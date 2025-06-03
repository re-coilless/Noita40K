dofile_once( "mods/index_core/files/_lib.lua" )
-- dofile_once( "mods/Noita40K/files/_lists.lua" )



--[[
function generic_stuff( hooman )
	--Player entity setup
	edit_component_with_tag_ultimate( hooman, "SpriteComponent", "player_amulet", function(comp,vars) 
		ComponentSetValue2( comp, "z_index", 0.599 )
		EntityRefreshSprite( hooman, comp )
	end)
	
	edit_component_with_tag_ultimate( hooman, "SpriteComponent", "player_hat2", function(comp,vars) 
		ComponentSetValue2( comp, "z_index", 0.599 )
		EntityRefreshSprite( hooman, comp )
	end)
	
	edit_component_ultimate( hooman, "CharacterPlatformingComponent", function(comp,vars) 
		ComponentSetValue2( comp, "accel_x", 0.3 )
		ComponentSetValue2( comp, "velocity_max_x", 70 )
	end)
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "head_offset",
		name = "head_offset",
		value_int = "0",
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "cooldown_taunt",
		name = "cooldown_taunt",
		value_int = "0",
	})
	
	EntityAddComponent( hooman, "AudioComponent", 
	{ 
		file = "mods/Noita40K/files/40K.bank",
		event_root = "taunts",
	})
	
	--GUIer
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "mm_is_open",
		name = "mm_is_open",
		value_bool = tostring( b2n( ModSettingGetNextValue( "Noita40K.UI_MODE" ) == 1 )),
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "mm_page_number",
		name = "mm_page_number",
		value_int = 2, --tostring( 2 + b2n( ModSettingGetNextValue( "Noita40K.UI_MODE" ) == 1 )),
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "qm_is_open",
		name = "qm_is_open",
		value_bool = "0",
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "qm_panel_state",
		name = "qm_panel_state",
		value_int = "0",
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "cooldown_note",
		name = "cooldown_note",
		value_int = "300",
	})
	
	EntityAddTag( hooman, "mm_tutorial" )
	
	EntityAddComponent( hooman, "LuaComponent", 
	{ 
		_tags = "menu",
		script_source_file = "mods/Noita40K/files/scripts/player/main_controller.lua",
		execute_every_n_frame = "1",
		-- vm_type = "ONE_PER_COMPONENT_INSTANCE",
	})
	
	EntityAddComponent( hooman, "LuaComponent", 
	{ 
		script_source_file = "mods/Noita40K/files/scripts/player/perk_gui.lua",
		execute_every_n_frame = "1",
	})
	
	EntityAddComponent( hooman, "LuaComponent", 
	{ 
		script_source_file = "mods/Noita40K/files/scripts/fog_hole_offseter.lua",
		execute_every_n_frame = "1",
		remove_after_executed = "1",
	})
end

