--stains
table.insert( status_effects, 
{
	id = "LIFE_EATER_INFECTION",
	ui_name = "Life-Eater Virus",
	ui_description = "There's no escape.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_life_eater.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_life_eater_infection.xml",
	is_harmful = true,
})

table.insert( status_effects, 
{
	id = "RUPTORINFERNO",
	ui_name = "Ruptor Inferno",
	ui_description = "You are being maintained.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_ruptorinferno.png",
	protects_from_fire = true,
	remove_cells_that_cause_when_activated = true,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_ruptorinferno.xml",
	is_harmful = false,
})

table.insert( status_effects, 
{
	id = "BIOINFERNO",
	ui_name = "Bio Inferno",
	ui_description = "Something's inside you. And it's burning.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_bioinferno.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_bioinferno.xml",
	is_harmful = false,
})

table.insert( status_effects, 
{
	id = "PROMETHIUM_FIRE",
	ui_name = "Promethium Fire",
	ui_description = "You are soaked in burning promethium.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_promethium_fire.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_promethium_fire.xml",
	is_harmful = true,
})

table.insert( status_effects, 
{
	id = "IONIZING_SUBLIMATION",
	ui_name = "Ionizing Sublimation",
	ui_description = "You are being evaporated.",
	ui_icon = "mods/Noita40K/files/pics/gui_gfx/icons/status_effects/icon_ionizing_sublimation.png",
	protects_from_fire = false,
	effect_entity = "mods/Noita40K/files/entities/status_effects/effect_ionizing_sublimation.xml",
	is_harmful = true,
})

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