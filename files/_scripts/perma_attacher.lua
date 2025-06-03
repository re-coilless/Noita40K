dofile_once( "data/scripts/gun/procedural/gun_action_utils.lua" )

local wand_id = GetUpdatedEntityID()
AddGunActionPermanent( wand_id, ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( wand_id, "VariableStorageComponent", "perma" ), "value_string" ))