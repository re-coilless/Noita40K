dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local hooman = GetUpdatedEntityID()
local is_enabled = ( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "dendrites_active" ), "value_bool" ) and not( EntityHasTag( hooman, "system_overload" )))
if( is_enabled ) then
	local gravity = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "CharacterPlatformingComponent" ), "pixel_gravity" )/60
	local v_x, v_y = GameGetVelocityCompVelocity( hooman )
	local final_v_x, final_v_y = 0, -gravity
	
	local c_x, c_y, c_r, c_s_x, c_s_y = EntityGetTransform( hooman )
	c_y = c_y + get_head_offset( hooman )/2
	local d = 10
	local d_rad = 5
	
	if( GameHasFlagRun( "poli_handling_time" )) then
		dendrites = nil
	end
	
	if( dendrites == nil or EntityGetFirstComponentIncludingDisabled( dendrites[1], "VariableStorageComponent", "is_going" ) == nil ) then
		dendrites = {}
		
		local children = EntityGetAllChildren( hooman ) or {}
		if( #children > 0 ) then
			for i,dendrite in ipairs( children ) do
				if( EntityHasTag( dendrite, "dendrite_walking" )) then
					table.insert( dendrites, dendrite )
				end
			end
		end
	end
	
	anchor_spots = anchor_spots or {{ 0, 0 }, { 0, 0 }, { 0, 0 }}
	function f( a, b, num )
		for i,spot in ipairs( anchor_spots ) do
			if( i ~= num ) then
				if( spot[1] == a and spot[2] == b ) then
					return false
				end
			end
		end
		return true
	end
	
	local angle = math.rad( -90 )
	local r_x, r_y = 0, 0
	local t_x, t_y = 0, 0
	local connected = false
	local check = false
	local v = math.sqrt( v_x^2 + v_y^2 )
	local v_angle = math.atan2( v_y, v_x )
	local d_angle = math.rad( 360/( #dendrites*2*d ))
	local step_count = 360/( #dendrites*math.deg( d_angle )) + 2
	for i,dendrite in ipairs( dendrites ) do
		ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "AudioLoopComponent", "wriggling" ), "volume_autofade_speed", 0.25 )
		
		local state_storage = EntityGetFirstComponentIncludingDisabled( dendrite, "VariableStorageComponent", "is_going" )
		if( not( ComponentGetValue2( state_storage, "value_bool" ))) then
			local children = EntityGetAllChildren( dendrite ) or {}
			if( #children > 0 ) then
				for e,d_module in ipairs( children ) do
					if( EntityHasTag( d_module, "final_part" )) then
						local с_angle = 0
						r_x, r_y, с_angle = EntityGetTransform( d_module )
						t_x = r_x + math.cos( с_angle )*d_rad
						t_y = r_y + math.sin( с_angle )*d_rad
						break
					end
				end
			end
			
			check, t_x, t_y = RaytracePlatforms( c_x, c_y, t_x, t_y )
			if( check ) then
				t_y = t_y + ( 1 - get_sign( c_y - t_y ))/2
				check = false
				connected = true
				if( math.sqrt(( t_x - r_x )^2 + ( t_y - r_y )^2 ) > d_rad ) then
					r_x = t_x
					r_y = t_y
				else
					check = true
				end
			else
				local switch = get_sign( -angle*v_x )
				local delta = 0.7*( get_sign( v_angle )*( math.abs( v_angle ) - ( 1 - get_sign( angle - v_angle ))*( 1 - get_sign( v_angle )*get_sign( angle ))*math.rad( 90 )) - angle ) --i mean
				local drift = delta*v*0.5
				if( math.abs( drift ) > math.abs( delta )) then
					drift = delta
				end
				local temp_angle = angle + drift + switch*d_angle
				-- GameCreateSpriteForXFrames( "mods/Noita40K/files/pics/gui_gfx/fillers/filler_solid_white.png", c_x + math.cos( temp_angle )*50, c_y + math.sin( temp_angle )*50, true, 0, 0, 1, true )
				local radius = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( dendrite, "VariableStorageComponent", "full_length" ), "value_float" )
				local similarity_prevention = false
				local sp_x, sp_y = 0, 0
				check = true
				for e = 1,step_count do
					local tmp = math.abs( math.floor( math.deg( temp_angle ) + 0.5 ))%360
					if( tmp ~= 0 and tmp ~= 90 and tmp ~= 180 ) then
						r_x = math.floor( c_x + math.cos( temp_angle )*radius )
						r_y = math.floor( c_y + math.sin( temp_angle )*radius )
						-- GameCreateSpriteForXFrames( "mods/Noita40K/files/pics/gui_gfx/mark_capture_corner.png", r_x, r_y, true, 0, 0, 1, true )
						local gotit = true
						gotit, t_x, t_y = RaytracePlatforms( c_x, c_y, r_x, r_y )
						if( gotit ) then
							if( f( t_x, t_y, i )) then
								if( similarity_prevention ) then
									sp_x = t_x
									sp_y = t_y
								else
									r_x = t_x
									r_y = t_y
									check = false
									break
								end
							else
								similarity_prevention = true
							end
						end
					end
					
					temp_angle = temp_angle + switch*d_angle
					if( switch*( temp_angle ) > switch*( angle + drift + switch*d_angle*( d + ( 1 - switch )/2 ))) then
						temp_angle = angle + drift
						switch = -switch
					end
				end
				
				if( check ) then
					r_x = 0
					r_y = 0
					check = false
				elseif( similarity_prevention ) then
					r_x = sp_x
					r_y = sp_y
					similarity_prevention = false
				end
			end
			
			if( not( check )) then
				ComponentSetValue2( state_storage, "value_bool", true )
				ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( dendrite, "VariableStorageComponent", "target_x" ), "value_float", r_x )
				ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( dendrite, "VariableStorageComponent", "target_y" ), "value_float", r_y )
				anchor_spots[i][1] = r_x
				anchor_spots[i][2] = r_y
			end
		elseif( ModSettingGetNextValue( "Noita40K.DENDRITES_SOUND" )) then
			play_shielded_loop( hooman, "wriggling" )
		end
		angle = angle + math.rad( 360/#dendrites )
	end
	
	if( connected ) then
		local total_speed = 150
		local vertical_killer = 0.9
	
		local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
		local char_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterDataComponent" )
		local w_down = ComponentGetValue2( ctrl_comp, "mButtonDownUp" )
		if( w_down ) then
			final_v_y = final_v_y - total_speed*vertical_killer
		end
		local a_down = ComponentGetValue2( ctrl_comp, "mButtonDownLeft" )
		if( a_down ) then
			final_v_x = final_v_x - total_speed
		end
		local e_down = ComponentGetValue2( ctrl_comp, "mButtonDownInteract" )
		local s_down = ComponentGetValue2( ctrl_comp, "mButtonDownDown" ) and not( e_down )
		if( s_down ) then
			final_v_y = final_v_y + total_speed*vertical_killer
		end
		local d_down = ComponentGetValue2( ctrl_comp, "mButtonDownRight" )
		if( d_down ) then
			final_v_x = final_v_x + total_speed
		end
		
		local a_name = "fly_idle"
		if( w_down or a_down or s_down or d_down ) then
			a_name = "fly_move"
		-- else --fucking inertion sucks
			-- local damping = 0.9
			-- if( v_x ~= 0 ) then
				-- prev_v_x = prev_v_x or v_x
				-- local temp_v_x = prev_v_x*damping
				-- if( math.abs( temp_v_x ) - math.abs( prev_v_x ) > 0.001 ) then
					-- final_v_x = temp_v_x
				-- end
			-- end
			-- if( v_y ~= -gravity ) then
				-- prev_v_y = prev_v_y or v_y
				-- local temp_v_y = prev_v_y*damping
				-- if( math.abs( temp_v_y ) - math.abs( prev_v_y ) > 0.001 ) then
					-- final_v_y = temp_v_y
				-- end
			-- end
			-- GamePrint( tostring( prev_v_x ).."|"..tostring( prev_v_y ))
		end
		
		GamePlayAnimation( hooman, a_name, 1 )
		ComponentSetValueVector2( char_comp, "mVelocity", final_v_x, final_v_y )
	end
end

--alright distance to the ground is deformed so the back will get less and speed dependent
--if can't connect search in alien part but only if less than two connected
--maintain set height above ground
--better joint direction handling via GetSurfaceNormal