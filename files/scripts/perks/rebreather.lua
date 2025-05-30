local hooman = GetUpdatedEntityID()
local dmg_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
if( not( ComponentGetValue2( dmg_comp, "mAirDoWeHave" ))) then
	ComponentSetValue2( dmg_comp, "air_in_lungs", ComponentGetValue2( dmg_comp, "air_in_lungs_max" ))
end