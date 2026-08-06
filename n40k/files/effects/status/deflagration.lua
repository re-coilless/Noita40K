return function( hooman, effect_id, is_added, is_removed )
	if( not( pen.magic_storage( effect_id, "got_scaled", "value_bool" ))) then
		pen.t.loop( EntityGetComponentIncludingDisabled( effect_id, "ParticleEmitterComponent" ), function( i, v )
			pen.scale_emitter( hooman, v )
		end)
		pen.magic_storage( effect_id, "got_scaled", "value_bool", true )
	end

	local dmg_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
	if( not( pen.vld( dmg_comp, true ))) then return end

	local eff_comp = EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent" )
	local will_weaken = ComponentGetValue2( eff_comp, "frames" ) > 10
	local k = will_weaken and 2 or 0.5
	
	if( pen.magic_storage( effect_id, "is_weakened", "value_bool" ) ~= will_weaken ) then
		ComponentObjectSetValue2( dmg_comp, "damage_multipliers",
			"fire", k*ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "fire" ))
		ComponentObjectSetValue2( dmg_comp, "damage_multipliers",
			"physics_hit", k*ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "physics_hit" ))
		pen.magic_storage( effect_id, "is_weakened", "value_bool", will_weaken )
	end
	
	local hp = ComponentGetValue2( dmg_comp, "hp" )
	ComponentSetValue2( dmg_comp, "is_on_fire", true )
	ComponentSetValue2( dmg_comp, "mFireFramesLeft", 600 )

	if( hp < 0.01 ) then
		local x, y = pen.get_creature_centre( hooman )
		EntityInflictDamage( hooman, 0.02, "DAMAGE_MATERIAL", "$n40k_MISC_dmg_burn", "NONE", 0, 0, nil, x, y, 0 )
	else ComponentSetValue2( dmg_comp, "hp", 0.999*hp ) end
end