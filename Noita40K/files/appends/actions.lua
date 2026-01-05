dofile_once( "mods/Noita40K/files/_lib.lua" )

function n40.muzzle_flash( muzzle_x, muzzle_y, r, s_x, s_y, gun_id, card_id, action )
	-- use action.muzzle_flash to apply projectile-based flash mutation
	local v_x, v_y = pen.get_speed( EntityGetRootEntity( gun_id ))
	local flash_func = n40.MUZZLE_FLASHES[ EntityGetName( gun_id )]
	return ( flash_func or n40.MUZZLE_FLASHES.bolter )( muzzle_x, muzzle_y, r, v_x, v_y, gun_id )
end

table.insert( actions,
{
	id = "N40_BOLT_75_HE_S",
	name = "$n40_MAG_bolt_75_he_s", description = "$n40_MAG_bolt_75_he_s_",
	sprite = "mods/Noita40K/files/items/mags/bolt_75_he_S.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_PROJECTILE,
	price = 50, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	shells = { "mods/Noita40K/files/items/rounds/bolt_998c.xml" },
	projectiles = {{ p = "mods/Noita40K/files/items/rounds/bolt_75_he.xml", r = 0.75, h = 0.25 }},
	custom_xml_file = "mods/Noita40K/files/items/mags/bolt_75_he_S.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/guns/bolt_998" },
	
	action = function()
		pen.gunshot( n40.muzzle_flash )
		c.spread_degrees = c.spread_degrees + 5.0
	end,
})

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
	id = "N40_BOLT_998_HEI_M",
	name = "$n40_MAG_bolt_998_hei_m", description = "$n40_MAG_bolt_998_hei_m_",
	sprite = "mods/Noita40K/files/items/mags/bolt_998_hei_M.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_PROJECTILE,
	price = 350, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	shells = { "mods/Noita40K/files/items/rounds/bolt_998c.xml" },
	projectiles = {{ p = "mods/Noita40K/files/items/rounds/bolt_998_he.xml", r = 3, h = 1 }},
	custom_xml_file = "mods/Noita40K/files/items/mags/bolt_998_hei_M.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/guns/bolt_998" },
	
	action = function()
		pen.gunshot( n40.muzzle_flash )
		c.spread_degrees = c.spread_degrees + 10.0
	end,
})

