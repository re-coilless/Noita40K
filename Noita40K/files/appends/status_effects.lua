--stains
table.insert( status_effects, 
{
	id = "LIFE_EATER",
	protects_from_fire = false,
	is_harmful = true,

	ui_name = "$n40_EFFECT_life_eater", ui_description = "$n40_EFFECT_life_eater_",
	ui_icon = "mods/Noita40K/files/effects/status/life_eater.png",

	effect_entity = "mods/Noita40K/files/effects/status/life_eater.xml",
})
table.insert( status_effects, 
{
	id = "RUPTORINFERNO",
	remove_cells_that_cause_when_activated = true,
	protects_from_fire = true,
	is_harmful = false,

	ui_name = "$n40_EFFECT_ruptorinferno", ui_description = "$n40_EFFECT_ruptorinferno_",
	ui_icon = "mods/Noita40K/files/effects/status/ruptorinferno.png",

	effect_entity = "mods/Noita40K/files/effects/status/ruptorinferno.xml",
})
table.insert( status_effects, 
{
	id = "BIOINFERNO",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40_EFFECT_bioinferno", ui_description = "$n40_EFFECT_bioinferno_",
	ui_icon = "mods/Noita40K/files/effects/status/bioinferno.png",

	effect_entity = "mods/Noita40K/files/effects/status/bioinferno.xml",
})
table.insert( status_effects, 
{
	id = "PROMETHIUM_FIRE",
	protects_from_fire = false,
	is_harmful = true,

	ui_name = "$n40_EFFECT_promethium_fire", ui_description = "$n40_EFFECT_promethium_fire_",
	ui_icon = "mods/Noita40K/files/effects/status/promethium_fire.png",

	effect_entity = "mods/Noita40K/files/effects/status/promethium_fire.xml",
})
table.insert( status_effects, 
{
	id = "IONIZING_SUBLIMATION",
	protects_from_fire = false,
	is_harmful = true,

	ui_name = "$n40_EFFECT_ionizing_sublimation", ui_description = "$n40_EFFECT_ionizing_sublimation_",
	ui_icon = "mods/Noita40K/files/effects/status/ionizing_sublimation.png",

	effect_entity = "mods/Noita40K/files/effects/status/ionizing_sublimation.xml",
})

--[[

--generic effects
table.insert( status_effects, 
{
	id = "WARPFIRE",
	ui_name = "Warpfire",
	ui_description = "Arm yourselves, fools, the enemy are within us!",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_warpfire.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_warpfire.xml",
	is_harmful = true,
})

table.insert( status_effects, 
{
	id = "FANCY_BURNING",
	ui_name = "Thermal Deflagration",
	ui_description = "You are being seared by a horrifying heat.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_fancy_burning.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_fancy_burning.xml",
	is_harmful = true,
})

table.insert( status_effects, 
{
	id = "PSYTRIP",
	ui_name = "Psytrip",
	ui_description = "A moment of laxity spawns a lifetime of heresy.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_psytrip.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_psytrip.xml",
	is_harmful = false,
})

table.insert( status_effects, 
{
	id = "SENSORY_OVERLOAD",
	ui_name = "Sensory Overload",
	ui_description = "Your senses are overloaded with excessive stimulus.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_sensory_overload.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_sensory_overload.xml",
	is_harmful = false,
})

table.insert( status_effects, 
{
	id = "STASIS_STUN",
	ui_name = "Stasis Stun",
	ui_description = "Your consciousness is fractured.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_stasis_stun.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_stasis_stun.xml",
	is_harmful = false,
})

table.insert( status_effects, 
{
	id = "STASIS_COMA",
	ui_name = "Stasis Coma",
	ui_description = "H-hard...to...think...",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_stasis_coma.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_stasis_coma.xml",
	is_harmful = false,
})

table.insert( status_effects, 
{
	id = "SYSTEM_OVERLOAD",
	ui_name = "System Overload",
	ui_description = "Your augmentations are oversaturated with exessive power.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_system_overload.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_system_overload.xml",
	is_harmful = false,
})

--special effects
table.insert( status_effects, 
{
	id = "UNTAMED",
	ui_name = "Untamed",
	ui_description = "The Great Wolf has been unleashed.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_untamed.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_untamed.xml",
	is_harmful = false,
})

table.insert( status_effects, 
{
	id = "MOMENT_UNRESTRAINED",
	ui_name = "Moment Unrestrained",
	ui_description = "Allconsuming ferocity overwhelms your body. They shall fear.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_moment_unrestrained.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_moment_unrestrained.xml",
	is_harmful = false,
})

table.insert( status_effects, 
{
	id = "BLACK_RAGE",
	ui_name = "Black Rage",
	ui_description = "For the Emperor and Sanguinius! Death! DEATH!",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_black_rage.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_black_rage.xml",
	is_harmful = false,
})

table.insert( status_effects, 
{
	id = "UNMOVABLE_FORTITUDE",
	ui_name = "Unmovable Fortitude",
	ui_description = "There is only the Emperor, and he is our Shield and Protector.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_unmovable_fortitude.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_unmovable_fortitude.xml",
	is_harmful = false,
})

]]