// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_10956a741a7e186e;
#using script_174ebb9642933bf7;
#using script_28b18e98462a3c7c;
#using script_32db4ab8dcf85b70;
#using script_3bdc2bccbfc95114;
#using script_3e5ec44cfab7a201;
#using script_3ed4043a74fa517b;
#using script_3f9e0dc8454d98e1;
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_52c6c2d1a2ef1b46;
#using script_58c342edd81589fb;
#using script_5bb072c3abf4652c;
#using script_62a0cb1167067152;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6ce38ab036223e6e;
#using script_78e9e286015f2ec;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_white.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_3e3742fd;

/*
	Name: function_89f2df9
	Namespace: namespace_3e3742fd
	Checksum: 0xF94A0D52
	Offset: 0x1470
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_290a78ab47105457", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3e3742fd
	Checksum: 0xF1A3D33F
	Offset: 0x14C0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_842831cf();
}

/*
	Name: __main__
	Namespace: namespace_3e3742fd
	Checksum: 0xEAF5B252
	Offset: 0x14E0
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	init_flags();
	function_ba863dca();
	function_ab78507c();
	level thread namespace_92cb027a::init();
	function_55672ea2();
	function_a7aa6c6b();
	function_aabbf13f();
	function_95a1b94();
	function_4455583f();
	if(zm_utility::function_e51dc2d8())
	{
		function_1b65b427();
	}
	var_90959fc6 = getentarray("alert_me", "targetname");
	foreach(var_b2e1ce80 in var_90959fc6)
	{
		var_b2e1ce80 function_2b5d562e("off");
	}
}

/*
	Name: function_842831cf
	Namespace: namespace_3e3742fd
	Checksum: 0x91D04E79
	Offset: 0x1650
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function function_842831cf()
{
	clientfield::register("scriptmover", "fx_steam_lab_dry_ice", 1, 1, "int");
	clientfield::register("world", "portal_map_to_nuclear_state", 1, 1, "int");
	clientfield::register("scriptmover", "fx_shard_glow_clientfield", 20000, 1, "int");
	clientfield::register("toplayer", "clock_interact_feedback", 20000, 1, "counter");
	clientfield::register("toplayer", "server_carry_feedback", 20000, 1, "counter");
	clientfield::register("toplayer", "server_carry_fail_feedback", 20000, 1, "counter");
	clientfield::register("toplayer", "server_carry_audio_feedback", 20000, 1, "int");
	clientfield::register("vehicle", "fx8_power_wisp_lg", 1, 1, "int");
	clientfield::register("scriptmover", "fx8_quest_mannequin_initial_sparks", 1, 1, "int");
	clientfield::register("scriptmover", "fx8_quest_mannequin_charging", 1, 1, "int");
	clientfield::register("scriptmover", "fx8_quest_mannequin_explode_main", 1, 1, "int");
}

/*
	Name: init_flags
	Namespace: namespace_3e3742fd
	Checksum: 0x71AB6DC5
	Offset: 0x1870
	Size: 0x614
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"mq_computer_activated");
	level flag::init(#"hash_58b6a09577af5b6d");
	level flag::init(#"hash_3b5dac8c2aa1bb31");
	level flag::init(#"hash_13e9bb1de846d022");
	level flag::init(#"hash_63d6d5191ca09cae");
	for(i = 0; i < 5; i++)
	{
		level flag::init(#"hash_ef15c4b3a1dfd31" + i);
	}
	for(i = 1; i <= 6; i++)
	{
		level flag::init(#"hash_714c5c1fbba11970" + i);
	}
	level flag::init(#"hash_10b7ed627014a952");
	level flag::init(#"hash_15ca9944ac87c57e");
	level flag::init(#"hash_32c6d727b3de8407");
	level flag::init(#"hash_3ee4f9c58fbc63bd");
	level flag::init(#"hash_485ced30125950ac");
	level flag::init(#"hash_4046ffe851ff5b1c");
	level flag::init(#"hash_2a7f2737e415ffd1");
	level flag::init(#"hash_b53fb25b12e713");
	level flag::init(#"hash_84e6c8a0b5f7e1e");
	level flag::init(#"hash_5744a0be920e5002");
	level flag::init(#"hash_487c2805cd41d547");
	level flag::init(#"hash_2b7c76b6b0dfc0fd");
	level flag::init(#"boss_fight_started");
	level flag::init(#"boss_fight_complete");
	level flag::init(#"hash_7432d2728d0f50e8");
	level flag::init(#"hash_5aa1c9627e8626e0");
	level flag::init(#"hash_7cc3b03eefb11fc");
	level flag::init(#"hash_2fd002acaea672e4");
	level flag::init(#"crawler_step_complete");
	level flag::init(#"hash_bbe0772d001265");
	level flag::init(#"hash_6a79293e26344b0f");
	level flag::init(#"hash_8f3e7e5efab6d13");
	level flag::init(#"hash_4ad92dd97af40a26");
	level flag::init(#"hash_bd08d5649673cd1");
	level flag::init(#"hash_1478cafcd626c361");
	level flag::init(#"circuit_step_complete");
	level flag::init(#"hash_60eeaaec1ff2cb28");
	level flag::init(#"hash_a2a33348aff3bff");
	level flag::init(#"hash_2f57ff102a73c0b5");
	level flag::init(#"hash_687dde640557a121");
	level flag::init(#"hash_6899cc997afd5fac");
	level flag::init(#"hash_6ebb9d0d0539bf68");
	level flag::init(#"hash_3b808ddcae9fea60");
	level flag::init(#"hash_7c2ae917559738ec");
	level flag::init(#"hash_12854365001ac5c");
	level flag::init(#"hash_3972ecbdd044ba98");
	level flag::init(#"hash_7e4bffd972b5993a");
	level flag::init(#"hash_66be0eea77b87d58");
	level flag::init(#"hash_1227f015cd55af9d");
}

/*
	Name: function_ba863dca
	Namespace: namespace_3e3742fd
	Checksum: 0x58150AED
	Offset: 0x1E90
	Size: 0x4AE
	Parameters: 0
	Flags: Linked
*/
function function_ba863dca()
{
	namespace_ee206246::register(#"hash_26a9aef6e9be5b86", #"crawler_start", #"hash_6dd6bf1a83b01f98", &function_3f4e9f0b, &function_6b2000cc);
	namespace_ee206246::register(#"hash_75f9f80c2256f3d3", #"canister_start", #"hash_3c45f2a0212121a5", &function_35829796, &function_3d6aec4);
	namespace_ee206246::register(#"hash_19d484735f237f45", #"hash_f301a963b67d8a3", #"hash_d7eabbef3c0ad57", &function_410eb13b, &_that_peek);
	namespace_ee206246::register(#"hash_ab36ea0a749269d", #"hash_1bd37826d376d83d", #"hash_66cc75d9d9624f3f", &function_8d0fab49, &function_7c2844de);
	namespace_ee206246::register(#"hash_8ad205f0a62b56e", #"hash_2873e4263b1aed76", #"hash_5bf53c01af16d950", &function_32a04434, &function_d221a1e8);
	namespace_ee206246::register(#"hash_8ad205f0a62b56e", #"hash_2873e3263b1aebc3", #"hash_5bf53f01af16de69", &function_553ec923, &function_b7fa863b);
	level.var_8bc5329 = [];
	level.var_8bc5329[0] = [];
	level.var_8bc5329[0][#"quest"] = #"hash_26a9aef6e9be5b86";
	level.var_8bc5329[0][#"flag"] = #"crawler_step_complete";
	level.var_8bc5329[1] = [];
	level.var_8bc5329[1][#"quest"] = #"hash_75f9f80c2256f3d3";
	level.var_8bc5329[1][#"flag"] = #"hash_6a79293e26344b0f";
	function_f46a1855();
	level.var_8bc5329[2] = [];
	level.var_8bc5329[2][#"quest"] = #"hash_19d484735f237f45";
	level.var_8bc5329[2][#"flag"] = #"circuit_step_complete";
	level.var_8bc5329[3] = [];
	level.var_8bc5329[3][#"quest"] = #"hash_ab36ea0a749269d";
	level.var_8bc5329[3][#"flag"] = #"hash_2f57ff102a73c0b5";
	level flag::init(#"hash_66ee9231ad909f7e");
	level.var_f7d08898 = [];
	level.var_e1b5b6fe = 0;
	level.var_8bc5329 = array::randomize(level.var_8bc5329);
}

/*
	Name: function_ab78507c
	Namespace: namespace_3e3742fd
	Checksum: 0xB42E54E4
	Offset: 0x2348
	Size: 0x38E
	Parameters: 0
	Flags: Linked
*/
function function_ab78507c()
{
	namespace_ee206246::register(#"hash_290a78ab47105457", #"hash_482ab5c3c8c111fc", #"hash_2400e42b1267ab11", &function_2b1ff821, &function_40f35ada);
	namespace_ee206246::register(#"hash_290a78ab47105457", #"hash_5f145cd2c7213440", #"hash_2400e12b1267a5f8", &function_43cc6c97, &function_4924cb9a);
	namespace_ee206246::register(#"hash_290a78ab47105457", #"hash_2bfae7e6471ca2aa", #"hash_2400e22b1267a7ab", &function_150faad9, &function_68d29adf);
	namespace_ee206246::register(#"hash_290a78ab47105457", #"hash_3f4bee62afbe0d8", #"hash_2400e72b1267b02a", &function_cb313a15, &function_89ec3a1c);
	namespace_ee206246::register(#"hash_290a78ab47105457", #"hash_7e699fb68d38bb56", #"hash_2400e82b1267b1dd", &function_5446e4c0, &function_c87f079a);
	namespace_ee206246::register(#"hash_290a78ab47105457", #"hash_679116c8fb952990", #"hash_2400e52b1267acc4", &function_aa0bf75b, &function_d12818ba);
	namespace_ee206246::register(#"hash_290a78ab47105457", #"hash_3a3d5f6df2a45005", #"hash_2400e62b1267ae77", &function_9952862f, &function_ad2bd43);
	namespace_ee206246::register(#"hash_290a78ab47105457", #"hash_12ea405f7c5f915c", #"hash_2400db2b12679bc6", &function_cce995f2, &function_6c9fdfa1);
	namespace_ee206246::register(#"hash_290a78ab47105457", #"hash_3a9a71b60d9f9435", #"hash_2400dc2b12679d79", &function_584620c3, &function_aea19bda);
	level.var_7be97400 = struct::get("hal_trigger", "targetname");
}

/*
	Name: function_1b65b427
	Namespace: namespace_3e3742fd
	Checksum: 0xA00F55CB
	Offset: 0x26E0
	Size: 0x292
	Parameters: 0
	Flags: Linked
*/
function function_1b65b427()
{
	s_hint = struct::get("mars_hint", "targetname");
	s_hint zm_unitrigger::create("", 72);
	s_hint thread function_550420a3();
	level.var_f1921b3 = getent("e_tobias", "targetname");
	level.var_f1921b3 thread function_931fd8c2();
	var_fba5dd09 = struct::get("marlton_door_scene", "targetname");
	level.var_55c50ef4 = var_fba5dd09.scene_ents[#"hash_7aff0ee60ddd937b"];
	level.var_55c50ef4.name = "marl";
	level.var_55c50ef4.isspeaking = 0;
	level.var_55c50ef4.var_5b6ebfd0 = 0;
	level.var_3e7698ce = [];
	for(i = 0; i < 10; i++)
	{
		level.var_3e7698ce[i] = i;
	}
	level.var_4e3bffd = [];
	for(i = 0; i < 5; i++)
	{
		level.var_4e3bffd[i] = i;
	}
	arrayremovevalue(level.var_4e3bffd, 0);
	arrayremovevalue(level.var_4e3bffd, 1);
	arrayremovevalue(level.var_4e3bffd, 3);
	level.var_3d9e8e0c = [];
	for(i = 0; i < 5; i++)
	{
		level.var_3d9e8e0c[i] = i;
	}
	level.var_5af37cf8 = 0;
	level.var_8bd0fb2e = 0;
	level.var_1409b3a9 = 1;
	level.var_5e2c12d8 = 0;
}

/*
	Name: function_4455583f
	Namespace: namespace_3e3742fd
	Checksum: 0x70A8D4A2
	Offset: 0x2980
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function function_4455583f()
{
	level.var_48b5d413 = 0;
	level.var_69d5de93 = 0;
	level.var_bc88ffc0 = [];
	for(i = 0; i < 5; i++)
	{
		level.var_bc88ffc0[i] = 0;
	}
	level.var_9778da1 = [];
	for(i = 0; i < 5; i++)
	{
		level.var_9778da1[i] = 0;
	}
	level.var_9778da1[1] = 1;
}

/*
	Name: function_dd616fdd
	Namespace: namespace_3e3742fd
	Checksum: 0xC3AF6611
	Offset: 0x2A48
	Size: 0x5AE
	Parameters: 0
	Flags: Linked
*/
function function_dd616fdd()
{
	function_967cd489();
	callback::on_actor_killed(&function_950562c0);
	level.var_7c64053d = struct::get_array("deanna_trigger", "targetname");
	if(level.var_7c64053d.size > 0)
	{
		for(i = 0; i < level.var_7c64053d.size; i++)
		{
			s_unitrigger = level.var_7c64053d[i] zm_unitrigger::create(&function_5a971787, 64);
			s_unitrigger.b_using = 0;
			s_unitrigger.var_9c74d1b8 = 0;
			s_unitrigger.is_selected = 0;
			s_unitrigger.n_position = -1;
			s_unitrigger.is_pm = 0;
			s_unitrigger.is_rotating = 0;
			s_unitrigger.var_415347ee = getent(level.var_7c64053d[i].target, "targetname");
			if(isdefined(level.var_7c64053d[i].script_int))
			{
				s_unitrigger.var_ab28dca = randomintrange(0, 11);
				s_unitrigger.n_hour = 0;
				s_unitrigger.var_af1cfded = randomintrange(0, 3) * 15;
				s_unitrigger.n_minute = 0;
				n_code_index = level.var_7c64053d[i].script_int - 1;
				if(level.var_92d8ea2e[n_code_index].is_selected === 1)
				{
					s_unitrigger.n_position = level.var_92d8ea2e[n_code_index].n_position;
					s_unitrigger.is_selected = 1;
					s_unitrigger.var_ab28dca = level.var_92d8ea2e[n_code_index].n_hour;
					s_unitrigger.var_af1cfded = level.var_92d8ea2e[n_code_index].n_minute;
				}
				s_unitrigger.var_92ac68d0 = level.var_7c64053d[i].script_int;
				var_98235255 = struct::get_array("timecard_clock", "targetname");
				if(var_98235255.size > 0)
				{
					foreach(var_3e8690ab in var_98235255)
					{
						if(var_3e8690ab.script_int === s_unitrigger.var_92ac68d0)
						{
							s_unitrigger.var_3e8690ab = var_3e8690ab;
						}
					}
				}
				var_9abca91c = getentarray("hour_hand", "targetname");
				if(var_9abca91c.size > 0)
				{
					foreach(var_cded5573 in var_9abca91c)
					{
						if(var_cded5573.script_int === s_unitrigger.var_92ac68d0 && isdefined(s_unitrigger.var_3e8690ab))
						{
							s_unitrigger.var_3e8690ab.hour_hand = var_cded5573;
						}
					}
				}
			}
			var_ee7af3b = s_unitrigger.var_ab28dca - randomintrange(1, 11);
			if(level.players.size == 1)
			{
				var_ee7af3b = s_unitrigger.var_ab28dca - randomintrange(1, 3);
			}
			if(var_ee7af3b < 0)
			{
				var_ee7af3b = var_ee7af3b + 12;
			}
			while(var_ee7af3b == s_unitrigger.var_ab28dca)
			{
				var_ee7af3b = randomintrange(0, 11);
			}
			var_6f927674 = randomintrange(0, 3) * 15;
			s_unitrigger.var_3e8690ab namespace_3be0b7ad::function_9b62d333(var_ee7af3b, var_6f927674);
			s_unitrigger.n_hour = var_ee7af3b;
			s_unitrigger.n_minute = var_6f927674;
			level.var_7c64053d[i] thread function_2193794();
			level.var_7c64053d[i] thread function_5391159f();
		}
	}
}

/*
	Name: function_d7662e16
	Namespace: namespace_3e3742fd
	Checksum: 0x18F25EC2
	Offset: 0x3000
	Size: 0x6A
	Parameters: 2
	Flags: None
*/
function function_d7662e16(var_ee7af3b, var_6f927674)
{
	self.is_rotating = 1;
	self.var_3e8690ab namespace_3be0b7ad::function_9b62d333(var_ee7af3b, var_6f927674);
	self.n_hour = var_ee7af3b;
	self.n_minute = var_6f927674;
	self.is_rotating = 0;
}

/*
	Name: setclock
	Namespace: namespace_3e3742fd
	Checksum: 0xCD6B4B37
	Offset: 0x3078
	Size: 0x1C0
	Parameters: 3
	Flags: None
*/
function setclock(n_hour, n_minute, is_fast)
{
	var_97ee4db9 = 0;
	var_f797d4af = 0;
	var_ed5a0a1a = self.n_hour * 60 + self.n_minute;
	var_21d43c4d = n_hour * 60 + n_minute;
	if(var_21d43c4d < var_ed5a0a1a)
	{
		var_97ee4db9 = 360 - self.n_minute * 6;
		var_f797d4af = 360 - self.n_hour * 30 + self.n_minute / 2;
		var_97ee4db9 = var_97ee4db9 + var_21d43c4d * 6;
		var_f797d4af = var_f797d4af + var_21d43c4d / 2;
	}
	else
	{
		var_97ee4db9 = var_97ee4db9 + var_21d43c4d - var_ed5a0a1a * 6;
		var_f797d4af = var_f797d4af + var_21d43c4d - var_ed5a0a1a / 2;
	}
	var_191e6b71 = var_97ee4db9 / 90 * 0.5;
	if(is_fast === 1)
	{
		var_191e6b71 = var_97ee4db9 / 360 * 0.5;
	}
	if(var_191e6b71 != 0)
	{
		self.var_fb4b0c60 rotateroll(-1 * var_97ee4db9, var_191e6b71);
		self.var_31285da7 rotateroll(-1 * var_f797d4af, var_191e6b71);
	}
	return var_191e6b71;
}

/*
	Name: function_c3a3c077
	Namespace: namespace_3e3742fd
	Checksum: 0x64C088B6
	Offset: 0x3240
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function function_c3a3c077(e_player)
{
	/#
		if(level flag::get(""))
		{
			debug2dtext((960, 135, 0), "", (1, 1, 0), 1, (0, 0, 0), 0.5, 2, 50);
		}
	#/
	return 1;
}

/*
	Name: function_55672ea2
	Namespace: namespace_3e3742fd
	Checksum: 0x6923F89D
	Offset: 0x32B8
	Size: 0x92C
	Parameters: 0
	Flags: Linked
*/
function function_55672ea2()
{
	var_abcd244b = getent("atlas_ct", "targetname");
	var_abcd244b hidepart("tag_head");
	var_abcd244b hidepart("tag_left_arm");
	var_abcd244b hidepart("tag_right_arm");
	level.n_captured = 0;
	level.var_247a1d9f = 0;
	level.var_2b5d31d8 = 0;
	level.var_8dc9db8d = 0;
	level.var_46829c80 = 0;
	level.registerstalactite_kill_zone_waypoint_ = 0;
	level.var_7d57cb9d = 0;
	s_green = struct::get("cp_green", "script_noteworthy");
	s_yellow = struct::get("cp_yellow", "script_noteworthy");
	s_hoggat = struct::get("cp_hoggat", "script_noteworthy");
	s_hammond = struct::get("cp_hammond", "script_noteworthy");
	s_diner = struct::get("cp_diner", "script_noteworthy");
	s_lounge = struct::get("cp_lounge", "script_noteworthy");
	var_22f19cbb = [];
	a_s_delete = [];
	var_22f19cbb[0] = s_green;
	var_22f19cbb[1] = s_lounge;
	a_s_delete[0] = s_yellow;
	a_s_delete[1] = s_diner;
	if(math::cointoss())
	{
		var_22f19cbb[0] = s_yellow;
		var_22f19cbb[1] = s_diner;
		a_s_delete[0] = s_green;
		a_s_delete[1] = s_lounge;
	}
	var_22f19cbb[2] = s_hoggat;
	a_s_delete[2] = s_hammond;
	if(math::cointoss())
	{
		var_22f19cbb[2] = s_hammond;
		a_s_delete[2] = s_hoggat;
	}
	level.var_22f19cbb = var_22f19cbb;
	for(i = 0; i < var_22f19cbb.size; i++)
	{
		if(isdefined(var_22f19cbb[i].script_string))
		{
			sc = var_22f19cbb[i].script_string;
			var_dc3827e3 = getentarray(sc + "_block", "targetname");
			foreach(e_blocker in var_dc3827e3)
			{
				e_blocker notsolid();
			}
		}
	}
	for(i = 0; i < a_s_delete.size; i++)
	{
		if(isdefined(a_s_delete[i].script_string))
		{
			sc = a_s_delete[i].script_string;
			e_head = getent(sc + "_head", "script_noteworthy");
			e_body = getent(sc + "_body", "script_noteworthy");
			e_collision = getent(sc + "_collision", "targetname");
			e_part = getent(sc + "_part", "targetname");
			e_hatch = getent(sc + "_hatch", "script_noteworthy");
			var_dc3827e3 = getentarray(sc + "_block", "targetname");
			e_head delete();
			e_body delete();
			e_collision delete();
			e_part delete();
			foreach(e_blocker in var_dc3827e3)
			{
				e_blocker delete();
			}
			if(isdefined(e_hatch))
			{
				e_platform = getent(e_hatch.target, "targetname");
				e_platform delete();
			}
			a_s_delete[i] struct::delete();
		}
	}
	var_22f19cbb = struct::get_array("capture_point", "targetname");
	var_3006dbae = struct::get("atlas_trigger", "targetname");
	var_7aabee8e = 0;
	for(i = 0; i < var_22f19cbb.size; i++)
	{
		sc = var_22f19cbb[i].script_string;
		e_hatch = getent(sc + "_hatch", "script_noteworthy");
		e_head = getent(sc + "_head", "script_noteworthy");
		e_body = getent(sc + "_body", "script_noteworthy");
		e_collision = getent(sc + "_collision", "targetname");
		e_part = getent(sc + "_part", "targetname");
		var_e2f3631c = struct::get(sc + "_part_trigger", "targetname");
		var_22f19cbb[i].zone = e_head.script_string;
		e_head hide();
		e_body hide();
		e_collision notsolid();
		if(isdefined(e_hatch))
		{
			e_platform = getent(e_hatch.target, "targetname");
			e_body linkto(e_platform);
			e_head linkto(e_platform);
			e_collision linkto(e_platform);
		}
		e_part hide();
	}
	level.var_809c1579 = [];
	for(i = 0; i < 15; i++)
	{
		level.var_809c1579[i] = i;
	}
}

/*
	Name: function_a7aa6c6b
	Namespace: namespace_3e3742fd
	Checksum: 0x488048DA
	Offset: 0x3BF0
	Size: 0x312
	Parameters: 0
	Flags: Linked
*/
function function_a7aa6c6b()
{
	level.var_c90d4581 = [];
	for(i = 0; i < 6; i++)
	{
		var_eb5adace = struct::get("circuit_breaker_bundle_" + string(i), "targetname");
		if(!isdefined(level.var_c90d4581))
		{
			level.var_c90d4581 = [];
		}
		else if(!isarray(level.var_c90d4581))
		{
			level.var_c90d4581 = array(level.var_c90d4581);
		}
		level.var_c90d4581[level.var_c90d4581.size] = var_eb5adace;
		var_eb5adace thread function_d4342625();
		if(i == 1 || i == 2 || i == 4)
		{
			var_eb5adace thread scene::play("a_to_b");
			continue;
		}
		var_eb5adace thread scene::play("b_to_a");
	}
	var_ecc896a8 = getent("use_elec_switch", "targetname");
	ent_parts = getentarray(var_ecc896a8.target, "targetname");
	struct_parts = struct::get_array(var_ecc896a8.target, "targetname");
	foreach(ent in ent_parts)
	{
		if(isdefined(ent.script_noteworthy))
		{
			level.var_3bce2e41 = ent;
		}
	}
	foreach(struct in struct_parts)
	{
		if(isdefined(struct.script_noteworthy) && struct.script_noteworthy == "elec_switch_fx")
		{
			level.var_577ff068 = struct;
		}
	}
}

/*
	Name: function_95a1b94
	Namespace: namespace_3e3742fd
	Checksum: 0xEE4A4A99
	Offset: 0x3F10
	Size: 0x12A
	Parameters: 0
	Flags: Linked
*/
function function_95a1b94()
{
	level.s_server_powerhouse = struct::get("server_powerhouse", "targetname");
	level.s_server_operations = struct::get("server_operations", "targetname");
	level.s_server_powerhouse function_1d92fe23();
	level.s_server_operations function_1d92fe23();
	wait(0.3);
	level.s_server_operations function_5f6e4e8f("closed_nopart", "lights_timer_off");
	level.var_b78d5f2c = [];
	for(i = 0; i < 5; i++)
	{
		level.var_b78d5f2c[i] = 0;
	}
	level.var_dee92db3 = 0;
	level.var_ca750e86 = 0;
	level.var_d5d631ad = 0;
}

/*
	Name: function_d4342625
	Namespace: namespace_3e3742fd
	Checksum: 0x8C8365D1
	Offset: 0x4048
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_d4342625()
{
	while(true)
	{
		if(isdefined(self.scene_ents))
		{
			if(isdefined(self.scene_ents[#"hash_7aff0ee60ddd937b"]))
			{
				var_84adcbfb = self.scene_ents[#"hash_7aff0ee60ddd937b"];
				for(i = 0; i < 6; i++)
				{
					var_84adcbfb hidepart("tag_light_green_" + string(i));
					var_84adcbfb hidepart("tag_light_red_" + string(i));
				}
				break;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_aabbf13f
	Namespace: namespace_3e3742fd
	Checksum: 0x4DE94D40
	Offset: 0x4148
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_aabbf13f()
{
	var_d93ca8ec = getent("enumerator", "targetname");
	level.var_ccefdb77 = struct::get("equator", "targetname");
	level.var_464a645c = getent("base10", "targetname");
	var_d93ca8ec hide();
	level.var_bf68ff1f = 0;
	level.var_2751df72 = [];
	for(i = 0; i < 5; i++)
	{
		level.var_2751df72[i] = 0;
	}
	level.var_2751df72[0] = 1;
	level.var_1fed619f = [];
	for(i = 0; i < 5; i++)
	{
		level.var_1fed619f[i] = 0;
	}
}

/*
	Name: function_5391159f
	Namespace: namespace_3e3742fd
	Checksum: 0x429C6AA1
	Offset: 0x4290
	Size: 0x6A4
	Parameters: 0
	Flags: Linked
*/
function function_5391159f()
{
	level endon(#"insanity_mode_triggered");
	level flag::wait_till(#"hash_13e9bb1de846d022");
	pixbeginevent(#"hash_68d79ade18c24edd");
	while(!level flag::get(#"hash_63d6d5191ca09cae"))
	{
		s_result = undefined;
		s_result = self.s_unitrigger.var_415347ee waittill(#"damage");
		if(s_result.mod === "MOD_MELEE" && (!(isdefined(s_result.weapon.isheroweapon) && s_result.weapon.isheroweapon)) && self.s_unitrigger.is_rotating === 0 && level flag::get(#"hash_58b6a09577af5b6d") && !level flag::get(#"hash_63d6d5191ca09cae") && self.s_unitrigger.var_9c74d1b8 === 0)
		{
			if(self.s_unitrigger.is_selected == 0 && level flag::get(#"hash_21cd8d3c0f4ef7f"))
			{
				if(!isdefined(level.var_ebf9cb51))
				{
					level function_704b8e();
				}
				level.var_7070ea0c = s_result.eattacker;
				self function_7b7aa3ff();
			}
			else
			{
				self.s_unitrigger.is_rotating = 1;
				var_c6781a1b = self.s_unitrigger.n_hour + 1;
				if(var_c6781a1b > 11)
				{
					var_c6781a1b = 0;
				}
				self.s_unitrigger.var_3e8690ab namespace_3be0b7ad::function_64c53556();
				wait(1);
				self.s_unitrigger.n_hour = var_c6781a1b;
				if(self.s_unitrigger.n_hour == self.s_unitrigger.var_ab28dca && self.s_unitrigger.n_minute == self.s_unitrigger.var_af1cfded && self.s_unitrigger.is_selected == 1)
				{
					var_abbc737b = 1;
					switch(self.s_unitrigger.n_position)
					{
						case 0:
						{
							break;
						}
						case 1:
						{
							if(!level flag::get(#"hash_21cd4d3c0f4e8b3"))
							{
								var_abbc737b = 0;
								level thread function_643d9747();
							}
							break;
						}
						case 2:
						{
							if(!level flag::get(#"hash_21cd3d3c0f4e700"))
							{
								var_abbc737b = 0;
								level thread function_643d9747();
							}
							break;
						}
						case 3:
						{
							if(!level flag::get(#"hash_21cd6d3c0f4ec19"))
							{
								var_abbc737b = 0;
								level thread function_643d9747();
							}
							break;
						}
						case 4:
						{
							if(!level flag::get(#"hash_21cd5d3c0f4ea66"))
							{
								var_abbc737b = 0;
								level thread function_643d9747();
							}
							break;
						}
						case 5:
						{
							var_abbc737b = 0;
							level flag::set(#"hash_21cd8d3c0f4ef7f");
							break;
						}
					}
					if(var_abbc737b)
					{
						if(self.s_unitrigger.is_selected)
						{
							level flag::set(#"hash_ef15c4b3a1dfd31" + self.s_unitrigger.n_position);
						}
						if(!level flag::get(#"hash_714c5c1fbba11970" + self.s_unitrigger.var_92ac68d0))
						{
							level.var_7070ea0c = s_result.eattacker;
							level flag::set(#"hash_714c5c1fbba11970" + self.s_unitrigger.var_92ac68d0);
						}
						level thread function_fdbf869e(self.s_unitrigger.var_92ac68d0);
						self.s_unitrigger.var_9c74d1b8 = 1;
						/#
							iprintlnbold("" + self.s_unitrigger.n_position + "");
						#/
					}
				}
				else if(self.s_unitrigger.is_selected)
				{
					level flag::clear(#"hash_ef15c4b3a1dfd31" + self.s_unitrigger.n_position);
					self.s_unitrigger.var_9c74d1b8 = 0;
				}
				self.s_unitrigger.is_rotating = 0;
			}
		}
	}
	pixendevent();
}

/*
	Name: function_2193794
	Namespace: namespace_3e3742fd
	Checksum: 0x115D843C
	Offset: 0x4940
	Size: 0x83C
	Parameters: 0
	Flags: Linked
*/
function function_2193794()
{
	level flag::wait_till(#"hash_13e9bb1de846d022");
	level endon(#"hash_10a56459715cd20e", #"insanity_mode_triggered");
	while(!self.s_unitrigger.var_9c74d1b8 || self.s_unitrigger.is_selected == 0)
	{
		s_activation = undefined;
		s_activation = self waittill(#"trigger_activated");
		e_who = s_activation.e_who;
		if(self.s_unitrigger.is_rotating == 0)
		{
			if(self.s_unitrigger.is_selected == 0 && level flag::get(#"hash_21cd8d3c0f4ef7f"))
			{
				if(!isdefined(level.var_ebf9cb51))
				{
					level function_704b8e();
				}
				level.var_7070ea0c = e_who;
				self function_7b7aa3ff();
			}
			else
			{
				b_using = 1;
				while(b_using && level flag::get(#"hash_58b6a09577af5b6d"))
				{
					if(isdefined(e_who))
					{
						e_who clientfield::increment_to_player("clock_interact_feedback", 1);
					}
					self.s_unitrigger.is_rotating = 1;
					b_using = 1;
					if(!e_who usebuttonpressed() || !zm_utility::can_use(e_who) || !isdefined(self.s_unitrigger) || !isdefined(self.s_unitrigger.trigger) || !e_who istouching(self.s_unitrigger.trigger))
					{
						b_using = 0;
						break;
					}
					if(b_using)
					{
						var_c6781a1b = self.s_unitrigger.n_hour;
						var_6fad1e36 = self.s_unitrigger.n_minute + 15;
						if(var_6fad1e36 > 45)
						{
							var_6fad1e36 = 0;
							var_c6781a1b = var_c6781a1b + 1;
							if(var_c6781a1b > 11)
							{
								var_c6781a1b = 0;
							}
						}
						self.s_unitrigger.var_3e8690ab namespace_3be0b7ad::function_fba6efd4();
						self.s_unitrigger.n_hour = var_c6781a1b;
						self.s_unitrigger.n_minute = var_6fad1e36;
						wait(0.15);
					}
				}
				/#
					if(level flag::get(""))
					{
						println("" + self.s_unitrigger.n_position + "" + self.s_unitrigger.n_hour + "" + self.s_unitrigger.n_minute + "" + self.s_unitrigger.var_ab28dca + "" + self.s_unitrigger.var_af1cfded);
					}
				#/
				wait(2);
				self.s_unitrigger.is_rotating = 0;
				if(self.s_unitrigger.n_hour == self.s_unitrigger.var_ab28dca && self.s_unitrigger.n_minute == self.s_unitrigger.var_af1cfded && self.s_unitrigger.is_selected == 1)
				{
					var_abbc737b = 1;
					switch(self.s_unitrigger.n_position)
					{
						case 0:
						{
							break;
						}
						case 1:
						{
							if(!level flag::get(#"hash_21cd4d3c0f4e8b3"))
							{
								var_abbc737b = 0;
								level thread function_643d9747();
							}
							break;
						}
						case 2:
						{
							if(!level flag::get(#"hash_21cd3d3c0f4e700"))
							{
								var_abbc737b = 0;
								level thread function_643d9747();
							}
							break;
						}
						case 3:
						{
							if(!level flag::get(#"hash_21cd6d3c0f4ec19"))
							{
								var_abbc737b = 0;
								level thread function_643d9747();
							}
							break;
						}
						case 4:
						{
							if(!level flag::get(#"hash_21cd5d3c0f4ea66"))
							{
								var_abbc737b = 0;
								level thread function_643d9747();
							}
							break;
						}
						case 5:
						{
							var_abbc737b = 0;
							level flag::set(#"hash_21cd8d3c0f4ef7f");
							break;
						}
					}
					if(var_abbc737b)
					{
						playsoundatposition(#"hash_1f1d2aad111ff462", self.s_unitrigger.origin);
						level flag::set(#"hash_ef15c4b3a1dfd31" + self.s_unitrigger.n_position);
						if(!level flag::get(#"hash_714c5c1fbba11970" + self.s_unitrigger.var_92ac68d0))
						{
							level.var_7070ea0c = e_who;
							level flag::set(#"hash_714c5c1fbba11970" + self.s_unitrigger.var_92ac68d0);
						}
						level thread function_fdbf869e(self.s_unitrigger.var_92ac68d0);
						self.s_unitrigger.var_9c74d1b8 = 1;
						/#
							iprintlnbold("" + self.s_unitrigger.n_position + "");
						#/
					}
				}
				else if(self.s_unitrigger.is_selected)
				{
					level flag::clear(#"hash_ef15c4b3a1dfd31" + self.s_unitrigger.n_position);
					self.s_unitrigger.var_9c74d1b8 = 0;
				}
			}
		}
		else
		{
			while(self.s_unitrigger.is_rotating == 1)
			{
				wait(0.1);
			}
		}
	}
}

/*
	Name: function_7b7aa3ff
	Namespace: namespace_3e3742fd
	Checksum: 0x25EFF6A3
	Offset: 0x5188
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_7b7aa3ff()
{
	a_time = level.var_ebf9cb51;
	self.s_unitrigger.is_rotating = 1;
	self.s_unitrigger.var_9c74d1b8 = 1;
	self.s_unitrigger.var_3e8690ab namespace_3be0b7ad::function_9b62d333(a_time[#"hour"], a_time[#"minute"]);
	var_97ee4db9 = 360 - self.s_unitrigger.n_minute * 6;
	self.s_unitrigger.n_minute = a_time[#"minute"];
	self.s_unitrigger.n_hour = a_time[#"hour"];
	if(isdefined(level.var_7070ea0c))
	{
		level.var_7070ea0c namespace_509a75d1::function_51b752a9("vox_generic_responses_positive");
	}
	else
	{
		level namespace_509a75d1::function_fd24e47f("vox_generic_responses_positive");
	}
	if(!level flag::get(#"hash_714c5c1fbba11970" + self.s_unitrigger.var_92ac68d0))
	{
		level flag::set(#"hash_714c5c1fbba11970" + self.s_unitrigger.var_92ac68d0);
	}
	level thread function_fdbf869e(self.s_unitrigger.var_92ac68d0);
}

/*
	Name: function_fdbf869e
	Namespace: namespace_3e3742fd
	Checksum: 0x912DDF78
	Offset: 0x5368
	Size: 0x1A2
	Parameters: 1
	Flags: Linked
*/
function function_fdbf869e(n_index)
{
	switch(n_index)
	{
		case 1:
		{
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_4b190e1b731a42d4", 0, 0);
			break;
		}
		case 2:
		{
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_714240e466da2ff", 0, 0);
			break;
		}
		case 3:
		{
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_6ef7226143f9fe18", 0, 0);
			break;
		}
		case 4:
		{
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_111f9f606fee5723", 0, 0);
			break;
		}
		case 5:
		{
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_6d145a499889855b", 0, 0);
			break;
		}
		case 6:
		{
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_5ac4b2461fbcdf67", 0, 0);
			break;
		}
	}
}

/*
	Name: function_65bedb47
	Namespace: namespace_3e3742fd
	Checksum: 0x5409299B
	Offset: 0x5518
	Size: 0x124
	Parameters: 1
	Flags: None
*/
function function_65bedb47(object)
{
	v_origin = object.origin;
	if(isdefined(object.var_eb397f67))
	{
		v_origin = object.var_eb397f67;
	}
	v_delta = vectornormalize(self geteye() - v_origin);
	v_view = anglestoforward(self getplayerangles());
	v_cross = vectorcross(v_view, v_delta);
	var_35b81369 = vectordot(v_cross, anglestoup(object.angles));
	if(var_35b81369 >= 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_643d9747
	Namespace: namespace_3e3742fd
	Checksum: 0x9397C56C
	Offset: 0x5648
	Size: 0x3DC
	Parameters: 0
	Flags: Linked
*/
function function_643d9747()
{
	level namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d("vox_s1_incorrect", 0, 0);
	level flag::clear(#"hash_58b6a09577af5b6d");
	level flag::clear(#"hash_21cd4d3c0f4e8b3");
	level flag::clear(#"hash_21cd3d3c0f4e700");
	level flag::clear(#"hash_21cd6d3c0f4ec19");
	level flag::clear(#"hash_21cd5d3c0f4ea66");
	level flag::clear(#"hash_21cd8d3c0f4ef7f");
	level notify(#"hash_10a56459715cd20e");
	level.var_eac33019 function_2b5d562e("static");
	foreach(var_6be675b7 in level.var_7c64053d)
	{
		var_ee7af3b = var_6be675b7.s_unitrigger.var_ab28dca - randomintrange(1, 11);
		if(level.players.size == 1)
		{
			var_ee7af3b = var_6be675b7.s_unitrigger.var_ab28dca - randomintrange(1, 3);
		}
		if(var_ee7af3b < 0)
		{
			var_ee7af3b = var_ee7af3b + 12;
		}
		while(var_ee7af3b == var_6be675b7.s_unitrigger.var_ab28dca)
		{
			var_ee7af3b = randomintrange(0, 11);
		}
		var_6f927674 = randomintrange(0, 3) * 15;
		var_6be675b7.s_unitrigger.var_3e8690ab namespace_3be0b7ad::function_9b62d333(var_ee7af3b, var_6f927674);
		var_6be675b7.s_unitrigger.n_hour = var_ee7af3b;
		var_6be675b7.s_unitrigger.n_minute = var_6f927674;
		var_6be675b7.s_unitrigger.var_9c74d1b8 = 0;
		var_6be675b7.s_unitrigger.is_rotating = 0;
		var_6be675b7 thread function_2193794();
	}
	var_d1ec2571 = namespace_a28acff3::get_round_number() + 1;
	while(namespace_a28acff3::get_round_number() < var_d1ec2571 && (!(isdefined(level.intermission) && level.intermission)))
	{
		wait(1);
	}
	level flag::set(#"hash_58b6a09577af5b6d");
	level.var_eac33019 function_2b5d562e("standby");
}

/*
	Name: function_967cd489
	Namespace: namespace_3e3742fd
	Checksum: 0xC0D58256
	Offset: 0x5A30
	Size: 0x1F42
	Parameters: 0
	Flags: Linked
*/
function function_967cd489()
{
	level.var_92d8ea2e = [];
	var_31d8f64c = function_21a3a673(1, 4);
	var_90959fc6 = getentarray("alert_me", "targetname");
	for(i = 0; i < var_90959fc6.size; i++)
	{
		if(var_90959fc6[i].script_int == var_31d8f64c)
		{
			level.var_eac33019 = var_90959fc6[i];
			level.var_eac33019 function_2b5d562e("off");
			level.var_eac33019.is_active = 0;
			level.var_eac33019.registerfullybreadcrumbs = 0;
			level.var_eac33019.name = "ncom";
			level.var_eac33019.isspeaking = 0;
			level.var_eac33019.var_5b6ebfd0 = 0;
			continue;
		}
		var_90959fc6[i] delete();
	}
	var_b59d25d3 = function_21a3a673(1, 8);
	while(var_b59d25d3 == 6 || var_b59d25d3 == 7)
	{
		var_b59d25d3 = function_21a3a673(1, 8);
	}
	switch(var_b59d25d3)
	{
		case 1:
		{
			level.var_a2f93b78 = "one";
			level.var_92d8ea2e[0] = spawnstruct();
			level.var_92d8ea2e[0].n_position = 1;
			level.var_92d8ea2e[0].n_hour = 2;
			level.var_92d8ea2e[0].n_minute = 45;
			level.var_92d8ea2e[0].is_selected = 1;
			level.var_92d8ea2e[1] = spawnstruct();
			level.var_92d8ea2e[1].n_position = 3;
			level.var_92d8ea2e[1].n_hour = 10;
			level.var_92d8ea2e[1].n_minute = 15;
			level.var_92d8ea2e[1].is_selected = 1;
			level.var_92d8ea2e[2] = spawnstruct();
			level.var_92d8ea2e[2].n_position = 2;
			level.var_92d8ea2e[2].n_hour = 0;
			level.var_92d8ea2e[2].n_minute = 0;
			level.var_92d8ea2e[2].is_selected = 1;
			level.var_92d8ea2e[3] = spawnstruct();
			level.var_92d8ea2e[3].n_position = 4;
			level.var_92d8ea2e[3].n_hour = 9;
			level.var_92d8ea2e[3].n_minute = 0;
			level.var_92d8ea2e[3].is_selected = 1;
			level.var_92d8ea2e[4] = spawnstruct();
			level.var_92d8ea2e[4].n_position = 0;
			level.var_92d8ea2e[4].n_hour = 2;
			level.var_92d8ea2e[4].n_minute = 15;
			level.var_92d8ea2e[4].is_selected = 1;
			level.var_92d8ea2e[5] = spawnstruct();
			level.var_92d8ea2e[5].n_position = 4;
			level.var_92d8ea2e[5].n_hour = 13;
			level.var_92d8ea2e[5].n_minute = 15;
			level.var_92d8ea2e[5].is_selected = 0;
			break;
		}
		case 2:
		{
			level.var_a2f93b78 = "two";
			level.var_92d8ea2e[0] = spawnstruct();
			level.var_92d8ea2e[0].n_position = 2;
			level.var_92d8ea2e[0].n_hour = 0;
			level.var_92d8ea2e[0].n_minute = 0;
			level.var_92d8ea2e[0].is_selected = 1;
			level.var_92d8ea2e[1] = spawnstruct();
			level.var_92d8ea2e[1].n_position = 4;
			level.var_92d8ea2e[1].n_hour = 3;
			level.var_92d8ea2e[1].n_minute = 0;
			level.var_92d8ea2e[1].is_selected = 1;
			level.var_92d8ea2e[2] = spawnstruct();
			level.var_92d8ea2e[2].n_position = 0;
			level.var_92d8ea2e[2].n_hour = 6;
			level.var_92d8ea2e[2].n_minute = 45;
			level.var_92d8ea2e[2].is_selected = 1;
			level.var_92d8ea2e[3] = spawnstruct();
			level.var_92d8ea2e[3].n_position = 1;
			level.var_92d8ea2e[3].n_hour = 5;
			level.var_92d8ea2e[3].n_minute = 15;
			level.var_92d8ea2e[3].is_selected = 1;
			level.var_92d8ea2e[4] = spawnstruct();
			level.var_92d8ea2e[4].n_position = 0;
			level.var_92d8ea2e[4].n_hour = 13;
			level.var_92d8ea2e[4].n_minute = 15;
			level.var_92d8ea2e[4].is_selected = 0;
			level.var_92d8ea2e[5] = spawnstruct();
			level.var_92d8ea2e[5].n_position = 3;
			level.var_92d8ea2e[5].n_hour = 8;
			level.var_92d8ea2e[5].n_minute = 30;
			level.var_92d8ea2e[5].is_selected = 1;
			break;
		}
		case 3:
		{
			level.var_a2f93b78 = "three";
			level.var_92d8ea2e[0] = spawnstruct();
			level.var_92d8ea2e[0].n_position = 3;
			level.var_92d8ea2e[0].n_hour = 2;
			level.var_92d8ea2e[0].n_minute = 30;
			level.var_92d8ea2e[0].is_selected = 1;
			level.var_92d8ea2e[1] = spawnstruct();
			level.var_92d8ea2e[1].n_position = 3;
			level.var_92d8ea2e[1].n_hour = 13;
			level.var_92d8ea2e[1].n_minute = 15;
			level.var_92d8ea2e[1].is_selected = 0;
			level.var_92d8ea2e[2] = spawnstruct();
			level.var_92d8ea2e[2].n_position = 1;
			level.var_92d8ea2e[2].n_hour = 6;
			level.var_92d8ea2e[2].n_minute = 15;
			level.var_92d8ea2e[2].is_selected = 1;
			level.var_92d8ea2e[3] = spawnstruct();
			level.var_92d8ea2e[3].n_position = 0;
			level.var_92d8ea2e[3].n_hour = 7;
			level.var_92d8ea2e[3].n_minute = 45;
			level.var_92d8ea2e[3].is_selected = 1;
			level.var_92d8ea2e[4] = spawnstruct();
			level.var_92d8ea2e[4].n_position = 4;
			level.var_92d8ea2e[4].n_hour = 3;
			level.var_92d8ea2e[4].n_minute = 0;
			level.var_92d8ea2e[4].is_selected = 1;
			level.var_92d8ea2e[5] = spawnstruct();
			level.var_92d8ea2e[5].n_position = 2;
			level.var_92d8ea2e[5].n_hour = 1;
			level.var_92d8ea2e[5].n_minute = 15;
			level.var_92d8ea2e[5].is_selected = 1;
			break;
		}
		case 4:
		{
			level.var_a2f93b78 = "four";
			level.var_92d8ea2e[0] = spawnstruct();
			level.var_92d8ea2e[0].n_position = 0;
			level.var_92d8ea2e[0].n_hour = 11;
			level.var_92d8ea2e[0].n_minute = 0;
			level.var_92d8ea2e[0].is_selected = 1;
			level.var_92d8ea2e[1] = spawnstruct();
			level.var_92d8ea2e[1].n_position = 3;
			level.var_92d8ea2e[1].n_hour = 13;
			level.var_92d8ea2e[1].n_minute = 15;
			level.var_92d8ea2e[1].is_selected = 0;
			level.var_92d8ea2e[2] = spawnstruct();
			level.var_92d8ea2e[2].n_position = 4;
			level.var_92d8ea2e[2].n_hour = 4;
			level.var_92d8ea2e[2].n_minute = 0;
			level.var_92d8ea2e[2].is_selected = 1;
			level.var_92d8ea2e[3] = spawnstruct();
			level.var_92d8ea2e[3].n_position = 2;
			level.var_92d8ea2e[3].n_hour = 3;
			level.var_92d8ea2e[3].n_minute = 45;
			level.var_92d8ea2e[3].is_selected = 1;
			level.var_92d8ea2e[4] = spawnstruct();
			level.var_92d8ea2e[4].n_position = 3;
			level.var_92d8ea2e[4].n_hour = 9;
			level.var_92d8ea2e[4].n_minute = 45;
			level.var_92d8ea2e[4].is_selected = 1;
			level.var_92d8ea2e[5] = spawnstruct();
			level.var_92d8ea2e[5].n_position = 1;
			level.var_92d8ea2e[5].n_hour = 5;
			level.var_92d8ea2e[5].n_minute = 30;
			level.var_92d8ea2e[5].is_selected = 1;
			break;
		}
		case 5:
		{
			level.var_a2f93b78 = "five";
			level.var_92d8ea2e[0] = spawnstruct();
			level.var_92d8ea2e[0].n_position = 1;
			level.var_92d8ea2e[0].n_hour = 13;
			level.var_92d8ea2e[0].n_minute = 45;
			level.var_92d8ea2e[0].is_selected = 0;
			level.var_92d8ea2e[1] = spawnstruct();
			level.var_92d8ea2e[1].n_position = 4;
			level.var_92d8ea2e[1].n_hour = 4;
			level.var_92d8ea2e[1].n_minute = 45;
			level.var_92d8ea2e[1].is_selected = 1;
			level.var_92d8ea2e[2] = spawnstruct();
			level.var_92d8ea2e[2].n_position = 1;
			level.var_92d8ea2e[2].n_hour = 10;
			level.var_92d8ea2e[2].n_minute = 15;
			level.var_92d8ea2e[2].is_selected = 1;
			level.var_92d8ea2e[3] = spawnstruct();
			level.var_92d8ea2e[3].n_position = 2;
			level.var_92d8ea2e[3].n_hour = 8;
			level.var_92d8ea2e[3].n_minute = 15;
			level.var_92d8ea2e[3].is_selected = 1;
			level.var_92d8ea2e[4] = spawnstruct();
			level.var_92d8ea2e[4].n_position = 3;
			level.var_92d8ea2e[4].n_hour = 11;
			level.var_92d8ea2e[4].n_minute = 30;
			level.var_92d8ea2e[4].is_selected = 1;
			level.var_92d8ea2e[5] = spawnstruct();
			level.var_92d8ea2e[5].n_position = 0;
			level.var_92d8ea2e[5].n_hour = 9;
			level.var_92d8ea2e[5].n_minute = 30;
			level.var_92d8ea2e[5].is_selected = 1;
			break;
		}
		case 6:
		{
			level.var_a2f93b78 = "six";
			level.var_92d8ea2e[0] = spawnstruct();
			level.var_92d8ea2e[0].n_position = 4;
			level.var_92d8ea2e[0].n_hour = 7;
			level.var_92d8ea2e[0].n_minute = 0;
			level.var_92d8ea2e[0].is_selected = 1;
			level.var_92d8ea2e[1] = spawnstruct();
			level.var_92d8ea2e[1].n_position = 3;
			level.var_92d8ea2e[1].n_hour = 9;
			level.var_92d8ea2e[1].n_minute = 45;
			level.var_92d8ea2e[1].is_selected = 1;
			level.var_92d8ea2e[2] = spawnstruct();
			level.var_92d8ea2e[2].n_position = 0;
			level.var_92d8ea2e[2].n_hour = 0;
			level.var_92d8ea2e[2].n_minute = 30;
			level.var_92d8ea2e[2].is_selected = 1;
			level.var_92d8ea2e[3] = spawnstruct();
			level.var_92d8ea2e[3].n_position = 4;
			level.var_92d8ea2e[3].n_hour = 13;
			level.var_92d8ea2e[3].n_minute = 0;
			level.var_92d8ea2e[3].is_selected = 0;
			level.var_92d8ea2e[4] = spawnstruct();
			level.var_92d8ea2e[4].n_position = 2;
			level.var_92d8ea2e[4].n_hour = 7;
			level.var_92d8ea2e[4].n_minute = 0;
			level.var_92d8ea2e[4].is_selected = 1;
			level.var_92d8ea2e[5] = spawnstruct();
			level.var_92d8ea2e[5].n_position = 1;
			level.var_92d8ea2e[5].n_hour = 8;
			level.var_92d8ea2e[5].n_minute = 15;
			level.var_92d8ea2e[5].is_selected = 1;
			break;
		}
		case 7:
		{
			level.var_a2f93b78 = "seven";
			level.var_92d8ea2e[0] = spawnstruct();
			level.var_92d8ea2e[0].n_position = 4;
			level.var_92d8ea2e[0].n_hour = 5;
			level.var_92d8ea2e[0].n_minute = 30;
			level.var_92d8ea2e[0].is_selected = 1;
			level.var_92d8ea2e[1] = spawnstruct();
			level.var_92d8ea2e[1].n_position = 2;
			level.var_92d8ea2e[1].n_hour = 1;
			level.var_92d8ea2e[1].n_minute = 45;
			level.var_92d8ea2e[1].is_selected = 1;
			level.var_92d8ea2e[2] = spawnstruct();
			level.var_92d8ea2e[2].n_position = 2;
			level.var_92d8ea2e[2].n_hour = 13;
			level.var_92d8ea2e[2].n_minute = 0;
			level.var_92d8ea2e[2].is_selected = 0;
			level.var_92d8ea2e[3] = spawnstruct();
			level.var_92d8ea2e[3].n_position = 3;
			level.var_92d8ea2e[3].n_hour = 1;
			level.var_92d8ea2e[3].n_minute = 30;
			level.var_92d8ea2e[3].is_selected = 1;
			level.var_92d8ea2e[4] = spawnstruct();
			level.var_92d8ea2e[4].n_position = 1;
			level.var_92d8ea2e[4].n_hour = 4;
			level.var_92d8ea2e[4].n_minute = 15;
			level.var_92d8ea2e[4].is_selected = 1;
			level.var_92d8ea2e[5] = spawnstruct();
			level.var_92d8ea2e[5].n_position = 0;
			level.var_92d8ea2e[5].n_hour = 7;
			level.var_92d8ea2e[5].n_minute = 30;
			level.var_92d8ea2e[5].is_selected = 1;
			break;
		}
		case 8:
		{
			level.var_a2f93b78 = "eight";
			level.var_92d8ea2e[0] = spawnstruct();
			level.var_92d8ea2e[0].n_position = 1;
			level.var_92d8ea2e[0].n_hour = 13;
			level.var_92d8ea2e[0].n_minute = 45;
			level.var_92d8ea2e[0].is_selected = 0;
			level.var_92d8ea2e[1] = spawnstruct();
			level.var_92d8ea2e[1].n_position = 1;
			level.var_92d8ea2e[1].n_hour = 6;
			level.var_92d8ea2e[1].n_minute = 0;
			level.var_92d8ea2e[1].is_selected = 1;
			level.var_92d8ea2e[2] = spawnstruct();
			level.var_92d8ea2e[2].n_position = 4;
			level.var_92d8ea2e[2].n_hour = 0;
			level.var_92d8ea2e[2].n_minute = 15;
			level.var_92d8ea2e[2].is_selected = 1;
			level.var_92d8ea2e[3] = spawnstruct();
			level.var_92d8ea2e[3].n_position = 3;
			level.var_92d8ea2e[3].n_hour = 8;
			level.var_92d8ea2e[3].n_minute = 30;
			level.var_92d8ea2e[3].is_selected = 1;
			level.var_92d8ea2e[4] = spawnstruct();
			level.var_92d8ea2e[4].n_position = 0;
			level.var_92d8ea2e[4].n_hour = 10;
			level.var_92d8ea2e[4].n_minute = 45;
			level.var_92d8ea2e[4].is_selected = 1;
			level.var_92d8ea2e[5] = spawnstruct();
			level.var_92d8ea2e[5].n_position = 2;
			level.var_92d8ea2e[5].n_hour = 11;
			level.var_92d8ea2e[5].n_minute = 45;
			level.var_92d8ea2e[5].is_selected = 1;
			break;
		}
	}
}

/*
	Name: function_704b8e
	Namespace: namespace_3e3742fd
	Checksum: 0xA16C383E
	Offset: 0x7980
	Size: 0x2EA
	Parameters: 0
	Flags: Linked
*/
function function_704b8e()
{
	var_92ac68d0 = 0;
	for(i = 0; i < level.var_92d8ea2e.size; i++)
	{
		if(level.var_92d8ea2e[i].is_selected === 0)
		{
			var_92ac68d0 = i;
		}
	}
	n_hour = randomintrange(1, 12);
	n_minute = function_21a3a673(0, 3) * 15;
	if(n_hour == level.var_92d8ea2e[var_92ac68d0].n_hour)
	{
		if(n_hour == 1)
		{
			n_hour = 12;
		}
		else
		{
			n_hour = n_hour - 1;
		}
	}
	var_90f307ff = n_hour * 100 + n_minute;
	while(isdefined(level.var_f13364b4.var_132bd718[var_90f307ff]))
	{
		n_hour = randomintrange(1, 12);
		n_minute = randomintrange(0, 3) * 15;
		if(n_hour == level.var_92d8ea2e[var_92ac68d0].n_hour)
		{
			if(n_hour == 1)
			{
				n_hour = 12;
			}
			else
			{
				n_hour = n_hour - 1;
			}
		}
		var_90f307ff = n_hour * 100 + n_minute;
	}
	level.var_f13364b4.var_132bd718[var_90f307ff] = {#hash_d9d9d617:&function_5d874e07, #hash_544c05c6:1};
	if(!isdefined(level.var_d7e5aaac))
	{
		level.var_d7e5aaac = [];
	}
	else if(!isarray(level.var_d7e5aaac))
	{
		level.var_d7e5aaac = array(level.var_d7e5aaac);
	}
	level.var_d7e5aaac[level.var_d7e5aaac.size] = var_90f307ff;
	a_return = [];
	a_return[#"hour"] = n_hour;
	a_return[#"minute"] = n_minute;
	level.var_ebf9cb51 = a_return;
}

/*
	Name: function_5d874e07
	Namespace: namespace_3e3742fd
	Checksum: 0x476284A5
	Offset: 0x7C78
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_5d874e07()
{
	level namespace_9cf755b::function_ec34b5ee(#"hash_fda2abccee87985");
	level flag::set(#"hash_63d6d5191ca09cae");
}

/*
	Name: function_7cd1bff1
	Namespace: namespace_3e3742fd
	Checksum: 0x4400ACEE
	Offset: 0x7CC8
	Size: 0x156
	Parameters: 0
	Flags: Linked
*/
function function_7cd1bff1()
{
	level endon(#"hash_63d6d5191ca09cae");
	while(true)
	{
		s_activation = undefined;
		s_activation = self waittill(#"trigger_activated");
		e_who = s_activation.e_who;
		if(level.var_eac33019.is_active === 0 && level flag::get(#"hash_58b6a09577af5b6d"))
		{
			level.var_eac33019.is_active = 1;
			level.var_eac33019 function_2b5d562e("standby");
			wait(0.5);
			if(!level flag::get(#"hash_58b6a09577af5b6d"))
			{
				level flag::set(#"hash_58b6a09577af5b6d");
			}
			level function_892b6616();
			wait(2);
			if(isdefined(level.var_eac33019))
			{
				level.var_eac33019.is_active = 0;
			}
		}
	}
}

/*
	Name: function_950562c0
	Namespace: namespace_3e3742fd
	Checksum: 0x972586F6
	Offset: 0x7E28
	Size: 0x234
	Parameters: 1
	Flags: Linked
*/
function function_950562c0(s_params)
{
	if(isplayer(s_params.eattacker) && level flag::get(#"hash_13e9bb1de846d022") && !level flag::get(#"hash_63d6d5191ca09cae"))
	{
		n_distance = distance(self.origin, level.var_eac33019.origin);
		if(n_distance < 128 && s_params.weapon.name == #"galvaknuckles_t8" && level.var_eac33019.is_active === 0)
		{
			if(level.var_eac33019.registerfullybreadcrumbs === 0)
			{
				level.var_eac33019.is_active = 1;
				level.var_eac33019 function_2b5d562e("standby");
				wait(0.5);
				level function_892b6616();
				wait(2);
				if(isdefined(level.var_eac33019))
				{
					level.var_eac33019.is_active = 0;
				}
				var_c0749244 = struct::get(level.var_eac33019.target, "targetname");
				var_c0749244 zm_unitrigger::create(&function_c3a3c077, 96);
				var_c0749244 thread function_7cd1bff1();
				level.var_eac33019.registerfullybreadcrumbs = 1;
				level flag::set(#"hash_58b6a09577af5b6d");
			}
		}
	}
}

/*
	Name: function_892b6616
	Namespace: namespace_3e3742fd
	Checksum: 0x97F7DADC
	Offset: 0x8068
	Size: 0x32E
	Parameters: 0
	Flags: Linked
*/
function function_892b6616()
{
	level endon(#"hash_63d6d5191ca09cae");
	a_codes = [];
	for(i = 0; i < 6; i++)
	{
		if(level.var_92d8ea2e[i].is_selected === 1)
		{
			var_2760389a = "";
			switch(i)
			{
				case 0:
				{
					var_2760389a = var_2760389a + "A - ";
					break;
				}
				case 1:
				{
					var_2760389a = var_2760389a + "B - ";
					break;
				}
				case 2:
				{
					var_2760389a = var_2760389a + "C - ";
					break;
				}
				case 3:
				{
					var_2760389a = var_2760389a + "D - ";
					break;
				}
				case 4:
				{
					var_2760389a = var_2760389a + "E - ";
					break;
				}
				case 5:
				{
					var_2760389a = var_2760389a + "F - ";
					break;
				}
			}
			if(level.var_92d8ea2e[i].n_hour == 0)
			{
				var_2760389a = var_2760389a + "12";
			}
			else if(level.var_92d8ea2e[i].n_hour < 10)
			{
				var_2760389a = var_2760389a + "0";
			}
			var_2760389a = var_2760389a + level.var_92d8ea2e[i].n_hour;
			if(level.var_92d8ea2e[i].n_minute < 10)
			{
				var_2760389a = var_2760389a + "0";
			}
			var_2760389a = var_2760389a + level.var_92d8ea2e[i].n_minute;
			a_codes[level.var_92d8ea2e[i].n_position] = var_2760389a;
		}
	}
	str_vo_alias = "vox_code_" + level.var_a2f93b78;
	for(i = 0; i < a_codes.size; i++)
	{
		/#
			debug2dtext((360, 135 + 40 * i, 0), a_codes[i], (1, 1, 0), 1, (0, 0, 0), 0.5, 2, 1000);
		#/
		level namespace_509a75d1::function_3c173d37();
		level.var_eac33019 namespace_509a75d1::function_6a0d675d(str_vo_alias, i, 0);
	}
}

/*
	Name: function_5a971787
	Namespace: namespace_3e3742fd
	Checksum: 0x4C42B468
	Offset: 0x83A0
	Size: 0xF8
	Parameters: 1
	Flags: Linked
*/
function function_5a971787(e_player)
{
	if(level flag::get(#"hash_58b6a09577af5b6d"))
	{
		/#
			if(level flag::get("") && self.stub.is_selected == 1)
			{
				debug2dtext((720, 135, 0), "" + self.stub.n_position + "" + self.stub.var_ab28dca + "" + self.stub.var_af1cfded, (1, 1, 0), 1, (0, 0, 0), 0.5, 1, 50);
			}
		#/
		return 1;
	}
	return 0;
}

/*
	Name: function_7d2b51d5
	Namespace: namespace_3e3742fd
	Checksum: 0x5622F4E3
	Offset: 0x84A8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_7d2b51d5(n_number)
{
	self hidepart("tag_all_screens", self, 1);
	self showpart("tag_number_" + n_number);
}

/*
	Name: function_2b5d562e
	Namespace: namespace_3e3742fd
	Checksum: 0x96CD872E
	Offset: 0x8500
	Size: 0xF2
	Parameters: 1
	Flags: Linked
*/
function function_2b5d562e(var_1bfeafad)
{
	self hidepart("tag_all_screens", "p8_zm_whi_freestanding_1960_tv_screen_vfx", 1);
	switch(var_1bfeafad)
	{
		case "off":
		{
			self stoploopsound();
			break;
		}
		case "static":
		{
			self showpart("tag_static");
			self playloopsound(#"hash_10527c78b7bb294a");
			break;
		}
		case "standby":
		{
			self showpart("tag_standby");
			break;
		}
	}
}

/*
	Name: function_2b1ff821
	Namespace: namespace_3e3742fd
	Checksum: 0xDEADCDC5
	Offset: 0x8600
	Size: 0x2E4
	Parameters: 1
	Flags: Linked
*/
function function_2b1ff821(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_cae70bde();
		level thread function_e3642d44();
		level flag::wait_till(#"mq_computer_activated");
		level namespace_509a75d1::function_314447b(1, 0);
		if(isdefined(level.var_18f1ca6e))
		{
			level.var_18f1ca6e playsound(#"hash_656964552426f55");
			level.var_18f1ca6e playloopsound(#"hash_3ed99d3b2e3e929f");
		}
		wait(11);
		level namespace_509a75d1::function_3c173d37();
		level.var_fa22c7ec namespace_509a75d1::function_51b752a9("vox_operations_intro", 0, 0);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_operations_intro", 1, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_operations_intro", 2, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		level.var_fa22c7ec namespace_509a75d1::function_51b752a9("vox_operations_intro", 3, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_operations_intro", 4, 0, 1);
		level namespace_509a75d1::function_314447b(0);
		namespace_6747c550::function_7df6bb60(#"hash_24d1f7403563d66f", 1);
		level flag::set(#"hash_13e9bb1de846d022");
		level.var_eac33019 function_2b5d562e("static");
		level flag::wait_till(#"hash_63d6d5191ca09cae");
	}
}

/*
	Name: function_40f35ada
	Namespace: namespace_3e3742fd
	Checksum: 0xB983F9C8
	Offset: 0x88F0
	Size: 0x214
	Parameters: 2
	Flags: Linked
*/
function function_40f35ada(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_63d6d5191ca09cae");
		level flag::set(#"hash_25d9caebd2bde973");
		level flag::set(#"hash_25d9cbebd2bdeb26");
		level flag::set(#"hash_25d9ccebd2bdecd9");
		level flag::set(#"hash_25d9cdebd2bdee8c");
		level flag::set(#"enable_countermeasure_5");
		level flag::set(#"hash_25d9cfebd2bdf1f2");
	}
	else if(!var_5ea5c94d)
	{
		var_d1bcd44b = level.var_f13364b4.var_12633dc5;
		if(!isdefined(var_d1bcd44b))
		{
			var_d1bcd44b = namespace_509a75d1::function_3815943c();
		}
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s1_prove", 0, 0);
		level namespace_509a75d1::function_3c173d37();
		var_d1bcd44b namespace_509a75d1::function_51b752a9("vox_s1_prove", 1, 0);
	}
	if(isdefined(level.var_eac33019))
	{
		level.var_eac33019 delete();
	}
	callback::remove_on_ai_killed(&function_950562c0);
}

/*
	Name: function_e3642d44
	Namespace: namespace_3e3742fd
	Checksum: 0x50D1DA0F
	Offset: 0x8B10
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_e3642d44()
{
	level endon(#"end_game", #"mq_computer_activated", #"hash_63d6d5191ca09cae");
	level.var_5dd0d3ff thread namespace_509a75d1::function_6a0d675d(#"hash_561c4b05a7df08b1", 0, 1);
	level.var_18f1ca6e thread namespace_7d8e6ec3::function_6ef53601("dynamic");
	wait(180);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_273bd180af5b9dc0", 0, 1);
	wait(180);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_273bd180af5b9dc0", 1, 1);
}

/*
	Name: function_43cc6c97
	Namespace: namespace_3e3742fd
	Checksum: 0x5912629
	Offset: 0x8C18
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function function_43cc6c97(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_cae70bde();
		level flag::wait_till(#"mq_computer_activated");
		level namespace_509a75d1::function_314447b(1, 0);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_289bd1667a73d037", 0, 0);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s2_locate", 0, 0, 1);
		namespace_6747c550::function_7df6bb60(#"hash_24d1f7403563d66f", 2);
		level namespace_509a75d1::function_314447b(0);
		level flag::set(#"hash_10b7ed627014a952");
		level namespace_ee206246::start(#"hash_26a9aef6e9be5b86");
		level namespace_509a75d1::function_3c173d37();
		level.var_fa22c7ec namespace_509a75d1::function_51b752a9("vox_s2_locate", 1, 0, 1);
		level flag::wait_till(#"crawler_step_complete");
	}
}

/*
	Name: function_4924cb9a
	Namespace: namespace_3e3742fd
	Checksum: 0x7D014C22
	Offset: 0x8E00
	Size: 0x144
	Parameters: 2
	Flags: Linked
*/
function function_4924cb9a(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set("crawler_step_complete");
		namespace_7d8e6ec3::function_a3442c46("1");
	}
	else if(!var_5ea5c94d)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_3902d1add39dd516", 0, 0);
		namespace_7d8e6ec3::function_a3442c46("1");
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s2_return", 0, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		namespace_509a75d1::function_fd24e47f("vox_s2_return", 1, 0, 1);
	}
}

/*
	Name: function_150faad9
	Namespace: namespace_3e3742fd
	Checksum: 0x3D4E182D
	Offset: 0x8F50
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function function_150faad9(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_cae70bde();
		level flag::wait_till(#"mq_computer_activated");
		level namespace_509a75d1::function_314447b(1, 0);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_ec098e4d41b788c", 0, 0, 1);
		namespace_6747c550::function_7df6bb60(#"hash_24d1f7403563d66f", 3);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s3_locate", 0, 0, 1);
		level namespace_509a75d1::function_314447b(0);
		level flag::set(#"hash_485ced30125950ac");
		level namespace_ee206246::start(#"hash_75f9f80c2256f3d3");
		level namespace_509a75d1::function_3c173d37();
		level.var_fa22c7ec namespace_509a75d1::function_51b752a9("vox_s3_locate", 1, 0, 1);
		level flag::wait_till(#"hash_6a79293e26344b0f");
	}
}

/*
	Name: function_68d29adf
	Namespace: namespace_3e3742fd
	Checksum: 0xD115E38A
	Offset: 0x9138
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function function_68d29adf(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_6a79293e26344b0f");
		namespace_7d8e6ec3::function_a3442c46("2");
	}
	else if(!var_5ea5c94d)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s3_return", 0, 0, 1);
		namespace_7d8e6ec3::function_a3442c46("2");
		level namespace_509a75d1::function_3c173d37();
		namespace_509a75d1::function_fd24e47f("vox_s3_return", 1, 0, 1);
	}
}

/*
	Name: function_cb313a15
	Namespace: namespace_3e3742fd
	Checksum: 0x4A98BDDB
	Offset: 0x9240
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function function_cb313a15(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_cae70bde();
		level flag::wait_till(#"mq_computer_activated");
		level namespace_509a75d1::function_314447b(1, 0);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_113535bfb3c2e45", 0, 0, 1);
		namespace_6747c550::function_7df6bb60(#"hash_24d1f7403563d66f", 4);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s4_locate", 0, 0, 1);
		level namespace_509a75d1::function_314447b(0);
		level flag::set(#"hash_2a7f2737e415ffd1");
		level namespace_ee206246::start(#"hash_ab36ea0a749269d");
		level namespace_509a75d1::function_3c173d37();
		level.var_fa22c7ec namespace_509a75d1::function_51b752a9("vox_s4_locate", 1, 0, 1);
		level flag::wait_till(#"hash_2f57ff102a73c0b5");
	}
}

/*
	Name: function_89ec3a1c
	Namespace: namespace_3e3742fd
	Checksum: 0xC60523A2
	Offset: 0x9428
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function function_89ec3a1c(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_2f57ff102a73c0b5");
		namespace_7d8e6ec3::function_a3442c46("3");
	}
	else if(!var_5ea5c94d)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_8eec03f629e2fbe", 0, 0);
		namespace_7d8e6ec3::function_a3442c46("3");
		level namespace_509a75d1::function_3c173d37();
		namespace_509a75d1::function_fd24e47f("vox_s4_success", 1, 0);
	}
}

/*
	Name: function_5446e4c0
	Namespace: namespace_3e3742fd
	Checksum: 0x56D48540
	Offset: 0x9530
	Size: 0x214
	Parameters: 1
	Flags: Linked
*/
function function_5446e4c0(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_cae70bde();
		level flag::wait_till(#"mq_computer_activated");
		level namespace_509a75d1::function_314447b(1, 0);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff thread namespace_509a75d1::function_6a0d675d(#"hash_451311782055a392", 0, 0);
		wait(12.75);
		level.var_8200dc81 thread namespace_509a75d1::function_6a0d675d(#"vox_s5_shutdown", 0, 0, 1);
		wait(3.5);
		level.var_5dd0d3ff thread namespace_509a75d1::function_6a0d675d(#"vox_s5_shutdown", 1, 0, 1);
		wait(12.4);
		namespace_6747c550::function_7df6bb60(#"hash_24d1f7403563d66f", 5);
		level namespace_509a75d1::function_314447b(0);
		level flag::set(#"hash_2a7f2737e415ffd1");
		level namespace_ee206246::start(#"hash_19d484735f237f45");
		wait(1.5);
		level namespace_509a75d1::function_3c173d37();
		level.var_fa22c7ec namespace_509a75d1::function_51b752a9("vox_s5_shutdown", 2, 0, 1);
		level flag::wait_till(#"circuit_step_complete");
	}
}

/*
	Name: function_c87f079a
	Namespace: namespace_3e3742fd
	Checksum: 0x4669881C
	Offset: 0x9750
	Size: 0x154
	Parameters: 2
	Flags: Linked
*/
function function_c87f079a(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"circuit_step_complete");
		namespace_7d8e6ec3::function_a3442c46("4");
	}
	else if(!var_5ea5c94d)
	{
		wait(2);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_3ac91b4fd37f0b02", 0, 0, 1);
		namespace_7d8e6ec3::function_a3442c46("4");
		level namespace_509a75d1::function_3c173d37();
		wait(0.25);
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s5_end", 0, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		namespace_509a75d1::function_fd24e47f("vox_s5_end", 1, 0, 1);
	}
}

/*
	Name: function_aa0bf75b
	Namespace: namespace_3e3742fd
	Checksum: 0x1C2123DF
	Offset: 0x98B0
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function function_aa0bf75b(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_cae70bde();
		level flag::wait_till(#"mq_computer_activated");
		level namespace_509a75d1::function_314447b(1, 0);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_7df449c60f68f1b3", 0, 0, 1);
		namespace_6747c550::function_7df6bb60(#"hash_24d1f7403563d66f", 6);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_repair", 0, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		level namespace_509a75d1::function_314447b(0);
		level flag::set(#"hash_84e6c8a0b5f7e1e");
		level namespace_ee206246::start(#"hash_8ad205f0a62b56e");
		level.var_fa22c7ec namespace_509a75d1::function_51b752a9("vox_s6_repair", 1, 0, 1);
		level flag::wait_till(#"hash_7e4bffd972b5993a");
	}
}

/*
	Name: function_d12818ba
	Namespace: namespace_3e3742fd
	Checksum: 0x7D223DC9
	Offset: 0x9A98
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_d12818ba(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_3b808ddcae9fea60");
		namespace_7d8e6ec3::function_a3442c46("5");
	}
	else if(!var_5ea5c94d)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_free", 3, 0);
		level namespace_509a75d1::function_314447b(0);
		namespace_7d8e6ec3::function_a3442c46("5");
	}
}

/*
	Name: function_9952862f
	Namespace: namespace_3e3742fd
	Checksum: 0x197DC73B
	Offset: 0x9B80
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_9952862f(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_cae70bde();
		level flag::wait_till(#"mq_computer_activated");
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_end", 0, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		level.var_fa22c7ec namespace_509a75d1::function_51b752a9("vox_s6_end", 1, 0, 1);
		wait(1);
		level flag::set(#"hash_487c2805cd41d547");
		namespace_6747c550::function_7df6bb60(#"hash_24d1f7403563d66f", 7);
		level thread namespace_92cb027a::function_94c0714();
		level flag::wait_till(#"hash_2b7c76b6b0dfc0fd");
	}
}

/*
	Name: function_ad2bd43
	Namespace: namespace_3e3742fd
	Checksum: 0x9F65DD50
	Offset: 0x9CE8
	Size: 0x1E4
	Parameters: 2
	Flags: Linked
*/
function function_ad2bd43(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set("bunker_boss_event");
		zm_zonemgr::enable_zone("zone_bunker_apd");
		var_de1edcdb = struct::get_array("zone_bunker_apd_respawn", "targetname");
		a_e_players = getplayers();
		for(i = 0; i < a_e_players.size; i++)
		{
			a_e_players[i] setorigin(var_de1edcdb[i].origin);
		}
		namespace_92cb027a::apd_lockdown();
		namespace_509a75d1::function_2ba419ee(0);
		level flag::set(#"infinite_round_spawning");
		level flag::clear("world_is_paused");
		s_apd = struct::get("cp_toast_apd", "script_noteworthy");
		namespace_617a54f4::function_2a94055d("sc_toast_apd");
		s_apd namespace_92cb027a::function_8c2bda65(1, 0);
		level flag::set(#"hash_2b7c76b6b0dfc0fd");
	}
}

/*
	Name: function_cce995f2
	Namespace: namespace_3e3742fd
	Checksum: 0x558D9344
	Offset: 0x9ED8
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_cce995f2(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::set(#"boss_fight_started");
		namespace_6747c550::function_7df6bb60(#"hash_24d1f7403563d66f", 7);
		level thread namespace_92cb027a::function_ca3759b1();
		level flag::wait_till(#"boss_fight_complete");
	}
}

/*
	Name: function_6c9fdfa1
	Namespace: namespace_3e3742fd
	Checksum: 0xE2EAF322
	Offset: 0x9F78
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_6c9fdfa1(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		var_1c91a56e = struct::get("apd_door_scene", "targetname");
		var_1c91a56e thread scene::play("open");
		level flag::set(#"boss_fight_complete");
	}
}

/*
	Name: function_584620c3
	Namespace: namespace_3e3742fd
	Checksum: 0xD0655082
	Offset: 0xA010
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function function_584620c3(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::set(#"hash_7432d2728d0f50e8");
		namespace_509a75d1::function_314447b(1, 0);
		namespace_6747c550::function_7df6bb60(#"hash_24d1f7403563d66f", 8);
		level.var_ee92bf8c show();
		level.var_ee92bf8c clientfield::set("fx_shard_glow_clientfield", 1);
		waitframe(1);
		var_1c91a56e = struct::get("apd_door_scene", "targetname");
		var_1c91a56e thread scene::play("open");
		namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_53c2cc547088e4a2", 0, 0, 1);
		level.var_ee92bf8c zm_unitrigger::create(&function_ec299a8d, (72, 72, 128));
		level.var_ee92bf8c thread function_1e136091();
		level flag::wait_till(#"hash_5aa1c9627e8626e0");
		/#
			iprintlnbold("");
		#/
	}
}

/*
	Name: function_aea19bda
	Namespace: namespace_3e3742fd
	Checksum: 0xB7D7AFA1
	Offset: 0xA1F0
	Size: 0x144
	Parameters: 2
	Flags: Linked
*/
function function_aea19bda(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_ee92bf8c clientfield::set("fx_shard_glow_clientfield", 0);
		level.var_ee92bf8c delete();
		if(isdefined(level.var_ee92bf8c.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(level.var_ee92bf8c.s_unitrigger);
		}
		level flag::set(#"hash_5aa1c9627e8626e0");
	}
	else
	{
		level.var_ee92bf8c clientfield::set("fx_shard_glow_clientfield", 0);
		level.var_ee92bf8c delete();
		if(isdefined(level.var_ee92bf8c.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(level.var_ee92bf8c.s_unitrigger);
		}
	}
	play_outro();
}

/*
	Name: function_1e136091
	Namespace: namespace_3e3742fd
	Checksum: 0x23E4E2B6
	Offset: 0xA340
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_1e136091()
{
	level endon(#"end_game");
	self endon(#"death");
	var_be17187b = undefined;
	var_be17187b = self waittill(#"trigger_activated");
	level flag::set(#"hash_5aa1c9627e8626e0");
}

/*
	Name: function_ec299a8d
	Namespace: namespace_3e3742fd
	Checksum: 0xF8ED9D3E
	Offset: 0xA3C0
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_ec299a8d(e_player)
{
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_388479afabb2a89e");
	}
	else
	{
		self sethintstring(#"hash_7df1e511b6a42cda");
	}
	return 1;
}

/*
	Name: play_outro
	Namespace: namespace_3e3742fd
	Checksum: 0xA77403DF
	Offset: 0xA430
	Size: 0x280
	Parameters: 0
	Flags: Linked
*/
function play_outro()
{
	exploder::exploder_stop("fxexp_nuke_event");
	level exploder::stop_exploder("fxexp_script_power_on");
	level exploder::stop_exploder("fxexp_script_power_on_bunker");
	exploder::stop_exploder("fxexp_script_power_on_lgt_exterior");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_green");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_hammond");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_hoggatt");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_obrien");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_red");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_reinsel");
	level.var_1fff8fd2 stoploopsound();
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_shed");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_yellow");
	waitframe(1);
	zm_white::function_4f60590c();
	namespace_5c160465::function_217e3c0f();
	level exploder::stop_exploder("fxexp_power_on");
	level zm_vo::function_3c173d37((0, 0, 0), 2147483647);
	level zm_audio::sndvoxoverride(1);
	level thread lui::play_movie(#"hash_789786bd99942b0e", "fullscreen", 1, 0, 0, #"hash_c210390aecd8cc", 157, 0);
	level waittill(#"movie_done");
	level notify(#"end_game");
}

/*
	Name: function_9a022fbc
	Namespace: namespace_3e3742fd
	Checksum: 0x3633FD29
	Offset: 0xA6B8
	Size: 0x278
	Parameters: 1
	Flags: None
*/
function function_9a022fbc(str_state)
{
	players = getplayers();
	var_7e05b6e9 = [];
	foreach(player in players)
	{
		if(isbot(player) || player issplitscreen())
		{
			array::add(var_7e05b6e9, player);
		}
	}
	foreach(bot in var_7e05b6e9)
	{
		arrayremovevalue(players, bot);
	}
	foreach(player in players)
	{
		lui_menu = lui::function_e810a527("FullScreenBlack");
		if(str_state == "open")
		{
			if(isdefined(lui_menu))
			{
				[[ lui_menu ]]->open(player);
				[[ lui_menu ]]->function_9cd54463(player, 1);
				[[ lui_menu ]]->function_331f9dd(player, 1);
				[[ lui_menu ]]->function_237ff433(player, int(2000));
			}
			continue;
		}
		if(isdefined(lui_menu))
		{
			[[ lui_menu ]]->close(player);
		}
	}
}

/*
	Name: function_3f4e9f0b
	Namespace: namespace_3e3742fd
	Checksum: 0x5258BA88
	Offset: 0xA938
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_3f4e9f0b(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::set(#"hash_7cc3b03eefb11fc");
		level thread function_777fb794();
		level flag::wait_till(#"crawler_step_complete");
	}
}

/*
	Name: function_6b2000cc
	Namespace: namespace_3e3742fd
	Checksum: 0xE328EFB6
	Offset: 0xA9B0
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function function_6b2000cc(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"crawler_step_complete");
	}
	var_b79e2c4e = getnode("wither_jump", "targetname");
	unlinktraversal(var_b79e2c4e);
}

/*
	Name: function_612f03f0
	Namespace: namespace_3e3742fd
	Checksum: 0xC7B21DFA
	Offset: 0xAA40
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_612f03f0()
{
	var_d1ec2571 = namespace_a28acff3::get_round_number();
	while(!level flag::get(#"crawler_step_complete"))
	{
		var_d1ec2571 = var_d1ec2571 + 1;
		if(namespace_c3287616::function_40229072(var_d1ec2571))
		{
			namespace_c3287616::function_43aed0ca(var_d1ec2571, 1);
		}
		while(var_d1ec2571 > namespace_a28acff3::get_round_number())
		{
			wait(1);
		}
	}
}

/*
	Name: function_777fb794
	Namespace: namespace_3e3742fd
	Checksum: 0xA2B59D78
	Offset: 0xAAF8
	Size: 0x4D0
	Parameters: 0
	Flags: Linked
*/
function function_777fb794()
{
	level.var_4d9eeedb = 0;
	level.var_86d0f5e7 = 0;
	var_f4254986 = namespace_a28acff3::get_round_number();
	if(namespace_c3287616::function_40229072(var_f4254986))
	{
		var_f4254986 = var_f4254986 + 1;
		while(namespace_a28acff3::get_round_number() < var_f4254986 && (!(isdefined(level.intermission) && level.intermission)))
		{
			wait(1);
		}
		level waittill(#"zombie_total_set");
	}
	level thread function_612f03f0();
	while(!level flag::get(#"crawler_step_complete"))
	{
		n_zombie_count = level.var_38b15968;
		var_26d4dd52 = floor(randomfloatrange(floor(n_zombie_count / 3), floor(n_zombie_count * 2 / 3)));
		while(level.var_9427911d > var_26d4dd52)
		{
			wait(1);
		}
		var_e3d37a1d = level function_a521b860();
		s_spawn_point = function_a0351130(var_e3d37a1d);
		while(!isdefined(s_spawn_point))
		{
			wait(1);
			s_spawn_point = function_a0351130(var_e3d37a1d);
		}
		var_3270571b = getent("the_wither", "targetname");
		var_3d6c445c = zombie_utility::spawn_zombie(var_3270571b, undefined, s_spawn_point);
		if(isdefined(var_3d6c445c))
		{
			level.var_69d5de93 = level.var_69d5de93 + 1;
			var_3d6c445c.var_7f1f259d = 1;
			var_3d6c445c.var_eb58e513 = 1;
			var_3d6c445c.var_580ff2bd = var_e3d37a1d;
			var_3d6c445c zombie_utility::set_zombie_run_cycle("sprint");
			/#
				iprintlnbold("");
			#/
			var_3d6c445c waittill(#"completed_emerging_into_playable_area");
			var_3d6c445c.ignoreme = 1;
			callback::on_ai_killed(&function_2cacde54);
			var_3d6c445c thread function_4d8087fd();
			var_3d6c445c thread function_9b979e93();
			var_3d6c445c thread function_c349b9ef();
			var_3d6c445c function_bf602089();
			level thread function_c15054f0();
			if(var_3d6c445c.var_74f97d1e)
			{
				/#
					iprintlnbold("");
				#/
				level flag::set(#"crawler_step_complete");
				var_3d6c445c delete();
			}
			else
			{
				var_f4254986 = namespace_a28acff3::get_round_number() + 1;
				level.var_48b5d413 = level.var_48b5d413 + 1;
				level thread function_4acd3e02();
				/#
					iprintlnbold("");
				#/
				while(namespace_a28acff3::get_round_number() < var_f4254986 && (!(isdefined(level.intermission) && level.intermission)))
				{
					wait(1);
				}
				level waittill(#"zombie_total_set");
			}
		}
	}
}

/*
	Name: function_4d8087fd
	Namespace: namespace_3e3742fd
	Checksum: 0xE359BEFE
	Offset: 0xAFD0
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function function_4d8087fd()
{
	self endon(#"death");
	self.var_82167dba = 0;
	while(!self.var_82167dba)
	{
		var_6f868336 = arraysort(level.activeplayers, self.origin, 1, level.activeplayers.size);
		foreach(player in var_6f868336)
		{
			if(!player zm_audio::function_65e5c19a() || (isdefined(level.var_b625a184) && level.var_b625a184))
			{
				continue;
			}
			if(isentity(self))
			{
				if(self sightconetrace(player getplayercamerapos(), player, anglestoforward(player.angles)) > 0.3)
				{
					level thread function_d61d258b();
					self.var_82167dba = 1;
					continue;
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_d61d258b
	Namespace: namespace_3e3742fd
	Checksum: 0x10D598D
	Offset: 0xB178
	Size: 0x2B4
	Parameters: 0
	Flags: Linked
*/
function function_d61d258b()
{
	if(level.var_69d5de93 == 1)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s2_escort", 0, 0);
		level namespace_509a75d1::function_3c173d37();
		namespace_509a75d1::function_fd24e47f("vox_s2_escort", 1, 0);
	}
	else if(level.var_69d5de93 == 2)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_5f0ce86c24ecaee2", 1, 0);
	}
	else
	{
		var_e515445c = [];
		for(i = 0; i < level.var_9778da1.size; i++)
		{
			if(level.var_9778da1[i] === 0)
			{
				if(!isdefined(var_e515445c))
				{
					var_e515445c = [];
				}
				else if(!isarray(var_e515445c))
				{
					var_e515445c = array(var_e515445c);
				}
				var_e515445c[var_e515445c.size] = i;
			}
		}
		if(var_e515445c.size == 0)
		{
			for(i = 0; i < 5; i++)
			{
				if(i != 1)
				{
					level.var_9778da1[i] = 0;
					if(!isdefined(var_e515445c))
					{
						var_e515445c = [];
					}
					else if(!isarray(var_e515445c))
					{
						var_e515445c = array(var_e515445c);
					}
					var_e515445c[var_e515445c.size] = i;
				}
			}
		}
		var_32060833 = array::random(var_e515445c);
		level.var_9778da1[var_32060833] = 1;
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_5f0ce86c24ecaee2", var_32060833, 0);
	}
}

/*
	Name: function_4acd3e02
	Namespace: namespace_3e3742fd
	Checksum: 0x67AABD3F
	Offset: 0xB438
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_4acd3e02()
{
	var_89909ff3 = [];
	for(i = 0; i < level.var_bc88ffc0.size; i++)
	{
		if(level.var_bc88ffc0[i] === 0)
		{
			if(!isdefined(var_89909ff3))
			{
				var_89909ff3 = [];
			}
			else if(!isarray(var_89909ff3))
			{
				var_89909ff3 = array(var_89909ff3);
			}
			var_89909ff3[var_89909ff3.size] = i;
		}
	}
	if(var_89909ff3.size == 0)
	{
		for(i = 0; i < 5; i++)
		{
			level.var_bc88ffc0[i] = 0;
			if(!isdefined(var_89909ff3))
			{
				var_89909ff3 = [];
			}
			else if(!isarray(var_89909ff3))
			{
				var_89909ff3 = array(var_89909ff3);
			}
			var_89909ff3[var_89909ff3.size] = i;
		}
	}
	var_32060833 = array::random(var_89909ff3);
	level.var_bc88ffc0[var_32060833] = 1;
	level namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_4897af3f145fc798", var_32060833, 0);
}

/*
	Name: function_2cacde54
	Namespace: namespace_3e3742fd
	Checksum: 0x1E5B0510
	Offset: 0xB5F8
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function function_2cacde54(s_params)
{
	if(self.archetype === #"zombie" && level.var_4d9eeedb > level.var_86d0f5e7)
	{
		if(namespace_c3287616::function_40229072(namespace_a28acff3::get_round_number()))
		{
			level.zombie_total = level.zombie_total - 1;
		}
		level.var_86d0f5e7 = level.var_86d0f5e7 + 1;
	}
}

/*
	Name: function_c15054f0
	Namespace: namespace_3e3742fd
	Checksum: 0x6A9B630C
	Offset: 0xB698
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_c15054f0()
{
	while(level.var_4d9eeedb > level.var_86d0f5e7)
	{
		wait(1);
	}
	callback::remove_on_ai_killed(&function_2cacde54);
}

/*
	Name: function_9b979e93
	Namespace: namespace_3e3742fd
	Checksum: 0xBA52748A
	Offset: 0xB6F0
	Size: 0x3E4
	Parameters: 0
	Flags: Linked
*/
function function_9b979e93()
{
	self endon(#"death");
	level.var_4d9eeedb = 0;
	if(getplayers().size > 2)
	{
		var_97c562fc = 260;
	}
	else if(getplayers().size > 2)
	{
		var_97c562fc = 174;
	}
	else
	{
		var_97c562fc = 96;
	}
	while(level.var_4d9eeedb < var_97c562fc)
	{
		var_63cf6c7b = 0;
		while(isdefined(level.intermission) && level.intermission)
		{
			var_63cf6c7b = 1;
			wait(1);
		}
		if(var_63cf6c7b)
		{
			level waittill(#"zombie_total_set");
		}
		str_zone = self.zone_name;
		var_eb3b90d = [];
		if(isdefined(str_zone))
		{
			foreach(s_spawn in level.zm_loc_types[#"zombie_location"])
			{
				if(s_spawn.zone_name == str_zone)
				{
					if(!isdefined(var_eb3b90d))
					{
						var_eb3b90d = [];
					}
					else if(!isarray(var_eb3b90d))
					{
						var_eb3b90d = array(var_eb3b90d);
					}
					if(!isinarray(var_eb3b90d, s_spawn))
					{
						var_eb3b90d[var_eb3b90d.size] = s_spawn;
					}
				}
			}
		}
		else
		{
			var_eb3b90d = level.zm_loc_types[#"zombie_location"];
		}
		if(getplayers().size > 2)
		{
			n_enemies = 10;
		}
		else if(getplayers().size > 2)
		{
			n_enemies = 6;
		}
		else
		{
			n_enemies = 3;
		}
		for(i = 0; i < n_enemies; i++)
		{
			ai = undefined;
			if(zombie_utility::get_current_zombie_count() < 24)
			{
				if(var_eb3b90d.size > 0)
				{
					s_spawn_point = array::random(var_eb3b90d);
					ai = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0], undefined, s_spawn_point);
				}
				else
				{
					ai = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0]);
				}
			}
			if(isdefined(ai))
			{
				level.zombie_total = level.zombie_total + 1;
				level.var_4d9eeedb = level.var_4d9eeedb + 1;
				ai zm_score::function_acaab828(1);
			}
			wait(0.2);
		}
		wait(5);
	}
}

/*
	Name: function_c349b9ef
	Namespace: namespace_3e3742fd
	Checksum: 0xA100A290
	Offset: 0xBAE0
	Size: 0x298
	Parameters: 0
	Flags: Linked
*/
function function_c349b9ef()
{
	self endon(#"death");
	self endon(#"hash_7da204dd1f666ddb");
	self.var_8ad92463 = 0;
	while(true)
	{
		e_closest_player = zm_utility::get_closest_valid_player(self.origin);
		if(isdefined(e_closest_player))
		{
			n_dist = distancesquared(self.origin, e_closest_player.origin);
			if(n_dist > 360000 && !self.var_eb58e513)
			{
				if(level.zones[self.var_580ff2bd].a_loc_types[#"wait_location"].size > 0)
				{
					self.ignore_find_flesh = 1;
					self setgoal(level.zones[self.var_580ff2bd].a_loc_types[#"wait_location"][0].origin);
					self.var_eb58e513 = 1;
				}
			}
			else if(self.var_eb58e513 && n_dist < 90000)
			{
				self.var_8ad92463 = 0;
				self.ignore_find_flesh = 0;
				self setgoal(self.origin);
				self.var_eb58e513 = 0;
			}
			if(self.var_eb58e513 && self.var_8ad92463 >= 80)
			{
				self.var_580ff2bd = level function_a521b860();
				self setgoal(level.zones[self.var_580ff2bd].a_loc_types[#"wait_location"][0].origin);
				self.var_8ad92463 = 0;
				/#
					iprintlnbold("" + self.var_580ff2bd);
				#/
			}
			else if(self.var_eb58e513)
			{
				self.var_8ad92463 = self.var_8ad92463 + 1;
			}
		}
		wait(0.25);
	}
}

/*
	Name: function_bf602089
	Namespace: namespace_3e3742fd
	Checksum: 0xA136DB2C
	Offset: 0xBD80
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function function_bf602089()
{
	self endon(#"death");
	self.var_74f97d1e = 0;
	b_complete = 0;
	var_1b10e09e = getent("wither_vol", "targetname");
	while(!b_complete)
	{
		if(self istouching(var_1b10e09e) && self.var_eb58e513 === 0)
		{
			b_complete = 1;
			self notify(#"hash_7da204dd1f666ddb");
		}
		wait(0.25);
	}
	var_1b84df34 = struct::get("wither_point", "targetname");
	self.ignore_find_flesh = 1;
	self setgoal(var_1b84df34.origin);
	b_complete = 0;
	var_1b10e09e = getent("wither_dest", "targetname");
	while(!b_complete)
	{
		if(self istouching(var_1b10e09e))
		{
			b_complete = 1;
			self.var_74f97d1e = 1;
		}
		wait(0.25);
	}
}

/*
	Name: function_a0351130
	Namespace: namespace_3e3742fd
	Checksum: 0xC9ECAEB3
	Offset: 0xBF08
	Size: 0x14A
	Parameters: 1
	Flags: Linked
*/
function function_a0351130(var_e3d37a1d)
{
	a_valid_spawn_points = [];
	foreach(s_spawn_point in level.zm_loc_types[#"zombie_location"])
	{
		if(s_spawn_point.zone_name == var_e3d37a1d && s_spawn_point.var_683460c9 === 1)
		{
			if(!isdefined(a_valid_spawn_points))
			{
				a_valid_spawn_points = [];
			}
			else if(!isarray(a_valid_spawn_points))
			{
				a_valid_spawn_points = array(a_valid_spawn_points);
			}
			if(!isinarray(a_valid_spawn_points, s_spawn_point))
			{
				a_valid_spawn_points[a_valid_spawn_points.size] = s_spawn_point;
			}
		}
	}
	if(a_valid_spawn_points.size > 0)
	{
		return array::random(a_valid_spawn_points);
	}
	return undefined;
}

/*
	Name: function_a521b860
	Namespace: namespace_3e3742fd
	Checksum: 0x4B975A3E
	Offset: 0xC060
	Size: 0x2EA
	Parameters: 0
	Flags: Linked
*/
function function_a521b860()
{
	n_zones = [];
	if(!isdefined(n_zones))
	{
		n_zones = [];
	}
	else if(!isarray(n_zones))
	{
		n_zones = array(n_zones);
	}
	n_zones[n_zones.size] = #"zone_bunker_lounge";
	if(!isdefined(n_zones))
	{
		n_zones = [];
	}
	else if(!isarray(n_zones))
	{
		n_zones = array(n_zones);
	}
	n_zones[n_zones.size] = #"zone_bunker_diner";
	if(!isdefined(n_zones))
	{
		n_zones = [];
	}
	else if(!isarray(n_zones))
	{
		n_zones = array(n_zones);
	}
	n_zones[n_zones.size] = #"zone_bunker_beds_1";
	if(!isdefined(n_zones))
	{
		n_zones = [];
	}
	else if(!isarray(n_zones))
	{
		n_zones = array(n_zones);
	}
	n_zones[n_zones.size] = #"zone_bunker_beds_2";
	if(!isdefined(n_zones))
	{
		n_zones = [];
	}
	else if(!isarray(n_zones))
	{
		n_zones = array(n_zones);
	}
	n_zones[n_zones.size] = #"zone_bunker_power_1";
	if(!isdefined(n_zones))
	{
		n_zones = [];
	}
	else if(!isarray(n_zones))
	{
		n_zones = array(n_zones);
	}
	n_zones[n_zones.size] = #"zone_bunker_power_2";
	if(!isdefined(n_zones))
	{
		n_zones = [];
	}
	else if(!isarray(n_zones))
	{
		n_zones = array(n_zones);
	}
	n_zones[n_zones.size] = #"zone_bunker_storage";
	if(!isdefined(n_zones))
	{
		n_zones = [];
	}
	else if(!isarray(n_zones))
	{
		n_zones = array(n_zones);
	}
	n_zones[n_zones.size] = #"zone_bunker_solitary";
	return array::random(n_zones);
}

/*
	Name: function_8ef535c2
	Namespace: namespace_3e3742fd
	Checksum: 0x3CE5605F
	Offset: 0xC358
	Size: 0xD6
	Parameters: 1
	Flags: None
*/
function function_8ef535c2(str_zone_name)
{
	if(str_zone_name == #"zone_bunker_lounge" || str_zone_name == #"zone_bunker_diner" || str_zone_name == #"zone_bunker_beds_1" || str_zone_name == #"zone_bunker_beds_2" || str_zone_name == #"zone_bunker_power_1" || str_zone_name == #"zone_bunker_power_2" || str_zone_name == #"zone_bunker_storage" || str_zone_name == #"zone_bunker_solitary")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_35829796
	Namespace: namespace_3e3742fd
	Checksum: 0x943EDE57
	Offset: 0xC438
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_35829796(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::set(#"hash_bbe0772d001265");
		level flag::set(#"hash_bd08d5649673cd1");
		level thread function_14df793d();
		level flag::wait_till(#"hash_6a79293e26344b0f");
	}
}

/*
	Name: function_3d6aec4
	Namespace: namespace_3e3742fd
	Checksum: 0xC158AEA5
	Offset: 0xC4D0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_3d6aec4(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_6a79293e26344b0f");
	}
}

/*
	Name: function_f46a1855
	Namespace: namespace_3e3742fd
	Checksum: 0xFED9B32C
	Offset: 0xC520
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_f46a1855()
{
	level.cornball_place = getent("cornball_place", "targetname");
	level.cornball_place hide();
}

/*
	Name: function_76340b81
	Namespace: namespace_3e3742fd
	Checksum: 0x9707921E
	Offset: 0xC578
	Size: 0x8
	Parameters: 0
	Flags: None
*/
function function_76340b81()
{
	return 1;
}

/*
	Name: function_14df793d
	Namespace: namespace_3e3742fd
	Checksum: 0x7E781787
	Offset: 0xC588
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_14df793d()
{
	self notify("3dbdac6970f8a606");
	self endon("3dbdac6970f8a606");
	e_volume = getent("manny_v_mars", "targetname");
	b_near = 0;
	while(!b_near)
	{
		wait(0.5);
		if(isdefined(level.var_8943f7db) && level.var_8943f7db istouching(e_volume))
		{
			b_near = 1;
		}
	}
	if(isdefined(level.var_8943f7db))
	{
		s_stand = struct::get("manny_deliver", "targetname");
		level function_7e1a75a4();
		level flag::set(#"hash_8f3e7e5efab6d13");
	}
	if(!level flag::get(#"hash_8f3e7e5efab6d13"))
	{
		level thread function_14df793d();
	}
}

/*
	Name: function_dbb98ad1
	Namespace: namespace_3e3742fd
	Checksum: 0xAE77E003
	Offset: 0xC6E8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_dbb98ad1()
{
	self notify("955a356459ad2c3");
	self endon("955a356459ad2c3");
	level flag::clear(#"hash_bd08d5649673cd1");
	wait(25);
	level flag::set(#"hash_bd08d5649673cd1");
}

/*
	Name: function_63f24bb1
	Namespace: namespace_3e3742fd
	Checksum: 0x90B5E067
	Offset: 0xC760
	Size: 0x394
	Parameters: 1
	Flags: Linked
*/
function function_63f24bb1(e_player)
{
	level endon(#"hash_6e610cd7ddf719c7");
	if(!level.var_5af37cf8)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_55c50ef4 namespace_509a75d1::function_6a0d675d("vox_s3_recover", 0, 0);
		level namespace_509a75d1::function_3c173d37();
		if(isdefined(e_player))
		{
			e_player namespace_509a75d1::function_51b752a9("vox_s3_recover", 1, 0, 1);
		}
		else
		{
			namespace_509a75d1::function_fd24e47f("vox_s3_recover", 1, 0, 1);
		}
		level namespace_509a75d1::function_3c173d37();
		level.var_55c50ef4 namespace_509a75d1::function_6a0d675d("vox_s3_refuse", 0, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_s3_persuade", 0, 0, 1);
		level.var_5af37cf8 = 1;
	}
	else if(level.var_4e3bffd.size == 0)
	{
		for(i = 0; i < 5; i++)
		{
			level.var_4e3bffd[i] = i;
		}
		arrayremovevalue(level.var_4e3bffd, 0);
		arrayremovevalue(level.var_4e3bffd, 1);
		arrayremovevalue(level.var_4e3bffd, 3);
	}
	var_e7af51e9 = array::random(level.var_4e3bffd);
	if(isdefined(level.var_55c50ef4))
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_55c50ef4 namespace_509a75d1::function_6a0d675d("vox_s3_fail", var_e7af51e9, 0);
	}
	arrayremovevalue(level.var_4e3bffd, var_e7af51e9);
	if(level.var_3d9e8e0c.size == 0)
	{
		for(i = 0; i < 5; i++)
		{
			level.var_3d9e8e0c[i] = i;
		}
	}
	var_e7af51e9 = array::random(level.var_3d9e8e0c);
	if(isdefined(level.var_5dd0d3ff))
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_s3_hint", var_e7af51e9, 0);
	}
	arrayremovevalue(level.var_3d9e8e0c, var_e7af51e9);
	level thread function_dbb98ad1();
}

/*
	Name: function_c1ac94bf
	Namespace: namespace_3e3742fd
	Checksum: 0x8C06E268
	Offset: 0xCB00
	Size: 0x2E4
	Parameters: 0
	Flags: Linked
*/
function function_c1ac94bf()
{
	level endon(#"hash_6e610cd7ddf719c7");
	if(level.var_3e7698ce.size == 0 && level.var_8bd0fb2e < 4)
	{
		switch(level.var_8bd0fb2e)
		{
			case 0:
			{
				level namespace_509a75d1::function_3c173d37();
				level.var_55c50ef4 namespace_509a75d1::function_6a0d675d("vox_marlton_message1", 0, 0);
				level.var_8bd0fb2e = level.var_8bd0fb2e + 1;
				break;
			}
			case 1:
			{
				level namespace_509a75d1::function_3c173d37();
				level.var_55c50ef4 namespace_509a75d1::function_6a0d675d("vox_marlton_message2", 0, 0);
				level.var_8bd0fb2e = level.var_8bd0fb2e + 1;
				break;
			}
			case 2:
			{
				level namespace_509a75d1::function_3c173d37();
				level.var_55c50ef4 namespace_509a75d1::function_6a0d675d("vox_marlton_message3", 0, 0);
				level.var_8bd0fb2e = level.var_8bd0fb2e + 1;
				break;
			}
			case 3:
			{
				level namespace_509a75d1::function_3c173d37();
				level.var_55c50ef4 namespace_509a75d1::function_6a0d675d("vox_marlton_message4", 0, 0);
				level.var_8bd0fb2e = level.var_8bd0fb2e + 1;
				break;
			}
		}
	}
	else if(level.var_3e7698ce.size == 0)
	{
		for(i = 0; i < 10; i++)
		{
			level.var_3e7698ce[i] = i;
		}
	}
	var_e7af51e9 = array::random(level.var_3e7698ce);
	if(isdefined(level.var_55c50ef4))
	{
		level.var_55c50ef4 namespace_509a75d1::function_6a0d675d("vox_marlton_trapped", var_e7af51e9, 1);
	}
	arrayremovevalue(level.var_3e7698ce, var_e7af51e9);
}

/*
	Name: function_3937a01d
	Namespace: namespace_3e3742fd
	Checksum: 0x6FFDE4D2
	Offset: 0xCDF0
	Size: 0x28A
	Parameters: 2
	Flags: Linked
*/
function function_3937a01d(e_player = undefined, is_adam = 0)
{
	if(is_adam)
	{
		level.var_8943f7db namespace_509a75d1::function_6a0d675d("vox_adam_activated", 3, 0);
		level notify(#"hash_6e610cd7ddf719c7");
		level.var_5e2c12d8 = 1;
		level.var_1409b3a9 = 0;
		level namespace_509a75d1::function_3c173d37();
		level.var_55c50ef4 namespace_509a75d1::function_6a0d675d("vox_s3_success", 0, 0);
		level thread marlton_door_scene_control();
		level flag::set(#"hash_4ad92dd97af40a26");
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_s3_success", 1, 0);
		level namespace_509a75d1::function_3c173d37();
		namespace_509a75d1::function_fd24e47f("vox_s3_success", 2, 0);
		level.var_1409b3a9 = 1;
		level.var_5e2c12d8 = 0;
	}
	if(level.var_1409b3a9 === 1)
	{
		level.var_1409b3a9 = 0;
		if(level flag::get(#"hash_bbe0772d001265") && !level flag::get(#"hash_4ad92dd97af40a26") && level flag::get(#"hash_bd08d5649673cd1") && level.var_5e2c12d8 === 0)
		{
			level function_63f24bb1(e_player);
		}
		else if(level.var_5e2c12d8 === 0)
		{
			level function_c1ac94bf();
		}
		level.var_1409b3a9 = 1;
	}
}

/*
	Name: function_550420a3
	Namespace: namespace_3e3742fd
	Checksum: 0x723928FA
	Offset: 0xD088
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function function_550420a3()
{
	while(true)
	{
		results = undefined;
		results = self waittill(#"trigger_activated");
		level function_3937a01d(results.e_who);
	}
}

/*
	Name: function_931fd8c2
	Namespace: namespace_3e3742fd
	Checksum: 0x6CFF6D96
	Offset: 0xD0E8
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function function_931fd8c2()
{
	level endon(#"end_game");
	self endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"damage");
		if(level flag::get(#"hash_bbe0772d001265") && !level flag::get(#"hash_4ad92dd97af40a26") && isplayer(s_result.attacker) && level.var_1409b3a9)
		{
			level function_3937a01d(s_result.attacker);
		}
		else if(s_result.mod === "MOD_MELEE" && isplayer(s_result.attacker) && level.var_1409b3a9)
		{
			level function_3937a01d(s_result.attacker);
		}
	}
}

/*
	Name: function_7e1a75a4
	Namespace: namespace_3e3742fd
	Checksum: 0xAFA37421
	Offset: 0xD248
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_7e1a75a4()
{
	if(isdefined(level.var_8943f7db))
	{
		level function_3937a01d(level.var_8943f7db, 1);
	}
}

/*
	Name: marlton_door_scene_control
	Namespace: namespace_3e3742fd
	Checksum: 0xD2521261
	Offset: 0xD288
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function marlton_door_scene_control()
{
	level.var_9343dcaf = struct::get("marlton_door_scene", "targetname");
	level.var_9343dcaf flagsys::wait_till(#"scene_ents_ready");
	level.var_9343dcaf scene::play("play");
	var_eb3eca05 = level.var_9343dcaf.scene_ents[#"hash_7aff0ee60ddd937b"];
	s_trigger_location = spawnstruct();
	s_trigger_location.origin = var_eb3eca05 gettagorigin("tag_cylinder");
	s_trigger_location zm_unitrigger::create("", 72, &function_5092a929);
}

/*
	Name: function_5092a929
	Namespace: namespace_3e3742fd
	Checksum: 0xFCE2B217
	Offset: 0xD3A8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_5092a929()
{
	self endon(#"death");
	self waittill(#"trigger");
	playsoundatposition(#"evt_canister_pickup", self.origin);
	level.var_9343dcaf scene::play("init");
	level.cornball_place zm_unitrigger::create("", 80, &function_fe7d6797);
	zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_fe7d6797
	Namespace: namespace_3e3742fd
	Checksum: 0xE6BEFF6C
	Offset: 0xD470
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_fe7d6797()
{
	self endon(#"death");
	self waittill(#"trigger");
	level.cornball_place show();
	playsoundatposition(#"evt_canister_pickup", self.origin);
	level flag::set(#"hash_6a79293e26344b0f");
	zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_410eb13b
	Namespace: namespace_3e3742fd
	Checksum: 0x62B63A2E
	Offset: 0xD520
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_410eb13b(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_12ea5b51();
		level flag::wait_till(#"circuit_step_complete");
	}
}

/*
	Name: _that_peek
	Namespace: namespace_3e3742fd
	Checksum: 0xBB6282A
	Offset: 0xD578
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function _that_peek(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"circuit_step_complete");
	}
	level function_c9d90b42();
}

/*
	Name: function_d12682c5
	Namespace: namespace_3e3742fd
	Checksum: 0xC6656AA1
	Offset: 0xD5E0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_d12682c5()
{
	self zm_perks::function_a30c73b9("off");
	if(!isdefined(self.var_a0fc37f6))
	{
		self.var_a0fc37f6 = self.prompt_and_visibility_func;
	}
	self.prompt_and_visibility_func = &function_c03c3007;
	if(!isdefined(self.var_492080a5))
	{
		self.var_492080a5 = self.trigger_func;
	}
	self.trigger_func = &function_713b8131;
	zm_unitrigger::reregister_unitrigger(self);
}

/*
	Name: function_f6ac524d
	Namespace: namespace_3e3742fd
	Checksum: 0x18C40C4E
	Offset: 0xD680
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_f6ac524d()
{
	self zm_perks::function_a30c73b9("on");
	if(isdefined(self.var_a0fc37f6))
	{
		self.prompt_and_visibility_func = self.var_a0fc37f6;
		self.var_a0fc37f6 = undefined;
	}
	if(isdefined(self.var_492080a5))
	{
		self.trigger_func = self.var_492080a5;
		self.var_492080a5 = undefined;
	}
	zm_unitrigger::reregister_unitrigger(self);
}

/*
	Name: function_c03c3007
	Namespace: namespace_3e3742fd
	Checksum: 0xC6BFFFE6
	Offset: 0xD708
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function function_c03c3007(e_player)
{
	self sethintstring(#"hash_71158766520dc432");
	return 1;
}

/*
	Name: function_713b8131
	Namespace: namespace_3e3742fd
	Checksum: 0x23A0398
	Offset: 0xD740
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function function_713b8131(e_player)
{
	while(true)
	{
		waitframe(1);
	}
}

/*
	Name: function_c9d90b42
	Namespace: namespace_3e3742fd
	Checksum: 0x84DB2F13
	Offset: 0xD768
	Size: 0x4EC
	Parameters: 0
	Flags: Linked
*/
function function_c9d90b42()
{
	if(isdefined(level.pack_a_punch) && level.var_bcaf8591 >= 4)
	{
		level flag::set("pap_power_ready");
	}
	playsoundatposition(#"hash_15f3b938e2fc15af", (0, 0, 0));
	level exploder::exploder("fxexp_script_pap_lgt");
	var_c718a93c = level namespace_1846c963::function_688df525();
	foreach(s_portal in var_c718a93c)
	{
		s_portal.b_active = 1;
		waitframe(1);
		s_portal thread namespace_1846c963::function_16ccd69f();
	}
	foreach(var_5baafbb2 in level.var_76a7ad28)
	{
		var_5baafbb2 function_f6ac524d();
	}
	level exploder::exploder("fxexp_script_perk_lgt");
	level exploder::exploder("fxexp_script_power_on");
	level exploder::exploder("fxexp_script_power_on_bunker");
	exploder::exploder("fxexp_script_power_on_lgt_exterior");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_green");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_hammond");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_hoggatt");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_obrien");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_red");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_reinsel");
	level.var_1fff8fd2 playloopsound("evt_apd_loop");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_shed");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_yellow");
	waitframe(1);
	zm_white::function_1c074340();
	level exploder::exploder("fxexp_power_on");
	level namespace_1846c963::function_71e1c159();
	level namespace_5c160465::function_10f8273e();
	namespace_5c160465::function_4b72fed8();
	if(level.var_bcaf8591 >= 4)
	{
		level.var_7a86ba58 namespace_5c160465::function_ccc74648("string_06");
	}
	else
	{
		level.var_7a86ba58 namespace_5c160465::function_ccc74648("string_05");
	}
	level.var_f13364b4.s_keypad thread namespace_7d8e6ec3::function_44748fe7();
	namespace_7d8e6ec3::function_9a2a7f26();
	namespace_7d8e6ec3::function_52838f02("keypad", 1);
	level.var_18f1ca6e thread namespace_7d8e6ec3::function_6ef53601("style1");
	level namespace_7d8e6ec3::function_a4c9098e(0);
	level.var_18f1ca6e thread namespace_7d8e6ec3::function_cafaeead();
	namespace_7d8e6ec3::function_792d350a(0);
	exploder::exploder("fxexp_script_computersystem_screen");
}

/*
	Name: function_12ea5b51
	Namespace: namespace_3e3742fd
	Checksum: 0x856905E2
	Offset: 0xDC60
	Size: 0x258C
	Parameters: 0
	Flags: Linked
*/
function function_12ea5b51()
{
	level flag::set(#"hash_1478cafcd626c361");
	var_c718a93c = level namespace_1846c963::function_688df525();
	foreach(s_portal in var_c718a93c)
	{
		s_portal thread namespace_1846c963::function_978923cd();
		s_portal.b_active = 0;
		waitframe(1);
		s_portal thread namespace_1846c963::function_16ccd69f();
	}
	level namespace_1846c963::function_3264eb9c();
	level namespace_5c160465::function_61753e3();
	if(isdefined(level.pack_a_punch) && level zm_pack_a_punch::is_on())
	{
		level.pack_a_punch.trigger_stubs[0].pap_machine flag::wait_till("pap_waiting_for_user");
	}
	level flag::clear("pap_power_ready");
	level exploder::stop_exploder("fxexp_script_pap_lgt");
	foreach(var_5baafbb2 in level.var_76a7ad28)
	{
		var_5baafbb2 function_d12682c5();
	}
	level exploder::stop_exploder("fxexp_script_perk_lgt");
	level exploder::stop_exploder("fxexp_script_power_on");
	level exploder::stop_exploder("fxexp_script_power_on_bunker");
	exploder::stop_exploder("fxexp_script_power_on_lgt_exterior");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_green");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_hammond");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_hoggatt");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_obrien");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_red");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_reinsel");
	level.var_1fff8fd2 stoploopsound();
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_shed");
	waitframe(1);
	exploder::stop_exploder("fxexp_script_power_on_lgt_house_yellow");
	waitframe(1);
	zm_white::function_4f60590c();
	playsoundatposition(#"hash_4ef404ee4aeb16bf", (0, 0, 0));
	namespace_5c160465::function_217e3c0f();
	level exploder::stop_exploder("fxexp_power_on");
	level notify(#"hash_5157b4b2b1edc64e");
	namespace_7d8e6ec3::function_31890499();
	namespace_7d8e6ec3::function_52838f02("both", 0);
	level.var_18f1ca6e thread namespace_7d8e6ec3::function_a196c54b();
	level.var_18f1ca6e stoploopsound();
	namespace_7d8e6ec3::function_792d350a(1);
	exploder::stop_exploder("fxexp_script_computersystem_screen");
	level.var_7a86ba58 namespace_5c160465::function_1bce0fd();
	var_4b4e7150 = [];
	if(!isdefined(var_4b4e7150))
	{
		var_4b4e7150 = [];
	}
	else if(!isarray(var_4b4e7150))
	{
		var_4b4e7150 = array(var_4b4e7150);
	}
	var_4b4e7150[var_4b4e7150.size] = 0;
	if(!isdefined(var_4b4e7150))
	{
		var_4b4e7150 = [];
	}
	else if(!isarray(var_4b4e7150))
	{
		var_4b4e7150 = array(var_4b4e7150);
	}
	var_4b4e7150[var_4b4e7150.size] = 0;
	if(!isdefined(var_4b4e7150))
	{
		var_4b4e7150 = [];
	}
	else if(!isarray(var_4b4e7150))
	{
		var_4b4e7150 = array(var_4b4e7150);
	}
	var_4b4e7150[var_4b4e7150.size] = 0;
	if(!isdefined(var_4b4e7150))
	{
		var_4b4e7150 = [];
	}
	else if(!isarray(var_4b4e7150))
	{
		var_4b4e7150 = array(var_4b4e7150);
	}
	var_4b4e7150[var_4b4e7150.size] = 0;
	if(!isdefined(var_4b4e7150))
	{
		var_4b4e7150 = [];
	}
	else if(!isarray(var_4b4e7150))
	{
		var_4b4e7150 = array(var_4b4e7150);
	}
	var_4b4e7150[var_4b4e7150.size] = 1;
	if(!isdefined(var_4b4e7150))
	{
		var_4b4e7150 = [];
	}
	else if(!isarray(var_4b4e7150))
	{
		var_4b4e7150 = array(var_4b4e7150);
	}
	var_4b4e7150[var_4b4e7150.size] = 1;
	var_4b4e7150 = array::randomize(var_4b4e7150);
	level.var_79551e8e = [];
	level.var_79551e8e[0] = 1;
	level.var_79551e8e[1] = 1;
	level.var_79551e8e[2] = 1;
	level.var_79551e8e[3] = 1;
	level.var_79551e8e[4] = 1;
	level.var_79551e8e[5] = 1;
	level.var_775f8ab0 = 6;
	level.var_4d75e9c1 = [];
	var_9fa88557 = struct::get("beaker_trigger_0", "targetname");
	s_unitrigger = var_9fa88557 zm_unitrigger::create("", 64);
	s_unitrigger.var_ef8cfa2c = level.var_c90d4581[0];
	s_unitrigger.is_on = 1;
	s_unitrigger.is_flipped = 0;
	if(var_4b4e7150[0] == 0)
	{
		s_unitrigger.is_on = 0;
		s_unitrigger.var_ef8cfa2c thread scene::play("a_to_b");
		s_unitrigger.is_flipped = 1;
		if(level.var_79551e8e[2] == 1)
		{
			level.var_79551e8e[2] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[2] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[3] == 1)
		{
			level.var_79551e8e[3] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[3] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[4] == 1)
		{
			level.var_79551e8e[4] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[4] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
	}
	s_unitrigger.a_positions = [];
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 2;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 3;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 4;
	var_9fa88557 thread function_cb6d744();
	if(!isdefined(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = [];
	}
	else if(!isarray(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = array(level.var_4d75e9c1);
	}
	level.var_4d75e9c1[level.var_4d75e9c1.size] = var_9fa88557;
	var_9fa88557 = struct::get("beaker_trigger_1", "targetname");
	s_unitrigger = var_9fa88557 zm_unitrigger::create("", 64);
	s_unitrigger.var_ef8cfa2c = level.var_c90d4581[1];
	s_unitrigger.is_on = 1;
	s_unitrigger.is_flipped = 1;
	if(var_4b4e7150[1] == 0)
	{
		s_unitrigger.var_ef8cfa2c thread scene::play("b_to_a");
		s_unitrigger.is_flipped = 0;
		s_unitrigger.is_on = 0;
		if(level.var_79551e8e[1] == 1)
		{
			level.var_79551e8e[1] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[1] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[3] == 1)
		{
			level.var_79551e8e[3] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[3] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[5] == 1)
		{
			level.var_79551e8e[5] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[5] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
	}
	s_unitrigger.a_positions = [];
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 1;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 3;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 5;
	var_9fa88557 thread function_cb6d744();
	if(!isdefined(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = [];
	}
	else if(!isarray(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = array(level.var_4d75e9c1);
	}
	level.var_4d75e9c1[level.var_4d75e9c1.size] = var_9fa88557;
	var_9fa88557 = struct::get("beaker_trigger_2", "targetname");
	s_unitrigger = var_9fa88557 zm_unitrigger::create("", 64);
	s_unitrigger.var_ef8cfa2c = level.var_c90d4581[2];
	s_unitrigger.is_on = 1;
	s_unitrigger.is_flipped = 1;
	if(var_4b4e7150[2] == 0)
	{
		s_unitrigger.var_ef8cfa2c thread scene::play("b_to_a");
		s_unitrigger.is_flipped = 0;
		s_unitrigger.is_on = 0;
		if(level.var_79551e8e[0] == 1)
		{
			level.var_79551e8e[0] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[0] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[4] == 1)
		{
			level.var_79551e8e[4] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[4] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[5] == 1)
		{
			level.var_79551e8e[5] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[5] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
	}
	s_unitrigger.a_positions = [];
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 0;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 4;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 5;
	var_9fa88557 thread function_cb6d744();
	if(!isdefined(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = [];
	}
	else if(!isarray(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = array(level.var_4d75e9c1);
	}
	level.var_4d75e9c1[level.var_4d75e9c1.size] = var_9fa88557;
	var_9fa88557 = struct::get("beaker_trigger_3", "targetname");
	s_unitrigger = var_9fa88557 zm_unitrigger::create("", 64);
	s_unitrigger.var_ef8cfa2c = level.var_c90d4581[3];
	s_unitrigger.is_on = 1;
	s_unitrigger.is_flipped = 0;
	if(var_4b4e7150[3] == 0)
	{
		s_unitrigger.var_ef8cfa2c thread scene::play("a_to_b");
		s_unitrigger.is_flipped = 1;
		s_unitrigger.is_on = 0;
		if(level.var_79551e8e[0] == 1)
		{
			level.var_79551e8e[0] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[0] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[2] == 1)
		{
			level.var_79551e8e[2] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[2] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[3] == 1)
		{
			level.var_79551e8e[3] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[3] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
	}
	s_unitrigger.a_positions = [];
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 0;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 2;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 3;
	var_9fa88557 thread function_cb6d744();
	if(!isdefined(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = [];
	}
	else if(!isarray(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = array(level.var_4d75e9c1);
	}
	level.var_4d75e9c1[level.var_4d75e9c1.size] = var_9fa88557;
	var_9fa88557 = struct::get("beaker_trigger_4", "targetname");
	s_unitrigger = var_9fa88557 zm_unitrigger::create("", 64);
	s_unitrigger.var_ef8cfa2c = level.var_c90d4581[4];
	s_unitrigger.is_on = 1;
	s_unitrigger.is_flipped = 1;
	if(var_4b4e7150[4] == 0)
	{
		s_unitrigger.var_ef8cfa2c thread scene::play("b_to_a");
		s_unitrigger.is_flipped = 0;
		s_unitrigger.is_on = 0;
		if(level.var_79551e8e[0] == 1)
		{
			level.var_79551e8e[0] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[0] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[1] == 1)
		{
			level.var_79551e8e[1] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[1] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[4] == 1)
		{
			level.var_79551e8e[4] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[4] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
	}
	s_unitrigger.a_positions = [];
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 0;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 1;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 4;
	var_9fa88557 thread function_cb6d744();
	if(!isdefined(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = [];
	}
	else if(!isarray(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = array(level.var_4d75e9c1);
	}
	level.var_4d75e9c1[level.var_4d75e9c1.size] = var_9fa88557;
	var_9fa88557 = struct::get("beaker_trigger_5", "targetname");
	s_unitrigger = var_9fa88557 zm_unitrigger::create("", 64);
	s_unitrigger.var_ef8cfa2c = level.var_c90d4581[5];
	s_unitrigger.is_on = 1;
	s_unitrigger.is_flipped = 0;
	if(var_4b4e7150[5] == 0)
	{
		s_unitrigger.var_ef8cfa2c thread scene::play("a_to_b");
		s_unitrigger.is_flipped = 1;
		s_unitrigger.is_on = 0;
		if(level.var_79551e8e[1] == 1)
		{
			level.var_79551e8e[1] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[1] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[2] == 1)
		{
			level.var_79551e8e[2] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[2] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
		if(level.var_79551e8e[5] == 1)
		{
			level.var_79551e8e[5] = 0;
			level.var_775f8ab0 = level.var_775f8ab0 - 1;
		}
		else
		{
			level.var_79551e8e[5] = 1;
			level.var_775f8ab0 = level.var_775f8ab0 + 1;
		}
	}
	s_unitrigger.a_positions = [];
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 1;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 2;
	if(!isdefined(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = [];
	}
	else if(!isarray(s_unitrigger.a_positions))
	{
		s_unitrigger.a_positions = array(s_unitrigger.a_positions);
	}
	s_unitrigger.a_positions[s_unitrigger.a_positions.size] = 5;
	var_9fa88557 thread function_cb6d744();
	if(!isdefined(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = [];
	}
	else if(!isarray(level.var_4d75e9c1))
	{
		level.var_4d75e9c1 = array(level.var_4d75e9c1);
	}
	level.var_4d75e9c1[level.var_4d75e9c1.size] = var_9fa88557;
	foreach(s_breaker in level.var_c90d4581)
	{
		e_prop = s_breaker.scene_ents[#"hash_7aff0ee60ddd937b"];
		if(level.var_79551e8e[0] == 1)
		{
			e_prop showpart("tag_light_green_0");
		}
		else
		{
			e_prop showpart("tag_light_red_0");
		}
		if(level.var_79551e8e[1] == 1)
		{
			e_prop showpart("tag_light_green_1");
		}
		else
		{
			e_prop showpart("tag_light_red_1");
		}
		if(level.var_79551e8e[2] == 1)
		{
			e_prop showpart("tag_light_green_2");
		}
		else
		{
			e_prop showpart("tag_light_red_2");
		}
		if(level.var_79551e8e[3] == 1)
		{
			e_prop showpart("tag_light_green_3");
		}
		else
		{
			e_prop showpart("tag_light_red_3");
		}
		if(level.var_79551e8e[4] == 1)
		{
			e_prop showpart("tag_light_green_4");
		}
		else
		{
			e_prop showpart("tag_light_red_4");
		}
		if(level.var_79551e8e[5] == 1)
		{
			e_prop showpart("tag_light_green_5");
			continue;
		}
		e_prop showpart("tag_light_red_5");
	}
	if(isdefined(level.var_3bce2e41))
	{
		level.var_3bce2e41 rotateroll(90, 0.3);
		level.var_3bce2e41 playsound(#"zmb_switch_flip");
		level.var_3bce2e41 zm_unitrigger::create(&function_a4cda974, 64);
		level.var_3bce2e41 thread function_bd754711();
	}
}

/*
	Name: function_cb6d744
	Namespace: namespace_3e3742fd
	Checksum: 0x7AB24732
	Offset: 0x101F8
	Size: 0x470
	Parameters: 0
	Flags: Linked
*/
function function_cb6d744()
{
	level endon(#"hash_60eeaaec1ff2cb28");
	while(!level flag::get(#"circuit_step_complete"))
	{
		activation = undefined;
		activation = self waittill(#"trigger_activated");
		if(!level flag::get(#"hash_60eeaaec1ff2cb28"))
		{
			if(self.s_unitrigger.is_on)
			{
				self.s_unitrigger.is_on = 0;
			}
			else
			{
				self.s_unitrigger.is_on = 1;
			}
			if(self.s_unitrigger.is_flipped)
			{
				self.s_unitrigger.is_flipped = 0;
				self.s_unitrigger.var_ef8cfa2c scene::play("b_to_a");
			}
			else
			{
				self.s_unitrigger.is_flipped = 1;
				self.s_unitrigger.var_ef8cfa2c scene::play("a_to_b");
			}
			foreach(var_939eafeb in self.s_unitrigger.a_positions)
			{
				if(level.var_79551e8e[var_939eafeb])
				{
					level.var_79551e8e[var_939eafeb] = 0;
					foreach(s_breaker in level.var_c90d4581)
					{
						s_breaker.scene_ents[#"hash_7aff0ee60ddd937b"] hidepart("tag_light_green_" + string(var_939eafeb));
						s_breaker.scene_ents[#"hash_7aff0ee60ddd937b"] showpart("tag_light_red_" + string(var_939eafeb));
					}
					level.var_775f8ab0 = level.var_775f8ab0 - 1;
					continue;
				}
				level.var_79551e8e[var_939eafeb] = 1;
				foreach(s_breaker in level.var_c90d4581)
				{
					s_breaker.scene_ents[#"hash_7aff0ee60ddd937b"] showpart("tag_light_green_" + string(var_939eafeb));
					s_breaker.scene_ents[#"hash_7aff0ee60ddd937b"] hidepart("tag_light_red_" + string(var_939eafeb));
				}
				level.var_775f8ab0 = level.var_775f8ab0 + 1;
			}
			if(level.var_775f8ab0 >= 6)
			{
				if(isdefined(level.var_3bce2e41))
				{
					activation.e_who namespace_509a75d1::function_51b752a9("vox_generic_responses_positive");
				}
			}
		}
	}
}

/*
	Name: function_a4cda974
	Namespace: namespace_3e3742fd
	Checksum: 0x107A4DB5
	Offset: 0x10670
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function function_a4cda974(e_player)
{
	if(level.var_775f8ab0 >= 6)
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_5c4125d53451e888");
		}
		else
		{
			self sethintstring(#"hash_5d8ba3059b5e82e4");
		}
	}
	return 1;
}

/*
	Name: function_bd754711
	Namespace: namespace_3e3742fd
	Checksum: 0x5DCB2508
	Offset: 0x106F8
	Size: 0x230
	Parameters: 0
	Flags: Linked
*/
function function_bd754711()
{
	var_707fca9c = 0;
	while(!level flag::get("circuit_step_complete"))
	{
		s_activation = undefined;
		s_activation = self waittill(#"trigger_activated");
		if(level.var_775f8ab0 >= 6)
		{
			level flag::set(#"hash_60eeaaec1ff2cb28");
			if(isdefined(level.var_3bce2e41))
			{
				level.var_3bce2e41 rotateroll(-90, 0.3);
				level.var_3bce2e41 playsound(#"zmb_switch_flip");
				level.var_3bce2e41 waittill(#"rotatedone");
				level.var_3bce2e41 playsound(#"zmb_turn_on");
				if(isdefined(level.var_577ff068))
				{
					playfx(level._effect[#"switch_sparks"], level.var_577ff068.origin);
				}
			}
			level flag::set(#"circuit_step_complete");
			if(isdefined(level.var_18f1ca6e))
			{
				level.var_18f1ca6e playloopsound(#"hash_3ed99d3b2e3e929f");
			}
			self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
		}
		else if(!var_707fca9c)
		{
			s_activation.e_who namespace_509a75d1::function_51b752a9("vox_generic_responses_negative");
			var_707fca9c = 1;
		}
	}
}

/*
	Name: function_6cebbce1
	Namespace: namespace_3e3742fd
	Checksum: 0x66A0E5C5
	Offset: 0x10930
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_6cebbce1()
{
	var_b1de144e = level flag::get(#"hash_1478cafcd626c361");
	var_2812d38 = level flag::get(#"circuit_step_complete");
	return var_b1de144e && !var_2812d38;
}

/*
	Name: function_8d0fab49
	Namespace: namespace_3e3742fd
	Checksum: 0x989A6E1C
	Offset: 0x109A0
	Size: 0x26C
	Parameters: 1
	Flags: Linked
*/
function function_8d0fab49(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::set(#"hash_a2a33348aff3bff");
		var_8e5ed5d = getent("moss_bed", "targetname");
		var_8e5ed5d hide();
		s_origin = struct::get("moss_work", "targetname");
		s_origin zm_unitrigger::create("", 64);
		s_origin thread function_65a1c71e();
		level thread function_431ee8fc();
		level flag::wait_till(#"hash_6899cc997afd5fac");
		level namespace_509a75d1::function_3c173d37();
		level namespace_509a75d1::function_314447b(1, 0);
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s4_success", 0, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_64be074234a54fe3", 0, 0, 1);
		level namespace_509a75d1::function_314447b(0);
		function_d6012fb8();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s4_hint", 0, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		namespace_509a75d1::function_fd24e47f("vox_s4_hint", 1, 0, 1);
		level flag::wait_till(#"hash_2f57ff102a73c0b5");
	}
}

/*
	Name: function_7c2844de
	Namespace: namespace_3e3742fd
	Checksum: 0xF73CC76B
	Offset: 0x10C18
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_7c2844de(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_2f57ff102a73c0b5");
	}
}

/*
	Name: function_431ee8fc
	Namespace: namespace_3e3742fd
	Checksum: 0x40284F65
	Offset: 0x10C68
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function function_431ee8fc()
{
	pixbeginevent(#"hash_6685ff45a6fa3be2");
	var_5128f73a = getent("moss_drive", "targetname");
	is_ready = 0;
	exploder::exploder("fxexp_frosty_console_gas");
	while(!is_ready)
	{
		s_result = undefined;
		s_result = var_5128f73a waittill(#"damage");
		if(s_result.weapon.name === #"white_nova_crawler_projectile")
		{
			level notify(#"hash_67b3ecdd6e33f06b");
			is_ready = 1;
			level.s_server_powerhouse function_5f6e4e8f("opening_withpart", "lights_timer_off");
			wait(2);
			if(level.var_d5d631ad === 0)
			{
				level namespace_509a75d1::function_3c173d37();
				level.var_5dd0d3ff thread namespace_509a75d1::function_6a0d675d(#"hash_39ce76b870710eee", 0, 0);
			}
		}
		else if(isplayer(s_result.attacker) && !level.var_ca750e86)
		{
			level.var_ca750e86 = 1;
			level thread function_ee37a268();
		}
	}
	pixendevent();
	level function_b485f46c();
}

/*
	Name: function_ee37a268
	Namespace: namespace_3e3742fd
	Checksum: 0x2C81C55C
	Offset: 0x10E78
	Size: 0x112
	Parameters: 0
	Flags: Linked
*/
function function_ee37a268()
{
	n_idx = function_21a3a673(0, 2);
	switch(n_idx)
	{
		case 0:
		{
			level.var_5dd0d3ff thread namespace_509a75d1::function_6a0d675d(#"vox_s3_hint", 0, 0);
			break;
		}
		case 1:
		{
			level.var_5dd0d3ff thread namespace_509a75d1::function_6a0d675d(#"vox_s3_hint", 1, 0);
			break;
		}
		case 2:
		{
			level.var_5dd0d3ff thread namespace_509a75d1::function_6a0d675d(#"vox_s3_hint", 3, 0);
			break;
		}
	}
	wait(30);
	level.var_ca750e86 = 0;
}

/*
	Name: function_65a1c71e
	Namespace: namespace_3e3742fd
	Checksum: 0x13E682BD
	Offset: 0x10F98
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_65a1c71e()
{
	level endon(#"hash_67b3ecdd6e33f06b");
	s_activation = undefined;
	s_activation = self waittill(#"trigger_activated");
	level.var_d5d631ad = 1;
	level.var_5dd0d3ff thread namespace_509a75d1::function_6a0d675d(#"hash_39ce76b870710eee", 0, 0);
}

/*
	Name: function_b485f46c
	Namespace: namespace_3e3742fd
	Checksum: 0x1B2C91D4
	Offset: 0x11018
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_b485f46c()
{
	s_origin = struct::get("moss_work", "targetname");
	s_origin thread function_d29ece92();
}

/*
	Name: function_d29ece92
	Namespace: namespace_3e3742fd
	Checksum: 0xD8896575
	Offset: 0x11068
	Size: 0x198
	Parameters: 0
	Flags: Linked
*/
function function_d29ece92()
{
	self endon(#"hash_499efb5492fe6802");
	while(!level flag::get(#"hash_687dde640557a121"))
	{
		s_activation = undefined;
		s_activation = self waittill(#"trigger_activated");
		level.s_server_powerhouse function_5f6e4e8f("removepart_close", "lights_timer_start");
		level.s_server_operations function_5f6e4e8f("opening_nopart", "lights_timer_start");
		s_activation.e_who.var_85039d98 = 1;
		/#
			iprintlnbold("");
		#/
		s_activation.e_who playsoundtoplayer(#"hash_7492b9f38f371981", s_activation.e_who);
		s_destination = struct::get("moss_home", "targetname");
		s_destination zm_unitrigger::create("", 64);
		s_destination thread function_f4f033c2();
		s_activation.e_who thread function_795df0c2();
		wait(1);
	}
}

/*
	Name: function_66b43b46
	Namespace: namespace_3e3742fd
	Checksum: 0xFC79C56D
	Offset: 0x11208
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_66b43b46()
{
	var_e87b2b1e = [];
	for(i = 0; i < level.var_b78d5f2c.size; i++)
	{
		if(level.var_b78d5f2c[i] === 0)
		{
			if(!isdefined(var_e87b2b1e))
			{
				var_e87b2b1e = [];
			}
			else if(!isarray(var_e87b2b1e))
			{
				var_e87b2b1e = array(var_e87b2b1e);
			}
			var_e87b2b1e[var_e87b2b1e.size] = i;
		}
	}
	if(var_e87b2b1e.size == 0)
	{
		for(i = 0; i < level.var_b78d5f2c.size; i++)
		{
			level.var_b78d5f2c[i] = 0;
			if(!isdefined(var_e87b2b1e))
			{
				var_e87b2b1e = [];
			}
			else if(!isarray(var_e87b2b1e))
			{
				var_e87b2b1e = array(var_e87b2b1e);
			}
			var_e87b2b1e[var_e87b2b1e.size] = i;
		}
	}
	var_32060833 = array::random(var_e87b2b1e);
	level.var_b78d5f2c[var_32060833] = 1;
	var_8fb3a1d4 = "vox_s4_fail_rush_" + var_32060833;
	level namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_6f5022d121f1efa1", var_32060833, 0);
}

/*
	Name: function_f4f033c2
	Namespace: namespace_3e3742fd
	Checksum: 0x1152B8A6
	Offset: 0x113E8
	Size: 0x290
	Parameters: 0
	Flags: Linked
*/
function function_f4f033c2()
{
	self endon(#"hash_187958b38e9fc842");
	var_9260818d = getent("moss_bed", "targetname");
	var_9260818d.var_43428f = util::spawn_model("tag_origin", var_9260818d.origin);
	var_9260818d.var_43428f.angles = var_9260818d.angles;
	var_9260818d.var_43428f clientfield::set("fx_steam_lab_dry_ice", 1);
	while(!level flag::get(#"hash_6899cc997afd5fac"))
	{
		s_activation = undefined;
		s_activation = self waittill(#"trigger_activated");
		if(s_activation.e_who.var_85039d98 === 1)
		{
			s_activation.e_who notify(#"hash_6b0b66cf2ec07802");
			s_activation.e_who clientfield::set_to_player("server_carry_audio_feedback", 0);
			s_activation.e_who playsoundtoplayer(#"hash_7492b9f38f371981", s_activation.e_who);
			if(isdefined(var_9260818d.var_43428f))
			{
				var_9260818d.var_43428f delete();
				var_9260818d.var_43428f = undefined;
			}
			/#
				iprintlnbold("");
			#/
			level.s_server_powerhouse function_5f6e4e8f("closed_nopart", "lights_timer_off");
			level.s_server_operations function_5f6e4e8f("addpart_close", "lights_timer_off");
			exploder::kill_exploder("fxexp_frosty_console_gas");
			level flag::clear(#"hash_687dde640557a121");
			level flag::set(#"hash_6899cc997afd5fac");
		}
	}
}

/*
	Name: function_795df0c2
	Namespace: namespace_3e3742fd
	Checksum: 0x65D131D3
	Offset: 0x11680
	Size: 0x228
	Parameters: 0
	Flags: Linked
*/
function function_795df0c2()
{
	self endon(#"hash_6b0b66cf2ec07802");
	self endon(#"disconnect");
	s_origin = struct::get("moss_work", "targetname");
	s_origin notify(#"hash_499efb5492fe6802");
	level flag::set(#"hash_687dde640557a121");
	self clientfield::set_to_player("server_carry_audio_feedback", 1);
	var_9260818d = getent("moss_bed", "targetname");
	if(isdefined(var_9260818d.var_43428f))
	{
		var_9260818d.var_43428f delete();
		var_9260818d.var_43428f = undefined;
	}
	n_elapsed_time = 0;
	level thread function_66cc35e7(self);
	while(n_elapsed_time < 12 && isdefined(self))
	{
		self thread clientfield::increment_to_player("server_carry_feedback", 1);
		if(n_elapsed_time < 5)
		{
			wait(1);
			n_elapsed_time = n_elapsed_time + 1;
		}
		else if(n_elapsed_time < 9)
		{
			wait(0.5);
			n_elapsed_time = n_elapsed_time + 0.5;
		}
		else
		{
			wait(0.25);
			n_elapsed_time = n_elapsed_time + 0.25;
		}
		if(n_elapsed_time == 5)
		{
			/#
				iprintlnbold("");
			#/
		}
		if(n_elapsed_time == 10)
		{
			/#
				iprintlnbold("");
			#/
		}
	}
}

/*
	Name: function_66cc35e7
	Namespace: namespace_3e3742fd
	Checksum: 0x2599BEA8
	Offset: 0x118B0
	Size: 0x20C
	Parameters: 1
	Flags: Linked
*/
function function_66cc35e7(e_player)
{
	self endon(#"hash_6b0b66cf2ec07802");
	wait(12);
	if(isdefined(e_player))
	{
		e_player clientfield::increment_to_player("server_carry_fail_feedback", 1);
		e_player clientfield::set_to_player("server_carry_audio_feedback", 0);
		e_player playsoundtoplayer(#"hash_97b813d405003aa", e_player);
	}
	level thread function_66b43b46();
	s_destination = struct::get("moss_home", "targetname");
	s_destination notify(#"hash_187958b38e9fc842");
	level flag::clear(#"hash_687dde640557a121");
	/#
		iprintlnbold("");
	#/
	level.s_server_powerhouse function_5f6e4e8f("opening_withpart", "lights_timer_off");
	level.s_server_operations function_5f6e4e8f("closing_nopart", "lights_timer_off");
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		e_player.var_85039d98 = 0;
	}
	level function_b485f46c();
}

/*
	Name: function_d6012fb8
	Namespace: namespace_3e3742fd
	Checksum: 0xFF93E0B2
	Offset: 0x11AC8
	Size: 0x11E
	Parameters: 0
	Flags: Linked
*/
function function_d6012fb8()
{
	level.var_f7d08898 = getentarray("server_painting", "targetname");
	level flag::set(#"hash_595f26b382ef7867");
	level thread function_f340b18e();
	level exploder::exploder("fxexp_brainrot_painting_beds");
	level exploder::exploder("fxexp_brainrot_painting_lounge");
	level exploder::exploder("fxexp_brainrot_painting_green");
	for(i = 0; i < level.var_f7d08898.size; i++)
	{
		level.var_f7d08898[i] playloopsound(#"hash_102a4d2346125954");
	}
}

/*
	Name: function_f340b18e
	Namespace: namespace_3e3742fd
	Checksum: 0xED952005
	Offset: 0x11BF0
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function function_f340b18e()
{
	self endon(#"hash_5758cf0a22937836");
	/#
		iprintlnbold("" + level.var_f13364b4.var_c8629019 + "" + level.var_f13364b4.var_becc7ced + "" + level.var_f13364b4.var_5beab72b);
	#/
	level waittill(#"hash_66ee9231ad909f7e");
	/#
		iprintlnbold("");
	#/
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_54d3d39c9c96c137", 0, 0);
	while(level.var_e1b5b6fe < 3)
	{
		/#
			iprintlnbold("" + level.var_f13364b4.var_c8629019 + "" + level.var_f13364b4.var_becc7ced + "" + level.var_f13364b4.var_5beab72b);
		#/
		level flag::clear(#"hash_66ee9231ad909f7e");
		level thread function_ca606729();
		level thread function_70c57a1a();
		level waittill(#"hash_66ee9231ad909f7e");
		level.countdown_clock namespace_7d8e6ec3::function_9b1511fa();
		level notify(#"hash_3f1d516a74b358b2");
	}
	level thread namespace_7d8e6ec3::function_6591945d();
	level flag::clear(#"hash_595f26b382ef7867");
	level flag::set(#"hash_2f57ff102a73c0b5");
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_ca606729
	Namespace: namespace_3e3742fd
	Checksum: 0x7D1B4FB9
	Offset: 0x11E70
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_ca606729()
{
	self endon(#"hash_3f1d516a74b358b2");
	level.countdown_clock namespace_7d8e6ec3::function_4955480();
	level.var_f13364b4.var_132bd718[level.var_f13364b4.var_c8629019].var_544c05c6 = 1;
	level.var_f13364b4.var_132bd718[level.var_f13364b4.var_becc7ced].var_544c05c6 = 1;
	level.var_f13364b4.var_132bd718[level.var_f13364b4.var_5beab72b].var_544c05c6 = 1;
	level.var_e1b5b6fe = 0;
	level notify(#"hash_5758cf0a22937836");
	level thread function_f340b18e();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_430854fd0f5d1a06", 0, 0);
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_70c57a1a
	Namespace: namespace_3e3742fd
	Checksum: 0x1B1E8A72
	Offset: 0x11FC8
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_70c57a1a()
{
	self endon(#"hash_3f1d516a74b358b2");
	while(level.countdown_clock.var_9400d2ae < 30)
	{
		wait(0.5);
	}
	level.var_f13364b4.var_e3d3636b = 1;
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_54d3d49c9c96c2ea", 0, 0);
	level.var_f13364b4.var_e3d3636b = 0;
}

/*
	Name: function_8033b54
	Namespace: namespace_3e3742fd
	Checksum: 0xF3A9743
	Offset: 0x12068
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function function_8033b54()
{
	targets = level.var_f7d08898;
	painting = undefined;
	closest_dist = undefined;
	foreach(target in targets)
	{
		dist = distancesquared(self.origin, target.origin);
		if(dist < 147456 && (!isdefined(closest_dist) || dist < closest_dist))
		{
			closest_dist = dist;
			painting = target;
		}
	}
	var_9ea2beb7 = 0;
	if(isdefined(painting))
	{
		str_exploder = "fxexp_brainrot_painting_" + painting.script_noteworthy;
		painting util::function_c596f193();
		self.favoriteenemy = painting;
		goalpos = getclosestpointonnavmesh(painting.origin, 128, 16);
		self setgoal(goalpos);
		self function_9f6dedfd(painting);
		var_9ea2beb7 = 1;
		exploder::stop_exploder(str_exploder);
		return 1;
	}
	return 0;
}

/*
	Name: function_9f6dedfd
	Namespace: namespace_3e3742fd
	Checksum: 0x770BACE9
	Offset: 0x12250
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function function_9f6dedfd(e_goal)
{
	self endon(#"death");
	var_d294ddbe = 0;
	while(!var_d294ddbe)
	{
		n_dist = distancesquared(self.origin, e_goal.origin);
		if(n_dist < 11500)
		{
			self function_7c3786a6(e_goal);
			var_d294ddbe = 1;
			break;
		}
		else
		{
			wait(0.1);
		}
	}
}

/*
	Name: function_a47e5054
	Namespace: namespace_3e3742fd
	Checksum: 0x882232A8
	Offset: 0x12300
	Size: 0xB4
	Parameters: 1
	Flags: None
*/
function function_a47e5054(targetpos)
{
	var_44b48bca = struct::get(self.target, "targetname");
	self endon(#"death");
	self physicslaunch(self.origin, vectornormalize(var_44b48bca.origin - self.origin) * 100000);
	arrayremovevalue(level.var_f7d08898, self, 0);
}

/*
	Name: function_7c3786a6
	Namespace: namespace_3e3742fd
	Checksum: 0x444FF2CE
	Offset: 0x123C0
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_7c3786a6(painting)
{
	self thread animation::play("ai_t8_zm_zombie_base_attack_01");
	wait(1);
	v_force = anglestoforward(painting.angles);
	v_force = v_force * 0.2;
	painting hide();
	if(isdefined(painting.dyn) && !isdefined(self.var_6a824c3e))
	{
		self.var_6a824c3e = 1;
		createdynentandlaunch(painting.dyn, painting.origin, painting.angles, painting.origin, v_force);
		playsoundatposition(#"hash_1ff16e6eb6a9dfed", painting.origin);
		arrayremovevalue(level.var_f7d08898, painting, 0);
		level.var_dee92db3 = level.var_dee92db3 + 1;
		level thread function_10e36c24();
	}
}

/*
	Name: function_10e36c24
	Namespace: namespace_3e3742fd
	Checksum: 0x448347F0
	Offset: 0x12530
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_10e36c24()
{
	if(level.var_dee92db3 == 1)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_278d42f84b8bb06b", 0, 0);
	}
	else if(level.var_dee92db3 == 3)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s4_last_code", 0, 0);
		level namespace_509a75d1::function_3c173d37();
		namespace_509a75d1::function_fd24e47f("vox_s4_last_code", 1, 0, 1);
	}
}

/*
	Name: function_32a04434
	Namespace: namespace_3e3742fd
	Checksum: 0x76A5173B
	Offset: 0x12630
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_32a04434(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::set(#"hash_6ebb9d0d0539bf68");
		level mannequin_step();
		level flag::wait_till(#"hash_3b808ddcae9fea60");
		namespace_7d8e6ec3::function_a3442c46("5");
	}
}

/*
	Name: function_d221a1e8
	Namespace: namespace_3e3742fd
	Checksum: 0x676F1AC
	Offset: 0x126C0
	Size: 0x140
	Parameters: 2
	Flags: Linked
*/
function function_d221a1e8(var_5ea5c94d, ended_early)
{
	var_abcd244b = getent("atlas_ct", "targetname");
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_3b808ddcae9fea60");
		var_847a63 = struct::get("atlas_trigger", "targetname");
		var_847a63 zm_unitrigger::create("", 64);
		var_847a63 thread function_ace163b6();
		var_847a63.b_placed = 1;
		var_abcd244b showpart("tag_head");
		var_abcd244b showpart("tag_left_arm");
		var_abcd244b showpart("tag_right_arm");
	}
}

/*
	Name: mannequin_step
	Namespace: namespace_3e3742fd
	Checksum: 0x9E53BE17
	Offset: 0x12808
	Size: 0x4FC
	Parameters: 0
	Flags: Linked
*/
function mannequin_step()
{
	level thread function_dd76c634();
	var_22f19cbb = level.var_22f19cbb;
	foreach(s_mannequin in var_22f19cbb)
	{
		sc = s_mannequin.script_string;
		e_head = getent(sc + "_head", "script_noteworthy");
		e_body = getent(sc + "_body", "script_noteworthy");
		e_collision = getent(sc + "_collision", "targetname");
		e_part = getent(sc + "_part", "targetname");
		e_head show();
		e_body show();
		e_collision solid();
		e_hatch = getent(sc + "_hatch", "script_noteworthy");
		var_67830325 = struct::get(sc + "_part_trigger", "targetname");
		if(isdefined(e_hatch))
		{
			s_hatch_open = struct::get(sc + "_hatch_open", "targetname");
			e_platform = getent(e_hatch.target, "targetname");
			var_3ba2cb8d = struct::get(e_platform.target, "targetname");
			e_hatch moveto(s_hatch_open.origin, 2, 0.25, 0.5);
			playsoundatposition(#"hash_1edbb15a3958792d", var_3ba2cb8d.origin);
			wait(1.75);
			level thread function_bf75d5a6(sc);
			e_platform moveto(var_3ba2cb8d.origin, 3, 0.25, 0.5);
		}
		if(isdefined(var_67830325))
		{
			var_67830325 zm_unitrigger::create("", 64);
		}
	}
	foreach(s_mannequin in var_22f19cbb)
	{
		s_mannequin.is_active = 0;
	}
	n_difficulty = 0;
	foreach(s_mannequin in var_22f19cbb)
	{
		if(isdefined(s_mannequin))
		{
			s_mannequin mannequin_activate(n_difficulty);
			n_difficulty = n_difficulty + 1;
		}
	}
	while(level.var_247a1d9f < 3)
	{
		wait(1);
	}
	var_847a63 = struct::get("atlas_trigger", "targetname");
	var_847a63 zm_unitrigger::create("", 64);
	var_847a63 thread function_ace163b6();
}

/*
	Name: function_dd76c634
	Namespace: namespace_3e3742fd
	Checksum: 0xA313164B
	Offset: 0x12D10
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_dd76c634()
{
	var_d1ec2571 = namespace_a28acff3::get_round_number();
	while(!level flag::get(#"hash_3b808ddcae9fea60"))
	{
		var_d1ec2571 = var_d1ec2571 + 1;
		if(namespace_c3287616::function_40229072(var_d1ec2571))
		{
			namespace_c3287616::function_43aed0ca(var_d1ec2571, 1);
		}
		while(var_d1ec2571 > namespace_a28acff3::get_round_number())
		{
			wait(1);
		}
	}
}

/*
	Name: function_bf75d5a6
	Namespace: namespace_3e3742fd
	Checksum: 0x826D4A8B
	Offset: 0x12DC8
	Size: 0x1FA
	Parameters: 1
	Flags: Linked
*/
function function_bf75d5a6(var_4743d914)
{
	switch(var_4743d914)
	{
		case "hash_1d5c817ea437f4ef":
		{
			exploder::exploder("fxexp_mannequin_defend_reveal_smoke_green_house");
			wait(3);
			exploder::stop_exploder("fxexp_mannequin_defend_reveal_smoke_green_house");
			break;
		}
		case "hash_1e4cf8226e91edc4":
		{
			exploder::exploder("fxexp_mannequin_defend_reveal_smoke_yellow_house");
			wait(3);
			exploder::stop_exploder("fxexp_mannequin_defend_reveal_smoke_yellow_house");
			break;
		}
		case "hash_235ab4a5da76ccd6":
		{
			exploder::exploder("fxexp_mannequin_defend_reveal_smoke_lounge");
			wait(3);
			exploder::stop_exploder("fxexp_mannequin_defend_reveal_smoke_lounge");
			break;
		}
		case "hash_5da141bd84380634":
		{
			exploder::exploder("fxexp_mannequin_defend_reveal_smoke_diner");
			wait(3);
			exploder::stop_exploder("fxexp_mannequin_defend_reveal_smoke_diner");
			break;
		}
		case "hash_3162ba3e960585ea":
		{
			exploder::exploder("fxexp_mannequin_defend_reveal_smoke_transfusion");
			wait(3);
			exploder::stop_exploder("fxexp_mannequin_defend_reveal_smoke_transfusion");
			break;
		}
		case "hash_4582c6b879dc2258":
		{
			exploder::exploder("fxexp_mannequin_defend_reveal_smoke_prison");
			wait(3);
			exploder::stop_exploder("fxexp_mannequin_defend_reveal_smoke_prison");
			break;
		}
	}
}

/*
	Name: function_ace163b6
	Namespace: namespace_3e3742fd
	Checksum: 0x4E0047AE
	Offset: 0x12FD0
	Size: 0x538
	Parameters: 0
	Flags: Linked
*/
function function_ace163b6()
{
	level endon(#"hash_66be0eea77b87d58");
	b_placed = 0;
	level.var_ffda9f5d = 0;
	while(!level flag::get(#"hash_66be0eea77b87d58"))
	{
		results = undefined;
		results = self waittill(#"trigger_activated");
		if(!b_placed)
		{
			b_placed = 1;
			var_abcd244b = getent("atlas_ct", "targetname");
			var_abcd244b showpart("tag_head");
			var_abcd244b showpart("tag_left_arm");
			var_abcd244b showpart("tag_right_arm");
			playsoundatposition(#"hash_56952caa95deab79", self.origin);
			level namespace_509a75d1::function_314447b(1, 0);
			level namespace_509a75d1::function_3c173d37();
			level.var_170ea961 namespace_509a75d1::function_6a0d675d(#"vox_s6_rebuilt", 0, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_rebuilt", 1, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			level.var_170ea961 namespace_509a75d1::function_6a0d675d("vox_s6_rebuilt", 2, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_rebuilt", 3, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			level.var_170ea961 namespace_509a75d1::function_6a0d675d("vox_s6_rebuilt", 4, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			results.e_who namespace_509a75d1::function_51b752a9("vox_s6_rebuilt", 5, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_rebuilt", 6, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			results.e_who namespace_509a75d1::function_51b752a9("vox_s6_rebuilt", 7, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_rebuilt", 8, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			level.var_170ea961 namespace_509a75d1::function_6a0d675d("vox_s6_rebuilt", 9, 0, 1);
			level namespace_509a75d1::function_3c173d37();
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_rebuilt", 10, 0, 1);
			level flag::set(#"hash_3b808ddcae9fea60");
		}
		else if(level flag::get(#"hash_7c2ae917559738ec") && !level flag::get(#"hash_66be0eea77b87d58"))
		{
			if(results.e_who zm_vo::function_82f9bc9f() == "Udem")
			{
				level function_edd35668(results.e_who);
			}
			else
			{
				level.var_170ea961 namespace_509a75d1::function_6a0d675d("vox_s6_interact", -1, 0);
			}
		}
	}
}

/*
	Name: function_edd35668
	Namespace: namespace_3e3742fd
	Checksum: 0x7D203B0C
	Offset: 0x13510
	Size: 0x28A
	Parameters: 1
	Flags: Linked
*/
function function_edd35668(e_player)
{
	switch(level.var_ffda9f5d)
	{
		case 0:
		{
			e_player namespace_509a75d1::function_51b752a9("vox_s6_interact_demp_1", 0, 0, 1);
			level.var_170ea961 namespace_509a75d1::function_6a0d675d("vox_s6_interact_demp_1", 1, 0, 1);
			level.var_ffda9f5d = level.var_ffda9f5d + 1;
			break;
		}
		case 1:
		{
			e_player namespace_509a75d1::function_51b752a9("vox_s6_interact_demp_2", 0, 0, 1);
			level.var_170ea961 namespace_509a75d1::function_6a0d675d("vox_s6_interact_demp_2", 1, 0, 1);
			level.var_ffda9f5d = level.var_ffda9f5d + 1;
			break;
		}
		case 2:
		{
			e_player namespace_509a75d1::function_51b752a9("vox_s6_interact_demp_3", 0, 0, 1);
			level.var_170ea961 namespace_509a75d1::function_6a0d675d("vox_s6_interact_demp_3", 1, 0, 1);
			level.var_ffda9f5d = level.var_ffda9f5d + 1;
			break;
		}
		case 3:
		{
			level.var_170ea961 namespace_509a75d1::function_6a0d675d("vox_s6_interact_demp_4", 0, 0, 1);
			e_player namespace_509a75d1::function_51b752a9("vox_s6_interact_demp_4", 1, 0, 1);
			level.var_ffda9f5d = level.var_ffda9f5d + 1;
			break;
		}
		case 4:
		{
			e_player namespace_509a75d1::function_51b752a9("vox_s6_interact_demp_5", 0, 0, 1);
			level.var_170ea961 namespace_509a75d1::function_6a0d675d("vox_s6_interact_demp_5", 1, 0, 1);
			level.var_ffda9f5d = level.var_ffda9f5d + 1;
			break;
		}
	}
}

/*
	Name: function_cdcaffd1
	Namespace: namespace_3e3742fd
	Checksum: 0xF0BF68BD
	Offset: 0x137A8
	Size: 0xCC
	Parameters: 2
	Flags: None
*/
function function_cdcaffd1(var_88206a50, ent)
{
	vol_test = getent(var_88206a50.target, "targetname");
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && ent istouching(vol_test);
}

/*
	Name: mannequin_activate
	Namespace: namespace_3e3742fd
	Checksum: 0xE32F1B18
	Offset: 0x13880
	Size: 0x680
	Parameters: 1
	Flags: Linked
*/
function mannequin_activate(n_difficulty)
{
	self.is_active = 1;
	self.is_complete = 0;
	while(!self.is_complete)
	{
		e_body = getent(self.script_string + "_body", "script_noteworthy");
		e_body clientfield::set("fx8_quest_mannequin_initial_sparks", 1);
		e_head = getent(self.script_string + "_head", "script_noteworthy");
		e_head unlink();
		e_head playsound(#"hash_55bcb314f29d9b");
		/#
			str_zone = zm_zonemgr::get_zone_from_position(e_head.origin, 1);
			waitframe(1);
			if(level flag::get("") && isdefined(str_zone))
			{
				debug2dtext((720, 135, 0), "" + str_zone + "", (1, 1, 0), 1, (0, 0, 0), 0.5, 1, 1000);
			}
		#/
		self zm_unitrigger::create(&function_b7afb313, 64);
		self thread function_a728dd4c();
		self waittill(#"hash_c03409dbf4f2cb9");
		e_body clientfield::set("fx8_quest_mannequin_initial_sparks", 0);
		self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
		e_head rotateroll(-20, 0.1);
		playsoundatposition(#"hash_55bcb314f29d9b", e_head.origin);
		wait(1);
		if(level.var_46829c80 === 0)
		{
			level.var_46829c80 = 1;
			level namespace_509a75d1::function_3c173d37();
			if(isdefined(level.var_f7acb793))
			{
				level.var_f7acb793 thread namespace_509a75d1::function_51b752a9("vox_s6_interact", 0, 0);
			}
		}
		/#
			iprintlnbold("");
		#/
		e_tag = util::spawn_model("tag_origin", e_body gettagorigin("tag_torso"));
		e_tag clientfield::set("fx8_quest_mannequin_charging", 1);
		self mannequin_defend(n_difficulty);
		level flag::clear(#"infinite_round_spawning");
		level flag::clear(#"pause_round_timeout");
		level.a_func_score_events[#"damage_points"] = undefined;
		level.a_func_score_events[#"death"] = undefined;
		level.var_382a24b0 = undefined;
		var_dc3827e3 = getentarray(self.script_string + "_block", "targetname");
		level exploder::stop_exploder(var_dc3827e3[0].script_string);
		foreach(e_blocker in var_dc3827e3)
		{
			e_blocker notsolid();
		}
		e_tag clientfield::set("fx8_quest_mannequin_charging", 0);
		if(self.is_complete)
		{
			e_body zm_vo::function_57b8cd17();
			level.var_7d57cb9d = level.var_7d57cb9d + 1;
			e_tag clientfield::set("fx8_quest_mannequin_explode_main", 1);
			e_collision = getent(self.script_string + "_collision", "targetname");
			e_collision delete();
			e_body delete();
			e_head delete();
			if(level.registerstalactite_kill_zone_waypoint_ === 0)
			{
				level.registerstalactite_kill_zone_waypoint_ = 1;
				level namespace_509a75d1::function_3c173d37();
				level thread namespace_509a75d1::function_fd24e47f("vox_s6_adam_first", 0, 0);
			}
			level function_62156542(self.script_string);
		}
		else
		{
			e_head rotateroll(20, 0.1);
		}
	}
}

/*
	Name: function_a728dd4c
	Namespace: namespace_3e3742fd
	Checksum: 0x9FEFD782
	Offset: 0x13F08
	Size: 0x132
	Parameters: 0
	Flags: Linked
*/
function function_a728dd4c()
{
	self endon(#"hash_c03409dbf4f2cb9");
	while(true)
	{
		s_activation = undefined;
		s_activation = self waittill(#"trigger_activated");
		if(self.zone == "zone_hoggatt_house")
		{
			n_players = zm_zonemgr::get_players_in_zone(self.zone) + zm_zonemgr::get_players_in_zone("zone_solitary");
			if(n_players == level.players.size)
			{
				level.var_f7acb793 = s_activation.e_who;
				self notify(#"hash_c03409dbf4f2cb9");
			}
		}
		else if(zm_zonemgr::get_players_in_zone(self.zone) == level.players.size)
		{
			level.var_f7acb793 = s_activation.e_who;
			self notify(#"hash_c03409dbf4f2cb9");
		}
	}
}

/*
	Name: function_b7afb313
	Namespace: namespace_3e3742fd
	Checksum: 0x4BD8BF35
	Offset: 0x14048
	Size: 0x1F0
	Parameters: 1
	Flags: Linked
*/
function function_b7afb313(e_player)
{
	if(self.is_active === 0)
	{
		return 0;
	}
	if(self.stub.related_parent.zone == "zone_hoggatt_house")
	{
		n_players = zm_zonemgr::get_players_in_zone(self.stub.related_parent.zone) + zm_zonemgr::get_players_in_zone("zone_solitary");
		if(n_players == level.players.size)
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_47763d747e9c35d7");
				return 1;
			}
			self sethintstring(#"hash_430c860d7d1f2c49");
			return 1;
		}
		self sethintstring(#"hash_32fa112e9fe55d3f");
		return 1;
	}
	if(zm_zonemgr::get_players_in_zone(self.stub.related_parent.zone) == level.players.size)
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_47763d747e9c35d7");
			return 1;
		}
		self sethintstring(#"hash_430c860d7d1f2c49");
		return 1;
	}
	self sethintstring(#"hash_32fa112e9fe55d3f");
	return 1;
}

/*
	Name: function_32c317fb
	Namespace: namespace_3e3742fd
	Checksum: 0xDF28B35
	Offset: 0x14248
	Size: 0x220
	Parameters: 0
	Flags: Linked
*/
function function_32c317fb()
{
	var_22f19cbb = level.var_22f19cbb;
	foreach(s_mannequin in var_22f19cbb)
	{
		sc = s_mannequin.script_string;
		e_head = getent(sc + "_head", "script_noteworthy");
		e_body = getent(sc + "_body", "script_noteworthy");
		e_collision = getent(sc + "_collision", "targetname");
		if(isdefined(e_head) && isdefined(e_body) && isdefined(e_collision))
		{
			e_head hide();
			e_body hide();
			e_collision notsolid();
		}
		var_67830325 = struct::get(sc + "_part_trigger", "targetname");
		if(isdefined(var_67830325) && isdefined(var_67830325.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(var_67830325.s_unitrigger);
		}
		s_mannequin.is_active = 0;
		if(isdefined(s_mannequin.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(s_mannequin.s_unitrigger);
		}
	}
}

/*
	Name: mannequin_defend
	Namespace: namespace_3e3742fd
	Checksum: 0x5A5B580B
	Offset: 0x14470
	Size: 0x25A
	Parameters: 1
	Flags: Linked
*/
function mannequin_defend(n_difficulty)
{
	self endon(#"hash_406e88e2ddaa3ffa");
	self thread function_578194a0();
	var_dc3827e3 = getentarray(self.script_string + "_block", "targetname");
	level exploder::exploder(var_dc3827e3[0].script_string);
	foreach(e_blocker in var_dc3827e3)
	{
		e_blocker solid();
		e_blocker playsound(#"hash_3faa335fd02a531");
	}
	level.musicsystemoverride = 1;
	music::setmusicstate("mannequin_defend");
	level flag::set(#"infinite_round_spawning");
	level flag::set(#"pause_round_timeout");
	level.var_382a24b0 = 1;
	level.a_func_score_events[#"damage_points"] = &function_ea6f0b51;
	level.a_func_score_events[#"death"] = &function_3ee2b1c3;
	self thread function_57bc4d0a();
	self function_c23eba78(n_difficulty);
	level.musicsystemoverride = 0;
	music::setmusicstate("none");
	self.is_complete = 1;
}

/*
	Name: function_ea6f0b51
	Namespace: namespace_3e3742fd
	Checksum: 0x6162BC80
	Offset: 0x146D8
	Size: 0x2E
	Parameters: 5
	Flags: Linked
*/
function function_ea6f0b51(event, mod, hit_location, zombie_team, damage_weapon)
{
	return 0;
}

/*
	Name: function_3ee2b1c3
	Namespace: namespace_3e3742fd
	Checksum: 0x22DD543A
	Offset: 0x14710
	Size: 0x30
	Parameters: 5
	Flags: Linked
*/
function function_3ee2b1c3(event, mod, hit_location, zombie_team, damage_weapon)
{
	return 10;
}

/*
	Name: function_57bc4d0a
	Namespace: namespace_3e3742fd
	Checksum: 0x99FF813C
	Offset: 0x14748
	Size: 0x12E
	Parameters: 0
	Flags: Linked
*/
function function_57bc4d0a()
{
	self endon(#"hash_406e88e2ddaa3ffa");
	e_body = getent(self.script_string + "_body", "script_noteworthy");
	for(i = 0; i < 5; i++)
	{
		wait(8);
		if(level.var_809c1579.size == 0)
		{
			for(i = 0; i < 15; i++)
			{
				level.var_809c1579[i] = i;
			}
		}
		var_e7af51e9 = array::random(level.var_809c1579);
		if(isdefined(e_body))
		{
			e_body namespace_509a75d1::function_6a0d675d("vox_s6_non_sequiturs_adam", var_e7af51e9);
		}
		arrayremovevalue(level.var_809c1579, var_e7af51e9);
	}
}

/*
	Name: function_c1407d2b
	Namespace: namespace_3e3742fd
	Checksum: 0x538786C
	Offset: 0x14880
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function function_c1407d2b(s_params)
{
	if(self.archetype === #"zombie" && level.var_2b5d31d8 > level.var_8dc9db8d)
	{
		if(namespace_c3287616::function_40229072(namespace_a28acff3::get_round_number()))
		{
			level.zombie_total = level.zombie_total - 1;
		}
		level.var_8dc9db8d = level.var_8dc9db8d + 1;
	}
}

/*
	Name: function_578194a0
	Namespace: namespace_3e3742fd
	Checksum: 0x5FB890E8
	Offset: 0x14920
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_578194a0()
{
	self endon(#"hash_406e88e2ddaa3ffa");
	while(self.is_complete === 0)
	{
		if(self.zone == "zone_yellow_backyard")
		{
			if(zm_zonemgr::get_players_in_zone(self.zone) + zm_zonemgr::get_players_in_zone("zone_ammo_door") < level.players.size)
			{
				self notify(#"hash_406e88e2ddaa3ffa");
			}
		}
		else if(self.zone == "zone_hoggatt_house")
		{
			n_players = zm_zonemgr::get_players_in_zone(self.zone) + zm_zonemgr::get_players_in_zone("zone_solitary");
			if(n_players < level.players.size)
			{
				self notify(#"hash_406e88e2ddaa3ffa");
			}
		}
		else if(zm_zonemgr::get_players_in_zone(self.zone) < level.players.size)
		{
			self notify(#"hash_406e88e2ddaa3ffa");
		}
		wait(1);
	}
}

/*
	Name: function_c23eba78
	Namespace: namespace_3e3742fd
	Checksum: 0x7A14C1F6
	Offset: 0x14A88
	Size: 0x19C
	Parameters: 1
	Flags: Linked
*/
function function_c23eba78(n_difficulty)
{
	level.var_2b5d31d8 = 0;
	if(getplayers().size > 2)
	{
		n_spawns = 95 + n_difficulty * 34;
	}
	else if(getplayers().size > 1)
	{
		n_spawns = 72 + n_difficulty * 26;
	}
	else
	{
		n_spawns = 52 + n_difficulty * 21;
	}
	n_wait = 45 / n_spawns;
	callback::on_ai_killed(&function_c1407d2b);
	for(i = 0; i < n_spawns; i++)
	{
		ai = undefined;
		if(zombie_utility::get_current_zombie_count() < 24)
		{
			ai = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0]);
		}
		if(isdefined(ai))
		{
			level.zombie_total = level.zombie_total + 1;
			level.var_2b5d31d8 = level.var_2b5d31d8 + 1;
		}
		wait(n_wait);
	}
	level thread function_878be53d();
}

/*
	Name: function_878be53d
	Namespace: namespace_3e3742fd
	Checksum: 0x21098BB9
	Offset: 0x14C30
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_878be53d()
{
	while(level.var_2b5d31d8 > level.var_8dc9db8d)
	{
		wait(1);
	}
	callback::remove_on_ai_killed(&function_c1407d2b);
}

/*
	Name: function_f0915ac7
	Namespace: namespace_3e3742fd
	Checksum: 0xFB8736EE
	Offset: 0x14C88
	Size: 0x132
	Parameters: 1
	Flags: None
*/
function function_f0915ac7(str_zone)
{
	var_dce50d83 = [];
	foreach(s_spawn in level.zm_loc_types[#"zombie_location"])
	{
		if(s_spawn.zone_name === str_zone)
		{
			if(!isdefined(var_dce50d83))
			{
				var_dce50d83 = [];
			}
			else if(!isarray(var_dce50d83))
			{
				var_dce50d83 = array(var_dce50d83);
			}
			if(!isinarray(var_dce50d83, s_spawn))
			{
				var_dce50d83[var_dce50d83.size] = s_spawn;
			}
		}
	}
	if(var_dce50d83.size > 0)
	{
		return array::random(var_dce50d83);
	}
	return undefined;
}

/*
	Name: function_3bdbb583
	Namespace: namespace_3e3742fd
	Checksum: 0x4E96E4DA
	Offset: 0x14DC8
	Size: 0x2A4
	Parameters: 2
	Flags: None
*/
function function_3bdbb583(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = 20;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = 15;
	}
	else
	{
		n_souls_required = 10;
	}
	level.n_captured++;
	/#
		if(level flag::get(#"hash_6dcc421d5fbf8d22"))
		{
			level.n_captured = n_souls_required;
		}
	#/
	if(level.n_captured >= n_souls_required)
	{
		var_f0e6c7a2.charged = 1;
		namespace_617a54f4::function_2a94055d(var_f0e6c7a2.script_string);
		level.n_captured = 0;
		e_head = getent(var_f0e6c7a2.script_string + "_head", "script_noteworthy");
		e_body = getent(var_f0e6c7a2.script_string + "_body", "script_noteworthy");
		e_collision = getent(var_f0e6c7a2.script_string + "_collision", "targetname");
		e_collision delete();
		e_body delete();
		e_head delete();
		level function_62156542(var_f0e6c7a2.script_string);
	}
	var_c286216d = n_souls_required - level.n_captured;
	debug2dtext((720, 155, 0), "" + var_c286216d, (1, 1, 0), 1, (0, 0, 0), 0.5, 1, 40);
}

/*
	Name: function_62156542
	Namespace: namespace_3e3742fd
	Checksum: 0xBF8F7B66
	Offset: 0x15078
	Size: 0x192
	Parameters: 1
	Flags: Linked
*/
function function_62156542(str_identifier)
{
	e_part = getent(str_identifier + "_part", "targetname");
	e_part show();
	var_67830325 = struct::get(str_identifier + "_part_trigger", "targetname");
	var_67830325 thread function_57dda4d1(str_identifier);
	switch(level.var_7d57cb9d)
	{
		case 1:
		{
			e_part setmodel("p8_fxanim_zm_white_mccain_mannequin_pickup_arm_left");
			var_67830325.type = #"left";
			break;
		}
		case 2:
		{
			e_part setmodel("p8_fxanim_zm_white_mccain_mannequin_pickup_arm_right");
			var_67830325.type = #"right";
			break;
		}
		case 3:
		{
			e_part setmodel("p8_fxanim_zm_white_mccain_mannequin_pickup_head");
			var_67830325.type = #"head";
			break;
		}
	}
}

/*
	Name: function_57dda4d1
	Namespace: namespace_3e3742fd
	Checksum: 0xACEC490F
	Offset: 0x15218
	Size: 0x138
	Parameters: 1
	Flags: Linked
*/
function function_57dda4d1(str_identifier)
{
	var_4c61c984 = 0;
	while(!var_4c61c984)
	{
		s_activation = undefined;
		s_activation = self waittill(#"trigger_activated");
		level zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
		e_who = s_activation.e_who;
		level.var_247a1d9f = level.var_247a1d9f + 1;
		level thread function_9840ec4a(self.type, e_who);
		e_part = getent(str_identifier + "_part", "targetname");
		playsoundatposition(#"hash_63bd968c7e332594", e_part.origin);
		e_part delete();
		var_4c61c984 = 1;
	}
}

/*
	Name: function_9840ec4a
	Namespace: namespace_3e3742fd
	Checksum: 0x1BA3A43A
	Offset: 0x15358
	Size: 0x16C
	Parameters: 2
	Flags: Linked
*/
function function_9840ec4a(str_type, e_who)
{
	if(str_type == #"left")
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_arm_first", 0, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		e_who namespace_509a75d1::function_51b752a9("vox_s6_arm_first", 1, 0, 1);
	}
	else if(str_type == #"right")
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_54913642eec90b94", 0, 0);
	}
	else if(str_type == #"head")
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_54009014235efa5d", 0, 0);
	}
}

/*
	Name: function_553ec923
	Namespace: namespace_3e3742fd
	Checksum: 0x97938FE5
	Offset: 0x154D0
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_553ec923(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_s6_locate", 0, 0, 1);
		level namespace_509a75d1::function_314447b(0);
		level thread function_b0b7e8a9();
		level namespace_509a75d1::function_3c173d37();
		namespace_509a75d1::function_fd24e47f("vox_s6_locate", 1, 0, 1);
		level flag::wait_till(#"hash_7e4bffd972b5993a");
	}
}

/*
	Name: function_b0b7e8a9
	Namespace: namespace_3e3742fd
	Checksum: 0xCCC97491
	Offset: 0x155C0
	Size: 0x788
	Parameters: 0
	Flags: Linked
*/
function function_b0b7e8a9()
{
	level flag::set(#"hash_7c2ae917559738ec");
	var_fa20d93d = function_21a3a673(0, 2);
	str_start = "number_line_start_" + var_fa20d93d;
	str_start_trigger = "equation_" + var_fa20d93d;
	var_d93ca8ec = getent("enumerator", "targetname");
	var_ce68e849 = util::spawn_model("tag_origin", var_d93ca8ec.origin);
	nd_start = getvehiclenode(str_start, "targetname");
	var_ef55363f = getent("denominator", "targetname");
	if(isdefined(var_ce68e849) && isdefined(nd_start) && isdefined(var_ef55363f))
	{
		vh_wisp = spawner::simple_spawn_single(getent("vinculum", "targetname"));
		while(!isdefined(vh_wisp))
		{
			waitframe(1);
		}
		vh_wisp.origin = nd_start.origin;
		vh_wisp.angles = nd_start.angles;
		vh_wisp setspeed(7.5);
		var_ce68e849.origin = nd_start.origin;
		var_ce68e849.angles = nd_start.angles;
		var_ce68e849 linkto(vh_wisp);
		var_ef55363f.origin = nd_start.origin;
		var_ef55363f.angles = nd_start.angles;
		var_ef55363f enablelinkto();
		var_ef55363f linkto(vh_wisp);
		vh_wisp val::set(#"hash_168ff55413401523", "takedamage", 0);
		vh_wisp.var_ce68e849 = var_ce68e849;
		vh_wisp.var_ef55363f = var_ef55363f;
		vh_wisp thread function_f5c6352d();
		vh_wisp thread function_396b3f90();
		var_f8b0325d = array(#"hash_7e4bffd972b5993a", #"hash_3972ecbdd044ba98");
		var_fae5a971 = namespace_a28acff3::get_round_number();
		var_9d62fe6f = getent(str_start_trigger, "targetname");
		if(isdefined(var_9d62fe6f))
		{
			while(!level flag::get(#"hash_7e4bffd972b5993a"))
			{
				if(namespace_a28acff3::get_round_number() >= var_fae5a971)
				{
					vh_wisp vehicle::get_on_path(nd_start);
					vh_wisp clientfield::set("fx8_power_wisp_lg", 1);
					var_c299518b = 0;
					a_e_players = getplayers();
					var_19092d6b = undefined;
					foreach(e_player in a_e_players)
					{
						if(e_player istouching(var_9d62fe6f))
						{
							var_c299518b = 1;
							var_19092d6b = e_player;
						}
					}
					if(var_c299518b)
					{
						vh_wisp.var_38f957e = undefined;
						level.var_bf68ff1f = level.var_bf68ff1f + 1;
						level thread function_c9dea1af(var_19092d6b);
						vh_wisp vehicle::resume_path();
						vh_wisp thread vehicle::get_on_and_go_path(nd_start);
						vh_wisp thread function_1ac25ead();
						vh_wisp thread function_3ce3c949();
						level flag::set(#"infinite_round_spawning");
						level flag::set(#"pause_round_timeout");
						level.var_382a24b0 = 1;
						level flag::wait_till_any(var_f8b0325d);
						level flag::clear(#"infinite_round_spawning");
						level flag::clear(#"pause_round_timeout");
						level.var_382a24b0 = 0;
						if(level flag::get(#"hash_7e4bffd972b5993a"))
						{
							if(isdefined(var_ce68e849))
							{
								var_ce68e849 delete();
								var_ce68e849 = undefined;
							}
							vh_wisp setspeed(16, 5);
							vh_wisp waittill(#"hash_29bd16047c62e452");
							vh_wisp clientfield::set("fx8_power_wisp_lg", 0);
						}
						else if(namespace_a28acff3::get_round_number() >= var_fae5a971)
						{
							level thread function_53851722();
						}
						var_fae5a971 = namespace_a28acff3::get_round_number() + 1;
						/#
							iprintlnbold("");
						#/
						level flag::clear(#"hash_3972ecbdd044ba98");
						vh_wisp clientfield::set("fx8_power_wisp_lg", 0);
						if(isdefined(var_ce68e849))
						{
							var_ce68e849 delete();
							var_ce68e849 = undefined;
						}
					}
				}
				wait(0.25);
			}
		}
	}
}

/*
	Name: function_3ce3c949
	Namespace: namespace_3e3742fd
	Checksum: 0x9160151D
	Offset: 0x15D50
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_3ce3c949()
{
	level endon(#"hash_7e4bffd972b5993a", #"hash_3972ecbdd044ba98", #"hash_66be0eea77b87d58");
	var_7b286c7b = 0;
	n_speed = 6;
	if(isdefined(self.var_ef55363f))
	{
		while(var_7b286c7b < 40)
		{
			a_e_players = getplayers();
			var_c299518b = 0;
			foreach(e_player in a_e_players)
			{
				if(e_player istouching(self.var_ef55363f))
				{
					var_c299518b = 1;
				}
			}
			if(var_c299518b)
			{
				if(n_speed < 9)
				{
					n_speed = n_speed + 0.5;
					self setspeed(n_speed);
				}
				var_7b286c7b = 0;
			}
			else if(n_speed > 0)
			{
				n_speed = n_speed - 0.5;
				self setspeed(n_speed);
			}
			var_7b286c7b = var_7b286c7b + 1;
			wait(0.25);
		}
		level flag::set(#"hash_3972ecbdd044ba98");
	}
}

/*
	Name: function_1ac25ead
	Namespace: namespace_3e3742fd
	Checksum: 0x1EC52FA5
	Offset: 0x15F30
	Size: 0x2BA
	Parameters: 0
	Flags: Linked
*/
function function_1ac25ead()
{
	level endon(#"hash_7e4bffd972b5993a", #"hash_3972ecbdd044ba98", #"hash_66be0eea77b87d58");
	self endon(#"hash_441968a3de2cf6a5");
	while(true)
	{
		wait(2);
		if(isdefined(self.var_38f957e))
		{
			str_zone = self.var_38f957e;
			var_eb3b90d = [];
			if(isdefined(str_zone) && level.zones[str_zone].a_loc_types[#"zombie_location"].size > 0)
			{
				var_eb3b90d = level.zones[str_zone].a_loc_types[#"zombie_location"];
			}
			else
			{
				var_eb3b90d = level.zm_loc_types[#"zombie_location"];
			}
			if(getplayers().size > 2)
			{
				n_enemies = 5;
			}
			else if(getplayers().size > 2)
			{
				n_enemies = 3;
			}
			else
			{
				n_enemies = 2;
			}
			for(i = 0; i < n_enemies; i++)
			{
				ai = undefined;
				if(zombie_utility::get_current_zombie_count() < 24)
				{
					if(var_eb3b90d.size > 0)
					{
						s_spawn_point = array::random(var_eb3b90d);
						ai = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0], undefined, s_spawn_point);
					}
					else
					{
						ai = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0]);
					}
				}
				if(isdefined(ai))
				{
					level.zombie_total = level.zombie_total + 1;
					ai zm_score::function_acaab828(1);
					ai zombie_utility::set_zombie_run_cycle("super_sprint");
				}
				wait(0.1);
			}
		}
	}
}

/*
	Name: function_396b3f90
	Namespace: namespace_3e3742fd
	Checksum: 0xEB5AAB99
	Offset: 0x161F8
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_396b3f90()
{
	self endon(#"hash_441968a3de2cf6a5");
	while(true)
	{
		if(isdefined(self.currentnode) && isdefined(self.currentnode.script_noteworthy))
		{
			self.var_38f957e = self.currentnode.script_noteworthy;
		}
		wait(0.1);
	}
}

/*
	Name: function_f5c6352d
	Namespace: namespace_3e3742fd
	Checksum: 0xA5F5B5FD
	Offset: 0x16268
	Size: 0x2DC
	Parameters: 0
	Flags: Linked
*/
function function_f5c6352d()
{
	self waittill(#"hash_441968a3de2cf6a5");
	level notify(#"hash_66be0eea77b87d58");
	level flag::set(#"hash_66be0eea77b87d58");
	self setspeedimmediate(0);
	wait(2);
	playsoundatposition(#"hash_6307f5c481951f36", (0, 0, 0));
	foreach(e_player in getplayers())
	{
		e_player thread lui::screen_flash(0.2, 0.5, 1, 1, "white", undefined, 1);
	}
	level exploder::exploder("fxexp_chair_scorch");
	getent("atlas_ct", "targetname") hide();
	level.var_170ea961 = self;
	level.var_170ea961.name = "mcca";
	level.var_170ea961.isspeaking = 0;
	level.var_170ea961.var_5b6ebfd0 = 0;
	wait(1);
	level namespace_509a75d1::function_3c173d37();
	level namespace_509a75d1::function_314447b(1, 0);
	self namespace_509a75d1::function_6a0d675d("vox_s6_free", 0, 0);
	level namespace_509a75d1::function_3c173d37();
	namespace_509a75d1::function_fd24e47f("vox_s6_free", 1, 0);
	level namespace_509a75d1::function_3c173d37();
	self namespace_509a75d1::function_6a0d675d("vox_s6_free", 2, 0);
	level flag::set(#"hash_7e4bffd972b5993a");
}

/*
	Name: function_53851722
	Namespace: namespace_3e3742fd
	Checksum: 0x9B1BE407
	Offset: 0x16550
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function function_53851722()
{
	var_e87b2b1e = [];
	for(i = 0; i < level.var_1fed619f.size; i++)
	{
		if(level.var_1fed619f[i] === 0)
		{
			if(!isdefined(var_e87b2b1e))
			{
				var_e87b2b1e = [];
			}
			else if(!isarray(var_e87b2b1e))
			{
				var_e87b2b1e = array(var_e87b2b1e);
			}
			var_e87b2b1e[var_e87b2b1e.size] = i;
		}
	}
	if(var_e87b2b1e.size == 0)
	{
		for(i = 0; i < 5; i++)
		{
			level.var_1fed619f[i] = 0;
			if(!isdefined(var_e87b2b1e))
			{
				var_e87b2b1e = [];
			}
			else if(!isarray(var_e87b2b1e))
			{
				var_e87b2b1e = array(var_e87b2b1e);
			}
			var_e87b2b1e[var_e87b2b1e.size] = i;
		}
	}
	var_32060833 = array::random(var_e87b2b1e);
	level.var_1fed619f[var_32060833] = 1;
	level namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_s6_fail", var_32060833, 0);
}

/*
	Name: function_c9dea1af
	Namespace: namespace_3e3742fd
	Checksum: 0x422D49E
	Offset: 0x16708
	Size: 0x2E4
	Parameters: 1
	Flags: Linked
*/
function function_c9dea1af(e_who)
{
	if(level.var_bf68ff1f == 1)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_s6_escort", 0, 0);
		level namespace_509a75d1::function_3c173d37();
		e_who namespace_509a75d1::function_51b752a9("vox_s6_escort", 1, 0, 1);
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_s6_escort", 2, 0, 1);
	}
	else if(level.var_bf68ff1f == 2)
	{
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_s6_escort_second", 0, 0);
	}
	else
	{
		var_ab2d294c = [];
		for(i = 0; i < level.var_2751df72.size; i++)
		{
			if(level.var_2751df72[i] === 0)
			{
				if(!isdefined(var_ab2d294c))
				{
					var_ab2d294c = [];
				}
				else if(!isarray(var_ab2d294c))
				{
					var_ab2d294c = array(var_ab2d294c);
				}
				var_ab2d294c[var_ab2d294c.size] = i;
			}
		}
		if(var_ab2d294c.size == 0)
		{
			for(i = 1; i < 5; i++)
			{
				level.var_2751df72[i] = 0;
				if(!isdefined(var_ab2d294c))
				{
					var_ab2d294c = [];
				}
				else if(!isarray(var_ab2d294c))
				{
					var_ab2d294c = array(var_ab2d294c);
				}
				var_ab2d294c[var_ab2d294c.size] = i;
			}
		}
		var_32060833 = array::random(var_ab2d294c);
		level.var_2751df72[var_32060833] = 1;
		level namespace_509a75d1::function_3c173d37();
		level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_s6_escort_second", var_32060833, 0);
	}
}

/*
	Name: function_b7fa863b
	Namespace: namespace_3e3742fd
	Checksum: 0xE76C3E3F
	Offset: 0x169F8
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_b7fa863b(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		getent("enumerator", "targetname") delete();
		level flag::set(#"hash_12854365001ac5c");
	}
	else
	{
		getent("enumerator", "targetname") delete();
	}
}

/*
	Name: function_cae70bde
	Namespace: namespace_3e3742fd
	Checksum: 0x417880F6
	Offset: 0x16AB8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_cae70bde()
{
	level flag::clear(#"mq_computer_activated");
	level.var_7be97400 zm_unitrigger::create(&function_f0b3b2d9, 64);
	level.var_7be97400 thread function_8b294c5a();
}

/*
	Name: function_f0b3b2d9
	Namespace: namespace_3e3742fd
	Checksum: 0xA87EFB50
	Offset: 0x16B30
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_f0b3b2d9(e_player)
{
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_2273a91e3516122a");
		return 1;
	}
	self sethintstring(#"hash_67e3bd58716e5f3e");
	return 1;
}

/*
	Name: function_8b294c5a
	Namespace: namespace_3e3742fd
	Checksum: 0xC12DDB13
	Offset: 0x16BA8
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_8b294c5a()
{
	while(!level flag::get(#"mq_computer_activated"))
	{
		results = undefined;
		results = self waittill(#"trigger_activated");
		level.var_fa22c7ec = results.e_who;
		level flag::set(#"mq_computer_activated");
		playsoundatposition("evt_computer_interact", self.origin);
	}
	self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: function_63e4838b
	Namespace: namespace_3e3742fd
	Checksum: 0xDDFFE7F6
	Offset: 0x16C78
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_63e4838b(should_hide = 1)
{
	level.var_7be97400.var_60b0e76f = should_hide;
}

/*
	Name: function_bf3779ea
	Namespace: namespace_3e3742fd
	Checksum: 0x293DD1B0
	Offset: 0x16CB8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_bf3779ea(e_player)
{
	return level.var_7be97400.var_60b0e76f !== 1;
}

/*
	Name: function_195cb69e
	Namespace: namespace_3e3742fd
	Checksum: 0x22CD7F3B
	Offset: 0x16CE8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_195cb69e()
{
	var_44d45b15 = struct::get("server_operations", "targetname");
	var_5b23b004 = struct::get("server_powerhouse", "targetname");
	var_44d45b15 function_1d92fe23();
	var_5b23b004 function_1d92fe23();
}

/*
	Name: function_1d92fe23
	Namespace: namespace_3e3742fd
	Checksum: 0x5EDAB6E2
	Offset: 0x16D78
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_1d92fe23()
{
	self scene::play("init");
	var_64460018 = self.scene_ents[#"hash_5a2b3ebf98bd6695"];
	var_64460018 thread function_368d1b4d();
}

/*
	Name: function_5f6e4e8f
	Namespace: namespace_3e3742fd
	Checksum: 0xBCF59A81
	Offset: 0x16DE0
	Size: 0x2B2
	Parameters: 2
	Flags: Linked
*/
function function_5f6e4e8f(var_cb672d5f, var_8208d890)
{
	var_64460018 = self.scene_ents[#"hash_5a2b3ebf98bd6695"];
	switch(var_cb672d5f)
	{
		case "init":
		{
			self thread scene::play("init");
			break;
		}
		case "opening_withpart":
		{
			self thread scene::play("opening_withpart");
			break;
		}
		case "removepart_close":
		{
			self thread scene::play("removepart_close");
			break;
		}
		case "closed_nopart":
		{
			self thread scene::play("closed_nopart");
			break;
		}
		case "open_nopart":
		{
			self thread scene::play("open_nopart");
			break;
		}
		case "addpart_close":
		{
			self thread scene::play("addpart_close");
			break;
		}
		case "closed_withpart":
		{
			self thread scene::play("closed_withpart");
			break;
		}
		case "open_withpart":
		{
			self thread scene::play("open_withpart");
			break;
		}
		case "opening_nopart":
		{
			self thread scene::play("opening_nopart");
			break;
		}
		case "closing_nopart":
		{
			self thread scene::play("closing_nopart");
			break;
		}
		default:
		{
			break;
		}
	}
	switch(var_8208d890)
	{
		case "lights_timer_off":
		{
			var_64460018 function_368d1b4d();
			break;
		}
		case "lights_timer_start":
		{
			var_64460018 function_f83e4a7d();
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_368d1b4d
	Namespace: namespace_3e3742fd
	Checksum: 0x8A3E26B7
	Offset: 0x170A0
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function function_368d1b4d()
{
	self.var_c223238f = 0;
	for(i = 0; i <= 15; i++)
	{
		if(i < 10)
		{
			self hidepart("tag_led_0" + i);
			continue;
		}
		self hidepart("tag_led_" + i);
	}
}

/*
	Name: function_f83e4a7d
	Namespace: namespace_3e3742fd
	Checksum: 0x47C242F
	Offset: 0x17130
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_f83e4a7d()
{
	for(i = 0; i <= 15; i++)
	{
		if(i < 10)
		{
			self showpart("tag_led_0" + i);
			continue;
		}
		self showpart("tag_led_" + i);
	}
	self.var_c223238f = 1;
	self thread function_a0968d2c();
}

/*
	Name: function_a0968d2c
	Namespace: namespace_3e3742fd
	Checksum: 0x123F83B6
	Offset: 0x171D8
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_a0968d2c()
{
	for(var_22b38470 = 0; var_22b38470 <= 15 && self.var_c223238f == 1; var_22b38470++)
	{
		if(var_22b38470 < 10)
		{
			self hidepart("tag_led_0" + var_22b38470);
			continue;
		}
		self hidepart("tag_led_" + var_22b38470);
		wait(0.8);
	}
}

/*
	Name: portal_map_to_nuclear_state
	Namespace: namespace_3e3742fd
	Checksum: 0xD46EE969
	Offset: 0x17278
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function portal_map_to_nuclear_state()
{
	clientfield::set("portal_map_to_nuclear_state", 1);
}

