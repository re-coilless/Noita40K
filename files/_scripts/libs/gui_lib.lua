dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

function shorten_number( num, length )
	local str = tostring( math.floor( num + 0.5 ))
	if( math.abs( num ) > 10^length - 1 ) then
		if( num > 0 ) then
			str = "_"..string.sub( str, -length )
		else
			str = "-_"..string.sub( str, -length )
		end
	end
	
	return str
end

function K_number( num, limit )
	if( num == nil ) then
		return "[NIL]"
	end
	
	local str = tostring( num )
	if( math.abs( num ) > 10^6 ) then
		str = "[ERROR]"
	elseif( math.abs( num ) > 10^( 3 + limit ) - 1 ) then
		str = math.floor( num/1000 + 0.5 ).."K"
	end
	
	return str
end

function text_cleaner( text )
	if( text == nil or text == "" ) then
		text = "[NIL]"
	end
	
	return text
end

function name_cleaner( name )
	if( name ~= nil and name ~= "" ) then
		if( ModSettingGetNextValue( "Noita40K.DATABASED_NAMES" )) then
			name = GameTextGetTranslatedOrNot( name )
		end
		
		name = string.lower( name )
		local crap_a, crap_b = string.find( name , "%$%w*_" )
		if( crap_b ~= nil ) then
			name = string.gsub( name, string.sub( name, crap_a, crap_b ), "" )
		end
		name = string.gsub( name, "_", "" )
	else
		name = "[NIL]"
	end
	
	return name
end

function paragrapher( gui, text, length, height, length_k )
	local formated = {}
	if( text ~= nil and text ~= "" ) then
		local length_counter = 0
		if( height ~= nil ) then
			length_k = length_k or 6
			length = math.floor( length/length_k + 0.5 )
			height = math.floor( height/9 )
			local words = t2w( text )
			local height_counter = 1
			text = ""
			
			for i,word in ipairs( words ) do
				local w_length = string.len( word ) + 1
				length_counter = length_counter + w_length
				
				if( length_counter > length or word == "/" ) then
					table.insert( formated, tostring( string.gsub( string.sub( text, 1, length ), "/ ", "" )))
					length_counter = w_length
					height_counter = height_counter + 1
					text = ""
				end
				
				if( height_counter > height ) then
					break
				end
				
				text = text..word.." "
			end
			
			table.insert( formated, tostring( string.gsub( string.sub( text, 1, length ), "/", "" )))
		else
			local starter = math.floor( math.abs( length )/7 + 0.5 )
			local total_length = string.len( text )
			if( starter < total_length ) then
				if( length > 0 or not( ModSettingGetNextValue( "p2k.END_DISPLAY" ))) then
					length = math.abs( length )
					formated = string.sub( text, 1, starter )
					for i = starter + 1,total_length do
						formated = formated..string.sub( text, i, i )
						length_counter = GuiGetTextDimensions( gui, formated, 1, 2 )
						if( length_counter > length ) then
							formated = string.sub( formated, 1, string.len( formated ) - 1 )
							break
						end
					end
				else
					length = math.abs( length )
					starter = total_length - starter
					formated = string.sub( text, starter, total_length )
					while starter > 0 do
						starter = starter - 1
						formated = string.sub( text, starter, starter )..formated
						length_counter = GuiGetTextDimensions( gui, formated, 1, 2 )
						if( length_counter > length ) then
							formated = string.sub( formated, 2, string.len( formated ))
							break
						end
					end
				end
			else
				formated = text
			end
		end
	else
		table.insert( formated, "[NIL]" )
	end
	
	return formated
end

function world2gui( gui, x, y )
	local w, h = GuiGetScreenDimensions( gui )
	local cam_x, cam_y = GameGetCameraPos()
	local shit_from_ass = w/( MagicNumbersGetValue( "VIRTUAL_RESOLUTION_X" ) + MagicNumbersGetValue( "VIRTUAL_RESOLUTION_OFFSET_X" ))
	
	return w/2 + shit_from_ass*( x - cam_x ), h/2 + shit_from_ass*( y - cam_y )
end

-- function get_camera_shake( hooman )
	-- hooman = hooman or get_player() or 0
	-- if( hooman == 0 ) then
		-- return 0, 0
	-- end
	
	-- local m_r_x, m_r_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" ), "mMousePositionRaw" )
	-- local m_w_x, m_w_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" ), "mMousePosition" )
	-- gimme the actual resolution
	-- local shit_from_ass = w/( MagicNumbersGetValue( "VIRTUAL_RESOLUTION_X" ) + MagicNumbersGetValue( "VIRTUAL_RESOLUTION_OFFSET_X" ))
	
	-- return 
