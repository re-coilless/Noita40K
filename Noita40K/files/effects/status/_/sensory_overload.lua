dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local effect_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( effect_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )

local frames_left = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( effect_id, "GameEffectComponent", "main" ), "frames" )
if( frames_left < 300 ) then
	if( EntityHasTag( effect_id, "sensory_overload" )) then
		if( EntityHasTag( hooman, "player_unit" )) then
			ComponentSetValue2( ctrl_comp, "enabled", true )
		else
			for i,comp in ipairs( ai_comps ) do
				local comp_id = EntityGetFirstComponentIncludingDisabled( hooman, comp ) or 0
				if( comp_id ~= 0 ) then
					EntitySetComponentIsEnabled( hooman, comp_id, true )
				end
			end
		end
		
		EntityRemoveTag( effect_id, "sensory_overload" )
	end
elseif( not( EntityHasTag( effect_id, "sensory_overload" ))) then
	EntityAddTag( effect_id, "sensory_overload" )
	ComponentSetValueVector2( EntityGetFirstComponentIncludingDisabled( effect_id, "SpriteComponent" ), "transform_offset", 0, get_head_offset( hooman )/2 )
	
	if( EntityHasTag( hooman, "player_unit" )) then
		local char_x, char_y = EntityGetTransform( hooman )
		GamePlaySound( "mods/Noita40K/files/40K.bank", "player/concussion", char_x, char_y )
		ComponentSetValue2( ctrl_comp, "enabled", false )
	else
		for i,comp in ipairs( ai_comps ) do
			local comp_id = EntityGetFirstComponentIncludingDisabled( hooman, comp ) or 0
			if( comp_id ~= 0 ) then
				EntitySetComponentIsEnabled( hooman, comp_id, false )
			end
		end
	end
end