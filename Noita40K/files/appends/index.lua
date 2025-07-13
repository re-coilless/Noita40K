table.insert( GLOBAL_MUTATORS, function()
    dofile_once( "mods/Noita40K/files/_lib.lua" )
    local xD, xM = index.D, index.M

    xD.can_tinker = true
    xD.invs[ xD.invs_p.f ].kind = { "universal" }
    xD.invs[ xD.invs_p.f ].update = function( inv_info, item_info_old, item_info_new, slot_data )
        local equipment_zone = xD.inv_quick_size + 2
        local do_old = ( item_info_old.inv_slot or { equipment_zone })[1] >= equipment_zone
        local do_new = ( slot_data or {}).is_equipment

        xM.is_updating = true
        local func_out = pen.magic_storage( item_info_old.id, "update", "value_string" )
        if( do_old and pen.vld( func_out )) then dofile( func_out )( inv_info, item_info_old, true ) end
        local func_in = pen.magic_storage( item_info_new.id, "update", "value_string" )
        if( do_new and pen.vld( func_in )) then dofile( func_in )( inv_info, item_info_new, false ) end
        xM.is_updating = nil
    end

    local hooman = xD.player_id

    local eid_pr = hooman.."_r_anim"
    xM.char_flip_memo = xM.char_flip_memo or {}
    pen.c.estimator_memo = pen.c.estimator_memo or {}
    local x, y, r, s_x, s_y = EntityGetTransform( hooman )
    pen.c.estimator_memo[ eid_pr ] = (( xM.char_flip_memo[ hooman ] or s_x ) ~= s_x ) and 0 or r
    EntitySetTransform( hooman, x, y, pen.estimate( eid_pr, 0, "exp1.75" ), s_x, s_y )
    xM.char_flip_memo[ hooman ] = s_x
    
	local initer = "N40K_READY_TO_PURGE"
	if( GameHasFlagRun( initer )) then return end
	GameAddFlagRun( initer )

    GlobalsSetValue( mnee.G_FORCED, "1" )
	local active = n40.setup_character( hooman )
end)

GUI_STRUCT.bars.hp = function( screen_w, screen_h, xys )
    local xD = index.D
    local data = xD.DamageModel
    local pic_x, pic_y = unpack( xys.hp or { 3, 2 })
    
    xD.xys.world_tip = { screen_w + 23, 20 }
    
    local pain_flash = 0
    pen.hallway( function()
        if( not( pen.vld( data ))) then return end
        if( not( ComponentGetIsEnabled( data.comp ))) then return end
        if( data.hp_max <= 0 ) then return end
        
        local bar_data = index.new_vanilla_hp(
            pic_x, pic_y, pen.LAYERS.MAIN_BACK, xD.player_id, { dmg_data = data, length = 50, is_left = true })
        pain_flash = bar_data.red_shift

        local hp_max_text, hp_text = pen.get_short_num( bar_data.hp_max ), pen.get_short_num( bar_data.hp )
        local tip = index.hud_text_fix( "$hud_health" )..( xD.short_hp and hp_text.."/"..hp_max_text or bar_data.hp.."/"..bar_data.hp_max )
        index.tipping( pic_x - 2, pic_y - 1, nil,
            { bar_data.length + 4, 8 }, tip, { pos = { pic_x + bar_data.length + 5, pic_y + 1 }})
        pic_y = pic_y + 10
    end)
    GameSetPostFxParameter( "low_health_indicator_alpha_proper", xD.hp_flashing_intensity*pain_flash, 0, 0, 0 )

    return { pic_x, pic_y }
end
GUI_STRUCT.bars.air = function( screen_w, screen_h, xys ) return { unpack( xys.hp )} end
GUI_STRUCT.bars.flight = function( screen_w, screen_h, xys ) return { unpack( xys.air )} end
GUI_STRUCT.bars.action.mana = function( screen_w, screen_h, xys ) return { unpack( xys.flight )} end
GUI_STRUCT.bars.action.reload = function( screen_w, screen_h, xys ) return { unpack( xys.mana )} end
GUI_STRUCT.bars.action.delay = function( screen_w, screen_h, xys ) return { unpack( xys.reload )} end
GUI_STRUCT.gold = function( screen_w, screen_h, xys ) return { unpack( xys.delay )} end
GUI_STRUCT.orbs = function( screen_w, screen_h, xys ) return { unpack( xys.gold )} end

