// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e54c7a9a7e1e2;
#using script_75be2950b381443;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\round.gsc;

#namespace platoons;

/*
	Name: function_89f2df9
	Namespace: platoons
	Checksum: 0x34FE4404
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_59488c07ab1c65ad", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: platoons
	Checksum: 0x257039BB
	Offset: 0xF0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&on_start_gametype);
}

/*
	Name: on_start_gametype
	Namespace: platoons
	Checksum: 0x662161EB
	Offset: 0x120
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
function private on_start_gametype()
{
	level callback::add_callback(#"hash_d8880c680eac47a", &function_a929f627);
}

/*
	Name: function_a1d82bd3
	Namespace: platoons
	Checksum: 0x9B7A6F6F
	Offset: 0x160
	Size: 0x36C
	Parameters: 0
	Flags: Linked
*/
function function_a1d82bd3()
{
	if(!function_382a49e0())
	{
		return;
	}
	if(infection::function_74650d7())
	{
		return;
	}
	params = {#hash_42c20e77:[], #hash_1ab40902:[]};
	foreach(var_b6173883, platoon in level.platoons)
	{
		if(platoon.var_9dd75dad == 0)
		{
			continue;
		}
		if(platoon.eliminated > 0)
		{
			continue;
		}
		var_3c12db95 = function_37d3bfcb(var_b6173883);
		var_87a87094 = [];
		foreach(team in var_3c12db95)
		{
			if(teams::function_9dd75dad(team) && level.teameliminated[team] == 0)
			{
				if(!isdefined(var_87a87094))
				{
					var_87a87094 = [];
				}
				else if(!isarray(var_87a87094))
				{
					var_87a87094 = array(var_87a87094);
				}
				var_87a87094[var_87a87094.size] = team;
			}
		}
		if(var_87a87094.size == 0)
		{
			platoon.eliminated = gettime();
			if(!isdefined(params.var_42c20e77))
			{
				params.var_42c20e77 = [];
			}
			else if(!isarray(params.var_42c20e77))
			{
				params.var_42c20e77 = array(params.var_42c20e77);
			}
			params.var_42c20e77[params.var_42c20e77.size] = var_b6173883;
			continue;
		}
		if(!isdefined(params.var_1ab40902))
		{
			params.var_1ab40902 = [];
		}
		else if(!isarray(params.var_1ab40902))
		{
			params.var_1ab40902 = array(params.var_1ab40902);
		}
		params.var_1ab40902[params.var_1ab40902.size] = var_b6173883;
	}
	if(params.var_42c20e77.size > 0)
	{
		level callback::callback(#"hash_d8880c680eac47a", params);
	}
}

/*
	Name: function_a929f627
	Namespace: platoons
	Checksum: 0xD0D7B02F
	Offset: 0x4D8
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_a929f627(params)
{
	if(params.var_1ab40902.size == 0)
	{
		round::set_flag("tie");
		thread globallogic::end_round(6);
	}
	else if(params.var_1ab40902.size == 1)
	{
		round::function_35702443(params.var_1ab40902[0]);
		thread globallogic::end_round(6);
	}
}

/*
	Name: function_cea75f29
	Namespace: platoons
	Checksum: 0x700DCA62
	Offset: 0x590
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function function_cea75f29()
{
	count = 0;
	foreach(platoon, _ in level.platoons)
	{
		if(!is_all_dead(platoon))
		{
			count++;
		}
	}
	return count;
}

/*
	Name: count_players
	Namespace: platoons
	Checksum: 0xAC1340E0
	Offset: 0x630
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function count_players()
{
	player_counts = [];
	foreach(platoon, _ in level.platoons)
	{
		player_counts[platoon] = 0;
	}
	var_6a39bbbd = self teams::count_players();
	foreach(team, _ in var_6a39bbbd)
	{
		platoon = function_22448d6c(team);
		if(!isdefined(level.platoons[platoon]))
		{
			continue;
		}
		player_counts[platoon] = player_counts[platoon] + var_6a39bbbd[team];
	}
	return player_counts;
}

/*
	Name: function_ef7959f0
	Namespace: platoons
	Checksum: 0xDEE98996
	Offset: 0x780
	Size: 0xD4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ef7959f0()
{
	playercounts = self count_players();
	count = 9999;
	var_c15f9be2 = undefined;
	foreach(platoon, _ in level.platoons)
	{
		if(count > playercounts[platoon])
		{
			count = playercounts[platoon];
			var_c15f9be2 = platoon;
		}
	}
	return var_c15f9be2;
}

/*
	Name: function_77ad4730
	Namespace: platoons
	Checksum: 0xA91D84E3
	Offset: 0x860
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function function_77ad4730()
{
	assignment = function_ef7959f0();
	/#
		var_655b66e0 = getdvarstring(#"hash_580a24dce39c44f9", "");
		var_7826a1b3 = strtok(var_655b66e0, "");
		if(var_7826a1b3.size > 0)
		{
			var_51746d07 = var_7826a1b3[self getentitynumber()];
			if(isdefined(var_51746d07) && isdefined(level.platoons[var_51746d07]))
			{
				assignment = hash(var_51746d07);
			}
		}
	#/
	return assignment;
}

/*
	Name: function_4b016b57
	Namespace: platoons
	Checksum: 0xCBC62173
	Offset: 0x958
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_4b016b57()
{
	if(!function_382a49e0() || level.platoon.assignment != 1)
	{
		return;
	}
	team = self.pers[#"team"];
	platoon = function_22448d6c(team);
	if(platoon != #"invalid" && platoon != #"none")
	{
		return;
	}
	assignment = function_77ad4730();
	function_334c4bec(team, assignment);
}

/*
	Name: function_a214d798
	Namespace: platoons
	Checksum: 0x791BF358
	Offset: 0xA40
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function function_a214d798(platoon)
{
	players = [];
	if(platoon == #"none" || platoon == #"invalid")
	{
		return players;
	}
	teams = function_37d3bfcb(platoon);
	foreach(team in teams)
	{
		foreach(player in level.aliveplayers[team])
		{
			if(!isdefined(players))
			{
				players = [];
			}
			else if(!isarray(players))
			{
				players = array(players);
			}
			players[players.size] = player;
		}
	}
	return players;
}

/*
	Name: is_all_dead
	Namespace: platoons
	Checksum: 0x1E368DE4
	Offset: 0xBD8
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function is_all_dead(platoon)
{
	teams = function_37d3bfcb(platoon);
	foreach(team in teams)
	{
		if(!teams::is_all_dead(team))
		{
			return false;
		}
	}
	return true;
}

