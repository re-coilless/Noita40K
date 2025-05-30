function init( entity_id )
	local matter_name = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "matter_name" ), "value_string" )
	local sucker_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialSuckerComponent" )
	local amount = 1000
	if( sucker_comp ~= nil ) then
		amount = ComponentGetValue2( sucker_comp, "barrel_size" )
	end
	AddMaterialInventoryMaterial( entity_id, matter_name, amount )
end