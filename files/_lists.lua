n40 = n40 or {}

n40.GUNS = --obtain stats and such dynamically from xml parsing, write names/descs to guns from here
{
	-- SLOT 1 (good all-arounder)
	BOLTER_GENERIC = {
		name = "Bolter",
		desc = "The Bolter, also called a Boltgun, and its variants are some of the most powerful, hand-held, ballistic anti-personnel weaponry in use by the military forces of the Imperium of Man. It is chambered in .998 calibre and capable of fully automatic fire.",
		path = "mods/Noita40K/files/items/weapons/bolter.xml",
		-- func = nil,
	},
	BOLTER_COMBIMELTA = {
		name = "Betrayer's Bane",
		desc = "Betrayer's Bane is one of the many patterns of the standard Boltgun. A masterpiece of enginering, it somehow manages to combine a fully functional Bolter and a modified version of the Melta-Cutter in a single handheld device. Use [RMB] for the secondary fire mode.",
		path = "mods/Noita40K/files/items/weapons/bolter_betrayers_bane.xml",
	},
	BOLTER_INCENDIARY = {
		name = "Drake's Roar",
		desc = "Drake's Roar is one of the many patterns of the standard Boltgun. It features slightly redesigned exterior while keeping near indetical to the original model insides, that were only slightly tweaked to operate flawlessly with the Inferno rounds - its default ammunition.",
		path = "mods/Noita40K/files/items/weapons/bolter_drakes_roar.xml",
	},
	BOLTER_RAPID = {
		name = "Octavio's Burden",
		desc = "Octavio's Burden is one of the many patterns of the standard Boltgun. This one has a Canticle of Unceasing Service inscribed which grants it a unique ability of condencing the power of the Black Rage into blood-like substance that constantly lubricates the mechanism improving the rate of fire.",
		path = "mods/Noita40K/files/items/weapons/bolter_octavios_burden.xml",
	},
	BOLTER_ARCHEO = {
		name = "Ravenwing Bolter",
		desc = "Ravenwing Bolter utilises a special type of ammunition, Stasis rounds, that are able to momentarily halt the flow of time in the surrounding area to stun and desorient the foe.",
		path = "mods/Noita40K/files/items/weapons/bolter_ravenwing.xml",
	},
	BOLTER_STALKER = {
		name = "Stalker Bolter",
		desc = "Incredibly accurate and powerful yet still compact and reliable sniper-grade pattern of the standard Bolter design. It's uses .998 armour-piercing rounds with extended casing and comes with a scope that can be accessed via the [RMB].",
		path = "mods/Noita40K/files/items/weapons/bolter_stalker.xml",
	},
	VOLKITE_PISTOL = {
		name = "Volkite Caliver",
		desc = "Volkite Weapons are a type of beam weapon developed during the Dark Age of Technology. They produce a deflagrating attack, in which subsonic combustion caused by a beam of thermal energy propagated through a target material by thermodynamic heat transfer so that hot burning matter heates the next layer of cold material and ignites it.",
		path = "mods/Noita40K/files/items/weapons/volkite_pistol.xml",
	},

	-- SLOT 2 (niche and skill-based)
	BOLTER_RIFLE = {
		name = "Bolt Carbine",
		desc = "Light anti-armour semi-automatic bolt rifle chambered in 50mm. Comes with an attached bayonet intended for jumppack charges.",
		path = "mods/Noita40K/files/items/weapons/bolter_rifle.xml",
	},
	DARKFIRE_RIFLE = {
		name = "Darkfire Rifle",
		desc = "Photon Thruster Weapons unleash a howling needle-thin beam of blackness able to pierce through the densest matters and easily rip the most heavily armoured men and machines apart. This model is appeared to be a downscaled Darkfire Cannon, a superheavy vehicle-mounted weapon. It seems that the darkfire beam interacts with this world in strange ways - stay vigilant. You may praise the Omnissiah via the [RMB].",
		path = "mods/Noita40K/files/items/weapons/darkfire_rifle.xml",
	},

	-- SLOT 3 (melee)
	SWORD_CHAIN = {
		name = "Chainsword",
		desc = "The Chainsword is the preferred close combat melee weapon of many of the military forces of the Imperium of Man. It is essentially a sword with powered teeth that run along a single-edged blade like that of a chainsaw. Most versions of the weapon make use of monomolecularly-edged or otherwise razor-sharp teeth. Using [RMB] while holding it will put you in a short term berserk rage.",
		path = "mods/Noita40K/files/items/weapons/sword_chain.xml",
	},
	SWORD_SOLLEX = {
		name = "Sollex-Aegis Energy Blade",
		desc = "This weapon is a product of information obtained from the Aegis Data Fragments and utilises the properties of the Sollex focusing crystals. It is the one of the rarest type of weapons in the Imperium, a blade of coherent high-energy plasma which materialises from the armoured hilt as a blazing, roaring column of blue-white fire. Use [RMB] to activate it and [LMB] to swing.",
		path = "mods/Noita40K/files/items/weapons/sword_sollex.xml",
	},

	-- SLOT 4 (utility)
	MELTA_CUTTER = {
		name = "Melta-Cutter",
		desc = "Melta Weapons are a type of thermal weapons that make use of a sub-atomic reaction in a chemical fuel source to produce a tightly-focused beam of intense, searing heat. This version was primarily designed for demolition work - not for actual combat, as Metlaguns were, but will still perform exceptionally in a CQC.",
		path = "mods/Noita40K/files/items/weapons/melta_cutter.xml",
	},
	LASGUN_MITRALOCK = {
		name = "Mitralock",
		desc = "Mitralocks are a type of Las-weapon used by the Adeptus Mechanicus. They release a fan of las-pulses akin to a shotgun blast. The firing range is reduced in favour of an increased likelihood of injuring their targets and way higher anti-material damage. Their beams evaporate surface layer of the metals turning it into the mirror that drastically increases internal structural damage.",
		path = "mods/Noita40K/files/items/weapons/lasgun_mitralock.xml",
	},
}

