local entity_id = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( entity_id )
local i_x, i_y = EntityGetTransform( entity_id )

local ctrl_comp = EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" )
local LMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownLeftClick" )
local RMB_down = ComponentGetValue2( ctrl_comp, "mButtonDownRightClick" )

local matter_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialInventoryComponent" )
local osculant_storage = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "osculant_matter" )
local matter_count = 0
local osculant_count = ComponentGetValue2( osculant_storage, "value_int" )
for i,matter in ipairs( ComponentGetValue2( matter_comp, "count_per_material_type" )) do
	if( matter > 0 ) then
		for m,matter_tag in ipairs( CellFactory_GetTags( i - 1 )) do
			if( matter_tag == "[blood]" ) then
				matter_count = matter_count + matter
			end
		end
	end
end

if( LMB_down ) then
	if( not( LMB_pressed )) then
		GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/ui/holo_button", i_x, i_y )
		GamePrint( "[STORAGE]: -"..matter_count.." NM- | -"..osculant_count.." OM-" )
	end
	LMB_pressed = true
else
	LMB_pressed = false
end

if( RMB_down ) then
	if( not( RMB_pressed )) then
		if( osculant_count > 0 ) then
			GamePlaySound( "mods/Noita40K/files/40K.bank", "items/osculant_device/extract", i_x, i_y )
			GamePrint( "[STATUS]: EXTRACTED" )
			ComponentSetValue2( osculant_storage, "value_int", osculant_count - 1 )
			GameCreateParticle( "osculant_matter", i_x, i_y, 1, 0, 0, false )
		else
			GamePlaySound( "mods/Noita40K/files/40K.bank", "fx/ui/holo_failure", i_x, i_y )
			GamePrint( "[STATUS]: INSUFFICIENT OM" )
		end
	end
	RMB_pressed = true
else
	RMB_pressed = false
end

if( matter_count > 5000 ) then
	local delta = 0
	for i,matter in ipairs( ComponentGetValue2( matter_comp, "count_per_material_type" )) do
		if( matter > 0 ) then
			for m,matter_tag in ipairs( CellFactory_GetTags( i - 1 )) do
				if( matter_tag == "[blood]" ) then
					delta = delta + matter
					if( delta > 5000 ) then
						AddMaterialInventoryMaterial( entity_id, CellFactory_GetName( i - 1 ), delta - 5000 )
					else
						AddMaterialInventoryMaterial( entity_id, CellFactory_GetName( i - 1 ), 0 )
					end
				end
			end
		end
	end
	GamePlaySound( "mods/Noita40K/files/40K.bank", "items/osculant_device/synthesize", i_x, i_y )
	ComponentSetValue2( osculant_storage, "value_int", osculant_count + 1 )
	GamePrint( "[STATUS]: OM PRODUCED" )
end