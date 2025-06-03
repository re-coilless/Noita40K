dofile_once( "mods/Noita40K/files/scripts/libs/taunts.lua" )

local hooman = GetUpdatedEntityID()
local x, y = EntityGetTransform( hooman )

local storage_taunt = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "cooldown_taunt" )
local taunt_frame = ComponentGetValue2( storage_taunt, "value_int" )
local frame_num = GameGetFrameNum()
if( taunt_frame <= frame_num ) then
	SetRandomSeed( GameGetFrameNum(), x + y + hooman )
	local list = taunt_list[1][ GlobalsGetValue( "ACTUAL_ACTIVE_CLASS", "1" ).."-"..GlobalsGetValue( "ACTUAL_ACTIVE_SKIN", "1" ) ]
	if( #( list or {} ) > 0 and #( list[1] or {} ) > 0 ) then
		local rnd = Random( 1, #list[1] )
		local taunt = list[1][rnd]
		GameEntityPlaySound( hooman, taunt.sfx_path )
		ComponentSetValue2( storage_taunt, "value_int", frame_num + taunt.cooldown_frames )
	end
end

if( GlobalsGetValue( "MEMER", "0" ) == "0" ) then
	SetRandomSeed( GameGetFrameNum(), x + y + hooman )
	local rnd = Random( 1, 15 )
	GlobalsSetValue( "MEMER", rnd )
end
GameCreateSpriteForXFrames( "mods/Noita40K/files/pics/meme_gfx/"..GlobalsGetValue( "MEMER", "0" )..".png", x, y, true, 0, 0, 1 )

GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
GameTriggerMusicEvent( "fx/ultramar_anthem", false, x, y )
GameEntityPlaySoundLoop( hooman, "ultramar_anthem", 1.0 )