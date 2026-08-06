return function( hooman, effect_id, is_added, is_removed )
	if( not( pen.magic_storage( effect_id, "got_scaled", "value_bool" ))) then
		local size = { min_x = -10, max_x = 10, min_y = -10, max_y = 10 }
		pen.t.loop( EntityGetComponentIncludingDisabled( effect_id, "ParticleEmitterComponent" ), function( i, v )
			size = pen.scale_emitter( hooman, v )
		end)
		pen.magic_storage( effect_id, "got_scaled", "value_bool", true )

		local size_x = ( math.abs( size.min_x ) + math.abs( size.max_x ))/2
		local size_y = ( math.abs( size.min_y ) + math.abs( size.max_y ))/2
		pen.magic_storage( effect_id, "got_scaled", "value_float", ( size_x + size_y )/2 )
	end

	local x, y = pen.get_creature_centre( hooman )
	local radius = pen.magic_storage( effect_id, "got_scaled", "value_float" )
	pen.t.loop( pen.get_killable( x, y, math.max( radius, 10 )), function( i, meat_id )
		local dmg_comp = EntityGetFirstComponentIncludingDisabled( meat_id, "DamageModelComponent" )

		if( not( pen.vld( dmg_comp, true ))) then return end
		if( ComponentGetValue2( dmg_comp, "is_on_fire" )) then return end
		if( ComponentGetValue2( dmg_comp, "fire_probability_of_ignition" ) < 0.001 ) then return end

		ComponentSetValue2( dmg_comp, "is_on_fire", true )
		ComponentSetValue2( dmg_comp, "mFireFramesLeft", 600 )
	end)

	local dmg_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
	if( not( pen.vld( dmg_comp, true ))) then return end
	if( ComponentGetValue2( dmg_comp, "fire_probability_of_ignition" ) < 0.001 ) then return end
	
	local hp = ComponentGetValue2( dmg_comp, "hp" )
	ComponentSetValue2( dmg_comp, "is_on_fire", true )
	ComponentSetValue2( dmg_comp, "mFireFramesLeft", 600 )

	if( hp < 0.02 ) then
		EntityInflictDamage( hooman, 0.025, "DAMAGE_MATERIAL", "$n40k_MISC_dmg_burn", "NONE", 0, 0, nil, x, y, 0 )
	else ComponentSetValue2( dmg_comp, "hp", hp - 0.01 ) end
end