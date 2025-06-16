n40 = n40 or {}

n40.GUNS = --obtain stats and such dynamically from xml parsing, write names/descs to guns from here
{
	-- SLOT 1 (good all-arounder)
	BOLTER_GENERIC = {
		name = "$n40_GUN_bolter_generic", desc = "$n40_GUN_bolter_generic_",
		path = "mods/Noita40K/files/items/weapons/bolter.xml",
		-- func = nil,
	},
	BOLTER_COMBIMELTA = {
		name = "$n40_GUN_bolter_combimelta", desc = "$n40_GUN_bolter_combimelta_",
		path = "mods/Noita40K/files/items/weapons/bolter_betrayers_bane.xml",
	},
	BOLTER_INCENDIARY = {
		name = "$n40_GUN_bolter_incendiary", desc = "$n40_GUN_bolter_incendiary_",
		path = "mods/Noita40K/files/items/weapons/bolter_drakes_roar.xml",
	},
	BOLTER_RAPID = {
		name = "$n40_GUN_bolter_rapid", desc = "$n40_GUN_bolter_rapid_",
		path = "mods/Noita40K/files/items/weapons/bolter_octavios_burden.xml",
	},
	BOLTER_ARCHEO = {
		name = "$n40_GUN_bolter_archeo", desc = "$n40_GUN_bolter_archeo_",
		path = "mods/Noita40K/files/items/weapons/bolter_ravenwing.xml",
	},
	BOLTER_STALKER = {
		name = "$n40_GUN_bolter_stalker", desc = "$n40_GUN_bolter_stalker_",
		path = "mods/Noita40K/files/items/weapons/bolter_stalker.xml",
	},
	VOLKITE_PISTOL = {
		name = "$n40_GUN_volkite_pistol", desc = "$n40_GUN_volkite_pistol_",
		path = "mods/Noita40K/files/items/weapons/volkite_pistol.xml",
	},

	-- SLOT 2 (niche and skill-based)
	BOLTER_RIFLE = {
		name = "$n40_GUN_bolter_rifle", desc = "$n40_GUN_bolter_rifle_",
		path = "mods/Noita40K/files/items/weapons/bolter_rifle.xml",
	},
	DARKFIRE_RIFLE = {
		name = "$n40_GUN_darkfire_rifle", desc = "$n40_GUN_darkfire_rifle_",
		path = "mods/Noita40K/files/items/weapons/darkfire_rifle.xml",
	},

	-- SLOT 3 (melee)
	SWORD_CHAIN = {
		name = "$n40_GUN_sword_chain", desc = "$n40_GUN_sword_chain_",
		path = "mods/Noita40K/files/items/weapons/sword_chain.xml",
	},
	SWORD_SOLLEX = {
		name = "$n40_GUN_sword_sollex", desc = "$n40_GUN_sword_sollex_",
		path = "mods/Noita40K/files/items/weapons/sword_sollex.xml",
	},

	-- SLOT 4 (utility)
	MELTA_CUTTER = {
		name = "$n40_GUN_melta_cutter", desc = "$n40_GUN_melta_cutter_",
		path = "mods/Noita40K/files/items/weapons/melta_cutter.xml",
	},
	LASGUN_MITRA = {
		name = "$n40_GUN_lasgun_mitra", desc = "$n40_GUN_lasgun_mitra_",
		path = "mods/Noita40K/files/items/weapons/lasgun_mitra.xml",
	},
}

n40.ITEMS = {
	-- throwables
	GRENADE_HE = {
		name = "$n40_ITEM_grenade_he", desc = "$n40_ITEM_grenade_he_",
		path = "",
	},
	GRENADE_HEI = {
		name = "$n40_ITEM_grenade_hei", desc = "$n40_ITEM_grenade_hei_",
		path = "",
	},
	GRENADE_FLASHBANG = {
		name = "$n40_ITEM_grenade_flashbang", desc = "$n40_ITEM_grenade_flashbang_",
		path = "",
	},
	GRENADE_ARC = {
		name = "$n40_ITEM_grenade_arc", desc = "$n40_ITEM_grenade_arc_",
		path = "",
	},
	GRENADE_RUPTOR = {
		name = "$n40_ITEM_grenade_ruptor", desc = "$n40_ITEM_grenade_ruptor_",
		path = "",
	},

	-- misc
	KEG = {
		name = "$n40_ITEM_keg", desc = "$n40_ITEM_keg_",
		path = "",
	},
}

