dofile_once( "mods/Noita40K/files/_lib.lua" )

local exp_id = GetUpdatedEntityID()
local x, y, r, s_x, s_y = EntityGetTransform( exp_id )

local cnt = ComponentGetValue2( GetUpdatedComponentID(), "mTimesExecuted" )
local pics = EntityGetComponentIncludingDisabled( exp_id, "SpriteComponent" )
local pic_wave, pic_fire, pic_hole, pic_fog = pics[1], pics[2], pics[3], pics[4]

explosion_data = explosion_data or {}
if( explosion_data[ exp_id ] == nil ) then
    local data = {}
    local tbl = { "speed", "size", "alpha", "force", "damage",
            "shrapnell", "shrapnell_speed", "shrapnell_damage" }
    for i,v in ipairs( tbl ) do data[v] = pen.magic_storage( exp_id, v, "value_float" ) end

    --shrapnell with sfxes
    --standartized multisound size-based sfxes

    explosion_data[ exp_id ] = data
end

local data = explosion_data[ exp_id ]
local anim = pen.animate( 1, cnt, { ease_out = "exp", frames = data.speed })
EntitySetTransform( exp_id, x, y, r, ( anim*data.size + 1 )/256, ( anim*data.size + 1 )/256 )

--add light

local anim_back = 1 - anim
ComponentSetValue2( pic_wave, "alpha", anim_back*data.alpha )
ComponentSetValue2( pic_fog, "alpha", anim_back*data.alpha/4 )
ComponentSetValue2( pic_fire, "alpha", cnt > 1 and 0 or 1 )
ComponentSetValue2( pic_hole, "visible", cnt < 3 )
for i,v in ipairs({ pic_wave, pic_fog, pic_fire }) do EntityRefreshSprite( exp_id, v ) end

--enemies hit with shockwaves should have contusion effect (rapidly decaying drunkness and inversed movement) applied if they don't have void-sealed status
--push objects as shockwave passes

if( cnt > data.speed ) then EntityKill( exp_id ) end