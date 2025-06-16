function enabled_changed( entity, is_enabled )
	if not( is_enabled ) then
		if( not( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent", "is_offhanded" ), "value_bool" ))) then
			local x, y = EntityGetTransform( entity )
			local holder = EntityGetClosestWithTag( x, y, "arm_left" )
			if( holder ~= nil ) then
				dofile( "mods/n40ke_bss/files/scripts/item_controllers/kill_action.lua" )
			end
		end
	end
end