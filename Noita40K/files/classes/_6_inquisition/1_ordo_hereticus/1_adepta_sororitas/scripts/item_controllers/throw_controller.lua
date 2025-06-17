function throw_item( from_x, from_y, to_x, to_y )
	local entity_id = GetUpdatedEntityID()
	ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "is_offhanded" ), "value_bool", false )
	
	local holder = EntityGetClosestWithTag( from_x, from_y, "arm_left" )
	if( holder ~= nil ) then
		dofile( "mods/n40ke_bss/files/scripts/item_controllers/kill_action.lua" )
	end
end