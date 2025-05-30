function enabled_changed( entity, is_enabled )
	if( not( is_enabled )) then
		local trash_tag = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent", "trash_tag" ), "value_string" )
		
		local x, y = EntityGetTransform( entity )
		local trash = EntityGetInRadiusWithTag( x, y, 200, trash_tag ) or {}
		if( #trash > 0 ) then
			for i,ass in ipairs( trash ) do
				EntityKill( ass )
			end
		end
	end
end