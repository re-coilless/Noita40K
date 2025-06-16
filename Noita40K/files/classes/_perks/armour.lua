return function( hooman )
	local char_x, char_y, char_r, char_scale_x, char_scale_y = EntityGetTransform( hooman )
end
--[[
SetRandomSeed( GameGetFrameNum(), char_x + char_y + hooman )

--extract this to penman

local radius = 50
local energy_left = 0.8

local velocity_buffer = 0.015

local projectiles = EntityGetInRadiusWithTag( char_x, char_y, radius, "projectile" ) or {}
if( #projectiles > 0 ) then
	local blessing_comp = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "emperors_blessing" )
	local EMBERORS_NUMBER = 0
	if( blessing_comp ~= nil ) then
		EMBERORS_NUMBER = Random( 1, ComponentGetValue2( blessing_comp, "value_int" ))
	end
	
	local armoring = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "armor_spec" ), "value_float" )
	
	local armor_right = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "armor_right" ), "value_int" )
	local armor_left = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "armor_left" ), "value_int" )
	local armor_up = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "armor_up" ), "value_int" )
	local armor_down = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "armor_down" ), "value_int" )
	
	for i,projectile_id in ipairs( projectiles ) do
		local proj_comp = EntityGetFirstComponentIncludingDisabled( projectile_id, "ProjectileComponent" )
		if( EntityGetRootEntity( hooman ) ~= ComponentGetValue2( proj_comp, "mWhoShot" ) and not( EntityHasTag( projectile_id, "armor_applied" ))) then
			local vel_comp = EntityGetFirstComponentIncludingDisabled( projectile_id, "VelocityComponent" )
			
			local proj_x, proj_y, proj_r, proj_s_x, proj_s_y = EntityGetTransform( projectile_id )
			local vel_x, vel_y = ComponentGetValue2( vel_comp, "mVelocity" )
			local char_vel_x, char_vel_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( EntityGetRootEntity( hooman ), "VelocityComponent" ), "mVelocity" )
			
			local hitbox_scaler_x = math.abs( vel_x - char_vel_x )*velocity_buffer
			local hitbox_scaler_y = math.abs( vel_y - char_vel_y )*velocity_buffer
			
			if( char_scale_x < 0 ) then
				local temp = armor_right
				armor_right = armor_left
				armor_left = temp
			end
			
			local hitbox_right = armor_right + hitbox_scaler_x
			local hitbox_left = armor_left + hitbox_scaler_x
			local hitbox_up = armor_up + hitbox_scaler_y
			local hitbox_down = armor_down + hitbox_scaler_y
			
			local present_check = ( proj_x <= ( char_x + hitbox_right )) and ( proj_x >= ( char_x - hitbox_left )) and ( proj_y <= ( char_y + hitbox_down )) and ( proj_y >= ( char_y - hitbox_up ))
			local future_check = (( proj_x + vel_x/60 ) <= ( char_x + hitbox_right )) and (( proj_x + vel_x/60 ) >= ( char_x - hitbox_left )) and (( proj_y + vel_y/60 ) <= ( char_y + hitbox_down )) and (( proj_y + vel_y/60 ) >= ( char_y - hitbox_up ))
			if( present_check or future_check ) then
				local proj_damage = ComponentGetValue2( proj_comp, "damage" )
				if( proj_damage <= armoring ) then
					if( proj_damage > 0 ) then
						ComponentSetValue2( proj_comp, "damage", 0 )
						proj_damage = 0
					end
				else
					ComponentSetValue2( proj_comp, "damage", proj_damage - armoring )
				end
				
				if( EMBERORS_NUMBER == 1 and proj_damage > 0 ) then
					GamePrint( "The Emperor Protects." )
					ComponentSetValue2( proj_comp, "damage", 0 )
					proj_damage = 0
					
					local p_hitbox_offset = get_head_offset( hooman ) - 4
					EntityLoad( "mods/Noita40K/files/entities/emitters/blessed_iron_halo.xml", char_x, char_y + p_hitbox_offset )
				end
				
				EntityAddTag( projectile_id, "armor_applied" )
				if( proj_damage == 0 and ( math.abs( vel_x ) > 5 or math.abs( vel_y ) > 5 )) then
					local new_vel_x = get_sign( vel_x )*math.max( math.abs( vel_x ), 0.0001 )
					local new_vel_y = get_sign( vel_y )*math.max( math.abs( vel_y ), 0.0001 )
					
					char_y = char_y - ( hitbox_up - hitbox_down )/2
					local a1 = ( hitbox_up + hitbox_down )/( hitbox_right + hitbox_left )
					local b1 = char_y - char_x*a1
					local a2 = -a1
					local b2 = char_y - char_x*a2
					
					local t_p_x = proj_x
					local t_p_y = proj_y
					if( not( future_check )) then
						t_p_x = t_p_x - new_vel_x
						t_p_y = t_p_y - new_vel_y
					end
					
					local future_buffer = 1
					local ap = new_vel_y/new_vel_x
					local bp = proj_y - proj_x*ap
					if((( t_p_y >= a1*t_p_x + b1 ) and ( t_p_y <= a2*t_p_x + b2 )) or (( t_p_y <= a1*t_p_x + b1 ) and ( t_p_y >= a2*t_p_x + b2 ))) then
						if( future_check ) then
							if( new_vel_x > 0 ) then 
								proj_x = char_x - ( armor_left + future_buffer )
							else
								proj_x = char_x + ( armor_right + future_buffer )
							end
							proj_y = ap*proj_x + bp
						end
						new_vel_x = -new_vel_x
					else
						if( future_check ) then
							if( new_vel_y > 0 ) then 
								proj_y = char_y - ( armor_up + future_buffer )
							else
								proj_y = char_y + ( armor_down + future_buffer )
							end
							proj_x = ( proj_y - bp )/ap
						end
						new_vel_y = -new_vel_y
					end
					
					if( future_check ) then
						EntitySetTransform( projectile_id, proj_x, proj_y, proj_r, proj_s_x, proj_s_y )
					end
					
					local how_many = 25*proj_damage + 10
					local rnd = Random( 1, 5 )
					GamePlaySound( "mods/Noita40K/files/40K.bank", "player/armor/ArmorHit"..rnd, proj_x, proj_y )
					GameCreateParticle( "spark", proj_x, proj_y, how_many, 150, 150, true )
					ComponentSetValueVector2( vel_comp, "mVelocity", energy_left*new_vel_x, energy_left*new_vel_y )
					ComponentObjectSetValue2( proj_comp, "config", "friendly_fire", true )
					ComponentSetValue2( proj_comp, "friendly_fire", true )
					ComponentSetValue2( proj_comp, "collide_with_shooter_frames", 0 )
					ComponentSetValue2( proj_comp, "mWhoShot", EntityGetRootEntity( hooman ))
				end
			end
		end
	end
end
]]