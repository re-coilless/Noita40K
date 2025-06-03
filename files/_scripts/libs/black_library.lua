dofile_once( "data/scripts/lib/utilities.lua" )

--utility lists
ai_comps = {
	"AIAttackComponent",
	"AdvancedFishAIComponent",
	"AnimalAIComponent",
	"BossDragonComponent",
	"ControllerGoombaAIComponent",
	"CrawlerAnimalComponent",
	"FishAIComponent",
	"PhysicsAIComponent",
	"WormAIComponent",
}

--core backend
function b2n( a )
	return a and 1 or 0
end

function n2b( a )
	if( a > 0 ) then
		return true
	else
		return false
	end
end

function t2l( str )
	local t = {}
	
	for line in string.gmatch( str, "([^\r\n]+)" ) do
		table.insert( t, line )
	end
	
	return t
end

function t2w( str )
	local t = {}
	
	for word in string.gmatch( str, "([^%s]+)" ) do
		table.insert( t, word )
	end
	
	return t
end

function rgb2hsv( colour )
	local r, g, b, a = colour[1], colour[2], colour[3], colour[4]

	local h = 0
	local s = 0
	local v = math.max( r, g, b )
	local temp = math.min( r, g, b )

	local d = v - temp
	if( v == 0 ) then
		s = 0
	else
		s = d/v
	end
	
	if( v == temp ) then
		h = 0
	else
		if( v == r ) then
			h = ( g - b )/d
			if( g < b ) then
				h = h + 6
			end
		elseif( v == g ) then
			h = ( b - r )/d + 2
		elseif( v == b ) then
			h = ( r - g )/d + 4
		end
		h = h/6
	end
	
	return { h, s, v, a }
end

function hsv2rgb( colour )
	local h, s, v, a = colour[1], colour[2], colour[3], colour[4]
	local r, g, b = 0, 0, 0
	
	local i = math.floor( h*6 )
	local f = h*6 - i
	local p = v*( 1 - s )
	local q = v*( 1 - f*s )
	local t = v*( 1 - ( 1 - f )*s )
	
	i = i%6
	if( i == 0 ) then
		r, g, b = v, t, p
	elseif( i == 1 ) then
		r, g, b = q, v, p
	elseif( i == 2 ) then
		r, g, b = p, v, t
	elseif( i == 3 ) then
		r, g, b = p, q, v
	elseif( i == 4 ) then
		r, g, b = t, p, v
	elseif( i == 5 ) then
		r, g, b = v, p, q
	end
	
	return { r, g, b, a }
end

function binsearch( tbl, value )
	local low = 1
	local high = #tbl
		
	while( high >= low ) do
		local middle = math.floor(( low + high )/2 + 0.5)
		if( tbl[middle] < value ) then
			low = middle + 1
		elseif( tbl[middle] > value ) then
			high = middle - 1
		elseif( tbl[middle] == value ) then
			return middle
		end
	end
	
	return nil
end

function magic_sorter( tbl, func )
    local out_tbl = {}
    for n in pairs( tbl ) do
        table.insert( out_tbl, n )
    end
    table.sort( out_tbl, func )
    local i = 0
    local iter = function ()
        i = i + 1
        if out_tbl[i] == nil then
            return nil
        else
            return out_tbl[i], tbl[out_tbl[i]]
        end
    end
    return iter
end

