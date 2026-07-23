n40 = n40 or {}

n40.GUNS = --obtain codex stats from xml parsing
{
	-- SLOT 1 (good all-arounder)
	BOLTER_PISTOL = {
		-- icon = true, --replace with string for custom one
		name = "$n40_GUN_bolter_pistol", desc = "$n40_GUN_bolter_pistol_",
		path = "mods/Noita40K/files/items/weapons/bolter_pistol.xml",
		-- func = nil,
	},
	BOLTER_GENERIC = {
		name = "$n40_GUN_bolter_generic", desc = "$n40_GUN_bolter_generic_",
		path = "mods/Noita40K/files/items/weapons/bolter_generic.xml",
	},
	BOLTER_COMBIMELTA = {
		name = "$n40_GUN_bolter_combimelta", desc = "$n40_GUN_bolter_combimelta_",
		path = "mods/Noita40K/files/items/weapons/bolter_combimelta.xml",
	},
	BOLTER_INCENDIARY = {
		name = "$n40_GUN_bolter_incendiary", desc = "$n40_GUN_bolter_incendiary_",
		path = "mods/Noita40K/files/items/weapons/bolter_incendiary.xml",
	},
	BOLTER_RAPID = {
		name = "$n40_GUN_bolter_rapid", desc = "$n40_GUN_bolter_rapid_",
		path = "mods/Noita40K/files/items/weapons/bolter_rapid.xml",
	},
	BOLTER_ARCHEO = {
		name = "$n40_GUN_bolter_archeo", desc = "$n40_GUN_bolter_archeo_",
		path = "mods/Noita40K/files/items/weapons/bolter_archeo.xml",
	},
	BOLTER_STALKER = {
		name = "$n40_GUN_bolter_stalker", desc = "$n40_GUN_bolter_stalker_",
		path = "mods/Noita40K/files/items/weapons/bolter_stalker.xml",
	},
	VOLKITE_PISTOL = {
		name = "$n40_GUN_volkite_pistol", desc = "$n40_GUN_volkite_pistol_",
		path = "mods/Noita40K/files/items/weapons/volkite_pistol.xml",
	},

	-- SLOT 2 (niche-use and skill-based)
	PLASMA_PISTOL = {
		name = "$n40_GUN_plasma_pistol", desc = "$n40_GUN_plasma_pistol_",
		path = "mods/Noita40K/files/items/weapons/plasma_pistol.xml",
	},
	BOLTER_RIFLE = {
		name = "$n40_GUN_bolter_rifle", desc = "$n40_GUN_bolter_rifle_",
		path = "mods/Noita40K/files/items/weapons/bolter_rifle.xml",
		func = function( hooman, data ) n40.new_item( n40.ITEMS.BAYONET_L, hooman, data ) end,
	},
	-- salamander gets flamer as rifle replacement
	DARKFIRE_RIFLE = {
		name = "$n40_GUN_darkfire_rifle", desc = "$n40_GUN_darkfire_rifle_",
		path = "mods/Noita40K/files/items/weapons/darkfire_rifle.xml",
	},

	-- SLOT 3 (melee)
	SWORD_CHAIN = {
		name = "$n40_GUN_sword_chain", desc = "$n40_GUN_sword_chain_",
		path = "mods/Noita40K/files/items/weapons/sword_chain.xml",
	},
	SWORD_CHAIN_LARGE = {
		name = "$n40_GUN_sword_chain_large", desc = "$n40_GUN_sword_chain_large_",
		path = "mods/Noita40K/files/items/weapons/sword_chain_large.xml",
	},
	SWORD_SOLLEX = {
		name = "$n40_GUN_sword_sollex", desc = "$n40_GUN_sword_sollex_",
		path = "mods/Noita40K/files/items/weapons/sword_sollex.xml",
	},

	-- SLOT 4 (utility)
	MELTA_PISTOL = {
		name = "$n40_GUN_melta_pistol", desc = "$n40_GUN_melta_pistol_",
		path = "mods/Noita40K/files/items/weapons/melta_pistol.xml",
	},
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
	-- attachments
	BAYONET_L = {
		name = "$n40_ITEM_bayonet_l", desc = "$n40_ITEM_bayonet_l_",
		path = "mods/Noita40K/files/items/attachments/bayonet_l.xml",
	},

	-- throwables
	GRENADE_HE = {
		name = "$n40_ITEM_grenade_he", desc = "$n40_ITEM_grenade_he_",
		path = "mods/Noita40K/files/items/grenade_he.xml",
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
	JUMPPACK_L = {
		name = "$n40_EQUIPMENT_jumppack_l", desc = "$n40_EQUIPMENT_jumppack_l_",
		path = "mods/Noita40K/files/items/equipment/jumppack_l.xml",
	},
	JUMPPACK_L_UPGRADE = {
		name = "$n40_EQUIPMENT_jumppack_l_upgrade", desc = "$n40_EQUIPMENT_jumppack_l_upgrade_",
		path = "",
	},

	-- utility
	SERVOSKULL = {
		name = "$n40_EQUIPMENT_servoskull", desc = "$n40_EQUIPMENT_servoskull_",
		path = "", --five variants: Janus, Hemera, Eunomia, Limos, Oizys
	},
	OSCULANT_DEVICE = {
		name = "$n40_EQUIPMENT_osculant_device", desc = "$n40_EQUIPMENT_osculant_device_",
		path = "",
	},
}

n40.PERKS = {
	-- skins
	ARMOR_MK7_ULTRA = {
		icon = "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/1_ultramarine/icon.png",
		name = "$n40_PERK_armor_mk7_ultramarine", desc = "$n40_PERK_armor_mk7_ultramarine_",
		-- vector_ctrl = "",
		func = function( hooman, data, char_name )
			char_name = char_name or "1_ultramarine"
			ComponentSetValue2( data.pic_char, "image_file",
				"mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/"..char_name.."/player.xml" )
			ComponentSetValue2( data.dmg_comp, "ragdoll_filenames_file",
				"mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/"..char_name.."/ragdoll/filenames.txt" )
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( data.arm_id, "HotspotComponent" ), "offset", -0.5, 0 )
			
			pen.magic_storage( hooman, "taunt_voice", "value_string", "12/taunts_1" )
			ComponentSetValue2( data.sfx_comp, "file", "mods/Noita40K/files/40K.bank" )
			ComponentSetValue2( data.sfx_comp, "event_root", "movement/armor_large" )
			
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

			data.breathing_immune = true
			data.contact_immune = true
			data.threshold_burn = 2*( data.threshold_burn or 25 )
			data.threshold_corrosion = 5*( data.threshold_burn or 5 )
			data.threshold_radiation = 999
			data.threshold_piercing = 999
			data.threshold_poison = 999

			n40.add_effect( hooman, "STAINS_DROP_FASTER" )
			n40.add_effect( hooman, "PROTECTION_RADIOACTIVITY" )
			n40.add_vector_ctrl( hooman, "mods/Noita40K/files/misc/ctrl_armor.lua" )
			n40.add_vector_ctrl( hooman, "mods/Noita40K/files/misc/ctrl_breath.lua" )

			pen.magic_storage( hooman, "reactor_load", "value_int",
				pen.magic_storage( hooman, "reactor_load", "value_int", nil, 1 ) + 4 )
			pen.magic_storage( hooman, "reactor_limit", "value_float", 250 )
			pen.magic_storage( hooman, "reactor_target", "value_float", 200 )
			n40.add_vector_ctrl( hooman, "mods/Noita40K/files/misc/ctrl_reactor.lua" )

			return data
		end,
	},
	ARMOR_MK7_BLOOD = {
		icon = "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/2_blood_angel/icon.png",
		name = "$n40_PERK_armor_mk7_blood_angel", desc = "$n40_PERK_armor_mk7_blood_angel_",
		func = function( hooman, data ) n40.PERKS.ARMOR_MK7_ULTRA.func( hooman, data, "2_blood_angel" ) end
	},
	ARMOR_MK7_IMPERIAL = {
		icon = "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/3_imperial_fist/icon.png",
		name = "$n40_PERK_armor_mk7_imperial_fist", desc = "$n40_PERK_armor_mk7_imperial_fist_",
		func = function( hooman, data ) n40.PERKS.ARMOR_MK7_ULTRA.func( hooman, data, "3_imperial_fist" ) end
	},
	ARMOR_MK7_WHITE = {
		icon = "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/4_white_scar/icon.png",
		name = "$n40_PERK_armor_mk7_white_scar", desc = "$n40_PERK_armor_mk7_white_scar_",
		func = function( hooman, data ) n40.PERKS.ARMOR_MK7_ULTRA.func( hooman, data, "4_white_scar" ) end
	},
	ARMOR_MK7_IRON = {
		icon = "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/5_iron_hand/icon.png",
		name = "$n40_PERK_armor_mk7_iron_hand", desc = "$n40_PERK_armor_mk7_iron_hand_",
		func = function( hooman, data ) n40.PERKS.ARMOR_MK7_ULTRA.func( hooman, data, "5_iron_hand" ) end
	},
	ARMOR_MK7_WOLF = {
		icon = "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/6_space_wolf/icon.png",
		name = "$n40_PERK_armor_mk7_space_wolf", desc = "$n40_PERK_armor_mk7_space_wolf_",
		func = function( hooman, data ) n40.PERKS.ARMOR_MK7_ULTRA.func( hooman, data, "6_space_wolf" ) end
	},
	ARMOR_MK7_SALAMANDER = {
		icon = "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/7_salamander/icon.png",
		name = "$n40_PERK_armor_mk7_salamander", desc = "$n40_PERK_armor_mk7_salamander_",
		func = function( hooman, data ) n40.PERKS.ARMOR_MK7_ULTRA.func( hooman, data, "7_salamander" ) end
	},
	ARMOR_MK7_RAVEN = {
		icon = "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/8_raven_guard/icon.png",
		name = "$n40_PERK_armor_mk7_raven_guard", desc = "$n40_PERK_armor_mk7_raven_guard_",
		func = function( hooman, data ) n40.PERKS.ARMOR_MK7_ULTRA.func( hooman, data, "8_raven_guard" ) end
	},
	ARMOR_MK7_DARK = {
		icon = "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/9_dark_angel/icon.png",
		name = "$n40_PERK_armor_mk7_dark_angel", desc = "$n40_PERK_armor_mk7_dark_angel_",
		func = function( hooman, data ) n40.PERKS.ARMOR_MK7_ULTRA.func( hooman, data, "9_dark_angel" ) end
	},
	ARMOR_SICARIAN = {
		icon = "mods/Noita40K/files/classes/3_adeptus_mechanicus/2_techpriest/1_magos_explorator/icon.png",
		name = "$n40_PERK_armor_sicarian", desc = "$n40_PERK_armor_sicarian_",
		func = function( hooman, data )
			ComponentSetValue2( data.pic_char, "image_file",
				"mods/Noita40K/files/classes/3_adeptus_mechanicus/2_techpriest/1_magos_explorator/player.xml" )
			ComponentSetValue2( data.dmg_comp, "ragdoll_filenames_file",
				"mods/Noita40K/files/classes/3_adeptus_mechanicus/2_techpriest/1_magos_explorator/ragdoll/filenames.txt" )
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( data.arm_id, "HotspotComponent" ), "offset", -0.5, -0.5 )
			
			pen.magic_storage( hooman, "taunt_voice", "value_string", "32/taunts_2" )
			ComponentSetValue2( data.sfx_comp, "file", "mods/Noita40K/files/40K.bank" )
			ComponentSetValue2( data.sfx_comp, "event_root", "movement/machine" )
			
			ComponentSetValue2( data.char_comp, "mass", 1 + ComponentGetValue2( data.char_comp, "mass" ))
			
			ComponentSetValue2( data.plat_comp, "swim_up_buoyancy_coeff", 0.2 )
			ComponentSetValue2( data.plat_comp, "swim_idle_buoyancy_coeff", 0.1 )
			ComponentSetValue2( data.plat_comp, "swim_down_buoyancy_coeff", 0 )

			EntityAddComponent2( hooman, "LuaComponent", {
				script_damage_received = "mods/Noita40K/files/misc/ctrl_armor.lua",
				execute_every_n_frame = -1,
			})

			pen.magic_storage( hooman, "reactor_load", "value_int",
				pen.magic_storage( hooman, "reactor_load", "value_int", nil, 1 ) + 3 )

			data.contact_immune = true
			data.threshold_piercing = 999
			n40.add_effect( hooman, "STAINS_DROP_FASTER" )
			return data
		end,
	},
	ARMOR_SORORITAS = {
		icon = "mods/Noita40K/files/classes/6_inquisition/1_ordo_hereticus/1_adepta_sororitas/icon.png",
		name = "$n40_PERK_armor_sororitas", desc = "$n40_PERK_armor_sororitas_",
		func = function( hooman, data )
			ComponentSetValue2( data.pic_char, "image_file",
				"mods/Noita40K/files/classes/6_inquisition/1_ordo_hereticus/1_adepta_sororitas/player.xml" )
			ComponentSetValue2( data.dmg_comp, "ragdoll_filenames_file",
				"mods/Noita40K/files/classes/6_inquisition/1_ordo_hereticus/1_adepta_sororitas/ragdoll/filenames.txt" )
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( data.arm_id, "HotspotComponent" ), "offset", -0.5, -0.5 )
			
			local x, y = EntityGetTransform( hooman )
			EntityAddChild( hooman, EntityLoad( "mods/Noita40K/files/classes/6_inquisition/1_ordo_hereticus/1_adepta_sororitas/cloth/cloth.xml", x, y - 4 ))

			pen.magic_storage( hooman, "taunt_voice", "value_string", "32/taunts_2" )
			ComponentSetValue2( data.sfx_comp, "file", "mods/Noita40K/files/40K.bank" )
			ComponentSetValue2( data.sfx_comp, "event_root", "movement/armor" )
			
			ComponentSetValue2( data.char_comp, "mass", 1 + ComponentGetValue2( data.char_comp, "mass" ))
			
			ComponentSetValue2( data.plat_comp, "swim_up_buoyancy_coeff", 0.2 )
			ComponentSetValue2( data.plat_comp, "swim_idle_buoyancy_coeff", 0.1 )
			ComponentSetValue2( data.plat_comp, "swim_down_buoyancy_coeff", 0 )
			
			ComponentSetValue2( data.dmg_comp, "fire_damage_ignited_amount", 0 )
			ComponentSetValue2( data.dmg_comp, "fire_probability_of_ignition", 0 )
			
			n40.add_strength( data.kick_comp, 0.4 )

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

			data.breathing_immune = true
			data.contact_immune = true
			data.threshold_burn = 2*( data.threshold_burn or 25 )
			data.threshold_corrosion = 5*( data.threshold_burn or 5 )
			data.threshold_piercing = 999

			n40.add_effect( hooman, "STAINS_DROP_FASTER" )
			n40.add_vector_ctrl( hooman, "mods/Noita40K/files/misc/ctrl_armor.lua" )
			n40.add_vector_ctrl( hooman, "mods/Noita40K/files/misc/ctrl_breath.lua" )

			return data
		end,
	},
	
	-- abilities
	SECOND_HEART = {
		icon = "mods/Noita40K/files/classes/_perks/second_heart.png",
		name = "$n40_PERK_second_heart", desc = "$n40_PERK_second_heart_",
		func = function( hooman, data )
			n40.add_vector_ctrl( hooman, "mods/Noita40K/files/misc/ctrl_status.lua" )
			EntityAddComponent2( hooman, "LuaComponent", {
				script_damage_received = "mods/Noita40K/files/classes/_perks/second_heart.lua",
				execute_every_n_frame = -1,
			})
		end,
	},
	OSSMODULA = {
		icon = "mods/Noita40K/files/classes/_perks/ossmodula.png",
		name = "$n40_PERK_ossmodula", desc = "$n40_PERK_ossmodula_",
		func = function( hooman, data )
			ComponentSetValue2( data.char_comp, "mass", 3 + ComponentGetValue2( data.char_comp, "mass" ))

			ComponentSetValue2( data.dmg_comp, "hp", 10*ComponentGetValue2( data.dmg_comp, "hp" ))
			ComponentSetValue2( data.dmg_comp, "max_hp", 10*ComponentGetValue2( data.dmg_comp, "max_hp" ))

			ComponentSetValue2( data.dmg_comp, "fire_damage_amount",
				0.1*ComponentGetValue2( data.dmg_comp, "fire_damage_amount" ))
			ComponentSetValue2( data.dmg_comp, "minimum_knockback_force",
				10*math.max( ComponentGetValue2( data.dmg_comp, "minimum_knockback_force" ), 50 ))
			ComponentSetValue2( data.dmg_comp, "critical_damage_resistance",
				math.min( 0.25 + ComponentGetValue2( data.dmg_comp, "critical_damage_resistance" ), 1 ))

			n40.add_resistance( data.dmg_comp, "overeating", 0.75 )
			n40.add_resistance( data.dmg_comp, "electricity", 0.75 )
			n40.add_resistance( data.dmg_comp, "radioactive", 0.5 )
			n40.add_resistance( data.dmg_comp, "fire", 0.5 )
			n40.add_resistance( data.dmg_comp, "ice", 0.5 )
			n40.add_resistance( data.dmg_comp, "poison", 0.1 )

			data.threshold_poison = 10*( data.threshold_poison or 10 )
			data.threshold_radiation = 5*( data.threshold_radiation or 10 )

			return data
		end,
	},
	BISCOPEA = {
		icon = "mods/Noita40K/files/classes/_perks/biscopea.png",
		name = "$n40_PERK_biscopea", desc = "n40_PERK_biscopea_",
		func = function( hooman, data )
			--requires ossmodula
			ComponentSetValue2( data.char_comp, "mass", 2 + ComponentGetValue2( data.char_comp, "mass" ))
			n40.add_strength( data.kick_comp, 1 )
		end,
	},
	LARRAMAN = {
		icon = "mods/Noita40K/files/classes/_perks/larraman.png",
		name = "$n40_PERK_larraman", desc = "$n40_PERK_larraman_",
		func = function( hooman, data )
			--regeneration that consumes adrenaline to heal

			n40.add_resistance( data.dmg_comp, "healing", 2 )
			data.threshold_heal = -math.min( 0.1*( math.abs( data.threshold_heal or 0 ) + 1 ), 0.5 )

			return data
		end,
	},
	OCCULOBE = {
		icon = "mods/Noita40K/files/classes/_perks/occulobe.png",
		name = "$n40_PERK_occulobe", desc = "$n40_PERK_occulobe_",
		func = function( hooman, data )
			local eye_x, eye_y = EntityGetHotspot( hooman, "eye", nil, true )
			EntityAddComponent2( hooman, "LightComponent", {
				r = 200, g = 255, b = 200,
				radius = 250, offset_x = eye_x, offset_y = eye_y,
			})
			EntityAddComponent2( hooman, "SpriteComponent", {
				smooth_filtering = true, fog_of_war_hole = true,
				alpha = 0.5, offset_x = 65 + eye_x, offset_y = 32 - eye_y,
				image_file = "mods/Noita40K/files/classes/_perks/occulobe_vision.png",
			})
		end,
	},
	SUS_AN = {
		icon = "mods/Noita40K/files/classes/_perks/sus_an.png",
		name = "$n40_PERK_sus_an", desc = "$n40_PERK_sus_an_",
		func = function( hooman, data )
			-- requires larraman
			-- the life should be regenning and regen speed and quality should be based on adrenaline
			-- lowers max_force overtime, the faster the regen, the less is lost

			-- EntityAddComponent( entity_who_picked, "LuaComponent", 
			-- {
			-- 	_tags = "sus_an",
			-- 	script_damage_received = "mods/Noita40K/files/scripts/perks/sus_an.lua",
			-- 	execute_every_n_frame = "-1",
			-- })
		end,
	},
	-- add a secondary layer of unique legion perks that is permananetly unlocked by staying at high adrenaline for long time
	CODEX_MASTERY = {
		icon = "mods/Noita40K/files/classes/_perks/codex_mastery.png",
		name = "$n40_PERK_codex_mastery", desc = "$n40_PERK_codex_mastery_",
	},
	BLACK_RAGE = {
		icon = "mods/Noita40K/files/classes/_perks/black_rage.png",
		name = "$n40_PERK_black_rage", desc = "$n40_PERK_black_rage_",
	},
	CHOGORIAN_SAVAGERY = {
		icon = "mods/Noita40K/files/classes/_perks/chogorian_savagery.png",
		name = "$n40_PERK_chogorian_savagery", desc = "$n40_PERK_chogorian_savagery_",
	},
	EMPERORS_PRAETORIAN = {
		icon = "mods/Noita40K/files/classes/_perks/emperors_praetorian.png",
		name = "$n40_PERK_emperors_praetorian", desc = "$n40_PERK_emperors_praetorian_",
		-- [{ "damage_multipliers", "curse" }] = 0.25,
	},
	FENRISIAN_BLOOD = {
		icon = "mods/Noita40K/files/classes/_perks/fenrisian_blood.png",
		name = "$n40_PERK_fenrisian_blood", desc = "$n40_PERK_fenrisian_blood_",
	},
	NOCTURNE_FORGED = {
		icon = "mods/Noita40K/files/classes/_perks/nocturne_forged.png",
		name = "$n40_PERK_nocturne_forged", desc = "$n40_PERK_nocturne_forged_",
	},
	LIVING_SHADOW = {
		icon = "mods/Noita40K/files/classes/_perks/living_shadow.png",
		name = "$n40_PERK_living_shadow", desc = "$n40_PERK_living_shadow_",
	},
	UNCHAINED = {
		icon = "mods/Noita40K/files/classes/_perks/unchained.png",
		name = "$n40_PERK_unchained", desc = "$n40_PERK_unchained_",
		func = function( hooman, data )
			EntityAddTag( hooman, "unchained" )
		end,
	},
	OMNISSIAHS_BLESSING = {
		icon = "mods/Noita40K/files/classes/_perks/omnissiahs_blessing.png",
		name = "$n40_PERK_omnissiahs_blessing", desc = "$n40_PERK_omnissiahs_blessing_",
		func = function( hooman, data )
			ComponentSetValue2( data.dmg_comp, "fire_damage_ignited_amount", 0 )
			ComponentSetValue2( data.dmg_comp, "fire_probability_of_ignition", 0 )

			n40.add_strength( data.kick_comp )

			n40.add_resistance( data.dmg_comp, "fire", 0.1 )
			n40.add_resistance( data.dmg_comp, "ice", 0.1 )
			n40.add_resistance( data.dmg_comp, "poison", 0.1 )
			n40.add_resistance( data.dmg_comp, "radioactive", 0.1 )

			data.threshold_poison = 999
			data.threshold_radiation = 999
			n40.add_effect( hooman, "PROTECTION_RADIOACTIVITY" )

			pen.magic_storage( hooman, "reactor_load", "value_int",
				pen.magic_storage( hooman, "reactor_load", "value_int", nil, 1 ) - 1 )
			pen.magic_storage( hooman, "reactor_limit", "value_float", 500 )
			pen.magic_storage( hooman, "reactor_target", "value_float", 100 )
			n40.add_vector_ctrl( hooman, "mods/Noita40K/files/misc/ctrl_reactor.lua" )

			return data
		end,
	},
	BREATH_OF_MARS = {
		icon = "mods/Noita40K/files/classes/_perks/breath_of_mars.png",
		name = "$n40_PERK_breath_of_mars", desc = "$n40_PERK_breath_of_mars_",
		func = function( hooman, data )
			data.breathing_immune = true
			n40.add_vector_ctrl( hooman, "mods/Noita40K/files/misc/ctrl_breath.lua" )
			return data
		end,
	},
	MECHADENDRITES = {
		icon = "mods/Noita40K/files/classes/_perks/mechadendrites/icon.png",
		name = "$n40_PERK_mechadendrites", desc = "$n40_PERK_mechadendrites_",
		func = function( hooman, data ) --figure out stains
			pen.magic_storage( hooman, "reactor_load", "value_int",
				pen.magic_storage( hooman, "reactor_load", "value_int", nil, 1 ) + 2 )

			local x, y = EntityGetTransform( hooman )
			local root_id = EntityLoad( "mods/Noita40K/files/classes/_perks/mechadendrites/root.xml", x, y )
			EntityAddChild( hooman, root_id )

			for i = 1,3 do
				local limb_id = EntityLoad( "mods/Noita40K/files/classes/_perks/mechadendrites/limb.xml", x, y )
				EntityAddChild( root_id, limb_id )
			end
		end,
	},
	ETERNAL_VIGILANCE = {
		icon = "mods/Noita40K/files/classes/_perks/eternal_vigilance.png",
		name = "$n40_PERK_eternal_vigilance", desc = "$n40_PERK_eternal_vigilance_",
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

n40.CLASSES[1].sects = {
	{
		name = "$n40_CLASS_1_1", desc = "$n40_CLASS_1_1_",
		-- icon = "",
	},
	{
		name = "$n40_CLASS_1_2", desc = "$n40_CLASS_1_2_",

		guns = { "BOLTER_GENERIC", "BOLTER_RIFLE", "SWORD_CHAIN_LARGE", "MELTA_CUTTER" },
		items = { "GRENADE_HE", "GRENADE_HE" },
		equipment = { "JUMPPACK_L" },
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

n40.CLASSES[1].sects[2].chars = {
	{
		name = "$n40_CLASS_1_2_1", desc = "$n40_CLASS_1_2_1_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_ultramarine.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_ultramarine.png",
		-- author = "Bruham/YourDoom",

		-- guns = {},
		-- items = {},
		--items_add = { "GRENADE_FLASHBANG" },
		-- equipment = {},
		-- equipment_add = {},
		
		skin = "ARMOR_MK7_ULTRA",
		perks_add = { "CODEX_MASTERY" },
		-- perks_remove = {},
		-- func = nil,
	},
	{
		name = "$n40_CLASS_1_2_2", desc = "$n40_CLASS_1_2_2_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_blood_angel.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_blood_angel.png",

		guns = { [1] = "BOLTER_RAPID" },
		skin = "ARMOR_MK7_BLOOD", perks_add = { "BLACK_RAGE" },
	},
	{
		name = "$n40_CLASS_1_2_3", desc = "$n40_CLASS_1_2_3_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_imperial_fist.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_imperial_fist.png",

		--equipment_add = { "SHIELD_S" },
		skin = "ARMOR_MK7_IMPERIAL", perks_add = { "EMPERORS_PRAETORIAN" }, perks_remove = { "SUS_AN" },
	},
	{
		name = "$n40_CLASS_1_2_4", desc = "$n40_CLASS_1_2_4_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_white_scar.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_white_scar.png",

		--equipment = { [1] = "JUMPPACK_L_UPGRADE" },
		skin = "ARMOR_MK7_WHITE", perks_add = { "CHOGORIAN_SAVAGERY" },
	},
	{
		name = "$n40_CLASS_1_2_5", desc = "$n40_CLASS_1_2_5_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_iron_hand.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_iron_hand.png",

		guns = { [1] = "BOLTER_COMBIMELTA" },
		skin = "ARMOR_MK7_IRON", perks_add = { "OMNISSIAHS_BLESSING", "ETERNAL_VIGILANCE" },
	},
	{
		name = "$n40_CLASS_1_2_6", desc = "$n40_CLASS_1_2_6_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_space_wolf.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_space_wolf.png",
		
		--items_add = { "KEG" },
		skin = "ARMOR_MK7_WOLF", perks_add = { "FENRISIAN_BLOOD" },
	},
	{
		name = "$n40_CLASS_1_2_7", desc = "$n40_CLASS_1_2_7_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_salamander.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_salamander.png",
		
		guns = { [1] = "BOLTER_INCENDIARY" },
		--items = { "GRENADE_HEI", "GRENADE_HEI" },
		skin = "ARMOR_MK7_SALAMANDER", perks_add = { "NOCTURNE_FORGED" },
	},
	{
		name = "$n40_CLASS_1_2_8", desc = "$n40_CLASS_1_2_8_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_raven_guard.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_raven_guard.png",
		
		guns = { [1] = "BOLTER_STALKER" },
		--items = { "GRENADE_FLASHBANG", "GRENADE_FLASHBANG" },
		skin = "ARMOR_MK7_RAVEN", perks_add = { "LIVING_SHADOW" },
	},
	{
		name = "$n40_CLASS_1_2_9", desc = "$n40_CLASS_1_2_9_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_dark_angel.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_dark_angel.png",
		
		guns = { [1] = "BOLTER_ARCHEO" },
		--items_add = { "GRENADE_RUPTOR" },
		--equipment_add = { "OSCULANT_DEVICE" },
		skin = "ARMOR_MK7_DARK", perks_add = { "UNCHAINED" },
	},
}

n40.CLASSES[3].sects = {
	{
		name = "$n40_CLASS_3_1", desc = "$n40_CLASS_3_1_",
	},
	{
		name = "$n40_CLASS_3_2", desc = "$n40_CLASS_3_2_",
		
		--items = { "GRENADE_ARC", "GRENADE_ARC" },
		--equipment = { "SERVOSKULL" },
		perks = { "OMNISSIAHS_BLESSING", "BREATH_OF_MARS" }, --"ETERNAL_VIGILANCE",
	},
	{
		name = "$n40_CLASS_3_3", desc = "$n40_CLASS_3_3_",
	},
	{
		name = "$n40_CLASS_3_4", desc = "$n40_CLASS_3_4_",
	},
}

n40.CLASSES[3].sects[2].chars = {
	{
		name = "$n40_CLASS_3_2_1", desc = "$n40_CLASS_3_2_1_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_tech_priest_magos_explorator.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/tech_priest_magos_explorator.png",
		
		guns = { "VOLKITE_PISTOL", "DARKFIRE_RIFLE", "SWORD_SOLLEX", "LASGUN_MITRA" },
		--equipment_add = { "REFRACTOR_FIELD" },
		skin = "ARMOR_SICARIAN", perks_add = { "MECHADENDRITES", "UNCHAINED" },
	},
}

n40.CLASSES[6].sects = {
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

n40.CLASSES[6].sects[1].chars = {
	{
		name = "$n40_CLASS_6_1_1", desc = "$n40_CLASS_6_1_1_",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_tech_priest_magos_explorator.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/tech_priest_magos_explorator.png",
		
		guns = { "BOLTER_PISTOL", "PLASMA_PISTOL", "SWORD_CHAIN", "MELTA_PISTOL" },
		--equipment = { "JUMPPACK_SERAPHIM" },
		skin = "ARMOR_SORORITAS", --perks = { "EMPERORS_DAUGHTER", "COMBAT_ZEALOT" },
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
		{ "ryyst", true }, --some are always at the top of the list
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

n40.MUZZLE_FLASHES = {
	bolter = function( muzzle_x, muzzle_y, r, v_x, v_y, gun_id )
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

	bolter_rifle = function( muzzle_x, muzzle_y, r, v_x, v_y, gun_id )
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

-- 	--Difficulty: Alpha = easily beatable, Beta = fair enough, Gamma = fair enough with a slightly salty taste, Delta = challenging, Epsilon = unfair (assuming you are playing on the custom n40k map [CURRENTLY NOT PRESENT])
-- 	--Toughness: ingame hp
-- 	--Height: pixels/10
-- 	--Mass: lore based in full armour
-- 	--Speed: ingame speed times 10 - you can get it through the Enternal Vigilance
-- 	--PL: 0.25*( 0.08*( f_speed*f_vulner*f_hp ) + f_cqc ) - check get_enemy_threat in black_library
-- 	stats = "Difficulty: epsilon / Toughness: 100 / Height: 1.8 m / Mass: 95 kg / Speed: 12 m/s / PL: 45.3 /",

-- 	--Velho C.: does it has a "wand" tag
-- 	--DPS: get it from Spell Lab's dummy
-- 	--PL: get it from eternal vigilance
-- 	stats = "Fire mode: semi / Velho C.: yes / Cal.: .75 / RPM: 360 / DPS: 300+ / PL: 5.3 /",