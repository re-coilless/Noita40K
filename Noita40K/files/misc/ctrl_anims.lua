return function( hooman )
    local char_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterDataComponent" )
    if( not( pen.vld( char_comp, true ))) then return end

    local frame_num = GameGetFrameNum()
    pen.c.anim_event_ground = pen.c.anim_event_ground or {}
    pen.c.anim_event_ground[ hooman ] = pen.c.anim_event_ground[ hooman ] or frame_num
    if( ComponentGetValue2( char_comp, "is_on_ground" )) then pen.c.anim_event_ground[ hooman ] = frame_num end
    local was_grounded = frame_num - pen.c.anim_event_ground[ hooman ] < 3

    local event = pen.magic_storage( hooman, "vector_anim_event", "value_string" )
    local event_frame = pen.magic_storage( hooman, "vector_anim_event_frame", "value_int" )
    if( not( pen.vld( event ) and pen.vld( event_frame ))) then return end
    
    pen.c.anim_event_prev = pen.c.anim_event_prev or {}
    pen.c.anim_event_prev[ hooman ] = pen.c.anim_event_prev[ hooman ] or 0
    if( pen.c.anim_event_prev[ hooman ] == event_frame ) then return end
    pen.c.anim_event_prev[ hooman ] = event_frame

    if( event == "jump_sfx" and was_grounded ) then
        local x, y = EntityGetTransform( hooman )
        pen.play_sound({ "mods/Noita40K/files/40K.bank", "classes/12/mk7/jump_rock" }, x, y )
    end
end