return function( hooman, effect_id, is_added, is_removed )
    local x, y = pen.get_creature_centre( hooman )
    if( not( pen.magic_storage( effect_id, "got_scaled", "value_bool" ))) then
		local size = { min_x = -10, max_x = 10, min_y = -10, max_y = 10 }
		pen.t.loop( EntityGetComponentIncludingDisabled( effect_id, "ParticleEmitterComponent" ), function( i, v )
			size = pen.scale_emitter( hooman, v )
		end)
		pen.magic_storage( effect_id, "got_scaled", "value_bool", true )

		local size_x = ( math.abs( size.min_x ) + math.abs( size.max_x ))/2
		local size_y = ( math.abs( size.min_y ) + math.abs( size.max_y ))/2
		pen.magic_storage( effect_id, "got_scaled", "value_float", ( size_x + size_y )/2 )

        GamePlaySound( "mods/n40k/files/n40k.bank", "effects/status/warpfire_start", x, y )
	end
    
    --edge effect
    
    pen.t.loop({
        GameGetGameEffect( hooman, "PROTECTION_ALL" ) or 0,
        GameGetGameEffect( hooman, "PROTECTION_POLYMORPH" ) or 0,
        GameGetGameEffect( hooman, "SAVING_GRACE" ) or 0,
        GameGetGameEffect( hooman, "RESPAWN" ) or 0,
    }, function( i, immun )
        if( not( pen.vld( immun, true ))) then return end
        if( ComponentGetValue2( immun, "effect" ) == "NONE" ) then return end
        ComponentSetValue2( immun, "effect", "NONE" )
    end)

    if( pen.magic_storage( hooman, "is_hollowed", "value_bool" )) then return EntityKill( effect_id ) end
    local dmg_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
    if( not( pen.vld( dmg_comp, true ))) then return EntityKill( effect_id ) end
	local radius = pen.magic_storage( effect_id, "got_scaled", "value_float" )
    local max_hp = ComponentSetValue2( dmg_comp, "max_hp" )
    
    if( max_hp < 0.2 ) then
        radius = 4*radius
        EntityLoad( "mods/n40k/files/effects/explosion_warpfire.xml", x, y )
        pen.magic_storage( hooman, "is_hollowed", "value_bool", true )
        EntityKill( effect_id )
    else ComponentSetValue2( dmg_comp, "max_hp", 0.8*max_hp ) end

    pen.t.loop( pen.get_killable( x, y, math.min( radius, 50 )), function( i, meat_id )
		local dmg_comp = EntityGetFirstComponent( meat_id, "DamageModelComponent" )

		if( not( pen.vld( dmg_comp, true ))) then return end
        if( not( pen.is_entity_sapient( meat_id ))) then return end
        if( pen.magic_storage( meat_id, "is_hollowed", "value_bool" )) then return end
        if( pen.vld( pen.get_effect( meat_id, "n40k_effect_warpfire" ), true )) then return end

        LoadGameEffectEntityTo( meat_id, "mods/n40k/files/effects/status/warpfire.xml" )
	end)
end