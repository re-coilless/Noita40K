dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/mag_system.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local x, y = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
local RMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownRightClick" )

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local frame_num = GameGetFrameNum()

purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, false )

local mags = get_mags( wand_id )
mag_gui( wand_id, frame_num, mags )
mag_reloader( wand_id, abil_comp, frame_num, ctrl_comp, mags )
mag_controller( wand_id, abil_comp, frame_num, mags )

if( RMB_down and not( EntityHasTag( hooman, "twin_linked" ))) then
	local shooter_comp = EntityGetFirstComponentIncludingDisabled( hooman, "PlatformShooterPlayerComponent" )
	local c_x, c_y = GameGetCameraPos()
	local a_x, a_y = ComponentGetValue2( ctrl_comp, "mAimingVectorNormalized" )
	a_x = get_sign( a_x )*math.max( math.abs( a_x ), 0.2 )
	local t_x = x + a_x*100*( 0.5 + 1.5*math.abs( a_x ))
	local t_y = y + a_y*100
	local speed = 0.2
	ComponentSetValueVector2( shooter_comp, "mDesiredCameraPos", c_x + speed*( t_x - c_x ), c_y + speed*( t_y - c_y ))
end