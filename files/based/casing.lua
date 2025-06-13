local casing = GetUpdatedEntityID()
local x, y = EntityGetTransform( casing ) 
GameCreateParticle( EntityGetName( casing ), x, y, 1, 0, 0, false, false, true )
GamePlaySound( "mods/Noita40K/files/40K.bank", "items/casings/normal", x, y )