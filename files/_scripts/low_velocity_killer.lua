dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local entity_id = GetUpdatedEntityID()

local min_vel = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "min_vel" ), "value_float" )
local v_x, v_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" ), "mVelocity" )
if( math.sqrt(( v_x )^2 + ( v_y )^2 ) < min_vel ) then
	local proj_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" )
	if( proj_comp ~= nil ) then
		local x, y, r, s_x, s_y = EntityGetTransform( entity_id )
		
		ComponentSetValue2( proj_comp, "velocity_sets_scale", false )
		EntitySetTransform( entity_id, x, y, r, get_sign( s_x ), get_sign( s_y ))
		ComponentSetValue2( proj_comp, "lifetime", 1 )
		EntityRemoveComponent( entity_id, GetUpdatedComponentID())
	else
		EntityKill( entity_id )
	end
end