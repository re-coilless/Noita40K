dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

table.insert(perk_list,
{
	id = "SICARIAN_ARMOUR",
	ui_name = "Sicarian Battle Armour",
	ui_description = "",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/sicarian_armour.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/sicarian_armour.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		edit_component_with_tag_ultimate( entity_who_picked, "SpriteComponent", "character", function(comp,vars) 
			ComponentSetValue2( comp, "image_file", "mods/Noita40K/files/pics/classes_gfx/sicarian/player.xml" )
			ComponentSetValue2( comp, "offset_x", 6 )
			ComponentSetValue2( comp, "offset_y", 15 )
			EntityRefreshSprite( entity_who_picked, comp )
		end)
		
		local x, y = EntityGetTransform( entity_who_picked )
		local arm = EntityGetClosestWithTag( x, y, "player_arm_r" )
		edit_component_ultimate( arm, "SpriteComponent", function(comp,vars) 
			ComponentSetValue2( comp, "image_file", "mods/Noita40K/files/pics/classes_gfx/sicarian/player_arm.xml" )
			EntityRefreshSprite( arm, comp )
		end)
		
		edit_component_with_tag_ultimate( entity_who_picked, "SpriteComponent", "player_amulet", function(comp,vars) 
			ComponentSetValue2( comp, "image_file", "mods/Noita40K/files/pics/classes_gfx/sicarian/sigil.xml" )
			ComponentSetValue2( comp, "offset_x", 6 )
			ComponentSetValue2( comp, "offset_y", 15 )
			EntityRefreshSprite( entity_who_picked, comp )
		end)
		
		edit_component_with_tag_ultimate( entity_who_picked, "SpriteComponent", "player_hat2", function(comp,vars) 
			ComponentSetValue2( comp, "image_file", "mods/Noita40K/files/pics/classes_gfx/sicarian/crown.xml" )
			ComponentSetValue2( comp, "offset_x", 6 )
			ComponentSetValue2( comp, "offset_y", 16 )
			ComponentSetValue2( comp, "z_index", 0.601 )
			EntityRefreshSprite( entity_who_picked, comp )
		end)
		
		local capes = EntityGetAllChildren( entity_who_picked )
		if ( capes ~= nil ) then
			for i,cape in ipairs( capes ) do
				if( EntityGetName( cape ) == "cape" ) then
					edit_component_ultimate( cape, "VerletPhysicsComponent", function(comp,vars) 
						ComponentSetValue2( comp, "cloth_color", 0x0303C3 )
						ComponentSetValue2( comp, "cloth_color_edge", 0x0C0C76 )
					end)
				end
			end
		end
		
		edit_component_ultimate( entity_who_picked, "DamageModelComponent", function(comp,vars) 
			ComponentSetValue2( comp, "ragdoll_filenames_file", "" ) --"mods/Noita40K/files/pics/classes_gfx/sicarian/ragdoll/filenames.txt" )
			ComponentSetValue2( comp, "ragdollify_child_entity_sprites", true )
		end)
		
		local head_off = -11
		-- edit_component_ultimate( entity_who_picked, "CharacterDataComponent", function(comp,vars) 
			-- ComponentSetValue2( comp, "mass", ComponentGetValue2( comp, "mass" ) + 1 )
		-- end)
		
		edit_component_with_tag_ultimate( entity_who_picked, "VariableStorageComponent", "head_offset", function(comp,vars) 
			ComponentSetValue2( comp, "value_int", head_off )
		end)
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{ 
			_tags = "energy_cap",
			name = "energy_cap",
			value_float = "50",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{ 
			_tags = "energy_cur",
			name = "energy_cur",
			value_float = "0",
		})
		
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "energy_armour" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "energy_armour",
				script_damage_received = "mods/Noita40K/files/scripts/perks/energy_armour.lua",
				execute_every_n_frame = "-1",
			})
		end
		
		-- EntityAddComponent( entity_who_picked, "SpriteComponent", 
		-- { 
			-- _tags = "character,emissive_ass",
			-- image_file = "mods/Noita40K/files/pics/classes_gfx/sicarian/player_emissive.xml",
			-- rect_animation = "walk",
			-- z_index = "0.599",
			-- alpha = "1",
			-- emissive = "0",
			-- additive = "0",
			-- smooth_filtering = "0",
			-- fog_of_war_hole = "0",
		-- })
		
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "reactor" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "reactor",
				script_source_file = "mods/Noita40K/files/scripts/perks/reactor.lua",
				execute_every_n_frame = "1",
			})
			
			EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
			{
				_tags = "stable_value",
				name = "stable_value",
				value_int = "35",
			})
		end
		
		if( GameHasFlagRun( "PERK_PICKED_ETERNAL_VIGILANCE" ) and not( GameHasFlagRun( "PERK_GUI_EV_MODE" ))) then
			GameAddFlagRun( "PERK_GUI_EV_MODE" )
		end
	end
})

