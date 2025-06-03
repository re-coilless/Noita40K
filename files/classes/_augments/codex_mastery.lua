dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/mag_system.lua" )

local hooman = GetUpdatedEntityID()
local char_x, char_y = EntityGetTransform( hooman )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
local frame_num = GameGetFrameNum()

local storage_frame = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "finest_frame" )
local storage_prev = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "finest_prev_frame" )
local frame = ComponentGetValue2( storage_frame, "value_int" )
local prev_frame = ComponentGetValue2( storage_prev, "value_int" )

local LMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownFire" )
if( LMB_down and not( GameIsInventoryOpen())) then
	if( not( LMB_pressed )) then
		local wand_id = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "Inventory2Component" ), "mActiveItem" )
		local fire_frame = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" ), "mCastDelayStartFrame" )
		if( fire_frame == frame_num and EntityHasTag( wand_id, "mag_gun" )) then
			ComponentSetValue2( storage_prev, "value_int", frame )
			ComponentSetValue2( storage_frame, "value_int", frame_num )
			
			local delay = frame_num - frame
			local prev_delay = frame - prev_frame
			local delta = math.abs( delay - prev_delay )
			if( delta < prev_delay*0.1 ) then
				local mags = get_mags( wand_id )
				if( #mags > 0 ) then
					local p_hitbox_offset = get_head_offset( hooman ) - 4
					EntityLoad( "mods/Noita40K/files/entities/emitters/blessed_iron_halo.xml", char_x, char_y + p_hitbox_offset )
					
					for i,mag in ipairs( mags ) do
						local is_reloading = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "is_reloading" ), "value_bool" )
						if( not( is_reloading )) then
							local item_comp = EntityGetFirstComponentIncludingDisabled( mag, "ItemComponent" )
							local act_comp = EntityGetFirstComponentIncludingDisabled( mag, "ItemActionComponent" )
							if( was_shot( ComponentGetValue2( act_comp, "action_id" ).."."..ComponentGetValue2( item_comp, "mItemUid" ))) then
								local current_storage = EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "ammo_current" )
								local ammo_current = ComponentGetValue2( current_storage, "value_int" )
								local ammo_max = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "ammo_max" ), "value_int" )
								if( ammo_current > -1 and ammo_max > ammo_current ) then
									ComponentSetValue2( current_storage, "value_int", ammo_current + 1 )
								end
								GameScreenshake( 1 )
							end
						end
					end
				end
			end
		else
			ComponentSetValue2( storage_prev, "value_int", 0 )
			ComponentSetValue2( storage_frame, "value_int", 0 )
		end
	end
	LMB_pressed = true
else
	LMB_pressed = false
end