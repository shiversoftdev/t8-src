// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace spectating;

/*
	Name: __init__system__
	Namespace: spectating
	Checksum: 0x61E01D0E
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"spectating", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: spectating
	Checksum: 0xFD8DBA83
	Offset: 0xF8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
	callback::on_spawned(&set_permissions);
	callback::on_joined_team(&set_permissions_for_machine);
	callback::on_joined_spectate(&set_permissions_for_machine);
	callback::on_player_killed_with_params(&on_player_killed);
}

/*
	Name: init
	Namespace: spectating
	Checksum: 0xAE94B03
	Offset: 0x1A8
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function init()
{
	foreach(team, _ in level.teams)
	{
		level.spectateoverride[team] = spawnstruct();
	}
}

/*
	Name: update_settings
	Namespace: spectating
	Checksum: 0xB4D83C32
	Offset: 0x240
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function update_settings()
{
	level endon(#"game_ended");
	foreach(player in level.players)
	{
		player set_permissions();
	}
}

/*
	Name: get_splitscreen_team
	Namespace: spectating
	Checksum: 0xDE9052A7
	Offset: 0x2D8
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
	return self.sessionteam;
}

/*
	Name: other_local_player_still_alive
	Namespace: spectating
	Checksum: 0x85705C3D
	Offset: 0x3B0
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function other_local_player_still_alive()
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
		if(isalive(level.players[index]))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: set_permissions
	Namespace: spectating
	Checksum: 0xEA1DCE04
	Offset: 0x470
	Size: 0x56C
	Parameters: 0
	Flags: Linked
*/
function set_permissions()
{
	team = self.sessionteam;
	if(team == #"spectator")
	{
		if(self issplitscreen() && !level.splitscreen)
		{
			team = get_splitscreen_team();
		}
		if(team == #"spectator")
		{
			self.spectatorteam = #"invalid";
			self allowspectateallteams(1);
			self allowspectateteam("freelook", 0);
			self allowspectateteam(#"none", 1);
			self allowspectateteam("localplayers", 1);
			return;
		}
	}
	self allowspectateallteams(0);
	self allowspectateteam("localplayers", 1);
	self allowspectateteam("freelook", 0);
	switch(level.spectatetype)
	{
		case 0:
		{
			self.spectatorteam = #"invalid";
			self allowspectateteam(#"none", 1);
			self allowspectateteam("localplayers", 0);
			break;
		}
		case 3:
		{
			self.spectatorteam = #"invalid";
			if(self issplitscreen() && self other_local_player_still_alive())
			{
				self allowspectateteam(#"none", 0);
				break;
			}
		}
		case 1:
		{
			self.spectatorteam = #"invalid";
			if(!level.teambased)
			{
				self allowspectateallteams(1);
				self allowspectateteam(#"none", 1);
			}
			else
			{
				if(isdefined(team) && isdefined(level.teams[team]))
				{
					self allowspectateteam(team, 1);
					self allowspectateteam(#"none", 0);
				}
				else
				{
					self allowspectateteam(#"none", 0);
				}
			}
			break;
		}
		case 2:
		{
			self.spectatorteam = #"invalid";
			self allowspectateteam(#"none", 1);
			self allowspectateallteams(1);
			foreach(team in level.teams)
			{
				if(self.team == team)
				{
					continue;
				}
				self allowspectateteam(team, 1);
			}
			break;
		}
		case 4:
		{
			return;
		}
	}
	if(isdefined(team) && isdefined(level.teams[team]))
	{
		if(isdefined(level.spectateoverride[team].allowfreespectate))
		{
			self allowspectateteam("freelook", 1);
		}
		if(isdefined(level.spectateoverride[team].allowenemyspectate))
		{
			if(level.spectateoverride[team].allowenemyspectate == #"all")
			{
				self allowspectateallteams(1);
			}
			else
			{
				self allowspectateallteams(0);
				self allowspectateteam(level.spectateoverride[team].allowenemyspectate, 1);
			}
		}
	}
}

/*
	Name: function_4c37bb21
	Namespace: spectating
	Checksum: 0xB29741B
	Offset: 0x9E8
	Size: 0x1EE
	Parameters: 1
	Flags: Linked
*/
function function_4c37bb21(var_2b7584f0)
{
	var_156b3879 = self function_b7c8d984(undefined, 0);
	if(isdefined(var_156b3879) && isplayer(var_156b3879))
	{
		self.spectatorteam = var_156b3879.team;
		if(var_2b7584f0)
		{
			self setcurrentspectatorclient(var_156b3879);
		}
	}
	else
	{
		spectator_team = undefined;
		players = getplayers(self.team);
		foreach(player in players)
		{
			if(player == self)
			{
				continue;
			}
			if(player.spectatorteam != #"invalid")
			{
				spectator_team = player.spectatorteam;
				break;
			}
		}
		if(!isdefined(spectator_team))
		{
			foreach(team, count in level.alivecount)
			{
				if(count > 0)
				{
					self.spectatorteam = team;
					break;
				}
			}
		}
		if(isdefined(spectator_team))
		{
			self.spectatorteam = spectator_team;
		}
	}
}

/*
	Name: set_permissions_for_machine
	Namespace: spectating
	Checksum: 0x9F570BE0
	Offset: 0xBE0
	Size: 0x15E
	Parameters: 0
	Flags: Linked
*/
function set_permissions_for_machine()
{
	if(level.spectatetype == 4 && self.spectatorteam != #"invalid")
	{
		var_c37023cb = 1;
		if(sessionmodeismultiplayergame())
		{
			if(self.sessionstate === "playing")
			{
				var_c37023cb = 0;
			}
		}
		function_4c37bb21(var_c37023cb);
	}
	self set_permissions();
	if(!self issplitscreen())
	{
		return;
	}
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
		level.players[index] set_permissions();
	}
}

/*
	Name: function_7d15f599
	Namespace: spectating
	Checksum: 0x49AAD242
	Offset: 0xD48
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_7d15f599()
{
	livesleft = !(level.numlives && !self.pers[#"lives"]);
	if(!level.alivecount[self.team] && !livesleft)
	{
		return false;
	}
	return true;
}

/*
	Name: function_23c5f4f2
	Namespace: spectating
	Checksum: 0xA03E551B
	Offset: 0xDC0
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_23c5f4f2()
{
	self endon(#"disconnect");
	waitframe(1);
	function_493d2e03(#"all");
}

/*
	Name: function_493d2e03
	Namespace: spectating
	Checksum: 0x4947F2E0
	Offset: 0xE08
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_493d2e03(team)
{
	if(!self function_7d15f599())
	{
		level.spectateoverride[self.team].allowenemyspectate = team;
		update_settings();
	}
}

/*
	Name: function_34460764
	Namespace: spectating
	Checksum: 0x95BF10DD
	Offset: 0xE70
	Size: 0xA8
	Parameters: 1
	Flags: None
*/
function function_34460764(team)
{
	players = getplayers(team);
	foreach(player in players)
	{
		player allowspectateallteams(1);
	}
}

/*
	Name: function_ef775048
	Namespace: spectating
	Checksum: 0xCEF69866
	Offset: 0xF20
	Size: 0xD8
	Parameters: 2
	Flags: None
*/
function function_ef775048(team, var_6f1b46b8)
{
	self endon(#"disconnect");
	waitframe(1);
	if(level.alivecount[team])
	{
		return;
	}
	players = getplayers(team);
	foreach(player in players)
	{
		player function_493d2e03(var_6f1b46b8);
	}
}

/*
	Name: function_18b8b7e4
	Namespace: spectating
	Checksum: 0x62E77089
	Offset: 0x1000
	Size: 0xDE
	Parameters: 2
	Flags: Linked
*/
function function_18b8b7e4(players, origin)
{
	sorted_players = arraysort(players, origin);
	foreach(player in sorted_players)
	{
		if(player == self)
		{
			continue;
		}
		if(!isalive(player))
		{
			continue;
		}
		if(player laststand::player_is_in_laststand())
		{
			continue;
		}
		return player;
	}
	return undefined;
}

/*
	Name: function_7ad5ad8
	Namespace: spectating
	Checksum: 0x864E8E29
	Offset: 0x10E8
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function function_7ad5ad8()
{
	if(self.team == #"spectator")
	{
		return undefined;
	}
	/#
		assert(isdefined(level.aliveplayers[self.team]));
	#/
	teammates = level.aliveplayers[self.team];
	player = function_18b8b7e4(teammates, self.origin);
	if(!isdefined(player) && isdefined(level.var_df67ea13))
	{
		player = self [[level.var_df67ea13]]();
	}
	return player;
}

/*
	Name: function_b7c8d984
	Namespace: spectating
	Checksum: 0x54891B3E
	Offset: 0x11B8
	Size: 0xB2
	Parameters: 2
	Flags: Linked
*/
function function_b7c8d984(attacker, var_1178af52)
{
	if(!isdefined(self) || !isdefined(self.team))
	{
		return undefined;
	}
	teammate = function_7ad5ad8();
	spectate_player = undefined;
	if(var_1178af52 && attacker.team == self.team)
	{
		spectate_player = attacker;
	}
	else
	{
		if(isdefined(teammate))
		{
			spectate_player = teammate;
		}
		else if(var_1178af52)
		{
			spectate_player = attacker;
		}
	}
	return spectate_player;
}

/*
	Name: follow_chain
	Namespace: spectating
	Checksum: 0x2DA0CBF0
	Offset: 0x1278
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function follow_chain(var_41349818)
{
	if(!isdefined(var_41349818))
	{
		return;
	}
	while(isdefined(var_41349818) && var_41349818.spectatorclient != -1)
	{
		var_41349818 = getentbynum(var_41349818.spectatorclient);
	}
	return var_41349818;
}

/*
	Name: function_2b728d67
	Namespace: spectating
	Checksum: 0xDE811140
	Offset: 0x12E0
	Size: 0x16E
	Parameters: 1
	Flags: Linked
*/
function function_2b728d67(attacker)
{
	if(level.spectatetype != 4)
	{
		return;
	}
	var_8447710e = player::figure_out_attacker(attacker);
	var_6407d695 = isdefined(var_8447710e) && isplayer(var_8447710e) && var_8447710e != self && isalive(var_8447710e);
	var_156b3879 = self function_b7c8d984(var_8447710e, var_6407d695);
	if(!isdefined(var_156b3879))
	{
		var_156b3879 = self function_18b8b7e4(level.activeplayers, self.origin);
	}
	var_156b3879 = follow_chain(var_156b3879);
	if(isdefined(var_156b3879) && isplayer(var_156b3879))
	{
		self.spectatorclient = -1;
		self.spectatorteam = var_156b3879.team;
		self setcurrentspectatorclient(var_156b3879);
	}
	else
	{
		self.spectatorteam = self.team;
	}
}

/*
	Name: on_player_killed
	Namespace: spectating
	Checksum: 0xF8802C1
	Offset: 0x1458
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function on_player_killed(params)
{
	if(level.spectatetype == 4)
	{
		self thread function_2b728d67(params.eattacker);
	}
}

