dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )
local hb_x, hb_y = EntityGetFirstHitboxCenter( hooman )

local dam_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
if( dam_comp ~= nil ) then
	local current_hp = ComponentGetValue2( dam_comp, "hp" )
	if( current_hp < 0.3 ) then
		EntityInflictDamage( hooman, 0.4, "DAMAGE_MATERIAL", "[BURN, HERETIC]", "NONE", 0, 0, nil, hb_x, hb_y, 0 )
	else
		EntityInflictDamage( hooman, math.max( 0.2, current_hp*0.001 ), "DAMAGE_MATERIAL", "[BURN, HERETIC]", "NONE", 0, 0, nil, hb_x, hb_y, 0 )
	end
end