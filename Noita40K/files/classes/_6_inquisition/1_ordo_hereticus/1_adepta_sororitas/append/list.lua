--adding skin to the specific class
table.insert( class_info[15].skins,
{
	author = "Bruham/YourDoom",
	name = "AS_Seraphim",
	unlocked = true,
	icon = "mods/n40ke_bss/files/pics/gui_gfx/icon_class_as_seraphim.png",
	main = "mods/n40ke_bss/files/pics/gui_gfx/as_seraphim.png",
	custom_desc = "Dash through the bloody fog of your enemies in the form of a living angel, bringing death and fire like divine wrath. Decimate the wicked, defeat the unworthy, and execute the profane. Dominus Et Imperator Noster Sic Fieri Jubet.",
	guns = { --ids from the gun_info, full paths to main .xml would work too
		"SERAPHIM_BOLT_PISTOL",
		"SERAPHIM_PLASMA_PISTOL",
		"SERAPHIM_CHAINSWORD",
		"SERAPHIM_INFERNO_PISTOL",
	},
	items = {
		"mods/n40ke_bss/files/entities/items/seraphim_bolt_pistol_offhand_item.xml",
		"mods/Noita40K/files/entities/items/grenade_he.xml",
	},
	perks = { --[[ Do we completely overwrite the default class perks?  ]]true, {
		{ "UNCHAINED", false, },
		{ "AS_POWER_ARMOUR", --[[ Are we using non-vanilla perk style? ]]true, --[[ Is it present in the main mod? ]]true },
		{ "EMPERORS_DAUGHTER", true, true },
	}},
	custom_code = nil, --Any code you wanna run after all the stuff was done goes here
	custom_numbers = nil, --If your character needs custom magic numbers - attach the path here
})

--adding guns
table.insert( gun_info,
{
	id = "SERAPHIM_BOLT_PISTOL",
	name = "Bolt Pistol",
	unlocked = HasFlagPersistent( "triumph_as_seraphim" ) and true or nil,
	icon = "mods/n40ke_bss/files/pics/gui_gfx/icon_gun_seraphim_bolt_pistol.png",
	pic = "mods/n40ke_bss/files/pics/guns_gfx/seraphim_bolt_pistol.png",
	ammo = { "mods/n40ke_bss/files/pics/cards_gfx/75_bolt_he_mag_small.png" },
	path = "mods/n40ke_bss/files/entities/guns/seraphim_bolt_pistol.xml",
})

table.insert( gun_info,
{
	id = "SERAPHIM_PLASMA_PISTOL",
	name = "Plasma Pistol",
	unlocked = HasFlagPersistent( "triumph_as_seraphim" ) and true or nil,
	icon = "mods/n40ke_bss/files/pics/gui_gfx/icon_gun_seraphim_plasma_pistol.png",
	pic = "mods/n40ke_bss/files/pics/guns_gfx/seraphim_plasma_pistol.png",
	ammo = { "mods/n40ke_bss/files/pics/cards_gfx/hydrogen_fuel_cell_small.png" },
	path = "mods/n40ke_bss/files/entities/guns/seraphim_plasma_pistol.xml",
})

table.insert( gun_info,
{
	id = "SERAPHIM_CHAINSWORD",
	name = "Chainsword",
	unlocked = HasFlagPersistent( "triumph_as_seraphim" ) and true or nil,
	icon = "mods/n40ke_bss/files/pics/gui_gfx/icon_gun_seraphim_chainsword.png",
	pic = "mods/n40ke_bss/files/pics/guns_gfx/seraphim_chainsword_pic.png",
	ammo = { "mods/Noita40K/files/pics/cards_gfx/adamantium_carbon_teeth.png" },
	path = "mods/n40ke_bss/files/entities/guns/seraphim_chainsword.xml",
})

table.insert( gun_info,
{
	id = "SERAPHIM_INFERNO_PISTOL",
	name = "Inferno Pistol",
	unlocked = HasFlagPersistent( "triumph_as_seraphim" ) and true or nil,
	icon = "mods/n40ke_bss/files/pics/gui_gfx/icon_gun_seraphim_inferno_pistol.png",
	pic = "mods/n40ke_bss/files/pics/guns_gfx/seraphim_inferno_pistol.png",
	ammo = { "mods/Noita40K/files/pics/cards_gfx/pyrum_petrol_canister_small.png" },
	path = "mods/n40ke_bss/files/entities/guns/seraphim_inferno_pistol.xml",
})

--adding perk ids to the pool for custom perk gui to use
table.insert( organ_list, { "AS_POWER_ARMOUR", true, })
table.insert( organ_list, { "EMPERORS_DAUGHTER", true, })

