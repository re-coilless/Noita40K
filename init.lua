ModLuaFileAppend( "data/scripts/gun/gun.lua", "mods/Noita40K/files/append/custom_gun.lua" ) -- do better
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Noita40K/files/append/actions.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/Noita40K/files/append/perks.lua" )
ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/Noita40K/files/append/extra_modifiers.lua" )
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Noita40K/files/append/status_effects.lua" )
ModLuaFileAppend( "data/scripts/biomes/boss_victoryroom.lua", "mods/Noita40K/files/append/custom_exterminatus_work.lua" ) -- do better
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Noita40K/files/append/custom_entrance.lua" ) -- do better
ModLuaFileAppend( "data/scripts/biomes/lavalake.lua", "mods/Noita40K/files/append/custom_lavalake_corpse.lua" ) -- do better
ModLuaFileAppend( "data/scripts/magic/fungal_shift.lua", "mods/Noita40K/files/append/custom_fungal_shift.lua" )
ModMaterialsFileAdd( "mods/Noita40K/files/append/matters.xml" )
ModRegisterAudioEventMappings( "mods/Noita40K/files/sfx/GUIDs.txt" )

dofile_once( "data/scripts/lib/utilities.lua" )
dofile_once( "data/scripts/perks/perk.lua" )

function OnModInit()
	dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
	dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )
	
	compatibility_patch()
	
	--Magic numbers
	local active_class = { ModSettingGetNextValue( "Noita40K.CURRENT_CLASS" ), ModSettingGetNextValue( "Noita40K.CURRENT_SKIN" ), }
	if( #class_info[active_class[1]].skins > 0 ) then
		if( class_info[active_class[1]].skins[active_class[2]] == nil ) then
			active_class[2] = class_info[active_class[1]].default_skin
			ModSettingSetNextValue( "Noita40K.CURRENT_SKIN", active_class[2], false )
		end
	else
		active_class[1] = 1
		active_class[2] = class_info[active_class[1]].default_skin
		ModSettingSetNextValue( "Noita40K.CURRENT_CLASS", active_class[1], false )
		ModSettingSetNextValue( "Noita40K.CURRENT_SKIN", active_class[2], false )
	end
	ModMagicNumbersFileAdd( class_info[active_class[1]].skins[active_class[2]].custom_numbers or "mods/Noita40K/files/append/magic_numbers_generic.xml" )
	
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
end

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

function OnPlayerSpawned( hooman )
	dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
	dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )
	dofile_once( "mods/Noita40K/files/scripts/libs/classer_lib.lua" )
	dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )
	
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
	GameAddFlagRun( string.upper( class_info[active_class[1]].class_name ).."_ACTIVE" )
	if( #class_info[active_class[1]].skins > 0 ) then
		GameAddFlagRun( string.upper( class_info[active_class[1]].skins[active_class[2]].name ).."_SELECTED" )
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
	magic_setuper( active_class, hooman, ModSettingGetNextValue( "Noita40K.ENABLE_CUSTOM_LOADOUT" ) and ( class_state( active_class[1], 3 ) or #class_info[active_class[1]].skins < 1 ))
	
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
			file = "mods/Noita40K/files/sfx/40K.bank",
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
end

--[[
He who dwells in the shelter of
   the Emperor
Will abide in the shadow of
  the God of Mankind.

I will say to the Emperor, "My
   refuge and my fortress,
My God, in whom I trust!"

For it is He who delivers you
  from the lies of the heretic,
And from the deadly pestilence.

He will cover you with his
  armor,
And under His Throne may you
  may seek refuge;
His faithfulness is a shield
  and bulwark.

You will not be afraid of the
  terror by night,
Or of the arrow that flies by
  day;
Of the corruption that stalks
  in darkness.

A thousand may fall at your
  side,
And ten thousand at your
  right hand;
But it shall not approach you.

You will only look on with
  your eyes,
And see the recompense of
  the wicked.

For you have made the Emperor,
  our refuge,
Even the Golden Throne, your
  dwelling place.

No evil will befall you,
Nor will any mutation come
  near your dwelling.

For He will give His Astartes
  charge concerning you,
To guard you in all your ways.

They will bear you up in their
  hands,
Lest you stumble or stray.

You will tread upon the alien
  and mutant,
The heretic and traitor
  you will trample down.
]]--