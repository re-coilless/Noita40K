local space_marine_stylish_taunts =
{
	{
		{
			sfx_path = "stylish/space_marine/taunt1",
			cooldown_frames = 144,
		},
		{
			sfx_path = "stylish/space_marine/taunt2",
			cooldown_frames = 96,
		},
		{
			sfx_path = "stylish/space_marine/taunt3",
			cooldown_frames = 84,
		},
		{
			sfx_path = "stylish/space_marine/taunt4",
			cooldown_frames = 84,
		},
		{
			sfx_path = "stylish/space_marine/taunt5",
			cooldown_frames = 96,
		},
		{
			sfx_path = "stylish/space_marine/taunt6",
			cooldown_frames = 57,
		},
		{
			sfx_path = "stylish/space_marine/taunt7",
			cooldown_frames = 90,
		},
		{
			sfx_path = "stylish/space_marine/taunt8",
			cooldown_frames = 132,
		},
		{
			sfx_path = "stylish/space_marine/taunt9",
			cooldown_frames = 78,
		},
	},
}

local salamander_stylish_taunts = 
{
	{
		{
			sfx_path = "stylish/space_marine/salamander/taunt1",
			cooldown_frames = 48,
		},
		{
			sfx_path = "stylish/space_marine/salamander/taunt2",
			cooldown_frames = 144,
		},
		{
			sfx_path = "stylish/space_marine/salamander/taunt3",
			cooldown_frames = 144,
		},
		{
			sfx_path = "stylish/space_marine/salamander/taunt4",
			cooldown_frames = 102,
		},
		{
			sfx_path = "stylish/space_marine/salamander/taunt5",
			cooldown_frames = 132,
		},
	},
}

local space_marine_emotional_taunts =
{
	{
		{
			sfx_path = "emotional/space_marine/taunt1",
			cooldown_frames = 108,
		},
		{
			sfx_path = "emotional/space_marine/taunt2",
			cooldown_frames = 96,
		},
		{
			sfx_path = "emotional/space_marine/taunt3",
			cooldown_frames = 114,
		},
		{
			sfx_path = "emotional/space_marine/taunt4",
			cooldown_frames = 138,
		},
		{
			sfx_path = "emotional/space_marine/taunt5",
			cooldown_frames = 120,
		},
		{
			sfx_path = "emotional/space_marine/taunt6",
			cooldown_frames = 72,
		},
		{
			sfx_path = "emotional/space_marine/taunt7",
			cooldown_frames = 114,
		},
	},
	function( hooman, wand_id, rnd )
		ComponentSetValue2( GetGameEffectLoadTo( hooman, "BERSERK", true ), "frames", 60 )
	end,
}

local salamander_emotional_taunts =
{
	{
		{
			sfx_path = "emotional/space_marine/salamander/taunt1",
			cooldown_frames = 60,
		},
		{
			sfx_path = "emotional/space_marine/salamander/taunt2",
			cooldown_frames = 132,
		},
		{
			sfx_path = "emotional/space_marine/salamander/taunt3",
			cooldown_frames = 102,
		},
		{
			sfx_path = "emotional/space_marine/salamander/taunt4",
			cooldown_frames = 66,
		},
		{
			sfx_path = "emotional/space_marine/salamander/taunt5",
			cooldown_frames = 144,
		},
		{
			sfx_path = "emotional/space_marine/salamander/taunt6",
			cooldown_frames = 78,
		},
	},
	function( hooman, wand_id, rnd )
		ComponentSetValue2( GetGameEffectLoadTo( hooman, "BERSERK", true ), "frames", 60 )
	end,
}

local tech_priest_stylish_taunts =
{
	{
		{
			sfx_path = "stylish/tech_priest/taunt1",
			cooldown_frames = 252,
		},
		{
			sfx_path = "stylish/tech_priest/taunt2",
			cooldown_frames = 210,
		},
		{
			sfx_path = "stylish/tech_priest/taunt3",
			cooldown_frames = 150,
		},
		{
			sfx_path = "stylish/tech_priest/taunt4",
			cooldown_frames = 78,
		},
		{
			sfx_path = "stylish/tech_priest/taunt5",
			cooldown_frames = 138,
		},
		{
			sfx_path = "stylish/tech_priest/taunt6",
			cooldown_frames = 90,
		},
		{
			sfx_path = "stylish/tech_priest/taunt7",
			cooldown_frames = 78,
		},
		{
			sfx_path = "stylish/tech_priest/taunt8",
			cooldown_frames = 90,
		},
		{
			sfx_path = "stylish/tech_priest/taunt9",
			cooldown_frames = 156,
		},
	},
	function( hooman, wand_id, rnd )
		dofile_once( "mods/Noita40K/files/scripts/libs/gui_lib.lua" )
		new_console_entry( hooman, "Executing voiceline"..rnd..".", 0 )
	end,
}

local stylish_taunts = {}
stylish_taunts["1-1"] = space_marine_stylish_taunts
stylish_taunts["1-2"] = space_marine_stylish_taunts
stylish_taunts["1-3"] = salamander_stylish_taunts
stylish_taunts["1-4"] = space_marine_stylish_taunts
stylish_taunts["1-5"] = space_marine_stylish_taunts
stylish_taunts["1-6"] = space_marine_stylish_taunts
stylish_taunts["1-7"] = space_marine_stylish_taunts
stylish_taunts["1-8"] = space_marine_stylish_taunts
stylish_taunts["1-9"] = space_marine_stylish_taunts
stylish_taunts["11-1"] = tech_priest_stylish_taunts

local emotional_taunts = {}
emotional_taunts["1-1"] = space_marine_emotional_taunts
emotional_taunts["1-2"] = space_marine_emotional_taunts
emotional_taunts["1-3"] = salamander_emotional_taunts
emotional_taunts["1-4"] = space_marine_emotional_taunts
emotional_taunts["1-5"] = space_marine_emotional_taunts
emotional_taunts["1-6"] = space_marine_emotional_taunts
emotional_taunts["1-7"] = space_marine_emotional_taunts
emotional_taunts["1-8"] = space_marine_emotional_taunts
emotional_taunts["1-9"] = space_marine_emotional_taunts

taunt_list = { stylish_taunts, emotional_taunts, }