GUI_STRUCT.icons.ingestions = function( screen_w, screen_h, xys )
    local xD = index.D
    local pic_x, pic_y = screen_w - 41, 20

    local data = xD.icon_data.ings
    pen.hallway( function()
        if( not( pen.vld( data ))) then return end
        if( xD.is_opened or xD.gmod.menu_capable ) then return end
        pic_y = pic_y + 3

        for i,info in ipairs( data ) do
            local step_x, step_y = xD.icon_func( pic_x, pic_y, pen.LAYERS.MAIN, info, 1 )
            pic_x, pic_y = pic_x, pic_y + step_y - 1
        end

        pic_y = pic_y + 4
    end)
    return { pic_x, pic_y }
end
GUI_STRUCT.icons.stains = function( screen_w, screen_h, xys )
    local xD = index.D
    local data = xD.icon_data.stains
    local pic_x, pic_y = unpack( xys.ingestions )
    pen.hallway( function()
        if( not( pen.vld( data ))) then return end
        if( xD.is_opened or xD.gmod.menu_capable ) then return end

        for i,info in ipairs( data ) do
            local step_x, step_y = xD.icon_func( pic_x, pic_y, pen.LAYERS.MAIN, info, 2 )
            pic_x, pic_y = pic_x, pic_y + step_y
        end

        pic_y = pic_y + 3
    end)
    return { pic_x, pic_y }
end
GUI_STRUCT.icons.effects = function( screen_w, screen_h, xys )
    local xD = index.D
    local data = xD.icon_data.misc
    local pic_x, pic_y = unpack( xys.stains )
    pen.hallway( function()
        if( not( pen.vld( data ))) then return end
        if( xD.is_opened or xD.gmod.menu_capable ) then return end

        for i,info in ipairs( data ) do
            if( info.amount < 2 ) then info.txt = "" end
            local step_x, step_y = xD.icon_func( pic_x, pic_y, pen.LAYERS.MAIN, info, 3 )
            pic_x, pic_y = pic_x, pic_y + step_y
        end

        pic_y = pic_y + 3
    end)
    return { pic_x, pic_y }
end
GUI_STRUCT.icons.perks = function( screen_w, screen_h, xys ) return { unpack( xys.effects )} end

