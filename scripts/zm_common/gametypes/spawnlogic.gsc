// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace spawnlogic;

/*
	Name: function_89f2df9
	Namespace: spawnlogic
	Checksum: 0x9FE8F208
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"spawnlogic", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: spawnlogic
	Checksum: 0x10EEB60E
	Offset: 0x120
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&main);
}

/*
	Name: main
	Namespace: spawnlogic
	Checksum: 0xBDDE17F9
	Offset: 0x150
	Size: 0x2E4
	Parameters: 0
	Flags: Linked
*/
function main()
{
	/#
		if(getdvarstring(#"scr_recordspawndata") == "")
		{
			setdvar(#"scr_recordspawndata", 0);
		}
		level.storespawndata = getdvarint(#"scr_recordspawndata", 0);
		if(getdvarstring(#"scr_killbots") == "")
		{
			setdvar(#"scr_killbots", 0);
		}
		if(getdvarstring(#"scr_killbottimer") == "")
		{
			setdvar(#"scr_killbottimer", 0.25);
		}
		thread loopbotspawns();
	#/
	level.spawnlogic_deaths = [];
	level.spawnlogic_spawnkills = [];
	level.players = [];
	level.grenades = [];
	level.pipebombs = [];
	level.spawnmins = (0, 0, 0);
	level.spawnmaxs = (0, 0, 0);
	level.spawnminsmaxsprimed = 0;
	if(isdefined(level.safespawns))
	{
		for(i = 0; i < level.safespawns.size; i++)
		{
			level.safespawns[i] spawnpointinit();
		}
	}
	/#
		if(!isdefined(getdvar(#"scr_spawnpointdebug")))
		{
			setdvar(#"scr_spawnpointdebug", 0);
		}
		if(getdvarint(#"scr_spawnpointdebug", 0) > 0)
		{
			thread showdeathsdebug();
			thread updatedeathinfodebug();
			thread profiledebug();
		}
		if(level.storespawndata)
		{
			thread allowspawndatareading();
		}
		thread watchspawnprofile();
		thread spawngraphcheck();
	#/
}

/*
	Name: findboxcenter
	Namespace: spawnlogic
	Checksum: 0xB972276
	Offset: 0x440
	Size: 0x70
	Parameters: 2
	Flags: None
*/
function findboxcenter(mins, maxs)
{
	center = (0, 0, 0);
	center = maxs - mins;
	center = (center[0] / 2, center[1] / 2, center[2] / 2) + mins;
	return center;
}

/*
	Name: expandmins
	Namespace: spawnlogic
	Checksum: 0x30FEFEAD
	Offset: 0x4B8
	Size: 0xC2
	Parameters: 2
	Flags: Linked
*/
function expandmins(mins, point)
{
	if(mins[0] > point[0])
	{
		mins = (point[0], mins[1], mins[2]);
	}
	if(mins[1] > point[1])
	{
		mins = (mins[0], point[1], mins[2]);
	}
	if(mins[2] > point[2])
	{
		mins = (mins[0], mins[1], point[2]);
	}
	return mins;
}

/*
	Name: expandmaxs
	Namespace: spawnlogic
	Checksum: 0xE2509490
	Offset: 0x588
	Size: 0xC2
	Parameters: 2
	Flags: Linked
*/
function expandmaxs(maxs, point)
{
	if(maxs[0] < point[0])
	{
		maxs = (point[0], maxs[1], maxs[2]);
	}
	if(maxs[1] < point[1])
	{
		maxs = (maxs[0], point[1], maxs[2]);
	}
	if(maxs[2] < point[2])
	{
		maxs = (maxs[0], maxs[1], point[2]);
	}
	return maxs;
}

/*
	Name: addspawnpointsinternal
	Namespace: spawnlogic
	Checksum: 0xB29329D1
	Offset: 0x658
	Size: 0x23C
	Parameters: 2
	Flags: Linked
*/
function addspawnpointsinternal(team, spawnpointname)
{
	oldspawnpoints = [];
	if(level.teamspawnpoints[team].size)
	{
		oldspawnpoints = level.teamspawnpoints[team];
	}
	level.teamspawnpoints[team] = getspawnpointarray(spawnpointname);
	if(!isdefined(level.spawnpoints))
	{
		level.spawnpoints = [];
	}
	for(index = 0; index < level.teamspawnpoints[team].size; index++)
	{
		spawnpoint = level.teamspawnpoints[team][index];
		if(!isdefined(spawnpoint.inited))
		{
			spawnpoint spawnpointinit();
			level.spawnpoints[level.spawnpoints.size] = spawnpoint;
		}
	}
	for(index = 0; index < oldspawnpoints.size; index++)
	{
		origin = oldspawnpoints[index].origin;
		level.spawnmins = expandmins(level.spawnmins, origin);
		level.spawnmaxs = expandmaxs(level.spawnmaxs, origin);
		level.teamspawnpoints[team][level.teamspawnpoints[team].size] = oldspawnpoints[index];
	}
	if(!level.teamspawnpoints[team].size)
	{
		/#
			println(("" + spawnpointname) + "");
		#/
		callback::abort_level();
		wait(1);
		return;
	}
}

/*
	Name: clearspawnpoints
	Namespace: spawnlogic
	Checksum: 0x6CCA9EDB
	Offset: 0x8A0
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function clearspawnpoints()
{
	foreach(team, _ in level.teams)
	{
		level.teamspawnpoints[team] = [];
	}
	level.spawnpoints = [];
	level.unified_spawn_points = undefined;
}

/*
	Name: addspawnpoints
	Namespace: spawnlogic
	Checksum: 0xC182CB54
	Offset: 0x940
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function addspawnpoints(team, spawnpointname)
{
	addspawnpointclassname(spawnpointname);
	addspawnpointteamclassname(team, spawnpointname);
	addspawnpointsinternal(team, spawnpointname);
}

/*
	Name: rebuildspawnpoints
	Namespace: spawnlogic
	Checksum: 0x626199D
	Offset: 0x9A8
	Size: 0x7E
	Parameters: 1
	Flags: None
*/
function rebuildspawnpoints(team)
{
	level.teamspawnpoints[team] = [];
	for(index = 0; index < level.spawn_point_team_class_names[team].size; index++)
	{
		addspawnpointsinternal(team, level.spawn_point_team_class_names[team][index]);
	}
}

/*
	Name: placespawnpoints
	Namespace: spawnlogic
	Checksum: 0xAA13FC53
	Offset: 0xA30
	Size: 0x134
	Parameters: 1
	Flags: None
*/
function placespawnpoints(spawnpointname)
{
	addspawnpointclassname(spawnpointname);
	spawnpoints = getspawnpointarray(spawnpointname);
	/#
		if(!isdefined(level.extraspawnpointsused))
		{
			level.extraspawnpointsused = [];
		}
	#/
	if(!spawnpoints.size)
	{
		/#
			println(("" + spawnpointname) + "");
		#/
		callback::abort_level();
		wait(1);
		return;
	}
	for(index = 0; index < spawnpoints.size; index++)
	{
		spawnpoints[index] spawnpointinit();
		/#
			spawnpoints[index].fakeclassname = spawnpointname;
			level.extraspawnpointsused[level.extraspawnpointsused.size] = spawnpoints[index];
		#/
	}
}

/*
	Name: dropspawnpoints
	Namespace: spawnlogic
	Checksum: 0x33243E5E
	Offset: 0xB70
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function dropspawnpoints(spawnpointname)
{
	spawnpoints = getspawnpointarray(spawnpointname);
	if(!spawnpoints.size)
	{
		/#
			println(("" + spawnpointname) + "");
		#/
		return;
	}
	for(index = 0; index < spawnpoints.size; index++)
	{
		spawnpoints[index] placespawnpoint();
	}
}

/*
	Name: addspawnpointclassname
	Namespace: spawnlogic
	Checksum: 0x4E106BC5
	Offset: 0xC20
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function addspawnpointclassname(spawnpointclassname)
{
	if(!isdefined(level.spawn_point_class_names))
	{
		level.spawn_point_class_names = [];
	}
	level.spawn_point_class_names[level.spawn_point_class_names.size] = spawnpointclassname;
}

/*
	Name: addspawnpointteamclassname
	Namespace: spawnlogic
	Checksum: 0x29B0CDE6
	Offset: 0xC70
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function addspawnpointteamclassname(team, spawnpointclassname)
{
	level.spawn_point_team_class_names[team][level.spawn_point_team_class_names[team].size] = spawnpointclassname;
}

/*
	Name: getspawnpointarray
	Namespace: spawnlogic
	Checksum: 0x32F5A21B
	Offset: 0xCB8
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function getspawnpointarray(classname)
{
	spawnpoints = getentarray(classname, "classname");
	if(!isdefined(level.extraspawnpoints) || !isdefined(level.extraspawnpoints[classname]))
	{
		return spawnpoints;
	}
	for(i = 0; i < level.extraspawnpoints[classname].size; i++)
	{
		spawnpoints[spawnpoints.size] = level.extraspawnpoints[classname][i];
	}
	return spawnpoints;
}

/*
	Name: spawnpointinit
	Namespace: spawnlogic
	Checksum: 0x23B0CD52
	Offset: 0xD80
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function spawnpointinit()
{
	spawnpoint = self;
	origin = spawnpoint.origin;
	if(!level.spawnminsmaxsprimed)
	{
		level.spawnmins = origin;
		level.spawnmaxs = origin;
		level.spawnminsmaxsprimed = 1;
	}
	else
	{
		level.spawnmins = expandmins(level.spawnmins, origin);
		level.spawnmaxs = expandmaxs(level.spawnmaxs, origin);
	}
	spawnpoint placespawnpoint();
	spawnpoint.forward = anglestoforward(spawnpoint.angles);
	spawnpoint.sighttracepoint = spawnpoint.origin + vectorscale((0, 0, 1), 50);
	spawnpoint.inited = 1;
}

/*
	Name: getteamspawnpoints
	Namespace: spawnlogic
	Checksum: 0x9607E1E8
	Offset: 0xEB0
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function getteamspawnpoints(team)
{
	return level.teamspawnpoints[team];
}

/*
	Name: getspawnpoint_final
	Namespace: spawnlogic
	Checksum: 0x8A3B3816
	Offset: 0xED8
	Size: 0x208
	Parameters: 2
	Flags: Linked
*/
function getspawnpoint_final(spawnpoints, useweights)
{
	bestspawnpoint = undefined;
	if(!isdefined(spawnpoints) || spawnpoints.size == 0)
	{
		return undefined;
	}
	if(!isdefined(useweights))
	{
		useweights = 1;
	}
	if(useweights)
	{
		bestspawnpoint = getbestweightedspawnpoint(spawnpoints);
		thread spawnweightdebug(spawnpoints);
	}
	else
	{
		for(i = 0; i < spawnpoints.size; i++)
		{
			if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i])
			{
				continue;
			}
			if(positionwouldtelefrag(spawnpoints[i].origin))
			{
				continue;
			}
			bestspawnpoint = spawnpoints[i];
			break;
		}
		if(!isdefined(bestspawnpoint))
		{
			if(isdefined(self.lastspawnpoint) && !positionwouldtelefrag(self.lastspawnpoint.origin))
			{
				for(i = 0; i < spawnpoints.size; i++)
				{
					if(spawnpoints[i] == self.lastspawnpoint)
					{
						bestspawnpoint = spawnpoints[i];
						break;
					}
				}
			}
		}
	}
	if(!isdefined(bestspawnpoint))
	{
		if(useweights)
		{
			bestspawnpoint = spawnpoints[randomint(spawnpoints.size)];
		}
		else
		{
			bestspawnpoint = spawnpoints[0];
		}
	}
	self finalizespawnpointchoice(bestspawnpoint);
	/#
		self storespawndata(spawnpoints, useweights, bestspawnpoint);
	#/
	return bestspawnpoint;
}

/*
	Name: finalizespawnpointchoice
	Namespace: spawnlogic
	Checksum: 0x7414AF1F
	Offset: 0x10E8
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function finalizespawnpointchoice(spawnpoint)
{
	time = gettime();
	self.lastspawnpoint = spawnpoint;
	self.lastspawntime = time;
	spawnpoint.lastspawnedplayer = self;
	spawnpoint.lastspawntime = time;
}

/*
	Name: getbestweightedspawnpoint
	Namespace: spawnlogic
	Checksum: 0x17C047D1
	Offset: 0x1140
	Size: 0x27C
	Parameters: 1
	Flags: Linked
*/
function getbestweightedspawnpoint(spawnpoints)
{
	maxsighttracedspawnpoints = 3;
	for(var_65ce2e33 = 0; var_65ce2e33 <= maxsighttracedspawnpoints; var_65ce2e33++)
	{
		bestspawnpoints = [];
		bestweight = undefined;
		bestspawnpoint = undefined;
		for(i = 0; i < spawnpoints.size; i++)
		{
			if(!isdefined(bestweight) || spawnpoints[i].weight > bestweight)
			{
				if(positionwouldtelefrag(spawnpoints[i].origin))
				{
					continue;
				}
				bestspawnpoints = [];
				bestspawnpoints[0] = spawnpoints[i];
				bestweight = spawnpoints[i].weight;
				continue;
			}
			if(spawnpoints[i].weight == bestweight)
			{
				if(positionwouldtelefrag(spawnpoints[i].origin))
				{
					continue;
				}
				bestspawnpoints[bestspawnpoints.size] = spawnpoints[i];
			}
		}
		if(bestspawnpoints.size == 0)
		{
			return undefined;
		}
		bestspawnpoint = bestspawnpoints[randomint(bestspawnpoints.size)];
		if(var_65ce2e33 == maxsighttracedspawnpoints)
		{
			return bestspawnpoint;
		}
		if(isdefined(bestspawnpoint.lastsighttracetime) && bestspawnpoint.lastsighttracetime == gettime())
		{
			return bestspawnpoint;
		}
		if(!lastminutesighttraces(bestspawnpoint))
		{
			return bestspawnpoint;
		}
		penalty = getlospenalty();
		/#
			if(level.storespawndata || level.debugspawning)
			{
				bestspawnpoint.spawndata[bestspawnpoint.spawndata.size] = "" + penalty;
			}
		#/
		bestspawnpoint.weight = bestspawnpoint.weight - penalty;
		bestspawnpoint.lastsighttracetime = gettime();
	}
}

/*
	Name: checkbad
	Namespace: spawnlogic
	Checksum: 0xA1C2B69B
	Offset: 0x13C8
	Size: 0x156
	Parameters: 1
	Flags: None
*/
function checkbad(spawnpoint)
{
	/#
		for(i = 0; i < level.players.size; i++)
		{
			player = level.players[i];
			if(!isalive(player) || player.sessionstate != "")
			{
				continue;
			}
			if(level.teambased && player.team == self.team)
			{
				continue;
			}
			losexists = bullettracepassed(player.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, 0, undefined);
			if(losexists)
			{
				thread badspawnline(spawnpoint.sighttracepoint, player.origin + vectorscale((0, 0, 1), 50), self.name, player.name);
			}
		}
	#/
}

/*
	Name: badspawnline
	Namespace: spawnlogic
	Checksum: 0xCBF8D9AA
	Offset: 0x1528
	Size: 0xDC
	Parameters: 4
	Flags: None
*/
function badspawnline(start, end, name1, name2)
{
	/#
		dist = distance(start, end);
		for(i = 0; i < 200; i++)
		{
			line(start, end, (1, 0, 0));
			print3d(start, (("" + name1) + "") + dist);
			print3d(end, name2);
			waitframe(1);
		}
	#/
}

/*
	Name: storespawndata
	Namespace: spawnlogic
	Checksum: 0x7C24FFBD
	Offset: 0x1610
	Size: 0x82A
	Parameters: 3
	Flags: None
*/
function storespawndata(spawnpoints, useweights, bestspawnpoint)
{
	/#
		if(!isdefined(level.storespawndata) || !level.storespawndata)
		{
			return;
		}
		level.storespawndata = getdvarint(#"scr_recordspawndata", 0);
		if(!level.storespawndata)
		{
			return;
		}
		if(!isdefined(level.spawnid))
		{
			level.spawngameid = randomint(100);
			level.spawnid = 0;
		}
		if(bestspawnpoint.classname == "")
		{
			return;
		}
		level.spawnid++;
		file = openfile("", "");
		fprintfields(file, (((((level.spawngameid + "") + level.spawnid) + "") + spawnpoints.size) + "") + self.name);
		for(i = 0; i < spawnpoints.size; i++)
		{
			str = vectostr(spawnpoints[i].origin) + "";
			if(spawnpoints[i] == bestspawnpoint)
			{
				str = str + "";
			}
			else
			{
				str = str + "";
			}
			if(!useweights)
			{
				str = str + "";
			}
			else
			{
				str = str + (spawnpoints[i].weight + "");
			}
			if(!isdefined(spawnpoints[i].spawndata))
			{
				spawnpoints[i].spawndata = [];
			}
			if(!isdefined(spawnpoints[i].sightchecks))
			{
				spawnpoints[i].sightchecks = [];
			}
			str = str + (spawnpoints[i].spawndata.size + "");
			for(j = 0; j < spawnpoints[i].spawndata.size; j++)
			{
				str = str + (spawnpoints[i].spawndata[j] + "");
			}
			str = str + (spawnpoints[i].sightchecks.size + "");
			for(j = 0; j < spawnpoints[i].sightchecks.size; j++)
			{
				str = str + ((spawnpoints[i].sightchecks[j].penalty + "") + vectostr(spawnpoints[i].origin) + "");
			}
			fprintfields(file, str);
		}
		obj = spawnstruct();
		getallalliedandenemyplayers(obj);
		numallies = 0;
		numenemies = 0;
		str = "";
		for(i = 0; i < obj.allies.size; i++)
		{
			if(obj.allies[i] == self)
			{
				continue;
			}
			numallies++;
			str = str + (vectostr(obj.allies[i].origin) + "");
		}
		for(i = 0; i < obj.enemies.size; i++)
		{
			numenemies++;
			str = str + (vectostr(obj.enemies[i].origin) + "");
		}
		str = (((numallies + "") + numenemies) + "") + str;
		fprintfields(file, str);
		otherdata = [];
		if(isdefined(level.bombguy))
		{
			index = otherdata.size;
			otherdata[index] = spawnstruct();
			otherdata[index].origin = level.bombguy.origin + vectorscale((0, 0, 1), 20);
			otherdata[index].text = "";
		}
		else if(isdefined(level.bombpos))
		{
			index = otherdata.size;
			otherdata[index] = spawnstruct();
			otherdata[index].origin = level.bombpos;
			otherdata[index].text = "";
		}
		if(isdefined(level.flags))
		{
			for(i = 0; i < level.flags.size; i++)
			{
				index = otherdata.size;
				otherdata[index] = spawnstruct();
				otherdata[index].origin = level.flags[i].origin;
				otherdata[index].text = level.flags[i].useobj gameobjects::get_owner_team() + "";
			}
		}
		str = otherdata.size + "";
		for(i = 0; i < otherdata.size; i++)
		{
			str = str + (((vectostr(otherdata[i].origin) + "") + otherdata[i].text) + "");
		}
		fprintfields(file, str);
		closefile(file);
		thisspawnid = (level.spawngameid + "") + level.spawnid;
		self.thisspawnid = thisspawnid;
	#/
}

/*
	Name: readspawndata
	Namespace: spawnlogic
	Checksum: 0xFC86D278
	Offset: 0x1E48
	Size: 0xA64
	Parameters: 2
	Flags: None
*/
function readspawndata(desiredid, relativepos)
{
	/#
		file = openfile("", "");
		if(file < 0)
		{
			return;
		}
		oldspawndata = level.curspawndata;
		level.curspawndata = undefined;
		prev = undefined;
		prevthisplayer = undefined;
		lookingfornextthisplayer = 0;
		lookingfornext = 0;
		if(isdefined(relativepos) && !isdefined(oldspawndata))
		{
			return;
		}
		while(true)
		{
			if(freadln(file) <= 0)
			{
				break;
			}
			data = spawnstruct();
			data.id = fgetarg(file, 0);
			numspawns = int(fgetarg(file, 1));
			if(numspawns > 256)
			{
				break;
			}
			data.playername = fgetarg(file, 2);
			data.spawnpoints = [];
			data.friends = [];
			data.enemies = [];
			data.otherdata = [];
			for(i = 0; i < numspawns; i++)
			{
				if(freadln(file) <= 0)
				{
					break;
				}
				spawnpoint = spawnstruct();
				spawnpoint.origin = strtovec(fgetarg(file, 0));
				spawnpoint.winner = int(fgetarg(file, 1));
				spawnpoint.weight = int(fgetarg(file, 2));
				spawnpoint.data = [];
				spawnpoint.sightchecks = [];
				if(i == 0)
				{
					data.minweight = spawnpoint.weight;
					data.maxweight = spawnpoint.weight;
				}
				else if(spawnpoint.weight < data.minweight)
				{
					data.minweight = spawnpoint.weight;
				}
				if(spawnpoint.weight > data.maxweight)
				{
					data.maxweight = spawnpoint.weight;
				}
				argnum = 4;
				numdata = int(fgetarg(file, 3));
				if(numdata > 256)
				{
					break;
				}
				for(j = 0; j < numdata; j++)
				{
					spawnpoint.data[spawnpoint.data.size] = fgetarg(file, argnum);
					argnum++;
				}
				numsightchecks = int(fgetarg(file, argnum));
				argnum++;
				if(numsightchecks > 256)
				{
					break;
				}
				for(j = 0; j < numsightchecks; j++)
				{
					index = spawnpoint.sightchecks.size;
					spawnpoint.sightchecks[index] = spawnstruct();
					spawnpoint.sightchecks[index].penalty = int(fgetarg(file, argnum));
					argnum++;
					spawnpoint.sightchecks[index].origin = strtovec(fgetarg(file, argnum));
					argnum++;
				}
				data.spawnpoints[data.spawnpoints.size] = spawnpoint;
			}
			if(!isdefined(data.minweight))
			{
				data.minweight = -1;
				data.maxweight = 0;
			}
			if(data.minweight == data.maxweight)
			{
				data.minweight = data.minweight - 1;
			}
			if(freadln(file) <= 0)
			{
				break;
			}
			numfriends = int(fgetarg(file, 0));
			numenemies = int(fgetarg(file, 1));
			if(numfriends > 32 || numenemies > 32)
			{
				break;
			}
			argnum = 2;
			for(i = 0; i < numfriends; i++)
			{
				data.friends[data.friends.size] = strtovec(fgetarg(file, argnum));
				argnum++;
			}
			for(i = 0; i < numenemies; i++)
			{
				data.enemies[data.enemies.size] = strtovec(fgetarg(file, argnum));
				argnum++;
			}
			if(freadln(file) <= 0)
			{
				break;
			}
			numotherdata = int(fgetarg(file, 0));
			argnum = 1;
			for(i = 0; i < numotherdata; i++)
			{
				otherdata = spawnstruct();
				otherdata.origin = strtovec(fgetarg(file, argnum));
				argnum++;
				otherdata.text = fgetarg(file, argnum);
				argnum++;
				data.otherdata[data.otherdata.size] = otherdata;
			}
			if(isdefined(relativepos))
			{
				if(relativepos == "")
				{
					if(data.id == oldspawndata.id)
					{
						level.curspawndata = prevthisplayer;
						break;
					}
				}
				else if(relativepos == "")
				{
					if(data.id == oldspawndata.id)
					{
						level.curspawndata = prev;
						break;
					}
				}
				else if(relativepos == "")
				{
					if(lookingfornextthisplayer)
					{
						level.curspawndata = data;
						break;
					}
					else if(data.id == oldspawndata.id)
					{
						lookingfornextthisplayer = 1;
					}
				}
				else if(relativepos == "")
				{
					if(lookingfornext)
					{
						level.curspawndata = data;
						break;
					}
					else if(data.id == oldspawndata.id)
					{
						lookingfornext = 1;
					}
				}
			}
			else if(data.id == desiredid)
			{
				level.curspawndata = data;
				break;
			}
			prev = data;
			if(isdefined(oldspawndata) && data.playername == oldspawndata.playername)
			{
				prevthisplayer = data;
			}
		}
		closefile(file);
	#/
}

/*
	Name: drawspawndata
	Namespace: spawnlogic
	Checksum: 0x6309902E
	Offset: 0x28B8
	Size: 0x468
	Parameters: 0
	Flags: None
*/
function drawspawndata()
{
	/#
		level notify(#"drawing_spawn_data");
		level endon(#"drawing_spawn_data");
		textoffset = vectorscale((0, 0, -1), 12);
		while(true)
		{
			if(!isdefined(level.curspawndata))
			{
				wait(0.5);
				continue;
			}
			for(i = 0; i < level.curspawndata.friends.size; i++)
			{
				print3d(level.curspawndata.friends[i], "", (0.5, 1, 0.5), 1, 5);
			}
			for(i = 0; i < level.curspawndata.enemies.size; i++)
			{
				print3d(level.curspawndata.enemies[i], "", (1, 0.5, 0.5), 1, 5);
			}
			for(i = 0; i < level.curspawndata.otherdata.size; i++)
			{
				print3d(level.curspawndata.otherdata[i].origin, level.curspawndata.otherdata[i].text, (0.5, 0.75, 1), 1, 2);
			}
			for(i = 0; i < level.curspawndata.spawnpoints.size; i++)
			{
				sp = level.curspawndata.spawnpoints[i];
				orig = sp.sighttracepoint;
				if(sp.winner)
				{
					print3d(orig, level.curspawndata.playername + "", (0.5, 0.5, 1), 1, 2);
					orig = orig + textoffset;
				}
				amnt = (sp.weight - level.curspawndata.minweight) / (level.curspawndata.maxweight - level.curspawndata.minweight);
				print3d(orig, "" + sp.weight, (1 - amnt, amnt, 0.5));
				orig = orig + textoffset;
				for(j = 0; j < sp.data.size; j++)
				{
					print3d(orig, sp.data[j], (1, 1, 1));
					orig = orig + textoffset;
				}
				for(j = 0; j < sp.sightchecks.size; j++)
				{
					print3d(orig, "" + sp.sightchecks[j].penalty, (1, 0.5, 0.5));
					orig = orig + textoffset;
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: vectostr
	Namespace: spawnlogic
	Checksum: 0xE541FCC9
	Offset: 0x2D28
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function vectostr(vec)
{
	/#
		return ((int(vec[0]) + "") + int(vec[1]) + "") + int(vec[2]);
	#/
}

/*
	Name: strtovec
	Namespace: spawnlogic
	Checksum: 0xFC534211
	Offset: 0x2DB0
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function strtovec(str)
{
	/#
		parts = strtok(str, "");
		if(parts.size != 3)
		{
			return (0, 0, 0);
		}
		return (int(parts[0]), int(parts[1]), int(parts[2]));
	#/
}

/*
	Name: getspawnpoint_random
	Namespace: spawnlogic
	Checksum: 0x83A5C5BC
	Offset: 0x2E58
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function getspawnpoint_random(spawnpoints)
{
	if(!isdefined(spawnpoints))
	{
		return undefined;
	}
	for(i = 0; i < spawnpoints.size; i++)
	{
		j = randomint(spawnpoints.size);
		spawnpoint = spawnpoints[i];
		spawnpoints[i] = spawnpoints[j];
		spawnpoints[j] = spawnpoint;
	}
	return getspawnpoint_final(spawnpoints, 0);
}

/*
	Name: getallotherplayers
	Namespace: spawnlogic
	Checksum: 0x4E3EB564
	Offset: 0x2F18
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function getallotherplayers()
{
	aliveplayers = [];
	for(i = 0; i < level.players.size; i++)
	{
		if(!isdefined(level.players[i]))
		{
			continue;
		}
		player = level.players[i];
		if(player.sessionstate != "playing" || player == self)
		{
			continue;
		}
		if(isdefined(level.customalivecheck))
		{
			if(![[level.customalivecheck]](player))
			{
				continue;
			}
		}
		aliveplayers[aliveplayers.size] = player;
	}
	return aliveplayers;
}

/*
	Name: getallalliedandenemyplayers
	Namespace: spawnlogic
	Checksum: 0xEE2CDC88
	Offset: 0x3000
	Size: 0x192
	Parameters: 1
	Flags: Linked
*/
function getallalliedandenemyplayers(obj)
{
	if(level.teambased)
	{
		/#
			assert(isdefined(level.teams[self.team]));
		#/
		obj.allies = [];
		obj.enemies = [];
		for(i = 0; i < level.players.size; i++)
		{
			if(!isdefined(level.players[i]))
			{
				continue;
			}
			player = level.players[i];
			if(player.sessionstate != "playing" || player == self)
			{
				continue;
			}
			if(isdefined(level.customalivecheck))
			{
				if(![[level.customalivecheck]](player))
				{
					continue;
				}
			}
			if(player.team == self.team)
			{
				obj.allies[obj.allies.size] = player;
				continue;
			}
			obj.enemies[obj.enemies.size] = player;
		}
	}
	else
	{
		obj.allies = [];
		obj.enemies = level.activeplayers;
	}
}

/*
	Name: initweights
	Namespace: spawnlogic
	Checksum: 0x86E4D778
	Offset: 0x31A0
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function initweights(spawnpoints)
{
	for(i = 0; i < spawnpoints.size; i++)
	{
		spawnpoints[i].weight = 0;
	}
	/#
		if(level.storespawndata || level.debugspawning)
		{
			for(i = 0; i < spawnpoints.size; i++)
			{
				spawnpoints[i].spawndata = [];
				spawnpoints[i].sightchecks = [];
			}
		}
	#/
}

/*
	Name: spawnpointupdate_zm
	Namespace: spawnlogic
	Checksum: 0xE6DE7D47
	Offset: 0x3258
	Size: 0x26E
	Parameters: 1
	Flags: Linked
*/
function spawnpointupdate_zm(spawnpoint)
{
	foreach(team, _ in level.teams)
	{
		spawnpoint.distsum[team] = 0;
		spawnpoint.enemydistsum[team] = 0;
	}
	players = getplayers();
	spawnpoint.numplayersatlastupdate = players.size;
	foreach(player in players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		if(player.sessionstate != "playing")
		{
			continue;
		}
		if(isdefined(level.customalivecheck))
		{
			if(![[level.customalivecheck]](player))
			{
				continue;
			}
		}
		dist = distance(spawnpoint.origin, player.origin);
		spawnpoint.distsum[player.team] = spawnpoint.distsum[player.team] + dist;
		foreach(team, _ in level.teams)
		{
			if(team != player.team)
			{
				spawnpoint.enemydistsum[team] = spawnpoint.enemydistsum[team] + dist;
			}
		}
	}
}

/*
	Name: getspawnpoint_nearteam
	Namespace: spawnlogic
	Checksum: 0x6F2C2F1D
	Offset: 0x34D0
	Size: 0x4D0
	Parameters: 4
	Flags: Linked
*/
function getspawnpoint_nearteam(spawnpoints, favoredspawnpoints, forceallydistanceweight, forceenemydistanceweight)
{
	if(!isdefined(spawnpoints))
	{
		return undefined;
	}
	/#
		if(getdvarint(#"scr_spawn_randomly", 0))
		{
			return getspawnpoint_random(spawnpoints);
		}
	#/
	if(getdvarint(#"scr_spawnsimple", 0) > 0)
	{
		return getspawnpoint_random(spawnpoints);
	}
	spawnlogic_begin();
	k_favored_spawn_point_bonus = 25000;
	initweights(spawnpoints);
	obj = spawnstruct();
	getallalliedandenemyplayers(obj);
	numplayers = obj.allies.size + obj.enemies.size;
	allieddistanceweight = 2;
	if(isdefined(forceallydistanceweight))
	{
		allieddistanceweight = forceallydistanceweight;
	}
	enemydistanceweight = 1;
	if(isdefined(forceenemydistanceweight))
	{
		enemydistanceweight = forceenemydistanceweight;
	}
	myteam = self.team;
	for(i = 0; i < spawnpoints.size; i++)
	{
		spawnpoint = spawnpoints[i];
		spawnpointupdate_zm(spawnpoint);
		if(!isdefined(spawnpoint.numplayersatlastupdate))
		{
			spawnpoint.numplayersatlastupdate = 0;
		}
		if(spawnpoint.numplayersatlastupdate > 0)
		{
			allydistsum = spawnpoint.distsum[myteam];
			enemydistsum = spawnpoint.enemydistsum[myteam];
			spawnpoint.weight = (enemydistanceweight * enemydistsum) - (allieddistanceweight * allydistsum) / spawnpoint.numplayersatlastupdate;
			/#
				if(level.storespawndata || level.debugspawning)
				{
					spawnpoint.spawndata[spawnpoint.spawndata.size] = (((((((("" + int(spawnpoint.weight)) + "") + enemydistanceweight) + "") + int(enemydistsum) + "") + allieddistanceweight) + "") + int(allydistsum) + "") + spawnpoint.numplayersatlastupdate;
				}
			#/
			continue;
		}
		spawnpoint.weight = 0;
		/#
			if(level.storespawndata || level.debugspawning)
			{
				spawnpoint.spawndata[spawnpoint.spawndata.size] = "";
			}
		#/
	}
	if(isdefined(favoredspawnpoints))
	{
		for(i = 0; i < favoredspawnpoints.size; i++)
		{
			if(isdefined(favoredspawnpoints[i].weight))
			{
				favoredspawnpoints[i].weight = favoredspawnpoints[i].weight + k_favored_spawn_point_bonus;
				continue;
			}
			favoredspawnpoints[i].weight = k_favored_spawn_point_bonus;
		}
	}
	avoidsamespawn(spawnpoints);
	avoidspawnreuse(spawnpoints, 1);
	avoidweapondamage(spawnpoints);
	avoidvisibleenemies(spawnpoints, 1);
	result = getspawnpoint_final(spawnpoints);
	/#
		if(getdvarint(#"scr_spawn_showbad", 0))
		{
			checkbad(result);
		}
	#/
	return result;
}

/*
	Name: getspawnpoint_dm
	Namespace: spawnlogic
	Checksum: 0x56C26D3C
	Offset: 0x39A8
	Size: 0x262
	Parameters: 1
	Flags: Linked
*/
function getspawnpoint_dm(spawnpoints)
{
	if(!isdefined(spawnpoints))
	{
		return undefined;
	}
	spawnlogic_begin();
	initweights(spawnpoints);
	aliveplayers = getallotherplayers();
	idealdist = 1600;
	baddist = 1200;
	if(aliveplayers.size > 0)
	{
		for(i = 0; i < spawnpoints.size; i++)
		{
			totaldistfromideal = 0;
			nearbybadamount = 0;
			for(j = 0; j < aliveplayers.size; j++)
			{
				dist = distance(spawnpoints[i].origin, aliveplayers[j].origin);
				if(dist < baddist)
				{
					nearbybadamount = nearbybadamount + ((baddist - dist) / baddist);
				}
				distfromideal = abs(dist - idealdist);
				totaldistfromideal = totaldistfromideal + distfromideal;
			}
			avgdistfromideal = totaldistfromideal / aliveplayers.size;
			welldistancedamount = (idealdist - avgdistfromideal) / idealdist;
			spawnpoints[i].weight = (welldistancedamount - (nearbybadamount * 2)) + randomfloat(0.2);
		}
	}
	avoidsamespawn(spawnpoints);
	avoidspawnreuse(spawnpoints, 0);
	avoidweapondamage(spawnpoints);
	avoidvisibleenemies(spawnpoints, 0);
	return getspawnpoint_final(spawnpoints);
}

/*
	Name: getspawnpoint_turned
	Namespace: spawnlogic
	Checksum: 0xEB123FBA
	Offset: 0x3C18
	Size: 0x32A
	Parameters: 5
	Flags: None
*/
function getspawnpoint_turned(spawnpoints, idealdist, baddist, idealdistteam, baddistteam)
{
	if(!isdefined(spawnpoints))
	{
		return undefined;
	}
	spawnlogic_begin();
	initweights(spawnpoints);
	aliveplayers = getallotherplayers();
	if(!isdefined(idealdist))
	{
		idealdist = 1600;
	}
	if(!isdefined(idealdistteam))
	{
		idealdistteam = 1200;
	}
	if(!isdefined(baddist))
	{
		baddist = 1200;
	}
	if(!isdefined(baddistteam))
	{
		baddistteam = 600;
	}
	myteam = self.team;
	if(aliveplayers.size > 0)
	{
		for(i = 0; i < spawnpoints.size; i++)
		{
			totaldistfromideal = 0;
			nearbybadamount = 0;
			for(j = 0; j < aliveplayers.size; j++)
			{
				dist = distance(spawnpoints[i].origin, aliveplayers[j].origin);
				distfromideal = 0;
				if(aliveplayers[j].team == myteam)
				{
					if(dist < baddistteam)
					{
						nearbybadamount = nearbybadamount + ((baddistteam - dist) / baddistteam);
					}
					distfromideal = abs(dist - idealdistteam);
				}
				else if(dist < baddist)
				{
					nearbybadamount = nearbybadamount + ((baddist - dist) / baddist);
				}
				distfromideal = abs(dist - idealdist);
				totaldistfromideal = totaldistfromideal + distfromideal;
			}
			avgdistfromideal = totaldistfromideal / aliveplayers.size;
			welldistancedamount = (idealdist - avgdistfromideal) / idealdist;
			spawnpoints[i].weight = (welldistancedamount - (nearbybadamount * 2)) + randomfloat(0.2);
		}
	}
	avoidsamespawn(spawnpoints);
	avoidspawnreuse(spawnpoints, 0);
	avoidweapondamage(spawnpoints);
	avoidvisibleenemies(spawnpoints, 0);
	return getspawnpoint_final(spawnpoints);
}

/*
	Name: spawnlogic_begin
	Namespace: spawnlogic
	Checksum: 0x85286E6F
	Offset: 0x3F50
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function spawnlogic_begin()
{
	/#
		level.storespawndata = getdvarint(#"scr_recordspawndata", 0);
		level.debugspawning = getdvarint(#"scr_spawnpointdebug", 0) > 0;
	#/
}

/*
	Name: watchspawnprofile
	Namespace: spawnlogic
	Checksum: 0xACACA64C
	Offset: 0x3FC8
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function watchspawnprofile()
{
	/#
		while(true)
		{
			while(true)
			{
				if(getdvarint(#"scr_spawnprofile", 0) > 0)
				{
					break;
				}
				waitframe(1);
			}
			thread spawnprofile();
			while(true)
			{
				if(getdvarint(#"scr_spawnprofile", 0) <= 0)
				{
					break;
				}
				waitframe(1);
			}
			level notify(#"stop_spawn_profile");
		}
	#/
}

/*
	Name: spawnprofile
	Namespace: spawnlogic
	Checksum: 0xE471B5D1
	Offset: 0x4090
	Size: 0x11E
	Parameters: 0
	Flags: None
*/
function spawnprofile()
{
	/#
		level endon(#"stop_spawn_profile");
		while(true)
		{
			if(level.players.size > 0 && level.spawnpoints.size > 0)
			{
				playernum = randomint(level.players.size);
				player = level.players[playernum];
				for(attempt = 1; !isdefined(player) && attempt < level.players.size; attempt++)
				{
					playernum = (playernum + 1) % level.players.size;
					player = level.players[playernum];
				}
				player getspawnpoint_nearteam(level.spawnpoints);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: spawngraphcheck
	Namespace: spawnlogic
	Checksum: 0xBE079341
	Offset: 0x41B8
	Size: 0x5A
	Parameters: 0
	Flags: None
*/
function spawngraphcheck()
{
	/#
		while(true)
		{
			wait(3);
		}
		if(getdvarint(#"scr_spawngraph", 0) < 1)
		{
		}
		thread spawngraph();
		return;
	#/
}

/*
	Name: spawngraph
	Namespace: spawnlogic
	Checksum: 0x58FBBA8
	Offset: 0x4220
	Size: 0x5EE
	Parameters: 0
	Flags: None
*/
function spawngraph()
{
	/#
		w = 20;
		h = 20;
		weightscale = 0.1;
		fakespawnpoints = [];
		corners = getentarray("", "");
		if(corners.size != 2)
		{
			println("");
			return;
		}
		min = corners[0].origin;
		max = corners[0].origin;
		if(corners[1].origin[0] > max[0])
		{
			max = (corners[1].origin[0], max[1], max[2]);
		}
		else
		{
			min = (corners[1].origin[0], min[1], min[2]);
		}
		if(corners[1].origin[1] > max[1])
		{
			max = (max[0], corners[1].origin[1], max[2]);
		}
		else
		{
			min = (min[0], corners[1].origin[1], min[2]);
		}
		i = 0;
		for(y = 0; y < h; y++)
		{
			yamnt = y / (h - 1);
			for(x = 0; x < w; x++)
			{
				xamnt = x / (w - 1);
				fakespawnpoints[i] = spawnstruct();
				fakespawnpoints[i].origin = ((min[0] * xamnt) + (max[0] * (1 - xamnt)), (min[1] * yamnt) + (max[1] * (1 - yamnt)), min[2]);
				fakespawnpoints[i].angles = (0, 0, 0);
				fakespawnpoints[i].forward = anglestoforward(fakespawnpoints[i].angles);
				fakespawnpoints[i].sighttracepoint = fakespawnpoints[i].origin;
				i++;
			}
		}
		didweights = 0;
		while(true)
		{
			spawni = 0;
			numiters = 5;
			for(i = 0; i < numiters; i++)
			{
				if(!level.players.size || !isdefined(level.players[0].team) || level.players[0].team == "" || !isdefined(level.players[0].curclass))
				{
					break;
				}
				endspawni = spawni + (fakespawnpoints.size / numiters);
				if(i == (numiters - 1))
				{
					endspawni = fakespawnpoints.size;
				}
				while(spawni < endspawni)
				{
					spawnpointupdate(fakespawnpoints[spawni]);
					spawni++;
				}
				if(didweights)
				{
					level.players[0] drawspawngraph(fakespawnpoints, w, h, weightscale);
				}
				waitframe(1);
			}
			if(!level.players.size || !isdefined(level.players[0].team) || level.players[0].team == "" || !isdefined(level.players[0].curclass))
			{
				wait(1);
				continue;
			}
			level.players[0] getspawnpoint_nearteam(fakespawnpoints);
			for(i = 0; i < fakespawnpoints.size; i++)
			{
				setupspawngraphpoint(fakespawnpoints[i], weightscale);
			}
			didweights = 1;
			level.players[0] drawspawngraph(fakespawnpoints, w, h, weightscale);
			waitframe(1);
		}
	#/
}

/*
	Name: drawspawngraph
	Namespace: spawnlogic
	Checksum: 0xE8EE3D63
	Offset: 0x4818
	Size: 0x12E
	Parameters: 4
	Flags: None
*/
function drawspawngraph(fakespawnpoints, w, h, weightscale)
{
	/#
		i = 0;
		for(y = 0; y < h; y++)
		{
			yamnt = y / (h - 1);
			for(x = 0; x < w; x++)
			{
				xamnt = x / (w - 1);
				if(y > 0)
				{
					spawngraphline(fakespawnpoints[i], fakespawnpoints[i - w], weightscale);
				}
				if(x > 0)
				{
					spawngraphline(fakespawnpoints[i], fakespawnpoints[i - 1], weightscale);
				}
				i++;
			}
		}
	#/
}

/*
	Name: setupspawngraphpoint
	Namespace: spawnlogic
	Checksum: 0x6C42CD2D
	Offset: 0x4950
	Size: 0x4E
	Parameters: 2
	Flags: None
*/
function setupspawngraphpoint(s1, weightscale)
{
	/#
		s1.visible = 1;
		if(s1.weight < -1000 / weightscale)
		{
			s1.visible = 0;
		}
	#/
}

/*
	Name: spawngraphline
	Namespace: spawnlogic
	Checksum: 0xBAD6927B
	Offset: 0x49A8
	Size: 0xD4
	Parameters: 3
	Flags: None
*/
function spawngraphline(s1, s2, weightscale)
{
	/#
		if(!s1.visible || !s2.visible)
		{
			return;
		}
		p1 = s1.origin + (0, 0, (s1.weight * weightscale) + 100);
		p2 = s2.origin + (0, 0, (s2.weight * weightscale) + 100);
		line(p1, p2, (1, 1, 1));
	#/
}

/*
	Name: loopbotspawns
	Namespace: spawnlogic
	Checksum: 0x60B86675
	Offset: 0x4A88
	Size: 0x37A
	Parameters: 0
	Flags: None
*/
function loopbotspawns()
{
	/#
		while(true)
		{
			if(getdvarint(#"scr_killbots", 0) < 1)
			{
				wait(3);
				continue;
			}
			if(!isdefined(level.players))
			{
				waitframe(1);
				continue;
			}
			bots = [];
			for(i = 0; i < level.players.size; i++)
			{
				if(!isdefined(level.players[i]))
				{
					continue;
				}
				if(level.players[i].sessionstate == "" && issubstr(level.players[i].name, ""))
				{
					bots[bots.size] = level.players[i];
				}
			}
			if(bots.size > 0)
			{
				if(getdvarint(#"scr_killbots", 0) == 1)
				{
					killer = bots[randomint(bots.size)];
					victim = bots[randomint(bots.size)];
					victim thread [[level.callbackplayerdamage]](killer, killer, 1000, 0, "", level.weaponnone, (0, 0, 0), (0, 0, 0), "", 0, 0);
				}
				else
				{
					numkills = getdvarint(#"scr_killbots", 0);
					lastvictim = undefined;
					for(index = 0; index < numkills; index++)
					{
						killer = bots[randomint(bots.size)];
						victim = bots[randomint(bots.size)];
						while(isdefined(lastvictim) && victim == lastvictim)
						{
							victim = bots[randomint(bots.size)];
						}
						victim thread [[level.callbackplayerdamage]](killer, killer, 1000, 0, "", level.weaponnone, (0, 0, 0), (0, 0, 0), "", 0, 0);
						lastvictim = victim;
					}
				}
			}
			if(getdvarstring(#"scr_killbottimer") != "")
			{
				wait(getdvarfloat(#"scr_killbottimer", 0));
			}
			else
			{
				waitframe(1);
			}
		}
	#/
}

/*
	Name: allowspawndatareading
	Namespace: spawnlogic
	Checksum: 0xC9B1EE6B
	Offset: 0x4E10
	Size: 0x1F8
	Parameters: 0
	Flags: None
*/
function allowspawndatareading()
{
	/#
		setdvar(#"scr_showspawnid", "");
		prevval = getdvarstring(#"scr_showspawnid");
		prevrelval = getdvarstring(#"scr_spawnidcycle");
		readthistime = 0;
		while(true)
		{
			val = getdvarstring(#"scr_showspawnid");
			relval = undefined;
			if(!isdefined(val) || val == prevval)
			{
				relval = getdvarstring(#"scr_spawnidcycle");
				if(isdefined(relval) && relval != "")
				{
					setdvar(#"scr_spawnidcycle", "");
				}
				else
				{
					wait(0.5);
					continue;
				}
			}
			prevval = val;
			readthistime = 0;
			readspawndata(val, relval);
			if(!isdefined(level.curspawndata))
			{
				println("");
			}
			else
			{
				println("" + level.curspawndata.id);
			}
			thread drawspawndata();
		}
	#/
}

/*
	Name: showdeathsdebug
	Namespace: spawnlogic
	Checksum: 0xD866F77B
	Offset: 0x5010
	Size: 0x472
	Parameters: 0
	Flags: None
*/
function showdeathsdebug()
{
	/#
		while(true)
		{
			if(!getdvarint(#"scr_spawnpointdebug", 0))
			{
				wait(3);
				continue;
			}
			time = gettime();
			for(i = 0; i < level.spawnlogic_deaths.size; i++)
			{
				if(isdefined(level.spawnlogic_deaths[i].los))
				{
					line(level.spawnlogic_deaths[i].org, level.spawnlogic_deaths[i].killorg, (1, 0, 0));
				}
				else
				{
					line(level.spawnlogic_deaths[i].org, level.spawnlogic_deaths[i].killorg, (1, 1, 1));
				}
				killer = level.spawnlogic_deaths[i].killer;
				if(isdefined(killer) && isalive(killer))
				{
					line(level.spawnlogic_deaths[i].killorg, killer.origin, (0.4, 0.4, 0.8));
				}
			}
			for(p = 0; p < level.players.size; p++)
			{
				if(!isdefined(level.players[p]))
				{
					continue;
				}
				if(isdefined(level.players[p].spawnlogic_killdist))
				{
					print3d(level.players[p].origin + vectorscale((0, 0, 1), 64), level.players[p].spawnlogic_killdist, (1, 1, 1));
				}
			}
			oldspawnkills = level.spawnlogic_spawnkills;
			level.spawnlogic_spawnkills = [];
			for(i = 0; i < oldspawnkills.size; i++)
			{
				spawnkill = oldspawnkills[i];
				if(spawnkill.dierwasspawner)
				{
					line(spawnkill.spawnpointorigin, spawnkill.dierorigin, (0.4, 0.5, 0.4));
					line(spawnkill.dierorigin, spawnkill.killerorigin, (0, 1, 1));
					print3d(spawnkill.dierorigin + vectorscale((0, 0, 1), 32), "", (0, 1, 1));
				}
				else
				{
					line(spawnkill.spawnpointorigin, spawnkill.killerorigin, (0.4, 0.5, 0.4));
					line(spawnkill.killerorigin, spawnkill.dierorigin, (0, 1, 1));
					print3d(spawnkill.dierorigin + vectorscale((0, 0, 1), 32), "", (0, 1, 1));
				}
				if(time - spawnkill.time < 60000)
				{
					level.spawnlogic_spawnkills[level.spawnlogic_spawnkills.size] = oldspawnkills[i];
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: updatedeathinfodebug
	Namespace: spawnlogic
	Checksum: 0xCA9F84C5
	Offset: 0x5490
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function updatedeathinfodebug()
{
	while(true)
	{
		if(!getdvarint(#"scr_spawnpointdebug", 0))
		{
			wait(3);
			continue;
		}
		updatedeathinfo();
		wait(3);
	}
}

/*
	Name: spawnweightdebug
	Namespace: spawnlogic
	Checksum: 0x3F48BC42
	Offset: 0x54F0
	Size: 0x2E0
	Parameters: 1
	Flags: Linked
*/
function spawnweightdebug(spawnpoints)
{
	level notify(#"stop_spawn_weight_debug");
	level endon(#"stop_spawn_weight_debug");
	/#
		while(true)
		{
			if(!getdvarint(#"scr_spawnpointdebug", 0))
			{
				wait(3);
				continue;
			}
			textoffset = vectorscale((0, 0, -1), 12);
			for(i = 0; i < spawnpoints.size; i++)
			{
				amnt = 1 * (1 - (spawnpoints[i].weight / 100000));
				if(amnt < 0)
				{
					amnt = 0;
				}
				if(amnt > 1)
				{
					amnt = 1;
				}
				orig = spawnpoints[i].origin + vectorscale((0, 0, 1), 80);
				print3d(orig, int(spawnpoints[i].weight), (1, amnt, 0.5));
				orig = orig + textoffset;
				if(isdefined(spawnpoints[i].spawndata))
				{
					for(j = 0; j < spawnpoints[i].spawndata.size; j++)
					{
						print3d(orig, spawnpoints[i].spawndata[j], vectorscale((1, 1, 1), 0.5));
						orig = orig + textoffset;
					}
				}
				if(isdefined(spawnpoints[i].sightchecks))
				{
					for(j = 0; j < spawnpoints[i].sightchecks.size; j++)
					{
						if(spawnpoints[i].sightchecks[j].penalty == 0)
						{
							continue;
						}
						print3d(orig, "" + spawnpoints[i].sightchecks[j].penalty, vectorscale((1, 1, 1), 0.5));
						orig = orig + textoffset;
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: profiledebug
	Namespace: spawnlogic
	Checksum: 0x925754CD
	Offset: 0x57D8
	Size: 0xEE
	Parameters: 0
	Flags: None
*/
function profiledebug()
{
	while(true)
	{
		if(!getdvarint(#"scr_spawnpointprofile", 0))
		{
			wait(3);
			continue;
		}
		for(i = 0; i < level.spawnpoints.size; i++)
		{
			level.spawnpoints[i].weight = randomint(10000);
		}
		if(level.players.size > 0)
		{
			level.players[randomint(level.players.size)] getspawnpoint_nearteam(level.spawnpoints);
		}
		waitframe(1);
	}
}

/*
	Name: debugnearbyplayers
	Namespace: spawnlogic
	Checksum: 0xA5CDBDFE
	Offset: 0x58D0
	Size: 0xD2
	Parameters: 2
	Flags: None
*/
function debugnearbyplayers(players, origin)
{
	/#
		if(!getdvarint(#"scr_spawnpointdebug", 0))
		{
			return;
		}
		starttime = gettime();
		while(true)
		{
			for(i = 0; i < players.size; i++)
			{
				line(players[i].origin, origin, (0.5, 1, 0.5));
			}
			if(gettime() - starttime > 5000)
			{
				return;
			}
			waitframe(1);
		}
	#/
}

/*
	Name: deathoccured
	Namespace: spawnlogic
	Checksum: 0xC24D4E92
	Offset: 0x59B0
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function deathoccured(dier, killer)
{
}

/*
	Name: checkforsimilardeaths
	Namespace: spawnlogic
	Checksum: 0xDE1CA5C1
	Offset: 0x59D0
	Size: 0x104
	Parameters: 1
	Flags: None
*/
function checkforsimilardeaths(deathinfo)
{
	for(i = 0; i < level.spawnlogic_deaths.size; i++)
	{
		if(level.spawnlogic_deaths[i].killer == deathinfo.killer)
		{
			dist = distance(level.spawnlogic_deaths[i].org, deathinfo.org);
			if(dist > 200)
			{
				continue;
			}
			dist = distance(level.spawnlogic_deaths[i].killorg, deathinfo.killorg);
			if(dist > 200)
			{
				continue;
			}
			level.spawnlogic_deaths[i].remove = 1;
		}
	}
}

/*
	Name: updatedeathinfo
	Namespace: spawnlogic
	Checksum: 0xC1EB936E
	Offset: 0x5AE0
	Size: 0x1D8
	Parameters: 0
	Flags: Linked
*/
function updatedeathinfo()
{
	time = gettime();
	for(i = 0; i < level.spawnlogic_deaths.size; i++)
	{
		deathinfo = level.spawnlogic_deaths[i];
		if((time - deathinfo.time) > 90000 || !isdefined(deathinfo.killer) || !isalive(deathinfo.killer) || !isdefined(level.teams[deathinfo.killer.team]) || distance(deathinfo.killer.origin, deathinfo.killorg) > 400)
		{
			level.spawnlogic_deaths[i].remove = 1;
		}
	}
	oldarray = level.spawnlogic_deaths;
	level.spawnlogic_deaths = [];
	start = 0;
	if(oldarray.size - 1024 > 0)
	{
		start = oldarray.size - 1024;
	}
	for(i = start; i < oldarray.size; i++)
	{
		if(!isdefined(oldarray[i].remove))
		{
			level.spawnlogic_deaths[level.spawnlogic_deaths.size] = oldarray[i];
		}
	}
}

/*
	Name: avoidweapondamage
	Namespace: spawnlogic
	Checksum: 0xB5E06F3F
	Offset: 0x5CC0
	Size: 0x1D2
	Parameters: 1
	Flags: Linked
*/
function avoidweapondamage(spawnpoints)
{
	if(!getdvarstring(#"scr_spawnpointnewlogic"))
	{
		return;
	}
	weapondamagepenalty = 100000;
	if(isdefined(getdvar(#"scr_spawnpointweaponpenalty")))
	{
		weapondamagepenalty = getdvarfloat(#"scr_spawnpointweaponpenalty", 0);
	}
	mingrenadedistsquared = 62500;
	for(i = 0; i < spawnpoints.size; i++)
	{
		for(j = 0; j < level.grenades.size; j++)
		{
			if(!isdefined(level.grenades[j]))
			{
				continue;
			}
			if(distancesquared(spawnpoints[i].origin, level.grenades[j].origin) < mingrenadedistsquared)
			{
				spawnpoints[i].weight = spawnpoints[i].weight - weapondamagepenalty;
				/#
					if(level.storespawndata || level.debugspawning)
					{
						spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "" + int(weapondamagepenalty);
					}
				#/
			}
		}
	}
}

/*
	Name: spawnperframeupdate
	Namespace: spawnlogic
	Checksum: 0x232DD211
	Offset: 0x5EA0
	Size: 0x80
	Parameters: 0
	Flags: None
*/
function spawnperframeupdate()
{
	spawnpointindex = 0;
	while(true)
	{
		waitframe(1);
		if(!isdefined(level.spawnpoints))
		{
			return;
		}
		spawnpointindex = (spawnpointindex + 1) % level.spawnpoints.size;
		spawnpoint = level.spawnpoints[spawnpointindex];
		spawnpointupdate(spawnpoint);
	}
}

/*
	Name: getnonteamsum
	Namespace: spawnlogic
	Checksum: 0x104B2C58
	Offset: 0x5F28
	Size: 0xAE
	Parameters: 2
	Flags: Linked
*/
function getnonteamsum(skip_team, sums)
{
	value = 0;
	foreach(team, _ in level.teams)
	{
		if(team == skip_team)
		{
			continue;
		}
		value = value + sums[team];
	}
	return value;
}

/*
	Name: getnonteammindist
	Namespace: spawnlogic
	Checksum: 0x182808F6
	Offset: 0x5FE0
	Size: 0xBE
	Parameters: 2
	Flags: Linked
*/
function getnonteammindist(skip_team, mindists)
{
	dist = 9999999;
	foreach(team, _ in level.teams)
	{
		if(team == skip_team)
		{
			continue;
		}
		if(dist > mindists[team])
		{
			dist = mindists[team];
		}
	}
	return dist;
}

/*
	Name: spawnpointupdate
	Namespace: spawnlogic
	Checksum: 0x6D8A7FF9
	Offset: 0x60A8
	Size: 0x672
	Parameters: 1
	Flags: Linked
*/
function spawnpointupdate(spawnpoint)
{
	if(level.teambased)
	{
		sights = [];
		foreach(team, _ in level.teams)
		{
			spawnpoint.enemysights[team] = 0;
			sights[team] = 0;
			spawnpoint.nearbyplayers[team] = [];
		}
	}
	else
	{
		spawnpoint.enemysights = 0;
		spawnpoint.nearbyplayers[#"all"] = [];
	}
	spawnpointdir = spawnpoint.forward;
	debug = 0;
	/#
		debug = getdvarint(#"scr_spawnpointdebug", 0) > 0;
	#/
	mindist = [];
	distsum = [];
	if(!level.teambased)
	{
		mindist[#"all"] = 9999999;
	}
	foreach(team, _ in level.teams)
	{
		spawnpoint.distsum[team] = 0;
		spawnpoint.enemydistsum[team] = 0;
		spawnpoint.minenemydist[team] = 9999999;
		mindist[team] = 9999999;
	}
	spawnpoint.numplayersatlastupdate = 0;
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];
		if(player.sessionstate != "playing")
		{
			continue;
		}
		diff = player.origin - spawnpoint.origin;
		diff = (diff[0], diff[1], 0);
		dist = length(diff);
		team = "all";
		if(level.teambased)
		{
			team = player.team;
		}
		if(dist < 1024)
		{
			spawnpoint.nearbyplayers[team][spawnpoint.nearbyplayers[team].size] = player;
		}
		if(dist < mindist[team])
		{
			mindist[team] = dist;
		}
		distsum[team] = distsum[team] + dist;
		spawnpoint.numplayersatlastupdate++;
		pdir = anglestoforward(player.angles);
		if(vectordot(spawnpointdir, diff) < 0 && vectordot(pdir, diff) > 0)
		{
			continue;
		}
		losexists = bullettracepassed(player.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, 0, undefined);
		spawnpoint.lastsighttracetime = gettime();
		if(losexists)
		{
			if(level.teambased)
			{
				sights[player.team]++;
			}
			else
			{
				spawnpoint.enemysights++;
			}
			/#
				if(debug)
				{
					line(player.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, (0.5, 1, 0.5));
				}
			#/
		}
	}
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			spawnpoint.enemysights[team] = getnonteamsum(team, sights);
			spawnpoint.minenemydist[team] = getnonteammindist(team, mindist);
			spawnpoint.distsum[team] = distsum[team];
			spawnpoint.enemydistsum[team] = getnonteamsum(team, distsum);
		}
	}
	else
	{
		spawnpoint.distsum[#"all"] = distsum[#"all"];
		spawnpoint.enemydistsum[#"all"] = distsum[#"all"];
		spawnpoint.minenemydist[#"all"] = mindist[#"all"];
	}
}

/*
	Name: getlospenalty
	Namespace: spawnlogic
	Checksum: 0xEFAFF606
	Offset: 0x6728
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function getlospenalty()
{
	if(isdefined(getdvar(#"scr_spawnpointlospenalty")) && getdvarint(#"scr_spawnpointlospenalty", 0))
	{
		return getdvarfloat(#"scr_spawnpointlospenalty", 0);
	}
	return 100000;
}

/*
	Name: lastminutesighttraces
	Namespace: spawnlogic
	Checksum: 0x4D8E3AB
	Offset: 0x67B0
	Size: 0x29E
	Parameters: 1
	Flags: Linked
*/
function lastminutesighttraces(spawnpoint)
{
	if(!isdefined(spawnpoint.nearbyplayers))
	{
		return 0;
	}
	closest = undefined;
	closestdistsq = undefined;
	secondclosest = undefined;
	secondclosestdistsq = undefined;
	foreach(team in spawnpoint.nearbyplayers)
	{
		if(team == self.team)
		{
			continue;
		}
		for(i = 0; i < spawnpoint.nearbyplayers[team].size; i++)
		{
			player = spawnpoint.nearbyplayers[team][i];
			if(!isdefined(player))
			{
				continue;
			}
			if(player.sessionstate != "playing")
			{
				continue;
			}
			if(player == self)
			{
				continue;
			}
			distsq = distancesquared(spawnpoint.origin, player.origin);
			if(!isdefined(closest) || distsq < closestdistsq)
			{
				secondclosest = closest;
				secondclosestdistsq = closestdistsq;
				closest = player;
				closestdistsq = distsq;
				continue;
			}
			if(!isdefined(secondclosest) || distsq < secondclosestdistsq)
			{
				secondclosest = player;
				secondclosestdistsq = distsq;
			}
		}
	}
	if(isdefined(closest))
	{
		if(bullettracepassed(closest.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, 0, undefined))
		{
			return 1;
		}
	}
	if(isdefined(secondclosest))
	{
		if(bullettracepassed(secondclosest.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, 0, undefined))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: avoidvisibleenemies
	Namespace: spawnlogic
	Checksum: 0x1FCB01D
	Offset: 0x6A58
	Size: 0x530
	Parameters: 2
	Flags: Linked
*/
function avoidvisibleenemies(spawnpoints, teambased)
{
	if(!getdvarint(#"scr_spawnpointnewlogic", 0))
	{
		return;
	}
	lospenalty = getlospenalty();
	mindistteam = self.team;
	if(teambased)
	{
		for(i = 0; i < spawnpoints.size; i++)
		{
			if(!isdefined(spawnpoints[i].enemysights))
			{
				continue;
			}
			penalty = lospenalty * spawnpoints[i].enemysights[self.team];
			spawnpoints[i].weight = spawnpoints[i].weight - penalty;
			/#
				if(level.storespawndata || level.debugspawning)
				{
					index = spawnpoints[i].sightchecks.size;
					spawnpoints[i].sightchecks[index] = spawnstruct();
					spawnpoints[i].sightchecks[index].penalty = penalty;
				}
			#/
		}
	}
	else
	{
		for(i = 0; i < spawnpoints.size; i++)
		{
			if(!isdefined(spawnpoints[i].enemysights))
			{
				continue;
			}
			penalty = lospenalty * spawnpoints[i].enemysights;
			spawnpoints[i].weight = spawnpoints[i].weight - penalty;
			/#
				if(level.storespawndata || level.debugspawning)
				{
					index = spawnpoints[i].sightchecks.size;
					spawnpoints[i].sightchecks[index] = spawnstruct();
					spawnpoints[i].sightchecks[index].penalty = penalty;
				}
			#/
		}
		mindistteam = "all";
	}
	avoidweight = getdvarfloat(#"scr_spawn_enemyavoidweight", 0);
	if(avoidweight != 0)
	{
		nearbyenemyouterrange = getdvarfloat(#"scr_spawn_enemyavoiddist", 800);
		nearbyenemyouterrangesq = nearbyenemyouterrange * nearbyenemyouterrange;
		nearbyenemypenalty = 1500 * avoidweight;
		nearbyenemyminorpenalty = 800 * avoidweight;
		lastattackerorigin = vectorscale((-1, -1, -1), 99999);
		lastdeathpos = vectorscale((-1, -1, -1), 99999);
		if(isalive(self.lastattacker))
		{
			lastattackerorigin = self.lastattacker.origin;
		}
		if(isdefined(self.lastdeathpos))
		{
			lastdeathpos = self.lastdeathpos;
		}
		for(i = 0; i < spawnpoints.size; i++)
		{
			mindist = spawnpoints[i].minenemydist[mindistteam];
			if(mindist < nearbyenemyouterrange * 2)
			{
				penalty = nearbyenemyminorpenalty * (1 - (mindist / (nearbyenemyouterrange * 2)));
				if(mindist < nearbyenemyouterrange)
				{
					penalty = penalty + (nearbyenemypenalty * (1 - (mindist / nearbyenemyouterrange)));
				}
				if(penalty > 0)
				{
					spawnpoints[i].weight = spawnpoints[i].weight - penalty;
					/#
						if(level.storespawndata || level.debugspawning)
						{
							spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = (("" + int(spawnpoints[i].minenemydist[mindistteam])) + "") + int(penalty);
						}
					#/
				}
			}
		}
	}
}

/*
	Name: avoidspawnreuse
	Namespace: spawnlogic
	Checksum: 0x99DCCA9E
	Offset: 0x6F90
	Size: 0x258
	Parameters: 2
	Flags: Linked
*/
function avoidspawnreuse(spawnpoints, teambased)
{
	if(!getdvarint(#"scr_spawnpointnewlogic", 0))
	{
		return;
	}
	time = gettime();
	maxtime = 10000;
	maxdistsq = 1048576;
	for(i = 0; i < spawnpoints.size; i++)
	{
		spawnpoint = spawnpoints[i];
		if(!isdefined(spawnpoint.lastspawnedplayer) || !isdefined(spawnpoint.lastspawntime) || !isalive(spawnpoint.lastspawnedplayer))
		{
			continue;
		}
		if(spawnpoint.lastspawnedplayer == self)
		{
			continue;
		}
		if(teambased && spawnpoint.lastspawnedplayer.team == self.team)
		{
			continue;
		}
		timepassed = time - spawnpoint.lastspawntime;
		if(timepassed < maxtime)
		{
			distsq = distancesquared(spawnpoint.lastspawnedplayer.origin, spawnpoint.origin);
			if(distsq < maxdistsq)
			{
				worsen = (5000 * (1 - (distsq / maxdistsq))) * (1 - (timepassed / maxtime));
				spawnpoint.weight = spawnpoint.weight - worsen;
				/#
					if(level.storespawndata || level.debugspawning)
					{
						spawnpoint.spawndata[spawnpoint.spawndata.size] = "" + worsen;
					}
				#/
			}
			else
			{
				spawnpoint.lastspawnedplayer = undefined;
			}
			continue;
		}
		spawnpoint.lastspawnedplayer = undefined;
	}
}

/*
	Name: avoidsamespawn
	Namespace: spawnlogic
	Checksum: 0x1D05A179
	Offset: 0x71F0
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function avoidsamespawn(spawnpoints)
{
	if(!getdvarint(#"scr_spawnpointnewlogic", 0))
	{
		return;
	}
	if(!isdefined(self.lastspawnpoint))
	{
		return;
	}
	for(i = 0; i < spawnpoints.size; i++)
	{
		if(spawnpoints[i] == self.lastspawnpoint)
		{
			spawnpoints[i].weight = spawnpoints[i].weight - 50000;
			/#
				if(level.storespawndata || level.debugspawning)
				{
					spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "";
				}
			#/
			break;
		}
	}
}

/*
	Name: getrandomintermissionpoint
	Namespace: spawnlogic
	Checksum: 0xE17A2F9F
	Offset: 0x72F0
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function getrandomintermissionpoint()
{
	spawnpoints = getentarray("mp_global_intermission", "classname");
	if(!spawnpoints.size)
	{
		spawnpoints = getentarray("info_player_start", "classname");
	}
	/#
		assert(spawnpoints.size);
	#/
	spawnpoint = getspawnpoint_random(spawnpoints);
	return spawnpoint;
}

