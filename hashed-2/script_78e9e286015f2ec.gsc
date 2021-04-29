// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2da1a66a13e2bbe1;
#using script_2f877a0752174fc1;
#using script_3f9e0dc8454d98e1;
#using script_6a3f43063dfd1bdc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_7d8e6ec3;

/*
	Name: preload
	Namespace: namespace_7d8e6ec3
	Checksum: 0x20AEE9EC
	Offset: 0xB18
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	init_clientfields();
}

/*
	Name: init_clientfields
	Namespace: namespace_7d8e6ec3
	Checksum: 0xD342E2BD
	Offset: 0xB38
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("toplayer", "" + #"hash_33c373888aa78dc2", 20000, 1, "counter");
}

/*
	Name: init
	Namespace: namespace_7d8e6ec3
	Checksum: 0x249F1C3C
	Offset: 0xB88
	Size: 0x102C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init("keypad_debug");
	level.var_f13364b4 = struct::spawn();
	level.var_f13364b4.var_132bd718 = [];
	level.var_f13364b4.var_cf1f0c9 = 0;
	level.var_f13364b4.var_b1e1ac14 = 0;
	level.var_f13364b4.var_2329ffa1 = array("x", "x", "x", "x");
	level.var_f13364b4.var_d7813dfd = array("x", "x", "x", "x");
	level.var_f13364b4.var_12633dc5 = undefined;
	level.countdown_clock = struct::spawn();
	level.countdown_clock function_beeabfd2(0);
	level.countdown_clock function_eb17b80b();
	level.countdown_clock.var_4cdc88ae = 0;
	level thread function_45822b7e();
	if(zm_utility::function_e51dc2d8())
	{
		level.var_f13364b4.var_132bd718[2265] = {#hash_d9d9d617:&function_607f8829, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[2739] = {#hash_d9d9d617:&function_ff176ced, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[2652] = {#hash_d9d9d617:&function_95787ed2, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[7632] = {#hash_d9d9d617:&function_3887862d, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[3667] = {#hash_d9d9d617:&function_d89fe502, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[6662] = {#hash_d9d9d617:&function_ccbd2e6c, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[3279] = {#hash_d9d9d617:&function_ccbd2e6c, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[3255] = {#hash_d9d9d617:&function_48f83a1d, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[9277] = {#hash_d9d9d617:&function_f5468d9b, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[7433] = {#hash_d9d9d617:&function_addac768, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[6853] = {#hash_d9d9d617:&function_a7f962c9, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[4376] = {#hash_d9d9d617:&function_8e63da67, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[4728] = {#hash_d9d9d617:&function_b015442e, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[4867] = {#hash_d9d9d617:&function_7b716b93, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[8463] = {#hash_d9d9d617:&function_f4c88568, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[7836] = {#hash_d9d9d617:&function_23dac63d, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[2666] = {#hash_d9d9d617:&function_23dac63d, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[7225] = {#hash_d9d9d617:&function_9e9664bd, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[2582] = {#hash_d9d9d617:&function_8a9baa13, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[7283] = {#hash_d9d9d617:&function_8a9baa13, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[3825] = {#hash_d9d9d617:&function_bb800be7, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[7853] = {#hash_d9d9d617:&function_77085b, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[7664] = {#hash_d9d9d617:&function_8606278d, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[1841] = {#hash_d9d9d617:&function_b54f6326, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[8459] = {#hash_d9d9d617:&function_685d3dab, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[5653] = {#hash_d9d9d617:&function_7d008839, #hash_544c05c6:6};
		level.var_f13364b4.var_132bd718[9296] = {#hash_d9d9d617:&function_a823412a, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[1111] = {#hash_d9d9d617:&function_a823412a, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[8368] = {#hash_d9d9d617:&function_90dbeb67, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[7268] = {#hash_d9d9d617:&function_90dbeb67, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[5683] = {#hash_d9d9d617:&function_6755931f, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[5433] = {#hash_d9d9d617:&function_b94ecbd8, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[8333] = {#hash_d9d9d617:&function_ac121b1c, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[1] = {#hash_d9d9d617:&function_7e966dbe, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[2] = {#hash_d9d9d617:&function_9b96f239, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[3] = {#hash_d9d9d617:&function_c36b1f94, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[4] = {#hash_d9d9d617:&function_27d39a4f, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[1001] = {#hash_d9d9d617:&function_998eba45, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[1002] = {#hash_d9d9d617:&function_be76c1b8, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[1003] = {#hash_d9d9d617:&function_fadd27d6, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[1004] = {#hash_d9d9d617:&function_cd2168cb, #hash_544c05c6:1};
		level.var_f13364b4.var_132bd718[1005] = {#hash_d9d9d617:&function_6b002f3c, #hash_544c05c6:1};
		level thread function_6338402();
		level.var_f13364b4.var_8deb4ed2 = 7626;
		level.var_f13364b4.var_132bd718[level.var_f13364b4.var_8deb4ed2] = {#hash_d9d9d617:&function_c9dcb3aa, #hash_544c05c6:1};
		level.var_f13364b4.var_a7450be4 = function_4696e086(1, &function_69dd6c5b);
		level.var_f13364b4.var_72c3e48c = function_4696e086(1, &function_97ab5da4);
		level.var_f13364b4.var_98e79e76 = function_4696e086(1, &function_9a405843);
		level.var_f13364b4.var_3c358113 = function_4696e086(1, &function_7ddee93a);
		level.var_f13364b4.var_c8629019 = function_4696e086(1, &function_68dfeba9);
		level.var_f13364b4.var_becc7ced = function_4696e086(1, &function_68dfeba9);
		level.var_f13364b4.var_5beab72b = function_4696e086(1, &function_68dfeba9);
		level.var_d7e5aaac = array(level.var_f13364b4.var_8deb4ed2, level.var_f13364b4.var_a7450be4, level.var_f13364b4.var_72c3e48c, level.var_f13364b4.var_98e79e76, level.var_f13364b4.var_c8629019, level.var_f13364b4.var_becc7ced, level.var_f13364b4.var_5beab72b, level.var_f13364b4.var_3c358113);
		level thread function_ca3efcd8();
		function_7ee18649();
	}
	else if(!zm_utility::is_standard())
	{
		level thread function_ca3efcd8();
	}
}

/*
	Name: function_ca3efcd8
	Namespace: namespace_7d8e6ec3
	Checksum: 0x864A1C0F
	Offset: 0x1BC0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_ca3efcd8()
{
	level thread function_d83247cd();
	function_8fff2dd();
	var_369dd48c = array("mq_computer_activated", "keypad_debug");
	level function_31890499();
	level flag::wait_till_any(var_369dd48c);
	level.var_18f1ca6e thread function_6ef53601("style1");
	function_4da0eaff();
}

/*
	Name: function_4da0eaff
	Namespace: namespace_7d8e6ec3
	Checksum: 0x7CD34BC3
	Offset: 0x1C80
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_4da0eaff()
{
	level.var_f13364b4.s_keypad = struct::get("keypad");
	level.var_f13364b4.s_keypad zm_unitrigger::create("", 32);
	level.var_f13364b4.s_keypad thread function_44748fe7();
	zm_unitrigger::function_89380dda(level.var_f13364b4.s_keypad.s_unitrigger, 1);
	level.var_f13364b4.var_1a37ad02 = namespace_509a75d1::function_2719d4c0("keypad_keys", "targetname", "script_int");
	function_52838f02("keypad", 1);
	level function_9a2a7f26();
	if(zm_utility::function_e51dc2d8())
	{
		level.var_18f1ca6e thread function_cafaeead();
	}
}

/*
	Name: function_44748fe7
	Namespace: namespace_7d8e6ec3
	Checksum: 0x91A79CA8
	Offset: 0x1DC8
	Size: 0x190
	Parameters: 0
	Flags: Linked
*/
function function_44748fe7()
{
	level endon(#"hash_5157b4b2b1edc64e");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(!level.var_5dd0d3ff.isspeaking || level.var_f13364b4.var_e3d3636b === 1)
		{
			foreach(var_6f1036dd in level.var_f13364b4.var_1a37ad02)
			{
				var_48b3293c = var_6f1036dd.origin + anglestoup(var_6f1036dd.angles) * 0;
				if(zombie_utility::is_player_valid(e_who) && e_who function_bcec00bc(var_48b3293c, 8, 0))
				{
					function_f359c8a0(var_6f1036dd, e_who);
					break;
				}
			}
		}
	}
}

