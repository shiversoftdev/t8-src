// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_31e56101095f174b;
#using script_321486e8a7c7176f;
#using script_39c61335d85620af;
#using script_522aeb6ae906391e;
#using script_aa63c66acbb23e;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace planner_commander_utility;

/*
	Name: function_89f2df9
	Namespace: planner_commander_utility
	Checksum: 0x65C47AD1
	Offset: 0x510
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"planner_commander_utility", &plannercommanderutility::__init__, undefined, undefined);
}

#namespace plannercommanderutility;

/*
	Name: __init__
	Namespace: plannercommanderutility
	Checksum: 0xF2A6C1C9
	Offset: 0x558
	Size: 0x12B4
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	plannerutility::registerplannerapi(#"hash_3032cc0c39eec160", &function_790fb743);
	plannerutility::registerplannerapi(#"hash_27cb7425e82f36b2", &function_a05a08bf);
	plannerutility::registerplannerapi(#"commanderblackboardvalueistrue", &strategyblackboardvalueistrue);
	plannerutility::registerplannerapi(#"hash_758a5e038102521d", &function_a75b29d8);
	plannerutility::registerplannerapi(#"commanderhasatleastxassaultobjects", &strategyhasatleastxassaultobjects);
	plannerutility::registerplannerapi(#"commanderhasatleastxdefendobjects", &strategyhasatleastxdefendobjects);
	plannerutility::registerplannerapi(#"commanderhasatleastxobjectives", &strategyhasatleastxobjectives);
	plannerutility::registerplannerapi(#"commanderhasatleastxplayers", &strategyhasatleastxplayers);
	plannerutility::registerplannerapi(#"commanderhasatleastxpriorityassaultobjects", &strategyhasatleastxpriorityassaultobjects);
	plannerutility::registerplannerapi(#"commanderhasatleastxprioritydefendobjects", &strategyhasatleastxprioritydefendobjects);
	plannerutility::registerplannerapi(#"commanderhasatleastxunassignedbots", &strategyhasatleastxunassignedbots);
	plannerutility::registerplannerapi(#"commanderhasatleastxunclaimedassaultobjects", &strategyhasatleastxunclaimedassaultobjects);
	plannerutility::registerplannerapi(#"commanderhasatleastxunclaimeddefendobjects", &strategyhasatleastxunclaimeddefendobjects);
	plannerutility::registerplannerapi(#"commanderhasatleastxunclaimedpriorityassaultobjects", &strategyhasatleastxunclaimedpriorityassaultobjects);
	plannerutility::registerplannerapi(#"commanderhasatleastxunclaimedprioritydefendobjects", &strategyhasatleastxunclaimedprioritydefendobjects);
	plannerutility::registerplannerapi(#"commanderhasforcegoal", &strategyhasforcegoal);
	plannerutility::registerplannerapi(#"hash_3328412ef57ec24f", &function_f6a3c6d5);
	plannerutility::registerplannerapi(#"commandershouldrushprogress", &strategyshouldrushprogress);
	plannerutility::registerplannerapi(#"commandershouldthrottleprogress", &strategyshouldthrottleprogress);
	plannerutility::registerplanneraction(#"hash_665ea68c4244269", &function_e0092cfc, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_38a4c999135f3595", &function_86270cca, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_30d4da4336523524", &function_14c766b3, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_5a63edd39e17c7fa", &function_52012b78, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderendplan", undefined, undefined, undefined, undefined);
	plannerutility::registerplannerapi(#"commanderincrementblackboardvalue", &strategyincrementblackboardvalue);
	plannerutility::registerplannerapi(#"hash_1e2223a7ca7420d2", &function_166d74b2);
	plannerutility::registerplannerapi(#"hash_63fe7d4f2c2b7232", &function_f162255b);
	plannerutility::registerplannerapi(#"commandersetblackboardvalue", &strategysetblackboardvalue);
	plannerutility::registerplannerapi(#"hash_757f8311986da567", &function_20de0d52);
	plannerutility::registerplannerapi(#"hash_b0021da8974ba24", &bunker_exposure_scale);
	plannerutility::registerplannerapi(#"commandersquadhaspathableescort", &strategysquadhaspathableescort);
	plannerutility::registerplannerapi(#"commandersquadhaspathableobject", &strategysquadhaspathableobject);
	plannerutility::registerplannerapi(#"commandersquadhaspathableobjective", &strategysquadhaspathableobjective);
	plannerutility::registerplannerapi(#"commandersquadhaspathableunclaimedobject", &strategysquadhaspathableunclaimedobject);
	plannerutility::registerplannerapi(#"commandersquadcopyblackboardvalue", &strategysquadcopyblackboardvalue);
	plannerutility::registerplannerapi(#"hash_405fef7ef4724a61", &function_86c0732e);
	plannerutility::registerplannerapi(#"commandersquadsortescortpoi", &strategysquadsortescortpoi);
	plannerutility::registerplanneraction(#"commandersquadassignforcegoal", &strategysquadassignforcegoalparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadassignpathableescort", &strategysquadassignpathableescortparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadassignpathableobject", &strategysquadassignpathableobjectparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadassignpathableobjective", &strategysquadassignpathableobjectiveparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadassignpathableunclaimedobject", &strategysquadassignpathableunclaimedobjectparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_58798fbbe44b7ef0", &function_b77887e, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadassignwander", &strategysquadassignwanderparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_5cd436bbd4c1e857", &function_34464159, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadcalculatepathableobjectives", &strategysquadcalculatepathableobjectivesparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadcalculatepathableplayers", &strategysquadcalculatepathableplayersparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadclaimobject", &strategysquadclaimobjectparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_544ff9246bf758e2", &function_d58b0781, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"hash_4da9a3c5542078a", &function_45f841ea, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadcreateofsizex", &strategysquadcreateofsizexparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadorder", &strategysquadorderparam, undefined, undefined, undefined);
	plannerutility::registerplannerapi(#"commandersquadescorthasnomainguard", &strategysquadescorthasnomainguard);
	plannerutility::registerplannerapi(#"commandersquadescorthasnorearguard", &strategysquadescorthasnorearguard);
	plannerutility::registerplannerapi(#"commandersquadescorthasnovanguard", &strategysquadescorthasnovanguard);
	plannerutility::registerplanneraction(#"commandersquadescortcalculatepathablepoi", &strategysquadescortcalculatepathablepoiparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadassignmainguard", &strategysquadescortassignmainguardparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadassignrearguard", &strategysquadescortassignrearguardparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commandersquadassignvanguard", &strategysquadescortassignvanguardparam, undefined, undefined, undefined);
	plannerutility::registerplannerapi(#"commanderpathinghascalculatedpaths", &strategypathinghascalculatedpaths);
	plannerutility::registerplannerapi(#"commanderpathinghascalculatedpathablepath", &strategypathinghascalculatedpathablepath);
	plannerutility::registerplannerapi(#"commanderpathinghasnorequestpoints", &strategypathinghasnorequestpoints);
	plannerutility::registerplannerapi(#"commanderpathinghasrequestpoints", &strategypathinghasrequestpoints);
	plannerutility::registerplannerapi(#"commanderpathinghasunprocessedgameobjects", &strategypathinghasunprocessedgameobjects);
	plannerutility::registerplannerapi(#"commanderpathinghasunprocessedobjectives", &strategypathinghasunprocessedobjectives);
	plannerutility::registerplannerapi(#"commanderpathinghasunprocessedrequestpoints", &strategypathinghasunprocessedrequestpoints);
	plannerutility::registerplannerapi(#"commanderpathinghasunreachablepath", &strategypathinghasunreachablepath);
	plannerutility::registerplanneraction(#"commanderpathingaddassaultgameobjects", &strategypathingaddassaultgameobjectsparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingadddefendgameobjects", &strategypathingadddefendgameobjectsparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingaddobjectives", &strategypathingaddobjectivesparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingaddsquadbots", &strategypathingaddsquadbotsparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingaddsquadescorts", &strategypathingaddsquadescortsparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingaddtosquadcalculatedgameobjects", &strategypathingaddtosquadcalculatedgameobjectsparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingaddtosquadcalculatedobjectives", &strategypathingaddtosquadcalculatedobjectivesparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingcalculatepathtorequestedpoints", &strategypathingcalculatepathtorequestedpointsparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingcalculategameobjectrequestpoints", &strategypathingcalculategameobjectrequestpointsparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingcalculategameobjectpathability", &strategypathingcalculategameobjectpathabilityparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingcalculateobjectiverequestpoints", &strategypathingcalculateobjectiverequestpointsparam, undefined, undefined, undefined);
	plannerutility::registerplanneraction(#"commanderpathingcalculateobjectivepathability", &strategypathingcalculateobjectivepathabilityparam, undefined, undefined, undefined);
	registerutilityapi("commanderScoreBotChain", &function_61d2b8ef);
	registerutilityapi("commanderScoreBotPresence", &utilityscorebotpresence);
	registerutilityapi("commanderScoreBotVehiclePresence", &function_de2b04c0);
	registerutilityapi("commanderScoreEscortPathing", &utilityscoreescortpathing);
	registerutilityapi("commanderScoreForceGoal", &utilityscoreforcegoal);
	registerutilityapi("commanderScoreGameobjectPathing", &utilityscoregameobjectpathing);
	registerutilityapi("commanderScoreGameobjectPriority", &utilityscoregameobjectpriority);
	registerutilityapi("commanderScoreGameobjectsValidity", &utilityscoregameobjectsvalidity);
	registerutilityapi("commanderScoreNoTarget", &function_2985faa1);
	registerutilityapi("commanderScoreProgressThrottling", &utilityscoreprogressthrottling);
	registerutilityapi("commanderScoreTarget", &function_a65b2be5);
	registerutilityapi("commanderScoreTeam", &function_f389ef61);
	registerutilityapi("commanderScoreViableEscort", &utilityscoreviableescort);
	registerdaemonapi("daemonClients", &daemonupdateclients);
	registerdaemonapi("daemonGameobjects", &daemonupdategameobjects);
	registerdaemonapi("daemonGameplayBundles", &function_e6443602);
	registerdaemonapi("daemonMissionComponents", &function_7706a6fa);
	registerdaemonapi("daemonObjectives", &daemonupdateobjective);
}

/*
	Name: _assignsquadunclaimeddefendgameobjectparam
	Namespace: plannercommanderutility
	Checksum: 0xF249D98F
	Offset: 0x1818
	Size: 0x188
	Parameters: 2
	Flags: Private
*/
private function _assignsquadunclaimeddefendgameobjectparam(planner, squadindex)
{
	defendobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
	validobjects = [];
	defendobject = undefined;
	foreach(gameobject in defendobjects)
	{
		if(!gameobject[#"claimed"])
		{
			validobjects[validobjects.size] = gameobject;
		}
	}
	if(validobjects.size > 0)
	{
		doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
		centroid = _calculatebotscentroid(doppelbots);
		defendobject = _calculateclosestgameobject(centroid, validobjects);
	}
	if(isdefined(defendobject))
	{
		planner::setblackboardattribute(planner, "gameobjects", array(defendobject), squadindex);
	}
}

/*
	Name: _assignsquadassaultgameobjectparam
	Namespace: plannercommanderutility
	Checksum: 0x2185A1B4
	Offset: 0x19A8
	Size: 0xE4
	Parameters: 2
	Flags: Private
*/
private function _assignsquadassaultgameobjectparam(planner, squadindex)
{
	assaultobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
	if(assaultobjects.size > 0)
	{
		doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
		centroid = _calculatebotscentroid(doppelbots);
		assaultobject = _calculateclosestgameobject(centroid, assaultobjects);
		planner::setblackboardattribute(planner, "gameobjects", array(assaultobject), squadindex);
	}
}

/*
	Name: _assignsquaddefendgameobjectparam
	Namespace: plannercommanderutility
	Checksum: 0xF92FA96
	Offset: 0x1A98
	Size: 0xE4
	Parameters: 2
	Flags: Private
*/
private function _assignsquaddefendgameobjectparam(planner, squadindex)
{
	defendobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
	if(defendobjects.size > 0)
	{
		doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
		centroid = _calculatebotscentroid(doppelbots);
		defendobject = _calculateclosestgameobject(centroid, defendobjects);
		planner::setblackboardattribute(planner, "gameobjects", array(defendobject), squadindex);
	}
}

/*
	Name: _calculatealliedteams
	Namespace: plannercommanderutility
	Checksum: 0x3771874F
	Offset: 0x1B88
	Size: 0x22
	Parameters: 1
	Flags: Private
*/
private function _calculatealliedteams(team)
{
	return array(team);
}

/*
	Name: _calculatebotscentroid
	Namespace: plannercommanderutility
	Checksum: 0xAEFBE91
	Offset: 0x1BB8
	Size: 0xE0
	Parameters: 1
	Flags: Linked, Private
*/
private function _calculatebotscentroid(doppelbots)
{
	/#
		assert(isarray(doppelbots));
	#/
	centroid = (0, 0, 0);
	foreach(doppelbot in doppelbots)
	{
		centroid = centroid + doppelbot[#"origin"];
	}
	if(doppelbots.size > 0)
	{
		return centroid / doppelbots.size;
	}
	return centroid;
}

/*
	Name: _calculateclosestgameobject
	Namespace: plannercommanderutility
	Checksum: 0x34AA0F8
	Offset: 0x1CA0
	Size: 0x146
	Parameters: 2
	Flags: Linked, Private
*/
private function _calculateclosestgameobject(position, gameobjects)
{
	/#
		assert(isvec(position));
	#/
	/#
		assert(isarray(gameobjects));
	#/
	if(gameobjects.size <= 0)
	{
		return undefined;
	}
	closest = gameobjects[0];
	distancesq = distancesquared(position, closest[#"origin"]);
	for(index = 1; index < gameobjects.size; index++)
	{
		newdistancesq = distancesquared(position, gameobjects[index][#"origin"]);
		if(newdistancesq < distancesq)
		{
			closest = gameobjects[index];
			distancesq = newdistancesq;
		}
	}
	return closest;
}

/*
	Name: function_65b16924
	Namespace: plannercommanderutility
	Checksum: 0xFC237B04
	Offset: 0x1DF0
	Size: 0x2DA
	Parameters: 2
	Flags: Private
*/
private function function_65b16924(doppelbots, components)
{
	/#
		assert(isarray(doppelbots));
	#/
	/#
		assert(isarray(components));
	#/
	var_1a9886d3 = array();
	if(doppelbots.size <= 0 || components.size <= 0)
	{
		return var_1a9886d3;
	}
	for(var_16b9ef20 = 0; var_16b9ef20 < components.size; var_16b9ef20++)
	{
		component = components[var_16b9ef20][#"__unsafe__"][#"component"];
		if(!isdefined(component))
		{
			continue;
		}
		chained = 0;
		for(botindex = 0; botindex < doppelbots.size; botindex++)
		{
			bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
			if(!strategiccommandutility::isvalidbot(bot) || !isdefined(bot.var_aeb3e046))
			{
				break;
			}
			if(bot isinvehicle())
			{
				break;
			}
			foreach(crumb in bot.var_aeb3e046)
			{
				var_9abffecd = crumb.var_5b8b19fe[bot.team];
				if(!isdefined(var_9abffecd))
				{
					continue;
				}
				if(component.var_54a1987a === var_9abffecd.var_951e29f)
				{
					chained = 1;
				}
			}
		}
		if(chained)
		{
			var_d6d184 = array();
			var_d6d184[#"component"] = components[var_16b9ef20];
			var_1a9886d3[var_1a9886d3.size] = var_d6d184;
		}
	}
	return var_1a9886d3;
}

/*
	Name: _calculateallpathablegameobjects
	Namespace: plannercommanderutility
	Checksum: 0x93143356
	Offset: 0x20D8
	Size: 0x3A4
	Parameters: 3
	Flags: Linked, Private
*/
private function _calculateallpathablegameobjects(planner, doppelbots, gameobjects)
{
	/#
		assert(isarray(doppelbots));
	#/
	/#
		assert(isarray(gameobjects));
	#/
	pathablegameobjects = [];
	if(gameobjects.size <= 0)
	{
		return pathablegameobjects;
	}
	if(doppelbots.size <= 0)
	{
		return pathablegameobjects;
	}
	for(gameobjectindex = 0; gameobjectindex < gameobjects.size; gameobjectindex++)
	{
		gameobject = gameobjects[gameobjectindex][#"__unsafe__"][#"object"];
		if(!isdefined(gameobject))
		{
			continue;
		}
		pathable = 1;
		longestpath = 0;
		for(botindex = 0; botindex < doppelbots.size; botindex++)
		{
			bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
			if(!strategiccommandutility::isvalidbot(bot))
			{
				pathable = 0;
				break;
			}
			path = strategiccommandutility::calculatepathtogameobject(bot, gameobject);
			if(!isdefined(path))
			{
				pathable = 0;
				break;
			}
			if(path.pathdistance > longestpath)
			{
				longestpath = path.pathdistance;
			}
		}
		if(pathable)
		{
			path = array();
			path[#"distance"] = longestpath;
			path[#"gameobject"] = gameobjects[gameobjectindex];
			pathablegameobjects[pathablegameobjects.size] = path;
		}
		if(getrealtime() - planner.planstarttime > planner.maxframetime)
		{
			var_ce386d7a = planner.api;
			planner.api = undefined;
			aiprofile_endentry();
			pixendevent();
			aiprofile_endentry();
			pixendevent();
			waitframe(1);
			[[ level.strategic_command_throttle ]]->waitinqueue(planner);
			pixbeginevent(planner.name);
			aiprofile_beginentry(planner.name);
			planner.api = var_ce386d7a;
			pixbeginevent(var_ce386d7a);
			aiprofile_beginentry(var_ce386d7a);
			planner.planstarttime = getrealtime();
		}
	}
	return pathablegameobjects;
}

/*
	Name: function_816f4052
	Namespace: plannercommanderutility
	Checksum: 0x5521ABE0
	Offset: 0x2488
	Size: 0x40C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_816f4052(planner, doppelbots, bundles)
{
	/#
		assert(isarray(doppelbots));
	#/
	/#
		assert(isarray(bundles));
	#/
	var_8c6da8a9 = [];
	if(bundles.size <= 0)
	{
		return var_8c6da8a9;
	}
	if(doppelbots.size <= 0)
	{
		return var_8c6da8a9;
	}
	for(var_22edb3dc = 0; var_22edb3dc < bundles.size; var_22edb3dc++)
	{
		bundle = bundles[var_22edb3dc][#"__unsafe__"][#"bundle"];
		if(!isdefined(bundle))
		{
			continue;
		}
		escort = undefined;
		switch(bundle.m_str_type)
		{
			case "escortbiped":
			{
				escort = bundle.var_27726d51;
				break;
			}
			default:
			{
				break;
			}
		}
		if(!isdefined(escort))
		{
			continue;
		}
		pathable = 1;
		longestpath = 0;
		for(botindex = 0; botindex < doppelbots.size; botindex++)
		{
			bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
			if(!strategiccommandutility::isvalidbot(bot))
			{
				pathable = 0;
				break;
			}
			path = strategiccommandutility::calculatepathtoposition(bot, escort.origin);
			if(!isdefined(path))
			{
				pathable = 0;
				break;
			}
			if(path.pathdistance > longestpath)
			{
				longestpath = path.pathdistance;
			}
		}
		if(pathable)
		{
			path = array();
			path[#"distance"] = longestpath;
			path[#"bundle"] = bundles[var_22edb3dc];
			var_8c6da8a9[var_8c6da8a9.size] = path;
		}
		if(getrealtime() - planner.planstarttime > planner.maxframetime)
		{
			var_ce386d7a = planner.api;
			planner.api = undefined;
			aiprofile_endentry();
			pixendevent();
			aiprofile_endentry();
			pixendevent();
			waitframe(1);
			[[ level.strategic_command_throttle ]]->waitinqueue(planner);
			pixbeginevent(planner.name);
			aiprofile_beginentry(planner.name);
			planner.api = var_ce386d7a;
			pixbeginevent(var_ce386d7a);
			aiprofile_beginentry(var_ce386d7a);
			planner.planstarttime = getrealtime();
		}
	}
	return var_8c6da8a9;
}

/*
	Name: function_77cd4593
	Namespace: plannercommanderutility
	Checksum: 0xC4C28362
	Offset: 0x28A0
	Size: 0x52C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_77cd4593(planner, doppelbots, components)
{
	/#
		assert(isarray(doppelbots));
	#/
	/#
		assert(isarray(components));
	#/
	var_3fc85ed1 = [];
	if(components.size <= 0)
	{
		return var_3fc85ed1;
	}
	if(doppelbots.size <= 0)
	{
		return var_3fc85ed1;
	}
	var_80e29ead = 0;
	for(botindex = 0; botindex < doppelbots.size; botindex++)
	{
		if(doppelbots[botindex][#"type"] == "air")
		{
			var_80e29ead = 1;
			break;
		}
	}
	var_b73a1d4b = 0;
	for(botindex = 0; botindex < doppelbots.size; botindex++)
	{
		if(doppelbots[botindex][#"type"] == "ground")
		{
			var_b73a1d4b = 1;
			break;
		}
	}
	for(var_16b9ef20 = 0; var_16b9ef20 < components.size; var_16b9ef20++)
	{
		component = components[var_16b9ef20][#"__unsafe__"][#"component"];
		if(!isdefined(component))
		{
			continue;
		}
		trigger = undefined;
		switch(component.m_str_type)
		{
			case "goto":
			{
				break;
			}
			case "destroy":
			case "defend":
			{
				trigger = (var_80e29ead ? component.var_6bc907c4 : component.var_2956bff4);
				break;
			}
			case "capturearea":
			{
				trigger = component.var_cc67d976;
				break;
			}
			default:
			{
				break;
			}
		}
		if(!isdefined(trigger))
		{
			continue;
		}
		pathable = 1;
		longestpath = 0;
		for(botindex = 0; botindex < doppelbots.size; botindex++)
		{
			bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
			if(!strategiccommandutility::isvalidbot(bot))
			{
				pathable = 0;
				break;
			}
			path = strategiccommandutility::calculatepathtoobjective(bot, trigger);
			if(!isdefined(path))
			{
				pathable = 0;
				break;
			}
			if(path.pathdistance > longestpath)
			{
				longestpath = path.pathdistance;
			}
		}
		if(pathable)
		{
			path = array();
			path[#"distance"] = longestpath;
			path[#"objective"] = components[var_16b9ef20];
			var_3fc85ed1[var_3fc85ed1.size] = path;
		}
		if(getrealtime() - planner.planstarttime > planner.maxframetime)
		{
			var_ce386d7a = planner.api;
			planner.api = undefined;
			aiprofile_endentry();
			pixendevent();
			aiprofile_endentry();
			pixendevent();
			waitframe(1);
			[[ level.strategic_command_throttle ]]->waitinqueue(planner);
			pixbeginevent(planner.name);
			aiprofile_beginentry(planner.name);
			planner.api = var_ce386d7a;
			pixbeginevent(var_ce386d7a);
			aiprofile_beginentry(var_ce386d7a);
			planner.planstarttime = getrealtime();
		}
	}
	return var_3fc85ed1;
}

/*
	Name: function_98bde2b6
	Namespace: plannercommanderutility
	Checksum: 0x5F69E1C4
	Offset: 0x2DD8
	Size: 0x34A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_98bde2b6(doppelbots, entities)
{
	/#
		assert(isarray(doppelbots));
	#/
	/#
		assert(isarray(entities));
	#/
	var_afb9d067 = [];
	if(entities.size <= 0)
	{
		return var_afb9d067;
	}
	if(doppelbots.size <= 0)
	{
		return var_afb9d067;
	}
	for(entityindex = 0; entityindex < entities.size; entityindex++)
	{
		entity = entities[entityindex][#"__unsafe__"][#"entity"];
		if(!isdefined(entity))
		{
			continue;
		}
		var_cec03170 = getclosestpointonnavmesh(entity.origin, 200);
		pathable = 1;
		longestpath = 0;
		for(botindex = 0; botindex < doppelbots.size; botindex++)
		{
			bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
			position = getclosestpointonnavmesh(bot.origin, 120, bot getpathfindingradius() * 1.05);
			if(!isdefined(position) || !isdefined(var_cec03170))
			{
				pathable = 0;
				break;
			}
			if(!strategiccommandutility::isvalidbot(bot))
			{
				pathable = 0;
				break;
			}
			queryresult = positionquery_source_navigation(var_cec03170, 0, 120, 60, 16, bot, 16);
			if(queryresult.data.size > 0)
			{
				path = _calculatepositionquerypath(queryresult, position, bot);
				if(!isdefined(path))
				{
					pathable = 0;
					break;
				}
				if(path.pathdistance > longestpath)
				{
					longestpath = path.pathdistance;
				}
			}
		}
		if(pathable)
		{
			path = array();
			path[#"distance"] = longestpath;
			path[#"entity"] = entities[entityindex];
			var_afb9d067[var_afb9d067.size] = path;
		}
	}
	return var_afb9d067;
}

/*
	Name: _calculateallpathableobjectives
	Namespace: plannercommanderutility
	Checksum: 0x8B428574
	Offset: 0x3130
	Size: 0x26A
	Parameters: 2
	Flags: Linked, Private
*/
private function _calculateallpathableobjectives(doppelbots, objectives)
{
	/#
		assert(isarray(doppelbots));
	#/
	/#
		assert(isarray(objectives));
	#/
	pathableobjectives = [];
	if(objectives.size <= 0)
	{
		return pathableobjectives;
	}
	if(doppelbots.size <= 0)
	{
		return pathableobjectives;
	}
	for(objectiveindex = 0; objectiveindex < objectives.size; objectiveindex++)
	{
		trigger = objectives[objectiveindex][#"__unsafe__"][#"trigger"];
		if(!isdefined(trigger))
		{
			continue;
		}
		pathable = 1;
		longestpath = 0;
		for(botindex = 0; botindex < doppelbots.size; botindex++)
		{
			bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
			if(!strategiccommandutility::isvalidbot(bot))
			{
				pathable = 0;
				break;
			}
			path = strategiccommandutility::calculatepathtoobjective(bot, trigger);
			if(!isdefined(path))
			{
				pathable = 0;
				break;
			}
			if(path.pathdistance > longestpath)
			{
				longestpath = path.pathdistance;
			}
		}
		if(pathable)
		{
			path = array();
			path[#"distance"] = longestpath;
			path[#"objective"] = objectives[objectiveindex];
			pathableobjectives[pathableobjectives.size] = path;
		}
	}
	return pathableobjectives;
}

/*
	Name: _calculateallpathableclients
	Namespace: plannercommanderutility
	Checksum: 0x8E8D804F
	Offset: 0x33A8
	Size: 0x3DA
	Parameters: 2
	Flags: Linked, Private
*/
private function _calculateallpathableclients(doppelbots, clients)
{
	/#
		assert(isarray(doppelbots));
	#/
	/#
		assert(isarray(clients));
	#/
	pathableclients = [];
	if(clients.size <= 0)
	{
		return pathableclients;
	}
	if(doppelbots.size <= 0)
	{
		return pathableclients;
	}
	for(clientindex = 0; clientindex < clients.size; clientindex++)
	{
		player = clients[clientindex][#"__unsafe__"][#"player"];
		if(!isdefined(player) || player isinmovemode("ufo", "noclip") || player.sessionstate !== "playing")
		{
			continue;
		}
		var_a0f4105 = strategiccommandutility::function_778568e2(player);
		clientposition = getclosestpointonnavmesh(player.origin, 200);
		pathable = 1;
		longestpath = 0;
		for(botindex = 0; botindex < doppelbots.size; botindex++)
		{
			bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
			if(!strategiccommandutility::isvalidbot(bot))
			{
				pathable = 0;
				break;
			}
			var_79c06ff6 = strategiccommandutility::function_778568e2(bot);
			if(var_79c06ff6 != var_a0f4105)
			{
				pathable = 0;
				break;
			}
			position = getclosestpointonnavmesh(bot.origin, 120, bot getpathfindingradius() * 1.05);
			if(!isdefined(position) || !isdefined(clientposition))
			{
				pathable = 0;
				break;
			}
			queryresult = positionquery_source_navigation(clientposition, 0, 120, 60, 16, bot, 16);
			if(queryresult.data.size > 0)
			{
				path = _calculatepositionquerypath(queryresult, position, bot);
				if(!isdefined(path))
				{
					pathable = 0;
					break;
				}
				if(path.pathdistance > longestpath)
				{
					longestpath = path.pathdistance;
				}
			}
		}
		if(pathable)
		{
			path = array();
			path[#"distance"] = longestpath;
			path[#"player"] = clients[clientindex];
			pathableclients[pathableclients.size] = path;
		}
	}
	return pathableclients;
}

/*
	Name: _calculatepositionquerypath
	Namespace: plannercommanderutility
	Checksum: 0xFBA4E0E9
	Offset: 0x3790
	Size: 0x174
	Parameters: 3
	Flags: Linked, Private
*/
private function _calculatepositionquerypath(queryresult, position, entity)
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
	Name: _calculateprioritygameobjects
	Namespace: plannercommanderutility
	Checksum: 0xD2CCC1F0
	Offset: 0x3910
	Size: 0x12E
	Parameters: 2
	Flags: Linked, Private
*/
private function _calculateprioritygameobjects(gameobjects, prioritygameobjectidentifiers)
{
	prioritygameobjects = [];
	foreach(gameobjectentry in gameobjects)
	{
		identifier = gameobjectentry[#"identifier"];
		if(!isdefined(identifier))
		{
			continue;
		}
		foreach(priorityidentifier in prioritygameobjectidentifiers)
		{
			if(identifier == priorityidentifier)
			{
				prioritygameobjects[prioritygameobjects.size] = gameobjectentry;
			}
		}
	}
	return prioritygameobjects;
}

/*
	Name: _updatehistoricalgameobjects
	Namespace: plannercommanderutility
	Checksum: 0xD5616A77
	Offset: 0x3A48
	Size: 0x1DC
	Parameters: 1
	Flags: Private
*/
private function _updatehistoricalgameobjects(commander)
{
	destroyedgameobjecttotal = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault_destroyed");
	assaultobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
	gameobjecttotal = 0;
	if(isarray(assaultobjects))
	{
		foreach(assaultobjectentry in assaultobjects)
		{
			if(!isdefined(assaultobjectentry))
			{
				continue;
			}
			if(assaultobjectentry[#"identifier"] === "carry_object")
			{
				continue;
			}
			gameobject = assaultobjectentry[#"__unsafe__"][#"object"];
			if(!isdefined(gameobject) || !isdefined(gameobject.trigger) || !gameobject.trigger istriggerenabled())
			{
				destroyedgameobjecttotal++;
				continue;
			}
			gameobjecttotal++;
		}
	}
	gameobjecttotal = gameobjecttotal + destroyedgameobjecttotal;
	blackboard::setstructblackboardattribute(commander, #"gameobjects_assault_destroyed", destroyedgameobjecttotal);
	blackboard::setstructblackboardattribute(commander, #"gameobjects_assault_total", gameobjecttotal);
}

/*
	Name: daemonupdateclients
	Namespace: plannercommanderutility
	Checksum: 0x12A62758
	Offset: 0x3C30
	Size: 0x46C
	Parameters: 1
	Flags: Linked, Private
*/
private function daemonupdateclients(commander)
{
	team = blackboard::getstructblackboardattribute(commander, #"team");
	clients = getplayers(team);
	doppelbots = [];
	players = [];
	vehicles = [];
	foreach(client in clients)
	{
		cachedclient = array();
		cachedclient[#"origin"] = client.origin;
		cachedclient[#"entnum"] = client getentitynumber();
		cachedclient[#"escortmainguard"] = array();
		cachedclient[#"escortrearguard"] = array();
		cachedclient[#"escortvanguard"] = array();
		if(strategiccommandutility::isvalidbot(client))
		{
			if(!isdefined(cachedclient[#"__unsafe__"]))
			{
				cachedclient[#"__unsafe__"] = array();
			}
			cachedclient[#"__unsafe__"][#"bot"] = client;
			if(client isinvehicle())
			{
				if(strategiccommandutility::function_4732f860(client))
				{
					vehicle = client getvehicleoccupied();
					if(!isdefined(cachedclient[#"__unsafe__"]))
					{
						cachedclient[#"__unsafe__"] = array();
					}
					cachedclient[#"__unsafe__"][#"vehicle"] = vehicle;
					cachedclient[#"type"] = strategiccommandutility::function_4b0c469d(vehicle);
					vehicles[vehicles.size] = cachedclient;
				}
			}
			else
			{
				cachedclient[#"type"] = "bot";
				doppelbots[doppelbots.size] = cachedclient;
			}
			continue;
		}
		if(strategiccommandutility::isvalidplayer(client))
		{
			if(!isdefined(cachedclient[#"__unsafe__"]))
			{
				cachedclient[#"__unsafe__"] = array();
			}
			cachedclient[#"__unsafe__"][#"player"] = client;
			players[players.size] = cachedclient;
		}
	}
	blackboard::setstructblackboardattribute(commander, #"hash_916ad083496a876", vehicles);
	blackboard::setstructblackboardattribute(commander, #"doppelbots", doppelbots);
	blackboard::setstructblackboardattribute(commander, #"players", players);
}

/*
	Name: daemonupdategameobjects
	Namespace: plannercommanderutility
	Checksum: 0xAADC9DD2
	Offset: 0x40A8
	Size: 0x6D4
	Parameters: 1
	Flags: Linked, Private
*/
private function daemonupdategameobjects(commander)
{
	if(isdefined(level.a_gameobjects))
	{
		commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
		var_832340f2 = strategiccommandutility::function_a1edb007(commanderteam);
		var_31b80437 = tolower(var_832340f2);
		gameobjects = array();
		var_1d83f398 = arraycopy(level.a_gameobjects);
		var_aa8d6440 = array();
		excluded = blackboard::getstructblackboardattribute(commander, #"gameobjects_exclude");
		excludedmap = array();
		foreach(excludename in excluded)
		{
			excludedmap[excludename] = 1;
		}
		restrict = blackboard::getstructblackboardattribute(commander, #"hash_5a8e9789fd37580e");
		var_fffabd2 = array();
		foreach(var_c96f243d in restrict)
		{
			var_fffabd2[var_c96f243d] = 1;
		}
		for(gameobjectindex = 0; gameobjectindex < var_1d83f398.size; gameobjectindex++)
		{
			gameobject = var_1d83f398[gameobjectindex];
			if(!isdefined(gameobject) || !isdefined(gameobject.trigger))
			{
				continue;
			}
			if(gameobject.type === "GenericObject")
			{
				continue;
			}
			if(!gameobject.trigger istriggerenabled())
			{
				continue;
			}
			if(!(gameobject.team == commanderteam || gameobject.team == var_31b80437 || gameobject.absolute_visible_and_interact_team === commanderteam || gameobject.team == #"free"))
			{
				continue;
			}
			identifier = gameobject gameobjects::get_identifier();
			if(var_fffabd2.size > 0)
			{
				if(!isdefined(identifier) || !isdefined(var_fffabd2[identifier]))
				{
					continue;
				}
			}
			if(isdefined(identifier) && isdefined(excludedmap[identifier]))
			{
				continue;
			}
			if(isdefined(gameobject.var_a267844e))
			{
				continue;
			}
			cachedgameobject = array();
			cachedgameobject[#"strategy"] = strategiccommandutility::function_423cfbc1(var_31b80437, undefined, undefined, gameobject);
			if(strategiccommandutility::function_f59ca353(cachedgameobject[#"strategy"]))
			{
				continue;
			}
			cachedgameobject[#"claimed"] = 0;
			cachedgameobject[#"type"] = "gameobject";
			if(!isdefined(cachedgameobject[#"__unsafe__"]))
			{
				cachedgameobject[#"__unsafe__"] = array();
			}
			cachedgameobject[#"__unsafe__"][#"object"] = gameobject;
			if(!isdefined(cachedgameobject[#"__unsafe__"]))
			{
				cachedgameobject[#"__unsafe__"] = array();
			}
			cachedgameobject[#"__unsafe__"][#"entity"] = gameobject.e_object;
			if(isdefined(identifier) && (identifier == "air_vehicle" || identifier == "ground_vehicle"))
			{
				var_aa8d6440[var_aa8d6440.size] = cachedgameobject;
			}
			else
			{
				gameobjects[gameobjects.size] = cachedgameobject;
			}
			if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f)
			{
				aiprofile_endentry();
				pixendevent();
				[[ level.strategic_command_throttle ]]->waitinqueue(commander);
				commander.var_22765a25 = getrealtime();
				pixbeginevent("daemonGameobjects");
				aiprofile_beginentry("daemonGameobjects");
			}
		}
		blackboard::setstructblackboardattribute(commander, #"gameobjects", gameobjects);
		blackboard::setstructblackboardattribute(commander, #"hash_1cf72c0289954423", var_aa8d6440);
	}
}

/*
	Name: function_e6443602
	Namespace: plannercommanderutility
	Checksum: 0x7C751133
	Offset: 0x4788
	Size: 0x364
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e6443602(commander)
{
	if(isdefined(level.var_97964e1))
	{
		commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
		var_832340f2 = strategiccommandutility::function_a1edb007(commanderteam);
		var_31b80437 = tolower(var_832340f2);
		bundles = array();
		foreach(gameplay in level.var_97964e1)
		{
			if(!strategiccommandutility::function_208c970d(gameplay, var_832340f2))
			{
				continue;
			}
			gpbundle = gameplay.o_gpbundle;
			type = gameplay.classname;
			var_5f31ab8b = array();
			switch(type)
			{
				case "hash_1c67b29f3576b10d":
				{
					var_5f31ab8b[#"type"] = "escortbiped";
					break;
				}
				default:
				{
					continue;
				}
			}
			var_5f31ab8b[#"strategy"] = strategiccommandutility::function_423cfbc1(var_31b80437, gpbundle.m_s_bundle);
			if(!isdefined(var_5f31ab8b[#"__unsafe__"]))
			{
				var_5f31ab8b[#"__unsafe__"] = array();
			}
			var_5f31ab8b[#"__unsafe__"][#"bundle"] = gpbundle;
			bundles[bundles.size] = var_5f31ab8b;
			if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f)
			{
				aiprofile_endentry();
				pixendevent();
				[[ level.strategic_command_throttle ]]->waitinqueue(commander);
				commander.var_22765a25 = getrealtime();
				pixbeginevent("daemonMissionComponents");
				aiprofile_beginentry("daemonMissionComponents");
			}
		}
		blackboard::setstructblackboardattribute(commander, #"gpbundles", bundles);
	}
}

/*
	Name: function_7706a6fa
	Namespace: plannercommanderutility
	Checksum: 0xBBFACE81
	Offset: 0x4AF8
	Size: 0x688
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7706a6fa(commander)
{
	if(isdefined(level.var_8239a46c) && level flagsys::get(#"hash_3a3d68ab491e1985"))
	{
		commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
		var_832340f2 = strategiccommandutility::function_a1edb007(commanderteam);
		var_31b80437 = tolower(var_832340f2);
		components = array();
		var_35301d62 = array();
		var_35301d62[#"hash_f5c6c6aa7dc0f6d"] = array();
		var_35301d62[#"hash_6e9081699001bcd9"] = array();
		var_35301d62[#"hash_3bf68fbcb5c53b6c"] = array();
		var_35301d62[#"hash_4984fd4b0ba666a2"] = array();
		foreach(var_5fbc7570 in level.var_8239a46c)
		{
			if(!strategiccommandutility::function_f867cce0(var_5fbc7570, commanderteam))
			{
				continue;
			}
			component = var_5fbc7570.var_36f0c06d;
			type = var_5fbc7570.scriptbundlename;
			var_b313868d = array();
			switch(type)
			{
				case "hash_f5c6c6aa7dc0f6d":
				{
					var_b313868d[#"type"] = "defend";
					break;
				}
				case "hash_6e9081699001bcd9":
				{
					var_b313868d[#"type"] = "destroy";
					break;
				}
				case "hash_3bf68fbcb5c53b6c":
				{
					var_b313868d[#"type"] = "capturearea";
					break;
				}
				case "hash_4984fd4b0ba666a2":
				{
					if(isdefined(component.var_c68dc48c) || isdefined(component.var_b95bcdc6))
					{
						var_b313868d[#"type"] = "goto";
					}
					else
					{
						/#
							println(("" + var_5fbc7570.origin) + "");
						#/
						continue;
					}
					break;
				}
				default:
				{
					continue;
				}
			}
			var_b313868d[#"strategy"] = strategiccommandutility::function_423cfbc1(var_31b80437, undefined, var_5fbc7570);
			if(strategiccommandutility::function_f59ca353(var_b313868d[#"strategy"]))
			{
				continue;
			}
			if(!isdefined(var_b313868d[#"__unsafe__"]))
			{
				var_b313868d[#"__unsafe__"] = array();
			}
			var_b313868d[#"__unsafe__"][#"hash_57b897c5ec9b1b71"] = var_5fbc7570;
			if(!isdefined(var_b313868d[#"__unsafe__"]))
			{
				var_b313868d[#"__unsafe__"] = array();
			}
			var_b313868d[#"__unsafe__"][#"component"] = component;
			components[components.size] = var_b313868d;
			arraysize = var_35301d62[type].size;
			var_35301d62[type][arraysize] = var_b313868d;
			if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f)
			{
				aiprofile_endentry();
				pixendevent();
				[[ level.strategic_command_throttle ]]->waitinqueue(commander);
				commander.var_22765a25 = getrealtime();
				pixbeginevent("daemonMissionComponents");
				aiprofile_beginentry("daemonMissionComponents");
			}
		}
		blackboard::setstructblackboardattribute(commander, #"hash_1eb0ee71cbc01785", components);
		foreach(var_96509353, var_c414ebaa in var_35301d62)
		{
			blackboard::setstructblackboardattribute(commander, var_96509353, var_c414ebaa);
		}
	}
}

/*
	Name: daemonupdateobjective
	Namespace: plannercommanderutility
	Checksum: 0xE9470614
	Offset: 0x5188
	Size: 0x794
	Parameters: 1
	Flags: Linked, Private
*/
private function daemonupdateobjective(commander)
{
	if(isdefined(level.a_objectives))
	{
		commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
		objectives = array();
		foreach(objective in level.a_objectives)
		{
			if(isdefined(objective.m_done) && objective.m_done)
			{
				continue;
			}
			if(isdefined(objective.m_str_team) && objective.m_str_team != commanderteam)
			{
				continue;
			}
			if(isdefined(objective.m_a_player_game_obj) && objective.m_a_player_game_obj.size > 0)
			{
				currentbreadcrumb = 0;
				furthestobjective = undefined;
				teamplayers = getplayers(commanderteam);
				foreach(player in teamplayers)
				{
					playerentitynumber = player getentitynumber();
					objectiveid = objective.m_a_player_game_obj[playerentitynumber];
					if(isdefined(objectiveid) && objective_state(objectiveid) == "active")
					{
						cachedobjective = array();
						cachedobjective[#"entnum"] = playerentitynumber;
						cachedobjective[#"id"] = objectiveid;
						cachedobjective[#"origin"] = objective_position(objectiveid);
						if(!isdefined(cachedobjective[#"__unsafe__"]))
						{
							cachedobjective[#"__unsafe__"] = array();
						}
						cachedobjective[#"__unsafe__"][#"trigger"] = undefined;
						if(isdefined(player.a_t_breadcrumbs))
						{
							cachedobjective[#"breadcrumbs"] = player.a_t_breadcrumbs.size;
							for(index = 0; index < player.a_t_breadcrumbs.size; index++)
							{
								if(player.t_current_active_breadcrumb == player.a_t_breadcrumbs[index])
								{
									cachedobjective[#"currentbreadcrumb"] = index;
									cachedobjective[#"triggermax"] = player.t_current_active_breadcrumb.maxs;
									cachedobjective[#"triggermin"] = player.t_current_active_breadcrumb.mins;
									cachedobjective[#"radius"] = player.t_current_active_breadcrumb.radius;
									if(!isdefined(cachedobjective[#"__unsafe__"]))
									{
										cachedobjective[#"__unsafe__"] = array();
									}
									cachedobjective[#"__unsafe__"][#"trigger"] = player.t_current_active_breadcrumb;
									break;
								}
							}
						}
						else
						{
							cachedobjective[#"breadcrumbs"] = 0;
							cachedobjective[#"currentbreadcrumb"] = 0;
						}
						if(currentbreadcrumb <= cachedobjective[#"currentbreadcrumb"])
						{
							currentbreadcrumb = cachedobjective[#"currentbreadcrumb"];
							furthestobjective = cachedobjective;
						}
					}
				}
				if(isdefined(furthestobjective))
				{
					objectives[objectives.size] = furthestobjective;
				}
				continue;
			}
			if(isdefined(objective.m_a_targets) && objective.m_a_targets.size > 0)
			{
				foreach(objectiveid in objective.m_a_game_obj)
				{
					if(isdefined(objectiveid) && objective_state(objectiveid) == "active")
					{
						foreach(target in objective.m_a_targets)
						{
							if(isdefined(target) && (isstruct(target) || isentity(target)) && isdefined(target.origin))
							{
								cachedobjective = array();
								cachedobjective[#"id"] = objectiveid;
								cachedobjective[#"origin"] = target.origin;
								if(!isdefined(cachedobjective[#"__unsafe__"]))
								{
									cachedobjective[#"__unsafe__"] = array();
								}
								cachedobjective[#"__unsafe__"][#"trigger"] = undefined;
							}
						}
					}
				}
			}
		}
		blackboard::setstructblackboardattribute(commander, #"objectives", objectives);
	}
}

/*
	Name: function_790fb743
	Namespace: plannercommanderutility
	Checksum: 0x4FB76F2
	Offset: 0x5928
	Size: 0xF6
	Parameters: 2
	Flags: Linked
*/
function function_790fb743(planner, constants)
{
	/#
		assert(isstring(constants[#"key"]) || function_7a600918(constants[#"key"]), ("" + "") + "");
	#/
	attribute = planner::getblackboardattribute(planner, constants[#"key"]);
	if(isdefined(attribute) && isarray(attribute))
	{
		return attribute.size > 0;
	}
	return 0;
}

/*
	Name: function_a05a08bf
	Namespace: plannercommanderutility
	Checksum: 0xF8747714
	Offset: 0x5A28
	Size: 0xBC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a05a08bf(planner, constants)
{
	/#
		assert(isstring(constants[#"key"]) || function_7a600918(constants[#"key"]), ("" + "") + "");
	#/
	return isdefined(planner::getblackboardattribute(planner, constants[#"key"]));
}

/*
	Name: strategyblackboardvalueistrue
	Namespace: plannercommanderutility
	Checksum: 0x10C0CB6C
	Offset: 0x5AF0
	Size: 0xC0
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyblackboardvalueistrue(planner, constants)
{
	/#
		assert(isstring(constants[#"key"]) || function_7a600918(constants[#"key"]), ("" + "") + "");
	#/
	return planner::getblackboardattribute(planner, constants[#"key"]) == 1;
}

/*
	Name: function_a75b29d8
	Namespace: plannercommanderutility
	Checksum: 0xE6BD1FD5
	Offset: 0x5BB8
	Size: 0x20E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a75b29d8(planner, constants)
{
	/#
		assert(isstring(constants[#"focus"]) || function_7a600918(constants[#"focus"]), ("" + "") + "");
	#/
	target = planner::getblackboardattribute(planner, #"current_target");
	/#
		assert(isdefined(target));
	#/
	if(!isdefined(target))
	{
		return 0;
	}
	strategy = target[#"strategy"];
	/#
		assert(isstruct(strategy));
	#/
	if(!isstruct(strategy))
	{
		return 0;
	}
	var_90b56683 = strategiccommandutility::function_f4921cb3(constants[#"focus"]);
	var_3c288f1b = strategy.("doppelbotsfocus");
	foreach(focus in var_90b56683)
	{
		if(var_3c288f1b == focus)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_e0092cfc
	Namespace: plannercommanderutility
	Checksum: 0x1934E10F
	Offset: 0x5DD0
	Size: 0x242
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e0092cfc(planner, constant)
{
	planner::setblackboardattribute(planner, #"current_target", undefined);
	targets = planner::getblackboardattribute(planner, #"targets");
	/#
		assert(isarray(targets));
	#/
	if(!isarray(targets))
	{
		return spawnstruct();
	}
	priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"hash_46658a8270df5a9e");
	/#
		assert(isarray(priorities));
	#/
	foreach(priority in priorities)
	{
		if(targets[priority].size > 0)
		{
			planner::setblackboardattribute(planner, #"current_target", targets[priority][0]);
			break;
		}
	}
	return spawnstruct();
}

/*
	Name: function_86270cca
	Namespace: plannercommanderutility
	Checksum: 0xECA19666
	Offset: 0x6020
	Size: 0x5AA
	Parameters: 2
	Flags: Linked, Private
*/
private function function_86270cca(planner, constant)
{
	target = planner::getblackboardattribute(planner, #"current_target");
	validsquads = planner::getblackboardattribute(planner, #"hash_4661e4151a0f3f7d");
	if(getdvarint(#"hash_6cad7fcde98d23ee", 0))
	{
		var_41ecbdf4 = array();
		if(!isdefined(target) || !isarray(validsquads) || validsquads.size <= 0)
		{
			planner::setblackboardattribute(planner, #"hash_1a25f2c4feaf60cf", var_41ecbdf4);
			return spawnstruct();
		}
		gameobject = target[#"__unsafe__"][#"object"];
		if(isdefined(gameobject))
		{
			foreach(squad in validsquads)
			{
				pathablegameobjects = _calculateallpathablegameobjects(planner, squad, array(target));
				if(pathablegameobjects.size > 0)
				{
					var_3703551e = array();
					var_3703551e[#"squad"] = squad;
					var_3703551e[#"pathablegameobjects"] = pathablegameobjects;
					var_41ecbdf4[var_41ecbdf4.size] = var_3703551e;
				}
			}
		}
		component = target[#"__unsafe__"][#"component"];
		if(isdefined(component))
		{
			foreach(squad in validsquads)
			{
				var_3fc85ed1 = function_77cd4593(planner, squad, array(target));
				if(var_3fc85ed1.size > 0)
				{
					var_3703551e = array();
					var_3703551e[#"squad"] = squad;
					var_3703551e[#"hash_1afef53505df03e"] = var_3fc85ed1;
					var_41ecbdf4[var_41ecbdf4.size] = var_3703551e;
				}
			}
		}
		bundle = target[#"__unsafe__"][#"bundle"];
		if(isdefined(bundle))
		{
			foreach(squad in validsquads)
			{
				var_8c6da8a9 = function_816f4052(planner, squad, array(target));
				if(var_8c6da8a9.size > 0)
				{
					var_3703551e = array();
					var_3703551e[#"squad"] = squad;
					var_3703551e[#"hash_8b60f743ed9b0d3"] = var_8c6da8a9;
					var_41ecbdf4[var_41ecbdf4.size] = var_3703551e;
				}
			}
		}
		planner::setblackboardattribute(planner, #"hash_1a25f2c4feaf60cf", var_41ecbdf4);
	}
	else
	{
		var_41ecbdf4 = array();
		foreach(squad in validsquads)
		{
			var_3703551e = array();
			var_3703551e[#"squad"] = squad;
			var_41ecbdf4[var_41ecbdf4.size] = var_3703551e;
		}
		planner::setblackboardattribute(planner, #"hash_1a25f2c4feaf60cf", var_41ecbdf4);
	}
	return spawnstruct();
}

/*
	Name: function_14c766b3
	Namespace: plannercommanderutility
	Checksum: 0xDFA873D6
	Offset: 0x65D8
	Size: 0x472
	Parameters: 2
	Flags: Linked, Private
*/
private function function_14c766b3(planner, constant)
{
	var_3d32e488 = planner::getblackboardattribute(planner, #"hash_6df1f48e5a0dda8");
	target = planner::getblackboardattribute(planner, #"current_target");
	var_3db29cab = 0;
	if(target[#"type"] == "gameobject")
	{
		object = target[#"__unsafe__"][#"object"];
		if(isdefined(object) && isarray(object.keyobject) && object.keyobject.size > 0)
		{
			var_3db29cab = 1;
		}
	}
	players = planner::getblackboardattribute(planner, #"players");
	var_bb89f65e = players.size > 0;
	var_8769837e = !var_bb89f65e || target[#"strategy"].("doppelbotsinteractions") == #"hash_7fa10febd2862b4a";
	var_f75536ec = !var_bb89f65e || target[#"strategy"].("companionsinteractions") == #"hash_7fa10febd2862b4a";
	var_f22aefd = strategiccommandutility::function_698a5382(target[#"strategy"]);
	var_e6966cf8 = strategiccommandutility::function_54032f13(target[#"strategy"]);
	var_eda803e5 = var_e6966cf8;
	validsquads = [];
	foreach(squad in var_3d32e488)
	{
		foreach(member in squad)
		{
			bot = member[#"__unsafe__"][#"bot"];
			if(!isdefined(bot))
			{
				break;
			}
			if(!var_8769837e)
			{
				continue;
			}
			if(var_3db29cab && !bot gameobjects::has_key_object(object))
			{
				continue;
			}
			if(var_f22aefd && member[#"type"] == "air")
			{
				validsquads[validsquads.size] = squad;
				break;
				continue;
			}
			if(var_e6966cf8 && member[#"type"] == "ground")
			{
				validsquads[validsquads.size] = squad;
				break;
				continue;
			}
			if(var_eda803e5 && member[#"type"] == "bot")
			{
				validsquads[validsquads.size] = squad;
				break;
			}
		}
	}
	planner::setblackboardattribute(planner, #"hash_4661e4151a0f3f7d", validsquads);
	return spawnstruct();
}

/*
	Name: function_52012b78
	Namespace: plannercommanderutility
	Checksum: 0x83FD9145
	Offset: 0x6A58
	Size: 0x2AA
	Parameters: 2
	Flags: Linked, Private
*/
private function function_52012b78(planner, constant)
{
	target = planner::getblackboardattribute(planner, #"current_target");
	/#
		assert(isdefined(target));
	#/
	if(!isdefined(target))
	{
		return spawnstruct();
	}
	strategy = target[#"strategy"];
	/#
		assert(isstruct(strategy));
	#/
	if(!isstruct(strategy))
	{
		return spawnstruct();
	}
	distribution = strategy.("doppelbotsdistribution");
	priority = strategy.("doppelbotspriority");
	targets = planner::getblackboardattribute(planner, #"targets");
	/#
		assert(isarray(targets));
	#/
	if(!isarray(targets))
	{
		return spawnstruct();
	}
	switch(distribution)
	{
		case "evenly":
		{
			arrayremoveindex(targets[priority], 0);
			targets[priority][targets.size] = target;
			break;
		}
		case "greedy":
		{
			break;
		}
		case "uniquely":
		{
			arrayremoveindex(targets[priority], 0);
			break;
		}
		default:
		{
			/#
				assert(0);
			#/
		}
	}
	planner::setblackboardattribute(planner, #"targets", targets);
	return spawnstruct();
}

/*
	Name: function_34464159
	Namespace: plannercommanderutility
	Checksum: 0x4DE03A0B
	Offset: 0x6D10
	Size: 0x2B2
	Parameters: 2
	Flags: Linked, Private
*/
private function function_34464159(planner, constant)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	target = planner::getblackboardattribute(planner, "target", squadindex);
	bundle = target[#"__unsafe__"][#"bundle"];
	if(!isdefined(bundle))
	{
		return spawnstruct();
	}
	team = planner::getblackboardattribute(planner, #"team");
	if(!strategiccommandutility::function_a0f88aca(bundle, team))
	{
		return spawnstruct();
	}
	switch(bundle.m_str_type)
	{
		case "escortbiped":
		{
			entity = bundle.var_27726d51;
		}
	}
	if(!isdefined(entity))
	{
		return spawnstruct();
	}
	var_eec336d1 = [];
	if(!isdefined(var_eec336d1[#"__unsafe__"]))
	{
		var_eec336d1[#"__unsafe__"] = array();
	}
	var_eec336d1[#"__unsafe__"][#"entity"] = entity;
	entities = array(var_eec336d1);
	pathableescorts = function_98bde2b6(doppelbots, entities);
	planner::setblackboardattribute(planner, "pathable_escorts", pathableescorts, squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadcalculatepathableobjectivesparam
	Namespace: plannercommanderutility
	Checksum: 0x725F6C25
	Offset: 0x6FD0
	Size: 0x10A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadcalculatepathableobjectivesparam(planner, constant)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	objectives = planner::getblackboardattribute(planner, #"objectives");
	pathableobjectives = _calculateallpathableobjectives(doppelbots, objectives);
	planner::setblackboardattribute(planner, "pathable_objectives", pathableobjectives, squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadcalculatepathableplayersparam
	Namespace: plannercommanderutility
	Checksum: 0xF477DEF6
	Offset: 0x70E8
	Size: 0x10A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadcalculatepathableplayersparam(planner, constant)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	players = planner::getblackboardattribute(planner, #"players");
	pathableescorts = _calculateallpathableclients(doppelbots, players);
	planner::setblackboardattribute(planner, "pathable_escorts", pathableescorts, squadindex);
	return spawnstruct();
}

/*
	Name: strategyincrementblackboardvalue
	Namespace: plannercommanderutility
	Checksum: 0x2BB147AC
	Offset: 0x7200
	Size: 0xF4
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyincrementblackboardvalue(planner, constants)
{
	/#
		assert(isarray(constants));
	#/
	/#
		assert(isstring(constants[#"name"]) || function_7a600918(constants[#"name"]));
	#/
	planner::setblackboardattribute(planner, constants[#"name"], planner::getblackboardattribute(planner, constants[#"name"]) + 1);
}

/*
	Name: function_166d74b2
	Namespace: plannercommanderutility
	Checksum: 0x7B0B17A1
	Offset: 0x7300
	Size: 0x354
	Parameters: 2
	Flags: Linked, Private
*/
private function function_166d74b2(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex > 0, "");
	#/
	currentsquad = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	var_3d32e488 = planner::getblackboardattribute(planner, #"hash_6df1f48e5a0dda8");
	for(i = 0; i < var_3d32e488.size; i++)
	{
		var_b44338e1 = 1;
		foreach(possiblemember in var_3d32e488[i])
		{
			var_5dc382b8 = 0;
			foreach(currentmember in currentsquad)
			{
				if(possiblemember[#"entnum"] == currentmember[#"entnum"])
				{
					var_5dc382b8 = 1;
					break;
				}
			}
			if(!var_5dc382b8)
			{
				var_b44338e1 = 0;
				break;
			}
		}
		if(var_b44338e1)
		{
			arrayremoveindex(var_3d32e488, i);
			break;
		}
	}
	planner::setblackboardattribute(planner, #"hash_6df1f48e5a0dda8", var_3d32e488);
	idlebots = array();
	for(squadindex = 0; squadindex < var_3d32e488.size; squadindex++)
	{
		squad = var_3d32e488[squadindex];
		for(var_353877ef = 0; var_353877ef < squad.size; var_353877ef++)
		{
			idlebots[idlebots.size] = squad[var_353877ef];
		}
	}
	/#
		var_26ae1214 = planner::getblackboardattribute(planner, #"idle_doppelbots").size;
		/#
			assert(var_26ae1214 > idlebots.size, "");
		#/
	#/
	planner::setblackboardattribute(planner, #"idle_doppelbots", idlebots);
}

/*
	Name: function_f162255b
	Namespace: plannercommanderutility
	Checksum: 0x928323A8
	Offset: 0x7660
	Size: 0x1C4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_f162255b(planner, constants)
{
	targets = planner::getblackboardattribute(planner, #"targets");
	priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"hash_46658a8270df5a9e");
	/#
		assert(isarray(priorities));
	#/
	foreach(priority in priorities)
	{
		if(targets[priority].size > 0)
		{
			arrayremoveindex(targets[priority], 0);
			break;
		}
	}
	planner::setblackboardattribute(planner, #"targets", targets);
}

/*
	Name: strategysetblackboardvalue
	Namespace: plannercommanderutility
	Checksum: 0x22D674DF
	Offset: 0x7830
	Size: 0xDC
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysetblackboardvalue(planner, constants)
{
	/#
		assert(isarray(constants));
	#/
	/#
		assert(isstring(constants[#"name"]) || function_7a600918(constants[#"name"]));
	#/
	planner::setblackboardattribute(planner, constants[#"name"], constants[#"value"]);
}

/*
	Name: function_20de0d52
	Namespace: plannercommanderutility
	Checksum: 0x2D925BAA
	Offset: 0x7918
	Size: 0xE4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_20de0d52(planner, constants)
{
	/#
		assert(isarray(constants));
	#/
	/#
		assert(isstring(constants[#"name"]) || function_7a600918(constants[#"name"]));
	#/
	planner::setblackboardattribute(planner, constants[#"name"], array());
}

/*
	Name: strategyshouldrushprogress
	Namespace: plannercommanderutility
	Checksum: 0x82E23CB1
	Offset: 0x7A08
	Size: 0x1DE
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyshouldrushprogress(planner, constant)
{
	if(planner::getblackboardattribute(planner, #"allow_progress_throttling") === 1)
	{
		enemycommander = planner::getblackboardattribute(planner, #"throttling_enemy_commander");
		if(!isdefined(enemycommander))
		{
			return 0;
		}
		lowerbound = planner::getblackboardattribute(planner, #"throttling_lower_bound");
		upperbound = planner::getblackboardattribute(planner, #"throttling_upper_bound");
		destroyedassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_destroyed");
		totalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects");
		if(!isdefined(totalassaults))
		{
			totalassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_total");
		}
		enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_destroyed");
		enemytotalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects_enemy");
		if(!isdefined(enemytotalassaults))
		{
			enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_total");
		}
		return strategiccommandutility::calculateprogressrushing(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults);
	}
	return 0;
}

/*
	Name: strategyshouldthrottleprogress
	Namespace: plannercommanderutility
	Checksum: 0x329638FC
	Offset: 0x7BF0
	Size: 0x1DE
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyshouldthrottleprogress(planner, constant)
{
	if(planner::getblackboardattribute(planner, #"allow_progress_throttling") === 1)
	{
		enemycommander = planner::getblackboardattribute(planner, #"throttling_enemy_commander");
		if(!isdefined(enemycommander))
		{
			return 0;
		}
		lowerbound = planner::getblackboardattribute(planner, #"throttling_lower_bound");
		upperbound = planner::getblackboardattribute(planner, #"throttling_upper_bound");
		destroyedassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_destroyed");
		totalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects");
		if(!isdefined(totalassaults))
		{
			totalassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_total");
		}
		enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_destroyed");
		enemytotalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects_enemy");
		if(!isdefined(enemytotalassaults))
		{
			enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_total");
		}
		return strategiccommandutility::calculateprogressthrottling(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults);
	}
	return 0;
}

/*
	Name: strategysquadorderparam
	Namespace: plannercommanderutility
	Checksum: 0xEFE2ED83
	Offset: 0x7DD8
	Size: 0x122
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadorderparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	/#
		assert(isstring(constants[#"order"]) || function_7a600918(constants[#"order"]), ("" + "") + "");
	#/
	planner::setblackboardattribute(planner, "order", constants[#"order"], squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadassignforcegoalparam
	Namespace: plannercommanderutility
	Checksum: 0x3962DC7F
	Offset: 0x7F08
	Size: 0xC2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadassignforcegoalparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	forcegoal = planner::getblackboardattribute(planner, #"force_goal");
	planner::setblackboardattribute(planner, "force_goal", forcegoal, squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadassignpathableescortparam
	Namespace: plannercommanderutility
	Checksum: 0xD08E876D
	Offset: 0x7FD8
	Size: 0x26A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadassignpathableescortparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	pathableescorts = planner::getblackboardattribute(planner, "pathable_escorts", squadindex);
	if(!isarray(pathableescorts) || pathableescorts.size <= 0)
	{
		return spawnstruct();
	}
	shortestpath = pathableescorts[0][#"distance"];
	types = array("player", "entity");
	foreach(type in types)
	{
		if(isdefined(pathableescorts[0][type]))
		{
			escort = pathableescorts[0][type];
			for(index = 1; index < pathableescorts.size; index++)
			{
				pathableescort = pathableescorts[index];
				if(pathableescort[#"distance"] < shortestpath)
				{
					shortestpath = pathableescort[#"distance"];
					escort = pathableescort[type];
				}
			}
			planner::setblackboardattribute(planner, "escorts", array(escort), squadindex);
		}
	}
	return spawnstruct();
}

/*
	Name: strategysquadassignpathableobjectparam
	Namespace: plannercommanderutility
	Checksum: 0x4C237CCC
	Offset: 0x8250
	Size: 0x2C2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadassignpathableobjectparam(planner, constant)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	pathablegameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
	prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
	gameobject = undefined;
	foreach(priorityname in prioritynames)
	{
		foreach(pathablegameobject in pathablegameobjects)
		{
			if(pathablegameobject[#"gameobject"][#"identifier"] === priorityname)
			{
				gameobject = pathablegameobject[#"gameobject"];
				break;
			}
		}
	}
	if(!isdefined(gameobject))
	{
		shortestpath = pathablegameobjects[0][#"distance"];
		gameobject = pathablegameobjects[0][#"gameobject"];
		for(index = 1; index < pathablegameobjects.size; index++)
		{
			pathablegameobject = pathablegameobjects[index];
			if(pathablegameobject[#"distance"] < shortestpath)
			{
				shortestpath = pathablegameobject[#"distance"];
				gameobject = pathablegameobject[#"gameobject"];
			}
		}
	}
	planner::setblackboardattribute(planner, "gameobjects", array(gameobject), squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadassignpathableobjectiveparam
	Namespace: plannercommanderutility
	Checksum: 0xC0AEFEA8
	Offset: 0x8520
	Size: 0x192
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadassignpathableobjectiveparam(planner, constant)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	pathableobjectives = planner::getblackboardattribute(planner, "pathable_objectives", squadindex);
	shortestpath = pathableobjectives[0][#"distance"];
	objective = pathableobjectives[0][#"objective"];
	for(index = 1; index < pathableobjectives.size; index++)
	{
		pathableobjective = pathableobjectives[index];
		if(pathableobjective[#"distance"] < shortestpath)
		{
			shortestpath = pathableobjective[#"distance"];
			objective = pathableobjective[#"objective"];
		}
	}
	planner::setblackboardattribute(planner, "objectives", array(objective), squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadassignpathableunclaimedobjectparam
	Namespace: plannercommanderutility
	Checksum: 0x796F4162
	Offset: 0x86C0
	Size: 0x32A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadassignpathableunclaimedobjectparam(planner, constant)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	pathablegameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
	prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
	gameobject = undefined;
	foreach(priorityname in prioritynames)
	{
		foreach(pathablegameobject in pathablegameobjects)
		{
			if(!pathablegameobject[#"gameobject"][#"claimed"] && pathablegameobject[#"gameobject"][#"identifier"] === priorityname)
			{
				gameobject = pathablegameobject[#"gameobject"];
				break;
			}
		}
	}
	if(!isdefined(gameobject))
	{
		shortestpath = undefined;
		foreach(pathablegameobject in pathablegameobjects)
		{
			if(!pathablegameobject[#"gameobject"][#"claimed"] && (!isdefined(shortestpath) || pathablegameobject[#"distance"] < shortestpath))
			{
				shortestpath = pathablegameobject[#"distance"];
				gameobject = pathablegameobject[#"gameobject"];
			}
		}
	}
	if(isdefined(gameobject))
	{
		planner::setblackboardattribute(planner, "gameobjects", array(gameobject), squadindex);
	}
	return spawnstruct();
}

/*
	Name: function_b77887e
	Namespace: plannercommanderutility
	Checksum: 0xB4C9E3EB
	Offset: 0x89F8
	Size: 0xDA
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b77887e(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	currenttarget = planner::getblackboardattribute(planner, #"current_target");
	/#
		assert(isdefined(currenttarget), "");
	#/
	planner::setblackboardattribute(planner, "target", currenttarget, squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadassignwanderparam
	Namespace: plannercommanderutility
	Checksum: 0x4BA58032
	Offset: 0x8AE0
	Size: 0x9A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadassignwanderparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	planner::setblackboardattribute(planner, "order", "order_wander", squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadclaimobjectparam
	Namespace: plannercommanderutility
	Checksum: 0x2DAA736B
	Offset: 0x8B88
	Size: 0x142
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadclaimobjectparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	gameobjects = planner::getblackboardattribute(planner, "gameobjects", squadindex);
	/#
		assert(gameobjects.size > 0, "");
	#/
	foreach(gameobject in gameobjects)
	{
		gameobject[#"claimed"] = 1;
	}
	return spawnstruct();
}

/*
	Name: strategysquadcopyblackboardvalue
	Namespace: plannercommanderutility
	Checksum: 0x12516E7C
	Offset: 0x8CD8
	Size: 0x1C4
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadcopyblackboardvalue(planner, constants)
{
	/#
		assert(isstring(constants[#"from"]) || function_7a600918(constants[#"from"]), ("" + "") + "");
	#/
	/#
		assert(isstring(constants[#"to"]) || function_7a600918(constants[#"to"]), ("" + "") + "");
	#/
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	value = planner::getblackboardattribute(planner, constants[#"from"], squadindex);
	planner::setblackboardattribute(planner, constants[#"to"], value, squadindex);
}

/*
	Name: function_86c0732e
	Namespace: plannercommanderutility
	Checksum: 0x3B984550
	Offset: 0x8EA8
	Size: 0x1C4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_86c0732e(planner, constants)
{
	/#
		assert(isstring(constants[#"from"]) || function_7a600918(constants[#"from"]), ("" + "") + "");
	#/
	/#
		assert(isstring(constants[#"to"]) || function_7a600918(constants[#"to"]), ("" + "") + "");
	#/
	value = planner::getblackboardattribute(planner, constants[#"from"]);
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	planner::setblackboardattribute(planner, constants[#"to"], value, squadindex);
}

/*
	Name: function_d58b0781
	Namespace: plannercommanderutility
	Checksum: 0x2200D856
	Offset: 0x9078
	Size: 0x42
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d58b0781(planner, constants)
{
	return function_faa6dd57(planner, constants, constants[#"key"]);
}

/*
	Name: function_45f841ea
	Namespace: plannercommanderutility
	Checksum: 0xA22DC873
	Offset: 0x90C8
	Size: 0x3A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_45f841ea(planner, constants)
{
	return function_faa6dd57(planner, constants, #"hash_1a25f2c4feaf60cf");
}

/*
	Name: function_faa6dd57
	Namespace: plannercommanderutility
	Checksum: 0x9E924DD4
	Offset: 0x9110
	Size: 0x2C2
	Parameters: 3
	Flags: Linked, Private
*/
private function function_faa6dd57(planner, constants, var_92812a91)
{
	squads = planner::getblackboardattribute(planner, var_92812a91);
	/#
		assert(isarray(squads));
	#/
	/#
		assert(squads.size > 0, ("" + var_92812a91) + "");
	#/
	if(!isarray(squads))
	{
		return spawnstruct();
	}
	var_75ff48f8 = squads[0];
	var_d91b9923 = array();
	foreach(botentry in var_75ff48f8[#"squad"])
	{
		bot = botentry[#"__unsafe__"][#"bot"];
		if(!isdefined(bot))
		{
			continue;
		}
		var_d91b9923[bot getentitynumber()] = 1;
	}
	squadindex = planner::createsubblackboard(planner);
	/#
		assert(squadindex <= 17, "");
	#/
	planner::setblackboardattribute(planner, #"current_squad", squadindex);
	planner::setblackboardattribute(planner, "doppelbots", var_75ff48f8[#"squad"], squadindex);
	team = planner::getblackboardattribute(planner, #"team");
	planner::setblackboardattribute(planner, "team", team, squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadcreateofsizexparam
	Namespace: plannercommanderutility
	Checksum: 0xBB81C77B
	Offset: 0x93E0
	Size: 0x2C2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadcreateofsizexparam(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	doppelbots = planner::getblackboardattribute(planner, #"idle_doppelbots");
	/#
		assert(doppelbots.size >= constants[#"amount"], ("" + constants[#"amount"]) + "");
	#/
	enlisteddoppelbots = array();
	idledoppelbots = array();
	for(index = 0; index < constants[#"amount"]; index++)
	{
		enlisteddoppelbots[enlisteddoppelbots.size] = doppelbots[index];
	}
	for(index = constants[#"amount"]; index < doppelbots.size; index++)
	{
		idledoppelbots[idledoppelbots.size] = doppelbots[index];
	}
	planner::setblackboardattribute(planner, #"idle_doppelbots", idledoppelbots);
	squadindex = planner::createsubblackboard(planner);
	/#
		assert(squadindex <= 17, "");
	#/
	planner::setblackboardattribute(planner, #"current_squad", squadindex);
	planner::setblackboardattribute(planner, "doppelbots", enlisteddoppelbots, squadindex);
	team = planner::getblackboardattribute(planner, #"team");
	planner::setblackboardattribute(planner, "team", team, squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadescortassignmainguardparam
	Namespace: plannercommanderutility
	Checksum: 0xBE9BBCF3
	Offset: 0x96B0
	Size: 0x1BA
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadescortassignmainguardparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
	squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	foreach(escort in escorts)
	{
		escort[#"escortmainguard"] = arraycombine(escort[#"escortmainguard"], squadbots, 1, 0);
	}
	planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
	planner::setblackboardattribute(planner, "order", "order_escort_mainguard", squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadescortassignrearguardparam
	Namespace: plannercommanderutility
	Checksum: 0xC6B10255
	Offset: 0x9878
	Size: 0x1BA
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadescortassignrearguardparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
	squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	foreach(escort in escorts)
	{
		escort[#"escortrearguard"] = arraycombine(escort[#"escortrearguard"], squadbots, 1, 0);
	}
	planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
	planner::setblackboardattribute(planner, "order", "order_escort_rearguard", squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadescortassignvanguardparam
	Namespace: plannercommanderutility
	Checksum: 0x402E2E8A
	Offset: 0x9A40
	Size: 0x1BA
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadescortassignvanguardparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
	squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	foreach(escort in escorts)
	{
		escort[#"escortvanguard"] = arraycombine(escort[#"escortvanguard"], squadbots, 1, 0);
	}
	planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
	planner::setblackboardattribute(planner, "order", "order_escort_vanguard", squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadescortcalculatepathablepoiparam
	Namespace: plannercommanderutility
	Checksum: 0x3BC20ACE
	Offset: 0x9C08
	Size: 0x11A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadescortcalculatepathablepoiparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
	/#
		assert(isarray(escorts) && escorts.size > 0, "");
	#/
	escortpoi = array();
	planner::setblackboardattribute(planner, "escort_poi", escortpoi, squadindex);
	return spawnstruct();
}

/*
	Name: strategysquadescorthasnomainguard
	Namespace: plannercommanderutility
	Checksum: 0x4E929437
	Offset: 0x9D30
	Size: 0x10E
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadescorthasnomainguard(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
	foreach(escort in escorts)
	{
		if(escort[#"escortmainguard"].size > 0)
		{
			return 1;
		}
	}
	return 1;
}

/*
	Name: strategysquadescorthasnorearguard
	Namespace: plannercommanderutility
	Checksum: 0xC7128A9E
	Offset: 0x9E48
	Size: 0x10C
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadescorthasnorearguard(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
	foreach(escort in escorts)
	{
		if(escort[#"escortrearguard"].size > 0)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: strategysquadescorthasnovanguard
	Namespace: plannercommanderutility
	Checksum: 0x59C91AB0
	Offset: 0x9F60
	Size: 0x10C
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadescorthasnovanguard(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
	foreach(escort in escorts)
	{
		if(escort[#"escortvanguard"].size > 0)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: strategysquadsortescortpoi
	Namespace: plannercommanderutility
	Checksum: 0xC4DD410
	Offset: 0xA078
	Size: 0x19C
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadsortescortpoi(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escortpois = planner::getblackboardattribute(planner, "escort_poi", squadindex);
	if(escortpois.size > 0)
	{
		for(index = 0; index < escortpois.size; index++)
		{
			closestindex = index;
			for(innerindex = index + 1; innerindex < escortpois.size; innerindex++)
			{
				if(escortpois[innerindex][#"distance"] < escortpois[closestindex][#"distance"])
				{
					closestindex = innerindex;
				}
			}
			temp = escortpois[index];
			escortpois[index] = escortpois[closestindex];
			escortpois[closestindex] = temp;
		}
	}
	planner::setblackboardattribute(planner, "escort_poi", escortpois, squadindex);
}

/*
	Name: bunker_exposure_scale
	Namespace: plannercommanderutility
	Checksum: 0xA9D5736
	Offset: 0xA220
	Size: 0x146
	Parameters: 2
	Flags: Linked, Private
*/
private function bunker_exposure_scale(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	/#
		assert(isstring(constants[#"key"]) || function_7a600918(constants[#"key"]), ("" + "") + "");
	#/
	attribute = planner::getblackboardattribute(planner, constants[#"key"], squadindex);
	if(isdefined(attribute) && isarray(attribute))
	{
		return attribute.size > 0;
	}
	return 0;
}

/*
	Name: strategysquadhaspathableescort
	Namespace: plannercommanderutility
	Checksum: 0x3675944A
	Offset: 0xA370
	Size: 0x98
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadhaspathableescort(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escorts = planner::getblackboardattribute(planner, "pathable_escorts", squadindex);
	return escorts.size > 0;
}

/*
	Name: strategysquadhaspathableobject
	Namespace: plannercommanderutility
	Checksum: 0xC1AB06B1
	Offset: 0xA410
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadhaspathableobject(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	gameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
	return isdefined(gameobjects) && gameobjects.size > 0;
}

/*
	Name: strategysquadhaspathableobjective
	Namespace: plannercommanderutility
	Checksum: 0x4A4AA98B
	Offset: 0xA4C0
	Size: 0x98
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadhaspathableobjective(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	objectives = planner::getblackboardattribute(planner, "pathable_objectives", squadindex);
	return objectives.size > 0;
}

/*
	Name: strategysquadhaspathableunclaimedobject
	Namespace: plannercommanderutility
	Checksum: 0xC1DFEB1
	Offset: 0xA560
	Size: 0xEE
	Parameters: 2
	Flags: Linked, Private
*/
private function strategysquadhaspathableunclaimedobject(planner, constant)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	gameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
	for(index = 0; index < gameobjects.size; index++)
	{
		if(!gameobjects[index][#"gameobject"][#"claimed"])
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: strategyhasatleastxassaultobjects
	Namespace: plannercommanderutility
	Checksum: 0x2EA818A3
	Offset: 0xA658
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasatleastxassaultobjects(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	return planner::getblackboardattribute(planner, #"gameobjects_assault").size >= constants[#"amount"];
}

/*
	Name: strategyhasatleastxdefendobjects
	Namespace: plannercommanderutility
	Checksum: 0x2EDFED4C
	Offset: 0xA708
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasatleastxdefendobjects(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	return planner::getblackboardattribute(planner, #"gameobjects_defend").size >= constants[#"amount"];
}

/*
	Name: strategyhasatleastxobjectives
	Namespace: plannercommanderutility
	Checksum: 0xEB6FD23D
	Offset: 0xA7B8
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasatleastxobjectives(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	return planner::getblackboardattribute(planner, #"objectives").size >= constants[#"amount"];
}

/*
	Name: strategyhasatleastxplayers
	Namespace: plannercommanderutility
	Checksum: 0x5DA7EBB0
	Offset: 0xA868
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasatleastxplayers(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	return planner::getblackboardattribute(planner, #"players").size >= constants[#"amount"];
}

/*
	Name: strategyhasatleastxpriorityassaultobjects
	Namespace: plannercommanderutility
	Checksum: 0x28D70AF3
	Offset: 0xA918
	Size: 0x21E
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasatleastxpriorityassaultobjects(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	if(strategyhasatleastxassaultobjects(planner, constants))
	{
		prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
		prioritymap = [];
		foreach(priorityname in prioritynames)
		{
			prioritymap[priorityname] = 1;
		}
		priorityobjects = 0;
		gameobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
		foreach(gameobject in gameobjects)
		{
			if(isdefined(gameobject[#"identifier"]) && isdefined(prioritymap[gameobject[#"identifier"]]))
			{
				priorityobjects++;
			}
		}
		return priorityobjects >= constants[#"amount"];
	}
	return 0;
}

/*
	Name: strategyhasatleastxprioritydefendobjects
	Namespace: plannercommanderutility
	Checksum: 0x3B7F891E
	Offset: 0xAB40
	Size: 0x21E
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasatleastxprioritydefendobjects(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	if(strategyhasatleastxassaultobjects(planner, constants))
	{
		prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
		prioritymap = [];
		foreach(priorityname in prioritynames)
		{
			prioritymap[priorityname] = 1;
		}
		priorityobjects = 0;
		gameobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
		foreach(gameobject in gameobjects)
		{
			if(isdefined(gameobject[#"identifier"]) && isdefined(prioritymap[gameobject[#"identifier"]]))
			{
				priorityobjects++;
			}
		}
		return priorityobjects >= constants[#"amount"];
	}
	return 0;
}

/*
	Name: strategyhasatleastxunassignedbots
	Namespace: plannercommanderutility
	Checksum: 0x9EF6ECC
	Offset: 0xAD68
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasatleastxunassignedbots(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	return planner::getblackboardattribute(planner, #"idle_doppelbots").size >= constants[#"amount"];
}

/*
	Name: strategyhasatleastxunclaimedassaultobjects
	Namespace: plannercommanderutility
	Checksum: 0xFB435738
	Offset: 0xAE18
	Size: 0x13A
	Parameters: 2
	Flags: Linked
*/
function strategyhasatleastxunclaimedassaultobjects(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	unclaimedobjects = 0;
	gameobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
	foreach(gameobject in gameobjects)
	{
		if(!gameobject[#"claimed"])
		{
			unclaimedobjects++;
		}
	}
	return unclaimedobjects >= constants[#"amount"];
}

/*
	Name: strategyhasatleastxunclaimeddefendobjects
	Namespace: plannercommanderutility
	Checksum: 0xE06DBE3
	Offset: 0xAF60
	Size: 0x13A
	Parameters: 2
	Flags: Linked
*/
function strategyhasatleastxunclaimeddefendobjects(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	unclaimedobjects = 0;
	gameobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
	foreach(gameobject in gameobjects)
	{
		if(!gameobject[#"claimed"])
		{
			unclaimedobjects++;
		}
	}
	return unclaimedobjects >= constants[#"amount"];
}

/*
	Name: strategyhasatleastxunclaimedpriorityassaultobjects
	Namespace: plannercommanderutility
	Checksum: 0x955290E9
	Offset: 0xB0A8
	Size: 0x236
	Parameters: 2
	Flags: Linked
*/
function strategyhasatleastxunclaimedpriorityassaultobjects(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	if(strategyhasatleastxassaultobjects(planner, constants))
	{
		prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
		prioritymap = [];
		foreach(priorityname in prioritynames)
		{
			prioritymap[priorityname] = 1;
		}
		priorityobjects = 0;
		gameobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
		foreach(gameobject in gameobjects)
		{
			if(isdefined(gameobject[#"identifier"]) && isdefined(prioritymap[gameobject[#"identifier"]]) && !gameobject[#"claimed"])
			{
				priorityobjects++;
			}
		}
		return priorityobjects >= constants[#"amount"];
	}
	return 0;
}

/*
	Name: strategyhasatleastxunclaimedprioritydefendobjects
	Namespace: plannercommanderutility
	Checksum: 0x73FE3214
	Offset: 0xB2E8
	Size: 0x236
	Parameters: 2
	Flags: Linked
*/
function strategyhasatleastxunclaimedprioritydefendobjects(planner, constants)
{
	/#
		assert(isint(constants[#"amount"]), ("" + "") + "");
	#/
	if(strategyhasatleastxassaultobjects(planner, constants))
	{
		prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
		prioritymap = [];
		foreach(priorityname in prioritynames)
		{
			prioritymap[priorityname] = 1;
		}
		priorityobjects = 0;
		gameobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
		foreach(gameobject in gameobjects)
		{
			if(isdefined(gameobject[#"identifier"]) && isdefined(prioritymap[gameobject[#"identifier"]]) && !gameobject[#"claimed"])
			{
				priorityobjects++;
			}
		}
		return priorityobjects >= constants[#"amount"];
	}
	return 0;
}

/*
	Name: strategyhasforcegoal
	Namespace: plannercommanderutility
	Checksum: 0x6F80D6EB
	Offset: 0xB528
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function strategyhasforcegoal(planner, constants)
{
	return isdefined(planner::getblackboardattribute(planner, #"force_goal"));
}

/*
	Name: function_f6a3c6d5
	Namespace: plannercommanderutility
	Checksum: 0xC97968DE
	Offset: 0xB568
	Size: 0x1DC
	Parameters: 2
	Flags: Linked
*/
function function_f6a3c6d5(planner, constants)
{
	targets = planner::getblackboardattribute(planner, #"targets");
	/#
		assert(isarray(targets));
	#/
	if(!isarray(targets))
	{
		return 0;
	}
	priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"hash_46658a8270df5a9e");
	/#
		assert(isarray(priorities));
	#/
	foreach(priority in priorities)
	{
		if(targets[priority].size > 0)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: strategypathinghascalculatedpaths
	Namespace: plannercommanderutility
	Checksum: 0xD89C2275
	Offset: 0xB750
	Size: 0x38
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathinghascalculatedpaths(planner, constants)
{
	return planner::getblackboardattribute(planner, #"pathing_calculated_paths").size > 0;
}

/*
	Name: strategypathinghascalculatedpathablepath
	Namespace: plannercommanderutility
	Checksum: 0x59269413
	Offset: 0xB790
	Size: 0xAE
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathinghascalculatedpathablepath(planner, constants)
{
	bots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
	botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
	calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
	return calculatedpaths.size >= bots.size && botindex >= bots.size;
}

/*
	Name: strategypathinghasnorequestpoints
	Namespace: plannercommanderutility
	Checksum: 0xC6DE43D8
	Offset: 0xB848
	Size: 0x38
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathinghasnorequestpoints(planner, constants)
{
	return planner::getblackboardattribute(planner, #"pathing_requested_points").size <= 0;
}

/*
	Name: strategypathinghasrequestpoints
	Namespace: plannercommanderutility
	Checksum: 0x18EE9FED
	Offset: 0xB888
	Size: 0x38
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathinghasrequestpoints(planner, constants)
{
	return planner::getblackboardattribute(planner, #"pathing_requested_points").size > 0;
}

/*
	Name: strategypathinghasunprocessedgameobjects
	Namespace: plannercommanderutility
	Checksum: 0x8A19570
	Offset: 0xB8C8
	Size: 0x72
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathinghasunprocessedgameobjects(planner, constants)
{
	requestedgameobjects = planner::getblackboardattribute(planner, #"pathing_requested_gameobjects");
	gameobjectindex = planner::getblackboardattribute(planner, #"pathing_current_gameobject_index");
	return gameobjectindex < requestedgameobjects.size;
}

/*
	Name: strategypathinghasunprocessedobjectives
	Namespace: plannercommanderutility
	Checksum: 0x291009A6
	Offset: 0xB948
	Size: 0x72
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathinghasunprocessedobjectives(planner, constants)
{
	requestedobjectives = planner::getblackboardattribute(planner, #"pathing_requested_objectives");
	objectiveindex = planner::getblackboardattribute(planner, #"pathing_current_objective_index");
	return objectiveindex < requestedobjectives.size;
}

/*
	Name: strategypathinghasunprocessedrequestpoints
	Namespace: plannercommanderutility
	Checksum: 0xADDB5985
	Offset: 0xB9C8
	Size: 0xD4
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathinghasunprocessedrequestpoints(planner, constants)
{
	requestedpoints = planner::getblackboardattribute(planner, #"pathing_requested_points");
	bots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
	pointindex = planner::getblackboardattribute(planner, #"pathing_current_point_index");
	botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
	return pointindex < requestedpoints.size && botindex < bots.size;
}

/*
	Name: strategypathinghasunreachablepath
	Namespace: plannercommanderutility
	Checksum: 0xE92493A1
	Offset: 0xBAA8
	Size: 0x72
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathinghasunreachablepath(planner, constants)
{
	botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
	calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
	return botindex > calculatedpaths.size;
}

/*
	Name: strategypathingaddassaultgameobjectsparam
	Namespace: plannercommanderutility
	Checksum: 0xBC4B86C9
	Offset: 0xBB28
	Size: 0x72
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingaddassaultgameobjectsparam(planner, constants)
{
	assaultobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
	planner::setblackboardattribute(planner, #"pathing_requested_gameobjects", assaultobjects);
	return spawnstruct();
}

/*
	Name: strategypathingadddefendgameobjectsparam
	Namespace: plannercommanderutility
	Checksum: 0x896D087A
	Offset: 0xBBA8
	Size: 0x72
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingadddefendgameobjectsparam(planner, constants)
{
	defendobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
	planner::setblackboardattribute(planner, #"pathing_requested_gameobjects", defendobjects);
	return spawnstruct();
}

/*
	Name: strategypathingaddobjectivesparam
	Namespace: plannercommanderutility
	Checksum: 0x3293FA65
	Offset: 0xBC28
	Size: 0x72
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingaddobjectivesparam(planner, constants)
{
	objectives = planner::getblackboardattribute(planner, #"objectives");
	planner::setblackboardattribute(planner, #"pathing_requested_objectives", objectives);
	return spawnstruct();
}

/*
	Name: strategypathingaddsquadbotsparam
	Namespace: plannercommanderutility
	Checksum: 0xF2EE7744
	Offset: 0xBCA8
	Size: 0xC2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingaddsquadbotsparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
	planner::setblackboardattribute(planner, #"pathing_requested_bots", doppelbots);
	return spawnstruct();
}

/*
	Name: strategypathingaddsquadescortsparam
	Namespace: plannercommanderutility
	Checksum: 0xA01D8BBA
	Offset: 0xBD78
	Size: 0x19A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingaddsquadescortsparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
	for(index = 0; index < escorts.size; index++)
	{
		player = escorts[index][#"__unsafe__"][#"player"];
		if(!isdefined(escorts[index][#"__unsafe__"]))
		{
			escorts[index][#"__unsafe__"] = array();
		}
		escorts[index][#"__unsafe__"][#"bot"] = player;
	}
	planner::setblackboardattribute(planner, #"pathing_requested_bots", escorts);
	return spawnstruct();
}

/*
	Name: strategypathingaddtosquadcalculatedgameobjectsparam
	Namespace: plannercommanderutility
	Checksum: 0xDE41E2F6
	Offset: 0xBF20
	Size: 0x142
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingaddtosquadcalculatedgameobjectsparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	calculatedgameobjects = planner::getblackboardattribute(planner, #"pathing_calculated_gameobjects");
	gameobjects = planner::getblackboardattribute(planner, "gameobjects", squadindex);
	if(!isdefined(gameobjects))
	{
		gameobjects = array();
	}
	if(isdefined(calculatedgameobjects) && calculatedgameobjects.size > 0)
	{
		gameobjects = arraycombine(gameobjects, calculatedgameobjects, 0, 0);
	}
	planner::setblackboardattribute(planner, "pathable_gameobjects", gameobjects, squadindex);
	return spawnstruct();
}

/*
	Name: strategypathingaddtosquadcalculatedobjectivesparam
	Namespace: plannercommanderutility
	Checksum: 0xDD4B4596
	Offset: 0xC070
	Size: 0x142
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingaddtosquadcalculatedobjectivesparam(planner, constants)
{
	squadindex = planner::getblackboardattribute(planner, #"current_squad");
	/#
		assert(squadindex >= 0, "");
	#/
	calculatedobjectives = planner::getblackboardattribute(planner, #"pathing_calculated_objectives");
	objectives = planner::getblackboardattribute(planner, "objectives", squadindex);
	if(!isdefined(objectives))
	{
		objectives = array();
	}
	if(isdefined(calculatedobjectives) && calculatedobjectives.size > 0)
	{
		objectives = arraycombine(objectives, calculatedobjectives, 0, 0);
	}
	planner::setblackboardattribute(planner, "pathable_objectives", objectives, squadindex);
	return spawnstruct();
}

/*
	Name: strategypathingcalculatepathtorequestedpointsparam
	Namespace: plannercommanderutility
	Checksum: 0xECA1E02C
	Offset: 0xC1C0
	Size: 0x332
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingcalculatepathtorequestedpointsparam(planner, constants)
{
	requestedpoints = planner::getblackboardattribute(planner, #"pathing_requested_points");
	bots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
	pointindex = planner::getblackboardattribute(planner, #"pathing_current_point_index");
	botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
	/#
		assert(bots.size > 0);
	#/
	/#
		assert(requestedpoints.size > 0);
	#/
	/#
		assert(pointindex < requestedpoints.size);
	#/
	/#
		assert(botindex < bots.size);
	#/
	if(bots.size > 0 && requestedpoints.size > 0 && pointindex < requestedpoints.size && botindex < bots.size)
	{
		bot = bots[botindex][#"__unsafe__"][#"bot"];
		goalpoints = array();
		startindex = pointindex;
		for(index = 0; pointindex < requestedpoints.size && index < 16; index++)
		{
			goalpoints[goalpoints.size] = requestedpoints[pointindex];
			pointindex++;
		}
		path = strategiccommandutility::calculatepathtopoints(bot, goalpoints);
		if(isdefined(path))
		{
			calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
			calculatedpaths[calculatedpaths.size] = path;
			planner::setblackboardattribute(planner, #"pathing_calculated_paths", calculatedpaths, undefined, 1);
		}
		if(isdefined(path) || pointindex >= requestedpoints.size)
		{
			pointindex = 0;
			botindex++;
		}
		planner::setblackboardattribute(planner, #"pathing_current_point_index", pointindex);
		planner::setblackboardattribute(planner, #"pathing_current_bot_index", botindex);
	}
	return spawnstruct();
}

/*
	Name: strategypathingcalculategameobjectrequestpointsparam
	Namespace: plannercommanderutility
	Checksum: 0x49CC39A7
	Offset: 0xC500
	Size: 0x1C2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingcalculategameobjectrequestpointsparam(planner, constants)
{
	requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
	requestedgameobjects = planner::getblackboardattribute(planner, #"pathing_requested_gameobjects");
	gameobjectindex = planner::getblackboardattribute(planner, #"pathing_current_gameobject_index");
	if(requestedbots.size <= 0 || requestedgameobjects.size <= 0)
	{
		return spawnstruct();
	}
	requestedbot = requestedbots[0];
	bot = requestedbot[#"__unsafe__"][#"bot"];
	gameobject = requestedgameobjects[gameobjectindex][#"__unsafe__"][#"object"];
	requestedpoints = array();
	if(strategiccommandutility::isvalidbotorplayer(bot) && isdefined(gameobject))
	{
		requestedpoints = strategiccommandutility::querypointsaroundgameobject(bot, gameobject);
	}
	planner::setblackboardattribute(planner, #"pathing_requested_points", requestedpoints);
	return spawnstruct();
}

/*
	Name: strategypathingcalculateobjectiverequestpointsparam
	Namespace: plannercommanderutility
	Checksum: 0x6B4A2B41
	Offset: 0xC6D0
	Size: 0x1C2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingcalculateobjectiverequestpointsparam(planner, constants)
{
	requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
	requestedobjectives = planner::getblackboardattribute(planner, #"pathing_requested_objectives");
	objectiveindex = planner::getblackboardattribute(planner, #"pathing_current_objective_index");
	if(requestedbots.size <= 0 || requestedobjectives.size <= 0)
	{
		return spawnstruct();
	}
	requestedbot = requestedbots[0];
	bot = requestedbot[#"__unsafe__"][#"bot"];
	trigger = requestedobjectives[objectiveindex][#"__unsafe__"][#"trigger"];
	requestedpoints = array();
	if(strategiccommandutility::isvalidbotorplayer(bot) && isdefined(trigger))
	{
		requestedpoints = strategiccommandutility::querypointsinsidetrigger(bot, trigger);
	}
	planner::setblackboardattribute(planner, #"pathing_requested_points", requestedpoints);
	return spawnstruct();
}

/*
	Name: strategypathingcalculateobjectivepathabilityparam
	Namespace: plannercommanderutility
	Checksum: 0x7C849866
	Offset: 0xC8A0
	Size: 0x1F2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingcalculateobjectivepathabilityparam(planner, constants)
{
	requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
	requestedobjectives = planner::getblackboardattribute(planner, #"pathing_requested_objectives");
	objectiveindex = planner::getblackboardattribute(planner, #"pathing_current_objective_index");
	calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
	if(requestedbots.size == calculatedpaths.size)
	{
		longestpath = 0;
		for(index = 0; index < calculatedpaths.size; index++)
		{
			if(calculatedpaths[index].pathdistance > longestpath)
			{
				longestpath = calculatedpaths[index].pathdistance;
			}
		}
		objectiveentry = array();
		objectiveentry[#"distance"] = longestpath;
		objectiveentry[#"objective"] = requestedobjectives[objectiveindex];
		calculatedobjectives = planner::getblackboardattribute(planner, #"pathing_calculated_objectives");
		calculatedobjectives[calculatedobjectives.size] = objectiveentry;
		planner::setblackboardattribute(planner, #"pathing_calculated_objectives", calculatedobjectives);
	}
	return spawnstruct();
}

/*
	Name: strategypathingcalculategameobjectpathabilityparam
	Namespace: plannercommanderutility
	Checksum: 0xFDBE9524
	Offset: 0xCAA0
	Size: 0x1F2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategypathingcalculategameobjectpathabilityparam(planner, constants)
{
	requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
	requestedgameobjects = planner::getblackboardattribute(planner, #"pathing_requested_gameobjects");
	gameobjectindex = planner::getblackboardattribute(planner, #"pathing_current_gameobject_index");
	calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
	if(requestedbots.size == calculatedpaths.size)
	{
		longestpath = 0;
		for(index = 0; index < calculatedpaths.size; index++)
		{
			if(calculatedpaths[index].pathdistance > longestpath)
			{
				longestpath = calculatedpaths[index].pathdistance;
			}
		}
		gameobjectentry = array();
		gameobjectentry[#"distance"] = longestpath;
		gameobjectentry[#"gameobject"] = requestedgameobjects[gameobjectindex];
		calculatedgameobjects = planner::getblackboardattribute(planner, #"pathing_calculated_gameobjects");
		calculatedgameobjects[calculatedgameobjects.size] = gameobjectentry;
		planner::setblackboardattribute(planner, #"pathing_calculated_gameobjects", calculatedgameobjects);
	}
	return spawnstruct();
}

/*
	Name: function_61d2b8ef
	Namespace: plannercommanderutility
	Checksum: 0x6261AAD
	Offset: 0xCCA0
	Size: 0x166
	Parameters: 3
	Flags: Linked, Private
*/
private function function_61d2b8ef(commander, squad, constants)
{
	doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	order = plannersquadutility::getblackboardattribute(squad, "order");
	if(isdefined(doppelbots) && doppelbots.size > 0 && isdefined(order))
	{
		foreach(botentry in doppelbots)
		{
			bot = botentry[#"__unsafe__"][#"bot"];
			if(isdefined(bot) && order == "follow_chain" && bot isinvehicle())
			{
				return 0;
			}
		}
		return 1;
	}
	return 1;
}

/*
	Name: utilityscorebotpresence
	Namespace: plannercommanderutility
	Checksum: 0x91FAD4CC
	Offset: 0xCE10
	Size: 0x116
	Parameters: 3
	Flags: Linked, Private
*/
private function utilityscorebotpresence(commander, squad, constants)
{
	doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	if(isdefined(doppelbots) && doppelbots.size > 0)
	{
		foreach(botentry in doppelbots)
		{
			bot = botentry[#"__unsafe__"][#"bot"];
			if(!strategiccommandutility::isvalidbot(bot))
			{
				return 0;
			}
		}
		return 1;
	}
	return 1;
}

/*
	Name: function_de2b04c0
	Namespace: plannercommanderutility
	Checksum: 0xFDB247BC
	Offset: 0xCF30
	Size: 0x18E
	Parameters: 3
	Flags: Linked, Private
*/
private function function_de2b04c0(commander, squad, constants)
{
	doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	if(isdefined(doppelbots) && doppelbots.size > 0)
	{
		foreach(botentry in doppelbots)
		{
			bot = botentry[#"__unsafe__"][#"bot"];
			if(!isdefined(bot))
			{
				return 0;
			}
			if(bot isinvehicle() && botentry[#"type"] == "bot")
			{
				return 0;
			}
			if(!bot isinvehicle() && botentry[#"type"] != "bot")
			{
				return 0;
			}
			if(!strategiccommandutility::function_4732f860(bot))
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: utilityscoreescortpathing
	Namespace: plannercommanderutility
	Checksum: 0x587C1973
	Offset: 0xD0C8
	Size: 0x1FE
	Parameters: 3
	Flags: Linked, Private
*/
private function utilityscoreescortpathing(commander, squad, constants)
{
	doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	escorts = plannersquadutility::getblackboardattribute(squad, "escorts");
	escortpoi = plannersquadutility::getblackboardattribute(squad, "escort_poi");
	if(!isdefined(doppelbots) || doppelbots.size <= 0)
	{
		return 1;
	}
	if(!isdefined(escorts) || escorts.size <= 0)
	{
		return 1;
	}
	if(!blackboard::getstructblackboardattribute(commander, #"allow_escort"))
	{
		return 0;
	}
	if(_calculateallpathableclients(doppelbots, escorts).size < escorts.size)
	{
		return 0;
	}
	if(isdefined(escortpoi) && escortpoi.size > 0)
	{
		return 0;
	}
	assaultgameobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
	defendgameobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_defend");
	objectives = blackboard::getstructblackboardattribute(commander, #"objectives");
	if(assaultgameobjects.size > 0 || defendgameobjects.size > 0 || objectives.size > 0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: utilityscoreforcegoal
	Namespace: plannercommanderutility
	Checksum: 0x9286FA76
	Offset: 0xD2D0
	Size: 0xAE
	Parameters: 3
	Flags: Linked
*/
function utilityscoreforcegoal(commander, squad, constants)
{
	doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	squadforcegoal = plannersquadutility::getblackboardattribute(squad, "force_goal");
	forcegoal = blackboard::getstructblackboardattribute(commander, #"force_goal");
	if(forcegoal !== squadforcegoal)
	{
		return 0;
	}
	return 1;
}

/*
	Name: utilityscoregameobjectpathing
	Namespace: plannercommanderutility
	Checksum: 0x50BFD1
	Offset: 0xD388
	Size: 0x172
	Parameters: 3
	Flags: Linked, Private
*/
private function utilityscoregameobjectpathing(commander, squad, constants)
{
	doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	if(!isdefined(doppelbots) || doppelbots.size <= 0)
	{
		return 1;
	}
	foreach(botentry in doppelbots)
	{
		bot = botentry[#"__unsafe__"][#"bot"];
		if(!strategiccommandutility::isvalidbot(bot))
		{
			continue;
		}
		if(isalive(bot) && !bot isingoal(bot.origin) && !bot haspath())
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: utilityscoregameobjectpriority
	Namespace: plannercommanderutility
	Checksum: 0x837CA704
	Offset: 0xD508
	Size: 0x42A
	Parameters: 3
	Flags: Linked, Private
*/
private function utilityscoregameobjectpriority(commander, squad, constants)
{
	priorityidentifiers = constants[#"priority"];
	if(!isdefined(priorityidentifiers) || priorityidentifiers.size <= 0)
	{
		return 1;
	}
	squadobjects = plannersquadutility::getblackboardattribute(squad, "gameobjects");
	if(isdefined(squadobjects))
	{
		prioritygameobjects = _calculateprioritygameobjects(squadobjects, priorityidentifiers);
		if(prioritygameobjects.size > 0)
		{
			return 1;
		}
	}
	assaultobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
	defendobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_defend");
	activeidentifiers = [];
	currentsquadassignedpriority = 0;
	if(isarray(assaultobjects))
	{
		prioritygameobjects = _calculateprioritygameobjects(assaultobjects, priorityidentifiers);
		foreach(gameobjectentry in prioritygameobjects)
		{
			activeidentifiers[gameobjectentry[#"identifier"]] = 1;
		}
	}
	if(isarray(defendobjects))
	{
		prioritygameobjects = _calculateprioritygameobjects(defendobjects, priorityidentifiers);
		foreach(gameobjectentry in prioritygameobjects)
		{
			activeidentifiers[gameobjectentry[#"identifier"]] = 1;
		}
	}
	if(activeidentifiers.size > 0)
	{
		foreach(currentsquad in commander.squads)
		{
			if(currentsquad == squad)
			{
				continue;
			}
			squadobjects = plannersquadutility::getblackboardattribute(currentsquad, "gameobjects");
			if(isdefined(squadobjects))
			{
				prioritygameobjects = _calculateprioritygameobjects(squadobjects, priorityidentifiers);
				foreach(gameobjectentry in prioritygameobjects)
				{
					activeidentifiers[gameobjectentry[#"identifier"]] = 0;
				}
			}
		}
	}
	foreach(value in activeidentifiers)
	{
		if(value)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: utilityscoregameobjectsvalidity
	Namespace: plannercommanderutility
	Checksum: 0xE2598487
	Offset: 0xD940
	Size: 0x132
	Parameters: 3
	Flags: Linked, Private
*/
private function utilityscoregameobjectsvalidity(commander, squad, constants)
{
	gameobjects = plannersquadutility::getblackboardattribute(squad, "gameobjects");
	if(!isdefined(gameobjects))
	{
		return 1;
	}
	foreach(gameobjectentry in gameobjects)
	{
		gameobject = gameobjectentry[#"__unsafe__"][#"object"];
		if(!isdefined(gameobject) || (isdefined(gameobject.trigger) && !gameobject.trigger istriggerenabled()))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_2985faa1
	Namespace: plannercommanderutility
	Checksum: 0x7EC81742
	Offset: 0xDA80
	Size: 0x5A
	Parameters: 3
	Flags: Linked, Private
*/
private function function_2985faa1(commander, squad, constants)
{
	target = plannersquadutility::getblackboardattribute(squad, "target");
	if(!isdefined(target))
	{
		return 0;
	}
	return 1;
}

/*
	Name: utilityscoreprogressthrottling
	Namespace: plannercommanderutility
	Checksum: 0x49A1C09
	Offset: 0xDAE8
	Size: 0x242
	Parameters: 3
	Flags: Linked, Private
*/
private function utilityscoreprogressthrottling(commander, squad, constants)
{
	if(blackboard::getstructblackboardattribute(commander, #"allow_progress_throttling") === 1)
	{
		enemycommander = blackboard::getstructblackboardattribute(commander, #"throttling_enemy_commander");
		if(!isdefined(enemycommander))
		{
			return 0;
		}
		lowerbound = blackboard::getstructblackboardattribute(commander, #"throttling_lower_bound");
		upperbound = blackboard::getstructblackboardattribute(commander, #"throttling_upper_bound");
		destroyedassaults = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault_destroyed");
		totalassaults = blackboard::getstructblackboardattribute(commander, #"throttling_total_gameobjects");
		if(!isdefined(totalassaults))
		{
			totalassaults = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault_total");
		}
		enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_destroyed");
		enemytotalassaults = blackboard::getstructblackboardattribute(commander, #"throttling_total_gameobjects_enemy");
		if(!isdefined(enemytotalassaults))
		{
			enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_total");
		}
		order = plannersquadutility::getblackboardattribute(squad, "order");
		if(strategiccommandutility::calculateprogressthrottling(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults))
		{
			if(order === "order_attack")
			{
				return 0;
			}
		}
		else if(order === "order_attack_surround")
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_a65b2be5
	Namespace: plannercommanderutility
	Checksum: 0x1E110715
	Offset: 0xDD38
	Size: 0x21A
	Parameters: 3
	Flags: Linked, Private
*/
private function function_a65b2be5(commander, squad, constants)
{
	var_fcee18d7 = plannersquadutility::getblackboardattribute(squad, "target");
	if(!isdefined(var_fcee18d7))
	{
		return 1;
	}
	if(var_fcee18d7[#"type"] === "gameobject")
	{
		gameobject = var_fcee18d7[#"__unsafe__"][#"object"];
		if(!isdefined(gameobject) || (isdefined(gameobject.trigger) && !gameobject.trigger istriggerenabled()))
		{
			return 0;
		}
	}
	else if(var_fcee18d7[#"type"] === "destroy" || var_fcee18d7[#"type"] === "defend")
	{
		return 0;
	}
	if(var_fcee18d7[#"type"] === "capturearea")
	{
		return 0;
	}
	if(var_fcee18d7[#"type"] === "destroy" || var_fcee18d7[#"type"] === "goto")
	{
		var_5fbc7570 = var_fcee18d7[#"__unsafe__"][#"hash_57b897c5ec9b1b71"];
		commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
		if(!strategiccommandutility::function_f867cce0(var_5fbc7570, commanderteam))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_f389ef61
	Namespace: plannercommanderutility
	Checksum: 0x8D88A504
	Offset: 0xDF60
	Size: 0x10E
	Parameters: 3
	Flags: Linked, Private
*/
private function function_f389ef61(commander, squad, constants)
{
	doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	team = blackboard::getstructblackboardattribute(commander, #"team");
	if(!isdefined(doppelbots) || !isdefined(team))
	{
		return 1;
	}
	for(botindex = 0; botindex < doppelbots.size; botindex++)
	{
		bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
		if(isdefined(bot) && bot.team != team)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: utilityscoreviableescort
	Namespace: plannercommanderutility
	Checksum: 0x98D0DDD
	Offset: 0xE078
	Size: 0x12E
	Parameters: 3
	Flags: Linked, Private
*/
private function utilityscoreviableescort(commander, squad, constants)
{
	doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	escorts = plannersquadutility::getblackboardattribute(squad, "escorts");
	players = blackboard::getstructblackboardattribute(commander, #"players");
	if(isdefined(escorts) && escorts.size > 0)
	{
		return 1;
	}
	if(!isdefined(doppelbots) || doppelbots.size <= 0)
	{
		return 1;
	}
	if(!isdefined(players) || players.size <= 0)
	{
		return 1;
	}
	if(_calculateallpathableclients(doppelbots, players).size > 0)
	{
		return 0;
	}
	return 1;
}

