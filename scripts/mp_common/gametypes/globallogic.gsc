// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1320d08e0182e6b8;
#using script_1417f739c5b20576;
#using script_18f0d22c75b141a7;
#using script_1bd0552c85e48ebe;
#using script_1d1e03233039d175;
#using script_1f2f7ef27f2aabba;
#using script_2255a7ad3edc838f;
#using script_229f24b1662651c4;
#using script_256b8879317373de;
#using script_2c49ae69cd8ce30c;
#using script_2d050f995be06579;
#using script_3f9e54c7a9a7e1e2;
#using script_457dc1cc11263d2b;
#using script_47fb62300ac0bd60;
#using script_5399f402045d7abd;
#using script_57f7003580bb15e0;
#using script_6350c209b3d1b07d;
#using script_66052559f4fc2bf9;
#using script_6c8abe14025b47c4;
#using script_6eb0d63d4a90adcf;
#using script_75be2950b381443;
#using script_788472602edbe3b9;
#using script_7bafaa95bb1b427e;
#using script_bc839bb0e693558;
#using script_caab14e8a60767c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\bb_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\demo_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\healthoverlay.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\hud_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\persistence_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\rat_shared.gsc;
#using scripts\core_common\simple_hostmigration.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\tweakables_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\mp_common\arena.gsc;
#using scripts\mp_common\challenges.gsc;
#using scripts\mp_common\draft.gsc;
#using scripts\mp_common\gameadvertisement.gsc;
#using scripts\mp_common\gamerep.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\gametypes\clientids.gsc;
#using scripts\mp_common\gametypes\deathicons.gsc;
#using scripts\mp_common\gametypes\dev.gsc;
#using scripts\mp_common\gametypes\dogtags.gsc;
#using scripts\mp_common\gametypes\gametype.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_defaults.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\gametypes\globallogic_ui.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\hostmigration.gsc;
#using scripts\mp_common\gametypes\hud_message.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\gametypes\menus.gsc;
#using scripts\mp_common\gametypes\outcome.gsc;
#using scripts\mp_common\gametypes\overtime.gsc;
#using scripts\mp_common\gametypes\round.gsc;
#using scripts\mp_common\gametypes\serversettings.gsc;
#using scripts\mp_common\gametypes\shellshock.gsc;
#using scripts\mp_common\rat.gsc;
#using scripts\mp_common\userspawnselection.gsc;
#using scripts\mp_common\util.gsc;

#namespace globallogic;

/*
	Name: function_89f2df9
	Namespace: globallogic
	Checksum: 0x6A83B275
	Offset: 0xED8
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
	Checksum: 0xA91555AE
	Offset: 0xF28
	Size: 0x33C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.vsmgr_prio_visionset_mpintro))
	{
		level.vsmgr_prio_visionset_mpintro = 5;
	}
	visionset_mgr::register_info("visionset", "mpintro", 1, level.vsmgr_prio_visionset_mpintro, 31, 0, &visionset_mgr::ramp_in_out_thread, 0);
	level.host_migration_activate_visionset_func = &mpintro_visionset_activate_func;
	level.host_migration_deactivate_visionset_func = &mpintro_visionset_deactivate_func;
	visionset_mgr::register_info("visionset", "crithealth", 1, 4, 25, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
	clientfield::register("clientuimodel", "huditems.killedByEntNum", 1, 4, "int");
	clientfield::register("clientuimodel", "huditems.killedByAttachmentCount", 1, 4, "int");
	clientfield::register("clientuimodel", "huditems.killedByItemIndex", 1, 10, "int");
	clientfield::register("clientuimodel", "huditems.killedByMOD", 1, 8, "int");
	for(index = 0; index < 5; index++)
	{
		clientfield::register("clientuimodel", "huditems.killedByAttachment" + index, 1, 6, "int");
	}
	clientfield::register("toplayer", "thermal_sight", 1, 1, "int");
	clientfield::register("toplayer", "strobe_light", 1, 1, "int");
	clientfield::register("allplayers", "cold_blooded", 1, 1, "int");
	level.var_462db2cf = getweapon(#"hero_pineapplegun");
	level.var_bfce6749 = getweapon(#"hero_pineapple_grenade");
	ability_power::function_9d78823f(level.var_462db2cf, level.var_bfce6749);
	callback::on_spawned(&on_player_spawned);
	callback::function_98a0917d(&function_98a0917d);
}

/*
	Name: on_player_spawned
	Namespace: globallogic
	Checksum: 0x8A575727
	Offset: 0x1270
	Size: 0x2E
	Parameters: 0
	Flags: Linked, Private
*/
private function on_player_spawned()
{
	self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
	self.var_84c4b3e6 = 0;
}

