return function( hooman, effect_id, is_added, is_removed )
    if( not( pen.magic_storage( effect_id, "got_scaled", "value_bool" ))) then
		pen.t.loop( EntityGetComponentIncludingDisabled( effect_id, "ParticleEmitterComponent" ), function( i, v )
			pen.scale_emitter( hooman, v )
		end)
		pen.magic_storage( effect_id, "got_scaled", "value_bool", true )
	end
	
	--edge effect

	local x, y = pen.get_creature_centre( hooman )
	local is_flaming = pen.vld( GameGetGameEffect( hooman, "ON_FIRE" ), true )
	local is_burning = pen.vld( GameGetGameEffect( hooman, "INTERNAL_FIRE" ), true )

    local dmg_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
    if( not( pen.vld( dmg_comp, true ))) then return EntityKill( effect_id ) end

	local hp = ComponentGetValue2( dmg_comp, "hp" )
	if( hp <= 0 or is_flaming or is_burning ) then
		EntityLoad( "mods/n40k/files/effects/explosion_life_eater.xml", x, y )
		EntityKill( hooman )
	else ComponentSetValue2( dmg_comp, "hp", pen.rnd( hp - 0.005, 10000 )) end
end