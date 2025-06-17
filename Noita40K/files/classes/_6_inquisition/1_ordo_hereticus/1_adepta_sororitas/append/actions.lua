table.insert( actions,
{
	id          = "75_BOLT_HE_MAG_SMALL",
	name 		= "Small .75 Bolt Mag HE",
	description = "5-round standard bolter magazine.",
	sprite 		= "mods/n40ke_bss/files/pics/cards_gfx/75_bolt_he_mag_small.png",
	sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_trigger_unidentified.png",
	related_projectiles	= { "mods/Noita40K/files/entities/projectiles/bolt_75_HE.xml" },
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_requires_flag = "never_fucking_spawn",
	spawn_level                       = "",
	spawn_probability                 = "",
	price             = 50,
	mana              = 25,
	max_uses          = -1,
	custom_xml_file = "mods/n40ke_bss/files/entities/cards/75_bolt_he_mag_small.xml",
	action = function()
		add_projectile( "mods/Noita40K/files/entities/projectiles/bolt_75_HE.xml" )
		c.spread_degrees = c.spread_degrees + 10.0
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
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