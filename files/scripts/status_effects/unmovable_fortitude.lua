dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )

local frames_left = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent", "main" ), "frames" )
if( frames_left > 0 ) then
	if( not( EntityHasTag( effect_id, "unmovable_fortitude" ))) then
		edit_component_ultimate( hooman, "DamageModelComponent", function(comp,vars)
			ComponentObjectSetValue2( comp, "damage_multipliers", "melee", ComponentObjectGetValue2( comp, "damage_multipliers", "melee" )*0.5 )
		end)
		
		EntityAddComponent( hooman, "LuaComponent", 
		{ 
			_tags = "unmovable_fortitude",
			script_damage_received = "mods/Noita40K/files/scripts/status_effects/unmovable_fortitude_protection.lua",
			execute_every_n_frame = "-1",
		})
		
		EntityAddTag( effect_id, "unmovable_fortitude" )
	end
else
	edit_component_ultimate( hooman, "DamageModelComponent", function(comp,vars)
		ComponentObjectSetValue2( comp, "damage_multipliers", "melee", ComponentObjectGetValue2( comp, "damage_multipliers", "melee" )*2 )
	end)
	
	EntityRemoveComponent( hooman, EntityGetFirstComponentIncludingDisabled( hooman, "LuaComponent", "unmovable_fortitude" ))
	EntityKill( effect_id )
end