--ELECTRO-MECHANICAL AUGMENTATIONS
table.insert(perk_list,
{
	id = "OMNISSIAHS_BLESSING",
	ui_name = "Omnissiah's Blessing",
	ui_description = "To every problem, a solution lies in the application of tech-lore.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/omnissiahs_blessing.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/omnissiahs_blessing.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		ComponentSetValue2( GetGameEffectLoadTo( entity_who_picked, "NO_DAMAGE_FLASH", true ), "frames", -1 )
		EntityAddTag( entity_who_picked, "robot" )
	
		local matters = { "acid", "lava", "blood_cold", "poison", "rock_static_radioactive", "rock_static_poison", "ice_radioactive_static", "ice_radioactive_glass", "ice_acid_static", "ice_acid_glass", "rock_static_cursed", "gold_radioactive", "gold_static_radioactive", "rock_static_cursed_green", "cursed_liquid" }
		local matters_dmg = { 0.004, 0.004, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
		
		for i = 1,#matters do
			EntitySetDamageFromMaterial( entity_who_picked, matters[i], matters_dmg[i] )
		end
		
		edit_component_ultimate( entity_who_picked, "CharacterPlatformingComponent", function(comp,vars) 
			ComponentSetValue2( comp, "swim_idle_buoyancy_coeff", 0.5 )
			ComponentSetValue2( comp, "swim_down_buoyancy_coeff", 0.5 )
			ComponentSetValue2( comp, "swim_up_buoyancy_coeff", 0.5 )
		end)
		
		edit_component_ultimate( entity_who_picked, "DamageModelComponent", function(comp,vars) 
			ComponentSetValue2( comp, "fire_probability_of_ignition", 0 )
			ComponentSetValue2( comp, "blood_material", "spark_electric" )
			ComponentSetValue2( comp, "blood_spray_material", "spark_electric" )
			ComponentSetValue2( comp, "ragdoll_material", "plasteel_thin_box2d" )
			ComponentObjectSetValue2( comp, "damage_multipliers", "poison", 0 )
			ComponentObjectSetValue2( comp, "damage_multipliers", "radioactive", 0 )
			ComponentObjectSetValue2( comp, "damage_multipliers", "fire", 0 )
		end)
		
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "dedrugger" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "dedrugger",
				script_source_file = "mods/Noita40K/files/scripts/perks/dedrugger.lua",
				execute_every_n_frame = "1",
			})
		end
		
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "dealcoholer" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "dealcoholer",
				script_source_file = "mods/Noita40K/files/scripts/perks/dealcoholer.lua",
				execute_every_n_frame = "1",
			})
		end
		
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "defarter" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "defarter",
				script_source_file = "mods/Noita40K/files/scripts/perks/defarter.lua",
				execute_every_n_frame = "1",
			})
		end
	end
})

