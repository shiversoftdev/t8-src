// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b10fdf0addd52e;
#using script_3657077a08b7f19e;
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_7e59d7bba853fe4b;
#using script_ab862743b3070a;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_977da60;

/*
	Name: function_89f2df9
	Namespace: namespace_977da60
	Checksum: 0x54860100
	Offset: 0x180
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_482f0758be7584b2", &__init__, &__main__, #"hash_6e8654cf5bb63c35");
}

/*
	Name: __init__
	Namespace: namespace_977da60
	Checksum: 0xB63C130D
	Offset: 0x1E0
	Size: 0x1BC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_491fd91 = getentarray("zombie_werewolf_spawner", "script_noteworthy");
	if(level.var_491fd91.size == 0)
	{
		/#
			assertmsg("");
		#/
		return;
	}
	foreach(var_362056e0 in level.var_491fd91)
	{
		var_362056e0.is_enabled = 1;
		var_362056e0.script_forcespawn = 1;
	}
	zm_score::function_e5d6e6dd(#"werewolf", 250);
	namespace_c3287616::register_archetype(#"werewolf", &function_45bed901, &round_spawn, &function_47a88a0c, 300);
	namespace_c3287616::function_306ce518(#"werewolf", &function_d7a8d5a8);
	namespace_32192f7::function_95c1dd81(#"werewolf", &function_fb4cbb48);
}

/*
	Name: __main__
	Namespace: namespace_977da60
	Checksum: 0x5657A7B0
	Offset: 0x3A8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	namespace_3fffba66::function_cfca77a7(#"hash_2ca39a768b9be4ab", #"werewolf", &function_39212989, 1, undefined, undefined, "aib_vign_zm_mnsn_werewolf_pre_transform", "aib_vign_zm_mnsn_werewolf_post_transform", &function_5c0a0b26);
}

/*
	Name: function_39212989
	Namespace: namespace_977da60
	Checksum: 0x5F7684BD
	Offset: 0x420
	Size: 0x1E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_39212989()
{
	if(!namespace_e0710ee6::function_db610082())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_5c0a0b26
	Namespace: namespace_977da60
	Checksum: 0xE21A923B
	Offset: 0x448
	Size: 0x14
	Parameters: 2
	Flags: Linked, Private
*/
private function function_5c0a0b26(zombie, var_167b5341)
{
}

/*
	Name: function_6268b69f
	Namespace: namespace_977da60
	Checksum: 0xFEF87E04
	Offset: 0x468
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_6268b69f()
{
	var_47469148 = getaiarchetypearray(#"werewolf");
	var_492bcd12 = var_47469148.size;
	foreach(var_e3cf2cc7 in var_47469148)
	{
		if(!isalive(var_e3cf2cc7))
		{
			var_492bcd12--;
		}
	}
	return var_492bcd12;
}

/*
	Name: function_15d944aa
	Namespace: namespace_977da60
	Checksum: 0xC61E8B74
	Offset: 0x530
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_15d944aa()
{
	var_492bcd12 = function_6268b69f();
	var_2bf29cda = function_1f269f0f();
	if(!(isdefined(level.var_76934955) && level.var_76934955) && (isdefined(level.var_fe2bb2ac) && level.var_fe2bb2ac || var_492bcd12 >= var_2bf29cda || !level flag::get("spawn_zombies")))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_1f269f0f
	Namespace: namespace_977da60
	Checksum: 0xB9352EF9
	Offset: 0x5F8
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_1f269f0f()
{
	switch(getplayers().size)
	{
		case 1:
		{
			return 1;
			break;
		}
		case 2:
		{
			return 2;
			break;
		}
		case 3:
		{
			return 2;
			break;
		}
		case 4:
		{
			return 3;
			break;
		}
	}
}

/*
	Name: function_cd674a85
	Namespace: namespace_977da60
	Checksum: 0x80F3006E
	Offset: 0x690
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_cd674a85()
{
	switch(getplayers().size)
	{
		case 1:
		{
			n_default_wait = 2.25;
			break;
		}
		case 2:
		{
			n_default_wait = 1.75;
			break;
		}
		case 3:
		{
			n_default_wait = 1.25;
			break;
		}
		default:
		{
			n_default_wait = 0.75;
			break;
		}
	}
	wait(n_default_wait);
}

/*
	Name: function_fb4cbb48
	Namespace: namespace_977da60
	Checksum: 0x30A276C6
	Offset: 0x748
	Size: 0x2A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fb4cbb48()
{
	var_e3cf2cc7 = function_47a88a0c(undefined, undefined, 1);
	return isdefined(var_e3cf2cc7);
}

/*
	Name: function_a7a6a96c
	Namespace: namespace_977da60
	Checksum: 0x4F9DBFEF
	Offset: 0x780
	Size: 0xD8
	Parameters: 3
	Flags: Linked
*/
function function_a7a6a96c(spawner, s_spot, n_round_number)
{
	var_e3cf2cc7 = zombie_utility::spawn_zombie(level.var_491fd91[0], "stoker", s_spot, n_round_number);
	if(isdefined(var_e3cf2cc7))
	{
		if(isdefined(s_spot.scriptbundlename))
		{
			s_spot thread scene::play(s_spot.scriptbundlename, array(var_e3cf2cc7));
		}
		else
		{
			var_e3cf2cc7.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
			var_e3cf2cc7 thread zombie_utility::round_spawn_failsafe();
		}
	}
	return var_e3cf2cc7;
}

