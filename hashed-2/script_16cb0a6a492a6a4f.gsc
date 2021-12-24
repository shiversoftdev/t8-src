// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1f2f7ef27f2aabba;
#using script_2255a7ad3edc838f;
#using script_3f9e54c7a9a7e1e2;
#using script_75be2950b381443;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\teams.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace teams;

/*
	Name: function_89f2df9
	Namespace: teams
	Checksum: 0xE5A3A656
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_29ee595d6bf61bf4", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: teams
	Checksum: 0xD2D54E10
	Offset: 0x118
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.var_a3e209ba))
	{
		level.var_a3e209ba = &function_321f8eb5;
	}
	/#
		level.var_ba13fb7a = getdvarint(#"hash_40fe9055da22add4", 0);
	#/
}

/*
	Name: function_ab5e18bb
	Namespace: teams
	Checksum: 0xCA40355
	Offset: 0x180
	Size: 0x26
	Parameters: 0
	Flags: None
*/
function function_ab5e18bb()
{
	teamname = getassignedteamname(self);
}

/*
	Name: function_2ba5e3e6
	Namespace: teams
	Checksum: 0x977ED33D
	Offset: 0x1B0
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function function_2ba5e3e6()
{
	var_ac46c774 = util::gethostplayerforbots();
	if(isdefined(var_ac46c774))
	{
		return var_ac46c774.team;
	}
	return "";
}

/*
	Name: function_582e5d7c
	Namespace: teams
	Checksum: 0x7538FF91
	Offset: 0x1F8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_582e5d7c()
{
	return isbot(self) && isdefined(self.botteam) && self.botteam != "autoassign" && (level.maxteamplayers == 0 || getplayers(self.botteam).size < level.maxteamplayers);
}

/*
	Name: function_ee150fcc
	Namespace: teams
	Checksum: 0x77CFAAE6
	Offset: 0x280
	Size: 0x1F0
	Parameters: 2
	Flags: Linked
*/
function function_ee150fcc(team, team_players)
{
	var_ab9e77bf = [];
	/#
		var_f8896168 = getdvarint(#"hash_4cbf229ab691d987", 0);
	#/
	foreach(player in team_players)
	{
		party = player function_491311f4();
		/#
			assert(party.var_a15e4438 <= level.maxteamplayers);
		#/
		var_ab9e77bf[party.party_id] = (party.fill ? party.var_a15e4438 : level.maxteamplayers);
		/#
			if(var_f8896168)
			{
				var_ab9e77bf[party.party_id] = party.var_a15e4438;
			}
		#/
	}
	var_6195506c = 0;
	foreach(count in var_ab9e77bf)
	{
		var_6195506c = var_6195506c + count;
	}
	return level.maxteamplayers - var_6195506c;
}

/*
	Name: function_f18da875
	Namespace: teams
	Checksum: 0xF868C3FD
	Offset: 0x478
	Size: 0x9E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_f18da875(platoon, player_counts)
{
	foreach(test_platoon, count in player_counts)
	{
		if(test_platoon != platoon && count >= player_counts[platoon])
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_efe5a681
	Namespace: teams
	Checksum: 0xC06027AE
	Offset: 0x520
	Size: 0x252
	Parameters: 1
	Flags: Linked
*/
function function_efe5a681(team)
{
	team_players = getplayers(team);
	if(team_players.size >= level.maxteamplayers)
	{
		return 0;
	}
	if(getdvarint(#"hash_aecb27a63d1fcee", 0) == 0)
	{
		if(platoons::function_382a49e0())
		{
			platoon = function_22448d6c(team);
			if(platoon != #"invalid" && platoon != #"none")
			{
				player_counts = platoons::count_players();
				if(player_counts[platoon] >= level.platoon.max_players)
				{
					return 0;
				}
				if(getdvarint(#"hash_52e8746b313ada90", 0) == 0)
				{
					if(function_f18da875(platoon, player_counts))
					{
						return 0;
					}
				}
			}
		}
	}
	var_fa810454 = function_ee150fcc(team, team_players);
	party = self function_491311f4();
	if(party.var_a15e4438 > var_fa810454)
	{
		return 0;
	}
	/#
		if(getdvarint(#"hash_2ffea48b89a9ff3f", 0) && self != getplayers()[0] && getplayers()[0].team == team && !isbot(self))
		{
			return 0;
		}
	#/
	return 1;
}

/*
	Name: function_ccb3bc7a
	Namespace: teams
	Checksum: 0xD59DB7A2
	Offset: 0x780
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function function_ccb3bc7a()
{
	foreach(team in level.teams)
	{
		if(self function_efe5a681(team))
		{
			/#
				println(((((("" + "") + self.name) + "") + team) + "") + getplayers(team).size);
			#/
			/#
				function_d28f6fa0(team);
			#/
			return team;
		}
	}
	return #"spectator";
}

/*
	Name: function_b919f6aa
	Namespace: teams
	Checksum: 0x50A7D55B
	Offset: 0x898
	Size: 0x1A2
	Parameters: 1
	Flags: Linked
*/
function function_b919f6aa(status)
{
	foreach(team in level.teams)
	{
		if(status == #"game")
		{
			if(isdefined(level.var_75dffa9f[team]) && level.var_75dffa9f[team] != #"game")
			{
				continue;
			}
		}
		else if(isdefined(level.var_75dffa9f[team]) && level.var_75dffa9f[team] == #"game")
		{
			continue;
		}
		if(self function_efe5a681(team))
		{
			/#
				println(((((("" + "") + self.name) + "") + team) + "") + getplayers(team).size);
			#/
			/#
				function_d28f6fa0(team);
			#/
			return team;
		}
	}
	return #"spectator";
}

/*
	Name: function_5c389625
	Namespace: teams
	Checksum: 0xEE5040E8
	Offset: 0xA48
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function function_5c389625()
{
	status = self function_3d288f14();
	assignment = self function_b919f6aa(status);
	if(!isdefined(assignment) || assignment == #"spectator")
	{
		assignment = function_959bac94();
	}
	if(!isdefined(assignment))
	{
		assignment = function_ccb3bc7a();
	}
	return assignment;
}

/*
	Name: function_5d02dd86
	Namespace: teams
	Checksum: 0xDCF23D6C
	Offset: 0xAF8
	Size: 0x192
	Parameters: 1
	Flags: Linked
*/
function function_5d02dd86(party)
{
	foreach(member in party.var_d77ed5eb)
	{
		if(self == member)
		{
			continue;
		}
		if(member.team != "autoassign" && member.team != "spectate")
		{
			team_players = getplayers(member.team);
			if(team_players.size >= level.maxteamplayers)
			{
				break;
			}
			/#
				println(((((("" + "") + self.name) + "") + member.team) + "") + member.name);
			#/
			/#
				function_d28f6fa0(member.team);
			#/
			return member.team;
		}
	}
	return function_868b679c(party);
}

/*
	Name: function_650d105d
	Namespace: teams
	Checksum: 0xBE4633C5
	Offset: 0xC98
	Size: 0x160
	Parameters: 0
	Flags: Linked, Private
*/
private function function_650d105d()
{
	if(function_582e5d7c())
	{
		return self.botteam;
	}
	teamkeys = getarraykeys(level.teams);
	assignment = teamkeys[randomint(teamkeys.size)];
	playercounts = self count_players();
	if(teamplayercountsequal(playercounts))
	{
		if(!level.splitscreen && self issplitscreen())
		{
			assignment = self get_splitscreen_team();
			if(assignment == "")
			{
				assignment = pickteamfromscores(teamkeys);
			}
		}
		else
		{
			assignment = pickteamfromscores(teamkeys);
		}
	}
	else
	{
		assignment = function_d078493a(playercounts);
	}
	/#
		assert(isdefined(assignment));
	#/
	return assignment;
}

/*
	Name: function_75daeb56
	Namespace: teams
	Checksum: 0x9BA03E0C
	Offset: 0xE00
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_75daeb56(party)
{
	/#
		var_f8896168 = getdvarint(#"hash_4cbf229ab691d987", 0);
		if(var_f8896168 && (var_f8896168 != 2 || self ishost()))
		{
			return 0;
		}
	#/
	if(isdefined(party) && party.fill == 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_868b679c
	Namespace: teams
	Checksum: 0xF7163858
	Offset: 0xEA8
	Size: 0xA2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_868b679c(party)
{
	if(function_75daeb56(party))
	{
		assignment = function_959bac94();
	}
	else if(getdvarint(#"hash_587d8e03df4f4f8a", 0))
	{
		assignment = function_ccb3bc7a();
	}
	else
	{
		assignment = self function_5c389625();
	}
	return assignment;
}

/*
	Name: function_1e545bc7
	Namespace: teams
	Checksum: 0xF4DFEE82
	Offset: 0xF58
	Size: 0x8A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1e545bc7()
{
	if(function_582e5d7c())
	{
		return self.botteam;
	}
	party = self function_491311f4();
	if(isdefined(party) && party.var_a15e4438 > 1)
	{
		return function_5d02dd86(party);
	}
	return function_868b679c(party);
}

/*
	Name: function_bec6e9a
	Namespace: teams
	Checksum: 0xD8105499
	Offset: 0xFF0
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_bec6e9a()
{
	if(level.multiteam && level.maxteamplayers > 0)
	{
		return function_1e545bc7();
	}
	return function_650d105d();
}

/*
	Name: function_b55ab4b3
	Namespace: teams
	Checksum: 0xE2CB15F
	Offset: 0x1040
	Size: 0x100
	Parameters: 2
	Flags: Linked
*/
function function_b55ab4b3(comingfrommenu, var_4c542e39)
{
	if(!comingfrommenu && var_4c542e39 === "spectator")
	{
		return var_4c542e39;
	}
	clientnum = self getentitynumber();
	count = 0;
	foreach(team, _ in level.teams)
	{
		if(team == "free")
		{
			continue;
		}
		count++;
		if(count == (clientnum + 1))
		{
			return team;
		}
	}
	return var_4c542e39;
}

/*
	Name: function_d22a4fbb
	Namespace: teams
	Checksum: 0x3B616FAD
	Offset: 0x1148
	Size: 0x118
	Parameters: 2
	Flags: Linked
*/
function function_d22a4fbb(comingfrommenu, var_4c542e39)
{
	if(!isdefined(var_4c542e39))
	{
		teamname = getassignedteamname(self);
	}
	else
	{
		teamname = var_4c542e39;
	}
	if(teamname !== "free" && !comingfrommenu)
	{
		assignment = teamname;
	}
	else if(function_a3e209ba(teamname, comingfrommenu))
	{
		assignment = #"spectator";
	}
	else if(isdefined(level.var_34e67a68) && !isbot(self))
	{
		assignment = level.var_34e67a68;
	}
	else
	{
		assignment = function_bec6e9a();
		/#
			assert(isdefined(assignment));
		#/
	}
	return assignment;
}

/*
	Name: teamscoresequal
	Namespace: teams
	Checksum: 0x29FE3A28
	Offset: 0x1268
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function teamscoresequal()
{
	score = undefined;
	foreach(team, _ in level.teams)
	{
		if(!isdefined(score))
		{
			score = getteamscore(team);
			continue;
		}
		if(score != getteamscore(team))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: teamwithlowestscore
	Namespace: teams
	Checksum: 0xEF63B29B
	Offset: 0x1330
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function teamwithlowestscore()
{
	score = 99999999;
	lowest_team = undefined;
	foreach(team, _ in level.teams)
	{
		if(score > getteamscore(team))
		{
			lowest_team = team;
		}
	}
	return lowest_team;
}

/*
	Name: pickteamfromscores
	Namespace: teams
	Checksum: 0x8DCDF1EC
	Offset: 0x13E8
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function pickteamfromscores(teams)
{
	assignment = #"allies";
	if(teamscoresequal())
	{
		assignment = teams[randomint(teams.size)];
	}
	else
	{
		assignment = teamwithlowestscore();
	}
	return assignment;
}

/*
	Name: get_splitscreen_team
	Namespace: teams
	Checksum: 0xDA7509BF
	Offset: 0x1470
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function get_splitscreen_team()
{
	for(index = 0; index < level.players.size; index++)
	{
		if(!isdefined(level.players[index]))
		{
			continue;
		}
		if(level.players[index] == self)
		{
			continue;
		}
		if(!self isplayeronsamemachine(level.players[index]))
		{
			continue;
		}
		team = level.players[index].sessionteam;
		if(team != #"spectator")
		{
			return team;
		}
	}
	return "";
}

/*
	Name: teamplayercountsequal
	Namespace: teams
	Checksum: 0x2FB31E47
	Offset: 0x1548
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function teamplayercountsequal(playercounts)
{
	count = undefined;
	foreach(team, _ in level.teams)
	{
		if(!isdefined(count))
		{
			count = playercounts[team];
			continue;
		}
		if(count != playercounts[team])
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_d078493a
	Namespace: teams
	Checksum: 0xB4F84A34
	Offset: 0x1608
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_d078493a(playercounts)
{
	count = 9999;
	lowest_team = undefined;
	foreach(team, _ in level.teams)
	{
		if(count > playercounts[team])
		{
			count = playercounts[team];
			lowest_team = team;
		}
	}
	return lowest_team;
}

/*
	Name: function_321f8eb5
	Namespace: teams
	Checksum: 0xAB1A81D6
	Offset: 0x16C8
	Size: 0x10
	Parameters: 1
	Flags: Linked
*/
function function_321f8eb5(player)
{
	return 1;
}

/*
	Name: function_a3e209ba
	Namespace: teams
	Checksum: 0x146D3A0C
	Offset: 0x16E0
	Size: 0xCE
	Parameters: 2
	Flags: Linked
*/
function function_a3e209ba(teamname, comingfrommenu)
{
	if(level.rankedmatch)
	{
		return 0;
	}
	if(level.inprematchperiod)
	{
		return 0;
	}
	if(teamname != "free")
	{
		return 0;
	}
	if(comingfrommenu)
	{
		return 0;
	}
	if(self ishost())
	{
		return 0;
	}
	if(level.forceautoassign)
	{
		return 0;
	}
	if(isbot(self))
	{
		return 0;
	}
	if(self issplitscreen())
	{
		return 0;
	}
	if(![[level.var_a3e209ba]]())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_7d93567f
	Namespace: teams
	Checksum: 0x5129EEE
	Offset: 0x17B8
	Size: 0x1FE
	Parameters: 0
	Flags: Linked
*/
function function_7d93567f()
{
	players = level.players;
	distribution = [];
	foreach(player in level.players)
	{
		team = player.pers[#"team"];
		if(!isdefined(level.teams[team]))
		{
			continue;
		}
		platoon = function_22448d6c(team);
		if(platoon == #"invalid")
		{
			continue;
		}
		if(!isdefined(distribution[platoon]))
		{
			distribution[platoon] = [];
		}
		if(!isdefined(distribution[platoon][team]))
		{
			distribution[platoon][team] = [];
		}
		if(!isdefined(distribution[platoon][team]))
		{
			distribution[platoon][team] = [];
		}
		else if(!isarray(distribution[platoon][team]))
		{
			distribution[platoon][team] = array(distribution[platoon][team]);
		}
		distribution[platoon][team][distribution[platoon][team].size] = player;
	}
	return distribution;
}

/*
	Name: function_94478182
	Namespace: teams
	Checksum: 0x1C3BF5CA
	Offset: 0x19C0
	Size: 0x282
	Parameters: 1
	Flags: Linked, Private
*/
private function function_94478182(distribution)
{
	var_dd3d17c1 = [];
	foreach(platoon, var_3c12db95 in distribution)
	{
		if(!isdefined(var_dd3d17c1[platoon]))
		{
			var_dd3d17c1[platoon] = [];
		}
		for(i = 1; i < level.maxteamplayers; i++)
		{
			var_dd3d17c1[platoon][i] = [];
		}
	}
	foreach(platoon, var_3c12db95 in distribution)
	{
		if(!isdefined(var_dd3d17c1[platoon]))
		{
			var_dd3d17c1[platoon] = [];
		}
		foreach(team, team_players in var_3c12db95)
		{
			if(team_players.size < level.maxteamplayers)
			{
				var_a787dfe7 = function_ee150fcc(team, team_players);
				if(var_a787dfe7 > 0)
				{
					if(!isdefined(var_dd3d17c1[platoon][var_a787dfe7]))
					{
						var_dd3d17c1[platoon][var_a787dfe7] = [];
					}
					else if(!isarray(var_dd3d17c1[platoon][var_a787dfe7]))
					{
						var_dd3d17c1[platoon][var_a787dfe7] = array(var_dd3d17c1[platoon][var_a787dfe7]);
					}
					var_dd3d17c1[platoon][var_a787dfe7][var_dd3d17c1[platoon][var_a787dfe7].size] = team;
				}
			}
		}
	}
	return var_dd3d17c1;
}

/*
	Name: function_b25f48bf
	Namespace: teams
	Checksum: 0x6762AE89
	Offset: 0x1C50
	Size: 0x13E
	Parameters: 4
	Flags: Linked
*/
function function_b25f48bf(var_dfb0e355, var_a9ab69de, var_d9438b7, var_ed0a1ecc)
{
	foreach(var_a787dfe7, var_75aa1f3c in var_ed0a1ecc)
	{
		if(level.maxteamplayers - var_a787dfe7 > var_a9ab69de)
		{
			continue;
		}
		if(var_75aa1f3c.size == 0)
		{
			continue;
		}
		foreach(team in var_75aa1f3c)
		{
			if(team == #"none")
			{
				continue;
			}
			if(team == var_dfb0e355)
			{
				continue;
			}
			return team;
		}
	}
	return undefined;
}

/*
	Name: function_78db0e06
	Namespace: teams
	Checksum: 0xA2FCC0E7
	Offset: 0x1D98
	Size: 0xB6
	Parameters: 2
	Flags: Linked, Private
*/
private function function_78db0e06(var_659f7dc3, var_5002c793)
{
	players = getplayers(var_659f7dc3);
	foreach(player in players)
	{
		player function_dc7eaabd(var_5002c793);
	}
	return players.size;
}

/*
	Name: function_a9822793
	Namespace: teams
	Checksum: 0x836F07DE
	Offset: 0x1E58
	Size: 0x4B4
	Parameters: 0
	Flags: None
*/
function function_a9822793()
{
	if(getdvarint(#"hash_761d80face4c4459", 0))
	{
		return;
	}
	distribution = function_7d93567f();
	var_ed0a1ecc = function_94478182(distribution);
	/#
		if(level.var_ba13fb7a)
		{
			println("" + "");
			function_a9bfa6d6();
			println("" + "");
		}
	#/
	foreach(platoon, var_3c12db95 in var_ed0a1ecc)
	{
		/#
			println("" + platoon);
		#/
		foreach(var_a787dfe7, var_75aa1f3c in var_3c12db95)
		{
			foreach(index, team in var_75aa1f3c)
			{
				if(team == #"none")
				{
					continue;
				}
				current_count = level.maxteamplayers - var_a787dfe7;
				while(current_count < level.maxteamplayers)
				{
					var_6f782d8f = function_b25f48bf(team, var_a787dfe7, distribution[platoon], var_ed0a1ecc[platoon]);
					if(!isdefined(var_6f782d8f))
					{
						break;
					}
					/#
						assert((getplayers(team).size + getplayers(var_6f782d8f).size) <= level.maxteamplayers);
					#/
					/#
						println("" + var_ed0a1ecc[platoon].size);
					#/
					foreach(var_aacd04cb in var_ed0a1ecc[platoon])
					{
						/#
							println("" + var_aacd04cb.size);
						#/
						foreach(remove_index, var_adeea4a7 in var_aacd04cb)
						{
							if(var_adeea4a7 == var_6f782d8f)
							{
								var_aacd04cb[remove_index] = #"none";
							}
						}
					}
					current_count = current_count + function_78db0e06(var_6f782d8f, team);
				}
				var_75aa1f3c[index] = #"none";
			}
		}
	}
	/#
		if(level.var_ba13fb7a)
		{
			println("" + "");
			function_a9bfa6d6();
		}
	#/
}

/*
	Name: function_a9bfa6d6
	Namespace: teams
	Checksum: 0xF376EF59
	Offset: 0x2318
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
private function function_a9bfa6d6()
{
	/#
		if(level.var_ba13fb7a)
		{
			foreach(team in level.teams)
			{
				self thread function_6c66cc64(team);
			}
		}
	#/
}

/*
	Name: function_6c66cc64
	Namespace: teams
	Checksum: 0x8A993584
	Offset: 0x23B0
	Size: 0x2F0
	Parameters: 1
	Flags: Private
*/
private function function_6c66cc64(team)
{
	/#
		players = getplayers(team);
		if(players.size == 0)
		{
			return;
		}
		var_54e8d52e = string(team);
		if(isdefined(level.teams[team]))
		{
			var_54e8d52e = level.teams[team];
		}
		voip = "";
		if(isdefined(level.var_75dffa9f[team]))
		{
			voip = voip + (level.var_75dffa9f[team] == #"game" ? "" : "");
		}
		else
		{
			voip = voip + "";
		}
		platoon = function_22448d6c(team);
		platoon_name = "";
		if(platoon == #"invalid")
		{
			platoon_name = platoon_name + "";
		}
		else if(platoon == #"none")
		{
			platoon_name = platoon_name + "";
		}
		else if(isdefined(level.platoons[platoon]))
		{
			platoon_name = platoon_name + level.platoons[platoon].name;
		}
		println(((((("" + "") + platoon_name) + "") + var_54e8d52e) + "") + voip);
		foreach(player in players)
		{
			party = player function_491311f4();
			println((((("" + "") + player.name) + "") + (party.fill ? "" : "") + "") + party.var_a15e4438);
		}
	#/
}

/*
	Name: function_58b6d2c9
	Namespace: teams
	Checksum: 0x36811E5F
	Offset: 0x26A8
	Size: 0x40C
	Parameters: 0
	Flags: None
*/
function function_58b6d2c9()
{
	/#
		if(level.multiteam && level.maxteamplayers > 0)
		{
			players = getplayers();
			foreach(team in level.teams)
			{
				var_dcbb8617 = getplayers(team);
				if(var_dcbb8617.size > level.maxteamplayers)
				{
					var_f554d31e = "";
					foreach(player in var_dcbb8617)
					{
						party = player function_491311f4();
						var_f554d31e = (((var_f554d31e + player.name) + "") + party.party_id) + "";
					}
					/#
						assertmsg(((((((("" + self.name) + "") + (function_7a600918(team) ? function_9e72a96(team) : team) + "") + var_dcbb8617.size) + "") + level.maxteamplayers) + "") + var_f554d31e);
					#/
				}
			}
			if(!level.custommatch)
			{
				foreach(player in players)
				{
					if(player.team == #"spectator")
					{
						continue;
					}
					party = player function_491311f4();
					foreach(var_52ec371a in party.var_d77ed5eb)
					{
						if(var_52ec371a.team == #"spectator")
						{
							continue;
						}
						if(var_52ec371a.team != player.team)
						{
							/#
								assertmsg(((((("" + player.name) + "") + function_9e72a96(player.team) + "") + var_52ec371a.name) + "") + function_9e72a96(var_52ec371a.team) + "");
							#/
						}
					}
				}
			}
		}
	#/
}

/*
	Name: function_1aa0418f
	Namespace: teams
	Checksum: 0xCE461EE0
	Offset: 0x2AC0
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function function_1aa0418f()
{
	/#
		while(true)
		{
			wait(3);
			players = getplayers();
			if(players.size > 0 && players[0] isstreamerready())
			{
				setdvar(#"devgui_bot", "");
				wait(3);
				function_a9822793();
				wait(1);
				bots = bot::get_bots();
				foreach(bot in bots)
				{
					level thread bot::remove_bot(bot);
				}
			}
		}
	#/
}

