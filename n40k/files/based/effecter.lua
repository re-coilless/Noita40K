return function( hooman, effect_id, is_added, is_removed )
	local targets = { hooman }
	local x, y = EntityGetTransform( effect_id )
	
	local stains = pen.t.pack( pen.magic_storage( effect_id, "add_stains", "value_string" ))
	local effects = pen.t.pack( pen.magic_storage( effect_id, "add_effects", "value_string" ))
	
	local range = pen.magic_storage( effect_id, "range", "value_float" )
	local check_walls = pen.magic_storage( effect_id, "check_walls", "value_bool" )
	local extra_check = pen.magic_storage( effect_id, "extra_check", "value_string" )
	
	local check = function( effect_id, entity_id, t_x, t_y ) return true end
	if( ModDoesFileExist( extra_check )) then check = dofile( extra_check ) end
	if( range > 0 ) then targets = pen.get_killable( x, y, range ) or targets end
	
	pen.t.loop( targets, function( i, entity_id )
		local t_x, t_y = pen.get_creature_head( entity_id )
		if( check_walls and RaytracePlatforms( x, y, t_x, t_y )) then return end
		if( not( check( effect_id, entity_id, t_x, t_y ))) then return end 
		
		pen.t.loop( stains, function( k, stain )
			EntityAddRandomStains( entity_id, CellFactory_GetType( stain[1]), tonumber( stain[2]))
		end)
		
		pen.t.loop( effects, function( k, effect )
			local eid = 0
			local is_real = false
			if( effect[4] == 1 ) then
				eid = pen.get_effect( entity_id, nil, effect[1])
				is_real = pen.vld( eid, true )
			end
			
			if( not( is_real )) then eid = LoadGameEffectEntityTo( entity_id, effect[2]) end
			local efct_comp = EntityGetFirstComponentIncludingDisabled( eid, "GameEffectComponent" )
			if( pen.vld( efct_comp, true )) then ComponentSetValue2( efct_comp, "frames", tonumber( effect[3])) end
		end)
	end)
end