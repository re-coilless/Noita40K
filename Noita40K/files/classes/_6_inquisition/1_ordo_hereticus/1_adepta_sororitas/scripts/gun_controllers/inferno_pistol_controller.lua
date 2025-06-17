dofile_once("mods/Noita40K/files/scripts/libs/black_library.lua")

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local w_x, w_y, w_rotation = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local delay_frame = ComponentGetValue2( abil_comp, "mNextFrameUsable" )
local frame_num = GameGetFrameNum()

local storage_overheated = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "overheated" )
local overheated = ComponentGetValue2( storage_overheated, "value_bool" )

local storage_state = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "melta_state" )
local state = ComponentGetValue2( storage_state, "value_bool")

local diameter = 35
local full_power = 0.5

purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, true )

if( beam_id == nil or not( EntityGetIsAlive( beam_id ))) then
	beam_id = EntityLoad( "mods/n40ke_bss/files/entities/projectiles/beam_inferno_pistol_visual.xml", w_x, w_y )
	EntityAddChild( wand_id, beam_id )
end

if( ComponentGetValue2( abil_comp, "mana" ) < 5 ) then
	if( not( overheated )) then
		ComponentSetValue2( abil_comp, "mNextFrameUsable", frame_num+300 )
		GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/reloads/overheat_start", w_x, w_y )
		ComponentSetValue2( storage_overheated, "value_bool", true )
	end
elseif( state and not( overheated )) then
	GameEntityPlaySoundLoop( wand_id, "melta_is_going", 1.0 )
	
	local rays = EntityGetAllChildren( beam_id )
	for i,ray in ipairs( rays ) do
		local emit_comp = EntityGetFirstComponentIncludingDisabled( ray, "LaserEmitterComponent" )
		ComponentSetValue2( emit_comp, "emit_until_frame", frame_num + 1 )
	end
	
	local barrel_x, barrel_y = EntityGetTransform( beam_id )
	local end_x = barrel_x + math.cos( w_rotation )*diameter
	local end_y = barrel_y + math.sin( w_rotation )*diameter
	
	local hit, hit_x, hit_y = RaytracePlatforms( barrel_x, barrel_y, end_x, end_y )
	
	local l_x = math.cos( w_rotation )*diameter
	local l_y = math.sin( w_rotation )*diameter
	local lenght = diameter
	if( hit ) then
		l_x = get_sign( l_x )*( math.max( math.abs( hit_x - barrel_x ), math.abs( l_x*full_power )) + math.cos( w_rotation )*5 )
		l_y = get_sign( l_y )*( math.max( math.abs( hit_y - barrel_y ), math.abs( l_y*full_power )) + math.sin( w_rotation )*5 )
		lenght = math.sqrt(( l_x )^2 + ( l_y )^2 ) + 1
	end
	
	if( lenght > 0 ) then
		local amount = math.ceil( lenght/2 )
		local delta_x = l_x/amount
		local delta_y = l_y/amount
		
		for m = 0,amount - 1 do
			local beam_eater_x = barrel_x + delta_x*m
			local beam_eater_y = barrel_y + delta_y*m
			
			EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_combimelta_physical.xml", beam_eater_x, beam_eater_y )
		end
		
		local shielded_sound_checker = true
		local hit_action = function( hooman, deadman, k, beam_part_x, beam_part_y, hitbox_dmg_scale )
			shielded_sound_checker = play_shielded_sound( shielded_sound_checker, w_x, w_y, "guns/burst" )
			play_shielded_loop( wand_id, "melting_flesh" )
			EntityInflictDamage( deadman, 0.2*hitbox_dmg_scale, "DAMAGE_MATERIAL", "[BURN, HERETIC]", "NORMAL", 0, 0, hooman, beam_part_x, beam_part_y, 0 )
		end
		
		local meat = get_killable_stuff( barrel_x + l_x/2, barrel_y + l_y/2, lenght/2 + 20 )
		if( #meat > 0 ) then
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( wand_id, "AudioLoopComponent", "melting_flesh" ), "volume_autofade_speed", 0.25 )
			
			for e,deadman in ipairs( meat ) do
				if( hooman ~= deadman ) then
					beam_hitter( hooman, deadman, barrel_x, barrel_y, amount - 1, delta_x, delta_y, true, hit_action )
				end
			end
		end
	end
end

if( state ) then
	ComponentSetValue2( storage_state, "value_bool", false )
end

if( overheated and delay_frame <= frame_num ) then
	GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/reloads/overheat_end", w_x, w_y )
	ComponentSetValue2( storage_overheated, "value_bool", false )
end