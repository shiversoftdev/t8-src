// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\gametypes\globallogic.gsc;
#using scripts\zm_common\gametypes\globallogic_player.gsc;
#using scripts\zm_common\gametypes\spectating.gsc;
#using scripts\zm_common\util.gsc;

#namespace globallogic_ui;

/*
	Name: __init__system__
	Namespace: globallogic_ui
	Checksum: 0x7DF4D212
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"globallogic_ui", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: globallogic_ui
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: setupcallbacks
	Namespace: globallogic_ui
	Checksum: 0xF937DA09
	Offset: 0x170
	Size: 0x7E
	Parameters: 0
	Flags: None
*/
function setupcallbacks()
{
	level.autoassign = &menuautoassign;
	level.spectator = &menuspectator;
	level.curclass = &menuclass;
	level.teammenu = &menuteam;
	level.autocontrolplayer = &menuautocontrolplayer;
}

/*
	Name: freegameplayhudelems
	Namespace: globallogic_ui
	Checksum: 0xB7D2EFCE
	Offset: 0x1F8
	Size: 0x27C
	Parameters: 0
	Flags: None
*/
function freegameplayhudelems()
{
	/#
		if(isdefined(self.perkicon))
		{
			for(numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++)
			{
				if(isdefined(self.perkicon[numspecialties]))
				{
					self.perkicon[numspecialties] hud::destroyelem();
					self.perkname[numspecialties] hud::destroyelem();
				}
			}
		}
		if(isdefined(self.perkhudelem))
		{
			self.perkhudelem hud::destroyelem();
		}
		if(isdefined(self.killstreakicon))
		{
			if(isdefined(self.killstreakicon[0]))
			{
				self.killstreakicon[0] hud::destroyelem();
			}
			if(isdefined(self.killstreakicon[1]))
			{
				self.killstreakicon[1] hud::destroyelem();
			}
			if(isdefined(self.killstreakicon[2]))
			{
				self.killstreakicon[2] hud::destroyelem();
			}
			if(isdefined(self.killstreakicon[3]))
			{
				self.killstreakicon[3] hud::destroyelem();
			}
			if(isdefined(self.killstreakicon[4]))
			{
				self.killstreakicon[4] hud::destroyelem();
			}
		}
		if(isdefined(self.lowermessage))
		{
			self.lowermessage hud::destroyelem();
		}
		if(isdefined(self.lowertimer))
		{
			self.lowertimer hud::destroyelem();
		}
		if(isdefined(self.proxbar))
		{
			self.proxbar hud::destroyelem();
		}
		if(isdefined(self.proxbartext))
		{
			self.proxbartext hud::destroyelem();
		}
		if(isdefined(self.carryicon))
		{
			self.carryicon hud::destroyelem();
		}
	#/
}

/*
	Name: teamplayercountsequal
	Namespace: globallogic_ui
	Checksum: 0x691A2637
	Offset: 0x480
	Size: 0xB2
	Parameters: 1
	Flags: None
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
			return false;
		}
	}
	return true;
}

/*
	Name: teamwithlowestplayercount
	Namespace: globallogic_ui
	Checksum: 0xB0BDA484
	Offset: 0x540
	Size: 0xC0
	Parameters: 2
	Flags: None
*/
function teamwithlowestplayercount(playercounts, ignore_team)
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
	Name: menuautoassign
	Namespace: globallogic_ui
	Checksum: 0x948AB1B2
	Offset: 0x608
	Size: 0x574
	Parameters: 1
	Flags: Linked
