return function( info )
    -- chainsword should overheat while cutting through metal + permanently decrease physics_hit resistance
    -- make chainsword be a chainsaw (exhaust, engine revving) but make it stop working underwater (requires several attempts while outside to restart)
    -- second anim does x10 damage and is being charged up progressively (indicated by sound and sparks)
    -- if the third anim is triggered while blade is hitting the target, do x2 damage for the next 5 frames
    -- if no blade is installed, do nothing

    local xD, xM = index.D, index.M
    if( xD.active_item ~= info.id ) then return end
    pen.c.sword_state = pen.c.sword_state or {}
    pen.c.sword_state[ info.id ] = pen.c.sword_state[ info.id ] or {}
    
    local is_swinging = false
    local memo = pen.c.sword_state[ info.id ]
    local data = { m = 0.15, is_debugging = true }
    if( xD.Controls.lmb[3] or memo.swing_start ) then
        data.active = true
        local shake = pen.generic_random( 0.5, 1.5, nil, true )
        if( not( memo.swing_done ) and memo.swing_start ) then
            data.drift = { r = 130, x = 5, y = 3 }
            is_swinging = true
        elseif( memo.swing_done and xD.Controls.lmb[3]) then
            data.drift = { r = 80, x = 3 + shake, y = 2 + shake, a = "ixp0.15", m = 0.75 }
        else
            data.drift = { r = -30, x = -2 + shake/4, y = -4 + shake/4, a = "wgt2", m = 0.5 }
            memo.swing_start = not( xD.Controls.lmb[1])
        end
    else memo.swing_done, memo.swing_start = false, false end

    local is_done = pen.bladesim( info.id, data )
    if( is_done and is_swinging ) then memo.swing_done, memo.swing_start = true, false end
end