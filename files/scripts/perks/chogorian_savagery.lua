dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/taunts.lua" )

local hooman = GetUpdatedEntityID()

local time_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "chogorian_timer" )
local timer = ComponentGetValue2( time_storage, "value_int" )

kill_table = kill_table or {}
local frame_num = GameGetFrameNum()
local kill_count = tonumber( StatsGetValue( "enemies_killed" ))
local kps = kill_count - ( kill_table[frame_num%60 + 1] or tonumber( StatsGetValue( "enemies_killed" )))
local kpf = kill_count - ( kill_table[frame_num%60] or tonumber( StatsGetValue( "enemies_killed" )))
kill_table[frame_num%60 + 1] = kill_count

if( not( EntityHasTag( hooman, "chogorian_savagery" ))) then
	if( kps > 4 ) then
		EntityAddTag( hooman, "chogorian_savagery" )
		LoadGameEffectEntityTo( hooman, "mods/Noita40K/files/entities/status_effects/effect_moment_unrestrained.xml" )
		ComponentSetValue2( time_storage, "value_int", frame_num + 1800 )
		GameScreenshake( 5 )
	end
elseif( kpf > 0 ) then
	local effect_comp = EntityGetFirstComponentIncludingDisabled( get_custom_effect( hooman, "moment_unrestrained" ), "GameEffectComponent", "main" )
	ComponentSetValue2( effect_comp, "frames", ComponentGetValue2( effect_comp, "frames" ) + 300*kpf )
	ComponentSetValue2( time_storage, "value_int", frame_num + 1800 )
	GameScreenshake( 2 )
elseif( timer > 0 and frame_num > timer ) then
	local effect_comp = EntityGetFirstComponentIncludingDisabled( get_custom_effect( hooman, "moment_unrestrained" ), "GameEffectComponent", "main" )
	local frames_left = ComponentGetValue2( effect_comp, "frames" )
	if( frames_left > 5400 ) then
		ComponentSetValue2( effect_comp, "frames", 3600 )
		GameScreenshake( 3 )
		
		local storage_taunt = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "cooldown_taunt" )
		local taunt_frame = ComponentGetValue2( storage_taunt, "value_int" )
		if( taunt_frame <= frame_num ) then
			SetRandomSeed( GameGetFrameNum(), frames_left + hooman )
			local list = taunt_list[1][ GlobalsGetValue( "ACTUAL_ACTIVE_CLASS", "1" ).."-"..GlobalsGetValue( "ACTUAL_ACTIVE_SKIN", "1" ) ]
			if( #( list or {} ) > 0 and #( list[1] or {} ) > 0 ) then
				local rnd = Random( 1, #list[1] )
				local taunt = list[1][rnd]
				GameEntityPlaySound( hooman, taunt.sfx_path )
				ComponentSetValue2( storage_taunt, "value_int", frame_num + taunt.cooldown_frames )
			end
		end
	else
		ComponentSetValue2( time_storage, "value_int", 0 )
	end
end