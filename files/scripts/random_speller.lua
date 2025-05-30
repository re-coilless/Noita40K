local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local frame_num = GameGetFrameNum()

SetRandomSeed( frame_num, x + y + entity_id )
local spell = GetRandomActionWithType( x, y, Random( 0, 7 ), Random( 0, 7 ), frame_num )
if( spell ~= nil and spell ~= "" ) then
	CreateItemActionEntity( spell, x, y )
end