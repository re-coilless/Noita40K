dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/mag_system.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local x, y, rotation, scale_x, scale_y = EntityGetTransform( wand_id )

local frame_num = GameGetFrameNum()

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local rate_delay = ComponentGetValue2( abil_comp, "mNextFrameUsable" )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
local LMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownFire" )

purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, false )

local offset_x = 21+11
local radius = offset_x

local trig_x = math.cos( rotation )*radius*scale_x
local trig_y = math.sin( rotation )*radius*scale_x

local total_x = x + trig_x
local total_y = y + trig_y

if( bayonet_id == nil or not( EntityGetIsAlive( bayonet_id ))) then
	bayonet_id = EntityLoad( "mods/Noita40K/files/entities/misc/rifle_bayonet.xml", x, y )
	EntityAddChild( wand_id, bayonet_id )
end

EntitySetTransform( bayonet_id, total_x, total_y, rotation, scale_x, scale_y )

if( LMB_down and rate_delay - frame_num == 1 ) then
	ComponentSetValue2( abil_comp, "mNextFrameUsable", rate_delay + 1 )
end

local mags = get_mags( wand_id )
mag_gui( wand_id, frame_num, mags )
mag_reloader( wand_id, abil_comp, frame_num, ctrl_comp, mags )
mag_controller( wand_id, abil_comp, frame_num, mags )