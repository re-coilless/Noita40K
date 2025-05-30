dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )

function damage_received( damage, message, entity_thats_responsible, is_fatal )
	if( damage > 0 and not( GameHasFlagRun( "damage_was_prevented" ))) then
		local hooman = GetUpdatedEntityID()
		
		local storage_energy_cap = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "energy_cap" )
		local energy_cap = ComponentGetValue2( storage_energy_cap, "value_float" )
		local storage_energy_cur = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "energy_cur" )
		local energy_cur = ComponentGetValue2( storage_energy_cur, "value_float" )
		
		if( energy_cur < energy_cap ) then
			edit_component_ultimate( hooman, "DamageModelComponent", function(comp,vars)
				ComponentSetValue2( comp, "hp", ComponentGetValue2( comp, "hp" ) + damage )
			end)
			GameAddFlagRun( "damage_was_prevented" )
			
			local stress = energy_cur + damage*25*3
			ComponentSetValue2( storage_energy_cur, "value_float", stress )
		else
			new_console_entry( hooman, "Direct damage.", 0 )
		end
	end
end