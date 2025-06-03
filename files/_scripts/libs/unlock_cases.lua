unlock_cases = 
{
	{
		unlock = function( active_class, active_skin, stats )
			if( GameHasFlagRun( "ending_game_completed" )) then
				if( stats[ active_class ][ 3 ] == 0 ) then
					new_notification( string.gsub( class_info[ active_class ].class_name, "_", " " ).." is triumphant!", "Additional possibilities were unlocked." )
				end
				stats[ active_class ][ 3 ] = stats[ active_class ][ 3 ] + 1
				
				local skin_flag_name = "triumph_"..string.lower( class_info[active_class].skins[active_skin].name )
				if( not( HasFlagPersistent( skin_flag_name ))) then
					AddFlagPersistent( skin_flag_name )
					new_notification( string.gsub( class_info[active_class].skins[active_skin].name, "_", " " ).." has tasted the glory!", "Additional possibilities might be unlocked." )
				end
				
				if( stats[ 11 ][ 1 ] ~= 1 ) then
					stats[ 11 ][ 1 ] = 1
					new_notification( "Tech-priest unlocked!", "Check him in the main menu." )
				end
			else
				stats[ active_class ][ 2 ] = stats[ active_class ][ 2 ] + 1
			end
			
			return stats
		end,
		reset = function()
			ModSettingSetNextValue( "Noita40K.CURRENT_CLASS", 1, false )
			ModSettingSetNextValue( "Noita40K.CURRENT_SKIN", class_info[1].default_skin, false )
			ModSettingSetNextValue( "Noita40K.CLASS_STATS", "|:1:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:0:0:0:|:1:0:0:|", false )
			ModSettingSetNextValue( "Noita40K.CUSTOM_LOADOUT", "|BOLT_CARBINE|CHAINSWORD|BOLTER|MELTACUTTER|", false )
			
			for i,class in ipairs( class_info ) do
				if( #( class.skins or {}) > 0 ) then
					for e,skin in ipairs( class.skins ) do
						local skin_flag_name = "triumph_"..string.lower( skin.name )
						if( HasFlagPersistent( skin_flag_name )) then
							RemoveFlagPersistent( skin_flag_name )
						end
					end
				end
			end
		end,
	},
}