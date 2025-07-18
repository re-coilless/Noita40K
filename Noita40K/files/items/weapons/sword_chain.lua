return function( info )
    local xD, xM = index.D, index.M

    pen.c.sword_state = pen.c.sword_state or {}
    pen.c.sword_state[ info.id ] = pen.c.sword_state[ info.id ] or {}
    if( xD.active_item ~= info.id ) then pen.c.sword_state[ info.id ].engine = false; return end

    -- stops working underwater (requires several attempts while outside to restart, no swinging)

    local may_swing = false
    pen.child_play( info.id, function( parent, child )
        may_swing = EntityHasTag( child, "blade40k" )
        if( may_swing ) then return true end
    end)

    local memo = pen.c.sword_state[ info.id ]
    local x, y = EntityGetTransform( info.id )
    local is_swinging, is_cutting = false, false
    local data = { m = 0.15, is_debugging = false, dmg = 5/25 }
    if( may_swing and ( xD.Controls.lmb[3] or memo.swing_start )) then
        data.active, memo.engine = true, true
        local shake = pen.generic_random( 0.5, 1.5, nil, true )
        if( not( memo.swing_done ) and memo.swing_start ) then
            --play extra sound
            data.drift = { r = 150, x = 5, y = 3 }
            is_swinging, data.dmg = true, 10*data.dmg
        elseif( memo.swing_done and xD.Controls.lmb[3]) then
            -- if triggered while blade is hitting the target, do x2 damage as long as every frame damage is dealt
            data.drift = { r = 80, x = 3 + shake, y = 2 + shake, a = "ixp0.15", m = 0.75 }
        else
            --charges up the swing (indicated by sound and sparks, at full charge starts applying heat)
            --add minimal charge level, letting go before it will abort the swing
            data.drift = { r = -30, x = -2 + shake/4, y = -4 + shake/4, a = "wgt2", m = 0.5 }
            memo.swing_start = not( xD.Controls.lmb[1])
        end

        is_cutting = memo.swing_start or memo.swing_done

        pen.play_sound({
            "mods/Noita40K/files/40K.bank", "items/guns/sword_chain/cut", true }, x, y )
        if( is_cutting ) then pen.play_sound({
            "mods/Noita40K/files/40K.bank", "items/guns/sword_chain/cut_", true }, x, y ) end
    else memo.swing_done, memo.swing_start = false, false end

    local max_heat = pen.magic_storage( info.id, "heat_max", "value_float" ) or -1
    data.on_hit = function( hit_id, hit_x, hit_y, dmg_mult, k )
        local is_metal = false --if got armor rating or ragdoll is made from metal
        pen.play_sound({ "mods/Noita40K/files/40K.bank",
            "items/guns/sword_chain/tear"..( is_metal and "_metal" or "" ), true }, hit_x, hit_y )
        
        -- permanently decrease physics_hit resistance
        -- do cutting vfxes based on blood type
        -- apply status effect that disables ai (name's Agony)

        if( max_heat <= 0 ) then return end
        pen.c.extra_heat = ( pen.c.extra_heat or 0 ) + 1 --only for metal
    end
    data.on_active = function( hooman, x, y, r, length )
        pen.magic_shooter( hooman, "mods/Noita40K/files/items/rounds/beam_sword_physical.xml",
            x + length*math.cos( r ), y + length*math.sin( r ), -600*math.cos( r ), -600*math.sin( r ))
    end
    if( pen.c.extra_heat ~= nil ) then
        local heat = pen.magic_storage( info.id, "heat", "value_float" ) or 0
        pen.magic_storage( info.id, "heat", "value_float", heat + pen.c.extra_heat )
        pen.c.extra_heat = nil
    end

    local is_done = pen.bladesim( info.id, data )
    if( is_done and is_swinging ) then memo.swing_done, memo.swing_start = true, false end
    if( not( memo.engine )) then return end

    local pics = EntityGetComponentIncludingDisabled( info.id, "SpriteComponent" )
    local anim = math.floor( GameGetFrameNum()/( is_cutting and 2 or 5 ))%2 == 0 and "A" or "B"
    ComponentSetValue2( pics[1], "image_file", "mods/Noita40K/files/items/weapons/sword_chain_"..anim..".png" )
    EntityRefreshSprite( info.id, pics[1])
    ComponentSetValue2( pics[2], "image_file", "mods/Noita40K/files/items/weapons/sword_chain_"..anim.."_heat.png" )
    EntityRefreshSprite( info.id, pics[2])

    pen.play_sound({ "mods/Noita40K/files/40K.bank", "items/guns/sword_chain/idle", true }, x, y )
    -- exaust (depends on engine state)
end