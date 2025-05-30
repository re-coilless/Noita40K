dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )

function damage_received( damage, message, entity_thats_responsible, is_fatal  )
	if( is_fatal and not( GameHasFlagRun( "damage_was_prevented" ))) then
		local hooman = GetUpdatedEntityID()
		
		edit_component_ultimate( hooman, "DamageModelComponent", function(comp,vars)
			ComponentSetValue2( comp, "hp", 1 + damage )
			ComponentSetValue2( comp, "invincibility_frames", 60 )
		end)
		new_notification( "SECONDARY HEART SAVED YOU", "And in the dark when the shadows threaten, the Emperor is with us, in spirit and in fact.", false )
		
		GameAddFlagRun( "damage_was_prevented" )
		GameRemoveFlagRun( "PERK_PICKED_SECOND_HEART" )
		EntityRemoveComponent( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "LuaComponent", "double_heart" ))
	end
end