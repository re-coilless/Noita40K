local entity = GetUpdatedEntityID()

local this_x = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent", "this_x" )
local this_y = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent", "this_y" )
local last_x = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent", "last_x" )
local last_y = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent", "last_y" )

local x, y = EntityGetTransform( entity )
local this_x_num = ComponentGetValue2( this_x, "value_float" )
local this_y_num = ComponentGetValue2( this_y, "value_float" )

ComponentSetValue2( last_x, "value_float", this_x_num )
ComponentSetValue2( last_y, "value_float", this_y_num )
ComponentSetValue2( this_x, "value_float", x )
ComponentSetValue2( this_y, "value_float", y )