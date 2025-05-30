dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/taunts.lua" )

local hooman = GetUpdatedEntityID()

local adrenalin = get_threat_level( hooman, false )
if( not( ModSettingGetNextValue( "Noita40K.DISABLE_SHADERS" ))) then
	set_shader( hooman, "chogorian_edge_effect", false, math.min( adrenalin, 1500 )/666 )
end

if( not( EntityHasTag( hooman, "black_rage" )) and adrenalin > 1000 ) then
	EntityAddTag( hooman, "black_rage" )
	LoadGameEffectEntityTo( hooman, "mods/Noita40K/files/entities/status_effects/effect_black_rage.xml" )
	
	local storage_taunt = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "cooldown_taunt" )
	local taunt_frame = ComponentGetValue2( storage_taunt, "value_int" )
	local frame_num = GameGetFrameNum()
	if( taunt_frame <= frame_num ) then
		SetRandomSeed( GameGetFrameNum(), adrenalin + hooman )
		local list = taunt_list[2][ GlobalsGetValue( "ACTUAL_ACTIVE_CLASS", "1" ).."-"..GlobalsGetValue( "ACTUAL_ACTIVE_SKIN", "1" ) ]
		if( #( list or {} ) > 0 and #( list[1] or {} ) > 0 ) then
			local rnd = Random( 1, #list[1] )
			local taunt = list[1][rnd]
			GameEntityPlaySound( hooman, taunt.sfx_path )
			ComponentSetValue2( storage_taunt, "value_int", frame_num + taunt.cooldown_frames )
		end
	end
	
	GameScreenshake( 10 )
end