dofile_once("mods/Noita40K/files/scripts/libs/black_library.lua")

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local w_x, w_y, w_rotation = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local current_mana = ComponentGetValue2( abil_comp, "mana" )
local delay_frame = ComponentGetValue2( abil_comp, "mNextFrameUsable" )
local frame_num = GameGetFrameNum()

local storage_overheated = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "overheated" )
local overheated = ComponentGetValue2( storage_overheated, "value_bool" )

local storage_state = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "las_state" )
local state = ComponentGetValue2( storage_state, "value_bool")

local diameter = 65
local max_angle = 0.265
local step = 10

purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, true )

if( beam_id == nil or not( EntityGetIsAlive( beam_id ))) then
	beam_id = EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_mitralock_visual.xml", w_x, w_y )
	EntityAddChild( wand_id, beam_id )
end

if( current_mana < 4+1 ) then
	if( not( overheated )) then
		ComponentSetValue2( abil_comp, "mNextFrameUsable", frame_num + 190 )
		GamePlaySound( "mods/Noita40K/files/40K.bank", "guns/reloads/overheat_start", w_x, w_y )
		ComponentSetValue2( storage_overheated, "value_bool", true )
	end
elseif( state and not( overheated )) then
	GameEntityPlaySoundLoop( wand_id, "mitralock_is_going", 1.0 )
	GameScreenshake( 1 )
	
	local rays = EntityGetAllChildren( beam_id )
	for i,ray in ipairs( rays ) do
		local storage_angle = EntityGetFirstComponentIncludingDisabled( ray, "VariableStorageComponent", "angle" )
		local angle = ComponentGetValue2( storage_angle, "value_int" ) + step
		
		if( angle >= 360 ) then
			angle = 0
		end
		ComponentSetValue2( storage_angle, "value_int", angle )
		
		local emit_comp = EntityGetFirstComponentIncludingDisabled( ray, "LaserEmitterComponent" )
		ComponentSetValue2( emit_comp, "emit_until_frame", frame_num + 1 )
		
		local current_angle = max_angle*math.cos( angle )
		ComponentSetValue2( emit_comp, "laser_angle_add_rad", current_angle )

		local r_x, r_y, r_rotation = EntityGetTransform( ray )
		local end_x = r_x + math.cos( r_rotation+current_angle )*diameter
		local end_y = r_y + math.sin( r_rotation+current_angle )*diameter
		
		local hit, hit_x, hit_y = RaytraceSurfacesAndLiquiform( r_x, r_y, end_x, end_y )
		
		local l_x = 0
		local l_y = 0
		local lenght = 0
		if( hit ) then
			l_x = hit_x - r_x
			l_y = hit_y - r_y
			lenght = math.sqrt(( l_x )^2 + ( l_y )^2 ) + 1
		else
			l_x = math.cos( w_rotation )*diameter
			l_y = math.sin( w_rotation )*diameter
			lenght = diameter
		end
		
		if( lenght > 0 ) then
			local meat = get_killable_stuff( r_x + l_x/2, r_y + l_y/2, lenght/2 + 5 )
		
			local amount = math.ceil( lenght/2 )
			local delta_x = l_x/amount
			local delta_y = l_y/amount
			
			local actual_deadman = 0
			local min_k = amount - 1
			local tmp1, tmp2 = 0,0
			if( #meat > 0 ) then
				for e,deadman in ipairs( meat ) do
					if( hooman ~= deadman ) then
						tmp1, tmp2 = beam_hitter( hooman, deadman, r_x, r_y, min_k, delta_x, delta_y, false )
						if( tmp1 ~= nil ) then
							actual_deadman = tmp1
							min_k = tmp2
						end
					end
				end
			end
			
			local filename = "mods/Noita40K/files/entities/projectiles/beam_mitralock_physical.xml"
			if( actual_deadman ~= 0 ) then
				local a_e_x, a_e_y = EntityGetTransform( actual_deadman )
			
				if( EntityHasTag( actual_deadman, "robot" )) then
					EntityInflictDamage( actual_deadman, 0.4, "DAMAGE_PHYSICS_HIT", "[t e c h n o h e r e s y]", "NONE", 0, 0, hooman, a_e_x, a_e_y, 0 )
				else
					EntityInflictDamage( actual_deadman, 0.04, "DAMAGE_PROJECTILE", "[BURN, HERETIC]", "NORMAL", 0, 0, hooman, a_e_x, a_e_y, 0 )
				end
				
				local final_length = math.sqrt(( a_e_x - r_x )^2 + ( a_e_y - r_y )^2)
				ComponentObjectSetValue2( emit_comp, "laser", "max_length", final_length )
				ComponentObjectSetValue2( emit_comp, "laser", "beam_particle_fade", 0 )
				
				EntityLoad( filename, a_e_x, a_e_y )
			else
				if( ComponentObjectGetValue2( emit_comp, "laser", "beam_particle_fade" ) == 0 ) then
					ComponentObjectSetValue2( emit_comp, "laser", "max_length", 75 )
					ComponentObjectSetValue2( emit_comp, "laser", "beam_particle_fade", 1 )
				end
			
				if( hit ) then
					EntityLoad( filename, hit_x, hit_y )
				else
					EntityLoad( filename, end_x, end_y )
				end
			end
		end
	end
end

if( state ) then
	ComponentSetValue2( storage_state, "value_bool", false )
end

if( overheated and delay_frame <= frame_num ) then
	GamePlaySound( "mods/Noita40K/files/40K.bank", "guns/reloads/overheat_end", w_x, w_y )
	ComponentSetValue2( storage_overheated, "value_bool", false )
end