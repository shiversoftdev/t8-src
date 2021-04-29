// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_256b8879317373de;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\gametypes\globallogic.gsc;
#using scripts\zm_common\gametypes\globallogic_audio.gsc;
#using scripts\zm_common\gametypes\globallogic_defaults.gsc;
#using scripts\zm_common\gametypes\globallogic_player.gsc;
#using scripts\zm_common\gametypes\globallogic_score.gsc;
#using scripts\zm_common\gametypes\globallogic_ui.gsc;
#using scripts\zm_common\gametypes\globallogic_utils.gsc;
#using scripts\zm_common\gametypes\hostmigration.gsc;
#using scripts\zm_common\gametypes\spawning.gsc;
#using scripts\zm_common\gametypes\spawnlogic.gsc;
#using scripts\zm_common\gametypes\spectating.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace globallogic_spawn;

/*
	Name: init
	Namespace: globallogic_spawn
	Checksum: 0x29D006A4
	Offset: 0x200
	Size: 0x2E
	Parameters: 0
	Flags: AutoExec
*/
autoexec function init()
{
	if(!isdefined(level.givestartloadout))
	{
		level.givestartloadout = &givestartloadout;
	}
}

/*
	Name: timeuntilspawn
	Namespace: globallogic_spawn
	Checksum: 0x429A8669
	Offset: 0x238
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function timeuntilspawn(includeteamkilldelay)
{
	if(level.ingraceperiod && !self.hasspawned)
	{
		return 0;
	}
	respawndelay = 0;
	if(isdefined(self.hasspawned) && self.hasspawned)
	{
		result = self [[level.onrespawndelay]]();
		if(isdefined(result))
		{
			respawndelay = result;
		}
		else
		{
			respawndelay = level.playerrespawndelay;
		}
	}
	wavebased = level.waverespawndelay > 0;
	if(wavebased)
	{
		return self timeuntilwavespawn(respawndelay);
	}
	return respawndelay;
}

/*
	Name: allteamshaveexisted
	Namespace: globallogic_spawn
	Checksum: 0xD875C12E
	Offset: 0x310
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function allteamshaveexisted()
{
	foreach(team, _ in level.teams)
	{
		if(!level.everexisted[team])
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: mayspawn
	Namespace: globallogic_spawn
	Checksum: 0x362D765E
	Offset: 0x3A0
	Size: 0x17A
	Parameters: 0
	Flags: Linked
*/
function mayspawn()
{
	if(isdefined(level.playermayspawn) && !self [[level.playermayspawn]]())
	{
		return 0;
	}
	if(level.inovertime)
	{
		return 0;
	}
	if(level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns)
	{
		return 0;
	}
	if(level.numlives)
	{
		if(level.teambased)
		{
			gamehasstarted = allteamshaveexisted();
		}
		else
		{
			gamehasstarted = level.maxplayercount > 1 || (!util::isoneround() && !util::isfirstround());
		}
		if(!self.pers[#"lives"] && gamehasstarted)
		{
			return 0;
		}
		if(gamehasstarted)
		{
			if(!level.ingraceperiod && !self.hasspawned && !isbot(self))
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: timeuntilwavespawn
	Namespace: globallogic_spawn
	Checksum: 0x20EAE81
	Offset: 0x528
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function timeuntilwavespawn(minimumwait)
{
	earliestspawntime = gettime() + minimumwait * 1000;
	lastwavetime = level.lastwave[self.pers[#"team"]];
	wavedelay = level.wavedelay[self.pers[#"team"]] * 1000;
	if(wavedelay == 0)
	{
		return 0;
	}
	numwavespassedearliestspawntime = earliestspawntime - lastwavetime / wavedelay;
	numwaves = ceil(numwavespassedearliestspawntime);
	timeofspawn = lastwavetime + numwaves * wavedelay;
	if(isdefined(self.wavespawnindex))
	{
		timeofspawn = timeofspawn + 50 * self.wavespawnindex;
	}
	return timeofspawn - gettime() / 1000;
}

/*
	Name: stoppoisoningandflareonspawn
	Namespace: globallogic_spawn
	Checksum: 0x768931F4
	Offset: 0x658
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function stoppoisoningandflareonspawn()
{
	self endon(#"disconnect");
	self.inpoisonarea = 0;
	self.inburnarea = 0;
	self.inflarevisionarea = 0;
	self.ingroundnapalm = 0;
}

/*
	Name: spawnplayerprediction
	Namespace: globallogic_spawn
	Checksum: 0x75CB4A86
	Offset: 0x6A8
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function spawnplayerprediction()
{
	self endon(#"disconnect", #"end_respawn", #"game_ended", #"joined_spectators", #"spawned");
	while(true)
	{
		wait(0.5);
		if(isdefined(level.onspawnplayerunified) && getdvarint(#"scr_disableunifiedspawning", 0) == 0)
		{
			spawning::onspawnplayer_unified(1);
		}
		else
		{
			self [[level.onspawnplayer]](1);
		}
	}
}

/*
	Name: giveloadoutlevelspecific
	Namespace: globallogic_spawn
	Checksum: 0x52E9EC69
	Offset: 0x790
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function giveloadoutlevelspecific(team, _class)
{
	pixbeginevent(#"giveloadoutlevelspecific");
	if(isdefined(level.givestartloadout))
	{
		self [[level.givestartloadout]]();
	}
	self flagsys::set(#"loadout_given");
	callback::callback(#"on_loadout");
	pixendevent();
}

/*
	Name: givestartloadout
	Namespace: globallogic_spawn
	Checksum: 0x74D9AA53
	Offset: 0x848
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function givestartloadout()
{
	if(isdefined(level.givecustomloadout))
	{
		self [[level.givecustomloadout]]();
	}
}

/*
	Name: spawnplayer
	Namespace: globallogic_spawn
	Checksum: 0x9DFB83EE
	Offset: 0x878
	Size: 0x56C
	Parameters: 0
	Flags: Linked
*/
function spawnplayer()
{
	pixbeginevent(#"spawnplayer_preuts");
	self endon(#"disconnect", #"joined_spectators");
	hadspawned = self.hasspawned;
	self player::spawn_player();
	if(isdefined(self.hasspawned) && !self.hasspawned)
	{
		self.underscorechance = 70;
	}
	self.laststand = undefined;
	self.revivingteammate = 0;
	self.burning = undefined;
	self.nextkillstreakfree = undefined;
	self.activeuavs = 0;
	self.activecounteruavs = 0;
	self.activesatellites = 0;
	self.maxarmor = 100;
	self.deathmachinekills = 0;
	self.diedonvehicle = undefined;
	if(isdefined(self.wasaliveatmatchstart) && !self.wasaliveatmatchstart)
	{
		if(level.ingraceperiod || globallogic_utils::gettimepassed() < 20000)
		{
			self.wasaliveatmatchstart = 1;
		}
	}
	pixbeginevent(#"onspawnplayer");
	if(isdefined(level.onspawnplayerunified) && getdvarint(#"scr_disableunifiedspawning", 0) == 0)
	{
		self [[level.onspawnplayerunified]]();
	}
	else
	{
		self [[level.onspawnplayer]](0);
	}
	if(isdefined(level.playerspawnedcb))
	{
		self [[level.playerspawnedcb]]();
	}
	pixendevent();
	pixendevent();
	globallogic::updateteamstatus();
	pixbeginevent(#"spawnplayer_postuts");
	self thread stoppoisoningandflareonspawn();
	/#
		assert(globallogic_utils::isvalidclass(self.curclass));
	#/
	self giveloadoutlevelspecific(self.team, self.curclass);
	if(level.inprematchperiod)
	{
		self val::set(#"prematch_period", "freezecontrols");
		self val::set(#"prematch_period", "disablegadgets");
		self val::set(#"prematch_period", "disable_weapons");
	}
	else if(!hadspawned && game.state == "playing")
	{
		pixbeginevent(#"sound");
		team = self.team;
		if(isdefined(self.pers[#"music"].spawn) && self.pers[#"music"].spawn == 0)
		{
			self.pers[#"music"].spawn = 1;
		}
		if(level.splitscreen)
		{
			if(isdefined(level.playedstartingmusic))
			{
				music = undefined;
			}
			else
			{
				level.playedstartingmusic = 1;
			}
		}
		pixendevent();
	}
	/#
		if(!level.splitscreen && getdvarint(#"scr_showperksonspawn", 0) == 1 && game.state != "")
		{
			pixbeginevent(#"showperksonspawn");
			if(level.perksenabled == 1)
			{
				self hud::showperks();
			}
			pixendevent();
		}
	#/
	if(isdefined(self.pers[#"momentum"]))
	{
		self.momentum = self.pers[#"momentum"];
	}
	pixendevent();
	self thread function_7455b680();
}

/*
	Name: function_7455b680
	Namespace: globallogic_spawn
	Checksum: 0xAA8AF5DC
	Offset: 0xDF0
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_7455b680()
{
	self endon(#"disconnect", #"joined_spectators");
	waittillframeend();
	self notify(#"spawned_player");
	self callback::callback(#"on_player_spawned");
	/#
		print("" + self.origin[0] + "" + self.origin[1] + "" + self.origin[2] + "");
	#/
	setdvar(#"scr_selecting_location", "");
	self zm_utility::function_e0448fec();
	if(game.state == "postgame")
	{
		/#
			assert(!level.intermission);
		#/
		self globallogic_player::freezeplayerforroundend();
	}
	self util::set_lighting_state();
	self util::set_sun_shadow_split_distance();
}

/*
	Name: spawnspectator
	Namespace: globallogic_spawn
	Checksum: 0x33EAA204
	Offset: 0xF80
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function spawnspectator(origin, angles)
{
	self notify(#"spawned");
	self notify(#"end_respawn");
	in_spawnspectator(origin, angles);
}

/*
	Name: respawn_asspectator
	Namespace: globallogic_spawn
	Checksum: 0xC981A4D6
	Offset: 0xFD8
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function respawn_asspectator(origin, angles)
{
	in_spawnspectator(origin, angles);
}

/*
	Name: in_spawnspectator
	Namespace: globallogic_spawn
	Checksum: 0xEE49E4AD
	Offset: 0x1010
	Size: 0x144
	Parameters: 2
	Flags: Linked
*/
function in_spawnspectator(origin, angles)
{
	pixmarker("BEGIN: in_spawnSpectator");
	self player::set_spawn_variables();
	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	if(self.pers[#"team"] == "spectator")
	{
		self.statusicon = "";
	}
	else
	{
		self.statusicon = "hud_status_dead";
	}
	spectating::setspectatepermissionsformachine();
	[[level.onspawnspectator]](origin, angles);
	if(level.teambased && !level.splitscreen)
	{
		self thread spectatorthirdpersonness();
	}
	pixmarker("END: in_spawnSpectator");
}

/*
	Name: spectatorthirdpersonness
	Namespace: globallogic_spawn
	Checksum: 0x1829FA8A
	Offset: 0x1160
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function spectatorthirdpersonness()
{
	self notify(#"spectator_thirdperson_thread");
	self endon(#"disconnect", #"spawned", #"spectator_thirdperson_thread");
	self.spectatingthirdperson = 0;
}

/*
	Name: forcespawn
	Namespace: globallogic_spawn
	Checksum: 0x1744176E
	Offset: 0x11C0
	Size: 0x108
	Parameters: 1
	Flags: None
*/
function forcespawn(time)
{
	self endon(#"death", #"spawned");
	if(!isdefined(time))
	{
		time = 60;
	}
	wait(time);
	if(isdefined(self.hasspawned) && self.hasspawned)
	{
		return;
	}
	if(self.pers[#"team"] == "spectator")
	{
		return;
	}
	if(!globallogic_utils::isvalidclass(self.pers[#"class"]))
	{
		self.pers[#"class"] = "CLASS_CUSTOM1";
		self.curclass = self.pers[#"class"];
	}
	self thread [[level.spawnclient]]();
}

/*
	Name: kickifdontspawn
	Namespace: globallogic_spawn
	Checksum: 0x172194D2
	Offset: 0x12D0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function kickifdontspawn()
{
	/#
		if(getdvarint(#"scr_hostmigrationtest", 0) == 1)
		{
			return;
		}
	#/
	if(self ishost())
	{
		return;
	}
	self kickifidontspawninternal();
}

/*
	Name: kickifidontspawninternal
	Namespace: globallogic_spawn
	Checksum: 0x3D26E4E5
	Offset: 0x1340
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function kickifidontspawninternal()
{
	self endon(#"death", #"spawned");
	waittime = 90;
	if(getdvarstring(#"scr_kick_time") != "")
	{
		waittime = getdvarfloat(#"scr_kick_time", 0);
	}
	mintime = 45;
	if(getdvarstring(#"scr_kick_mintime") != "")
	{
		mintime = getdvarfloat(#"scr_kick_mintime", 0);
	}
	starttime = gettime();
	kickwait(waittime);
	timepassed = gettime() - starttime / 1000;
	if(timepassed < waittime - 0.1 && timepassed < mintime)
	{
		return;
	}
	if(isdefined(self.hasspawned) && self.hasspawned)
	{
		return;
	}
	if(sessionmodeisprivate())
	{
		return;
	}
	if(self.pers[#"team"] == "spectator")
	{
		return;
	}
	kick(self getentitynumber());
}

/*
	Name: kickwait
	Namespace: globallogic_spawn
	Checksum: 0x1E44EF5A
	Offset: 0x1520
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function kickwait(waittime)
{
	level endon(#"game_ended");
	hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

/*
	Name: spawninterroundintermission
	Namespace: globallogic_spawn
	Checksum: 0x2A8C5B87
	Offset: 0x1560
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function spawninterroundintermission()
{
	self notify(#"spawned");
	self notify(#"end_respawn");
	self player::set_spawn_variables();
	self hud_message::clearlowermessage();
	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	self globallogic_defaults::default_onspawnintermission();
	self setorigin(self.origin);
	self setplayerangles(self.angles);
	self clientfield::set_to_player("player_dof_settings", 2);
}

/*
	Name: spawnintermission
	Namespace: globallogic_spawn
	Checksum: 0x23C80A69
	Offset: 0x1678
	Size: 0x244
	Parameters: 1
	Flags: Linked
*/
function spawnintermission(usedefaultcallback)
{
	self notify(#"spawned");
	self notify(#"end_respawn");
	self endon(#"disconnect");
	self player::set_spawn_variables();
	self hud_message::clearlowermessage();
	if(level.rankedmatch && util::waslastround())
	{
		if(self.postgamemilestones || self.postgamecontracts || self.postgamepromotion)
		{
			if(self.postgamepromotion)
			{
				self playlocalsound(#"mus_level_up");
			}
			else if(self.postgamecontracts)
			{
				self playlocalsound(#"mus_challenge_complete");
			}
			else if(self.postgamemilestones)
			{
				self playlocalsound(#"mus_contract_complete");
			}
			self closeingamemenu();
			while(waittime)
			{
				wait(0.25);
				waittime = waittime - 0.25;
			}
		}
	}
	self.sessionstate = "intermission";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	if(isdefined(usedefaultcallback) && usedefaultcallback)
	{
		globallogic_defaults::default_onspawnintermission();
	}
	else
	{
		[[level.onspawnintermission]]();
	}
	if(game.state != "postgame")
	{
		self clientfield::set_to_player("player_dof_settings", 2);
	}
}

/*
	Name: spawnqueuedclientonteam
	Namespace: globallogic_spawn
	Checksum: 0x3AA73825
	Offset: 0x18C8
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function spawnqueuedclientonteam(team)
{
	player_to_spawn = undefined;
	for(i = 0; i < level.deadplayers[team].size; i++)
	{
		player = level.deadplayers[team][i];
		if(player.waitingtospawn)
		{
			continue;
		}
		player_to_spawn = player;
		break;
	}
	if(isdefined(player_to_spawn))
	{
		player_to_spawn.allowqueuespawn = 1;
		player_to_spawn thread [[level.spawnclient]]();
	}
}

/*
	Name: spawnqueuedclient
	Namespace: globallogic_spawn
	Checksum: 0x41244EC7
	Offset: 0x1988
	Size: 0x130
	Parameters: 2
	Flags: None
*/
function spawnqueuedclient(dead_player_team, killer)
{
	if(!level.playerqueuedrespawn)
	{
		return;
	}
	util::waittillslowprocessallowed();
	spawn_team = undefined;
	if(isdefined(killer) && isdefined(killer.team) && isdefined(level.teams[killer.team]))
	{
		spawn_team = killer.team;
	}
	if(isdefined(spawn_team))
	{
		spawnqueuedclientonteam(spawn_team);
		return;
	}
	foreach(team, _ in level.teams)
	{
		if(team == dead_player_team)
		{
			continue;
		}
		spawnqueuedclientonteam(team);
	}
}

/*
	Name: allteamsnearscorelimit
	Namespace: globallogic_spawn
	Checksum: 0x5645F5E7
	Offset: 0x1AC0
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function allteamsnearscorelimit()
{
	if(!level.teambased)
	{
		return 0;
	}
	if(level.scorelimit <= 1)
	{
		return 0;
	}
	foreach(team, _ in level.teams)
	{
		if(!game.stat[#"teamscores"][team] >= level.scorelimit - 1)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: shouldshowrespawnmessage
	Namespace: globallogic_spawn
	Checksum: 0x193A50C5
	Offset: 0x1B90
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function shouldshowrespawnmessage()
{
	if(util::waslastround())
	{
		return 0;
	}
	if(util::isoneround())
	{
		return 0;
	}
	if(isdefined(level.livesdonotreset) && level.livesdonotreset)
	{
		return 0;
	}
	if(allteamsnearscorelimit())
	{
		return 0;
	}
	return 1;
}

/*
	Name: default_spawnmessage
	Namespace: globallogic_spawn
	Checksum: 0xE00EF763
	Offset: 0x1C08
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function default_spawnmessage()
{
	hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
}

/*
	Name: showspawnmessage
	Namespace: globallogic_spawn
	Checksum: 0x1EF6C33D
	Offset: 0x1C40
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function showspawnmessage()
{
	if(shouldshowrespawnmessage())
	{
		self thread [[level.spawnmessage]]();
	}
}

/*
	Name: spawnclient
	Namespace: globallogic_spawn
	Checksum: 0x94E9AC5C
	Offset: 0x1C70
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function spawnclient(timealreadypassed)
{
	pixbeginevent(#"spawnclient");
	/#
		assert(isdefined(self.team));
	#/
	/#
		assert(globallogic_utils::isvalidclass(self.curclass));
	#/
	if(!self mayspawn())
	{
		currentorigin = self.origin;
		currentangles = self.angles;
		self showspawnmessage();
		self thread [[level.spawnspectator]](currentorigin + vectorscale((0, 0, 1), 60), currentangles);
		pixendevent();
		return;
	}
	if(isdefined(self.waitingtospawn) && self.waitingtospawn)
	{
		pixendevent();
		return;
	}
	self.waitingtospawn = 1;
	self.allowqueuespawn = undefined;
	self waitandspawnclient(timealreadypassed);
	if(isdefined(self))
	{
		self.waitingtospawn = 0;
	}
	pixendevent();
}

/*
	Name: waitandspawnclient
	Namespace: globallogic_spawn
	Checksum: 0x45310B8C
	Offset: 0x1E10
	Size: 0x3AC
	Parameters: 1
	Flags: Linked
*/
function waitandspawnclient(timealreadypassed)
{
	self endon(#"disconnect", #"end_respawn");
	level endon(#"game_ended");
	if(!isdefined(timealreadypassed))
	{
		timealreadypassed = 0;
	}
	spawnedasspectator = 0;
	if(!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team]))
	{
		self.wavespawnindex = level.waveplayerspawnindex[self.team];
		level.waveplayerspawnindex[self.team]++;
	}
	timeuntilspawn = timeuntilspawn(0);
	if(timeuntilspawn > timealreadypassed)
	{
		timeuntilspawn = timeuntilspawn - timealreadypassed;
		timealreadypassed = 0;
	}
	else
	{
		timealreadypassed = timealreadypassed - timeuntilspawn;
		timeuntilspawn = 0;
	}
	if(timeuntilspawn > 0)
	{
		if(level.playerqueuedrespawn)
		{
			hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
		}
		else
		{
			hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
		}
		if(!spawnedasspectator)
		{
			spawnorigin = self.origin + vectorscale((0, 0, 1), 60);
			spawnangles = self.angles;
			if(isdefined(level.useintermissionpointsonwavespawn) && [[level.useintermissionpointsonwavespawn]]() == 1)
			{
				spawnpoint = spawnlogic::getrandomintermissionpoint();
				if(isdefined(spawnpoint))
				{
					spawnorigin = spawnpoint.origin;
					spawnangles = spawnpoint.angles;
				}
			}
			self thread respawn_asspectator(spawnorigin, spawnangles);
		}
		spawnedasspectator = 1;
		self globallogic_utils::waitfortimeornotify(timeuntilspawn, "force_spawn");
		self notify(#"stop_wait_safe_spawn_button");
	}
	wavebased = level.waverespawndelay > 0;
	if(!level.playerforcerespawn && self.hasspawned && !wavebased && !self.wantsafespawn && !level.playerqueuedrespawn)
	{
		hud_message::setlowermessage(game.strings[#"press_to_spawn"]);
		if(!spawnedasspectator)
		{
			self thread respawn_asspectator(self.origin + vectorscale((0, 0, 1), 60), self.angles);
		}
		spawnedasspectator = 1;
		self waitrespawnorsafespawnbutton();
	}
	self.waitingtospawn = 0;
	self.wavespawnindex = undefined;
	self.respawntimerstarttime = undefined;
	self thread [[level.spawnplayer]]();
	self hud_message::clearlowermessage();
}

/*
	Name: waitrespawnorsafespawnbutton
	Namespace: globallogic_spawn
	Checksum: 0x46867C97
	Offset: 0x21C8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function waitrespawnorsafespawnbutton()
{
	self endon(#"disconnect", #"end_respawn");
	while(true)
	{
		if(self usebuttonpressed())
		{
			break;
		}
		waitframe(1);
	}
}

/*
	Name: waitinspawnqueue
	Namespace: globallogic_spawn
	Checksum: 0xB6766703
	Offset: 0x2228
	Size: 0xB2
	Parameters: 0
	Flags: None
*/
function waitinspawnqueue()
{
	self endon(#"disconnect", #"end_respawn");
	if(!level.ingraceperiod && !level.usestartspawns)
	{
		currentorigin = self.origin;
		currentangles = self.angles;
		self thread [[level.spawnspectator]](currentorigin + vectorscale((0, 0, 1), 60), currentangles);
		self waittill(#"queue_respawn");
	}
}

/*
	Name: setthirdperson
	Namespace: globallogic_spawn
	Checksum: 0xAFDEA64D
	Offset: 0x22E8
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function setthirdperson(value)
{
	if(!level.console)
	{
		return;
	}
	if(!isdefined(self.spectatingthirdperson) || value != self.spectatingthirdperson)
	{
		self.spectatingthirdperson = value;
		if(value)
		{
			self setclientthirdperson(1);
			self clientfield::set_to_player("player_dof_settings", 2);
		}
		else
		{
			self setclientthirdperson(0);
			self clientfield::set_to_player("player_dof_settings", 1);
		}
		self resetfov();
	}
}

