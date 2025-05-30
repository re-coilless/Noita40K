local hooman = GetUpdatedEntityID()
local parent = EntityGetParent( hooman )
local x, y, r, s_x, s_y = EntityGetTransform( hooman )

local d_x, d_y = 0, 0
if( EntityGetFirstComponent( parent, "VelocityComponent" ) ~= nil ) then
	d_x, d_y = GameGetVelocityCompVelocity( parent )
else
	local this_x = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( parent, "VariableStorageComponent", "this_x" ), "value_float" )
	local this_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( parent, "VariableStorageComponent", "this_y" ), "value_float" )
	local last_x = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( parent, "VariableStorageComponent", "last_x" ), "value_float" )
	local last_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( parent, "VariableStorageComponent", "last_y" ), "value_float" )
	d_x = this_x - last_x
	d_y = this_y - last_y
	local a, b, c, d, e = EntityGetTransform( parent )
end

EntitySetTransform( hooman, x + d_x, y + d_y, r, s_x, s_y )