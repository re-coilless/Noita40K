local hooman = GetUpdatedEntityID()

local storage_energy_cap = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "energy_cap" )
local storage_energy_cur = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "energy_cur" )
local storage_energy_max = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "stable_value" )
local energy_cap = ComponentGetValue2( storage_energy_cap, "value_float" )
local energy_cur = ComponentGetValue2( storage_energy_cur, "value_float" )
local stable_value = ComponentGetValue2( storage_energy_max, "value_int" )*energy_cap/100

local char_x, char_y = EntityGetTransform( hooman )
if( energy_cur > energy_cap ) then
	if( not( EntityHasTag( hooman, "system_overload" ))) then
		GamePlayAnimation( hooman, "knockback", 100 )
		GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/status_effects/overload/create", char_x, char_y )
		EntityAddTag( hooman, "system_overload" )
	end
	LoadGameEffectEntityTo( hooman, "mods/Noita40K/files/entities/status_effects/effect_system_overload.xml" )
elseif( EntityHasTag( hooman, "system_overload" )) then
	GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "fx/status_effects/overload/game_effect_end", char_x, char_y )
	EntityRemoveTag( hooman, "system_overload" )
end

if( GameHasFlagRun( "PERK_PICKED_ETERNAL_VIGILANCE" )) then
	local ui_mode_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "explorator_mode" )
	if( ComponentGetValue2( ui_mode_storage, "value_bool")) then
		stable_value = 0
	end
end

if( energy_cur ~= stable_value ) then
	local new_cur = 0
	if( energy_cur > stable_value ) then
		new_cur = energy_cur - 0.2
		if( new_cur < 0) then
			new_cur = 0
		end
	else
		new_cur = energy_cur + 0.05
		if( new_cur > stable_value ) then
			new_cur = stable_value
		end
	end
	
	ComponentSetValue2( storage_energy_cur, "value_float", new_cur )
end