n40.ITEMS = {
	-- throwables
	GRENADE_HE = {
		name = "",
		desc = "",
		path = "",
	},
	GRENADE_HEI = {
		name = "",
		desc = "",
		path = "",
	},
	GRENADE_FLASHBANG = {
		name = "",
		desc = "",
		path = "",
	},
	GRENADE_ARC = {
		name = "",
		desc = "",
		path = "",
	},
	GRENADE_RUPTOR = {
		name = "",
		desc = "",
		path = "",
	},

	-- misc
	KEG = {
		name = "",
		desc = "",
		path = "",
	},
}

n40.EQUIPMENT = {
	-- defensive
	SHIELD_S = {
		name = "",
		desc = "",
		path = "",
	},
	REFRACTOR_FIELD = {
		name = "Refractor Field",
		desc = "Refractor Field distorts the image of the wearer with a shimmering cloak of gravitic force. Incoming attacks that strike the shield will be refracted into multi-spectrum bursts that dissipate into harmlessness.",
		path = "",
	},

	-- mobility
	JUMPPACK = {
		name = "",
		desc = "",
		path = "",
	},
	JUMPPACK_UPGRADE = {
		name = "",
		desc = "",
		path = "",
	},

	-- utility
	SERVOSKULL = {
		name = "Servo-skull",
		desc = "A Servo-skull is a drone-like robotic device that appears to be a human skull outfitted with electronic or cybernetic components that utilise embedded anti-gravity field generators to allow them to hover and drift bodiless through the air. Your model was drastically redesigned to better serve its master: it is able to perform low level operations with highly hazardous xenotech, store certain types of data and process any matter into its basic components. You may interact with the red buttons on the servointerface via the [RMB].",
		path = "",
	},
	OSCULANT_DEVICE = {
		name = "",
		desc = "",
		path = "",
	},
}

