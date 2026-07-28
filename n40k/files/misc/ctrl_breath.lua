return function( hooman )
	local dmg_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
	if( not( pen.vld( dmg_comp, true ))) then return end
	if( ComponentGetValue2( dmg_comp, "mAirDoWeHave" )) then return end
	ComponentSetValue2( dmg_comp, "air_in_lungs", ComponentGetValue2( dmg_comp, "air_in_lungs_max" ))
end