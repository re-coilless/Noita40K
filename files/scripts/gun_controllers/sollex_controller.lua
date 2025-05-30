dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local wand_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( wand_id )
local w_x, w_y, w_rotation, w_scale_x, w_scale_y = EntityGetTransform( wand_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
local LMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownFire" )
local RMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownRightClick" ) and not( EntityHasTag( hooman, "twin_linked" ))

local frame_num = GameGetFrameNum()

local storage_active = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "active" )
local storage_hype = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "hype" )
local storage_count = EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "count" )
local hype = ComponentGetValue2( storage_hype, "value_bool" )
local count = ComponentGetValue2( storage_count, "value_int" )

local diameter = 25
local d_angle = 20

if( beam_id == nil or not( EntityGetIsAlive( beam_id ))) then
	ComponentSetValue2( storage_active, "value_bool", false )

	beam_id = EntityLoad( "mods/Noita40K/files/entities/projectiles/beam_sollex_visual.xml", w_x, w_y )
	EntityAddChild( wand_id, beam_id )
end

if(( RMB_down or ( LMB_down and EntityHasTag( hooman, "twin_linked" ))) and not( GameIsInventoryOpen())) then
	if( not( RMB_pressed )) then
		if( ComponentGetValue2( storage_active, "value_bool" )) then
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/sollex/end", w_x, w_y )
			ComponentSetValue2( storage_active, "value_bool", false )
		else
			GameScreenshake( 2 )
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/sollex/start", w_x, w_y )
			ComponentSetValue2( storage_active, "value_bool", true )
		end
	end
	RMB_pressed = true
else
	RMB_pressed = false
end

if( hype ) then
	if( count <= 360/d_angle - 1 ) then
		EntitySetTransform( wand_id, w_x, w_y, w_rotation + get_sign( w_scale_y )*count*math.rad( d_angle ), w_scale_x, w_scale_y )
		w_x, w_y, w_rotation, w_scale_x, w_scale_y = EntityGetTransform( wand_id )
		ComponentSetValue2( storage_count, "value_int", count + 1 )
	else
		ComponentSetValue2( storage_count, "value_int", 1 )
		ComponentSetValue2( storage_hype, "value_bool", false )
	end
elseif( LMB_down and not( EntityHasTag( hooman, "twin_linked" ))) then
	ComponentSetValue2( storage_hype, "value_bool", true )
end

if( ComponentGetValue2( storage_active, "value_bool" )) then
	GameEntityPlaySoundLoop( wand_id, "sollex_is_going", 1.0 )
	
	local rays = EntityGetAllChildren( beam_id )
	for i,ray in ipairs( rays ) do
		local emit_comp = EntityGetFirstComponentIncludingDisabled( ray, "LaserEmitterComponent" )
		ComponentSetValue2( emit_comp, "emit_until_frame", frame_num + 1 )
	end
	
	local barrel_x, barrel_y = EntityGetTransform( beam_id )
	local end_x = barrel_x + math.cos( w_rotation )*diameter
	local end_y = barrel_y + math.sin( w_rotation )*diameter
	
	local hit, hit_x, hit_y = RaytraceSurfacesAndLiquiform( barrel_x, barrel_y, end_x, end_y )
	
	local l_x = 0
	local l_y = 0
	local lenght = 0
	local filename = "mods/Noita40K/files/entities/projectiles/beam_sollex_physical.xml"
	if( hit ) then
		l_x = hit_x - barrel_x
		l_y = hit_y - barrel_y
		lenght = math.sqrt(( l_x )^2 + ( l_y )^2 ) + 1
		EntityLoad( filename, hit_x, hit_y )
	else
		l_x = math.cos( w_rotation )*diameter
		l_y = math.sin( w_rotation )*diameter
		lenght = diameter
		EntityLoad( filename, end_x, end_y )
	end
	
	if( lenght > 0 ) then
		local amount = math.ceil( lenght/2 )
		local delta_x = l_x/amount
		local delta_y = l_y/amount
		
		local hit_action = function( hooman, deadman, k, beam_part_x, beam_part_y, hitbox_dmg_scale )
			GamePlaySound( "mods/Noita40K/files/sfx/40K.bank", "guns/burst", beam_part_x, beam_part_y )
			EntityInflictDamage( deadman, 0.07*hitbox_dmg_scale, "DAMAGE_MATERIAL", "[BURN, HERETIC]", "NORMAL", 0, 0, hooman, beam_part_x, beam_part_y, 0 )
		end
		
		local meat = get_killable_stuff( barrel_x + l_x/2, barrel_y + l_y/2, lenght/2 + 20 )
		if( #meat > 0 ) then
			for e,deadman in ipairs( meat ) do
				if( hooman ~= deadman ) then
					beam_hitter( hooman, deadman, barrel_x, barrel_y, amount - 1, delta_x, delta_y, true, hit_action )
				end
			end
		end
		
		local lead = EntityGetInRadiusWithTag( barrel_x + l_x/2, barrel_y + l_y/2, lenght/2 + 5, "projectile" ) or {}
		if( #lead > 0 ) then
			for m,crap in ipairs( lead ) do
				local proj_comp = EntityGetFirstComponentIncludingDisabled( crap, "ProjectileComponent" )
				if( hooman ~= ComponentGetValue2( proj_comp, "mWhoShot" )) then
					local pj_x, pj_y = EntityGetTransform( crap )
					
					for l = 0,amount-1 do
						local beam_part_x = barrel_x + delta_x*l
						local beam_part_y = barrel_y + delta_y*l
						
						if(( beam_part_x <= pj_x + 2 ) and ( beam_part_x >= pj_x - 2 ) and ( beam_part_y <= pj_y + 2 ) and ( beam_part_y >= pj_y - 2 )) then
							EntityKill( crap )
							break
						end
					end
				end
			end
		end
	end
end