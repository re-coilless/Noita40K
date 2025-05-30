dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )
local hb_x, hb_y = EntityGetFirstHitboxCenter( hooman )

local storage_hollow = EntityGetFirstComponentIncludingDisabled( effect_id, "VariableStorageComponent", "hollow" )
local status = ComponentGetValue2( storage_hollow, "value_bool" )

local storage_scale = EntityGetFirstComponentIncludingDisabled( effect_id, "VariableStorageComponent", "scaled" )
local scaled = ComponentGetValue2( storage_scale, "value_bool" )

local damage_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
local current_hp = ComponentGetValue2( damage_comp, "hp" )
local max_hp = ComponentGetValue2( damage_comp, "max_hp" )

local radius = 10

if( effect_id == hooman ) then
	EntityKill( effect_id )
end

function curse( char_x, char_y, c_radius )
	local meat = EntityGetInRadiusWithTag( char_x, char_y, c_radius, "mortal" ) or {}
	if( #meat > 0 ) then
		for i,deadman in ipairs( meat ) do
			local dam_comp = EntityGetFirstComponentIncludingDisabled( deadman, "DamageModelComponent" )
			if( not( EntityHasTag( deadman, "corrupted" )) and dam_comp ~= nil and is_sentient( deadman )) then
				EntityAddTag( deadman, "corrupted" )
				LoadGameEffectEntityTo( deadman, "mods/Noita40K/files/entities/status_effects/effect_warpfire.xml" )
			end
		end
	end
end

if( not( ModSettingGetNextValue( "Noita40K.DISABLE_SHADERS" ))) then
	set_shader( hooman, "warpfire_edge_effect", true, 1 )
end

if( not( scaled )) then
	GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/status_effects/warpfire_start", hb_x, hb_y )
	scale_emitter( hooman, EntityGetFirstComponentIncludingDisabled( effect_id, "ParticleEmitterComponent", "warpfire" ), true )
	ComponentSetValue2( storage_scale, "value_bool", true )
end

local immunity_supreme = GameGetGameEffect( hooman, "PROTECTION_ALL" )
if( immunity_supreme ~= 0 and ComponentGetValue2( immunity_supreme, "effect" ) ~= "NONE" ) then
	ComponentSetValue2( immunity_supreme, "effect", "NONE" )
end
local immunity_poly = GameGetGameEffect( hooman, "PROTECTION_POLYMORPH" )
if( immunity_poly ~= 0 and ComponentGetValue2( immunity_poly, "effect" ) ~= "NONE" ) then
	ComponentSetValue2( immunity_poly, "effect", "NONE" )
end
local immunity_damage = GameGetGameEffect( hooman, "SAVING_GRACE" )
if( immunity_damage ~= 0 and ComponentGetValue2( immunity_damage, "effect" ) ~= "NONE" ) then
	ComponentSetValue2( immunity_damage, "effect", "NONE" )
end
local immunity_death = GameGetGameEffect( hooman, "RESPAWN" )
if( immunity_death ~= 0 and ComponentGetValue2( immunity_death, "effect" ) ~= "NONE" ) then
	ComponentSetValue2( immunity_death, "effect", "NONE" )
end

if( status ) then
	if( max_hp == current_hp ) then
		curse( hb_x, hb_y, radius*4 )
		set_shader( hooman, "warpfire_edge_effect", true )
		EntityLoad( "mods/Noita40K/files/entities/emitters/explosion_warpfire.xml", hb_x, hb_y )
		EntityKill( effect_id )
	else
		ComponentSetValue2( damage_comp, "max_hp", max_hp*0.80 )
	end
else
	if( current_hp <= max_hp*0.01 ) then
		ComponentSetValue2( storage_hollow, "value_bool", true )
	else
		ComponentSetValue2( damage_comp, "hp", current_hp*0.90 )
	end
end

curse( hb_x, hb_y, radius )