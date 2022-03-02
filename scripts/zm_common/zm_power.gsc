// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\demo_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_power;

/*
	Name: function_89f2df9
	Namespace: zm_power
	Checksum: 0x6678A63C
	Offset: 0x210
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_power", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_power
	Checksum: 0xA945DFE0
	Offset: 0x260
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.powered_items = [];
	level.local_power = [];
}

/*
	Name: __main__
	Namespace: zm_power
	Checksum: 0x938F0128
	Offset: 0x288
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	thread standard_powered_items();
	level thread electric_switch_init();
	/#
		thread debug_powered_items();
	#/
}

/*
	Name: debug_powered_items
	Namespace: zm_power
	Checksum: 0x585175D7
	Offset: 0x2D8
	Size: 0xEA
	Parameters: 0
	Flags: None
*/
function debug_powered_items()
{
	/#
		while(true)
		{
			if(getdvarint(#"zombie_equipment_health", 0))
			{
				if(isdefined(level.local_power))
				{
					foreach(localpower in level.local_power)
					{
						circle(localpower.origin, localpower.radius, (1, 0, 0), 0, 1, 1);
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: electric_switch_init
	Namespace: zm_power
	Checksum: 0x21DB757B
	Offset: 0x3D0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function electric_switch_init()
{
	trigs = getentarray("use_elec_switch", "targetname");
	if(isdefined(level.temporary_power_switch_logic))
	{
		array::thread_all(trigs, level.temporary_power_switch_logic, trigs);
	}
	else
	{
		array::thread_all(trigs, &electric_switch);
	}
}

/*
	Name: electric_switch
	Namespace: zm_power
	Checksum: 0x8015001C
	Offset: 0x460
	Size: 0x810
	Parameters: 0
	Flags: Linked
*/
function electric_switch()
{
	self endon(#"hash_21e36726a7f30458");
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.target))
	{
		ent_parts = getentarray(self.target, "targetname");
		struct_parts = struct::get_array(self.target, "targetname");
		foreach(ent in ent_parts)
		{
			if(isdefined(ent.script_noteworthy))
			{
				master_switch = ent;
				switch(ent.script_noteworthy)
				{
					case "elec_switch":
					{
						break;
					}
					case "hash_47bde376753a03c9":
					{
						break;
					}
					case "artifact_mind":
					{
						break;
					}
				}
			}
		}
		foreach(struct in struct_parts)
		{
			if(isdefined(struct.script_noteworthy) && struct.script_noteworthy == "elec_switch_fx")
			{
				fx_pos = struct;
			}
		}
	}
	while(isdefined(self))
	{
		if(isdefined(master_switch) && isdefined(master_switch.script_noteworthy) && (!(isdefined(self.var_1d2fecd6) && self.var_1d2fecd6)))
		{
			switch(master_switch.script_noteworthy)
			{
				case "elec_switch":
				{
					if(function_8b1a219a())
					{
						self sethintstring(#"hash_5c4125d53451e888");
					}
					else
					{
						self sethintstring(#"hash_5d8ba3059b5e82e4");
					}
					break;
				}
				case "hash_47bde376753a03c9":
				{
					if(function_8b1a219a())
					{
						self sethintstring(#"hash_5c4125d53451e888");
					}
					else
					{
						self sethintstring(#"hash_5d8ba3059b5e82e4");
					}
					break;
				}
				case "artifact_mind":
				{
					level waittill(#"player_spawned");
					if(function_8b1a219a())
					{
						self sethintstring(#"hash_10cc78ab5ba5a7f2");
					}
					else
					{
						self sethintstring(#"hash_60e4802baafefe56");
					}
					break;
				}
			}
		}
		self setvisibletoall();
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		user = waitresult.activator;
		if(isdefined(self.var_b9eb2dbb) && self.var_b9eb2dbb)
		{
			self.var_1d2fecd6 = 1;
			waitframe(1);
			continue;
		}
		self setinvisibletoall();
		power_zone = undefined;
		if(isdefined(self.script_int))
		{
			power_zone = self.script_int;
		}
		level thread zm_perks::perk_unpause_all_perks(power_zone);
		if(isdefined(master_switch) && isdefined(master_switch.script_noteworthy))
		{
			switch(master_switch.script_noteworthy)
			{
				case "elec_switch":
				{
					elec_switch_on(master_switch, fx_pos);
					break;
				}
				case "hash_47bde376753a03c9":
				{
					function_9d9892d2(master_switch);
					break;
				}
				case "artifact_mind":
				{
					artifact_mind_on(master_switch, fx_pos, user);
					break;
				}
			}
		}
		level turn_power_on_and_open_doors(power_zone);
		switchentnum = self getentitynumber();
		if(isdefined(switchentnum) && isdefined(user))
		{
			user recordmapevent(17, gettime(), user.origin, level.round_number, switchentnum);
		}
		if(isplayer(user))
		{
			user util::delay(1, "death", &zm_audio::create_and_play_dialog, #"power_switch", #"activate", undefined, 2);
		}
		if(!isdefined(self.script_noteworthy) || self.script_noteworthy != "allow_power_off")
		{
			self delete();
			return;
		}
		if(isdefined(master_switch) && isdefined(master_switch.script_noteworthy))
		{
			switch(master_switch.script_noteworthy)
			{
				case "elec_switch":
				{
					self sethintstring(#"hash_3071a199ee6ad7a6");
					break;
				}
			}
		}
		self setvisibletoall();
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		user = waitresult.activator;
		self setinvisibletoall();
		level thread zm_perks::perk_pause_all_perks(power_zone);
		if(isdefined(master_switch) && isdefined(master_switch.script_noteworthy))
		{
			switch(master_switch.script_noteworthy)
			{
				case "elec_switch":
				{
					elec_switch_off(master_switch);
					break;
				}
			}
		}
		if(isdefined(switchentnum) && isdefined(user))
		{
			user recordmapevent(18, gettime(), user.origin, level.round_number, switchentnum);
		}
		level turn_power_off_and_close_doors(power_zone);
	}
}

/*
	Name: elec_switch_on
	Namespace: zm_power
	Checksum: 0x870D4386
	Offset: 0xC78
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function elec_switch_on(master_switch, fx_pos)
{
	master_switch rotateroll(-90, 0.3);
	master_switch playsound(#"zmb_switch_flip");
	master_switch waittill(#"rotatedone");
	master_switch playsound(#"zmb_turn_on");
	if(isdefined(fx_pos))
	{
		playfx(level._effect[#"switch_sparks"], fx_pos.origin);
	}
}

/*
	Name: elec_switch_off
	Namespace: zm_power
	Checksum: 0xF94A7EEC
	Offset: 0xD48
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function elec_switch_off(master_switch)
{
	master_switch rotateroll(90, 0.3);
	master_switch waittill(#"rotatedone");
}

/*
	Name: function_9d9892d2
	Namespace: zm_power
	Checksum: 0x99DA707F
	Offset: 0xD98
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_9d9892d2(master_switch)
{
	if(isdefined(master_switch.model_on))
	{
		master_switch setmodel(master_switch.model_on);
	}
	if(isdefined(master_switch.bundle))
	{
		master_switch thread scene::play(master_switch.bundle, "ON", master_switch);
	}
}

/*
	Name: artifact_mind_on
	Namespace: zm_power
	Checksum: 0xEAC5B61C
	Offset: 0xE18
	Size: 0x48
	Parameters: 3
	Flags: Linked
*/
function artifact_mind_on(master_switch, fx_pos, user)
{
	level notify(#"hash_3e80d503318a5674", {#player:user});
}

/*
	Name: watch_global_power
	Namespace: zm_power
	Checksum: 0xDFBC211D
	Offset: 0xE68
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function watch_global_power()
{
	while(true)
	{
		level flag::wait_till("power_on");
		level thread set_global_power(1);
		level flag::wait_till_clear("power_on");
		level thread set_global_power(0);
	}
}

/*
	Name: standard_powered_items
	Namespace: zm_power
	Checksum: 0x2442FFBE
	Offset: 0xEF0
	Size: 0x374
	Parameters: 0
	Flags: Linked
*/
function standard_powered_items()
{
	level flag::wait_till("start_zombie_round_logic");
	vending_machines = zm_perks::get_perk_machines();
	foreach(trigger in vending_machines)
	{
		powered_on = zm_perks::get_perk_machine_start_state(trigger.script_noteworthy);
		powered_perk = add_powered_item(&perk_power_on, &perk_power_off, &perk_range, &cost_low_if_local, 0, powered_on, trigger);
		if(isdefined(trigger.script_int))
		{
			powered_perk thread zone_controlled_perk(trigger.script_int);
		}
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") != 0)
	{
		zombie_doors = getentarray("zombie_door", "targetname");
		foreach(door in zombie_doors)
		{
			if(isdefined(door.script_noteworthy) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door"))
			{
				add_powered_item(&door_power_on, &door_power_off, &door_range, &cost_door, 0, 0, door);
				continue;
			}
			if(isdefined(door.script_noteworthy) && door.script_noteworthy == "local_electric_door")
			{
				power_sources = 0;
				if(!(isdefined(level.power_local_doors_globally) && level.power_local_doors_globally))
				{
					power_sources = 1;
				}
				add_powered_item(&door_local_power_on, &door_local_power_off, &door_range, &cost_door, power_sources, 0, door);
			}
		}
	}
	thread watch_global_power();
}

/*
	Name: zone_controlled_perk
	Namespace: zm_power
	Checksum: 0xACF6F1A7
	Offset: 0x1270
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function zone_controlled_perk(zone)
{
	while(true)
	{
		power_flag = "power_on" + zone;
		level flag::wait_till(power_flag);
		self thread perk_power_on();
		level flag::wait_till_clear(power_flag);
		self thread perk_power_off();
	}
}

/*
	Name: add_powered_item
	Namespace: zm_power
	Checksum: 0x443A899C
	Offset: 0x1308
	Size: 0x112
	Parameters: 7
	Flags: Linked
*/
function add_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target)
{
	powered = spawnstruct();
	powered.power_on_func = power_on_func;
	powered.power_off_func = power_off_func;
	powered.range_func = range_func;
	powered.power_sources = power_sources;
	powered.self_powered = self_powered;
	powered.target = target;
	powered.cost_func = cost_func;
	powered.power = self_powered;
	powered.powered_count = self_powered;
	powered.depowered_count = 0;
	level.powered_items[level.powered_items.size] = powered;
	return powered;
}

/*
	Name: remove_powered_item
	Namespace: zm_power
	Checksum: 0xD78E0434
	Offset: 0x1428
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function remove_powered_item(powered)
{
	arrayremovevalue(level.powered_items, powered, 0);
}

/*
	Name: add_temp_powered_item
	Namespace: zm_power
	Checksum: 0x29CA3D74
	Offset: 0x1460
	Size: 0x1A0
	Parameters: 7
	Flags: None
*/
function add_temp_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target)
{
	powered = add_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target);
	if(isdefined(level.local_power))
	{
		foreach(localpower in level.local_power)
		{
			if(powered [[powered.range_func]](1, localpower.origin, localpower.radius))
			{
				powered change_power(1, localpower.origin, localpower.radius);
				if(!isdefined(localpower.added_list))
				{
					localpower.added_list = [];
				}
				localpower.added_list[localpower.added_list.size] = powered;
			}
		}
	}
	thread watch_temp_powered_item(powered);
	return powered;
}

/*
	Name: watch_temp_powered_item
	Namespace: zm_power
	Checksum: 0x897EED5
	Offset: 0x1608
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function watch_temp_powered_item(powered)
{
	powered.target waittill(#"death");
	remove_powered_item(powered);
	if(isdefined(level.local_power))
	{
		foreach(localpower in level.local_power)
		{
			if(isdefined(localpower.added_list))
			{
				arrayremovevalue(localpower.added_list, powered, 0);
			}
			if(isdefined(localpower.enabled_list))
			{
				arrayremovevalue(localpower.enabled_list, powered, 0);
			}
		}
	}
}

/*
	Name: change_power_in_radius
	Namespace: zm_power
	Checksum: 0x8C8DFA0C
	Offset: 0x1728
	Size: 0xE4
	Parameters: 3
	Flags: Linked
*/
function change_power_in_radius(delta, origin, radius)
{
	changed_list = [];
	for(i = 0; i < level.powered_items.size; i++)
	{
		powered = level.powered_items[i];
		if(powered.power_sources != 2 && powered [[powered.range_func]](delta, origin, radius))
		{
			powered change_power(delta, origin, radius);
			changed_list[changed_list.size] = powered;
		}
	}
	return changed_list;
}

/*
	Name: change_power
	Namespace: zm_power
	Checksum: 0xED919A77
	Offset: 0x1818
	Size: 0xA8
	Parameters: 3
	Flags: Linked
*/
function change_power(delta, origin, radius)
{
	if(delta > 0)
	{
		if(!self.power)
		{
			self.power = 1;
			self [[self.power_on_func]](origin, radius);
		}
		self.powered_count++;
	}
	else if(delta < 0)
	{
		if(self.power)
		{
			self.power = 0;
			self [[self.power_off_func]](origin, radius);
		}
		self.depowered_count++;
	}
}

/*
	Name: revert_power_to_list
	Namespace: zm_power
	Checksum: 0x3947D501
	Offset: 0x18C8
	Size: 0x7E
	Parameters: 4
	Flags: Linked
*/
function revert_power_to_list(delta, origin, radius, powered_list)
{
	for(i = 0; i < powered_list.size; i++)
	{
		powered = powered_list[i];
		powered revert_power(delta, origin, radius);
	}
}

/*
	Name: revert_power
	Namespace: zm_power
	Checksum: 0xE1F5B681
	Offset: 0x1950
	Size: 0x130
	Parameters: 4
	Flags: Linked
*/
function revert_power(delta, origin, radius, powered_list)
{
	if(delta > 0)
	{
		self.depowered_count--;
		/#
			assert(self.depowered_count >= 0, "");
		#/
		if(self.depowered_count == 0 && self.powered_count > 0 && !self.power)
		{
			self.power = 1;
			self [[self.power_on_func]](origin, radius);
		}
	}
	else if(delta < 0)
	{
		self.powered_count--;
		/#
			assert(self.powered_count >= 0, "");
		#/
		if(self.powered_count == 0 && self.power)
		{
			self.power = 0;
			self [[self.power_off_func]](origin, radius);
		}
	}
}

/*
	Name: add_local_power
	Namespace: zm_power
	Checksum: 0x698CF27F
	Offset: 0x1A88
	Size: 0xCE
	Parameters: 2
	Flags: None
*/
function add_local_power(origin, radius)
{
	localpower = spawnstruct();
	/#
		println(((("" + origin) + "") + radius) + "");
	#/
	localpower.origin = origin;
	localpower.radius = radius;
	localpower.enabled_list = change_power_in_radius(1, origin, radius);
	level.local_power[level.local_power.size] = localpower;
	return localpower;
}

/*
	Name: move_local_power
	Namespace: zm_power
	Checksum: 0xE3257B0E
	Offset: 0x1B60
	Size: 0x1BA
	Parameters: 2
	Flags: None
*/
function move_local_power(localpower, origin)
{
	changed_list = [];
	for(i = 0; i < level.powered_items.size; i++)
	{
		powered = level.powered_items[i];
		if(powered.power_sources == 2)
		{
			continue;
		}
		waspowered = isinarray(localpower.enabled_list, powered);
		ispowered = powered [[powered.range_func]](1, origin, localpower.radius);
		if(ispowered && !waspowered)
		{
			powered change_power(1, origin, localpower.radius);
			localpower.enabled_list[localpower.enabled_list.size] = powered;
			continue;
		}
		if(!ispowered && waspowered)
		{
			powered revert_power(-1, localpower.origin, localpower.radius, localpower.enabled_list);
			arrayremovevalue(localpower.enabled_list, powered, 0);
		}
	}
	localpower.origin = origin;
	return localpower;
}

/*
	Name: end_local_power
	Namespace: zm_power
	Checksum: 0x6BAD8BDB
	Offset: 0x1D28
	Size: 0x114
	Parameters: 1
	Flags: None
*/
function end_local_power(localpower)
{
	/#
		println(((("" + localpower.origin) + "") + localpower.radius) + "");
	#/
	if(isdefined(localpower.enabled_list))
	{
		revert_power_to_list(-1, localpower.origin, localpower.radius, localpower.enabled_list);
	}
	localpower.enabled_list = undefined;
	if(isdefined(localpower.added_list))
	{
		revert_power_to_list(-1, localpower.origin, localpower.radius, localpower.added_list);
	}
	localpower.added_list = undefined;
	arrayremovevalue(level.local_power, localpower, 0);
}

/*
	Name: has_local_power
	Namespace: zm_power
	Checksum: 0xCC728773
	Offset: 0x1E48
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function has_local_power(origin)
{
	if(isdefined(level.local_power))
	{
		foreach(localpower in level.local_power)
		{
			if(distancesquared(localpower.origin, origin) < localpower.radius * localpower.radius)
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: get_powered_item_cost
	Namespace: zm_power
	Checksum: 0x593C7543
	Offset: 0x1F18
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function get_powered_item_cost()
{
	if(!(isdefined(self.power) && self.power))
	{
		return 0;
	}
	if(isdefined(level._power_global) && level._power_global && !self.power_sources == 1)
	{
		return 0;
	}
	cost = [[self.cost_func]]();
	power_sources = self.powered_count;
	if(power_sources < 1)
	{
		power_sources = 1;
	}
	return cost / power_sources;
}

/*
	Name: get_local_power_cost
	Namespace: zm_power
	Checksum: 0x599FA8A9
	Offset: 0x1FC8
	Size: 0x158
	Parameters: 1
	Flags: None
*/
function get_local_power_cost(localpower)
{
	cost = 0;
	if(isdefined(localpower) && isdefined(localpower.enabled_list))
	{
		foreach(powered in localpower.enabled_list)
		{
			cost = cost + powered get_powered_item_cost();
		}
	}
	if(isdefined(localpower) && isdefined(localpower.added_list))
	{
		foreach(powered in localpower.added_list)
		{
			cost = cost + powered get_powered_item_cost();
		}
	}
	return cost;
}

/*
	Name: set_global_power
	Namespace: zm_power
	Checksum: 0x81E59605
	Offset: 0x2128
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function set_global_power(on_off)
{
	demo::bookmark(#"zm_power", gettime(), undefined, undefined, 1);
	potm::bookmark(#"zm_power", gettime(), undefined, undefined, 1);
	level._power_global = on_off;
	for(i = 0; i < level.powered_items.size; i++)
	{
		powered = level.powered_items[i];
		if(isdefined(powered.target) && powered.power_sources != 1)
		{
			powered global_power(on_off);
			util::wait_network_frame();
		}
	}
}

/*
	Name: global_power
	Namespace: zm_power
	Checksum: 0xACECF3E6
	Offset: 0x2230
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function global_power(on_off)
{
	if(on_off)
	{
		/#
			println("");
		#/
		if(!self.power)
		{
			self.power = 1;
			self [[self.power_on_func]]();
		}
		self.powered_count++;
	}
	else
	{
		/#
			println("");
		#/
		self.powered_count--;
		/#
			assert(self.powered_count >= 0, "");
		#/
		if(self.powered_count == 0 && self.power)
		{
			self.power = 0;
			self [[self.power_off_func]]();
		}
	}
}

/*
	Name: never_power_on
	Namespace: zm_power
	Checksum: 0x64E085EF
	Offset: 0x2338
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function never_power_on(origin, radius)
{
}

/*
	Name: never_power_off
	Namespace: zm_power
	Checksum: 0xF9921E77
	Offset: 0x2358
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function never_power_off(origin, radius)
{
}

/*
	Name: cost_negligible
	Namespace: zm_power
	Checksum: 0x5D154D0D
	Offset: 0x2378
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function cost_negligible()
{
	if(isdefined(self.one_time_cost))
	{
		cost = self.one_time_cost;
		self.one_time_cost = undefined;
		return cost;
	}
	return 0;
}

/*
	Name: cost_low_if_local
	Namespace: zm_power
	Checksum: 0x3C34940
	Offset: 0x23B8
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function cost_low_if_local()
{
	if(isdefined(self.one_time_cost))
	{
		cost = self.one_time_cost;
		self.one_time_cost = undefined;
		return cost;
	}
	if(isdefined(level._power_global) && level._power_global || (isdefined(self.self_powered) && self.self_powered))
	{
		return 0;
	}
	return 1;
}

/*
	Name: cost_high
	Namespace: zm_power
	Checksum: 0x5A455F38
	Offset: 0x2438
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function cost_high()
{
	if(isdefined(self.one_time_cost))
	{
		cost = self.one_time_cost;
		self.one_time_cost = undefined;
		return cost;
	}
	return 10;
}

/*
	Name: door_range
	Namespace: zm_power
	Checksum: 0x7927B78D
	Offset: 0x2478
	Size: 0x60
	Parameters: 3
	Flags: Linked
*/
function door_range(delta, origin, radius)
{
	if(delta < 0)
	{
		return false;
	}
	if(distancesquared(self.target.origin, origin) < radius * radius)
	{
		return true;
	}
	return false;
}

/*
	Name: door_power_on
	Namespace: zm_power
	Checksum: 0x55CD01FF
	Offset: 0x24E0
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function door_power_on(origin, radius)
{
	/#
		println("");
	#/
	self.target.power_on = 1;
	self.target notify(#"power_on");
}

/*
	Name: door_power_off
	Namespace: zm_power
	Checksum: 0x9378A182
	Offset: 0x2548
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function door_power_off(origin, radius)
{
	/#
		println("");
	#/
	self.target notify(#"power_off");
	self.target.power_on = 0;
}

/*
	Name: door_local_power_on
	Namespace: zm_power
	Checksum: 0x9D625EAB
	Offset: 0x25B0
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function door_local_power_on(origin, radius)
{
	/#
		println("");
	#/
	self.target.local_power_on = 1;
	self.target notify(#"local_power_on");
}

/*
	Name: door_local_power_off
	Namespace: zm_power
	Checksum: 0x8217F5AA
	Offset: 0x2618
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function door_local_power_off(origin, radius)
{
	/#
		println("");
	#/
	self.target notify(#"local_power_off");
	self.target.local_power_on = 0;
}

/*
	Name: cost_door
	Namespace: zm_power
	Checksum: 0x15D6C7EC
	Offset: 0x2680
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function cost_door()
{
	if(isdefined(self.target.power_cost))
	{
		if(!isdefined(self.one_time_cost))
		{
			self.one_time_cost = 0;
		}
		self.one_time_cost = self.one_time_cost + self.target.power_cost;
		self.target.power_cost = 0;
	}
	if(isdefined(self.one_time_cost))
	{
		cost = self.one_time_cost;
		self.one_time_cost = undefined;
		return cost;
	}
	return 0;
}

/*
	Name: zombie_range
	Namespace: zm_power
	Checksum: 0x6455A1CE
	Offset: 0x2720
	Size: 0x7E
	Parameters: 3
	Flags: None
*/
function zombie_range(delta, origin, radius)
{
	if(delta > 0)
	{
		return false;
	}
	self.zombies = array::get_all_closest(origin, zombie_utility::get_round_enemy_array(), undefined, undefined, radius);
	if(!isdefined(self.zombies))
	{
		return false;
	}
	self.power = 1;
	return true;
}

/*
	Name: zombie_power_off
	Namespace: zm_power
	Checksum: 0x1C185D0F
	Offset: 0x27A8
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function zombie_power_off(origin, radius)
{
	/#
		println("");
	#/
	for(i = 0; i < self.zombies.size; i++)
	{
		self.zombies[i] thread stun_zombie();
		waitframe(1);
	}
}

/*
	Name: stun_zombie
	Namespace: zm_power
	Checksum: 0x6521147E
	Offset: 0x2838
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function stun_zombie()
{
	self notify(#"stun_zombie");
	self endon(#"death", #"stun_zombie");
	if(self.health <= 0)
	{
		/#
			iprintln("");
		#/
		return;
	}
	if(isdefined(self.ignore_inert) && self.ignore_inert)
	{
		return;
	}
	if(isdefined(self.stun_zombie))
	{
		self thread [[self.stun_zombie]]();
		return;
	}
}

/*
	Name: perk_range
	Namespace: zm_power
	Checksum: 0xB56A24C6
	Offset: 0x28E8
	Size: 0xF0
	Parameters: 3
	Flags: Linked
*/
function perk_range(delta, origin, radius)
{
	if(isdefined(self.target))
	{
		perkorigin = self.target.origin;
		if(isdefined(self.target.trigger_off) && self.target.trigger_off)
		{
			perkorigin = self.target.realorigin;
		}
		else if(isdefined(self.target.disabled) && self.target.disabled)
		{
			perkorigin = perkorigin + vectorscale((0, 0, 1), 10000);
		}
		if(distancesquared(perkorigin, origin) < radius * radius)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: perk_power_on
	Namespace: zm_power
	Checksum: 0x57A7F3B6
	Offset: 0x29E0
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function perk_power_on(origin, radius)
{
	/#
		println(("" + self.target zm_perks::getvendingmachinenotify()) + "");
	#/
	level notify(self.target zm_perks::getvendingmachinenotify() + "_on");
	zm_perks::perk_unpause(self.target.script_noteworthy);
}

/*
	Name: perk_power_off
	Namespace: zm_power
	Checksum: 0x6D07343
	Offset: 0x2A88
	Size: 0x17A
	Parameters: 2
	Flags: Linked
*/
function perk_power_off(origin, radius)
{
	notify_name = self.target zm_perks::getvendingmachinenotify();
	if(isdefined(notify_name) && notify_name == "revive")
	{
		if(level flag::exists("solo_game") && level flag::get("solo_game"))
		{
			return;
		}
	}
	/#
		println(("" + self.target.script_noteworthy) + "");
	#/
	self.target notify(#"death");
	self.target thread zm_perks::vending_trigger_think();
	if(isdefined(self.target.perk_hum))
	{
		self.target.perk_hum delete();
	}
	zm_perks::perk_pause(self.target.script_noteworthy);
	level notify(self.target zm_perks::getvendingmachinenotify() + "_off");
}

/*
	Name: turn_power_on_and_open_doors
	Namespace: zm_power
	Checksum: 0x46CBCE4E
	Offset: 0x2C10
	Size: 0x34C
	Parameters: 1
	Flags: Linked
*/
function turn_power_on_and_open_doors(power_zone)
{
	level.local_doors_stay_open = 1;
	level.power_local_doors_globally = 1;
	if(!isdefined(power_zone))
	{
		level flag::set("power_on");
		level clientfield::set("zombie_power_on", 1);
	}
	else
	{
		level flag::set("power_on" + power_zone);
		level clientfield::set("zombie_power_on", power_zone + 1);
	}
	foreach(player in level.players)
	{
		player zm_stats::function_8f10788e("boas_power_turnedon");
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") != 0)
	{
		zombie_doors = getentarray("zombie_door", "targetname");
		foreach(door in zombie_doors)
		{
			if(!isdefined(door.script_noteworthy))
			{
				continue;
			}
			if(!isdefined(power_zone) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door"))
			{
				door notify(#"power_on");
				continue;
			}
			if(isdefined(door.script_int) && door.script_int == power_zone && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door"))
			{
				door notify(#"power_on");
				if(isdefined(level.temporary_power_switch_logic))
				{
					door.power_on = 1;
				}
				continue;
			}
			if(isdefined(door.script_int) && door.script_int == power_zone && door.script_noteworthy === "local_electric_door")
			{
				door notify(#"local_power_on");
			}
		}
	}
}

/*
	Name: turn_power_off_and_close_doors
	Namespace: zm_power
	Checksum: 0xCC60E11A
	Offset: 0x2F68
	Size: 0x2EC
	Parameters: 1
	Flags: Linked
*/
function turn_power_off_and_close_doors(power_zone)
{
	level.local_doors_stay_open = 0;
	level.power_local_doors_globally = 0;
	if(!isdefined(power_zone))
	{
		level flag::clear("power_on");
		level clientfield::set("zombie_power_off", 0);
	}
	else
	{
		level flag::clear("power_on" + power_zone);
		level clientfield::set("zombie_power_off", power_zone);
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") != 0)
	{
		zombie_doors = getentarray("zombie_door", "targetname");
		foreach(door in zombie_doors)
		{
			if(!isdefined(door.script_noteworthy))
			{
				continue;
			}
			if(!isdefined(power_zone) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door"))
			{
				door notify(#"power_on");
				continue;
			}
			if(isdefined(door.script_int) && door.script_int == power_zone && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door"))
			{
				door notify(#"power_on");
				if(isdefined(level.temporary_power_switch_logic))
				{
					door.power_on = 0;
					door sethintstring(#"hash_71158766520dc432");
					door notify(#"kill_door_think");
					door thread zm_blockers::door_think();
				}
				continue;
			}
			if(isdefined(door.script_noteworthy) && door.script_noteworthy == "local_electric_door")
			{
				door notify(#"local_power_on");
			}
		}
	}
}