--adding character to the codex
table.insert( codex_structure[2].entries,
{
	icon = "mods/n40ke_bss/files/pics/gui_gfx/icon_class_as_seraphim.png",
	unlocked = true,
	name = "[Adepta Sororitas Seraphim]",
	
	--Difficulty: Alpha = easily beatable, Beta = fair enough, Gamma = fair enough with a slightly salty taste, Delta = challenging, Epsilon = unfair (assuming you are playing on the custom n40k map [CURRENTLY NOT PRESENT])
	--Toughness: ingame hp
	--Height: pixels/10
	--Mass: lore based in full armour
	--Speed: ingame speed times 10 - you can get it through the Enternal Vigilance
	--PL: 0.25*( 0.08*( f_speed*f_vulner*f_hp ) + f_cqc ) - check get_enemy_threat in black_library
	stats = "Difficulty: epsilon / Toughness: 100 / Height: 1.8 m / Mass: 95 kg / Speed: 12 m/s / PL: 45.3 /",
	
	image = { "mods/n40ke_bss/files/pics/ui_anims/seraphim_idle/", --[[ Frame count ]]6, --[[ Delay between frames (is in frames) ]]12 },
	desc = "Amongst the highly devoted warriors of the Orders Militant there are those whose faith burns so brightly that it appears as if the Emperor Himself guides their actions. These angelic warriors are known as Seraphim, and are exclusively trained to use jumppacks and to master the co-ordination, dexterity and control required to wield two firearms at once. They strike like avenging angels, descending into the thickest of fighting upon wings of fire, their Bolt Pistols spitting death at their foes in a devastating dance of fury and faith.",
})

--adding guns to the codex
table.insert( codex_structure[3].entries,
{
	info = get_gun_with_id( "SERAPHIM_BOLT_PISTOL" ),
	unlocked = true,
	name = "[Bolt Pistol]",
	
	--Velho C.: does it has a "wand" tag
	--DPS: get it from Spell Lab's dummy
	--PL: get it from eternal vigilance
	stats = "Fire mode: semi / Velho C.: yes / Cal.: .75 / RPM: 360 / DPS: 300+ / PL: 5.3 /",
	
	desc = "An extremely compact semi-automatic variant of the Bolter, designed for dual wielding. Requires a special training and inhuman strength to be successfully utilized.",
})

table.insert( codex_structure[3].entries,
{
	info = get_gun_with_id( "SERAPHIM_PLASMA_PISTOL" ),
	unlocked = true,
	name = "[Plasma Pistol]",
	stats = "Fire mode: charge / Type: plasma / Velho C.: no / Volitile: yes / DPS: varied / PL: 32.5 /",
	desc = "Plasma weapons make use of a micro-fusion nuclear reaction to superheat a cartridge of gas into the state of matter known as plasma and then release it in a projectile-like cloud. Such a volitile process is incredibly hard to control however, so the gun tends to explode right in the hands of its operator upon overheating. This version has been modified to increase the amount of expelled plasma, though at the cost of nullifying the AP capabilities. Hold [LMB] to start the charging cycle.",
})

table.insert( codex_structure[3].entries,
{
	info = get_gun_with_id( "SERAPHIM_CHAINSWORD" ),
	unlocked = true,
	name = "[Chainsword]",
	stats = "Fire mode: melee / Type: constant / Velho C.: no / DPS: 450+ / PL: 1.1 /",
	desc = "A standard human chainsword of appropriate size and balancing.",
})

table.insert( codex_structure[3].entries,
{
	info = get_gun_with_id( "SERAPHIM_INFERNO_PISTOL" ),
	unlocked = true,
	name = "[Inferno Pistol]",
	stats = "Fire mode: beam / Type: melta / Velho C.: no / Range: 40 / DPS: 4K+ / PL: 10.8 /",
	desc = "A drastically downscaled version of the Meltagun, still capable of vaporization foes in split second but at a cost of heavily decreased thermal capacity.",
})

--adding perks to the codex
table.insert( codex_structure[4].entries,
{
	info = get_perk_with_actual_id( "AS_POWER_ARMOUR", true ),
	unlocked = true,
	name = "[AS Seraphim Power Armour]",
	desc = "This lighter power armour provides excellent protection and increased strength with little to no reduction in movement speed or agility, despite the lack of direct nervous system integration. Combined with the wing-shaped jumppack, it gives the wearer an angelic profile, striking fear in the corrupt and strengthening the morale of the devout. Press [DOWN]+[USE] for directed dash or just hold [DOWN] to enter the glide mode.",
})

table.insert( codex_structure[4].entries,
{
	info = get_perk_with_actual_id( "EMPERORS_DAUGHTER", true ),
	unlocked = true,
	name = "[Emperor's Daughter]",
	desc = "Purity of your faith and valiancy of your spirit deserve His attention - a sensation of divine protection propagates throughout your entire body.",
})