/*
	Name: function_bcec00bc
	Namespace: namespace_7d8e6ec3
	Checksum: 0x6AA14569
	Offset: 0x1F60
	Size: 0xB2
	Parameters: 4
	Flags: Linked
*/
function function_bcec00bc(origin, arc_angle_degrees = 90, do_trace, e_ignore = undefined)
{
	arc_angle_degrees = absangleclamp360(arc_angle_degrees);
	dot = cos(arc_angle_degrees * 0.5);
	if(self util::is_player_looking_at(origin, dot, do_trace, e_ignore))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_f359c8a0
	Namespace: namespace_7d8e6ec3
	Checksum: 0x3EA35E6A
	Offset: 0x2020
	Size: 0x482
	Parameters: 2
	Flags: Linked
*/
function function_f359c8a0(var_6f1036dd, e_player)
{
	e_player clientfield::increment_to_player("" + #"hash_33c373888aa78dc2", 1);
	level.var_f13364b4.var_12633dc5 = e_player;
	switch(var_6f1036dd.script_string)
	{
		case "number":
		{
			if(level.var_f13364b4.var_b1e1ac14 >= 4)
			{
				/#
					iprintlnbold("");
				#/
				playsoundatposition("zmb_comp_keypad_action_full", self.origin);
				break;
			}
			level.var_f13364b4.var_d7813dfd[level.var_f13364b4.var_b1e1ac14] = var_6f1036dd.script_int;
			level function_edbb34e5(level.var_f13364b4.var_b1e1ac14, var_6f1036dd.script_int);
			level.var_f13364b4.var_b1e1ac14++;
			/#
				iprintlnbold("" + var_6f1036dd.script_string + "" + var_6f1036dd.script_int);
			#/
			playsoundatposition("zmb_comp_keypad_press_" + var_6f1036dd.script_int, self.origin);
			function_52838f02("both", 1);
			level.var_18f1ca6e function_b2fba7f5();
			level.var_18f1ca6e thread function_a196c54b();
			level.var_18f1ca6e thread function_450060dd();
			level.var_18f1ca6e.is_idling = 0;
			break;
		}
		case "enter":
		{
			if(level.var_f13364b4.var_b1e1ac14 < 4)
			{
				/#
					iprintlnbold("" + level.var_f13364b4.var_d7813dfd[0] + level.var_f13364b4.var_d7813dfd[1] + level.var_f13364b4.var_d7813dfd[2] + level.var_f13364b4.var_d7813dfd[3]);
				#/
				playsoundatposition("zmb_comp_keypad_action_full", self.origin);
				break;
			}
			/#
				iprintlnbold("" + level.var_f13364b4.var_d7813dfd[0] + level.var_f13364b4.var_d7813dfd[1] + level.var_f13364b4.var_d7813dfd[2] + level.var_f13364b4.var_d7813dfd[3]);
			#/
			n_code = function_352f47ae(level.var_f13364b4.var_d7813dfd);
			function_cd7e0989(n_code);
			level thread function_a4c9098e();
			break;
		}
		case "clear":
		{
			level thread function_a4c9098e();
			/#
				iprintlnbold("");
			#/
			playsoundatposition("zmb_comp_keypad_action_clear", self.origin);
			break;
		}
		default:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
	}
}

/*
	Name: function_a4c9098e
	Namespace: namespace_7d8e6ec3
	Checksum: 0xC3CF3192
	Offset: 0x24B0
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function function_a4c9098e(n_delay = 1)
{
	wait(n_delay);
	level.var_18f1ca6e notify(#"hash_23cb7679bd15f5aa");
	function_e8bd25f9();
	level.var_18f1ca6e.is_idling = 1;
}

/*
	Name: function_e8bd25f9
	Namespace: namespace_7d8e6ec3
	Checksum: 0xA9461C16
	Offset: 0x2520
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_e8bd25f9()
{
	level.var_f13364b4.var_b1e1ac14 = 0;
	for(i = 0; i < 4; i++)
	{
		level.var_f13364b4.var_d7813dfd[i] = level.var_f13364b4.var_2329ffa1[i];
	}
	level function_5b1c42a6();
}

/*
	Name: function_4696e086
	Namespace: namespace_7d8e6ec3
	Checksum: 0x6B58D8A6
	Offset: 0x25B0
	Size: 0x112
	Parameters: 2
	Flags: Linked
*/
function function_4696e086(var_5c0c59ca = undefined, var_64d0790a = undefined)
{
	while(isdefined(level.var_f13364b4.var_132bd718[n_random_int]))
	{
		n_random_int = randomintrange(0, 10000);
		/#
			iprintlnbold("" + n_random_int + "");
		#/
	}
	if(isdefined(var_5c0c59ca) && isdefined(var_64d0790a))
	{
		level.var_f13364b4.var_132bd718[n_random_int] = {#hash_d9d9d617:var_64d0790a, #hash_544c05c6:var_5c0c59ca};
	}
	return n_random_int;
}

/*
	Name: function_352f47ae
	Namespace: namespace_7d8e6ec3
	Checksum: 0x8FCABE83
	Offset: 0x26D0
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_352f47ae(var_2ac83b81)
{
	/#
		assert(isdefined(var_2ac83b81[3]), "");
	#/
	return var_2ac83b81[0] * 1000 + var_2ac83b81[1] * 100 + var_2ac83b81[2] * 10 + var_2ac83b81[3];
}

/*
	Name: function_cd7e0989
	Namespace: namespace_7d8e6ec3
	Checksum: 0xE72AEA83
	Offset: 0x2750
	Size: 0x294
	Parameters: 1
	Flags: Linked
*/
function function_cd7e0989(n_code)
{
	if(!isdefined(level.var_f13364b4.var_132bd718[n_code]))
	{
		/#
			iprintlnbold("");
		#/
		playsoundatposition("zmb_comp_keypad_action_fail", self.origin);
		level thread namespace_9cf755b::function_ec34b5ee(#"hash_74933b1a2d246442");
	}
	else if(level.var_f13364b4.var_cf1f0c9 && !array::contains(level.var_d7e5aaac, n_code))
	{
		/#
			iprintlnbold("");
		#/
		playsoundatposition("zmb_comp_keypad_action_fail", self.origin);
		level thread namespace_9cf755b::function_ec34b5ee(#"hash_74933b1a2d246442");
	}
	else if(level.var_f13364b4.var_132bd718[n_code].var_544c05c6 <= 0)
	{
		/#
			iprintlnbold("");
		#/
		playsoundatposition("zmb_comp_keypad_action_fail", self.origin);
		level thread namespace_9cf755b::function_ec34b5ee(#"hash_74933b1a2d246442");
	}
	else if(isdefined(level.var_f13364b4.var_132bd718[n_code].var_d9d9d617))
	{
		/#
			iprintlnbold("");
		#/
		level thread [[level.var_f13364b4.var_132bd718[n_code].var_d9d9d617]]();
		level.var_f13364b4.var_132bd718[n_code].var_544c05c6--;
		playsoundatposition("zmb_comp_keypad_action_success", self.origin);
		if(!array::contains(level.var_d7e5aaac, n_code))
		{
			level thread function_6591945d();
		}
	}
}

/*
	Name: function_6591945d
	Namespace: namespace_7d8e6ec3
	Checksum: 0x358BCBAF
	Offset: 0x29F0
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_6591945d()
{
	level.var_f13364b4.var_cf1f0c9 = 1;
	level waittill(#"end_of_round");
	level.var_f13364b4.var_cf1f0c9 = 0;
}

/*
	Name: function_48f83a1d
	Namespace: namespace_7d8e6ec3
	Checksum: 0xCA88E6F7
	Offset: 0x2A40
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_48f83a1d()
{
	level thread namespace_fddd83bd::fall();
}

/*
	Name: function_b015442e
	Namespace: namespace_7d8e6ec3
	Checksum: 0x355EA579
	Offset: 0x2A68
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_b015442e()
{
	level thread namespace_fddd83bd::grav();
}

/*
	Name: function_7b716b93
	Namespace: namespace_7d8e6ec3
	Checksum: 0xA21FE59C
	Offset: 0x2A90
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_7b716b93()
{
	level thread namespace_fddd83bd::guns();
}

/*
	Name: function_f4c88568
	Namespace: namespace_7d8e6ec3
	Checksum: 0x2B97ED24
	Offset: 0x2AB8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_f4c88568()
{
	level thread namespace_fddd83bd::time();
}

/*
	Name: function_ff176ced
	Namespace: namespace_7d8e6ec3
	Checksum: 0xD93ED2E
	Offset: 0x2AE0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_ff176ced()
{
	level thread namespace_fddd83bd::function_e0b95486();
}

/*
	Name: function_95787ed2
	Namespace: namespace_7d8e6ec3
	Checksum: 0x78D9770D
	Offset: 0x2B08
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_95787ed2()
{
	level thread namespace_fddd83bd::cola();
}

/*
	Name: function_3887862d
	Namespace: namespace_7d8e6ec3
	Checksum: 0xF9E4AD26
	Offset: 0x2B30
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_3887862d()
{
	level thread namespace_fddd83bd::soda();
}

/*
	Name: function_ccbd2e6c
	Namespace: namespace_7d8e6ec3
	Checksum: 0x4A13E6BE
	Offset: 0x2B58
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_ccbd2e6c()
{
	level thread namespace_fddd83bd::noob();
	level.var_f13364b4.var_132bd718[6662].var_544c05c6 = 0;
	level.var_f13364b4.var_132bd718[3279].var_544c05c6 = 0;
}

/*
	Name: function_607f8829
	Namespace: namespace_7d8e6ec3
	Checksum: 0x14DA64FE
	Offset: 0x2BC8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_607f8829()
{
	level thread namespace_fddd83bd::bank();
}

/*
	Name: function_d89fe502
	Namespace: namespace_7d8e6ec3
	Checksum: 0xF4BBFF01
	Offset: 0x2BF0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_d89fe502()
{
	level thread namespace_fddd83bd::door();
}

/*
	Name: function_f5468d9b
	Namespace: namespace_7d8e6ec3
	Checksum: 0x64061C13
	Offset: 0x2C18
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_f5468d9b()
{
	level thread namespace_fddd83bd::warp();
}

/*
	Name: function_addac768
	Namespace: namespace_7d8e6ec3
	Checksum: 0x91CFFEE3
	Offset: 0x2C40
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_addac768()
{
	level thread namespace_fddd83bd::shed();
}

/*
	Name: function_a7f962c9
	Namespace: namespace_7d8e6ec3
	Checksum: 0xEF0456B4
	Offset: 0x2C68
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_a7f962c9()
{
	level thread namespace_fddd83bd::nuke();
}

/*
	Name: function_8e63da67
	Namespace: namespace_7d8e6ec3
	Checksum: 0xCE52ACB0
	Offset: 0x2C90
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_8e63da67()
{
	level thread namespace_fddd83bd::hero();
}

/*
	Name: function_77085b
	Namespace: namespace_7d8e6ec3
	Checksum: 0xBD09EB3D
	Offset: 0x2CB8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_77085b()
{
	level thread namespace_fddd83bd::puke();
}

/*
	Name: function_8a9baa13
	Namespace: namespace_7d8e6ec3
	Checksum: 0xB07AC81E
	Offset: 0x2CE0
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_8a9baa13()
{
	level thread namespace_fddd83bd::club();
	level.var_f13364b4.var_132bd718[2582].var_544c05c6 = 0;
	level.var_f13364b4.var_132bd718[7268].var_544c05c6 = 0;
}

/*
	Name: function_bb800be7
	Namespace: namespace_7d8e6ec3
	Checksum: 0x70F05754
	Offset: 0x2D50
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_bb800be7()
{
	level thread namespace_fddd83bd::duck();
}

/*
	Name: function_8606278d
	Namespace: namespace_7d8e6ec3
	Checksum: 0xC5CB1AA0
	Offset: 0x2D78
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_8606278d()
{
	level thread namespace_fddd83bd::song();
}

/*
	Name: function_b54f6326
	Namespace: namespace_7d8e6ec3
	Checksum: 0xD19FF984
	Offset: 0x2DA0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_b54f6326()
{
	level thread namespace_fddd83bd::function_a2c208d5();
}

/*
	Name: function_685d3dab
	Namespace: namespace_7d8e6ec3
	Checksum: 0x13F6E5A9
	Offset: 0x2DC8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_685d3dab()
{
	level thread namespace_fddd83bd::ugly();
}

/*
	Name: function_7d008839
	Namespace: namespace_7d8e6ec3
	Checksum: 0x712F75FA
	Offset: 0x2DF0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_7d008839()
{
	level thread namespace_fddd83bd::joke();
}

/*
	Name: function_a823412a
	Namespace: namespace_7d8e6ec3
	Checksum: 0xAB7F9F1
	Offset: 0x2E18
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_a823412a()
{
	level thread namespace_fddd83bd::yawn();
	level.var_f13364b4.var_132bd718[9296].var_544c05c6 = 0;
	level.var_f13364b4.var_132bd718[1111].var_544c05c6 = 0;
}

/*
	Name: function_90dbeb67
	Namespace: namespace_7d8e6ec3
	Checksum: 0xB9DE2E9
	Offset: 0x2E88
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_90dbeb67()
{
	level thread namespace_fddd83bd::vent();
	level.var_f13364b4.var_132bd718[8368].var_544c05c6 = 0;
	level.var_f13364b4.var_132bd718[7268].var_544c05c6 = 0;
}

/*
	Name: function_6755931f
	Namespace: namespace_7d8e6ec3
	Checksum: 0x7BA1F386
	Offset: 0x2EF8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_6755931f()
{
	level thread namespace_fddd83bd::love();
}

/*
	Name: function_b94ecbd8
	Namespace: namespace_7d8e6ec3
	Checksum: 0x6A92FA13
	Offset: 0x2F20
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_b94ecbd8()
{
	level thread namespace_fddd83bd::life();
}

/*
	Name: function_23dac63d
	Namespace: namespace_7d8e6ec3
	Checksum: 0x52400AA5
	Offset: 0x2F48
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_23dac63d()
{
	level thread namespace_fddd83bd::boom();
	level.var_f13364b4.var_132bd718[7836].var_544c05c6 = 0;
	level.var_f13364b4.var_132bd718[2666].var_544c05c6 = 0;
}

/*
	Name: function_9e9664bd
	Namespace: namespace_7d8e6ec3
	Checksum: 0x627DC18A
	Offset: 0x2FB8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_9e9664bd()
{
	level thread namespace_fddd83bd::pack();
}

/*
	Name: function_ac121b1c
	Namespace: namespace_7d8e6ec3
	Checksum: 0xBB7FAD7A
	Offset: 0x2FE0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_ac121b1c()
{
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	level thread namespace_cc08081f::function_a0b040d4();
}

/*
	Name: function_7e966dbe
	Namespace: namespace_7d8e6ec3
	Checksum: 0x72A93B92
	Offset: 0x3028
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_7e966dbe()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_3d3b83078e638263", 0, 1);
}

/*
	Name: function_9b96f239
	Namespace: namespace_7d8e6ec3
	Checksum: 0xABD4795C
	Offset: 0x3068
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_9b96f239()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_24f10736d61f17be", 0, 1);
}

/*
	Name: function_c36b1f94
	Namespace: namespace_7d8e6ec3
	Checksum: 0xE8291117
	Offset: 0x30A8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_c36b1f94()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_5f8cf3a67798b7ab", 0, 1);
}

/*
	Name: function_27d39a4f
	Namespace: namespace_7d8e6ec3
	Checksum: 0x2D7E4B4B
	Offset: 0x30E8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_27d39a4f()
{
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_998eba45
	Namespace: namespace_7d8e6ec3
	Checksum: 0x6E04CD90
	Offset: 0x3118
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_998eba45()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_5ec22c1b18a29d51", 0, 1);
}

/*
	Name: function_be76c1b8
	Namespace: namespace_7d8e6ec3
	Checksum: 0x4B440EC4
	Offset: 0x3158
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_be76c1b8()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_346e9556bd641875", 0, 1);
}

/*
	Name: function_fadd27d6
	Namespace: namespace_7d8e6ec3
	Checksum: 0x9FEF93B
	Offset: 0x3198
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_fadd27d6()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_774ea9ca1a48e4d", 0, 1);
}

/*
	Name: function_cd2168cb
	Namespace: namespace_7d8e6ec3
	Checksum: 0xB133CAED
	Offset: 0x31D8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_cd2168cb()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_3d1ea1a6ac1bd74c", 0, 1);
}

/*
	Name: function_6b002f3c
	Namespace: namespace_7d8e6ec3
	Checksum: 0x4069325E
	Offset: 0x3218
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_6b002f3c()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_57bcd7bd5e8ab56e", 0, 1);
}

/*
	Name: function_c9dcb3aa
	Namespace: namespace_7d8e6ec3
	Checksum: 0xD308EFAD
	Offset: 0x3258
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_c9dcb3aa()
{
	level flag::set(#"hash_3ee874ebee843004");
	/#
		iprintlnbold("" + level.var_f13364b4.var_a7450be4);
	#/
}

/*
	Name: function_69dd6c5b
	Namespace: namespace_7d8e6ec3
	Checksum: 0x45B37E70
	Offset: 0x32B8
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_69dd6c5b()
{
	if(level flag::get(#"hash_3ee874ebee843004"))
	{
		level flag::set(#"hash_315d0bf1d50724f0");
		/#
			iprintlnbold("" + level.var_f13364b4.var_72c3e48c);
		#/
	}
	else
	{
		level.var_f13364b4.var_132bd718[level.var_f13364b4.var_a7450be4].var_544c05c6++;
	}
}

/*
	Name: function_97ab5da4
	Namespace: namespace_7d8e6ec3
	Checksum: 0x85442857
	Offset: 0x3368
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_97ab5da4()
{
	a_flags = array(#"hash_3ee874ebee843004", #"hash_315d0bf1d50724f0");
	if(level flag::get_all(a_flags))
	{
		level flag::set(#"hash_359cbec050523f4");
		/#
			iprintlnbold("" + level.var_f13364b4.var_98e79e76);
		#/
	}
	else
	{
		level.var_f13364b4.var_132bd718[level.var_f13364b4.var_72c3e48c].var_544c05c6++;
	}
}

/*
	Name: function_9a405843
	Namespace: namespace_7d8e6ec3
	Checksum: 0xC82ECF5C
	Offset: 0x3448
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_9a405843()
{
	a_flags = array(#"hash_3ee874ebee843004", #"hash_315d0bf1d50724f0", #"hash_359cbec050523f4");
	if(level flag::get_all(a_flags))
	{
		level flag::set(#"hash_130656ec8ad5480d");
	}
	else
	{
		level.var_f13364b4.var_132bd718[level.var_f13364b4.var_98e79e76].var_544c05c6++;
	}
}

/*
	Name: function_7ddee93a
	Namespace: namespace_7d8e6ec3
	Checksum: 0x54ED3198
	Offset: 0x3508
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_7ddee93a()
{
	level flag::set(#"hash_eb582974245f076");
}

/*
	Name: function_68dfeba9
	Namespace: namespace_7d8e6ec3
	Checksum: 0x8C00052C
	Offset: 0x3538
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_68dfeba9()
{
	level.var_e1b5b6fe++;
	if(!flag::get(#"hash_66ee9231ad909f7e"))
	{
		level flag::set(#"hash_66ee9231ad909f7e");
	}
}

/*
	Name: function_8fff2dd
	Namespace: namespace_7d8e6ec3
	Checksum: 0x29887EE1
	Offset: 0x3598
	Size: 0x466
	Parameters: 0
	Flags: Linked
*/
function function_8fff2dd()
{
	level._effect[#"hash_7c49a746639d8fb9"] = "maps/zm_white/fx8_zm_white_code_type_0";
	level._effect[#"hash_7c49a646639d8e06"] = "maps/zm_white/fx8_zm_white_code_type_1";
	level._effect[#"hash_7c49a546639d8c53"] = "maps/zm_white/fx8_zm_white_code_type_2";
	level._effect[#"hash_7c49a446639d8aa0"] = "maps/zm_white/fx8_zm_white_code_type_3";
	level._effect[#"hash_7c49ab46639d9685"] = "maps/zm_white/fx8_zm_white_code_type_4";
	level._effect[#"hash_7c49aa46639d94d2"] = "maps/zm_white/fx8_zm_white_code_type_5";
	level._effect[#"hash_7c49a946639d931f"] = "maps/zm_white/fx8_zm_white_code_type_6";
	level._effect[#"hash_7c49a846639d916c"] = "maps/zm_white/fx8_zm_white_code_type_7";
	level._effect[#"hash_7c49af46639d9d51"] = "maps/zm_white/fx8_zm_white_code_type_8";
	level._effect[#"hash_7c49ae46639d9b9e"] = "maps/zm_white/fx8_zm_white_code_type_9";
	level._effect[#"hash_440d5b73d8a98ff4"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_0";
	level._effect[#"hash_440d5c73d8a991a7"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_1";
	level._effect[#"hash_440d5d73d8a9935a"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_2";
	level._effect[#"hash_440d5e73d8a9950d"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_3";
	level._effect[#"hash_440d5773d8a98928"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_4";
	level._effect[#"hash_440d5873d8a98adb"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_5";
	level._effect[#"hash_440d5973d8a98c8e"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_6";
	level._effect[#"hash_440d5a73d8a98e41"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_7";
	level._effect[#"hash_440d5373d8a9825c"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_8";
	level._effect[#"hash_440d5473d8a9840f"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_9";
	level.var_f3c560b6[0] = getent("code_display_digit0", "script_noteworthy");
	for(i = 0; i < 4; i++)
	{
		level.var_40361d9a[i] = "screen_code_display_digit" + i;
		level.var_1e220e78[i] = getent(level.var_40361d9a[i], "script_noteworthy");
		level.var_1e220e78[i] hide();
		level.var_3dbe29c9[i] = "screen_code_display_large_digit" + i;
		level.var_17ff2d5e[i] = getent(level.var_3dbe29c9[i], "script_noteworthy");
		level.var_17ff2d5e[i] hide();
	}
}

/*
	Name: function_edbb34e5
	Namespace: namespace_7d8e6ec3
	Checksum: 0xDE8D7017
	Offset: 0x3A08
	Size: 0x1B4
	Parameters: 2
	Flags: Linked
*/
function function_edbb34e5(n_digit, n_value)
{
	if(n_digit == 0)
	{
		level.var_1e220e78[1] setmodel("p8_zm_white_computer_system_code_display_small_cursor");
		level.var_17ff2d5e[1] setmodel("p8_zm_white_computer_system_code_display_large_cursor");
	}
	if(n_digit == 1)
	{
		level.var_1e220e78[2] setmodel("p8_zm_white_computer_system_code_display_small_cursor");
		level.var_17ff2d5e[2] setmodel("p8_zm_white_computer_system_code_display_large_cursor");
	}
	if(n_digit == 2)
	{
		level.var_1e220e78[3] setmodel("p8_zm_white_computer_system_code_display_small_cursor");
		level.var_17ff2d5e[3] setmodel("p8_zm_white_computer_system_code_display_large_cursor");
	}
	var_9e6fc71b = "p8_zm_white_computer_system_code_display_small_" + n_value;
	level.var_1e220e78[n_digit] setmodel(var_9e6fc71b);
	var_954db43c = "p8_zm_white_computer_system_code_display_large_" + n_value;
	level.var_17ff2d5e[n_digit] setmodel(var_954db43c);
}

/*
	Name: function_5b1c42a6
	Namespace: namespace_7d8e6ec3
	Checksum: 0x6361C8A4
	Offset: 0x3BC8
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function function_5b1c42a6()
{
	for(n_digit = 0; n_digit < 4; n_digit++)
	{
		if(n_digit == 0)
		{
			level.var_1e220e78[n_digit] setmodel("p8_zm_white_computer_system_code_display_small_cursor");
			level.var_17ff2d5e[n_digit] setmodel("p8_zm_white_computer_system_code_display_large_cursor");
			continue;
		}
		level.var_1e220e78[n_digit] setmodel("p8_zm_white_computer_system_code_display_small_space");
		level.var_17ff2d5e[n_digit] setmodel("p8_zm_white_computer_system_code_display_large_space");
	}
}

/*
	Name: function_52838f02
	Namespace: namespace_7d8e6ec3
	Checksum: 0x40FD2E0
	Offset: 0x3CB0
	Size: 0x1AA
	Parameters: 2
	Flags: Linked
*/
function function_52838f02(var_601fee0 = "both", b_show = 1)
{
	var_b58f214e = &show;
	if(!b_show)
	{
		var_b58f214e = &hide;
	}
	switch(var_601fee0)
	{
		case "both":
		{
			for(i = 0; i < 4; i++)
			{
				level.var_1e220e78[i] [[var_b58f214e]]();
				level.var_17ff2d5e[i] [[var_b58f214e]]();
			}
			break;
		}
		case "keypad":
		{
			for(i = 0; i < 4; i++)
			{
				level.var_1e220e78[i] [[var_b58f214e]]();
			}
			break;
		}
		case "large":
		{
			for(i = 0; i < 4; i++)
			{
				level.var_17ff2d5e[i] [[var_b58f214e]]();
			}
			break;
		}
		default:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
	}
}

/*
	Name: function_7ee18649
	Namespace: namespace_7d8e6ec3
	Checksum: 0x492EA8F6
	Offset: 0x3E68
	Size: 0x34A
	Parameters: 0
	Flags: Linked
*/
function function_7ee18649()
{
	level thread function_a02dfba();
	var_127789d1 = randomint(3);
	var_2ec8989 = namespace_509a75d1::function_bffcedde("mesh_code_display_01", "script_noteworthy", "script_int");
	level.var_f140d610 = var_2ec8989[var_127789d1];
	level.var_f140d610 function_f0af359();
	level.var_f140d610 function_66365668(function_da24090c(level.var_f13364b4.var_a7450be4));
	level.var_f140d610 showpart("tag_code_paper_1");
	var_dad3f7bf = namespace_509a75d1::function_bffcedde("sawyer_authorization_code", "targetname", "script_int");
	for(i = 0; i < var_2ec8989.size; i++)
	{
		if(i != var_127789d1)
		{
			var_2ec8989[i] delete();
		}
	}
	waitframe(1);
	level.var_ff8f72ad function_66365668(function_da24090c(level.var_f13364b4.var_72c3e48c));
	level.var_ff8f72ad showpart("tag_code_paper_2");
	waitframe(1);
	level.var_d2e0194f function_66365668(function_da24090c(level.var_f13364b4.var_98e79e76));
	level.var_d2e0194f showpart("tag_code_paper_3");
	level.var_a91ec5cd function_66365668(function_da24090c(level.var_f13364b4.var_3c358113));
	level.var_b6696062 function_66365668(function_da24090c(level.var_f13364b4.var_c8629019));
	waitframe(1);
	level.var_a925c5df function_66365668(function_da24090c(level.var_f13364b4.var_becc7ced));
	waitframe(1);
	level.var_b6f4617c function_66365668(function_da24090c(level.var_f13364b4.var_5beab72b));
	waitframe(1);
}

/*
	Name: function_a02dfba
	Namespace: namespace_7d8e6ec3
	Checksum: 0x50A8B661
	Offset: 0x41C0
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_a02dfba()
{
	level.var_ff8f72ad = getent("mesh_code_display_02", "script_noteworthy");
	level.var_d2e0194f = getent("mesh_code_display_03", "script_noteworthy");
	level.var_a91ec5cd = getent("mesh_code_display_04", "script_noteworthy");
	level.var_b6696062 = getent("mesh_code_display_05", "script_noteworthy");
	level.var_a925c5df = getent("mesh_code_display_06", "script_noteworthy");
	level.var_b6f4617c = getent("mesh_code_display_07", "script_noteworthy");
	level.var_ff8f72ad function_f0af359();
	level.var_d2e0194f function_f0af359();
	level.var_a91ec5cd function_f0af359();
	level.var_b6696062 function_f0af359();
	level.var_a925c5df function_f0af359();
	level.var_b6f4617c function_f0af359();
}

/*
	Name: function_f0af359
	Namespace: namespace_7d8e6ec3
	Checksum: 0xE278D4B9
	Offset: 0x4358
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_f0af359()
{
	for(n_digit = 0; n_digit <= 3; n_digit++)
	{
		for(n_value = 0; n_value <= 9; n_value++)
		{
			self hidepart("tag_code_digit_" + n_digit + "_" + n_value);
		}
	}
	self hidepart("tag_code_paper_1");
	self hidepart("tag_code_paper_2");
	self hidepart("tag_code_paper_3");
}

/*
	Name: function_66365668
	Namespace: namespace_7d8e6ec3
	Checksum: 0x9133454C
	Offset: 0x4440
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_66365668(a_code)
{
	var_aa2d940c = "tag_code_digit_0_" + int(a_code[0]);
	var_bfd7bf60 = "tag_code_digit_1_" + int(a_code[1]);
	var_ce0d5bcb = "tag_code_digit_2_" + int(a_code[2]);
	var_e38486c9 = "tag_code_digit_3_" + int(a_code[3]);
	self showpart(var_aa2d940c);
	self showpart(var_bfd7bf60);
	self showpart(var_ce0d5bcb);
	self showpart(var_e38486c9);
}

/*
	Name: function_da24090c
	Namespace: namespace_7d8e6ec3
	Checksum: 0x461AF219
	Offset: 0x4570
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_da24090c(n_code)
{
	a_code[0] = floor(n_code / 1000);
	n_code = n_code % 1000;
	a_code[1] = floor(n_code / 100);
	n_code = n_code % 100;
	a_code[2] = floor(n_code / 10);
	n_code = n_code % 10;
	a_code[3] = n_code;
	return a_code;
}

/*
	Name: delete_entities
	Namespace: namespace_7d8e6ec3
	Checksum: 0xE7D179E1
	Offset: 0x4630
	Size: 0x76
	Parameters: 0
	Flags: None
*/
function delete_entities()
{
	for(i = 0; i < 4; i++)
	{
		var_51d09dba = getent("code_display_digit" + i, "script_noteworthy");
		if(isdefined(var_51d09dba))
		{
			var_51d09dba delete();
		}
	}
}

/*
	Name: function_beeabfd2
	Namespace: namespace_7d8e6ec3
	Checksum: 0x21BD400C
	Offset: 0x46B0
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_beeabfd2(n_id)
{
	self.var_5543b573 = n_id;
	self.var_2b315dde[0] = "string";
	self.var_731ce5fc[0] = "string";
	self.var_e3a88238 = getent("computersystem_clock_colon", "targetname");
	for(i = 0; i < 4; i++)
	{
		self.var_731ce5fc[i] = "computersystem_" + self.var_5543b573 + "_clock_digit" + i;
		self.var_2b315dde[i] = getent(self.var_731ce5fc[i], "script_noteworthy");
	}
}

/*
	Name: function_4955480
	Namespace: namespace_7d8e6ec3
	Checksum: 0xECEE6903
	Offset: 0x47B8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_4955480()
{
	self.var_4cdc88ae = 1;
	level.var_18f1ca6e function_b2fba7f5();
	level.var_18f1ca6e thread function_a196c54b();
	self endon(#"hash_10b7419f15453a9e");
	self function_80707067();
	self function_5e0b6734(1, 0, 1, 0, 1);
	self waittill(#"hash_6cb5d5beb3730446");
	self function_9b1511fa();
}

/*
	Name: function_9b1511fa
	Namespace: namespace_7d8e6ec3
	Checksum: 0xBC25A3C3
	Offset: 0x4880
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function function_9b1511fa()
{
	self function_58dddc4e();
	self function_eb17b80b();
	self.var_4cdc88ae = 0;
	self notify(#"hash_10b7419f15453a9e");
}

/*
	Name: function_5e0b6734
	Namespace: namespace_7d8e6ec3
	Checksum: 0x20AB843F
	Offset: 0x48D8
	Size: 0x7BC
	Parameters: 5
	Flags: Linked
*/
function function_5e0b6734(var_b995184a, var_2199b576, var_ec214a86, var_d1201d6b, var_f3ea62ff)
{
	self.var_5659075f = var_b995184a;
	self.var_9400d2ae = 0;
	self.var_87d84bef = 0;
	self.var_9901ee42 = 0;
	self.var_18e46e05 = 0;
	self.var_eb2b1293 = 0;
	if(self.var_5659075f == 1)
	{
		self.var_87d84bef = var_f3ea62ff;
		self.var_9901ee42 = var_d1201d6b;
		self.var_18e46e05 = var_ec214a86;
		self.var_eb2b1293 = var_2199b576;
		self.var_2b315dde[3] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_87d84bef);
		self.var_2b315dde[2] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_9901ee42);
		self.var_2b315dde[1] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_18e46e05);
		self.var_2b315dde[0] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_eb2b1293);
	}
	while(true)
	{
		self.var_9400d2ae++;
		if(self.var_5659075f == 0)
		{
			if(self.var_eb2b1293 == var_2199b576 && self.var_18e46e05 == var_ec214a86 && self.var_9901ee42 == var_d1201d6b && self.var_87d84bef == var_f3ea62ff)
			{
				break;
			}
			self.var_87d84bef++;
			if(self.var_87d84bef < 10)
			{
				self.var_2b315dde[3] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_87d84bef);
			}
			if(self.var_87d84bef == 10 && self.var_9901ee42 < 5)
			{
				self.var_87d84bef = 0;
				self.var_2b315dde[3] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_87d84bef);
				self.var_9901ee42++;
				if(self.var_9901ee42 < 6)
				{
					self.var_2b315dde[2] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_9901ee42);
				}
			}
			if(self.var_87d84bef == 10 && self.var_9901ee42 == 5 && self.var_18e46e05 < 9)
			{
				self.var_9901ee42 = 0;
				self.var_87d84bef = 0;
				self.var_2b315dde[3] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_87d84bef);
				self.var_2b315dde[2] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_9901ee42);
				self.var_18e46e05++;
				if(self.var_18e46e05 < 10)
				{
					self.var_2b315dde[1] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_18e46e05);
				}
			}
			if(self.var_87d84bef == 10 && self.var_9901ee42 == 5 && self.var_18e46e05 >= 9 && self.var_eb2b1293 < 10)
			{
				self.var_87d84bef = 0;
				self.var_2b315dde[3] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_87d84bef);
				self.var_9901ee42 = 0;
				self.var_2b315dde[2] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_9901ee42);
				self.var_18e46e05 = 0;
				self.var_2b315dde[1] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_18e46e05);
				self.var_eb2b1293++;
				if(self.var_eb2b1293 < 10)
				{
					self.var_2b315dde[0] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_eb2b1293);
				}
			}
			if(self.var_87d84bef == 10 && self.var_9901ee42 == 5 && self.var_18e46e05 == 10 && self.var_eb2b1293 == 10)
			{
				break;
			}
		}
		if(self.var_5659075f == 1)
		{
			self.var_87d84bef--;
			if(self.var_87d84bef < 0 && self.var_9901ee42 > -1)
			{
				self.var_9901ee42--;
				self.var_87d84bef = 9;
				if(self.var_9901ee42 > -1)
				{
					self.var_2b315dde[2] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_9901ee42);
				}
			}
			if(self.var_9901ee42 < 0)
			{
				self.var_18e46e05--;
				self.var_9901ee42 = 5;
				self.var_2b315dde[2] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_9901ee42);
				if(self.var_18e46e05 > -1)
				{
					self.var_2b315dde[1] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_18e46e05);
				}
			}
			if(self.var_18e46e05 < 0)
			{
				self.var_eb2b1293--;
				self.var_18e46e05 = 9;
				self.var_2b315dde[1] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_18e46e05);
				if(self.var_eb2b1293 > -1)
				{
					self.var_2b315dde[0] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_eb2b1293);
				}
			}
			self.var_2b315dde[3] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_87d84bef);
			if(self.var_eb2b1293 == 0 && self.var_18e46e05 == 0 && self.var_9901ee42 == 0 && self.var_87d84bef == 0)
			{
				break;
			}
		}
		wait(1);
	}
	self thread function_7a1b3cff();
}

/*
	Name: function_58dddc4e
	Namespace: namespace_7d8e6ec3
	Checksum: 0xB4A386A
	Offset: 0x50A0
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_58dddc4e()
{
	self.var_87d84bef = 0;
	self.var_9901ee42 = 0;
	self.var_18e46e05 = 0;
	self.var_eb2b1293 = 0;
	self.var_2b315dde[3] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_87d84bef);
	self.var_2b315dde[2] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_9901ee42);
	self.var_2b315dde[1] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_18e46e05);
	self.var_2b315dde[0] setmodel("p8_zm_white_computer_system_code_display_small_" + self.var_eb2b1293);
}

/*
	Name: function_80707067
	Namespace: namespace_7d8e6ec3
	Checksum: 0x152D4F92
	Offset: 0x51A0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_80707067()
{
	self.var_e3a88238 show();
	self.var_2b315dde[3] show();
	self.var_2b315dde[2] show();
	self.var_2b315dde[1] show();
	self.var_2b315dde[0] show();
}

/*
	Name: function_eb17b80b
	Namespace: namespace_7d8e6ec3
	Checksum: 0xB3FC6345
	Offset: 0x5248
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_eb17b80b()
{
	self.var_e3a88238 hide();
	self.var_2b315dde[3] hide();
	self.var_2b315dde[2] hide();
	self.var_2b315dde[1] hide();
	self.var_2b315dde[0] hide();
}

/*
	Name: function_7a1b3cff
	Namespace: namespace_7d8e6ec3
	Checksum: 0xA3F1A936
	Offset: 0x52F0
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function function_7a1b3cff()
{
	for(i = 0; i < 3; i++)
	{
		self function_eb17b80b();
		wait(0.5);
		self function_80707067();
		wait(0.5);
	}
	self function_eb17b80b();
	self notify(#"hash_6cb5d5beb3730446");
}

/*
	Name: function_45822b7e
	Namespace: namespace_7d8e6ec3
	Checksum: 0x4CA3FFF4
	Offset: 0x5388
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_45822b7e()
{
	level.var_18f1ca6e = getent("face_screen", "targetname");
	level.var_cb1cac73 = getent("computer_system_extras", "targetname");
	level.var_cb1cac73 hidepart("tag_control_panel");
	level thread function_a3442c46("0");
	level.var_18f1ca6e thread function_a196c54b();
}

/*
	Name: function_a3442c46
	Namespace: namespace_7d8e6ec3
	Checksum: 0xCA8CE145
	Offset: 0x5440
	Size: 0x25A
	Parameters: 1
	Flags: Linked
*/
function function_a3442c46(s_stage)
{
	switch(s_stage)
	{
		case "0":
		{
			level.var_cb1cac73 hidepart("tag_lights");
			level.var_cb1cac73 hidepart("tag_stage_01");
			level.var_cb1cac73 hidepart("tag_stage_02");
			level.var_cb1cac73 hidepart("tag_stage_03");
			level.var_cb1cac73 hidepart("tag_stage_04");
			level.var_cb1cac73 hidepart("tag_stage_05");
			exploder::stop_exploder("fxexp_script_computersystem_screen");
			break;
		}
		case "1":
		{
			level.var_cb1cac73 showpart("tag_stage_01");
			level.var_cb1cac73 showpart("tag_lights");
			exploder::exploder("fxexp_script_computersystem_screen");
			break;
		}
		case "2":
		{
			level.var_cb1cac73 showpart("tag_stage_02");
			break;
		}
		case "3":
		{
			level.var_cb1cac73 showpart("tag_stage_03");
			break;
		}
		case "4":
		{
			level.var_cb1cac73 showpart("tag_stage_04");
			break;
		}
		case "5":
		{
			level.var_cb1cac73 showpart("tag_stage_05");
			break;
		}
	}
}

/*
	Name: function_6ef53601
	Namespace: namespace_7d8e6ec3
	Checksum: 0x728E0B18
	Offset: 0x56A8
	Size: 0x352
	Parameters: 1
	Flags: Linked
*/
function function_6ef53601(var_7e123df8)
{
	switch(var_7e123df8)
	{
		case "blink":
		{
			self function_a196c54b();
			self showpart("tag_glitch");
			wait(0.2);
			self function_a196c54b();
			self showpart("tag_blink_cycle_all");
			break;
		}
		case "dynamic":
		{
			self function_a196c54b();
			self showpart("tag_glitch");
			wait(0.2);
			self function_a196c54b();
			self showpart("tag_dynamic");
			break;
		}
		case "glitch":
		{
			self function_a196c54b();
			self showpart("tag_glitch");
			wait(0.2);
			self function_a196c54b();
			self showpart("tag_glitch");
			break;
		}
		case "style1":
		{
			self function_a196c54b();
			self showpart("tag_glitch");
			wait(0.2);
			self function_a196c54b();
			self showpart("tag_style1");
			break;
		}
		case "style2":
		{
			self function_a196c54b();
			self showpart("tag_glitch");
			wait(0.2);
			self function_a196c54b();
			self showpart("tag_style2");
			break;
		}
		case "vector":
		{
			self function_a196c54b();
			self showpart("tag_glitch");
			wait(0.2);
			self function_a196c54b();
			self showpart("tag_vector");
			break;
		}
	}
}

/*
	Name: function_450060dd
	Namespace: namespace_7d8e6ec3
	Checksum: 0x523739E6
	Offset: 0x5A08
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_450060dd()
{
	self notify(#"hash_23cb7679bd15f5aa");
	self endon(#"end_game", #"hash_23cb7679bd15f5aa");
	self thread function_a196c54b();
	while(gettime() < n_start_time + 60000)
	{
		wait(0.5);
	}
	level thread function_a4c9098e();
}

/*
	Name: function_cafaeead
	Namespace: namespace_7d8e6ec3
	Checksum: 0x54D36F05
	Offset: 0x5AA0
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_cafaeead()
{
	self endon(#"end_game");
	while(true)
	{
		if(self.is_idling && (!(isdefined(self.var_1549a0a5) && self.var_1549a0a5)))
		{
			if(!level.countdown_clock.var_4cdc88ae && level.var_f13364b4.var_b1e1ac14 == 0)
			{
				level.var_18f1ca6e thread function_67621880();
			}
		}
		wait(0.5);
	}
}

/*
	Name: function_67621880
	Namespace: namespace_7d8e6ec3
	Checksum: 0x48830FAE
	Offset: 0x5B58
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_67621880()
{
	self notify(#"hash_23cb7679bd15f5aa");
	function_52838f02("large", 0);
	self.var_1549a0a5 = 1;
	var_745db666 = array("blink", "dynamic", "style1", "style2");
	self endon(#"end_game", #"hash_3f68e1ecf3892766");
	while(true)
	{
		var_745db666 = array::randomize(var_745db666);
		self thread function_6ef53601(var_745db666[0]);
		wait(randomfloatrange(5, 10));
	}
}

/*
	Name: function_b2fba7f5
	Namespace: namespace_7d8e6ec3
	Checksum: 0xA12BF856
	Offset: 0x5C60
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function function_b2fba7f5()
{
	level.var_18f1ca6e notify(#"hash_3f68e1ecf3892766");
	self.var_1549a0a5 = 0;
}

/*
	Name: function_a196c54b
	Namespace: namespace_7d8e6ec3
	Checksum: 0xC579AB93
	Offset: 0x5C90
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_a196c54b()
{
	self hidepart("tag_blink_cycle_all");
	self hidepart("tag_dynamic");
	self hidepart("tag_glitch");
	self hidepart("tag_style1");
	self hidepart("tag_style2");
	self hidepart("tag_vector");
}

/*
	Name: function_9a2a7f26
	Namespace: namespace_7d8e6ec3
	Checksum: 0x2112BCA2
	Offset: 0x5D60
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_9a2a7f26()
{
	level.var_cb1cac73 showpart("tag_control_panel");
	level.var_cb1cac73 showpart("tag_lights");
}

/*
	Name: function_31890499
	Namespace: namespace_7d8e6ec3
	Checksum: 0xBE9CCD36
	Offset: 0x5DB0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_31890499()
{
	level.var_cb1cac73 hidepart("tag_control_panel");
	level.var_cb1cac73 hidepart("tag_lights");
}

/*
	Name: function_d83247cd
	Namespace: namespace_7d8e6ec3
	Checksum: 0x3259490E
	Offset: 0x5E00
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_d83247cd()
{
	level.var_5d577798 = getent("code_printer_monitor", "targetname");
	level.var_5d577798 showpart("tag_screen_static");
	level.var_5d577798 hidepart("tag_screen_unbroken");
	level.var_5d577798 hidepart("tag_screen_broken");
	level.var_5d577798 playloopsound(#"hash_340bf847392d3d2f");
}

/*
	Name: function_5fbede7a
	Namespace: namespace_7d8e6ec3
	Checksum: 0xEE4E1196
	Offset: 0x5EC0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_5fbede7a()
{
	level.var_5d577798 hidepart("tag_screen_static");
	level.var_5d577798 showpart("tag_screen_unbroken");
	level.var_5d577798 hidepart("tag_screen_broken");
	level.var_5d577798 playloopsound(#"hash_781ac45f11aba91e");
	level.var_5d577798 playsound(#"hash_d959f93f00640e9");
}

/*
	Name: function_60f15ca8
	Namespace: namespace_7d8e6ec3
	Checksum: 0xA113A123
	Offset: 0x5F80
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_60f15ca8()
{
	var_a94d1ca3 = getent("code_printer_paper", "targetname");
	level._effect[#"hash_ae7ff67227046f2"] = #"hash_731cff4f6f2d012d";
	var_73a8928d = var_a94d1ca3.origin;
	level.var_5d577798 stoploopsound();
	level.var_5d577798 playsound(#"hash_42924f60b7b4c07a");
	playfxontag(level._effect[#"hash_ae7ff67227046f2"], level.var_5d577798, "tag_fx");
	level.var_5d577798 hidepart("tag_screen_static");
	level.var_5d577798 showpart("tag_screen_broken");
	level.var_5d577798 hidepart("tag_screen_unbroken");
	wait(2);
	var_a94d1ca3 playsound(#"hash_51945414465e1801");
	var_a94d1ca3 moveto(var_73a8928d + vectorscale((0, -1, 0), 6), 0.3);
}

/*
	Name: function_6338402
	Namespace: namespace_7d8e6ec3
	Checksum: 0x46030C34
	Offset: 0x6130
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_6338402()
{
	level flag::wait_till("mq_computer_activated");
	level.var_70407389 = [];
	level thread rushmore_speech_hamilton();
	level thread rushmore_speech_franklin();
	level thread rushmore_speech_madison();
	level thread rushmore_speech_jefferson();
	level thread rushmore_speech_flag();
}

/*
	Name: rushmore_speech_hamilton
	Namespace: namespace_7d8e6ec3
	Checksum: 0xFF0F7353
	Offset: 0x61E8
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function rushmore_speech_hamilton()
{
	s_interact = struct::get("rushmore_speech_hamilton");
	if(!isdefined(level.var_70407389))
	{
		level.var_70407389 = [];
	}
	else if(!isarray(level.var_70407389))
	{
		level.var_70407389 = array(level.var_70407389);
	}
	level.var_70407389[level.var_70407389.size] = s_interact;
	while(!var_805dab64)
	{
		s_interact zm_unitrigger::function_fac87205(&function_a74f51a8, 32);
		if(level.var_5dd0d3ff zm_audio::function_65e5c19a())
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_3bb62fc3dd0ef854", 0, 0);
			var_805dab64 = 1;
		}
		else
		{
			wait(2);
		}
	}
}

/*
	Name: rushmore_speech_franklin
	Namespace: namespace_7d8e6ec3
	Checksum: 0x55F9879C
	Offset: 0x6338
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function rushmore_speech_franklin()
{
	s_interact = struct::get("rushmore_speech_franklin");
	if(!isdefined(level.var_70407389))
	{
		level.var_70407389 = [];
	}
	else if(!isarray(level.var_70407389))
	{
		level.var_70407389 = array(level.var_70407389);
	}
	level.var_70407389[level.var_70407389.size] = s_interact;
	while(!var_805dab64)
	{
		s_interact zm_unitrigger::function_fac87205(&function_a74f51a8, 32);
		if(level.var_5dd0d3ff zm_audio::function_65e5c19a())
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_3d5961d25aa763a8", 0, 0);
			var_805dab64 = 1;
		}
		else
		{
			wait(2);
		}
	}
}

/*
	Name: rushmore_speech_madison
	Namespace: namespace_7d8e6ec3
	Checksum: 0xF4654FA5
	Offset: 0x6488
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function rushmore_speech_madison()
{
	s_interact = struct::get("rushmore_speech_madison");
	if(!isdefined(level.var_70407389))
	{
		level.var_70407389 = [];
	}
	else if(!isarray(level.var_70407389))
	{
		level.var_70407389 = array(level.var_70407389);
	}
	level.var_70407389[level.var_70407389.size] = s_interact;
	while(!var_805dab64)
	{
		s_interact zm_unitrigger::function_fac87205(&function_a74f51a8, 32);
		if(level.var_5dd0d3ff zm_audio::function_65e5c19a())
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_6bbfaf4e608a79b8", 0, 0);
			var_805dab64 = 1;
		}
		else
		{
			wait(2);
		}
	}
}

/*
	Name: rushmore_speech_jefferson
	Namespace: namespace_7d8e6ec3
	Checksum: 0xB2C0A4A8
	Offset: 0x65D8
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function rushmore_speech_jefferson()
{
	s_interact = struct::get("rushmore_speech_jefferson");
	if(!isdefined(level.var_70407389))
	{
		level.var_70407389 = [];
	}
	else if(!isarray(level.var_70407389))
	{
		level.var_70407389 = array(level.var_70407389);
	}
	level.var_70407389[level.var_70407389.size] = s_interact;
	while(!var_805dab64)
	{
		s_interact zm_unitrigger::function_fac87205(&function_a74f51a8, 32);
		if(level.var_5dd0d3ff zm_audio::function_65e5c19a())
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_c11fc3ab92db957", 0, 0);
			var_805dab64 = 1;
		}
		else
		{
			wait(2);
		}
	}
}

/*
	Name: rushmore_speech_flag
	Namespace: namespace_7d8e6ec3
	Checksum: 0xF00BEA7B
	Offset: 0x6728
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function rushmore_speech_flag()
{
	s_interact = struct::get("rushmore_speech_flag");
	if(!isdefined(level.var_70407389))
	{
		level.var_70407389 = [];
	}
	else if(!isarray(level.var_70407389))
	{
		level.var_70407389 = array(level.var_70407389);
	}
	level.var_70407389[level.var_70407389.size] = s_interact;
	while(!var_805dab64)
	{
		s_interact zm_unitrigger::function_fac87205(&function_a74f51a8, 32);
		if(level.var_5dd0d3ff zm_audio::function_65e5c19a())
		{
			function_5b16217f();
			var_805dab64 = 1;
		}
		else
		{
			wait(2);
		}
	}
}

/*
	Name: function_5b16217f
	Namespace: namespace_7d8e6ec3
	Checksum: 0xA7416FF0
	Offset: 0x6860
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_5b16217f()
{
	level endon(#"hash_1a91b42d31e0b28d");
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_45f67ba6693762f7", 0, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_45f67ba6693762f7", 1, 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_45f67ba6693762f7", 2, 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_45f67ba6693762f7", 3, 0, 1);
}

/*
	Name: function_792d350a
	Namespace: namespace_7d8e6ec3
	Checksum: 0xB53EACC0
	Offset: 0x6940
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_792d350a(b_pause = 1)
{
	level.var_fb7b424 = b_pause;
}

/*
	Name: function_a74f51a8
	Namespace: namespace_7d8e6ec3
	Checksum: 0x18E8D237
	Offset: 0x6978
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_a74f51a8(e_player)
{
	return level.var_fb7b424 !== 1;
}

