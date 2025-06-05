dofile_once( "mods/Noita40K/files/_lib.lua" )

table.insert( actions,
{
	id = "BOLT_998_HE_M",
	name = "Bolt .998 HE (Medium Mag)",
	description = "Standard bolter magazine of 20-rounds.",
	sprite = "mods/Noita40K/files/items/mags/bolt_998_he_M.png",
	
	type = ACTION_TYPE_PROJECTILE,
	price = 250, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	shells = { "mods/Noita40K/files/items/rounds/bolt_998c.xml" },
	projectiles = {{ p = "mods/Noita40K/files/items/rounds/bolt_998_he.xml", r = 3, h = 1 }},
	custom_xml_file = "mods/Noita40K/files/items/mags/bolt_998_he_M.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "projectiles/bolt_998" },
	
	action = function()
		pen.gunshot()
		-- shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10
		c.spread_degrees = c.spread_degrees + 10.0
	end,
})

--[[
table.insert( actions,
{
	id          = "75_BOLT_HEI_MAG",
	name 		= ".75 Bolt Mag HEI",
	description = "20-round standard bolter magazine packed with Inferno Rounds.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/75_bolt_hei_mag.png",
	sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_trigger_unidentified.png",
	related_projectiles	= { "mods/Noita40K/files/entities/projectiles/bolt_75_HEI.xml" },
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 350,
	mana              = 30,
	max_uses          = -1,
	custom_xml_file = "mods/Noita40K/files/entities/cards/75_bolt_hei_mag.xml",
	action = function()
		add_projectile( "mods/Noita40K/files/entities/projectiles/bolt_75_HEI.xml" )
		c.spread_degrees = c.spread_degrees + 10.0
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
	end,
})

table.insert( actions,
{
	id          = "75_BOLT_STASIS_MAG",
	name 		= ".75 Bolt Mag Stasis",
	description = "20-round standard bolter magazine packed with Stasis Rounds.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/75_bolt_stasis_mag.png",
	sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_trigger_unidentified.png",
	related_projectiles	= { "mods/Noita40K/files/entities/projectiles/bolt_75_stasis.xml" },
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 400,
	mana              = 30,
	max_uses          = -1,
	custom_xml_file = "mods/Noita40K/files/entities/cards/75_bolt_stasis_mag.xml",
	action = function()
		add_projectile( "mods/Noita40K/files/entities/projectiles/bolt_75_stasis.xml" )
		c.spread_degrees = c.spread_degrees + 10.0
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
	end,
})

table.insert( actions,
{
	id          = "75_BOLT_VP_MAG",
	name 		= ".75 Bolt Mag Velho",
	description = "A curiously modified 15-round bolter magazine. It's surrounded by so familiar yet so alien purple aura.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/75_bolt_vp_mag.png",
	sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_trigger_unidentified.png",
	related_projectiles	= { "mods/Noita40K/files/entities/projectiles/bolt_75_VP.xml" },
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 500,
	mana              = 50,
	max_uses          = -1,
	custom_xml_file = "mods/Noita40K/files/entities/cards/75_bolt_vp_mag.xml",
	action = function()
		c.spread_degrees = c.spread_degrees + 10.0
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
		add_projectile_trigger_hit_world( "mods/Noita40K/files/entities/projectiles/bolt_75_VP.xml", 1 )
	end,
})

table.insert( actions,
{
	id          = "998_BOLT_AP_S_MAG",
	name 		= ".998 Bolt Mag AP Suppressed",
	description = "10-round standard high-caliber bolter magazine containing cartridges with silenced jet nozzle.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/998_bolt_ap_s_mag.png",
	sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_trigger_unidentified.png",
	related_projectiles	= { "mods/Noita40K/files/entities/projectiles/bolt_998_AP_S.xml" },
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 300,
	mana              = 30,
	max_uses          = -1,
	custom_xml_file = "mods/Noita40K/files/entities/cards/998_bolt_ap_s_mag.xml",
	action = function()
		add_projectile( "mods/Noita40K/files/entities/projectiles/bolt_998_AP_S.xml" )
		c.spread_degrees = c.spread_degrees + 15.0
		c.damage_critical_chance = c.damage_critical_chance + 10
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 25.0
	end,
})

table.insert( actions,
{
	id          = "50MM_BOLT_AP_HE_MAG_SMALL",
	name 		= "Small 50mm Bolt Mag AP HE",
	description = "3-round standard bolt carbine magazine.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/50mm_bolt_ap_he_mag_small.png",
	related_projectiles	= { "mods/Noita40K/files/entities/projectiles/bolt_50mm_AP_HE.xml" },
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 400,
	mana              = 200,
	max_uses          = -1,
	custom_xml_file = "mods/Noita40K/files/entities/cards/50mm_bolt_ap_he_mag_small.xml",
	action = function()
		add_projectile( "mods/Noita40K/files/entities/projectiles/bolt_50mm_AP_HE.xml" )
		c.fire_rate_wait = c.fire_rate_wait + 10
		c.reload_time = c.reload_time + 60
		c.spread_degrees = c.spread_degrees + 30.0
		c.damage_critical_chance = c.damage_critical_chance + 20
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 100.0
	end,
})

table.insert( actions,
{
	id          = "ADAMANTIUM_CARBON_TEETH",
	name 		= "Adamantium-Carbon Alloy Teeth",
	description = "Razor-sharp chainedge made of adamantium-carbon alloy.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/adamantium_carbon_teeth.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 10,
	mana              = 0,
	max_uses          = -1,
	
	action = function()
		beam_controller( GetUpdatedEntityID(), "chainedge_state" )
	end,
})

table.insert( actions,
{
	id          = "PYRUM_PETROL_CANISTER_SMALL",
	name 		= "Small Pyrum-Petrol Fuel Canister",
	description = "Small fuel tank designed for low-power melta-based tools.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/pyrum_petrol_canister_small.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 200,
	mana              = 5,
	max_uses          = -1,
	custom_xml_file = "mods/Noita40K/files/entities/cards/pyrum_petrol_canister_small.xml",
	action = function()
		beam_controller( GetUpdatedEntityID(), "melta_state" )
	end,
})

table.insert( actions,
{
	id          = "HD_POWER_PACK",
	name 		= "High-Dencity Power Pack",
	description = "Extremely advanced energy storage capable of outputting TW of raw power. Though, it tends to overheat almost instantly.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/hd_power_pack.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 250,
	mana              = 10,
	max_uses          = -1,
	custom_xml_file = "mods/Noita40K/files/entities/cards/hd_power_pack.xml",
	action = function()
		beam_controller( GetUpdatedEntityID(), "volkite_state" )
	end,
})

table.insert( actions,
{
	id          = "WARPBORN_PHOTON_PACK",
	name 		= "Warpborn Photon Pack",
	description = "Unbelievably sophisticated storage container filled with roaring backness.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/warpborn_photon_pack.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 600,
	mana              = 1000,
	max_uses          = -1,
	custom_xml_file = "mods/Noita40K/files/entities/cards/warpborn_photon_pack.xml",
	action = function()
		beam_controller( GetUpdatedEntityID(), "darkfire_state" )
	end,
})

table.insert( actions,
{
	id          = "SOLLEX_FOCUSING_CRYSTAL",
	name 		= "Sollex Focusing Crystal",
	description = "An artificial crystal from the Dark Age. It shimmers with aenigmatic power.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/sollex_focusing_crystal.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 10,
	mana              = 0,
	max_uses          = -1,
	
	action = function()
	end,
})

table.insert( actions,
{
	id          = "MT_LASBAT",
	name 		= "Multi-Threaded Las-Battery",
	description = "A bundle of high-powered las-batteries conjoined into a single unit by an unknown tech-zealot.",
	sprite 		= "mods/Noita40K/files/pics/cards_gfx/mt_lasbat.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 300,
	mana              = 4,
	max_uses          = -1,
	custom_xml_file = "mods/Noita40K/files/entities/cards/mt_lasbat.xml",
	action = function()
		beam_controller( GetUpdatedEntityID(), "las_state" )
	end,
})
]]