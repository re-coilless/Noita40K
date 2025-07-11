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

    data.size = math.max( 2*data.size, 1 )
    data.force = math.max( data.force, 0.01 )
    local event = ( data.force > data.damage ) and "/force_" or "/pressure_"
    local event_size = data.size < 25 and "S" or ( data.size < 50 and "M" or "L" )
    local event_path = pen.t.pack( pen.magic_storage( exp_id, "sfx_root", "value_string" ))
    pen.play_sound({ event_path[1], event_path[2]..event..event_size }, x, y )

    local k_size_energy = ( 14336 + 3.483 )/( 1 + math.pow( data.size/1.638, 1.695 )) - 3.483
    local k_force_energy = math.max( 32397 - ( 290 + 32397 )/( 1 + math.pow( data.force/1.311, 2.996 )), 1 )
    
    local k_size_shake = 22 + ( 0.237 - 22 )/( 1 + math.pow( data.size/116, 1.535 ))
    local k_force_shake = 6.328*( 1 - 1/( 1 + math.pow( data.force/1.2, 1.081 )))
    
    local k_size_impact = ( 25 + 0.304 )/( 1 + math.pow( data.size/4.87, 0.921 )) - 0.304
    local k_force_impact = 200 + ( 2.35 - 200 )/( 1 + math.pow( data.force/24, 12.315 ))
    
    --redo the scaling
    pen.magic_explosion( x, y, {
        shooter = who_shot, light = 0.2,
        radius = math.ceil( data.size/2.5 ),
        energy = math.ceil( math.max( k_size_energy*k_force_energy, 1 )),
        shake = math.max( math.min( k_size_shake*k_force_shake, 20 ), 0 ),
        impact = math.floor( math.max( math.min( k_size_impact*k_force_impact, 20 ), 20 )),
    })

    explosion_data[ exp_id ] = data
end

local data = explosion_data[ exp_id ]
local anim = pen.animate( 1, cnt, { ease_out = "exp", frames = data.time })
EntitySetTransform( exp_id, x, y, r, ( anim*data.size + 1 )/256, ( anim*data.size + 1 )/256 )

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