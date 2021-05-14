// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace bot_chain;

/*
	Name: function_89f2df9
	Namespace: bot_chain
	Checksum: 0xFA268BC2
	Offset: 0x120
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"bot_chain", &__init__, undefined, undefined);
}

#namespace namespace_92792865;

/*
	Name: __constructor
	Namespace: namespace_92792865
	Checksum: 0x5B7C59F6
	Offset: 0x168
	Size: 0x32
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.var_4de004b7 = undefined;
	self.startstruct = undefined;
	self.var_e7ce4106 = undefined;
	self.var_d1e3e893 = undefined;
}

/*
	Name: __destructor
	Namespace: namespace_92792865
	Checksum: 0x80F724D1
	Offset: 0x1A8
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
}

#namespace bot_chain;

/*
	Name: function_92792865
	Namespace: bot_chain
	Checksum: 0x7DDA262D
	Offset: 0x1B8
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_92792865()
{
	classes.var_92792865[0] = spawnstruct();
	classes.var_92792865[0].__vtable[913321084] = &namespace_92792865::__destructor;
	classes.var_92792865[0].__vtable[674154906] = &namespace_92792865::__constructor;
}

/*
	Name: __init__
	Namespace: bot_chain
	Checksum: 0x3558FE50
	Offset: 0x248
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_e3eaa42b();
	level thread function_ea764100();
}

/*
	Name: function_b1487cfa
	Namespace: bot_chain
	Checksum: 0xB8423BFB
	Offset: 0x280
	Size: 0x102
	Parameters: 1
	Flags: Private
*/
private function function_b1487cfa(var_72284260)
{
	entities = bot::get_bots();
	foreach(entity in entities)
	{
		if(!isdefined(entity.bot))
		{
			continue;
		}
		if(!isdefined(entity.bot.var_53ffa4c4))
		{
			continue;
		}
		if(isdefined(entity.bot.var_53ffa4c4.var_4de004b7) && entity.bot.var_53ffa4c4.var_4de004b7 == var_72284260)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_8ded619
	Namespace: bot_chain
	Checksum: 0x9A55D14C
	Offset: 0x390
	Size: 0xFF4
	Parameters: 3
	Flags: Private
*/
private function function_8ded619(var_72284260, targetstructs = undefined, duration = 1)
{
	/#
		var_a6ba4626 = 8;
		active = function_b1487cfa(var_72284260);
		if(active)
		{
			sphere(var_72284260.origin, 8, (0, 1, 0), 1, 0, 12, duration);
		}
		else if(isinarray(level.var_40ed3318, var_72284260))
		{
			sphere(var_72284260.origin, 6, vectorscale((1, 1, 1), 0.75), 0.7, 0, 10, duration);
		}
		else
		{
			sphere(var_72284260.origin, 6, (1, 0.5, 0), 0.7, 0, 10, duration);
		}
		if(!isdefined(targetstructs))
		{
			targetstructs = [];
			if(isdefined(var_72284260.target))
			{
				structs = struct::get_array(var_72284260.target);
				foreach(struct in structs)
				{
					if(struct.variantname === "")
					{
						array::add(targetstructs, struct);
					}
				}
			}
			if(isdefined(var_72284260.var_6440b5b))
			{
				var_354db6a0 = var_72284260 namespace_2e6206f9::get_target_structs("");
				if(var_354db6a0.size > 0)
				{
					targetstructs = arraycombine(targetstructs, var_354db6a0, 0, 0);
				}
			}
		}
		foreach(struct in targetstructs)
		{
			if(active)
			{
				line(var_72284260.origin, struct.origin, (0, 1, 0), 1, 0, duration);
				continue;
			}
			line(var_72284260.origin, struct.origin, (1, 0.5, 0), 0.7, 0, duration);
		}
		if(isdefined(var_72284260.targetname))
		{
			if(active)
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.targetname, (0, 1, 0), 1, 0.2, duration);
			}
			else
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.targetname, (1, 0.5, 0), 1, 0.2, duration);
			}
			var_a6ba4626 = var_a6ba4626 + 4;
		}
		if(isdefined(var_72284260.script_flag_set))
		{
			if(level flag::get(var_72284260.script_flag_set))
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_set, (0, 1, 0), 1, 0.2, duration);
			}
			else
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_set, (1, 0.5, 0), 1, 0.2, duration);
			}
			var_a6ba4626 = var_a6ba4626 + 4;
		}
		if(isdefined(var_72284260.script_flag_set))
		{
			if(level flag::get(var_72284260.script_flag_set))
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_set, (0, 1, 0), 1, 0.2, duration);
			}
			else
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_set, (1, 0.5, 0), 1, 0.2, duration);
			}
			var_a6ba4626 = var_a6ba4626 + 4;
		}
		if(isdefined(var_72284260.script_flag_wait))
		{
			if(level flag::get(var_72284260.script_flag_wait))
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_wait, (0, 1, 0), 1, 0.2, duration);
			}
			else
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_wait, (1, 0.5, 0), 1, 0.2, duration);
			}
			var_a6ba4626 = var_a6ba4626 + 4;
		}
		if(isdefined(var_72284260.script_flag_clear))
		{
			if(level flag::get(var_72284260.script_flag_wait))
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_clear, (0, 1, 0), 1, 0.2, duration);
			}
			else
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_clear, (1, 0.5, 0), 1, 0.2, duration);
			}
			var_a6ba4626 = var_a6ba4626 + 4;
		}
		if(isdefined(var_72284260.script_flag_activate))
		{
			if(level flag::get(var_72284260.script_flag_activate))
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_activate, (0, 1, 0), 1, 0.2, duration);
			}
			else
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_flag_activate, (1, 0.5, 0), 1, 0.2, duration);
			}
			var_a6ba4626 = var_a6ba4626 + 4;
		}
		if(isdefined(var_72284260.script_aigroup))
		{
			if(level flag::exists(var_72284260.script_aigroup) && level flag::get(var_72284260.script_aigroup))
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_aigroup, (0, 1, 0), 1, 0.2, duration);
			}
			else
			{
				print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_aigroup, (1, 0.5, 0), 1, 0.2, duration);
			}
			var_a6ba4626 = var_a6ba4626 + 4;
		}
		if(isdefined(var_72284260.script_ent_flag_set))
		{
			print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_ent_flag_set, (1, 1, 1), 1, 0.2, duration);
			var_a6ba4626 = var_a6ba4626 + 4;
		}
		if(isdefined(var_72284260.script_ent_flag_clear))
		{
			print3d(var_72284260.origin + (0, 0, var_a6ba4626), "" + var_72284260.script_ent_flag_clear, (1, 1, 1), 1, 0.2, duration);
			var_a6ba4626 = var_a6ba4626 + 4;
		}
		if(!active)
		{
			return targetstructs;
		}
		if(!isdefined(var_72284260.target) && !isdefined(var_72284260.script_botchain_goal))
		{
			return targetstructs;
		}
		goals = [];
		if(isdefined(var_72284260.target))
		{
			nodes = getnodearray(var_72284260.target, "");
			if(isdefined(nodes) && nodes.size > 0)
			{
				goals = arraycombine(goals, nodes, 0, 0);
			}
		}
		if(isdefined(var_72284260.script_botchain_goal))
		{
			nodes = getnodearray(var_72284260.script_botchain_goal, "");
			if(isdefined(nodes) && nodes.size > 0)
			{
				goals = arraycombine(goals, nodes, 0, 0);
			}
		}
		if(isdefined(var_72284260.target))
		{
			volumes = getentarray(var_72284260.target, "");
			if(isdefined(volumes) && volumes.size > 0)
			{
				goals = arraycombine(goals, volumes, 0, 0);
			}
		}
		if(isdefined(var_72284260.script_botchain_goal))
		{
			volumes = getentarray(var_72284260.script_botchain_goal, "");
			if(isdefined(volumes) && volumes.size > 0)
			{
				goals = arraycombine(goals, volumes, 0, 0);
			}
		}
		if(!goals.size)
		{
			return targetstructs;
		}
		foreach(goal in goals)
		{
			if(ispathnode(goal))
			{
				line(var_72284260.origin, goal.origin, (0, 1, 0), 1, 0, duration);
				nodecolor = (0, 1, 0);
				if(isdefined(goal.radius))
				{
					circle(goal.origin, goal.radius, (0, 1, 0), 0, 1, duration);
				}
				else
				{
					nodecolor = (1, 0, 0);
				}
				box(goal.origin, vectorscale((-1, -1, 0), 16), vectorscale((1, 1, 0), 16), 0, nodecolor, 1, 1, duration);
				continue;
			}
			if(goal.classname === "")
			{
				maxs = goal getmaxs();
				mins = goal getmins();
				box(goal.origin, mins, maxs, 0, (0, 1, 0), 1, 1, duration);
				line(var_72284260.origin, goal.origin, (0, 1, 0), 1, 0, duration);
				continue;
			}
			if(goal.variantname === "")
			{
				if(isdefined(goal.radius))
				{
					searchradius = goal.radius;
				}
				else
				{
					print3d(var_72284260.origin + (0, 0, var_a6ba4626), "", (1, 0, 0), 1, 0.2);
					var_a6ba4626 = var_a6ba4626 + 4;
				}
				circle(goal.origin, searchradius, (0, 1, 0), 0, 1, duration);
				line(var_72284260.origin, goal.origin, (0, 1, 0), 1, 0, duration);
			}
		}
		return targetstructs;
	#/
}