n40.EQUIPMENT = {
	-- defensive
	SHIELD_S = {
		name = "$n40_EQUIPMENT_shield_s", desc = "$n40_EQUIPMENT_shield_s_",
		path = "",
	},
	REFRACTOR_FIELD = {
		name = "$n40_EQUIPMENT_refractor", desc = "$n40_EQUIPMENT_refractor_",
		path = "",
	},

	-- mobility
	JUMPPACK = {
		name = "$n40_EQUIPMENT_jumppack", desc = "$n40_EQUIPMENT_jumppack_",
		path = "",
	},
	JUMPPACK_UPGRADE = {
		name = "$n40_EQUIPMENT_jumppack_upgrade", desc = "$n40_EQUIPMENT_jumppack_upgrade_",
		path = "",
	},

	-- utility
	SERVOSKULL = {
		name = "$n40_EQUIPMENT_servoskull", desc = "$n40_EQUIPMENT_servoskull_",
		path = "",
	},
	OSCULANT_DEVICE = {
		name = "$n40_EQUIPMENT_osculant_device", desc = "$n40_EQUIPMENT_osculant_device_",
		path = "",
	},
}

n40.PERKS = {
	-- skins
	MKVII_ULTRAMARINE = {
		name = "$n40_PERK_armor_mk7_ultramarine", desc = "$n40_PERK_armor_mk7_ultramarine_",
		-- vector_ctrl = "",
		func = function( hooman, data, char_name )
			char_name = char_name or "1_ultramarine"
			ComponentSetValue2( data.pic_char, "image_file",
				"mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/"..char_name.."/player.xml" )
			ComponentSetValue2( data.dmg_comp, "ragdoll_filenames_file",
				"mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/"..char_name.."/ragdoll/filenames.txt" )
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( data.arm_id, "HotspotComponent" ), "offset", -0.5, 0 )
			
			ComponentSetValue2( data.sfx_comp, "file", "mods/Noita40K/files/40K.bank" )
			ComponentSetValue2( data.sfx_comp, "event_root", "classes/12/mk7" )
			
			ComponentSetValue2( data.char_comp, "mass", 9 + ComponentGetValue2( data.char_comp, "mass" ))
			
			ComponentSetValue2( data.plat_comp, "swim_up_buoyancy_coeff", 0.2 )
			ComponentSetValue2( data.plat_comp, "swim_idle_buoyancy_coeff", 0.1 )
			ComponentSetValue2( data.plat_comp, "swim_down_buoyancy_coeff", 0 )
			
			ComponentSetValue2( data.dmg_comp, "fire_damage_ignited_amount", 0 )
			ComponentSetValue2( data.dmg_comp, "fire_probability_of_ignition", 0 )

			n40.add_resistance( data.dmg_comp, "radioactive", 0.75 )
			n40.add_resistance( data.dmg_comp, "fire", 0.75 )
			n40.add_resistance( data.dmg_comp, "ice", 0.75 )
			n40.add_resistance( data.dmg_comp, "poison", 0.75 )
			n40.add_resistance( data.dmg_comp, "drill", 0.5 )
			n40.add_resistance( data.dmg_comp, "physics_hit", 0.5 )
			n40.add_resistance( data.dmg_comp, "explosion", 0.25 )
			n40.add_resistance( data.dmg_comp, "projectile", 0.25 )
			n40.add_resistance( data.dmg_comp, "slice", 0.1 )
			n40.add_resistance( data.dmg_comp, "melee", 0.1 )

			n40.add_effect( hooman, "STAINS_DROP_FASTER" )
			n40.add_vector_ctrl( hooman, "mods/Noita40K/files/classes/_perks/armour.lua" )
		end,
	},
	MKVII_BLOOD_ANGEL = {
		name = "$n40_PERK_armor_mk7_blood_angel", desc = "$n40_PERK_armor_mk7_blood_angel_",
		func = function( hooman, data ) n40.PERKS.MKVII_ULTRAMARINE.func( hooman, data, "2_blood_angel" ) end
	},
	MKVII_IMPERIAL_FIST = {
		name = "$n40_PERK_armor_mk7_imperial_fist", desc = "$n40_PERK_armor_mk7_imperial_fist_",
		func = function( hooman, data ) n40.PERKS.MKVII_ULTRAMARINE.func( hooman, data, "3_imperial_fist" ) end
	},
	MKVII_WHITE_SCAR = {
		name = "$n40_PERK_armor_mk7_white_scar", desc = "$n40_PERK_armor_mk7_white_scar_",
		func = function( hooman, data ) n40.PERKS.MKVII_ULTRAMARINE.func( hooman, data, "4_white_scar" ) end
	},
	MKVII_IRON_HAND = {
		name = "$n40_PERK_armor_mk7_iron_hand", desc = "$n40_PERK_armor_mk7_iron_hand_",
		func = function( hooman, data ) n40.PERKS.MKVII_ULTRAMARINE.func( hooman, data, "5_iron_hand" ) end
	},
	MKVII_SPACE_WOLF = {
		name = "$n40_PERK_armor_mk7_space_wolf", desc = "$n40_PERK_armor_mk7_space_wolf_",
		func = function( hooman, data ) n40.PERKS.MKVII_ULTRAMARINE.func( hooman, data, "6_space_wolf" ) end
	},
	MKVII_SALAMANDER = {
		name = "$n40_PERK_armor_mk7_salamander", desc = "$n40_PERK_armor_mk7_salamander_",
		func = function( hooman, data ) n40.PERKS.MKVII_ULTRAMARINE.func( hooman, data, "7_salamander" ) end
	},
	MKVII_RAVEN_GUARD = {
		name = "$n40_PERK_armor_mk7_raven_guard", desc = "$n40_PERK_armor_mk7_raven_guard_",
		func = function( hooman, data ) n40.PERKS.MKVII_ULTRAMARINE.func( hooman, data, "8_raven_guard" ) end
	},
	MKVII_DARK_ANGEL = {
		name = "$n40_PERK_armor_mk7_dark_angel", desc = "$n40_PERK_armor_mk7_dark_angel_",
		func = function( hooman, data ) n40.PERKS.MKVII_ULTRAMARINE.func( hooman, data, "9_dark_angel" ) end
	},
	SICARIAN_ARMOUR = {
		name = "$n40_PERK_armor_sicarian", desc = "$n40_PERK_armor_sicarian_",
	},
	
	-- abilities
	SECOND_HEART = {
		name = "$n40_PERK_second_heart", desc = "$n40_PERK_second_heart_",
		-- vector_ctrl = "",
		func = function( hooman, data )
			EntityAddComponent2( hooman, "LuaComponent", {
				script_damage_received = "mods/Noita40K/files/scripts/perks/second_heart.lua",
				execute_every_n_frame = -1,
			})
		end,
	},
	OSSMODULA = {
		name = "$n40_PERK_ossmodula", desc = "$n40_PERK_ossmodula_",
		func = function( hooman, data )
			ComponentSetValue2( data.char_comp, "mass", 3 + ComponentGetValue2( data.char_comp, "mass" ))

			ComponentSetValue2( data.dmg_comp, "hp", 10*ComponentGetValue2( data.dmg_comp, "hp" ))
			ComponentSetValue2( data.dmg_comp, "max_hp", 10*ComponentGetValue2( data.dmg_comp, "max_hp" ))

			ComponentSetValue2( data.dmg_comp, "fire_damage_amount",
				0.1*ComponentGetValue2( data.dmg_comp, "fire_damage_amount" ))
			ComponentSetValue2( data.dmg_comp, "minimum_knockback_force",
				1 + ComponentGetValue2( data.dmg_comp, "minimum_knockback_force" ))
			ComponentSetValue2( data.dmg_comp, "critical_damage_resistance",
				math.min( 0.25 + ComponentGetValue2( data.dmg_comp, "critical_damage_resistance" ), 1 ))

			n40.add_resistance( data.dmg_comp, "overeating", 0.75 )
			n40.add_resistance( data.dmg_comp, "electricity", 0.75 )
			n40.add_resistance( data.dmg_comp, "radioactive", 0.5 )
			n40.add_resistance( data.dmg_comp, "fire", 0.5 )
			n40.add_resistance( data.dmg_comp, "ice", 0.5 )
			n40.add_resistance( data.dmg_comp, "poison", 0.1 )
		end,
	},
	BISCOPEA = {
		name = "$n40_PERK_biscopea", desc = "n40_PERK_biscopea_",
		func = function( hooman, data )
			ComponentSetValue2( data.char_comp, "mass", 2 + ComponentGetValue2( data.char_comp, "mass" ))

			ComponentSetValue2( data.plat_comp, "run_velocity",
				1.2*ComponentGetValue2( data.plat_comp, "run_velocity" ))
			ComponentSetValue2( data.plat_comp, "jump_velocity_x",
				1.5*ComponentGetValue2( data.plat_comp, "jump_velocity_x" ))
			ComponentSetValue2( data.plat_comp, "jump_velocity_y",
				1.5*ComponentGetValue2( data.plat_comp, "jump_velocity_y" ))

			ComponentSetValue2( data.kick_comp, "max_force",
				20*ComponentGetValue2( data.kick_comp, "max_force" ))
			ComponentSetValue2( data.kick_comp, "player_kickforce",
				20*ComponentGetValue2( data.kick_comp, "player_kickforce" ))
			ComponentSetValue2( data.kick_comp, "kick_damage",
				25*ComponentGetValue2( data.kick_comp, "kick_damage" ))
			ComponentSetValue2( data.kick_comp, "kick_knockback",
				10*ComponentGetValue2( data.kick_comp, "kick_knockback" ))
		end,
	},
	LARRAMAN = {
		name = "$n40_PERK_larraman", desc = "$n40_PERK_larraman_",
		func = function( hooman, data )
			n40.add_resistance( data.dmg_comp, "healing", 2 )

			-- EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
			-- { 
			-- 	_tags = "larraman_frame",
			-- 	name = "larraman_frame",
			-- 	value_int = "600",
			-- })
		
			-- EntityAddComponent( entity_who_picked, "LuaComponent", 
			-- { 
			-- 	script_source_file = "mods/Noita40K/files/scripts/perks/larraman.lua",
			-- 	execute_every_n_frame = "1",
			-- })
			
			-- EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
			-- { 
			-- 	_tags = "larraman_protects",
			-- 	name = "larraman_protects",
			-- 	value_int = "5",
			-- })
			
			-- EntityAddComponent( entity_who_picked, "LuaComponent", 
			-- { 
			-- 	_tags = "larraman_death",
			-- 	script_damage_received = "mods/Noita40K/files/scripts/perks/larraman_death.lua",
			-- 	execute_every_n_frame = "-1",
			-- })
		end,
	},
	OCCULOBE = {
		name = "$n40_PERK_occulobe", desc = "$n40_PERK_occulobe_",
		func = function( hooman, data )
			local eye_x, eye_y = EntityGetHotspot( hooman, "eye", nil, true )
			EntityAddComponent2( hooman, "LightComponent", {
				r = 255, g = 255, b = 255,
				radius = 1000, offset_x = eye_x, offset_y = eye_y,
			})
			
			-- EntityAddComponent( entity_who_picked, "SpriteComponent", 
			-- { 
			-- 	_tags = "fog_o_war_hole",
			-- 	alpha = "0.5",
			-- 	emissive = "0",
			-- 	image_file = "mods/Noita40K/files/pics/misc_gfx/fog_of_war_hole_64.xml",
			-- 	smooth_filtering = "1",
			-- 	fog_of_war_hole = "1",
			-- })
		end,
	},
	SUS_AN = {
		name = "$n40_PERK_sus_an", desc = "$n40_PERK_sus_an_",
		func = function( hooman, data )
			-- EntityAddComponent( entity_who_picked, "LuaComponent", 
			-- {
			-- 	_tags = "sus_an",
			-- 	script_damage_received = "mods/Noita40K/files/scripts/perks/sus_an.lua",
			-- 	execute_every_n_frame = "-1",
			-- })
		end,
	},
	CODEX_MASTERY = {
		name = "$n40_PERK_codex_mastery", desc = "$n40_PERK_codex_mastery_",
	},
	BLACK_RAGE = {
		name = "$n40_PERK_black_rage", desc = "$n40_PERK_black_rage_",
	},
	CHOGORIAN_SAVAGERY = {
		name = "$n40_PERK_chogorian_savagery", desc = "$n40_PERK_chogorian_savagery_",
	},
	EMPERORS_PRAETORIAN = {
		name = "$n40_PERK_emperors_praetorian", desc = "$n40_PERK_emperors_praetorian_",
		-- [{ "damage_multipliers", "curse" }] = 0.25,
	},
	FENRISIAN_BLOOD = {
		name = "$n40_PERK_fenrisian_blood", desc = "$n40_PERK_fenrisian_blood_",
	},
	NOCTURNE_FORGED = {
		name = "$n40_PERK_nocturne_forged", desc = "$n40_PERK_nocturne_forged_",
	},
	LIVING_SHADOW = {
		name = "$n40_PERK_living_shadow", desc = "$n40_PERK_living_shadow_",
	},
	UNCHAINED = {
		name = "$n40_PERK_unchained", desc = "$n40_PERK_unchained_",
	},
	OMNISSIAHS_BLESSING = {
		name = "$n40_PERK_omnissiahs_blessing", desc = "$n40_PERK_omnissiahs_blessing_",
	},
	ETERNAL_VIGILANCE = {
		name = "$n40_PERK_eternal_vigilance", desc = "$n40_PERK_eternal_vigilance_",
	},
	BREATH_OF_MARS = {
		name = "$n40_PERK_breath_of_mars", desc = "$n40_PERK_breath_of_mars_",
	},
	MECHADENDRITES = {
		name = "$n40_PERK_mechadendrites", desc = "$n40_PERK_mechadendrites_",
	},
}

