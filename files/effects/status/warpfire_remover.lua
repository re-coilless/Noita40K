dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

function material_area_checker_success( x, y )
	GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/game_effect_end", x, y )
	local effect_id = GetUpdatedEntityID()
	set_shader( EntityGetRootEntity( effect_id ), "warpfire_edge_effect", true )
	EntityKill( effect_id )
end