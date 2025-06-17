table.insert( perk_list_external, --note that it says "external" - vanilla system won't work
{
	id = "AS_POWER_ARMOUR",
	ui_name = "Adepta Sororitas Power Armour",
	ui_description = "A Spiritu Dominatus, Domine, Libra Nos.",
	ui_icon = "mods/n40ke_bss/files/pics/perks_gfx/as_power_armour.png",
	perk_icon = "mods/n40ke_bss/files/pics/perks_gfx/as_power_armour.png",
	func = function( entity_perk_item, entity_who_picked, item_name )
		--editing the hitbox
		edit_component_ultimate( entity_who_picked, "HitboxComponent", function(comp,vars) 
			ComponentSetValue2( comp, "aabb_max_x", 2 )
			ComponentSetValue2( comp, "aabb_max_y", 0 )
			ComponentSetValue2( comp, "aabb_min_x", -2 )
			ComponentSetValue2( comp, "aabb_min_y", -13 )
		end)
		
		edit_component_with_tag_ultimate( entity_who_picked, "HitboxComponent", "crouched", function(comp,vars) 
			ComponentSetValue2( comp, "aabb_max_x", 2 )
			ComponentSetValue2( comp, "aabb_max_y", 0 )
			ComponentSetValue2( comp, "aabb_min_x", -2 )
			ComponentSetValue2( comp, "aabb_min_y", -11 )
		end)
		
		--editing the collider and some of the jetpack values
		edit_component_ultimate( entity_who_picked, "CharacterDataComponent", function(comp,vars) 
			ComponentSetValue2( comp, "collision_aabb_max_x", 2 )
			ComponentSetValue2( comp, "collision_aabb_max_y", 2.1 )
			ComponentSetValue2( comp, "collision_aabb_min_x", -2 )
			ComponentSetValue2( comp, "collision_aabb_min_y", -11 )
			ComponentSetValue2( comp, "fly_time_max", ComponentGetValue2( comp, "fly_time_max" )*3 )
			ComponentSetValue2( comp, "fly_recharge_spd_ground", ComponentGetValue2( comp, "fly_recharge_spd_ground" )/2 )
		end)
		
		--this determines when to switch to crouch mode
		edit_component_with_tag_ultimate( entity_who_picked, "HotspotComponent", "crouch_sensor", function(comp,vars) 
			ComponentSetValueVector2( comp, "offset", 0, -16 )
		end)
		
		--this controls everything that is related to the eyes
		edit_component_with_tag_ultimate( entity_who_picked, "VariableStorageComponent", "head_offset", function(comp,vars) 
			ComponentSetValue2( comp, "value_int", -14 )
		end)
		
		--direct damage from having those matters inside or near your collider
		local matters = { "acid", "lava", "blood_cold_vapour", "blood_cold", "poison", "radioactive_gas", "radioactive_gas_static", "rock_static_radioactive", "rock_static_poison", "ice_radioactive_static", "ice_radioactive_glass", "ice_acid_static", "ice_acid_glass", "rock_static_cursed", "magic_gas_hp_regeneration", "gold_radioactive", "gold_static_radioactive", "rock_static_cursed_green", "cursed_liquid" }
		local matters_dmg = { 0.002, 0.002, 0, 0.00005, 0.00005, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.005, 0, 0, 0, 0.00005 }
		for i = 1,#matters do
			EntitySetDamageFromMaterial( entity_who_picked, matters[i], matters_dmg[i] )
		end
		
		--jumppack emitters setup
		edit_component_with_tag_ultimate( entity_who_picked, "ParticleEmitterComponent", "jetpack", function(comp,vars) 
			ComponentSetValue2( comp, "emit_real_particles", true )
			ComponentSetValue2( comp, "fade_based_on_lifetime", true )
			ComponentSetValue2( comp, "custom_style", "FIRE" )
			ComponentSetValue2( comp, "emitted_material_name", "fire" )
			ComponentSetValue2( comp, "direction_random_deg", 3 )
			ComponentSetValue2( comp, "x_vel_min", -15 )
			ComponentSetValue2( comp, "x_vel_max", 15 )
			ComponentSetValue2( comp, "x_pos_offset_min", -3 )
			ComponentSetValue2( comp, "x_pos_offset_max", 3 )
			ComponentSetValueVector2( comp, "offset", 0, 1 )
		end)
		
		local emit_comp = EntityAddComponent( entity_who_picked, "ParticleEmitterComponent", 
		{ 
			_tags = "jetpack",
			emitted_material_name = "fire",
			direction_random_deg = "3",
			x_vel_min = "-15",
			x_vel_max = "15",
			x_pos_offset_min = "-4",
			x_pos_offset_max = "4",
			emission_interval_max_frames = "1",
			emission_interval_min_frames = "0",
			emit_real_particles = "1",
			emit_cosmetic_particles = "1",
			fade_based_on_lifetime = "1",
			lifetime_max = "0.2",
			lifetime_min = "0",
			y_vel_max = "180",
			y_vel_min = "80",
		})
		ComponentSetValueVector2( emit_comp, "offset", 0, 3 )
		ComponentSetValue2( emit_comp, "count_max", 5 )
		ComponentSetValue2( emit_comp, "count_min", 4 )
		
		emit_comp = EntityAddComponent( entity_who_picked, "ParticleEmitterComponent", 
		{ 
			_tags = "jetpack",
			custom_style = "FIRE",
			emitted_material_name = "fire",
			direction_random_deg = "3",
			x_vel_min = "-15",
			x_vel_max = "15",
			x_pos_offset_min = "-2.5",
			x_pos_offset_max = "0.5",
			emission_interval_max_frames = "1",
			emission_interval_min_frames = "0",
			emit_real_particles = "1",
			emit_cosmetic_particles = "1",
			fade_based_on_lifetime = "1",
			lifetime_max = "0.2",
			lifetime_min = "0",
			y_vel_max = "180",
			y_vel_min = "80",
		})
		ComponentSetValueVector2( emit_comp, "offset", -5.5, -5 )
		ComponentSetValue2( emit_comp, "count_max", 4 )
		ComponentSetValue2( emit_comp, "count_min", 2 )
		
		emit_comp = EntityAddComponent( entity_who_picked, "ParticleEmitterComponent", 
		{ 
			_tags = "jetpack",
			custom_style = "FIRE",
			emitted_material_name = "fire",
			direction_random_deg = "3",
			x_vel_min = "-15",
			x_vel_max = "15",
			x_pos_offset_min = "-2.5",
			x_pos_offset_max = "0.5",
			emission_interval_max_frames = "1",
			emission_interval_min_frames = "0",
			emit_real_particles = "1",
			emit_cosmetic_particles = "1",
			fade_based_on_lifetime = "1",
			lifetime_max = "0.2",
			lifetime_min = "0",
			y_vel_max = "180",
			y_vel_min = "80",
		})
		ComponentSetValueVector2( emit_comp, "offset", 5.5, -5 )
		ComponentSetValue2( emit_comp, "count_max", 4 )
		ComponentSetValue2( emit_comp, "count_min", 2 )
		
		edit_component_ultimate( entity_who_picked, "CharacterPlatformingComponent", function(comp,vars) 
			ComponentSetValue2( comp, "fly_speed_max_up", 150 )
		end)
		
		--non-matter damage multipliers and fire immunity
		edit_component_ultimate( entity_who_picked, "DamageModelComponent", function(comp,vars) 
			ComponentSetValue2( comp, "fire_probability_of_ignition", 0 )
			ComponentObjectSetValue2( comp, "damage_multipliers", "poison", 0.1 )
			ComponentObjectSetValue2( comp, "damage_multipliers", "radioactive", 0.1 )
		end)
		
		--custom jumppack sound
		edit_component_with_tag_ultimate( entity_who_picked, "AudioLoopComponent", "sound_jetpack", function(comp,vars) 
			ComponentSetValue2( comp, "file", "mods/Noita40K/files/sfx/40K.bank" )
			ComponentSetValue2( comp, "event_name", "player/jumppack/active" )
		end)
		
		ComponentSetValue2( GetGameEffectLoadTo( entity_who_picked, "STAINS_DROP_FASTER", true ), "frames", -1 )
		
		--adding custom jumppack entity
		local hot_comp = EntityAddComponent( entity_who_picked, "HotspotComponent", 
		{ 
			_tags = "jumppack_mount",
		})
		ComponentSetValueVector2( hot_comp, "offset", 0, -10 )
		
		local x, y = EntityGetTransform( entity_who_picked )
		local pack = EntityLoad( "mods/Noita40K/files/entities/emitters/jumppack.xml", x, y )
		EntityAddChild( entity_who_picked, pack )
		ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( pack, "VariableStorageComponent", "jumppack_speed" ), "value_int", 180 )
		ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( pack, "VariableStorageComponent", "jumppack_rate" ), "value_float", 0.3 )
		EntityAddTag( pack, "hover_enabled" )
		
		--adding physical armour script
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "VariableStorageComponent", "emperors_blessing" ) == nil ) then
			EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
			{ 
				_tags = "emperors_blessing",
				name = "emperors_blessing",
				value_int = tostring( ModSettingGetNextValue( "Noita40K.ARMOR_DEFLECTION_CHANCE" )),
			})
		end
		
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "physical_armour" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "physical_armour",
				script_source_file = "mods/Noita40K/files/scripts/perks/physical_armour.lua",
				execute_every_n_frame = "1",
			})
			
			EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
			{ 
				_tags = "armor_spec",
				name = "armor_spec",
				value_float = "0.2",
			})
			
			EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
			{ 
				_tags = "armor_right",
				name = "armor_right",
				value_int = "4",
			})
			
			EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
			{ 
				_tags = "armor_left",
				name = "armor_left",
				value_int = "4",
			})
			
			EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
			{ 
				_tags = "armor_up",
				name = "armor_up",
				value_int = "11",
			})
			
			EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
			{ 
				_tags = "armor_down",
				name = "armor_down",
				value_int = "2",
			})
		end
		
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "rebreather" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "rebreather",
				script_source_file = "mods/Noita40K/files/scripts/perks/rebreather.lua",
				execute_every_n_frame = "1",
			})
		end
		
		--changing player skin
		edit_component_with_tag_ultimate( entity_who_picked, "SpriteComponent", "character", function(comp,vars) 
			ComponentSetValue2( comp, "image_file", "mods/n40ke_bss/files/pics/classes_gfx/player.xml" )
			ComponentSetValue2( comp, "offset_x", 7 )
			ComponentSetValue2( comp, "offset_y", 18 )
			EntityRefreshSprite( entity_who_picked, comp )
		end)
		
		--arm
		local x, y = EntityGetTransform( entity_who_picked )
		local arm = EntityGetClosestWithTag( x, y, "player_arm_r" )
		edit_component_ultimate( arm, "SpriteComponent", function(comp,vars) 
			ComponentSetValue2( comp, "image_file", "mods/n40ke_bss/files/pics/classes_gfx/player_arm.xml" )
			EntityRefreshSprite( arm, comp )
		end)
		
		--amulet
		edit_component_with_tag_ultimate( entity_who_picked, "SpriteComponent", "player_amulet", function(comp,vars)
			ComponentSetValue2( comp, "image_file", "mods/n40ke_bss/files/pics/classes_gfx/cross.xml" )
			ComponentSetValue2( comp, "offset_x", 7 )
			ComponentSetValue2( comp, "offset_y", 18 )
			EntityRefreshSprite( entity_who_picked, comp )
		end)
		
		--crown
		edit_component_with_tag_ultimate( entity_who_picked, "SpriteComponent", "player_hat2", function(comp,vars)
			ComponentSetValue2( comp, "image_file", "mods/n40ke_bss/files/pics/classes_gfx/halo.xml" )
			ComponentSetValue2( comp, "offset_x", 7 )
			ComponentSetValue2( comp, "offset_y", 18 )
			EntityRefreshSprite( entity_who_picked, comp )
		end)
		
		--ragdoll
		edit_component_ultimate( entity_who_picked, "DamageModelComponent", function(comp,vars)
			ComponentSetValue2( comp, "ragdoll_filenames_file", "mods/n40ke_bss/files/pics/classes_gfx/ragdoll/filenames.txt" )
		end)
		
		--additional custom sprites
		EntityAddComponent( entity_who_picked, "SpriteComponent", 
		{ 
			_tags = "character,hand",
			image_file = "mods/n40ke_bss/files/pics/classes_gfx/player_hand.xml",
			rect_animation = "walk",
			offset_x = "7",
			offset_y = "18",
			z_index = "0.6",
		})
		
		EntityAddComponent( entity_who_picked, "SpriteComponent", 
		{ 
			_tags = "character,jumppack",
			image_file = "mods/n40ke_bss/files/pics/classes_gfx/wings.xml",
			rect_animation = "walk",
			offset_x = "8",
			offset_y = "18",
			z_index = "0.601",
		})
		
		--adding the rag
		EntityAddComponent( entity_who_picked, "HotspotComponent", 
		{ 
			_tags = "cloth_root",
			sprite_hotspot_name = "cloth_start",
		})
		
		EntityAddChild( entity_who_picked, EntityLoad( "mods/n40ke_bss/files/entities/misc/cloth.xml", x, y - 4 ))
		
		--removing the cape
		local capes = EntityGetAllChildren( entity_who_picked )
		if( capes ~= nil ) then
			for i,cape in ipairs( capes ) do
				if ( EntityGetName( cape ) == "cape" ) then
					EntityKill( cape )
				end
			end
		end
	end,
})

table.insert( perk_list_external,
{
	id = "EMPERORS_DAUGHTER",
	ui_name = "Emperor's Daughter",
	ui_description = "A Morte Perpetua, Domine, Libra Nos.",
	ui_icon = "mods/n40ke_bss/files/pics/perks_gfx/emperors_daughter.png",
	perk_icon = "mods/n40ke_bss/files/pics/perks_gfx/emperors_daughter.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		--modifying emperor's blessing chance
		edit_component_with_tag_ultimate( entity_who_picked, "VariableStorageComponent", "emperors_blessing", function(comp,vars) 
			ComponentSetValue2( comp, "value_int", math.ceil( ComponentGetValue2( comp, "value_int" )/4 ))
		end)
		
		edit_component_ultimate( entity_who_picked, "DamageModelComponent", function(comp,vars) 
			ComponentObjectSetValue2( comp, "damage_multipliers", "curse", 0.1 )
		end)
		
		--adding anchor for the left hand
		EntityAddComponent( entity_who_picked, "HotspotComponent",
		{
			_tags = "left_arm_root",
			sprite_hotspot_name = "left_arm_start",
		})
	end
})