n40.CLASSES = {
	{
		name = "$n40_CLASS_1", desc = "$n40_CLASS_1_",
		-- icon = "",
	},
	{
		name = "$n40_CLASS_2", desc = "$n40_CLASS_2_",
	},
	{
		name = "$n40_CLASS_3", desc = "$n40_CLASS_3_",
	},
	{
		name = "$n40_CLASS_4", desc = "$n40_CLASS_4_",
	},
	{
		name = "$n40_CLASS_5", desc = "$n40_CLASS_5_",
	},
	{
		name = "$n40_CLASS_6", desc = "$n40_CLASS_6_",
	},
	{
		name = "$n40_CLASS_7", desc = "$n40_CLASS_7_",
	},
	{
		name = "$n40_CLASS_8", desc = "$n40_CLASS_8_",
	},
	{
		name = "$n40_CLASS_9", desc = "$n40_CLASS_9_",
	},
	{
		name = "$n40_CLASS_10", desc = "$n40_CLASS_10_",
	},
	{
		name = "$n40_CLASS_11", desc = "$n40_CLASS_11_",
	},
	{
		name = "$n40_CLASS_12", desc = "$n40_CLASS_12_",
	},
	{
		name = "$n40_CLASS_13", desc = "$n40_CLASS_13_",
	},
	{
		name = "$n40_CLASS_14", desc = "$n40_CLASS_14_",
	},
	{
		name = "$n40_CLASS_15", desc = "$n40_CLASS_15_",
	},
}

