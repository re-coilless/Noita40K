return function( hooman, effect_id, is_added, is_removed )
	--maintain at certain lifetime
end

-- local effect_id = GetUpdatedEntityID()
-- local deadman = EntityGetRootEntity( effect_id )

-- if( not( EntityHasTag( deadman, "life_eater_infected" ))) then
-- 	EntityAddTag( deadman, "life_eater_infected" )
-- 	local x, y = EntityGetTransform( deadman )
-- 	EntityAddChild( deadman, EntityLoad( "mods/n40k/files/entities/status_effects/effect_life_eater.xml", x, y ))
-- end