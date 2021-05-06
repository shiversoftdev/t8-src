// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_387eab232fe22983;
#using script_3e8c1d1a6e50b75b;
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_6ce38ab036223e6e;
#using script_6e3c826b1814cab6;
#using script_7e59d7bba853fe4b;
#using script_ab862743b3070a;
#using script_db06eb511bd9b36;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_9d27962b;

/*
	Name: init
	Namespace: namespace_9d27962b
	Checksum: 0x861D59E4
	Offset: 0x260
	Size: 0x32C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	namespace_c3287616::function_2669b95a(#"bat", #"hash_50f4e0eea9f4e4a4");
	level.var_4c350e72 = 0;
	level.var_ce53172d = 30;
	level.dog_spawn_func = &function_e1c262fb;
	level.var_6189feaf = &function_c79d744e;
	level.var_29a8e07 = &function_d075d6e9;
	level.var_d9334d8b = &function_2438d55e;
	level.var_ae4acb3f = &function_18f5f327;
	level.var_b106cd7a = &function_50ec1ddf;
	level.var_7e40409b = &namespace_977da60::function_774f6e70;
	level.var_aab23eac = &function_84c5200d;
	level.var_8a5c1a7a = 1;
	level.custom_dog_target_validity_check = &function_bc0facd3;
	level flag::init("flag_werewolf_set_intro");
	level flag::init("flag_bat_nosferatu_set_intro");
	level flag::init("flag_crimson_nosferatu_set_intro");
	namespace_c3287616::function_2876740e(#"hash_1bab8a0ba811401e", &function_2ffc8cca);
	level waittill(#"all_players_spawned");
	if(zm_utility::is_standard())
	{
		level thread function_6957c745(#"hash_1bab8a0ba811401e", 3);
	}
	else
	{
		level thread function_6957c745(#"hash_1bab8a0ba811401e", 7);
		level thread function_6957c745(#"werewolf", 30, "flag_werewolf_set_intro");
		level thread function_6957c745(#"bat", 12, "flag_bat_nosferatu_set_intro");
		level thread function_6957c745(#"hash_50f4e0eea9f4e4a4", 12, "flag_bat_nosferatu_set_intro");
		level thread function_6957c745(#"hash_69eff09684574252", 35, "flag_crimson_nosferatu_set_intro");
	}
	/#
		callback::on_vehicle_spawned(&function_cfcf2d32);
	#/
}

/*
	Name: function_cfcf2d32
	Namespace: namespace_9d27962b
	Checksum: 0xB09A457B
	Offset: 0x598
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_cfcf2d32()
{
	/#
		if(self.archetype === #"bat")
		{
			self thread function_2438d55e();
		}
	#/
}

/*
	Name: function_2ffc8cca
	Namespace: namespace_9d27962b
	Checksum: 0x2859A8C5
	Offset: 0x5D8
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_2ffc8cca(n_max)
{
	return int(n_max * 0.4);
}

/*
	Name: function_6957c745
	Namespace: namespace_9d27962b
	Checksum: 0xE0BEB622
	Offset: 0x610
	Size: 0x9C
	Parameters: 3
	Flags: Linked
*/
function function_6957c745(str_archetype, n_round, var_b2239dab)
{
	if(isdefined(var_b2239dab))
	{
		level thread function_36c1dcca(n_round, var_b2239dab);
		level flag::wait_till(var_b2239dab);
		level waittill(#"hash_5d3012139f083ccb");
		n_round = level.round_number;
	}
	namespace_c3287616::function_376e51ef(str_archetype, n_round);
}

/*
	Name: function_36c1dcca
	Namespace: namespace_9d27962b
	Checksum: 0xF9D1D39D
	Offset: 0x6B8
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_36c1dcca(n_round, var_b2239dab)
{
	level endon(var_b2239dab);
	while(level.round_number < n_round)
	{
		level waittill(#"end_of_round");
	}
	level flag::set(var_b2239dab);
}

/*
	Name: function_3dab3302
	Namespace: namespace_9d27962b
	Checksum: 0x7992284E
	Offset: 0x730
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_3dab3302()
{
	level notify(#"hash_21672c4f6ccf13d0");
	level thread function_93eab559();
}

/*
	Name: function_93eab559
	Namespace: namespace_9d27962b
	Checksum: 0x15799D76
	Offset: 0x768
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_93eab559()
{
	level clientfield::set("" + #"hash_42e03f9ae74a1070", 1);
	if(zm_utility::is_standard())
	{
		return;
	}
	level thread p9_wood_lumber_01_1x4_64_01();
	wait(1);
	level thread zm_audio::sndannouncerplayvox("dogstart");
}

/*
	Name: function_41509519
	Namespace: namespace_9d27962b
	Checksum: 0x1156EF6D
	Offset: 0x7F8
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_41509519(var_d25bbdd5)
{
	if(var_d25bbdd5)
	{
		level.var_4c350e72++;
	}
	level notify(#"hash_7b9245ff51f3d4f7");
	level clientfield::set("" + #"hash_42e03f9ae74a1070", 0);
}

/*
	Name: function_4c350e72
	Namespace: namespace_9d27962b
	Checksum: 0x8211503B
	Offset: 0x870
	Size: 0x62
	Parameters: 0
	Flags: None
*/
function function_4c350e72()
{
	if(getplayers().size < 3)
	{
		n_max = getplayers().size * 6;
	}
	else
	{
		n_max = getplayers().size * 8;
	}
	return n_max;
}

/*
	Name: function_ffa01525
	Namespace: namespace_9d27962b
	Checksum: 0x35C8AD50
	Offset: 0x8E0
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function function_ffa01525()
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
	Name: function_e1c262fb
	Namespace: namespace_9d27962b
	Checksum: 0x17953E9C
	Offset: 0x998
	Size: 0x26A
	Parameters: 1
	Flags: Linked
*/
function function_e1c262fb(entity)
{
	if(isdefined(level.zm_loc_types[#"dog_location"]) && level.zm_loc_types[#"dog_location"].size >= 1)
	{
		a_locs = array::randomize(level.zm_loc_types[#"dog_location"]);
	}
	else
	{
		a_locs = struct::get_array("dog_location", "script_noteworthy");
		a_locs = array::randomize(a_locs);
	}
	if(isdefined(entity) && isdefined(entity.favoriteenemy) && zm_utility::is_player_valid(entity.favoriteenemy))
	{
		var_46d2ec35 = entity.favoriteenemy;
	}
	else
	{
		var_46d2ec35 = get_favorite_enemy();
	}
	var_ae51d146 = 400 * 400;
	var_5c124858 = 1200 * 1200;
	for(i = 0; i < a_locs.size; i++)
	{
		if(isdefined(level.var_445185e3) && level.var_445185e3 == a_locs[i])
		{
			continue;
		}
		if(!isalive(var_46d2ec35))
		{
			return array::random(a_locs);
		}
		n_dist_squared = distancesquared(a_locs[i].origin, var_46d2ec35.origin);
		if(n_dist_squared > var_ae51d146 && n_dist_squared < var_5c124858)
		{
			level.var_445185e3 = a_locs[i];
			return a_locs[i];
		}
	}
	return arraygetclosest(var_46d2ec35.origin, a_locs);
}

/*
	Name: function_c79d744e
	Namespace: namespace_9d27962b
	Checksum: 0xFCBB8FFA
	Offset: 0xC10
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_c79d744e(s_spawn_loc)
{
	self endon(#"death");
	if(isdefined(s_spawn_loc.scriptbundlename))
	{
		self zm_spawner::function_45bb11e4(s_spawn_loc);
	}
	/#
		assert(isdefined(self), "");
	#/
	/#
		assert(isalive(self), "");
	#/
	self namespace_c402654::zombie_setup_attack_properties_dog();
	wait(0.1);
	self show();
	self setfreecameralockonallowed(1);
	self val::reset(#"dog_spawn", "ignoreme");
	self val::reset(#"dog_spawn", "ignoreall");
	self notify(#"visible");
	self ai::set_behavior_attribute("sprint", 1);
}

/*
	Name: function_d075d6e9
	Namespace: namespace_9d27962b
	Checksum: 0xFB9CBFE4
	Offset: 0xD80
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function function_d075d6e9()
{
	if(!getdvarint(#"hash_331b448d3ef91baf", 0))
	{
		if(isdefined(level.zm_loc_types[#"bat_location"]) && level.zm_loc_types[#"bat_location"].size > 0)
		{
			a_locs = array::randomize(level.zm_loc_types[#"bat_location"]);
			s_loc = function_5618c56d(a_locs);
			return s_loc;
		}
	}
	return undefined;
}

/*
	Name: function_2438d55e
	Namespace: namespace_9d27962b
	Checksum: 0x5869E7A1
	Offset: 0xE50
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_2438d55e(s_spawn_loc)
{
	self endon_callback(&function_4d180baa, #"death");
	if(isdefined(s_spawn_loc))
	{
		if(isdefined(s_spawn_loc.target))
		{
			self thread vehicle::get_on_and_go_path(s_spawn_loc.target);
		}
		else if(isdefined(s_spawn_loc.scriptbundlename))
		{
			level scene::play(s_spawn_loc.scriptbundlename, "Shot 1", self);
		}
	}
	else
	{
		wait(1);
	}
}

/*
	Name: function_4d180baa
	Namespace: namespace_9d27962b
	Checksum: 0x66E3D77F
	Offset: 0xF08
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_4d180baa(str_notify)
{
}

/*
	Name: function_18f5f327
	Namespace: namespace_9d27962b
	Checksum: 0xDC7C9835
	Offset: 0xF20
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function function_18f5f327(s_spawn_loc)
{
	if(isdefined(s_spawn_loc.scriptbundlename))
	{
		switch(s_spawn_loc.scriptbundlename)
		{
			case "hash_c84f757f722cc2d":
			{
				self zm_spawner::function_45bb11e4(s_spawn_loc);
				break;
			}
			case "hash_7d11e0c604cdd69e":
			{
				self zm_spawner::do_zombie_rise(s_spawn_loc);
				break;
			}
		}
	}
}

/*
	Name: get_favorite_enemy
	Namespace: namespace_9d27962b
	Checksum: 0x95BD1216
	Offset: 0xFB8
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
	Name: function_27e8f915
	Namespace: namespace_9d27962b
	Checksum: 0xACB7B254
	Offset: 0x10F8
	Size: 0x7C
	Parameters: 3
	Flags: None
*/
function function_27e8f915(s_loc, e_target, var_d57228ca = 0)
{
	str_player_zone = e_target zm_zonemgr::get_player_zone();
	var_23525cb = s_loc.zone_name === str_player_zone;
	if(!var_d57228ca)
	{
		return var_23525cb;
	}
	return !var_23525cb;
}

/*
	Name: function_5618c56d
	Namespace: namespace_9d27962b
	Checksum: 0xDA44017C
	Offset: 0x1180
	Size: 0x122
	Parameters: 1
	Flags: Linked
*/
function function_5618c56d(a_locs)
{
	foreach(loc in a_locs)
	{
		if(loc !== level.var_c4437092)
		{
			/#
				var_666a9e97 = zm_zonemgr::get_zone_from_position(loc.origin);
			#/
			if(isdefined(loc.script_flag_wait) && loc.script_flag_wait !== "")
			{
				if(level flag::get(loc.script_flag_wait))
				{
					level.var_c4437092 = loc;
					return loc;
				}
				continue;
			}
			level.var_c4437092 = loc;
			return loc;
		}
	}
	return undefined;
}

/*
	Name: function_38c0c907
	Namespace: namespace_9d27962b
	Checksum: 0x11D7ADA
	Offset: 0x12B0
	Size: 0x104
	Parameters: 0
	Flags: None
*/
function function_38c0c907()
{
	var_d3b167fd = self.origin;
	if(isdefined(var_d3b167fd))
	{
		var_b82ff340 = namespace_c05f06c7::function_a8176b98(var_d3b167fd);
	}
	if(!isdefined(var_b82ff340))
	{
		foreach(player in util::get_active_players())
		{
			if(zm_utility::is_player_valid(player))
			{
				var_b82ff340 = player.origin;
				break;
			}
		}
	}
	if(isdefined(var_b82ff340))
	{
		level thread zm_powerups::specific_powerup_drop("full_ammo", var_b82ff340);
	}
}

/*
	Name: p9_wood_lumber_01_1x4_64_01
	Namespace: namespace_9d27962b
	Checksum: 0x424B4CE0
	Offset: 0x13C0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function p9_wood_lumber_01_1x4_64_01()
{
	players = getplayers();
	num = randomintrange(0, players.size);
	players[num] zm_audio::create_and_play_dialog(#"general", #"dog_spawn");
}

/*
	Name: function_988438a7
	Namespace: namespace_9d27962b
	Checksum: 0x11DD7FFA
	Offset: 0x1440
	Size: 0x118
	Parameters: 3
	Flags: Linked
*/
function function_988438a7(sp_spawner = level.var_38f5f109[0], s_spawn, n_round_number)
{
	var_e5e48bf4 = zombie_utility::spawn_zombie(sp_spawner, undefined, undefined, n_round_number);
	if(isdefined(var_e5e48bf4))
	{
		var_e5e48bf4.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		var_e5e48bf4 thread zombie_utility::round_spawn_failsafe();
		var_e5e48bf4 zm_score::function_82732ced();
	}
	if(isdefined(s_spawn) && isstruct(s_spawn) && isalive(var_e5e48bf4))
	{
		var_e5e48bf4 forceteleport(s_spawn.origin, s_spawn.angles);
	}
	return var_e5e48bf4;
}

/*
	Name: function_f46db405
	Namespace: namespace_9d27962b
	Checksum: 0x55936CD8
	Offset: 0x1560
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_f46db405()
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
	Name: function_50ec1ddf
	Namespace: namespace_9d27962b
	Checksum: 0x8B400D39
	Offset: 0x1618
	Size: 0x300
	Parameters: 0
	Flags: Linked
*/
function function_50ec1ddf()
{
	if(level flag::get(#"boss_fight_started") == 0)
	{
		a_s_spawn_locs = array::randomize(struct::get_array("werewolf_patrol_location", "script_noteworthy"));
		foreach(s_spawn_loc in a_s_spawn_locs)
		{
			if(zm_utility::check_point_in_enabled_zone(s_spawn_loc.origin) && (!(isdefined(s_spawn_loc function_1a27cc15()) && s_spawn_loc function_1a27cc15())) && (!(isdefined(s_spawn_loc function_e91102ad()) && s_spawn_loc function_e91102ad())))
			{
				return s_spawn_loc;
			}
		}
	}
	a_s_spawn_locs = struct::get_array("werewolf_location", "script_noteworthy");
	var_46d2ec35 = get_favorite_enemy();
	if(isdefined(var_46d2ec35))
	{
		a_s_spawn_locs = array::get_all_closest(var_46d2ec35.origin, a_s_spawn_locs);
	}
	else
	{
		a_s_spawn_locs = array::randomize(a_s_spawn_locs);
	}
	foreach(s_spawn_loc in a_s_spawn_locs)
	{
		if(zm_zonemgr::zone_is_enabled(s_spawn_loc.zone_name))
		{
			if(!isdefined(s_spawn_loc.var_39512f0e) || level flag::get(s_spawn_loc.var_39512f0e) == 0)
			{
				return s_spawn_loc;
			}
			if(s_spawn_loc.var_39512f0e === "power_on3" && namespace_59ff1d6c::function_901b751c("zmPowerState") == 2 && namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 0)
			{
				return s_spawn_loc;
			}
		}
	}
	return undefined;
}

/*
	Name: function_e91102ad
	Namespace: namespace_9d27962b
	Checksum: 0xB153A722
	Offset: 0x1920
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function function_e91102ad()
{
	foreach(player in getplayers())
	{
		if(player util::is_player_looking_at(self.origin + vectorscale((0, 0, 1), 64)))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_1a27cc15
	Namespace: namespace_9d27962b
	Checksum: 0x7BFDEB20
	Offset: 0x19D0
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_1a27cc15()
{
	var_c9e3c7bc = arraycombine(getplayers(), getaiarchetypearray(#"werewolf"), 0, 0);
	var_bdf9e3c2 = self zm_utility::get_current_zone();
	foreach(e_entity in var_c9e3c7bc)
	{
		var_91dfe7f4 = e_entity zm_utility::get_current_zone();
		if(var_91dfe7f4 === var_bdf9e3c2)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_84c5200d
	Namespace: namespace_9d27962b
	Checksum: 0x91C140B7
	Offset: 0x1AE0
	Size: 0x2F4
	Parameters: 1
	Flags: Linked
*/
function function_84c5200d(entity)
{
	entity endon(#"death");
	if(!isdefined(level.dog_spawners) || level.dog_spawners.size == 0)
	{
		/#
			iprintlnbold("");
		#/
		return;
	}
	var_a9e4d1ee = int(max(0, min(5, level.zombie_ai_limit - zombie_utility::get_current_zombie_count())));
	if(!var_a9e4d1ee)
	{
		a_ai_zombies = getaiarchetypearray(#"zombie");
		foreach(e_player in util::get_active_players(#"allies"))
		{
			var_77696b51 = array::get_all_closest(e_player.origin, a_ai_zombies, undefined, undefined, 640);
			a_ai_zombies = array::exclude(a_ai_zombies, var_77696b51);
		}
		var_a9e4d1ee = int(max(0, min(5, a_ai_zombies.size)));
		/#
			iprintln("" + var_a9e4d1ee + "");
		#/
		for(i = 0; i < var_a9e4d1ee; i++)
		{
			a_ai_zombies[i] thread namespace_57ff8cbb::cleanup_zombie();
		}
	}
	if(var_a9e4d1ee)
	{
		/#
			iprintln("" + var_a9e4d1ee + "");
		#/
		entity thread function_d1371239(var_a9e4d1ee);
	}
	iprintlnbold("");
}

/*
	Name: function_d1371239
	Namespace: namespace_9d27962b
	Checksum: 0x86FE9A98
	Offset: 0x1DE0
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_d1371239(var_a9e4d1ee)
{
	self endon(#"death");
	while(var_a9e4d1ee > 0)
	{
		var_18f8f237 = 5;
		do
		{
			ai = namespace_c402654::function_62db7b1c(1, undefined);
			var_18f8f237--;
			waitframe(1);
		}
		while(!isdefined(ai) && var_18f8f237);
		/#
			if(!var_18f8f237 && !isdefined(ai))
			{
				iprintlnbold("");
			}
		#/
		if(isdefined(ai))
		{
			ai thread function_acab3515();
			wait(randomfloatrange(1.5, 3.5));
		}
		var_a9e4d1ee--;
		waitframe(1);
	}
}

/*
	Name: function_acab3515
	Namespace: namespace_9d27962b
	Checksum: 0xBB00B0FA
	Offset: 0x1EF0
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_acab3515()
{
	self endon(#"death");
	self.var_126d7bef = 1;
	self.ignore_round_spawn_failsafe = 1;
	self.ignore_enemy_count = 1;
	self.b_ignore_cleanup = 1;
	self waittill(#"completed_emerging_into_playable_area");
	self.no_powerups = 1;
}

/*
	Name: function_bc0facd3
	Namespace: namespace_9d27962b
	Checksum: 0x5F185C3F
	Offset: 0x1F68
	Size: 0x142
	Parameters: 0
	Flags: Linked
*/
function function_bc0facd3()
{
	self endon(#"death");
	if(!isdefined(self.favoriteenemy))
	{
		return;
	}
	foreach(player in getplayers())
	{
		if(zm_utility::is_player_valid(player) && player != self.favoriteenemy && distancesquared(player.origin, self.origin) < 300 * 300 && distancesquared(self.favoriteenemy.origin, self.origin) > 150 * 150)
		{
			self function_f3ce0f2b(player);
			return;
		}
	}
}

/*
	Name: function_f3ce0f2b
	Namespace: namespace_9d27962b
	Checksum: 0xF800D3AE
	Offset: 0x20B8
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function function_f3ce0f2b(player)
{
	self endon(#"death");
	player endon(#"disconnect");
	self.favoriteenemy = player;
	for(n_timer = 5; n_timer > 0 && zm_utility::is_player_valid(player); n_timer--)
	{
		wait(1);
	}
}