n40.CLASSES[1].sections = {
	{
		name = "$n40_CLASS_1_1", desc = "$n40_CLASS_1_1_",
		-- icon = "",
	},
	{
		name = "$n40_CLASS_1_2", desc = "$n40_CLASS_1_2_",

		guns = { "BOLTER", "BOLTER_RIFLE", "SWORD_CHAIN", "MELTA_CUTTER" },
		items = { "GRENADE_HE", "GRENADE_HE" },
		equipment = { "JUMPPACK" },
		perks = {
			"SECOND_HEART",
			"OSSMODULA",
			"BISCOPEA",
			"LARRAMAN",
			"OCCULOBE",
			"SUS_AN",
		},
	},
	{
		name = "$n40_CLASS_1_3", desc = "$n40_CLASS_1_3_",
	},
	{
		name = "$n40_CLASS_1_4", desc = "$n40_CLASS_1_4_",
	},
}

n40.CLASSES[1].sections[2].chars = {
	{
		name = "$n40_CLASS_1_2_1", desc = "$n40_CLASS_1_2_1_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_ultramarine.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_ultramarine.png",
		-- author = "Bruham/YourDoom",

		-- guns = {},
		-- items = {},
		items_add = { "GRENADE_FLASHBANG" },
		-- equipment = {},
		-- equipment_add = {},
		
		skin = "MKVII_ULTRAMARINE",
		perks_add = { "CODEX_MASTERY" },
		-- perks_remove = {},
		-- func = nil,
	},
	{
		name = "$n40_CLASS_1_2_2", desc = "$n40_CLASS_1_2_2_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_blood_angel.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_blood_angel.png",

		guns = { [1] = "BOLTER_RAPID" },
		skin = "MKVII_BLOOD_ANGEL", perks_add = { "BLACK_RAGE" },
	},
	{
		name = "$n40_CLASS_1_2_3", desc = "$n40_CLASS_1_2_3_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_imperial_fist.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_imperial_fist.png",

		equipment_add = { "SHIELD_S" },
		skin = "MKVII_IMPERIAL_FIST", perks_add = { "EMPERORS_PRAETORIAN" }, perks_remove = { "SUS_AN" },
	},
	{
		name = "$n40_CLASS_1_2_4", desc = "$n40_CLASS_1_2_4_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_white_scar.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_white_scar.png",

		equipment = { [1] = "JUMPPACK_UPGRADE" },
		skin = "MKVII_WHITE_SCAR", perks_add = { "CHOGORIAN_SAVAGERY" },
	},
	{
		name = "$n40_CLASS_1_2_5", desc = "$n40_CLASS_1_2_5_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_iron_hand.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_iron_hand.png",

		guns = { [1] = "BOLTER_COMBIMELTA" },
		skin = "MKVII_IRON_HAND", perks_add = { "OMNISSIAHS_BLESSING", "ETERNAL_VIGILANCE" },
	},
	{
		name = "$n40_CLASS_1_2_6", desc = "$n40_CLASS_1_2_6_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_space_wolf.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_space_wolf.png",
		
		items_add = { "KEG" },
		skin = "MKVII_SPACE_WOLF", perks_add = { "FENRISIAN_BLOOD" },
	},
	{
		name = "$n40_CLASS_1_2_7", desc = "$n40_CLASS_1_2_7_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_salamander.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_salamander.png",
		
		guns = { [1] = "BOLTER_INCENDIARY" },
		items = { "GRENADE_HEI", "GRENADE_HEI" },
		skin = "MKVII_SALAMANDER", perks_add = { "NOCTURNE_FORGED" },
	},
	{
		name = "$n40_CLASS_1_2_8", desc = "$n40_CLASS_1_2_8_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_raven_guard.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_raven_guard.png",
		
		guns = { [1] = "BOLTER_STALKER" },
		items = { "GRENADE_FLASHBANG", "GRENADE_FLASHBANG" },
		skin = "MKVII_RAVEN_GUARD", perks_add = { "LIVING_SHADOW" },
	},
	{
		name = "$n40_CLASS_1_2_9", desc = "$n40_CLASS_1_2_9_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_dark_angel.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_dark_angel.png",
		
		guns = { [1] = "BOLTER_ARCHEO" },
		items_add = { "GRENADE_RUPTOR" },
		equipment_add = { "OSCULANT_DEVICE" },
		skin = "MKVII_DARK_ANGEL", perks_add = { "UNCHAINED" },
	},
}

