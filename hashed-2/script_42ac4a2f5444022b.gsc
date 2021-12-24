// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b10fdf0addd52e;
#using script_387eab232fe22983;
#using script_3e5ec44cfab7a201;
#using script_3f9e0dc8454d98e1;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using script_7e59d7bba853fe4b;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_mansion_pap_quest.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_7922d3d4;

/*
	Name: init
	Namespace: namespace_7922d3d4
	Checksum: 0x39C23500
	Offset: 0xA40
	Size: 0x3F4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("allplayers", "" + #"hash_6e7b9ac29b5ccee1", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_14f3f35558fd380b", 8000, getminbitcountfornum(3), "int");
	clientfield::register("scriptmover", "" + #"wisp_fx", 8000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_2108935a0c33f89a", 8000, getminbitcountfornum(3), "int");
	namespace_617a54f4::function_d8383812(#"soul_capture_kp1", 8000, #"kp_1", &function_4175b958, &function_138b784e, 1);
	namespace_617a54f4::function_d8383812(#"soul_capture_kp2", 8000, #"kp_2", &function_53e85e3d, &function_25d21cdb, 1);
	namespace_617a54f4::function_d8383812(#"soul_capture_kp3", 8000, #"kp_3", &function_5e8b7383, &function_28082147, 1);
	namespace_617a54f4::function_d8383812(#"soul_capture_kp1_halfway", 8000, #"hash_5ff0996978af5e05", &function_a23300bc, &function_3d90aae2, 1);
	namespace_617a54f4::function_d8383812(#"soul_capture_kp2_halfway", 8000, #"hash_2e71806f86ca448c", &function_ecb921f0, &function_49798eb9, 1);
	namespace_617a54f4::function_d8383812(#"soul_capture_kp3_halfway", 8000, #"hash_11f38acf5e773a0b", &function_ba203e13, &function_60bda2cf, 1);
	namespace_617a54f4::function_d8383812(#"soul_capture_forest", 8000, #"kp_forest", &is_soul_capture_forest, &function_b570f926, 1);
	init_flags();
	function_c739f755();
	level thread function_c6e2a4fd();
	level thread function_6eb39fe4();
	level thread function_b8cc9d7e();
}

/*
	Name: function_6eb39fe4
	Namespace: namespace_7922d3d4
	Checksum: 0x210AB6FA
	Offset: 0xE40
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_6eb39fe4()
{
	level flag::wait_till("open_pap");
	if(zm_utility::function_e51dc2d8())
	{
		if(namespace_59ff1d6c::function_901b751c(#"hash_3c5363541b97ca3e") && namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") != 2)
		{
			namespace_ee206246::start(#"hash_7242bba9d0b132f5");
		}
	}
}

/*
	Name: function_b8cc9d7e
	Namespace: namespace_7922d3d4
	Checksum: 0xFC0EDF8A
	Offset: 0xEE8
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_b8cc9d7e()
{
	var_74abfa21 = getent("knight_model_cemetery", "targetname");
	var_74abfa21 hidepart("tag_stone_01", "p8_zm_man_statue_kisa_stone_01", 1);
	var_4703a54b = getent("knight_model_main_hall", "targetname");
	var_4703a54b hidepart("tag_stone_02", "p8_zm_man_statue_kisa_stone_02", 1);
	var_5528f605 = getent("knight_model_greenhouse", "targetname");
	var_5528f605 hidepart("tag_stone_03", "p8_zm_man_statue_kisa_stone_03", 1);
}

/*
	Name: function_c6e2a4fd
	Namespace: namespace_7922d3d4
	Checksum: 0x973B34F0
	Offset: 0xFE8
	Size: 0x1D8
	Parameters: 0
	Flags: Linked
*/
function function_c6e2a4fd()
{
	level flag::wait_till("all_players_spawned");
	level thread forest_entrance();
	level thread zmb_ee_key_pickupmemberdeath();
	var_65c9997c = getent("stone_forest", "targetname");
	var_65c9997c ghost();
	var_5757942c = getentarray("kp_mark", "targetname");
	foreach(var_5f3c4fab in var_5757942c)
	{
		var_5f3c4fab ghost();
	}
	var_67b37a67 = struct::get_array("fireplace_location");
	foreach(s_fireplace in var_67b37a67)
	{
		s_fireplace thread function_8c4357b4("hi", 1);
	}
}

/*
	Name: function_8c4357b4
	Namespace: namespace_7922d3d4
	Checksum: 0xB3C2B30B
	Offset: 0x11C8
	Size: 0x1B4
	Parameters: 2
	Flags: Linked
*/
function function_8c4357b4(str_state, b_on)
{
	if(self.script_noteworthy === "kp_fireplace_main_hall")
	{
		if(isdefined(b_on) && b_on)
		{
			exploder::exploder((("exp_lgt_fireplace_mainhall_" + self.script_int) + "_") + str_state);
		}
		else
		{
			exploder::stop_exploder((("exp_lgt_fireplace_mainhall_" + self.script_int) + "_") + str_state);
		}
	}
	else if(self.script_noteworthy === "kp_fireplace_cemetery")
	{
		if(isdefined(b_on) && b_on)
		{
			exploder::exploder((("exp_lgt_fireplace_cemetery_" + self.script_int) + "_") + str_state);
		}
		else
		{
			exploder::stop_exploder((("exp_lgt_fireplace_cemetery_" + self.script_int) + "_") + str_state);
		}
	}
	else if(isdefined(b_on) && b_on)
	{
		exploder::exploder((("exp_lgt_fireplace_greenhouse_" + self.script_int) + "_") + str_state);
	}
	else
	{
		exploder::stop_exploder((("exp_lgt_fireplace_greenhouse_" + self.script_int) + "_") + str_state);
	}
}