n40.PERKS = {
	-- skins
	MKVII_ULTRAMARINE = {
		name = "Mark VII Power Armour",
		desc = "This version of basic power armour was also known as Imperator Armour. It is the contemporary variant of power armour most commonly used by the Space Marine Chapters of the Imperium. Mark VII armour was developed during the last stages of the Horus Heresy, and remains in use as the most common form of power armour more than 10,000 standard years later. This one is coupled with a combat jumppack and features targeting arrays. Hold [DOWN]+[USE] to accelerate towards the crosshair.",
		path = "",
		func = function( hooman, data )
			ComponentSetValue2( data.pic_char, "image_file",
				"mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/1_ultramarine/player.xml" )
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" ), "ragdoll_filenames_file", "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/1_ultramarine/ragdoll/filenames.txt" )
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( data.arm_id, "HotspotComponent" ), "offset", -0.5, 0 )
		end,
	},
	MKVII_BLOOD_ANGEL = {
		name = "",
		desc = "",
		path = "",
	},
	MKVII_WHITE_SCAR = {
		name = "",
		desc = "",
		path = "",
	},
	MKVII_IMPERIAL_FIST = {
		name = "",
		desc = "",
		path = "",
	},
	MKVII_IRON_HAND = {
		name = "",
		desc = "",
		path = "",
	},
	MKVII_SPACE_WOLF = {
		name = "",
		desc = "",
		path = "",
	},
	MKVII_SALAMANDER = {
		name = "",
		desc = "",
		path = "",
	},
	MKVII_RAVEN_GUARD = {
		name = "",
		desc = "",
		path = "",
	},
	MKVII_DARK_ANGEL = {
		name = "",
		desc = "",
		path = "",
	},
	SICARIAN_ARMOUR = {
		name = "Sicarian Battle Armour",
		desc = "This armour is built out of the multilayered alloy, informally known as aegium, that provides admirable protection despite being thin and flexible. It acts as a capacitor that harnesses the energy of incoming attacks and disperses it across the wearer's energy system.",
		path = "",
	},
	
	-- abilities
	SECOND_HEART = {
		name = "Secondary Heart",
		desc = "The Secondary Heart, also called the Maintainer, resembles a smaller version of the Human heart and is implanted in the chest cavity. In the event of failure of the Space Marine's original heart, the Secondary Heart is usually capable of pumping enough blood through the Astartes' circulatory system to maintain survival.",
		path = "",
		-- func = "",
	},
	OSSMODULA = {
		name = "Ossmodula",
		desc = "The Ossmodula, also called the Ironheart, is surgically placed alongside the neophyte's pituitary gland at the base of the brain, thus becoming a part of the Space Marine's endocrine system, secretes a specially engineered form of human growth hormone. When the effects of this hormone are combined with a diet laced with microscopic ceramic-based minerals, they act to synthesise the rapid growth of an Astartes' skeleto-muscular system which results in an Astartes' superhuman strength and massive size compared to a baseline human male.",
		path = "",
	},
	BISCOPEA = {
		name = "Biscopea",
		desc = "The Biscopea, also called the Forge of Strength, enhances a Space Marine's physical combat ability and survivability to superhuman levels should he live to become a full Astartes of a Space Marine Chapter. This organ is implanted into the chest cavity. It is small, approximately spherical and, like the Ossmodula, its primary action is hormonal. The presence of the Biscopea stimulates muscle growth throughout the body, greatly increasing a Space Marine's physical strength.",
		path = "",
	},
	LARRAMAN = {
		name = "Larraman's Organ",
		desc = "Larraman's Organ, also called the Healer, shaped like the Human liver but only the size of a golf ball, is placed within the chest cavity and manufactures the synthetic biological cells known as Larraman Cells. These biosynthetic cells serve the same physiological purpose for an Astartes as the normal Human body's platelets, serving to clot the blood lost from wounds, but act faster, more efficiently and more effectively.",
		path = "",
	},
	OCCULOBE = {
		name = "Occulobe",
		desc = "The Occulobe, also called the Eye of Vengeance, sits at the base of the brain after being implanted along the optic nerve and connected to the retina, and provides hormonal and genetic stimuli which enable a Space Marine's eyes to respond to the optic-therapy that all neophytes must undergo in their Chapter's Apothecarium to allow sight in low-light conditions and near-darkness almost as well as in bright daylight.",
		path = "",
	},
	SUS_AN = {
		name = "Sus-an Membrane",
		desc = "The Sus-an Membrane, also called the Hibernator, implanted within the neophyte's cranium, eventually merges with the recipient's cerebrum, becoming a full part of his neural architecture. The organ's functions are ineffective without follow-up chemical therapy and training by a Chapter's Apothecaries, but with sufficient practice and instruction a Space Marine can use this implant to enter a state of suspended animation, consciously or as an automatic reaction to extreme trauma, keeping the wounded Space Marine alive for Terran years.",
		path = "",
	},
	CODEX_MASTERY = {
		name = "Codex Mastery",
		desc = "Inhuman memory combined with unbelievable discipline result in the thorough knowledge of the Codex Astartes. Such a remarkable achievement grants you a special blessing: every shot worthy of His finest warrior will be instantly replenished, so the enemies might taste even more of the glorious fury of thy weapons.",
		path = "",
	},
	BLACK_RAGE = {
		name = "Black Rage",
		desc = "Burried deep inside you, a horrifying curse sleeps, a distant memory of the greatest betrayal, waiting for the chance to unleash upon the world and harvest the bloody crop of the enemies of the Imperium.",
		path = "",
	},
	CHOGORIAN_SAVAGERY = {
		name = "Chogorian Savagery",
		desc = "Your noble and valiant heart can't stand the scum that dares to oppose the might of your Primarch to the extend of throwing you into the battle rage in the heat of the fight.",
		path = "",
	},
	EMPERORS_PRAETORIAN = {
		name = "Emperor's Praetorian",
		desc = "Unbreakable body and adamant mind result in an outstanding steadfastness, striking even for the Space Marine, making you a true Bastion of the Imperium.",
		path = "",
	},
	FENRISIAN_BLOOD = {
		name = "Fenrisian Blood",
		desc = "Cold winds of Fenris and noble taste of Mjød tempered your body and spirit, so not only you have become near immune to the extremes of the frost but also gained a special ability of transforming inner heat into the pure power of the warrior's rage.",
		path = "",
	},
	NOCTURNE_FORGED = {
		name = "Nocturne Forged",
		desc = "A special kind of skin, bestowed upon you by the genes of the Primarch himself, allows you to survive an absolute extremes of the searing heat and effortlessly step through an incinerating inferno.",
		path = "",
	},
	LIVING_SHADOW = {
		name = "Living Shadow",
		desc = "Decades of nonstop practice allow you to position your body in such a way that it near completely fades into the background, making you effectively invisible to the naked eye, assuming you are stationary.",
		path = "",
	},
	UNCHAINED = {
		name = "Unchained",
		desc = "No secret shall remain veiled.",
		path = "",
	},
	OMNISSIAHS_BLESSING = {
		name = "Omnissiah's Blessing",
		desc = "The vast majority of your body consists of highly advanced machinery which significantly enchanses your capabilities, provides solid foundation for futher augmentation and makes you immune to the most natural threats.",
		path = "",
	},
	ETERNAL_VIGILANCE = {
		name = "Eternal Vigilance",
		desc = "Your eyelids were replaced with a multipurpose visor system connected directly to the brain. It will display your position, speed and orientation, condition of the energy system, locations and threat levels of all detected enemies. It features the auspex, global success chance and threat level calculators, advanced entity scanner and centralized console output. It may also assume direct control over the servoskull and mechadedrites. Let its sophistication be the bane of your foes. Use the button in top left corner to change the modes. Press [DOWN]+[USE] to capture the target. See console log for futher info.",
		path = "",
	},
	BREATH_OF_MARS = {
		name = "The Breath of Mars",
		desc = "Your respiratory system is represented by the cognis rebreather tubes that plunge deep into the chest. When necessary you may draw upon a reservoir of polluted gases harvested from your homeworld.",
		path = "",
	},
	MECHADENDRITES = {
		name = "Mechadendrites",
		desc = "A Mechadendrite is the term used for the bionic tentacle-like limb prosthetics. They are hard-wired into the central nervous system of the owner and surgically attached to the spine, so that user will be able to control them using neural impulses just like a biological limb.",
		path = "",
	},
}

