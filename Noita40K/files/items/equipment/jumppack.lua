if( index.M.is_updating ) then
	return function( inv_info, item_info, is_out )
		local hooman = index.D.player_id
		if( not( is_out )) then
			local path = "mods/Noita40K/files/items/equipment/jumppack_l_vis.xml"
			EntityAddChild( hooman, EntityLoad( path, unpack( index.D.player_xy )))
		else EntityKill( pen.get_child( hooman, "equipment_jumppack_l_vis" ) or 0 ) end
	end
else
	return function( info )
		local xD, xM = index.D, index.M

		local hooman = xD.player_id
		local vis_id = pen.get_child( hooman, "equipment_jumppack_l_vis" )
		if( not( pen.vld( vis_id, true ))) then return end

		local x, y, _, s_x, s_y = EntityGetTransform( hooman )
		local pack_x, pack_y = EntityGetTransform( vis_id )
		
		if(( pen.magic_storage( vis_id, "heat_cutoff", "value_float" ) or -1 ) > 0 ) then return end

		local heat = pen.magic_storage( vis_id, "heat", "value_float" ) or 0
		local max_heat = pen.magic_storage( vis_id, "heat_max", "value_float" )
		if( heat > max_heat ) then
			pen.play_sound({ "mods/Noita40K/files/40K.bank", "items/overheat_start" }, pack_x, pack_y )
			pen.magic_storage( vis_id, "heat_cutoff", "value_float", 0.25 )
		end

		local frame_num = GameGetFrameNum()
		local dmg_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
		local char_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterDataComponent" )
		local plat_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterPlatformingComponent" )

		local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
		local is_right = ComponentGetValue2( ctrl_comp, "mButtonDownRight" )
		local is_left = ComponentGetValue2( ctrl_comp, "mButtonDownLeft" )
		local will_fly = ComponentGetValue2( ctrl_comp, "mButtonDownUp" )
		will_fly = will_fly or ComponentGetValue2( ctrl_comp, "mButtonDownFly" )
		will_fly = will_fly or ComponentGetValue2( ctrl_comp, "mButtonDownJump" )

		pen.c.magic_particle_ids = pen.c.magic_particle_ids or {}
		local v_x, v_y = ComponentGetValue2( char_comp, "mVelocity" )
		local thrust = pen.magic_storage( info.id, "thrust", "value_float" )
		local is_firing = EntityGetIsAlive( pen.c.magic_particle_ids[ info.id ] or 0 )
		local d_ground = frame_num - ComponentGetValue2( char_comp, "mLastFrameOnGround" )
		if( not( is_firing ) and d_ground < 10 and v_y < -1.5*thrust ) then will_fly = false end
		
		local is_grounded = ComponentGetValue2( char_comp, "is_on_ground" )
		local may_hover = pen.magic_storage( info.id, "may_hover", "value_bool" )
		may_hover = may_hover and not( is_grounded or ComponentGetValue2( dmg_comp, "mAirAreWeInWater" ))
		local will_hover = not( will_fly ) and may_hover and ComponentGetValue2( ctrl_comp, "mButtonDownDown" )

		local may_dash = pen.magic_storage( info.id, "may_dash", "value_bool" )
		local will_dash = mnee.mnin( "bind", { "Noita40K", "jumppack" }, { pressed = true })
		will_dash = not( will_move ) and may_dash and will_dash

		local will_move = will_fly and ( is_left or is_right )
		local is_active = will_fly or will_move or will_dash or will_hover
		if( not( is_active )) then return end
		
		--efficiency decreases with higher char mass
		--increase efficiency with horizontal speed
		--hovering is three times more efficient
		--if is trying to enter hover but speed is over (gravity+10*thrust), activate afterburner that makes it so the speed reaches zero in 10 frames but proportionally reduces effiency

		--activate high-temp entity
		--if is on the ground and starting to fly, do ignition
		--dash is two times more powerful but four times less efficient
		local waste = 1 - ( pen.magic_storage( info.id, "efficiency", "value_float" ) or 0 )
		pen.magic_storage( vis_id, "heat", "value_float", heat + waste )
		
		local v_x, v_y = ComponentGetValue2( char_comp, "mVelocity" )
		local gravity = ComponentGetValue2( plat_comp, "pixel_gravity" )
		if( will_fly ) then v_y = math.max( -gravity/2, v_y - thrust ) end
		if( will_fly and will_move ) then v_x = v_x + ( is_left and -1 or 1 )*thrust/2.5 end
		if( is_grounded and ( will_fly or will_dash )) then v_y = v_y - gravity/4 end

		local char_tilt = 0
		if( will_fly ) then char_tilt = will_move and ( is_left and -10 or 10 ) or s_x*3 end
		if( char_tilt ~= 0 ) then EntitySetTransform( hooman, x, y, math.rad( char_tilt ), s_x, s_y ) end
		
		local aim_x, aim_y = ComponentGetValue2( ctrl_comp, "mAimingVector" ) --use mMousePos instead
		local angle = -math.atan2( aim_x, aim_y )
		
		-- local delta_vel_x = math.cos( angle )*JUMPPACK_SPEED
		-- local delta_vel_y = math.sin( angle )*JUMPPACK_SPEED

		
		-- GamePlaySound( "mods/Noita40K/files/40K.bank", "player/jumppack/ignition", char_x, char_y )

		-- if( hover_combo and EntityHasTag( emitter, "hover_enabled" ) and GameGetFrameNum()%3 == 0 ) then
			-- local v_x, v_y = ComponentGetValue2( char_comp, "mVelocity" )
			-- local final_v_x, final_v_y = v_x, math.min( -gravity*0.01, v_y )
			
			-- local a_down = ComponentGetValue2( ctrl_comp, "mButtonDownLeft" )
			-- if( a_down ) then
				-- final_v_x = final_v_x - JUMPPACK_SPEED*0.6
			-- end
			-- local d_down = ComponentGetValue2( ctrl_comp, "mButtonDownRight" )
			-- if( d_down ) then
				-- final_v_x = final_v_x + JUMPPACK_SPEED*0.6
			-- end
			
			-- ComponentSetValueVector2( char_comp, "mVelocity", final_v_x, final_v_y )
			-- ComponentSetValue2( char_comp, "mFlyingTimeLeft", fuel - JUMPPACK_BURNING_RATE/6 )
			-- GameEntityPlaySoundLoop( hooman, "sound_jetpack", 1.0 )
			
			-- if( not( is_hovering )) then
				-- EntitySetComponentsWithTagEnabled( hooman, "jetpack", true )
				-- ComponentSetValue2( storage_hover, "value_bool", true )
			-- end_x
		-- end

		ComponentSetValue2( char_comp, "mVelocity", v_x, v_y )
		pen.play_sound({ "mods/Noita40K/files/40K.bank", "items/jumppack/loop", true }, pack_x, pack_y )
		
		--jet to the left looks different from the one to the right
		--indicate the heat level with sound (dynamically change pitch) and color
		local jet_angle = -pen.sgn( aim_x )*math.rad( 145 )
		pen.magic_particles( pack_x, pack_y + 5, jet_angle, {
			uid = info.id, z_index = 5, render_back = true,
			fading = 7, additive = true, count = { 5, 10 },
			
			scale = { 0.5, 0.75 },
			alpha = 1, color = { 230, 88, 0 },
			alpha_end = 0.1, color_end = { 59, 42, 32 },
			
			p_range = { -5, -2, 5, 0 },
			global_velocity = { 0, -150 }, velocity = { 0, -100 },
		})
		pen.magic_particles( pack_x + v_x/60, pack_y + 7 + v_y/60, jet_angle, {
			uid = info.id.."_alt", z_index = 5, render_back = true,
			fading = 10, additive = true, count = { 3, 7 },
			
			scale = { 0.75, 1 },
			alpha = 1, color = { 230, 88, 0 },
			alpha_end = 0.1, color_end = { 59, 42, 32 },
			
			p_range = { -4, -4, 4, 0 },
			global_velocity = { 0, -150 }, velocity = { 0, -100 },
		})
	end
end