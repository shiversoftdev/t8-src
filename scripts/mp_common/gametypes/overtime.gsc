// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace overtime;

/*
	Name: main
	Namespace: overtime
	Checksum: 0x5E54D3F1
	Offset: 0x78
	Size: 0x3E
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	if(!isdefined(game.overtime_round))
	{
		game.overtime_round = 0;
	}
	if(!isdefined(level.nextroundisovertime))
	{
		level.nextroundisovertime = 0;
	}
}

/*
	Name: is_overtime_round
	Namespace: overtime
	Checksum: 0x8BF4CF92
	Offset: 0xC0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function is_overtime_round()
{
	if(game.overtime_round > 0)
	{
		return true;
	}
	return false;
}

/*
	Name: round_stats_init
	Namespace: overtime
	Checksum: 0x7742F650
	Offset: 0xE8
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function round_stats_init()
{
	if(is_overtime_round())
	{
		setmatchflag("overtime", 1);
	}
	else
	{
		setmatchflag("overtime", 0);
	}
	if(!isdefined(game.stat[#"overtimeroundswon"]))
	{
		game.stat[#"overtimeroundswon"] = [];
	}
	if(!isdefined(game.stat[#"overtimeroundswon"][#"tie"]))
	{
		game.stat[#"overtimeroundswon"][#"tie"] = 0;
	}
	foreach(team, _ in level.teams)
	{
		if(!isdefined(game.stat[#"overtimeroundswon"][team]))
		{
			game.stat[#"overtimeroundswon"][team] = 0;
		}
	}
}

/*
	Name: get_rounds_played
	Namespace: overtime
	Checksum: 0xEE9C5D2F
	Offset: 0x290
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function get_rounds_played()
{
	if(game.overtime_round == 0)
	{
		return game.overtime_round;
	}
	return game.overtime_round - 1;
}

/*
	Name: function_f435f4dd
	Namespace: overtime
	Checksum: 0xD1C3D6F9
	Offset: 0x2C8
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_f435f4dd()
{
	if(isdefined(level.shouldplayovertimeround))
	{
		if([[level.shouldplayovertimeround]]())
		{
			level.nextroundisovertime = 1;
			return;
		}
	}
	level.nextroundisovertime = 0;
}

