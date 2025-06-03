local hooman = GetUpdatedEntityID()
local balls_gone = EntityGetFirstComponentIncludingDisabled( hooman, "DrugEffectComponent" )

if( ComponentGetIsEnabled( balls_gone )) then
	EntitySetComponentIsEnabled( hooman, balls_gone, false )
end