// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace spectating;

/*
	Name: __init__system__
	Namespace: spectating
	Checksum: 0x6C0475AC
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_spectating", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: spectating
	Checksum: 0x2DCF9C03
	Offset: 0xF8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&main);
}

/*
	Name: main
	Namespace: spectating
	Checksum: 0x62EF05AF
	Offset: 0x128
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function main()
{
	foreach(team, _ in level.teams)
	{
		level.spectateoverride[team] = spawnstruct();
	}
	callback::on_connecting(&on_player_connecting);
}

/*
	Name: on_player_connecting
	Namespace: spectating
	Checksum: 0xC7D7E727
	Offset: 0x1E0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function on_player_connecting()
{
	callback::on_joined_team(&on_joined_team);
	callback::on_spawned(&on_player_spawned);
	callback::on_joined_spectate(&on_joined_spectate);
}

/*
	Name: on_player_spawned
	Namespace: spectating
	Checksum: 0x854C6884
	Offset: 0x250
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self endon(#"disconnect");
	self setspectatepermissions();
}

/*
	Name: on_joined_team
	Namespace: spectating
	Checksum: 0xAF98A67
	Offset: 0x288
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function on_joined_team(params)
{
	self endon(#"disconnect");
	self setspectatepermissionsformachine();
}

/*
	Name: on_joined_spectate
	Namespace: spectating
	Checksum: 0x1230CCC9
	Offset: 0x2C8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function on_joined_spectate(params)
{
	self endon(#"disconnect");
	self setspectatepermissionsformachine();
}

/*
	Name: updatespectatesettings
	Namespace: spectating
	Checksum: 0x95DFC1F3
	Offset: 0x308
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function updatespectatesettings()
{
	level endon(#"game_ended");
	for(index = 0; index < level.players.size; index++)
	{
		level.players[index] setspectatepermissions();
	}
}

/*
	Name: getsplitscreenteam
	Namespace: spectating
	Checksum: 0x6A0BE8CE
	Offset: 0x378
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function getsplitscreenteam()
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
		if(team != "spectator")
		{
			return team;
		}
	}
	return self.sessionteam;
}

/*
	Name: otherlocalplayerstillalive
	Namespace: spectating
	Checksum: 0x278D5889
	Offset: 0x450
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function otherlocalplayerstillalive()
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
	Name: allowspectateallteams
	Namespace: spectating
	Checksum: 0xACDD95B1
	Offset: 0x510
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function allowspectateallteams(allow)
{
	foreach(team, _ in level.teams)
	{
		self allowspectateteam(team, allow);
	}
}

/*
	Name: allowspectateallteamsexceptteam
	Namespace: spectating
	Checksum: 0xCEE31C25
	Offset: 0x5A0
	Size: 0xA8
	Parameters: 2
	Flags: Linked
*/
function allowspectateallteamsexceptteam(skip_team, allow)
{
	foreach(team, _ in level.teams)
	{
		if(team == skip_team)
		{
			continue;
		}
		self allowspectateteam(team, allow);
	}
}

/*
	Name: setspectatepermissions
	Namespace: spectating
	Checksum: 0xF2CB8AB5
	Offset: 0x650
	Size: 0x54C
	Parameters: 0
	Flags: Linked
*/
function setspectatepermissions()
{
	team = self.sessionteam;
	if(team == "spectator")
	{
		if(self issplitscreen() && !level.splitscreen)
		{
			team = getsplitscreenteam();
		}
		if(team == "spectator")
		{
			self allowspectateallteams(1);
			self allowspectateteam("freelook", 0);
			self allowspectateteam("none", 1);
			self allowspectateteam("localplayers", 1);
			return;
		}
	}
	spectatetype = level.spectatetype;
	switch(spectatetype)
	{
		case 0:
		{
			self allowspectateallteams(0);
			self allowspectateteam("freelook", 0);
			self allowspectateteam("none", 1);
			self allowspectateteam("localplayers", 0);
			break;
		}
		case 3:
		{
			if(self issplitscreen() && self otherlocalplayerstillalive())
			{
				self allowspectateallteams(0);
				self allowspectateteam("none", 0);
				self allowspectateteam("freelook", 0);
				self allowspectateteam("localplayers", 1);
				break;
			}
		}
		case 1:
		{
			if(!level.teambased)
			{
				self allowspectateallteams(1);
				self allowspectateteam("none", 1);
				self allowspectateteam("freelook", 0);
				self allowspectateteam("localplayers", 1);
			}
			else
			{
				if(isdefined(team) && isdefined(level.teams[team]))
				{
					self allowspectateteam(team, 1);
					self allowspectateallteamsexceptteam(team, 0);
					self allowspectateteam("freelook", 0);
					self allowspectateteam("none", 0);
					self allowspectateteam("localplayers", 1);
				}
				else
				{
					self allowspectateallteams(0);
					self allowspectateteam("freelook", 0);
					self allowspectateteam("none", 0);
					self allowspectateteam("localplayers", 1);
				}
			}
			break;
		}
		case 2:
		{
			self allowspectateallteams(1);
			self allowspectateteam("freelook", 1);
			self allowspectateteam("none", 1);
			self allowspectateteam("localplayers", 1);
			break;
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
			self allowspectateallteamsexceptteam(team, 1);
		}
	}
}

/*
	Name: setspectatepermissionsformachine
	Namespace: spectating
	Checksum: 0xE106DDAF
	Offset: 0xBA8
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function setspectatepermissionsformachine()
{
	self setspectatepermissions();
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
		level.players[index] setspectatepermissions();
	}
}

