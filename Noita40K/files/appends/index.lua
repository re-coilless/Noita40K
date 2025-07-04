table.insert( GLOBAL_MUTATORS, function()
    dofile_once( "mods/Noita40K/files/_lib.lua" )

    local xD = index.D
    xD.can_tinker = true
	
	local initer = "N40K_READY_TO_PURGE"
	if( GameHasFlagRun( initer )) then return end
	GameAddFlagRun( initer )

	local active = n40.setup_character( xD.player_id )
end)

GUI_STRUCT.bars.hp = function( screen_w, screen_h, xys )
    local xD = index.D
    local data = xD.DamageModel
    local pic_x, pic_y = unpack( xys.hp or { 0, 0 })
    
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
        index.tipping( pic_x - 1, pic_y - 1, nil, { bar_data.length + 4, 8 }, tip, { pos = { pic_x - 1, pic_y + 10 }, is_left = true })
        pic_y = pic_y + 10
    end)
    GameSetPostFxParameter( "low_health_indicator_alpha_proper", xD.hp_flashing_intensity*pain_flash, 0, 0, 0 )

    return { pic_x, pic_y }
end
GUI_STRUCT.bars.air = function( screen_w, screen_h, xys ) return { unpack( xys.hp )} end
GUI_STRUCT.bars.flight = function( screen_w, screen_h, xys ) return { unpack( xys.air )} end --(indicate the charge level with sound)
GUI_STRUCT.bars.action.mana = function( screen_w, screen_h, xys ) return { unpack( xys.flight )} end
GUI_STRUCT.bars.action.reload = function( screen_w, screen_h, xys ) return { unpack( xys.mana )} end
GUI_STRUCT.bars.action.delay = function( screen_w, screen_h, xys ) return { unpack( xys.reload )} end
GUI_STRUCT.gold = function( screen_w, screen_h, xys ) return { unpack( xys.delay )} end
GUI_STRUCT.orbs = function( screen_w, screen_h, xys ) return { unpack( xys.gold )} end

GUI_STRUCT.icons.perks = function( screen_w, screen_h, xys ) return { unpack( xys.effects )} end
GUI_STRUCT.icons.ingestions = index.new_generic_ingestions
GUI_STRUCT.icons.stains = index.new_generic_stains
GUI_STRUCT.icons.effects = index.new_generic_effects

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

local wand_cat = pen.t.get( ITEM_CATS, "WAND", nil, nil, {})
local spell_cat = pen.t.get( ITEM_CATS, "SPELL", nil, nil, {})
local item_cat = pen.t.get( ITEM_CATS, "ITEM", nil, nil, {})

table.insert( ITEM_CATS, 1, {
    id = "GUN40K",
    name = "Gun",
    is_wand = true, is_quickest = true,
    
    on_check = function( item_id ) return EntityHasTag( item_id, "gun40k" ) end,
    on_data = wand_cat.on_data,
    on_processed_forced = wand_cat.on_processed_forced,

    on_tooltip = wand_cat.on_tooltip,
    on_inventory = function( info, pic_x, pic_y, state_tbl, slot_dims )
        -- ammo swap check
        -- reloading (add phantom slot, one per unique mag type, that does fake swap; discarded mag continues flying with gravity past the slot it wanted to swap with)
        -- first mag slots, then attachment slots (every attachment slot schematically points to the part of the gun it will occupy; allow overriding on-hover slot numbers with custom text)

        local xD = index.D
        if( not( xD.is_opened )) then return end
        if( not( state_tbl.is_quick )) then return end
        if( not( xD.gmod.allow_wand_editing )) then return end
        pic_x, pic_y = unpack( pen.vld( xD.xys.wands ) and xD.xys.wands or xD.xys.full_inv )
        w, h = xD.wand_func( pic_x - 3*pen.b2n( state_tbl.in_hand ), pic_y + 2, info, state_tbl.in_hand )
        xD.xys.wands = { pic_x, pic_y + h }
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
    on_data = spell_cat.on_data,
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
    -- jumppack should apply rotation to character on acceleraion

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

    on_check = function( item_id ) return EntityHasTag( item_id, "attachment40k" ) end,
    on_data = spell_cat.on_data,
    on_processed = spell_cat.on_processed,

    on_tooltip = spell_cat.on_tooltip,
    on_slot_check = spell_cat.on_slot_check,
    on_swap = spell_cat.on_swap,
    on_slot = spell_cat.on_slot,

    on_gui_world = spell_cat.on_gui_world,
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
    on_slot = gun_cat.on_slot, -- in-slot color-based mag percentage indicators but no literal bullet counters except for the ones on-screen

    on_gui_world = gun_cat.on_gui_world,
    on_gui_pause = gun_cat.on_gui_pause,
    on_pickup = gun_cat.on_pickup,
})