// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3a3c430eb58ed475;
#using script_3f9e0dc8454d98e1;
#using script_4d000493c57bb851;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_towers_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_574b32d2;

/*
	Name: init
	Namespace: namespace_574b32d2
	Checksum: 0xEB10A09D
	Offset: 0x548
	Size: 0xB0C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"hash_42cc4bf5e47478c5"] = #"hash_387c78244f5f45e5";
	level._effect[#"hash_5b4e7c178480d885"] = #"hash_62eafc17a432322a";
	level flag::init(#"hash_57454e59c155098d");
	level flag::init(#"hash_2fb4b4431d3ed627");
	level flag::init(#"hash_40f20925227353f4");
	level flag::init(#"hash_5cdf5c960293141a");
	level flag::init(#"hash_6af037519dceda7a");
	level flag::init(#"hash_30e0e4bbbfc9b7d8");
	level flag::init(#"hash_d9ce740cc4b8285");
	level flag::init(#"hash_200151b21f16734f");
	level flag::init(#"hash_45259bb6368fc0d3");
	level flag::init(#"hash_5649f57b918f85f8");
	level flag::init(#"hash_30ca6a723fbb84e9");
	level flag::init(#"hash_1c66e5c351c08de1");
	level flag::init(#"hash_77ff9a8101ea687b");
	level flag::init(#"hash_631e8676a2fa932b");
	level flag::init(#"hash_3ac6f9944962bd4c");
	level flag::init(#"hash_786b9153c754d127");
	level flag::init(#"hash_17f15c9242ddea6f");
	level flag::init(#"hash_70b6094c8cd39890");
	namespace_ee206246::register(#"ww_quest", #"hash_614495ae17eb5cbe", #"hash_614495ae17eb5cbe", &function_eb342c64, &function_56486fd0);
	namespace_ee206246::register(#"ww_quest", #"hash_d5c25527e182d3d", #"hash_d5c25527e182d3d", &function_87c0abfb, &function_2f217c86);
	namespace_ee206246::register(#"ww_quest", #"hash_32b57ffc37ccf79a", #"hash_32b57ffc37ccf79a", &function_26956e1e, &function_4f056f0c);
	namespace_ee206246::register(#"ww_quest", #"hash_2e681afa5f81f37", #"hash_2e681afa5f81f37", &function_708cd4d, &function_c4e5bf05);
	namespace_ee206246::register(#"ww_quest", #"hash_27967f916a97a057", #"hash_27967f916a97a057", &function_2eea86a9, &function_57b4770f);
	namespace_ee206246::register(#"ww_quest", #"hash_34d18772151ea4fa", #"hash_34d18772151ea4fa", &function_a1e2245, &function_e02f2459);
	namespace_ee206246::register(#"ww_quest", #"hash_2e126c422fbf5654", #"hash_2e126c422fbf5654", &function_9ef8d102, &function_1c380f29);
	namespace_ee206246::register(#"ww_quest", #"hash_396293edac63aa6f", #"hash_396293edac63aa6f", &function_dd053937, &function_4509873);
	namespace_ee206246::register(#"ww_quest", #"hash_776efec5f9b03a68", #"hash_776efec5f9b03a68", &function_a616131a, &function_605806f);
	namespace_ee206246::register(#"ww_quest", #"hash_7e929133c03a391b", #"hash_7e929133c03a391b", &function_ac4e38bc, &function_8c32234c);
	namespace_ee206246::register(#"ww_quest", #"hash_1ab84b282c179562", #"hash_1ab84b282c179562", &function_ec26e009, &function_4877f171);
	namespace_ee206246::register(#"ww_quest", #"hash_530b93342f7f39ae", #"hash_530b93342f7f39ae", &function_bbdde10e, &function_40f77b4a);
	namespace_ee206246::register(#"ww_quest", #"hash_38a9bcd55c0565ca", #"hash_38a9bcd55c0565ca", &function_ab13e06, &function_868dcb6d);
	namespace_ee206246::register(#"ww_quest", #"hash_2512f1281c5c7237", #"hash_2512f1281c5c7237", &function_869d271a, &function_79875787);
	namespace_ee206246::register(#"ww_quest", #"hash_4e767f415b51d0a1", #"hash_4e767f415b51d0a1", &function_3cadd22, &function_f04288b4);
	namespace_ee206246::start(#"ww_quest", 1);
	level scene::add_scene_func("p8_fxanim_zm_towers_ww_quest_bowl_bundle", &function_73808ab9, "init");
	var_85034658 = array("danu", "ra", "odin", "zeus");
	level.var_9f950fe2 = array::random(var_85034658);
	var_d3b8df9 = var_85034658;
	arrayremovevalue(var_d3b8df9, level.var_9f950fe2);
	foreach(var_8cac5c1e in var_d3b8df9)
	{
		s_unitrigger = struct::get("s_ww_quest_rough_statue_unitrigger_" + var_8cac5c1e);
		var_1fd4478b = struct::get(s_unitrigger.target);
		var_1fd4478b struct::delete();
		s_unitrigger struct::delete();
	}
	var_1fd4478b = struct::get("s_ww_quest_rough_statue_" + level.var_9f950fe2);
	v_origin = var_1fd4478b.origin;
	v_angles = var_1fd4478b.angles;
	var_1fd4478b struct::delete();
	level.var_240da80 = util::spawn_model(#"hash_5a9c6a0cacc652bc", v_origin, v_angles);
	var_9581be99 = struct::get_array("s_ww_quest_acid_trap_unitrigger");
	array::thread_all(var_9581be99, &function_a58dfad4);
	zm_crafting::function_d1f16587(#"zblueprint_trap_hellpools", &function_b4bc6524);
}

/*
	Name: function_73808ab9
	Namespace: namespace_574b32d2
	Checksum: 0x9A979A7D
	Offset: 0x1060
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_73808ab9(a_ents)
{
	var_f57bbec0 = a_ents[#"hash_7aff0ee60ddd937b"];
	s_fx = struct::get(#"hash_495fb43788e05676");
	mdl_fx = util::spawn_model("tag_origin", s_fx.origin, s_fx.angles);
	s_fx struct::delete();
	mdl_fx linkto(var_f57bbec0, "tag_fx_jnt");
	mdl_fx clientfield::set("" + #"hash_42cc4bf5e47478c5", 1);
	level.var_1285519 = mdl_fx;
	level scene::remove_scene_func("p8_fxanim_zm_towers_ww_quest_bowl_bundle", &function_73808ab9, "init");
}

/*
	Name: function_eb342c64
	Namespace: namespace_574b32d2
	Checksum: 0xDBB1566C
	Offset: 0x11A8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_eb342c64(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	level flag::wait_till("zm_towers_pap_quest_completed");
}

/*
	Name: function_56486fd0
	Namespace: namespace_574b32d2
	Checksum: 0xF2868C1A
	Offset: 0x11E8
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_56486fd0(b_skipped, var_19e802fa)
{
	level thread scene::play("p8_fxanim_zm_towers_ww_quest_wall_bundle");
}

/*
	Name: function_87c0abfb
	Namespace: namespace_574b32d2
	Checksum: 0x6499AED0
	Offset: 0x1228
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_87c0abfb(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	t_trigger = trigger::wait_till("t_ww_quest_knock_brazier");
	level thread function_be25f239();
}

/*
	Name: function_2f217c86
	Namespace: namespace_574b32d2
	Checksum: 0x9FA98775
	Offset: 0x1280
	Size: 0x204
	Parameters: 2
	Flags: Linked
*/
function function_2f217c86(b_skipped, var_19e802fa)
{
	wait(0.05);
	level.var_1285519 clientfield::set("" + #"hash_42cc4bf5e47478c5", 0);
	level.var_1285519 clientfield::set("" + #"hash_3b746cf6eec416b2", 1);
	level scene::play("p8_fxanim_zm_towers_ww_quest_bowl_bundle");
	level clientfield::set("" + #"hash_584e8f7433246444", 1);
	level flag::set(#"hash_17f15c9242ddea6f");
	wait(1);
	switch(level.var_9f950fe2)
	{
		case "danu":
		{
			str_clientfield = "" + #"hash_418c1c843450232b";
			break;
		}
		case "ra":
		{
			str_clientfield = "" + #"hash_4d547bf36c6cb2d8";
			break;
		}
		case "odin":
		{
			str_clientfield = "" + #"hash_38ba3ad0902aa355";
			break;
		}
		case "zeus":
		{
			str_clientfield = "" + #"hash_24d7233bb17e6558";
			break;
		}
	}
	level clientfield::set(str_clientfield, 1);
}

/*
	Name: function_be25f239
	Namespace: namespace_574b32d2
	Checksum: 0x21B1BF5C
	Offset: 0x1490
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_be25f239()
{
	level endon(#"hash_70b6094c8cd39890", #"hash_9b33f522f6f1424", #"end_game");
	var_7ccafcfd = getent("t_l_t_w_w_q", "targetname");
	level flag::wait_till(#"hash_17f15c9242ddea6f");
	s_info = undefined;
	s_info = var_7ccafcfd waittill(#"trigger");
	e_player = s_info.activator;
	level.var_b2b15659 = 1;
	e_player thread zm_audio::create_and_play_dialog(#"fire_trail", #"active", undefined, 0);
	level.var_b2b15659 = 0;
	level flag::set(#"hash_70b6094c8cd39890");
}

/*
	Name: function_26956e1e
	Namespace: namespace_574b32d2
	Checksum: 0xD3DA7508
	Offset: 0x15D8
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_26956e1e(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	s_loc = struct::get("s_ww_quest_rough_statue_unitrigger_" + level.var_9f950fe2);
	e_player = s_loc zm_unitrigger::function_fac87205(&function_bdcb6aac);
	level notify(#"hash_9b33f522f6f1424");
	e_player thread function_710d3ac7();
}

/*
	Name: function_710d3ac7
	Namespace: namespace_574b32d2
	Checksum: 0x73E94BB4
	Offset: 0x1678
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_710d3ac7()
{
	level.var_b2b15659 = 1;
	self zm_vo::function_a2bd5a0c(#"hash_7cddd6b0ff9e4d32", 0, 0, 9999, 1);
	level.var_b2b15659 = 0;
}

/*
	Name: function_bdcb6aac
	Namespace: namespace_574b32d2
	Checksum: 0xF6986DF9
	Offset: 0x16D0
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function function_bdcb6aac(e_player)
{
	if(!isplayer(e_player) || !isdefined(level.var_240da80))
	{
		return 0;
	}
	var_5168e40f = e_player zm_utility::is_player_looking_at(level.var_240da80.origin, 0.9, 0);
	return var_5168e40f;
}

/*
	Name: function_4f056f0c
	Namespace: namespace_574b32d2
	Checksum: 0xCE61379F
	Offset: 0x1758
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_4f056f0c(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_5cdf5c960293141a");
	level.var_240da80 delete();
	level namespace_6747c550::function_7df6bb60(#"hash_46e7cf2b7aa7c22", 1);
}

/*
	Name: function_a58dfad4
	Namespace: namespace_574b32d2
	Checksum: 0x4A3CB033
	Offset: 0x17D8
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function function_a58dfad4()
{
	var_575ce9bb = struct::get_array(self.target);
	foreach(s_part in var_575ce9bb)
	{
		switch(s_part.script_noteworthy)
		{
			case "hash_1dfc1ec795736a53":
			{
				self.var_9ce49aba = s_part;
				break;
			}
			case "hash_373094cfb6ea84f5":
			{
				self.var_b56f9e01 = s_part;
				break;
			}
		}
	}
}

/*
	Name: function_b4bc6524
	Namespace: namespace_574b32d2
	Checksum: 0x51BC86FC
	Offset: 0x18C0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_b4bc6524()
{
	var_5542e979 = self.script_noteworthy;
	level.var_708e0925 = var_5542e979;
	level flag::set(#"hash_57454e59c155098d");
}

/*
	Name: function_708cd4d
	Namespace: namespace_574b32d2
	Checksum: 0x8D84E57B
	Offset: 0x1910
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_708cd4d(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	level flag::wait_till(#"hash_57454e59c155098d");
}

/*
	Name: function_c4e5bf05
	Namespace: namespace_574b32d2
	Checksum: 0x50A20A49
	Offset: 0x1950
	Size: 0x39C
	Parameters: 2
	Flags: Linked
*/
function function_c4e5bf05(b_skipped, var_19e802fa)
{
	if(b_skipped || var_19e802fa && !isdefined(level.var_708e0925))
	{
		level.var_708e0925 = "ra";
		var_c65eed8e = getentarray("zm_towers_hellpool_ra", "script_noteworthy");
		foreach(part in var_c65eed8e)
		{
			if(part trigger::is_trigger_of_type("trigger_use_new"))
			{
				part triggerenable(1);
				continue;
			}
			part show();
		}
		zm_crafting::function_ca244624(#"zblueprint_trap_hellpools");
		/#
			iprintlnbold("");
		#/
	}
	s_unitrigger = struct::get(level.var_708e0925, "script_ww_quest_acid_trap_unitrigger");
	level.var_2ea12e52 = s_unitrigger;
	level.var_968b0184 = s_unitrigger.var_9ce49aba;
	level.var_1f5e01af = s_unitrigger.var_b56f9e01;
	var_70d5933e = array("danu", "ra", "odin", "zeus");
	arrayremovevalue(var_70d5933e, level.var_708e0925);
	foreach(var_f4dad7ae in var_70d5933e)
	{
		var_dca0e32e = struct::get(var_f4dad7ae, "script_ww_quest_acid_trap_unitrigger");
		var_575ce9bb = struct::get_array(var_dca0e32e.target);
		foreach(s_part in var_575ce9bb)
		{
			s_part struct::delete();
		}
		var_dca0e32e struct::delete();
	}
	level flag::set(#"hash_57454e59c155098d");
	level thread function_d7f0e50e();
}

/*
	Name: function_2eea86a9
	Namespace: namespace_574b32d2
	Checksum: 0xE5468BA
	Offset: 0x1CF8
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_2eea86a9(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	level.var_2ea12e52 zm_unitrigger::create(&function_1308049e, 128);
	level thread function_4c3928a2();
	level flag::wait_till(#"hash_6af037519dceda7a");
}

/*
	Name: function_57b4770f
	Namespace: namespace_574b32d2
	Checksum: 0x592A7988
	Offset: 0x1D80
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function function_57b4770f(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_6af037519dceda7a");
	v_origin = level.var_968b0184.origin;
	v_angles = level.var_968b0184.angles;
	level.var_968b0184 struct::delete();
	level.var_ea8de547 = util::spawn_model(#"hash_5a9c6a0cacc652bc", v_origin, v_angles);
	level namespace_6747c550::function_7df6bb60(#"hash_46e7cf2b7aa7c22", 0);
	if(!b_skipped)
	{
		zm_unitrigger::unregister_unitrigger(level.var_2ea12e52.s_unitrigger);
	}
}

/*
	Name: function_1308049e
	Namespace: namespace_574b32d2
	Checksum: 0x38F28E39
	Offset: 0x1E98
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_1308049e(e_player)
{
	var_5168e40f = e_player zm_utility::is_player_looking_at(level.var_968b0184.origin, 0.9, 0);
	return var_5168e40f;
}

/*
	Name: function_d7f0e50e
	Namespace: namespace_574b32d2
	Checksum: 0x7D5A80A2
	Offset: 0x1EF0
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_d7f0e50e()
{
	level endon(#"hash_30e0e4bbbfc9b7d8");
	while(true)
	{
		s_notify = undefined;
		s_notify = level waittill(#"trap_activated");
		e_trap = s_notify.trap;
		if(isdefined(e_trap))
		{
			str_type = e_trap.script_noteworthy;
			if(str_type === "hellpool")
			{
				level flag::set(#"hash_40f20925227353f4");
				b_active = 1;
				str_id = e_trap.script_string;
				while(b_active)
				{
					s_notify = undefined;
					s_notify = level waittill(#"hash_3c662e7b29cfc3dd");
					if(s_notify.var_be3f58a === str_id)
					{
						b_active = 0;
						break;
					}
				}
				level flag::clear(#"hash_40f20925227353f4");
			}
		}
	}
}

/*
	Name: function_4c3928a2
	Namespace: namespace_574b32d2
	Checksum: 0x7E8FAFFF
	Offset: 0x2040
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_4c3928a2(notifyhash)
{
	level endon(#"hash_6af037519dceda7a");
	level flag::wait_till_clear(#"hash_40f20925227353f4");
	level thread function_7ffb149d();
}

/*
	Name: function_7ffb149d
	Namespace: namespace_574b32d2
	Checksum: 0x598B6ECA
	Offset: 0x20A8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_7ffb149d()
{
	level endon_callback(&function_4c3928a2, #"hash_40f20925227353f4");
	level.var_2ea12e52 waittill(#"trigger_activated");
	level flag::set(#"hash_6af037519dceda7a");
}

/*
	Name: function_a1e2245
	Namespace: namespace_574b32d2
	Checksum: 0x7AD755C6
	Offset: 0x2120
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_a1e2245(b_skipped)
{
	if(!b_skipped)
	{
		level flag::wait_till(#"hash_40f20925227353f4");
		wait(2);
		level.var_ea8de547 clientfield::increment("" + #"hash_3dca6eaa62a8f783");
		wait(3);
	}
}

/*
	Name: function_e02f2459
	Namespace: namespace_574b32d2
	Checksum: 0x7CAA74C7
	Offset: 0x21A0
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_e02f2459(b_skipped, var_19e802fa)
{
	v_origin = level.var_1f5e01af.origin;
	v_angles = level.var_1f5e01af.angles;
	level.var_1f5e01af struct::delete();
	level.var_f49fd32c = util::spawn_model(#"hash_2a69359be4696c83", v_origin, v_angles);
	level.var_ea8de547 delete();
}

/*
	Name: function_9ef8d102
	Namespace: namespace_574b32d2
	Checksum: 0xF9130E75
	Offset: 0x2268
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_9ef8d102(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	level flag::wait_till_clear(#"hash_40f20925227353f4");
	level.var_2ea12e52 zm_unitrigger::create(&function_69a2caa1, 128);
	level thread function_7df5ca0b();
	level flag::wait_till(#"hash_30e0e4bbbfc9b7d8");
}

/*
	Name: function_1c380f29
	Namespace: namespace_574b32d2
	Checksum: 0xE089B259
	Offset: 0x2310
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_1c380f29(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_30e0e4bbbfc9b7d8");
	level.var_2ea12e52 struct::delete();
	level.var_f49fd32c delete();
	level namespace_6747c550::function_7df6bb60(#"hash_46e7cf2b7aa7c22", 2);
	if(!b_skipped)
	{
		zm_unitrigger::unregister_unitrigger(level.var_2ea12e52.s_unitrigger);
	}
}

/*
	Name: function_69a2caa1
	Namespace: namespace_574b32d2
	Checksum: 0xE53F9795
	Offset: 0x23D0
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_69a2caa1(e_player)
{
	var_7b371ada = level.var_f49fd32c;
	var_5168e40f = 0;
	if(isdefined(var_7b371ada) && isdefined(e_player))
	{
		var_5168e40f = e_player zm_utility::is_player_looking_at(var_7b371ada.origin, 0.9, 0);
	}
	return var_5168e40f;
}

/*
	Name: function_7df5ca0b
	Namespace: namespace_574b32d2
	Checksum: 0xFC6B8E4C
	Offset: 0x2450
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_7df5ca0b(notifyhash)
{
	level endon(#"hash_30e0e4bbbfc9b7d8");
	level flag::wait_till_clear(#"hash_40f20925227353f4");
	level thread function_10692994();
}

/*
	Name: function_10692994
	Namespace: namespace_574b32d2
	Checksum: 0x4D4DE80E
	Offset: 0x24B8
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function function_10692994()
{
	level endon_callback(&function_7df5ca0b, #"hash_40f20925227353f4");
	var_be17187b = undefined;
	var_be17187b = level.var_2ea12e52 waittill(#"trigger_activated");
	level flag::set(#"hash_30e0e4bbbfc9b7d8");
	e_player = var_be17187b.e_who;
	level.var_b2b15659 = 1;
	e_player zm_vo::function_a2bd5a0c(#"hash_79d38c133d9291c4", 0, 0, 9999, 1);
	level.var_b2b15659 = 0;
}

/*
	Name: function_dd053937
	Namespace: namespace_574b32d2
	Checksum: 0x3A57D976
	Offset: 0x2598
	Size: 0x2F6
	Parameters: 1
	Flags: Linked
*/
function function_dd053937(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	var_a0788e41 = 1;
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			var_a0788e41 = 0;
		}
	#/
	enable_despawn = 0;
	while(!enable_despawn)
	{
		var_ecc87a75 = 0;
		while(!var_ecc87a75)
		{
			var_9345b0e9 = [];
			if(var_a0788e41)
			{
				level waittill(#"start_of_round");
			}
			foreach(e_player in util::get_active_players())
			{
				var_7df228aa = e_player.var_7df228aa;
				if(isdefined(var_7df228aa))
				{
					var_def266a8 = var_7df228aa.var_def266a8;
					if(e_player namespace_ebd828b::function_aa0b6eb())
					{
						if(!isdefined(var_9345b0e9))
						{
							var_9345b0e9 = [];
						}
						else if(!isarray(var_9345b0e9))
						{
							var_9345b0e9 = array(var_9345b0e9);
						}
						var_9345b0e9[var_9345b0e9.size] = e_player;
					}
				}
			}
			if(var_9345b0e9.size > 0)
			{
				var_ecc87a75 = 1;
				break;
			}
			waitframe(1);
		}
		level flag::clear(#"hash_d9ce740cc4b8285");
		level thread function_963a76cf();
		foreach(e_player in var_9345b0e9)
		{
			if(isdefined(e_player))
			{
				e_player thread function_6f7d36ec();
			}
		}
		level flag::wait_till_any(array(#"hash_d9ce740cc4b8285", #"hash_200151b21f16734f"));
		if(level flag::get(#"hash_200151b21f16734f"))
		{
			enable_despawn = 1;
			break;
		}
	}
}

/*
	Name: function_4509873
	Namespace: namespace_574b32d2
	Checksum: 0x3947A1B7
	Offset: 0x2898
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_4509873(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_200151b21f16734f");
}

/*
	Name: function_963a76cf
	Namespace: namespace_574b32d2
	Checksum: 0xD8830724
	Offset: 0x28D8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_963a76cf()
{
	level endon(#"hash_d9ce740cc4b8285");
	level waittill(#"end_of_round");
	level flag::set(#"hash_200151b21f16734f");
}

/*
	Name: function_6f7d36ec
	Namespace: namespace_574b32d2
	Checksum: 0x1EB613F5
	Offset: 0x2938
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_6f7d36ec()
{
	level endon(#"hash_d9ce740cc4b8285", #"hash_200151b21f16734f");
	self endon(#"death");
	var_5d275db0 = 0;
	while(!var_5d275db0)
	{
		var_7df228aa = self.var_7df228aa;
		if(isdefined(var_7df228aa))
		{
			var_def266a8 = var_7df228aa.var_def266a8;
			if(!self namespace_ebd828b::function_aa0b6eb())
			{
				var_5d275db0 = 1;
				break;
			}
		}
		waitframe(1);
	}
	level flag::set(#"hash_d9ce740cc4b8285");
}

/*
	Name: function_a616131a
	Namespace: namespace_574b32d2
	Checksum: 0xFF78639F
	Offset: 0x2A18
	Size: 0x522
	Parameters: 1
	Flags: Linked
*/
function function_a616131a(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	var_97323694 = struct::get_array("s_ww_quest_impervious_jar_start");
	var_a53ca88a = [];
	foreach(e_player in util::get_active_players())
	{
		if(isdefined(e_player))
		{
			foreach(s_option in var_97323694)
			{
				if(e_player util::is_player_looking_at(s_option.origin, 0.9, 0))
				{
					if(!isdefined(var_a53ca88a))
					{
						var_a53ca88a = [];
					}
					else if(!isarray(var_a53ca88a))
					{
						var_a53ca88a = array(var_a53ca88a);
					}
					if(!isinarray(var_a53ca88a, s_option))
					{
						var_a53ca88a[var_a53ca88a.size] = s_option;
					}
				}
			}
		}
	}
	if(var_a53ca88a.size == 0)
	{
		var_1a472b57 = array::random(var_97323694);
	}
	else
	{
		var_1a472b57 = array::random(var_a53ca88a);
	}
	arrayremovevalue(var_97323694, var_1a472b57);
	foreach(s_option in var_97323694)
	{
		s_end = struct::get(s_option.target);
		s_end struct::delete();
		s_option struct::delete();
	}
	namespace_11c28b18::function_afd37143(#"hash_28dbb5b91d8a954e");
	var_8fa68ef = struct::get(var_1a472b57.target);
	var_69450ec5 = util::spawn_model(#"p8_zm_gla_jar_gold_01", var_1a472b57.origin, var_1a472b57.angles);
	if(!isdefined(var_69450ec5))
	{
		/#
			assert(0, "");
		#/
		return;
	}
	var_69450ec5 notsolid();
	var_69450ec5 clientfield::set("" + #"hash_2c6f04d08665dbda", 1);
	n_time = var_69450ec5 zm_utility::fake_physicslaunch(var_8fa68ef.origin, 1000);
	wait(n_time);
	var_69450ec5.origin = var_8fa68ef.origin;
	var_69450ec5.angles = var_8fa68ef.angles;
	var_69450ec5 clientfield::set("" + #"hash_2a332df32456c86f", 1);
	var_69450ec5 clientfield::set("" + #"hash_2c6f04d08665dbda", 0);
	s_loc = struct::get(var_8fa68ef.target);
	s_loc.var_6d6bbd67 = var_69450ec5;
	e_player = s_loc zm_unitrigger::function_fac87205(&function_5f2a9b69);
	var_69450ec5 delete();
	level.var_b2b15659 = 1;
	e_player thread zm_vo::function_a2bd5a0c(#"hash_2b2a7c0ea867948e", 0, 0, 9999, 1);
	level.var_b2b15659 = 0;
}

/*
	Name: function_605806f
	Namespace: namespace_574b32d2
	Checksum: 0x29190CCE
	Offset: 0x2F48
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_605806f(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_45259bb6368fc0d3");
	level namespace_6747c550::function_7df6bb60(#"hash_d3e328bb2670edf", 1);
}

/*
	Name: function_5f2a9b69
	Namespace: namespace_574b32d2
	Checksum: 0x27186125
	Offset: 0x2FB0
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function function_5f2a9b69(e_player)
{
	if(!isdefined(self) || !isdefined(self.stub) || !isdefined(self.stub.related_parent) || !isdefined(self.stub.related_parent.var_6d6bbd67))
	{
		return 0;
	}
	var_69450ec5 = self.stub.related_parent.var_6d6bbd67;
	var_5168e40f = e_player zm_utility::is_player_looking_at(var_69450ec5.origin, 0.9, 0);
	return var_5168e40f;
}

/*
	Name: function_ac4e38bc
	Namespace: namespace_574b32d2
	Checksum: 0xBF69CDCE
	Offset: 0x3080
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_ac4e38bc(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	b_planted = 0;
	while(!b_planted)
	{
		var_be17187b = trigger::wait_till("t_ww_quest_spile_damage_trigger");
		e_player = var_be17187b.who;
		if(isplayer(e_player))
		{
			b_planted = 1;
			break;
		}
	}
}

/*
	Name: function_8c32234c
	Namespace: namespace_574b32d2
	Checksum: 0x15EDE224
	Offset: 0x3118
	Size: 0x144
	Parameters: 2
	Flags: Linked
*/
function function_8c32234c(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_5649f57b918f85f8");
	s_spile = struct::get("s_ww_quest_spile_in_tree");
	v_origin = s_spile.origin;
	v_angles = s_spile.angles;
	s_spile struct::delete();
	var_7b371ada = util::spawn_model(#"hash_2a69359be4696c83", v_origin, v_angles);
	var_7b371ada thread function_336ee69f();
	t_trigger = getent("t_ww_quest_spile_damage_trigger", "targetname");
	t_trigger delete();
	level namespace_6747c550::function_7df6bb60(#"hash_46e7cf2b7aa7c22", 0);
}

/*
	Name: function_336ee69f
	Namespace: namespace_574b32d2
	Checksum: 0x67FA4C4B
	Offset: 0x3268
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_336ee69f()
{
	level endon(#"end_game");
	self endon(#"death");
	wait(3);
	self clientfield::increment("" + #"hash_48ad84f9cf6a33f0");
}

/*
	Name: function_ec26e009
	Namespace: namespace_574b32d2
	Checksum: 0x8134809D
	Offset: 0x32D0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_ec26e009(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	s_loc = struct::get("s_ww_quest_place_impervious_jar");
	s_loc zm_unitrigger::function_fac87205(&function_f6781b0f);
}

/*
	Name: function_4877f171
	Namespace: namespace_574b32d2
	Checksum: 0x5AE255E6
	Offset: 0x3330
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function function_4877f171(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_30ca6a723fbb84e9");
	s_jar = struct::get("s_ww_quest_jar_under_tree");
	v_origin = s_jar.origin;
	v_angles = s_jar.angles;
	var_69450ec5 = util::spawn_model(#"p8_zm_gla_jar_gold_01", v_origin, v_angles);
	var_f3747cdd = util::spawn_model(#"hash_2b0b7a64db1fe73d", v_origin - vectorscale((0, 0, 1), 2048), v_angles);
	level.var_6d6bbd67 = var_69450ec5;
	level.var_1028e128 = var_f3747cdd;
	level namespace_6747c550::function_7df6bb60(#"hash_d3e328bb2670edf", 0);
}

/*
	Name: function_f6781b0f
	Namespace: namespace_574b32d2
	Checksum: 0xC044DC89
	Offset: 0x3478
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_f6781b0f(e_player)
{
	s_jar = struct::get("s_ww_quest_jar_under_tree");
	var_5168e40f = e_player zm_utility::is_player_looking_at(s_jar.origin, 0.9, 0);
	return var_5168e40f;
}

/*
	Name: function_bbdde10e
	Namespace: namespace_574b32d2
	Checksum: 0x523824B
	Offset: 0x34F0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_bbdde10e(b_skipped)
{
	if(b_skipped)
	{
		return;
	}
	level waittill(#"end_of_round", #"between_round_over");
}

/*
	Name: function_40f77b4a
	Namespace: namespace_574b32d2
	Checksum: 0xDF119B2E
	Offset: 0x3538
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_40f77b4a(b_skipped, var_19e802fa)
{
	level.var_1028e128.origin = level.var_1028e128.origin + vectorscale((0, 0, 1), 2048);
	waitframe(1);
	level.var_6d6bbd67 delete();
}

/*
	Name: function_ab13e06
	Namespace: namespace_574b32d2
	Checksum: 0xD9E1A9DE
	Offset: 0x35A8
	Size: 0x192
	Parameters: 1
	Flags: Linked
*/
function function_ab13e06(b_skipped)
{
	level.disable_firesale_drop = 1;
	var_5804e911 = zm_powerups::get_powerups();
	if(isarray(var_5804e911))
	{
		foreach(var_9c0bf2db in arraycopy(var_5804e911))
		{
			if(isdefined(var_9c0bf2db) && var_9c0bf2db.powerup_name === "fire_sale")
			{
				var_9c0bf2db thread zm_powerups::powerup_delete();
			}
		}
	}
	if(b_skipped)
	{
		return;
	}
	s_loc = struct::get("s_ww_quest_place_impervious_jar");
	e_player = s_loc zm_unitrigger::function_fac87205(&function_f6781b0f);
	level.var_b2b15659 = 1;
	e_player thread zm_vo::function_a2bd5a0c(#"hash_7afc64a7fa6a0db4", 0, 0, 9999, 1);
	level.var_b2b15659 = 0;
}

/*
	Name: function_868dcb6d
	Namespace: namespace_574b32d2
	Checksum: 0x99A80ED5
	Offset: 0x3748
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_868dcb6d(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_1c66e5c351c08de1");
	level.var_1028e128 delete();
	level namespace_6747c550::function_7df6bb60(#"hash_d3e328bb2670edf", 2);
}

/*
	Name: function_869d271a
	Namespace: namespace_574b32d2
	Checksum: 0xBBC68994
	Offset: 0x37C8
	Size: 0x398
	Parameters: 1
	Flags: Linked
*/
function function_869d271a(b_skipped)
{
	var_6c9a8875 = array("tower_a_chest", "tower_b_chest", "tower_c_chest", "tower_d_chest", "tower_a_lower_chest", "tower_b_lower_chest", "tower_c_lower_chest", "tower_d_lower_chest", "danu_zeus_tunnel_chest", "ra_odin_tunnel_chest");
	level.var_13fc0c88 = [];
	level.var_b7ef852e = [];
	foreach(var_79ed50b4 in var_6c9a8875)
	{
		var_545bb17f = getent(var_79ed50b4, "targetname");
		s_chest = struct::get(var_79ed50b4, "script_noteworthy");
		if(!isdefined(level.var_13fc0c88))
		{
			level.var_13fc0c88 = [];
		}
		else if(!isarray(level.var_13fc0c88))
		{
			level.var_13fc0c88 = array(level.var_13fc0c88);
		}
		level.var_13fc0c88[level.var_13fc0c88.size] = var_545bb17f;
		if(!isdefined(level.var_b7ef852e))
		{
			level.var_b7ef852e = [];
		}
		else if(!isarray(level.var_b7ef852e))
		{
			level.var_b7ef852e = array(level.var_b7ef852e);
		}
		level.var_b7ef852e[level.var_b7ef852e.size] = s_chest;
	}
	level thread function_9da58e50();
	if(b_skipped)
	{
		return;
	}
	foreach(var_545bb17f in level.var_13fc0c88)
	{
		var_545bb17f function_9c9af843();
		var_545bb17f thread function_f250013e();
		var_545bb17f thread function_9b311308();
	}
	level flag::wait_till(#"hash_77ff9a8101ea687b");
	foreach(var_545bb17f in level.var_13fc0c88)
	{
		var_545bb17f function_2d53ee2a();
	}
}

/*
	Name: function_79875787
	Namespace: namespace_574b32d2
	Checksum: 0x656DF39
	Offset: 0x3B68
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_79875787(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_77ff9a8101ea687b");
	zm_weapons::function_603af7a8(getweapon(#"hash_4ae11871b1233211"));
	callback::on_spawned(&function_e7e07200);
	array::thread_all(level.players, &function_e7e07200);
	level.customrandomweaponweights = &function_73ed3038;
	level namespace_6747c550::function_7df6bb60(#"hash_d3e328bb2670edf", 0);
	/#
		if(b_skipped)
		{
			iprintlnbold("");
		}
	#/
}

/*
	Name: function_e7e07200
	Namespace: namespace_574b32d2
	Checksum: 0xC1CBE68B
	Offset: 0x3C88
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function function_e7e07200()
{
	if(isdefined(self.var_afb3ba4e))
	{
		self.var_edd0b994 = self.var_afb3ba4e;
		self.var_afb3ba4e = undefined;
	}
}

/*
	Name: function_d317ceba
	Namespace: namespace_574b32d2
	Checksum: 0xAE3742D9
	Offset: 0x3CB8
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function function_d317ceba()
{
	if(isdefined(self.var_edd0b994))
	{
		self.var_afb3ba4e = self.var_edd0b994;
		self.var_edd0b994 = undefined;
	}
}

/*
	Name: function_f250013e
	Namespace: namespace_574b32d2
	Checksum: 0xBFF89839
	Offset: 0x3CE8
	Size: 0x12E
	Parameters: 0
	Flags: Linked
*/
function function_f250013e()
{
	level endon(#"hash_77ff9a8101ea687b", #"fire_sale_on");
	while(true)
	{
		str_state = self zm_magicbox::get_magic_box_zbarrier_state();
		n_index = array::find(level.chests, self.owner);
		switch(str_state)
		{
			case "close":
			case "arriving":
			case "initial":
			{
				if(level.chest_index === n_index)
				{
					self thread function_1da98a12();
				}
				break;
			}
			default:
			{
				self thread function_2d53ee2a();
				break;
			}
		}
		self waittill(#"zbarrier_state_change");
	}
}

/*
	Name: function_9b311308
	Namespace: namespace_574b32d2
	Checksum: 0xC9958FB6
	Offset: 0x3E20
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function function_9b311308()
{
	level endon(#"hash_77ff9a8101ea687b");
	while(true)
	{
		level waittill(#"fire_sale_on");
		self function_2d53ee2a();
		level waittill(#"fire_sale_off");
		self thread function_f250013e();
	}
}

/*
	Name: function_9c9af843
	Namespace: namespace_574b32d2
	Checksum: 0x463CF5E2
	Offset: 0x3EB0
	Size: 0x1AA
	Parameters: 0
	Flags: Linked
*/
function function_9c9af843()
{
	str_targetname = self.targetname;
	switch(str_targetname)
	{
		case "tower_a_chest":
		{
			str_loc = "odin_top_floor";
			break;
		}
		case "tower_b_chest":
		{
			str_loc = "zeus_top_floor";
			break;
		}
		case "tower_c_chest":
		{
			str_loc = "danu_top_floor";
			break;
		}
		case "tower_d_chest":
		{
			str_loc = "ra_top_floor";
			break;
		}
		case "tower_a_lower_chest":
		{
			str_loc = "odin_basement";
			break;
		}
		case "tower_b_lower_chest":
		{
			str_loc = "zeus_basement";
			break;
		}
		case "tower_c_lower_chest":
		{
			str_loc = "danu_basement";
			break;
		}
		case "tower_d_lower_chest":
		{
			str_loc = "ra_basement";
			break;
		}
		case "ra_odin_tunnel_chest":
		{
			str_loc = "ra_odin_tunnel";
			break;
		}
		case "danu_zeus_tunnel_chest":
		{
			str_loc = "danu_zeus_tunnel";
			break;
		}
	}
	s_loc = struct::get("s_ww_quest_magic_box_unitrigger_" + str_loc);
	self.var_732ed72e = s_loc;
}

/*
	Name: function_1da98a12
	Namespace: namespace_574b32d2
	Checksum: 0x21DB902
	Offset: 0x4068
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_1da98a12()
{
	self notify("5951a9603b9ff9a3");
	self endon("5951a9603b9ff9a3");
	level endon(#"hash_77ff9a8101ea687b");
	self endon(#"hash_34af1b1562febca4");
	s_loc = self.var_732ed72e;
	if(!isdefined(self.var_1ac569e5))
	{
		self.var_1ac569e5 = s_loc zm_unitrigger::create(&function_6919af04);
	}
	var_be17187b = undefined;
	var_be17187b = s_loc waittill(#"trigger_activated");
	e_player = var_be17187b.e_who;
	level.var_b2b15659 = 1;
	e_player thread zm_vo::function_a2bd5a0c(#"hash_1c667d0f1af843a9", 0, 0, 9999, 1);
	level.var_b2b15659 = 0;
	level flag::set(#"hash_77ff9a8101ea687b");
}

/*
	Name: function_6919af04
	Namespace: namespace_574b32d2
	Checksum: 0xBFF530D6
	Offset: 0x41B0
	Size: 0x150
	Parameters: 1
	Flags: Linked
*/
function function_6919af04(e_player)
{
	if(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") === 1 || e_player hasweapon(level.var_3891e803) || e_player hasweapon(level.var_d7f4cb84) || e_player hasweapon(level.var_29cce7eb) || e_player hasweapon(level.var_bc26d00c))
	{
		self sethintstringforplayer(e_player, "");
		return 0;
	}
	if(function_8b1a219a())
	{
		self sethintstringforplayer(e_player, #"hash_18341747d3b4143a");
	}
	else
	{
		self sethintstringforplayer(e_player, #"hash_a57efeec61b5a4e");
	}
	return 1;
}

/*
	Name: function_2d53ee2a
	Namespace: namespace_574b32d2
	Checksum: 0x4D1D7DFC
	Offset: 0x4310
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_2d53ee2a()
{
	self notify(#"hash_34af1b1562febca4");
	s_loc = self.var_732ed72e;
	if(isdefined(self.var_1ac569e5))
	{
		zm_unitrigger::unregister_unitrigger(s_loc.s_unitrigger);
		self.var_1ac569e5 = undefined;
	}
}

/*
	Name: function_9da58e50
	Namespace: namespace_574b32d2
	Checksum: 0xB3DB02F8
	Offset: 0x4378
	Size: 0x2BC
	Parameters: 0
	Flags: Linked
*/
function function_9da58e50()
{
	level endon(#"end_game");
	level flag::wait_till(#"hash_77ff9a8101ea687b");
	var_2002b43f = level.chests[level.chest_index].zbarrier;
	playsoundatposition(#"hash_f481d0cba05eda5", var_2002b43f.origin);
	var_2002b43f clientfield::set("" + #"hash_3974bea828fbf7f7", 1);
	var_2002b43f clientfield::set("" + #"hash_3a51c9895d4afcf7", 1);
	while(true)
	{
		var_2002b43f waittill(#"zbarrier_state_change");
		if(var_2002b43f getzbarrierpiecestate(2) === "opening")
		{
			break;
		}
	}
	var_2002b43f clientfield::set("" + #"hash_3974bea828fbf7f7", 0);
	var_2002b43f clientfield::set("" + #"hash_5dc6f97e5850e1d1", 1);
	var_2002b43f clientfield::set("" + #"hash_1add6939914df65a", 1);
	level flag::wait_till_any(array(#"hash_3ac6f9944962bd4c", #"hash_786b9153c754d127"));
	var_2002b43f clientfield::set("" + #"hash_5dc6f97e5850e1d1", 0);
	var_2002b43f clientfield::set("" + #"hash_1add6939914df65a", 0);
	var_2002b43f clientfield::set("" + #"hash_3a51c9895d4afcf7", 0);
}

/*
	Name: function_73ed3038
	Namespace: namespace_574b32d2
	Checksum: 0x1E5293C0
	Offset: 0x4640
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function function_73ed3038(a_keys)
{
	level.customrandomweaponweights = undefined;
	arrayinsert(a_keys, getweapon(#"hash_4ae11871b1233211"), 0);
	return a_keys;
}

/*
	Name: function_3cadd22
	Namespace: namespace_574b32d2
	Checksum: 0xA789BE3D
	Offset: 0x4698
	Size: 0x2A0
	Parameters: 1
	Flags: Linked
*/
function function_3cadd22(b_skipped)
{
	foreach(s_chest in level.var_b7ef852e)
	{
		if(!isdefined(s_chest.no_fly_away))
		{
			s_chest.no_fly_away = 1;
			s_chest.var_31212fac = 1;
		}
	}
	array::thread_all(level.var_13fc0c88, &function_c448aa83);
	level.chests[0].zbarrier clientfield::set("force_stream_magicbox", 1);
	level flag::wait_till_any(array(#"hash_3ac6f9944962bd4c", #"hash_786b9153c754d127"));
	callback::remove_on_spawned(&function_e7e07200);
	array::thread_all(level.players, &function_d317ceba);
	foreach(s_chest in level.var_b7ef852e)
	{
		if(isdefined(s_chest.var_31212fac))
		{
			s_chest.no_fly_away = undefined;
			s_chest.var_31212fac = undefined;
		}
	}
	level.disable_firesale_drop = undefined;
	foreach(e_player in level.players)
	{
		e_player clientfield::increment_to_player("" + #"hash_47e0e1e96b037286");
	}
}

/*
	Name: function_f04288b4
	Namespace: namespace_574b32d2
	Checksum: 0x81249D98
	Offset: 0x4940
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_f04288b4(b_skipped, var_19e802fa)
{
}

/*
	Name: function_c448aa83
	Namespace: namespace_574b32d2
	Checksum: 0xA46B5F1D
	Offset: 0x4960
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_c448aa83()
{
	level endon(#"hash_631e8676a2fa932b");
	self waittill(#"opened");
	level.var_3064d5f7 = self.owner;
	level.var_3064d5f7 thread function_61280c4d();
	self thread function_da474552();
	level flag::set(#"hash_631e8676a2fa932b");
}

/*
	Name: function_61280c4d
	Namespace: namespace_574b32d2
	Checksum: 0x164B2E5C
	Offset: 0x4A08
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_61280c4d()
{
	level endon(#"hash_3ac6f9944962bd4c", #"hash_786b9153c754d127");
	self waittill(#"user_grabbed_weapon");
	level flag::set(#"hash_3ac6f9944962bd4c");
}

/*
	Name: function_da474552
	Namespace: namespace_574b32d2
	Checksum: 0x13A98190
	Offset: 0x4A78
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_da474552()
{
	level endon(#"hash_786b9153c754d127", #"hash_3ac6f9944962bd4c");
	while(self getzbarrierpiecestate(2) !== "closing")
	{
		waitframe(1);
	}
	level flag::set(#"hash_786b9153c754d127");
}