-- end

function get_mouse_pos( gui )
	local m_x, m_y = DEBUG_GetMouseWorld()
	return world2gui( gui, m_x, m_y )
end

function new_text( gui, pic_x, pic_y, pic_z, text, colours )
	local out_str = {}
	if( text ~= nil ) then
		if( type( text ) == "table" ) then
			out_str = text
		else
			table.insert( out_str, text )
		end
	else
		table.insert( out_str, "[NIL]" )
	end
	
	for i,line in ipairs( out_str ) do
		if( colours ~= nil ) then
			GuiColorSetForNextWidget( gui, colours[1]/255, colours[2]/255, colours[3]/255, colours[4] )
		end
		GuiZSetForNextWidget( gui, pic_z )
		GuiText( gui, pic_x, pic_y, line )
		pic_y = pic_y + 9
	end
end

function new_ecs_text( gui, pic_x, pic_y, pic_z, comp, value_f, desc )
	local out_str = {}
	if( comp ~= nil ) then
		local text = value_f( comp )
		
		if( type( text ) == "table" ) then
			out_str = text
		else
			table.insert( out_str, text )
		end
	else
		table.insert( out_str, "[NIL]" )
	end
	
	for i,line in ipairs( out_str ) do
		if( desc ~= nil ) then
			if( i == 1 ) then
				line = desc..": "..line
			elseif( i == 2 ) then
				pic_x = pic_x + GuiGetTextDimensions( gui, desc, 1, 1 )
			end
		end
		
		GuiZSetForNextWidget( gui, pic_z )
		GuiText( gui, pic_x, pic_y, line )
		pic_y = pic_y + 9
	end
end

function new_console_entry( hooman, text, cleaner_type )
	local console_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "console_log" )
	if( console_storage ~= nil ) then
		local memory_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "last_log" )
		local console_log = ComponentGetValue2( console_storage, "value_string" )
		local last_log = ComponentGetValue2( memory_storage, "value_string" )
		if( cleaner_type == 0 or ( text ~= last_log and cleaner_type == 1 ) or ( string.find( console_log, text ) == nil and cleaner_type == 2 )) then
			ComponentSetValue2( console_storage, "value_string", text.." / "..console_log )
			ComponentSetValue2( memory_storage, "value_string", text )
		end
	end
end

function console_text( gui, pic_x, pic_y, pic_z, text )
	local out_str = {}
	if( text ~= nil ) then
		out_str = text
	else
		table.insert( out_str, "[NIL]" )
	end
	
	local line_count = #out_str - 1
	for i,line in ipairs( out_str ) do
		local k = 0.05*( i - 1 )
		GuiColorSetForNextWidget( gui, 1 - k, 1 - k, 1 - k, 1 - k/2 )
		new_text( gui, pic_x, pic_y, pic_z, line )
		pic_y = pic_y - 9
	end
end

function new_image( gui, uid, pic_x, pic_y, pic_z, pic, s_x, s_y, alpha, interactive )
	if( s_x == nil ) then
		s_x = 1
	end
	if( s_y == nil ) then
		s_y = 1
	end
	if( alpha == nil ) then
		alpha = 1
	end
	if( interactive == nil ) then
		interactive = false
	end
	
	if( not( interactive )) then
		GuiOptionsAddForNextWidget( gui, 2 ) --NonInteractive
	end
	GuiZSetForNextWidget( gui, pic_z )
	uid = uid + 1
	GuiIdPush( gui, uid )
	GuiImage( gui, uid, pic_x, pic_y, pic, alpha, s_x, s_y )
	return uid
end

function new_blinker( gui, colour )
	colour = rgb2hsv( colour )
	local fancy_index = math.abs( math.cos( math.rad( GameGetFrameNum())))
	colour = hsv2rgb( { colour[1], fancy_index*colour[2], math.max( colour[3], ( 1 - fancy_index )), colour[3] } )
	GuiColorSetForNextWidget( gui, colour[1], colour[2], colour[3], colour[4] )
end

