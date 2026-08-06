return function( hooman, effect_id, is_added, is_removed )
	local dmg_comp = EntityGetFirstComponent( hooman, "DamageModelComponent" )
	if( not( pen.vld( dmg_comp, true ))) then return end
	
	local x, y = pen.get_creature_centre( hooman )
	local hp = ComponentGetValue2( dmg_comp, "hp" )
	local dmg = hp < 0.3 and 0.4 or math.max( 0.2, hp*0.001 )
	EntityInflictDamage( hooman, dmg, "DAMAGE_MATERIAL", "$n40k_MISC_dmg_burn", "NONE", 0, 0, nil, x, y, 0 )
end