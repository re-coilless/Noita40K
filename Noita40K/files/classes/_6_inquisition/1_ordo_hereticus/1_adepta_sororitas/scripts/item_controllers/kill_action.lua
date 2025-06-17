local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local holder = EntityGetClosestWithTag( x, y, "arm_left" )
local inv_comp = EntityGetFirstComponentIncludingDisabled( holder, "Inventory2Component" )
local wand_id = ComponentGetValue( inv_comp, "mActiveItem" )
local children = EntityGetAllChildren( wand_id ) or {}
if( #children > 0 ) then
	for i,mag in ipairs( children ) do
		if( EntityHasTag( mag, "mag" )) then
			local is_reloading = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "is_reloading" ), "value_bool" )
			local reload_end = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "reload_end" ), "value_int" )
			local current_ammo = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( mag, "VariableStorageComponent", "ammo_current" ), "value_int" )
			
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "is_reloading" ), "value_bool", is_reloading )
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "reload_end" ), "value_int", reload_end )
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "ammo_current" ), "value_int", current_ammo )
			break
		end
	end
end

local hooman = EntityGetRootEntity( entity_id )
if( entity_id == EntityGetRootEntity( entity_id )) then
	hooman = EntityGetClosestWithTag( x, y, "player_unit" )
end

ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "hand" ), "visible", true )

for i,pic in ipairs( EntityGetComponent( hooman, "SpriteComponent" )) do
	EntityRefreshSprite( hooman, pic )
end

EntityRemoveTag( hooman, "twin_linked" )
EntityKill( holder )