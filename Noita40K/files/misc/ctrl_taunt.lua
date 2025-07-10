return function( hooman )
    local voice = pen.magic_storage( hooman, "taunt_voice", "value_string" )
    if( not( pen.vld( voice ))) then return end

    local bind = mnee.mnin( "bind", { "Noita40K", "taunt" }, { pressed = true, dirty = true })
    if( not( bind )) then return end

    pen.c.taunt_cooldown = ( pen.c.taunt_cooldown or 0 ) - pen.get_delta_time( "n40taunt" )
    if( pen.c.taunt_cooldown < 1 ) then pen.c.taunt_cooldown = 180 else return end

    local is_stressed = true
    local type = is_stressed and "_" or ""
    pen.play_sound({ "mods/Noita40K/files/40K.bank", "classes/"..voice..type })
end