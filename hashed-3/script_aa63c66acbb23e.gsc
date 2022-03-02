// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_321486e8a7c7176f;
#using script_366ff0bb9cb7adb1;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace strategic_command;

/*
	Name: function_89f2df9
	Namespace: strategic_command
	Checksum: 0xC8BADC5
	Offset: 0x2F8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"strategic_command", &strategiccommandutility::__init__, undefined, undefined);
}

#namespace strategiccommandutility;

/*
	Name: __init__
	Namespace: strategiccommandutility
	Checksum: 0xFC007B6E
	Offset: 0x340
	Size: 0xEC
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	/#
		level thread _debuggameobjects();
		level thread function_f0be958();
		level thread function_1e535a11();
		level thread function_35fd8254();
		level thread function_75df771f();
	#/
	if(!isdefined(level.strategic_command_throttle))
	{
		level.strategic_command_throttle = new throttle();
		[[ level.strategic_command_throttle ]]->initialize(1, float(function_60d95f53()) / 1000);
	}
}

/*
	Name: function_ee3d20f5
	Namespace: strategiccommandutility
	Checksum: 0x67D8970D
	Offset: 0x438
	Size: 0x19E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_ee3d20f5(entity, points)
{
	path = undefined;
	shortestpath = undefined;
	start = entity getclosestpointonnavvolume(entity.origin, 200);
	index = 0;
	while(index < points.size)
	{
		goalpoints = [];
		for(goalindex = index; (goalindex - index) < 16 && goalindex < points.size; goalindex++)
		{
			goalpoints[goalpoints.size] = entity getclosestpointonnavvolume(points[goalindex].origin, 200);
		}
		possiblepath = function_ae7a8634(start, goalpoints, entity);
		if(isdefined(possiblepath) && possiblepath.status === "succeeded")
		{
			if(!isdefined(shortestpath) || possiblepath.pathdistance < shortestpath)
			{
				path = possiblepath;
				shortestpath = possiblepath.pathdistance;
				return path;
			}
		}
		index = index + 16;
	}
	return path;
}

/*
	Name: _calculatepathtopoints
	Namespace: strategiccommandutility
	Checksum: 0xAA3F11B1
	Offset: 0x5E0
	Size: 0x210
	Parameters: 2
	Flags: Linked, Private
*/
function private _calculatepathtopoints(entity, points)
{
	path = undefined;
	shortestpath = undefined;
	var_551173dc = entity getpathfindingradius();
	var_bb52d328 = getclosestpointonnavmesh(entity.origin, 200, var_551173dc);
	index = 0;
	while(index < points.size)
	{
		goalpoints = [];
		for(goalindex = index; (goalindex - index) < 16 && goalindex < points.size; goalindex++)
		{
			if(ispointonnavmesh(points[goalindex].origin, var_551173dc))
			{
				goalpoints[goalpoints.size] = points[goalindex].origin;
			}
		}
		if(isbot(entity))
		{
			possiblepath = generatenavmeshpath(var_bb52d328, goalpoints, entity, undefined, undefined, 5000);
		}
		else
		{
			possiblepath = generatenavmeshpath(var_bb52d328, goalpoints, undefined, undefined, undefined, 5000);
		}
		if(isdefined(possiblepath) && possiblepath.status === "succeeded")
		{
			if(!isdefined(shortestpath) || possiblepath.pathdistance < shortestpath)
			{
				path = possiblepath;
				shortestpath = possiblepath.pathdistance;
			}
		}
		index = index + 16;
	}
	return path;
}

/*
	Name: function_45857dbe
	Namespace: strategiccommandutility
	Checksum: 0x26FB2E4
	Offset: 0x7F8
	Size: 0x150
	Parameters: 1
	Flags: Private
*/
function private function_45857dbe(members)
{
	/#
		var_48fb9acf = 0;
		working = array();
		foreach(member in members)
		{
			entnum = member getentitynumber();
			working[entnum] = member;
			if(entnum > var_48fb9acf)
			{
				var_48fb9acf = entnum;
			}
		}
		sorted = array();
		for(index = 0; index <= var_48fb9acf; index++)
		{
			if(isdefined(working[index]))
			{
				sorted[sorted.size] = working[index];
			}
		}
		return sorted;
	#/
}

/*
	Name: function_65b80a10
	Namespace: strategiccommandutility
	Checksum: 0x34723097
	Offset: 0x958
	Size: 0x1FE
	Parameters: 3
	Flags: Private
*/
function private function_65b80a10(commander, member, vehicle = undefined)
{
	/#
		if(isdefined(vehicle))
		{
			occupant = vehicle getseatoccupant(0);
			if(isplayer(occupant) && !isbot(occupant))
			{
				return "";
			}
			if(isdefined(vehicle.attachedpath))
			{
				return "";
			}
			if(member bot_chain::function_58b429fb())
			{
				return "";
			}
			if(isdefined(commander) && !commander.pause && function_4732f860(member))
			{
				return "";
			}
			if(vehicle.goalforced)
			{
				return "";
			}
		}
		else
		{
			autonomous = ai::getaiattribute(member, "") == "";
			if(function_778568e2(member) || function_e1b87d35(member))
			{
				return "";
			}
			if(autonomous)
			{
				if(member bot_chain::function_58b429fb())
				{
					return "";
				}
				return "";
			}
			if(isdefined(commander) && !commander.pause && isvalidbot(member))
			{
				return "";
			}
		}
		return "";
	#/
}

/*
	Name: function_41c81572
	Namespace: strategiccommandutility
	Checksum: 0xBAE9585C
	Offset: 0xB60
	Size: 0xA6
	Parameters: 1
	Flags: Private
*/
function private function_41c81572(var_78caba27)
{
	/#
		switch(var_78caba27)
		{
			case "hash_3622af976971f417":
			case "spline":
			{
				return (0, 1, 0);
			}
			case "scripted":
			{
				return (1, 0, 0);
			}
			case "commander":
			case "player":
			case "vehicle":
			{
				return (1, 0.5, 0);
			}
		}
		return (1, 0, 0);
	#/
}

