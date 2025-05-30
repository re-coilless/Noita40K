dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local hooman = GetUpdatedEntityID()

shadow_progress = shadow_progress or 0
pos_before = pos_current or { 0, 0, }
pos_current = { EntityGetTransform( hooman ) }
local velocity = math.sqrt(( pos_current[1] - pos_before[1] )^2 + ( pos_current[2] - pos_before[2] )^2 )
if( velocity < 0.005 ) then
	if( shadow_progress < 1 ) then
		local pics = EntityGetComponent( hooman, "SpriteComponent" ) or {}
		if( #pics > 0 ) then
			for i,pic in ipairs( pics ) do
				ComponentSetValue2( pic, "alpha", 1 - shadow_progress/1.5 )
			end
		end
		
		shadow_progress = shadow_progress + 0.01
		if( shadow_progress > 0.99 ) then
			ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "GenomeDataComponent" ), "herd_id", StringToHerdId( "living_shadow" ))
		end
	else
		GameEntityPlaySoundLoop( hooman, "shadow_is_going", 1.0 )
	end
	
	if( not( ModSettingGetNextValue( "Noita40K.DISABLE_SHADERS" ))) then
		set_shader( hooman, "living_shadow", false, shadow_progress )
	end
elseif( shadow_progress > 0 ) then
	local pics = EntityGetComponent( hooman, "SpriteComponent" ) or {}
	if( #pics > 0 ) then
		for i,pic in ipairs( pics ) do
			ComponentSetValue2( pic, "alpha", 1 )
		end
	end
	
	set_shader( hooman, "living_shadow" )
	ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "GenomeDataComponent" ), "herd_id", StringToHerdId( "player" ))
	shadow_progress = 0
end