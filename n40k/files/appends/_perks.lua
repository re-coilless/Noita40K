table.insert(perk_list,
{
	id = "ETERNAL_VIGILANCE",
	ui_name = "Eternal Vigilance",
	ui_description = "Know thine enemy, you are known to him already.",
	ui_icon = "mods/n40k/files/pics/perks_gfx/eternal_vigilance.png",
	perk_icon = "mods/n40k/files/pics/perks_gfx/eternal_vigilance.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/n40k/files/scripts/perks/eternal_vigilance.lua",
			execute_every_n_frame = "1",
			-- vm_type = "ONE_PER_COMPONENT_INSTANCE",
		})
		
		if( EntityGetFirstComponentIncludingDisabled( entity_who_picked, "LuaComponent", "target_array" ) == nil ) then
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				_tags = "target_array",
				script_source_file = "mods/n40k/files/scripts/perks/target_detection.lua",
				execute_every_n_frame = "1",
			})
		end
		
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/n40k/files/scripts/perks/log_cleaner.lua",
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
			image_file = "mods/n40k/files/pics/misc_gfx/fog_of_war_hole_64.xml",
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

--SPECIAL ABILITIES
table.insert(perk_list,
{
	id = "FENRISIAN_BLOOD",
	ui_name = "Fenrisian Blood",
	ui_description = "Fenris breeds heroes like a bar breeds drunks - loud, proud and spoiling for a fight.",
	ui_icon = "mods/n40k/files/pics/perks_gfx/fenrisian_blood.png",
	perk_icon = "mods/n40k/files/pics/perks_gfx/fenrisian_blood.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		edit_component_ultimate( entity_who_picked, "DamageModelComponent", function(comp,vars)
			ComponentObjectSetValue2( comp, "damage_multipliers", "ice", ComponentObjectGetValue2( comp, "damage_multipliers", "ice" )*0.3 )
		end)
		
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/n40k/files/scripts/perks/fenrisian_blood.lua",
			execute_every_n_frame = "1",
		})
	end
})

table.insert(perk_list,
{
	id = "NOCTURNE_FORGED",
	ui_name = "Nocturne Forged",
	ui_description = "Thus are men's souls tested as metal in the forge's fire.",
	ui_icon = "mods/n40k/files/pics/perks_gfx/nocturne_forged.png",
	perk_icon = "mods/n40k/files/pics/perks_gfx/nocturne_forged.png",
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
	ui_icon = "mods/n40k/files/pics/perks_gfx/emperors_praetorian.png",
	perk_icon = "mods/n40k/files/pics/perks_gfx/emperors_praetorian.png",
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
	ui_icon = "mods/n40k/files/pics/perks_gfx/codex_mastery.png",
	perk_icon = "mods/n40k/files/pics/perks_gfx/codex_mastery.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/n40k/files/scripts/perks/codex_mastery.lua",
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
	ui_icon = "mods/n40k/files/pics/perks_gfx/black_rage.png",
	perk_icon = "mods/n40k/files/pics/perks_gfx/black_rage.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/n40k/files/scripts/perks/black_rage.lua",
			execute_every_n_frame = "1",
		})
	end
})

table.insert(perk_list,
{
	id = "CHOGORIAN_SAVAGERY",
	ui_name = "Chogorian Savagery",
	ui_description = "Killing is nothing without beauty, and it may only be beautiful if it is necessary.",
	ui_icon = "mods/n40k/files/pics/perks_gfx/chogorian_savagery.png",
	perk_icon = "mods/n40k/files/pics/perks_gfx/chogorian_savagery.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/n40k/files/scripts/perks/chogorian_savagery.lua",
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
	ui_icon = "mods/n40k/files/pics/perks_gfx/living_shadow.png",
	perk_icon = "mods/n40k/files/pics/perks_gfx/living_shadow.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "AudioLoopComponent", 
		{ 
			_tags = "shadow_is_going",
			file = "mods/n40k/files/n40k.bank",
			event_name = "fx/status_effects/ambient/shadow",
			volume_autofade_speed = "0.25",
		})
		
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_source_file = "mods/n40k/files/scripts/perks/living_shadow.lua",
			execute_every_n_frame = "1",
			-- vm_type = "ONE_PER_COMPONENT_INSTANCE",
		})
	end
})