GUI_STRUCT.gmodder = function( screen_w, screen_h, xys )
    local xD = index.D
    local data = xD.gmod
    if( not( xD.is_opened )) then return end
    if( not( pen.vld( data ))) then return end
    if( data.is_hidden ) then return end
    
    local w, h = pen.get_text_dims( data.name, true )
    local pic_x, pic_y = ( screen_w + w )/2, 13
    
    local new_mode = xD.global_mode
    local arrow_left_c, arrow_right_c = nil, nil
    local gonna_reset, gonna_highlight, arrow_left_a, arrow_right_a = false, false, 0.3, 0.3
    local clicked, r_clicked, is_hovered = pen.new_interface( pic_x - ( 11 + w ), pic_y - 11, 15, 10, pen.LAYERS.TIPS )
    if( is_hovered ) then arrow_left_c, arrow_left_a = pen.PALETTE.VNL.YELLOW, 1 end
    gonna_reset, gonna_highlight = gonna_reset or r_clicked, gonna_highlight or is_hovered
    if( clicked or index.get_input( "invmode_previous" )) then new_mode, arrow_left_a = new_mode - 1, 1 end
    
    clicked, r_clicked, is_hovered = pen.new_interface( pic_x - 10, pic_y - 11, 15, 10, pen.LAYERS.TIPS )
    if( is_hovered ) then arrow_right_c, arrow_right_a = pen.PALETTE.VNL.YELLOW, 1 end
    gonna_reset, gonna_highlight = gonna_reset or r_clicked, gonna_highlight or is_hovered
    if( clicked or index.get_input( "invmode_next" )) then new_mode, arrow_right_a = new_mode + 1, 1 end
    
    is_hovered, clicked, r_clicked = index.tipping( pic_x - ( 6 + w ), pic_y - 11, pen.LAYERS.TIPS, { w + 6, 10 },
        { data.name, data.desc }, { tid = "slot", fully_featured = true, pos = { pic_x, pic_y }, is_left = true, do_corrections = true })
    gonna_reset, gonna_highlight = gonna_reset or r_clicked, gonna_highlight or is_hovered

    if( gonna_reset ) then for i,gmod in ipairs( xD.gmods ) do if( gmod.is_default ) then new_mode = i; break end end end

    pen.new_text( pic_x - ( 3 + w ), pic_y - ( 2 + h ),
        pen.LAYERS.MAIN, data.name, { color = data.color, alpha = gonna_highlight and 1 or 0.3 })
    xD.box_func( pic_x - ( 4 + w ), pic_y - 9, pen.LAYERS.MAIN_BACK, { w + 2, 6 })
    
    pen.new_image( pic_x - ( 12 + w ), pic_y - 10, pen.LAYERS.MAIN_BACK,
        "data/ui_gfx/keyboard_cursor_right.png", { color = arrow_left_c, alpha = arrow_left_a })
    pen.new_image( pic_x - 2, pic_y - 10, pen.LAYERS.MAIN_BACK,
        "data/ui_gfx/keyboard_cursor.png", { color = arrow_right_c, alpha = arrow_right_a })

    if( xD.global_mode == new_mode ) then return end

    local go_ahead = true
    while( go_ahead ) do
        if( new_mode > #xD.gmods ) then new_mode = 1 elseif( new_mode < 1 ) then new_mode = #xD.gmods end
        go_ahead = xD.gmods[ new_mode ].is_hidden or false
        if( go_ahead ) then new_mode = new_mode + ( arrow_left_a == 1 and -1 or 1 ) end
    end

    index.play_sound( gonna_reset and "reset" or "click" )
    GlobalsSetValue( index.GLOBAL_GLOBAL_MODE, tostring( new_mode ))
end

GUI_STRUCT.full_inv = function( screen_w, screen_h, xys )
    local xD, xM = index.D, index.M
    local root_x, root_y = unpack( xys.full_inv or { 0, 0 })
    local pic_x, pic_y = root_x, root_y
    
    local function check_shortcut( id, is_quickest )
        if( id <= 4 ) then return index.get_input(( is_quickest and "quickest_" or "quick_" )..id ) end
    end
    
    xD.xys.wands = { 40, 20 }
    -- show a weapon+item wheel at the pointer, force 20 fps when holding down weapon select button
    -- add small non-clickable indicators of equipped weapons and items at the bottom left of the screen

    local w, h, step = 0, 0, 1
    if( xD.is_opened ) then
        if( not( xD.gmod.can_see )) then
            local delta = math.max(( xM.inv_alpha or xD.frame_num ) - xD.frame_num, 0 )
            local alpha = 0.5*math.cos( math.pi*delta/30 )
            pen.new_image( -2, -2, pen.LAYERS.BACKGROUND + 1.1,
                "data/ui_gfx/empty_black.png", { s_x = screen_w + 4, s_y = screen_h + 4, alpha = alpha })
        end

        local full_depth = #xD.slot_state[ xD.invs_p.f ][1]
        xys.inv_root, xys.full_inv = { root_x - 3, root_y - 3 }, { root_x + 2, root_y + 26 }

        local gun_belt_y = 20
        for i,slot in ipairs( xD.slot_state[ xD.invs_p.q ].quickest ) do
            w, h = index.new_generic_slot( pic_x + 10, gun_belt_y, {
                inv_slot = { i, -1 },
                inv_id = xD.invs_p.q, id = slot,
            }, xD.is_opened, false, true )
            gun_belt_y = gun_belt_y + h + step
        end

        local item_belt_x = screen_w - ( xD.inv_quick_size*20 + 35 ) --space for quests and main menu
        local backpack_x, backpack_y = item_belt_x, 20
        for i,slot in ipairs( xD.slot_state[ xD.invs_p.q ].quick ) do
            w, h = index.new_generic_slot( item_belt_x, 0, {
                inv_slot = { i, -2 },
                inv_id = xD.invs_p.q, id = slot,
            }, xD.is_opened, false, true )
            item_belt_x = item_belt_x + w + step
        end
        for i = 1,( xD.inv_quick_size + 1 ) do
            for e = 1,( xD.inv_quick_size - 1 ) do
                w, h = index.new_generic_slot( backpack_x, backpack_y, {
                    inv_slot = { i, e },
                    inv_id = xD.invs_p.f, id = xD.slot_state[ xD.invs_p.f ][i][e],
                }, xD.is_opened, true, false )
                backpack_y = backpack_y + h + step
            end
            backpack_x, backpack_y = backpack_x + w + step, 20
        end

        --do a proper equipment size variable
        local equipment_size = xD.inv_quick_size + 2
        local equipment_x = screen_w - equipment_size*20
        for k = 1,equipment_size do
            local i, e = xD.inv_quick_size + k + 1, 1
            w, h = index.new_generic_slot( equipment_x, screen_h - 20, {
                is_equipment = true,
                inv_slot = { i, e }, inv_id = xD.invs_p.f,
                id = xD.slot_state[ xD.invs_p.f ][i][e],
            }, xD.is_opened, true, false )
            equipment_x = equipment_x + w + step
        end
    end
    
    xD.xys.inv_root_orig = { root_x, root_y }
    xD.xys.full_inv_orig = { pic_x, pic_y }
    if( xD.Controls.inv[2]) then xD.inv_toggle = true end
    return { root_x, root_y }, { pic_x, pic_y }
end

GUI_STRUCT.info = function( screen_w, screen_h, xys )
    local xD, xM = index.D, index.M
    local function do_info( p_x, p_y, txt, alpha, is_right, hover_func )
        local offset_x = 0
        txt = pen.capitalizer( txt )
        if( is_right ) then
            local w,h = pen.get_text_dims( txt, true )
            offset_x = w + 1; p_x = p_x - offset_x
        end

        local color = pen.vld( hover_func ) and hover_func( offset_x ) or nil
        pen.new_shadowed_text( p_x, p_y, pen.LAYERS.MAIN, txt, { color = color, alpha = alpha })
    end
    
    local pic_x, pic_y = 0, 0
    xM.ui_info = xM.ui_info or { 0, 0 }
    pen.hallway( function()
        if( xD.is_opened and xD.gmod.show_full ) then return end
        if( xM.ui_info[1] == 0 and xD.pointer_delta[3] >= xD.info_threshold ) then return end

        local info = ""
        local best_kind, dist_tbl = -1, {}
        local x, y = unpack( xD.pointer_world )
        pen.t.loop( EntityGetInRadius( x, y, xD.info_radius ), function( i, entity_id )
            if( entity_id == xD.player_id ) then return end
            if( EntityGetRootEntity( entity_id ) ~= entity_id ) then return end

            local kind, name = {}, ""
            local item_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "ItemComponent" )
            local info_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "UIInfoComponent" )
            if( pen.vld( info_comp, true )) then name = GameTextGetTranslatedOrNot( ComponentGetValue2( info_comp, "name" ) or "" ) end

            if( index.check_item_name( name )) then
                kind = { 0, name }
            elseif( pen.vld( item_comp, true ) and ComponentGetValue2( item_comp, "is_pickable" )) then
                local name_func = function( item_id, item_comp, default_name )
                    local name = index.get_entity_name( item_id, item_comp )
                    return pen.vld( name ) and name or default_name
                end
                pen.t.loop( xD.item_cats, function( k, cat )
                    if( not( cat.on_check( entity_id ))) then return end
                    local func = pen.vld( cat.on_info_name ) and cat.on_info_name or name_func
                    kind = { k, func( entity_id, item_comp, cat.name )}
                    return true
                end)
            elseif( EntityHasTag( entity_id, "hittable" ) or EntityHasTag( entity_id, "mortal" )) then
                name = index.get_entity_name( entity_id )
                if( index.check_item_name( name )) then kind = { 0, GameTextGetTranslatedOrNot( name )} end
            end

            if( not( pen.vld( kind ))) then return end
            if( best_kind < 0 or best_kind > kind[1]) then best_kind = kind[1] end
            table.insert( dist_tbl, { entity_id, unpack( kind )})
        end)
        if( pen.vld( dist_tbl )) then
            local the_one = pen.get_closest(
                xD.pointer_world[1], xD.pointer_world[2], dist_tbl, nil, nil, function( thing ) return thing[2] == best_kind end)
            if( the_one ~= 0 ) then info = the_one[3] end
        end
        
        local fading = 1
        if( index.check_item_name( info )) then
            xM.ui_info = { info, math.max( xM.ui_info[2], xD.frame_num )}
        elseif( xM.ui_info[1] ~= 0 ) then
            info = xM.ui_info[1]

            local delta = xD.frame_num - xM.ui_info[2]
            if( delta > 2*xD.info_fading ) then
                xM.ui_info, info = nil, ""
            elseif( delta > xD.info_fading ) then
                fading = math.max( fading*math.sin(( 2*xD.info_fading - delta )*math.pi/( 2*xD.info_fading )), 0.01 )
            end
        end

        if( not( pen.vld( info ))) then return end
        local tip_anim = (( pen.c.ttips or {})[ "dft" ] or {}).going or 0
        local is_obstructed = xD.dragger.item_id > 0 or ( xD.frame_num - tip_anim ) < 2

        pic_x, pic_y = unpack( xD.pointer_ui )
        pic_x, pic_y = pic_x + ( is_obstructed and -2 or 6 ), pic_y + 3
        do_info( pic_x, pic_y, info, fading*xD.info_pointer_alpha, is_obstructed )
    end)
    pen.hallway( function()
        if( xD.gmod.menu_capable ) then return end

        xM.mtr_prb = xM.mtr_prb or { 0, 0 }
        local fading, matter = 0.5, xM.mtr_prb[1]
        if( xD.pointer_matter > 0 ) then
            matter = xD.pointer_matter
            xM.mtr_prb = { xD.pointer_matter, math.max( xM.mtr_prb[2], xD.frame_num )}
        elseif( xM.mtr_prb[1] > 0 ) then
            local delta = xD.frame_num - xM.mtr_prb[2]
            if( delta > 2*xD.info_fading ) then
                xM.mtr_prb, matter = nil, 0
            elseif( delta > xD.info_fading ) then
                fading = math.max( fading*math.sin(( 2*xD.info_fading - delta )*math.pi/( 2*xD.info_fading )), 0.01 )
            end
        end

        if( matter == 0 and xD.info_mtr_state ~= 3 ) then return end
        if( xD.info_mtr_state ~= 1 or xM.mtr_prb[2] > xD.frame_num ) then
            fading = xD.info_mtr_state == 3 and 1 or math.min( fading*4, 1 )
        end
        
        local no_matter = xD.info_mtr_state == 3 and matter == 0
        local txt = GameTextGetTranslatedOrNot( no_matter and "$mat_air" or CellFactory_GetUIName( matter ))
        do_info( screen_w - 5, 3, txt, fading, true, function( offset_x )
            local _,_,is_hovered = pen.new_interface( pic_x + 2 - offset_x, pic_y - 1, offset_x, 8, pen.LAYERS.TIPS )
            if( is_hovered ) then xM.mtr_prb = { matter, xD.frame_num + 300 } end
            return is_hovered and pen.PALETTE.VNL.YELLOW or pen.PALETTE.W
        end)
    end)
    return { pic_x, pic_y }
