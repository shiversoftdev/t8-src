// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;

#namespace destructible;

/*
	Name: __init__system__
	Namespace: destructible
	Checksum: 0x5A43C771
	Offset: 0x208
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"destructible", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: destructible
	Checksum: 0x27EC2DDF
	Offset: 0x250
	Size: 0x14E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int");
	level.destructible_callbacks = [];
	destructibles = getentarray("destructible", "targetname");
	if(destructibles.size <= 0)
	{
		return;
	}
	for(i = 0; i < destructibles.size; i++)
	{
		if(getsubstr(destructibles[i].destructibledef, 0, 4) == "veh_")
		{
			destructibles[i] thread car_death_think();
			destructibles[i] thread car_grenade_stuck_think();
			continue;
		}
		if(destructibles[i].destructibledef == "fxdest_upl_metal_tank_01")
		{
			destructibles[i] thread tank_grenade_stuck_think();
		}
	}
}

/*
	Name: physics_explosion_and_rumble
	Namespace: destructible
	Checksum: 0xFEAEC2E2
	Offset: 0x3A8
	Size: 0x9C
	Parameters: 3
	Flags: Linked
*/
function physics_explosion_and_rumble(origin, radius, physics_explosion)
{
	/#
		assert(radius <= (pow(2, 10) - 1));
	#/
	if(isdefined(physics_explosion) && physics_explosion)
	{
		radius = radius + (1 << 9);
	}
	self clientfield::set("start_destructible_explosion", radius);
}

/*
	Name: event_callback
	Namespace: destructible
	Checksum: 0x41C3C03A
	Offset: 0x450
	Size: 0x452
	Parameters: 7
	Flags: Linked
*/
function event_callback(destructible_event, attacker, weapon, piece_index, point, dir, mod)
{
	explosion_radius = 0;
	if(issubstr(destructible_event, "explode") && destructible_event != "explode")
	{
		tokens = strtok(destructible_event, "_");
		explosion_radius = tokens[1];
		if(explosion_radius == "sm")
		{
			explosion_radius = 150;
		}
		else
		{
			if(explosion_radius == "lg")
			{
				explosion_radius = 450;
			}
			else
			{
				explosion_radius = int(explosion_radius);
			}
		}
		destructible_event = "explode_complex";
	}
	if(issubstr(destructible_event, "explosive"))
	{
		tokens = strtok(destructible_event, "_");
		explosion_radius_type = tokens[3];
		if(explosion_radius_type == "small")
		{
			explosion_radius = 150;
		}
		else
		{
			if(explosion_radius_type == "large")
			{
				explosion_radius = 450;
			}
			else
			{
				explosion_radius = 300;
			}
		}
	}
	if(issubstr(destructible_event, "simple_timed_explosion"))
	{
		self thread simple_timed_explosion(destructible_event, attacker);
		return;
	}
	switch(destructible_event)
	{
		case "destructible_car_explosion":
		{
			self car_explosion(attacker);
			if(isdefined(weapon))
			{
				self.destroyingweapon = weapon;
			}
			break;
		}
		case "destructible_car_fire":
		{
			level thread battlechatter::on_player_near_explodable(self, "car");
			self thread car_fire_think(attacker);
			if(isdefined(weapon))
			{
				self.destroyingweapon = weapon;
			}
			break;
		}
		case "explode":
		{
			self thread simple_explosion(attacker);
			break;
		}
		case "explode_complex":
		{
			self thread complex_explosion(attacker, explosion_radius);
			break;
		}
		case "destructible_explosive_incendiary_large":
		case "destructible_explosive_incendiary_small":
		{
			self explosive_incendiary_explosion(attacker, explosion_radius, 0);
			if(isdefined(weapon))
			{
				self.destroyingweapon = weapon;
			}
			break;
		}
		case "destructible_explosive_electrical_small":
		case "destructible_explosive_electrical_large":
		{
			self explosive_electrical_explosion(attacker, explosion_radius, 0);
			if(isdefined(weapon))
			{
				self.destroyingweapon = weapon;
			}
			break;
		}
		case "destructible_explosive_concussive_large":
		case "destructible_explosive_concussive_small":
		{
			self explosive_concussive_explosion(attacker, explosion_radius, 0);
			if(isdefined(weapon))
			{
				self.destroyingweapon = weapon;
			}
			break;
		}
		default:
		{
			break;
		}
	}
	if(isdefined(level.destructible_callbacks[destructible_event]))
	{
		self thread [[level.destructible_callbacks[destructible_event]]](destructible_event, attacker, weapon, piece_index, point, dir, mod);
	}
}

