// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_31e56101095f174b;
#using script_366ff0bb9cb7adb1;
#using script_aa63c66acbb23e;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace planner_squad_utility;

/*
	Name: function_89f2df9
	Namespace: planner_squad_utility
	Checksum: 0xC5DDB00B
	Offset: 0x1D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"planner_squad_utility", &plannersquadutility::__init__, undefined, undefined);
}

#namespace plannersquadutility;

/*
	Name: __init__
	Namespace: plannersquadutility
	Checksum: 0x3BDC29A4
	Offset: 0x218
	Size: 0x82C
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	plannerutility::registerplannerapi(#"hash_5414bc90f9b0a9a4", &function_790fb743);
	plannerutility::registerplannerapi(#"hash_4a94655debb4ee2f", &function_f6ec02a4);
	plannerutility::registerplannerapi(#"squadhasattackobject", &strategyhasattackobject);
	plannerutility::registerplannerapi(#"squadhasbelowxammo", &strategyhasbelowxammounsafe);
	plannerutility::registerplannerapi(#"squadhasblackboardvalue", &strategyhasblackboardvalue);
	plannerutility::registerplannerapi(#"squadhasdefendobject", &strategyhasdefendobject);
	plannerutility::registerplannerapi(#"squadhasescort", &strategyhasescort);
	plannerutility::registerplannerapi(#"squadhasescortpoi", &strategyhasescortpoi);
	plannerutility::registerplannerapi(#"squadhasforcegoal", &strategyhasforcegoal);
	plannerutility::registerplannerapi(#"squadhasobjective", &strategyhasobjective);
	plannerutility::registerplannerapi(#"hash_3e9c87665dfef699", &function_b384b9b6);
	plannerutility::registerplannerapi(#"hash_5dfbc649e2cdd6aa", &function_2083115a);
	plannerutility::registerplannerapi(#"squadhaspathableammocache", &strategyhaspathableammocache);
	plannerutility::registerplannerapi(#"hash_2b8bf371fba6de6a", &function_a0f209b7);
	plannerutility::registerplannerapi(#"hash_3ed9287b5cc1ec2c", &function_e96dd96b);
	plannerutility::registerplannerapi(#"hash_5678bc75fd7c0675", &function_50c7bd5a);
	plannerutility::registerplanneraction(#"hash_186a23f9ca83351f", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatoattackobjectupdate, undefined);
	plannerutility::registerplanneraction(#"squadclearareatoattackobject", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatoattackobjectupdate, undefined);
	plannerutility::registerplanneraction(#"hash_553b7b133c2aee64", &strategyclearareatogoldenpathparam, &strategyclearareatogoldenpathinit, &function_903aeb1c, undefined);
	plannerutility::registerplanneraction(#"squadclearareatodefendobject", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatodefendobjectupdate, undefined);
	plannerutility::registerplanneraction(#"squadclearareatoescort", &strategyclearareatoescortparam, &strategyclearareatoescortinit, &strategyclearareatoescortupdate, undefined);
	plannerutility::registerplanneraction(#"squadclearareatogoldenpath", &strategyclearareatogoldenpathparam, &strategyclearareatogoldenpathinit, &strategyclearareatogoldenpathupdate, undefined);
	plannerutility::registerplanneraction(#"squadclearareatoobjective", &strategyclearareaobjectiveparam, &strategyclearareatoobjectiveinit, &strategyclearareatoobjectiveupdate, undefined);
	plannerutility::registerplanneraction(#"hash_12d15145a12cf7ed", &strategybotobjectparam, &function_b3ede444, &function_942e45dc, undefined);
	plannerutility::registerplanneraction(#"hash_23810516f86c60f", &strategybotparam, &function_6ed940fb, &function_4c91e90d, undefined);
	plannerutility::registerplanneraction(#"squadrushattackobject", &strategybotobjectparam, &strategyrushattackobjectinit, &strategyrushattackobjectupdate, undefined);
	plannerutility::registerplanneraction(#"squadrushcloserthanxammocache", &strategyrushammocacheparam, &strategyrushammocacheinit, &strategyrushammocacheupdate, undefined);
	plannerutility::registerplanneraction(#"squadrushdefendobject", &strategybotobjectparam, &strategyrushdefendobjectinit, &strategyrushdefendobjectupdate, undefined);
	plannerutility::registerplanneraction(#"hash_7c1f27a774d46b97", &strategyclearareatoescortparam, &function_5ac5aed, &function_a856fc9d, undefined);
	plannerutility::registerplanneraction(#"squadrushforcegoal", &strategybotgoalparam, &strategyrushforcegoalinit, &strategyrushforcegoalupdate, undefined);
	plannerutility::registerplanneraction(#"squadrushobjective", &strategyrushobjectiveparam, &strategyrushobjectiveinit, &strategyrushobjectiveupdate, undefined);
	plannerutility::registerplanneraction(#"squadwander", &strategybotparam, &strategywanderinit, &strategywanderupdate, undefined);
	plannerutility::registerplanneraction(#"squadendplan", undefined, undefined, undefined, undefined);
}

/*
	Name: _assigngameobject
	Namespace: plannersquadutility
	Checksum: 0xDD8CF27
	Offset: 0xA50
	Size: 0x1CC
	Parameters: 2
	Flags: Linked, Private
*/
private function _assigngameobject(bot, gameobject)
{
	if(isdefined(bot) && isalive(bot) && isdefined(gameobject) && bot bot::function_343d7ef4())
	{
		bot.goalradius = 512;
		if(isdefined(gameobject.e_object) && isvehicle(gameobject.e_object))
		{
			bot setgoal(gameobject.e_object);
		}
		else if(isdefined(gameobject.trigger))
		{
			_setgoalpoint(bot, gameobject.trigger.origin);
		}
		else
		{
			_setgoalpoint(bot, gameobject.origin);
		}
		if(gameobject.type == "use" || gameobject.type == "useObject" || gameobject.type == "carryObject")
		{
			if(!isdefined(bot.owner) || isbot(bot.owner) || !strategiccommandutility::isvalidplayer(bot.owner))
			{
				bot bot::function_7a6eea9c(gameobject);
			}
		}
	}
}

