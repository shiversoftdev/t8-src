// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\overtime.gsc;
#using scripts\mp_common\gametypes\outcome.gsc;

#namespace round;

/*
	Name: function_37f04b09
	Namespace: round
	Checksum: 0x713E5FE4
	Offset: 0x78
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_37f04b09()
{
	outcome = outcome::function_a1a81955();
	game.outcome.var_3c5fdf73[game.outcome.var_3c5fdf73.size] = outcome;
	game.outcome.var_aefc8b8d = outcome;
}

/*
	Name: function_f37f02fc
	Namespace: round
	Checksum: 0x9174C357
	Offset: 0xE0
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function function_f37f02fc()
{
	return game.outcome.var_aefc8b8d;
}

/*
	Name: round_stats_init
	Namespace: round
	Checksum: 0x3D601CFF
	Offset: 0x100
	Size: 0x212
	Parameters: 0
	Flags: Linked
*/
function round_stats_init()
{
	if(!isdefined(game.roundsplayed))
	{
		game.roundsplayed = 0;
	}
	setroundsplayed(game.roundsplayed + overtime::get_rounds_played());
	overtime::round_stats_init();
	if(!isdefined(game.roundwinner))
	{
		game.roundwinner = [];
	}
	if(!isdefined(game.lastroundscore))
	{
		game.lastroundscore = [];
	}
	if(!isdefined(game.stat[#"roundswon"]))
	{
		game.stat[#"roundswon"] = [];
	}
	if(!isdefined(game.stat[#"roundswon"][#"tie"]))
	{
		game.stat[#"roundswon"][#"tie"] = 0;
	}
	foreach(team, _ in level.teams)
	{
		if(!isdefined(game.stat[#"roundswon"][team]))
		{
			game.stat[#"roundswon"][team] = 0;
		}
		level.teamspawnpoints[team] = [];
		level.spawn_point_team_class_names[team] = [];
	}
}

/*
	Name: set_flag
	Namespace: round
	Checksum: 0x678AB895
	Offset: 0x320
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function set_flag(flag)
{
	outcome::set_flag(game.outcome.var_aefc8b8d, flag);
}

/*
	Name: get_flag
	Namespace: round
	Checksum: 0x77A4974A
	Offset: 0x360
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function get_flag(flag)
{
	return outcome::get_flag(game.outcome.var_aefc8b8d, flag);
}

/*
	Name: clear_flag
	Namespace: round
	Checksum: 0x11384E49
	Offset: 0x3A0
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function clear_flag(flag)
{
	return outcome::clear_flag(game.outcome.var_aefc8b8d, flag);
}

/*
	Name: function_897438f4
	Namespace: round
	Checksum: 0x52AAB565
	Offset: 0x3E0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_897438f4(var_c1e98979)
{
	outcome::function_897438f4(game.outcome.var_aefc8b8d, var_c1e98979);
}

/*
	Name: function_3624d032
	Namespace: round
	Checksum: 0x1C5C6369
	Offset: 0x420
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function function_3624d032()
{
	return outcome::function_3624d032(game.outcome.var_aefc8b8d);
}

/*
	Name: get_winning_team
	Namespace: round
	Checksum: 0x1851E7E2
	Offset: 0x450
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function get_winning_team()
{
	return outcome::get_winning_team(game.outcome.var_aefc8b8d);
}

/*
	Name: function_b5f4c9d8
	Namespace: round
	Checksum: 0xC5BF3EC4
	Offset: 0x480
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function function_b5f4c9d8()
{
	return outcome::function_b5f4c9d8(game.outcome.var_aefc8b8d);
}

/*
	Name: get_winner
	Namespace: round
	Checksum: 0x6A88045F
	Offset: 0x4B0
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function get_winner()
{
	return outcome::get_winner(game.outcome.var_aefc8b8d);
}

/*
	Name: is_winner
	Namespace: round
	Checksum: 0xF97E709E
	Offset: 0x4E0
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function is_winner(team_or_player)
{
	return outcome::is_winner(game.outcome.var_aefc8b8d, team_or_player);
}

/*
	Name: set_winner
	Namespace: round
	Checksum: 0x907F95D6
	Offset: 0x520
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function set_winner(team_or_player)
{
	outcome::set_winner(game.outcome.var_aefc8b8d, team_or_player);
}

/*
	Name: function_35702443
	Namespace: round
	Checksum: 0xD9016928
	Offset: 0x560
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_35702443(platoon)
{
	/#
		assert(isdefined(level.platoons[platoon]));
	#/
	outcome::function_35702443(game.outcome.var_aefc8b8d, platoon);
}

/*
	Name: function_d30d1a2e
	Namespace: round
	Checksum: 0x4EFB076
	Offset: 0x5C8
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function function_d30d1a2e()
{
	return outcome::function_d30d1a2e(game.outcome.var_aefc8b8d);
}

/*
	Name: function_af2e264f
	Namespace: round
	Checksum: 0x2E28D93
	Offset: 0x5F8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_af2e264f(winner)
{
	outcome::function_af2e264f(game.outcome.var_aefc8b8d, winner);
}

/*
	Name: function_870759fb
	Namespace: round
	Checksum: 0xBC54AF33
	Offset: 0x638
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_870759fb()
{
	outcome::function_870759fb(game.outcome.var_aefc8b8d);
}

/*
	Name: is_overtime_round
	Namespace: round
	Checksum: 0x2DDDB871
	Offset: 0x668
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function is_overtime_round()
{
	if(game.overtime_round > 0)
	{
		return true;
	}
	return false;
}