function add_table( a, b )
	if( #b > 0 ) then
		table.sort( b )
		if( #a > 0 ) then
			for m,new in ipairs( b ) do 
				if( binsearch( a, new ) == nil ) then
					table.insert( a, new )
				end
			end
			
			table.sort( a )
		else
			a = b
		end
	end
	
	return a
end

function get_sign( a )
	if( a > 0 ) then
		return 1
	else
		return -1
	end
end

function D_extractor( data_raw, use_string )
	if( data_raw == nil ) then
		return nil
	end
	use_string = use_string or false
	
	local data = {}
	
	for value in string.gmatch( data_raw, "([^|]+)" ) do
		if( use_string ) then
			table.insert( data, value )
		else
			table.insert( data, tonumber( value ))
		end
	end
	
	return data
end

function D_packer( data )
	if( data == nil ) then
		return nil
	end

	local data_raw = "|"
	
	for i,value in ipairs( data ) do
		data_raw = data_raw..value.."|"
	end
	
	return data_raw
end

function DD_extractor( data_raw, use_string )
	if( data_raw == nil ) then
		return nil
	end
	use_string = use_string or false
	
	local data = {}
	
	for subdata_raw in string.gmatch( data_raw, "([^|]+)" ) do
		local subdata = {}
		for value in string.gmatch( subdata_raw, "([^:]+)" ) do
			if( use_string ) then
				table.insert( subdata, value )
			else
				table.insert( subdata, tonumber( value ))
			end
		end
		table.insert( data, subdata )
	end
	
	return data
end

function DD_packer( data )
	if( data == nil ) then
		return nil
	end
	
	local data_raw = "|"
	
	for i,subdata in ipairs( data ) do
		for e,value in ipairs( subdata ) do
			data_raw = data_raw..":"..value
			if( e == #subdata ) then
				data_raw = data_raw..":"
			end
		end
		data_raw = data_raw.."|"
	end
	
	return data_raw
end

--ECS backend
function edit_component_ultimate( entity_id, type_name, do_what )
	if( not( is_valid_entity( entity_id ))) then
		return  
	end
	
	local comp = EntityGetFirstComponentIncludingDisabled( entity_id, type_name )
	if( comp ~= nil ) then
		local modified_vars = { }
		do_what( comp, modified_vars )
		for key,value in pairs( modified_vars ) do 
			ComponentSetValue( comp, key, to_string(value) )
		end
	end
end

function edit_component_with_tag_ultimate( entity_id, type_name, tag, do_what )
	if( not( is_valid_entity( entity_id ))) then
		return
	end
	
	local comp = EntityGetFirstComponentIncludingDisabled( entity_id, type_name, tag )
	if( comp ~= nil ) then
		local modified_vars = { }
		do_what( comp, modified_vars )
		for key,value in pairs( modified_vars ) do 
			ComponentSetValue( comp, key, to_string(value) )
		end
	end
end

function get_variable_storage_component_ultimate( entity_id, name )
	if not is_valid_entity( entity_id ) then  
		return nil
	end
	
	local comps = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" ) or {}
	if( #comps > 0 ) then
		for _,comp_id in pairs( comps ) do 
			local var_name = ComponentGetValue2( comp_id, "name" )
			if( var_name == name ) then
				return comp_id
			end
		end
	end
	
	return nil
end

function shoot_projectile_ultimate( who_shot, entity_file, x, y, v_x, v_y, do_thing, proj_mods, custom_values )
	do_thing = do_thing or true
	
	local entity_id = EntityLoad( entity_file, x, y )
	local herd_id = get_herd_id( who_shot )
	
	if( do_thing ) then
		GameShootProjectile( who_shot, x, y, x + v_x, y + v_y, entity_id, false )
	end
	
	edit_component( entity_id, "ProjectileComponent", function(comp,vars)
		vars.mWhoShot = who_shot
		vars.mShooterHerdId = herd_id
	end)
	
	edit_component( entity_id, "VelocityComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", v_x, v_y )
	end)
	
	if( proj_mods ~= nil ) then
		proj_mods( entity_id, custom_values )
	end
	
	return entity_id
end

function get_player()
	local players = get_players()
	if( players ) then
		return players[1]
	end
	
	return nil
end

function get_matter_inv_name( matters )
	local names = {}
	
	for i,matter in ipairs( matters ) do
		if( matter > 0 ) then
			table.insert( names, CellFactory_GetUIName( i - 1 ))
		end
	end
	
	return names
end

function get_custom_effect( hooman, effect_name, effect_id )
	local children = EntityGetAllChildren( hooman ) or {}
	if( #children > 0 ) then
		if( effect_id ~= nil ) then
			if( type( effect_id ) == "string" ) then
				dofile_once( "data/scripts/status_effects/status_list.lua" )
				for i,effect in ipairs( status_effects ) do
					if( effect.ui_name == effect_id ) then
						effect_id = i
						break
					end
				end
			end
			
			for i,child in ipairs( children ) do			
				local effect_comp = EntityGetFirstComponentIncludingDisabled( child, "GameEffectComponent" )
				if( effect_comp ~= nil and ( ComponentGetValue2( effect_comp, "effect" ) == effect_name or ComponentGetValue2( effect_comp, "causing_status_effect" ) == effect_id or ComponentGetValue2( effect_comp, "ragdoll_effect" ) == effect_name )) then
					return child, effect_comp, effect_id
				end
			end
		else
			for i,child in ipairs( children ) do
				if( EntityGetName( child ) == effect_name ) then
					return child
				end
			end
		end
	end
end

function get_tagged_id( tag )
	local id = EntityGetWithTag( tag ) or {}
	local amount = #id
	if( amount < 1 ) then
		return nil
	elseif( amount > 1 ) then
		table.sort( id )
		for i = 1,amount-1 do
			EntityRemoveTag( id[i], tag )
		end
		return id[amount]
	end
	return id[1]
end

function is_sentient( entity_id )
	if( EntityHasTag( entity_id, "player_unit" )) then
		return true
	else
		for i,comp in ipairs( ai_comps ) do
			if( EntityGetFirstComponentIncludingDisabled( entity_id, comp ) or 0 ~= 0 ) then
				return true
			end
		end
	end
	
	return false
end

--utility
function class_state( class_num, stat_num )
	local stats = DD_extractor( ModSettingGetNextValue( "Noita40K.CLASS_STATS" ) or "|:1:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:1:0:0:|" )
	return n2b( stats[ class_num ][ stat_num ])
end

function compatibility_patch()
	if( ModSettingGetNextValue( "Noita40K.VERSION" ) < 2 ) then
		local stats = DD_extractor( ModSettingGetNextValue( "Noita40K.CLASS_STATS" ))
		stats[11] = stats[2]
		stats[2] = { 0, 0, 0, }
		stats[15][1] = 1
		ModSettingSetNextValue( "Noita40K.CLASS_STATS", DD_packer( stats ), false )
		ModSettingSetNextValue( "Noita40K.CUSTOM_LOADOUT", "|BOLT_CARBINE|CHAINSWORD|BOLTER|MELTACUTTER|", false )
		ModSettingSetNextValue( "Noita40K.CURRENT_CLASS", 1, false )
		ModSettingSetNextValue( "Noita40K.CURRENT_SKIN", class_info[1].default_skin, false )
		ModSettingSetNextValue( "Noita40K.VERSION", 2, false )
	end
	
	if( ModSettingGetNextValue( "Noita40K.VERSION" ) < 3 ) then
		ModSettingSetNextValue( "Noita40K.REFRACTOR_VISUALS", false, false )
		ModSettingSetNextValue( "Noita40K.VERSION", 3, false )
	end
end

function set_shader( entity_id, name, shielded, x, y, w, h )
	if( entity_id == -1 or EntityHasTag( entity_id, "player_unit" )) then
		shielded = shielded or false
		x = x or 0
		y = y or 0
		w = w or 0
		h = h or 0
		
		if( shielded ) then
			local flag_name = string.upper( name ).."_SHADER_ACTIVE"
			if( x == 0 and y == 0 and w == 0 and h == 0 ) then
				if( GameHasFlagRun( flag_name )) then
					GameSetPostFxParameter( name, x, y, w, h )
					GameRemoveFlagRun( flag_name )
				end
			elseif( not( GameHasFlagRun( flag_name ))) then
				GameSetPostFxParameter( name, x, y, w, h )
				GameAddFlagRun( flag_name )
			end
		else
			GameSetPostFxParameter( name, x, y, w, h )
		end
	end
end

function get_action_with_id( action_id )
	dofile_once( "data/scripts/gun/gun_enums.lua")
	dofile_once( "data/scripts/gun/gun_actions.lua" )
	
	local action_data = nil
	for i,action in ipairs( actions ) do
		if( action.id == action_id ) then
			action_data = action
			break
		end
	end

	return action_data
end

function get_perk_with_actual_id( perk_id, is_external )
	is_external = is_external or false
	
	local perk_data = nil
	if( is_external ) then
		dofile_once( "mods/Noita40K/files/append/perks.lua" )
		for i,perk in ipairs( perk_list_external ) do
			if perk.id == perk_id then
				perk_data = perk
				break
			end
		end
	else
		dofile_once( "data/scripts/perks/perk.lua" )
		dofile_once( "data/scripts/perks/perk_list.lua" )
		perk_data = get_perk_with_id( perk_list, perk_id )
	end
	
	return perk_data
end

function get_gun_with_id( gun_id )
	local gun_data = nil
	for i,gun in ipairs( gun_info ) do
		if( gun.id == gun_id ) then
			gun_data = gun
			break
		end
	end
	
	if( gun_data == nil ) then
		gun_data = {
			id = "ERROR",
			name = "",
			unlocked = nil,
			icon = nil,
			pic = nil,
			ammo = nil,
			path = gun_id,
		}
	end
	
	return gun_data
end

function get_quest_uid()
	local quest_info = DD_extractor( ModSettingGetNextValue( "Noita40K.QUEST_INFO" ), true ) or {}
	if( #quest_info > 0 ) then
		for i = 1,10000 do
			local checker = true
			for e,quest in ipairs( quest_info ) do
				if( tonumber( quest[1] ) == i ) then
					checker = false
					break
				end
			end
			if( checker ) then
				return i
			end
		end
	end
	
	return 1
end

function get_quest_with_id( quest_id )
	dofile_once( "mods/Noita40K/files/scripts/libs/lists.lua" )
	
	local quest_data = nil
	for i,quest in ipairs( quest_list ) do
		if( quest.id == quest_id ) then
			quest_data = quest
			break
		end
	end
	
	return quest_data
end

function get_quest_with_num( quest_num )
	local quest_info = DD_extractor( ModSettingGetNextValue( "Noita40K.QUEST_INFO" ), true ) or {}
	
	local quest_data = nil
	for i,quest in ipairs( quest_info ) do
		if( quest[1] == tostring( quest_num )) then
			quest_data = quest
			break
		end
	end
	
	return quest_data
end

function get_head_offset( hooman )
	local offset_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "head_offset" )
	local animal_comp = EntityGetFirstComponentIncludingDisabled( hooman, "AnimalAIComponent" )
	if( offset_storage ~= nil ) then
		return ComponentGetValue2( offset_storage, "value_int" )
	elseif( animal_comp ~= nil ) then
		return ComponentGetValue2( animal_comp, "eye_offset_y" )
	end
	return 0
end

function get_killable_stuff( c_x, c_y, r )
	local stuff = {}
	return add_table( add_table( stuff, EntityGetInRadiusWithTag( c_x, c_y, r, "hittable" ) or {} ), EntityGetInRadiusWithTag( c_x, c_y, r, "mortal" ) or {} )
end

function get_threat_level( hooman, extra )
	local char_x, char_y = EntityGetTransform( hooman )
	
	local threat_level = 0
	local enemies = EntityGetInRadiusWithTag( char_x, char_y, 250, "enemy" ) or {}
	if( #enemies > 0 ) then
		for i,enemy_id in ipairs( enemies ) do
			threat_level = threat_level + math.abs( get_enemy_threat( hooman, enemy_id, extra ))
		end
	end
	
	local projectiles = EntityGetInRadiusWithTag( char_x, char_y, 250, "projectile" ) or {}
	if( #projectiles > 0 ) then
		for e,projectile_id in ipairs( projectiles ) do
			threat_level = threat_level + get_proj_threat( hooman, projectile_id, extra )
		end
	end
	
	return threat_level
end

function get_enemy_threat( hooman, enemy_id, extra )
	local damage_comp = EntityGetFirstComponentIncludingDisabled( enemy_id, "DamageModelComponent" )
	local gene_comp = EntityGetFirstComponentIncludingDisabled( enemy_id, "GenomeDataComponent" )
	
	if( EntityGetRootEntity( enemy_id ) ~= enemy_id ) then
		return 0
	elseif( hooman == enemy_id or damage_comp == nil or gene_comp == nil ) then
		return -1
	end
	
	local char_x, char_y = EntityGetTransform( hooman )
	local enemy_x, enemy_y = EntityGetTransform( enemy_id )
	
	local p_hitbox_offset = get_head_offset( hooman )
	local animal_comp = EntityGetFirstComponentIncludingDisabled( enemy_id, "AnimalAIComponent" )
	local e_eye = get_head_offset( enemy_id )
	
	local hidden = RaytracePlatforms( char_x, char_y + p_hitbox_offset, enemy_x, enemy_y + e_eye )
	if( not( hidden ) and EntityGetHerdRelation( enemy_id, hooman ) < 90 ) then
		local platform_comp = EntityGetFirstComponentIncludingDisabled( enemy_id, "CharacterPlatformingComponent" )
		
		local hp = ComponentGetValue2( damage_comp, "hp" )
		local supremacy = ComponentGetValue2( gene_comp, "food_chain_rank" )
		
		local distance = math.sqrt(( enemy_x - char_x )^2 + ( enemy_y - char_y )^2)
		
		local vulnerability = 0
		if( extra ) then
			local armor_types = { "curse", "drill", "electricity", "explosion", "fire", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice", }
			for i = 1,#armor_types do
				vulnerability = vulnerability + ComponentObjectGetValue2( damage_comp, "damage_multipliers", armor_types[i] )
			end
		else
			vulnerability = ComponentObjectGetValue2( damage_comp, "damage_multipliers", "projectile" ) + ComponentObjectGetValue2( damage_comp, "damage_multipliers", "explosion" )
		end
		
		local cqc = 0
		local overall_speed = 0
		if( animal_comp ~= nil and platform_comp ~= nil ) then
			if( ComponentGetValue2( animal_comp, "attack_melee_enabled" )) then
				cqc = ( ComponentGetValue2( animal_comp, "attack_melee_damage_min" ) + ComponentGetValue2( animal_comp, "attack_melee_damage_max" ))/2
			end
			if( ComponentGetValue2( animal_comp, "can_walk" )) then
				overall_speed = overall_speed + ComponentGetValue2( platform_comp, "run_velocity" )
			end
			if( ComponentGetValue2( animal_comp, "can_fly" )) then
				overall_speed = overall_speed + ComponentGetValue2( platform_comp, "fly_velocity_x" ) + 10
			end
		end
		
		-- spider at 20m is ~1
		local f_distance = 1 + 4/2^( distance/10 )
		local f_speed = ( overall_speed + 0.01 )/10
		local f_vulner = 0.77 + ( 3 - 0.26 )/( 1 + ( vulnerability/5 )^2.9 )
		local f_supremacy = supremacy/20
		local f_cqc = cqc*10
		local f_hp = hp*25
		
		return 0.25*( 0.08*( f_distance*f_speed*f_vulner*f_hp - f_supremacy ) + f_cqc )
	end
	
	return 0
end

function get_proj_threat( hooman, projectile_id, extra )
	if( EntityGetRootEntity( projectile_id ) ~= projectile_id ) then
		return 0
	end

	local proj_comp = EntityGetFirstComponentIncludingDisabled( projectile_id, "ProjectileComponent" )
	if( hooman ~= ComponentGetValue2( proj_comp, "mWhoShot" ) or ComponentGetValue2( proj_comp, "friendly_fire" )) then
		local char_x, char_y = EntityGetTransform( hooman )
		local proj_x, proj_y = EntityGetTransform( projectile_id )
		
		local p_hitbox_offset = get_head_offset( hooman )
		
		local hidden = RaytracePlatforms( char_x, char_y + p_hitbox_offset, proj_x, proj_y )
		if( not( hidden )) then
			local proj_vel_x, proj_vel_y = GameGetVelocityCompVelocity( projectile_id )
			local char_vel_x, char_vel_y = GameGetVelocityCompVelocity( hooman )
			local proj_v = math.sqrt( ( char_vel_x - proj_vel_x )^2 + ( char_vel_y - proj_vel_y )^2 )
			
			local d_x = proj_x - char_x
			local d_y = proj_y - char_y
			local direction = math.abs( math.rad( 180 ) - math.abs( math.atan2( proj_vel_x, proj_vel_y ) - math.atan2( d_x, d_y )))
			local distance = math.sqrt(( d_x )^2 + ( d_y )^ 2 )
			
			local is_real = b2n( ComponentGetValue2( proj_comp, "collide_with_entities" ))
			local lifetime = ComponentGetValue2( proj_comp, "lifetime" )
			if( lifetime < 2 and lifetime > -1 ) then
				lifetime = 1
			end
			
			local total_damage = 0
			if( extra ) then
				local damage_types = { "curse", "drill", "electricity", "explosion", "fire", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice", }
				for i = 1,#damage_types do
					local dmg = ComponentObjectGetValue2( proj_comp, "damage_by_type", damage_types[i] )
					if( dmg > 0 ) then
						total_damage = total_damage + dmg
					end
				end
				total_damage = total_damage + ComponentGetValue2( proj_comp, "damage" )
				
				local explosion_dmg = ComponentObjectGetValue2( proj_comp, "config_explosion", "damage" )
				local explosion_rad = ComponentObjectGetValue2( proj_comp, "config_explosion", "explosion_radius" )
				if( explosion_dmg > 0 ) then
					explosion_dmg = explosion_dmg + explosion_rad/25
					
					if( distance <= explosion_rad ) then
						explosion_dmg = explosion_dmg + ( explosion_rad - distance + 1 )/25
					end
				end
				total_damage = total_damage + explosion_dmg
			else
				total_damage = ComponentGetValue2( proj_comp, "damage" )
			end
			
			-- sparkbolt at 20m is ~1
			local f_distance = 1 + 4/2^( distance/10 )
			local f_direction = 0.02 + 1.08/2^( direction/0.6 )
			local f_velocity = 0.1847 + ( 1 - math.exp( -0.0021*proj_v ))
			local f_lifetime = ( 1.8*( lifetime - 1 )/lifetime + 0.3 )/2
			local f_is_real = 0.5 + 0.5*is_real
			local f_damage = total_damage*25
			
			return 0.15*f_distance*f_direction*f_lifetime*f_is_real*f_velocity*f_damage
		end
	end
	
	return 0
end

function wand_rater( wand_id, shuffle, can_reload, capacity, reload_time, cast_delay, mana_max, mana_charge, spell_cast, spread )
	local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
	
	if( shuffle == nil ) then
		shuffle = b2n( ComponentObjectGetValue2( abil_comp, "gun_config", "shuffle_deck_when_empty" ))
	end
	if( can_reload == nil ) then
		can_reload = not( ComponentGetValue2( abil_comp, "never_reload" ))
	end
	if( capacity == nil ) then
		capacity = ComponentObjectGetValue2( abil_comp, "gun_config", "deck_capacity" )
	end
	
	if( reload_time == nil ) then
		reload_time = ComponentObjectGetValue2( abil_comp, "gun_config", "reload_time" )
	end
	if( cast_delay == nil ) then
		cast_delay = ComponentObjectGetValue2( abil_comp, "gunaction_config", "fire_rate_wait" )
	end
	
	if( mana_max == nil ) then
		mana_max = ComponentGetValue2( abil_comp, "mana_max" )
	end
	if( mana_charge == nil ) then
		mana_charge = ComponentGetValue2( abil_comp, "mana_charge_speed" )
	end
	
	if( spell_cast == nil ) then
		spell_cast = ComponentObjectGetValue2( abil_comp, "gun_config", "actions_per_round" )
	end
	if( spread == nil ) then
		spread = ComponentObjectGetValue2( abil_comp, "gunaction_config", "spread_degrees" )
	end
	
	-- sollex is 1
	local f_shuffle = 1 - 0.7*shuffle
	local f_reloading = 2
	if( can_reload ) then
		f_reloading = 2 - ( 0.044/0.024 )*( 1 - math.exp( -0.024*reload_time ))
	end
	local f_capacity = 3.47 + ( 0.05 - 3.47 )/( 1 + (( capacity + 3 )/13.67 )^3.05 )
	local f_delay = 2 - ( 0.044/0.024 )*( 1 - math.exp( -0.024*cast_delay ))
	local f_mana_max = 1.5 + ( 0.06 - 1.5 )/( 1 + ( mana_max/6074441 )^1.416 )^237023
	local f_mana_charge = 3.41 + ( 0.07 - 3.41 )/( 1 + ( mana_charge/14641850 )^1.314 )^251693
	local f_multi = 2.58 + ( 1.017 - 2.58 )/( 1 + ( spell_cast/48023 )^1.63 )^983676
	local f_spread = math.rad( 45 - spread )
	
	return 1500*f_delay*f_reloading*f_mana_max*f_mana_charge*math.sqrt( f_spread*f_multi )*f_shuffle*f_capacity^1.5
end

function spell_rater( spell_id, check_permas )
	if( spell_id ~= nil and spell_id ~= "" ) then
		local t_item_comp = EntityGetFirstComponentIncludingDisabled( spell_id, "ItemComponent" )
		local t_act_comp = EntityGetFirstComponentIncludingDisabled( spell_id, "ItemActionComponent" )
		local action_data = get_action_with_id( ComponentGetValue2( t_act_comp, "action_id" ))
		if( action_data == nil ) then
			return 0
		end
		
		local price = action_data.price
		local uses_max = action_data.max_uses or -1
		local mana = math.abs( action_data.mana or 0 )
		local is_perma = 0
		if( check_permas ) then
			is_perma = b2n( ComponentGetValue2( t_item_comp, "permanently_attached" ))
		end
		local uses_left = ComponentGetValue2( t_item_comp, "uses_remaining" )
		
		--sparkbolt is 1
		local f_perma = 1 + 4*is_perma
		local f_price = price/100
		local f_uses = uses_left/uses_max
		if( uses_left < 0 and uses_max > 0 ) then
			f_uses = 2
		end
		local f_mana = 5.4 + ( 0.1 - 5.4 )/( 1 + ( mana/8420.3 )^0.367 )
		
		return 2.5*f_perma*f_price*f_uses*f_mana
	end
	
	return 0
end

function add_quest( hooman, id, custom_message, custom_conslusion, custom_name, custom_desc, alpha, beta, gamma, progress, custom_pic, is_global )
	dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )
	
	local quest_info_raw = ModSettingGetNextValue( "Noita40K.QUEST_INFO" )
	local quest_data = get_quest_with_id( id )
	if( quest_data ~= nil ) then
		custom_pic = custom_pic or quest_data.pic
		custom_name = custom_name or quest_data.name
		custom_desc = custom_desc or quest_data.desc
		
		alpha = alpha or 1
		beta = beta or 1
		gamma = gamma or 1
		progress = progress or 0
		
		custom_conslusion = custom_conslusion or quest_data.conclusion
		
		ModSettingSetNextValue( "Noita40K.QUEST_INFO", quest_info_raw..
						":"..get_quest_uid()..
						":"..id..
						":"..custom_pic..
						":"..custom_name..
						":"..custom_desc..
						":"..alpha..
						":"..beta..
						":"..gamma..
						":"..progress..
						":"..custom_conslusion..
						":"..b2n( is_global == nil and quest_data.is_global or is_global )..":|", false )
		ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "qm_is_open" ), "value_bool", true )
		ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "mm_is_open" ), "value_bool", false )
		
		local char_x, char_y = EntityGetTransform( hooman )
		GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/ui/quest_start", char_x, char_y )
		local message = custom_message or { "New quest added!", "Open the inventory." }
		new_notification( message[1], message[2], false )
	end
end

function remove_quest( hooman, num )
	local quest_info = DD_extractor( ModSettingGetNextValue( "Noita40K.QUEST_INFO" ), true )
	
	local victim_id = 0
	for i,quest in ipairs( quest_info ) do
		if( quest[1] == num ) then
			victim_id = i
			break
		end
	end
	
	if( victim_id > 0 ) then
		local panel_state_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "qm_panel_state" )
		local panel_state = ComponentGetValue2( panel_state_storage, "value_int" )
		if( panel_state == tonumber( num )) then
			ComponentSetValue2( panel_state_storage, "value_int", 0 )
		end
		
		local value = "|"
		if( #quest_info > 1 ) then
			table.remove( quest_info, victim_id )
			value = DD_packer( quest_info )
		else
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "qm_is_open" ), "value_bool", false )
		end
		ModSettingSetNextValue( "Noita40K.QUEST_INFO", value, false )
	end
end

function quest_abg_controller( num, values )
	if( values == nil ) then
		local quest_info = get_quest_with_num( num )
		return { quest_info[6], quest_info[7], quest_info[8] }
	else
		local quest_info = DD_extractor( ModSettingGetNextValue( "Noita40K.QUEST_INFO" ), true )
		for i,quest in ipairs( quest_info ) do
			if( quest[1] == num ) then
				if( values[1] ~= nil ) then
					quest[6] = values[1]
				end
				if( values[2] ~= nil ) then
					quest[7] = values[2]
				end
				if( values[3] ~= nil ) then
					quest[8] = values[3]
				end
				break
			end
		end
		ModSettingSetNextValue( "Noita40K.QUEST_INFO", DD_packer( quest_info ), false )
	end
end

function quest_progress_controller( num, value )
	if( value == nil ) then
		return get_quest_with_num( num )[9]
	else
		local quest_info = DD_extractor( ModSettingGetNextValue( "Noita40K.QUEST_INFO" ), true )
		for i,quest in ipairs( quest_info ) do
			if( quest[1] == num ) then
				quest[9] = value
				break
			end
		end
		ModSettingSetNextValue( "Noita40K.QUEST_INFO", DD_packer( quest_info ), false )
	end
end

function play_shielded_sound( shielded_sound_checker, x, y, event_name )
	if( shielded_sound_checker ) then
		GamePlaySound( "mods/Noita40K/files/40K.bank", event_name, x, y )
	end
	return false
end

function play_shielded_loop( entity_id, tag )
	local loop_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "AudioLoopComponent", tag )
	local switcher = ComponentGetValue2( loop_comp, "volume_autofade_speed" )
	if( switcher == 0.25 ) then
		GameEntityPlaySoundLoop( entity_id, tag, 1.0 )
		ComponentSetValue2( loop_comp, "volume_autofade_speed", 0.26 )
	end
