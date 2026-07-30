if( ModIsEnabled( "mnee" )) then
	ModLuaFileAppend( "mods/mnee/bindings.lua", "mods/n40k/mnee.lua" )
else return end

ModMaterialsFileAdd( "mods/n40k/files/map/matters/_.xml" )
ModRegisterAudioEventMappings( "mods/n40k/files/GUIDs.txt" )
ModMagicNumbersFileAdd( "mods/n40k/files/appends/magic_numbers.xml" )

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/n40k/files/appends/actions.lua" )
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/n40k/files/appends/status_effects.lua" )

-- darkfire and volkite status effects
-- add credits

-- finish battle sister (jumppack, plasma pistol, mass-restricted dual wielding)
-- marine perks

-- add warning that's not compatible with vanilla if generic map detected + warnings for each dependency
-- matter info is broken due to culling
-- new magos char sounds
-- better sound effect system
-- universal sword script
-- beam weapons should apply recoil/damage with a frame-long delay
-- rmb action should be obtained from controls comp Fire2

-- distance from grip to barrel should affect the flip force
-- main menu
-- inventory (three main styles: physical, holographic and psychic)
-- do class bootup intro animation on world pre update (should block inputs + display tips)
-- custom mnee frontend
-- allow shift clicking equipment

-- standing on one knee animation on holding down s while on solid ground that prevents movement, reduces recoil and dramatically improves weapon handling
-- ledge mounting anim
-- madness combat style hands
-- make trailing red eyes for rage modes

-- steal wolfensteins perk system (achievement-locked minor general gameplay rewards)
-- ballistic semiauto jamming should still fire the round that ruins the mag except with scpecial effects (slower + different sound)
-- medium class of main force can obtain alternative loadouts though permanent in-game unlocks (that's how terminators are done)
-- taunts should apply a cooldown status effect that prevents stress from dropping and boosts its increase
-- hotkey to automatically throw the first grenade
-- hotkey to switch to a melee weapon
-- scope is picture-in-picture zoom shader at the pointer + x1.5 max cam distance
-- do frag grenade that has directed spread
-- some of the marine classes should recieve Land Device - permanently attached full auto conversion kit for rifle
-- clot and warpmatter ambient sound through Cardinal (can be done though spawning entites from reaction with air and global script check for them in radius of char and plays the sound loop if some are detected)
-- codex should have lore word hyperlinks that show tips on hower
-- replace confirm button on default loadout switch + global mode swap button at the top of slot list + item showcase on class/skin screens + add "select" button on the desc page
-- combat wolf with custom ai for Space Wolf
-- exterminatus should squirt some juice directly at nearby sentient entities
-- Eternal vigilance ability to hack robots allegiance to yours through a minigame + raven's test for admech hacking minigame (with layers)
-- "target has expired"
-- include detailed PL calcuator explanation in seraphim
-- cicle the class icon between subclasses if it's not selected
-- sister of silence sword can be holstered on the back for instaswing on lmb (has to be reholstered manually each time by holding the button in inventory, gives slight speed boost, spine armor and shows on back when done so)
-- several stands for the sister of silence greatsword and the controls are be based on the stand in use (fast swing, low damage, no dodge | slow swing, high damage, dodge)
-- ConvertMaterialOnAreaInstantly
-- N40 dialogue options must be the concepts, not words (+meaning+ instead of "What does it mean?")
-- Display all n40 unlocks as a tech tree
-- sword must stick into enemies who are not oneshotted and pulling it out deals additional damage
-- ogryn mode than makes all lore caveman like
-- refraction visualization must be chromatic abbreration + color correction based, no bending needed
-- if no character author is stated, write "vanilla"
-- permanent status effects that are designed to be abused through procedural interactions
-- global currency is accumulated through holotype collection – a miniboss enemies that can be harvested for smaples on defeat (the kill must be clean) to later to delivered for analysis to the STC (maybe make it take irl time)

function OnModInit()
	dofile_once( "mods/n40k/files/_lib.lua" )
	
	if( pen.vld( pen.setting_get( "Noita40K.CURRENT_CLASS" ))) then
		local rot = { "ARMOR_DEFLECTION_CHANCE", "BAYONET_HIT_FORCE", "BAYONET_HIT_VELOCITY",
			"BAYONET_MAX_DAMAGE", "CLASS_SELECTION", "CLASS_STATS", "CLIPBOARD_INFO", "CURRENT_CLASS",
			"CURRENT_SKIN", "CUSTOM_LOADOUT", "DATABASED_NAMES", "DENDRITES_SOUND", "DISABLE_SHADERS",
			"ENABLE_CUSTOM_LOADOUT", "JUMPPACK_BURNING_RATE", "JUMPPACK_REAL_FIRE", "JUMPPACK_SPEED",
			"MAG_AUTORELOAD", "MAX_AMMO_SHOWN_FULL", "NOTE_INFO", "PURITY_CONTROL", "QUEST_INFO", "",
			"REFRACTOR_VISUALS", "RELOAD_TAP_WAIT", "RESETER", "SHOW_PERKS", "SHOW_REMINDED", "VERSION",
			"SHOW_REMINDER", "SKIN_ONLY", "SPAWN_LIFE_EATER", "TOOLTIP_MODE", "TUTORIAL_MODE", "UI_MODE" }
		for i,v in ipairs( rot ) do ModSettingRemove( "Noita40K."..v ) end
	end

	pen.add_shaders( "mods/n40k/files/appends/shaders.frag" )
	pen.add_translations( "mods/n40k/files/appends/translations.csv" )
	pen.magic_append( "mods/index_core/files/_structure.lua", "mods/n40k/files/appends/index.lua", true )

	pen.lib.sprite_builder( "mods/n40k/files/classes/1_adeptus_astartes/2_firstborn/1_ultramarine/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/1_adeptus_astartes/2_firstborn/2_blood_angel/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/1_adeptus_astartes/2_firstborn/3_imperial_fist/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/1_adeptus_astartes/2_firstborn/4_white_scar/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/1_adeptus_astartes/2_firstborn/5_iron_hand/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/1_adeptus_astartes/2_firstborn/6_space_wolf/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/1_adeptus_astartes/2_firstborn/7_salamander/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/1_adeptus_astartes/2_firstborn/8_raven_guard/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/1_adeptus_astartes/2_firstborn/9_dark_angel/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/3_adeptus_mechanicus/2_techpriest/1_magos_explorator/player.xml" )
	pen.lib.sprite_builder( "mods/n40k/files/classes/6_inquisition/1_ordo_hereticus/1_adepta_sororitas/player.xml" )

	--[[
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
	]]
end

--sounds
--[[
cosmicembers
fastson
michellegrobler
cambrianman
mariadelcastillo
daveincamas
samsterbirdies
arrowheadproductions
robinbarnard
duisterwho
jesabat
oneshotofficial
dymewiz
]]