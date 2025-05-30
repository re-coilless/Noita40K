function collision_trigger( colliding_entity_id )
	local BAYONET_HIT_VELOCITY = 0.3
	local BAYONET_MAX_DAMAGE = 4
	local BAYONET_HIT_FORCE = 30

	local x, y = EntityGetTransform( colliding_entity_id )
	local enemy_vel_x, enemy_vel_y = GameGetVelocityCompVelocity( colliding_entity_id )
	
	local bayonet = GetUpdatedEntityID()
	local this_x = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( bayonet, "VariableStorageComponent", "this_x" ), "value_float" )
	local this_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( bayonet, "VariableStorageComponent", "this_y" ), "value_float" )
	local last_x = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( bayonet, "VariableStorageComponent", "last_x" ), "value_float" )
	local last_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( bayonet, "VariableStorageComponent", "last_y" ), "value_float" )
	
	local path_x = ( last_x - this_x )
	local path_y = ( last_y - this_y )
	local enemy_speed = math.sqrt( enemy_vel_x^2 + enemy_vel_y^2 )
	local bayonet_speed = math.sqrt( path_x^2 + path_y^2 )
	local damage = math.abs( bayonet_speed - enemy_speed )*BAYONET_HIT_VELOCITY
	
	if( damage > BAYONET_MAX_DAMAGE ) then
		damage = BAYONET_MAX_DAMAGE
	end
	
	if( damage > 1 ) then
		EntityInflictDamage( colliding_entity_id, damage, "DAMAGE_SLICE", "[DIE, DEMON]", "BLOOD_SPRAY", 0-path_x, 0-path_y, EntityGetRootEntity( GetUpdatedEntityID()), x, y, bayonet_speed*BAYONET_HIT_FORCE )
		-- ComponentSetValue2(GetGameEffectLoadTo( colliding_entity_id, "KNOCKBACK", true ), "frames", 30)
	
		local target_comp = EntityGetFirstComponentIncludingDisabled( colliding_entity_id, "CharacterDataComponent" )
		if( target_comp ~= nil ) then
			local target_mass = ComponentGetValue2( target_comp, "mass" )
			local target_velocity_x, target_velocity_y = ComponentGetValue2( target_comp, "mVelocity" )
			ComponentSetValueVector2( target_comp, "mVelocity", target_velocity_x + (( 0-path_x*BAYONET_HIT_FORCE )/target_mass ), target_velocity_y + (( 0-path_y*BAYONET_HIT_FORCE )/target_mass ))
		end
		
		if( EntityHasTag( colliding_entity_id, "robot" )) then
			GamePlaySound( "data/audio/Desktop/animals.bank", "animals/robot/damage/melee", x, y )
		else
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/bayonet_hit", x, y )
		end
	end
end