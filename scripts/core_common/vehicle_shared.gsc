// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3728b3b9606c4299;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\turret_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_death_shared.gsc;
#using scripts\core_common\vehicleriders_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace vehicle;

/*
	Name: function_89f2df9
	Namespace: vehicle
	Checksum: 0x36ADE958
	Offset: 0xAF8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"vehicle_shared", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: vehicle
	Checksum: 0xDA20212B
	Offset: 0xB48
	Size: 0xB5E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("vehicle", "toggle_lockon", 1, 1, "int");
	clientfield::register("vehicle", "toggle_sounds", 1, 1, "int");
	clientfield::register("vehicle", "use_engine_damage_sounds", 1, 2, "int");
	clientfield::register("vehicle", "toggle_treadfx", 1, 1, "int");
	clientfield::register("vehicle", "toggle_exhaustfx", 1, 1, "int");
	clientfield::register("vehicle", "toggle_lights", 1, 2, "int");
	clientfield::register("vehicle", "toggle_lights_group1", 1, 1, "int");
	clientfield::register("vehicle", "toggle_lights_group2", 1, 1, "int");
	clientfield::register("vehicle", "toggle_lights_group3", 1, 1, "int");
	clientfield::register("vehicle", "toggle_lights_group4", 1, 1, "int");
	clientfield::register("vehicle", "toggle_force_driver_taillights", 1, 1, "int");
	clientfield::register("vehicle", "toggle_ambient_anim_group1", 1, 1, "int");
	clientfield::register("vehicle", "toggle_ambient_anim_group2", 1, 1, "int");
	clientfield::register("vehicle", "toggle_ambient_anim_group3", 1, 1, "int");
	clientfield::register("vehicle", "toggle_control_bone_group1", 1, 1, "int");
	clientfield::register("vehicle", "toggle_control_bone_group2", 1, 1, "int");
	clientfield::register("vehicle", "toggle_control_bone_group3", 1, 1, "int");
	clientfield::register("vehicle", "toggle_control_bone_group4", 1, 1, "int");
	clientfield::register("vehicle", "toggle_emp_fx", 1, 1, "int");
	clientfield::register("vehicle", "toggle_burn_fx", 1, 1, "int");
	clientfield::register("vehicle", "deathfx", 1, 2, "int");
	clientfield::register("vehicle", "stopallfx", 1, 1, "int");
	clientfield::register("vehicle", "flickerlights", 1, 2, "int");
	clientfield::register("vehicle", "alert_level", 1, 2, "int");
	clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int");
	clientfield::register("vehicle", "stun", 1, 1, "int");
	clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int");
	clientfield::register("vehicle", "damage_level", 1, 3, "int");
	clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int");
	clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int");
	clientfield::register("vehicle", "toggle_horn_sound", 1, 1, "int");
	clientfield::register("vehicle", "update_malfunction", 1, 2, "int");
	if(!sessionmodeiszombiesgame() && (!(isdefined(level.var_7b05c4b5) && level.var_7b05c4b5)))
	{
		clientfield::function_a8bbc967("vehicle.ammoCount", 1, 10, "int", 0);
		clientfield::function_a8bbc967("vehicle.ammoReloading", 1, 1, "int", 0);
		clientfield::function_a8bbc967("vehicle.ammoLow", 1, 1, "int", 0);
		clientfield::function_a8bbc967("vehicle.rocketAmmo", 1, 2, "int", 0);
		clientfield::function_a8bbc967("vehicle.ammo2Count", 1, 10, "int", 0);
		clientfield::function_a8bbc967("vehicle.ammo2Reloading", 1, 1, "int", 0);
		clientfield::function_a8bbc967("vehicle.ammo2Low", 1, 1, "int", 0);
		clientfield::function_a8bbc967("vehicle.collisionWarning", 1, 2, "int", 0);
		clientfield::function_a8bbc967("vehicle.enemyInReticle", 1, 1, "int", 0);
		clientfield::function_a8bbc967("vehicle.missileRepulsed", 1, 1, "int", 0);
		clientfield::function_a8bbc967("vehicle.incomingMissile", 1, 1, "int", 0);
		clientfield::function_a8bbc967("vehicle.missileLock", 1, 2, "int", 0);
		clientfield::function_a8bbc967("vehicle.malfunction", 1, 2, "int", 0);
		clientfield::function_a8bbc967("vehicle.showHoldToExitPrompt", 1, 1, "int", 0);
		clientfield::function_a8bbc967("vehicle.holdToExitProgress", 1, 5, "float", 0);
		clientfield::function_a8bbc967("vehicle.vehicleAttackMode", 1, 3, "int", 0);
		clientfield::function_a8bbc967("vehicle.invalidLanding", 1, 1, "int", 0);
		for(i = 0; i < 3; i++)
		{
			clientfield::function_a8bbc967("vehicle.bindingCooldown" + i + ".cooldown", 1, 5, "float", 0);
		}
	}
	clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int");
	clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int");
	clientfield::register("toplayer", "static_postfx", 1, 1, "int");
	clientfield::register("vehicle", "vehUseMaterialPhysics", 1, 1, "int");
	clientfield::register("scriptmover", "play_flare_fx", 1, 1, "int");
	clientfield::register("scriptmover", "play_flare_hit_fx", 1, 1, "int");
	if(isdefined(level.bypassvehiclescripts))
	{
		return;
	}
	level.heli_default_decel = 10;
	setup_dvars();
	setup_level_vars();
	setup_triggers();
	setup_nodes();
	level array::thread_all_ents(level.vehicle_processtriggers, &trigger_process);
	level.vehicle_processtriggers = undefined;
	level.vehicle_enemy_tanks = [];
	level.vehicle_enemy_tanks[#"vehicle_ger_tracked_king_tiger"] = 1;
	level thread _watch_for_hijacked_vehicles();
	level.var_16e6c35e = &function_16e6c35e;
}

/*
	Name: __main__
	Namespace: vehicle
	Checksum: 0x365499C2
	Offset: 0x16B0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	a_all_spawners = getvehiclespawnerarray();
	setup_spawners(a_all_spawners);
	/#
		level thread vehicle_spawner_tool();
		level thread spline_debug();
	#/
}

/*
	Name: setup_script_gatetrigger
	Namespace: vehicle
	Checksum: 0xED1431C3
	Offset: 0x1720
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function setup_script_gatetrigger(trigger)
{
	gates = [];
	if(isdefined(trigger.script_gatetrigger))
	{
		return level.vehicle_gatetrigger[trigger.script_gatetrigger];
	}
	return gates;
}

/*
	Name: trigger_process
	Namespace: vehicle
	Checksum: 0xDC150014
	Offset: 0x1770
	Size: 0x63C
	Parameters: 1
	Flags: Linked
*/
function trigger_process(trigger)
{
	if(isdefined(trigger.classname) && (trigger.classname == "trigger_multiple" || trigger.classname == "trigger_radius" || trigger.classname == "trigger_lookat" || trigger.classname == "trigger_box" || trigger.classname == "trigger_multiple_new" || trigger.classname == "trigger_radius_new" || trigger.classname == "trigger_lookat_new" || trigger.classname == "trigger_box_new"))
	{
		btriggeronce = 1;
	}
	else
	{
		btriggeronce = 0;
	}
	if(isdefined(trigger.script_noteworthy) && trigger.script_noteworthy == "trigger_multiple")
	{
		btriggeronce = 0;
	}
	trigger.processed_trigger = undefined;
	gates = setup_script_gatetrigger(trigger);
	script_vehicledetour = isdefined(trigger.script_vehicledetour) && (is_node_script_origin(trigger) || is_node_script_struct(trigger));
	detoured = isdefined(trigger.detoured) && (!(is_node_script_origin(trigger) || is_node_script_struct(trigger)));
	while(gotrigger)
	{
		trigger trigger::wait_till();
		other = trigger.who;
		if(isdefined(trigger.enabled) && !trigger.enabled)
		{
			trigger waittill(#"enable");
		}
		if(isdefined(trigger.script_flag_set))
		{
			if(isdefined(other) && isdefined(other.vehicle_flags))
			{
				other.vehicle_flags[trigger.script_flag_set] = 1;
			}
			if(isdefined(other))
			{
				other notify(#"vehicle_flag_arrived", {#is_set:trigger.script_flag_set});
			}
			level flag::set(trigger.script_flag_set);
		}
		if(isdefined(trigger.script_flag_clear))
		{
			if(isdefined(other) && isdefined(other.vehicle_flags))
			{
				other.vehicle_flags[trigger.script_flag_clear] = 0;
			}
			level flag::clear(trigger.script_flag_clear);
		}
		if(isdefined(other) && script_vehicledetour)
		{
			other thread path_detour_script_origin(trigger);
		}
		else if(detoured && isdefined(other))
		{
			other thread path_detour(trigger);
		}
		trigger util::script_delay();
		if(btriggeronce)
		{
			gotrigger = 0;
		}
		if(isdefined(trigger.script_vehiclegroupdelete))
		{
			if(!isdefined(level.vehicle_deletegroup[trigger.script_vehiclegroupdelete]))
			{
				/#
					println("", trigger.script_vehiclegroupdelete);
				#/
				level.vehicle_deletegroup[trigger.script_vehiclegroupdelete] = [];
			}
			array::delete_all(level.vehicle_deletegroup[trigger.script_vehiclegroupdelete]);
		}
		if(isdefined(trigger.script_vehiclespawngroup))
		{
			level notify("spawnvehiclegroup" + trigger.script_vehiclespawngroup);
			level waittill("vehiclegroup spawned" + trigger.script_vehiclespawngroup);
		}
		if(gates.size > 0 && btriggeronce)
		{
			level array::thread_all_ents(gates, &path_gate_open);
		}
		if(isdefined(trigger) && isdefined(trigger.script_vehiclestartmove))
		{
			if(!isdefined(level.vehicle_startmovegroup[trigger.script_vehiclestartmove]))
			{
				/#
					println("", trigger.script_vehiclestartmove);
				#/
				return;
			}
			foreach(vehicle in arraycopy(level.vehicle_startmovegroup[trigger.script_vehiclestartmove]))
			{
				if(isdefined(vehicle))
				{
					vehicle thread go_path();
				}
			}
		}
	}
}

/*
	Name: path_detour_get_detourpath
	Namespace: vehicle
	Checksum: 0x78E057C3
	Offset: 0x1DB8
	Size: 0x186
	Parameters: 1
	Flags: Linked
*/
function path_detour_get_detourpath(a_nd_detour)
{
	if(!isdefined(a_nd_detour))
	{
		a_nd_detour = [];
	}
	else if(!isarray(a_nd_detour))
	{
		a_nd_detour = array(a_nd_detour);
	}
	a_nd_detour_real = [];
	foreach(nd in a_nd_detour)
	{
		if(isdefined(nd.script_vehicledetour))
		{
			if(!isdefined(a_nd_detour_real))
			{
				a_nd_detour_real = [];
			}
			else if(!isarray(a_nd_detour_real))
			{
				a_nd_detour_real = array(a_nd_detour_real);
			}
			a_nd_detour_real[a_nd_detour_real.size] = nd;
		}
	}
	a_nd_detour_real = array::randomize(a_nd_detour_real);
	for(i = 0; i < a_nd_detour_real.size; i++)
	{
		if(!islastnode(a_nd_detour_real[i]))
		{
			return a_nd_detour_real[i];
		}
	}
	return undefined;
}

/*
	Name: path_detour_script_origin
	Namespace: vehicle
	Checksum: 0x5EC94B5C
	Offset: 0x1F48
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function path_detour_script_origin(detournode)
{
	detourpath = path_detour_get_detourpath(detournode);
	if(isdefined(detourpath))
	{
		self thread paths(detourpath);
	}
}

/*
	Name: crash_detour_check
	Namespace: vehicle
	Checksum: 0x7E46FF3B
	Offset: 0x1FA0
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function crash_detour_check(detourpath)
{
	return isdefined(detourpath.script_crashtype) && (isdefined(self.deaddriver) || self.health <= 0 || detourpath.script_crashtype == "forced") && (!isdefined(detourpath.derailed) || (isdefined(detourpath.script_crashtype) && detourpath.script_crashtype == "plane"));
}

/*
	Name: crash_derailed_check
	Namespace: vehicle
	Checksum: 0xC9C6944F
	Offset: 0x2040
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function crash_derailed_check(detourpath)
{
	return isdefined(detourpath.derailed) && detourpath.derailed;
}

/*
	Name: path_detour
	Namespace: vehicle
	Checksum: 0x29127997
	Offset: 0x2070
	Size: 0x19A
	Parameters: 1
	Flags: Linked
*/
function path_detour(node)
{
	a_nd_detour = getvehiclenodearray(node.target2, "targetname");
	detourpath = path_detour_get_detourpath(a_nd_detour);
	if(!isdefined(detourpath))
	{
		return;
	}
	if(node.detoured && !isdefined(detourpath.script_vehicledetourgroup))
	{
		return;
	}
	if(crash_detour_check(detourpath))
	{
		if(isdefined(self.script_crashtypeoverride) && self.script_crashtypeoverride === "ground_vehicle_on_spline")
		{
			self.nd_crash_path = detourpath;
			self thread vehicle_death::ground_vehicle_crash();
		}
		else
		{
			self notify(#"crashpath", detourpath);
			detourpath.derailed = 1;
			self notify(#"newpath");
			self setswitchnode(node, detourpath);
		}
		return;
	}
	if(crash_derailed_check(detourpath))
	{
		return;
	}
	if(isdefined(detourpath.script_vehicledetourgroup))
	{
		if(!isdefined(self.script_vehicledetourgroup))
		{
			return;
		}
		if(detourpath.script_vehicledetourgroup != self.script_vehicledetourgroup)
		{
			return;
		}
	}
}

/*
	Name: levelstuff
	Namespace: vehicle
	Checksum: 0x52B6F087
	Offset: 0x2218
	Size: 0x10E
	Parameters: 1
	Flags: Linked
*/
function levelstuff(vehicle)
{
	if(isdefined(vehicle.script_linkname))
	{
		level.vehicle_link = array_2d_add(level.vehicle_link, vehicle.script_linkname, vehicle);
	}
	if(isdefined(vehicle.script_vehiclespawngroup))
	{
		level.vehicle_spawngroup = array_2d_add(level.vehicle_spawngroup, vehicle.script_vehiclespawngroup, vehicle);
	}
	if(isdefined(vehicle.script_vehiclestartmove))
	{
		level.vehicle_startmovegroup = array_2d_add(level.vehicle_startmovegroup, vehicle.script_vehiclestartmove, vehicle);
	}
	if(isdefined(vehicle.script_vehiclegroupdelete))
	{
		level.vehicle_deletegroup = array_2d_add(level.vehicle_deletegroup, vehicle.script_vehiclegroupdelete, vehicle);
	}
}

/*
	Name: _spawn_array
	Namespace: vehicle
	Checksum: 0x6665C2B6
	Offset: 0x2330
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function _spawn_array(spawners)
{
	ai = _remove_non_riders_from_array(spawner::simple_spawn(spawners));
	return ai;
}

/*
	Name: _remove_non_riders_from_array
	Namespace: vehicle
	Checksum: 0xA134A540
	Offset: 0x2380
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function _remove_non_riders_from_array(ai)
{
	living_ai = [];
	for(i = 0; i < ai.size; i++)
	{
		if(!ai_should_be_added(ai[i]))
		{
			continue;
		}
		living_ai[living_ai.size] = ai[i];
	}
	return living_ai;
}

/*
	Name: ai_should_be_added
	Namespace: vehicle
	Checksum: 0x5C10943E
	Offset: 0x2408
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function ai_should_be_added(ai)
{
	if(isalive(ai))
	{
		return 1;
	}
	if(!isdefined(ai))
	{
		return 0;
	}
	if(!isdefined(ai.classname))
	{
		return 0;
	}
	return ai.classname == "script_model";
}

/*
	Name: sort_by_startingpos
	Namespace: vehicle
	Checksum: 0xA8224411
	Offset: 0x2470
	Size: 0xBA
	Parameters: 1
	Flags: None
*/
function sort_by_startingpos(guysarray)
{
	firstarray = [];
	secondarray = [];
	for(i = 0; i < guysarray.size; i++)
	{
		if(isdefined(guysarray[i].script_startingposition))
		{
			firstarray[firstarray.size] = guysarray[i];
			continue;
		}
		secondarray[secondarray.size] = guysarray[i];
	}
	return arraycombine(firstarray, secondarray, 1, 0);
}

/*
	Name: rider_walk_setup
	Namespace: vehicle
	Checksum: 0x9FC611D2
	Offset: 0x2538
	Size: 0x9A
	Parameters: 1
	Flags: None
*/
function rider_walk_setup(vehicle)
{
	if(!isdefined(self.script_vehiclewalk))
	{
		return;
	}
	if(isdefined(self.script_followmode))
	{
		self.followmode = self.script_followmode;
	}
	else
	{
		self.followmode = "cover nodes";
	}
	if(!isdefined(self.target))
	{
		return;
	}
	node = getnode(self.target, "targetname");
	if(isdefined(node))
	{
		self.nodeaftervehiclewalk = node;
	}
}

/*
	Name: setup_groundnode_detour
	Namespace: vehicle
	Checksum: 0x753ED814
	Offset: 0x25E0
	Size: 0xC8
	Parameters: 1
	Flags: Linked
*/
function setup_groundnode_detour(node)
{
	a_nd_realdetour = getvehiclenodearray(node.targetname, "target2");
	if(!a_nd_realdetour.size)
	{
		return;
	}
	foreach(nd_detour in a_nd_realdetour)
	{
		nd_detour.detoured = 0;
		add_proccess_trigger(nd_detour);
	}
}

/*
	Name: add_proccess_trigger
	Namespace: vehicle
	Checksum: 0x5C4CE3BB
	Offset: 0x26B0
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function add_proccess_trigger(trigger)
{
	if(isdefined(trigger.processed_trigger))
	{
		return;
	}
	if(!isdefined(level.vehicle_processtriggers))
	{
		level.vehicle_processtriggers = [];
	}
	else if(!isarray(level.vehicle_processtriggers))
	{
		level.vehicle_processtriggers = array(level.vehicle_processtriggers);
	}
	level.vehicle_processtriggers[level.vehicle_processtriggers.size] = trigger;
	trigger.processed_trigger = 1;
}

/*
	Name: islastnode
	Namespace: vehicle
	Checksum: 0x4237E21A
	Offset: 0x2770
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function islastnode(node)
{
	if(!isdefined(node.target))
	{
		return 1;
	}
	if(!isdefined(getvehiclenode(node.target, "targetname")) && !isdefined(get_vehiclenode_any_dynamic(node.target)))
	{
		return 1;
	}
	return 0;
}

/*
	Name: paths
	Namespace: vehicle
	Checksum: 0x3974B1D7
	Offset: 0x27F0
	Size: 0xBF4
	Parameters: 1
	Flags: Linked
*/
function paths(node)
{
	/#
		assert(isdefined(node) || isdefined(self.attachedpath), "");
	#/
	self notify(#"endpath");
	self endon(#"endpath");
	self notify(#"newpath");
	self endon(#"death", #"newpath");
	if(isdefined(node))
	{
		self.attachedpath = node;
	}
	pathstart = self.attachedpath;
	self.currentnode = self.attachedpath;
	if(!isdefined(pathstart))
	{
		return;
	}
	/#
		self thread debug_vehicle_paths();
	#/
	while(isdefined(currentpoint))
	{
		waitresult = undefined;
		waitresult = self waittill(#"reached_node");
		currentpoint = waitresult.node;
		currentpoint enable_turrets(self);
		if(!isdefined(self))
		{
			return;
		}
		self.currentnode = currentpoint;
		self.nextnode = (isdefined(currentpoint.target) ? getvehiclenode(currentpoint.target, "targetname") : undefined);
		if(isdefined(currentpoint.gateopen) && !currentpoint.gateopen)
		{
			self thread path_gate_wait_till_open(currentpoint);
		}
		currentpoint notify(#"trigger", {#activator:self});
		if(isdefined(currentpoint.script_dropbombs) && currentpoint.script_dropbombs > 0)
		{
			amount = currentpoint.script_dropbombs;
			delay = 0;
			delaytrace = 0;
			if(isdefined(currentpoint.script_dropbombs_delay) && currentpoint.script_dropbombs_delay > 0)
			{
				delay = currentpoint.script_dropbombs_delay;
			}
			if(isdefined(currentpoint.script_dropbombs_delaytrace) && currentpoint.script_dropbombs_delaytrace > 0)
			{
				delaytrace = currentpoint.script_dropbombs_delaytrace;
			}
			self notify(#"drop_bombs", {#delay_trace:delaytrace, #delay:delay, #amount:amount});
		}
		if(isdefined(currentpoint.script_noteworthy))
		{
			self notify(currentpoint.script_noteworthy);
			self notify(#"noteworthy", {#noteworthy:currentpoint.script_noteworthy});
		}
		if(isdefined(currentpoint.script_notify))
		{
			self notify(currentpoint.script_notify);
			level notify(currentpoint.script_notify);
		}
		waittillframeend();
		if(!isdefined(self))
		{
			return;
		}
		if(isdefined(currentpoint.script_delete) && currentpoint.script_delete)
		{
			if(isdefined(self.riders) && self.riders.size > 0)
			{
				array::delete_all(self.riders);
			}
			self delete();
			return;
		}
		if(isdefined(currentpoint.script_sound))
		{
			self playsound(currentpoint.script_sound);
		}
		if(isdefined(currentpoint.script_noteworthy))
		{
			if(currentpoint.script_noteworthy == "godon")
			{
				self god_on();
			}
			else if(currentpoint.script_noteworthy == "godoff")
			{
				self god_off();
			}
			else if(currentpoint.script_noteworthy == "drivepath")
			{
				self drivepath();
			}
			else if(currentpoint.script_noteworthy == "lockpath")
			{
				self startpath();
			}
			else if(currentpoint.script_noteworthy == "brake")
			{
				if(self.isphysicsvehicle)
				{
					self setbrake(1);
				}
				self setspeed(0, 60, 60);
			}
			else if(currentpoint.script_noteworthy == "resumespeed")
			{
				accel = 30;
				if(isdefined(currentpoint.script_float))
				{
					accel = currentpoint.script_float;
				}
				self resumespeed(accel);
			}
		}
		if(isdefined(currentpoint.script_crashtypeoverride))
		{
			self.script_crashtypeoverride = currentpoint.script_crashtypeoverride;
		}
		if(isdefined(currentpoint.script_badplace))
		{
			self.script_badplace = currentpoint.script_badplace;
		}
		if(isdefined(currentpoint.script_team))
		{
			self.team = currentpoint.script_team;
		}
		if(isdefined(currentpoint.script_turningdir))
		{
			self notify(#"turning", {#direction:currentpoint.script_turningdir});
		}
		if(isdefined(currentpoint.script_deathroll))
		{
			if(currentpoint.script_deathroll == 0)
			{
				self thread vehicle_death::deathrolloff();
			}
			else
			{
				self thread vehicle_death::deathrollon();
			}
		}
		if(isdefined(currentpoint.script_exploder))
		{
			exploder::exploder(currentpoint.script_exploder);
		}
		if(isdefined(currentpoint.script_flag_set))
		{
			if(isdefined(self.vehicle_flags))
			{
				self.vehicle_flags[currentpoint.script_flag_set] = 1;
			}
			self notify(#"vehicle_flag_arrived", {#is_set:currentpoint.script_flag_set});
			level flag::set(currentpoint.script_flag_set);
		}
		if(isdefined(currentpoint.script_flag_clear))
		{
			if(isdefined(self.vehicle_flags))
			{
				self.vehicle_flags[currentpoint.script_flag_clear] = 0;
			}
			level flag::clear(currentpoint.script_flag_clear);
		}
		if(self.vehicleclass === "helicopter" && isdefined(self.drivepath) && self.drivepath == 1)
		{
			if(isdefined(self.nextnode) && self.nextnode is_unload_node())
			{
				unload_node_helicopter(undefined);
				self.attachedpath = self.nextnode;
				self drivepath(self.attachedpath);
			}
		}
		else if(currentpoint is_unload_node())
		{
			unload_node(currentpoint);
		}
		if(isdefined(currentpoint.script_wait))
		{
			pause_path();
			currentpoint util::script_wait();
		}
		if(isdefined(currentpoint.script_waittill))
		{
			pause_path();
			util::waittill_any_ents(self, currentpoint.script_waittill, level, currentpoint.script_waittill);
		}
		if(isdefined(currentpoint.script_flag_wait))
		{
			if(!isdefined(self.vehicle_flags))
			{
				self.vehicle_flags = [];
			}
			self.vehicle_flags[currentpoint.script_flag_wait] = 1;
			self notify(#"vehicle_flag_arrived", {#is_set:currentpoint.script_flag_wait});
			self flag::set("waiting_for_flag");
			if(!level flag::get(currentpoint.script_flag_wait))
			{
				pause_path();
				level flag::wait_till(currentpoint.script_flag_wait);
			}
			self flag::clear("waiting_for_flag");
		}
		if(isdefined(self.set_lookat_point))
		{
			self.set_lookat_point = undefined;
			self vehclearlookat();
		}
		if(isdefined(currentpoint.script_lights_on))
		{
			if(currentpoint.script_lights_on)
			{
				self lights_on();
			}
			else
			{
				self lights_off();
			}
		}
		if(isdefined(currentpoint.script_stopnode))
		{
			self set_goal_pos(currentpoint.origin, 1);
		}
		if(isdefined(self.switchnode))
		{
			if(currentpoint == self.switchnode)
			{
				self.switchnode = undefined;
			}
		}
		else if(!isdefined(currentpoint.target))
		{
			break;
		}
		if(isdefined(self.vehicle_paused) && self.vehicle_paused)
		{
			resume_path();
		}
	}
	self notify(#"reached_dynamic_path_end");
	self.attachedpath = undefined;
	if(isai(self))
	{
		self function_af0fc980();
	}
	if(isdefined(self.var_cc1f9488) && self.var_cc1f9488)
	{
		self function_d4c687c9();
	}
	if(isdefined(self.script_delete))
	{
		self delete();
	}
}

/*
	Name: pause_path
	Namespace: vehicle
	Checksum: 0x7756D42A
	Offset: 0x33F0
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function pause_path()
{
	if(!(isdefined(self.vehicle_paused) && self.vehicle_paused))
	{
		if(self.isphysicsvehicle)
		{
			self setbrake(1);
		}
		if(self.vehicleclass === "helicopter")
		{
			if(isdefined(self.drivepath) && self.drivepath)
			{
				self function_a57c34b7(self.origin, 1);
			}
			else
			{
				self setspeed(0, 100, 100);
			}
		}
		else
		{
			self setspeed(0, 35, 35);
		}
		self.vehicle_paused = 1;
	}
}

/*
	Name: resume_path
	Namespace: vehicle
	Checksum: 0x62EADB99
	Offset: 0x34D8
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function resume_path()
{
	if(isdefined(self.vehicle_paused) && self.vehicle_paused)
	{
		if(self.isphysicsvehicle)
		{
			self setbrake(0);
		}
		if(self.vehicleclass === "helicopter")
		{
			if(isdefined(self.drivepath) && self.drivepath)
			{
				self drivepath(self.currentnode);
			}
			self resumespeed(100);
		}
		else
		{
			self resumespeed(35);
		}
		self.vehicle_paused = undefined;
	}
}

/*
	Name: get_on_path
	Namespace: vehicle
	Checksum: 0xA30D0F15
	Offset: 0x35A8
	Size: 0x24C
	Parameters: 3
	Flags: Linked
*/
function get_on_path(path_start, str_key = "targetname", distance = 0)
{
	if(!isdefined(self))
	{
		/#
			assert(0, "");
		#/
		return;
	}
	if(isstring(path_start))
	{
		path_start = getvehiclenode(path_start, str_key);
	}
	if(!isdefined(path_start))
	{
		if(isdefined(self.targetname))
		{
			/#
				assertmsg("" + self.targetname);
			#/
		}
		assertmsg("");
		return;
	}
	if(isdefined(self.hasstarted))
	{
		self.hasstarted = undefined;
	}
	self.attachedpath = path_start;
	if(!(isdefined(self.drivepath) && self.drivepath))
	{
		self attachpath(path_start);
	}
	else if(distance != 0)
	{
		self function_ded6dd2e(path_start, distance);
		self.var_ef0d9bf7 = 1;
	}
	if(self.disconnectpathonstop === 1 && !issentient(self))
	{
		self disconnect_paths(self.disconnectpathdetail);
	}
	if(isdefined(self.isphysicsvehicle) && self.isphysicsvehicle)
	{
		self setbrake(1);
	}
	if(isai(self))
	{
		self vehicle_ai::set_state("spline");
	}
	self thread paths();
}

/*
	Name: function_af0fc980
	Namespace: vehicle
	Checksum: 0xF54C13E0
	Offset: 0x3800
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_af0fc980()
{
	/#
		assert(isdefined(isai(self)) && isai(self));
	#/
	state = self vehicle_ai::get_previous_state();
	if(!isdefined(state))
	{
		state = "off";
	}
	self vehicle_ai::set_state(state);
}

/*
	Name: get_off_path
	Namespace: vehicle
	Checksum: 0xD75D30AA
	Offset: 0x38A0
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function get_off_path()
{
	self cancelaimove();
	self function_d4c687c9();
	if(isai(self))
	{
		function_af0fc980();
	}
}

/*
	Name: create_from_spawngroup_and_go_path
	Namespace: vehicle
	Checksum: 0xBB2BF14D
	Offset: 0x3910
	Size: 0x82
	Parameters: 1
	Flags: None
*/
function create_from_spawngroup_and_go_path(spawngroup)
{
	vehiclearray = _scripted_spawn(spawngroup);
	for(i = 0; i < vehiclearray.size; i++)
	{
		if(isdefined(vehiclearray[i]))
		{
			vehiclearray[i] thread go_path();
		}
	}
	return vehiclearray;
}

/*
	Name: get_on_and_go_path
	Namespace: vehicle
	Checksum: 0xD0875DE8
	Offset: 0x39A0
	Size: 0x5C
	Parameters: 2
	Flags: None
*/
function get_on_and_go_path(path_start, distance = 0)
{
	self get_on_path(path_start, "targetname", distance);
	self go_path();
}

/*
	Name: go_path
	Namespace: vehicle
	Checksum: 0xA2FBEC66
	Offset: 0x3A08
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function go_path()
{
	self endon(#"death", #"hash_7c36ba955d05ca78");
	if(self.isphysicsvehicle)
	{
		self setbrake(0);
	}
	if(isdefined(self.script_vehiclestartmove))
	{
		arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
	}
	if(isdefined(self.hasstarted))
	{
		/#
			println("");
		#/
		return;
	}
	self.hasstarted = 1;
	self util::script_delay();
	self notify(#"start_vehiclepath");
	if(isdefined(self.var_ef0d9bf7) && self.var_ef0d9bf7)
	{
		self drivepath();
	}
	else if(isdefined(self.drivepath) && self.drivepath)
	{
		self drivepath(self.attachedpath);
	}
	else
	{
		self startpath();
	}
	waitframe(1);
	self connect_paths();
	self waittill(#"reached_end_node");
	if(self.disconnectpathonstop === 1 && !issentient(self))
	{
		self disconnect_paths(self.disconnectpathdetail);
	}
	if(isdefined(self.currentnode) && isdefined(self.currentnode.script_noteworthy) && self.currentnode.script_noteworthy == "deleteme")
	{
		return;
	}
}

/*
	Name: path_gate_open
	Namespace: vehicle
	Checksum: 0xF0260CDF
	Offset: 0x3C28
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function path_gate_open(node)
{
	node.gateopen = 1;
	node notify(#"hash_4c7e71f20b5a7db7");
}

/*
	Name: path_gate_wait_till_open
	Namespace: vehicle
	Checksum: 0x637D9D6A
	Offset: 0x3C60
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function path_gate_wait_till_open(pathspot)
{
	self endon(#"death");
	self.waitingforgate = 1;
	self set_speed(0, 15, "path gate closed");
	pathspot waittill(#"hash_4c7e71f20b5a7db7");
	self.waitingforgate = 0;
	if(self.health > 0)
	{
		script_resume_speed("gate opened", level.vehicle_resumespeed);
	}
}

/*
	Name: _spawn_group
	Namespace: vehicle
	Checksum: 0xAE587FF8
	Offset: 0x3D08
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function _spawn_group(spawngroup)
{
	while(true)
	{
		level waittill("spawnvehiclegroup" + spawngroup);
		spawned_vehicles = [];
		for(i = 0; i < level.vehicle_spawners[spawngroup].size; i++)
		{
			spawned_vehicles[spawned_vehicles.size] = _vehicle_spawn(level.vehicle_spawners[spawngroup][i]);
		}
		level notify("vehiclegroup spawned" + spawngroup, {#vehicles:spawned_vehicles});
	}
}

/*
	Name: _scripted_spawn
	Namespace: vehicle
	Checksum: 0xF47E516E
	Offset: 0x3DE0
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function _scripted_spawn(group)
{
	thread _scripted_spawn_go(group);
	waitresult = undefined;
	waitresult = level waittill("vehiclegroup spawned" + group);
	return waitresult.vehicles;
}

/*
	Name: _scripted_spawn_go
	Namespace: vehicle
	Checksum: 0x14906635
	Offset: 0x3E40
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function _scripted_spawn_go(group)
{
	waittillframeend();
	level notify("spawnvehiclegroup" + group);
}

/*
	Name: set_variables
	Namespace: vehicle
	Checksum: 0x7BFAA51
	Offset: 0x3E70
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function set_variables(vehicle)
{
}

/*
	Name: _vehicle_spawn
	Namespace: vehicle
	Checksum: 0xF80CD2E3
	Offset: 0x3E88
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function _vehicle_spawn(vspawner)
{
	if(!isdefined(vspawner) || !vspawner.count)
	{
		return;
	}
	spawner::global_spawn_throttle();
	if(!isdefined(vspawner) || !vspawner.count)
	{
		return;
	}
	vehicle = vspawner spawnfromspawner((isdefined(vspawner.targetname) ? vspawner.targetname : undefined), 1);
	if(!isdefined(vehicle))
	{
		return;
	}
	if(isdefined(vspawner.script_team))
	{
		vehicle setteam(vspawner.script_team);
	}
	if(isdefined(vehicle.lockheliheight))
	{
		vehicle setheliheightlock(vehicle.lockheliheight);
	}
	if(isdefined(vehicle.targetname))
	{
		level notify("new_vehicle_spawned" + vehicle.targetname, {#vehicle:vehicle});
	}
	if(isdefined(vehicle.script_noteworthy))
	{
		level notify("new_vehicle_spawned" + vehicle.script_noteworthy, {#vehicle:vehicle});
	}
	if(isdefined(vehicle.script_animname))
	{
		vehicle.animname = vehicle.script_animname;
	}
	if(isdefined(vehicle.script_animscripted))
	{
		vehicle.supportsanimscripted = vehicle.script_animscripted;
	}
	return vehicle;
}

/*
	Name: init
	Namespace: vehicle
	Checksum: 0x3CAB9179
	Offset: 0x4078
	Size: 0x884
	Parameters: 1
	Flags: Linked
*/
function init(vehicle)
{
	callback::callback(#"on_vehicle_spawned");
	vehicle useanimtree("generic");
	if(isdefined(vehicle.e_dyn_path))
	{
		vehicle.e_dyn_path linkto(vehicle);
	}
	vehicle flag::init("waiting_for_flag");
	if(isdefined(vehicle.script_godmode) && vehicle.script_godmode)
	{
		vehicle val::set(#"script_godmode", "takedamage", 0);
	}
	vehicle.zerospeed = 1;
	if(!isdefined(vehicle.modeldummyon))
	{
		vehicle.modeldummyon = 0;
	}
	if(isdefined(vehicle.isphysicsvehicle) && vehicle.isphysicsvehicle)
	{
		if(isdefined(vehicle.script_brake) && vehicle.script_brake)
		{
			vehicle setbrake(1);
		}
	}
	type = vehicle.vehicletype;
	vehicle _vehicle_life();
	vehicle thread maingun_fx();
	vehicle.getoutrig = [];
	if(isdefined(level.vehicle_attachedmodels) && isdefined(level.vehicle_attachedmodels[type]))
	{
		rigs = level.vehicle_attachedmodels[type];
		strings = getarraykeys(rigs);
		for(i = 0; i < strings.size; i++)
		{
			vehicle.getoutrig[strings[i]] = undefined;
			vehicle.getoutriganimating[strings[i]] = 0;
		}
	}
	if(isdefined(self.script_badplace))
	{
		vehicle thread _vehicle_bad_place();
	}
	if(isdefined(vehicle.scriptbundlesettings))
	{
		settings = struct::get_script_bundle("vehiclecustomsettings", vehicle.scriptbundlesettings);
		if(isdefined(settings) && isdefined(settings.lightgroups_numgroups))
		{
			if(settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on === 1 && (!(isdefined(settings.var_1eaaada1) && settings.var_1eaaada1)))
			{
				vehicle toggle_lights_group(1, 1);
			}
			if(settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on === 1 && (!(isdefined(settings.var_97369f73) && settings.var_97369f73)))
			{
				vehicle toggle_lights_group(2, 1);
			}
			if(settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on === 1 && (!(isdefined(settings.var_acd5533) && settings.var_acd5533)))
			{
				vehicle toggle_lights_group(3, 1);
			}
			if(settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on === 1 && (!(isdefined(settings.var_bcb4ccd1) && settings.var_bcb4ccd1)))
			{
				vehicle toggle_lights_group(4, 1);
			}
		}
		if(isdefined(settings) && isdefined(settings.var_22b9bee1))
		{
			vehicle.var_22b9bee1 = 1;
		}
	}
	if(!vehicle is_cheap())
	{
		vehicle friendly_fire_shield();
	}
	levelstuff(vehicle);
	vehicle.disconnectpathdetail = 0;
	if(vehicle.vehicleclass === "artillery")
	{
		vehicle.disconnectpathonstop = undefined;
		self disconnect_paths(0);
	}
	else if(vehicle.var_46439e18 && !function_f99d2668())
	{
		vehicle.disconnectpathonstop = 1;
		vehicle.disconnectpathdetail = 2;
	}
	else
	{
		vehicle.disconnectpathonstop = self.script_disconnectpaths;
	}
	if(isdefined(self.script_disconnectpath_detail))
	{
		vehicle.disconnectpathdetail = self.script_disconnectpath_detail;
	}
	if(!vehicle is_cheap() && !vehicle.vehicleclass === "plane" && !vehicle.vehicleclass === "artillery")
	{
		vehicle thread _disconnect_paths_when_stopped();
	}
	if(!isdefined(vehicle.script_nonmovingvehicle))
	{
		path_start = get_target(vehicle);
		if(isdefined(path_start) && function_5f430582(path_start))
		{
			vehicle thread get_on_path(path_start);
		}
	}
	if(isdefined(vehicle.script_vehicleattackgroup))
	{
		vehicle thread attack_group_think();
	}
	/#
		if(isdefined(vehicle.script_recordent) && vehicle.script_recordent)
		{
			recordent(vehicle);
		}
	#/
	/#
		vehicle thread debug_vehicle();
	#/
	if(!vehicle vehicle_ai::function_6c17ee49())
	{
		vehicle thread vehicle_death::main();
	}
	if(isdefined(vehicle.script_targetset) && vehicle.script_targetset == 1)
	{
		offset = (0, 0, 0);
		if(isdefined(vehicle.script_targetoffset))
		{
			offset = vehicle.script_targetoffset;
		}
		make_targetable(vehicle, offset);
	}
	if(isdefined(vehicle.script_vehicleavoidance) && vehicle.script_vehicleavoidance)
	{
		vehicle setvehicleavoidance(1);
	}
	vehicle enable_turrets();
	if(isdefined(level.vehiclespawncallbackthread))
	{
		level thread [[level.vehiclespawncallbackthread]](vehicle);
	}
	heatseekingmissile::initlockfield(vehicle);
}

/*
	Name: make_targetable
	Namespace: vehicle
	Checksum: 0x9D753CB0
	Offset: 0x4908
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function make_targetable(vehicle, offset = (0, 0, 0))
{
	target_set(vehicle, offset);
}

/*
	Name: function_e2a44ff1
	Namespace: vehicle
	Checksum: 0x7A0B1C28
	Offset: 0x4950
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_e2a44ff1(vehicle)
{
	subtargets = target_getpotentialsubtargets(vehicle);
	if(subtargets.size > 1)
	{
		foreach(subtarget in subtargets)
		{
			if(subtarget)
			{
				thread subtarget_watch(vehicle, subtarget);
			}
		}
	}
}

/*
	Name: subtarget_watch
	Namespace: vehicle
	Checksum: 0x92FE8DD3
	Offset: 0x4A10
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function subtarget_watch(vehicle, subtarget)
{
	vehicle endon(#"death");
	target_set(vehicle, (0, 0, 0), subtarget);
	while(true)
	{
		waitresult = undefined;
		waitresult = vehicle waittill(#"subtarget_broken");
		if(waitresult.subtarget === subtarget)
		{
			break;
		}
	}
	if(target_istarget(vehicle, subtarget))
	{
		target_remove(vehicle, subtarget);
	}
}

/*
	Name: get_settings
	Namespace: vehicle
	Checksum: 0xC224C301
	Offset: 0x4AE0
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function get_settings()
{
	settings = getscriptbundle(self.scriptbundlesettings);
	return settings;
}

/*
	Name: detach_getoutrigs
	Namespace: vehicle
	Checksum: 0xBC61170C
	Offset: 0x4B18
	Size: 0x98
	Parameters: 0
	Flags: None
*/
function detach_getoutrigs()
{
	if(!isdefined(self.getoutrig))
	{
		return;
	}
	if(!self.getoutrig.size)
	{
		return;
	}
	foreach(v in self.getoutrig)
	{
		v unlink();
	}
}

/*
	Name: enable_turrets
	Namespace: vehicle
	Checksum: 0x5EAB67CC
	Offset: 0x4BB8
	Size: 0x21C
	Parameters: 1
	Flags: Linked
*/
function enable_turrets(veh = self)
{
	if(isdefined(self.script_enable_turret0) && self.script_enable_turret0)
	{
		veh turret::enable(0);
	}
	if(isdefined(self.script_enable_turret1) && self.script_enable_turret1)
	{
		veh turret::enable(1);
	}
	if(isdefined(self.script_enable_turret2) && self.script_enable_turret2)
	{
		veh turret::enable(2);
	}
	if(isdefined(self.script_enable_turret3) && self.script_enable_turret3)
	{
		veh turret::enable(3);
	}
	if(isdefined(self.script_enable_turret4) && self.script_enable_turret4)
	{
		veh turret::enable(4);
	}
	if(isdefined(self.script_enable_turret0) && !self.script_enable_turret0)
	{
		veh turret::disable(0);
	}
	if(isdefined(self.script_enable_turret1) && !self.script_enable_turret1)
	{
		veh turret::disable(1);
	}
	if(isdefined(self.script_enable_turret2) && !self.script_enable_turret2)
	{
		veh turret::disable(2);
	}
	if(isdefined(self.script_enable_turret3) && !self.script_enable_turret3)
	{
		veh turret::disable(3);
	}
	if(isdefined(self.script_enable_turret4) && !self.script_enable_turret4)
	{
		veh turret::disable(4);
	}
}

/*
	Name: _disconnect_paths_when_stopped
	Namespace: vehicle
	Checksum: 0xDEA461A9
	Offset: 0x4DE0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function _disconnect_paths_when_stopped()
{
	if(ispathfinder(self) && (!(isdefined(self.disconnectpathonstop) && self.disconnectpathonstop)))
	{
		return;
	}
	if(isdefined(self.script_disconnectpaths) && !self.script_disconnectpaths)
	{
		self.disconnectpathonstop = 0;
		return;
	}
	self function_d733412a(1);
}

/*
	Name: set_speed
	Namespace: vehicle
	Checksum: 0xBA54640F
	Offset: 0x4E70
	Size: 0x84
	Parameters: 3
	Flags: Linked
*/
function set_speed(speed, rate, msg)
{
	if(self getspeedmph() == 0 && speed == 0)
	{
		return;
	}
	/#
		self thread debug_set_speed(speed, rate, msg);
	#/
	self setspeed(speed, rate);
}

/*
	Name: debug_set_speed
	Namespace: vehicle
	Checksum: 0xAD44E0AC
	Offset: 0x4F00
	Size: 0xFC
	Parameters: 3
	Flags: None
*/
function debug_set_speed(speed, rate, msg)
{
	/#
		self notify(#"hash_7df59f670b5723ce");
		self endon(#"hash_7df59f670b5723ce", #"hash_7542a4bb12b44682", #"death");
		while(true)
		{
			while(getdvarstring(#"debug_vehiclesetspeed") != "")
			{
				print3d(self.origin + vectorscale((0, 0, 1), 192), "" + msg, (1, 1, 1), 1, 3);
				waitframe(1);
			}
			wait(0.5);
		}
	#/
}

/*
	Name: script_resume_speed
	Namespace: vehicle
	Checksum: 0x2CDACAAF
	Offset: 0x5008
	Size: 0x15C
	Parameters: 2
	Flags: Linked
*/
function script_resume_speed(msg, rate)
{
	fsetspeed = 0;
	type = "resumespeed";
	if(!isdefined(self.resumemsgs))
	{
		self.resumemsgs = [];
	}
	if(isdefined(self.waitingforgate) && self.waitingforgate)
	{
		return;
	}
	if(isdefined(self.attacking) && self.attacking)
	{
		fsetspeed = self.attackspeed;
		type = "setspeed";
	}
	self.zerospeed = 0;
	if(fsetspeed == 0)
	{
		self.zerospeed = 1;
	}
	if(type == "resumespeed")
	{
		self resumespeed(rate);
	}
	else if(type == "setspeed")
	{
		self set_speed(fsetspeed, 15, "resume setspeed from attack");
	}
	self notify(#"hash_7542a4bb12b44682");
	/#
		self thread debug_resume(msg + "" + type);
	#/
}

/*
	Name: debug_resume
	Namespace: vehicle
	Checksum: 0x8DB004B3
	Offset: 0x5170
	Size: 0x132
	Parameters: 1
	Flags: None
*/
function debug_resume(msg)
{
	/#
		if(getdvarstring(#"debug_vehicleresume") == "")
		{
			return;
		}
		self endon(#"death");
		number = self.resumemsgs.size;
		self.resumemsgs[number] = msg;
		self thread print_resume_speed(gettime() + int(3 * 1000));
		wait(3);
		newarray = [];
		for(i = 0; i < self.resumemsgs.size; i++)
		{
			if(i != number)
			{
				newarray[newarray.size] = self.resumemsgs[i];
			}
		}
		self.resumemsgs = newarray;
	#/
}

/*
	Name: print_resume_speed
	Namespace: vehicle
	Checksum: 0x534AFDAA
	Offset: 0x52B0
	Size: 0x128
	Parameters: 1
	Flags: None
*/
function print_resume_speed(timer)
{
	self notify(#"newresumespeedmsag");
	self endon(#"newresumespeedmsag", #"death");
	while(gettime() < timer && isdefined(self.resumemsgs))
	{
		if(self.resumemsgs.size > 6)
		{
			start = self.resumemsgs.size - 5;
		}
		else
		{
			start = 0;
		}
		for(i = start; i < self.resumemsgs.size; i++)
		{
			position = i * 32;
			/#
				print3d(self.origin + (0, 0, position), "" + self.resumemsgs[i], (0, 1, 0), 1, 3);
			#/
		}
		waitframe(1);
	}
}

/*
	Name: god_on
	Namespace: vehicle
	Checksum: 0x8192DB06
	Offset: 0x53E0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function god_on()
{
	self val::set(#"vehicle_god_on", "takedamage", 0);
}

/*
	Name: god_off
	Namespace: vehicle
	Checksum: 0xA4AD32D2
	Offset: 0x5418
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function god_off()
{
	self val::reset(#"vehicle_god_on", "takedamage");
}

/*
	Name: get_normal_anim_time
	Namespace: vehicle
	Checksum: 0x8B5195AC
	Offset: 0x5450
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function get_normal_anim_time(animation)
{
	animtime = self getanimtime(animation);
	animlength = getanimlength(animation);
	if(animtime == 0)
	{
		return 0;
	}
	return self getanimtime(animation) / getanimlength(animation);
}

/*
	Name: setup_dynamic_detour
	Namespace: vehicle
	Checksum: 0x7F12460E
	Offset: 0x54E0
	Size: 0x62
	Parameters: 2
	Flags: Linked
*/
function setup_dynamic_detour(pathnode, get_func)
{
	prevnode = [[get_func]](pathnode.targetname);
	/#
		assert(isdefined(prevnode), "");
	#/
	prevnode.detoured = 0;
}

/*
	Name: array_2d_add
	Namespace: vehicle
	Checksum: 0xE03246D5
	Offset: 0x5550
	Size: 0x5C
	Parameters: 3
	Flags: Linked
*/
function array_2d_add(array, firstelem, newelem)
{
	if(!isdefined(array[firstelem]))
	{
		array[firstelem] = [];
	}
	array[firstelem][array[firstelem].size] = newelem;
	return array;
}

/*
	Name: is_node_script_origin
	Namespace: vehicle
	Checksum: 0x68237562
	Offset: 0x55B8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function is_node_script_origin(pathnode)
{
	return isdefined(pathnode.classname) && pathnode.classname == "script_origin";
}

/*
	Name: node_trigger_process
	Namespace: vehicle
	Checksum: 0x98989035
	Offset: 0x55F8
	Size: 0x32C
	Parameters: 0
	Flags: Linked
*/
function node_trigger_process()
{
	processtrigger = 0;
	if(isdefined(self.spawnflags) && self.spawnflags & 1 == 1)
	{
		if(isdefined(self.script_crashtype))
		{
			level.vehicle_crashpaths[level.vehicle_crashpaths.size] = self;
		}
		level.vehicle_startnodes[level.vehicle_startnodes.size] = self;
	}
	if(isdefined(self.script_vehicledetour) && isdefined(self.targetname))
	{
		get_func = undefined;
		if(isdefined(get_from_entity(self.targetname)))
		{
			get_func = &get_from_entity_target;
		}
		if(isdefined(get_from_spawnstruct(self.targetname)))
		{
			get_func = &get_from_spawnstruct_target;
		}
		if(isdefined(get_func))
		{
			setup_dynamic_detour(self, get_func);
			processtrigger = 1;
		}
		else
		{
			setup_groundnode_detour(self);
		}
		level.vehicle_detourpaths = array_2d_add(level.vehicle_detourpaths, self.script_vehicledetour, self);
		/#
			if(level.vehicle_detourpaths[self.script_vehicledetour].size > 2)
			{
				println("", self.script_vehicledetour);
			}
		#/
	}
	if(isdefined(self.script_gatetrigger))
	{
		level.vehicle_gatetrigger = array_2d_add(level.vehicle_gatetrigger, self.script_gatetrigger, self);
		self.gateopen = 0;
	}
	if(isdefined(self.script_flag_set))
	{
		if(!isdefined(level.flag) || !isdefined(level.flag[self.script_flag_set]))
		{
			level flag::init(self.script_flag_set);
		}
	}
	if(isdefined(self.script_flag_clear))
	{
		if(!level flag::exists(self.script_flag_clear))
		{
			level flag::init(self.script_flag_clear);
		}
	}
	if(isdefined(self.script_flag_wait))
	{
		if(!level flag::exists(self.script_flag_wait))
		{
			level flag::init(self.script_flag_wait);
		}
	}
	if(isdefined(self.script_vehiclespawngroup) || isdefined(self.script_vehiclestartmove) || isdefined(self.script_gatetrigger) || isdefined(self.script_vehiclegroupdelete))
	{
		processtrigger = 1;
	}
	if(processtrigger)
	{
		add_proccess_trigger(self);
	}
}

/*
	Name: setup_triggers
	Namespace: vehicle
	Checksum: 0x9674FA8C
	Offset: 0x5930
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function setup_triggers()
{
	level.vehicle_processtriggers = [];
	triggers = [];
	triggers = arraycombine(getallvehiclenodes(), getentarray("script_origin", "classname"), 1, 0);
	triggers = arraycombine(triggers, level.struct, 1, 0);
	triggers = arraycombine(triggers, trigger::get_all(), 1, 0);
	array::thread_all(triggers, &node_trigger_process);
}

/*
	Name: setup_nodes
	Namespace: vehicle
	Checksum: 0x5C677F6A
	Offset: 0x5A20
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function setup_nodes()
{
	a_nodes = getallvehiclenodes();
	foreach(node in a_nodes)
	{
		if(isdefined(node.script_flag_set))
		{
			if(!level flag::exists(node.script_flag_set))
			{
				level flag::init(node.script_flag_set);
			}
		}
	}
}

/*
	Name: is_node_script_struct
	Namespace: vehicle
	Checksum: 0x729C98E3
	Offset: 0x5AF0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function is_node_script_struct(node)
{
	if(!isdefined(node.targetname))
	{
		return 0;
	}
	return isdefined(struct::get(node.targetname, "targetname"));
}

/*
	Name: setup_spawners
	Namespace: vehicle
	Checksum: 0xA91C49B0
	Offset: 0x5B40
	Size: 0x368
	Parameters: 1
	Flags: Linked
*/
function setup_spawners(a_veh_spawners)
{
	spawnvehicles = [];
	groups = [];
	foreach(spawner in a_veh_spawners)
	{
		if(isdefined(spawner.script_vehiclespawngroup))
		{
			if(!isdefined(spawnvehicles[spawner.script_vehiclespawngroup]))
			{
				spawnvehicles[spawner.script_vehiclespawngroup] = [];
			}
			else if(!isarray(spawnvehicles[spawner.script_vehiclespawngroup]))
			{
				spawnvehicles[spawner.script_vehiclespawngroup] = array(spawnvehicles[spawner.script_vehiclespawngroup]);
			}
			spawnvehicles[spawner.script_vehiclespawngroup][spawnvehicles[spawner.script_vehiclespawngroup].size] = spawner;
			addgroup[0] = spawner.script_vehiclespawngroup;
			groups = arraycombine(groups, addgroup, 0, 0);
		}
	}
	waittillframeend();
	foreach(spawngroup in groups)
	{
		a_veh_spawners = spawnvehicles[spawngroup];
		level.vehicle_spawners[spawngroup] = [];
		foreach(sp in a_veh_spawners)
		{
			if(sp.count < 1)
			{
				sp.count = 1;
			}
			set_variables(sp);
			if(!isdefined(level.vehicle_spawners[spawngroup]))
			{
				level.vehicle_spawners[spawngroup] = [];
			}
			else if(!isarray(level.vehicle_spawners[spawngroup]))
			{
				level.vehicle_spawners[spawngroup] = array(level.vehicle_spawners[spawngroup]);
			}
			level.vehicle_spawners[spawngroup][level.vehicle_spawners[spawngroup].size] = sp;
		}
		level thread _spawn_group(spawngroup);
	}
}

/*
	Name: _vehicle_life
	Namespace: vehicle
	Checksum: 0xF774A200
	Offset: 0x5EB0
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function _vehicle_life()
{
	if(isdefined(self.destructibledef))
	{
		self.health = 99999;
	}
	else
	{
		type = self.vehicletype;
		if(isdefined(self.script_startinghealth))
		{
			self.health = self.script_startinghealth;
		}
		else if(!self.var_dd74f4a9)
		{
			return;
		}
		self.health = self.healthdefault;
	}
}

/*
	Name: _vehicle_load_assets
	Namespace: vehicle
	Checksum: 0x80F724D1
	Offset: 0x5F30
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function _vehicle_load_assets()
{
}

/*
	Name: is_cheap
	Namespace: vehicle
	Checksum: 0x138FD3FB
	Offset: 0x5F40
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function is_cheap()
{
	if(!isdefined(self.script_cheap))
	{
		return 0;
	}
	if(!self.script_cheap)
	{
		return 0;
	}
	return 1;
}

/*
	Name: play_looped_fx_on_tag
	Namespace: vehicle
	Checksum: 0x4E863BBD
	Offset: 0x5F70
	Size: 0xCE
	Parameters: 3
	Flags: None
*/
function play_looped_fx_on_tag(effect, durration, tag)
{
	emodel = get_dummy();
	effectorigin = sys::spawn("script_origin", emodel.origin);
	self endon(#"fire_extinguish");
	thread _play_looped_fx_on_tag_origin_update(tag, effectorigin);
	while(true)
	{
		playfx(effect, effectorigin.origin, effectorigin.upvec);
		wait(durration);
	}
}

/*
	Name: _play_looped_fx_on_tag_origin_update
	Namespace: vehicle
	Checksum: 0xF741E52D
	Offset: 0x6048
	Size: 0x198
	Parameters: 2
	Flags: Linked
*/
function _play_looped_fx_on_tag_origin_update(tag, effectorigin)
{
	effectorigin.angles = self gettagangles(tag);
	effectorigin.origin = self gettagorigin(tag);
	effectorigin.forwardvec = anglestoforward(effectorigin.angles);
	while(isdefined(self) && self.classname == "script_vehicle" && self getspeedmph() > 0)
	{
		emodel = get_dummy();
		effectorigin.angles = emodel gettagangles(tag);
		effectorigin.origin = emodel gettagorigin(tag);
		effectorigin.forwardvec = anglestoforward(effectorigin.angles);
		effectorigin.upvec = anglestoup(effectorigin.angles);
		waitframe(1);
	}
}

/*
	Name: setup_dvars
	Namespace: vehicle
	Checksum: 0xDFA96F0
	Offset: 0x61E8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function setup_dvars()
{
	/#
		if(getdvarstring(#"debug_vehicleresume") == "")
		{
			setdvar(#"debug_vehicleresume", "");
		}
		if(getdvarstring(#"debug_vehiclesetspeed") == "")
		{
			setdvar(#"debug_vehiclesetspeed", "");
		}
	#/
}

/*
	Name: setup_level_vars
	Namespace: vehicle
	Checksum: 0x10BB8C9D
	Offset: 0x62B0
	Size: 0x2E6
	Parameters: 0
	Flags: Linked
*/
function setup_level_vars()
{
	level.vehicle_resumespeed = 5;
	level.vehicle_deletegroup = [];
	level.vehicle_spawngroup = [];
	level.vehicle_startmovegroup = [];
	level.vehicle_deathswitch = [];
	level.vehicle_gatetrigger = [];
	level.vehicle_crashpaths = [];
	level.vehicle_link = [];
	level.vehicle_detourpaths = [];
	level.vehicle_startnodes = [];
	level.vehicle_spawners = [];
	level.a_str_vehicle_spawn_custom_keys = [];
	level.vehicle_walkercount = [];
	level.helicopter_crash_locations = getentarray("helicopter_crash_location", "targetname");
	level.playervehicle = sys::spawn("script_origin", (0, 0, 0));
	level.playervehiclenone = level.playervehicle;
	if(!isdefined(level.vehicle_death_thread))
	{
		level.vehicle_death_thread = [];
	}
	if(!isdefined(level.vehicle_driveidle))
	{
		level.vehicle_driveidle = [];
	}
	if(!isdefined(level.vehicle_driveidle_r))
	{
		level.vehicle_driveidle_r = [];
	}
	if(!isdefined(level.attack_origin_condition_threadd))
	{
		level.attack_origin_condition_threadd = [];
	}
	if(!isdefined(level.vehiclefireanim))
	{
		level.vehiclefireanim = [];
	}
	if(!isdefined(level.vehiclefireanim_settle))
	{
		level.vehiclefireanim_settle = [];
	}
	if(!isdefined(level.vehicle_hasname))
	{
		level.vehicle_hasname = [];
	}
	if(!isdefined(level.vehicle_turret_requiresrider))
	{
		level.vehicle_turret_requiresrider = [];
	}
	if(!isdefined(level.vehicle_isstationary))
	{
		level.vehicle_isstationary = [];
	}
	if(!isdefined(level.vehicle_compassicon))
	{
		level.vehicle_compassicon = [];
	}
	if(!isdefined(level.vehicle_unloadgroups))
	{
		level.vehicle_unloadgroups = [];
	}
	if(!isdefined(level.vehicle_unloadwhenattacked))
	{
		level.vehicle_unloadwhenattacked = [];
	}
	if(!isdefined(level.vehicle_deckdust))
	{
		level.vehicle_deckdust = [];
	}
	if(!isdefined(level.vehicle_types))
	{
		level.vehicle_types = [];
	}
	if(!isdefined(level.vehicle_compass_types))
	{
		level.vehicle_compass_types = [];
	}
	if(!isdefined(level.vehicle_bulletshield))
	{
		level.vehicle_bulletshield = [];
	}
	if(!isdefined(level.vehicle_death_badplace))
	{
		level.vehicle_death_badplace = [];
	}
}

/*
	Name: attacker_is_on_my_team
	Namespace: vehicle
	Checksum: 0x834EF563
	Offset: 0x65A0
	Size: 0x6E
	Parameters: 1
	Flags: None
*/
function attacker_is_on_my_team(attacker)
{
	if(isdefined(attacker) && isdefined(attacker.team) && isdefined(self.team) && !util::function_fbce7263(attacker.team, self.team))
	{
		return 1;
	}
	return 0;
}

/*
	Name: bullet_shielded
	Namespace: vehicle
	Checksum: 0xA4A144CF
	Offset: 0x6618
	Size: 0x7E
	Parameters: 1
	Flags: None
*/
function bullet_shielded(type)
{
	if(!isdefined(self.script_bulletshield))
	{
		return 0;
	}
	type = tolower(type);
	if(!isdefined(type) || !issubstr(type, "bullet"))
	{
		return 0;
	}
	if(self.script_bulletshield)
	{
		return 1;
	}
	return 0;
}

/*
	Name: friendly_fire_shield
	Namespace: vehicle
	Checksum: 0x7E21A4B3
	Offset: 0x66A0
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function friendly_fire_shield()
{
	if(isdefined(level.vehicle_bulletshield[self.vehicletype]) && !isdefined(self.script_bulletshield))
	{
		self.script_bulletshield = level.vehicle_bulletshield[self.vehicletype];
	}
}

/*
	Name: _vehicle_bad_place
	Namespace: vehicle
	Checksum: 0xD8647759
	Offset: 0x66F0
	Size: 0x20E
	Parameters: 0
	Flags: Linked
*/
function _vehicle_bad_place()
{
	self endon(#"kill_badplace_forever", #"death", #"delete");
	if(isdefined(level.custombadplacethread))
	{
		self thread [[level.custombadplacethread]]();
		return;
	}
	hasturret = isdefined(self.turretweapon) && self.turretweapon != level.weaponnone;
	while(true)
	{
		if(!self.script_badplace)
		{
			while(!self.script_badplace)
			{
				wait(0.5);
			}
		}
		speed = self getspeedmph();
		if(speed <= 0)
		{
			wait(0.5);
			continue;
		}
		if(speed < 5)
		{
			bp_radius = 200;
		}
		else if(speed > 5 && speed < 8)
		{
			bp_radius = 350;
		}
		else
		{
			bp_radius = 500;
		}
		if(isdefined(self.badplacemodifier))
		{
			bp_radius = bp_radius * self.badplacemodifier;
		}
		v_turret_angles = self gettagangles("tag_turret");
		if(hasturret && isdefined(v_turret_angles))
		{
			bp_direction = anglestoforward(v_turret_angles);
		}
		else
		{
			bp_direction = anglestoforward(self.angles);
		}
		wait(0.5 + 0.05);
	}
}

/*
	Name: get_vehiclenode_any_dynamic
	Namespace: vehicle
	Checksum: 0x6F9C6C24
	Offset: 0x6908
	Size: 0x11A
	Parameters: 1
	Flags: Linked
*/
function get_vehiclenode_any_dynamic(target)
{
	path_start = getvehiclenode(target, "targetname");
	if(!isdefined(path_start))
	{
		path_start = getent(target, "targetname");
	}
	else if(self.vehicleclass === "plane")
	{
		/#
			println("" + path_start.targetname);
			println("" + self.vehicletype);
		#/
		/#
			assertmsg("");
		#/
	}
	if(!isdefined(path_start))
	{
		path_start = struct::get(target, "targetname");
	}
	return path_start;
}

/*
	Name: resume_path_vehicle
	Namespace: vehicle
	Checksum: 0xC1463817
	Offset: 0x6A30
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function resume_path_vehicle()
{
	if(isdefined(self.currentnode.target))
	{
		node = get_vehiclenode_any_dynamic(self.currentnode.target);
	}
	if(isdefined(node))
	{
		self resumespeed(35);
		paths(node);
	}
}

/*
	Name: land
	Namespace: vehicle
	Checksum: 0xA58C3D69
	Offset: 0x6AB8
	Size: 0x102
	Parameters: 0
	Flags: None
*/
function land()
{
	self setneargoalnotifydist(2);
	self sethoverparams(0, 0, 10);
	self cleargoalyaw();
	self settargetyaw((0, self.angles[1], 0)[1]);
	self set_goal_pos(groundtrace(self.origin + vectorscale((0, 0, 1), 8), self.origin + vectorscale((0, 0, -1), 100000), 0, self)[#"position"], 1);
	self waittill(#"goal");
}

/*
	Name: set_goal_pos
	Namespace: vehicle
	Checksum: 0xBBEBCF40
	Offset: 0x6BC8
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function set_goal_pos(origin, bstop)
{
	if(self.health <= 0)
	{
		return;
	}
	if(isdefined(self.originheightoffset))
	{
		origin = origin + (0, 0, self.originheightoffset);
	}
	self function_a57c34b7(origin, bstop);
}

/*
	Name: liftoff
	Namespace: vehicle
	Checksum: 0x685FED58
	Offset: 0x6C38
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function liftoff(height = 512)
{
	dest = self.origin + (0, 0, height);
	self setneargoalnotifydist(10);
	self set_goal_pos(dest, 1);
	self waittill(#"goal");
}

/*
	Name: wait_till_stable
	Namespace: vehicle
	Checksum: 0xB0ABA600
	Offset: 0x6CD0
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function wait_till_stable()
{
	while(isdefined(self))
	{
		if(self.angles[0] > 12 || self.angles[0] < -1 * 12)
		{
			timer = gettime() + 400;
		}
		if(self.angles[2] > 12 || self.angles[2] < -1 * 12)
		{
			timer = gettime() + 400;
		}
		if(gettime() > timer)
		{
			break;
		}
		waitframe(1);
	}
}

/*
	Name: unload_node
	Namespace: vehicle
	Checksum: 0x6EA229C6
	Offset: 0x6DA8
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function unload_node(node)
{
	if(isdefined(self.custom_unload_function))
	{
		[[self.custom_unload_function]]();
		return;
	}
	pause_path();
	if(self.vehicleclass === "plane")
	{
		wait_till_stable();
	}
	else if(self.vehicleclass === "helicopter")
	{
		self sethoverparams(0, 0, 10);
		wait_till_stable();
	}
	if(node is_unload_node())
	{
		unload(node.script_unload);
	}
}

/*
	Name: is_unload_node
	Namespace: vehicle
	Checksum: 0x578480A5
	Offset: 0x6E98
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function is_unload_node()
{
	return isdefined(self.script_unload) && self.script_unload != "none";
}

/*
	Name: unload_node_helicopter
	Namespace: vehicle
	Checksum: 0xE25C1A41
	Offset: 0x6EC8
	Size: 0x23A
	Parameters: 1
	Flags: Linked
*/
function unload_node_helicopter(node)
{
	if(isdefined(self.custom_unload_function))
	{
		self thread [[self.custom_unload_function]]();
	}
	self sethoverparams(0, 0, 10);
	goal = self.nextnode.origin;
	start = self.nextnode.origin;
	end = start - vectorscale((0, 0, 1), 10000);
	trace = bullettrace(start, end, 0, undefined);
	if(trace[#"fraction"] <= 1)
	{
		goal = (trace[#"position"][0], trace[#"position"][1], trace[#"position"][2] + self.fastropeoffset);
	}
	drop_offset_tag = "tag_fastrope_ri";
	if(isdefined(self.drop_offset_tag))
	{
		drop_offset_tag = self.drop_offset_tag;
	}
	drop_offset = self gettagorigin("tag_origin") - self gettagorigin(drop_offset_tag);
	goal = goal + (drop_offset[0], drop_offset[1], 0);
	self function_a57c34b7(goal, 1);
	self waittill(#"goal");
	self notify(#"unload", {#who:self.nextnode.script_unload});
	self waittill(#"unloaded");
}

/*
	Name: detach_path
	Namespace: vehicle
	Checksum: 0x428786D4
	Offset: 0x7110
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function detach_path()
{
	self.attachedpath = undefined;
	self notify(#"newpath");
	if(isvehicle(self))
	{
		speed = self getgoalspeedmph();
		if(speed == 0)
		{
			self setspeed(0.01);
		}
		self setgoalyaw((0, self.angles[1], 0)[1]);
		self function_a57c34b7(self.origin + vectorscale((0, 0, 1), 4), 1);
	}
}

/*
	Name: simple_spawn
	Namespace: vehicle
	Checksum: 0x7108145F
	Offset: 0x7200
	Size: 0x1D0
	Parameters: 2
	Flags: Linked
*/
function simple_spawn(name_or_spawners, b_supress_assert = 0)
{
	a_spawners = [];
	if(isstring(name_or_spawners))
	{
		a_spawners = getvehiclespawnerarray(name_or_spawners, "targetname");
		/#
			assert(a_spawners.size || b_supress_assert, "" + name_or_spawners + "");
		#/
	}
	else if(!isdefined(name_or_spawners))
	{
		name_or_spawners = [];
	}
	else if(!isarray(name_or_spawners))
	{
		name_or_spawners = array(name_or_spawners);
	}
	a_spawners = name_or_spawners;
	a_vehicles = [];
	foreach(sp in a_spawners)
	{
		vh = _vehicle_spawn(sp);
		if(!isdefined(a_vehicles))
		{
			a_vehicles = [];
		}
		else if(!isarray(a_vehicles))
		{
			a_vehicles = array(a_vehicles);
		}
		a_vehicles[a_vehicles.size] = vh;
	}
	return a_vehicles;
}

/*
	Name: simple_spawn_single
	Namespace: vehicle
	Checksum: 0x454AD0C1
	Offset: 0x73D8
	Size: 0xAA
	Parameters: 2
	Flags: None
*/
function simple_spawn_single(name, b_supress_assert = 0)
{
	vehicle_array = simple_spawn(name, b_supress_assert);
	/#
		assert(b_supress_assert || vehicle_array.size == 1, "" + name + "" + vehicle_array.size + "");
	#/
	if(vehicle_array.size > 0)
	{
		return vehicle_array[0];
	}
}

/*
	Name: simple_spawn_single_and_drive
	Namespace: vehicle
	Checksum: 0xB9F0C8EB
	Offset: 0x7490
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function simple_spawn_single_and_drive(name)
{
	vehiclearray = simple_spawn(name);
	/#
		assert(vehiclearray.size == 1, "" + name + "" + vehiclearray.size + "");
	#/
	vehiclearray[0] thread go_path();
	return vehiclearray[0];
}

/*
	Name: simple_spawn_and_drive
	Namespace: vehicle
	Checksum: 0x91540B11
	Offset: 0x7530
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function simple_spawn_and_drive(name)
{
	vehiclearray = simple_spawn(name);
	for(i = 0; i < vehiclearray.size; i++)
	{
		vehiclearray[i] thread go_path();
	}
	return vehiclearray;
}

/*
	Name: spawn
	Namespace: vehicle
	Checksum: 0xD0740E8F
	Offset: 0x75B0
	Size: 0xBA
	Parameters: 6
	Flags: None
*/
function spawn(modelname, targetname, vehicletype, origin, angles, destructibledef)
{
	/#
		assert(isdefined(targetname));
	#/
	/#
		assert(isdefined(vehicletype));
	#/
	/#
		assert(isdefined(origin));
	#/
	/#
		assert(isdefined(angles));
	#/
	return spawnvehicle(vehicletype, origin, angles, targetname, destructibledef);
}

/*
	Name: impact_fx
	Namespace: vehicle
	Checksum: 0x87D94280
	Offset: 0x7678
	Size: 0x1D4
	Parameters: 2
	Flags: None
*/
function impact_fx(fxname, surfacetypes)
{
	if(isdefined(fxname))
	{
		body = self gettagorigin("tag_body");
		if(!isdefined(body))
		{
			body = self.origin + vectorscale((0, 0, 1), 10);
		}
		trace = bullettrace(body, body - (0, 0, 2 * self.radius), 0, self);
		if(trace[#"fraction"] < 1 && !isdefined(trace[#"entity"]) && (!isdefined(surfacetypes) || array::contains(surfacetypes, trace[#"surfacetype"])))
		{
			pos = 0.5 * self.origin + trace[#"position"];
			up = 0.5 * trace[#"normal"] + anglestoup(self.angles);
			forward = anglestoforward(self.angles);
			playfx(fxname, pos, up, forward);
		}
	}
}

/*
	Name: maingun_fx
	Namespace: vehicle
	Checksum: 0x93202D20
	Offset: 0x7858
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function maingun_fx()
{
	if(!isdefined(level.vehicle_deckdust[self.model]))
	{
		return;
	}
	self endon(#"death");
	while(true)
	{
		self waittill(#"weapon_fired");
		playfxontag(level.vehicle_deckdust[self.model], self, "tag_engine_exhaust");
		barrel_origin = self gettagorigin("tag_flash");
		ground = physicstrace(barrel_origin, barrel_origin + vectorscale((0, 0, -1), 128));
		physicsexplosionsphere(ground, 192, 100, 1);
	}
}

/*
	Name: toggle_force_driver_taillights
	Namespace: vehicle
	Checksum: 0xA48356B1
	Offset: 0x7958
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function toggle_force_driver_taillights(on)
{
	bit = 1;
	if(!on)
	{
		bit = 0;
	}
	self clientfield::set("toggle_force_driver_taillights", bit);
}

/*
	Name: toggle_lights_group
	Namespace: vehicle
	Checksum: 0x3076B5A3
	Offset: 0x79B0
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function toggle_lights_group(groupid, on)
{
	bit = 1;
	if(!on)
	{
		bit = 0;
	}
	self clientfield::set("toggle_lights_group" + groupid, bit);
}

/*
	Name: control_lights_groups
	Namespace: vehicle
	Checksum: 0xDA54005
	Offset: 0x7A10
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function control_lights_groups(on)
{
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(!isdefined(settings) || !isdefined(settings.lightgroups_numgroups))
	{
		return;
	}
	if(settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on !== 1 && (!(isdefined(level.var_f1997f07) && level.var_f1997f07)))
	{
		toggle_lights_group(1, on);
	}
	if(settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on !== 1)
	{
		toggle_lights_group(2, on);
	}
	if(settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on !== 1)
	{
		toggle_lights_group(3, on);
	}
	if(settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on !== 1)
	{
		toggle_lights_group(4, on);
	}
}

/*
	Name: lights_on
	Namespace: vehicle
	Checksum: 0xE73305D0
	Offset: 0x7BA8
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function lights_on(team)
{
	if(isdefined(team))
	{
		if(team == #"allies")
		{
			self clientfield::set("toggle_lights", 2);
		}
		else if(team == #"axis")
		{
			self clientfield::set("toggle_lights", 3);
		}
	}
	else
	{
		self clientfield::set("toggle_lights", 0);
	}
	control_lights_groups(1);
}

/*
	Name: lights_off
	Namespace: vehicle
	Checksum: 0xF125E180
	Offset: 0x7C78
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function lights_off()
{
	self clientfield::set("toggle_lights", 1);
	control_lights_groups(0);
}

/*
	Name: toggle_ambient_anim_group
	Namespace: vehicle
	Checksum: 0x84E98F61
	Offset: 0x7CC0
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function toggle_ambient_anim_group(groupid, on)
{
	bit = 1;
	if(!on)
	{
		bit = 0;
	}
	self clientfield::set("toggle_ambient_anim_group" + groupid, bit);
}

/*
	Name: toggle_control_bone_group
	Namespace: vehicle
	Checksum: 0xD4587A85
	Offset: 0x7D20
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function toggle_control_bone_group(groupid, on)
{
	bit = 1;
	if(!on)
	{
		bit = 0;
	}
	self clientfield::set("toggle_control_bone_group" + groupid, bit);
}

/*
	Name: do_death_fx
	Namespace: vehicle
	Checksum: 0x4EFD23CA
	Offset: 0x7D80
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function do_death_fx()
{
	deathfxtype = (self.died_by_emp === 1 ? 2 : 1);
	self clientfield::set("deathfx", deathfxtype);
	self stopsounds();
}

/*
	Name: toggle_emp_fx
	Namespace: vehicle
	Checksum: 0xDCF00CF3
	Offset: 0x7DF0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function toggle_emp_fx(on)
{
	self clientfield::set("toggle_emp_fx", on);
}

/*
	Name: toggle_burn_fx
	Namespace: vehicle
	Checksum: 0xD671F5F8
	Offset: 0x7E28
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function toggle_burn_fx(on)
{
	self clientfield::set("toggle_burn_fx", on);
}

/*
	Name: do_death_dynents
	Namespace: vehicle
	Checksum: 0x61C66CB8
	Offset: 0x7E60
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function do_death_dynents(special_status = 1)
{
	/#
		assert(special_status >= 0 && special_status <= 3);
	#/
	self clientfield::set("spawn_death_dynents", special_status);
}

/*
	Name: do_gib_dynents
	Namespace: vehicle
	Checksum: 0x81355994
	Offset: 0x7ED8
	Size: 0xAE
	Parameters: 0
	Flags: None
*/
function do_gib_dynents()
{
	self clientfield::set("spawn_gib_dynents", 1);
	numdynents = 2;
	for(i = 0; i < numdynents; i++)
	{
		hidetag = self.settings.("servo_gib_tag" + i);
		if(isdefined(hidetag))
		{
			self hidepart(hidetag, "", 1);
		}
	}
}

/*
	Name: set_alert_fx_level
	Namespace: vehicle
	Checksum: 0x18D020C3
	Offset: 0x7F90
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function set_alert_fx_level(alert_level)
{
	self clientfield::set("alert_level", alert_level);
}

/*
	Name: should_update_damage_fx_level
	Namespace: vehicle
	Checksum: 0x497008F7
	Offset: 0x7FC8
	Size: 0x38A
	Parameters: 3
	Flags: Linked
*/
function should_update_damage_fx_level(currenthealth, damage, maxhealth)
{
	if(!isdefined(self.scriptbundlesettings))
	{
		return 0;
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(!isdefined(settings))
	{
		return 0;
	}
	currentratio = math::clamp(float(currenthealth) / float(maxhealth), 0, 1);
	afterdamageratio = math::clamp(float(currenthealth - damage) / float(maxhealth), 0, 1);
	currentlevel = undefined;
	afterdamagelevel = undefined;
	switch((isdefined(settings.damagestate_numstates) ? settings.damagestate_numstates : 0))
	{
		case 6:
		{
			if(settings.damagestate_lv6_ratio >= afterdamageratio)
			{
				afterdamagelevel = 6;
				currentlevel = 6;
				if(settings.damagestate_lv6_ratio < currentratio)
				{
					currentlevel = 5;
				}
				break;
			}
		}
		case 5:
		{
			if(settings.damagestate_lv5_ratio >= afterdamageratio)
			{
				afterdamagelevel = 5;
				currentlevel = 5;
				if(settings.damagestate_lv5_ratio < currentratio)
				{
					currentlevel = 4;
				}
				break;
			}
		}
		case 4:
		{
			if(settings.damagestate_lv4_ratio >= afterdamageratio)
			{
				afterdamagelevel = 4;
				currentlevel = 4;
				if(settings.damagestate_lv4_ratio < currentratio)
				{
					currentlevel = 3;
				}
				break;
			}
		}
		case 3:
		{
			if(settings.damagestate_lv3_ratio >= afterdamageratio)
			{
				afterdamagelevel = 3;
				currentlevel = 3;
				if(settings.damagestate_lv3_ratio < currentratio)
				{
					currentlevel = 2;
				}
				break;
			}
		}
		case 2:
		{
			if(settings.damagestate_lv2_ratio >= afterdamageratio)
			{
				afterdamagelevel = 2;
				currentlevel = 2;
				if(settings.damagestate_lv2_ratio < currentratio)
				{
					currentlevel = 1;
				}
				break;
			}
		}
		case 1:
		{
			if(settings.damagestate_lv1_ratio >= afterdamageratio)
			{
				afterdamagelevel = 1;
				currentlevel = 1;
				if(settings.damagestate_lv1_ratio < currentratio)
				{
					currentlevel = 0;
				}
				break;
			}
		}
		default:
		{
		}
	}
	if(!isdefined(currentlevel) || !isdefined(afterdamagelevel))
	{
		return 0;
	}
	if(currentlevel != afterdamagelevel)
	{
		return afterdamagelevel;
	}
	return 0;
}

/*
	Name: update_damage_fx_level
	Namespace: vehicle
	Checksum: 0x78386E7F
	Offset: 0x8360
	Size: 0x6C
	Parameters: 3
	Flags: None
*/
function update_damage_fx_level(currenthealth, damage, maxhealth)
{
	newdamagelevel = should_update_damage_fx_level(currenthealth, damage, maxhealth);
	if(newdamagelevel > 0)
	{
		self set_damage_fx_level(newdamagelevel);
		return 1;
	}
	return 0;
}

/*
	Name: set_damage_fx_level
	Namespace: vehicle
	Checksum: 0x6DAFCC52
	Offset: 0x83D8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function set_damage_fx_level(damage_level)
{
	self clientfield::set("damage_level", damage_level);
}

/*
	Name: build_drive
	Namespace: vehicle
	Checksum: 0xBA495190
	Offset: 0x8410
	Size: 0xB2
	Parameters: 4
	Flags: None
*/
function build_drive(forward, reverse, normalspeed = 10, rate)
{
	level.vehicle_driveidle[self.model] = forward;
	if(isdefined(reverse))
	{
		level.vehicle_driveidle_r[self.model] = reverse;
	}
	level.vehicle_driveidle_normal_speed[self.model] = normalspeed;
	if(isdefined(rate))
	{
		level.vehicle_driveidle_animrate[self.model] = rate;
	}
}

/*
	Name: function_ea56e00e
	Namespace: vehicle
	Checksum: 0xE5D1B2F0
	Offset: 0x84D0
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function function_ea56e00e(vehicle)
{
	target = get_target(vehicle);
	if(!isdefined(target))
	{
		vehicle setgoal(vehicle.origin, 0, vehicle.goalradius, vehicle.goalheight);
	}
	else
	{
		vehicle setgoal(target.origin, 1);
	}
}

/*
	Name: get_target
	Namespace: vehicle
	Checksum: 0x4928FB3C
	Offset: 0x8570
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function get_target(vehicle)
{
	target = undefined;
	if(isdefined(vehicle.target))
	{
		target = getvehiclenode(vehicle.target, "targetname");
		if(!isdefined(target))
		{
			target = get_from_entity(vehicle.target);
			if(!isdefined(target))
			{
				target = get_from_spawnstruct(vehicle.target);
			}
		}
	}
	return target;
}

/*
	Name: get_from_spawnstruct
	Namespace: vehicle
	Checksum: 0xEAD92AF9
	Offset: 0x8628
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function get_from_spawnstruct(target)
{
	return struct::get(target, "targetname");
}

/*
	Name: get_from_entity
	Namespace: vehicle
	Checksum: 0xC164C45A
	Offset: 0x8660
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function get_from_entity(target)
{
	return getent(target, "targetname");
}

/*
	Name: get_from_spawnstruct_target
	Namespace: vehicle
	Checksum: 0xA1F6EB51
	Offset: 0x8698
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function get_from_spawnstruct_target(target)
{
	return struct::get(target, "target");
}

/*
	Name: get_from_entity_target
	Namespace: vehicle
	Checksum: 0xC44A3BB9
	Offset: 0x86D0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function get_from_entity_target(target)
{
	return getent(target, "target");
}

/*
	Name: is_destructible
	Namespace: vehicle
	Checksum: 0xF95B554D
	Offset: 0x8708
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function is_destructible()
{
	return isdefined(self.destructible_type);
}

/*
	Name: attack_group_think
	Namespace: vehicle
	Checksum: 0xD4852871
	Offset: 0x8720
	Size: 0x2CC
	Parameters: 0
	Flags: Linked
*/
function attack_group_think()
{
	self endon(#"death", #"hash_bfb3547eac174da", #"hash_1f5849cf956e2ad");
	if(isdefined(self.script_vehicleattackgroupwait))
	{
		wait(self.script_vehicleattackgroupwait);
	}
	for(;;)
	{
		group = getentarray("script_vehicle", "classname");
		valid_targets = [];
		for(i = 0; i < group.size; i++)
		{
			if(!isdefined(group[i].script_vehiclespawngroup))
			{
				continue;
			}
			if(group[i].script_vehiclespawngroup == self.script_vehicleattackgroup)
			{
				if(util::function_fbce7263(group[i].team, self.team))
				{
					if(!isdefined(valid_targets))
					{
						valid_targets = [];
					}
					else if(!isarray(valid_targets))
					{
						valid_targets = array(valid_targets);
					}
					valid_targets[valid_targets.size] = group[i];
				}
			}
		}
		if(valid_targets.size == 0)
		{
			wait(0.5);
			continue;
		}
		for(;;)
		{
			current_target = undefined;
			if(valid_targets.size != 0)
			{
				current_target = self get_nearest_target(valid_targets);
			}
			else
			{
				self notify(#"hash_1f5849cf956e2ad");
			}
			if(current_target.health <= 0)
			{
				arrayremovevalue(valid_targets, current_target);
				continue;
				continue;
			}
			self turretsettarget(0, current_target, vectorscale((0, 0, 1), 50));
			if(isdefined(self.fire_delay_min) && isdefined(self.fire_delay_max))
			{
				if(self.fire_delay_max < self.fire_delay_min)
				{
					self.fire_delay_max = self.fire_delay_min;
				}
				wait(randomintrange(self.fire_delay_min, self.fire_delay_max));
			}
			else
			{
				wait(randomintrange(4, 6));
			}
			self fireweapon();
		}
	}
}

/*
	Name: get_nearest_target
	Namespace: vehicle
	Checksum: 0x1109B755
	Offset: 0x89F8
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function get_nearest_target(valid_targets)
{
	nearest_distsq = 99999999;
	nearest = undefined;
	for(i = 0; i < valid_targets.size; i++)
	{
		if(!isdefined(valid_targets[i]))
		{
			continue;
		}
		current_distsq = distancesquared(self.origin, valid_targets[i].origin);
		if(current_distsq < nearest_distsq)
		{
			nearest_distsq = current_distsq;
			nearest = valid_targets[i];
		}
	}
	return nearest;
}

/*
	Name: debug_vehicle
	Namespace: vehicle
	Checksum: 0xE72754B2
	Offset: 0x8AC0
	Size: 0xD6
	Parameters: 0
	Flags: None
*/
function debug_vehicle()
{
	/#
		self endon(#"death");
		if(getdvarstring(#"debug_vehicle_health") == "")
		{
			setdvar(#"debug_vehicle_health", 0);
		}
		while(true)
		{
			if(getdvarint(#"debug_vehicle_health", 0) > 0)
			{
				print3d(self.origin, "" + self.health, (1, 1, 1), 1, 3);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: debug_vehicle_paths
	Namespace: vehicle
	Checksum: 0x2341B5C6
	Offset: 0x8BA0
	Size: 0x15A
	Parameters: 0
	Flags: None
*/
function debug_vehicle_paths()
{
	/#
		self endon(#"death", #"newpath", #"endpath", #"reached_dynamic_path_end");
		while(true)
		{
			if(getdvarint(#"debug_vehicle_paths", 0) > 0)
			{
				recordline(self.origin, self.currentnode.origin, (1, 0, 0), "", self);
				recordline(self.origin, nextnode.origin, (0, 1, 0), "", self);
				recordline(self.currentnode.origin, nextnode.origin, (1, 1, 1), "", self);
			}
			waitframe(1);
			if(isdefined(self.nextnode) && self.nextnode != nextnode)
			{
				nextnode = self.nextnode;
			}
		}
	#/
}

/*
	Name: get_dummy
	Namespace: vehicle
	Checksum: 0x26640A0B
	Offset: 0x8D08
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function get_dummy()
{
	if(isdefined(self.modeldummyon) && self.modeldummyon)
	{
		emodel = self.modeldummy;
	}
	else
	{
		emodel = self;
	}
	return emodel;
}

/*
	Name: add_main_callback
	Namespace: vehicle
	Checksum: 0x96BD0ED0
	Offset: 0x8D50
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function add_main_callback(vehicletype, main)
{
	if(!isdefined(level.vehicle_main_callback))
	{
		level.vehicle_main_callback = [];
	}
	/#
		if(isdefined(level.vehicle_main_callback[vehicletype]))
		{
			println("" + vehicletype + "");
		}
	#/
	level.vehicle_main_callback[vehicletype] = main;
}

/*
	Name: vehicle_get_occupant_team
	Namespace: vehicle
	Checksum: 0x1DE71CB5
	Offset: 0x8DE8
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function vehicle_get_occupant_team()
{
	occupants = self getvehoccupants();
	if(occupants.size != 0)
	{
		occupant = occupants[0];
		if(isplayer(occupant))
		{
			return occupant.team;
		}
	}
	return self.team;
}

/*
	Name: toggle_exhaust_fx
	Namespace: vehicle
	Checksum: 0xC827D291
	Offset: 0x8E68
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function toggle_exhaust_fx(on)
{
	if(!on)
	{
		self clientfield::set("toggle_exhaustfx", 1);
	}
	else
	{
		self clientfield::set("toggle_exhaustfx", 0);
	}
}

/*
	Name: toggle_tread_fx
	Namespace: vehicle
	Checksum: 0x27DA24C4
	Offset: 0x8EC8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function toggle_tread_fx(on)
{
	if(on)
	{
		self clientfield::set("toggle_treadfx", 1);
	}
	else
	{
		self clientfield::set("toggle_treadfx", 0);
	}
}

/*
	Name: toggle_sounds
	Namespace: vehicle
	Checksum: 0xF36B5D99
	Offset: 0x8F28
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function toggle_sounds(on)
{
	if(!on)
	{
		self clientfield::set("toggle_sounds", 1);
	}
	else
	{
		self clientfield::set("toggle_sounds", 0);
	}
}

/*
	Name: function_bbc1d940
	Namespace: vehicle
	Checksum: 0x96B14711
	Offset: 0x8F88
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_bbc1d940(on)
{
	if(isdefined(self.emped) && self.emped || (isdefined(self.isjammed) && self.isjammed))
	{
		on = 0;
	}
	if(on)
	{
		self clientfield::set("toggle_horn_sound", 1);
	}
	else
	{
		self clientfield::set("toggle_horn_sound", 0);
	}
	self callback::callback(#"hash_6e388f6a0df7bdac", {#hash_d8ceeba3:on});
}

/*
	Name: function_c8effed1
	Namespace: vehicle
	Checksum: 0x1C8FB042
	Offset: 0x9058
	Size: 0x134
	Parameters: 1
	Flags: Event
*/
event function_c8effed1(eventstruct)
{
	if(isvehicle(eventstruct.vehicle))
	{
		if(!isdefined(eventstruct.vehicle.var_18a9fdc) || self [[eventstruct.vehicle.var_18a9fdc]](eventstruct.vehicle))
		{
			if(isdefined(eventstruct.vehicle.var_304cf9da) && eventstruct.vehicle.var_304cf9da)
			{
				if(eventstruct.vehicle clientfield::get("toggle_horn_sound"))
				{
					eventstruct.vehicle function_bbc1d940(0);
				}
				else
				{
					eventstruct.vehicle function_bbc1d940(1);
				}
			}
			else
			{
				eventstruct.vehicle function_bbc1d940(1);
			}
		}
	}
}

/*
	Name: function_7e40b597
	Namespace: vehicle
	Checksum: 0x18F45347
	Offset: 0x9198
	Size: 0x74
	Parameters: 1
	Flags: Event
*/
event function_7e40b597(eventstruct)
{
	if(isvehicle(eventstruct.vehicle))
	{
		if(!(isdefined(eventstruct.vehicle.var_304cf9da) && eventstruct.vehicle.var_304cf9da))
		{
			eventstruct.vehicle function_bbc1d940(0);
		}
	}
}

/*
	Name: function_5b65d9ec
	Namespace: vehicle
	Checksum: 0xAD678911
	Offset: 0x9218
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event function_5b65d9ec(eventstruct)
{
	callback::callback(#"veh_collision", eventstruct);
}

/*
	Name: function_fa4236af
	Namespace: vehicle
	Checksum: 0x7CC14C5
	Offset: 0x9250
	Size: 0x234
	Parameters: 1
	Flags: Linked
*/
function function_fa4236af(params)
{
	self endon(#"death", #"exit_vehicle");
	driver = self getseatoccupant(0);
	if(!isplayer(driver))
	{
		self toggle_sounds(1);
		return;
	}
	driver endon(#"death", #"disconnect");
	if(isdefined(self.var_42cfec27) && self.var_42cfec27 != "")
	{
		var_b0c85051 = soundgetplaybacktime(self.var_42cfec27) * 0.001;
		var_b0c85051 = var_b0c85051 - 0.5;
		if(var_b0c85051 > 0)
		{
			var_b0c85051 = math::clamp(var_b0c85051, 0.25, 1.5);
			self takeplayercontrol();
			self playsound(self.var_42cfec27);
			wait(var_b0c85051);
			if(!(isdefined(params.var_30a04b16) && params.var_30a04b16))
			{
				self returnplayercontrol();
			}
		}
	}
	self toggle_sounds(1);
	if(isdefined(params.var_32a85fa1))
	{
		self takeplayercontrol();
		wait(params.var_32a85fa1);
		if(!(isdefined(params.var_30a04b16) && params.var_30a04b16))
		{
			self returnplayercontrol();
		}
	}
}

/*
	Name: function_7f0bbde3
	Namespace: vehicle
	Checksum: 0xC873552A
	Offset: 0x9490
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_7f0bbde3()
{
	if(isdefined(self.var_ae271c0b) && self.var_ae271c0b != "")
	{
		self playsound(self.var_ae271c0b);
	}
}

/*
	Name: is_corpse
	Namespace: vehicle
	Checksum: 0x3E673711
	Offset: 0x94E0
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function is_corpse(veh)
{
	if(isdefined(veh))
	{
		if(isdefined(veh.isacorpse) && veh.isacorpse)
		{
			return 1;
		}
		if(isdefined(veh.classname) && veh.classname == "script_vehicle_corpse")
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: is_on
	Namespace: vehicle
	Checksum: 0xD47CC00C
	Offset: 0x9560
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function is_on(vehicle)
{
	if(!isdefined(self.viewlockedentity))
	{
		return 0;
	}
	if(self.viewlockedentity == vehicle)
	{
		return 1;
	}
	if(!isdefined(self.groundentity))
	{
		return 0;
	}
	if(self.groundentity == vehicle)
	{
		return 1;
	}
	return 0;
}

/*
	Name: add_spawn_function
	Namespace: vehicle
	Checksum: 0xAEB8B6CE
	Offset: 0x95D0
	Size: 0x64
	Parameters: 6
	Flags: None
*/
function add_spawn_function(veh_targetname, spawn_func, param1, param2, param3, param4)
{
	add_spawn_function_group(veh_targetname, "targetname", spawn_func, param1, param2, param3, param4);
}

/*
	Name: add_spawn_function_group
	Namespace: vehicle
	Checksum: 0xC5490CD4
	Offset: 0x9640
	Size: 0x25C
	Parameters: 7
	Flags: Linked
*/
function add_spawn_function_group(str_value, str_key, spawn_func, param1, param2, param3, param4)
{
	func = [];
	func[#"function"] = spawn_func;
	func[#"param1"] = param1;
	func[#"param2"] = param2;
	func[#"param3"] = param3;
	func[#"param4"] = param4;
	if(!isdefined(level.a_str_vehicle_spawn_custom_keys))
	{
		level.a_str_vehicle_spawn_custom_keys = [];
	}
	if(!isdefined(level.("a_str_vehicle_spawn_key_" + str_key)))
	{
		level.("a_str_vehicle_spawn_key_" + str_key) = [];
	}
	a_key_spawn_funcs = level.("a_str_vehicle_spawn_key_" + str_key);
	if(!isdefined(level.a_str_vehicle_spawn_custom_keys))
	{
		level.a_str_vehicle_spawn_custom_keys = [];
	}
	else if(!isarray(level.a_str_vehicle_spawn_custom_keys))
	{
		level.a_str_vehicle_spawn_custom_keys = array(level.a_str_vehicle_spawn_custom_keys);
	}
	if(!isinarray(level.a_str_vehicle_spawn_custom_keys, str_key))
	{
		level.a_str_vehicle_spawn_custom_keys[level.a_str_vehicle_spawn_custom_keys.size] = str_key;
	}
	if(!isdefined(a_key_spawn_funcs[str_value]))
	{
		a_key_spawn_funcs[str_value] = [];
	}
	else if(!isarray(a_key_spawn_funcs[str_value]))
	{
		a_key_spawn_funcs[str_value] = array(a_key_spawn_funcs[str_value]);
	}
	a_key_spawn_funcs[str_value][a_key_spawn_funcs[str_value].size] = func;
}

/*
	Name: add_spawn_function_by_type
	Namespace: vehicle
	Checksum: 0xC4C84647
	Offset: 0x98A8
	Size: 0x64
	Parameters: 6
	Flags: None
*/
function add_spawn_function_by_type(veh_type, spawn_func, param1, param2, param3, param4)
{
	add_spawn_function_group(veh_type, "vehicletype", spawn_func, param1, param2, param3, param4);
}

/*
	Name: add_hijack_function
	Namespace: vehicle
	Checksum: 0xD8BE50C4
	Offset: 0x9918
	Size: 0x180
	Parameters: 6
	Flags: None
*/
function add_hijack_function(veh_targetname, spawn_func, param1, param2, param3, param4)
{
	func = [];
	func[#"function"] = spawn_func;
	func[#"param1"] = param1;
	func[#"param2"] = param2;
	func[#"param3"] = param3;
	func[#"param4"] = param4;
	if(!isdefined(level.a_vehicle_hijack_targetnames))
	{
		level.a_vehicle_hijack_targetnames = [];
	}
	if(!isdefined(level.a_vehicle_hijack_targetnames[veh_targetname]))
	{
		level.a_vehicle_hijack_targetnames[veh_targetname] = [];
	}
	else if(!isarray(level.a_vehicle_hijack_targetnames[veh_targetname]))
	{
		level.a_vehicle_hijack_targetnames[veh_targetname] = array(level.a_vehicle_hijack_targetnames[veh_targetname]);
	}
	level.a_vehicle_hijack_targetnames[veh_targetname][level.a_vehicle_hijack_targetnames[veh_targetname].size] = func;
}

/*
	Name: _watch_for_hijacked_vehicles
	Namespace: vehicle
	Checksum: 0x5A458F1A
	Offset: 0x9AA0
	Size: 0x164
	Parameters: 0
	Flags: Linked, Private
*/
private function _watch_for_hijacked_vehicles()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"clonedentity");
		str_targetname = waitresult.clone.targetname;
		waittillframeend();
		if(isdefined(str_targetname) && isdefined(level.a_vehicle_hijack_targetnames) && isdefined(level.a_vehicle_hijack_targetnames[str_targetname]))
		{
			foreach(func in level.a_vehicle_hijack_targetnames[str_targetname])
			{
				util::single_thread(waitresult.clone, func[#"function"], func[#"param1"], func[#"param2"], func[#"param3"], func[#"param4"]);
			}
		}
	}
}

/*
	Name: disconnect_paths
	Namespace: vehicle
	Checksum: 0x16855A15
	Offset: 0x9C10
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function disconnect_paths(detail_level = 2, move_allowed = 1)
{
	self disconnectpaths(detail_level, move_allowed);
	self enableobstacle(0);
}

/*
	Name: connect_paths
	Namespace: vehicle
	Checksum: 0x69201D11
	Offset: 0x9C80
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function connect_paths()
{
	self connectpaths();
	self enableobstacle(1);
}

/*
	Name: init_target_group
	Namespace: vehicle
	Checksum: 0x5EC6EF7B
	Offset: 0x9CC0
	Size: 0xE
	Parameters: 0
	Flags: None
*/
function init_target_group()
{
	self.target_group = [];
}

/*
	Name: add_to_target_group
	Namespace: vehicle
	Checksum: 0x27198B77
	Offset: 0x9CD8
	Size: 0x9E
	Parameters: 1
	Flags: None
*/
function add_to_target_group(target_ent)
{
	/#
		assert(isdefined(self.target_group), "");
	#/
	if(!isdefined(self.target_group))
	{
		self.target_group = [];
	}
	else if(!isarray(self.target_group))
	{
		self.target_group = array(self.target_group);
	}
	self.target_group[self.target_group.size] = target_ent;
}

/*
	Name: remove_from_target_group
	Namespace: vehicle
	Checksum: 0xE40DD3
	Offset: 0x9D80
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function remove_from_target_group(target_ent)
{
	/#
		assert(isdefined(self.target_group), "");
	#/
	arrayremovevalue(self.target_group, target_ent);
}

/*
	Name: monitor_missiles_locked_on_to_me
	Namespace: vehicle
	Checksum: 0x884E4534
	Offset: 0x9DD8
	Size: 0xF6
	Parameters: 2
	Flags: None
*/
function monitor_missiles_locked_on_to_me(player, wait_time = 0.1)
{
	monitored_entity = self;
	monitored_entity endon(#"death");
	/#
		assert(isdefined(monitored_entity.target_group), "");
	#/
	player endon(#"stop_monitor_missile_locked_on_to_me", #"disconnect", #"joined_team");
	while(true)
	{
		closest_attacker = player get_closest_attacker_with_missile_locked_on_to_me(monitored_entity);
		player setvehiclelockedonbyent(closest_attacker);
		wait(wait_time);
	}
}

/*
	Name: watch_freeze_on_flash
	Namespace: vehicle
	Checksum: 0xA677E0A5
	Offset: 0x9ED8
	Size: 0x492
	Parameters: 1
	Flags: None
*/
function watch_freeze_on_flash(duration)
{
	veh = self;
	if(veh flag::exists("watch_freeze_on_flash"))
	{
		return;
	}
	veh flag::init("watch_freeze_on_flash", 1);
	if(isdefined(veh.owner))
	{
		veh.owner clientfield::set_to_player("static_postfx", 0);
	}
	veh clientfield::set("stun", 0);
	while(true)
	{
		waitresult = undefined;
		waitresult = veh waittill(#"damage", #"death");
		if(waitresult._notify == "death")
		{
			return;
		}
		weapon = waitresult.weapon;
		mod = waitresult.mod;
		owner = veh.owner;
		controlled = isdefined(veh.controlled) && veh.controlled;
		if(!(isdefined(veh.isstunned) && veh.isstunned))
		{
			if(weapon.dostun && mod == "MOD_GRENADE_SPLASH")
			{
				veh.isstunned = 1;
				veh.noshoot = 1;
				veh notify(#"fire_stop");
				veh cancelaimove();
				if(issentient(veh))
				{
					veh clearentitytarget();
				}
				veh function_d4c687c9();
				veh vehclearlookat();
				veh disablegunnerfiring(0, 1);
				angles = veh function_bc2f1cb8(0);
				veh turretsettargetangles(0, angles + vectorscale((1, 0, 0), 50));
				if(controlled && isdefined(owner))
				{
					owner val::set(#"veh", "freezecontrols", 1);
					owner clientfield::set_to_player("static_postfx", 1);
				}
				veh clientfield::set("stun", 1);
				waitresult = undefined;
				waitresult = veh waittill_timeout(duration, #"death");
				if(controlled && isdefined(owner))
				{
					owner clientfield::set_to_player("static_postfx", 0);
					owner val::reset(#"veh", "freezecontrols");
				}
				if(!isdefined(veh))
				{
					return;
				}
				veh clientfield::set("stun", 0);
				isalive = isalive(veh);
				if(isalive)
				{
					veh turretcleartarget(0);
					veh disablegunnerfiring(0, 0);
					veh.noshoot = undefined;
					veh.isstunned = undefined;
				}
				if(waitresult._notify == "death")
				{
					return;
				}
			}
		}
	}
}

/*
	Name: stop_monitor_missiles_locked_on_to_me
	Namespace: vehicle
	Checksum: 0x4C54D21F
	Offset: 0xA378
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function stop_monitor_missiles_locked_on_to_me()
{
	self notify(#"stop_monitor_missile_locked_on_to_me");
}

/*
	Name: get_closest_attacker_with_missile_locked_on_to_me
	Namespace: vehicle
	Checksum: 0x9872E9A7
	Offset: 0xA398
	Size: 0x268
	Parameters: 1
	Flags: Linked
*/
function get_closest_attacker_with_missile_locked_on_to_me(monitored_entity)
{
	/#
		assert(isdefined(monitored_entity.target_group), "");
	#/
	player = self;
	closest_attacker = undefined;
	closest_attacker_dot = -999;
	view_origin = player getplayercamerapos();
	view_forward = anglestoforward(player getplayerangles());
	remaining_locked_on_flags = 0;
	foreach(target_ent in monitored_entity.target_group)
	{
		if(isdefined(target_ent) && isdefined(target_ent.locked_on))
		{
			remaining_locked_on_flags = remaining_locked_on_flags | target_ent.locked_on;
		}
	}
	for(i = 0; remaining_locked_on_flags && i < level.players.size; i++)
	{
		attacker = level.players[i];
		if(isdefined(attacker))
		{
			client_flag = 1 << attacker getentitynumber();
			if(client_flag & remaining_locked_on_flags)
			{
				to_attacker = vectornormalize(attacker.origin - view_origin);
				attacker_dot = vectordot(view_forward, to_attacker);
				if(attacker_dot > closest_attacker_dot)
				{
					closest_attacker = attacker;
					closest_attacker_dot = attacker_dot;
				}
				~closest_attacker_dot;
				remaining_locked_on_flags = remaining_locked_on_flags & client_flag;
			}
		}
	}
	return closest_attacker;
}

/*
	Name: set_vehicle_drivable_time_starting_now
	Namespace: vehicle
	Checksum: 0x3A1F9A38
	Offset: 0xA608
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function set_vehicle_drivable_time_starting_now(duration_ms)
{
	end_time_ms = gettime() + duration_ms;
	set_vehicle_drivable_time(duration_ms, end_time_ms);
	return end_time_ms;
}

/*
	Name: set_vehicle_drivable_time
	Namespace: vehicle
	Checksum: 0xFA7746C2
	Offset: 0xA650
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function set_vehicle_drivable_time(duration_ms, end_time_ms)
{
	self setvehicledrivableduration(duration_ms);
	self setvehicledrivableendtime(end_time_ms);
}

/*
	Name: update_damage_as_occupant
	Namespace: vehicle
	Checksum: 0x8E03C499
	Offset: 0xA6A0
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function update_damage_as_occupant(damage_taken, max_health)
{
	damage_taken_normalized = math::clamp(damage_taken / max_health, 0, 1);
	self setvehicledamagemeter(damage_taken_normalized);
}

/*
	Name: stop_monitor_damage_as_occupant
	Namespace: vehicle
	Checksum: 0x72A18BF0
	Offset: 0xA710
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function stop_monitor_damage_as_occupant()
{
	self notify(#"stop_monitor_damage_as_occupant");
}

/*
	Name: monitor_damage_as_occupant
	Namespace: vehicle
	Checksum: 0x1F20AA63
	Offset: 0xA730
	Size: 0x100
	Parameters: 1
	Flags: None
*/
function monitor_damage_as_occupant(player)
{
	player notify(#"stop_monitor_damage_as_occupant");
	player endon(#"stop_monitor_damage_as_occupant", #"disconnect");
	self endon(#"death");
	if(!isdefined(self.maxhealth))
	{
		self.maxhealth = self.healthdefault;
	}
	wait(0.1);
	player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
	while(true)
	{
		self waittill(#"damage");
		waittillframeend();
		player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
	}
}

/*
	Name: kill_vehicle
	Namespace: vehicle
	Checksum: 0x69B66D0F
	Offset: 0xA838
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function kill_vehicle(var_dbd1a594, weapon = level.weaponnone)
{
	damageorigin = self.origin + (0, 0, 1);
	self finishvehicleradiusdamage(var_dbd1a594, var_dbd1a594, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", weapon, damageorigin, 400, -1, (0, 0, 1), 0);
}

/*
	Name: function_eb183ffe
	Namespace: vehicle
	Checksum: 0xA685E3B3
	Offset: 0xA8D0
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function function_eb183ffe(var_dbd1a594, weapon)
{
	kill_vehicle(var_dbd1a594, weapon);
}

/*
	Name: player_is_driver
	Namespace: vehicle
	Checksum: 0x22496458
	Offset: 0xA908
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function player_is_driver()
{
	if(!isalive(self))
	{
		return 0;
	}
	vehicle = self getvehicleoccupied();
	if(isdefined(vehicle))
	{
		seat = vehicle getoccupantseat(self);
		if(isdefined(seat) && seat == 0)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: laser_death_watcher
	Namespace: vehicle
	Checksum: 0xDB4C2893
	Offset: 0xA998
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function laser_death_watcher()
{
	self notify(#"laser_death_thread_stop");
	self endon(#"laser_death_thread_stop");
	self waittill(#"death");
	if(isdefined(self))
	{
		self laseroff();
	}
}

/*
	Name: enable_laser
	Namespace: vehicle
	Checksum: 0x268DB553
	Offset: 0xA9F8
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function enable_laser(b_enable, n_index)
{
	if(b_enable)
	{
		self laseron();
		self thread laser_death_watcher();
	}
	else
	{
		self laseroff();
		self notify(#"laser_death_thread_stop");
	}
}

/*
	Name: vehicle_spawner_tool
	Namespace: vehicle
	Checksum: 0x378BE86B
	Offset: 0xAA78
	Size: 0x436
	Parameters: 0
	Flags: None
*/
function vehicle_spawner_tool()
{
	/#
		var_b75d0d00 = function_951b4205();
		if(var_b75d0d00.size == 0)
		{
			return;
		}
		while(true)
		{
			if(getdvarint(#"debug_vehicle_spawn", 0) > 0)
			{
				player = getplayers()[0];
				dynamic_spawn_hud = newdebughudelem(player);
				dynamic_spawn_hud.alignx = "";
				dynamic_spawn_hud.x = 20;
				dynamic_spawn_hud.y = 395;
				dynamic_spawn_hud.fontscale = 1;
				dynamic_spawn_dummy_model = sys::spawn("", (0, 0, 0));
				while(getdvarint(#"debug_vehicle_spawn", 0) > 0)
				{
					origin = player.origin + anglestoforward(player getplayerangles()) * 270;
					origin = origin + vectorscale((0, 0, 1), 40);
					if(player usebuttonpressed())
					{
						dynamic_spawn_dummy_model hide();
						vehicle = spawnvehicle(var_b75d0d00[type_index].name, origin, player.angles, "");
						vehicle makevehicleusable();
						if(getdvarint(#"debug_vehicle_spawn", 0) == 1)
						{
							setdvar(#"debug_vehicle_spawn", 0);
							continue;
						}
						wait(0.3);
					}
					if(player buttonpressed(""))
					{
						dynamic_spawn_dummy_model hide();
						type_index++;
						if(type_index >= var_b75d0d00.size)
						{
							type_index = 0;
						}
						wait(0.3);
					}
					if(player buttonpressed(""))
					{
						dynamic_spawn_dummy_model hide();
						type_index--;
						if(type_index < 0)
						{
							type_index = var_b75d0d00.size - 1;
						}
						wait(0.3);
					}
					dynamic_spawn_hud settext("" + function_9e72a96(var_b75d0d00[type_index].name));
					dynamic_spawn_dummy_model setmodel(var_b75d0d00[type_index].model);
					dynamic_spawn_dummy_model show();
					dynamic_spawn_dummy_model notsolid();
					dynamic_spawn_dummy_model.origin = origin;
					dynamic_spawn_dummy_model.angles = player.angles;
					waitframe(1);
				}
				dynamic_spawn_hud destroy();
				dynamic_spawn_dummy_model delete();
			}
			wait(2);
		}
	#/
}

/*
	Name: spline_debug
	Namespace: vehicle
	Checksum: 0x1A5D806B
	Offset: 0xAEB8
	Size: 0xA6
	Parameters: 0
	Flags: None
*/
function spline_debug()
{
	/#
		level flag::init("");
		level thread _spline_debug();
		while(true)
		{
			if(flag::exists(""))
			{
				level flag::set_val("", getdvarint(#"g_vehicledrawsplines", 0));
			}
			waitframe(1);
		}
	#/
}

/*
	Name: _spline_debug
	Namespace: vehicle
	Checksum: 0xC7FB1957
	Offset: 0xAF68
	Size: 0xB2
	Parameters: 0
	Flags: None
*/
function _spline_debug()
{
	/#
		while(true)
		{
			level flag::wait_till("");
			foreach(nd in getallvehiclenodes())
			{
				nd show_node_debug_info();
			}
			waitframe(1);
		}
	#/
}

/*
	Name: show_node_debug_info
	Namespace: vehicle
	Checksum: 0xDDA9C700
	Offset: 0xB028
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function show_node_debug_info()
{
	/#
		self.n_debug_display_count = 0;
		if(is_unload_node())
		{
			print_debug_info("" + self.script_unload + "");
		}
		if(isdefined(self.script_notify))
		{
			print_debug_info("" + self.script_notify + "");
		}
		if(isdefined(self.script_delete) && self.script_delete)
		{
			print_debug_info("");
		}
	#/
}

/*
	Name: print_debug_info
	Namespace: vehicle
	Checksum: 0x76365F44
	Offset: 0xB0F0
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function print_debug_info(str_info)
{
	/#
		self.n_debug_display_count++;
		print3d(self.origin - (0, 0, self.n_debug_display_count * 20), str_info, (0, 0, 1), 1, 1);
	#/
}

/*
	Name: function_96b5f1c3
	Namespace: vehicle
	Checksum: 0xC5857DAD
	Offset: 0xB158
	Size: 0xFA
	Parameters: 2
	Flags: None
*/
function function_96b5f1c3(vh_target, n_seat)
{
	if(isbot(self) && (isdefined(vh_target.var_3a60b519) && vh_target.var_3a60b519))
	{
		return 0;
	}
	if(isdefined(vh_target) && isalive(self) && !self laststand::player_is_in_laststand() && (isdefined(vh_target function_dcef0ba1(n_seat)) && vh_target function_dcef0ba1(n_seat)) && !vh_target isvehicleseatoccupied(n_seat))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_bbd487c2
	Namespace: vehicle
	Checksum: 0x7F08A42D
	Offset: 0xB260
	Size: 0x114
	Parameters: 0
	Flags: Private
*/
private function function_bbd487c2()
{
	e_player = self.owner;
	if(!isdefined(e_player))
	{
		self thread util::auto_delete();
		return;
	}
	self endon(#"death", #"enter_vehicle");
	e_player endon(#"disconnect");
	level endon(#"game_ended");
	while(!b_do_delete)
	{
		wait(5);
		dist = distance2d(self.origin, e_player.origin);
		if(isalive(e_player) && dist > 3000)
		{
			b_do_delete = 1;
		}
	}
	self thread util::auto_delete();
}

/*
	Name: function_93844822
	Namespace: vehicle
	Checksum: 0xD70DE1EF
	Offset: 0xB380
	Size: 0x5EC
	Parameters: 3
	Flags: None
*/
function function_93844822(e_player, b_skip_scene, var_df8e0f5d = 1)
{
	var_40a72df6 = "";
	if(!var_df8e0f5d)
	{
		s_info = self function_831cd622(e_player);
	}
	if(!b_skip_scene)
	{
		if(var_df8e0f5d)
		{
			debug_scene = getdvarstring(#"hash_56b164d8150f9e8d", "");
			if(debug_scene != "")
			{
				str_scene = debug_scene;
			}
			else if(isdefined(self.var_e31ecd10))
			{
				str_scene = self.var_e31ecd10;
			}
			else if(isdefined(self.settings) && isdefined(self.settings.var_fbbdbf11))
			{
				str_scene = self.settings.var_fbbdbf11;
				if(!isdefined(e_player.companion))
				{
					var_3966de80 = str_scene;
					var_3966de80 = var_3966de80 + "_solo";
					scene = getscriptbundle(var_3966de80);
					if(isdefined(scene))
					{
						str_scene = var_3966de80;
					}
				}
				var_9d0b2a04 = vectordot(anglestoright(self.angles), vectornormalize(self.origin - e_player.origin));
				if(var_9d0b2a04 > 0)
				{
					var_664b49b8 = "left";
				}
				else
				{
					var_664b49b8 = "right";
				}
				str_shot = var_664b49b8 + var_40a72df6;
			}
		}
		else
		{
			debug_scene = getdvarstring(#"hash_56b164d8150f9e8d", "");
			if(debug_scene != "")
			{
				str_scene = debug_scene;
			}
			else if(isdefined(self.var_a5fbf4c5))
			{
				str_scene = self.var_a5fbf4c5;
			}
			else if(isdefined(self.settings) && isdefined(self.settings.var_ffbed7fd))
			{
				str_scene = self.settings.var_ffbed7fd;
				if(!isdefined(e_player.companion))
				{
					var_3966de80 = str_scene;
					var_3966de80 = var_3966de80 + "_solo";
					scene = getscriptbundle(var_3966de80);
					if(isdefined(scene))
					{
						str_scene = var_3966de80;
					}
				}
				var_664b49b8 = s_info.var_664b49b8;
				str_shot = var_664b49b8 + var_40a72df6;
			}
		}
		if(isdefined(str_scene) && str_scene != "")
		{
			if(isdefined(e_player.companion) && e_player.companion isplayinganimscripted())
			{
				e_player.companion stopanimscripted();
				util::wait_network_frame();
			}
			self notify(#"hash_376d57a458a131df");
			a_ents = array(e_player);
			if(isalive(e_player.companion) && scene::function_d1dd6e60(str_scene) > 0)
			{
				if(!isdefined(a_ents))
				{
					a_ents = [];
				}
				else if(!isarray(a_ents))
				{
					a_ents = array(a_ents);
				}
				a_ents[a_ents.size] = e_player.companion;
			}
			if(scene::get_vehicle_count(str_scene) > 0)
			{
				if(!isdefined(a_ents))
				{
					a_ents = [];
				}
				else if(!isarray(a_ents))
				{
					a_ents = array(a_ents);
				}
				a_ents[a_ents.size] = self;
			}
			if(isdefined(str_shot))
			{
				self thread scene::play(str_scene, str_shot, a_ents);
			}
			else
			{
				self thread scene::play(str_scene, a_ents);
			}
			e_player flagsys::wait_till_clear("scene");
			self notify(#"vehicle_scene_done");
		}
		if(!var_df8e0f5d)
		{
			if(isdefined(s_info.v_teleport_pos))
			{
				e_player setorigin(s_info.v_teleport_pos);
			}
			if(isdefined(s_info.v_teleport_angles))
			{
				e_player setplayerangles(s_info.v_teleport_angles);
			}
			if(isdefined(s_info.var_ad3d636d))
			{
				e_player.companion setorigin(s_info.var_ad3d636d);
			}
		}
	}
}

/*
	Name: function_831cd622
	Namespace: vehicle
	Checksum: 0x2F3DAB6F
	Offset: 0xB978
	Size: 0x426
	Parameters: 1
	Flags: Linked, Private
*/
private function function_831cd622(e_player)
{
	s_info = {};
	v_movement = e_player getnormalizedmovement();
	if(self.archetype === #"hash_5cb98c18fee01b3a")
	{
		var_d526c0e4 = self.origin + anglestoright(self.angles) * 115;
		var_c1af71a1 = self.origin + anglestoright(self.angles) * -125;
		var_b44997b4 = self.origin + anglestoforward(self.angles) * -110;
		if(v_movement[1] < 0 && ispointonnavmesh(var_c1af71a1) && bullettracepassed(self.origin + vectorscale((0, 0, 1), 75), var_c1af71a1 + vectorscale((0, 0, 1), 5), 1, self))
		{
			s_info.var_664b49b8 = "left";
		}
		else if(ispointonnavmesh(var_d526c0e4) && bullettracepassed(self.origin + vectorscale((0, 0, 1), 75), var_d526c0e4 + vectorscale((0, 0, 1), 5), 1, self))
		{
			s_info.var_664b49b8 = "right";
		}
		else
		{
			s_info.var_664b49b8 = "left";
			s_info.v_teleport_pos = getclosestpointonnavmesh(self.origin, 256, 16);
		}
		if(!ispointonnavmesh(var_b44997b4) || !bullettracepassed(self.origin + vectorscale((0, 0, 1), 75), var_b44997b4 + vectorscale((0, 0, 1), 75), 1, self))
		{
			s_info.var_ad3d636d = getclosestpointonnavmesh(self.origin, 256, 16);
		}
	}
	else if(self.archetype === #"quad")
	{
		var_d526c0e4 = self.origin + anglestoright(self.angles) * 85;
		var_c1af71a1 = self.origin + anglestoright(self.angles) * -85;
		if(v_movement[1] < 0 && ispointonnavmesh(var_c1af71a1))
		{
			s_info.var_664b49b8 = "left";
			s_info.v_teleport_pos = getclosestpointonnavmesh(var_c1af71a1, 256, 16);
		}
		else
		{
			s_info.var_664b49b8 = "right";
			s_info.v_teleport_pos = getclosestpointonnavmesh(var_d526c0e4, 256, 16);
		}
		s_info.v_teleport_angles = (0, self.angles[1], 0);
	}
	else if(v_movement[1] < 0)
	{
		s_info.var_664b49b8 = "left";
	}
	else
	{
		s_info.var_664b49b8 = "right";
	}
	return s_info;
}

/*
	Name: function_19bd94a1
	Namespace: vehicle
	Checksum: 0xAFD8D98E
	Offset: 0xBDA8
	Size: 0x196
	Parameters: 2
	Flags: None
*/
function function_19bd94a1(var_3051fdcd, var_eb0c57db = 0)
{
	level endon(#"game_ended");
	a_vehicles = self;
	if(!isarray(a_vehicles))
	{
		if(!isdefined(a_vehicles))
		{
			a_vehicles = [];
		}
		else if(!isarray(a_vehicles))
		{
			a_vehicles = array(a_vehicles);
		}
	}
	foreach(vh in a_vehicles)
	{
		vh.var_e31ecd10 = var_3051fdcd;
	}
	if(var_eb0c57db)
	{
		array::wait_till(a_vehicles, "vehicle_scene_done");
		foreach(vh in a_vehicles)
		{
			if(isdefined(vh))
			{
				vh.var_e31ecd10 = undefined;
			}
		}
	}
}

/*
	Name: function_1e82f829
	Namespace: vehicle
	Checksum: 0xDF6B9FDC
	Offset: 0xBF48
	Size: 0x196
	Parameters: 2
	Flags: None
*/
function function_1e82f829(var_35304872, var_eb0c57db = 0)
{
	level endon(#"game_ended");
	a_vehicles = self;
	if(!isarray(a_vehicles))
	{
		if(!isdefined(a_vehicles))
		{
			a_vehicles = [];
		}
		else if(!isarray(a_vehicles))
		{
			a_vehicles = array(a_vehicles);
		}
	}
	foreach(vh in a_vehicles)
	{
		vh.var_a5fbf4c5 = var_35304872;
	}
	if(var_eb0c57db)
	{
		array::wait_any(a_vehicles, "vehicle_scene_done");
		foreach(vh in a_vehicles)
		{
			if(isdefined(vh))
			{
				vh.var_a5fbf4c5 = undefined;
			}
		}
	}
}

/*
	Name: function_ca9b286c
	Namespace: vehicle
	Checksum: 0x25852CEE
	Offset: 0xC0E8
	Size: 0x2F4
	Parameters: 1
	Flags: Event
*/
event function_ca9b286c(eventstruct)
{
	if(isvehicle(eventstruct.vehicle))
	{
		if(!isdefined(eventstruct.seat_index))
		{
			return;
		}
		var_fd110a27 = eventstruct.vehicle function_a3f90231(eventstruct.seat_index);
		if(!isdefined(var_fd110a27))
		{
			return;
		}
		var_8730ee3e = getscriptbundle(var_fd110a27);
		if(isdefined(var_8730ee3e))
		{
			if(isdefined(var_8730ee3e.var_b99b6e3c) && var_8730ee3e.var_b99b6e3c)
			{
				if(!isdefined(eventstruct.vehicle.var_26fb6644))
				{
					eventstruct.vehicle.var_26fb6644 = [];
				}
				if(isdefined(eventstruct.vehicle.var_26fb6644[eventstruct.seat_index]) && eventstruct.vehicle.var_26fb6644[eventstruct.seat_index])
				{
					return;
				}
				eventstruct.vehicle.var_26fb6644[eventstruct.seat_index] = 1;
			}
			rightvecdot = vectordot(anglestoright(eventstruct.vehicle.angles), vectornormalize(self.origin - eventstruct.vehicle.origin));
			if(rightvecdot > 0)
			{
				animation = var_8730ee3e.var_9b47c071;
			}
			else
			{
				animation = var_8730ee3e.var_9323d5c1;
			}
			if(isdefined(animation))
			{
				self animscripted("vehicle_enter_anim", eventstruct.vehicle function_5051cc0c(eventstruct.seat_index), eventstruct.vehicle function_90d45d34(eventstruct.seat_index), animation, "server script", undefined, 1, undefined, undefined, undefined, 1);
			}
			vehicleanim = var_8730ee3e.vehicleenteranim;
			if(isdefined(vehicleanim))
			{
				eventstruct.vehicle setanimknobrestart(vehicleanim, 1, 0, 1);
			}
		}
	}
}

/*
	Name: function_124469f4
	Namespace: vehicle
	Checksum: 0xD767AF70
	Offset: 0xC3E8
	Size: 0x314
	Parameters: 1
	Flags: Event
*/
event function_124469f4(eventstruct)
{
	if(isvehicle(eventstruct.vehicle))
	{
		if(!isdefined(eventstruct.seat_index))
		{
			return;
		}
		var_fd110a27 = eventstruct.vehicle function_a3f90231(eventstruct.seat_index);
		if(!isdefined(var_fd110a27))
		{
			return;
		}
		var_8730ee3e = getscriptbundle(var_fd110a27);
		if(isdefined(var_8730ee3e))
		{
			if(!(isdefined(var_8730ee3e.var_8d496bb1) && var_8730ee3e.var_8d496bb1))
			{
				return;
			}
			if(isdefined(var_8730ee3e.var_b99b6e3c) && var_8730ee3e.var_b99b6e3c)
			{
				if(!isdefined(eventstruct.vehicle.var_26fb6644))
				{
					eventstruct.vehicle.var_26fb6644 = [];
				}
				if(isdefined(eventstruct.vehicle.var_26fb6644[eventstruct.seat_index]) && eventstruct.vehicle.var_26fb6644[eventstruct.seat_index])
				{
					return;
				}
				eventstruct.vehicle.var_26fb6644[eventstruct.seat_index] = 1;
			}
			rightvecdot = vectordot(anglestoright(eventstruct.vehicle.angles), vectornormalize(self.origin - eventstruct.vehicle.origin));
			if(rightvecdot > 0)
			{
				animation = var_8730ee3e.var_9b47c071;
			}
			else
			{
				animation = var_8730ee3e.var_9323d5c1;
			}
			if(isdefined(animation))
			{
				self animscripted("vehicle_enter_anim", eventstruct.vehicle function_5051cc0c(eventstruct.seat_index), eventstruct.vehicle function_90d45d34(eventstruct.seat_index), animation, "server script", undefined, 1, undefined, undefined, undefined, 1);
			}
			vehicleanim = var_8730ee3e.vehicleenteranim;
			if(isdefined(vehicleanim))
			{
				eventstruct.vehicle setanimknobrestart(vehicleanim, 1, 0, 1);
			}
		}
	}
}

/*
	Name: function_fa8ced6e
	Namespace: vehicle
	Checksum: 0xC5545F6D
	Offset: 0xC708
	Size: 0xD0
	Parameters: 3
	Flags: None
*/
function function_fa8ced6e(v_origin, v_angles, str_vehicle = undefined)
{
	if(self isinvehicle())
	{
		return self getvehicleoccupied();
	}
	/#
		/#
			assert(isdefined(str_vehicle), "");
		#/
	#/
	var_80730518 = spawnvehicle(str_vehicle, v_origin, v_angles, "player_spawned_vehicle");
	var_80730518 usevehicle(self, 0);
	return var_80730518;
}

/*
	Name: function_715433be
	Namespace: vehicle
	Checksum: 0xB1634C1F
	Offset: 0xC7E0
	Size: 0x84
	Parameters: 3
	Flags: None
*/
function function_715433be(vehicle, bot, n_seat)
{
	if(isbot(bot) && n_seat == 0)
	{
		if(vehicle vehicle_ai::has_state("off"))
		{
			vehicle vehicle_ai::set_state("off");
		}
	}
}

/*
	Name: function_a29610b6
	Namespace: vehicle
	Checksum: 0xB8CBBCEA
	Offset: 0xC870
	Size: 0xF4
	Parameters: 2
	Flags: None
*/
function function_a29610b6(x, k)
{
	if(x < -1)
	{
		x = -1;
	}
	else if(x > 1)
	{
		x = 1;
	}
	if(k < -1)
	{
		k = -1;
	}
	else if(k > 1)
	{
		k = 1;
	}
	numerator = x - x * k;
	denominator = k - abs(x) * 2 * k + 1;
	result = numerator / denominator;
	return result;
}

/*
	Name: update_flare_ability
	Namespace: vehicle
	Checksum: 0xAADD7A46
	Offset: 0xC970
	Size: 0x306
	Parameters: 5
	Flags: None
*/
function update_flare_ability(player, var_55716d54, active_time = 5, cooldown_time = 10, var_f69e2d1 = undefined)
{
	var_a86d6798 = "update_flare_ability";
	self notify(var_a86d6798);
	self endon(#"death", var_a86d6798);
	var_bca5c6c1 = active_time;
	flarecooldown = cooldown_time;
	if(!self flag::exists("flares_available"))
	{
		self flag::init("flares_available", 1);
	}
	else
	{
		self flag::set("flares_available");
	}
	player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", 1);
	while(isdefined(player.vh_vehicle) && player function_e01d381a())
	{
		waitframe(1);
	}
	while(isdefined(player) && (isdefined(player.vh_vehicle) || self.var_40d7d1f2))
	{
		/#
			assert(!(isdefined(self.var_40d7d1f2) && self.var_40d7d1f2));
		#/
		if(player function_e01d381a())
		{
			self flag::clear("flares_available");
			self.var_40d7d1f2 = 1;
			player playsoundtoplayer(#"hash_35af2f72517d10ab", player);
			self function_d42bfb21(player, var_f69e2d1, active_time);
			player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", 0);
			wait(var_bca5c6c1);
			self.var_40d7d1f2 = 0;
			level thread function_1bb979ca(flarecooldown, player, var_55716d54);
			player playsoundtoplayer(#"hash_62742dd7b6e513e", player);
			self flag::set("flares_available");
		}
		waitframe(1);
	}
}

/*
	Name: function_8aab5d53
	Namespace: vehicle
	Checksum: 0xF7DAB243
	Offset: 0xCC80
	Size: 0x140
	Parameters: 2
	Flags: None
*/
function function_8aab5d53(player, var_55716d54)
{
	self endon(#"death");
	player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", 0);
	while(isdefined(player) && isdefined(player.vh_vehicle))
	{
		var_42775dfe = 0;
		if(player function_b835102b())
		{
			var_42775dfe = player function_dd63190a();
		}
		else
		{
			var_759ec838 = player getvehicleboosttime();
			var_93237569 = player getvehicleboosttimeleft();
			if(var_759ec838 > 0)
			{
				var_42775dfe = var_93237569 / var_759ec838;
			}
		}
		player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", var_42775dfe);
		wait(0.05);
	}
}

/*
	Name: function_1eab63e3
	Namespace: vehicle
	Checksum: 0xCAEB0715
	Offset: 0xCDC8
	Size: 0x16A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1eab63e3(flare_lifetime = 3)
{
	var_d8ba54e6 = [];
	for(var_b2814b11 = 0; var_b2814b11 < 4; var_b2814b11++)
	{
		if(!isdefined(var_d8ba54e6))
		{
			var_d8ba54e6 = [];
		}
		else if(!isarray(var_d8ba54e6))
		{
			var_d8ba54e6 = array(var_d8ba54e6);
		}
		var_d8ba54e6[var_d8ba54e6.size] = flare_lifetime - var_b2814b11 * 0.3;
	}
	var_d8ba54e6 = array::randomize(var_d8ba54e6);
	foreach(key, value in var_d8ba54e6)
	{
		if(value == flare_lifetime)
		{
			var_d8ba54e6[key] = var_d8ba54e6[key] + key * 0.15;
		}
	}
	return var_d8ba54e6;
}

/*
	Name: function_d42bfb21
	Namespace: vehicle
	Checksum: 0xCB0C0ADD
	Offset: 0xCF40
	Size: 0x266
	Parameters: 3
	Flags: Linked
*/
function function_d42bfb21(player, var_f69e2d1 = undefined, flare_lifetime = undefined)
{
	var_f9a2afb9 = function_1eab63e3(flare_lifetime);
	for(var_558d81a6 = 0; var_558d81a6 < 4; var_558d81a6++)
	{
		model = "tag_origin";
		if(!isdefined(var_f69e2d1))
		{
			self.var_70eddc3b = !(isdefined(self.var_70eddc3b) && self.var_70eddc3b);
			var_da3d244a = (self.var_70eddc3b ? "tag_fx_flare_left" : "tag_fx_flare_right");
			start_origin = self gettagorigin(var_da3d244a);
		}
		else
		{
			start_origin = self gettagorigin(var_f69e2d1);
		}
		if(!isdefined(start_origin))
		{
			start_origin = self gettagorigin("tag_origin") + vectorscale((0, 0, 1), 128);
		}
		if(isdefined(var_f69e2d1))
		{
			var_ac3aef54 = self gettagangles(var_f69e2d1);
		}
		if(!isdefined(var_ac3aef54))
		{
			var_ac3aef54 = self.angles;
		}
		flare = util::spawn_model(model, start_origin, var_ac3aef54);
		flare clientfield::set("play_flare_fx", 1);
		flare_lifetime = max(var_f9a2afb9[var_558d81a6] - var_558d81a6 * 0.15, 0.5);
		flare thread function_3ff1d5d6(self, vectorscale((0, 0, -1), 200), 0.5, 0.25, flare_lifetime, var_f69e2d1);
		flare thread function_9ff1a886(self);
		wait(0.15);
	}
}

/*
	Name: function_e863c9af
	Namespace: vehicle
	Checksum: 0x3C0BAB69
	Offset: 0xD1B0
	Size: 0x17A
	Parameters: 3
	Flags: Linked
*/
function function_e863c9af(owner, var_8fbb46cd, var_abfdfad5)
{
	ownerforward = anglestoforward(owner.angles);
	if(!var_abfdfad5)
	{
		var_538c5a93 = vectornormalize((ownerforward[0], ownerforward[1], 0));
		velocity = var_538c5a93 * 1000;
		var_43fa4fb6 = vectornormalize((var_8fbb46cd[0], var_8fbb46cd[1], 0));
		velocity = velocity + function_7786cb5e(var_43fa4fb6, owner getvelocity()) * 1.2;
	}
	else
	{
		ownerforward = vectornormalize(ownerforward);
		velocity = ownerforward * 1000;
		var_8fbb46cd = vectornormalize(var_8fbb46cd);
		velocity = velocity + owner getvelocity() * 1.2;
	}
	velocity = velocity + (0, 0, 1) * 275;
	return velocity;
}

/*
	Name: function_7786cb5e
	Namespace: vehicle
	Checksum: 0x8DA482CB
	Offset: 0xD338
	Size: 0x78
	Parameters: 2
	Flags: Linked
*/
function function_7786cb5e(var_95d2171d, vector)
{
	vector2d = (vector[0], vector[1], 0);
	dot = vectordot(var_95d2171d, vector2d);
	if(dot < 0)
	{
		vector2d = vector2d - var_95d2171d * dot;
	}
	return vector2d;
}

/*
	Name: function_3ff1d5d6
	Namespace: vehicle
	Checksum: 0xE879DB22
	Offset: 0xD3B8
	Size: 0x39C
	Parameters: 6
	Flags: Linked
*/
function function_3ff1d5d6(owner, gravity, var_2434a7ac, var_2d0d8b66, max_time, var_f69e2d1 = undefined)
{
	self endon(#"death");
	start_time = gettime();
	var_6de53efa = start_time + var_2434a7ac * 1000;
	end_time = start_time + max_time * 1000;
	if(isdefined(var_f69e2d1))
	{
		var_4626a28f = owner gettagangles(var_f69e2d1);
		var_abfdfad5 = 1;
	}
	else
	{
		var_4626a28f = owner.angles;
		var_abfdfad5 = 0;
	}
	velocity = function_e863c9af(owner, anglestoforward(var_4626a28f), var_abfdfad5);
	while(gettime() < end_time)
	{
		if(gettime() > var_6de53efa)
		{
			newvelocity = velocity * 1 - gettime() - var_6de53efa / 1000 / max_time - var_2434a7ac;
		}
		else
		{
			velocity = self getvelocity();
			var_c18f874c = vectornormalize(velocity);
			var_40a3c87d = function_e863c9af(owner, var_c18f874c, var_abfdfad5);
			velocity = lerpvector(velocity, var_40a3c87d, 0.5);
			newvelocity = velocity;
		}
		newvelocity = newvelocity + gravity * gettime() - start_time / 1000;
		movetopos = self.origin + newvelocity * var_2d0d8b66;
		traceresult = bullettrace(self.origin, movetopos, 0, owner, 0, 0, self);
		if(traceresult[#"fraction"] < 1)
		{
			if(traceresult[#"fraction"] > 0)
			{
				movetopos = traceresult[#"position"] + traceresult[#"normal"] * 0.1;
				var_2d0d8b66 = var_2d0d8b66 * traceresult[#"fraction"];
				self moveto(movetopos, var_2d0d8b66);
				self waittill(#"movedone");
			}
			break;
		}
		self moveto(movetopos, var_2d0d8b66);
		wait(var_2d0d8b66);
	}
	if(gettime() < end_time)
	{
		wait(end_time - gettime() / 1000);
	}
	self delete();
}

/*
	Name: function_b5f1f39
	Namespace: vehicle
	Checksum: 0xF97A4B69
	Offset: 0xD760
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_b5f1f39(missile)
{
	self endon(#"death");
	self thread heatseekingmissile::missiletarget_proximitydetonate(missile, missile.owner, missile.weapon, "death");
	missile waittill(#"death");
	self clientfield::set("play_flare_fx", 0);
	self clientfield::set("play_flare_hit_fx", 1);
	util::wait_network_frame();
	self delete();
}

/*
	Name: function_d6c00549
	Namespace: vehicle
	Checksum: 0x580A478
	Offset: 0xD848
	Size: 0x178
	Parameters: 2
	Flags: Linked
*/
function function_d6c00549(owner, var_cc6abdaa)
{
	if(isdefined(var_cc6abdaa) && isdefined(var_cc6abdaa.weapon))
	{
		if(var_cc6abdaa.weapon.guidedmissiletype === "HeatSeeking" && var_cc6abdaa missile_gettarget() === owner)
		{
			self thread function_b5f1f39(var_cc6abdaa);
			return 1;
		}
	}
	else
	{
		foreach(missile in level.missileentities)
		{
			if(!isdefined(missile) || !isdefined(missile.weapon))
			{
				continue;
			}
			if(missile.weapon.guidedmissiletype !== "HeatSeeking")
			{
				continue;
			}
			if(missile missile_gettarget() === owner)
			{
				self thread function_b5f1f39(missile);
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_9ff1a886
	Namespace: vehicle
	Checksum: 0x8C5982CE
	Offset: 0xD9C8
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function function_9ff1a886(owner)
{
	self endon(#"death");
	owner endon(#"death");
	while(!self.var_8dfaef6b)
	{
		self.var_8dfaef6b = self function_d6c00549(owner);
		waitresult = undefined;
		waitresult = owner waittill(#"stinger_fired_at_me");
		self.var_8dfaef6b = self function_d6c00549(owner, waitresult.projectile);
	}
}

/*
	Name: function_ae93aef2
	Namespace: vehicle
	Checksum: 0x67F196E6
	Offset: 0xDA90
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_ae93aef2(usephysics)
{
	clientfield::set("vehUseMaterialPhysics", usephysics);
}

/*
	Name: function_1bb979ca
	Namespace: vehicle
	Checksum: 0xA9883A45
	Offset: 0xDAC0
	Size: 0xD0
	Parameters: 3
	Flags: Linked
*/
function function_1bb979ca(n_cooldown_time, e_player, var_a18a512)
{
	e_player endon(#"death");
	var_e41dced6 = 0;
	while(var_e41dced6 <= var_d969828b)
	{
		var_50d0d640 = mapfloat(0, var_d969828b, 0, 1, var_e41dced6);
		e_player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_a18a512 + ".cooldown", var_50d0d640);
		var_e41dced6++;
		wait(0.05);
	}
}

/*
	Name: function_78cfd053
	Namespace: vehicle
	Checksum: 0x4CF60F04
	Offset: 0xDB98
	Size: 0x180
	Parameters: 0
	Flags: None
*/
function function_78cfd053()
{
	self endon(#"death");
	var_c56865cf = self.healthdefault;
	var_c96543ab = self.var_7812fce8;
	var_70fdf0cb = self.var_2f13ccc9;
	var_8ac0fa8 = [];
	for(n = 0; n < var_c96543ab; n++)
	{
		if(n == 0)
		{
			var_8ac0fa8[n] = var_c56865cf;
			continue;
		}
		var_8ac0fa8[n] = var_c56865cf - var_70fdf0cb * n;
	}
	while(true)
	{
		self waittill(#"damage");
		foreach(n_health_threshold in var_8ac0fa8)
		{
			if(self.health > n_health_threshold)
			{
				break;
			}
		}
		self thread function_f2fa0421(var_8ac0fa8[keys - 1]);
	}
}

/*
	Name: function_f2fa0421
	Namespace: vehicle
	Checksum: 0x3AE3979E
	Offset: 0xDD20
	Size: 0x1CC
	Parameters: 1
	Flags: Linked
*/
function function_f2fa0421(n_health)
{
	self notify(#"hash_7d33424c72addcf1");
	self endon(#"death", #"hash_7d33424c72addcf1");
	if(isdefined(level.playerhealth_regularregendelay))
	{
		wait(float(level.playerhealth_regularregendelay) / 1000);
	}
	else
	{
		wait(3);
	}
	while(self.health < n_health)
	{
		self.health = self.health + var_ab73d707;
		if(self.health >= n_health)
		{
			self.health = n_health;
		}
		var_d8bf3ee8 = self getvehoccupants();
		foreach(var_ccec4fe9 in var_d8bf3ee8)
		{
			if(isplayer(var_ccec4fe9))
			{
				var_ccec4fe9 update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_ff77beb1
	Namespace: vehicle
	Checksum: 0xDA0BD33D
	Offset: 0xDEF8
	Size: 0x2EC
	Parameters: 1
	Flags: None
*/
function function_ff77beb1(otherplayer = undefined)
{
	if(!isdefined(self))
	{
		return;
	}
	player = self;
	if(isdefined(player.var_19bc935c))
	{
		player function_d4a848de(player.var_19bc935c);
		player weapons::force_stowed_weapon_update();
		player.var_19bc935c = undefined;
		if(isdefined(otherplayer) && isdefined(otherplayer.var_19bc935c))
		{
			otherplayer function_d4a848de(otherplayer.var_19bc935c);
			otherplayer weapons::force_stowed_weapon_update();
			otherplayer.var_19bc935c = undefined;
		}
		return;
	}
	if(isdefined(otherplayer))
	{
		var_9db4bbbe = spawnstruct();
		var_9db4bbbe.var_6a2bb112 = player.tag_stowed_back;
		var_9db4bbbe.var_b6233805 = player.tag_stowed_hip;
		var_9db4bbbe.stowed_weapon = player getstowedweapon();
		var_9db4bbbe.bodytype = player getcharacterbodytype();
		var_9db4bbbe.var_ab6c1fa9 = player function_50a9aad5();
		var_d8d89950 = spawnstruct();
		var_d8d89950.var_6a2bb112 = otherplayer.tag_stowed_back;
		var_d8d89950.var_b6233805 = otherplayer.tag_stowed_hip;
		var_d8d89950.stowed_weapon = otherplayer getstowedweapon();
		var_d8d89950.bodytype = otherplayer getcharacterbodytype();
		var_d8d89950.var_ab6c1fa9 = otherplayer function_50a9aad5();
		if(!isdefined(player.var_19bc935c))
		{
			player.var_19bc935c = var_9db4bbbe;
		}
		if(!isdefined(otherplayer.var_19bc935c))
		{
			otherplayer.var_19bc935c = var_d8d89950;
		}
		otherplayer function_d4a848de(var_9db4bbbe);
		otherplayer function_269b4eca(var_9db4bbbe);
		player function_d4a848de(var_d8d89950);
		player function_269b4eca(var_d8d89950);
	}
}

/*
	Name: function_d4a848de
	Namespace: vehicle
	Checksum: 0x40EB0B26
	Offset: 0xE1F0
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_d4a848de(var_19bc935c)
{
	player = self;
	player setcharacterbodytype(var_19bc935c.bodytype);
	player function_8fd843dd(var_19bc935c.var_ab6c1fa9);
}

/*
	Name: function_269b4eca
	Namespace: vehicle
	Checksum: 0x62BF9D5A
	Offset: 0xE258
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_269b4eca(var_19bc935c)
{
	player = self;
	player weapons::detach_all_weapons();
	player.tag_stowed_back = var_19bc935c.var_6a2bb112;
	if(isdefined(player.tag_stowed_back))
	{
		player attach(player.tag_stowed_back, "tag_stowed_back", 1);
	}
	else if(level.weaponnone != var_19bc935c.stowed_weapon)
	{
		player setstowedweapon(var_19bc935c.stowed_weapon);
	}
	player.tag_stowed_hip = var_19bc935c.var_6a2bb112;
	if(isdefined(player.tag_stowed_hip))
	{
		player attach(player.tag_stowed_hip.worldmodel, "tag_stowed_hip_rear", 1);
	}
}

/*
	Name: function_16e6c35e
	Namespace: vehicle
	Checksum: 0x61557C72
	Offset: 0xE388
	Size: 0x4C
	Parameters: 3
	Flags: Linked
*/
function function_16e6c35e(vehicle, player, seatindex)
{
	if(isdefined(level.var_2513e40c))
	{
		return [[level.var_2513e40c]](vehicle, player, seatindex);
	}
	return 1;
}