n40.CLASSES = {
	{
		name = "Adeptus Astartes",
		desc = "Adeptus Astartes are fearsome warriors, created by the Emperor and forged by the millenia of neverending wars. Only one Space Marine can be compared to a battalion of regular troops and a company of Astartes is considered to be a sufficient enough force to kneel entire armies. They dominate the battlefield through raw power and resilience but their capabilities are drastically improved with application of outstanding tactics and inhuman skills granted by a dozen of Gene-Seed implants that unlock the true potential of human body.",
		-- icon = "",
	},
	{
		name = "Astra Militarum",
		desc = "",
	},
	{
		name = "Adeptus Mechanicus",
		desc = "",
	},
	{
		name = "Adeptus Astra Telepathica",
		desc = "",
	},
	{
		name = "Officio Assassinorum",
		desc = "",
	},
	{
		name = "Inquisition",
		desc = "",
	},
	{
		name = "Adeptus Terra",
		desc = "",
	},
	{
		name = "Adeptus Ministorum",
		desc = "",
	},
	{
		name = "Leagues of Votann",
		desc = "",
	},
	{
		name = "Talons of the Emperor",
		desc = "",
	},
	{
		name = "Faith Daemons",
		desc = "",
	},
	{
		name = "Alpha Legionnaire",
		desc = "",
	},
	{
		name = "The Five",
		desc = "",
	},
	{
		name = "Fabulas Ultra",
		desc = "",
	},
	{
		name = "CUSTOM",
		desc = "this is where all the extensions go",
	},
}

