dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )

local frames_comp = EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent", "main" )
local frames_left = ComponentGetValue2( frames_comp, "frames" )

local adrenalin = get_threat_level( hooman, false )
if( frames_left < 0 ) then
	if( adrenalin < 1000 ) then
		ComponentSetValue2( frames_comp, "frames", 6000 )
	end
elseif( frames_left ~= 0 ) then
	if( adrenalin > 1000 ) then
		ComponentSetValue2( frames_comp, "frames", -1 )
	end
end

if( math.abs( frames_left ) > 600 or frames_left < 0 ) then
	GameEntityPlaySoundLoop( effect_id, "is_going", 1.0 )
end

if( not( ModSettingGetNextValue( "Noita40K.DISABLE_SHADERS" ))) then
	set_shader( hooman, "black_rage", false, ( frames_left > 0 ) and frames_left/6000 or 1 )
end

if( math.abs( frames_left ) > 0 and GameGetGameEffect( hooman, "CHARM" ) == 0 ) then
	if( not( EntityHasTag( effect_id, "black_rage" ))) then
		local kick_comp = EntityGetFirstComponentIncludingDisabled( hooman, "KickComponent" )
		ComponentSetValue2( kick_comp, "max_force", ComponentGetValue2( kick_comp, "max_force" )*2 )
		ComponentSetValue2( kick_comp, "player_kickforce", ComponentGetValue2( kick_comp, "player_kickforce" )*1.5 )
		ComponentSetValue2( kick_comp, "kick_damage", ComponentGetValue2( kick_comp, "kick_damage" )*5 )
		ComponentSetValue2( kick_comp, "kick_knockback", ComponentGetValue2( kick_comp, "kick_knockback" )*2 )
		ComponentSetValue2( kick_comp, "kick_radius", ComponentGetValue2( kick_comp, "kick_radius" )*2 )
		
		local dmg_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
		ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "drill", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "drill" )/2 )
		ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "explosion", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "explosion" )/2 )
		ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "melee", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "melee" )/2 )
		ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "projectile", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "projectile" )/2 )
		ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "slice", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "slice" )/2 )
		
		local plat_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterPlatformingComponent" )
		ComponentSetValue2( plat_comp, "run_velocity", ComponentGetValue2( plat_comp, "run_velocity" )*2 )
		ComponentSetValue2( plat_comp, "fly_velocity_x", ComponentGetValue2( plat_comp, "fly_velocity_x" )*5 )
		ComponentSetValue2( plat_comp, "velocity_max_x", ComponentGetValue2( plat_comp, "velocity_max_x" )*2 )
		ComponentSetValue2( plat_comp, "velocity_min_x", ComponentGetValue2( plat_comp, "velocity_min_x" )*2 )
		
		EntityAddTag( effect_id, "black_rage" )
	end
else
	local kick_comp = EntityGetFirstComponentIncludingDisabled( hooman, "KickComponent" )
	ComponentSetValue2( kick_comp, "max_force", ComponentGetValue2( kick_comp, "max_force" )/2 )
	ComponentSetValue2( kick_comp, "player_kickforce", ComponentGetValue2( kick_comp, "player_kickforce" )/1.5 )
	ComponentSetValue2( kick_comp, "kick_damage", ComponentGetValue2( kick_comp, "kick_damage" )/5 )
	ComponentSetValue2( kick_comp, "kick_knockback", ComponentGetValue2( kick_comp, "kick_knockback" )/2 )
	ComponentSetValue2( kick_comp, "kick_radius", ComponentGetValue2( kick_comp, "kick_radius" )/2 )
	
	local dmg_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
	ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "drill", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "drill" )*2 )
	ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "explosion", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "explosion" )*2 )
	ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "melee", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "melee" )*2 )
	ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "projectile", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "projectile" )*2 )
	ComponentObjectSetValue2( dmg_comp, "damage_multipliers", "slice", ComponentObjectGetValue2( dmg_comp, "damage_multipliers", "slice" )*2 )
	
	local plat_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterPlatformingComponent" )
	ComponentSetValue2( plat_comp, "run_velocity", ComponentGetValue2( plat_comp, "run_velocity" )/2 )
	ComponentSetValue2( plat_comp, "fly_velocity_x", ComponentGetValue2( plat_comp, "fly_velocity_x" )/5 )
	ComponentSetValue2( plat_comp, "velocity_max_x", ComponentGetValue2( plat_comp, "velocity_max_x" )/2 )
	ComponentSetValue2( plat_comp, "velocity_min_x", ComponentGetValue2( plat_comp, "velocity_min_x" )/2 )
	
	set_shader( hooman, "chogorian_edge_effect" )
	set_shader( hooman, "black_rage" )
	EntityRemoveTag( hooman, "black_rage" )
	EntityKill( effect_id )
end

local frame_num = GameGetFrameNum()
twitchy_cooldown = twitchy_cooldown or frame_num
if( frame_num > twitchy_cooldown ) then
	SetRandomSeed( GameGetFrameNum(), frames_left )
	twitchy_cooldown = frame_num + Random( 1, 20 )
	
	local shoot_comp = EntityGetFirstComponentIncludingDisabled( hooman, "PlatformShooterPlayerComponent" )
	if( shoot_comp ~= nil ) then
		ComponentSetValue2( shoot_comp, "mForceFireOnNextUpdate", true )
	end
end