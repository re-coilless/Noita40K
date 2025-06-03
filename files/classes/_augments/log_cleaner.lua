local hooman = GetUpdatedEntityID()

local console_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "console_log" )
local console_log = ComponentGetValue2( console_storage, "value_string" )

if( string.len( console_log ) > 150 ) then
	ComponentSetValue2( console_storage, "value_string", string.sub( console_log, 1, 150 ))
end