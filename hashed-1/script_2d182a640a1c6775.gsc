// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b10fdf0addd52e;
#using script_2892d932ac4f3e3c;
#using script_35598499769dbb3d;
#using script_39e954a546d3baf;
#using script_3f9e0dc8454d98e1;
#using script_4d00889cf8c807d5;
#using script_5660bae5b402a1eb;
#using script_58c342edd81589fb;
#using script_5bb072c3abf4652c;
#using script_6021ce59143452c3;
#using script_6e3c826b1814cab6;
#using script_db06eb511bd9b36;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_red.gsc;
#using scripts\zm\zm_red_util.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_8b80898c;

/*
	Name: init
	Namespace: namespace_8b80898c
	Checksum: 0xF9119396
	Offset: 0x8D8
	Size: 0x5F4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("actor", "" + #"hash_3405b851cc3a2f1", 16000, 1, "counter");
	clientfield::register("actor", "" + #"zombie_delete", 16000, 1, "counter");
	clientfield::register("actor", "" + #"hash_6d5686b05e69fcb0", 16000, 1, "counter");
	clientfield::register("actor", "" + #"hash_76696d393fa512bf", 16000, 2, "int");
	if(!zm_utility::function_3bff983f())
	{
		clientfield::register("scriptmover", "" + #"hash_440ca00839d907a8", -17000, 1, "int");
	}
	clientfield::register("scriptmover", "" + #"hash_2a586a321116326c", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_3ec0452110ea5621", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_5da65e20d966c63f", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"artifact_glow", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_78015e57e42c1e9a", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_39815108525ba28b", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"pegasus_ambient", 16000, 1, "int");
	clientfield::register("vehicle", "" + #"hash_5da65e20d966c63f", 16000, 1, "counter");
	clientfield::register("vehicle", "" + #"hash_463ff879b8d656bb", 16000, 1, "int");
	clientfield::register("vehicle", "" + #"hash_13ec9477957fe921", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_6e61536372d6546d", 16000, 1, "int");
	level.var_2f2b78fb = spawnstruct();
	level.var_5cc61d5f = 0;
	level.var_19819980 = 0;
	array::run_all(getentarray("event_ground_before", "targetname"), &connectpaths);
	array::run_all(getentarray("mdl_power_quest_aftermath_2", "targetname"), &notsolid);
	array::run_all(getentarray("mdl_power_quest_aftermath_2", "targetname"), &hide);
	array::run_all(getentarray("mdl_power_quest_aftermath", "targetname"), &notsolid);
	array::run_all(getentarray("mdl_power_quest_aftermath", "targetname"), &hide);
	level.var_b0ccfa4c = array("c_t8_zmb_dlc2_zombie_male_body4_skin2_fb", "c_t8_zmb_dlc2_zombie_male_body3_skin2_fb", "c_t8_zmb_dlc2_zombie_male_body4_fb", "c_t8_zmb_dlc2_zombie_male_body1_skin2_fb", "c_t8_zmb_dlc2_zombie_male_body3_fb", "c_t8_zmb_dlc2_zombie_female_body3_skin2_fb", "c_t8_zmb_dlc2_zombie_female_body1_fb", "c_t8_zmb_dlc2_zombie_female_body2_skin2_fb");
	level thread function_bda82828();
}

/*
	Name: function_bda82828
	Namespace: namespace_8b80898c
	Checksum: 0x92FC15BB
	Offset: 0xED8
	Size: 0xD76
	Parameters: 0
	Flags: Linked
*/
function function_bda82828()
{
	level endon(#"end_game", #"hash_420b070435236eab");
	level flag::wait_till("all_players_spawned");
	if(namespace_59ff1d6c::function_901b751c(#"zmpowerstate") == 2)
	{
		function_e8a7948d();
		function_e059d0e1();
		return;
	}
	if(namespace_59ff1d6c::function_901b751c(#"zmpowerstate") == 0 || namespace_59ff1d6c::function_901b751c("zmMinibossState") == 2 || namespace_59ff1d6c::function_901b751c("zmEnhancedState") == 2)
	{
		function_e8a7948d();
		callback::remove_on_connect(&function_8efba1b4);
		var_3e910f73 = getent("mdl_power_bullet", "targetname");
		if(isdefined(var_3e910f73))
		{
			var_3e910f73 delete();
		}
		mdl_blocker = getent("mdl_power_blocker", "targetname");
		if(isdefined(mdl_blocker))
		{
			mdl_blocker delete();
		}
		exploder::stop_exploder("Fxexp_barrier_amph");
		return;
	}
	if(zm_utility::is_standard())
	{
		function_77dd379a();
		return;
	}
	var_71da3f5a = getentarray("mdl_power_skeleton", "targetname");
	foreach(var_5c688ad6 in var_71da3f5a)
	{
		mdl_clip = getent(var_5c688ad6.target, "targetname");
		mdl_clip notsolid();
	}
	callback::on_connect(&function_8efba1b4);
	array::thread_all(getplayers(), &function_8efba1b4);
	var_3e910f73 = getent("mdl_power_bullet", "targetname");
	var_3e910f73.origin = var_3e910f73.origin + (0, 0, 2048);
	var_3e910f73 thread namespace_159b5b5b::function_1de14ea4();
	var_4ec3364d = getent("perseus_amphitheater_clip", "targetname");
	var_4ec3364d notsolid();
	level clientfield::set("" + #"hash_6e61536372d6546d", 1);
	var_f2c72290 = [];
	level.var_2f2b78fb.var_9400690b = [];
	level.var_2f2b78fb.var_5bf6d1df = 0;
	level.var_9400690b = [];
	var_e92cf3d9 = struct::get_array(#"hash_76796d914e70fc43");
	foreach(var_d85d42ba in var_e92cf3d9)
	{
		var_b6b01674 = var_d85d42ba function_e9f93d33();
		var_b6b01674 thread function_aab4eb23();
		level.var_9400690b[level.var_9400690b.size] = var_b6b01674;
	}
	level.var_26450f62 = [];
	var_b81c0ab3 = struct::get_array(#"hash_2cb6fcd3ae46aec0");
	foreach(var_d85d42ba in var_b81c0ab3)
	{
		var_b6b01674 = var_d85d42ba function_ba40fcf4();
		var_b6b01674 thread function_aab4eb23();
		level.var_26450f62[level.var_26450f62.size] = var_b6b01674;
	}
	callback::on_ai_killed(&function_75c83fbf);
	level flag::wait_till("begin_spawning");
	level.var_ffb89532 = level.zones[#"zone_amphitheater_house"].a_loc_types[#"zombie_location"];
	level.zones[#"zone_amphitheater_house"].a_loc_types[#"zombie_location"] = [];
	mdl_sentinel_artifact = getent("mdl_sentinel_artifact", "targetname");
	mdl_sentinel_artifact clientfield::set("" + #"artifact_glow", 1);
	mdl_sentinel_artifact playloopsound(#"hash_5c7e9911ac98f633");
	s_loc = struct::get(#"hash_3dbe0b62fa014608");
	s_loc zm_unitrigger::create(&function_969cb6b2);
	s_loc thread function_b3d827f();
	level thread function_3ff7750a();
	level flag::wait_till(#"hash_dc34ebe02d09532");
	level thread function_95d6655b();
	level thread function_be9bce83();
	level flag::set(#"hash_70efff113b745513");
	if(zm_utility::function_3bff983f())
	{
		level.check_for_valid_spawn_near_team_callback = &function_d1435bda;
	}
	zm_unitrigger::unregister_unitrigger(s_loc.s_unitrigger);
	s_loc.s_unitrigger = undefined;
	s_loc struct::delete();
	zm_powerups::function_74b8ec6b(#"nuke");
	var_3e910f73.origin = var_3e910f73.origin - (0, 0, 2048);
	var_4ec3364d solid();
	var_4ec3364d thread namespace_159b5b5b::function_1de14ea4();
	exploder::exploder("Fxexp_barrier_amph");
	if(function_71ac80d2())
	{
		level zm_utility::function_fdb0368(2, #"hash_5911a4f09afeb690");
		level flag::set("pause_round_timeout");
		level flag::set("hold_round_end");
		wait(0.1);
		foreach(ai in getaiteamarray(level.zombie_team))
		{
			if(isdefined(ai))
			{
				ai thread function_9cc74e1b();
			}
		}
		level flag::wait_till("spawn_zombies");
		level flag::clear("spawn_zombies");
	}
	else
	{
		level thread function_63102269();
	}
	level thread perseus_amphitheater();
	level flag::wait_till(#"hash_3db8e78cda787136");
	level thread function_d8db57f6();
	level flag::wait_till(#"hash_78334a5d5a02e966");
	wait(4);
	namespace_f551babc::function_ae725d63();
	level thread function_aa54541d();
	level thread function_30da273d();
	level thread function_a5b8e88f();
	level flag::wait_till(#"hash_6471231d75af61b9");
	wait(1);
	function_e059d0e1();
	level flag::clear(#"hash_70efff113b745513");
	wait(4);
	if(zm_utility::function_3bff983f())
	{
		level.check_for_valid_spawn_near_team_callback = undefined;
	}
	level flag::set("spawn_zombies");
	level flag::clear("pause_round_timeout");
	level flag::clear("hold_round_end");
	function_350204ca(#"hash_4c0b3f3f8e394cbc");
	wait(1);
	foreach(player in util::get_active_players())
	{
		player thread namespace_891c9bac::function_8e0f4696(#"hash_33e1e5be84d42bba", 0, 1, 9999, 1, 1, 1);
	}
	var_8ded56d0 = getent("vol_power_quest_kill_zone", "targetname");
	if(isdefined(var_8ded56d0))
	{
		var_8ded56d0 delete();
	}
	level.zones[#"zone_amphitheater_house"].a_loc_types[#"zombie_location"] = level.var_ffb89532;
	level.zones[#"zone_amphitheater"].is_spawning_allowed = 1;
}

/*
	Name: function_d1435bda
	Namespace: namespace_8b80898c
	Checksum: 0xF07102AC
	Offset: 0x1C58
	Size: 0x60
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d1435bda(player, var_feed7374)
{
	var_1de1f14d = struct::get_array("s_trials_power_quest_player_spawns");
	n_ent_num = player getentitynumber();
	return var_1de1f14d[n_ent_num];
}

/*
	Name: function_e8a7948d
	Namespace: namespace_8b80898c
	Checksum: 0x58A01871
	Offset: 0x1CC0
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function function_e8a7948d()
{
	var_71da3f5a = getentarray("mdl_power_skeleton", "targetname");
	foreach(var_5c688ad6 in var_71da3f5a)
	{
		var_5c688ad6 ghost();
		mdl_clip = getent(var_5c688ad6.target, "targetname");
		mdl_clip delete();
	}
}

/*
	Name: function_77dd379a
	Namespace: namespace_8b80898c
	Checksum: 0x81FAD292
	Offset: 0x1DB0
	Size: 0x5F4
	Parameters: 0
	Flags: Linked
*/
function function_77dd379a()
{
	level endon(#"end_game");
	var_71da3f5a = getentarray("mdl_power_skeleton", "targetname");
	foreach(var_5c688ad6 in var_71da3f5a)
	{
		var_5c688ad6 ghost();
		mdl_clip = getent(var_5c688ad6.target, "targetname");
		mdl_clip ghost();
	}
	var_3cd87194 = getentarray("mdl_power_blocker_glyph", "targetname");
	foreach(var_6eb21a54 in var_3cd87194)
	{
		var_6eb21a54 hide();
	}
	var_3e910f73 = getent("mdl_power_bullet", "targetname");
	var_3e910f73.origin = var_3e910f73.origin + (0, 0, 2048);
	mdl_blocker = getent("mdl_power_blocker", "targetname");
	mdl_blocker delete();
	function_e8a7948d();
	level.var_2f2b78fb.var_9400690b = [];
	level.var_2f2b78fb.var_5bf6d1df = 0;
	level.var_9400690b = [];
	var_e92cf3d9 = struct::get_array(#"hash_76796d914e70fc43");
	foreach(var_d85d42ba in var_e92cf3d9)
	{
		var_b6b01674 = var_d85d42ba function_e9f93d33();
		level.var_9400690b[level.var_9400690b.size] = var_b6b01674;
	}
	level.var_26450f62 = [];
	var_b81c0ab3 = struct::get_array(#"hash_2cb6fcd3ae46aec0");
	foreach(var_d85d42ba in var_b81c0ab3)
	{
		var_b6b01674 = var_d85d42ba function_ba40fcf4();
		level.var_26450f62[level.var_26450f62.size] = var_b6b01674;
	}
	level waittill(#"hash_20632257a91d251a");
	wait(25);
	zm_powerups::function_74b8ec6b(#"nuke");
	level.var_2f2b78fb.var_5579012f = 80;
	level.var_2f2b78fb.var_30c1e68b = 25;
	level thread function_ee7ebb1a();
	level waittill(#"hash_7a04a7fb98fa4e4d");
	wait(0.75);
	level flag::clear("spawn_zombies");
	level thread lui::screen_flash(0.2, 1, 0.5, 1, "white");
	wait(0.2);
	level.var_9400690b = array::remove_undefined(level.var_9400690b);
	foreach(var_b6b01674 in level.var_9400690b)
	{
		if(isdefined(var_b6b01674.var_feb69dca))
		{
			var_b6b01674.var_feb69dca delete();
		}
		var_b6b01674 delete();
	}
	function_e059d0e1();
	level flag::set("spawn_zombies");
}

/*
	Name: function_ee7ebb1a
	Namespace: namespace_8b80898c
	Checksum: 0x67EABC9F
	Offset: 0x23B0
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function function_ee7ebb1a()
{
	level endon(#"game_ended", #"hash_7a04a7fb98fa4e4d");
	var_69b8b63f = array::randomize(level.var_9400690b);
	foreach(var_f7473111 in var_69b8b63f)
	{
		if(isdefined(var_f7473111) && (!(isdefined(level.var_a286b947) && level.var_a286b947)))
		{
			function_3c2c7054();
			while(getaiteamarray("axis").size >= 25)
			{
				wait(0.1);
			}
			var_f7473111 thread zm_red::function_a4e2970b(1);
			level.var_19819980++;
			wait(randomfloatrange(2 / getplayers().size, 5 / getplayers().size));
		}
	}
}

/*
	Name: function_3ff7750a
	Namespace: namespace_8b80898c
	Checksum: 0x34698F3
	Offset: 0x2538
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_3ff7750a()
{
	level endon(#"hash_70efff113b745513");
	while(true)
	{
		var_a5e3ee12 = trigger::wait_till("trigger_amph_entrance");
		if(isplayer(var_a5e3ee12.who))
		{
			player = var_a5e3ee12.who;
			break;
		}
	}
	if(!level flag::get(#"hash_6c92a415bd4bb739"))
	{
		player namespace_891c9bac::function_a2bd5a0c(#"hash_5f91baafb561a09d", 0, 1, 9999, 1);
	}
}

/*
	Name: function_9cc74e1b
	Namespace: namespace_8b80898c
	Checksum: 0x439D240A
	Offset: 0x2618
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_9cc74e1b()
{
	self endon(#"death");
	self clientfield::increment("" + #"zombie_delete");
	self thread ai::stun();
	wait(1);
	if(isdefined(self))
	{
		self thread namespace_159b5b5b::cleanup_zombie();
	}
}

/*
	Name: function_e059d0e1
	Namespace: namespace_8b80898c
	Checksum: 0x9C4C130F
	Offset: 0x26A8
	Size: 0xD24
	Parameters: 0
	Flags: Linked
*/
function function_e059d0e1()
{
	hidemiscmodels("event_stands_zombies");
	level clientfield::set("" + #"hash_6e61536372d6546d", 0);
	exploder::exploder("exp_lgt_power_event");
	array::run_all(getentarray("event_ground_before", "targetname"), &delete);
	array::run_all(getentarray("mdl_power_quest_aftermath_2", "targetname"), &solid);
	array::run_all(getentarray("mdl_power_quest_aftermath_2", "targetname"), &show);
	array::run_all(getentarray("mdl_power_quest_aftermath_2", "targetname"), &connectpaths);
	var_eb5ed779 = getentarray("mdl_power_holder", "targetname");
	mdl_clip = getent("mdl_power_holder_clip", "targetname");
	if(isdefined(var_eb5ed779))
	{
		array::delete_all(var_eb5ed779);
	}
	if(isdefined(mdl_clip))
	{
		mdl_clip delete();
	}
	mdl_sentinel_artifact = getent("mdl_sentinel_artifact", "targetname");
	if(isdefined(mdl_sentinel_artifact))
	{
		mdl_sentinel_artifact clientfield::set("" + #"hash_2a586a321116326c", 1);
		mdl_sentinel_artifact playloopsound(#"hash_e2c71c7dece38ee");
	}
	var_a6c6bf68 = getentarray("event_collision_move", "targetname");
	var_d11f336d = struct::get_array(#"hash_5bc8479768b4a60e");
	if(isdefined(var_a6c6bf68) && isdefined(var_d11f336d))
	{
		foreach(vol in var_a6c6bf68)
		{
			foreach(player in getplayers())
			{
				if(player istouching(vol) && (!(isdefined(player.var_e17ca454) && player.var_e17ca454)))
				{
					player.var_e17ca454 = 1;
					var_d495f74c = arraygetclosest(player.origin, var_d11f336d);
					arrayremovevalue(var_d11f336d, var_d495f74c);
					player setorigin(var_d495f74c.origin);
				}
			}
		}
	}
	if(isdefined(var_d11f336d))
	{
		foreach(var_d495f74c in var_d11f336d)
		{
			if(isdefined(var_d495f74c))
			{
				var_d495f74c struct::delete();
			}
		}
	}
	if(isdefined(var_a6c6bf68))
	{
		foreach(ai_zombie in getaiteamarray(level.zombie_team))
		{
			foreach(vol in var_a6c6bf68)
			{
				if(ai_zombie istouching(vol) && !zm_utility::is_magic_bullet_shield_enabled(ai_zombie))
				{
					ai_zombie kill();
				}
			}
		}
		foreach(vol in var_a6c6bf68)
		{
			vol delete();
		}
	}
	wait(0.1);
	foreach(player in getplayers())
	{
		player.var_e17ca454 = undefined;
	}
	var_503d53c2 = getentarray("mdl_power_quest_aftermath", "targetname");
	foreach(mdl_power_quest_aftermath in var_503d53c2)
	{
		if(isdefined(mdl_power_quest_aftermath) && (!(isdefined(mdl_power_quest_aftermath.is_in_place) && mdl_power_quest_aftermath.is_in_place)))
		{
			mdl_power_quest_aftermath.is_in_place = 1;
			mdl_power_quest_aftermath show();
			mdl_power_quest_aftermath solid();
			mdl_power_quest_aftermath disconnectpaths();
		}
	}
	zm_powerups::function_41cedb05(#"nuke");
	wait(3);
	var_6e56eb16 = getent("vol_power_quest_no_powerups", "script_noteworthy");
	if(isdefined(var_6e56eb16))
	{
		if(isdefined(level.var_5fa2f970))
		{
			arrayremovevalue(level.var_5fa2f970, var_6e56eb16);
		}
		var_6e56eb16 delete();
	}
	if(isdefined(mdl_sentinel_artifact))
	{
		s_move = struct::get(mdl_sentinel_artifact.target);
	}
	if(isdefined(s_move) && isdefined(mdl_sentinel_artifact))
	{
		mdl_sentinel_artifact moveto(s_move.origin, 3);
		mdl_sentinel_artifact rotateto(s_move.angles, 3);
		mdl_sentinel_artifact playsound(#"hash_75b9c9ad6ebe8af2");
	}
	wait(2);
	level flag::set("power_on");
	if(isdefined(mdl_sentinel_artifact))
	{
		mdl_sentinel_artifact clientfield::set("" + #"hash_3ec0452110ea5621", 1);
		wait(2);
		mdl_sentinel_artifact clientfield::set("" + #"hash_2a586a321116326c", 0);
		mdl_sentinel_artifact clientfield::set("" + #"hash_3ec0452110ea5621", 0);
		mdl_sentinel_artifact clientfield::increment("" + #"hash_5da65e20d966c63f");
		wait(1);
		mdl_sentinel_artifact playsound(#"hash_5de064f33e9e49b8");
		v_origin = mdl_sentinel_artifact.origin;
		level thread function_ae259e17(v_origin);
		if(!level flag::get(#"hash_420b070435236eab"))
		{
			mdl_sentinel_artifact delete();
		}
		else
		{
			mdl_sentinel_artifact hide();
		}
	}
	if(isdefined(s_move))
	{
		s_move struct::delete();
	}
	playsoundatposition(#"hash_3d8fef5997663b17", (0, 0, 0));
	s_reward = struct::get(#"hash_3b2d60a79515031a");
	if(isdefined(s_reward))
	{
		v_origin = s_reward.origin;
		s_reward struct::delete();
		level thread zm_powerups::specific_powerup_drop("full_ammo", v_origin, undefined, undefined, undefined, 0, 1);
	}
	callback::remove_on_connect(&function_8efba1b4);
	var_3e910f73 = getent("mdl_power_bullet", "targetname");
	if(isdefined(var_3e910f73))
	{
		var_3e910f73 delete();
	}
	mdl_blocker = getent("mdl_power_blocker", "targetname");
	if(isdefined(mdl_blocker))
	{
		mdl_blocker delete();
	}
	exploder::stop_exploder("Fxexp_barrier_amph");
	s_center = struct::get(#"hash_4ede0d513d23996b");
	if(isdefined(s_center))
	{
		s_center struct::delete();
	}
	level flag::clear(#"hash_dc34ebe02d09532");
	if(isdefined(level.var_2f2b78fb))
	{
		level.var_2f2b78fb struct::delete();
	}
	level flag::set(#"hash_3dba794053dea40e");
}

/*
	Name: function_95d6655b
	Namespace: namespace_8b80898c
	Checksum: 0xD0B41A7D
	Offset: 0x33D8
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_95d6655b()
{
	level endon(#"hash_4d8091aa6a26d815");
	var_168ccd6b = getent("vol_power_quest_kill_zone", "targetname");
	level.zones[#"zone_amphitheater"].is_spawning_allowed = 0;
	wait(2);
	while(true)
	{
		foreach(ai_zombie in getaiteamarray(level.zombie_team))
		{
			if(!(isdefined(ai_zombie.var_ae4569d5) && ai_zombie.var_ae4569d5) && ai_zombie istouching(var_168ccd6b) && isdefined(ai_zombie))
			{
				ai_zombie thread function_9cc74e1b();
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_be9bce83
	Namespace: namespace_8b80898c
	Checksum: 0x2191A8D3
	Offset: 0x3538
	Size: 0x314
	Parameters: 0
	Flags: Linked
*/
function function_be9bce83()
{
	level flag::wait_till(#"hash_dc34ebe02d09532");
	var_1679e8e = function_22230e37();
	foreach(ai_zombie in getaiteamarray(level.zombie_team))
	{
		foreach(player in var_1679e8e)
		{
			if(isdefined(player.var_fd141207) && player.var_fd141207)
			{
				ai_zombie setignoreent(player, 1);
			}
		}
	}
	callback::on_ai_spawned(&function_1b3428bf);
	level flag::wait_till(#"hash_3dba794053dea40e");
	callback::remove_on_ai_spawned(&function_1b3428bf);
	foreach(player in getplayers())
	{
		player.var_fd141207 = undefined;
	}
	wait(0.5);
	foreach(ai_zombie in getaiteamarray(level.zombie_team))
	{
		foreach(player in getplayers())
		{
			ai_zombie setignoreent(player, 0);
		}
	}
}

/*
	Name: function_1b3428bf
	Namespace: namespace_8b80898c
	Checksum: 0xA746C7D9
	Offset: 0x3858
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_1b3428bf()
{
	self endon(#"death");
	if(isdefined(self.var_ae4569d5) && self.var_ae4569d5)
	{
		return;
	}
	foreach(player in getplayers())
	{
		if(isdefined(player.var_fd141207) && player.var_fd141207)
		{
			self setignoreent(player, 1);
		}
	}
}

/*
	Name: function_71ac80d2
	Namespace: namespace_8b80898c
	Checksum: 0xF7242FA7
	Offset: 0x3938
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_71ac80d2()
{
	var_1679e8e = function_22230e37();
	var_f64e8455 = getplayers();
	if(isdefined(var_1679e8e) && isdefined(var_f64e8455))
	{
		if(var_1679e8e.size === var_f64e8455.size)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_63102269
	Namespace: namespace_8b80898c
	Checksum: 0x663E23E3
	Offset: 0x39B0
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_63102269()
{
	level endon(#"hash_4d8091aa6a26d815");
	while(true)
	{
		var_1679e8e = function_22230e37();
		var_f64e8455 = getplayers();
		if(isdefined(var_1679e8e) && isdefined(var_f64e8455))
		{
			if(var_1679e8e.size === var_f64e8455.size)
			{
				level zm_utility::function_fdb0368(2, #"hash_5911a4f09afeb690");
				level flag::set("pause_round_timeout");
				level flag::set("hold_round_end");
				function_a7bdf314();
				level flag::wait_till("spawn_zombies");
				level flag::clear("spawn_zombies");
				break;
			}
		}
		wait(0.5);
	}
}

/*
	Name: function_a7bdf314
	Namespace: namespace_8b80898c
	Checksum: 0xE797EBE0
	Offset: 0x3B08
	Size: 0x25E
	Parameters: 0
	Flags: Linked
*/
function function_a7bdf314()
{
	foreach(ai in getaiteamarray(level.zombie_team))
	{
		if(isalive(ai) && (!(isdefined(ai.var_d45ca662) && ai.var_d45ca662)) && (!(isdefined(ai.marked_for_death) && ai.marked_for_death)) && (!(isdefined(ai.var_ae4569d5) && ai.var_ae4569d5)))
		{
			if(ai.var_6f84b820 === #"basic" || ai.var_6f84b820 === #"popcorn")
			{
				if(zm_utility::is_magic_bullet_shield_enabled(ai))
				{
					ai util::stop_magic_bullet_shield();
				}
				ai.allowdeath = 1;
				ai.no_powerups = 1;
				ai.deathpoints_already_given = 1;
				ai.marked_for_death = 1;
				ai clientfield::increment("" + #"zombie_delete");
				wait(0.1);
				if(isdefined(ai))
				{
					ai thread function_9cc74e1b();
				}
			}
			else
			{
				ai clientfield::increment("" + #"zombie_delete");
				wait(0.1);
				if(isdefined(ai))
				{
					ai thread function_9cc74e1b();
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: perseus_amphitheater
	Namespace: namespace_8b80898c
	Checksum: 0x2B635AD9
	Offset: 0x3D70
	Size: 0x2DC
	Parameters: 0
	Flags: Linked
*/
function perseus_amphitheater()
{
	s_scene = struct::get("tag_align_red_amphitheatre");
	var_3edd432d = getent("perseus_amphitheater", "targetname");
	var_3edd432d hide();
	s_scene thread scene::play(#"hash_6f717ae316034ada", var_3edd432d);
	wait(0.1);
	var_3edd432d show();
	level.musicsystemoverride = 1;
	music::setmusicstate("poweron_event_start");
	waitframe(1);
	var_3edd432d clientfield::increment("" + #"hash_78015e57e42c1e9a");
	wait(1.5);
	var_3edd432d playsound(#"hash_7e17c0850b86d621");
	var_3edd432d playloopsound(#"hash_4572307d016259a6");
	exploder::exploder("Fxexp_barrier_amph_perseus");
	level waittill(#"summon");
	for(i = 0; i < 3; i++)
	{
		var_ee28fc90 = spawner::simple_spawn_single("perseus_trail");
		if(isdefined(var_ee28fc90))
		{
			var_ee28fc90 thread function_a8f1dc6b(getvehiclenode("perseus_trail_" + i, "targetname"));
		}
		wait(0.1);
	}
	wait(2.5);
	level flag::set(#"hash_3db8e78cda787136");
	var_3edd432d stoploopsound();
	var_3edd432d playsound(#"hash_4917791296076e1d");
	wait(4);
	exploder::stop_exploder("Fxexp_barrier_amph_perseus");
	var_4ec3364d = getent("perseus_amphitheater_clip", "targetname");
	if(isdefined(var_4ec3364d))
	{
		var_4ec3364d delete();
	}
}

/*
	Name: function_a8f1dc6b
	Namespace: namespace_8b80898c
	Checksum: 0x52073228
	Offset: 0x4058
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_a8f1dc6b(nd_start)
{
	self endon(#"death");
	self clientfield::set("" + #"hash_13ec9477957fe921", 1);
	self vehicle::get_on_and_go_path(nd_start);
	self clientfield::set("" + #"hash_13ec9477957fe921", 0);
	self playsound(#"hash_7c51534a91103a32");
	self delete();
}

/*
	Name: function_e9f93d33
	Namespace: namespace_8b80898c
	Checksum: 0x1935EFD2
	Offset: 0x4128
	Size: 0x198
	Parameters: 0
	Flags: Linked
*/
function function_e9f93d33()
{
	str_model = level.var_b0ccfa4c[randomint(level.var_b0ccfa4c.size)];
	var_f7473111 = util::spawn_model(str_model, self.origin, self.angles);
	var_f7473111.target = self.target;
	var_f7473111.var_e259ad71 = self.var_e259ad71;
	var_f7473111.var_feb69dca = array::get_all_closest(var_f7473111.origin, getentarray("chaos_crust", "targetname"))[0];
	var_f7473111.sp_model = getent(str_model, "targetname");
	if(isdefined(var_f7473111.var_feb69dca))
	{
		var_f7473111.var_feb69dca setscale(0.8);
	}
	var_f7473111.str_scene = function_efcd5d38();
	wait(0.1);
	if(isdefined(var_f7473111.str_scene))
	{
		var_f7473111 thread scene::play(var_f7473111.str_scene, "init", var_f7473111);
	}
	return var_f7473111;
}

/*
	Name: function_ba40fcf4
	Namespace: namespace_8b80898c
	Checksum: 0xE21B29A0
	Offset: 0x42C8
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function function_ba40fcf4()
{
	str_model = level.var_b0ccfa4c[randomint(level.var_b0ccfa4c.size)];
	var_f7473111 = util::spawn_model(str_model, self.origin, self.angles);
	var_f7473111.target = self.target;
	var_f7473111.var_feb69dca = array::get_all_closest(var_f7473111.origin, getentarray("chaos_crust", "targetname"))[0];
	var_f7473111.sp_model = getent(str_model, "targetname");
	if(isdefined(var_f7473111.var_feb69dca))
	{
		var_f7473111.var_feb69dca setscale(0.8);
	}
	var_f7473111.str_scene = function_efcd5d38();
	wait(0.1);
	if(isdefined(var_f7473111.str_scene))
	{
		var_f7473111 thread scene::play(var_f7473111.str_scene, "init", var_f7473111);
	}
	return var_f7473111;
}

/*
	Name: function_efcd5d38
	Namespace: namespace_8b80898c
	Checksum: 0xBF34490D
	Offset: 0x4450
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function function_efcd5d38()
{
	a_str_scenes = [];
	for(i = 1; i < 10; i++)
	{
		a_str_scenes[a_str_scenes.size] = "aib_vign_cust_zm_red_amp_zmb_brk_out_0" + i;
	}
	a_str_scenes[a_str_scenes.size] = "aib_vign_cust_zm_red_amp_zmb_brk_out_10";
	return array::random(a_str_scenes);
}

/*
	Name: function_aab4eb23
	Namespace: namespace_8b80898c
	Checksum: 0x4E5DD873
	Offset: 0x44D8
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_aab4eb23()
{
	level endon(#"hash_dc34ebe02d09532");
	self endon(#"death");
	self val::set(#"hash_380f047d8df05b1", "takedamage", 1);
	self.health = 99999999;
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"damage");
		e_attacker = var_be17187b.attacker;
		if(isplayer(e_attacker) && zm_utility::is_player_valid(e_attacker, 0, 0, 0))
		{
			var_168ccd6b = getent("vol_power_quest_kill_zone", "targetname");
			if(e_attacker istouching(var_168ccd6b))
			{
				break;
			}
		}
	}
	level flag::set(#"hash_dc34ebe02d09532");
}

/*
	Name: function_b3d827f
	Namespace: namespace_8b80898c
	Checksum: 0x9D087A09
	Offset: 0x4630
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function function_b3d827f()
{
	level endon(#"end_game", #"hash_dc34ebe02d09532");
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"trigger_activated");
	e_player = var_88706ea7.e_who;
	if(zm_utility::is_player_valid(e_player))
	{
		level flag::set(#"hash_6c92a415bd4bb739");
		mdl_sentinel_artifact = getent("mdl_sentinel_artifact", "targetname");
		mdl_sentinel_artifact clientfield::set("" + #"artifact_glow", 0);
		mdl_sentinel_artifact stoploopsound();
		mdl_sentinel_artifact playsound(#"hash_331b62b49768f70");
		if(e_player zm_audio::function_65e5c19a())
		{
			e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_497fcbdaee283347", 0.5, 1, 10000, 0);
		}
	}
	level flag::set(#"hash_dc34ebe02d09532");
}

/*
	Name: function_969cb6b2
	Namespace: namespace_8b80898c
	Checksum: 0x34590242
	Offset: 0x47D8
	Size: 0x1EA
	Parameters: 1
	Flags: Linked
*/
function function_969cb6b2(e_player)
{
	mdl_sentinel_artifact = getent("mdl_sentinel_artifact", "targetname");
	if(isdefined(mdl_sentinel_artifact))
	{
		var_39b20ef6 = e_player zm_utility::is_player_looking_at(mdl_sentinel_artifact.origin + (0, 0, -16), 0.95 + -0.15);
		b_is_valid = zm_utility::is_player_valid(e_player, 0, 0);
		b_disable = 0;
		var_3a6fab91 = namespace_c3287616::function_f6cd912d(1);
		if(isdefined(var_3a6fab91))
		{
			var_f40360e8 = var_3a6fab91.n_round;
			b_disable = var_f40360e8 === level.round_number;
		}
		if(level flag::get(#"hash_6c92a415bd4bb739"))
		{
			b_disable = 1;
		}
		if(!b_disable && b_is_valid)
		{
			str_prompt = zm_utility::function_d6046228(#"hash_65fb48b6dbf04c10", #"hash_2e613e6f3511ecbc");
			self sethintstringforplayer(e_player, str_prompt);
			return 1;
		}
		self sethintstringforplayer(e_player, "");
		return 0;
	}
	return 0;
}

/*
	Name: function_8efba1b4
	Namespace: namespace_8b80898c
	Checksum: 0xE96F8538
	Offset: 0x49D0
	Size: 0x1B0
	Parameters: 0
	Flags: Linked
*/
function function_8efba1b4()
{
	self notify("3bb67145bc189b04");
	self endon("3bb67145bc189b04");
	level endon(#"end_game", #"hash_3dba794053dea40e");
	self endon(#"disconnect");
	if(level flag::get(#"hash_3dba794053dea40e"))
	{
		return;
	}
	mdl_blocker = getent("mdl_power_blocker", "targetname");
	mdl_blocker endon(#"death");
	mdl_blocker setinvisibletoplayer(self);
	level flag::wait_till(#"hash_dc34ebe02d09532");
	var_8ded56d0 = getent("vol_power_quest_kill_zone", "targetname");
	while(true)
	{
		while(!self istouching(var_8ded56d0))
		{
			waitframe(1);
		}
		mdl_blocker setvisibletoplayer(self);
		while(self istouching(var_8ded56d0))
		{
			waitframe(1);
		}
		mdl_blocker setinvisibletoplayer(self);
	}
}

/*
	Name: function_aa54541d
	Namespace: namespace_8b80898c
	Checksum: 0xD36BDB6D
	Offset: 0x4B88
	Size: 0x170
	Parameters: 0
	Flags: Linked
*/
function function_aa54541d()
{
	level endon(#"end_game", #"hash_4d8091aa6a26d815");
	while(true)
	{
		wait(0.5);
		a_ai_zombies = level.ai[#"axis"];
		if(isdefined(a_ai_zombies) && isarray(a_ai_zombies) && a_ai_zombies.size > level.zombie_ai_limit)
		{
			foreach(ai_zombie in a_ai_zombies)
			{
				if(ai_zombie.archetype == #"zombie" && (!(isdefined(ai_zombie.var_ae4569d5) && ai_zombie.var_ae4569d5)) && !zm_utility::is_magic_bullet_shield_enabled(ai_zombie))
				{
					ai_zombie kill();
					break;
				}
			}
		}
	}
}

/*
	Name: function_30da273d
	Namespace: namespace_8b80898c
	Checksum: 0xF046557C
	Offset: 0x4D00
	Size: 0x25A
	Parameters: 0
	Flags: Linked
*/
function function_30da273d()
{
	self notify("bf7bc278661b0a8");
	self endon("bf7bc278661b0a8");
	level endon(#"end_game", #"hash_4d8091aa6a26d815", #"hash_420b070435236eab");
	a_players = getplayers();
	if(isdefined(a_players))
	{
		switch(a_players.size)
		{
			case 4:
			{
				level.var_7cea7fa8 = array(2, 0.25, 0.1, 0.05);
				break;
			}
			case 3:
			{
				level.var_7cea7fa8 = array(2, 0.4, 0.2, 0.1);
				break;
			}
			case 2:
			{
				level.var_7cea7fa8 = array(2, 0.5, 0.35, 0.2);
				break;
			}
			case 1:
			{
				level.var_7cea7fa8 = array(2, 1.25, 0.8, 0.35);
				break;
			}
		}
	}
	level.n_index = 0;
	while(level.var_19819980 < 4)
	{
		wait(1);
	}
	level.n_index = 1;
	while(level.var_19819980 < 7)
	{
		wait(1);
	}
	level.n_index = 2;
	while(level.var_19819980 < 10)
	{
		wait(1);
	}
	level.n_index = 3;
}

/*
	Name: function_a5b8e88f
	Namespace: namespace_8b80898c
	Checksum: 0xBE8F2F7C
	Offset: 0x4F68
	Size: 0x464
	Parameters: 1
	Flags: Linked
*/
function function_a5b8e88f(var_ddab7294 = 0)
{
	self notify("392ebc6b9cec5b9");
	self endon("392ebc6b9cec5b9");
	level endon(#"end_game", #"hash_420b070435236eab");
	level.var_ac6d10d4 = 1;
	level.var_2f2b78fb.var_5579012f = 80;
	level.var_2f2b78fb.var_30c1e68b = 25;
	var_69b8b63f = array::randomize(level.var_9400690b);
	if(var_ddab7294)
	{
		level.var_19819980 = 0;
		level thread function_30da273d();
		level waittill_timeout(8, #"hash_2f976f64c9301e7f");
		foreach(var_f7473111 in var_69b8b63f)
		{
			var_f7473111 show();
			var_f7473111.var_a7cbb3cb = undefined;
			if(isdefined(var_f7473111.var_feb69dca))
			{
				var_f7473111.var_feb69dca show();
			}
		}
		namespace_f551babc::function_ae725d63();
	}
	foreach(var_f7473111 in var_69b8b63f)
	{
		if(zm_utility::function_3bff983f() && level flag::get("round_reset"))
		{
			return;
		}
		if(isdefined(var_f7473111))
		{
			function_3c2c7054();
			while(getaiteamarray("axis").size >= 32)
			{
				wait(0.1);
			}
			var_f7473111 thread zm_red::function_a4e2970b(1);
			level.var_19819980++;
			wait(level.var_7cea7fa8[level.n_index]);
		}
	}
	function_350204ca(#"hash_4f27038870dd43b0");
	wait(6);
	level.var_ac6d10d4 = undefined;
	namespace_f551babc::function_ae725d63();
	level thread function_1e9b5c67();
	level thread function_c577b1bf();
	level thread function_56c68db();
	level flag::wait_till(#"hash_6471231d75af61b9");
	wait(0.5);
	level function_9ead836c();
	foreach(var_f7473111 in level.var_26450f62)
	{
		if(isdefined(var_f7473111))
		{
			var_f7473111 delete();
		}
	}
	wait(1);
	level flag::set(#"hash_4d8091aa6a26d815");
	level flag::set(#"hash_787f723b2f0d72f9");
}

/*
	Name: function_9ead836c
	Namespace: namespace_8b80898c
	Checksum: 0x9004F88B
	Offset: 0x53D8
	Size: 0x296
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9ead836c()
{
	var_4b9821e4 = 0;
	level thread lui::screen_flash(1, 1, 0.5, 1, "white");
	a_ai_zombies = getaiteamarray(level.zombie_team);
	foreach(ai in a_ai_zombies)
	{
		if(isalive(ai) && (isdefined(ai.var_ae4569d5) && ai.var_ae4569d5) && (!(isdefined(ai.var_d45ca662) && ai.var_d45ca662)) && (!(isdefined(ai.marked_for_death) && ai.marked_for_death)))
		{
			if(zm_utility::is_magic_bullet_shield_enabled(ai))
			{
				ai util::stop_magic_bullet_shield();
			}
			ai.allowdeath = 1;
			ai.no_powerups = 1;
			ai.deathpoints_already_given = 1;
			ai.marked_for_death = 1;
			if(ai.var_6f84b820 === #"basic" || ai.var_6f84b820 === #"enhanced" && var_4b9821e4 < 6)
			{
				var_4b9821e4++;
				ai thread zombie_death::flame_death_fx();
				if(!(isdefined(ai.no_gib) && ai.no_gib))
				{
					ai zombie_utility::zombie_head_gib();
				}
			}
			ai dodamage(ai.health + 666, ai.origin);
		}
		waitframe(1);
	}
}

/*
	Name: function_c577b1bf
	Namespace: namespace_8b80898c
	Checksum: 0x5C5EF43D
	Offset: 0x5678
	Size: 0x3A4
	Parameters: 0
	Flags: Linked
*/
function function_c577b1bf()
{
	var_81f76694 = getent("pegasus_cloud", "targetname");
	var_10d4f67d = util::spawn_model("c_t8_zmb_dlc2_pegasus_fb", var_81f76694.origin + vectorscale((0, 0, -1), 285), var_81f76694.angles);
	var_10d4f67d.linkto = util::spawn_model("tag_origin", var_10d4f67d.origin, var_10d4f67d.angles);
	scene::add_scene_func("aib_zm_red_vign_peg_inair_flapattack_01", &function_4b198b8f, "play");
	var_10d4f67d.linkto thread scene::play("aib_zm_red_vign_peg_inair_flapattack_01", "start", var_10d4f67d);
	level.var_10d4f67d = var_10d4f67d;
	level.var_10d4f67d setteam(#"allies");
	wait(0.1);
	level flag::set(#"hash_7fc5886c894cf1f4");
	level.musicsystemoverride = 0;
	level thread zm_audio::sndmusicsystem_playstate("poweron_event_complete", zm_utility::function_3bff983f());
	level thread function_350204ca(#"hash_62be5a478a16c968");
	playsoundatposition(#"hash_2642ecae6103f09b", var_10d4f67d.origin);
	var_10d4f67d clientfield::increment("" + #"hash_19edb07afd0faeb7");
	var_10d4f67d clientfield::set("" + #"hash_39815108525ba28b", 1);
	level flag::set(#"hash_50172adaa660c417");
	wait(0.5);
	level thread function_c4f5840a();
	wait(8);
	level flag::set(#"hash_6471231d75af61b9");
	var_10d4f67d playrumbleonentity("zm_red_pegasus_clear_rumble");
	playsoundatposition(#"hash_737ff3246a85fd0e", var_10d4f67d.origin);
	level flag::wait_till(#"hash_4d8091aa6a26d815");
	if(isdefined(var_10d4f67d.linkto))
	{
		var_10d4f67d.linkto delete();
	}
	var_10d4f67d function_ce24f67b();
	level flag::set(#"hash_5587d659c08d5af1");
	if(isdefined(var_10d4f67d))
	{
		var_10d4f67d delete();
	}
}

/*
	Name: function_ce24f67b
	Namespace: namespace_8b80898c
	Checksum: 0x7C9EDD4
	Offset: 0x5A28
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_ce24f67b()
{
	nd_entry = getvehiclenode("pegasus_exit_start", "targetname");
	var_b56bded7 = undefined;
	while(!isdefined(var_b56bded7))
	{
		var_b56bded7 = spawner::simple_spawn_single("cam_vehicle");
		waitframe(1);
	}
	var_b56bded7 setteam(#"allies");
	var_b56bded7.origin = nd_entry.origin;
	var_b56bded7.angles = nd_entry.angles;
	self linkto(var_b56bded7);
	var_b56bded7 thread scene::play("aib_zm_red_vign_peg_inair_flight_cycle_01", "loop", self);
	var_b56bded7 vehicle::get_on_and_go_path(nd_entry);
	var_b56bded7 delete();
}

/*
	Name: function_4b198b8f
	Namespace: namespace_8b80898c
	Checksum: 0xB7C8449E
	Offset: 0x5B60
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_4b198b8f(a_ents)
{
	var_10d4f67d = a_ents[#"hash_7aff0ee60ddd937b"];
	if(isdefined(var_10d4f67d))
	{
		var_10d4f67d setteam(#"allies");
		var_10d4f67d thread scene::play("aib_zm_red_vign_peg_inair_flapattack_01", "loop", var_10d4f67d);
	}
}

/*
	Name: function_1e9b5c67
	Namespace: namespace_8b80898c
	Checksum: 0x1B4CA79E
	Offset: 0x5BE8
	Size: 0x224
	Parameters: 0
	Flags: Linked
*/
function function_1e9b5c67()
{
	var_81f76694 = getent("pegasus_cloud", "targetname");
	var_81f76694 clientfield::set("" + #"hash_5e74ad0afcfe7364", 1);
	var_81f76694 clientfield::increment("" + #"hash_19edb07afd0faeb7");
	wait(1);
	level flag::wait_till(#"hash_7fc5886c894cf1f4");
	wait(2);
	foreach(ai_zombie in getaiteamarray(level.zombie_team))
	{
		if(isdefined(ai_zombie.var_ae4569d5) && ai_zombie.var_ae4569d5)
		{
			ai_zombie zombie_utility::set_zombie_run_cycle("walk");
		}
	}
	s_poi = struct::get("s_poi_amphitheater");
	s_poi zm_utility::create_zombie_point_of_interest(800, 32, 10000);
	level flag::wait_till(#"hash_4d8091aa6a26d815");
	s_poi zm_utility::deactivate_zombie_point_of_interest();
	var_81f76694 clientfield::set("" + #"hash_5e74ad0afcfe7364", 0);
}

/*
	Name: function_31a4a4d9
	Namespace: namespace_8b80898c
	Checksum: 0x73319ECA
	Offset: 0x5E18
	Size: 0x174
	Parameters: 1
	Flags: None
*/
function function_31a4a4d9(a_players)
{
	level endon(#"hash_50172adaa660c417");
	while(true)
	{
		for(i = 0; i < a_players.size; i++)
		{
			if(zm_utility::is_player_valid(a_players[i]))
			{
				a_players[i].a_targets = a_players[i] function_763444ff();
				for(j = 0; j < 5; j++)
				{
					if(isdefined(a_players[i]) && isdefined(a_players[i].a_targets) && isalive(a_players[i].a_targets[j]))
					{
						self thread function_208a0da4(a_players[i].a_targets[j]);
					}
				}
				wait(randomfloatrange(0.25, 0.5));
			}
		}
		wait(0.5);
	}
}

/*
	Name: function_c4f5840a
	Namespace: namespace_8b80898c
	Checksum: 0xC84F52AD
	Offset: 0x5F98
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_c4f5840a()
{
	level endon(#"hash_6471231d75af61b9");
	while(true)
	{
		level.var_10d4f67d waittill(#"hash_650e71405864012e");
		level.var_10d4f67d function_c0e19f04();
		level.var_10d4f67d thread function_75162692(level.var_b26291ed, 3);
		level.var_10d4f67d thread function_75162692(level.var_bc021123, 3);
	}
}

/*
	Name: function_75162692
	Namespace: namespace_8b80898c
	Checksum: 0xA6A28EFC
	Offset: 0x6050
	Size: 0x8E
	Parameters: 2
	Flags: Linked
*/
function function_75162692(a_ai_zombies, var_4f9e00cf)
{
	if(isdefined(a_ai_zombies) && a_ai_zombies.size)
	{
		for(i = 0; i < var_4f9e00cf; i++)
		{
			if(isalive(a_ai_zombies[i]))
			{
				level.var_10d4f67d thread function_208a0da4(a_ai_zombies[i]);
			}
		}
	}
}

/*
	Name: function_c0e19f04
	Namespace: namespace_8b80898c
	Checksum: 0xDB505594
	Offset: 0x60E8
	Size: 0x23E
	Parameters: 0
	Flags: Linked
*/
function function_c0e19f04()
{
	level.var_b26291ed = [];
	level.var_bc021123 = [];
	a_ai_zombies = getaiteamarray(level.zombie_team);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(isalive(ai_zombie) && (isdefined(ai_zombie.var_ae4569d5) && ai_zombie.var_ae4569d5) && (!(isdefined(ai_zombie.var_45bfef99) && ai_zombie.var_45bfef99)))
		{
			n_dot = self math::get_dot_right(ai_zombie.origin);
			if(n_dot > 0)
			{
				if(!isdefined(level.var_b26291ed))
				{
					level.var_b26291ed = [];
				}
				else if(!isarray(level.var_b26291ed))
				{
					level.var_b26291ed = array(level.var_b26291ed);
				}
				level.var_b26291ed[level.var_b26291ed.size] = ai_zombie;
				continue;
			}
			if(!isdefined(level.var_bc021123))
			{
				level.var_bc021123 = [];
			}
			else if(!isarray(level.var_bc021123))
			{
				level.var_bc021123 = array(level.var_bc021123);
			}
			level.var_bc021123[level.var_bc021123.size] = ai_zombie;
		}
	}
}

/*
	Name: function_208a0da4
	Namespace: namespace_8b80898c
	Checksum: 0x88333E5D
	Offset: 0x6330
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function function_208a0da4(ai_zombie)
{
	ai_zombie endon(#"death");
	if(isdefined(ai_zombie.aat_turned) && ai_zombie.aat_turned || (isdefined(ai_zombie.var_c6aafbdb) && ai_zombie.var_c6aafbdb))
	{
		return;
	}
	if(isalive(ai_zombie) && (!(isdefined(ai_zombie.var_45bfef99) && ai_zombie.var_45bfef99)))
	{
		ai_zombie.var_45bfef99 = 1;
		n_dot = self math::get_dot_right(ai_zombie.origin);
		if(n_dot > 0)
		{
			ai_zombie clientfield::set("" + #"hash_76696d393fa512bf", 2);
		}
		else
		{
			ai_zombie clientfield::set("" + #"hash_76696d393fa512bf", 1);
		}
		ai_zombie thread function_52a818f();
	}
}

/*
	Name: function_52a818f
	Namespace: namespace_8b80898c
	Checksum: 0x6D53A85
	Offset: 0x64A8
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_52a818f()
{
	self endon(#"death");
	self ai::stun();
	self thread zm_perk_electric_cherry::electric_cherry_death_fx();
	self clientfield::set("tesla_shock_eyes_fx", 1);
	if(self.archetype == #"zombie")
	{
		function_6eac4ca1(self, "electrocute");
	}
	wait(0.5);
	self ai::function_62795e55();
	self clientfield::set("tesla_shock_eyes_fx", 0);
	if(!zm_utility::is_magic_bullet_shield_enabled(self))
	{
		gibserverutils::annihilate(self);
		self kill();
	}
}

/*
	Name: function_56c68db
	Namespace: namespace_8b80898c
	Checksum: 0xF78F5000
	Offset: 0x65D8
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function function_56c68db()
{
	level endon(#"hash_6471231d75af61b9");
	level flag::wait_till(#"hash_7fc5886c894cf1f4");
	var_69b8b63f = array::randomize(level.var_26450f62);
	foreach(var_f7473111 in var_69b8b63f)
	{
		if(isdefined(var_f7473111))
		{
			while(getaiteamarray("axis").size >= 32)
			{
				wait(0.1);
			}
			var_f7473111 thread zm_red::function_a4e2970b(1);
			wait(0.1);
		}
	}
}

/*
	Name: function_763444ff
	Namespace: namespace_8b80898c
	Checksum: 0x608A69C0
	Offset: 0x66F8
	Size: 0x192
	Parameters: 0
	Flags: Linked
*/
function function_763444ff()
{
	self endon(#"death");
	a_ai_zombies = array::get_all_closest(self.origin, getaispeciesarray(level.zombie_team, "all"), undefined, 4, 500);
	var_45a4e11d = [];
	foreach(ai_zombie in a_ai_zombies)
	{
		if(isdefined(ai_zombie.var_ae4569d5) && ai_zombie.var_ae4569d5)
		{
			if(!isdefined(var_45a4e11d))
			{
				var_45a4e11d = [];
			}
			else if(!isarray(var_45a4e11d))
			{
				var_45a4e11d = array(var_45a4e11d);
			}
			var_45a4e11d[var_45a4e11d.size] = ai_zombie;
		}
	}
	var_45a4e11d = array::get_all_closest(self.origin, getaispeciesarray(level.zombie_team, "all"), undefined, 4, 500);
	return var_45a4e11d;
}

/*
	Name: function_22230e37
	Namespace: namespace_8b80898c
	Checksum: 0x3ECBFB5D
	Offset: 0x6898
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_22230e37()
{
	var_8ded56d0 = getent("vol_power_quest_kill_zone", "targetname");
	a_players = getplayers();
	var_1679e8e = [];
	foreach(player in a_players)
	{
		if(isdefined(var_8ded56d0) && player istouching(var_8ded56d0))
		{
			var_1679e8e[var_1679e8e.size] = player;
			player.var_fd141207 = 1;
		}
	}
	return var_1679e8e;
}

/*
	Name: function_3c2c7054
	Namespace: namespace_8b80898c
	Checksum: 0x987EE09E
	Offset: 0x69A8
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function function_3c2c7054()
{
	level endon(#"end_game");
	while(true)
	{
		foreach(e_player in util::get_active_players())
		{
			if(zm_utility::is_player_valid(e_player, 0, 0))
			{
				return;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_4fe65f31
	Namespace: namespace_8b80898c
	Checksum: 0xBFB5BDA1
	Offset: 0x6A68
	Size: 0xB2
	Parameters: 2
	Flags: None
*/
function function_4fe65f31(n_zombies, n_timeout)
{
	level endon(#"end_game");
	n_start_time = gettime();
	while(true)
	{
		if(getaiteamarray(level.zombie_team).size <= n_zombies)
		{
			return;
		}
		n_time_passed = float(gettime() - n_start_time) / 1000;
		if(n_time_passed >= n_timeout)
		{
			return;
		}
		waitframe(1);
	}
}

/*
	Name: function_72d7e85b
	Namespace: namespace_8b80898c
	Checksum: 0xB4ABE1F5
	Offset: 0x6B28
	Size: 0x2E4
	Parameters: 3
	Flags: None
*/
function function_72d7e85b(var_1c6bf395, var_29826eea, n_timeout)
{
	level endon(#"end_game");
	if(!isdefined(var_1c6bf395))
	{
		var_1c6bf395 = [];
	}
	else if(!isarray(var_1c6bf395))
	{
		var_1c6bf395 = array(var_1c6bf395);
	}
	if(!isdefined(var_29826eea))
	{
		var_29826eea = [];
	}
	else if(!isarray(var_29826eea))
	{
		var_29826eea = array(var_29826eea);
	}
	foreach(n_section in var_1c6bf395)
	{
		level thread function_b8848794(n_section);
	}
	foreach(n_section in var_29826eea)
	{
		if(isinarray(level.var_2f2b78fb.var_a651e043, n_section))
		{
			arrayremovevalue(var_29826eea, n_section);
		}
	}
	if(var_29826eea.size > 0)
	{
		n_start_time = gettime();
		while(true)
		{
			foreach(n_section in var_29826eea)
			{
				if(isinarray(level.var_2f2b78fb.var_a651e043, n_section))
				{
					arrayremovevalue(var_29826eea, n_section);
				}
			}
			n_time_passed = float(gettime() - n_start_time) / 1000;
			if(var_29826eea.size == 0 || n_time_passed >= n_timeout)
			{
				break;
			}
			waitframe(1);
		}
	}
	function_3c2c7054();
}

/*
	Name: function_b8848794
	Namespace: namespace_8b80898c
	Checksum: 0x6710C696
	Offset: 0x6E18
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function function_b8848794(n_section, n_delay = 0.5)
{
	if(!isdefined(n_section))
	{
		return;
	}
	level endon(#"end_game");
	var_69b8b63f = array::randomize(level.var_2f2b78fb.var_9400690b[n_section]);
	foreach(var_f7473111 in var_69b8b63f)
	{
		if(isdefined(var_f7473111))
		{
			var_f7473111 thread zm_red::function_a4e2970b(1);
			if(n_delay > 0)
			{
				wait(0.5);
			}
		}
	}
}

/*
	Name: reinforcements_think
	Namespace: namespace_8b80898c
	Checksum: 0x19B49CDF
	Offset: 0x6F30
	Size: 0x300
	Parameters: 3
	Flags: None
*/
function reinforcements_think(var_17e78c4a, var_f153be86 = 0, var_a294702 = 0)
{
	level endon(#"end_game", #"hash_a3780ca3fcd7d5f", #"hash_4d8091aa6a26d815");
	var_eb3b90d = struct::get_array(var_17e78c4a);
	var_8e8ab42 = array::randomize(var_eb3b90d);
	while(true)
	{
		if(getaiteamarray(level.zombie_team).size < level.zombie_ai_limit)
		{
			var_d27a6650 = math::cointoss(25);
			if(!var_a294702)
			{
				var_d27a6650 = 0;
			}
			while(true)
			{
				if(var_8e8ab42.size == 0)
				{
					var_8e8ab42 = array::randomize(var_eb3b90d);
				}
				if(var_d27a6650)
				{
					ai_zombie = namespace_bc12435c::function_1ea880bd(1, var_8e8ab42[0]);
				}
				else
				{
					ai_zombie = zombie_utility::spawn_zombie(array::random(level.zombie_spawners), undefined, var_8e8ab42[0]);
				}
				if(isdefined(ai_zombie))
				{
					break;
				}
				waitframe(1);
			}
			arrayremoveindex(var_8e8ab42, 0);
			if(!var_d27a6650)
			{
				namespace_3fffba66::function_5db4f2f5(ai_zombie);
			}
			ai_zombie.var_126d7bef = 1;
			ai_zombie.ignore_round_spawn_failsafe = 1;
			ai_zombie.b_ignore_cleanup = 1;
			ai_zombie.ignore_enemy_count = 1;
			ai_zombie.no_powerups = 1;
			ai_zombie.var_12745932 = 1;
			ai_zombie.var_ae4569d5 = 1;
			if(var_f153be86)
			{
				ai_zombie.maxhealth = ai_zombie.maxhealth * 2;
				ai_zombie.health = ai_zombie.health * 2;
			}
			ai_zombie thread function_2a80a9cc();
		}
		n_random_wait = randomfloatrange(level.var_2f2b78fb.var_92cdd7d9, level.var_2f2b78fb.var_a7a8788a);
		wait(n_random_wait);
	}
}

/*
	Name: function_2a80a9cc
	Namespace: namespace_8b80898c
	Checksum: 0x7362D332
	Offset: 0x7238
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function function_2a80a9cc(var_6f24f431 = 0, b_sprint = 0)
{
	self endon(#"death");
	waitframe(1);
	self.completed_emerging_into_playable_area = 1;
	self notify(#"completed_emerging_into_playable_area");
	if(level flag::get(#"hash_7fc5886c894cf1f4"))
	{
		return;
	}
	if(math::cointoss(level.var_2f2b78fb.var_5579012f) || var_6f24f431 || b_sprint)
	{
		self.var_f6fe2733 = 1;
		if(math::cointoss(level.var_2f2b78fb.var_30c1e68b) || b_sprint)
		{
			self zombie_utility::set_zombie_run_cycle("sprint");
		}
		else
		{
			self zombie_utility::set_zombie_run_cycle("run");
		}
	}
}

/*
	Name: function_75c83fbf
	Namespace: namespace_8b80898c
	Checksum: 0x92D89872
	Offset: 0x7380
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_75c83fbf(s_params)
{
	e_attacker = s_params.eattacker;
	if(isplayer(e_attacker) && (isdefined(self.var_ae4569d5) && self.var_ae4569d5))
	{
		if(zombie_utility::function_6403cf83(#"zombie_powerup_double_points_on", #"allies"))
		{
			n_points = 20;
		}
		else
		{
			n_points = 10;
		}
		e_attacker thread zm_score::add_to_player_score(n_points, 1, "");
	}
}

/*
	Name: function_d8db57f6
	Namespace: namespace_8b80898c
	Checksum: 0x98B63DFA
	Offset: 0x7450
	Size: 0x3C4
	Parameters: 0
	Flags: Linked
*/
function function_d8db57f6()
{
	level endon(#"end_game", #"hash_420b070435236eab", #"hash_4d8091aa6a26d815");
	var_71da3f5a = getentarray("mdl_power_skeleton", "targetname");
	array::run_all(var_71da3f5a, &show);
	foreach(var_3e9d57b3 in var_71da3f5a)
	{
		v_origin = var_3e9d57b3.origin;
		v_angles = var_3e9d57b3.angles;
		a_info = zm_utility::function_b0eeaada(v_origin + vectorscale((0, 0, 1), 64));
		if(isdefined(a_info) && isdefined(a_info[#"point"]))
		{
			v_origin = a_info[#"point"];
		}
		s_spawn = struct::spawn(v_origin, v_angles);
		while(true)
		{
			var_862206ea = namespace_bc12435c::function_1ea880bd(1, s_spawn, level.round_number);
			if(isdefined(var_862206ea))
			{
				break;
			}
			waitframe(1);
		}
		var_862206ea thread function_f95a14a0();
		mdl_clip = getent(var_3e9d57b3.target, "targetname");
		s_spawn struct::delete();
		if(zm_utility::function_3bff983f())
		{
			mdl_clip thread zm_red::function_19a28e98();
			var_3e9d57b3 thread zm_red::function_19a28e98();
		}
		else
		{
			mdl_clip delete();
			var_3e9d57b3 delete();
		}
		n_random_wait = randomfloatrange(0.1, 0.5);
		wait(n_random_wait);
	}
	wait(3);
	function_350204ca(#"hash_6e38772014019f10");
	level flag::wait_till(#"hash_5ab27713447940f3");
	var_1679e8e = function_22230e37();
	if(isdefined(var_1679e8e))
	{
		player = array::random(var_1679e8e);
		if(zm_utility::is_player_valid(player))
		{
			player namespace_891c9bac::function_a2bd5a0c(#"hash_5c714f3566f4c4", 0.5, 1, 9999, 1);
		}
	}
}

/*
	Name: function_f95a14a0
	Namespace: namespace_8b80898c
	Checksum: 0xBD98271D
	Offset: 0x7820
	Size: 0x39C
	Parameters: 0
	Flags: Linked
*/
function function_f95a14a0()
{
	self endon(#"death");
	self thread function_9cf59384();
	s_scene = array::get_all_closest(self.origin, struct::get_array("s_spartoi_spawnpt"))[0];
	self.e_linkto = util::spawn_model("tag_origin", self.origin, self.angles);
	if(isdefined(self.e_linkto))
	{
		self linkto(self.e_linkto);
	}
	self ghost();
	self notsolid();
	self val::set(#"hash_65edbe063d05f17b", "ignoreall", 1);
	self.var_126d7bef = 1;
	self.ignore_round_spawn_failsafe = 1;
	self.b_ignore_cleanup = 1;
	self.ignore_enemy_count = 1;
	self.no_powerups = 1;
	self.var_ae4569d5 = 1;
	self solid();
	waitframe(1);
	if(isdefined(self.e_linkto))
	{
		self.e_linkto.angles = s_scene.angles;
	}
	var_704f0f40 = #"hash_76de0304e060bae4";
	switch(self.var_9fde8624)
	{
		case "hash_fd7b9665529dd42":
		{
			var_704f0f40 = #"hash_21cc4ecb5263f2fd";
			break;
		}
		case "skeleton_spear":
		{
			var_704f0f40 = #"hash_3991ae9fa82906a2";
			break;
		}
		case "hash_1520c8987a671df0":
		{
			var_704f0f40 = #"hash_4b06db801e96b3db";
			break;
		}
	}
	s_scene.angles = (s_scene.angles[0], s_scene.angles[1] + 90, s_scene.angles[2]);
	s_scene scene::play(var_704f0f40);
	self show();
	if(isdefined(self.e_linkto))
	{
		self.e_linkto delete();
	}
	self val::reset(#"hash_65edbe063d05f17b", "ignoreall");
	if(zm_utility::function_3bff983f())
	{
		s_scene thread zm_red::function_19a28e98();
	}
	else
	{
		s_scene struct::delete();
	}
	self waittill(#"hash_782dbc5eec90f62f");
	level flag::set(#"hash_5ab27713447940f3");
}

/*
	Name: function_9cf59384
	Namespace: namespace_8b80898c
	Checksum: 0xB955A1ED
	Offset: 0x7BC8
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_9cf59384()
{
	self waittill(#"death");
	if(level flag::get("round_reset") && !level flag::get(#"hash_78334a5d5a02e966"))
	{
		level thread function_1f25fb54();
		return;
	}
	level.var_5cc61d5f++;
	if(level.var_5cc61d5f > 2)
	{
		level flag::set(#"hash_78334a5d5a02e966");
	}
}

/*
	Name: function_1f25fb54
	Namespace: namespace_8b80898c
	Checksum: 0x11594525
	Offset: 0x7C88
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_1f25fb54()
{
	self notify("425f8e7d1e805a1b");
	self endon("425f8e7d1e805a1b");
	level.var_5cc61d5f = 0;
	var_71da3f5a = getentarray("mdl_power_skeleton", "targetname");
	array::run_all(var_71da3f5a, &show);
	namespace_f551babc::function_ae725d63(0);
	foreach(var_3e9d57b3 in var_71da3f5a)
	{
		var_3e9d57b3 show();
	}
	wait(8);
	level thread function_d8db57f6();
}

/*
	Name: function_be2e3f06
	Namespace: namespace_8b80898c
	Checksum: 0xD82342AB
	Offset: 0x7DB0
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function function_be2e3f06(a_ents)
{
	var_10d4f67d = a_ents[#"hash_7aff0ee60ddd937b"];
	if(!isdefined(var_10d4f67d))
	{
		return;
	}
	var_10d4f67d setteam(#"allies");
	var_10d4f67d clientfield::increment("" + #"hash_19edb07afd0faeb7");
	var_10d4f67d thread function_342bd17b();
	level waittill(#"hash_28fd121552fe5ef3");
	level flag::set(#"hash_6471231d75af61b9");
}

/*
	Name: function_342bd17b
	Namespace: namespace_8b80898c
	Checksum: 0xB9C4CE3
	Offset: 0x7E90
	Size: 0x4A0
	Parameters: 0
	Flags: Linked
*/
function function_342bd17b()
{
	self endon(#"death");
	s_center = struct::get(#"hash_4ede0d513d23996b");
	v_center = s_center.origin;
	while(true)
	{
		self waittill(#"zombie_melee");
		level notify(#"hash_a3780ca3fcd7d5f");
		var_5f1a008f = [];
		var_e87293a = [];
		foreach(ai_zombie in getaiteamarray(level.zombie_team))
		{
			n_dot = self math::get_dot_right(ai_zombie.origin);
			if(n_dot > 0)
			{
				if(!isdefined(var_5f1a008f))
				{
					var_5f1a008f = [];
				}
				else if(!isarray(var_5f1a008f))
				{
					var_5f1a008f = array(var_5f1a008f);
				}
				var_5f1a008f[var_5f1a008f.size] = ai_zombie;
				continue;
			}
			if(!isdefined(var_e87293a))
			{
				var_e87293a = [];
			}
			else if(!isarray(var_e87293a))
			{
				var_e87293a = array(var_e87293a);
			}
			var_e87293a[var_e87293a.size] = ai_zombie;
		}
		var_e87293a = arraysortclosest(var_e87293a, v_center, 5);
		var_5f1a008f = arraysortclosest(var_5f1a008f, v_center, 5);
		var_d5d04666 = [];
		foreach(ai_zombie in var_5f1a008f)
		{
			if(!isdefined(var_d5d04666))
			{
				var_d5d04666 = [];
			}
			else if(!isarray(var_d5d04666))
			{
				var_d5d04666 = array(var_d5d04666);
			}
			var_d5d04666[var_d5d04666.size] = array(ai_zombie, #"right");
		}
		foreach(ai_zombie in var_e87293a)
		{
			if(!isdefined(var_d5d04666))
			{
				var_d5d04666 = [];
			}
			else if(!isarray(var_d5d04666))
			{
				var_d5d04666 = array(var_d5d04666);
			}
			var_d5d04666[var_d5d04666.size] = array(ai_zombie, #"left");
		}
		var_d5d04666 = array::randomize(var_d5d04666);
		foreach(i, a_info in var_d5d04666)
		{
			ai_zombie = a_info[0];
			str_side = a_info[1];
			if(!isdefined(ai_zombie))
			{
				continue;
			}
			ai_zombie thread function_f38b76b1(str_side);
			if(i < var_d5d04666.size)
			{
				waitframe(2);
			}
		}
	}
}

/*
	Name: function_f38b76b1
	Namespace: namespace_8b80898c
	Checksum: 0xB9DF9456
	Offset: 0x8338
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_f38b76b1(str_side)
{
	self endon(#"death");
	if(zm_utility::is_magic_bullet_shield_enabled(self))
	{
		return;
	}
	if(str_side == #"right")
	{
		self clientfield::increment("" + #"hash_1bdce857fd614cef");
	}
	else
	{
		self clientfield::increment("" + #"hash_2856f87ecdfaf62");
	}
	waitframe(1);
	if(zm_utility::is_magic_bullet_shield_enabled(self))
	{
		return;
	}
	gibserverutils::annihilate(self);
	self kill();
}

/*
	Name: function_ae259e17
	Namespace: namespace_8b80898c
	Checksum: 0xC8C76189
	Offset: 0x8438
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_ae259e17(v_origin)
{
	var_ea4f0ca0 = spawner::simple_spawn_single("sp_power_quest_energy_trails");
	var_fc16302e = spawner::simple_spawn_single("sp_power_quest_energy_trails");
	var_86ea9611 = getvehiclenode("nd_power_quest_energy_trail_1", "targetname");
	var_f2d66de7 = getvehiclenode("nd_power_quest_energy_trail_2", "targetname");
	var_86ea9611.origin = v_origin;
	var_f2d66de7.origin = v_origin;
	var_ea4f0ca0 thread function_1984219e(var_86ea9611);
	var_fc16302e thread function_1984219e(var_f2d66de7);
}

/*
	Name: function_1984219e
	Namespace: namespace_8b80898c
	Checksum: 0xD1B2C9F8
	Offset: 0x8530
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_1984219e(nd_start)
{
	self endon(#"death");
	self clientfield::set("" + #"hash_463ff879b8d656bb", 1);
	self vehicle::get_on_and_go_path(nd_start);
	self clientfield::set("" + #"hash_463ff879b8d656bb", 0);
	self playsound(#"hash_3fc47e14a55e5bbc");
	self delete();
}

/*
	Name: function_350204ca
	Namespace: namespace_8b80898c
	Checksum: 0x377B91BC
	Offset: 0x8600
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_350204ca(str_vo)
{
	var_1679e8e = function_22230e37();
	if(isdefined(var_1679e8e))
	{
		player = array::random(var_1679e8e);
		if(zm_utility::is_player_valid(player))
		{
			player namespace_891c9bac::function_a2bd5a0c(str_vo, 0, 1, 9999, 1);
		}
	}
}

/*
	Name: function_e940b2ce
	Namespace: namespace_8b80898c
	Checksum: 0x9D04C3DD
	Offset: 0x8698
	Size: 0x2C4
	Parameters: 0
	Flags: None
*/
function function_e940b2ce()
{
	/#
		level flag::set(#"hash_dc34ebe02d09532");
		level flag::set(#"hash_3dba794053dea40e");
		level flag::set(#"hash_3db8e78cda787136");
		level flag::set(#"hash_78334a5d5a02e966");
		level flag::set(#"hash_6471231d75af61b9");
		level flag::set(#"hash_4d8091aa6a26d815");
		level flag::set(#"hash_787f723b2f0d72f9");
		var_71da3f5a = getentarray("", "");
		foreach(var_3e9d57b3 in var_71da3f5a)
		{
			if(isdefined(var_3e9d57b3))
			{
				var_3e9d57b3 delete();
			}
		}
		foreach(var_f7473111 in level.var_26450f62)
		{
			if(isdefined(var_f7473111))
			{
				var_f7473111 delete();
			}
		}
		level flag::set(#"hash_3db8e78cda787136");
		level flag::set(#"hash_78334a5d5a02e966");
		level flag::wait_till("");
		level flag::wait_till("");
		level flag::set(#"hash_420b070435236eab");
		function_e059d0e1();
	#/
}

