// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_16f6e32fce786c0d;
#using script_47fb62300ac0bd60;
#using script_70a43d6ba27cff6a;
#using scripts\core_common\bb_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\healthoverlay.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\hud_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\persistence_shared.gsc;
#using scripts\core_common\popups_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\simple_hostmigration.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\tweakables_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\gametypes\dev.gsc;
#using scripts\zm_common\gametypes\globallogic_audio.gsc;
#using scripts\zm_common\gametypes\globallogic_defaults.gsc;
#using scripts\zm_common\gametypes\globallogic_player.gsc;
#using scripts\zm_common\gametypes\globallogic_score.gsc;
#using scripts\zm_common\gametypes\globallogic_spawn.gsc;
#using scripts\zm_common\gametypes\globallogic_ui.gsc;
#using scripts\zm_common\gametypes\globallogic_utils.gsc;
#using scripts\zm_common\gametypes\hostmigration.gsc;
#using scripts\zm_common\gametypes\hud_message.gsc;
#using scripts\zm_common\gametypes\spawnlogic.gsc;
#using scripts\zm_common\rat.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace globallogic;

/*
	Name: function_89f2df9
	Namespace: globallogic
	Checksum: 0x26364FE0
	Offset: 0x450
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"globallogic", &__init__, undefined, #"visionset_mgr");
}

/*
	Name: __init__
	Namespace: globallogic
	Checksum: 0x4B7F67D2
	Offset: 0x4A0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	visionset_mgr::register_info("visionset", "crithealth", 1, 4, 25, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
}

/*
	Name: init
	Namespace: globallogic
	Checksum: 0x76196A6B
	Offset: 0x4F0
	Size: 0x8BE
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.language = getdvarstring(#"language");
	level.splitscreen = issplitscreen();
	level.xenon = getdvarstring(#"xenongame") == "true";
	level.ps3 = getdvarstring(#"ps3game") == "true";
	level.wiiu = getdvarstring(#"wiiugame") == "true";
	level.orbis = getdvarstring(#"orbisgame") == "true";
	level.durango = getdvarstring(#"durangogame") == "true";
	level.createfx_disable_fx = getdvarint(#"disable_fx", 0) == 1;
	level.onlinegame = sessionmodeisonlinegame();
	level.systemlink = sessionmodeissystemlink();
	level.console = level.xenon || level.ps3 || level.wiiu || level.orbis || level.durango;
	level.rankedmatch = gamemodeisusingxp();
	level.leaguematch = 0;
	level.arenamatch = 0;
	level.contractsenabled = !getgametypesetting(#"disablecontracts");
	level.contractsenabled = 0;
	level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
	/#
		if(getdvarint(#"scr_forcerankedmatch", 0) == 1)
		{
			level.rankedmatch = 1;
		}
	#/
	level.script = util::function_53bbf9d2();
	level.gametype = util::function_5df4294();
	level.var_837aa533 = hash(level.gametype);
	level.teambased = 0;
	level.teamcount = 1;
	level.multiteam = level.teamcount > 2;
	if(sessionmodeiszombiesgame())
	{
		level.zombie_team_index = level.teamcount + 1;
		if(2 == level.zombie_team_index)
		{
			level.zombie_team = #"axis";
		}
		else
		{
			level.zombie_team = "team" + level.zombie_team_index;
		}
	}
	level.teams = [];
	level.teamindex = [];
	teamcount = level.teamcount;
	level.teams[#"allies"] = "allies";
	level.teams[#"axis"] = "axis";
	level.teamindex[#"neutral"] = 0;
	level.teamindex[#"allies"] = 1;
	level.teamindex[#"axis"] = 2;
	for(teamindex = 3; teamindex <= teamcount; teamindex++)
	{
		level.teams[hash("team" + teamindex)] = "team" + teamindex;
		level.teamindex[hash("team" + teamindex)] = teamindex;
	}
	level.overrideteamscore = 0;
	level.overrideplayerscore = 0;
	level.displayhalftimetext = 0;
	level.displayroundendtext = 1;
	level.endgameonscorelimit = 1;
	level.endgameontimelimit = 1;
	level.scoreroundwinbased = 0;
	level.resetplayerscoreeveryround = 0;
	level.gameforfeited = 0;
	level.forceautoassign = 0;
	level.halftimetype = "halftime";
	level.halftimesubcaption = #"hash_54b0f0ec952ddba8";
	level.laststatustime = 0;
	level.waswinning = [];
	level.lastslowprocessframe = 0;
	level.placement = [];
	foreach(team, _ in level.teams)
	{
		level.placement[team] = [];
	}
	level.placement[#"all"] = [];
	level.postroundtime = 7;
	level.inovertime = 0;
	level.defaultoffenseradius = 560;
	level.dropteam = getdvarint(#"sv_maxclients", 0);
	level.infinalkillcam = 0;
	registerdvars();
	level.oldschool = getdvarint(#"scr_oldschool", 0);
	if(level.oldschool)
	{
		/#
			print("");
		#/
		setdvar(#"jump_height", 64);
		setdvar(#"jump_slowdownenable", 0);
		setdvar(#"bg_falldamageminheight", 256);
		setdvar(#"bg_falldamagemaxheight", 512);
		setdvar(#"player_clipsizemultiplier", 2);
	}
	if(!isdefined(game.tiebreaker))
	{
		game.tiebreaker = 0;
	}
	if(!isdefined(game.stat))
	{
		game.stat = [];
	}
	level.figure_out_attacker = &globallogic_player::figureoutattacker;
	level.figure_out_friendly_fire = &globallogic_player::figureoutfriendlyfire;
}

/*
	Name: registerdvars
	Namespace: globallogic
	Checksum: 0x771059DE
	Offset: 0xDB8
	Size: 0x1AE
	Parameters: 0
	Flags: Linked
*/
function registerdvars()
{
	if(!isdefined(getdvar(#"scr_oldschool")))
	{
		setdvar(#"scr_oldschool", 0);
	}
	if(!isdefined(getdvar(#"ui_guncycle")))
	{
		setdvar(#"ui_guncycle", 0);
	}
	if(!isdefined(getdvar(#"ui_weapon_tiers")))
	{
		setdvar(#"ui_weapon_tiers", 0);
	}
	setdvar(#"ui_text_endreason", "");
	setmatchflag("bomb_timer", 0);
	level.vehicledamagescalar = getdvarfloat(#"scr_vehicle_damage_scalar", 1);
	level.fire_audio_repeat_duration = getdvarint(#"fire_audio_repeat_duration", 0);
	level.fire_audio_random_max_duration = getdvarint(#"fire_audio_random_max_duration", 0);
}

/*
	Name: blank
	Namespace: globallogic
	Checksum: 0x7DE50794
	Offset: 0xF70
	Size: 0x54
	Parameters: 10
	Flags: Linked
*/
function blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
{
}

/*
	Name: setupcallbacks
	Namespace: globallogic
	Checksum: 0xDBB63D6E
	Offset: 0xFD0
	Size: 0x42E
	Parameters: 0
	Flags: None
*/
function setupcallbacks()
{
	level.spawnplayer = &globallogic_spawn::spawnplayer;
	level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
	level.spawnclient = &globallogic_spawn::spawnclient;
	level.spawnspectator = &globallogic_spawn::spawnspectator;
	level.spawnintermission = &globallogic_spawn::spawnintermission;
	level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
	level.onplayerscore = &globallogic_score::default_onplayerscore;
	level.wavespawntimer = &wavespawntimer;
	level.spawnmessage = &globallogic_spawn::default_spawnmessage;
	level.onspawnplayer = &blank;
	level.onspawnplayerunified = &blank;
	level.onspawnspectator = &globallogic_defaults::default_onspawnspectator;
	level.onspawnintermission = &globallogic_defaults::default_onspawnintermission;
	level.onrespawndelay = &blank;
	level.onforfeit = &globallogic_defaults::default_onforfeit;
	level.ontimelimit = &globallogic_defaults::default_ontimelimit;
	level.onscorelimit = &globallogic_defaults::default_onscorelimit;
	level.onalivecountchange = &globallogic_defaults::default_onalivecountchange;
	level.ondeadevent = &globallogic_defaults::default_ondeadevent;
	level.ononeleftevent = &globallogic_defaults::default_ononeleftevent;
	level.giveteamscore = &globallogic_score::giveteamscore;
	level.onlastteamaliveevent = undefined;
	level.gettimepassed = &globallogic_utils::gettimepassed;
	level.gettimelimit = &globallogic_defaults::default_gettimelimit;
	level.getteamkillpenalty = &blank;
	level.getteamkillscore = &blank;
	level.iskillboosting = &globallogic_score::default_iskillboosting;
	level._setteamscore = &globallogic_score::_setteamscore;
	level._setplayerscore = &globallogic_score::_setplayerscore;
	level._getteamscore = &globallogic_score::_getteamscore;
	level._getplayerscore = &globallogic_score::_getplayerscore;
	level.onprecachegametype = &blank;
	level.onstartgametype = &blank;
	level.onplayerconnect = &blank;
	level.onplayerdisconnect = &blank;
	level.onplayerdamage = &blank;
	level.onplayerkilled = &blank;
	level.onplayerkilledextraunthreadedcbs = [];
	level.onteamoutcomenotify = &blank;
	level.onoutcomenotify = &blank;
	level.onendgame = &blank;
	level.onroundendgame = &globallogic_defaults::default_onroundendgame;
	level.onmedalawarded = &blank;
	level.dogmanagerongetdogs = &blank;
	level.var_fc5ef179 = &blank;
}

/*
	Name: compareteambygamestat
	Namespace: globallogic
	Checksum: 0x4968A130
	Offset: 0x1408
	Size: 0x106
	Parameters: 4
	Flags: Linked
*/
function compareteambygamestat(gamestat, teama, teamb, previous_winner_score)
{
	winner = undefined;
	if(teama == "tie")
	{
		winner = #"tie";
		if(previous_winner_score < game.stat[gamestat][teamb])
		{
			winner = teamb;
		}
	}
	else if(game.stat[gamestat][teama] == game.stat[gamestat][teamb])
	{
		winner = #"tie";
	}
	else if(game.stat[gamestat][teamb] > game.stat[gamestat][teama])
	{
		winner = teamb;
	}
	else
	{
		winner = teama;
	}
	return winner;
}

/*
	Name: determineteamwinnerbygamestat
	Namespace: globallogic
	Checksum: 0xDD392CBB
	Offset: 0x1518
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function determineteamwinnerbygamestat(gamestat)
{
	teamkeys = getarraykeys(level.teams);
	winner = teamkeys[0];
	previous_winner_score = game.stat[gamestat][winner];
	for(teamindex = 1; teamindex < teamkeys.size; teamindex++)
	{
		winner = compareteambygamestat(gamestat, winner, teamkeys[teamindex], previous_winner_score);
		if(winner != "tie")
		{
			previous_winner_score = game.stat[gamestat][winner];
		}
	}
	return winner;
}

/*
	Name: compareteambyteamscore
	Namespace: globallogic
	Checksum: 0xFEB5E38B
	Offset: 0x1600
	Size: 0xDA
	Parameters: 3
	Flags: Linked
*/
function compareteambyteamscore(teama, teamb, previous_winner_score)
{
	winner = undefined;
	teambscore = [[level._getteamscore]](teamb);
	if(teama == "tie")
	{
		winner = "tie";
		if(previous_winner_score < teambscore)
		{
			winner = teamb;
		}
		return winner;
	}
	teamascore = [[level._getteamscore]](teama);
	if(teambscore == teamascore)
	{
		winner = "tie";
	}
	else if(teambscore > teamascore)
	{
		winner = teamb;
	}
	else
	{
		winner = teama;
	}
	return winner;
}

/*
	Name: determineteamwinnerbyteamscore
	Namespace: globallogic
	Checksum: 0x51878A2B
	Offset: 0x16E8
	Size: 0xCC
	Parameters: 0
	Flags: None
*/
function determineteamwinnerbyteamscore()
{
	teamkeys = getarraykeys(level.teams);
	winner = teamkeys[0];
	previous_winner_score = [[level._getteamscore]](winner);
	for(teamindex = 1; teamindex < teamkeys.size; teamindex++)
	{
		winner = compareteambyteamscore(winner, teamkeys[teamindex], previous_winner_score);
		if(winner != "tie")
		{
			previous_winner_score = [[level._getteamscore]](winner);
		}
	}
	return winner;
}

/*
	Name: forceend
	Namespace: globallogic
	Checksum: 0x408AF8B0
	Offset: 0x17C0
	Size: 0x1CC
	Parameters: 1
	Flags: Linked
*/
function forceend(hostsucks = 0)
{
	if(level.hostforcedend || level.forcedend)
	{
		return;
	}
	winner = undefined;
	if(level.teambased)
	{
		winner = determineteamwinnerbygamestat("teamScores");
		globallogic_utils::logteamwinstring("host ended game", winner);
	}
	else
	{
		winner = globallogic_score::gethighestscoringplayer();
		/#
			if(isdefined(winner))
			{
				print("" + winner.name);
			}
			else
			{
				print("");
			}
		#/
	}
	level.forcedend = 1;
	level.hostforcedend = 1;
	if(hostsucks)
	{
		endstring = #"hash_115339e33ac1efcb";
	}
	else if(level.splitscreen)
	{
		endstring = #"hash_4f9682270c82e8f6";
	}
	else
	{
		endstring = #"hash_cd63faed592da03";
	}
	setmatchflag("disableIngameMenu", 1);
	setdvar(#"ui_text_endreason", endstring);
	thread endgame(winner, endstring);
}

/*
	Name: killserverpc
	Namespace: globallogic
	Checksum: 0xB84EC3EE
	Offset: 0x1998
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function killserverpc()
{
	if(level.hostforcedend || level.forcedend)
	{
		return;
	}
	winner = undefined;
	if(level.teambased)
	{
		winner = determineteamwinnerbygamestat("teamScores");
		globallogic_utils::logteamwinstring("host ended game", winner);
	}
	else
	{
		winner = globallogic_score::gethighestscoringplayer();
		/#
			if(isdefined(winner))
			{
				print("" + winner.name);
			}
			else
			{
				print("");
			}
		#/
	}
	level.forcedend = 1;
	level.hostforcedend = 1;
	level.killserver = 1;
	endstring = #"hash_cd63faed592da03";
	/#
		println("");
	#/
	thread endgame(winner, endstring);
}

/*
	Name: someoneoneachteam
	Namespace: globallogic
	Checksum: 0x64A9105
	Offset: 0x1B08
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function someoneoneachteam()
{
	foreach(team, _ in level.teams)
	{
		if(level.playercount[team] == 0)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: checkifteamforfeits
	Namespace: globallogic
	Checksum: 0xD76CC7A2
	Offset: 0x1B98
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function checkifteamforfeits(team)
{
	if(!level.everexisted[team])
	{
		return 0;
	}
	if(level.playercount[team] < 1 && util::totalplayercount() > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: checkforanyteamforfeit
	Namespace: globallogic
	Checksum: 0x37C0CC24
	Offset: 0x1C08
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function checkforanyteamforfeit()
{
	foreach(team, _ in level.teams)
	{
		if(checkifteamforfeits(team))
		{
			thread [[level.onforfeit]](team);
			return 1;
		}
	}
	return 0;
}

/*
	Name: dospawnqueueupdates
	Namespace: globallogic
	Checksum: 0x5FC815F1
	Offset: 0x1CB0
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function dospawnqueueupdates()
{
	foreach(team, _ in level.teams)
	{
		if(level.spawnqueuemodified[team])
		{
			[[level.onalivecountchange]](team);
		}
	}
}

/*
	Name: isteamalldead
	Namespace: globallogic
	Checksum: 0x55782F20
	Offset: 0x1D48
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function isteamalldead(team)
{
	return level.everexisted[team] && !level.alivecount[team] && !level.playerlives[team];
}

/*
	Name: areallteamsdead
	Namespace: globallogic
	Checksum: 0xDBB02D72
	Offset: 0x1DA0
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function areallteamsdead()
{
	foreach(team, _ in level.teams)
	{
		if(!isteamalldead(team))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: alldeadteamcount
	Namespace: globallogic
	Checksum: 0x7B9A977A
	Offset: 0x1E38
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function alldeadteamcount()
{
	count = 0;
	foreach(team, _ in level.teams)
	{
		if(isteamalldead(team))
		{
			count++;
		}
	}
	return count;
}

/*
	Name: dodeadeventupdates
	Namespace: globallogic
	Checksum: 0x6368F4C
	Offset: 0x1ED8
	Size: 0x1F8
	Parameters: 0
	Flags: Linked
*/
function dodeadeventupdates()
{
	if(level.teambased)
	{
		if(areallteamsdead())
		{
			[[level.ondeadevent]]("all");
			return 1;
		}
		if(isdefined(level.onlastteamaliveevent))
		{
			if(alldeadteamcount() == level.teams.size - 1)
			{
				foreach(team, _ in level.teams)
				{
					if(!isteamalldead(team))
					{
						[[level.onlastteamaliveevent]](team);
						return 1;
					}
				}
			}
		}
		else
		{
			foreach(team, _ in level.teams)
			{
				if(isteamalldead(team))
				{
					[[level.ondeadevent]](team);
					return 1;
				}
			}
		}
	}
	else if(totalalivecount() == 0 && totalplayerlives() == 0 && level.maxplayercount > 1)
	{
		[[level.ondeadevent]]("all");
		return 1;
	}
	return 0;
}

/*
	Name: isonlyoneleftaliveonteam
	Namespace: globallogic
	Checksum: 0xBD5D47A5
	Offset: 0x20D8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function isonlyoneleftaliveonteam(team)
{
	return level.lastalivecount[team] > 1 && level.alivecount[team] == 1 && level.playerlives[team] == 1;
}

/*
	Name: doonelefteventupdates
	Namespace: globallogic
	Checksum: 0x5DD70034
	Offset: 0x2138
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function doonelefteventupdates()
{
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			if(isonlyoneleftaliveonteam(team))
			{
				[[level.ononeleftevent]](team);
				return 1;
			}
		}
	}
	else if(totalalivecount() == 1 && totalplayerlives() == 1 && level.maxplayercount > 1)
	{
		[[level.ononeleftevent]]("all");
		return 1;
	}
	return 0;
}

/*
	Name: updategameevents
	Namespace: globallogic
	Checksum: 0x4862B4FE
	Offset: 0x2250
	Size: 0x208
	Parameters: 0
	Flags: Linked
*/
function updategameevents()
{
	/#
		if(getdvarint(#"scr_hostmigrationtest", 0) == 1)
		{
			return;
		}
	#/
	if(level.rankedmatch || level.leaguematch && !level.ingraceperiod)
	{
		if(level.teambased)
		{
			if(!level.gameforfeited)
			{
				if(game.state == "playing" && checkforanyteamforfeit())
				{
					return;
				}
			}
			else if(someoneoneachteam())
			{
				level.gameforfeited = 0;
				level notify(#"hash_39a00a79045884ca");
			}
		}
		else if(!level.gameforfeited)
		{
			if(util::totalplayercount() == 1 && level.maxplayercount > 1)
			{
				thread [[level.onforfeit]]();
				return;
			}
		}
		else if(util::totalplayercount() > 1)
		{
			level.gameforfeited = 0;
			level notify(#"hash_39a00a79045884ca");
		}
	}
	if(!level.playerqueuedrespawn && !level.numlives && !level.inovertime)
	{
		return;
	}
	if(level.ingraceperiod)
	{
		return;
	}
	if(level.playerqueuedrespawn)
	{
		dospawnqueueupdates();
	}
	if(dodeadeventupdates())
	{
		return;
	}
	if(doonelefteventupdates())
	{
		return;
	}
}

/*
	Name: matchstarttimer
	Namespace: globallogic
	Checksum: 0x9AD71D74
	Offset: 0x2460
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function matchstarttimer()
{
	waitforplayers();
	counttime = int(level.prematchperiod);
	var_5654073f = counttime >= 2;
	luinotifyevent(#"create_prematch_timer", 2, gettime() + int(counttime * 1000), var_5654073f);
	if(var_5654073f)
	{
		while(counttime > 0 && !level.gameended)
		{
			if(counttime == 2)
			{
				visionsetnaked("default", 3);
			}
			counttime--;
			wait(1);
		}
	}
	else
	{
		visionsetnaked("default", 1);
	}
	luinotifyevent(#"prematch_timer_ended", 1, var_5654073f);
}

/*
	Name: matchstarttimerskip
	Namespace: globallogic
	Checksum: 0xEBC91704
	Offset: 0x25B8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function matchstarttimerskip()
{
	visionsetnaked("default", 0);
}

/*
	Name: notifyteamwavespawn
	Namespace: globallogic
	Checksum: 0x89272693
	Offset: 0x25E0
	Size: 0x82
	Parameters: 2
	Flags: Linked
*/
function notifyteamwavespawn(team, time)
{
	if(time - level.lastwave[team] > level.wavedelay[team] * 1000)
	{
		level notify("wave_respawn_" + team);
		level.lastwave[team] = time;
		level.waveplayerspawnindex[team] = 0;
	}
}

/*
	Name: wavespawntimer
	Namespace: globallogic
	Checksum: 0xCB4C48CF
	Offset: 0x2670
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function wavespawntimer()
{
	level endon(#"game_ended");
	while(game.state == "playing")
	{
		time = gettime();
		foreach(team, _ in level.teams)
		{
			notifyteamwavespawn(team, time);
		}
		waitframe(1);
	}
}

/*
	Name: hostidledout
	Namespace: globallogic
	Checksum: 0xDFFB3407
	Offset: 0x2740
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function hostidledout()
{
	hostplayer = util::gethostplayer();
	/#
		if(getdvarint(#"scr_writeconfigstrings", 0) == 1 || getdvarint(#"scr_hostmigrationtest", 0) == 1)
		{
			return 0;
		}
	#/
	if(isdefined(hostplayer) && (!(isdefined(hostplayer.hasspawned) && hostplayer.hasspawned)) && !isdefined(hostplayer.selectedclass))
	{
		return 1;
	}
	return 0;
}

/*
	Name: incrementmatchcompletionstat
	Namespace: globallogic
	Checksum: 0xB194C140
	Offset: 0x2810
	Size: 0x5C
	Parameters: 3
	Flags: Linked
*/
function incrementmatchcompletionstat(gamemode, playedorhosted, stat)
{
	self stats::inc_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

/*
	Name: setmatchcompletionstat
	Namespace: globallogic
	Checksum: 0xEAB7C88C
	Offset: 0x2878
	Size: 0x5C
	Parameters: 3
	Flags: None
*/
function setmatchcompletionstat(gamemode, playedorhosted, stat)
{
	self stats::set_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

/*
	Name: getendreasontext
	Namespace: globallogic
	Checksum: 0x1C00E724
	Offset: 0x28E0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function getendreasontext()
{
	if(util::hitroundlimit() || util::hitroundwinlimit())
	{
		return game.strings[#"round_limit_reached"];
	}
	if(util::hitscorelimit())
	{
		return game.strings[#"score_limit_reached"];
	}
	if(level.forcedend)
	{
		if(level.hostforcedend)
		{
			return #"hash_cd63faed592da03";
		}
		return #"hash_4f9682270c82e8f6";
	}
	return game.strings[#"time_limit_reached"];
}

/*
	Name: resetoutcomeforallplayers
	Namespace: globallogic
	Checksum: 0x84A0C502
	Offset: 0x29B0
	Size: 0x6A
	Parameters: 0
	Flags: None
*/
function resetoutcomeforallplayers()
{
	players = level.players;
	for(index = 0; index < players.size; index++)
	{
		player = players[index];
		player notify(#"reset_outcome");
	}
}

/*
	Name: getgamelength
	Namespace: globallogic
	Checksum: 0xFBA296A0
	Offset: 0x2A28
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function getgamelength()
{
	if(!level.timelimit || level.forcedend)
	{
		gamelength = globallogic_utils::gettimepassed() / 1000;
		gamelength = min(gamelength, 1200);
	}
	else
	{
		gamelength = level.timelimit * 60;
	}
	return gamelength;
}

/*
	Name: gamehistoryplayerquit
	Namespace: globallogic
	Checksum: 0xB863B6C9
	Offset: 0x2AA8
	Size: 0x14A
	Parameters: 0
	Flags: Linked
*/
function gamehistoryplayerquit()
{
	if(!gamemodeismode(0))
	{
		return;
	}
	teamscoreratio = 0;
	self gamehistoryfinishmatch(3, 0, 0, 0, 0, teamscoreratio);
	if(isdefined(self.pers[#"matchesplayedstatstracked"]))
	{
		gamemode = util::getcurrentgamemode();
		self incrementmatchcompletionstat(gamemode, "played", "quit");
		if(isdefined(self.pers[#"matcheshostedstatstracked"]))
		{
			self incrementmatchcompletionstat(gamemode, "hosted", "quit");
			self.pers[#"matcheshostedstatstracked"] = undefined;
		}
		self.pers[#"matchesplayedstatstracked"] = undefined;
	}
	uploadstats(self);
	wait(1);
}

/*
	Name: function_6c8d7c31
	Namespace: globallogic
	Checksum: 0xA83698FB
	Offset: 0x2C00
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_6c8d7c31(winner)
{
	players = level.players;
	for(index = 0; index < players.size; index++)
	{
		globallogic_player::function_7314957c(players[index], winner);
	}
}

/*
	Name: endgame
	Namespace: globallogic
	Checksum: 0x5EEB3025
	Offset: 0x2C70
	Size: 0x85C
	Parameters: 2
	Flags: Linked
*/
function endgame(winner, endreasontext)
{
	if(game.state == "postgame" || level.gameended)
	{
		return;
	}
	if(isdefined(level.onendgame))
	{
		[[level.onendgame]](winner);
	}
	if(!isdefined(level.disableoutrovisionset) || level.disableoutrovisionset == 0)
	{
		if(sessionmodeiszombiesgame() && level.forcedend)
		{
			visionsetnaked("zombie_last_stand", 2);
		}
		else
		{
			visionsetnaked("mpOutro", 2);
		}
	}
	setmatchflag("cg_drawSpectatorMessages", 0);
	setmatchflag("game_ended", 1);
	game.state = "postgame";
	level.gameendtime = gettime();
	level.gameended = 1;
	setdvar(#"g_gameended", 1);
	level.ingraceperiod = 0;
	level notify(#"game_ended");
	level.allowbattlechatter[#"bc"] = 0;
	if(!isdefined(game.overtime_round) || util::waslastround())
	{
		game.roundsplayed++;
		game.roundwinner[game.roundsplayed] = winner;
		if(level.teambased)
		{
			game.stat[#"roundswon"][winner]++;
		}
	}
	if(isdefined(winner) && isdefined(level.teams[winner]))
	{
		level.finalkillcam_winner = winner;
	}
	else
	{
		level.finalkillcam_winner = "none";
	}
	setgameendtime(0);
	updateplacement();
	updaterankedmatch(winner);
	players = level.players;
	newtime = gettime();
	gamelength = getgamelength();
	setmatchtalkflag("EveryoneHearsEveryone", 1);
	bbgameover = 0;
	if(util::isoneround() || util::waslastround())
	{
		bbgameover = 1;
		if(level.teambased)
		{
			if(winner == "tie")
			{
				recordgameresult(#"draw");
			}
			else
			{
				recordgameresult(winner);
			}
		}
		else if(!isdefined(winner))
		{
			recordgameresult(#"draw");
		}
		else
		{
			recordgameresult(winner.team);
		}
	}
	for(index = 0; index < players.size; index++)
	{
		player = players[index];
		player globallogic_player::freezeplayerforroundend();
		player thread roundenddof(4);
		player zm_weapons::updateweapontimingszm(newtime);
		player bbplayermatchend(gamelength, endreasontext, bbgameover);
		clientnum = player getentitynumber();
		player stats::set_stat(#"afteractionreportstats", #"clientnum", clientnum);
		if(level.rankedmatch || level.leaguematch && !player issplitscreen())
		{
			if(isdefined(player.setpromotion))
			{
				player stats::set_stat(#"afteractionreportstats", #"lobbypopup", #"promotion");
				continue;
			}
			player stats::set_stat(#"afteractionreportstats", #"lobbypopup", #"summary");
		}
	}
	music::setmusicstate("SILENT");
	thread challenges::roundend(winner);
	function_6c8d7c31(winner);
	globallogic_player::recordactiveplayersendgamematchrecordstats();
	if(!util::isoneround())
	{
		if(isdefined(level.onroundendgame))
		{
			winner = [[level.onroundendgame]](winner);
		}
		endreasontext = getendreasontext();
	}
	skillupdate(winner, level.teambased);
	thread challenges::gameend(winner);
	if(util::isoneround())
	{
		globallogic_utils::executepostroundevents();
	}
	level.intermission = 1;
	setmatchtalkflag("EveryoneHearsEveryone", 1);
	stopdemorecording();
	players = level.players;
	for(index = 0; index < players.size; index++)
	{
		player = players[index];
		recordplayerstats(player, "present_at_end", 1);
		player closeingamemenu();
		player notify(#"reset_outcome");
		player thread [[level.spawnintermission]]();
		player setclientuivisibilityflag("hud_visible", 1);
		player setclientuivisibilityflag("weapon_hud_visible", 1);
	}
	level notify(#"sfade");
	/#
		print("");
	#/
	if(!isdefined(level.skipgameend) || !level.skipgameend)
	{
		wait(5);
	}
	exitlevel(0);
}

/*
	Name: bbplayermatchend
	Namespace: globallogic
	Checksum: 0xB9C9E236
	Offset: 0x34D8
	Size: 0xC6
	Parameters: 3
	Flags: Linked
*/
function bbplayermatchend(gamelength, endreasonstring, gameover)
{
	playerrank = getplacementforplayer(self);
	totaltimeplayed = 0;
	if(isdefined(self.timeplayed) && isdefined(self.timeplayed[#"total"]))
	{
		totaltimeplayed = self.timeplayed[#"total"];
		if(totaltimeplayed > gamelength)
		{
			totaltimeplayed = gamelength;
		}
	}
	xuid = self getxuid();
}

/*
	Name: roundendwait
	Namespace: globallogic
	Checksum: 0x96025B74
	Offset: 0x35A8
	Size: 0x78
	Parameters: 2
	Flags: None
*/
function roundendwait(defaultdelay, matchbonus)
{
	if(!matchbonus)
	{
		wait(defaultdelay);
		level notify(#"round_end_done");
		return;
	}
	wait(defaultdelay / 2);
	level notify(#"give_match_bonus");
	wait(defaultdelay / 2);
	level notify(#"round_end_done");
}

/*
	Name: roundenddof
	Namespace: globallogic
	Checksum: 0xF16D2F6D
	Offset: 0x3628
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function roundenddof(time)
{
	self clientfield::set_to_player("player_dof_settings", 2);
}

/*
	Name: checktimelimit
	Namespace: globallogic
	Checksum: 0xCFCD6EF4
	Offset: 0x3660
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function checktimelimit()
{
	if(isdefined(level.timelimitoverride) && level.timelimitoverride)
	{
		return;
	}
	if(game.state != "playing")
	{
		setgameendtime(0);
		return;
	}
	if(level.timelimit <= 0)
	{
		setgameendtime(0);
		return;
	}
	if(level.inprematchperiod)
	{
		setgameendtime(0);
		return;
	}
	if(level.timerstopped)
	{
		setgameendtime(0);
		return;
	}
	if(!isdefined(level.starttime))
	{
		return;
	}
	timeleft = globallogic_utils::gettimeremaining();
	setgameendtime(gettime() + int(timeleft));
	if(timeleft > 0)
	{
		return;
	}
	[[level.ontimelimit]]();
}

/*
	Name: allteamsunderscorelimit
	Namespace: globallogic
	Checksum: 0x8A207CDF
	Offset: 0x3798
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function allteamsunderscorelimit()
{
	foreach(team, _ in level.teams)
	{
		if(game.stat[#"teamscores"][team] >= level.scorelimit)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: checkscorelimit
	Namespace: globallogic
	Checksum: 0x679AA6C2
	Offset: 0x3838
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function checkscorelimit()
{
	if(game.state != "playing")
	{
		return 0;
	}
	if(level.scorelimit <= 0)
	{
		return 0;
	}
	if(level.teambased)
	{
		if(allteamsunderscorelimit())
		{
			return 0;
		}
	}
	else if(!isplayer(self))
	{
		return 0;
	}
	if(self.score < level.scorelimit)
	{
		return 0;
	}
	[[level.onscorelimit]]();
}

/*
	Name: updategametypedvars
	Namespace: globallogic
	Checksum: 0x6F903CBD
	Offset: 0x38E8
	Size: 0x23A
	Parameters: 0
	Flags: Linked
*/
function updategametypedvars()
{
	level endon(#"game_ended");
	while(game.state == "playing")
	{
		roundlimit = math::clamp(getgametypesetting(#"roundlimit"), level.roundlimitmin, level.roundlimitmax);
		if(roundlimit != level.roundlimit)
		{
			level.roundlimit = roundlimit;
			level notify(#"update_roundlimit");
		}
		timelimit = [[level.gettimelimit]]();
		if(timelimit != level.timelimit)
		{
			level.timelimit = timelimit;
			setdvar(#"ui_timelimit", level.timelimit);
			level notify(#"update_timelimit");
		}
		thread checktimelimit();
		scorelimit = math::clamp(getgametypesetting(#"scorelimit"), level.scorelimitmin, level.scorelimitmax);
		if(scorelimit != level.scorelimit)
		{
			level.scorelimit = scorelimit;
			setdvar(#"ui_scorelimit", level.scorelimit);
			level notify(#"update_scorelimit");
		}
		thread checkscorelimit();
		if(isdefined(level.starttime))
		{
			if(globallogic_utils::gettimeremaining() < 3000)
			{
				wait(0.1);
				continue;
			}
		}
		wait(1);
	}
}

/*
	Name: removedisconnectedplayerfromplacement
	Namespace: globallogic
	Checksum: 0x4C9644B6
	Offset: 0x3B30
	Size: 0x202
	Parameters: 0
	Flags: Linked
*/
function removedisconnectedplayerfromplacement()
{
	offset = 0;
	numplayers = level.placement[#"all"].size;
	found = 0;
	for(i = 0; i < numplayers; i++)
	{
		if(level.placement[#"all"][i] == self)
		{
			found = 1;
		}
		if(found)
		{
			level.placement[#"all"][i] = level.placement[#"all"][i + 1];
		}
	}
	if(!found)
	{
		return;
	}
	level.placement[#"all"][numplayers - 1] = undefined;
	/#
		assert(level.placement[#"all"].size == numplayers - 1);
	#/
	/#
		globallogic_utils::assertproperplacement();
	#/
	updateteamplacement();
	if(level.teambased)
	{
		return;
	}
	numplayers = level.placement[#"all"].size;
	for(i = 0; i < numplayers; i++)
	{
		player = level.placement[#"all"][i];
		player notify(#"update_outcome");
	}
}

/*
	Name: updateplacement
	Namespace: globallogic
	Checksum: 0x920C8016
	Offset: 0x3D40
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function updateplacement()
{
	if(!level.players.size)
	{
		return;
	}
	level.placement[#"all"] = [];
	foreach(player in level.players)
	{
		if(!level.teambased || isdefined(level.teams[player.team]))
		{
			level.placement[#"all"][level.placement[#"all"].size] = player;
		}
	}
	placementall = level.placement[#"all"];
	for(i = 1; i < placementall.size; i++)
	{
		player = placementall[i];
		playerscore = player.score;
		for(j = i - 1; j >= 0 && (playerscore > placementall[j].score || (playerscore == placementall[j].score && player.deaths < placementall[j].deaths)); j--)
		{
			placementall[j + 1] = placementall[j];
		}
		placementall[j + 1] = player;
	}
	level.placement[#"all"] = placementall;
	/#
		globallogic_utils::assertproperplacement();
	#/
	updateteamplacement();
}

/*
	Name: updateteamplacement
	Namespace: globallogic
	Checksum: 0x2A79C2DC
	Offset: 0x3FB8
	Size: 0x1BE
	Parameters: 0
	Flags: Linked
*/
function updateteamplacement()
{
	foreach(team, _ in level.teams)
	{
		placement[team] = [];
	}
	placement[#"spectator"] = [];
	if(!level.teambased)
	{
		return;
	}
	placementall = level.placement[#"all"];
	placementallsize = placementall.size;
	for(i = 0; i < placementallsize; i++)
	{
		player = placementall[i];
		if(isdefined(player))
		{
			team = player.pers[#"team"];
			placement[team][placement[team].size] = player;
		}
	}
	foreach(team, _ in level.teams)
	{
		level.placement[team] = placement[team];
	}
}

/*
	Name: getplacementforplayer
	Namespace: globallogic
	Checksum: 0xD25D7657
	Offset: 0x4180
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function getplacementforplayer(player)
{
	updateplacement();
	playerrank = -1;
	placement = level.placement[#"all"];
	for(placementindex = 0; placementindex < placement.size; placementindex++)
	{
		if(level.placement[#"all"][placementindex] == player)
		{
			playerrank = placementindex + 1;
			break;
		}
	}
	return playerrank;
}

/*
	Name: sortdeadplayers
	Namespace: globallogic
	Checksum: 0xECE65AB3
	Offset: 0x4238
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function sortdeadplayers(team)
{
	if(!level.playerqueuedrespawn)
	{
		return;
	}
	for(i = 1; i < level.deadplayers[team].size; i++)
	{
		player = level.deadplayers[team][i];
		for(j = i - 1; j >= 0 && player.deathtime < level.deadplayers[team][j].deathtime; j--)
		{
			level.deadplayers[team][j + 1] = level.deadplayers[team][j];
		}
		level.deadplayers[team][j + 1] = player;
	}
	for(i = 0; i < level.deadplayers[team].size; i++)
	{
		if(level.deadplayers[team][i].spawnqueueindex != i)
		{
			level.spawnqueuemodified[team] = 1;
		}
		level.deadplayers[team][i].spawnqueueindex = i;
	}
}

/*
	Name: totalalivecount
	Namespace: globallogic
	Checksum: 0xCE16CC22
	Offset: 0x43E8
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function totalalivecount()
{
	count = 0;
	foreach(team, _ in level.teams)
	{
		count = count + level.alivecount[team];
	}
	return count;
}

/*
	Name: totalplayerlives
	Namespace: globallogic
	Checksum: 0xFF8D91D
	Offset: 0x4488
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function totalplayerlives()
{
	count = 0;
	foreach(team, _ in level.teams)
	{
		count = count + level.playerlives[team];
	}
	return count;
}

/*
	Name: initteamvariables
	Namespace: globallogic
	Checksum: 0x753BA72E
	Offset: 0x4528
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function initteamvariables(team)
{
	if(!isdefined(level.alivecount))
	{
		level.alivecount = [];
	}
	level.alivecount[team] = 0;
	level.lastalivecount[team] = 0;
	level.everexisted[team] = 0;
	level.wavedelay[team] = 0;
	level.lastwave[team] = 0;
	level.waveplayerspawnindex[team] = 0;
	resetteamvariables(team);
}

/*
	Name: resetteamvariables
	Namespace: globallogic
	Checksum: 0x8F23A289
	Offset: 0x45E8
	Size: 0xCE
	Parameters: 1
	Flags: Linked
*/
function resetteamvariables(team)
{
	level.playercount[team] = 0;
	level.botscount[team] = 0;
	level.lastalivecount[team] = level.alivecount[team];
	level.alivecount[team] = 0;
	level.playerlives[team] = 0;
	level.aliveplayers[team] = [];
	level.deadplayers[team] = [];
	level.squads[team] = [];
	level.spawnqueuemodified[team] = 0;
}

/*
	Name: updateteamstatus
	Namespace: globallogic
	Checksum: 0x88160EE9
	Offset: 0x46C0
	Size: 0x3E0
	Parameters: 1
	Flags: Linked
*/
function updateteamstatus(var_bdfe75a7)
{
	if(game.state == "postgame")
	{
		return;
	}
	foreach(team, _ in level.teams)
	{
		resetteamvariables(team);
	}
	level.activeplayers = [];
	self.var_bdfe75a7 = var_bdfe75a7;
	players = level.players;
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(!isdefined(player) && level.splitscreen)
		{
			continue;
		}
		team = player.team;
		if(team != "spectator")
		{
			level.playercount[team]++;
			if(isbot(player))
			{
				level.botscount[team]++;
			}
			if(player.sessionstate == "playing" && (!(isdefined(player.var_bdfe75a7) && player.var_bdfe75a7)))
			{
				level.alivecount[team]++;
				level.playerlives[team]++;
				player.spawnqueueindex = -1;
				if(isalive(player))
				{
					level.aliveplayers[team][level.aliveplayers[team].size] = player;
					level.activeplayers[level.activeplayers.size] = player;
				}
				else
				{
					level.deadplayers[team][level.deadplayers[team].size] = player;
				}
				continue;
			}
			level.deadplayers[team][level.deadplayers[team].size] = player;
			if(player globallogic_spawn::mayspawn())
			{
				level.playerlives[team]++;
			}
		}
	}
	totalalive = totalalivecount();
	if(totalalive > level.maxplayercount)
	{
		level.maxplayercount = totalalive;
	}
	foreach(team, _ in level.teams)
	{
		if(level.alivecount[team] && level.everexisted[team] == 0)
		{
			level.everexisted[team] = gettime();
		}
		sortdeadplayers(team);
	}
	level updategameevents();
	self.var_bdfe75a7 = undefined;
}

/*
	Name: checkteamscorelimitsoon
	Namespace: globallogic
	Checksum: 0x3D47A59B
	Offset: 0x4AA8
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function checkteamscorelimitsoon(team)
{
	/#
		assert(isdefined(team));
	#/
	if(level.scorelimit <= 0)
	{
		return;
	}
	if(!level.teambased)
	{
		return;
	}
	if(globallogic_utils::gettimepassed() < 60000)
	{
		return;
	}
	timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(team);
	if(timeleft < 1)
	{
		level notify(#"match_ending_soon", "score");
	}
}

/*
	Name: checkplayerscorelimitsoon
	Namespace: globallogic
	Checksum: 0xCCD53179
	Offset: 0x4B60
	Size: 0xB8
	Parameters: 0
	Flags: None
*/
function checkplayerscorelimitsoon()
{
	/#
		assert(isplayer(self));
	#/
	if(level.scorelimit <= 0)
	{
		return;
	}
	if(level.teambased)
	{
		return;
	}
	if(globallogic_utils::gettimepassed() < 60000)
	{
		return;
	}
	timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(undefined);
	if(timeleft < 1)
	{
		level notify(#"match_ending_soon", "score");
	}
}

/*
	Name: startgame
	Namespace: globallogic
	Checksum: 0x499CE3A7
	Offset: 0x4C20
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function startgame()
{
	thread globallogic_utils::gametimer();
	level.timerstopped = 0;
	setmatchtalkflag("DeadChatWithDead", level.voip.deadchatwithdead);
	setmatchtalkflag("DeadChatWithTeam", level.voip.deadchatwithteam);
	setmatchtalkflag("DeadHearTeamLiving", level.voip.deadhearteamliving);
	setmatchtalkflag("DeadHearAllLiving", level.voip.deadhearallliving);
	setmatchtalkflag("EveryoneHearsEveryone", level.voip.everyonehearseveryone);
	setmatchtalkflag("DeadHearKiller", level.voip.deadhearkiller);
	setmatchtalkflag("KillersHearVictim", level.voip.killershearvictim);
	prematchperiod();
	level notify(#"prematch_over");
	level.prematch_over = 1;
	thread graceperiod();
	thread watchmatchendingsoon();
	if(isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats)
	{
		return;
	}
	recordmatchbegin();
}

/*
	Name: waitforplayers
	Namespace: globallogic
	Checksum: 0x80F724D1
	Offset: 0x4DF8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function waitforplayers()
{
}

/*
	Name: prematchperiod
	Namespace: globallogic
	Checksum: 0x183FDCDE
	Offset: 0x4E08
	Size: 0x192
	Parameters: 0
	Flags: Linked
*/
function prematchperiod()
{
	setmatchflag("hud_hardcore", level.hardcoremode);
	level endon(#"game_ended");
	if(level.prematchperiod > 0)
	{
		thread matchstarttimer();
		waitforplayers();
		wait(level.prematchperiod);
	}
	else
	{
		matchstarttimerskip();
		waitframe(1);
	}
	level.inprematchperiod = 0;
	foreach(player in level.players)
	{
		player val::reset(#"prematch_period", "freezecontrols");
		player val::reset(#"prematch_period", "disable_weapons");
		player val::reset(#"prematch_period", "disablegadgets");
	}
	if(game.state != "playing")
	{
		return;
	}
}

/*
	Name: graceperiod
	Namespace: globallogic
	Checksum: 0x93BAD3F1
	Offset: 0x4FA8
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function graceperiod()
{
	level endon(#"game_ended");
	if(isdefined(level.graceperiodfunc))
	{
		[[level.graceperiodfunc]]();
	}
	else
	{
		wait(level.graceperiod);
	}
	level notify(#"grace_period_ending");
	waitframe(1);
	level.ingraceperiod = 0;
	if(game.state != "playing")
	{
		return;
	}
	if(level.numlives)
	{
		players = level.players;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player.hasspawned && player.sessionteam != "spectator" && !isalive(player))
			{
				player.statusicon = "hud_status_dead";
			}
		}
	}
}

/*
	Name: watchmatchendingsoon
	Namespace: globallogic
	Checksum: 0x7C7C0AE9
	Offset: 0x50F0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function watchmatchendingsoon()
{
	setdvar(#"xblive_matchendingsoon", 0);
	level waittill(#"match_ending_soon");
	setdvar(#"xblive_matchendingsoon", 1);
}

/*
	Name: assertteamvariables
	Namespace: globallogic
	Checksum: 0x80F724D1
	Offset: 0x5160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function assertteamvariables()
{
}

/*
	Name: anyteamhaswavedelay
	Namespace: globallogic
	Checksum: 0x20A3D5A2
	Offset: 0x5170
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function anyteamhaswavedelay()
{
	foreach(team, _ in level.teams)
	{
		if(level.wavedelay[team])
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: callback_startgametype
	Namespace: globallogic
	Checksum: 0xBB85164B
	Offset: 0x5200
	Size: 0x159C
	Parameters: 0
	Flags: Linked
*/
function callback_startgametype()
{
	level.prematchperiod = 0;
	level.intermission = 0;
	setmatchflag("cg_drawSpectatorMessages", 1);
	setmatchflag("game_ended", 0);
	if(!isdefined(game.gamestarted))
	{
		if(!isdefined(game.allies))
		{
			game.allies = "seals";
		}
		if(!isdefined(game.axis))
		{
			game.axis = "pmc";
		}
		if(!isdefined(game.attackers))
		{
			game.attackers = #"allies";
		}
		if(!isdefined(game.defenders))
		{
			game.defenders = #"axis";
		}
		/#
			assert(game.attackers != game.defenders);
		#/
		foreach(_ in level.teams)
		{
			if(!isdefined(game.team))
			{
				game.team = "pmc";
			}
		}
		if(!isdefined(game.state))
		{
			game.state = "playing";
		}
		setdvar(#"cg_thirdpersonangle", 354);
		game.strings[#"press_to_spawn"] = #"hash_203ff65a4ee460e6";
		if(level.teambased)
		{
			game.strings[#"waiting_for_teams"] = #"hash_150c54160239825";
			game.strings[#"opponent_forfeiting_in"] = #"hash_52d76ed35e0b625a";
		}
		else
		{
			game.strings[#"waiting_for_teams"] = #"hash_47c479655d474f31";
			game.strings[#"opponent_forfeiting_in"] = #"hash_52d76ed35e0b625a";
		}
		game.strings[#"match_starting_in"] = #"hash_18e58cc95db34427";
		game.strings[#"spawn_next_round"] = #"hash_590100cdca62e7db";
		game.strings[#"waiting_to_spawn"] = #"hash_44d60a6e6ed2a53c";
		game.strings[#"waiting_to_spawn_ss"] = #"hash_78bf3a61cf52e257";
		game.strings[#"you_will_spawn"] = #"hash_53c0ba6abce1c0ea";
		game.strings[#"match_starting"] = #"hash_73938fd7959ab087";
		game.strings[#"change_class"] = #"hash_181a96fe9c28ada2";
		game.strings[#"last_stand"] = #"hash_5732d212e4511a00";
		game.strings[#"cowards_way"] = #"hash_268e464278a2f8ff";
		game.strings[#"tie"] = #"hash_72785a9088fa0d1b";
		game.strings[#"round_draw"] = #"hash_7d3ae25e0187143e";
		game.strings[#"enemies_eliminated"] = #"mp_enemies_eliminated";
		game.strings[#"score_limit_reached"] = #"hash_3050eee23c6a3574";
		game.strings[#"round_limit_reached"] = #"hash_3b23cb510ab5970a";
		game.strings[#"time_limit_reached"] = #"hash_4e2680278af76571";
		game.strings[#"players_forfeited"] = #"hash_4b172be7ce459674";
		assertteamvariables();
		[[level.onprecachegametype]]();
		game.gamestarted = 1;
		game.totalkills = 0;
		foreach(team, _ in level.teams)
		{
			game.stat[#"teamscores"][team] = 0;
			game.totalkillsteam[team] = 0;
		}
		if(!level.splitscreen)
		{
			level.prematchperiod = getgametypesetting(#"prematchperiod");
		}
	}
	if(!isdefined(game.timepassed))
	{
		game.timepassed = 0;
	}
	if(!isdefined(game.roundsplayed))
	{
		game.roundsplayed = 0;
	}
	setroundsplayed(game.roundsplayed);
	if(!isdefined(game.roundwinner))
	{
		game.roundwinner = [];
	}
	if(!isdefined(game.stat[#"roundswon"]))
	{
		game.stat[#"roundswon"] = [];
	}
	if(!isdefined(game.stat[#"roundswon"][#"tie"]))
	{
		game.stat[#"roundswon"][#"tie"] = 0;
	}
	foreach(team, _ in level.teams)
	{
		if(!isdefined(game.stat[#"roundswon"][team]))
		{
			game.stat[#"roundswon"][team] = 0;
		}
		level.teamspawnpoints[team] = [];
		level.spawn_point_team_class_names[team] = [];
	}
	level.skipvote = 0;
	level.gameended = 0;
	setdvar(#"g_gameended", 0);
	level.objidstart = 0;
	level.forcedend = 0;
	level.hostforcedend = 0;
	level.hardcoremode = getgametypesetting(#"hardcoremode");
	if(level.hardcoremode)
	{
		/#
			print("");
		#/
		if(!isdefined(level.friendlyfiredelaytime))
		{
			level.friendlyfiredelaytime = 0;
		}
	}
	level.rankcap = getdvarint(#"scr_max_rank", 0);
	level.minprestige = getdvarint(#"scr_min_prestige", 0);
	level.usestartspawns = 1;
	level.cumulativeroundscores = getgametypesetting(#"cumulativeroundscores");
	level.allowhitmarkers = getgametypesetting(#"allowhitmarkers");
	level.playerqueuedrespawn = getgametypesetting(#"playerqueuedrespawn");
	level.playerforcerespawn = getgametypesetting(#"playerforcerespawn");
	level.perksenabled = getgametypesetting(#"perksenabled");
	level.disableattachments = getgametypesetting(#"disableattachments");
	level.disabletacinsert = getgametypesetting(#"disabletacinsert");
	level.disablecac = getgametypesetting(#"disablecac");
	level.disableweapondrop = getgametypesetting(#"disableweapondrop");
	level.onlyheadshots = getgametypesetting(#"onlyheadshots");
	level.minimumallowedteamkills = getgametypesetting(#"teamkillpunishcount") - 1;
	level.teamkillreducedpenalty = getgametypesetting(#"teamkillreducedpenalty");
	level.teamkillpointloss = getgametypesetting(#"teamkillpointloss");
	level.teamkillspawndelay = getgametypesetting(#"teamkillspawndelay");
	level.deathpointloss = getgametypesetting(#"deathpointloss");
	level.leaderbonus = getgametypesetting(#"leaderbonus");
	level.forceradar = getgametypesetting(#"forceradar");
	level.playersprinttime = getgametypesetting(#"playersprinttime");
	level.bulletdamagescalar = getgametypesetting(#"bulletdamagescalar");
	level.playermaxhealth = getgametypesetting(#"playermaxhealth");
	level.playerhealthregentime = getgametypesetting(#"playerhealthregentime");
	level.playerrespawndelay = getgametypesetting(#"playerrespawndelay");
	level.playerobjectiveheldrespawndelay = getgametypesetting(#"playerobjectiveheldrespawndelay");
	level.waverespawndelay = getgametypesetting(#"waverespawndelay");
	level.spectatetype = getgametypesetting(#"spectatetype");
	level.voip = spawnstruct();
	level.voip.deadchatwithdead = getgametypesetting(#"voipdeadchatwithdead");
	level.voip.deadchatwithteam = getgametypesetting(#"voipdeadchatwithteam");
	level.voip.deadhearallliving = getgametypesetting(#"voipdeadhearallliving");
	level.voip.deadhearteamliving = getgametypesetting(#"voipdeadhearteamliving");
	level.voip.everyonehearseveryone = getgametypesetting(#"voipeveryonehearseveryone");
	level.voip.deadhearkiller = getgametypesetting(#"voipdeadhearkiller");
	level.voip.killershearvictim = getgametypesetting(#"voipkillershearvictim");
	callback::callback(#"on_start_gametype");
	level.prematchperiod = 0;
	level.persistentdatainfo = [];
	level.maxrecentstats = 10;
	level.maxhitlocations = 19;
	level.globalshotsfired = 0;
	thread hud_message::init();
	foreach(team, _ in level.teams)
	{
		initteamvariables(team);
	}
	level.maxplayercount = 0;
	level.activeplayers = [];
	level.allowannouncer = getgametypesetting(#"allowannouncer");
	if(!isdefined(level.timelimit))
	{
		util::registertimelimit(1, 1440);
	}
	if(!isdefined(level.scorelimit))
	{
		util::registerscorelimit(1, 500);
	}
	if(!isdefined(level.roundlimit))
	{
		util::registerroundlimit(0, 10);
	}
	if(!isdefined(level.roundwinlimit))
	{
		util::registerroundwinlimit(0, 10);
	}
	globallogic_utils::registerpostroundevent(&potm::post_round_potm);
	wavedelay = level.waverespawndelay;
	if(wavedelay)
	{
		foreach(team, _ in level.teams)
		{
			level.wavedelay[team] = wavedelay;
			level.lastwave[team] = 0;
		}
		level thread [[level.wavespawntimer]]();
	}
	level.inprematchperiod = 1;
	if(level.prematchperiod > 2)
	{
		level.prematchperiod = level.prematchperiod + randomfloat(4) - 2;
	}
	if(level.numlives || anyteamhaswavedelay() || level.playerqueuedrespawn)
	{
		level.graceperiod = 15;
	}
	else
	{
		level.graceperiod = 5;
	}
	level.ingraceperiod = 1;
	level.roundenddelay = 5;
	level.halftimeroundenddelay = 3;
	globallogic_score::updateallteamscores();
	level.killstreaksenabled = 1;
	if(getdvarstring(#"scr_game_rankenabled") == "")
	{
		setdvar(#"scr_game_rankenabled", 1);
	}
	level.rankenabled = getdvarint(#"scr_game_rankenabled", 0);
	if(getdvarstring(#"scr_game_medalsenabled") == "")
	{
		setdvar(#"scr_game_medalsenabled", 1);
	}
	level.medalsenabled = getdvarint(#"scr_game_medalsenabled", 0);
	if(level.hardcoremode && level.rankedmatch && getdvarstring(#"scr_game_friendlyfiredelay") == "")
	{
		setdvar(#"scr_game_friendlyfiredelay", 1);
	}
	level.friendlyfiredelay = getdvarint(#"scr_game_friendlyfiredelay", 0);
	[[level.onstartgametype]]();
	if(getdvarint(#"custom_killstreak_mode", 0) == 1)
	{
		level.killstreaksenabled = 0;
	}
	level thread potm::play_potm(1);
	thread startgame();
	level thread updategametypedvars();
	level thread simple_hostmigration::updatehostmigrationdata();
	/#
		if(getdvarint(#"scr_writeconfigstrings", 0) == 1)
		{
			level.skipgameend = 1;
			level.roundlimit = 1;
			wait(1);
			thread forceend(0);
		}
		if(getdvarint(#"scr_hostmigrationtest", 0) == 1)
		{
			thread forcedebughostmigration();
		}
	#/
}

/*
	Name: forcedebughostmigration
	Namespace: globallogic
	Checksum: 0x2004A5BA
	Offset: 0x67A8
	Size: 0x50
	Parameters: 0
	Flags: None
*/
function forcedebughostmigration()
{
	/#
		while(true)
		{
			hostmigration::waittillhostmigrationdone();
			wait(60);
			starthostmigration();
			hostmigration::waittillhostmigrationdone();
		}
	#/
}

/*
	Name: registerfriendlyfiredelay
	Namespace: globallogic
	Checksum: 0xF1517221
	Offset: 0x6800
	Size: 0x116
	Parameters: 4
	Flags: Linked
*/
function registerfriendlyfiredelay(dvarstring, defaultvalue, minvalue, maxvalue)
{
	dvarstring = "scr_" + dvarstring + "_friendlyFireDelayTime";
	if(getdvarstring(dvarstring) == "")
	{
		setdvar(dvarstring, defaultvalue);
	}
	if(getdvarint(dvarstring, 0) > maxvalue)
	{
		setdvar(dvarstring, maxvalue);
	}
	else if(getdvarint(dvarstring, 0) < minvalue)
	{
		setdvar(dvarstring, minvalue);
	}
	level.friendlyfiredelaytime = getdvarint(dvarstring, 0);
}

/*
	Name: checkroundswitch
	Namespace: globallogic
	Checksum: 0xDC1B5A98
	Offset: 0x6920
	Size: 0x90
	Parameters: 0
	Flags: None
*/
function checkroundswitch()
{
	if(!isdefined(level.roundswitch) || !level.roundswitch)
	{
		return 0;
	}
	if(!isdefined(level.onroundswitch))
	{
		return 0;
	}
	/#
		assert(game.roundsplayed > 0);
	#/
	if(game.roundsplayed % level.roundswitch == 0)
	{
		[[level.onroundswitch]]();
		return 1;
	}
	return 0;
}

/*
	Name: listenforgameend
	Namespace: globallogic
	Checksum: 0x538844CE
	Offset: 0x69B8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function listenforgameend()
{
	self endon(#"disconnect");
	self waittill(#"host_sucks_end_game");
	level.skipvote = 1;
	if(!level.gameended)
	{
		level thread forceend(1);
	}
}

/*
	Name: getkillstreaks
	Namespace: globallogic
	Checksum: 0x3854BB85
	Offset: 0x6A28
	Size: 0x124
	Parameters: 1
	Flags: None
*/
function getkillstreaks(player)
{
	for(killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++)
	{
		killstreak[killstreaknum] = "killstreak_null";
	}
	if(isplayer(player) && !level.oldschool && level.disablecac != 1 && (!isbot(player) && isdefined(player.killstreak)))
	{
		currentkillstreak = 0;
		for(killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++)
		{
			if(isdefined(player.killstreak[killstreaknum]))
			{
				killstreak[currentkillstreak] = player.killstreak[killstreaknum];
				currentkillstreak++;
			}
		}
	}
	return killstreak;
}

/*
	Name: updaterankedmatch
	Namespace: globallogic
	Checksum: 0xDCF5CB28
	Offset: 0x6B58
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function updaterankedmatch(winner)
{
	if(level.rankedmatch)
	{
		if(hostidledout())
		{
			level.hostforcedend = 1;
			/#
				print("");
			#/
		}
	}
}

