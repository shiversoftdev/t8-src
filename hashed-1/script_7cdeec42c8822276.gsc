// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14e569dd391faf67;
#using script_174ebb9642933bf7;
#using script_2cd0a997aa904279;
#using script_3f9e0dc8454d98e1;
#using script_6ce38ab036223e6e;
#using script_ab862743b3070a;
#using script_db06eb511bd9b36;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_powerups.gsc;

#namespace namespace_76ccb07a;

/*
	Name: init
	Namespace: namespace_76ccb07a
	Checksum: 0xBFD8CF4D
	Offset: 0x138
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function init()
{
	level thread function_88b87834();
}

/*
	Name: function_fac06066
	Namespace: namespace_76ccb07a
	Checksum: 0x817DB735
	Offset: 0x160
	Size: 0x194
	Parameters: 0
	Flags: None
*/
function function_fac06066()
{
	var_2b198109 = getaiarray();
	foreach(e_zombie in var_2b198109)
	{
		e_zombie thread namespace_57ff8cbb::cleanup_zombie();
	}
	level.var_894a83d8 = 1;
	level flag::clear("spawn_zombies");
	level flag::set("pause_round_timeout");
	level.var_37769559 = 10;
	level.var_baf33f0e = 0;
	zm_powerups::function_74b8ec6b("full_ammo");
	zm_powerups::function_74b8ec6b("bonus_points_team");
	zm_powerups::function_74b8ec6b("double_points");
	callback::on_ai_killed(&function_1cae4e0a);
	level thread function_bcae2e4b();
	wait(15);
	level thread round_spawning();
}