end

local wand_cat = pen.t.get( ITEM_CATS, "WAND", nil, nil, {})
local spell_cat = pen.t.get( ITEM_CATS, "SPELL", nil, nil, {})
local item_cat = pen.t.get( ITEM_CATS, "ITEM", nil, nil, {})

table.insert( ITEM_CATS, 1, {
    id = "GUN40K",
    name = "Gun",
    is_wand = true, is_quickest = true,
    
    on_check = function( item_id ) return EntityHasTag( item_id, "gun40k" ) end,
    on_data = function( info, wip_item_list )
        local xD, xM = index.D, index.M
        info.wand_info = {
            shuffle_deck_when_empty = ComponentObjectGetValue2( info.AbilityC, "gun_config", "shuffle_deck_when_empty" ),
            actions_per_round = ComponentObjectGetValue2( info.AbilityC, "gun_config", "actions_per_round" ),
            deck_capacity = ComponentObjectGetValue2( info.AbilityC, "gun_config", "deck_capacity" ),
            spread_degrees = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "spread_degrees" ),
            mana_max = ComponentGetValue2( info.AbilityC, "mana_max" ),
            mana_charge_speed = ComponentGetValue2( info.AbilityC, "mana_charge_speed" ),
            mana = ComponentGetValue2( info.AbilityC, "mana" ),

            never_reload = ComponentGetValue2( info.AbilityC, "never_reload" ),
            reload_time = ComponentObjectGetValue2( info.AbilityC, "gun_config", "reload_time" ) +
                            ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "reload_time" ),
            delay_time = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "fire_rate_wait" ),
            reload_frame = math.max( ComponentGetValue2( info.AbilityC, "mReloadNextFrameUsable" ) - xD.frame_num, 0 ),
            delay_frame = math.max( ComponentGetValue2( info.AbilityC, "mNextFrameUsable" ) - xD.frame_num, 0 ),

            speed_multiplier = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "speed_multiplier" ),
            lifetime_add = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "lifetime_add" ),
            bounces = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "bounces" ),

            crit_chance = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "damage_critical_chance" ),
            crit_mult = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "damage_critical_multiplier" ),

            damage_electricity_add = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "damage_electricity_add" ),
            damage_explosion_add = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "damage_explosion_add" ),
            damage_fire_add = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "damage_fire_add" ),
            damage_melee_add = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "damage_melee_add" ),
            damage_projectile_add = ComponentObjectGetValue2( info.AbilityC, "gunaction_config", "damage_projectile_add" ),
        }
        
        local check_func = function( inv_info, item_info ) --ultra cancer
            --ammo type check
            --make sure attachment type matches slot type
            --use inv_info.inv_slot to make sure player is only allowed to swap to true wand slots
            
            if( not( item_info.is_spell )) then return false end
            
            local is_phantom = EntityHasTag( item_info.id, "phantom40k" )
            if( is_phantom ) then
                local is_local = item_info.inv_id == inv_info.inv_id
                local gun_info = pen.t.get( index.D.item_list, item_info.inv_id, nil, nil, {})
                local deck_cap = ( gun_info.wand_info or {}).deck_capacity or inv_info.inv_slot[1]
                local is_valid = item_info.spell_id == inv_info.spell_id and is_local
                local is_without = inv_info.inv_slot[1] > deck_cap and is_local
                
                local is_allowed = is_valid or is_without
                local is_same = inv_info.id == item_info.id
                if( is_allowed and not( is_same ) and pen.vld( inv_info.id, true )) then    
                    local mag_id = inv_info.id
                    local max_ammo = pen.magic_storage( mag_id, "ammo_max", "value_int" )
                    pen.magic_storage( mag_id, "ammo", "value_int", max_ammo )
                    
                    local phantom_id = item_info.id
                    --discarded mag continues flying with gravity past the slot it wanted to swap with not matter if inv is closed or opened
                    
                    pen.play_sound({ "mods/Noita40K/files/40K.bank", "items/guns/reload" }, index.D.player_xy[1], index.D.player_xy[2])
                end
                
                return is_without and not( pen.vld( inv_info.id, true )) --is_allowed and not( is_same )
            end

            return true
        end
        local update_func = function( inv_info, item_info_old, item_info_new, slot_data )
            index.M.is_updating = true
            local func_out = pen.magic_storage( item_info_old.id, "update", "value_string" )
            if( pen.vld( func_out )) then dofile( func_out )( inv_info, item_info_old, true ) end
            local func_in = pen.magic_storage( item_info_new.id, "update", "value_string" )
            if( pen.vld( func_in )) then dofile( func_in )( inv_info, item_info_new, false ) end
            index.M.is_updating = nil

            return pen.vld( inv_info.in_hand, true )
        end
        local sort_func = function( a, b )
            local inv_slot = { 0, 0 }
            local is_perma = { false, false }
            pen.t.loop({ a, b }, function( i,v )
                local item_comp = EntityGetFirstComponentIncludingDisabled( v, "ItemComponent" )
                if( not( pen.vld( item_comp, true ))) then return end
                is_perma[i] = ComponentGetValue2( item_comp, "permanently_attached" )
                inv_slot[i] = math.max( ComponentGetValue2( item_comp, "inventory_slot" ), 0 )
            end)
            return ( is_perma[1] and not( is_perma[2])) or ( not( is_perma[2]) and inv_slot[1] < inv_slot[2])
        end
        
        xD.invs_i[ info.id ] = index.get_inv_info(
            info.id, { 2*info.wand_info.deck_capacity, 1 }, { "full" }, nil, check_func, update_func, nil, sort_func )
        
        pen.child_play( info.id, function( parent, child, i )
            local max_ammo = pen.magic_storage( child, "ammo_max", "value_int" ) or -1
            local ammo = pen.magic_storage( child, "ammo", "value_int" ) or max_ammo
            if( max_ammo < 0 or ammo >= max_ammo ) then return end
            
            --there should be only one per wand per type

            xM.phantom_ids = xM.phantom_ids or {}
            local phantom_id, is_new = pen.life_support( xM.phantom_ids,
                info.id..":"..child, "mods/Noita40K/files/based/phantom_mag.xml", EntityGetTransform( child ))
            if( is_new ) then
                EntityAddChild( info.id, phantom_id )

                local act_comp = EntityGetFirstComponentIncludingDisabled( child, "ItemActionComponent" )
                pen.magic_storage( phantom_id, "phantom_id", "value_string", ComponentGetValue2( act_comp, "action_id" ))

                -- there should be a way to control inv slots in proper manner
                local item_comp = EntityGetFirstComponentIncludingDisabled( phantom_id, "ItemComponent" )
                ComponentSetValue2( item_comp, "inventory_slot", info.wand_info.deck_capacity + i, -5 )
            elseif( EntityGetParent( phantom_id ) ~= info.id ) then EntityKill( phantom_id ) end
        end)

        return info
    end,
    on_processed_forced = wand_cat.on_processed_forced,

    on_tooltip = wand_cat.on_tooltip,
    on_inventory = function( info, pic_x, pic_y, state_tbl, slot_dims )
        -- first mag slots, then attachment slots (every attachment slot schematically points to the part of the gun it will occupy; allow overriding on-hover slot numbers with custom text)
        -- dynamically add attachment slots based on hotspots

        local xD = index.D
        if( not( xD.is_opened )) then return end
        if( not( state_tbl.is_quick )) then return end
        if( not( xD.gmod.allow_wand_editing )) then return end
        pic_x, pic_y = unpack( pen.vld( xD.xys.wands ) and xD.xys.wands or xD.xys.full_inv )
        local w, h = xD.wand_func( pic_x - 3*pen.b2n( state_tbl.in_hand ), pic_y + 2, info, state_tbl.in_hand )
        xD.xys.wands = { pic_x, pic_y + h }

        pen.t.loop( xD.slot_state[ info.id ], function( i,slot )
            local mag_id = slot[1]
            if( EntityHasTag( mag_id, "phantom40k" )) then
                pic_x = pic_x + index.new_generic_slot( pic_x + w, pic_y + 3, {
                    inv_slot = { i, 1 }, inv_id = info.id, id = mag_id,
                }, true, true, false ) + 3
            end
        end)
    end,
    on_slot = wand_cat.on_slot, -- in-slot color-based mag percentage indicators but no literal bullet counters except for the ones on-screen

    on_gui_world = wand_cat.on_gui_world,
    on_gui_pause = wand_cat.on_gui_pause,
    on_pickup = wand_cat.on_pickup,
})

