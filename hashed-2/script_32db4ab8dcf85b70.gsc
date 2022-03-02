// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_28b18e98462a3c7c;
#using script_3e5ec44cfab7a201;
#using script_3f9e0dc8454d98e1;
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_57f7003580bb15e0;
#using script_58c342edd81589fb;
#using script_5bb072c3abf4652c;
#using script_676fc0767562bc02;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6ce38ab036223e6e;
#using script_ab862743b3070a;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_trap_electric.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_92cb027a;

/*
	Name: preload
	Namespace: namespace_92cb027a
	Checksum: 0xE95EB8D5
	Offset: 0xBB0
	Size: 0x34C
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	s_apd = struct::get("cp_toast_apd", "script_noteworthy");
	s_diner = struct::get("cp_toast_diner", "script_noteworthy");
	s_lounge = struct::get("cp_toast_lounge", "script_noteworthy");
	s_storage = struct::get("cp_toast_storage", "script_noteworthy");
	s_beds = struct::get("cp_toast_beds", "script_noteworthy");
	namespace_617a54f4::function_d8383812(#"sc_toast_apd", 8000, s_apd, &function_cdcaffd1, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"hash_79bfedd79fde9574", 8000, s_diner, &function_cdcaffd1, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"hash_6de0dca7b8c02116", 8000, s_lounge, &function_cdcaffd1, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"hash_63c249049e8fab1d", 8000, s_storage, &function_cdcaffd1, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"hash_65c89350fbe358b0", 8000, s_beds, &function_cdcaffd1, &function_3bdbb583, 1);
	clientfield::register("scriptmover", "soul_capture_filled", 1, 1, "int");
	clientfield::register("scriptmover", "soul_capture_depleted", 1, 1, "int");
	clientfield::register("zbarrier", "discharge_pap", 1, 1, "int");
	clientfield::register("scriptmover", "discharge_perk", 1, 1, "int");
	clientfield::register("scriptmover", "discharge_wallbuy", 1, 1, "int");
}

/*
	Name: init
	Namespace: namespace_92cb027a
	Checksum: 0xB2ECCFBE
	Offset: 0xF08
	Size: 0x5CC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init("world_is_paused");
	level flag::init(#"hash_48039f3a4c1a3248");
	level flag::init(#"hash_56dcbeaf295dd09e");
	level flag::init(#"toast_final_charge");
	namespace_ee206246::register(#"boss_battle", #"hash_46f2c0a9943a3b4", #"hash_46f2c0a9943a3b4", &function_5ac09481, &function_43d699d6, 1);
	namespace_ee206246::start(#"boss_battle");
	level function_d30f74b8();
	level apd_computer_screens_init();
	level waittill(#"start_zombie_round_logic");
	level.var_65e355f = 0;
	level.var_5233174e = 0;
	level.var_c01b1042 = 100;
	level.var_433834a2 = [];
	var_6a4f5b8f = struct::get_array("toast_reward", "targetname");
	foreach(struct in var_6a4f5b8f)
	{
		if(!isdefined(level.var_433834a2[struct.script_noteworthy]))
		{
			level.var_433834a2[struct.script_noteworthy] = [];
		}
		else if(!isarray(level.var_433834a2[struct.script_noteworthy]))
		{
			level.var_433834a2[struct.script_noteworthy] = array(level.var_433834a2[struct.script_noteworthy]);
		}
		if(!isinarray(level.var_433834a2[struct.script_noteworthy], struct))
		{
			level.var_433834a2[struct.script_noteworthy][level.var_433834a2[struct.script_noteworthy].size] = struct;
		}
	}
	vol_intro_blocker = getent("intro_blocker", "targetname");
	vol_intro_blocker notsolid();
	vol_apd_console = getent("vol_apd_console", "targetname");
	vol_apd_console hide();
	level.var_ee92bf8c = getent("nugget", "targetname");
	level.var_ee92bf8c playloopsound(#"hash_52058ae478647502");
	level.var_ee92bf8c hide();
	if(!isdefined(level.var_f9fe0920))
	{
		level.var_f9fe0920 = [];
	}
	else if(!isarray(level.var_f9fe0920))
	{
		level.var_f9fe0920 = array(level.var_f9fe0920);
	}
	level.var_f9fe0920 = struct::get_array("toast_capture_point", "targetname");
	foreach(canister in level.var_f9fe0920)
	{
		canister thread function_ffa1c335();
		canister.fx_handle = util::spawn_model("tag_origin", canister.origin + (vectorscale((0, 0, -1), 56)));
		if(canister.script_int === 1 && canister.script_noteworthy != "cp_toast_apd")
		{
			canister function_8c2bda65(1, 0);
		}
	}
	namespace_9cf755b::function_6f635c39("apd_lockdown");
	namespace_9cf755b::function_985c08e7();
}

/*
	Name: function_5ac09481
	Namespace: namespace_92cb027a
	Checksum: 0x4BB6A3D4
	Offset: 0x14E0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_5ac09481(b_skipped)
{
	level endon(#"end_game", #"hash_46f2c0a9943a3b4" + "_ended_early");
	while(!level flag::exists(#"hash_5aa1c9627e8626e0"))
	{
		wait(1);
	}
	level flag::wait_till(#"hash_5aa1c9627e8626e0");
}

/*
	Name: function_43d699d6
	Namespace: namespace_92cb027a
	Checksum: 0x762E10DF
	Offset: 0x1578
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_43d699d6(b_skipped, var_19e802fa)
{
	level flag::set(#"hash_5aa1c9627e8626e0");
}

/*
	Name: function_94c0714
	Namespace: namespace_92cb027a
	Checksum: 0xFECECF43
	Offset: 0x15B8
	Size: 0x3CC
	Parameters: 0
	Flags: Linked
*/
function function_94c0714()
{
	level endon(#"hash_2b7c76b6b0dfc0fd");
	level flag::set("bunker_boss_event");
	level.var_f8fdb172 function_13456343();
	level thread function_1e689ec8();
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	function_c88a99db(#"hash_5889e925689d6ce2");
	level.var_b2b15659 = 1;
	level.zmannouncerprefix = "";
	level.musicsystemoverride = 1;
	music::setmusicstate("boss_battle_preamble");
	level.var_f8fdb172 function_2a8ad7ea();
	level notify(#"hash_366807a48fc105bb");
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	zm_bgb_anywhere_but_here::function_886fce8f(0);
	apd_lockdown();
	namespace_509a75d1::function_2ba419ee(0);
	level namespace_509a75d1::function_314447b(0);
	vol_intro_blocker = getent("intro_blocker", "targetname");
	vol_intro_blocker solid();
	level flag::set(#"infinite_round_spawning");
	level flag::set(#"pause_round_timeout");
	level flag::set("world_is_paused");
	namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 thread namespace_509a75d1::function_6a0d675d(#"hash_46be55ed9729001b", 0, 0);
	level flag::clear("world_is_paused");
	namespace_617a54f4::function_3f808d3d("sc_toast_apd");
	s_apd = struct::get("cp_toast_apd", "script_noteworthy");
	while(!s_apd.charged)
	{
		wait(1);
	}
	level flag::set(#"hash_2b7c76b6b0dfc0fd");
}

/*
	Name: function_ca3759b1
	Namespace: namespace_92cb027a
	Checksum: 0xDDDD5C23
	Offset: 0x1990
	Size: 0x1524
	Parameters: 0
	Flags: Linked
*/
function function_ca3759b1()
{
	level endon(#"boss_fight_complete", #"end_game");
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	level flag::set("world_is_paused");
	namespace_509a75d1::function_2ba419ee(0);
	wait(0.5);
	foreach(canister in level.var_f9fe0920)
	{
		if(canister.script_int == 1)
		{
			canister thread function_8c2bda65(3, 1);
		}
	}
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	music::setmusicstate("boss_battle_avogadro_intro");
	exploder::exploder("fxexp_pyramid_open");
	var_1c91a56e = struct::get("apd_door_scene", "targetname");
	var_1c91a56e scene::play("open");
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	spawn_boss();
	exploder::exploder("fxexp_avo_elec_floor");
	namespace_509a75d1::function_3c173d37();
	level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"vox_boss_release", 0, 0, 1);
	namespace_509a75d1::function_3c173d37();
	namespace_509a75d1::function_fd24e47f("vox_boss_release", 1, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_boss_release", 2, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"vox_boss_release", 3, 0, 1);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	function_5ef0416();
	namespace_9cf755b::function_6f635c39("boss_lockdown");
	namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"vox_boss_release", 4, 0);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	playsoundatposition(#"hash_274493fd61d94d73", (0, 0, 0));
	playsoundatposition(#"hash_1fc67d7ad7445bbf", (-521, -1972, -82));
	playsoundatposition(#"hash_1fc67c7ad7445a0c", (-1146, -1956, -92));
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_ncom_0");
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_ten_ncom_0");
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_nine_ncom_0");
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_eight_ncom_0");
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_seven_ncom_0");
	playsoundatposition(#"hash_5dddf55133ac4bcf", (-576, -1992, -87));
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_six_ncom_0");
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_five_ncom_0");
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_four_ncom_0");
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_three_ncom_0");
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_two_ncom_0");
	level namespace_9cf755b::function_ec34b5ee("vox_boss_nuke_count_one_ncom_0");
	foreach(player in getplayers())
	{
		player thread function_a29438da();
	}
	level thread lui::screen_flash(0.1, 0.6, 1.5, 0.8, "white");
	playsoundatposition(#"hash_782025025ec70d68", (0, 0, 0));
	exploder::exploder("fxexp_nuke_event");
	wait(2);
	namespace_509a75d1::function_3c173d37();
	wait(2);
	level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"hash_5233a87eed32231a", 0, 0);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	if(isdefined(level.var_43c333a8))
	{
		level.var_43c333a8 notify(#"intro_done");
	}
	exploder::stop_exploder("fxexp_avo_elec_floor");
	vol_intro_blocker = getent("intro_blocker", "targetname");
	vol_intro_blocker notsolid();
	music::setmusicstate("boss_battle_stage_1");
	namespace_9cf755b::function_f2fa71ce();
	namespace_9cf755b::function_364cd8c0("apd_lockdown");
	level flag::clear("world_is_paused");
	level.var_f8fdb172 function_3ea7f25d();
	level thread function_4a73d084();
	level thread function_abb0b62();
	level thread function_1cc4b08e();
	level thread function_927c0f2e();
	level thread function_8149ceff();
	level thread function_1fba7fc2();
	var_3942c56 = [];
	var_46db9038 = array("cp_toast_lounge", "cp_toast_diner", "cp_toast_storage");
	foreach(str in var_46db9038)
	{
		var_49cec412 = struct::get(str, "script_noteworthy");
		var_49cec412 zm_unitrigger::create(&function_80a202c1, (72, 72, 128), undefined, 1, 1);
		var_49cec412 thread function_dbbdda4c();
		if(!isdefined(var_3942c56))
		{
			var_3942c56 = [];
		}
		else if(!isarray(var_3942c56))
		{
			var_3942c56 = array(var_3942c56);
		}
		var_3942c56[var_3942c56.size] = var_49cec412;
	}
	while(function_875983ad(var_3942c56))
	{
		wait(1);
	}
	var_88c6a045 = struct::get("cp_toast_beds", "script_noteworthy");
	var_88c6a045 zm_unitrigger::create(&function_80a202c1, (72, 72, 128), undefined, 1, 1);
	var_88c6a045 thread function_dbbdda4c();
	level flag::wait_till("toast_final_charge");
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	level thread function_26739c84();
	exploder::exploder("fxexp_pyramid_capture");
	level.vol_toast_trap = getent("vol_toast_trap", "targetname");
	while(isdefined(level.var_43c333a8) && !level.var_43c333a8 istouching(level.vol_toast_trap))
	{
		wait(0.1);
	}
	level notify(#"hash_7b64b40fb601fb93");
	namespace_509a75d1::function_3c173d37();
	level.var_ee92bf8c.name = "avog";
	level.var_ee92bf8c thread namespace_509a75d1::function_6a0d675d(#"hash_1617ecba0bd3c76c", 3, 0);
	music::setmusicstate("none");
	while(isdefined(level.var_43c333a8))
	{
		wait(0.1);
	}
	level thread function_3418b6f6();
	namespace_509a75d1::function_314447b(1, 0);
	wait(2);
	namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_1617ecba0bd3c76c", 1, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_1617ecba0bd3c76c", 2, 0, 1);
	level.var_f8fdb172 function_43124a8f();
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	function_3b0da1a8(#"hash_17f86af9c5a89e4e");
	level.var_f8fdb172 function_2a8ad7ea();
	exploder::exploder("fxexp_pyramid_transmit");
	playsoundatposition(#"hash_5c68b001a4e41ad3", (0, 0, 0));
	var_94db4a2f = struct::get("cp_toast_apd_diner", "script_noteworthy");
	var_94db4a2f thread function_8c2bda65(3, 1);
	var_59c92575 = struct::get("cp_toast_apd_lounge", "script_noteworthy");
	var_59c92575 thread function_8c2bda65(3, 1);
	var_e2649117 = struct::get("cp_toast_apd", "script_noteworthy");
	var_e2649117 thread function_8c2bda65(3, 1);
	var_6bff6faa = struct::get("cp_toast_apd_beds", "script_noteworthy");
	var_6bff6faa thread function_8c2bda65(3, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_ee92bf8c namespace_509a75d1::function_6a0d675d(#"vox_boss_success", 0, 0, 1);
	level function_45b60e0e();
	level function_976e7caa();
	level function_2cdb9672();
	level function_54f91945();
	wait(1.5);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	level notify(#"boss_teleported");
	level.musicsystemoverride = 0;
	exploder::exploder_stop("fxexp_elec_lounge");
	exploder::exploder_stop("fxexp_elec_diner");
	exploder::exploder_stop("fxexp_elec_storage");
	exploder::exploder_stop("fxexp_elec_beds");
	level.pack_a_punch.trigger_stubs[0] function_cf62f3c7();
	foreach(var_5baafbb2 in level.var_76a7ad28)
	{
		var_5baafbb2 function_cf62f3c7();
	}
	foreach(s_wallbuy in level._spawned_wallbuys)
	{
		s_wallbuy.trigger_stub function_cf62f3c7();
	}
	level s_construction_push_point_a_markets();
	level flag::set(#"boss_fight_complete");
}

/*
	Name: function_a29438da
	Namespace: namespace_92cb027a
	Checksum: 0x2CED3506
	Offset: 0x2EC0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_a29438da()
{
	self playrumbleonentity("zm_white_nuke_impact");
	wait(0.7);
	self playrumbleonentity("zm_white_nuke_wind");
	wait(1);
	self playrumbleonentity("zm_white_nuke_aftershock");
	wait(1);
	if(isdefined(self))
	{
		self clientfield::increment("sndRattle", 1);
	}
}

/*
	Name: function_3418b6f6
	Namespace: namespace_92cb027a
	Checksum: 0x4AD9D5AC
	Offset: 0x2F70
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_3418b6f6()
{
	var_1c91a56e = struct::get("apd_door_scene", "targetname");
	var_1c91a56e thread scene::play("close");
	wait(2);
	exploder::exploder_stop("fxexp_pyramid_open");
	exploder::exploder_stop("fxexp_pyramid_capture");
}

/*
	Name: function_875983ad
	Namespace: namespace_92cb027a
	Checksum: 0x8FF5D563
	Offset: 0x3000
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function function_875983ad(var_3942c56)
{
	foreach(s_point in var_3942c56)
	{
		if(!s_point.charged)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_c88a99db
	Namespace: namespace_92cb027a
	Checksum: 0x7FBFDB56
	Offset: 0x3090
	Size: 0x1AC
	Parameters: 1
	Flags: Linked
*/
function function_c88a99db(str_hint)
{
	vol_apd_console = getent("vol_apd_console", "targetname");
	vol_apd_console show();
	vol_apd_console sethintstring(str_hint);
	b_wait = 1;
	while(b_wait)
	{
		b_wait = 0;
		foreach(player in getplayers())
		{
			if(!(player istouching(vol_apd_console) && player usebuttonpressed()) && zm_utility::is_player_valid(player, 0, 1))
			{
				b_wait = 1;
			}
		}
		waitframe(1);
	}
	vol_apd_console playsound("evt_computer_interact");
	vol_apd_console sethintstring(#"");
	vol_apd_console hide();
}

/*
	Name: function_3b0da1a8
	Namespace: namespace_92cb027a
	Checksum: 0xE8D447D4
	Offset: 0x3248
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_3b0da1a8(str_hint)
{
	vol_apd_console = getent("vol_apd_console", "targetname");
	vol_apd_console show();
	vol_apd_console sethintstring(str_hint);
	b_wait = 1;
	while(b_wait)
	{
		foreach(player in getplayers())
		{
			if(player istouching(vol_apd_console) && player usebuttonpressed() && zm_utility::is_player_valid(player, 0, 1))
			{
				b_wait = 0;
			}
		}
		waitframe(1);
	}
	vol_apd_console sethintstring(#"");
	vol_apd_console hide();
}

/*
	Name: function_1e689ec8
	Namespace: namespace_92cb027a
	Checksum: 0xF008954D
	Offset: 0x33D8
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_1e689ec8()
{
	level endon(#"hash_366807a48fc105bb");
	namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_boss_intro", 0, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_boss_intro", 1, 0, 1);
	namespace_509a75d1::function_3c173d37();
	namespace_509a75d1::function_fd24e47f("vox_boss_intro", -1, 0, 1);
}

/*
	Name: function_4a73d084
	Namespace: namespace_92cb027a
	Checksum: 0x3ECEA551
	Offset: 0x34B0
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_4a73d084()
{
	level endon(#"hash_56dcbeaf295dd09e");
	namespace_509a75d1::function_3c173d37();
	namespace_509a75d1::function_fd24e47f("vox_boss_canister_instruct", 0, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_boss_canister_instruct", 1, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_boss_canister_instruct", 3, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"vox_boss_canister_instruct", 4, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_boss_canister_instruct", 5, 0, 1);
}

/*
	Name: function_26739c84
	Namespace: namespace_92cb027a
	Checksum: 0x7BC0C4DD
	Offset: 0x3608
	Size: 0x1A2
	Parameters: 0
	Flags: Linked
*/
function function_26739c84()
{
	level endon(#"hash_7b64b40fb601fb93");
	namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_e23ab83d54dcb8c", 0, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_e23ab83d54dcb8c", 1, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"hash_599ad19acca1d1c8", 3, 0, 1);
	vol_beds = getent("vol_soul_beds", "targetname");
	if(level.var_43c333a8 istouching(vol_beds))
	{
		vol_test = getent("vol_soul_generators", "targetname");
		vol_test.var_72f7bafe = struct::get_array("vol_soul_generators", "script_noteworthy");
		level.var_43c333a8.var_885c1824 = vol_test;
		wait(2);
		level.var_43c333a8.var_885c1824 = undefined;
	}
}

/*
	Name: s_construction_push_point_a_markets
	Namespace: namespace_92cb027a
	Checksum: 0xA66692A1
	Offset: 0x37B8
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function s_construction_push_point_a_markets()
{
	level endon(#"hash_5aa1c9627e8626e0");
	namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"vox_boss_success", 1, 0, 1);
	namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"vox_boss_success", 2, 0, 1);
	namespace_509a75d1::function_3c173d37();
	namespace_509a75d1::function_fd24e47f("vox_boss_success", 3, 0, 1);
}

/*
	Name: apd_lockdown
	Namespace: namespace_92cb027a
	Checksum: 0x8BC385AF
	Offset: 0x3890
	Size: 0x57E
	Parameters: 0
	Flags: Linked
*/
function apd_lockdown()
{
	namespace_9cf755b::function_985c08e7();
	namespace_9cf755b::function_6f635c39("apd_lockdown");
	function_b58e5865();
	foreach(zone in level.zones)
	{
		if(zone.name != "zone_bunker_apd")
		{
			zone.is_enabled = 0;
		}
	}
	level.var_868c98df = 0;
	var_63fca02d = struct::get_array("white_portal");
	foreach(s_portal in var_63fca02d)
	{
		s_portal thread namespace_1846c963::function_978923cd();
		s_portal.b_active = 0;
		if(isdefined(s_portal.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(s_portal.s_unitrigger);
		}
	}
	foreach(var_5f41c401 in level.var_4fe2f84d)
	{
		foreach(s_crafting in var_5f41c401)
		{
			if(isdefined(s_crafting.var_ae360c37))
			{
				s_crafting.var_ae360c37 hide();
			}
			if(isarray(s_crafting.craftfoundry.blueprints))
			{
				foreach(var_6645c992 in s_crafting.craftfoundry.blueprints)
				{
					if(var_6645c992.name === "zblueprint_zhield_white")
					{
						s_crafting.blueprint = var_6645c992;
						zm_unitrigger::unregister_unitrigger(s_crafting);
						s_crafting zm_crafting::function_6dccf508();
						s_crafting zm_crafting::function_a187b293();
					}
				}
			}
		}
	}
	var_58d9e0d3 = getitemarray();
	foreach(var_2e1f34dd in var_58d9e0d3)
	{
		var_9c95ad05 = var_2e1f34dd.item;
		if(isdefined(var_9c95ad05) && (isdefined(var_9c95ad05.var_52a84c7a) && var_9c95ad05.var_52a84c7a) && (var_9c95ad05.name == #"hash_79bb43e8065dc831" || var_9c95ad05.name == #"hash_79bb40e8065dc318" || var_9c95ad05.name == #"hash_79bb41e8065dc4cb"))
		{
			e_player = array::random(getplayers());
			zm_items::player_pick_up(e_player, var_9c95ad05);
			var_2e1f34dd delete();
		}
	}
	if(isdefined(level.var_279a11a3))
	{
		level.var_279a11a3.related_parent hide();
		zm_unitrigger::unregister_unitrigger(level.var_279a11a3);
	}
	level._zombiemode_custom_box_move_logic = &function_979d1e2;
	level.var_401aaa92 = 1;
}

/*
	Name: function_5ef0416
	Namespace: namespace_92cb027a
	Checksum: 0xFF91C20C
	Offset: 0x3E18
	Size: 0x2E8
	Parameters: 0
	Flags: Linked
*/
function function_5ef0416()
{
	var_b2f7a245 = array("zone_bunker_lounge", "zone_bunker_diner", "zone_bunker_beds_1", "zone_bunker_beds_2", "zone_bunker_power_1", "zone_bunker_power_2", "zone_bunker_storage", "zone_bunker_solitary");
	foreach(zone in var_b2f7a245)
	{
		level.zones[zone].is_enabled = 1;
	}
	if(!level flag::get(#"pap_power_ready"))
	{
		level flag::set(#"pap_power_ready");
	}
	while(!isdefined(level.pack_a_punch.trigger_stubs[0].trigger_func))
	{
		waitframe(1);
	}
	level.pack_a_punch.trigger_stubs[0] function_641f4ec(&function_a96ea498, &function_c6c9b014, 5000, "discharge_pap");
	foreach(var_5baafbb2 in level.var_76a7ad28)
	{
		var_5baafbb2 function_641f4ec(&function_c03c3007, &function_c6c9b014, 3000, "discharge_perk");
	}
	foreach(s_wallbuy in level._spawned_wallbuys)
	{
		s_wallbuy.trigger_stub function_641f4ec(&function_91256361, &function_c6c9b014, 3000, "discharge_wallbuy");
	}
}

/*
	Name: function_979d1e2
	Namespace: namespace_92cb027a
	Checksum: 0x7B2892D8
	Offset: 0x4108
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_979d1e2()
{
	for(i = 0; i < level.chests.size; i++)
	{
		if(level.chests[i].script_noteworthy == "start1_chest")
		{
			level.chest_index = i;
			break;
		}
	}
}

/*
	Name: function_641f4ec
	Namespace: namespace_92cb027a
	Checksum: 0x19BF910F
	Offset: 0x4178
	Size: 0x1CC
	Parameters: 4
	Flags: Linked
*/
function function_641f4ec(var_ae5725a9, lockdown_trigger_func, unlock_cost, client_fx)
{
	self.client_fx = client_fx;
	if(client_fx === "discharge_perk")
	{
		self zm_perks::function_a30c73b9("off");
		self.var_3468124.var_73bd396b clientfield::set(client_fx, 1);
	}
	else
	{
		if(client_fx === "discharge_pap")
		{
			self.pap_machine clientfield::set(client_fx, 1);
		}
		else
		{
			target1 = struct::get(self.target, "targetname");
			self.var_13aacf99 = getent(target1.target, "targetname");
			self.var_13aacf99 clientfield::set(client_fx, 1);
		}
	}
	if(!isdefined(self.var_a0fc37f6))
	{
		self.var_a0fc37f6 = self.prompt_and_visibility_func;
	}
	if(!isdefined(self.var_492080a5))
	{
		self.var_492080a5 = self.trigger_func;
	}
	self.unlock_func = &function_cf62f3c7;
	self.var_534571f = unlock_cost;
	self.trigger_func = lockdown_trigger_func;
	self.prompt_and_visibility_func = var_ae5725a9;
	zm_unitrigger::reregister_unitrigger(self);
}

/*
	Name: function_cf62f3c7
	Namespace: namespace_92cb027a
	Checksum: 0x6510CDD0
	Offset: 0x4350
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_cf62f3c7()
{
	if(isdefined(self.client_fx))
	{
		if(self.client_fx === "discharge_perk")
		{
			self zm_perks::function_a30c73b9("off");
			self.var_3468124.var_73bd396b clientfield::set(self.client_fx, 0);
		}
		else
		{
			if(self.client_fx === "discharge_pap")
			{
				self.pap_machine clientfield::set(self.client_fx, 0);
			}
			else
			{
				self.var_13aacf99 clientfield::set(self.client_fx, 0);
			}
		}
	}
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
	Namespace: namespace_92cb027a
	Checksum: 0x385C68D2
	Offset: 0x4480
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_c03c3007(e_player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_5436ed3c090b1b5b", #"hash_4b3c40d9079f38d1");
	self sethintstring(str_prompt);
	return true;
}

/*
	Name: function_91256361
	Namespace: namespace_92cb027a
	Checksum: 0xF5BC54A1
	Offset: 0x44E8
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_91256361(e_player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_3262580790190195", #"hash_1c978c7c32d6accb");
	self sethintstring(str_prompt);
	return true;
}

/*
	Name: function_a96ea498
	Namespace: namespace_92cb027a
	Checksum: 0x336A2FC4
	Offset: 0x4550
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_a96ea498(e_player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_3cedf7684da7e8a8", #"hash_2755ffa17bc473e4");
	self sethintstring(str_prompt);
	return true;
}

/*
	Name: function_c6c9b014
	Namespace: namespace_92cb027a
	Checksum: 0x4071C190
	Offset: 0x45B8
	Size: 0x19C
	Parameters: 1
	Flags: Linked
*/
function function_c6c9b014(e_player)
{
	self endon(#"death");
	level endon(#"end_game");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!isdefined(player))
		{
			continue;
		}
		if(!zm_perks::vending_trigger_can_player_use(player, 1))
		{
			continue;
		}
		if(!player zm_score::can_player_purchase(self.stub.var_534571f))
		{
			zm_utility::play_sound_on_ent("no_purchase");
			player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
			continue;
		}
		player zm_score::minus_to_player_score(self.stub.var_534571f);
		playsoundatposition(#"hash_6b9160d5f97e5ecb", self.origin);
		player thread shock_player();
		waitframe(1);
		self.stub thread [[self.stub.unlock_func]]();
	}
}

/*
	Name: function_297251d8
	Namespace: namespace_92cb027a
	Checksum: 0x6F8313F1
	Offset: 0x4760
	Size: 0x16A
	Parameters: 0
	Flags: Linked
*/
function function_297251d8()
{
	level endon(#"game_ended", #"boss_teleported");
	var_5b857980 = function_4d1e7b48(#"hash_320c81d91eb89d73");
	while(!level flag::get(#"boss_fight_complete"))
	{
		foreach(player in getplayers())
		{
			if(player istouching(self))
			{
				player playrumbleonentity("damage_heavy");
				player playsound(#"hash_5af2a9d11f007b9");
				player status_effect::status_effect_apply(var_5b857980, undefined, self, 1);
			}
		}
		wait(1);
	}
}

/*
	Name: shock_player
	Namespace: namespace_92cb027a
	Checksum: 0xF093DE89
	Offset: 0x48D8
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function shock_player(n_damage = 50)
{
	var_5b857980 = function_4d1e7b48(#"hash_19533caf858a9f3b");
	self thread player_elec_damage(n_damage);
	self status_effect::status_effect_apply(var_5b857980, undefined, self, 0);
}

/*
	Name: player_elec_damage
	Namespace: namespace_92cb027a
	Checksum: 0xB2491195
	Offset: 0x4960
	Size: 0xDA
	Parameters: 1
	Flags: Linked
*/
function player_elec_damage(n_damage)
{
	self endon(#"death", #"disconnect");
	if(!(isdefined(self.is_burning) && self.is_burning) && zm_utility::is_player_valid(self))
	{
		self.is_burning = 1;
		self playrumbleonentity("damage_heavy");
		self playsound(#"hash_5af2a9d11f007b9");
		self dodamage(n_damage, self.origin, undefined);
		wait(1);
		self.is_burning = undefined;
	}
}

/*
	Name: spawn_boss
	Namespace: namespace_92cb027a
	Checksum: 0xDA16E772
	Offset: 0x4A48
	Size: 0x344
	Parameters: 0
	Flags: Linked
*/
function spawn_boss()
{
	level.var_43c333a8 = zombie_utility::spawn_zombie(getent("avogadro_spawner", "targetname"), undefined, undefined);
	level.var_43c333a8.var_885c1824 = undefined;
	level.var_43c333a8.var_a8161b1a = getent("vol_avogadro_no_charge", "targetname");
	level.var_43c333a8.vol_retreat = getent("vol_avogadro_retreat", "targetname");
	level.var_43c333a8.var_77ef4a35 = struct::get("avogadro_retreat_point", "targetname");
	level.var_43c333a8 thread function_e5e69e2c();
	level.var_43c333a8.name = "avog";
	level.var_43c333a8.isspeaking = 0;
	level.var_43c333a8.var_5b6ebfd0 = 0;
	level.var_43c333a8 playloopsound(#"hash_43d41833f5950a8d");
	var_ecec4136 = array("vol_soul_beds", "vol_soul_diner", "vol_soul_lounge", "vol_soul_storage");
	var_54037511 = [];
	foreach(str in var_ecec4136)
	{
		if(!isdefined(var_54037511))
		{
			var_54037511 = [];
		}
		else if(!isarray(var_54037511))
		{
			var_54037511 = array(var_54037511);
		}
		var_54037511[var_54037511.size] = getent(str, "targetname");
	}
	foreach(vol in var_54037511)
	{
		vol.var_72f7bafe = struct::get_array(vol.targetname, "script_noteworthy");
	}
	if(isdefined(level.door_powerup))
	{
		level notify(#"magic_door_power_up_grabbed");
		level.door_powerup zm_powerups::powerup_delete();
	}
}

/*
	Name: function_abb0b62
	Namespace: namespace_92cb027a
	Checksum: 0xA51A006E
	Offset: 0x4D98
	Size: 0x236
	Parameters: 0
	Flags: Linked
*/
function function_abb0b62()
{
	level endon(#"game_ended", #"toast_final_charge");
	var_51f3793d = 0;
	var_733f4178 = array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
	var_733f4178 = array::randomize(var_733f4178);
	i = 0;
	while(true)
	{
		wait(function_21a3a673(5, 10));
		b_spoke = 0;
		var_adea2587 = undefined;
		var_adea2587 = level waittill(#"hash_7edbeeb2b6f53bfe");
		e_player = var_adea2587.e_player;
		if(!var_51f3793d)
		{
			if(e_player zm_audio::function_65e5c19a())
			{
				namespace_509a75d1::function_3c173d37();
				e_player namespace_509a75d1::function_51b752a9(#"hash_2260a354cf8d04c1", -1, 0, 1);
				var_51f3793d = 1;
				b_spoke = 1;
			}
		}
		else if(isdefined(level.var_43c333a8))
		{
			if(level.var_43c333a8 zm_audio::function_65e5c19a())
			{
				var_ca2331b5 = var_733f4178[i];
				namespace_509a75d1::function_3c173d37();
				level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"hash_2260a354cf8d04c1", var_ca2331b5, 0, 1);
				b_spoke = 1;
				i++;
			}
		}
		if(i >= var_733f4178.size)
		{
			return;
		}
		if(b_spoke)
		{
			wait(30);
		}
	}
}

/*
	Name: function_1cc4b08e
	Namespace: namespace_92cb027a
	Checksum: 0x5196E16D
	Offset: 0x4FD8
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function function_1cc4b08e()
{
	level endon(#"game_ended", #"hash_7b64b40fb601fb93");
	while(true)
	{
		wait(function_21a3a673(5, 10));
		b_spoke = 0;
		var_adea2587 = undefined;
		var_adea2587 = level waittill(#"hash_3a603bc69204f012");
		if(isdefined(level.var_43c333a8))
		{
			if(level.var_43c333a8 zm_audio::function_65e5c19a())
			{
				namespace_509a75d1::function_3c173d37();
				level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"hash_4f74505970e866da", -1, 0, 1);
				b_spoke = 1;
			}
		}
		if(b_spoke)
		{
			wait(30);
		}
	}
}

/*
	Name: function_927c0f2e
	Namespace: namespace_92cb027a
	Checksum: 0x1047940
	Offset: 0x50E8
	Size: 0x254
	Parameters: 0
	Flags: Linked
*/
function function_927c0f2e()
{
	level endon(#"game_ended", #"hash_7b64b40fb601fb93");
	while(true)
	{
		b_spoke = 0;
		var_adea2587 = undefined;
		var_adea2587 = level waittill(#"hash_4cbbb6dfc789393f");
		if(isdefined(level.var_43c333a8))
		{
			players = getplayers();
			valid_players = [];
			foreach(player in players)
			{
				str_name = player zm_vo::function_82f9bc9f();
				if(zm_utility::is_player_valid(player) && player cansee(level.var_43c333a8))
				{
					if(!isdefined(valid_players))
					{
						valid_players = [];
					}
					else if(!isarray(valid_players))
					{
						valid_players = array(valid_players);
					}
					valid_players[valid_players.size] = player;
				}
			}
			if(valid_players.size > 0)
			{
				e_player = arraygetclosest(level.var_43c333a8.origin, valid_players);
				if(e_player zm_audio::function_65e5c19a())
				{
					namespace_509a75d1::function_3c173d37();
					e_player namespace_509a75d1::function_51b752a9(#"hash_3a561b214fd1c2f5", -1, 0, 1);
					b_spoke = 1;
				}
			}
		}
		if(b_spoke)
		{
			wait(60);
		}
		waitframe(1);
	}
}

/*
	Name: function_8149ceff
	Namespace: namespace_92cb027a
	Checksum: 0x81FFD546
	Offset: 0x5348
	Size: 0x254
	Parameters: 0
	Flags: Linked
*/
function function_8149ceff()
{
	level endon(#"game_ended", #"hash_7b64b40fb601fb93");
	while(true)
	{
		b_spoke = 0;
		var_adea2587 = undefined;
		var_adea2587 = level waittill(#"hash_498ebb296003fd76");
		if(isdefined(level.var_43c333a8))
		{
			players = getplayers();
			valid_players = [];
			foreach(player in players)
			{
				str_name = player zm_vo::function_82f9bc9f();
				if(zm_utility::is_player_valid(player) && player cansee(level.var_43c333a8))
				{
					if(!isdefined(valid_players))
					{
						valid_players = [];
					}
					else if(!isarray(valid_players))
					{
						valid_players = array(valid_players);
					}
					valid_players[valid_players.size] = player;
				}
			}
			if(valid_players.size > 0)
			{
				e_player = arraygetclosest(level.var_43c333a8.origin, valid_players);
				if(e_player zm_audio::function_65e5c19a())
				{
					namespace_509a75d1::function_3c173d37();
					e_player namespace_509a75d1::function_51b752a9(#"hash_79b9be92b942990d", -1, 0, 1);
					b_spoke = 1;
				}
			}
		}
		if(b_spoke)
		{
			wait(60);
		}
		waitframe(1);
	}
}

/*
	Name: function_1fba7fc2
	Namespace: namespace_92cb027a
	Checksum: 0x1C3D90FF
	Offset: 0x55A8
	Size: 0x4E6
	Parameters: 0
	Flags: Linked
*/
function function_1fba7fc2()
{
	level endon(#"game_ended", #"hash_7b64b40fb601fb93");
	a_taunts = [];
	a_taunts[#"niko"] = array::randomize(array(0, 1, 2, 3));
	a_taunts[#"demp"] = array::randomize(array(0, 1, 2, 3));
	a_taunts[#"rich"] = array::randomize(array(0, 1, 2, 3));
	a_taunts[#"take"] = array::randomize(array(0, 1, 2, 3));
	a_taunts[#"unik"] = array::randomize(array(0, 1, 2, 3));
	a_taunts[#"udem"] = array::randomize(array(0, 1, 2, 3));
	a_taunts[#"uric"] = array::randomize(array(0, 1, 2, 3));
	a_taunts[#"utak"] = array::randomize(array(0, 1, 2, 3));
	var_4854a91b = "vox_boss_taunt_";
	while(true)
	{
		b_spoke = 0;
		wait(function_21a3a673(30, 60));
		if(isdefined(level.var_43c333a8))
		{
			players = getplayers();
			valid_players = [];
			foreach(player in players)
			{
				str_name = player zm_vo::function_82f9bc9f();
				if(zm_utility::is_player_valid(player) && a_taunts[str_name].size > 0)
				{
					if(!isdefined(valid_players))
					{
						valid_players = [];
					}
					else if(!isarray(valid_players))
					{
						valid_players = array(valid_players);
					}
					valid_players[valid_players.size] = player;
				}
			}
			if(valid_players.size > 0)
			{
				var_d1e952c4 = array::random(valid_players);
				str_name = var_d1e952c4 zm_vo::function_82f9bc9f();
				if(var_d1e952c4 zm_audio::function_65e5c19a())
				{
					alias = ((var_4854a91b + str_name) + "_avog_") + a_taunts[str_name][0];
					namespace_509a75d1::function_3c173d37();
					var_d1e952c4 zm_audio::do_player_or_npc_playvox(alias, 1);
					arrayremoveindex(a_taunts[str_name], 0);
					b_spoke = 1;
				}
			}
		}
		if(b_spoke)
		{
			wait(60);
		}
	}
}

/*
	Name: function_e5e69e2c
	Namespace: namespace_92cb027a
	Checksum: 0xF9FEB64
	Offset: 0x5A98
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function function_e5e69e2c()
{
	self endon(#"death");
	while(true)
	{
		var_9a61376 = [];
		foreach(powerup in level.active_powerups)
		{
			dist = distancesquared(self.origin, powerup.origin);
			if(dist <= 4096)
			{
				if(!isdefined(var_9a61376))
				{
					var_9a61376 = [];
				}
				else if(!isarray(var_9a61376))
				{
					var_9a61376 = array(var_9a61376);
				}
				if(!isinarray(var_9a61376, powerup))
				{
					var_9a61376[var_9a61376.size] = powerup;
				}
			}
		}
		foreach(powerup in var_9a61376)
		{
			var_f79dc259 = powerup zm_powerups::function_d5b6ce91();
			powerup clientfield::set("powerup_grabbed_fx", var_f79dc259);
			powerup zm_powerups::powerup_delete();
		}
		wait(0.01);
	}
}

/*
	Name: function_b58e5865
	Namespace: namespace_92cb027a
	Checksum: 0x24EF775C
	Offset: 0x5C90
	Size: 0x32E
	Parameters: 0
	Flags: Linked
*/
function function_b58e5865()
{
	level flag::set(#"hash_48039f3a4c1a3248");
	level.var_45827161 = [];
	level.func_get_zombie_spawn_delay = &function_61dc1b0;
	level.func_get_delay_between_rounds = &function_f85d3d98;
	callback::function_74872db6(&function_3d06f24e);
	if(isdefined(level.var_5f4eaf85))
	{
		level.var_5f4eaf85 val::set(#"hash_2c2f52c7b4c42bab", "takedamage", 1);
		level.var_5f4eaf85 kill();
	}
	if(isdefined(level.var_57ce903d))
	{
		level.var_57ce903d delete();
	}
	var_e3d10631 = getentarray("private_mannequin_parts", "targetname");
	var_a2c75164 = getent("mannequin_ally_door", "targetname");
	zm_unitrigger::unregister_unitrigger(var_e3d10631[0].s_unitrigger);
	if(isdefined(var_a2c75164.v_start_pos))
	{
		var_a2c75164 playsound("evt_bunker_door_interior_close");
		var_a2c75164 moveto(var_a2c75164.v_start_pos, 1);
	}
	foreach(e_part in var_e3d10631)
	{
		e_part hide();
	}
	if(isdefined(level.var_8943f7db))
	{
		util::stop_magic_bullet_shield(level.var_8943f7db);
		level.var_8943f7db kill();
	}
	level.var_5da5aff4 = 0;
	if(level flag::get(#"hash_398e4b1e72edb4ee"))
	{
		level flag::clear(#"hash_398e4b1e72edb4ee");
		exploder::stop_exploder("fxexp_elec_lounge");
	}
	level.var_382a24b0 = 1;
	level.var_dc22f98 = level.fn_custom_round_ai_spawn;
	level.fn_custom_round_ai_spawn = &function_be93a2bf;
}

/*
	Name: function_f85d3d98
	Namespace: namespace_92cb027a
	Checksum: 0x1474AD15
	Offset: 0x5FC8
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function function_f85d3d98()
{
	return false;
}

/*
	Name: function_61dc1b0
	Namespace: namespace_92cb027a
	Checksum: 0x4B2FB726
	Offset: 0x5FD8
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_61dc1b0(n_round)
{
	n_round = max(n_round, 20);
	n_delay = namespace_a28acff3::get_zombie_spawn_delay(n_round);
	return n_delay;
}

/*
	Name: function_3d06f24e
	Namespace: namespace_92cb027a
	Checksum: 0x93A75321
	Offset: 0x6030
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_3d06f24e()
{
	level waittill(#"zombie_total_set");
	level.zombie_health = zombie_utility::ai_calculate_health(level.zombie_vars[#"zombie_health_start"], max(level.round_number, 20));
}

/*
	Name: function_be93a2bf
	Namespace: namespace_92cb027a
	Checksum: 0x992C2657
	Offset: 0x60A8
	Size: 0x242
	Parameters: 0
	Flags: Linked
*/
function function_be93a2bf()
{
	if(level.var_65e355f > 1 && level.var_5233174e > 4)
	{
		ai = namespace_c402654::function_62db7b1c(0);
		if(isdefined(ai))
		{
			level.var_5233174e = 0;
			return true;
		}
	}
	s_spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
	ai = zombie_utility::spawn_zombie(getentarray("mannequin_zombie_spawner", "script_noteworthy")[0], undefined, s_spawn_point);
	if(isdefined(ai))
	{
		ai.health = int(ai.health * 2);
		ai thread function_ea2d02a6();
		level.zombie_total--;
		n_delay = (isdefined(zombie_utility::function_d2dfacfd(#"zombie_spawn_delay")) ? zombie_utility::function_d2dfacfd(#"zombie_spawn_delay") : zombie_utility::function_d2dfacfd(#"hash_7d5a25e2463f7fc5"));
		if(flag::get(#"hash_2b7c76b6b0dfc0fd"))
		{
			if(getplayers().size > 2)
			{
				n_delay = max(n_delay, 0.5);
			}
			else
			{
				n_delay = max(n_delay, 1);
			}
		}
		level.var_5233174e++;
		wait(n_delay);
		return true;
	}
	return false;
}

/*
	Name: function_ea2d02a6
	Namespace: namespace_92cb027a
	Checksum: 0x1A0896A7
	Offset: 0x62F8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_ea2d02a6()
{
	self endon(#"death");
	wait(0.5);
	self zombie_utility::set_zombie_run_cycle("sprint");
}

/*
	Name: function_cdcaffd1
	Namespace: namespace_92cb027a
	Checksum: 0xC31BACFD
	Offset: 0x6340
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_cdcaffd1(var_88206a50, ent)
{
	vol_test = getent(var_88206a50.target, "targetname");
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && ent istouching(vol_test);
}

/*
	Name: function_3bdbb583
	Namespace: namespace_92cb027a
	Checksum: 0xD9F452B8
	Offset: 0x6418
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function function_3bdbb583(var_f0e6c7a2, ent)
{
	var_f0e6c7a2.n_captured++;
	/#
		if(level flag::get(#"hash_6dcc421d5fbf8d22"))
		{
			var_f0e6c7a2.n_captured = 28;
		}
	#/
	level notify(#"hash_77f4046f7db1e137");
	canister = getent(var_f0e6c7a2.soul_goo, "script_noteworthy");
	if(var_f0e6c7a2.n_captured >= 28)
	{
		var_f0e6c7a2.charged = 1;
		var_f0e6c7a2.fx_handle clientfield::set("soul_capture_filled", 1);
		namespace_617a54f4::function_2a94055d(var_f0e6c7a2.script_string);
	}
}

/*
	Name: function_ffa1c335
	Namespace: namespace_92cb027a
	Checksum: 0x9B011605
	Offset: 0x6520
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_ffa1c335()
{
	level endon(#"game_ended");
	var_681e3f31 = getent(self.soul_goo, "script_noteworthy");
	v_start_pos = var_681e3f31.origin;
	while(true)
	{
		var_681e3f31 moveto(v_start_pos + (0, 0, self.n_captured), 1);
		wait(1);
	}
}

/*
	Name: function_8c2bda65
	Namespace: namespace_92cb027a
	Checksum: 0x72C0F913
	Offset: 0x65C8
	Size: 0x144
	Parameters: 2
	Flags: Linked
*/
function function_8c2bda65(n_rate, b_drain)
{
	var_681e3f31 = getent(self.soul_goo, "script_noteworthy");
	if(b_drain)
	{
		self.fx_handle clientfield::set("soul_capture_filled", 0);
		while(self.n_captured > 2)
		{
			self.n_captured = self.n_captured - (int(self.n_captured / n_rate));
			wait(1);
		}
		self.n_captured = 0;
	}
	else
	{
		while(self.n_captured < 26)
		{
			self.n_captured = self.n_captured + (int(28 / n_rate));
			wait(1);
		}
		self.n_captured = 28;
		self.fx_handle clientfield::set("soul_capture_filled", 1);
	}
}

/*
	Name: function_80a202c1
	Namespace: namespace_92cb027a
	Checksum: 0x506A3441
	Offset: 0x6718
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function function_80a202c1(e_player)
{
	str_prompt = "";
	if(self.stub.related_parent.var_3fc5ae3d)
	{
		str_prompt = #"hash_22dc6a35ff6146d7";
	}
	else
	{
		if(!level flag::get(#"hash_56dcbeaf295dd09e"))
		{
			str_prompt = zm_utility::function_d6046228(#"hash_6228a6a31d64d0ee", #"hash_2b939967b7ce331a");
		}
		else
		{
			str_prompt = #"hash_757733252517119a";
		}
	}
	self sethintstring(str_prompt);
	return true;
}

/*
	Name: function_dbbdda4c
	Namespace: namespace_92cb027a
	Checksum: 0xDE272DCB
	Offset: 0x67F8
	Size: 0x444
	Parameters: 1
	Flags: Linked
*/
function function_dbbdda4c(e_player)
{
	level endon(#"end_game");
	while(!self.charged)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger_activated");
		if(level flag::get(#"hash_56dcbeaf295dd09e"))
		{
			waitframe(1);
			continue;
		}
		level flag::set(#"hash_56dcbeaf295dd09e");
		self thread function_5f7d6e4c();
		vol_test = getent(self.target, "targetname");
		vol_test.var_72f7bafe = struct::get_array(self.target, "script_noteworthy");
		level.var_43c333a8.var_885c1824 = vol_test;
		namespace_617a54f4::function_3f808d3d(self.script_string);
		level waittill(#"hash_77f4046f7db1e137");
		self thread function_10dde0dd();
		while(!self.charged && self.n_captured > 0)
		{
			waitframe(1);
		}
		self notify(#"hash_4d9ae187d6e333c7");
		namespace_617a54f4::function_2a94055d(self.script_string);
		level.var_43c333a8.var_885c1824 = undefined;
		level flag::clear(#"hash_56dcbeaf295dd09e");
		if(self.charged)
		{
			self thread function_a6a4a162();
			playsoundatposition(#"hash_4a67e67e0a9d6df9", (0, 0, 0));
			/#
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					if(getdvarint(#"hash_11ad6a9695943217", 0))
					{
						iprintlnbold("");
						println("");
					}
				}
			#/
		}
		else
		{
			/#
				iprintlnbold("");
				println("");
			#/
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
				}
			}
			namespace_509a75d1::function_3c173d37();
			level.var_8200dc81 thread namespace_509a75d1::function_6a0d675d(#"hash_5c371dc17ccdf97", 0, 0, 1);
			playsoundatposition(#"hash_3fc59a2ac3e3a5b9", (0, 0, 0));
			self.var_3fc5ae3d = 1;
			self.fx_handle clientfield::set("soul_capture_depleted", 1);
			for(i = 0; i < 30; i++)
			{
				wait(1);
			}
			self.var_3fc5ae3d = 0;
			self.fx_handle clientfield::set("soul_capture_depleted", 0);
		}
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: function_5f7d6e4c
	Namespace: namespace_92cb027a
	Checksum: 0xC6C23F3B
	Offset: 0x6C48
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_5f7d6e4c()
{
	self endon(#"hash_56dcbeaf295dd09e", #"end_game");
	namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_529b7231d7ddbe80", 0, 0, 1);
	n_variant = function_21a3a673(0, 9);
	namespace_509a75d1::function_3c173d37();
	level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"hash_7c662a0005eae5d4", n_variant, 0, 1);
}

/*
	Name: function_a6a4a162
	Namespace: namespace_92cb027a
	Checksum: 0x9C032DC3
	Offset: 0x6D28
	Size: 0x5DC
	Parameters: 0
	Flags: Linked
*/
function function_a6a4a162()
{
	zm_unitrigger::unregister_unitrigger(self.stub);
	level.var_65e355f++;
	if(isdefined(level.var_43c333a8))
	{
		level.var_43c333a8 namespace_f7516cdf::function_ed39491e(level.var_65e355f);
	}
	namespace_509a75d1::function_2ba419ee(0);
	switch(self.script_string)
	{
		case "hash_79bfedd79fde9574":
		{
			function_12a92019("diner");
			level.var_f8fdb172 function_f757dba3();
			break;
		}
		case "hash_6de0dca7b8c02116":
		{
			function_12a92019("lounge");
			level.var_f8fdb172 function_47550faa();
			break;
		}
		case "hash_63c249049e8fab1d":
		{
			function_12a92019("storage");
			level.var_f8fdb172 function_8c41f9de();
			break;
		}
		case "hash_65c89350fbe358b0":
		{
			function_12a92019("beds");
			level.var_f8fdb172 function_d0dd97c4();
			break;
		}
	}
	function_2dfd8e82();
	self thread function_8c2bda65(3, 1);
	var_4a373f57 = getent(self.target, "targetname");
	var_703d991b = undefined;
	switch(self.script_string)
	{
		case "hash_79bfedd79fde9574":
		{
			var_703d991b = struct::get("cp_toast_apd_diner", "script_noteworthy");
			level function_594dae();
			var_703d991b thread function_8c2bda65(3, 0);
			namespace_509a75d1::function_3c173d37();
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_278f7dd58492d72f", 0, 0, 1);
			level thread function_377062e2();
			wait(5);
			exploder::exploder("fxexp_elec_diner");
			break;
		}
		case "hash_6de0dca7b8c02116":
		{
			var_703d991b = struct::get("cp_toast_apd_lounge", "script_noteworthy");
			level function_6fd6c18f();
			var_703d991b thread function_8c2bda65(3, 0);
			namespace_509a75d1::function_3c173d37();
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_5aa17424c77358bf", 0, 0, 1);
			level thread function_377062e2();
			wait(5);
			exploder::exploder("fxexp_elec_lounge");
			break;
		}
		case "hash_63c249049e8fab1d":
		{
			var_703d991b = struct::get("cp_toast_apd", "script_noteworthy");
			level function_6f083d9c();
			var_703d991b thread function_8c2bda65(3, 0);
			namespace_509a75d1::function_3c173d37();
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_6a8081b211c908ce", 0, 0, 1);
			level thread function_377062e2();
			wait(5);
			exploder::exploder("fxexp_elec_storage");
			break;
		}
		case "hash_65c89350fbe358b0":
		{
			var_703d991b = struct::get("cp_toast_apd_beds", "script_noteworthy");
			level function_8ba67fdc();
			var_703d991b thread function_8c2bda65(3, 0);
			namespace_509a75d1::function_3c173d37();
			level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_740bffff7149b220", 0, 0, 1);
			level thread function_377062e2();
			wait(5);
			exploder::exploder("fxexp_elec_beds");
			break;
		}
	}
	var_4a373f57 function_297251d8();
}

/*
	Name: function_2dfd8e82
	Namespace: namespace_92cb027a
	Checksum: 0x96D58CF0
	Offset: 0x7310
	Size: 0x1A2
	Parameters: 0
	Flags: Linked
*/
function function_2dfd8e82()
{
	level endon(#"hash_56dcbeaf295dd09e", #"end_game");
	switch(level.var_65e355f)
	{
		case 1:
		{
			namespace_509a75d1::function_3c173d37();
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_52ef0df6d3730e90", 1, 0, 1);
			break;
		}
		case 2:
		{
			namespace_509a75d1::function_3c173d37();
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_75fc60c1d10de4c2", 1, 0, 1);
			break;
		}
		case 3:
		{
			namespace_509a75d1::function_3c173d37();
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_6e3f8bae61789524", 1, 0, 1);
			break;
		}
		case 4:
		{
			namespace_509a75d1::function_3c173d37();
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_599ad19acca1d1c8", 1, 0, 1);
			break;
		}
	}
}

/*
	Name: function_377062e2
	Namespace: namespace_92cb027a
	Checksum: 0xD7ACA5FA
	Offset: 0x74C0
	Size: 0x1C2
	Parameters: 0
	Flags: Linked
*/
function function_377062e2()
{
	level endon(#"hash_56dcbeaf295dd09e", #"end_game");
	switch(level.var_65e355f)
	{
		case 1:
		{
			namespace_509a75d1::function_3c173d37();
			level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"hash_52ef0df6d3730e90", 2, 0, 1);
			break;
		}
		case 2:
		{
			namespace_509a75d1::function_3c173d37();
			level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"hash_75fc60c1d10de4c2", 2, 0, 1);
			break;
		}
		case 3:
		{
			namespace_509a75d1::function_3c173d37();
			level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"hash_6e3f8bae61789524", 2, 0, 1);
			break;
		}
		case 4:
		{
			namespace_509a75d1::function_3c173d37();
			level.var_43c333a8 namespace_509a75d1::function_6a0d675d(#"hash_599ad19acca1d1c8", 2, 0, 1);
			level flag::set(#"toast_final_charge");
			break;
		}
	}
}

/*
	Name: function_12a92019
	Namespace: namespace_92cb027a
	Checksum: 0x161598EA
	Offset: 0x7690
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function function_12a92019(str_position)
{
	foreach(struct in level.var_433834a2[str_position])
	{
		level thread zm_powerups::specific_powerup_drop(struct.script_string, struct.origin);
	}
}

/*
	Name: function_10dde0dd
	Namespace: namespace_92cb027a
	Checksum: 0xEA1D4EC5
	Offset: 0x7738
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_10dde0dd()
{
	self endon(#"hash_4d9ae187d6e333c7");
	while(level flag::get(#"hash_56dcbeaf295dd09e"))
	{
		level waittill(#"hash_77f4046f7db1e137");
		self thread function_8db56cee();
	}
}

/*
	Name: function_8db56cee
	Namespace: namespace_92cb027a
	Checksum: 0x3A587FED
	Offset: 0x77B0
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function function_8db56cee()
{
	level endon(#"hash_77f4046f7db1e137");
	self endon(#"hash_4d9ae187d6e333c7");
	wait(5);
	while(self.n_captured > 0 && level flag::get(#"hash_56dcbeaf295dd09e"))
	{
		self.n_captured--;
		wait(2);
	}
}

/*
	Name: function_d30f74b8
	Namespace: namespace_92cb027a
	Checksum: 0xBA4C7EFA
	Offset: 0x7838
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_d30f74b8()
{
	level.var_22cd4e60 = [];
	level.var_f48e1692 = [];
	level.var_f861a2bc = [];
	level.var_9e318617 = [];
	level.var_79d7145f = [];
	level.var_f48e1692 = getentarray("beds_wire_set", "targetname");
	level.var_f861a2bc = getentarray("diner_wire_set", "targetname");
	level.var_9e318617 = getentarray("lounge_wire_set", "targetname");
	level.var_79d7145f = getentarray("storage_wire_set", "targetname");
	level function_54f91945();
	level function_45b60e0e();
	level function_976e7caa();
	level function_2cdb9672();
}

/*
	Name: function_35b8264f
	Namespace: namespace_92cb027a
	Checksum: 0xFACC24BE
	Offset: 0x7988
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_35b8264f()
{
	self hidepart("tag_wire_apd_off");
	self showpart("tag_wire_apd_on");
}

/*
	Name: function_3507dc95
	Namespace: namespace_92cb027a
	Checksum: 0x7DF077E3
	Offset: 0x79D8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_3507dc95()
{
	self hidepart("tag_wire_apd_on");
	self showpart("tag_wire_apd_off");
}

/*
	Name: function_8ba67fdc
	Namespace: namespace_92cb027a
	Checksum: 0xAFBE8A45
	Offset: 0x7A28
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_8ba67fdc()
{
	foreach(wire in level.var_f48e1692)
	{
		if(wire.script_noteworthy === "apd_wire")
		{
			wire function_35b8264f();
			continue;
		}
		wire hidepart("tag_wire_beds_off");
		wire showpart("tag_wire_beds_on");
	}
}

/*
	Name: function_54f91945
	Namespace: namespace_92cb027a
	Checksum: 0x42C42110
	Offset: 0x7B08
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_54f91945()
{
	foreach(wire in level.var_f48e1692)
	{
		if(wire.script_noteworthy === "apd_wire")
		{
			wire function_3507dc95();
			continue;
		}
		wire hidepart("tag_wire_beds_on");
		wire showpart("tag_wire_beds_off");
	}
}

/*
	Name: function_594dae
	Namespace: namespace_92cb027a
	Checksum: 0xF5554B98
	Offset: 0x7BE8
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_594dae()
{
	foreach(wire in level.var_f861a2bc)
	{
		if(wire.script_noteworthy === "apd_wire")
		{
			wire function_35b8264f();
			continue;
		}
		wire hidepart("tag_wire_diner_off");
		wire showpart("tag_wire_diner_on");
	}
}

/*
	Name: function_45b60e0e
	Namespace: namespace_92cb027a
	Checksum: 0x405A9E4A
	Offset: 0x7CC8
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_45b60e0e()
{
	foreach(wire in level.var_f861a2bc)
	{
		if(wire.script_noteworthy === "apd_wire")
		{
			wire function_3507dc95();
			continue;
		}
		wire hidepart("tag_wire_diner_on");
		wire showpart("tag_wire_diner_off");
	}
}

/*
	Name: function_6fd6c18f
	Namespace: namespace_92cb027a
	Checksum: 0x2D48AF10
	Offset: 0x7DA8
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_6fd6c18f()
{
	foreach(wire in level.var_9e318617)
	{
		if(wire.script_noteworthy === "apd_wire")
		{
			wire function_35b8264f();
			continue;
		}
		wire hidepart("tag_wire_lounge_off");
		wire showpart("tag_wire_lounge_on");
	}
}

/*
	Name: function_976e7caa
	Namespace: namespace_92cb027a
	Checksum: 0x8D811340
	Offset: 0x7E88
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_976e7caa()
{
	foreach(wire in level.var_9e318617)
	{
		if(wire.script_noteworthy === "apd_wire")
		{
			wire function_3507dc95();
			continue;
		}
		wire hidepart("tag_wire_lounge_on");
		wire showpart("tag_wire_lounge_off");
	}
}

/*
	Name: function_6f083d9c
	Namespace: namespace_92cb027a
	Checksum: 0xC9B4C63E
	Offset: 0x7F68
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_6f083d9c()
{
	foreach(wire in level.var_79d7145f)
	{
		if(wire.script_noteworthy === "apd_wire")
		{
			wire function_35b8264f();
			continue;
		}
		wire hidepart("tag_wire_storage_off");
		wire showpart("tag_wire_storage_on");
	}
}

/*
	Name: function_2cdb9672
	Namespace: namespace_92cb027a
	Checksum: 0xAAE98FFD
	Offset: 0x8048
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_2cdb9672()
{
	foreach(wire in level.var_79d7145f)
	{
		if(wire.script_noteworthy === "apd_wire")
		{
			wire function_3507dc95();
			continue;
		}
		wire hidepart("tag_wire_storage_on");
		wire showpart("tag_wire_storage_off");
	}
}

/*
	Name: apd_computer_screens_init
	Namespace: namespace_92cb027a
	Checksum: 0x572557B6
	Offset: 0x8128
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function apd_computer_screens_init()
{
	level.var_f8fdb172 = getent("apd_computer_screens", "targetname");
	level.var_f8fdb172 function_2a8ad7ea();
}

/*
	Name: function_2a8ad7ea
	Namespace: namespace_92cb027a
	Checksum: 0x95F96D4A
	Offset: 0x8180
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_2a8ad7ea()
{
	self hidepart("tag_roomnames");
	self hidepart("tag_end");
	self hidepart("tag_start");
	self hidepart("tag_beds_full");
	self hidepart("tag_beds_empty");
	self hidepart("tag_storage_full");
	self hidepart("tag_storage_empty");
	self hidepart("tag_diner_full");
	self hidepart("tag_diner_empty");
	self hidepart("tag_lounge_full");
	self hidepart("tag_lounge_empty");
}

/*
	Name: function_3ea7f25d
	Namespace: namespace_92cb027a
	Checksum: 0xCD9A06B8
	Offset: 0x82F0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_3ea7f25d()
{
	self showpart("tag_roomnames");
	self showpart("tag_beds_empty");
	self showpart("tag_storage_empty");
	self showpart("tag_diner_empty");
	self showpart("tag_lounge_empty");
}

/*
	Name: function_13456343
	Namespace: namespace_92cb027a
	Checksum: 0x6454D634
	Offset: 0x83A0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_13456343()
{
	self hidepart("tag_end");
	self showpart("tag_start");
}

/*
	Name: function_43124a8f
	Namespace: namespace_92cb027a
	Checksum: 0xE83D6346
	Offset: 0x83F0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_43124a8f()
{
	self showpart("tag_end");
	self hidepart("tag_start");
}

/*
	Name: function_d0dd97c4
	Namespace: namespace_92cb027a
	Checksum: 0x410DF64A
	Offset: 0x8440
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_d0dd97c4()
{
	self showpart("tag_beds_full");
	self hidepart("tag_beds_empty");
}

/*
	Name: function_8c41f9de
	Namespace: namespace_92cb027a
	Checksum: 0x2A9FA2A7
	Offset: 0x8490
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_8c41f9de()
{
	self showpart("tag_storage_full");
	self hidepart("tag_storage_empty");
}

/*
	Name: function_f757dba3
	Namespace: namespace_92cb027a
	Checksum: 0x41DD44E1
	Offset: 0x84E0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_f757dba3()
{
	self showpart("tag_diner_full");
	self hidepart("tag_diner_empty");
}

/*
	Name: function_47550faa
	Namespace: namespace_92cb027a
	Checksum: 0xBD1E3F32
	Offset: 0x8530
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_47550faa()
{
	self showpart("tag_lounge_full");
	self hidepart("tag_lounge_empty");
}

