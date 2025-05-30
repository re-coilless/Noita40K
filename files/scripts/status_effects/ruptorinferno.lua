dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )

local storage_scale = EntityGetFirstComponentIncludingDisabled( effect_id, "VariableStorageComponent", "scaled" )
local scaled = ComponentGetValue2( storage_scale, "value_bool" )

if( not( scaled )) then
	scale_emitter( hooman, EntityGetFirstComponentIncludingDisabled( effect_id, "ParticleEmitterComponent", "ruptorinferno" ), true )
	ComponentSetValue2( storage_scale, "value_bool", true )
end

local damage_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
if( damage_comp ~= nil ) then
	local max_hp = ComponentGetValue2( damage_comp, "max_hp" )
	local current_hp = ComponentGetValue2( damage_comp, "hp" )
	if( current_hp < max_hp*0.9 ) then
		ComponentSetValue2( damage_comp, "hp", math.floor(( current_hp + 0.001 )*10000 )/10000 )
	end
end