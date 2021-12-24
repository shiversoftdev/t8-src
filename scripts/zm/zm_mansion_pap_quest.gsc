// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b10fdf0addd52e;
#using script_3496aeeccaa9d66a;
#using script_35598499769dbb3d;
#using script_387eab232fe22983;
#using script_3e5ec44cfab7a201;
#using script_3f9e0dc8454d98e1;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using script_79c9122f9058e8ba;
#using script_ab862743b3070a;
#using script_b52a163973f339f;
#using script_b761c44ab2e5b46;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\serverfield_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_mansion_sound.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_b8f22955;

/*
	Name: init
	Namespace: namespace_b8f22955
	Checksum: 0x3764A9FC
	Offset: 0xF00
	Size: 0x672
	Parameters: 1
	Flags: Linked
*/
function init(var_5ea5c94d)
{
	level.var_239e2979 = 0;
	level.var_be779a9e = 0;
	level.var_a5be39a5 = 0;
	level.var_bc07224f = 4;
	level.var_d4fada4a = 6;
	level.var_71561996 = 8;
	level._effect[#"hash_493422eb9f876bcb"] = #"zombie/fx8_wallbuy_reveal";
	level flag::init("crystal_main_hall");
	level flag::init("crystal_library");
	level flag::init("crystal_greenhouse");
	level flag::init("crystal_main_hall_key");
	level flag::init("crystal_library_key");
	level flag::init("crystal_greenhouse_key");
	level flag::init("bedroom_charged");
	level flag::init("cellar_charged");
	level flag::init("library_charged");
	level flag::init("painting_clue");
	level flag::init("wisp_done");
	level flag::init("clock");
	level flag::init("clock_defend");
	level flag::init("trophy_prints");
	level flag::init("trophy_portal");
	level flag::init("flag_pack_disabled");
	level flag::init("unlock_pap_gate");
	level flag::init("nosferatu_defend");
	level flag::init("nosferatu_pap_event_done");
	level flag::init("nosferatu_pap_drop");
	/#
		level.var_426fec = spawnstruct();
		level.var_7ccd6341 = spawnstruct();
		level.var_2ff50a = spawnstruct();
	#/
	level.var_eab529d7 = getent("key_main_hall", "targetname");
	level.var_eab529d7 hide();
	level.var_eab529d7.var_db9b80c9 = "main_hall";
	level.var_192555d1 = getent("key_library", "targetname");
	level.var_192555d1 hide();
	level.var_192555d1.var_db9b80c9 = "library";
	level.var_a46e88e5 = getent("key_greenhouse", "targetname");
	level.var_a46e88e5 hide();
	level.var_a46e88e5.var_db9b80c9 = "greenhouse";
	level.a_str_zones = array::randomize(array("main_hall", "library", "greenhouse"));
	level.var_28edc152 = array("cemetery", "garden");
	level.var_c25e1f9c = array(0, 1);
	level thread setup_clocks();
	if(!zm_utility::is_standard())
	{
		function_eecfbd25();
	}
	level thread function_cdb8fe80();
	level thread function_2605cb3d();
	n_pap_enabled = namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2");
	switch(n_pap_enabled)
	{
		case 2:
		{
			level thread function_a7faeaaf();
			return;
		}
		case 0:
		{
			level flag::set("flag_pack_disabled");
		}
	}
	level thread function_a865c184();
	level thread function_5caf3d1a();
	level thread function_c996ff1();
	level.var_a05737eb = 0;
}

/*
	Name: cleanup
	Namespace: namespace_b8f22955
	Checksum: 0x42147B76
	Offset: 0x1580
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function cleanup(var_5ea5c94d, ended_early)
{
}

/*
	Name: init_clientfields
	Namespace: namespace_b8f22955
	Checksum: 0xB9E31DEB
	Offset: 0x15A0
	Size: 0x304
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_51257ec597a8f84f", 8000, getminbitcountfornum(3), "int");
	clientfield::register("scriptmover", "" + #"hash_47b8db8cde2c4291", 8000, getminbitcountfornum(13), "int");
	clientfield::register("scriptmover", "" + #"hash_6babc320ed9a08f1", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_1f18edb30c01161a", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"ghost_trail", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_11eb6b7dc7db71ad", 8000, getminbitcountfornum(1), "int");
	clientfield::register("scriptmover", "" + #"hash_58b293ceeb7f93e4", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_33f073e3476b420d", 8000, getminbitcountfornum(17), "int");
	clientfield::register("toplayer", "" + #"hash_2d63a1398e98f279", 8000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_ea66e39c63f5b41", 13000, 1, "int");
	clientfield::register("allplayers", "" + #"hash_49de76d6c4f95e5d", 8000, 1, "int");
}

/*
	Name: function_a7faeaaf
	Namespace: namespace_b8f22955
	Checksum: 0x5F74AF19
	Offset: 0x18B0
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function function_a7faeaaf()
{
	var_82c8a927 = getent("pap_lock_main_hall", "targetname");
	var_a82b1de9 = getent("pap_lock_library", "targetname");
	var_34cbce37 = getent("pap_lock_greenhouse", "targetname");
	if(isdefined(var_82c8a927))
	{
		var_82c8a927 delete();
	}
	if(isdefined(var_a82b1de9))
	{
		var_a82b1de9 delete();
	}
	if(isdefined(var_34cbce37))
	{
		var_34cbce37 delete();
	}
	if(zm_utility::is_standard())
	{
		level waittill(#"hash_70b8a9572ba21d10");
	}
	level flag::wait_till("gameplay_started");
	var_7ba3f1dd = getent("ooze_gate_col", "targetname");
	if(isdefined(var_7ba3f1dd))
	{
		var_7ba3f1dd connectpaths();
		var_7ba3f1dd delete();
	}
	level flag::wait_till("connect_main_hall_to_forest_entrance");
	zm_power::turn_power_on_and_open_doors(666);
	exploder::exploder("fxexp_pap_gate");
	exploder::exploder("exp_lgt_ooze_gate_torches");
	level flag::set("open_pap");
}

/*
	Name: function_124362b5
	Namespace: namespace_b8f22955
	Checksum: 0xAA8D853F
	Offset: 0x1AC8
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_124362b5(is_powered)
{
	self endon(#"hash_404acc7ce223033");
	level flag::wait_till("all_players_spawned");
	self zm_pack_a_punch::set_state_hidden();
	level flag::wait_till("open_pap");
	if(!level flag::get("flag_pack_disabled"))
	{
		self zm_pack_a_punch::function_bb629351(1, "arriving", "arrive_anim_done");
		level.pap_machine = self;
	}
}

/*
	Name: setup_clocks
	Namespace: namespace_b8f22955
	Checksum: 0x5C75565B
	Offset: 0x1BA0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function setup_clocks()
{
	level thread function_4a648207();
}

/*
	Name: function_39549562
	Namespace: namespace_b8f22955
	Checksum: 0xD75A20FD
	Offset: 0x1BC8
	Size: 0x14C
	Parameters: 2
	Flags: Linked
*/
function function_39549562(var_7b192260, var_f8561a50)
{
	level flag::wait_till("all_players_spawned");
	/#
		var_f8561a50 thread function_debf98ad((1, 0, 1));
	#/
	var_f8561a50 clientfield::set("" + #"hash_1f18edb30c01161a", 1);
	s_result = undefined;
	s_result = self waittill(#"death");
	level notify(#"hash_483503537a553500", {#e_player:s_result.attacker});
	namespace_617a54f4::function_3f808d3d(var_7b192260);
	var_f8561a50 clientfield::set("" + #"hash_1f18edb30c01161a", 0);
	/#
		var_f8561a50 thread function_debf98ad((1, 0, 0));
	#/
}

/*
	Name: function_7255025f
	Namespace: namespace_b8f22955
	Checksum: 0xE7ED86DB
	Offset: 0x1D20
	Size: 0x85C
	Parameters: 0
	Flags: Linked
*/
function function_7255025f()
{
	if(zm_utility::is_standard() || namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 2)
	{
		var_99a245 = getent("gazing_stone_main_hall", "targetname");
		var_d8f56b29 = getent("gazing_stone_cellar", "targetname");
		var_aa527474 = getent("gazing_stone_library", "targetname");
		var_99a245 delete();
		var_d8f56b29 delete();
		var_aa527474 delete();
		return;
	}
	var_634714d5 = getentarray("gazign_stone_covers", "script_noteworthy");
	array::run_all(var_634714d5, &function_2baad8fc);
	var_d8358012 = struct::get("mh_cpt1", "script_noteworthy");
	var_a7181dd8 = struct::get("mh_cpt2", "script_noteworthy");
	var_b4c5b933 = struct::get("mh_cpt3", "script_noteworthy");
	var_8be21cb = array(var_d8358012, var_a7181dd8, var_b4c5b933);
	s_pt = array::random(var_8be21cb);
	var_99a245 = getent("gazing_stone_main_hall", "targetname");
	var_99a245.origin = s_pt.origin;
	var_99a245.angles = s_pt.angles;
	var_7a3eaf5e = getent("main_hall_v_" + s_pt.script_int, "targetname");
	var_7a3eaf5e thread function_39549562(s_pt.script_string, var_99a245);
	namespace_617a54f4::function_d8383812(#"hash_51c79c8e74688138", 8000, var_d8358012, &function_bbceb70a, &function_9ce2b677, 1);
	namespace_617a54f4::function_d8383812(#"hash_51c79f8e74688651", 8000, var_a7181dd8, &function_bbceb70a, &function_9ce2b677, 1);
	namespace_617a54f4::function_d8383812(#"hash_51c79e8e7468849e", 8000, var_b4c5b933, &function_bbceb70a, &function_9ce2b677, 1);
	var_b3513ad0 = struct::get("cl_cpt1", "script_noteworthy");
	var_5245e75 = struct::get("cl_cpt2", "script_noteworthy");
	var_41e6ec54 = array(var_b3513ad0, var_5245e75);
	s_cellar = array::random(var_41e6ec54);
	var_d8f56b29 = getent("gazing_stone_cellar", "targetname");
	var_d8f56b29.origin = s_cellar.origin;
	var_d8f56b29.angles = s_cellar.angles;
	var_e298d09d = getent("cellar_v_" + s_cellar.script_int, "targetname");
	var_e298d09d thread function_39549562(s_cellar.script_string, var_d8f56b29);
	namespace_617a54f4::function_d8383812(#"hash_3fc3ce8e6a02292e", 8000, var_b3513ad0, &function_995220a5, &function_da937c94, 1);
	namespace_617a54f4::function_d8383812(#"hash_3fc3cd8e6a02277b", 8000, var_5245e75, &function_995220a5, &function_da937c94, 1);
	var_bc650319 = struct::get("lb_cpt1", "script_noteworthy");
	var_cd1aa484 = struct::get("lb_cpt2", "script_noteworthy");
	var_36df7810 = struct::get("lb_cpt3", "script_noteworthy");
	var_8811b3a = array(var_bc650319, var_cd1aa484, var_36df7810);
	var_e009cb59 = array::random(var_8811b3a);
	var_aa527474 = getent("gazing_stone_library", "targetname");
	var_aa527474.origin = var_e009cb59.origin;
	var_aa527474.angles = var_e009cb59.angles;
	var_453c074e = getent("library_v_" + var_e009cb59.script_int, "targetname");
	var_453c074e thread function_39549562(var_e009cb59.script_string, var_aa527474);
	namespace_617a54f4::function_d8383812(#"hash_478cff8e6e2b9aad", 8000, var_bc650319, &function_2ec958b6, &function_2c902b77, 1);
	namespace_617a54f4::function_d8383812(#"hash_478cfc8e6e2b9594", 8000, var_cd1aa484, &function_2ec958b6, &function_2c902b77, 1);
	namespace_617a54f4::function_d8383812(#"hash_478cfd8e6e2b9747", 8000, var_36df7810, &function_2ec958b6, &function_2c902b77, 1);
	/#
		array::thread_all(level.var_d2540500, &function_f728c266);
	#/
	level thread namespace_48607e17::function_90659e2c();
	level thread namespace_48607e17::function_eb112701();
	level thread namespace_48607e17::function_6b5b1780();
}

/*
	Name: function_bbceb70a
	Namespace: namespace_b8f22955
	Checksum: 0xBDB36509
	Offset: 0x2588
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_bbceb70a(var_88206a50, ent)
{
	vol_main_hall = getent(var_88206a50.target, "targetname");
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && ent istouching(vol_main_hall);
}

/*
	Name: function_9ce2b677
	Namespace: namespace_b8f22955
	Checksum: 0x6E1A9DBE
	Offset: 0x2660
	Size: 0x35A
	Parameters: 2
	Flags: Linked
*/
function function_9ce2b677(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = level.var_71561996;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = level.var_d4fada4a;
	}
	else
	{
		n_souls_required = level.var_bc07224f;
	}
	level.var_239e2979++;
	if(level.var_239e2979 >= n_souls_required)
	{
		level flag::set("bedroom_charged");
		namespace_617a54f4::function_2a94055d(var_f0e6c7a2.script_string);
		var_99a245 = getent("gazing_stone_main_hall", "targetname");
		var_99a245 clientfield::set("" + #"hash_6babc320ed9a08f1", 1);
		if(!var_f0e6c7a2 flag::exists("flag_gazing_stone_in_use"))
		{
			var_f0e6c7a2 flag::init("flag_gazing_stone_in_use");
		}
		var_47323b73 = var_f0e6c7a2 zm_unitrigger::create(&function_5815f500, 64, &function_5713470b);
		var_47323b73.var_f0e6c7a2 = var_f0e6c7a2;
		if(level.a_str_zones[0] == "main_hall")
		{
			var_47323b73.var_1ed09409 = "nos";
		}
		else if(level.a_str_zones[1] == "main_hall")
		{
			var_47323b73.var_1ed09409 = "clock";
		}
		else
		{
			var_47323b73.var_1ed09409 = function_4e8b75e0();
		}
		var_47323b73.str_hint = function_639c87e1(var_47323b73.var_1ed09409);
		var_47323b73.mdl_key = level.var_eab529d7;
		var_47323b73.s_loc = struct::get("key_main_hall_loc");
		var_47323b73.var_e62bb9d2 = getent("gazing_stone_main_hall", "targetname");
		var_99a245 thread function_8b6c61d3(level.var_eab529d7);
		var_f0e6c7a2 thread namespace_48607e17::function_70c90053();
		/#
			if(isdefined(level.var_426fec.var_1ed09409))
			{
				var_47323b73.var_1ed09409 = level.var_426fec.var_1ed09409;
				var_47323b73.str_hint = level.var_426fec.str_hint;
			}
		#/
	}
}

/*
	Name: function_2ec958b6
	Namespace: namespace_b8f22955
	Checksum: 0x2818F9C3
	Offset: 0x29C8
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_2ec958b6(var_88206a50, ent)
{
	vol_library = getent(var_88206a50.target, "targetname");
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && ent istouching(vol_library);
}

/*
	Name: function_2c902b77
	Namespace: namespace_b8f22955
	Checksum: 0x13A58F06
	Offset: 0x2AA0
	Size: 0x3DA
	Parameters: 2
	Flags: Linked
*/
function function_2c902b77(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = level.var_71561996;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = level.var_d4fada4a;
	}
	else
	{
		n_souls_required = level.var_bc07224f;
	}
	level.var_be779a9e++;
	if(level.var_be779a9e >= n_souls_required)
	{
		level flag::set("library_charged");
		namespace_617a54f4::function_2a94055d(var_f0e6c7a2.script_string);
		var_aa527474 = getent("gazing_stone_library", "targetname");
		var_aa527474 clientfield::set("" + #"hash_6babc320ed9a08f1", 1);
		if(!var_f0e6c7a2 flag::exists("flag_gazing_stone_in_use"))
		{
			var_f0e6c7a2 flag::init("flag_gazing_stone_in_use");
		}
		var_47323b73 = var_f0e6c7a2 zm_unitrigger::create(&function_5815f500, 64, &function_5713470b);
		var_47323b73.var_f0e6c7a2 = var_f0e6c7a2;
		if(level.a_str_zones[0] == "library")
		{
			var_47323b73.var_1ed09409 = "nos";
		}
		else if(level.a_str_zones[1] == "library")
		{
			var_47323b73.var_1ed09409 = "clock";
		}
		else
		{
			var_47323b73.var_1ed09409 = function_4e8b75e0();
		}
		if(var_47323b73.var_1ed09409 === "trophy")
		{
			var_47323b73.str_hint = array::random(array("bull_loc", "dl_loc"));
		}
		else
		{
			var_47323b73.str_hint = function_639c87e1(var_47323b73.var_1ed09409);
		}
		var_47323b73.mdl_key = level.var_192555d1;
		var_47323b73.s_loc = struct::get("key_library_loc");
		var_47323b73.vol_transform = getent("vol_transform_library", "targetname");
		var_47323b73.var_e62bb9d2 = getent("gazing_stone_library", "targetname");
		var_aa527474 thread function_8b6c61d3(level.var_192555d1);
		var_f0e6c7a2 thread namespace_48607e17::function_70c90053();
		/#
			if(isdefined(level.var_2ff50a.var_1ed09409))
			{
				var_47323b73.var_1ed09409 = level.var_2ff50a.var_1ed09409;
				var_47323b73.str_hint = level.var_2ff50a.str_hint;
			}
		#/
	}
}

/*
	Name: function_995220a5
	Namespace: namespace_b8f22955
	Checksum: 0x7C52CDB4
	Offset: 0x2E88
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_995220a5(var_88206a50, ent)
{
	vol_greenhouse = getent(var_88206a50.target, "targetname");
	return isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) && isdefined(ent) && ent istouching(vol_greenhouse);
}

/*
	Name: function_da937c94
	Namespace: namespace_b8f22955
	Checksum: 0x8FBC68D5
	Offset: 0x2F60
	Size: 0x3DA
	Parameters: 2
	Flags: Linked
*/
function function_da937c94(var_f0e6c7a2, ent)
{
	if(getplayers().size > 2)
	{
		n_souls_required = level.var_71561996;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = level.var_d4fada4a;
	}
	else
	{
		n_souls_required = level.var_bc07224f;
	}
	level.var_a5be39a5++;
	if(level.var_a5be39a5 >= n_souls_required)
	{
		level flag::set("cellar_charged");
		namespace_617a54f4::function_2a94055d(var_f0e6c7a2.script_string);
		var_d8f56b29 = getent("gazing_stone_cellar", "targetname");
		var_d8f56b29 clientfield::set("" + #"hash_6babc320ed9a08f1", 1);
		if(!var_f0e6c7a2 flag::exists("flag_gazing_stone_in_use"))
		{
			var_f0e6c7a2 flag::init("flag_gazing_stone_in_use");
		}
		var_47323b73 = var_f0e6c7a2 zm_unitrigger::create(&function_5815f500, 64, &function_5713470b);
		var_47323b73.var_f0e6c7a2 = var_f0e6c7a2;
		if(level.a_str_zones[0] == "greenhouse")
		{
			var_47323b73.var_1ed09409 = "nos";
		}
		else if(level.a_str_zones[1] == "greenhouse")
		{
			var_47323b73.var_1ed09409 = "clock";
		}
		else
		{
			var_47323b73.var_1ed09409 = function_4e8b75e0();
		}
		if(var_47323b73.var_1ed09409 === "trophy")
		{
			var_47323b73.str_hint = array::random(array("monkey_loc", "dl_loc"));
		}
		else
		{
			var_47323b73.str_hint = function_639c87e1(var_47323b73.var_1ed09409);
		}
		var_47323b73.mdl_key = level.var_a46e88e5;
		var_47323b73.s_loc = struct::get("key_greenhouse_loc");
		var_47323b73.vol_transform = getent("vol_transform_greenhouse", "targetname");
		var_47323b73.var_e62bb9d2 = getent("gazing_stone_cellar", "targetname");
		var_d8f56b29 thread function_8b6c61d3(level.var_a46e88e5);
		var_f0e6c7a2 thread namespace_48607e17::function_70c90053();
		/#
			if(isdefined(level.var_7ccd6341.var_1ed09409))
			{
				var_47323b73.var_1ed09409 = level.var_7ccd6341.var_1ed09409;
				var_47323b73.str_hint = level.var_7ccd6341.str_hint;
			}
		#/
	}
}

/*
	Name: function_8b6c61d3
	Namespace: namespace_b8f22955
	Checksum: 0xC7C99F52
	Offset: 0x3348
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_8b6c61d3(mdl_key)
{
	while(isdefined(mdl_key))
	{
		wait(0.1);
	}
	self clientfield::set("" + #"hash_6babc320ed9a08f1", 0);
}

/*
	Name: function_5815f500
	Namespace: namespace_b8f22955
	Checksum: 0x9E03C67A
	Offset: 0x33A0
	Size: 0xF8
	Parameters: 1
	Flags: Linked
*/
function function_5815f500(player)
{
	if(player zm_utility::in_revive_trigger())
	{
		return 0;
	}
	if(!player.var_d049df11 && !self.stub.var_f0e6c7a2 flag::get("flag_gazing_stone_in_use"))
	{
		str_prompt = zm_utility::function_d6046228(#"hash_78daefa5877d95d1", #"hash_4beb10678533accf");
		self sethintstringforplayer(player, str_prompt);
	}
	else
	{
		self sethintstringforplayer(player, #"hash_419b9e1f22265b5b");
	}
	return 1;
}

/*
	Name: function_5caf3d1a
	Namespace: namespace_b8f22955
	Checksum: 0xF174B629
	Offset: 0x34A0
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_5caf3d1a()
{
	if(util::function_5df4294() == #"zstandard")
	{
		return;
	}
	pap_gate_loc = struct::get("pap_gate_loc");
	pap_gate_loc.var_47323b73 = pap_gate_loc zm_unitrigger::create(&function_53c0c5e, 176, &function_5ccf9075);
	var_908736b3 = spawn("trigger_radius", pap_gate_loc.origin, 0, 256, 128);
	var_908736b3 thread function_686b9870();
	level flag::wait_till("unlock_pap_gate");
	exploder::exploder("exp_lgt_gas_lantern_trail");
	if(isdefined(var_908736b3))
	{
		var_908736b3 delete();
	}
}

/*
	Name: function_686b9870
	Namespace: namespace_b8f22955
	Checksum: 0xC2BFA9AA
	Offset: 0x35E8
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function function_686b9870()
{
	self endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		player = var_be17187b.activator;
		var_f7a8259e = level flag::get_all(array("crystal_main_hall", "crystal_library", "crystal_greenhouse"));
		if(zm_utility::is_player_valid(player) && !var_f7a8259e)
		{
			player thread zm_vo::function_a2bd5a0c(#"hash_7edbe7e0a2def479", 1);
			self delete();
		}
		else if(var_f7a8259e)
		{
			self delete();
		}
		wait(1);
	}
}

/*
	Name: function_53c0c5e
	Namespace: namespace_b8f22955
	Checksum: 0xD8460661
	Offset: 0x3718
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_53c0c5e(player)
{
	if(function_fc79b7da("crystal_main_hall") || function_fc79b7da("crystal_library") || function_fc79b7da("crystal_greenhouse"))
	{
		str_prompt = zm_utility::function_d6046228(#"hash_3dd539cb05389d25", #"hash_2b92feb97bdafc9b");
		self sethintstringforplayer(player, str_prompt);
		return 1;
	}
	return 0;
}

/*
	Name: function_fc79b7da
	Namespace: namespace_b8f22955
	Checksum: 0x9EA3A04E
	Offset: 0x37E8
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function function_fc79b7da(str_flag)
{
	if(level flag::get(str_flag) && !level flag::get(str_flag + "_key"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_5ccf9075
	Namespace: namespace_b8f22955
	Checksum: 0x91E7469F
	Offset: 0x3850
	Size: 0x238
	Parameters: 0
	Flags: Linked
*/
function function_5ccf9075()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		if(level flag::get("crystal_main_hall") && !level flag::get("crystal_main_hall_key"))
		{
			level thread function_94fc7512("main_hall");
		}
		if(level flag::get("crystal_library") && !level flag::get("crystal_library_key"))
		{
			level thread function_94fc7512("library");
		}
		if(level flag::get("crystal_greenhouse") && !level flag::get("crystal_greenhouse_key"))
		{
			level thread function_94fc7512("greenhouse");
		}
		if(level flag::get_all(array("crystal_main_hall_key", "crystal_library_key", "crystal_greenhouse_key")))
		{
			scene::add_scene_func(#"p8_fxanim_zm_man_ooze_clump_bundle", &function_93e11617, "trails", player);
			level thread function_94fc7512();
			zm_unitrigger::unregister_unitrigger(self.stub);
		}
	}
}

/*
	Name: function_93e11617
	Namespace: namespace_b8f22955
	Checksum: 0xEAFB6CA1
	Offset: 0x3A90
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_93e11617(a_ents, e_player)
{
	level flag::set("unlock_pap_gate");
	array::wait_any(array::remove_undefined(a_ents), #"hash_6743539e144cc34c");
	if(zm_utility::is_player_valid(e_player))
	{
		e_player thread zm_vo::function_a2bd5a0c(#"hash_29c7299aeeb543d1");
	}
}

/*
	Name: function_94fc7512
	Namespace: namespace_b8f22955
	Checksum: 0x7DB1D4A
	Offset: 0x3B38
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function function_94fc7512(var_b374fe7b)
{
	if(isstring(var_b374fe7b))
	{
		level flag::set(("crystal_" + var_b374fe7b) + "_key");
	}
	level flag::wait_till(#"hash_6453fae6f9a19033");
	level flag::clear(#"hash_6453fae6f9a19033");
	s_scene = struct::get(#"p8_fxanim_zm_man_ooze_clump_bundle", "scriptbundlename");
	a_shots = s_scene.scenes[0].var_5a2219f0;
	str_shot = a_shots[s_scene.scene_played.size];
	s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", str_shot);
	if(isstring(var_b374fe7b))
	{
		level flag::set("crystal_" + var_b374fe7b);
	}
}

/*
	Name: function_35ce3b56
	Namespace: namespace_b8f22955
	Checksum: 0x2F41B46C
	Offset: 0x3CB0
	Size: 0x96
	Parameters: 1
	Flags: None
*/
function function_35ce3b56(s_scene)
{
	n_delay = int(2 * 1000);
	n_time = gettime();
	if(!isdefined(self.var_65a45e8c))
	{
		self.var_65a45e8c = n_time;
	}
	if(n_time > self.var_65a45e8c + n_delay)
	{
		s_scene waittill(#"hash_426564ac324c6a73");
	}
	self.var_65a45e8c = gettime();
}

/*
	Name: function_c996ff1
	Namespace: namespace_b8f22955
	Checksum: 0xBED10A77
	Offset: 0x3D50
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_c996ff1()
{
	level flag::wait_till("unlock_pap_gate");
	var_7ba3f1dd = getent("ooze_gate_col", "targetname");
	if(isdefined(var_7ba3f1dd))
	{
		var_7ba3f1dd connectpaths();
		var_7ba3f1dd delete();
	}
	zm_power::turn_power_on_and_open_doors(666);
	exploder::exploder("fxexp_pap_gate");
	exploder::exploder("exp_lgt_ooze_gate_torches");
	level flag::set("open_pap");
	if(level flag::get("open_pap_dev"))
	{
		return;
	}
	if(level.round_number <= 7)
	{
		level notify(#"hash_3464fd1132f34721");
	}
	else
	{
		level notify(#"hash_691d769f8aa3dcbd");
	}
	level thread function_72e53e19();
	wait(2);
	wait(1.5);
	level flag::set("flag_werewolf_set_intro");
	level flag::set("flag_bat_nosferatu_set_intro");
}

/*
	Name: function_72e53e19
	Namespace: namespace_b8f22955
	Checksum: 0xEC481D0
	Offset: 0x3F10
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_72e53e19()
{
	level endon(#"end_game");
	while(!isdefined(level.var_a6583e6d))
	{
		level.var_a6583e6d = namespace_977da60::function_47a88a0c(1, undefined, 1, struct::get("zone_forest_n", "script_noteworthy"));
		waitframe(1);
	}
	level.var_a6583e6d.var_126d7bef = 1;
	level.var_a6583e6d.no_powerups = 1;
	level.var_a6583e6d.var_f34ca9c4 = 1;
	scene::add_scene_func(#"hash_49e3dd966929fada", &function_c60ba36e, "play");
	scene::add_scene_func(#"hash_49e3dd966929fada", &function_a1d4bbeb, "done");
	level thread scene::play(#"hash_49e3dd966929fada", level.var_a6583e6d);
	level.var_a6583e6d thread function_1c62cd2();
}

/*
	Name: function_c60ba36e
	Namespace: namespace_b8f22955
	Checksum: 0x349DAC9B
	Offset: 0x4080
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function function_c60ba36e(a_ents)
{
	if(isactor(a_ents[#"hash_17e93fc8e34f1d4d"]))
	{
		a_ents[#"hash_17e93fc8e34f1d4d"].var_7b0667d9 = 1;
		a_ents[#"hash_17e93fc8e34f1d4d"].blockingpain = 1;
	}
}

/*
	Name: function_a1d4bbeb
	Namespace: namespace_b8f22955
	Checksum: 0xAD7A5320
	Offset: 0x4108
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function function_a1d4bbeb(a_ents)
{
	waitframe(1);
	if(isalive(a_ents[#"hash_17e93fc8e34f1d4d"]))
	{
		a_ents[#"hash_17e93fc8e34f1d4d"].var_7b0667d9 = undefined;
		a_ents[#"hash_17e93fc8e34f1d4d"].blockingpain = 0;
	}
}

/*
	Name: function_1c62cd2
	Namespace: namespace_b8f22955
	Checksum: 0xB0623C9D
	Offset: 0x4190
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_1c62cd2()
{
	self endon(#"death");
	var_9d90ef8b = scene::function_12479eba(#"hash_49e3dd966929fada");
	wait(var_9d90ef8b * 0.8);
	namespace_c05f06c7::function_2057ddc1(level.var_a6583e6d.origin, "werewolf", "react_first", array(0, 1), #"hash_1c4067bfba5af231");
}

/*
	Name: function_74bb3b2
	Namespace: namespace_b8f22955
	Checksum: 0x238E8CB9
	Offset: 0x4248
	Size: 0x114
	Parameters: 0
	Flags: None
*/
function function_74bb3b2()
{
	var_20c9365c = struct::get_array("gate_greeter_wolf", "targetname");
	foreach(var_32caf0b0 in var_20c9365c)
	{
		var_8469be27 = namespace_c402654::function_62db7b1c(1, var_32caf0b0);
		if(isdefined(var_8469be27))
		{
			var_8469be27.var_126d7bef = 1;
			var_8469be27.ignore_round_spawn_failsafe = 1;
			var_8469be27.ignore_enemy_count = 1;
			var_8469be27.b_ignore_cleanup = 1;
			var_8469be27.no_powerups = 1;
		}
		wait(0.5);
	}
}

/*
	Name: function_2605cb3d
	Namespace: namespace_b8f22955
	Checksum: 0xD2B6B727
	Offset: 0x4368
	Size: 0x50C
	Parameters: 0
	Flags: Linked
*/
function function_2605cb3d()
{
	level endon("end_game");
	/#
		var_e9c37042 = array(#"p8_fxanim_zm_man_pap_drawers_bundle", #"p8_fxanim_zm_man_pap_graveyard_bundle", #"p8_fxanim_zm_man_pap_lantern_bundle", #"p8_fxanim_zm_man_pap_platter_bundle", #"p8_fxanim_zm_man_pap_quest_entrance_room_bundle", #"p8_fxanim_zm_man_pap_quest_statue_fountain_bundle", #"p8_fxanim_zm_man_pap_quest_statue_garden_bundle", #"p8_fxanim_zm_man_pap_safe_bundle", #"p8_fxanim_zm_man_pap_sarcophagus_bundle", #"p8_fxanim_zm_man_pap_terrace_bundle", #"p8_fxanim_zm_man_pap_wall_bundle", #"p8_fxanim_zm_man_clock_01_bundle", #"p8_fxanim_zm_man_clock_02_bundle", #"p8_fxanim_zm_man_clock_03_bundle");
		foreach(str_scene in var_e9c37042)
		{
			scene::add_scene_func(str_scene, &function_11886796, "");
		}
	#/
	scene::add_scene_func(#"p8_fxanim_zm_man_pap_lantern_bundle", &function_62561ed8, "done");
	util::delay(10, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_wall_bundle");
	level flag::wait_till_any(array(#"power_on1", #"hash_2daf5bdda85cc660"));
	/#
		foreach(str_scene in var_e9c37042)
		{
			scene::remove_scene_func(str_scene, &function_11886796, "");
		}
	#/
	util::delay(5, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_drawers_bundle");
	util::delay(6, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_graveyard_bundle");
	util::delay(7, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_lantern_bundle");
	util::delay(8, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_platter_bundle");
	util::delay(9, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_quest_entrance_room_bundle");
	util::delay(10, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_quest_statue_fountain_bundle");
	util::delay(11, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_quest_statue_garden_bundle");
	util::delay(12, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_safe_bundle");
	util::delay(13, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_sarcophagus_bundle");
	util::delay(14, "end_game", &scene::init, #"p8_fxanim_zm_man_pap_terrace_bundle");
}

/*
	Name: function_a865c184
	Namespace: namespace_b8f22955
	Checksum: 0xBD54F83E
	Offset: 0x4880
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_a865c184()
{
	scene::add_scene_func(#"p8_fxanim_zm_man_ooze_clump_bundle", &function_cf336ef1, "init");
	scene::add_scene_func(#"p8_fxanim_zm_man_ooze_clump_bundle", &function_d9ad128c, "clump01_rise", "clump01_rise");
	scene::add_scene_func(#"p8_fxanim_zm_man_ooze_clump_bundle", &function_d9ad128c, "clump02_rise", "clump02_rise");
	scene::add_scene_func(#"p8_fxanim_zm_man_ooze_clump_bundle", &function_d9ad128c, "clump03_rise", "clump03_rise");
	util::delay(4, "end_game", &scene::init, #"p8_fxanim_zm_man_ooze_clump_bundle");
}

/*
	Name: function_62561ed8
	Namespace: namespace_b8f22955
	Checksum: 0x405DD646
	Offset: 0x49C8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_62561ed8(a_ents)
{
	level util::delay(6, #"end_game", &exploder::stop_exploder, "fxexp_pap_mausoleum_fire");
}

/*
	Name: function_cf336ef1
	Namespace: namespace_b8f22955
	Checksum: 0x10BDF002
	Offset: 0x4A20
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_cf336ef1(a_ents)
{
	level flag::init(#"hash_6453fae6f9a19033", 1);
	var_7ba3f1dd = getent("ooze_gate_col", "targetname");
	if(isdefined(var_7ba3f1dd))
	{
		var_7ba3f1dd disconnectpaths();
	}
	array::thread_all(a_ents, &clientfield::set, "" + #"hash_58b293ceeb7f93e4", 1);
}

/*
	Name: function_d9ad128c
	Namespace: namespace_b8f22955
	Checksum: 0x6530B84A
	Offset: 0x4AE8
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function function_d9ad128c(a_ents, str_shot)
{
	switch(str_shot)
	{
		case "clump01_rise":
		{
			var_79a8b01b = "Prop 1";
			break;
		}
		case "clump02_rise":
		{
			var_79a8b01b = "Prop 2";
			break;
		}
		default:
		{
			var_79a8b01b = "Prop 3";
		}
	}
	var_f67ecd64 = a_ents[var_79a8b01b];
	var_f67ecd64 clientfield::set("" + #"hash_58b293ceeb7f93e4", 0);
	wait(9);
	if(isdefined(var_f67ecd64))
	{
		var_f67ecd64 delete();
	}
}

/*
	Name: function_cdb8fe80
	Namespace: namespace_b8f22955
	Checksum: 0xD6BDCFDD
	Offset: 0x4BE8
	Size: 0x224
	Parameters: 0
	Flags: Linked
*/
function function_cdb8fe80()
{
	level endon(#"end_game");
	a_paintings = [];
	if(!isdefined(a_paintings))
	{
		a_paintings = [];
	}
	else if(!isarray(a_paintings))
	{
		a_paintings = array(a_paintings);
	}
	a_paintings[a_paintings.size] = getent("painting_1", "targetname");
	if(!isdefined(a_paintings))
	{
		a_paintings = [];
	}
	else if(!isarray(a_paintings))
	{
		a_paintings = array(a_paintings);
	}
	a_paintings[a_paintings.size] = getent("painting_2", "targetname");
	if(!isdefined(a_paintings))
	{
		a_paintings = [];
	}
	else if(!isarray(a_paintings))
	{
		a_paintings = array(a_paintings);
	}
	a_paintings[a_paintings.size] = getent("painting_3", "targetname");
	if(!isdefined(a_paintings))
	{
		a_paintings = [];
	}
	else if(!isarray(a_paintings))
	{
		a_paintings = array(a_paintings);
	}
	a_paintings[a_paintings.size] = getent("painting_4", "targetname");
	level flag::wait_till("all_players_spawned");
	array::thread_all(a_paintings, &clientfield::set, "" + #"hash_11eb6b7dc7db71ad", 1);
}

/*
	Name: function_9e7129d2
	Namespace: namespace_b8f22955
	Checksum: 0x95F97028
	Offset: 0x4E18
	Size: 0xB78
	Parameters: 4
	Flags: Linked
*/
function function_9e7129d2(e_player, s_stone, var_6cf4ded4, str_hint)
{
	n_player_index = namespace_c05f06c7::get_player_index(e_player);
	var_6cf4ded4 = function_617b9c13(var_6cf4ded4, e_player, str_hint);
	/#
		if(getdvarint(#"hash_3c4df2fe4b1618d5", 0))
		{
			var_3032d18d = getdvarint(#"hash_d7d89d5096898ec", 1);
			if(var_3032d18d != n_player_index)
			{
				n_player_index = var_3032d18d;
			}
		}
	#/
	s_teleport_room = struct::get("s_crystal_ball_room_" + n_player_index);
	e_player.b_gazing = 1;
	e_player.var_f22c83f5 = 1;
	e_player.var_9414a188 = 1;
	e_player val::set(#"gazing", "ignoreme", 1);
	e_player val::set(#"gazing", "takedamage", 0);
	e_player val::set(#"gazing", "show_hud", 0);
	e_player val::set(#"gazing", "show_weapon_hud", 0);
	e_player freezecontrols(1);
	e_player disableweapons();
	e_player disableoffhandweapons();
	s_anim = spawnstruct();
	s_anim.origin = e_player.origin;
	var_476002f7 = e_player.angles;
	if(isdefined(s_stone))
	{
		var_476002f7 = vectortoangles(s_stone.origin - e_player.origin);
	}
	s_anim.angles = var_476002f7;
	e_player thread namespace_c05f06c7::function_5f42b3e2(s_anim);
	v_cam = (s_teleport_room.origin + vectorscale((0, 0, 1), 64)) + vectorscale(anglestoforward(s_teleport_room.angles), 16);
	var_59e3224a = 1090;
	/#
		var_59e3224a = getdvarint(#"hash_1775ae42c634445e", var_59e3224a);
	#/
	v_loc = v_cam + (anglestoforward(s_teleport_room.angles) * var_59e3224a);
	s_wormhole = struct::spawn(v_loc, (s_teleport_room.angles[0], s_teleport_room.angles[1] + 90, s_teleport_room.angles[2]));
	/#
		s_wormhole thread debug_draw_star();
	#/
	var_fd99631b = util::spawn_model(#"hash_106db0f970e1faec", s_wormhole.origin, s_wormhole.angles);
	e_player util::create_streamer_hint(v_cam, s_teleport_room.angles, 1);
	e_player waittill(#"hash_18259ed594f164dc", #"disconnect");
	s_wormhole thread scene::play(#"p8_fxanim_zm_man_wormhole_bundle_vision_stone", var_fd99631b);
	/#
		if(!isdefined(var_6cf4ded4))
		{
			var_6cf4ded4 = getdvarint(#"hash_8a909b353203ed4", 1);
		}
	#/
	var_fd99631b clientfield::set("" + #"hash_33f073e3476b420d", var_6cf4ded4);
	if(isplayer(e_player))
	{
		e_player camerasetposition(v_cam, s_teleport_room.angles);
		e_player cameraactivate(1);
		if(var_6cf4ded4 == 17)
		{
			e_player util::delay(2.3, "disconnect", &function_856b4499);
		}
		e_player clientfield::set_to_player("" + #"hash_2d63a1398e98f279", 1);
		e_player clientfield::set_to_player("" + #"hash_ea66e39c63f5b41", 1);
		e_player util::delay(2.5, "disconnect", &util::create_streamer_hint, e_player.origin, e_player.angles, 1);
		e_player playrumblelooponentity(#"hash_5d8a1a68b12dfb24");
		if(var_6cf4ded4 == 17)
		{
			n_time = gettime();
		}
		var_be17187b = undefined;
		var_be17187b = e_player waittill_timeout(3, #"hide_equipment_hint_text", #"disconnect", #"death");
	}
	if(isdefined(n_time))
	{
		n_timeout = int(3 * 1000);
		while(isplayer(e_player) && (gettime() - n_time) < n_timeout)
		{
			waitframe(1);
		}
	}
	if(isplayer(e_player))
	{
		e_player notify(#"hash_30795d8b5cd79089");
		e_player stoprumble(#"hash_5d8a1a68b12dfb24");
		e_player util::streamer_wait(undefined, 0, 0.5);
		if(isplayer(e_player))
		{
			if(var_be17187b._notify == #"timeout")
			{
				e_player notify(#"hide_equipment_hint_text");
			}
			e_player notify(#"hash_770bb1239dc37ad0");
			e_player camerasetposition(e_player gettagorigin("tag_eye"), e_player gettagangles("tag_eye"));
			e_player cameraactivate(0);
			e_player clientfield::set_to_player("" + #"hash_ea66e39c63f5b41", 0);
			e_player clientfield::set_to_player("" + #"hash_2d63a1398e98f279", 0);
			e_player waittill(#"hash_18259ed594f164dc", #"disconnect", #"death");
		}
	}
	if(isplayer(e_player))
	{
		if(var_6cf4ded4 == 17)
		{
			e_player thread zm_vo::function_a2bd5a0c("vox_seer_stone_jump_react", 0.2, 0, 9999, 1);
		}
		e_player freezecontrols(0);
		e_player enableweapons();
		e_player enableoffhandweapons();
		e_player util::delay(2, "disconnect", &val::reset, #"gazing", "ignoreme");
		e_player val::reset(#"gazing", "takedamage");
		e_player val::reset(#"gazing", "show_hud");
		e_player val::reset(#"gazing", "show_weapon_hud");
		e_player util::clear_streamer_hint();
		e_player.var_f22c83f5 = 0;
		e_player.b_gazing = 0;
		e_player.var_9414a188 = undefined;
	}
	if(isdefined(s_stone))
	{
		s_stone flag::clear("flag_gazing_stone_in_use");
	}
	s_wormhole scene::stop();
	s_wormhole struct::delete();
	s_anim struct::delete();
	var_fd99631b thread function_e29d2d07();
	wait(2);
	if(isplayer(e_player))
	{
		level notify(#"hash_43aa2c21cf191318", {#e_player:e_player});
	}
}

/*
	Name: function_e29d2d07
	Namespace: namespace_b8f22955
	Checksum: 0xBBDC7080
	Offset: 0x5998
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_e29d2d07()
{
	self clientfield::set("" + #"hash_33f073e3476b420d", 0);
	wait(0.1);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_856b4499
	Namespace: namespace_b8f22955
	Checksum: 0x1BE49ED7
	Offset: 0x59F8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_856b4499()
{
	if(isplayer(self))
	{
		self playsoundtoplayer(#"hash_1a4480459e1a1aaa", self);
	}
}

/*
	Name: function_a93fe3a4
	Namespace: namespace_b8f22955
	Checksum: 0x19E4C7C2
	Offset: 0x5A48
	Size: 0x1B6
	Parameters: 1
	Flags: Linked
*/
function function_a93fe3a4(str_loc)
{
	switch(str_loc)
	{
		case "cemetery":
		{
			var_4e290f2e = "graveyard";
			break;
		}
		case "garden":
		{
			var_4e290f2e = "gardens";
			break;
		}
	}
	var_58717b80 = struct::get_array("perk_vapor_altar");
	foreach(s_perk in var_58717b80)
	{
		if(s_perk.prefabname == var_4e290f2e)
		{
			n_index = s_perk.script_int;
		}
	}
	switch(n_index)
	{
		case 0:
		{
			str_model = "p8_fxanim_zm_vapor_altar_danu_mod";
			break;
		}
		case 1:
		{
			str_model = "p8_fxanim_zm_vapor_altar_ra_mod";
			break;
		}
		case 2:
		{
			str_model = "p8_fxanim_zm_vapor_altar_zeus_mod";
			break;
		}
		case 3:
		{
			str_model = "p8_fxanim_zm_vapor_altar_odin_mod";
			break;
		}
	}
	return str_model;
}

/*
	Name: function_5713470b
	Namespace: namespace_b8f22955
	Checksum: 0x7048072C
	Offset: 0x5C08
	Size: 0x790
	Parameters: 0
	Flags: Linked
*/
function function_5713470b()
{
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		player = s_result.activator;
		if(isdefined(player.var_d049df11) && player.var_d049df11)
		{
			continue;
		}
		if(!zm_utility::can_use(player) || (distancesquared(groundtrace(player.origin, player.origin + (vectorscale((0, 0, -1), 128)), 0, player)[#"position"], player.origin)) > 16)
		{
			continue;
		}
		if(self.stub.var_f0e6c7a2 flag::get("flag_gazing_stone_in_use"))
		{
			continue;
		}
		self.stub.var_f0e6c7a2 flag::set("flag_gazing_stone_in_use");
		player.b_gazing = 0;
		switch(self.stub.str_hint)
		{
			case "cemetery":
			{
				vol_transform = getent("vol_transform_library", "targetname");
				s_loc = struct::get("key_library_loc");
				str_model = function_a93fe3a4("cemetery");
				var_6cf4ded4 = function_212eae28(str_model);
				break;
			}
			case "garden":
			{
				vol_transform = getent("vol_transform_greenhouse", "targetname");
				s_loc = struct::get("key_greenhouse_loc");
				str_model = function_a93fe3a4("garden");
				var_6cf4ded4 = function_212eae28(str_model);
				break;
			}
			case "clock_star":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 7;
				break;
			}
			case "clock_horseshoe":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 6;
				break;
			}
			case "clock_hook":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 5;
				break;
			}
			case "painting_1":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 1;
				break;
			}
			case "painting_2":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 2;
				break;
			}
			case "painting_3":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 3;
				break;
			}
			case "painting_4":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 4;
				break;
			}
			case "dl_loc":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 11;
				break;
			}
			case "bull_loc":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 12;
				break;
			}
			case "monkey_loc":
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				var_6cf4ded4 = 13;
				break;
			}
			default:
			{
				vol_transform = getent("vol_transform_main_hall", "targetname");
				s_loc = struct::get("key_main_hall_loc");
				break;
			}
		}
		if(!player.b_gazing)
		{
			if(isint(var_6cf4ded4))
			{
				level thread function_9e7129d2(player, self.stub.var_f0e6c7a2, var_6cf4ded4, self.stub.str_hint);
			}
			player thread namespace_c05f06c7::function_58dfa337(15);
			player thread namespace_c05f06c7::function_a113df82(18);
		}
		if(!isdefined(level.var_4b2ed5f))
		{
			level.var_4b2ed5f = [];
		}
		if(!isdefined(level.var_4b2ed5f[var_6cf4ded4]) && var_6cf4ded4 != 17)
		{
			level.var_4b2ed5f[var_6cf4ded4] = var_6cf4ded4;
			self thread function_16288b92(self.stub.var_1ed09409, s_loc, self.stub.mdl_key, vol_transform);
		}
	}
}

/*
	Name: function_212eae28
	Namespace: namespace_b8f22955
	Checksum: 0x23292EEF
	Offset: 0x63A0
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function function_212eae28(str_model)
{
	switch(str_model)
	{
		case "p8_fxanim_zm_vapor_altar_odin_mod":
		{
			n_index = 8;
			break;
		}
		case "p8_fxanim_zm_vapor_altar_ra_mod":
		{
			n_index = 9;
			break;
		}
		default:
		{
			n_index = 10;
		}
	}
	return n_index;
}

/*
	Name: function_4e8b75e0
	Namespace: namespace_b8f22955
	Checksum: 0xBBDE3676
	Offset: 0x6428
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_4e8b75e0()
{
	n_random = array::random(level.var_c25e1f9c);
	arrayremovevalue(level.var_c25e1f9c, n_random);
	switch(n_random)
	{
		case 0:
		{
			str_type = "painting";
			break;
		}
		case 1:
		{
			str_type = "trophy";
			break;
		}
	}
	return str_type;
}

/*
	Name: function_639c87e1
	Namespace: namespace_b8f22955
	Checksum: 0xCDDDA057
	Offset: 0x64D8
	Size: 0x176
	Parameters: 1
	Flags: Linked
*/
function function_639c87e1(str_type)
{
	switch(str_type)
	{
		case "nos":
		{
			str_loc = array::random(level.var_28edc152);
			arrayremovevalue(level.var_28edc152, str_loc);
			break;
		}
		case "painting":
		{
			str_loc = array::random(array("painting_1", "painting_2", "painting_3", "painting_4"));
			break;
		}
		case "clock":
		{
			str_loc = array::random(array("clock_star", "clock_horseshoe", "clock_hook"));
			break;
		}
		case "trophy":
		{
			str_loc = array::random(array("monkey_loc", "bull_loc", "dl_loc"));
			break;
		}
	}
	return str_loc;
}

/*
	Name: function_617b9c13
	Namespace: namespace_b8f22955
	Checksum: 0x19B2E1C1
	Offset: 0x6658
	Size: 0x18E
	Parameters: 3
	Flags: Linked
*/
function function_617b9c13(n_index, e_player, str_type)
{
	if(!zm_utility::function_e51dc2d8() || !isstring(str_type))
	{
		return n_index;
	}
	if(!isdefined(e_player.var_2ee03c07))
	{
		e_player.var_2ee03c07 = [];
	}
	else if(!isarray(e_player.var_2ee03c07))
	{
		e_player.var_2ee03c07 = array(e_player.var_2ee03c07);
	}
	if(!isdefined(e_player.var_2ee03c07[str_type]))
	{
		e_player.var_2ee03c07[str_type] = 0;
	}
	e_player.var_2ee03c07[str_type]++;
	if(isdefined(level.var_d698a430) && level.var_d698a430 || (e_player.var_2ee03c07[str_type] == 7 || (e_player.var_2ee03c07[str_type] > 7 && randomint(100) < 10)))
	{
		n_index = 17;
	}
	return n_index;
}

/*
	Name: function_16ce67dd
	Namespace: namespace_b8f22955
	Checksum: 0x1F929FC2
	Offset: 0x67F0
	Size: 0xBA
	Parameters: 1
	Flags: None
*/
function function_16ce67dd(vol_transform)
{
	while(true)
	{
		a_zombies = getaiteamarray(level.zombie_team);
		for(i = 0; i < a_zombies.size; i++)
		{
			if(a_zombies[i] istouching(vol_transform) && a_zombies[i].archetype === #"zombie")
			{
				return a_zombies[i];
			}
		}
		wait(1);
	}
}

/*
	Name: function_16288b92
	Namespace: namespace_b8f22955
	Checksum: 0xB09D5A51
	Offset: 0x68B8
	Size: 0x1414
	Parameters: 4
	Flags: Linked
*/
function function_16288b92(str_type, s_loc, mdl_key, vol_transform)
{
	v_offset = vectorscale((0, 0, 1), 16);
	s_stub = self.stub;
	switch(str_type)
	{
		case "nos":
		{
			if(vol_transform.targetname == #"vol_transform_library")
			{
				t_spawn = getent("trigger_shadow_enemy_cemetery", "targetname");
				s_key = array::random(struct::get_array("cemetery_pap_key"));
			}
			else
			{
				t_spawn = getent("trigger_shadow_enemy_garden", "targetname");
				s_key = array::random(struct::get_array("gardens_pap_key"));
			}
			/#
				t_spawn thread function_debf98ad();
			#/
			t_spawn thread function_f7b04d9c(s_key);
			level flag::wait_till("nosferatu_pap_event_done");
			/#
				t_spawn function_af24d641();
			#/
			if(isdefined(level.var_9ce3e25a))
			{
				s_loc.origin = level.var_9ce3e25a;
			}
			else
			{
				mdl_trail = util::spawn_model("tag_origin", s_key.origin + vectorscale((0, 0, 1), 500));
				mdl_trail clientfield::set("" + #"soul_fx", 1);
				mdl_trail moveto(s_key.origin, 2);
				mdl_trail waittill(#"movedone");
				mdl_trail delete();
				s_loc.origin = s_key.origin;
			}
			level thread function_49eab22d(s_key);
			break;
		}
		case "painting":
		{
			var_ff4b3a13 = getent(s_stub.str_hint, "targetname");
			var_19762c3e = 96;
			str_loc = s_stub.str_hint;
			v_offset = (0, 0, 0);
			if(var_ff4b3a13.targetname == "painting_4")
			{
				v_offset = vectorscale((0, 0, -1), 16);
			}
			else
			{
				v_offset = vectorscale((0, 0, -1), 28);
			}
			str_loc = array::random(level.var_28edc152);
			arrayremovevalue(level.var_28edc152, str_loc);
			if(str_loc == "cemetery")
			{
				var_48246e0 = "gravestone";
				s_clue = array::random(struct::get_array("painting_clue_cemetery"));
			}
			else
			{
				var_48246e0 = "hedge";
				s_clue = array::random(struct::get_array("painting_clue_garden"));
			}
			s_spawnpt = struct::get(var_ff4b3a13.target);
			s_portal = struct::get(var_ff4b3a13.script_noteworthy);
			/#
				var_ff4b3a13 thread function_debf98ad();
			#/
			/#
				s_spawnpt thread debug_draw_star();
			#/
			var_47323b73 = s_spawnpt zm_unitrigger::create(&function_7c097281, 64, &function_450b01a5);
			var_47323b73.str_flag = "painting_clue";
			var_47323b73.var_1fe5108 = getent(var_48246e0, "targetname");
			var_47323b73.var_ff4b3a13 = var_ff4b3a13;
			var_47323b73.v_offset = v_offset;
			var_47323b73.str_flag = "painting_clue";
			var_47323b73.var_48246e0 = var_48246e0;
			level flag::wait_till("painting_clue");
			var_ff4b3a13 clientfield::set("" + #"hash_11eb6b7dc7db71ad", 0);
			var_ff4b3a13 playsound(#"hash_20df90b365932d7c");
			wait(2);
			e_fx = util::spawn_model(#"tag_origin", s_spawnpt.origin);
			e_fx playsound("zmb_sq_souls_release");
			e_fx playloopsound("zmb_sq_souls_lp");
			e_fx delete();
			/#
				var_ff4b3a13 function_af24d641();
			#/
			/#
				s_spawnpt function_af24d641();
			#/
			nd_start = getvehiclenode(var_ff4b3a13.targetname + "_spline", "targetname");
			e_trail = util::spawn_model("tag_origin", nd_start.origin, nd_start.angles);
			e_trail thread function_c9c7a593();
			e_trail thread function_7ff450ae();
			/#
				e_trail thread function_debf98ad();
			#/
			e_trail show_trail(nd_start, var_ff4b3a13);
			e_trail thread scene::play(#"hash_1d324e9f967f0848", e_trail);
			e_trail.mdl_head thread scene::play(#"hash_1d324e9f967f0848", e_trail.mdl_head);
			s_loc = s_portal;
			t_portal = getent("trigger_portal", "targetname");
			t_portal.origin = s_loc.origin;
			t_portal waittill(#"trigger");
			e_trail clientfield::set("" + #"soul_fx", 0);
			wait(0.1);
			e_trail playsound(#"hash_72a28324d62874cc");
			e_trail clientfield::set("" + #"ghost_trail", 0);
			waitframe(3);
			if(isdefined(e_trail))
			{
				e_trail thread scene::stop();
				e_trail delete();
				if(isdefined(e_trail.mdl_head))
				{
					e_trail.mdl_head thread scene::stop();
					e_trail.mdl_head delete();
				}
			}
			break;
		}
		case "clock":
		{
			s_clock = struct::get(s_stub.str_hint, "script_noteworthy");
			s_loc = struct::get(s_clock.target);
			v_offset = (0, 0, 0);
			level thread scene::play(s_loc.var_50ed3bae, "Shot 1");
			var_991cace9 = spawn("script_origin", s_clock.origin);
			var_991cace9 playloopsound(#"hash_36b6c118a7b66199");
			var_47323b73 = s_loc zm_unitrigger::create(&function_5c8eab18, 64, &function_d29a3f81);
			var_47323b73.str_flag = "clock";
			var_47323b73.s_clock = s_clock;
			var_c597d89a = struct::get("vol_" + s_stub.str_hint);
			var_47323b73.vol_defend = spawn("trigger_radius", var_c597d89a.origin, 0, var_c597d89a.radius, var_c597d89a.height);
			var_47323b73.vol_defend.targetname = var_c597d89a.targetname;
			var_47323b73.var_159100b7 = mdl_key.targetname;
			level flag::wait_till("clock");
			var_991cace9 delete();
			wait(1);
			break;
		}
		case "trophy":
		{
			str_loc = s_stub.str_hint;
			v_offset = (0, 0, 0);
			s_trophy = struct::get(str_loc);
			s_spawnpt = struct::get(s_trophy.target);
			s_portal = struct::get(str_loc, "script_noteworthy");
			/#
				s_trophy thread function_debf98ad();
			#/
			/#
				s_spawnpt thread debug_draw_star();
			#/
			var_47323b73 = s_trophy zm_unitrigger::create(&function_7c097281, 64, &function_4135e83e);
			var_47323b73.str_flag = "trophy_prints";
			if(s_trophy.targetname == "monkey_loc")
			{
				var_7b57e2cc = getent("monkey_lid", "targetname");
				var_7b57e2cc rotateroll(-27, 0.5);
				var_7b57e2cc playsound(#"hash_56315c5fd55c0092");
			}
			level flag::wait_till(var_47323b73.str_flag);
			e_fx = util::spawn_model(#"tag_origin", s_spawnpt.origin);
			e_fx playsound("zmb_sq_souls_release");
			e_fx playloopsound("zmb_sq_souls_lp");
			if(s_trophy.targetname == "monkey_loc")
			{
				var_7b57e2cc = getent("monkey_lid", "targetname");
				var_7b57e2cc rotateroll(27, 0.5);
				var_7b57e2cc playsound(#"hash_3d156fc836a3f16");
			}
			e_fx delete();
			/#
				s_trophy function_af24d641();
			#/
			/#
				s_spawnpt function_af24d641();
			#/
			nd_start = getvehiclenode(s_trophy.targetname + "_trail_start_node", "targetname");
			e_trail = util::spawn_model("tag_origin", nd_start.origin, nd_start.angles);
			e_trail thread function_c9c7a593();
			e_trail thread function_7ff450ae();
			/#
				e_trail thread function_debf98ad();
			#/
			e_trail show_trail(nd_start);
			e_trail thread scene::play(#"hash_1d324e9f967f0848", e_trail);
			e_trail.mdl_head thread scene::play(#"hash_1d324e9f967f0848", e_trail.mdl_head);
			s_loc = e_trail.s_portal;
			s_loc.origin = e_trail.s_portal.origin + vectorscale((0, 0, 1), 48);
			t_portal = getent("trigger_portal", "targetname");
			t_portal.origin = groundtrace(s_loc.origin, s_loc.origin + (vectorscale((0, 0, -1), 128)), 0, e_trail)[#"position"];
			t_portal waittill(#"trigger");
			e_trail clientfield::set("" + #"soul_fx", 0);
			wait(0.1);
			e_trail playsound(#"hash_72a28324d62874cc");
			e_trail clientfield::set("" + #"ghost_trail", 0);
			waitframe(3);
			if(isdefined(e_trail))
			{
				e_trail thread scene::stop();
				e_trail delete();
				if(isdefined(e_trail.mdl_head))
				{
					e_trail.mdl_head thread scene::stop();
					e_trail.mdl_head delete();
				}
			}
			break;
		}
	}
	if(isdefined(s_loc.var_50ed3bae))
	{
		s_scene = struct::get(s_loc.var_50ed3bae, "scriptbundlename");
		foreach(s_scene in s_scene.scenes)
		{
			var_b2a60109 = s_scene._s.var_b5d05f70;
			break;
		}
		switch(s_loc.var_50ed3bae)
		{
			case "p8_fxanim_zm_man_clock_03_bundle":
			case "p8_fxanim_zm_man_clock_01_bundle":
			case "p8_fxanim_zm_man_clock_02_bundle":
			{
				var_8a9c5e4f = 1;
				var_1f24f68d = 0;
				break;
			}
			default:
			{
				var_8a9c5e4f = 0;
				var_1f24f68d = 1;
			}
		}
		level scene::add_scene_func(s_loc.var_50ed3bae, &function_342e0887, var_b2a60109[0 + var_8a9c5e4f], mdl_key, s_stub.var_e62bb9d2);
		level thread function_2f2d292b(s_loc, mdl_key, var_b2a60109, var_8a9c5e4f);
		mdl_key waittill(#"hash_7965b64017c8bf50");
	}
	else
	{
		mdl_key moveto(s_loc.origin + v_offset, 0.05);
		mdl_key waittill(#"movedone");
		mdl_key thread function_224d642(s_stub.var_e62bb9d2);
	}
	if(!isdefined(mdl_key.var_fe321a35))
	{
		mdl_key.var_fe321a35 = 64;
	}
	var_47323b73 = mdl_key zm_unitrigger::create(&function_74d1be5d, mdl_key.var_fe321a35, &trigger_think);
	var_47323b73.var_db9b80c9 = mdl_key.var_db9b80c9;
	var_47323b73.str_type = str_type;
	if(str_type == "nos")
	{
		level waittill(#"hash_2e6a18007d9e2996");
	}
	zm_unitrigger::unregister_unitrigger(s_stub);
}

/*
	Name: function_2f2d292b
	Namespace: namespace_b8f22955
	Checksum: 0xAA8E6753
	Offset: 0x7CD8
	Size: 0xBC
	Parameters: 4
	Flags: Linked
*/
function function_2f2d292b(s_loc, mdl_key, var_b2a60109, var_8a9c5e4f)
{
	level scene::play(s_loc.var_50ed3bae, var_b2a60109[0 + var_8a9c5e4f]);
	level thread scene::play(s_loc.var_50ed3bae, var_b2a60109[1 + var_8a9c5e4f]);
	level thread function_22b22d52(mdl_key, s_loc.var_50ed3bae, var_b2a60109[2 + var_8a9c5e4f]);
}

/*
	Name: function_22b22d52
	Namespace: namespace_b8f22955
	Checksum: 0xC09E075A
	Offset: 0x7DA0
	Size: 0x64
	Parameters: 3
	Flags: Linked
*/
function function_22b22d52(mdl_key, str_scene, str_shot)
{
	if(isdefined(str_shot))
	{
		if(isdefined(mdl_key))
		{
			mdl_key waittill(#"death");
		}
		level thread scene::play(str_scene, str_shot);
	}
}

/*
	Name: function_f7b04d9c
	Namespace: namespace_b8f22955
	Checksum: 0x2D826871
	Offset: 0x7E10
	Size: 0x678
	Parameters: 1
	Flags: Linked
*/
function function_f7b04d9c(s_key)
{
	level endon(#"nosferatu_pap_event_done", #"end_game");
	level.var_42c74991 = 0;
	if(getplayers().size > 2)
	{
		n_max_zombies = 9;
		var_4e06036b = 2.5;
		var_d18f896 = 5;
	}
	else if(getplayers().size > 1)
	{
		n_max_zombies = 6;
		var_4e06036b = 4;
		var_d18f896 = 8;
	}
	else
	{
		n_max_zombies = 3;
		var_4e06036b = 5;
		var_d18f896 = 10;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		if(isplayer(waitresult.activator))
		{
			e_player = waitresult.activator;
			break;
		}
	}
	e_player thread function_51367ff6(s_key.origin);
	level thread namespace_9d27962b::function_93eab559();
	if(s_key.targetname === "cemetery_pap_key")
	{
		exploder::exploder("fxexp_pap_barrier_nosferatu");
	}
	else
	{
		exploder::exploder("fxexp_pap_barrier_nosferatu_2");
	}
	level thread function_a1d7d92b(self, "nosferatu_pap_event_done", "nosferatu_defend");
	level thread function_b7e42989();
	level.var_84b2907f = &function_1ea41244;
	level.var_2f477020 = self;
	var_f1c4ec4f = e_player zm_utility::get_current_zone(1);
	var_2815c876 = var_f1c4ec4f.a_loc_types[#"bat_location"];
	var_6aea2f76 = [];
	a_adjacent_zones = getarraykeys(var_f1c4ec4f.adjacent_zones);
	for(i = 0; i < a_adjacent_zones.size; i++)
	{
		if(var_f1c4ec4f.adjacent_zones[a_adjacent_zones[i]].is_connected)
		{
			var_c714ccfe = level.zones[a_adjacent_zones[i]];
			var_9387e4ab = var_c714ccfe.a_loc_types[#"bat_location"];
			if(!isdefined(var_9387e4ab))
			{
				var_9387e4ab = [];
			}
			else if(!isarray(var_9387e4ab))
			{
				var_9387e4ab = array(var_9387e4ab);
			}
			if(isdefined(var_9387e4ab))
			{
				foreach(s_spawner in var_9387e4ab)
				{
					if(distancesquared(s_spawner.origin, s_key.origin) < 8000 * 8000)
					{
						if(!isdefined(var_6aea2f76))
						{
							var_6aea2f76 = [];
						}
						else if(!isarray(var_6aea2f76))
						{
							var_6aea2f76 = array(var_6aea2f76);
						}
						var_6aea2f76[var_6aea2f76.size] = s_spawner;
					}
				}
			}
		}
	}
	var_3779c48 = [];
	var_a1e469f3 = arraycombine(var_2815c876, var_6aea2f76, 0, 0);
	if(isdefined(s_key.location))
	{
		foreach(s_spawn in var_a1e469f3)
		{
			if(s_spawn.targetname == s_key.location)
			{
				if(!isdefined(var_3779c48))
				{
					var_3779c48 = [];
				}
				else if(!isarray(var_3779c48))
				{
					var_3779c48 = array(var_3779c48);
				}
				var_3779c48[var_3779c48.size] = s_spawn;
			}
		}
	}
	s_pos = array::random(var_3779c48);
	var_ad728f = undefined;
	while(!level flag::get("nosferatu_pap_event_done"))
	{
		level flag::wait_till("nosferatu_defend");
		while(level.var_42c74991 > n_max_zombies)
		{
			waitframe(1);
		}
		while(var_ad728f === s_pos)
		{
			s_pos = array::random(var_3779c48);
			waitframe(1);
		}
		var_ad728f = s_pos;
		level thread spawn_nosferatu_defend(s_pos);
		wait(randomfloatrange(var_4e06036b, var_d18f896));
	}
}

/*
	Name: function_51367ff6
	Namespace: namespace_b8f22955
	Checksum: 0x861640DE
	Offset: 0x8490
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function function_51367ff6(v_loc)
{
	level endon(#"end_game");
	self endon(#"death");
	if(zm_utility::is_player_valid(self))
	{
		var_83201b91 = self;
	}
	else
	{
		a_e_players = util::get_active_players();
		a_e_players = arraysortclosest(a_e_players, v_loc);
		foreach(e_player in a_e_players)
		{
			if(e_player !== self && zm_utility::is_player_valid(e_player))
			{
				var_83201b91 = e_player;
				break;
			}
		}
	}
	if(isdefined(var_83201b91) && zm_utility::is_player_valid(var_83201b91))
	{
		var_83201b91 zm_vo::function_a2bd5a0c(#"hash_69cfed93cf2b2ec5", 1.9, 1, 9999, 0);
	}
}

/*
	Name: function_49eab22d
	Namespace: namespace_b8f22955
	Checksum: 0x8449B6BC
	Offset: 0x8618
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function function_49eab22d(s_key)
{
	level clientfield::set("" + #"hash_42e03f9ae74a1070", 0);
	if(s_key.targetname === "cemetery_pap_key")
	{
		exploder::stop_exploder("fxexp_pap_barrier_nosferatu");
	}
	else
	{
		exploder::stop_exploder("fxexp_pap_barrier_nosferatu_2");
	}
	level.var_84b2907f = undefined;
	level.var_2f477020 = undefined;
}

/*
	Name: spawn_nosferatu_defend
	Namespace: namespace_b8f22955
	Checksum: 0xB8F63
	Offset: 0x86C8
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function spawn_nosferatu_defend(s_pos)
{
	if(!isdefined(s_pos))
	{
		return;
	}
	ai = bat::function_2e37549f(1, s_pos, level.round_number);
	if(isalive(ai))
	{
		ai endon(#"death");
		ai.var_126d7bef = 1;
		ai.ignore_round_spawn_failsafe = 1;
		ai.ignore_enemy_count = 1;
		ai.b_ignore_cleanup = 1;
		ai zm_score::function_acaab828();
		level flag::wait_till("nosferatu_pap_event_done");
		ai dodamage(ai.health, ai.origin);
	}
}

/*
	Name: function_1ea41244
	Namespace: namespace_b8f22955
	Checksum: 0x96B46F19
	Offset: 0x87E0
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_1ea41244(ai)
{
	if(isalive(ai))
	{
		ai endon(#"death");
		ai.script_string = "find_flesh";
		ai thread function_1a3604f4(level.var_2f477020);
		ai.var_126d7bef = 1;
		ai.ignore_round_spawn_failsafe = 1;
		ai.ignore_enemy_count = 1;
		ai.b_ignore_cleanup = 1;
		ai thread function_c2c920c3();
		ai zm_score::function_acaab828();
		ai thread function_57fcbf3f();
		level flag::wait_till("nosferatu_pap_event_done");
		ai dodamage(ai.health, ai.origin);
	}
}

/*
	Name: function_57fcbf3f
	Namespace: namespace_b8f22955
	Checksum: 0x3292CF42
	Offset: 0x8920
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_57fcbf3f()
{
	level endon(#"nosferatu_pap_event_done");
	level.var_42c74991++;
	self waittill(#"death");
	if(level flag::get("nosferatu_pap_drop"))
	{
		var_d3b167fd = self.origin;
		v_drop = namespace_c05f06c7::function_a8176b98(var_d3b167fd);
		if(isdefined(v_drop) && !isdefined(level.var_9ce3e25a))
		{
			level.var_9ce3e25a = v_drop;
			level flag::set("nosferatu_defend");
			level flag::set("nosferatu_pap_event_done");
		}
	}
	level.var_42c74991--;
}

/*
	Name: function_b7e42989
	Namespace: namespace_b8f22955
	Checksum: 0x3EA24F80
	Offset: 0x8A20
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_b7e42989()
{
	level endon(#"nosferatu_pap_event_done");
	n_time = 40;
	while(n_time > 0)
	{
		wait(0.05);
		n_time = n_time - 0.05;
		if(!level flag::get("nosferatu_defend"))
		{
			level flag::wait_till("nosferatu_defend");
		}
	}
	level flag::set("nosferatu_pap_drop");
	wait(30);
	level flag::set("nosferatu_pap_event_done");
}

/*
	Name: function_ff4485b6
	Namespace: namespace_b8f22955
	Checksum: 0x2471A68
	Offset: 0x8AF8
	Size: 0x5DE
	Parameters: 3
	Flags: Linked
*/
function function_ff4485b6(a_ents, mdl_key, var_3128fb28)
{
	/#
		if(isdefined(self.var_b0ba8d36) && self.var_b0ba8d36)
		{
			return;
		}
		if(!isdefined(mdl_key))
		{
			self.var_b0ba8d36 = 1;
			if(!isdefined(mdl_key))
			{
				mdl_key = util::spawn_model(array::random(array(#"hash_2fa3430bd92ec805", #"hash_3d81fa5687d50740", #"hash_28f791b6dd2cda67")));
			}
			if(!isdefined(var_3128fb28))
			{
				var_3128fb28 = util::spawn_model(array::random(array(#"hash_75789bca38aa1419", #"hash_7e08d4df1f3ead6", #"hash_55f5de51b5f366fb")));
			}
		}
		if(getdvarint(#"hash_3c4df2fe4b1618d5", 0))
		{
			mdl_key thread function_debf98ad();
		}
	#/
	var_5b1e58f2 = a_ents[#"hash_7aff0ee60ddd937b"];
	switch(var_5b1e58f2.model)
	{
		case "hash_1dd3416afee692d8":
		{
			str_tag = "tag_drawers_tuning_fork_jnt";
			break;
		}
		case "hash_62c15aa0668683a":
		{
			str_tag = "tag_lantern_tuning_fork_jnt";
			break;
		}
		case "hash_2ceba6aefd3f75f4":
		{
			str_tag = "tag_wall_tuning_fork_jnt";
			break;
		}
		case "hash_37c9b0c4b462bd22":
		{
			str_tag = "tag_platter_tuning_fork_jnt";
			break;
		}
		case "hash_3fe50271537529e6":
		{
			str_tag = "tag_statue_fountain_tuning_fork_jnt";
			mdl_key.var_fe321a35 = 96;
			break;
		}
		case "hash_5b8a7611e9763f9b":
		{
			str_tag = "tag_entrance_room_tuning_fork_jnt";
			break;
		}
		case "hash_318a2711e4e77403":
		{
			str_tag = "tag_statue_tuning_fork_jnt";
			break;
		}
		case "hash_2c76d5bc4c5adb79":
		{
			str_tag = "tag_safe_tuning_fork_jnt";
			break;
		}
		case "hash_13fe648896c9dc33":
		{
			str_tag = "tag_grave_tuning_fork_jnt";
			break;
		}
		case "p8_fxanim_zm_man_clock_01_mod":
		{
			str_tag = "tag_clock_01_tuning_fork_jnt";
			break;
		}
		case "hash_3bf4900d0ea602b3":
		{
			str_tag = "tag_clock_02_tuning_fork_jnt";
			break;
		}
		case "hash_65ed2bf94169fd50":
		{
			str_tag = "tag_clock_03_tuning_fork_jnt";
			break;
		}
		default:
		{
			str_tag = "tag_key_attach";
		}
	}
	mdl_key show();
	mdl_key linkto(var_5b1e58f2, str_tag, (0, 0, 0), (0, 0, 0));
	if(!isdefined(mdl_key.fx_org))
	{
		mdl_key.fx_org = util::spawn_model(#"tag_origin");
		mdl_key.fx_org linkto(var_5b1e58f2, str_tag, (0, 0, 0), (0, 0, 0));
	}
	switch(var_3128fb28.model)
	{
		case "hash_75789bca38aa1419":
		{
			n_value = 1;
			break;
		}
		case "hash_7e08d4df1f3ead6":
		{
			n_value = 2;
			break;
		}
		default:
		{
			n_value = 3;
		}
	}
	s_waittill = undefined;
	s_waittill = var_5b1e58f2 waittill(#"hash_7e8ff943115ed67b", #"hash_7965b64017c8bf50", #"death");
	mdl_key.fx_org clientfield::set("" + #"hash_51257ec597a8f84f", n_value);
	if(isdefined(var_5b1e58f2) && s_waittill._notify != #"hash_7965b64017c8bf50")
	{
		var_5b1e58f2 waittill(#"hash_7965b64017c8bf50");
	}
	mdl_key playsound(#"hash_5c1e3168236012f9" + n_value);
	if(isdefined(var_5b1e58f2))
	{
		mdl_key notify(#"hash_7965b64017c8bf50");
	}
	/#
		if(isdefined(self.var_b0ba8d36) && self.var_b0ba8d36)
		{
			mdl_key.fx_org thread function_67a6aea8();
			mdl_key delete();
			var_3128fb28 delete();
			self.var_b0ba8d36 = 0;
		}
	#/
}

/*
	Name: function_342e0887
	Namespace: namespace_b8f22955
	Checksum: 0xAAF1636B
	Offset: 0x90E0
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function function_342e0887(a_ents, mdl_key, var_3128fb28)
{
	self function_ff4485b6(a_ents, mdl_key, var_3128fb28);
}

/*
	Name: function_11886796
	Namespace: namespace_b8f22955
	Checksum: 0x2A174301
	Offset: 0x9128
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_11886796(a_ents)
{
	/#
		self function_ff4485b6(a_ents);
	#/
}

/*
	Name: function_b0e1c435
	Namespace: namespace_b8f22955
	Checksum: 0x2F23EC5C
	Offset: 0x9158
	Size: 0x1A4
	Parameters: 0
	Flags: Private
*/
private function function_b0e1c435()
{
	self endon(#"disconnect");
	var_1a1cbe5a = 0;
	while(!var_1a1cbe5a && isarray(level.var_219a33e2) && isalive(self))
	{
		foreach(var_67335db8 in array::remove_undefined(level.var_219a33e2))
		{
			if(self function_80d68e4d(var_67335db8, 0.7, 1) && distance2dsquared(self.origin, var_67335db8.origin) < 65536)
			{
				var_1a1cbe5a = 1;
			}
		}
		wait(1);
	}
	if(var_1a1cbe5a && isalive(self))
	{
		self thread zm_audio::create_and_play_dialog(#"hash_287f10fce8cd278b", #"react", undefined, 1);
	}
}

/*
	Name: function_3a4e98c1
	Namespace: namespace_b8f22955
	Checksum: 0xB751FF46
	Offset: 0x9308
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_3a4e98c1()
{
	self endon(#"death");
	wait(0.5);
	self clientfield::set("" + #"clock_zombie", 1);
	self zombie_utility::set_zombie_run_cycle("super_sprint");
}

/*
	Name: function_d409a74f
	Namespace: namespace_b8f22955
	Checksum: 0x29B48D25
	Offset: 0x9380
	Size: 0xADC
	Parameters: 1
	Flags: None
*/
function function_d409a74f(var_9e7c3935)
{
	level endon(#"end_game");
	self endon(#"death");
	self.mdl_body = util::spawn_model(#"c_t8_zmb_dlc1_catherine_ghost_body", self.origin, self.angles);
	self.mdl_head = util::spawn_model(#"c_t8_zmb_dlc1_catherine_ghost_head", self.mdl_body.origin, self.mdl_body.angles);
	self.mdl_body linkto(self);
	self.mdl_head linkto(self.mdl_body);
	self.mdl_body clientfield::set("" + #"ghost_trail", 1);
	self playsound(#"hash_4826261b01f96036");
	self playloopsound(#"hash_298631572be3dd79");
	/#
		self thread function_debf98ad();
	#/
	self.var_7988eee5 = self namespace_c05f06c7::get_closest_valid_player(22500);
	n_timer = 0;
	self thread function_7752a9e4();
	self thread function_d93fdc8f();
	self thread function_52980a22();
	self thread function_7c045e39();
	self.is_idle = 1;
	var_4fe0e488 = distance2dsquared(self.origin, var_9e7c3935.origin) / 4;
	do
	{
		wait(0.25);
		/#
			if(getdvarint(#"hash_512a591aa90d3f39", 0) && !self.is_idle)
			{
				setdvar(#"hash_73bbec0bc374eba6", 0);
				self.is_idle = 1;
				self scene::stop();
				self.mdl_body scene::stop();
				self thread scene::play(#"hash_1d324e9f967f0848", self.mdl_body);
				self.mdl_body thread scene::play(#"hash_1d324e9f967f0848", self.mdl_head);
				self moveto(self.origin, 0.05);
			}
		#/
		else
		{
			var_ec0bc953 = distance2dsquared(self.origin, var_9e7c3935.origin);
			if(var_ec0bc953 <= var_4fe0e488)
			{
				level notify(#"hash_5927e3d93a01cc61");
			}
			if(isdefined(self.var_7988eee5) && zm_utility::is_player_valid(self.var_7988eee5) && n_timer < 30)
			{
				v_player = self.var_7988eee5.origin + vectorscale((0, 0, 1), 8);
				n_dist = distance2dsquared(self.origin, v_player);
			}
			else
			{
				self.var_7988eee5 = self namespace_c05f06c7::get_closest_valid_player(22500);
			}
			/#
				if(isdefined(n_dist) && getdvarint(#"hash_73bbec0bc374eba6", 0))
				{
					if(self.is_idle)
					{
						setdvar(#"hash_512a591aa90d3f39", 0);
						self.is_idle = 0;
						self scene::stop();
						self.mdl_body scene::stop();
						self thread scene::play(#"hash_d278eff0ca38301", self.mdl_body);
						self.mdl_body thread scene::play(#"hash_d278eff0ca38301", self.mdl_head);
					}
					self moveto(v_player, 1.35);
					n_timer = 0;
				}
			#/
			else if(isdefined(n_dist) && n_dist > 101250)
			{
				self notify(#"hash_c4d9cf3f7bbbd3");
				/#
					if(getdvarint(#"hash_512a591aa90d3f39", 0))
					{
					}
				#/
				else if(!self.is_idle)
				{
					self.is_idle = 1;
					self scene::stop();
					self.mdl_body scene::stop();
					self thread scene::play(#"hash_1d324e9f967f0848", self.mdl_body);
					self.mdl_body thread scene::play(#"hash_1d324e9f967f0848", self.mdl_head);
				}
				self moveto(self.origin, 0.05);
				n_timer = n_timer + 0.25;
			}
			else if(isdefined(n_dist) && n_dist > 22500)
			{
				/#
					if(getdvarint(#"hash_512a591aa90d3f39", 0))
					{
					}
				#/
				else if(self.is_idle)
				{
					self.is_idle = 0;
					self scene::stop();
					self.mdl_body scene::stop();
					self thread scene::play(#"hash_d278eff0ca38301", self.mdl_body);
					self.mdl_body thread scene::play(#"hash_d278eff0ca38301", self.mdl_head);
				}
				self moveto(v_player, 1.35);
				n_timer = 0;
			}
			else
			{
				/#
				#/
				if(getdvarint(#"hash_512a591aa90d3f39", 0) || getdvarint(#"hash_73bbec0bc374eba6", 0))
				{
				}
				else if(!self.is_idle)
				{
					self.is_idle = 1;
					self scene::stop();
					self.mdl_body scene::stop();
					self thread scene::play(#"hash_1d324e9f967f0848", self.mdl_body);
					self.mdl_body thread scene::play(#"hash_1d324e9f967f0848", self.mdl_head);
					self moveto(self.origin, 0.05);
				}
				n_timer = 0;
			}
			n_dist = undefined;
		}
	}
	while(var_ec0bc953 > 40000);
	self scene::stop();
	self.mdl_body scene::stop();
	self notify(#"hash_26bafee97946f464");
	self function_679cf27a();
	self thread scene::play(#"hash_d278eff0ca38301", self.mdl_body);
	self.mdl_body thread scene::play(#"hash_d278eff0ca38301", self.mdl_head);
	self moveto(var_9e7c3935.origin, 2);
	self waittill(#"movedone");
	level flag::set("wisp_done");
	self playsound(#"hash_72a28324d62874cc");
	self.mdl_body clientfield::set("" + #"ghost_trail", 0);
	waitframe(3);
	self scene::stop();
	self.mdl_body scene::stop();
	self.mdl_head delete();
	self.mdl_body delete();
	self delete();
}

/*
	Name: function_7752a9e4
	Namespace: namespace_b8f22955
	Checksum: 0xEA81C313
	Offset: 0x9E68
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_7752a9e4()
{
	self endon(#"death");
	while(true)
	{
		wait(0.1);
		if(isdefined(self.var_7988eee5))
		{
			/#
				if(getdvarint(#"hash_512a591aa90d3f39", 0))
				{
					continue;
				}
			#/
			v_to_player = self.var_7988eee5.origin - self.origin;
			v_angles = vectortoangles(v_to_player);
			self rotateto(v_angles, 0.5);
			wait(0.45);
		}
	}
}

/*
	Name: function_d93fdc8f
	Namespace: namespace_b8f22955
	Checksum: 0x70D63C1E
	Offset: 0x9F40
	Size: 0x27C
	Parameters: 0
	Flags: Linked
*/
function function_d93fdc8f()
{
	level endon(#"end_game");
	self endon(#"death");
	wait(1);
	var_844489a = self namespace_c05f06c7::_print_player_out();
	if(isdefined(var_844489a))
	{
		n_player_index = var_844489a.n_index;
		switch(n_player_index)
		{
			case 10:
			{
				str_vo = #"hash_62e65f7a3e7cacc9";
				var_e009f4e5 = array("vox_ghost_react_first_plr_10_0", "vox_ghost_react_first_plr_10_1", "vox_ghost_react_first_plr_10_2");
				break;
			}
			case 12:
			{
				str_vo = #"hash_101b9b06c56b2b46";
				var_e009f4e5 = array("vox_ghost_react_first_plr_12_0", "vox_ghost_react_first_plr_12_1", "vox_ghost_react_first_plr_12_2");
				break;
			}
			case 11:
			{
				var_e009f4e5 = array("vox_ghost_react_first_plr_11_0", "vox_ghost_react_first_plr_11_1", "vox_ghost_react_first_plr_11_2");
				break;
			}
			case 9:
			{
				var_e009f4e5 = array("vox_ghost_react_first_plr_9_0", "vox_ghost_react_first_plr_9_1", "vox_ghost_react_first_plr_9_2");
				break;
			}
		}
		wait(1);
		self function_4e550169(str_vo);
		if(isdefined(var_844489a))
		{
			e_player = var_844489a.e_player;
			if(zm_utility::is_player_valid(e_player) && (!(isdefined(e_player.var_85028f37) && e_player.var_85028f37)))
			{
				e_player.var_85028f37 = 1;
				var_ffdda767 = array::random(var_e009f4e5);
				e_player thread zm_vo::function_8e0f4696(var_ffdda767, 0, 1, 9999);
			}
		}
	}
}

/*
	Name: function_679cf27a
	Namespace: namespace_b8f22955
	Checksum: 0xD335B821
	Offset: 0xA1C8
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_679cf27a()
{
	level endon(#"end_game");
	self endon(#"death");
	var_844489a = self namespace_c05f06c7::_print_player_out();
	if(isdefined(var_844489a))
	{
		n_player_index = var_844489a.n_index;
		switch(n_player_index)
		{
			case 10:
			{
				str_vo = #"hash_6505342b49042e55";
				break;
			}
			case 12:
			{
				str_vo = #"hash_2c5ec2eaeee4f872";
				break;
			}
			case 11:
			{
				str_vo = #"hash_44fc649c0f0931a4";
				break;
			}
			case 9:
			{
				str_vo = #"hash_7e25bb98b405333e";
				break;
			}
		}
		self function_4e550169(str_vo);
	}
}

/*
	Name: function_7c045e39
	Namespace: namespace_b8f22955
	Checksum: 0xA502DAB7
	Offset: 0xA318
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_7c045e39()
{
	level endon(#"end_game");
	self endon(#"death");
	level waittill(#"hash_5927e3d93a01cc61");
	var_844489a = self namespace_c05f06c7::_print_player_out();
	if(isdefined(var_844489a))
	{
		n_player_index = var_844489a.n_index;
		switch(n_player_index)
		{
			case 10:
			{
				str_vo = #"hash_7a53f00b3db3948c";
				break;
			}
			case 12:
			{
				str_vo = #"hash_ddb7909d2ce74f";
				break;
			}
			case 11:
			{
				str_vo = #"hash_73dc7ef0878732f9";
				break;
			}
			case 9:
			{
				str_vo = #"hash_4fd1088b74edb13b";
				break;
			}
		}
		self function_4e550169(str_vo);
	}
}

/*
	Name: function_52980a22
	Namespace: namespace_b8f22955
	Checksum: 0xB1E8B7D6
	Offset: 0xA480
	Size: 0x176
	Parameters: 0
	Flags: Linked
*/
function function_52980a22()
{
	level endon(#"end_game");
	self endon(#"death", #"hash_26bafee97946f464");
	while(true)
	{
		self waittill(#"hash_c4d9cf3f7bbbd3");
		var_844489a = self namespace_c05f06c7::_print_player_out();
		if(isdefined(var_844489a))
		{
			n_player_index = var_844489a.n_index;
			switch(n_player_index)
			{
				case 10:
				{
					str_vo = #"hash_5c43fbd9392b21ed";
					break;
				}
				case 12:
				{
					str_vo = #"hash_5319dbc7382d7dca";
					break;
				}
				case 11:
				{
					str_vo = #"hash_6794b805afc7acbc";
					break;
				}
				case 9:
				{
					str_vo = #"hash_c1ae5ad9afc2796";
					break;
				}
			}
			self function_4e550169(str_vo);
			wait(10);
		}
	}
}

/*
	Name: function_4e550169
	Namespace: namespace_b8f22955
	Checksum: 0xFCABD556
	Offset: 0xA600
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_4e550169(str_vo)
{
	self notify(#"hash_3fe13c25845b3eb1");
	level endon(#"end_game");
	self endon_callback(&function_c05430c5, #"hash_3fe13c25845b3eb1");
	self endon(#"death");
	self.mdl_head zm_vo::function_8e0f4696(str_vo, 0, 1, 9999);
}

/*
	Name: function_c05430c5
	Namespace: namespace_b8f22955
	Checksum: 0x641D3521
	Offset: 0xA698
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_c05430c5(var_5a5260d8)
{
	if(isdefined(self))
	{
		self zm_vo::function_57b8cd17();
	}
}

/*
	Name: function_450b01a5
	Namespace: namespace_b8f22955
	Checksum: 0xC5D72E59
	Offset: 0xA6D0
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_450b01a5()
{
	/#
		self thread function_debf98ad();
	#/
	s_result = undefined;
	s_result = self waittill(#"trigger");
	/#
		self thread function_af24d641();
	#/
	level flag::set(self.stub.str_flag);
	s_result.activator thread zm_audio::create_and_play_dialog(#"painting", #"hash_508ab5d518ddf87e");
	zm_unitrigger::unregister_unitrigger(self.stub);
}

/*
	Name: function_c9c7a593
	Namespace: namespace_b8f22955
	Checksum: 0xD59266E2
	Offset: 0xA7B0
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function function_c9c7a593()
{
	self notify(#"hash_6edff0409a51550e");
	self endon(#"death", #"hash_6edff0409a51550e");
	while(true)
	{
		a_ai_zombies = getaiteamarray(#"axis");
		foreach(ai_zombie in a_ai_zombies)
		{
			if(!isalive(ai_zombie) || !isdefined(ai_zombie.archetype))
			{
				continue;
			}
			if(distance2dsquared(self.origin, ai_zombie.origin) < 1600 && !isdefined(ai_zombie.var_3f5addd0))
			{
				if(ai_zombie.archetype == #"zombie" || ai_zombie.archetype == #"nosferatu" || ai_zombie.archetype == #"zombie_dog")
				{
					ai_zombie clientfield::set("" + #"hash_1d0080ad80fd0913", 1);
					ai_zombie.var_3f5addd0 = 1;
					ai_zombie thread function_d480d1a3();
				}
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_d480d1a3
	Namespace: namespace_b8f22955
	Checksum: 0x81799EB5
	Offset: 0xA9B8
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function function_d480d1a3()
{
	self endon(#"death");
	n_damage = (int(self.health / 4)) + 1;
	n_count = 0;
	if(n_damage >= 250)
	{
		n_damage = 250;
	}
	while(n_count < 4)
	{
		self dodamage(n_damage, self.origin);
		n_count++;
		wait(0.5);
	}
	self clientfield::set("" + #"hash_1d0080ad80fd0913", 0);
	self.var_3f5addd0 = undefined;
	if(isalive(self))
	{
		self dodamage(self.health + 666, self.origin);
	}
	level notify(#"hash_597743410e6561dd");
}

/*
	Name: show_trail
	Namespace: namespace_b8f22955
	Checksum: 0xD9EC4D3C
	Offset: 0xAB00
	Size: 0x53C
	Parameters: 2
	Flags: Linked
*/
function show_trail(nd_start, var_ff4b3a13)
{
	self setmodel(#"c_t8_zmb_dlc1_catherine_ghost_body");
	if(!isdefined(self.mdl_head))
	{
		self.mdl_head = util::spawn_model(#"c_t8_zmb_dlc1_catherine_ghost_head", self.origin, self.angles);
	}
	self.mdl_head linkto(self);
	self util::delay(0.1, #"death", &clientfield::set, "" + #"ghost_trail", 1);
	self.var_c176969a = spawner::simple_spawn_single(getent("veh_power_on_projectile", "targetname"));
	while(!isdefined(self.var_c176969a))
	{
		waitframe(1);
	}
	var_c176969a = self.var_c176969a;
	self.var_c176969a.team = #"allies";
	self.var_c176969a.var_6353e3f1 = 1;
	self.var_c176969a setspeed(7);
	if(isdefined(var_ff4b3a13))
	{
		if(!isdefined(nd_start.var_7eedec61))
		{
			nd_start.var_7eedec61 = 1;
		}
		n_scale = nd_start.var_7eedec61;
		self.var_c176969a setspeedimmediate(4);
		self thread function_24bd273(n_scale);
		self.mdl_head thread function_24bd273(n_scale);
	}
	self.var_c176969a.origin = nd_start.origin;
	self.var_c176969a.angles = nd_start.angles;
	/#
		self.var_c176969a thread function_75e87a52(nd_start);
	#/
	/#
		self.var_c176969a thread function_debf98ad();
	#/
	self linkto(self.var_c176969a);
	var_878f0f0a = getallvehiclenodes();
	self thread function_f0b97bc7();
	if(nd_start.targetname === "monkey_loc_trail_start_node")
	{
		var_a797e723 = 0;
	}
	else
	{
		var_a797e723 = 1;
	}
	self thread function_900b7dca(var_878f0f0a, undefined, undefined, var_a797e723);
	self.var_c176969a vehicle::get_on_and_go_path(nd_start);
	var_36e0efc5 = getvehiclenodearray(nd_start.targetname + "_split", "targetname");
	var_2cee3bd = array::random(var_36e0efc5);
	/#
		if(isdefined(level.var_3952757f))
		{
			var_2cee3bd = level.var_3952757f;
			level.var_3952757f = undefined;
		}
		else if(isdefined(level.var_584c4114))
		{
			var_2cee3bd = level.var_584c4114;
			level.var_584c4114 = undefined;
		}
	#/
	/#
		self.var_c176969a thread function_75e87a52(nd_start, (1, 0, 0));
	#/
	/#
		self.var_c176969a thread function_75e87a52(var_2cee3bd);
	#/
	level notify(#"hash_74beea7c4720cdb9");
	self thread function_900b7dca(var_878f0f0a);
	self.var_c176969a vehicle::get_on_and_go_path(var_2cee3bd);
	self.s_portal = arraygetclosest(self.origin, struct::get_array(nd_start.targetname + "_end"));
	level notify(#"hash_10580fbe74622186");
	self.var_c176969a scene::stop();
	self scene::stop();
	level thread function_1ae44836(self.var_c176969a);
}

/*
	Name: function_1ae44836
	Namespace: namespace_b8f22955
	Checksum: 0xF73AC5C5
	Offset: 0xB048
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_1ae44836(var_c176969a)
{
	while(isdefined(var_c176969a) && (isdefined(var_c176969a.isspeaking) && var_c176969a.isspeaking))
	{
		waitframe(1);
	}
	if(isdefined(var_c176969a))
	{
		var_c176969a delete();
	}
}

/*
	Name: function_24bd273
	Namespace: namespace_b8f22955
	Checksum: 0xE55592B1
	Offset: 0xB0B0
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_24bd273(n_scale)
{
	self setscale(n_scale);
	while(isdefined(self) && n_scale < 1)
	{
		waitframe(1);
		n_scale = n_scale + 0.01;
		if(n_scale > 1)
		{
			n_scale = 1;
		}
		self setscale(n_scale);
	}
}

/*
	Name: function_900b7dca
	Namespace: namespace_b8f22955
	Checksum: 0x12F88B2A
	Offset: 0xB148
	Size: 0x3C0
	Parameters: 4
	Flags: Linked
*/
function function_900b7dca(var_878f0f0a, var_5a365909 = 0, e_player, var_a797e723 = 0)
{
	self endon(#"death");
	self.var_c176969a endon(#"reached_end_node");
	self.var_9c715b4f = 0;
	self.var_aa273e8b = 0;
	while(true)
	{
		if(math::cointoss())
		{
			var_8423ab7b = #"hash_d278eff0ca38301";
		}
		else
		{
			var_8423ab7b = #"hash_d278bff0ca37de8";
		}
		self.var_c176969a thread scene::play(var_8423ab7b, self);
		self thread scene::play(var_8423ab7b, self.mdl_head);
		if(!var_a797e723)
		{
			self.var_c176969a setspeed(7);
		}
		/#
			var_1a03dcc0 = getdvarint(#"hash_68d0383bc6472cad", 7);
			if(var_1a03dcc0 > 7)
			{
				self.var_c176969a setspeed(var_1a03dcc0);
			}
		#/
		self.var_c176969a waittill(#"reached_node");
		self.var_aa273e8b++;
		self.var_c176969a scene::stop();
		self scene::stop();
		self.var_c176969a thread scene::play(#"hash_1d324e9f967f0848", self);
		self thread scene::play(#"hash_1d324e9f967f0848", self.mdl_head);
		if(!var_a797e723)
		{
			self.var_c176969a setspeed(0);
		}
		var_a797e723 = 0;
		var_49e93815 = arraygetclosest(self.origin, var_878f0f0a);
		if(!self.var_9c715b4f)
		{
			self.var_9c715b4f = 1;
			function_1da9c778(var_49e93815);
		}
		if(self.var_aa273e8b >= (self.var_f2831f45 / 2))
		{
			level notify(#"hash_10a51d6f30d3daf8");
		}
		if(self.var_aa273e8b >= (self.var_f2831f45 - 1))
		{
			level notify(#"hash_73c2d56d8912635b");
			self.var_c176969a notify(#"hash_73c2d56d8912635b");
		}
		if(isdefined(var_49e93815) && isdefined(var_49e93815.radius))
		{
			self.n_radius = var_49e93815.radius;
		}
		if(!var_a797e723)
		{
			self namespace_c05f06c7::waittill_player_nearby(e_player, var_5a365909);
		}
		self.var_c176969a scene::stop();
		self scene::stop();
	}
	level notify(#"hash_7099ee9e4c813f08");
}

/*
	Name: function_1da9c778
	Namespace: namespace_b8f22955
	Checksum: 0xAB9D7A90
	Offset: 0xB510
	Size: 0x17E
	Parameters: 1
	Flags: Linked
*/
function function_1da9c778(nd_start)
{
	self endon(#"death");
	self.var_f2831f45 = 1;
	current_node = nd_start;
	do
	{
		if(isdefined(current_node.target))
		{
			s_current = struct::get(current_node.target, "targetname");
			e_current = getent(current_node.target, "targetname");
			nd_current = getnode(current_node.target, "targetname");
			var_cf04fc05 = getvehiclenode(current_node.target, "targetname");
			if(isdefined(s_current))
			{
				current_node = s_current;
			}
			else if(isdefined(e_current))
			{
				current_node = e_current;
			}
			else if(isdefined(nd_current))
			{
				current_node = nd_current;
			}
			else if(isdefined(var_cf04fc05))
			{
				current_node = var_cf04fc05;
			}
			if(isdefined(current_node))
			{
				self.var_f2831f45++;
			}
		}
		else
		{
			current_node = undefined;
		}
	}
	while(isdefined(current_node));
}

/*
	Name: function_f0b97bc7
	Namespace: namespace_b8f22955
	Checksum: 0x526926E4
	Offset: 0xB698
	Size: 0x414
	Parameters: 0
	Flags: Linked
*/
function function_f0b97bc7()
{
	level endon(#"end_game");
	self endon(#"death");
	if(isalive(self.var_8f2e6110))
	{
		e_player = self.var_8f2e6110;
	}
	else
	{
		e_player = self namespace_c05f06c7::get_closest_valid_player();
	}
	if(isalive(e_player))
	{
		n_player_index = e_player zm_characters::function_d35e4c92();
		switch(n_player_index)
		{
			case 10:
			{
				str_vo = array::random(array(#"hash_3aa5abb95e6135dc", #"hash_3aa5acb95e61378f"));
				var_db5bdee0 = array::random(array(#"vox_ghost_react_first_plr_10_0", #"vox_ghost_react_first_plr_10_1", #"vox_ghost_react_first_plr_10_2"));
				break;
			}
			case 12:
			{
				str_vo = array::random(array(#"hash_71daabc266664b7f", #"hash_71daaac2666649cc"));
				var_db5bdee0 = array::random(array(#"vox_ghost_react_first_plr_12_0", #"vox_ghost_react_first_plr_12_1", #"vox_ghost_react_first_plr_12_2"));
				break;
			}
			case 11:
			{
				str_vo = array::random(array(#"hash_5935358e81a47829", #"hash_5935348e81a47676"));
				var_db5bdee0 = array::random(array(#"vox_ghost_react_first_plr_11_0", #"vox_ghost_react_first_plr_11_1", #"vox_ghost_react_first_plr_11_2"));
				break;
			}
			case 9:
			{
				str_vo = #"hash_67b26c79bbe5bbcb";
				var_db5bdee0 = array::random(array(#"vox_ghost_react_first_plr_9_0", #"vox_ghost_react_first_plr_9_1", #"vox_ghost_react_first_plr_9_2"));
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
		if(isdefined(str_vo))
		{
			self function_4e550169(str_vo);
			e_player zm_vo::function_8e0f4696(var_db5bdee0, 0, 1, 9999);
		}
	}
	self thread function_b5697137();
	self thread function_9874e47();
}

/*
	Name: function_b5697137
	Namespace: namespace_b8f22955
	Checksum: 0x7287D66A
	Offset: 0xBAB8
	Size: 0x2AC
	Parameters: 0
	Flags: Linked
*/
function function_b5697137()
{
	level endon(#"end_game");
	self endon(#"death");
	level waittill(#"hash_74beea7c4720cdb9");
	var_844489a = self namespace_c05f06c7::_print_player_out();
	if(isdefined(var_844489a))
	{
		n_player_index = var_844489a.n_index;
		switch(n_player_index)
		{
			case 10:
			{
				str_vo = array::random(array(#"hash_4855af835de9357d", #"hash_4855ae835de933ca"));
				break;
			}
			case 12:
			{
				str_vo = array::random(array(#"hash_65e2fba5d5b1bfa", #"hash_65e30ba5d5b1dad"));
				break;
			}
			case 11:
			{
				str_vo = array::random(array(#"hash_b54330fb35d21ec", #"hash_b54340fb35d239f"));
				break;
			}
			case 9:
			{
				str_vo = array::random(array(#"hash_799148d514ef2fa6", #"hash_799149d514ef3159"));
				break;
			}
		}
		self function_4e550169(str_vo);
		var_c176969a = self.var_c176969a;
		if(!isvehicle(var_c176969a))
		{
			return;
		}
		var_c176969a waittill(#"hash_73c2d56d8912635b", #"reached_end_node", #"death");
		if(isvehicle(var_c176969a))
		{
			var_c176969a function_58cb08ba();
		}
	}
}

/*
	Name: function_9874e47
	Namespace: namespace_b8f22955
	Checksum: 0xDE74B1CF
	Offset: 0xBD70
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function function_9874e47()
{
	level endon(#"end_game");
	self endon(#"death", #"hash_10580fbe74622186");
	level waittill(#"hash_5ed8f262549ea460");
	var_844489a = self namespace_c05f06c7::_print_player_out();
	if(isdefined(var_844489a))
	{
		n_player_index = var_844489a.n_index;
		switch(n_player_index)
		{
			case 10:
			{
				str_vo = array::random(array(#"hash_2ee930d95b672ff6", #"hash_2ee931d95b6731a9"));
				break;
			}
			case 12:
			{
				str_vo = array::random(array(#"hash_617b0aa1eea5171", #"hash_617afaa1eea4fbe"));
				break;
			}
			case 11:
			{
				str_vo = array::random(array(#"hash_4fe1018f779a685b", #"hash_4fe1008f779a66a8"));
				break;
			}
			case 9:
			{
				str_vo = #"hash_36e6966b62980731";
				break;
			}
		}
		self function_4e550169(str_vo);
	}
}

/*
	Name: function_58cb08ba
	Namespace: namespace_b8f22955
	Checksum: 0x70BE2DBC
	Offset: 0xBF78
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function function_58cb08ba()
{
	level endon(#"end_game");
	self endon(#"death");
	var_844489a = self namespace_c05f06c7::_print_player_out();
	if(isdefined(var_844489a))
	{
		n_player_index = var_844489a.n_index;
		switch(n_player_index)
		{
			case 10:
			{
				str_vo = array::random(array(#"hash_1d2198f4ef4a92ae", #"hash_1d2199f4ef4a9461"));
				break;
			}
			case 12:
			{
				str_vo = array::random(array(#"hash_1017561af340ea09", #"hash_1017551af340e856"));
				break;
			}
			case 11:
			{
				str_vo = array::random(array(#"hash_2594dbbe4ec9cc33", #"hash_2594dabe4ec9ca80"));
				break;
			}
			case 9:
			{
				str_vo = array::random(array(#"hash_24a7392ff4c6ca9", #"hash_24a7292ff4c6af6"));
				break;
			}
		}
		self zm_vo::function_8e0f4696(str_vo, 0, 1, 9999);
	}
}

/*
	Name: function_74d1be5d
	Namespace: namespace_b8f22955
	Checksum: 0x509E2FFF
	Offset: 0xC190
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_74d1be5d(player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_ec89d606b637daf", #"hash_469be9d3e689cf8d");
	self sethintstringforplayer(player, str_prompt);
	return 1;
}

/*
	Name: function_5c8eab18
	Namespace: namespace_b8f22955
	Checksum: 0xB2323EE7
	Offset: 0xC200
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_5c8eab18(player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_33e7f205d1a4abdb", #"hash_3b18f50168dff251");
	self sethintstringforplayer(player, str_prompt);
	return 1;
}

/*
	Name: function_7c097281
	Namespace: namespace_b8f22955
	Checksum: 0x52581AD1
	Offset: 0xC270
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_7c097281(player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_c959420bf77c557", #"hash_17fa44f503d31a85");
	self sethintstringforplayer(player, str_prompt);
	return 1;
}

/*
	Name: function_5af2281f
	Namespace: namespace_b8f22955
	Checksum: 0x5BC0D573
	Offset: 0xC2E0
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function function_5af2281f(player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_1cfe0fa2955e2979", #"hash_5538019ad6e6cdc7");
	self sethintstringforplayer(player, str_prompt);
	return 1;
}

/*
	Name: function_4135e83e
	Namespace: namespace_b8f22955
	Checksum: 0x3B6A3CE1
	Offset: 0xC350
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_4135e83e()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(player zm_utility::in_revive_trigger())
		{
			continue;
		}
		if(player zm_utility::is_drinking())
		{
			continue;
		}
		if(isdefined(player.var_564dec14) && player.var_564dec14)
		{
			continue;
		}
		if(!zm_utility::is_player_valid(player))
		{
			continue;
		}
		level flag::set(self.stub.str_flag);
		self.var_8f2e6110 = player;
		zm_unitrigger::unregister_unitrigger(self.stub);
	}
}

/*
	Name: function_d29a3f81
	Namespace: namespace_b8f22955
	Checksum: 0x8CF677AB
	Offset: 0xC460
	Size: 0x2B0
	Parameters: 0
	Flags: Linked
*/
function function_d29a3f81()
{
	while(true)
	{
		/#
			self thread function_debf98ad();
		#/
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		/#
			self thread function_af24d641();
		#/
		player = waitresult.activator;
		if(player zm_utility::in_revive_trigger())
		{
			continue;
		}
		if(player zm_utility::is_drinking())
		{
			continue;
		}
		if(isdefined(player.var_564dec14) && player.var_564dec14)
		{
			continue;
		}
		if(!zm_utility::is_player_valid(player))
		{
			continue;
		}
		if(!level flag::get(self.stub.str_flag))
		{
			level thread function_3088c773(self.stub.str_flag);
			level thread function_d48fb847(self.stub, self.stub.str_flag, self.stub.vol_defend, player);
			level thread function_a1d7d92b(self.stub.vol_defend, self.stub.str_flag, "clock_defend");
			level thread function_4dfd5cf6(self.stub.vol_defend.targetname, self.stub.str_flag, self.stub.vol_defend, self.stub.str_flag, "clock_defend");
			level thread function_e8355769(self.stub.vol_defend, self.stub.str_flag);
			level thread function_b7c114a2(player);
			level thread function_418873a4(self.stub.vol_defend);
			zm_unitrigger::unregister_unitrigger(self.stub);
		}
	}
}

/*
	Name: function_e8355769
	Namespace: namespace_b8f22955
	Checksum: 0xCC75012C
	Offset: 0xC718
	Size: 0x1DE
	Parameters: 2
	Flags: Linked
*/
function function_e8355769(vol_defend, str_flag)
{
	level endon(#"end_game");
	wait(3);
	var_ef6d594a = namespace_c05f06c7::function_91dfc9d4(vol_defend);
	while(!level flag::get(str_flag))
	{
		var_840c2f31 = namespace_c05f06c7::function_91dfc9d4(vol_defend);
		foreach(var_b930e62d in array::remove_undefined(var_ef6d594a))
		{
			if(!isinarray(var_840c2f31, var_b930e62d))
			{
				var_b930e62d.var_e6abb74b = 1;
			}
		}
		wait(1);
	}
	foreach(var_5e81c7ad in array::remove_undefined(var_ef6d594a))
	{
		if(!(isdefined(var_5e81c7ad.var_e6abb74b) && var_5e81c7ad.var_e6abb74b))
		{
			var_5e81c7ad notify(#"hash_305ca852d958a7e1");
		}
		var_5e81c7ad.var_e6abb74b = undefined;
	}
}

/*
	Name: function_4a648207
	Namespace: namespace_b8f22955
	Checksum: 0xC43D95E9
	Offset: 0xC900
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_4a648207()
{
	var_8c877776 = getent("c_hook_floor", "targetname");
	var_3c51b3a1 = getent("c_horseshoe_floor", "targetname");
	registerambush_enemy = getent("c_star_floor", "targetname");
	var_8c877776 notsolid();
	var_3c51b3a1 notsolid();
	registerambush_enemy notsolid();
}

/*
	Name: function_4dfd5cf6
	Namespace: namespace_b8f22955
	Checksum: 0xB0886222
	Offset: 0xC9D0
	Size: 0x2B4
	Parameters: 5
	Flags: Linked
*/
function function_4dfd5cf6(str_vol, str_flag, vol_defend, var_39cddd2a, var_854f3b02)
{
	switch(str_vol)
	{
		case "vol_clock_hook":
		{
			var_b66d1b0d = getent("c_hook_floor", "targetname");
			var_46c6a12e = getent("c_horseshoe_floor", "targetname");
			var_dab99f17 = getent("c_star_floor", "targetname");
			if(isdefined(var_46c6a12e))
			{
				var_46c6a12e delete();
			}
			if(isdefined(var_dab99f17))
			{
				var_dab99f17 delete();
			}
			break;
		}
		case "vol_clock_horseshoe":
		{
			var_b66d1b0d = getent("c_horseshoe_floor", "targetname");
			var_91721e52 = getent("c_hook_floor", "targetname");
			var_dab99f17 = getent("c_star_floor", "targetname");
			if(isdefined(var_91721e52))
			{
				var_91721e52 delete();
			}
			if(isdefined(var_dab99f17))
			{
				var_dab99f17 delete();
			}
			break;
		}
		case "vol_clock_star":
		{
			var_b66d1b0d = getent("c_star_floor", "targetname");
			var_46c6a12e = getent("c_horseshoe_floor", "targetname");
			var_91721e52 = getent("c_hook_floor", "targetname");
			if(isdefined(var_46c6a12e))
			{
				var_46c6a12e delete();
			}
			if(isdefined(var_91721e52))
			{
				var_91721e52 delete();
			}
			break;
		}
	}
	var_b66d1b0d thread function_51573c45(var_39cddd2a, var_854f3b02);
	var_b66d1b0d thread function_1a82ca71(str_flag);
}

/*
	Name: function_51573c45
	Namespace: namespace_b8f22955
	Checksum: 0x775C5CE9
	Offset: 0xCC90
	Size: 0xD8
	Parameters: 2
	Flags: Linked
*/
function function_51573c45(var_39cddd2a, var_854f3b02)
{
	level endon(#"end_game", var_39cddd2a);
	self endon(#"death");
	while(true)
	{
		level flag::wait_till(var_854f3b02);
		self clientfield::set("" + #"hash_47b8db8cde2c4291", 13);
		level flag::wait_till_clear(var_854f3b02);
		self clientfield::set("" + #"hash_47b8db8cde2c4291", 0);
	}
}

/*
	Name: function_1a82ca71
	Namespace: namespace_b8f22955
	Checksum: 0xE69A95FB
	Offset: 0xCD70
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_1a82ca71(str_flag, b_delete = 1)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self clientfield::set("" + #"hash_47b8db8cde2c4291", 13);
	for(n_count = 1; n_count < 13; n_count++)
	{
		level waittill(#"hash_5a23f461b8ae05a4");
		self clientfield::set("" + #"hash_47b8db8cde2c4291", n_count);
	}
	wait(1.25);
	/#
		self notify(#"hash_7220ecdbd444567a");
	#/
	wait(2.5);
	if(b_delete)
	{
		self delete();
	}
}

/*
	Name: function_3088c773
	Namespace: namespace_b8f22955
	Checksum: 0x49230996
	Offset: 0xCE90
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_3088c773(str_flag)
{
	n_time = 40;
	var_a780e211 = 0;
	while(n_time > 0)
	{
		if(var_a780e211 >= 3.2)
		{
			level notify(#"hash_5a23f461b8ae05a4");
			var_a780e211 = 0;
		}
		wait(0.05);
		n_time = n_time - 0.05;
		var_a780e211 = var_a780e211 + 0.05;
		if(!level flag::get("clock_defend"))
		{
			level flag::wait_till("clock_defend");
		}
	}
	level flag::set(str_flag);
}

/*
	Name: function_d48fb847
	Namespace: namespace_b8f22955
	Checksum: 0xC57AEDFD
	Offset: 0xCF88
	Size: 0x3E8
	Parameters: 4
	Flags: Linked
*/
function function_d48fb847(var_ffba68db, str_flag, e_volume, e_player)
{
	level.var_e4628267 = 0;
	if(getplayers().size > 2)
	{
		n_max_zombies = 9;
		var_4e06036b = 2;
		var_d18f896 = 4;
	}
	else if(getplayers().size > 1)
	{
		n_max_zombies = 6;
		var_4e06036b = 4;
		var_d18f896 = 8;
	}
	else
	{
		n_max_zombies = 3;
		var_4e06036b = 5;
		var_d18f896 = 10;
	}
	var_f1c4ec4f = e_player zm_utility::get_current_zone(1);
	var_2815c876 = var_f1c4ec4f.a_loc_types[#"zombie_location"];
	var_6aea2f76 = [];
	a_adjacent_zones = getarraykeys(var_f1c4ec4f.adjacent_zones);
	for(i = 0; i < a_adjacent_zones.size; i++)
	{
		if(var_f1c4ec4f.adjacent_zones[a_adjacent_zones[i]].is_connected)
		{
			var_c714ccfe = level.zones[a_adjacent_zones[i]];
			var_9387e4ab = var_c714ccfe.a_loc_types[#"zombie_location"];
			foreach(s_spawner in var_9387e4ab)
			{
				if(distancesquared(s_spawner.origin, var_ffba68db.s_clock.origin) < 1000 * 1000)
				{
					if(!isdefined(var_6aea2f76))
					{
						var_6aea2f76 = [];
					}
					else if(!isarray(var_6aea2f76))
					{
						var_6aea2f76 = array(var_6aea2f76);
					}
					var_6aea2f76[var_6aea2f76.size] = s_spawner;
				}
			}
		}
	}
	var_a1e469f3 = arraycombine(var_2815c876, var_6aea2f76, 0, 0);
	s_pos = array::random(var_a1e469f3);
	var_ad728f = undefined;
	while(!level flag::get(str_flag))
	{
		level flag::wait_till("clock_defend");
		while(level.var_e4628267 > n_max_zombies)
		{
			waitframe(1);
		}
		while(var_ad728f === s_pos)
		{
			s_pos = array::random(var_a1e469f3);
			waitframe(1);
		}
		var_ad728f = s_pos;
		level thread clock_zombie_spawn(s_pos, str_flag, e_volume);
		wait(randomfloatrange(var_4e06036b, var_d18f896));
	}
}

/*
	Name: function_a1d7d92b
	Namespace: namespace_b8f22955
	Checksum: 0x6582196E
	Offset: 0xD378
	Size: 0xFC
	Parameters: 3
	Flags: Linked
*/
function function_a1d7d92b(vol_defend, var_39cddd2a, var_854f3b02)
{
	while(!level flag::get(var_39cddd2a))
	{
		if(var_854f3b02 == "clock_defend")
		{
			array::thread_all(namespace_c05f06c7::function_91dfc9d4(vol_defend), &function_4387bfae, vol_defend, var_39cddd2a);
		}
		if(namespace_c05f06c7::function_98ca58fc(vol_defend))
		{
			level flag::set(var_854f3b02);
		}
		else
		{
			level flag::clear(var_854f3b02);
		}
		wait(1);
	}
	wait(5);
	if(isdefined(vol_defend))
	{
		vol_defend delete();
	}
}

/*
	Name: function_4387bfae
	Namespace: namespace_b8f22955
	Checksum: 0x173B612E
	Offset: 0xD480
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function function_4387bfae(vol_defend, var_39cddd2a)
{
	self notify(#"hash_3f1155789e552158");
	self endon(#"disconnect", #"hash_3f1155789e552158");
	self clientfield::set("" + #"hash_49de76d6c4f95e5d", 1);
	while(isplayer(self) && self istouching(vol_defend) && !self laststand::player_is_in_laststand() && !level flag::get(var_39cddd2a))
	{
		waitframe(1);
	}
	if(isplayer(self))
	{
		self clientfield::set("" + #"hash_49de76d6c4f95e5d", 0);
	}
}

/*
	Name: clock_zombie_spawn
	Namespace: namespace_b8f22955
	Checksum: 0xE6B9357D
	Offset: 0xD5C0
	Size: 0x2EC
	Parameters: 3
	Flags: Linked
*/
function clock_zombie_spawn(s_pos, str_flag, e_volume)
{
	if(!isdefined(s_pos))
	{
		return;
	}
	ai_zombie = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0], "" + #"clock_zombie", s_pos, level.round_number);
	if(isalive(ai_zombie))
	{
		ai_zombie endon(#"death");
		level.var_e4628267++;
		ai_zombie.script_string = "find_flesh";
		ai_zombie thread function_1a3604f4(e_volume);
		ai_zombie.var_126d7bef = 1;
		ai_zombie.ignore_round_spawn_failsafe = 1;
		ai_zombie.ignore_enemy_count = 1;
		ai_zombie.b_ignore_cleanup = 1;
		ai_zombie thread function_c2c920c3();
		ai_zombie zm_score::function_acaab828();
		ai_zombie thread function_1f3845a9();
		wait(0.5);
		ai_zombie util::delay(1, "death", &clientfield::set, "" + #"clock_zombie", 1);
		if(isdefined(level.is_forever_solo_game) && level.is_forever_solo_game)
		{
			ai_zombie zombie_utility::set_zombie_run_cycle("sprint");
		}
		else
		{
			ai_zombie zombie_utility::set_zombie_run_cycle("super_sprint");
		}
		level flag::wait_till(str_flag);
		gibserverutils::gibhead(ai_zombie);
		if(math::cointoss())
		{
			gibserverutils::gibleftarm(ai_zombie);
		}
		else
		{
			gibserverutils::gibrightarm(ai_zombie);
		}
		gibserverutils::gibleftleg(ai_zombie);
		gibserverutils::gibrightleg(ai_zombie);
		ai_zombie dodamage(ai_zombie.health, ai_zombie.origin);
	}
}

/*
	Name: function_c2c920c3
	Namespace: namespace_b8f22955
	Checksum: 0x36989ED9
	Offset: 0xD8B8
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_c2c920c3()
{
	self endon(#"death");
	self waittill(#"completed_emerging_into_playable_area");
	self.no_powerups = 1;
}

/*
	Name: function_1a3604f4
	Namespace: namespace_b8f22955
	Checksum: 0x13DA04DF
	Offset: 0xD8F8
	Size: 0x10A
	Parameters: 1
	Flags: Linked
*/
function function_1a3604f4(e_volume)
{
	self endon(#"death");
	a_players = array::randomize(util::get_active_players());
	foreach(player in a_players)
	{
		if(player istouching(e_volume))
		{
			self.favoriteenemy = player;
			return;
		}
	}
	e_player = arraygetclosest(e_volume.origin, a_players);
	self.favoriteenemy = e_player;
}

/*
	Name: function_1f3845a9
	Namespace: namespace_b8f22955
	Checksum: 0xA703BEF0
	Offset: 0xDA10
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function function_1f3845a9()
{
	self waittill(#"death");
	level.var_e4628267--;
}

/*
	Name: function_418873a4
	Namespace: namespace_b8f22955
	Checksum: 0x6394063E
	Offset: 0xDA40
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_418873a4(var_eb6e62b5)
{
	var_eb6e62b5 playsound(#"hash_26a50e69d0c10a3c");
	for(n_count = 1; n_count < 13; n_count++)
	{
		level waittill(#"hash_5a23f461b8ae05a4");
		switch(n_count)
		{
			case 3:
			{
				var_eb6e62b5 playsound(#"hash_1a58bf8555bdbb23");
				break;
			}
			case 6:
			{
				var_eb6e62b5 playsound(#"hash_1a58bf8555bdbb23");
				break;
			}
			case 9:
			{
				var_eb6e62b5 playsound(#"hash_1a58bf8555bdbb23");
				break;
			}
		}
	}
	var_eb6e62b5 playsound(#"hash_2fb1c47e5864ae0f");
}

/*
	Name: function_b7c114a2
	Namespace: namespace_b8f22955
	Checksum: 0x982C88C1
	Offset: 0xDB88
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b7c114a2(e_player)
{
	e_player endon(#"death");
	wait(1);
	if(isalive(e_player))
	{
		e_player zm_audio::create_and_play_dialog(#"clock", #"hash_508ab5d518ddf87e", undefined, 1);
	}
}

/*
	Name: function_152fe2a0
	Namespace: namespace_b8f22955
	Checksum: 0x1B14D671
	Offset: 0xDC10
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_152fe2a0()
{
	self endon(#"death");
	self waittill(#"trigger");
	level flag::set(self.stub.str_flag);
	self delete();
}

/*
	Name: function_224d642
	Namespace: namespace_b8f22955
	Checksum: 0x1D99F6D4
	Offset: 0xDC80
	Size: 0x180
	Parameters: 1
	Flags: Linked
*/
function function_224d642(var_e62bb9d2)
{
	self endon(#"death");
	self show();
	if(!isdefined(self.fx_org))
	{
		self.fx_org = util::spawn_model(#"tag_origin", self.origin, self.angles);
	}
	switch(var_e62bb9d2.model)
	{
		case "hash_75789bca38aa1419":
		{
			n_value = 1;
			break;
		}
		case "hash_7e08d4df1f3ead6":
		{
			n_value = 2;
			break;
		}
		default:
		{
			n_value = 3;
		}
	}
	self.fx_org clientfield::set("" + #"hash_51257ec597a8f84f", n_value);
	self playsound(#"hash_5c1e3168236012f9" + n_value);
	while(true)
	{
		self rotateyaw(180, 3);
		wait(2.95);
	}
}

/*
	Name: trigger_think
	Namespace: namespace_b8f22955
	Checksum: 0x2C50736E
	Offset: 0xDE08
	Size: 0x408
	Parameters: 0
	Flags: Linked
*/
function trigger_think()
{
	while(true)
	{
		/#
			self thread function_debf98ad();
		#/
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		/#
			self function_af24d641();
		#/
		player = waitresult.activator;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		player thread zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
		switch(self.stub.var_db9b80c9)
		{
			case "main_hall":
			{
				if(isdefined(level.var_eab529d7))
				{
					if(isdefined(level.var_eab529d7.fx_org))
					{
						level.var_eab529d7.fx_org thread function_67a6aea8();
					}
					level namespace_6747c550::function_7df6bb60(#"hash_1dd7a9a7abf4d516", 1);
					level flag::set("crystal_main_hall");
					playsoundatposition(#"hash_7a91182f3727ce9", level.var_eab529d7.origin);
					level.var_eab529d7 delete();
				}
				break;
			}
			case "library":
			{
				if(isdefined(level.var_192555d1))
				{
					if(isdefined(level.var_192555d1.fx_org))
					{
						level.var_192555d1.fx_org thread function_67a6aea8();
					}
					level namespace_6747c550::function_7df6bb60(#"hash_1dd7a8a7abf4d363", 1);
					level flag::set("crystal_library");
					playsoundatposition(#"hash_7a91182f3727ce9", level.var_192555d1.origin);
					level.var_192555d1 delete();
				}
				break;
			}
			case "greenhouse":
			{
				if(isdefined(level.var_a46e88e5))
				{
					if(isdefined(level.var_a46e88e5.fx_org))
					{
						level.var_a46e88e5.fx_org thread function_67a6aea8();
					}
					level namespace_6747c550::function_7df6bb60(#"hash_1dd7a7a7abf4d1b0", 1);
					level flag::set("crystal_greenhouse");
					playsoundatposition(#"hash_7a91182f3727ce9", level.var_a46e88e5.origin);
					level.var_a46e88e5 delete();
				}
				break;
			}
		}
		if(self.stub.str_type == "nos")
		{
			level notify(#"hash_2e6a18007d9e2996");
		}
		zm_unitrigger::unregister_unitrigger(self.stub);
	}
}

/*
	Name: function_67a6aea8
	Namespace: namespace_b8f22955
	Checksum: 0xEDEEECEE
	Offset: 0xE218
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_67a6aea8()
{
	self clientfield::set("" + #"hash_51257ec597a8f84f", 0);
	wait(3);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_7ff450ae
	Namespace: namespace_b8f22955
	Checksum: 0xF264316A
	Offset: 0xE270
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_7ff450ae()
{
	wait(0.1);
	if(isdefined(self))
	{
		self playsound(#"hash_4826261b01f96036");
		self playloopsound(#"hash_298631572be3dd79");
	}
}

/*
	Name: function_eecfbd25
	Namespace: namespace_b8f22955
	Checksum: 0x60BF75B
	Offset: 0xE2D0
	Size: 0x198
	Parameters: 0
	Flags: Linked
*/
function function_eecfbd25()
{
	var_7156d2c4 = getentarray("forest_gate_pap_location", "prefabname");
	foreach(e_chunk in var_7156d2c4)
	{
		e_chunk notify(#"hash_404acc7ce223033");
		e_chunk setplayercollision(0);
		e_chunk.targetname = "";
		if(isdefined(e_chunk.unitrigger_stub))
		{
			zm_unitrigger::unregister_unitrigger(e_chunk.unitrigger_stub);
		}
		if(isdefined(e_chunk.packa_rollers))
		{
			e_chunk.packa_rollers delete();
		}
		if(isdefined(e_chunk.packa_timer))
		{
			e_chunk.packa_timer delete();
		}
		e_chunk connectpaths();
		e_chunk hide();
		e_chunk delete();
	}
}

/*
	Name: function_f728c266
	Namespace: namespace_b8f22955
	Checksum: 0x920D727D
	Offset: 0xE470
	Size: 0x1EE
	Parameters: 0
	Flags: None
*/
function function_f728c266()
{
	/#
		switch(function_9e72a96(self.id))
		{
			case "hash_51c79c8e74688138":
			{
				break;
			}
			case "hash_51c79f8e74688651":
			{
				break;
			}
			case "hash_51c79e8e7468849e":
			{
				break;
			}
			case "hash_478cff8e6e2b9aad":
			{
				break;
			}
			case "hash_478cfc8e6e2b9594":
			{
				break;
			}
			case "hash_478cfd8e6e2b9747":
			{
				break;
			}
			case "hash_3fc3ce8e6a02292e":
			{
				break;
			}
			case "hash_3fc3cd8e6a02277b":
			{
				break;
			}
			default:
			{
				return;
			}
		}
		level flag::wait_till("");
		while(getdvarint(#"hash_612c719b4ad48d57", 0))
		{
			var_91d1913b = distance2d(level.players[0].origin, self.origin);
			n_radius = 0.015 * var_91d1913b;
			if(n_radius > 32)
			{
				n_radius = 32;
			}
			v_color = (1, 1, 0);
			if(isdefined(self.active) && self.active)
			{
				v_color = (0, 1, 0);
			}
			sphere(self.origin, n_radius, v_color);
			waitframe(1);
		}
	#/
}

/*
	Name: function_debf98ad
	Namespace: namespace_b8f22955
	Checksum: 0x33E89362
	Offset: 0xE668
	Size: 0x176
	Parameters: 1
	Flags: None
*/
function function_debf98ad(v_color)
{
	/#
		if(!isdefined(v_color))
		{
			v_color = (0, 1, 0);
		}
		self notify(#"hash_75850c5ae5d8a5dc");
		self endon(#"death", #"hash_75850c5ae5d8a5dc");
		level flag::wait_till("");
		while(getdvarint(#"hash_3c4df2fe4b1618d5", 0))
		{
			var_91d1913b = distance2d(level.players[0].origin, self.origin);
			n_radius = 0.015 * var_91d1913b;
			if(n_radius > 32)
			{
				n_radius = 32;
			}
			sphere(self.origin, n_radius, v_color);
			if(isdefined(self.targetname))
			{
				print3d(self.origin, self.targetname, v_color, 1, 0.25);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: debug_draw_star
	Namespace: namespace_b8f22955
	Checksum: 0xF8533AD
	Offset: 0xE7E8
	Size: 0x186
	Parameters: 1
	Flags: None
*/
function debug_draw_star(v_color)
{
	/#
		if(!isdefined(v_color))
		{
			v_color = (0, 1, 0);
		}
		self notify(#"hash_75850c5ae5d8a5dc");
		self endon(#"death", #"hash_75850c5ae5d8a5dc");
		level flag::wait_till("");
		while(getdvarint(#"hash_3c4df2fe4b1618d5", 0))
		{
			var_91d1913b = distance2d(level.players[0].origin, self.origin);
			n_radius = 0.015 * var_91d1913b;
			if(n_radius > 32)
			{
				n_radius = 32;
			}
			debugstar(self.origin, 1, v_color);
			if(isdefined(self.targetname))
			{
				print3d(self.origin + vectorscale((0, 0, 1), 4), self.targetname, v_color, 1, 0.5);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_af24d641
	Namespace: namespace_b8f22955
	Checksum: 0x7FBF8984
	Offset: 0xE978
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function function_af24d641()
{
	/#
		self notify(#"hash_75850c5ae5d8a5dc");
	#/
}

/*
	Name: function_5e48b125
	Namespace: namespace_b8f22955
	Checksum: 0x5DF82501
	Offset: 0xE9A0
	Size: 0xD6
	Parameters: 4
	Flags: None
*/
function function_5e48b125(thing, var_f068172b, str_ender, v_color)
{
	/#
		if(!isdefined(str_ender))
		{
			str_ender = "";
		}
		if(!isdefined(v_color))
		{
			v_color = (0, 1, 0);
		}
		self endon(#"death", str_ender);
		thing endon(#"death", str_ender);
		var_f068172b endon(#"death", str_ender);
		while(isdefined(thing) && isdefined(var_f068172b))
		{
			line(thing.origin, var_f068172b.origin, v_color);
			waitframe(1);
		}
	#/
}

/*
	Name: function_75e87a52
	Namespace: namespace_b8f22955
	Checksum: 0x1C54B704
	Offset: 0xEA80
	Size: 0xF8
	Parameters: 2
	Flags: None
*/
function function_75e87a52(nd_start, v_color)
{
	/#
		self notify("");
		self endon("");
		var_ce8cd8 = nd_start;
		while(getdvarint(#"hash_3c4df2fe4b1618d5", 0) && isdefined(self))
		{
			waitframe(1);
			if(isdefined(var_ce8cd8) && isdefined(var_ce8cd8.target))
			{
				nd_next = getvehiclenode(var_ce8cd8.target, "");
				self thread function_5e48b125(var_ce8cd8, nd_next, "", v_color);
				var_ce8cd8 = nd_next;
				continue;
			}
			break;
		}
	#/
}

