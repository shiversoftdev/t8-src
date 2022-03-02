// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_58c342edd81589fb;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_d129df5c;

/*
	Name: init
	Namespace: namespace_d129df5c
	Checksum: 0x9B1C1C84
	Offset: 0xA0
	Size: 0x27C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(zm_utility::is_standard())
	{
		return;
	}
	if(!isdefined(level.var_9ce0f2a5))
	{
		level.var_9ce0f2a5 = 0;
	}
	if(!isdefined(level.var_9b1fafcf))
	{
		level.var_9b1fafcf = 0;
	}
	if(!isdefined(level.var_4c6c91cf))
	{
		level.var_4c6c91cf = 0;
	}
	level.var_95c10956 = &function_a0488ba8;
	level flag::init(#"flag_gegenees_set_intro");
	level flag::init(#"flag_skeleton_set_intro");
	namespace_c3287616::function_cc103b38(#"catalyst", 7);
	namespace_c3287616::function_cc103b38(#"blight_father", 14);
	namespace_c3287616::function_2876740e(#"catalyst", &function_2ffc8cca);
	namespace_c3287616::function_2876740e(#"blight_father", &function_ec882ff);
	namespace_c3287616::function_2876740e(#"gegenees", &function_57fd9735);
	namespace_c3287616::function_306ce518(#"blight_father", &function_fa00e485);
	namespace_c3287616::function_306ce518(#"gegenees", &function_c1a0ea97);
	level thread function_6957c745(#"skeleton", 8, #"flag_skeleton_set_intro");
	level thread function_6957c745(#"gegenees", 12, #"flag_gegenees_set_intro");
	level thread function_990c303a();
}

/*
	Name: function_fa00e485
	Namespace: namespace_d129df5c
	Checksum: 0xA21BB2C9
	Offset: 0x328
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_fa00e485(n_round_number)
{
	level endon(#"end_game");
	while(true)
	{
		level waittill(#"hash_5d3012139f083ccb");
		if(namespace_c3287616::function_d0db51fc(#"blight_father") && (!(isdefined(level.var_153e9058) && level.var_153e9058)))
		{
			if(isdefined(level.var_9ce0f2a5))
			{
				level.var_9ce0f2a5 = level.round_number + function_21a3a673(4, 6);
			}
		}
	}
}

/*
	Name: function_c1a0ea97
	Namespace: namespace_d129df5c
	Checksum: 0x392A401F
	Offset: 0x400
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_c1a0ea97(n_round_number)
{
	level endon(#"end_game");
	while(true)
	{
		level waittill(#"hash_5d3012139f083ccb");
		if(namespace_c3287616::function_d0db51fc(#"gegenees") && (!(isdefined(level.var_153e9058) && level.var_153e9058)))
		{
			if(isdefined(level.var_9ce0f2a5))
			{
				level.var_9ce0f2a5 = level.round_number + function_21a3a673(4, 6);
			}
		}
	}
}

/*
	Name: function_990c303a
	Namespace: namespace_d129df5c
	Checksum: 0x8CF4193D
	Offset: 0x4D8
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function function_990c303a()
{
	level endon(#"end_game");
	while(true)
	{
		level waittill(#"end_of_round");
		level.var_4c6c91cf = 0;
		if(level.players.size == 1)
		{
			level.var_9b1fafcf = 1;
		}
		else
		{
			if(level.round_number <= 10)
			{
				level.var_9b1fafcf = 1;
			}
			else
			{
				if(level.round_number <= 17)
				{
					level.var_9b1fafcf = 2;
				}
				else
				{
					level.var_9b1fafcf = 3;
				}
			}
		}
	}
}

/*
	Name: function_2ffc8cca
	Namespace: namespace_d129df5c
	Checksum: 0x9A349D3C
	Offset: 0x5B0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_2ffc8cca(n_max)
{
	return int(n_max * 0.4);
}

/*
	Name: function_ec882ff
	Namespace: namespace_d129df5c
	Checksum: 0xD48EE40D
	Offset: 0x5E8
	Size: 0x13E
	Parameters: 1
	Flags: Linked
*/
function function_ec882ff(n_max)
{
	if(isdefined(level.var_9ce0f2a5))
	{
		if(level.round_number < level.var_9ce0f2a5)
		{
			return 0;
		}
	}
	if(randomint(100) > 25)
	{
		return 0;
	}
	if(level.players.size == 1)
	{
		var_1797c23a = 1;
	}
	else
	{
		if(level.round_number <= 10)
		{
			var_1797c23a = 1;
		}
		else
		{
			if(level.round_number <= 17)
			{
				var_1797c23a = 2;
			}
			else
			{
				var_1797c23a = 3;
			}
		}
	}
	var_2506688 = 1;
	n_num_to_spawn = function_21a3a673(int(var_2506688), var_1797c23a);
	if(level.var_4c6c91cf < level.var_9b1fafcf)
	{
		level.var_4c6c91cf = level.var_4c6c91cf + n_num_to_spawn;
		return n_num_to_spawn;
	}
	return 0;
}

