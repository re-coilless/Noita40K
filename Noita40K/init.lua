if( ModIsEnabled( "mnee" )) then
	ModLuaFileAppend( "mods/mnee/bindings.lua", "mods/Noita40K/mnee.lua" )
else return end

ModMaterialsFileAdd( "mods/Noita40K/files/map/matters/_.xml" )
ModRegisterAudioEventMappings( "mods/Noita40K/files/GUIDs.txt" )
ModMagicNumbersFileAdd( "mods/Noita40K/files/appends/magic_numbers.xml" )

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Noita40K/files/appends/actions.lua" )
-- ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/Noita40K/files/appends/extra_modifiers.lua" )
-- ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Noita40K/files/appends/status_effects.lua" )

-- new magos taunts through cardinal
-- new magos char sounds
-- guns

-- make trailing red eyes for rage modes

-- news role (direct broadcasting)

-- redo reloading system
-- main menu
-- inventory (three main styles: physical, holographic and psychic)
-- do class bootup intro animation on world pre update (should block inputs + display tips)
-- custom mnee frontend
-- allow shift clicking equipment
-- medium class of main force can obtain alternative loadouts though permanent in-game unlocks (that's how terminators are done)

-- standing on one knee animation on holding down s while on solid ground that prevents movement, reduces recoil and dramatically improves weapon handling
-- ledge mounting anim
-- madness combat style hands

-- hotkey to automatically throw the first grenade
-- hotkey for quick melee (only simple swords support this)
-- scope is picture-in-picture zoom shader at the pointer + x1.5 max cam distance
-- do frag grenade that has directed spread
-- rmb action should be obtained from controls comp Fire2 (do this after vector mnee integration is done)
-- some of the marine classes should recieve Land Device - permanently attached full auto conversion kit for rifle
-- clot and warpmatter ambient sound (can be done though spawning entites from reaction with air and global script check for them in radius of char and plays the sound loop if some are detected)
-- LMB on dendrite button to toggle the speed mode (does not maintain distance to ground and is faster) and RMB to enable/disable
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
-- music is a single track that evolves based on events and biomes
-- put new link in the desc https://cortex-command-community.github.io/
-- N40 dialogue options must be the concepts, not words (+meaning+ instead of "What does it mean?")
-- Display all n40 unlocks as a tech tree
-- sword must stick into enemies who are not oneshotted and pulling it out deals additional damage
-- ogryn mode than makes all lore caveman like
-- refraction visualization must be chromatic abbreration + color correction based, no bending needed
-- if no character author is stated, write "vanilla"
-- permanent status effects that are designed to be abused through procedural interactions
-- mrshll pack builder
-- global currency is accumulated through holotype collection – a miniboss enemies that can be harvested for smaples on defeat (the kill must be clean) to later to delivered for analysis to the STC (maybe make it take irl time)

function OnModInit()
	dofile_once( "mods/Noita40K/files/_lib.lua" )
	
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

	pen.add_translations( "mods/Noita40K/files/appends/translations.csv" )
	pen.magic_append( "mods/index_core/files/_structure.lua", "mods/Noita40K/files/appends/index.lua", true )

	pen.lib.sprite_builder( "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/1_ultramarine/player.xml" )
	pen.lib.sprite_builder( "mods/Noita40K/files/classes/3_adeptus_mechanicus/2_techpriest/1_magos_explorator/player.xml" )

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