/*
	Name: function_ea764100
	Namespace: bot_chain
	Checksum: 0xD04A6060
	Offset: 0x1390
	Size: 0x2BC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ea764100()
{
	/#
		level.var_40ed3318 = [];
		structs = struct::get_array("", "");
		targetstructs = [];
		duration = 10;
		var_d515e92d = 3000 * 3000;
		while(true)
		{
			waitframe(duration);
			var_b1285611 = getdvarint(#"hash_5bc9f81b4f504592", 0);
			if(!var_b1285611)
			{
				targetstructs = [];
				continue;
			}
			entities = bot::get_bots();
			players = getplayers();
			campos = (0, 0, 0);
			if(players.size > 0)
			{
				campos = players[0].origin;
			}
			foreach(entity in entities)
			{
				if(!isdefined(entity.bot))
				{
					continue;
				}
				if(!isdefined(entity.bot.var_53ffa4c4))
				{
					continue;
				}
				if(isdefined(entity.bot.var_53ffa4c4.var_4de004b7))
				{
					line(entity.origin, entity.bot.var_53ffa4c4.var_4de004b7.origin, (0, 1, 1), 1, 0, duration);
				}
			}
			for(index = 0; index < structs.size; index++)
			{
				if(distance2dsquared(campos, structs[index].origin) <= var_d515e92d)
				{
					targetstructs[index] = function_8ded619(structs[index], targetstructs[index], duration);
				}
			}
		}
	#/
}

/*
	Name: function_e3eaa42b
	Namespace: bot_chain
	Checksum: 0x38FFE78A
	Offset: 0x1658
	Size: 0x170
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e3eaa42b()
{
	structs = struct::get_array("bot_chain", "variantname");
	if(!isdefined(structs))
	{
		return;
	}
	foreach(struct in structs)
	{
		if(isdefined(struct.script_flag_set))
		{
			if(!isdefined(level.flag[struct.script_flag_set]))
			{
				level flag::init(struct.script_flag_set);
			}
		}
		if(isdefined(struct.script_flag_wait))
		{
			if(!isdefined(level.flag[struct.script_flag_wait]))
			{
				level flag::init(struct.script_flag_wait);
			}
		}
		if(isdefined(struct.script_flag_activate))
		{
			if(!isdefined(level.flag[struct.script_flag_activate]))
			{
				level flag::init(struct.script_flag_activate);
			}
		}
	}
}

/*
	Name: function_e7b80b1e
	Namespace: bot_chain
	Checksum: 0x52F9A98B
	Offset: 0x17D0
	Size: 0x44E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e7b80b1e(var_72284260)
{
	self endon(#"hash_382a628dad5ecbb5");
	/#
		assert(isdefined(var_72284260));
	#/
	if(!isdefined(var_72284260.target) && !isdefined(var_72284260.var_6440b5b))
	{
		return undefined;
	}
	structs = [];
	if(isdefined(var_72284260.target))
	{
		var_436fb4d0 = struct::get_array(var_72284260.target);
		if(isdefined(var_436fb4d0) && var_436fb4d0.size)
		{
			structs = arraycombine(structs, var_436fb4d0, 0, 0);
		}
	}
	if(isdefined(var_72284260.var_6440b5b))
	{
		var_436fb4d0 = var_72284260 namespace_2e6206f9::get_target_structs("script_bot_chain");
		if(var_436fb4d0.size > 0)
		{
			structs = arraycombine(structs, var_436fb4d0, 0, 0);
		}
	}
	var_d8bb5bb6 = [];
	foreach(struct in structs)
	{
		if(struct.variantname === "bot_chain")
		{
			array::add(var_d8bb5bb6, struct);
		}
	}
	var_7bc3c842 = [];
	var_653c94ca = [];
	var_fd6be869 = [];
	foreach(struct in var_d8bb5bb6)
	{
		if(!isdefined(struct.script_flag_activate) || level flag::get(struct.script_flag_activate))
		{
			array::add(var_7bc3c842, struct);
		}
		if(isdefined(struct.script_flag_activate) && !level flag::get(struct.script_flag_activate))
		{
			array::add(var_653c94ca, struct);
			array::add(var_fd6be869, struct.script_flag_activate);
		}
	}
	if(var_7bc3c842.size)
	{
		return array::random(var_7bc3c842);
	}
	if(var_653c94ca.size)
	{
		/#
			assert(var_fd6be869.size);
		#/
		level flag::wait_till_any(var_fd6be869);
		foreach(struct in var_653c94ca)
		{
			/#
				assert(isdefined(struct.script_flag_activate));
			#/
			if(level flag::get(struct.script_flag_activate))
			{
				return struct;
			}
		}
	}
	if(var_d8bb5bb6.size > 0)
	{
		return array::random(var_d8bb5bb6);
	}
	return undefined;
}

/*
	Name: function_ea88f102
	Namespace: bot_chain
	Checksum: 0x27503118
	Offset: 0x1C28
	Size: 0x96
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ea88f102(entity, goal)
{
	/#
		assert(isdefined(goal));
	#/
	if(!isdefined(entity.bot.var_53ffa4c4))
	{
		return 0;
	}
	if(isdefined(entity.bot.var_53ffa4c4.var_d1e3e893) && entity.bot.var_53ffa4c4.var_d1e3e893 == goal)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_ce1ee70
	Namespace: bot_chain
	Checksum: 0x6435DED5
	Offset: 0x1CC8
	Size: 0x25A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ce1ee70(goal, bot)
{
	/#
		assert(isdefined(bot));
	#/
	/#
		assert(isdefined(goal));
	#/
	bots = bot bot::get_friendly_bots();
	arrayremovevalue(bots, bot);
	if(!bot.size)
	{
		return 0;
	}
	if(ispathnode(goal))
	{
		foreach(entity in bots)
		{
			if(function_ea88f102(entity, goal))
			{
				return 1;
			}
		}
		return 0;
	}
	if(goal.classname === "info_volume")
	{
		foreach(entity in bots)
		{
			if(function_ea88f102(entity, goal))
			{
				return 1;
			}
		}
		return 0;
	}
	/#
		assert(isvec(goal));
	#/
	foreach(entity in bots)
	{
		if(function_ea88f102(entity, goal))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_c2d874f1
	Namespace: bot_chain
	Checksum: 0x48E58749
	Offset: 0x1F30
	Size: 0x4CA
	Parameters: 2
	Flags: Linked, Private
*/
private function function_c2d874f1(var_72284260, bot)
{
	/#
		assert(isdefined(var_72284260));
	#/
	/#
		assert(isdefined(bot));
	#/
	if(!isdefined(var_72284260.target) && !isdefined(var_72284260.script_botchain_goal))
	{
		return var_72284260;
	}
	/#
		assert(isdefined(var_72284260.target) || isdefined(var_72284260.script_botchain_goal));
	#/
	goals = [];
	if(isdefined(var_72284260.target))
	{
		var_cfc087ec = getnodearray(var_72284260.target, "targetname");
		if(isdefined(var_cfc087ec) && var_cfc087ec.size)
		{
			goals = arraycombine(goals, var_cfc087ec, 0, 0);
		}
	}
	if(isdefined(var_72284260.script_botchain_goal))
	{
		var_cfc087ec = getnodearray(var_72284260.script_botchain_goal, "script_botchain_goal");
		if(isdefined(var_cfc087ec) && var_cfc087ec.size)
		{
			goals = arraycombine(goals, var_cfc087ec, 0, 0);
		}
	}
	if(isdefined(var_72284260.target))
	{
		var_ddf842e8 = getentarray(var_72284260.target, "targetname");
		if(isdefined(var_ddf842e8) && var_ddf842e8.size)
		{
			goals = arraycombine(goals, var_ddf842e8, 0, 0);
		}
	}
	if(isdefined(var_72284260.script_botchain_goal))
	{
		var_ddf842e8 = getentarray(var_72284260.script_botchain_goal, "script_botchain_goal");
		if(isdefined(var_ddf842e8) && var_ddf842e8.size)
		{
			goals = arraycombine(goals, var_ddf842e8, 0, 0);
		}
	}
	if(!goals.size)
	{
		return var_72284260;
	}
	var_1bfc6c1d = [];
	if(isdefined(self.bot.var_53ffa4c4.var_e7ce4106))
	{
		foreach(goal in goals)
		{
			if(isdefined(goal.var_b750799) && goal.var_b750799 == self.bot.var_53ffa4c4.var_e7ce4106)
			{
				array::add(var_1bfc6c1d, goal);
			}
		}
	}
	if(var_1bfc6c1d.size)
	{
		return var_1bfc6c1d;
	}
	var_133e0bbb = [];
	foreach(goal in goals)
	{
		if(function_ce1ee70(goal, bot))
		{
			array::add(var_133e0bbb, goal);
		}
	}
	foreach(goal in var_133e0bbb)
	{
		arrayremovevalue(goals, goal);
	}
	if(goals.size)
	{
		return goals;
	}
	if(var_133e0bbb.size)
	{
		goals = arraycombine(goals, var_133e0bbb, 0, 0);
	}
	return goals;
}