/*
	Name: function_4074a9e2
	Namespace: namespace_76ccb07a
	Checksum: 0x4E6D0188
	Offset: 0x300
	Size: 0x1BC
	Parameters: 0
	Flags: None
*/
function function_4074a9e2()
{
	var_2b198109 = getaiarray();
	foreach(e_zombie in var_2b198109)
	{
		e_zombie.exclude_cleanup_adding_to_total = 1;
		e_zombie thread namespace_57ff8cbb::cleanup_zombie();
	}
	level.var_894a83d8 = 0;
	level flag::clear(#"hash_26e9fe6561459de3");
	level flag::set("spawn_zombies");
	level flag::set("pause_round_timeout");
	callback::remove_on_ai_killed(&function_1cae4e0a);
	zm_powerups::function_41cedb05("full_ammo");
	zm_powerups::function_41cedb05("bonus_points_team");
	zm_powerups::function_41cedb05("double_points");
	/#
		iprintlnbold("" + level.var_baf33f0e + "");
	#/
	level thread function_88b87834();
}

/*
	Name: function_1cae4e0a
	Namespace: namespace_76ccb07a
	Checksum: 0xC33C829A
	Offset: 0x4C8
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function function_1cae4e0a(s_params)
{
	if(self.var_c39323b5 !== 1)
	{
		level.var_baf33f0e++;
		if(level.var_bdc8b034.size < 1 && zombie_utility::get_current_zombie_count() < 2)
		{
			level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
		}
	}
}

/*
	Name: function_b741acea
	Namespace: namespace_76ccb07a
	Checksum: 0x913B3F
	Offset: 0x568
	Size: 0x234
	Parameters: 0
	Flags: None
*/
function function_b741acea()
{
	level.var_bdc8b034 = [];
	level.var_bdc8b034[#"zombie"] = namespace_a28acff3::get_zombie_count_for_round(level.var_37769559, level.activeplayers.size);
	var_d90bc041 = min(level.var_37769559 - 10 / 40, 1);
	var_82981c27 = lerpfloat(0.1, 0.3, var_d90bc041);
	var_2f8a58bb = lerpfloat(0.2, 0.4, var_d90bc041);
	var_8c110732 = randomfloatrange(var_82981c27, var_2f8a58bb);
	var_778b517c = int(var_8c110732 * level.var_bdc8b034[#"zombie"]);
	level.var_bdc8b034[#"zombie"] = level.var_bdc8b034[#"zombie"] - var_778b517c;
	level.var_bdc8b034[#"zombie_dog"] = int(randomfloatrange(0.2, 0.4) * var_778b517c);
	level.var_bdc8b034[#"nova_crawler"] = var_778b517c - level.var_bdc8b034[#"zombie_dog"];
	arrayremovevalue(level.var_bdc8b034, 0, 1);
}

/*
	Name: function_88b87834
	Namespace: namespace_76ccb07a
	Checksum: 0x5E0FF33C
	Offset: 0x7A8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_88b87834()
{
	level waittill(#"hash_70624458fe48ac18");
	level flag::set(#"hash_26e9fe6561459de3");
	function_fac06066();
}

/*
	Name: function_bcae2e4b
	Namespace: namespace_76ccb07a
	Checksum: 0xFA70593A
	Offset: 0x800
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_bcae2e4b()
{
	level waittill(#"hash_3e95ff63d623d736");
	function_4074a9e2();
}

/*
	Name: round_spawning
	Namespace: namespace_76ccb07a
	Checksum: 0xEF661A
	Offset: 0x838
	Size: 0x264
	Parameters: 0
	Flags: None
*/
function round_spawning()
{
	level endon(#"hash_3e95ff63d623d736");
	function_b741acea();
	n_spawn_delay = namespace_a28acff3::get_zombie_spawn_delay(level.var_37769559);
	while(level.var_bdc8b034.size > 0)
	{
		var_404e4288 = zombie_utility::get_current_zombie_count();
		while(var_404e4288 >= level.zombie_ai_limit)
		{
			wait(0.1);
			var_404e4288 = zombie_utility::get_current_zombie_count();
		}
		while(zombie_utility::get_current_actor_count() >= level.zombie_actor_limit)
		{
			zombie_utility::clear_all_corpses();
			wait(0.1);
		}
		level flag::wait_till_clear(#"hash_21921ed511559aa3");
		str_archetype = function_80804ee4();
		ai = function_fc475b3b(str_archetype);
		if(isdefined(ai))
		{
			ai._starting_round_number = level.var_37769559;
			level.var_bdc8b034[str_archetype]--;
			if(level.var_bdc8b034[str_archetype] == 0)
			{
				arrayremoveindex(level.var_bdc8b034, str_archetype, 1);
			}
			ai thread zombie_utility::round_spawn_failsafe();
			var_404e4288++;
			if(ai ai::has_behavior_attribute("can_juke"))
			{
				ai ai::set_behavior_attribute("can_juke", 0);
			}
			wait(n_spawn_delay);
		}
		util::wait_network_frame();
	}
	while(zombie_utility::get_current_zombie_count() > 0)
	{
		wait(0.1);
	}
	level thread end_round();
}

/*
	Name: function_80804ee4
	Namespace: namespace_76ccb07a
	Checksum: 0xAFA2250F
	Offset: 0xAA8
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function function_80804ee4()
{
	a_keys = getarraykeys(level.var_bdc8b034);
	return array::random(a_keys);
}

/*
	Name: function_fc475b3b
	Namespace: namespace_76ccb07a
	Checksum: 0x53ADFDBF
	Offset: 0xAF0
	Size: 0xFE
	Parameters: 1
	Flags: None
*/
function function_fc475b3b(str_archetype)
{
	switch(str_archetype)
	{
		case "zombie":
		{
			spawner = array::random(level.zombie_spawners);
			ai = zombie_utility::spawn_zombie(spawner);
			break;
		}
		case "zombie_dog":
		{
			ai = namespace_c402654::function_62db7b1c();
			break;
		}
		case "nova_crawler":
		{
			ai = namespace_df88241c::function_33bf3983();
			break;
		}
		default:
		{
			/#
				assertmsg("");
			#/
			break;
		}
	}
	return ai;
}

/*
	Name: end_round
	Namespace: namespace_76ccb07a
	Checksum: 0x98BA2028
	Offset: 0xBF8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function end_round()
{
	level endon(#"hash_3e95ff63d623d736");
	wait(15);
	function_d89bf8aa();
}

/*
	Name: function_d89bf8aa
	Namespace: namespace_76ccb07a
	Checksum: 0xC291BD9
	Offset: 0xC38
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_d89bf8aa()
{
	level.var_37769559 = level.var_37769559 + 5;
	level thread round_spawning();
}

