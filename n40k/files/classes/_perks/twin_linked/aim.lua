local l_arm = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( l_arm )

local aim_x, aim_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" ), "mAimingVector" )
local ctrl_comp = EntityGetFirstComponentIncludingDisabled( l_arm, "ControlsComponent" )
ComponentSetValueVector2( ctrl_comp, "mAimingVector", aim_x, aim_y )
ComponentSetValue2( ctrl_comp, "mMousePosition", aim_x*1000, aim_y*1000 )

local char_comp = EntityGetFirstComponentIncludingDisabled( l_arm, "CharacterDataComponent" )
local default_x, default_y = GetValueNumber( "default_recoil_x", 0 ), GetValueNumber( "default_recoil_y", 200 )
local r_x, r_y = ComponentGetValue2( char_comp, "mVelocity" )
if( r_x ~= default_x or r_y ~= default_y ) then
	local last_x, last_y = GetValueNumber( "last_recoil_x", 0 ), GetValueNumber( "last_recoil_y", 0 )
	if( last_x == default_x and last_y == default_y ) then
		local data_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterDataComponent" ) or 0
		if( data_comp > 0 ) then
			local v_x, v_y = ComponentGetValue2( data_comp, "mVelocity" )
			ComponentSetValue2( data_comp, "mVelocity", v_x + ( r_x - default_x ), v_y + ( r_y - default_y ))
		end
	elseif( last_x == r_x and last_y == r_y ) then
		SetValueNumber( "default_recoil_x", r_x )
		SetValueNumber( "default_recoil_y", r_y )
	end
	ComponentSetValue2( char_comp, "mVelocity", default_x, default_y )
end
SetValueNumber( "last_recoil_x", r_x )
SetValueNumber( "last_recoil_y", r_y )