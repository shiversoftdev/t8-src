// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18f0d22c75b141a7;
#using script_1d1e03233039d175;
#using script_256b8879317373de;
#using script_29ed825598140ca0;
#using script_2c49ae69cd8ce30c;
#using script_3f27a7b2232674db;
#using script_3f9e54c7a9a7e1e2;
#using script_6c8abe14025b47c4;
#using script_6eb0d63d4a90adcf;
#using script_788472602edbe3b9;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\armor.gsc;
#using scripts\mp_common\callbacks.gsc;
#using scripts\mp_common\draft.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_defaults.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_ui.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\hostmigration.gsc;
#using scripts\mp_common\gametypes\hud_message.gsc;
#using scripts\mp_common\userspawnselection.gsc;
#using scripts\mp_common\util.gsc;

#namespace globallogic_spawn;

/*
	Name: function_89f2df9
	Namespace: globallogic_spawn
	Checksum: 0xD1FEF0F3
	Offset: 0x350
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"globallogic_spawn", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: globallogic_spawn
	Checksum: 0x61DA8E7D
	Offset: 0x398
	Size: 0x236
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_b3c4b7b7 = getgametypesetting(#"hash_4bf99a809542e4ea");
	level.requirespawnpointstoexistinlevel = 0;
	level.spawnsystem.var_3709dc53 = 0;
	spawning::add_default_spawnlist("auto_normal");
	level.spawnentitytypes = [];
	array::add(level.spawnentitytypes, {#entityname:"mp_t8_spawn_point", #team:"all"});
	if(level.gametype == #"dom")
	{
		array::add(level.spawnentitytypes, {#entityname:"mp_t8_spawn_point", #team:#"allies"});
		array::add(level.spawnentitytypes, {#entityname:"mp_t8_spawn_point", #team:#"axis"});
	}
	array::add(level.spawnentitytypes, {#entityname:"mp_t8_spawn_point_allies", #team:#"allies"});
	array::add(level.spawnentitytypes, {#entityname:"mp_t8_spawn_point_axis", #team:#"axis"});
	level.allspawnpoints = [];
	level.spawnpoints = [];
}

/*
	Name: getspawnentitytypes
	Namespace: globallogic_spawn
	Checksum: 0xBB0BED13
	Offset: 0x5D8
	Size: 0xE
	Parameters: 0
	Flags: None
*/
function getspawnentitytypes()
{
	return level.spawnentitytypes;
}

/*
	Name: getmpspawnpoints
	Namespace: globallogic_spawn
	Checksum: 0x49F51CFD
	Offset: 0x5F0
	Size: 0xE
	Parameters: 0
	Flags: None
*/
function getmpspawnpoints()
{
	return level.allspawnpoints;
}

/*
	Name: function_82ca1565
	Namespace: globallogic_spawn
	Checksum: 0x730C6207
	Offset: 0x608
	Size: 0x7CC
	Parameters: 2
	Flags: Linked
*/
function function_82ca1565(spawnpoint, gametype)
{
	switch(gametype)
	{
		case "ffa":
		{
			return isdefined(spawnpoint.ffa) && spawnpoint.ffa;
			break;
		}
		case "sd":
		{
			return isdefined(spawnpoint.sd) && spawnpoint.sd;
			break;
		}
		case "ctf":
		{
			return isdefined(spawnpoint.ctf) && spawnpoint.ctf;
			break;
		}
		case "dom":
		{
			return isdefined(spawnpoint.domination) && spawnpoint.domination;
			break;
		}
		case "dem":
		{
			return isdefined(spawnpoint.demolition) && spawnpoint.demolition;
			break;
		}
		case "gg":
		{
			return isdefined(spawnpoint.gg) && spawnpoint.gg;
			break;
		}
		case "tdm":
		{
			return isdefined(spawnpoint.tdm) && spawnpoint.tdm;
			break;
		}
		case "infil":
		{
			return isdefined(spawnpoint.infiltration) && spawnpoint.infiltration;
			break;
		}
		case "control":
		{
			return isdefined(spawnpoint.control) && spawnpoint.control;
			break;
		}
		case "uplink":
		{
			return isdefined(spawnpoint.uplink) && spawnpoint.uplink;
			break;
		}
		case "kc":
		{
			return isdefined(spawnpoint.kc) && spawnpoint.kc;
			break;
		}
		case "koth":
		{
			return isdefined(spawnpoint.hardpoint) && spawnpoint.hardpoint;
			break;
		}
		case "frontline":
		{
			return isdefined(spawnpoint.frontline) && spawnpoint.frontline;
			break;
		}
		case "dom_flag_a":
		{
			return isdefined(spawnpoint.var_50156c55) && spawnpoint.var_50156c55;
			break;
		}
		case "dom_flag_b":
		{
			return isdefined(spawnpoint.var_3e85c936) && spawnpoint.var_3e85c936;
			break;
		}
		case "dom_flag_c":
		{
			return isdefined(spawnpoint.var_6cda25e2) && spawnpoint.var_6cda25e2;
			break;
		}
		case "hash_6056c310624d5afd":
		{
			return isdefined(spawnpoint.var_5b72d24c) && spawnpoint.var_5b72d24c;
			break;
		}
		case "hash_6056c010624d55e4":
		{
			return isdefined(spawnpoint.var_f3739d6) && spawnpoint.var_f3739d6;
			break;
		}
		case "hash_6ef2d89ce8ee9a32":
		{
			return isdefined(spawnpoint.var_efff95db) && spawnpoint.var_efff95db;
			break;
		}
		case "hash_6ef2d79ce8ee987f":
		{
			return isdefined(spawnpoint.var_58e9e7ae) && spawnpoint.var_58e9e7ae;
			break;
		}
		case "dem_overtime":
		{
			return isdefined(spawnpoint.var_21f814f) && spawnpoint.var_21f814f;
			break;
		}
		case "hash_7cb9d0a58715cebe":
		{
			return isdefined(spawnpoint.var_20e05c9f) && spawnpoint.var_20e05c9f;
			break;
		}
		case "hash_6d83e5f1bdefa7dd":
		{
			return isdefined(spawnpoint.var_7d98dad4) && spawnpoint.var_7d98dad4;
			break;
		}
		case "hash_6d83e2f1bdefa2c4":
		{
			return isdefined(spawnpoint.var_93530648) && spawnpoint.var_93530648;
			break;
		}
		case "control_attack_add_0":
		{
			return isdefined(spawnpoint.var_ce26d39d) && spawnpoint.var_ce26d39d;
			break;
		}
		case "control_attack_add_1":
		{
			return isdefined(spawnpoint.var_dfd87700) && spawnpoint.var_dfd87700;
			break;
		}
		case "control_attack_remove_0":
		{
			return isdefined(spawnpoint.var_2c6a069f) && spawnpoint.var_2c6a069f;
			break;
		}
		case "control_attack_remove_1":
		{
			return isdefined(spawnpoint.var_5f196bfd) && spawnpoint.var_5f196bfd;
			break;
		}
		case "control_defend_add_0":
		{
			return isdefined(spawnpoint.registerlast_mapshouldstun) && spawnpoint.registerlast_mapshouldstun;
			break;
		}
		case "control_defend_add_1":
		{
			return isdefined(spawnpoint.var_8dfc136) && spawnpoint.var_8dfc136;
			break;
		}
		case "control_defend_remove_0":
		{
			return isdefined(spawnpoint.var_ba7e6e0d) && spawnpoint.var_ba7e6e0d;
			break;
		}
		case "control_defend_remove_1":
		{
			return isdefined(spawnpoint.var_5cc5b29d) && spawnpoint.var_5cc5b29d;
			break;
		}
		case "ct":
		{
			return isdefined(spawnpoint.ct) && spawnpoint.ct;
			break;
		}
		case "escort":
		{
			return isdefined(spawnpoint.escort) && spawnpoint.escort;
			break;
		}
		case "bounty":
		{
			return isdefined(spawnpoint.bounty) && spawnpoint.bounty;
			break;
		}
		default:
		{
			/#
				assertmsg((((((("" + gametype) + "") + spawnpoint.origin[0]) + "") + spawnpoint.origin[1]) + "") + spawnpoint.origin[2]);
			#/
			break;
		}
	}
	return 0;
}