function magic_setuper( active_class, hooman, custom )
	local class = class_info[active_class[1] ]
	local skin = class.skins[active_class[2] ]
	
	--Perks
	local perk_table = class.default_perks
	if( skin ~= nil and skin.perks ~= nil ) then
		if( #skin.perks[2] > 0 ) then
			if( skin.perks[1] ) then
				perk_table = skin.perks[2]
			else
				for i,perk in ipairs( skin.perks[2] ) do
					table.insert( perk_table, perk )
				end
			end
		end
	end
	if( perk_table ~= nil ) then
		for i,perk in ipairs( perk_table ) do
			perker( hooman, perk[1], perk[2], perk[3] )
		end
	end
	
	--Loadout
	local loadout = class.default_guns
	if( custom ) then
		loadout = D_extractor( ModSettingGetNextValue( "Noita40K.CUSTOM_LOADOUT" ), true )
	elseif( skin ~= nil and skin.guns ~= nil ) then
		loadout = skin.guns
	end
	if( loadout ~= nil ) then
		local guns = {}
		for i,gun in ipairs( loadout ) do
			table.insert( guns, get_gun_with_id( gun ).path )
		end
		picker( hooman, guns )
	end
	
	--Items
	loadout = class.default_items
	if( skin ~= nil and skin.items ~= nil ) then
		loadout = skin.items
	end
	if( loadout ~= nil ) then
		local items = {}
		for i,item in ipairs( loadout ) do
			table.insert( items, get_gun_with_id( item ).path )
		end
		picker( hooman, items )
	end
	
	--Custom
	if( skin ~= nil and skin.custom_code ~= nil ) then
		skin.custom_code( hooman )
	end
end

function window_inner( gui, uid, pic_x, pic_y, pic_z, width, height, inner_filler )
	inner_filler = inner_filler or "filler_weak_gray"

	local pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/inner_A.png"
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/"..inner_filler..".png"
	uid = new_image( gui, uid, pic_x + 1, pic_y + 1, pic_z, pic, width + 2, height + 2 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_white.png"
	pic_x = pic_x + 2
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, width, 1 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/inner_B.png"
	pic_x = pic_x + width
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/inner_A.png"
	pic_x = pic_x
	pic_y = pic_y + height + 2
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_white.png"
	pic_x = pic_x - width
	pic_y = pic_y + 1
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, width, 1 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/inner_B.png"
	pic_x = pic_x - 2
	pic_y = pic_y - 1
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic )
	
	return uid
end

function window_tiny( gui, uid, pic_x, pic_y, pic_z, length, opener_type )
	local pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/tiny_"..( opener_type or "A" )..".png"
	local pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/tiny_filler.png"
	pic_x = pic_x + pic_w
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, length, 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 0.2, pic, length, 1, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/tiny_C.png"
	pic_x = pic_x + length
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	return uid
end

function window_small( gui, uid, pic_x, pic_y, pic_z, length, closer_type )
	local pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/small_A.png"
	local pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/small_filler.png"
	pic_x = pic_x + pic_w
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, length, 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 0.2, pic, length, 1, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/small_"..( closer_type or "B" )..".png"
	pic_x = pic_x + length - 4
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	return uid
end

function window_pillar( gui, uid, pic_x, pic_y, pic_z, height, closer_type )
	local pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/pillar_A.png"
	local pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/pillar_filler.png"
	pic_y = pic_y + pic_h
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1, height )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 0.2, pic, 1, height, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/pillar_"..( closer_type or "B" )..".png"
	pic_y = pic_y + height
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	return uid
end

function window_normal( gui, uid, pic_x, pic_y, pic_z, width, height, mode, skull_action )
	mode = mode or 1
	local mode_offset_x, mode_offset_y = 0, 0
	
	local pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/normal_A.png"
	local pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	
	if( mode == 2 ) then
		local tmp1, tmp2 = pic_w, pic_h
		
		pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/normal_A_skull.png"
		pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
		uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 1.01, pic )
		if( clicked ) then
			skull_action()
		end
		
		mode_offset_x = pic_w - tmp1
		mode_offset_y = pic_h - tmp2 - 1
		
		pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_bright.png"
		uid = new_image( gui, uid, pic_x + pic_w, pic_y + 12, pic_z, pic, width, height + 9 )
		uid = new_image( gui, uid, pic_x + pic_w, pic_y + 12, pic_z - 0.2, pic, width, height + 9, 0.5 )
		
		uid = new_image( gui, uid, pic_x + 10, pic_y + pic_h - 1, pic_z, pic, 9, height + 1 )
		uid = new_image( gui, uid, pic_x + 10, pic_y + pic_h - 1, pic_z - 0.2, pic, 9, height + 1, 0.5 )
	else
		uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
		
		pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_bright.png"
		uid = new_image( gui, uid, pic_x + 10, pic_y + 12, pic_z, pic, width + 7, height + 7 )
		uid = new_image( gui, uid, pic_x + 10, pic_y + 12, pic_z - 0.2, pic, width + 7, height + 7, 0.5 )
	end
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/normal_filler_AB.png"
	pic_x = pic_x + pic_w
	pic_y = pic_y + 2
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, width, 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 0.2, pic, width, 1, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/normal_B"
	pic_x = pic_x + width - 4
	pic_y = pic_y - 2
	if( mode == 3 ) then
		pic = pic.."_flareless"
	end
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic..".png" )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/normal_filler_BD.png"
	pic_x = pic_x + 4
	pic_y = pic_y + 12
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1, height + 7 + mode_offset_y )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 0.2, pic, 1, height + 7 + mode_offset_y, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/normal_D.png"
	pic_x = pic_x - 1
	pic_y = pic_y + ( height + 7 + mode_offset_y )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/normal_filler_DC.png"
	pic_x = pic_x - ( width + 9 + mode_offset_x )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, width + 10 + mode_offset_x, 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 0.2, pic, width + 10 + mode_offset_x, 1, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/normal_C.png"
	pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	pic_x = pic_x - pic_w
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/normal_filler_CA.png"
	pic_x = pic_x + 2
	pic_y = pic_y - ( height + 1 + mode_offset_y )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1, height + 1 + mode_offset_y )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 0.2, pic, 1, height + 1 + mode_offset_y, 0.5 )
	
	return uid
