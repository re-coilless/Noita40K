dofile_once( "mods/Noita40K/files/_lib.lua" )

local root_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( root_id )
local hooman = EntityGetRootEntity( root_id )
local limbs = EntityGetAllChildren( root_id )

local is_enabled = pen.magic_storage( root_id, "is_active", "value_bool" )
if( is_enabled ) then
	is_enabled = pen.magic_storage( hooman, "reactor_charge", "value_float", nil, 0 ) > 0 end
if( not( is_enabled )) then
	for i,limb_id in ipairs( limbs ) do
		pen.magic_storage( limb_id, "is_active", "value_bool", false )
	end
	return
end

--shift the center of search distance towards the direction the player is trying to move

local section = math.rad( 360 )/#limbs
local step = math.rad( pen.magic_storage( root_id, "step", "value_float" ))
local amount = math.floor( section/step )

local is_valid = false
pen.t.loop( limbs, function( i,limb_id )
	if( pen.magic_storage( limb_id, "is_active", "value_bool" )) then
		if( pen.magic_storage( limb_id, "is_going", "value_bool" )) then return end

		local acc = 2.5
		local c_x, c_y = EntityGetTransform( pen.get_child( limb_id, "foot" ))
		local check_1 = RaytracePlatforms( c_x - acc, c_y - acc, c_x + acc, c_y + acc )
		local check_2 = RaytracePlatforms( c_x - acc, c_y + acc, c_x + acc, c_y - acc )
		
		is_valid = true
		if( check_1 and check_2 ) then return end
	end

	local is_done = false
	local range = pen.magic_storage(
		limb_id, "max_length", "value_float" ) - 5
	local sweep = math.rad( -90 ) + ( i - 1 )*section
	for k = 0,amount do
		local t_x = x + range*math.cos( sweep )
		local t_y = y + range*math.sin( sweep )
		local is_hit, hit_x, hit_y = RaytracePlatforms( x, y, t_x, t_y )
		if( is_hit ) then --check for exclusion areas
			is_done = true
			pen.magic_storage( limb_id, "is_active", "value_bool", true )
			pen.magic_storage( limb_id, "target_x", "value_float", hit_x )
			pen.magic_storage( limb_id, "target_y", "value_float", hit_y )
			break
		end

		sweep = sweep + step
	end

	if( not( is_done )) then
		pen.magic_storage( limb_id, "is_active", "value_bool", false )
	else is_valid = true end
end)

if( not( is_valid )) then return end

--wriggling sound

local force = pen.magic_storage( root_id, "force", "value_float" )
local decay = pen.magic_storage( root_id, "decay", "value_float" )
local resistance = pen.magic_storage( root_id, "resistance", "value_float" )
local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
local char_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterDataComponent" )
local plat_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterPlatformingComponent" )

local w_down = ComponentGetValue2( ctrl_comp, "mButtonDownUp" )
local s_down = ComponentGetValue2( ctrl_comp, "mButtonDownDown" )
local a_down = ComponentGetValue2( ctrl_comp, "mButtonDownLeft" )
local d_down = ComponentGetValue2( ctrl_comp, "mButtonDownRight" )
local v_x, v_y = ComponentGetValue2( char_comp, "mVelocity" )
v_x, v_y = resistance*v_x, resistance*v_y

local a_name = "fly_idle"
if( not( w_down or s_down or a_down or d_down )) then
	v_x, v_y = decay*v_x, decay*v_y
else a_name = "fly_move" end

--check distance to walls in all directions (elongated cross checks the size of hitbox)
--prevent moving closer than min allowed and further than max allowed unless shift is held
--holding shift with no keys pressed divides the decay by 10

v_y = v_y - pen.get_gravity( hooman )
if( w_down ) then v_y = v_y - force/2 end
if( s_down ) then v_y = v_y + force/2 end
if( a_down ) then v_x = v_x - force end
if( d_down ) then v_x = v_x + force end
ComponentSetValue2( char_comp, "mVelocity", v_x, v_y )
GamePlayAnimation( hooman, a_name, 1 )

--mark the zones that are empty and repeat the scans in other sections if less than 2 legs are valid