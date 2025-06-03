dofile_once("mods/Noita40K/files/scripts/libs/black_library.lua")

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local w_x, w_y, w_rotation = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local current_mana = ComponentGetValue2( abil_comp, "mana" )
local delay_frame = ComponentGetValue2( abil_comp, "mNextFrameUsable" )
local frame_num = GameGetFrameNum()

local storage_active = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "active" )
local active = ComponentGetValue2( storage_active, "value_bool" )

local storage_overheated = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "overheated" )
local overheated = ComponentGetValue2( storage_overheated, "value_bool" )

local storage_state = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "volkite_state" )
local state = ComponentGetValue2( storage_state, "value_bool" )

local diameter = 250

purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, true )

if( beam_id == nil or not( EntityGetIsAlive( beam_id ))) then
	beam_id = EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_volkite_visual.xml", w_x, w_y )
	EntityAddChild( wand_id, beam_id )
end

if( current_mana < 10+1 ) then
	if( not( overheated )) then
		ComponentSetValue2( abil_comp, "mNextFrameUsable", frame_num + 75 )
		GamePlaySound( "mods/Noita40K/files/40K.bank", "guns/reloads/overheat_start", w_x, w_y )
		ComponentSetValue2( storage_overheated, "value_bool", true )
	end
elseif( state and not( overheated )) then
	GameEntityPlaySoundLoop( wand_id, "volkite_is_going", 1.0 )
	
	local rays = EntityGetAllChildren( beam_id )
	for i,ray in ipairs( rays ) do
		local emit_comp = EntityGetFirstComponentIncludingDisabled( ray, "LaserEmitterComponent" )
		ComponentSetValue2( emit_comp, "emit_until_frame", frame_num + 1 )
	end

	local barrel_x, barrel_y = EntityGetTransform( beam_id )
	local end_x = barrel_x + math.cos( w_rotation )*diameter
	local end_y = barrel_y + math.sin( w_rotation )*diameter
	
	if( not( active )) then
		GameScreenshake( 3 )
		GamePlaySound( "mods/Noita40K/files/40K.bank", "projectiles/volkite/beam_start", w_x, w_y )
		ComponentSetValue2( storage_active, "value_bool", true )
	end
	
	local hit, hit_x, hit_y = RaytraceSurfacesAndLiquiform( barrel_x, barrel_y, end_x, end_y )
	
	local l_x = 0
	local l_y = 0
	local lenght = 0
	if( hit ) then
		l_x = hit_x - barrel_x
		l_y = hit_y - barrel_y
		lenght = math.sqrt(( l_x )^2 + ( l_y )^2 ) + 1
	else
		l_x = math.cos( w_rotation )*diameter
		l_y = math.sin( w_rotation )*diameter
		lenght = diameter
	end
	
	if( lenght > 0 ) then
		local meat = get_killable_stuff( barrel_x + l_x/2, barrel_y + l_y/2, lenght/2 + 5 )
		
		local amount = math.ceil( lenght/2 )
		local delta_x = l_x/amount
		local delta_y = l_y/amount
		
		local actual_deadman = 0
		local min_k = amount - 1
		local tmp1, tmp2 = 0,0
		if( #meat > 0 ) then
			for i,deadman in ipairs( meat ) do
				if( hooman ~= deadman ) then
					tmp1, tmp2 = beam_hitter( hooman, deadman, barrel_x, barrel_y, min_k, delta_x, delta_y, false )
					if( tmp1 ~= nil ) then
						actual_deadman = tmp1
						min_k = tmp2
					end
				end
			end
		end
		
		local filename = "mods/Noita40K/files/entities/projectiles/beam_volkite_physical.xml"
		if( actual_deadman ~= 0 ) then
			local a_e_x, a_e_y = EntityGetTransform( actual_deadman )
		
			local beam_damage = 1
			if( EntityHasTag( actual_deadman, "robot" ) or EntityHasTag( actual_deadman, "heavy_armoured" )) then
				beam_damage = beam_damage*0.02
			else
				beam_damage = beam_damage*0.5
				ComponentSetValue2( GetGameEffectLoadTo( actual_deadman, "EXPLODING_CORPSE", true ), "frames", 2 )
			end
			
			local effect_id = get_custom_effect( actual_deadman, "fancy_burning" )
			if( effect_id ~= nil ) then
				local effect_comp = EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent" )
				ComponentSetValue2( effect_comp, "frames", ComponentGetValue2( effect_comp, "frames" ) + 5 )
			else
				LoadGameEffectEntityTo( actual_deadman, "mods/Noita40K/files/entities/status_effects/effect_fancy_burning.xml" )
			end
			
			local max_mana = ComponentGetValue2( abil_comp, "mana_max" )
			EntityInflictDamage( actual_deadman, beam_damage*(max_mana/current_mana), "DAMAGE_EXPLOSION", "[BURN, HERETIC]", "NORMAL", 0, 0, hooman, a_e_x, a_e_y, 0 )
			
			local final_length = math.sqrt(( a_e_x - barrel_x )^2 + ( a_e_y - barrel_y )^2)
			for i,ray in ipairs( rays ) do
				local emit_comp = EntityGetFirstComponentIncludingDisabled( ray, "LaserEmitterComponent" )
				ComponentObjectSetValue2( emit_comp, "laser", "max_length", final_length )
				ComponentObjectSetValue2( emit_comp, "laser", "beam_particle_fade", 0 )
			end
			
			EntityLoad( filename, a_e_x, a_e_y )
		else
			for i,ray in ipairs( rays ) do
				local emit_comp = EntityGetFirstComponentIncludingDisabled( ray, "LaserEmitterComponent" )
				if( ComponentObjectGetValue2( emit_comp, "laser", "beam_particle_fade" ) == 1 ) then
					break
				end
				
				ComponentObjectSetValue2( emit_comp, "laser", "max_length", 250 )
				ComponentObjectSetValue2( emit_comp, "laser", "beam_particle_fade", 1 )
			end
			
			if( hit ) then
				EntityLoad( filename, hit_x, hit_y )
			else
				EntityLoad( filename, end_x, end_y )
			end
		end
	end
else
	ComponentSetValue2( storage_active, "value_bool", false )
end

if( state ) then
	ComponentSetValue2( storage_state, "value_bool", false )
end

if( overheated and delay_frame <= frame_num ) then
	GamePlaySound( "mods/Noita40K/files/40K.bank", "guns/reloads/overheat_end", w_x, w_y )
	ComponentSetValue2( storage_overheated, "value_bool", false )
end