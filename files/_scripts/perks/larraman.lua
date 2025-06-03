dofile_once( "mods/Noita40K/files/scripts/libs/black_library.lua" )

local hooman = GetUpdatedEntityID()

local health_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
local char_x, char_y = EntityGetTransform( hooman )

local current_hp = ComponentGetValue2( health_comp, "hp" )
local max_hp = ComponentGetValue2( health_comp, "max_hp" )

local radius = 250
local HIGHEST_ADRENALINE = 2500

local storage = EntityGetFirstComponentIncludingDisabled( hooman, "VariableStorageComponent", "larraman_frame" )
local healing_frame = ComponentGetValue2( storage, "value_int" )
local current_frame = GameGetFrameNum()

if( current_hp < max_hp*0.7 and current_hp > max_hp*0.3 and healing_frame <= current_frame ) then
	local adrenalin = get_threat_level( hooman, false )
	
	local heal_amount = math.floor( max_hp/current_hp )/25
	ComponentSetValue2( health_comp, "hp", current_hp + heal_amount )
	
	if( adrenalin > HIGHEST_ADRENALINE ) then
		adrenalin = HIGHEST_ADRENALINE
	end
	
	local cooler = math.floor( -827 + ( 600 + 827 )/( 1 + ( adrenalin/46100 )^0.12 )) --from 600 to 10 cooldown frames
	ComponentSetValue2( storage, "value_int", current_frame + cooler )
end