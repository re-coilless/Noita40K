dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )
local hb_x, hb_y = EntityGetFirstHitboxCenter( hooman )

local storage_scale = EntityGetFirstComponentIncludingDisabled( effect_id, "VariableStorageComponent", "scaled" )
local scaled = ComponentGetValue2( storage_scale, "value_bool" )
if( not( scaled )) then
	scale_emitter( hooman, EntityGetFirstComponentIncludingDisabled( effect_id, "ParticleEmitterComponent", "promethium_fire" ), true )
	scale_emitter( hooman, EntityGetFirstComponentIncludingDisabled( effect_id, "ParticleEmitterComponent", "fire" ), true )
	ComponentSetValue2( storage_scale, "value_bool", true )
end

local meat = EntityGetInRadiusWithTag( hb_x, hb_y + get_head_offset( hooman )/2, 10, "mortal" ) or {}
if( #meat > 0 ) then
	for i,deadman in ipairs( meat ) do
		local dam_comp = EntityGetFirstComponentIncludingDisabled( deadman, "DamageModelComponent" )
		if( dam_comp ~= nil and not( ComponentGetValue2( dam_comp, "is_on_fire" )) and ComponentGetValue2( dam_comp, "fire_probability_of_ignition" ) > 0.001 ) then
			ComponentSetValue2( dam_comp, "mFireFramesLeft", 600 )
			ComponentSetValue2( dam_comp, "is_on_fire", true )
		end
	end
end

local dam_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
if( dam_comp ~= nil and ComponentGetValue2( dam_comp, "fire_probability_of_ignition" ) > 0.001 ) then
	ComponentSetValue2( dam_comp, "mFireFramesLeft", 600 )
	if( not( ComponentGetValue2( dam_comp, "is_on_fire" ))) then
		ComponentSetValue2( dam_comp, "is_on_fire", true )
	end
	
	local current_hp = ComponentGetValue2( dam_comp, "hp" )
	if( current_hp < 0.02 ) then
		EntityInflictDamage( hooman, 0.025, "DAMAGE_MATERIAL", "[BURN, HERETIC]", "NONE", 0, 0, nil, hb_x, hb_y, 0 )
	else
		ComponentSetValue2( dam_comp, "hp", current_hp - 0.01 )
	end
end