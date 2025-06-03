dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

function enabled_changed( entity, is_enabled )
	if( not( is_enabled )) then
		local comp_id = get_variable_storage_component_ultimate( entity, "state" )
		if( comp_id ~= nil ) then
			if( ComponentGetValue2( comp_id, "value_bool" )) then
				ComponentSetValue2( comp_id, "value_bool", false )
			elseif( ComponentGetValue2( comp_id, "value_int" ) ~= 0 ) then
				ComponentSetValue2( comp_id, "value_int", 0 )
			end
		end
	end
end