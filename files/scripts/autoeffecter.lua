dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local entity_id = GetUpdatedEntityID()
local deadman = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local effect_info = {}
for value in string.gmatch( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "effect_info" ), "value_string" ), "([^|]+)" ) do
	table.insert( effect_info, value )
end

local theres_none = get_custom_effect( deadman, effect_info[1] ) == nil
if( effect_info[3] == "0" or theres_none ) then
	LoadGameEffectEntityTo( deadman, effect_info[2] )
end
if( effect_info[4] ~= "0" and ( effect_info[5] == "1" or theres_none )) then
	ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( get_custom_effect( deadman, effect_info[1] ), "GameEffectComponent", "main" ), "frames", tonumber( effect_info[4] ))
end