n40.CLASSES[3].sections = {
	{
		name = "$n40_CLASS_3_1", desc = "$n40_CLASS_3_1_",
	},
	{
		name = "$n40_CLASS_3_2", desc = "$n40_CLASS_3_2_",
		
		items = { "GRENADE_ARC", "GRENADE_ARC" },
		equipment = { "SERVOSKULL" },
		perks = { "OMNISSIAHS_BLESSING", "ETERNAL_VIGILANCE", "BREATH_OF_MARS" },
	},
	{
		name = "$n40_CLASS_3_3", desc = "$n40_CLASS_3_3_",
	},
	{
		name = "$n40_CLASS_3_4", desc = "$n40_CLASS_3_4_",
	},
}

n40.CLASSES[3].sections[2].chars = {
	{
		name = "$n40_CLASS_3_2_1", desc = "$n40_CLASS_3_2_1_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_tech_priest_magos_explorator.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/tech_priest_magos_explorator.png",
		
		guns = { "VOLKITE_PISTOL", "DARKFIRE_RIFLE", "SWORD_SOLLEX", "LASGUN_MITRA" },
		equipment_add = { "REFRACTOR_FIELD" },
		skin = "SICARIAN_ARMOUR", perks_add = { "MECHADENDRITES", "UNCHAINED" },
	},
}

