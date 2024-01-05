// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\powerup\zm_powerup_nuke.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_round_spawning.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_2c5daa95f8fec03c;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai_shared.gsc;

#namespace zombie_gladiator_util;

/*
	Name: __init__system__
	Namespace: zombie_gladiator_util
	Checksum: 0x6E817A6A
	Offset: 0x1B8
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zombie_gladiator_util", &__init__, &__main__, #"zm_ai_gladiator");
}

/*
	Name: __init__
	Namespace: zombie_gladiator_util
	Checksum: 0x616FDDFA
	Offset: 0x218
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_fc0d2372 = getentarray("zombie_gladiator_destroyer_spawner", "script_noteworthy");
	level.var_735451fc = getentarray("zombie_gladiator_marauder_spawner", "script_noteworthy");
	level.var_4d136b9a = arraycombine(level.var_fc0d2372, level.var_735451fc, 0, 0);
	level.var_7e0bfb6 = 0;
	zm_round_spawning::register_archetype(#"gladiator_destroyer", &function_c251d29f, &function_bb067153, &function_2efc00db, 225);
	zm_round_spawning::register_archetype(#"gladiator_marauder", &function_c251d29f, &function_60e6998a, &function_c9cd31, 75);
}

/*
	Name: __main__
	Namespace: zombie_gladiator_util
	Checksum: 0x55B3175C
	Offset: 0x360
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	spawner::add_archetype_spawn_function(#"gladiator", &function_8c0ab720);
	zm_score::function_e5d6e6dd(#"gladiator", level.var_fc0d2372[0] ai::function_9139c839().var_1aa4e66a);
}

/*
	Name: function_8c0ab720
	Namespace: zombie_gladiator_util
	Checksum: 0x8C228105
	Offset: 0x3E8
	Size: 0x1C4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8c0ab720()
{
	n_hp = zm_ai_utility::function_8d44707e(1) * (isdefined(level.var_1b0cc4f5) ? level.var_1b0cc4f5 : 1);
	if(self.var_9fde8624 == #"gladiator_marauder")
	{
		n_hp = n_hp * 0.7;
		self.var_17a22c08 = 150;
		self playsound(#"zmb_ai_gladiator_spawn_mar");
	}
	else
	{
		self playsound(#"zmb_ai_gladiator_spawn_des");
	}
	self.health = int(n_hp);
	self.maxhealth = int(n_hp);
	self.should_zigzag = 1;
	self zm_powerup_nuke::function_9a79647b(0.5);
	self zm_score::function_82732ced();
	if(self.var_9fde8624 == #"gladiator_destroyer")
	{
		namespace_81245006::initweakpoints(self, "c_t8_zmb_gladiator_dst_weakpoint_def");
	}
	else if(self.var_9fde8624 == #"gladiator_marauder")
	{
		namespace_81245006::initweakpoints(self, "c_t8_zmb_gladiator_mar_weakpoint_def");
	}
	self thread vo();
}

/*
	Name: vo
	Namespace: zombie_gladiator_util
	Checksum: 0xECE4F163
	Offset: 0x5B8
	Size: 0x196
	Parameters: 0
	Flags: Linked
*/
function vo()
{
	self endon(#"death");
	e_enemy = undefined;
	a_vo = zm_audio::get_valid_lines(#"hash_76d06b092be0a0de");
	wait(15);
	while(true)
	{
		function_c03b6f46(90000, 640000);
		e_enemy = self.enemy;
		wait(randomfloatrange(2, 4));
		function_c03b6f46(90000, 640000);
		if(self.enemy === e_enemy && !level.var_7e0bfb6)
		{
			level.var_7e0bfb6 = 1;
			line = array::random(a_vo);
			if(zm_vo::vo_say(line))
			{
				arrayremovevalue(a_vo, line);
				if(!a_vo.size)
				{
					return;
				}
			}
		}
		wait(randomfloatrange(40, 80));
		level.var_7e0bfb6 = 0;
	}
}

/*
	Name: function_c03b6f46
	Namespace: zombie_gladiator_util
	Checksum: 0x357953B6
	Offset: 0x758
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_c03b6f46(n_min_dist_sq, n_max_dist_sq)
{
	self endon(#"death");
	while(true)
	{
		wait(randomfloatrange(0.6666666, 1.333333));
		if(zm_utility::is_player_valid(self.enemy))
		{
			n_dist_sq = distance2dsquared(self.origin, self.enemy.origin);
			if(n_dist_sq > n_min_dist_sq && n_dist_sq < n_max_dist_sq)
			{
				break;
			}
		}
		else
		{
			continue;
		}
	}
}

/*
	Name: function_bfa79e98
	Namespace: zombie_gladiator_util
	Checksum: 0x45B77A5A
	Offset: 0x830
	Size: 0x140
	Parameters: 4
	Flags: Linked
*/
function function_bfa79e98(sp_spawner = level.var_4d136b9a[0], s_spot, str_type, n_round)
{
	if(isdefined(str_type))
	{
		switch(str_type)
		{
			case "melee":
			{
				sp_spawner = level.var_735451fc[0];
				break;
			}
			case "ranged":
			{
				sp_spawner = level.var_fc0d2372[0];
				break;
			}
		}
	}
	ai = zombie_utility::spawn_zombie(sp_spawner, "gladiator", s_spot, n_round);
	if(isdefined(ai))
	{
		if(isdefined(s_spot))
		{
			ai.script_string = s_spot.script_string;
			ai.find_flesh_struct_string = s_spot.find_flesh_struct_string;
		}
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
	}
	return ai;
}

/*
	Name: function_69f309b
	Namespace: zombie_gladiator_util
	Checksum: 0xC45B8545
	Offset: 0x978
	Size: 0x294
	Parameters: 6
	Flags: Linked
*/
function function_69f309b(n_to_spawn = 1, str_type = array::random(level.var_4d136b9a), var_1fafa3fc, b_force_spawn = 0, var_eb3a8721 = undefined, n_round)
{
	n_spawned = 0;
	while(n_spawned < n_to_spawn)
	{
		if(!b_force_spawn && !function_e4d7ae2b())
		{
			return n_spawned;
		}
		players = getplayers();
		if(isdefined(var_eb3a8721))
		{
			s_spawn_loc = var_eb3a8721;
		}
		else
		{
			if(isdefined(level.var_14961f90) && level flag::get("special_round"))
			{
				s_spawn_loc = [[level.var_14961f90]](gladiator_spawner);
			}
			else if(isdefined(level.zm_loc_types[#"gladiator_location"]) && level.zm_loc_types[#"gladiator_location"].size)
			{
				s_spawn_loc = array::random(level.zm_loc_types[#"gladiator_location"]);
			}
		}
		if(!isdefined(s_spawn_loc))
		{
			return 0;
		}
		ai = function_bfa79e98(gladiator_spawner, s_spawn_loc, str_type, n_round);
		if(isdefined(ai))
		{
			ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
			ai.script_string = s_spawn_loc.script_string;
			ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
			n_spawned++;
			if(isdefined(var_1fafa3fc))
			{
				ai thread [[var_1fafa3fc]](s_spawn_loc);
			}
		}
		function_5d0001ad();
	}
	return 1;
}

/*
	Name: function_2efc00db
	Namespace: zombie_gladiator_util
	Checksum: 0xBADB79F5
	Offset: 0xC18
	Size: 0x208
	Parameters: 2
	Flags: Linked
*/
function function_2efc00db(b_force_spawn = 0, var_eb3a8721)
{
	if(!b_force_spawn && !function_e4d7ae2b())
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
		if(isdefined(level.var_14961f90))
		{
			s_spawn_loc = [[level.var_14961f90]]();
		}
		else if(isdefined(level.zm_loc_types[#"gladiator_location"]) && level.zm_loc_types[#"gladiator_location"].size)
		{
			s_spawn_loc = array::random(level.zm_loc_types[#"gladiator_location"]);
		}
	}
	if(!isdefined(s_spawn_loc))
	{
		return undefined;
	}
	ai = zombie_utility::spawn_zombie(level.var_fc0d2372[0], "gladiator");
	if(isdefined(ai))
	{
		ai.script_string = s_spawn_loc.script_string;
		ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		if(isdefined(level.var_290ac2c3))
		{
			ai thread [[level.var_290ac2c3]](s_spawn_loc);
		}
	}
	return ai;
}

/*
	Name: function_c9cd31
	Namespace: zombie_gladiator_util
	Checksum: 0xF976C6C7
	Offset: 0xE28
	Size: 0x208
	Parameters: 2
	Flags: Linked
*/
function function_c9cd31(b_force_spawn = 0, var_eb3a8721)
{
	if(!b_force_spawn && !function_e4d7ae2b())
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
		if(isdefined(level.var_14961f90))
		{
			s_spawn_loc = [[level.var_14961f90]]();
		}
		else if(isdefined(level.zm_loc_types[#"gladiator_location"]) && level.zm_loc_types[#"gladiator_location"].size)
		{
			s_spawn_loc = array::random(level.zm_loc_types[#"gladiator_location"]);
		}
	}
	if(!isdefined(s_spawn_loc))
	{
		return undefined;
	}
	ai = zombie_utility::spawn_zombie(level.var_735451fc[0], "gladiator");
	if(isdefined(ai))
	{
		ai.script_string = s_spawn_loc.script_string;
		ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		if(isdefined(level.var_290ac2c3))
		{
			ai thread [[level.var_290ac2c3]](s_spawn_loc);
		}
	}
	return ai;
}

/*
	Name: function_e4d7ae2b
	Namespace: zombie_gladiator_util
	Checksum: 0x826EED7C
	Offset: 0x1038
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_e4d7ae2b()
{
	var_3e8b490d = function_78913059();
	var_10833f75 = function_45876e23();
	if(!(isdefined(level.var_76934955) && level.var_76934955) && (isdefined(level.var_fe2bb2ac) && level.var_fe2bb2ac || var_3e8b490d >= var_10833f75 || !level flag::get("spawn_zombies")))
	{
		return false;
	}
	return true;
}

/*
	Name: function_78913059
	Namespace: zombie_gladiator_util
	Checksum: 0x1F9916F9
	Offset: 0x1100
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_78913059()
{
	var_80074df6 = getaiarchetypearray(#"gladiator");
	var_3e8b490d = var_80074df6.size;
	foreach(ai in var_80074df6)
	{
		if(!isalive(ai))
		{
			var_3e8b490d--;
		}
	}
	return var_3e8b490d;
}

/*
	Name: function_5d0001ad
	Namespace: zombie_gladiator_util
	Checksum: 0x7A5E090
	Offset: 0x11C8
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function function_5d0001ad()
{
	n_player_count = zm_utility::function_a2541519(level.players.size);
	switch(n_player_count)
	{
		case 1:
		{
			n_default_wait = 8;
			break;
		}
		case 2:
		{
			n_default_wait = 5;
			break;
		}
		case 3:
		{
			n_default_wait = 3;
			break;
		}
		default:
		{
			n_default_wait = 1;
			break;
		}
	}
	wait(n_default_wait);
}

/*
	Name: function_45876e23
	Namespace: zombie_gladiator_util
	Checksum: 0xEB131394
	Offset: 0x1290
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function function_45876e23()
{
	n_player_count = zm_utility::function_a2541519(level.players.size);
	switch(n_player_count)
	{
		case 1:
		{
			return 3;
			break;
		}
		case 2:
		{
			return 4;
			break;
		}
		case 3:
		{
			return 5;
			break;
		}
		default:
		{
			return 6;
			break;
		}
	}
}

/*
	Name: function_c251d29f
	Namespace: zombie_gladiator_util
	Checksum: 0x2F2E92E3
	Offset: 0x1348
	Size: 0x1C2
	Parameters: 1
	Flags: Linked
*/
function function_c251d29f(var_dbce0c44)
{
	var_8cf00d40 = int(floor(var_dbce0c44 / 225));
	if(!isdefined(level.var_15aa32df))
	{
		level.var_15aa32df = 8;
	}
	n_player_count = zm_utility::function_a2541519(level.players.size);
	if(n_player_count == 1)
	{
		var_1797c23a = 1 + (max(0, floor((level.round_number - level.var_15aa32df) / 4)));
	}
	else
	{
		var_1797c23a = 1 + (max(0, floor((level.round_number - level.var_15aa32df) / 3)));
	}
	var_2506688 = (var_1797c23a > 8 ? var_1797c23a * 0.75 : max(var_1797c23a - 3, 0));
	return function_21a3a673(int(var_2506688), int(min(var_8cf00d40, var_1797c23a)));
}

/*
	Name: function_60e6998a
	Namespace: zombie_gladiator_util
	Checksum: 0x3CC33ADD
	Offset: 0x1518
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_60e6998a()
{
	ai = function_c9cd31();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return true;
	}
	return false;
}

/*
	Name: function_bb067153
	Namespace: zombie_gladiator_util
	Checksum: 0x8776E33B
	Offset: 0x1560
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_bb067153()
{
	ai = function_2efc00db();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return true;
	}
	return false;
}

