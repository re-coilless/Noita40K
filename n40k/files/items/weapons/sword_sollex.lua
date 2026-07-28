return function( info )
    local xD, xM = index.D, index.M
    
	--sollex swing pattern is a stab with an upwards swing

    local gun_id = info.id
    pen.c.sword_state = pen.c.sword_state or {}
    pen.c.sword_state[ gun_id ] = pen.c.sword_state[ gun_id ] or {}
    local blade_x, blade_y = pen.get_hotspot_pos( gun_id, "shoot_pos" )
    if( xD.active_item ~= gun_id ) then
        if( pen.c.sword_state[ gun_id ].active ) then
            pen.play_sound( pen.S.N40K.SOLLEX_DIE, blade_x, blade_y ) end
        pen.c.sword_state[ gun_id ].active = false; return
    end

    local data = { dmg = 0.07, dmg_type = "DAMAGE_MATERIAL", dmg_msg = "sollex", dmg_effect = "NORMAL",
        will_choke = true, do_liquids = true,
        point_action = function( data, point_x, point_y, k, is_final )
            if( k%5 ~= 0 and not( is_final )) then return end
            local effect = "mods/n40k/files/items/rounds/effect_plasma_small.xml"
            pen.life_support( pen.c.beam_eff_ids, data.gun..k, effect, point_x, point_y )
        end,
    }

    --don't swing on initial activation
    if( not( pen.c.sword_state[ gun_id ].active )) then
        pen.c.sword_state[ gun_id ].active = xD.Controls.lmb[1]; return
    else pen.play_sound( pen.S.N40K.SOLLEX_IDLE, blade_x, blade_y ) end

	data.gun, data.uid = gun_id, gun_id
	data.shooter = EntityGetRootEntity( gun_id )
	local length = pen.magic_storage( gun_id, "blade_length", "value_float" )
	
	pen.c.beam_ids = pen.c.beam_ids or {}
	pen.child_play( pen.c.beam_ids[ gun_id ], function( parent, child, i )
		pen.t.loop( EntityGetComponentIncludingDisabled( child, "LaserEmitterComponent" ), function( i, comp )
			ComponentSetValue2( comp, "is_emitting", true )
		end)
	end)
	
	pen.c.beam_sfxes = pen.c.beam_sfxes or {}
    local x, y, r, s_x, s_y = EntityGetTransform( gun_id )
    local blade_path = "mods/n40k/files/items/rounds/beam_sollex.xml"
	local beam_id, is_new = pen.life_support( pen.c.beam_ids, gun_id, blade_path, blade_x, blade_y, r )
	if( is_new ) then
		pen.c.beam_sfxes[ beam_id ] = true
	elseif( pen.c.beam_sfxes[ beam_id ]) then
		pen.c.beam_sfxes[ beam_id ] = nil
		pen.play_sound( pen.S.N40K.SOLLEX_IGNITE, blade_x, blade_y )
	end

	pen.c.beam_eff_ids = pen.c.beam_eff_ids or {}
	local out = pen.raytrace_entities( blade_x, blade_y, r, length, function( hit_id, hit_x, hit_y, dmg_mult, k )
		pen.play_sound( pen.S.N40K.EFFECT_BURST, hit_x, hit_y )
		EntityInflictDamage( hit_id, dmg_mult*( data.dmg or 0.02 ), data.dmg_type or "DAMAGE_MATERIAL",
			data.dmg_msg or "beam", data.dmg_effect or "NORMAL", 0, 0, hooman, hit_x, hit_y, 0 )
	end, data )

    -- local is_done = pen.bladesim( info.id, data )
    -- explode projectiles
end