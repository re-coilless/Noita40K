dofile_once( "mods/mnee/lib.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )

if( not( pen.is_inv_active())) then
	local hooman = GetUpdatedEntityID()
	local char_x, char_y = EntityGetTransform( hooman )

	local targeter_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "show_targets" )
	local show_targeter = true
	if( targeter_storage ~= nil ) then
		show_targeter = ComponentGetValue2( targeter_storage, "value_bool" )
	end
	
	if( show_targeter ) then
		local gui = GuiCreate()
		GuiStartFrame( gui )

		local enemies = EntityGetInRadiusWithTag( char_x, char_y, 250, "enemy" ) or {}
		if( #enemies > 0 ) then
			for i,enemy_id in ipairs( enemies ) do
				local e_x, e_y = EntityGetFirstHitboxCenter( enemy_id )
				local p_hitbox_offset = get_head_offset( hooman )
				local hidden = RaytracePlatforms( char_x, char_y + p_hitbox_offset, e_x, e_y )
				
				if( not( hidden )) then
					local e_hitbox_comp = EntityGetFirstComponentIncludingDisabled( enemy_id, "HitboxComponent" )
					local pic = "mods/Noita40K/files/pics/gui_gfx/mark_enemy.png"
					
					local e_hitbox_offset = -10
					if( e_hitbox_comp ~= nil ) then
						e_hitbox_offset = e_hitbox_offset + ComponentGetValue2( e_hitbox_comp, "aabb_min_y" )
					end
					local pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
					
					local pic_x, pic_y = world2gui( gui, e_x, e_y )
					pic_y = pic_y + e_hitbox_offset
					new_image( gui, 1, pic_x - pic_w/2, pic_y - pic_h/2, 0.01, pic, 1.5, 1.5 )
					
					local ui_mode_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "explorator_mode" )
					if( ui_mode_storage ~= nil ) then
						local explorator_mode = ComponentGetValue2( ui_mode_storage, "value_bool" )
						if( not( explorator_mode )) then
							local TL = math.ceil( get_enemy_threat( hooman, enemy_id, true ))
							
							if( TL < 50 ) then
								GuiColorSetForNextWidget( gui, 62/255, 0, 10/255, 1 )
							elseif( TL < 100 ) then
								GuiColorSetForNextWidget( gui, 136/255, 0, 21/255, 1 )
							elseif( TL < 500 ) then
								GuiColorSetForNextWidget( gui, 195/255, 3/255, 3/255, 1 )
							else
								GuiColorSetForNextWidget( gui, 1, 0, 0, 1 )
							end
							
							local str = K_number( TL, 0 )
							local t_w, t_h = GuiGetTextDimensions( gui, str, 1 )
							new_text( gui, pic_x - t_w/2.0, pic_y - ( t_h + 1 ), 0.01, str )
						end
					end
				end
			end
		end

		GuiDestroy( gui )
	end
end