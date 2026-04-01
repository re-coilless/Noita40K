dofile_once( "data/scripts/lib/utilities.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )

function damage_received( damage, message, entity_thats_responsible, is_fatal  )
	local hooman = GetUpdatedEntityID()
	
	local heart_checker = GameHasFlagRun( "PERK_PICKED_SECOND_HEART" )
	local larraman_checker = GameHasFlagRun( "PERK_PICKED_LARRAMAN" )
	if( larraman_checker ) then
		larraman_checker = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "larraman_protects" ), "value_int" ) > 0
	end
	
	if( is_fatal and not( heart_checker or larraman_checker ) and not( GameHasFlagRun( "damage_was_prevented" ))) then
		local hp = ( component_get_value( hooman, "DamageModelComponent", "hp", 1 ) - damage )*25
		if( hp <= 0 ) then
			edit_component_ultimate( hooman, "DamageModelComponent", function(comp,vars)
				ComponentSetValue2( comp, "max_hp", ComponentGetValue2( comp, "max_hp" )*0.7 )
				ComponentSetValue2( comp, "hp", ComponentGetValue2( comp, "max_hp" ) + damage )
			end)
			GameAddFlagRun( "damage_was_prevented" )
			
			local effect_id = get_custom_effect( hooman, "stasis_coma" )
			if( effect_id == nil ) then
				LoadGameEffectEntityTo( hooman, "mods/Noita40K/files/entities/status_effects/effect_stasis_coma.xml" )
			else
				ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent", "main" ), "frames", 2000 )
			end
			ComponentSetValue2( GetGameEffectLoadTo( hooman, "BLINDNESS", true ), "frames", 1500 )
			ComponentSetValue2( GetGameEffectLoadTo( hooman, "MOVEMENT_SLOWER_2X", true ), "frames", 3600 )
			ComponentSetValue2( GetGameEffectLoadTo( hooman, "MOVEMENT_SLOWER", true ), "frames", -1 )
			
			new_notification( "ENTERED A STATE OF SUSPENDED ANIMATION", "Let your soul be armoured with Faith, driven on the tracks of Obedience which overcome all obstacles, and armed with the three great guns of Zeal, Duty and Purity.", false )
			
			GameRemoveFlagRun( "PERK_PICKED_SUS_AN" )
			EntityRemoveComponent( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "LuaComponent", "sus_an" ))
		end
	end
end