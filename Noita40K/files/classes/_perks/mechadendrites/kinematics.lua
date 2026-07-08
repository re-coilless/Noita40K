dofile_once( "mods/Noita40K/files/_lib.lua" )

local limb_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( limb_id )
local base_x, base_y, base_r, base_s_x, base_s_y = EntityGetTransform( limb_id )

local claw_id = pen.get_child( limb_id, "foot" )
if( not( pen.vld( claw_id, true ))) then return end
local c_x, c_y = EntityGetTransform( claw_id )
c_x, c_y = c_x - base_x, c_y - base_y

local lmt_1A, lmt_1B, lmt_15, lmt_2A, lmt_2B, lmt_25 = unpack(
	pen.t.pack( pen.magic_storage( limb_id, "limits", "value_string" )))
local is_active = pen.magic_storage( limb_id, "is_active", "value_bool" )
local may_flip = pen.magic_storage( limb_id, "may_flip", "value_bool" )
local max_length = pen.magic_storage( limb_id, "max_length", "value_float" )
local morph_length = pen.magic_storage( limb_id, "morph_length", "value_float" )

local t_x, t_y = -5*base_s_x, 1
if( is_active ) then
	t_x = pen.magic_storage( limb_id, "target_x", "value_float" )
	t_y = pen.magic_storage( limb_id, "target_y", "value_float" )
	t_x, t_y = pen.get_mouse_pos( true )
	if( pen.magic_storage( limb_id, "absolute_mode", "value_bool" )) then
		t_x, t_y = t_x - base_x, t_y - base_y
	end
end

local length = math.max( math.sqrt( t_x^2 + t_y^2 ), 0.1 )
if( length > max_length ) then
	local angle = math.atan2( t_y, t_x )
	t_x = math.cos( angle )*max_length
	t_y = math.sin( angle )*max_length
	length = max_length
end

local speed = pen.magic_storage( limb_id, "speed", "value_float" )
if( speed > 0 ) then
	c_x = pen.estimate( "", { t_x, c_x }, { "wgt", speed })
	c_y = pen.estimate( "", { t_y, c_y }, { "wgt", speed })
else c_x, c_y = t_x, t_y end

local d_x, d_y = t_x - c_x, t_y - c_y
local accuracy = 5/( is_active and 2 or 1 )
pen.magic_storage( limb_id, "is_going", "value_bool", math.sqrt( d_x^2 + d_y^2 ) > accuracy )

--if lmt_1B or lmt_2B are negative, stretch A instead of shifting B pos

local foot_off = lmt_25 - lmt_2A
local link_1, link_2 = lmt_1A + 1, lmt_2A + 1 + foot_off
if( length >= morph_length ) then
	local delta = ( length - morph_length )/2
	lmt_1B = math.max( math.min( delta*0.75, lmt_1B ), 1 )
	lmt_2B = math.max( math.min( delta*1.25, lmt_2B ), 1 )
	link_1, link_2 = lmt_1A + lmt_1B, lmt_2A + lmt_2B + foot_off
else lmt_1B, lmt_2B = 1, 1 end

local angle = math.atan2( c_y, c_x )
local cos_1 = ( link_1^2 + length^2 - link_2^2 )/( 2*link_1*length )
local angle_1 = math.acos( pen.lmt( cos_1, 1 ))
local angle_2 = math.asin( link_1*math.sin( angle_1 )/link_2 )

--smooth flipping (fold the limb closed then unfold once on the other side)

local scale = 1
local is_bottom = false
if( may_flip ) then --five degrees of grace
	is_bottom = math.abs( angle ) > math.rad( 90 )
else is_bottom = pen.magic_storage( limb_id, "may_flip", "value_int" ) == 1 end

if( is_bottom ) then
	angle_1, angle_2, scale = angle + angle_1, angle - angle_2, -1
else angle_1, angle_2 = angle - angle_1, angle_2 + angle end

local x_1A, y_1A, r_1A = 0, 0, angle_1
local x_1B, y_1B, r_1B = x_1A + math.cos( angle_1 )*lmt_1B, y_1A + math.sin( angle_1 )*lmt_1B, angle_1
local x_15, y_15, r_15 = math.cos( angle_1 )*( link_1 + lmt_15 ), math.sin( angle_1 )*( link_1 + lmt_15 ), angle
local x_2A, y_2A, r_2A = x_15 + math.cos( angle_2 )*lmt_15, y_15 + math.sin( angle_2 )*lmt_15, angle_2
local x_2B, y_2B, r_2B = x_2A + math.cos( angle_2 )*lmt_2B, y_2A + math.sin( angle_2 )*lmt_2B, angle_2
local x_3, y_3, r_3 = x_2B + math.cos( angle_2 )*lmt_25, y_2B + math.sin( angle_2 )*lmt_25, angle_2

local pos = {
	{ base_x + x_1A, base_y + y_1A, r_1A },
	{ base_x + x_1B, base_y + y_1B, r_1B },
	{ base_x + x_15, base_y + y_15, r_15 },
	{ base_x + x_2A, base_y + y_2A, r_2A },
	{ base_x + x_2B, base_y + y_2B, r_2B },
	{ base_x + x_3, base_y + y_3, r_3 },
}

for i,id in ipairs( EntityGetAllChildren( limb_id ) or {}) do
	EntitySetTransform( id, pos[i][1], pos[i][2], pos[i][3], 1, scale )
end