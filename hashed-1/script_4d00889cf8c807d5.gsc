// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3657077a08b7f19e;
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_7e59d7bba853fe4b;
#using script_db06eb511bd9b36;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_bc12435c;

/*
	Name: function_89f2df9
	Namespace: namespace_bc12435c
	Checksum: 0x56488435
	Offset: 0x1B0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_381a5b2deb7adc74", &__init__, undefined, #"hash_36b936ddd622fccf");
}

/*
	Name: __init__
	Namespace: namespace_bc12435c
	Checksum: 0xF22766C8
	Offset: 0x200
	Size: 0x296
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	level.var_edd123b1 = &function_d325f6a4;
	zm_score::function_e5d6e6dd(#"skeleton", 60);
	if(zm_utility::is_standard())
	{
		namespace_c3287616::register_archetype(#"skeleton", &function_cf877849, &round_spawn, &function_1ea880bd, 5);
	}
	else
	{
		namespace_c3287616::register_archetype(#"skeleton", &function_cf877849, &round_spawn, &function_1ea880bd, 25);
	}
	zm_cleanup::function_cdf5a512(#"skeleton", &function_ad4293a8);
	namespace_32192f7::function_95c1dd81(#"skeleton", &function_8609d56e);
	level.var_5fc2833 = getentarray("zombie_skeleton_spawner", "script_noteworthy");
	level.var_7b7fd31e = getentarray("zombie_skeleton_spear_spawner", "script_noteworthy");
	level.var_ea48e91 = getentarray("zombie_skeleton_helmet_spawner", "script_noteworthy");
	level.var_c34db86 = getentarray("zombie_skeleton_helmet_spear_spawner", "script_noteworthy");
	level.var_5781a278 = arraycombine(level.var_5fc2833, level.var_7b7fd31e, 0, 0);
	level.var_5781a278 = arraycombine(level.var_5781a278, level.var_ea48e91, 0, 0);
	level.var_5781a278 = arraycombine(level.var_5781a278, level.var_c34db86, 0, 0);
}

/*
	Name: function_cf877849
	Namespace: namespace_bc12435c
	Checksum: 0xC05A246E
	Offset: 0x4A0
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function function_cf877849(var_dbce0c44)
{
	if(zm_utility::is_standard())
	{
		var_8cf00d40 = int(floor(var_dbce0c44 / 25));
		var_a1737466 = randomfloatrange(0.35, 0.45);
	}
	else
	{
		var_8cf00d40 = int(floor(var_dbce0c44 / 25));
		var_a1737466 = randomfloatrange(0.08, 0.12);
	}
	return min(var_8cf00d40, int(level.zombie_total * var_a1737466));
}

/*
	Name: round_spawn
	Namespace: namespace_bc12435c
	Checksum: 0xE9ABC68B
	Offset: 0x5B0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function round_spawn()
{
	ai = function_1ea880bd();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return 1;
	}
	return 0;
}

/*
	Name: function_8609d56e
	Namespace: namespace_bc12435c
	Checksum: 0x5CA6E145
	Offset: 0x5F8
	Size: 0x2A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_8609d56e()
{
	var_8739be3d = function_1ea880bd(1);
	return isdefined(var_8739be3d);
}

/*
	Name: function_1ea880bd
	Namespace: namespace_bc12435c
	Checksum: 0xDD0A0993
	Offset: 0x630
	Size: 0x310
	Parameters: 5
	Flags: Linked
*/
function function_1ea880bd(b_force_spawn = 0, var_eb3a8721, round_number, b_spear, b_helmet)
{
	if(!b_force_spawn && !function_bdd7ec59())
	{
		return undefined;
	}
	players = getplayers();
	if(isdefined(var_eb3a8721))
	{
		s_spawn_loc = var_eb3a8721;
	}
	else if(isdefined(level.var_edd123b1))
	{
		s_spawn_loc = [[level.var_edd123b1]]();
	}
	else if(isarray(level.zm_loc_types) && level.zm_loc_types[#"zombie_location"].size > 0)
	{
		a_s_spawn_locs = function_3ce1516d(level.zm_loc_types[#"zombie_location"]);
		s_spawn_loc = array::random(a_s_spawn_locs);
	}
	if(!isdefined(s_spawn_loc))
	{
		return undefined;
	}
	if(!isdefined(b_spear))
	{
		b_spear = math::cointoss();
	}
	if(!isdefined(b_helmet))
	{
		b_helmet = math::cointoss();
	}
	if(b_spear)
	{
		if(b_helmet)
		{
			var_5fc2833 = level.var_c34db86;
		}
		else
		{
			var_5fc2833 = level.var_7b7fd31e;
		}
	}
	else if(b_helmet)
	{
		var_5fc2833 = level.var_ea48e91;
	}
	else
	{
		var_5fc2833 = level.var_5fc2833;
	}
	ai = zombie_utility::spawn_zombie(array::random(var_5fc2833), undefined, undefined, round_number);
	if(isdefined(ai))
	{
		if(!b_spear)
		{
			ai.var_4e9f7942 = 1;
		}
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		if(isdefined(level.var_1a540a38))
		{
			ai thread [[level.var_1a540a38]](s_spawn_loc);
		}
		var_46d2ec35 = get_favorite_enemy();
		if(isdefined(var_46d2ec35))
		{
			ai.favoriteenemy = var_46d2ec35;
			ai.favoriteenemy.hunted_by++;
		}
	}
	return ai;
}

/*
	Name: function_bdd7ec59
	Namespace: namespace_bc12435c
	Checksum: 0x241349AE
	Offset: 0x948
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function function_bdd7ec59()
{
	var_14bd36c2 = function_331e9312();
	var_f11e475c = function_d3195b0c();
	if(!(isdefined(level.var_4a03b294) && level.var_4a03b294) && (isdefined(level.var_5e45f817) && level.var_5e45f817) || var_14bd36c2 >= var_f11e475c || !level flag::get("spawn_zombies"))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_d3195b0c
	Namespace: namespace_bc12435c
	Checksum: 0xB1EF834B
	Offset: 0xA10
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_d3195b0c()
{
	switch(getplayers().size)
	{
		case 1:
		{
			return 3;
			break;
		}
		case 2:
		{
			return 5;
			break;
		}
		case 3:
		{
			return 7;
			break;
		}
		case 4:
		{
			return 10;
			break;
		}
	}
}

/*
	Name: function_331e9312
	Namespace: namespace_bc12435c
	Checksum: 0xE5370AF7
	Offset: 0xAA8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_331e9312()
{
	var_f98807b1 = getaiarchetypearray(#"skeleton");
	var_14bd36c2 = var_f98807b1.size;
	foreach(var_8739be3d in var_f98807b1)
	{
		if(!isalive(var_8739be3d))
		{
			var_14bd36c2--;
		}
	}
	return var_14bd36c2;
}

/*
	Name: function_d325f6a4
	Namespace: namespace_bc12435c
	Checksum: 0xD2EA6EEB
	Offset: 0xB70
	Size: 0x24A
	Parameters: 1
	Flags: Linked
*/
function function_d325f6a4(entity)
{
	if(isarray(level.zm_loc_types[#"zombie_location"]) && level.zm_loc_types[#"zombie_location"].size >= 1)
	{
		a_locs = function_3ce1516d(level.zm_loc_types[#"zombie_location"]);
		a_locs = array::randomize(a_locs);
	}
	if(!isdefined(a_locs) || a_locs.size == 0)
	{
		return;
	}
	if(isdefined(entity) && isdefined(entity.favoriteenemy) && zm_utility::is_player_valid(entity.favoriteenemy))
	{
		var_46d2ec35 = entity.favoriteenemy;
	}
	else
	{
		var_46d2ec35 = get_favorite_enemy();
	}
	if(!isdefined(var_46d2ec35) || !isalive(var_46d2ec35))
	{
		return array::random(a_locs);
	}
	var_ae2b4871 = 3600 * 3600;
	for(i = 0; i < a_locs.size; i++)
	{
		if(isdefined(level.var_445185e3) && level.var_445185e3 == a_locs[i])
		{
			continue;
		}
		n_dist_squared = distancesquared(a_locs[i].origin, var_46d2ec35.origin);
		if(n_dist_squared < var_ae2b4871)
		{
			level.var_445185e3 = a_locs[i];
			return a_locs[i];
		}
	}
	return arraygetclosest(var_46d2ec35.origin, a_locs);
}

/*
	Name: get_favorite_enemy
	Namespace: namespace_bc12435c
	Checksum: 0x6F97D4DF
	Offset: 0xDC8
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function get_favorite_enemy()
{
	var_8637c743 = getplayers();
	e_least_hunted = var_8637c743[0];
	for(i = 0; i < var_8637c743.size; i++)
	{
		if(!isdefined(var_8637c743[i].hunted_by))
		{
			var_8637c743[i].hunted_by = 0;
		}
		if(!zm_utility::is_player_valid(var_8637c743[i]))
		{
			continue;
		}
		if(!zm_utility::is_player_valid(e_least_hunted))
		{
			e_least_hunted = var_8637c743[i];
		}
		if(var_8637c743[i].hunted_by < e_least_hunted.hunted_by)
		{
			e_least_hunted = var_8637c743[i];
		}
	}
	if(!zm_utility::is_player_valid(e_least_hunted))
	{
		return undefined;
	}
	e_least_hunted.hunted_by = e_least_hunted.hunted_by + 1;
	return e_least_hunted;
}

/*
	Name: function_ad4293a8
	Namespace: namespace_bc12435c
	Checksum: 0x134AEB2E
	Offset: 0xF08
	Size: 0x2B8
	Parameters: 0
	Flags: Linked
*/
function function_ad4293a8()
{
	self endon(#"death");
	a_s_spawn_locs = function_3ce1516d(level.zm_loc_types[#"zombie_location"]);
	if(!isarray(a_s_spawn_locs) || a_s_spawn_locs.size < 1)
	{
		self.b_ignore_cleanup = 1;
		return 1;
	}
	if(zm_utility::is_standard() && level flag::exists("started_defend_area") && level flag::get("started_defend_area"))
	{
		self.b_ignore_cleanup = 1;
		return 1;
	}
	var_31f7011a = arraycopy(getplayers());
	var_31f7011a = arraysortclosest(var_31f7011a, self.origin);
	i = 0;
	var_b2aa54a9 = a_s_spawn_locs[0];
	var_56feeec4 = distancesquared(var_31f7011a[0].origin, var_b2aa54a9.origin);
	foreach(var_d7eff26a in a_s_spawn_locs)
	{
		if(!zm_utility::is_player_valid(var_31f7011a[i]))
		{
			i++;
			if(i >= var_31f7011a.size)
			{
				i = 0;
				util::wait_network_frame();
			}
			continue;
		}
		var_e8ab126e = distancesquared(var_31f7011a[i].origin, var_d7eff26a.origin);
		if(var_e8ab126e < var_56feeec4)
		{
			var_56feeec4 = var_e8ab126e;
			var_b2aa54a9 = var_d7eff26a;
		}
	}
	self namespace_e0710ee6::function_a8dc3363(var_b2aa54a9);
	return 1;
}

/*
	Name: function_3ce1516d
	Namespace: namespace_bc12435c
	Checksum: 0x649345AF
	Offset: 0x11C8
	Size: 0x108
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3ce1516d(a_s_spawn_locs)
{
	var_f74a9210 = [];
	foreach(s_spawn_loc in a_s_spawn_locs)
	{
		if(s_spawn_loc.script_noteworthy !== "spawn_location")
		{
			continue;
		}
		else if(s_spawn_loc.script_string !== "find_flesh")
		{
			continue;
		}
		if(!isdefined(var_f74a9210))
		{
			var_f74a9210 = [];
		}
		else if(!isarray(var_f74a9210))
		{
			var_f74a9210 = array(var_f74a9210);
		}
		var_f74a9210[var_f74a9210.size] = s_spawn_loc;
	}
	return var_f74a9210;
}

/*
	Name: function_4c74b381
	Namespace: namespace_bc12435c
	Checksum: 0x699A8326
	Offset: 0x12D8
	Size: 0x7A
	Parameters: 3
	Flags: None
*/
function function_4c74b381(origin, radius, half_height)
{
	/#
		assert(self.archetype === #"skeleton", "");
	#/
	self.var_dbbbae12 = ai::t_cylinder(origin, radius, half_height);
}

/*
	Name: function_9ac81c11
	Namespace: namespace_bc12435c
	Checksum: 0xC51FA8C1
	Offset: 0x1360
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function function_9ac81c11()
{
	/#
		assert(self.archetype === #"skeleton", "");
	#/
	self.var_dbbbae12 = undefined;
}

