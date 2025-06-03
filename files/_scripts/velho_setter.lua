dofile_once( "data/scripts/gun/procedural/gun_action_utils.lua" )

local wand_id = GetUpdatedEntityID()
local w_x, w_y = EntityGetTransform( wand_id )
local spells = {}

local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
local deck_size = ComponentObjectGetValue2( abil_comp, "gun_config", "deck_capacity" )

SetRandomSeed( GameGetFrameNum(), w_x + w_y + wand_id + deck_size )

local counter = Random( math.floor( deck_size*0.125 ), math.floor( deck_size*0.25 ))
while counter > 0 do
	local spell_type = 6
	if( Random( 1, 3 ) == 3 ) then
		spell_type = 7
	end
	local spell = GetRandomActionWithType( w_x, w_y, Random( 1, 7 ), spell_type, counter ) --ACTION_TYPE_UTILITY/ACTION_TYPE_PASSIVE
	if( spell ~= nil and spell ~= "" ) then
		table.insert( spells, spell )
		counter = counter - 1
	end
end

counter = Random( math.floor( deck_size*0.375 ), math.floor( deck_size*0.625 ))
while counter > 0 do
	local spell_type = 2
	if( Random( 1, 10 ) == 10 ) then
		spell_type = 5
	end
	local spell_level = Random( 1, 100 )
	if( spell_level < 32 ) then
		spell_level = 5
	elseif( spell_level < 64 ) then
		spell_level = 6
	elseif( spell_level < 96 ) then
		spell_level = 7
	else
		spell_level = 10
	end
	local spell = GetRandomActionWithType( w_x, w_y, spell_level, spell_type, counter ) --ACTION_TYPE_MODIFIER/ACTION_TYPE_OTHER
	if( spell ~= nil and spell ~= "" ) then
		table.insert( spells, spell )
		counter = counter - 1
	end
end

table.insert( spells, ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "velho_main" ), "value_string" ))

if( #spells < deck_size ) then
	counter = Random( 0, 1 )
	while counter > 0 do
		local spell_level = Random( 1, 10 )
		if( spell_level < 10 ) then
			spell_level = Random( 1, 7 )
		else
			spell_level = 10
		end
		local spell = GetRandomActionWithType( w_x, w_y, spell_level, 1, counter ) --ACTION_TYPE_STATIC_PROJECTILE
		if( spell ~= nil and spell ~= "" ) then
			table.insert( spells, spell )
			counter = counter - 1
		end
	end
end

for i,spell in ipairs( spells ) do
	AddGunAction( wand_id, spell )
end