/*
	Name: set_goalradius_based_on_settings
	Namespace: bot_chain
	Checksum: 0xF1A0DBDF
	Offset: 0x2408
	Size: 0xD6
	Parameters: 1
	Flags: Linked, Private
*/
private function set_goalradius_based_on_settings(goal)
{
	/#
		assert(isbot(self) || isvehicle(self));
	#/
	/#
		assert(isdefined(goal));
	#/
	if(isdefined(goal.script_forcegoal) && goal.script_forcegoal)
	{
		return;
	}
	if(spawner::node_has_radius(goal))
	{
		self.goalradius = goal.radius;
	}
	if(isdefined(goal.height))
	{
		self.goalheight = goal.height;
	}
}

/*
	Name: function_95d17a51
	Namespace: bot_chain
	Checksum: 0xB40729D6
	Offset: 0x24E8
	Size: 0x3DA
	Parameters: 1
	Flags: None
*/
function function_95d17a51(startstruct)
{
	structs = array();
	if(isstring(startstruct))
	{
		startstruct = struct::get(startstruct);
		/#
			assert(isdefined(startstruct));
		#/
	}
	assert(isdefined(startstruct) && isstruct(startstruct));
	var_5842dd6c = array();
	targets = array();
	if(isdefined(startstruct.target))
	{
		targets[targets.size] = startstruct.target;
		var_5842dd6c[startstruct.target] = 1;
	}
	structs[structs.size] = startstruct;
	while(targets.size > 0)
	{
		target = targets[0];
		arrayremoveindex(targets, 0);
		targetstructs = struct::get_array(target);
		foreach(struct in targetstructs)
		{
			structs[structs.size] = struct;
			if(isdefined(struct.target) && !isdefined(var_5842dd6c[struct.target]))
			{
				targets[targets.size] = struct.target;
				var_5842dd6c[struct.target] = 1;
			}
		}
	}
	targets = array();
	if(isdefined(startstruct.var_6440b5b))
	{
		targets[targets.size] = startstruct.var_6440b5b;
		var_5842dd6c[startstruct.var_6440b5b] = 1;
	}
	while(targets.size > 0)
	{
		target = targets[0];
		arrayremoveindex(targets, 0);
		targetstructs = struct::get_array(target, "script_bot_chain_target");
		foreach(struct in targetstructs)
		{
			structs[structs.size] = struct;
			if(isdefined(struct.var_6440b5b) && !isdefined(var_5842dd6c[struct.var_6440b5b]))
			{
				targets[targets.size] = struct.var_6440b5b;
				var_5842dd6c[struct.var_6440b5b] = 1;
			}
		}
	}
	return structs;
}

