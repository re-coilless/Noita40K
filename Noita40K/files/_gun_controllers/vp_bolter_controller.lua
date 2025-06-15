dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/mag_system.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local w_x, w_y, x_r, w_s_x, w_s_y = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local frame_num = GameGetFrameNum()

local aura_r_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "ParticleEmitterComponent", "aura_right" )
local aura_l_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "ParticleEmitterComponent", "aura_left" )
if( w_s_y > 0 ) then
	if( not( ComponentHasTag( aura_r_comp, "active" ))) then
		ComponentRemoveTag( aura_l_comp, "enabled_in_world" )
		ComponentRemoveTag( aura_l_comp, "enabled_in_hand" )
		ComponentRemoveTag( aura_l_comp, "active" )
		EntitySetComponentIsEnabled( wand_id, aura_l_comp, false )
		ComponentAddTag( aura_r_comp, "enabled_in_world" )
		ComponentAddTag( aura_r_comp, "enabled_in_hand" )
		ComponentAddTag( aura_r_comp, "active" )
		EntitySetComponentIsEnabled( wand_id, aura_r_comp, true )
	end
elseif( not( ComponentHasTag( aura_l_comp, "active" ))) then
	ComponentRemoveTag( aura_r_comp, "enabled_in_world" )
	ComponentRemoveTag( aura_r_comp, "enabled_in_hand" )
	ComponentRemoveTag( aura_r_comp, "active" )
	EntitySetComponentIsEnabled( wand_id, aura_r_comp, false )
	ComponentAddTag( aura_l_comp, "enabled_in_world" )
	ComponentAddTag( aura_l_comp, "enabled_in_hand" )
	ComponentAddTag( aura_l_comp, "active" )
	EntitySetComponentIsEnabled( wand_id, aura_l_comp, true )
end

local mags = get_mags( wand_id )
mag_gui( wand_id, frame_num, mags )
mag_reloader( wand_id, abil_comp, frame_num, ctrl_comp, mags )
mag_controller( wand_id, abil_comp, frame_num, mags )
if( not( EntityHasTag( hooman, "twin_linked" ))) then
	mag_switcher( wand_id, ctrl_comp, mags )
end