// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\planner_commander.gsc;

#namespace commander_util;

/*
	Name: function_2c38e191
	Namespace: commander_util
	Checksum: 0x7A013708
	Offset: 0x70
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function function_2c38e191(team)
{
	switch(team)
	{
		case "allies":
		{
			if(isdefined(level.alliescommander))
			{
				plannercommanderutility::function_2974807c(level.alliescommander);
			}
			break;
		}
		case "axis":
		{
			if(isdefined(level.axiscommander))
			{
				plannercommanderutility::function_2974807c(level.axiscommander);
			}
			break;
		}
	}
}

/*
	Name: pause_commander
	Namespace: commander_util
	Checksum: 0x93CBAE75
	Offset: 0x118
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function pause_commander(team)
{
	switch(team)
	{
		case "allies":
		{
			if(isdefined(level.alliescommander))
			{
				plannercommanderutility::pausecommander(level.alliescommander);
			}
			break;
		}
		case "axis":
		{
			if(isdefined(level.axiscommander))
			{
				plannercommanderutility::pausecommander(level.axiscommander);
			}
			break;
		}
	}
}

