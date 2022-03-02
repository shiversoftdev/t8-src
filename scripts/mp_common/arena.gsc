// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\match.gsc;

#namespace arena;

/*
	Name: function_89f2df9
	Namespace: arena
	Checksum: 0x87ECD8BC
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"arena", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: arena
	Checksum: 0x409B928E
	Offset: 0x100
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_connect);
	callback::on_disconnect(&on_disconnect);
	if(gamemodeisarena())
	{
		callback::function_98a0917d(&function_98a0917d);
		level.var_a962eeb6 = &function_51203700;
	}
}

/*
	Name: on_connect
	Namespace: arena
	Checksum: 0x8A582088
	Offset: 0x198
	Size: 0x13E
	Parameters: 0
	Flags: Linked
*/
function on_connect()
{
	if(isdefined(self.pers[#"arenainit"]) && self.pers[#"arenainit"] == 1)
	{
		return;
	}
	draftenabled = getgametypesetting(#"pregamedraftenabled") == 1;
	voteenabled = getgametypesetting(#"pregameitemvoteenabled") == 1;
	if(!draftenabled && !voteenabled)
	{
		self arenabeginmatch();
		if(function_945560bf() == 1)
		{
			self.pers[#"hash_1b5251cc167039c8"] = self function_a200171d();
		}
	}
	self.pers[#"arenainit"] = 1;
}

/*
	Name: function_b856a952
	Namespace: arena
	Checksum: 0x4C2994D2
	Offset: 0x2E0
	Size: 0x1B4
	Parameters: 1
	Flags: Linked
*/
function function_b856a952(team)
{
	if(getdvarint(#"hash_6eb6c222bc98b01", 0))
	{
		penalty = function_377f07c2();
		for(index = 0; index < level.players.size; index++)
		{
			player = level.players[index];
			if(isdefined(player.team) && player.team == team && !isdefined(player.pers[#"hash_6dbbb195b62e0dd3"]))
			{
				if(isdefined(player.pers[#"arenainit"]) && player.pers[#"arenainit"] == 1)
				{
					if(isdefined(player.pers[#"hash_1b5251cc167039c8"]))
					{
						player function_ca53535e(penalty);
						player function_46445a75(player.pers[#"hash_1b5251cc167039c8"]);
						player.pers[#"hash_6dbbb195b62e0dd3"] = 1;
					}
				}
			}
		}
	}
}

/*
	Name: on_disconnect
	Namespace: arena
	Checksum: 0x7A940D94
	Offset: 0x4A0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function on_disconnect()
{
	if(isdefined(self) && isdefined(self.team) && isdefined(level.playercount) && isdefined(level.playercount[self.team]))
	{
		if(!gamestate::is_game_over() && level.playercount[self.team] <= function_7a0dc792())
		{
			function_b856a952(self.team);
		}
	}
}

/*
	Name: update_arena_challenge_seasons
	Namespace: arena
	Checksum: 0x563949CC
	Offset: 0x548
	Size: 0x262
	Parameters: 0
	Flags: None
*/
function update_arena_challenge_seasons()
{
	eventstate = "";
	eventtype = function_945560bf();
	switch(eventtype)
	{
		case 0:
		{
			eventstate = #"hash_ca4c97bc6c2963b";
			break;
		}
		case 1:
		{
			eventstate = #"hash_60f1e9335197f661";
			break;
		}
		case 4:
		{
			eventstate = #"hash_4986c748eb81d3c5";
			break;
		}
		default:
		{
			return;
		}
	}
	perseasonwins = self stats::get_stat(#"arenaperseasonstats", eventstate, #"hash_2f54ed970fcecc95", #"wins");
	if(perseasonwins >= getdvarint(#"arena_seasonvetchallengewins", 0))
	{
		arenaslot = arenagetslot();
		currentseason = self stats::get_stat(#"arenastats", arenaslot, #"season");
		seasonvetchallengearraycount = self getdstatarraycount("arenaChallengeSeasons");
		for(i = 0; i < seasonvetchallengearraycount; i++)
		{
			challengeseason = self stats::get_stat(#"arenachallengeseasons", i);
			if(challengeseason == currentseason)
			{
				return;
			}
			if(challengeseason == 0)
			{
				self stats::set_stat(#"arenachallengeseasons", i, currentseason);
				break;
			}
		}
	}
}

/*
	Name: match_end
	Namespace: arena
	Checksum: 0x7ADFA597
	Offset: 0x7B8
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function match_end()
{
	for(index = 0; index < level.players.size; index++)
	{
		player = level.players[index];
		if(isdefined(player.pers[#"arenainit"]) && player.pers[#"arenainit"] == 1)
		{
			if(match::function_5f24faac("tie"))
			{
				player arenaendmatch(0);
			}
			else
			{
				if(match::function_a2b53e17(player))
				{
					player arenaendmatch(1);
				}
				else
				{
					player arenaendmatch(-1);
				}
			}
			if(isdefined(player.pers[#"hash_1b5251cc167039c8"]))
			{
				player function_46445a75(player.pers[#"hash_1b5251cc167039c8"]);
			}
		}
	}
	if(match::function_5f24faac("tie") || !isdefined(game.outcome.team))
	{
		function_a357a2b8(0);
	}
	else
	{
		if(game.outcome.team == #"allies")
		{
			function_a357a2b8(1);
		}
		else
		{
			function_a357a2b8(-1);
		}
	}
}

/*
	Name: function_51203700
	Namespace: arena
	Checksum: 0xE59D1ACF
	Offset: 0x9C8
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function function_51203700()
{
	return false;
}

/*
	Name: function_98a0917d
	Namespace: arena
	Checksum: 0xE746A95E
	Offset: 0x9D8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function function_98a0917d()
{
	function_e938380b();
}