table.insert( actions,
{
	id = "N40_BOLT_998_STASIS_M",
	name = "$n40_MAG_bolt_998_stasis_m", description = "$n40_MAG_bolt_998_stasis_m_",
	sprite = "mods/Noita40K/files/items/mags/bolt_998_stasis_M.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_PROJECTILE,
	price = 400, mana = 0, max_uses = -1,
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
	id = "N40_BOLT_998L_APDS_S",
	name = "$n40_MAG_bolt_998l_apds_s", description = "$n40_MAG_bolt_998l_apds_s_",
	sprite = "mods/Noita40K/files/items/mags/bolt_998L_apds_S.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_PROJECTILE,
	price = 350, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	shells = { "mods/Noita40K/files/items/rounds/bolt_998Lc.xml" },
	projectiles = {{ p = "mods/Noita40K/files/items/rounds/bolt_998L_apds.xml", r = 4.5, h = 7 }},
	custom_xml_file = "mods/Noita40K/files/items/mags/bolt_998L_apds_S.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/guns/bolt_998L" },
	
	action = function()
		pen.gunshot( n40.muzzle_flash )
		c.spread_degrees = c.spread_degrees + 15.0
		c.damage_critical_chance = c.damage_critical_chance + 10
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
	data.card, data.gun, data.uid = card_id, gun_id, gun_id
	local beam_path = pen.magic_storage( gun_id, "beam", "value_string" )
	local length = pen.magic_storage( gun_id, "beam_length", "value_float" )
	
	pen.c.beam_ids = pen.c.beam_ids or {}
	pen.child_play( pen.c.beam_ids[ gun_id ], function( parent, child, i )
		pen.t.loop( EntityGetComponentIncludingDisabled( child, "LaserEmitterComponent" ), function( i, comp )
			ComponentSetValue2( comp, "is_emitting", true )
		end)
	end)
	
	pen.c.beam_sfxes = pen.c.beam_sfxes or {}
	local beam_id, is_new = pen.life_support( pen.c.beam_ids, gun_id, beam_path, beam_x, beam_y, r )
	if( is_new ) then
		pen.c.beam_sfxes[ beam_id ] = true
	elseif( pen.c.beam_sfxes[ beam_id ]) then
		pen.c.beam_sfxes[ beam_id ] = nil
		pen.play_sound({ action.sfx[1], action.sfx[2].."/create" }, beam_x, beam_y )
		if( pen.vld( data.shake, true )) then GameScreenshake( data.shake, beam_x, beam_y ) end
	end
	
	local hit_action = function( hit_id, hit_x, hit_y, dmg_mult, k )
		if( pen.vld( data.f )) then data.f( data, hit_id, hit_x, hit_y ) end
		EntityInflictDamage( hit_id, dmg_mult*( data.dmg or 0.02 ), data.dmg_type or "DAMAGE_MATERIAL",
			data.dmg_msg or "beam", data.dmg_effect or "NORMAL", 0, 0, hooman, hit_x, hit_y, 0 )
	end

	pen.c.beam_eff_ids = pen.c.beam_eff_ids or {}
	if( pen.vld( data.raytrace )) then
		return data.raytrace( beam_x, beam_y, r, length, hit_action, data ) end
	local out = pen.raytrace_entities( beam_x, beam_y, r, length, hit_action, data )
	if( not( data.will_stop )) then return end

	local hit_id, hit_x, hit_y, dmg_mult, k = unpack( out )
	local is_hitting = pen.vld( hit_id, true )
	if( is_hitting ) then hit_action( hit_id, hit_x, hit_y, dmg_mult, k ) end
	
	local real_length = math.sqrt(( beam_x - hit_x )^2 + ( beam_y - hit_y )^2 )
	pen.child_play( pen.c.beam_ids[ gun_id ], function( parent, child, i )
		pen.t.loop( EntityGetComponentIncludingDisabled( child, "LaserEmitterComponent" ), function( i, comp )
			ComponentObjectSetValue2( comp, "laser", "max_length", is_hitting and real_length or length )
			ComponentObjectSetValue2( comp, "laser", "beam_particle_fade", is_hitting and 0 or 1 )
		end)
	end)
end

table.insert( actions,
{
	id = "N40_CANISTER_S_PYRUM",
	name = "$n40_MAG_canister_s_pyrum", description = "$n40_MAG_canister_s_pyrum_",
	sprite = "mods/Noita40K/files/items/mags/canister_S_pyrum.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_OTHER,
	price = 100, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	projectiles = {{ r = 0.5, h = 4 }},
	--pyrum decreases length and increases damage; changes color to be more yellow
	beam = { dmg = 0.3, dmg_type = "DAMAGE_MATERIAL", dmg_msg = "melta", dmg_effect = "NORMAL",
		always_action = true, will_choke = true, will_stop = true, do_liquids = true,
		point_action = function( data, point_x, point_y, k, is_final )
			if( k%5 ~= 0 and not( is_final )) then return end
			local effect = "mods/Noita40K/files/items/rounds/effect_pyrum_small.xml"
			pen.life_support( pen.c.beam_eff_ids, data.gun..k, effect, point_x, point_y )
		end, f = function( data, hit_id, hit_x, hit_y )
			pen.play_sound({ "mods/Noita40K/files/40K.bank", "effects/burst" }, hit_x, hit_y )
		end,
	},
	custom_xml_file = "mods/Noita40K/files/items/mags/canister_S_pyrum.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/beams/pyrum", true, "items/overheat_start" },

	action = function() pen.gunshot( n40.beamshot ) end,
})

table.insert( actions,
{
	id = "N40_CANISTER_M_PYRUM",
	name = "$n40_MAG_canister_m_pyrum", description = "$n40_MAG_canister_m_pyrum_",
	sprite = "mods/Noita40K/files/items/mags/canister_M_pyrum.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_OTHER,
	price = 200, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	projectiles = {{ r = 1.5, h = 7 }},
	--pyrum decreases length and increases damage; changes color to be more yellow
	beam = { dmg = 0.6, dmg_type = "DAMAGE_MATERIAL", dmg_msg = "melta", dmg_effect = "NORMAL",
		always_action = true,
		point_action = function( data, point_x, point_y, k, is_final )
			if( k%5 ~= 0 and not( is_final )) then return end
			local effect = "mods/Noita40K/files/items/rounds/effect_pyrum_medium.xml"
			pen.life_support( pen.c.beam_eff_ids, data.gun..k, effect, point_x, point_y )
		end, f = function( data, hit_id, hit_x, hit_y )
			pen.play_sound({ "mods/Noita40K/files/40K.bank", "effects/burst" }, hit_x, hit_y )
		end,
	},
	custom_xml_file = "mods/Noita40K/files/items/mags/canister_M_pyrum.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/beams/pyrum", true, "items/overheat_start" },

	action = function() pen.gunshot( n40.beamshot ) end,
})

