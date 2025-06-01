dofile_once( "mods/mnee/lib.lua" )

local emitter = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( emitter )

local storage_ignited = EntityGetFirstComponentIncludingDisabled( emitter, "VariableStorageComponent", "jumppack_ignited" )
local storage_overheat = EntityGetFirstComponentIncludingDisabled( emitter, "VariableStorageComponent", "jumppack_overheat" )
local storage_hover = EntityGetFirstComponentIncludingDisabled( emitter, "VariableStorageComponent", "jumppack_hovering" )
local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
local is_ignited = ComponentGetValue2( storage_ignited, "value_bool" )
local is_overheat = ComponentGetValue2( storage_overheat, "value_bool" )
local is_hovering = ComponentGetValue2( storage_hover, "value_bool" )
local ignite_combo = mnee.mnin( "bind", { "Noita40K", "jumppack" }, { dirty = true })
local hover_combo = ComponentGetValue2( ctrl_comp, "mButtonDownDown" )

local ui_mode_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "explorator_mode" )
if( ui_mode_storage ~= nil ) then
	if( ComponentGetValue2( ui_mode_storage, "value_bool" )) then
		ignite_combo = false
	end
end

local JUMPPACK_SPEED = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( emitter, "VariableStorageComponent", "jumppack_speed" ), "value_int" )
local JUMPPACK_BURNING_RATE = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( emitter, "VariableStorageComponent", "jumppack_rate" ), "value_float" )

local char_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterDataComponent" )
local dmg_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
local fuel = ComponentGetValue2( char_comp, "mFlyingTimeLeft" )
hover_combo = hover_combo and not( ComponentGetValue2( char_comp, "is_on_ground" ) or ComponentGetValue2( dmg_comp, "mAirAreWeInWater" )) and fuel > 0

if( fuel < JUMPPACK_BURNING_RATE and is_ignited ) then
	ComponentSetValue2( storage_overheat, "value_bool", true )
	is_overheat = true
elseif( not( ignite_combo ) and is_overheat and fuel > 5*JUMPPACK_BURNING_RATE ) then
	ComponentSetValue2( storage_overheat, "value_bool", false )
end

if( ignite_combo and not( is_overheat )) then
	local char_x, char_y = EntityGetTransform( hooman )
	
	local init_velocity_x, init_velocity_y = ComponentGetValue2( char_comp, "mVelocity" )
	local aiming_x, aiming_y = ComponentGetValue2( ctrl_comp, "mAimingVector" )
	local angle = 0 - math.atan2( aiming_y, aiming_x )
	
	local delta_vel_x = math.cos( angle )*JUMPPACK_SPEED
	local delta_vel_y = math.sin( angle )*JUMPPACK_SPEED
	
	if( not( is_ignited )) then	
		local radius = 10
		local emit_delta_angle = math.rad( 40 )*5
		local emit_delta_vel = 5
		
		SetRandomSeed( GameGetFrameNum(), char_x + char_y + hooman )
		local rnd_amount = Random( 10, 15 ) + 50
		
		if( math.abs( delta_vel_x ) < math.abs( delta_vel_y )) then
			delta_vel_x = ( delta_vel_x + 10 )*10
		else
			delta_vel_y = ( delta_vel_y + 10 )*10
		end
		
		for i = 1,rnd_amount do
			local rnd_x = Random( -emit_delta_vel, emit_delta_vel )
			local rnd_y = Random( -emit_delta_vel, emit_delta_vel )
			
			local angle_rnd = angle + Random( -emit_delta_angle, emit_delta_angle )/5
			
			local emit_x = char_x - math.cos( angle_rnd )*radius
			local emit_y = ( char_y - 10 ) + math.sin( angle_rnd )*radius
			
			GameCreateParticle( "fire", emit_x, emit_y, 1, rnd_y - delta_vel_y, rnd_x - delta_vel_x, false )
		end
		
		GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "player/jumppack/ignition", char_x, char_y )
		ComponentSetValue2( storage_ignited, "value_bool", true )
		EntitySetComponentsWithTagEnabled( emitter, "jet", true )
	end
	
	ComponentSetValueVector2( char_comp, "mVelocity", init_velocity_x + delta_vel_x, init_velocity_y - delta_vel_y )
	ComponentSetValue2( char_comp, "mFlyingTimeLeft", fuel - JUMPPACK_BURNING_RATE )
	
	EntitySetTransform( emitter, char_x, char_y, -angle + math.rad( 90 ), 1, 1 )
	
	GameEntityPlaySoundLoop( hooman, "sound_jetpack", 1.0 )
elseif( is_ignited ) then
	EntitySetComponentsWithTagEnabled( emitter, "jet", false )
	ComponentSetValue2( storage_ignited, "value_bool", false )
end

if( hover_combo and EntityHasTag( emitter, "hover_enabled" ) and GameGetFrameNum()%3 == 0 ) then
	local gravity = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "CharacterPlatformingComponent" ), "pixel_gravity" )/60
	local v_x, v_y = ComponentGetValue2( char_comp, "mVelocity" )
	local final_v_x, final_v_y = v_x, math.min( -gravity*0.01, v_y )
	
	local a_down = ComponentGetValue2( ctrl_comp, "mButtonDownLeft" )
	if( a_down ) then
		final_v_x = final_v_x - JUMPPACK_SPEED*0.6
	end
	local d_down = ComponentGetValue2( ctrl_comp, "mButtonDownRight" )
	if( d_down ) then
		final_v_x = final_v_x + JUMPPACK_SPEED*0.6
	end
	
	ComponentSetValueVector2( char_comp, "mVelocity", final_v_x, final_v_y )
	ComponentSetValue2( char_comp, "mFlyingTimeLeft", fuel - JUMPPACK_BURNING_RATE/6 )
	GameEntityPlaySoundLoop( hooman, "sound_jetpack", 1.0 )
	
	if( not( is_hovering )) then
		EntitySetComponentsWithTagEnabled( hooman, "jetpack", true )
		ComponentSetValue2( storage_hover, "value_bool", true )
	end
elseif( is_hovering ) then
	EntitySetComponentsWithTagEnabled( hooman, "jetpack", false )
	ComponentSetValue2( storage_hover, "value_bool", false )
end