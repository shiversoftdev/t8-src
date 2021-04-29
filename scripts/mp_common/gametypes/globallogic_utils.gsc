// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_68d2ee1489345a1d;
#using script_6c8abe14025b47c4;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\hostmigration.gsc;
#using scripts\mp_common\gametypes\hud_message.gsc;
#using scripts\mp_common\gametypes\round.gsc;

#namespace globallogic_utils;

/*
	Name: function_2d4168be
	Namespace: globallogic_utils
	Checksum: 0x90EC7D4D
	Offset: 0x118
	Size: 0xCA
	Parameters: 2
	Flags: None
*/
function function_2d4168be(outcome, var_512330f1)
{
	if(isplayer(var_512330f1))
	{
		if(outcome.players.size && outcome.players[0] == var_512330f1)
		{
			return 1;
		}
		if(isdefined(outcome.team) && outcome.team == var_512330f1.team)
		{
			return 1;
		}
	}
	else if(isdefined(outcome.team) && outcome.team == var_512330f1)
	{
		return 1;
	}
	return 0;
}

/*
	Name: testshock
	Namespace: globallogic_utils
	Checksum: 0x13A2327E
	Offset: 0x1F0
	Size: 0xBA
	Parameters: 0
	Flags: None
*/
function testshock()
{
	self endon(#"death", #"disconnect");
	for(;;)
	{
		wait(3);
		numshots = randomint(6);
		for(i = 0; i < numshots; i++)
		{
			iprintlnbold(numshots);
			self shellshock(#"frag_grenade_mp", 0.2);
			wait(0.1);
		}
	}
}

/*
	Name: testhps
	Namespace: globallogic_utils
	Checksum: 0x7883554D
	Offset: 0x2B8
	Size: 0xD0
	Parameters: 0
	Flags: None
*/
function testhps()
{
	self endon(#"death", #"disconnect");
	hps = [];
	hps[hps.size] = "radar";
	hps[hps.size] = "artillery";
	hps[hps.size] = "dogs";
	for(;;)
	{
		hp = "radar";
		if(self thread killstreaks::give(hp))
		{
			self playlocalsound(level.killstreaks[hp].informdialog);
		}
		wait(20);
	}
}

/*
	Name: timeuntilroundend
	Namespace: globallogic_utils
	Checksum: 0xFA3F1324
	Offset: 0x390
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function timeuntilroundend()
{
	if(level.gameended)
	{
		timepassed = float(gettime() - level.gameendtime) / 1000;
		timeremaining = level.roundenddelay[3] - timepassed;
		if(timeremaining < 0)
		{
			return 0;
		}
		return timeremaining;
	}
	if(level.timelimit <= 0)
	{
		return undefined;
	}
	if(!isdefined(level.starttime))
	{
		return undefined;
	}
	timepassed = float(gettimepassed() - level.starttime) / 1000;
	timeremaining = level.timelimit * 60 - timepassed;
	return timeremaining + level.roundenddelay[3];
}

/*
	Name: gettimeremaining
	Namespace: globallogic_utils
	Checksum: 0x1272F52A
	Offset: 0x4A8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function gettimeremaining()
{
	return level.timelimit * int(60 * 1000) - gettimepassed();
}

/*
	Name: registerpostroundevent
	Namespace: globallogic_utils
	Checksum: 0x6E600E5F
	Offset: 0x4F0
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function registerpostroundevent(eventfunc)
{
	if(!isdefined(level.postroundevents))
	{
		level.postroundevents = [];
	}
	level.postroundevents[level.postroundevents.size] = eventfunc;
}

/*
	Name: executepostroundevents
	Namespace: globallogic_utils
	Checksum: 0x473F7C5C
	Offset: 0x540
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function executepostroundevents()
{
	if(!isdefined(level.postroundevents))
	{
		return;
	}
	for(i = 0; i < level.postroundevents.size; i++)
	{
		[[level.postroundevents[i]]]();
	}
}

/*
	Name: getvalueinrange
	Namespace: globallogic_utils
	Checksum: 0x7EB2CE4B
	Offset: 0x5A0
	Size: 0x4C
	Parameters: 3
	Flags: None
*/
function getvalueinrange(value, minvalue, maxvalue)
{
	if(value > maxvalue)
	{
		return maxvalue;
	}
	if(value < minvalue)
	{
		return minvalue;
	}
	return value;
}

/*
	Name: assertproperplacement
	Namespace: globallogic_utils
	Checksum: 0xA794AC3D
	Offset: 0x5F8
	Size: 0x2CA
	Parameters: 0
	Flags: None
*/
function assertproperplacement()
{
	/#
		numplayers = level.placement[#"all"].size;
		if(level.teambased)
		{
			for(i = 0; i < numplayers - 1; i++)
			{
				if(level.placement[#"all"][i].score < level.placement[#"all"][i + 1].score)
				{
					println("");
					for(j = 0; j < numplayers; j++)
					{
						player = level.placement[#"all"][j];
						println("" + j + "" + player.name + "" + player.score);
					}
					/#
						assertmsg("");
					#/
					break;
				}
			}
		}
		else
		{
			for(i = 0; i < numplayers - 1; i++)
			{
				if(level.placement[#"all"][i].pointstowin < level.placement[#"all"][i + 1].pointstowin)
				{
					println("");
					for(j = 0; j < numplayers; j++)
					{
						player = level.placement[#"all"][j];
						println("" + j + "" + player.name + "" + player.pointstowin);
					}
					/#
						assertmsg("");
					#/
					break;
				}
			}
		}
	#/
}

/*
	Name: isvalidclass
	Namespace: globallogic_utils
	Checksum: 0x316712AA
	Offset: 0x8D0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function isvalidclass(c)
{
	return isdefined(c) && c != "";
}

/*
	Name: playtickingsound
	Namespace: globallogic_utils
	Checksum: 0xF92A0771
	Offset: 0x900
	Size: 0x118
	Parameters: 1
	Flags: None
*/
function playtickingsound(gametype_tick_sound)
{
	self endon(#"death", #"stop_ticking");
	level endon(#"game_ended");
	while(true)
	{
		self playsound(gametype_tick_sound);
		if(time > 10)
		{
			time = time - 1;
			wait(1);
		}
		else if(time > 4)
		{
			time = time - 0.5;
			wait(0.5);
		}
		else if(time > 1)
		{
			time = time - 0.4;
			wait(0.4);
		}
		else
		{
			time = time - 0.3;
			wait(0.3);
		}
		hostmigration::waittillhostmigrationdone();
	}
}

/*
	Name: stoptickingsound
	Namespace: globallogic_utils
	Checksum: 0xB53FF919
	Offset: 0xA20
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function stoptickingsound()
{
	if(isdefined(self))
	{
		self notify(#"stop_ticking");
	}
}

/*
	Name: gametimer
	Namespace: globallogic_utils
	Checksum: 0xC4142529
	Offset: 0xA48
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function gametimer()
{
	level endon(#"game_ended");
	level.var_8a3a9ca4.roundstart = gettime();
	level.starttime = gettime();
	level.discardtime = 0;
	if(isdefined(game.roundmillisecondsalreadypassed))
	{
		level.starttime = level.starttime - game.roundmillisecondsalreadypassed;
		game.roundmillisecondsalreadypassed = undefined;
	}
	while(game.state == "playing")
	{
		if(!level.timerstopped)
		{
			game.timepassed = game.timepassed + gettime() - prevtime;
		}
		if(!level.playabletimerstopped)
		{
			game.playabletimepassed = game.playabletimepassed + gettime() - prevtime;
		}
		prevtime = gettime();
		wait(1);
	}
}

/*
	Name: disableplayerroundstartdelay
	Namespace: globallogic_utils
	Checksum: 0xC2437C44
	Offset: 0xB60
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function disableplayerroundstartdelay()
{
	player = self;
	player endon(#"death", #"disconnect");
	if(getroundstartdelay())
	{
		wait(getroundstartdelay());
	}
	player disableroundstartdelay();
}

/*
	Name: getroundstartdelay
	Namespace: globallogic_utils
	Checksum: 0x8705FB9E
	Offset: 0xBE8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function getroundstartdelay()
{
	waittime = level.roundstartexplosivedelay - float([[level.gettimepassed]]()) / 1000;
	if(waittime > 0)
	{
		return waittime;
	}
	return 0;
}

/*
	Name: applyroundstartdelay
	Namespace: globallogic_utils
	Checksum: 0x3DE5ABE9
	Offset: 0xC48
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function applyroundstartdelay()
{
	self endon(#"disconnect", #"joined_spectators", #"death");
	if(game.state == "pregame")
	{
		level waittill(#"hash_313ad43b34e74e96");
	}
	else
	{
		waitframe(1);
	}
	self enableroundstartdelay();
	self thread disableplayerroundstartdelay();
}

/*
	Name: gettimepassed
	Namespace: globallogic_utils
	Checksum: 0x18B4C773
	Offset: 0xCF0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function gettimepassed()
{
	if(!isdefined(level.starttime))
	{
		return 0;
	}
	if(level.timerstopped)
	{
		return level.timerpausetime - level.starttime - level.discardtime;
	}
	return gettime() - level.starttime - level.discardtime;
}

/*
	Name: pausetimer
	Namespace: globallogic_utils
	Checksum: 0xAF766E59
	Offset: 0xD60
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function pausetimer(pauseplayabletimer = 0)
{
	level.playabletimerstopped = pauseplayabletimer;
	if(level.timerstopped)
	{
		return;
	}
	level.timerstopped = 1;
	level.timerpausetime = gettime();
}

/*
	Name: resumetimer
	Namespace: globallogic_utils
	Checksum: 0xBFF9B58F
	Offset: 0xDC0
	Size: 0x52
	Parameters: 0
	Flags: None
*/
function resumetimer()
{
	if(!level.timerstopped)
	{
		return;
	}
	level.timerstopped = 0;
	level.playabletimerstopped = 0;
	level.discardtime = level.discardtime + gettime() - level.timerpausetime;
}

/*
	Name: resumetimerdiscardoverride
	Namespace: globallogic_utils
	Checksum: 0xA9E144AF
	Offset: 0xE20
	Size: 0x3A
	Parameters: 1
	Flags: None
*/
function resumetimerdiscardoverride(discardtime)
{
	if(!level.timerstopped)
	{
		return;
	}
	level.timerstopped = 0;
	level.discardtime = discardtime;
}

/*
	Name: getscoreremaining
	Namespace: globallogic_utils
	Checksum: 0xB10C37BF
	Offset: 0xE68
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function getscoreremaining(team)
{
	/#
		assert(isplayer(self) || isdefined(team));
	#/
	scorelimit = level.scorelimit;
	if(isplayer(self))
	{
		return scorelimit - globallogic_score::_getplayerscore(self);
	}
	return scorelimit - getteamscore(team);
}

/*
	Name: getteamscoreforround
	Namespace: globallogic_utils
	Checksum: 0x71F9A59
	Offset: 0xF10
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function getteamscoreforround(team)
{
	if(level.cumulativeroundscores && isdefined(game.lastroundscore[team]))
	{
		return getteamscore(team) - game.lastroundscore[team];
	}
	return getteamscore(team);
}

/*
	Name: getscoreperminute
	Namespace: globallogic_utils
	Checksum: 0x86CC7D75
	Offset: 0xF88
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function getscoreperminute(team)
{
	/#
		assert(isplayer(self) || isdefined(team));
	#/
	minutespassed = gettimepassed() / int(60 * 1000) + 0.0001;
	if(isplayer(self))
	{
		return globallogic_score::_getplayerscore(self) / minutespassed;
	}
	return getteamscoreforround(team) / minutespassed;
}

/*
	Name: getestimatedtimeuntilscorelimit
	Namespace: globallogic_utils
	Checksum: 0x868AAFEB
	Offset: 0x1068
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function getestimatedtimeuntilscorelimit(team)
{
	/#
		assert(isplayer(self) || isdefined(team));
	#/
	scoreperminute = self getscoreperminute(team);
	scoreremaining = self getscoreremaining(team);
	if(!scoreperminute)
	{
		return 999999;
	}
	return scoreremaining / scoreperminute;
}

/*
	Name: rumbler
	Namespace: globallogic_utils
	Checksum: 0x93B806D6
	Offset: 0x1110
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function rumbler()
{
	self endon(#"disconnect");
	while(true)
	{
		wait(0.1);
		self playrumbleonentity("damage_heavy");
	}
}

/*
	Name: waitfortimeornotify
	Namespace: globallogic_utils
	Checksum: 0x59B0C0C3
	Offset: 0x1160
	Size: 0x24
	Parameters: 2
	Flags: Linked
*/
function waitfortimeornotify(time, notifyname)
{
	self endon(notifyname);
	wait(time);
}

/*
	Name: waitfortimeornotifynoartillery
	Namespace: globallogic_utils
	Checksum: 0x4E754972
	Offset: 0x1190
	Size: 0x60
	Parameters: 2
	Flags: None
*/
function waitfortimeornotifynoartillery(time, notifyname)
{
	self endon(notifyname);
	wait(time);
	while(isdefined(level.artilleryinprogress))
	{
		/#
			assert(level.artilleryinprogress);
		#/
		wait(0.25);
	}
}

/*
	Name: isheadshot
	Namespace: globallogic_utils
	Checksum: 0xFFB1A4C9
	Offset: 0x11F8
	Size: 0x140
	Parameters: 4
	Flags: Linked
*/
function isheadshot(weapon, shitloc, smeansofdeath, einflictor)
{
	if(shitloc != "head" && shitloc != "helmet")
	{
		return 0;
	}
	switch(smeansofdeath)
	{
		case "mod_melee_assassinate":
		case "mod_melee":
		{
			return 0;
		}
		case "mod_impact":
		{
			baseweapon = weapons::getbaseweapon(weapon);
			if(!weapon.isballisticknife && baseweapon != level.weaponspecialcrossbow && baseweapon != level.var_9e188c0b)
			{
				return 0;
			}
		}
	}
	if(killstreaks::is_killstreak_weapon(weapon))
	{
		if(!isdefined(einflictor) || !isdefined(einflictor.controlled) || einflictor.controlled == 0)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: gethitlocheight
	Namespace: globallogic_utils
	Checksum: 0x1A6008CD
	Offset: 0x1340
	Size: 0x166
	Parameters: 1
	Flags: None
*/
function gethitlocheight(shitloc)
{
	switch(shitloc)
	{
		case "head":
		case "helmet":
		case "neck":
		{
			return 60;
		}
		case "left_arm_lower":
		case "left_arm_upper":
		case "torso_upper":
		case "right_arm_lower":
		case "left_hand":
		case "right_arm_upper":
		case "gun":
		case "right_hand":
		{
			return 48;
		}
		case "torso_lower":
		{
			return 40;
		}
		case "right_leg_upper":
		case "left_leg_upper":
		{
			return 32;
		}
		case "left_leg_lower":
		case "right_leg_lower":
		{
			return 10;
		}
		case "left_foot":
		case "right_foot":
		{
			return 5;
		}
	}
	return 48;
}

/*
	Name: debugline
	Namespace: globallogic_utils
	Checksum: 0x13C75858
	Offset: 0x14B0
	Size: 0x5C
	Parameters: 2
	Flags: None
*/
function debugline(start, end)
{
	/#
		for(i = 0; i < 50; i++)
		{
			line(start, end);
			waitframe(1);
		}
	#/
}

/*
	Name: isexcluded
	Namespace: globallogic_utils
	Checksum: 0xC92A34C4
	Offset: 0x1518
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function isexcluded(entity, entitylist)
{
	if(!isarray(entitylist))
	{
		return entity == entitylist;
	}
	for(index = 0; index < entitylist.size; index++)
	{
		if(entity == entitylist[index])
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_4aa8d809
	Namespace: globallogic_utils
	Checksum: 0x83348D69
	Offset: 0x15A0
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function function_4aa8d809(index, string)
{
	level.var_336c35f1[index] = string;
}

/*
	Name: function_8d61a6c2
	Namespace: globallogic_utils
	Checksum: 0x19ECE4A
	Offset: 0x15D8
	Size: 0x22C
	Parameters: 1
	Flags: Linked
*/
function function_8d61a6c2(var_c1e98979)
{
	/#
		/#
			assert(isdefined(var_c1e98979));
		#/
		/#
			assert(isdefined(level.var_336c35f1[var_c1e98979]));
		#/
		log_string = level.var_336c35f1[var_c1e98979];
		winner = round::function_9b24638f();
		if(isplayer(winner))
		{
			print("" + winner getxuid() + "" + winner.name + "");
		}
		if(isdefined(winner))
		{
			if(isplayer(winner))
			{
				log_string = log_string + "" + winner getxuid() + "" + winner.name + "";
			}
			else
			{
				log_string = log_string + "" + winner;
			}
		}
		foreach(team, str_team in level.teams)
		{
			log_string = log_string + "" + str_team + "" + game.stat[#"teamscores"][team];
		}
		print(log_string);
	#/
}

/*
	Name: add_map_error
	Namespace: globallogic_utils
	Checksum: 0x5C5AE9A8
	Offset: 0x1810
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function add_map_error(msg)
{
	if(!isdefined(level.maperrors))
	{
		level.maperrors = [];
	}
	level.maperrors[level.maperrors.size] = msg;
}

/*
	Name: print_map_errors
	Namespace: globallogic_utils
	Checksum: 0xFAAD6FBE
	Offset: 0x1860
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function print_map_errors()
{
	if(isdefined(level.maperrors) && level.maperrors.size > 0)
	{
		/#
			println("");
			for(i = 0; i < level.maperrors.size; i++)
			{
				println("" + level.maperrors[i]);
			}
			println("");
			util::error("");
		#/
		callback::abort_level();
		return 1;
	}
	return 0;
}

/*
	Name: function_308e3379
	Namespace: globallogic_utils
	Checksum: 0x892D0A4F
	Offset: 0x1948
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function function_308e3379()
{
	return strendswith(level.gametype, "_bb");
}