table.insert( ITEM_CATS, 2, {
    id = "MAG40K",
    name = "Mag",
    is_spell = true,

    on_check = function( item_id ) return EntityHasTag( item_id, "mag40k" ) end,
    on_data = function( info, wip_item_list )
        local xD = index.D
        if( info.is_permanent ) then info.charges = -1 end

        info.ActionC = EntityGetFirstComponentIncludingDisabled( info.id, "ItemActionComponent" )

        info.spell_id = ComponentGetValue2( info.ActionC, "action_id" )
        info.spell_info = pen.get_spell_data( info.spell_id )
        info.pic = info.spell_info.sprite
        
        info.tip_name = pen.capitalizer( GameTextGetTranslatedOrNot( info.spell_info.name ))
        info.name = info.tip_name..( info.charges >= 0 and " ("..info.charges..")" or "" )
        info.desc = index.full_stopper( GameTextGetTranslatedOrNot( info.spell_info.description ))
        info.tip_name = string.upper( info.tip_name )
        
        local parent_id = EntityGetParent( info.id )
        if( pen.vld( parent_id, true ) and pen.vld( xD.invs[ parent_id ])) then
            parent_id = pen.t.get( wip_item_list, parent_id, nil, nil, {})
            if( parent_id.is_wand ) then info.in_wand = parent_id.id end
        end

        local may_use = pen.vld( info.AbilityC, true )
        may_use = may_use and GameGetGameEffectCount( xD.player_id, "ABILITY_ACTIONS_MATERIALIZED" ) > 0
        may_use = may_use and ComponentGetValue2( info.AbilityC, "use_entity_file_as_projectile_info_proxy" )
        if( may_use ) then info.inv_cat = 0 end
        return info
    end,
    on_processed = spell_cat.on_processed,

    on_tooltip = spell_cat.on_tooltip,
    on_slot_check = spell_cat.on_slot_check,
    on_swap = spell_cat.on_swap,
    on_slot = spell_cat.on_slot, -- in-slot color-based mag percentage indicators but no literal bullet counters except for the ones on-screen

    on_gui_world = spell_cat.on_gui_world,
})

