local entity_id = EntityGetRootEntity( GetUpdatedEntityID() or 0 ) or 0
if( entity_id > 0 ) then
	local proj_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" ) or 0
	if( proj_comp > 0 ) then ComponentSetValue2( proj_comp, "lifetime", 0 ) end
	local life_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "LifetimeComponent" ) or 0
	if( life_comp > 0 ) then ComponentSetValue2( life_comp, "lifetime", 0 ) end
	local vel_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" ) or 0
	if( vel_comp > 0 ) then ComponentSetValue2( vel_comp, "mVelocity", 0, 0 ) end
end