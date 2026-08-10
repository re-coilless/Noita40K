if( index.M.is_updating ) then
	return function( inv_info, item_info, is_out )
		local hooman = index.D.player_id
		if( not( is_out )) then
			--add 200 to max reactor load and increase target charge by 100
			--store heat on the item itself once taken off and then apply back
			EntityAddChild( hooman, EntityLoad( pen.magic_storage( item_info.id, "vis_path", "value_string" ), unpack( index.D.player_xy )))
		else EntityKill( pen.get_child( hooman, pen.magic_storage( item_info.id, "vis_tag", "value_string" )) or 0 ) end
	end
else
	return function( info )
		local xD, xM = index.D, index.M

		--do beam breaking by checking for refractor callback inside pen.raytrace_entities if beam is gonna hit the player

		local hooman = xD.player_id
		local vis_id = pen.get_child( hooman, pen.magic_storage( info.id, "vis_tag", "value_string" ))
		if( not( pen.vld( vis_id, true ))) then return end
		local x, y = EntityGetTransform( vis_id )
		
		pen.c.refractor_sfx = pen.c.refractor_sfx or {}
		pen.c.refractor_sfx[ vis_id ] = pen.c.refractor_sfx[ vis_id ] or false
		local charge = pen.magic_storage( hooman, "reactor_charge", "value_float", nil, 0 )
		if( charge < 0 ) then
			if( not( pen.c.refractor_sfx[ vis_id ])) then
				GamePlaySound( "mods/n40k/files/n40k.bank", "items/refractor/off", x, y )
				pen.c.refractor_sfx[ vis_id ] = true
			end
			
			--set_shader( hooman, "refractor_effect" )
			return
		elseif( pen.c.refractor_sfx[ vis_id ]) then
			GamePlaySound( "mods/n40k/files/n40k.bank", "items/refractor/on", x, y )
			pen.c.refractor_sfx[ vis_id ] = false
		end
		
		local is_hit = false
		local radius = pen.magic_storage( info.id, "range", "value_float" )
		local efficiency = 1 - pen.magic_storage( info.id, "efficiency", "value_float" )
		pen.t.loop( EntityGetInRadiusWithTag( x, y, radius, "projectile" ), function( i, proj_id )
			local proj_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" )
			if( hooman == ComponentGetValue2( proj_comp, "mWhoShot" )) then return end
			
			local p_x, p_y = EntityGetTransform( proj_id )
			if( RaytracePlatforms( x, y, p_x, p_y )) then return end
			local damage = 25*math.abs( ComponentGetValue2( proj_comp, "damage" ))/2
			if( damage > charge ) then return end
			EntityKill( proj_id )
			is_hit = true

			--better emitter
			GameCreateParticle( "plasma_unstable",
				p_x, p_y, 5*math.ceil( 10*( damage + 1 )/29 ), 150, 150, true )
			GamePlaySound( "mods/n40k/files/n40k.bank", "items/refractor/refraction", p_x, p_y )
			
			local heat = pen.magic_storage( vis_id, "heat", "value_float" ) or 0
			pen.magic_storage( vis_id, "heat", "value_float", heat + damage*efficiency )
			pen.magic_storage( hooman, "reactor_charge", "value_float", charge - damage )
		end)
		
		local w, h = pen.get_screen_data()
		local shader_x, shader_y = pen.world2gui( x, y )
		shader_x, shader_y = ( shader_x )/w, ( h - shader_y )/h
		pen.set_uniform( "refractor_effect", shader_x, shader_y, is_hit and 50 or 25, is_hit and 3.5 or 1 )
	end
end