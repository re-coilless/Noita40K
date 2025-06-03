dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/mag_system.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local x, y = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local frame_num = GameGetFrameNum()

purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, false )

local mags = get_mags( wand_id )
mag_gui( wand_id, frame_num, mags )
mag_reloader( wand_id, abil_comp, frame_num, ctrl_comp, mags )
mag_controller( wand_id, abil_comp, frame_num, mags )

kill_count = { ( frame_num - ( kill_count or { 0, 0, } )[2]) > 2 and tonumber( StatsGetValue( "enemies_killed" )) or kill_count[1], frame_num }
local kill_current = tonumber( StatsGetValue( "enemies_killed" ))
if( kill_count[1] ~= kill_current ) then
	local damage_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
	local hp = ComponentGetValue2( damage_comp, "hp" )
	local max_hp = ComponentGetValue2( damage_comp, "max_hp" )
	if( hp/max_hp < 0.1 ) then
		ComponentSetValue2( damage_comp, "hp", hp + 0.01*( max_hp - hp ))
	end
	
	local effect_id = get_custom_effect( hooman, "black_rage" )
	if( effect_id ~= nil ) then
		local effect_comp = EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent", "main" )
		local frames_left = ComponentGetValue2( effect_comp, "frames" )
		if( frames_left > 0 ) then
			local new_frames = frames_left - 300*( kill_current - kill_count[1] )
			ComponentSetValue2( effect_comp, "frames", math.max( new_frames, 0 ))
			
			GameCreateParticle( "blood", x, y, 10, 0, 0, false )
		end
	end
	
	kill_count[1] = kill_current
end