table.insert( ITEM_CATS, 3, {
    id = "EQUIPMENT40K",
    name = "Equipment",

    -- SpriteStainsComponent sprite_id for multisprite stains
    -- all equipment should be hotspot attached as it must be universal

    on_check = function( item_id ) return EntityHasTag( item_id, "equipment40k" ) end,
    on_data = item_cat.on_data,
    
    on_tooltip = item_cat.on_tooltip,
    on_slot = item_cat.on_slot,

    on_gui_world = item_cat.on_gui_world,
    on_pickup = item_cat.on_pickup,
})

table.insert( ITEM_CATS, 4, {
    id = "ATTACHMENT40K",
    name = "Attachment",
    is_spell = true,

    on_check = function( item_id ) return EntityHasTag( item_id, "attachment40k" ) end,
    on_data = item_cat.on_data,
    on_processed = spell_cat.on_processed,

    on_tooltip = item_cat.on_tooltip,
    on_slot_check = spell_cat.on_slot_check,
    on_swap = spell_cat.on_swap,
    on_slot = function( info, pic_x, pic_y, state_tbl, rmb_func, drag_func, hov_func, hov_scale, slot_dims )
        local xD, xM = index.D, index.M
        local angle, anim_speed = 0, xD.spell_anim_frames
        local is_considered = state_tbl.is_dragged or state_tbl.is_hov
        if( state_tbl.can_drag ) then
            angle = -math.rad( 5 )
            if( not( is_considered )) then
                angle = anim_speed == 0 and 0 or angle*math.sin(( xD.frame_num%%anim_speed )*math.pi/anim_speed )
            else angle = 1.5*angle end
        end
        
        local pic_z = index.slot_z( info.id, pen.LAYERS.ICONS )
        index.new_slot_pic( pic_x, pic_y, pic_z, info.pic, false, hov_scale, false, nil, angle )
        local is_active = pen.vld( hov_func ) and state_tbl.is_hov and state_tbl.is_opened
        index.pinning({ "slot", info.id }, is_active, hov_func, { info, "slot", pic_x - 10, pic_y + 7, pen.LAYERS.TIPS, true })

        return info, ( state_tbl.is_hov and state_tbl.can_drag ) and 1 or nil
    end,

    on_gui_world = spell_cat.on_gui_world,
})