end

function scale_emitter( hooman, emit_comp, advanced )
	advanced = advanced or false
	local borders = { 0, 0, 0, 0, }
	local gonna_update = false
	
	local sprite_comp = EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "character" )
	local char_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterDataComponent" )
	if( advanced and sprite_comp ~= nil ) then
		local offset_x = ComponentGetValue2( sprite_comp, "offset_x" )
		local offset_y = ComponentGetValue2( sprite_comp, "offset_y" )
		
		if( char_comp ~= nil ) then
			local temp = {}
			temp[1] = ComponentGetValue2( char_comp, "collision_aabb_min_x" )
			temp[2] = ComponentGetValue2( char_comp, "collision_aabb_max_x" )
			temp[3] = ComponentGetValue2( char_comp, "collision_aabb_min_y" )
			temp[4] = ComponentGetValue2( char_comp, "collision_aabb_max_y" )
			
			if( offset_x == 0 ) then
				offset_x = ( math.abs( temp[1] ) + math.abs( temp[2] ))/2
			end
			if( offset_y == 0 ) then
				offset_y = temp[3]
			end
			
			borders[1] = ( -offset_x + temp[1] )/2
			borders[2] = ( offset_x + temp[2] )/2
			borders[3] = ( -offset_y + temp[3] )/2
			borders[4] = ( offset_y + temp[3] )/2
		else
			if( offset_x == 0 ) then
				offset_x = 3
			end
			if( offset_y == 0 ) then
				offset_y = 3
			end
			borders[1] = -offset_x
			borders[2] = offset_x
			borders[3] = -offset_y
			borders[4] = offset_y*0.5
		end
		gonna_update = true
	elseif( char_comp ~= nil ) then
		borders[1] = ComponentGetValue2( char_comp, "collision_aabb_min_x" )
		borders[2] = ComponentGetValue2( char_comp, "collision_aabb_max_x" )
		borders[3] = ComponentGetValue2( char_comp, "collision_aabb_min_y" )
		borders[4] = ComponentGetValue2( char_comp, "collision_aabb_max_y" )
		gonna_update = true
	end
	
	if( gonna_update ) then
		ComponentSetValue2( emit_comp, "x_pos_offset_min", borders[1])
		ComponentSetValue2( emit_comp, "x_pos_offset_max", borders[2])
		ComponentSetValue2( emit_comp, "y_pos_offset_min", borders[3])
		ComponentSetValue2( emit_comp, "y_pos_offset_max", borders[4])
	end
