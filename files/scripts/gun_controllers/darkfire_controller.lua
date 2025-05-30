dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local w_x, w_y, w_rotation = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local current_mana = ComponentGetValue2( abil_comp, "mana" )
local reload_frame = ComponentGetValue2( abil_comp, "mReloadNextFrameUsable" )
local frame_num = GameGetFrameNum()

local storage_empty = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "empty" )
local empty = ComponentGetValue2( storage_empty, "value_bool" )
local storage_state = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "darkfire_state" )
local state = ComponentGetValue2( storage_state, "value_bool" )

local diameter = 500

purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, true )

if( beam_spot_id == nil or not( EntityGetIsAlive( beam_spot_id ))) then
	beam_spot_id = EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_spot.xml", w_x, w_y )
	EntityAddChild( wand_id, beam_spot_id )
end

if( state ) then
	local barrel_x, barrel_y, b_rotation, b_scale_x, b_scale_y = EntityGetTransform( beam_spot_id )
	local end_x = barrel_x + math.cos( w_rotation )*diameter
	local end_y = barrel_y + math.sin( w_rotation )*diameter
	
	local beam_id = EntityLoad( "mods/Noita40K/files/entities/emitters/beam_darkfire_visual.xml", barrel_x, barrel_y )
	EntitySetTransform( beam_id, barrel_x, barrel_y, w_rotation, b_scale_x, b_scale_y )
	GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "projectiles/darkfire/beam_start", barrel_x, barrel_y )
	GameScreenshake( 6 )
	
	local l_x = math.cos( w_rotation )*diameter
	local l_y = math.sin( w_rotation )*diameter
	local lenght = diameter
	
	for i = 1,2 do
		local amount = math.ceil( lenght/2 )
		local delta_x = l_x/amount
		local delta_y = l_y/amount
		
		for m = 0,amount-1 do
			local beam_corr_x = barrel_x + delta_x*m
			local beam_corr_y = barrel_y + delta_y*m
			
			if( i == 1 ) then
				EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_darkfire_eater.xml", beam_corr_x, beam_corr_y )
				EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_darkfire_eater.xml", beam_corr_x + delta_x/2, beam_corr_y + delta_y/2 )
			elseif( i == 2 ) then
				EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_darkfire_corruptor.xml", beam_corr_x, beam_corr_y )
			end
		end
		
		local hit_action = function( hooman, deadman, k, beam_part_x, beam_part_y, hitbox_dmg_scale )
			EntityInflictDamage( deadman, 1*hitbox_dmg_scale, "DAMAGE_MATERIAL", "[BURN, HERETIC]", "BLOOD_EXPLOSION", 0, 0, hooman, beam_part_x, beam_part_y, 0 )
			local damage_comp = EntityGetFirstComponentIncludingDisabled( deadman, "DamageModelComponent" )
			if( not( EntityHasTag( deadman, "corrupted" )) and EntityGetIsAlive( deadman ) and damage_comp ~= nil and is_sentient( deadman )) then
				EntityAddTag( deadman, "corrupted" )
				LoadGameEffectEntityTo( deadman, "mods/Noita40K/files/entities/status_effects/effect_warpfire.xml" )
			end
		end
		
		local meat = get_killable_stuff( barrel_x + l_x/2, barrel_y + l_y/2, lenght/2 + 5 )
		if( #meat > 0 ) then
			for e,deadman in ipairs( meat ) do
				if( hooman ~= deadman ) then
					beam_hitter( hooman, deadman, barrel_x, barrel_y, amount - 1, delta_x, delta_y, true, hit_action )
				end
			end
		end
	end
	
	ComponentSetValue2( storage_state, "value_bool", false )
end

if( empty and reload_frame < frame_num ) then
	GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/reloads/darkfire_reload_end", w_x, w_y )
	ComponentSetValue2( storage_empty, "value_bool", false )
elseif( reload_frame > frame_num and not( empty )) then
	ComponentSetValue2( storage_empty, "value_bool", true )
end