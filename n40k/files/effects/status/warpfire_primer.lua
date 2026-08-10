return function( hooman, effect_id, is_added, is_removed )
	if( pen.vld( pen.get_effect( hooman, "n40k_effect_warpfire" ), true )) then return end
	LoadGameEffectEntityTo( hooman, "mods/n40k/files/effects/status/warpfire.xml" )
end