n40.CLASSES[1].sections = {
	{
		name = "Neophyte",
		desc = "",
		-- icon = "",
	},
	{
		name = "Firstborn Marine",
		desc = "",

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
		name = "Warsuit Veteran",
		desc = "",
	},
	{
		name = "Moritat Warrior",
		desc = "",
	},
}

n40.CLASSES[1].sections[2].chars = {
	{
		name = "Ultramarine",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_ultramarine.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_ultramarine.png",
		desc = "Highly disciplined and courageous warriors, the Ultramarines have remained true to the teachings of their Primarch for 10,000 standard years. Utilizing Codex Astartes as their primary weapon, they are able to achieve outstanding tactical decisions, that alone were known to win wars which had already been considered a failure, not only completely obliterating the opposition but also preserving priceless resources. / Courage and Honour! /",
		-- author = "Bruham/YourDoom",

		-- guns = {},
		-- items = {},
		items_add = { "GRENADE_FLASHBANG" },
		-- equipment = {},
		-- equipment_add = {},
		
		skin = "MKVII_ULTRAMARINE", perks_add = { "CODEX_MASTERY" }, -- perks_remove = {},
		-- func = nil,
	},
	{
		name = "Blood Angel",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_blood_angel.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_blood_angel.png",
		desc = "The Blood Angels are well-known across the galaxy for their bloodthirsty nature in battle, and feared for the curse of flawed gene-seed they carry, which, none-the-less, is the primary source of their terrifying combat performance. They were one of the most celebrated Legions: their countless heroic deeds and victories known to untold billions of the Emperor's subjects across the length and breadth of the Imperium. / By the Blood of Sanguinius! /",

		guns = { [1] = "BOLTER_RAPID" },
		skin = "MKVII_BLOOD_ANGEL", perks_add = { "BLACK_RAGE" },
	},
	{
		name = "Imperial Fist",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_imperial_fist.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_imperial_fist.png",
		desc = "The Imperial Fists were one of the most valiant of all Legions, held as paragons of all the principles to which a Space Marine is heir. They stand as the steadfast defenders of the Imperium, crashing adversary armies for millenias. Indeed, if the Fists have a fault, it is that they continue to strive when others would yield or withdraw, but this comes only at a steep cost in lives. / Primarch, to your glory and the glory of Him on Terra! /",

		equipment_add = { "SHIELD_S" },
		skin = "MKVII_IMPERIAL_FIST", perks_add = { "EMPERORS_PRAETORIAN" }, perks_remove = { "SUS_AN" },
	},
	{
		name = "White Scar",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_white_scar.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_white_scar.png",
		desc = "Known and feared throughout the Imperium for their highly mobile way of war, the White Scars are considered the masters of the lightning strike and hit-and-run attack. Bearing the ritual scars of bravery, these fierce warriors fight with all the tribal savagery that define the fierce steppe nomads of their homeworld bringing swift death to all of the enemies of the mankind. / For the Emperor and the Khan! /",

		equipment = { [1] = "JUMPPACK_UPGRADE" },
		skin = "MKVII_WHITE_SCAR", perks_add = { "CHOGORIAN_SAVAGERY" },
	},
	{
		name = "Iron Hand",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_iron_hand.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_iron_hand.png",
		desc = "The Iron Hands are ultimately defined by their hatred of weakness of any kind, a hatred that extends to their own bodies, for they hold that all organic limbs are ultimately frail and subject to the weaknesses brought on by age and disease, compulsively driven to augment their flesh. In battle, they utilise their anger and hatred, identifying enemies' vulnerabilities and exploiting them ruthlessly. / The Flesh is Weak! /",

		guns = { [1] = "BOLTER_COMBIMELTA" },
		skin = "MKVII_IRON_HAND", perks_add = { "OMNISSIAHS_BLESSING", "ETERNAL_VIGILANCE" },
	},
	{
		name = "Space Wolf",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_space_wolf.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_space_wolf.png",
		desc = "Nurtured among ones of the most hostile predators known to mankind and tempered in deadly permafrost of their homeworld, the Space Wolves were one of the most savage Legiones Astartes in the Imperium. Wild and glorious, brute and perseptive, loyal and horrifying, they are ready to decimate anyone who dares to offend their King or even thinks of foul tricks on the battlefield. / For Russ and the All-father! /",
		
		items_add = { "KEG" },
		skin = "MKVII_SPACE_WOLF", perks_add = { "FENRISIAN_BLOOD" },
	},
	{
		name = "Salamander",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_salamander.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_salamander.png",
		desc = "Craftsmen and artificers, the Salamanders know the true price of every creation be it a machine or a living thing. Such an invaluable knowledge results in the believe that their most important duty is to protect the innocent lives whenever and wherever possible. They are also fascinated by the fire in all of its hypostases, seeing it as the greatest tool and utilizing as the most powerful weapon. / Into the fires of battle, unto the Anvil of War! /",
		
		guns = { [1] = "BOLTER_INCENDIARY" },
		items = { "GRENADE_HEI", "GRENADE_HEI" },
		skin = "MKVII_SALAMANDER", perks_add = { "NOCTURNE_FORGED" },
	},
	{
		name = "Raven Guard",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_raven_guard.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_raven_guard.png",
		desc = "From its earliest days, the Raven Guard were known as cunning and patient hunters, adept at biding their time until the moment to strike was at hand. For thousands of standard years, across thousands of worlds, they stalked the enemies of the Imperium as shadows of death, waiting for the perfect moment to deliver the killing blow before melting back into the darkness once more, leaving no witnesses and no unnessesary casualities behind. / Victory or Death! /",
		
		guns = { [1] = "BOLTER_STALKER" },
		items = { "GRENADE_FLASHBANG", "GRENADE_FLASHBANG" },
		skin = "MKVII_RAVEN_GUARD", perks_add = { "LIVING_SHADOW" },
	},
	{
		name = "Dark Angel",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_space_marine_dark_angel.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/space_marine_dark_angel.png",
		desc = "The Dark Angels were one of the most cryptic Legions. They fought uncountable wars against never seen before and never discovered again enemies, held numerous horrifyingly heretical secrets and were responsible for several of the most glorious victories of the Imperium. The capabilities of their arsenal can't be rivaled with and their combat potential is unmatched, much like the fury that the Angels unleash upon those who betrayed their brotherhood. / Repent! For tomorrow you die! /",
		
		guns = { [1] = "BOLTER_ARCHEO" },
		items_add = { "GRENADE_RUPTOR" },
		equipment_add = { "OSCULANT_DEVICE" },
		skin = "MKVII_DARK_ANGEL", perks_add = { "UNCHAINED" },
	},
}

