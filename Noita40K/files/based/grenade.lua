if((( index or {}).D or {}).player_id ~= nil ) then
    return function( info )
        local xD = index.D
        if( xD.is_opened ) then return end
        if( xD.active_item ~= info.id ) then return end

        local clicked, r_clicked = pen.new_interface(
            xD.pointer_ui[1] - 10, xD.pointer_ui[2] - 10, 20, 20, pen.LAYERS.WORLD_BACK + 100 )
        if( r_clicked ) then
            local fuse = pen.magic_storage( info.id, "fuse", "value_int" )
            if( fuse < 0 ) then
                local x, y = EntityGetTransform( info.id )
                pen.play_sound({ "mods/Noita40K/files/40K.bank", "items/pin_pull" }, x, y )
                pen.magic_storage( info.id, "fuse", "value_int", math.abs( fuse or 60 ))
            end
        elseif( clicked ) then
            pen.magic_storage( info.id, "author", "value_int", xD.player_id )
            xD.throw_force = xD.throw_force*2 --this should depend on char strength (index should obtain char strength automatically)
            xD.drop_func( info.id )
        end
    end
end

dofile_once( "mods/Noita40K/files/_lib.lua" )

if( not( GetValueBool( "was_added", false ))) then
    SetValueBool( "was_added", true )
else --thanks Dexter and Horscht
    local entity_id = GetUpdatedEntityID()
    local exp = pen.magic_storage( entity_id, "explosion", "value_string" )
    if( string.find( exp, "%.lua$" ) == nil ) then
        local x, y = EntityGetTransform( entity_id )
        local who_shot = pen.magic_storage( entity_id, "author", "value_int" )
        pen.magic_storage( EntityLoad( exp, x, y ), "author", "value_int", who_shot )
    else dofile( exp )( entity_id ) end
end

function wake_up_waiting_threads()
    local entity_id = GetUpdatedEntityID()
    local fuse = pen.magic_storage( entity_id, "fuse", "value_int" )
    if(( fuse or -1 ) < 0 ) then return end
    pen.magic_storage( entity_id, "fuse", "value_int", fuse - 1 )
    
    local x, y = EntityGetTransform( entity_id )
    local pic_x, pic_y = pen.world2gui( x, y )
    local text = "["..math.floor(( fuse + 10 )/20 ).."]"
    pen.new_shadowed_text( pic_x, pic_y - 10, pen.LAYERS.WORLD_FRONT, text, {
        alpha = 0.75, is_centered_x = true, is_centered_y = true, color = pen.PALETTE.N40.HOLO_1 })
    
    if( fuse == 0 ) then EntityKill( entity_id ) end
end