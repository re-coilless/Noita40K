dofile_once( "data/scripts/lib/utilities.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )

function shot_controller( mag_id )
	local wse_id = GameGetWorldStateEntity()
	if( wse_id ~= 0 and wse_id ~= nil ) then
		GlobalsSetValue( "MAG_SYSTEM_SHOT_THIS_FRAME", GlobalsGetValue( "MAG_SYSTEM_SHOT_THIS_FRAME", "" )..mag_id.."|" )
	end
end

function was_shot( mag_id )
	local shot_table = D_extractor( GlobalsGetValue( "MAG_SYSTEM_SHOT_THIS_FRAME", "" ), true )
	
	for i,shot_id in ipairs( shot_table ) do
		if( mag_id == shot_id ) then
			return true
		end
	end
	
	return false
end

function update_gun( wand_id )
	local inv_comp = EntityGetFirstComponentIncludingDisabled( EntityGetParent( EntityGetParent( wand_id )), "Inventory2Component" )
	ComponentSetValue2( inv_comp, "mActualActiveItem", 0 )
end

function get_mags( wand_id )
	local sorted_children = {}
	
	local children = EntityGetAllChildren( wand_id ) or {}
	if( #children > 0 ) then
		local custom_sort = true
		for i,mag in ipairs( children ) do
			if( EntityHasTag( mag, "mag" )) then
				local index = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "ItemComponent" ), "inventory_slot" ) + 1
				if( sorted_children[index] == nil ) then
					sorted_children[index] = mag
				else
					sorted_children = {}
					for e,mag_id in ipairs( children ) do
						if( EntityHasTag( mag_id, "mag" )) then
							table.insert( sorted_children, mag_id )
						end
					end
					table.sort( sorted_children )
					custom_sort = false
					break
				end
			end
		end
		if( custom_sort ) then
			local tmp = {}
			for i,id in pairs( sorted_children ) do
				if( #tmp > 0 ) then
					local done = false
					for e,value in ipairs( tmp ) do
						if( i < value[1] ) then
							table.insert( tmp, e, { i,id })
							done = true
							break
						end
					end
					if( not( done )) then
						table.insert( tmp, { i,id })
					end
				else
					table.insert( tmp, { i,id })
				end
			end
			sorted_children = {}
			for i,value in ipairs( tmp ) do
				table.insert( sorted_children, value[2] )
			end
		end
	end
	
	return sorted_children
end

function get_reload_state( wand_id )
	local mags = get_mags( wand_id )
	if( #mags > 0 ) then
		for i,mag in ipairs( mags ) do
			if( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "reload_end" ), "value_int" ) > GameGetFrameNum()) then
				return false
			end
		end
	end
	
	return true
end

function mag_switcher( wand_id, ctrl_comp, mags )
	local RMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownRightClick" )
	
	if( RMB_down and not( GameIsInventoryOpen())) then
		if( not( RMB_pressed ) and #mags > 0 ) then
			for i,mag in ipairs( mags ) do
				local storage_mode = EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "mode" )
				if( storage_mode ~= nil ) then
					local mode = ComponentGetValue2( storage_mode, "value_bool" )
					
					local act_id = 0
					if( mode ) then
						act_id = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "state1" ), "value_string" )
					else
						act_id = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "state2" ), "value_string" )
					end
					ComponentSetValue2( storage_mode, "value_bool", not( mode ))
					
					local act_comp = EntityGetFirstComponentIncludingDisabled( mag, "ItemActionComponent" )
					ComponentSetValue2( act_comp, "action_id", act_id )
					update_gun( wand_id )
					
					local sprite_comp = EntityGetFirstComponentIncludingDisabled( mag, "SpriteComponent", "item_identified" )
					ComponentSetValue2( sprite_comp, "image_file", get_action_with_id( act_id ).sprite )
					EntityRefreshSprite( mag, sprite_comp )
					
					local x, y = EntityGetTransform( wand_id )
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/switch", x, y )
				end
			end
		end
		RMB_pressed = true
	else
		RMB_pressed = false
	end
end

