local hooman = GetUpdatedEntityID()
local c_x, c_y, c_r, c_scale_x, c_scale_y = EntityGetTransform( hooman )
local owner = EntityGetClosestWithTag( c_x, c_y, "servoskull" )
if( owner ~= nil and owner ~= 0 ) then
	local o_x, o_y, o_r, o_scale_x, o_scale_y = EntityGetTransform( owner )
	if( o_x == o_x and o_y == o_y ) then
		EntitySetTransform( hooman, o_x, o_y, o_r, o_scale_x, o_scale_y )
		local children = EntityGetAllChildren( hooman ) or {}
		if( #children > 0 ) then
			for i,child in ipairs( children ) do
				local k_x, k_y, k_r, k_scale_x, k_scale_y = EntityGetTransform( child )
				EntitySetTransform( child, k_x + ( o_x - c_x ), k_y + ( o_y - c_y ), k_r, k_scale_x, k_scale_y )
			end
		end
	end
end