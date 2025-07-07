if( index.M.is_updating ) then
	return function( inv_info, item_info, is_out )
		local pic = "mods/Noita40K/files/items/attachments/bayonet_l.png"
	
		local gun_id = inv_info.id
		if( is_out ) then
			local pics = EntityGetComponentIncludingDisabled( gun_id, "SpriteComponent" )
			for i,p in ipairs( pics ) do
				if( ComponentGetValue2( p, "image_file" ) == pic ) then return EntityRemoveComponent( gun_id, p ) end
			end
		end
		
		local off_x, off_y = EntityGetHotspot( gun_id, "attachment_underbarrel", nil, true )
		EntityAddComponent2( gun_id, "SpriteComponent", {
			_enabled = false,
			_tags = "enabled_in_world,enabled_in_hand",
			offset_x = -off_x, offset_y = -off_y, image_file = pic,
		})
	end
else
	return function( info )
		local gun_id = EntityGetParent( info.id )
		if( index.D.active_item ~= gun_id ) then return end
		
		--should only work if pos delta is high enough
		
		local hooman = EntityGetRootEntity( gun_id )
		local _, _, r = EntityGetTransform( gun_id )
		local blade_x, blade_y = pen.get_hotspot_pos( gun_id, "attachment_underbarrel" )
		local hit_action = function( hit_id, k, hit_x, hit_y, dmg_mult, is_final )
			EntityInflictDamage( hit_id, dmg_mult*0.02, "DAMAGE_DRILL", "slash", "NORMAL", 0, 0, hooman, hit_x, hit_y, 0 )
		end
		pen.raytrace_entities( blade_x, blade_y, r, 15, hit_action, { is_debugging = true, shooter = hooman })
	end
end