function mag_controller( wand_id, abil_comp, frame_num, mags, comp_tag )
	local x, y, r, s_x, s_y = EntityGetTransform( wand_id )
	
	local fire_frame = ComponentGetValue2( abil_comp, "mCastDelayStartFrame" )
	local ejector_storage = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "ejector_info" )
	local ejector_info = {}
	if( ejector_storage ~= nil ) then
		ejector_info = D_extractor( ComponentGetValue2( ejector_storage, "value_string" ))
		ejector_info[1] = math.rad( ejector_info[1] )
		SetRandomSeed( frame_num, x + y + fire_frame )
		table.insert( ejector_info, Random( 1, 19 ))
	end
	
	if( fire_frame == frame_num ) then
		if( #mags > 0 ) then
			for i,mag in ipairs( mags ) do
				local is_reloading = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "is_reloading" ), "value_bool" )
				if( not( is_reloading )) then
					local item_comp = EntityGetFirstComponentIncludingDisabled( mag, "ItemComponent" )
					local act_comp = EntityGetFirstComponentIncludingDisabled( mag, "ItemActionComponent" )
					if( was_shot( ComponentGetValue2( act_comp, "action_id" ).."."..ComponentGetValue2( item_comp, "mItemUid" ))) then
						if( comp_tag ~= nil ) then
							EntityRefreshSprite( wand_id, EntityGetFirstComponentIncludingDisabled( wand_id, "SpriteComponent", comp_tag ))
							local sound_storage = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "cycle_sound" )
							if( sound_storage ~= nil ) then
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", ComponentGetValue2( sound_storage, "value_string" ), x, y )
							end
						end
						
						local current_storage = EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "ammo_current" )
						local ammo_current = ComponentGetValue2( current_storage, "value_int" )
						if( ammo_current > 0 ) then
							ComponentSetValue2( current_storage, "value_int", ammo_current - 1 )
						end
						
						if( ejector_storage ~= nil ) then
							local casing_storage = EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "casing_info" )
							if( casing_storage ~= nil ) then
								local casing_info = D_extractor( ComponentGetValue2( casing_storage, "value_string" ), true )
								
								local actual_angle = -get_sign( s_y )*ejector_info[1] + r
								local e_x = x + math.cos( actual_angle )*ejector_info[2]
								local e_y = y + math.sin( actual_angle )*ejector_info[2]
								local force_damper = tonumber( casing_info[2] )
								if( casing_info[1] == "1" ) then
									local casing_entity = EntityLoad( casing_info[3], e_x, e_y )
									EntityApplyTransform( casing_entity, e_x, e_y, r )
									PhysicsApplyForce( casing_entity, -math.cos( r + get_sign( s_y )*math.abs( 45 ))*force_damper, math.sin( r - get_sign( s_y )*math.abs( 45 ))*force_damper - i )
									PhysicsApplyTorque( casing_entity, force_damper/5 )
								else
									local char_vel_x, char_vel_y = 0, 0
									local data_comp = EntityGetFirstComponentIncludingDisabled( EntityGetRootEntity( wand_id ), "CharacterDataComponent" )
									if( data_comp ~= nil ) then
										char_vel_x, char_vel_y = ComponentGetValueVector2( data_comp, "mVelocity" )
										if( math.floor( char_vel_y ) > 1 ) then
											char_vel_y = char_vel_y - 60
										end
									end
									local v_x = -( math.cos( r + get_sign( s_y )*math.abs( 45 )) + frame_num%ejector_info[3]/30 )*force_damper + char_vel_x
									local v_y = math.sin( r - get_sign( s_y )*math.abs( 45 ))*force_damper - i*force_damper/20 + char_vel_y
									shoot_projectile( 0, casing_info[3], e_x, e_y, v_x, v_y )
								end
							end
						end
					end
				end
			end
		end
	end
end

function mag_reloader( wand_id, abil_comp, frame_num, ctrl_comp, mags )
	local x, y = EntityGetTransform( wand_id )

	local USE_down = ComponentGetValue2( ctrl_comp, "mButtonDownInteract" )
	local DOWN_down = ComponentGetValue2( ctrl_comp, "mButtonDownDown" )
	
	local manual_reload = false
	
	if( USE_down ) then
		if( not( DOWN_down or USE_pressed )) then
			if( tap_frame == nil ) then
				tap_frame = 0
			end
			
			local delay = frame_num - tap_frame
			if( delay <= 20 ) then
				manual_reload = true
			end
			
			tap_frame = frame_num
		end
		USE_pressed = true
	else
		USE_pressed = false
	end
	
	if( #mags > 0 ) then
		for i,mag in ipairs( mags ) do
			local reloading_storage = EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "is_reloading" )
			local end_storage = EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "reload_end" )
			local max_storage = EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "ammo_max" )
			local current_storage = EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "ammo_current" )
			
			local is_reloading = ComponentGetValue2( reloading_storage, "value_bool" )
			local ammo_max = ComponentGetValue2( max_storage, "value_int" )
			local ammo_left = ComponentGetValue2( current_storage, "value_int" )
			if( ammo_left > -1 ) then
				if( is_reloading and not( manual_reload )) then
					local reload_frame = ComponentGetValue2( abil_comp, "mNextFrameUsable" )
					if( reload_frame <= frame_num + 1 ) then
						ComponentSetValue2( abil_comp, "mNextFrameUsable", frame_num + 2 )
					end
					
					local reload_end = ComponentGetValue2( end_storage, "value_int" )
					if( reload_end <= frame_num ) then
						ComponentSetValue2( reloading_storage, "value_bool", false )
						GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/reloads/bolt_reload_end", x, y )
					end
				elseif( ammo_left < 1 or ( not( is_reloading ) and manual_reload and ammo_left ~= ammo_max and EntityHasTag( EntityGetRootEntity( wand_id ), "player_unit" ))) then
					local reload_time = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "reload_time" ), "value_int" )
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/reloads/bolt_reload_start", x, y )
					ComponentSetValue2( reloading_storage, "value_bool", true )
					ComponentSetValue2( end_storage, "value_int", frame_num + reload_time )
					ComponentSetValue2( current_storage, "value_int", ammo_max )
					
					if( not( manual_reload )) then
						break
					end
				end
			end
		end
	end
