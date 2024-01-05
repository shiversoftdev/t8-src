// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\colors_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\bots\bot.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace spawner;

/*
	Name: __init__system__
	Namespace: spawner
	Checksum: 0x81DD415A
	Offset: 0x160
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"spawner", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: spawner
	Checksum: 0x69D27872
	Offset: 0x1B0
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._ai_group = [];
	level.missionfailed = 0;
	level.deathflags = [];
	level.go_to_node_arrays = [];
	level.global_spawn_timer = 0;
	level.global_spawn_count = 0;
	spawners = getspawnerarray();
	for(i = 0; i < spawners.size; i++)
	{
		spawners[i] thread spawn_prethink();
	}
	level.ai = [];
	add_global_spawn_function(#"axis", &global_ai_array);
	add_global_spawn_function(#"allies", &global_ai_array);
	add_global_spawn_function(#"team3", &global_ai_array);
	/#
		level thread aigroup_debug();
	#/
}

/*
	Name: __main__
	Namespace: spawner
	Checksum: 0xE5289B01
	Offset: 0x320
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	waittillframeend();
	ai = getaispeciesarray("all");
	array::thread_all(ai, &living_ai_prethink);
	foreach(ai_guy in ai)
	{
		if(isalive(ai_guy))
		{
			ai_guy thread spawn_think();
		}
	}
	level thread spawn_throttle_reset();
}

/*
	Name: global_ai_array
	Namespace: spawner
	Checksum: 0x382F739A
	Offset: 0x410
	Size: 0x2B2
	Parameters: 0
	Flags: Linked
*/
function global_ai_array()
{
	if(!isdefined(level.ai[self.team]))
	{
		level.ai[self.team] = [];
	}
	else if(!isarray(level.ai[self.team]))
	{
		level.ai[self.team] = array(level.ai[self.team]);
	}
	level.ai[self.team][level.ai[self.team].size] = self;
	self waittill(#"death");
	if(isdefined(self))
	{
		if(isdefined(level.ai) && isdefined(level.ai[self.team]) && isinarray(level.ai[self.team], self))
		{
			arrayremovevalue(level.ai[self.team], self);
		}
		else
		{
			foreach(aiarray in level.ai)
			{
				if(isinarray(aiarray, self))
				{
					arrayremovevalue(aiarray, self);
					break;
				}
			}
		}
	}
	else
	{
		foreach(array in level.ai)
		{
			for(i = array.size - 1; i >= 0; i--)
			{
				if(!isdefined(array[i]))
				{
					arrayremoveindex(array, i);
				}
			}
		}
	}
}

/*
	Name: spawn_throttle_reset
	Namespace: spawner
	Checksum: 0xD2D1BC04
	Offset: 0x6D0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function spawn_throttle_reset()
{
	while(true)
	{
		util::wait_network_frame();
		level.global_spawn_count = 0;
	}
}

/*
	Name: global_spawn_throttle
	Namespace: spawner
	Checksum: 0x1E86D40B
	Offset: 0x708
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function global_spawn_throttle(n_count_per_network_frame = 4)
{
	if(!(isdefined(level.first_frame) && level.first_frame))
	{
		while(level.global_spawn_count >= n_count_per_network_frame)
		{
			waitframe(1);
		}
		level.global_spawn_count++;
	}
}

/*
	Name: spawn_prethink
	Namespace: spawner
	Checksum: 0x3E275A8E
	Offset: 0x778
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function spawn_prethink()
{
	/#
		assert(self != level);
	#/
	if(isdefined(self.script_aigroup))
	{
		aigroup_init(self.script_aigroup, self);
	}
	if(isdefined(self.script_delete))
	{
		array_size = 0;
		if(isdefined(level._ai_delete))
		{
			if(isdefined(level._ai_delete[self.script_delete]))
			{
				array_size = level._ai_delete[self.script_delete].size;
			}
		}
		level._ai_delete[self.script_delete][array_size] = self;
	}
	if(isdefined(self.target))
	{
		crawl_through_targets_to_init_flags();
	}
}

/*
	Name: spawn_think
	Namespace: spawner
	Checksum: 0x5AC8C974
	Offset: 0x860
	Size: 0x246
	Parameters: 1
	Flags: Linked
*/
function spawn_think(spawner)
{
	self endon(#"death");
	if(isdefined(self.spawn_think_thread_active))
	{
		return;
	}
	self.spawn_think_thread_active = 1;
	/#
		assert(isactor(self) || isvehicle(self), "" + "");
	#/
	if(!isvehicle(self))
	{
		if(!isalive(self))
		{
			return;
		}
		self.maxhealth = self.health;
	}
	self.script_animname = undefined;
	if(isdefined(self.script_aigroup))
	{
		level flag::set(self.script_aigroup + "_spawning");
		self thread aigroup_think(level._ai_group[self.script_aigroup]);
	}
	if(isdefined(spawner) && isdefined(spawner.script_dropammo))
	{
		self.disableammodrop = !spawner.script_dropammo;
	}
	if(isdefined(spawner) && isdefined(spawner.spawn_funcs))
	{
		self.spawn_funcs = spawner.spawn_funcs;
	}
	if(isai(self))
	{
		spawn_think_action(spawner);
		/#
			assert(isalive(self));
		#/
		/#
			assert(isdefined(self.team));
		#/
	}
	self thread run_spawn_functions();
	self.finished_spawning = 1;
	self notify(#"finished spawning");
}

/*
	Name: run_spawn_functions
	Namespace: spawner
	Checksum: 0x453391DF
	Offset: 0xAB0
	Size: 0x3B6
	Parameters: 0
	Flags: Linked
*/
function run_spawn_functions()
{
	self endon(#"death");
	if(!isdefined(level.spawn_funcs))
	{
		return;
	}
	if(isdefined(level.spawn_funcs[#"all"]))
	{
		for(i = 0; i < level.spawn_funcs[#"all"].size; i++)
		{
			func = level.spawn_funcs[#"all"][i];
			util::single_thread_argarray(self, func[#"function"], func[#"params"]);
		}
	}
	if(isdefined(self.archetype) && isdefined(level.spawn_funcs[self.archetype]))
	{
		for(i = 0; i < level.spawn_funcs[self.archetype].size; i++)
		{
			func = level.spawn_funcs[self.archetype][i];
			util::single_thread_argarray(self, func[#"function"], func[#"params"]);
		}
	}
	waittillframeend();
	callback::callback(#"on_ai_spawned");
	if(isdefined(level.spawn_funcs[self.team]))
	{
		for(i = 0; i < level.spawn_funcs[self.team].size; i++)
		{
			func = level.spawn_funcs[self.team][i];
			util::single_thread_argarray(self, func[#"function"], func[#"params"]);
		}
	}
	if(isdefined(self.spawn_funcs))
	{
		for(i = 0; i < self.spawn_funcs.size; i++)
		{
			func = self.spawn_funcs[i];
			util::single_thread_argarray(self, func[#"function"], func[#"params"]);
		}
		/#
			var_f9bfb16c = self.spawn_funcs;
		#/
		self.spawn_funcs = undefined;
		/#
			self.spawn_funcs = var_f9bfb16c;
		#/
	}
	if(isdefined(self.archetype) && isdefined(level.spawn_funcs[self.archetype + "_post"]))
	{
		for(i = 0; i < level.spawn_funcs[self.archetype + "_post"].size; i++)
		{
			func = level.spawn_funcs[self.archetype + "_post"][i];
			util::single_thread_argarray(self, func[#"function"], func[#"params"]);
		}
	}
}

/*
	Name: living_ai_prethink
	Namespace: spawner
	Checksum: 0x21F9C7B5
	Offset: 0xE70
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function living_ai_prethink()
{
	if(isdefined(self.target))
	{
		crawl_through_targets_to_init_flags();
	}
}

/*
	Name: crawl_through_targets_to_init_flags
	Namespace: spawner
	Checksum: 0xFB89702E
	Offset: 0xEA0
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function crawl_through_targets_to_init_flags()
{
	array = get_node_funcs_based_on_target();
	if(isdefined(array))
	{
		targets = array[#"node"];
		get_func = array[#"get_target_func"];
		for(i = 0; i < targets.size; i++)
		{
			crawl_target_and_init_flags(targets[i], get_func);
		}
	}
}

/*
	Name: remove_spawner_values
	Namespace: spawner
	Checksum: 0xF6B5CE13
	Offset: 0xF50
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function remove_spawner_values()
{
	self.spawner_number = undefined;
	self.script_scene_entities = undefined;
}

/*
	Name: spawn_think_action
	Namespace: spawner
	Checksum: 0x1B7C4CB3
	Offset: 0xF70
	Size: 0x36C
	Parameters: 1
	Flags: Linked
*/
function spawn_think_action(spawner)
{
	remove_spawner_values();
	if(isdefined(spawner))
	{
		if(!isdefined(self.targetname))
		{
			self.targetname = spawner.targetname;
		}
	}
	if(isdefined(spawner) && isdefined(spawner.script_animname))
	{
		self.animname = spawner.script_animname;
	}
	else if(isdefined(self.script_animname))
	{
		self.animname = self.script_animname;
	}
	if(isdefined(self.script_forcecolor))
	{
		colors::set_force_color(self.script_forcecolor);
	}
	if(isdefined(self.script_ignoreme))
	{
		/#
			assert(self.script_ignoreme == 1, "");
		#/
		self val::set(#"spawn_think", "ignoreme", 1);
	}
	if(isdefined(self.script_ignoreall))
	{
		/#
			assert(self.script_ignoreall == 1, "");
		#/
		self val::set(#"spawn_think", "ignoreall", 1);
	}
	if(isdefined(self.script_grenades))
	{
		self.grenadeammo = self.script_grenades;
	}
	if(isdefined(self.script_pacifist))
	{
		self.pacifist = 1;
	}
	if(isdefined(self.script_allowdeath))
	{
		self.allowdeath = self.script_allowdeath;
	}
	if(isdefined(self.script_forcegib))
	{
		self.force_gib = 1;
	}
	if(isdefined(self.script_patroller))
	{
		return;
	}
	if(isdefined(self.target) && !isdefined(self.script_disable_spawn_targeting))
	{
		var_8e8b0300 = 0;
		a_s_targets = struct::get_array(self.target);
		foreach(s_target in a_s_targets)
		{
			if(s_target.classname === "scriptbundle_scene")
			{
				self thread function_27fb21d8(s_target);
				var_8e8b0300 = 1;
				break;
			}
		}
		if(!var_8e8b0300)
		{
			e_goal = getent(self.target, "targetname");
			if(isdefined(e_goal))
			{
				self setgoal(e_goal);
			}
			else
			{
				self thread go_to_node();
			}
		}
	}
	else
	{
		self thread set_goalradius_based_on_settings();
	}
}

/*
	Name: function_27fb21d8
	Namespace: spawner
	Checksum: 0x92845247
	Offset: 0x12E8
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_27fb21d8(s_scene)
{
	self endon(#"death");
	waittillframeend();
	s_scene scene::play(self);
	e_goal = getent(self.target, "targetname");
	if(isdefined(e_goal))
	{
		self setgoal(e_goal);
	}
	else
	{
		self thread go_to_node();
	}
}

/*
	Name: get_target_ents
	Namespace: spawner
	Checksum: 0xA4689A33
	Offset: 0x1390
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function get_target_ents(target)
{
	return getentarray(target, "targetname");
}

/*
	Name: get_target_nodes
	Namespace: spawner
	Checksum: 0xCB71F2ED
	Offset: 0x13C8
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function get_target_nodes(target)
{
	return getnodearray(target, "targetname");
}

/*
	Name: get_target_structs
	Namespace: spawner
	Checksum: 0x9AD44F86
	Offset: 0x1400
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function get_target_structs(target)
{
	return struct::get_array(target, "targetname");
}

/*
	Name: node_has_radius
	Namespace: spawner
	Checksum: 0x3DA8425
	Offset: 0x1438
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function node_has_radius(node)
{
	return isdefined(node.radius) && node.radius != 0;
}

/*
	Name: go_to_origin
	Namespace: spawner
	Checksum: 0xCF77A3EB
	Offset: 0x1470
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function go_to_origin(node, optional_arrived_at_node_func)
{
	self go_to_node(node, "origin", optional_arrived_at_node_func);
}

/*
	Name: go_to_struct
	Namespace: spawner
	Checksum: 0xC0C433F6
	Offset: 0x14B0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function go_to_struct(node, optional_arrived_at_node_func)
{
	self go_to_node(node, "struct", optional_arrived_at_node_func);
}

/*
	Name: go_to_node
	Namespace: spawner
	Checksum: 0x1BC4F175
	Offset: 0x14F0
	Size: 0xD4
	Parameters: 3
	Flags: Linked
*/
function go_to_node(node, goal_type, optional_arrived_at_node_func)
{
	self endon(#"death");
	array = get_node_funcs_based_on_target(node, goal_type);
	if(!isdefined(array))
	{
		self notify(#"reached_path_end");
		return;
	}
	if(!isdefined(optional_arrived_at_node_func))
	{
		optional_arrived_at_node_func = &util::empty;
	}
	go_to_node_using_funcs(array[#"node"], array[#"get_target_func"], array[#"set_goal_func_quits"], optional_arrived_at_node_func);
}

/*
	Name: get_least_used_from_array
	Namespace: spawner
	Checksum: 0xA93B5458
	Offset: 0x15D0
	Size: 0x14A
	Parameters: 1
	Flags: Linked
*/
function get_least_used_from_array(array)
{
	/#
		assert(array.size > 0, "");
	#/
	if(array.size == 1)
	{
		return array[0];
	}
	targetname = array[0].targetname;
	if(!isdefined(level.go_to_node_arrays[targetname]))
	{
		level.go_to_node_arrays[targetname] = array;
	}
	array = level.go_to_node_arrays[targetname];
	first = array[0];
	newarray = [];
	for(i = 0; i < array.size - 1; i++)
	{
		newarray[i] = array[i + 1];
	}
	newarray[array.size - 1] = array[0];
	level.go_to_node_arrays[targetname] = newarray;
	return first;
}

/*
	Name: go_to_node_using_funcs
	Namespace: spawner
	Checksum: 0x97E6FB86
	Offset: 0x1728
	Size: 0x4E4
	Parameters: 5
	Flags: Linked
*/
function go_to_node_using_funcs(node, get_target_func, set_goal_func_quits, optional_arrived_at_node_func, require_player_dist)
{
	self endon(#"stop_going_to_node", #"death");
	for(;;)
	{
		node = get_least_used_from_array(node);
		player_wait_dist = require_player_dist;
		if(isdefined(node.script_requires_player))
		{
			if(node.script_requires_player > 1)
			{
				player_wait_dist = node.script_requires_player;
			}
			else
			{
				player_wait_dist = 256;
			}
			node.script_requires_player = 0;
		}
		self set_goalradius_based_on_settings(node);
		if(isdefined(node.height))
		{
			self.goalheight = node.height;
		}
		if(isdefined(self.script_forcegoal) && self.script_forcegoal)
		{
			self thread ai::force_goal(get_goal(self.target));
		}
		else
		{
			if(isdefined(node) && (isdefined(node.script_forcegoal) && node.script_forcegoal))
			{
				self thread ai::force_goal(get_goal(self.target));
			}
			else
			{
				[[set_goal_func_quits]](node);
			}
		}
		self waittill(#"goal");
		[[optional_arrived_at_node_func]](node);
		if(isdefined(node.script_flag_set))
		{
			level flag::set(node.script_flag_set);
		}
		if(isdefined(node.script_flag_clear))
		{
			level flag::set(node.script_flag_clear);
		}
		if(isdefined(node.script_ent_flag_set))
		{
			if(!self flag::exists(node.script_ent_flag_set))
			{
				/#
					assertmsg(("" + node.script_ent_flag_set) + "");
				#/
			}
			self flag::set(node.script_ent_flag_set);
		}
		if(isdefined(node.script_ent_flag_clear))
		{
			if(!self flag::exists(node.script_ent_flag_clear))
			{
				/#
					assertmsg(("" + node.script_ent_flag_clear) + "");
				#/
			}
			self flag::clear(node.script_ent_flag_clear);
		}
		if(isdefined(node.script_flag_wait))
		{
			level flag::wait_till(node.script_flag_wait);
		}
		while(isdefined(node.script_requires_player))
		{
			node.script_requires_player = 0;
			if(self go_to_node_wait_for_player(node, get_target_func, player_wait_dist))
			{
				node.script_requires_player = 1;
				node notify(#"script_requires_player");
				break;
			}
			wait(0.1);
		}
		if(isdefined(node.script_aigroup))
		{
			waittill_ai_group_cleared(node.script_aigroup);
		}
		node util::script_delay();
		if(!isdefined(node.target))
		{
			break;
		}
		nextnode_array = update_target_array(node.target);
		if(!nextnode_array.size)
		{
			break;
		}
		node = nextnode_array;
	}
	if(isdefined(self.arrived_at_end_node_func))
	{
		[[self.arrived_at_end_node_func]](node);
	}
	self notify(#"reached_path_end");
	if(isdefined(self.delete_on_path_end))
	{
		self delete();
	}
	self set_goalradius_based_on_settings(node);
}

/*
	Name: go_to_node_wait_for_player
	Namespace: spawner
	Checksum: 0xDE59FC57
	Offset: 0x1C18
	Size: 0x2E4
	Parameters: 3
	Flags: Linked
*/
function go_to_node_wait_for_player(node, get_target_func, dist)
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(distancesquared(player.origin, node.origin) < distancesquared(self.origin, node.origin))
		{
			return true;
		}
	}
	vec = anglestoforward(self.angles);
	if(isdefined(node.target))
	{
		temp = [[get_target_func]](node.target);
		if(temp.size == 1)
		{
			vec = vectornormalize(temp[0].origin - node.origin);
		}
		else if(isdefined(node.angles))
		{
			vec = anglestoforward(node.angles);
		}
	}
	else if(isdefined(node.angles))
	{
		vec = anglestoforward(node.angles);
	}
	vec2 = [];
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		vec2[vec2.size] = vectornormalize(player.origin - self.origin);
	}
	for(i = 0; i < vec2.size; i++)
	{
		value = vec2[i];
		if(vectordot(vec, value) > 0)
		{
			return true;
		}
	}
	dist2rd = dist * dist;
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(distancesquared(player.origin, self.origin) < dist2rd)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: go_to_node_set_goal_pos
	Namespace: spawner
	Checksum: 0x6788ED24
	Offset: 0x1F08
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function go_to_node_set_goal_pos(ent)
{
	self setgoal(ent.origin);
}

/*
	Name: go_to_node_set_goal_node
	Namespace: spawner
	Checksum: 0x623264BE
	Offset: 0x1F40
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function go_to_node_set_goal_node(node)
{
	self setgoal(node);
}

/*
	Name: remove_crawled
	Namespace: spawner
	Checksum: 0xFB3489AA
	Offset: 0x1F70
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function remove_crawled(ent)
{
	waittillframeend();
	if(isdefined(ent))
	{
		ent.crawled = undefined;
	}
}

/*
	Name: crawl_target_and_init_flags
	Namespace: spawner
	Checksum: 0x7CEDF184
	Offset: 0x1FA0
	Size: 0x168
	Parameters: 2
	Flags: Linked
*/
function crawl_target_and_init_flags(ent, get_func)
{
	targets = [];
	index = 0;
	for(;;)
	{
		if(!isdefined(ent.crawled))
		{
			ent.crawled = 1;
			level thread remove_crawled(ent);
			if(isdefined(ent.script_flag_set))
			{
				if(!isdefined(level.flag[ent.script_flag_set]))
				{
					level flag::init(ent.script_flag_set);
				}
			}
			if(isdefined(ent.script_flag_wait))
			{
				if(!isdefined(level.flag[ent.script_flag_wait]))
				{
					level flag::init(ent.script_flag_wait);
				}
			}
			if(isdefined(ent.target))
			{
				new_targets = [[get_func]](ent.target);
				array::add(targets, new_targets);
			}
		}
		index++;
		if(index >= targets.size)
		{
			break;
		}
		ent = targets[index];
	}
}

/*
	Name: get_node_funcs_based_on_target
	Namespace: spawner
	Checksum: 0xF096E64E
	Offset: 0x2110
	Size: 0x27E
	Parameters: 2
	Flags: Linked
*/
function get_node_funcs_based_on_target(node, goal_type)
{
	get_target_func[#"origin"] = &get_target_ents;
	get_target_func[#"node"] = &get_target_nodes;
	get_target_func[#"struct"] = &get_target_structs;
	set_goal_func_quits[#"origin"] = &go_to_node_set_goal_pos;
	set_goal_func_quits[#"struct"] = &go_to_node_set_goal_pos;
	set_goal_func_quits[#"node"] = &go_to_node_set_goal_node;
	if(!isdefined(goal_type))
	{
		goal_type = "node";
	}
	array = [];
	if(isdefined(node))
	{
		array[#"node"][0] = node;
	}
	else
	{
		node = getentarray(self.target, "targetname");
		if(node.size > 0)
		{
			goal_type = "origin";
		}
		if(goal_type == "node")
		{
			node = getnodearray(self.target, "targetname");
			if(!node.size)
			{
				node = struct::get_array(self.target, "targetname");
				if(!node.size)
				{
					return;
				}
				goal_type = "struct";
			}
		}
		array[#"node"] = node;
	}
	array[#"get_target_func"] = get_target_func[goal_type];
	array[#"set_goal_func_quits"] = set_goal_func_quits[goal_type];
	return array;
}

/*
	Name: update_target_array
	Namespace: spawner
	Checksum: 0xD96FC837
	Offset: 0x2398
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function update_target_array(str_target)
{
	a_nd_target = getnodearray(str_target, "targetname");
	if(a_nd_target.size)
	{
		return a_nd_target;
	}
	a_s_target = struct::get_array(str_target, "targetname");
	if(a_s_target.size)
	{
		return a_s_target;
	}
	a_e_target = getentarray(str_target, "targetname");
	if(a_e_target.size)
	{
		return a_e_target;
	}
}

/*
	Name: set_goalradius_based_on_settings
	Namespace: spawner
	Checksum: 0x89A335DF
	Offset: 0x2458
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function set_goalradius_based_on_settings(node)
{
	self endon(#"death");
	waittillframeend();
	if(isdefined(self.script_radius))
	{
		self.goalradius = self.script_radius;
	}
	else if(isdefined(node) && node_has_radius(node))
	{
		self.goalradius = node.radius;
	}
}

/*
	Name: get_goal
	Namespace: spawner
	Checksum: 0x933A1EAB
	Offset: 0x24D8
	Size: 0x82
	Parameters: 2
	Flags: Linked
*/
function get_goal(str_goal, str_key = "targetname")
{
	a_goals = getnodearray(str_goal, str_key);
	if(!a_goals.size)
	{
		a_goals = getentarray(str_goal, str_key);
	}
	return array::random(a_goals);
}

/*
	Name: aigroup_debug
	Namespace: spawner
	Checksum: 0xFCC056FA
	Offset: 0x2568
	Size: 0x982
	Parameters: 0
	Flags: None
*/
function aigroup_debug()
{
	/#
		a_aigroups = [];
		a_spawners = getspawnerarray();
		foreach(spawner in a_spawners)
		{
			if(isdefined(spawner.script_aigroup) && !isinarray(a_aigroups, spawner.script_aigroup))
			{
				array::add(a_aigroups, spawner.script_aigroup, 0);
			}
		}
		foreach(aigroup in a_aigroups)
		{
			cmd = ((("" + aigroup) + "") + aigroup) + "";
			adddebugcommand(cmd);
		}
		cmd = ((("" + "") + "") + "") + "";
		adddebugcommand(cmd);
		while(true)
		{
			var_d4f26db9 = getdvarstring(#"debug_aigroup", "");
			var_c708e6e1 = 120;
			if(var_d4f26db9 != "")
			{
				debug2dtext((150, var_c708e6e1, 0), "", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
				var_c708e6e1 = var_c708e6e1 + 22;
				if(isdefined(level._ai_group) && isdefined(level._ai_group[var_d4f26db9]) && isdefined(level._ai_group[var_d4f26db9].ai))
				{
					ais = get_ai_group_ai(var_d4f26db9);
					spawners = get_ai_group_spawner_count(var_d4f26db9);
					debug2dtext((150, var_c708e6e1, 0), "" + var_d4f26db9, (1, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
					var_c708e6e1 = var_c708e6e1 + 22;
					debug2dtext((150, var_c708e6e1, 0), "", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
					var_c708e6e1 = var_c708e6e1 + 22;
					debug2dtext((150, var_c708e6e1, 0), "" + ais.size, (1, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
					var_c708e6e1 = var_c708e6e1 + 22;
					debug2dtext((150, var_c708e6e1, 0), "" + spawners, (1, 0, 0), 1, (0, 0, 0), 0.9, 1, 1);
					var_c708e6e1 = var_c708e6e1 + 22;
					if(isdefined(level.flag[var_d4f26db9 + ""]))
					{
						flag = level flag::get(var_d4f26db9 + "");
						if(flag)
						{
							debug2dtext((150, var_c708e6e1, 0), "", (1, 0.5, 0), 1, (0, 0, 0), 0.9, 1, 1);
						}
						else
						{
							debug2dtext((150, var_c708e6e1, 0), "", (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
						}
						var_c708e6e1 = var_c708e6e1 + 22;
					}
					if(isdefined(level.flag[var_d4f26db9 + ""]))
					{
						flag = level flag::get(var_d4f26db9 + "");
						if(flag)
						{
							debug2dtext((150, var_c708e6e1, 0), "", (1, 0.5, 0), 1, (0, 0, 0), 0.9, 1, 1);
						}
						else
						{
							debug2dtext((150, var_c708e6e1, 0), "", (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
						}
						var_c708e6e1 = var_c708e6e1 + 22;
					}
					debug2dtext((150, var_c708e6e1, 0), "", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
					var_c708e6e1 = var_c708e6e1 + 22;
					foreach(ai in ais)
					{
						sphere(ai.origin + vectorscale((0, 0, 1), 72), 4, (1, 1, 0), 1, 0, 8, 1);
						line(ai.origin + vectorscale((0, 0, 1), 72), ai.origin + vectorscale((0, 0, 1), 92), (1, 1, 0), 1, 1);
					}
					foreach(spawner in level._ai_group[var_d4f26db9].spawners)
					{
						if(isdefined(spawner) && spawner.count > 0)
						{
							sphere(spawner.origin + vectorscale((0, 0, 1), 10), 4, (1, 0, 0), 1, 0, 8, 1);
							line(spawner.origin + vectorscale((0, 0, 1), 10), spawner.origin + vectorscale((0, 0, 1), 50), (1, 0, 0), 1, 1);
							print3d(spawner.origin + vectorscale((0, 0, 1), 20), function_9e72a96(spawner.archetype), (1, 0, 0), 1, 0.4, 1);
							print3d(spawner.origin + vectorscale((0, 0, 1), 30), "" + spawner.count, (1, 0, 0), 1, 0.4, 1);
						}
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: aigroup_init
	Namespace: spawner
	Checksum: 0x2FBBBD81
	Offset: 0x2EF8
	Size: 0x2A4
	Parameters: 2
	Flags: Linked
*/
function aigroup_init(aigroup, spawner)
{
	if(!isdefined(level._ai_group[aigroup]))
	{
		level._ai_group[aigroup] = spawnstruct();
		level._ai_group[aigroup].aigroup = aigroup;
		level._ai_group[aigroup].aicount = 0;
		level._ai_group[aigroup].killed_count = 0;
		level._ai_group[aigroup].ai = [];
		level._ai_group[aigroup].spawners = [];
		level._ai_group[aigroup].cleared_count = 0;
		if(!isdefined(level.flag[aigroup + "_cleared"]))
		{
			level flag::init(aigroup + "_cleared");
		}
		if(!isdefined(level.flag[aigroup + "_spawning"]))
		{
			level flag::init(aigroup + "_spawning");
		}
		level thread set_ai_group_cleared_flag(level._ai_group[aigroup]);
	}
	if(isdefined(spawner))
	{
		if(!isdefined(level._ai_group[aigroup].spawners))
		{
			level._ai_group[aigroup].spawners = [];
		}
		else if(!isarray(level._ai_group[aigroup].spawners))
		{
			level._ai_group[aigroup].spawners = array(level._ai_group[aigroup].spawners);
		}
		level._ai_group[aigroup].spawners[level._ai_group[aigroup].spawners.size] = spawner;
		spawner thread aigroup_spawner_death(level._ai_group[aigroup]);
	}
}

/*
	Name: aigroup_spawner_death
	Namespace: spawner
	Checksum: 0xC4CA16D7
	Offset: 0x31A8
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function aigroup_spawner_death(tracker)
{
	self waittill(#"death", #"hash_4f7ebd2a17a44113");
	tracker notify(#"update_aigroup");
}

/*
	Name: aigroup_think
	Namespace: spawner
	Checksum: 0x9036D30E
	Offset: 0x31F8
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function aigroup_think(tracker)
{
	tracker.aicount++;
	tracker.ai[tracker.ai.size] = self;
	tracker notify(#"update_aigroup");
	self waittill(#"death");
	tracker.aicount--;
	tracker.killed_count++;
	tracker notify(#"update_aigroup");
	waitframe(1);
	tracker.ai = array::remove_undefined(tracker.ai);
}

/*
	Name: set_ai_group_cleared_flag
	Namespace: spawner
	Checksum: 0xEA13F089
	Offset: 0x32B8
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function set_ai_group_cleared_flag(tracker)
{
	waittillframeend();
	while(tracker.aicount + get_ai_group_spawner_count(tracker.aigroup) > tracker.cleared_count)
	{
		tracker waittill(#"update_aigroup");
	}
	level flag::set(tracker.aigroup + "_cleared");
}

/*
	Name: trigger_requires_player
	Namespace: spawner
	Checksum: 0x71F4FD39
	Offset: 0x3350
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function trigger_requires_player(trigger)
{
	if(!isdefined(trigger))
	{
		return 0;
	}
	return isdefined(trigger.script_requires_player);
}

/*
	Name: spawn
	Namespace: spawner
	Checksum: 0x624CB30E
	Offset: 0x3380
	Size: 0xBCC
	Parameters: 5
	Flags: Linked
*/
function spawn(b_force = 0, str_targetname, v_origin, v_angles, bignorespawninglimit)
{
	self endon(#"death");
	e_spawned = undefined;
	force_spawn = 0;
	makeroom = 0;
	infinitespawn = 0;
	deleteonzerocount = 0;
	if(!check_player_requirements())
	{
		return;
	}
	while(true)
	{
		if(!(isdefined(bignorespawninglimit) && bignorespawninglimit) && (!(isdefined(self.ignorespawninglimit) && self.ignorespawninglimit)))
		{
			global_spawn_throttle();
		}
		if(isdefined(self.lastspawntime) && self.lastspawntime >= gettime())
		{
			waitframe(1);
			continue;
		}
		break;
	}
	if(isactorspawner(self))
	{
		if(isdefined(self.spawnflags) && (self.spawnflags & 2) == 2)
		{
			makeroom = 1;
		}
		if(isdefined(self.spawnflags) && (self.spawnflags & 128) == 128)
		{
			deleteonzerocount = 1;
		}
	}
	else if(isvehiclespawner(self))
	{
		if(isdefined(self.spawnflags) && (self.spawnflags & 8) == 8)
		{
			makeroom = 1;
		}
	}
	if(b_force || (isdefined(self.spawnflags) && (self.spawnflags & 16) == 16) || isdefined(self.script_forcespawn))
	{
		force_spawn = 1;
	}
	if(isdefined(self.spawnflags) && (self.spawnflags & 64) == 64)
	{
		infinitespawn = 1;
	}
	/#
		vehiclespawner = self.classname == "";
		overridevehicle = !vehiclespawner || (!(isdefined(level.var_3313aeb2) && level.var_3313aeb2));
		if(isdefined(level.archetype_spawners) && isarray(level.archetype_spawners) && overridevehicle)
		{
			archetype = undefined;
			archetype_spawner = undefined;
			if(self.team == #"axis")
			{
				archetype = getdvarstring(#"feature_ai_enemy_archetype");
				if(getdvarstring(#"feature_ai_archetype_override") == #"enemy")
				{
					archetype = getdvarstring(#"feature_ai_enemy_archetype");
				}
				archetype_spawner = level.archetype_spawners[archetype];
			}
			else
			{
				if(self.team == #"allies")
				{
					archetype = getdvarstring(#"feature_ai_ally_archetype");
					if(getdvarstring(#"feature_ai_archetype_override") == "")
					{
						archetype = getdvarstring(#"feature_ai_ally_archetype");
					}
					archetype_spawner = level.archetype_spawners[archetype];
				}
				else if(self.team == #"team3")
				{
					if(getdvarstring(#"feature_ai_archetype_override") == #"enemy")
					{
						archetype = getdvarstring(#"feature_ai_enemy_archetype");
					}
					else
					{
						if(getdvarstring(#"feature_ai_archetype_override") == "")
						{
							archetype = getdvarstring(#"feature_ai_ally_archetype");
						}
						else
						{
							archetype = getdvarstring(#"feature_ai_enemy_archetype");
						}
					}
					archetype_spawner = level.archetype_spawners[archetype];
					if(!isdefined(archetype_spawner))
					{
						archetype = getdvarstring(#"feature_ai_ally_archetype");
						archetype_spawner = level.archetype_spawners[archetype];
					}
				}
			}
			if(isspawner(archetype_spawner))
			{
				while(isdefined(archetype_spawner.lastspawntime) && archetype_spawner.lastspawntime >= gettime())
				{
					waitframe(1);
				}
				originalorigin = archetype_spawner.origin;
				originalangles = archetype_spawner.angles;
				originaltarget = archetype_spawner.target;
				originaltargetname = archetype_spawner.targetname;
				archetype_spawner.target = self.target;
				archetype_spawner.targetname = self.targetname;
				archetype_spawner.script_noteworthy = self.script_noteworthy;
				archetype_spawner.script_string = self.script_string;
				archetype_spawner.origin = self.origin;
				archetype_spawner.angles = self.angles;
				e_spawned = archetype_spawner spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
				if(!isdefined(str_targetname))
				{
					e_spawned.targetname = archetype_spawner.targetname;
				}
				archetype_spawner.target = originaltarget;
				archetype_spawner.targetname = originaltargetname;
				archetype_spawner.origin = originalorigin;
				archetype_spawner.angles = originalangles;
				if(isdefined(archetype_spawner.spawnflags) && (archetype_spawner.spawnflags & 64) == 64)
				{
					archetype_spawner.count++;
				}
				archetype_spawner.lastspawntime = gettime();
			}
			else if(archetype === "")
			{
				bot = bot::add_bot(self.team);
				if(isdefined(bot))
				{
					bot.botremoveondeath = 1;
					bot thread bot::fixed_spawn_override(self.origin, self.angles[1], undefined, isdefined(self.script_forcegoal) && self.script_forcegoal);
					bot waittill(#"spawned_player");
					bot.sessionteam = self.team;
					bot setteam(self.team);
					if(isdefined(bot.pers))
					{
						bot.pers[#"team"] = self.team;
					}
					bot.target = self.target;
					bot.targetname = self.targetname + "";
					bot.script_noteworthy = self.script_noteworthy;
					bot.script_string = self.script_string;
					return bot;
				}
			}
		}
	#/
	if(!isdefined(e_spawned))
	{
		use_female = randomint(100) < level.female_percent;
		if(level.dont_use_female_replacements === 1)
		{
			use_female = 0;
		}
		if(use_female && isdefined(self.aitypevariant))
		{
			e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, self.aitypevariant);
		}
		else
		{
			override_aitype = undefined;
			if(isdefined(level.override_spawned_aitype_func))
			{
				override_aitype = [[level.override_spawned_aitype_func]](self);
			}
			if(isdefined(override_aitype))
			{
				e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, override_aitype);
			}
			else
			{
				e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
			}
		}
	}
	if(isdefined(e_spawned))
	{
		if(isdefined(level.run_custom_function_on_ai))
		{
			if(isdefined(archetype_spawner))
			{
				e_spawned thread [[level.run_custom_function_on_ai]](archetype_spawner, str_targetname, force_spawn);
			}
			else
			{
				e_spawned thread [[level.run_custom_function_on_ai]](self, str_targetname, force_spawn);
			}
		}
		if(isdefined(v_origin) || isdefined(v_angles))
		{
			e_spawned teleport_spawned(v_origin, v_angles);
		}
		self.lastspawntime = gettime();
	}
	var_e331297b = isdefined(self.count) && self.count <= 0;
	if(var_e331297b && isdefined(self.script_aigroup))
	{
		self notify(#"hash_4f7ebd2a17a44113");
	}
	if(deleteonzerocount || (isdefined(self.script_delete_on_zero) && self.script_delete_on_zero) && var_e331297b)
	{
		self thread function_d4a13039();
	}
	if(issentient(e_spawned))
	{
		if(!spawn_failed(e_spawned))
		{
			if(isdefined(self.radius))
			{
				e_spawned.goalradius = self.radius;
			}
			self notify(#"hash_66551cac93d16401");
			return e_spawned;
		}
	}
	else
	{
		self notify(#"hash_66551cac93d16401");
		return e_spawned;
	}
}

/*
	Name: function_d4a13039
	Namespace: spawner
	Checksum: 0xCE837E3C
	Offset: 0x3F58
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_d4a13039()
{
	self endon(#"death");
	self waittill(#"hash_66551cac93d16401");
	waittillframeend();
	self delete();
}

/*
	Name: teleport_spawned
	Namespace: spawner
	Checksum: 0xA8C8F4A2
	Offset: 0x3FA8
	Size: 0xAA
	Parameters: 3
	Flags: Linked
*/
function teleport_spawned(v_origin = self.origin, v_angles = self.angles, b_reset_entity = 1)
{
	if(isactor(self))
	{
		self forceteleport(v_origin, v_angles, 1, b_reset_entity);
	}
	else
	{
		self.origin = v_origin;
		self.angles = v_angles;
	}
}

/*
	Name: check_player_requirements
	Namespace: spawner
	Checksum: 0xEFEA561C
	Offset: 0x4060
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function check_player_requirements()
{
	if(isdefined(level.players) && level.players.size > 0)
	{
		n_player_count = level.players.size;
	}
	else
	{
		n_player_count = getnumexpectedplayers();
	}
	if(isdefined(self.script_minplayers))
	{
		if(n_player_count < self.script_minplayers)
		{
			self delete();
			return false;
		}
	}
	if(isdefined(self.script_numplayers))
	{
		if(n_player_count < self.script_numplayers)
		{
			self delete();
			return false;
		}
	}
	if(isdefined(self.script_maxplayers))
	{
		if(n_player_count > self.script_maxplayers)
		{
			self delete();
			return false;
		}
	}
	return true;
}

/*
	Name: spawn_failed
	Namespace: spawner
	Checksum: 0x836CDF6F
	Offset: 0x4158
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function spawn_failed(spawn)
{
	if(isalive(spawn))
	{
		if(!isdefined(spawn.finished_spawning))
		{
			spawn waittill(#"finished spawning");
		}
		waittillframeend();
		if(isalive(spawn))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: kill_spawnernum
	Namespace: spawner
	Checksum: 0xBCEBF822
	Offset: 0x41D0
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function kill_spawnernum(number)
{
	foreach(sp in getspawnerarray("" + number, "script_killspawner"))
	{
		sp delete();
	}
}

/*
	Name: set_ai_group_cleared_count
	Namespace: spawner
	Checksum: 0x20C719FA
	Offset: 0x4278
	Size: 0x4A
	Parameters: 2
	Flags: None
*/
function set_ai_group_cleared_count(aigroup, count)
{
	aigroup_init(aigroup);
	level._ai_group[aigroup].cleared_count = count;
}

/*
	Name: waittill_ai_group_cleared
	Namespace: spawner
	Checksum: 0xB72FCDCC
	Offset: 0x42D0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function waittill_ai_group_cleared(aigroup)
{
	/#
		assert(isdefined(level._ai_group[aigroup]), ("" + aigroup) + "");
	#/
	level flag::wait_till(aigroup + "_cleared");
}

/*
	Name: waittill_ai_group_count
	Namespace: spawner
	Checksum: 0xA38A39A2
	Offset: 0x4348
	Size: 0x6A
	Parameters: 2
	Flags: None
*/
function waittill_ai_group_count(aigroup, count)
{
	while(get_ai_group_spawner_count(aigroup) + level._ai_group[aigroup].aicount > count)
	{
		level._ai_group[aigroup] waittill(#"update_aigroup");
	}
}

/*
	Name: waittill_ai_group_ai_count
	Namespace: spawner
	Checksum: 0xD6EDF863
	Offset: 0x43C0
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function waittill_ai_group_ai_count(aigroup, count)
{
	while(level._ai_group[aigroup].aicount > count)
	{
		level._ai_group[aigroup] waittill(#"update_aigroup");
	}
}

/*
	Name: waittill_ai_group_spawner_count
	Namespace: spawner
	Checksum: 0x7AFA015E
	Offset: 0x4428
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function waittill_ai_group_spawner_count(aigroup, count)
{
	while(get_ai_group_spawner_count(aigroup) > count)
	{
		level._ai_group[aigroup] waittill(#"update_aigroup");
	}
}

/*
	Name: waittill_ai_group_amount_killed
	Namespace: spawner
	Checksum: 0xE3DAC335
	Offset: 0x4490
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function waittill_ai_group_amount_killed(aigroup, amount_killed)
{
	while(level._ai_group[aigroup].killed_count < amount_killed)
	{
		level._ai_group[aigroup] waittill(#"update_aigroup");
	}
}

/*
	Name: get_ai_group_count
	Namespace: spawner
	Checksum: 0xAAE8E1FA
	Offset: 0x44F8
	Size: 0x38
	Parameters: 1
	Flags: None
*/
function get_ai_group_count(aigroup)
{
	return get_ai_group_spawner_count(aigroup) + level._ai_group[aigroup].aicount;
}

/*
	Name: get_ai_group_sentient_count
	Namespace: spawner
	Checksum: 0xEFEFDE37
	Offset: 0x4538
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_ai_group_sentient_count(aigroup)
{
	return level._ai_group[aigroup].aicount;
}

/*
	Name: get_ai_group_spawner_count
	Namespace: spawner
	Checksum: 0x6420ED3E
	Offset: 0x4568
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function get_ai_group_spawner_count(aigroup)
{
	n_count = 0;
	foreach(sp in level._ai_group[aigroup].spawners)
	{
		if(isdefined(sp) && sp.count > 0)
		{
			n_count = n_count + sp.count;
		}
	}
	return n_count;
}

/*
	Name: get_ai_group_ai
	Namespace: spawner
	Checksum: 0xF91D0950
	Offset: 0x4630
	Size: 0xB0
	Parameters: 1
	Flags: None
*/
function get_ai_group_ai(aigroup)
{
	aiset = [];
	for(index = 0; index < level._ai_group[aigroup].ai.size; index++)
	{
		if(!isalive(level._ai_group[aigroup].ai[index]))
		{
			continue;
		}
		aiset[aiset.size] = level._ai_group[aigroup].ai[index];
	}
	return aiset;
}

/*
	Name: add_global_spawn_function
	Namespace: spawner
	Checksum: 0x5B73222F
	Offset: 0x46E8
	Size: 0x148
	Parameters: 3
	Flags: Linked, Variadic
*/
function add_global_spawn_function(team, spawn_func, ...)
{
	if(!isdefined(level.spawn_funcs))
	{
		level.spawn_funcs = [];
	}
	if(!isdefined(level.spawn_funcs[team]))
	{
		level.spawn_funcs[team] = [];
	}
	func = [];
	func[#"function"] = spawn_func;
	func[#"params"] = vararg;
	if(!isdefined(level.spawn_funcs[team]))
	{
		level.spawn_funcs[team] = [];
	}
	else if(!isarray(level.spawn_funcs[team]))
	{
		level.spawn_funcs[team] = array(level.spawn_funcs[team]);
	}
	level.spawn_funcs[team][level.spawn_funcs[team].size] = func;
}

/*
	Name: add_ai_spawn_function
	Namespace: spawner
	Checksum: 0x446E3A63
	Offset: 0x4838
	Size: 0x19C
	Parameters: 2
	Flags: Linked, Variadic
*/
function add_ai_spawn_function(spawn_func, ...)
{
	if(!isdefined(level.spawn_funcs))
	{
		level.spawn_funcs = [];
	}
	if(!isdefined(level.spawn_funcs[#"all"]))
	{
		level.spawn_funcs[#"all"] = [];
	}
	func = [];
	func[#"function"] = spawn_func;
	func[#"params"] = vararg;
	if(!isdefined(level.spawn_funcs[#"all"]))
	{
		level.spawn_funcs[#"all"] = [];
	}
	else if(!isarray(level.spawn_funcs[#"all"]))
	{
		level.spawn_funcs[#"all"] = array(level.spawn_funcs[#"all"]);
	}
	level.spawn_funcs[#"all"][level.spawn_funcs[#"all"].size] = func;
}

/*
	Name: add_archetype_spawn_function
	Namespace: spawner
	Checksum: 0xA353548C
	Offset: 0x49E0
	Size: 0x148
	Parameters: 3
	Flags: Linked, Variadic
*/
function add_archetype_spawn_function(archetype, spawn_func, ...)
{
	if(!isdefined(level.spawn_funcs))
	{
		level.spawn_funcs = [];
	}
	if(!isdefined(level.spawn_funcs[archetype]))
	{
		level.spawn_funcs[archetype] = [];
	}
	func = [];
	func[#"function"] = spawn_func;
	func[#"params"] = vararg;
	if(!isdefined(level.spawn_funcs[archetype]))
	{
		level.spawn_funcs[archetype] = [];
	}
	else if(!isarray(level.spawn_funcs[archetype]))
	{
		level.spawn_funcs[archetype] = array(level.spawn_funcs[archetype]);
	}
	level.spawn_funcs[archetype][level.spawn_funcs[archetype].size] = func;
}

/*
	Name: function_89a2cd87
	Namespace: spawner
	Checksum: 0x365D1EC1
	Offset: 0x4B30
	Size: 0x1A4
	Parameters: 3
	Flags: Linked, Variadic
*/
function function_89a2cd87(archetype, spawn_func, ...)
{
	if(!isdefined(level.spawn_funcs))
	{
		level.spawn_funcs = [];
	}
	if(!isdefined(level.spawn_funcs[archetype + "_post"]))
	{
		level.spawn_funcs[archetype + "_post"] = [];
	}
	func = [];
	func[#"function"] = spawn_func;
	func[#"params"] = vararg;
	if(!isdefined(level.spawn_funcs[archetype + "_post"]))
	{
		level.spawn_funcs[archetype + "_post"] = [];
	}
	else if(!isarray(level.spawn_funcs[archetype + "_post"]))
	{
		level.spawn_funcs[archetype + "_post"] = array(level.spawn_funcs[archetype + "_post"]);
	}
	level.spawn_funcs[archetype + "_post"][level.spawn_funcs[archetype + "_post"].size] = func;
}

/*
	Name: remove_global_spawn_function
	Namespace: spawner
	Checksum: 0x8FEB95F5
	Offset: 0x4CE0
	Size: 0xE6
	Parameters: 2
	Flags: Linked
*/
function remove_global_spawn_function(team, func)
{
	if(isdefined(level.spawn_funcs) && isdefined(level.spawn_funcs[team]))
	{
		array = [];
		for(i = 0; i < level.spawn_funcs[team].size; i++)
		{
			if(level.spawn_funcs[team][i][#"function"] != func)
			{
				array[array.size] = level.spawn_funcs[team][i];
			}
		}
		level.spawn_funcs[team] = array;
	}
}

/*
	Name: add_spawn_function
	Namespace: spawner
	Checksum: 0x26F9C0D
	Offset: 0x4DD0
	Size: 0xC6
	Parameters: 2
	Flags: Linked, Variadic
*/
function add_spawn_function(spawn_func, ...)
{
	/#
		assert(!isdefined(level._loadstarted) || !isalive(self), "");
	#/
	func = [];
	func[#"function"] = spawn_func;
	func[#"params"] = vararg;
	if(!isdefined(self.spawn_funcs))
	{
		self.spawn_funcs = [];
	}
	self.spawn_funcs[self.spawn_funcs.size] = func;
}

/*
	Name: remove_spawn_function
	Namespace: spawner
	Checksum: 0xFBA74D5C
	Offset: 0x4EA0
	Size: 0x112
	Parameters: 1
	Flags: Linked
*/
function remove_spawn_function(func)
{
	/#
		assert(!isdefined(level._loadstarted) || !isalive(self), "");
	#/
	if(isdefined(self.spawn_funcs))
	{
		array = [];
		for(i = 0; i < self.spawn_funcs.size; i++)
		{
			if(self.spawn_funcs[i][#"function"] != func)
			{
				array[array.size] = self.spawn_funcs[i];
			}
		}
		/#
			assert(self.spawn_funcs.size != array.size, "");
		#/
		self.spawn_funcs = array;
	}
}

/*
	Name: add_spawn_function_group
	Namespace: spawner
	Checksum: 0xF61701DB
	Offset: 0x4FC0
	Size: 0xEC
	Parameters: 8
	Flags: None
*/
function add_spawn_function_group(str_value, str_key = "targetname", func_spawn, param_1, param_2, param_3, param_4, param_5)
{
	/#
		assert(isdefined(str_value), "");
	#/
	/#
		assert(isdefined(func_spawn), "");
	#/
	a_spawners = getspawnerarray(str_value, str_key);
	array::run_all(a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5);
}

/*
	Name: add_spawn_function_ai_group
	Namespace: spawner
	Checksum: 0xAA3C2BA4
	Offset: 0x50B8
	Size: 0xDC
	Parameters: 7
	Flags: None
*/
function add_spawn_function_ai_group(str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5)
{
	/#
		assert(isdefined(str_aigroup), "");
	#/
	/#
		assert(isdefined(func_spawn), "");
	#/
	a_spawners = getspawnerarray(str_aigroup, "script_aigroup");
	array::run_all(a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5);
}

/*
	Name: remove_spawn_function_ai_group
	Namespace: spawner
	Checksum: 0x958FC180
	Offset: 0x51A0
	Size: 0xCC
	Parameters: 7
	Flags: None
*/
function remove_spawn_function_ai_group(str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5)
{
	/#
		assert(isdefined(str_aigroup), "");
	#/
	/#
		assert(isdefined(func_spawn), "");
	#/
	a_spawners = getspawnerarray(str_aigroup, "script_aigroup");
	array::run_all(a_spawners, &remove_spawn_function, func_spawn);
}

/*
	Name: simple_spawn
	Namespace: spawner
	Checksum: 0xCE6FC222
	Offset: 0x5278
	Size: 0x1E8
	Parameters: 3
	Flags: Linked, Variadic
*/
function simple_spawn(name_or_spawners, spawn_func, ...)
{
	spawners = [];
	if(isstring(name_or_spawners))
	{
		spawners = getentarray(name_or_spawners, "targetname");
		/#
			assert(spawners.size, ("" + name_or_spawners) + "");
		#/
	}
	else
	{
		if(!isdefined(name_or_spawners))
		{
			name_or_spawners = [];
		}
		else if(!isarray(name_or_spawners))
		{
			name_or_spawners = array(name_or_spawners);
		}
		spawners = name_or_spawners;
	}
	a_spawned = [];
	foreach(sp in spawners)
	{
		e_spawned = sp spawn();
		if(isdefined(e_spawned))
		{
			if(isdefined(spawn_func))
			{
				util::single_thread_argarray(e_spawned, spawn_func, vararg);
			}
			if(!isdefined(a_spawned))
			{
				a_spawned = [];
			}
			else if(!isarray(a_spawned))
			{
				a_spawned = array(a_spawned);
			}
			a_spawned[a_spawned.size] = e_spawned;
		}
	}
	return a_spawned;
}

/*
	Name: simple_spawn_single
	Namespace: spawner
	Checksum: 0x4291B4CC
	Offset: 0x5468
	Size: 0xC8
	Parameters: 3
	Flags: Linked, Variadic
*/
function simple_spawn_single(name_or_spawner, spawn_func, ...)
{
	a_args = arraycombine(array(name_or_spawner, spawn_func), vararg, 1, 0);
	ai = util::single_func_argarray(undefined, &simple_spawn, a_args);
	/#
		assert(ai.size <= 1, "");
	#/
	if(ai.size)
	{
		return ai[0];
	}
}

/*
	Name: init_female_spawn
	Namespace: spawner
	Checksum: 0x5C3BD5B0
	Offset: 0x5538
	Size: 0x2C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec init_female_spawn()
{
	level.female_percent = 0;
	set_female_percent(30);
}

/*
	Name: set_female_percent
	Namespace: spawner
	Checksum: 0x3F1514CC
	Offset: 0x5570
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function set_female_percent(percent)
{
	level.female_percent = percent;
}