*/
function menuautoassign(comingfrommenu)
{
	teamkeys = getarraykeys(level.teams);
	assignment = teamkeys[randomint(teamkeys.size)];
	self closemenus();
	if(isdefined(level.forceallallies) && level.forceallallies)
	{
		assignment = #"allies";
	}
	else
	{
		if(level.teambased)
		{
			if(getdvarint(#"party_autoteams", 0) == 1)
			{
				if(level.allow_teamchange && (self.hasspawned || comingfrommenu))
				{
					assignment = "";
				}
				else
				{
					team = getassignedteam(self);
					switch(team)
					{
						case 1:
						{
							assignment = teamkeys[1];
							break;
						}
						case 2:
						{
							assignment = teamkeys[0];
							break;
						}
						case 3:
						{
							assignment = teamkeys[2];
							break;
						}
						case 4:
						{
							if(!isdefined(level.forceautoassign) || !level.forceautoassign)
							{
								return;
							}
						}
						default:
						{
							assignment = "";
							if(isdefined(level.teams[team]))
							{
								assignment = team;
							}
							else if(team == "spectator" && !level.forceautoassign)
							{
								return;
							}
						}
					}
				}
			}
			if(assignment == "" || getdvarint(#"party_autoteams", 0) == 0)
			{
				assignment = #"allies";
			}
			if(assignment == self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead"))
			{
				self beginclasschoice();
				return;
			}
		}
		else if(getdvarint(#"party_autoteams", 0) == 1)
		{
			if(!level.allow_teamchange || (!self.hasspawned && !comingfrommenu))
			{
				team = getassignedteam(self);
				if(isdefined(level.teams[team]))
				{
					assignment = team;
				}
				else if(team == "spectator" && !level.forceautoassign)
				{
					return;
				}
			}
		}
	}
	if(isdefined(self.botteam) && self.botteam != "autoassign")
	{
		assignment = self.botteam;
	}
	if(assignment != self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead"))
	{
		self.switching_teams = 1;
		self.joining_team = assignment;
		self.leaving_team = self.pers[#"team"];
		self suicide();
	}
	self.pers[#"team"] = assignment;
	self.team = assignment;
	self.pers[#"class"] = undefined;
	self.curclass = undefined;
	self.pers[#"weapon"] = undefined;
	self.pers[#"savedmodel"] = undefined;
	self updateobjectivetext();
	self.sessionteam = assignment;
	if(!isalive(self))
	{
		self.statusicon = "hud_status_dead";
	}
	self player::function_466d8a4b(comingfrommenu);
	self notify(#"end_respawn");
	self beginclasschoice();
}

/*
	Name: teamscoresequal
	Namespace: globallogic_ui
	Checksum: 0xE43AEE19
	Offset: 0xB88
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
			return false;
		}
	}
	return true;
}

/*
	Name: teamwithlowestscore
	Namespace: globallogic_ui
	Checksum: 0x41DB77A5
	Offset: 0xC50
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
	Namespace: globallogic_ui
	Checksum: 0x628EAE2F
	Offset: 0xD08
	Size: 0x7A
	Parameters: 1
	Flags: None
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
	Name: getsplitscreenteam
	Namespace: globallogic_ui
	Checksum: 0xA4034C58
	Offset: 0xD90
	Size: 0xCA
	Parameters: 0
	Flags: None
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
	return "";
}

/*
	Name: updateobjectivetext
	Namespace: globallogic_ui
	Checksum: 0x7C092E3F
	Offset: 0xE68
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function updateobjectivetext()
{
	self setclientcgobjectivetext("");
}

/*
	Name: closemenus
	Namespace: globallogic_ui
	Checksum: 0x6C75F1FD
	Offset: 0xE98
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function closemenus()
{
	self closeingamemenu();
}

/*
	Name: beginclasschoice
	Namespace: globallogic_ui
	Checksum: 0xA658585D
	Offset: 0xEC0
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function beginclasschoice(forcenewchoice)
{
	/#
		assert(isdefined(level.teams[self.pers[#"team"]]));
	#/
	team = self.pers[#"team"];
	if(level.disablecac == 1)
	{
		self.pers[#"class"] = level.defaultclass;
		self.curclass = level.defaultclass;
		if(self.sessionstate != "playing" && game.state == "playing")
		{
			self thread [[level.spawnclient]]();
		}
		self thread spectating::setspectatepermissionsformachine();
		return;
	}
	self openmenu(game.menu["menu_changeclass_" + level.teams[team]]);
}

/*
	Name: showmainmenuforteam
	Namespace: globallogic_ui
	Checksum: 0x6CB26A6F
	Offset: 0x1010
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function showmainmenuforteam()
{
	/#
		assert(isdefined(level.teams[self.pers[#"team"]]));
	#/
	team = self.pers[#"team"];
	self openmenu(game.menu["menu_changeclass_" + level.teams[team]]);
}

/*
	Name: menuautocontrolplayer
	Namespace: globallogic_ui
	Checksum: 0x18598400
	Offset: 0x10B8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function menuautocontrolplayer()
{
	self closemenus();
	if(self.pers[#"team"] != "spectator")
	{
		toggleplayercontrol(self);
	}
}

/*
	Name: menuteam
	Namespace: globallogic_ui
	Checksum: 0xCBA5E22D
	Offset: 0x1118
	Size: 0x204
	Parameters: 1
	Flags: Linked
*/
function menuteam(team)
{
	self closemenus();
	if(!level.console && !level.allow_teamchange && (isdefined(self.hasdonecombat) && self.hasdonecombat))
	{
		return;
	}
	if(self.pers[#"team"] != team)
	{
		if(level.ingraceperiod && (!isdefined(self.hasdonecombat) || !self.hasdonecombat))
		{
			self.hasspawned = 0;
		}
		if(self.sessionstate == "playing")
		{
			self.switching_teams = 1;
			self.joining_team = team;
			self.leaving_team = self.pers[#"team"];
			self suicide();
		}
		self.pers[#"team"] = team;
		self.team = team;
		self.pers[#"class"] = undefined;
		self.curclass = undefined;
		self.pers[#"weapon"] = undefined;
		self.pers[#"savedmodel"] = undefined;
		self updateobjectivetext();
		self.sessionteam = team;
		self player::function_466d8a4b(1);
		self notify(#"end_respawn");
	}
	self beginclasschoice();
}

/*
	Name: menuspectator
	Namespace: globallogic_ui
	Checksum: 0xA8B178B1
	Offset: 0x1328
	Size: 0x18E
	Parameters: 0
	Flags: Linked
*/
function menuspectator()
{
	self closemenus();
	if(self.pers[#"team"] != "spectator")
	{
		if(isalive(self))
		{
			self.switching_teams = 1;
			self.joining_team = "spectator";
			self.leaving_team = self.pers[#"team"];
			self suicide();
		}
		self.pers[#"team"] = "spectator";
		self.team = "spectator";
		self.pers[#"class"] = undefined;
		self.curclass = undefined;
		self.pers[#"weapon"] = undefined;
		self.pers[#"savedmodel"] = undefined;
		self updateobjectivetext();
		self.sessionteam = "spectator";
		[[level.spawnspectator]]();
		self thread globallogic_player::spectate_player_watcher();
		self notify(#"joined_spectators");
	}
}

/*
	Name: menuclass
	Namespace: globallogic_ui
	Checksum: 0xDB1DBC6A
	Offset: 0x14C0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function menuclass(response)
{
	self closemenus();
}

/*
	Name: removespawnmessageshortly
	Namespace: globallogic_ui
	Checksum: 0x284CBA01
	Offset: 0x14F0
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function removespawnmessageshortly(delay)
{
	self endon(#"disconnect");
	waittillframeend();
	self endon(#"end_respawn");
	wait(delay);
	self hud_message::clearlowermessage();
}