end

--gun stuff
function purity_controller( wand_id, hooman, ctrl_comp, abil_comp, frame_num, strict_mode )
	strict_mode = strict_mode or false
	local ammo_type = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "ammo_type" ), "value_string" )
	local loaded = true
	
	local children = EntityGetAllChildren( wand_id ) or {}
	if( #children > 0 ) then
		for i,comp in ipairs( children ) do
			local is_perma = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( comp, "ItemComponent" ), "permanently_attached" )
			if( not( EntityHasTag( comp, ammo_type )) and EntityHasTag( comp, "card_action" ) and not( is_perma )) then
				local action_id = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( comp, "ItemActionComponent" ), "action_id" )
				local action_data = get_action_with_id( action_id )
				if( strict_mode or action_data.type == ACTION_TYPE_PROJECTILE or action_data.type == ACTION_TYPE_STATIC_PROJECTILE or action_data.type == ACTION_TYPE_MATERIAL ) then
					loaded = false
					break
				end
			end
		end
	end
	
	if( not( loaded )) then
		local LMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownFire" )
		
		if( LMB_down ) then
			GamePrint( "Brother, this is heresy!" )
		end
		
		local delay_frame = ComponentGetValue2( abil_comp, "mNextFrameUsable" )
		frame_num = frame_num + 1
		
		if( delay_frame <= frame_num ) then
			ComponentSetValue2( abil_comp, "mNextFrameUsable", frame_num + 1 )
		end
	end