end

function window_large( gui, uid, pic_x, pic_y, pic_z, width, height_upper, height_lower, close_action, next_action, previous_action, sign_pic ) -- h and w is in modules
	width = width*2 + 5

	local pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_corner.png"
	local pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	local clicked, r_clicked = 0, 0
	local temp_offset = 0
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1.03, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_horizontal.png"
	pic_x = pic_x + pic_w - 2
	pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	temp_offset = pic_x
	for i = 1,width do
		uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
		pic_x = pic_x + pic_w
	end
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_darker.png"
	uid = new_image( gui, uid, temp_offset + 2, pic_y + pic_h, pic_z, pic, width*18 - 4, 4, 1.2 )
	uid = new_image( gui, uid, temp_offset + 2, pic_y + pic_h, pic_z - 0.2, pic, width*18 - 4, 4, 0.3 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_bright.png"
	uid = new_image( gui, uid, temp_offset + 2, pic_y + pic_h + 4, pic_z, pic, width*18 - 6, 6, 1.2 )
	uid = new_image( gui, uid, temp_offset + 2, pic_y + pic_h + 4, pic_z - 0.2, pic, width*18 - 6, 6, 0.3 )
	
	uid = new_image( gui, uid, temp_offset, pic_y + pic_h + 10, pic_z, pic, width*18 - 4, height_upper*18 + 2, 1.2 )
	uid = new_image( gui, uid, temp_offset, pic_y + pic_h + 10, pic_z - 0.2, pic, width*18 - 4, height_upper*18 + 2, 0.3 )
	
	pic_x = pic_x - 2
	pic_y = pic_y + pic_h
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_gray.png"
	uid = new_image( gui, uid, pic_x + 1, pic_y - 3, pic_z - 1.01, pic, 1, 3 )
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_vertical_tiny.png"
	temp_offset = 14 + height_upper*18
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic, 1, temp_offset )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_darker.png"
	uid = new_image( gui, uid, pic_x - 2, pic_y + 4, pic_z, pic, 2, temp_offset - 4, 1.2 )
	uid = new_image( gui, uid, pic_x - 2, pic_y + 4, pic_z - 0.2, pic, 2, temp_offset - 4, 0.3 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_special_link_right.png"
	pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	pic_x = pic_x - pic_w + 2
	pic_y = pic_y + temp_offset
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1.01, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_special_horizontal.png"
	for i = 1,math.floor( 4.5*( width - 1 ) + 1 ) do
		pic_x = pic_x - 4
		uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	end
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_special_link_left.png"
	pic_x = pic_x - pic_w
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1.01, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_darker.png"
	uid = new_image( gui, uid, pic_x + 6, pic_y - 2, pic_z, pic, width*18 - 4, 2, 1.2 )
	uid = new_image( gui, uid, pic_x + 6, pic_y - 2, pic_z - 0.2, pic, width*18 - 4, 2, 0.3 )
	
	uid = new_image( gui, uid, pic_x + 6, pic_y + 12, pic_z, pic, width*18 - 4, 4 )
	uid = new_image( gui, uid, pic_x + 6, pic_y + 12, pic_z - 0.2, pic, width*18 - 4, 4, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_bright.png"
	uid = new_image( gui, uid, pic_x + 6, pic_y + 16, pic_z, pic, width*18 - 4, height_lower*18 - 6 )
	uid = new_image( gui, uid, pic_x + 6, pic_y + 16, pic_z - 0.2, pic, width*18 - 4, height_lower*18 - 6, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_special_vertical.png"
	pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	pic_x = pic_x - pic_w + 2
	pic_y = pic_y - 8
	temp_offset = pic_y
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1.02, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_vertical.png"
	for i = 1,height_upper do
		pic_y = pic_y - pic_h
		uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	end
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_darker.png"
	uid = new_image( gui, uid, pic_x + pic_w, pic_y + 4, pic_z, pic, 4, height_upper*18 + 6, 1.2 )
	uid = new_image( gui, uid, pic_x + pic_w, pic_y + 4, pic_z - 0.2, pic, 4, height_upper*18 + 6, 0.3 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_vertical.png"
	pic_y = temp_offset
	for i = 1,height_lower do
		pic_y = pic_y + pic_h
		uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	end
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_darker.png"
	uid = new_image( gui, uid, pic_x + pic_w, temp_offset + pic_h + 2, pic_z, pic, 4, height_lower*18 - 2 )
	uid = new_image( gui, uid, pic_x + pic_w, temp_offset + pic_h + 2, pic_z - 0.2, pic, 4, height_lower*18 - 2, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_button_close_bg.png"
	pic_y = pic_y + pic_h
	pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_button_close.png"
	uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 1.01, pic )
	if( clicked ) then
		close_action()
	end
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_horizontal_tiny.png"
	pic_x = pic_x + pic_w
	pic_y = pic_y + pic_h - 3
	temp_offset = ( width - 3 )*18 - 1
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic, temp_offset, 1 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_darker.png"
	uid = new_image( gui, uid, pic_x, pic_y - 2, pic_z, pic, temp_offset, 2 )
	uid = new_image( gui, uid, pic_x, pic_y - 2, pic_z - 0.2, pic, temp_offset, 2, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_bright.png"
	uid = new_image( gui, uid, pic_x, pic_y - pic_h + 3, pic_z, pic, temp_offset, pic_h - 5 )
	uid = new_image( gui, uid, pic_x, pic_y - pic_h + 3, pic_z - 0.2, pic, temp_offset, pic_h - 5, 0.5 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_button_page_bg.png"
	pic_x = pic_x + temp_offset
	pic_y = pic_y - pic_h + 3
	pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic )
	
	local tutorial_mode = ( ModSettingGetNextValue( "Noita40K.UI_MODE" ) == 1 ) and EntityHasTag( GetUpdatedEntityID(), "mm_tutorial" )
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_button_previous.png"
	if( tutorial_mode ) then
		new_blinker( gui, { 195/255, 3/255, 3/255, 1 } )
	end
	uid, clicked, r_clicked = new_button( gui, uid, pic_x + 2, pic_y, pic_z - 1.01, pic )
	if( tutorial_mode ) then
		uid = new_tooltip( gui, uid, "Disable Tutorial mode in settings." )
	end
	if( clicked ) then
		previous_action()
	end
	
	uid = new_image( gui, uid, pic_x + 21, pic_y + 3, pic_z - 1.01, sign_pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_button_next.png"
	if( tutorial_mode ) then
		new_blinker( gui, { 195/255, 3/255, 3/255, 1 } )
	end
	uid, clicked, r_clicked = new_button( gui, uid, pic_x + 35, pic_y, pic_z - 1.01, pic )
	if( tutorial_mode ) then
		uid = new_tooltip( gui, uid, "Disable Tutorial mode in settings." )
	end
	if( clicked ) then
		next_action()
	end
	
	pic = "mods/Noita40K/files/pics/gui_gfx/window_modules/large_vertical_tiny.png"
	pic_x = pic_x + pic_w - 2
	pic_y = pic_y - 18*height_lower
	uid = new_image( gui, uid, pic_x, pic_y, pic_z - 1, pic, 1, 18*height_lower )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_green_darker.png"
	uid = new_image( gui, uid, pic_x - 2, pic_y + 2, pic_z, pic, 2, 18*height_lower - 2 )
	uid = new_image( gui, uid, pic_x - 2, pic_y + 2, pic_z - 0.2, pic, 2, 18*height_lower - 2, 0.5 )
	
	return uid
end
]]