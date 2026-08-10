return function( pic_x, pic_y, inv_info, xys, slot_func )
    local xD, xM, inv_id = index.D, index.M, inv_info.id
    if( EntityGetRootEntity( inv_id ) ~= xD.player_id ) then return end
    
    if( xD.Controls.rmb[1] ) then
        if( not( xM.twin_linked_ignore )) then
            if( pen.vld( xD.active_info ) and not( xD.active_info.uses_rmb )) then
                ComponentSetValue2( EntityGetFirstComponentIncludingDisabled(
                    EntityGetParent( inv_id ), "PlatformShooterPlayerComponent" ), "mForceFireOnNextUpdate", true )
            else xM.twin_linked_ignore = true end
        end
    else xM.twin_linked_ignore = false end
    
    local wand_id = xD.slot_state[ inv_id ][1][1]
    local core_x, core_y = unpack( xys.inv_root_orig )
    index.dft.slot( core_x - 19, core_y, {
        inv_slot = { 1, 1 },
        inv_id = inv_id, id = wand_id,
    }, index.D.is_opened, true, true )
end