table.insert( actions,
{
	id = "N40_PACK_S_HIGH_DENSITY",
	name = "$n40_MAG_pack_s_high_density", description = "$n40_MAG_pack_s_high_density_",
	sprite = "mods/Noita40K/files/items/mags/pack_S_high_density.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_OTHER,
	price = 250, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	projectiles = {{ r = 0.5, h = 25 }}, shake = 1,
	--high density decreases the size of effect entity and increases damage; changes color to be more white
	beam = { dmg = 0.5, dmg_type = "DAMAGE_EXPLOSION", dmg_msg = "volkite", dmg_effect = "NORMAL",
		will_choke = true, will_stop = true, do_liquids = true, shake = 2,
		point_action = function( data, point_x, point_y, k, is_final )
			if( not( is_final )) then return end --make sure this spawns both as final and as hit
			local effect = "mods/Noita40K/files/items/rounds/effect_volkite_small.xml"
			pen.life_support( pen.c.beam_eff_ids, data.gun..k, effect, point_x, point_y )

			-- local effect_id = get_custom_effect( actual_deadman, "fancy_burning" )
			-- if( effect_id ~= nil ) then
			-- 	local effect_comp = EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent" )
			-- 	ComponentSetValue2( effect_comp, "frames", ComponentGetValue2( effect_comp, "frames" ) + 5 )
			-- else
			-- 	LoadGameEffectEntityTo( actual_deadman, "mods/Noita40K/files/entities/status_effects/effect_fancy_burning.xml" )
			-- end
		end, f = function( data, hit_id, hit_x, hit_y ) --deal damage to armor instead
			pen.play_sound({ "mods/Noita40K/files/40K.bank", "effects/burst" }, hit_x, hit_y )
			if( EntityHasTag( hit_id, "armored" )) then data.dmg = data.dmg/4; return end
			ComponentSetValue2( GetGameEffectLoadTo( hit_id, "EXPLODING_CORPSE", true ), "frames", 2 )
		end,
	},
	custom_xml_file = "mods/Noita40K/files/items/mags/pack_S_high_density.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/beams/volkite", true, "items/overheat_start" },

	action = function() pen.gunshot( n40.beamshot ) end,
})

table.insert( actions,
{
	id = "N40_PACK_M_WARPBORN_PHOTON",
	name = "$n40_MAG_pack_m_warpborn_photon", description = "$n40_MAG_pack_m_warpborn_photon_",
	sprite = "mods/Noita40K/files/items/mags/pack_M_warpborn_photon.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_OTHER,
	price = 600, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	projectiles = {{ r = 5, h = 1000 }}, shake = 5,
	--sometimes ammo is not being deducted, must always take exactly two shots
	--fully overrides beam to be darkfire and explodes on overheat if the gun is not designed for it
	beam = { dmg = 1, dmg_type = "DAMAGE_MATERIAL", dmg_msg = "darkfire", dmg_effect = "BLOOD_EXPLOSION",
		always_action = true, always_trace = true,
		point_action = function( data, point_x, point_y, k, is_final )
			EntityLoad( "mods/Noita40K/files/items/rounds/effect_darkfire_eater.xml", point_x, point_y )
			if( k%2 == 1 ) then return end
			EntityLoad( "mods/Noita40K/files/items/rounds/effect_darkfire_corruptor.xml", point_x, point_y )
		end, f = function( data, hit_id, hit_x, hit_y )
			-- local damage_comp = EntityGetFirstComponentIncludingDisabled( deadman, "DamageModelComponent" )
			-- if( not( EntityHasTag( deadman, "corrupted" )) and EntityGetIsAlive( deadman ) and damage_comp ~= nil and is_sentient( deadman )) then
			-- 	EntityAddTag( deadman, "corrupted" )
			-- 	LoadGameEffectEntityTo( deadman, "mods/Noita40K/files/entities/status_effects/effect_warpfire.xml" )
			-- end
		end,
	},
	custom_xml_file = "mods/Noita40K/files/items/mags/pack_M_warpborn_photon.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/beams/darkfire", false, "items/overheat_start" },

	action = function() pen.gunshot( n40.beamshot ) end,
})