table.insert( ITEM_CATS, 3, {
    id = "PHANTOM40K",
    name = "Phantom Mag",
    is_spell = true,

    on_check = function( item_id ) return EntityHasTag( item_id, "phantom40k" ) end,
    on_data = function( info, wip_item_list )
        local xD = index.D
        if( info.is_permanent ) then info.charges = -1 end

        info.spell_id = pen.magic_storage( info.id, "phantom_id", "value_string" )
        info.spell_info = pen.get_spell_data( info.spell_id )
        info.pic = info.spell_info.sprite
        
        info.tip_name = pen.capitalizer( GameTextGetTranslatedOrNot( info.spell_info.name ))
        info.name = info.tip_name..( info.charges >= 0 and " ("..info.charges..")" or "" )
        info.desc = index.full_stopper( GameTextGetTranslatedOrNot( info.spell_info.description ))
        info.tip_name = string.upper( info.tip_name )
        
        local parent_id = EntityGetParent( info.id )
        if( pen.vld( parent_id, true ) and pen.vld( xD.invs[ parent_id ])) then
            parent_id = pen.t.get( wip_item_list, parent_id, nil, nil, {})
            if( parent_id.is_wand ) then info.in_wand = parent_id.id end
        end

        return info
    end,

    -- on_tooltip = spell_cat.on_tooltip, --reloading tip
    on_slot = spell_cat.on_slot, --highlight valid mags to swap with on hover and drag
})