/*
	Name: addsupportedspawnpointtype
	Namespace: globallogic_spawn
	Checksum: 0xA18CF6D5
	Offset: 0xDE0
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function addsupportedspawnpointtype(spawnpointtype, team)
{
	if(!isdefined(level.supportedspawntypes))
	{
		level.supportedspawntypes = [];
	}
	var_79942a82 = spawnstruct();
	var_79942a82.type = spawnpointtype;
	if(isdefined(team))
	{
		var_79942a82.team = team;
	}
	array::add(level.supportedspawntypes, var_79942a82);
}

/*
	Name: function_c40af6fa
	Namespace: globallogic_spawn
	Checksum: 0x9E7AF523
	Offset: 0xE80
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function function_c40af6fa()
{
	level.supportedspawntypes = [];
	level.allspawnpoints = [];
}

/*
	Name: function_d3d4ff67
	Namespace: globallogic_spawn
	Checksum: 0xACB2725E
	Offset: 0xEA8
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function function_d3d4ff67(spawn)
{
	foreach(var_a24ffdcc in level.supportedspawntypes)
	{
		supportedspawntype = var_a24ffdcc.type;
		if(function_82ca1565(spawn, supportedspawntype))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: addspawnsforteamname
	Namespace: globallogic_spawn
	Checksum: 0x50DCB658
	Offset: 0xF60
	Size: 0x244
	Parameters: 4
	Flags: Linked
*/
function addspawnsforteamname(teamname, searchentity, spawnarray, startspawns)
{
	rawspawns = struct::get_array(searchentity, "targetname");
	foreach(spawn in rawspawns)
	{
		array::add(level.allspawnpoints, spawn);
		spawn.team = teamname;
		foreach(var_a24ffdcc in level.supportedspawntypes)
		{
			supportedspawntype = var_a24ffdcc.type;
			if(!function_82ca1565(spawn, supportedspawntype))
			{
				continue;
			}
			teamname = util::get_team_mapping(teamname);
			if(isdefined(var_a24ffdcc.team))
			{
				if(teamname != var_a24ffdcc.team)
				{
					continue;
				}
			}
			var_61a53e63 = ((isdefined(spawn._human_were) ? spawn._human_were : 0) ? startspawns : spawnarray);
			if(!isdefined(var_61a53e63[teamname]))
			{
				var_61a53e63[teamname] = [];
			}
			if(!isdefined(spawn.enabled))
			{
				spawn.enabled = -1;
			}
			array::add(var_61a53e63[teamname], spawn);
		}
	}
}

/*
	Name: function_d400d613
	Namespace: globallogic_spawn
	Checksum: 0xBE72E673
	Offset: 0x11B0
	Size: 0x1C8
	Parameters: 2
	Flags: None
*/
function function_d400d613(targetname, var_37c5ce49)
{
	returnarray = [];
	rawspawns = struct::get_array(targetname, "targetname");
	foreach(spawn in rawspawns)
	{
		foreach(supportedspawntype in var_37c5ce49)
		{
			if(!function_82ca1565(spawn, supportedspawntype))
			{
				continue;
			}
			if(!isdefined(returnarray[supportedspawntype]))
			{
				returnarray[supportedspawntype] = [];
			}
			if(!isdefined(returnarray[supportedspawntype]))
			{
				returnarray[supportedspawntype] = [];
			}
			else if(!isarray(returnarray[supportedspawntype]))
			{
				returnarray[supportedspawntype] = array(returnarray[supportedspawntype]);
			}
			returnarray[supportedspawntype][returnarray[supportedspawntype].size] = spawn;
		}
	}
	return returnarray;
}

