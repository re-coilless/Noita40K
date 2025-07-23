dofile_once( "mods/Noita40K/files/_lib.lua" )

local exp_id = GetUpdatedEntityID()
local x, y, r, s_x, s_y = EntityGetTransform( exp_id )

local cnt = ComponentGetValue2( GetUpdatedComponentID(), "mTimesExecuted" )
local pics = EntityGetComponentIncludingDisabled( exp_id, "SpriteComponent" )
local pic_fire, pic_wave, pic_fog, pic_hole = pics[1], pics[2], pics[3], pics[4]

explosion_data = explosion_data or {}
if( explosion_data[ exp_id ] == nil ) then
    local data = {}
    local tbl = { "time", "size", "alpha", "force", "damage",
        "shrapnel", "shrapnel_speed", "shrapnel_damage", "shrapnel_time" }
    for i,v in ipairs( tbl ) do data[v] = pen.magic_storage( exp_id, v, "value_float" ) end
    data.shrapnel_damage = data.shrapnel_damage*data.damage/10
    data.shrapnel_time = data.shrapnel_time*data.time/2
    data.shrapnel_tbl = {}
    
    local count = math.floor( data.shrapnel + 0.5 )
    local who_shot = pen.magic_storage( exp_id, "author", "value_int" )
    local shrapnel = pen.magic_storage( exp_id, "shrapnel_file", "value_string" )
    local stains = pen.magic_storage( exp_id, "stains", "value_bool" ) or false
    for i = 1,count do
        local angle = math.rad( 360 )/count*( i + math.random()/2 ) --do directional explosion here
        local v_x, v_y = math.cos( angle )*data.shrapnel_speed, math.sin( angle )*data.shrapnel_speed
        local id = pen.magic_shooter( who_shot, shrapnel, x, y, v_x, v_y, false, function( proj_id, proj_comp )
            ComponentSetValue2( proj_comp, "lifetime", data.shrapnel_time )
            ComponentSetValue2( proj_comp, "damage", data.shrapnel_damage )
            local p_x, p_y, p_r, p_s_x, p_s_y = EntityGetTransform( proj_id )
            EntitySetTransform( proj_id, p_x, p_y, p_r, p_s_x/2, p_s_y/2 )
        end)
        table.insert( data.shrapnel_tbl, id )
    end

    data.size = math.max( data.size, 1 )
    local s = data.size
    data.force = math.max( data.force, 0.01 )
    local f = data.force

    -- size 1 10 20 50 250 | 5 3 2 0.2 0.1
    local kes = math.log( 50227*math.exp( -99*s/820 + 919/( 820*math.pow( 894/695, s )))/719 + 294/271 )
    -- force 1 2 7 15 25 | 0.1 0.75 3 5 8
    local kef = -2*f - 173*( -f - 826/171 )*math.log( math.log( f*( f - 92/537 ) + 3169/997 ))/166 + 58/559
    -- energy 1 10 20 50 250 | 1 2 7 15 25 | 0.5 2 6 1 0.8
    local energy = kes*kef

    -- size 1 10 20 50 250 | 1 4 6 10 15
    local kss = s*( -998*math.log( s + 7/41 )/927 + math.log( s + 778/531 ) + 56/117 ) - 205/969
    -- force 1 2 7 15 25 | 0.5 1 1.33 1.5 2
    local ksf = 176*f*( f - 13/745 )/148535 + 15136/( 103761*( 32/275 + math.exp( -311*f/177 )))
    -- shake 1 10 20 50 250 | 1 2 7 15 25 | 0.5 4 8 15 30
    local shake = kss*ksf
    
    -- size 1 10 20 50 250 | 15 10 7.5 4 1
    local kis = -32/491 - 228592/( 817*( -s - 7351/418 ))
    -- force 1 2 7 15 25 | 0.2 1 2 3 4
    local kif = 72*math.pow( f, 549/862 )/155 - math.pow( 646/( 981*f ), f ) + 216/551
    -- impact 1 10 20 50 250 | 1 2 7 15 25 | 3 10 15 12 4
    local impact = kis*kif

    local diameter = 2*data.size
    local is_hyper = data.time/diameter > 0.4
    if( is_hyper ) then
        local off_x, off_y = math.cos( r ), math.sin( r )
        local x_lock = RaytracePlatforms( x, y, x - off_x, y ) and RaytracePlatforms( x, y, x + off_x, y )
        local y_lock = RaytracePlatforms( x, y, x, y - off_y ) and RaytracePlatforms( x, y, x, y + off_y )
        if( x_lock or y_lock ) then energy, diameter, impact = energy + 1, diameter/1.5, impact + 5 end
    end
    
    pen.magic_explosion( x, y, {
        shooter = who_shot, light = 0.2,
        radius = math.ceil( diameter/5 ),
        stains = stains and data.size or nil,
        shake = math.min( math.max( shake, 0 ), 30 ),
        energy = math.ceil( math.max( 100000*energy, 1 )),
        impact = math.floor( math.min( math.max( impact, 10 ), 20 )),
    })
    
    local event = is_hyper and "/hypersonic_" or "/supersonic_"
    local event_size = diameter < 30 and "S" or ( diameter < 75 and "M" or "L" )
    local event_path = pen.t.pack( pen.magic_storage( exp_id, "sfx_root", "value_string" ))
    pen.play_sound({ event_path[1], event_path[2]..event..event_size }, x, y )

    explosion_data[ exp_id ] = data
end

local data = explosion_data[ exp_id ]
local anim = pen.animate( 1, cnt, { ease_out = "exp", frames = data.time })
EntitySetTransform( exp_id, x, y, r, ( anim*data.size + 1 )/256, ( anim*data.size + 1 )/256 )

-- heat explosion creates a cone of bigger and bigger explosion entites with raycast and a single frame delay betwenn each one

pen.t.loop( data.shrapnel_tbl, function( i, proj_id )
    if( not( EntityGetIsAlive( proj_id ))) then return end
    --as they die play hit sfx at last known pos (max one per 3 frames)
    local proj_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" )
    ComponentSetValue2( proj_comp, "damage", data.shrapnel_damage*( 1 - cnt/data.time ))
    local pic_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "SpriteComponent" )
    ComponentSetValue2( pic_comp, "alpha", 1.5*( 1 - anim ))
    EntityRefreshSprite( proj_id, pic_comp )
end)

local fog_anim = 1 - pen.animate( 1, cnt, { ease_out = "exp3", frames = data.time })
ComponentSetValue2( pic_wave, "alpha", ( 1 - anim )*data.alpha )
ComponentSetValue2( pic_fog, "alpha", fog_anim*data.alpha )
ComponentSetValue2( pic_fire, "alpha", cnt > 1 and 0 or 1 )
ComponentSetValue2( pic_hole, "visible", cnt < 3 )
for i,v in ipairs({ pic_wave, pic_fog, pic_fire }) do EntityRefreshSprite( exp_id, v ) end

--enemies hit with shockwaves should have contusion effect (rapidly decaying drunkness and inversed movement) applied if they don't have void-sealed status
--check showave hit by gettign distance to each of the four hitbox center points (deal damage every frame but spread the total number listed between them)
--push objects as shockwave passes
--wavefront damage should be scaled based on size, var storage is just a multiplier

if( cnt > data.time ) then EntityKill( exp_id ) end