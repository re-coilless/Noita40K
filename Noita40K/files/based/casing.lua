local casing = GetUpdatedEntityID()
local x, y = EntityGetTransform( casing )
local name = EntityGetName( casing )
local count = tonumber( string.gsub( name, "^.*|", "" ), nil ) or 1
GameCreateParticle( string.gsub( name, "|.*$", "" ), x, y, count, 0, 0, false, false, true )
GamePlaySound( "mods/Noita40K/files/40K.bank", "items/casings/normal", x, y )