table.insert(perk_list,
{
	id = "BREATH_OF_MARS",
	ui_name = "Breath of Mars",
	ui_description = "Only flesh falters: the machine is never corrupted.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/breath_of_mars.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/breath_of_mars.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "rebreather" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "rebreather",
				script_source_file = "mods/Noita40K/files/scripts/perks/rebreather.lua",
				execute_every_n_frame = "1",
			})
		end
	
		local matters = { "blood_cold_vapour", "radioactive_gas", "radioactive_gas_static", "magic_gas_hp_regeneration" }
		local matters_dmg = { 0, 0, 0, -0.005 }
		
		for i = 1,#matters do
			EntitySetDamageFromMaterial( entity_who_picked, matters[i], matters_dmg[i] )
		end
	end
})

table.insert(perk_list,
{
	id = "ETERNAL_VIGILANCE",
	ui_name = "Eternal Vigilance",
	ui_description = "Know thine enemy, you are known to him already.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/eternal_vigilance.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/eternal_vigilance.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/perks/eternal_vigilance.lua",
			execute_every_n_frame = "1",
			-- vm_type = "ONE_PER_COMPONENT_INSTANCE",
		})
		
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "target_array" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "target_array",
				script_source_file = "mods/Noita40K/files/scripts/perks/target_detection.lua",
				execute_every_n_frame = "1",
			})
		end
		
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/perks/log_cleaner.lua",
			execute_every_n_frame = "1",
		})
		
		edit_component_ultimate( entity_who_picked, "LightComponent", function(comp,vars) 
			ComponentSetValue2( comp, "radius", 1000 )
		end)
		
		EntityAddComponent( entity_who_picked, "SpriteComponent", 
		{ 
			_tags = "fog_o_war_hole",
			alpha = "0.5",
			emissive = "0",
			image_file = "mods/Noita40K/files/pics/misc_gfx/fog_of_war_hole_64.xml",
			smooth_filtering = "1",
			fog_of_war_hole = "1",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "explorator_mode",
			name = "explorator_mode",
			value_bool = "0",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "show_targets",
			name = "show_targets",
			value_bool = "1",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "show_infer",
			name = "show_infer",
			value_bool = "1",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "show_console",
			name = "show_console",
			value_bool = "1",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "ss_menu_state",
			name = "ss_menu_state",
			value_bool = "0",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "ss_menu_page",
			name = "ss_menu_page",
			value_int = "0",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "captured_entity",
			name = "captured_entity",
			value_int = "0",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "waypoint",
			name = "waypoint",
			value_string = "|",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "last_log",
			name = "last_log",
			value_string = "",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "console_log",
			name = "console_log",
			value_string = "",
		})
	end
})

table.insert(perk_list,
{
	id = "MECHADENDRITES",
	ui_name = "Mechadendrites",
	ui_description = "If His will be done, let it be done quickly.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/mechadendrites.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/mechadendrites.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		edit_component_ultimate( entity_who_picked, "CharacterDataComponent", function(comp,vars) 
			ComponentSetValue2( comp, "fly_recharge_spd", 0 )
			ComponentSetValue2( comp, "fly_recharge_spd_ground", 0 )
			ComponentSetValue2( comp, "fly_time_max", 0 )
			ComponentSetValue2( comp, "flying_in_air_wait_frames", 60 )
			ComponentSetValue2( comp, "mFlyingTimeLeft", 0 )
		end)
		
		edit_component_ultimate( entity_who_picked, "CharacterPlatformingComponent", function(comp,vars) 
			ComponentSetValue2( comp, "accel_x", 0.5 )
			ComponentSetValue2( comp, "accel_x_air", 0.5 )
			ComponentSetValue2( comp, "run_velocity", 100 )
			ComponentSetValue2( comp, "fly_velocity_x", 100 )
			ComponentSetValue2( comp, "fly_speed_max_down", 100 )
			ComponentSetValue2( comp, "fly_speed_max_up", 100 )
			ComponentSetValue2( comp, "jump_velocity_x", 75 )
			ComponentSetValue2( comp, "jump_velocity_y", -150 )
			ComponentSetValue2( comp, "velocity_max_x", 150 )
			ComponentSetValue2( comp, "velocity_max_y", 350 )
			ComponentSetValue2( comp, "velocity_min_x", -150 )
			ComponentSetValue2( comp, "velocity_min_y", -200 )
		end)
		
		local x, y = EntityGetTransform( entity_who_picked )
		for i = 1,3 do
			EntityAddChild( entity_who_picked, EntityLoad( "mods/Noita40K/files/entities/misc/mechadendrites/dendrite_walking.xml", x, y ))
		end
		
		EntityAddComponent( entity_who_picked, "AudioLoopComponent", 
		{
			_tags = "enabled_in_world,wriggling",
			file = "mods/Noita40K/files/40K.bank",
			event_name = "player/dendrite_wriggling",
			volume_autofade_speed = "0.25",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "dendrites_active",
			name = "dendrites_active",
			value_bool = "1",
		})
		
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/perks/mechadendrites.lua",
			execute_every_n_frame = "1",
		})
	end
})

