return function( hooman, effect_id, is_added, is_removed )
	if( not( pen.magic_storage( effect_id, "got_scaled", "value_bool" ))) then
		pen.t.loop( EntityGetComponentIncludingDisabled( effect_id, "ParticleEmitterComponent" ), function( i, v )
			pen.scale_emitter( hooman, v )
		end)
		pen.magic_storage( effect_id, "got_scaled", "value_bool", true )
	end

	local dmg_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
	if( not( pen.vld( dmg_comp, true ))) then return end
	
	local hp = ComponentGetValue2( dmg_comp, "hp" )
	if( current_hp > ComponentGetValue2( dmg_comp, "max_hp" )*0.9 ) then return end
	ComponentSetValue2( dmg_comp, "hp", pen.rnd( hp + 0.001, 10000 ))
end