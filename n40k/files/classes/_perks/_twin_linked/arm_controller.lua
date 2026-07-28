local l_arm = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( l_arm )

local aim_x, aim_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" ), "mAimingVector" )
ComponentSetValueVector2( EntityGetFirstComponentIncludingDisabled( l_arm, "ControlsComponent" ), "mAimingVector", aim_x, aim_y )

local RMB_down = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" ), "mButtonDownRightClick" )
if( RMB_down and not( GameIsInventoryOpen())) then
	if( not( EntityHasTag( ComponentGetValue( EntityGetFirstComponentIncludingDisabled( hooman, "Inventory2Component" ), "mActiveItem" ), "rmb_reactive" ))) then
		ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( l_arm, "PlatformShooterPlayerComponent" ), "mForceFireOnNextUpdate", true )
	end
end