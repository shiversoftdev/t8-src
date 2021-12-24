// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1c72973fb240f263;
#using script_3f9e0dc8454d98e1;
#using script_421e0a3702e22de;
#using script_52c6c2d1a2ef1b46;
#using script_5cd88351d6d269b1;
#using script_5e177698fdcdbe2c;
#using script_6a3f43063dfd1bdc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_orange.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_13b4b4b;

/*
	Name: preload
	Namespace: namespace_13b4b4b
	Checksum: 0x313E7C65
	Offset: 0x240
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	clientfield::register("vehicle", "" + #"wisp_fx", 24000, 1, "int");
}

/*
	Name: init
	Namespace: namespace_13b4b4b
	Checksum: 0xFFA468EF
	Offset: 0x290
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init(#"hash_2c3411c8b8b421d8");
	namespace_85e029d3::register_drop_off(16, #"hash_18dcf44bdd7a747c", #"hash_459899940f28d8f0", &function_b5f900c3);
}

/*
	Name: function_5309464a
	Namespace: namespace_13b4b4b
	Checksum: 0x9FF08D77
	Offset: 0x300
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_5309464a(var_5ea5c94d)
{
	namespace_6747c550::function_7df6bb60(#"hash_2fbec633e5118bab", 11);
	level.var_80c25d0a = 115;
	if(isdefined(level.chests))
	{
		zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 0);
		level notify(#"fire_sale_off");
		foreach(chest in level.chests)
		{
			chest zm_magicbox::hide_chest(0);
		}
		zm_orange::function_2336a7c8();
	}
	if(!var_5ea5c94d)
	{
		level thread function_39c9e020();
		namespace_85e029d3::function_d83490c5(16);
		level flag::wait_till(#"hash_2c3411c8b8b421d8");
	}
}

/*
	Name: function_ae270d9e
	Namespace: namespace_13b4b4b
	Checksum: 0x26797BC7
	Offset: 0x480
	Size: 0x1C
	Parameters: 2
	Flags: Linked
*/
function function_ae270d9e(var_5ea5c94d, ended_early)
{
}

