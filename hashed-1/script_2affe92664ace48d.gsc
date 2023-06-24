// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\ai\zm_ai_tiger.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\trials\zm_trial_add_special.gsc;
#using scripts\zm_common\zm_round_spawning.gsc;
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using scripts\core_common\ai\archetype_tiger.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zombie_tiger_util;

/*
	Name: __init__system__
	Namespace: zombie_tiger_util
	Checksum: 0x3F99401F
	Offset: 0x140
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zombie_tiger_util", &__init__, &__main__, #"zm_ai_tiger");
}

/*
	Name: __init__
	Namespace: zombie_tiger_util
	Checksum: 0x61F94A66
	Offset: 0x1A0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_4ead8122 = getentarray("zombie_tiger_spawner", "script_noteworthy");
	if(level.var_4ead8122.size == 0)
	{
		/#
			assertmsg("");
		#/
		return;
	}
	zm_round_spawning::register_archetype(#"tiger", &function_235d0eb6, &round_spawn, &spawn_single, 25);
}

/*
	Name: __main__
	Namespace: zombie_tiger_util
	Checksum: 0x8288F6F7
	Offset: 0x260
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	zm_score::function_e5d6e6dd(#"tiger", level.var_4ead8122[0] ai::function_9139c839().var_7a715ab5);
	spawner::add_archetype_spawn_function(#"tiger", &function_fe4c8547);
}

/*
	Name: function_fe4c8547
	Namespace: zombie_tiger_util
	Checksum: 0xE65FA07
	Offset: 0x2E8
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_fe4c8547()
{
	self thread function_94c9b195();
	var_1751372a = zm_ai_utility::function_8d44707e(0);
	var_1751372a = var_1751372a * (isdefined(level.var_1eb98fb1) ? level.var_1eb98fb1 : 1);
	var_1751372a = int(var_1751372a);
	self.health = var_1751372a;
	self.maxhealth = var_1751372a;
	self zm_score::function_82732ced();
}

/*
	Name: spawn_single
	Namespace: zombie_tiger_util
	Checksum: 0x1C76925C
	Offset: 0x3A0
	Size: 0x1E8
	Parameters: 2
	Flags: Linked
*/
function spawn_single(b_force_spawn = 0, var_eb3a8721)
{
	if(!b_force_spawn && !function_66cfd7d())
	{
		return undefined;
	}
	players = getplayers();
	if(isdefined(var_eb3a8721))
	{
		s_spawn_loc = var_eb3a8721;
	}
	else
	{
		if(isdefined(level.var_fcde6b4))
		{
			s_spawn_loc = [[level.var_fcde6b4]]();
		}
		else if(level.zm_loc_types[#"tiger_location"].size > 0)
		{
			s_spawn_loc = array::random(level.zm_loc_types[#"tiger_location"]);
		}
	}
	if(!isdefined(s_spawn_loc))
	{
		return undefined;
	}
	ai = zombie_utility::spawn_zombie(level.var_4ead8122[0], "tiger");
	if(isdefined(ai))
	{
		ai.script_string = s_spawn_loc.script_string;
		ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		if(isdefined(level.var_262798e2))
		{
			ai thread [[level.var_262798e2]](s_spawn_loc);
		}
	}
	return ai;
}

/*
	Name: function_66cfd7d
	Namespace: zombie_tiger_util
	Checksum: 0x7BEC0D6F
	Offset: 0x590
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_66cfd7d()
{
	var_6ecc1639 = function_ba8172ca();
	var_b3c0e90e = function_cbfb0da4();
	if(var_6ecc1639 >= var_b3c0e90e || !level flag::get("spawn_zombies") || (isdefined(level.var_5e45f817) && level.var_5e45f817))
	{
		return false;
	}
	return true;
}

/*
	Name: function_cbfb0da4
	Namespace: zombie_tiger_util
	Checksum: 0xA22240BC
	Offset: 0x638
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_cbfb0da4()
{
	n_player_count = zm_utility::function_a2541519(getplayers().size);
	switch(n_player_count)
	{
		case 1:
		{
			var_ed61bfaa = 3;
			break;
		}
		case 2:
		{
			var_ed61bfaa = 5;
			break;
		}
		case 3:
		{
			var_ed61bfaa = 7;
			break;
		}
		default:
		{
			var_ed61bfaa = 10;
			break;
		}
	}
	if(zm_trial_add_special::is_active(#"tiger"))
	{
		var_ed61bfaa = var_ed61bfaa * 4;
	}
	return var_ed61bfaa;
}

/*
	Name: function_ba8172ca
	Namespace: zombie_tiger_util
	Checksum: 0x4779DA8C
	Offset: 0x738
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_ba8172ca()
{
	var_cf9c1780 = getaiarchetypearray(#"tiger");
	var_6ecc1639 = var_cf9c1780.size;
	foreach(ai_tiger in var_cf9c1780)
	{
		if(!isalive(ai_tiger))
		{
			var_6ecc1639--;
		}
	}
	return var_6ecc1639;
}

/*
	Name: function_ffa01525
	Namespace: zombie_tiger_util
	Checksum: 0xCB62AB7E
	Offset: 0x800
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_ffa01525()
{
	n_player_count = zm_utility::function_a2541519(level.players.size);
	switch(n_player_count)
	{
		case 1:
		{
			n_default_wait = 1;
			break;
		}
		case 2:
		{
			n_default_wait = 0.75;
			break;
		}
		case 3:
		{
			n_default_wait = 0.5;
			break;
		}
		default:
		{
			n_default_wait = 0.25;
			break;
		}
	}
	wait(n_default_wait);
}

/*
	Name: function_94c9b195
	Namespace: zombie_tiger_util
	Checksum: 0x4FD8C79D
	Offset: 0x8D8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_94c9b195()
{
	self endon(#"death");
	if(level flag::get("special_round"))
	{
		self ai::set_behavior_attribute("sprint", 1);
	}
}

/*
	Name: function_235d0eb6
	Namespace: zombie_tiger_util
	Checksum: 0xA4DA1771
	Offset: 0x938
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function function_235d0eb6(var_dbce0c44)
{
	if(isdefined(level.var_5e45f817) && level.var_5e45f817)
	{
		return 0;
	}
	var_8cf00d40 = int(floor(var_dbce0c44 / 25));
	var_a1737466 = randomfloatrange(0.08, 0.12);
	return min(var_8cf00d40, int(level.zombie_total * var_a1737466));
}

/*
	Name: round_spawn
	Namespace: zombie_tiger_util
	Checksum: 0x4E3B861D
	Offset: 0xA08
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function round_spawn()
{
	ai = spawn_single();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return true;
	}
	return false;
}

