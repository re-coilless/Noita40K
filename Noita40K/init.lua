if( ModIsEnabled( "mnee" )) then
	ModLuaFileAppend( "mods/mnee/bindings.lua", "mods/Noita40K/mnee.lua" )
else return end

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Noita40K/files/appends/actions.lua" )
-- ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/Noita40K/files/appends/extra_modifiers.lua" )
-- ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Noita40K/files/appends/status_effects.lua" )
ModMaterialsFileAdd( "mods/Noita40K/files/map/matters/_.xml" )
ModRegisterAudioEventMappings( "mods/Noita40K/files/GUIDs.txt" )

-- shooting at the flat walls to the left of the char results in ricochet
-- do quick class bootup intro animation on world pre update (should block inputs)
-- custom status effect system though HitEffectComp (thanks Extol)
-- turn sprite_pipeline into full on spritesheet generator that optimizes the atlas and xml
-- nuke all old settings
-- add proper [liquid]/[gas]/[solid] tags to custom matters (cleanup matter list overall)
-- MaterialSuckerComponent randomized_position for osculant device
-- emissive eyes with correct z (make trailing red eyes for rage modes; steal Alex's method of encoding?)
-- custom mnee frontend on the main menu
-- remove vanilla map

-- some of the marine classes should recieve Land Device - permanently attached full auto conversion kit for rifle
-- battle sister is vanilla now
-- madness combat style hands
-- LMB on dendrite button to toggle the speed mode (does not maintain distance to ground and is faster) and RMB to enable/disable
-- codex should have lore word hyperlinks that show tips on hower
-- overload shader (somehow vertex shader is being overwritten by refractor)
-- replace confirm button on default loadout switch + global mode swap button at the top of slot list + item showcase on class/skin screens + add "select" button on the desc page
-- combat wolf with custom ai for Space Wolf
-- option to align ammo at the center of the screen
-- smoothen blood rage edge effect transition
-- custom taunts for the marines
-- exterminatus should squirt some juice directly at nearby sentient entities
-- stable main menu height
-- Eternal vigilance ability to hack robots allegiance to yours through a minigame + raven's test for admech hacking minigame (with layers)
-- SpriteComponent never_ragdollify_on_death for magos
-- "target has expired"
-- include detailed PL calcuator explanation in seraphim
-- cicle the class icon between subclasses if it's not selected
-- check bloodtype for threat level
-- two-stage beacon event
-- salamnder gets flamer as rifle replacement
-- extension documentation
-- sister of silence sword can be holstered on the back for instaswing on lmb (has to be reholstered manually each time by holding the button in inventory, gives slight speed boost, spine armor and shows on back when done so)
-- several stands for the sister of silence greatsword and the controls are be based on the stand in use (fast swing, low damage, no dodge | slow swing, high damage, dodge)
-- ConvertMaterialOnAreaInstantly
-- add a secondary layer of unique legion perks (after getting some item, you current perk "evolves" to entirely different and more powerful one)
-- music is a single track that evolves based on events and biomes
-- put new link in the desc https://cortex-command-community.github.io/
-- mobile game tier tutorial that remembers which steps were shown and doesn't show em again (per-class)
-- standing on one knee animation on holding down s while on solid ground that prevents movement, reduces recoil and dramatically improves weapon handling
-- N40 dialogue options must be the concepts, not words (+meaning+ instead of "What does it mean?")
-- Display all n40 unlocks as a tech tree
-- Use rack2 for advanced audio design
-- burning with promethium fire or being ot low hp should apply "void compomized" debuff that restores all status effect weaknesses that armor negates (can be fixed either in the "holy mountain" or with a "reseal kit")
-- sword must stick into enemies who are not oneshotted and pulling it out deals additional damage
-- ogryn mode than makes all lore caveman like
-- dendrite inertion
-- foreground alpha and glowing on refraction is fucked
-- unchained now acts as a special access pass
-- if no character author is stated, write "vanilla"
-- medium class of main force can obtain alternative loadouts though permanent in-game unlocks (that's how terminators are done)
-- taunts should have hardcoded unified cooldown
-- custom ai should get the baseline terrain info from REing the wang gen, then run simple real-time checks to get box2d geometry and extra check every terrain altering thing (like explosions)
-- ?clot and warpmatter ambient sound

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