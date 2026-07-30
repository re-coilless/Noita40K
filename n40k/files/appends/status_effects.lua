--stains
table.insert( status_effects, 
{
	id = "PROMETHIUM_FIRE",
	protects_from_fire = false,
	is_harmful = true,

	ui_name = "$n40k_EFFECT_promethium_fire", ui_description = "$n40k_EFFECT_promethium_fire_",
	ui_icon = "mods/n40k/files/effects/status/promethium_fire.png",

	effect_entity = "mods/n40k/files/effects/status/promethium_fire.xml",
})
table.insert( status_effects, 
{
	id = "IONIZING_SUBLIMATION",
	protects_from_fire = false,
	is_harmful = true,

	ui_name = "$n40k_EFFECT_ionizing_sublimation", ui_description = "$n40k_EFFECT_ionizing_sublimation_",
	ui_icon = "mods/n40k/files/effects/status/ionizing_sublimation.png",

	effect_entity = "mods/n40k/files/effects/status/ionizing_sublimation.xml",
})
table.insert( status_effects, 
{
	id = "LIFE_EATER",
	protects_from_fire = false,
	is_harmful = true,

	ui_name = "$n40k_EFFECT_life_eater", ui_description = "$n40k_EFFECT_life_eater_",
	ui_icon = "mods/n40k/files/effects/status/life_eater.png",

	effect_entity = "mods/n40k/files/effects/status/life_eater.xml",
})
table.insert( status_effects, 
{
	id = "RUPTORINFERNO",
	remove_cells_that_cause_when_activated = true,
	protects_from_fire = true,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_ruptorinferno", ui_description = "$n40k_EFFECT_ruptorinferno_",
	ui_icon = "mods/n40k/files/effects/status/ruptorinferno.png",

	effect_entity = "mods/n40k/files/effects/status/ruptorinferno.xml",
})
table.insert( status_effects, 
{
	id = "BIOINFERNO",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_bioinferno", ui_description = "$n40k_EFFECT_bioinferno_",
	ui_icon = "mods/n40k/files/effects/status/bioinferno.png",

	effect_entity = "mods/n40k/files/effects/status/bioinferno.xml",
})

--generic
table.insert( status_effects, 
{
	id = "DEFLAGRATION",
	protects_from_fire = false,
	is_harmful = true,

	ui_name = "$n40k_EFFECT_deflagration", ui_description = "$n40k_EFFECT_deflagration_",
	ui_icon = "mods/n40k/files/effects/status/deflagration.png",

	effect_entity = "mods/n40k/files/effects/status/deflagration.xml",
})
table.insert( status_effects, 
{
	id = "SENSORY_OVERLOAD",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_sensory_overload", ui_description = "$n40k_EFFECT_sensory_overload_",
	ui_icon = "mods/n40k/files/effects/status/sensory_overload.png",

	effect_entity = "mods/n40k/files/effects/status/sensory_overload.xml",
})
table.insert( status_effects, 
{
	id = "SYSTEM_OVERLOAD",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_system_overload", ui_description = "$n40k_EFFECT_system_overload_",
	ui_icon = "mods/n40k/files/effects/status/system_overload.png",

	effect_entity = "mods/n40k/files/effects/status/system_overload.xml",
})
table.insert( status_effects, 
{
	id = "TEMPORAL_MISALIGNMENT",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_temporal_misalignment", ui_description = "$n40k_EFFECT_temporal_misalignment_",
	ui_icon = "mods/n40k/files/effects/status/temporal_misalignment.png",

	effect_entity = "mods/n40k/files/effects/status/temporal_misalignment.xml",
})
table.insert( status_effects, 
{
	id = "STASIS_COMA",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_stasis_coma", ui_description = "$n40k_EFFECT_stasis_coma_",
	ui_icon = "mods/n40k/files/effects/status/stasis_coma.png",

	effect_entity = "mods/n40k/files/effects/status/stasis_coma.xml",
})
table.insert( status_effects, 
{
	id = "PSYTRIP",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_psytrip", ui_description = "$n40k_EFFECT_psytrip_",
	ui_icon = "mods/n40k/files/effects/status/psytrip.png",

	effect_entity = "mods/n40k/files/effects/status/psytrip.xml",
})
table.insert( status_effects, 
{
	id = "WARPFIRE",
	protects_from_fire = false,
	is_harmful = true,

	ui_name = "$n40k_EFFECT_warpfire", ui_description = "$n40k_EFFECT_warpfire_",
	ui_icon = "mods/n40k/files/effects/status/warpfire.png",

	effect_entity = "mods/n40k/files/effects/status/warpfire.xml",
})

--special
table.insert( status_effects, 
{
	id = "IMMOVABLE_FORTITUDE",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_immovable_fortitude", ui_description = "$n40k_EFFECT_immovable_fortitude_",
	ui_icon = "mods/n40k/files/effects/status/immovable_fortitude.png",

	effect_entity = "mods/n40k/files/effects/status/immovable_fortitude.xml",
})
table.insert( status_effects, 
{
	id = "UNTAMED",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_untamed", ui_description = "$n40k_EFFECT_untamed_",
	ui_icon = "mods/n40k/files/effects/status/untamed.png",

	effect_entity = "mods/n40k/files/effects/status/untamed.xml",
})
table.insert( status_effects, 
{
	id = "UNRESTRAINED",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_unrestrained", ui_description = "$n40k_EFFECT_unrestrained_",
	ui_icon = "mods/n40k/files/effects/status/unrestrained.png",

	effect_entity = "mods/n40k/files/effects/status/unrestrained.xml",
})
table.insert( status_effects, 
{
	id = "BLACK_RAGE",
	protects_from_fire = false,
	is_harmful = false,

	ui_name = "$n40k_EFFECT_black_rage", ui_description = "$n40k_EFFECT_black_rage_",
	ui_icon = "mods/n40k/files/effects/status/black_rage.png",

	effect_entity = "mods/n40k/files/effects/status/black_rage.xml",
})