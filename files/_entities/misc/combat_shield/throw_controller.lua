function throw_item( from_x, from_y, to_x, to_y )
	local entity_id = GetUpdatedEntityID()
	ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "shield_mode" ), "value_bool", false )

	local holder = EntityGetClosestWithTag( from_x, from_y, "combat_shield_holder" )
	if( holder ~= nil ) then
		EntityKill( holder )
	end
end