table.insert(perk_list,
{
	id = "REFRACTOR_FIELD",
	ui_name = "Refractor Field",
	ui_description = "Protect the shield of the mind, and the body will be shielded thereby.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/refractor_field.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/refractor_field.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "SpriteComponent", 
		{ 
			_tags = "character,shield_gen",
			image_file = "mods/Noita40K/files/pics/classes_gfx/sicarian/shield_gen.xml",
			offset_x = "6",
			offset_y = "15",
			rect_animation = "walk",
			z_index = "0.701",
		})
		
		-- EntityAddComponent( entity_who_picked, "SpriteStainsComponent", 
		-- { 
			-- sprite_id = "2",
			-- fade_stains_towards_srite_top = "0",
		-- })
		
		edit_component_with_tag_ultimate( entity_who_picked, "VariableStorageComponent", "energy_cap", function(comp,vars) 
			ComponentSetValue2( comp, "value_float", ComponentGetValue2( comp, "value_float" )*3 )
		end)
		
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/perks/refractor_field.lua",
			execute_every_n_frame = "1",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "refractor_online",
			name = "refractor_online",
			value_bool = "1",
		})
	end
})

table.insert(perk_list,
{
	id = "SERVOSKULL",
	ui_name = "Servo-skull",
	ui_description = "Through the application of knowledge can great destruction arise.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/servoskull.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/servoskull.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		local x, y = EntityGetTransform( entity_who_picked )
		EntityAddChild( entity_who_picked, EntityLoad( "mods/Noita40K/files/entities/misc/servoskull/servoskull.xml", x - 20, y ))
		EntityAddTag( entity_who_picked, "servoskull_owner" )
	end
})

--SPECIAL ABILITIES
table.insert(perk_list,
{
	id = "FENRISIAN_BLOOD",
	ui_name = "Fenrisian Blood",
	ui_description = "Fenris breeds heroes like a bar breeds drunks - loud, proud and spoiling for a fight.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/fenrisian_blood.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/fenrisian_blood.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		edit_component_ultimate( entity_who_picked, "DamageModelComponent", function(comp,vars)
			ComponentObjectSetValue2( comp, "damage_multipliers", "ice", ComponentObjectGetValue2( comp, "damage_multipliers", "ice" )*0.3 )
		end)
		
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/perks/fenrisian_blood.lua",
			execute_every_n_frame = "1",
		})
	end
})

table.insert(perk_list,
{
	id = "NOCTURNE_FORGED",
	ui_name = "Nocturne Forged",
	ui_description = "Thus are men's souls tested as metal in the forge's fire.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/nocturne_forged.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/nocturne_forged.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		edit_component_ultimate( entity_who_picked, "DamageModelComponent", function(comp,vars)
			ComponentObjectSetValue2( comp, "damage_multipliers", "fire", 0 )
		end)
		
		EntitySetDamageFromMaterial( entity_who_picked, "lava", 0.00005 )
	end
})

