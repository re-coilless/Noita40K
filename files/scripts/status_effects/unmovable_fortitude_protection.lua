dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

function damage_received( damage, message, entity_thats_responsible, is_fatal  )
	if( message == "$damage_melee" and not( GameHasFlagRun( "damage_was_prevented" ))) then
		local hooman = GetUpdatedEntityID()
		
		if( damage < 1 ) then
			edit_component_ultimate( hooman, "DamageModelComponent", function(comp,vars)
				ComponentSetValue2( comp, "hp", ComponentGetValue2( comp, "hp" ) + damage )
				ComponentSetValue2( comp, "invincibility_frames", 15 )
			end)
			GameAddFlagRun( "damage_was_prevented" )
		end
	end
end