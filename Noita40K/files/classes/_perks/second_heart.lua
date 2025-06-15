dofile_once( "mods/Noita40K/files/_lib.lua" )

function damage_received( damage, message, entity_thats_responsible, is_fatal )
	local hooman = GetUpdatedEntityID()
	if( not( is_fatal )) then return end
	
	local dmg_comp = EntityGetFirstComponentIncludingDisabled( hooman, "DamageModelComponent" )
	if( not( pen.vld( dmg_comp, true ))) then return end
	
	local is_mortal = ComponentGetValue2( dmg_comp, "invincibility_frames" ) == 0
	if( not( is_mortal )) then return end
	
	ComponentSetValue2( dmg_comp, "invincibility_frames", 60 )
	ComponentSetValue2( dmg_comp, "hp", 1 + damage )
	
	--use index for notifications
	--new_notification( "SECONDARY HEART SAVED YOU", "And in the dark when the shadows threaten, the Emperor is with us, in spirit and in fact.", false )
	
	EntityRemoveComponent( hooman, GetUpdatedComponentID())
end