table.insert( actions,
{
	id = "N40_BATTERY_L_MULTI",
	name = "$n40_MAG_battery_l_multi", description = "$n40_MAG_battery_l_multi_",
	sprite = "mods/Noita40K/files/items/mags/battery_L_multi.png",
	
	mod = "Noita40K",
	type = ACTION_TYPE_OTHER,
	price = 300, mana = 0, max_uses = -1,
	spawn_requires_flag = "never_spawn_this_action",
	projectiles = {{ r = 0.1, h = 5 }},
	--functions as normal battery except with very high capacity and enables specialty equipment to work
	beam = { dmg = 0.04, dmg_type = "DAMAGE_PROJECTILE", dmg_msg = "lasfire", dmg_effect = "NORMAL",
		always_action = true, will_stop = true, do_liquids = true,
		point_action = function( data, point_x, point_y, k, is_final )
			if( not( is_final )) then return end
			local effect = "mods/Noita40K/files/items/rounds/effect_lasgun_large.xml"
			pen.life_support( pen.c.beam_eff_ids, data.gun..k, effect, point_x, point_y )
		end, f = function( data, hit_id, hit_x, hit_y )
			pen.play_sound({ "mods/Noita40K/files/40K.bank", "effects/burst" }, hit_x, hit_y )
			if( not( EntityHasTag( hit_id, "armored" ))) then return end
			data.dmg_type = "DAMAGE_PHYSICS_HIT"
			data.dmg_effect = "NONE"
			data.dmg = 10*data.dmg
		end, raytrace = function( beam_x, beam_y, r, length, hit_action, data )
			pen.child_play( pen.c.beam_ids[ data.gun ], function( parent, child, i )
				local storage = pen.magic_storage( child, "angle" )
				local angle = ComponentGetValue2( storage, "value_int" ) + 10
				if( angle >= 360 ) then angle = 0 end
				ComponentSetValue2( storage, "value_int", angle )

				local max_angle = 0.265
				angle = max_angle*math.cos( math.rad( angle ))
				pen.t.loop( EntityGetComponentIncludingDisabled( child, "LaserEmitterComponent" ), function( i, comp )
					ComponentSetValue2( comp, "laser_angle_add_rad", angle )
				end)

				local out = pen.raytrace_entities( beam_x, beam_y, r + angle, length, hit_action, data )
				if( not( data.will_stop )) then return end

				local hit_id, hit_x, hit_y, dmg_mult, k = unpack( out )
				local is_hitting = pen.vld( hit_id, true )
				if( is_hitting ) then hit_action( hit_id, hit_x, hit_y, dmg_mult, k ) end
				
				local real_length = math.sqrt(( beam_x - hit_x )^2 + ( beam_y - hit_y )^2 )
				pen.t.loop( EntityGetComponentIncludingDisabled( child, "LaserEmitterComponent" ), function( i, comp )
					ComponentObjectSetValue2( comp, "laser", "max_length", is_hitting and real_length or length )
					ComponentObjectSetValue2( comp, "laser", "beam_particle_fade", is_hitting and 0 or 1 )
				end)
			end)
		end,
	},
	custom_xml_file = "mods/Noita40K/files/items/mags/battery_L_multi.xml",
	sfx = { "mods/Noita40K/files/40K.bank", "items/beams/mitra", true, "items/overheat_start" },
	
	action = function() pen.gunshot( n40.beamshot ) end,
})

--[[
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
	id          = "HYDROGEN_FUEL_CELL_SMALL",
	name 		= "Small Cryo-Sealed Hydrogen Fuel Cell",
	description = "An armoured flask, containing highly unstable hydrogen-based concoction.",
	sprite 		= "mods/n40ke_bss/files/pics/cards_gfx/hydrogen_fuel_cell_small.png",
	sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_trigger_unidentified.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 50,
	mana              = 4,
	max_uses          = -1,
	custom_xml_file = "mods/n40ke_bss/files/entities/cards/hydrogen_fuel_cell_small.xml",
	action = function()
		beam_controller( GetUpdatedEntityID(), "plasma_state", 3 ) --check it in the black_library
	end,
})
]]

function n40.init_empty_action( id, data )
	return {
		id = id, name = data.name, description = data.desc,
		sprite = data.pic, custom_xml_file = data.card, price = data.cost,
		mod = "Noita40K", type = ACTION_TYPE_OTHER, mana = 0, max_uses = -1,
		spawn_requires_flag = "never_spawn_this_action", action = function() end,
	}
end

table.insert( actions, n40.init_empty_action( "N40_BLADE_ADAMANTIUM_TEETH", {
	cost = 50,
	name = "$n40_MAG_blade_adamantium_teeth",
	desc = "$n40_MAG_blade_adamantium_teeth_",
	pic = "mods/Noita40K/files/items/mags/blade_adamantium_teeth.png",
	card = "mods/Noita40K/files/items/mags/blade_adamantium_teeth.xml",
}))

table.insert( actions, n40.init_empty_action( "N40_CRYSTAL_S_SOLLEX", {
	cost = 10,
	name = "$n40_MAG_crystal_s_sollex",
	desc = "$n40_MAG_crystal_s_sollex_",
	pic = "mods/Noita40K/files/items/mags/crystal_S_sollex.png",
	card = "mods/Noita40K/files/items/mags/crystal_S_sollex.xml",
}))