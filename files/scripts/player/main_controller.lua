dofile_once( "mods/mnee/lib.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )

local hooman = GetUpdatedEntityID()
local char_x, char_y = EntityGetTransform( hooman )

local frame_num = GameGetFrameNum()

local quest_info_raw = ModSettingGetNextValue( "Noita40K.QUEST_INFO" )
local quest_info = {}
if( quest_info_raw ~= "|" ) then
	quest_info = DD_extractor( quest_info_raw, true )
end

local note_info_raw = ModSettingGetNextValue( "Noita40K.NOTE_INFO" )
local note_info = {}
if( note_info_raw ~= "|" ) then
	note_info = DD_extractor( note_info_raw, true )
end

local tutorial_mode = ModSettingGetNextValue( "Noita40K.UI_MODE" ) == 1

if( gui == nil ) then
	gui = GuiCreate()
end
GuiStartFrame( gui )

local w, h = GuiGetScreenDimensions( gui )
local clicked, r_clicked, hovered, pic_x, pic_y, pic_z = 0, 0, 0, 0, 0, 0
local pic, pic_w, pic_h = 0, 0, 0
local uid = 0
pic_z = -10

local note_cooldown_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "cooldown_note" )
local note_cooldown = ComponentGetValue2( note_cooldown_storage, "value_int" )
local panel_state_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "qm_panel_state" )
local panel_state = ComponentGetValue2( panel_state_storage, "value_int" )