/*
	Name: get_favorite_enemy
	Namespace: namespace_977da60
	Checksum: 0x13FBFE00
	Offset: 0x860
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function get_favorite_enemy()
{
	a_targets = getplayers();
	least_hunted = a_targets[0];
	for(i = 0; i < a_targets.size; i++)
	{
		if(!isdefined(a_targets[i].hunted_by))
		{
			a_targets[i].hunted_by = 0;
		}
		if(!zm_utility::is_player_valid(a_targets[i]))
		{
			continue;
		}
		if(!zm_utility::is_player_valid(least_hunted))
		{
			least_hunted = a_targets[i];
		}
		if(a_targets[i].hunted_by < least_hunted.hunted_by)
		{
			least_hunted = a_targets[i];
		}
	}
	if(!zm_utility::is_player_valid(least_hunted))
	{
		return undefined;
	}
	least_hunted.hunted_by = least_hunted.hunted_by + 1;
	return least_hunted;
}

/*
	Name: round_spawn
	Namespace: namespace_977da60
	Checksum: 0x6554F926
	Offset: 0x9A0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function round_spawn()
{
	ai = function_47a88a0c();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return 1;
	}
	return 0;
}

/*
	Name: function_47a88a0c
	Namespace: namespace_977da60
	Checksum: 0x3969A656
	Offset: 0x9E8
	Size: 0x2FC
	Parameters: 5
	Flags: Linked
*/
function function_47a88a0c(n_to_spawn = 1, var_1fafa3fc, b_force_spawn = 0, var_eb3a8721, n_round)
{
	while(n_spawned < n_to_spawn)
	{
		if(!b_force_spawn && !function_15d944aa())
		{
			return n_spawned;
		}
		players = getplayers();
		var_46d2ec35 = get_favorite_enemy();
		if(isdefined(var_eb3a8721))
		{
			s_spawn_loc = var_eb3a8721;
		}
		else if(isdefined(level.var_b106cd7a))
		{
			s_spawn_loc = [[level.var_b106cd7a]]();
		}
		else if(level.zm_loc_types[#"werewolf_location"].size > 0)
		{
			s_spawn_loc = array::random(level.zm_loc_types[#"werewolf_location"]);
		}
		if(!isdefined(s_spawn_loc))
		{
			return;
		}
		ai = function_a7a6a96c(level.var_491fd91[0], s_spawn_loc, n_round);
		if(isdefined(ai))
		{
			ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
			ai.script_string = s_spawn_loc.script_string;
			ai.find_flesh_struct_string = ai.script_string;
			if(isdefined(var_eb3a8721) || zm_utility::is_standard())
			{
				ai.var_cf3ac201 = 0;
			}
			else
			{
				ai.var_cf3ac201 = 1;
			}
			if(isdefined(var_46d2ec35))
			{
				ai.favoriteenemy = var_46d2ec35;
				ai.favoriteenemy.hunted_by++;
			}
			n_spawned++;
			if(isdefined(level.var_7e40409b))
			{
				ai thread [[level.var_7e40409b]](s_spawn_loc);
			}
			if(isdefined(var_1fafa3fc))
			{
				ai thread [[var_1fafa3fc]]();
			}
			ai playsound(#"hash_63299a75a97f9678");
			function_6eac4ca1(ai, "spawn");
		}
		function_cd674a85();
	}
	return ai;
}

/*
	Name: function_774f6e70
	Namespace: namespace_977da60
	Checksum: 0x7050067E
	Offset: 0xCF0
	Size: 0x184
	Parameters: 4
	Flags: Linked
*/
function function_774f6e70(s_spawn_loc, var_58a8a3cb = 1, var_cda6f9a7 = undefined, var_d5e7e76d = undefined)
{
	self endon(#"death", #"hash_1783be2ff62b582c");
	if(!(isdefined(self.var_cf3ac201) && self.var_cf3ac201))
	{
		return;
	}
	if(isdefined(s_spawn_loc.target))
	{
		var_a8a8b6f8 = namespace_e0710ee6::function_35eac38d(getnode(s_spawn_loc.target, "targetname"));
		namespace_e0710ee6::start_patrol(self, var_a8a8b6f8.path, var_a8a8b6f8.loops, var_cda6f9a7, var_d5e7e76d);
		if(var_58a8a3cb)
		{
			for(n_timer = randomintrange(60, 90); n_timer > 0 && level.var_9427911d > 15; n_timer--)
			{
				wait(1);
			}
			namespace_e0710ee6::stop_patrol(self);
		}
	}
}

/*
	Name: function_7c14f53f
	Namespace: namespace_977da60
	Checksum: 0xCA271B31
	Offset: 0xE80
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_7c14f53f()
{
	namespace_e0710ee6::stop_patrol(self);
}

/*
	Name: function_d7a8d5a8
	Namespace: namespace_977da60
	Checksum: 0x4DD4CED4
	Offset: 0xEA8
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_d7a8d5a8(n_round_number)
{
	level endon(#"end_game");
	if(!isdefined(level.var_d7b601b9))
	{
		level.var_d7b601b9 = 0;
	}
	while(true)
	{
		level waittill(#"hash_5d3012139f083ccb");
		if(namespace_c3287616::function_d0db51fc(#"werewolf") && (!(isdefined(level.var_153e9058) && level.var_153e9058)))
		{
			level.var_d7b601b9++;
			level.var_2c03ab22 = level.round_number + function_21a3a673(3, 5);
		}
	}
}

/*
	Name: function_45bed901
	Namespace: namespace_977da60
	Checksum: 0xE080D718
	Offset: 0xF98
	Size: 0x222
	Parameters: 1
	Flags: Linked
*/
function function_45bed901(var_dbce0c44)
{
	var_8cf00d40 = int(floor(var_dbce0c44 / 300));
	if(isdefined(level.var_2c03ab22) && level.round_number < level.var_2c03ab22)
	{
		return 0;
	}
	var_2506688 = 1;
	var_1797c23a = 1;
	n_player_count = zm_utility::function_a2541519(level.players.size);
	if(n_player_count > 1)
	{
		switch(level.var_d7b601b9)
		{
			case 0:
			{
				break;
			}
			case 1:
			{
				var_1797c23a = 2;
				break;
			}
			case 2:
			{
				var_1797c23a = 3;
				break;
			}
			case 3:
			{
				var_2506688 = 1;
				var_1797c23a = 3;
				break;
			}
			case 4:
			{
				var_2506688 = 2;
				var_1797c23a = 3;
				break;
			}
			default:
			{
				var_2506688 = 3;
				var_1797c23a = 3;
			}
		}
	}
	else if(level.round_number >= 40)
	{
		var_1797c23a = 3;
	}
	else if(level.round_number >= 30)
	{
		var_1797c23a = 2;
	}
	else
	{
		var_1797c23a = 1;
	}
	return function_21a3a673(var_2506688, int(min(var_8cf00d40, var_1797c23a)));
}

