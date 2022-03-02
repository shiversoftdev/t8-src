// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\gametypes\globallogic_player.gsc;

#namespace destructible;

/*
	Name: function_89f2df9
	Namespace: destructible
	Checksum: 0xC8853A8F
	Offset: 0x1D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"destructible", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: destructible
	Checksum: 0xC62AA103
	Offset: 0x218
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.destructible_callbacks = [];
	destructibles = getentarray("destructible", "targetname");
	clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int");
	if(destructibles.size <= 0)
	{
		return;
	}
	for(i = 0; i < destructibles.size; i++)
	{
		if(getsubstr(destructibles[i].destructibledef, 0, 4) == "veh_")
		{
			destructibles[i] thread destructible_car_death_think();
			destructibles[i] thread destructible_car_grenade_stuck_think();
		}
	}
}

/*
	Name: physics_explosion_and_rumble
	Namespace: destructible
	Checksum: 0xD3F95BEF
	Offset: 0x330
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
	Name: destructible_event_callback
	Namespace: destructible
	Checksum: 0xF49C6E69
	Offset: 0x3D8
	Size: 0x496
	Parameters: 3
	Flags: None
*/
function destructible_event_callback(destructible_event, attacker, weapon)
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
		damage_type = tokens[2];
		explosion_radius_type = tokens[3];
		explosion_radius = 300;
		switch(damage_type)
		{
			case "concussive":
			{
				if(explosion_radius_type == "large")
				{
					explosion_radius = 280;
				}
				else
				{
					explosion_radius = 220;
				}
				break;
			}
			case "electrical":
			{
				if(explosion_radius_type == "large")
				{
					explosion_radius = 60;
				}
				else
				{
					explosion_radius = 210;
				}
				break;
			}
			case "incendiary":
			{
				if(explosion_radius_type == "large")
				{
					explosion_radius = 250;
				}
				else
				{
					explosion_radius = 200;
				}
				break;
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
			self destructible_car_explosion(attacker);
			if(isdefined(weapon))
			{
				self.destroyingweapon = weapon;
			}
			break;
		}
		case "destructible_car_fire":
		{
			self thread destructible_car_fire_think(attacker);
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
		self thread [[level.destructible_callbacks[destructible_event]]](destructible_event, attacker);
	}
}

/*
	Name: simple_explosion
	Namespace: destructible
	Checksum: 0x58C9F429
	Offset: 0x878
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function simple_explosion(attacker)
{
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
	Checksum: 0xFD4DC613
	Offset: 0x988
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
	Checksum: 0xA7AF96C9
	Offset: 0xAD0
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
	Name: destructible_car_explosion
	Namespace: destructible
	Checksum: 0x891DE267
	Offset: 0xBE8
	Size: 0x1A4
	Parameters: 2
	Flags: Linked
*/
function destructible_car_explosion(attacker, physics_explosion)
{
	if(self.car_dead)
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
	Name: destructible_car_death_think
	Namespace: destructible
	Checksum: 0x6BC5469F
	Offset: 0xD98
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function destructible_car_death_think()
{
	self endon(#"car_dead");
	self.car_dead = 0;
	self thread destructible_car_death_notify();
	waitresult = undefined;
	waitresult = self waittill(#"destructible_base_piece_death");
	if(isdefined(self))
	{
		self thread destructible_car_explosion(waitresult.attacker, 0);
	}
}

/*
	Name: destructible_car_grenade_stuck_think
	Namespace: destructible
	Checksum: 0x36346D44
	Offset: 0xE28
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function destructible_car_grenade_stuck_think()
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
			self thread destructible_car_grenade_stuck_explode(missile);
		}
	}
}

/*
	Name: destructible_car_grenade_stuck_explode
	Namespace: destructible
	Checksum: 0x3E44B9ED
	Offset: 0xF30
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function destructible_car_grenade_stuck_explode(missile)
{
	self endon(#"destructible_base_piece_death", #"car_dead", #"death");
	owner = getmissileowner(missile);
	if(isdefined(owner) && missile.model == "wpn_t7_c4_world")
	{
		owner endon(#"disconnect", #"weapon_object_destroyed");
		missile endon(#"picked_up");
		missile thread destructible_car_hacked_c4(self);
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
	Name: destructible_car_hacked_c4
	Namespace: destructible
	Checksum: 0xF4DA10E9
	Offset: 0x1098
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function destructible_car_hacked_c4(car)
{
	car endon(#"destructible_base_piece_death", #"car_dead", #"death");
	self endon(#"death");
	self waittill(#"hacked");
	self notify(#"picked_up");
	car thread destructible_car_grenade_stuck_explode(self);
}

/*
	Name: destructible_car_death_notify
	Namespace: destructible
	Checksum: 0x4A651825
	Offset: 0x1138
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function destructible_car_death_notify()
{
	self endon(#"car_dead");
	self notify(#"destructible_base_piece_death", self waittill(#"death"));
}

/*
	Name: destructible_car_fire_think
	Namespace: destructible
	Checksum: 0xEEF19D9A
	Offset: 0x1180
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function destructible_car_fire_think(attacker)
{
	self endon(#"death");
	wait(randomintrange(7, 10));
	self thread destructible_car_explosion(attacker);
}

/*
	Name: breakafter
	Namespace: destructible
	Checksum: 0xA4D5346E
	Offset: 0x11E0
	Size: 0x6C
	Parameters: 3
	Flags: None
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
	Checksum: 0x7077EE0D
	Offset: 0x1258
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
			self radiusdamage(self.origin + offset, explosion_radius, 380, 95, attacker, "MOD_BURNED", getweapon(#"incendiary_fire"));
		}
		else
		{
			self radiusdamage(self.origin + offset, explosion_radius, 380, 95);
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
	Checksum: 0x7220851B
	Offset: 0x13D8
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
			self radiusdamage(self.origin + offset, explosion_radius, 350, 80, attacker, "MOD_ELECTROCUTED");
		}
		else
		{
			self radiusdamage(self.origin + offset, explosion_radius, 350, 80);
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
	Checksum: 0x40AF8C5F
	Offset: 0x1538
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
			self radiusdamage(self.origin + offset, explosion_radius, 300, 50, attacker, "MOD_GRENADE");
		}
		else
		{
			self radiusdamage(self.origin + offset, explosion_radius, 300, 50);
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

