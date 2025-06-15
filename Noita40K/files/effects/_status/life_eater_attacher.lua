local effect_id = GetUpdatedEntityID()
local deadman = EntityGetRootEntity( effect_id )

if( not( EntityHasTag( deadman, "life_eater_infected" ))) then
	EntityAddTag( deadman, "life_eater_infected" )
	local x, y = EntityGetTransform( deadman )
	EntityAddChild( deadman, EntityLoad( "mods/Noita40K/files/entities/status_effects/effect_life_eater.xml", x, y ))
end