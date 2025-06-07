local hooman = GetUpdatedEntityID()
local gases_gone = GameGetGameEffect( hooman, "FARTS" )

if( gases_gone ~= 0 and ComponentGetValue2( gases_gone, "effect" ) ~= "NONE" ) then
	ComponentSetValue2( gases_gone, "effect", "NONE" )
end