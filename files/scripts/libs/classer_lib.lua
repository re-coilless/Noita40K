dofile_once( "data/scripts/lib/utilities.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )

function picker( hooman, items )
	local x, y = EntityGetTransform( hooman )

	for i,path in ipairs( items ) do
		if( i > 4 ) then
			return
		end
	
		local item = EntityLoad( path, x, y )
		if( item ) then
			-- local item_comp = EntityGetFirstComponentIncludingDisabled( item, "ItemComponent" )
			-- ComponentSetValue2( item_comp, "has_been_picked_by_player", true )
			-- ComponentSetValueVector2( item_comp, "inventory_slot", i - 1, 0 )
			-- ComponentSetValue2( item_comp, "mFramePickedUp", 0 )
			-- ComponentSetValue2( item_comp, "next_frame_pickable", GameGetFrameNum())
			GamePickUpInventoryItem( hooman, item, false )
		else
			GamePrint( "Brother, I can't load ["..path.."]! Save us, God-Emperor..." )
		end
	end
end

function perker( hooman, organ, gene_seed, is_external )
	local perk_data = get_perk_with_actual_id( organ, is_external )
	local name = "PERK_PICKED_"..organ
	local name_persistent = string.lower( name )
	if( not( HasFlagPersistent( name_persistent ))) then
		GameAddFlagRun( "new_" .. name_persistent )
		AddFlagPersistent( name_persistent )
	end
	GameAddFlagRun( name )
	
	if( perk_data.game_effect ~= nil ) then
		ComponentSetValue2( GetGameEffectLoadTo( hooman, perk_data.game_effect, true ), "frames", -1 )
    end
    if( perk_data.func ~= nil ) then
		perk_data.func( nil, hooman, nil )
    end
	
	if( not( gene_seed )) then
		local ui = EntityCreateNew( "" )
		EntityAddComponent( ui, "UIIconComponent",
		{
			name = perk_data.ui_name,
			description = perk_data.ui_description,
			icon_sprite_file = perk_data.ui_icon
		})
		EntityAddChild( hooman, ui )
	end
end

function player_switcher( hooman, state )
	EntitySetComponentIsEnabled( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "InventoryGuiComponent" ), state )
	EntitySetComponentIsEnabled( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "Inventory2Component" ), state )
	EntitySetComponentIsEnabled( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" ), state )
end

function generic_stuff( hooman )
	--Player entity setup
	edit_component_with_tag_ultimate( hooman, "SpriteComponent", "player_amulet", function(comp,vars) 
		ComponentSetValue2( comp, "z_index", 0.599 )
		EntityRefreshSprite( hooman, comp )
	end)
	
	edit_component_with_tag_ultimate( hooman, "SpriteComponent", "player_hat2", function(comp,vars) 
		ComponentSetValue2( comp, "z_index", 0.599 )
		EntityRefreshSprite( hooman, comp )
	end)
	
	edit_component_ultimate( hooman, "CharacterPlatformingComponent", function(comp,vars) 
		ComponentSetValue2( comp, "accel_x", 0.3 )
		ComponentSetValue2( comp, "velocity_max_x", 70 )
	end)
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "head_offset",
		name = "head_offset",
		value_int = "0",
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "cooldown_taunt",
		name = "cooldown_taunt",
		value_int = "0",
	})
	
	EntityAddComponent( hooman, "AudioComponent", 
	{ 
		file = "mods/Noita40K/files/sfx/40K.bank",
		event_root = "taunts",
	})
	
	--GUIer
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "mm_is_open",
		name = "mm_is_open",
		value_bool = tostring( b2n( ModSettingGetNextValue( "Noita40K.UI_MODE" ) == 1 )),
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "mm_page_number",
		name = "mm_page_number",
		value_int = 2, --tostring( 2 + b2n( ModSettingGetNextValue( "Noita40K.UI_MODE" ) == 1 )),
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "qm_is_open",
		name = "qm_is_open",
		value_bool = "0",
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "qm_panel_state",
		name = "qm_panel_state",
		value_int = "0",
	})
	
	EntityAddComponent( hooman, "VariableStorageComponent", 
	{
		_tags = "cooldown_note",
		name = "cooldown_note",
		value_int = "300",
	})
	
	EntityAddTag( hooman, "mm_tutorial" )
	
	EntityAddComponent( hooman, "LuaComponent", 
	{ 
		_tags = "menu",
		script_source_file = "mods/Noita40K/files/scripts/player/main_controller.lua",
		execute_every_n_frame = "1",
		-- vm_type = "ONE_PER_COMPONENT_INSTANCE",
	})
	
	EntityAddComponent( hooman, "LuaComponent", 
	{ 
		script_source_file = "mods/Noita40K/files/scripts/player/perk_gui.lua",
		execute_every_n_frame = "1",
	})
	
	EntityAddComponent( hooman, "LuaComponent", 
	{ 
		script_source_file = "mods/Noita40K/files/scripts/fog_hole_offseter.lua",
		execute_every_n_frame = "1",
		remove_after_executed = "1",
	})
end

function magic_setuper( active_class, hooman, custom )
	local class = class_info[active_class[1]]
	local skin = class.skins[active_class[2]]
	
	--Perks
	local perk_table = class.default_perks
	if( skin ~= nil and skin.perks ~= nil ) then
		if( #skin.perks[2] > 0 ) then
			if( skin.perks[1] ) then
				perk_table = skin.perks[2]
			else
				for i,perk in ipairs( skin.perks[2] ) do
					table.insert( perk_table, perk )
				end
			end
		end
	end
	if( perk_table ~= nil ) then
		for i,perk in ipairs( perk_table ) do
			perker( hooman, perk[1], perk[2], perk[3] )
		end
	end
	
	--Loadout
	local loadout = class.default_guns
	if( custom ) then
		loadout = D_extractor( ModSettingGetNextValue( "Noita40K.CUSTOM_LOADOUT" ), true )
	elseif( skin ~= nil and skin.guns ~= nil ) then
		loadout = skin.guns
	end
	if( loadout ~= nil ) then
		local guns = {}
		for i,gun in ipairs( loadout ) do
			table.insert( guns, get_gun_with_id( gun ).path )
		end
		picker( hooman, guns )
	end
	
	--Items
	loadout = class.default_items
	if( skin ~= nil and skin.items ~= nil ) then
		loadout = skin.items
	end
	if( loadout ~= nil ) then
		local items = {}
		for i,item in ipairs( loadout ) do
			table.insert( items, get_gun_with_id( item ).path )
		end
		picker( hooman, items )
	end
	
	--Custom
	if( skin ~= nil and skin.custom_code ~= nil ) then
		skin.custom_code( hooman )
	end
end