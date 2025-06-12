--cool by liquids + add light source
--smoke from barrel (through sprite emitter)
--remove comp if heat pic does not exist
--make guns with a parent but not equipped cool two times slower
--there should be delta handling for guns that are outside the range

--degrate firerate at high heat and lower accuracy, overheat on full-auto guns has a chance to trigger runaway detonation in the form of uncontrolled fast firing magdump with radnomized intervals and insanely low accuracy (continue to detonate even in inventory)

return function( entity_id )
    local x, y = EntityGetTransform( entity_id )
    pen.t.loop( EntityGetInRadiusWithTag( x, y, 500, "gun" ), function( i, gun_id )
        local pics = EntityGetComponentIncludingDisabled( gun_id, "SpriteComponent" )
        local max_heat = pen.magic_storage( gun_id, "heat_max", "value_float" ) or -1
        if( not( pen.vld( pics )) or max_heat <= 0 ) then return end
        
        if( not( pen.vld( pics[2], true ))) then return end
        if( ComponentGetValue2( pics[2], "emissive" )) then
            ComponentSetValue2( pics[2], "emissive", false )
            ComponentSetValue2( pics[2], "image_file",
                string.gsub( ComponentGetValue2( pics[1], "image_file" ), "%.png$", "_heat.png" ))
            ComponentSetValue2( pics[2], "offset_x", ComponentGetValue2( pics[1], "offset_x" ) + 1 )
            ComponentSetValue2( pics[2], "offset_y", ComponentGetValue2( pics[1], "offset_y" ) + 1 )
            EntityRefreshSprite( gun_id, pics[2])
        end

        local alpha = ComponentGetValue2( pics[2], "alpha" )
        local heat = pen.magic_storage( gun_id, "heat", "value_float" ) or 0
        if( heat > 0 ) then
            pen.magic_storage( gun_id, "heat", "value_float", heat*pen.magic_storage( gun_id, "heat_loss", "value_float" ))
        end

        local heat_perc = pen.rounder( 1/( 1 + math.exp( 12*( 0.45 - heat/max_heat ))), 100 )
        if( not( pen.eps_compare( alpha, heat_perc ))) then
            ComponentSetValue2( pics[2], "alpha", heat_perc )
            EntityRefreshSprite( gun_id, pics[2])
        end
    end)
end