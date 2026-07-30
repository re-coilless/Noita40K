function damage_received( damage, message, entity_thats_responsible, is_fatal )
	dofile_once( "mods/n40k/files/_lib.lua" )
	
	if( damage <= 0 ) then return end

	local hooman = GetUpdatedEntityID()
	local charge = pen.magic_storage( hooman, "reactor_charge", "value_float", nil, 0 )
	if( charge > 0 ) then
		pen.magic_storage( hooman, "reactor_charge", "value_float", charge + 25*damage )
	else return end

	local dmg_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
	if( not( pen.vld( dmg_comp, true ))) then return end
	ComponentSetValue2( dmg_comp, "hp", ComponentGetValue2( dmg_comp, "hp" ) + damage )

	--apply invulner frames
	--electric damage type deals x10 the charge and leaks 10% of hp damage
end

return function( hooman ) --add invulner frames
	dofile_once( "mods/n40k/files/_lib.lua" )

	-- local blessing_comp = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "emperors_blessing" )
	-- local EMBERORS_NUMBER = 0
	-- if( blessing_comp ~= nil ) then
	-- 	EMBERORS_NUMBER = Random( 1, ComponentGetValue2( blessing_comp, "value_int" ))
	-- end

	-- if( EMBERORS_NUMBER == 1 and proj_damage > 0 ) then
	-- 	GamePrint( "The Emperor Protects." )
	-- 	ComponentSetValue2( proj_comp, "damage", 0 )
	-- 	proj_damage = 0
		
	-- 	local p_hitbox_offset = get_head_offset( hooman ) - 4
	-- 	EntityLoad( "mods/n40k/files/entities/emitters/blessed_iron_halo.xml", char_x, char_y + p_hitbox_offset )
	-- end

	-- damage threshold (below armor rating damage_recieved/armor_rating passes)

	pen.armorsim( hooman, { rating = 100, func = function( hooman, proj_id, x, y, data )
		--top 10% of armour should have double ricochet window
		--do blessing by having a chance to x10 armor rating after a deflection attempt until next deflection
		
		if( data.dmg > data.rating ) then
			local min_rico, max_rico = 65, 85
			local will_rico = data.d_angle > max_rico
			if( not( will_rico ) and data.d_angle > min_rico ) then
				will_rico = math.random() < ( data.d_angle - min_rico )/( max_rico - min_rico )
			end
			if( not( will_rico )) then return true end
		end

		--speed increases the damage, compare it against data.rating

		pen.magic_particles( x, y, math.rad( 180 ) + data.p_angle, {
			fading = 7, lifetime = 2,
			additive = true, emissive = true, count = { 2, 3 },
			
			alpha = 0.9, alpha_end = 0.1,
			color = { 237, 141, 45 },
			
			v_range = { 0, -50, 200, 50 }, slowdown = { -20, 0, 1 },
		})
		pen.play_sound( pen.S.N40K.EFFECT_PLING, x, y )
	end})
end