/*
	Name: function_741d9796
	Namespace: strategiccommandutility
	Checksum: 0x1C77FCB9
	Offset: 0xC10
	Size: 0x36A
	Parameters: 4
	Flags: Private
*/
function private function_741d9796(member, vehicle, commander, var_78caba27)
{
	/#
		switch(var_78caba27)
		{
			case "hash_3622af976971f417":
			{
				if(isdefined(member.bot.var_53ffa4c4.startstruct))
				{
					return ("" + member.bot.var_53ffa4c4.startstruct.targetname) + "";
				}
			}
			case "commander":
			{
				foreach(squad in commander.squads)
				{
					bots = plannersquadutility::getblackboardattribute(squad, "");
					if(bots.size > 0 && bots[0][#"entnum"] == member getentitynumber())
					{
						target = plannersquadutility::getblackboardattribute(squad, "");
						if(isdefined(target))
						{
							bundle = target[#"__unsafe__"][#"bundle"];
							var_5fbc7570 = target[#"__unsafe__"][#"hash_57b897c5ec9b1b71"];
							if(isdefined(var_5fbc7570))
							{
								return var_5fbc7570.scriptbundlename;
							}
							object = target[#"__unsafe__"][#"object"];
							if(isdefined(object) && isdefined(object.e_object) && isdefined(object.e_object.scriptbundlename))
							{
								return object.e_object.scriptbundlename;
							}
						}
						order = plannersquadutility::getblackboardattribute(squad, "");
						return order;
					}
				}
			}
		}
		if(isdefined(vehicle))
		{
			switch(var_78caba27)
			{
				case "spline":
				{
					return vehicle.attachedpath.targetname;
				}
			}
			return;
		}
		switch(var_78caba27)
		{
			case "vehicle":
			{
				vehicle = member getvehicleoccupied();
				if(isdefined(vehicle))
				{
					return vehicle.vehicleclass;
				}
			}
		}
	#/
}

/*
	Name: function_7c3d768e
	Namespace: strategiccommandutility
	Checksum: 0xE044C527
	Offset: 0xF88
	Size: 0x2BC
	Parameters: 3
	Flags: Private
*/
function private function_7c3d768e(var_1b2a0645, var_d695a79f, commander)
{
	/#
		if(!isdefined(commander))
		{
			return var_d695a79f;
		}
		var_6e868cb7 = 0;
		var_e348a3f4 = 27;
		textcolor = (1, 1, 1);
		textalpha = 1;
		var_48a7a4bd = (0, 0, 0);
		backgroundalpha = 0.8;
		textsize = 1.25;
		team = blackboard::getstructblackboardattribute(commander, #"team");
		paused = isdefined(commander.pause) && commander.pause;
		squadcount = commander.squads.size;
		debug2dtext((var_1b2a0645, var_d695a79f, 0), ("" + function_9e72a96(team)) + "", textcolor, textalpha, var_48a7a4bd, backgroundalpha, textsize);
		var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
		var_d695a79f = var_d695a79f + var_e348a3f4;
		var_1b2a0645 = var_1b2a0645 + 25;
		debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + squadcount, (squadcount == 0 ? (0, 1, 0) : (1, 0.5, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
		var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
		var_d695a79f = var_d695a79f + var_e348a3f4;
		loc_000011DE:
		debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + (paused ? "" : ""), (paused ? (0, 1, 0) : (1, 0.5, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
		var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
		var_d695a79f = var_d695a79f + var_e348a3f4;
	#/
	return var_d695a79f;
}

/*
	Name: function_df74a8f3
	Namespace: strategiccommandutility
	Checksum: 0xCC3609A4
	Offset: 0x1250
	Size: 0xAB0
	Parameters: 4
	Flags: Private
*/
function private function_df74a8f3(var_1b2a0645, var_d695a79f, members, commander)
{
	/#
		var_6e868cb7 = 0;
		var_e348a3f4 = 27;
		textcolor = (1, 1, 1);
		textalpha = 1;
		var_48a7a4bd = (0, 0, 0);
		backgroundalpha = 0.8;
		textsize = 1.25;
		var_4fe31551 = 350;
		var_96e1d277 = 25;
		foreach(member in members)
		{
			yoffset = var_d695a79f;
			debug2dtext((var_1b2a0645, var_d695a79f, 0), (((("" + member getentitynumber()) + "") + member.name) + "") + function_9e72a96(member.team) + "", textcolor, textalpha, var_48a7a4bd, backgroundalpha, textsize);
			var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
			var_d695a79f = var_d695a79f + var_e348a3f4;
			var_1b2a0645 = var_1b2a0645 + var_96e1d277;
			var_78caba27 = function_65b80a10(commander, member);
			loc_000014A2:
			debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + (member isplayinganimscripted() ? "" : ""), (member isplayinganimscripted() ? (1, 0.5, 0) : (0, 1, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
			var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
			var_d695a79f = var_d695a79f + var_e348a3f4;
			debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + var_78caba27, function_41c81572(var_78caba27), textalpha, var_48a7a4bd, backgroundalpha, textsize);
			var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
			var_d695a79f = var_d695a79f + var_e348a3f4;
			var_52cace54 = function_741d9796(member, undefined, commander, var_78caba27);
			if(isdefined(var_52cace54))
			{
				var_1b2a0645 = var_1b2a0645 + var_96e1d277;
				debug2dtext((var_1b2a0645, var_d695a79f, 0), var_52cace54, function_41c81572(var_78caba27), textalpha, var_48a7a4bd, backgroundalpha, textsize);
				var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
				var_d695a79f = var_d695a79f + var_e348a3f4;
				var_1b2a0645 = var_1b2a0645 - var_96e1d277;
			}
			loc_00001652:
			debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + (member.ignoreme ? "" : ""), (member.ignoreme ? (1, 0.5, 0) : (0, 1, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
			var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
			var_d695a79f = var_d695a79f + var_e348a3f4;
			loc_000016EA:
			debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + (member.ignoreall ? "" : ""), (member.ignoreall ? (1, 0.5, 0) : (0, 1, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
			var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
			var_d695a79f = var_d695a79f + var_e348a3f4;
			loc_00001782:
			debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + (member.takedamage ? "" : ""), (member.takedamage ? (0, 1, 0) : (1, 0.5, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
			var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
			var_d695a79f = var_d695a79f + var_e348a3f4;
			var_cf1c1552 = var_d695a79f;
			if(member isinvehicle())
			{
				vehicle = member getvehicleoccupied();
				var_538f88eb = vehicle getoccupantseat(member);
				var_d695a79f = yoffset;
				var_1b2a0645 = var_1b2a0645 + var_4fe31551;
				debug2dtext((var_1b2a0645, var_d695a79f, 0), (((("" + vehicle getentitynumber()) + "") + vehicle.scriptvehicletype) + "") + function_9e72a96(vehicle.team) + "", textcolor, textalpha, var_48a7a4bd, backgroundalpha, textsize);
				var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
				var_d695a79f = var_d695a79f + var_e348a3f4;
				var_1b2a0645 = var_1b2a0645 + var_96e1d277;
				var_78caba27 = function_65b80a10(commander, member, vehicle);
				loc_00001962:
				debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + (vehicle isplayinganimscripted() ? "" : ""), (vehicle isplayinganimscripted() ? (1, 0.5, 0) : (0, 1, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
				var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
				var_d695a79f = var_d695a79f + var_e348a3f4;
				debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + var_78caba27, function_41c81572(var_78caba27), textalpha, var_48a7a4bd, backgroundalpha, textsize);
				var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
				var_d695a79f = var_d695a79f + var_e348a3f4;
				var_52cace54 = function_741d9796(member, vehicle, commander, var_78caba27);
				if(isdefined(var_52cace54))
				{
					var_1b2a0645 = var_1b2a0645 + var_96e1d277;
					debug2dtext((var_1b2a0645, var_d695a79f, 0), var_52cace54, function_41c81572(var_78caba27), textalpha, var_48a7a4bd, backgroundalpha, textsize);
					var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
					var_d695a79f = var_d695a79f + var_e348a3f4;
					var_1b2a0645 = var_1b2a0645 - var_96e1d277;
				}
				loc_00001B1A:
				debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + (vehicle.ignoreme ? "" : ""), (vehicle.ignoreme ? (1, 0.5, 0) : (0, 1, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
				var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
				var_d695a79f = var_d695a79f + var_e348a3f4;
				loc_00001BB2:
				debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + (vehicle.ignoreall ? "" : ""), (vehicle.ignoreall ? (1, 0.5, 0) : (0, 1, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
				var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
				var_d695a79f = var_d695a79f + var_e348a3f4;
				loc_00001C4A:
				debug2dtext((var_1b2a0645, var_d695a79f, 0), "" + (vehicle.takedamage ? "" : ""), (vehicle.takedamage ? (0, 1, 0) : (1, 0.5, 0)), textalpha, var_48a7a4bd, backgroundalpha, textsize);
				var_1b2a0645 = var_1b2a0645 + var_6e868cb7;
				var_d695a79f = var_d695a79f + var_e348a3f4;
				var_d695a79f = var_cf1c1552;
				var_1b2a0645 = var_1b2a0645 - var_4fe31551;
				var_1b2a0645 = var_1b2a0645 - var_96e1d277;
			}
			var_1b2a0645 = var_1b2a0645 - var_96e1d277;
			var_d695a79f = var_d695a79f + 10;
		}
	#/
	return var_d695a79f;
}

/*
	Name: function_75df771f
	Namespace: strategiccommandutility
	Checksum: 0x3DB52D9
	Offset: 0x1D08
	Size: 0x2E2
	Parameters: 0
	Flags: Private
*/
function private function_75df771f()
{
	/#
		xoffset = 150;
		yoffset = 100;
		var_2f7868e6 = 850;
		var_608ee9cd = 50;
		var_f7059c = getdvarint(#"hash_2010e59417406d5f", 0);
		while(true)
		{
			waitframe(1);
			var_f3ac248f = getdvarint(#"hash_2010e59417406d5f", 0);
			if(var_f3ac248f != 0)
			{
				if(!var_f7059c)
				{
					/#
						iprintlnbold("");
					#/
				}
				var_1b2a0645 = xoffset;
				var_d695a79f = yoffset;
				var_6854a979 = 0;
				if(var_f3ac248f != 3)
				{
					var_6854a979 = function_7c3d768e(var_1b2a0645, var_d695a79f, level.var_6e68e2a4);
					var_1b2a0645 = var_1b2a0645 + var_2f7868e6;
				}
				if(var_f3ac248f != 2)
				{
					var_6854a979 = function_7c3d768e(var_1b2a0645, var_d695a79f, level.var_c2ba4b3d);
				}
				var_1b2a0645 = xoffset;
				var_d695a79f = var_6854a979 + var_608ee9cd;
				if(var_f3ac248f != 3)
				{
					allies = function_45857dbe(util::function_517954bb(#"allies"));
					function_df74a8f3(var_1b2a0645, var_d695a79f, allies, level.var_6e68e2a4);
					var_1b2a0645 = var_1b2a0645 + var_2f7868e6;
					var_d695a79f = var_6854a979 + var_608ee9cd;
				}
				if(var_f3ac248f != 2)
				{
					axis = function_45857dbe(util::function_517954bb(#"axis"));
					function_df74a8f3(var_1b2a0645, var_d695a79f, axis, level.var_c2ba4b3d);
				}
			}
			else if(var_f7059c)
			{
				/#
					iprintlnbold("");
				#/
			}
			var_f7059c = getdvarint(#"hash_2010e59417406d5f", 0);
		}
	#/
}

/*
	Name: _debuggameobjects
	Namespace: strategiccommandutility
	Checksum: 0x7706C312
	Offset: 0x1FF8
	Size: 0xD4
	Parameters: 0
	Flags: Private
*/
function private _debuggameobjects()
{
	while(true)
	{
		waitframe(1);
		/#
			if(!getdvarint(#"ai_debuggameobjects", 0) || !isdefined(level.a_gameobjects))
			{
				continue;
			}
			foreach(gameobject in level.a_gameobjects)
			{
				function_3ed19fa3(gameobject);
			}
		#/
	}
}

/*
	Name: function_f0be958
	Namespace: strategiccommandutility
	Checksum: 0xD354ADCD
	Offset: 0x20D8
	Size: 0xAA
	Parameters: 0
	Flags: Private
*/
function private function_f0be958()
{
	/#
		while(true)
		{
			waitframe(1);
			if(!getdvarint(#"hash_1e47802a0e8997e3", 0) || !isdefined(level.var_8239a46c))
			{
				continue;
			}
			for(i = 0; i < level.var_8239a46c.size; i++)
			{
				function_31badd5d(level.var_8239a46c[i], i);
			}
		}
	#/
}

/*
	Name: function_1e535a11
	Namespace: strategiccommandutility
	Checksum: 0x64E61720
	Offset: 0x2190
	Size: 0xAA
	Parameters: 0
	Flags: Private
*/
function private function_1e535a11()
{
	/#
		while(true)
		{
			waitframe(1);
			if(!getdvarint(#"hash_2e02207d5878b8eb", 0) || !isdefined(level.var_6a36223c))
			{
				continue;
			}
			for(i = 0; i < level.var_6a36223c.size; i++)
			{
				function_adb62fbb(level.var_6a36223c[i], i);
			}
		}
	#/
}

/*
	Name: function_31badd5d
	Namespace: strategiccommandutility
	Checksum: 0x36231AAD
	Offset: 0x2248
	Size: 0x5DC
	Parameters: 2
	Flags: Private
*/
function private function_31badd5d(var_5fbc7570, index)
{
	/#
		if(!isdefined(index))
		{
			index = "";
		}
		/#
			origin = var_5fbc7570.origin;
			identifiertext = ((var_5fbc7570.scriptbundlename + "") + index) + "";
			origintext = ((("" + int(origin[0])) + "") + int(origin[1]) + "") + int(origin[2]) + "";
			var_4fea471b = ("" + var_5fbc7570.script_team) + "";
			var_fabc86d6 = "" + (isdefined(var_5fbc7570.var_3093fd62) ? "" : "");
			var_f3fe7e2c = ("" + (isdefined(var_5fbc7570.var_4702e184) ? var_5fbc7570.var_4702e184 : "")) + "";
			var_2aac6b87 = ("" + (isdefined(var_5fbc7570.var_eba32ac6) ? var_5fbc7570.var_eba32ac6 : "")) + "";
			var_7c52e53d = "";
			var_651415fc = (1, 1, 1);
			tacpointtext = "";
			var_31aedcbf = undefined;
			component = var_5fbc7570.var_36f0c06d;
			if(isdefined(component) && var_5fbc7570 flag::get(""))
			{
				var_7c52e53d = "";
				var_651415fc = (0, 1, 0);
				gameobject = component.var_abc3ef9;
				var_41dd65b0 = undefined;
				if(isdefined(gameobject))
				{
					var_41dd65b0 = gameobject.mdl_gameobject.trigger;
					function_3ed19fa3(gameobject.mdl_gameobject);
					recordline(origin, gameobject.mdl_gameobject.origin, var_651415fc, "");
				}
				else
				{
					if(isdefined(component.var_2956bff4))
					{
						var_41dd65b0 = component.var_2956bff4;
						function_20610c3(component.var_2956bff4, var_651415fc, "");
						recordline(origin, component.var_2956bff4.origin, var_651415fc, "");
						record3dtext("", component.var_2956bff4.origin + (vectorscale((0, 0, -1), 5)), var_651415fc, "");
					}
					if(isdefined(component.var_6bc907c4))
					{
						function_20610c3(component.var_6bc907c4, var_651415fc, "");
						recordline(origin, component.var_6bc907c4.origin, var_651415fc, "");
						record3dtext("", component.var_6bc907c4.origin + vectorscale((0, 0, 1), 5), var_651415fc, "");
					}
				}
				if(isdefined(var_41dd65b0))
				{
					points = tacticalquery(#"stratcom_tacquery_trigger", var_41dd65b0);
					tacpointtext = ("" + points.size) + "";
					if(points.size == 0)
					{
						var_31aedcbf = "";
					}
				}
				else if(!isdefined(component.var_6bc907c4))
				{
					var_31aedcbf = "";
				}
			}
			else if(var_5fbc7570 flag::get(""))
			{
				var_7c52e53d = "";
				var_651415fc = vectorscale((1, 1, 1), 0.1);
			}
			textcolor = (isdefined(var_31aedcbf) ? (1, 0, 0) : (1, 1, 1));
			function_15462dcd(origin, textcolor, "", identifiertext, var_7c52e53d, origintext, var_4fea471b, var_fabc86d6, var_f3fe7e2c, var_2aac6b87, tacpointtext, var_31aedcbf);
			recordsphere(origin, 20, var_651415fc);
		#/
	#/
}

/*
	Name: function_3ed19fa3
	Namespace: strategiccommandutility
	Checksum: 0xBF36760B
	Offset: 0x2830
	Size: 0x79C
	Parameters: 2
	Flags: Private
*/
function private function_3ed19fa3(gameobject, position)
{
	/#
		/#
			entnum = gameobject getentitynumber();
			origin = gameobject.origin;
			identifiertext = (((isdefined(gameobject gameobjects::get_identifier()) ? gameobject gameobjects::get_identifier() : "") + "") + entnum) + "";
			var_5f5e2bd5 = ("" + gameobject.type) + "";
			origintext = ((("" + int(origin[0])) + "") + int(origin[1]) + "") + int(origin[2]) + "";
			var_7358fe8e = "";
			var_8de0589e = "";
			var_4fea471b = ("" + function_9e72a96(gameobject.team)) + "";
			var_8dbcaed7 = ("" + (isdefined(gameobject.absolute_visible_and_interact_team) ? function_9e72a96(gameobject.absolute_visible_and_interact_team) : "")) + "";
			tacpointtext = "";
			var_31aedcbf = undefined;
			var_7ddeb599 = "";
			var_bd3388e8 = "";
			var_d8e00365 = "";
			if(isdefined(gameobject.identifier))
			{
				var_d8e00365 = var_d8e00365 + gameobject.identifier;
			}
			var_d8e00365 = var_d8e00365 + "";
			var_ea15be8 = undefined;
			var_da71cc36 = undefined;
			if(isdefined(gameobject.e_object))
			{
				var_7358fe8e = ("" + (isdefined(gameobject.e_object.e_object.targetname) ? gameobject.e_object.targetname : "")) + "";
				if(isdefined(gameobject.e_object.scriptbundlename))
				{
					var_8de0589e = ("" + gameobject.e_object.scriptbundlename) + "";
					var_54f813d6 = getscriptbundle(gameobject.e_object.scriptbundlename);
					if(isdefined(var_54f813d6))
					{
						var_ea15be8 = var_54f813d6.var_4702e184;
						var_da71cc36 = var_54f813d6.var_eba32ac6;
					}
				}
			}
			if(isdefined(gameobject.s_minigame) && isdefined(gameobject.s_minigame.var_ff3c99c5) && isdefined(gameobject.s_minigame.var_ff3c99c5.var_63e8057))
			{
				foreach(location in gameobject.s_minigame.var_ff3c99c5.var_63e8057)
				{
					if(location.mdl_gameobject === gameobject)
					{
						if(isdefined(gameobject.s_minigame.var_4702e184))
						{
							var_ea15be8 = gameobject.s_minigame.var_4702e184;
							var_7ddeb599 = "";
						}
						if(isdefined(gameobject.s_minigame.var_eba32ac6))
						{
							var_da71cc36 = gameobject.s_minigame.var_eba32ac6;
							var_bd3388e8 = "";
						}
						break;
					}
				}
			}
			var_f3fe7e2c = (("" + (isdefined(var_ea15be8) ? var_ea15be8 : "")) + "") + var_7ddeb599;
			var_2aac6b87 = (("" + (isdefined(var_da71cc36) ? var_da71cc36 : "")) + "") + var_bd3388e8;
			var_651415fc = (gameobject.type !== "" ? (1, 1, 1) : vectorscale((1, 1, 1), 0.1));
			if(isdefined(gameobject.trigger) && gameobject.trigger istriggerenabled())
			{
				points = tacticalquery(#"stratcom_tacquery_trigger", gameobject.trigger);
				tacpointtext = ("" + points.size) + "";
				if(points.size == 0)
				{
					var_31aedcbf = "";
				}
				var_651415fc = (0, 1, 1);
				function_20610c3(gameobject.trigger, var_651415fc, "");
				recordline(origin, gameobject.trigger.origin, var_651415fc, "");
				record3dtext("", gameobject.trigger.origin + vectorscale((0, 0, 1), 5), var_651415fc, "");
			}
			textcolor = (isdefined(var_31aedcbf) ? (1, 0, 0) : (1, 1, 1));
			function_15462dcd(origin, textcolor, "", identifiertext, var_5f5e2bd5, var_8de0589e, origintext, var_7358fe8e, var_4fea471b, var_8dbcaed7, var_f3fe7e2c, var_2aac6b87, tacpointtext, var_d8e00365, var_31aedcbf);
			recordsphere(origin, 17, var_651415fc, "");
		#/
	#/
}

/*
	Name: function_adb62fbb
	Namespace: strategiccommandutility
	Checksum: 0x59FC1830
	Offset: 0x2FD8
	Size: 0x2D4
	Parameters: 2
	Flags: Private
*/
function private function_adb62fbb(breadcrumb, index)
{
	/#
		if(!isdefined(index))
		{
			index = "";
		}
		/#
			origin = breadcrumb.origin;
			identifiertext = ("" + index) + "";
			origintext = ((("" + int(origin[0])) + "") + int(origin[1]) + "") + int(origin[2]) + "";
			var_4fea471b = ("" + breadcrumb.script_team) + "";
			var_651415fc = (1, 1, 1);
			tacpointtext = "";
			var_31aedcbf = undefined;
			if(isdefined(breadcrumb.trigger))
			{
				var_651415fc = (1, 1, 0);
				function_20610c3(breadcrumb.trigger, (1, 1, 0), "");
				recordline(origin, breadcrumb.trigger.origin, (1, 1, 0), "");
				record3dtext("", breadcrumb.trigger.origin, (1, 1, 0), "");
				points = tacticalquery(#"stratcom_tacquery_trigger", breadcrumb.trigger);
				tacpointtext = ("" + points.size) + "";
				if(points.size == 0)
				{
					var_31aedcbf = "";
				}
			}
			recordsphere(origin, 14, var_651415fc);
			textcolor = (isdefined(var_31aedcbf) ? (1, 0, 0) : (1, 1, 1));
			function_15462dcd(origin, textcolor, "", identifiertext, origintext, var_4fea471b, tacpointtext, var_31aedcbf);
		#/
	#/
}

/*
	Name: function_15462dcd
	Namespace: strategiccommandutility
	Checksum: 0x6F4B725B
	Offset: 0x32B8
	Size: 0xDC
	Parameters: 4
	Flags: Private, Variadic
*/
function private function_15462dcd(pos, color, channel, vararg)
{
	/#
		/#
			var_3428d894 = "";
			foreach(str in vararg)
			{
				if(!isdefined(str))
				{
					continue;
				}
				var_3428d894 = var_3428d894 + (str + "");
			}
			record3dtext(var_3428d894, pos, color, channel);
		#/
	#/
}

/*
	Name: function_20610c3
	Namespace: strategiccommandutility
	Checksum: 0x9118B9EE
	Offset: 0x33A0
	Size: 0x1B4
	Parameters: 3
	Flags: Private
*/
function private function_20610c3(volume, color, channel)
{
	/#
		/#
			maxs = volume getmaxs();
			mins = volume getmins();
			if(issubstr(volume.classname, ""))
			{
				radius = max(maxs[0], maxs[1]);
				top = volume.origin + (0, 0, maxs[2]);
				bottom = volume.origin + (0, 0, mins[2]);
				recordcircle(bottom, radius, color, channel);
				recordcircle(top, radius, color, channel);
				recordline(bottom, top, color, channel);
			}
			else
			{
				function_af72dbc5(volume.origin, mins, maxs, volume.angles[0], color, channel);
			}
		#/
	#/
}

/*
	Name: function_35fd8254
	Namespace: strategiccommandutility
	Checksum: 0x9E4B77AC
	Offset: 0x3560
	Size: 0x48E
	Parameters: 0
	Flags: Private
*/
function private function_35fd8254()
{
	/#
		while(true)
		{
			if(getdvarint(#"hash_53bff1e7234da64b", 0))
			{
				offset = 30;
				position = (0, 0, 0);
				xoffset = 0;
				yoffset = 10;
				textscale = 0.7;
				var_69548289 = 0;
				if(isdefined(level.var_b3d6ba87))
				{
					var_69548289 = level.var_b3d6ba87.size;
				}
				recordtext("" + var_69548289, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
				yoffset = yoffset + 13;
				assaultobjects = 0;
				defendobjects = 0;
				botcount = 0;
				objectivecount = 0;
				targetcount = 0;
				for(index = 0; index < var_69548289; index++)
				{
					commander = level.var_b3d6ba87[index];
					assaultobjects = assaultobjects + blackboard::getstructblackboardattribute(commander, #"gameobjects_assault").size;
					defendobjects = defendobjects + blackboard::getstructblackboardattribute(commander, #"gameobjects_defend").size;
					botcount = botcount + blackboard::getstructblackboardattribute(commander, #"doppelbots").size;
					objectivecount = objectivecount + blackboard::getstructblackboardattribute(commander, #"objectives").size;
					targetcount = targetcount + commander.var_6365d720;
				}
				xoffset = xoffset + 15;
				recordtext("" + botcount, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
				yoffset = yoffset + 13;
				recordtext("" + objectivecount, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
				yoffset = yoffset + 13;
				recordtext("" + assaultobjects, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
				yoffset = yoffset + 13;
				recordtext("" + defendobjects, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
				yoffset = yoffset + 13;
				recordtext("" + targetcount, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
				yoffset = yoffset + 13;
				yoffset = yoffset + 13;
				xoffset = xoffset - 15;
				squadcount = 0;
				for(index = 0; index < var_69548289; index++)
				{
					commander = level.var_b3d6ba87[index];
					squadcount = squadcount + commander.squads.size;
				}
				recordtext("" + squadcount, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_7712a8e4
	Namespace: strategiccommandutility
	Checksum: 0x6298948
	Offset: 0x39F8
	Size: 0x10A
	Parameters: 5
	Flags: Linked, Private
*/
function private function_7712a8e4(strategy, var_a5bd84a3, var_48ce643a, doppelbots = 1, companions = 1)
{
	/#
		assert(isdefined(strategy));
	#/
	var_c4c7d0bc = strategy.(var_a5bd84a3) === 1;
	var_3b9048 = var_c4c7d0bc;
	if(strategy.("customizecompanions") === 1)
	{
		var_3b9048 = strategy.(var_48ce643a) === 1;
	}
	if(doppelbots && companions)
	{
		return var_c4c7d0bc && var_3b9048;
	}
	if(doppelbots)
	{
		return var_c4c7d0bc;
	}
	if(companions)
	{
		return var_3b9048;
	}
	return 0;
}

/*
	Name: function_700c578d
	Namespace: strategiccommandutility
	Checksum: 0x1997EF46
	Offset: 0x3B10
	Size: 0x2C8
	Parameters: 1
	Flags: Linked
*/
function function_700c578d(bundle)
{
	/#
		assert(isdefined(bundle));
	#/
	var_389ef689 = spawnstruct();
	/#
		var_389ef689.name = bundle.name;
	#/
	var_6da809dc = array("doppelbotsignore", "doppelbotsallowair", "doppelbotsallowground", "doppelbotspriority", "doppelbotstactics", "doppelbotsfocus", "doppelbotsinteractions", "doppelbotsdistribution");
	var_e3e0ebe5 = array("companionsignore", "companionsallowair", "companionsallowground", "companionspriority", "companionstactics", "companionsfocus", "companionsinteractions", "companionsdistribution");
	foreach(kvp in var_6da809dc)
	{
		if(!isdefined(bundle.(kvp)))
		{
			var_389ef689.(kvp) = 0;
			continue;
		}
		var_389ef689.(kvp) = bundle.(kvp);
	}
	if(bundle.("customizecompanions") === 1)
	{
		for(index = 0; index < var_e3e0ebe5.size; index++)
		{
			kvp = var_e3e0ebe5[index];
			if(!isdefined(bundle.(kvp)))
			{
				var_389ef689.(kvp) = 0;
				continue;
			}
			if(bundle.(kvp) === "inherit from doppelbot")
			{
				var_389ef689.(kvp) = var_389ef689.(var_6da809dc[index]);
				continue;
			}
			var_389ef689.(kvp) = bundle.(kvp);
		}
	}
	else
	{
		for(index = 0; index < var_e3e0ebe5.size; index++)
		{
			kvp = var_e3e0ebe5[index];
			var_389ef689.(kvp) = var_389ef689.(var_6da809dc[index]);
		}
	}
	return var_389ef689;
}

/*
	Name: function_2cce6a82
	Namespace: strategiccommandutility
	Checksum: 0x63CB6474
	Offset: 0x3DE0
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_2cce6a82(entity, bundle)
{
	/#
		assert(isdefined(bundle));
	#/
	if(!function_9ab82e4f(entity))
	{
		return;
	}
	if(bundle.m_str_type == "escortbiped")
	{
		if(!isdefined(bundle.var_27726d51))
		{
			return;
		}
		if(entity === bundle.var_27726d51)
		{
			return calculatepathtoposition(entity, entity.goalpos);
		}
		return calculatepathtoposition(entity, bundle.var_27726d51.origin);
	}
}

/*
	Name: function_704d5fbd
	Namespace: strategiccommandutility
	Checksum: 0x4DAD5056
	Offset: 0x3EB8
	Size: 0x11A
	Parameters: 2
	Flags: Linked
*/
function function_704d5fbd(bot, component)
{
	/#
		assert(isdefined(component));
	#/
	if(!function_9ab82e4f(bot))
	{
		return;
	}
	switch(component.m_str_type)
	{
		case "goto":
		{
			break;
		}
		case "destroy":
		case "defend":
		{
			if(function_778568e2(bot))
			{
				return calculatepathtotrigger(bot, component.var_6bc907c4);
			}
			else
			{
				return calculatepathtotrigger(bot, component.var_2956bff4);
			}
			break;
		}
		case "capturearea":
		{
			return calculatepathtotrigger(bot, component.var_cc67d976);
		}
	}
}

/*
	Name: calculatepathtogameobject
	Namespace: strategiccommandutility
	Checksum: 0xF0CEB9FC
	Offset: 0x3FE0
	Size: 0x132
	Parameters: 2
	Flags: Linked
*/
function calculatepathtogameobject(bot, gameobject)
{
	/#
		assert(isdefined(gameobject));
	#/
	if(!function_9ab82e4f(bot))
	{
		return;
	}
	if(function_778568e2(bot))
	{
		return calculatepathtotrigger(bot, gameobject.trigger);
	}
	var_e61f062b = bot getpathfindingradius();
	botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);
	if(!isdefined(botposition))
	{
		return;
	}
	points = querypointsaroundgameobject(bot, gameobject);
	if(!isdefined(points) || points.size <= 0)
	{
		return;
	}
	return _calculatepathtopoints(bot, points);
}

/*
	Name: function_71866d71
	Namespace: strategiccommandutility
	Checksum: 0x37A145F5
	Offset: 0x4120
	Size: 0xBA
	Parameters: 2
	Flags: None
*/
function function_71866d71(bot, breadcrumb)
{
	/#
		assert(isdefined(breadcrumb));
	#/
	if(!function_9ab82e4f(bot))
	{
		return;
	}
	var_e61f062b = bot getpathfindingradius();
	botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);
	if(!isdefined(botposition))
	{
		return;
	}
	return calculatepathtotrigger(bot, breadcrumb.trigger);
}

/*
	Name: calculatepathtoobjective
	Namespace: strategiccommandutility
	Checksum: 0x7C8305C2
	Offset: 0x41E8
	Size: 0x19A
	Parameters: 2
	Flags: Linked
*/
function calculatepathtoobjective(bot, objective)
{
	/#
		assert(isdefined(objective));
	#/
	if(!function_9ab82e4f(bot))
	{
		return;
	}
	inair = function_778568e2(bot);
	vehicle = undefined;
	if(inair)
	{
		vehicle = bot getvehicleoccupied();
		botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
	}
	else
	{
		var_e61f062b = bot getpathfindingradius();
		botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);
	}
	if(!isdefined(botposition))
	{
		return;
	}
	points = querypointsinsideobjective(bot, objective);
	if(!isdefined(points) || points.size <= 0)
	{
		return;
	}
	if(inair)
	{
		return function_ee3d20f5(vehicle, points);
	}
	return _calculatepathtopoints(bot, points);
}

/*
	Name: calculatepathtopoints
	Namespace: strategiccommandutility
	Checksum: 0x44F3C3BB
	Offset: 0x4390
	Size: 0xD2
	Parameters: 2
	Flags: Linked
*/
function calculatepathtopoints(bot, points)
{
	/#
		assert(isdefined(points));
	#/
	if(!function_9ab82e4f(bot))
	{
		return;
	}
	var_e61f062b = bot getpathfindingradius();
	botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);
	if(!isdefined(botposition))
	{
		return;
	}
	if(!isdefined(points) || points.size <= 0)
	{
		return;
	}
	return _calculatepathtopoints(bot, points);
}

/*
	Name: calculatepathtoposition
	Namespace: strategiccommandutility
	Checksum: 0x81A2C116
	Offset: 0x4470
	Size: 0x132
	Parameters: 4
	Flags: Linked
*/
function calculatepathtoposition(entity, position, radius = 200, halfheight = 100)
{
	/#
		assert(isdefined(position));
	#/
	if(!function_9ab82e4f(entity))
	{
		return;
	}
	var_e61f062b = entity getpathfindingradius();
	botposition = getclosestpointonnavmesh(entity.origin, 200, var_e61f062b);
	if(!isdefined(botposition))
	{
		return;
	}
	points = querypointsinsideposition(entity, position, radius, halfheight);
	if(!isdefined(points) || points.size <= 0)
	{
		return;
	}
	return _calculatepathtopoints(entity, points);
}

/*
	Name: calculatepathtotrigger
	Namespace: strategiccommandutility
	Checksum: 0x56738F77
	Offset: 0x45B0
	Size: 0x182
	Parameters: 2
	Flags: Linked
*/
function calculatepathtotrigger(bot, trigger)
{
	if(!isdefined(trigger))
	{
		return;
	}
	if(!function_9ab82e4f(bot))
	{
		return;
	}
	inair = function_778568e2(bot);
	vehicle = undefined;
	if(inair)
	{
		vehicle = bot getvehicleoccupied();
		botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
	}
	else
	{
		var_e61f062b = bot getpathfindingradius();
		botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);
	}
	if(!isdefined(botposition))
	{
		return;
	}
	points = querypointsinsidetrigger(bot, trigger);
	if(!isdefined(points) || points.size <= 0)
	{
		return;
	}
	if(inair)
	{
		return function_ee3d20f5(vehicle, points);
	}
	return _calculatepathtopoints(bot, points);
}

/*
	Name: function_e696ce55
	Namespace: strategiccommandutility
	Checksum: 0x13D83F11
	Offset: 0x4740
	Size: 0x182
	Parameters: 2
	Flags: Linked
*/
function function_e696ce55(bot, trigger)
{
	if(!isdefined(trigger))
	{
		return;
	}
	if(!function_9ab82e4f(bot))
	{
		return;
	}
	inair = function_778568e2(bot);
	vehicle = undefined;
	if(inair)
	{
		vehicle = bot getvehicleoccupied();
		botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
	}
	else
	{
		var_e61f062b = bot getpathfindingradius();
		botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);
	}
	if(!isdefined(botposition))
	{
		return;
	}
	points = function_210f00bf(bot, trigger);
	if(!isdefined(points) || points.size <= 0)
	{
		return;
	}
	if(inair)
	{
		return function_ee3d20f5(vehicle, points);
	}
	return _calculatepathtopoints(bot, points);
}

/*
	Name: calculateprogressrushing
	Namespace: strategiccommandutility
	Checksum: 0xC7179080
	Offset: 0x48D0
	Size: 0x13C
	Parameters: 6
	Flags: Linked
*/
function calculateprogressrushing(lowerboundpercentile, upperboundpercentile, destroyedobjects, totalobjects, enemydestroyedobjects, enemytotalobjects)
{
	if(enemytotalobjects <= 0)
	{
		return 0;
	}
	if(totalobjects <= 0)
	{
		return 0;
	}
	gameobjectcost = 1 / totalobjects;
	enemygameobjectcost = 1 / enemytotalobjects;
	currentgameobjectcost = min(gameobjectcost * destroyedobjects, 1);
	currentenemygameobjectcost = min(enemygameobjectcost * enemydestroyedobjects, 1);
	return (max(min(lowerboundpercentile + currentenemygameobjectcost, 1), 0)) > (max(min(gameobjectcost + currentgameobjectcost, 1), 0));
}

/*
	Name: calculateprogressthrottling
	Namespace: strategiccommandutility
	Checksum: 0x501668A4
	Offset: 0x4A18
	Size: 0x144
	Parameters: 6
	Flags: Linked
*/
function calculateprogressthrottling(lowerboundpercentile, upperboundpercentile, destroyedobjects, totalobjects, enemydestroyedobjects, enemytotalobjects)
{
	if(enemytotalobjects <= 0)
	{
		return 1;
	}
	if(totalobjects <= 0)
	{
		return 0;
	}
	gameobjectcost = 1 / totalobjects;
	enemygameobjectcost = 1 / enemytotalobjects;
	currentgameobjectcost = min(gameobjectcost * destroyedobjects, 1);
	currentenemygameobjectcost = min(enemygameobjectcost * enemydestroyedobjects, 1);
	return (max(min(upperboundpercentile + currentenemygameobjectcost, 1), 0)) < (max(min(gameobjectcost + currentgameobjectcost, 1), 0));
}

/*
	Name: function_1e3c1b91
	Namespace: strategiccommandutility
	Checksum: 0x82EAE158
	Offset: 0x4B68
	Size: 0x340
	Parameters: 2
	Flags: Linked
*/
function function_1e3c1b91(var_b7f15515, var_5e513205)
{
	/#
		assert(isdefined(var_b7f15515));
	#/
	/#
		assert(isdefined(var_5e513205));
	#/
	var_389ef689 = spawnstruct();
	var_6da809dc = array("doppelbotsignore", "doppelbotsallowair", "doppelbotsallowground", "doppelbotspriority", "doppelbotstactics", "doppelbotsfocus", "doppelbotsinteractions", "doppelbotsdistribution");
	var_e3e0ebe5 = array("companionsignore", "companionsallowair", "companionsallowground", "companionspriority", "companionstactics", "companionsfocus", "companionsinteractions", "companionsdistribution");
	/#
		assert(var_6da809dc.size == var_e3e0ebe5.size);
	#/
	foreach(kvp in var_6da809dc)
	{
		if(!isdefined(var_5e513205.(kvp)) || var_5e513205.(kvp) === #"hash_13275474a58f1175")
		{
			if(!isdefined(var_b7f15515.(kvp)))
			{
				var_389ef689.(kvp) = 0;
			}
			else
			{
				var_389ef689.(kvp) = var_b7f15515.(kvp);
			}
			continue;
		}
		var_389ef689.(kvp) = var_5e513205.(kvp);
	}
	if(var_5e513205.("customizecompanions") === 1)
	{
		for(index = 0; index < var_e3e0ebe5.size; index++)
		{
			kvp = var_e3e0ebe5[index];
			if(!isdefined(var_5e513205.(kvp)))
			{
				var_389ef689.(kvp) = 0;
				continue;
			}
			if(var_5e513205.(kvp) === "inherit from doppelbot")
			{
				var_389ef689.(kvp) = var_389ef689.(var_6da809dc[index]);
				continue;
			}
			var_389ef689.(kvp) = var_5e513205.(kvp);
		}
	}
	else
	{
		for(index = 0; index < var_e3e0ebe5.size; index++)
		{
			kvp = var_e3e0ebe5[index];
			var_389ef689.(kvp) = var_389ef689.(var_6da809dc[index]);
		}
	}
	return var_389ef689;
}

/*
	Name: function_423cfbc1
	Namespace: strategiccommandutility
	Checksum: 0x97016D6E
	Offset: 0x4EB0
	Size: 0x532
	Parameters: 4
	Flags: Linked
*/
function function_423cfbc1(side, var_ebfc3fac = undefined, var_5fbc7570 = undefined, gameobject = undefined)
{
	/#
		assert(isstring(side));
	#/
	strategy = function_d077c2b6(side);
	if(!isdefined(strategy))
	{
		function_1852d313(#"default_strategicbundle", side);
		strategy = function_d077c2b6(side);
	}
	/#
		sdebug = [0:"" + strategy.name];
	#/
	strategy = function_1e3c1b91(strategy, strategy);
	if(isdefined(var_ebfc3fac))
	{
		var_f57f0f3f = var_ebfc3fac.("scriptbundle_strategy_" + side);
		if(isdefined(var_f57f0f3f))
		{
			strategy = function_1e3c1b91(strategy, getscriptbundle(var_f57f0f3f));
		}
		/#
			sdebug[sdebug.size] = (((var_ebfc3fac.type + "") + var_ebfc3fac.name) + "") + (isdefined(var_f57f0f3f) ? var_f57f0f3f : "");
		#/
	}
	if(isdefined(var_5fbc7570))
	{
		var_e763ef0b = var_5fbc7570.("scriptbundle_strategy_" + side);
		if(isdefined(var_e763ef0b))
		{
			strategy = function_1e3c1b91(strategy, getscriptbundle(var_e763ef0b));
		}
		/#
			sdebug[sdebug.size] = (var_5fbc7570.scriptbundlename + "") + (isdefined(var_e763ef0b) ? var_e763ef0b : "");
		#/
	}
	if(isdefined(gameobject))
	{
		var_3bb544aa = 0;
		if(isdefined(gameobject.s_minigame) && isdefined(gameobject.s_minigame.var_ff3c99c5) && isdefined(gameobject.s_minigame.var_ff3c99c5.var_63e8057))
		{
			foreach(location in gameobject.s_minigame.var_ff3c99c5.var_63e8057)
			{
				if(location.mdl_gameobject === gameobject)
				{
					var_3bb544aa = 1;
					var_1c9cd543 = gameobject.s_minigame.("scriptbundle_strategy_" + side);
					if(isdefined(var_1c9cd543))
					{
						strategy = function_1e3c1b91(strategy, getscriptbundle(var_1c9cd543));
					}
				}
				/#
					sdebug[sdebug.size] = (("" + gameobject getentitynumber()) + "") + (isdefined(var_1c9cd543) ? var_1c9cd543 : "") + "";
				#/
				break;
			}
		}
		if(!var_3bb544aa && isdefined(gameobject.e_object) && isdefined(gameobject.e_object.scriptbundlename))
		{
			var_54f813d6 = getscriptbundle(gameobject.e_object.scriptbundlename);
			if(isdefined(var_54f813d6))
			{
				var_1c9cd543 = var_54f813d6.("scriptbundle_strategy_" + side);
				if(isdefined(var_1c9cd543))
				{
					strategy = function_1e3c1b91(strategy, getscriptbundle(var_1c9cd543));
				}
			}
			/#
				sdebug[sdebug.size] = (("" + gameobject getentitynumber()) + "") + (isdefined(var_1c9cd543) ? var_1c9cd543 : "");
			#/
		}
	}
	/#
		strategy.sdebug = sdebug;
	#/
	return strategy;
}

/*
	Name: function_4b0c469d
	Namespace: strategiccommandutility
	Checksum: 0xE0B61343
	Offset: 0x53F0
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function function_4b0c469d(vehicle)
{
	/#
		assert(isdefined(vehicle) && isvehicle(vehicle));
	#/
	switch(vehicle.vehicleclass)
	{
		case "helicopter":
		{
			return "air";
		}
		case "hash_533cea8e2a687ac8":
		{
			return "ground";
		}
	}
	return "ground";
}

/*
	Name: canattackgameobject
	Namespace: strategiccommandutility
	Checksum: 0x3D1A48D5
	Offset: 0x5490
	Size: 0x96
	Parameters: 2
	Flags: None
*/
function canattackgameobject(team, gameobject)
{
	return gameobject.team == team && gameobject.interactteam == #"friendly" || (gameobject.team != team && gameobject.interactteam == #"enemy") || gameobject.absolute_visible_and_interact_team === team;
}

/*
	Name: candefendgameobject
	Namespace: strategiccommandutility
	Checksum: 0xD4702315
	Offset: 0x5530
	Size: 0x80
	Parameters: 2
	Flags: None
*/
function candefendgameobject(team, gameobject)
{
	return gameobject.team == team && gameobject.interactteam == #"enemy" || (gameobject.team != team && gameobject.interactteam == #"friendly");
}

/*
	Name: function_a1edb007
	Namespace: strategiccommandutility
	Checksum: 0xD26ED468
	Offset: 0x55B8
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_a1edb007(team)
{
	var_832340f2 = "sideA";
	if(util::get_team_mapping("sidea") !== team)
	{
		var_832340f2 = "sideB";
	}
	return var_832340f2;
}

/*
	Name: function_5c2c9542
	Namespace: strategiccommandutility
	Checksum: 0x8784D1D1
	Offset: 0x5610
	Size: 0xCA
	Parameters: 2
	Flags: Linked
*/
function function_5c2c9542(entity, component)
{
	/#
		assert(isdefined(entity));
	#/
	/#
		assert(isdefined(component));
	#/
	switch(component.m_str_type)
	{
		case "destroy":
		case "defend":
		{
			if(function_778568e2(entity))
			{
				return component.var_6bc907c4;
			}
			return component.var_2956bff4;
		}
		case "capturearea":
		{
			return component.var_cc67d976;
		}
	}
}

/*
	Name: function_45c5edc6
	Namespace: strategiccommandutility
	Checksum: 0xBEF8D570
	Offset: 0x56E8
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_45c5edc6(side)
{
	/#
		assert(isdefined(side));
	#/
	if(!isdefined(level.var_2731863e))
	{
		level.var_2731863e = [];
	}
	else if(!isarray(level.var_2731863e))
	{
		level.var_2731863e = array(level.var_2731863e);
	}
	return level.var_2731863e[side];
}

/*
	Name: function_d077c2b6
	Namespace: strategiccommandutility
	Checksum: 0x6E89F690
	Offset: 0x5790
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_d077c2b6(side)
{
	/#
		assert(isdefined(side));
	#/
	if(!isdefined(level.var_aca184cd))
	{
		level.var_aca184cd = [];
	}
	else if(!isarray(level.var_aca184cd))
	{
		level.var_aca184cd = array(level.var_aca184cd);
	}
	return level.var_aca184cd[side];
}

/*
	Name: function_a0f88aca
	Namespace: strategiccommandutility
	Checksum: 0x2F6FF9FB
	Offset: 0x5838
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function function_a0f88aca(gpbundle, team)
{
	var_832340f2 = function_a1edb007(team);
	return gpbundle.var_96f00c9f == var_832340f2 || gpbundle.var_96f00c9f == team;
}

/*
	Name: function_778568e2
	Namespace: strategiccommandutility
	Checksum: 0x717D74CB
	Offset: 0x58A0
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_778568e2(entity)
{
	if(entity isinvehicle())
	{
		vehicle = entity getvehicleoccupied();
		return function_4b0c469d(vehicle) == "air";
	}
	return 0;
}

/*
	Name: function_e1b87d35
	Namespace: strategiccommandutility
	Checksum: 0x183495E
	Offset: 0x5910
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function function_e1b87d35(entity)
{
	if(entity isinvehicle())
	{
		vehicle = entity getvehicleoccupied();
		return function_4b0c469d(vehicle) == "ground";
	}
	return 0;
}

/*
	Name: function_9ab82e4f
	Namespace: strategiccommandutility
	Checksum: 0x7CB3534
	Offset: 0x5980
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function function_9ab82e4f(entity)
{
	if(isactor(entity))
	{
		return isalive(entity);
	}
	return isvalidbotorplayer(entity);
}

/*
	Name: isvalidbotorplayer
	Namespace: strategiccommandutility
	Checksum: 0x4BB316A5
	Offset: 0x59E0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function isvalidbotorplayer(client)
{
	return isvalidbot(client) || isvalidplayer(client);
}

/*
	Name: isvalidbot
	Namespace: strategiccommandutility
	Checksum: 0x866491EF
	Offset: 0x5A28
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function isvalidbot(bot)
{
	return isdefined(bot) && isbot(bot) && bot bot::initialized() && !bot isplayinganimscripted() && ai::getaiattribute(bot, "control") === "commander" && bot bot::function_343d7ef4();
}

/*
	Name: function_4732f860
	Namespace: strategiccommandutility
	Checksum: 0x185EEDFF
	Offset: 0x5AD0
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function function_4732f860(bot)
{
	if(bot isinvehicle())
	{
		vehicle = bot getvehicleoccupied();
		var_538f88eb = vehicle getoccupantseat(bot);
		return var_538f88eb == 0 && !isdefined(vehicle.attachedpath);
	}
	return 0;
}

/*
	Name: function_208c970d
	Namespace: strategiccommandutility
	Checksum: 0xA6D9FEFD
	Offset: 0x5B60
	Size: 0x166
	Parameters: 2
	Flags: Linked
*/
function function_208c970d(gpbundle, var_832340f2)
{
	team = util::get_team_mapping(var_832340f2);
	bundle = gpbundle.o_gpbundle;
	if(!isdefined(bundle))
	{
		return false;
	}
	if(!(bundle.var_96f00c9f === var_832340f2 || bundle.var_96f00c9f === team || (bundle.var_eb371c04 === var_832340f2 || bundle.var_eb371c04 === team)))
	{
		return false;
	}
	if(!bundle flag::get("bundle_initialized"))
	{
		return false;
	}
	type = gpbundle.classname;
	switch(type)
	{
		case "hash_1c67b29f3576b10d":
		{
			if(!isdefined(bundle.var_27726d51))
			{
				return false;
			}
			if(!isdefined(bundle.var_27726d51.mdl_gameobject))
			{
				return false;
			}
			break;
		}
		default:
		{
			return false;
		}
	}
	return true;
}

/*
	Name: isvalidplayer
	Namespace: strategiccommandutility
	Checksum: 0xF03E7F17
	Offset: 0x5CD0
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function isvalidplayer(client)
{
	return isdefined(client) && !isbot(client) && isplayer(client) && !client isinmovemode("ufo", "noclip");
}

/*
	Name: function_f867cce0
	Namespace: strategiccommandutility
	Checksum: 0x142565A2
	Offset: 0x5D48
	Size: 0x1C6
	Parameters: 2
	Flags: Linked
*/
function function_f867cce0(var_5fbc7570, commanderteam)
{
	component = var_5fbc7570.var_36f0c06d;
	/#
		assert(commanderteam == #"any" || commanderteam == #"allies" || commanderteam == #"axis", ("" + commanderteam) + "");
	#/
	if(!isdefined(component))
	{
		return false;
	}
	if(!var_5fbc7570 flag::get("enabled"))
	{
		return false;
	}
	if(var_5fbc7570 flag::get("complete"))
	{
		return false;
	}
	if(component.m_str_team !== commanderteam && component.m_str_team != #"any")
	{
		if(!isdefined(var_5fbc7570.var_3093fd62) || var_5fbc7570.var_3093fd62 == 0)
		{
			return false;
		}
	}
	type = var_5fbc7570.scriptbundlename;
	switch(type)
	{
		case "hash_6e9081699001bcd9":
		{
			break;
		}
		case "hash_3bf68fbcb5c53b6c":
		{
			break;
		}
		case "hash_4984fd4b0ba666a2":
		{
			break;
		}
		default:
		{
			return false;
		}
	}
	return true;
}

/*
	Name: querypointsaroundgameobject
	Namespace: strategiccommandutility
	Checksum: 0xBF0D3E4D
	Offset: 0x5F18
	Size: 0x16C
	Parameters: 2
	Flags: Linked
*/
function querypointsaroundgameobject(bot, gameobject)
{
	/#
		assert(isdefined(gameobject));
	#/
	if(!function_9ab82e4f(bot))
	{
		return;
	}
	points = array();
	if(isdefined(gameobject) && isdefined(gameobject.trigger))
	{
		points = tacticalquery(#"stratcom_tacquery_gameobject", gameobject.trigger);
	}
	/#
		if(getdvarint(#"ai_debugsquadpointquery", 0))
		{
			foreach(point in points)
			{
				recordstar(point.origin, (1, 0.5, 0), "");
			}
		}
	#/
	return points;
}

/*
	Name: querypointsinsideobjective
	Namespace: strategiccommandutility
	Checksum: 0x5D6DFABA
	Offset: 0x6090
	Size: 0x244
	Parameters: 2
	Flags: Linked
*/
function querypointsinsideobjective(bot, trigger)
{
	/#
		assert(isdefined(trigger));
	#/
	if(!function_9ab82e4f(bot))
	{
		return [];
	}
	points = [];
	if(function_778568e2(bot))
	{
		vehicle = bot getvehicleoccupied();
		botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
		radius = distance2d(trigger.maxs, (0, 0, 0));
		query = positionquery_source_navigation(trigger.origin, 0, radius, trigger.maxs[2], 100, vehicle);
		if(isdefined(query) && isdefined(query.data))
		{
			points = query.data;
		}
	}
	else
	{
		points = tacticalquery(#"stratcom_tacquery_objective", trigger);
		/#
			if(getdvarint(#"ai_debugsquadpointquery", 0))
			{
				foreach(point in points)
				{
					recordstar(point.origin, (1, 0.5, 0), "");
				}
			}
		#/
	}
	return points;
}

/*
	Name: querypointsinsideposition
	Namespace: strategiccommandutility
	Checksum: 0xC460DFB4
	Offset: 0x62E0
	Size: 0x16C
	Parameters: 4
	Flags: Linked
*/
function querypointsinsideposition(bot, position, radius, halfheight)
{
	/#
		assert(isdefined(position));
	#/
	if(!function_9ab82e4f(bot))
	{
		return [];
	}
	cylinder = ai::t_cylinder(position, radius, halfheight);
	points = tacticalquery(#"stratcom_tacquery_position", cylinder);
	/#
		if(getdvarint(#"ai_debugsquadpointquery", 0))
		{
			foreach(point in points)
			{
				recordstar(point.origin, (1, 0.5, 0), "");
			}
		}
	#/
	return points;
}

/*
	Name: function_1891d0d2
	Namespace: strategiccommandutility
	Checksum: 0x950485EA
	Offset: 0x6458
	Size: 0x158
	Parameters: 2
	Flags: Private
*/
function private function_1891d0d2(points, var_75ae35a4)
{
	/#
		var_2586092e = 50;
		for(var_c2a08848 = 0; var_c2a08848 < var_2586092e; var_c2a08848++)
		{
			if(getdvarint(#"ai_debugsquadpointquery", 0))
			{
				function_af72dbc5(var_75ae35a4.center, var_75ae35a4.halfsize * -1, var_75ae35a4.halfsize, var_75ae35a4.angles[1], (0, 1, 0), "");
				foreach(point in points)
				{
					recordstar(point.origin, (1, 0.5, 0), "");
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: querypointsinsidetrigger
	Namespace: strategiccommandutility
	Checksum: 0x84D9EC3D
	Offset: 0x65B8
	Size: 0x1C8
	Parameters: 2
	Flags: Linked
*/
function querypointsinsidetrigger(bot, trigger)
{
	/#
		assert(isdefined(trigger));
	#/
	if(!function_9ab82e4f(bot))
	{
		return [];
	}
	points = [];
	if(function_778568e2(bot))
	{
		vehicle = bot getvehicleoccupied();
		botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
		radius = distance2d(trigger.maxs, (0, 0, 0));
		query = positionquery_source_navigation(trigger.origin, 0, radius, trigger.maxs[2], 100, vehicle);
		if(isdefined(query) && isdefined(query.data))
		{
			points = query.data;
		}
	}
	else
	{
		var_75ae35a4 = bot bot::function_f0c35734(trigger);
		points = tacticalquery(#"stratcom_tacquery_trigger", var_75ae35a4);
		/#
			level thread function_1891d0d2(points, var_75ae35a4);
		#/
	}
	return points;
}

/*
	Name: function_210f00bf
	Namespace: strategiccommandutility
	Checksum: 0xD4445DCE
	Offset: 0x6788
	Size: 0x100
	Parameters: 2
	Flags: Linked
*/
function function_210f00bf(bot, trigger)
{
	/#
		assert(isdefined(trigger));
	#/
	if(!function_9ab82e4f(bot))
	{
		return [];
	}
	points = [];
	if(function_778568e2(bot))
	{
		/#
			assert(0, "");
		#/
	}
	else
	{
		var_75ae35a4 = bot bot::function_52947b70(trigger);
		points = tacticalquery(#"stratcom_tacquery_trigger", var_75ae35a4);
		/#
			level thread function_1891d0d2(points, var_75ae35a4);
		#/
	}
	return points;
}

/*
	Name: function_ba05bd2
	Namespace: strategiccommandutility
	Checksum: 0x263DEE8F
	Offset: 0x6890
	Size: 0xF4
	Parameters: 2
	Flags: None
*/
function function_ba05bd2(strategicbundle, side)
{
	/#
		assert(isdefined(side));
	#/
	if(!isdefined(level.var_2731863e))
	{
		level.var_2731863e = [];
	}
	else if(!isarray(level.var_2731863e))
	{
		level.var_2731863e = array(level.var_2731863e);
	}
	strategy = getscriptbundle(strategicbundle);
	if(isdefined(strategy) && isdefined(side))
	{
		level.var_2731863e[side] = strategicbundle;
		function_1852d313(strategicbundle, side);
	}
}

/*
	Name: function_3837a75d
	Namespace: strategiccommandutility
	Checksum: 0x50B52F2A
	Offset: 0x6990
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_3837a75d(side)
{
	/#
		assert(isdefined(side));
	#/
	if(isdefined(level.var_2731863e) && isdefined(level.var_2731863e[side]))
	{
		function_1852d313(level.var_2731863e[side], side);
	}
}

/*
	Name: function_1852d313
	Namespace: strategiccommandutility
	Checksum: 0xDC471F9F
	Offset: 0x6A10
	Size: 0xEE
	Parameters: 2
	Flags: Linked
*/
function function_1852d313(strategicbundle, side)
{
	/#
		assert(isdefined(side));
	#/
	if(!isdefined(level.var_aca184cd))
	{
		level.var_aca184cd = [];
	}
	else if(!isarray(level.var_aca184cd))
	{
		level.var_aca184cd = array(level.var_aca184cd);
	}
	strategy = getscriptbundle(strategicbundle);
	if(isdefined(strategy) && isdefined(side))
	{
		level.var_aca184cd[side] = function_700c578d(strategy);
	}
}

/*
	Name: function_f4921cb3
	Namespace: strategiccommandutility
	Checksum: 0xBD7EFB9D
	Offset: 0x6B08
	Size: 0x24E
	Parameters: 1
	Flags: Linked
*/
function function_f4921cb3(var_6d1ae0e2)
{
	focuses = array();
	switch(var_6d1ae0e2)
	{
		case "hash_617966a33a6bad2b":
		{
			focuses[focuses.size] = #"hash_617966a33a6bad2b";
			break;
		}
		case "hash_1d7cd4babd8ff905":
		{
			focuses[focuses.size] = #"hash_1d7cd4babd8ff905";
			break;
		}
		case "hash_a465dbf9320e821":
		{
			focuses[focuses.size] = #"hash_617966a33a6bad2b";
			focuses[focuses.size] = #"hash_1d7cd4babd8ff905";
			break;
		}
		case "hash_964e75ec7937916":
		{
			focuses[focuses.size] = #"hash_964e75ec7937916";
			break;
		}
		case "hash_64a01d6e814c8dc":
		{
			focuses[focuses.size] = #"hash_64a01d6e814c8dc";
			break;
		}
		case "hash_584bf5a5b6fe57ca":
		{
			focuses[focuses.size] = #"hash_964e75ec7937916";
			focuses[focuses.size] = #"hash_64a01d6e814c8dc";
			break;
		}
		case "hash_833af17ffa224fe":
		{
			focuses[focuses.size] = #"hash_617966a33a6bad2b";
			focuses[focuses.size] = #"hash_964e75ec7937916";
			break;
		}
		case "hash_692e498c8008c994":
		{
			focuses[focuses.size] = #"hash_1d7cd4babd8ff905";
			focuses[focuses.size] = #"hash_64a01d6e814c8dc";
			break;
		}
		case "objective":
		{
			focuses[focuses.size] = #"objective";
			break;
		}
	}
	return focuses;
}

/*
	Name: function_f59ca353
	Namespace: strategiccommandutility
	Checksum: 0x3140B2E9
	Offset: 0x6D60
	Size: 0x62
	Parameters: 3
	Flags: Linked
*/
function function_f59ca353(strategy, doppelbots = 1, companions = 1)
{
	return function_7712a8e4(strategy, "doppelbotsignore", "companionsignore", doppelbots, companions);
}

/*
	Name: function_698a5382
	Namespace: strategiccommandutility
	Checksum: 0xD722F3D
	Offset: 0x6DD0
	Size: 0x62
	Parameters: 3
	Flags: Linked
*/
function function_698a5382(strategy, doppelbots = 1, companions = 1)
{
	return function_7712a8e4(strategy, "doppelbotsallowair", "companionsallowair", doppelbots, companions);
}

/*
	Name: function_54032f13
	Namespace: strategiccommandutility
	Checksum: 0xAC34DA7
	Offset: 0x6E40
	Size: 0x62
	Parameters: 3
	Flags: Linked
*/
function function_54032f13(strategy, doppelbots = 1, companions = 1)
{
	return function_7712a8e4(strategy, "doppelbotsallowground", "companionsallowground", doppelbots, companions);
}

