local casing = GetUpdatedEntityID()
local x, y = EntityGetTransform( casing ) 
GameCreateParticle( EntityGetName( casing ), x, y, 1, 0, 0, false, false, true )