/*
	Name: function_cf70f2fe
	Namespace: bot_chain
	Checksum: 0x888583E2
	Offset: 0x28D0
	Size: 0x70C
	Parameters: 2
	Flags: Linked
*/
function function_cf70f2fe(startstruct, resuming = 0)
{
	/#
		assert(isbot(self));
	#/
	/#
		assert(isdefined(self.bot));
	#/
	if(isstring(startstruct))
	{
		startstruct = struct::get(startstruct);
		/#
			assert(isdefined(startstruct));
		#/
	}
	assert(isdefined(startstruct) && isstruct(startstruct));
	/#
		assert(startstruct.variantname == "");
	#/
	goalent = (self isinvehicle() ? self getvehicleoccupied() : self);
	goalent endon(#"death");
	self endon(#"death");
	self notify(#"hash_382a628dad5ecbb5");
	self endon(#"hash_382a628dad5ecbb5");
	var_e29a9947 = startstruct;
	if(resuming && isdefined(self.bot.var_53ffa4c4))
	{
		var_e29a9947 = self.bot.var_53ffa4c4.startstruct;
	}
	object = new var_92792865();
	[[ object ]]->__constructor();
	self.bot.var_53ffa4c4 = object;
	self.bot.var_53ffa4c4.var_4de004b7 = startstruct;
	self.bot.var_53ffa4c4.startstruct = var_e29a9947;
	for(;;)
	{
		var_4de004b7 = self.bot.var_53ffa4c4.var_4de004b7;
		goals = function_c2d874f1(var_4de004b7, self);
		if(!isdefined(goals))
		{
			break;
		}
		if(isarray(goals))
		{
			goal = array::random(goals);
		}
		else if(goals == var_4de004b7)
		{
			goal = goals;
		}
		if(ispathnode(goal) || isstruct(goal))
		{
			goalent set_goalradius_based_on_settings(goal);
		}
		if(ispathnode(goal))
		{
			goalent setgoal(goal, isdefined(goal.script_forcegoal) && goal.script_forcegoal);
		}
		else if(isstruct(goal))
		{
			goalent setgoal(goal.origin, isdefined(goal.script_forcegoal) && goal.script_forcegoal);
		}
		else
		{
			goalent setgoal(goal);
		}
		self.bot.var_53ffa4c4.var_d1e3e893 = goal;
		goalent waittill(#"goal");
		if(isdefined(var_4de004b7.script_notify))
		{
			self notify(var_4de004b7.script_notify);
		}
		if(isdefined(goal.var_b750799))
		{
			self.bot.var_53ffa4c4.var_e7ce4106 = goal.var_b750799;
		}
		if(isdefined(var_4de004b7.script_flag_set))
		{
			level flag::set(var_4de004b7.script_flag_set);
		}
		if(isdefined(var_4de004b7.script_flag_clear))
		{
			level flag::set(var_4de004b7.script_flag_clear);
		}
		if(isdefined(var_4de004b7.script_ent_flag_set))
		{
			if(!self flag::exists(var_4de004b7.script_ent_flag_set))
			{
				/#
					assertmsg("" + var_4de004b7.script_ent_flag_set + "");
				#/
			}
			self flag::set(var_4de004b7.script_ent_flag_set);
		}
		if(isdefined(var_4de004b7.script_ent_flag_clear))
		{
			if(!self flag::exists(var_4de004b7.script_ent_flag_clear))
			{
				/#
					assertmsg("" + var_4de004b7.script_ent_flag_clear + "");
				#/
			}
			self flag::clear(var_4de004b7.script_ent_flag_clear);
		}
		if(isdefined(var_4de004b7.script_flag_wait))
		{
			level flag::wait_till(var_4de004b7.script_flag_wait);
		}
		if(isdefined(var_4de004b7.script_aigroup))
		{
			if(isdefined(level._ai_group[var_4de004b7.script_aigroup]))
			{
				spawner::waittill_ai_group_cleared(var_4de004b7.script_aigroup);
			}
		}
		var_4de004b7 util::script_delay();
		var_18c2bdb3 = function_e7b80b1e(var_4de004b7);
		/#
			array::add(level.var_40ed3318, var_4de004b7, 0);
		#/
		if(!isdefined(var_18c2bdb3))
		{
			break;
		}
		self.bot.var_53ffa4c4.var_4de004b7 = var_18c2bdb3;
	}
	self function_73d1cfe6();
}

/*
	Name: function_34a84039
	Namespace: bot_chain
	Checksum: 0xA6FC04DC
	Offset: 0x2FE8
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_34a84039()
{
	/#
		assert(isbot(self));
	#/
	if(isdefined(self.bot.var_53ffa4c4) && isdefined(self.bot.var_53ffa4c4.var_4de004b7))
	{
		self thread function_cf70f2fe(self.bot.var_53ffa4c4.var_4de004b7, 1);
	}
}

/*
	Name: function_73d1cfe6
	Namespace: bot_chain
	Checksum: 0x2790A6F4
	Offset: 0x3080
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_73d1cfe6()
{
	/#
		assert(isbot(self));
	#/
	if(isdefined(self.bot.var_53ffa4c4))
	{
		self.bot.var_53ffa4c4 = undefined;
	}
	self notify(#"hash_382a628dad5ecbb5");
}

/*
	Name: function_58b429fb
	Namespace: bot_chain
	Checksum: 0xA9AA5A35
	Offset: 0x30E8
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_58b429fb()
{
	/#
		assert(isbot(self));
	#/
	if(isdefined(self.bot.var_53ffa4c4))
	{
		return 1;
	}
	return 0;
}