end

function mag_gui( wand_id, frame_num, mags )
	local hooman = EntityGetRootEntity( wand_id )
	if( not( GameIsInventoryOpen()) and EntityHasTag( hooman, "player_unit" )) then
		local gui = GuiCreate()
		GuiStartFrame( gui )
		
		local w, h = GuiGetScreenDimensions( gui )
		
		local lefted_offset = 0
		if( EntityHasTag( wand_id, "is_lefted" )) then
			lefted_offset = 30
		end
		
		local extra_offset = lefted_offset
		if( GameHasFlagRun( "PERK_PICKED_ETERNAL_VIGILANCE" )) then
			if( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "show_infer" ), "value_bool" )) then
				extra_offset = extra_offset + 137
			end
		end
		
		local is_tl = EntityHasTag( hooman, "twin_linked" )
		if( #mags > 0 ) then
			local h_offset = 0
			for i,mag in ipairs( mags ) do
				local pic_tag = "pic"
				local storage_mode = EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "mode" )
				if( storage_mode ~= nil ) then
					if( ComponentGetValue2( storage_mode, "value_bool" )) then
						pic_tag = "pic_alt"
					end
				end
				local pic = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", pic_tag ), "value_string" )
				local pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
				
				local is_reloading = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "is_reloading" ), "value_bool" )
				local ammo = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "ammo_current" ), "value_int" )
				if( is_reloading ) then
					local reload_time = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "reload_time" ), "value_int" )
					local reload_left = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "reload_end" ), "value_int" ) - frame_num
					local reload_ratio = math.floor( reload_left/reload_time*100 )
					
					local text = "["
					for e = 1,5 do
						if( reload_ratio >= 20*e ) then
							text = text..( is_tl and "." or "_" )
						else
							text = text..( is_tl and "l" or "X" )
						end
					end
					text = text.."]"
					
					local text_w, text_h = GuiGetTextDimensions( gui, text, 1, 1 )
					local pos_x = w - text_w - 2
					local pos_y = h - ( text_h + h_offset ) - 2
					
					new_text( gui, pos_x - extra_offset, pos_y, -0.1, text )
				elseif( ammo < 0 ) then
					local text = "[INF]"
					local text_w, text_h = GuiGetTextDimensions( gui, text, 1, 1 )
					local pos_x = w - text_w - 2
					local pos_y = h - ( text_h + h_offset ) - 2
					
					new_text( gui, pos_x - extra_offset, pos_y, -0.1, text )
				elseif( ammo < 1 ) then
					local text = is_tl and "[_]" or "[EMPTY]"
					local text_w, text_h = GuiGetTextDimensions( gui, text, 1, 1 )
					local pos_x = w - text_w - 2
					local pos_y = h - ( text_h + h_offset ) - 2
					
					new_text( gui, pos_x - extra_offset, pos_y, -0.1, text )
				elseif( ammo <= math.floor( ModSettingGetNextValue( "Noita40K.MAX_AMMO_SHOWN_FULL" ) + 0.5 )*5 and extra_offset == 0 and not( is_tl )) then					
					local step = 1 + pic_w
					local pos_x = w - pic_w - 2
					local pos_y = h - ( pic_h + h_offset ) - 2
					
					new_image( gui, 1, pos_x - extra_offset, pos_y, -0.1, pic )
					for e = 2,ammo do
						new_image( gui, e, pos_x - step*( e - 1 ) - extra_offset, pos_y, -0.1, pic )
					end
				else
					local text_w, text_h = GuiGetTextDimensions( gui, ammo.."X", 1, 1 )
					local pos_x = w - pic_w
					local pos_y = h - 2
					
					new_text( gui, pos_x - text_w - 2 - extra_offset, pos_y - ( text_h + h_offset ), -0.1, ammo.."X" )
					new_image( gui, 1, pos_x - 2 - extra_offset, pos_y - ( pic_h + h_offset ), -0.1, pic )
				end
				
				h_offset = h_offset + pic_h + 1
			end
		end

		GuiDestroy( gui )
	end
end