dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/mag_system.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local x, y = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
local LMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownFire" )

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local rate_delay = ComponentGetValue2( abil_comp, "mNextFrameUsable" )

local frame_num = GameGetFrameNum()

purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, false ) --Brother, this is heresy!

--semi auto limiter
if( LMB_down and rate_delay - frame_num == 1 ) then
	ComponentSetValue2( abil_comp, "mNextFrameUsable", rate_delay + 1 )
end

local mags = get_mags( wand_id )
mag_gui( wand_id, frame_num, mags ) --draws that fansy ammo counter in the corner
mag_reloader( wand_id, abil_comp, frame_num, ctrl_comp, mags ) --controls how mag update is handled
mag_controller( wand_id, abil_comp, frame_num, mags ) --controls how each shot is handled