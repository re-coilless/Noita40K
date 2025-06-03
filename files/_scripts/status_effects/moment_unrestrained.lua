dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )

local frames_left = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent", "main" ), "frames" )
if( not( ModSettingGetNextValue( "Noita40K.DISABLE_SHADERS" ))) then
	set_shader( hooman, "chogorian_edge_effect", false, frames_left/3000 )
end

if( frames_left > 0 and GameGetGameEffect( hooman, "CHARM" ) == 0 ) then
	if( frames_left > 3600 ) then
		GameEntityPlaySoundLoop( effect_id, "is_going", 1.0 )
	end

	if( not( EntityHasTag( effect_id, "moment_unrestrained" ))) then
		local kick_comp = EntityGetFirstComponentIncludingDisabled( hooman, "KickComponent" )
		ComponentSetValue2( kick_comp, "max_force", ComponentGetValue2( kick_comp, "max_force" )*2 )
		ComponentSetValue2( kick_comp, "player_kickforce", ComponentGetValue2( kick_comp, "player_kickforce" )*1.5 )
		ComponentSetValue2( kick_comp, "kick_damage", ComponentGetValue2( kick_comp, "kick_damage" )*3 )
		ComponentSetValue2( kick_comp, "kick_knockback", ComponentGetValue2( kick_comp, "kick_knockback" )*2 )
		
		EntityAddTag( effect_id, "moment_unrestrained" )
	end
else
	local kick_comp = EntityGetFirstComponentIncludingDisabled( hooman, "KickComponent" )
	ComponentSetValue2( kick_comp, "max_force", ComponentGetValue2( kick_comp, "max_force" )/2 )
	ComponentSetValue2( kick_comp, "player_kickforce", ComponentGetValue2( kick_comp, "player_kickforce" )/1.5 )
	ComponentSetValue2( kick_comp, "kick_damage", ComponentGetValue2( kick_comp, "kick_damage" )/3 )
	ComponentSetValue2( kick_comp, "kick_knockback", ComponentGetValue2( kick_comp, "kick_knockback" )/2 )
	
	set_shader( hooman, "chogorian_edge_effect" )
	EntityRemoveTag( hooman, "chogorian_savagery" )
	EntityKill( effect_id )
end

local frame_num = GameGetFrameNum()
twitchy_cooldown = twitchy_cooldown or frame_num
if( frame_num > twitchy_cooldown ) then
	local w_x, w_y = EntityGetTransform( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "Inventory2Component" ), "mActiveItem" ))
	local m_x, m_y = DEBUG_GetMouseWorld()
	local target_id = EntityGetClosestWithTag( m_x, m_y, "enemy" ) or 0
	if( target_id ~= 0 ) then
		local t_x, t_y = EntityGetTransform( target_id )
		local dist = math.sqrt(( t_x - m_x )^2 + ( t_y - m_y )^2 )
		if( not( RaytracePlatforms( w_x, w_y, t_x, t_y + get_head_offset( target_id ))) and dist < 10 ) then
			SetRandomSeed( GameGetFrameNum(), frames_left )
			twitchy_cooldown = frame_num + Random( 10, 30 )
			
			local shoot_comp = EntityGetFirstComponentIncludingDisabled( hooman, "PlatformShooterPlayerComponent" )
			if( shoot_comp ~= nil ) then
				ComponentSetValue2( shoot_comp, "mForceFireOnNextUpdate", true )
			end
		end
	end
end