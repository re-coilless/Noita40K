dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local hooman = GetUpdatedEntityID()
local hole_comp = EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "fog_o_war_hole" )
if( hole_comp ~= nil ) then
	ComponentSetValueVector2( hole_comp, "transform_offset", 0, get_head_offset( hooman ))
	EntityRefreshSprite( hooman, hole_comp )
end