if( index.M.is_updating ) then
	return function( inv_info, item_info, is_out )
		local hooman = index.D.player_id
		local power = pen.magic_storage( item_info.id, "power", "value_int" )

		if( not( is_out )) then
			pen.magic_storage( hooman, "reactor_load", "value_int",
				pen.magic_storage( hooman, "reactor_load", "value_int", nil, 1 ) - power )
			local path = "mods/n40k/files/items/equipment/servoskull_e/body.xml"
			EntityAddChild( hooman, EntityLoad( path, unpack( index.D.player_xy )))
		else
			pen.magic_storage( hooman, "reactor_load", "value_int",
				pen.magic_storage( hooman, "reactor_load", "value_int", nil, 1 ) + power )
			EntityKill( pen.get_child( hooman, "equipment_servoskull_e_vis" ) or 0 )
		end
	end
else
	return function( info )
		local xD, xM = index.D, index.M

		local hooman = xD.player_id
		local vis_id = pen.get_child( hooman, "equipment_servoskull_e_vis" )
		if( not( pen.vld( vis_id, true ))) then return end

		local _,_,_, s_x, s_y = EntityGetTransform( hooman )
		local skull_x, skull_y = EntityGetTransform( vis_id )
		local t_x, t_y = pen.get_creature_centre( hooman )
		
		--support for multiple skulls
		--tilt based on flight direction and speed
		--add slight fluctuation to the desired pos (through frame num)
		--autovalidate the velrets (move them when is flipped + make sure they exist); port this out as penman func
		
		skull_x = pen.estimate( "", { t_x - s_x*7, skull_x }, { "wgt", 0.4 })
		skull_y = pen.estimate( "", { t_y - 7, skull_y }, { "wgt", 0.4 })
		EntitySetTransform( vis_id, skull_x, skull_y, 0, pen.sgn( t_x - skull_x ), 1 )

		local charge = pen.magic_storage( hooman, "reactor_charge", "value_float", nil, 0 )
		if( charge < pen.magic_storage( hooman, "reactor_target", "value_float", nil, 100 )) then
			pen.magic_storage( hooman, "reactor_charge", "value_float", charge + 0.2 )
		end
	end
end