table.insert(perk_list,
{
	id = "EMPERORS_PRAETORIAN",
	ui_name = "Emperor's Praetorian",
	ui_description = "The Emperor commands us. Dorn guides us. Honour shields us.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/emperors_praetorian.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/emperors_praetorian.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		edit_component_ultimate( entity_who_picked, "DamageModelComponent", function(comp,vars)
			ComponentObjectSetValue2( comp, "damage_multipliers", "projectile", ComponentObjectGetValue2( comp, "damage_multipliers", "projectile" )*0.9 )
			ComponentObjectSetValue2( comp, "damage_multipliers", "melee", ComponentObjectGetValue2( comp, "damage_multipliers", "melee" )*0.8 )
		end)
		
		ComponentSetValue2( GetGameEffectLoadTo( entity_who_picked, "KNOCKBACK_IMMUNITY", true ), "frames", -1 )
		ComponentSetValue2( GetGameEffectLoadTo( entity_who_picked, "STUN_PROTECTION_ELECTRICITY", true ), "frames", -1 )
		
		edit_component_with_tag_ultimate( entity_who_picked, "VariableStorageComponent", "emperors_blessing", function(comp,vars) 
			ComponentSetValue2( comp, "value_int", math.ceil( ComponentGetValue2( comp, "value_int" )/2 ))
		end)
	end
})

table.insert(perk_list,
{
	id = "CODEX_MASTERY",
	ui_name = "Codex Mastery",
	ui_description = "We march for Macragge! And we shall know no fear!",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/codex_mastery.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/codex_mastery.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/perks/codex_mastery.lua",
			execute_every_n_frame = "1",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "finest_frame",
			name = "finest_frame",
			value_int = "0",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "finest_prev_frame",
			name = "finest_prev_frame",
			value_int = "0",
		})
	end
})

table.insert(perk_list,
{
	id = "BLACK_RAGE",
	ui_name = "Black Rage",
	ui_description = "It cries out for blood. And there is never enough.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/black_rage.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/black_rage.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/perks/black_rage.lua",
			execute_every_n_frame = "1",
		})
	end
})

table.insert(perk_list,
{
	id = "CHOGORIAN_SAVAGERY",
	ui_name = "Chogorian Savagery",
	ui_description = "Killing is nothing without beauty, and it may only be beautiful if it is necessary.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/chogorian_savagery.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/chogorian_savagery.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/perks/chogorian_savagery.lua",
			execute_every_n_frame = "1",
			-- vm_type = "ONE_PER_COMPONENT_INSTANCE",
		})
		
		EntityAddComponent( entity_who_picked, "VariableStorageComponent", 
		{
			_tags = "chogorian_timer",
			name = "chogorian_timer",
			value_int = "0",
		})
	end
})

table.insert(perk_list,
{
	id = "LIVING_SHADOW",
	ui_name = "Living Shadow",
	ui_description = "From the darkness we strike: fast and lethal, and by the time our foes can react ... darkness there and nothing more.",
	ui_icon = "mods/Noita40K/files/pics/perks_gfx/living_shadow.png",
	perk_icon = "mods/Noita40K/files/pics/perks_gfx/living_shadow.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "AudioLoopComponent", 
		{ 
			_tags = "shadow_is_going",
			file = "mods/Noita40K/files/40K.bank",
			event_name = "fx/status_effects/ambient/shadow",
			volume_autofade_speed = "0.25",
		})
		
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/Noita40K/files/scripts/perks/living_shadow.lua",
			execute_every_n_frame = "1",
			-- vm_type = "ONE_PER_COMPONENT_INSTANCE",
		})
	end
})