/*
	Name: _cleargameobject
	Namespace: plannersquadutility
	Checksum: 0x76FC58AC
	Offset: 0xC28
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
private function _cleargameobject(bot)
{
	if(strategiccommandutility::isvalidbot(bot))
	{
		if(!isdefined(bot.owner) || isbot(bot.owner))
		{
			bot bot::function_6c280dfe();
		}
	}
}

/*
	Name: _calculateadjustedpathsegments
	Namespace: plannersquadutility
	Checksum: 0x8F0790E7
	Offset: 0xCA0
	Size: 0x376
	Parameters: 1
	Flags: Linked, Private
*/
private function _calculateadjustedpathsegments(params)
{
	params.adjustedpath = [];
	params.adjustedpathsegment = 0;
	if(isdefined(params.path) && isdefined(params.path.pathpoints) && params.path.pathpoints.size > 0)
	{
		adjustedpath = [];
		radius = function_48bd5e74(params.bots);
		segmentlength = radius * 1.5;
		pathpointssize = params.path.pathpoints.size;
		currentdistance = 0;
		currentpoint = params.path.pathpoints[0];
		adjustedpath[adjustedpath.size] = currentpoint;
		for(index = 1; index < pathpointssize; index++)
		{
			nextpoint = params.path.pathpoints[index];
			distancetonextpoint = distance2d(currentpoint, nextpoint);
			totaldistance = currentdistance + distancetonextpoint;
			if(totaldistance < segmentlength)
			{
				currentdistance = currentdistance + distancetonextpoint;
				currentpoint = nextpoint;
				continue;
				continue;
			}
			if(totaldistance >= segmentlength)
			{
				distancetonextadjusted = segmentlength - currentdistance;
				ratiotonextadjusted = distancetonextadjusted / distancetonextpoint;
				currentpoint = lerpvector(currentpoint, nextpoint, ratiotonextadjusted);
				adjustedpath[adjustedpath.size] = currentpoint;
				currentdistance = 0;
				index--;
			}
		}
		adjustedpath[adjustedpath.size] = params.path.pathpoints[pathpointssize - 1];
		params.adjustedpath = adjustedpath;
		params.fallback = params.adjustedpath[0];
		if(params.adjustedpath.size >= 2)
		{
			direction = params.adjustedpath[1] - params.adjustedpath[0];
			direction = vectornormalize(direction);
			fallback = params.adjustedpath[0] - (direction * 256);
			fallback = getclosestpointonnavmesh(fallback, 256);
			if(isdefined(fallback))
			{
				if(tracepassedonnavmesh(params.adjustedpath[0], fallback))
				{
					params.fallback = fallback;
				}
			}
		}
	}
}

/*
	Name: function_48bd5e74
	Namespace: plannersquadutility
	Checksum: 0x6470693F
	Offset: 0x1020
	Size: 0x98
	Parameters: 1
	Flags: Linked, Private
*/
private function function_48bd5e74(bots)
{
	foreach(bot in bots)
	{
		if(isdefined(bot) && bot isinvehicle())
		{
			return 640;
		}
	}
	return 256;
}

/*
	Name: function_66f80bb1
	Namespace: plannersquadutility
	Checksum: 0x2FD7BB67
	Offset: 0x10C0
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_66f80bb1(bots)
{
	foreach(bot in bots)
	{
		if(isdefined(bot) && bot isinvehicle())
		{
			return (256 / 2) * 2.5;
		}
	}
	return 256 / 2;
}

/*
	Name: function_e1b14108
	Namespace: plannersquadutility
	Checksum: 0x51642834
	Offset: 0x1178
	Size: 0xB0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e1b14108(bots)
{
	foreach(bot in bots)
	{
		if(isdefined(bot) && bot isinvehicle())
		{
			return (256 * 1.5) * 2.5;
		}
	}
	return 256 * 1.5;
}

/*
	Name: function_8ff43349
	Namespace: plannersquadutility
	Checksum: 0x62ED5118
	Offset: 0x1230
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8ff43349(bots)
{
	foreach(bot in bots)
	{
		if(isdefined(bot) && bot isinvehicle())
		{
			return ((256 / 2) * 6) * 2.5;
		}
	}
	return (256 / 2) * 6;
}

/*
	Name: _debugadjustedpath
	Namespace: plannersquadutility
	Checksum: 0xBCD1D2F0
	Offset: 0x12F8
	Size: 0x39C
	Parameters: 1
	Flags: Private
*/
private function _debugadjustedpath(params)
{
	if(getdvarint(#"ai_debugsquadareas", 0))
	{
		bot = undefined;
		foreach(bot in params.bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				break;
			}
		}
		innerradius = function_66f80bb1(params.bots);
		outerradius = function_8ff43349(params.bots);
		for(index = 1; index < params.adjustedpath.size; index++)
		{
			start = params.adjustedpath[index - 1];
			end = params.adjustedpath[index];
			center = start + ((end - start) * 0.5);
			/#
				recordline(start, end, (1, 0.5, 0), "");
				recordcircle(center, function_48bd5e74(params.bots), (1, 0, 0), "");
			#/
			if(isdefined(bot))
			{
				offset = 10;
				pointdanger = _evaluatepointdanger(bot, center, innerradius, outerradius);
				/#
					record3dtext("" + pointdanger.inner, center, (1, 0, 0), "");
					record3dtext("" + pointdanger.outer, center + (0, 0, offset), (1, 0.5, 0), "");
				#/
			}
		}
		currentpathsegment = params.adjustedpathsegment;
		if(isdefined(currentpathsegment) && isarray(params.adjustedpath) && currentpathsegment < (params.adjustedpath.size - 2))
		{
			currentcenter = (params.adjustedpath[currentpathsegment] + (params.adjustedpath[currentpathsegment + 1])) / 2;
			/#
				recordsphere(currentcenter, 10, (0, 1, 0));
			#/
		}
	}
}

/*
	Name: _evaluateadjustedpath
	Namespace: plannersquadutility
	Checksum: 0xC957B135
	Offset: 0x16A0
	Size: 0x624
	Parameters: 1
	Flags: Linked, Private
*/
private function _evaluateadjustedpath(params)
{
	if(params.adjustedpath.size <= 0)
	{
		return;
	}
	bot = undefined;
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			break;
		}
	}
	currentpathsegment = params.adjustedpathsegment;
	innerradius = function_66f80bb1(params.bots);
	outerradius = function_8ff43349(params.bots);
	if(currentpathsegment > 0)
	{
		previouscenter = ((params.adjustedpath[currentpathsegment - 1]) + params.adjustedpath[currentpathsegment]) / 2;
		previouspointdanger = _evaluatepointdanger(bot, previouscenter, innerradius, outerradius);
	}
	currentcenter = (params.adjustedpath[currentpathsegment] + (params.adjustedpath[currentpathsegment + 1])) / 2;
	currentpointdanger = _evaluatepointdanger(bot, currentcenter, innerradius, outerradius);
	if(currentpathsegment < params.adjustedpath.size - 2)
	{
		nextcenter = (params.adjustedpath[currentpathsegment + 1]) + (params.adjustedpath[currentpathsegment + 2]) / 2;
		nextpointdanger = _evaluatepointdanger(bot, nextcenter, innerradius, outerradius);
	}
	injured = 0;
	foreach(bot in params.bots)
	{
		if(_isinjured(bot))
		{
			injured = 1;
			break;
		}
	}
	reachedcurrent = 0;
	var_4fbb80f1 = function_e1b14108(params.bots);
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			if(distance2dsquared(bot.origin, currentcenter) <= (var_4fbb80f1 * var_4fbb80f1))
			{
				reachedcurrent = 1;
				break;
			}
		}
	}
	if(reachedcurrent)
	{
		if(injured)
		{
			if(isdefined(previouspointdanger) && previouspointdanger.inner < currentpointdanger.inner && previouspointdanger.outer > 15)
			{
				params.adjustedpathsegment--;
			}
		}
		else if(currentpointdanger.outer <= 50 && currentpointdanger.inner <= 15)
		{
			if(isdefined(nextpointdanger) && nextpointdanger.inner <= 15)
			{
				params.adjustedpathsegment++;
			}
		}
		if(currentpathsegment == params.adjustedpathsegment)
		{
			foreach(bot in params.bots)
			{
				if(strategiccommandutility::isvalidbot(bot) && isalive(bot) && !bot haspath() && (!isdefined(bot.enemy) || !bot cansee(bot.enemy)))
				{
					params.adjustedpathsegment++;
					break;
				}
			}
		}
		if(currentpathsegment == params.adjustedpathsegment)
		{
			if(currentpointdanger.inner > 15)
			{
				if(isdefined(previouspointdanger) && previouspointdanger.inner < currentpointdanger.inner && previouspointdanger.outer > 15)
				{
					params.adjustedpathsegment--;
				}
			}
		}
	}
}

