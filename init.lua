if( ModIsEnabled( "mnee" )) then
	ModLuaFileAppend( "mods/mnee/bindings.lua", "mods/Noita40K/mnee.lua" )
else return end

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Noita40K/files/appends/actions.lua" )
-- ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/Noita40K/files/appends/extra_modifiers.lua" )
-- ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Noita40K/files/appends/status_effects.lua" )
ModMaterialsFileAdd( "mods/Noita40K/files/appends/matters.xml" )
ModRegisterAudioEventMappings( "mods/Noita40K/files/GUIDs.txt" )

-- strip the player
-- restore class functionality (run it all through vector_ctrl)
-- redo the sound banks to have proper uids
-- normalize and rebalance all the sounds
-- add randomness to several sounds
-- add multisounds
-- custom char sounds
-- regenerate uv_maps

-- add physics_hit as AP damage that will be considered as x5 with physical armour penetration
-- armor script is a single-function pen.armor() thing that does an on-hit function (add new table to penman to house all gameplay-first functionality)
-- phycisal armour patch that prevents phasing and projectiles sometimes disappear + sound and sparks play only if the speed is above certain level
-- check speed + angle for armour penetration
-- top 10% of armour should have rickoshet chance, the higher - the more

-- jumppack is an "item" (do a separate inventory space for equipment)
-- SpriteStainsComponent sprite_id for multisprite stains

-- chainsword should overheat while cutting through metal + permanently decrease physics_hit resistance
-- make chainsword be a chainsaw (exhaust, engine revving) but make it stop working underwater (requires several attempts while outside to restart)
-- chainsword projectiles lifetime is 2x of what it should be
-- rmb action should be obtained from controls comp Fire2

