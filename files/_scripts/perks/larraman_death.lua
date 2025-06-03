dofile_once( "data/scripts/lib/utilities.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )

function damage_received( damage, message, entity_thats_responsible, is_fatal  )
	if( is_fatal and not( GameHasFlagRun( "PERK_PICKED_SECOND_HEART" )) and not( GameHasFlagRun( "damage_was_prevented" ))) then
		local hooman = GetUpdatedEntityID()
		local char_x, char_y = EntityGetTransform( hooman )
		
		local hp = ( component_get_value( hooman, "DamageModelComponent", "hp", 1 ) - damage )*25
		local storage_uses = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "larraman_protects" )
		if( hp <= 0 ) then
			SetRandomSeed( GameGetFrameNum(), ( entity_thats_responsible or 0 ) + damage + hooman )
			while( true ) do
				local uses_left = ComponentGetValue2( storage_uses, "value_int" )
				ComponentSetValue2( storage_uses, "value_int", uses_left - 1 )
				
				if( uses_left < 1 ) then
					EntityRemoveComponent( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "LuaComponent", "larraman_death" ))
					break
				elseif( Random( 1, uses_left ) == 1 ) then					
					edit_component_ultimate( hooman, "DamageModelComponent", function(comp,vars)
						ComponentSetValue2( comp, "hp", 0.04 + damage )
						ComponentSetValue2( comp, "invincibility_frames", 30 )
					end)
					GameAddFlagRun( "damage_was_prevented" )
					
					local p_hitbox_offset = get_head_offset( hooman ) - 4
					EntityLoad( "mods/Noita40K/files/entities/emitters/blessed_iron_halo.xml", char_x, char_y + p_hitbox_offset )
					GlobalsSetValue( "BLESSED_EDGE_EFFECT", tostring( 0.5 ))
					GamePrint( quote[uses_left] )
					break
				end
			end
		end
	end
end