// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_3f9e0dc8454d98e1;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_b43e152a;

/*
	Name: function_89f2df9
	Namespace: namespace_b43e152a
	Checksum: 0xE63E7A3B
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_77f93374658c46e4", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b43e152a
	Checksum: 0xB9145C3A
	Offset: 0x108
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_10949a7065d076ef", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_b43e152a
	Checksum: 0xF9D894A
	Offset: 0x170
	Size: 0x144
	Parameters: 8
	Flags: Private
*/
private function function_d1de6a85(n_max_zombies, var_2ec39966, str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9, var_a7a5a6ef)
{
	level endon(#"hash_7646638df88a3656");
	a_str_zones = array(str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9, var_a7a5a6ef);
	arrayremovevalue(a_str_zones, undefined);
	if(isdefined(n_max_zombies))
	{
		n_max_zombies = namespace_f551babc::function_5769f26a(n_max_zombies);
	}
	wait(5);
	if(isdefined(var_2ec39966))
	{
		self.var_2ec39966 = var_2ec39966;
		zm_utility::function_75fd65f9(self.var_2ec39966, 1);
	}
	/#
		assert(a_str_zones.size, "");
	#/
	level thread function_65e6d40c(a_str_zones, n_max_zombies);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_b43e152a
	Checksum: 0x3B5DA61E
	Offset: 0x2C0
	Size: 0x4E
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	namespace_b22c99a5::function_f3dbeda7();
	if(isdefined(self.var_2ec39966))
	{
		zm_utility::function_b1f3be5c(undefined, self.var_2ec39966);
		self.var_2ec39966 = undefined;
	}
}

/*
	Name: function_65e6d40c
	Namespace: namespace_b43e152a
	Checksum: 0xFC0F7DF6
	Offset: 0x318
	Size: 0x310
	Parameters: 2
	Flags: Private
*/
private function function_65e6d40c(a_str_zones, n_max_zombies = 0)
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	level waittill(#"zombie_total_set");
	a_s_locs = zm_utility::function_9f7fd525("zombie_location", a_str_zones, 0);
	foreach(s_loc in a_s_locs)
	{
		if(level.zombie_total > 0)
		{
			ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined, s_loc);
			if(isdefined(ai))
			{
				ai.b_ignore_cleanup = 1;
				ai.var_45cec07d = 1;
				level.zombie_total--;
				util::wait_network_frame();
			}
		}
	}
	while(true)
	{
		a_ai_enemies = getaiteamarray(level.zombie_team);
		var_d1d851f3 = 0;
		foreach(ai in a_ai_enemies)
		{
			if(isalive(ai) && (isdefined(ai.completed_emerging_into_playable_area) && ai.completed_emerging_into_playable_area))
			{
				str_zone_name = ai zm_utility::get_current_zone();
				if(isdefined(str_zone_name) && isinarray(a_str_zones, hash(str_zone_name)))
				{
					var_d1d851f3++;
				}
			}
			if(n_max_zombies > 0)
			{
				namespace_b22c99a5::function_dace284(var_d1d851f3, 1);
				namespace_b22c99a5::function_2976fa44(n_max_zombies + 1);
			}
			if(var_d1d851f3 > n_max_zombies)
			{
				namespace_f551babc::fail(#"hash_622e72c9731cca58");
				return;
			}
		}
		wait(0.5);
	}
}

