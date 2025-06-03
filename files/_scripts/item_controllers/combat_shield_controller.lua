dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local entity_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( entity_id )
local i_x, i_y, i_r = EntityGetTransform( entity_id )
local c_x, c_y, c_r, c_s_x, c_s_y = EntityGetTransform( hooman )

local storage_mode = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "shield_mode" )
local mode = ComponentGetValue2( storage_mode, "value_bool" )

if( mode ) then
	if( shield_id ~= nil ) then
		local holder = EntityLoad( "mods/Noita40K/files/entities/misc/combat_shield/combat_shield_holder.xml", c_x, c_y )
		EntityAddChild( hooman, holder )
		EntityRemoveFromParent( shield_id )
		EntityAddChild( holder, shield_id )
		shield_id = nil
	end
else
	if( shield_id == nil or not( EntityGetIsAlive( shield_id ))) then
		shield_id = EntityLoad( "mods/Noita40K/files/entities/misc/combat_shield/combat_shield.xml", c_x, c_y )
		EntityAddChild( entity_id, shield_id )
	end
	
	if( hooman ~= entity_id ) then
		local a_x, a_y = EntityGetTransform( EntityGetClosestWithTag( i_x, i_y, "player_arm_r" ))
		local total_x = c_x + get_sign( c_s_x )*ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "SpriteComponent", "character" ), "offset_x" )*0.7
		local total_y = a_y
		EntitySetTransform( shield_id, total_x, total_y, c_r, get_sign( c_s_x ), c_s_y )
	end
end

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
if( ctrl_comp ~= nil ) then
	local RMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownRightClick" )
	if( RMB_down ) then
		if( not( RMB_pressed )) then
			if( mode ) then
				local holder = EntityGetClosestWithTag( i_x, i_y, "combat_shield_holder" )
				shield_id = EntityGetAllChildren( holder )[1]
				EntityRemoveFromParent( shield_id )
				EntityKill( holder )
				EntityAddChild( entity_id, shield_id )
				ComponentSetValue2( storage_mode, "value_bool", false )
				GamePlaySound( "mods/Noita40K/files/40K.bank", "items/unequip", i_x, i_y )
			else
				ComponentSetValue2( storage_mode, "value_bool", true )
				GamePlaySound( "mods/Noita40K/files/40K.bank", "items/equip", i_x, i_y )
			end
		end
		RMB_pressed = true
	else
		RMB_pressed = false
	end
end