end

function beam_controller( hooman, state_name, value )
	local inv_comp = EntityGetFirstComponentIncludingDisabled( hooman, "Inventory2Component" )
	local wand_id = ComponentGetValue2( inv_comp, "mActiveItem" )
	
	if( wand_id ~= 0 and wand_id ~= nil ) then
		local storage_state = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", state_name or "state" )
		if( storage_state ~= nil ) then
			ComponentSetValue2( storage_state, value == nil and "value_bool" or "value_int",( value == nil and true or value ))
		end
	end
end

function beam_hitter( hooman, deadman, barrel_x, barrel_y, amount, delta_x, delta_y, is_piercing, hit_action )
	if( EntityGetComponent( deadman, "DamageModelComponent" ) ~= nil ) then
		local e_x, e_y = EntityGetTransform( deadman )
		
		local hitbox_comp = EntityGetComponent( deadman, "HitboxComponent" ) or {}
		local hitbox_count = 1
		if( #hitbox_comp > 1 ) then
			hitbox_count = #hitbox_comp
		end
		
		local hitbox_right = 0
		local hitbox_left = 0
		local hitbox_up = 0
		local hitbox_down = 0
		local hitbox_dmg_scale = 0
		for i = 1,hitbox_count do
			if( i > #hitbox_comp ) then
				local hitbox_size = 5
				hitbox_right = hitbox_size
				hitbox_left = 0-hitbox_size
				hitbox_up = 0-hitbox_size
				hitbox_down = hitbox_size
				hitbox_dmg_scale = 1
			else
				hitbox_right = ComponentGetValue2( hitbox_comp[i], "aabb_max_x" )
				hitbox_left = ComponentGetValue2( hitbox_comp[i], "aabb_min_x" )
				hitbox_up = ComponentGetValue2( hitbox_comp[i], "aabb_min_y" )
				hitbox_down = ComponentGetValue2( hitbox_comp[i], "aabb_max_y" )
				hitbox_dmg_scale = ComponentGetValue2( hitbox_comp[i], "damage_multiplier" )
			end
			
			for k = 0,amount do
				local beam_part_x = barrel_x + delta_x*k
				local beam_part_y = barrel_y + delta_y*k
				
				if(( beam_part_x <= e_x + hitbox_right ) and ( beam_part_x >= e_x + hitbox_left ) and ( beam_part_y <= e_y + hitbox_down ) and ( beam_part_y >= e_y + hitbox_up )) then
					if( is_piercing ) then
						hit_action( hooman, deadman, k, beam_part_x, beam_part_y, hitbox_dmg_scale )
					else
						return deadman, k
					end
				end
			end
		end
	end
end

--heavy functionality
function magic2binary( hooman, target )
	local char_x, char_y = EntityGetTransform( hooman )
	local t_x, t_y, t_r, t_scale_x, t_scale_y = EntityGetTransform( target )
	local hidden = RaytracePlatforms( char_x, char_y, t_x, t_y - 2 )
	if( not( hidden ) and target == EntityGetRootEntity( target )) then
		local beam_id = EntityLoad( "mods/Noita40K/files/entities/misc/servoskull/salvage_visual.xml", char_x, char_y )
		local dx = t_x - char_x
		local dy = t_y - char_y
		
		local distance = math.sqrt( dx^2 + dy^2 )
		ComponentObjectSetValue2( EntityGetFirstComponentIncludingDisabled( beam_id, "LaserEmitterComponent" ), "laser", "max_length", distance )
		
		local angle = math.atan2( dy, dx )
		EntitySetTransform( beam_id, char_x, char_y, angle, t_scale_x, t_scale_y )
		GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/salvaging", t_x, t_y )
		GameCreateParticle( "spark_red", t_x, t_y, 20, 150, 150, false )
		return true
	else
		return false
	end
end

function put_in( hooman, item_id )
	local itm_comp = EntityGetFirstComponentIncludingDisabled( item_id, "ItemComponent" )
	if( not( ComponentGetValue2( itm_comp, "has_been_picked_by_player" ))) then
		ComponentSetValue2( itm_comp, "has_been_picked_by_player", true )
		ComponentSetValue2( itm_comp, "play_hover_animation", false )
		ComponentSetValue2( itm_comp, "mFramePickedUp", GameGetFrameNum())
		ComponentSetValue2( itm_comp, "next_frame_pickable", GameGetFrameNum() + 60 )
		
		local cost_comp = EntityGetFirstComponentIncludingDisabled( item_id, "ItemCostComponent", "shop_cost" )
		if( cost_comp ~= nil ) then
			EntityRemoveComponent( item_id, cost_comp )
			EntityRemoveComponent( item_id, EntityGetFirstComponentIncludingDisabled( item_id, "SpriteComponent", "shop_cost" ))
			
			local char_x, char_y = EntityGetTransform( hooman )
			GameScreenshake( 5 )
			GamePrint( "Gods are annoyed." )
			GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/chest_bad/create", char_x, char_y )
		end
	end
	
	local comps = EntityGetAllComponents( item_id ) or {}
	if( #comps > 0 ) then
		for i,comp in ipairs( comps ) do
			if( ComponentHasTag( comp, "enabled_in_inventory" )) then
				EntitySetComponentIsEnabled( item_id, comp, true )
			else
				EntitySetComponentIsEnabled( item_id, comp, false )
			end
		end
	end
	
	local h_x, h_y = EntityGetTransform( hooman )
	local i_x, i_y, i_r, i_s_x, i_s_y = EntityGetTransform( item_id )
	EntitySetTransform( item_id, h_x, h_y, i_r, i_s_x, i_s_y )
	EntityAddChild( hooman, item_id )
end

function pull_out( item_id )
	local comps = EntityGetAllComponents( item_id ) or {}
	if( #comps > 0 ) then
		for i,comp in ipairs( comps ) do
			if( ComponentHasTag( comp, "enabled_in_world" ) or not( ComponentHasTag( comp, "enabled_in_hand" ) or ComponentHasTag( comp, "enabled_in_inventory" ))) then
				EntitySetComponentIsEnabled( item_id, comp, true )
			else
				EntitySetComponentIsEnabled( item_id, comp, false )
			end
		end
	end
	
	local p_x, p_y = EntityGetTransform( EntityGetParent( item_id ))
	local i_x, i_y, i_r, i_s_x, i_s_y = EntityGetTransform( item_id )
	EntityRemoveFromParent( item_id )
	EntitySetTransform( item_id, p_x, p_y, i_r, i_s_x, i_s_y )
end