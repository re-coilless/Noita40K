dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local v_x, v_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" ), "mVelocity" )
v_x, v_y = v_x/60, v_y/60
if( RaytracePlatforms( x, y, x + v_x, y + v_y )) then
	local k = 1
	EntitySetTransform( entity_id, x - v_x*k, y - v_y*k )
	ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" ), "lifetime", 1 )
	EntityRemoveComponent( entity_id, GetUpdatedComponentID())
end