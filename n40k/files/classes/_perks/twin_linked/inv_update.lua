return function( inv_info, info_old, info_new )
    local hooman = index.D.player_id
    local john_arm = EntityGetParent( inv_info.id )
    ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( john_arm, "PlatformShooterPlayerComponent" ), "mForceFireOnNextUpdate", false )

    local update_the_thing = false
    local is_linked = EntityHasTag( hooman, "twin_linked" )
    if( pen.vld( info_old.id, true )) then
        EntityRemoveTag( info_old.id, "left_linked" )
    elseif( not( is_linked )) then update_the_thing = 1 end

    if( pen.vld( info_new.id, true )) then
        EntityAddTag( info_new.id, "left_linked" )
        pen.t.loop( EntityGetComponentIncludingDisabled( info_new.id, "SpriteComponent", "item" ), function( i, comp )
            ComponentSetValue2( comp, "z_index", 0.62 + ( i - 1 )*0.0001 ); EntityRefreshSprite( info_new.id, comp )
        end)
    elseif( is_linked ) then update_the_thing = 2 end

    if( not( update_the_thing )) then return true end

    local is_twin = update_the_thing == 1
    if( is_twin ) then
        EntityAddTag( hooman, "twin_linked" )
    else EntityRemoveTag( hooman, "twin_linked" ) end
    
    local pic = GlobalsGetValue( "TWIN_LINKED_BODY", "mods/Twin-Linked/files/pics/player_handless.xml" )
    local pic_comp = EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "character" )
    ComponentSetValue2( pic_comp, "image_file", is_twin and pic or "data/enemies_gfx/player.xml" )
    local pic_comps = EntityGetComponentIncludingDisabled( hooman, "SpriteComponent" ) or {}
    for i,comp in ipairs( pic_comps ) do EntityRefreshSprite( hooman, comp ) end

    john_arm = pen.get_child( john_arm, "arm_r" )
    pic_comp = EntityGetFirstComponentIncludingDisabled( john_arm, "SpriteComponent" )
    ComponentSetValue2( pic_comp, "alpha", 2 - update_the_thing )
    EntityRefreshSprite( john_arm, pic_comp )
    
    return true
end