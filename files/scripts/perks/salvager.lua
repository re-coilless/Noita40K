dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )
dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )

local hooman = GetUpdatedEntityID()
local char_x, char_y = EntityGetTransform( hooman )

local matter_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "matter_storage" )
local max_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "matter_max" )
local power_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "power_storage" )
local salvage_storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "salvage_mode" )
local matter_max = ComponentGetValue2( max_storage, "value_int" )
local matter_count = ComponentGetValue2( matter_storage, "value_int" )
local power_count = ComponentGetValue2( power_storage, "value_int" )
local salvage_mode = ComponentGetValue2( salvage_storage, "value_bool" )

local type_0 = { "this_is_sampo" }
local type_1 = { "orb", "essence", "item_perk" }
local type_2 = { "item_physics", "item_pickup", "tablet" }
local database = { { tags = type_0, power = 10000, matter = 1 }, { tags = type_1, power = 500, matter = 10 }, { tags = type_2, power = 5, matter = 100 } }

local future_matter = matter_count

if( salvage_mode ) then
	for i,anomaly_type in ipairs( database ) do
		local anomalies = {}
		for e,anomaly_tag in ipairs( anomaly_type.tags ) do
			local targets = EntityGetInRadiusWithTag( char_x, char_y, 50, anomaly_tag ) or {}
			anomalies = add_table( anomalies, targets )
		end
		
		for k,anomaly in ipairs( anomalies ) do
			if( not( EntityHasTag( anomaly, "gold_nugget" ) or EntityHasTag( anomaly, "chest" ))) then
				if( magic2binary( hooman, anomaly )) then
					local minv_comp = EntityGetFirstComponentIncludingDisabled( anomaly, "MaterialInventoryComponent" )
					if( minv_comp == nil ) then
						ComponentSetValue2( power_storage, "value_int", power_count + anomaly_type.power )
						future_matter = future_matter + anomaly_type.matter
					else
						for j,matter in ipairs( ComponentGetValue2( minv_comp, "count_per_material_type" )) do
							if( matter > 0 ) then
								for m,matter_tag in ipairs( CellFactory_GetTags( j - 1 )) do
									if( matter_tag == "[magic_liquid]" ) then
										future_matter = future_matter + matter
										AddMaterialInventoryMaterial( anomaly, CellFactory_GetName( j - 1 ), 0 )
									end
								end
							end
						end
					end
					EntityKill( anomaly )
				end
			end
		end
		
		function anomalies:tableKiller()
			self = nil
		end
	end
	
	local wands = EntityGetInRadiusWithTag( char_x, char_y, 50, "wand" ) or {}
	if( #wands > 0 ) then
		for i,wand in ipairs( wands ) do
			if( magic2binary( hooman, wand )) then
				local WPL = wand_rater( wand )
				
				local spells = EntityGetAllChildren( wand ) or {}
				if( #spells > 0 ) then
					for e,spell in ipairs( spells ) do
						if( EntityHasTag( spell, "card_action" )) then
							WPL = WPL + spell_rater( spell, true )
							future_matter = future_matter + 20
						end
					end
				end
				
				ComponentSetValue2( power_storage, "value_int", power_count + math.ceil( WPL ))
				future_matter = future_matter + 100
				
				EntityKill( wand )
			end
		end
	end
	
	local spells = EntityGetInRadiusWithTag( char_x, char_y, 50, "card_action" ) or {}
	if( #spells > 0 ) then
		for i,spell in ipairs( spells ) do
			if( magic2binary( hooman, spell )) then
				ComponentSetValue2( power_storage, "value_int", power_count + math.ceil( spell_rater( spell, false )))
				future_matter = future_matter + 20
				
				EntityKill( spell )
			end
		end
	end
	
	if( future_matter ~= matter_count ) then
		if( future_matter > matter_max ) then
			new_console_entry( hooman, "Matter overflow.", 0 )
			GameCreateParticle( "void_liquid", char_x, char_y, future_matter - matter_max, 1, 1, false )
			future_matter = matter_max
		end
		ComponentSetValue2( matter_storage, "value_int", future_matter )
	end
end