/*
	Name: _evaluatepointdanger
	Namespace: plannersquadutility
	Checksum: 0x4A29D4B0
	Offset: 0x1CD0
	Size: 0xA2
	Parameters: 4
	Flags: Linked, Private
*/
private function _evaluatepointdanger(bot, center, inner, outer)
{
	pointdanger = spawnstruct();
	pointdanger.inner = tacticalinfluencergetthreatscore(center, inner, bot.team);
	pointdanger.outer = tacticalinfluencergetthreatscore(center, outer, bot.team);
	return pointdanger;
}

/*
	Name: _isinjured
	Namespace: plannersquadutility
	Checksum: 0xC806996B
	Offset: 0x1D80
	Size: 0xB6
	Parameters: 1
	Flags: Linked, Private
*/
private function _isinjured(bot)
{
	if(strategiccommandutility::isvalidbot(bot) && isdefined(bot.health) && isdefined(bot.maxhealth))
	{
		tacstate = bot bot::function_d473f7de();
		if(isdefined(tacstate))
		{
			return (bot.health / bot.maxhealth) <= (isdefined(tacstate.var_ac1c818f) ? tacstate.var_ac1c818f : 0);
		}
	}
	return 0;
}

/*
	Name: _paramshasbots
	Namespace: plannersquadutility
	Checksum: 0x50C203FE
	Offset: 0x1E40
	Size: 0x92
	Parameters: 1
	Flags: Linked, Private
*/
private function _paramshasbots(params)
{
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: _setgoalpoint
	Namespace: plannersquadutility
	Checksum: 0x658DACAF
	Offset: 0x1EE0
	Size: 0x17E
	Parameters: 3
	Flags: Linked, Private
*/
private function _setgoalpoint(bot, point, likelyenemyposition)
{
	if(isdefined(bot) && isalive(bot) && isvec(point) && bot bot::function_343d7ef4())
	{
		if(bot isinvehicle())
		{
			vehicle = bot getvehicleoccupied();
			var_538f88eb = vehicle getoccupantseat(bot);
			if(var_538f88eb == 0)
			{
				vehicle setgoal(point);
			}
		}
		else
		{
			navmeshpoint = getclosestpointonnavmesh(point, 200);
			if(!isdefined(navmeshpoint))
			{
				navmeshpoint = point;
			}
			bot setgoal(navmeshpoint);
			if(isdefined(likelyenemyposition) && isvec(likelyenemyposition))
			{
				bot.var_2925fedc = likelyenemyposition;
			}
			else
			{
				bot.var_2925fedc = undefined;
			}
		}
	}
}

/*
	Name: function_a1574a8d
	Namespace: plannersquadutility
	Checksum: 0xF6A0898F
	Offset: 0x2068
	Size: 0xF6
	Parameters: 3
	Flags: Linked, Private
*/
private function function_a1574a8d(bot, trigger, likelyenemyposition)
{
	if(isdefined(bot) && isdefined(trigger) && bot bot::function_343d7ef4())
	{
		if(bot isinvehicle())
		{
			vehicle = bot getvehicleoccupied();
			vehicle setgoal(trigger);
		}
		else
		{
			bot setgoal(trigger);
			if(isdefined(likelyenemyposition) && isvec(likelyenemyposition))
			{
				bot.var_2925fedc = likelyenemyposition;
			}
			else
			{
				bot.var_2925fedc = undefined;
			}
		}
	}
}

/*
	Name: function_d065f4fd
	Namespace: plannersquadutility
	Checksum: 0x7B2B75AA
	Offset: 0x2168
	Size: 0x6E
	Parameters: 3
	Flags: Linked, Private
*/
private function function_d065f4fd(adjustedpath, currentpathsegment, var_769cf7b7)
{
	for(i = var_769cf7b7; i >= 0; i--)
	{
		lookaheadpoint = adjustedpath[currentpathsegment + var_769cf7b7];
		if(isdefined(lookaheadpoint))
		{
			return lookaheadpoint;
		}
	}
	return undefined;
}

/*
	Name: strategybotgoalparam
	Namespace: plannersquadutility
	Checksum: 0xD5280C1F
	Offset: 0x21E0
	Size: 0x11A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategybotgoalparam(planner, constants)
{
	params = spawnstruct();
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.goal = planner::getblackboardattribute(planner, "force_goal");
	return params;
}

/*
	Name: strategybotobjectparam
	Namespace: plannersquadutility
	Checksum: 0x65A49234
	Offset: 0x2308
	Size: 0x454
	Parameters: 2
	Flags: Linked, Private
*/
private function strategybotobjectparam(planner, constants)
{
	params = spawnstruct();
	objects = planner::getblackboardattribute(planner, "gameobjects");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.order = planner::getblackboardattribute(planner, "order");
	if(isdefined(objects) && isarray(objects))
	{
		params.object = objects[0][#"__unsafe__"][#"object"];
	}
	target = planner::getblackboardattribute(planner, "target");
	if(isdefined(target))
	{
		params.bundle = target[#"__unsafe__"][#"bundle"];
		params.component = target[#"__unsafe__"][#"component"];
		params.object = target[#"__unsafe__"][#"object"];
	}
	if(isdefined(params.object))
	{
		foreach(bot in bots)
		{
			params.path = strategiccommandutility::calculatepathtogameobject(bot, params.object);
			if(isdefined(params.path))
			{
				break;
			}
		}
	}
	if(isdefined(params.component))
	{
		foreach(bot in bots)
		{
			params.path = strategiccommandutility::function_704d5fbd(bot, params.component);
			if(isdefined(params.path))
			{
				break;
			}
		}
	}
	if(isdefined(params.bundle))
	{
		foreach(bot in bots)
		{
			params.path = strategiccommandutility::function_2cce6a82(bot, params.bundle);
			if(isdefined(params.path))
			{
				break;
			}
		}
	}
	return params;
}

/*
	Name: strategybotparam
	Namespace: plannersquadutility
	Checksum: 0x34AC27ED
	Offset: 0x2768
	Size: 0xF6
	Parameters: 2
	Flags: Linked
*/
function strategybotparam(planner, constants)
{
	params = spawnstruct();
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	return params;
}

/*
	Name: strategyclearareaobjectiveparam
	Namespace: plannersquadutility
	Checksum: 0xE46D4565
	Offset: 0x2868
	Size: 0x46
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareaobjectiveparam(planner, constants)
{
	params = strategyrushobjectiveparam(planner, constants);
	params.adjustedpath = [];
	return params;
}

/*
	Name: strategyclearareaobjectparam
	Namespace: plannersquadutility
	Checksum: 0x1F093CC
	Offset: 0x28B8
	Size: 0x46
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareaobjectparam(planner, constants)
{
	params = strategybotobjectparam(planner, constants);
	params.adjustedpath = [];
	return params;
}

/*
	Name: strategyclearareatoescortinit
	Namespace: plannersquadutility
	Checksum: 0x59E92A14
	Offset: 0x2908
	Size: 0x64
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatoescortinit(planner, params)
{
	_calculateadjustedpathsegments(params);
	if(!isdefined(params.escort) || !_paramshasbots(params))
	{
		return 2;
	}
	return 1;
}

/*
	Name: strategyclearareatoescortparam
	Namespace: plannersquadutility
	Checksum: 0xA114A441
	Offset: 0x2978
	Size: 0x46
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatoescortparam(planner, constants)
{
	params = strategyrushescortparam(planner, constants);
	params.adjustedpath = [];
	return params;
}

/*
	Name: strategyclearareatogoldenpathinit
	Namespace: plannersquadutility
	Checksum: 0x42CBDC1D
	Offset: 0x29C8
	Size: 0x7A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatogoldenpathinit(planner, params)
{
	_calculateadjustedpathsegments(params);
	if(!_paramshasbots(params))
	{
		if(!isdefined(params.goldengameobject) && !isdefined(params.goldenobjective))
		{
			return 2;
		}
	}
	return 1;
}

/*
	Name: strategyclearareatogoldenpathparam
	Namespace: plannersquadutility
	Checksum: 0x489DDE45
	Offset: 0x2A50
	Size: 0x456
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatogoldenpathparam(planner, constants)
{
	params = spawnstruct();
	target = planner::getblackboardattribute(planner, "target");
	escortpoi = planner::getblackboardattribute(planner, "escort_poi");
	escorts = planner::getblackboardattribute(planner, "escorts");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.escort = escorts[0][#"__unsafe__"][constants[#"hash_2d0d1f930e0b821c"]];
	if(isdefined(target))
	{
		params.var_263ac6c8 = target[#"__unsafe__"][#"bundle"];
		params.var_d7403996 = target[#"__unsafe__"][#"component"];
		params.goldengameobject = target;
	}
	if(isdefined(escortpoi))
	{
		params.goldenpathdistance = escortpoi[0][#"distance"];
		params.goldengameobject = escortpoi[0][#"gameobject"];
		params.goldenobjective = escortpoi[0][#"objective"];
	}
	if(isdefined(params.var_263ac6c8))
	{
		if(isdefined(params.escort))
		{
			params.path = strategiccommandutility::function_2cce6a82(params.escort, params.var_263ac6c8);
		}
	}
	if(isdefined(params.var_d7403996))
	{
		if(isdefined(params.escort))
		{
			params.path = strategiccommandutility::function_704d5fbd(params.escort, params.var_d7403996);
		}
	}
	if(isdefined(params.goldengameobject))
	{
		gameobject = params.goldengameobject[#"__unsafe__"][#"object"];
		if(isdefined(params.escort) && isdefined(gameobject))
		{
			params.path = strategiccommandutility::calculatepathtogameobject(params.escort, gameobject);
		}
	}
	if(isdefined(params.goldenobjective))
	{
		trigger = params.goldenobjective[#"__unsafe__"][#"trigger"];
		if(isdefined(params.escort) && isdefined(trigger))
		{
			params.path = strategiccommandutility::calculatepathtoobjective(params.escort, trigger);
		}
	}
	params.adjustedpath = [];
	return params;
}

/*
	Name: function_903aeb1c
	Namespace: plannersquadutility
	Checksum: 0x7BC5CF9F
	Offset: 0x2EB0
	Size: 0x16E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_903aeb1c(planner, params)
{
	/#
		_debugadjustedpath(params);
	#/
	if(!isdefined(params.escort) || !_paramshasbots(params))
	{
		return 2;
	}
	escort = params.escort;
	if(!isdefined(escort))
	{
		return 2;
	}
	if(!isdefined(params.fallback))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_setgoalpoint(bot, params.fallback, function_d065f4fd(params.adjustedpath, 0, 3));
			bot.goalradius = 256;
		}
	}
}

/*
	Name: strategyclearareatogoldenpathupdate
	Namespace: plannersquadutility
	Checksum: 0xBF1A055B
	Offset: 0x3028
	Size: 0x282
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatogoldenpathupdate(planner, params)
{
	/#
		_debugadjustedpath(params);
	#/
	if(!isdefined(params.escort) || !_paramshasbots(params))
	{
		return 2;
	}
	if(params.adjustedpath.size <= 0)
	{
		return 2;
	}
	escort = params.escort;
	currentpathsegment = 0;
	currentcenter = undefined;
	if(params.adjustedpath.size > 1)
	{
		params.adjustedpathsegment = 1;
		params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
		currentpathsegment = params.adjustedpathsegment;
		currentcenter = (params.adjustedpath[currentpathsegment] + (params.adjustedpath[currentpathsegment + 1])) / 2;
	}
	var_ba6c6b41 = function_48bd5e74(params.bots);
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_cleargameobject(bot);
			_setgoalpoint(bot, currentcenter, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
			bot.goalradius = var_ba6c6b41;
		}
	}
	return 3;
}

/*
	Name: strategyclearareatoobjectinit
	Namespace: plannersquadutility
	Checksum: 0x27F25ACB
	Offset: 0x32B8
	Size: 0x90
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatoobjectinit(planner, params)
{
	_calculateadjustedpathsegments(params);
	if(!isdefined(params.object) && !isdefined(params.component) && !isdefined(params.bundle))
	{
		return 2;
	}
	if(!_paramshasbots(params))
	{
		return 2;
	}
	return 1;
}

/*
	Name: strategyclearareatoobjectiveinit
	Namespace: plannersquadutility
	Checksum: 0xA6D74B40
	Offset: 0x3350
	Size: 0x64
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatoobjectiveinit(planner, params)
{
	_calculateadjustedpathsegments(params);
	if(!isdefined(params.objective) || !_paramshasbots(params))
	{
		return 2;
	}
	return 1;
}

/*
	Name: strategyclearareatoattackobjectupdate
	Namespace: plannersquadutility
	Checksum: 0x2F96666D
	Offset: 0x33C0
	Size: 0x69A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatoattackobjectupdate(planner, params)
{
	/#
		_debugadjustedpath(params);
	#/
	if(!isdefined(params.object) && !isdefined(params.component) && !isdefined(params.bundle))
	{
		return 2;
	}
	if(!_paramshasbots(params))
	{
		return 2;
	}
	entity = undefined;
	trigger = undefined;
	if(isdefined(params.object))
	{
		trigger = params.object.trigger;
	}
	else if(isdefined(params.component))
	{
		foreach(bot in params.bots)
		{
			if(!isdefined(bot))
			{
				continue;
			}
			trigger = strategiccommandutility::function_5c2c9542(bot, params.component);
		}
	}
	else if(isdefined(params.bundle))
	{
		switch(params.bundle.m_str_type)
		{
			case "escortbiped":
			{
				entity = params.bundle.var_27726d51;
			}
		}
	}
	if(!isdefined(trigger) && !isdefined(entity))
	{
		return 2;
	}
	currentpathsegment = 0;
	currentcenter = undefined;
	if(params.adjustedpath.size > 1)
	{
		_evaluateadjustedpath(params);
		params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
		currentpathsegment = params.adjustedpathsegment;
		currentcenter = (params.adjustedpath[currentpathsegment] + (params.adjustedpath[currentpathsegment + 1])) / 2;
	}
	var_ba6c6b41 = function_48bd5e74(params.bots);
	foreach(bot in params.bots)
	{
		if(!strategiccommandutility::isvalidbot(bot))
		{
			continue;
		}
		if(currentpathsegment >= (params.adjustedpath.size - 2))
		{
			if(!isdefined(params.order) || params.order == "order_attack")
			{
				if(isdefined(params.object) && params.object.triggertype == "use")
				{
					_assigngameobject(bot, params.object);
				}
				else if(isdefined(trigger))
				{
					function_a1574a8d(bot, trigger, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
				}
				else
				{
					_setgoalpoint(bot, entity.origin, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
				}
			}
			else if(isdefined(params.object))
			{
				_setgoalpoint(bot, params.object.origin, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
			}
			else if(isdefined(trigger))
			{
				_setgoalpoint(bot, trigger.origin, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
			}
			else
			{
				_setgoalpoint(bot, entity.origin, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
			}
			bot.goalradius = 512;
			continue;
		}
		_cleargameobject(bot);
		bot.goalradius = var_ba6c6b41;
		_setgoalpoint(bot, currentcenter, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
	}
	if(isdefined(params.object) && params.object.trigger istriggerenabled())
	{
		return 3;
	}
	if(isdefined(params.component))
	{
		return 3;
	}
	if(isdefined(params.bundle))
	{
		return 3;
	}
	return 1;
}

/*
	Name: strategyclearareatodefendobjectupdate
	Namespace: plannersquadutility
	Checksum: 0xC7609DF3
	Offset: 0x3A68
	Size: 0x2D0
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatodefendobjectupdate(planner, params)
{
	/#
		_debugadjustedpath(params);
	#/
	if(!isdefined(params.object) || !isdefined(params.object.trigger) || !_paramshasbots(params))
	{
		return 2;
	}
	currentpathsegment = 0;
	currentcenter = undefined;
	if(params.adjustedpath.size > 1)
	{
		_evaluateadjustedpath(params);
		params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
		currentpathsegment = params.adjustedpathsegment;
		currentcenter = (params.adjustedpath[currentpathsegment] + (params.adjustedpath[currentpathsegment + 1])) / 2;
	}
	var_ba6c6b41 = function_48bd5e74(params.bots);
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_cleargameobject(bot);
			if(currentpathsegment >= (params.adjustedpath.size - 2))
			{
				_setgoalpoint(bot, params.object.origin);
				bot.goalradius = 512;
				continue;
			}
			_setgoalpoint(bot, currentcenter);
			bot.goalradius = var_ba6c6b41;
		}
	}
	if(params.object.trigger istriggerenabled())
	{
		return 3;
	}
	return 1;
}

/*
	Name: strategyclearareatoescortupdate
	Namespace: plannersquadutility
	Checksum: 0xA7B30422
	Offset: 0x3D40
	Size: 0x2C2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatoescortupdate(planner, params)
{
	/#
		_debugadjustedpath(params);
	#/
	if(!isdefined(params.escort) || !_paramshasbots(params))
	{
		return 2;
	}
	escort = params.escort;
	if(!isdefined(escort))
	{
		return 2;
	}
	currentpathsegment = 0;
	currentcenter = undefined;
	if(params.adjustedpath.size > 1)
	{
		_evaluateadjustedpath(params);
		params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
		currentpathsegment = params.adjustedpathsegment;
		currentcenter = (params.adjustedpath[currentpathsegment] + (params.adjustedpath[currentpathsegment + 1])) / 2;
	}
	var_ba6c6b41 = function_48bd5e74(params.bots);
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_cleargameobject(bot);
			if(currentpathsegment >= (params.adjustedpath.size - 2))
			{
				if(!bot isingoal(escort.origin))
				{
					_setgoalpoint(bot, escort.origin);
					bot.goalradius = 512;
				}
				continue;
			}
			_setgoalpoint(bot, currentcenter);
			bot.goalradius = var_ba6c6b41;
		}
	}
	return 3;
}

/*
	Name: strategyclearareatoobjectiveupdate
	Namespace: plannersquadutility
	Checksum: 0xE7120295
	Offset: 0x4010
	Size: 0x3B4
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyclearareatoobjectiveupdate(planner, params)
{
	/#
		_debugadjustedpath(params);
	#/
	if(!isdefined(params.objective) || !_paramshasbots(params))
	{
		return 2;
	}
	currentpathsegment = 0;
	currentcenter = undefined;
	if(params.adjustedpath.size > 1)
	{
		_evaluateadjustedpath(params);
		params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
		currentpathsegment = params.adjustedpathsegment;
		currentcenter = (params.adjustedpath[currentpathsegment] + (params.adjustedpath[currentpathsegment + 1])) / 2;
	}
	var_ba6c6b41 = function_48bd5e74(params.bots);
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_cleargameobject(bot);
			if(currentpathsegment >= (params.adjustedpath.size - 2))
			{
				trigger = params.objective[#"__unsafe__"][#"trigger"];
				if(isdefined(trigger))
				{
					function_a1574a8d(bot, trigger);
				}
				else
				{
					_setgoalpoint(bot, params.objective[#"origin"]);
					bot.goalradius = 512;
				}
				if(isdefined(params.objective[#"radius"]))
				{
					bot.goalradius = params.objective[#"radius"];
				}
				continue;
			}
			_setgoalpoint(bot, currentcenter, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
			bot.goalradius = var_ba6c6b41;
		}
	}
	if(isdefined(params.objective) && objective_state(params.objective[#"id"]) == "active")
	{
		return 3;
	}
	return 1;
}

/*
	Name: strategyhasattackobject
	Namespace: plannersquadutility
	Checksum: 0xFB01E3F0
	Offset: 0x43D0
	Size: 0x13A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasattackobject(planner, constants)
{
	team = planner::getblackboardattribute(planner, "team");
	objects = planner::getblackboardattribute(planner, "gameobjects");
	if(isdefined(objects))
	{
		foreach(object in objects)
		{
			if(object[#"team"] == team || object[#"team"] == #"any" || object[#"team"] == "free")
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: strategyhasescort
	Namespace: plannersquadutility
	Checksum: 0xEB935E7B
	Offset: 0x4518
	Size: 0x13E
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasescort(planner, constants)
{
	escorts = planner::getblackboardattribute(planner, "escorts");
	if(!isarray(escorts) || escorts.size <= 0)
	{
		return 0;
	}
	var_3ba94a7e = constants[#"key"];
	if(!isstring(var_3ba94a7e) && !function_7a600918(var_3ba94a7e) || var_3ba94a7e == "")
	{
		return 1;
	}
	for(i = 0; i < escorts.size; i++)
	{
		escort = escorts[i][#"__unsafe__"][var_3ba94a7e];
		if(isdefined(escort))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: strategyhasescortpoi
	Namespace: plannersquadutility
	Checksum: 0xCB413314
	Offset: 0x4660
	Size: 0x62
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasescortpoi(planner, constants)
{
	escortpoi = planner::getblackboardattribute(planner, "escort_poi");
	return isarray(escortpoi) && escortpoi.size > 0;
}

/*
	Name: strategyhasforcegoal
	Namespace: plannersquadutility
	Checksum: 0x719EF5BD
	Offset: 0x46D0
	Size: 0x34
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasforcegoal(planner, constants)
{
	return isdefined(planner::getblackboardattribute(planner, "force_goal"));
}

/*
	Name: function_790fb743
	Namespace: plannersquadutility
	Checksum: 0x1F504F09
	Offset: 0x4710
	Size: 0xF6
	Parameters: 2
	Flags: Linked, Private
*/
private function function_790fb743(planner, constants)
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
	Name: function_f6ec02a4
	Namespace: plannersquadutility
	Checksum: 0x38DE5E8B
	Offset: 0x4810
	Size: 0x25A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_f6ec02a4(planner, constants)
{
	/#
		assert(isfloat(constants[#"percent"]), ("" + "") + "");
	#/
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bot = botinfo[#"__unsafe__"][#"bot"];
		if(!strategiccommandutility::isvalidbot(bot))
		{
			continue;
		}
		weapons = bot getweaponslistprimaries();
		foreach(weapon in weapons)
		{
			if(isdefined(weapon) && weapon.name != "none")
			{
				currentammo = bot getammocount(weapon);
				maxammo = weapon.maxammo;
				if(isdefined(maxammo) && maxammo > 0)
				{
					ammofraction = currentammo / maxammo;
					if(ammofraction >= constants[#"percent"])
					{
						return 0;
					}
				}
			}
		}
		return 1;
	}
	return 0;
}

/*
	Name: strategyhasbelowxammounsafe
	Namespace: plannersquadutility
	Checksum: 0xCA039B73
	Offset: 0x4A78
	Size: 0x254
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasbelowxammounsafe(planner, constants)
{
	/#
		assert(isfloat(constants[#"percent"]), ("" + "") + "");
	#/
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bot = botinfo[#"__unsafe__"][#"bot"];
		if(!strategiccommandutility::isvalidbot(bot))
		{
			continue;
		}
		weapons = bot getweaponslistprimaries();
		foreach(weapon in weapons)
		{
			if(isdefined(weapon) && weapon.name != "none")
			{
				currentammo = bot getammocount(weapon);
				maxammo = weapon.maxammo;
				if(isdefined(maxammo) && maxammo > 0)
				{
					ammofraction = currentammo / maxammo;
					if(ammofraction < constants[#"percent"])
					{
						return 1;
					}
				}
			}
		}
	}
	return 0;
}

/*
	Name: strategyhasblackboardvalue
	Namespace: plannersquadutility
	Checksum: 0x19A969F7
	Offset: 0x4CD8
	Size: 0xF2
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasblackboardvalue(planner, constants)
{
	/#
		assert(isarray(constants));
	#/
	/#
		assert(isstring(constants[#"name"]) || function_7a600918(constants[#"name"]));
	#/
	value = planner::getblackboardattribute(planner, constants[#"name"]);
	return value == constants[#"value"];
}

/*
	Name: strategyhasdefendobject
	Namespace: plannersquadutility
	Checksum: 0xCBB3FAB0
	Offset: 0x4DD8
	Size: 0x13A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasdefendobject(planner, constants)
{
	team = planner::getblackboardattribute(planner, "team");
	objects = planner::getblackboardattribute(planner, "gameobjects");
	if(isdefined(objects))
	{
		foreach(object in objects)
		{
			if(object[#"team"] != team && object[#"team"] != #"any" && object[#"team"] != "free")
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: strategyhasobjective
	Namespace: plannersquadutility
	Checksum: 0xBCB00FB7
	Offset: 0x4F20
	Size: 0x10C
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhasobjective(planner, constants)
{
	team = planner::getblackboardattribute(planner, "team");
	objects = planner::getblackboardattribute(planner, "objectives");
	if(isdefined(objects))
	{
		foreach(object in objects)
		{
			if(objective_state(object[#"id"]) == "active")
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_b384b9b6
	Namespace: plannersquadutility
	Checksum: 0xA72DD2E6
	Offset: 0x5038
	Size: 0x5A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b384b9b6(planner, constants)
{
	order = planner::getblackboardattribute(planner, "order");
	return order === constants[#"order"];
}

/*
	Name: function_2083115a
	Namespace: plannersquadutility
	Checksum: 0x8325E185
	Offset: 0x50A0
	Size: 0x114
	Parameters: 2
	Flags: Linked, Private
*/
private function function_2083115a(planner, constants)
{
	team = planner::getblackboardattribute(planner, "team");
	target = planner::getblackboardattribute(planner, "target");
	if(isdefined(target))
	{
		switch(target[#"type"])
		{
			case "gameobject":
			{
				return 1;
			}
			case "goto":
			{
				return 1;
			}
			case "destroy":
			{
				return 1;
			}
			case "defend":
			{
				return 1;
			}
			case "capturearea":
			{
				return 1;
			}
			case "escortbiped":
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: strategyhaspathableammocache
	Namespace: plannersquadutility
	Checksum: 0x356081E
	Offset: 0x51C0
	Size: 0x52
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyhaspathableammocache(planner, constants)
{
	ammocaches = planner::getblackboardattribute(planner, "pathable_ammo_caches");
	return isdefined(ammocaches) && ammocaches.size > 0;
}

/*
	Name: strategyrushammocacheinit
	Namespace: plannersquadutility
	Checksum: 0xF72D1AE5
	Offset: 0x5220
	Size: 0x11C
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushammocacheinit(planner, params)
{
	if(!isdefined(params.ammo) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_setgoalpoint(bot, params.ammo.origin);
			bot.goalradius = 512;
			_assigngameobject(bot, params.ammo);
		}
	}
	return 1;
}

/*
	Name: function_a0f209b7
	Namespace: plannersquadutility
	Checksum: 0xE412CEA3
	Offset: 0x5348
	Size: 0x1F8
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a0f209b7(planner, constants)
{
	/#
		assert(isfloat(constants[#"percent"]), ("" + "") + "");
	#/
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bot = botinfo[#"__unsafe__"][#"bot"];
		if(!strategiccommandutility::isvalidbot(bot))
		{
			continue;
		}
		weapon = bot getcurrentweapon();
		if(isdefined(weapon) && weapon.name != "none")
		{
			currentammo = bot getammocount(weapon);
			maxammo = weapon.maxammo;
			if(isdefined(maxammo) && maxammo > 0)
			{
				ammofraction = currentammo / maxammo;
				if(ammofraction < constants[#"percent"])
				{
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_b3ede444
	Namespace: plannersquadutility
	Checksum: 0x29E37713
	Offset: 0x5548
	Size: 0x38
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b3ede444(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	return 1;
}

/*
	Name: function_942e45dc
	Namespace: plannersquadutility
	Checksum: 0xCF0ED201
	Offset: 0x5588
	Size: 0x440
	Parameters: 2
	Flags: Linked, Private
*/
private function function_942e45dc(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(!isalive(bot) || !strategiccommandutility::isvalidbot(bot) || !isdefined(bot.var_aeb3e046) || !bot.var_aeb3e046.size > 0 || bot bot_chain::function_58b429fb())
		{
			continue;
		}
		var_1f2328d0 = bot function_4794d6a3();
		if(var_1f2328d0.goalforced)
		{
			continue;
		}
		crumb = bot.var_aeb3e046[0];
		botnum = bot getentitynumber();
		if(isdefined(crumb.var_2777474d) && isdefined(crumb.var_2777474d[botnum]))
		{
			continue;
		}
		if(isdefined(crumb.target))
		{
			var_8d50333d = struct::get_array(crumb.target, "targetname");
			botchains = [];
			foreach(var_ced34a87 in var_8d50333d)
			{
				if(var_ced34a87.variantname === "bot_chain")
				{
					botchains[botchains.size] = var_ced34a87;
				}
			}
			if(botchains.size > 0)
			{
				bot thread bot_chain::function_cf70f2fe(botchains[randomint(botchains.size)]);
				if(!isdefined(crumb.var_2777474d))
				{
					crumb.var_2777474d = [];
				}
				else if(!isarray(crumb.var_2777474d))
				{
					crumb.var_2777474d = array(crumb.var_2777474d);
				}
				crumb.var_2777474d[botnum] = 1;
				continue;
			}
		}
		component = crumb.var_36f0c06d;
		var_3b4a9d6d = undefined;
		if(isdefined(component))
		{
			if(isdefined(component.var_2956bff4))
			{
				var_3b4a9d6d = component.var_2956bff4;
			}
			else if(isdefined(component.var_abc3ef9) && isdefined(component.var_abc3ef9.mdl_gameobject))
			{
				var_3b4a9d6d = component.var_abc3ef9.mdl_gameobject.trigger;
			}
		}
		else if(isdefined(crumb.trigger))
		{
			var_3b4a9d6d = crumb.trigger;
		}
		if(isdefined(var_3b4a9d6d))
		{
			bot setgoal(var_3b4a9d6d);
			continue;
		}
	}
	return 1;
}

/*
	Name: function_6ed940fb
	Namespace: plannersquadutility
	Checksum: 0x43E55AD0
	Offset: 0x59D0
	Size: 0xBA
	Parameters: 2
	Flags: Linked, Private
*/
private function function_6ed940fb(planner, params)
{
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_cleargameobject(bot);
			bot.goalradius = 256;
		}
	}
	return 1;
}

/*
	Name: function_4c91e90d
	Namespace: plannersquadutility
	Checksum: 0x1C2DE0A6
	Offset: 0x5A98
	Size: 0xE2
	Parameters: 2
	Flags: Linked, Private
*/
private function function_4c91e90d(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_setgoalpoint(bot, bot.origin);
			bot.goalradius = 256;
		}
	}
	return 3;
}

/*
	Name: strategyrushammocacheparam
	Namespace: plannersquadutility
	Checksum: 0x14ADCEBD
	Offset: 0x5B88
	Size: 0x51E
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushammocacheparam(planner, constants)
{
	/#
		assert(isint(constants[#"distance"]) || isfloat(constants[#"distance"]), ("" + "") + "");
	#/
	params = spawnstruct();
	params.bots = [];
	botpositions = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bot = botinfo[#"__unsafe__"][#"bot"];
		if(strategiccommandutility::isvalidbot(bot))
		{
			botposition = getclosestpointonnavmesh(botinfo[#"origin"], 200);
			if(isdefined(botposition))
			{
				botpositions[botpositions.size] = botposition;
			}
			params.bots[params.bots.size] = bot;
		}
	}
	possiblecaches = [];
	distancesq = constants[#"distance"] * constants[#"distance"];
	foreach(gameobject in level.a_gameobjects)
	{
		if(isdefined(gameobject) && gameobject gameobjects::get_identifier() === "ammo_cache")
		{
			closeenough = 1;
			foreach(botposition in botpositions)
			{
				if(distance2dsquared(gameobject.origin, botposition) > distancesq)
				{
					closeenough = 0;
					break;
				}
			}
			if(closeenough)
			{
				possiblecaches[possiblecaches.size] = gameobject;
			}
		}
	}
	path = undefined;
	shortestpath = undefined;
	closestammocache = undefined;
	foreach(ammocache in possiblecaches)
	{
		ammocachepos = getclosestpointonnavmesh(ammocache.origin, 200);
		if(isdefined(ammocachepos))
		{
			pathsegment = generatenavmeshpath(ammocachepos, botpositions);
			if(isdefined(pathsegment) && pathsegment.status === "succeeded")
			{
				if(pathsegment.pathdistance > constants[#"distance"])
				{
					continue;
				}
				if(!isdefined(path) || pathsegment.pathdistance < shortestpath)
				{
					path = pathsegment;
					shortestpath = pathsegment.pathdistance;
					closestammocache = ammocache;
				}
			}
		}
	}
	if(isdefined(closestammocache))
	{
		planner::setblackboardattribute(planner, "pathable_ammo_caches", array(closestammocache));
		params.ammo = closestammocache;
	}
	return params;
}

/*
	Name: strategyrushammocacheupdate
	Namespace: plannersquadutility
	Checksum: 0x522AF366
	Offset: 0x60B0
	Size: 0x14A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushammocacheupdate(planner, params)
{
	if(!isdefined(params.ammo) || !_paramshasbots(params))
	{
		return 2;
	}
	if(params.ammo.trigger istriggerenabled())
	{
		foreach(bot in params.bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				_setgoalpoint(bot, params.ammo.origin);
				bot.goalradius = 512;
				_assigngameobject(bot, params.ammo);
			}
		}
		return 3;
	}
	return 2;
}

/*
	Name: strategyrushattackobjectinit
	Namespace: plannersquadutility
	Checksum: 0xA38AD3E3
	Offset: 0x6208
	Size: 0x114
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushattackobjectinit(planner, params)
{
	if(!isdefined(params.object) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(params.object.triggertype == "proximity")
		{
			function_a1574a8d(bot, params.object.trigger);
			continue;
		}
		_assigngameobject(bot, params.object);
	}
	return 1;
}

/*
	Name: strategyrushattackobjectupdate
	Namespace: plannersquadutility
	Checksum: 0xC229EE39
	Offset: 0x6328
	Size: 0x78
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushattackobjectupdate(planner, params)
{
	if(!isdefined(params.object) || !_paramshasbots(params))
	{
		return 2;
	}
	if(params.object.trigger istriggerenabled())
	{
		return 3;
	}
	return 1;
}

/*
	Name: strategyrushdefendobjectinit
	Namespace: plannersquadutility
	Checksum: 0xE7ADCB88
	Offset: 0x63A8
	Size: 0x112
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushdefendobjectinit(planner, params)
{
	if(!isdefined(params.object) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_cleargameobject(bot);
			_setgoalpoint(bot, params.object.origin);
			bot.goalradius = 512;
		}
	}
	return 1;
}

/*
	Name: strategyrushdefendobjectupdate
	Namespace: plannersquadutility
	Checksum: 0x75285BDE
	Offset: 0x64C8
	Size: 0x78
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushdefendobjectupdate(planner, params)
{
	if(!isdefined(params.object) || !_paramshasbots(params))
	{
		return 2;
	}
	if(params.object.trigger istriggerenabled())
	{
		return 3;
	}
	return 2;
}

/*
	Name: strategyrushescortparam
	Namespace: plannersquadutility
	Checksum: 0x3D25F4A6
	Offset: 0x6548
	Size: 0x224
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushescortparam(planner, constants)
{
	params = spawnstruct();
	escorts = planner::getblackboardattribute(planner, "escorts");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.escort = escorts[0][#"__unsafe__"][#"player"];
	if(isdefined(params.escort))
	{
		foreach(bot in bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				params.path = strategiccommandutility::calculatepathtoposition(bot, params.escort.origin);
				if(isdefined(params.path))
				{
					break;
				}
			}
		}
	}
	return params;
}

/*
	Name: function_5ac5aed
	Namespace: plannersquadutility
	Checksum: 0xDA189E58
	Offset: 0x6778
	Size: 0x2F2
	Parameters: 2
	Flags: Linked, Private
*/
private function function_5ac5aed(planner, params)
{
	if(!isdefined(params.escort) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			bot bot::function_6c280dfe();
			var_4b3d8f59 = 0;
			if(sessionmodeiszombiesgame() && isdefined(params.bots[0]) && isalive(params.bots[0]))
			{
				groundent = params.escort getgroundent();
				if(isdefined(groundent) && groundent ismovingplatform())
				{
					var_201e45bb = (randomfloatrange(groundent.mins[0], groundent.maxs[0]), randomfloatrange(groundent.mins[1], groundent.maxs[1]), 0);
					var_d0354e07 = (groundent.origin + var_201e45bb) * (1, 1, 0);
					var_2c574437 = var_d0354e07 + (0, 0, params.escort.origin[2] + 16);
					targetpoint = getclosestpointonnavmesh(var_2c574437, 64, 16);
					if(isdefined(targetpoint))
					{
						var_4b3d8f59 = 1;
						bot setgoal(targetpoint, 1);
					}
				}
			}
			if(!var_4b3d8f59)
			{
				bot clearforcedgoal();
				bot setgoal(params.escort);
				bot.goalradius = 512;
			}
		}
	}
	return 1;
}

/*
	Name: function_a856fc9d
	Namespace: plannersquadutility
	Checksum: 0xAB5DC419
	Offset: 0x6A78
	Size: 0x130
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a856fc9d(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(isdefined(params.escort))
	{
		if(sessionmodeiszombiesgame() && isdefined(params.bots[0]) && isalive(params.bots[0]) && isdefined(params.bots[0].goalent) && params.bots[0].goalent == params.escort)
		{
			groundent = params.escort getgroundent();
			if(isdefined(groundent) && groundent ismovingplatform())
			{
				return 2;
			}
		}
		return 3;
	}
	return 2;
}

/*
	Name: strategyrushforcegoalinit
	Namespace: plannersquadutility
	Checksum: 0xF1F1BAE2
	Offset: 0x6BB0
	Size: 0xFC
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushforcegoalinit(planner, params)
{
	if(!isdefined(params.goal) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_cleargameobject(bot);
			bot setgoal(params.goal);
		}
	}
	return 1;
}

/*
	Name: strategyrushforcegoalupdate
	Namespace: plannersquadutility
	Checksum: 0x947509B8
	Offset: 0x6CB8
	Size: 0x4E
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushforcegoalupdate(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(isdefined(params.goal))
	{
		return 3;
	}
	return 2;
}

/*
	Name: strategyrushobjectiveinit
	Namespace: plannersquadutility
	Checksum: 0x2F9DCD29
	Offset: 0x6D10
	Size: 0x162
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushobjectiveinit(planner, params)
{
	if(!isdefined(params.objective) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_cleargameobject(bot);
			_setgoalpoint(bot, params.objective[#"origin"]);
			bot.goalradius = 512;
			if(isdefined(params.objective[#"radius"]))
			{
				bot.goalradius = params.objective[#"radius"];
			}
		}
	}
	return 1;
}

/*
	Name: strategyrushobjectiveparam
	Namespace: plannersquadutility
	Checksum: 0xB1F5B930
	Offset: 0x6E80
	Size: 0x304
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushobjectiveparam(planner, constants)
{
	params = spawnstruct();
	objectives = planner::getblackboardattribute(planner, "objectives");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.objective = objectives[0];
	if(isdefined(params.objective))
	{
		trigger = params.objective[#"__unsafe__"][#"trigger"];
		if(isdefined(trigger))
		{
			foreach(bot in bots)
			{
				if(strategiccommandutility::isvalidbot(bot))
				{
					params.path = strategiccommandutility::calculatepathtotrigger(bot, trigger);
					if(isdefined(params.path))
					{
						break;
					}
				}
			}
		}
		else
		{
			foreach(bot in bots)
			{
				if(strategiccommandutility::isvalidbot(bot))
				{
					params.path = strategiccommandutility::calculatepathtoposition(bot, objective_position(params.objective[#"id"]));
					if(isdefined(params.path))
					{
						break;
					}
				}
			}
		}
	}
	return params;
}

/*
	Name: strategyrushobjectiveupdate
	Namespace: plannersquadutility
	Checksum: 0xFB37D11F
	Offset: 0x7190
	Size: 0x8C
	Parameters: 2
	Flags: Linked, Private
*/
private function strategyrushobjectiveupdate(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(isdefined(params.objective) && objective_state(params.objective[#"id"]) == "active")
	{
		return 3;
	}
	return 2;
}

/*
	Name: function_e96dd96b
	Namespace: plannersquadutility
	Checksum: 0x4CD2F087
	Offset: 0x7228
	Size: 0x282
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e96dd96b(planner, constants)
{
	/#
		assert(isarray(constants));
	#/
	/#
		assert(isstring(constants[#"focus"]) || function_7a600918(constants[#"focus"]));
	#/
	target = planner::getblackboardattribute(planner, "target");
	if(isdefined(target))
	{
		var_3d879b56 = target[#"strategy"];
		var_f8ffdb19 = strategiccommandutility::function_f4921cb3(constants[#"focus"]);
		squadbots = planner::getblackboardattribute(planner, "doppelbots");
		if(isstruct(var_3d879b56))
		{
			foreach(botinfo in squadbots)
			{
				bot = botinfo[#"__unsafe__"][#"bot"];
				var_681a8d61 = "doppelbotsfocus";
				foreach(focus in var_f8ffdb19)
				{
					if(var_3d879b56.(var_681a8d61) == focus)
					{
						return 1;
					}
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_50c7bd5a
	Namespace: plannersquadutility
	Checksum: 0xC10C115
	Offset: 0x74B8
	Size: 0x148
	Parameters: 2
	Flags: Linked, Private
*/
private function function_50c7bd5a(planner, constants)
{
	/#
		assert(isarray(constants));
	#/
	/#
		assert(isstring(constants[#"tactics"]) || function_7a600918(constants[#"tactics"]));
	#/
	var_e67e6f95 = constants[#"tactics"];
	target = planner::getblackboardattribute(planner, "target");
	if(isdefined(target))
	{
		var_3d879b56 = target[#"strategy"];
		if(isstruct(var_3d879b56))
		{
			return var_3d879b56.("doppelbotstactics") == var_e67e6f95;
		}
	}
	return 0;
}

/*
	Name: strategywanderinit
	Namespace: plannersquadutility
	Checksum: 0xB3C4F083
	Offset: 0x7608
	Size: 0xBA
	Parameters: 2
	Flags: Linked, Private
*/
private function strategywanderinit(planner, params)
{
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			_cleargameobject(bot);
			bot.goalradius = 128;
		}
	}
	return 1;
}

/*
	Name: strategywanderupdate
	Namespace: plannersquadutility
	Checksum: 0x17C2809D
	Offset: 0x76D0
	Size: 0x24A
	Parameters: 2
	Flags: Linked, Private
*/
private function strategywanderupdate(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			if(!isdefined(bot._wander_update_time))
			{
				bot._wander_update_time = 0;
			}
			if((bot._wander_update_time + 3000) < gettime() || bot isingoal(bot.origin))
			{
				searchradius = 1024;
				navmeshpoint = getclosestpointonnavmesh(bot.origin, 200);
				if(isdefined(navmeshpoint))
				{
					forward = anglestoforward(bot getangles());
					forwardpos = bot.origin + (forward * searchradius);
					cylinder = ai::t_cylinder(bot.origin, searchradius, searchradius);
					points = tacticalquery(#"stratcom_tacquery_wander", navmeshpoint, cylinder, forwardpos, bot);
					if(points.size > 0)
					{
						_setgoalpoint(bot, points[0].origin);
						bot._wander_update_time = gettime();
					}
				}
			}
		}
	}
	return 3;
}

