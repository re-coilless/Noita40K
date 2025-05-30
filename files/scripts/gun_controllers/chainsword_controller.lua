dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local char_x, char_y = EntityGetTransform( hooman )
local w_x, w_y, w_rotation, w_scale_x, w_scale_y = EntityGetTransform( wand_id )
w_rotation = w_rotation - get_sign( w_scale_y )*math.rad( 90 )

local storage_state = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "chainedge_state" )
local state = ComponentGetValue2( storage_state, "value_bool" )

local sprite_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "SpriteComponent" )
local anim_active = "mods/Noita40K/files/pics/guns_gfx/chainsword_active.xml"
local anim_passive = "mods/Noita40K/files/pics/guns_gfx/chainsword_passive.xml"
local anim_current = ComponentGetValue2( sprite_comp, "image_file" )

local diameter = 18

if( beam_spot_id == nil or not( EntityGetIsAlive( beam_spot_id ))) then
	beam_spot_id = EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_spot.xml", w_x, w_y )
	EntityAddChild( wand_id, beam_spot_id )
end

if( state ) then
	if( anim_current ~= anim_active ) then
		ComponentSetValue2( sprite_comp, "image_file", anim_active )
		EntityRefreshSprite( wand_id, sprite_comp )
	end
	GameEntityPlaySoundLoop( wand_id, "chains_are_going", 1.0 )
	
	local barrel_x, barrel_y, b_rotation, b_scale_x, b_scale_y = EntityGetTransform( beam_spot_id )
	local end_x = barrel_x + math.cos( w_rotation )*diameter
	local end_y = barrel_y + math.sin( w_rotation )*diameter
	
	local blade_speed = 1000
	shoot_projectile_ultimate( hooman, "mods/Noita40K/files/entities/projectiles/beam_chainsword_physical.xml", end_x, end_y, -math.cos( w_rotation )*blade_speed, -math.sin( w_rotation )*blade_speed, false )
	
	local hit, hit_x, hit_y = RaytracePlatforms( barrel_x, barrel_y, end_x, end_y )
	
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
		local amount = math.ceil( lenght/2 )
		local delta_x = l_x/amount
		local delta_y = l_y/amount
		
		if( tmp_counter ~= 0 ) then
			tmp_counter = 0
		end
		
		local hit_action = function( hooman, deadman, k, beam_part_x, beam_part_y, hitbox_dmg_scale )
			if( GameGetGameEffect( hooman, "BERSERK" ) ~= 0 ) then
				hitbox_dmg_scale = hitbox_dmg_scale*3
			end
			
			if( EntityHasTag( deadman, "robot" ) or EntityHasTag( deadman, "heavy_armoured" )) then
				play_shielded_loop( wand_id, "slice_armor" )
				GameCreateParticle( "spark", beam_part_x, beam_part_y, 1*hitbox_dmg_scale, 150*math.sqrt( hitbox_dmg_scale ), 150*math.sqrt( hitbox_dmg_scale ), true )
				EntityInflictDamage( deadman, 0.02*hitbox_dmg_scale, "DAMAGE_PHYSICS_BODY_DAMAGED", "[RIP AND TEAR]", "NONE", 0, 0, hooman, beam_part_x, beam_part_y, 0 )
			else
				local damage_comp = EntityGetFirstComponentIncludingDisabled( deadman, "DamageModelComponent" )
				if( damage_comp ~= nil ) then
					local blood_matter = ComponentGetValue2( damage_comp, "blood_material" )
					if( blood_matter ~= "" and blood_matter ~= "-1" and blood_matter ~= nil ) then
						play_shielded_loop( wand_id, "slice_flesh" )
						GameCreateParticle( blood_matter, beam_part_x, beam_part_y, 5*hitbox_dmg_scale, 150*math.sqrt( hitbox_dmg_scale ), 150*math.sqrt( hitbox_dmg_scale ), true )
					end
				end
			
				local fx_type = "NONE"
				if( tmp_counter < 1 ) then
					tmp_counter = tmp_counter + 1
					fx_type = "BLOOD_SPRAY"
					hitbox_dmg_scale = hitbox_dmg_scale*5
				end
				EntityInflictDamage( deadman, 0.04*hitbox_dmg_scale, "DAMAGE_SLICE", "[RIP AND TEAR]", fx_type, 0, 0, hooman, beam_part_x, beam_part_y, 0 )
			end
		end
		
		local meat = get_killable_stuff( barrel_x + l_x/2, barrel_y + l_y/2, lenght/2 + 20 )
		if( #meat > 0 ) then
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( wand_id, "AudioLoopComponent", "slice_flesh" ), "volume_autofade_speed", 0.25 )
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( wand_id, "AudioLoopComponent", "slice_armor" ), "volume_autofade_speed", 0.25 )
			
			for e,deadman in ipairs( meat ) do
				if( hooman ~= deadman ) then
					beam_hitter( hooman, deadman, barrel_x, barrel_y, amount - 1, delta_x, delta_y, true, hit_action )
				end
			end
		end
	end
	
	ComponentSetValue2( storage_state, "value_bool", false )
elseif( anim_current ~= anim_passive ) then
	ComponentSetValue2( sprite_comp, "image_file", anim_passive )
	EntityRefreshSprite( wand_id, sprite_comp )
end