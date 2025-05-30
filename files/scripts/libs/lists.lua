dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

--classes
class_info =
{
	{
		class_name = "Space_Marine",
		class_desc = "Delve deep into the tainted caves wearing blessed MKVII Power Armour with a trusty Boltgun in your hand and slaughter everything that moves under the corrupted Moon. Purge the heresy, wash the unclean and stain the ceramite with warm blood of the unknown creatures. In Dedicato Imperatum Ultra Articulo Mortis.",
		unlock_case = "No heretics are allowed.",
		default_guns = 
		{
			"BOLTER",
			"BOLT_CARBINE",
			"CHAINSWORD",
			"MELTACUTTER",
		},
		default_items = {
			"mods/Noita40K/files/entities/items/grenade_he.xml",
			"mods/Noita40K/files/entities/items/grenade_he.xml",
		},
		default_perks = 
		{
			{ "UNCHAINED", false, },
			{ "SECOND_HEART", true, },
			{ "OSSMODULA", true, },
			{ "BISCOPEA", true, },
			{ "LARRAMAN", true, },
			{ "OCCULOBE", true, },
			{ "SUS_AN", true, },
		},
		visual = 
		{
			{ "UNCHAINED", },
			{ "SECOND_HEART", },
			{ "OSSMODULA", },
			{ "BISCOPEA", },
			{ "LARRAMAN", },
			{ "OCCULOBE", },
			{ "SUS_AN", },
		},
		default_skin = 5,
		skins = 
		{
			{
				author = "Bruham/YourDoom",
				name = "Space_Wolf",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_space_wolf.png",
				main = "mods/Noita40K/files/pics/codex_gfx/space_marine_space_wolf.png",
				custom_desc = "Nurtured among ones of the most hostile predators known to mankind and tempered in deadly permafrost of their homeworld, the Space Wolves were one of the most savage Legiones Astartes in the Imperium. Wild and glorious, brute and perseptive, loyal and horrifying, they are ready to decimate anyone who dares to offend their King or even thinks of foul tricks on the battlefield. / For Russ and the All-father! /",
				guns = nil,
				items = {
					"mods/Noita40K/files/entities/items/tactical_keg.xml",
					"mods/Noita40K/files/entities/items/grenade_he.xml",
					"mods/Noita40K/files/entities/items/grenade_he.xml",
				},
				perks = { false, {
					{ "MKVII_SPACE_WOLF", true, },
					{ "FENRISIAN_BLOOD", true, },
				}},
				custom_code = nil,
				custom_numbers = nil,
			},
			{
				author = "Bruham/YourDoom",
				name = "Iron_Hand",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_iron_hand.png",
				main = "mods/Noita40K/files/pics/codex_gfx/space_marine_iron_hand.png",
				custom_desc = "The Iron Hands are ultimately defined by their hatred of weakness of any kind, a hatred that extends to their own bodies, for they hold that all organic limbs are ultimately frail and subject to the weaknesses brought on by age and disease, compulsively driven to augment their flesh. In battle, they utilise their anger and hatred, identifying enemies' vulnerabilities and exploiting them ruthlessly. / The Flesh is Weak! /",
				guns = { 
					"WHITE_BOLTER",
					"BOLT_CARBINE",
					"CHAINSWORD",
					"MELTACUTTER",
				},
				items = nil,
				perks = { false, {
					{ "MKVII_IRON_HAND", true, },
					{ "OMNISSIAHS_BLESSING", true, },
					{ "ETERNAL_VIGILANCE", true, },
				}},
				custom_code = nil,
				custom_numbers = "mods/Noita40K/files/append/magic_numbers_eternal_vigilance.xml",
			},
			{
				author = "Bruham/YourDoom",
				name = "Salamander",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_salamander.png",
				main = "mods/Noita40K/files/pics/codex_gfx/space_marine_salamander.png",
				custom_desc = "Craftsmen and artificers, the Salamanders know the true price of every creation be it a machine or a living thing. Such an invaluable knowledge results in the believe that their most important duty is to protect the innocent lives whenever and wherever possible. They are also fascinated by the fire in all of its hypostases, seeing it as the greatest tool and utilizing as the most powerful weapon. / Into the fires of battle, unto the Anvil of War! /",
				guns = { 
					"GREEN_BOLTER",
					"BOLT_CARBINE",
					"CHAINSWORD",
					"MELTACUTTER",
				},
				items = {
					"mods/Noita40K/files/entities/items/grenade_he.xml",
					"mods/Noita40K/files/entities/items/grenade_incendiary.xml",
				},
				perks = { false, {
					{ "MKVII_SALAMANDER", true, },
					{ "NOCTURNE_FORGED", true, },
				}},
				custom_code = nil,
				custom_numbers = nil,
			},
			{
				author = "Bruham/YourDoom",
				name = "Imperial_Fist",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_imperial_fist.png",
				main = "mods/Noita40K/files/pics/codex_gfx/space_marine_imperial_fist.png",
				custom_desc = "The Imperial Fists were one of the most valiant of all Legions, held as paragons of all the principles to which a Space Marine is heir. They stand as the steadfast defenders of the Imperium, crashing adversary armies for millenias. Indeed, if the Fists have a fault, it is that they continue to strive when others would yield or withdraw, but this comes only at a steep cost in lives. / Primarch, to your glory and the glory of Him on Terra! /",
				guns = nil,
				items = {
					"mods/Noita40K/files/entities/items/combat_shield_item.xml",
					"mods/Noita40K/files/entities/items/grenade_he.xml",
					"mods/Noita40K/files/entities/items/grenade_he.xml",
				},
				perks = { true, {
					{ "UNCHAINED", false, },
					{ "SECOND_HEART", true, },
					{ "OSSMODULA", true, },
					{ "BISCOPEA", true, },
					{ "LARRAMAN", true, },
					{ "OCCULOBE", true, },
					{ "MKVII_IMPERIAL_FIST", true, },
					{ "EMPERORS_PRAETORIAN", true, },
				}},
				custom_code = nil,
				custom_numbers = nil,
			},
			{
				author = "Bruham/YourDoom",
				name = "Ultramarine",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_ultramarine.png",
				main = "mods/Noita40K/files/pics/codex_gfx/space_marine_ultramarine.png",
				custom_desc = "Highly disciplined and courageous warriors, the Ultramarines have remained true to the teachings of their Primarch for 10,000 standard years. Utilizing Codex Astartes as their primary weapon, they are able to achieve outstanding tactical decisions, that alone were known to win wars which had already been considered a failure, not only completely obliterating the opposition but also preserving priceless resources. / Courage and Honour! /",
				guns = nil,
				items = {
					"mods/Noita40K/files/entities/items/grenade_he.xml",
					"mods/Noita40K/files/entities/items/grenade_he.xml",
					"mods/Noita40K/files/entities/items/grenade_flashbang.xml",
				},
				perks = { false, {
					{ "MKVII_ULTRAMARINE", true, },
					{ "CODEX_MASTERY", true, },
				}},
				custom_code = nil,
				custom_numbers = nil,
			},
			{
				author = "Bruham/YourDoom",
				name = "Blood_Angel",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_blood_angel.png",
				main = "mods/Noita40K/files/pics/codex_gfx/space_marine_blood_angel.png",
				custom_desc = "The Blood Angels are well-known across the galaxy for their bloodthirsty nature in battle, and feared for the curse of flawed gene-seed they carry, which, none-the-less, is the primary source of their terrifying combat performance. They were one of the most celebrated Legions: their countless heroic deeds and victories known to untold billions of the Emperor's subjects across the length and breadth of the Imperium. / By the Blood of Sanguinius! /",
				guns = { 
					"GOLDY_BOLTER",
					"BOLT_CARBINE",
					"CHAINSWORD",
					"MELTACUTTER",
				},
				items = nil,
				perks = { false, {
					{ "MKVII_BLOOD_ANGEL", true, },
					{ "BLACK_RAGE", true, },
				}},
				custom_code = nil,
				custom_numbers = nil,
			},
			{
				author = "Bruham/YourDoom",
				name = "Dark_Angel",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_dark_angel.png",
				main = "mods/Noita40K/files/pics/codex_gfx/space_marine_dark_angel.png",
				custom_desc = "The Dark Angels were one of the most cryptic Legions. They fought uncountable wars against never seen before and never discovered again enemies, held numerous horrifyingly heretical secrets and were responsible for several of the most glorious victories of the Imperium. The capabilities of their arsenal can't be rivaled with and their combat potential is unmatched, much like the fury that the Angels unleash upon those who betrayed their brotherhood. / Repent! For tomorrow you die! /",
				guns = { 
					"RED_BOLTER",
					"BOLT_CARBINE",
					"CHAINSWORD",
					"MELTACUTTER",
				},
				items = {
					"mods/Noita40K/files/entities/items/osculant_device.xml",
					"mods/Noita40K/files/entities/items/grenade_ruptor.xml",
					"mods/Noita40K/files/entities/items/grenade_he.xml",
				},
				perks = { false, {
					{ "MKVII_DARK_ANGEL", true, },
				}},
				custom_code = nil,
				custom_numbers = nil,
			},
			{
				author = "Bruham/YourDoom",
				name = "White_Scar",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_white_scar.png",
				main = "mods/Noita40K/files/pics/codex_gfx/space_marine_white_scar.png",
				custom_desc = "Known and feared throughout the Imperium for their highly mobile way of war, the White Scars are considered the masters of the lightning strike and hit-and-run attack. Bearing the ritual scars of bravery, these fierce warriors fight with all the tribal savagery that define the fierce steppe nomads of their homeworld bringing swift death to all of the enemies of the mankind. / For the Emperor and the Khan! /",
				guns = nil,
				items = nil,
				perks = { false, {
					{ "MKVII_WHITE_SCAR", true, },
					{ "CHOGORIAN_SAVAGERY", true, },
				}},
				custom_code = nil,
				custom_numbers = nil,
			},
			{
				author = "Bruham/YourDoom",
				name = "Raven_Guard",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_raven_guard.png",
				main = "mods/Noita40K/files/pics/codex_gfx/space_marine_raven_guard.png",
				custom_desc = "From its earliest days, the Raven Guard were known as cunning and patient hunters, adept at biding their time until the moment to strike was at hand. For thousands of standard years, across thousands of worlds, they stalked the enemies of the Imperium as shadows of death, waiting for the perfect moment to deliver the killing blow before melting back into the darkness once more, leaving no witnesses and no unnessesary casualities behind. / Victory or Death! /",
				guns = { 
					"STALKER_BOLTER",
					"BOLT_CARBINE",
					"CHAINSWORD",
					"MELTACUTTER",
				},
				items = {
					"mods/Noita40K/files/entities/items/grenade_flashbang.xml",
					"mods/Noita40K/files/entities/items/grenade_flashbang.xml",
				},
				perks = { false, {
					{ "MKVII_RAVEN_GUARD", true, },
					{ "LIVING_SHADOW", true, },
				}},
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "Tech-Priest",
		class_desc = "Explore the world full of unseen abominations and blasphemous machinery as the Omnissiah's chosen. Vaporize the flesh, study the xenotech, forge ultimate weapons and discover long-forgotten constructs with the potent arsenal of devastatingly advanced guns and horrifyingly blessed augmentations. Armorum Telae Sunt Verum Robur.",
		unlock_case = "Complete xeno artefact deep below.",
		default_guns = nil,
		default_items = nil,
		default_perks = 
		{
			{ "UNCHAINED", false, },
			{ "OMNISSIAHS_BLESSING", true, },
			{ "BREATH_OF_MARS", true, },
		},
		visual = 
		{
			{ "UNCHAINED", },
			{ "OMNISSIAHS_BLESSING", },
			{ "BREATH_OF_MARS", },
		},
		default_skin = 1,
		skins = 
		{
			{
				author = "Bruham/YourDoom",
				name = "Magos_Explorator",
				unlocked = true,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_tech_priest_magos_explorator.png",
				main = "mods/Noita40K/files/pics/codex_gfx/tech_priest_magos_explorator.png",
				custom_desc = "Adeptus Mechanicus are well known for their frenetic obsession with technology as well as for how little innovative minds are left amongst them. However, no matter how few, those members of the Machine Cult often play key roles in the history of the Imperium and their name - Explorators. Armed to the teeth with forbidden technologies, extensive knowledge of numerous dark secrets and truly undying urge for discovery, they represent the Omnissiah in all of its terrifying glory, eager to save and ready to destroy.",
				guns = { 
					"VOLKITE_CALIVER",
					"DARKFIRE_RIFLE",
					"SOLLEX_AEGIS",
					"MITRALOCK",
				},
				items = {
					"mods/Noita40K/files/entities/items/e_grenade_arc.xml",
					"mods/Noita40K/files/entities/items/e_grenade_arc.xml",
				},
				perks = { false, {
					{ "ETERNAL_VIGILANCE", true, },
					{ "MECHADENDRITES", true, },
					{ "SICARIAN_ARMOUR", true, },
					{ "REFRACTOR_FIELD", true, },
					{ "SERVOSKULL", true, },
				}},
				custom_code = nil,
				custom_numbers = "mods/Noita40K/files/append/magic_numbers_eternal_vigilance.xml",
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "[WIP]",
		class_desc = nil,
		unlock_case = "Coming soon.",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = 
		{
			{
				author = "",
				name = "[WIP]",
				unlocked = false,
				icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_empty.png",
				main = nil,
				custom_desc = nil,
				guns = nil,
				items = nil,
				perks = nil,
				custom_code = nil,
				custom_numbers = nil,
			},
		},
	},
	{
		class_name = "Custom",
		class_desc = "Ruthless mersenaries and legendary warriors? Living machines and animated corpses? Foul xenos and heroes from the unknown lands? You want it? It's your's, brother, as long as you are alright with a little bit of heresy. Quidquid Latine Dictum Sit, Altum Videtur.",
		unlock_case = "Install some extensions to \"unlock\" this one. Check \"Extensions\" thread at the mod's Steam page for futher info.",
		special_icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_custom.png",
		default_guns = nil,
		default_items = nil,
		default_perks = nil,
		visual = nil,
		default_skin = 1,
		skins = {},
	},
}

--guns
gun_info = 
{
	{
		id = "BOLTER",
		name = "Bolter",
		unlocked = class_state( 1, 3 ),
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_bolter.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/bolter.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/75_bolt_he_mag_medium.png" },
		path = "mods/Noita40K/files/entities/guns/bolter.xml",
	},
	{
		id = "WHITE_BOLTER",
		name = "Betrayer's_Bane",
		unlocked = HasFlagPersistent( "triumph_iron_hand" ) and true or nil,
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_bolter_betrayers_bane.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/bolter_betrayers_bane.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/75_bolt_he_mag_medium.png", "mods/Noita40K/files/pics/cards_gfx/pyrum_petrol_canister_small.png", },
		path = "mods/Noita40K/files/entities/guns/bolter_betrayers_bane.xml",
	},
	{
		id = "GREEN_BOLTER",
		name = "Drake's_Roar",
		unlocked = HasFlagPersistent( "triumph_salamander" ) and true or nil,
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_bolter_drakes_roar.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/bolter_drakes_roar.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/75_bolt_hei_mag.png" },
		path = "mods/Noita40K/files/entities/guns/bolter_drakes_roar.xml",
	},
	{
		id = "GOLDY_BOLTER",
		name = "Octavio's_Burden",
		unlocked = HasFlagPersistent( "triumph_blood_angel" ) and true or nil,
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_bolter_octavios_burden.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/bolter_octavios_burden.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/75_bolt_he_mag_medium.png" },
		path = "mods/Noita40K/files/entities/guns/bolter_octavios_burden.xml",
	},
	{
		id = "RED_BOLTER",
		name = "Ravenwing_Bolter",
		unlocked = HasFlagPersistent( "triumph_dark_angel" ) and true or nil,
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_bolter_ravenwing.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/bolter_ravenwing.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/75_bolt_stasis_mag.png" },
		path = "mods/Noita40K/files/entities/guns/bolter_ravenwing.xml",
	},
	{
		id = "STALKER_BOLTER",
		name = "Stalker_Bolter",
		unlocked = HasFlagPersistent( "triumph_raven_guard" ) and true or nil,
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_bolter_stalker.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/bolter_stalker.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/998_bolt_ap_s_mag.png" },
		path = "mods/Noita40K/files/entities/guns/bolter_stalker.xml",
	},
	{
		id = "BOLT_CARBINE",
		name = "Bolt_Carbine",
		unlocked = class_state( 1, 3 ),
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_carbine.png",
		pic = "mods/Noita40K/files/pics/codex_gfx/rifle_pic.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/50mm_bolt_ap_he_mag_small.png" },
		path = "mods/Noita40K/files/entities/guns/rifle.xml",
	},
	{
		id = "CHAINSWORD",
		name = "Chainsword",
		unlocked = class_state( 1, 3 ),
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_chainsword.png",
		pic = "mods/Noita40K/files/pics/codex_gfx/chainsword_pic.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/adamantium_carbon_teeth.png" },
		path = "mods/Noita40K/files/entities/guns/chainsword.xml",
	},
	{
		id = "MELTACUTTER",
		name = "Melta-Cutter",
		unlocked = class_state( 1, 3 ),
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_cutter.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/cutter.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/pyrum_petrol_canister_small.png" },
		path = "mods/Noita40K/files/entities/guns/cutter.xml",
	},
	{
		id = "VOLKITE_CALIVER",
		name = "Volkite_Caliver",
		unlocked = class_state( 11, 3 ),
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_volkite.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/volkite.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/hd_power_pack.png" },
		path = "mods/Noita40K/files/entities/guns/volkite.xml",
	},
	{
		id = "DARKFIRE_RIFLE",
		name = "Darkfire_Rifle",
		unlocked = class_state( 11, 3 ),
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_darkfire.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/darkfire.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/warpborn_photon_pack.png" },
		path = "mods/Noita40K/files/entities/guns/darkfire.xml",
	},
	{
		id = "SOLLEX_AEGIS",
		name = "Sollex-Aegis",
		unlocked = class_state( 11, 3 ),
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_sollex.png",
		pic = "mods/Noita40K/files/pics/codex_gfx/sollex_pic.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/sollex_focusing_crystal.png" },
		path = "mods/Noita40K/files/entities/guns/sollex.xml",
	},
	{
		id = "MITRALOCK",
		name = "Mitralock",
		unlocked = class_state( 11, 3 ),
		icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_gun_mitralock.png",
		pic = "mods/Noita40K/files/pics/guns_gfx/mitralock.png",
		ammo = { "mods/Noita40K/files/pics/cards_gfx/mt_lasbat.png" },
		path = "mods/Noita40K/files/entities/guns/mitralock.xml",
	},
}

--perks
organ_list =
{
	-- armour
	{ "MKVII_SPACE_WOLF", },
	{ "MKVII_IRON_HAND", },
	{ "MKVII_SALAMANDER", },
	{ "MKVII_IMPERIAL_FIST", },
	{ "MKVII_ULTRAMARINE", },
	{ "MKVII_BLOOD_ANGEL", },
	{ "MKVII_DARK_ANGEL", },
	{ "MKVII_WHITE_SCAR", },
	{ "MKVII_RAVEN_GUARD", },
	{ "SICARIAN_ARMOUR", },
	-- gene-seed
	{ "SECOND_HEART", },
	{ "OSSMODULA", },
	{ "BISCOPEA", },
	{ "LARRAMAN", },
	{ "OCCULOBE", },
	{ "SUS_AN", },
	-- implants
	{ "OMNISSIAHS_BLESSING", },
	{ "BREATH_OF_MARS", },
	{ "ETERNAL_VIGILANCE", },
	-- modifications
	{ "MECHADENDRITES", },
	{ "REFRACTOR_FIELD", },
	{ "SERVOSKULL", },
	-- misc
	{ "FENRISIAN_BLOOD", },
	{ "NOCTURNE_FORGED", },
	{ "EMPERORS_PRAETORIAN", },
	{ "CODEX_MASTERY", },
	{ "BLACK_RAGE", },
	{ "CHOGORIAN_SAVAGERY", },
	{ "LIVING_SHADOW", },
}

--herds
herd_relations = {
	{ 
		name = "living_shadow", 
		default_value = 99,
		vanilla_vertical = { 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 0, 100, 100, 100, 100, 100, 0, 100, 0, 100, },
		vanilla_horizontal = { 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 0, 100, 100, 100, 100, 100, 0, 100, 0, 100, },
		custom_vertical = {},
		custom_horizontal = { 100, },
	},
}

--quests
quest_list = {
	{
		id = "BEACON_HUNT",
		is_global = false,
		pic = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_quest_beacon.png",
		name = "Beacon Hunt",
		desc = "Find the source of the signal.",
		conclusion = "Signal source was reached.",
		checker = function( num, gui, uid, pic_x, pic_y, pic_z, hooman, char_x, char_y, alpha, beta, gamma, progress )
			local dist = math.sqrt(( char_x - tonumber( alpha ))^2 + ( char_y - tonumber( beta ))^2 )/10
			new_text( gui, pic_x, pic_y, pic_z, "Distance to beacon: "..shorten_number( dist, 10 ).."m" )
			
			return uid
		end,
		winner = function( num, hooman, char_x, char_y, alpha, beta, gamma, progress )
			local dist = math.sqrt(( char_x - tonumber( alpha ))^2 + ( char_y - tonumber( beta ))^2 )/10
			return dist < tonumber( gamma )
		end,
	},
	{
		id = "BEACON_HUNT_ITEM",
		is_global = false,
		pic = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_quest_beacon_item.png",
		name = "Lost and Forgotten",
		desc = "There's an artifact that was said to kill the Gods. Find it.",
		conclusion = "Item was obtained.",
		checker = function( num, gui, uid, pic_x, pic_y, pic_z, hooman, char_x, char_y, alpha, beta, gamma, progress )
			local dist = math.sqrt(( char_x - tonumber( alpha ))^2 + ( char_y - tonumber( beta ))^2 )/10
			new_text( gui, pic_x, pic_y, pic_z, "Distance to beacon: "..shorten_number( dist, 10 ).."m" )
			
			return uid
		end,
		winner = function( num, hooman, char_x, char_y, alpha, beta, gamma, progress )
			local inv_comp = EntityGetFirstComponentIncludingDisabled( hooman, "Inventory2Component" )
			local wand_id = ComponentGetValue2( inv_comp, "mActiveItem" )
			if( wand_id == 0 or wand_id == nil ) then
				return false
			end
			
			return EntityGetName( wand_id ) == gamma
		end,
	},
	{
		id = "KILLING_SPREE",
		is_global = false,
		pic = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_quest_killing_spree.png",
		name = "Killing Spree",
		desc = "This world is overwhelmed with dusgusting xenos. Purge them for the name of the Emperor.",
		conclusion = "Heretics were purged.",
		checker = function( num, gui, uid, pic_x, pic_y, pic_z, hooman, char_x, char_y, alpha, beta, gamma, progress )
			new_text( gui, pic_x, pic_y, pic_z, "Kills left: "..( alpha - progress ))
			return uid
		end,
		winner = function( num, hooman, char_x, char_y, alpha, beta, gamma, progress )
			local kill_count = StatsGetValue( "enemies_killed" )
			if( tonumber( beta ) ~= kill_count ) then
				progress = tonumber( quest_progress_controller( num )) + kill_count - tonumber( beta )
				quest_progress_controller( num, progress )
				quest_abg_controller( num, { nil, kill_count, nil } )
			end
			
			return progress >= tonumber( alpha )
		end,
	},
}

--codex
codex_structure =
{
	{
		name = "Briefing",
		main_icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_codex_general.png",
		entries = 
		{
			{
				"General",
				"Codex will teach you some of the background lore and mechanics of this mod.",
				"Check Main/Pause Menu -> Options -> Mod Settings -> Noita40K for further info. You can also find a complete breakdown of the majority of mod features at mods/[mod_id]/libro_manualis.",
			},
			{
				"Controls",
				"Double tap [USE] to reload the gun in hand.",
				"Some of the equipment has special functionality that may be activated either via the [RMB] or [USE] + [DOWN] combo. Check corresponding info pages for more detailed description.",
			},
			{
				"Kinda_Important_Stuff",
				"The buttons right below will switch the panels. Everything that looks like a button is most likely a button - don't hesitate to click it."
			},
			{
				"Vanilla_Tips",
				"You are expected to already know the basics of the vanilla, so be sure to complete the game at least once before proceeding.",
				"You can read descriptions of any items by mousing over their icons with opened inventory.",
				"You can drink from any liquid containing item via the [RMB] on its inventory icon.",
			},
			{
				"Extra",
				"This mod supports extensions. Check \"Extensions\" thread at Steam mod page for examples and/or already published works."
			},
		},
	},
	{
		name = "Personnel",
		main_icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_codex_chars.png",
		entries = 
		{
			{
				icon = class_info[1].skins[class_info[1].default_skin].icon,
				unlocked = class_state( 1, 1 ),
				name = "[Firstborn Space Marine]",
				stats = "Difficulty: beta / Toughness: 250 / Height: 2.4 m / Mass: 623 kg / Speed: 12 m/s / PL: 82.5 /",
				image = { "mods/Noita40K/files/pics/ui_anims/ultramarine_idle/", 6, 12 },
				desc = "Adeptus Astartes are fearsome warriors, created by the Emperor and forged by the millenia of neverending wars. Only one Space Marine can be compared to a battalion of regular troops and a company of Astartes is considered to be a sufficient enough force to kneel entire armies. They dominate the battlefield through raw power and resilience but their capabilities are drastically improved with application of outstanding tactics and inhuman skills granted by a dozen of Gene-Seed implants that unlock the true potential of human body.",
			},
			{
				icon = class_info[2].skins[class_info[2].default_skin].icon,
				unlocked = class_state( 2, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[3].skins[class_info[3].default_skin].icon,
				unlocked = class_state( 3, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[4].skins[class_info[4].default_skin].icon,
				unlocked = class_state( 4, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[5].skins[class_info[5].default_skin].icon,
				unlocked = class_state( 5, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[6].skins[class_info[6].default_skin].icon,
				unlocked = class_state( 6, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[7].skins[class_info[7].default_skin].icon,
				unlocked = class_state( 7, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[8].skins[class_info[8].default_skin].icon,
				unlocked = class_state( 8, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[9].skins[class_info[9].default_skin].icon,
				unlocked = class_state( 9, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[10].skins[class_info[10].default_skin].icon,
				unlocked = class_state( 10, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[11].skins[class_info[11].default_skin].icon,
				unlocked = class_state( 11, 1 ),
				name = "[Tech-Priest]",
				stats = "Difficulty: gamma / Toughness: 100 / Height: 1.6 m / Mass: 416 kg / Speed: 21 m/s / PL: 64.1 /",
				image = { "mods/Noita40K/files/pics/ui_anims/magos_explorator_idle/", 6, 12 },
				desc = "Tech-Priests are the members of the Machine Cult, a priesthood which forms an hierarchy of technicians, scientists, and religious leaders who believe that knowledge represents the only true divinity in the universe. Their bodies are often heavily augmented in the pursuit to please the Machine God, Omnissiah. However, despite the never-ending thirst for knowledge of all branches of the order, most Tech-Priests have lost the ability to innovate or carry out basic scientific research - that is the price of 10,000 years of neverending wars and all-consuming stagnation.",
			},
			{
				icon = class_info[12].skins[class_info[12].default_skin].icon,
				unlocked = class_state( 12, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[13].skins[class_info[13].default_skin].icon,
				unlocked = class_state( 13, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[14].skins[class_info[14].default_skin].icon,
				unlocked = class_state( 14, 1 ),
				name = "[WIP]",
				stats = "Toughness: / Height: / Mass: / Speed: / Style: / PL: /",
				image = nil,
				desc = "Coming soon.",
			},
			{
				icon = class_info[15].special_icon,
				unlocked = true,
				name = "[Custom]",
				stats = "Toughness: nan / Height: nan / Mass: nan / Speed: nan / Style: nan / PL: nan /",
				image = { "mods/Noita40K/files/pics/ui_anims/gear_spinning/", 16, 4 },
				desc = "Check \"Extensions\" thread at the mod's Steam page.",
			},
		},
	},
	{
		name = "Armaments",
		main_icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_codex_guns.png",
		entries = 
		{
			{
				info = get_gun_with_id( "BOLTER" ),
				unlocked = class_state( 1, 1 ),
				name = "[Bolter]",
				stats = "Fire mode: full / Velho C.: yes / Cal.: .75 / RPM: 360 / DPS: 430+ / PL: 121.5 /",
				desc = "The Bolter, also called a Boltgun, and its variants are some of the most powerful, hand-held, ballistic anti-personnel weaponry in use by the military forces of the Imperium of Man. It is chambered in .75 calibre and capable of fully automatic fire.",
			},
			{
				info = get_gun_with_id( "WHITE_BOLTER" ),
				unlocked = class_state( 1, 1 ),
				name = "[Betrayer's Bane]",
				stats = "Fire mode: full / Velho C.: yes / Cal.: .75 / RPM: 360 / DPS: 1K+ / PL: 70.3 /",
				desc = "Betrayer's Bane is one of the many patterns of the standard Boltgun. A masterpiece of enginering, it somehow manages to combine a fully functional Bolter and a modified version of the Melta-Cutter in a single handheld device. Use [RMB] for the secondary fire mode.",
			},
			{
				info = get_gun_with_id( "GREEN_BOLTER" ),
				unlocked = class_state( 1, 1 ),
				name = "[Drake's Roar]",
				stats = "Fire mode: full / Velho C.: yes / Cal.: .75 / RPM: 360 / DPS: 250+ / PL: 121.5 /",
				desc = "Drake's Roar is one of the many patterns of the standard Boltgun. It features slightly redesigned exterior while keeping near indetical to the original model insides, that were only slightly tweaked to operate flawlessly with the Inferno rounds - its default ammunition.",
			},
			{
				info = get_gun_with_id( "GOLDY_BOLTER" ),
				unlocked = class_state( 1, 1 ),
				name = "[Octavio's Burden]",
				stats = "Fire mode: full / Velho C.: yes / Cal.: .75 / RPM: 515 / DPS: 550+ / PL: 129.7 /",
				desc = "Octavio's Burden is one of the many patterns of the standard Boltgun. This one has a Canticle of Unceasing Service inscribed which grants it a unique ability of condencing the power of the Black Rage into blood-like substance that constantly lubricates the mechanism improving the rate of fire.",
			},
			{
				info = get_gun_with_id( "RED_BOLTER" ),
				unlocked = class_state( 1, 1 ),
				name = "[Ravenwing Bolter]",
				stats = "Fire mode: full / Velho C.: yes / Cal.: .75 / RPM: 360 / DPS: 350+ / PL: 121.5 /",
				desc = "Ravenwing Bolter utilises a special type of ammunition, Stasis rounds, that are able to momentarily halt the flow of time in the surrounding area to stun and desorient the foe.",
			},
			{
				info = get_gun_with_id( "STALKER_BOLTER" ),
				unlocked = class_state( 1, 1 ),
				name = "[Stalker Bolter]",
				stats = "Fire mode: full / Velho C.: yes / Cal.: .998 / RPM: 240 / DPS: 450+ / PL: 73.4 /",
				desc = "Incredibly accurate and powerful yet still compact and reliable sniper-oriented pattern of the standard Bolter design. It's uses .998 armour-piercing rounds by default and comes with a scope that can be accessed via the [RMB].",
			},
			{
				info = get_gun_with_id( "BOLT_CARBINE" ),
				unlocked = class_state( 1, 1 ),
				name = "[Bolt Carbine]",
				stats = "Fire mode: semi / Velho C.: yes / Cal.: 50mm / RPM: 360 / DPS: 1K+ / PL: 205.1 /",
				desc = "Light anti-armour semi-automatic bolt rifle chambered in 50mm. Yours also has a bayonet attached and a special [RMB] ability.",
			},
			{
				info = get_gun_with_id( "CHAINSWORD" ),
				unlocked = class_state( 1, 1 ),
				name = "[Chainsword]",
				stats = "Fire mode: melee / Type: constant / Velho C.: no / DPS: 780+ / PL: 1.1 /",
				desc = "The Chainsword is the preferred close combat melee weapon of many of the military forces of the Imperium of Man. It is essentially a sword with powered teeth that run along a single-edged blade like that of a chainsaw. Most versions of the weapon make use of monomolecularly-edged or otherwise razor-sharp teeth. Using [RMB] while holding it will put you in a short term berserk rage.",
			},
			{
				info = get_gun_with_id( "MELTACUTTER" ),
				unlocked = class_state( 1, 1 ),
				name = "[Melta-Cutter]",
				stats = "Fire mode: beam / Type: melta / Velho C.: no / Range: 10 / DPS: 4.5K+ / PL: 27 /",
				desc = "Melta Weapons are a type of thermal weapons that make use of a sub-atomic reaction in a chemical fuel source to produce a tightly-focused beam of intense, searing heat. This version was primarily designed for demolition work - not for actual combat, as Metlaguns were, but will still perform exceptionally in a CQC.",
			},
			{
				info = get_gun_with_id( "VOLKITE_CALIVER" ),
				unlocked = class_state( 11, 1 ),
				name = "[Volkite Caliver]",
				stats = "Fire mode: beam / Type: volkite / Velho C.: no / Range: 250 / DPS: 2K+ / PL: 25.4 /",
				desc = "Volkite Weapons are a type of beam weapon developed during the Dark Age of Technology. They produce a deflagrating attack, in which subsonic combustion caused by a beam of thermal energy propagated through a target material by thermodynamic heat transfer so that hot burning matter heates the next layer of cold material and ignites it.",
			},
			{
				info = get_gun_with_id( "DARKFIRE_RIFLE" ),
				unlocked = class_state( 11, 1 ),
				name = "[Darkfire Rifle]",
				stats = "Fire mode: single / Type: darkfire / Velho C.: no / Range: 500 / DPS: 500+ / PL: 41.8 /",
				desc = "Photon Thruster Weapons unleash a howling needle-thin beam of blackness able to pierce through the densest matters and easily rip the most heavily armoured men and machines apart. This model is appeared to be a downscaled Darkfire Cannon, a superheavy vehicle-mounted weapon. It seems that the darkfire beam interacts with this world in strange ways - stay vigilant. You may praise the Omnissiah via the [RMB].",
			},
			{
				info = get_gun_with_id( "SOLLEX_AEGIS" ),
				unlocked = class_state( 11, 1 ),
				name = "[Sollex-Aegis Energy Blade]",
				stats = "Fire mode: beam / Type: constant / Velho C.: no / Range: 25 / DPS: 1.1K+ / PL: 1.1 /",
				desc = "This weapon is a product of information obtained from the Aegis Data Fragments and utilises the properties of the Sollex focusing crystals. It is the one of the rarest type of weapons in the Imperium, a blade of coherent high-energy plasma which materialises from the armoured hilt as a blazing, roaring column of blue-white fire. Use [RMB] to activate it and [LMB] to swing.",
			},
			{
				info = get_gun_with_id( "MITRALOCK" ),
				unlocked = class_state( 11, 1 ),
				name = "[Mitralock]",
				stats = "Fire mode: beam / Type: multi-las / Velho C.: no / Range: 65 / DPS: 300+ / PL: 26.11 /",
				desc = "Mitralocks are a type of Las-weapon used by the Adeptus Mechanicus. They release a fan of las-pulses akin to a shotgun blast. The firing range is reduced in favour of an increased likelihood of injuring their targets and way higher anti-material damage. Their beams evaporate surface layer of the metals turning it into the mirror that drastically increases internal structural damage.",
			},
		},
	},
	{
		name = "Perks",
		main_icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_codex_perks.png",
		entries = 
		{
			{
				info = get_perk_with_actual_id( "MKVII_ULTRAMARINE" ),
				unlocked = class_state( 1, 1 ),
				name = "[Mark VII Power Armour]",
				desc = "This version of basic power armour was also known as Imperator Armour. It is the contemporary variant of power armour most commonly used by the Space Marine Chapters of the Imperium. Mark VII armour was developed during the last stages of the Horus Heresy, and remains in use as the most common form of power armour more than 10,000 standard years later. This one is coupled with a combat jumppack and features targeting arrays. Hold [DOWN]+[USE] to accelerate towards the crosshair.",
			},
			{
				info = get_perk_with_actual_id( "SICARIAN_ARMOUR" ),
				unlocked = class_state( 11, 1 ),
				name = "[Sicarian Battle Armour]",
				desc = "This armour is built out of the multilayered alloy, informally known as aegium, that provides admirable protection despite being thin and flexible. It acts as a capacitor that harnesses the energy of incoming attacks and disperses it across the wearer's energy system.",
			},
			{
				info = get_perk_with_actual_id( "SECOND_HEART" ),
				unlocked = class_state( 1, 1 ),
				name = "[Secondary Heart]",
				desc = "The Secondary Heart, also called the Maintainer, resembles a smaller version of the Human heart and is implanted in the chest cavity. In the event of failure of the Space Marine's original heart, the Secondary Heart is usually capable of pumping enough blood through the Astartes' circulatory system to maintain survival.",
			},
			{
				info = get_perk_with_actual_id( "OSSMODULA" ),
				unlocked = class_state( 1, 1 ),
				name = "[Ossmodula]",
				desc = "The Ossmodula, also called the Ironheart, is surgically placed alongside the neophyte's pituitary gland at the base of the brain, thus becoming a part of the Space Marine's endocrine system, secretes a specially engineered form of human growth hormone. When the effects of this hormone are combined with a diet laced with microscopic ceramic-based minerals, they act to synthesise the rapid growth of an Astartes' skeleto-muscular system which results in an Astartes' superhuman strength and massive size compared to a baseline human male.",
			},
			{
				info = get_perk_with_actual_id( "BISCOPEA" ),
				unlocked = class_state( 1, 1 ),
				name = "[Biscopea]",
				desc = "The Biscopea, also called the Forge of Strength, enhances a Space Marine's physical combat ability and survivability to superhuman levels should he live to become a full Astartes of a Space Marine Chapter. This organ is implanted into the chest cavity. It is small, approximately spherical and, like the Ossmodula, its primary action is hormonal. The presence of the Biscopea stimulates muscle growth throughout the body, greatly increasing a Space Marine's physical strength.",
			},
			{
				info = get_perk_with_actual_id( "LARRAMAN" ),
				unlocked = class_state( 1, 1 ),
				name = "[Larraman's Organ]",
				desc = "Larraman's Organ, also called the Healer, shaped like the Human liver but only the size of a golf ball, is placed within the chest cavity and manufactures the synthetic biological cells known as Larraman Cells. These biosynthetic cells serve the same physiological purpose for an Astartes as the normal Human body's platelets, serving to clot the blood lost from wounds, but act faster, more efficiently and more effectively.",
			},
			{
				info = get_perk_with_actual_id( "OCCULOBE" ),
				unlocked = class_state( 1, 1 ),
				name = "[Occulobe]",
				desc = "The Occulobe, also called the Eye of Vengeance, sits at the base of the brain after being implanted along the optic nerve and connected to the retina, and provides hormonal and genetic stimuli which enable a Space Marine's eyes to respond to the optic-therapy that all neophytes must undergo in their Chapter's Apothecarium to allow sight in low-light conditions and near-darkness almost as well as in bright daylight.",
			},
			{
				info = get_perk_with_actual_id( "SUS_AN" ),
				unlocked = class_state( 1, 1 ),
				name = "[Sus-an Membrane]",
				desc = "The Sus-an Membrane, also called the Hibernator, implanted within the neophyte's cranium, eventually merges with the recipient's cerebrum, becoming a full part of his neural architecture. The organ's functions are ineffective without follow-up chemical therapy and training by a Chapter's Apothecaries, but with sufficient practice and instruction a Space Marine can use this implant to enter a state of suspended animation, consciously or as an automatic reaction to extreme trauma, keeping the wounded Space Marine alive for Terran years.",
			},
			{
				info = get_perk_with_actual_id( "OMNISSIAHS_BLESSING" ),
				unlocked = class_state( 11, 1 ),
				name = "[Omnissiah's Blessing]",
				desc = "73% of your body consists of highly advanced machinery which significantly enchanses your capabilities, provides solid foundation for futher augmentation and makes you immune to the most natural threats.",
			},
			{
				info = get_perk_with_actual_id( "BREATH_OF_MARS" ),
				unlocked = class_state( 11, 1 ),
				name = "[The Breath of Mars]",
				desc = "Your respiratory system is represented by the cognis rebreather tubes that plunge deep into the chest. When necessary you may draw upon a reservoir of polluted gases harvested from your homeworld.",
			},
			{
				info = get_perk_with_actual_id( "ETERNAL_VIGILANCE" ),
				unlocked = class_state( 11, 1 ),
				name = "[Eternal Vigilance]",
				desc = "Your eyelids were replaced with a multipurpose visor system connected directly to the brain. It will display your position, speed and orientation, condition of the energy system, locations and threat levels of all detected enemies. It features the auspex, global success chance and threat level calculators, advanced entity scanner and centralized console output. It may also assume direct control over the servoskull and mechadedrites. Let its sophistication be the bane of your foes. Use the button in top left corner to change the modes. Press [DOWN]+[USE] to capture the target. See console log for futher info.",
			},
			{
				info = get_perk_with_actual_id( "MECHADENDRITES" ),
				unlocked = class_state( 11, 1 ),
				name = "[Mechadendrites]",
				desc = "A Mechadendrite is the term used for the bionic tentacle-like limb prosthetics. They are hard-wired into the central nervous system of the owner and surgically attached to the spine, so that user will be able to control them using neural impulses just like a biological limb.",
			},
			{
				info = get_perk_with_actual_id( "REFRACTOR_FIELD" ),
				unlocked = class_state( 11, 1 ),
				name = "[Refractor Field]",
				desc = "Refractor Field distorts the image of the wearer with a shimmering cloak of gravitic force. Incoming attacks that strike the shield will be refracted into multi-spectrum bursts that dissipate into harmlessness.",
			},
			{
				info = get_perk_with_actual_id( "SERVOSKULL" ),
				unlocked = class_state( 11, 1 ),
				name = "[Servo-skull]",
				desc = "A Servo-skull is a drone-like robotic device that appears to be a human skull outfitted with electronic or cybernetic components that utilise embedded anti-gravity field generators to allow them to hover and drift bodiless through the air. Your model was drastically redesigned to better serve its master: it is able to perform low level operations with highly hazardous xenotech, store certain types of data and process any matter into its basic components. You may interact with the red buttons on the servointerface via the [RMB].",
			},
			{
				info = get_perk_with_actual_id( "FENRISIAN_BLOOD" ),
				unlocked = class_state( 1, 1 ),
				name = "[Fenrisian Blood]",
				desc = "Cold winds of Fenris and noble taste of Mjød tempered your body and spirit, so not only you have become near immune to the extremes of the frost but also gained a special ability of transforming inner heat into the pure power of the warrior's rage.",
			},
			{
				info = get_perk_with_actual_id( "NOCTURNE_FORGED" ),
				unlocked = class_state( 1, 1 ),
				name = "[Nocturne Forged]",
				desc = "A special kind of skin, bestowed upon you by the genes of the Primarch himself, allows you to survive an absolute extremes of the searing heat and effortlessly step through an incinerating inferno.",
			},
			{
				info = get_perk_with_actual_id( "EMPERORS_PRAETORIAN" ),
				unlocked = class_state( 1, 1 ),
				name = "[Emperor's Praetorian]",
				desc = "Unbreakable body and adamant mind result in an outstanding steadfastness, striking even for the Space Marine, making you a true Bastion of the Imperium.",
			},
			{
				info = get_perk_with_actual_id( "CODEX_MASTERY" ),
				unlocked = class_state( 1, 1 ),
				name = "[Codex Mastery]",
				desc = "Inhuman memory combined with unbelievable discipline result in the thorough knowledge of the Codex Astartes. Such a remarkable achievement grants you a special blessing: every shot worthy of His finest warrior will be instantly replenished, so the enemies might taste even more of the glorious fury of thy weapons.",
			},
			{
				info = get_perk_with_actual_id( "BLACK_RAGE" ),
				unlocked = class_state( 1, 1 ),
				name = "[Black Rage]",
				desc = "Burried deep inside you, a horrifying curse sleeps, a distant memory of the greatest betrayal, waiting for the chance to unleash upon the world and harvest the bloody crop of the enemies of the Imperium.",
			},
			{
				info = get_perk_with_actual_id( "CHOGORIAN_SAVAGERY" ),
				unlocked = class_state( 1, 1 ),
				name = "[Chogorian Savagery]",
				desc = "Your noble and valiant heart can't stand the scum that dares to oppose the might of your Primarch to the extend of throwing you into the battle rage in the heat of the fight.",
			},
			{
				info = get_perk_with_actual_id( "LIVING_SHADOW" ),
				unlocked = class_state( 1, 1 ),
				name = "[Living Shadow]",
				desc = "Decades of nonstop practice allow you to position your body in such a way that it near completely fades into the background, making you effectively invisible to the naked eye, assuming you are stationary.",
			},
			{
				info = get_perk_with_actual_id( "UNCHAINED" ),
				unlocked = true,
				name = "[Unchained]",
				desc = "You feel a strange sensation in the hands. It seems that some fundamental laws of this world are not applying to you: \"wands\" are always tinkerable and several \"spells\" may be used without any vessel.",
			},
		},
	},
	{
		name = "Database",
		main_icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_codex_logs.png",
		entries = 
		{
			--WIP
		},
	},
	{
		name = "Credits",
		main_icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_codex_credits.png",
		entries = 
		{
			{ "Logic by", "Bruham", },
			{ "Graphics by", "YourDoom", },
			"Special thanks to / - ryyst / - etwas_merkwuerdig / - Whollow / - Vromikos / - Horscht / - Archaeopteryx / - Disco Witch /",
		},
	},
}

--misc
quote=
{
	"Fear not death, for the soul of the faithful man never dies.",
	"Duty prevails.",
	"Victory needs no explanation, defeat allows none.",
	"To admit defeat is to blaspheme against the Emperor.",
	"Let faith protect your mind and metal your flesh.",
}