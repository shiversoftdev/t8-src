// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5a63672f07149a55;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;

#namespace killcam;

/*
	Name: function_89f2df9
	Namespace: killcam
	Checksum: 0xD1234DE7
	Offset: 0x190
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"killcam", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: killcam
	Checksum: 0xDCABB4FB
	Offset: 0x1D8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
}

/*
	Name: init
	Namespace: killcam
	Checksum: 0x45CDF20F
	Offset: 0x208
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.killcam = getgametypesetting(#"allowkillcam");
	level.finalkillcam = getgametypesetting(#"allowfinalkillcam");
	level.killcamtime = getgametypesetting(#"killcamtime");
	level.var_a95350da = getgametypesetting(#"hash_154db5a1b2e9d757");
	level.var_7abccc83 = !function_f99d2668();
	init_final_killcam();
}

/*
	Name: end_killcam
	Namespace: killcam
	Checksum: 0xB2679AFA
	Offset: 0x2F0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function end_killcam()
{
	self.spectatorclient = -1;
	self notify(#"end_killcam");
	self setmodellodbias(0);
}

/*
	Name: function_2f7579f
	Namespace: killcam
	Checksum: 0x14B2D212
	Offset: 0x338
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_2f7579f(var_167baaa)
{
	if(!isdefined(level.var_ef3352fc))
	{
		level.var_ef3352fc = [];
	}
	level.var_ef3352fc[var_167baaa] = 1;
}

/*
	Name: get_killcam_entity_start_time
	Namespace: killcam
	Checksum: 0xC1DE7D50
	Offset: 0x388
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function get_killcam_entity_start_time(killcamentity)
{
	killcamentitystarttime = 0;
	if(isdefined(killcamentity))
	{
		if(isdefined(killcamentity.starttime))
		{
			killcamentitystarttime = killcamentity.starttime;
		}
		else
		{
			killcamentitystarttime = killcamentity.birthtime;
		}
		if(!isdefined(killcamentitystarttime))
		{
			killcamentitystarttime = 0;
		}
	}
	return killcamentitystarttime;
}

/*
	Name: store_killcam_entity_on_entity
	Namespace: killcam
	Checksum: 0x5D8531F7
	Offset: 0x3F8
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function store_killcam_entity_on_entity(killcam_entity)
{
	/#
		assert(isdefined(killcam_entity));
	#/
	self.killcamentitystarttime = get_killcam_entity_start_time(killcam_entity);
	self.killcamentityindex = killcam_entity getentitynumber();
}

/*
	Name: init_final_killcam
	Namespace: killcam
	Checksum: 0xC9CB648A
	Offset: 0x460
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function init_final_killcam()
{
	level.finalkillcamsettings = [];
	init_final_killcam_team(#"none");
	foreach(team, _ in level.teams)
	{
		init_final_killcam_team(team);
	}
	level.finalkillcam_winner = undefined;
	level.finalkillcam_winnerpicked = undefined;
}

/*
	Name: init_final_killcam_team
	Namespace: killcam
	Checksum: 0xD81CF144
	Offset: 0x530
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function init_final_killcam_team(team)
{
	level.finalkillcamsettings[team] = spawnstruct();
	clear_final_killcam_team(team);
}

/*
	Name: clear_final_killcam_team
	Namespace: killcam
	Checksum: 0x7E2D8B47
	Offset: 0x580
	Size: 0x116
	Parameters: 1
	Flags: Linked
*/
function clear_final_killcam_team(team)
{
	level.finalkillcamsettings[team].spectatorclient = undefined;
	level.finalkillcamsettings[team].weapon = undefined;
	level.finalkillcamsettings[team].meansofdeath = undefined;
	level.finalkillcamsettings[team].deathtime = undefined;
	level.finalkillcamsettings[team].deathtimeoffset = undefined;
	level.finalkillcamsettings[team].offsettime = undefined;
	level.finalkillcamsettings[team].killcam_entity_info = undefined;
	level.finalkillcamsettings[team].targetentityindex = undefined;
	level.finalkillcamsettings[team].perks = undefined;
	level.finalkillcamsettings[team].killstreaks = undefined;
	level.finalkillcamsettings[team].attacker = undefined;
}

