dofile_once( "mods/Noita40K/files/_lib.lua" )

n40.MFLASH = {
	["bolt_998"] = function( muzzle_x, muzzle_y, r, s_x, s_y, gun_id, card_id, action )
		local v_x, v_y = pen.get_speed( EntityGetRootEntity( gun_id ))
		pen.magic_particles( muzzle_x, muzzle_y, r, {
			delay = 2, fading = 6, lifetime = 4,
			additive = true, emissive = true, count = { 2, 3 },
			
			alpha = 0.9, color = { 230, 88, 0 },
			alpha_end = 0.1, color_end = { 59, 42, 32 },
			
			global_velocity = { v_x/2, v_y/2 },
			velocity = { 140, 0 }, slowdown = { -20, 0, 1 },
		})
		pen.magic_particles( muzzle_x, muzzle_y, r, {
			fading = 5, lifetime = 2,
			additive = true, emissive = true, count = { 2, 3 },

			alpha = 0.9, color = { 230, 88, 0 },
			alpha_end = 0.2, color_end = { 59, 42, 32 },

			global_velocity = { v_x/2, v_y/2 },
			scale = { 0.7, 0.5 }, v_range = { 0, -75, 0, 75 },
		})
	end,

	["bolt_50mm"] = function( muzzle_x, muzzle_y, r, s_x, s_y, gun_id, card_id, action )
		local v_x, v_y = pen.get_speed( EntityGetRootEntity( gun_id ))
		pen.magic_particles( muzzle_x, muzzle_y, r, {
			fading = 7, lifetime = 4,
			additive = true, emissive = true, count = { 5, 7 },

			alpha = 0.9, color = { 230, 88, 0 },
			alpha_end = 0.2, color_end = { 59, 42, 32 },

			scale = { 0.7, 0.7 }, p_range = { -0.5, -1.5, 0.5, 1.5 },
			global_velocity = { v_x/2, v_y/2 }, v_range = { 100, -20, 150, 20 },
		})
	end,
}

table.insert( actions,
{
	id = "BOLT_998_HE_M",
	name = "Bolt .998 HE (Medium Mag)",
	description = "Standard bolter magazine of 20-rounds.",
	sprite = "mods/Noita40K/files/items/mags/bolt_998_he_M.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_PROJECTILE,
	price = 250, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	shells = { "mods/Noita40K/files/items/rounds/bolt_998c.xml" },
	projectiles = {{ p = "mods/Noita40K/files/items/rounds/bolt_998_he.xml", r = 3, h = 1 }},
	custom_xml_file = "mods/Noita40K/files/items/mags/bolt_998_he_M.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/guns/bolt_998" },
	
	action = function()
		pen.gunshot( n40.MFLASH.bolt_998 )
		c.spread_degrees = c.spread_degrees + 10.0
	end,
})

table.insert( actions,
{
	id = "BOLT_50MM_AP_HE_S",
	name = "Bolt 50mm APHE (Small Mag)",
	description = "Standard bolt carbine magazine of 3-rounds.",
	sprite = "mods/Noita40K/files/items/mags/bolt_50mm_aphe_S.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_PROJECTILE,
	price = 400, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	shells = { "mods/Noita40K/files/items/rounds/bolt_50mmc.xml" },
	projectiles = {{ p = "mods/Noita40K/files/items/rounds/bolt_50mm_aphe.xml", r = 12, h = 50 }},
	custom_xml_file = "mods/Noita40K/files/items/mags/bolt_50mm_aphe_S.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/guns/bolt_50mm" },
	
	action = function()
		pen.gunshot( n40.MFLASH.bolt_50mm )
		c.spread_degrees = c.spread_degrees + 30.0
		c.damage_critical_chance = c.damage_critical_chance + 20
	end,
})

table.insert( actions,
{
	id = "CANISTER_S_PYRUM",
	name = "Small Fuel Canister of Pyrum-Petrol",
	description = "Small fuel tank designed for low-powered melta tools.",
	sprite = "mods/Noita40K/files/items/mags/canister_S_pyrum.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_OTHER,
	price = 200, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	projectiles = {{ r = 0.5, h = 7 }},
	--pyrum decreases length and increases damage; changes color to be more yellow
	beam = { dmg = 0.6, dmg_type = "DAMAGE_MATERIAL", dmg_msg = "melta", dmg_effect = "NORMAL",
		point_action = function( data, point_x, point_y, k, is_final )
			if( k%5 ~= 0 and not( is_final )) then return end
			pen.c.beam_eff_ids = pen.c.beam_eff_ids or {}
			local effect = "mods/Noita40K/files/items/rounds/effect_pyrum_small.xml"
			pen.life_support( pen.c.beam_eff_ids, data.gun..k, effect, point_x, point_y )
		end,
	},
	custom_xml_file = "mods/Noita40K/files/items/mags/canister_S_pyrum.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/beams/pyrum", true },

	action = function() pen.gunshot() end,
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