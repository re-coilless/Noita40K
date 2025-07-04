dofile_once( "mods/Noita40K/files/_lib.lua" )

if( not( GetValueBool( "was_added", false ))) then
    SetValueBool( "was_added", true )
else --thanks Dexter and Horscht
    local proj_id = GetUpdatedEntityID()
    local exp = pen.magic_storage( proj_id, "explosion", "value_string" )
    if( pen.vld( exp )) then
        local x, y = EntityGetTransform( proj_id )
        local exp_id = EntityLoad( exp, x, y )
        local proj_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" )
        local who_shot = ComponentGetValue2( proj_comp, "mWhoShot" )
        pen.magic_storage( exp_id, "author", "value_int", who_shot )
    end
end

function wake_up_waiting_threads()
    local proj_id = GetUpdatedEntityID()
    local proj_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" )
    if( not( pen.vld( proj_comp, true ))) then return end
    local vel_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "VelocityComponent" )
    if( not( pen.vld( vel_comp, true ))) then return end


    
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

                -- play decaying sound loop from projectile
                pen.magic_particles( point_x, point_y, math.rad( 180 ) + n_angle, {
                    fading = 7, lifetime = 2,
                    additive = true, emissive = true, count = { 2, 3 },
                    
                    alpha = 0.9, alpha_end = 0.1,
                    color = { 237, 141, 45 },
                    
                    v_range = { 0, -50, 200, 50 }, slowdown = { -20, 0, 1 },
                })
            end
        end
    end



    proj_memo = proj_memo or {}
    local true_v = { x - last_x, y - last_y }
    proj_memo[ proj_id ] = proj_memo[ proj_id ] or {}
    local last_true_v = proj_memo[ proj_id ].true_v or true_v
    local acceleration = math.sqrt(( true_v[1] - last_true_v[1])^2 + ( true_v[2] - last_true_v[2])^2 )
    proj_memo[ proj_id ].true_v = true_v

    local lob_min = math.floor( 10*ComponentGetValue2( proj_comp, "lob_min" ))
    local lob_max = math.ceil( 10*ComponentGetValue2( proj_comp, "lob_max" ))
    if( acceleration > math.random( lob_min, lob_max )) then ComponentSetValue2( proj_comp, "lifetime", 0 ) end

    

    local frame_num = GameGetFrameNum()
    local just_hit = ComponentGetValue2( proj_comp, "mLastFrameDamaged" ) == frame_num --stolen from Apotheosis
    if( just_hit ) then
        v = math.sqrt( v_x^2 + v_y^2 )
        local friction = ComponentGetValue2( vel_comp, "air_friction" )
        local angle, perc = math.atan2( v_y, v_x ), math.max( 1/math.max( math.abs( friction ), 1.25 ), 0.6 )
        
        proj_memo[ proj_id ].hit_tbl = proj_memo[ proj_id ].hit_tbl or {}
        if( pen.t.loop( ComponentGetValue2( proj_comp, "mDamagedEntities" ), function( i, hit_id )
            if( proj_memo[ proj_id ].hit_tbl[ hit_id ] ~= nil ) then return end
            if( EntityGetIsAlive( hit_id )) then return true end
            proj_memo[ proj_id ].hit_tbl[ hit_id ] = 1

            v = perc*v
            angle = angle + math.rad( pen.generic_random( 1, 5, nil, true ))
        end)) then
            ComponentSetValue2( proj_comp, "lifetime", 0 )
            ComponentSetValue2( vel_comp, "mVelocity", 0, 0 )
        else
            v_x, v_y = v*math.cos( angle ), v*math.sin( angle )
            ComponentSetValue2( vel_comp, "mVelocity", v_x, v_y )
        end
    end
end