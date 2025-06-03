dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local hooman = GetUpdatedEntityID()

local aim_gone = GameGetGameEffect( hooman, "DRUNK" )
if( aim_gone ~= 0 and ComponentGetValue2( aim_gone, "effect" ) ~= "NONE" ) then
	ComponentSetValue2( aim_gone, "effect", "NONE" )
end

local brains_gone, drunk_effect, effect_id = get_custom_effect( hooman, "INGESTION_DRUNK", "$status_ingestion_alcoholic_00" )
if( brains_gone ~= nil ) then
	local status_comp = EntityGetFirstComponentIncludingDisabled( hooman, "StatusEffectDataComponent" )
	for i,timer in ipairs( ComponentGetValue2( status_comp, "ingestion_effects" )) do
		if( i - 1 == effect_id and timer > 0 ) then
			if( timer < 50 or EntityHasTag( hooman, "robot" )) then
				EntityRemoveIngestionStatusEffect( hooman, "INGESTION_DRUNK" )
			end
			break
		end
	end
end