/*
	Name: function_57fd9735
	Namespace: namespace_d129df5c
	Checksum: 0x5C2D1D21
	Offset: 0x730
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_57fd9735(n_max)
{
	if(isdefined(level.var_9ce0f2a5))
	{
		if(level.round_number < level.var_9ce0f2a5)
		{
			return 0;
		}
	}
	if(level.players.size == 1)
	{
		var_1797c23a = 1;
	}
	else
	{
		if(level.round_number <= 10)
		{
			var_1797c23a = 1;
		}
		else
		{
			if(level.round_number <= 17)
			{
				var_1797c23a = 2;
			}
			else
			{
				var_1797c23a = 3;
			}
		}
	}
	var_2506688 = 1;
	n_num_to_spawn = function_21a3a673(int(var_2506688), var_1797c23a);
	if(level.var_4c6c91cf < level.var_9b1fafcf)
	{
		level.var_4c6c91cf = level.var_4c6c91cf + n_num_to_spawn;
		return n_num_to_spawn;
	}
	return 0;
}

/*
	Name: function_6957c745
	Namespace: namespace_d129df5c
	Checksum: 0x855E5226
	Offset: 0x858
	Size: 0x84
	Parameters: 3
	Flags: Linked
*/
function function_6957c745(str_archetype, n_round, var_b2239dab)
{
	if(isdefined(var_b2239dab))
	{
		level thread function_36c1dcca(n_round, var_b2239dab);
		level flag::wait_till(var_b2239dab);
		n_round = level.round_number;
	}
	namespace_c3287616::function_376e51ef(str_archetype, n_round);
}

/*
	Name: function_36c1dcca
	Namespace: namespace_d129df5c
	Checksum: 0x8CB8A985
	Offset: 0x8E8
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_36c1dcca(n_round, var_b2239dab)
{
	level endon(#"end_game", var_b2239dab);
	while(level.round_number < n_round)
	{
		level waittill(#"end_of_round");
	}
	level flag::set(var_b2239dab);
}

/*
	Name: function_a0488ba8
	Namespace: namespace_d129df5c
	Checksum: 0x9EB93800
	Offset: 0x968
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_a0488ba8()
{
	var_2b198109 = getaiarray();
	var_a128313 = 0;
	foreach(e_zombie in var_2b198109)
	{
		if(isalive(e_zombie) && (isdefined(e_zombie.archetype) && isinarray(array(#"blight_father", #"brutus", #"gegenees"), e_zombie.archetype)))
		{
			var_a128313++;
		}
	}
	if(isarray(level.var_b175714d) && isdefined(level.var_b175714d[#"blight_father"]) && isdefined(level.var_b175714d[#"blight_father"].var_33e393a7))
	{
		var_a128313 = var_a128313 + level.var_b175714d[#"blight_father"].var_33e393a7;
	}
	return var_a128313;
}

