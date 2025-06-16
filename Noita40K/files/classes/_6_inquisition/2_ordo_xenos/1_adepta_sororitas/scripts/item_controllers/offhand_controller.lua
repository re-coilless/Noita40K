dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local entity_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( entity_id )
local c_x, c_y, c_r, c_s_x, c_s_y = EntityGetTransform( hooman )
local i_x, i_y, i_r = EntityGetTransform( entity_id )

local storage_mode = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "is_offhanded" )
local mode = ComponentGetValue2( storage_mode, "value_bool" )

if( offhand_id == nil or not( EntityGetIsAlive( offhand_id ))) then
	ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "hand" ), "visible", false )
	
	for i,pic in ipairs( EntityGetComponent( hooman, "SpriteComponent" )) do
		EntityRefreshSprite( hooman, pic )
	end
	
	offhand_id = EntityLoad( "mods/n40ke_bss/files/entities/twin_linked/left_arm.xml", c_x, c_y )
	EntityAddChild( hooman, offhand_id )
	
	local wand_id = EntityLoad( "mods/n40ke_bss/files/entities/items/seraphim_bolt_pistol_offhand.xml", c_x, c_y )
	local children = EntityGetAllChildren( wand_id ) or {}
	if( #children > 0 ) then
		for i,mag in ipairs( children ) do
			if( EntityHasTag( mag, "mag" )) then
				local is_reloading = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "is_reloading" ), "value_bool" )
				local reload_end = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "reload_end" ), "value_int" )
				local current_ammo = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "ammo_current" ), "value_int" )
				
				ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "is_reloading" ), "value_bool", is_reloading )
				ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "reload_end" ), "value_int", reload_end )
				ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "ammo_current" ), "value_int", current_ammo )
				break
			end
		end
	end
	
	EntityAddTag( hooman, "twin_linked" )
	GamePickUpInventoryItem( offhand_id, wand_id, false )
end

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
if( ctrl_comp ~= nil ) then
	local LMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownFire" )
	if( LMB_down ) then
		if( not( LMB_pressed )) then
			if( mode ) then
				ComponentSetValue2( storage_mode, "value_bool", false )
				GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "items/unequip", i_x, i_y )
			else
				ComponentSetValue2( storage_mode, "value_bool", true )
				GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "items/equip", i_x, i_y )
			end
		end
		LMB_pressed = true
	else
		LMB_pressed = false
	end
end