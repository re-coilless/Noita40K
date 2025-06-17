dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local w_x, w_y, w_rotation = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local delay_frame = ComponentGetValue2( abil_comp, "mNextFrameUsable" )
local frame_num = GameGetFrameNum()

local storage_overheated = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "overheated" )
local overheated = ComponentGetValue2( storage_overheated, "value_bool" )

local storage_state = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "plasma_state" )
local state = ComponentGetValue2( storage_state, "value_int" )
local is_state = n2b( state )

local storage_charge = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "current_charge" )
local current_charge = ComponentGetValue2( storage_charge, "value_int" )
local is_active = n2b( current_charge )

local max_charge = math.ceil( ComponentGetValue2( abil_comp, "mana_max" )/2 )

purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, true )

local speed = 1300

if( beam_spot_id == nil or not( EntityGetIsAlive( beam_spot_id ))) then
	beam_spot_id = EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_spot.xml", w_x, w_y )
	EntityAddChild( wand_id, beam_spot_id )
end

local barrel_x, barrel_y, b_rotation, b_scale_x, b_scale_y = EntityGetTransform( beam_spot_id )

if( ComponentGetValue2( abil_comp, "mana" ) < 5 ) then
	if( not( overheated )) then
		ComponentSetValue2( abil_comp, "mNextFrameUsable", frame_num + 300 )
		GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/reloads/overheat_start", w_x, w_y )
		ComponentSetValue2( storage_overheated, "value_bool", true )
	end
elseif( is_state ) then
	if( not( overheated )) then
		if( current_charge < max_charge ) then
			ComponentSetValue2( storage_charge, "value_int", current_charge + state )
			if( current_charge > state ) then
				GameEntityPlaySoundLoop( wand_id, "charge_is_going", 1.0 )
			end
		else
			is_state = false
		end
	end
end

if( is_active ) then
	local charge_percent = current_charge/max_charge
	local charge_stage = 0
	if( charge_percent < 0.3 ) then
		charge_stage = 0
	elseif( charge_percent < 0.5 ) then
		charge_stage = 1
	elseif( charge_percent < 0.7 ) then
		charge_stage = 2
	elseif( charge_percent < 0.9 ) then
		charge_stage = 3
	else
		charge_stage = 4
	end
	
	local vars = {
		{ "mods/n40ke_bss/files/entities/emitters/particles/plasma_0.xml", "mods/n40ke_bss/files/entities/emitters/muzzle_flash_plasma.xml", },
		{ 0, 32, "mods/n40ke_bss/files/entities/emitters/explosion_plasma_1.xml", "mods/n40ke_bss/files/pics/projectiles_gfx/plasma_bolt_1.xml", 3, "plasma_1", 0.2 },
		{ 1, 128, "mods/n40ke_bss/files/entities/emitters/explosion_plasma_2.xml", "mods/n40ke_bss/files/pics/projectiles_gfx/plasma_bolt_2.xml", 10, "plasma_2", 0.4 },
		{ 2, 200, "mods/n40ke_bss/files/entities/emitters/explosion_plasma_3.xml", "mods/n40ke_bss/files/pics/projectiles_gfx/plasma_bolt_3.xml", 20, "plasma_3", 0.4 },
		{ 3, 256, "mods/n40ke_bss/files/entities/emitters/explosion_plasma_4.xml", "mods/n40ke_bss/files/pics/projectiles_gfx/plasma_bolt_4.xml", 32, "plasma_4", 0.5 },
	}
	
	if( overheated ) then
		if( charge_stage > 0 ) then
			EntityLoad( vars[charge_stage + 1][3], barrel_x, barrel_y )
			GamePlaySound( "mods/n40ke_bss/files/sfx/n40ke_bss.bank", vars[charge_stage + 1][6].."/destroy", barrel_x, barrel_y )
		else
			EntityAddChild( wand_id, EntityLoad( vars[1][1], barrel_x, barrel_y ))
			GamePlaySound( "mods/n40ke_bss/files/sfx/n40ke_bss.bank", "vent", barrel_x, barrel_y )
		end
		ComponentSetValue2( storage_charge, "value_int", 0 )
	elseif( not( is_state )) then
		if( charge_stage > 0 ) then
			local v_x = math.cos( w_rotation )*( speed*charge_percent + 200 )
			local v_y = math.sin( w_rotation )*( speed*charge_percent + 200 )
			
			local custom_func = function( entity_id, values )
				local proj_comp = EntityGetFirstComponent( entity_id, "ProjectileComponent" )
				ComponentSetValue2( proj_comp, "camera_shake_when_shot", values[1] )
				ComponentSetValue2( proj_comp, "shoot_light_flash_radius", values[2] )
				ComponentSetValue2( proj_comp, "spawn_entity", values[3] )
				
				local pic_comp = EntityGetFirstComponent( entity_id, "SpriteComponent", "main" )
				ComponentSetValue2( pic_comp, "special_scale_x", values[7] )
				ComponentSetValue2( pic_comp, "special_scale_y", values[7] )
				ComponentSetValue2( pic_comp, "image_file", values[4] )
				EntityRefreshSprite( entity_id, pic_comp )
				
				local emit_comp = EntityGetFirstComponent( entity_id, "SpriteParticleEmitterComponent" )
				ComponentSetValueVector2( emit_comp, "scale", values[7]*1.5, values[7] )
				
				for i,comp in ipairs( EntityGetComponent( entity_id, "LightComponent" )) do
					ComponentSetValue2( comp, "radius", values[5] )
				end
				
				local x, y = EntityGetTransform( entity_id )
				GamePlaySound( "mods/n40ke_bss/files/sfx/n40ke_bss.bank", values[6].."/shoot", x, y )
			end
			
			shoot_projectile_ultimate( hooman, "mods/n40ke_bss/files/entities/projectiles/plasma_bolt_small.xml", barrel_x, barrel_y, v_x, v_y, true, custom_func, vars[charge_stage + 1] )
			
			local muzzle_flash = EntityLoad( vars[1][2], barrel_x, barrel_y )
			EntitySetTransform( muzzle_flash, barrel_x + math.cos( w_rotation )*5, barrel_y + math.sin( w_rotation )*5, b_rotation, b_scale_x, b_scale_y )
			EntityAddChild( wand_id, muzzle_flash )
		else
			EntityAddChild( wand_id, EntityLoad( vars[1][1], barrel_x, barrel_y ))
			GamePlaySound( "mods/n40ke_bss/files/sfx/n40ke_bss.bank", "vent", barrel_x, barrel_y )
		end
		ComponentSetValue2( storage_charge, "value_int", 0 )
	end
end

if( is_state ) then
	ComponentSetValue2( storage_state, "value_int", 0 )
end

if( overheated and delay_frame <= frame_num ) then
	GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/reloads/overheat_end", w_x, w_y )
	ComponentSetValue2( storage_overheated, "value_bool", false )
end