/*
	Name: init
	Namespace: globallogic
	Checksum: 0xB3219F0D
	Offset: 0x12A8
	Size: 0xDA4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.splitscreen = issplitscreen();
	level.xenon = getdvarstring(#"xenongame") == "true";
	level.ps3 = getdvarstring(#"ps3game") == "true";
	level.wiiu = getdvarstring(#"wiiugame") == "true";
	level.orbis = getdvarstring(#"orbisgame") == "true";
	level.durango = getdvarstring(#"durangogame") == "true";
	level.onlinegame = sessionmodeisonlinegame();
	level.systemlink = sessionmodeissystemlink();
	level.console = level.xenon || level.ps3 || level.wiiu || level.orbis || level.durango;
	level.rankedmatch = gamemodeisusingxp();
	level.leaguematch = 0;
	level.custommatch = gamemodeismode(1) || gamemodeismode(7);
	level.arenamatch = gamemodeisarena();
	level.mpcustommatch = level.custommatch;
	level.contractsenabled = !getgametypesetting(#"disablecontracts");
	level.contractsenabled = 0;
	level.disablevehicleburndamage = 1;
	level.var_49d9aa70 = 1;
	/#
		if(getdvarint(#"scr_forcerankedmatch", 0) == 1)
		{
			level.rankedmatch = 1;
		}
	#/
	level.script = util::function_53bbf9d2();
	level.gametype = util::function_5df4294();
	level.var_837aa533 = hash(level.gametype);
	if(isdefined(level.gametype))
	{
		level.var_12323003 = function_16495154(level.gametype);
	}
	level.teambased = 0;
	level.teamcount = getgametypesetting(#"teamcount");
	/#
		level.teamcount = math::clamp(level.teamcount, 1, getdvarint(#"com_maxclients", level.teamcount));
	#/
	level.multiteam = level.teamcount > 2;
	level.maxteamplayers = getgametypesetting(#"maxteamplayers");
	level.var_71c35c9f = getgametypesetting(#"competitivesettings") === 1;
	level.competitiveteamlives = getgametypesetting(#"competitiveteamlives") === 1;
	gametype::init();
	function_44c8af7f();
	level.var_724cf71 = 1;
	/#
		thread function_340107d4();
	#/
	level.overrideteamscore = 0;
	level.overrideplayerscore = 0;
	level.displayhalftimetext = 0;
	level.displayroundendtext = 1;
	level.clampscorelimit = 1;
	level.endgameonscorelimit = 1;
	level.endgameontimelimit = 1;
	level.scoreroundwinbased = 0;
	level.resetplayerscoreeveryround = 0;
	level.doendgamescoreboard = 1;
	level.gameforfeited = 0;
	level.forceautoassign = 0;
	level.halftimetype = 2;
	level.laststatustime = 0;
	level.waswinning = [];
	level.lastslowprocessframe = 0;
	level.placement = [];
	foreach(team, _ in level.teams)
	{
		level.placement[team] = [];
	}
	level.placement[#"all"] = [];
	level.defaultoffenseradius = 560;
	level.defaultoffenseradiussq = level.defaultoffenseradius * level.defaultoffenseradius;
	level.dropteam = getdvarint(#"sv_maxclients", 0);
	level.infinalkillcam = 0;
	level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
	setdvar(#"hash_6028c4687677bbc9", getgametypesetting(#"boastenabled"));
	setdvar(#"hash_e099986c072eb0f", getgametypesetting(#"hash_104f124f56f0f20a"));
	setdvar(#"hash_553ad8f9db24bf22", int(1000 * getgametypesetting(#"hash_1614b9cbe0df6f75")));
	function_9afe34e3();
	gameobjects::register_allowed_gameobject(level.gametype);
	if(isdefined(level.var_d1455682))
	{
		gameobjectname = level.var_d1455682.gameobjectname;
		if(isdefined(gameobjectname))
		{
			gameobjects::register_allowed_gameobject(gameobjectname);
		}
	}
	map::init();
	globallogic_ui::init();
	registerdvars();
	loadout::init_dvars();
	level.oldschool = getgametypesetting(#"oldschoolmode");
	namespace_81c567a8::init_shared();
	precache_mp_leaderboards();
	if(!isdefined(game.tiebreaker))
	{
		game.tiebreaker = 0;
	}
	if(!isdefined(game.stat))
	{
		game.stat = [];
	}
	thread gameadvertisement::init();
	thread gamerep::init();
	level.disablechallenges = 0;
	if(level.leaguematch || getdvarint(#"scr_disablechallenges", 0) > 0)
	{
		level.disablechallenges = 1;
	}
	level.disablestattracking = getdvarint(#"scr_disablestattracking", 0) > 0;
	setup_callbacks();
	clientfield::register("playercorpse", "firefly_effect", 1, 2, "int");
	clientfield::register("playercorpse", "annihilate_effect", 1, 1, "int");
	clientfield::register("playercorpse", "pineapplegun_effect", 1, 1, "int");
	clientfield::register("actor", "annihilate_effect", 1, 1, "int");
	clientfield::register("actor", "pineapplegun_effect", 1, 1, "int");
	clientfield::register("world", "game_ended", 1, 1, "int");
	clientfield::register("world", "post_game", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.hideOutcomeUI", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.captureCrateState", 1, 2, "int");
	clientfield::register("clientuimodel", "hudItems.captureCrateTotalTime", 1, 13, "int");
	clientfield::register("worlduimodel", "hudItems.team1.roundsWon", 1, 4, "int");
	clientfield::register("worlduimodel", "hudItems.team1.livesCount", 1, 8, "int");
	clientfield::register("worlduimodel", "hudItems.team1.noRespawnsLeft", 1, 1, "int");
	clientfield::register("worlduimodel", "hudItems.team2.roundsWon", 1, 4, "int");
	clientfield::register("worlduimodel", "hudItems.team2.livesCount", 1, 8, "int");
	clientfield::register("worlduimodel", "hudItems.team2.noRespawnsLeft", 1, 1, "int");
	clientfield::register("worlduimodel", "hudItems.specialistSwitchIsLethal", 1, 1, "int");
	clientfield::function_a8bbc967("hudItems.playerLivesCount", 1, 8, "int", 0);
	clientfield::register("clientuimodel", "hudItems.armorIsOnCooldown", 1, 1, "int");
	level thread setroundswonuimodels();
	level.figure_out_attacker = &player::figure_out_attacker;
	level.figure_out_friendly_fire = &player::figure_out_friendly_fire;
	thread hud_message::init();
}

/*
	Name: function_340107d4
	Namespace: globallogic
	Checksum: 0x789B5F0C
	Offset: 0x2058
	Size: 0x52
	Parameters: 0
	Flags: None
*/
function function_340107d4()
{
	/#
		while(true)
		{
			wait(2);
			level.var_724cf71 = getdvarint(#"hash_4842177be6e78c16", level.var_724cf71);
		}
	#/
}

/*
	Name: function_44c8af7f
	Namespace: globallogic
	Checksum: 0x733F2451
	Offset: 0x20B8
	Size: 0x23C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_44c8af7f()
{
	level.teams = [];
	level.teamindex = [];
	teamcount = level.teamcount;
	if(level.teamcount == 1)
	{
		teamcount = getdvarint(#"com_maxclients", 17) + 1;
		level.teams[#"free"] = "free";
	}
	level.teams[#"allies"] = "allies";
	level.teams[#"axis"] = "axis";
	level.teamindex[#"world"] = "world";
	level.teamindex[#"neutral"] = 0;
	level.teamindex[#"allies"] = 1;
	level.teamindex[#"axis"] = 2;
	for(teamindex = 3; teamindex < teamcount + 1; teamindex++)
	{
		level.teams[hash("team" + teamindex)] = "team" + teamindex;
		level.teamindex[hash("team" + teamindex)] = teamindex;
	}
	level.var_75dffa9f = [];
	callback::callback(#"hash_79b2aab11c0a9902");
}

/*
	Name: function_9afe34e3
	Namespace: globallogic
	Checksum: 0xDA5E7B1
	Offset: 0x2300
	Size: 0x1B6
	Parameters: 0
	Flags: Linked
*/
function function_9afe34e3()
{
	level.var_336c35f1 = [];
	globallogic_utils::function_4aa8d809(0, "dnf");
	globallogic_utils::function_4aa8d809(1, "completed");
	globallogic_utils::function_4aa8d809(2, "time limit");
	globallogic_utils::function_4aa8d809(3, "scorelimit");
	globallogic_utils::function_4aa8d809(4, "roundscorelimit");
	globallogic_utils::function_4aa8d809(5, "roundlimit");
	globallogic_utils::function_4aa8d809(6, "team eliminated");
	globallogic_utils::function_4aa8d809(7, "forfeit");
	globallogic_utils::function_4aa8d809(8, "ended game");
	globallogic_utils::function_4aa8d809(9, "host ended game");
	globallogic_utils::function_4aa8d809(10, "host ended sucks");
	for(i = 0; i < 5; i++)
	{
		globallogic_utils::function_4aa8d809(11 + i, "gamemode-specific");
	}
}

/*
	Name: registerdvars
	Namespace: globallogic
	Checksum: 0xBD62036D
	Offset: 0x24C0
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function registerdvars()
{
	setmatchflag("bomb_timer", 0);
	level.vehicledamagescalar = getdvarfloat(#"scr_vehicle_damage_scalar", 1);
	level.fire_audio_repeat_duration = getdvarint(#"fire_audio_repeat_duration", 0);
	level.fire_audio_random_max_duration = getdvarint(#"fire_audio_random_max_duration", 0);
	setdvar(#"g_customteamname_allies", "");
	setdvar(#"g_customteamname_axis", "");
	setdvar(#"hash_8351525729015ab", 1);
}

/*
	Name: setroundswonuimodels
	Namespace: globallogic
	Checksum: 0xDB9C2DA4
	Offset: 0x25F0
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function setroundswonuimodels()
{
	waitframe(1);
	alliesroundswon = 0;
	axisroundswon = 0;
	if(isdefined(game.stat[#"roundswon"]))
	{
		alliesroundswon = game.stat[#"roundswon"][#"allies"];
		axisroundswon = game.stat[#"roundswon"][#"axis"];
	}
	clientfield::set_world_uimodel("hudItems.team1.roundsWon", alliesroundswon);
	clientfield::set_world_uimodel("hudItems.team2.roundsWon", axisroundswon);
}

/*
	Name: blank
	Namespace: globallogic
	Checksum: 0x52415775
	Offset: 0x26D0
	Size: 0x54
	Parameters: 10
	Flags: Linked
*/
function blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
{
}

/*
	Name: setup_callbacks
	Namespace: globallogic
	Checksum: 0x66D7C378
	Offset: 0x2730
	Size: 0x534
	Parameters: 0
	Flags: Linked
*/
function setup_callbacks()
{
	level.spawnplayer = &globallogic_spawn::spawnplayer;
	level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
	level.spawnclient = &globallogic_spawn::spawnclient;
	level.spawnspectator = &globallogic_spawn::spawnspectator;
	level.spawnintermission = &globallogic_spawn::spawnintermission;
	level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
	level.onplayerscore = &globallogic_score::default_onplayerscore;
	level.onteamscore = &globallogic_score::default_onteamscore;
	level.gamehistoryplayerkicked = &gamehistoryplayerkicked;
	level.wavespawntimer = &wavespawntimer;
	level.spawnmessage = &globallogic_spawn::default_spawnmessage;
	level.onspawnplayer = &blank;
	level.onspawnplayer = &spawning::onspawnplayer;
	level.onspawnspectator = &globallogic_defaults::default_onspawnspectator;
	level.onspawnintermission = &globallogic_defaults::default_onspawnintermission;
	level.onrespawndelay = &blank;
	level.onforfeit = &globallogic_defaults::default_onforfeit;
	level.ontimelimit = &globallogic_defaults::default_ontimelimit;
	level.onscorelimit = &globallogic_defaults::default_onscorelimit;
	level.onroundscorelimit = &globallogic_defaults::default_onroundscorelimit;
	level.onalivecountchange = &globallogic_defaults::default_onalivecountchange;
	level.ondeadevent = undefined;
	level.ononeleftevent = &globallogic_defaults::default_ononeleftevent;
	level.giveteamscore = &globallogic_score::giveteamscore;
	level.gettimepassed = &globallogic_utils::gettimepassed;
	level.gettimelimit = &globallogic_defaults::default_gettimelimit;
	level.getteamkillpenalty = &globallogic_defaults::default_getteamkillpenalty;
	level.getteamkillscore = &globallogic_defaults::default_getteamkillscore;
	level.iskillboosting = &globallogic_score::default_iskillboosting;
	level.var_37d62931 = &globallogic_score::function_37d62931;
	level._setteamscore = &globallogic_score::_setteamscore;
	level._setplayerscore = &globallogic_score::_setplayerscore;
	level._getteamscore = &globallogic_score::_getteamscore;
	level._getplayerscore = &globallogic_score::_getplayerscore;
	level.resetplayerscorestreaks = &globallogic_score::resetplayerscorechainandmomentum;
	level.onprecachegametype = &blank;
	level.onstartgametype = &blank;
	level.onplayerconnect = &blank;
	level.onplayerdisconnect = &blank;
	level.onplayerdamage = &blank;
	level.var_da2045d0 = [];
	level.var_fa66fada = [];
	level.var_6c4ec3fc = &function_8af3b312;
	level.onteamoutcomenotify = &hud_message::teamoutcomenotify;
	level.onoutcomenotify = &hud_message::outcomenotify;
	level.var_f6d301b = &blank;
	level.onendgame = &globallogic_defaults::onendgame;
	level.onmedalawarded = &blank;
	level.var_df67ea13 = &globallogic_defaults::function_108c4b65;
	level.var_36a111f3 = &function_10dc43bc;
	if(function_f99d2668())
	{
		level.var_b10e134d = &player_monitor::function_d35f877a;
	}
	level callback::add_callback(#"hash_84d8c1164d90313", &globallogic_defaults::function_dcf41142);
	level callback::add_callback(#"hash_6b7d26d34885b425", &function_b29d2423);
	globallogic_ui::setupcallbacks();
}

/*
	Name: precache_mp_friend_leaderboards
	Namespace: globallogic
	Checksum: 0x138F8C71
	Offset: 0x2C70
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function precache_mp_friend_leaderboards()
{
	hardcoremode = getgametypesetting(#"hardcoremode");
	if(!isdefined(hardcoremode))
	{
		hardcoremode = 0;
	}
	arenamode = isarenamode();
	postfix = "";
	if(hardcoremode)
	{
		postfix = "_HC";
	}
	else if(arenamode)
	{
		postfix = "_ARENA";
	}
	friendleaderboarda = "LB_MP_FRIEND_A" + postfix;
	friendleaderboardb = " LB_MP_FRIEND_B" + postfix;
	precacheleaderboards(friendleaderboarda + friendleaderboardb);
}

/*
	Name: precache_mp_anticheat_leaderboards
	Namespace: globallogic
	Checksum: 0xB8CB138
	Offset: 0x2D60
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function precache_mp_anticheat_leaderboards()
{
	hardcoremode = getgametypesetting(#"hardcoremode");
	if(!isdefined(hardcoremode))
	{
		hardcoremode = 0;
	}
	arenamode = isarenamode();
	postfix = "";
	if(hardcoremode)
	{
		postfix = "_HC";
	}
	else if(arenamode)
	{
		postfix = "_ARENA";
	}
	anticheatleaderboard = ("LB_MP_ANTICHEAT_" + level.gametype) + postfix;
	if(level.gametype != "fr")
	{
		anticheatleaderboard = anticheatleaderboard + " LB_MP_ANTICHEAT_GLOBAL";
	}
	precacheleaderboards(anticheatleaderboard);
}

/*
	Name: precache_mp_public_leaderboards
	Namespace: globallogic
	Checksum: 0x67AF54B4
	Offset: 0x2E60
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function precache_mp_public_leaderboards()
{
	mapname = util::function_53bbf9d2();
	hardcoremode = getgametypesetting(#"hardcoremode");
	if(!isdefined(hardcoremode))
	{
		hardcoremode = 0;
	}
	arenamode = isarenamode();
	freerunmode = level.gametype == "fr";
	postfix = "";
	if(freerunmode)
	{
		frleaderboard = " LB_MP_GM_FR_" + getsubstr(mapname, 3, mapname.size);
		precacheleaderboards(frleaderboard);
		return;
	}
	if(hardcoremode)
	{
		postfix = "_HC";
	}
	else if(arenamode)
	{
		postfix = "_ARENA";
	}
	careerleaderboard = " LB_MP_GB_SCORE" + postfix;
	prestigelb = " LB_MP_GB_XPPRESTIGE";
	gamemodeleaderboard = ("LB_MP_GM_" + level.gametype) + postfix;
	arenaleaderboard = "";
	if(gamemodeismode(6))
	{
		arenaslot = arenagetslot();
		arenaleaderboard = " LB_MP_ARENA_MASTERS_0" + arenaslot;
	}
	precacheleaderboards(((gamemodeleaderboard + careerleaderboard) + prestigelb) + arenaleaderboard);
}

/*
	Name: precache_mp_custom_leaderboards
	Namespace: globallogic
	Checksum: 0xB20BEC2
	Offset: 0x3060
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function precache_mp_custom_leaderboards()
{
	customleaderboards = "LB_MP_CG_" + level.gametype;
	precacheleaderboards("LB_MP_CG_GENERAL " + customleaderboards);
}

/*
	Name: precache_mp_leaderboards
	Namespace: globallogic
	Checksum: 0x51D03F41
	Offset: 0x30B0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function precache_mp_leaderboards()
{
	if(bot::is_bot_ranked_match())
	{
		return;
	}
	if(level.rankedmatch || level.gametype == "fr")
	{
		precache_mp_public_leaderboards();
		precache_mp_friend_leaderboards();
		precache_mp_anticheat_leaderboards();
	}
	else
	{
		precache_mp_custom_leaderboards();
	}
}

/*
	Name: compareteambygamestat
	Namespace: globallogic
	Checksum: 0x2B065F58
	Offset: 0x3148
	Size: 0xB2
	Parameters: 4
	Flags: Linked
*/
function compareteambygamestat(gamestat, teama, teamb, previous_winner_score)
{
	winner = undefined;
	/#
		assert(teama !== "");
	#/
	if(previous_winner_score == game.stat[gamestat][teamb])
	{
		winner = undefined;
	}
	else if(game.stat[gamestat][teamb] > previous_winner_score)
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
	Checksum: 0x2281F6AF
	Offset: 0x3208
	Size: 0xD4
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
		if(isdefined(winner))
		{
			previous_winner_score = game.stat[gamestat][winner];
		}
	}
	return winner;
}

/*
	Name: compareteambyteamscore
	Namespace: globallogic
	Checksum: 0xCCA4585B
	Offset: 0x32E8
	Size: 0x86
	Parameters: 3
	Flags: Linked
*/
function compareteambyteamscore(var_1ada49b5, teamb, var_2a5c5ccb)
{
	/#
		assert(var_1ada49b5 !== "");
	#/
	teambscore = [[level._getteamscore]](teamb);
	if(teambscore == var_2a5c5ccb)
	{
		return undefined;
	}
	if(teambscore > var_2a5c5ccb)
	{
		return teamb;
	}
	return var_1ada49b5;
}

/*
	Name: determineteamwinnerbyteamscore
	Namespace: globallogic
	Checksum: 0x849C8C2E
	Offset: 0x3378
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function determineteamwinnerbyteamscore()
{
	teamkeys = getarraykeys(level.teams);
	winner = teamkeys[0];
	var_2a5c5ccb = [[level._getteamscore]](winner);
	for(teamindex = 1; teamindex < teamkeys.size; teamindex++)
	{
		winner = compareteambyteamscore(winner, teamkeys[teamindex], var_2a5c5ccb);
		if(isdefined(winner))
		{
			var_2a5c5ccb = [[level._getteamscore]](winner);
		}
	}
	return winner;
}

/*
	Name: forceend
	Namespace: globallogic
	Checksum: 0xFCBB1A50
	Offset: 0x3440
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function forceend(hostsucks = 0)
{
	if(level.hostforcedend || level.forcedend)
	{
		return;
	}
	level.forcedend = 1;
	level.hostforcedend = 1;
	if(hostsucks)
	{
		var_c1e98979 = 10;
	}
	else
	{
		var_c1e98979 = 9;
	}
	setmatchflag("disableIngameMenu", 1);
	round::function_870759fb();
	round::set_flag("force_end_host");
	thread end_round(var_c1e98979);
}

/*
	Name: killserverpc
	Namespace: globallogic
	Checksum: 0xC992C0F0
	Offset: 0x3520
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function killserverpc()
{
	if(level.hostforcedend || level.forcedend)
	{
		return;
	}
	level.forcedend = 1;
	level.hostforcedend = 1;
	level.killserver = 1;
	round::set_flag("force_end_host");
	round::function_870759fb();
	thread end_round(9);
}

/*
	Name: atleasttwoteams
	Namespace: globallogic
	Checksum: 0x2FB3800B
	Offset: 0x35C0
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function atleasttwoteams()
{
	valid_count = 0;
	foreach(team, _ in level.teams)
	{
		if(level.playercount[team] != 0)
		{
			valid_count++;
		}
	}
	if(valid_count < 2)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_f25690c1
	Namespace: globallogic
	Checksum: 0x52458607
	Offset: 0x3670
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_f25690c1(team)
{
	if(!game.everexisted[team])
	{
		return 0;
	}
	if(level.playercount[team] < 1)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_4b670b29
	Namespace: globallogic
	Checksum: 0x38381F61
	Offset: 0x36C0
	Size: 0x558
	Parameters: 0
	Flags: Linked
*/
function function_4b670b29()
{
	if(game.state != "playing")
	{
		return 0;
	}
	if(util::totalplayercount() == 0)
	{
		return 0;
	}
	params = {#hash_6eb69269:[], #hash_9648a6d7:[]};
	foreach(team, _ in level.teams)
	{
		if(function_f25690c1(team))
		{
			if(!isdefined(params.var_9648a6d7))
			{
				params.var_9648a6d7 = [];
			}
			else if(!isarray(params.var_9648a6d7))
			{
				params.var_9648a6d7 = array(params.var_9648a6d7);
			}
			params.var_9648a6d7[params.var_9648a6d7.size] = team;
			continue;
		}
		if(!isdefined(params.var_6eb69269))
		{
			params.var_6eb69269 = [];
		}
		else if(!isarray(params.var_6eb69269))
		{
			params.var_6eb69269 = array(params.var_6eb69269);
		}
		params.var_6eb69269[params.var_6eb69269.size] = team;
	}
	if(platoons::function_382a49e0() && !infection::function_74650d7())
	{
		params.var_f300b200 = [];
		foreach(team in params.var_9648a6d7)
		{
			platoon = function_22448d6c(team);
			if(platoon != #"none" && platoon != #"invalid")
			{
				if(!isdefined(params.var_f300b200))
				{
					params.var_f300b200 = [];
				}
				else if(!isarray(params.var_f300b200))
				{
					params.var_f300b200 = array(params.var_f300b200);
				}
				if(!isinarray(params.var_f300b200, platoon))
				{
					params.var_f300b200[params.var_f300b200.size] = platoon;
				}
			}
		}
		params.var_b2ee6c67 = [];
		foreach(team in params.var_6eb69269)
		{
			platoon = function_22448d6c(team);
			if(!isdefined(params.var_b2ee6c67))
			{
				params.var_b2ee6c67 = [];
			}
			else if(!isarray(params.var_b2ee6c67))
			{
				params.var_b2ee6c67 = array(params.var_b2ee6c67);
			}
			if(!isinarray(params.var_b2ee6c67, platoon))
			{
				params.var_b2ee6c67[params.var_b2ee6c67.size] = platoon;
			}
		}
		if(params.var_b2ee6c67.size == 1 && params.var_f300b200.size > 0)
		{
			thread [[level.onforfeit]](params);
			return 1;
		}
	}
	else if(params.var_6eb69269.size == 1 && params.var_9648a6d7.size > 0)
	{
		thread [[level.onforfeit]](params);
		return 1;
	}
	return 0;
}

/*
	Name: dospawnqueueupdates
	Namespace: globallogic
	Checksum: 0x30E7CE25
	Offset: 0x3C20
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
	Name: function_7b75ee16
	Namespace: globallogic
	Checksum: 0xD9486B6B
	Offset: 0x3CB8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_7b75ee16(team)
{
	if(level.playerlives[team])
	{
		return 1;
	}
	if(level.alivecount[team] - level.laststandcount[team] > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_9c839e9
	Namespace: globallogic
	Checksum: 0x63D2B12D
	Offset: 0x3D18
	Size: 0x5A2
	Parameters: 0
	Flags: Linked
*/
function function_9c839e9()
{
	params = {#teams_alive:[], #hash_46a749a8:[], #hash_8245068d:0};
	aliveteam = undefined;
	foreach(team, _ in level.teams)
	{
		if(teams::function_9dd75dad(team))
		{
			params.var_8245068d++;
			if(!teams::is_all_dead(team))
			{
				if(!isdefined(params.teams_alive))
				{
					params.teams_alive = [];
				}
				else if(!isarray(params.teams_alive))
				{
					params.teams_alive = array(params.teams_alive);
				}
				params.teams_alive[params.teams_alive.size] = team;
				continue;
			}
			if(!isdefined(params.var_46a749a8))
			{
				params.var_46a749a8 = [];
			}
			else if(!isarray(params.var_46a749a8))
			{
				params.var_46a749a8 = array(params.var_46a749a8);
			}
			params.var_46a749a8[params.var_46a749a8.size] = team;
		}
	}
	if(platoons::function_382a49e0())
	{
		params.platoons_alive = [];
		foreach(team in params.teams_alive)
		{
			platoon = function_22448d6c(team);
			if(platoon != #"invalid")
			{
				if(!isdefined(params.platoons_alive))
				{
					params.platoons_alive = [];
				}
				else if(!isarray(params.platoons_alive))
				{
					params.platoons_alive = array(params.platoons_alive);
				}
				if(!isinarray(params.platoons_alive, platoon))
				{
					params.platoons_alive[params.platoons_alive.size] = platoon;
				}
			}
		}
		params.var_eb1984d4 = [];
		foreach(team in params.var_46a749a8)
		{
			platoon = function_22448d6c(team);
			if(platoon != #"invalid" && !isdefined(params.platoons_alive[platoon]))
			{
				if(!isdefined(params.var_eb1984d4))
				{
					params.var_eb1984d4 = [];
				}
				else if(!isarray(params.var_eb1984d4))
				{
					params.var_eb1984d4 = array(params.var_eb1984d4);
				}
				if(!isinarray(params.var_eb1984d4, platoon))
				{
					params.var_eb1984d4[params.var_eb1984d4.size] = platoon;
				}
			}
		}
	}
	if(infection::function_74650d7())
	{
		params.var_dfa2cc2c = [];
		var_6c4bfa17 = infection::function_76601b7d();
		foreach(team in params.teams_alive)
		{
			if(function_22448d6c(team) != var_6c4bfa17)
			{
				params.var_dfa2cc2c[params.var_dfa2cc2c.size] = team;
			}
		}
	}
	return params;
}

/*
	Name: function_10dc43bc
	Namespace: globallogic
	Checksum: 0x4E28484E
	Offset: 0x42C8
	Size: 0xA6
	Parameters: 1
	Flags: Linked
*/
function function_10dc43bc(params)
{
	if(params.var_8245068d == 0)
	{
		return 0;
	}
	if(platoons::function_382a49e0())
	{
		if(params.platoons_alive.size == 1 && params.var_eb1984d4.size > 0)
		{
			return 1;
		}
	}
	else if(params.teams_alive.size == 1 && params.var_46a749a8.size > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_eb1c0d37
	Namespace: globallogic
	Checksum: 0xD4E91B36
	Offset: 0x4378
	Size: 0xD2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_eb1c0d37()
{
	if(level.var_f97a6ba3 && !level.var_4ad4bec3)
	{
		return 0;
	}
	foreach(team, _ in level.teams)
	{
		if(!level.var_f97a6ba3 && !level.everexisted[team])
		{
			return 0;
		}
		if(!teams::is_all_dead(team))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: dodeadeventupdates
	Namespace: globallogic
	Checksum: 0x802AF839
	Offset: 0x4458
	Size: 0x27C
	Parameters: 0
	Flags: Linked
*/
function dodeadeventupdates()
{
	if(level.teambased)
	{
		if(function_eb1c0d37())
		{
			level callback::callback(#"hash_8a248204daef7ec");
			if(isdefined(level.ondeadevent))
			{
				[[level.ondeadevent]]("all");
			}
			return 1;
		}
		foreach(team, _ in level.teams)
		{
			if(teams::function_9dd75dad(team) && !level.teameliminated[team])
			{
				if(!function_7b75ee16(team))
				{
					level.teameliminated[team] = gettime();
					level callback::callback(#"hash_4b1a02a87458f191", team);
					if(isdefined(level.ondeadevent))
					{
						[[level.ondeadevent]](team);
					}
				}
			}
		}
		platoons::function_a1d82bd3();
		params = function_9c839e9();
		if([[level.var_36a111f3]](params))
		{
			level callback::callback(#"hash_84d8c1164d90313", params);
			return 1;
		}
	}
	else if(totalalivecount() == 0 && totalplayerlives() == 0 && level.maxplayercount > 1)
	{
		level callback::callback(#"hash_8a248204daef7ec");
		if(isdefined(level.ondeadevent))
		{
			[[level.ondeadevent]]("all");
		}
		return 1;
	}
	return 0;
}

/*
	Name: isonlyoneleftaliveonteam
	Namespace: globallogic
	Checksum: 0x12434FC2
	Offset: 0x46E0
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Private
*/
private function isonlyoneleftaliveonteam(team)
{
	if(level.lastalivecount[team] <= 1)
	{
		return 0;
	}
	if(level.alivecount[team] != 1)
	{
		return 0;
	}
	if(level.playerlives[team] != 1)
	{
		return 0;
	}
	if(isdefined(level.aliveplayers[team]) && level.aliveplayers[team].size && level.aliveplayers[team][0] laststand::player_is_in_laststand())
	{
		return 0;
	}
	return 1;
}

/*
	Name: doonelefteventupdates
	Namespace: globallogic
	Checksum: 0x934D5F18
	Offset: 0x47A8
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
	Name: function_b29d2423
	Namespace: globallogic
	Checksum: 0x46038C4D
	Offset: 0x48C0
	Size: 0x2B0
	Parameters: 1
	Flags: Linked
*/
function function_b29d2423(params)
{
	/#
		if(getdvarint(#"scr_hostmigrationtest", 0) == 1)
		{
			return;
		}
	#/
	if(isdefined(level.takelivesondeath) && level.takelivesondeath)
	{
		foreach(team, _ in level.teams)
		{
			player::function_c49fc862(team);
		}
	}
	if(level.rankedmatch || level.leaguematch && !level.ingraceperiod)
	{
		if(level.teambased)
		{
			if(!level.gameforfeited)
			{
				if(function_4b670b29())
				{
					return;
				}
			}
			else if(atleasttwoteams())
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
	if(level.ingraceperiod)
	{
		return;
	}
	if(level.playerqueuedrespawn)
	{
		dospawnqueueupdates();
	}
	if(!level.numlives && !level.numteamlives && !level.var_c2cc011f && !infection::function_74650d7())
	{
		return;
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
	Name: mpintro_visionset_ramp_hold_func
	Namespace: globallogic
	Checksum: 0xFB88BA35
	Offset: 0x4B78
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function mpintro_visionset_ramp_hold_func()
{
	level endon(#"mpintro_ramp_out_notify");
	while(true)
	{
		for(player_index = 0; player_index < level.players.size; player_index++)
		{
			self visionset_mgr::set_state_active(level.players[player_index], 1);
		}
		waitframe(1);
	}
}

/*
	Name: mpintro_visionset_activate_func
	Namespace: globallogic
	Checksum: 0x5DE58516
	Offset: 0x4C00
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function mpintro_visionset_activate_func()
{
	visionset_mgr::activate("visionset", "mpintro", undefined, 0, &mpintro_visionset_ramp_hold_func, 2);
}

/*
	Name: mpintro_visionset_deactivate_func
	Namespace: globallogic
	Checksum: 0x62CFAAEA
	Offset: 0x4C48
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function mpintro_visionset_deactivate_func()
{
	level notify(#"mpintro_ramp_out_notify");
}

/*
	Name: showobjectivenotificationuiforallplayers
	Namespace: globallogic
	Checksum: 0x5D8B4D11
	Offset: 0x4C68
	Size: 0x190
	Parameters: 2
	Flags: Linked
*/
function showobjectivenotificationuiforallplayers(missiontype, delay)
{
	level endon(#"game_ended");
	if(!isdefined(delay) || delay < 2)
	{
		delay = 2;
	}
	if(sessionmodeismultiplayergame())
	{
		var_b43cb603 = getgametypesetting(#"hash_112e2ccb6a33c090");
		if(isdefined(var_b43cb603))
		{
			delay = delay + var_b43cb603;
		}
	}
	wait(delay);
	foreach(player in level.players)
	{
		team = player.pers[#"team"];
		if(team === #"spectator")
		{
			continue;
		}
		hintmessage = util::function_4a118b30(team);
		if(isdefined(hintmessage))
		{
			player luinotifyevent(#"show_gametype_objective_hint", 1, hintmessage);
		}
	}
}

/*
	Name: matchstarttimer
	Namespace: globallogic
	Checksum: 0x706191A4
	Offset: 0x4E00
	Size: 0x37C
	Parameters: 0
	Flags: Linked
*/
function matchstarttimer()
{
	mpintro_visionset_activate_func();
	waitforplayers();
	counttime = int(level.prematchperiod);
	var_5654073f = counttime >= 2;
	level.var_5654073f = var_5654073f;
	level.var_fd167bf6 = gettime() + (int(counttime * 1000));
	luinotifyevent(#"create_prematch_timer", 2, level.var_fd167bf6, var_5654073f);
	if(var_5654073f)
	{
		while(counttime > 0 && !level.gameended)
		{
			if(counttime == 2)
			{
				mpintro_visionset_deactivate_func();
			}
			if(counttime == 3)
			{
				level thread sndsetmatchsnapshot(0);
				foreach(player in level.players)
				{
					if(player.hasspawned || player.pers[#"team"] == #"spectator")
					{
						player globallogic_audio::set_music_on_player("spawnPreRise");
					}
				}
			}
			counttime--;
			var_b9ef7eae = [];
			foreach(player in level.players)
			{
				shouldplaysound = 1;
				for(var_3c0cc784 = 0; var_3c0cc784 < var_b9ef7eae.size; var_3c0cc784++)
				{
					if(player isplayeronsamemachine(var_b9ef7eae[var_3c0cc784]))
					{
						shouldplaysound = 0;
					}
				}
				if(shouldplaysound)
				{
					if(function_f99d2668())
					{
						player playlocalsound(#"hash_6a97a2aee9eb2f4");
					}
					else
					{
						player playlocalsound(#"uin_start_count_down");
					}
					var_b9ef7eae[var_b9ef7eae.size] = player;
				}
			}
			wait(1);
		}
	}
	else
	{
		mpintro_visionset_deactivate_func();
	}
	luinotifyevent(#"prematch_timer_ended", 1, var_5654073f);
}

/*
	Name: matchstarttimerskip
	Namespace: globallogic
	Checksum: 0x69654475
	Offset: 0x5188
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function matchstarttimerskip()
{
	visionsetnaked("default", 0);
}

/*
	Name: sndsetmatchsnapshot
	Namespace: globallogic
	Checksum: 0x8D345D8
	Offset: 0x51B0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function sndsetmatchsnapshot(num)
{
	waitframe(1);
	level clientfield::set("sndMatchSnapshot", num);
}

/*
	Name: notifyteamwavespawn
	Namespace: globallogic
	Checksum: 0x8EBFC01B
	Offset: 0x51F0
	Size: 0x9E
	Parameters: 2
	Flags: Linked
*/
function notifyteamwavespawn(team, time)
{
	if(time - level.lastwave[team] > int(level.wavedelay[team] * 1000))
	{
		level notify("wave_respawn_" + team);
		level.lastwave[team] = time;
		level.waveplayerspawnindex[team] = 0;
		return 1;
	}
	return 0;
}

/*
	Name: wavespawntimer
	Namespace: globallogic
	Checksum: 0xEBA2F0B1
	Offset: 0x5298
	Size: 0x1C8
	Parameters: 0
	Flags: Linked
*/
function wavespawntimer()
{
	self notify("1a95a923bdb84bdb");
	self endon("1a95a923bdb84bdb");
	level endon(#"game_ended");
	level callback::callback(#"hash_3be1213f454fa90e");
	if(isdefined(level.var_75db41a7) && gettime() >= level.var_75db41a7)
	{
		level callback::callback(#"hash_7fc21de2eaebdb3b");
		return;
	}
	while(game.state == "playing")
	{
		time = gettime();
		notified = 0;
		foreach(team, _ in level.teams)
		{
			notified = notified | notifyteamwavespawn(team, time);
		}
		if(notified)
		{
			level callback::callback(#"hash_3be1213f454fa90e");
			if(isdefined(level.var_75db41a7) && time >= level.var_75db41a7)
			{
				level callback::callback(#"hash_7fc21de2eaebdb3b");
				return;
			}
		}
		waitframe(1);
	}
}

/*
	Name: hostidledout
	Namespace: globallogic
	Checksum: 0x1CCA1B16
	Offset: 0x5468
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
	Checksum: 0xEB41D6C0
	Offset: 0x5538
	Size: 0x6C
	Parameters: 3
	Flags: Linked
*/
function incrementmatchcompletionstat(gamemode, playedorhosted, stat)
{
	if(function_f99d2668())
	{
		return;
	}
	self stats::inc_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

/*
	Name: setmatchcompletionstat
	Namespace: globallogic
	Checksum: 0x68B04F0D
	Offset: 0x55B0
	Size: 0x6C
	Parameters: 3
	Flags: None
*/
function setmatchcompletionstat(gamemode, playedorhosted, stat)
{
	if(function_f99d2668())
	{
		return;
	}
	self stats::set_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

/*
	Name: getteamscoreratio
	Namespace: globallogic
	Checksum: 0x4FA5AB72
	Offset: 0x5628
	Size: 0x14A
	Parameters: 0
	Flags: Linked
*/
function getteamscoreratio()
{
	playerteam = self.pers[#"team"];
	score = getteamscore(playerteam);
	otherteamscore = 0;
	foreach(team, _ in level.teams)
	{
		if(team == playerteam)
		{
			continue;
		}
		otherteamscore = otherteamscore + getteamscore(team);
	}
	if(level.teams.size > 1)
	{
		otherteamscore = otherteamscore / (level.teams.size - 1);
	}
	if(otherteamscore != 0)
	{
		return float(score) / float(otherteamscore);
	}
	return score;
}

/*
	Name: gethighestscore
	Namespace: globallogic
	Checksum: 0x27E8AD99
	Offset: 0x5780
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function gethighestscore()
{
	highestscore = 999999999;
	for(index = 0; index < level.players.size; index++)
	{
		player = level.players[index];
		if(player.score > highestscore)
		{
			highestscore = player.score;
		}
	}
	return highestscore;
}

/*
	Name: getnexthighestscore
	Namespace: globallogic
	Checksum: 0xC922A0EF
	Offset: 0x5810
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function getnexthighestscore(score)
{
	highestscore = 999999999;
	for(index = 0; index < level.players.size; index++)
	{
		player = level.players[index];
		if(player.score >= score)
		{
			continue;
		}
		if(player.score > highestscore)
		{
			highestscore = player.score;
		}
	}
	return highestscore;
}

/*
	Name: recordplaystyleinformation
	Namespace: globallogic
	Checksum: 0x69422001
	Offset: 0x58C0
	Size: 0x3E4
	Parameters: 0
	Flags: Linked
*/
function recordplaystyleinformation()
{
	if(!sessionmodeismultiplayergame())
	{
		return;
	}
	avgkilldistance = 0;
	percenttimemoving = 0;
	avgspeedofplayerwhenmoving = 0;
	totalkilldistances = float(self.pers[#"kill_distances"]);
	numkilldistanceentries = float(self.pers[#"num_kill_distance_entries"]);
	timeplayedmoving = float(self.pers[#"time_played_moving"]);
	timeplayedalive = float(self.pers[#"time_played_alive"]);
	totalspeedswhenmoving = float(self.pers[#"total_speeds_when_moving"]);
	numspeedswhenmovingentries = float(self.pers[#"num_speeds_when_moving_entries"]);
	totaldistancetravelled = float(self.pers[#"total_distance_travelled"]);
	movementupdatecount = float(self.pers[#"movement_update_count"]);
	if(numkilldistanceentries > 0)
	{
		avgkilldistance = totalkilldistances / numkilldistanceentries;
	}
	movementupdatedenom = int(movementupdatecount / 5);
	if(movementupdatedenom > 0)
	{
		percenttimemoving = (numspeedswhenmovingentries / movementupdatedenom) * 100;
	}
	if(numspeedswhenmovingentries > 0)
	{
		avgspeedofplayerwhenmoving = totalspeedswhenmoving / numspeedswhenmovingentries;
	}
	recordplayerstats(self, "totalKillDistances", totalkilldistances);
	recordplayerstats(self, "numKillDistanceEntries", numkilldistanceentries);
	recordplayerstats(self, "timePlayedMoving", timeplayedmoving);
	recordplayerstats(self, "timePlayedAlive", timeplayedalive);
	recordplayerstats(self, "totalSpeedsWhenMoving", totalspeedswhenmoving);
	recordplayerstats(self, "numSpeedsWhenMovingEntries", numspeedswhenmovingentries);
	recordplayerstats(self, "averageKillDistance", avgkilldistance);
	recordplayerstats(self, "percentageOfTimeMoving", percenttimemoving);
	recordplayerstats(self, "averageSpeedDuringMatch", avgspeedofplayerwhenmoving);
	recordplayerstats(self, "totalDistanceTravelled", totaldistancetravelled);
	mpplaystyles = {#averagespeedduringmatch:avgspeedofplayerwhenmoving, #percentageoftimemoving:percenttimemoving, #averagekilldistance:avgkilldistance};
	function_92d1707f(#"hash_5cee5eb6de3811d0", mpplaystyles);
}

/*
	Name: updateandfinalizematchrecord
	Namespace: globallogic
	Checksum: 0xCC0D036C
	Offset: 0x5CB0
	Size: 0x85C
	Parameters: 0
	Flags: Linked
*/
function updateandfinalizematchrecord()
{
	/#
		if(getdvarint(#"scr_writeconfigstrings", 0) == 1)
		{
			return;
		}
	#/
	for(index = 0; index < level.players.size; index++)
	{
		player = level.players[index];
		player namespace_42fe87d::record_special_move_data_for_life(undefined);
		if(isbot(player))
		{
			continue;
		}
		player namespace_42fe87d::record_global_mp_stats_for_player_at_match_end();
		nemesis = player.pers[#"nemesis_name"];
		if(!isdefined(player.pers[#"killed_players"][nemesis]))
		{
			player.pers[#"killed_players"][nemesis] = 0;
		}
		if(!isdefined(player.pers[#"killed_by"][nemesis]))
		{
			player.pers[#"killed_by"][nemesis] = 0;
		}
		spread = player.kills - player.deaths;
		if(player.pers[#"cur_kill_streak"] > player.pers[#"best_kill_streak"])
		{
			player.pers[#"best_kill_streak"] = player.pers[#"cur_kill_streak"];
		}
		if(level.onlinegame)
		{
			teamscoreratio = player getteamscoreratio();
			scoreboardposition = getplacementforplayer(player);
			if(scoreboardposition < 0)
			{
				scoreboardposition = level.players.size;
			}
			player gamehistoryfinishmatch(4, player.kills, player.deaths, player.score, scoreboardposition, teamscoreratio);
			placement = level.placement[#"all"];
			for(otherplayerindex = 0; otherplayerindex < placement.size; otherplayerindex++)
			{
				if(level.placement[#"all"][otherplayerindex] == player)
				{
					recordplayerstats(player, "position", otherplayerindex);
				}
			}
			if(isdefined(player.pers[#"matchesplayedstatstracked"]))
			{
				gamemode = util::getcurrentgamemode();
				player incrementmatchcompletionstat(gamemode, "played", "completed");
				if(isdefined(player.pers[#"matcheshostedstatstracked"]))
				{
					player incrementmatchcompletionstat(gamemode, "hosted", "completed");
					player.pers[#"matcheshostedstatstracked"] = undefined;
				}
				player.pers[#"matchesplayedstatstracked"] = undefined;
			}
			recordplayerstats(player, "highestKillStreak", player.pers[#"best_kill_streak"]);
			recordplayerstats(player, "numUavCalled", player killstreaks::get_killstreak_usage("uav_used"));
			recordplayerstats(player, "numDogsCalleD", player killstreaks::get_killstreak_usage("dogs_used"));
			recordplayerstats(player, "numDogsKills", player.pers[#"dog_kills"]);
			recordplayerstats(player, "participation", player.pers[#"participation"]);
			recordplayerstats(player, "controllerParticipation", player.pers[#"controllerparticipation"]);
			recordplayerstats(player, "controllerParticipationChecks", player.pers[#"controllerparticipationchecks"]);
			recordplayerstats(player, "controllerParticipationChecksSkipped", player.pers[#"controllerparticipationchecksskipped"]);
			recordplayerstats(player, "controllerParticipationConsecutiveSuccessMax", player.pers[#"controllerparticipationconsecutivesuccessmax"]);
			recordplayerstats(player, "controllerParticipationConsecutiveFailureMax", player.pers[#"controllerparticipationconsecutivefailuremax"]);
			recordplayerstats(player, "controllerParticipationEndGameResult", player.pers[#"controllerparticipationendgameresult"]);
			recordplayerstats(player, "controllerParticipationInactivityWarnings", player.pers[#"controllerparticipationinactivitywarnings"]);
			recordplayerstats(player, "controllerParticipationSuccessAfterInactivityWarning", player.pers[#"controllerparticipationsuccessafterinactivitywarning"]);
			player recordplaystyleinformation();
			recordplayermatchend(player);
			function_c5906527(player);
			recordplayerstats(player, "present_at_end", 1);
			if(isdefined(player.pers) && isdefined(player.pers[#"totalmatchbonus"]))
			{
				recordplayerstats(player, "match_xp", player.pers[#"totalmatchbonus"]);
			}
			else if(isdefined(player.matchbonus))
			{
				recordplayerstats(player, "match_xp", player.matchbonus);
			}
		}
		recordplayerstats(player, "damage_dealt", player.pers[#"damagedone"]);
	}
	finalizematchrecord();
}

/*
	Name: function_c5906527
	Namespace: globallogic
	Checksum: 0x5FBC7C0E
	Offset: 0x6518
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function function_c5906527(player)
{
	if(isdefined(player.pers[#"hash_f9d3527022e8383"]))
	{
		foreach(event, count in player.pers[#"hash_f9d3527022e8383"])
		{
			function_2c666d56(player, event, count);
		}
	}
}

/*
	Name: gamehistoryplayerkicked
	Namespace: globallogic
	Checksum: 0x4F1614EE
	Offset: 0x65E0
	Size: 0x1C2
	Parameters: 0
	Flags: Linked
*/
function gamehistoryplayerkicked()
{
	teamscoreratio = self getteamscoreratio();
	scoreboardposition = getplacementforplayer(self);
	if(scoreboardposition < 0)
	{
		scoreboardposition = level.players.size;
	}
	/#
		/#
			assert(isdefined(self.kills));
		#/
		/#
			assert(isdefined(self.deaths));
		#/
		/#
			assert(isdefined(self.score));
		#/
		/#
			assert(isdefined(scoreboardposition));
		#/
		/#
			assert(isdefined(teamscoreratio));
		#/
	#/
	self gamehistoryfinishmatch(2, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio);
	if(isdefined(self.pers[#"matchesplayedstatstracked"]))
	{
		gamemode = util::getcurrentgamemode();
		self incrementmatchcompletionstat(gamemode, "played", "kicked");
		self.pers[#"matchesplayedstatstracked"] = undefined;
	}
	uploadstats(self);
	wait(1);
}

/*
	Name: gamehistoryplayerquit
	Namespace: globallogic
	Checksum: 0xCD054FEA
	Offset: 0x67B0
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function gamehistoryplayerquit()
{
	teamscoreratio = self getteamscoreratio();
	scoreboardposition = getplacementforplayer(self);
	if(scoreboardposition < 0)
	{
		scoreboardposition = level.players.size;
	}
	self gamehistoryfinishmatch(3, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio);
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
	if(!self ishost())
	{
		wait(1);
	}
}

/*
	Name: function_a50a4f61
	Namespace: globallogic
	Checksum: 0xA5A724EB
	Offset: 0x6960
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_a50a4f61(outcome)
{
	if(level.teambased)
	{
		if(outcome::function_5f24faac(outcome, "tie") || !isdefined(outcome::get_winning_team(outcome)))
		{
			demo::function_c6ae5fd6(#"game_result", level.teamindex[#"neutral"], level.teamindex[#"neutral"]);
		}
		else
		{
			demo::function_c6ae5fd6(#"game_result", level.teamindex[outcome::get_winning_team(outcome)], level.teamindex[#"neutral"]);
		}
	}
}

/*
	Name: function_9022da4e
	Namespace: globallogic
	Checksum: 0x3E956305
	Offset: 0x6A70
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_9022da4e()
{
	bb::function_a7ba460f(match::function_3624d032());
	if(sessionmodeismultiplayergame())
	{
		mpmatchfacts = {#killstreakcount:level.globalkillstreakscalled, #winner:match::function_9b24638f(), #gametime:function_f8d53445()};
		function_92d1707f(#"hash_7784f98b4b9750ec", mpmatchfacts);
	}
}

/*
	Name: function_b0a2785c
	Namespace: globallogic
	Checksum: 0x8DD73125
	Offset: 0x6B48
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_b0a2785c()
{
	if(util::hitroundlimit() || util::hitroundwinlimit())
	{
		return 5;
	}
	if(util::hitscorelimit())
	{
		return 3;
	}
	if(util::hitroundscorelimit())
	{
		return 4;
	}
	if(level.forcedend)
	{
		if(level.hostforcedend)
		{
			return 9;
		}
		return 8;
	}
	return "time limit";
}

/*
	Name: function_8111babb
	Namespace: globallogic
	Checksum: 0xB3712FAD
	Offset: 0x6BF8
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_8111babb()
{
	setmatchtalkflag("DeadChatWithDead", level.voip.deadchatwithdead);
	setmatchtalkflag("DeadChatWithTeam", level.voip.deadchatwithteam);
	setmatchtalkflag("DeadHearTeamLiving", level.voip.deadhearteamliving);
	setmatchtalkflag("DeadHearAllLiving", level.voip.deadhearallliving);
	setmatchtalkflag("EveryoneHearsEveryone", level.voip.everyonehearseveryone);
	setmatchtalkflag("DeadHearKiller", level.voip.deadhearkiller);
	setmatchtalkflag("KillersHearVictim", level.voip.killershearvictim);
	setmatchtalkflag("PartyChat", level.voip.partychat);
}

/*
	Name: function_d89bf8aa
	Namespace: globallogic
	Checksum: 0x95456F37
	Offset: 0x6D48
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_d89bf8aa()
{
	if(!is_game_over())
	{
		if(isdefined(level.nextroundisovertime) && level.nextroundisovertime)
		{
			game.overtime_round++;
		}
		player::function_2f80d95b(&val::reset, "freeze_player_for_round_end", "freezecontrols");
		player::function_2f80d95b(&val::reset, "freeze_player_for_round_end", "disablegadgets");
		player::function_2f80d95b(&clientfield::set_player_uimodel, "hudItems.hideOutcomeUI", 1);
		function_8111babb();
		function_452e18ad();
		game.state = "pregame";
		map_restart(1);
		return 1;
	}
	return 0;
}

/*
	Name: function_de2b637d
	Namespace: globallogic
	Checksum: 0x52808CB3
	Offset: 0x6E78
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function function_de2b637d(winner)
{
	if(!isdefined(winner))
	{
		return "tie";
	}
	if(isentity(winner))
	{
		return (isdefined(winner.team) ? winner.team : #"none");
	}
	return winner;
}

/*
	Name: getroundlength
	Namespace: globallogic
	Checksum: 0x639740F7
	Offset: 0x6EE8
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function getroundlength()
{
	if(!level.timelimit || level.forcedend)
	{
		gamelength = float(globallogic_utils::gettimepassed()) / 1000;
		gamelength = min(gamelength, 1200);
	}
	else
	{
		gamelength = level.timelimit * 60;
	}
	return gamelength;
}

/*
	Name: waitanduploadstats
	Namespace: globallogic
	Checksum: 0xB58EA110
	Offset: 0x6F88
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function waitanduploadstats(player, waittime)
{
	wait(waittime);
	if(isplayer(player))
	{
		uploadstats(player);
	}
}

/*
	Name: registerotherlootxpawards
	Namespace: globallogic
	Checksum: 0x7ADEEFD1
	Offset: 0x6FD8
	Size: 0xAA
	Parameters: 1
	Flags: None
*/
function registerotherlootxpawards(func)
{
	if(!isdefined(level.awardotherlootxpfunctions))
	{
		level.awardotherlootxpfunctions = [];
	}
	if(!isdefined(level.awardotherlootxpfunctions))
	{
		level.awardotherlootxpfunctions = [];
	}
	else if(!isarray(level.awardotherlootxpfunctions))
	{
		level.awardotherlootxpfunctions = array(level.awardotherlootxpfunctions);
	}
	level.awardotherlootxpfunctions[level.awardotherlootxpfunctions.size] = func;
}

/*
	Name: awardotherlootxp
	Namespace: globallogic
	Checksum: 0x6B6586B7
	Offset: 0x7090
	Size: 0xDA
	Parameters: 0
	Flags: None
*/
function awardotherlootxp()
{
	player = self;
	if(!isdefined(level.awardotherlootxpfunctions))
	{
		return 0;
	}
	if(!isplayer(player))
	{
		return 0;
	}
	lootxp = 0;
	foreach(func in level.awardotherlootxpfunctions)
	{
		if(!isdefined(func))
		{
			continue;
		}
		lootxp = lootxp + player [[func]]();
	}
	return lootxp;
}

/*
	Name: function_6c9e78d5
	Namespace: globallogic
	Checksum: 0x76190516
	Offset: 0x7178
	Size: 0x304
	Parameters: 1
	Flags: Linked, Private
*/
private function function_6c9e78d5(var_c1e98979)
{
	updateplacement();
	function_68bfd6d7();
	roundlength = getroundlength();
	var_f9adbf05 = function_70171add();
	current_time = gettime();
	game_over = is_game_over();
	players = level.players;
	foreach(player in players)
	{
		/#
			player globallogic_ui::freegameplayhudelems();
		#/
		player.pers[#"lastroundscore"] = player.pointstowin;
		player weapons::update_timings(current_time);
		player bbplayermatchend(roundlength, var_c1e98979, game_over);
		player.pers[#"totaltimeplayed"] = player.pers[#"totaltimeplayed"] + player.timeplayed[#"total"];
		if(sessionmodeisonlinegame())
		{
			player stats::function_7a850245(#"demofileid", getdemofileid());
			player stats::function_7a850245(#"matchid", function_c7c50474());
			if(level.rankedmatch)
			{
				player stats::function_7a850245("surveyId", var_f9adbf05);
			}
		}
		player stats::function_7a850245("hardcore", level.hardcoremode);
	}
	userspawnselection::closespawnselectionmenuforallplayers();
	player::function_2f80d95b(&function_5ae24200);
	if(!util::waslastround())
	{
		player::function_38de2d5a("round_ended");
	}
}

/*
	Name: is_game_over
	Namespace: globallogic
	Checksum: 0xC4810A0C
	Offset: 0x7488
	Size: 0x38
	Parameters: 0
	Flags: Linked, Private
*/
private function is_game_over()
{
	if(util::isoneround() || util::waslastround())
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_70171add
	Namespace: globallogic
	Checksum: 0xEB8AF421
	Offset: 0x74C8
	Size: 0x7E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_70171add()
{
	if(randomfloat(1) <= getdvarfloat(#"survey_chance", 0))
	{
		return randomintrange(1, getdvarint(#"survey_count", 0) + 1);
	}
	return 0;
}

/*
	Name: function_176452e3
	Namespace: globallogic
	Checksum: 0xF72E6209
	Offset: 0x7550
	Size: 0x92
	Parameters: 0
	Flags: Linked, Private
*/
private function function_176452e3()
{
	winning_team = round::get_winning_team();
	winner = round::function_9b24638f();
	if(isdefined(winner) && isdefined(level.teams[winning_team]))
	{
		level.finalkillcam_winner = winner;
	}
	else
	{
		level.finalkillcam_winner = "none";
	}
	level.finalkillcam_winnerpicked = 1;
}

/*
	Name: function_9113e843
	Namespace: globallogic
	Checksum: 0x1B137491
	Offset: 0x75F0
	Size: 0x124
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9113e843()
{
	winning_team = round::get_winning_team();
	overtime_round = round::function_5f24faac("overtime");
	if(overtime_round)
	{
		if(isdefined(game.stat[#"overtimeroundswon"][winning_team]))
		{
			game.stat[#"overtimeroundswon"][winning_team]++;
		}
	}
	if(!overtime_round || util::waslastround())
	{
		game.roundsplayed++;
		game.roundwinner[game.roundsplayed] = round::function_9b24638f();
		if(isdefined(game.stat[#"roundswon"][winning_team]))
		{
			game.stat[#"roundswon"][winning_team]++;
		}
	}
}

/*
	Name: function_e8cd6051
	Namespace: globallogic
	Checksum: 0xD6555E64
	Offset: 0x7720
	Size: 0xA2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e8cd6051()
{
	result = #"draw";
	if(!match::function_5f24faac("tie") && match::function_c10174e7())
	{
		result = match::get_winning_team();
	}
	if(result == "tie" || result == "free")
	{
		result = #"draw";
	}
	return result;
}

/*
	Name: function_d8d30361
	Namespace: globallogic
	Checksum: 0x9F752C69
	Offset: 0x77D0
	Size: 0xCC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d8d30361(var_c1e98979)
{
	setmatchflag("game_ended", 1);
	gamestate::set_state("postgame");
	level.gameendtime = gettime();
	level.gameended = 1;
	level.var_8a3a9ca4.roundend = gettime();
	setdvar(#"g_gameended", 1);
	round::function_897438f4(var_c1e98979);
	/#
		rat::function_65e13d0f();
	#/
}

/*
	Name: function_68bfd6d7
	Namespace: globallogic
	Checksum: 0xE184E2BF
	Offset: 0x78A8
	Size: 0xCC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_68bfd6d7()
{
	if(!is_game_over())
	{
		game_winner = round::function_9b24638f();
	}
	else
	{
		game_winner = match::function_6d0354e3();
		var_8dbf2a6d = globallogic_score::function_15683f39();
		if(isdefined(var_8dbf2a6d) && isdefined(var_8dbf2a6d.var_9cd2c51d))
		{
			var_8dbf2a6d stats::function_dad108fa(#"hash_a4542d8005dba09", 1);
			var_8dbf2a6d contracts::function_a54e2068(#"hash_117aee9968655de3");
		}
	}
}

/*
	Name: function_dd9663e5
	Namespace: globallogic
	Checksum: 0xFCC39B70
	Offset: 0x7980
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_dd9663e5()
{
	callback::function_daed27e8(#"on_end_game");
	callback::function_bea20a96(#"on_end_game");
	level notify(#"game_ended");
	level clientfield::set("gameplay_started", 0);
	level clientfield::set("game_ended", 1);
}

/*
	Name: function_4720c07f
	Namespace: globallogic
	Checksum: 0x7B49E9
	Offset: 0x7A20
	Size: 0x264
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4720c07f(outcome)
{
	level.ingraceperiod = 0;
	function_dd9663e5();
	if(!isdefined(level.disableoutrovisionset) || level.disableoutrovisionset == 0)
	{
		visionsetnaked("mpOutro", 2);
	}
	setmatchflag("cg_drawSpectatorMessages", 0);
	globallogic_audio::flush_dialog();
	foreach(team, _ in level.teams)
	{
		game.lastroundscore[team] = getteamscore(team);
	}
	if(util::isroundbased())
	{
		matchrecordroundend();
	}
	function_9113e843();
	function_176452e3();
	thread setroundswonuimodels();
	setgameendtime(0);
	updaterankedmatch(outcome);
	setmatchtalkflag("EveryoneHearsEveryone", 1);
	gamerep::gamerepupdateinformationforround();
	thread challenges::roundend(round::function_9b24638f());
	function_6c9e78d5(outcome.var_c1e98979);
	gameobjects::function_407c83be();
	globallogic_utils::function_8d61a6c2(outcome.var_c1e98979);
	function_a50a4f61(outcome);
}

/*
	Name: function_566a70ad
	Namespace: globallogic
	Checksum: 0x9A1F02B8
	Offset: 0x7C90
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_566a70ad(var_c139bfe2)
{
	level.var_49d9aa70 = 0.25;
	level.var_db945f12 = level.roundenddelay[var_c139bfe2] / 4;
	setslowmotion(1, level.var_49d9aa70, level.var_db945f12);
}

/*
	Name: function_2556afb5
	Namespace: globallogic
	Checksum: 0x87847C5A
	Offset: 0x7D08
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function function_2556afb5(scale_start, scale_end, transition_time)
{
	level.var_49d9aa70 = scale_end;
	setslowmotion(scale_start, scale_end, transition_time);
}

/*
	Name: function_452e18ad
	Namespace: globallogic
	Checksum: 0xC4F59658
	Offset: 0x7D58
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_452e18ad()
{
	level.var_49d9aa70 = 1;
	setslowmotion(1, 1, 0);
}

/*
	Name: function_8b4fc766
	Namespace: globallogic
	Checksum: 0x7F58981F
	Offset: 0x7DA0
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_8b4fc766(var_c1e98979)
{
	switch(var_c1e98979)
	{
		case 0:
		case 9:
		case 10:
		{
			return 0;
		}
		default:
		{
			return 1;
		}
	}
	return 1;
}

/*
	Name: function_a3e3bd39
	Namespace: globallogic
	Checksum: 0xF0FD15A9
	Offset: 0x7E18
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_a3e3bd39(winning_team, var_c1e98979)
{
	if(level.var_23b92e65 === 1)
	{
		return;
	}
	level.var_23b92e65 = 1;
	/#
		assert(isdefined(winning_team));
	#/
	if(function_8b4fc766(var_c1e98979))
	{
		globallogic_score::giveteamscoreforobjective_delaypostprocessing(winning_team, 1);
	}
	round::function_d1e740f6(winning_team);
	thread end_round(var_c1e98979);
}

/*
	Name: function_61e80d63
	Namespace: globallogic
	Checksum: 0xFAF93E24
	Offset: 0x7EE0
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_61e80d63()
{
	if(level.teambased)
	{
		function_a3e3bd39(game.defenders, 2);
	}
	else
	{
		end_round(2);
	}
}

/*
	Name: function_543ac649
	Namespace: globallogic
	Checksum: 0x350D8AC5
	Offset: 0x7F38
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_543ac649()
{
	if(level.teambased)
	{
		round::function_d1e740f6(game.defenders);
	}
	end_round(2);
}

/*
	Name: function_692f2157
	Namespace: globallogic
	Checksum: 0x9D22FFC3
	Offset: 0x7F88
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_692f2157()
{
	if(isalive(self))
	{
		self.deathtime = 0;
		self.pers[#"deathtime"] = 0;
	}
}

/*
	Name: end_round
	Namespace: globallogic
	Checksum: 0xE923D9C6
	Offset: 0x7FD8
	Size: 0x254
	Parameters: 1
	Flags: Linked
*/
function end_round(var_c1e98979)
{
	if(sessionmodeismultiplayergame() && var_c1e98979 === 6)
	{
		if(isdefined(level.var_81536c1d) && level.var_81536c1d)
		{
			return;
		}
		level.var_81536c1d = 1;
		if(!isdefined(level.var_a5c930dd))
		{
			level.var_a5c930dd = 0;
		}
		if(!isdefined(level.var_697b1d55))
		{
			level.var_697b1d55 = 0;
		}
		do
		{
			waitframe(1);
			endtime = gettime() - (2 * (float(function_60d95f53()) / 1000));
		}
		while(level.lastslowprocessframe > endtime || level.var_a5c930dd > endtime || level.var_697b1d55 > endtime);
	}
	if(gamestate::is_game_over() || level.gameended)
	{
		return;
	}
	player::function_2f80d95b(&function_692f2157);
	function_d8d30361(var_c1e98979);
	level clientfield::set_world_uimodel("hudItems.specialistSwitchIsLethal", 0);
	if(isdefined(level.var_f6d301b))
	{
		[[level.var_f6d301b]](var_c1e98979);
	}
	outcome = hud_message::function_a2f30ab4(1, var_c1e98979, 0, round::function_f37f02fc());
	function_4720c07f(outcome);
	overtime::function_f435f4dd();
	namespace_81c567a8::function_26654e7e(outcome);
	if(!function_d89bf8aa())
	{
		beacon_cp_biodomes_server_room_top_floor_door_rumble();
	}
}

/*
	Name: function_f30cfedb
	Namespace: globallogic
	Checksum: 0x1B33020F
	Offset: 0x8238
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f30cfedb()
{
	if(util::isoneround())
	{
		var_c1e98979 = round::function_3624d032();
	}
	else
	{
		var_c1e98979 = function_b0a2785c();
	}
	match::function_897438f4(var_c1e98979);
}

/*
	Name: function_3526a519
	Namespace: globallogic
	Checksum: 0x8E0F3622
	Offset: 0x82A8
	Size: 0x214
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3526a519()
{
	var_e61d6eb0 = [];
	foreach(vehicle in level.var_8819644a)
	{
		if(!isdefined(vehicle))
		{
			continue;
		}
		data = {#used:isdefined(vehicle.used) && vehicle.used, #type:vehicle.vehicletype, #pos_z:vehicle.origin[2], #pos_y:vehicle.origin[1], #pos_x:vehicle.origin[0]};
		if(!isdefined(var_e61d6eb0))
		{
			var_e61d6eb0 = [];
		}
		else if(!isarray(var_e61d6eb0))
		{
			var_e61d6eb0 = array(var_e61d6eb0);
		}
		var_e61d6eb0[var_e61d6eb0.size] = data;
		if(var_e61d6eb0.size >= 100)
		{
			function_92d1707f(#"hash_55f923de6ff3632b", #"entries", var_e61d6eb0);
			var_e61d6eb0 = [];
			wait(0.1);
		}
	}
	if(var_e61d6eb0.size > 0)
	{
		function_92d1707f(#"hash_55f923de6ff3632b", #"entries", var_e61d6eb0);
	}
}

/*
	Name: function_e4335431
	Namespace: globallogic
	Checksum: 0x979E99DF
	Offset: 0x84C8
	Size: 0x27C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e4335431()
{
	var_726f6c6 = [];
	foreach(stash in level.var_5862f2ce)
	{
		state = function_ffdbe8c2(stash);
		data = {#hash_fa0ba6bc:isdefined(stash.var_1ed4b650) && stash.var_1ed4b650, #hash_a7feba9c:(isdefined(stash.var_80b1d504) ? stash.var_80b1d504 : 0), #state:state, #used:state != 0, #type:stash.var_15d44120, #pos_z:stash.origin[2], #pos_y:stash.origin[1], #pos_x:stash.origin[0]};
		if(!isdefined(var_726f6c6))
		{
			var_726f6c6 = [];
		}
		else if(!isarray(var_726f6c6))
		{
			var_726f6c6 = array(var_726f6c6);
		}
		var_726f6c6[var_726f6c6.size] = data;
		if(var_726f6c6.size >= 100)
		{
			function_92d1707f(#"hash_7cd6488eb92cb736", #"entries", var_726f6c6);
			var_726f6c6 = [];
			wait(0.1);
		}
	}
	if(var_726f6c6.size > 0)
	{
		function_92d1707f(#"hash_7cd6488eb92cb736", #"entries", var_726f6c6);
	}
}

/*
	Name: function_159d7b6f
	Namespace: globallogic
	Checksum: 0xA8ABFF99
	Offset: 0x8750
	Size: 0x834
	Parameters: 0
	Flags: Linked, Private
*/
private function function_159d7b6f()
{
	itemcount = function_8322cf16();
	summary = [];
	var_69cbb8c = [];
	for(i = 0; i < itemcount; i++)
	{
		if((i % 100) == 0)
		{
			wait(0.1);
		}
		item = function_b1702735(i);
		if(!isdefined(summary[item.targetname]))
		{
			summary[item.targetname] = {};
		}
		if(isdefined(item.var_a6762160))
		{
			if(!isdefined(summary[item.targetname].var_b2f6f151))
			{
				summary[item.targetname].var_b2f6f151 = [];
			}
			if(!isdefined(summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype]))
			{
				summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype] = {};
			}
			if(!isdefined(summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype].items))
			{
				summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype].items = [];
			}
			if(!isdefined(summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype].items[item.var_a6762160.name]))
			{
				summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype].items[item.var_a6762160.name] = {};
			}
			if(!isdefined(summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype].items[item.var_a6762160.name].count))
			{
				summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype].items[item.var_a6762160.name].count = 0;
			}
			summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype].items[item.var_a6762160.name].count = summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype].items[item.var_a6762160.name].count + 1;
			summary[item.targetname].var_b2f6f151[item.var_a6762160.itemtype].items[item.var_a6762160.name].rarity = hash(item.var_a6762160.rarity);
		}
		else if(!isdefined(var_69cbb8c[item.targetname]))
		{
			var_69cbb8c[item.targetname] = {};
		}
		if(!isdefined(var_69cbb8c[item.targetname].count))
		{
			var_69cbb8c[item.targetname].count = 0;
		}
		var_69cbb8c[item.targetname].count = var_69cbb8c[item.targetname].count + 1;
		continue;
	}
	wait(0.1);
	item_data = [];
	foreach(location_name, location in summary)
	{
		if(isdefined(location.var_b2f6f151))
		{
			foreach(category_name, category in location.var_b2f6f151)
			{
				if(isdefined(category.items))
				{
					foreach(item_name, item in category.items)
					{
						data = {#count:item.count, #rarity:item.rarity, #item:item_name, #category:category_name, #location:location_name};
						if(!isdefined(item_data))
						{
							item_data = [];
						}
						else if(!isarray(item_data))
						{
							item_data = array(item_data);
						}
						item_data[item_data.size] = data;
						if(item_data.size >= 100)
						{
							var_cae7fe15 = {#event_count:item_data.size, #seed:level.var_cca3647d};
							function_92d1707f(#"hash_67dcbe8b30edd15a", #"summary", var_cae7fe15, #"entries", item_data);
							item_data = [];
							wait(0.1);
						}
					}
				}
			}
		}
	}
	if(item_data.size > 0)
	{
		var_cae7fe15 = {#event_count:item_data.size, #seed:level.var_cca3647d};
		function_92d1707f(#"hash_67dcbe8b30edd15a", #"summary", var_cae7fe15, #"entries", item_data);
	}
}

/*
	Name: function_2506a4ec
	Namespace: globallogic
	Checksum: 0x5DED59A7
	Offset: 0x8F90
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2506a4ec()
{
	function_3526a519();
	wait(0.1);
	function_e4335431();
	wait(0.1);
	function_159d7b6f();
	wait(0.1);
}

/*
	Name: function_6a4a86
	Namespace: globallogic
	Checksum: 0x67113452
	Offset: 0x8FE8
	Size: 0xEC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6a4a86()
{
	result = function_e8cd6051();
	recordgameresult(result);
	player::function_2f80d95b(&namespace_42fe87d::function_96d38b95, result);
	player::function_2f80d95b(&namespace_42fe87d::record_misc_player_stats);
	skillupdate();
	if(function_f99d2668())
	{
		thread function_2506a4ec();
	}
	winner = match::function_9b24638f();
	thread challenges::gameend(winner);
	function_9022da4e();
}

/*
	Name: function_5ae24200
	Namespace: globallogic
	Checksum: 0xF527DC11
	Offset: 0x90E0
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_5ae24200()
{
	self setclientuivisibilityflag("hud_visible", 0);
	self setclientuivisibilityflag("g_compassShowEnemies", 0);
}

/*
	Name: function_a18a9342
	Namespace: globallogic
	Checksum: 0x495BC537
	Offset: 0x9130
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a18a9342()
{
	setmatchtalkflag("EveryoneHearsEveryone", 1);
	setmatchflag("cg_drawSpectatorMessages", 0);
	util::setclientsysstate("levelNotify", "streamFKsl");
	player::function_2f80d95b(&function_5ae24200);
}

/*
	Name: function_ac30613c
	Namespace: globallogic
	Checksum: 0x694D7D9F
	Offset: 0x91B8
	Size: 0x42
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ac30613c()
{
	return hud_message::function_a2f30ab4(1, match::function_3624d032(), 1, match::function_f37f02fc());
}

/*
	Name: function_bd1e54e7
	Namespace: globallogic
	Checksum: 0x9029A155
	Offset: 0x9208
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function function_bd1e54e7(outcome)
{
	stopdemorecording();
	function_a50a4f61(outcome);
}

/*
	Name: player_end_game
	Namespace: globallogic
	Checksum: 0xC29CC42C
	Offset: 0x9248
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function player_end_game()
{
	self thread [[level.spawnintermission]](0, level.usexcamsforendgame);
	self setclientuivisibilityflag("hud_visible", 1);
}

/*
	Name: function_f6928798
	Namespace: globallogic
	Checksum: 0xD5161E9B
	Offset: 0x9298
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f6928798()
{
	level.intermission = 1;
	level notify(#"hash_196a12ab46f87ead");
	player::function_2f80d95b(&player_end_game);
	level clientfield::set("post_game", 1);
}

/*
	Name: getplayerbyname
	Namespace: globallogic
	Checksum: 0xDF82232
	Offset: 0x9310
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function getplayerbyname(name)
{
	for(index = 0; index < level.players.size; index++)
	{
		player = level.players[index];
		if(isbot(player))
		{
			continue;
		}
		if(player.name == name)
		{
			return player;
		}
	}
}

/*
	Name: function_4e7d44bd
	Namespace: globallogic
	Checksum: 0x4AB8E2D3
	Offset: 0x93A0
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_4e7d44bd()
{
	foreach(team, _ in level.teams)
	{
		if(level.everexisted[team])
		{
			var_9b58638e = (isdefined(level.var_eed7c027[team]) ? level.var_eed7c027[team] : 1);
			players = getplayers(team);
			foreach(player in players)
			{
				player luinotifyevent(#"team_eliminated", 1, var_9b58638e);
			}
		}
	}
}

/*
	Name: function_9c14ee08
	Namespace: globallogic
	Checksum: 0xA536F16A
	Offset: 0x9500
	Size: 0x1F6
	Parameters: 0
	Flags: Linked
*/
function function_9c14ee08()
{
	for(index = 0; index < level.players.size; index++)
	{
		player = level.players[index];
		if(isbot(player))
		{
			continue;
		}
		var_c9b7411e = player getentitynumber();
		var_9b208b53 = 0;
		for(j = 0; j < level.players.size; j++)
		{
			if(index == j)
			{
				continue;
			}
			notplayer = level.players[j];
			if(util::function_fbce7263(player.team, notplayer.team))
			{
				var_13947986 = notplayer getentitynumber();
				killed = notplayer.pers[#"killed_by"][player.name];
				killedby = notplayer.pers[#"killed_players"][player.name];
				if(!isdefined(killed))
				{
					killed = 0;
				}
				if(!isdefined(killedby))
				{
					killedby = 0;
				}
				player luinotifyevent(#"hash_9ab42b593c66ed", 5, var_c9b7411e, var_9b208b53, var_13947986, killed, killedby);
				var_9b208b53++;
			}
		}
	}
}

/*
	Name: function_4636deca
	Namespace: globallogic
	Checksum: 0x9BC3C174
	Offset: 0x9700
	Size: 0x4E4
	Parameters: 1
	Flags: Linked
*/
function function_4636deca(player)
{
	if(isbot(player))
	{
		return;
	}
	player namespace_42fe87d::function_7569c0fb();
	nemesis = player.pers[#"nemesis_name"];
	/#
		assert(isdefined(nemesis), "" + player.name);
	#/
	/#
		assert(isstring(nemesis), (("" + nemesis) + "") + player.name);
	#/
	if(!isdefined(player.pers[#"killed_players"][nemesis]))
	{
		player.pers[#"killed_players"][nemesis] = 0;
	}
	if(!isdefined(player.pers[#"killed_by"][nemesis]))
	{
		player.pers[#"killed_by"][nemesis] = 0;
	}
	spread = player.kills - player.deaths;
	if(player.pers[#"cur_kill_streak"] > player.pers[#"best_kill_streak"])
	{
		player.pers[#"best_kill_streak"] = player.pers[#"cur_kill_streak"];
	}
	if(level.rankedmatch || level.leaguematch)
	{
		player stats::function_7a850245(#"privatematch", 0);
	}
	else
	{
		player stats::function_7a850245(#"privatematch", 1);
	}
	player setnemesisxuid(player.pers[#"nemesis_xuid"]);
	player stats::function_7a850245(#"valid", 1);
	player stats::function_7a850245(#"nemesisname", nemesis);
	player stats::function_7a850245(#"nemesisrank", player.pers[#"nemesis_rank"]);
	player stats::function_7a850245(#"nemesisrankicon", player.pers[#"nemesis_rankicon"]);
	player stats::function_7a850245(#"nemesiskills", player.pers[#"killed_players"][nemesis]);
	player stats::function_7a850245(#"nemesiskilledby", player.pers[#"killed_by"][nemesis]);
	nemesisplayerent = getplayerbyname(nemesis);
	if(isdefined(nemesisplayerent))
	{
		player stats::function_7a850245(#"nemesisheroindex", nemesisplayerent getcharacterbodytype());
	}
	clientnum = player getentitynumber();
	player stats::function_7a850245(#"clientnum", clientnum);
	characterindex = player getcharacterbodytype();
	player stats::function_7a850245(#"characterindex", characterindex);
	player stats::function_7a850245(#"gametype", level.var_12323003);
}

/*
	Name: sendafteractionreport
	Namespace: globallogic
	Checksum: 0xF1E8A904
	Offset: 0x9BF0
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function sendafteractionreport()
{
	/#
		if(getdvarint(#"scr_writeconfigstrings", 0) == 1)
		{
			return;
		}
	#/
	for(index = 0; index < level.players.size; index++)
	{
		player = level.players[index];
		function_4636deca(player);
	}
}

/*
	Name: function_5c159ad3
	Namespace: globallogic
	Checksum: 0xDA5411A
	Offset: 0x9C90
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
private function function_5c159ad3()
{
	util::preload_frontend();
	gamerep::gamerepanalyzeandreport();
	thread function_4e7d44bd();
	wait(1);
	if(!function_f99d2668())
	{
		thread sendafteractionreport();
	}
	thread function_9c14ee08();
}

/*
	Name: function_9a022fbc
	Namespace: globallogic
	Checksum: 0x27FF1C6
	Offset: 0x9D10
	Size: 0x278
	Parameters: 1
	Flags: Linked
*/
function function_9a022fbc(str_state)
{
	players = getplayers();
	var_7e05b6e9 = [];
	foreach(player in players)
	{
		if(isbot(player) || player issplitscreen())
		{
			array::add(var_7e05b6e9, player);
		}
	}
	foreach(bot in var_7e05b6e9)
	{
		arrayremovevalue(players, bot);
	}
	foreach(player in players)
	{
		lui_menu = lui::function_e810a527("FullScreenBlack");
		if(str_state == "open")
		{
			if(isdefined(lui_menu))
			{
				[[ lui_menu ]]->open(player);
				[[ lui_menu ]]->function_9cd54463(player, 1);
				[[ lui_menu ]]->function_331f9dd(player, 1);
				[[ lui_menu ]]->function_237ff433(player, int(2000));
			}
			continue;
		}
		if(isdefined(lui_menu))
		{
			[[ lui_menu ]]->close(player);
		}
	}
}

/*
	Name: beacon_cp_biodomes_server_room_top_floor_door_rumble
	Namespace: globallogic
	Checksum: 0xF04AC668
	Offset: 0x9F90
	Size: 0x304
	Parameters: 0
	Flags: Linked, Private
*/
private function beacon_cp_biodomes_server_room_top_floor_door_rumble()
{
	function_f30cfedb();
	namespace_9a8d2924::function_323c6715();
	[[level.onendgame]](match::function_3624d032());
	globallogic_score::updatewinlossstats();
	if(level.arenamatch)
	{
		arena::match_end();
	}
	function_6a4a86();
	function_a18a9342();
	outcome = function_ac30613c();
	if(util::function_8570168d())
	{
		level notify(#"result", {#outcome:outcome});
	}
	level notify(#"give_match_bonus");
	thread function_5c159ad3();
	if(!isdefined(level.skipgameend) || !level.skipgameend)
	{
		namespace_81c567a8::function_19adc0b7(outcome);
	}
	if(util::function_8570168d())
	{
		level notify(#"hash_5562cfc90ce9dfe2");
	}
	function_bd1e54e7(outcome);
	if(util::isoneround() && !namespace_81c567a8::function_81d670f5())
	{
		globallogic_utils::executepostroundevents();
	}
	function_f6928798();
	level notify(#"sfade");
	updateandfinalizematchrecord();
	if(util::function_8570168d() && (isdefined(level.b_movie) && level.b_movie))
	{
		level waittill(#"movie_done");
	}
	if(isdefined(level.end_game_video))
	{
		function_9a022fbc("open");
		level thread lui::play_movie(level.end_game_video, "fullscreen", 1, 0, 0, #"", level.var_48ea0e8c);
		level waittill(#"movie_done");
	}
	level callback::callback(#"hash_1b5be9017cd4b5fa");
	exit_level();
}

/*
	Name: exit_level
	Namespace: globallogic
	Checksum: 0x6C2472DD
	Offset: 0xA2A0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function exit_level()
{
	if(level.exitlevel)
	{
		return;
	}
	level.exitlevel = 1;
	exitlevel(0);
}

/*
	Name: gettotaltimeplayed
	Namespace: globallogic
	Checksum: 0x4E78479E
	Offset: 0xA2E0
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function gettotaltimeplayed(maxlength)
{
	totaltimeplayed = 0;
	if(isdefined(self.pers[#"totaltimeplayed"]))
	{
		totaltimeplayed = self.pers[#"totaltimeplayed"];
		if(totaltimeplayed > maxlength)
		{
			totaltimeplayed = maxlength;
		}
	}
	return totaltimeplayed;
}

/*
	Name: getroundtimeplayed
	Namespace: globallogic
	Checksum: 0x3E65C158
	Offset: 0xA358
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function getroundtimeplayed(roundlength)
{
	totaltimeplayed = 0;
	if(isdefined(self.timeplayed) && isdefined(self.timeplayed[#"total"]))
	{
		totaltimeplayed = self.timeplayed[#"total"];
		if(totaltimeplayed > roundlength)
		{
			totaltimeplayed = roundlength;
		}
	}
	return totaltimeplayed;
}

/*
	Name: bbplayermatchend
	Namespace: globallogic
	Checksum: 0xCE8D30B2
	Offset: 0xA3D8
	Size: 0x1DC
	Parameters: 3
	Flags: Linked
*/
function bbplayermatchend(gamelength, var_c1e98979, gameover)
{
	if(!sessionmodeismultiplayergame() || !isdefined(self.pers))
	{
		return;
	}
	playerrank = getplacementforplayer(self);
	totaltimeplayed = self getroundtimeplayed(gamelength);
	xuid = int(self getxuid(1));
	mpplayermatchfacts = {#specialist:self getspecialistindex(), #team:self.team, #gameover:gameover, #xuid:xuid, #playtime:int(totaltimeplayed), #sessionrank:playerrank, #endreason:var_c1e98979, #momentum:self.pers[#"momentum"], #score:self.pers[#"score"]};
	function_92d1707f(#"hash_7c173cd9201d5271", mpplayermatchfacts);
}

/*
	Name: roundenddof
	Namespace: globallogic
	Checksum: 0x8704892
	Offset: 0xA5C0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function roundenddof()
{
	self clientfield::set_to_player("player_dof_settings", 2);
}

/*
	Name: checktimelimit
	Namespace: globallogic
	Checksum: 0x29CC308E
	Offset: 0xA5F0
	Size: 0x190
	Parameters: 0
	Flags: Linked
*/
function checktimelimit()
{
	if(isdefined(level.timelimitoverride) && level.timelimitoverride)
	{
		return;
	}
	if(gamestate::is_game_over())
	{
		setgameendtime(0);
		return;
	}
	if(level.timelimit <= 0)
	{
		setgameendtime(0);
		return;
	}
	if(isdefined(level.timerpaused) && level.timerpaused)
	{
		timeremaining = globallogic_utils::gettimeremaining();
		setgameendtime(int(timeremaining) * -1);
		return;
	}
	if(isdefined(level.timerstopped) && level.timerstopped)
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
	Name: checkscorelimit
	Namespace: globallogic
	Checksum: 0x682D3BDE
	Offset: 0xA788
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
		if(!util::any_team_hit_score_limit())
		{
			return 0;
		}
	}
	else if(!isplayer(self))
	{
		return 0;
	}
	if(self.pointstowin < level.scorelimit)
	{
		return 0;
	}
	[[level.onscorelimit]]();
}

/*
	Name: checksuddendeathscorelimit
	Namespace: globallogic
	Checksum: 0x21B29AF5
	Offset: 0xA838
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function checksuddendeathscorelimit(team)
{
	if(game.state != "playing")
	{
		return 0;
	}
	if(level.roundscorelimit <= 0)
	{
		return 0;
	}
	if(level.teambased)
	{
		if(!game.teamsuddendeath[team])
		{
			return 0;
		}
	}
	else
	{
		return 0;
	}
	[[level.onscorelimit]]();
}

/*
	Name: checkroundscorelimit
	Namespace: globallogic
	Checksum: 0x665478FB
	Offset: 0xA8B8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function checkroundscorelimit()
{
	if(game.state != "playing")
	{
		return 0;
	}
	if(level.roundscorelimit <= 0)
	{
		return 0;
	}
	if(level.teambased)
	{
		if(!util::any_team_hit_round_score_limit())
		{
			return 0;
		}
	}
	else if(!isplayer(self))
	{
		return 0;
	}
	roundscorelimit = util::get_current_round_score_limit();
	if(self.pointstowin < roundscorelimit)
	{
		return 0;
	}
	[[level.onroundscorelimit]]();
}

/*
	Name: updategametypedvars
	Namespace: globallogic
	Checksum: 0x9BDCA54F
	Offset: 0xA980
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function updategametypedvars()
{
	level endon(#"game_ended");
	while(!gamestate::is_game_over())
	{
		roundlimit = math::clamp(getgametypesetting(#"roundlimit"), level.roundlimitmin, level.roundlimitmax);
		if(roundlimit != level.roundlimit)
		{
			level.roundlimit = roundlimit;
		}
		timelimit = [[level.gettimelimit]]();
		if(timelimit != level.timelimit)
		{
			level.timelimit = timelimit;
		}
		thread checktimelimit();
		scorelimit = math::clamp(getgametypesetting(#"scorelimit"), level.scorelimitmin, level.scorelimitmax);
		if(scorelimit != level.scorelimit)
		{
			level.scorelimit = scorelimit;
		}
		thread checkscorelimit();
		roundscorelimit = math::clamp(getgametypesetting(#"roundscorelimit"), level.roundscorelimitmin, level.roundscorelimitmax);
		if(roundscorelimit != level.roundscorelimit)
		{
			level.roundscorelimit = roundscorelimit;
		}
		thread checkroundscorelimit();
		if(isdefined(level.starttime))
		{
			if(globallogic_utils::gettimeremaining() < 30000)
			{
				wait(0.1);
				continue;
			}
		}
		wait(0.25);
	}
}

/*
	Name: removedisconnectedplayerfromplacement
	Namespace: globallogic
	Checksum: 0xA55E967B
	Offset: 0xABB8
	Size: 0x212
	Parameters: 0
	Flags: Linked
*/
function removedisconnectedplayerfromplacement()
{
	if(gamestate::is_shutting_down())
	{
		return;
	}
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
		assert(level.placement[#"all"].size == (numplayers - 1));
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
	Checksum: 0xFC76443A
	Offset: 0xADD8
	Size: 0x3D4
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
	if(level.teambased)
	{
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
	}
	else
	{
		for(i = 1; i < placementall.size; i++)
		{
			player = placementall[i];
			playerscore = player.pointstowin;
			for(j = i - 1; j >= 0 && (playerscore > placementall[j].pointstowin || (playerscore == placementall[j].pointstowin && player.deaths < placementall[j].deaths) || (playerscore == placementall[j].pointstowin && player.deaths == placementall[j].deaths && player.lastkilltime > placementall[j].lastkilltime)); j--)
			{
				placementall[j + 1] = placementall[j];
			}
			placementall[j + 1] = player;
		}
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
	Checksum: 0x797B510B
	Offset: 0xB1B8
	Size: 0x1E6
	Parameters: 0
	Flags: Linked
*/
function updateteamplacement()
{
	if(!level.teambased)
	{
		return;
	}
	if(!isdefined(level.placement[#"all"]))
	{
		return;
	}
	foreach(team, _ in level.teams)
	{
		placement[team] = [];
	}
	placement[#"spectator"] = [];
	placementall = level.placement[#"all"];
	placementallsize = placementall.size;
	for(i = 0; i < placementallsize; i++)
	{
		player = placementall[i];
		if(!isdefined(player))
		{
			continue;
		}
		team = player.pers[#"team"];
		placement[team][placement[team].size] = player;
	}
	foreach(team, _ in level.teams)
	{
		level.placement[team] = placement[team];
	}
}

/*
	Name: getplacementforplayer
	Namespace: globallogic
	Checksum: 0x9D2C2484
	Offset: 0xB3A8
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
	Name: istopscoringplayer
	Namespace: globallogic
	Checksum: 0x9B84E6E5
	Offset: 0xB460
	Size: 0x264
	Parameters: 1
	Flags: None
*/
function istopscoringplayer(player)
{
	topscoringplayer = 0;
	updateplacement();
	/#
		assert(level.placement[#"all"].size > 0);
	#/
	if(level.placement[#"all"].size == 0)
	{
		return 0;
	}
	if(level.teambased)
	{
		topscore = level.placement[#"all"][0].score;
		foreach(place in level.placement[#"all"])
		{
			if(place.score == 0)
			{
				break;
			}
			if(topscore > place.score)
			{
				break;
			}
			if(player == place)
			{
				topscoringplayer = 1;
				break;
			}
		}
	}
	else
	{
		topscore = level.placement[#"all"][0].pointstowin;
		foreach(place in level.placement[#"all"])
		{
			if(place.pointstowin == 0)
			{
				break;
			}
			if(topscore > place.pointstowin)
			{
				break;
			}
			if(player == place)
			{
				topscoringplayer = 1;
				break;
			}
		}
	}
	return topscoringplayer;
}

/*
	Name: sortdeadplayers
	Namespace: globallogic
	Checksum: 0xC4CE025
	Offset: 0xB6D0
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
	Checksum: 0x36A831A9
	Offset: 0xB880
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
	Checksum: 0xAEC46A22
	Offset: 0xB920
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
	Name: function_e9e52d05
	Namespace: globallogic
	Checksum: 0xDB83ED1
	Offset: 0xB9C0
	Size: 0x92
	Parameters: 0
	Flags: None
*/
function function_e9e52d05()
{
	count = 0;
	foreach(team, _ in level.teams)
	{
		if(level.alivecount[team])
		{
			count++;
		}
	}
	return count;
}

/*
	Name: initteamvariables
	Namespace: globallogic
	Checksum: 0xFAE86B4E
	Offset: 0xBA60
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function initteamvariables(team)
{
	if(!isdefined(level.alivecount))
	{
		level.alivecount = [];
	}
	if(!isdefined(level.laststandcount))
	{
		level.laststandcount = [];
	}
	level.alivecount[team] = 0;
	level.lastalivecount[team] = 0;
	if(!isdefined(level.var_f97a6ba3))
	{
		level.var_f97a6ba3 = 0;
	}
	if(!isdefined(level.var_4ad4bec3))
	{
		level.var_4ad4bec3 = 0;
	}
	if(!isdefined(game.everexisted))
	{
		game.everexisted = [];
	}
	if(!isdefined(game.everexisted[team]))
	{
		game.everexisted[team] = 0;
	}
	if(!isdefined(level.var_eed7c027))
	{
		level.var_eed7c027 = [];
	}
	level.teameliminated[team] = 0;
	level.everexisted[team] = 0;
	level.wavedelay[team] = 0;
	level.lastwave[team] = 0;
	level.waveplayerspawnindex[team] = 0;
	level.var_4ad4bec3 = 0;
	resetteamvariables(team);
}

/*
	Name: resetteamvariables
	Namespace: globallogic
	Checksum: 0xBBC42070
	Offset: 0xBBF8
	Size: 0xE2
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
	level.laststandcount[team] = 0;
	level.aliveplayers[team] = [];
	level.spawningplayers[team] = [];
	level.deadplayers[team] = [];
	level.spawnqueuemodified[team] = 0;
}

/*
	Name: updateteamstatus
	Namespace: globallogic
	Checksum: 0x978C24D0
	Offset: 0xBCE8
	Size: 0x5B4
	Parameters: 0
	Flags: Linked
*/
function updateteamstatus()
{
	level notify(#"updating_team_status");
	level endon(#"updating_team_status", #"game_ended");
	waittillframeend();
	wait(0);
	if(gamestate::is_game_over())
	{
		return;
	}
	resettimeout();
	foreach(team, _ in level.teams)
	{
		resetteamvariables(team);
	}
	if(!level.teambased)
	{
		resetteamvariables("free");
	}
	level.activeplayers = [];
	players = level.players;
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(!isdefined(player) && level.splitscreen)
		{
			continue;
		}
		if(level.teambased || player.team == #"spectator")
		{
			team = player.team;
		}
		else
		{
			team = "free";
		}
		playerclass = player.curclass;
		if(team != #"spectator" && (isdefined(playerclass) && playerclass != "" || !loadout::function_87bcb1b()))
		{
			level.playercount[team]++;
			if(isbot(player))
			{
				level.botscount[team]++;
			}
			not_quite_dead = 0;
			if(isdefined(player.overrideplayerdeadstatus))
			{
				not_quite_dead = player [[player.overrideplayerdeadstatus]]();
			}
			if(player.sessionstate == "playing")
			{
				level.alivecount[team]++;
				level.playerlives[team]++;
				player.spawnqueueindex = -1;
				if(isalive(player))
				{
					level.aliveplayers[team][level.aliveplayers[team].size] = player;
					level.activeplayers[level.activeplayers.size] = player;
					if(isdefined(player.laststand) && player.laststand)
					{
						level.laststandcount[team]++;
					}
				}
				else
				{
					level.deadplayers[team][level.deadplayers[team].size] = player;
				}
				continue;
			}
			if(not_quite_dead)
			{
				level.alivecount[team]++;
				level.playerlives[team]++;
				level.aliveplayers[team][level.aliveplayers[team].size] = player;
				continue;
			}
			level.deadplayers[team][level.deadplayers[team].size] = player;
		}
	}
	foreach(team, _ in level.deadplayers)
	{
		foreach(player in level.deadplayers[team])
		{
			if(player globallogic_spawn::mayspawn())
			{
				level.playerlives[team]++;
			}
		}
		sortdeadplayers(team);
	}
	totalalive = totalalivecount();
	if(totalalive > level.maxplayercount)
	{
		level.maxplayercount = totalalive;
	}
	teams::function_596bfb16();
	platoons::function_596bfb16();
	callback::callback(#"hash_6b7d26d34885b425", {});
}

/*
	Name: updatealivetimes
	Namespace: globallogic
	Checksum: 0x1789890F
	Offset: 0xC2A8
	Size: 0x3D4
	Parameters: 1
	Flags: Linked
*/
function updatealivetimes(team)
{
	level.alivetimesaverage[team] = 0;
	if(gamestate::is_game_over())
	{
		return;
	}
	total_player_count = 0;
	average_player_spawn_time = 0;
	total_value_count = 0;
	foreach(player in level.aliveplayers[team])
	{
		average_time = 0;
		count = 0;
		if(!isdefined(player))
		{
			continue;
		}
		if(isdefined(player.alivetimes))
		{
			foreach(time in player.alivetimes)
			{
				if(!isdefined(time))
				{
					continue;
				}
				if(time != 0)
				{
					average_time = average_time + time;
					count++;
				}
			}
		}
		if(count)
		{
			total_value_count = total_value_count + count;
			average_player_spawn_time = average_player_spawn_time + (average_time / count);
			total_player_count++;
		}
	}
	foreach(player in level.deadplayers[team])
	{
		if(!isdefined(player))
		{
			continue;
		}
		average_time = 0;
		count = 0;
		if(isdefined(player.alivetimes))
		{
			foreach(time in player.alivetimes)
			{
				if(!isdefined(time))
				{
					continue;
				}
				if(time != 0)
				{
					average_time = average_time + time;
					count++;
				}
			}
		}
		if(count)
		{
			total_value_count = total_value_count + count;
			average_player_spawn_time = average_player_spawn_time + (average_time / count);
			total_player_count++;
		}
	}
	if(total_player_count == 0 || total_value_count < 3)
	{
		level.alivetimesaverage[team] = 0;
		return;
	}
	level.alivetimesaverage[team] = average_player_spawn_time / total_player_count;
	/#
		if(getdvarint(#"hash_7d48f244ba0d0b2d", 0))
		{
			iprintln((("" + level.alivetimesaverage[#"allies"]) + "") + level.alivetimesaverage[#"axis"]);
		}
	#/
}

/*
	Name: updateallalivetimes
	Namespace: globallogic
	Checksum: 0x46E1389F
	Offset: 0xC688
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function updateallalivetimes()
{
	foreach(team, _ in level.teams)
	{
		updatealivetimes(team);
	}
}

/*
	Name: checkteamscorelimitsoon
	Namespace: globallogic
	Checksum: 0x3296041
	Offset: 0xC710
	Size: 0xD8
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
	if(globallogic_utils::gettimepassed() < int(60 * 1000))
	{
		return;
	}
	timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(team);
	if(timeleft < 1)
	{
		level notify(#"match_ending_soon", {#event:"score"});
	}
}

/*
	Name: checkplayerscorelimitsoon
	Namespace: globallogic
	Checksum: 0x5BF4AA37
	Offset: 0xC7F0
	Size: 0xE0
	Parameters: 0
	Flags: Linked
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
	if(globallogic_utils::gettimepassed() < int(60 * 1000))
	{
		return;
	}
	timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(undefined);
	if(timeleft < 1)
	{
		level notify(#"match_ending_soon", {#event:"score"});
	}
}

/*
	Name: timelimitclock
	Namespace: globallogic
	Checksum: 0x5C693FAE
	Offset: 0xC8D8
	Size: 0x450
	Parameters: 0
	Flags: Linked
*/
function timelimitclock()
{
	level endon(#"game_ended");
	waitframe(1);
	clockobject = spawn("script_origin", (0, 0, 0));
	while(!gamestate::is_game_over())
	{
		using_tickets_as_time = level.timelimit == 0 && isdefined(level.low_tickets_enabled) && isdefined(level.get_tickets_as_time);
		if(!level.timerstopped && (level.timelimit || level.low_ticket_count === 1))
		{
			if(using_tickets_as_time)
			{
				timeleftint = [[level.get_tickets_as_time]]();
			}
			else
			{
				timeleft = float(globallogic_utils::gettimeremaining()) / 1000;
				timeleftint = int(timeleft + 0.5);
			}
			if(timeleftint == 601)
			{
				util::clientnotify("notify_10");
			}
			if(timeleftint == 301)
			{
				util::clientnotify("notify_5");
			}
			if(timeleftint == 60)
			{
				util::clientnotify("notify_1");
			}
			if(timeleftint == 12)
			{
				util::clientnotify("notify_count");
			}
			if(timeleftint >= 40 && timeleftint <= 60)
			{
				level notify(#"match_ending_soon", "time");
			}
			if(timeleftint >= 30 && timeleftint <= 40)
			{
				level notify(#"match_ending_pretty_soon", "time");
			}
			if(timeleftint <= 32)
			{
				level notify(#"match_ending_vox");
			}
			if(timeleftint <= 10 || (timeleftint <= 30 && (timeleftint % 2) == 0) || (level.low_ticket_count === 1 && (timeleftint % 2) == 0) || level.very_low_ticket_count === 1)
			{
				level notify(#"match_ending_very_soon", "time");
				if(timeleftint == 0)
				{
					break;
				}
				clockobject playsound(#"mpl_ui_timer_countdown");
			}
			if(!using_tickets_as_time)
			{
				if(timeleftint <= 5)
				{
					wait(0.5);
					continue;
				}
				else if((timeleft - floor(timeleft)) >= 0.05)
				{
					wait(timeleft - floor(timeleft));
				}
			}
		}
		if(using_tickets_as_time && !level.timerstopped)
		{
			timeleftint = [[level.get_tickets_as_time]]();
			if(timeleftint <= 0)
			{
				wait(1);
			}
			else
			{
				oldtimeleftint = timeleftint;
				while(!level.timerstopped && oldtimeleftint == timeleftint && timeleftint > 0)
				{
					waitframe(1);
					timeleftint = [[level.get_tickets_as_time]]();
				}
			}
		}
		else
		{
			wait(1);
		}
	}
}

/*
	Name: timelimitclock_intermission
	Namespace: globallogic
	Checksum: 0xFBA13310
	Offset: 0xCD30
	Size: 0xB0
	Parameters: 1
	Flags: None
*/
function timelimitclock_intermission(waittime)
{
	setgameendtime(gettime() + (int(waittime * 1000)));
	clockobject = spawn("script_origin", (0, 0, 0));
	if(waittime >= 10)
	{
		wait(waittime - 10);
	}
	for(;;)
	{
		clockobject playsound(#"mpl_ui_timer_countdown");
		wait(1);
	}
}

/*
	Name: function_51350eb8
	Namespace: globallogic
	Checksum: 0x8BDCEEAC
	Offset: 0xCDE8
	Size: 0x364
	Parameters: 0
	Flags: Linked, Private
*/
private function function_51350eb8()
{
	level notify(#"hash_313ad43b34e74e96");
	gamestate::set_state("playing");
	level callback::callback(#"hash_361e06db4b210e");
	if(level.var_6aec2d48 > 0)
	{
		thread function_b4262bec();
	}
	level clientfield::set("gameplay_started", 1);
	players = getplayers();
	totalplayers = 0;
	foreach(player in players)
	{
		if(isalive(player))
		{
			totalplayers++;
		}
	}
	function_5fad41b5();
	if(isdefined(level.var_7dc1df3a) && isdefined(level.var_7dc1df3a.duration))
	{
		var_bc9cd862 = level.var_7dc1df3a.duration;
		var_2c5afb5e = (isdefined(level.var_7dc1df3a.var_e2382b29) ? level.var_7dc1df3a.var_e2382b29 : 0);
		var_b3418d40 = (isdefined(level.var_7dc1df3a.var_7be962bb) ? level.var_7dc1df3a.var_7be962bb : 0);
		var_84dc46fb = (isdefined(level.var_7dc1df3a.var_7d960258) ? level.var_7dc1df3a.var_7d960258 : 0);
		var_47f5b811 = (isdefined(level.var_7dc1df3a.var_a104a7da) ? level.var_7dc1df3a.var_a104a7da : 0);
	}
	else
	{
		var_bc9cd862 = 0;
		var_2c5afb5e = 0;
		var_b3418d40 = 0;
		var_84dc46fb = 0;
		var_47f5b811 = 0;
	}
	data = {#player_count:totalplayers, #hash_31942899:gettime(), #hash_cac41566:var_47f5b811, #hash_f0956407:var_84dc46fb, #hash_be2fca42:var_b3418d40, #hash_962b073b:var_2c5afb5e, #hash_ea8aaaef:var_bc9cd862};
	function_92d1707f(#"hash_24f510499c464072", data);
	match_record::set_stat(#"hash_5288d149bac65a79", gettime());
}

/*
	Name: function_b4262bec
	Namespace: globallogic
	Checksum: 0x4BDB861E
	Offset: 0xD158
	Size: 0x6A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b4262bec()
{
	level endon(#"game_ended");
	level.friendlyfire = level.var_78d89cdd;
	level.var_40eaa459 = 1;
	wait(level.var_6aec2d48);
	level.friendlyfire = level.var_a65e8e93;
	level.var_40eaa459 = 0;
}

/*
	Name: function_edb0e0f0
	Namespace: globallogic
	Checksum: 0xBB462F8E
	Offset: 0xD1D0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_edb0e0f0()
{
	if(util::isroundbased())
	{
		if(util::getroundsplayed() == 0)
		{
			recordmatchbegin();
		}
		matchrecordroundstart();
		if(overtime::is_overtime_round())
		{
			matchrecordovertimeround();
		}
	}
	else
	{
		recordmatchbegin();
	}
}

/*
	Name: startgame
	Namespace: globallogic
	Checksum: 0x5AEC1B64
	Offset: 0xD270
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function startgame()
{
	callback::function_98a0917d(&globallogic_utils::gametimer);
	level.timerstopped = 0;
	level.playabletimerstopped = 0;
	gamestate::set_state("pregame");
	function_8111babb();
	if(isdefined(level.custom_prematch_period))
	{
		[[level.custom_prematch_period]]();
	}
	else
	{
		prematchperiod();
	}
	if(!gamestate::is_state("pregame"))
	{
		return;
	}
	function_51350eb8();
	/#
		rat::function_7d22c1c9();
	#/
	thread showobjectivenotificationuiforallplayers(undefined, 0);
	thread timelimitclock();
	thread graceperiod();
	thread watchmatchendingsoon();
	thread globallogic_audio::announcercontroller();
	thread globallogic_audio::sndmusicfunctions();
	function_edb0e0f0();
}

/*
	Name: isprematchrequirementconditionmet
	Namespace: globallogic
	Checksum: 0x7E2A9C29
	Offset: 0xD3D8
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function isprematchrequirementconditionmet(activeteamcount)
{
	if(level.prematchrequirement == 0)
	{
		return 1;
	}
	if(level.teambased)
	{
		if(activeteamcount.size <= 1)
		{
			return 0;
		}
		foreach(teamcount in activeteamcount)
		{
			if(teamcount != level.prematchrequirement)
			{
				return 0;
			}
		}
	}
	else if(activeteamcount[#"free"] != level.prematchrequirement)
	{
		return 0;
	}
	return 1;
}

/*
	Name: waitforplayers
	Namespace: globallogic
	Checksum: 0x77D9DF23
	Offset: 0xD4C8
	Size: 0x402
	Parameters: 0
	Flags: Linked
*/
function waitforplayers()
{
	level endon(#"game_ended");
	starttime = gettime();
	playerready = 0;
	activeplayercount = 0;
	accepttestclient = 0;
	activeteamcount = [];
	player_ready = [];
	while(!playerready || activeplayercount == 0 || !isprematchrequirementconditionmet(activeteamcount))
	{
		activeplayercount = 0;
		if(level.teambased)
		{
			foreach(team, _ in level.teams)
			{
				activeteamcount[team] = 0;
			}
		}
		else
		{
			activeteamcount[#"free"] = 0;
		}
		temp_player_ready = [];
		foreach(player in level.players)
		{
			if(player istestclient() && accepttestclient == 0)
			{
				continue;
			}
			if(player.team != #"spectator")
			{
				activeplayercount++;
				player_num = player getentitynumber();
				if(isdefined(player_ready[player_num]))
				{
					temp_player_ready[player_num] = player_ready[player_num];
				}
				else
				{
					temp_player_ready[player_num] = gettime();
				}
				if((temp_player_ready[player_num] + 5000) < gettime() || player isstreamerready(-1, 1))
				{
					if(level.teambased)
					{
						activeteamcount[player.team]++;
					}
					else
					{
						activeteamcount[#"free"]++;
					}
				}
			}
			if(player isstreamerready(-1, 1))
			{
				if(playerready == 0)
				{
					level notify(#"first_player_ready", {#player:player});
				}
				playerready = 1;
			}
		}
		player_read = temp_player_ready;
		waitframe(1);
		if(gettime() - starttime > int(20 * 1000))
		{
			if(level.rankedmatch == 0 && level.arenamatch == 0)
			{
				accepttestclient = 1;
			}
		}
		if(level.rankedmatch && (gettime() - starttime) > (int(120 * 1000)))
		{
			exit_level();
			while(true)
			{
				wait(10);
			}
		}
	}
}

/*
	Name: prematchwaitingforplayers
	Namespace: globallogic
	Checksum: 0x72BCC848
	Offset: 0xD8D8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function prematchwaitingforplayers()
{
	if(level.prematchrequirement != 0)
	{
		level waittill(#"first_player_ready");
		luinotifyevent(#"prematch_waiting_for_players");
	}
}

/*
	Name: prematchperiod
	Namespace: globallogic
	Checksum: 0x29154DD6
	Offset: 0xD930
	Size: 0x2A4
	Parameters: 0
	Flags: Linked
*/
function prematchperiod()
{
	setmatchflag("hud_hardcore", level.hardcoremode);
	level endon(#"game_ended");
	globallogic_audio::sndmusicsetrandomizer();
	if(draft::is_draft_this_round())
	{
		level thread draft::start();
		level waittill(#"draft_complete");
		if(isdefined(level.var_f3e25805))
		{
			level thread [[level.var_f3e25805]]();
		}
		function_654d64ea();
	}
	else if(isdefined(level.var_f3e25805))
	{
		level thread [[level.var_f3e25805]]();
	}
	if(isdefined(level.var_86513cd0))
	{
		[[level.var_86513cd0]]();
	}
	thread matchstarttimer();
	if(level.prematchperiod > 0)
	{
		thread prematchwaitingforplayers();
		waitforplayers();
		wait(level.prematchperiod);
	}
	else
	{
		matchstarttimerskip();
		waitframe(1);
	}
	level.inprematchperiod = 0;
	level thread sndsetmatchsnapshot(0);
	foreach(player in level.players)
	{
		player val::reset(#"spawn_player", "freezecontrols");
		player val::reset(#"spawn_player", "disablegadgets");
		player enableweapons();
		player callback::callback(#"hash_1303178bdaf337b5");
	}
	level callback::callback(#"hash_1303178bdaf337b5");
}

/*
	Name: graceperiod
	Namespace: globallogic
	Checksum: 0xC744672
	Offset: 0xDBE0
	Size: 0x16C
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
	if(gamestate::is_game_over())
	{
		return;
	}
	if(level.numlives)
	{
		players = level.players;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player.hasspawned && player.sessionteam != #"spectator" && !isalive(player))
			{
				player.statusicon = "hud_status_dead";
			}
		}
	}
	level thread updateteamstatus();
	level thread updateallalivetimes();
}

/*
	Name: watchmatchendingsoon
	Namespace: globallogic
	Checksum: 0xF8D439F
	Offset: 0xDD58
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
	Name: anyteamhaswavedelay
	Namespace: globallogic
	Checksum: 0x61CA1C2D
	Offset: 0xDDC8
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
	Name: setteamlivesuimodels
	Namespace: globallogic
	Checksum: 0x37439A74
	Offset: 0xDE58
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function setteamlivesuimodels()
{
	waitframe(1);
	if(level.numteamlives > 0)
	{
		allieslivescount = 0;
		axislivescount = 0;
		if(isdefined(game.lives))
		{
			allieslivescount = level.numteamlives;
			axislivescount = level.numteamlives;
		}
		clientfield::set_world_uimodel("hudItems.team1.livesCount", allieslivescount);
		clientfield::set_world_uimodel("hudItems.team2.livesCount", axislivescount);
	}
}

/*
	Name: function_8af3b312
	Namespace: globallogic
	Checksum: 0xD3B926FC
	Offset: 0xDEF8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_8af3b312()
{
	if(isdefined(level.var_cdb8ae2c))
	{
		[[level.var_cdb8ae2c]]();
	}
	influencers::create_map_placed_influencers();
	globallogic_spawn::addspawns();
}

/*
	Name: function_98a0917d
	Namespace: globallogic
	Checksum: 0xED08266F
	Offset: 0xDF48
	Size: 0x38
	Parameters: 0
	Flags: Linked
*/
function function_98a0917d()
{
	wavedelay = level.waverespawndelay;
	if(wavedelay)
	{
		level thread [[level.wavespawntimer]]();
	}
}

/*
	Name: function_b9b7618
	Namespace: globallogic
	Checksum: 0x58D9CD04
	Offset: 0xDF88
	Size: 0x1964
	Parameters: 0
	Flags: Linked
*/
function function_b9b7618()
{
	level.prematchrequirement = 0;
	level.prematchperiod = 0;
	level.intermission = 0;
	setmatchflag("cg_drawSpectatorMessages", 1);
	setmatchflag("game_ended", 0);
	if(!isdefined(game.gamestarted))
	{
		/#
			assert(isdefined(game.attackers) && isdefined(game.defenders));
		#/
		/#
			assert(game.attackers != game.defenders);
		#/
		if(!isdefined(game.state))
		{
			game.state = "pregame";
		}
		gamestate::set_state(game.state);
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
		game.strings[#"item_on_respawn"] = #"hash_220160808c99fe71";
		game.strings[#"hash_b71875e85956ea"] = #"hash_61f8bf2959b7bd5a";
		game.strings[#"last_stand"] = #"hash_5732d212e4511a00";
		game.strings[#"cowards_way"] = #"hash_268e464278a2f8ff";
		[[level.onprecachegametype]]();
		game.gamestarted = 1;
		game.totalkills = 0;
		foreach(team, _ in level.teams)
		{
			if(!isdefined(game.migratedhost))
			{
				game.stat[#"teamscores"][team] = 0;
			}
			game.teamsuddendeath[team] = 0;
			game.totalkillsteam[team] = 0;
		}
		level.prematchrequirement = getgametypesetting(#"prematchrequirement");
		level.prematchperiod = getgametypesetting(#"prematchperiod");
		/#
			prematchperiodoverride = getdvarint(#"prematchperiodoverride", -1);
			if(prematchperiodoverride >= 0)
			{
				level.prematchperiod = prematchperiodoverride;
			}
		#/
	}
	else if(!level.splitscreen)
	{
		level.prematchperiod = getgametypesetting(#"preroundperiod");
	}
	/#
		preroundperiodoverride = getdvarint(#"preroundperiodoverride", -1);
		if(preroundperiodoverride >= 0)
		{
			level.prematchperiod = preroundperiodoverride;
		}
	#/
	if(!isdefined(game.timepassed))
	{
		game.timepassed = 0;
	}
	if(!isdefined(game.playabletimepassed))
	{
		game.playabletimepassed = 0;
	}
	round::function_6343685();
	level.skipvote = 0;
	level.gameended = 0;
	level.exitlevel = 0;
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
	level.alwaysusestartspawns = 0;
	level.usexcamsforendgame = 0;
	level.cumulativeroundscores = getgametypesetting(#"cumulativeroundscores");
	level.playerqueuedrespawn = getgametypesetting(#"playerqueuedrespawn");
	level.playerforcerespawn = getgametypesetting(#"playerforcerespawn");
	level.roundstartexplosivedelay = getgametypesetting(#"roundstartexplosivedelay");
	level.roundstartkillstreakdelay = getgametypesetting(#"roundstartkillstreakdelay");
	level.perksenabled = getgametypesetting(#"perksenabled");
	level.disableattachments = getgametypesetting(#"disableattachments");
	level.disabletacinsert = getgametypesetting(#"disabletacinsert");
	level.disablecac = getgametypesetting(#"disablecac");
	level.disableclassselection = getgametypesetting(#"disableclassselection");
	if(!isdefined(level.disableweapondrop))
	{
		level.disableweapondrop = getgametypesetting(#"disableweapondrop");
	}
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
	if(sessionmodeismultiplayergame())
	{
		level.var_90bb9821 = getgametypesetting(#"specialistmaxhealth_allies_1") - 150;
		level.minimumallowedteamkills = getgametypesetting(#"specialistteamkillsallowed_allies_1") - 1;
		level.onlyheadshots = getgametypesetting(#"specialistonlyheadshots_allies_1");
		level.allowhitmarkers = getgametypesetting(#"hash_7477eea36687a960");
	}
	else
	{
		level.var_90bb9821 = getgametypesetting(#"playermaxhealth") - 150;
		level.minimumallowedteamkills = getgametypesetting(#"teamkillpunishcount") - 1;
		level.onlyheadshots = getgametypesetting(#"onlyheadshots");
		level.allowhitmarkers = getgametypesetting(#"allowhitmarkers");
	}
	level.scoreresetondeath = getgametypesetting(#"scoreresetondeath");
	level.var_f68b214e = getgametypesetting(#"hash_12305baed865fd67");
	level.var_c77de7d6 = getgametypesetting(#"hash_32da91b78e54e7b5");
	level.playerrespawndelay = getgametypesetting(#"playerrespawndelay");
	level.playerincrementalrespawndelay = getgametypesetting(#"incrementalspawndelay");
	level.playerobjectiveheldrespawndelay = getgametypesetting(#"playerobjectiveheldrespawndelay");
	level.waverespawndelay = getgametypesetting(#"waverespawndelay");
	level.suicidespawndelay = getgametypesetting(#"spawnsuicidepenalty");
	level.teamkilledspawndelay = getgametypesetting(#"spawnteamkilledpenalty");
	level.maxsuicidesbeforekick = getgametypesetting(#"maxsuicidesbeforekick");
	level.spectatetype = getgametypesetting(#"spectatetype");
	level.voip = spawnstruct();
	level.voip.deadchatwithdead = getgametypesetting(#"voipdeadchatwithdead");
	level.voip.deadchatwithteam = getgametypesetting(#"voipdeadchatwithteam");
	level.voip.deadhearallliving = getgametypesetting(#"voipdeadhearallliving");
	level.voip.deadhearteamliving = getgametypesetting(#"voipdeadhearteamliving");
	level.voip.everyonehearseveryone = getgametypesetting(#"voipeveryonehearseveryone");
	level.voip.deadhearkiller = getgametypesetting(#"voipdeadhearkiller");
	level.voip.killershearvictim = getgametypesetting(#"voipkillershearvictim");
	level.voip.partychat = getgametypesetting(#"hash_33bc6781006ae83d");
	level.droppedtagrespawn = getgametypesetting(#"droppedtagrespawn");
	setdvar(#"hash_53e6eeca9f56d0bf", getgametypesetting(#"hash_7ab596bf4932361d"));
	if(isdefined(level.droppedtagrespawn) && level.droppedtagrespawn)
	{
		dogtags::init();
	}
	gameobjects::main();
	foreach(team, _ in level.teams)
	{
		initteamvariables(team);
	}
	if(!level.teambased)
	{
		initteamvariables("free");
	}
	level.maxplayercount = 0;
	level.activeplayers = [];
	level.alivetimemaxcount = 3;
	level.alivetimesaverage = [];
	level.var_a236b703 = [];
	level.var_61952d8b = [];
	level.deaths = [];
	foreach(team, _ in level.teams)
	{
		level.alivetimesaverage[team] = 0;
		level.var_a236b703[team] = 0;
		level.var_61952d8b[team] = 0;
		level.deaths[team] = 0;
	}
	if(!isdefined(level.livesdonotreset) || !level.livesdonotreset)
	{
		if(level.teambased)
		{
			foreach(team, _ in level.teams)
			{
				game.lives[team] = level.numteamlives;
			}
			level thread setteamlivesuimodels();
		}
		else
		{
			foreach(team, _ in level.teams)
			{
				game.lives[team] = 0;
			}
		}
	}
	level.allowannouncer = getgametypesetting(#"allowannouncer");
	if(!isdefined(level.timelimit))
	{
		util::registertimelimit(1, 1440);
	}
	if(!isdefined(level.scorelimit))
	{
		util::registerscorelimit(1, 500);
	}
	if(!isdefined(level.roundscorelimit))
	{
		util::registerroundscorelimit(0, 500);
	}
	if(!isdefined(level.roundlimit))
	{
		util::registerroundlimit(0, 10);
	}
	if(!isdefined(level.roundwinlimit))
	{
		util::registerroundwinlimit(0, 10);
	}
	if(!namespace_81c567a8::function_81d670f5())
	{
		globallogic_utils::registerpostroundevent(&killcam::function_a26057ee);
		globallogic_utils::registerpostroundevent(&potm::post_round_potm);
	}
	wavedelay = level.waverespawndelay;
	if(wavedelay)
	{
		foreach(team, _ in level.teams)
		{
			level.wavedelay[team] = wavedelay;
			level.lastwave[team] = 0;
		}
	}
	level.inprematchperiod = 1;
	if(level.prematchperiod > 2 && level.rankedmatch)
	{
		level.prematchperiod = level.prematchperiod + (randomfloat(4) - 2);
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
	level.roundenddelay[0] = 3.5;
	level.roundenddelay[1] = 1.5;
	level.roundenddelay[2] = 1.5;
	level.roundenddelay[3] = 7;
	level.roundenddelay[4] = 2;
	globallogic_score::updateallteamscores();
	level.killstreaksenabled = 1;
	level.missilelockplayspacecheckenabled = 1;
	level.missilelockplayspacecheckextraradius = 18000;
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
	setclientnamemode("auto_change");
	if(getdvarint(#"custom_killstreak_mode", 0) == 1)
	{
		level.killstreaksenabled = 0;
	}
	level.var_aa5e6547 = strendswith((isdefined(level.gametype) ? level.gametype : ""), "_cwl");
	if(level.var_aa5e6547)
	{
		var_1141ae61 = getdvarfloat(#"hash_5349c39a9c2a9357", 1E-06);
		if(var_1141ae61 > 0)
		{
			var_480ff6af = (var_1141ae61 <= (1E-06) ? 0 : var_1141ae61);
			setgametypesetting("scoreHeroPowerTimeFactor", var_480ff6af);
		}
	}
	/#
		setdebugsideswitch(game.switchedsides);
	#/
}

/*
	Name: callback_startgametype
	Namespace: globallogic
	Checksum: 0xE818F8F7
	Offset: 0xF8F8
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function callback_startgametype()
{
	function_b9b7618();
	[[level.var_6c4ec3fc]]();
	gametype::function_d81f6eb7();
	callback::callback(#"on_start_gametype");
	[[level.onstartgametype]]();
	level thread function_54b079aa();
	level thread killcam::do_final_killcam();
	level thread updategametypedvars();
	thread startgame();
	level thread simple_hostmigration::updatehostmigrationdata();
	if(!(isdefined(level.var_f16f6c66) && level.var_f16f6c66))
	{
		level thread radar_sweeps::function_ce66ebf2();
	}
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
	Name: function_54b079aa
	Namespace: globallogic
	Checksum: 0xFB5A4EA7
	Offset: 0xFAB0
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_54b079aa()
{
	waittillframeend();
	while(game.state != "playing")
	{
		waitframe(1);
	}
	var_ffd5062b = 1;
	if(isdefined(level.var_324e2795) && level.var_324e2795)
	{
		var_ffd5062b = 0;
	}
	level clientfield::set_world_uimodel("hudItems.specialistSwitchIsLethal", var_ffd5062b);
}

/*
	Name: forcedebughostmigration
	Namespace: globallogic
	Checksum: 0x9DDC94C1
	Offset: 0xFB38
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
	Checksum: 0xB508E080
	Offset: 0xFB90
	Size: 0x116
	Parameters: 4
	Flags: Linked
*/
function registerfriendlyfiredelay(dvarstring, defaultvalue, minvalue, maxvalue)
{
	dvarstring = ("scr_" + dvarstring) + "_friendlyFireDelayTime";
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
	Name: listenforgameend
	Namespace: globallogic
	Checksum: 0xBA2E6446
	Offset: 0xFCB0
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
	Checksum: 0x4C44512B
	Offset: 0xFD20
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function getkillstreaks(player)
{
	for(killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++)
	{
		killstreak[killstreaknum] = "killstreak_null";
	}
	if(isplayer(player) && level.disableclassselection != 1 && !isbot(player) && isdefined(player.killstreak))
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
	Checksum: 0x670F31D7
	Offset: 0xFE40
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function updaterankedmatch(outcome)
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
	globallogic_score::updatematchbonusscores(outcome);
}

/*
	Name: annihilatorgunplayerkilleffect
	Namespace: globallogic
	Checksum: 0xBAE9E37
	Offset: 0xFEC0
	Size: 0x154
	Parameters: 3
	Flags: Linked
*/
function annihilatorgunplayerkilleffect(attacker, weapon, smeansofdeath)
{
	if(smeansofdeath == "MOD_IMPACT")
	{
		wait(weapon.fusetime / 1000);
	}
	else if(weapon.fusetime != 0)
	{
		wait(0.1);
	}
	else
	{
		wait(0.45);
	}
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(attacker))
	{
		self playsoundtoplayer(#"evt_annihilation_plr", attacker);
		self playsoundtoallbutplayer(#"evt_annihilation_npc", attacker);
	}
	codesetclientfield(self, "annihilate_effect", 1);
	earthquake(0.3, 0.75, self.origin, 500);
	wait(0.1);
	if(!isdefined(self))
	{
		return;
	}
	self notsolid();
	self ghost();
}

/*
	Name: annihilatorgunactorkilleffect
	Namespace: globallogic
	Checksum: 0x321BA1C4
	Offset: 0x10020
	Size: 0x16C
	Parameters: 2
	Flags: Linked
*/
function annihilatorgunactorkilleffect(attacker, weapon)
{
	waitresult = undefined;
	waitresult = self waittill(#"actor_corpse");
	body = waitresult.corpse;
	if(weapon.fusetime != 0)
	{
		wait(weapon.fusetime * 0.001);
	}
	else
	{
		wait(0.45);
	}
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(attacker))
	{
		self playsoundtoplayer(#"evt_annihilation_plr", attacker);
		self playsoundtoallbutplayer(#"evt_annihilation_npc", attacker);
	}
	if(!isdefined(body))
	{
		return;
	}
	codesetclientfield(body, "annihilate_effect", 1);
	body shake_and_rumble(0, 0.6, 0.2, 1);
	body notsolid();
	body ghost();
}

/*
	Name: pineapplegunplayerkilleffect
	Namespace: globallogic
	Checksum: 0xB08E63BE
	Offset: 0x10198
	Size: 0xCC
	Parameters: 1
	Flags: None
*/
function pineapplegunplayerkilleffect(attacker)
{
	wait(0.1);
	if(!isdefined(self))
	{
		return;
	}
	playsoundatposition(#"evt_annihilation_npc", self.origin);
	codesetclientfield(self, "pineapplegun_effect", 1);
	self shake_and_rumble(0, 0.3, 0.35, 1);
	wait(0.1);
	if(!isdefined(self))
	{
		return;
	}
	self notsolid();
	self ghost();
}

/*
	Name: bowplayerkilleffect
	Namespace: globallogic
	Checksum: 0x57B155B0
	Offset: 0x10270
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function bowplayerkilleffect()
{
	waitframe(1);
	if(!isdefined(self))
	{
		return;
	}
	playsoundatposition(#"evt_annihilation_npc", self.origin);
	codesetclientfield(self, "annihilate_effect", 1);
	self shake_and_rumble(0, 0.3, 0.35, 1);
	if(!isdefined(self))
	{
		return;
	}
	self notsolid();
	self ghost();
}

/*
	Name: pineapplegunactorkilleffect
	Namespace: globallogic
	Checksum: 0xFE6E8025
	Offset: 0x10338
	Size: 0x104
	Parameters: 0
	Flags: None
*/
function pineapplegunactorkilleffect()
{
	waitresult = undefined;
	waitresult = self waittill(#"actor_corpse");
	body = waitresult.corpse;
	wait(0.75);
	if(!isdefined(self))
	{
		return;
	}
	playsoundatposition(#"evt_annihilation_npc", self.origin);
	if(!isdefined(body))
	{
		return;
	}
	codesetclientfield(body, "pineapplegun_effect", 1);
	body shake_and_rumble(0, 0.3, 0.75, 1);
	body notsolid();
	body ghost();
}

/*
	Name: shake_and_rumble
	Namespace: globallogic
	Checksum: 0xF74600BA
	Offset: 0x10448
	Size: 0xEE
	Parameters: 4
	Flags: Linked
*/
function shake_and_rumble(n_delay, shake_size, shake_time, rumble_num)
{
	if(isdefined(n_delay) && n_delay > 0)
	{
		wait(n_delay);
	}
	nmagnitude = shake_size;
	nduration = shake_time;
	nradius = 500;
	v_pos = self.origin;
	earthquake(nmagnitude, nduration, v_pos, nradius);
	for(i = 0; i < rumble_num; i++)
	{
		self playrumbleonentity("damage_heavy");
		wait(0.1);
	}
}

/*
	Name: doweaponspecifickilleffects
	Namespace: globallogic
	Checksum: 0xCD9E9E17
	Offset: 0x10540
	Size: 0xAC
	Parameters: 8
	Flags: Linked
*/
function doweaponspecifickilleffects(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	if(weapon.name == "hero_pineapplegun" && isplayer(attacker) && smeansofdeath == "MOD_GRENADE")
	{
		attacker playlocalsound(#"wpn_pineapple_grenade_explode_flesh_2d");
	}
}

/*
	Name: function_e050e788
	Namespace: globallogic
	Checksum: 0xA4CDA004
	Offset: 0x105F8
	Size: 0x178
	Parameters: 4
	Flags: Linked
*/
function function_e050e788(weapon, attacker, einflictor, smeansofdeath)
{
	if(!weapon.doannihilate)
	{
		return 0;
	}
	if(randomfloat(1) > weapon.var_36c76157)
	{
		return 0;
	}
	if(!isplayer(attacker))
	{
		return 0;
	}
	if(smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_MELEE")
	{
		return 0;
	}
	if(smeansofdeath == "MOD_IMPACT" && weapon.var_6262fd11)
	{
		return 0;
	}
	if(smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" && (!(isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self)))
	{
		return 0;
	}
	return 1;
}

/*
	Name: doweaponspecificcorpseeffects
	Namespace: globallogic
	Checksum: 0x7FF52691
	Offset: 0x10778
	Size: 0x1DC
	Parameters: 9
	Flags: Linked
*/
function doweaponspecificcorpseeffects(body, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	if(!isdefined(weapon))
	{
		return;
	}
	if(function_e050e788(weapon, attacker, einflictor, smeansofdeath))
	{
		if(isactor(body))
		{
			body thread annihilatorgunactorkilleffect(attacker, weapon);
		}
		else
		{
			body thread annihilatorgunplayerkilleffect(attacker, weapon, smeansofdeath);
		}
	}
	else if(smeansofdeath == "MOD_BURNED" || (smeansofdeath == "MOD_DOT" && weapon.doesfiredamage))
	{
		if(!isactor(body))
		{
			body thread burncorpse();
		}
	}
	else if(weapon.isheavyweapon && isplayer(attacker))
	{
		if(weapon.name == #"hero_firefly_swarm")
		{
			value = randomint(2) + 1;
			if(!isactor(body))
			{
				codesetclientfield(body, "firefly_effect", value);
			}
		}
	}
}

/*
	Name: burncorpse
	Namespace: globallogic
	Checksum: 0x80B19169
	Offset: 0x10960
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function burncorpse()
{
	self endon(#"death");
	codesetclientfield(self, "burned_effect", 1);
	wait(6);
	codesetclientfield(self, "burned_effect", 0);
}

/*
	Name: function_991daa12
	Namespace: globallogic
	Checksum: 0xB420F42A
	Offset: 0x109D0
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_991daa12(weapon)
{
	if(weaponhasattachment(weapon, "ir"))
	{
		self clientfield::set_to_player("thermal_sight", 1);
	}
	if(weaponhasattachment(weapon, "uber") && weapon.rootweapon == getweapon(#"shotgun_semiauto_t8"))
	{
		self thread function_a4156fb2();
	}
}

/*
	Name: function_ec7cf015
	Namespace: globallogic
	Checksum: 0xD16FCE43
	Offset: 0x10A90
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_ec7cf015(weapon)
{
	if(weaponhasattachment(weapon, "ir"))
	{
		self clientfield::set_to_player("thermal_sight", 0);
	}
	if(weaponhasattachment(weapon, "uber") && weapon.rootweapon == getweapon(#"shotgun_semiauto_t8"))
	{
		function_b761e219();
	}
}

/*
	Name: function_fdb8b430
	Namespace: globallogic
	Checksum: 0xC3023F6E
	Offset: 0x10B50
	Size: 0x13E
	Parameters: 1
	Flags: Linked
*/
function function_fdb8b430(player)
{
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return 0;
	}
	if(!player util::isenemyteam(self.team))
	{
		return 0;
	}
	distsq = distancesquared(self.origin, player.origin);
	if(distsq > level.var_b6a8b043 * level.var_b6a8b043)
	{
		return 0;
	}
	if(!util::within_fov(self.origin, self.angles, player.origin, level.var_6090be3a))
	{
		return 0;
	}
	if(!util::within_fov(player.origin, player getplayerangles(), self.origin, level.var_6090be3a))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_a4156fb2
	Namespace: globallogic
	Checksum: 0xE5BFC504
	Offset: 0x10C98
	Size: 0x210
	Parameters: 0
	Flags: Linked
*/
function function_a4156fb2()
{
	self notify("52ea5c232e4bcf");
	self endon("52ea5c232e4bcf");
	self endon(#"strobe_off", #"death");
	level.var_b6a8b043 = getdvarint(#"hash_4c9c0fc41c430462", 500);
	level.var_6090be3a = cos(getdvarint(#"hash_fa482274b5600cc", 45));
	while(true)
	{
		var_193fd4c6 = getplayers("all", self.origin, level.var_b6a8b043 * 2);
		foreach(player in var_193fd4c6)
		{
			if(self function_fdb8b430(player))
			{
				if(!(isdefined(player.var_84c4b3e6) && player.var_84c4b3e6))
				{
					player clientfield::set_to_player("strobe_light", 1);
					player.var_84c4b3e6 = 1;
				}
				continue;
			}
			if(isdefined(player.var_84c4b3e6) && player.var_84c4b3e6)
			{
				player clientfield::set_to_player("strobe_light", 0);
				player.var_84c4b3e6 = 0;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_b761e219
	Namespace: globallogic
	Checksum: 0x138D6042
	Offset: 0x10EB0
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function function_b761e219()
{
	self notify(#"strobe_off");
	var_193fd4c6 = getplayers();
	foreach(player in var_193fd4c6)
	{
		if(!player util::isenemyteam(self.team))
		{
			continue;
		}
		if(isdefined(player.var_84c4b3e6) && player.var_84c4b3e6)
		{
			player clientfield::set_to_player("strobe_light", 0);
			player.var_84c4b3e6 = 0;
		}
	}
}

