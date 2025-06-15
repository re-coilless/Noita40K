if( ModIsEnabled( "mnee" )) then
	ModLuaFileAppend( "mods/mnee/bindings.lua", "mods/Noita40K/mnee.lua" )
else return end

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Noita40K/files/appends/actions.lua" )
-- ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/Noita40K/files/appends/extra_modifiers.lua" )
-- ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Noita40K/files/appends/status_effects.lua" )
ModMaterialsFileAdd( "mods/Noita40K/files/appends/matters.xml" )
ModRegisterAudioEventMappings( "mods/Noita40K/files/GUIDs.txt" )

-- translations
-- fully setup ultramarine

-- add physics_hit as AP damage that will be considered as x5 with physical armour penetration
-- armor script is a single-function pen.armor() thing that does an on-hit function (add new table to penman to house all gameplay-first functionality)
-- phycisal armour patch that prevents phasing and projectiles sometimes disappear + sound and sparks play only if the speed is above certain level
-- check speed + angle for armour penetration
-- top 10% of armour should have rickoshet chance, the higher - the more

-- jumppack is an "item" (do a separate inventory space for equipment)
-- SpriteStainsComponent sprite_id for multisprite stains
-- all equipment should be hotspot attached as it must be universal

-- chainsword should overheat while cutting through metal + permanently decrease physics_hit resistance
-- make chainsword be a chainsaw (exhaust, engine revving) but make it stop working underwater (requires several attempts while outside to restart)
-- chainsword projectiles lifetime is 2x of what it should be
-- rmb action should be obtained from controls comp Fire2

-- remove friendly fire from projectiles themselves
-- bolter rounds should be only effective against meat while rifle round should go through anything it instakills
-- all weapons scripts should run through index
-- add clanking sound for the last 25% of shots from the mag
-- add rickoshet angles (somehow bouncy orb and that extra bouncy shit have different angles)
-- fancy explosions with shockwave visualization through shaders (https://youtu.be/ypNJHZt2cX8), enemies hit with shockwaves should be briefly stunned if they don't have void-sealed status
-- turning around with heavy weapon resets it to point up
-- casings are being ejected at different speeds based on char facing

-- vector basic spell system rewrite (wand is the center part of the thing, player is optional)

---------------------------------------------------------------------------

-- turn sprite_pipeline into full on spritesheet generator that optimizes the atlas and xml
-- nuke all old settings
-- add proper [liquid]/[gas]/[solid] tags to custom matters (cleanup matter list overall)
-- all the gui page tables to the separate lists.lua
-- MaterialSuckerComponent randomized_position for osculant device
-- emissive eyes with correct z (make trailing red eyes for rage modes; steal Alex's method of encoding?)
-- custom mnee frontend that ties all the mods together
-- remove vanilla map

-- battle sister is vanilla now
-- madness combat style hands
-- LMB on dendrite button to toggle the speed mode (does not maintain distance to ground and is faster) and RMB to enable/disable
-- better tutorial
-- codex should have lore word hyperlinks that show tips on hower
-- plasma rounds should detonate if their acceleration was too high
-- overload shader (somehow vertex shader is being overwritten by refractor)
-- replace confirm button on default loadout switch + global mode swap button at the top of slot list + item showcase on class/skin screens
-- combat wolf with custom ai for Space Wolf
-- option to align ammo at the center of the screen
-- smoothen blood rage edge effect transition
-- custom taunts for the marines
-- exterminatus should squirt some juice directly at nearby sentient entities
-- stable main menu height
-- Eternal vigilance ability to hack robots allegiance to yours through a minigame
-- redo the credits section to add contributors and supporters
-- SpriteComponent never_ragdollify_on_death for magos
-- update servoskull's wand storage with necro stuff's one
-- "target has expired"
-- include detailed PL calcuator explanation in seraphim
-- cicle the class icon between subclasses if it's not selected
-- check bloodtype for threat level
-- two-stage beacon event
-- stalker bolter ammo should have almost no knockback + make knockback to be less on other rounds
-- salamnder gets flamer as rifle replacement
-- extension documentation
-- make the mass salvager ignore the stuff that was once picked up by the player
-- sister of silence sword can be holstered on the back for instaswing on lmb (has to be reholstered manually each time by holding the button in inventory, gives slight speed boost, spine armor and shows on back when done so)
-- several stands for the sister of silence greatsword and the controls are be based on the stand in use (fast swing, low damage, no dodge | slow swing, high damage, dodge)
-- ConvertMaterialOnAreaInstantly
-- add a secondary layer of unique legion perks (after getting some item, you current perk "evolves" to entirely different and more powerful one)
-- add "select" button on the desc page
-- music is a single track that evolves based on events and biomes
-- put new link in the desc https://cortex-command-community.github.io/
-- raven's test for admech hacking minigame (with layers)
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
-- having jumppack one slows down the movement speed
-- unchained now acts as a special access pass
-- if no chacrater author is stated, write "vanilla"
-- medium class of main force can obtain alternative loadouts (that's how terminators are done)
-- taunts should have hardcoded unified cooldown
-- custom ai should get the baseline terrain info from REing the wang gen, then run simple real-time checks to get box2d geometry and extra check every terrain altering thing (like explosions)
-- ?clot and warpmatter ambient sound
-- fix the stains

function OnModInit()
	dofile_once( "mods/Noita40K/files/_lib.lua" )
	
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

--[[
function OnWorldPreUpdate()
	--Flags
	if( GameHasFlagRun( "poli_handling_time" )) then
		GameRemoveFlagRun( "poli_handling_time" )
	end
	
	if( GameHasFlagRun( "damage_was_prevented" )) then
		GameRemoveFlagRun( "damage_was_prevented" )
	end
end
]]

function OnPlayerSpawned( hooman )
	dofile_once( "mods/Noita40K/files/_lib.lua" )

	local initer = "N40K_READY_TO_PURGE"
	if GameHasFlagRun( initer ) then return end
	GameAddFlagRun( initer )

	local active = n40.setup_character( hooman )

	local x, y = EntityGetTransform( hooman )
	EntityLoad( "mods/Noita40K/files/items/weapons/bolter_generic.xml", x, y )
	
	--[[
	--Nothing to see here
	if( ModSettingGetNextValue( "Noita40K.BEST_GAMEPLAY_EVER" )) then
		EntityAddComponent( hooman, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/player/meme_controller.lua",
			execute_every_n_frame = "1",
		})

		GlobalsSetValue( "MEMER", "0" )
		
		local angle = 0
		for i = 1,8 do
			local laser = EntityLoad( "mods/Noita40K/files/entities/misc/meme_laser.xml", x, y )
			local emit_comp = EntityGetFirstComponentIncludingDisabled( laser, "LaserEmitterComponent" )
			ComponentSetValue2( emit_comp, "laser_angle_add_rad", math.rad( angle ))
			EntityAddChild( hooman, laser )
			angle = angle + 45
		end
		
		ComponentObjectSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" ), "damage_multipliers", "projectile", 0 )
		
		EntityAddComponent( hooman, "AudioLoopComponent", 
		{ 
			_tags = "enabled_in_world,ultramar_anthem",
			file = "mods/Noita40K/files/40K.bank",
			event_name = "fx/ultramar_anthem",
			volume_autofade_speed = "0.25",
		})
	end
	
	--Random stuff
	if( ModSettingGetNextValue( "Noita40K.UI_MODE" ) == 1 ) then
		new_notification( "First time?", "Open the inventory." )
	end
	]]
end