/*
	Name: init_flags
	Namespace: namespace_7922d3d4
	Checksum: 0x2C983D19
	Offset: 0x1388
	Size: 0x324
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"kp_upg_main");
	level flag::init(#"kp_upg_dead");
	level flag::init(#"kp_upg_green");
	level flag::init(#"hash_4e56d6c8c78b24ef");
	level flag::init(#"hash_737628b9329f3e72");
	level flag::init(#"hash_72e622de2019c9f5");
	level flag::init(#"hash_1ccd179637a573e3");
	level flag::init(#"hash_70c18019036e06");
	level flag::init(#"hash_7c0a6f1432d54fc5");
	level flag::init(#"knight_main_hall_stationed");
	level flag::init(#"knight_cemetery_stationed");
	level flag::init(#"knight_greenhouse_stationed");
	level flag::init(#"hash_59379e190111ef24");
	level flag::init(#"hash_6e8014ad2f5a3a5");
	level flag::init(#"hash_d491aae3ed3bc7e");
	level flag::init(#"hash_4751f59c00375059");
	level flag::init(#"hash_2427d27d352e9454");
	level flag::init(#"forest_final");
	level flag::init(#"forest_complete");
	level flag::init(#"hash_2d21160da504fb1");
	level flag::init(#"hash_6402d013069eb3a");
	level flag::init(#"hash_4b00aa230ebbe82b");
	level flag::init(#"hash_775ff2ad49f494a7");
	level flag::init(#"hash_7583b516d2aab62e");
	level flag::init(#"hash_4ee2d51615eadbb");
}

/*
	Name: function_c739f755
	Namespace: namespace_7922d3d4
	Checksum: 0x5FD540DC
	Offset: 0x16B8
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_c739f755()
{
	namespace_ee206246::register(#"hash_7242bba9d0b132f5", #"step_1", #"hash_54cb84780c19a836", &function_cdfe68a2, &function_c5868f47);
	namespace_ee206246::register(#"hash_7242bba9d0b132f5", #"step_2", #"hash_54cb83780c19a683", &function_a03f8d25, &function_f05be4f1);
	namespace_ee206246::register(#"hash_7242bba9d0b132f5", #"step_3", #"hash_54cb82780c19a4d0", &function_aa79a199, &function_bafa7a2b);
	namespace_ee206246::register(#"hash_7242bba9d0b132f5", #"step_4", #"hash_54cb89780c19b0b5", &function_86e35a69, &function_a93d56b1);
}

/*
	Name: function_cdfe68a2
	Namespace: namespace_7922d3d4
	Checksum: 0xE396C331
	Offset: 0x1848
	Size: 0x224
	Parameters: 1
	Flags: Linked
*/
function function_cdfe68a2(var_a276c861)
{
	var_65c9997c = getent("gazing_stone_main_hall", "targetname");
	if(isdefined(var_65c9997c))
	{
		var_47323b73 = var_65c9997c zm_unitrigger::create(undefined, 64, &function_55b79f54);
		var_47323b73.str_loc = "main_hall";
		var_47323b73.var_f0e6c7a2 = var_65c9997c;
		if(!var_47323b73.var_f0e6c7a2 flag::exists(#"flag_gazing_stone_in_use"))
		{
			var_47323b73.var_f0e6c7a2 flag::init(#"flag_gazing_stone_in_use");
		}
	}
	level.var_7f30bc18 = 0;
	level.var_6d7e18b3 = 0;
	level.var_3224a1fd = 0;
	level.n_forest = 0;
	level.var_835c3546 = 0;
	level.var_2ba64f64 = 0;
	level.var_94c6e50c = 0;
	level.var_dc3a898e = 1;
	level.var_ded69395 = 1;
	level.var_5f9f8ce8 = 1;
	if(!var_a276c861)
	{
		level flag::wait_till(#"gazed_main_hall");
		level namespace_6747c550::function_7df6bb60(#"hash_7b00754a8b214587", 1);
		level thread function_3207f433();
		level flag::wait_till_all(array(#"kp_upg_main", #"kp_upg_dead", #"kp_upg_green"));
	}
}

/*
	Name: function_c5868f47
	Namespace: namespace_7922d3d4
	Checksum: 0x744216CC
	Offset: 0x1A78
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function function_c5868f47(var_5ea5c94d, ended_early)
{
	level notify(#"hash_12cb63ce83e1c017");
	level flag::set(#"gazed_main_hall");
	level flag::set(#"kp_upg_main");
	level flag::set(#"kp_upg_dead");
	level flag::set(#"kp_upg_green");
}

/*
	Name: function_a03f8d25
	Namespace: namespace_7922d3d4
	Checksum: 0x4DD8D161
	Offset: 0x1B30
	Size: 0x234
	Parameters: 1
	Flags: Linked
*/
function function_a03f8d25(var_a276c861)
{
	level namespace_6747c550::function_7df6bb60(#"hash_22f194aa6971efed", 1);
	var_67b37a67 = struct::get_array("fireplace_location");
	foreach(s_fireplace in var_67b37a67)
	{
		s_fireplace thread function_8c4357b4("low", 0);
		s_fireplace thread function_8c4357b4("hi", 1);
	}
	foreach(s_loc in struct::get_array("knight_protector_loc"))
	{
		var_47323b73 = s_loc zm_unitrigger::create(undefined, 100, &function_265858d6);
		var_47323b73.script_string = s_loc.script_string;
		var_47323b73.s_loc = s_loc;
	}
	if(!var_a276c861)
	{
		level flag::wait_till_all(array(#"knight_main_hall_stationed", #"knight_cemetery_stationed", #"knight_greenhouse_stationed"));
	}
	level thread function_97dd9a16();
}

/*
	Name: function_97dd9a16
	Namespace: namespace_7922d3d4
	Checksum: 0x17498105
	Offset: 0x1D70
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_97dd9a16()
{
	level endon(#"end_game");
	if(!(isdefined(level.var_f1028094[#"hash_4768e5d68ac1bb63"]) && level.var_f1028094[#"hash_4768e5d68ac1bb63"]))
	{
		if(zm_utility::is_player_valid(level.var_5beab970))
		{
			e_speaker = level.var_5beab970;
		}
		else
		{
			a_players = util::get_active_players();
			if(isdefined(level.var_d96749fe))
			{
				e_speaker = arraygetclosest(level.var_d96749fe.origin, a_players);
			}
			else
			{
				e_speaker = array::random(a_players);
			}
		}
		if(zm_utility::is_player_valid(e_speaker))
		{
			level.var_f1028094[#"hash_4768e5d68ac1bb63"] = 1;
			e_speaker zm_vo::function_a2bd5a0c("vox_generic_responses_positive", 0, 1);
		}
	}
}

/*
	Name: function_f05be4f1
	Namespace: namespace_7922d3d4
	Checksum: 0xB77A4099
	Offset: 0x1ED8
	Size: 0x2DC
	Parameters: 2
	Flags: Linked
*/
function function_f05be4f1(var_5ea5c94d, ended_early)
{
	level notify(#"hash_75774dc13775a414");
	level flag::set(#"knight_main_hall_stationed");
	level flag::set(#"knight_cemetery_stationed");
	level flag::set(#"knight_greenhouse_stationed");
	var_5757942c = getentarray("kp_mark", "targetname");
	foreach(var_5f3c4fab in var_5757942c)
	{
		var_5f3c4fab delete();
	}
	var_8de0a1bb = getent("knight_model_main_hall", "targetname");
	if(isdefined(var_8de0a1bb))
	{
		var_8de0a1bb delete();
	}
	var_cbf2d010 = getent("knight_model_cemetery", "targetname");
	if(isdefined(var_cbf2d010))
	{
		var_cbf2d010 delete();
	}
	var_41f3c120 = getent("knight_model_greenhouse", "targetname");
	if(isdefined(var_41f3c120))
	{
		var_41f3c120 delete();
	}
	var_d29db808 = getent("kp_upg_main", "targetname");
	if(isdefined(var_d29db808))
	{
		var_d29db808 delete();
	}
	var_2332b25b = getent("kp_upg_dead", "targetname");
	if(isdefined(var_2332b25b))
	{
		var_2332b25b delete();
	}
	var_c6ce47 = getent("kp_upg_green", "targetname");
	if(isdefined(var_c6ce47))
	{
		var_c6ce47 delete();
	}
}

/*
	Name: function_aa79a199
	Namespace: namespace_7922d3d4
	Checksum: 0x7F1405C2
	Offset: 0x21C0
	Size: 0x2BC
	Parameters: 1
	Flags: Linked
*/
function function_aa79a199(var_a276c861)
{
	level namespace_6747c550::function_7df6bb60(#"hash_22f193aa6971ee3a", 1);
	if(!isdefined(level.var_fbcb1d5b))
	{
		s_loc = struct::get("kp_1", "script_noteworthy");
		level.var_fbcb1d5b = util::spawn_model(#"p8_zm_man_statue_kisa_stone_02", s_loc.origin);
		util::wait_network_frame();
		level.var_fbcb1d5b clientfield::set("" + #"wisp_fx", 1);
	}
	if(!isdefined(level.var_abe1b67c))
	{
		s_loc = struct::get("kp_2", "script_noteworthy");
		level.var_abe1b67c = util::spawn_model(#"p8_zm_man_statue_kisa_stone_01", s_loc.origin);
		util::wait_network_frame();
		level.var_abe1b67c clientfield::set("" + #"wisp_fx", 1);
	}
	if(!isdefined(level.var_c22f75e6))
	{
		s_loc = struct::get("kp_3", "script_noteworthy");
		level.var_c22f75e6 = util::spawn_model(#"p8_zm_man_statue_kisa_stone_03", s_loc.origin);
		util::wait_network_frame();
		level.var_c22f75e6 clientfield::set("" + #"wisp_fx", 1);
	}
	if(!var_a276c861)
	{
		level thread function_444d9cf8();
		level thread function_226e15cc();
		level flag::wait_till(#"hash_4751f59c00375059");
	}
}

/*
	Name: function_bafa7a2b
	Namespace: namespace_7922d3d4
	Checksum: 0x36E002B9
	Offset: 0x2488
	Size: 0x5F4
	Parameters: 2
	Flags: Linked
*/
function function_bafa7a2b(var_5ea5c94d, ended_early)
{
	level notify(#"hash_3a7ba7e53fa848e9");
	level flag::set(#"hash_4751f59c00375059");
	if(isdefined(level.var_5453910))
	{
		level.var_5453910 clientfield::set("" + #"hash_14f3f35558fd380b", 0);
		level.var_5453910 thread function_aea7ad83();
	}
	if(isdefined(level.var_8607bacb))
	{
		level.var_8607bacb clientfield::set("" + #"hash_14f3f35558fd380b", 0);
		level.var_8607bacb thread function_aea7ad83();
	}
	if(isdefined(level.var_8bb8c62d))
	{
		level.var_8bb8c62d clientfield::set("" + #"hash_14f3f35558fd380b", 0);
		level.var_8bb8c62d thread function_aea7ad83();
	}
	var_4eed727b = getent("stone_forest", "targetname");
	var_4eed727b playsound(#"hash_224d8c48960f71ee");
	var_4eed727b stoploopsound();
	wait(3);
	var_a484bb88 = struct::get("kp1_end");
	var_febddc3e = struct::get("kp2_end");
	var_c0c5878c = struct::get("kp3_end");
	v_stone = getent("stone_forest", "targetname").origin + vectorscale((0, 0, 1), 2);
	if(isdefined(level.var_fbcb1d5b))
	{
		level.var_fbcb1d5b clientfield::set("" + #"wisp_fx", 1);
		level.var_fbcb1d5b stopanimscripted();
		level.var_fbcb1d5b setmodel(#"p8_zm_man_statue_kisa_stone_02");
		level.var_fbcb1d5b.origin = var_a484bb88.origin;
		level.var_fbcb1d5b moveto(v_stone, 3, 0.1, 1.5);
		level.var_fbcb1d5b playsound(#"hash_20cc4a02f0ac5e7b");
	}
	if(isdefined(level.var_abe1b67c))
	{
		level.var_abe1b67c clientfield::set("" + #"wisp_fx", 1);
		level.var_abe1b67c stopanimscripted();
		level.var_abe1b67c setmodel(#"p8_zm_man_statue_kisa_stone_01");
		level.var_abe1b67c.origin = var_febddc3e.origin;
		level.var_abe1b67c moveto(v_stone, 3, 0.1, 1.5);
		level.var_abe1b67c playsound(#"hash_20cc4a02f0ac5e7b");
	}
	if(isdefined(level.var_c22f75e6))
	{
		level.var_c22f75e6 clientfield::set("" + #"wisp_fx", 1);
		level.var_c22f75e6 stopanimscripted();
		level.var_c22f75e6 setmodel(#"p8_zm_man_statue_kisa_stone_03");
		level.var_c22f75e6.origin = var_c0c5878c.origin;
		level.var_c22f75e6 moveto(v_stone, 3, 0.1, 1.5);
		level.var_c22f75e6 playsound(#"hash_20cc4a02f0ac5e7b");
	}
	if(!var_5ea5c94d)
	{
		wait(3);
	}
	if(ended_early)
	{
		namespace_617a54f4::function_2a94055d("soul_capture_kp1");
		namespace_617a54f4::function_2a94055d("soul_capture_kp2");
		namespace_617a54f4::function_2a94055d("soul_capture_kp3");
		namespace_617a54f4::function_2a94055d("soul_capture_kp1_halfway");
		namespace_617a54f4::function_2a94055d("soul_capture_kp2_halfway");
		namespace_617a54f4::function_2a94055d("soul_capture_kp3_halfway");
	}
}

/*
	Name: function_86e35a69
	Namespace: namespace_7922d3d4
	Checksum: 0x801A6004
	Offset: 0x2A88
	Size: 0x344
	Parameters: 1
	Flags: Linked
*/
function function_86e35a69(var_a276c861)
{
	level thread function_3dab6861();
	level thread function_6b0caad3();
	level thread function_52529102();
	level thread function_68a397a0();
	level thread function_b646e75d();
	if(!isdefined(level.var_fbcb1d5b))
	{
		var_e0d9e42f = struct::get("kp1_end");
		level.var_fbcb1d5b = util::spawn_model(#"p8_zm_man_statue_kisa_stone_02", var_e0d9e42f.origin);
		util::wait_network_frame();
		level.var_fbcb1d5b clientfield::set("" + #"wisp_fx", 1);
	}
	if(!isdefined(level.var_abe1b67c))
	{
		var_c1395057 = struct::get("kp2_end");
		level.var_abe1b67c = util::spawn_model(#"p8_zm_man_statue_kisa_stone_01", var_c1395057.origin);
		util::wait_network_frame();
		level.var_abe1b67c clientfield::set("" + #"wisp_fx", 1);
	}
	if(!isdefined(level.var_c22f75e6))
	{
		var_4c27be7b = struct::get("kp3_end");
		level.var_c22f75e6 = util::spawn_model(#"p8_zm_man_statue_kisa_stone_03", var_4c27be7b.origin);
		util::wait_network_frame();
		level.var_c22f75e6 clientfield::set("" + #"wisp_fx", 1);
	}
	level.var_fbcb1d5b thread function_6f244e();
	level.var_abe1b67c thread function_6f244e();
	level.var_c22f75e6 thread function_6f244e();
	if(!var_a276c861)
	{
		level flag::wait_till(#"hash_2d21160da504fb1");
	}
	level namespace_6747c550::function_7df6bb60(#"hash_22f192aa6971ec87", 1);
}

/*
	Name: function_a93d56b1
	Namespace: namespace_7922d3d4
	Checksum: 0x1798AA71
	Offset: 0x2DD8
	Size: 0x2BE
	Parameters: 2
	Flags: Linked
*/
function function_a93d56b1(var_5ea5c94d, ended_early)
{
	level notify(#"hash_106bb5214b1fb1e6");
	level flag::set(#"hash_2d21160da504fb1");
	level flag::set(#"hash_4751f59c00375059");
	level flag::set(#"hash_6402d013069eb3a");
	level notify(#"hash_3c7945247db32d89");
	if(isdefined(level.var_fbcb1d5b))
	{
		level.var_fbcb1d5b delete();
	}
	if(isdefined(level.var_abe1b67c))
	{
		level.var_abe1b67c delete();
	}
	if(isdefined(level.var_c22f75e6))
	{
		level.var_c22f75e6 delete();
	}
	s_relic = struct::get("relic_forest");
	mdl_relic = util::spawn_model(#"p8_zm_man_druid_door_stone_triangle", s_relic.origin, s_relic.angles);
	util::wait_network_frame();
	mdl_relic.targetname = s_relic.targetname;
	mdl_relic clientfield::set("" + #"hash_5eff598dc267e32a", 1);
	var_65c9997c = getent("stone_forest", "targetname");
	if(isdefined(var_65c9997c))
	{
		var_65c9997c delete();
	}
	level flag::set(#"forest_complete");
	if(ended_early)
	{
		namespace_617a54f4::function_2a94055d("soul_capture_forest");
		level flag::set(#"spawn_zombies");
		level flag::set(#"zombie_drop_powerups");
	}
	if(isdefined(level.var_be97413))
	{
		level.var_be97413 = undefined;
	}
}

/*
	Name: function_aea7ad83
	Namespace: namespace_7922d3d4
	Checksum: 0x4D6EB4A3
	Offset: 0x30A0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_aea7ad83()
{
	wait(2);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_55b79f54
	Namespace: namespace_7922d3d4
	Checksum: 0x65B899AC
	Offset: 0x30D0
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function function_55b79f54()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::can_use(player) || (isdefined(player.b_gazing) && player.b_gazing) || (isdefined(player.var_d049df11) && player.var_d049df11) || (distancesquared(groundtrace(player.origin, player.origin + (vectorscale((0, 0, -1), 128)), 0, player)[#"position"], player.origin)) > 16)
		{
			continue;
		}
		level thread namespace_b8f22955::function_9e7129d2(player, self.stub.var_f0e6c7a2, 14, "triad");
		player thread namespace_c05f06c7::function_58dfa337(15);
		player thread namespace_c05f06c7::function_a113df82(18);
		level flag::set(#"gazed_main_hall");
	}
}

/*
	Name: function_a8de7aeb
	Namespace: namespace_7922d3d4
	Checksum: 0x94BF67C5
	Offset: 0x3278
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_a8de7aeb(player)
{
}

/*
	Name: function_3207f433
	Namespace: namespace_7922d3d4
	Checksum: 0xC87EC476
	Offset: 0x3290
	Size: 0x188
	Parameters: 0
	Flags: Linked
*/
function function_3207f433()
{
	a_s_locs = struct::get_array("fireplace_location");
	foreach(s_loc in a_s_locs)
	{
		s_loc thread function_8c4357b4("hi", 0);
		s_loc thread function_8c4357b4("low", 1);
		s_loc thread function_2aa04f9f();
	}
	level waittill(#"hash_12cb63ce83e1c017");
	foreach(s_loc in a_s_locs)
	{
		s_loc thread function_8c4357b4("blue", 0);
		if(isdefined(s_loc.t_dmg))
		{
			s_loc.t_dmg delete();
		}
	}
}

/*
	Name: function_2aa04f9f
	Namespace: namespace_7922d3d4
	Checksum: 0xC0454E8C
	Offset: 0x3420
	Size: 0x7CC
	Parameters: 0
	Flags: Linked
*/
function function_2aa04f9f()
{
	level endon(#"hash_12cb63ce83e1c017");
	self endon(self.script_noteworthy + "_done");
	self.t_dmg = spawn("trigger_damage", self.origin, 0, 46, 64);
	while(true)
	{
		s_notify = undefined;
		s_notify = self.t_dmg waittill(#"damage");
		if(isplayer(s_notify.attacker) && namespace_c05f06c7::is_shield(s_notify.weapon) && s_notify.mod === "MOD_MELEE" && (isdefined(s_notify.attacker.is_blue) && s_notify.attacker.is_blue))
		{
			var_e4e66b68 = undefined;
			e_player = s_notify.attacker;
			self thread function_8c4357b4("low", 0);
			self thread function_8c4357b4("blue", 1);
			switch(self.script_noteworthy)
			{
				case "kp_fireplace_main_hall":
				{
					if(self.script_int == level.var_835c3546)
					{
						if(self.script_int == 0)
						{
							self thread function_82dc0664(e_player);
							level.var_835c3546++;
							var_e4e66b68 = 1;
						}
						else if(!level.var_dc3a898e)
						{
							level.var_835c3546++;
							var_e4e66b68 = 1;
						}
						else
						{
							level.var_835c3546 = 0;
							var_e4e66b68 = 0;
						}
					}
					else
					{
						level.var_835c3546 = 0;
						var_e4e66b68 = 0;
					}
					break;
				}
				case "kp_fireplace_cemetery":
				{
					if(self.script_int == level.var_2ba64f64)
					{
						if(self.script_int == 0)
						{
							self thread function_82dc0664(e_player);
							level.var_2ba64f64++;
							var_e4e66b68 = 1;
						}
						else if(!level.var_ded69395)
						{
							level.var_2ba64f64++;
							var_e4e66b68 = 1;
						}
						else
						{
							level.var_2ba64f64 = 0;
							var_e4e66b68 = 0;
						}
					}
					else
					{
						level.var_2ba64f64 = 0;
						var_e4e66b68 = 0;
					}
					break;
				}
				case "hash_181850bb8bb2f622":
				{
					if(self.script_int == level.var_94c6e50c)
					{
						if(self.script_int == 0)
						{
							self thread function_82dc0664(e_player);
							level.var_94c6e50c++;
							var_e4e66b68 = 1;
						}
						else if(!level.var_5f9f8ce8)
						{
							level.var_94c6e50c++;
							var_e4e66b68 = 1;
						}
						else
						{
							level.var_94c6e50c = 0;
							var_e4e66b68 = 0;
						}
					}
					else
					{
						level.var_94c6e50c = 0;
						var_e4e66b68 = 0;
					}
					break;
				}
			}
			if(var_e4e66b68)
			{
				if(self.script_int != 3)
				{
					self waittill(#"fire_end");
				}
				else
				{
					wait(1.5);
				}
				if(self.script_int == 3)
				{
					if(isalive(e_player) && (!(isdefined(e_player.var_aed1893c[#"hash_7a226c41930a49a3"]) && e_player.var_aed1893c[#"hash_7a226c41930a49a3"])))
					{
						e_player.var_aed1893c[#"hash_7a226c41930a49a3"] = 1;
						var_6a01d8dc = e_player.characterindex;
						str_vo = ("vox_fireplace_change_react_plr_" + var_6a01d8dc) + "_0";
						e_player thread zm_vo::function_8e0f4696(str_vo, 0, 1, 9999);
					}
					s_loc = struct::get(self.target);
					var_ee156d3d = util::spawn_model(self.str_model, s_loc.origin, s_loc.angles);
					var_ee156d3d.fx_org = util::spawn_model(#"tag_origin", s_loc.origin);
					var_ee156d3d playsound(#"hash_4b1143cc57b2474b");
					var_ee156d3d playloopsound(#"hash_661ab5dd3a814d28");
					util::wait_network_frame();
					var_ee156d3d.fx_org clientfield::set("" + #"hash_51257ec597a8f84f", 2);
					var_47323b73 = s_loc zm_unitrigger::create(undefined, 100, &function_566d3cd2);
					var_47323b73.script_flag = self.script_flag;
					var_47323b73.var_ee156d3d = var_ee156d3d;
					self thread function_899525c7();
					level flag::set(self.str_model + "_reveal");
				}
				else
				{
					self thread function_8c4357b4("blue", 0);
					self thread function_8c4357b4("low", 1);
				}
			}
			else
			{
				wait(1.5);
				a_s_locs = struct::get_array(self.script_noteworthy, "script_noteworthy");
				foreach(s_loc in a_s_locs)
				{
					s_loc notify(#"fire_end");
					s_loc thread function_8c4357b4("blue", 0);
					s_loc thread function_8c4357b4("low", 1);
				}
			}
		}
	}
}

/*
	Name: function_82dc0664
	Namespace: namespace_7922d3d4
	Checksum: 0xE5C04F74
	Offset: 0x3BF8
	Size: 0x21C
	Parameters: 1
	Flags: Linked
*/
function function_82dc0664(e_player)
{
	level endon(#"hash_12cb63ce83e1c017");
	self endon(self.script_noteworthy + "_done");
	switch(self.script_noteworthy)
	{
		case "kp_fireplace_main_hall":
		{
			level.var_dc3a898e = 0;
			break;
		}
		case "kp_fireplace_cemetery":
		{
			level.var_ded69395 = 0;
			break;
		}
		case "hash_181850bb8bb2f622":
		{
			level.var_5f9f8ce8 = 0;
			break;
		}
	}
	self waittill_timeout(36, #"fire_end");
	switch(self.script_noteworthy)
	{
		case "kp_fireplace_main_hall":
		{
			level.var_dc3a898e = 1;
			level.var_835c3546 = 0;
			break;
		}
		case "kp_fireplace_cemetery":
		{
			level.var_ded69395 = 1;
			level.var_2ba64f64 = 0;
			break;
		}
		case "hash_181850bb8bb2f622":
		{
			level.var_5f9f8ce8 = 1;
			level.var_94c6e50c = 0;
			break;
		}
	}
	a_s_locs = struct::get_array(self.script_noteworthy, "script_noteworthy");
	foreach(s_loc in a_s_locs)
	{
		s_loc notify(#"fire_end");
	}
}

/*
	Name: function_899525c7
	Namespace: namespace_7922d3d4
	Checksum: 0x4DA6C6C4
	Offset: 0x3E20
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function function_899525c7()
{
	a_s_locs = struct::get_array(self.script_noteworthy, "script_noteworthy");
	foreach(s_loc in a_s_locs)
	{
		s_loc notify(self.script_noteworthy + "_done");
		s_loc thread function_8c4357b4("blue", 0);
		s_loc thread function_8c4357b4("low", 1);
	}
}

/*
	Name: function_566d3cd2
	Namespace: namespace_7922d3d4
	Checksum: 0x34552550
	Offset: 0x3F10
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_566d3cd2()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		level flag::set(self.stub.script_flag);
		var_ee156d3d = self.stub.var_ee156d3d;
		player playsound(#"hash_31a648443e4497e8");
		if(isdefined(var_ee156d3d) && isdefined(var_ee156d3d.fx_org))
		{
			var_ee156d3d.fx_org thread function_3c832025();
			var_ee156d3d delete();
		}
		zm_unitrigger::unregister_unitrigger(self.stub);
	}
}

/*
	Name: function_3c832025
	Namespace: namespace_7922d3d4
	Checksum: 0x91DD6017
	Offset: 0x4040
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_3c832025()
{
	self clientfield::set("" + #"hash_51257ec597a8f84f", 0);
	wait(1.5);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_40e665ab
	Namespace: namespace_7922d3d4
	Checksum: 0xF9B5E1D2
	Offset: 0x40A0
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_40e665ab()
{
	self endon(#"extinguish");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		if(!isplayer(waitresult.activator))
		{
			continue;
		}
		player = waitresult.activator;
		if(isdefined(player.currentweapon) && namespace_c05f06c7::is_shield(player.currentweapon) && !player.is_blue)
		{
			player.is_blue = 1;
			player thread function_fb54ddba();
		}
	}
}

/*
	Name: function_fb54ddba
	Namespace: namespace_7922d3d4
	Checksum: 0x27EAE026
	Offset: 0x4188
	Size: 0x112
	Parameters: 0
	Flags: Linked
*/
function function_fb54ddba()
{
	self endon(#"disconnect");
	self notify(#"hash_4916b386e0478580");
	self thread function_4c8574b3();
	self clientfield::set("" + #"hash_6e7b9ac29b5ccee1", 1);
	while(isdefined(self.is_blue) && self.is_blue)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_change", #"hash_4916b386e0478580");
		if(s_result._notify !== "weapon_change" || !namespace_c05f06c7::is_shield(s_result.weapon))
		{
			self notify(#"hash_459246e5bfcc3713");
		}
	}
}

/*
	Name: function_4c8574b3
	Namespace: namespace_7922d3d4
	Checksum: 0xE018D1B5
	Offset: 0x42A8
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_4c8574b3()
{
	self endon(#"disconnect");
	self waittill_timeout(55, #"hash_4916b386e0478580", #"hash_459246e5bfcc3713", #"destroy_riotshield");
	self.is_blue = 0;
	self clientfield::set("" + #"hash_6e7b9ac29b5ccee1", 0);
	self notify(#"hash_4916b386e0478580");
}

/*
	Name: function_265858d6
	Namespace: namespace_7922d3d4
	Checksum: 0x978AE5F4
	Offset: 0x4348
	Size: 0x368
	Parameters: 0
	Flags: Linked
*/
function function_265858d6()
{
	level endon(#"hash_75774dc13775a414");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(zm_utility::can_use(player))
		{
			switch(self.stub.script_string)
			{
				case "main_hall":
				{
					var_64403099 = getent("knight_model_main_hall", "targetname");
					var_64403099 thread function_30fe35b("tag_stone_02", "p8_zm_man_statue_kisa_stone_02", 1.5);
					var_64403099 util::delay(1.5, undefined, &scene::play, #"p8_fxanim_zm_man_ka01_bundle", "crumble", var_64403099);
					level flag::set(#"hash_775ff2ad49f494a7");
					break;
				}
				case "cemetery":
				{
					var_64403099 = getent("knight_model_cemetery", "targetname");
					var_64403099 thread function_30fe35b("tag_stone_01", "p8_zm_man_statue_kisa_stone_01", 1.5);
					var_64403099 util::delay(1.5, undefined, &scene::play, #"p8_fxanim_zm_man_ka03_bundle", "crumble", var_64403099);
					level flag::set(#"hash_7583b516d2aab62e");
					break;
				}
				case "greenhouse":
				{
					var_64403099 = getent("knight_model_greenhouse", "targetname");
					var_64403099 thread function_30fe35b("tag_stone_03", "p8_zm_man_statue_kisa_stone_03", 1.5);
					var_64403099 util::delay(1.5, undefined, &scene::play, #"p8_fxanim_zm_man_ka02_bundle", "crumble", var_64403099);
					level flag::set(#"hash_4ee2d51615eadbb");
					break;
				}
			}
			self.stub.s_loc thread function_4490aa7d();
			player thread zm_audio::create_and_play_dialog(#"knight_trap", #"active", undefined, 1);
			zm_unitrigger::unregister_unitrigger(self.stub);
		}
	}
}

/*
	Name: function_30fe35b
	Namespace: namespace_7922d3d4
	Checksum: 0x5FD7BE15
	Offset: 0x46B8
	Size: 0x8C
	Parameters: 3
	Flags: Linked
*/
function function_30fe35b(str_tag, str_model, n_wait)
{
	self showpart(str_tag, str_model, 1);
	self playsoundontag(#"hash_7c38eb0531ca63ee", str_tag);
	wait(n_wait);
	if(isdefined(self))
	{
		self hidepart(str_tag, str_model, 1);
	}
}

/*
	Name: function_4490aa7d
	Namespace: namespace_7922d3d4
	Checksum: 0x10C92C2C
	Offset: 0x4750
	Size: 0x4B4
	Parameters: 0
	Flags: Linked
*/
function function_4490aa7d()
{
	level endon(#"hash_75774dc13775a414");
	s_spawn = struct::get("knight_spawnpt_" + self.script_string);
	switch(self.script_string)
	{
		case "main_hall":
		{
			var_ca0ae05d = "knight_main_hall_stationed";
			s_loc = struct::get("kp_1", "script_noteworthy");
			var_9e7c3935 = getent("kp_mark_lion", "script_noteworthy");
			var_9e7c3935 clientfield::set("" + #"hash_2108935a0c33f89a", 1);
			var_ce68e849 = util::spawn_model(#"p8_zm_man_statue_kisa_stone_02", s_spawn.origin, s_spawn.angles);
			level.var_fbcb1d5b = var_ce68e849;
			break;
		}
		case "cemetery":
		{
			var_ca0ae05d = "knight_cemetery_stationed";
			s_loc = struct::get("kp_2", "script_noteworthy");
			var_9e7c3935 = getent("kp_mark_cobra", "script_noteworthy");
			var_9e7c3935 clientfield::set("" + #"hash_2108935a0c33f89a", 2);
			var_ce68e849 = util::spawn_model(#"p8_zm_man_statue_kisa_stone_01", s_spawn.origin, s_spawn.angles);
			level.var_abe1b67c = var_ce68e849;
			break;
		}
		case "greenhouse":
		{
			var_ca0ae05d = "knight_greenhouse_stationed";
			s_loc = struct::get("kp_3", "script_noteworthy");
			var_9e7c3935 = getent("kp_mark_wolf", "script_noteworthy");
			var_9e7c3935 clientfield::set("" + #"hash_2108935a0c33f89a", 3);
			var_ce68e849 = util::spawn_model(#"p8_zm_man_statue_kisa_stone_03", s_spawn.origin, s_spawn.angles);
			level.var_c22f75e6 = var_ce68e849;
			break;
		}
	}
	util::wait_network_frame();
	var_ce68e849 clientfield::set("" + #"wisp_fx", 1);
	var_9e7c3935 show();
	wait(2.5);
	var_ce68e849 thread function_d409a74f(var_9e7c3935);
	var_ce68e849 waittill(#"hash_6df5566461d13967");
	var_ce68e849 moveto(s_loc.origin, 0.25);
	var_ce68e849 rotateto(s_loc.angles, 0.25);
	var_ce68e849 waittill(#"rotatedone");
	var_ce68e849 bobbing((0, 0, 1), 2, 3);
	a_players = util::get_active_players();
	level.var_5beab970 = arraygetclosest(s_loc.origin, a_players, 600);
	level.var_d96749fe = s_loc;
	level flag::set(var_ca0ae05d);
}

/*
	Name: function_d409a74f
	Namespace: namespace_7922d3d4
	Checksum: 0x7D89665E
	Offset: 0x4C10
	Size: 0x4D4
	Parameters: 1
	Flags: Linked
*/
function function_d409a74f(var_9e7c3935)
{
	level endon(#"hash_75774dc13775a414", #"end_game");
	self endon(#"death");
	self.var_7988eee5 = undefined;
	n_timer = 0;
	self.var_199faf5e = 1;
	while(distance2dsquared(self.origin, var_9e7c3935.origin) > 40000)
	{
		if(isdefined(self.var_7988eee5) && zm_utility::is_player_valid(self.var_7988eee5) && n_timer < 30)
		{
			var_2f07de84 = self.var_7988eee5.origin + (randomintrange(60 * -1, 60), randomintrange(60 * -1, 60), 0);
			v_moveto = getclosestpointonnavmesh(var_2f07de84, 64, 16);
			if(isdefined(v_moveto))
			{
				v_moveto = v_moveto + vectorscale((0, 0, 1), 46);
				n_dist = distance2dsquared(self.origin, v_moveto);
			}
		}
		else
		{
			self.var_7988eee5 = self namespace_c05f06c7::get_closest_valid_player(22500);
		}
		if(isdefined(self.var_199faf5e) && self.var_199faf5e)
		{
			self bobbing((0, 0, 1), 2, 3);
			self.var_199faf5e = 0;
		}
		if(isdefined(n_dist) && n_dist > (22500 * 4.5))
		{
			self.var_199faf5e = 0;
			n_timer = n_timer + 0.25;
		}
		else if(isdefined(n_dist) && n_dist > 22500)
		{
			self moveto(v_moveto, 1.35);
			self thread function_7e316825();
			n_timer = 0;
		}
		else
		{
			self.var_199faf5e = 0;
			n_timer = 0;
		}
		n_dist = undefined;
		wait(0.25);
	}
	self moveto(var_9e7c3935.origin + vectorscale((0, 0, 1), 46), 2);
	self waittill(#"movedone");
	self notify(#"hash_6df5566461d13967");
	level flag::wait_till_all(array(#"knight_main_hall_stationed", #"knight_cemetery_stationed", #"knight_greenhouse_stationed"));
	switch(var_9e7c3935.script_noteworthy)
	{
		case "kp_mark_lion":
		{
			var_9e7c3935 clientfield::set("" + #"hash_2108935a0c33f89a", 0);
			break;
		}
		case "kp_mark_wolf":
		{
			var_9e7c3935 clientfield::set("" + #"hash_2108935a0c33f89a", 0);
			break;
		}
		case "kp_mark_cobra":
		{
			var_9e7c3935 clientfield::set("" + #"hash_2108935a0c33f89a", 0);
			break;
		}
	}
	wait(2);
	var_9e7c3935 delete();
}

/*
	Name: function_7e316825
	Namespace: namespace_7922d3d4
	Checksum: 0x2E410EA3
	Offset: 0x50F0
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function function_7e316825()
{
	self notify("399a1770792ffde7");
	self endon("399a1770792ffde7");
	self endon(#"death");
	self waittill(#"movedone");
	self.var_199faf5e = 1;
}

/*
	Name: function_226e15cc
	Namespace: namespace_7922d3d4
	Checksum: 0x12A9DA05
	Offset: 0x5148
	Size: 0x304
	Parameters: 0
	Flags: Linked
*/
function function_226e15cc()
{
	level endon(#"hash_3a7ba7e53fa848e9");
	level flag::wait_till_all(array(#"knight_main_hall_stationed", #"knight_cemetery_stationed", #"knight_greenhouse_stationed"));
	v_offset = vectorscale((0, 0, -1), 45);
	level.var_abe1b67c moveto(level.var_abe1b67c.origin + v_offset, 0.25);
	level.var_fbcb1d5b moveto(level.var_fbcb1d5b.origin + v_offset, 0.25);
	level.var_c22f75e6 moveto(level.var_c22f75e6.origin + v_offset, 0.25);
	array::wait_till(array(level.var_abe1b67c, level.var_fbcb1d5b, level.var_c22f75e6), "movedone", 1);
	level.var_abe1b67c.str_model = #"hash_2fd7d12881613ff1";
	level.var_fbcb1d5b.str_model = #"hash_485dabee10eddd9a";
	level.var_c22f75e6.str_model = #"hash_1e5559d9a4922ce7";
	scene::add_scene_func(#"p8_fxanim_zm_man_kag03_bundle", &function_92227ee8, "rise");
	level.var_abe1b67c thread scene::play(#"p8_fxanim_zm_man_kag03_bundle", "rise", level.var_abe1b67c);
	level.var_fbcb1d5b thread scene::play(#"p8_fxanim_zm_man_kag03_bundle", "rise", level.var_fbcb1d5b);
	level.var_c22f75e6 scene::play(#"p8_fxanim_zm_man_kag03_bundle", "rise", level.var_c22f75e6);
	namespace_617a54f4::function_3f808d3d("soul_capture_kp1");
	namespace_617a54f4::function_3f808d3d("soul_capture_kp2");
	namespace_617a54f4::function_3f808d3d("soul_capture_kp3");
}

/*
	Name: function_4175b958
	Namespace: namespace_7922d3d4
	Checksum: 0x85DB3797
	Offset: 0x5458
	Size: 0xB0
	Parameters: 2
	Flags: Linked
*/
function function_4175b958(var_88206a50, ent)
{
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && distance2dsquared(var_88206a50.origin, ent.origin) <= (400 * 400);
}

/*
	Name: function_138b784e
	Namespace: namespace_7922d3d4
	Checksum: 0xDFB73A69
	Offset: 0x5510
	Size: 0x15C
	Parameters: 2
	Flags: Linked
*/
function function_138b784e(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = 12;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = 10;
	}
	else
	{
		n_souls_required = 7;
	}
	level.var_7f30bc18++;
	if(level.var_7f30bc18 >= n_souls_required)
	{
		level.var_7f30bc18 = 0;
		var_a4e33d04 = getent("kp_mark_lion", "script_noteworthy");
		if(isdefined(var_a4e33d04))
		{
			var_a4e33d04 delete();
		}
		namespace_617a54f4::function_2a94055d(#"soul_capture_kp1");
		s_goal = struct::get("kp1_halfway");
		if(isdefined(level.var_fbcb1d5b))
		{
			level.var_fbcb1d5b thread function_90cc31c4(s_goal, "soul_capture_kp1_halfway");
		}
	}
}

/*
	Name: function_a23300bc
	Namespace: namespace_7922d3d4
	Checksum: 0x3B54C6AF
	Offset: 0x5678
	Size: 0xB0
	Parameters: 2
	Flags: Linked
*/
function function_a23300bc(var_88206a50, ent)
{
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && distance2dsquared(var_88206a50.origin, ent.origin) <= (400 * 400);
}

/*
	Name: function_3d90aae2
	Namespace: namespace_7922d3d4
	Checksum: 0xD10927DC
	Offset: 0x5730
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function function_3d90aae2(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = 12;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = 10;
	}
	else
	{
		n_souls_required = 7;
	}
	level.var_7f30bc18++;
	if(level.var_7f30bc18 >= n_souls_required)
	{
		level.var_7f30bc18 = 0;
		namespace_617a54f4::function_2a94055d(#"soul_capture_kp1_halfway");
		s_goal = struct::get("kp1_end");
		if(isdefined(level.var_fbcb1d5b))
		{
			level.var_fbcb1d5b thread function_90cc31c4(s_goal, undefined, #"hash_59379e190111ef24");
		}
	}
}

/*
	Name: function_53e85e3d
	Namespace: namespace_7922d3d4
	Checksum: 0x8AC67CB
	Offset: 0x5858
	Size: 0xB0
	Parameters: 2
	Flags: Linked
*/
function function_53e85e3d(var_88206a50, ent)
{
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && distance2dsquared(var_88206a50.origin, ent.origin) <= (400 * 400);
}

/*
	Name: function_25d21cdb
	Namespace: namespace_7922d3d4
	Checksum: 0xCB109D18
	Offset: 0x5910
	Size: 0x15C
	Parameters: 2
	Flags: Linked
*/
function function_25d21cdb(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = 12;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = 10;
	}
	else
	{
		n_souls_required = 7;
	}
	level.var_6d7e18b3++;
	if(level.var_6d7e18b3 >= n_souls_required)
	{
		level.var_6d7e18b3 = 0;
		var_bd9c1ba7 = getent("kp_mark_cobra", "script_noteworthy");
		if(isdefined(var_bd9c1ba7))
		{
			var_bd9c1ba7 delete();
		}
		namespace_617a54f4::function_2a94055d(#"soul_capture_kp2");
		s_goal = struct::get("kp2_halfway");
		if(isdefined(level.var_abe1b67c))
		{
			level.var_abe1b67c thread function_90cc31c4(s_goal, "soul_capture_kp2_halfway");
		}
	}
}

/*
	Name: function_ecb921f0
	Namespace: namespace_7922d3d4
	Checksum: 0xD21AAF50
	Offset: 0x5A78
	Size: 0xB0
	Parameters: 2
	Flags: Linked
*/
function function_ecb921f0(var_88206a50, ent)
{
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && distance2dsquared(var_88206a50.origin, ent.origin) <= (400 * 400);
}

/*
	Name: function_49798eb9
	Namespace: namespace_7922d3d4
	Checksum: 0xB48F9E6B
	Offset: 0x5B30
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function function_49798eb9(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = 12;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = 10;
	}
	else
	{
		n_souls_required = 7;
	}
	level.var_6d7e18b3++;
	if(level.var_6d7e18b3 >= n_souls_required)
	{
		level.var_6d7e18b3 = 0;
		namespace_617a54f4::function_2a94055d(#"soul_capture_kp2_halfway");
		s_goal = struct::get("kp2_end");
		if(isdefined(level.var_abe1b67c))
		{
			level.var_abe1b67c thread function_90cc31c4(s_goal, undefined, #"hash_6e8014ad2f5a3a5");
		}
	}
}

/*
	Name: function_5e8b7383
	Namespace: namespace_7922d3d4
	Checksum: 0xFB199CEC
	Offset: 0x5C58
	Size: 0xB0
	Parameters: 2
	Flags: Linked
*/
function function_5e8b7383(var_88206a50, ent)
{
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && distance2dsquared(var_88206a50.origin, ent.origin) <= (400 * 400);
}

/*
	Name: function_28082147
	Namespace: namespace_7922d3d4
	Checksum: 0xEA083E32
	Offset: 0x5D10
	Size: 0x15C
	Parameters: 2
	Flags: Linked
*/
function function_28082147(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = 12;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = 10;
	}
	else
	{
		n_souls_required = 7;
	}
	level.var_3224a1fd++;
	if(level.var_3224a1fd >= n_souls_required)
	{
		level.var_3224a1fd = 0;
		var_6c6c7d49 = getent("kp_mark_wolf", "script_noteworthy");
		if(isdefined(var_6c6c7d49))
		{
			var_6c6c7d49 delete();
		}
		namespace_617a54f4::function_2a94055d(#"soul_capture_kp3");
		s_goal = struct::get("kp3_halfway");
		if(isdefined(level.var_c22f75e6))
		{
			level.var_c22f75e6 thread function_90cc31c4(s_goal, "soul_capture_kp3_halfway");
		}
	}
}

/*
	Name: function_ba203e13
	Namespace: namespace_7922d3d4
	Checksum: 0xCFF22FE1
	Offset: 0x5E78
	Size: 0xB0
	Parameters: 2
	Flags: Linked
*/
function function_ba203e13(var_88206a50, ent)
{
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && distance2dsquared(var_88206a50.origin, ent.origin) <= (400 * 400);
}

/*
	Name: function_60bda2cf
	Namespace: namespace_7922d3d4
	Checksum: 0xA1CF90F8
	Offset: 0x5F30
	Size: 0x124
	Parameters: 2
	Flags: Linked
*/
function function_60bda2cf(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = 12;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = 10;
	}
	else
	{
		n_souls_required = 7;
	}
	level.var_3224a1fd++;
	if(level.var_3224a1fd >= n_souls_required)
	{
		level.var_3224a1fd = 0;
		namespace_617a54f4::function_2a94055d(#"soul_capture_kp3_halfway");
		s_goal = struct::get(#"kp3_end");
		if(isdefined(level.var_c22f75e6))
		{
			level.var_c22f75e6 thread function_90cc31c4(s_goal, undefined, #"hash_d491aae3ed3bc7e");
		}
	}
}

/*
	Name: is_soul_capture_forest
	Namespace: namespace_7922d3d4
	Checksum: 0x969E40E
	Offset: 0x6060
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function is_soul_capture_forest(var_88206a50, ent)
{
	if(ent.archetype !== #"werewolf")
	{
		return 0;
	}
	p = ent.origin;
	a = struct::get("kp1_end").origin;
	b = struct::get("kp2_end").origin;
	c = struct::get("kp3_end").origin;
	if(function_f699a6c8(p, a, b, c) && function_f699a6c8(p, b, a, c) && function_f699a6c8(p, c, a, b))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_f699a6c8
	Namespace: namespace_7922d3d4
	Checksum: 0xC0A2E8D0
	Offset: 0x61A8
	Size: 0xAE
	Parameters: 4
	Flags: Linked
*/
function function_f699a6c8(p1, p2, a, b)
{
	var_f6c2b8ab = vectorcross(b - a, p1 - a);
	var_31ceaec2 = vectorcross(b - a, p2 - a);
	if(vectordot(var_f6c2b8ab, var_31ceaec2) >= 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_b570f926
	Namespace: namespace_7922d3d4
	Checksum: 0xEF3923B4
	Offset: 0x6260
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_b570f926(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		var_c61e686c = 2;
	}
	else
	{
		var_c61e686c = 1;
	}
	level.n_forest++;
	if(level.n_forest >= var_c61e686c)
	{
		namespace_617a54f4::function_2a94055d(#"soul_capture_forest");
		level flag::set(#"hash_4751f59c00375059");
		level thread function_3d151222(#"knight_trap", #"hash_73e9e7476fdbc069");
	}
}

/*
	Name: function_90cc31c4
	Namespace: namespace_7922d3d4
	Checksum: 0x10DD1092
	Offset: 0x6348
	Size: 0x2E4
	Parameters: 3
	Flags: Linked
*/
function function_90cc31c4(s_goal, var_ea62e3e9, str_flag)
{
	self endon(#"death");
	self scene::play(#"p8_fxanim_zm_man_kag03_bundle", "crumble", self);
	self stopanimscripted();
	switch(self.str_model)
	{
		case "hash_2fd7d12881613ff1":
		{
			self setmodel(#"p8_zm_man_statue_kisa_stone_01");
			break;
		}
		case "hash_485dabee10eddd9a":
		{
			self setmodel(#"p8_zm_man_statue_kisa_stone_02");
			break;
		}
		case "hash_1e5559d9a4922ce7":
		{
			self setmodel(#"p8_zm_man_statue_kisa_stone_03");
			break;
		}
	}
	self clientfield::set("" + #"wisp_fx", 1);
	self playsound(#"hash_20cc4a02f0ac5e7b");
	self moveto(self.origin + vectorscale((0, 0, 1), 64), 0.25);
	self waittill(#"movedone");
	self moveto(s_goal.origin, 3);
	self rotateto(s_goal.angles, 3);
	self waittill(#"movedone");
	self moveto(s_goal.origin - vectorscale((0, 0, 1), 64), 0.25);
	self waittill(#"movedone");
	if(isdefined(var_ea62e3e9))
	{
		namespace_617a54f4::function_3f808d3d(var_ea62e3e9);
	}
	self scene::play(#"p8_fxanim_zm_man_kag03_bundle", "rise", self);
	if(isdefined(str_flag))
	{
		level flag::set(str_flag);
	}
}

/*
	Name: function_92227ee8
	Namespace: namespace_7922d3d4
	Checksum: 0x84EFB112
	Offset: 0x6638
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_92227ee8(a_ents)
{
	var_ce68e849 = a_ents[getfirstarraykey(a_ents)];
	if(isdefined(var_ce68e849.str_model))
	{
		var_ce68e849 ghost();
		var_ce68e849 setmodel(var_ce68e849.str_model);
		util::wait_network_frame(1);
		if(isdefined(var_ce68e849))
		{
			var_ce68e849 show();
			var_ce68e849 clientfield::set("" + #"wisp_fx", 2);
		}
	}
}

/*
	Name: function_444d9cf8
	Namespace: namespace_7922d3d4
	Checksum: 0x809C37EE
	Offset: 0x6730
	Size: 0x33C
	Parameters: 0
	Flags: Linked
*/
function function_444d9cf8()
{
	level endon(#"hash_3a7ba7e53fa848e9");
	level flag::wait_till_all(array(#"hash_59379e190111ef24", #"hash_6e8014ad2f5a3a5", #"hash_d491aae3ed3bc7e"));
	wait(0.5);
	var_2e679877 = struct::get("kp1_line_source");
	level.var_5453910 = util::spawn_model("tag_origin", var_2e679877.origin, var_2e679877.angles);
	var_61257df2 = struct::get("kp2_line_source");
	level.var_8607bacb = util::spawn_model("tag_origin", var_61257df2.origin, var_61257df2.angles);
	var_9409e3ba = struct::get("kp3_line_source");
	level.var_8bb8c62d = util::spawn_model("tag_origin", var_9409e3ba.origin, var_9409e3ba.angles);
	util::wait_network_frame();
	level.var_5453910 clientfield::set("" + #"hash_14f3f35558fd380b", 1);
	level.var_8607bacb clientfield::set("" + #"hash_14f3f35558fd380b", 2);
	level.var_8bb8c62d clientfield::set("" + #"hash_14f3f35558fd380b", 3);
	var_4eed727b = getent("stone_forest", "targetname");
	var_4eed727b playsound(#"hash_7736e4287bd3440b");
	var_4eed727b playloopsound(#"hash_22739fd2435ae7bd");
	namespace_617a54f4::function_3f808d3d(#"soul_capture_forest");
	level thread function_df2c4d2d();
	if(getplayers().size > 2)
	{
		var_34ac013b = 2;
	}
	else
	{
		var_34ac013b = 1;
	}
	level thread function_a78b58f6(var_34ac013b, undefined, #"hash_4751f59c00375059");
}

/*
	Name: function_df2c4d2d
	Namespace: namespace_7922d3d4
	Checksum: 0xFF19F269
	Offset: 0x6A78
	Size: 0x204
	Parameters: 0
	Flags: Linked, Private
*/
private function function_df2c4d2d()
{
	level endon_callback(&function_46b38ca2, #"hash_3a7ba7e53fa848e9", #"end_game");
	var_2db98020 = 0;
	var_12bee25f = struct::get(#"kp1_end");
	level.var_411ea43b = util::spawn_model("tag_origin", var_12bee25f.origin, var_12bee25f.angles);
	waitframe(1);
	while(!(isdefined(var_2db98020) && var_2db98020))
	{
		a_players = util::get_active_players();
		foreach(e_player in a_players)
		{
			if(level.var_411ea43b sightconetrace(e_player geteye(), e_player, e_player getweaponforwarddir(), 70))
			{
				var_2db98020 = e_player zm_audio::create_and_play_dialog(#"knight_trap", #"defend", undefined, 1);
				if(isdefined(var_2db98020) && var_2db98020)
				{
					break;
				}
			}
		}
		wait(1);
	}
	level.var_411ea43b delete();
}

/*
	Name: function_46b38ca2
	Namespace: namespace_7922d3d4
	Checksum: 0xF450BC0F
	Offset: 0x6C88
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function function_46b38ca2(var_c34665fc)
{
	if(isdefined(level.var_411ea43b))
	{
		level.var_411ea43b delete();
	}
}

/*
	Name: function_a78b58f6
	Namespace: namespace_7922d3d4
	Checksum: 0x3B41E63E
	Offset: 0x6CC8
	Size: 0x2DE
	Parameters: 3
	Flags: Linked
*/
function function_a78b58f6(n_active, var_e05ded9, var_39cddd2a)
{
	a_s_center = struct::get_array("forest_center_spawns");
	var_1dc59002 = struct::get_array("forest_n_spawns");
	var_4275b4d6 = [];
	level.var_34ac013b = 0;
	level.var_b02bf6d2 = 0;
	var_70bce1d6 = 0;
	foreach(s_loc in a_s_center)
	{
		if(s_loc.script_noteworthy === "werewolf_location")
		{
			var_4275b4d6[var_4275b4d6.size] = s_loc;
		}
	}
	foreach(s_loc in var_1dc59002)
	{
		if(s_loc.script_noteworthy === "werewolf_location")
		{
			var_4275b4d6[var_4275b4d6.size] = s_loc;
		}
	}
	s_loc = array::random(var_4275b4d6);
	while(!level flag::get(var_39cddd2a))
	{
		if(isdefined(var_e05ded9) && var_70bce1d6 >= var_e05ded9)
		{
			return;
		}
		if(level.var_34ac013b < n_active)
		{
			var_e3cf2cc7 = namespace_977da60::function_47a88a0c(1, undefined, 1, s_loc, 20);
			if(isdefined(var_e3cf2cc7))
			{
				level.var_34ac013b++;
				var_70bce1d6++;
				var_e3cf2cc7.no_powerups = 1;
				var_e3cf2cc7 zm_score::function_acaab828();
				var_e3cf2cc7 zm_transform::function_bbaec2fd();
				var_e3cf2cc7 forceteleport(s_loc.origin, s_loc.angles);
				var_e3cf2cc7 callback::function_d8abfc3d(#"on_ai_killed", &teleporter_digger_hacked_before_breached_imp);
			}
		}
		wait(5);
	}
}

/*
	Name: teleporter_digger_hacked_before_breached_imp
	Namespace: namespace_7922d3d4
	Checksum: 0xF414E00B
	Offset: 0x6FB0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function teleporter_digger_hacked_before_breached_imp(params)
{
	level.var_34ac013b--;
	level.var_b02bf6d2++;
}

/*
	Name: function_3dab6861
	Namespace: namespace_7922d3d4
	Checksum: 0x4E766A4C
	Offset: 0x6FE0
	Size: 0x234
	Parameters: 0
	Flags: Linked
*/
function function_3dab6861()
{
	level endon(#"hash_106bb5214b1fb1e6");
	level flag::wait_till(#"hash_4751f59c00375059");
	foreach(player in util::get_active_players())
	{
		player playrumbleonentity("zm_power_on_rumble");
	}
	var_65c9997c = getent("stone_forest", "targetname");
	var_65c9997c show();
	var_65c9997c clientfield::set("" + #"force_stream_model", 1);
	util::wait_network_frame();
	var_65c9997c clientfield::increment("" + #"hash_33fddc34b8b16bca", 1);
	var_65c9997c movez(5, 2);
	var_65c9997c playsound(#"hash_1d64292cc84a95ed");
	var_65c9997c waittill(#"movedone");
	var_47323b73 = var_65c9997c zm_unitrigger::create(undefined, 96);
	var_47323b73.v_start = var_65c9997c.angles;
	var_65c9997c thread function_31e641f5();
}

/*
	Name: function_31e641f5
	Namespace: namespace_7922d3d4
	Checksum: 0xA8C8442F
	Offset: 0x7220
	Size: 0x4F4
	Parameters: 0
	Flags: Linked
*/
function function_31e641f5()
{
	level endon(#"hash_106bb5214b1fb1e6");
	while(true)
	{
		self waittill(#"trigger_activated");
		b_using = 1;
		n_time = 0;
		self thread namespace_c05f06c7::function_6a523c8c();
		self playsound(#"hash_5f64672d2f3be1cf");
		while(n_time < 3)
		{
			foreach(player in getplayers())
			{
				if(!player usebuttonpressed() || !zm_utility::can_use(player) || !isdefined(self.s_unitrigger) || !isdefined(self.s_unitrigger.trigger) || !player istouching(self.s_unitrigger.trigger))
				{
					b_using = 0;
					n_time = 0;
					break;
				}
			}
			if(b_using == 0)
			{
				self notify(#"stop_wobble");
				self.angles = self.s_unitrigger.v_start;
				self clientfield::set("" + #"hash_5eff598dc267e32a", 0);
				self playsound(#"hash_44f80245c4072de");
				break;
			}
			self clientfield::set("" + #"hash_5eff598dc267e32a", 1);
			wait(0.1);
			n_time = n_time + 0.1;
		}
		if(b_using == 1)
		{
			self playsound(#"hash_c8be5b775b7ca39");
			break;
		}
		wait(0.1);
	}
	array::run_all(util::get_active_players(), &clientfield::increment_to_player, "" + #"hash_73a4abf07bc65bc3", 1);
	level flag::set(#"hash_1b9ecc7979b0fcfb");
	level clientfield::set("fasttravel_exploder", 0);
	exploder::exploder("fxexp_barrier_gameplay_forest");
	level thread namespace_c05f06c7::function_f1c106b("loc2", 1);
	self clientfield::set("" + #"hash_141bb928b3d09e20", 1);
	self playloopsound(#"hash_7e416bed2776d588");
	s_dest = struct::get(self.target);
	self rotateto(s_dest.angles, 3);
	self moveto(s_dest.origin, 3);
	self waittill(#"movedone");
	self clientfield::set("" + #"hash_60051e21f8eb4af", 1);
	wait(1);
	self.var_4c4f2b6 = self.angles;
	self thread namespace_c05f06c7::function_da5cd631(vectorscale((0, 1, 0), 180));
	level flag::set(#"hash_2427d27d352e9454");
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: function_6f244e
	Namespace: namespace_7922d3d4
	Checksum: 0xB38C1D52
	Offset: 0x7720
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function function_6f244e()
{
	level endon(#"hash_106bb5214b1fb1e6");
	self endon(#"death");
	level flag::wait_till(#"hash_2427d27d352e9454");
	self thread namespace_b8f22955::function_c9c7a593();
	self thread function_3c07c22e();
	a_s_locs = struct::get_array("wisp_loc");
	wait(randomfloatrange(1.5, 2.5));
	while(!level flag::get(#"hash_6402d013069eb3a"))
	{
		v_loc = self function_3f504167();
		if(!isdefined(v_loc))
		{
			v_loc = self function_46e4dd8b(a_s_locs);
		}
		if(isdefined(v_loc))
		{
			n_time = function_de2561ce(self.origin, v_loc);
		}
		if(isdefined(n_time) && n_time > 0)
		{
			self moveto(v_loc + vectorscale((0, 0, 1), 45), n_time);
			self waittill(#"movedone");
			wait(randomfloatrange(1.5, 2.5));
		}
		n_time = undefined;
		v_loc = undefined;
	}
	self delete();
}

/*
	Name: function_3c07c22e
	Namespace: namespace_7922d3d4
	Checksum: 0x76A2B3CD
	Offset: 0x7920
	Size: 0x160
	Parameters: 0
	Flags: Linked
*/
function function_3c07c22e()
{
	level endon(#"end_game", #"hash_681be3e1ac458d79", #"hash_106bb5214b1fb1e6");
	self endon(#"death");
	while(true)
	{
		level waittill(#"hash_597743410e6561dd");
		var_1ef7b21 = randomintrange(20, 40);
		if(randomint(100) < 50)
		{
			namespace_c05f06c7::function_2057ddc1(self.origin, "knight_trap", "kill", array(0), #"hash_59600c8c9675d5f9", var_1ef7b21, 1, 1);
		}
		else
		{
			namespace_c05f06c7::function_2057ddc1(self.origin, "knight_trap", "kill", array(1), #"hash_59600b8c9675d446", var_1ef7b21, 1, 1);
		}
	}
}

/*
	Name: function_46e4dd8b
	Namespace: namespace_7922d3d4
	Checksum: 0xFECF8B8B
	Offset: 0x7A88
	Size: 0xF0
	Parameters: 1
	Flags: Linked
*/
function function_46e4dd8b(a_s_locs)
{
	level endon(#"hash_106bb5214b1fb1e6");
	self endon(#"death");
	var_94c758f2 = array::randomize(a_s_locs);
	foreach(s_loc in var_94c758f2)
	{
		if(distance2dsquared(s_loc.origin, self.origin > 250000))
		{
			return s_loc.origin;
		}
	}
}

/*
	Name: function_3f504167
	Namespace: namespace_7922d3d4
	Checksum: 0x9A088A90
	Offset: 0x7B80
	Size: 0x19A
	Parameters: 0
	Flags: Linked
*/
function function_3f504167()
{
	level endon(#"hash_106bb5214b1fb1e6");
	self endon(#"death");
	var_2b198109 = array::randomize(getaiarchetypearray(#"zombie"));
	foreach(e_zombie in var_2b198109)
	{
		if(isalive(e_zombie) && (!(isdefined(e_zombie.var_c57bc555) && e_zombie.var_c57bc555)))
		{
			var_e07059fa = namespace_c05f06c7::function_a8176b98(e_zombie.origin);
		}
		if(isdefined(var_e07059fa) && zm_zonemgr::function_66bf6a43(var_e07059fa) && distance2dsquared(var_e07059fa, self.origin > 250000))
		{
			if(isdefined(e_zombie))
			{
				e_zombie.var_c57bc555 = 1;
			}
			return var_e07059fa;
		}
	}
	return undefined;
}

/*
	Name: function_de2561ce
	Namespace: namespace_7922d3d4
	Checksum: 0xC7399998
	Offset: 0x7D28
	Size: 0x58
	Parameters: 2
	Flags: Linked
*/
function function_de2561ce(v_start, v_end)
{
	n_distance = distance2d(v_start, v_end);
	n_time = n_distance / 400;
	return n_time;
}

/*
	Name: function_de68c9b7
	Namespace: namespace_7922d3d4
	Checksum: 0xDC75B343
	Offset: 0x7D88
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_de68c9b7(s_params)
{
	if(!(isdefined(self.var_3f5addd0) && self.var_3f5addd0))
	{
		return;
	}
	if(!(isdefined(level.var_be97413) && level.var_be97413))
	{
		level thread function_5ffc956(self.origin);
	}
}

/*
	Name: function_5ffc956
	Namespace: namespace_7922d3d4
	Checksum: 0xFA12DA5D
	Offset: 0x7DF8
	Size: 0x13A
	Parameters: 1
	Flags: Linked
*/
function function_5ffc956(v_zombie_origin)
{
	level endon(#"end_game", #"hash_6402d013069eb3a");
	e_closest_player = arraygetclosest(v_zombie_origin, zm_vo::function_347f7d34());
	if(isalive(e_closest_player) && e_closest_player util::is_player_looking_at(v_zombie_origin) && distance2dsquared(v_zombie_origin, e_closest_player.origin) < 147456)
	{
		level.var_be97413 = 1 === e_closest_player zm_audio::create_and_play_dialog(#"kill", #"knight_trap", undefined, 1);
	}
	if(isdefined(level.var_be97413) && level.var_be97413)
	{
		wait(25);
		level.var_be97413 = 0;
	}
}

/*
	Name: function_b646e75d
	Namespace: namespace_7922d3d4
	Checksum: 0xC893DFB5
	Offset: 0x7F40
	Size: 0x1D6
	Parameters: 0
	Flags: Linked
*/
function function_b646e75d()
{
	level endon(#"hash_106bb5214b1fb1e6");
	level flag::wait_till(#"hash_6402d013069eb3a");
	level thread zm_utility::function_9ad5aeb1(0, 1, 0, 1, 0);
	wait(2);
	var_65c9997c = getent("stone_forest", "targetname");
	s_loc = struct::get("kp_forest");
	var_65c9997c notify(#"hash_3946eb0fdd8a2c0e");
	var_65c9997c stoploopsound();
	var_65c9997c playsound(#"hash_7fb9d3b7c445909f");
	wait(0.5);
	var_65c9997c rotateto(var_65c9997c.v_start_angles, 1);
	var_65c9997c moveto(var_65c9997c.v_start_origin, 2);
	var_65c9997c waittill(#"movedone");
	var_65c9997c clientfield::set("" + #"hash_141bb928b3d09e20", 0);
	var_47323b73 = var_65c9997c zm_unitrigger::create(undefined, (80, 80, 100), &function_c9ebaa3);
}

/*
	Name: function_c9ebaa3
	Namespace: namespace_7922d3d4
	Checksum: 0x401E0204
	Offset: 0x8120
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_c9ebaa3()
{
	level endon(#"hash_106bb5214b1fb1e6");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		player thread namespace_c05f06c7::function_f15c4657();
		level thread function_78a99a79();
		zm_unitrigger::unregister_unitrigger(self.stub);
	}
}

/*
	Name: function_78a99a79
	Namespace: namespace_7922d3d4
	Checksum: 0x3D8F609E
	Offset: 0x81E0
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_78a99a79()
{
	var_65c9997c = getent("stone_forest", "targetname");
	if(isdefined(var_65c9997c))
	{
		v_loc = var_65c9997c.origin + vectorscale((0, 0, 1), 32);
		var_65c9997c clientfield::set("" + #"hash_60051e21f8eb4af", 1);
		var_65c9997c playsound(#"hash_6386a4b7daf03dea");
		var_65c9997c thread util::delayed_delete(1);
		level thread zm_powerups::specific_powerup_drop(#"full_ammo", v_loc);
	}
	level flag::set(#"hash_2d21160da504fb1");
}

/*
	Name: function_6b0caad3
	Namespace: namespace_7922d3d4
	Checksum: 0x207CE067
	Offset: 0x82F8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_6b0caad3()
{
	level flag::wait_till(#"hash_2427d27d352e9454");
	namespace_c05f06c7::function_45ac4bb8();
	level thread function_3d151222(#"forest", #"defend");
}

/*
	Name: function_52529102
	Namespace: namespace_7922d3d4
	Checksum: 0x54D93076
	Offset: 0x8368
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_52529102()
{
	level flag::wait_till(#"hash_2d21160da504fb1");
	namespace_c05f06c7::function_5904a8e1();
	exploder::stop_exploder("fxexp_barrier_gameplay_forest");
	level thread namespace_c05f06c7::function_f1c106b("loc2", 0);
	level flag::clear(#"hash_1b9ecc7979b0fcfb");
	level clientfield::set("fasttravel_exploder", 1);
}

/*
	Name: function_81b48f5f
	Namespace: namespace_7922d3d4
	Checksum: 0xC238E9ED
	Offset: 0x8420
	Size: 0x100
	Parameters: 1
	Flags: None
*/
function function_81b48f5f(var_65500f70)
{
	var_e9b059c7 = [];
	foreach(var_70e1deb9 in var_65500f70)
	{
		if(var_70e1deb9.script_noteworthy == "zone_forest_n" || var_70e1deb9.script_noteworthy == "zone_forest_s")
		{
			if(!isdefined(var_e9b059c7))
			{
				var_e9b059c7 = [];
			}
			else if(!isarray(var_e9b059c7))
			{
				var_e9b059c7 = array(var_e9b059c7);
			}
			var_e9b059c7[var_e9b059c7.size] = var_70e1deb9;
		}
	}
	return var_e9b059c7;
}

/*
	Name: function_68a397a0
	Namespace: namespace_7922d3d4
	Checksum: 0xB91D2311
	Offset: 0x8528
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_68a397a0()
{
	level endon(#"hash_106bb5214b1fb1e6");
	level flag::wait_till(#"hash_2427d27d352e9454");
	level flag::clear(#"spawn_zombies");
	level flag::clear(#"zombie_drop_powerups");
	level.var_be97413 = 0;
	callback::on_ai_killed(&function_de68c9b7);
	wait(2);
	level thread namespace_c05f06c7::function_bb613572(function_d11cc23b(), #"hash_6402d013069eb3a");
	level thread _angles_cp_medal_no_deaths();
	level flag::wait_till("forest_final");
	function_b5ab717();
	level thread function_3d151222(#"forest", #"hash_73e9e7476fdbc069");
	level thread function_769c307c();
	callback::remove_on_ai_killed(&function_de68c9b7);
	level flag::set(#"hash_6402d013069eb3a");
}

/*
	Name: function_769c307c
	Namespace: namespace_7922d3d4
	Checksum: 0x70A24DE
	Offset: 0x86E8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_769c307c()
{
	level endon(#"boss_fight_started");
	wait(15);
	level flag::set(#"spawn_zombies");
	level flag::set(#"zombie_drop_powerups");
}

/*
	Name: function_3d151222
	Namespace: namespace_7922d3d4
	Checksum: 0x5004368
	Offset: 0x8758
	Size: 0x174
	Parameters: 2
	Flags: Linked, Private
*/
private function function_3d151222(var_f49ead21, var_5e1197bc)
{
	var_4421515 = array(#"zone_forest_n", #"zone_forest_center", #"zone_forest_s");
	a_e_players = array::randomize(util::get_active_players());
	foreach(e_player in a_e_players)
	{
		str_zone = e_player zm_zonemgr::get_player_zone();
		if(isdefined(str_zone))
		{
			var_fafc280c = hash(str_zone);
			if(array::contains(var_4421515, var_fafc280c))
			{
				e_player thread zm_audio::create_and_play_dialog(var_f49ead21, var_5e1197bc, undefined, 1);
				break;
			}
		}
	}
}

/*
	Name: _angles_cp_medal_no_deaths
	Namespace: namespace_7922d3d4
	Checksum: 0x5EF1D6B8
	Offset: 0x88D8
	Size: 0x3B8
	Parameters: 0
	Flags: Linked
*/
function _angles_cp_medal_no_deaths()
{
	function_f0a7d11b();
	wait(10);
	switch(getplayers().size)
	{
		case 1:
		{
			n_num = 64;
			n_next_wave = 42;
			break;
		}
		case 2:
		{
			n_num = 84;
			n_next_wave = 60;
			break;
		}
		case 3:
		{
			n_num = 114;
			n_next_wave = 82;
			break;
		}
		case 4:
		{
			n_num = 164;
			n_next_wave = 112;
			break;
		}
	}
	var_18f3c565 = [];
	var_a1fc54b0 = 0;
	var_3833f77b = 0;
	while(!level flag::get(#"hash_6402d013069eb3a"))
	{
		wait(1);
		if(!var_a1fc54b0 && level.var_3dd9f9be >= n_next_wave)
		{
			var_a1fc54b0 = 1;
			level flag::set(#"hash_29b12646045186fa");
			wait(15 - getplayers().size);
			level flag::clear(#"hash_29b12646045186fa");
		}
		if(!var_3833f77b && level.var_3dd9f9be >= n_num)
		{
			var_3833f77b = 1;
			level flag::set("forest_final");
			level flag::set(#"hash_29b12646045186fa");
			wait(15 - getplayers().size);
			level flag::clear(#"hash_29b12646045186fa");
		}
		a_zombies = getaiarchetypearray(#"zombie");
		if(level.var_8a64ef3a < 9 && a_zombies.size >= 9)
		{
			if(!var_18f3c565.size)
			{
				var_18f3c565 = array::randomize(array(#"hash_48d8727043be63bc", #"hash_cc3279e1c9378c3", #"hash_f320466b419b45", #"hash_45bc5c87327d33a2"));
			}
			foreach(ai in a_zombies)
			{
				if(ai namespace_e0710ee6::function_db610082())
				{
					zm_transform::function_9acf76e6(ai, array::pop(var_18f3c565, undefined, 0));
					break;
				}
			}
		}
	}
}

/*
	Name: function_b5ab717
	Namespace: namespace_7922d3d4
	Checksum: 0x2C1564CC
	Offset: 0x8C98
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_b5ab717()
{
	a_players = getplayers();
	switch(a_players.size)
	{
		case 1:
		{
			n_num = 3;
			n_active = 2;
			break;
		}
		case 2:
		{
			n_num = 4;
			n_active = 2;
			break;
		}
		case 3:
		{
			n_num = 5;
			n_active = 3;
			break;
		}
		case 4:
		{
			n_num = 6;
			n_active = 4;
			break;
		}
	}
	level thread function_a78b58f6(n_active, n_num, #"hash_6402d013069eb3a");
	while(level.var_b02bf6d2 < n_num)
	{
		wait(0.5);
	}
}

/*
	Name: function_9b73d9d3
	Namespace: namespace_7922d3d4
	Checksum: 0x57D840BC
	Offset: 0x8DC0
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_9b73d9d3(params)
{
	level.var_3f26be33--;
	level.var_1d2ffde3++;
}

/*
	Name: zmb_ee_key_pickupmemberdeath
	Namespace: namespace_7922d3d4
	Checksum: 0xE5F62E09
	Offset: 0x8DF0
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function zmb_ee_key_pickupmemberdeath()
{
	for(var_1363654e = 1; var_1363654e < 4; var_1363654e++)
	{
		level waittill(#"hash_3c7945247db32d89");
		zm_audio::sndmusicsystem_playstate("quest_" + var_1363654e);
		playsoundatposition(#"hash_27659ddbc81c63cc" + var_1363654e, (0, 0, 0));
	}
}

/*
	Name: forest_entrance
	Namespace: namespace_7922d3d4
	Checksum: 0x5D991B96
	Offset: 0x8E88
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function forest_entrance()
{
	level flag::wait_till_all(array(#"hash_2d21160da504fb1", #"hash_1abd4da28f5bc572", #"hash_10693cfc20e83df1"));
	scene::add_scene_func(#"p8_fxanim_zm_man_druid_door_bundle", &function_de7be188, "init");
	level scene::init(#"p8_fxanim_zm_man_druid_door_bundle");
	scene::remove_scene_func(#"p8_fxanim_zm_man_druid_door_bundle", &function_de7be188, "init");
	s_door = struct::get("s_forest_door");
	s_door zm_unitrigger::create(#"hash_6d663dca450595ef", 150);
	s_door thread trigger_forest_entrance();
}

/*
	Name: function_de7be188
	Namespace: namespace_7922d3d4
	Checksum: 0x2F34CC6C
	Offset: 0x8FD8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_de7be188(a_ents)
{
	level.var_bc889083 = a_ents[getfirstarraykey(a_ents)];
	level.var_bc889083 ghost();
}

/*
	Name: trigger_forest_entrance
	Namespace: namespace_7922d3d4
	Checksum: 0x3548A63F
	Offset: 0x9030
	Size: 0x334
	Parameters: 0
	Flags: Linked
*/
function trigger_forest_entrance()
{
	e_door = getent("forest_stone_holder", "targetname");
	while(true)
	{
		self waittill(#"trigger_activated");
		e_door playsound(#"hash_4a0656a938f60847");
		b_using = 1;
		n_time = 0;
		while(n_time < 2.5)
		{
			foreach(player in getplayers())
			{
				if(!player usebuttonpressed() || !zm_utility::can_use(player) || !isdefined(self.s_unitrigger) || !isdefined(self.s_unitrigger.trigger) || !player istouching(self.s_unitrigger.trigger))
				{
					b_using = 0;
					n_time = 0;
					break;
				}
			}
			if(b_using == 0)
			{
				e_door playsound(#"hash_7b1799e118dcfdc6");
				e_door clientfield::set("" + #"hash_5eff598dc267e32a", 0);
				break;
			}
			e_door clientfield::set("" + #"hash_5eff598dc267e32a", 1);
			wait(0.1);
			n_time = n_time + 0.1;
		}
		if(b_using == 1)
		{
			e_door playsound(#"hash_6e67bd5897b45cb1");
			break;
		}
		wait(0.1);
	}
	player = array::random(zm_vo::function_347f7d34());
	if(isdefined(player))
	{
		player thread zm_vo::function_a2bd5a0c(#"hash_7cedb4ec0f14ff50", 1);
	}
	level thread function_a112ed5e();
	if(isdefined(self.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	}
}

/*
	Name: function_a112ed5e
	Namespace: namespace_7922d3d4
	Checksum: 0xA4B44B8D
	Offset: 0x9370
	Size: 0x454
	Parameters: 0
	Flags: Linked
*/
function function_a112ed5e()
{
	exploder::exploder("exp_lgt_boss_entrance");
	array::run_all(util::get_active_players(), &freezecontrolsallowlook, 1);
	array::run_all(util::get_active_players(), &val::set, "boss_door_opening", "ignoreme", 1);
	array::run_all(util::get_active_players(), &val::set, "boss_door_opening", "takedamage", 0);
	wait(1);
	array::run_all(util::get_active_players(), &clientfield::increment_to_player, "" + #"hash_73a4abf07bc65bc3", 1);
	var_3f81f68b = getent("relic_greenhouse", "targetname");
	var_b32bc0a = getent("relic_cemetery", "targetname");
	var_d73febbe = getent("relic_forest", "targetname");
	mdl_door = getent("forest_stone_holder", "targetname");
	if(isdefined(var_3f81f68b) && isdefined(var_b32bc0a) && isdefined(var_d73febbe))
	{
		mdl_door clientfield::set("" + #"hash_5eff598dc267e32a", 0);
		var_3f81f68b clientfield::set("" + #"hash_5eff598dc267e32a", 0);
		var_b32bc0a clientfield::set("" + #"hash_5eff598dc267e32a", 0);
		var_d73febbe clientfield::set("" + #"hash_5eff598dc267e32a", 0);
		wait(1.25);
		level.var_bc889083 show();
		level.var_bc889083 = undefined;
		mdl_door delete();
		var_3f81f68b delete();
		var_b32bc0a delete();
		var_d73febbe delete();
	}
	level scene::play(#"p8_fxanim_zm_man_druid_door_bundle");
	wait(2.5);
	namespace_ee206246::start(#"hash_221e18c31e82092d");
	level flag::set(#"hash_4b00aa230ebbe82b");
	wait(2);
	array::run_all(util::get_active_players(), &freezecontrolsallowlook, 0);
	array::run_all(util::get_active_players(), &val::reset, "boss_door_opening", "ignoreme");
	array::run_all(util::get_active_players(), &val::reset, "boss_door_opening", "takedamage");
}

/*
	Name: function_d11cc23b
	Namespace: namespace_7922d3d4
	Checksum: 0xF48A2AFD
	Offset: 0x97D0
	Size: 0x122
	Parameters: 1
	Flags: Linked
*/
function function_d11cc23b(str_script_noteworthy = "spawn_location")
{
	a_spawns = struct::get_array(str_script_noteworthy, "script_noteworthy");
	foreach(s_loc in a_spawns)
	{
		if(s_loc.targetname !== "forest_n_spawns" || s_loc.targetname !== "forest_center_spawns" || s_loc.targetname !== "forest_s_spawns")
		{
			arrayremovevalue(a_spawns, s_loc, 1);
		}
	}
	return array::remove_undefined(a_spawns);
}

/*
	Name: function_f0a7d11b
	Namespace: namespace_7922d3d4
	Checksum: 0xCFEEFFC6
	Offset: 0x9900
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function function_f0a7d11b()
{
	if(!isdefined(level.var_8a64ef3a))
	{
		level.var_8a64ef3a = 0;
	}
	var_c1da220b = getspawnerarray("zombie_spawner_catalyst_corrosive", "targetname")[0];
	zm_transform::function_cfca77a7(var_c1da220b, #"hash_48d8727043be63bc", &namespace_e0710ee6::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_corrosive_spawn_pre_split", "aib_vign_zm_zod_catalyst_corrosive_spawn_post_split");
	var_c1da220b = getspawnerarray("zombie_spawner_catalyst_water", "targetname")[0];
	zm_transform::function_cfca77a7(var_c1da220b, #"hash_cc3279e1c9378c3", &namespace_e0710ee6::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_water_spawn_pre_split", "aib_vign_zm_zod_catalyst_water_spawn_post_split");
	var_c1da220b = getspawnerarray("zombie_spawner_catalyst_electric", "targetname")[0];
	zm_transform::function_cfca77a7(var_c1da220b, #"hash_f320466b419b45", &namespace_e0710ee6::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_electric_spawn_pre_split", "aib_vign_zm_zod_catalyst_electric_spawn_post_split");
	var_c1da220b = getspawnerarray("zombie_spawner_catalyst_plasma", "targetname")[0];
	zm_transform::function_cfca77a7(var_c1da220b, #"hash_45bc5c87327d33a2", &namespace_e0710ee6::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_plasma_spawn_pre_split", "aib_vign_zm_zod_catalyst_plasma_spawn_post_split");
}

/*
	Name: function_724b3e30
	Namespace: namespace_7922d3d4
	Checksum: 0x512DE604
	Offset: 0x9B18
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_724b3e30(n_health)
{
	if(!isdefined(level.var_8a64ef3a))
	{
		level.var_8a64ef3a = 0;
	}
	self.var_12745932 = 1;
	level.var_8a64ef3a++;
	level thread function_83ad8f65(self);
	if(self.var_62e81e47 == 1)
	{
		self zombie_utility::set_zombie_run_cycle("sprint");
	}
	else
	{
		self zombie_utility::set_zombie_run_cycle("run");
	}
}

/*
	Name: function_83ad8f65
	Namespace: namespace_7922d3d4
	Checksum: 0x4EE37BC6
	Offset: 0x9BD0
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function function_83ad8f65(ai)
{
	if(!isdefined(level.var_8a64ef3a))
	{
		level.var_8a64ef3a = 0;
	}
	ai waittill(#"death");
	level.var_8a64ef3a--;
}

