// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\bots\bot.gsc;
#using script_30e0aa25775a6927;
#using script_31e56101095f174b;
#using scripts\core_common\ai\planner_squad.gsc;
#using scripts\core_common\ai\planner_commander.gsc;
#using script_522aeb6ae906391e;
#using scripts\core_common\ai\region_utility.gsc;
#using scripts\core_common\ai\strategic_command.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_ff7f7372;

/*
	Name: __init__system__
	Namespace: namespace_ff7f7372
	Checksum: 0xD8C3321A
	Offset: 0x350
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_432f3eb0cc2e347f", &namespace_e2d53d54::__init__, undefined, undefined);
}

#namespace namespace_e2d53d54;

/*
	Name: __init__
	Namespace: namespace_e2d53d54
	Checksum: 0x3D1AB65B
	Offset: 0x398
	Size: 0x734
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	plannercommanderutility::registerdaemonapi("daemonControlZones", &function_c5bf12a5);
	plannercommanderutility::registerdaemonapi("daemonDomFlags", &function_88ab5a6e);
	plannercommanderutility::registerdaemonapi("daemonKothZone", &function_337c2c5d);
	plannercommanderutility::registerdaemonapi("daemonSdBomb", &function_4364713f);
	plannercommanderutility::registerdaemonapi("daemonSdBombZones", &function_c111c0aa);
	plannercommanderutility::registerdaemonapi("daemonSdDefuseObj", &function_7e03c94a);
	plannercommanderutility::registerutilityapi("commanderScoreAge", &_monkey_water_corvus_vo_cleared);
	plannercommanderutility::registerutilityapi("commanderScoreAlive", &function_e319475e);
	plannercommanderutility::registerutilityapi("commanderScoreControlZones", &function_f478ac94);
	plannercommanderutility::registerutilityapi("commanderScoreDomFlags", &function_78126acd);
	plannercommanderutility::registerutilityapi("commanderScoreStopWanderingDom", &function_8ee25278);
	plannercommanderutility::registerutilityapi("commanderScoreKothZone", &function_eb0a4e86);
	plannerutility::registerplannerapi(#"hash_6130077bb861d4fa", &function_2f04f764);
	plannerutility::registerplannerapi(#"hash_23ede7441ff7e15f", &function_34c0ebaf);
	plannerutility::registerplannerapi(#"hash_9d5448e604895e", &function_68a32d83);
	plannerutility::registerplannerapi(#"hash_58f852e4b26d4080", &function_380f4233);
	plannerutility::registerplannerapi(#"hash_6c55a3eed50ed047", &function_4792217e);
	plannerutility::registerplannerapi(#"hash_654106abca773945", &function_97e7d0d8);
	plannerutility::registerplannerapi(#"hash_783f83ce7a2dc41b", &function_493ead90);
	plannerutility::registerplannerapi(#"hash_19dd182b96412bae", &function_cd5b7cc9);
	plannerutility::registerplannerapi(#"hash_72014ae7e091d06f", &function_efa74ce4);
	plannerutility::registerplanneraction(#"hash_5c39c15c20a4b033", &function_b35625c2, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_5ad6d3a6bb956fb1", &function_a207b2e4, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_6a957e932b7f93aa", &function_9d8a9994, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_746e217e5d63efc2", &function_913bffb1, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_303c3d6d6bfcc25b", &function_edf25221, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_4a587832fd66b314", &function_90af2101, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_4d82b95b9c45bb53", &function_bca7d900, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_494fab5e2093d5b", &function_1cce4bb6, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_506b5e12327f16f4", &function_f192ef84, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_67ba42774c6db6a6", &function_7a576970, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_6b51afb697e53d12", &function_53600d78, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_4c584e62f0069dfa", &function_7a9a7a24, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_3eb5ac2692fce4e7", &function_b032f16b, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_60a8773a51426c27", &function_9c7e3773, undefined, undefined, undefined);
	plannerutility::registerplannerapi(#"hash_3df2466d38b695da", &function_39cd5957);
	plannerutility::registerplannerapi(#"hash_2d8246b9d8badd2e", &function_97659d05);
	plannerutility::registerplannerapi(#"hash_10cfd447c35656ef", &function_9e016913);
}

/*
	Name: _calculatepositionquerypath
	Namespace: namespace_e2d53d54
	Checksum: 0x352D8DBC
	Offset: 0xAD8
	Size: 0x174
	Parameters: 3
	Flags: Linked, Private
*/
function private _calculatepositionquerypath(queryresult, position, entity)
{
	path = undefined;
	longestpath = 0;
	if(queryresult.data.size > 0)
	{
		index = 0;
		while(index < queryresult.data.size)
		{
			goalpoints = [];
			for(goalindex = index; (goalindex - index) < 16 && goalindex < queryresult.data.size; goalindex++)
			{
				goalpoints[goalpoints.size] = queryresult.data[goalindex].origin;
			}
			pathsegment = generatenavmeshpath(position, goalpoints, entity);
			if(isdefined(pathsegment) && pathsegment.status === "succeeded")
			{
				if(pathsegment.pathdistance > longestpath)
				{
					path = pathsegment;
					longestpath = pathsegment.pathdistance;
				}
			}
			index = index + 16;
		}
	}
	return path;
}

