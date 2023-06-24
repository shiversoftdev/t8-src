// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\trials\zm_trial_special_enemy.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\zm_round_spawning.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using script_ab862743b3070a;
#using script_db06eb511bd9b36;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_orange_special_rounds;

/*
	Name: main
	Namespace: zm_orange_special_rounds
	Checksum: 0x8380C992
	Offset: 0x168
	Size: 0x294
	Parameters: 0
	Flags: Linked
*/
function main()
{
	zm_round_spawning::register_archetype(#"zombie_electric", &function_5df3e3dd, &function_c7e59327, &function_27695a82, 5);
	zm_score::function_e5d6e6dd(#"zombie_electric", zombie_utility::function_d2dfacfd(#"zombie_score_kill"));
	zm_cleanup::function_cdf5a512(#"zombie", &function_a2f2a9a3);
	level.var_621701e5 = array(getent("zombie_electric_spawner", "script_noteworthy"));
	array::thread_all(level.var_621701e5, &spawner::add_spawn_function, &zm_behavior::function_57d3b5eb);
	level.var_1c921b2b = 0;
	if(zm_utility::is_classic())
	{
		if(zm_custom::function_901b751c(#"zmpopcornstate") != 0)
		{
			zombie_dog_util::dog_enable_rounds(0);
			level.var_2f14be05 = 15;
			zm_round_spawning::function_376e51ef(#"zombie_dog", level.var_2f14be05);
		}
		level thread function_2eb8970d();
	}
	if(zm_utility::is_trials())
	{
		zm_trial_special_enemy::function_95c1dd81(#"zombie_electric", &function_c7e59327);
		zm_trial_special_enemy::function_95c1dd81(#"zombie_dog", &function_82e6d4e0);
		zm_round_spawning::function_376e51ef(#"zombie_dog", 15);
		level thread function_2eb8970d();
	}
}

/*
	Name: function_2eb8970d
	Namespace: zm_orange_special_rounds
	Checksum: 0x83FC5FAE
	Offset: 0x408
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_2eb8970d()
{
	level waittill(#"power_on2");
	if(zm_custom::function_901b751c(#"zmenhancedstate") != 0)
	{
		zm_round_spawning::function_376e51ef(#"zombie_electric", level.round_number);
	}
}

/*
	Name: function_5df3e3dd
	Namespace: zm_orange_special_rounds
	Checksum: 0x4E6F91CE
	Offset: 0x480
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_5df3e3dd(var_dbce0c44)
{
	var_8cf00d40 = int(floor(var_dbce0c44 / 5));
	if(level.round_number < 20)
	{
		var_ce0732c6 = 0.1;
	}
	else
	{
		if(level.round_number < 30)
		{
			var_ce0732c6 = 0.15;
		}
		else
		{
			var_ce0732c6 = 0.2;
		}
	}
	return min(var_8cf00d40, int(ceil(level.zombie_total * var_ce0732c6)));
}

/*
	Name: function_c6959cf1
	Namespace: zm_orange_special_rounds
	Checksum: 0xD2C23D8D
	Offset: 0x570
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_c6959cf1()
{
	spawner = getent("zombie_electric_spawner", "script_noteworthy");
	return spawner;
}

/*
	Name: function_27695a82
	Namespace: zm_orange_special_rounds
	Checksum: 0xD630DEAD
	Offset: 0x5B0
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_27695a82()
{
	spawner = function_c6959cf1();
	spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
	ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point, level.round_number + level.var_1c921b2b);
	if(isdefined(ai))
	{
		ai thread zm_orange_util::function_865209df(#"electric_zombie", #"hash_73e5e9787832fc70");
	}
	return ai;
}

/*
	Name: function_c7e59327
	Namespace: zm_orange_special_rounds
	Checksum: 0xBC0CE845
	Offset: 0x680
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_c7e59327()
{
	ai = function_27695a82();
	if(isdefined(ai))
	{
		if(!zm_utility::is_trials())
		{
			level.zombie_total--;
		}
		return true;
	}
	return false;
}

/*
	Name: function_82e6d4e0
	Namespace: zm_orange_special_rounds
	Checksum: 0x243F0D3A
	Offset: 0x6E0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_82e6d4e0()
{
	ai = zombie_dog_util::function_62db7b1c();
	if(isdefined(ai))
	{
		return true;
	}
	return false;
}

/*
	Name: function_a2f2a9a3
	Namespace: zm_orange_special_rounds
	Checksum: 0xDA23CA49
	Offset: 0x718
	Size: 0x2A8
	Parameters: 0
	Flags: Linked
*/
function function_a2f2a9a3()
{
	if(self.var_9fde8624 !== #"zombie_electric")
	{
		return false;
	}
	a_s_spawn_locs = level.zm_loc_types[#"zombie_location"];
	var_91562d8c = [];
	var_f2a95155 = [];
	foreach(s_spawn_loc in a_s_spawn_locs)
	{
		if(isdefined(s_spawn_loc.script_noteworthy) && (s_spawn_loc.script_noteworthy == "riser_location" || s_spawn_loc.script_noteworthy == "faller_location"))
		{
			continue;
		}
		if(s_spawn_loc.script_string == "find_flesh")
		{
			if(!isdefined(var_91562d8c))
			{
				var_91562d8c = [];
			}
			else if(!isarray(var_91562d8c))
			{
				var_91562d8c = array(var_91562d8c);
			}
			var_91562d8c[var_91562d8c.size] = s_spawn_loc;
			continue;
		}
		if(!isdefined(var_f2a95155))
		{
			var_f2a95155 = [];
		}
		else if(!isarray(var_f2a95155))
		{
			var_f2a95155 = array(var_f2a95155);
		}
		var_f2a95155[var_f2a95155.size] = s_spawn_loc;
	}
	if(var_91562d8c.size)
	{
		var_d7eff26a = zm_spawner::function_20e7d186(var_91562d8c);
	}
	else
	{
		if(var_f2a95155.size)
		{
			var_d7eff26a = zm_spawner::function_20e7d186(var_f2a95155);
		}
		else
		{
			return false;
		}
	}
	if(isdefined(self) && isentity(self))
	{
		self thread clientfield::set("zm_ai/zombie_electric_fx_clientfield", 0);
		self zm_ai_utility::function_a8dc3363(var_d7eff26a);
		if(isdefined(self))
		{
			self thread clientfield::set("zm_ai/zombie_electric_fx_clientfield", 1);
		}
	}
	return true;
}

