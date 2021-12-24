// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\zm_common\gametypes\globallogic_score.gsc;
#using scripts\zm_common\gametypes\hostmigration.gsc;

#namespace globallogic_utils;

/*
	Name: testshock
	Namespace: globallogic_utils
	Checksum: 0xA8DC9B43
	Offset: 0xD0
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
	Checksum: 0x6C582FE9
	Offset: 0x198
	Size: 0x94
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
		wait(20);
	}
}

/*
	Name: timeuntilroundend
	Namespace: globallogic_utils
	Checksum: 0xFCB415C8
	Offset: 0x238
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function timeuntilroundend()
{
	if(level.gameended)
	{
		timepassed = (gettime() - level.gameendtime) / 1000;
		timeremaining = level.postroundtime - timepassed;
		if(timeremaining < 0)
		{
			return 0;
		}
		return timeremaining;
	}
	if(level.inovertime)
	{
		return undefined;
	}
	if(level.timelimit <= 0)
	{
		return undefined;
	}
	if(!isdefined(level.starttime))
	{
		return undefined;
	}
	timepassed = (gettimepassed() - level.starttime) / 1000;
	timeremaining = (level.timelimit * 60) - timepassed;
	return timeremaining + level.postroundtime;
}

/*
	Name: gettimeremaining
	Namespace: globallogic_utils
	Checksum: 0x9CFC9827
	Offset: 0x328
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function gettimeremaining()
{
	return ((level.timelimit * 60) * 1000) - gettimepassed();
}

/*
	Name: registerpostroundevent
	Namespace: globallogic_utils
	Checksum: 0xA01C2F7
	Offset: 0x360
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
	Checksum: 0xE7E66FCA
	Offset: 0x3B0
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
	Checksum: 0x445B9128
	Offset: 0x410
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
	Checksum: 0x265ED4E2
	Offset: 0x468
	Size: 0x1C2
	Parameters: 0
	Flags: None
*/
function assertproperplacement()
{
	/#
		numplayers = level.placement[#"all"].size;
		for(i = 0; i < numplayers - 1; i++)
		{
			if(isdefined(level.placement[#"all"][i]) && isdefined(level.placement[#"all"][i + 1]))
			{
				if(level.placement[#"all"][i].score < level.placement[#"all"][i + 1].score)
				{
					println("");
					for(i = 0; i < numplayers; i++)
					{
						player = level.placement[#"all"][i];
						println((((("" + i) + "") + player.name) + "") + player.score);
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
	Checksum: 0xF28D881C
	Offset: 0x638
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function isvalidclass(vclass)
{
	if(level.oldschool || sessionmodeiszombiesgame())
	{
		/#
			assert(!isdefined(vclass));
		#/
		return 1;
	}
	return isdefined(vclass) && vclass != "";
}

/*
	Name: playtickingsound
	Namespace: globallogic_utils
	Checksum: 0x3A70DB50
	Offset: 0x6B0
	Size: 0x118
	Parameters: 1
	Flags: None
*/
function playtickingsound(gametype_tick_sound)
{
	self endon(#"death", #"stop_ticking");
	level endon(#"game_ended");
	time = level.bombtimer;
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
	Checksum: 0xA4B3FEC0
	Offset: 0x7D0
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function stoptickingsound()
{
	self notify(#"stop_ticking");
}

/*
	Name: gametimer
	Namespace: globallogic_utils
	Checksum: 0x10BE8EAD
	Offset: 0x7F0
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function gametimer()
{
	level endon(#"game_ended");
	level waittill(#"prematch_over");
	level.starttime = gettime();
	level.discardtime = 0;
	if(isdefined(game.roundmillisecondsalreadypassed))
	{
		level.starttime = level.starttime - game.roundmillisecondsalreadypassed;
		game.roundmillisecondsalreadypassed = undefined;
	}
	prevtime = gettime();
	while(game.state == "playing")
	{
		if(!level.timerstopped)
		{
			game.timepassed = game.timepassed + (gettime() - prevtime);
		}
		prevtime = gettime();
		wait(1);
	}
}

/*
	Name: gettimepassed
	Namespace: globallogic_utils
	Checksum: 0x843B0220
	Offset: 0x8E0
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
		return (level.timerpausetime - level.starttime) - level.discardtime;
	}
	return (gettime() - level.starttime) - level.discardtime;
}

/*
	Name: pausetimer
	Namespace: globallogic_utils
	Checksum: 0xD5124267
	Offset: 0x950
	Size: 0x2E
	Parameters: 0
	Flags: None
*/
function pausetimer()
{
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
	Checksum: 0xBE93C885
	Offset: 0x988
	Size: 0x46
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
	level.discardtime = level.discardtime + (gettime() - level.timerpausetime);
}

/*
	Name: getscoreremaining
	Namespace: globallogic_utils
	Checksum: 0xCA695483
	Offset: 0x9D8
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
	Name: getscoreperminute
	Namespace: globallogic_utils
	Checksum: 0xB1EEE434
	Offset: 0xA80
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function getscoreperminute(team)
{
	/#
		assert(isplayer(self) || isdefined(team));
	#/
	scorelimit = level.scorelimit;
	timelimit = level.timelimit;
	minutespassed = (gettimepassed() / 60000) + 0.0001;
	if(isplayer(self))
	{
		return globallogic_score::_getplayerscore(self) / minutespassed;
	}
	return getteamscore(team) / minutespassed;
}

/*
	Name: getestimatedtimeuntilscorelimit
	Namespace: globallogic_utils
	Checksum: 0xD3FAF349
	Offset: 0xB78
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
	Checksum: 0xF47AC2B4
	Offset: 0xC20
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
	Checksum: 0x785F180F
	Offset: 0xC70
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
	Checksum: 0x88A1E57F
	Offset: 0xCA0
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
	Checksum: 0x36E202BD
	Offset: 0xD08
	Size: 0x86
	Parameters: 4
	Flags: None
*/
function isheadshot(weapon, shitloc, smeansofdeath, einflictor)
{
	if(shitloc != "head" && shitloc != "helmet")
	{
		return 0;
	}
	switch(smeansofdeath)
	{
		case "mod_impact":
		case "mod_melee":
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: gethitlocheight
	Namespace: globallogic_utils
	Checksum: 0x7ACE2227
	Offset: 0xD98
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
	Checksum: 0xE7748731
	Offset: 0xF08
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
	Checksum: 0xE16A2BF3
	Offset: 0xF70
	Size: 0x56
	Parameters: 2
	Flags: None
*/
function isexcluded(entity, entitylist)
{
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
	Name: logteamwinstring
	Namespace: globallogic_utils
	Checksum: 0xF6FFC7D9
	Offset: 0xFD0
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function logteamwinstring(wintype, winner)
{
	/#
		log_string = wintype;
		if(isdefined(winner))
		{
			log_string = (log_string + "") + winner;
		}
		foreach(team, str_team in level.teams)
		{
			log_string = (((log_string + "") + str_team) + "") + game.stat[#"teamscores"][team];
		}
		print(log_string);
	#/
}