/*
	Name: simple_explosion
	Namespace: destructible
	Checksum: 0xFB6E4F14
	Offset: 0x8B0
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function simple_explosion(attacker)
{
	if(isdefined(self.exploded) && self.exploded)
	{
		return;
	}
	self.exploded = 1;
	offset = vectorscale((0, 0, 1), 5);
	self radiusdamage(self.origin + offset, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon(#"explodable_barrel"));
	physics_explosion_and_rumble(self.origin, 255, 1);
	if(isdefined(attacker))
	{
		self dodamage(self.health + 10000, self.origin + offset, attacker);
	}
	else
	{
		self dodamage(self.health + 10000, self.origin + offset);
	}
}

/*
	Name: simple_timed_explosion
	Namespace: destructible
	Checksum: 0x2B7787FF
	Offset: 0x9E8
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function simple_timed_explosion(destructible_event, attacker)
{
	self endon(#"death");
	wait_times = [];
	str = getsubstr(destructible_event, 23);
	tokens = strtok(str, "_");
	for(i = 0; i < tokens.size; i++)
	{
		wait_times[wait_times.size] = int(tokens[i]);
	}
	if(wait_times.size <= 0)
	{
		wait_times[0] = 5;
		wait_times[1] = 10;
	}
	wait(randomintrange(wait_times[0], wait_times[1]));
	simple_explosion(attacker);
}

/*
	Name: complex_explosion
	Namespace: destructible
	Checksum: 0x2610E81E
	Offset: 0xB30
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function complex_explosion(attacker, max_radius)
{
	offset = vectorscale((0, 0, 1), 5);
	if(isdefined(attacker))
	{
		self radiusdamage(self.origin + offset, max_radius, 300, 100, attacker);
	}
	else
	{
		self radiusdamage(self.origin + offset, max_radius, 300, 100);
	}
	physics_explosion_and_rumble(self.origin, max_radius, 1);
	if(isdefined(attacker))
	{
		self dodamage(20000, self.origin + offset, attacker);
	}
	else
	{
		self dodamage(20000, self.origin + offset);
	}
}

/*
	Name: car_explosion
	Namespace: destructible
	Checksum: 0x8A764902
	Offset: 0xC48
	Size: 0x1AC
	Parameters: 2
	Flags: Linked
*/
function car_explosion(attacker, physics_explosion)
{
	if(isdefined(self.car_dead) && self.car_dead)
	{
		return;
	}
	if(!isdefined(physics_explosion))
	{
		physics_explosion = 1;
	}
	self notify(#"car_dead");
	self.car_dead = 1;
	if(isdefined(attacker))
	{
		self radiusdamage(self.origin, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon(#"destructible_car"));
	}
	else
	{
		self radiusdamage(self.origin, 256, 300, 75);
	}
	physics_explosion_and_rumble(self.origin, 255, physics_explosion);
	if(isdefined(attacker))
	{
		attacker thread challenges::destroyed_car();
	}
	level.globalcarsdestroyed++;
	if(isdefined(attacker))
	{
		self dodamage(self.health + 10000, self.origin + (0, 0, 1), attacker);
	}
	else
	{
		self dodamage(self.health + 10000, self.origin + (0, 0, 1));
	}
	self markdestructibledestroyed();
}

/*
	Name: tank_grenade_stuck_think
	Namespace: destructible
	Checksum: 0xFCFA28E2
	Offset: 0xE00
	Size: 0xF0
	Parameters: 0
	Flags: Linked
*/
function tank_grenade_stuck_think()
{
	self endon(#"destructible_base_piece_death", #"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_stuck");
		missile = waitresult.projectile;
		if(!isdefined(missile) || !isdefined(missile.model))
		{
			continue;
		}
		if(missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world")
		{
			self thread tank_grenade_stuck_explode(missile);
		}
	}
}

/*
	Name: tank_grenade_stuck_explode
	Namespace: destructible
	Checksum: 0x3B449B81
	Offset: 0xEF8
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function tank_grenade_stuck_explode(missile)
{
	self endon(#"destructible_base_piece_death", #"death");
	owner = getmissileowner(missile);
	if(isdefined(owner) && missile.model == "wpn_t7_c4_world")
	{
		owner endon(#"disconnect", #"weapon_object_destroyed");
		missile endon(#"picked_up");
		missile thread tank_hacked_c4(self);
	}
	missile waittill(#"explode");
	if(isdefined(owner))
	{
		self dodamage(self.health + 10000, self.origin + (0, 0, 1), owner);
	}
	else
	{
		self dodamage(self.health + 10000, self.origin + (0, 0, 1));
	}
}

/*
	Name: tank_hacked_c4
	Namespace: destructible
	Checksum: 0x3298161A
	Offset: 0x1050
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function tank_hacked_c4(tank)
{
	tank endon(#"destructible_base_piece_death", #"death");
	self endon(#"death");
	self waittill(#"hacked");
	self notify(#"picked_up");
	tank thread tank_grenade_stuck_explode(self);
}

/*
	Name: car_death_think
	Namespace: destructible
	Checksum: 0x30611008
	Offset: 0x10E0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function car_death_think()
{
	self endon(#"car_dead");
	self.car_dead = 0;
	self thread car_death_notify();
	waitresult = undefined;
	waitresult = self waittill(#"destructible_base_piece_death");
	if(isdefined(self))
	{
		self thread car_explosion(waitresult.attacker, 0);
	}
}

/*
	Name: car_grenade_stuck_think
	Namespace: destructible
	Checksum: 0x3D994D76
	Offset: 0x1170
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function car_grenade_stuck_think()
{
	self endon(#"destructible_base_piece_death", #"car_dead", #"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_stuck");
		missile = waitresult.projectile;
		if(!isdefined(missile) || !isdefined(missile.model))
		{
			continue;
		}
		if(missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world")
		{
			self thread car_grenade_stuck_explode(missile);
		}
	}
}

/*
	Name: car_grenade_stuck_explode
	Namespace: destructible
	Checksum: 0xD5AF69F3
	Offset: 0x1278
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function car_grenade_stuck_explode(missile)
{
	self endon(#"destructible_base_piece_death", #"car_dead", #"death");
	owner = getmissileowner(missile);
	if(isdefined(owner) && missile.model == "wpn_t7_c4_world")
	{
		owner endon(#"disconnect", #"weapon_object_destroyed");
		missile endon(#"picked_up");
		missile thread car_hacked_c4(self);
	}
	missile waittill(#"explode");
	if(isdefined(owner))
	{
		self dodamage(self.health + 10000, self.origin + (0, 0, 1), owner);
	}
	else
	{
		self dodamage(self.health + 10000, self.origin + (0, 0, 1));
	}
}

/*
	Name: car_hacked_c4
	Namespace: destructible
	Checksum: 0x1776994A
	Offset: 0x13E0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function car_hacked_c4(car)
{
	car endon(#"destructible_base_piece_death", #"car_dead", #"death");
	self endon(#"death");
	self waittill(#"hacked");
	self notify(#"picked_up");
	car thread car_grenade_stuck_explode(self);
}

/*
	Name: car_death_notify
	Namespace: destructible
	Checksum: 0x6CE10BA6
	Offset: 0x1480
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function car_death_notify()
{
	self endon(#"car_dead");
	self notify(#"destructible_base_piece_death", self waittill(#"death"));
}

/*
	Name: car_fire_think
	Namespace: destructible
	Checksum: 0xF5020478
	Offset: 0x14C8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function car_fire_think(attacker)
{
	self endon(#"death");
	wait(randomintrange(7, 10));
	self thread car_explosion(attacker);
}

/*
	Name: codecallback_destructibleevent
	Namespace: destructible
	Checksum: 0x526F34EE
	Offset: 0x1528
	Size: 0x11C
	Parameters: 1
	Flags: Event
*/
event codecallback_destructibleevent(eventstruct)
{
	if(eventstruct.event == "broken")
	{
		event_callback(eventstruct.notify_type, eventstruct.attacker, eventstruct.weapon, eventstruct.piece, eventstruct.point, eventstruct.dir, eventstruct.mod);
		self notify(eventstruct.event, {#attacker:eventstruct.attacker, #type:eventstruct.notify_type});
	}
	else if(eventstruct.event == "breakafter")
	{
		self thread breakafter(eventstruct.time, eventstruct.amount, eventstruct.piece);
	}
}

/*
	Name: breakafter
	Namespace: destructible
	Checksum: 0xF37EF008
	Offset: 0x1650
	Size: 0x6C
	Parameters: 3
	Flags: Linked
*/
function breakafter(time, damage, piece)
{
	self notify(#"breakafter");
	self endon(#"breakafter");
	wait(time);
	self dodamage(damage, self.origin, undefined, undefined);
}

/*
	Name: explosive_incendiary_explosion
	Namespace: destructible
	Checksum: 0xAA854992
	Offset: 0x16C8
	Size: 0x174
	Parameters: 3
	Flags: Linked
*/
function explosive_incendiary_explosion(attacker, explosion_radius, physics_explosion)
{
	if(!isvehicle(self))
	{
		offset = vectorscale((0, 0, 1), 5);
		if(isdefined(attacker))
		{
			self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_BURNED", getweapon(#"incendiary_fire"));
		}
		else
		{
			self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
		}
		physics_explosion_and_rumble(self.origin, 255, physics_explosion);
	}
	if(isdefined(self.target))
	{
		dest_clip = getent(self.target, "targetname");
		if(isdefined(dest_clip))
		{
			dest_clip delete();
		}
	}
	self markdestructibledestroyed();
}

/*
	Name: explosive_electrical_explosion
	Namespace: destructible
	Checksum: 0x4FB6B421
	Offset: 0x1848
	Size: 0x154
	Parameters: 3
	Flags: Linked
*/
function explosive_electrical_explosion(attacker, explosion_radius, physics_explosion)
{
	if(!isvehicle(self))
	{
		offset = vectorscale((0, 0, 1), 5);
		if(isdefined(attacker))
		{
			self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_ELECTROCUTED");
		}
		else
		{
			self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
		}
		physics_explosion_and_rumble(self.origin, 255, physics_explosion);
	}
	if(isdefined(self.target))
	{
		dest_clip = getent(self.target, "targetname");
		if(isdefined(dest_clip))
		{
			dest_clip delete();
		}
	}
	self markdestructibledestroyed();
}

/*
	Name: explosive_concussive_explosion
	Namespace: destructible
	Checksum: 0x8AA4B95D
	Offset: 0x19A8
	Size: 0x154
	Parameters: 3
	Flags: Linked
*/
function explosive_concussive_explosion(attacker, explosion_radius, physics_explosion)
{
	if(!isvehicle(self))
	{
		offset = vectorscale((0, 0, 1), 5);
		if(isdefined(attacker))
		{
			self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_GRENADE");
		}
		else
		{
			self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
		}
		physics_explosion_and_rumble(self.origin, 255, physics_explosion);
	}
	if(isdefined(self.target))
	{
		dest_clip = getent(self.target, "targetname");
		if(isdefined(dest_clip))
		{
			dest_clip delete();
		}
	}
	self markdestructibledestroyed();
}

