function enabled_changed( entity, is_enabled )
	if not( is_enabled ) then
		local child_tag = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent", "child_tag" ), "value_string" )
		local children = EntityGetAllChildren( entity ) or {}
		if( #children > 0 ) then
			for i,child in ipairs( children ) do
				if( EntityHasTag( child, child_tag )) then
					EntityKill( child )
				end
			end
		end
	end
end