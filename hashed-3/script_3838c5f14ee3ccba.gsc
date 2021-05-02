// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b10fdf0addd52e;
#using script_33fd053376f47476;
#using script_3e8c1d1a6e50b75b;
#using script_3f9e0dc8454d98e1;
#using script_508e64253010d13c;
#using script_52a84b3d20788c6;
#using script_5bb072c3abf4652c;
#using script_6c5b51f98cd04fa3;
#using script_733222d63341ad58;
#using script_7e59d7bba853fe4b;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_zodt8.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_8139f49c;

/*
	Name: function_89f2df9
	Namespace: namespace_8139f49c
	Checksum: 0xA318B9E8
	Offset: 0xDD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_77bec2ab64ee4676", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_8139f49c
	Checksum: 0xAD109408
	Offset: 0xE20
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
	init_flags();
	function_3335f286();
	function_a46c58d0();
	function_f34b8812();
	function_cf33e88a();
	level thread function_28effa18();
	function_8dec32e2();
	init_vo();
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			level thread function_5d346946();
		}
	#/
}

/*
	Name: init_clientfields
	Namespace: namespace_8139f49c
	Checksum: 0x63E20BF8
	Offset: 0xF08
	Size: 0x484
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "engine_room_chillout_decals", 1, 1, "int");
	clientfield::register("world", "state_rooms_chillout_decals", 1, 1, "int");
	clientfield::register("world", "promenade_chillout_decals", 1, 1, "int");
	clientfield::register("world", "poop_deck_chillout_decals", 1, 1, "int");
	clientfield::register("scriptmover", "bs_bdy_base_cf", 1, 3, "int");
	clientfield::register("scriptmover", "bs_bdy_fx_cf", 1, 2, "int");
	clientfield::register("scriptmover", "bs_bdy_dmg_fx_cf", 1, 3, "int");
	clientfield::register("scriptmover", "bs_dth_fx_cf", 1, 1, "counter");
	clientfield::register("scriptmover", "bs_bdy_str_cf", 1, 2, "int");
	clientfield::register("scriptmover", "bs_spn_fx_cf", 1, 1, "int");
	clientfield::register("scriptmover", "bs_att_mst_tell_cf", 1, 1, "int");
	clientfield::register("scriptmover", "bs_att_mst_cf", 1, 1, "int");
	clientfield::register("scriptmover", "bs_att_bm_targ_ini_cf", 1, 1, "int");
	clientfield::register("scriptmover", "bs_att_bm_tell_cf", 1, 2, "int");
	clientfield::register("scriptmover", "bs_att_bm_tell_fx_cf", 1, 1, "int");
	clientfield::register("scriptmover", "bs_att_bm_cf", 1, 1, "int");
	clientfield::register("allplayers", "bs_att_bm_targ_hit_cf", 1, 1, "int");
	clientfield::register("toplayer", "bs_att_bm_targ_frz_fx_cf", 1, 1, "int");
	clientfield::register("scriptmover", "bs_att_blst_tll", 1, 1, "int");
	clientfield::register("scriptmover", "bs_att_blst", 1, 1, "int");
	clientfield::register("world", "in_engine_room", 1, 1, "int");
	clientfield::register("world", "bs_gr_fog_fx_cf", 1, 1, "int");
	clientfield::register("allplayers", "bs_player_ice_br_cf", 1, 1, "int");
	clientfield::register("allplayers", "bs_player_snow_cf", 1, 3, "int");
}

/*
	Name: init_flags
	Namespace: namespace_8139f49c
	Checksum: 0x75A7482
	Offset: 0x1398
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"boss_fight_started");
	level flag::init(#"hash_62b951a213a3945e");
	level flag::init(#"hash_bd3b222f6d8329d");
	level flag::init(#"hash_fa1fa6cc9b17c7c");
	level flag::init(#"hash_50113a36d2c6bb73");
	level flag::init(#"hash_25d8c88ff3f91ee5");
}

/*
	Name: function_3335f286
	Namespace: namespace_8139f49c
	Checksum: 0xA792B719
	Offset: 0x1468
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function function_3335f286()
{
	namespace_ee206246::register(#"boss_fight", #"step_1", #"hash_29b25d86ddeb7d44", &function_51e51897, &function_99cfd11d);
	namespace_ee206246::register(#"boss_fight", #"step_2", #"hash_29b26086ddeb825d", &function_85bc1590, &function_af6afecd);
	namespace_ee206246::register(#"boss_fight", #"step_3", #"hash_29b25f86ddeb80aa", &function_ed500548, &function_3c959c2e);
	namespace_ee206246::register(#"boss_fight", #"step_4", #"hash_29b25a86ddeb782b", &function_37f8d5ce, &function_eeb1c75d);
	namespace_ee206246::register(#"boss_fight", #"step_5", #"hash_29b25986ddeb7678", &function_b939c184, &function_c6fc0a46);
}

/*
	Name: function_a46c58d0
	Namespace: namespace_8139f49c
	Checksum: 0x923A052D
	Offset: 0x1658
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_a46c58d0()
{
	a_blockers = getentarray("bs_scr_bkr", "targetname");
	foreach(e_blocker in a_blockers)
	{
		e_blocker hide();
		e_blocker notsolid();
	}
}

/*
	Name: function_f34b8812
	Namespace: namespace_8139f49c
	Checksum: 0x208832CD
	Offset: 0x1718
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_f34b8812()
{
	a_blockers = getentarray("bs_att_bm_ai_blck", "targetname");
	foreach(e_blocker in a_blockers)
	{
		e_blocker hide();
		e_blocker notsolid();
	}
}

/*
	Name: function_cf33e88a
	Namespace: namespace_8139f49c
	Checksum: 0xE90CE296
	Offset: 0x17D8
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function function_cf33e88a()
{
	var_6c390c77 = getent("bs_bdy_mdl", "targetname");
	var_6c390c77 enablelinkto();
	var_6c390c77 notsolid();
	var_6c390c77.var_a6ed9e82 = getent("bs_bdy_dmg", "targetname");
	var_6c390c77.var_a6ed9e82.takedamage = 1;
	var_6c390c77.var_a6ed9e82 function_2baad8fc();
	var_6c390c77.var_a6ed9e82.var_6f84b820 = #"boss";
	var_6c390c77.var_a6ed9e82 enablelinkto();
	var_6c390c77.var_a6ed9e82 linkto(var_6c390c77);
	var_6c390c77.var_a6ed9e82 notsolid();
	level.var_6c390c77 = var_6c390c77;
	zm_player::register_slowdown(#"hash_2cc0dfb628810e41", 0.5, 0.1);
	zm_player::register_slowdown(#"hash_7d336706f2aeadab", 0, 60);
	zm_player::register_slowdown(#"hash_532f7f688c86c9b1", 0, 2);
	zm_player::register_slowdown(#"hash_2a290908eb355917", 0, 2);
}

/*
	Name: function_28effa18
	Namespace: namespace_8139f49c
	Checksum: 0x6B608369
	Offset: 0x19E8
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_28effa18()
{
	wait(5);
	level flag::wait_till("start_zombie_round_logic");
	function_901c5ffe("eng", 0);
	function_901c5ffe("st", 0);
	function_901c5ffe("pro", 0);
	function_901c5ffe("pd", 0);
}

/*
	Name: function_8dec32e2
	Namespace: namespace_8139f49c
	Checksum: 0xAA6D09FF
	Offset: 0x1A80
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function function_8dec32e2()
{
	var_e9b0099b = getent("zombie_spawner_blight_father", "targetname");
	namespace_3fffba66::function_cfca77a7(var_e9b0099b, #"hash_9ecf8085fb7a68f", &namespace_1e226e4e::function_39212989, 10, undefined, undefined, "aib_vign_zm_zod_bltfthr_spawn_pre_split", "aib_vign_zm_zod_bltfthr_spawn_post_split");
	var_c1da220b = getent("zombie_spawn_1", "script_string");
	namespace_3fffba66::function_cfca77a7(var_c1da220b, #"hash_7c89b1397a38e3ad", &namespace_e0710ee6::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_corrosive_spawn_pre_split", "aib_vign_zm_zod_catalyst_corrosive_spawn_post_split");
	var_c1da220b = getent("zombie_spawn_2", "script_string");
	namespace_3fffba66::function_cfca77a7(var_c1da220b, #"hash_7c89ae397a38de94", &namespace_e0710ee6::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_water_spawn_pre_split", "aib_vign_zm_zod_catalyst_water_spawn_post_split");
	var_c1da220b = getent("zombie_spawn_3", "script_string");
	namespace_3fffba66::function_cfca77a7(var_c1da220b, #"hash_7c89af397a38e047", &namespace_e0710ee6::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_electric_spawn_pre_split", "aib_vign_zm_zod_catalyst_electric_spawn_post_split");
	var_c1da220b = getent("zombie_spawn_4", "script_string");
	namespace_3fffba66::function_cfca77a7(var_c1da220b, #"hash_7c89ac397a38db2e", &namespace_e0710ee6::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_plasma_spawn_pre_split", "aib_vign_zm_zod_catalyst_plasma_spawn_post_split");
}

/*
	Name: init_vo
	Namespace: namespace_8139f49c
	Checksum: 0x9554D2A2
	Offset: 0x1CC8
	Size: 0x10DE
	Parameters: 0
	Flags: Linked
*/
function init_vo()
{
	level.var_bd976920 = [];
	if(!isdefined(level.var_bd976920[1]))
	{
		level.var_bd976920[1] = [];
	}
	else if(!isarray(level.var_bd976920[1]))
	{
		level.var_bd976920[1] = array(level.var_bd976920[1]);
	}
	level.var_bd976920[1][level.var_bd976920[1].size] = array(1, #"hash_3131662c13d2efbc");
	if(!isdefined(level.var_bd976920[1]))
	{
		level.var_bd976920[1] = [];
	}
	else if(!isarray(level.var_bd976920[1]))
	{
		level.var_bd976920[1] = array(level.var_bd976920[1]);
	}
	level.var_bd976920[1][level.var_bd976920[1].size] = array(4, #"hash_3131662c13d2efbc");
	if(!isdefined(level.var_bd976920[1]))
	{
		level.var_bd976920[1] = [];
	}
	else if(!isarray(level.var_bd976920[1]))
	{
		level.var_bd976920[1] = array(level.var_bd976920[1]);
	}
	level.var_bd976920[1][level.var_bd976920[1].size] = array(2, #"hash_3131662c13d2efbc");
	if(!isdefined(level.var_bd976920[1]))
	{
		level.var_bd976920[1] = [];
	}
	else if(!isarray(level.var_bd976920[1]))
	{
		level.var_bd976920[1] = array(level.var_bd976920[1]);
	}
	level.var_bd976920[1][level.var_bd976920[1].size] = array(3, #"hash_3131662c13d2efbc");
	if(!isdefined(level.var_bd976920[2]))
	{
		level.var_bd976920[2] = [];
	}
	else if(!isarray(level.var_bd976920[2]))
	{
		level.var_bd976920[2] = array(level.var_bd976920[2]);
	}
	level.var_bd976920[2][level.var_bd976920[2].size] = array(1, #"hash_510594b72cc9b1fd");
	if(!isdefined(level.var_bd976920[2]))
	{
		level.var_bd976920[2] = [];
	}
	else if(!isarray(level.var_bd976920[2]))
	{
		level.var_bd976920[2] = array(level.var_bd976920[2]);
	}
	level.var_bd976920[2][level.var_bd976920[2].size] = array(4, #"hash_510594b72cc9b1fd");
	if(!isdefined(level.var_bd976920[2]))
	{
		level.var_bd976920[2] = [];
	}
	else if(!isarray(level.var_bd976920[2]))
	{
		level.var_bd976920[2] = array(level.var_bd976920[2]);
	}
	level.var_bd976920[2][level.var_bd976920[2].size] = array(3, #"hash_510594b72cc9b1fd");
	if(!isdefined(level.var_bd976920[2]))
	{
		level.var_bd976920[2] = [];
	}
	else if(!isarray(level.var_bd976920[2]))
	{
		level.var_bd976920[2] = array(level.var_bd976920[2]);
	}
	level.var_bd976920[2][level.var_bd976920[2].size] = array(2, #"hash_510594b72cc9b1fd");
	if(!isdefined(level.var_bd976920[3]))
	{
		level.var_bd976920[3] = [];
	}
	else if(!isarray(level.var_bd976920[3]))
	{
		level.var_bd976920[3] = array(level.var_bd976920[3]);
	}
	level.var_bd976920[3][level.var_bd976920[3].size] = array(2, #"hash_7dc8f64c802a299e");
	if(!isdefined(level.var_bd976920[3]))
	{
		level.var_bd976920[3] = [];
	}
	else if(!isarray(level.var_bd976920[3]))
	{
		level.var_bd976920[3] = array(level.var_bd976920[3]);
	}
	level.var_bd976920[3][level.var_bd976920[3].size] = array(4, #"hash_7dc8f64c802a299e");
	if(!isdefined(level.var_bd976920[3]))
	{
		level.var_bd976920[3] = [];
	}
	else if(!isarray(level.var_bd976920[3]))
	{
		level.var_bd976920[3] = array(level.var_bd976920[3]);
	}
	level.var_bd976920[3][level.var_bd976920[3].size] = array(1, #"hash_7dc8f64c802a299e");
	if(!isdefined(level.var_bd976920[3]))
	{
		level.var_bd976920[3] = [];
	}
	else if(!isarray(level.var_bd976920[3]))
	{
		level.var_bd976920[3] = array(level.var_bd976920[3]);
	}
	level.var_bd976920[3][level.var_bd976920[3].size] = array(3, #"hash_7dc8f64c802a299e");
	if(!isdefined(level.var_bd976920[4]))
	{
		level.var_bd976920[4] = [];
	}
	else if(!isarray(level.var_bd976920[4]))
	{
		level.var_bd976920[4] = array(level.var_bd976920[4]);
	}
	level.var_bd976920[4][level.var_bd976920[4].size] = array(1, #"hash_c76edadd1574af7");
	if(!isdefined(level.var_bd976920[4]))
	{
		level.var_bd976920[4] = [];
	}
	else if(!isarray(level.var_bd976920[4]))
	{
		level.var_bd976920[4] = array(level.var_bd976920[4]);
	}
	level.var_bd976920[4][level.var_bd976920[4].size] = array(2, #"hash_c76edadd1574af7");
	if(!isdefined(level.var_bd976920[4]))
	{
		level.var_bd976920[4] = [];
	}
	else if(!isarray(level.var_bd976920[4]))
	{
		level.var_bd976920[4] = array(level.var_bd976920[4]);
	}
	level.var_bd976920[4][level.var_bd976920[4].size] = array(3, #"hash_c76edadd1574af7");
	if(!isdefined(level.var_bd976920[4]))
	{
		level.var_bd976920[4] = [];
	}
	else if(!isarray(level.var_bd976920[4]))
	{
		level.var_bd976920[4] = array(level.var_bd976920[4]);
	}
	level.var_bd976920[4][level.var_bd976920[4].size] = array(4, #"hash_c76edadd1574af7");
	if(!isdefined(level.var_bd976920[5]))
	{
		level.var_bd976920[5] = [];
	}
	else if(!isarray(level.var_bd976920[5]))
	{
		level.var_bd976920[5] = array(level.var_bd976920[5]);
	}
	level.var_bd976920[5][level.var_bd976920[5].size] = array(4, #"hash_3cde846b48875568");
	if(!isdefined(level.var_bd976920[5]))
	{
		level.var_bd976920[5] = [];
	}
	else if(!isarray(level.var_bd976920[5]))
	{
		level.var_bd976920[5] = array(level.var_bd976920[5]);
	}
	level.var_bd976920[5][level.var_bd976920[5].size] = array(3, #"hash_3cde846b48875568");
	if(!isdefined(level.var_bd976920[5]))
	{
		level.var_bd976920[5] = [];
	}
	else if(!isarray(level.var_bd976920[5]))
	{
		level.var_bd976920[5] = array(level.var_bd976920[5]);
	}
	level.var_bd976920[5][level.var_bd976920[5].size] = array(2, #"hash_3cde846b48875568");
	if(!isdefined(level.var_bd976920[5]))
	{
		level.var_bd976920[5] = [];
	}
	else if(!isarray(level.var_bd976920[5]))
	{
		level.var_bd976920[5] = array(level.var_bd976920[5]);
	}
	level.var_bd976920[5][level.var_bd976920[5].size] = array(1, #"hash_3cde846b48875568");
	level.var_d748689e = #"hash_2df184d89b83d7a6";
	level.var_73f9d759 = #"hash_68b36b3fd33fde80";
	level.var_99d2b056 = #"hash_50eaadbd6d85e554";
	level.var_2404b2a5 = #"hash_1eb09b9ee996d6ed";
	level.var_c7daa370 = #"hash_1ad33382e08dace7";
	level.var_ad9b527b = #"hash_6c43ec4efecb96f8";
}

/*
	Name: function_51e51897
	Namespace: namespace_8139f49c
	Checksum: 0xA95A1F9E
	Offset: 0x2DB0
	Size: 0x554
	Parameters: 1
	Flags: Linked
*/
function function_51e51897(var_5ea5c94d)
{
	level flag::clear("spawn_zombies");
	level flag::clear("zombie_drop_powerups");
	level flag::clear(#"hash_21921ed511559aa3");
	level flag::set(#"hash_1b9ecc7979b0fcfb");
	level flag::set("pause_round_timeout");
	level flag::set(#"boss_fight_started");
	level zm_bgb_anywhere_but_here::function_886fce8f(0);
	arrayremoveindex(level.sndplayervox, #"elixir", 1);
	arrayremoveindex(level.sndplayervox, #"blight_father", 1);
	arrayremoveindex(level.sndplayervox, #"powerup", 1);
	arrayremoveindex(level.sndplayervox, #"stoker", 1);
	arrayremoveindex(level.sndplayervox, #"kill", 1);
	arrayremoveindex(level.sndplayervox, #"hash_110a819726ba35f4", 1);
	arrayremoveindex(level.sndplayervox, #"hash_50660c7d730b03a1", 1);
	arrayremoveindex(level.sndplayervox, #"hash_695932a4ae89574f", 1);
	arrayremoveindex(level.sndplayervox, #"hash_4433242e2d225df8", 1);
	arrayremoveindex(level.sndplayervox, #"hash_4c7748b237c6fcbe", 1);
	level.var_923e8cb4 = struct::get_array("pd", "script_teleport");
	level.var_eeb98313 = &function_714f8756;
	level.custom_spawnplayer = &function_9bc4f8cb;
	level.disable_nuke_delay_spawning = 1;
	level notify(#"disable_nuke_delay_spawning");
	level namespace_74905749::function_77a859a8(1);
	level.var_d6f059f7 = max(level.round_number, 25);
	zm_spawner::register_zombie_death_event_callback(&function_e9b8eaff);
	level.var_c9f5947d = 1;
	level notify(#"hash_3c3d24ff76335a0d");
	/#
		util::wait_network_frame();
		level notify(#"hash_fbdf766a8b47229");
	#/
	level.var_6c390c77 function_500cb0be(#"hash_678aaf8e37498e9a", #"hash_48d376e92022fee8");
	level thread zm_zodt8::change_water_height_aft(1);
	if(!var_5ea5c94d)
	{
		level thread function_482a7a01();
		level.musicsystemoverride = 1;
		music::setmusicstate("boss_1");
		level.var_6c390c77 function_8f3497ee(1, "pd");
		level thread function_de60e752();
		level thread function_f6e1e56f(10, 3);
		level thread function_776c95e2(50, 1);
		level thread function_ee223250(2);
		var_23cac703 = [];
		level.var_6c390c77 function_bb612e31(var_23cac703, 0, -1);
	}
}

/*
	Name: function_99cfd11d
	Namespace: namespace_8139f49c
	Checksum: 0x264191B5
	Offset: 0x3310
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_99cfd11d(var_5ea5c94d, ended_early)
{
	level flag::set(#"hash_62b951a213a3945e");
	if(!var_5ea5c94d)
	{
		level.var_6c390c77 function_9bc73093(1);
	}
}

/*
	Name: function_85bc1590
	Namespace: namespace_8139f49c
	Checksum: 0x552C6040
	Offset: 0x3378
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function function_85bc1590(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level clientfield::set("in_engine_room", 1);
		level function_f4cadcd6("eng");
		level thread function_482a7a01();
		level.var_6c390c77 function_8f3497ee(2, "eng");
		var_533ac894 = array(#"zone_boiler_room", #"zone_turbine_room");
		level thread function_de60e752(var_533ac894);
		level thread function_f6e1e56f(12, 3, var_533ac894);
		level thread function_776c95e2(35, 2);
		level thread function_ee223250(2);
		var_23cac703 = array(&function_ff69c896);
		level.var_6c390c77 function_bb612e31(var_23cac703, 0, -1, 0);
	}
}

/*
	Name: function_af6afecd
	Namespace: namespace_8139f49c
	Checksum: 0x7C9F24E6
	Offset: 0x3510
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_af6afecd(var_5ea5c94d, ended_early)
{
	level flag::set(#"hash_bd3b222f6d8329d");
	if(!var_5ea5c94d)
	{
		level.var_6c390c77 function_9bc73093(2);
		level clientfield::set("in_engine_room", 0);
	}
}

/*
	Name: function_ed500548
	Namespace: namespace_8139f49c
	Checksum: 0xC878FDC1
	Offset: 0x3598
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_ed500548(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_f4cadcd6("st");
		level thread function_482a7a01();
		music::setmusicstate("boss_2");
		level.var_6c390c77 function_8f3497ee(3, "st");
		level thread function_de60e752();
		level thread function_f6e1e56f(20);
		var_23cac703 = array(&function_c7c928e9);
		level.var_6c390c77 function_bb612e31(var_23cac703, 8000, 36000);
	}
}

/*
	Name: function_3c959c2e
	Namespace: namespace_8139f49c
	Checksum: 0xCD009F82
	Offset: 0x36B0
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_3c959c2e(var_5ea5c94d, ended_early)
{
	level flag::set(#"hash_fa1fa6cc9b17c7c");
	if(!var_5ea5c94d)
	{
		level.var_6c390c77 function_9bc73093(3);
	}
}

/*
	Name: function_37f8d5ce
	Namespace: namespace_8139f49c
	Checksum: 0x19A037DC
	Offset: 0x3718
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_37f8d5ce(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level function_f4cadcd6("pro");
		level thread function_482a7a01();
		level.var_6c390c77 function_8f3497ee(4, "pro");
		level thread function_de60e752();
		level thread function_f6e1e56f(15);
		level thread function_770486e1(46);
		var_23cac703 = array(&function_371e0929);
		level.var_6c390c77 function_bb612e31(var_23cac703, 13000, 35000);
	}
}

/*
	Name: function_eeb1c75d
	Namespace: namespace_8139f49c
	Checksum: 0x632312AC
	Offset: 0x3830
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_eeb1c75d(var_5ea5c94d, ended_early)
{
	level flag::set(#"hash_50113a36d2c6bb73");
	if(!var_5ea5c94d)
	{
		level.var_6c390c77 function_9bc73093(4);
	}
}

/*
	Name: function_b939c184
	Namespace: namespace_8139f49c
	Checksum: 0x240D2FC0
	Offset: 0x3898
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_b939c184(var_5ea5c94d)
{
	level function_f4cadcd6("pd");
	level thread function_482a7a01();
	music::setmusicstate("boss_3");
	level.var_6c390c77 function_8f3497ee(5, "pd");
	level thread function_de60e752();
	level thread function_f6e1e56f(9);
	level thread function_770486e1(35);
	var_23cac703 = array(&function_f487ff16);
	level.var_6c390c77 function_6fa7a16a(var_23cac703);
}

/*
	Name: function_c6fc0a46
	Namespace: namespace_8139f49c
	Checksum: 0x82D12056
	Offset: 0x39B8
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function function_c6fc0a46(var_5ea5c94d, ended_early)
{
	level flag::clear(#"boss_fight_started");
	level zm_bgb_anywhere_but_here::function_886fce8f(1);
	level.custom_spawnplayer = undefined;
	level.var_c9f5947d = 0;
	zm_spawner::deregister_zombie_death_event_callback(&function_e9b8eaff);
	music::setmusicstate("none");
	level.musicsystemoverride = 0;
	level.var_6c390c77 function_9bc73093(5);
	function_a46c58d0();
	level flag::set(#"hash_25d8c88ff3f91ee5");
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_9bc4f8cb
	Namespace: namespace_8139f49c
	Checksum: 0x4E522582
	Offset: 0x3AE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_9bc4f8cb()
{
	self.spectator_respawn = level.var_923e8cb4[self.characterindex];
	self zm_player::spectator_respawn();
}

/*
	Name: function_f74b38da
	Namespace: namespace_8139f49c
	Checksum: 0x53A56EE8
	Offset: 0x3B20
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function function_f74b38da(str_rumble, var_b5291261 = 0)
{
	if(var_b5291261)
	{
		a_e_players = arraycopy(level.activeplayers);
	}
	else
	{
		a_e_players = arraycopy(level.players);
	}
	foreach(e_player in a_e_players)
	{
		e_player playrumbleonentity(str_rumble);
	}
}

/*
	Name: function_500cb0be
	Namespace: namespace_8139f49c
	Checksum: 0x9387F52A
	Offset: 0x3C10
	Size: 0x22C
	Parameters: 2
	Flags: Linked
*/
function function_500cb0be(var_b1a0177b, str_scene)
{
	self endon(#"death");
	self setmodel(var_b1a0177b);
	self.mdl_base = var_b1a0177b;
	if(var_b1a0177b == #"hash_678aaf8e37498e9a")
	{
		self clientfield::set("bs_bdy_base_cf", 1);
	}
	else if(var_b1a0177b == #"hash_32a51dafb1c7344f")
	{
		self clientfield::set("bs_bdy_base_cf", 2);
	}
	else if(var_b1a0177b == #"hash_597bdc83a7c9e8c")
	{
		self clientfield::set("bs_bdy_base_cf", 3);
	}
	self.str_scene = str_scene;
	self function_3d8879d7();
	util::wait_network_frame();
	self clientfield::set("bs_bdy_fx_cf", 2);
	util::wait_network_frame();
	if(isdefined(self.var_ad1388ef) && self.var_ad1388ef)
	{
		self clientfield::set("bs_bdy_fx_cf", 0);
	}
	else
	{
		self clientfield::set("bs_bdy_fx_cf", 1);
	}
	if(isdefined(self.var_914750d) && self.var_914750d > 0 && self.var_914750d <= 3)
	{
		util::wait_network_frame();
		self clientfield::set("bs_bdy_dmg_fx_cf", self.var_914750d);
	}
}

/*
	Name: function_3d8879d7
	Namespace: namespace_8139f49c
	Checksum: 0x71EB3AEE
	Offset: 0x3E48
	Size: 0x2B4
	Parameters: 1
	Flags: Linked
*/
function function_3d8879d7(var_97d9fa86)
{
	self endon(#"death");
	self clientfield::set("bs_bdy_str_cf", 0);
	if(!isdefined(var_97d9fa86))
	{
		self clientfield::set("bs_bdy_str_cf", 2);
		util::wait_network_frame(8);
		self clientfield::set("bs_bdy_dmg_fx_cf", 0);
		self.str_idle = "ilde";
		self.str_arrive = "arrive";
		self.str_depart = "leave";
	}
	else if(var_97d9fa86 == "crack")
	{
		self clientfield::set("bs_bdy_str_cf", 1);
		util::wait_network_frame(8);
		self clientfield::set("bs_bdy_dmg_fx_cf", self.var_914750d);
		self scene::play(self.str_scene, "crack", self);
		self animation::stop(0);
		self.str_arrive = "crack_arrive";
		self.str_depart = "crack_leave";
	}
	else if(var_97d9fa86 == "break")
	{
		self clientfield::set("bs_bdy_str_cf", 1);
		util::wait_network_frame(8);
		self clientfield::set("bs_bdy_dmg_fx_cf", self.var_914750d);
		self scene::play(self.str_scene, "break", self);
		self animation::stop(0);
		self.str_arrive = "break_arrive";
		self.str_depart = "break_leave";
	}
	util::wait_network_frame(2);
	self clientfield::set("bs_bdy_str_cf", 0);
}

/*
	Name: function_901c5ffe
	Namespace: namespace_8139f49c
	Checksum: 0xB003076
	Offset: 0x4108
	Size: 0x43A
	Parameters: 2
	Flags: Linked
*/
function function_901c5ffe(str_loc, b_on)
{
	switch(str_loc)
	{
		case "eng":
		{
			if(b_on)
			{
				exploder::exploder("fxexp_er_bf_w_1");
				exploder::exploder("fxexp_er_bf_w_2");
				level clientfield::set("engine_room_chillout_decals", 0);
				var_4f77fdcb = getentarray("engine_room_chillout_ice", "targetname");
				foreach(var_da532ccb in var_4f77fdcb)
				{
					var_da532ccb solid();
					var_da532ccb show();
				}
				showmiscmodels("engine_room_chillout_misc_models_iced");
				hidemiscmodels("engine_room_chillout_misc_models_not_iced");
			}
			else
			{
				level clientfield::set("engine_room_chillout_decals", 1);
				var_4f77fdcb = getentarray("engine_room_chillout_ice", "targetname");
				foreach(var_da532ccb in var_4f77fdcb)
				{
					var_da532ccb notsolid();
					var_da532ccb hide();
				}
				showmiscmodels("engine_room_chillout_misc_models_not_iced");
				hidemiscmodels("engine_room_chillout_misc_models_iced");
			}
			break;
		}
		case "st":
		{
			if(b_on)
			{
				level clientfield::set("state_rooms_chillout_decals", 0);
			}
			else
			{
				level clientfield::set("state_rooms_chillout_decals", 1);
			}
			break;
		}
		case "pro":
		{
			if(b_on)
			{
				exploder::exploder("fxexp_s_p_bf_w");
				level clientfield::set("promenade_chillout_decals", 0);
				showmiscmodels("promenade_chillout_props");
			}
			else
			{
				level clientfield::set("promenade_chillout_decals", 1);
				hidemiscmodels("promenade_chillout_props");
			}
			break;
		}
		case "pd":
		{
			if(b_on)
			{
				exploder::exploder("fxexp_pd_bf_w");
				level clientfield::set("poop_deck_chillout_decals", 0);
				showmiscmodels("poop_deck_chillout_props");
			}
			else
			{
				level clientfield::set("poop_deck_chillout_decals", 1);
				hidemiscmodels("poop_deck_chillout_props");
			}
			break;
		}
	}
}

/*
	Name: function_714f8756
	Namespace: namespace_8139f49c
	Checksum: 0xA08CD882
	Offset: 0x4550
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function function_714f8756(var_65500f70)
{
	return level.var_923e8cb4;
}

/*
	Name: function_f4cadcd6
	Namespace: namespace_8139f49c
	Checksum: 0x62837D84
	Offset: 0x4570
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_f4cadcd6(str_loc)
{
	level.var_923e8cb4 = struct::get_array(str_loc, "script_teleport");
	level namespace_74905749::function_43a16eb7(str_loc, struct::get(#"boss_fight"));
}

/*
	Name: function_7d475775
	Namespace: namespace_8139f49c
	Checksum: 0xDBBB4FF1
	Offset: 0x45F0
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_7d475775()
{
	foreach(player in level.players)
	{
		if(player laststand::player_is_in_laststand())
		{
			player thread zm_laststand::auto_revive(player);
		}
	}
}

/*
	Name: function_732f7da0
	Namespace: namespace_8139f49c
	Checksum: 0x295BEF3F
	Offset: 0x4690
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_732f7da0()
{
	if(!isdefined(level.var_f3c4bd00))
	{
		level.var_f3c4bd00 = zm_utility::get_number_of_valid_players();
	}
	else if(level.var_f3c4bd00 < zm_utility::get_number_of_valid_players())
	{
		level.var_f3c4bd00 = zm_utility::get_number_of_valid_players();
	}
}

/*
	Name: function_482a7a01
	Namespace: namespace_8139f49c
	Checksum: 0x409DB085
	Offset: 0x4708
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_482a7a01()
{
	self notify("1c4193aa80a6dcb8");
	self endon("1c4193aa80a6dcb8");
	level waittill(#"hash_38f29f9cb03586ea", #"intermission");
	namespace_3fffba66::function_e95ec8df();
	level namespace_74905749::function_77a859a8(1, 0, 0);
}

/*
	Name: function_c8f90603
	Namespace: namespace_8139f49c
	Checksum: 0x63721C5E
	Offset: 0x4788
	Size: 0x3B6
	Parameters: 2
	Flags: Linked
*/
function function_c8f90603(var_da816ebe, var_15d2b367)
{
	a_blockers = getentarray(var_da816ebe, "script_blocker");
	if(var_15d2b367)
	{
		foreach(e_blocker in a_blockers)
		{
			e_blocker solid();
			e_blocker show();
		}
		e_blocker.var_c2a873f6 = [];
		var_4dd195ea = struct::get_array(var_da816ebe, "script_blocker_fx");
		foreach(s_fx in var_4dd195ea)
		{
			mdl_fx = util::spawn_model(#"p8_zm_power_door_symbol_01", s_fx.origin, s_fx.angles);
			mdl_fx.objectid = "symbol_front_power";
			mdl_fx clientfield::set("" + #"hash_4b4f7c300315b9d0", 1);
			if(!isdefined(e_blocker.var_c2a873f6))
			{
				e_blocker.var_c2a873f6 = [];
			}
			else if(!isarray(e_blocker.var_c2a873f6))
			{
				e_blocker.var_c2a873f6 = array(e_blocker.var_c2a873f6);
			}
			e_blocker.var_c2a873f6[e_blocker.var_c2a873f6.size] = mdl_fx;
		}
	}
	else
	{
		foreach(e_blocker in a_blockers)
		{
			e_blocker notsolid();
			e_blocker hide();
			if(isdefined(e_blocker.var_c2a873f6))
			{
				foreach(mdl_fx in e_blocker.var_c2a873f6)
				{
					mdl_fx thread namespace_74905749::function_73145dbe();
					mdl_fx clientfield::set("" + #"hash_4b4f7c300315b9d0", 0);
				}
				e_blocker.var_c2a873f6 = undefined;
			}
		}
	}
}

/*
	Name: function_a55a0339
	Namespace: namespace_8139f49c
	Checksum: 0xDD54BBCA
	Offset: 0x4B48
	Size: 0x282
	Parameters: 1
	Flags: Linked
*/
function function_a55a0339(str_loc)
{
	self.var_431d02e5 = struct::get("bs_pth_hld_" + str_loc, "targetname");
	if(!isdefined(self.var_431d02e5))
	{
		self.var_431d02e5 = spawnstruct();
		self.var_431d02e5.targetname = "bs_pth_hld_" + str_loc;
		self.var_431d02e5.origin = vectorscale((0, 0, -1), 9999);
		self.var_431d02e5.angles = (0, 0, 0);
	}
	var_461e7e58 = struct::get("bs_pth_st_" + str_loc, "targetname");
	if(!isdefined(var_461e7e58))
	{
		var_461e7e58 = self.var_431d02e5;
	}
	/#
		assert(isdefined(var_461e7e58));
	#/
	self.var_86698449 = [];
	if(!isdefined(self.var_86698449))
	{
		self.var_86698449 = [];
	}
	else if(!isarray(self.var_86698449))
	{
		self.var_86698449 = array(self.var_86698449);
	}
	self.var_86698449[self.var_86698449.size] = var_461e7e58;
	self.n_path_start = 0;
	n_path_index = 0;
	while(isdefined(var_461e7e58.linkto))
	{
		n_path_index++;
		var_461e7e58 = struct::get(var_461e7e58.linkto, "linkname");
		if(!isdefined(self.var_86698449))
		{
			self.var_86698449 = [];
		}
		else if(!isarray(self.var_86698449))
		{
			self.var_86698449 = array(self.var_86698449);
		}
		self.var_86698449[self.var_86698449.size] = var_461e7e58;
		if(isdefined(var_461e7e58.var_f0b23ec1) && var_461e7e58.var_f0b23ec1)
		{
			self.n_path_start = n_path_index;
		}
	}
}

/*
	Name: function_8f3497ee
	Namespace: namespace_8139f49c
	Checksum: 0x82E85A92
	Offset: 0x4DD8
	Size: 0xCA4
	Parameters: 2
	Flags: Linked
*/
function function_8f3497ee(var_5839811b, str_loc)
{
	level thread function_c8f90603("bs_blkr_stg_" + str_loc, 1);
	util::wait_network_frame(2);
	self function_141c7d46();
	self function_a55a0339(str_loc);
	self function_26e02ac9(0);
	function_732f7da0();
	self function_71f63a19(str_loc);
	self function_1b11b43(str_loc);
	/#
		iprintlnbold("" + var_5839811b + "");
	#/
	zm_audio::sndvoxoverride(1);
	level.powerup_vo_available = &namespace_74905749::return_false;
	switch(var_5839811b)
	{
		case 1:
		{
			function_d21f5b58(1);
			wait(3);
			self function_1122d832("event_low_impact", "pd");
			self playsound("zmb_eyeball_vox_intro_s1");
			level thread function_f74b38da("zm_power_on_rumble");
			self scene::play(self.str_scene, "roar", self);
			self animation::stop(0);
			self thread scene::play(self.str_scene, self.str_idle, self);
			level util::delay(#"hash_5286b6160d468570", undefined, &function_a2170913, var_5839811b, 3);
			level thread namespace_74905749::function_53802e89(#"hash_696f2e5fafff5614", undefined, array(2, 1, 4, 3));
			wait(1.5);
			self function_671e8d37();
			self function_ead65ea1(0, 0);
			util::wait_network_frame(4);
			self function_20c99a47();
			self.var_451ab1a6 = 0;
			var_d1c757d1 = struct::get("bs_pth_pd_s1_hold", "targetname");
			self.origin = var_d1c757d1.origin;
			self.angles = var_d1c757d1.angles;
			self function_8e49143c();
			function_d21f5b58(0);
			break;
		}
		case 2:
		{
			function_d21f5b58(1);
			wait(3);
			self function_1122d832("event_low_impact", "eng", 2);
			self playsound("zmb_eyeball_vox_intro_s2");
			level thread function_f74b38da("zm_power_on_rumble");
			self scene::play(self.str_scene, "roar", self);
			self animation::stop(0);
			self thread scene::play(self.str_scene, self.str_idle, self);
			function_901c5ffe("eng", 1);
			wait(1);
			self clientfield::set("bs_att_mst_tell_cf", 1);
			level thread scene::play("p8_fxanim_zm_zod_engine_pistons_idle_01_bundle", "stop");
			level thread scene::play("p8_fxanim_zm_zod_engine_pistons_idle_02_bundle", "stop");
			wait(1);
			level thread function_a2170913(var_5839811b);
			function_d21f5b58(1);
			break;
		}
		case 3:
		{
			function_d21f5b58(1);
			wait(3);
			self function_1122d832("event_impact", "st");
			function_901c5ffe("st", 1);
			self playsound("zmb_eyeball_vox_intro_s3");
			level thread function_f74b38da("zm_power_on_rumble");
			self function_671e8d37();
			level thread function_a6f08a79(#"hash_33bad2b73372fb4d");
			self function_c7c928e9(0, 1, 0);
			level thread function_a6f08a79(#"hash_651c866df079d05d");
			self function_c7c928e9(0, 1, 1);
			self function_a8a76e18();
			wait(0.5);
			level thread function_a2170913(var_5839811b);
			function_d21f5b58(0);
			break;
		}
		case 4:
		{
			function_d21f5b58(1);
			self function_500cb0be(#"hash_32a51dafb1c7344f", #"hash_778aa1db2592594f");
			wait(3);
			self function_1122d832("event_impact", "pro", 4);
			self playsound("zmb_eyeball_vox_intro_s4");
			level thread function_f74b38da("zm_power_on_rumble");
			self.var_914750d = 1;
			self clientfield::set("bs_bdy_dmg_fx_cf", self.var_914750d);
			wait(0.5);
			function_901c5ffe("pro", 1);
			level thread function_3681a3ac(#"hash_5da478c959d34c54");
			level thread function_3681a3ac(#"hash_2c398eb908863afb");
			level thread function_3681a3ac(#"hash_6385c188c2623daa");
			self scene::play(self.str_scene, "roar1", self);
			self.str_idle = "idle1";
			self animation::stop(0);
			self thread scene::play(self.str_scene, self.str_idle, self);
			self clientfield::set("bs_att_mst_tell_cf", 0);
			wait(0.5);
			level thread function_a2170913(var_5839811b);
			function_d21f5b58(0);
			break;
		}
		case 5:
		{
			function_d21f5b58(1);
			self function_500cb0be(#"hash_597bdc83a7c9e8c", #"hash_7760b698f6aeafbe");
			wait(2);
			self function_1122d832("event_high_impact", "pd", 5);
			self playsound("zmb_eyeball_vox_intro_s5");
			level thread function_f74b38da("zm_power_on_rumble");
			self scene::play(self.str_scene, "roar2", self);
			self.str_idle = "idle2";
			self animation::stop(0);
			self thread scene::play(self.str_scene, self.str_idle, self);
			self.var_914750d = 1;
			self clientfield::set("bs_bdy_dmg_fx_cf", self.var_914750d);
			var_ff6feb7e = getentarray("forget_what_you_know", "targetname");
			foreach(mdl in var_ff6feb7e)
			{
				mdl.origin = mdl.origin - vectorscale((0, 0, 1), 13800);
				mdl show();
				mdl.origin = mdl.origin + vectorscale((0, 0, 1), 13800);
				mdl clientfield::set("" + #"hash_15b23de7589e61a", 1);
			}
			function_901c5ffe("pd", 1);
			wait(0.5);
			level thread function_a2170913(var_5839811b);
			wait(1);
			function_d21f5b58(0);
			break;
		}
	}
	/#
		iprintlnbold("" + var_5839811b + "");
	#/
}

/*
	Name: function_a2170913
	Namespace: namespace_8139f49c
	Checksum: 0xD08DF9C
	Offset: 0x5A88
	Size: 0x11E
	Parameters: 2
	Flags: Linked
*/
function function_a2170913(var_5839811b, n_delay)
{
	zm_audio::sndvoxoverride(1);
	if(isdefined(n_delay))
	{
		wait(n_delay);
	}
	foreach(str_vo_line in level.var_bd976920[var_5839811b])
	{
		e_speaker = zm_utility::function_828bac1(str_vo_line[0]);
		if(isplayer(e_speaker))
		{
			e_speaker namespace_891c9bac::function_a2bd5a0c(str_vo_line[1]);
		}
	}
	zm_audio::sndvoxoverride(0);
	level.powerup_vo_available = undefined;
}

/*
	Name: function_1122d832
	Namespace: namespace_8139f49c
	Checksum: 0x59BFA9E1
	Offset: 0x5BB0
	Size: 0x1E8
	Parameters: 3
	Flags: Linked
*/
function function_1122d832(var_d503d5d9, str_loc, var_5839811b)
{
	level thread scene::stop(#"p8_fxanim_zm_zod_skybox_bundle");
	level thread scene::play(#"p8_fxanim_zm_zod_skybox_bundle", var_d503d5d9);
	level thread function_f74b38da("zm_power_on_rumble");
	level thread namespace_74905749::function_63a0f09e(1, 0);
	wait(0.5);
	self function_1e93034e(str_loc);
	self function_a8a76e18(1);
	level clientfield::set("bs_gr_fog_fx_cf", 1);
	if(isdefined(var_5839811b))
	{
		switch(var_5839811b)
		{
			case 2:
			{
				var_5fe34cb1 = 1;
				break;
			}
			case 4:
			{
				var_5fe34cb1 = 2;
				break;
			}
			case 5:
			{
				var_5fe34cb1 = 3;
				break;
			}
		}
		foreach(e_player in level.players)
		{
			e_player clientfield::set("bs_player_snow_cf", var_5fe34cb1);
		}
	}
}

/*
	Name: function_a6f08a79
	Namespace: namespace_8139f49c
	Checksum: 0xB9EE612D
	Offset: 0x5DA0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_a6f08a79(var_c1d77974)
{
	wait(2.5);
	level thread scene::play(var_c1d77974);
}

/*
	Name: function_3681a3ac
	Namespace: namespace_8139f49c
	Checksum: 0x3CBE1169
	Offset: 0x5DD8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_3681a3ac(var_c1d77974)
{
	level thread scene::play(var_c1d77974);
}

/*
	Name: function_d21f5b58
	Namespace: namespace_8139f49c
	Checksum: 0x3BFEAE43
	Offset: 0x5E08
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function function_d21f5b58(var_ff66e3f1)
{
	if(var_ff66e3f1)
	{
		foreach(player in level.activeplayers)
		{
			player clientfield::set("bs_player_ice_br_cf", 1);
		}
	}
	else
	{
		foreach(player in level.players)
		{
			player clientfield::set("bs_player_ice_br_cf", 0);
		}
	}
}

/*
	Name: function_9bc73093
	Namespace: namespace_8139f49c
	Checksum: 0x31CAC9F
	Offset: 0x5F28
	Size: 0x6F4
	Parameters: 1
	Flags: Linked
*/
function function_9bc73093(var_5839811b)
{
	function_7d475775();
	/#
		iprintlnbold("" + var_5839811b + "");
	#/
	self function_26e02ac9(0);
	level thread function_f74b38da("zm_power_on_rumble");
	switch(var_5839811b)
	{
		case 1:
		{
			var_d66d7d37 = "zmb_eyeball_vox_outro_s1";
			var_d503d5d9 = "event_low_impact";
			break;
		}
		case 2:
		{
			var_d66d7d37 = "zmb_eyeball_vox_outro_s2";
			var_d503d5d9 = "event_impact";
			break;
		}
		case 3:
		{
			var_d66d7d37 = "zmb_eyeball_vox_outro_s3";
			var_d503d5d9 = "event_impact";
			break;
		}
		case 4:
		{
			var_d66d7d37 = "zmb_eyeball_vox_outro_s4";
			var_d503d5d9 = "event_high_impact";
			break;
		}
		case 5:
		{
			var_d66d7d37 = "zmb_eyeball_vox_outro_s5";
			var_d503d5d9 = "event_high_impact";
			break;
		}
	}
	self playsound(var_d66d7d37);
	level thread scene::stop(#"p8_fxanim_zm_zod_skybox_bundle");
	level util::delay(0.2, undefined, &scene::play, #"p8_fxanim_zm_zod_skybox_bundle", var_d503d5d9);
	self thread scene::play(self.str_scene, "pain", self);
	level thread function_f74b38da("zm_power_on_rumble");
	n_wait = 0.6 * getanimlength(#"hash_24f221de31f87832");
	wait(n_wait);
	if(var_5839811b != 5)
	{
		level thread namespace_74905749::function_63a0f09e(1, 0);
		self function_20c99a47(1);
		self clientfield::set("bs_bdy_fx_cf", 2);
		wait(0.5);
		level clientfield::set("bs_gr_fog_fx_cf", 0);
		self clientfield::set("bs_bdy_dmg_fx_cf", 0);
		foreach(e_player in level.players)
		{
			e_player clientfield::set("bs_player_snow_cf", 0);
		}
		self.origin = self.origin - vectorscale((0, 0, 1), 9999);
		self function_8e49143c();
		if(isdefined(self.var_29b322f2))
		{
			array::remove_undefined(self.var_29b322f2);
			if(self.var_29b322f2.size > 0)
			{
				wait(5);
			}
		}
		wait(5);
	}
	else
	{
		level thread scene::init_streamer(#"cin_zm_zod_outro", level.teams[#"allies"]);
		level thread lui::screen_flash(0.33, 0.33, 0.33, 0.8, "white");
		level thread scene::stop(#"p8_fxanim_zm_zod_skybox_bundle");
		level util::delay(0.2, undefined, &scene::play, #"p8_fxanim_zm_zod_skybox_bundle", var_d503d5d9);
		self clientfield::set("bs_bdy_fx_cf", 2);
		self clientfield::increment("bs_dth_fx_cf", 1);
		self scene::play(self.str_scene, "death", self);
		wait(1);
		level thread lui::screen_fade_out(10, "white");
		wait(10);
		self function_141c7d46();
		level clientfield::set("bs_gr_fog_fx_cf", 0);
		self clientfield::set("bs_bdy_dmg_fx_cf", 0);
		foreach(e_player in level.players)
		{
			e_player clientfield::set("bs_player_snow_cf", 0);
		}
		util::wait_network_frame();
		level notify(#"hash_38f29f9cb03586ea");
		self.var_a6ed9e82 delete();
		self delete();
	}
	/#
		iprintlnbold("" + var_5839811b + "");
	#/
}

/*
	Name: function_ee223250
	Namespace: namespace_8139f49c
	Checksum: 0x64CA84BA
	Offset: 0x6628
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function function_ee223250(var_bcccab17)
{
	for(var_aae7efaa = 0; var_aae7efaa < var_bcccab17; var_aae7efaa++)
	{
		level waittill(#"hash_3a4456148ade383a");
	}
	level notify(#"hash_38f29f9cb03586ea");
}

/*
	Name: function_abbfbdff
	Namespace: namespace_8139f49c
	Checksum: 0xEDFC1DBD
	Offset: 0x6688
	Size: 0xEC
	Parameters: 2
	Flags: Linked
*/
function function_abbfbdff(var_3608d414, n_delay)
{
	if(isdefined(n_delay))
	{
		wait(n_delay);
	}
	if(isplayer(self))
	{
		var_ee033f8 = self;
	}
	else
	{
		var_ee033f8 = array::random(namespace_891c9bac::function_347f7d34());
		if(!isdefined(var_ee033f8))
		{
			return;
		}
	}
	if(!isdefined(var_3608d414))
	{
		var_3608d414 = [];
	}
	else if(!isarray(var_3608d414))
	{
		var_3608d414 = array(var_3608d414);
	}
	str_vo_line = array::random(var_3608d414);
	var_ee033f8 thread namespace_891c9bac::function_a2bd5a0c(str_vo_line);
}

/*
	Name: function_bb612e31
	Namespace: namespace_8139f49c
	Checksum: 0x361286E2
	Offset: 0x6780
	Size: 0x14C
	Parameters: 4
	Flags: Linked
*/
function function_bb612e31(var_23cac703, var_59cdb7b9, var_c962047c, var_890ce7a8 = 1)
{
	level thread function_2b6b4a44();
	var_2aaf6cdb = 0.5;
	foreach(player in level.activeplayers)
	{
		var_2aaf6cdb = var_2aaf6cdb + 0.5;
	}
	self.var_59cdb7b9 = var_2aaf6cdb * var_59cdb7b9;
	if(var_c962047c > 0)
	{
		self.var_c962047c = var_2aaf6cdb * var_c962047c;
	}
	else
	{
		self.var_c962047c = -1;
	}
	if(var_23cac703.size > 0)
	{
		self thread function_542eeaa7(var_23cac703, var_890ce7a8);
	}
	level waittill(#"hash_38f29f9cb03586ea");
}

/*
	Name: function_1e93034e
	Namespace: namespace_8139f49c
	Checksum: 0xA5502BFD
	Offset: 0x68D8
	Size: 0x1C6
	Parameters: 1
	Flags: Linked
*/
function function_1e93034e(str_loc)
{
	self.var_29b322f2 = [];
	var_43a9d923 = struct::get("bs_pup_fa_" + str_loc, "targetname");
	var_906d3e2a = zm_powerups::specific_powerup_drop("full_ammo", var_43a9d923.origin, undefined, undefined, undefined, 1);
	if(!isdefined(self.var_29b322f2))
	{
		self.var_29b322f2 = [];
	}
	else if(!isarray(self.var_29b322f2))
	{
		self.var_29b322f2 = array(self.var_29b322f2);
	}
	self.var_29b322f2[self.var_29b322f2.size] = var_906d3e2a;
	var_78a8b445 = struct::get("bs_pup_crpn_" + str_loc, "targetname");
	var_ea90642e = zm_powerups::specific_powerup_drop("carpenter", var_78a8b445.origin, undefined, undefined, undefined, 1);
	if(!isdefined(self.var_29b322f2))
	{
		self.var_29b322f2 = [];
	}
	else if(!isarray(self.var_29b322f2))
	{
		self.var_29b322f2 = array(self.var_29b322f2);
	}
	self.var_29b322f2[self.var_29b322f2.size] = var_ea90642e;
}

/*
	Name: function_141c7d46
	Namespace: namespace_8139f49c
	Checksum: 0xFB098F0A
	Offset: 0x6AA8
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_141c7d46()
{
	if(!isdefined(self.var_29b322f2))
	{
		return;
	}
	foreach(var_7d81025 in self.var_29b322f2)
	{
		if(isdefined(var_7d81025))
		{
			var_7d81025 delete();
		}
	}
}

/*
	Name: function_71f63a19
	Namespace: namespace_8139f49c
	Checksum: 0x4CE361E4
	Offset: 0x6B40
	Size: 0x1D0
	Parameters: 1
	Flags: Linked
*/
function function_71f63a19(str_loc)
{
	var_a6a5b18e = struct::get_array("bs_att_mst_" + str_loc, "targetname");
	if(var_a6a5b18e.size > 0)
	{
		self.var_48b3f539 = [];
		var_a6a5b18e = array::sort_by_script_int(var_a6a5b18e, 1);
		var_20920e30 = 0;
		self.var_48b3f539[var_20920e30] = [];
		for(i = 0; i < var_a6a5b18e.size; i++)
		{
			if(!isdefined(self.var_48b3f539[var_20920e30]))
			{
				self.var_48b3f539[var_20920e30] = [];
			}
			if(!isdefined(self.var_48b3f539[var_20920e30]))
			{
				self.var_48b3f539[var_20920e30] = [];
			}
			else if(!isarray(self.var_48b3f539[var_20920e30]))
			{
				self.var_48b3f539[var_20920e30] = array(self.var_48b3f539[var_20920e30]);
			}
			self.var_48b3f539[var_20920e30][self.var_48b3f539[var_20920e30].size] = var_a6a5b18e[i];
			if(isdefined(var_a6a5b18e[i + 1]))
			{
				if(var_a6a5b18e[i].script_int != var_a6a5b18e[i + 1].script_int)
				{
					var_20920e30++;
				}
			}
		}
	}
}

/*
	Name: function_1b11b43
	Namespace: namespace_8139f49c
	Checksum: 0x92F77952
	Offset: 0x6D18
	Size: 0x2EA
	Parameters: 2
	Flags: Linked
*/
function function_1b11b43(str_loc, var_765a63f)
{
	self.var_3c63665 = [];
	var_ef1960a9 = struct::get_array("bs_att_bm_" + str_loc, "targetname");
	if(isdefined(var_765a63f))
	{
		var_dde77388 = struct::get_array("bs_att_bm_" + var_765a63f, "targetname");
		var_ef1960a9 = arraycombine(var_ef1960a9, var_dde77388, 0, 0);
	}
	var_ef1960a9 = array::filter(var_ef1960a9, 0, &function_c0e39137);
	if(var_ef1960a9.size > 0)
	{
		var_ef1960a9 = array::sort_by_script_int(var_ef1960a9, 1);
		for(i = 0; i < var_ef1960a9.size; i++)
		{
			var_2a64b584 = var_ef1960a9[i];
			self.var_3c63665[i] = [];
			if(!isdefined(self.var_3c63665[i]))
			{
				self.var_3c63665[i] = [];
			}
			else if(!isarray(self.var_3c63665[i]))
			{
				self.var_3c63665[i] = array(self.var_3c63665[i]);
			}
			self.var_3c63665[i][self.var_3c63665[i].size] = var_2a64b584;
			while(isdefined(var_2a64b584.linkto))
			{
				var_2a64b584 = struct::get(var_2a64b584.linkto, "linkname");
				if(!isdefined(self.var_3c63665[i]))
				{
					self.var_3c63665[i] = [];
				}
				else if(!isarray(self.var_3c63665[i]))
				{
					self.var_3c63665[i] = array(self.var_3c63665[i]);
				}
				self.var_3c63665[i][self.var_3c63665[i].size] = var_2a64b584;
			}
		}
	}
	self.var_e6621b81 = getentarray("bs_att_bm_vol_" + str_loc, "targetname");
}

/*
	Name: function_c0e39137
	Namespace: namespace_8139f49c
	Checksum: 0xCADF7976
	Offset: 0x7010
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_c0e39137(e_ent)
{
	return !isdefined(e_ent.linkname);
}

/*
	Name: function_bb528a4b
	Namespace: namespace_8139f49c
	Checksum: 0x6F85A4B4
	Offset: 0x7038
	Size: 0x474
	Parameters: 0
	Flags: Linked
*/
function function_bb528a4b()
{
	level endon(#"hash_38f29f9cb03586ea", #"intermission");
	self notify("541847c2acc31617");
	self endon("541847c2acc31617");
	var_2721aeff = 0;
	self.var_18acfe18 = 0;
	if(!isdefined(self.var_c962047c) || self.var_c962047c <= 0)
	{
		var_bdcf6288 = 1;
	}
	else
	{
		var_bdcf6288 = 0;
		var_97cf344e = 3;
		if(!isdefined(self.var_914750d))
		{
			self.var_914750d = 0;
			var_97cf344e = var_97cf344e - 1;
		}
		var_3b922743 = self.var_c962047c / 4;
		if(!isdefined(self.var_6a30a892))
		{
			self.var_6a30a892 = var_3b922743;
		}
	}
	while(true)
	{
		var_2cf6a874 = 0;
		var_385703b7 = undefined;
		var_385703b7 = self.var_a6ed9e82 waittill(#"damage");
		n_damage = var_385703b7.amount;
		w_weapon = var_385703b7.weapon;
		if(isdefined(w_weapon) && zm_weapons::is_wonder_weapon(w_weapon))
		{
			n_damage = n_damage * 0.1;
		}
		if(isalive(var_385703b7.attacker) && isplayer(var_385703b7.attacker))
		{
			var_385703b7.attacker util::show_hit_marker();
			if(var_385703b7.attacker hasperk(#"hash_6afc24062d2515a2"))
			{
				n_damage = int(n_damage * 1.1);
			}
		}
		self.var_18acfe18 = self.var_18acfe18 + n_damage;
		if(isdefined(self.var_59cdb7b9) && self.var_59cdb7b9 > 0 && self.var_18acfe18 >= self.var_59cdb7b9)
		{
			/#
				iprintlnbold("");
			#/
			var_2cf6a874 = 1;
			self function_26e02ac9(0);
			util::wait_network_frame();
		}
		if(!var_bdcf6288)
		{
			self.var_57badb98 = self.var_57badb98 + n_damage;
			if(self.var_914750d < var_97cf344e && self.var_57badb98 > self.var_6a30a892)
			{
				self.var_914750d++;
				self.var_6a30a892 = self.var_6a30a892 + var_3b922743;
				var_2cf6a874 = 1;
				self.var_e21ca032 = &function_c85b83f3;
			}
			if(self.var_57badb98 >= self.var_c962047c)
			{
				var_2cf6a874 = 1;
				var_2721aeff = 1;
			}
		}
		if(var_2cf6a874)
		{
			level notify(#"hash_14400d2bff068132");
			if(var_2721aeff)
			{
				self.var_914750d = undefined;
				self.var_6a30a892 = undefined;
				level notify(#"hash_38f29f9cb03586ea");
			}
			else
			{
				function_abbfbdff(level.var_73f9d759, 0.5);
				playsoundatposition(#"hash_6040f3b85932670c", self.origin);
				self scene::play(self.str_scene, "pain", self);
				level thread function_f74b38da("zm_power_on_rumble");
			}
			break;
		}
	}
}

/*
	Name: function_c85b83f3
	Namespace: namespace_8139f49c
	Checksum: 0xA71889FB
	Offset: 0x74B8
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_c85b83f3()
{
	if(!isdefined(self.var_914750d))
	{
		self.var_914750d = 0;
	}
	if(self.mdl_base == #"hash_32a51dafb1c7344f")
	{
		if(self.var_914750d == 2)
		{
			self function_3d8879d7("crack");
		}
		else
		{
			self function_3d8879d7("break");
		}
	}
	else if(self.mdl_base == #"hash_678aaf8e37498e9a")
	{
		if(self.var_914750d == 1)
		{
			self function_3d8879d7("crack");
		}
		else
		{
			self function_3d8879d7("break");
		}
	}
}

/*
	Name: function_26e02ac9
	Namespace: namespace_8139f49c
	Checksum: 0x444153B0
	Offset: 0x75B0
	Size: 0xEA
	Parameters: 1
	Flags: Linked
*/
function function_26e02ac9(b_show)
{
	if(isdefined(b_show) && b_show)
	{
		self clientfield::set("bs_bdy_fx_cf", 0);
		self.var_a6ed9e82 solid();
		target_set(self);
	}
	else
	{
		self clientfield::set("bs_bdy_fx_cf", 1);
		self.var_a6ed9e82 notsolid();
		if(target_istarget(self))
		{
			target_remove(self);
		}
	}
	self.var_ad1388ef = b_show;
}

/*
	Name: function_6fa7a16a
	Namespace: namespace_8139f49c
	Checksum: 0x6BE705CA
	Offset: 0x76A8
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function function_6fa7a16a(var_23cac703)
{
	level endon(#"intermission");
	level thread function_c8f90603("bs_blkr_stg_" + "pd", 1);
	level thread function_2b6b4a44();
	self function_a55a0339("pd");
	var_2aaf6cdb = 0.5;
	foreach(player in level.activeplayers)
	{
		var_2aaf6cdb = var_2aaf6cdb + 0.5;
	}
	self.var_7954bf70 = var_2aaf6cdb * 10000;
	self.var_ba36376c = var_2aaf6cdb * 25000;
	self.var_f881e30f = var_2aaf6cdb * 18000;
	self.var_6efcc8c1 = 0;
	self thread function_542eeaa7(var_23cac703);
	level waittill(#"hash_38f29f9cb03586ea");
}

/*
	Name: function_3d6eaad5
	Namespace: namespace_8139f49c
	Checksum: 0x9EEE51AD
	Offset: 0x7830
	Size: 0x374
	Parameters: 0
	Flags: Linked
*/
function function_3d6eaad5()
{
	level endon(#"hash_38f29f9cb03586ea", #"hash_14400d2bff068132", #"intermission");
	self notify("470dfc850103a920");
	self endon("470dfc850103a920");
	self.var_18acfe18 = 0;
	var_7350b8a6 = 0;
	while(true)
	{
		var_2cf6a874 = 0;
		var_385703b7 = undefined;
		var_385703b7 = self.var_a6ed9e82 waittill(#"damage");
		n_damage = var_385703b7.amount;
		w_weapon = var_385703b7.weapon;
		if(isdefined(w_weapon) && zm_weapons::is_wonder_weapon(w_weapon))
		{
			n_damage = n_damage * 0.1;
		}
		if(isalive(var_385703b7.attacker) && isplayer(var_385703b7.attacker))
		{
			var_385703b7.attacker util::show_hit_marker();
			if(var_385703b7.attacker hasperk(#"hash_6afc24062d2515a2"))
			{
				n_damage = int(n_damage * 1.1);
			}
		}
		self.var_18acfe18 = self.var_18acfe18 + n_damage;
		if(self.var_18acfe18 >= self.var_7954bf70)
		{
			/#
				iprintlnbold("");
			#/
			self function_26e02ac9(0);
			var_2cf6a874 = 1;
			util::wait_network_frame();
		}
		self.var_57badb98 = self.var_57badb98 + n_damage;
		if(self.var_57badb98 >= self.var_ba36376c)
		{
			/#
				iprintlnbold("");
			#/
			self.var_575f3097 = 1;
			self.var_57badb98 = 0;
			self function_26e02ac9(0);
			var_2cf6a874 = 1;
			var_7350b8a6 = 1;
		}
		if(var_2cf6a874)
		{
			level notify(#"hash_14400d2bff068132");
			if(!var_7350b8a6)
			{
				function_abbfbdff(level.var_73f9d759, 0.5);
				playsoundatposition(#"hash_6040f3b85932670c", self.origin);
				self scene::play(self.str_scene, "pain", self);
				level thread function_f74b38da("zm_power_on_rumble");
			}
			break;
		}
	}
}

/*
	Name: function_ae4a013d
	Namespace: namespace_8139f49c
	Checksum: 0xAEF664C4
	Offset: 0x7BB0
	Size: 0x2E0
	Parameters: 0
	Flags: Linked
*/
function function_ae4a013d()
{
	level endon(#"hash_38f29f9cb03586ea", #"hash_2e4b6b86e99b024b", #"intermission");
	self.var_18acfe18 = 0;
	var_8ce07a9c = 0;
	var_7350b8a6 = 0;
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self.var_a6ed9e82 waittill(#"damage");
		n_damage = var_385703b7.amount;
		if(isalive(var_385703b7.attacker) && isplayer(var_385703b7.attacker))
		{
			var_385703b7.attacker util::show_hit_marker();
			if(var_385703b7.attacker hasperk(#"hash_6afc24062d2515a2"))
			{
				n_damage = int(n_damage * 1.1);
			}
		}
		self.var_18acfe18 = self.var_18acfe18 + n_damage;
		if(self.var_18acfe18 >= self.var_f881e30f)
		{
			/#
				iprintlnbold("");
			#/
			self function_26e02ac9(0);
			util::wait_network_frame();
			self.var_6efcc8c1++;
			if(self.var_6efcc8c1 >= 3)
			{
				var_8ce07a9c = 1;
				var_7350b8a6 = 0;
			}
			self clientfield::set("bs_att_blst_tll", 0);
			level notify(#"hash_14400d2bff068132");
			if(!var_7350b8a6)
			{
				self.var_914750d++;
				self scene::play(self.str_scene, "pain", self);
				level thread function_f74b38da("zm_power_on_rumble");
				playsoundatposition(#"hash_6040f3b85932670c", self.origin);
				self.var_e21ca032 = &function_d775bddd;
			}
			if(var_8ce07a9c)
			{
				level notify(#"hash_38f29f9cb03586ea");
			}
			break;
		}
	}
}

/*
	Name: function_d775bddd
	Namespace: namespace_8139f49c
	Checksum: 0x70CE2D57
	Offset: 0x7E98
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_d775bddd()
{
	if(!isdefined(self.var_914750d))
	{
		self.var_914750d = 0;
	}
	if(self.var_914750d == 2)
	{
		self function_3d8879d7("crack");
	}
	else if(self.var_914750d == 3)
	{
		self function_3d8879d7("break");
	}
}

/*
	Name: function_542eeaa7
	Namespace: namespace_8139f49c
	Checksum: 0x796FE52
	Offset: 0x7F20
	Size: 0x150
	Parameters: 2
	Flags: Linked
*/
function function_542eeaa7(var_23cac703, var_890ce7a8 = 1)
{
	level endon(#"hash_38f29f9cb03586ea", #"intermission");
	self function_26e02ac9(0);
	self.var_57badb98 = 0;
	var_a4d5d85c = 0;
	while(true)
	{
		if(!(isdefined(self.var_575f3097) && self.var_575f3097))
		{
			wait(randomfloatrange(9, 13));
		}
		if(var_890ce7a8 && (!(isdefined(self.var_575f3097) && self.var_575f3097)))
		{
			self function_671e8d37();
		}
		self function_bb28e41d(var_23cac703, var_a4d5d85c);
		if(var_a4d5d85c + 1 >= var_23cac703.size)
		{
			var_a4d5d85c = 0;
		}
		else
		{
			var_a4d5d85c++;
		}
		if(var_890ce7a8)
		{
			self function_a8a76e18();
		}
	}
}

/*
	Name: function_20c99a47
	Namespace: namespace_8139f49c
	Checksum: 0xC3AA8D84
	Offset: 0x8078
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_20c99a47(var_db828ea6 = 0)
{
	self animation::stop(0);
	v_pos = self.origin;
	if(var_db828ea6)
	{
		playsoundatposition(#"hash_e2ba9305b1dafc9", v_pos);
	}
	else
	{
		playsoundatposition(#"hash_1b108a99d8b8a77e", v_pos);
	}
	self thread function_55841cbf("bs_spn_fx_cf", 0, "bs_bdy_fx_cf", 2, 3, "bs_bdy_dmg_fx_cf", 0);
	self scene::play(self.str_scene, self.str_depart, self);
	self animation::stop(0);
	if(!var_db828ea6)
	{
		self ghost();
	}
}

/*
	Name: function_8e49143c
	Namespace: namespace_8139f49c
	Checksum: 0x7F599985
	Offset: 0x81B8
	Size: 0x1F4
	Parameters: 1
	Flags: Linked
*/
function function_8e49143c(var_dc094f99 = 0)
{
	util::wait_network_frame();
	v_pos = self.origin;
	if(var_dc094f99)
	{
		playsoundatposition(#"hash_732b71cd63845865", v_pos);
	}
	else
	{
		playsoundatposition(#"hash_241b296b37ac90bf", v_pos);
	}
	var_193df069 = undefined;
	var_914750d = undefined;
	if(isdefined(self.var_914750d) && self.var_914750d > 0)
	{
		var_193df069 = "bs_bdy_dmg_fx_cf";
		var_914750d = self.var_914750d;
	}
	self thread function_55841cbf("bs_spn_fx_cf", 1, "bs_bdy_fx_cf", 1, 3, var_193df069, var_914750d);
	self clientfield::set("bs_spn_fx_cf", 1);
	self util::delay(0.1, "death", &function_10df7fb6);
	self scene::play(self.str_scene, self.str_arrive, self);
	self animation::stop(0);
	self clientfield::set("bs_bdy_fx_cf", 1);
	self thread scene::play(self.str_scene, self.str_idle, self);
}

/*
	Name: function_10df7fb6
	Namespace: namespace_8139f49c
	Checksum: 0xB3A2D0E4
	Offset: 0x83B8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_10df7fb6()
{
	self show();
}

/*
	Name: function_55841cbf
	Namespace: namespace_8139f49c
	Checksum: 0x544FD57A
	Offset: 0x83E0
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_55841cbf(var_2cab862a, var_b5cb2fdb, var_73d99491, var_2f44a2c, n_frames, var_8218310e, var_1f94836c)
{
	self clientfield::set(var_2cab862a, var_b5cb2fdb);
	util::wait_network_frame(n_frames);
	self clientfield::set(var_73d99491, var_2f44a2c);
	if(isdefined(var_8218310e) && isdefined(var_1f94836c))
	{
		self clientfield::set(var_8218310e, var_1f94836c);
	}
}

/*
	Name: function_a8a76e18
	Namespace: namespace_8139f49c
	Checksum: 0x358C44FA
	Offset: 0x84A0
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_a8a76e18(var_dc094f99 = 0)
{
	self function_20c99a47();
	if(isdefined(self.var_e21ca032))
	{
		[[self.var_e21ca032]]();
		self.var_e21ca032 = undefined;
	}
	self.var_451ab1a6 = 0;
	self.origin = self.var_431d02e5.origin;
	self.angles = self.var_431d02e5.angles;
	self function_8e49143c(var_dc094f99);
}

/*
	Name: function_671e8d37
	Namespace: namespace_8139f49c
	Checksum: 0xD2BA68CF
	Offset: 0x8550
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_671e8d37()
{
	self function_20c99a47();
	self.var_451ab1a6 = self.n_path_start;
	self.origin = self.var_86698449[self.var_451ab1a6].origin;
	self.angles = self.var_86698449[self.var_451ab1a6].angles;
	self function_8e49143c();
}

/*
	Name: function_ead65ea1
	Namespace: namespace_8139f49c
	Checksum: 0x2C74D9C1
	Offset: 0x85D8
	Size: 0x210
	Parameters: 2
	Flags: Linked
*/
function function_ead65ea1(var_31a7a68f, var_6eabe8dd = 1)
{
	level endon(#"intermission");
	if(self.var_86698449.size == 1)
	{
		return;
	}
	if(self.var_451ab1a6 == var_31a7a68f)
	{
		return;
	}
	if(var_6eabe8dd)
	{
		var_6c1749ec = 3;
	}
	else
	{
		var_6c1749ec = 2;
	}
	while(self.var_451ab1a6 != var_31a7a68f)
	{
		if(self.var_451ab1a6 > var_31a7a68f)
		{
			for(i = 1; i <= var_6c1749ec; i++)
			{
				if(self.var_451ab1a6 - i < var_31a7a68f)
				{
					break;
				}
				var_ac191c43 = i * -1;
			}
		}
		else
		{
			for(i = 1; i <= var_6c1749ec; i++)
			{
				if(self.var_451ab1a6 + i > var_31a7a68f)
				{
					break;
				}
				var_ac191c43 = i;
			}
		}
		self function_20c99a47();
		self.var_451ab1a6 = self.var_451ab1a6 + var_ac191c43;
		self.origin = self.var_86698449[self.var_451ab1a6].origin;
		self.angles = self.var_86698449[self.var_451ab1a6].angles;
		self function_8e49143c();
		if(self.var_451ab1a6 != var_31a7a68f)
		{
			if(!var_6eabe8dd)
			{
				wait(randomfloatrange(0.75, 1.25));
			}
			else
			{
				util::wait_network_frame(4);
			}
		}
	}
}

/*
	Name: function_bb28e41d
	Namespace: namespace_8139f49c
	Checksum: 0x6EFA314F
	Offset: 0x87F0
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function function_bb28e41d(var_23cac703, var_a4d5d85c)
{
	level endon(#"intermission");
	if(isdefined(self.var_575f3097) && self.var_575f3097)
	{
		self.var_575f3097 = 0;
		self function_1acc1d3();
	}
	else
	{
		self [[var_23cac703[var_a4d5d85c]]]();
	}
	level notify(#"hash_14400d2bff068132");
	self function_26e02ac9(0);
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_371e0929
	Namespace: namespace_8139f49c
	Checksum: 0x36E9B1D
	Offset: 0x88C0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_371e0929()
{
	level endon(#"intermission");
	self thread function_ff69c896();
	self function_c7c928e9();
}

/*
	Name: function_f487ff16
	Namespace: namespace_8139f49c
	Checksum: 0x65402F45
	Offset: 0x8910
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_f487ff16()
{
	level endon(#"intermission");
	self thread function_ff69c896();
	self function_c7c928e9(1);
}

/*
	Name: function_ff69c896
	Namespace: namespace_8139f49c
	Checksum: 0x37135803
	Offset: 0x8960
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_ff69c896()
{
	level endon(#"hash_14400d2bff068132", #"intermission");
	/#
		iprintlnbold("");
	#/
	var_34f21704 = array::random(self.var_48b3f539);
	self clientfield::set("bs_att_mst_tell_cf", 1);
	foreach(var_cbd5f8e3 in var_34f21704)
	{
		self thread function_47073904(var_cbd5f8e3.origin);
		util::wait_network_frame();
	}
	wait(6);
	self clientfield::set("bs_att_mst_tell_cf", 0);
}

/*
	Name: function_47073904
	Namespace: namespace_8139f49c
	Checksum: 0x4EBCD1F0
	Offset: 0x8AA0
	Size: 0x298
	Parameters: 2
	Flags: Linked
*/
function function_47073904(v_loc, n_time = 8)
{
	level endon(#"intermission");
	e_target = util::spawn_model("tag_origin", v_loc);
	util::wait_network_frame();
	e_target clientfield::set("bs_att_mst_cf", 1);
	e_target thread function_65bd10f6();
	wait(1);
	n_time_passed = 0;
	while(n_time_passed <= n_time)
	{
		a_players = util::get_active_players();
		a_players = arraysortclosest(a_players, v_loc, undefined, undefined, 128);
		foreach(player in a_players)
		{
			player thread zm_player::slowdown(#"hash_2cc0dfb628810e41");
		}
		a_ai_zombies = array::get_all_closest(v_loc, getaiarchetypearray(#"zombie"), undefined, undefined, 128);
		foreach(ai_zombie in a_ai_zombies)
		{
			if(!ai_zombie namespace_83bc53d2::function_50a8406d())
			{
				ai_zombie thread namespace_83bc53d2::function_e5e8cbd2(0);
			}
		}
		wait(0.1);
		n_time_passed = n_time_passed + 0.1;
	}
	level notify(#"hash_738991c86bf9f7c2");
}

/*
	Name: function_65bd10f6
	Namespace: namespace_8139f49c
	Checksum: 0x8B5D9B62
	Offset: 0x8D40
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_65bd10f6()
{
	level waittill(#"hash_38f29f9cb03586ea", #"hash_738991c86bf9f7c2", #"intermission");
	self clientfield::set("bs_att_mst_cf", 0);
	util::wait_network_frame(4);
	self delete();
}

/*
	Name: function_c7c928e9
	Namespace: namespace_8139f49c
	Checksum: 0xB01D58DA
	Offset: 0x8DD8
	Size: 0x1C4
	Parameters: 3
	Flags: Linked
*/
function function_c7c928e9(var_a3d1842b = 0, var_6df65756 = 0, var_601f90f8)
{
	level endon(#"hash_14400d2bff068132", #"intermission");
	/#
		iprintlnbold("");
	#/
	level thread function_7e30d4b5();
	var_b7ba41fc = [];
	if(isdefined(var_601f90f8))
	{
		n_path = var_601f90f8;
	}
	else if(self.var_e6621b81.size > 0)
	{
		n_path = self function_5382ba1b(self.var_e6621b81);
	}
	else
	{
		n_path = randomint(self.var_3c63665.size);
	}
	var_b7ba41fc = self.var_3c63665[n_path];
	level.var_6c390c77 thread function_c48e93c1(n_path);
	var_31a7a68f = var_b7ba41fc[0].script_int;
	self function_ead65ea1(var_31a7a68f);
	if(var_a3d1842b)
	{
		self thread function_3d6eaad5();
	}
	else if(!var_6df65756)
	{
		self thread function_bb528a4b();
	}
	self function_d07ce2a9(n_path, var_a3d1842b, var_6df65756);
}

/*
	Name: function_5382ba1b
	Namespace: namespace_8139f49c
	Checksum: 0xBB6326D9
	Offset: 0x8FA8
	Size: 0x1E6
	Parameters: 1
	Flags: Linked
*/
function function_5382ba1b(var_9a28a0c8)
{
	var_9a28a0c8 = array::randomize(var_9a28a0c8);
	var_28f5cd30 = var_9a28a0c8[0];
	var_8adde38a = 0;
	foreach(e_vol in var_9a28a0c8)
	{
		var_f14d7e9d = var_8adde38a;
		var_8adde38a = 0;
		foreach(player in level.activeplayers)
		{
			if(player istouching(e_vol))
			{
				var_8adde38a++;
			}
		}
		if(var_8adde38a > var_f14d7e9d)
		{
			var_28f5cd30 = e_vol;
		}
	}
	/#
		assert(isdefined(var_28f5cd30.script_int));
	#/
	var_2370b91b = var_28f5cd30.script_int;
	for(i = 0; i < self.var_3c63665.size; i++)
	{
		if(self.var_3c63665[i][0].script_int == var_2370b91b)
		{
			return i;
		}
	}
	return 0;
}

/*
	Name: function_c48e93c1
	Namespace: namespace_8139f49c
	Checksum: 0x8706827A
	Offset: 0x9198
	Size: 0x260
	Parameters: 1
	Flags: Linked
*/
function function_c48e93c1(n_path)
{
	if(!isdefined(self.var_ba0b1919))
	{
		return;
	}
	var_1e908ff2 = [];
	var_8830daf3 = "bs_att_bm_ai_blck_" + self.var_ba0b1919;
	var_dc3827e3 = array::sort_by_script_int(getentarray(var_8830daf3, "script_blocker"), 1);
	foreach(e_blocker in var_dc3827e3)
	{
		if(e_blocker.script_int == n_path)
		{
			if(!isdefined(var_1e908ff2))
			{
				var_1e908ff2 = [];
			}
			else if(!isarray(var_1e908ff2))
			{
				var_1e908ff2 = array(var_1e908ff2);
			}
			var_1e908ff2[var_1e908ff2.size] = e_blocker;
			e_blocker solid();
			e_blocker show();
			e_blocker disconnectpaths();
		}
	}
	level waittill(#"hash_38f29f9cb03586ea", #"hash_ba0b98df6573d80", #"intermission");
	if(isdefined(var_1e908ff2))
	{
		foreach(e_blocker in var_1e908ff2)
		{
			e_blocker notsolid();
			e_blocker hide();
			e_blocker connectpaths();
		}
	}
}

/*
	Name: function_7e30d4b5
	Namespace: namespace_8139f49c
	Checksum: 0x55532296
	Offset: 0x9400
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_7e30d4b5()
{
	level waittill(#"hash_38f29f9cb03586ea", #"hash_14400d2bff068132", #"hash_ba0b98df6573d80", #"intermission");
	level.var_6c390c77 function_26e02ac9(0);
	level.var_6c390c77 clientfield::set("bs_att_bm_tell_fx_cf", 0);
	level.var_6c390c77 clientfield::set("bs_att_bm_cf", 0);
	level.var_6c390c77 clientfield::set("bs_att_mst_tell_cf", 0);
	level.var_6c390c77 notify(#"hash_2bb8be6b846aed93");
}

/*
	Name: function_3413fdf9
	Namespace: namespace_8139f49c
	Checksum: 0xAB1B07FD
	Offset: 0x94F0
	Size: 0x10A
	Parameters: 2
	Flags: Linked
*/
function function_3413fdf9(v_loc, n_time)
{
	level endon(#"hash_14400d2bff068132", #"intermission");
	if(!isdefined(level.var_90bda347))
	{
		level.var_90bda347 = util::spawn_model("tag_origin", v_loc);
		util::wait_network_frame(4);
		level.var_90bda347 clientfield::set("bs_att_bm_targ_ini_cf", 1);
		util::wait_network_frame(4);
	}
	if(isdefined(n_time))
	{
		level.var_90bda347 moveto(v_loc, n_time);
		wait(n_time);
	}
	else
	{
		level.var_90bda347.origin = v_loc;
	}
}

/*
	Name: function_d07ce2a9
	Namespace: namespace_8139f49c
	Checksum: 0x8DC02CC4
	Offset: 0x9608
	Size: 0x3B0
	Parameters: 3
	Flags: Linked
*/
function function_d07ce2a9(n_path_id, var_a3d1842b, var_6df65756)
{
	level endon(#"hash_14400d2bff068132", #"intermission");
	/#
		assert(isdefined(self.var_3c63665));
	#/
	v_loc = self.var_3c63665[n_path_id][0].origin;
	var_5b84ed9a = self gettagorigin("tag_fx_beam");
	var_23ee4083 = vectortoangles(v_loc - self.origin);
	v_forward = anglestoforward(var_23ee4083);
	a_trace = beamtrace(var_5b84ed9a, var_5b84ed9a + v_forward * 20000, 0, self, 1, 1);
	var_dd6e9876 = a_trace[#"position"];
	level function_3413fdf9(var_dd6e9876);
	self thread scene::play(self.str_scene, "charge", self);
	self clientfield::set("bs_att_bm_cf", 1);
	wait(1);
	self clientfield::set("bs_att_bm_tell_cf", 1);
	wait(0.4);
	self clientfield::set("bs_att_bm_tell_fx_cf", 1);
	wait(0.1);
	self clientfield::set("bs_att_bm_tell_cf", 2);
	self playsound(#"hash_2af120dbf3e870e8");
	self function_26e02ac9(1);
	if(!var_a3d1842b && randomint(100) > 30)
	{
		function_abbfbdff(array(level.var_d748689e, level.var_99d2b056));
	}
	/#
		self thread persistentdebugline(var_5b84ed9a, level.var_90bda347);
		render_debug_sphere(var_5b84ed9a, (1, 1, 0));
		render_debug_sphere(var_dd6e9876, (1, 0, 0));
	#/
	if(var_a3d1842b)
	{
		self thread function_9520ea39(1);
	}
	else if(var_6df65756)
	{
		self thread function_9520ea39(0, 1);
	}
	else
	{
		self thread function_9520ea39(0);
	}
	self function_f142f73c(n_path_id, var_a3d1842b, var_6df65756);
	level notify(#"hash_ba0b98df6573d80");
}

/*
	Name: function_f142f73c
	Namespace: namespace_8139f49c
	Checksum: 0x7CCC5FC
	Offset: 0x99C0
	Size: 0x2BE
	Parameters: 3
	Flags: Linked
*/
function function_f142f73c(var_1ee74d52, var_a3d1842b, var_6df65756)
{
	level endon(#"hash_14400d2bff068132", #"intermission");
	var_b68dd8d0 = [];
	var_a50ac7ec = 0;
	a_path = arraycopy(self.var_3c63665[var_1ee74d52]);
	var_d9ad5cc8 = a_path[0];
	while(isdefined(var_d9ad5cc8.linkto))
	{
		var_cd22b387 = var_d9ad5cc8.origin;
		var_d9ad5cc8 = struct::get(var_d9ad5cc8.linkto, "linkname");
		n_dist = distance(var_d9ad5cc8.origin, var_cd22b387);
		var_a50ac7ec = var_a50ac7ec + n_dist;
		if(!isdefined(var_b68dd8d0))
		{
			var_b68dd8d0 = [];
		}
		else if(!isarray(var_b68dd8d0))
		{
			var_b68dd8d0 = array(var_b68dd8d0);
		}
		var_b68dd8d0[var_b68dd8d0.size] = n_dist;
	}
	var_36e740de = [];
	if(var_6df65756)
	{
		n_total_time = 2;
	}
	else if(var_a3d1842b)
	{
		n_total_time = 7.5;
	}
	else
	{
		n_total_time = 9;
	}
	for(i = 0; i < var_b68dd8d0.size; i++)
	{
		n_time = n_total_time * var_b68dd8d0[i] / var_a50ac7ec;
		if(!isdefined(var_36e740de))
		{
			var_36e740de = [];
		}
		else if(!isarray(var_36e740de))
		{
			var_36e740de = array(var_36e740de);
		}
		var_36e740de[var_36e740de.size] = n_time;
	}
	for(i = 1; i < a_path.size; i++)
	{
		level function_3413fdf9(a_path[i].origin, var_36e740de[i - 1]);
	}
}

/*
	Name: function_9520ea39
	Namespace: namespace_8139f49c
	Checksum: 0xC6E32A78
	Offset: 0x9C88
	Size: 0xDB0
	Parameters: 2
	Flags: Linked
*/
function function_9520ea39(var_a3d1842b, var_6df65756 = 0)
{
	level endon(#"hash_14400d2bff068132", #"intermission");
	self endon(#"hash_2bb8be6b846aed93");
	while(true)
	{
		v_source = self gettagorigin("tag_fx_beam");
		v_target = level.var_90bda347.origin;
		var_fa879df8 = beamtrace(v_source, v_target, 0, self, 1, 1);
		var_f94546ed = distance(v_source, var_fa879df8[#"position"]);
		var_78d7b8bf = var_f94546ed * var_f94546ed;
		a_players = array::get_all_closest(v_source, level.players, undefined, undefined, var_f94546ed);
		if(a_players.size <= 0)
		{
			foreach(player in level.players)
			{
				player notify(#"hash_27a44c71de4b4cb8");
				player.var_39ef0b7f = 0;
			}
			util::wait_network_frame();
			continue;
		}
		var_fc0acaf1 = [];
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_helmet";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_head";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_neck";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_spine_upper";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_spine_lower";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_shoulder_le";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_shoulder_ri";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_spine4";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "tag_aim";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_elbow_le";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_elbow_ri";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_wrist_le";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_wrist_ri";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_hiptwist_le";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_hiptwist_ri";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_knee_bulge_le";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_knee_bulge_ri";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_ankle_le";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_ankle_ri";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_ball_le";
		if(!isdefined(var_fc0acaf1))
		{
			var_fc0acaf1 = [];
		}
		else if(!isarray(var_fc0acaf1))
		{
			var_fc0acaf1 = array(var_fc0acaf1);
		}
		var_fc0acaf1[var_fc0acaf1.size] = "j_ball_ri";
		var_aaa5649f = [];
		foreach(player in a_players)
		{
			if(zm_utility::is_player_valid(player) && !player issliding())
			{
				var_7cb315bb = player getcentroid();
				v_player_origin = player getorigin();
				var_67b0f6b1 = distancesquared(v_source, var_7cb315bb);
				var_cf64e11c = distancesquared(v_source, v_player_origin);
				var_3c71dedb = pointonsegmentnearesttopoint(v_source, v_target, var_7cb315bb);
				var_c526df5a = pointonsegmentnearesttopoint(v_source, v_target, v_player_origin);
				b_is_valid_target = 0;
				if(distancesquared(var_7cb315bb, var_3c71dedb) <= 324 || distancesquared(v_player_origin, var_c526df5a) <= 324)
				{
					b_is_valid_target = 1;
				}
				else
				{
					foreach(str_tag in var_fc0acaf1)
					{
						var_6732192d = player gettagorigin(str_tag);
						if(isdefined(var_6732192d))
						{
							var_4d9e2def = pointonsegmentnearesttopoint(v_source, v_target, var_6732192d);
							temp_dist = distancesquared(var_6732192d, var_4d9e2def);
							if(distancesquared(var_6732192d, var_4d9e2def) <= 324)
							{
								b_is_valid_target = 1;
								break;
							}
						}
					}
				}
			}
			if(isdefined(b_is_valid_target) && b_is_valid_target)
			{
				if(!isdefined(var_aaa5649f))
				{
					var_aaa5649f = [];
				}
				else if(!isarray(var_aaa5649f))
				{
					var_aaa5649f = array(var_aaa5649f);
				}
				var_aaa5649f[var_aaa5649f.size] = player;
			}
		}
		if(var_aaa5649f.size > 0)
		{
			foreach(player in var_aaa5649f)
			{
				if(!zm_utility::is_player_valid(player))
				{
					continue;
					continue;
				}
				if(isdefined(player))
				{
					if(var_6df65756)
					{
						if(!(isdefined(player.var_13e995b6) && player.var_13e995b6))
						{
							player thread function_d8d597c();
						}
						util::wait_network_frame();
						continue;
					}
					if(!(isdefined(player.var_39ef0b7f) && player.var_39ef0b7f))
					{
						player.var_39ef0b7f = 1;
						player thread function_583f7d85(var_a3d1842b);
					}
					player thread function_c542a237();
				}
			}
		}
		util::wait_network_frame();
	}
}

/*
	Name: function_d8d597c
	Namespace: namespace_8139f49c
	Checksum: 0x686B22C3
	Offset: 0xAA40
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_d8d597c()
{
	self endon(#"entering_last_stand", #"disconnect", #"death");
	self.var_13e995b6 = 1;
	self dodamage(25, self.origin);
	wait(2.5);
	self.var_13e995b6 = 0;
}

/*
	Name: function_c542a237
	Namespace: namespace_8139f49c
	Checksum: 0xF074D170
	Offset: 0xAAC0
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_c542a237()
{
	self notify("68b77673d8cf61f6");
	self endon("68b77673d8cf61f6");
	wait(0.3);
	if(isdefined(self))
	{
		self.var_39ef0b7f = 0;
		self clientfield::set("bs_att_bm_targ_hit_cf", 0);
		self notify(#"hash_27a44c71de4b4cb8");
	}
}

/*
	Name: function_583f7d85
	Namespace: namespace_8139f49c
	Checksum: 0x9106091D
	Offset: 0xAB38
	Size: 0x278
	Parameters: 1
	Flags: Linked
*/
function function_583f7d85(var_a3d1842b)
{
	level endon(#"hash_14400d2bff068132", #"intermission");
	self endon(#"hash_27a44c71de4b4cb8", #"disconnect");
	n_counter = 0;
	if(var_a3d1842b)
	{
		n_wait = 0.2;
	}
	else
	{
		n_wait = 0.3;
	}
	while(!(isdefined(self.var_49c233e) && self.var_49c233e) && self.var_39ef0b7f && zm_utility::is_player_valid(self))
	{
		if(n_counter == 0 && (!(isdefined(self.var_f6adf684) && self.var_f6adf684)))
		{
			self thread function_c010c5f2();
			self dodamage(25, self.origin);
			self clientfield::set("bs_att_bm_targ_hit_cf", 1);
		}
		else
		{
			self dodamage(10, self.origin);
			self clientfield::set("bs_att_bm_targ_hit_cf", 1);
		}
		if(n_counter < 4)
		{
			if(var_a3d1842b)
			{
				self thread zm_player::slowdown(#"hash_2a290908eb355917", 1 - n_wait);
			}
			else
			{
				self thread zm_player::slowdown(#"hash_532f7f688c86c9b1", 1 - n_wait);
			}
			wait(n_wait);
			n_wait = n_wait / 2;
			n_counter++;
		}
		else if(!(isdefined(self.var_49c233e) && self.var_49c233e))
		{
			self.var_49c233e = 1;
			self thread function_844b44a2();
			return;
		}
		wait(n_wait);
	}
}

/*
	Name: function_c010c5f2
	Namespace: namespace_8139f49c
	Checksum: 0xFEB5E963
	Offset: 0xADB8
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_c010c5f2()
{
	level endon(#"intermission");
	self notify("134819d3c344ebdd");
	self endon("134819d3c344ebdd");
	self endon(#"disconnect");
	self.var_f6adf684 = 1;
	wait(2);
	self.var_f6adf684 = 0;
}

/*
	Name: function_844b44a2
	Namespace: namespace_8139f49c
	Checksum: 0x7092DDB2
	Offset: 0xAE30
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function function_844b44a2()
{
	level endon(#"intermission");
	self notify("24a2fa7fb84676f3");
	self endon("24a2fa7fb84676f3");
	self endon(#"disconnect");
	self thread function_70123a1a();
	self thread zm_player::slowdown(#"hash_7d336706f2aeadab");
	self clientfield::set("bs_att_bm_targ_hit_cf", 0);
	self clientfield::set_to_player("bs_att_bm_targ_frz_fx_cf", 1);
	self allowjump(0);
	self util::delay(0.5, "death", &function_abbfbdff, level.var_2404b2a5);
	self waittill(#"entering_last_stand", #"hash_14ed4d12ee0b5984");
	self thread zm_player::slowdown(#"hash_7d336706f2aeadab", 1);
	self clientfield::set_to_player("bs_att_bm_targ_frz_fx_cf", 0);
	self allowjump(1);
}

/*
	Name: function_70123a1a
	Namespace: namespace_8139f49c
	Checksum: 0x5E7F23B
	Offset: 0xAFD0
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function function_70123a1a()
{
	level endon(#"intermission");
	self notify("7aed1f0026cbe559");
	self endon("7aed1f0026cbe559");
	self endon(#"disconnect", #"entering_last_stand");
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"weapon_melee", #"weapon_melee_power");
	self notify(#"hash_14ed4d12ee0b5984");
	self.var_49c233e = 0;
}

/*
	Name: render_debug_sphere
	Namespace: namespace_8139f49c
	Checksum: 0xF38200E2
	Offset: 0xB088
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function render_debug_sphere(origin, color)
{
	/#
		sphere(origin, 2, color, 0.75, 1, 10, 100);
	#/
}

/*
	Name: persistentdebugline
	Namespace: namespace_8139f49c
	Checksum: 0x3472570E
	Offset: 0xB0E0
	Size: 0xB0
	Parameters: 2
	Flags: None
*/
function persistentdebugline(start, end)
{
	/#
		level endon(#"hash_14400d2bff068132", #"newdebugline");
		self endon(#"hash_27a44c71de4b4cb8");
		level notify(#"newdebugline");
		for(;;)
		{
			line(start, end.origin, (0.3, 1, 0), 1);
			util::wait_network_frame();
		}
	#/
}

/*
	Name: function_1acc1d3
	Namespace: namespace_8139f49c
	Checksum: 0xB1C2D9BD
	Offset: 0xB198
	Size: 0x578
	Parameters: 0
	Flags: Linked
*/
function function_1acc1d3()
{
	level endon(#"hash_14400d2bff068132", #"intermission");
	n_time_started = gettime() / 1000;
	n_time_elapsed = 0;
	var_75c193e4 = 0;
	var_2d4cbeee = 0;
	var_b29f9af = 0;
	var_a74ef896 = 0;
	var_6b67821f = 0;
	var_b973dc14 = 0;
	/#
		iprintlnbold("");
	#/
	level thread function_bacc07e2();
	self function_a8a76e18();
	self thread function_ae4a013d();
	self function_26e02ac9(1);
	self clientfield::set("bs_att_blst_tll", 1);
	self thread function_e3f1b159();
	self playsound("zmb_eyeball_swrath_charge");
	self thread scene::play(self.str_scene, "charge_blast", self);
	while(n_time_elapsed < 15)
	{
		n_time_current = gettime() / 1000;
		n_time_elapsed = n_time_current - n_time_started;
		util::wait_network_frame();
		n_time_left = 15 - n_time_elapsed;
		if(!var_75c193e4 && n_time_left <= 12)
		{
			var_75c193e4 = 1;
			/#
				iprintlnbold("");
			#/
		}
		else if(!var_2d4cbeee && n_time_left <= 10)
		{
			var_2d4cbeee = 1;
			/#
				iprintlnbold("");
			#/
			function_abbfbdff(level.var_c7daa370);
		}
		else if(!var_b29f9af && n_time_left <= 5)
		{
			var_b29f9af = 1;
			/#
				iprintlnbold("");
			#/
		}
		else if(!var_a74ef896 && n_time_left <= 3)
		{
			var_a74ef896 = 1;
			/#
				iprintlnbold("");
			#/
		}
		else if(!var_6b67821f && n_time_left <= 2)
		{
			var_6b67821f = 1;
			/#
				iprintlnbold("");
			#/
		}
		else if(!var_b973dc14 && n_time_left <= 1)
		{
			var_b973dc14 = 1;
			/#
				iprintlnbold("");
			#/
		}
	}
	self clientfield::set("bs_att_blst", 1);
	level thread lui::screen_flash(0.1, 0.3, 0.7, 0.5, "white");
	self playsound("zmb_eyeball_swrath_burst");
	var_3f0f05e = 0;
	a_players = array::randomize(level.activeplayers);
	foreach(player in a_players)
	{
		if(!(isdefined(player.hasriotshieldequipped) && player.hasriotshieldequipped))
		{
			player dodamage(player.health + 666, player.origin);
			continue;
		}
		if(!var_3f0f05e)
		{
			if(isdefined(player))
			{
				player function_abbfbdff(level.var_ad9b527b);
				var_3f0f05e = 1;
			}
		}
	}
	level notify(#"hash_2e4b6b86e99b024b");
}

/*
	Name: function_bacc07e2
	Namespace: namespace_8139f49c
	Checksum: 0xCB8091AF
	Offset: 0xB718
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_bacc07e2()
{
	level endon(#"intermission");
	level.var_6c390c77 endon(#"death");
	level waittill(#"hash_38f29f9cb03586ea", #"hash_14400d2bff068132", #"hash_2e4b6b86e99b024b");
	level.var_6c390c77 clientfield::set("bs_att_blst_tll", 0);
	exploder::exploder_stop("fxexp_be_f_ovf_b");
	exploder::exploder_stop("fxexp_be_f_a");
	exploder::exploder_stop("fxexp_be_f_b");
	exploder::exploder_stop("fxexp_be_f_c");
	level.var_6c390c77 function_26e02ac9(0);
	level.var_6c390c77 animation::stop(0);
	level.var_6c390c77 stopsound("zmb_eyeball_swrath_charge");
	wait(1);
	level.var_6c390c77 clientfield::set("bs_att_blst", 0);
}

/*
	Name: function_e3f1b159
	Namespace: namespace_8139f49c
	Checksum: 0x12DF16C9
	Offset: 0xB898
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_e3f1b159()
{
	level endon(#"hash_38f29f9cb03586ea", #"hash_14400d2bff068132", #"hash_2e4b6b86e99b024b", #"intermission");
	level.var_6c390c77 endon(#"death");
	wait(4);
	exploder::exploder("fxexp_be_f_ovf_b");
	wait(0.5);
	exploder::exploder("fxexp_be_f_a");
	wait(0.5);
	exploder::exploder("fxexp_be_f_b");
	wait(0.5);
	exploder::exploder("fxexp_be_f_c");
}

/*
	Name: function_2b6b4a44
	Namespace: namespace_8139f49c
	Checksum: 0x11DB00A3
	Offset: 0xB990
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_2b6b4a44()
{
	level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
	while(true)
	{
		level notify(#"hash_6986218d09dc1cb2");
		util::wait_network_frame(randomintrange(1, 3));
		level function_e2f134ce();
		level notify(#"hash_6b642d0b24b9ee12");
		util::wait_network_frame(randomintrange(1, 3));
		level function_e2f134ce();
	}
}

/*
	Name: function_e2f134ce
	Namespace: namespace_8139f49c
	Checksum: 0x55A04F37
	Offset: 0xBA90
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_e2f134ce()
{
	level flag::wait_till_clear(#"hash_21921ed511559aa3");
}

/*
	Name: function_de60e752
	Namespace: namespace_8139f49c
	Checksum: 0x37232588
	Offset: 0xBAC0
	Size: 0x5D8
	Parameters: 1
	Flags: Linked
*/
function function_de60e752(var_533ac894)
{
	level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
	n_round = level.var_d6f059f7;
	switch(level.var_f3c4bd00)
	{
		case 1:
		{
			var_d166a3c6 = 1;
			var_6d55be0e = 1.5;
			break;
		}
		case 2:
		{
			var_d166a3c6 = 2;
			var_6d55be0e = 1;
			break;
		}
		case 3:
		{
			var_d166a3c6 = 5;
			var_6d55be0e = 0.5;
			break;
		}
		case 4:
		{
			var_d166a3c6 = 9;
			var_6d55be0e = 0.1;
			break;
		}
	}
	n_max_active_ai = 16 + var_d166a3c6;
	level.var_9eaf1031 = 0;
	level.var_83c0592c = 0;
	level thread function_f5b2d086();
	a_players = util::get_active_players();
	if(a_players.size > 0)
	{
		s_zone = a_players[0] zm_utility::get_current_zone(1);
	}
	if(!isdefined(s_zone))
	{
		s_zone = level.zones[#"zone_poop_deck"];
	}
	a_s_spawnpoints = struct::get_array(s_zone.name + "_spawns");
	a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(s_zone.name + "_spawner"), 0, 0);
	var_e6217dda = getarraykeys(s_zone.adjacent_zones);
	foreach(str_zone in var_e6217dda)
	{
		if(isdefined(s_zone.adjacent_zones[str_zone]) && s_zone.adjacent_zones[str_zone].is_connected)
		{
			a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawns"), 0, 0);
			a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawner"), 0, 0);
		}
	}
	if(isdefined(var_533ac894))
	{
		foreach(str_zone in var_533ac894)
		{
			a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawns"), 0, 0);
			a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawner"), 0, 0);
		}
	}
	a_s_spawnpoints = array::filter(a_s_spawnpoints, 0, &function_62b1d725);
	var_c5cc6b59 = array::randomize(a_s_spawnpoints);
	n_index = 0;
	while(true)
	{
		while(getaiteamarray(level.zombie_team).size >= n_max_active_ai)
		{
			util::wait_network_frame();
		}
		spawner = array::random(level.zombie_spawners);
		s_spawnpoint = var_c5cc6b59[n_index];
		if(n_index + 1 >= var_c5cc6b59.size)
		{
			n_index = 0;
		}
		else
		{
			n_index++;
		}
		var_b2a4b538 = level.var_83c0592c;
		level waittill(#"hash_6986218d09dc1cb2");
		e_zombie = zombie_utility::spawn_zombie(spawner, spawner.targetname, s_spawnpoint, n_round);
		if(isdefined(e_zombie))
		{
			level.var_83c0592c++;
		}
		wait(var_6d55be0e);
	}
	level notify(#"hash_71fd67248b9a37ca");
}

/*
	Name: function_e9b8eaff
	Namespace: namespace_8139f49c
	Checksum: 0x43727EEF
	Offset: 0xC0A0
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_e9b8eaff(e_attacker)
{
	if(self.archetype !== #"zombie")
	{
		return;
	}
	if(!isplayer(e_attacker))
	{
		return;
	}
	if(isdefined(self.var_69a981e6) && self.var_69a981e6)
	{
		return;
	}
	level.var_9eaf1031++;
}

/*
	Name: function_62b1d725
	Namespace: namespace_8139f49c
	Checksum: 0xD61CB07E
	Offset: 0xC110
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_62b1d725(s_loc)
{
	if(!isdefined(s_loc.script_noteworthy))
	{
		return 0;
	}
	if(s_loc.script_noteworthy === "spawn_location")
	{
		return 1;
	}
	a_str_tokens = strtok(s_loc.script_noteworthy, " ");
	foreach(str_token in a_str_tokens)
	{
		if(str_token == "custom_spawner_entry")
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_769d7e4f
	Namespace: namespace_8139f49c
	Checksum: 0xC4AA43C0
	Offset: 0xC200
	Size: 0x14E
	Parameters: 0
	Flags: Linked
*/
function function_769d7e4f()
{
	level endon(#"intermission");
	a_ai_zombies = getaiarchetypearray(#"zombie", level.zombie_team);
	foreach(ai in a_ai_zombies)
	{
		if(!isalive(ai) || zm_utility::is_magic_bullet_shield_enabled(ai) || (isdefined(ai.var_69a981e6) && ai.var_69a981e6))
		{
			util::wait_network_frame();
			continue;
		}
		ai kill();
		ai hide();
		level.var_83c0592c--;
		return;
	}
}

/*
	Name: function_f5b2d086
	Namespace: namespace_8139f49c
	Checksum: 0xD23C5577
	Offset: 0xC358
	Size: 0x1BC
	Parameters: 0
	Flags: Linked
*/
function function_f5b2d086()
{
	level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"hash_71fd67248b9a37ca", #"intermission");
	wait(6);
	var_e8ebec1d = array(#"hash_7c89b1397a38e3ad", #"hash_7c89ae397a38de94", #"hash_7c89af397a38e047", #"hash_7c89ac397a38db2e");
	level.var_8a64ef3a = 0;
	var_ffd2fe87 = 4 + level.var_f3c4bd00;
	while(true)
	{
		if(getaiteamarray(level.zombie_team).size > 0 && level.var_8a64ef3a / getaiteamarray(level.zombie_team).size * 100 < var_ffd2fe87)
		{
			var_6c463143 = 1;
		}
		else
		{
			var_6c463143 = 0;
		}
		var_c0958d26 = array::random(var_e8ebec1d);
		if(var_6c463143 && !namespace_3fffba66::function_abf1dcb4(var_c0958d26))
		{
			namespace_3fffba66::function_bdd8aba6(var_c0958d26);
			level.var_9eaf1031--;
		}
		wait(2);
	}
}

/*
	Name: function_724b3e30
	Namespace: namespace_8139f49c
	Checksum: 0xA89F95B0
	Offset: 0xC520
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_724b3e30(n_health)
{
	level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
	self.b_ignore_cleanup = 1;
	level.var_8a64ef3a++;
	level thread function_83ad8f65(self);
}

/*
	Name: function_83ad8f65
	Namespace: namespace_8139f49c
	Checksum: 0xEBECEE05
	Offset: 0xC5A0
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function function_83ad8f65(ai)
{
	level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
	ai waittill(#"death");
	if(isdefined(level.var_8a64ef3a))
	{
		level.var_8a64ef3a--;
	}
}

/*
	Name: function_f6e1e56f
	Namespace: namespace_8139f49c
	Checksum: 0x5BDDB28A
	Offset: 0xC620
	Size: 0x7DC
	Parameters: 3
	Flags: Linked
*/
function function_f6e1e56f(var_238eb6ec, var_b5a033fe = 0, var_533ac894)
{
	level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
	n_round = level.var_d6f059f7;
	var_5b839378 = 0;
	var_c6e6a75d = 0;
	var_8b999044 = [];
	switch(level.var_f3c4bd00)
	{
		case 1:
		{
			var_c9221a0f = 10;
			var_b68a90de = 12;
			var_dda23e4b = 0.5;
			break;
		}
		case 2:
		{
			var_c9221a0f = 8;
			var_b68a90de = 10;
			var_dda23e4b = 0.4;
			break;
		}
		case 3:
		{
			var_c9221a0f = 6;
			var_b68a90de = 8;
			var_dda23e4b = 0.35;
			break;
		}
		case 4:
		{
			var_c9221a0f = 4;
			var_b68a90de = 6;
			var_dda23e4b = 0.3;
			break;
		}
	}
	var_5dc704a7 = int(ceil(var_238eb6ec + var_238eb6ec * var_dda23e4b));
	var_1e8caeb1 = var_5dc704a7;
	n_max_active_ai = 16 + level.var_f3c4bd00;
	var_36f58c64 = level.var_f3c4bd00 + 1;
	var_9cc45d9e = undefined;
	a_players = util::get_active_players();
	if(a_players.size > 0)
	{
		s_zone = a_players[0] zm_utility::get_current_zone(1);
	}
	if(!isdefined(s_zone))
	{
		s_zone = level.zones[#"zone_poop_deck"];
	}
	var_bb492495 = struct::get_array(s_zone.name + "_spawns");
	var_bb492495 = arraycombine(var_bb492495, struct::get_array(s_zone.name + "_spawner"), 0, 0);
	var_e6217dda = getarraykeys(s_zone.adjacent_zones);
	foreach(str_zone in var_e6217dda)
	{
		if(isdefined(s_zone.adjacent_zones[str_zone]) && s_zone.adjacent_zones[str_zone].is_connected)
		{
			var_bb492495 = arraycombine(var_bb492495, struct::get_array(str_zone + "_spawns"), 0, 0);
			var_bb492495 = arraycombine(var_bb492495, struct::get_array(str_zone + "_spawner"), 0, 0);
		}
	}
	if(isdefined(var_533ac894))
	{
		foreach(str_zone in var_533ac894)
		{
			var_bb492495 = arraycombine(var_bb492495, struct::get_array(str_zone + "_spawns"), 0, 0);
			var_bb492495 = arraycombine(var_bb492495, struct::get_array(str_zone + "_spawner"), 0, 0);
		}
	}
	var_bb492495 = array::filter(var_bb492495, 0, &function_6c4ef5c9);
	while(var_b5a033fe == 0 || var_5b839378 < var_b5a033fe)
	{
		if(level.var_9eaf1031 < var_1e8caeb1)
		{
			util::wait_network_frame(5);
			continue;
		}
		var_bb492495 = array::randomize(var_bb492495);
		var_c979da59 = 0;
		var_1e8caeb1 = var_1e8caeb1 + var_5dc704a7;
		while(var_8b999044.size < var_36f58c64)
		{
			while(!isdefined(var_9cc45d9e))
			{
				level waittill(#"hash_6b642d0b24b9ee12");
				var_9cc45d9e = namespace_823c357e::function_6249817(1, var_bb492495[var_c979da59], n_round);
			}
			if(!isdefined(var_8b999044))
			{
				var_8b999044 = [];
			}
			else if(!isarray(var_8b999044))
			{
				var_8b999044 = array(var_8b999044);
			}
			var_8b999044[var_8b999044.size] = var_9cc45d9e;
			var_c6e6a75d++;
			while(getaiteamarray(level.zombie_team).size >= n_max_active_ai)
			{
				util::wait_network_frame();
				level function_769d7e4f();
			}
			wait(randomfloatrange(var_c9221a0f, var_b68a90de));
			var_9cc45d9e = undefined;
			var_c979da59++;
		}
		function_1eaaceab(var_8b999044, 0);
		if(var_8b999044.size)
		{
			array::wait_till(var_8b999044, "death");
		}
		function_1eaaceab(var_8b999044, 0);
		if(var_8b999044.size)
		{
			array::wait_till(var_8b999044, "death");
		}
		if(var_b5a033fe > 0)
		{
			var_5b839378++;
			if(var_5b839378 >= var_b5a033fe)
			{
				break;
			}
		}
	}
	function_98198f98(#"stoker");
	wait(randomfloatrange(var_c9221a0f, var_b68a90de));
}

/*
	Name: function_6c4ef5c9
	Namespace: namespace_8139f49c
	Checksum: 0xC505A263
	Offset: 0xCE08
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_6c4ef5c9(s_loc)
{
	if(!isdefined(s_loc.script_noteworthy))
	{
		return 0;
	}
	if(s_loc.script_noteworthy === "stoker_location")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_776c95e2
	Namespace: namespace_8139f49c
	Checksum: 0x44CEBA5F
	Offset: 0xCE50
	Size: 0x2FC
	Parameters: 2
	Flags: Linked
*/
function function_776c95e2(var_61e1a92c, var_dbb23c7)
{
	level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
	var_2208179c = struct::get_array(#"hash_1145e9b37016a8bd");
	var_7bb1ca00 = level.var_f3c4bd00;
	var_ab2645b = undefined;
	var_24b27265 = 0;
	switch(level.var_f3c4bd00)
	{
		case 1:
		{
			var_8c9010a4 = 21;
			var_dde52a4d = 26;
			break;
		}
		case 2:
		{
			var_8c9010a4 = 19;
			var_dde52a4d = 24;
			break;
		}
		case 3:
		{
			var_8c9010a4 = 17;
			var_dde52a4d = 22;
			break;
		}
		case 4:
		{
			var_8c9010a4 = 15;
			var_dde52a4d = 20;
			break;
		}
	}
	while(var_24b27265 < var_dbb23c7)
	{
		wait(randomfloatrange(20, 25));
		var_50e016a7 = level.var_83c0592c + var_61e1a92c;
		while(level.var_83c0592c <= var_50e016a7)
		{
			util::wait_network_frame(2);
		}
		for(var_9b2fc577 = 0; var_9b2fc577 < var_7bb1ca00; var_9b2fc577++)
		{
			namespace_3fffba66::function_bdd8aba6(#"hash_9ecf8085fb7a68f");
			wait(randomfloatrange(var_8c9010a4, var_dde52a4d));
		}
		while(level.var_b175714d[#"hash_9ecf8085fb7a68f"].var_33e393a7 > 0)
		{
			util::wait_network_frame(2);
		}
		do
		{
			wait(2);
			var_b036ebfb = getaiarchetypearray(#"blight_father");
		}
		while(var_b036ebfb.size > 0);
		var_24b27265++;
	}
	function_98198f98(#"blight_father");
}

/*
	Name: function_770486e1
	Namespace: namespace_8139f49c
	Checksum: 0x143B11EF
	Offset: 0xD158
	Size: 0x278
	Parameters: 1
	Flags: Linked
*/
function function_770486e1(var_61e1a92c)
{
	level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission");
	var_2208179c = struct::get_array(#"hash_1145e9b37016a8bd");
	var_7bb1ca00 = level.var_f3c4bd00;
	var_ab2645b = undefined;
	while(true)
	{
		wait(randomfloatrange(20, 25));
		var_50e016a7 = level.var_83c0592c + var_61e1a92c;
		while(level.var_83c0592c <= var_50e016a7)
		{
			util::wait_network_frame(2);
		}
		for(var_9b2fc577 = 0; var_9b2fc577 < var_7bb1ca00; var_9b2fc577++)
		{
			namespace_3fffba66::function_bdd8aba6(#"hash_9ecf8085fb7a68f");
			wait(randomfloatrange(15, 20));
		}
		while(level.var_b175714d[#"hash_9ecf8085fb7a68f"].var_33e393a7 > 0)
		{
			wait(0.2);
		}
		var_b036ebfb = getaiarchetypearray(#"blight_father");
		var_791efa17 = var_b036ebfb.size;
		while(var_791efa17 > 0)
		{
			foreach(var_ab2645b in var_b036ebfb)
			{
				if(!isalive(var_ab2645b))
				{
					var_791efa17--;
				}
			}
			wait(0.2);
		}
		util::wait_network_frame();
	}
}

/*
	Name: function_98198f98
	Namespace: namespace_8139f49c
	Checksum: 0x80411DFD
	Offset: 0xD3D8
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_98198f98(str_archetype)
{
	level endon(#"intermission");
	util::delay_notify(600, #"hash_20ba9a0874996fda");
	while(true)
	{
		wait(0.5);
		b_wait = 0;
		a_ai = getaiarchetypearray(str_archetype);
		foreach(ai in a_ai)
		{
			if(isalive(ai))
			{
				b_wait = 1;
				break;
			}
		}
		if(!b_wait)
		{
			level notify(#"hash_3a4456148ade383a");
			return;
		}
	}
}

/*
	Name: function_5d346946
	Namespace: namespace_8139f49c
	Checksum: 0x2F5AE598
	Offset: 0xD500
	Size: 0x1A4
	Parameters: 0
	Flags: None
*/
function function_5d346946()
{
	/#
		if(!getdvarint(#"hash_11ad6a9695943217", 0))
		{
			return;
		}
		zm_devgui::add_custom_devgui_callback(&function_d25f8fbc);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_d25f8fbc
	Namespace: namespace_8139f49c
	Checksum: 0x92FD9E8A
	Offset: 0xD6B0
	Size: 0x322
	Parameters: 1
	Flags: None
*/
function function_d25f8fbc(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_6f3275b0f2068260":
			{
				level thread function_435a7941();
				return 1;
			}
			case "hash_1774efff8d070e0d":
			{
				level thread function_435a7941(1);
				return 1;
			}
			case "hash_1774eeff8d070c5a":
			{
				level thread function_435a7941(2);
				return 1;
			}
			case "hash_1774e9ff8d0703db":
			{
				level thread function_435a7941(3);
				return 1;
			}
			case "hash_1774e8ff8d070228":
			{
				level thread function_435a7941(4);
				return 1;
			}
			case "hash_56b003484b719b01":
			{
				level.var_6c390c77 thread function_225a4561();
				return 1;
			}
			case "hash_28985be47f864a03":
			{
				level.var_6c390c77 thread function_81b39fd3();
				return 1;
			}
			case "hash_44d685aa9a6085ac":
			{
				level.var_6c390c77 thread function_6b5e9ead();
				return 1;
			}
			case "hash_2005de954011f43d":
			{
				level.var_6c390c77 thread function_da98e094();
				return 1;
			}
			case "hash_587980f75fa98810":
			{
				level.var_6c390c77 thread function_c31e58d9();
				return 1;
			}
			case "hash_42e3fa83d357e8e0":
			{
				level.var_6c390c77 function_500cb0be(#"hash_678aaf8e37498e9a", #"hash_48d376e92022fee8");
				return 1;
			}
			case "hash_42e3fd83d357edf9":
			{
				level.var_6c390c77 function_500cb0be(#"hash_32a51dafb1c7344f", #"hash_778aa1db2592594f");
				return 1;
			}
			case "hash_42e3fc83d357ec46":
			{
				level.var_6c390c77 function_500cb0be(#"hash_597bdc83a7c9e8c", #"hash_7760b698f6aeafbe");
				return 1;
			}
			case "hash_5dad3801740fa24a":
			{
				level notify(#"hash_38f29f9cb03586ea");
				return 1;
			}
		}
	#/
}

/*
	Name: function_435a7941
	Namespace: namespace_8139f49c
	Checksum: 0xED17298C
	Offset: 0xD9E0
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function function_435a7941(var_c1051599)
{
	/#
		zm_devgui::zombie_devgui_open_sesame();
		if(!flag::get(""))
		{
			level.var_7759c77d.var_4ee2e2ab = 0;
			level flag::set("");
		}
		if(isdefined(var_c1051599))
		{
			level.var_ec84950b[#"boss_fight"].var_8ff9d08f = var_c1051599;
		}
		namespace_ee206246::start(#"boss_fight");
		level waittill(#"hash_fbdf766a8b47229");
		if(!isdefined(var_c1051599))
		{
			level function_f4cadcd6("");
		}
	#/
}

/*
	Name: function_225a4561
	Namespace: namespace_8139f49c
	Checksum: 0x1B55CD32
	Offset: 0xDAE0
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function function_225a4561()
{
	/#
		if(isdefined(level.var_19261dce) && level.var_19261dce)
		{
			return;
		}
		self function_5e792125();
		var_b7ba41fc = [];
		n_rand = randomint(self.var_3c63665.size);
		var_b7ba41fc = self.var_3c63665[n_rand];
		var_31a7a68f = var_b7ba41fc[0].script_int;
		util::wait_network_frame();
		self function_ead65ea1(var_31a7a68f);
		self function_ae28c1a7();
	#/
}

/*
	Name: function_81b39fd3
	Namespace: namespace_8139f49c
	Checksum: 0x73A6C571
	Offset: 0xDBC8
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_81b39fd3()
{
	/#
		if(isdefined(level.var_19261dce) && level.var_19261dce)
		{
			return;
		}
		self function_5e792125();
		self function_ff69c896();
		self function_ae28c1a7();
	#/
}

/*
	Name: function_6b5e9ead
	Namespace: namespace_8139f49c
	Checksum: 0x64B5CF80
	Offset: 0xDC40
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_6b5e9ead()
{
	/#
		if(isdefined(level.var_19261dce) && level.var_19261dce)
		{
			return;
		}
		self function_5e792125();
		self function_c7c928e9();
		self function_ae28c1a7();
	#/
}

/*
	Name: function_da98e094
	Namespace: namespace_8139f49c
	Checksum: 0x9864887B
	Offset: 0xDCB8
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_da98e094()
{
	/#
		if(isdefined(level.var_19261dce) && level.var_19261dce)
		{
			return;
		}
		self function_5e792125();
		self function_371e0929();
		self function_ae28c1a7();
	#/
}

/*
	Name: function_c31e58d9
	Namespace: namespace_8139f49c
	Checksum: 0x19626723
	Offset: 0xDD30
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function function_c31e58d9()
{
	/#
		if(isdefined(level.var_19261dce) && level.var_19261dce)
		{
			return;
		}
		self function_5e792125(1);
		self function_1acc1d3();
		self function_ae28c1a7();
	#/
}

/*
	Name: function_5e792125
	Namespace: namespace_8139f49c
	Checksum: 0x74E372B
	Offset: 0xDDB0
	Size: 0x204
	Parameters: 1
	Flags: None
*/
function function_5e792125(var_4c971546)
{
	/#
		if(!isdefined(var_4c971546))
		{
			var_4c971546 = 0;
		}
		/#
			iprintlnbold("");
		#/
		level.var_19261dce = 1;
		if(!isdefined(self.var_431d02e5))
		{
			self function_a55a0339("");
		}
		if(!isdefined(self.var_48b3f539))
		{
			self function_71f63a19("");
		}
		if(!isdefined(self.var_3c63665))
		{
			self function_1b11b43("");
		}
		if(!isdefined(self.var_c962047c))
		{
			self.var_c962047c = -1;
		}
		if(!isdefined(self.var_59cdb7b9))
		{
			self.var_59cdb7b9 = 1000;
		}
		if(!isdefined(self.var_f881e30f))
		{
			self.var_f881e30f = 1000;
		}
		if(!isdefined(self.var_6efcc8c1))
		{
			self.var_6efcc8c1 = 0;
		}
		if(!isdefined(self.str_scene))
		{
			self function_500cb0be(#"hash_678aaf8e37498e9a", #"hash_48d376e92022fee8");
		}
		level clientfield::set("", 1);
		util::wait_network_frame();
		self function_a8a76e18();
		util::wait_network_frame();
		self function_26e02ac9(0);
		wait(4);
		if(!var_4c971546)
		{
			self function_671e8d37();
		}
	#/
}

/*
	Name: function_ae28c1a7
	Namespace: namespace_8139f49c
	Checksum: 0x6A4329BC
	Offset: 0xDFC0
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function function_ae28c1a7()
{
	/#
		self function_26e02ac9(0);
		wait(2);
		self function_a8a76e18();
		wait(3);
		self function_20c99a47();
		self.origin = (0, 0, 0);
		self.angles = (0, 0, 0);
		self function_8e49143c();
		level.var_19261dce = 0;
		level clientfield::set("", 0);
		/#
			iprintlnbold("");
		#/
	#/
}

