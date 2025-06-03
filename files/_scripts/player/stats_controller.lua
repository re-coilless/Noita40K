dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/unlock_cases.lua" )

local entity_id = GetUpdatedEntityID()
local player_stats = EntityGetFirstComponentIncludingDisabled( entity_id, "PlayerStatsComponent" )
local lives = ComponentGetValue2( player_stats, "lives" )

local stats_raw = ModSettingGetNextValue( "Noita40K.CLASS_STATS" )

if( lives < 1 ) then
	local active_class = tonumber( GlobalsGetValue( "ACTUAL_ACTIVE_CLASS", "1" ))
	local active_skin = tonumber( GlobalsGetValue( "ACTUAL_ACTIVE_SKIN", "1" ))
	local stats = DD_extractor( stats_raw )
	if( #unlock_cases > 0 ) then
		for i,case in ipairs( unlock_cases ) do
			local func = case.unlock
			if( func ~= nil ) then
				stats = func( active_class, active_skin, stats )
			end
		end
		
		ModSettingSetNextValue( "Noita40K.CLASS_STATS", DD_packer( stats ), false )
	end
	
	EntityRemoveComponent( entity_id, EntityGetFirstComponentIncludingDisabled( entity_id, "LuaComponent", "stats_controller" ))
end