function new_button( gui, uid, pic_x, pic_y, pic_z, pic )
	GuiZSetForNextWidget( gui, pic_z )
	uid = uid + 1
	GuiIdPush( gui, uid )
	GuiOptionsAddForNextWidget( gui, 6 ) --NoPositionTween
	GuiOptionsAddForNextWidget( gui, 4 ) --ClickCancelsDoubleClick
	GuiOptionsAddForNextWidget( gui, 21 ) --DrawNoHoverAnimation
	GuiOptionsAddForNextWidget( gui, 47 ) --NoSound
	local clicked, r_clicked = GuiImageButton( gui, uid, pic_x, pic_y, "", pic )
	return uid, clicked, r_clicked
end

function new_anim( gui, uid, auid, pic_x, pic_y, pic_z, path, amount, delay, s_x, s_y, alpha, interactive ) --you need to uid them manually
	anims_state = anims_state or {}
	anims_state[auid] = anims_state[auid] or { 1, 0 }
	
	new_image( gui, uid, pic_x, pic_y, pic_z, path..anims_state[auid][1]..".png", s_x, s_y, alpha, interactive )
	
	anims_state[auid][2] = anims_state[auid][2] + 1
	if( anims_state[auid][2] > delay ) then
		anims_state[auid][2] = 0
		anims_state[auid][1] = anims_state[auid][1] + 1
		if( anims_state[auid][1] > amount ) then
			anims_state[auid][1] = 1
		end
	end
	
	return uid
end

function new_dragger( gui, uid, pic_x, pic_y, pic_z, pic ) --you need to uid them manually
	GuiOptionsAddForNextWidget( gui, 51 ) --IsExtraDraggable
	new_button( gui, uid, pic_x, pic_y, pic_z, pic )
	local _, _, _, _, _, _, _, d_x, d_y = GuiGetPreviousWidgetInfo( gui )
	if( d_x ~= pic_x and d_y ~= pic_y and d_x ~= 0 and d_y ~= 0 ) then
		if( local_grab_x[uid] == nil ) then
			local_grab_x[uid] = d_x - pic_x
		end
		if( local_grab_y[uid] == nil ) then
			local_grab_y[uid] = d_y - pic_y
		end
		
		pic_x = d_x - local_grab_x[uid]
		pic_y = d_y - local_grab_y[uid]
	else
		local_grab_x[uid] = nil
		local_grab_y[uid] = nil
	end
	
	return pic_x, pic_y
end

function new_slider( gui, uid, char_x, char_y, pic_x, pic_y, pic_z, dragger_uid, length, operator_pos )
	operator_pos = operator_pos*length
	local new_pos = operator_pos
	
	local pic = "mods/Noita40K/files/pics/gui_gfx/button_side.png"
	local pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
	local clicked, r_clicked, hovered = false, false, false
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_white.png"
	pic_x = pic_x + pic_w
	uid = new_image( gui, uid, pic_x, pic_y + ( pic_h/2 - 2 ), pic_z, pic, length + pic_w, 1 )
	uid = new_image( gui, uid, pic_x, pic_y + ( pic_h/2 + 1 ), pic_z, pic, length + pic_w, 1 )
	
	pic = "mods/Noita40K/files/pics/gui_gfx/button_side.png"
	uid = new_image( gui, uid, pic_x + length + pic_w, pic_y, pic_z, pic )
	
	pic_x = pic_x + operator_pos
	local new_x, new_y = new_dragger( gui, dragger_uid, pic_x, pic_y, pic_z - 0.02, "mods/Noita40K/files/pics/gui_gfx/slider_dragger.png" )
	if( math.abs( pic_x - new_x ) > 0.001 ) then
		new_pos = new_pos + ( new_x - pic_x )
	end
	uid, clicked, r_clicked = new_image( gui, uid, pic_x, pic_y, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/slider_operator.png" )
	
	if( new_pos > length ) then
		new_pos = length
	elseif( new_pos < 0 ) then
		new_pos = 0
	end
	
	return uid, new_pos/length
end

function new_side_clicker( gui, uid, char_x, char_y, pic_x, pic_y, pic_z, icon )
	local value = 0
	local pic = "mods/Noita40K/files/pics/gui_gfx/button_side.png"
	
	uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z, pic )
	if( clicked ) then
		GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/ui/holo_button", char_x, char_y )
		value = -1
	elseif( r_clicked ) then
		GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/ui/holo_button", char_x, char_y ) --stronger
		value = -5
	end
	
	pic_x = pic_x + 6
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, icon )
	
	pic_x = pic_x + 17
	uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z, pic )
	if( clicked ) then
		GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/ui/holo_button", char_x, char_y )
		value = 1
	elseif( r_clicked ) then
		GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/ui/holo_button", char_x, char_y ) --stronger
		value = 5
	end
	
	return uid, value
