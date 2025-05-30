dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )
local hb_x, hb_y = EntityGetFirstHitboxCenter( hooman )

if( GameGetGameEffect( hooman, "INTERNAL_FIRE" ) ~= 0 or GameGetGameEffect( hooman, "ON_FIRE" ) ~= 0 ) then
	set_shader( hooman, "life_eater_edge_effect", true )
	EntityLoad( "mods/Noita40K/files/entities/emitters/explosion_life_eater.xml", hb_x, hb_y )
	EntityKill( hooman )
end

local storage_scale = EntityGetFirstComponentIncludingDisabled( effect_id, "VariableStorageComponent", "scaled" )
local scaled = ComponentGetValue2( storage_scale, "value_bool" )
if( not( scaled )) then
	scale_emitter( hooman, EntityGetFirstComponentIncludingDisabled( effect_id, "ParticleEmitterComponent", "spores" ), true )
	ComponentSetValue2( storage_scale, "value_bool", true )
end

if( not( ModSettingGetNextValue( "Noita40K.DISABLE_SHADERS" ))) then
	set_shader( hooman, "life_eater_edge_effect", true, 1 )
end

local damage_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
if( damage_comp ~= nil ) then
	local current_hp = ComponentGetValue2( damage_comp, "hp" )
	if( current_hp > 0 ) then
		ComponentSetValue2( damage_comp, "hp", math.floor(( current_hp - 0.005 )*10000 )/10000 )
	else
		EntityLoad( "mods/Noita40K/files/entities/emitters/explosion_life_eater.xml", hb_x, hb_y )
		EntityKill( hooman )
	end
end