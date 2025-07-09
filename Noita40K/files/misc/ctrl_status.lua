return function( hooman )
	local filter = {
		{{ "CONFUSION", "CONFUSION" }, "$status_confusion", 50 },
		{{ "INTERNAL_ICE", "INGESTION_FREEZING" }, "$status_ingestion_freezing", 50 },
		{{ "INTERNAL_FIRE", "INGESTION_ON_FIRE" }, "$status_internal_fire", 50 },
		{{ "DRUNK", "ALCOHOLIC" }, "$status_alcoholic", 200 },
		{{ "DRUNK", "INGESTION_DRUNK" }, "$status_ingestion_alcoholic_00", 200 },
		{{ "DRUNK", "INGESTION_DRUNK" }, "$status_ingestion_alcoholic_01", 200 },
		{{ "DRUNK", "INGESTION_DRUNK" }, "$status_ingestion_alcoholic_02", 200 },
		{{ "POISON", "POISONED" }, "$status_poisoned", 200 },
		{{ "TRIP_00", "TRIP" }, "$status_trip_00", 200 },
		{{ "TRIP_00", "TRIP" }, "$status_trip_01", 200 },
		{{ "TRIP_00", "TRIP" }, "$status_trip_02", 200 },
		{{ "TRIP_00", "TRIP" }, "$status_trip_03", 200 },
		{{ "FOOD_POISONING", "FOOD_POISONING" }, "$status_food_poisoning", 200 },
		{{ "FARTS", "FARTS" }, "$status_farts", 200 },
		{{ "RAINBOW_FARTS", "RAINBOW_FARTS" }, "$status_rainbow_farts", 200 },
	}
	
	--obtain pack encoded override list from the var storage
	
	local status_comp = EntityGetFirstComponentIncludingDisabled( hooman, "StatusEffectDataComponent" )
	if( not( pen.vld( status_comp, true ))) then return end
	local ingestions = ComponentGetValue2( status_comp, "ingestion_effects" )
	
	pen.t.loop( filter, function( i, e )
		local effect_id, comp, status_id = pen.get_effect( hooman, e[1][1], e[2])
		if( not( pen.vld( effect_id, true ))) then return end
		
		local frames = ComponentGetValue2( comp, "frames" )
		for i,timer in ipairs( ingestions ) do
			if(( i - 1 ) == status_id ) then frames = -timer; break end
		end
		
		local threshold = e[3]
		if( math.abs( frames ) > threshold ) then return end
		if( frames < 0 ) then EntityRemoveIngestionStatusEffect( hooman, e[1][2]) end
		if( ComponentGetValue2( comp, "effect" ) ~= "NONE" ) then ComponentSetValue2( comp, "effect", "NONE" ) end
	end)
end