dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local effect_info = {}
for value in string.gmatch( ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "effect_info" ), "value_string" ), "([^|]+)" ) do
	table.insert( effect_info, value )
end

local targets = get_killable_stuff( x, y, tonumber( effect_info[3] ))
if( #targets > 0 ) then
	for i,target_id in ipairs( targets ) do
		if( EntityGetRootEntity( target_id ) == target_id ) then
			local t_x, t_y = EntityGetTransform( target_id )
			local t_eye = math.min( get_head_offset( target_id ), 0 )
			if( not( RaytracePlatforms( x, y - 2, t_x, effect_info[4] == "1" and ( t_y + t_eye ) or t_y )) and ( is_sentient( target_id ) or effect_info[5] == "0" ) and ( not( EntityHasTag( target_id, "robot" )) or tonumber( effect_info[5] ) < 2 )) then
				local theres_none = get_custom_effect( target_id, effect_info[1] ) == nil
				if( effect_info[6] == "0" or theres_none ) then
					LoadGameEffectEntityTo( target_id, effect_info[2] )
				end
				if( effect_info[7] ~= "0" and ( effect_info[8] == "1" or theres_none )) then
					ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( get_custom_effect( target_id, effect_info[1] ), "GameEffectComponent", "main" ), "frames", tonumber( effect_info[7] ))
				end
			end
		end
	end
end