if( pen.is_inv_active()) then
	local menu_state_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "mm_is_open" )
	local quest_menu_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "qm_is_open" )
	local page_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "mm_page_number" )
	local menu_state = ComponentGetValue2( menu_state_storage, "value_bool" )
	local quest_state = ComponentGetValue2( quest_menu_storage, "value_bool" )
	local page_number = ComponentGetValue2( page_storage, "value_int" )
	
	pages = 
	{
		{
			title = "mods/Noita40K/files/pics/gui_gfx/main_menu_title_loadout.png",
			pic = "mods/Noita40K/files/pics/gui_gfx/main_menu_sign_loadout.png",
			content = function( gui, uid, pic_x, pic_y, pic_z )
				function get_gun_nums( gun_ids )
					local gun_nums = {}
					
					for i,gun_id in ipairs( gun_ids ) do
						for e,gun in ipairs( gun_info ) do
							if gun.id == gun_id then
								table.insert( gun_nums, e )
								break
							end
						end
					end
					
					return gun_nums
				end
				
				function get_gun_ids( gun_nums )
					local gun_ids = {}
					
					for i,gun_num in ipairs( gun_nums ) do
						table.insert( gun_ids, gun_info[gun_num].id )
					end
					
					return gun_ids
				end
				
				local loadout = get_gun_nums( D_extractor( ModSettingGetNextValue( "Noita40K.CUSTOM_LOADOUT" ), true ))
			
				if( loadout_current == nil ) then
					loadout_current = 0
				end
				if( loadout_temp == nil ) then
					loadout_temp = loadout
				end
				
				pic_x = pic_x + 1
				pic_y = pic_y + 28
				page_loadout = page_loadout or 1
				local counter = 9*page_loadout - 8
				local selected = -1
				local fancy_offset = { 0, 0, }
				for i = counter,9*page_loadout do
					for e = ( 4*i - 3 ),4*i do
						while( counter <= #gun_info and gun_info[counter].unlocked == nil ) do
							counter = counter + 1
						end
						
						if( counter <= #gun_info ) then
							uid = new_image( gui, uid, pic_x + fancy_offset[1], pic_y + fancy_offset[2], pic_z, gun_info[counter].icon, 1, 1, 1, true )
							clicked, r_clicked, hovered = GuiGetPreviousWidgetInfo( gui )
							uid = new_tutorial_tooltip( gui, uid, gun_info[counter].unlocked and "LMB this to select the gun. / Then, LMB the slot on the right to modify the loadout. / Selected guns are highlighted with red. /" or "Unlock to continue." )
							if( hovered ) then
								uid = new_image( gui, uid, pic_x + fancy_offset[1] - 1, pic_y + fancy_offset[2] - 1, pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/selection_hover.png" )
								selected = counter
							end
							if( gun_info[counter].unlocked ) then
								if( clicked ) then
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
									loadout_current = counter
								end
							else
								uid = new_image( gui, uid, pic_x + fancy_offset[1], pic_y + fancy_offset[2], pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png" )
							end
							
							if( counter == loadout_current ) then
								uid = new_image( gui, uid, pic_x + fancy_offset[1] + 1, pic_y + fancy_offset[2] + 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 23, 23 )
							end
						else
							uid = new_image( gui, uid, pic_x + fancy_offset[1], pic_y + fancy_offset[2], pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png", 1, 1, 1, true )
							clicked, r_clicked, hovered = GuiGetPreviousWidgetInfo( gui )
							if( hovered ) then
								uid = new_image( gui, uid, pic_x + fancy_offset[1] - 1, pic_y + fancy_offset[2] - 1, pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/selection_hover.png" )
								selected = -1
							end
						end
						
						counter = counter + 1
						
						fancy_offset[1] = fancy_offset[1] + 30
					end
					fancy_offset[2] = fancy_offset[2] + 30
					fancy_offset[1] = 0
				end
				
				pic_y = pic_y - 28
				uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 172, 20 )
				local txt = ""
				if( selected > 0 ) then
					txt = gun_info[selected].name
				else
					txt = "Coming_Soon"
				end
				uid = new_high_gothic( gui, uid, pic_x + 5, pic_y + 4, pic_z, txt )
				
				pic_x = pic_x + 127
				pic_y = pic_y + 30
				for i = 1,4 do
					uid = window_inner( gui, uid, pic_x, pic_y + ( i - 1 )*30, pic_z + 0.01, 17, 17 )
					uid = new_high_gothic( gui, uid, pic_x + 7, pic_y + 2 + ( i - 1 )*30, pic_z, tostring( i ))
				end
				
				pic_x = pic_x + 24
				pic_y = pic_y - 2
				for i = 1,4 do
					uid = new_image( gui, uid, pic_x - 1, pic_y + ( i - 1 )*30 - 1, pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/selection_special.png" )
					uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y + ( i - 1 )*30, pic_z, gun_info[loadout_temp[i]].icon )
					uid = new_tutorial_tooltip( gui, uid, "LMB this with gun selected to modify the loadout. / Don't forget to confirm the changes with the button below. / Confirmed guns are highlighted with red. /" )
					if( clicked and loadout_current > 0 ) then
						GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
						loadout_temp[i] = loadout_current
						loadout_current = 0
					end
					
					if( loadout[i] == loadout_temp[i] ) then
						uid = new_image( gui, uid, pic_x + 1, pic_y + ( i - 1 )*30 + 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 23, 23 )
					end
				end
				
				uid, clicked, r_clicked = new_button( gui, uid, pic_x + 2, pic_y + 117, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_done.png" )
				uid = new_tutorial_tooltip( gui, uid, "LMB to confirm." )
				if( clicked ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					ModSettingSetNextValue( "Noita40K.CUSTOM_LOADOUT", D_packer( get_gun_ids( loadout_temp )), false )
				end
				
				pic_x = pic_x - 30
				pic_y = pic_y + 120
				uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 21, 21 )
				if( selected > 0 ) then
					uid = new_image( gui, uid, pic_x + 4.5, pic_y + 4.5, pic_z, gun_info[selected].ammo[1] )
				end
				
				pic_y = pic_y + 30
				uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 51, 21 )
				if( selected > 0 ) then
					pic = gun_info[selected].pic
					pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
					uid = new_image( gui, uid, pic_x + 27.5 - pic_w/2, pic_y + 12.5 - pic_h/2, pic_z, pic )
				end
				
				pic_y = pic_y + 32
				uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_previous.png" )
				if( clicked and #gun_info > 36 ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					page_loadout = page_loadout - 1
					if( page_loadout < 1 ) then
						page_loadout = math.ceil( #gun_info/36.0 )
					end
				end
				uid, clicked, r_clicked = new_button( gui, uid, pic_x + 34, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_next.png" )
				if( clicked and #gun_info > 36 ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					page_loadout = page_loadout + 1
					if( page_loadout > math.ceil( #gun_info/36.0 )) then
						page_loadout = 1
					end
				end
				
				pic_y = pic_y + 28
				uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 51, 36 )
				new_text( gui, pic_x + 3, pic_y + 1, pic_z, paragrapher( nil, "Failure is temporary, Triumph is forever.", 51, 36, 3.9 ))
				uid = new_tutorial_tooltip( gui, uid, "Only the classes with at least one triumph are allowed to be customized." )
				
				return uid
			end,
		},
		{
			title = "mods/Noita40K/files/pics/gui_gfx/main_menu_title_classes.png",
			pic = "mods/Noita40K/files/pics/gui_gfx/main_menu_sign_classes.png",
			content = function( gui, uid, pic_x, pic_y, pic_z )
				local counter = 1
				local stats = DD_extractor( ModSettingGetNextValue( "Noita40K.CLASS_STATS" ))
				local current = { ModSettingGetNextValue( "Noita40K.CURRENT_CLASS" ), ModSettingGetNextValue( "Noita40K.CURRENT_SKIN" ), }
				
				skin_pos = skin_pos or 1
				function skin_scroller( gui, uid, pic_x, pic_y, pic_z, class )
					if( #class.skins == 0 ) then
						return uid
					end
					
					uid = window_normal( gui, uid, pic_x, pic_y, pic_z + 0.1, 17, 270 )
					
					pic_x = pic_x + 8
					pic_y = pic_y + 12
					uid, clicked, r_clicked = new_button( gui, uid, pic_x + 2, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_up.png" )
					uid = new_tutorial_tooltip( gui, uid, "LMB to scroll singulars. / RMB to scroll pages. /" )
					if( #class.skins > 8 ) then
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							skin_pos = skin_pos - 1
							if( skin_pos < 1 ) then
								skin_pos = #class.skins
							end
						end
						if( r_clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							skin_pos = skin_pos - 8
							if( skin_pos < 1 ) then
								skin_pos = #class.skins + skin_pos
							end
						end
					end
					pic_y = pic_y + 21
					local list_num = skin_pos
					for i = 1,8 do
						while( list_num <= #class.skins and class.skins[list_num].unlocked == nil ) do
							list_num = list_num + 1
							if( list_num > #class.skins ) then
								list_num = 1
							end
						end
						
						if( current[2] == list_num ) then
							uid = new_image( gui, uid, pic_x + 1, pic_y + ( i - 1 )*30 + 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 23, 23 )
						end
						if(( selected_skin or 0 ) == list_num ) then
							uid = new_image( gui, uid, pic_x - 1, pic_y + ( i - 1 )*30 - 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/icons/menu/selection_special.png" )
						end
						uid = new_image( gui, uid, pic_x, pic_y + ( i - 1 )*30, pic_z, class.skins[list_num].icon, 1, 1, 1, true )
						clicked, r_clicked, hovered = GuiGetPreviousWidgetInfo( gui )
						if( tutorial_mode ) then
							uid = new_tutorial_tooltip( gui, uid, class.skins[list_num].unlocked and "LMB to access the info tab. / RMB to select the subclass. / Changes will be applied with the new game. /" or ( class.skins[list_num].unlock_case or "Unlock to continue" ))
						else
							uid = new_tooltip( gui, uid, string.gsub( class.skins[list_num].name, "_", " " ))
						end
						if( hovered ) then
							uid = new_image( gui, uid, pic_x - 1, pic_y + ( i - 1 )*30 - 1, pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/selection_hover.png" )
						end
						if( class.skins[list_num].unlocked ) then
							if( clicked ) then
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
								selected_skin = list_num
								perk_page_skin = nil
							end
							if( r_clicked ) then
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
								ModSettingSetNextValue( "Noita40K.CURRENT_SKIN", list_num, false )
								perk_page_class = nil
							end
						else
							uid = new_image( gui, uid, pic_x, pic_y + ( i - 1 )*30, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png" )
						end
						
						list_num = list_num + 1
						if( list_num > #class.skins ) then
							if( #class.skins > 8 ) then
								list_num = 1
							else
								break
							end
						end
					end
					pic_y = pic_y + 239
					uid, clicked, r_clicked = new_button( gui, uid, pic_x + 2, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_down.png" )
					uid = new_tutorial_tooltip( gui, uid, "LMB to scroll singulars. / RMB to scroll pages. /" )
					if( #class.skins > 8 ) then
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							skin_pos = skin_pos + 1
							if( skin_pos > #class.skins ) then
								skin_pos = 1
							end
						end
						if( r_clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							skin_pos = skin_pos + 8
							if( skin_pos > #class.skins ) then
								skin_pos = skin_pos - #class.skins
							end
						end
					end
					
					return uid
				end
				
				uid = skin_scroller( gui, uid, pic_x - 61, pic_y - 12, pic_z, class_info[current[1]] )
				
				if( selected_skin == nil ) then
					local selected_class = current[1]
					for i = 1,5 do
						for e = 1,3 do
							if( #class_info[counter].skins > 0 ) then
								if( counter == current[1] ) then
									uid = new_image( gui, uid, pic_x + ( e - 1 )*30 + 1, pic_y + ( i - 1 )*30 + 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 23, 23 )
									pic = class_info[counter].skins[current[2]].icon
								else
									pic = class_info[counter].skins[class_info[counter].default_skin].icon
								end
							else
								if( counter == current[1] ) then
									uid = new_image( gui, uid, pic_x + ( e - 1 )*30 + 1, pic_y + ( i - 1 )*30 + 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 23, 23 )
								end
								pic = class_info[counter].special_icon
							end
							uid = new_image( gui, uid, pic_x + ( e - 1 )*30, pic_y + ( i - 1 )*30, pic_z, pic, 1, 1, 1, true )
							clicked, r_clicked, hovered = GuiGetPreviousWidgetInfo( gui )
							if( tutorial_mode ) then
								uid = new_tutorial_tooltip( gui, uid, stats[counter][1] == 1 and "Hover to see the info. / LMB to select the class and access subclass menu. / Changes will be applied with the new game. /" or "Unlock to continue. / (Check the case below) /" )
							else
								uid = new_tooltip( gui, uid, string.gsub( class_info[counter].class_name, "_", " " ))
							end
							if( hovered ) then
								uid = new_image( gui, uid, pic_x + ( e - 1 )*30 - 1, pic_y + ( i - 1 )*30 - 1, pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/selection_hover.png" )
								selected_class = counter
							end
							if( stats[counter][1] == 1 ) then
								if( clicked and #class_info[counter].skins > 0 ) then
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
									ModSettingSetNextValue( "Noita40K.CURRENT_CLASS", counter, false )
									ModSettingSetNextValue( "Noita40K.CURRENT_SKIN", class_info[counter].default_skin, false )
									perk_page_class = nil
									skin_pos = nil
								end
							else
								uid = new_image( gui, uid, pic_x + ( e - 1 )*30, pic_y + ( i - 1 )*30, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png" )
							end
							
							counter = counter + 1
						end
					end
					
					pic_x = pic_x + 88
					local skin_num = current[2]
					if( selected_class ~= current[1] ) then
						skin_num = class_info[selected_class].default_skin
					end
					uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 84, 51 )
					if( #class_info[selected_class].skins > 0 ) then
						pic = class_info[selected_class].skins[skin_num].main
						if( pic ~= nil ) then
							pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1.5 )
							uid = new_image( gui, uid, pic_x + 42 - pic_w/2, pic_y + 50 - pic_h, pic_z, pic, 1.5, 1.5 )
						end
					end
					
					pic_y = pic_y + 60
					if( #( class_info[selected_class].skins or {} ) > 0 and class_info[selected_class].skins[skin_num].guns ~= nil ) then
						local temp = pic_y + 3
						counter = 0
						for i = 1,#class_info[selected_class].skins[skin_num].guns do
							pic = get_gun_with_id( class_info[selected_class].skins[skin_num].guns[i] ).pic
							if( pic ~= nil ) then
								pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
								counter = counter + pic_h + 1
								uid = new_image( gui, uid, pic_x + 3, temp, pic_z, pic, 1, 1, 1, true )
								uid = new_tooltip( gui, uid, string.gsub( get_gun_with_id( class_info[selected_class].skins[skin_num].guns[i] ).name, "_", " " ))
								temp = temp + pic_h + 2
							end
						end
					elseif( class_info[selected_class].default_guns ~= nil ) then
						local temp = pic_y + 3
						counter = 0
						for i = 1,#class_info[selected_class].default_guns do
							pic = get_gun_with_id( class_info[selected_class].default_guns[i] ).pic
							if( pic ~= nil ) then
								pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
								counter = counter + pic_h + 1
								uid = new_image( gui, uid, pic_x + 3, temp, pic_z, pic, 1, 1, 1, true )
								uid = new_tooltip( gui, uid, string.gsub( get_gun_with_id( class_info[selected_class].default_guns[i] ).name, "_", " " ))
								temp = temp + pic_h + 2
							end
						end
					else
						counter = 2
					end
					uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 48, counter + 4 )
					
					perk_page_class = perk_page_class or 1
					function perk_scroller_vertical( gui, uid, pic_x, pic_y, pic_z, visual_perks )
						local p_x = pic_x
						local p_y = pic_y
						for i = ( 8*perk_page_class - 7 ), 8*perk_page_class do
							if( i > #visual_perks ) then
								break
							end
							
							local perk_data = get_perk_with_actual_id( visual_perks[i][1], visual_perks[i][2] )
							uid = new_image( gui, uid, p_x, p_y, pic_z, perk_data.perk_icon, 1, 1, 1, true )
							uid = new_tooltip( gui, uid, perk_data.ui_name )
							
							if( i%2 == 0 ) then
								p_x = p_x - 18
								p_y = p_y + 18
							else
								p_x = p_x + 18
							end
						end
						
						pic_y = pic_y + 72
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_previous_perk.png" )
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							perk_page_class = perk_page_class + 1
							if( perk_page_class > math.ceil( #visual_perks/8.0 )) then
								perk_page_class = 1
							end
						end
						
						pic_x = pic_x + 18
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_next_perk.png" )
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							perk_page_class = perk_page_class - 1
							if( perk_page_class < 1 ) then
								perk_page_class = math.ceil( #visual_perks/8.0 )
							end
						end
						
						return uid
					end
					
					pic_x = pic_x + 54
					local visual_perks = {}
					if( #( class_info[selected_class].skins or {} ) > 0 ) then
						if( #( class_info[selected_class].skins[skin_num].perks or {} ) > 0 ) then
							if( not( class_info[selected_class].skins[skin_num].perks[1] )) then
								for i,line in ipairs( class_info[selected_class].visual ) do
									table.insert( visual_perks, line )
								end
							end
							for i,line in ipairs( class_info[selected_class].skins[skin_num].perks[2] ) do
								table.insert( visual_perks, { line[1], line[3], })
							end
						end
					elseif( #( class_info[selected_class].visual or {} ) > 0 ) then
						for i,line in ipairs( class_info[selected_class].visual ) do
							table.insert( visual_perks, line )
						end
					end
					if( #visual_perks > 0 ) then
						uid = perk_scroller_vertical( gui, uid, pic_x, pic_y, pic_z, visual_perks )
					end
					
					pic_x = pic_x - 142
					pic_y = pic_y + 90
					uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 172, 20 )
					uid = new_high_gothic( gui, uid, pic_x + 5, pic_y + 4, pic_z, class_info[selected_class].class_name )
					
					pic_y = pic_y + 28
					counter = h - ( pic_y + 24 )
					uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 172, counter )
					local txt = ""
					if( stats[selected_class][1] == 1 and #class_info[selected_class].skins > 0 ) then
						txt = class_info[selected_class].class_desc
					else
						txt = class_info[selected_class].unlock_case
					end
					new_text( gui, pic_x + 3, pic_y + 1, pic_z, paragrapher( nil, txt, 172, 96, 4 ))
					
					if( stats[selected_class][1] == 1 ) then
						pic_x = pic_x + 2
						pic_y = pic_y + counter + 6
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 134, 8 )
						txt = "Failures: "..stats[selected_class][2].."  |  Triumphs: "..stats[selected_class][3]
						local t_w, t_h = GuiGetTextDimensions( gui, txt, 1 )
						new_text( gui, pic_x + 67 - t_w/2, pic_y + 1, pic_z, txt )
					end
				else
					uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 153, 20 )
					uid = new_high_gothic( gui, uid, pic_x + 5, pic_y + 4, pic_z, class_info[current[1]].skins[selected_skin].name )
					
					local gonna_close = false
					uid, clicked, r_clicked = new_button( gui, uid, pic_x + 160, pic_y + 4, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_close_skin.png" )
					if( clicked ) then
						GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
						gonna_close = true
					end
					
					pic_y = pic_y + 29
					uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 116, 116 )
					pic = class_info[current[1]].skins[selected_skin].main
					if( pic ~= nil ) then
						pic_w, pic_h = GuiGetImageDimensions( gui, pic, 4 )
						uid = new_image( gui, uid, pic_x + 59.5 - pic_w/2, pic_y + 120 - pic_h, pic_z, pic, 4, 4 )
					end
					
					perk_page_skin = perk_page_skin or 1
					function perk_scroller_horizontal( gui, uid, pic_x, pic_y, pic_z, visual_perks )
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/button_side_large.png" )
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							perk_page_skin = perk_page_skin - 1
							if( perk_page_skin < 1 ) then
								perk_page_skin = math.ceil( #visual_perks/4.0 )
							end
						end
						
						local p_x = pic_x + 8
						local p_y = pic_y
						for i = ( 4*perk_page_skin - 3 ), 4*perk_page_skin do
							if( i > #visual_perks ) then
								break
							end
							
							local perk_data = get_perk_with_actual_id( visual_perks[i][1], visual_perks[i][2] )
							uid = new_image( gui, uid, p_x, p_y, pic_z, perk_data.perk_icon, 1, 1, 1, true )
							uid = new_tooltip( gui, uid, perk_data.ui_name )
							
							if( i%2 == 0 ) then
								p_x = p_x - 19
								p_y = p_y + 19
							else
								p_x = p_x + 19
							end
						end
						
						uid, clicked, r_clicked = new_button( gui, uid, pic_x + 46, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/button_side_large.png" )
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							perk_page_skin = perk_page_skin + 1
							if( perk_page_skin > math.ceil( #visual_perks/4.0 )) then
								perk_page_skin = 1
							end
						end
						
						return uid
					end
					
					local gun_table_offset = -38
					pic_x = pic_x + 124
					if( #( class_info[current[1]].skins[selected_skin].perks or {} ) > 0 ) then
						local visual_perks = {}
						if( not( class_info[current[1]].skins[selected_skin].perks[1] )) then
							for i,line in ipairs(class_info[current[1]].visual) do
								table.insert( visual_perks, line )
							end
						end
						for i,line in ipairs(class_info[current[1]].skins[selected_skin].perks[2]) do
							table.insert( visual_perks, { line[1], line[3], })
						end
						uid = perk_scroller_horizontal( gui, uid, pic_x, pic_y, pic_z, visual_perks )
						gun_table_offset = 0
					end
					
					pic_x = pic_x - 1
					pic_y = pic_y + 38
					local temp = pic_y + gun_table_offset + 3
					if( class_info[current[1]].skins[selected_skin].guns ~= nil ) then
						counter = 0
						for i = 1,#class_info[current[1]].skins[selected_skin].guns do
							pic = get_gun_with_id( class_info[current[1]].skins[selected_skin].guns[i]).pic
							if( pic ~= nil ) then
								pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
								counter = counter + pic_h + 1
								uid = new_image( gui, uid, pic_x + 3, temp, pic_z, pic, 1, 1, 1, true )
								uid = new_tooltip( gui, uid, string.gsub( get_gun_with_id( class_info[current[1]].skins[selected_skin].guns[i]).name, "_", " " ))
								temp = temp + pic_h + 2
							end
						end
					elseif( class_info[current[1]].default_guns ~= nil ) then
						counter = 0
						for i = 1,#class_info[current[1]].default_guns do
							pic = get_gun_with_id( class_info[current[1]].default_guns[i]).pic
							if( pic ~= nil ) then
								pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
								counter = counter + pic_h + 1
								uid = new_image( gui, uid, pic_x + 3, temp, pic_z, pic, 1, 1, 1, true )
								uid = new_tooltip( gui, uid, string.gsub( get_gun_with_id( class_info[current[1]].default_guns[i]).name, "_", " " ))
								temp = temp + pic_h + 2
							end
						end
					else
						counter = 2
					end
					uid = window_inner( gui, uid, pic_x, pic_y + gun_table_offset, pic_z + 0.01, 49, counter + 4 )
					
					pic_x = pic_x - 123
					pic_y = pic_y + 87
					uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 172, 120 )
					local txt = ""
					if( class_info[current[1]].skins[selected_skin].custom_desc == nil ) then
						txt = class_info[current[1]].class_desc
					else
						txt = class_info[current[1]].skins[selected_skin].custom_desc
					end
					new_text( gui, pic_x + 3, pic_y + 1, pic_z, paragrapher( nil, txt, 172, 120, 4 ))
					
					pic_x = pic_x + 2
					pic_y = pic_y + 126
					uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 134, 8 )
					txt = class_info[current[1]].skins[selected_skin].author
					if( txt ~= nil ) then
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, "By "..txt )
					end
					
					if( gonna_close ) then
						selected_skin = nil
					end
				end
				
				return uid
			end,
		},
		{
			title = "mods/Noita40K/files/pics/gui_gfx/main_menu_title_codex.png",
			pic = "mods/Noita40K/files/pics/gui_gfx/main_menu_sign_codex.png",
			content = function( gui, uid, pic_x, pic_y, pic_z )
				codex_page = codex_page or 1
				codex_list_pos = codex_list_pos or 1
				current_entry = current_entry or 1
				
				function entry_scroller( gui, uid, pic_x, pic_y, pic_z, entries, add_frame )
					add_frame = add_frame or false
				
					uid, clicked, r_clicked = new_button( gui, uid, pic_x + 2, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_up.png" )
					uid = new_tutorial_tooltip( gui, uid, "LMB to scroll singulars. / RMB to scroll pages. /" )
					if( #entries > 7 ) then
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							codex_list_pos = codex_list_pos - 1
							if( codex_list_pos < 1 ) then
								codex_list_pos = #entries
							end
						end
						if( r_clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							codex_list_pos = codex_list_pos - 7
							if( codex_list_pos < 1 ) then
								codex_list_pos = #entries + codex_list_pos
							end
						end
					end
					pic_y = pic_y + 21
					local list_num = codex_list_pos
					for i = 1,7 do
						while( list_num <= #entries and entries[list_num].unlocked == nil ) do
							list_num = list_num + 1
							if( list_num > #entries ) then
								list_num = 1
							end
						end
						
						if( list_num <= #entries ) then
							if( current_entry == list_num ) then
								uid = new_image( gui, uid, pic_x + 1, pic_y + ( i - 1 )*30 + 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 23, 23 )
							end
							local pic = entries[list_num].icon or entries[list_num].info.icon or entries[list_num].info.perk_icon
							if( add_frame ) then
								pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
								uid = new_image( gui, uid, pic_x + ( 25 - pic_w )/2, pic_y + ( i - 1 )*30 + ( 25 - pic_h )/2, pic_z - 0.005, pic )
								uid = new_image( gui, uid, pic_x, pic_y + ( i - 1 )*30, pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon.png", 1, 1, 1, true )
							else
								uid = new_image( gui, uid, pic_x, pic_y + ( i - 1 )*30, pic_z, pic, 1, 1, 1, true )
							end
							clicked, r_clicked, hovered = GuiGetPreviousWidgetInfo( gui )
							uid = new_tooltip( gui, uid, entries[list_num].unlocked and string.gsub( string.gsub( entries[list_num].name, "%[", "" ), "%]", "" ) or "Unlock to continue." )
							if( hovered ) then
								uid = new_image( gui, uid, pic_x - 1, pic_y + ( i - 1 )*30 - 1, pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/selection_hover.png" )
							end
							if( entries[list_num].unlocked ) then
								if( clicked ) then
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
									current_entry = list_num
								end
							else
								uid = new_image( gui, uid, pic_x, pic_y + ( i - 1 )*30, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png" )
							end
						end
						
						list_num = list_num + 1
						if( list_num > #entries ) then
							if( #entries > 7 ) then
								list_num = 1
							else
								break
							end
						end
					end
					pic_y = pic_y + 209
					uid, clicked, r_clicked = new_button( gui, uid, pic_x + 2, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_down.png" )
					uid = new_tutorial_tooltip( gui, uid, "LMB to scroll singulars. / RMB to scroll pages. /" )
					if( #entries > 7 ) then
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							codex_list_pos = codex_list_pos + 1
							if( codex_list_pos > #entries ) then
								codex_list_pos = 1
							end
						end
						if( r_clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							codex_list_pos = codex_list_pos + 7
							if( codex_list_pos > #entries ) then
								codex_list_pos = codex_list_pos - #entries
							end
						end
					end
					
					return uid
				end
				
				for i,page in ipairs( codex_structure ) do
					if( codex_page == i ) then
						uid = new_image( gui, uid, pic_x + ( i - 1 )*30 + 1, pic_y + 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 23, 23 )
					end
					uid = new_image( gui, uid, pic_x + ( i - 1 )*30, pic_y, pic_z, page.main_icon, 1, 1, 1, true )
					clicked, r_clicked, hovered = GuiGetPreviousWidgetInfo( gui )
					uid = new_tooltip( gui, uid, page.name )
					if( hovered ) then
						uid = new_image( gui, uid, pic_x + ( i - 1 )*30 - 1, pic_y - 1, pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/selection_hover.png" )
					end
					if( clicked ) then
						GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
						codex_page = i
						codex_list_pos = 1
						current_entry = 1
					end
				end
				
				pic_y = pic_y + 27
				uid = new_image( gui, uid, pic_x, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_white.png", 175, 1 )
				
				local codex_pages =
				{
					function( gui, uid, pic_x, pic_y, pic_z )
						info_page = info_page or 1
						
						local segment = 1
						local start_pos = 1
						while( start_pos < #codex_structure[codex_page].entries ) do
							local shown = false
							local p_y = pic_y + 3
							local total_height = 0
							for i = start_pos,#codex_structure[codex_page].entries do
								local text = ""
								for e = 2,#codex_structure[codex_page].entries[i] do
									text = text.."- "..codex_structure[codex_page].entries[i][e].." / "
								end
								text = paragrapher( nil, text, 169, 250, 4 )
								local text_y = p_y + ( #text + 1 )*9
								local height = text_y - p_y - 2
								start_pos = i
								
								total_height = total_height + height + 6
								if( total_height > 237 ) then
									segment = segment + 1
									break
								end
								
								if( info_page == segment ) then
									uid = new_high_gothic( gui, uid, pic_x + 3, p_y + 2, pic_z, codex_structure[codex_page].entries[i][1], { 195, 3, 3, 1 })
									new_text( gui, pic_x + 3, p_y + 18, pic_z, text )
									uid = window_inner( gui, uid, pic_x, p_y, pic_z + 0.01, 171, height )
									shown = true
								end
								p_y = text_y + 5
							end
							if( shown ) then
								break
							end
						end
						
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y + 242, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_previous_long.png" )
						if( segment > 1 and clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							info_page = info_page - 1
							if( info_page < 1 ) then
								info_page = segment
							end
						end
						
						uid, clicked, r_clicked = new_button( gui, uid, pic_x + 88, pic_y + 242, pic_z, "mods/Noita40K/files/pics/gui_gfx/main_menu_button_holo_next_long.png" )
						if( segment > 1 and clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							info_page = info_page + 1
							if( info_page > segment ) then
								info_page = 1
							end
						end
					
						return uid
					end,
					function( gui, uid, pic_x, pic_y, pic_z )
						pic_y = pic_y + 3
						uid = entry_scroller( gui, uid, pic_x, pic_y, pic_z, codex_structure[codex_page].entries )
						
						pic_x = pic_x + 30
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 141, 8 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, codex_structure[codex_page].entries[current_entry].name )
						
						pic_y = pic_y + 14
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 141, 60 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, paragrapher( nil, codex_structure[codex_page].entries[current_entry].stats, 139, 250, 4.3 ))
						
						pic_x = pic_x + 83
						pic_y = pic_y + 2
						uid = simple_frame( gui, uid, pic_x, pic_y, pic_z, 60, 60 )
						pic = codex_structure[codex_page].entries[current_entry].image
						if( pic ~= nil ) then
							pic_w, pic_h = GuiGetImageDimensions( gui, pic[1].."1.png", 1 )
							local new_scale = 58/pic_h
							if( pic_w*new_scale > 58 ) then
								new_scale = 58/pic_w
							end
							uid = new_anim( gui, uid, current_entry, pic_x + ( 60 - pic_w*new_scale )/2, pic_y + ( 60 - pic_h*new_scale )/2, pic_z, pic[1], pic[2], pic[3], new_scale, new_scale )
						end
						
						pic_x = pic_x - 83
						pic_y = pic_y + 64
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 141, 163 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, paragrapher( nil, codex_structure[codex_page].entries[current_entry].desc, 139, 250, 4 ))
						
						return uid
					end,
					function( gui, uid, pic_x, pic_y, pic_z )
						pic_y = pic_y + 3
						uid = entry_scroller( gui, uid, pic_x, pic_y, pic_z, codex_structure[codex_page].entries )
						
						pic_x = pic_x + 30
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 141, 8 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, codex_structure[codex_page].entries[current_entry].name )
						
						pic_y = pic_y + 14
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 141, 53 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, paragrapher( nil, codex_structure[codex_page].entries[current_entry].stats, 139, 250, 4.3 ))
						
						pic_x = pic_x + 76
						pic_y = pic_y + 2
						uid = simple_frame( gui, uid, pic_x, pic_y, pic_z, 67, 36 )
						pic = codex_structure[codex_page].entries[current_entry].info.pic
						if( pic ~= nil ) then
							pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
							local new_scale = 63/pic_w
							if( pic_h*new_scale > 32 ) then
								new_scale = 32/pic_h
							end
							uid = new_image( gui, uid, pic_x + ( 67 - pic_w*new_scale )/2, pic_y + ( 36 - pic_h*new_scale )/2, pic_z, pic, new_scale, new_scale )
						end
						
						pic_x = pic_x + 68
						pic_y = pic_y + 37
						for i,mag in ipairs( codex_structure[codex_page].entries[current_entry].info.ammo ) do
							uid = new_image( gui, uid, pic_x - 17*i, pic_y, pic_z, mag )
						end
						
						pic_x = pic_x - 144
						pic_y = pic_y + 20
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 141, 170 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, paragrapher( nil, codex_structure[codex_page].entries[current_entry].desc, 139, 250, 4 ))
						
						return uid
					end,
					function( gui, uid, pic_x, pic_y, pic_z )
						pic_y = pic_y + 3
						uid = entry_scroller( gui, uid, pic_x, pic_y, pic_z, codex_structure[codex_page].entries, true )
						
						pic_x = pic_x + 30
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 141, 8 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, codex_structure[codex_page].entries[current_entry].name )
						
						pic_y = pic_y + 14
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 141, 229 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, paragrapher( nil, codex_structure[codex_page].entries[current_entry].desc, 139, 250, 4 ))
						
						return uid
					end,
					function( gui, uid, pic_x, pic_y, pic_z )
						pic_y = pic_y + 3
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 172, 20 )
						uid = new_high_gothic( gui, uid, pic_x + 3, pic_y + 3, pic_z, "Coming_Soon" )
						
						return uid
					end,
					function( gui, uid, pic_x, pic_y, pic_z )
						pic_y = pic_y + 3
						
						for i = 1,2 do
							uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 171, 30 )
							new_text( gui, pic_x + 3, pic_y + 1, pic_z, codex_structure[codex_page].entries[i][1] )
							uid = new_high_gothic( gui, uid, pic_x + 3, pic_y + 13, pic_z, codex_structure[codex_page].entries[i][2] )
							pic_y = pic_y + 36
						end
						
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 171, 171 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z, paragrapher( nil, codex_structure[codex_page].entries[3], 170, 170, 4 ))
						
						return uid
					end,
				}
				uid = codex_pages[codex_page]( gui, uid, pic_x, pic_y, pic_z )
				
				pic_x = pic_x + 2
				pic_y = pic_y + 253
				uid = window_inner( gui, uid, pic_x, pic_y, pic_z + 0.01, 134, 8 )
				new_text( gui, pic_x + 3, pic_y + 1, pic_z, "Noita40K | ACT III | U4" )
				
				return uid
			end,
		},
	}
	
	if( not( menu_state or quest_state )) then
		pic = "mods/Noita40K/files/pics/gui_gfx/main_menu_button_main.png"
		pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
		pic_x = w - ( pic_w + 1 )
		pic_y = 1
		uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z, pic )
		if( clicked ) then
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/menu_open", char_x, char_y )
			ComponentSetValue2( menu_state_storage, "value_bool", true )
		end
		
		if( quest_info_raw ~= "|" ) then
			pic = "mods/Noita40K/files/pics/gui_gfx/quest_menu_button_main.png"
			pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
			pic_x = pic_x - ( pic_w + 1 )
			uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z, pic )
			if( clicked ) then
				GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/menu_open", char_x, char_y )
				ComponentSetValue2( quest_menu_storage, "value_bool", true )
			end
		end
	elseif( quest_state ) then
		quest_list_pos = quest_list_pos or 1
		current_quest = current_quest or 1
		
		pic_x = w - 19
		pic_y = 1
		uid = window_pillar( gui, uid, pic_x, pic_y, pic_z + 0.1, 108, "B" )
		if( #quest_info > 0 ) then
			uid, clicked, r_clicked = new_button( gui, uid, pic_x + 1, pic_y + 8, pic_z, "mods/Noita40K/files/pics/gui_gfx/quest_menu_button_holo_up.png" )
			uid = new_tutorial_tooltip( gui, uid, "LMB to scroll singulars. / RMB to scroll pages. /" )
			if( #quest_info > 5 ) then
				if( clicked ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					quest_list_pos = quest_list_pos - 1
					if( quest_list_pos < 1 ) then
						quest_list_pos = #quest_info
					end
				end
				if( r_clicked ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					quest_list_pos = quest_list_pos - 5
					if( quest_list_pos < 1 ) then
						quest_list_pos = quest_list_pos + #quest_info
					end
				end
			end
			local list_num = quest_list_pos
			for i = 1,5 do
				if( list_num <= #quest_info ) then
					if( current_quest == list_num ) then
						uid = new_image( gui, uid, pic_x + 2, pic_y + ( i - 1 )*17 + 21, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 14 )
					end
					
					uid = new_image( gui, uid, pic_x + 1, pic_y + ( i - 1 )*17 + 20, pic_z, quest_info[list_num][3], 1, 1, 1, true )
					clicked, r_clicked, hovered = GuiGetPreviousWidgetInfo( gui )
					uid = new_tooltip( gui, uid, paragrapher( nil, quest_info[list_num][4], 100, 100, 4 ))
					if( panel_state == tonumber( quest_info[list_num][1] )) then
						uid = new_image( gui, uid, pic_x, pic_y + ( i - 1 )*17 + 19, pic_z, "mods/Noita40K/files/pics/gui_gfx/icons/menu/selection_hover_small.png" )
					end
					if( clicked ) then
						GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
						current_quest = list_num
					end
				end
				
				list_num = list_num + 1
				if( list_num > #quest_info ) then
					if( #quest_info > 5 ) then
						list_num = 1
					else
						break
					end
				end
			end
			uid, clicked, r_clicked = new_button( gui, uid, pic_x + 1, pic_y + 106, pic_z, "mods/Noita40K/files/pics/gui_gfx/quest_menu_button_holo_down.png" )
			uid = new_tutorial_tooltip( gui, uid, "LMB to scroll singulars. / RMB to scroll pages. /" )
			if( #quest_info > 5 ) then
				if( clicked ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					quest_list_pos = quest_list_pos + 1
					if( quest_list_pos > #quest_info ) then
						quest_list_pos = 1
					end
				end
				if( r_clicked ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					quest_list_pos = quest_list_pos + 5
					if( quest_list_pos > #quest_info ) then
						quest_list_pos = quest_list_pos - #quest_info
					end
				end
			end
		end
		
		pic_x = pic_x - 210
		uid = window_normal( gui, uid, pic_x, pic_y, pic_z + 0.1, 186, 98, 3 )
		uid, clicked, r_clicked = new_button( gui, uid, pic_x + 191, pic_y + 3, pic_z, "mods/Noita40K/files/pics/gui_gfx/quest_menu_button_holo_close.png" )
		if( clicked ) then
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
			ComponentSetValue2( quest_menu_storage, "value_bool", false )
		end
		if( #quest_info > 0 ) then
			gonna_remove = gonna_remove or 0
			uid, clicked, r_clicked = new_button( gui, uid, pic_x + 10, pic_y + 12, pic_z, quest_info[current_quest][3] )
			if( gonna_remove == current_quest ) then
				uid = new_tooltip( gui, uid, paragrapher( nil, "RMB to proceed. / LMB to cancel. /", 200, 100, 3.9 ))
				uid = new_image( gui, uid, pic_x + 10, pic_y + 12, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/quest_menu_button_holo_delete.png" )
				if( clicked ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					gonna_remove = 0
				elseif( r_clicked ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
					remove_quest( hooman, quest_info[current_quest][1] )
					gonna_remove = 0
				end
			else
				if( gonna_remove > 0 ) then
					gonna_remove = 0
				end
			
				uid = new_tutorial_tooltip( gui, uid, "RMB to delete." )
				if( r_clicked ) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					gonna_remove = current_quest
				end
			end
			
			uid = window_inner( gui, uid, pic_x + 27, pic_y + 16, pic_z + 0.01, 172, 8, "filler_weak_red" )
			new_text( gui, pic_x + 30, pic_y + 17, pic_z, quest_info[current_quest][4] )
			
			uid = window_inner( gui, uid, pic_x + 7, pic_y + 29, pic_z + 0.01, 192, 71 )
			new_text( gui, pic_x + 10, pic_y + 30, pic_z, paragrapher( nil, quest_info[current_quest][5], 192, 71, 3.9 ))
			
			uid = window_inner( gui, uid, pic_x + 7, pic_y + 105, pic_z + 0.01, 179, 8 )
			uid = get_quest_with_id( quest_info[current_quest][2] ).checker( quest_info[current_quest][1], gui, uid, pic_x + 10, pic_y + 106, pic_z, hooman, char_x, char_y, quest_info[current_quest][6], quest_info[current_quest][7], quest_info[current_quest][8], quest_info[current_quest][9] )
			
			if( panel_state == tonumber( quest_info[current_quest][1] )) then
				uid = new_image( gui, uid, pic_x + 192, pic_y + 106, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 10, 10 )
			elseif( tutorial_mode ) then
				new_blinker( gui, { 195/255, 3/255, 3/255, 1 } )
			end
			uid, clicked, r_clicked = new_button( gui, uid, pic_x + 191, pic_y + 105, pic_z, "mods/Noita40K/files/pics/gui_gfx/quest_menu_button_holo_pin.png" )
			if( clicked ) then
				if( panel_state == tonumber( quest_info[current_quest][1] )) then
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
					ComponentSetValue2( panel_state_storage, "value_int", 0 )
				else
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
					ComponentSetValue2( panel_state_storage, "value_int", tonumber( quest_info[current_quest][1] ))
				end
			end
		end
	else
		pic_x = w - 216
		pic_y = 0
		close_action = function()
			local hooman = GetUpdatedEntityID()
			local menu_state_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "mm_is_open" )
			ComponentSetValue2( menu_state_storage, "value_bool", false )
			
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/menu_close", char_x, char_y )
		end
		next_action = function()
			local hooman = GetUpdatedEntityID()
			local page_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "mm_page_number" )
			local page_number = ComponentGetValue2( page_storage, "value_int" )
			if( page_number < #pages ) then
				page_number = page_number + 1
			else
				page_number = 1
			end
			ComponentSetValue2( page_storage, "value_int", page_number )
			
			if( EntityHasTag( hooman, "mm_tutorial" )) then
				EntityRemoveTag( hooman, "mm_tutorial" )
			end
			
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/forward", char_x, char_y )
		end
		previous_action = function()
			local hooman = GetUpdatedEntityID()
			local page_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "mm_page_number" )
			local page_number = ComponentGetValue2( page_storage, "value_int" )
			if( page_number > 1 ) then
				page_number = page_number - 1
			else
				page_number = #pages
			end
			ComponentSetValue2( page_storage, "value_int", page_number )
			
			if( EntityHasTag( hooman, "mm_tutorial" )) then
				EntityRemoveTag( hooman, "mm_tutorial" )
			end
			
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/forward", char_x, char_y )
		end
		local height = math.floor(( h - 72 )/18 )
		uid = window_large( gui, uid, pic_x, pic_y, pic_z + 0.1, 3, 1, height, close_action, next_action, previous_action, pages[page_number].pic )
		
		pic_x = pic_x + 20
		pic_y = pic_y + 22
		uid = new_image( gui, uid, pic_x, pic_y, pic_z, pages[page_number].title )
		
		pic_y = pic_y + 40
		uid = pages[page_number].content( gui, uid, pic_x, pic_y, pic_z )
	end
elseif( panel_state ~= 0 ) then
	pic_x = w - 200
	pic_y = 0
	local pinned_quest = get_quest_with_num( panel_state )
	uid = window_small( gui, uid, pic_x, pic_y, -0.9, 183, "B" )
	uid = window_inner( gui, uid, pic_x + 8, pic_y + 3, -0.99, 179, 8 )
	uid = get_quest_with_id( pinned_quest[2] ).checker( tostring( panel_state ), gui, uid, pic_x + 11, pic_y + 4, -1, hooman, char_x, char_y, pinned_quest[6], pinned_quest[7], pinned_quest[8], pinned_quest[9] )
end

if( #quest_info > 0 ) then
	for i,q in ipairs( quest_info ) do
		if( get_quest_with_id( q[2] ).winner( q[1], hooman, char_x, char_y, q[6], q[7], q[8], q[9] )) then
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/quest_end", char_x, char_y )
			new_notification( q[10], "Quest completed.", false )
			remove_quest( hooman, q[1] )
			current_quest = 1
			quest_list_pos = 1
		end
	end
end

if( #note_info > 0 ) then
	if( frame_num > note_cooldown ) then
		GamePrintImportant( note_info[1][1], note_info[1][2], "mods/Noita40K/files/pics/gui_gfx/window_modules/3piece_custom_A.png" )
		if( note_info[1][3] == "1" ) then
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/note", char_x, char_y )
		end
		table.remove( note_info, 1 )
		ModSettingSetNextValue( "Noita40K.NOTE_INFO", DD_packer( note_info ), false )
		ComponentSetValue2( note_cooldown_storage, "value_int", frame_num + 240 )
	end
end