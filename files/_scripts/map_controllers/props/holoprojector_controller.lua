dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )

local entity_id = GetUpdatedEntityID()

local phys_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
local storage_broken = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "broken_cooldown" )
local broken_cooldown = ComponentGetValue2( storage_broken, "value_int" )

local is_broken = EntityHasTag( entity_id, "broken" )
local frame_num = GameGetFrameNum()
local h_x, h_y, h_r, h_s_x, h_s_y = EntityGetTransform( entity_id )
local v_x, v_y = PhysicsGetComponentVelocity( entity_id, phys_comp )
local a_v = PhysicsGetComponentAngularVelocity( entity_id, phys_comp )
if( broken_cooldown < frame_num ) then
	local is_updated = false
	if( math.sqrt( v_x^2 + v_y^2 ) < 10 and math.deg( math.abs( h_r )) < 15 and math.abs( a_v ) < 0.5 ) then
		if( is_broken ) then
			GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/short_circuit_alt", h_x, h_y )
			EntityRemoveTag( entity_id, "broken" )
			EntitySetComponentsWithTagEnabled( entity_id, "active", true )
			is_updated = true
		end
	elseif( not( is_broken )) then
		GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/short_circuit", h_x, h_y )
		EntityAddTag( entity_id, "broken" )
		EntitySetComponentsWithTagEnabled( entity_id, "active", false )
		is_updated = true
	end
	
	if( is_updated ) then
		ComponentSetValue2( storage_broken, "value_int", frame_num + 10 )
	end
end

if( not( is_broken )) then
	local hooman = get_player()
	if( hooman ~= nil ) then
		local p_x, p_y, p_r, p_s_x, p_s_y = EntityGetTransform( hooman )
		
		local dist = math.sqrt(( p_x - h_x )^2 + ( p_y - h_y )^2 )
		if( dist < 50 ) then
			local active_storage = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "is_active" )
			local is_active = ComponentGetValue2( active_storage, "value_bool" )
			
			if( gui == nil ) then
				gui = GuiCreate()
			end
			GuiStartFrame( gui )
			
			local uid, clicked, r_clicked = 0, 0, 0
			local pic_x, pic_y = world2gui( gui, h_x, h_y )
			local pic_z = 0
			
			if( is_active ) then
				pic_x = pic_x - 100
				pic_y = pic_y + 6
				uid = window_normal( gui, uid, pic_x, pic_y, pic_z + 0.1, 177, 73, 3 )
				
				uid = window_inner( gui, uid, pic_x + 18, pic_y + 4, pic_z + 0.01, 159, 8 )
				new_text( gui, pic_x + 21, pic_y + 5, pic_z, "FA [VALLO] | ? ??? ???.M?? | _" )
				
				uid, clicked, r_clicked = new_button( gui, uid, pic_x + 182, pic_y + 4, pic_z, "mods/Noita40K/files/pics/gui_gfx/quest_menu_button_holo_close.png" )
				if( clicked ) then
					GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/ui/holo_button", h_x, h_y )
					ComponentSetValue2( active_storage, "value_bool", false )
				end
				
				uid = window_inner( gui, uid, pic_x + 7, pic_y + 18, pic_z + 0.01, 166, 12 )
				new_text( gui, pic_x + 10, pic_y + 21, pic_z, "Personal Log | Entry #37 | [REPLICA]" )
				new_blinker( gui, { 195/255, 3/255, 3/255, 1 } )
				uid, clicked, r_clicked = new_button( gui, uid, pic_x + 178, pic_y + 18, pic_z, "mods/Noita40K/files/pics/gui_gfx/button_confirm.png" )
				uid = new_tutorial_tooltip( gui, uid, "LMB to synchronize." )
				if( clicked ) then
					GamePrint( "[SYNCHRONIZATION COMPLETED]" )
					add_quest( hooman, "BEACON_HUNT_ITEM", { "Auspex data was updated.", "Open the inventory." }, "This must be heresy.", "Alone in the Dark", "The message left by brother Vallo clearly states that he can be found near the Anomaly. Follow his path and provide utmost assistance in his deeds.", 2350, 850, "Velho_Pattern_Bolter", nil, "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_quest_velho.png" )
					GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/short_circuit", h_x, h_y )
					EntitySetComponentsWithTagEnabled( entity_id, "active", false )
					EntityRemoveComponent( entity_id, GetUpdatedComponentID())
				end
				
				local text = "[Primary destination reached. Scanning...] / [Anomaly detected. Initiating secondary cycle...] / [Target confirmed. Uploading the log...] / ++++++++++++++++++++++++++++++ / The signature proves to be alien, cogitators report an unknown origin, armaments are primed. /"
				uid = window_inner( gui, uid, pic_x + 7, pic_y + 35, pic_z + 0.01, 183, 53 )
				new_text( gui, pic_x + 10, pic_y + 36, pic_z, paragrapher( nil, text, 184, 54, 3.5 ))
			else
				local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
				if( ComponentGetValue2( ctrl_comp, "mButtonDownInteract" )) then
					ComponentSetValue2( active_storage, "value_bool", true )
					GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/ui/holo_button", h_x, h_y )
				end
				
				local prompt = "[USE] to activate."
				local offset = GuiGetTextDimensions( gui, prompt, 1, 2 )/2
				new_text( gui, pic_x - offset, pic_y + 5, pic_z, prompt )
				new_text( gui, pic_x - offset + 1, pic_y + 6, pic_z + 0.01, prompt, { 0, 0, 0, 1 } )
			end
		else
			if( gui ~= nil ) then
				GuiDestroy( gui )
				gui = nil
			end
		end
	end
end