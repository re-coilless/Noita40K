dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )

local frames_left = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent", "main" ), "frames" )
if( frames_left < 1000 ) then
	if( EntityHasTag( effect_id, "stasis_coma" )) then
		if( not( EntityHasTag( hooman, "player_unit" ))) then
			for i,comp in ipairs( ai_comps ) do
				local comp_id = EntityGetFirstComponentIncludingDisabled( hooman, comp ) or 0
				if( comp_id ~= 0 ) then
					EntitySetComponentIsEnabled( hooman, comp_id, true )
				end
			end
		end
		
		EntityRemoveTag( effect_id, "stasis_coma" )
	end
elseif( not( EntityHasTag( effect_id, "stasis_coma" ))) then
	if( not( EntityHasTag( hooman, "player_unit" ))) then
		for i,comp in ipairs( ai_comps ) do
			local comp_id = EntityGetFirstComponentIncludingDisabled( hooman, comp ) or 0
			if( comp_id ~= 0 ) then
				EntitySetComponentIsEnabled( hooman, comp_id, false )
			end
		end
		
		EntityAddTag( effect_id, "stasis_coma" )
	end
end