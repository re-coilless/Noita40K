local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local fuse_storage = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "fuse_state" )
local fuse_state = ComponentGetValue2( fuse_storage, "value_int" )

local hooman = EntityGetRootEntity( entity_id )
if( hooman ~= entity_id ) then
	local active_id = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "Inventory2Component" ), "mActiveItem" )
	local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
	local THROW_down = ComponentGetValue2( ctrl_comp, "mButtonDownThrow" )
	if( THROW_down and tonumber( active_id ) == tonumber( entity_id ) and fuse_state < 0 ) then
		local sprite_comp = EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "character" )
		if( sprite_comp ~= nil ) then
			local current_anim = ComponentGetValue2( sprite_comp, "rect_animation" )
			if( current_anim == "throw" or current_anim == "throw_old" or current_anim == "throw_item" or current_anim == "throw_small" or current_anim == "throw_crouched" ) then
				local explosion = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "explosion_entity" ), "value_string" )
				ComponentObjectSetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "ExplosionComponent" ), "config_explosion", "load_this_entity", explosion )
				GamePlaySound( "mods/Noita40K/files/40K.bank", "items/pin_pull", x, y )
				ComponentSetValue2( fuse_storage, "value_int", math.abs( fuse_state ))
			end
		end
	end
end

if( fuse_state > -1 ) then
	if( fuse_state > 0 ) then
		ComponentSetValue2( fuse_storage, "value_int", fuse_state - 1 )
	else
		local sfx_storage = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "custom_sfx" )
		if( sfx_storage ~= nil ) then
			GamePlaySound( "mods/Noita40K/files/40K.bank", ComponentGetValue2( sfx_storage, "value_string" ), x, y )
		end
		EntityKill( entity_id )
	end
end