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

    --standartized multisound size-based sfxes
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

--add light

local fog_anim = 1 - pen.animate( 1, cnt, { ease_out = "exp3", frames = data.time })
ComponentSetValue2( pic_wave, "alpha", ( 1 - anim )*data.alpha )
ComponentSetValue2( pic_fog, "alpha", fog_anim*data.alpha )
ComponentSetValue2( pic_fire, "alpha", cnt > 1 and 0 or 1 )
ComponentSetValue2( pic_hole, "visible", cnt < 3 )
for i,v in ipairs({ pic_wave, pic_fog, pic_fire }) do EntityRefreshSprite( exp_id, v ) end

--enemies hit with shockwaves should have contusion effect (rapidly decaying drunkness and inversed movement) applied if they don't have void-sealed status
--push objects as shockwave passes

if( cnt > data.time ) then EntityKill( exp_id ) end