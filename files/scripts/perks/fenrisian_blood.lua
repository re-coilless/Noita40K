dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local hooman = GetUpdatedEntityID()

local brains_gone, drunk_effect, effect_id = get_custom_effect( hooman, "INGESTION_DRUNK", "$status_ingestion_alcoholic_00" )
if( brains_gone ~= nil ) then
	local frames_left = 0
	local status_comp = EntityGetFirstComponentIncludingDisabled( hooman, "StatusEffectDataComponent" )
	for i,timer in ipairs( ComponentGetValue2( status_comp, "ingestion_effects" )) do
		if( i - 1 == effect_id and timer > 0 ) then
			frames_left = timer*60
			break
		end
	end
	
	local effect = get_custom_effect( hooman, "untamed" )
	if( effect ~= nil ) then
		local effect_comp = EntityGetFirstComponentIncludingDisabled( effect, "GameEffectComponent", "main" )
		ComponentSetValue2( effect_comp, "frames", frames_left )
	else
		LoadGameEffectEntityTo( hooman, "mods/Noita40K/files/entities/status_effects/effect_untamed.xml" )
	end
else
	local effect = get_custom_effect( hooman, "untamed" )
	if( effect ~= nil ) then
		EntityKill( effect )
	end
end