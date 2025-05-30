dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local hooman = GetUpdatedEntityID()
local char_x, char_y = EntityGetFirstHitboxCenter( hooman )

local storage_energy_cap = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "energy_cap" )
local storage_energy_cur = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "energy_cur" )
local storage_state = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "refractor_online" )
local energy_cap = ComponentGetValue2( storage_energy_cap, "value_float" )
local energy_cur = ComponentGetValue2( storage_energy_cur, "value_float" )
local is_online = ComponentGetValue2( storage_state, "value_bool" )

local radius = 30
local visuals = ModSettingGetNextValue( "Noita40K.REFRACTOR_VISUALS" )
if( energy_cur > 0 and energy_cur <= energy_cap ) then
	if( not( is_online )) then
		GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "player/refractor_field/on", char_x, char_y )
		ComponentSetValue2( storage_state, "value_bool", true )
	end
	
	local is_hit = false
	local projectiles = EntityGetInRadiusWithTag( char_x, char_y, radius, "projectile" ) or {}
	if( #projectiles > 0 ) then
		for i,projectile_id in ipairs( projectiles ) do
			local proj_comp = EntityGetFirstComponentIncludingDisabled( projectile_id, "ProjectileComponent" )
			if( hooman ~= ComponentGetValue2( proj_comp, "mWhoShot" )) then
				local proj_x, proj_y = EntityGetTransform( projectile_id )
				local proj_damage = ComponentGetValue2( proj_comp, "damage" )*25
				local hidden = RaytracePlatforms( char_x, char_y, proj_x, proj_y )
				
				if( not( hidden ) and proj_damage <= energy_cur ) then
					local dam_per = ( proj_damage + 1 )/29.0
					GameCreateParticle( "plasma_unstable", proj_x, proj_y, 5*math.ceil( 10*dam_per ), 150, 150, true )
					is_hit = true
					
					EntityKill( projectile_id )
					GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "player/refractor_field/refraction", proj_x, proj_y )
					
					ComponentSetValue2( storage_energy_cur, "value_float", energy_cur - math.abs( proj_damage ))
				end
			end
		end
	end
	
	if( visuals ) then
		local gui = GuiCreate()
		GuiStartFrame( gui )
		local w, h = GuiGetScreenDimensions( gui )
		GuiDestroy( gui )
		
		local shit_from_ass = w/( MagicNumbersGetValue( "VIRTUAL_RESOLUTION_X" ) + MagicNumbersGetValue( "VIRTUAL_RESOLUTION_OFFSET_X" ))
		local c_x, c_y = GameGetCameraPos()
		
		local shader_x = ( w/2 + shit_from_ass*( char_x - c_x ))/w
		local shader_y = ( h/2 - shit_from_ass*( char_y - c_y ))/h
		set_shader( hooman, "refractor_effect", false, shader_x, shader_y, is_hit and 50 or 25, is_hit and 3.5 or 1 )
	else
		set_shader( hooman, "refractor_effect" )
	end
else
	if( is_online ) then
		GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "player/refractor_field/off", char_x, char_y )
		ComponentSetValue2( storage_state, "value_bool", false )
	end
	
	if( visuals ) then
		set_shader( hooman, "refractor_effect" )
	end
end