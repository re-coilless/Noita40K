dofile_once( "mods/Noita40K/files/_lib.lua" )

local proj_id = GetUpdatedEntityID()
local proj_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" )
if( not( pen.vld( proj_comp, true ))) then return end
local vel_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "VelocityComponent" )
if( not( pen.vld( vel_comp, true ))) then return end


--separate this in penman
local x, y = EntityGetTransform( proj_id )
local v_x, v_y = ComponentGetValue2( vel_comp, "mVelocity" )
local last_x, last_y = ComponentGetValue2( vel_comp, "mPrevPosition" )
local will_coll, coll_x, coll_y = RaytracePlatforms( x, y, x + v_x/60, y + v_y/60 )

local v = math.sqrt( v_x^2 + v_y^2 )
local can_rico = ComponentGetValue2( proj_comp, "bounce_energy" ) > 0
if( can_rico and will_coll and v > 900 ) then
    local point_x = coll_x - pen.get_sign( v_x )
    local point_y = coll_y - pen.get_sign( v_y )
    local n_found, n_x, n_y, n_dist = GetSurfaceNormal( point_x, point_y, 1.1, 40 )
    if( n_found ) then
        local p_angle = math.atan2( v_y, v_x )
        local n_angle = math.atan2( n_y, n_x )
        local angle = math.abs( math.deg( n_angle - p_angle ))%90
        
        local min_rico, max_rico = 65, 85
        local will_rico = angle > max_rico
        if( not( will_rico ) and angle > min_rico ) then
            will_rico = math.random() < ( angle - min_rico )/( max_rico - min_rico )
        end

        if( will_rico ) then
            local r_angle = p_angle + 2*( n_angle - p_angle )
            v_x, v_y = -v*math.cos( r_angle ), -v*math.sin( r_angle )
            ComponentSetValue2( vel_comp, "mVelocity", v_x, v_y )
            EntitySetTransform( proj_id, point_x, point_y )
            -- EntityApplyTransform( proj_id, point_x, point_y )
            -- release sparks + play sound
        end
    end
end



true_v_memo = true_v_memo or {}
local true_v = { x - last_x, y - last_y }
local last_true_v = true_v_memo[ proj_id ] or true_v
local acceleration = math.sqrt(( true_v[1] - last_true_v[1])^2 + ( true_v[2] - last_true_v[2])^2 )
true_v_memo[ proj_id ] = true_v

local lob_min = math.floor( 10*ComponentGetValue2( proj_comp, "lob_min" ))
local lob_max = math.ceil( 10*ComponentGetValue2( proj_comp, "lob_max" ))
if( acceleration > math.random( lob_min, lob_max )) then ComponentSetValue2( proj_comp, "lifetime", 0 ) end



local frame_num = GameGetFrameNum()
local just_hit = ComponentGetValue2( proj_comp, "mLastFrameDamaged" ) == frame_num --stolen from Apotheosis
if( not( just_hit )) then return end
local hit_list = ComponentGetValue2( proj_comp, "mDamagedEntities" )
--loop through the table, check IsAlive or just hp value on each of them
--if at least one is still alive, set lifetime to 0
--memorize all of the entities and ignore them on the next check