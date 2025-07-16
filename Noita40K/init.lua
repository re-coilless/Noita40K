if( ModIsEnabled( "mnee" )) then
	ModLuaFileAppend( "mods/mnee/bindings.lua", "mods/Noita40K/mnee.lua" )
else return end

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Noita40K/files/appends/actions.lua" )
-- ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/Noita40K/files/appends/extra_modifiers.lua" )
-- ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Noita40K/files/appends/status_effects.lua" )
ModMaterialsFileAdd( "mods/Noita40K/files/map/matters/_.xml" )
ModRegisterAudioEventMappings( "mods/Noita40K/files/GUIDs.txt" )

-- raycast interpolation
-- clean up armor (both hiisi smg and shotguns should work properly)
-- separate stress to vector

-- news role (direct broadcasting)
-- design of n40 post
-- fair mod contibution

-- targetting is integrated into index info system
-- energy weapons should have ammo consumption based on gun
-- char jump sound is not playing cause jump velocity is too big
-- muzzle flash should be per-gun instead of per-spell (allow spells to modify them the same way as beam altering goes)
-- kicking sound should be produced by different event
-- shooting at the flat walls to the left of the char almost always results in ricochet
-- turn sprite_pipeline into full on spritesheet generator that optimizes the atlas and xml
-- nuke all old settings
-- add proper [liquid]/[gas]/[solid] tags to custom matters (cleanup matter list overall)
-- ammo display with an option to align at the center of the screen or at the pointer
-- standing on one knee animation on holding down s while on solid ground that prevents movement, reduces recoil and dramatically improves weapon handling
-- ledge mounting anim

-- do frag grenade that has directed spread
-- rmb action should be obtained from controls comp Fire2 (do this after vector mnee integration is done)
-- do quick class bootup intro animation on world pre update (should block inputs + display tips)
-- custom status effect system though HitEffectComp (thanks Extol)
-- make trailing red eyes for rage modes
-- custom mnee frontend in the main menu
-- fix shift clicking to have proper callbacks
-- allow shift clicking equipment

-- some of the marine classes should recieve Land Device - permanently attached full auto conversion kit for rifle
-- madness combat style hands
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
-- mobile game tier tutorial that remembers which steps were shown and doesn't show em again (per-class)
-- N40 dialogue options must be the concepts, not words (+meaning+ instead of "What does it mean?")
-- Display all n40 unlocks as a tech tree
-- sword must stick into enemies who are not oneshotted and pulling it out deals additional damage
-- ogryn mode than makes all lore caveman like
-- refraction visualization must be chromatic abbreration + color correction based, no bending needed
-- if no character author is stated, write "vanilla"
-- medium class of main force can obtain alternative loadouts though permanent in-game unlocks (that's how terminators are done)
-- ?clot and warpmatter ambient sound (can be done though spawning entites from reaction with air and global script check for them in radius of char and plays the sound loop if some are detected)

function OnModInit()
	dofile_once( "mods/Noita40K/files/_lib.lua" )
	
	pen.add_translations( "mods/Noita40K/files/appends/translations.csv" )
	pen.magic_append( "mods/index_core/files/_structure.lua", "mods/Noita40K/files/appends/index.lua" )

	pen.lib.sprite_builder( "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/1_ultramarine/player.xml" )

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