local hooman = GetUpdatedEntityID()
local c_x, c_y, c_r, c_scale_x, c_scale_y = EntityGetTransform( hooman )
local visual = EntityGetClosestWithTag( c_x, c_y, "servoskull_visual" )
if( visual == nil or visual == 0 ) then
	EntityLoad( "mods/Noita40K/files/entities/misc/servoskull/servoskull_visual.xml", c_x, c_y )
end