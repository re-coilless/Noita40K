function spawn_corpse( x, y )
	EntityLoad( "data/entities/items/books/book_corpse.xml", x - 10, y )
	
	EntityLoad( "mods/Noita40K/files/entities/guns/bolter_velho.xml", x + 50, y - 20 )
	EntityLoad( "mods/Noita40K/files/entities/props/corpse_vallo.xml", x + 10, y )
end