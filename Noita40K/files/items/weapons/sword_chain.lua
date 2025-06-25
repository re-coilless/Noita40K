return function( info )
    -- chainsword should overheat while cutting through metal + permanently decrease physics_hit resistance
    -- make chainsword be a chainsaw (exhaust, engine revving) but make it stop working underwater (requires several attempts while outside to restart)
    local xD, xM = index.D, index.M
    if( xD.active_item ~= info.id ) then return end
    if( xD.Controls.lmb[1]) then pen.bladeshot( info.id ) end --the entire sword logic is handled here
end