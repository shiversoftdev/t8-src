// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\bots\bot.gsc;
#using script_30e0aa25775a6927;
#using script_31e56101095f174b;
#using scripts\core_common\ai\planner_squad.gsc;
#using scripts\core_common\ai\planner_squad_utility.gsc;
#using script_522aeb6ae906391e;
#using scripts\core_common\ai\region_utility.gsc;
#using script_59f07c660e6710a5;
#using scripts\core_common\ai\strategic_command.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_83a61576;

/*
	Name: __init__system__
	Namespace: namespace_83a61576
	Checksum: 0x82037293
	Offset: 0x1A0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_363beb0dbbf3d8bb", &namespace_9b3ab448::__init__, undefined, undefined);
}

#namespace namespace_9b3ab448;

/*
	Name: __init__
	Namespace: namespace_9b3ab448
	Checksum: 0x78C9249D
	Offset: 0x1E8
	Size: 0x404
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	plannerutility::registerplannerapi(#"hash_7cb07a568d6f4cdf", &function_984c7289);
	plannerutility::registerplannerapi(#"hash_a478e9ff1c93f25", &function_3e055926);
	plannerutility::registerplannerapi(#"hash_6d04a8beefdd8300", &function_ca867965);
	plannerutility::registerplannerapi(#"hash_4e7f3e0ab96fb7d6", &function_16b44b20);
	plannerutility::registerplannerapi(#"hash_390ec5fab1695fc5", &function_c1f972ba);
	plannerutility::registerplannerapi(#"hash_729fab3e03b8972e", &function_a5c008c);
	plannerutility::registerplannerapi(#"hash_22435468ace59f07", &function_b6cc50c3);
	plannerutility::registerplannerapi(#"hash_5a17553b6546a4c5", &function_5d508101);
	plannerutility::registerplanneraction(#"hash_238cb2b85abe80de", &function_c586e586, &function_bb0c6999, &function_e9a16daa, undefined);
	plannerutility::registerplanneraction(#"hash_3fff1f031065f09f", &function_2b5c33a8, &function_4ff28605, &function_fd3f340f, undefined);
	plannerutility::registerplanneraction(#"hash_1d498d2dc9db37d7", &function_e32ce201, &function_fb2a81d9, &function_99cd56f9, undefined);
	plannerutility::registerplanneraction(#"hash_62f0edcdb7d80d62", &function_f3fefad8, &function_3235898a, &function_94e18e0d, undefined);
	plannerutility::registerplanneraction(#"hash_44fb55c97ea86435", &function_5b04cb13, &function_bb791fc6, &function_df817333, undefined);
	plannerutility::registerplanneraction(#"hash_7390712ebfb3d2d3", &function_f08360d0, &function_e7a81528, &function_fb79f3bd, undefined);
	plannerutility::registerplanneraction(#"hash_49c4e40e3e0f7be0", &function_458e36c0, &function_4f4ef3b6, &function_53882720, undefined);
	plannerutility::registerplanneraction(#"hash_53845b799f264276", &function_8c1624c4, &function_61587057, &function_6203826a, undefined);
}

/*
	Name: _paramshasbots
	Namespace: namespace_9b3ab448
	Checksum: 0xCACB5A29
	Offset: 0x5F8
	Size: 0xC6
	Parameters: 1
	Flags: Linked, Private
*/
function private _paramshasbots(params)
{
	foreach(bot in params.bots)
	{
		if(isdefined(bot) && isbot(bot) && ai::getaiattribute(bot, "control") === "commander")
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_5cc53671
	Namespace: namespace_9b3ab448
	Checksum: 0xD27B5C5F
	Offset: 0x6C8
	Size: 0x6A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5cc53671(bot)
{
	if(isdefined(bot) && isbot(bot))
	{
		bot setgoal(bot.origin);
		bot.goalradius = 128;
		bot.goalheight = 128;
	}
}

/*
	Name: function_61be4b2c
	Namespace: namespace_9b3ab448
	Checksum: 0xC69959F
	Offset: 0x740
	Size: 0x18E
	Parameters: 2
	Flags: Private
*/
function private function_61be4b2c(bot, gameobject)
{
	botpos = getclosestpointonnavmesh(bot.origin, 120, bot getpathfindingradius() * 1.05);
	var_5bf84edd = getclosestpointonnavmesh(gameobject.origin, 200);
	if(!isdefined(botpos) || !isdefined(var_5bf84edd))
	{
		return gameobject.origin;
	}
	queryresult = positionquery_source_navigation(var_5bf84edd, 0, 200, 100, 16, bot);
	if(queryresult.data.size > 0)
	{
		for(i = 0; i < queryresult.data.size; i++)
		{
			pathsegment = generatenavmeshpath(botpos, queryresult.data[i].origin, bot);
			if(isdefined(pathsegment) && pathsegment.status === "succeeded")
			{
				return queryresult.data[i].origin;
			}
		}
	}
}

/*
	Name: function_3ecc52d9
	Namespace: namespace_9b3ab448
	Checksum: 0x8A19DF9B
	Offset: 0x8D8
	Size: 0x230
	Parameters: 2
	Flags: Linked, Private
*/
function private function_3ecc52d9(var_d3547bb1, laneNum)
{
	if(isdefined(self.bot.var_6369695a))
	{
		soundsgunnerplay = self.bot.var_6369695a.path;
		if(soundsgunnerplay.size > 0)
		{
			var_3ebdf257 = soundsgunnerplay[soundsgunnerplay.size - 1];
			if(var_3ebdf257 === var_d3547bb1)
			{
				return self.bot.var_6369695a;
			}
		}
	}
	tpoint = getclosesttacpoint(self.origin);
	if(!isdefined(tpoint))
	{
		var_9f855ac9 = getclosestpointonnavmesh(self.origin, 600);
		if(isdefined(var_9f855ac9))
		{
			tpoint = getclosesttacpoint(var_9f855ac9);
		}
	}
	if(isdefined(tpoint))
	{
		var_55e8adf1 = tpoint.region;
		var_8c8aa14d = spawnstruct();
		var_8c8aa14d.path = self region_utility::function_b0f112ca(var_55e8adf1, var_d3547bb1, laneNum);
		var_8c8aa14d.var_91fc28f4 = 0;
		if(var_8c8aa14d.path.size == 0)
		{
			if(!isdefined(var_8c8aa14d.path))
			{
				var_8c8aa14d.path = [];
			}
			else if(!isarray(var_8c8aa14d.path))
			{
				var_8c8aa14d.path = array(var_8c8aa14d.path);
			}
			var_8c8aa14d.path[var_8c8aa14d.path.size] = var_d3547bb1;
		}
		self.bot.var_6369695a = var_8c8aa14d;
		return var_8c8aa14d;
	}
}

/*
	Name: function_a702eb04
	Namespace: namespace_9b3ab448
	Checksum: 0xDCE63BCC
	Offset: 0xB10
	Size: 0x294
	Parameters: 2
	Flags: Linked, Private
*/
function private function_a702eb04(params, goal)
{
	var_c19c4223 = 0;
	for(i = 0; i < params.bots.size; i++)
	{
		bot = params.bots[i];
		if(strategiccommandutility::isvalidbot(bot))
		{
			var_6369695a = params.var_bb5fa5a7[i];
			if(!isdefined(var_6369695a) || var_6369695a.path.size == 0)
			{
				bot setgoal(goal);
				continue;
			}
			var_1f2328d0 = bot function_4794d6a3();
			tpoint = getclosesttacpoint(bot.origin);
			if(!isdefined(tpoint) && isdefined(var_1f2328d0.regionid) && !var_1f2328d0.isatgoal)
			{
				continue;
			}
			var_65733efe = -1;
			if(isdefined(tpoint))
			{
				var_65733efe = tpoint.region;
			}
			for(var_91fc28f4 = var_6369695a.var_91fc28f4; var_91fc28f4 < var_6369695a.path.size; var_91fc28f4++)
			{
				if(var_65733efe === var_6369695a.path[var_91fc28f4])
				{
					break;
				}
			}
			if(var_91fc28f4 < var_6369695a.path.size - 2)
			{
				bot.var_d494450c = undefined;
				bot setgoal(var_6369695a.path[var_91fc28f4 + 1]);
				if(var_91fc28f4 > var_6369695a.var_91fc28f4)
				{
					var_6369695a.var_91fc28f4 = var_91fc28f4;
				}
				continue;
			}
			bot.var_d494450c = undefined;
			bot setgoal(goal);
			var_c19c4223++;
		}
	}
	if(var_c19c4223 == params.bots.size)
	{
		return 1;
	}
	return 3;
}

/*
	Name: function_a023ae49
	Namespace: namespace_9b3ab448
	Checksum: 0x17397274
	Offset: 0xDB0
	Size: 0x90
	Parameters: 2
	Flags: Private
*/
function private function_a023ae49(planner, params)
{
	foreach(bot in params.bots)
	{
		function_5cc53671(bot);
	}
}

/*
	Name: function_3f15f776
	Namespace: namespace_9b3ab448
	Checksum: 0x146152EB
	Offset: 0xE48
	Size: 0x112
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3f15f776(params)
{
	for(i = 0; i < params.bots.size; i++)
	{
		bot = params.bots[i];
		if(strategiccommandutility::isvalidbot(bot))
		{
			var_1f2328d0 = bot function_4794d6a3();
			if(isdefined(var_1f2328d0.regionid) && !var_1f2328d0.isatgoal)
			{
				continue;
			}
			region = params.regions[randomint(params.regions.size)];
			bot.var_d494450c = undefined;
			bot setgoal(region);
		}
	}
	return 3;
}

/*
	Name: function_6d153384
	Namespace: namespace_9b3ab448
	Checksum: 0x1C0D02F6
	Offset: 0xF68
	Size: 0x112
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6d153384(position)
{
	if(level.teambased)
	{
		return function_69e73bdb(position);
	}
	maxdist = 0;
	var_4764de7f = position;
	foreach(spawn in level.spawn_start[#"free"])
	{
		dist = distancesquared(position, spawn.origin);
		if(dist > maxdist)
		{
			maxdist = dist;
			var_4764de7f = spawn.origin;
		}
	}
	return var_4764de7f;
}

/*
	Name: function_69e73bdb
	Namespace: namespace_9b3ab448
	Checksum: 0x7921A458
	Offset: 0x1088
	Size: 0x15E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_69e73bdb(position)
{
	if(!isdefined(level.spawn_start) || !isdefined(level.spawn_start[#"allies"]) || !isdefined(level.spawn_start[#"axis"]) || level.spawn_start[#"allies"].size == 0 || level.spawn_start[#"axis"].size == 0)
	{
		return undefined;
	}
	var_192c21ed = level.spawn_start[#"allies"][0].origin;
	var_945e5bae = level.spawn_start[#"axis"][0].origin;
	var_eb097b41 = distancesquared(position, var_192c21ed);
	var_75b1f52d = distancesquared(position, var_945e5bae);
	return (var_eb097b41 > var_75b1f52d ? var_192c21ed : var_945e5bae);
}

/*
	Name: function_55cc58c4
	Namespace: namespace_9b3ab448
	Checksum: 0x38384984
	Offset: 0x11F0
	Size: 0x156
	Parameters: 2
	Flags: Linked
*/
function function_55cc58c4(planner, var_973c5ec5)
{
	var_757ff5c1 = undefined;
	var_72d5b8ac = planner::getblackboardattribute(planner, "mp_pathable_controlZones");
	if(isarray(var_72d5b8ac) && var_72d5b8ac.size == 2)
	{
		foreach(var_2b511b1a in var_72d5b8ac)
		{
			zone = var_2b511b1a[#"controlzone"][#"__unsafe__"][#"controlzone"];
			if(zone.gameobject.trigger istriggerenabled() && zone != var_973c5ec5)
			{
				var_757ff5c1 = zone;
			}
		}
	}
	return var_757ff5c1;
}

/*
	Name: function_984c7289
	Namespace: namespace_9b3ab448
	Checksum: 0xF010816B
	Offset: 0x1350
	Size: 0xE8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_984c7289(planner, constants)
{
	controlzones = planner::getblackboardattribute(planner, "mp_controlZones");
	if(!isarray(controlzones) || controlzones.size <= 0)
	{
		return false;
	}
	for(i = 0; i < controlzones.size; i++)
	{
		zone = controlzones[i][#"__unsafe__"][#"controlzone"];
		if(isdefined(zone) && isdefined(zone.gameobject))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_3e055926
	Namespace: namespace_9b3ab448
	Checksum: 0x8DE96068
	Offset: 0x1440
	Size: 0xFA
	Parameters: 2
	Flags: Linked, Private
*/
function private function_3e055926(planner, constants)
{
	domflags = planner::getblackboardattribute(planner, "mp_domFlags");
	if(!isarray(domflags) || domflags.size <= 0)
	{
		return false;
	}
	for(i = 0; i < domflags.size; i++)
	{
		domflag = domflags[i][#"__unsafe__"][#"domflag"];
		if(isdefined(domflag) && domflags[i][#"claimed"] == 0)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_ca867965
	Namespace: namespace_9b3ab448
	Checksum: 0xFB150682
	Offset: 0x1548
	Size: 0xE8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_ca867965(planner, constants)
{
	kothzone = planner::getblackboardattribute(planner, "mp_kothZone");
	if(!isarray(kothzone) || kothzone.size <= 0)
	{
		return false;
	}
	zone = kothzone[0][#"__unsafe__"][#"kothzone"];
	if(isdefined(zone) && isdefined(zone.trig) && zone.trig istriggerenabled())
	{
		return true;
	}
	return false;
}

/*
	Name: function_16b44b20
	Namespace: namespace_9b3ab448
	Checksum: 0xE0CDB490
	Offset: 0x1638
	Size: 0x2A8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_16b44b20(planner, constants)
{
	sdbomb = planner::getblackboardattribute(planner, "mp_sdBomb");
	if(!isarray(sdbomb) || sdbomb.size <= 0)
	{
		return false;
	}
	bots = planner::getblackboardattribute(planner, "doppelbots");
	if(isdefined(bots))
	{
		bot = bots[0][#"__unsafe__"][#"bot"];
		if(isdefined(bot) && isalive(bot))
		{
			var_7fe54ea1 = bot getentitynumber();
			foreach(player in level.players)
			{
				if(!isdefined(player) || !isalive(player))
				{
					continue;
				}
				if(player == bot || !isbot(player))
				{
					continue;
				}
				if(!isdefined(player.sessionstate) || player.sessionstate != "playing")
				{
					continue;
				}
				if(player.team != bot.team)
				{
					continue;
				}
				if(player getentitynumber() < var_7fe54ea1)
				{
					return false;
				}
			}
		}
	}
	bomb = sdbomb[0][#"__unsafe__"][#"sdbomb"];
	if(isdefined(bomb) && bomb.trigger istriggerenabled())
	{
		return true;
	}
	return false;
}

/*
	Name: function_c1f972ba
	Namespace: namespace_9b3ab448
	Checksum: 0xB817C30
	Offset: 0x18E8
	Size: 0xD6
	Parameters: 2
	Flags: Linked, Private
*/
function private function_c1f972ba(planner, constants)
{
	bombzones = planner::getblackboardattribute(planner, "mp_sdBombZones");
	if(!isarray(bombzones) || bombzones.size <= 0)
	{
		return false;
	}
	for(i = 0; i < bombzones.size; i++)
	{
		zone = bombzones[i][#"__unsafe__"][#"sdbombzone"];
		if(isdefined(zone))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_a5c008c
	Namespace: namespace_9b3ab448
	Checksum: 0x2C423AB9
	Offset: 0x19C8
	Size: 0xB2
	Parameters: 2
	Flags: Linked, Private
*/
function private function_a5c008c(planner, constants)
{
	defuseobj = planner::getblackboardattribute(planner, "mp_sdDefuseObj");
	if(!isarray(defuseobj) || defuseobj.size <= 0)
	{
		return false;
	}
	defuse = defuseobj[0][#"__unsafe__"][#"sddefuseobj"];
	if(isdefined(defuse))
	{
		return true;
	}
	return false;
}

/*
	Name: function_b6cc50c3
	Namespace: namespace_9b3ab448
	Checksum: 0xC2DDE523
	Offset: 0x1A88
	Size: 0xE8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_b6cc50c3(planner, constants)
{
	bots = planner::getblackboardattribute(planner, "doppelbots");
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
	Name: function_5d508101
	Namespace: namespace_9b3ab448
	Checksum: 0x29035059
	Offset: 0x1B78
	Size: 0x60
	Parameters: 2
	Flags: Linked, Private
*/
function private function_5d508101(planner, constants)
{
	laneNum = planner::getblackboardattribute(planner, "mp_laneNum");
	if(!isdefined(laneNum) || laneNum.size == 0)
	{
		return false;
	}
	return true;
}

/*
	Name: function_f816c9b0
	Namespace: namespace_9b3ab448
	Checksum: 0xDA4F2E44
	Offset: 0x1BE0
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function function_f816c9b0(var_973c5ec5, var_5d4457)
{
	var_803d2f2a = var_973c5ec5.gameobject.curprogress > 0;
	var_99b927c3 = var_5d4457.gameobject.curprogress > 0;
	if(!var_803d2f2a && var_99b927c3)
	{
		return true;
	}
	return false;
}

/*
	Name: function_c586e586
	Namespace: namespace_9b3ab448
	Checksum: 0xA69F24FA
	Offset: 0x1C60
	Size: 0x52C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_c586e586(planner, constants)
{
	params = spawnstruct();
	controlzone = planner::getblackboardattribute(planner, "mp_controlZones");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		if(!isdefined(bots))
		{
			bots = [];
		}
		else if(!isarray(bots))
		{
			bots = array(bots);
		}
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.controlzone = controlzone[0][#"__unsafe__"][#"controlzone"];
	var_a83322cd = params.controlzone.gameobject.trigger istriggerenabled();
	if(!var_a83322cd)
	{
		var_5d4457 = self function_55cc58c4(planner, params.controlzone);
		var_497c24d4 = isdefined(var_5d4457);
		if(var_497c24d4)
		{
			params.controlzone = var_5d4457;
		}
	}
	else if(isdefined(params.bots[0]) && params.bots[0].team == game.defenders && getdvarint(#"bot_difficulty", 1) >= 1)
	{
		var_5d4457 = self function_55cc58c4(planner, params.controlzone);
		var_497c24d4 = isdefined(var_5d4457);
		if(var_497c24d4 && self function_f816c9b0(params.controlzone, var_5d4457))
		{
			params.controlzone = var_5d4457;
		}
	}
	params.var_f76f8cf6 = planner::getblackboardattribute(planner, "mp_laneNum");
	params.var_46b70ee6 = getclosesttacpoint(params.controlzone.gameobject.origin).region;
	if(isdefined(params.controlzone))
	{
		if(isdefined(params.var_f76f8cf6))
		{
			params.var_bb5fa5a7 = [];
			for(i = 0; i < bots.size; i++)
			{
				if(strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i]) && game.state == "playing")
				{
					params.var_bb5fa5a7[i] = bots[i] function_3ecc52d9(params.var_46b70ee6, params.var_f76f8cf6[0]);
				}
			}
		}
		else
		{
			foreach(bot in bots)
			{
				if(strategiccommandutility::isvalidbot(bot))
				{
					params.path = strategiccommandutility::calculatepathtoposition(bot, params.controlzone.gameobject.origin);
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
	Name: function_bb0c6999
	Namespace: namespace_9b3ab448
	Checksum: 0x400FBF97
	Offset: 0x2198
	Size: 0x4C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_bb0c6999(planner, params)
{
	if(!isdefined(params.controlzone) || !_paramshasbots(params))
	{
		return 2;
	}
	return 1;
}

/*
	Name: function_e9a16daa
	Namespace: namespace_9b3ab448
	Checksum: 0x9F10D931
	Offset: 0x21F0
	Size: 0x2A2
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e9a16daa(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(!isdefined(params.controlzone))
	{
		return 2;
	}
	var_a83322cd = params.controlzone.gameobject.trigger istriggerenabled();
	if(!var_a83322cd)
	{
		var_5d4457 = self function_55cc58c4(planner, params.controlzone);
		var_497c24d4 = isdefined(var_5d4457);
		if(var_497c24d4)
		{
			return 2;
		}
	}
	else if(isdefined(params.bots[0]) && params.bots[0].team == game.defenders && getdvarint(#"bot_difficulty", 1) >= 1)
	{
		var_5d4457 = self function_55cc58c4(planner, params.controlzone);
		var_497c24d4 = isdefined(var_5d4457);
		if(var_497c24d4 && self function_f816c9b0(params.controlzone, var_5d4457))
		{
			return 2;
		}
	}
	if(!isdefined(params.var_bb5fa5a7) || params.var_bb5fa5a7.size == 0)
	{
		foreach(bot in params.bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				bot setgoal(params.controlzone.trigger);
			}
		}
		return 3;
	}
	return function_a702eb04(params, params.controlzone.trigger);
}

/*
	Name: function_2b5c33a8
	Namespace: namespace_9b3ab448
	Checksum: 0x52765079
	Offset: 0x24A0
	Size: 0x88C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_2b5c33a8(planner, constants)
{
	params = spawnstruct();
	domflags = planner::getblackboardattribute(planner, "mp_domFlags");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		if(!isdefined(bots))
		{
			bots = [];
		}
		else if(!isarray(bots))
		{
			bots = array(bots);
		}
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	var_2bd3822d = [];
	foreach(flag in domflags)
	{
		var_796d54f2 = flag[#"__unsafe__"][#"domflag"];
		if(!isdefined(var_2bd3822d))
		{
			var_2bd3822d = [];
		}
		else if(!isarray(var_2bd3822d))
		{
			var_2bd3822d = array(var_2bd3822d);
		}
		var_2bd3822d[var_2bd3822d.size] = var_796d54f2;
	}
	params.bots = bots;
	foreach(bot in params.bots)
	{
		if(!isdefined(bot))
		{
			continue;
		}
		var_d637f1b0 = [];
		var_e2b90cdd = [];
		var_44114a0e = "";
		for(i = 0; i < var_2bd3822d.size; i++)
		{
			flag = var_2bd3822d[i];
			if(flag gameobjects::get_owner_team() === bot.team)
			{
				var_44114a0e = var_44114a0e + "d";
				if(!isdefined(var_e2b90cdd))
				{
					var_e2b90cdd = [];
				}
				else if(!isarray(var_e2b90cdd))
				{
					var_e2b90cdd = array(var_e2b90cdd);
				}
				var_e2b90cdd[var_e2b90cdd.size] = flag;
				continue;
			}
			var_44114a0e = var_44114a0e + "a";
			if(!isdefined(var_d637f1b0))
			{
				var_d637f1b0 = [];
			}
			else if(!isarray(var_d637f1b0))
			{
				var_d637f1b0 = array(var_d637f1b0);
			}
			var_d637f1b0[var_d637f1b0.size] = flag;
		}
		if(!isdefined(bot.bot.var_44114a0e) || var_44114a0e != bot.bot.var_44114a0e)
		{
			bot.bot.var_44114a0e = var_44114a0e;
			bot.bot.currentflag = undefined;
		}
		if(!isdefined(bot.bot.currentflag))
		{
			if(var_e2b90cdd.size >= 2)
			{
				if(getdvarint(#"bot_difficulty", 1) == 0)
				{
					bot.bot.currentflag = var_e2b90cdd[0];
				}
				else
				{
					bot.bot.currentflag = array::random(var_e2b90cdd);
				}
			}
			else
			{
				if(var_d637f1b0.size >= 0)
				{
					bot.bot.currentflag = var_d637f1b0[0];
					if(var_d637f1b0.size > 1 && randomfloat(1) < 0.35 && distancesquared(bot.origin, var_d637f1b0[0].origin) > 360000)
					{
						bot.bot.currentflag = var_d637f1b0[1];
						if(var_d637f1b0.size > 2 && randomfloat(1) < 0.3)
						{
							bot.bot.currentflag = var_d637f1b0[2];
						}
					}
				}
				else if(var_2bd3822d.size > 0)
				{
					bot.bot.currentflag = var_2bd3822d[0];
				}
			}
		}
		params.domflag = bot.bot.currentflag;
	}
	if(!isdefined(params.domflag))
	{
		return params;
	}
	params.var_f76f8cf6 = planner::getblackboardattribute(planner, "mp_laneNum");
	params.var_46b70ee6 = getclosesttacpoint(params.domflag.origin).region;
	if(isdefined(params.domflag))
	{
		if(isdefined(params.var_f76f8cf6))
		{
			params.var_bb5fa5a7 = [];
			for(i = 0; i < bots.size; i++)
			{
				if(strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i]) && game.state == "playing")
				{
					params.var_bb5fa5a7[i] = bots[i] function_3ecc52d9(params.var_46b70ee6, params.var_f76f8cf6[0]);
				}
			}
		}
		else
		{
			foreach(bot in bots)
			{
				if(strategiccommandutility::isvalidbot(bot))
				{
					params.path = strategiccommandutility::calculatepathtoposition(bot, params.domflag.origin);
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
	Name: function_4ff28605
	Namespace: namespace_9b3ab448
	Checksum: 0x4B5CAD36
	Offset: 0x2D38
	Size: 0xEC
	Parameters: 2
	Flags: Linked, Private
*/
function private function_4ff28605(planner, params)
{
	if(!isdefined(params.domflag) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			bot setgoal(params.domflag.trigger);
		}
	}
	return 1;
}

/*
	Name: function_fd3f340f
	Namespace: namespace_9b3ab448
	Checksum: 0x13E629F4
	Offset: 0x2E30
	Size: 0x142
	Parameters: 2
	Flags: Linked, Private
*/
function private function_fd3f340f(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(!isdefined(params.domflag))
	{
		return 2;
	}
	if(!isdefined(params.var_bb5fa5a7) || params.var_bb5fa5a7.size == 0)
	{
		foreach(bot in params.bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				bot setgoal(params.domflag.trigger);
			}
		}
		return 3;
	}
	return function_a702eb04(params, params.domflag.trigger);
}

/*
	Name: function_e32ce201
	Namespace: namespace_9b3ab448
	Checksum: 0x7E17C668
	Offset: 0x2F80
	Size: 0x39C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e32ce201(planner, constants)
{
	params = spawnstruct();
	kothzone = planner::getblackboardattribute(planner, "mp_kothZone");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		if(!isdefined(bots))
		{
			bots = [];
		}
		else if(!isarray(bots))
		{
			bots = array(bots);
		}
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.kothzone = kothzone[0][#"__unsafe__"][#"kothzone"];
	params.var_f76f8cf6 = planner::getblackboardattribute(planner, "mp_laneNum");
	params.var_46b70ee6 = getclosesttacpoint(params.kothzone.gameobject.origin).region;
	if(isdefined(params.kothzone))
	{
		if(isdefined(params.laneNum))
		{
			params.var_bb5fa5a7 = [];
			for(i = 0; i < bots.size; i++)
			{
				if(strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i]))
				{
					params.var_bb5fa5a7[i] = bots[i] function_3ecc52d9(params.var_46b70ee6, params.var_f76f8cf6[0]);
				}
			}
		}
		else
		{
			foreach(bot in bots)
			{
				if(strategiccommandutility::isvalidbot(bot))
				{
					params.path = strategiccommandutility::calculatepathtoposition(bot, params.kothzone.gameobject.origin);
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
	Name: function_fb2a81d9
	Namespace: namespace_9b3ab448
	Checksum: 0x4E9BCC38
	Offset: 0x3328
	Size: 0x4C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_fb2a81d9(planner, params)
{
	if(!isdefined(params.kothzone) || !_paramshasbots(params))
	{
		return 2;
	}
	return 1;
}

/*
	Name: function_99cd56f9
	Namespace: namespace_9b3ab448
	Checksum: 0xEBF91B4A
	Offset: 0x3380
	Size: 0x142
	Parameters: 2
	Flags: Linked, Private
*/
function private function_99cd56f9(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(!isdefined(params.kothzone))
	{
		return 2;
	}
	if(!isdefined(params.var_bb5fa5a7) || params.var_bb5fa5a7.size == 0)
	{
		foreach(bot in params.bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				bot setgoal(params.kothzone.trig);
			}
		}
		return 3;
	}
	return function_a702eb04(params, params.kothzone.trig);
}

/*
	Name: function_f3fefad8
	Namespace: namespace_9b3ab448
	Checksum: 0x9C676704
	Offset: 0x34D0
	Size: 0x264
	Parameters: 2
	Flags: Linked, Private
*/
function private function_f3fefad8(planner, constants)
{
	params = spawnstruct();
	sdbomb = planner::getblackboardattribute(planner, "mp_sdBomb");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		if(!isdefined(bots))
		{
			bots = [];
		}
		else if(!isarray(bots))
		{
			bots = array(bots);
		}
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.sdbomb = sdbomb[0][#"__unsafe__"][#"sdbomb"];
	if(isdefined(params.sdbomb))
	{
		foreach(bot in bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				params.path = strategiccommandutility::calculatepathtoposition(bot, params.sdbomb.origin);
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
	Name: function_3235898a
	Namespace: namespace_9b3ab448
	Checksum: 0x60349CFF
	Offset: 0x3740
	Size: 0x172
	Parameters: 2
	Flags: Linked, Private
*/
function private function_3235898a(planner, params)
{
	if(!isdefined(params.sdbomb) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			bot bot::function_6c280dfe();
			goal = params.sdbomb.origin;
			if(!ispointonnavmesh(goal, bot))
			{
				var_1209f27 = getclosesttacpoint(goal);
				if(isdefined(var_1209f27))
				{
					goal = var_1209f27.origin;
				}
			}
			bot setgoal(goal);
			bot.goalradius = 8;
		}
	}
	return 1;
}

/*
	Name: function_94e18e0d
	Namespace: namespace_9b3ab448
	Checksum: 0x11DC0D8E
	Offset: 0x38C0
	Size: 0x156
	Parameters: 2
	Flags: Linked, Private
*/
function private function_94e18e0d(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(isdefined(params.sdbomb))
	{
		if(isdefined(params.bots[0].isbombcarrier) && params.bots[0].isbombcarrier)
		{
			return 1;
		}
		if(!isdefined(params.sdbomb.trigger) || !params.sdbomb.trigger istriggerenabled())
		{
			return 2;
		}
		var_1f2328d0 = params.bots[0] function_4794d6a3();
		if(isdefined(var_1f2328d0) && var_1f2328d0.isatgoal)
		{
			params.sdbomb.trigger useby(params.bots[0]);
		}
		return 3;
	}
	return 2;
}

/*
	Name: function_5b04cb13
	Namespace: namespace_9b3ab448
	Checksum: 0xD2C4D481
	Offset: 0x3A20
	Size: 0x264
	Parameters: 2
	Flags: Linked, Private
*/
function private function_5b04cb13(planner, constants)
{
	params = spawnstruct();
	sdbombzone = planner::getblackboardattribute(planner, "mp_sdBombZones");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		if(!isdefined(bots))
		{
			bots = [];
		}
		else if(!isarray(bots))
		{
			bots = array(bots);
		}
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.sdbombzone = sdbombzone[0][#"__unsafe__"][#"sdbombzone"];
	if(isdefined(params.sdbombzone))
	{
		foreach(bot in bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				params.path = strategiccommandutility::calculatepathtoposition(bot, params.sdbombzone.origin);
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
	Name: function_bb791fc6
	Namespace: namespace_9b3ab448
	Checksum: 0xD00EB1AC
	Offset: 0x3C90
	Size: 0x13C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_bb791fc6(planner, params)
{
	if(!isdefined(params.sdbombzone) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			bot bot::function_6c280dfe();
			goal = params.sdbombzone;
			bot setgoal(goal);
			bot.goalradius = 128;
			bot bot::set_interact(params.sdbombzone);
		}
	}
	return 1;
}

/*
	Name: function_df817333
	Namespace: namespace_9b3ab448
	Checksum: 0x9A3D2BEB
	Offset: 0x3DD8
	Size: 0x4E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_df817333(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(isdefined(params.sdbombzone))
	{
		return 3;
	}
	return 2;
}

/*
	Name: function_f08360d0
	Namespace: namespace_9b3ab448
	Checksum: 0x536A8FD5
	Offset: 0x3E30
	Size: 0x264
	Parameters: 2
	Flags: Linked, Private
*/
function private function_f08360d0(planner, constants)
{
	params = spawnstruct();
	sddefuseobj = planner::getblackboardattribute(planner, "mp_sdDefuseObj");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		if(!isdefined(bots))
		{
			bots = [];
		}
		else if(!isarray(bots))
		{
			bots = array(bots);
		}
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.sddefuseobj = sddefuseobj[0][#"__unsafe__"][#"sddefuseobj"];
	if(isdefined(params.sddefuseobj))
	{
		foreach(bot in bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				params.path = strategiccommandutility::calculatepathtoposition(bot, params.sddefuseobj.origin);
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
	Name: function_e7a81528
	Namespace: namespace_9b3ab448
	Checksum: 0x2C989903
	Offset: 0x40A0
	Size: 0x12C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e7a81528(planner, params)
{
	if(!isdefined(params.sddefuseobj) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			bot bot::function_6c280dfe();
			bot setgoal(params.sddefuseobj);
			bot.goalradius = 128;
			bot bot::set_interact(params.sddefuseobj);
		}
	}
	return 1;
}

/*
	Name: function_fb79f3bd
	Namespace: namespace_9b3ab448
	Checksum: 0xA811939C
	Offset: 0x41D8
	Size: 0x4E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_fb79f3bd(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(isdefined(params.sddefuseobj))
	{
		return 3;
	}
	return 2;
}

/*
	Name: function_458e36c0
	Namespace: namespace_9b3ab448
	Checksum: 0x4FC2665C
	Offset: 0x4230
	Size: 0x43E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_458e36c0(planner, constants)
{
	params = spawnstruct();
	sdbombzone = planner::getblackboardattribute(planner, "mp_sdBombZones");
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		if(!isdefined(bots))
		{
			bots = [];
		}
		else if(!isarray(bots))
		{
			bots = array(bots);
		}
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	params.bots = bots;
	params.sdbombzone = sdbombzone[0][#"__unsafe__"][#"sdbombzone"];
	if(isdefined(params.sdbombzone))
	{
		foreach(bot in bots)
		{
			if(strategiccommandutility::isvalidbot(bot))
			{
				params.path = strategiccommandutility::calculatepathtoposition(bot, params.sdbombzone.origin);
				if(isdefined(params.path))
				{
					break;
				}
			}
		}
	}
	params.regions = [];
	if(!isdefined(params.regions))
	{
		params.regions = [];
	}
	else if(!isarray(params.regions))
	{
		params.regions = array(params.regions);
	}
	params.regions[params.regions.size] = getclosesttacpoint(params.sdbombzone.origin).region;
	var_c1db2604 = function_b507a336(params.regions[0]);
	foreach(neighbor in var_c1db2604.neighbors)
	{
		if(!isdefined(params.regions))
		{
			params.regions = [];
		}
		else if(!isarray(params.regions))
		{
			params.regions = array(params.regions);
		}
		params.regions[params.regions.size] = neighbor;
	}
	return params;
}

/*
	Name: function_4f4ef3b6
	Namespace: namespace_9b3ab448
	Checksum: 0x7EBED205
	Offset: 0x4678
	Size: 0xEC
	Parameters: 2
	Flags: Linked, Private
*/
function private function_4f4ef3b6(planner, params)
{
	if(!isdefined(params.sdbombzone) || !_paramshasbots(params))
	{
		return 2;
	}
	foreach(bot in params.bots)
	{
		if(strategiccommandutility::isvalidbot(bot))
		{
			bot setgoal(params.regions[0]);
		}
	}
	return 1;
}

/*
	Name: function_53882720
	Namespace: namespace_9b3ab448
	Checksum: 0x60DD06B5
	Offset: 0x4770
	Size: 0x5A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_53882720(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(!isdefined(params.sdbombzone))
	{
		return 2;
	}
	return function_3f15f776(params);
}

/*
	Name: function_8c1624c4
	Namespace: namespace_9b3ab448
	Checksum: 0xB778368C
	Offset: 0x47D8
	Size: 0x3F4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8c1624c4(planner, constants)
{
	params = spawnstruct();
	bots = [];
	foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots"))
	{
		if(!isdefined(bots))
		{
			bots = [];
		}
		else if(!isarray(bots))
		{
			bots = array(bots);
		}
		bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
	}
	if(!isdefined(bots[0]) || game.state != "playing")
	{
		return params;
	}
	params.bots = bots;
	params.var_f76f8cf6 = planner::getblackboardattribute(planner, "mp_laneNum");
	/#
		if(bots.size > 1)
		{
			print("");
		}
	#/
	var_79a83b2e = undefined;
	if(isdefined(bots[0].bot.var_f9954cf6))
	{
		var_79a83b2e = bots[0].bot.var_f9954cf6;
		var_f6ce5982 = getclosesttacpoint(bots[0].origin);
		if(isdefined(var_f6ce5982) && isdefined(var_f6ce5982.region))
		{
			var_65733efe = var_f6ce5982.region;
			if(var_65733efe === bots[0].bot.var_f9954cf6)
			{
				var_79a83b2e = undefined;
			}
		}
	}
	if(!isdefined(var_79a83b2e))
	{
		var_ae5ed4e = function_6d153384(bots[0].origin);
		if(isdefined(var_ae5ed4e))
		{
			var_79a83b2e = getclosesttacpoint(var_ae5ed4e).region;
		}
		else
		{
			var_79a83b2e = getclosesttacpoint(bots[0].origin).region;
		}
		bots[0].bot.var_f9954cf6 = var_79a83b2e;
	}
	params.var_46b70ee6 = var_79a83b2e;
	params.var_bb5fa5a7 = [];
	for(i = 0; i < bots.size; i++)
	{
		if(strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i]))
		{
			params.var_bb5fa5a7[i] = bots[i] function_3ecc52d9(params.var_46b70ee6, params.var_f76f8cf6[0]);
		}
	}
	return params;
}

/*
	Name: function_61587057
	Namespace: namespace_9b3ab448
	Checksum: 0xAED690
	Offset: 0x4BD8
	Size: 0x4C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_61587057(planner, params)
{
	if(!isdefined(params.var_bb5fa5a7) || !_paramshasbots(params))
	{
		return 2;
	}
	return 1;
}

/*
	Name: function_6203826a
	Namespace: namespace_9b3ab448
	Checksum: 0x732BE0BD
	Offset: 0x4C30
	Size: 0x192
	Parameters: 2
	Flags: Linked, Private
*/
function private function_6203826a(planner, params)
{
	if(!_paramshasbots(params))
	{
		return 2;
	}
	if(!isdefined(params.var_bb5fa5a7))
	{
		return 2;
	}
	var_d5fcb00b = params;
	for(i = 0; i < var_d5fcb00b.bots.size; i++)
	{
		bot = var_d5fcb00b.bots[i];
		if(strategiccommandutility::isvalidbot(bot) && bot bot::in_combat() && distancesquared(bot.enemy.origin, bot.origin) < 640000)
		{
			var_494658cd = getclosesttacpoint(bot.enemy.origin);
			if(!isdefined(var_494658cd))
			{
				continue;
			}
			bot setgoal(var_494658cd.region);
			var_d5fcb00b.bots[i] = undefined;
		}
	}
	return function_a702eb04(var_d5fcb00b, params.var_46b70ee6);
}

