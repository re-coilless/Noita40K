-- move hud to the left
-- inventory is fully invisible when closed (show a weapon+item wheel at the pointer, force 20 fps when holding down weapon select button)

GUI_STRUCT.bars.air = nil
GUI_STRUCT.bars.flight = nil --(indicate the charge level with sound)
GUI_STRUCT.icons.perks = nil

local wand_cat = pen.t.get( ITEM_CATS, "WAND", nil, nil, {})
local spell_cat = pen.t.get( ITEM_CATS, "SPELL", nil, nil, {})
local item_cat = pen.t.get( ITEM_CATS, "ITEM", nil, nil, {})

table.insert( ITEM_CATS, 1, {
    id = "GUN40K",
    name = "Gun",
    is_wand = true, is_quickest = true,
    
    on_check = function( item_id ) return EntityHasTag( item_id, "gun40k" ) end,
    on_info_name = wand_cat.on_info_name,
    on_data = wand_cat.on_data,
    on_processed_forced = wand_cat.on_processed_forced,

    on_tooltip = wand_cat.on_tooltip,
    on_inventory = wand_cat.on_inventory,
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
    on_slot = spell_cat.on_slot,

    on_gui_world = spell_cat.on_gui_world,
})

--equipment cat
-- equipment slots are components of the full inv, dedicate a full row and assign some big y value