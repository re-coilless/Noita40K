dofile_once( "mods/mnee/lib.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/taunts.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local w_x, w_y = EntityGetTransform( wand_id )

local storage_taunt = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "cooldown_taunt" )
local taunt_frame = ComponentGetValue2( storage_taunt, "value_int" )
local frame_num = GameGetFrameNum()

if( mnee.mnin( "bind", { "Noita40K", "taunt" }, { pressed = true, dirty = true }) and not( EntityHasTag( hooman, "twin_linked" ))) then
	if( taunt_frame <= frame_num ) then
		SetRandomSeed( GameGetFrameNum(), w_x + w_y + hooman )
		local list = taunt_list[ ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "taunt_type" ), "value_int" ) ][ GlobalsGetValue( "ACTUAL_ACTIVE_CLASS", "1" ).."-"..GlobalsGetValue( "ACTUAL_ACTIVE_SKIN", "1" ) ]
		if( #( list or {} ) > 0 and #( list[1] or {} ) > 0 ) then
			local rnd = Random( 1, #list[1] )
			local taunt = list[1][rnd]
			GameEntityPlaySound( hooman, taunt.sfx_path )
			ComponentSetValue2( storage_taunt, "value_int", frame_num + taunt.cooldown_frames )
			
			if( list[2] ~= nil ) then
				list[2]( hooman, wand_id, rnd )
			end
		end
	end
end