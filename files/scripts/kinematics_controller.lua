dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local hooman = GetUpdatedEntityID()
local base_x, base_y, base_r, base_s_x, base_s_y = EntityGetTransform( hooman )
base_y = base_y + get_head_offset( EntityGetParent( hooman ))/2

local is_active = ( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( EntityGetParent( hooman ), "VariableStorageComponent", "dendrites_active" ), "value_bool" ) and not( EntityHasTag( EntityGetParent( hooman ), "system_overload" )))

local t_x = base_x - 7*base_s_x
local t_y = base_y

local accuracy = 8
if( is_active ) then
	local temp_x = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "target_x" ), "value_float" )
	local temp_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "target_y" ), "value_float" )
	local full_length = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "full_length" ), "value_float" )
	if(( temp_x == 0 and temp_y == 0 ) or math.sqrt(( base_x - temp_x )^2 + ( base_y - temp_y )^2 ) > full_length ) then
		is_active = false
	else
		t_x = temp_x
		t_y = temp_y
		accuracy = accuracy/2
	end
end

local first_link = 12
local first_limit = 6
local second_link = 2
local third_link = 14
local third_limit = 8

local stretching_k = 1/( first_limit + third_limit )
local stretching = first_link + first_limit + second_link + third_link + third_limit

local c_x, c_y = 0, 0
local children = EntityGetAllChildren( hooman ) or {}
if( #children > 0 ) then
	for i,d_module in ipairs( children ) do
		if( EntityHasTag( d_module, "final_part" )) then
			c_x, c_y = EntityGetTransform( d_module )
			break
		end
	end
end

local speed_k = 2.5
local d_x = t_x - c_x
local d_y = t_y - c_y
if( math.sqrt( d_x^2 + d_y^2 ) > accuracy ) then
	t_x = c_x + get_sign( d_x )*speed_k*math.log( math.abs( d_x ) + 1 )
	t_y = c_y + get_sign( d_y )*speed_k*math.log( math.abs( d_y ) + 1 )
else
	ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "is_going" ), "value_bool", false )
end
t_x = t_x - base_x
t_y = t_y - base_y

local length = math.sqrt( t_x^2 + t_y^2 )
local angle = -math.atan2( t_y, t_x )

local h = 0
local a = 0
local b = 0

if( length + 2 >= first_link + second_link + third_link ) then
	if( length > stretching ) then
		length = stretching
	end
	stretching = length - ( first_link + second_link + third_link )
	first_limit = first_limit*stretching*stretching_k + 2
	third_limit = third_limit*stretching*stretching_k + 3
else
	first_limit = 1
	third_limit = 2
end

local tmp_first = first_link + first_limit
local tmp_third = third_link + third_limit
h = math.sqrt( tmp_first^2 - ((( length - second_link )^2 + tmp_first^2 - tmp_third^2 )/( 2*( length - second_link )) )^2 )
if( h < tmp_first ) then
	a = math.sqrt( tmp_first^2 - h^2 )
else
	h = tmp_first
end
if( not( is_active ) ) then
	h = -get_sign( t_x )*h
else
	h = -get_sign( t_x )*get_sign( t_y )*h
end
b = a + second_link

local dx1 = a*math.cos( angle ) + h*math.sin( angle )
local dy1 = -a*math.sin( angle ) + h*math.cos( angle )
local dx2 = b*math.cos( angle ) + h*math.sin( angle )
local dy2 = -b*math.sin( angle ) + h*math.cos( angle )

local angle_back = math.atan2( dy1, dx1 )
local angle_front = math.atan2( t_y - dy2, t_x - dx2 )
local pos = {
	{ base_x, base_y, angle_back },
	{ base_x + math.cos( angle_back )*first_limit, base_y + math.sin( angle_back )*first_limit, angle_back },
	{ base_x + dx1, base_y + dy1, -angle },
	{ base_x + dx2, base_y + dy2, angle_front },
	{ base_x + dx2 + math.cos( angle_front )*third_limit, base_y + dy2 + math.sin( angle_front )*third_limit, angle_front },
	{ base_x + dx2 + math.cos( angle_front )*( tmp_third - 2 ), base_y + dy2 + math.sin( angle_front )*( tmp_third - 2 ), angle_front },
}

if( #children > 0 ) then
	for i,d_module in ipairs( children ) do
		EntitySetTransform( d_module, pos[i][1], pos[i][2], pos[i][3], 1, 1 )
	end
end