/*
	Name: function_c0e398c4
	Namespace: namespace_e2d53d54
	Checksum: 0xA9E5484E
	Offset: 0xC58
	Size: 0x39E
	Parameters: 4
	Flags: Linked, Private
*/
function private function_c0e398c4(bots, var_26b45a5e, bbkey, claimed = undefined)
{
	/#
		assert(isarray(bots));
	#/
	/#
		assert(isarray(var_26b45a5e));
	#/
	var_f8d389a2 = [];
	if(bots.size <= 0 || var_26b45a5e.size <= 0)
	{
		return var_f8d389a2;
	}
	for(i = 0; i < var_26b45a5e.size; i++)
	{
		var_deb9ffcf = var_26b45a5e[i][#"__unsafe__"][bbkey];
		if(!isdefined(var_deb9ffcf))
		{
			continue;
		}
		if(isdefined(claimed) && var_26b45a5e[i][#"claimed"] != claimed)
		{
			continue;
		}
		var_9f855ac9 = getclosestpointonnavmesh(var_deb9ffcf.origin, 200);
		if(isdefined(var_9f855ac9))
		{
			pathable = 1;
			distance = 0;
			for(botindex = 0; botindex < bots.size; botindex++)
			{
				bot = bots[botindex][#"__unsafe__"][#"bot"];
				if(!strategiccommandutility::isvalidbot(bot))
				{
					continue;
				}
				position = getclosestpointonnavmesh(bot.origin, 120, 1.2 * bot getpathfindingradius());
				if(!isdefined(position))
				{
					pathable = 0;
					continue;
				}
				queryresult = positionquery_source_navigation(var_9f855ac9, 0, 120, 60, 16, bot, 16);
				if(queryresult.data.size > 0)
				{
					path = _calculatepositionquerypath(queryresult, position, bot);
					if(!isdefined(path))
					{
						pathable = 0;
						break;
					}
					if(path.pathdistance > distance)
					{
						distance = path.pathdistance;
					}
				}
			}
			if(pathable)
			{
				path = [];
				path[bbkey] = var_26b45a5e[i];
				path[#"distance"] = distance;
				if(!isdefined(var_f8d389a2))
				{
					var_f8d389a2 = [];
				}
				else if(!isarray(var_f8d389a2))
				{
					var_f8d389a2 = array(var_f8d389a2);
				}
				var_f8d389a2[var_f8d389a2.size] = path;
			}
		}
	}
	return var_f8d389a2;
}

/*
	Name: function_3ea6bf0b
	Namespace: namespace_e2d53d54
	Checksum: 0x5B8EAAE5
	Offset: 0x1000
	Size: 0xA8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_3ea6bf0b(gameobject, var_1766c557)
{
	teamkeys = getarraykeys(gameobject.numtouching);
	for(i = 0; i < gameobject.numtouching.size; i++)
	{
		team = teamkeys[i];
		if(team == var_1766c557)
		{
			continue;
		}
		if(gameobject.numtouching[team] > 0)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_c5bf12a5
	Namespace: namespace_e2d53d54
	Checksum: 0xAA561069
	Offset: 0x10B0
	Size: 0x2DC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c5bf12a5(commander)
{
	if(!isdefined(level.zones))
	{
		return;
	}
	commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
	controlzones = [];
	var_c4c8bf3f = arraycopy(level.zones);
	foreach(zone in var_c4c8bf3f)
	{
		if(!isdefined(zone) || !isdefined(zone.trigger) || !zone.trigger istriggerenabled())
		{
			continue;
		}
		var_72812cde = [];
		var_72812cde[#"origin"] = zone.origin;
		if(!isdefined(var_72812cde[#"__unsafe__"]))
		{
			var_72812cde[#"__unsafe__"] = array();
		}
		var_72812cde[#"__unsafe__"][#"controlzone"] = zone;
		if(!isdefined(controlzones))
		{
			controlzones = [];
		}
		else if(!isarray(controlzones))
		{
			controlzones = array(controlzones);
		}
		controlzones[controlzones.size] = var_72812cde;
		if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f)
		{
			aiprofile_endentry();
			pixendevent();
			[[ level.strategic_command_throttle ]]->waitinqueue(commander);
			commander.var_22765a25 = getrealtime();
			pixbeginevent("daemonControlZones");
			aiprofile_beginentry("daemonControlZones");
		}
	}
	blackboard::setstructblackboardattribute(commander, "mp_controlZones", controlzones);
}

/*
	Name: function_88ab5a6e
	Namespace: namespace_e2d53d54
	Checksum: 0xA1D59482
	Offset: 0x1398
	Size: 0x334
	Parameters: 1
	Flags: Linked, Private
*/
function private function_88ab5a6e(commander)
{
	if(!isdefined(level.domflags))
	{
		return;
	}
	commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
	domflags = [];
	var_42c3a790 = arraycopy(level.domflags);
	foreach(domflag in var_42c3a790)
	{
		if(!isdefined(domflag) || !isdefined(domflag.trigger))
		{
			continue;
		}
		if(!domflag.trigger istriggerenabled())
		{
			continue;
		}
		var_2435544a = [];
		var_2435544a[#"origin"] = domflag.origin;
		var_2435544a[#"radius"] = domflag.levelflag.radius;
		var_2435544a[#"claimed"] = commanderteam == domflag gameobjects::get_owner_team();
		if(!isdefined(var_2435544a[#"__unsafe__"]))
		{
			var_2435544a[#"__unsafe__"] = array();
		}
		var_2435544a[#"__unsafe__"][#"domflag"] = domflag;
		if(!isdefined(domflags))
		{
			domflags = [];
		}
		else if(!isarray(domflags))
		{
			domflags = array(domflags);
		}
		domflags[domflags.size] = var_2435544a;
		if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f)
		{
			aiprofile_endentry();
			pixendevent();
			[[ level.strategic_command_throttle ]]->waitinqueue(commander);
			commander.var_22765a25 = getrealtime();
			pixbeginevent("daemonDomFlags");
			aiprofile_beginentry("daemonDomFlags");
		}
	}
	blackboard::setstructblackboardattribute(commander, "mp_domFlags", domflags);
}

/*
	Name: function_337c2c5d
	Namespace: namespace_e2d53d54
	Checksum: 0xE5CF4471
	Offset: 0x16D8
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
function private function_337c2c5d(commander)
{
	if(!isdefined(level.zone))
	{
		return;
	}
	commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
	zone = [];
	cachedzone = [];
	cachedzone[#"origin"] = level.zone.origin;
	if(!isdefined(cachedzone[#"__unsafe__"]))
	{
		cachedzone[#"__unsafe__"] = array();
	}
	cachedzone[#"__unsafe__"][#"kothzone"] = level.zone;
	if(!isdefined(zone))
	{
		zone = [];
	}
	else if(!isarray(zone))
	{
		zone = array(zone);
	}
	zone[zone.size] = cachedzone;
	blackboard::setstructblackboardattribute(commander, "mp_kothZone", zone);
}

/*
	Name: function_4364713f
	Namespace: namespace_e2d53d54
	Checksum: 0x2354AF02
	Offset: 0x1858
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4364713f(commander)
{
	if(!isdefined(level.sdbomb))
	{
		return;
	}
	commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
	bomb = [];
	var_b0fd50a8 = [];
	var_b0fd50a8[#"origin"] = level.sdbomb.origin;
	if(!isdefined(var_b0fd50a8[#"__unsafe__"]))
	{
		var_b0fd50a8[#"__unsafe__"] = array();
	}
	var_b0fd50a8[#"__unsafe__"][#"sdbomb"] = level.sdbomb;
	if(!isdefined(bomb))
	{
		bomb = [];
	}
	else if(!isarray(bomb))
	{
		bomb = array(bomb);
	}
	bomb[bomb.size] = var_b0fd50a8;
	blackboard::setstructblackboardattribute(commander, "mp_sdBomb", bomb);
}

/*
	Name: function_c111c0aa
	Namespace: namespace_e2d53d54
	Checksum: 0x7711939A
	Offset: 0x19D8
	Size: 0x34C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c111c0aa(commander)
{
	if(!isdefined(level.bombzones) || !isarray(level.bombzones) || level.bombzones.size <= 0)
	{
		return;
	}
	commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
	bombzones = [];
	var_99cb62dc = arraycopy(level.bombzones);
	foreach(bombzone in var_99cb62dc)
	{
		if(!isdefined(bombzone) || !isdefined(bombzone.trigger))
		{
			continue;
		}
		if(!bombzone.trigger istriggerenabled())
		{
			continue;
		}
		var_fa640b48 = [];
		var_fa640b48[#"origin"] = bombzone.origin;
		var_fa640b48[#"planted"] = bombzone gameobjects::get_flags(1);
		if(!isdefined(var_fa640b48[#"__unsafe__"]))
		{
			var_fa640b48[#"__unsafe__"] = array();
		}
		var_fa640b48[#"__unsafe__"][#"sdbombzone"] = bombzone;
		if(!isdefined(bombzones))
		{
			bombzones = [];
		}
		else if(!isarray(bombzones))
		{
			bombzones = array(bombzones);
		}
		bombzones[bombzones.size] = var_fa640b48;
		if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f)
		{
			aiprofile_endentry();
			pixendevent();
			[[ level.strategic_command_throttle ]]->waitinqueue(commander);
			commander.var_22765a25 = getrealtime();
			pixbeginevent("daemonSdBombZones");
			aiprofile_beginentry("daemonSdBombZones");
		}
	}
	blackboard::setstructblackboardattribute(commander, "mp_sdBombZones", bombzones);
}

/*
	Name: function_7e03c94a
	Namespace: namespace_e2d53d54
	Checksum: 0x3E89D10B
	Offset: 0x1D30
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7e03c94a(commander)
{
	if(!isdefined(level.defuseobject))
	{
		return;
	}
	commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
	defuseobj = [];
	var_30b29fd3 = [];
	var_30b29fd3[#"origin"] = level.defuseobject.origin;
	if(!isdefined(var_30b29fd3[#"__unsafe__"]))
	{
		var_30b29fd3[#"__unsafe__"] = array();
	}
	var_30b29fd3[#"__unsafe__"][#"sddefuseobj"] = level.defuseobject;
	if(!isdefined(defuseobj))
	{
		defuseobj = [];
	}
	else if(!isarray(defuseobj))
	{
		defuseobj = array(defuseobj);
	}
	defuseobj[defuseobj.size] = var_30b29fd3;
	blackboard::setstructblackboardattribute(commander, "mp_sdDefuseObj", defuseobj);
}

/*
	Name: _monkey_water_corvus_vo_cleared
	Namespace: namespace_e2d53d54
	Checksum: 0xBC582AFE
	Offset: 0x1EB0
	Size: 0x9A
	Parameters: 3
	Flags: Linked, Private
*/
function private _monkey_water_corvus_vo_cleared(commander, squad, constants)
{
	/#
		assert(isdefined(constants[#"maxage"]), ("" + "") + "");
	#/
	if(gettime() > squad.createtime + constants[#"maxage"])
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_e319475e
	Namespace: namespace_e2d53d54
	Checksum: 0x1B35700F
	Offset: 0x1F58
	Size: 0xDA
	Parameters: 3
	Flags: Linked, Private
*/
function private function_e319475e(commander, squad, constants)
{
	bots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	if(!isdefined(bots))
	{
		return 0;
	}
	for(botindex = 0; botindex < bots.size; botindex++)
	{
		bot = bots[botindex][#"__unsafe__"][#"bot"];
		if(!isdefined(bot))
		{
			return 0;
		}
		if(!isalive(bot))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_f478ac94
	Namespace: namespace_e2d53d54
	Checksum: 0xDCD1C2C
	Offset: 0x2040
	Size: 0xEE
	Parameters: 3
	Flags: Linked, Private
*/
function private function_f478ac94(commander, squad, constants)
{
	controlzones = plannersquadutility::getblackboardattribute(squad, "mp_controlZones");
	if(isdefined(controlzones) && controlzones.size > 0)
	{
		for(i = 0; i < controlzones.size; i++)
		{
			zone = controlzones[i][#"__unsafe__"][#"controlzone"];
			if(!zone.gameobject.trigger istriggerenabled())
			{
				return 0;
			}
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_78126acd
	Namespace: namespace_e2d53d54
	Checksum: 0xAD53C44F
	Offset: 0x2138
	Size: 0x14E
	Parameters: 3
	Flags: Linked, Private
*/
function private function_78126acd(commander, squad, constants)
{
	domflags = plannersquadutility::getblackboardattribute(squad, "mp_domFlags");
	squadteam = plannersquadutility::getblackboardattribute(squad, "team");
	if(isdefined(domflags) && domflags.size > 0)
	{
		foreach(domflag in domflags)
		{
			object = domflag[#"__unsafe__"][#"domflag"];
			if(hash(squadteam) !== object gameobjects::get_owner_team())
			{
				return 1;
			}
		}
		return 0;
	}
	return 1;
}

/*
	Name: function_8ee25278
	Namespace: namespace_e2d53d54
	Checksum: 0x3D29EE47
	Offset: 0x2290
	Size: 0xF6
	Parameters: 3
	Flags: Linked, Private
*/
function private function_8ee25278(commander, squad, constants)
{
	order = plannersquadutility::getblackboardattribute(squad, "order");
	if(order === "order_wander")
	{
		bots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
		domflags = planner::getblackboardattribute(commander.planner, "mp_domFlags");
		if(isdefined(domflags))
		{
			pathabledomFlags = function_c0e398c4(bots, domflags, "domFlag");
			if(pathabledomFlags.size > 0)
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_eb0a4e86
	Namespace: namespace_e2d53d54
	Checksum: 0xB2EBA3BD
	Offset: 0x2390
	Size: 0xC6
	Parameters: 3
	Flags: Linked, Private
*/
function private function_eb0a4e86(commander, squad, constants)
{
	kothzone = plannersquadutility::getblackboardattribute(squad, "mp_kothZone");
	if(isdefined(kothzone) && kothzone.size > 0)
	{
		zone = kothzone[0][#"__unsafe__"][#"kothzone"];
		if(zone.gameobject.trigger istriggerenabled())
		{
			return 1;
		}
		return 0;
	}
	return 0;
}

/*
	Name: function_2f04f764
	Namespace: namespace_e2d53d54
	Checksum: 0x6CB6D536
	Offset: 0x2460
	Size: 0x1A2
	Parameters: 2
	Flags: Linked, Private
*/
function private function_2f04f764(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	commanderteam = planner::getblackboardattribute(planner, #"team");
	/#
		assert(squadindex >= 0, "");
	#/
	controlzones = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);
	foreach(controlzone in controlzones)
	{
		zone = controlzone[#"controlzone"][#"__unsafe__"][#"controlzone"];
		if(!isdefined(zone) || !isdefined(zone.gameobject))
		{
			continue;
		}
		if(function_3ea6bf0b(zone.gameobject, commanderteam))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_34c0ebaf
	Namespace: namespace_e2d53d54
	Checksum: 0x82CF797B
	Offset: 0x2610
	Size: 0x98
	Parameters: 2
	Flags: Linked, Private
*/
function private function_34c0ebaf(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	controlzones = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);
	return controlzones.size > 0;
}

/*
	Name: function_68a32d83
	Namespace: namespace_e2d53d54
	Checksum: 0x440A2EE8
	Offset: 0x26B0
	Size: 0x98
	Parameters: 2
	Flags: Linked, Private
*/
function private function_68a32d83(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	domflags = planner::getblackboardattribute(planner, "mp_pathable_domFlags", squadindex);
	return domflags.size > 0;
}

/*
	Name: function_380f4233
	Namespace: namespace_e2d53d54
	Checksum: 0x576A2CBC
	Offset: 0x2750
	Size: 0x98
	Parameters: 2
	Flags: Linked, Private
*/
function private function_380f4233(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	kothzone = planner::getblackboardattribute(planner, "mp_pathable_kothZone", squadindex);
	return kothzone.size > 0;
}

/*
	Name: function_4792217e
	Namespace: namespace_e2d53d54
	Checksum: 0xD8B964CA
	Offset: 0x27F0
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
function private function_4792217e(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bomb = planner::getblackboardattribute(planner, "mp_pathable_sdBomb", squadindex);
	return isdefined(bomb) && bomb.size > 0;
}

/*
	Name: function_97e7d0d8
	Namespace: namespace_e2d53d54
	Checksum: 0x288BEED8
	Offset: 0x28A0
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
function private function_97e7d0d8(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	zones = planner::getblackboardattribute(planner, "mp_pathable_sdBombZones", squadindex);
	return isdefined(zones) && zones.size > 0;
}

/*
	Name: function_493ead90
	Namespace: namespace_e2d53d54
	Checksum: 0x5ADC711A
	Offset: 0x2950
	Size: 0x138
	Parameters: 2
	Flags: Linked, Private
*/
function private function_493ead90(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	for(i = 0; i < bots.size; i++)
	{
		bot = bots[0][#"__unsafe__"][#"bot"];
		if(isdefined(bot.isbombcarrier) && bot.isbombcarrier || (isdefined(level.multibomb) && level.multibomb))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_cd5b7cc9
	Namespace: namespace_e2d53d54
	Checksum: 0xF0B1CFB3
	Offset: 0x2A90
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
function private function_cd5b7cc9(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	var_a13843cf = planner::getblackboardattribute(planner, "mp_pathable_sdDefuseObj", squadindex);
	return isdefined(var_a13843cf) && var_a13843cf.size > 0;
}

/*
	Name: function_efa74ce4
	Namespace: namespace_e2d53d54
	Checksum: 0x84DF3FAF
	Offset: 0x2B40
	Size: 0x26
	Parameters: 2
	Flags: Linked, Private
*/
function private function_efa74ce4(planner, constants)
{
	return region_utility::function_9fe18733() > 0;
}

/*
	Name: function_b35625c2
	Namespace: namespace_e2d53d54
	Checksum: 0xBFBF2B73
	Offset: 0x2B70
	Size: 0x112
	Parameters: 2
	Flags: Linked, Private
*/
function private function_b35625c2(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	controlzones = planner::getblackboardattribute(planner, "mp_controlZones");
	var_72d5b8ac = function_c0e398c4(bots, controlzones, "controlZone");
	planner::setblackboardattribute(planner, "mp_pathable_controlZones", var_72d5b8ac, squadindex);
	return spawnstruct();
}

/*
	Name: function_a207b2e4
	Namespace: namespace_e2d53d54
	Checksum: 0x7542EEE9
	Offset: 0x2C90
	Size: 0x3AA
	Parameters: 2
	Flags: Linked, Private
*/
function private function_a207b2e4(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	commanderteam = planner::getblackboardattribute(planner, #"team");
	/#
		assert(squadindex >= 0, "");
	#/
	var_72d5b8ac = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);
	if(!isarray(var_72d5b8ac) || var_72d5b8ac.size <= 0)
	{
		return spawnstruct();
	}
	var_82711a20 = [];
	foreach(var_2b511b1a in var_72d5b8ac)
	{
		zone = var_2b511b1a[#"controlzone"][#"__unsafe__"][#"controlzone"];
		if(!isdefined(zone) || !isdefined(zone.gameobject))
		{
			continue;
		}
		if(function_3ea6bf0b(zone.gameobject, commanderteam))
		{
			if(!isdefined(var_82711a20))
			{
				var_82711a20 = [];
			}
			else if(!isarray(var_82711a20))
			{
				var_82711a20 = array(var_82711a20);
			}
			var_82711a20[var_82711a20.size] = var_2b511b1a;
		}
	}
	if(var_82711a20.size < 1)
	{
		if(!isdefined(var_82711a20))
		{
			var_82711a20 = [];
		}
		else if(!isarray(var_82711a20))
		{
			var_82711a20 = array(var_82711a20);
		}
		var_82711a20[var_82711a20.size] = var_72d5b8ac[0];
	}
	shortestpath = var_82711a20[0][#"distance"];
	controlzone = var_82711a20[0][#"controlzone"];
	for(i = 1; i < var_82711a20.size; i++)
	{
		if(var_82711a20[i][#"distance"] < shortestpath)
		{
			shortestpath = var_82711a20[i][#"distance"];
			controlzone = var_82711a20[i][#"controlzone"];
		}
	}
	planner::setblackboardattribute(planner, "mp_controlZones", array(controlzone), squadindex);
	return spawnstruct();
}

/*
	Name: function_9d8a9994
	Namespace: namespace_e2d53d54
	Checksum: 0x39DC796B
	Offset: 0x3048
	Size: 0x4FA
	Parameters: 2
	Flags: Linked, Private
*/
function private function_9d8a9994(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	var_72d5b8ac = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);
	if(!isarray(var_72d5b8ac) || var_72d5b8ac.size <= 0)
	{
		return spawnstruct();
	}
	controlzones = [];
	for(i = 0; i < var_72d5b8ac.size; i++)
	{
		zone = var_72d5b8ac[i][#"controlzone"];
		if(!isdefined(controlzones))
		{
			controlzones = [];
		}
		else if(!isarray(controlzones))
		{
			controlzones = array(controlzones);
		}
		controlzones[controlzones.size] = zone;
	}
	controlzone = undefined;
	bot = undefined;
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	if(isdefined(bots) && bots.size > 0)
	{
		bot = bots[0][#"__unsafe__"][#"bot"];
	}
	if(isdefined(bot) && isalive(bot))
	{
		if(!isdefined(controlzone) && getdvarint(#"bot_difficulty", 1) >= 1)
		{
			if(function_97659d05(planner, constants))
			{
				foreach(var_e8450bcf in controlzones)
				{
					var_f7b61e5e = var_e8450bcf[#"__unsafe__"][#"controlzone"];
					if(var_f7b61e5e.gameobject.trigger istriggerenabled() && bot istouching(var_f7b61e5e.gameobject.trigger) && var_f7b61e5e.gameobject.curprogress > 0)
					{
						controlzone = var_e8450bcf;
						break;
					}
				}
			}
		}
		if(!isdefined(controlzone) && getdvarint(#"bot_difficulty", 1) >= 2)
		{
			if(function_39cd5957(planner, constants))
			{
				foreach(var_e8450bcf in controlzones)
				{
					var_f7b61e5e = var_e8450bcf[#"__unsafe__"][#"controlzone"];
					if(var_f7b61e5e.gameobject.trigger istriggerenabled() && bot istouching(var_f7b61e5e.gameobject.trigger))
					{
						controlzone = var_e8450bcf;
						break;
					}
				}
			}
		}
	}
	if(!isdefined(controlzone))
	{
		controlzone = array::random(controlzones);
	}
	planner::setblackboardattribute(planner, "mp_controlZones", array(controlzone), squadindex);
	return spawnstruct();
}

/*
	Name: function_913bffb1
	Namespace: namespace_e2d53d54
	Checksum: 0x4EA19CD0
	Offset: 0x3550
	Size: 0x112
	Parameters: 2
	Flags: Linked, Private
*/
function private function_913bffb1(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	domflags = planner::getblackboardattribute(planner, "mp_domFlags");
	pathabledomFlags = function_c0e398c4(bots, domflags, "domFlag");
	planner::setblackboardattribute(planner, "mp_pathable_domFlags", pathabledomFlags, squadindex);
	return spawnstruct();
}

/*
	Name: function_edf25221
	Namespace: namespace_e2d53d54
	Checksum: 0x4034BDD3
	Offset: 0x3670
	Size: 0x39A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_edf25221(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	pathabledomFlags = planner::getblackboardattribute(planner, "mp_pathable_domFlags", squadindex);
	if(!isarray(pathabledomFlags) || pathabledomFlags.size <= 0)
	{
		return spawnstruct();
	}
	domflags = [];
	shortestpath = pathabledomFlags[0][#"distance"];
	longestpath = pathabledomFlags[0][#"distance"];
	var_fa2c1b88 = 0;
	var_67f36fed = 0;
	for(i = 1; i < pathabledomFlags.size; i++)
	{
		pathabledomFlag = pathabledomFlags[i];
		if(pathabledomFlag[#"distance"] < shortestpath)
		{
			shortestpath = pathabledomFlags[i][#"distance"];
			var_fa2c1b88 = i;
			continue;
		}
		if(pathabledomFlag[#"distance"] > longestpath)
		{
			longestpath = pathabledomFlags[i][#"distance"];
			var_67f36fed = i;
		}
	}
	if(!isdefined(domflags))
	{
		domflags = [];
	}
	else if(!isarray(domflags))
	{
		domflags = array(domflags);
	}
	domflags[domflags.size] = pathabledomFlags[var_fa2c1b88][#"domflag"];
	for(i = 0; i < pathabledomFlags.size; i++)
	{
		if(i == var_fa2c1b88 || i == var_67f36fed)
		{
			continue;
		}
		if(!isdefined(domflags))
		{
			domflags = [];
		}
		else if(!isarray(domflags))
		{
			domflags = array(domflags);
		}
		domflags[domflags.size] = pathabledomFlags[i][#"domflag"];
	}
	if(!isdefined(domflags))
	{
		domflags = [];
	}
	else if(!isarray(domflags))
	{
		domflags = array(domflags);
	}
	domflags[domflags.size] = pathabledomFlags[var_67f36fed][#"domflag"];
	planner::setblackboardattribute(planner, "mp_domFlags", domflags, squadindex);
	return spawnstruct();
}

/*
	Name: function_90af2101
	Namespace: namespace_e2d53d54
	Checksum: 0xF7696208
	Offset: 0x3A18
	Size: 0x112
	Parameters: 2
	Flags: Linked, Private
*/
function private function_90af2101(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	kothzone = planner::getblackboardattribute(planner, "mp_kothZone");
	pathablekothZone = function_c0e398c4(bots, kothzone, "kothZone");
	planner::setblackboardattribute(planner, "mp_pathable_kothZone", pathablekothZone, squadindex);
	return spawnstruct();
}

/*
	Name: function_bca7d900
	Namespace: namespace_e2d53d54
	Checksum: 0xEC5178CB
	Offset: 0x3B38
	Size: 0x122
	Parameters: 2
	Flags: Linked, Private
*/
function private function_bca7d900(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	pathablekothZone = planner::getblackboardattribute(planner, "mp_pathable_kothZone", squadindex);
	if(!isarray(pathablekothZone) || pathablekothZone.size <= 0)
	{
		return spawnstruct();
	}
	planner::setblackboardattribute(planner, "mp_kothZone", array(pathablekothZone[0][#"kothzone"]), squadindex);
	return spawnstruct();
}

/*
	Name: function_1cce4bb6
	Namespace: namespace_e2d53d54
	Checksum: 0xE801A37
	Offset: 0x3C68
	Size: 0x192
	Parameters: 2
	Flags: Linked, Private
*/
function private function_1cce4bb6(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	sdbomb = planner::getblackboardattribute(planner, "mp_sdBomb");
	if(!isdefined(sdbomb))
	{
		return spawnstruct();
	}
	bomb = sdbomb[0][#"__unsafe__"][#"sdbomb"];
	if(isdefined(bomb) && isdefined(bomb.carrier))
	{
		var_494de2dd = [];
	}
	else
	{
		var_494de2dd = function_c0e398c4(bots, sdbomb, "sdBomb");
	}
	planner::setblackboardattribute(planner, "mp_pathable_sdBomb", var_494de2dd, squadindex);
	return spawnstruct();
}

/*
	Name: function_f192ef84
	Namespace: namespace_e2d53d54
	Checksum: 0xB5ED6C4D
	Offset: 0x3E08
	Size: 0x122
	Parameters: 2
	Flags: Linked, Private
*/
function private function_f192ef84(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	pathablesdBomb = planner::getblackboardattribute(planner, "mp_pathable_sdBomb", squadindex);
	if(!isarray(pathablesdBomb) || pathablesdBomb.size <= 0)
	{
		return spawnstruct();
	}
	planner::setblackboardattribute(planner, "mp_sdBomb", array(pathablesdBomb[0][#"sdbomb"]), squadindex);
	return spawnstruct();
}

/*
	Name: function_7a576970
	Namespace: namespace_e2d53d54
	Checksum: 0xDFC66873
	Offset: 0x3F38
	Size: 0x12A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_7a576970(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	bombzones = planner::getblackboardattribute(planner, "mp_sdBombZones");
	if(isdefined(bots) && isdefined(bombzones))
	{
		var_154e2210 = function_c0e398c4(bots, bombzones, "sdBombZone");
		planner::setblackboardattribute(planner, "mp_pathable_sdBombZones", var_154e2210, squadindex);
	}
	return spawnstruct();
}

/*
	Name: function_53600d78
	Namespace: namespace_e2d53d54
	Checksum: 0xEA8C91FF
	Offset: 0x4070
	Size: 0x242
	Parameters: 2
	Flags: Linked, Private
*/
function private function_53600d78(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	var_154e2210 = planner::getblackboardattribute(planner, "mp_pathable_sdBombZones", squadindex);
	if(!isarray(var_154e2210) || var_154e2210.size <= 0)
	{
		return spawnstruct();
	}
	zoneindex = undefined;
	if(isdefined(bots))
	{
		bot = bots[0][#"__unsafe__"][#"bot"];
		if(isdefined(bot) && isalive(bot))
		{
			if(!isdefined(bot.bot.var_16fb46e7))
			{
				bot.bot.var_16fb46e7 = randomint(var_154e2210.size);
			}
			zoneindex = bot.bot.var_16fb46e7;
		}
	}
	if(!isdefined(zoneindex) || zoneindex >= var_154e2210.size)
	{
		zoneindex = randomint(var_154e2210.size);
	}
	planner::setblackboardattribute(planner, "mp_sdBombZones", array(var_154e2210[zoneindex][#"sdbombzone"]), squadindex);
	return spawnstruct();
}

/*
	Name: function_7a9a7a24
	Namespace: namespace_e2d53d54
	Checksum: 0x2002D732
	Offset: 0x42C0
	Size: 0x132
	Parameters: 2
	Flags: Linked, Private
*/
function private function_7a9a7a24(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	defuseobj = planner::getblackboardattribute(planner, "mp_sdDefuseObj");
	if(!isdefined(defuseobj))
	{
		return spawnstruct();
	}
	var_a9e623b5 = function_c0e398c4(bots, defuseobj, "sdDefuseObj");
	planner::setblackboardattribute(planner, "mp_pathable_sdDefuseObj", var_a9e623b5, squadindex);
	return spawnstruct();
}

/*
	Name: function_b032f16b
	Namespace: namespace_e2d53d54
	Checksum: 0xB1B8F58A
	Offset: 0x4400
	Size: 0x14A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_b032f16b(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	var_a9e623b5 = planner::getblackboardattribute(planner, "mp_pathable_sdDefuseObj", squadindex);
	if(!isarray(var_a9e623b5) || var_a9e623b5.size <= 0)
	{
		return spawnstruct();
	}
	planner::setblackboardattribute(planner, "mp_sdDefuseObj", array(var_a9e623b5[0][#"sddefuseobj"]), squadindex);
	return spawnstruct();
}

/*
	Name: function_9c7e3773
	Namespace: namespace_e2d53d54
	Checksum: 0x8A21B90F
	Offset: 0x4558
	Size: 0xD2
	Parameters: 2
	Flags: Linked, Private
*/
function private function_9c7e3773(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	var_7c70464e = region_utility::function_9fe18733();
	laneNum = squadindex % var_7c70464e;
	planner::setblackboardattribute(planner, "mp_laneNum", array(laneNum), squadindex);
	return spawnstruct();
}

/*
	Name: function_39cd5957
	Namespace: namespace_e2d53d54
	Checksum: 0xF5398D16
	Offset: 0x4638
	Size: 0x4C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_39cd5957(planner, constants)
{
	commanderteam = planner::getblackboardattribute(planner, #"team");
	return commanderteam == game.attackers;
}

/*
	Name: function_97659d05
	Namespace: namespace_e2d53d54
	Checksum: 0x7606ED71
	Offset: 0x4690
	Size: 0x4C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_97659d05(planner, constants)
{
	commanderteam = planner::getblackboardattribute(planner, #"team");
	return commanderteam == game.defenders;
}

/*
	Name: function_9e016913
	Namespace: namespace_e2d53d54
	Checksum: 0x54881E95
	Offset: 0x46E8
	Size: 0x30
	Parameters: 2
	Flags: Linked, Private
*/
function private function_9e016913(planner, constants)
{
	return isdefined(level.bombplanted) && level.bombplanted;
}

