local hooman = GetUpdatedEntityID()
local x, y, r, s_x, s_y = EntityGetTransform( hooman )
if( s_x < 0 ) then
	EntitySetTransform( hooman, x - 1, y, r, s_x, s_y )
end

local parent = EntityGetParent( hooman )
if( EntityHasTag( parent, "target_teleported" )) then
	local path = "mods/Noita40K/files/entities/misc/servoskull/"..EntityGetTags( hooman )..".xml"
	EntityAddChild( parent, EntityLoad( path, x, y )) --absolute cringe
	EntityKill( hooman )
end