n40.CLASSES[3].sections = {
	{
		name = "Legiones Skitarii",
		desc = "",
	},
	{
		name = "Tech-Priesthood",
		desc = "Tech-Priests are the members of the Machine Cult, a priesthood which forms an hierarchy of technicians, scientists, and religious leaders who believe that knowledge represents the only true divinity in the universe. Their bodies are often heavily augmented in the pursuit to please the Machine God, Omnissiah. However, despite the never-ending thirst for knowledge of all branches of the order, most Tech-Priests have lost the ability to innovate or carry out basic scientific research - that is the price of 10,000 years of neverending wars and all-consuming stagnation.",
		
		items = { "GRENADE_ARC", "GRENADE_ARC" },
		equipment = { "SERVOSKULL" },
		perks = { "OMNISSIAHS_BLESSING", "ETERNAL_VIGILANCE", "BREATH_OF_MARS" },
	},
	{
		name = "Legio Cybernetica",
		desc = "",
	},
	{
		name = "Auxilia Myrmidon",
		desc = "",
	},
}

n40.CLASSES[3].sections[2].chars = {
	{
		name = "Magos Explorator",
		-- icon = "mods/Noita40K/files/pics/gui_gfx/icons/menu/icon_class_tech_priest_magos_explorator.png",
		-- main = "mods/Noita40K/files/pics/codex_gfx/tech_priest_magos_explorator.png",
		desc = "Adeptus Mechanicus are well known for their frenetic obsession with technology as well as for how little innovative minds are left amongst them. However, no matter how few, those members of the Machine Cult often play key roles in the history of the Imperium and their name - Explorators. Armed to the teeth with forbidden technologies, extensive knowledge of numerous dark secrets and truly undying urge for discovery, they represent the Omnissiah in all of its terrifying glory, eager to save and ready to destroy.",
		
		guns = { "VOLKITE_PISTOL", "DARKFIRE_RIFLE", "SWORD_SOLLEX", "LASUNG_MITRALOCK" },
		equipment_add = { "REFRACTOR_FIELD" },
		skin = "SICARIAN_ARMOUR", perks_add = { "MECHADENDRITES", "UNCHAINED" },
	},
}

