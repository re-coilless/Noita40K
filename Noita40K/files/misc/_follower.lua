dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local hooman = GetUpdatedEntityID()
local owner = get_tagged_id( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "storage_owner" ), "value_string" ))

if( owner ~= nil and owner ~= 0 and EntityGetIsAlive( owner )) then
	local c_x, c_y, c_r, c_scale_x, c_scale_y = EntityGetTransform( hooman )
	local o_x, o_y = EntityGetTransform( owner )
	if( c_x == c_x and c_y == c_y ) then --nan value is considered not equal to any value, including itself
		o_y = o_y + get_head_offset( owner )
		
		local d_x = o_x - c_x
		local d_y = o_y - c_y
		if( math.abs( d_x ) > 300 or math.abs( d_y ) > 300 ) then
			EntityAddTag( hooman, "target_teleported" )
		elseif( EntityHasTag( hooman, "target_teleported" ) ) then
			EntityRemoveTag( hooman, "target_teleported" )
		end
		
		local speed = 0.2
		local max_dist = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "max_dist" ), "value_int" )
		local dist = math.sqrt(( d_x )^2 + ( d_y )^2 )
		local k = dist/max_dist - 1
		function f( a )
			if( math.abs( a ) > 300 ) then
				return get_sign( a )*( math.abs( a ) - 250 )
			end
			
			if( k > 0 ) then
				return math.log( math.abs( a + 1 ))*get_sign( a )*speed*( math.abs( a )/max_dist )
			else
				return 0
			end
		end
		
		local fdx = f( d_x )
		local fdy = f( d_y )
		if( fdx == fdx and fdy == fdy ) then
			EntitySetTransform( hooman, c_x + fdx, c_y + fdy, c_r, get_sign( d_x ), c_scale_y )
			local children = EntityGetAllChildren( hooman ) or {}
			if( #children > 0 ) then
				for i,child in ipairs( children ) do
					c_x, c_y, c_r, c_scale_x, c_scale_y = EntityGetTransform( child )
					EntitySetTransform( child, c_x + fdx, c_y + fdy, c_r, c_scale_x, c_scale_y )
				end
			end
		else
			GamePrint( "[CRITICAL TRACKING ERROR] - Skipping Cycle" )
		end
	else
		GamePrint( "[CRITICAL TRACKING ERROR] - Position Reset" )
		EntitySetTransform( hooman, o_x, o_y, c_r, c_scale_x, c_scale_y )
	end
end