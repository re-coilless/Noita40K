dofile_once( "mods/Noita40K/files/_lib.lua" )

local limb_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( limb_id )
local base_x, base_y, base_r, base_s_x, base_s_y = EntityGetTransform( limb_id )
local is_active = pen.magic_storage( limb_id, "is_active", "value_bool" )
local t_x, t_y = base_x - 7*base_s_x, base_y + 1
local accuracy = 8

if( is_active ) then
	local length = pen.magic_storage( limb_id, "length", "value_float" )
	local temp_x = pen.magic_storage( limb_id, "target_x", "value_float" )
	local temp_y = pen.magic_storage( limb_id, "target_y", "value_float" )
	temp_x, temp_y = pen.get_mouse_pos( true )
	if( pen.magic_storage( limb_id, "offset_mode", "value_bool" )) then
		temp_x, temp_y = base_x + temp_x, base_y + temp_y end
	if(( temp_x ~= 0 or temp_y ~= 0 ) and math.sqrt(( base_x - temp_x )^2 + ( base_y - temp_y )^2 ) < length ) then
		t_x, t_y, accuracy = temp_x, temp_y, accuracy/2
	else is_active = false end
end

local lmt_1A, lmt_1B, lmt_15, lmt_2A, lmt_2B = unpack(
	pen.t.pack( pen.magic_storage( limb_id, "limits", "value_string" )))
local stretching = lmt_1A + lmt_1B + lmt_15 + lmt_2A + lmt_2B
local stretching_k = 1/( lmt_1B + lmt_2B )

local c_x, c_y = 0, 0
local children = EntityGetAllChildren( limb_id ) or {}
for i,d_module in ipairs( children ) do
	if( EntityGetName( d_module ) == "claw" ) then
		c_x, c_y = EntityGetTransform( d_module )
		break
	end
end

local speed_k = 2.5
local d_x, d_y = t_x - c_x, t_y - c_y
if( math.sqrt( d_x^2 + d_y^2 ) > accuracy ) then
	t_x = c_x + pen.sgn( d_x )*speed_k*math.log( math.abs( d_x ) + 1 )
	t_y = c_y + pen.sgn( d_y )*speed_k*math.log( math.abs( d_y ) + 1 )
else pen.magic_storage( limb_id, "is_going", "value_bool", false ) end
t_x, t_y = t_x - base_x, t_y - base_y

local h, a, b = 0, 0, 0
local angle = -math.atan2( t_y, t_x )
local length = math.sqrt( t_x^2 + t_y^2 )
if( length + 2 >= lmt_1A + lmt_15 + lmt_2A ) then
	length = math.min( length, stretching )
	stretching = length - ( lmt_1A + lmt_15 + lmt_2A ) --subtracting from this causes the change in final angle
	lmt_1B = lmt_1B*stretching*stretching_k + 3
	lmt_2B = lmt_2B*stretching*stretching_k + 2
else lmt_1B, lmt_2B = 2, 1 end

local tmp_first, tmp_third = lmt_1A + lmt_1B, lmt_2A + lmt_2B
h = math.sqrt( tmp_first^2 - ((( length - lmt_15 )^2 + tmp_first^2 - tmp_third^2 )/( 2*( length - lmt_15 )) )^2 )
if( h < tmp_first ) then a = math.sqrt( tmp_first^2 - h^2 ) else h = tmp_first end
if( is_active ) then h = -pen.sgn( t_x )*pen.sgn( t_y )*h else h = -pen.sgn( t_x )*h end
b = a + lmt_15

local dx1 = a*math.cos( angle ) + h*math.sin( angle )
local dy1 = -a*math.sin( angle ) + h*math.cos( angle )
local dx2 = b*math.cos( angle ) + h*math.sin( angle )
local dy2 = -b*math.sin( angle ) + h*math.cos( angle )

local angle_back = math.atan2( dy1, dx1 )
local angle_front = math.atan2( t_y - dy2, t_x - dx2 )
local pos = {
	{ base_x, base_y, angle_back },
	{ base_x + math.cos( angle_back )*lmt_1B, base_y + math.sin( angle_back )*lmt_1B, angle_back },
	{ base_x + dx1, base_y + dy1, -angle },
	{ base_x + dx2, base_y + dy2, angle_front },
	{ base_x + dx2 + math.cos( angle_front )*lmt_2B, base_y + dy2 + math.sin( angle_front )*lmt_2B, angle_front },
	{ base_x + dx2 + math.cos( angle_front )*( tmp_third - 2 ), base_y + dy2 + math.sin( angle_front )*( tmp_third - 2 ), angle_front },
}

for i,d_module in ipairs( children ) do
	EntitySetTransform( d_module, pos[i][1], pos[i][2], pos[i][3], 1, 1 )
end