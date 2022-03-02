// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\outcome.gsc;
#using scripts\mp_common\gametypes\overtime.gsc;
#using scripts\mp_common\gametypes\round.gsc;

#namespace match;

/*
	Name: function_89f2df9
	Namespace: match
	Checksum: 0xAC2250AA
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"match", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: match
	Checksum: 0x65A0A06D
	Offset: 0x110
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_94003d29();
}

/*
	Name: function_37f04b09
	Namespace: match
	Checksum: 0x805949B
	Offset: 0x130
	Size: 0x42
	Parameters: 0
	Flags: Linked, Private
*/
function private function_37f04b09()
{
	if(!isdefined(game.outcome))
	{
		game.outcome = outcome::function_a1a81955();
		game.outcome.var_3c5fdf73 = [];
	}
}

/*
	Name: function_94003d29
	Namespace: match
	Checksum: 0x275D83B5
	Offset: 0x180
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_94003d29()
{
	function_37f04b09();
	round::function_37f04b09();
	if(overtime::is_overtime_round())
	{
		function_1362c7e0();
	}
}

/*
	Name: function_f37f02fc
	Namespace: match
	Checksum: 0x40E2C6F1
	Offset: 0x1D8
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function function_f37f02fc()
{
	return game.outcome;
}

/*
	Name: function_b6b94df8
	Namespace: match
	Checksum: 0x2404EC13
	Offset: 0x1F0
	Size: 0x2C
	Parameters: 0
	Flags: Private
*/
function private function_b6b94df8()
{
	if(overtime::is_overtime_round())
	{
		function_1362c7e0();
	}
}

/*
	Name: function_1362c7e0
	Namespace: match
	Checksum: 0x3163C761
	Offset: 0x228
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_1362c7e0()
{
	round::set_flag("overtime");
	set_flag("overtime");
}

/*
	Name: set_flag
	Namespace: match
	Checksum: 0x1CF40C0A
	Offset: 0x268
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function set_flag(flag)
{
	outcome::set_flag(game.outcome, flag);
}

/*
	Name: function_5f24faac
	Namespace: match
	Checksum: 0x9FBA52B9
	Offset: 0x2A0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_5f24faac(flag)
{
	return outcome::function_5f24faac(game.outcome, flag);
}

/*
	Name: function_46cb766c
	Namespace: match
	Checksum: 0x74B29B9B
	Offset: 0x2D8
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function function_46cb766c(flag)
{
	return outcome::function_46cb766c(game.outcome, flag);
}

/*
	Name: function_897438f4
	Namespace: match
	Checksum: 0xFB6355E9
	Offset: 0x310
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_897438f4(var_c1e98979)
{
	outcome::function_897438f4(game.outcome, var_c1e98979);
}

/*
	Name: function_3624d032
	Namespace: match
	Checksum: 0x93282F88
	Offset: 0x348
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_3624d032()
{
	return outcome::function_3624d032(game.outcome);
}

/*
	Name: function_c10174e7
	Namespace: match
	Checksum: 0xA33DDDFE
	Offset: 0x370
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_c10174e7()
{
	if(isdefined(game.outcome.team) && isdefined(level.teams[game.outcome.team]))
	{
		return true;
	}
	if(game.outcome.players.size)
	{
		return true;
	}
	return false;
}

/*
	Name: get_winning_team
	Namespace: match
	Checksum: 0x1AD56F2E
	Offset: 0x3E0
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function get_winning_team()
{
	return outcome::get_winning_team(game.outcome);
}

/*
	Name: function_ebd67076
	Namespace: match
	Checksum: 0x99F509C5
	Offset: 0x408
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function function_ebd67076(team)
{
	if(isdefined(game.outcome.team) && team == game.outcome.team)
	{
		return true;
	}
	return false;
}

/*
	Name: function_a2b53e17
	Namespace: match
	Checksum: 0xADB23937
	Offset: 0x460
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_a2b53e17(player)
{
	if(game.outcome.platoon !== #"none" && function_22448d6c(player.pers[#"team"]) === game.outcome.platoon)
	{
		return true;
	}
	if(game.outcome.team !== #"free" && player.pers[#"team"] === game.outcome.team)
	{
		return true;
	}
	if(game.outcome.players.size)
	{
		if(player == game.outcome.players[0])
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_75f97ac7
	Namespace: match
	Checksum: 0x1709A958
	Offset: 0x588
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_75f97ac7()
{
	if(game.outcome.players.size)
	{
		return true;
	}
	return false;
}

/*
	Name: function_517c0ce0
	Namespace: match
	Checksum: 0x86DF0DD8
	Offset: 0x5B8
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_517c0ce0()
{
	if(game.outcome.players.size)
	{
		return game.outcome.players[0] ishost();
	}
	return 0;
}

/*
	Name: function_b5f4c9d8
	Namespace: match
	Checksum: 0x5D61177B
	Offset: 0x608
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function function_b5f4c9d8()
{
	return outcome::function_b5f4c9d8(game.outcome);
}

/*
	Name: function_9b24638f
	Namespace: match
	Checksum: 0x2320205A
	Offset: 0x630
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_9b24638f()
{
	if(isdefined(level.teambased) && level.teambased)
	{
		return outcome::get_winning_team(game.outcome);
	}
	return outcome::function_b5f4c9d8(game.outcome);
}

/*
	Name: function_d1e740f6
	Namespace: match
	Checksum: 0xD1B4FE22
	Offset: 0x690
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_d1e740f6(var_512330f1)
{
	outcome::function_d1e740f6(game.outcome, var_512330f1);
}

/*
	Name: function_af2e264f
	Namespace: match
	Checksum: 0x321224B0
	Offset: 0x6C8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_af2e264f(winner)
{
	outcome::function_af2e264f(game.outcome, winner);
}

/*
	Name: function_870759fb
	Namespace: match
	Checksum: 0xCC928E45
	Offset: 0x700
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_870759fb()
{
	winner = function_6d0354e3();
	outcome::function_af2e264f(game.outcome, winner);
}

/*
	Name: function_35702443
	Namespace: match
	Checksum: 0xBD9C1A11
	Offset: 0x748
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_35702443(platoon)
{
	outcome::function_35702443(game.outcome, platoon);
}

/*
	Name: function_d30d1a2e
	Namespace: match
	Checksum: 0xD9B9A02E
	Offset: 0x780
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function function_d30d1a2e()
{
	return outcome::function_d30d1a2e(game.outcome);
}

/*
	Name: function_6d0354e3
	Namespace: match
	Checksum: 0x64B3F478
	Offset: 0x7A8
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function function_6d0354e3()
{
	winner = round::function_9b24638f();
	if(game.outcome.var_aefc8b8d.var_c1e98979 != 7)
	{
		if(level.teambased && function_5f24faac("overtime"))
		{
			if(!(isdefined(level.doubleovertime) && level.doubleovertime) || round::function_5f24faac("tie"))
			{
				winner = globallogic::determineteamwinnerbygamestat("overtimeroundswon");
			}
		}
		else
		{
			if(level.scoreroundwinbased)
			{
				winner = globallogic::determineteamwinnerbygamestat("roundswon");
			}
			else
			{
				winner = globallogic::determineteamwinnerbyteamscore();
			}
		}
	}
	return winner;
}

