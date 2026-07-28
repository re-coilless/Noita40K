return function( hooman )
    local charge = pen.magic_storage( hooman, "reactor_charge", "value_float", nil, 0 )
    local limit = pen.magic_storage( hooman, "reactor_limit", "value_float", nil, 500 )
    if( charge > limit ) then
        --[[
        if( energy_cur > energy_cap ) then
            if( not( EntityHasTag( hooman, "system_overload" ))) then
                GamePlayAnimation( hooman, "knockback", 100 )
                GamePlaySound( "mods/n40k/files/n40k.bank", "fx/status_effects/overload/create", char_x, char_y )
                EntityAddTag( hooman, "system_overload" )
            end
            LoadGameEffectEntityTo( hooman, "mods/n40k/files/entities/status_effects/effect_system_overload.xml" )
        elseif( EntityHasTag( hooman, "system_overload" )) then
            GamePlaySound( "mods/n40k/files/n40k.bank", "fx/status_effects/overload/game_effect_end", char_x, char_y )
            EntityRemoveTag( hooman, "system_overload" )
        end
        ]]

        --apply system overload and only remove it once the charge gets above 0 again
        charge = -limit/5
    end
    
    local load_limit = 8
    local load = math.max( pen.magic_storage( hooman, "reactor_load", "value_int", nil, 1 ), 1 )
    local is_draining = charge > pen.magic_storage( hooman, "reactor_target", "value_float", nil, 100 )
    local delta = pen.rat( math.min( load, load_limit ), load_limit )
    if( is_draining ) then delta = -2*( 1 - delta ) end

    pen.magic_storage( hooman, "reactor_charge", "value_float", charge + delta/10 )
end