dofile_once( "mods/Noita40K/files/_lib.lua" )

function n40.muzzle_flash( muzzle_x, muzzle_y, r, s_x, s_y, gun_id, card_id, action )
	-- use action.muzzle_flash to apply projectile-based flash mutation
	local v_x, v_y = pen.get_speed( EntityGetRootEntity( gun_id ))
	local flash_func = n40.MUZZLE_FLASHES[ EntityGetName( gun_id )]
	return ( flash_func or n40.MUZZLE_FLASHES.bolter )( muzzle_x, muzzle_y, r, v_x, v_y, gun_id )
end

table.insert( actions,
{
	id = "N40_BOLT_998_HE_M",
	name = "$n40_MAG_bolt_998_he_m", description = "$n40_MAG_bolt_998_he_m_",
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
		pen.gunshot( n40.muzzle_flash )
		c.spread_degrees = c.spread_degrees + 10.0
	end,
})

table.insert( actions,
{
	id = "N40_BOLT_50MM_APHE_S",
	name = "$n40_MAG_bolt_50mm_aphe_s", description = "$n40_MAG_bolt_50mm_aphe_s_",
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
		pen.gunshot( n40.muzzle_flash )
		c.spread_degrees = c.spread_degrees + 30.0
		c.damage_critical_chance = c.damage_critical_chance + 20
	end,
})

function n40.beamshot( beam_x, beam_y, r, s_x, s_y, gun_id, card_id, action )
	local data = action.beam
	data.shooter = EntityGetRootEntity( gun_id )
	data.card = card_id
	data.gun = gun_id
	data.uid = gun_id
	
	local beam_path = pen.magic_storage( gun_id, "beam", "value_string" )
	local length = pen.magic_storage( gun_id, "beam_length", "value_float" )
	
	pen.c.beam_ids = pen.c.beam_ids or {}
	pen.child_play( pen.c.beam_ids[ gun_id ], function( parent, child, i )
		pen.t.loop( EntityGetComponentIncludingDisabled( child, "LaserEmitterComponent" ), function( i, comp )
			ComponentSetValue2( comp, "is_emitting", true )
		end)
	end)
	
	pen.life_support( pen.c.beam_ids, gun_id, beam_path, beam_x, beam_y, r )
	pen.raytrace_entities( beam_x, beam_y, r, length, function( hit_id, hit_x, hit_y, dmg_mult, k )
		if( pen.vld( data.f )) then data.f( hit_id, hit_x, hit_y ) end
		EntityInflictDamage( hit_id, dmg_mult*( data.dmg or 0.02 ), data.dmg_type or "DAMAGE_MATERIAL",
			data.dmg_msg or "beam", data.dmg_effect or "NORMAL", 0, 0, hooman, hit_x, hit_y, 0 )
	end, data )
end

table.insert( actions,
{
	id = "N40_CANISTER_S_PYRUM",
	name = "$n40_MAG_canister_s_pyrum", description = "$n40_MAG_canister_s_pyrum_",
	sprite = "mods/Noita40K/files/items/mags/canister_S_pyrum.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_OTHER,
	price = 200, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	projectiles = {{ r = 1.5, h = 7 }},
	--pyrum decreases length and increases damage; changes color to be more yellow
	beam = { dmg = 0.6, dmg_type = "DAMAGE_MATERIAL", dmg_msg = "melta", dmg_effect = "NORMAL",
		always_action = true, point_action = function( data, point_x, point_y, k, is_final )
			if( k%5 ~= 0 and not( is_final )) then return end
			pen.c.beam_eff_ids = pen.c.beam_eff_ids or {}
			local effect = "mods/Noita40K/files/items/rounds/effect_pyrum_small.xml"
			pen.life_support( pen.c.beam_eff_ids, data.gun..k, effect, point_x, point_y )
		end,
	},
	custom_xml_file = "mods/Noita40K/files/items/mags/canister_S_pyrum.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/beams/pyrum", true, "items/overheat_start" },

	action = function() pen.gunshot( n40.beamshot ) end,
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

function n40.init_blade_action( id, data )
	return {
		id = id, name = data.name, description = data.desc,
		sprite = data.pic, custom_xml_file = data.card, price = data.cost,
		mod = "Noita40K", type = ACTION_TYPE_OTHER, mana = 0, max_uses = -1,
		spawn_requires_flag = "never_spawn_this_action", action = function() end,
	}
end

table.insert( actions, n40.init_blade_action( "N40_BLADE_ADAMANTIUM_TEETH", {
	cost = 50,
	name = "$n40_MAG_blade_adamantium_teeth",
	desc = "$n40_MAG_blade_adamantium_teeth_",
	pic = "mods/Noita40K/files/items/mags/blade_adamantium_teeth.png",
	card = "mods/Noita40K/files/items/mags/blade_adamantium_teeth.xml",
}))