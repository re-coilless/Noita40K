local entity_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local stain_info = {}
for value in string.gmatch( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "stain_info" ), "value_string" ), "([^|]+)" ) do
	table.insert( stain_info, value )
end

EntityAddRandomStains( hooman, CellFactory_GetType( stain_info[1] ), tonumber( stain_info[2]))