n40.CLASSES[6].sections = {
	{
		name = "$n40_CLASS_6_1", desc = "$n40_CLASS_6_1_",
	},
	{
		name = "$n40_CLASS_6_2", desc = "$n40_CLASS_6_2_",
	},
	{
		name = "$n40_CLASS_6_3", desc = "$n40_CLASS_6_3_",
	},
	{
		name = "$n40_CLASS_6_4", desc = "$n40_CLASS_6_4_",
	},
}

n40.CLASSES[6].sections[2].chars = {
	{
		name = "$n40_CLASS_6_2_1", desc = "$n40_CLASS_6_2_1_",
	},
}

n40.CODEX = {
	BRIEFING = "$n40_CODEX_briefing", --translation is a full encoded table
	PERSONNEL = {}, -- perks are displayed here
	WARGEAR = {}, -- populated procedurally
	DATABASE = {}, -- basically a progress log
	CREDITS = {},
}

n40.CODEX.CREDITS = {
	{ "$n40_CODEX_credits_author_code", "Bruham" },
	{ "$n40_CODEX_credits_author_sprites", "YourDoom" },
	{ "$n40_CODEX_credits_author_extra", { --sort alphabetically
		"Rib",
	}},
	{ "$n40_CODEX_credits_patreon", {
		{ "Vibrant Causality", 9999999 },
		{ "pants", 999999 },
	}},
	{ "$n40_CODEX_credits_extra", { --sort alphabetically; include all Quires from CA
		{ "ryyst", true }, --some are always at the top os the list
		{ "Copi", true },
		"Ancient",
		"etwas_merkwuerdig",
		"Whollow",
		"Vromikos",
		"Horscht",
		"Archaeopteryx",
		"Disco Witch",
	}},
}

n40.QUOTES = "$n40_EXTRA_quotes" --encoded table + add like 30 more