n40.CLASSES[6].sections = {
	{
		name = "Ordo Hereticus",
		desc = "",
	},
	{
		name = "Ordo Xenos",
		desc = "",
	},
	{
		name = "Ordo Malleus",
		desc = "",
	},
	{
		name = "Ordos Minoris",
		desc = "",
	},
}

n40.CLASSES[6].sections[2].chars = {
	{
		name = "Adepta Sororitas",
	},
}

n40.CODEX = {
	BRIEFING = {},
	PERSONNEL = {}, -- perks are displayed here
	WARGEAR = {}, -- populated procedurally
	DATABASE = {}, -- basically a progress log
	CREDITS = {},
}

n40.CODEX.BRIEFING = {
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
}

n40.CODEX.CREDITS = {
	{ "Logic by", "Bruham" },
	{ "Graphics by", "YourDoom" },
	{ "Additional contributions by", { --sort alphabetically
		"Rib",
	}},
	{ "Funded by", {
		{ "Vibrant Causality", 9999999 },
		{ "pants", 999999 },
	}},
	{ "Special thanks to", { --sort alphabetically; include all Quires from CA
		"ryyst",
		"etwas_merkwuerdig",
		"Whollow",
		"Vromikos",
		"Horscht",
		"Archaeopteryx",
		"Disco Witch",
		"Copi",
	}},
}

n40.QUOTES = --add insane amount here
{
	"Fear not death, for the soul of the faithful man never dies.",
	"Duty prevails.",
	"Victory needs no explanation, defeat allows none.",
	"To admit defeat is to blaspheme against the Emperor.",
	"Let faith protect your mind and metal your flesh.",
}