local gun_cat = pen.t.get( ITEM_CATS, "GUN40K", nil, nil, {})

table.insert( ITEM_CATS, 1, {
    id = "GUN40K_ENERGY",
    name = "Energy Weapon",
    is_wand = true, is_quickest = true,
    
    on_check = function( item_id ) return EntityHasTag( item_id, "gun40k_energy" ) end,
    on_data = gun_cat.on_data,
    on_processed_forced = gun_cat.on_processed_forced,

    on_tooltip = gun_cat.on_tooltip,
    on_inventory = gun_cat.on_inventory,
    on_slot = gun_cat.on_slot, -- in-slot heat and charge percentage indicators but no literal bullet counters except for the ones on-screen

    on_gui_world = gun_cat.on_gui_world,
    on_gui_pause = gun_cat.on_gui_pause,
    on_pickup = gun_cat.on_pickup,
})

table.insert( ITEM_CATS, 1, {
    id = "GUN40K_MELEE",
    name = "Melee Weapon",
    is_wand = true, is_quickest = true,
    
    on_check = function( item_id ) return EntityHasTag( item_id, "gun40k_melee" ) end,
    on_data = gun_cat.on_data,
    on_processed_forced = gun_cat.on_processed_forced,

    ctrl_script = function( info )
        --check button down
        --do bladeshot (default to simulated if no default hit profile varstorage is defined)
    end,

    on_tooltip = gun_cat.on_tooltip,
    on_inventory = gun_cat.on_inventory,
    on_slot = gun_cat.on_slot,

    on_gui_world = gun_cat.on_gui_world,
    on_gui_pause = gun_cat.on_gui_pause,
    on_pickup = gun_cat.on_pickup,
})