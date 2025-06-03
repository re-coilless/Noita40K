dofile_once( "mods/mnee/lib.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )

if( ModSettingGetNextValue( "Noita40K.SHOW_PERKS" )) then
	if( not( pen.is_inv_active())) then
		local hooman = GetUpdatedEntityID()
		
		local clicked, r_clicked, hovered, pic_x, pic_y = 0, 0, 0, 0, 0
		local pic, pic_w, pic_h = 0, 0, 0
		local uid = 0
		
		local vigilance_mode = GameHasFlagRun( "PERK_GUI_EV_MODE" )
		local counter = 1
		
		local gui = GuiCreate()
		GuiStartFrame( gui )
		
		local magic_offset = MagicNumbersGetValue( "UI_QUICKBAR_OFFSET_X" )
		pic_x = 21 + magic_offset
		if( vigilance_mode ) then
			pic_x = pic_x + 20
		end
		pic_y = 41
		for i,perk_id in ipairs( organ_list ) do
			if( GameHasFlagRun( "PERK_PICKED_"..perk_id[1] )) then
				local perk_data = get_perk_with_actual_id( perk_id[1], perk_id[2] )
				
				pic = perk_data.ui_icon
				uid = new_image( gui, uid, pic_x, pic_y, -1, pic, 1, 1, 1, true )
				
				clicked, r_clicked, hovered = GuiGetPreviousWidgetInfo( gui )
				if( vigilance_mode ) then
					local ui_mode_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "explorator_mode" )
					hovered = not( ComponentGetValue2( ui_mode_storage, "value_bool" )) and hovered
				end
				if( hovered ) then				
					local info_w, info_h = GuiGetTextDimensions( gui, perk_data.ui_description, 1, 2 )
					
					pic_y = pic_y + 18
					uid = window_normal( gui, uid, pic_x, pic_y, 0, info_w - 5, 0, 1 )
					
					new_text( gui, pic_x + 20, pic_y + 2, -0.1, "["..string.gsub( string.upper( perk_data.ui_name ), " ", "_" ).."]" )
					new_text( gui, pic_x + 10, pic_y + 11, -0.1, perk_data.ui_description )
					
					if( vigilance_mode ) then
						pic_y = pic_y - 18
					else
						pic_y = pic_y + info_h
					end
				end
				
				if( vigilance_mode ) then
					pic_x = pic_x + 20
					if( counter == 3 ) then
						pic_x = pic_x + 1
					end
				else
					pic_y = pic_y + 18
				end
				
				counter = counter + 1
			end
		end
		GuiDestroy( gui )
	end
end