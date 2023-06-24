// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_drop.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace wz_ai;

/*
	Name: __init__system__
	Namespace: wz_ai
	Checksum: 0xAF8C399D
	Offset: 0x130
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_ai", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_ai
	Checksum: 0x1720DA32
	Offset: 0x178
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	clientfield::register("vehicle", "enable_on_radar", 1, 1, "int");
	clientfield::register("actor", "enable_on_radar", 1, 1, "int");
}

/*
	Name: ai_init
	Namespace: wz_ai
	Checksum: 0x85974F0
	Offset: 0x1E8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function ai_init()
{
	function_41822a58();
}

/*
	Name: function_41822a58
	Namespace: wz_ai
	Checksum: 0x1D0207F1
	Offset: 0x208
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_41822a58()
{
	if(getdvarint(#"hash_20cd968623dbb8ef", 0))
	{
		patrolspawns = struct::get_array("wz_patrol_loc", "targetname");
		foreach(spot in patrolspawns)
		{
			level thread function_afce0cdb(spot);
		}
	}
}

/*
	Name: function_afce0cdb
	Namespace: wz_ai
	Checksum: 0xBBEF4C30
	Offset: 0x2D8
	Size: 0x5B0
	Parameters: 1
	Flags: Linked
*/
function function_afce0cdb(spawn_loc)
{
	level endon(#"game_ended");
	if(!ispointonnavmesh(spawn_loc.origin))
	{
		return;
	}
	parms = strtok(spawn_loc.script_parameters, ";");
	/#
		assert(parms.size == 5);
	#/
	zone = spawnstruct();
	if(!isdefined(zone))
	{
		return;
	}
	zone.name = parms[0];
	zone.volume = getent(zone.name, "targetname");
	zone.mins = zone.volume.origin + zone.volume.mins;
	zone.maxs = zone.volume.origin + zone.volume.maxs;
	zone.var_c6328f73 = int(parms[1]);
	zone.is_vehicle = int(parms[2]);
	zone.fovcosine = cos(int(parms[4]));
	zone.goalradius = (isdefined(spawn_loc.radius) ? spawn_loc.radius : 4096);
	zone.maxsightdistsqrd = int(parms[3]) * int(parms[3]);
	zone.type = spawn_loc.script_noteworthy;
	zone thread function_77a4c7ab();
	patroller = undefined;
	while(true)
	{
		if(zone.var_c6328f73 < 1)
		{
			return;
		}
		while(!(isdefined(zone.is_occupied) && zone.is_occupied))
		{
			wait(randomintrange(2, 6));
		}
		if(!isdefined(patroller))
		{
			if(isdefined(zone.is_vehicle) && zone.is_vehicle)
			{
				patroller = spawnvehicle(spawn_loc.script_noteworthy, spawn_loc.origin, (0, 0, 0), "wz_patrol_veh_ai");
			}
			else
			{
				patroller = spawnactor(spawn_loc.script_noteworthy, spawn_loc.origin, (0, 0, 0), "wz_patrol_ai");
			}
			if(isdefined(patroller))
			{
				patroller clientfield::set("enable_on_radar", 1);
				patroller.goalradius = zone.goalradius;
				patroller.maxsightdistsqrd = zone.maxsightdistsqrd;
				patroller.fovcosine = zone.fovcosine;
				patroller.zone = zone;
				if(patroller.archetype === #"amws")
				{
					patroller.scan_turret = 1;
					patroller.var_9b4a5686 = 1;
					patroller.var_a8c60b0e = 1;
				}
				if(isdefined(spawn_loc.target))
				{
					node = getnode(spawn_loc.target, "targetname");
					if(isdefined(node))
					{
						patroller thread function_f8e46115(node, patroller.goalradius);
					}
					else
					{
						patroller setgoal(patroller.origin);
					}
				}
				else
				{
					patroller setgoal(patroller.origin);
				}
				patroller thread function_b25a6169();
				patroller thread function_7820dead();
				zone thread function_9fc23101(patroller);
				zone thread function_af46682(patroller);
			}
		}
		while(isdefined(zone.is_occupied) && zone.is_occupied)
		{
			wait(randomintrange(2, 6));
		}
		if(isdefined(patroller))
		{
			patroller delete();
		}
	}
}

/*
	Name: function_f7c5e2f0
	Namespace: wz_ai
	Checksum: 0xCBB280E9
	Offset: 0x890
	Size: 0xB6
	Parameters: 3
	Flags: None
*/
function function_f7c5e2f0(point, mins, maxs)
{
	return point[0] >= mins[0] && point[0] <= maxs[0] && (point[1] >= mins[1] && point[1] <= maxs[1]) && (point[2] >= mins[2] && point[2] <= maxs[2]);
}

/*
	Name: function_77a4c7ab
	Namespace: wz_ai
	Checksum: 0x17A5EE8
	Offset: 0x950
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_77a4c7ab()
{
	level endon(#"game_ended");
	self.is_occupied = 0;
	while(true)
	{
		self.is_occupied = 0;
		foreach(player in getplayers())
		{
			if(!isdefined(player) || !isalive(player))
			{
				continue;
			}
			istouching = player istouching(self.volume);
			if(istouching)
			{
				self.is_occupied = 1;
				break;
			}
		}
		wait(randomfloatrange(2, 4));
	}
}

/*
	Name: function_c5fad73b
	Namespace: wz_ai
	Checksum: 0xB6B55034
	Offset: 0xA80
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function function_c5fad73b(type)
{
	items = [];
	switch(type)
	{
		case "hash_33ccea7be2e5f439":
		{
			break;
		}
		default:
		{
			break;
		}
	}
	return items;
}

/*
	Name: function_9fc23101
	Namespace: wz_ai
	Checksum: 0xA912DF1A
	Offset: 0xAE8
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function function_9fc23101(patroller)
{
	type = patroller.type;
	waitresult = undefined;
	waitresult = patroller waittill(#"death");
	attacker = waitresult.attacker;
	if(isdefined(attacker) && attacker != patroller)
	{
		self.var_c6328f73--;
	}
}

/*
	Name: function_ff88da82
	Namespace: wz_ai
	Checksum: 0xAB5C9717
	Offset: 0xB70
	Size: 0x28
	Parameters: 3
	Flags: None
*/
function function_ff88da82(origin, angles, items)
{
	if(!items.size)
	{
		return;
	}
}

/*
	Name: function_f8e46115
	Namespace: wz_ai
	Checksum: 0x5DB96E67
	Offset: 0xBA0
	Size: 0x23C
	Parameters: 2
	Flags: Linked
*/
function function_f8e46115(node, oldgoalradius)
{
	self endon(#"death");
	level endon(#"game_ended");
	self notify("488af40167c3a4a7");
	self endon("488af40167c3a4a7");
	if(isdefined(self.enemy))
	{
		self.goalradius = oldgoalradius;
		wait(randomintrange(3, 6));
		self thread function_f8e46115(node, oldgoalradius);
		return;
	}
	if(!isdefined(node))
	{
		self setgoal(self.origin);
		self.goalradius = oldgoalradius;
		return;
	}
	if(isdefined(node.radius))
	{
		self.goalradius = node.radius;
	}
	else
	{
		self.goalradius = 512;
	}
	self setgoal(node);
	if(isdefined(self.scan_turret) && self.scan_turret)
	{
		self turretsettargetangles(0, (0, self.angles[1], 0));
	}
	isatgoal = 0;
	while(!isatgoal)
	{
		var_1f2328d0 = self function_4794d6a3();
		isatgoal = isdefined(var_1f2328d0.isatgoal) && var_1f2328d0.isatgoal || (self isapproachinggoal() && isdefined(self.overridegoalpos));
		wait(1);
	}
	if(isdefined(node.target))
	{
		self thread function_f8e46115(getnode(node.target, "targetname"), oldgoalradius);
	}
}

/*
	Name: function_7820dead
	Namespace: wz_ai
	Checksum: 0x63DB72A5
	Offset: 0xDE8
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_7820dead()
{
	self endon(#"death");
	level endon(#"game_ended");
	self notify("27ad2aca1861b8c8");
	self endon("27ad2aca1861b8c8");
	waitresult = undefined;
	waitresult = self waittill(#"damage");
	if(isdefined(waitresult.attacker) && isplayer(waitresult.attacker))
	{
		self.favoriteenemy = waitresult.attacker;
		wait(5);
		self.favoriteenemy = undefined;
	}
	self thread function_7820dead();
}

/*
	Name: function_b25a6169
	Namespace: wz_ai
	Checksum: 0x6E4CF2E5
	Offset: 0xEC0
	Size: 0x1C0
	Parameters: 0
	Flags: Linked
*/
function function_b25a6169()
{
	self endon(#"death");
	level endon(#"game_ended");
	self notify("7c5dbe7edcfd4795");
	self endon("7c5dbe7edcfd4795");
	goalradius = self.goalradius;
	var_1a93f447 = 5;
	while(true)
	{
		if(isdefined(self.enemy))
		{
			self.goalradius = 1024;
			if(!self cansee(self.enemy))
			{
				var_1a93f447--;
				if(var_1a93f447 < 1)
				{
					self clearenemy();
					var_1a93f447 = 5;
				}
			}
			else
			{
				self setgoal(self.enemy.origin);
			}
		}
		else
		{
			self.goalradius = goalradius;
			if(isdefined(self.scan_turret) && self.scan_turret)
			{
				if(randomint(100) > 50)
				{
					self turretsettargetangles(0, (0, self.angles[1], 0));
				}
				else
				{
					self turretsettargetangles(0, (0, randomint(360), 0));
				}
			}
		}
		wait(randomintrange(3, 6));
	}
}

/*
	Name: function_af46682
	Namespace: wz_ai
	Checksum: 0xD927A6D8
	Offset: 0x1088
	Size: 0x128
	Parameters: 1
	Flags: Linked
*/
function function_af46682(patroller)
{
	level endon(#"game_ended", #"hash_12a8f2c59a67e4fc");
	patroller endon(#"death");
	while(!isdefined(level.deathcircle))
	{
		wait(1);
	}
	while(isdefined(patroller))
	{
		distsq = distance2dsquared(patroller.origin, level.deathcircle.origin);
		if(distsq > level.deathcircle.radius * level.deathcircle.radius)
		{
			patroller dodamage(patroller.health, patroller.origin, level.deathcircle);
			self.var_c6328f73 = 0;
		}
		wait(randomint(10));
	}
}

