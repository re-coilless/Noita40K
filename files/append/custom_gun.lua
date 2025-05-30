dofile_once( "mods/Noita40K/files/scripts/libs/mag_system.lua" )

function set_current_action_custom( action )
	c.action_id                	 = action.id
	c.action_name              	 = action.name
	c.action_description       	 = action.description
	c.action_sprite_filename   	 = action.sprite
	c.action_type              	 = action.type
	c.action_recursive           = action.recursive
	c.action_spawn_level       	 = action.spawn_level
	c.action_spawn_probability 	 = action.spawn_probability
	c.action_spawn_requires_flag = action.spawn_requires_flag
	c.action_spawn_manual_unlock = action.spawn_manual_unlock or false
	c.action_max_uses          	 = action.max_uses
	c.custom_xml_file          	 = action.custom_xml_file
	c.action_ai_never_uses		 = action.ai_never_uses or false
	c.action_never_unlimited	 = action.never_unlimited or false
	
	if( action.inventoryitem_id ~= nil ) then
		shot_controller( action.id.."."..action.inventoryitem_id )
	end
	
	c.action_is_dangerous_blast  = action.is_dangerous_blast

	c.sound_loop_tag = action.sound_loop_tag

	c.action_mana_drain = action.mana
	if action.mana == nil then
		c.action_mana_drain = ACTION_MANA_DRAIN_DEFAULT
	end

	c.action_unidentified_sprite_filename = action.sprite_unidentified
	if action.sprite_unidentified == nil then
		c.action_unidentified_sprite_filename = ACTION_UNIDENTIFIED_SPRITE_DEFAULT
	end

	current_action = action
end

set_current_action = set_current_action_custom