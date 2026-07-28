dofile( "data/scripts/lib/mod_settings.lua" )

local mod_id = "n40k"
mod_settings_version = 1
mod_settings = 
{
	{
		id = "THIS_CLSS",
		ui_name = "Selected Class",
		ui_description = "",
		hidden = true,
		value_default = 1,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "THIS_SECT",
		ui_name = "Selected Section",
		ui_description = "",
		hidden = true,
		value_default = 2,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "THIS_CHAR",
		ui_name = "Selected Character",
		ui_description = "",
		hidden = true,
		value_default = 1,
		scope = MOD_SETTING_SCOPE_RUNTIME,
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
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end