dofile_once( "data/scripts/magic/fungal_shift.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )
local c_x, c_y = EntityGetTransform( hooman )

SetRandomSeed( c_x, c_y + GameGetFrameNum())
local lua_comp = EntityGetFirstComponentIncludingDisabled( effect_id, "LuaComponent", "shift" )
ComponentSetValue2( lua_comp, "execute_every_n_frame", Random( 60, 180 ))

fungal_shift_simple( effect_id, c_x, c_y )