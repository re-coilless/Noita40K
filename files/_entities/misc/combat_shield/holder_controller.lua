dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local entity_id = GetUpdatedEntityID()
local children = EntityGetAllChildren( entity_id ) or {}
if( #children > 0 ) then
	local shield_id = children[1]
	local hooman = EntityGetRootEntity( entity_id )
	local c_x, c_y, c_r, c_s_x, c_s_y = EntityGetTransform( hooman )
	
	local a_x, a_y = EntityGetTransform( EntityGetClosestWithTag( c_x, c_y, "player_arm_r" ))
	local total_x = c_x + math.abs( c_s_x )/c_s_x*ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "character" ), "offset_x" )*0.7
	local total_y = a_y
	EntitySetTransform( shield_id, total_x, total_y, c_r, math.abs( c_s_x )/c_s_x, c_s_y )
	
	local effect_id = get_custom_effect( hooman, "unmovable_fortitude" )
	if( effect_id == nil ) then
		LoadGameEffectEntityTo( hooman, "mods/Noita40K/files/entities/status_effects/effect_unmovable_fortitude.xml" )
	else
		ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent", "main" ), "frames", 2 )
	end
end