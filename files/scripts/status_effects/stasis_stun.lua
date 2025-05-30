dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )

local frames_left = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent", "main" ), "frames" )
if( frames_left > 0 ) then
	if( EntityHasTag( hooman, "stasis_stun_applied" ) and not( EntityHasTag( effect_id, "stasis_stun" ))) then
		EntitySetName( effect_id, "gonna_die" )
		local actual_effect_id = get_custom_effect( hooman, "stasis_stun" )
		local effect_comp = EntityGetFirstComponentIncludingDisabled( actual_effect_id, "GameEffectComponent", "main" )
		ComponentSetValue2( effect_comp, "frames", 120 )
		EntityKill( effect_id )
	else
		if( frames_left < 60 ) then
			if( EntityHasTag( effect_id, "stasis_stun_activated" )) then
				if( not( EntityHasTag( hooman, "player_unit" ))) then
					for i,comp in ipairs( ai_comps ) do
						local comp_id = EntityGetFirstComponentIncludingDisabled( hooman, comp ) or 0
						if( comp_id ~= 0 ) then
							EntitySetComponentIsEnabled( hooman, comp_id, true )
						end
					end
				end
				
				EntityRemoveTag( effect_id, "stasis_stun_activated" )
			end
		elseif( not( EntityHasTag( effect_id, "stasis_stun_activated" ))) then
			if( not( EntityHasTag( hooman, "player_unit" ))) then
				for i,comp in ipairs( ai_comps ) do
					local comp_id = EntityGetFirstComponentIncludingDisabled( hooman, comp ) or 0
					if( comp_id ~= 0 ) then
						EntitySetComponentIsEnabled( hooman, comp_id, false )
					end
				end
				
				EntityAddTag( effect_id, "stasis_stun" )
				EntityAddTag( effect_id, "stasis_stun_activated" )
			end
		end
		
		if( not( EntityHasTag( hooman, "stasis_stun_applied" ))) then
			EntityAddTag( hooman, "stasis_stun_applied" )
		end
	end
elseif( EntityHasTag( hooman, "stasis_stun_applied" )) then
	EntityRemoveTag( hooman, "stasis_stun_applied" )
end