/*
	Name: record_settings
	Namespace: killcam
	Checksum: 0x39D98819
	Offset: 0x6A0
	Size: 0x396
	Parameters: 11
	Flags: None
*/
function record_settings(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker)
{
	if(isdefined(attacker) && isdefined(attacker.team) && isdefined(level.teams[attacker.team]))
	{
		team = attacker.team;
		level.finalkillcamsettings[team].spectatorclient = spectatorclient;
		level.finalkillcamsettings[team].weapon = weapon;
		level.finalkillcamsettings[team].meansofdeath = meansofdeath;
		level.finalkillcamsettings[team].deathtime = deathtime;
		level.finalkillcamsettings[team].deathtimeoffset = deathtimeoffset;
		level.finalkillcamsettings[team].offsettime = offsettime;
		level.finalkillcamsettings[team].killcam_entity_info = killcam_entity_info;
		level.finalkillcamsettings[team].targetentityindex = targetentityindex;
		level.finalkillcamsettings[team].perks = perks;
		level.finalkillcamsettings[team].killstreaks = killstreaks;
		level.finalkillcamsettings[team].attacker = attacker;
	}
	level.finalkillcamsettings[#"none"].spectatorclient = spectatorclient;
	level.finalkillcamsettings[#"none"].weapon = weapon;
	level.finalkillcamsettings[#"none"].meansofdeath = meansofdeath;
	level.finalkillcamsettings[#"none"].deathtime = deathtime;
	level.finalkillcamsettings[#"none"].deathtimeoffset = deathtimeoffset;
	level.finalkillcamsettings[#"none"].offsettime = offsettime;
	level.finalkillcamsettings[#"none"].killcam_entity_info = killcam_entity_info;
	level.finalkillcamsettings[#"none"].targetentityindex = targetentityindex;
	level.finalkillcamsettings[#"none"].perks = perks;
	level.finalkillcamsettings[#"none"].killstreaks = killstreaks;
	level.finalkillcamsettings[#"none"].attacker = attacker;
}

/*
	Name: function_eb3deeec
	Namespace: killcam
	Checksum: 0x19BD8FA8
	Offset: 0xA40
	Size: 0x14E
	Parameters: 11
	Flags: None
*/
function function_eb3deeec(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker)
{
	player = self;
	if(spectatorclient == -1)
	{
		spectatorclient = player getentitynumber();
	}
	player.var_e59bd911 = {#attacker:attacker, #killstreaks:killstreaks, #perks:perks, #targetentityindex:targetentityindex, #killcam_entity_info:killcam_entity_info, #offsettime:offsettime, #deathtimeoffset:deathtimeoffset, #deathtime:deathtime, #meansofdeath:meansofdeath, #weapon:weapon, #spectatorclient:spectatorclient};
}

/*
	Name: function_2c8aa45e
	Namespace: killcam
	Checksum: 0x67C12DB0
	Offset: 0xB98
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function function_2c8aa45e()
{
	return isdefined(self.var_e59bd911);
}

/*
	Name: function_139c2945
	Namespace: killcam
	Checksum: 0xA19C9E6C
	Offset: 0xBB0
	Size: 0xA8
	Parameters: 0
	Flags: None
*/
function function_139c2945()
{
	if(!self function_2c8aa45e())
	{
		self.sessionstate = "spectator";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self.spectatekillcam = 0;
		return 0;
	}
	if(isdefined(self.var_e5681505) && self.var_e5681505)
	{
		return 0;
	}
	self thread deathcam(self);
	return 1;
}

/*
	Name: deathcam
	Namespace: killcam
	Checksum: 0x741C518F
	Offset: 0xC60
	Size: 0x20E
	Parameters: 1
	Flags: Linked
*/
function deathcam(victim)
{
	self endon(#"disconnect");
	self.var_e5681505 = 1;
	self clientfield::set_player_uimodel("hudItems.killcamActive", 1);
	s = victim.var_e59bd911;
	self killcam(s.spectatorclient, s.targetentityindex, s.killcam_entity_info, s.weapon, s.meansofdeath, s.deathtime, s.deathtimeoffset, s.offsettime, 0, undefined, s.perks, s.killstreaks, s.attacker, 0);
	var_9a73aefe = self.currentspectatingclient;
	self function_223716c();
	if(var_9a73aefe >= 0)
	{
		var_e1f8d08d = getentbynum(var_9a73aefe);
		if(isdefined(var_e1f8d08d))
		{
			self setcurrentspectatorclient(var_e1f8d08d);
		}
	}
	self.sessionstate = "dead";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.spectatekillcam = 0;
	self luinotifyevent(#"hash_5b2d65a026de792d", 0);
	self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
	self.var_e5681505 = undefined;
}

/*
	Name: erase_final_killcam
	Namespace: killcam
	Checksum: 0xA8ED44BA
	Offset: 0xE78
	Size: 0xB6
	Parameters: 0
	Flags: None
*/
function erase_final_killcam()
{
	clear_final_killcam_team(#"none");
	foreach(team, _ in level.teams)
	{
		clear_final_killcam_team(team);
	}
	level.finalkillcam_winner = undefined;
	level.finalkillcam_winnerpicked = undefined;
}

/*
	Name: final_killcam_waiter
	Namespace: killcam
	Checksum: 0x2D7D8C28
	Offset: 0xF38
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function final_killcam_waiter()
{
	if(level.finalkillcam_winnerpicked === 1)
	{
		level waittill(#"final_killcam_done");
	}
}

/*
	Name: post_round_final_killcam
	Namespace: killcam
	Checksum: 0xC874723C
	Offset: 0xF70
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function post_round_final_killcam()
{
	if(!level.finalkillcam)
	{
		return;
	}
	level notify(#"play_final_killcam");
	final_killcam_waiter();
}

/*
	Name: function_a26057ee
	Namespace: killcam
	Checksum: 0x3ABEBDC9
	Offset: 0xFB8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_a26057ee()
{
	if(potm::function_ec01de3())
	{
		/#
			println("");
		#/
		return;
	}
	post_round_final_killcam();
}

/*
	Name: function_de2b637d
	Namespace: killcam
	Checksum: 0xF8B62A8F
	Offset: 0x1010
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function function_de2b637d(winner)
{
	if(!isdefined(winner))
	{
		return #"none";
	}
	if(isentity(winner))
	{
		return (isdefined(winner.team) ? winner.team : #"none");
	}
	return winner;
}

/*
	Name: do_final_killcam
	Namespace: killcam
	Checksum: 0xF5BFA219
	Offset: 0x1088
	Size: 0x276
	Parameters: 0
	Flags: None
*/
function do_final_killcam()
{
	level waittill(#"play_final_killcam");
	setslowmotion(1, 1, 0);
	level.infinalkillcam = 1;
	winner = #"none";
	if(isdefined(level.finalkillcam_winner))
	{
		winner = level.finalkillcam_winner;
	}
	winning_team = function_de2b637d(winner);
	if(!isdefined(level.finalkillcamsettings[winning_team].targetentityindex))
	{
		level.infinalkillcam = 0;
		level notify(#"final_killcam_done");
		return;
	}
	attacker = level.finalkillcamsettings[winning_team].attacker;
	if(isdefined(attacker) && isdefined(attacker.archetype) && attacker.archetype == "mannequin")
	{
		level.infinalkillcam = 0;
		level notify(#"final_killcam_done");
		return;
	}
	if(isdefined(attacker))
	{
		challenges::getfinalkill(attacker);
	}
	visionsetnaked("default", 0);
	players = level.players;
	for(index = 0; index < players.size; index++)
	{
		player = players[index];
		if(!function_8b1a219a())
		{
			player closeingamemenu();
		}
		player thread final_killcam(winner);
	}
	wait(0.1);
	while(are_any_players_watching())
	{
		waitframe(1);
	}
	level notify(#"final_killcam_done");
	level.infinalkillcam = 0;
}

/*
	Name: are_any_players_watching
	Namespace: killcam
	Checksum: 0xD0FC391E
	Offset: 0x1308
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function are_any_players_watching()
{
	players = level.players;
	for(index = 0; index < players.size; index++)
	{
		player = players[index];
		if(isdefined(player.killcam))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: watch_for_skip_killcam
	Namespace: killcam
	Checksum: 0x9E564986
	Offset: 0x1380
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function watch_for_skip_killcam()
{
	self endon(#"begin_killcam");
	self waittill(#"disconnect", #"spawned");
	waitframe(1);
	level.numplayerswaitingtoenterkillcam--;
}

/*
	Name: killcam
	Namespace: killcam
	Checksum: 0xADCD6B39
	Offset: 0x13D8
	Size: 0x76A
	Parameters: 14
	Flags: Linked
*/
function killcam(attackernum, targetnum, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, respawn, maxtime, perks, killstreaks, attacker, keep_deathcam)
{
	self endon(#"disconnect", #"spawned", #"game_ended");
	if(attackernum < 0)
	{
		return;
	}
	self thread watch_for_skip_killcam();
	self callback::function_52ac9652(#"on_end_game", &on_end_game, undefined, 1);
	self callback::function_d8abfc3d(#"on_end_game", &on_end_game);
	level.numplayerswaitingtoenterkillcam++;
	if(level.numplayerswaitingtoenterkillcam > 1)
	{
		/#
			println("");
		#/
		waitframe(level.numplayerswaitingtoenterkillcam - 1);
	}
	waitframe(1);
	level.numplayerswaitingtoenterkillcam--;
	if(!function_7f088568())
	{
		/#
			println("");
		#/
		while(!function_7f088568())
		{
			waitframe(1);
		}
	}
	/#
		assert(level.numplayerswaitingtoenterkillcam > -1);
	#/
	postdeathdelay = float(gettime() - deathtime) / 1000;
	predelay = postdeathdelay + deathtimeoffset;
	killcamentitystarttime = get_killcam_entity_info_starttime(killcam_entity_info);
	camtime = calc_time(weapon, killcamentitystarttime, predelay, maxtime);
	postdelay = calc_post_delay();
	killcamlength = camtime + postdelay;
	if(isdefined(maxtime) && killcamlength > maxtime)
	{
		if(maxtime < 2)
		{
			return;
		}
		if(maxtime - camtime >= 1)
		{
			postdelay = maxtime - camtime;
		}
		else
		{
			postdelay = 1;
			camtime = maxtime - 1;
		}
		killcamlength = camtime + postdelay;
	}
	killcamoffset = camtime + predelay;
	self notify(#"begin_killcam", {#start_time:gettime()});
	if(isdefined(weapon) && weapon.name === #"straferun_rockets")
	{
		self setmodellodbias(8);
	}
	self util::clientnotify("sndDEDe");
	killcamstarttime = gettime() - int(killcamoffset * 1000);
	self.sessionstate = "spectator";
	self.spectatekillcam = 1;
	self.spectatorclient = attackernum;
	self.killcamentity = -1;
	self thread set_killcam_entities(killcam_entity_info, killcamstarttime);
	self.killcamtargetentity = targetnum;
	self.killcamweapon = weapon;
	self.killcammod = meansofdeath;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = offsettime;
	foreach(team, _ in level.teams)
	{
		self allowspectateteam(team, 1);
	}
	self allowspectateteam("freelook", 1);
	self allowspectateteam(#"none", 1);
	waitframe(1);
	if(self.archivetime <= predelay)
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self.spectatekillcam = 0;
		self end_killcam();
		return;
	}
	self thread check_for_abrupt_end();
	self.killcam = 1;
	/#
		if(!self issplitscreen() && level.perksenabled == 1)
		{
			self hud::showperks();
		}
	#/
	self thread spawned_killcam_cleanup();
	self thread wait_skip_killcam_button();
	self thread function_fa405b23();
	self thread wait_team_change_end_killcam();
	self thread wait_killcam_time();
	self thread tacticalinsertion::cancel_button_think();
	self waittill(#"end_killcam");
	self end(0);
	if(isdefined(keep_deathcam) && keep_deathcam)
	{
		return;
	}
	self.sessionstate = "dead";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.spectatekillcam = 0;
}

/*
	Name: set_entity
	Namespace: killcam
	Checksum: 0x636C3AC5
	Offset: 0x1B50
	Size: 0x7A
	Parameters: 2
	Flags: Linked
*/
function set_entity(killcamentityindex, delayms)
{
	self endon(#"disconnect", #"end_killcam", #"spawned");
	if(delayms > 0)
	{
		wait(float(delayms) / 1000);
	}
	self.killcamentity = killcamentityindex;
}

/*
	Name: set_killcam_entities
	Namespace: killcam
	Checksum: 0x2D14B804
	Offset: 0x1BD8
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function set_killcam_entities(entity_info, killcamstarttime)
{
	for(index = 0; index < entity_info.entity_indexes.size; index++)
	{
		delayms = entity_info.entity_spawntimes[index] - killcamstarttime - 100;
		thread set_entity(entity_info.entity_indexes[index], delayms);
		if(delayms <= 0)
		{
			return;
		}
	}
}

/*
	Name: wait_killcam_time
	Namespace: killcam
	Checksum: 0x769676FC
	Offset: 0x1C80
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function wait_killcam_time()
{
	self endon(#"disconnect", #"end_killcam", #"begin_killcam");
	wait(self.killcamlength - 0.05);
	self end_killcam();
}

/*
	Name: wait_final_killcam_slowdown
	Namespace: killcam
	Checksum: 0x2A7FB3CB
	Offset: 0x1CE8
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function wait_final_killcam_slowdown(deathtime, starttime)
{
	self endon(#"disconnect", #"end_killcam");
	secondsuntildeath = float(deathtime - starttime) / 1000;
	deathtime = gettime() + int(secondsuntildeath * 1000);
	waitbeforedeath = 2;
	wait(max(0, secondsuntildeath - waitbeforedeath));
	util::setclientsysstate("levelNotify", "sndFKsl");
	setslowmotion(1, 0.25, waitbeforedeath);
	wait(waitbeforedeath + 0.5);
	setslowmotion(0.25, 1, 1);
	wait(0.5);
}

/*
	Name: function_875fc588
	Namespace: killcam
	Checksum: 0x9E54BE51
	Offset: 0x1E28
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_875fc588()
{
	if(!isdefined(self.killcamsskipped))
	{
		self.killcamsskipped = 0;
	}
	self.killcamsskipped++;
	self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
	self end_killcam();
	self util::clientnotify("fkce");
}

/*
	Name: wait_skip_killcam_button
	Namespace: killcam
	Checksum: 0xE9FB3ABF
	Offset: 0x1EB0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function wait_skip_killcam_button()
{
	self endon(#"disconnect", #"end_killcam");
	while(self usebuttonpressed())
	{
		waitframe(1);
	}
	while(!self usebuttonpressed())
	{
		waitframe(1);
	}
	if(!(isdefined(self.var_eca4c67f) && self.var_eca4c67f))
	{
		function_875fc588();
	}
}

/*
	Name: function_fa405b23
	Namespace: killcam
	Checksum: 0x99DD93D9
	Offset: 0x1F50
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_fa405b23()
{
	self endon(#"disconnect", #"end_killcam");
	while(self jumpbuttonpressed())
	{
		waitframe(1);
	}
	while(!self jumpbuttonpressed())
	{
		waitframe(1);
	}
	if(!(isdefined(self.var_eca4c67f) && self.var_eca4c67f))
	{
		function_875fc588();
	}
}

/*
	Name: wait_team_change_end_killcam
	Namespace: killcam
	Checksum: 0x1BC0924B
	Offset: 0x1FF0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function wait_team_change_end_killcam()
{
	self endon(#"disconnect", #"end_killcam");
	self waittill(#"changed_class", #"joined_team");
	end(0);
	self end_killcam();
}

/*
	Name: wait_skip_killcam_safe_spawn_button
	Namespace: killcam
	Checksum: 0x2FC73384
	Offset: 0x2070
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function wait_skip_killcam_safe_spawn_button()
{
	self endon(#"disconnect", #"end_killcam");
	while(self fragbuttonpressed())
	{
		waitframe(1);
	}
	while(!self fragbuttonpressed())
	{
		waitframe(1);
	}
	self.wantsafespawn = 1;
	self end_killcam();
}

/*
	Name: end
	Namespace: killcam
	Checksum: 0xE7586B25
	Offset: 0x2108
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function end(final)
{
	self.killcam = undefined;
	self callback::function_52ac9652(#"on_end_game", &on_end_game);
	self callback::function_52ac9652(#"on_end_game", &function_f5f2d8e6);
	self thread spectating::set_permissions();
}

/*
	Name: check_for_abrupt_end
	Namespace: killcam
	Checksum: 0xB73538ED
	Offset: 0x21A0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function check_for_abrupt_end()
{
	self endon(#"disconnect", #"end_killcam");
	while(true)
	{
		if(self.archivetime <= 0)
		{
			break;
		}
		waitframe(1);
	}
	self end_killcam();
}

/*
	Name: spawned_killcam_cleanup
	Namespace: killcam
	Checksum: 0x77E05036
	Offset: 0x2210
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function spawned_killcam_cleanup()
{
	self endon(#"end_killcam", #"disconnect");
	self waittill(#"spawned");
	self end(0);
}

/*
	Name: spectator_killcam_cleanup
	Namespace: killcam
	Checksum: 0x8CEFC915
	Offset: 0x2270
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function spectator_killcam_cleanup(attacker)
{
	self endon(#"end_killcam", #"disconnect");
	attacker endon(#"disconnect");
	waitresult = undefined;
	waitresult = attacker waittill(#"begin_killcam");
	waittime = max(0, waitresult.start_time - self.deathtime - 50);
	wait(waittime);
	self end(0);
}

/*
	Name: on_end_game
	Namespace: killcam
	Checksum: 0xDDAC0FF2
	Offset: 0x2338
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function on_end_game()
{
	if(level.var_7abccc83)
	{
		self notify(#"game_ended");
		self end(0);
		self [[level.spawnspectator]](0);
	}
}

/*
	Name: function_f5f2d8e6
	Namespace: killcam
	Checksum: 0x7741C7CA
	Offset: 0x2390
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_f5f2d8e6()
{
	self notify(#"game_ended");
	self end(1);
}

/*
	Name: cancel_use_button
	Namespace: killcam
	Checksum: 0x5EEC095D
	Offset: 0x23C8
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function cancel_use_button()
{
	return self usebuttonpressed();
}

/*
	Name: cancel_safe_spawn_button
	Namespace: killcam
	Checksum: 0x777D3C85
	Offset: 0x23F0
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function cancel_safe_spawn_button()
{
	return self fragbuttonpressed();
}

/*
	Name: cancel_callback
	Namespace: killcam
	Checksum: 0xB85C2E
	Offset: 0x2418
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function cancel_callback()
{
	self.cancelkillcam = 1;
}

/*
	Name: cancel_safe_spawn_callback
	Namespace: killcam
	Checksum: 0xD257061
	Offset: 0x2438
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function cancel_safe_spawn_callback()
{
	self.cancelkillcam = 1;
	self.wantsafespawn = 1;
}

/*
	Name: cancel_on_use
	Namespace: killcam
	Checksum: 0x3CC212A9
	Offset: 0x2460
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function cancel_on_use()
{
	self thread cancel_on_use_specific_button(&cancel_use_button, &cancel_callback);
}

/*
	Name: cancel_on_use_specific_button
	Namespace: killcam
	Checksum: 0x12A8E6FB
	Offset: 0x24A0
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function cancel_on_use_specific_button(pressingbuttonfunc, finishedfunc)
{
	self endon(#"death_delay_finished", #"disconnect", #"game_ended");
	for(;;)
	{
		if(!self [[pressingbuttonfunc]]())
		{
			waitframe(1);
			continue;
		}
		buttontime = 0;
		while(self [[pressingbuttonfunc]]())
		{
			buttontime = buttontime + 0.05;
			waitframe(1);
		}
		if(buttontime >= 0.5)
		{
			continue;
		}
		buttontime = 0;
		while(!self [[pressingbuttonfunc]]() && buttontime < 0.5)
		{
			buttontime = buttontime + 0.05;
			waitframe(1);
		}
		if(buttontime >= 0.5)
		{
			continue;
		}
		self [[finishedfunc]]();
		return;
	}
}

/*
	Name: final_killcam_internal
	Namespace: killcam
	Checksum: 0x7D0D9537
	Offset: 0x25C8
	Size: 0x3E2
	Parameters: 1
	Flags: Linked
*/
function final_killcam_internal(winner)
{
	winning_team = function_de2b637d(winner);
	killcamsettings = level.finalkillcamsettings[winning_team];
	postdeathdelay = float(gettime() - killcamsettings.deathtime) / 1000;
	predelay = postdeathdelay + killcamsettings.deathtimeoffset;
	killcamentitystarttime = get_killcam_entity_info_starttime(killcamsettings.killcam_entity_info);
	camtime = calc_time(killcamsettings.weapon, killcamentitystarttime, predelay, undefined);
	postdelay = calc_post_delay();
	killcamoffset = camtime + predelay;
	killcamlength = camtime + postdelay - 0.05;
	killcamstarttime = gettime() - int(killcamoffset * 1000);
	self notify(#"begin_killcam", {#start_time:gettime()});
	util::setclientsysstate("levelNotify", "sndFKs");
	self.sessionstate = "spectator";
	self.spectatorclient = killcamsettings.spectatorclient;
	self.killcamentity = -1;
	self thread set_killcam_entities(killcamsettings.killcam_entity_info, killcamstarttime);
	self.killcamtargetentity = killcamsettings.targetentityindex;
	self.killcamweapon = killcamsettings.weapon;
	self.killcammod = killcamsettings.meansofdeath;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = killcamsettings.offsettime;
	self allowspectateallteams(1);
	self allowspectateteam("freelook", 1);
	self allowspectateteam(#"none", 1);
	self callback::function_d8abfc3d(#"on_end_game", &function_f5f2d8e6);
	waitframe(1);
	if(self.archivetime <= predelay)
	{
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self.spectatekillcam = 0;
		self end_killcam();
		return;
	}
	self thread check_for_abrupt_end();
	self.killcam = 1;
	self thread wait_killcam_time();
	self thread wait_final_killcam_slowdown(level.finalkillcamsettings[winning_team].deathtime, killcamstarttime);
	self waittill(#"end_killcam");
}

/*
	Name: final_killcam
	Namespace: killcam
	Checksum: 0xF1D11AAC
	Offset: 0x29B8
	Size: 0x254
	Parameters: 1
	Flags: Linked
*/
function final_killcam(winner)
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	if(util::waslastround())
	{
		setmatchflag("final_killcam", 1);
		setmatchflag("round_end_killcam", 0);
	}
	else
	{
		setmatchflag("final_killcam", 0);
		setmatchflag("round_end_killcam", 1);
	}
	/#
		if(getdvarint(#"scr_force_finalkillcam", 0) == 1)
		{
			setmatchflag("", 1);
			setmatchflag("", 0);
		}
	#/
	/#
		while(getdvarint(#"scr_endless_finalkillcam", 0) == 1)
		{
			final_killcam_internal(winner);
		}
	#/
	final_killcam_internal(winner);
	util::setclientsysstate("levelNotify", "sndFKe");
	luinotifyevent(#"post_killcam_transition");
	self val::set(#"killcam", "freezecontrols", 1);
	self end(1);
	setmatchflag("final_killcam", 0);
	setmatchflag("round_end_killcam", 0);
	self spawn_end_of_final_killcam();
}

/*
	Name: spawn_end_of_final_killcam
	Namespace: killcam
	Checksum: 0x3616D343
	Offset: 0x2C18
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function spawn_end_of_final_killcam()
{
	self visionset_mgr::player_shutdown();
}

/*
	Name: is_entity_weapon
	Namespace: killcam
	Checksum: 0xA7F7AED6
	Offset: 0x2C40
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function is_entity_weapon(weapon)
{
	if(weapon.statname == #"planemortar")
	{
		return 1;
	}
	return 0;
}

/*
	Name: calc_time
	Namespace: killcam
	Checksum: 0xC8359BC8
	Offset: 0x2C78
	Size: 0x142
	Parameters: 4
	Flags: Linked
*/
function calc_time(weapon, entitystarttime, predelay, maxtime)
{
	camtime = 0;
	if(getdvarstring(#"scr_killcam_time") == "")
	{
		if(is_entity_weapon(weapon))
		{
			camtime = float(gettime() - entitystarttime) / 1000 - predelay - 0.1;
		}
		else if(weapon.isgrenadeweapon)
		{
			camtime = level.var_a95350da;
		}
		else
		{
			camtime = level.killcamtime;
		}
	}
	else
	{
		camtime = getdvarfloat(#"scr_killcam_time", 0);
	}
	if(isdefined(maxtime))
	{
		if(camtime > maxtime)
		{
			camtime = maxtime;
		}
		if(camtime < 0.05)
		{
			camtime = 0.05;
		}
	}
	return camtime;
}

/*
	Name: calc_post_delay
	Namespace: killcam
	Checksum: 0xF1D0D442
	Offset: 0x2DC8
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function calc_post_delay()
{
	postdelay = 0;
	if(getdvarstring(#"scr_killcam_posttime") == "")
	{
		postdelay = 2;
	}
	else
	{
		postdelay = getdvarfloat(#"scr_killcam_posttime", 0);
		if(postdelay < 0.05)
		{
			postdelay = 0.05;
		}
	}
	return postdelay;
}

/*
	Name: get_closest_killcam_entity
	Namespace: killcam
	Checksum: 0xD73130D3
	Offset: 0x2E60
	Size: 0x1EA
	Parameters: 3
	Flags: Linked
*/
function get_closest_killcam_entity(attacker, killcamentities, depth = 0)
{
	closestkillcament = undefined;
	closestkillcamentindex = undefined;
	closestkillcamentdist = undefined;
	origin = undefined;
	foreach(killcamentindex, killcament in killcamentities)
	{
		if(killcament == attacker)
		{
			continue;
		}
		origin = killcament.origin;
		if(isdefined(killcament.offsetpoint))
		{
			origin = origin + killcament.offsetpoint;
		}
		dist = distancesquared(self.origin, origin);
		if(!isdefined(closestkillcament) || dist < closestkillcamentdist)
		{
			closestkillcament = killcament;
			closestkillcamentdist = dist;
			closestkillcamentindex = killcamentindex;
		}
	}
	if(depth < 3 && isdefined(closestkillcament))
	{
		if(!bullettracepassed(closestkillcament.origin, self.origin, 0, self))
		{
			killcamentities[closestkillcamentindex] = undefined;
			betterkillcament = get_closest_killcam_entity(attacker, killcamentities, depth + 1);
			if(isdefined(betterkillcament))
			{
				closestkillcament = betterkillcament;
			}
		}
	}
	return closestkillcament;
}

/*
	Name: get_killcam_entity
	Namespace: killcam
	Checksum: 0xB76490A1
	Offset: 0x3058
	Size: 0x342
	Parameters: 3
	Flags: Linked
*/
function get_killcam_entity(attacker, einflictor, weapon)
{
	if(!isdefined(einflictor))
	{
		return undefined;
	}
	if(isdefined(self.killcamkilledbyent))
	{
		return self.killcamkilledbyent;
	}
	if(einflictor == attacker)
	{
		if(isai(einflictor))
		{
			return einflictor;
		}
		if(!isdefined(einflictor.ismagicbullet))
		{
			return undefined;
		}
		if(isdefined(einflictor.ismagicbullet) && !einflictor.ismagicbullet)
		{
			return undefined;
		}
	}
	else if(isdefined(level.levelspecifickillcam))
	{
		levelspecifickillcament = self [[level.levelspecifickillcam]]();
		if(isdefined(levelspecifickillcament))
		{
			return levelspecifickillcament;
		}
	}
	if(weapon.name == #"hero_gravityspikes")
	{
		return undefined;
	}
	if(isdefined(attacker) && isplayer(attacker) && attacker isremotecontrolling() && (einflictor.controlled === 1 || einflictor.occupied === 1))
	{
		if(weapon.name == #"sentinel_turret" || weapon.name == #"amws_gun_turret_mp_player" || weapon.name == #"auto_gun_turret")
		{
			return undefined;
		}
	}
	if(weapon.name == #"dart")
	{
		return undefined;
	}
	if(isdefined(einflictor.killcament))
	{
		if(einflictor.killcament == attacker)
		{
			return undefined;
		}
		return einflictor.killcament;
	}
	if(isdefined(einflictor.killcamentities))
	{
		return get_closest_killcam_entity(attacker, einflictor.killcamentities);
	}
	if(isdefined(einflictor.script_gameobjectname) && einflictor.script_gameobjectname == "bombzone")
	{
		return einflictor.killcament;
	}
	if(isai(attacker))
	{
		return attacker;
	}
	if(isplayer(attacker))
	{
		if(attacker function_a867284b())
		{
			return undefined;
		}
		if(isvehicle(einflictor) && attacker.viewlockedentity === einflictor)
		{
			if(attacker.vehicleposition >= 1 && attacker.vehicleposition <= 4)
			{
				return undefined;
			}
		}
	}
	return einflictor;
}

/*
	Name: get_secondary_killcam_entity
	Namespace: killcam
	Checksum: 0xE52CBEE1
	Offset: 0x33A8
	Size: 0x86
	Parameters: 2
	Flags: Linked
*/
function get_secondary_killcam_entity(entity, entity_info)
{
	if(!isdefined(entity) || !isdefined(entity.killcamentityindex))
	{
		return;
	}
	entity_info.entity_indexes[entity_info.entity_indexes.size] = entity.killcamentityindex;
	entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = entity.killcamentitystarttime;
}

/*
	Name: get_primary_killcam_entity
	Namespace: killcam
	Checksum: 0xCA67A2B4
	Offset: 0x3438
	Size: 0x17C
	Parameters: 4
	Flags: Linked
*/
function get_primary_killcam_entity(attacker, einflictor, weapon, entity_info)
{
	killcamentity = self get_killcam_entity(attacker, einflictor, weapon);
	if(isdefined(level.var_ef3352fc) && isdefined(level.var_ef3352fc[weapon.name]))
	{
		if(isdefined(einflictor) && isdefined(einflictor.owner) && isdefined(einflictor.owner.killcament))
		{
			killcamentity store_killcam_entity_on_entity(einflictor.owner.killcament);
		}
	}
	killcamentitystarttime = get_killcam_entity_start_time(killcamentity);
	killcamentityindex = -1;
	if(isdefined(killcamentity))
	{
		killcamentityindex = killcamentity getentitynumber();
	}
	entity_info.entity_indexes[entity_info.entity_indexes.size] = killcamentityindex;
	entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = killcamentitystarttime;
	get_secondary_killcam_entity(killcamentity, entity_info);
}

/*
	Name: get_killcam_entity_info
	Namespace: killcam
	Checksum: 0x530560C4
	Offset: 0x35C0
	Size: 0x70
	Parameters: 3
	Flags: Linked
*/
function get_killcam_entity_info(attacker, einflictor, weapon)
{
	entity_info = spawnstruct();
	entity_info.entity_indexes = [];
	entity_info.entity_spawntimes = [];
	get_primary_killcam_entity(attacker, einflictor, weapon, entity_info);
	return entity_info;
}

/*
	Name: get_killcam_entity_info_starttime
	Namespace: killcam
	Checksum: 0xE5E670EA
	Offset: 0x3638
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function get_killcam_entity_info_starttime(entity_info)
{
	if(entity_info.entity_spawntimes.size == 0)
	{
		return 0;
	}
	return entity_info.entity_spawntimes[entity_info.entity_spawntimes.size - 1];
}