/*
	Name: function_68312709
	Namespace: globallogic_spawn
	Checksum: 0x548F50C0
	Offset: 0x1380
	Size: 0x68A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_68312709()
{
	spawnstoadd = [];
	startspawns = [];
	foreach(spawnentitytype in level.spawnentitytypes)
	{
		addspawnsforteamname(spawnentitytype.team, spawnentitytype.entityname, spawnstoadd, startspawns);
	}
	spawnteams = getarraykeys(spawnstoadd);
	foreach(spawnteam in spawnteams)
	{
		if(spawnteam == "all")
		{
			if(function_f99d2668())
			{
				addspawnpoints("free", spawnstoadd[spawnteam], "auto_normal");
				addspawnpoints(#"axis", spawnstoadd[spawnteam], "fallback");
				addspawnpoints(#"allies", spawnstoadd[spawnteam], "fallback");
				enablespawnpointlist("auto_normal", util::getteammask("free"));
				level.spawnpoints = arraycombine(level.spawnpoints, spawnstoadd[spawnteam], 0, 0);
			}
			else
			{
				foreach(team, _ in level.teams)
				{
					addspawnpoints(team, spawnstoadd[spawnteam], "auto_normal");
					level.spawnpoints = arraycombine(level.spawnpoints, spawnstoadd[spawnteam], 0, 0);
					enablespawnpointlist("auto_normal", util::getteammask(team));
				}
			}
			continue;
		}
		teamforspawns = (spawning::function_1bc642b7() ? util::getotherteam(spawnteam) : spawnteam);
		addspawnpoints(teamforspawns, spawnstoadd[spawnteam], "auto_normal");
		otherteam = util::getotherteam(teamforspawns);
		addspawnpoints(otherteam, spawnstoadd[spawnteam], "fallback");
		enablespawnpointlist("auto_normal", util::getteammask(teamforspawns));
		foreach(spawnpoint in spawnstoadd[spawnteam])
		{
			array::add(level.spawnpoints, spawnpoint, 0);
		}
	}
	if(!isdefined(level.spawn_start))
	{
		level.spawn_start = [];
	}
	var_d74bb7ad = getarraykeys(startspawns);
	foreach(spawnteam in var_d74bb7ad)
	{
		if(spawnteam == "all")
		{
			foreach(team, _ in level.teams)
			{
				if(!isdefined(level.spawn_start[team]))
				{
					level.spawn_start[team] = [];
				}
				level.spawn_start[team] = arraycombine(level.spawn_start[team], startspawns[spawnteam], 0, 0);
			}
			continue;
		}
		teamforspawns = (spawning::function_1bc642b7() ? util::getotherteam(spawnteam) : spawnteam);
		if(!isdefined(level.spawn_start[teamforspawns]))
		{
			level.spawn_start[teamforspawns] = [];
		}
		level.spawn_start[teamforspawns] = arraycombine(level.spawn_start[teamforspawns], startspawns[spawnteam], 0, 0);
	}
}

/*
	Name: function_8acd9309
	Namespace: globallogic_spawn
	Checksum: 0x46CE03C6
	Offset: 0x1A18
	Size: 0x382
	Parameters: 0
	Flags: Linked
*/
function function_8acd9309()
{
	spawnarray = [];
	startspawns = [];
	if(!isdefined(level.allspawnpoints))
	{
		level.allspawnpoints = [];
	}
	foreach(spawnentitytype in level.spawnentitytypes)
	{
		rawspawns = struct::get_array(spawnentitytype.entityname, "targetname");
		foreach(spawn in rawspawns)
		{
			array::add(level.allspawnpoints, spawn);
			foreach(var_a24ffdcc in level.supportedspawntypes)
			{
				supportedspawntype = var_a24ffdcc.type;
				if(!function_82ca1565(spawn, supportedspawntype))
				{
					continue;
				}
				var_61a53e63 = ((isdefined(spawn._human_were) ? spawn._human_were : 0) ? startspawns : spawnarray);
				if(!isdefined(spawn.enabled))
				{
					spawn.enabled = -1;
				}
				array::add(var_61a53e63, spawn);
			}
		}
	}
	addspawnpoints("free", spawnarray, "auto_normal");
	enablespawnpointlist("auto_normal", util::getteammask("free"));
	level.spawnpoints = arraycombine(level.spawnpoints, spawnarray, 0, 0);
	if(!isdefined(level.spawn_start))
	{
		level.spawn_start = [];
	}
	if(!isdefined(level.spawn_start[#"free"]))
	{
		level.spawn_start[#"free"] = [];
	}
	level.spawn_start[#"free"] = arraycombine(level.spawn_start[#"free"], startspawns, 0, 0);
}

/*
	Name: addspawns
	Namespace: globallogic_spawn
	Checksum: 0x78A3F168
	Offset: 0x1DA8
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function addspawns()
{
	clearspawnpoints("auto_normal");
	clearspawnpoints("fallback");
	if(level.teambased)
	{
		if(!isdefined(level.supportedspawntypes))
		{
			/#
				println("");
			#/
			addsupportedspawnpointtype("tdm");
		}
		function_68312709();
	}
	else
	{
		function_8acd9309();
	}
	calculate_map_center();
	spawnpoint = spawning::get_random_intermission_point();
	setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
}

/*
	Name: calculate_map_center
	Namespace: globallogic_spawn
	Checksum: 0x3D740EE4
	Offset: 0x1EB0
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function calculate_map_center()
{
	if(!isdefined(level.mapcenter))
	{
		spawn_points = level.spawnpoints;
		if(isdefined(spawn_points[0]))
		{
			level.spawnmins = spawn_points[0].origin;
			level.spawnmaxs = spawn_points[0].origin;
		}
		else
		{
			level.spawnmins = (0, 0, 0);
			level.spawnmaxs = (0, 0, 0);
		}
		for(index = 0; index < spawn_points.size; index++)
		{
			origin = spawn_points[index].origin;
			level.spawnmins = math::expand_mins(level.spawnmins, origin);
			level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
		}
		level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
		setmapcenter(level.mapcenter);
	}
}

/*
	Name: timeuntilspawn
	Namespace: globallogic_spawn
	Checksum: 0x9A30624C
	Offset: 0x2028
	Size: 0x244
	Parameters: 1
	Flags: Linked
*/
function timeuntilspawn(includeteamkilldelay)
{
	if(level.ingraceperiod && (isdefined(self.hasspawned) && !self.hasspawned))
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
		if(isdefined(level.playerincrementalrespawndelay) && isdefined(self.pers[#"spawns"]))
		{
			respawndelay = respawndelay + (level.playerincrementalrespawndelay * self.pers[#"spawns"]);
		}
		if(isdefined(self.suicide) && self.suicide && level.suicidespawndelay > 0)
		{
			respawndelay = respawndelay + level.suicidespawndelay;
		}
		if(isdefined(self.teamkilled) && self.teamkilled && level.teamkilledspawndelay > 0)
		{
			respawndelay = respawndelay + level.teamkilledspawndelay;
		}
		if(includeteamkilldelay && (isdefined(self.teamkillpunish) && self.teamkillpunish))
		{
			respawndelay = respawndelay + player::function_821200bb();
		}
	}
	if(isdefined(level.var_f220c297) && level.var_f220c297)
	{
		return self function_ac5b273c(respawndelay);
	}
	wavebased = level.waverespawndelay > 0;
	if(wavebased)
	{
		return self timeuntilwavespawn(respawndelay);
	}
	if(isdefined(self.usedresurrect) && self.usedresurrect)
	{
		return 0;
	}
	return respawndelay;
}

/*
	Name: allteamshaveexisted
	Namespace: globallogic_spawn
	Checksum: 0x5DD5D4D8
	Offset: 0x2278
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function allteamshaveexisted()
{
	foreach(team, _ in level.teams)
	{
		if(!teams::function_9dd75dad(team))
		{
			return false;
		}
		if(level.everexisted[team] > gettime() + 1000)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_38527849
	Namespace: globallogic_spawn
	Checksum: 0x3F8D1730
	Offset: 0x2328
	Size: 0x152
	Parameters: 0
	Flags: Linked
*/
function function_38527849()
{
	if(level.numlives || level.numteamlives)
	{
		if(level.numlives && !self.pers[#"lives"])
		{
			return false;
		}
		if(!level.numlives && level.numteamlives && game.lives[self.team] <= 0)
		{
			return false;
		}
		if(level.teambased)
		{
			gamehasstarted = allteamshaveexisted();
		}
		else
		{
			gamehasstarted = level.maxplayercount > 1 || (!util::isoneround() && !util::isfirstround());
		}
		if(gamehasstarted && (isdefined(level.var_60507c71) && level.var_60507c71))
		{
			if(!level.ingraceperiod && !self.hasspawned)
			{
				return false;
			}
		}
	}
	return true;
}

/*
	Name: mayspawn
	Namespace: globallogic_spawn
	Checksum: 0xF8605957
	Offset: 0x2488
	Size: 0x112
	Parameters: 0
	Flags: Linked
*/
function mayspawn()
{
	if(isdefined(level.mayspawn) && !self [[level.mayspawn]]())
	{
		return 0;
	}
	if(level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns)
	{
		return 0;
	}
	if(game.state == "playing" && level.var_c2cc011f && level.aliveplayers[self.team].size == 0)
	{
		return 0;
	}
	if(isdefined(level.var_75db41a7) && gettime() >= level.var_75db41a7)
	{
		return 0;
	}
	if(isdefined(self.var_97181f3c) && self.var_97181f3c)
	{
		return 0;
	}
	return function_38527849();
}

/*
	Name: function_ac5b273c
	Namespace: globallogic_spawn
	Checksum: 0x52DE45DF
	Offset: 0x25A8
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function function_ac5b273c(minimumwait)
{
	earliestspawntime = gettime() + (int(minimumwait * 1000));
	if(!isdefined(level.var_56baa802))
	{
		return 0;
	}
	return max((float(level.var_56baa802 - gettime())) / 1000, 0);
}

/*
	Name: timeuntilwavespawn
	Namespace: globallogic_spawn
	Checksum: 0x336F4B06
	Offset: 0x2638
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function timeuntilwavespawn(minimumwait)
{
	earliestspawntime = gettime() + (int(minimumwait * 1000));
	lastwavetime = level.lastwave[self.pers[#"team"]];
	wavedelay = int(level.wavedelay[self.pers[#"team"]] * 1000);
	if(wavedelay == 0)
	{
		return 0;
	}
	numwavespassedearliestspawntime = (earliestspawntime - lastwavetime) / wavedelay;
	numwaves = ceil(numwavespassedearliestspawntime);
	timeofspawn = lastwavetime + (numwaves * wavedelay);
	if(isdefined(self.wavespawnindex))
	{
		timeofspawn = timeofspawn + (50 * self.wavespawnindex);
	}
	return (float(timeofspawn - gettime())) / 1000;
}

/*
	Name: stoppoisoningandflareonspawn
	Namespace: globallogic_spawn
	Checksum: 0x52B2F9B2
	Offset: 0x2798
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
	Checksum: 0x51CB4517
	Offset: 0x27E8
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function spawnplayerprediction()
{
	self endon(#"disconnect", #"end_respawn", #"game_ended", #"joined_spectators", #"spawned");
	plrs = teams::count_players();
	nolivesleft = level.numlives && !self.pers[#"lives"] || (level.numteamlives && game.lives[self.team] > 0);
	if(nolivesleft)
	{
		return;
	}
	while(true)
	{
		wait(0.5);
		spawning::onspawnplayer(1);
	}
}

/*
	Name: playmatchstartaudio
	Namespace: globallogic_spawn
	Checksum: 0xB2112FDB
	Offset: 0x2900
	Size: 0x1BC
	Parameters: 1
	Flags: Linked
*/
function playmatchstartaudio(team)
{
	self endon(#"disconnect");
	for(index = 0; index < 5; index++)
	{
		waitframe(1);
	}
	if(self.pers[#"playedgamemode"] !== 1)
	{
		if(level.hardcoremode)
		{
			if(globallogic_utils::function_308e3379())
			{
				self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_d04b3734);
			}
			else
			{
				self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog);
			}
		}
		else
		{
			if(globallogic_utils::function_308e3379())
			{
				self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_f6fda321);
			}
			else
			{
				self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog);
			}
		}
		self.pers[#"playedgamemode"] = 1;
	}
	if(team == game.attackers)
	{
		self globallogic_audio::leader_dialog_on_player(level.leaderdialog.offenseorderdialog);
	}
	else
	{
		self globallogic_audio::leader_dialog_on_player(level.leaderdialog.defenseorderdialog);
	}
}

/*
	Name: doinitialspawnmessaging
	Namespace: globallogic_spawn
	Checksum: 0x8383E46D
	Offset: 0x2AC8
	Size: 0x1FC
	Parameters: 1
	Flags: Linked
*/
function doinitialspawnmessaging(params = undefined)
{
	pixbeginevent(#"sound");
	if(sessionmodeismultiplayergame() && (!(isdefined(self.var_b279086a) && self.var_b279086a)))
	{
		self show();
		self solid();
	}
	if(level.gametype !== "bounty")
	{
		if(isdefined(self.pers[#"music"].spawn) && self.pers[#"music"].spawn == 0)
		{
			if(game.roundsplayed == 0)
			{
				self thread globallogic_audio::set_music_on_player("spawnFull");
			}
			else
			{
				self thread globallogic_audio::set_music_on_player("spawnShort");
			}
			self.pers[#"music"].spawn = 1;
		}
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
	self.playleaderdialog = 1;
	if(isdefined(level.leaderdialog))
	{
		self thread playmatchstartaudio(self.pers[#"team"]);
	}
	pixendevent();
}

/*
	Name: resetattackersthisspawnlist
	Namespace: globallogic_spawn
	Checksum: 0x64547A99
	Offset: 0x2CD0
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function resetattackersthisspawnlist()
{
	self.attackersthisspawn = [];
}

/*
	Name: spawnplayer
	Namespace: globallogic_spawn
	Checksum: 0xF0C75627
	Offset: 0x2CE8
	Size: 0xC54
	Parameters: 0
	Flags: Linked
*/
function spawnplayer()
{
	pixbeginevent(#"spawnplayer_preuts");
	self endon(#"disconnect", #"joined_spectators");
	hadspawned = self.hasspawned;
	self player::spawn_player();
	if(globallogic_utils::getroundstartdelay())
	{
		self thread globallogic_utils::applyroundstartdelay();
	}
	if(isdefined(self.spawnlightarmor) && self.spawnlightarmor > 0)
	{
		self thread armor::setlightarmor(self.spawnlightarmor);
	}
	self.nextkillstreakfree = undefined;
	self.deathmachinekills = 0;
	self resetattackersthisspawnlist();
	self.diedonvehicle = undefined;
	if(isdefined(self.wasaliveatmatchstart) && !self.wasaliveatmatchstart)
	{
		if(level.ingraceperiod || globallogic_utils::gettimepassed() < (int(20 * 1000)))
		{
			self.wasaliveatmatchstart = 1;
		}
	}
	pixbeginevent(#"onspawnplayer");
	self [[level.onspawnplayer]](0);
	if(isdefined(level.playerspawnedcb))
	{
		self [[level.playerspawnedcb]]();
	}
	pixendevent();
	pixendevent();
	level thread globallogic::updateteamstatus();
	pixbeginevent(#"spawnplayer_postuts");
	self val::nuke("disable_oob");
	self thread stoppoisoningandflareonspawn();
	self.sensorgrenadedata = undefined;
	self.var_342564dd = 0;
	self.var_6a9b15ba = undefined;
	self.var_ec59e88c = undefined;
	if(level.var_b3c4b7b7 === 1)
	{
		self player_role::clear();
		draft::assign_remaining_players(self);
	}
	role = self player_role::get();
	/#
		assert(!loadout::function_87bcb1b() || globallogic_utils::isvalidclass(self.curclass));
	#/
	/#
		assert(player_role::is_valid(role));
	#/
	self.pers[#"momentum_at_spawn_or_game_end"] = (isdefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0);
	if(loadout::function_87bcb1b())
	{
		self loadout::function_53b62db1(self.curclass);
	}
	self loadout::give_loadout(self.team, self.curclass);
	if(sessionmodeismultiplayergame() || function_f99d2668())
	{
		specialist = function_b14806c6(role, currentsessionmode());
		if(isdefined(specialist))
		{
			self function_6c3348ac(specialist);
		}
		var_be574bd8 = self function_b568258e();
		outfitindex = self function_50a9aad5();
		gender = self getplayergendertype();
		var_34ba1b60 = self function_3d1a97c6();
		var_8fa79650 = self function_564cfaeb();
		var_9cc50881 = self function_e1c06cd0();
		var_b3d9cfaa = self function_11d0e790();
		var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
		if(isdefined(var_f8e6b703))
		{
			self match_record::set_stat(#"lives", var_f8e6b703, #"hash_4fb5a848ac8329a8", gender);
			self match_record::set_stat(#"lives", var_f8e6b703, #"hash_7f98574cf2a03360", var_9cc50881);
			self match_record::set_stat(#"lives", var_f8e6b703, #"hash_38198df3d9b2c8b8", var_be574bd8);
			self match_record::set_stat(#"lives", var_f8e6b703, #"hash_77e4495eb46e7e2b", var_8fa79650);
			self match_record::set_stat(#"lives", var_f8e6b703, #"character_outfit", outfitindex);
			self match_record::set_stat(#"lives", var_f8e6b703, #"hash_3e4aa1baa6e0dd0f", var_34ba1b60);
			for(i = 0; i < var_b3d9cfaa.size; i++)
			{
				self match_record::set_stat(#"lives", var_f8e6b703, #"hash_20d6751cb2f9ca09", i, var_b3d9cfaa[i]);
			}
		}
	}
	if(level.inprematchperiod)
	{
		self val::set(#"spawn_player", "freezecontrols");
		self val::set(#"spawn_player", "disablegadgets");
		if(sessionmodeismultiplayergame())
		{
			self ghost();
			self notsolid();
		}
		self callback::function_10006d25(&doinitialspawnmessaging);
	}
	else
	{
		self val::reset(#"spawn_player", "freezecontrols");
		self val::reset(#"spawn_player", "disablegadgets");
		self enableweapons();
		if(!(isdefined(hadspawned) && hadspawned) && game.state == "playing")
		{
			self thread doinitialspawnmessaging();
		}
	}
	if(isdefined(level.scoreresetondeath) && level.scoreresetondeath)
	{
		self globallogic_score::resetplayermomentumonspawn();
	}
	self.deathtime = 0;
	self.pers[#"deathtime"] = 0;
	if(self hasperk(#"specialty_anteup"))
	{
		anteup_bonus = getdvarint(#"perk_killstreakanteupresetvalue", 0);
		if(self.pers[#"momentum_at_spawn_or_game_end"] < anteup_bonus)
		{
			globallogic_score::_setplayermomentum(self, anteup_bonus, 0);
		}
	}
	if(!isdefined(getdvar(#"scr_showperksonspawn")))
	{
		setdvar(#"scr_showperksonspawn", 0);
	}
	if(level.hardcoremode)
	{
		setdvar(#"scr_showperksonspawn", 0);
	}
	/#
		if(getdvarint(#"scr_showperksonspawn", 0) == 1 && !gamestate::is_game_over())
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
	self callback::function_d8abfc3d(#"on_end_game", &on_end_game);
	self setsprintboost(0);
	pixendevent();
	waittillframeend();
	self notify(#"spawned_player");
	callback::callback(#"on_player_spawned");
	self thread player_monitor::monitor();
	/#
		print(((((("" + self.origin[0]) + "") + self.origin[1]) + "") + self.origin[2]) + "");
	#/
	setdvar(#"scr_selecting_location", "");
	if(gamestate::is_game_over())
	{
		/#
			assert(!level.intermission);
		#/
		self player::freeze_player_for_round_end();
	}
	self util::set_lighting_state();
}

/*
	Name: on_end_game
	Namespace: globallogic_spawn
	Checksum: 0x6192633D
	Offset: 0x3948
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function on_end_game()
{
	self.pers[#"momentum_at_spawn_or_game_end"] = (isdefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0);
}

/*
	Name: spawnspectator
	Namespace: globallogic_spawn
	Checksum: 0xE4AB94B0
	Offset: 0x39B0
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
	Checksum: 0xE5DCEDE2
	Offset: 0x3A08
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function respawn_asspectator(origin, angles)
{
	in_spawnspectator(origin, angles);
}

/*
	Name: function_3ee5119e
	Namespace: globallogic_spawn
	Checksum: 0x93EA6EEA
	Offset: 0x3A40
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function function_3ee5119e()
{
	if(self.pers[#"team"] != #"spectator" && level.spectatetype == 4 && self.var_92e86779 == #"invalid")
	{
		team_players = getplayers(self.team);
		foreach(player in team_players)
		{
			if(player != self && isalive(player))
			{
				self.var_92e86779 = player.team;
				/#
					println(((((((("" + player.team) + "") + self.name) + "") + self.team) + "") + player.name) + "");
				#/
				return;
			}
		}
		foreach(player in team_players)
		{
			if(player != self && player.var_92e86779 != #"invalid")
			{
				self.var_92e86779 = player.var_92e86779;
				/#
					println(((((((("" + player.var_92e86779) + "") + self.name) + "") + self.team) + "") + player.name) + "");
				#/
				return;
			}
		}
		self.var_92e86779 = self.team;
		/#
			println(((((("" + self.var_92e86779) + "") + self.name) + "") + self.team) + "");
		#/
	}
}

/*
	Name: in_spawnspectator
	Namespace: globallogic_spawn
	Checksum: 0x6F5C5032
	Offset: 0x3D38
	Size: 0x1C4
	Parameters: 2
	Flags: Linked
*/
function in_spawnspectator(origin, angles)
{
	pixmarker("BEGIN: in_spawnSpectator");
	self player::set_spawn_variables();
	self.sessionstate = "spectator";
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.spectatekillcam = 0;
	self.friendlydamage = undefined;
	if(self.pers[#"team"] == #"spectator")
	{
		self.statusicon = "";
	}
	else
	{
		self.statusicon = "hud_status_dead";
	}
	if(level.spectatetype != 4 || self.pers[#"team"] == #"spectator")
	{
		self.spectatorclient = -1;
		spectating::set_permissions_for_machine();
	}
	function_3ee5119e();
	[[level.onspawnspectator]](origin, angles);
	if(level.teambased && !level.splitscreen)
	{
		self thread spectatorthirdpersonness();
	}
	level thread globallogic::updateteamstatus();
	pixmarker("END: in_spawnSpectator");
}

/*
	Name: spectatorthirdpersonness
	Namespace: globallogic_spawn
	Checksum: 0x361B8634
	Offset: 0x3F08
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function spectatorthirdpersonness()
{
	self endon(#"disconnect", #"spawned");
	self notify(#"spectator_thirdperson_thread");
	self endon(#"spectator_thirdperson_thread");
	self.spectatingthirdperson = 0;
}

/*
	Name: forcespawn
	Namespace: globallogic_spawn
	Checksum: 0xD8096569
	Offset: 0x3F70
	Size: 0x150
	Parameters: 1
	Flags: None
*/
function forcespawn(time)
{
	self endon(#"death", #"disconnect", #"spawned");
	if(!isdefined(time))
	{
		time = 60;
	}
	wait(time);
	if(isdefined(self.hasspawned) && self.hasspawned)
	{
		return;
	}
	if(self.pers[#"team"] == #"spectator")
	{
		return;
	}
	if(!globallogic_utils::isvalidclass(self.pers[#"class"]))
	{
		self.pers[#"class"] = "CLASS_CUSTOM1";
		self.curclass = self.pers[#"class"];
	}
	if(!function_8b1a219a())
	{
		self globallogic_ui::closemenus();
	}
	self thread [[level.spawnclient]]();
}

/*
	Name: kickifdontspawn
	Namespace: globallogic_spawn
	Checksum: 0x8E95DB66
	Offset: 0x40C8
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
	Checksum: 0x2C13D5C0
	Offset: 0x4138
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function kickifidontspawninternal()
{
	self endon(#"death", #"disconnect", #"spawned");
	while(true)
	{
		if(!(isdefined(level.inprematchperiod) && level.inprematchperiod) && self isstreamerready())
		{
			break;
		}
		wait(5);
	}
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
	timepassed = (float(gettime() - starttime)) / 1000;
	if(timepassed < (waittime - 0.1) && timepassed < mintime)
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
	if(self.pers[#"team"] == #"spectator")
	{
		return;
	}
	if(!mayspawn() && self.pers[#"time_played_total"] > 0)
	{
		return;
	}
	globallogic::gamehistoryplayerkicked();
	kick(self getentitynumber(), "EXE/PLAYERKICKED_NOTSPAWNED");
}

/*
	Name: kickwait
	Namespace: globallogic_spawn
	Checksum: 0xCCA0117F
	Offset: 0x43E0
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
	Checksum: 0xC9712F9E
	Offset: 0x4420
	Size: 0x16C
	Parameters: 0
	Flags: None
*/
function spawninterroundintermission()
{
	self notify(#"spawned");
	self notify(#"end_respawn");
	self player::set_spawn_variables();
	self hud_message::clearlowermessage();
	self val::reset(#"spawn_player", "freezecontrols");
	self val::reset(#"spawn_player", "disablegadgets");
	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.spectatekillcam = 0;
	self.friendlydamage = undefined;
	self globallogic_defaults::default_onspawnintermission();
	self setorigin(self.origin);
	self setplayerangles(self.angles);
	self clientfield::set_to_player("player_dof_settings", 2);
}

/*
	Name: spawnintermission
	Namespace: globallogic_spawn
	Checksum: 0xD6442B7E
	Offset: 0x4598
	Size: 0x174
	Parameters: 2
	Flags: Linked
*/
function spawnintermission(usedefaultcallback, endgame)
{
	self notify(#"spawned");
	self notify(#"end_respawn");
	self endon(#"disconnect");
	self player::set_spawn_variables();
	self hud_message::clearlowermessage();
	self val::reset(#"spawn_player", "freezecontrols");
	self val::reset(#"spawn_player", "disablegadgets");
	self.sessionstate = "intermission";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.spectatekillcam = 0;
	self.friendlydamage = undefined;
	if(isdefined(usedefaultcallback) && usedefaultcallback)
	{
		globallogic_defaults::default_onspawnintermission();
	}
	else
	{
		[[level.onspawnintermission]](endgame);
	}
	self clientfield::set_to_player("player_dof_settings", 2);
}

/*
	Name: spawnqueuedclientonteam
	Namespace: globallogic_spawn
	Checksum: 0xFD761698
	Offset: 0x4718
	Size: 0xC8
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
		player_to_spawn globallogic_ui::closemenus();
		player_to_spawn thread [[level.spawnclient]]();
	}
}

/*
	Name: spawnqueuedclient
	Namespace: globallogic_spawn
	Checksum: 0x9260081D
	Offset: 0x47E8
	Size: 0x130
	Parameters: 2
	Flags: Linked
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
	Checksum: 0x38950D69
	Offset: 0x4920
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function allteamsnearscorelimit()
{
	if(!level.teambased)
	{
		return false;
	}
	if(level.scorelimit <= 1)
	{
		return false;
	}
	foreach(team, _ in level.teams)
	{
		if(!game.stat[#"teamscores"][team] >= (level.scorelimit - 1))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: shouldshowrespawnmessage
	Namespace: globallogic_spawn
	Checksum: 0xC8741A83
	Offset: 0x49F0
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function shouldshowrespawnmessage()
{
	if(util::waslastround())
	{
		return false;
	}
	if(util::isoneround())
	{
		return false;
	}
	if(isdefined(level.livesdonotreset) && level.livesdonotreset)
	{
		return false;
	}
	if(allteamsnearscorelimit())
	{
		return false;
	}
	return true;
}

/*
	Name: default_spawnmessage
	Namespace: globallogic_spawn
	Checksum: 0x674EFEDA
	Offset: 0x4A68
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function default_spawnmessage()
{
	if(util::getroundsplayed() + 1 < level.roundlimit)
	{
		hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
		self thread globallogic_ui::removespawnmessageshortly(3);
	}
}

/*
	Name: showspawnmessage
	Namespace: globallogic_spawn
	Checksum: 0xCF535479
	Offset: 0x4AD8
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
	Checksum: 0x7049A09F
	Offset: 0x4B08
	Size: 0x1F4
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
		assert(!loadout::function_87bcb1b() || globallogic_utils::isvalidclass(self.curclass));
	#/
	if(!self mayspawn() && (!(isdefined(self.usedresurrect) && self.usedresurrect)))
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
	if(!(isdefined(level.takelivesondeath) && level.takelivesondeath))
	{
		game.lives[self.team]--;
	}
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
	Checksum: 0xF33FD07F
	Offset: 0x4D08
	Size: 0x500
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
	if(isdefined(self.teamkillpunish) && self.teamkillpunish)
	{
		var_821200bb = player::function_821200bb();
		if(var_821200bb > timealreadypassed)
		{
			var_821200bb = var_821200bb - timealreadypassed;
			timealreadypassed = 0;
		}
		else
		{
			timealreadypassed = timealreadypassed - var_821200bb;
			var_821200bb = 0;
		}
		if(var_821200bb > 0)
		{
			hud_message::setlowermessage(#"hash_7d1a0e5bd191fce", var_821200bb);
			self thread respawn_asspectator(self.origin + vectorscale((0, 0, 1), 60), self.angles);
			spawnedasspectator = 1;
			wait(var_821200bb);
		}
		self.teamkillpunish = 0;
	}
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
		if(!function_f99d2668())
		{
			if(level.playerqueuedrespawn)
			{
				hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
			}
			else
			{
				hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
			}
		}
		if(!spawnedasspectator)
		{
			spawnorigin = self.origin + vectorscale((0, 0, 1), 60);
			spawnangles = self.angles;
			if(isdefined(level.useintermissionpointsonwavespawn) && [[level.useintermissionpointsonwavespawn]]() == 1)
			{
				spawnpoint = spawning::get_random_intermission_point();
				if(isdefined(spawnpoint))
				{
					spawnorigin = spawnpoint.origin;
					spawnangles = spawnpoint.angles;
				}
			}
			self thread respawn_asspectator(spawnorigin, spawnangles);
		}
		spawnedasspectator = 1;
		if(!function_f99d2668())
		{
			self function_6c23d45b(timeuntilspawn, "force_spawn");
		}
		else
		{
			self globallogic_utils::waitfortimeornotify(timeuntilspawn, "force_spawn");
		}
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
	self hud_message::clearlowermessage();
	self.wavespawnindex = undefined;
	self.respawntimerstarttime = undefined;
	self.pers[#"spawns"]++;
	self thread [[level.spawnplayer]]();
}

/*
	Name: function_6c23d45b
	Namespace: globallogic_spawn
	Checksum: 0x34A06B0C
	Offset: 0x5210
	Size: 0xE2
	Parameters: 2
	Flags: Linked
*/
function function_6c23d45b(time, notifyname)
{
	timeleft = time;
	self endon(notifyname);
	while(timeleft > 0)
	{
		if(level.playerqueuedrespawn)
		{
			hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeleft);
		}
		else
		{
			hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeleft);
		}
		if(timeleft > 0 && timeleft < 1)
		{
			wait(timeleft);
		}
		else
		{
			wait(1);
		}
		timeleft = timeleft - 1;
	}
}

/*
	Name: waitrespawnorsafespawnbutton
	Namespace: globallogic_spawn
	Checksum: 0xF37ECCF3
	Offset: 0x5300
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
	Checksum: 0x2A44ECFB
	Offset: 0x5360
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
	Checksum: 0x27665C79
	Offset: 0x5420
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

/*
	Name: function_6f7bedf0
	Namespace: globallogic_spawn
	Checksum: 0xCE526CD9
	Offset: 0x5508
	Size: 0x208
	Parameters: 4
	Flags: None
*/
function function_6f7bedf0(origin, angles, team, gamemode)
{
	if(gamemode != level.gametype)
	{
		return;
	}
	spawnpoint = spawnstruct();
	if(team == "axis")
	{
		spawnpoint.classname = "mp_t8_spawn_point_axis";
		spawnpoint.targetname = "mp_t8_spawn_point_axis";
	}
	else if(team == "allies")
	{
		spawnpoint.classname = "mp_t8_spawn_point_allies";
		spawnpoint.targetname = "mp_t8_spawn_point_allies";
	}
	spawnpoint.origin = origin;
	spawnpoint.angles = angles;
	spawnpoint._human_were = 1;
	spawnpoint.tdm = 1;
	spawnpoint.var_446998f8 = 1;
	if(!isdefined(level.spawn_start))
	{
		level.spawn_start = [];
	}
	if(!isdefined(level.spawn_start[team]))
	{
		level.spawn_start[team] = [];
	}
	if(!isdefined(level.spawn_start[team]))
	{
		level.spawn_start[team] = [];
	}
	else if(!isarray(level.spawn_start[team]))
	{
		level.spawn_start[team] = array(level.spawn_start[team]);
	}
	level.spawn_start[team][level.spawn_start[team].size] = spawnpoint;
}

