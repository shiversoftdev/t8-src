// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;

#namespace outcome;

/*
	Name: main
	Namespace: outcome
	Checksum: 0xC927B62D
	Offset: 0xA0
	Size: 0x9A
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	level.var_9b671c3c[#"tie"] = {#hash_6cab3b8e:1, #flag:"tie"};
	level.var_9b671c3c[#"overtime"] = {#hash_6cab3b8e:2, #flag:"overtime"};
}

/*
	Name: function_a1a81955
	Namespace: outcome
	Checksum: 0x51553BAE
	Offset: 0x148
	Size: 0xFA
	Parameters: 0
	Flags: Linked
*/
function function_a1a81955()
{
	outcome = spawnstruct();
	outcome.flags = 0;
	outcome.var_c1e98979 = 0;
	outcome.team = #"free";
	foreach(team, _ in level.teams)
	{
		outcome.team_score[team] = 0;
	}
	outcome.platoon = #"none";
	outcome.players = [];
	outcome.var_f79c6bfc = [];
	return outcome;
}

/*
	Name: is_winner
	Namespace: outcome
	Checksum: 0x1391BBCE
	Offset: 0x250
	Size: 0xDA
	Parameters: 2
	Flags: Linked
*/
function is_winner(outcome, team_or_player)
{
	if(isplayer(team_or_player))
	{
		if(isdefined(outcome.players) && outcome.players.size && outcome.players[0] == team_or_player)
		{
			return true;
		}
		if(isdefined(outcome.team) && outcome.team == team_or_player.team)
		{
			return true;
		}
	}
	else if(isdefined(outcome.team) && outcome.team == team_or_player)
	{
		return true;
	}
	return false;
}

/*
	Name: set_flag
	Namespace: outcome
	Checksum: 0x90555BFA
	Offset: 0x338
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function set_flag(outcome, flag)
{
	outcome flagsys::set(flag);
}

/*
	Name: get_flag
	Namespace: outcome
	Checksum: 0xDA160E79
	Offset: 0x370
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function get_flag(outcome, flag)
{
	return outcome flagsys::get(flag);
}

/*
	Name: clear_flag
	Namespace: outcome
	Checksum: 0x5457B92B
	Offset: 0x3A8
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function clear_flag(outcome, flag)
{
	return outcome flagsys::clear(flag);
}

/*
	Name: function_2e00fa44
	Namespace: outcome
	Checksum: 0x95D947DE
	Offset: 0x3E0
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_2e00fa44(outcome)
{
	flags = 0;
	foreach(var_b4a9554f in level.var_9b671c3c)
	{
		if(outcome flagsys::get(var_b4a9554f.flag))
		{
			flags = flags | var_b4a9554f.var_6cab3b8e;
		}
	}
	return flags;
}

/*
	Name: function_897438f4
	Namespace: outcome
	Checksum: 0xAA8108AD
	Offset: 0x4A0
	Size: 0x22
	Parameters: 2
	Flags: Linked
*/
function function_897438f4(outcome, var_c1e98979)
{
	outcome.var_c1e98979 = var_c1e98979;
}

/*
	Name: function_3624d032
	Namespace: outcome
	Checksum: 0x3DE4E931
	Offset: 0x4D0
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function function_3624d032(outcome)
{
	return outcome.var_c1e98979;
}

/*
	Name: get_winning_team
	Namespace: outcome
	Checksum: 0x1689D40A
	Offset: 0x4F0
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function get_winning_team(outcome)
{
	if(isdefined(outcome.team))
	{
		return outcome.team;
	}
	if(outcome.players.size)
	{
		return outcome.players[0].team;
	}
	return #"free";
}

/*
	Name: function_b5f4c9d8
	Namespace: outcome
	Checksum: 0x4A0F43ED
	Offset: 0x558
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function function_b5f4c9d8(outcome)
{
	if(outcome.players.size)
	{
		return outcome.players[0];
	}
	return undefined;
}

/*
	Name: function_9b24638f
	Namespace: outcome
	Checksum: 0xC3977A02
	Offset: 0x590
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_9b24638f(outcome)
{
	if(isdefined(outcome.team))
	{
		return outcome.team;
	}
	if(outcome.players.size)
	{
		return outcome.players[0];
	}
	return undefined;
}

/*
	Name: function_d30d1a2e
	Namespace: outcome
	Checksum: 0x2C5F1C5C
	Offset: 0x5E8
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function function_d30d1a2e(outcome)
{
	return outcome.platoon;
}

/*
	Name: function_d1e740f6
	Namespace: outcome
	Checksum: 0x357C5877
	Offset: 0x608
	Size: 0x82
	Parameters: 2
	Flags: Linked
*/
function function_d1e740f6(outcome, team_or_player)
{
	if(!isdefined(team_or_player))
	{
		return;
	}
	if(isplayer(team_or_player))
	{
		outcome.players[outcome.players.size] = team_or_player;
		outcome.team = team_or_player.team;
	}
	else
	{
		outcome.team = team_or_player;
	}
}

/*
	Name: function_35702443
	Namespace: outcome
	Checksum: 0xC3015C6E
	Offset: 0x698
	Size: 0x2E
	Parameters: 2
	Flags: Linked
*/
function function_35702443(outcome, platoon)
{
	if(!isdefined(platoon))
	{
		return;
	}
	outcome.platoon = platoon;
}

/*
	Name: function_af2e264f
	Namespace: outcome
	Checksum: 0xFB4D15DC
	Offset: 0x6D0
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_af2e264f(outcome, winner)
{
	if(isdefined(winner))
	{
		function_d1e740f6(outcome, winner);
	}
	else
	{
		set_flag(outcome, "tie");
	}
}

/*
	Name: function_6d0354e3
	Namespace: outcome
	Checksum: 0xD21C0486
	Offset: 0x730
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_6d0354e3()
{
	if(level.teambased)
	{
		winner = globallogic::determineteamwinnerbygamestat("teamScores");
	}
	else
	{
		winner = globallogic_score::gethighestscoringplayer();
	}
	return winner;
}

/*
	Name: function_870759fb
	Namespace: outcome
	Checksum: 0x3DCDB9ED
	Offset: 0x790
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_870759fb(outcome)
{
	winner = function_6d0354e3();
	function_af2e264f(outcome, winner);
}

