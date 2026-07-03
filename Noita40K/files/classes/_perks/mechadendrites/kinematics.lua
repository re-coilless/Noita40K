dofile_once( "mods/Noita40K/files/_lib.lua" )

local limb_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( limb_id )
local base_x, base_y, base_r, base_s_x, base_s_y = EntityGetTransform( limb_id )

local lmt_1A, lmt_1B, lmt_15, lmt_2A, lmt_2B = unpack(
	pen.t.pack( pen.magic_storage( limb_id, "limits", "value_string" )))
local is_active = pen.magic_storage( limb_id, "is_active", "value_bool" )
local max_angle = pen.magic_storage( limb_id, "max_angle", "value_float" )
local max_length = pen.magic_storage( limb_id, "max_length", "value_float" )

local t_x, t_y = -5*base_s_x, 1
if( is_active ) then
	t_x = pen.magic_storage( limb_id, "target_x", "value_float" )
	t_y = pen.magic_storage( limb_id, "target_y", "value_float" )
	t_x, t_y = pen.get_mouse_pos( true )
	if( pen.magic_storage( limb_id, "absolute_mode", "value_bool" )) then
		t_x, t_y = t_x - base_x, t_y - base_y
	end
end

local claw_id = pen.get_child( limb_id, "claw" )
if( not( pen.vld( claw_id, true ))) then return end
local c_x, c_y = EntityGetTransform( claw_id )

local speed = pen.magic_storage( limb_id, "speed", "value_float" )
local accuracy = 5/( is_active and 2 or 1 )
local d_x, d_y = t_x - c_x, t_y - c_y

pen.magic_storage( limb_id, "is_going",
	"value_bool", math.sqrt( d_x^2 + d_y^2 ) > accuracy )
-- t_x = pen.estimate( "_", { t_x, c_x }, { "wgt", speed })
-- t_y = pen.estimate( "_", { t_y, c_y }, { "wgt", speed })

--smooth flipping (fold the limb closed then unfold once on the other side)
--stretching should start once angle_3 hits a certain limit
lmt_1B, lmt_2B = 2, 1 --remove this (should scale automatically, if is zero, do the A-link stretching)

local angle = math.atan2( t_y, t_x )
local length = math.sqrt( t_x^2 + t_y^2 )
local link_1, link_2 = lmt_1A + lmt_1B, lmt_2A + lmt_2B
local angle_1 = math.acos(( link_1^2 + length^2 - link_2^2 )/( 2*link_1*length ))
local angle_2 = math.asin( link_1*math.sin( angle_1 )/link_2 )
local angle_3 = math.rad( 180 ) - ( angle_1 + angle_2 )
angle_2 = math.rad( 180 ) - angle_2

local a = lmt_1A + lmt_1B + 0.5
local b = 0

local x_1A, y_1A, r_1A = 0, 0, angle_1
local x_1B, y_1B, r_1B = x_1A + math.cos( angle_1 )*lmt_1B, y_1A + math.sin( angle_1 )*lmt_1B, angle_1
local x_15, y_15, r_15 = math.cos( angle_1 )*a, math.sin( angle_1 )*a, angle
local x_2A, y_2A, r_2A = x_15 + math.cos( angle_2 )*0.5, y_15 + math.sin( angle_2 )*0.5, angle_2
local x_2B, y_2B, r_2B = x_2A + math.cos( angle_2 )*lmt_2B, y_2A + math.sin( angle_2 )*lmt_2B, angle_2
local x_3, y_3, r_3 = t_x + math.cos( angle_2 ), t_y + math.sin( angle_2 ), angle_2

--this is a general solution, it should be rotated
pen.debug_dot( base_x + x_1A, base_y + y_1A )
pen.debug_dot( base_x + x_1B, base_y + y_1B )
pen.debug_dot( base_x + x_15, base_y + y_15 )
pen.debug_dot( base_x + x_2A, base_y + y_2A )
pen.debug_dot( base_x + x_2B, base_y + y_2B )
pen.debug_dot( base_x + x_3, base_y + y_3 )

-- h = math.sqrt( tmp_first^2 - ((( length - lmt_15 )^2 + tmp_first^2 - tmp_third^2 )/( 2*( length - lmt_15 )))^2 )
-- if( h < tmp_first ) then a = math.sqrt( tmp_first^2 - h^2 ) else h = tmp_first end
-- if( is_active ) then h = -pen.sgn( t_x )*pen.sgn( t_y )*h else h = -pen.sgn( t_x )*h end
-- b = a + lmt_15

-- local dx1 = a*math.cos( angle ) + h*math.sin( angle )
-- local dy1 = -a*math.sin( angle ) + h*math.cos( angle )
-- local dx2 = b*math.cos( angle ) + h*math.sin( angle )
-- local dy2 = -b*math.sin( angle ) + h*math.cos( angle )

-- local angle_back = math.atan2( dy1, dx1 )
-- local angle_front = math.atan2( t_y - dy2, t_x - dx2 )
-- local pos = {
-- 	{ base_x, base_y, angle_back },
-- 	{ base_x + math.cos( angle_back )*lmt_1B, base_y + math.sin( angle_back )*lmt_1B, angle_back },
-- 	{ base_x + dx1, base_y + dy1, -angle },
-- 	{ base_x + dx2, base_y + dy2, angle_front },
-- 	{ base_x + dx2 + math.cos( angle_front )*lmt_2B, base_y + dy2 + math.sin( angle_front )*lmt_2B, angle_front },
-- 	{ base_x + dx2 + math.cos( angle_front )*( tmp_third - 2 ), base_y + dy2 + math.sin( angle_front )*( tmp_third - 2 ), angle_front },
-- }

-- for i,d_module in ipairs( EntityGetAllChildren( limb_id ) or {}) do
-- 	EntitySetTransform( d_module, pos[i][1], pos[i][2], pos[i][3], 1, 1 )
-- end