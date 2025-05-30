dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )

if( not( GameIsInventoryOpen())) then
	local hooman = GetUpdatedEntityID()
	
	if( gui == nil ) then
		gui = GuiCreate()
	end
	GuiStartFrame( gui )
	
	local clicked, r_clicked, hovered, pic_x, pic_y, pic_z = 0, 0, 0, 0, 0
	local pic, pic_w, pic_h = 0, 0, 0
	local uid = 0
	local energy_percent = 0
	local wand_state_matrix = { { ready = 0, handed = 0}, { ready = 0, handed = 0}, { ready = 0, handed = 0}, { ready = 0, handed = 0}, }
	local entity_scanner_offset = 0
	
	local frame_num = GameGetFrameNum()
	local w, h = GuiGetScreenDimensions( gui )
	local char_x, char_y = EntityGetTransform( hooman )
	
	local ui_mode_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "explorator_mode" )
	local dendrite_state_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "dendrites_active" )
	local infer_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "show_infer" )
	local consoler_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "show_console" )
	local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
	local health_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
	local captured_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "captured_entity" )
	local waypoint_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "waypoint" )
	
	local explorator_mode = ComponentGetValue2( ui_mode_storage, "value_bool" )
	local show_infer = ComponentGetValue2( infer_storage, "value_bool" )
	local show_console = ComponentGetValue2( consoler_storage, "value_bool" )
	local current_hp = ComponentGetValue2( health_comp, "hp" )
	local captured_entity = ComponentGetValue2( captured_storage, "value_int" )
	local current_waypoint = ComponentGetValue2( waypoint_storage, "value_string" )
	
	pic_z = -1
	
	function mode_controller()
		pic = "mods/Noita40K/files/pics/gui_gfx/ui_mode_button_off.png"
		if( explorator_mode ) then
			pic = "mods/Noita40K/files/pics/gui_gfx/ui_mode_button_on.png"
		end
		uid, clicked, r_clicked = new_button( gui, uid, 1, 18, pic_z, pic )
		if( clicked ) then
			if( explorator_mode ) then
				GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/exp_mode_off", char_x, char_y )
				new_console_entry( hooman, "[COMBAT_MODE]", 0 )
				ComponentSetValue2( ui_mode_storage, "value_bool", false )
			else
				GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/exp_mode_on", char_x, char_y )
				new_console_entry( hooman, "[EXPLORATOR_MODE]", 0 )
				ComponentSetValue2( ui_mode_storage, "value_bool", true )
			end
		end
	end
	
	function dendrites_controller()
		local dendrites_active = ComponentGetValue2( dendrite_state_storage, "value_bool" )
		
		pic = "mods/Noita40K/files/pics/gui_gfx/dendrite_state_button_B.png"
		if( dendrites_active ) then
			pic = "mods/Noita40K/files/pics/gui_gfx/dendrite_state_button_A.png"
		end
		uid, clicked, r_clicked = new_button( gui, uid, 1, 41, pic_z, pic )
		if( clicked ) then
			if( dendrites_active ) then
				GamePlayAnimation( hooman, "move_item", 100 )
				GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/forward", char_x, char_y )
				new_console_entry( hooman, "[SUPPORTS_DISABLED]", 0 )
				ComponentSetValue2( dendrite_state_storage, "value_bool", false )
			else
				GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/forward", char_x, char_y )
				new_console_entry( hooman, "[SUPPORTS_ENGAGED]", 0 )
				ComponentSetValue2( dendrite_state_storage, "value_bool", true )
			end
		end
	end
	
	function energy_state()
		local storage_energy_cap = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "energy_cap" )
		local storage_energy_cur = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "energy_cur" )
		local energy_cap = ComponentGetValue2( storage_energy_cap, "value_float" )
		local energy_cur = ComponentGetValue2( storage_energy_cur, "value_float" )
		
		pic = "mods/Noita40K/files/pics/gui_gfx/energy_system_state.png"
		uid = new_image( gui, uid, 21, 41, pic_z - 0.1, pic )
		clicked, r_clicked, hovered, pic_x, pic_y = GuiGetPreviousWidgetInfo( gui )
		
		energy_percent = energy_cur/energy_cap
		if( energy_percent > 0 ) then
			uid = uid + 1
			GuiIdPush( gui, uid )	
			uid = uid + 1		
			GuiIdPush( gui, uid )
			if( energy_percent < 1 ) then
				local filler_pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_energy_blue.png"
				if( energy_percent >= 0.78 ) then
					filler_pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_energy_yellow.png"
				end
				
				GuiZSetForNextWidget( gui, pic_z )
				GuiImage( gui, uid - 1, pic_x + 8, pic_y + 125, filler_pic, 1, 0.83, 1 )
				GuiZSetForNextWidget( gui, pic_z )
				GuiImage( gui, uid, pic_x + 7, pic_y + 125 - 107*energy_percent, filler_pic, 1, 1, 107*energy_percent )
			else
				GuiZSetForNextWidget( gui, pic_z )
				GuiImage( gui, uid - 1, pic_x + 8, pic_y + 125, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_energy_red.png", 1, 0.83, 1 )
				GuiZSetForNextWidget( gui, pic_z )
				GuiImage( gui, uid, pic_x + 7, pic_y + 18, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_energy_red.png", 1, 1, 107 )
			end
		end
	end
	
	function wand_state()
		local inventory = 0
		local children = EntityGetAllChildren( hooman ) or {}
		if( #children > 0 ) then
			for i,inv in ipairs( children ) do
				if( EntityGetName( inv ) == "inventory_quick" ) then
					inventory = inv
					break
				end
			end
		end
		
		children = EntityGetAllChildren( inventory ) or {}
		if( #children > 0 ) then
			for e,wand_id in ipairs( children ) do
				if( EntityHasTag( wand_id, "wand" ) or EntityHasTag( wand_id, "custom_wand" )) then
					local item_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "ItemComponent" )
					local inv_slot_x, inv_slot_y = ComponentGetValue2( item_comp, "inventory_slot" )
					
					if( inv_slot_x < 4 and inv_slot_y == 0 ) then
						local mag_reloaded = true
						if( EntityHasTag( wand_id, "mag_gun" )) then
							dofile_once( "mods/Noita40K/files/scripts/libs/mag_system.lua" )
							mag_reloaded = get_reload_state( wand_id )
						end
						
						local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
						local reload_frame = ComponentGetValue2( abil_comp, "mReloadNextFrameUsable" )
						local delay_frame = ComponentGetValue2( abil_comp, "mNextFrameUsable" )
						
						if( reload_frame < frame_num and delay_frame <= frame_num and mag_reloaded ) then
							wand_state_matrix[inv_slot_x + 1].ready = 1
						end
						
						local handed = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "Inventory2Component" ), "mActiveItem" )
						if( tonumber( wand_id ) == tonumber( handed )) then
							wand_state_matrix[inv_slot_x + 1].handed = 1
						end
					end
				end
			end
		end
		
		pic = "mods/Noita40K/files/pics/gui_gfx/wand_status.png"
		pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
		for k,wand in ipairs( wand_state_matrix ) do
			if( wand.handed == 1 ) then
				pic = "mods/Noita40K/files/pics/gui_gfx/wand_status_full.png"
			else
				pic = "mods/Noita40K/files/pics/gui_gfx/wand_status.png"
			end
			
			local extra_offset = MagicNumbersGetValue( "UI_QUICKBAR_OFFSET_X" )
			uid = new_image( gui, uid, ( 20 + extra_offset ) + ( k - 1 )*( pic_w + 2 ), 17, -0.1, pic )
			clicked, r_clicked, hovered, pic_x, pic_y = GuiGetPreviousWidgetInfo( gui )
			
			if( wand.ready ~= 1 ) then
				pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_energy_red.png"
				uid = new_image( gui, uid, pic_x + 1, pic_y + 2, 0, pic, 1.33334, 2 )
			end
		end
	end
	
	function global_info()
		pic_x = w - 138
		pic_y = h - 20
		uid = window_small( gui, uid, pic_x, pic_y, pic_z, 120, "C" )
		
		pic_x = pic_x + 9
		pic_y = pic_y - 0.5
		new_text( gui, pic_x, pic_y, pic_z - 0.1, "x: "..shorten_number( char_x, 5 ))
		pic_y = pic_y + 7
		new_text( gui, pic_x, pic_y, pic_z - 0.1, "y: "..shorten_number( char_y, 5 ))
		
		pic_x = pic_x + 45
		new_text( gui, pic_x, pic_y, pic_z - 0.1, "k: "..StatsGetValue( "enemies_killed" ))
		
		local char_vel_x, char_vel_y = ComponentGetValueVector2( EntityGetFirstComponentIncludingDisabled( hooman, "CharacterDataComponent" ), "mVelocity" )
		if( dendrite_state_storage == nil or not( ComponentGetValue2( dendrite_state_storage, "value_bool" ))) then
			char_vel_y = char_vel_y - 60
		end
		local char_v = math.floor( math.sqrt( char_vel_x^2 + char_vel_y^2 )/6 + 0.5 )/10.0
		pic_y = pic_y - 7
		new_text( gui, pic_x, pic_y, pic_z - 0.1, "v: "..char_v )
		
		local threat_level = math.floor( get_threat_level( hooman, true ) + 0.5 )
		pic_x = pic_x + 30
		new_text( gui, pic_x, pic_y, pic_z - 0.1, "TL: "..K_number( threat_level, 1 ))
		
		local f_energy = 0.7 + 12.3*( energy_percent - 0.02) - 62.4*( energy_percent + 0.04 )^2 + 103*( energy_percent + 0.04 )^3 - 52.9*( energy_percent + 0.04 )^4
		local f_hp = 2*( 1.0515 - 1.052*math.exp( -0.193*current_hp ))
		local f_wsm = ( 6 + ( wand_state_matrix[1].ready + wand_state_matrix[2].ready + wand_state_matrix[3].ready + wand_state_matrix[4].ready ))/10
		local f_threat = 1/( math.sqrt( threat_level/100 ) + 1 )
		
		local success_chance = math.floor( 100*f_hp*f_energy*f_wsm*f_threat + 0.5 )
		
		if( success_chance < 0 ) then
			success_chance = 0
		end
		pic_y = pic_y + 7
		new_text( gui, pic_x, pic_y, pic_z - 0.1, "SC: "..K_number( success_chance, 0 ).."%" )
	end
	
	function captured_pointer()
		local ce_x, ce_y, ce_rotation, ce_scale_x, ce_scale_y = EntityGetTransform( captured_entity )
		local cam_x, cam_y = GameGetCameraPos()
		
		local ced_x = ce_x - cam_x
		local ced_y = ce_y - cam_y
		local ce_distance = math.sqrt(( ced_x )^2 + ( ced_y )^2 )
		if( ce_distance < 250 ) then
			pic = "mods/Noita40K/files/pics/gui_gfx/mark_capture.png"
			pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1.5 )
			
			local shit_from_ass = w/( MagicNumbersGetValue( "VIRTUAL_RESOLUTION_X" ) + MagicNumbersGetValue( "VIRTUAL_RESOLUTION_OFFSET_X" ))
			pic_x = w/2 + ( shit_from_ass*ced_x - pic_w/2 )
			pic_y = h/2 + ( shit_from_ass*ced_y - pic_h/2 )
			uid = new_image( gui, uid, pic_x, pic_y, pic_z + 0.01, pic, 1.5, 1.5 )
			
			local corner_coeff = pic_w/2
			local corners = { corner_coeff, corner_coeff, -corner_coeff, -corner_coeff }
			local hb_values = { "max_x", "max_y", "min_x", "min_y" }
			local ce_hitbox_comp = EntityGetFirstComponentIncludingDisabled( captured_entity, "HitboxComponent" )
			if( ce_hitbox_comp ~= nil ) then
				for i = 1,4 do
					local hostage = shit_from_ass*ComponentGetValue2( ce_hitbox_comp, "aabb_"..hb_values[i] )
					if( math.abs( hostage ) < corner_coeff ) then
						corners[i] = get_sign( corners[i] )*corner_coeff
					else
						corners[i] = hostage
					end
				end
				
				if( ce_scale_x < 0 ) then
					local temp = corners[1]
					corners[1] = corners[3]
					corners[3] = temp
				end
			end
			
			pic = "mods/Noita40K/files/pics/gui_gfx/mark_capture_corner.png"
			pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1.5 )
			
			pic_x = pic_x + corner_coeff
			pic_y = pic_y + corner_coeff
			
			uid = new_image( gui, uid, pic_x + corners[1] - pic_w/2, pic_y + corners[2] - pic_h/2, pic_z + 0.01, pic, 1.5, 1.5 )
			uid = new_image( gui, uid, pic_x + corners[3] - pic_w/2, pic_y + corners[2] - pic_h/2, pic_z + 0.01, pic, 1.5, 1.5 )
			uid = new_image( gui, uid, pic_x + corners[3] - pic_w/2, pic_y + corners[4] - pic_h/2, pic_z + 0.01, pic, 1.5, 1.5 )
			uid = new_image( gui, uid, pic_x + corners[1] - pic_w/2, pic_y + corners[4] - pic_h/2, pic_z + 0.01, pic, 1.5, 1.5 )
		end
	end
	
	function anomaly_detector()
		local max_hp = ComponentGetValue2( health_comp, "max_hp" )
		if( max_hp < 4 ) then
			max_hp = 4
		end
		local hp_offset = math.floor( 82.6 - 61.3/2.5^( max_hp/9 ))
		
		pic = "mods/Noita40K/files/pics/gui_gfx/basic_radar.png"
		pic_x = w - ( 80 + hp_offset )
		pic_y = 20
		uid = new_image( gui, uid, pic_x, pic_y, pic_z - 0.02, pic )
		
		entity_scanner_offset = pic_x
		
		local high_anomalies = { "orb", "essence", "item_perk", "portal", "this_is_sampo" }
		local normal_anomalies = { "wand", "custom_wand", "card_action" }
		local low_anomalies = { "item_physics", "item_pickup", "tablet" }
		local database = {{ tags = high_anomalies, radius = 1000, power = 50 }, { tags = normal_anomalies, radius = 500, power = 20 }, { tags = low_anomalies, radius = 300, power = 10 }}
		
		local quarter_power = { tr = 0, br = 0, bl = 0, tl = 0 }
		
		local p_hitbox_offset = get_head_offset( hooman )
		
		for i,anomaly_type in ipairs( database ) do
			local anomalies = {}
			for e,anomaly_tag in ipairs( anomaly_type.tags ) do
				local targets = EntityGetInRadiusWithTag( char_x, char_y + p_hitbox_offset, anomaly_type.radius, anomaly_tag ) or {}
				anomalies = add_table( anomalies, targets )
			end
			
			for k,anomaly in ipairs( anomalies ) do
				if( anomaly == EntityGetRootEntity( anomaly ) and not( EntityHasTag( anomaly, "gold_nugget" ))) then
					local a_x, a_y = EntityGetTransform( anomaly )
					a_x = a_x - char_x
					a_y = a_y - ( char_y + p_hitbox_offset )
					
					local distance = math.sqrt(( a_x )^2 + ( a_y )^2)
					local f_distance = 0.0126 + ( 1.3014 - 0.013 )/( 1 + ( distance/381.46 )^1.84 )
					
					if( a_x >= 0 and a_y > 0 ) then
						quarter_power.br = quarter_power.br + anomaly_type.power*f_distance
					elseif( a_x > 0 and a_y <= 0 ) then
						quarter_power.tr = quarter_power.tr + anomaly_type.power*f_distance
					elseif( a_x <= 0 and a_y < 0) then
						quarter_power.tl = quarter_power.tl + anomaly_type.power*f_distance
					else
						quarter_power.bl = quarter_power.bl + anomaly_type.power*f_distance
					end
				end
			end
			
			function anomalies:tableKiller()
				self = nil
			end
		end
		
		pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_energy_green.png"
		pic_x = pic_x + 1
		pic_y = pic_y + 1
		uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1.25, 15, quarter_power.tl/100 )
		pic_x = pic_x + 19
		uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1.25, 15, quarter_power.tr/100 )
		pic_y = pic_y + 19
		uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1.25, 15, quarter_power.br/100 )
		pic_x = pic_x - 19
		uid = new_image( gui, uid, pic_x, pic_y, pic_z, pic, 1.25, 15, quarter_power.bl/100 )
		
		if( captured_entity ~= 0 ) then
			local ce_x, ce_y = EntityGetTransform( captured_entity )
			local t1 = pic_x
			local t2 = pic_y
			ce_x = ce_x - char_x
			ce_y = ce_y - char_y
			
			if( ce_x >= 0 and ce_y > 0 ) then
				t1 = t1 + 19
			elseif( ce_x > 0 and ce_y <= 0 ) then
				t2 = t2 - 19
				t1 = t1 + 19
			elseif( ce_x <= 0 and ce_y < 0) then
				t2 = t2 - 19
			end
			
			pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_energy_red.png"
			uid = new_image( gui, uid, t1, t2, pic_z - 0.01, pic, 1.25, 15, 0.5 )
		end
		
		if( current_waypoint ~= "|" ) then
			local waypoint_pos = D_extractor( current_waypoint )
			local t1 = pic_x
			local t2 = pic_y
			waypoint_pos[1] = waypoint_pos[1] - char_x
			waypoint_pos[2] = waypoint_pos[2] - char_y
			
			if( waypoint_pos[1] >= 0 and waypoint_pos[2] > 0 ) then
				t1 = t1 + 19
			elseif( waypoint_pos[1] > 0 and waypoint_pos[2] <= 0 ) then
				t2 = t2 - 19
				t1 = t1 + 19
			elseif( waypoint_pos[1] <= 0 and waypoint_pos[2] < 0) then
				t2 = t2 - 19
			end
			
			pic = "mods/Noita40K/files/pics/gui_gfx/fillers/filler_energy_blue.png"
			uid = new_image( gui, uid, t1, t2, pic_z - 0.011, pic, 1.25, 15, 0.5 )
		end
	end
	
	function entity_scanner()
		pic_x = entity_scanner_offset - 245
		pic_y = 20
		uid = window_normal( gui, uid, pic_x, pic_y, pic_z, 220, 10, 1 )
		
		local t_s = math.floor( GameGetRealWorldTimeSinceStarted() )
		local t_m = math.floor( t_s/60 )
		local t_h = math.floor( t_m/60 )
		local s_h = tostring( t_h )
		local s_m = tostring( t_m - t_h*60 )
		local s_s = tostring( t_s - t_m*60 )
		if( tonumber( s_h ) < 10 ) then
			s_h = "0"..s_h
		end
		if( tonumber( s_m ) < 10 ) then
			s_m = "0"..s_m
		end
		if( tonumber( s_s ) < 10 ) then
			s_s = "0"..s_s
		end
		pic_x = pic_x + 20
		pic_y = pic_y + 2
		new_text( gui, pic_x, pic_y, pic_z - 0.1, "t: "..s_h..":"..s_m..":"..s_s )
		
		local DOWN_down = ComponentGetValue2( ctrl_comp, "mButtonDownDown" )
		local USE_down = ComponentGetValue2( ctrl_comp, "mButtonDownInteract" )
		local capture_combo = DOWN_down and USE_down
		
		local target_entity = 0
		local t_dist = 0
		if( captured_entity == 0 or capture_combo ) then
			local pointer_x, pointer_y = DEBUG_GetMouseWorld()
			target_entity = EntityGetRootEntity( EntityGetClosest( pointer_x, pointer_y ))
			local t_x, t_y = EntityGetTransform( target_entity )
			t_dist = math.sqrt(( pointer_x - t_x )^2 + ( pointer_y - t_y )^2 )
			
			if( capture_combo ) then
				if( not( capture_activated )) then
					if( t_dist < 10 ) then
						if( target_entity ~= captured_entity ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/capture_mode_on", char_x, char_y )
							new_console_entry( hooman, "Target "..target_entity.." captured.", 0 )
							ComponentSetValue2( captured_storage, "value_int", target_entity )
						end
					else
						GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/capture_mode_off", char_x, char_y )
						new_console_entry( hooman, "Capture mode offline.", 0 )
						ComponentSetValue2( captured_storage, "value_int", 0 )
					end
				end
				capture_activated = true
			end
		else
			target_entity = captured_entity
		end
		
		if( not( capture_combo )) then
			capture_activated = false
		end
		
		function generic_info( gui, pic_x, pic_y, target_entity )
			local target_x, target_y = EntityGetTransform( target_entity )
			local t_name = tostring( EntityGetName( target_entity ))
			
			pic_x = pic_x - 10
			new_text( gui, pic_x, pic_y, pic_z - 0.1, "n: "..string.sub( name_cleaner( t_name ), 1, 20 ))
			
			pic_x = pic_x + 90
			new_text( gui, pic_x, pic_y, pic_z - 0.1, "x: "..shorten_number( target_x, 3 ))
			
			pic_x = pic_x + 40
			new_text( gui, pic_x, pic_y, pic_z - 0.1, "y: "..shorten_number( target_y, 3 ))
		end
		
		pic_x = pic_x + 60
		if( t_dist < 10 ) then
			local value_f = function( comp ) return comp end
			generic_info( gui, pic_x, pic_y, target_entity )
			
			pic_x = pic_x - 70
			pic_y = pic_y + 9
			if( EntityHasTag( target_entity, "mortal" )) then
				local t_damage_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "DamageModelComponent" )
				local t_gene_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "GenomeDataComponent" )
				local t_ai_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "AnimalAIComponent" )
				
				value_f = function( comp ) return K_number( math.floor( ComponentGetValue2( comp, "hp" )*250 + 0.5 )/10.0, 0 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_damage_comp, value_f, "HP" )
				
				pic_y = pic_y + 9
				new_text( gui, pic_x, pic_y, pic_z - 0.1, "TL: "..K_number( math.floor( get_enemy_threat( hooman, target_entity, true )*10 + 0.5 )/10.0, 1 ))
				
				pic_x = pic_x + 50
				value_f = function( comp ) return ComponentGetValue2( comp, "food_chain_rank" ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_gene_comp, value_f, "rnk" )
				
				pic_y = pic_y - 9
				value_f = function( comp ) return math.floor( ComponentGetValue2( comp, "mAggression" ) + 0.5 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_ai_comp, value_f, "agr" )
				
				pic_x = pic_x + 50
				value_f = function( comp ) return string.sub( text_cleaner( HerdIdToString( ComponentGetValue2( comp, "herd_id" ))), 1, 25 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_gene_comp, value_f, "knd" )
				
				pic_y = pic_y + 9
				value_f = function( comp ) return string.sub( text_cleaner( ComponentGetValue2( comp, "blood_material" )), 1, 25 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_damage_comp, value_f, "BM" )
			elseif( EntityHasTag( target_entity, "projectile" )) then
				local t_proj_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "ProjectileComponent" )
				
				value_f = function( comp ) return K_number( math.floor( ComponentGetValue2( comp, "damage" )*250 + 0.5 )/10.0, 0 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_proj_comp, value_f, "d" )
				
				pic_y = pic_y + 9
				new_text( gui, pic_x, pic_y, pic_z - 0.1, "TL: "..K_number( math.floor( get_proj_threat( hooman, target_entity, true )*10 + 0.5 )/10.0, 1 ))
				
				pic_x = pic_x + 50
				value_f = function( comp ) return b2n( ComponentGetValue2( comp, "collide_with_world" )) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_proj_comp, value_f, "hitW" )
				
				pic_y = pic_y - 9
				value_f = function( comp ) return b2n( ComponentGetValue2( comp, "collide_with_entities" )) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_proj_comp, value_f, "hitE" )
				
				pic_x = pic_x + 50
				value_f = function( comp ) return K_number( ComponentGetValue2( comp, "lifetime" ), 0 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_proj_comp, value_f, "LT" )
				
				pic_y = pic_y + 9
				value_f = function( comp ) return string.sub( name_cleaner( ComponentObjectGetValue2( comp, "config", "action_id" )), 1, 25 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_proj_comp, value_f, "ID" )
			elseif( EntityHasTag( target_entity, "wand" ) or EntityHasTag( target_entity, "custom_wand" )) then
				new_text( gui, pic_x, pic_y, pic_z - 0.1, "[ARMAMENT_DETECTED]" )
				
				pic_y = pic_y + 9
				new_text( gui, pic_x, pic_y, pic_z - 0.1, "[  REPORT_IS_READY  ]" )
				
				local SPL = 0
				local spells = EntityGetAllChildren( target_entity ) or {}
				if( #spells > 0 ) then
					for i,spell in ipairs( spells ) do
						if( EntityHasTag( spell, "card_action" )) then
							SPL = SPL + spell_rater( spell, true )
						end
					end
				end
				pic_x = pic_x + 120
				value_f = function( comp ) return K_number( math.floor( comp*10 + 0.5 )/10.0, 2 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, SPL, value_f, "SPL" )
				
				pic_y = pic_y - 9
				value_f = function( comp ) return K_number( math.floor( wand_rater( comp )*100 + 0.5 )/100.0, 2 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, target_entity, value_f, "WPL" )
			elseif( EntityHasTag( target_entity, "card_action" )) then
				local t_act_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "ItemActionComponent" )
				local t_item_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "ItemComponent" )
				
				local action_id = nil
				if( t_act_comp ~= nil ) then
					action_id = ComponentGetValue2( t_act_comp, "action_id" )
				end
				
				local action_data = nil
				if( action_id ~= nil and action_id ~= "" ) then
					action_data = get_action_with_id( action_id )
					uid = new_image( gui, uid, pic_x, pic_y + 1, pic_z - 0.1, action_data.sprite )
				end
				
				pic_x = pic_x + 20
				value_f = function( comp ) return K_number( comp.mana or 0, 0 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, action_data, value_f, "m" )
				
				pic_y = pic_y + 9
				value_f = function( comp ) return K_number( ComponentGetValue2( comp, "uses_remaining" ) or -1, 0 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_item_comp, value_f, "u" )
				
				pic_x = pic_x + 40
				new_text( gui, pic_x, pic_y, pic_z - 0.1, "PL: "..K_number( math.floor( spell_rater( target_entity, false )*10 + 0.5 )/10.0, 1 ))
				
				pic_y = pic_y - 9
				value_f = function( comp ) return string.sub( name_cleaner( comp ), 1, 35 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, action_id, value_f, "ID" )
			elseif( EntityHasTag( target_entity, "item_perk" )) then
				local t_item_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "ItemComponent" )
				local t_sprite_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "SpriteComponent" )
				
				if( t_sprite_comp ~= nil ) then
					uid = new_image( gui, uid, pic_x, pic_y + 1, pic_z - 0.1, ComponentGetValue2( t_sprite_comp, "image_file" ))
				end
				
				pic_x = pic_x + 20
				value_f = function( comp ) return paragrapher( nil, string.sub( GameTextGetTranslatedOrNot( ComponentGetValue2( comp, "ui_description" )), 1, 100 ), 185, 18, 3.7 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_item_comp, value_f, "desc" )
			elseif( EntityHasTag( target_entity, "item_physics" )) then
				local t_item_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "ItemComponent" )
				local t_minv_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "MaterialInventoryComponent" )
					
				if( t_item_comp ~= nil ) then
					if( t_minv_comp ~= nil ) then
						local p_color = GameGetPotionColorUint( target_entity )
						GuiColorSetForNextWidget( gui, bit.band( p_color, 0xff )/255, bit.band( bit.rshift( p_color, 8 ), 0xff )/255, bit.band( bit.rshift( p_color, 16 ), 0xff )/255, 1 )
					end
					uid = new_image( gui, uid, pic_x, pic_y + 1, pic_z - 0.1, ComponentGetValue2( t_item_comp, "ui_sprite" ))
				end
				
				pic_x = pic_x + 20
				value_f = function( comp ) return string.sub( name_cleaner( ComponentGetValue2( comp, "item_name" )), 1, 15 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_item_comp, value_f, "tp" )
				
				pic_y = pic_y + 9
				value_f = function( comp ) return string.sub( GameTextGetTranslatedOrNot( ComponentGetValue2( comp, "ui_description" )), 1, 45 ) end
				new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_item_comp, value_f, "desc" )
				
				if( t_minv_comp ~= nil ) then
					pic_x = pic_x + 70
					pic_y = pic_y - 9
					value_f = function( comp ) return string.sub( name_cleaner( get_matter_inv_name( ComponentGetValue2( comp, "count_per_material_type" ))[1] ), 1, 25 ) end
					new_ecs_text( gui, pic_x, pic_y, pic_z - 0.1, t_minv_comp, value_f, "cnt" )
				end
			else
				local t_tele_comp = EntityGetFirstComponentIncludingDisabled( target_entity, "TeleportComponent" )
			
				if( t_tele_comp ~= nil ) then
					local dest_x, dest_y = ComponentGetValue2( t_tele_comp, "target" )
					
					new_text( gui, pic_x, pic_y, pic_z - 0.1, "[REALITY_BREACH_DETECTED]" )
					
					pic_y = pic_y + 9
					new_text( gui, pic_x, pic_y, pic_z - 0.1, "[ APPROXIMATION_COMPLETED ]" )
					
					pic_x = pic_x + 160
					new_text( gui, pic_x, pic_y, pic_z - 0.1, "dy: "..shorten_number( dest_y, 6 ))
					
					pic_y = pic_y - 9
					new_text( gui, pic_x, pic_y, pic_z - 0.1, "dx: "..shorten_number( dest_x, 6 ))
				else
					local tags = EntityGetTags( target_entity )
					
					if( tags ~= nil and tags ~= "" ) then
						out_str = string.sub( tags, 1, 50 )
					else
						out_str = "[NIL]"
					end
					new_text( gui, pic_x, pic_y, pic_z - 0.1, "tags: "..out_str )
				end
			end
		else
			new_text( gui, pic_x, pic_y, pic_z - 0.1, "[SEARCHING FOR TARGETS]" )
		end
	end
	
	function custom_console()
		pic_x = w - 138
		pic_y = h - 82
		uid = window_normal( gui, uid, pic_x, pic_y, pic_z, 112, 34, 1 )
		
		pic_x = pic_x + 20
		pic_y = pic_y + 2
		local text = "[SHIELD_IS_ONLINE]"
		if( energy_percent <= 0 ) then
			text = "[SHIELD_IS_OFFLINE]"
		elseif( energy_percent > 1 ) then
			text = "[SYSTEM_OVERLOAD]"
		end
		new_text( gui, pic_x, pic_y, pic_z - 0.1, text )
		
		pic_x = pic_x - 10
		pic_y = pic_y + 45
		console_text( gui, pic_x, pic_y, pic_z - 0.1, paragrapher( nil, ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "console_log" ), "value_string" ), 115, 45, 2.3 ))
	end
	
	function servoskull_interface()
		pic_x = 42
		pic_y = 41
		if( ModSettingGetNextValue( "Noita40K.SHOW_PERKS" ) and GameHasFlagRun( "PERK_GUI_EV_MODE" )) then
			pic_y = pic_y + 18
		end
		
		local skull_id = get_tagged_id( "servoskull" )
		local s_x, s_y = EntityGetTransform( skull_id )
		
		local skull_state_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "ss_menu_state" )
		local skull_menu_state = ComponentGetValue2( skull_state_storage, "value_bool" )
		if( not( skull_menu_state )) then
			uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z, "mods/Noita40K/files/pics/gui_gfx/servoskull_button.png" )
			if( clicked ) then
				ComponentSetValue2( skull_state_storage, "value_bool", true )
				GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/menu_open", char_x, char_y )
				new_console_entry( hooman, "Servointerface online.", 0 )
			end
		else
			uid = window_normal( gui, uid, pic_x, pic_y, pic_z, 114, 80, 2, function()
				local hooman = GetUpdatedEntityID()
				local skull_state_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "ss_menu_state" )
				ComponentSetValue2( skull_state_storage, "value_bool", false )
				GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/menu_close", char_x, char_y )
				new_console_entry( hooman, "Servointerface offline.", 0 )
			end )
			
			local pages = 
			{
				{
					content = function( gui, uid, pic_x, pic_y )
						local stable_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "stable_value" )
						local targeter_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "show_targets" )
						local stable_value = ComponentGetValue2( stable_storage, "value_int" )
						local show_targeter = ComponentGetValue2( targeter_storage, "value_bool" )
						local new_value = 0
						
						pic_y = pic_y + 2
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z - 0.01, 12, 8 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z - 0.1, stable_value )
						
						pic_y = pic_y - 2
						local_grab_x = local_grab_x or {}
						local_grab_y = local_grab_y or {}
						uid, new_value = new_slider( gui, uid, char_x, char_y, pic_x + 18, pic_y, pic_z - 0.1, 1023, 89, stable_value/99 )
						new_value = math.floor( new_value*99 )
						if( new_value ~= stable_value ) then
							ComponentSetValue2( stable_storage, "value_int", new_value )
						end
						
						pic_y = pic_y + 19
						if( show_targeter ) then
							uid = new_image( gui, uid, pic_x + 1, pic_y + 1, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 14 )
						end
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon.png" )
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							ComponentSetValue2( targeter_storage, "value_bool", not( show_targeter ))
						end
						
						uid = window_inner( gui, uid, pic_x + 18, pic_y + 2, pic_z - 0.01, 33, 8 )
						new_text( gui, pic_x + 20, pic_y + 3, pic_z - 0.1, "Targeter" )
						
						pic_y = pic_y + 19
						if( show_infer ) then
							uid = new_image( gui, uid, pic_x + 1, pic_y + 1, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 14 )
						end
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon.png" )
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							ComponentSetValue2( infer_storage, "value_bool", not( show_infer ))
						end
						
						uid = window_inner( gui, uid, pic_x + 18, pic_y + 2, pic_z - 0.1, 33, 8 )
						new_text( gui, pic_x + 20, pic_y + 3, pic_z - 0.1, "Info Tab" )
						
						pic_y = pic_y + 19
						if( show_console ) then
							uid = new_image( gui, uid, pic_x + 1, pic_y + 1, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 14 )
						end
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon.png" )
						if( clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							ComponentSetValue2( consoler_storage, "value_bool", not( show_console ))
						end
						
						uid = window_inner( gui, uid, pic_x + 18, pic_y + 2, pic_z - 0.01, 33, 8 )
						new_text( gui, pic_x + 20, pic_y + 3, pic_z - 0.1, "Console" )
						
						pic_x = pic_x + 58
						pic_y = pic_y - 36
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z - 0.01, 60, 46 )
						uid = new_image( gui, uid, pic_x + 12, pic_y + 4.5, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/servoskull_quote.png" )
						
						return uid
					end,
				},
				{
					content = function( gui, uid, pic_x, pic_y )
						pic_x = pic_x - 21
						for i = 1,5 do
							local data_storage = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "save_slot_"..i )
							local slot_state = ComponentGetValue2( data_storage, "value_int" )
							local saved_id = get_tagged_id( "storage_save_slot_"..i )
							
							pic_x = pic_x + 21
							uid = window_inner( gui, uid, pic_x, pic_y, pic_z - 0.01, 12, 14 )
							uid = new_high_gothic( gui, uid, pic_x + 5, pic_y + 1, pic_z - 0.1, string.char( 96 + i ))
							if( slot_state ~= 0 ) then
								if( saved_id == nil ) then
									uid = new_image( gui, uid, pic_x + 1, pic_y + 1, pic_z - 0.005, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_blue.png", 14, 16 )
									slot_state = 0
								else
									uid = new_image( gui, uid, pic_x + 1, pic_y + 1, pic_z - 0.005, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 16 )
								end
							end
							
							uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y + 21, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_write.png" )
							if( r_clicked ) then
								if( captured_entity ~= 0 and slot_state >= 0 ) then
									if( slot_state ~= 0 ) then
										EntityRemoveTag( saved_id, "storage_save_slot_"..i )
									end
								
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
									EntityAddTag( captured_entity, "storage_save_slot_"..i )
									ComponentSetValue2( data_storage, "value_int", 1 )
									new_console_entry( hooman, "Target "..captured_entity.." saved.", 0 )
								else
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
									
									local tmp = "None captured."
									if( slot_state < 0 ) then
										tmp = "Lock detected."
									end
									new_console_entry( hooman, tmp, 0 )
								end
							end
							
							uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y + 40, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_read.png" )
							if( clicked ) then
								if( slot_state == 0 ) then
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
									new_console_entry( hooman, "Nothing to load.", 0 )
								else
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
									ComponentSetValue2( captured_storage, "value_int", saved_id )
									new_console_entry( hooman, "Target "..saved_id.." loaded.", 0 )
								end
							end
							
							if( slot_state < 0 ) then
								uid = new_image( gui, uid, pic_x + 1, pic_y + 60, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 14 )
							end
							uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y + 59, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_lock.png" )
							if( clicked ) then
								if( slot_state ~= 0 ) then
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
									ComponentSetValue2( data_storage, "value_int", -1*slot_state )
									
									local tmp = "Slot locked."
									if( slot_state < 0 ) then
										tmp = "Slot unlocked."
									end
									new_console_entry( hooman, tmp, 0 )
								else
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
									new_console_entry( hooman, "None captured.", 0 )
								end
							end
						end
						
						pic_x = pic_x + 24
						pic_y = pic_y + 1
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_reset.png" )
						if( r_clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							for i = 1,5 do
								local data_stg = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "save_slot_"..i )
								local slot_st = ComponentGetValue2( data_stg, "value_int" )
								if( slot_st > 0 ) then
									EntityRemoveTag( get_tagged_id( "storage_save_slot_"..i ), "storage_save_slot_"..i )
									ComponentSetValue2( data_stg, "value_int", 0 )
								end
							end
							new_console_entry( hooman, "Data purged.", 0 )
						end
						
						pic_y = pic_y + 20
						local wp_names = { "ALPHA", "BETA", "GAMMA" }
						for i = 1,3 do
							local wp_stg = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "waypoint_"..i )
							local waypoint = ComponentGetValue2( wp_stg, "value_string" )
							if( waypoint ~= "|" ) then
								if( current_waypoint == waypoint ) then
									uid = new_image( gui, uid, pic_x - 4, pic_y + ( i - 1 )*19 + 3, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/mark_waypoint.png" )
								end
								
								uid = new_image( gui, uid, pic_x + 1, pic_y + ( i - 1 )*19 + 1, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 14 )
							end
							uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y + ( i - 1 )*19, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_waypoint_"..i..".png" )
							if( clicked ) then
								if( waypoint ~= "|" ) then
									if( current_waypoint ~= waypoint ) then
										GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
										ComponentSetValue2( waypoint_storage, "value_string", waypoint )
										new_console_entry( hooman, "Waypoint "..wp_names[i].." selected.", 0 )
									else
										GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
										ComponentSetValue2( waypoint_storage, "value_string", "|" )
										new_console_entry( hooman, "Waypoint "..wp_names[i].." dismissed.", 0 )
									end
								else
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
									new_console_entry( hooman, "Storage is empty.", 0 )
								end
							end
							if( r_clicked ) then
								if( waypoint == "|" ) then
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
									ComponentSetValue2( wp_stg, "value_string", D_packer({ math.floor( s_x ), math.floor( s_y ) }))
									new_console_entry( hooman, "Waypoint "..wp_names[i].." created.", 0 )
								else
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
									ComponentSetValue2( wp_stg, "value_string", "|" )
									ComponentSetValue2( waypoint_storage, "value_string", "|" )
									new_console_entry( hooman, "Waypoint "..wp_names[i].." deleted.", 0 )
								end
							end
						end
						
						return uid
					end,
				},
				{
					content = function( gui, uid, pic_x, pic_y )
						local wand_storage = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "wand_storage" )
						local matter_storage = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "matter_storage" )
						local max_storage = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "matter_max" )
						local power_storage = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "power_storage" )
						local wand_state = ComponentGetValue2( wand_storage, "value_int" )
						local wand_id = get_tagged_id( "storage_wand_storage" )
						local power_count = ComponentGetValue2( power_storage, "value_int" )
						
						local delta = 0
						local power_cost = 0
						local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
						
						if( wand_id == nil ) then
							wand_state = 0
						end
						
						if( wand_state ~= 0 and new_values == nil ) then
							ComponentSetValue2( wand_storage, "value_int", 1 )
							new_values = { 0, 0, 0, 0, 0, 0, 0 }
							stats = { 0, 0, 0, 0, 0, 0, 0 }
							stats[1] = ComponentObjectGetValue2( abil_comp, "gunaction_config", "fire_rate_wait" )
							stats[2] = ComponentObjectGetValue2( abil_comp, "gun_config", "reload_time" )
							stats[3] = ComponentGetValue2( abil_comp, "mana_max" )
							stats[4] = ComponentGetValue2( abil_comp, "mana_charge_speed" )
							stats[5] = ComponentObjectGetValue2( abil_comp, "gun_config", "deck_capacity" )
							stats[6] = ComponentObjectGetValue2( abil_comp, "gunaction_config", "spread_degrees" )
							stats[7] = b2n( ComponentObjectGetValue2( abil_comp, "gun_config", "shuffle_deck_when_empty" ))
							old_rating = math.floor( wand_rater( wand_id )*10 + 0.5 )/10.0
							
							for i = 1,7 do
								new_values[i] = stats[i]
							end
						end
						
						if( wand_state > 0 ) then
							for i = 1,7 do
								if( stats[i] ~= new_values[i] ) then
									ComponentSetValue2( wand_storage, "value_int", -1 )
									break
								end
							end
						elseif( wand_state == 0 and new_values ~= nil ) then
							new_values = nil
						end
						
						function delter( stt, val )
							if( val ~= 0 ) then
								if( stt >= 0 ) then
									stt = stt + val
									if( stt < 0 ) then
										stt = 0
									end
								elseif( val > 0 ) then
									stt = stt + val
								end
							end
							return stt
						end
						
						uid, delta = new_side_clicker( gui, uid, char_x, char_y, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_delay.png" )
						if( wand_state ~= 0 ) then
							new_values[1] = delter( new_values[1], delta )
						end
						
						pic_x = pic_x + 31
						uid, delta = new_side_clicker( gui, uid, char_x, char_y, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_recharge.png" )
						if( wand_state ~= 0 ) then
							new_values[2] = delter( new_values[2], delta )
						end
						
						pic_y = pic_y + 19
						uid, delta = new_side_clicker( gui, uid, char_x, char_y, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_mana_max.png" )
						if( wand_state ~= 0 ) then
							new_values[3] = delter( new_values[3], 10*delta )
						end
						
						pic_x = pic_x - 31
						uid, delta = new_side_clicker( gui, uid, char_x, char_y, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_mana_up.png" )
						if( wand_state ~= 0 ) then
							new_values[4] = delter( new_values[4], 10*delta )
						end
						
						pic_y = pic_y + 19
						uid, delta = new_side_clicker( gui, uid, char_x, char_y, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_capacity.png" )
						if( wand_state ~= 0 ) then
							new_values[5] = delter( new_values[5], delta )
						end
						
						pic_x = pic_x + 31
						uid, delta = new_side_clicker( gui, uid, char_x, char_y, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_spread.png" )
						if( wand_state ~= 0 ) then
							new_values[6] = delter( new_values[6], delta )
						end
						
						pic_x = pic_x - 31
						pic_y = pic_y + 19
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_shuffle.png" )
						if( wand_state ~= 0 ) then
							if( n2b( new_values[7] )) then
								uid = new_image( gui, uid, pic_x + 1, pic_y + 1, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 14 )
							end
							if( clicked ) then
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
								new_values[7] = b2n( not( n2b( new_values[7] )))
							end
						end
						
						pic_x = pic_x + 19
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z - 0.01, 36, 12 )
						if( wand_state ~= 0 ) then
							local new_rating = wand_rater( wand_id, new_values[7], nil, new_values[5], new_values[2], new_values[1], new_values[3], new_values[4], nil, new_values[6] )
							power_cost = math.floor(( new_rating - old_rating ) + 0.5 )
							new_text( gui, pic_x + 2, pic_y + 3, pic_z - 0.1, K_number( power_cost, 2 ))
						end
						
						pic_x = pic_x + 43
						pic_y = pic_y - 57
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z - 0.01, 39, 50 )
						if( wand_state ~= 0 ) then
							new_text( gui, pic_x + 3, pic_y + 1, pic_z - 0.1, "D: "..math.floor( new_values[1]*10/6 )/100 )
							new_text( gui, pic_x + 3, pic_y + 9, pic_z - 0.1, "R: "..math.floor( new_values[2]*10/6 )/100 )
							new_text( gui, pic_x + 3, pic_y + 17, pic_z - 0.1, "M: "..math.floor( new_values[3] + 0.5 ))
							new_text( gui, pic_x + 3, pic_y + 25, pic_z - 0.1, "U: "..math.floor( new_values[4] + 0.5 ))
							new_text( gui, pic_x + 3, pic_y + 33, pic_z - 0.1, "C: "..new_values[5] )
							new_text( gui, pic_x + 3, pic_y + 41, pic_z - 0.1, "A: "..new_values[6] )
						end
						
						pic_y = pic_y + 57
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z - 0.01, 39, 12 )
						if( wand_state ~= 0 ) then
							pic = ComponentGetValue2( abil_comp, "sprite_file" ) --ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( wand_id, "SpriteComponent", "item" ), "image_file" )
							if( pic ~= nil and pic ~= "" ) then
								pic = string.sub( pic, 1, string.len( pic ) - 3 ).."png"
								pic_w, pic_h = GuiGetImageDimensions( gui, pic, 1 )
								local new_scale = 39/pic_w
								if( pic_h*new_scale > 13 ) then
									new_scale = 13/pic_h
								end
								uid = new_image( gui, uid, pic_x + ( 43 - pic_w*new_scale )/2, pic_y + ( 16 - pic_h*new_scale )/2, pic_z - 0.1, pic, new_scale, new_scale )
							end
						end
						
						pic_x = pic_x + 46
						pic_y = pic_y - 57
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_salvage.png" )
						if( r_clicked ) then
							if( wand_state ~= 0 ) then
								local matter_max = ComponentGetValue2( max_storage, "value_int" )
								local matter_count = ComponentGetValue2( matter_storage, "value_int" )
								
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
								EntityRemoveTag( wand_id, "storage_wand_storage" )
								ComponentSetValue2( wand_storage, "value_int", 0 )
								pull_out( wand_id )
								
								ComponentSetValue2( power_storage, "value_int", power_count + math.ceil( wand_rater( wand_id )))
								matter_count = matter_count + 100
								if( matter_count > matter_max ) then
									new_console_entry( hooman, "Matter overflow.", 0 )
									GameCreateParticle( "void_liquid", s_x, s_y, matter_count - matter_max, 1, 1, false )
									matter_count = matter_max
								end
								ComponentSetValue2( matter_storage, "value_int", matter_count )
								EntityKill( wand_id )
								GameCreateParticle( "spark_red", s_x, s_y, 20, 150, 150, false )
								
								new_console_entry( hooman, "Armament salvaged.", 0 )
							else
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
								new_console_entry( hooman, "Storage is empty.", 0 )
							end
						end
						
						pic_y = pic_y + 19
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_insert.png" )
						if( r_clicked ) then
							if( wand_state == 0 ) then
								if( captured_entity ~= 0 ) then
									if( EntityHasTag( captured_entity, "wand" )) then
										if( magic2binary( skull_id, captured_entity )) then
											GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
											
											local spells = EntityGetAllChildren( captured_entity ) or {}
											if( #spells > 0 ) then
												for i,spell in ipairs( spells ) do
													if( EntityHasTag( spell, "card_action" )) then
														if( not( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( spell, "ItemComponent" ), "permanently_attached" ))) then
															pull_out( spell )
														end
													end
												end
											end
											
											EntityAddTag( captured_entity, "storage_wand_storage" )
											ComponentSetValue2( wand_storage, "value_int", 1 )
											put_in( skull_id, captured_entity )
											ComponentSetValue2( captured_storage, "value_int", 0 )
											new_console_entry( hooman, "Armament inserted.", 0 )
										else
											GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
											new_console_entry( hooman, "Unable to reach.", 0 )
										end
									else
										GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
										new_console_entry( hooman, "None detected.", 0 )
									end
								else
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
									new_console_entry( hooman, "None captured.", 0 )
								end
							else
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
								new_console_entry( hooman, "Storage is full.", 0 )
							end
						end
						
						pic_y = pic_y + 19
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_extract.png" )
						if( r_clicked ) then
							if( wand_state ~= 0 ) then
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
								EntityRemoveTag( wand_id, "storage_wand_storage" )
								ComponentSetValue2( wand_storage, "value_int", 0 )
								pull_out( wand_id )
								new_console_entry( hooman, "Armament extracted.", 0 )
							else
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
								new_console_entry( hooman, "Storage is empty.", 0 )
							end
						end
						
						pic_y = pic_y + 19
						if( wand_state < 0 ) then
							uid = new_image( gui, uid, pic_x + 1, pic_y + 1, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 14 )
						end
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_done.png" )
						if( r_clicked ) then
							if( wand_state ~= 0 ) then
								if( power_cost <= power_count ) then
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
									ComponentSetValue2( power_storage, "value_int", power_count - power_cost )
									
									ComponentObjectSetValue2( abil_comp, "gunaction_config", "fire_rate_wait", new_values[1] )
									ComponentObjectSetValue2( abil_comp, "gun_config", "reload_time", new_values[2] )
									ComponentSetValue2( abil_comp, "mana_max", new_values[3] )
									ComponentSetValue2( abil_comp, "mana_charge_speed", new_values[4] )
									ComponentObjectSetValue2( abil_comp, "gun_config", "deck_capacity", new_values[5] )
									ComponentObjectSetValue2( abil_comp, "gunaction_config", "spread_degrees", new_values[6] )
									ComponentObjectSetValue2( abil_comp, "gun_config", "shuffle_deck_when_empty", n2b( new_values[7] ))
									
									ComponentSetValue2( wand_storage, "value_int", 1 )
									new_values = nil
									
									new_console_entry( hooman, "Armament modified.", 0 )
								else
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
									new_console_entry( hooman, "Insufficient Power Level.", 0 )
								end
							else
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
								new_console_entry( hooman, "Storage is empty.", 0 )
							end
						end
						
						return uid
					end,
				},
				{
					content = function( gui, uid, pic_x, pic_y )
						local matter_storage = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "matter_storage" )
						local max_storage = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "matter_max" )
						local power_storage = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "power_storage" )
						local salvage_storage = EntityGetFirstComponentIncludingDisabled( skull_id, "VariableStorageComponent", "salvage_mode" )
						local matter_count = ComponentGetValue2( matter_storage, "value_int" )
						local power_count = ComponentGetValue2( power_storage, "value_int" )
						local salvage_mode = ComponentGetValue2( salvage_storage, "value_bool" )
						
						SetRandomSeed( GameGetFrameNum(), char_x + char_y + skull_id + power_count )
						
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z - 0.01, 12, 71 )
						if( matter_count > 0 ) then
							local matter_percent = matter_count/ComponentGetValue2( max_storage, "value_int" )*73
							uid = new_image( gui, uid, pic_x + 1, pic_y + 74 - matter_percent, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, matter_percent )
						end
						
						pic_x = pic_x + 19
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z - 0.01, 82, 56 )
						new_text( gui, pic_x + 3, pic_y + 2, pic_z - 0.1, paragrapher( nil, "Be still, spirits / I do what I must, / Forgive the intrusion, / And give me your trust.", 80, 54, 4 ))
						
						pic_x = pic_x + 89
						if( salvage_mode ) then
							uid = new_image( gui, uid, pic_x + 1, pic_y + 1, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_red.png", 14, 14 )
						end
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_salvage.png" )
						if( r_clicked ) then
							GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
							ComponentSetValue2( salvage_storage, "value_bool", not( salvage_mode ))
							
							local tmp = "Commencing salvaging."
							if( salvage_mode ) then
								tmp = "Salvaging terminated."
							end
							new_console_entry( hooman, tmp, 0 )
						end
						
						pic_y = pic_y + 59
						uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/icons/servoskull/icon_gen.png" )
						if( r_clicked ) then
							if( matter_count >= 500 ) then
								ComponentSetValue2( matter_storage, "value_int", matter_count - 500 )
								local spell = GetRandomActionWithType( char_x, char_y, Random( 0, 7 ), Random( 0, 7 ), frame_num )
								
								if( spell == nil or spell == "" ) then
									GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
									new_console_entry( hooman, "Critical error.", 0 )
								else
									local cost = math.ceil( get_action_with_id( spell ).price/10 )
									if( cost > power_count ) then
										GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
										new_console_entry( hooman, "Insufficient power level.", 0 )
										spell = ""
									else
										ComponentSetValue2( power_storage, "value_int", power_count - cost )
										GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
										new_console_entry( hooman, "Generation completed.", 0 )
									end
									
									CreateItemActionEntity( spell, s_x, s_y )
								end
							else
								GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_failure", char_x, char_y )
								new_console_entry( hooman, "Insufficient matter.", 0 )
							end
						end
						
						pic_x = pic_x - 89
						pic_y = pic_y + 4
						uid = window_inner( gui, uid, pic_x, pic_y, pic_z - 0.01, 82, 8 )
						new_text( gui, pic_x + 3, pic_y + 1, pic_z - 0.1, "PL: "..power_count )
						
						return uid
					end,
				},
			}
			
			local skull_page_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "ss_menu_page" )
			local skull_menu_page = ComponentGetValue2( skull_page_storage, "value_int" )
			
			pic_x = pic_x + 22
			pic_y = pic_y + 5
			uid = new_image( gui, uid, pic_x, pic_y, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/servoskull_pages.png" )
			uid = new_image( gui, uid, pic_x - 2, pic_y + 8, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_white.png", 3 + skull_menu_page*26, 1 )
			uid = new_image( gui, uid, pic_x + ( skull_menu_page + 1 )*26, pic_y + 8, pic_z - 0.1, "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_white.png", ( 3 - skull_menu_page )*26 + 3, 1 )
			
			pic_x = pic_x + 1
			for i = 0,3 do
				uid, clicked, r_clicked = new_button( gui, uid, pic_x + i*26, pic_y, pic_z - 0.01, "mods/Noita40K/files/pics/gui_gfx/button_weak_gray.png" )
				if( clicked ) then
					ComponentSetValue2( skull_page_storage, "value_int", i )
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/ui/holo_button", char_x, char_y )
				end
			end
			
			pic_x = pic_x - 15
			pic_y = pic_y + 18
			uid = pages[skull_menu_page + 1].content( gui, uid, pic_x, pic_y )
		end
	end
	
	
	
	if( GameHasFlagRun( "PERK_PICKED_OMNISSIAHS_BLESSING" )) then
		mode_controller()
	end
	if( GameHasFlagRun( "PERK_PICKED_MECHADENDRITES" )) then
		dendrites_controller()
	end
	if( GameHasFlagRun( "PERK_PICKED_SICARIAN_ARMOUR" )) then
		energy_state()
	end
	wand_state()
	if( show_infer ) then
		global_info()
	end
	if( captured_entity ~= 0 ) then
		if( EntityGetIsAlive( captured_entity )) then
			captured_pointer()
		else
			captured_entity = 0
			ComponentSetValue2( captured_storage, "value_int", captured_entity )
			new_console_entry( hooman, "Target terminated.", 1 )
		end
	end
	if( explorator_mode ) then
		anomaly_detector()
		entity_scanner()
		if( show_console ) then
			custom_console()
		end
		if( GameHasFlagRun( "PERK_PICKED_SERVOSKULL" )) then
			servoskull_interface()
		end
	end
else
	if( gui ~= nil ) then
		GuiDestroy( gui )
		gui = nil
	end
end