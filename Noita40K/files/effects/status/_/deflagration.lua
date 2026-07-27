dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )
local hb_x, hb_y = EntityGetFirstHitboxCenter( hooman )

local storage_scale = EntityGetFirstComponentIncludingDisabled( effect_id, "VariableStorageComponent", "scaled" )
local scaled = ComponentGetValue2( storage_scale, "value_bool" )
if( not( scaled )) then
	scale_emitter( hooman, EntityGetFirstComponentIncludingDisabled( effect_id, "ParticleEmitterComponent", "flames" ), true )
	scale_emitter( hooman, EntityGetFirstComponentIncludingDisabled( effect_id, "ParticleEmitterComponent", "fire" ), true )
	ComponentSetValue2( storage_scale, "value_bool", true )
end

local frames_left = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent" ), "frames" )
if( frames_left > 0 ) then
	if( not( EntityHasTag( effect_id, "fancy_burning" ))) then
		edit_component_ultimate( hooman, "DamageModelComponent", function(comp,vars)
			ComponentObjectSetValue2( comp, "damage_multipliers", "explosion", ComponentObjectGetValue2( comp, "damage_multipliers", "explosion" )*2 )
			ComponentObjectSetValue2( comp, "damage_multipliers", "fire", ComponentObjectGetValue2( comp, "damage_multipliers", "fire" )*2 )
			ComponentObjectSetValue2( comp, "damage_multipliers", "physics_hit", ComponentObjectGetValue2( comp, "damage_multipliers", "physics_hit" )*2 )
			ComponentObjectSetValue2( comp, "damage_multipliers", "projectile", ComponentObjectGetValue2( comp, "damage_multipliers", "projectile" )*2 )
		end)
		
		EntityAddTag( effect_id, "fancy_burning" )
	end
else
	edit_component_ultimate( hooman, "DamageModelComponent", function(comp,vars)
		ComponentObjectSetValue2( comp, "damage_multipliers", "explosion", ComponentObjectGetValue2( comp, "damage_multipliers", "explosion" )*0.5 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "fire", ComponentObjectGetValue2( comp, "damage_multipliers", "fire" )*0.5 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "physics_hit", ComponentObjectGetValue2( comp, "damage_multipliers", "physics_hit" )*0.5 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "projectile", ComponentObjectGetValue2( comp, "damage_multipliers", "projectile" )*0.5 )
	end)
	
	EntityKill( effect_id )
end

local dam_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
if( dam_comp ~= nil ) then
	ComponentSetValue2( dam_comp, "mFireFramesLeft", 600 )
	if( not( ComponentGetValue2( dam_comp, "is_on_fire" ))) then
		ComponentSetValue2( dam_comp, "is_on_fire", true )
	end
	
	local current_hp = ComponentGetValue2( dam_comp, "hp" )
	if( current_hp < 0.01 ) then
		EntityInflictDamage( hooman, 0.02, "DAMAGE_MATERIAL", "[BURN, HERETIC]", "NONE", 0, 0, nil, hb_x, hb_y, 0 )
	else
		ComponentSetValue2( dam_comp, "hp", current_hp*0.999 )
	end
end