/*
	Name: function_b5f900c3
	Namespace: namespace_13b4b4b
	Checksum: 0x9722BECC
	Offset: 0x4A8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_b5f900c3()
{
	/#
		iprintlnbold("");
	#/
	level notify(#"hash_7b1d7041d240c3da");
	level thread sun_deck_watcher();
}

/*
	Name: function_39c9e020
	Namespace: namespace_13b4b4b
	Checksum: 0x8AD33E28
	Offset: 0x500
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function function_39c9e020()
{
	level endon(#"end_game");
	a_str_zones = array("main_entrance", "loading_platform");
	while(true)
	{
		if(namespace_509a75d1::any_player_in_zone(a_str_zones))
		{
			break;
		}
		wait(1);
	}
	a_e_players = [];
	foreach(e_player in getplayers())
	{
		str_zone = e_player zm_zonemgr::get_player_zone();
		if(str_zone === "main_entrance" || str_zone === "loading_platform")
		{
			if(!isdefined(a_e_players))
			{
				a_e_players = [];
			}
			else if(!isarray(a_e_players))
			{
				a_e_players = array(a_e_players);
			}
			a_e_players[a_e_players.size] = e_player;
		}
	}
	if(a_e_players.size > 0)
	{
		e_player = array::random(a_e_players);
		e_player thread namespace_3263198e::function_51b752a9(#"hash_ebd07fabb769017");
	}
	else
	{
		level thread namespace_3263198e::function_fd24e47f(#"hash_ebd07fabb769017");
	}
}

/*
	Name: sun_deck_watcher
	Namespace: namespace_13b4b4b
	Checksum: 0x9464413D
	Offset: 0x6F8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function sun_deck_watcher()
{
	level endon(#"end_game");
	while(true)
	{
		if(namespace_509a75d1::any_player_in_zone("sun_deck"))
		{
			break;
		}
		wait(0.1);
	}
	level thread function_d096f18f();
}

/*
	Name: function_d096f18f
	Namespace: namespace_13b4b4b
	Checksum: 0x53386672
	Offset: 0x768
	Size: 0x43C
	Parameters: 0
	Flags: Linked
*/
function function_d096f18f()
{
	level.var_ab11c23d notify(#"hash_78fc5bbd712046b0");
	level.var_ab11c23d rotateto((10, level.var_ab11c23d.angles[1] - 5, 0), 0.2);
	level.var_ab11c23d waittill(#"rotatedone");
	level.var_ab11c23d rotatevelocity(vectorscale((0, -1, 0), 1440), 4.5, 3);
	level thread function_39d9b290();
	exploder::exploder("fxexp_portal_115_start");
	wait(5);
	level.var_ab11c23d rotateto((-90, level.var_ab11c23d.angles[1], 0), 0.2);
	level namespace_3263198e::function_fd24e47f(#"hash_1003004a8ca44bb3", -1, 1);
	var_6df66af8 = float(soundgetplaybacktime(#"hash_2e5e53739622d4e5")) / 1000;
	s_start = struct::get("pablo_rise_start");
	level.var_d827e909 setblackboardattribute("_stance", "swim");
	e_mover = util::spawn_model("tag_origin", level.var_d827e909.origin);
	var_6740ea1e = util::spawn_model("p8_fxp_hell_sphere", e_mover.origin);
	var_6740ea1e setscale(1.5);
	var_6740ea1e linkto(e_mover);
	level.var_d827e909 linkto(e_mover);
	e_mover moveto(s_start.origin, 1);
	level thread namespace_85e029d3::function_e44c7c0c(#"hash_1a974fe7a0edddab");
	wait(1);
	namespace_6747c550::function_7df6bb60(#"hash_2fbec633e5118bab", 12);
	e_mover moveto(e_mover.origin + vectorscale((0, 0, 1), 4000), var_6df66af8 - 1);
	wait(var_6df66af8 - 3);
	exploder::stop_exploder("fxexp_portal_115_start");
	exploder::exploder("fxexp_portal_115_end");
	wait(2);
	level.var_d827e909 delete();
	var_6740ea1e delete();
	e_mover delete();
	level thread function_bf106bdf();
	level namespace_3263198e::function_fd24e47f(#"hash_1a974fe7a0edddab");
	wait(1);
	level.var_1c53964e thread namespace_509a75d1::function_6a0d675d(#"hash_635ca3634ea94ee9");
}

/*
	Name: function_8a707841
	Namespace: namespace_13b4b4b
	Checksum: 0xA35BFF9
	Offset: 0xBB0
	Size: 0xD2
	Parameters: 1
	Flags: None
*/
function function_8a707841(n_loop_time)
{
	n_wait_time = 0.5;
	n_time_elapsed = 0;
	self clientfield::set("lighthouse_on", 0);
	while(n_time_elapsed < n_loop_time)
	{
		self clientfield::increment("" + #"hash_6c84cb8d22df46f0", 1);
		wait(n_wait_time);
		n_time_elapsed = n_time_elapsed + n_wait_time;
		n_wait_time = max(n_wait_time * 0.85, 0.1);
	}
}

/*
	Name: function_39d9b290
	Namespace: namespace_13b4b4b
	Checksum: 0x211E53E0
	Offset: 0xC90
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_39d9b290()
{
	level endon(#"end_game");
	var_6fe200e3 = zm_zonemgr::get_players_in_zone("sun_deck", 1);
	wait(1);
	a_e_players = zm_zonemgr::get_players_in_zone("sun_deck", 1);
	if(a_e_players.size == 0)
	{
		a_e_players = var_6fe200e3;
	}
	e_player = array::random(a_e_players);
	e_player thread namespace_3263198e::function_51b752a9(#"hash_8f686e289c54c01");
}

/*
	Name: function_bf106bdf
	Namespace: namespace_13b4b4b
	Checksum: 0x93491629
	Offset: 0xD60
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_bf106bdf()
{
	vh_wisp = spawner::simple_spawn_single(getent("virgil", "targetname"));
	while(!isdefined(vh_wisp))
	{
		waitframe(1);
		vh_wisp = spawner::simple_spawn_single(getent("virgil", "targetname"));
	}
	vh_wisp clientfield::set("" + #"wisp_fx", 1);
	nd_start = getvehiclenode("portal_wisp_start", "targetname");
	vh_wisp setspeed(20);
	vh_wisp vehicle::get_on_and_go_path(nd_start);
	var_68e87752 = util::spawn_model("p8_zm_ora_elemental_vessel", vh_wisp.origin + (vectorscale((0, 0, -1), 10)));
	var_68e87752 thread namespace_bfc8ee03::rotate_forever(vectorscale((0, 1, 0), 45));
	var_68e87752 namespace_2e9c09b3::function_f1827cc6(&function_f140d71a, zm_utility::function_d6046228(#"hash_50d83a4f11ad9d8", #"hash_51d8e27e625c6bd4"), undefined, 128);
}

/*
	Name: function_f140d71a
	Namespace: namespace_13b4b4b
	Checksum: 0x6BC603E5
	Offset: 0xF38
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_f140d71a(var_2e1f34dd, e_player)
{
	e_player playrumbleonentity("zm_mansion_atlas_interact_rumble");
	level flag::set(#"hash_2c3411c8b8b421d8");
	/#
		iprintlnbold("");
	#/
}

