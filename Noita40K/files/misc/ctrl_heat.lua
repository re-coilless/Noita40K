--cool by liquids + add light source (do this through heating comp and check the number of pixels converted)
--smoke from barrel (through sprite emitter)
--remove comp if heat pic does not exist
--make guns with a parent but not equipped cool two times slower
--there should be delta handling for guns that are outside the range

return function( root_id )
    local root_x, root_y = EntityGetTransform( root_id )
    pen.t.loop( EntityGetInRadiusWithTag( root_x, root_y, 500, "heat40k" ), function( i, entity_id )
        local pics = EntityGetComponentIncludingDisabled( entity_id, "SpriteComponent" )
        local max_heat = pen.magic_storage( entity_id, "heat_max", "value_float" ) or -1
        if( not( pen.vld( pics )) or max_heat <= 0 ) then return end
        if( not( pen.vld( pics[2], true ))) then return end
        
        if( ComponentGetValue2( pics[2], "emissive" )) then
            ComponentSetValue2( pics[2], "emissive", false )
            ComponentSetValue2( pics[2], "image_file",
                string.gsub( ComponentGetValue2( pics[1], "image_file" ), "%.png$", "_heat.png" ))
            ComponentSetValue2( pics[2], "offset_x", ComponentGetValue2( pics[1], "offset_x" ) + 1 )
            ComponentSetValue2( pics[2], "offset_y", ComponentGetValue2( pics[1], "offset_y" ) + 1 )
            EntityRefreshSprite( entity_id, pics[2])
        end

        local alpha = ComponentGetValue2( pics[2], "alpha" )
        local heat = pen.magic_storage( entity_id, "heat", "value_float" ) or 0
        if( heat > 0 ) then
            heat = heat*pen.magic_storage( entity_id, "heat_loss", "value_float" )
            pen.magic_storage( entity_id, "heat", "value_float", heat )
        end

        local pic_update = false
        local perc = pen.rnd( 1/( 1 + math.exp( 12*( 0.45 - heat/max_heat ))), 100 )
        if( not( pen.epc( alpha, perc ))) then
            ComponentSetValue2( pics[2], "alpha", perc )
            pic_update = true
        end

        local heat_cutoff = pen.magic_storage( entity_id, "heat_cutoff", "value_float" ) or -1
        if( heat_cutoff > 0 and heat/max_heat < heat_cutoff ) then
            local x, y = EntityGetTransform( entity_id )
            pen.play_sound({ "mods/Noita40K/files/40K.bank", "items/overheat_end" }, x, y )
            pen.magic_storage( entity_id, "heat_cutoff", "value_float", -1 )
        end

        local main_z = ComponentGetValue2( pics[1], "z_index" )
        local heat_z = ComponentGetValue2( pics[2], "z_index" )
        if( main_z - heat_z < 0.01 ) then
            ComponentSetValue2( pics[2], "z_index", main_z - 0.01 )
            pic_update = true
        end

        if( pic_update ) then EntityRefreshSprite( entity_id, pics[2]) end
    end)
end