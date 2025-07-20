dofile( "data/scripts/lib/mod_settings.lua" )

function mod_setting_custom_enum( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id( mod_id, setting ))
	local text = setting.ui_name .. ": " .. setting.values[ value ]
	
	local clicked,right_clicked = GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text )
	if clicked then
		value = value + 1
		if( value > #setting.values ) then
			value = 1
		end
		ModSettingSetNextValue( mod_setting_get_id( mod_id,setting ), value, false )
	end
	if right_clicked and setting.value_default then
		ModSettingSetNextValue( mod_setting_get_id( mod_id, setting ), setting.value_default, false )
	end
	
	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

-- function mod_setting_custom_class_enum( mod_id, gui, in_main_menu, im_id, setting )	
	-- dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
	-- dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )

	-- local value = ModSettingGetNextValue( mod_setting_get_id( mod_id, setting ))
	-- local value_old = value
	-- local text = setting.ui_name .. ": " .. string.gsub( class_info[ value ].class_name, "_", " " )
	
	-- local stats = DD_extractor( ModSettingGetNextValue( "Noita40K.CLASS_STATS" ))
	-- local clicked, r_clicked = GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text )
	-- if( clicked ) then
		-- value = value + 1
		-- while true do
			-- if( value > #class_info ) then
				-- value = 1
			-- end
			-- if( stats[value][1] == 1 ) then
				-- break
			-- end
			-- value = value + 1
		-- end
	-- end
	-- if( r_clicked ) then
		-- value = value - 1
		-- while true do
			-- if( value < 1 ) then
				-- value = #class_info
			-- end
			-- if( stats[value][1] == 1 ) then
				-- break
			-- end
			-- value = value - 1
		-- end
	-- end
	-- if( value_old ~= value ) then
		-- ModSettingSetNextValue( mod_setting_get_id( mod_id, setting ), value, false )
		-- ModSettingSetNextValue( "Noita40K.CURRENT_SKIN", class_info[value].default_skin, false )
	-- end
	
	-- mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
-- end

-- function mod_setting_custom_skin_enum( mod_id, gui, in_main_menu, im_id, setting )
	-- dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
	-- dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )

	-- local value = ModSettingGetNextValue( mod_setting_get_id( mod_id, setting ))
	-- local value_old = value
	-- local skin_list = class_info[ ModSettingGetNextValue( "Noita40K.CURRENT_CLASS" ) ].skins
	-- if( #skin_list < 1 ) then
		-- return
	-- end
	-- local text = setting.ui_name .. ": " .. string.gsub( skin_list[value].name, "_", " " )
	
	-- local clicked, r_clicked = GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text )
	-- if( clicked ) then
		-- value = value + 1
		-- while true do
			-- if( value > #skin_list ) then
				-- value = 1
			-- end
			-- if( skin_list[value].unlocked ) then
				-- break
			-- end
			-- value = value + 1
		-- end
	-- end
	-- if( r_clicked ) then
		-- value = value - 1
		-- while true do
			-- if( value < 1 ) then
				-- value = #skin_list
			-- end
			-- if( skin_list[value].unlocked ) then
				-- break
			-- end
			-- value = value - 1
		-- end
	-- end
	-- if( value_old ~= value ) then
		-- ModSettingSetNextValue( mod_setting_get_id( mod_id, setting ), value, false )
	-- end
	
	-- mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
-- end


-- function mod_setting_reseter( mod_id, gui, in_main_menu, im_id, setting )
	-- dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )
	-- dofile_once( "mods/Noita40K/files/scripts/libs/unlock_cases.lua" )
	
	-- local value = ModSettingGetNextValue( mod_setting_get_id( mod_id, setting ))
	-- local text = setting.ui_name .. " - " ..( value and "[ARMED] ([RMB] to continue | [LMB] to cancel)" or "[STANDING BY] ([LMB] to arm)" )
	
	-- local clicked, r_clicked = GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text )
	-- if( value ) then
		-- if( clicked ) then
			-- ModSettingSetNextValue( mod_setting_get_id( mod_id, setting ), false, false )
		-- elseif( r_clicked ) then
			-- ModSettingSetNextValue( mod_setting_get_id( mod_id, setting ), not value, false )
			-- ModSettingSetNextValue( "Noita40K.QUEST_INFO", "|", false )
			-- ModSettingSetNextValue( "Noita40K.NOTE_INFO", "|", false )
			
			-- if( #unlock_cases > 0 ) then
				-- for i,case in ipairs( unlock_cases ) do
					-- local func = case.reset
					-- if( func ~= nil ) then
						-- func()
					-- end
				-- end
			-- end
		-- end
	-- elseif( clicked ) then
		-- ModSettingSetNextValue( mod_setting_get_id( mod_id, setting ), not value, false )
	-- end
	
	-- mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
-- end

local mod_id = "Noita40K"
mod_settings_version = 3
mod_settings = 
{
	{
		id = "VERSION",
		ui_name = "Settings Version",
		ui_description = "This helps fixing compatibility issues.",
		hidden = true,
		value_default = 1,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	
	{
		id = "CLASS_STATS",
		ui_name = "Class Stats",
		ui_description = "General mod progression and some extra data.",
		hidden = true,
		value_default = "|:1:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:1:0:0:|",
		text_max_length = 100000,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	
	{
		id = "CUSTOM_LOADOUT",
		ui_name = "Custom Loadout",
		ui_description = "User defined loadout.",
		hidden = true,
		value_default = "|BOLT_CARBINE|CHAINSWORD|BOLTER|MELTACUTTER|",
		text_max_length = 100000,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	
	{
		id = "QUEST_INFO",
		ui_name = "Quest Info",
		ui_description = "IDs and info of the active quests.",
		hidden = true,
		value_default = "|",
		text_max_length = 100000,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	
	{
		id = "NOTE_INFO",
		ui_name = "Note Info",
		ui_description = "Notification queue.",
		hidden = true,
		value_default = "|",
		text_max_length = 100000,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	
	{
		id = "CURRENT_CLASS",
		ui_name = "Current Class",
		ui_description = "This class will be autoselected at the start of every new game.",
		hidden = true,
		value_default = 1,
		scope = MOD_SETTING_SCOPE_RUNTIME,
		-- ui_fn = mod_setting_custom_class_enum,
	},
	
	{
		id = "CURRENT_SKIN",
		ui_name = "Current Skin",
		ui_description = "This skin will be autoselected at the start of every new game.",
		hidden = true,
		value_default = 5,
		scope = MOD_SETTING_SCOPE_RUNTIME,
		-- ui_fn = mod_setting_custom_skin_enum,
	},

	{
		category_id = "SETTINGS",
		ui_name = "[SETTINGS]",
		ui_description = "Set up your own adventure.",
		foldable = true,
		_folded = true,
		settings = {
			{
				category_id = "GLOBAL_TWEAKS",
				ui_name = "Global Tweaks",
				ui_description = "Overall game behaviour.",
				settings = {
					{
						id = "ENABLE_CUSTOM_LOADOUT",
						ui_name = "Use Custom Loadout",
						ui_description = "Only those who tasted the glory shall be allowed.",
						value_default = false,
						scope = MOD_SETTING_SCOPE_NEW_GAME,
					},
					
					{
						id = "RELOAD_TAP_WAIT",
						ui_name = "Frames Between Double Tap",
						ui_description = "",
						value_default = 20,
						value_min = 1,
						value_max = 30,
						value_display_multiplier = 1,
						value_display_formatting = " $0 ",
						scope = MOD_SETTING_SCOPE_RUNTIME,
					},
					
					{
						id = "BEST_GAMEPLAY_EVER",
						ui_name = "#BESTGAMEPLAYEVER",
						ui_description = "Do it",
						value_default = false,
						scope = MOD_SETTING_SCOPE_NEW_GAME,
					},
				},
			},
			
			{
				category_id = "GUI",
				ui_name = "GUI Tweaks",
				ui_description = "Change the look of the game.",
				settings = {
					{
						id = "UI_MODE",
						ui_name = "UI Mode",
						ui_description = "",
						value_default = 1,
						values = { "Tutorial", "Normal", "Yeah, I know the stuff, ok?", },
						scope = MOD_SETTING_SCOPE_RUNTIME,
						ui_fn = mod_setting_custom_enum,
					},
					
					{
						id = "DISABLE_SHADERS",
						ui_name = "Disable Aggressive Shaders",
						ui_description = "",
						value_default = false,
						scope = MOD_SETTING_SCOPE_RUNTIME,
					},
					
					{
						id = "MAX_AMMO_SHOWN_FULL",
						ui_name = "Amount of Ammo to Show Unhidden",
						ui_description = "",
						value_default = 2,
						value_min = 1,
						value_max = 10,
						value_display_multiplier = 1,
						value_display_formatting = " $0x5 ",
						scope = MOD_SETTING_SCOPE_RUNTIME,
					},
					
					{
						id = "SHOW_PERKS",
						ui_name = "Show Special Perks",
						ui_description = "",
						value_default = true,
						scope = MOD_SETTING_SCOPE_RUNTIME,
					},
					
					{
						id = "DATABASED_NAMES",
						ui_name = "Pull Entity Names From Database",
						ui_description = "",
						value_default = false,
						scope = MOD_SETTING_SCOPE_RUNTIME,
					},
				},
			},
			
			{
				id = "DENDRITES_SOUND",
				ui_name = "Mechadendrites produce sound",
				ui_description = "",
				value_default = false,
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			
			{
				id = "REFRACTOR_VISUALS",
				ui_name = "Visualize refractor field",
				ui_description = "",
				value_default = false,
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			
			{
				id = "ARMOR_DEFLECTION_CHANCE",
				ui_name = "Emperor's Blessing Chance",
				ui_description = "",
				value_default = 6,
				value_min = 1,
				value_max = 20,
				value_display_multiplier = 1,
				value_display_formatting = " 1/$0 ",
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			
			-- {
				-- id = "RESETER",
				-- ui_name = "Exterminate All Progress",
				-- ui_description = "Reset all mod specific permanent progress.",
				-- value_default = false,
				-- scope = MOD_SETTING_SCOPE_RUNTIME,
				-- ui_fn = mod_setting_reseter,
			-- },
		},
	},
	
	{
		category_id = "GUIDE",
		ui_name = "[LEGACY CODEX]",
		ui_description = "Learn how to.",
		foldable = true,
		_folded = true,
		not_setting = true,
		settings = {
			{
				category_id = "INFO",
				ui_name = "BASIC INFO",
				ui_description = "",
				foldable = false,
				_folded = false,
				not_setting = true,
				settings = {
					{
						id = "C1",
						ui_name = "[Main Menu]\nOpen your inventory and seek for the button in top right corner.\nYou'll find actual Codex on the right page.",
						ui_description = "",
						not_setting = true,
					},
					
					{
						ui_fn = mod_setting_vertical_spacing,
						not_setting = true,
					},
					
					{
						id = "C2",
						ui_name = "[Reload]\nDouble tap [USE] to reload the gun in hand.",
						ui_description = "",
						not_setting = true,
					},
					
					{
						ui_fn = mod_setting_vertical_spacing,
						not_setting = true,
					},
				},
			},
		},
	},
}

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
	-- dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
	-- dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )
	
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
	
	-- compatibility_patch()
end