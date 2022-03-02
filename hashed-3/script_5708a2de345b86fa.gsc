// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_10956a741a7e186e;
#using script_19d580f91d270e23;
#using script_23c01b321e642c31;
#using script_27eb70dfa42c6e69;
#using script_28bfe6df1650ab79;
#using script_2fd18c09d0536718;
#using script_30ba61ad5559c51d;
#using script_3225d67f8e4a63cb;
#using script_32db4ab8dcf85b70;
#using script_3657077a08b7f19e;
#using script_3f9e0dc8454d98e1;
#using script_43642da1b2402e5c;
#using script_4491b82ef72751cd;
#using script_512d27609721ec85;
#using script_5931c3fe7ea52f77;
#using script_62a0cb1167067152;
#using script_676fc0767562bc02;
#using script_6951ea86fdae9ae0;
#using script_6d813fcbc979603a;
#using script_6f5e741b2bceba3a;
#using script_7ed360d98f276e94;
#using script_dce2cd1bcd07d72;
#using script_ddbbb750404a64b;
#using script_e56ea76d6c36d39;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_powerups.gsc;

#namespace namespace_309bc702;

/*
	Name: main
	Namespace: namespace_309bc702
	Checksum: 0xB8C9F93A
	Offset: 0x290
	Size: 0x328
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level endon(#"end_game");
	level.var_4182b94e = struct::get_array("initial_spawn_points", "targetname");
	level flag::init(#"hash_18775b013e93e516");
	var_50f6b3f4 = getent("counter_tens", "targetname");
	var_50f6b3f4.start_angles = var_50f6b3f4.angles;
	var_d02e9cd = getent("counter_ones", "targetname");
	var_d02e9cd.start_angles = var_d02e9cd.angles;
	level.var_b691023c = 0;
	while(true)
	{
		if(isdefined(level.var_dc22f98))
		{
			level.fn_custom_round_ai_spawn = level.var_dc22f98;
			level.var_dc22f98 = undefined;
		}
		if(level.round_number > 1)
		{
			level.var_b691023c = undefined;
		}
		level waittill(#"hash_5d42d8ee7a08b543");
		switch(level.round_number)
		{
			case 1:
			{
				level thread function_1a2500e5();
				break;
			}
			case 15:
			{
				level thread function_439b486f();
				break;
			}
			case 21:
			{
				level thread function_21e77256();
				break;
			}
			case 30:
			{
				level thread function_e478fb2a();
				level.var_dc22f98 = level.fn_custom_round_ai_spawn;
				level.fn_custom_round_ai_spawn = &function_1bc491ab;
				level thread spawn_boss();
				break;
			}
		}
		level waittill(#"hash_7646638df88a3656");
		if(isdefined(level.var_43c333a8))
		{
			level.var_43c333a8 kill();
		}
		if(level flag::get(#"hash_639e8274a1b57729") && !level flag::get(#"hash_40856b65dff0f6eb") && level flag::get("round_reset"))
		{
			level namespace_5c160465::function_6acd363d(0);
		}
	}
}

/*
	Name: function_1a2500e5
	Namespace: namespace_309bc702
	Checksum: 0x9564527C
	Offset: 0x5C0
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function function_1a2500e5()
{
	level.var_806abe8f = level.var_f44e37f7;
	level.var_f44e37f7 = &function_c4d44a1b;
	foreach(player in getplayers())
	{
		player thread teleport_player();
	}
	wait(0.5);
	level.var_f44e37f7 = level.var_806abe8f;
}

/*
	Name: function_c4d44a1b
	Namespace: namespace_309bc702
	Checksum: 0x8F600EB6
	Offset: 0x6A0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_c4d44a1b(var_de1edcdb)
{
	n_script_int = self getentitynumber();
	s_point = level.var_4182b94e[n_script_int];
	return s_point;
}

/*
	Name: teleport_player
	Namespace: namespace_309bc702
	Checksum: 0x22B001D7
	Offset: 0x6F8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function teleport_player()
{
	if(isalive(self) && self.zone_name != "zone_security_checkpoint")
	{
		if(self isusingoffhand())
		{
			self forceoffhandend();
		}
		self zm_bgb_anywhere_but_here::activation(0);
	}
}

/*
	Name: function_439b486f
	Namespace: namespace_309bc702
	Checksum: 0xB140592
	Offset: 0x780
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_439b486f()
{
	if(!level flag::get(#"hash_18775b013e93e516"))
	{
		level flag::set(#"hash_18775b013e93e516");
		exploder::exploder("fxexp_disco_lgt");
		var_51bef3af = spawn("script_model", (1, 1145, -350));
		var_51bef3af playsound(#"hash_c8d3a1557c42ab7");
		s_notify = undefined;
		s_notify = level waittilltimeout(253, #"hash_7646638df88a3656");
		var_51bef3af stopsound(#"hash_c8d3a1557c42ab7");
		waitframe(1);
		var_51bef3af delete();
		exploder::stop_exploder("fxexp_disco_lgt");
		level flag::clear(#"hash_18775b013e93e516");
	}
}

/*
	Name: function_21e77256
	Namespace: namespace_309bc702
	Checksum: 0xDBACE9D7
	Offset: 0x8D8
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_21e77256()
{
	level flag::set(#"hash_502f2e83a538c679");
	level.var_df3991a = getentarray("dummy", "targetname");
	level.var_561ae1f8 = level.var_df3991a.size;
	if(level.var_df3991a.size <= 0)
	{
		return;
	}
	foreach(m in level.var_df3991a)
	{
		if(isdefined(m))
		{
			m thread namespace_b9fd696c::function_edcadf04();
		}
	}
}

/*
	Name: function_1bc491ab
	Namespace: namespace_309bc702
	Checksum: 0xDF2CDC7C
	Offset: 0x9D8
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_1bc491ab()
{
	s_spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
	ai = zombie_utility::spawn_zombie(getentarray("mannequin_zombie_spawner", "script_noteworthy")[0], undefined, s_spawn_point);
	if(isdefined(ai))
	{
		ai.health = int(ai.health * 2);
		level.zombie_total--;
		n_delay = (isdefined(zombie_utility::function_d2dfacfd(#"zombie_spawn_delay")) ? zombie_utility::function_d2dfacfd(#"zombie_spawn_delay") : zombie_utility::function_d2dfacfd(#"hash_7d5a25e2463f7fc5"));
		wait(n_delay);
		return true;
	}
	return false;
}

/*
	Name: spawn_boss
	Namespace: namespace_309bc702
	Checksum: 0xAA65E073
	Offset: 0xB20
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function spawn_boss()
{
	level endon(#"end_game", #"hash_7646638df88a3656");
	exploder::exploder("fxexp_pyramid_open");
	var_1c91a56e = struct::get("apd_door_scene", "targetname");
	level waittill(#"zombie_total_set");
	n_threshold = (level.total_zombies_killed - level.zombie_total_subtract) + level.zombie_total;
	s_notify = undefined;
	s_notify = level waittill(#"hash_715188521b564b16");
	var_1c91a56e scene::play("open");
	namespace_92cb027a::spawn_boss();
	if(isdefined(level.var_43c333a8))
	{
		level.var_43c333a8 thread spawn_done(n_threshold);
	}
}

/*
	Name: function_e478fb2a
	Namespace: namespace_309bc702
	Checksum: 0xF9BA92D7
	Offset: 0xC60
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_e478fb2a()
{
	var_1c91a56e = struct::get("apd_door_scene", "targetname");
	var_1c91a56e thread scene::play_from_time("close", undefined, undefined, 1, 1);
	exploder::exploder_stop("fxexp_pyramid_open");
	exploder::exploder_stop("fxexp_pyramid_capture");
}

/*
	Name: spawn_done
	Namespace: namespace_309bc702
	Checksum: 0x95EDBBFF
	Offset: 0xCF0
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function spawn_done(n_threshold)
{
	level endon(#"hash_7646638df88a3656");
	waitframe(1);
	if(isdefined(level.var_43c333a8))
	{
		self waittill(#"new_scripted_anim");
		self notify(#"intro_done");
		self namespace_f7516cdf::function_ed39491e(1);
	}
	while(n_threshold > level.total_zombies_killed - level.zombie_total_subtract)
	{
		wait(0.1);
	}
	if(isdefined(level.var_43c333a8))
	{
		self namespace_f7516cdf::function_ed39491e(4);
		exploder::exploder("fxexp_pyramid_capture");
		level.vol_toast_trap = getent("vol_toast_trap", "targetname");
		while(isdefined(level.var_43c333a8) && !level.var_43c333a8 istouching(level.vol_toast_trap))
		{
			wait(0.1);
		}
		while(isdefined(level.var_43c333a8))
		{
			wait(0.1);
		}
		level thread namespace_92cb027a::function_3418b6f6();
	}
}