-- bolter rounds should be only effective against meat while rifle round should go through anything it instakills
-- all weapons scripts should run through index
-- add clanking sound for the last 25% of shots from the mag
-- add rickoshet angles (somehow bouncy orb and that extra bouncy shit have different angles)
-- fancy explosions with shockwave visualization through shaders (https://youtu.be/ypNJHZt2cX8), enemies hit with shockwaves should be briefly stunned if they don't have void-sealed status
-- turning around with heavy weapon resets it to point up
-- casings are being ejected at different speeds based on char facing

-- vector basic spell system rewrite (wand is the center part of the thing, player is optional)

---------------------------------------------------------------------------

-- nuke all old settings
-- add proper [liquid]/[gas]/[solid] tags to custom matters (cleanup matter list overall)
-- all the gui page tables to the separate lists.lua
-- MaterialSuckerComponent randomized_position for osculant device
-- emissive eyes with correct z (make trailing red eyes for rage modes; steal Alex's method of encoding?)
-- custom mnee frontend that ties all the mods together
-- remove vanilla map

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
-- ?clot and warpmatter ambient sound

function OnModInit()
	dofile_once( "mods/Noita40K/files/_lib.lua" )
	
	pen.lib.sprite_builder( "mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/1_ultramarine/player.xml" )

	--[[
	compatibility_patch()
	
	--Magic numbers
	local active_class = { ModSettingGetNextValue( "Noita40K.CURRENT_CLASS" ), ModSettingGetNextValue( "Noita40K.CURRENT_SKIN" ), }
	if( #class_info[active_class[1] ].skins > 0 ) then
		if( class_info[active_class[1] ].skins[active_class[2] ] == nil ) then
			active_class[2] = class_info[active_class[1] ].default_skin
			ModSettingSetNextValue( "Noita40K.CURRENT_SKIN", active_class[2], false )
		end
	else
		active_class[1] = 1
		active_class[2] = class_info[active_class[1] ].default_skin
		ModSettingSetNextValue( "Noita40K.CURRENT_CLASS", active_class[1], false )
		ModSettingSetNextValue( "Noita40K.CURRENT_SKIN", active_class[2], false )
	end
	ModMagicNumbersFileAdd( class_info[active_class[1] ].skins[active_class[2] ].custom_numbers or "mods/Noita40K/files/append/magic_numbers_generic.xml" )
	
	--Shaders
	local shader_old = "data/shaders/post_final.frag"
	local shader_custom_base = "mods/Noita40K/files/append/shader"
	
	local file = ModTextFileGetContent( shader_old )
	local uniform_marker = "// %-*\r\n// utilities"
	local function_marker = "// trip \"fractals\" effect. this is based on some code from ShaderToy, which I can't find anymore."
	local world_effect_marker = "#ifdef TRIPPY\r\n	// drunk doublevision"
	local overlay_marker = "// ============================================================================================================\r\n// additive overlay ==========================================================================================="
	file = string.gsub( file, uniform_marker, ModTextFileGetContent( shader_custom_base.."_uniforms.frag" ))
	file = string.gsub( file, function_marker, ModTextFileGetContent( shader_custom_base.."_functions.frag" ))
	file = string.gsub( file, world_effect_marker, ModTextFileGetContent( shader_custom_base.."_world_effects.frag" ))
	file = string.gsub( file, overlay_marker, ModTextFileGetContent( shader_custom_base.."_overlays.frag" ))
	ModTextFileSetContent( shader_old, file )
	
	--Herd relations
	local herd_relations_old = "data/genome_relations.csv"
	
	file = t2l( ModTextFileGetContent( herd_relations_old ))
	local _,count = string.gsub( file[1], ",", "" ) --vanilla is 35
	
	for i,herd in ipairs( herd_relations ) do
		file[1] = file[1]..","..herd.name
		for e = 2,( count + i ) do
			if( e < 37 ) then
				file[e] = file[e]..","..herd.vanilla_vertical[ e - 1 ]
			elseif( e > count - #herd_relations + i and herd.custom_vertical ~= nil ) then
				local value = herd.custom_vertical[ e - ( count + 1 ) ] or herd.default_value
				file[e] = file[e]..","..value
			else
				file[e] = file[e]..","..herd.default_value
			end
		end
		
		local new_line = herd.name
		for e = 1,( count + i ) do
			if( e < 36 ) then
				new_line = new_line..","..herd.vanilla_horizontal[e]
			elseif( e > count - #herd_relations and herd.custom_horizontal ~= nil ) then
				local value = herd.custom_horizontal[ e - count ] or herd.default_value
				new_line = new_line..","..value
			else
				new_line = new_line..","..herd.default_value
			end
		end
		table.insert( file, new_line )
	end
	
	local herd_relations_new = ""
	for i,line in ipairs( file ) do
		herd_relations_new = herd_relations_new..line.."\n"
	end
	ModTextFileSetContent( herd_relations_old, herd_relations_new )
	
	--Tags
	local orb_base = "data/entities/items/orbs/orb_base.xml"
	local teleport_base = "data/entities/buildings/teleport"
	
	file = ModTextFileGetContent( orb_base )
	ModTextFileSetContent( orb_base, string.gsub( file, "<Entity tags=\"hittable,teleportable_NOT,polymorphable_NOT\">", "<Entity tags=\"hittable,teleportable_NOT,polymorphable_NOT,orb\">" ))
	
	file = ModTextFileGetContent( teleport_base..".xml" )
	ModTextFileSetContent( teleport_base..".xml", string.gsub( file, "<Entity>", "<Entity tags=\"portal\">" ))
	
	file = ModTextFileGetContent( teleport_base.."_liquid_powered.xml" )
	ModTextFileSetContent( teleport_base.."_liquid_powered.xml", string.gsub( file, "<Entity>", "<Entity tags=\"portal\">" ))
	
	file = ModTextFileGetContent( teleport_base.."_ending.xml" )
	ModTextFileSetContent( teleport_base.."_ending.xml", string.gsub( file, "<Entity>", "<Entity tags=\"portal\">" ))
	
	file = ModTextFileGetContent( teleport_base.."_start.xml" )
	ModTextFileSetContent( teleport_base.."_start.xml", string.gsub( file, "<Entity>", "<Entity tags=\"portal\">" ))

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
	dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
	
	--Globals
	if( GlobalsGetValue( "MAG_SYSTEM_SHOT_THIS_FRAME", "" ) ~= "|" ) then
		GlobalsSetValue( "MAG_SYSTEM_SHOT_THIS_FRAME", "|" )
	end
	
	local blessed_uniform = tonumber( GlobalsGetValue( "BLESSED_EDGE_EFFECT", "" )) or 0
	if( blessed_uniform > 0 ) then
		set_shader( -1, "blessed_edge_effect", false, blessed_uniform )
		GlobalsSetValue( "BLESSED_EDGE_EFFECT", tostring( math.floor( blessed_uniform*0.95*100 )/100 ))
	end
	
	--Flags
	if( GameHasFlagRun( "poli_handling_time" )) then
		GameRemoveFlagRun( "poli_handling_time" )
	end
	
	if( GameHasFlagRun( "damage_was_prevented" )) then
		GameRemoveFlagRun( "damage_was_prevented" )
	end
	
	--Missing player
	local hooman = get_player()
	if( hooman == nil ) then
		set_shader( -1, "refractor_effect" )
		set_shader( -1, "living_shadow" )
		set_shader( -1, "black_rage" )
		set_shader( -1, "life_eater_edge_effect", true )
		set_shader( -1, "warpfire_edge_effect", true )
		set_shader( -1, "chogorian_edge_effect" )
		
		local cam_x, cam_y = GameGetCameraPos()
		local fucked_hooman = EntityGetClosestWithTag( cam_x, cam_y, "polymorphed" )
		if( fucked_hooman ~= nil ) then
			if( not( GameHasFlagRun( "hooman_was_polied" ))) then
				GameAddFlagRun( "hooman_was_polied" )
			end
			
			if( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( fucked_hooman, "ControlsComponent" ), "enabled" )) then
				local char_comp = EntityGetFirstComponentIncludingDisabled( fucked_hooman, "CharacterDataComponent" )
				if( ComponentGetValue2( char_comp, "fly_time_max" ) == 0 ) then
					ComponentSetValue2( char_comp, "fly_recharge_spd", 0.4 )
					ComponentSetValue2( char_comp, "fly_recharge_spd_ground", 6 )
					ComponentSetValue2( char_comp, "fly_time_max", 3 )
					ComponentSetValue2( char_comp, "flying_in_air_wait_frames", 38 )
				end
			end
		end
	else
		if( GameHasFlagRun( "hooman_was_polied" )) then
			GameAddFlagRun( "poli_handling_time" )
			GameRemoveFlagRun( "hooman_was_polied" )
		end
	end
end
]]

function OnPlayerSpawned( hooman )
	pen.strip_player( hooman )

	local pic_comp = EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "character" )
	ComponentSetValue2( pic_comp, "image_file",
		"mods/Noita40K/files/classes/1_adeptus_astartes/2_firstborn/1_ultramarine/player.xml" )
	ComponentSetValue2( pic_comp, "offset_x", 32 ); ComponentSetValue2( pic_comp, "offset_y", 44 )
	EntityRefreshSprite( hooman, pic_comp )

	local x, y = EntityGetTransform( hooman )
	EntityLoad( "mods/Noita40K/files/items/weapons/bolter_generic.xml", x, y )
	
	--[[
	local active_class = { ModSettingGetNextValue( "Noita40K.CURRENT_CLASS" ), ModSettingGetNextValue( "Noita40K.CURRENT_SKIN" ), }
	
	--Flags
	local initer = "N40K_READY_TO_PURGE"
	if GameHasFlagRun( initer ) then
		return
	end
	GameAddFlagRun( initer )
	
	--Misc
	EntityRemoveComponent( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "player_hat" ))
	EntityRemoveComponent( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "player_hat2_shadow" ))
	EntityRemoveComponent( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "player_amulet_gem" ))
	EntityRemoveComponent( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "lukki_enable" ))
	
	GlobalsSetValue( "ACTUAL_ACTIVE_CLASS", tostring( active_class[1] ))
	GlobalsSetValue( "ACTUAL_ACTIVE_SKIN", tostring( active_class[2] ))
	GameAddFlagRun( string.upper( class_info[active_class[1] ].class_name ).."_ACTIVE" )
	if( #class_info[active_class[1] ].skins > 0 ) then
		GameAddFlagRun( string.upper( class_info[active_class[1] ].skins[active_class[2] ].name ).."_SELECTED" )
	end
	
	--Quests
	local quest_info = DD_extractor( ModSettingGetNextValue( "Noita40K.QUEST_INFO" ), true ) or {}
	if( #quest_info > 0 ) then
		local actual_quest_info = {}
		for i,quest in ipairs( quest_info ) do
			if( quest[11] == "1" ) then
				table.insert( actual_quest_info, quest )
			end
		end
		
		local value = "|"
		if( #actual_quest_info > 0 ) then
			value = DD_packer( actual_quest_info )
		end
		ModSettingSetNextValue( "Noita40K.QUEST_INFO", value, false )
	end
	
	--Class/Skin setup
	EntityAddComponent( EntityGetWithName( "player_stats" ), "LuaComponent", 
	{ 
		_tags = "stats_controller",
		script_source_file = "mods/Noita40K/files/scripts/player/stats_controller.lua",
		execute_every_n_frame = "1",
	})
	
	local inventory = EntityGetWithName( "inventory_quick" )
	if inventory ~= nil then
		GameDestroyInventoryItems( hooman )
	end
	
	generic_stuff( hooman )
	magic_setuper( active_class, hooman, ModSettingGetNextValue( "Noita40K.ENABLE_CUSTOM_LOADOUT" ) and ( class_state( active_class[1], 3 ) or #class_info[active_class[1] ].skins < 1 ))
	
	--Utility bullshit
	local x, y = EntityGetTransform( hooman )

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
	
	-- GameCreateParticle( "exterminatus_gas", x + 50, y, 100, 0, 0, false )
	-- EntityLoad( "data/entities/animals/the_end/skygazer.xml", x - 300, y )
	-- EntityLoad( "data/entities/animals/scavenger_leader.xml", x - 50, y )
	-- EntityLoad( "data/entities/animals/drone_lasership.xml", x - 50, y )
	-- EntityLoad( "data/entities/animals/tank.xml", x - 50, y )
	-- EntityLoad( "data/entities/animals/scavenger_smg.xml", x - 50, y )
	-- CreateItemActionEntity( "POLLEN", x, y )
	-- perk_spawn( x + 40, y - 20, "ALWAYS_CAST" )
	
	-- ModSettingSetNextValue( "Noita40K.QUEST_INFO", "|", false )
	-- add_quest( hooman, "BEACON_HUNT", nil, nil, nil, nil, -500, 100, 10 )
	-- add_quest( hooman, "BEACON_HUNT_ITEM", nil, nil, nil, nil, -500, 100, 10 )
	-- add_quest( hooman, "KILLING_SPREE", nil, nil, nil, nil, 20, StatsGetValue( "enemies_killed" ))
	]]
end