end

function new_tooltip( gui, uid, text )
	local pic_z = -100
	
	local _, _, t_hov = GuiGetPreviousWidgetInfo( gui )
	if( t_hov and ModSettingGetNextValue( "Noita40K.UI_MODE" ) < 3 ) then
		local w, h = GuiGetScreenDimensions( gui )
		local pic_x, pic_y = get_mouse_pos( gui )
		pic_x = pic_x + 5
		
		local out_str = {}
		if( text ~= nil ) then
			if( type( text ) == "table" ) then
				out_str = text
			else
				table.insert( out_str, text )
			end
		else
			table.insert( out_str, "[NIL]" )
		end
		
		local max_length = 0
		for i,line in ipairs( out_str ) do
			local length = GuiGetTextDimensions( gui, line, 1, 1 ) + 1
			if( length > max_length ) then
				max_length = length
			end
		end
		
		if( w < pic_x + max_length + 11 ) then
			pic_x = pic_x - ( max_length + 19 )
		end
		if( h < pic_y + 8 ) then
			pic_y = h - 8
		end
		
		local counter = 0
		for i,line in ipairs( out_str ) do
			if( line ~= "" and line ~= " " and line ~= nil ) then
				if( counter > 0 ) then
					uid = new_image( gui, uid, pic_x + 2, pic_y + counter*9 - 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_red_dark.png" )
					uid = new_image( gui, uid, pic_x + max_length + 7, pic_y + counter*9 - 1, pic_z + 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_gray_bright.png" )
				end
				
				uid = window_tiny( gui, uid, pic_x, pic_y + counter*9, pic_z + 0.01, max_length, ( counter == 0 ) and "A" or "B" )
				
				counter = counter + 1
			end
		end
		
		new_text( gui, pic_x + 6, pic_y - 1, pic_z, text, { 195, 3, 3, 1, } )
	end
	
	return uid
end

function new_tutorial_tooltip( gui, uid, text )
	if( ModSettingGetNextValue( "Noita40K.UI_MODE" ) == 1 ) then
		uid = new_tooltip( gui, uid, paragrapher( nil, text, 200, 100, 3.9 ))
	end
	
	return uid
end

function new_high_gothic( gui, uid, pic_x, pic_y, pic_z, text, colours )
	for ltr in string.gmatch( text, "." ) do
		if( ltr ~= "_" ) then
			local path = ltr
			if( string.upper( ltr ) ~= ltr ) then
				path = "lower/"..path
			end
			
			if( colours ~= nil ) then
				GuiColorSetForNextWidget( gui, colours[1]/255, colours[2]/255, colours[3]/255, colours[4] )
			end
			
			local pic = "mods/Noita40K/files/pics/gothic_font/"..path..".png"
			uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1, 1 )
			local pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
			pic_x = pic_x + pic_w + 1
		else
			pic_x = pic_x + 5
		end
	end
	
	return uid
end

function new_notification( title, desc, use_sound )
	ModSettingSetNextValue( "Noita40K.NOTE_INFO", ModSettingGetNextValue( "Noita40K.NOTE_INFO" )..title..":"..desc..":"..b2n( use_sound == nil and true or use_sound )..":|", false )
end

function simple_frame( gui, uid, pic_x, pic_y, pic_z, width, height, color )
	color = color or { 255, 255, 255 }
	color[1] = color[1]/255
	color[2] = color[2]/255
	color[3] = color[3]/255
	
	local pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_white.png"
	
	GuiColorSetForNextWidget( gui, color[1], color[2], color[3], 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, width - 1, 1 )
	
	pic_x = pic_x + width - 1
	GuiColorSetForNextWidget( gui, color[1], color[2], color[3], 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1, height - 1 )
	
	pic_x = pic_x - width + 2
	pic_y = pic_y + height - 1
	GuiColorSetForNextWidget( gui, color[1], color[2], color[3], 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, width - 1, 1 )
	
	pic_x = pic_x - 1
	pic_y = pic_y - height + 2
	GuiColorSetForNextWidget( gui, color[1], color[2], color[3], 1 )
	uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1, height - 1 )
	
	return uid
end

-- function pie_menu( gui, uid, pic_x, pic_y, pic_z, pics, current )
-- end

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