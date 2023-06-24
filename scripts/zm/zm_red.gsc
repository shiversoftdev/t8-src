// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14af1fd264ffe8cc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_audio_sq.gsc;
#using scripts\zm_common\zm_transformation.gsc;
#using scripts\zm\zm_red_special_rounds.gsc;
#using scripts\zm\zm_red_achievement.gsc;
#using scripts\zm\zm_red_oracle_boons.gsc;
#using scripts\zm\zm_red_power_quest.gsc;
#using scripts\abilities\ability_player.gsc;
#using scripts\zm\weapons\zm_weap_bowie.gsc;
#using script_3aa54d3cb36ea43f;
#using scripts\zm_common\zm_fasttravel.gsc;
#using scripts\zm\weapons\zm_weap_hand_ouranos.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm\weapons\zm_weap_riotshield.gsc;
#using scripts\zm\powerup\zm_powerup_hero_weapon_power.gsc;
#using scripts\zm_common\zm_items.gsc;
#using scripts\zm\zm_red_boss_battle.gsc;
#using scripts\zm_common\zm_crafting.gsc;
#using script_4d00889cf8c807d5;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm\zm_red_trials.gsc;
#using scripts\zm_common\zm_round_spawning.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm\zm_red_trap_boiling_bath.gsc;
#using scripts\zm\zm_red_ww_quests.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm\zm_red_main_quest.gsc;
#using script_65930a0d8e6a77c2;
#using script_6c983b627f4a3d51;
#using scripts\zm\weapons\zm_weap_hand_charon.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm\weapons\zm_weap_thunderstorm.gsc;
#using scripts\zm\weapons\zm_weap_hand_hemera.gsc;
#using scripts\zm_common\zm_wallbuy.gsc;
#using scripts\zm\weapons\zm_weap_hand_gaia.gsc;
#using scripts\zm\ai\zm_ai_gegenees.gsc;
#using scripts\zm\zm_red_fasttravel.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_red_challenges.gsc;
#using scripts\zm\zm_red_ffotd.gsc;
#using scripts\zm\zm_red_gamemodes.gsc;
#using scripts\zm\zm_red_pap_quest.gsc;
#using scripts\zm\zm_red_util.gsc;
#using scripts\zm\zm_red_zones.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\load.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_red;

/*
	Name: opt_in
	Namespace: zm_red
	Checksum: 0xE64B71AE
	Offset: 0xC78
	Size: 0xB4
	Parameters: 0
	Flags: AutoExec
*/
function autoexec opt_in()
{
	level.aat_in_use = 1;
	level.bgb_in_use = 1;
	level.bgb_machine_count = 2;
	level.random_pandora_box_start = 1;
	level.zombie_round_start_delay = 0;
	level.var_3a382f82 = 0.1;
	level.var_1f1de1ef = 1;
	level.pack_a_punch_camo_index = 74;
	level.pack_a_punch_camo_index_number_variants = 5;
	init_flags();
	zm_red_pap_quest::function_90a833e2();
}

/*
	Name: main
	Namespace: zm_red
	Checksum: 0x8487358F
	Offset: 0xD38
	Size: 0xDF4
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	level._uses_default_wallbuy_fx = 1;
	level._uses_sticky_grenades = 1;
	level._uses_taser_knuckles = 1;
	level.var_a5689564 = &zm_red_fasttravel::function_a5689564;
	level.var_e9737821 = &zm_red_fasttravel::function_c52e8ba;
	level.var_829d6a97 = &zm_red_fasttravel::function_ae5d684b;
	level.var_a5a050c1 = 15;
	level.var_9d19ea6d = 1;
	level.var_ce0f67cf = 120;
	level.var_a38d293a = 120;
	level.var_304d38af = &zm_red_util::function_f0ed2a66;
	level.var_45b0f2f3 = &function_443f6873;
	level.var_5a2df97b = &function_fbf0e632;
	ability_player::register_gadget_possession_callbacks(6, &function_f2427bae);
	zm::init_fx();
	clientfield::register("clientuimodel", "player_lives", 16000, 2, "int");
	clientfield::register("scriptmover", "" + #"register_pegasus", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"special_target", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"medusa_eyes", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_2856f87ecdfaf62", 16000, 1, "counter");
	clientfield::register("actor", "" + #"hash_1bdce857fd614cef", 16000, 1, "counter");
	clientfield::register("world", "" + #"postfx_play", 16000, 2, "int");
	clientfield::register("world", "" + #"hash_71f9fcfb2cd84a9c", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"eye_vignette", 16000, 1, "int");
	level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
	level._effect[#"switch_sparks"] = #"electric/fx8_sparks_burst_dir_sm_orange_os";
	level.default_start_location = "zone_temple_of_apollo";
	level.default_game_mode = "zclassic";
	level.var_22fda912 = &function_9f50079d;
	level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
	if(zm_custom::function_901b751c(#"zmpowerdoorstate") == 0)
	{
		level.var_d5bd7049 = "";
	}
	else
	{
		level.var_d5bd7049 = #"hash_3ca4508c9597fd12";
	}
	level.pack_a_punch.custom_power_think = &zm_red_pap_quest::function_9b917fd5;
	level.var_c02e63 = &function_c02e63;
	level.var_d0ab70a2 = #"hash_27415a2cb947e75";
	level._allow_melee_weapon_switching = 1;
	level.zombiemode_reusing_pack_a_punch = 1;
	level.custom_spawner_entry[#"crawl"] = &zm_spawner::function_45bb11e4;
	level.move_spawn_func = &function_a5f3cb45;
	level.var_6f6cc58 = &function_6f6cc58;
	level.var_4e4950d1 = &function_4e4950d1;
	level.var_21326085 = 1;
	level._no_vending_machine_auto_collision = 1;
	level thread sndfunctions();
	zm_red_achievement::init();
	zm_red_fasttravel::init();
	zm_red_trap_boiling_bath::init();
	namespace_f2050961::init();
	zm_red_ww_quests::init();
	zm_red_pap_quest::init();
	zm_red_power_quest::init();
	zm_red_main_quest::init();
	zm_red_challenges::init();
	zm_red_util::init();
	red_boss_battle::init();
	zm_audio_sq::init();
	load::main();
	scene::add_scene_func(#"hash_649bf4517c6d8d25", &function_509bbc5b, "sh290");
	scene::add_scene_func(#"hash_649bf4517c6d8d25", &function_924ba3d, "sh320");
	scene::add_scene_func(#"hash_649bf4517c6d8d25", &function_bff9977d, "sh330");
	scene::add_scene_func(#"hash_649bf4517c6d8d25", &function_5b984671, "play");
	scene::add_scene_func(#"hash_649bf4517c6d8d25", &function_ea8d45ef, "done");
	scene::add_scene_func(#"hash_29e069a70818e58f", &function_b5670bb7, "play");
	scene::add_scene_func(#"hash_29e069a70818e58f", &function_75ef7b1f, "play");
	scene::add_scene_func(#"hash_29e069a70818e58f", &function_ea8d45ef, "done");
	scene::add_scene_func(#"hash_29e068a70818e3dc", &function_b648a6d9, "init");
	scene::add_scene_func(#"hash_29e068a70818e3dc", &function_883a1fb8, "play");
	scene::add_scene_func(#"hash_29e068a70818e3dc", &function_ea8d45ef, "done");
	level.vending_machines_powered_on_at_start = 1;
	level.var_42d80aa0 = 0;
	level.zones = [];
	level.zone_manager_init_func = &zm_red_zones::zone_init;
	level thread zm_zonemgr::manage_zones("zone_temple_of_apollo");
	level thread zm_red_zones::init();
	level thread zm_red_special_rounds::init();
	level thread zm_red_main_quest::main();
	zm_red_fasttravel::main();
	level thread function_3f6e4b5f();
	zm_blockers::function_6f01c3cf("start_open", "script_label");
	if(!getdvarint(#"hash_576506f1621c45d2", 0))
	{
		level thread function_c000f08b();
	}
	level.use_powerup_volumes = 1;
	/#
		level thread function_acb5b0ec();
	#/
	level.random_pandora_box_start = 1;
	level.magic_box_zbarrier_state_func = &zm_magicbox::function_35c66b27;
	level.chest_joker_model = "p8_fxanim_zm_zod_magic_box_skull_mod";
	level.chest_joker_custom_movement = &zm_magicbox::function_f5503c41;
	/#
		t_kill_ai = getent("", "");
		if(isdefined(t_kill_ai))
		{
			t_kill_ai callback::on_trigger(&function_d4ff1dd6);
		}
	#/
	if(zm_custom::function_901b751c(#"hash_4e0ec3fe56f08b47") == 2)
	{
		level flag::wait_till("magicbox_initialized");
		var_2d50e3c1 = level.chests[level.chest_index];
		level.chests = array::filter(level.chests, 0, &function_7e4ce7f8);
		level.chest_index = array::find(level.chests, var_2d50e3c1);
	}
	zm_crafting::function_d1f16587(#"hash_2c548d4a8ba1c9cc", &function_4479ec95);
	if(!zm_custom::function_901b751c(#"zmequipmentisenabled"))
	{
		level thread zm_crafting::function_ca244624(#"hash_3f832ccf78265a33");
	}
	level.zm_bgb_anywhere_but_here_validation_override = &function_598a6222;
	level.var_e120ae98 = &function_46159bb7;
	function_625a9bcf();
	function_8f72e6b8();
	zm_custom::function_a00576dd(&function_7722c6f0, undefined, &function_c8ce0a17, undefined);
	level.var_338bae81 = &function_338bae81;
	level.var_d99d49fd = &function_7c7c6a1;
	if(zm_utility::is_trials())
	{
		level.var_a601d6a6 = &function_95db9900;
		level.var_43216bdf = &function_28073e18;
		level thread function_269f27a9();
		level thread function_ea526b81();
	}
}

/*
	Name: function_95db9900
	Namespace: zm_red
	Checksum: 0x53A33832
	Offset: 0x1B38
	Size: 0x130
	Parameters: 1
	Flags: Linked, Private
*/
function private function_95db9900(weapon)
{
	if(weapon === level.w_hand_charon || weapon === level.w_hand_charon_charged || weapon === level.w_hand_charon_uncharged)
	{
		return level.w_hand_charon;
	}
	if(weapon === level.w_hand_gaia || weapon === level.w_hand_gaia_charged || weapon === level.w_hand_gaia_uncharged)
	{
		return level.w_hand_gaia;
	}
	if(weapon === level.w_hand_ouranos || weapon === level.w_hand_ouranos_charged || weapon === level.w_hand_ouranos_uncharged)
	{
		return level.w_hand_ouranos;
	}
	if(weapon === level.w_hand_hemera || weapon === level.w_hand_hemera_charged || weapon === level.w_hand_hemera_uncharged)
	{
		return level.w_hand_hemera;
	}
	return weapon;
}

/*
	Name: function_269f27a9
	Namespace: zm_red
	Checksum: 0x8BCD583C
	Offset: 0x1C70
	Size: 0x214
	Parameters: 0
	Flags: Linked, Private
*/
function private function_269f27a9()
{
	level.var_ab5b85bf = "bonus_points_team";
	n_players = getplayers().size;
	var_b67b53e8 = zombie_utility::function_d2dfacfd(#"hash_434b3261c607850" + n_players);
	var_ee327079 = zombie_utility::function_d2dfacfd(#"zombie_powerup_drop_max_" + n_players);
	zombie_utility::set_zombie_var(#"hash_434b3261c607850" + n_players, n_players * 5);
	zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_" + n_players, n_players * 5);
	level.var_1dce56cc = n_players * 5;
	while(isdefined(level.var_ab5b85bf))
	{
		waitframe(1);
	}
	if(getplayers().size == 1)
	{
		level.var_ab5b85bf = "bonus_points_team";
	}
	else
	{
		level.var_ab5b85bf = array::random(array("bonus_points_team", "double_points"));
	}
	zm_utility::function_fdb0368(4);
	zombie_utility::set_zombie_var(#"hash_434b3261c607850" + n_players, var_b67b53e8 + 3);
	zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_" + n_players, var_ee327079 + 3);
}

/*
	Name: function_28073e18
	Namespace: zm_red
	Checksum: 0xBD3B0547
	Offset: 0x1E90
	Size: 0x13C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_28073e18(b_game_ended)
{
	if(level.round_number == 1)
	{
		level thread function_cba532f6();
	}
	if(isdefined(level.var_ac6d10d4) && level.var_ac6d10d4)
	{
		level thread zm_red_power_quest::function_a5b8e88f(1);
	}
	if(isdefined(level.var_8aa0830e) && level.var_8aa0830e)
	{
		foreach(player in getplayers())
		{
			player thread function_6f63ad34();
		}
	}
	if(isdefined(level.var_c7e9961f) && level.var_c7e9961f)
	{
		level thread function_a47f80af();
	}
}

/*
	Name: function_a47f80af
	Namespace: zm_red
	Checksum: 0x6D1BD3C5
	Offset: 0x1FD8
	Size: 0xDC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a47f80af()
{
	self notify("4ae9dc40193a4f80");
	self endon("4ae9dc40193a4f80");
	level endon(#"egg_free");
	level flag::wait_till_clear("round_reset");
	mdl_blocker = getent("pap_arena_blocker", "targetname");
	if(isdefined(mdl_blocker))
	{
		mdl_blocker setinvisibletoall();
	}
	exploder::stop_exploder("Fxexp_barrier_pap");
	level waittill(#"pap_defend");
	exploder::exploder("Fxexp_barrier_pap");
}

/*
	Name: function_6f63ad34
	Namespace: zm_red
	Checksum: 0x1A3A6D11
	Offset: 0x20C0
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_6f63ad34()
{
	self endon(#"disconnect");
	level flag::wait_till_clear("round_reset");
	level thread zm_powerup_hero_weapon_power::hero_weapon_power(self);
}

/*
	Name: function_ea526b81
	Namespace: zm_red
	Checksum: 0xD93726EA
	Offset: 0x2118
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_ea526b81()
{
	level flag::wait_till(#"hash_7943879f3be8ccc6");
	level.var_5b175281 = level.check_for_valid_spawn_near_team_callback;
	level.check_for_valid_spawn_near_team_callback = &function_f0bd229;
	if(!level flag::get("zm_red_fasttravel_open"))
	{
		level zm_utility::function_fdb0368(10, "zm_red_fasttravel_open");
		if(!level flag::get("zm_red_fasttravel_open"))
		{
			level flag::set("zm_red_fasttravel_open");
			level thread function_a7641284();
		}
	}
	level.check_for_valid_spawn_near_team_callback = level.var_5b175281;
	level.var_5b175281 = undefined;
}

/*
	Name: function_a7641284
	Namespace: zm_red
	Checksum: 0x491120CD
	Offset: 0x2230
	Size: 0x1E8
	Parameters: 0
	Flags: Linked
*/
function function_a7641284()
{
	if(level flag::get(#"egg_free") || level flag::get(#"pap_quest_completed"))
	{
		return;
	}
	level endon(#"egg_free", #"pap_quest_completed");
	var_af2013df = array(#"hash_67695ee69c57c0b2", #"hash_61de3b8fe6f6a35");
	level flag::wait_till_all(var_af2013df);
	while(true)
	{
		wait(1);
		var_c91c19bb = 0;
		foreach(player in getplayers())
		{
			t_pap = getent("trigger_pap_defend", "targetname");
			if(isdefined(t_pap) && isalive(player) && player istouching(t_pap))
			{
				var_c91c19bb = 1;
				break;
			}
		}
		if(!var_c91c19bb)
		{
			function_a47f80af();
		}
	}
}

/*
	Name: function_f0bd229
	Namespace: zm_red
	Checksum: 0xD19690A0
	Offset: 0x2420
	Size: 0x60
	Parameters: 2
	Flags: Linked
*/
function function_f0bd229(player, var_feed7374)
{
	var_44841a74 = struct::get_array("s_trials_dark_side_spawn_points");
	n_ent_num = player getentitynumber();
	return var_44841a74[n_ent_num];
}

/*
	Name: function_dba42129
	Namespace: zm_red
	Checksum: 0xD40EB487
	Offset: 0x2488
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function function_dba42129(n_max, n_round)
{
	if(n_round == 1)
	{
		return 0;
	}
	return n_max;
}

/*
	Name: function_cba532f6
	Namespace: zm_red
	Checksum: 0x5EC5EADE
	Offset: 0x24C0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_cba532f6()
{
	level.check_for_valid_spawn_near_team_callback = &function_f8822ae1;
	array::wait_any(getplayers(), "round_reset_done");
	level.zombie_round_start_delay = 0;
	level.var_c54ec9bb = 1;
	level.noroundnumber = 1;
	level thread function_c000f08b();
}

/*
	Name: function_f8822ae1
	Namespace: zm_red
	Checksum: 0x1BC66626
	Offset: 0x2560
	Size: 0x60
	Parameters: 2
	Flags: Linked, Private
*/
function private function_f8822ae1(player, var_feed7374)
{
	var_b9083025 = struct::get_array("initial_spawn_points");
	n_ent_num = player getentitynumber();
	return var_b9083025[n_ent_num];
}

/*
	Name: init_flags
	Namespace: zm_red
	Checksum: 0x8B6765E1
	Offset: 0x25C8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"round_one");
	level flag::init(#"spartoi_resurrect");
	level flag::init(#"hash_6c92a415bd4bb739");
	level flag::init(#"pegasus_exited");
}

/*
	Name: function_3f6e4b5f
	Namespace: zm_red
	Checksum: 0xA29B7B86
	Offset: 0x2658
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_3f6e4b5f()
{
	if(zm_custom::function_901b751c(#"zmdoorstate") == 2)
	{
		zm_zonemgr::enable_zone("zone_temple_to_stoa_of_the_athenians");
	}
}

/*
	Name: function_4479ec95
	Namespace: zm_red
	Checksum: 0x7BF57A85
	Offset: 0x26A8
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_4479ec95(e_player)
{
	level.var_f9e5f55a = 1;
}

/*
	Name: function_7e4ce7f8
	Namespace: zm_red
	Checksum: 0xF41448B0
	Offset: 0x26D0
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_7e4ce7f8(s_chest)
{
	if(s_chest.script_noteworthy == "serpent_pass_chest" || s_chest.script_noteworthy == "cliff_tombs_chest")
	{
		return false;
	}
	return true;
}

/*
	Name: registermp_vehicles_agr_prespawn
	Namespace: zm_red
	Checksum: 0xC8168EBF
	Offset: 0x2728
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function registermp_vehicles_agr_prespawn(s_chest)
{
	if(s_chest.script_noteworthy == "serpent_pass_chest" || s_chest.script_noteworthy == "cliff_tombs_chest")
	{
		return true;
	}
	return false;
}

/*
	Name: function_c000f08b
	Namespace: zm_red
	Checksum: 0x1EB69DEA
	Offset: 0x2780
	Size: 0x954
	Parameters: 0
	Flags: Linked
*/
function function_c000f08b()
{
	level endon(#"end_game", #"hash_49085a6baf9c2c27");
	if(zm_custom::function_901b751c(#"zmenhancedstate") == 2 || zm_custom::function_901b751c(#"zmminibossstate") == 2 || zm_custom::function_901b751c(#"startround") > 1)
	{
		level thread function_12b9b9a9();
		return;
	}
	a_s_spawns = struct::get_array(#"hash_39721602c33f4cc7");
	/#
		if(getdvarint(#"zombie_cheat", 0) == 2)
		{
			level thread function_12b9b9a9();
			return;
		}
	#/
	level.no_powerups = 1;
	level flag::clear("spawn_zombies");
	level flag::set("pause_round_timeout");
	level flag::set("hold_round_end");
	level thread function_d7831b0f();
	level flag::wait_till("all_players_spawned");
	a_e_players = getplayers();
	n_players = a_e_players.size;
	n_spawn_limit = zm_round_logic::get_zombie_count_for_round(1, n_players);
	if(zm_utility::is_trials())
	{
		level.max_zombie_func = &function_dba42129;
		level flag::clear("hold_round_end");
	}
	var_27e96420 = [];
	level.a_starting_zombies = [];
	if(n_players > 1)
	{
		var_6d4778a1 = struct::get_array(#"hash_6acfe5efcae5340e");
		var_6d4778a1 = array::randomize(var_6d4778a1);
		if(!isdefined(a_s_spawns))
		{
			a_s_spawns = [];
		}
		else if(!isarray(a_s_spawns))
		{
			a_s_spawns = array(a_s_spawns);
		}
		a_s_spawns[a_s_spawns.size] = var_6d4778a1[0];
		if(!isdefined(a_s_spawns))
		{
			a_s_spawns = [];
		}
		else if(!isarray(a_s_spawns))
		{
			a_s_spawns = array(a_s_spawns);
		}
		a_s_spawns[a_s_spawns.size] = var_6d4778a1[1];
	}
	var_c51ddfeb = arraycopy(a_s_spawns);
	foreach(e_player in a_e_players)
	{
		if(var_c51ddfeb.size > 0)
		{
			var_c51ddfeb = array::randomize(var_c51ddfeb);
			if(isplayer(e_player))
			{
				v_player_forward = anglestoforward(e_player getplayerangles());
				foreach(s_spawn in a_s_spawns)
				{
					var_75d386a3 = vectornormalize(s_spawn.origin - e_player.origin);
					n_dot = vectordot(v_player_forward, var_75d386a3);
					if(n_dot >= 0.86)
					{
						if(!isdefined(var_27e96420))
						{
							var_27e96420 = [];
						}
						else if(!isarray(var_27e96420))
						{
							var_27e96420 = array(var_27e96420);
						}
						var_27e96420[var_27e96420.size] = s_spawn;
						n_index = array::find(var_c51ddfeb, s_spawn);
						arrayremoveindex(var_c51ddfeb, n_index);
						if(var_27e96420.size >= n_spawn_limit)
						{
							break;
						}
					}
				}
			}
			a_s_spawns = var_c51ddfeb;
			if(var_27e96420.size >= n_spawn_limit)
			{
				break;
			}
		}
		waitframe(1);
	}
	foreach(var_f4f3df1 in var_27e96420)
	{
		e_zombie = var_f4f3df1 function_9f8c0587();
		if(!isdefined(level.a_starting_zombies))
		{
			level.a_starting_zombies = [];
		}
		else if(!isarray(level.a_starting_zombies))
		{
			level.a_starting_zombies = array(level.a_starting_zombies);
		}
		level.a_starting_zombies[level.a_starting_zombies.size] = e_zombie;
	}
	var_6d4778a1 = struct::get_array(#"hash_6acfe5efcae5340e");
	var_c51ddfeb = arraycombine(var_c51ddfeb, var_6d4778a1, 0, 0);
	foreach(s_spawn in var_c51ddfeb)
	{
		if(isdefined(s_spawn.target))
		{
			mdl_clip = getent(s_spawn.target, "targetname");
			mdl_clip notsolid();
		}
	}
	if(isdefined(level.var_c54ec9bb) && level.var_c54ec9bb)
	{
		level util::delay(4, "round_reset", &function_d2085d57);
	}
	else
	{
		level thread function_d2085d57();
	}
	level waittill(#"zombie_total_set", #"hash_39eae7c03390a3a7", #"round_reset");
	if(zm_utility::is_trials())
	{
		level.max_zombie_func = undefined;
	}
	level.zombie_total = 0;
	level.zombie_respawns = 0;
	level.no_powerups = undefined;
	level.a_starting_zombies = undefined;
	level.zombie_round_start_delay = undefined;
	level flag::set("spawn_zombies");
	level flag::clear("pause_round_timeout");
	level flag::clear("hold_round_end");
}

/*
	Name: function_d2085d57
	Namespace: zm_red
	Checksum: 0xDCC97F16
	Offset: 0x30E0
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_d2085d57()
{
	level endon(#"hash_1cf28f130f16e2eb", #"hash_49085a6baf9c2c27");
	level flag::wait_till("gameplay_started");
	exploder::stop_exploder("exp_lgt_temple_gameplay_group");
	level notify(#"hash_1cf28f130f16e2eb");
}

/*
	Name: function_d7831b0f
	Namespace: zm_red
	Checksum: 0xAFF5633B
	Offset: 0x3158
	Size: 0x144
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d7831b0f()
{
	level endon(#"end_game", #"hash_49085a6baf9c2c27");
	level thread function_a3e22935();
	s_result = undefined;
	s_result = level waittill(#"end_of_round", #"hash_dc34ebe02d09532");
	level.no_powerups = undefined;
	level flag::set(#"round_one");
	level flag::set("spawn_zombies");
	level flag::clear("pause_round_timeout");
	level flag::clear("hold_round_end");
	if(!level flag::get("round_reset"))
	{
		level thread function_12b9b9a9();
	}
}

/*
	Name: function_a3e22935
	Namespace: zm_red
	Checksum: 0x32BFA8E5
	Offset: 0x32A8
	Size: 0xB0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a3e22935()
{
	level endon(#"end_game", #"end_of_round", #"hash_dc34ebe02d09532");
	level waittill(#"host_migration_begin");
	level notify(#"hash_49085a6baf9c2c27");
	level waittill(#"host_migration_end");
	level thread function_c000f08b();
	wait(1);
	level notify(#"hash_39eae7c03390a3a7");
}

/*
	Name: function_12b9b9a9
	Namespace: zm_red
	Checksum: 0xF53C0E95
	Offset: 0x3360
	Size: 0x1A4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_12b9b9a9()
{
	if(zm_utility::is_trials())
	{
		level.check_for_valid_spawn_near_team_callback = undefined;
		level.zombie_round_start_delay = undefined;
		level.var_c54ec9bb = undefined;
		level.noroundnumber = undefined;
		level.max_zombie_func = undefined;
		level notify(#"hash_49085a6baf9c2c27");
	}
	a_s_spawns = struct::get_array(#"hash_39721602c33f4cc7");
	var_6d4778a1 = struct::get_array(#"hash_6acfe5efcae5340e");
	a_s_spawns = arraycombine(a_s_spawns, var_6d4778a1, 0, 0);
	foreach(s_spawn in a_s_spawns)
	{
		if(isdefined(s_spawn.target))
		{
			mdl_clip = getent(s_spawn.target, "targetname");
			mdl_clip delete();
		}
	}
	array::delete_all(a_s_spawns);
}

/*
	Name: function_a5f3cb45
	Namespace: zm_red
	Checksum: 0x31ABA49E
	Offset: 0x3510
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_a5f3cb45(s_spawn)
{
	if(isdefined(s_spawn.var_6efb24e2) && s_spawn.var_6efb24e2 || (isdefined(s_spawn.var_3816dc63) && s_spawn.var_3816dc63))
	{
		return;
	}
	self thread zm_utility::move_zombie_spawn_location(s_spawn);
}

/*
	Name: function_9f8c0587
	Namespace: zm_red
	Checksum: 0x7B9080CE
	Offset: 0x3580
	Size: 0x190
	Parameters: 0
	Flags: Linked
*/
function function_9f8c0587()
{
	self.var_3816dc63 = 1;
	while(true)
	{
		ai_zombie = zombie_utility::spawn_zombie(array::random(level.zombie_spawners), undefined, self);
		if(isdefined(ai_zombie))
		{
			break;
		}
		waitframe(1);
	}
	ai_zombie.no_eye_glow = 1;
	ai_zombie.ignore_round_spawn_failsafe = 1;
	if(zm_custom::function_901b751c(#"zmdoorstate") != 2)
	{
		ai_zombie.b_ignore_cleanup = 1;
	}
	ai_zombie.start_inert = 1;
	ai_zombie forceteleport(self.origin, self.angles);
	ai_zombie dontinterpolate();
	if(isdefined(self.target))
	{
		mdl_clip = getent(self.target, "targetname");
		mdl_clip delete();
	}
	ai_zombie thread function_690aab3e();
	ai_zombie thread companys_();
	return ai_zombie;
}

/*
	Name: function_690aab3e
	Namespace: zm_red
	Checksum: 0x6CBD7FBB
	Offset: 0x3718
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function function_690aab3e()
{
	level endon(#"hash_1cf28f130f16e2eb");
	self waittill(#"damage", #"death");
	level notify(#"hash_1cf28f130f16e2eb");
}

/*
	Name: companys_
	Namespace: zm_red
	Checksum: 0x6B18D70F
	Offset: 0x3778
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function companys_()
{
	self endon(#"death");
	self thread scene::play(#"hash_1f71a30bc78ea047", "Shot 1", self);
	level waittill(#"hash_1cf28f130f16e2eb");
	self.no_eye_glow = undefined;
	self thread zombie_utility::zombie_eye_glow();
	wait(randomfloatrange(1.6, 2.9));
	self thread scene::play(#"hash_1f71a30bc78ea047", "Shot 2", self);
}

/*
	Name: function_eba3496
	Namespace: zm_red
	Checksum: 0x6F2082A7
	Offset: 0x3848
	Size: 0x138
	Parameters: 2
	Flags: None
*/
function function_eba3496(var_cd13b40e = 1, var_4e4cc9a9 = 1)
{
	str_model = level.var_b0ccfa4c[randomint(level.var_b0ccfa4c.size)];
	mdl_zombie = util::spawn_model(str_model, self.origin, self.angles);
	mdl_zombie.target = self.target;
	mdl_zombie.var_e259ad71 = self.var_e259ad71;
	mdl_zombie.sp_model = getent(str_model, "targetname");
	mdl_zombie thread scene::play(#"hash_1f71a30bc78ea047", "Shot 1", mdl_zombie);
	if(var_cd13b40e)
	{
		mdl_zombie thread function_fb3ab798(var_4e4cc9a9);
	}
	return mdl_zombie;
}

/*
	Name: function_a4e2970b
	Namespace: zm_red
	Checksum: 0x3636F244
	Offset: 0x3988
	Size: 0x5CC
	Parameters: 2
	Flags: Linked
*/
function function_a4e2970b(var_4e4cc9a9 = 1, s_damage)
{
	if(isdefined(self.var_a7cbb3cb) && self.var_a7cbb3cb)
	{
		return;
	}
	self.var_a7cbb3cb = 1;
	s_spawn = struct::spawn(self.origin, self.angles);
	s_spawn.var_3816dc63 = 1;
	while(true)
	{
		if(isdefined(self.sp_model))
		{
			ai_zombie = zombie_utility::spawn_zombie(self.sp_model, undefined, s_spawn);
		}
		else
		{
			ai_zombie = zombie_utility::spawn_zombie(array::random(level.zombie_spawners), undefined, s_spawn);
		}
		if(isdefined(ai_zombie))
		{
			break;
		}
		waitframe(1);
	}
	s_spawn struct::delete();
	ai_zombie.start_inert = 1;
	ai_zombie forceteleport(self.origin, self.angles);
	ai_zombie dontinterpolate();
	if(isdefined(self.target))
	{
		mdl_clip = getent(self.target, "targetname");
		mdl_clip delete();
	}
	b_killed = 0;
	if(isdefined(s_damage))
	{
		n_damage = s_damage.amount;
		if(n_damage >= ai_zombie.health)
		{
			b_killed = 1;
		}
		e_attacker = s_damage.attacker;
		ai_zombie dodamage(n_damage, s_damage.position, e_attacker, s_damage.inflictor, "none", s_damage.mod, -1, s_damage.weapon);
	}
	if(!b_killed)
	{
		ai_zombie.ignore_round_spawn_failsafe = 1;
		if(zm_custom::function_901b751c(#"zmdoorstate") != 2)
		{
			ai_zombie.b_ignore_cleanup = 1;
		}
		ai_zombie.var_126d7bef = 1;
		ai_zombie.no_powerups = 1;
		if(var_4e4cc9a9)
		{
			level zm_transform::function_5db4f2f5(ai_zombie);
			ai_zombie.ignore_enemy_count = 1;
			ai_zombie.var_12745932 = 1;
			ai_zombie.var_ae4569d5 = 1;
			ai_zombie.var_e259ad71 = self.var_e259ad71;
			ai_zombie thread zm_red_power_quest::function_2a80a9cc();
		}
		if(isdefined(self.str_scene))
		{
			self thread scene::play(self.str_scene, "breakout", self);
		}
		else
		{
			self thread scene::play(#"hash_1f71a30bc78ea047", "Shot 2", self);
		}
		if(zm_utility::is_trials() && var_4e4cc9a9)
		{
			self thread function_19a28e98();
		}
		else
		{
			self thread util::delayed_delete(float(function_60d95f53()) / 1000);
		}
		ai_zombie clientfield::increment("" + #"zombie_breakout");
		if(isdefined(self.var_feb69dca))
		{
			if(zm_utility::is_trials() && var_4e4cc9a9)
			{
				self.var_feb69dca thread function_19a28e98();
			}
			else
			{
				self.var_feb69dca delete();
			}
		}
		if(isdefined(self.str_scene))
		{
			self scene::play(self.str_scene, "breakout", self);
		}
		else
		{
			self scene::play(#"hash_1f71a30bc78ea047", "Shot 2", self);
		}
		if(!var_4e4cc9a9 && isdefined(ai_zombie))
		{
			ai_zombie thread zombie_utility::round_spawn_failsafe();
			ai_zombie.ignore_round_spawn_failsafe = undefined;
			ai_zombie.b_ignore_cleanup = undefined;
			ai_zombie.var_126d7bef = undefined;
		}
	}
	if(isdefined(self))
	{
		if(zm_utility::is_trials() && var_4e4cc9a9)
		{
			self thread function_19a28e98();
		}
		else
		{
			self delete();
		}
	}
}

/*
	Name: function_19a28e98
	Namespace: zm_red
	Checksum: 0x6F02879E
	Offset: 0x3F60
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_19a28e98()
{
	self notify("ce3924c2a8d8ee7");
	self endon("ce3924c2a8d8ee7");
	self endon(#"death");
	if(!isstruct(self))
	{
		self hide();
	}
	level flag::wait_till(#"pegasus_rescue");
	if(isstruct(self))
	{
		self struct::delete();
	}
	else
	{
		self delete();
	}
}

/*
	Name: function_fb3ab798
	Namespace: zm_red
	Checksum: 0xBDFF4420
	Offset: 0x4030
	Size: 0x254
	Parameters: 1
	Flags: Linked
*/
function function_fb3ab798(var_4e4cc9a9 = 1)
{
	self endon(#"death");
	self val::set(#"hash_58d304d03782fc3c", "takedamage", 1);
	self.health = 99999999;
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"damage");
		e_attacker = var_be17187b.attacker;
		if(isplayer(e_attacker) && zm_utility::is_player_valid(e_attacker, 0, 0, 0))
		{
			if(!var_4e4cc9a9)
			{
				break;
			}
			else
			{
				var_168ccd6b = getent("vol_power_quest_kill_zone", "targetname");
				if(e_attacker istouching(var_168ccd6b))
				{
					break;
				}
			}
		}
	}
	if(var_4e4cc9a9 && !level flag::get(#"hash_dc34ebe02d09532"))
	{
		level.var_2f2b78fb.var_5bf6d1df++;
		if(level.var_2f2b78fb.var_5bf6d1df >= 2)
		{
			level flag::set(#"hash_dc34ebe02d09532");
		}
	}
	if(!(isdefined(self.var_a7cbb3cb) && self.var_a7cbb3cb))
	{
		if(level flag::get(#"hash_dc34ebe02d09532"))
		{
			level thread zm_red_power_quest::function_b8848794(self.var_e259ad71, 0);
		}
		if(var_4e4cc9a9)
		{
			self thread function_a4e2970b(var_4e4cc9a9, var_be17187b);
		}
		else
		{
			level thread function_a14d96ed();
		}
	}
}

/*
	Name: function_a14d96ed
	Namespace: zm_red
	Checksum: 0xE801F569
	Offset: 0x4290
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_a14d96ed()
{
	foreach(starting_zombie in level.a_mdl_zombies)
	{
		if(isdefined(starting_zombie))
		{
			starting_zombie thread function_a4e2970b(0);
			wait(0.5);
		}
	}
}

/*
	Name: function_4e4950d1
	Namespace: zm_red
	Checksum: 0x6F345D5D
	Offset: 0x4328
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function function_4e4950d1(poi)
{
	vol_amphitheater = getent("vol_power_quest_kill_zone", "targetname");
	if(isdefined(vol_amphitheater) && poi[1] istouching(vol_amphitheater))
	{
		poi[1].var_fd141207 = 1;
	}
	reachable = self function_6f6cc58(poi[1]);
	return reachable;
}

/*
	Name: function_6f6cc58
	Namespace: zm_red
	Checksum: 0x80AEAFE2
	Offset: 0x43D8
	Size: 0x560
	Parameters: 1
	Flags: Linked
*/
function function_6f6cc58(e_player)
{
	if(!isdefined(e_player) || !isdefined(self))
	{
		return false;
	}
	if(level flag::get(#"hash_70efff113b745513") && !isdefined(self.var_ae4569d5) && (isdefined(e_player.var_fd141207) && e_player.var_fd141207))
	{
		var_9e80f473 = array("zone_amphitheater", "zone_amphitheater_house");
		str_zone = self zm_utility::get_current_zone();
		if(isdefined(str_zone) && !isinarray(var_9e80f473, str_zone))
		{
			return false;
		}
	}
	vol_light_side = getent("vol_light_side", "targetname");
	vol_dark_side = getent("vol_dark_side", "targetname");
	var_9b9fe2ad = self istouching(vol_light_side);
	var_ecad7bb = e_player istouching(vol_light_side);
	var_59248979 = self istouching(vol_dark_side);
	var_ef8cbe1f = e_player istouching(vol_dark_side);
	if(var_59248979 && var_ecad7bb)
	{
		return false;
	}
	if(var_9b9fe2ad && var_ef8cbe1f)
	{
		return false;
	}
	vol_gaia_combat = getent("vol_gaia_combat", "script_noteworthy");
	var_6b56dfbd = self istouching(vol_gaia_combat);
	var_c944a910 = e_player istouching(vol_gaia_combat);
	if(var_6b56dfbd && !var_c944a910 || (var_c944a910 && !var_6b56dfbd))
	{
		return false;
	}
	vol_charon_combat = getent("vol_charon_combat", "script_noteworthy");
	var_397d0352 = self istouching(vol_charon_combat);
	var_cb8ad8e2 = e_player istouching(vol_charon_combat);
	if(var_397d0352 && !var_cb8ad8e2 || (var_cb8ad8e2 && !var_397d0352))
	{
		return false;
	}
	vol_hemera_combat = getent("vol_hemera_combat", "script_noteworthy");
	var_670f0524 = self istouching(vol_hemera_combat);
	var_4a314340 = e_player istouching(vol_hemera_combat);
	if(var_670f0524 && !var_4a314340 || (var_4a314340 && !var_670f0524))
	{
		return false;
	}
	vol_ouranos_combat = getent("vol_ouranos_combat", "script_noteworthy");
	var_ee73da02 = self istouching(vol_ouranos_combat);
	var_863a1e1f = e_player istouching(vol_ouranos_combat);
	if(var_ee73da02 && !var_863a1e1f || (var_863a1e1f && !var_ee73da02))
	{
		return false;
	}
	if(!var_ecad7bb && !var_ef8cbe1f && !var_863a1e1f && !var_4a314340 && !var_c944a910 && !var_cb8ad8e2)
	{
		return false;
	}
	if(zm_utility::function_e51dc2d8() || zm_utility::is_trials())
	{
		if(isdefined(self.var_be2fc36d) && self.var_be2fc36d)
		{
			s_play = level.var_28dcf408;
			if(isdefined(s_play))
			{
				var_fc14780a = s_play.var_fc14780a;
				str_ww = self.var_8ca159b2;
				e_target = var_fc14780a[str_ww];
				if(isdefined(e_target) && e_target != e_player)
				{
					return false;
				}
			}
		}
	}
	return true;
}

/*
	Name: function_9f50079d
	Namespace: zm_red
	Checksum: 0x4980C039
	Offset: 0x4940
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_9f50079d()
{
	zm_loadout::register_tactical_grenade_for_level("zhield_zpear_dw", 1);
}

/*
	Name: offhand_weapon_give_override
	Namespace: zm_red
	Checksum: 0x5042A973
	Offset: 0x4970
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function offhand_weapon_give_override(str_weapon)
{
	self endon(#"death");
	if(zm_loadout::is_tactical_grenade(str_weapon) && isdefined(self zm_loadout::get_player_tactical_grenade()) && !self zm_loadout::is_player_tactical_grenade(str_weapon))
	{
		self setweaponammoclip(self zm_loadout::get_player_tactical_grenade(), 0);
		self takeweapon(self zm_loadout::get_player_tactical_grenade());
	}
	return false;
}

/*
	Name: sndfunctions
	Namespace: zm_red
	Checksum: 0x6B548C2
	Offset: 0x4A40
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function sndfunctions()
{
	if(zm_utility::is_standard())
	{
		level.zmannouncerprefix = "rush";
	}
	else
	{
		level.zmannouncerprefix = "prst";
	}
	level.sndweaponpickupoverride = array(#"wonder");
	zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
	level thread setupmusic();
	level thread custom_add_vox();
	level thread setup_personality_character_exerts();
}

/*
	Name: custom_add_vox
	Namespace: zm_red
	Checksum: 0x444BDB74
	Offset: 0x4B20
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function custom_add_vox()
{
	zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
	zm_audio::loadplayervoicecategories(#"hash_5963a3db3032ab46");
	zm_audio::loadplayervoicecategories(#"hash_37db46ab64d46fca");
}

/*
	Name: setupmusic
	Namespace: zm_red
	Checksum: 0xF7A1DE15
	Offset: 0x4B90
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function setupmusic()
{
	zm_audio::musicstate_create("round_start", 3, "red_roundstart_1", "red_roundstart_2");
	zm_audio::musicstate_create("round_end", 3, "red_roundend_1", "red_roundend_2");
	zm_audio::musicstate_create("game_over", 5, "red_death");
	zm_audio::musicstate_create("ee_song", 4, "ee_song");
	zm_audio::musicstate_create("poweron_event_start", 4, "poweron_event_start");
	zm_audio::musicstate_create("poweron_event_complete", 4, "poweron_event_complete");
	zm_audio::musicstate_create("play", 4, "play");
	zm_audio::musicstate_create("the_ride", 4, "the_ride");
	zm_audio::musicstate_create("pap_complete", 4, "pap_complete");
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_red
	Checksum: 0xC616C3F6
	Offset: 0x4D18
	Size: 0x3C8
	Parameters: 0
	Flags: Linked
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[1][#"hitmed"] = "vox_plr_1_exert_pain";
	level.exert_sounds[2][#"hitmed"] = "vox_plr_2_exert_pain";
	level.exert_sounds[3][#"hitmed"] = "vox_plr_3_exert_pain";
	level.exert_sounds[4][#"hitmed"] = "vox_plr_4_exert_pain";
	level.exert_sounds[1][#"hitlrg"] = "vox_plr_1_exert_pain";
	level.exert_sounds[2][#"hitlrg"] = "vox_plr_2_exert_pain";
	level.exert_sounds[3][#"hitlrg"] = "vox_plr_2_exert_pain";
	level.exert_sounds[4][#"hitlrg"] = "vox_plr_3_exert_pain";
	level.exert_sounds[1][#"drowning"] = "vox_plr_1_exert_underwater_air_low";
	level.exert_sounds[2][#"drowning"] = "vox_plr_2_exert_underwater_air_low";
	level.exert_sounds[3][#"drowning"] = "vox_plr_3_exert_underwater_air_low";
	level.exert_sounds[4][#"drowning"] = "vox_plr_4_exert_underwater_air_low";
	level.exert_sounds[1][#"cough"] = "vox_plr_1_exert_gas_cough";
	level.exert_sounds[2][#"cough"] = "vox_plr_2_exert_gas_cough";
	level.exert_sounds[3][#"cough"] = "vox_plr_3_exert_gas_cough";
	level.exert_sounds[4][#"cough"] = "vox_plr_4_exert_gas_cough";
	level.exert_sounds[1][#"underwater_emerge"] = "vox_plr_1_exert_underwater_emerge_breath";
	level.exert_sounds[2][#"underwater_emerge"] = "vox_plr_2_exert_underwater_emerge_breath";
	level.exert_sounds[3][#"underwater_emerge"] = "vox_plr_3_exert_underwater_emerge_breath";
	level.exert_sounds[4][#"underwater_emerge"] = "vox_plr_4_exert_underwater_emerge_breath";
	level.exert_sounds[1][#"underwater_gasp"] = "vox_plr_1_exert_underwater_emerge_gasp";
	level.exert_sounds[2][#"underwater_gasp"] = "vox_plr_2_exert_underwater_emerge_gasp";
	level.exert_sounds[3][#"underwater_gasp"] = "vox_plr_3_exert_underwater_emerge_gasp";
	level.exert_sounds[4][#"underwater_gasp"] = "vox_plr_4_exert_underwater_emerge_gasp";
}

/*
	Name: play_outro
	Namespace: zm_red
	Checksum: 0x4D22A905
	Offset: 0x50E8
	Size: 0x3F0
	Parameters: 0
	Flags: Linked
*/
function play_outro()
{
	foreach(player in getplayers())
	{
		if(isdefined(player))
		{
			player disableweaponfire();
		}
		if(player clientfield::get("" + #"hash_9d9fb6cf3d5d3a6"))
		{
			player clientfield::set("" + #"hash_9d9fb6cf3d5d3a6", 0);
		}
	}
	namespace_c8efdadc::function_53bac096(1);
	foreach(e_player in util::get_active_players())
	{
		e_player val::set(#"outro", "freezecontrols", 1);
		e_player.var_16735873 = 1;
		if(e_player laststand::player_is_in_laststand())
		{
			e_player thread zm_laststand::auto_revive(e_player, 0, 0);
		}
		e_player val::set(#"outro", "takedamage", 0);
		e_player val::set(#"outro", "ignoreme", 1);
		e_player notify(#"bgb_update");
	}
	/#
		zm_devgui::zombie_devgui_open_sesame();
	#/
	level zm_vo::function_3c173d37((0, 0, 0), 2147483647);
	level zm_audio::sndvoxoverride(1);
	zombie_utility::clear_all_corpses();
	util::set_lighting_state(0);
	scene::play(#"hash_649bf4517c6d8d25");
	scene::play(#"hash_29e069a70818e58f");
	scene::play(#"hash_29e068a70818e3dc");
	scene::play(#"hash_29e067a70818e229");
	level scene::function_f81475ae(#"hash_29e067a70818e229");
	foreach(player in getplayers())
	{
		if(isdefined(player))
		{
			player enableweaponfire();
		}
	}
	level notify(#"end_game");
}

/*
	Name: function_eeb6a1e7
	Namespace: zm_red
	Checksum: 0x7EDC7D74
	Offset: 0x54E0
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_eeb6a1e7()
{
	s_wallbuy = struct::get("tr_leveraction_t8", "zombie_weapon_upgrade");
	var_8651c21a = struct::get(s_wallbuy.target);
	var_bd118df0 = getent(var_8651c21a.target, "targetname");
	var_bd118df0 hide();
	level clientfield::set(s_wallbuy.trigger_stub.clientfieldname, 0);
	var_bd118df0 clientfield::set("wallbuy_ambient_fx", 0);
}

/*
	Name: function_bff9977d
	Namespace: zm_red
	Checksum: 0xCD290861
	Offset: 0x55D0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_bff9977d(a_ents)
{
	if(isdefined(a_ents[#"scarlett_eyes"]))
	{
		scarlett_eyes = a_ents[#"scarlett_eyes"];
		level waittill(#"eyes_start");
		scarlett_eyes clientfield::set("" + #"medusa_eyes", 1);
	}
}

/*
	Name: function_b5670bb7
	Namespace: zm_red
	Checksum: 0xDEB80F66
	Offset: 0x5670
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_b5670bb7(a_ents)
{
	if(isdefined(a_ents[#"scarlett_eyes"]))
	{
		scarlett_eyes = a_ents[#"scarlett_eyes"];
		scarlett_eyes clientfield::set("" + #"medusa_eyes", 1);
		level waittill(#"eyes_done");
		scarlett_eyes clientfield::set("" + #"medusa_eyes", 0);
	}
}

/*
	Name: function_924ba3d
	Namespace: zm_red
	Checksum: 0x5227B697
	Offset: 0x5740
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_924ba3d(a_ents)
{
	foreach(player in getplayers())
	{
		player clientfield::set_to_player("" + #"eye_vignette", 1);
	}
	if(isdefined(a_ents[#"medusa_eyes"]))
	{
		medusa_eyes = a_ents[#"medusa_eyes"];
		level waittill(#"eyes_start");
		medusa_eyes clientfield::set("" + #"medusa_eyes", 1);
		level waittill(#"eyes_done");
		medusa_eyes clientfield::set("" + #"medusa_eyes", 0);
	}
}

/*
	Name: function_b648a6d9
	Namespace: zm_red
	Checksum: 0x8AA78D25
	Offset: 0x58C0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_b648a6d9(a_ents)
{
	if(isdefined(a_ents[#"medusa_eyes"]))
	{
		medusa_eyes = a_ents[#"medusa_eyes"];
		medusa_eyes clientfield::set("" + #"medusa_eyes", 1);
		level waittill(#"eyes_done");
		medusa_eyes clientfield::set("" + #"medusa_eyes", 0);
	}
}

/*
	Name: function_5b984671
	Namespace: zm_red
	Checksum: 0x53AE7F15
	Offset: 0x5990
	Size: 0x1FC
	Parameters: 1
	Flags: Linked
*/
function function_5b984671(a_ents)
{
	zm_utility::function_9ad5aeb1(0, 1, 1, 0);
	level clientfield::set("" + #"postfx_play", 1);
	zm_red_challenges::function_304fb042();
	foreach(e_player in util::get_active_players())
	{
		e_player val::reset(#"outro", "freezecontrols");
	}
	array::run_all(getentarray("zm_red_temple_clutter_left", "targetname"), &delete);
	array::run_all(getentarray("zm_red_temple_clutter_right", "targetname"), &delete);
	array::run_all(getentarray("zm_red_temple_clutter_oracle", "targetname"), &delete);
	hidemiscmodels("zm_red_temple_clutter_oracle_pile");
	hidemiscmodels("zm_red_oracle_floor_door");
}

/*
	Name: function_509bbc5b
	Namespace: zm_red
	Checksum: 0xA1026654
	Offset: 0x5B98
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_509bbc5b(a_ents)
{
	level thread scene::init_streamer(#"hash_29e067a70818e229", #"allies", 0, 0);
}

/*
	Name: function_75ef7b1f
	Namespace: zm_red
	Checksum: 0x101D4126
	Offset: 0x5BE8
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function function_75ef7b1f(a_ents)
{
	level scene::function_f81475ae(#"hash_649bf4517c6d8d25");
	level scene::function_27f5972e(#"hash_29e067a70818e229");
	level clientfield::set("" + #"postfx_play", 2);
	foreach(e_player in util::get_active_players())
	{
		e_player val::reset(#"outro", "freezecontrols");
	}
}

/*
	Name: function_883a1fb8
	Namespace: zm_red
	Checksum: 0x872611A3
	Offset: 0x5D08
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function function_883a1fb8(a_ents)
{
	level clientfield::set("" + #"postfx_play", 3);
	foreach(e_player in util::get_active_players())
	{
		e_player val::reset(#"outro", "freezecontrols");
	}
}

/*
	Name: function_ea8d45ef
	Namespace: zm_red
	Checksum: 0x35497A8E
	Offset: 0x5DE8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_ea8d45ef(a_ents)
{
	level clientfield::set("" + #"postfx_play", 0);
}

/*
	Name: function_625a9bcf
	Namespace: zm_red
	Checksum: 0x850A0671
	Offset: 0x5E30
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_625a9bcf()
{
	level zm_audio::function_6191af93(#"shield_piece", #"pickup", "", "");
	w_component = zm_crafting::get_component(#"hash_fb7df72cfdf8492");
	zm_items::function_4d230236(w_component, &function_a3fd9b43);
	w_component = zm_crafting::get_component(#"hash_fb7de72cfdf82df");
	zm_items::function_4d230236(w_component, &function_3fbc19fb);
	w_component = zm_crafting::get_component(#"hash_fb7dd72cfdf812c");
	zm_items::function_4d230236(w_component, &function_9f645f7);
}

/*
	Name: function_a3fd9b43
	Namespace: zm_red
	Checksum: 0xDB8218FF
	Offset: 0x5F48
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function function_a3fd9b43(e_holder, w_item)
{
	self thread zm_audio::create_and_play_dialog(#"shield_piece", #"pickup_1", undefined, 1);
}

/*
	Name: function_3fbc19fb
	Namespace: zm_red
	Checksum: 0x2058E556
	Offset: 0x5FA0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_3fbc19fb(e_holder, w_item)
{
	self thread zm_audio::create_and_play_dialog(#"shield_piece", #"pickup_3");
}

/*
	Name: function_9f645f7
	Namespace: zm_red
	Checksum: 0x472D2734
	Offset: 0x5FF0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_9f645f7(e_holder, w_item)
{
	self thread zm_audio::create_and_play_dialog(#"shield_piece", #"pickup_2");
}

/*
	Name: function_8f72e6b8
	Namespace: zm_red
	Checksum: 0x7E760E68
	Offset: 0x6040
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function function_8f72e6b8()
{
	w_component = zm_crafting::get_component(#"hash_5b9dc0415a4521f3");
	w_component.var_62a98b13 = #"hash_46cc2afc76bb1891";
	w_component = zm_crafting::get_component(#"hash_5b9dc1415a4523a6");
	w_component.var_62a98b13 = #"hash_4378a7cfd8341a30";
	w_component = zm_crafting::get_component(#"hash_5b9dc2415a452559");
	w_component.var_62a98b13 = #"hash_2ac16e115b8e401a";
}

/*
	Name: function_f2427bae
	Namespace: zm_red
	Checksum: 0xDCF71D40
	Offset: 0x6100
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function function_f2427bae(slot, weapon)
{
	if(weapon == level.var_49d60273)
	{
		self.var_424c161e = 1;
	}
	else
	{
		self.var_cad44cf2 = weapon;
		self.var_424c161e = 0;
	}
}

/*
	Name: function_46159bb7
	Namespace: zm_red
	Checksum: 0xFD483B6F
	Offset: 0x6160
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_46159bb7(a_s_valid_respawn_points)
{
	if(level flag::get(#"hash_7943879f3be8ccc6"))
	{
		return a_s_valid_respawn_points;
	}
	var_65c6fc29 = array("zone_river_upper", "zone_river_lower", "zone_cliff_tombs_upper", "zone_cliff_tombs_center", "zone_cliff_tombs_forge", "zone_cliff_tombs_lower", "zone_serpent_pass_upper", "zone_serpent_pass_center", "zone_serpent_pass_lower", "zone_serpent_pass_bridge", "zone_drakaina_arena", "zone_cliff_tombs_bridge");
	a_s_respawn_points = arraycopy(a_s_valid_respawn_points);
	foreach(s_respawn_point in a_s_valid_respawn_points)
	{
		if(isinarray(var_65c6fc29, s_respawn_point.script_noteworthy))
		{
			arrayremovevalue(a_s_respawn_points, s_respawn_point);
		}
	}
	return a_s_respawn_points;
}

/*
	Name: function_598a6222
	Namespace: zm_red
	Checksum: 0xE132E490
	Offset: 0x62D0
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_598a6222()
{
	vol_amphitheater = getent("vol_power_quest_kill_zone", "targetname");
	if(isdefined(vol_amphitheater) && self istouching(vol_amphitheater) && !level flag::get(#"hash_3dba794053dea40e"))
	{
		return false;
	}
	if(self flag::exists(#"hash_3247dad158e8b329") && self flag::get(#"hash_3247dad158e8b329"))
	{
		return false;
	}
	return true;
}

/*
	Name: function_d4ff1dd6
	Namespace: zm_red
	Checksum: 0x75A047E6
	Offset: 0x63A0
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_d4ff1dd6(waitresult)
{
	/#
		if(waitresult.activator.health <= 0)
		{
			iprintlnbold("" + waitresult.activator.origin);
		}
	#/
}

/*
	Name: function_c02e63
	Namespace: zm_red
	Checksum: 0x69CE2102
	Offset: 0x6408
	Size: 0x748
	Parameters: 1
	Flags: Linked
*/
function function_c02e63(var_2753f06a)
{
	wait(1);
	if(!isdefined(level.host))
	{
		return false;
	}
	var_7ce59f05 = level.host zm_vo::function_82f9bc9f();
	if(getplayers().size === 1)
	{
		switch(var_2753f06a)
		{
			case 0:
			{
				if(var_7ce59f05 == "brun")
				{
					level.host zm_vo::vo_say(#"hash_6d9e1d549cc1b3ba", undefined, undefined, undefined, undefined, 1);
					level.host zm_vo::vo_say(#"hash_72533b3d4278425d", 0.5);
				}
				else
				{
					level.host zm_vo::function_a2bd5a0c(#"vox_solo_game_start_" + var_7ce59f05, 0, 1);
				}
				break;
			}
			case 1:
			{
				if(var_7ce59f05 == "brun")
				{
					level.host zm_vo::vo_say(#"hash_6f1df3b4e6354472", 0.5);
					level.host zm_vo::vo_say(#"hash_31a9fb6be6fe1013", undefined, undefined, undefined, undefined, 1);
				}
				else
				{
					level.host zm_vo::function_a2bd5a0c(#"vox_solo_end_round1_" + var_7ce59f05, 0, 1);
				}
				break;
			}
			case 2:
			{
				if(var_7ce59f05 == "brun")
				{
					level.host zm_vo::vo_say(#"hash_166f0f941a5b1e45", 0.5);
					level.host zm_vo::vo_say(#"hash_2c81ea0c696b6232", undefined, undefined, undefined, undefined, 1);
				}
				else
				{
					level.host zm_vo::function_a2bd5a0c(#"vox_solo_end_round2_" + var_7ce59f05, 0, 1);
				}
				break;
			}
		}
	}
	else
	{
		switch(var_2753f06a)
		{
			case 0:
			{
				if(var_7ce59f05 == "brun")
				{
					level.host zm_vo::vo_say(#"hash_54180fda77534ccd", undefined, undefined, undefined, undefined, 1);
					level.host zm_vo::function_a2bd5a0c(#"hash_3d803349cfe68c13", 0.5);
				}
				else
				{
					level.host zm_vo::function_a2bd5a0c(#"hash_4c0be2bb6d0c80b0" + var_7ce59f05);
				}
				break;
			}
			case 1:
			{
				switch(var_7ce59f05)
				{
					case "scar":
					{
						level.host zm_vo::vo_say(#"hash_1da6407e4cd932bf");
						break;
					}
					case "dieg":
					{
						level.host zm_vo::vo_say(#"hash_1cdc8a3e02fcfce3");
						break;
					}
					case "brun":
					{
						level.host zm_vo::vo_say(#"hash_590040ddc7032e94");
						break;
					}
					case "shaw":
					{
						level.host zm_vo::vo_say(#"hash_7f40dc2d71347256");
						break;
					}
				}
				break;
			}
			case 2:
			{
				switch(var_7ce59f05)
				{
					case "scar":
					{
						level.host zm_vo::vo_say(#"hash_6c4dee81df419edc");
						break;
					}
					case "dieg":
					{
						level.host zm_vo::vo_say(#"hash_24d7b7428867b4f0");
						break;
					}
					case "brun":
					{
						level.host zm_vo::vo_say(#"hash_42880967b7a32953");
						break;
					}
					case "shaw":
					{
						level.host zm_vo::vo_say(#"hash_5fb3938045de5389");
						break;
					}
				}
				break;
			}
			case 3:
			{
				switch(var_7ce59f05)
				{
					case "scar":
					{
						level.host zm_vo::vo_say(#"hash_394a9cfe79112d79");
						break;
					}
					case "dieg":
					{
						level.host zm_vo::vo_say(#"hash_2abbc74b0d21d3f9");
						break;
					}
					case "brun":
					{
						level.host zm_vo::vo_say(#"hash_171f4130f28f8812");
						break;
					}
					case "shaw":
					{
						level.host zm_vo::vo_say(#"hash_7db0de42b6aa9784");
						break;
					}
				}
				break;
			}
		}
		level thread function_b35c3e0b(var_7ce59f05, var_2753f06a);
	}
	return true;
}

/*
	Name: function_b35c3e0b
	Namespace: zm_red
	Checksum: 0xE7FDE5C6
	Offset: 0x6B58
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function function_b35c3e0b(var_7ce59f05, n_index)
{
	a_players = util::get_active_players();
	var_9103f439 = [];
	if(isdefined(a_players) && a_players.size > 1)
	{
		foreach(player in a_players)
		{
			if(player zm_vo::function_82f9bc9f() != var_7ce59f05)
			{
				var_9103f439[var_9103f439.size] = player;
			}
		}
		player = array::random(var_9103f439);
		if(isdefined(player))
		{
			player zm_vo::function_a2bd5a0c(((#"hash_71bde3a512edb440" + n_index) + "_") + var_7ce59f05, 0.5);
		}
	}
}

/*
	Name: function_7edd912b
	Namespace: zm_red
	Checksum: 0x125BFAA1
	Offset: 0x6CA0
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_7edd912b(var_2753f06a)
{
}

/*
	Name: function_7722c6f0
	Namespace: zm_red
	Checksum: 0xB5CFEF17
	Offset: 0x6CB8
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_7722c6f0(var_404e4288, var_8dd554ee)
{
	if(math::cointoss())
	{
		var_6095c0b6 = zm_round_logic::function_4e8157cd(var_404e4288, var_8dd554ee);
		if(isalive(var_6095c0b6.ai_spawned))
		{
			zm_transform::function_d2374144(var_6095c0b6.ai_spawned, #"blight_father");
		}
	}
	else
	{
		ai = zombie_gegenees_util::spawn_single(1);
		if(isdefined(ai))
		{
			ai.ignore_enemy_count = 0;
			level.zombie_total--;
		}
	}
	return true;
}

/*
	Name: function_c8ce0a17
	Namespace: zm_red
	Checksum: 0xE69F3D82
	Offset: 0x6D98
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function function_c8ce0a17(var_404e4288, var_8dd554ee)
{
	if(math::cointoss())
	{
		var_6095c0b6 = zm_round_logic::function_4e8157cd(var_404e4288, var_8dd554ee);
		if(isalive(var_6095c0b6.ai_spawned))
		{
			zm_transform::function_d2374144(var_6095c0b6.ai_spawned, array::random(array(#"catalyst_corrosive", #"catalyst_electric", #"catalyst_plasma", #"catalyst_water")));
		}
	}
	else
	{
		var_862206ea = zombie_skeleton_util::function_1ea880bd(1);
		if(isdefined(var_862206ea))
		{
			level.zombie_total--;
		}
	}
	return true;
}

/*
	Name: function_338bae81
	Namespace: zm_red
	Checksum: 0x80D7AEBC
	Offset: 0x6EC0
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function function_338bae81(e_player)
{
	if(!isdefined(e_player.var_4674988e))
	{
		e_player.var_4674988e = 0;
	}
	n_time = gettime() / 1000;
	dt = n_time - e_player.var_4674988e;
	if(dt > 15)
	{
		e_player thread zm_audio::create_and_play_dialog(#"peg_summon", #"use");
		e_player.var_4674988e = n_time;
	}
}

/*
	Name: function_7c7c6a1
	Namespace: zm_red
	Checksum: 0x4466CDC3
	Offset: 0x6F78
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_7c7c6a1(weapon)
{
	if(weapon.name == #"thunderstorm")
	{
		self thread zm_audio::create_and_play_dialog(#"magicbox", #"peg", undefined, 1);
		return true;
	}
	return false;
}

/*
	Name: function_443f6873
	Namespace: zm_red
	Checksum: 0xB84B97B6
	Offset: 0x6FE8
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_443f6873(str_weapon)
{
	var_a7c8ee36 = undefined;
	if(isdefined(str_weapon))
	{
		switch(str_weapon)
		{
			case "zhield_zpear_dw":
			{
				var_a7c8ee36 = #"novox";
				break;
			}
		}
	}
	return var_a7c8ee36;
}

/*
	Name: function_fbf0e632
	Namespace: zm_red
	Checksum: 0xC9F33908
	Offset: 0x7050
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_fbf0e632()
{
	self endon(#"powerup_timedout", #"powerup_stolen", #"death");
	self playsound(#"hash_e3e5f7c83015171");
	self playloopsound(#"hash_2adfa98b79668366");
	waitresult = undefined;
	waitresult = self waittill(#"powerup_grabbed");
	if(isdefined(waitresult.e_grabber) && isplayer(waitresult.e_grabber))
	{
		waitresult.e_grabber playsound(#"hash_1c696244a9a3dbbf");
	}
}

/*
	Name: function_acb5b0ec
	Namespace: zm_red
	Checksum: 0xCB7630FC
	Offset: 0x7158
	Size: 0x8AC
	Parameters: 0
	Flags: None
*/
function function_acb5b0ec()
{
	/#
		zm_devgui::add_custom_devgui_callback(&function_76dc48b8);
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
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		if(zm_utility::function_e51dc2d8())
		{
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
		}
	#/
}

/*
	Name: function_76dc48b8
	Namespace: zm_red
	Checksum: 0x136573B7
	Offset: 0x7A10
	Size: 0x1A5A
	Parameters: 1
	Flags: None
*/
function function_76dc48b8(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_6eb30455e9df06a1":
			{
				level thread function_71a6c3ea();
				function_eeb6a1e7();
				scene::add_scene_func("", &function_5b984671, "");
				scene::add_scene_func("", &function_ea8d45ef, "");
				scene::play("");
				return true;
				break;
			}
			case "hash_6eb30155e9df0188":
			{
				level thread function_71a6c3ea();
				function_eeb6a1e7();
				scene::add_scene_func("", &function_75ef7b1f, "");
				scene::add_scene_func("", &function_ea8d45ef, "");
				scene::play("");
				return true;
				break;
			}
			case "hash_6eb30255e9df033b":
			{
				level thread function_71a6c3ea();
				function_eeb6a1e7();
				scene::add_scene_func("", &function_883a1fb8, "");
				scene::add_scene_func("", &function_ea8d45ef, "");
				scene::play("");
				return true;
				break;
			}
			case "hash_6eb30755e9df0bba":
			{
				level thread function_71a6c3ea();
				function_eeb6a1e7();
				scene::play("");
				return true;
				break;
			}
			case "play_all":
			{
				level.var_7652563c = 1;
				function_eeb6a1e7();
				level thread play_outro();
				return true;
				break;
			}
			case "hash_50d92ca3c6c7c2a8":
			{
				level thread function_71a6c3ea();
				return true;
				break;
			}
			case "hash_993396a4206a1e9":
			{
				level thread function_f39d0796();
				return true;
				break;
			}
			case "hash_4abb72859ec9576c":
			{
				level thread function_3594d78b();
				break;
			}
			case "hash_2f2a0c012b9587d3":
			{
				level thread function_590ce3bd();
				break;
			}
			case "hash_23e8dfb7c173d426":
			{
				level thread function_80b73b4();
				break;
			}
			case "hash_661d906e81e681a0":
			{
				level thread function_313ff13();
				return true;
				break;
			}
			case "spawn_pegasus":
			{
				level thread spawn_pegasus();
				return true;
				break;
			}
			case "ride_pegasus":
			{
				level thread ride_pegasus();
				return true;
				break;
			}
			case "free_eagles":
			{
				level thread free_eagles();
				return true;
				break;
			}
			case "complete_pap":
			{
				level thread complete_pap();
				return true;
				break;
			}
			case "hash_6429644808eb1a0e":
			{
				level thread zm_red_ww_quests::function_9dc3d269();
				return true;
				break;
			}
			case "hash_137588aac1c5e8a4":
			{
				level thread zm_red_ww_quests::function_34c06bf9();
				return true;
				break;
			}
			case "hash_78f0de868a955048":
			{
				level thread zm_red_ww_quests::function_e3a8b066(#"light");
				return true;
				break;
			}
			case "hash_76f44a33d967751a":
			{
				level thread zm_red_ww_quests::function_e3a8b066(#"death");
				return true;
				break;
			}
			case "hash_76a546919ae7f290":
			{
				level thread zm_red_ww_quests::function_e3a8b066(#"earth");
				return true;
				break;
			}
			case "hash_6ad4284ef1b3e750":
			{
				level thread zm_red_ww_quests::function_e3a8b066(#"air");
				return true;
				break;
			}
			case "hash_3e4ac36ee130ef3c":
			{
				level thread zm_red_ww_quests::function_51a8e408(#"light");
				return true;
				break;
			}
			case "hash_5890d948dcfe86a6":
			{
				level thread zm_red_ww_quests::function_51a8e408(#"death");
				return true;
				break;
			}
			case "hash_3b720308ca9b47d4":
			{
				level thread zm_red_ww_quests::function_51a8e408(#"earth");
				return true;
				break;
			}
			case "hash_651e411e90da7f94":
			{
				level thread zm_red_ww_quests::function_51a8e408(#"air");
				return true;
				break;
			}
			case "hash_182705f03ec3d976":
			{
				level thread zm_red_ww_quests::function_f241b684();
				return true;
				break;
			}
			case "hash_4fa27fb98665fe3a":
			{
				level thread zm_red_ww_quests::function_6bf10cf9();
				return true;
				break;
			}
			case "hash_170c2110b1de2872":
			{
				level thread zm_red_ww_quests::function_11a0f6f8();
				return true;
				break;
			}
			case "hash_290820a2a3f4b0b9":
			{
				level thread zm_red_ww_quests::function_c5d7d69b();
				return true;
				break;
			}
			case "hash_16ca21dc88e8049b":
			{
				level thread zm_red_ww_quests::function_681ce100();
				return true;
				break;
			}
			case "hash_4cd02ce602240df9":
			{
				level thread zm_red_ww_quests::function_9fe8bfeb();
				return true;
				break;
			}
			case "hash_4135904306940f66":
			{
				level thread zm_red_ww_quests::function_dcfed198();
				return true;
				break;
			}
			case "hash_5b980405c2fb2366":
			{
				level thread zm_red_ww_quests::function_d6e30032();
				return true;
				break;
			}
			case "hash_566accf8fdcd834c":
			{
				level thread zm_red_ww_quests::function_ec9bf2a();
				return true;
				break;
			}
			case "hash_655e705781bfd2af":
			{
				level thread zm_red_ww_quests::function_30ecec0c();
				return true;
				break;
			}
			case "hash_eef0c3bf29481cd":
			{
				level thread zm_red_ww_quests::function_a5efeb8d();
				return true;
				break;
			}
			case "hash_fea23dfe07cc931":
			{
				level thread zm_red_ww_quests::function_4594e669();
				return true;
				break;
			}
			case "hash_2f8409a9af0b7b4b":
			{
				level thread zm_red_ww_quests::function_b8b8845();
				return true;
				break;
			}
			case "hash_52a251650604890f":
			{
				level thread zm_red_ww_quests::function_318c3039();
				return true;
				break;
			}
			case "hash_71a15c94ec8d4c2a":
			{
				level thread zm_red_ww_quests::function_37deb555();
				return true;
				break;
			}
			case "hash_3046318853a1f0f9":
			{
				level thread zm_red_ww_quests::function_d8765f3d();
				return true;
				break;
			}
			case "hash_6540cece460115d8":
			{
				level thread zm_red_ww_quests::function_233156e3();
				return true;
				break;
			}
			case "hash_46ef6728b784e895":
			{
				level thread zm_red_ww_quests::function_c4614158();
				return true;
				break;
			}
			case "hash_15fba8108df788e7":
			{
				level thread zm_red_ww_quests::function_d963daa9();
				return true;
				break;
			}
			case "hash_522749387ee44839":
			{
				level thread zm_red_ww_quests::function_405e6a83();
				return true;
				break;
			}
			case "hash_5e2fc595f8d3d7bd":
			{
				level thread zm_red_power_quest::devgui_complete();
				return true;
				break;
			}
			case "hash_55435ba74ce9b712":
			{
				level.var_656c1a37 = 0;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_71fe4179fafd7f3":
			{
				level.var_656c1a37 = 11;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_6ae2b92946638ba0":
			{
				level.var_656c1a37 = 1;
				level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_3b5e1577a3ac05f9":
			{
				level.var_656c1a37 = 2;
				level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_72ef3034042f03e2":
			{
				level.var_656c1a37 = 3;
				level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_3bc45b4ec610c6ea":
			{
				level.var_656c1a37 = 4;
				level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_53ee2bdf0d2847c4":
			{
				level.var_656c1a37 = 5;
				level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_2915d280a9091d5d":
			{
				level.var_656c1a37 = 6;
				level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_38eb67ea5f4036f3":
			{
				level.var_656c1a37 = 7;
				level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_555ae35b6c19f641":
			{
				level.var_656c1a37 = 13;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_2cc5d2651dded199":
			{
				level.var_656c1a37 = 10;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_7629cafaf2e465e3":
			{
				level.var_656c1a37 = 9;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_368aef09ae7ed576":
			{
				level.var_656c1a37 = 12;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_2e0e00c6ad36186f":
			{
				level.var_656c1a37 = 8;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_359525c5c273d324":
			{
				level.var_656c1a37 = 14;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_8cff6d431ab1efe":
			{
				level.var_656c1a37 = 15;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_45c7d33388c20473":
			{
				level.var_656c1a37 = 16;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_6d8584607d816e70":
			{
				level.var_656c1a37 = 17;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_7768dba8fad5836b":
			{
				level.var_656c1a37 = 18;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_2793bc8d461b411":
			{
				level.var_656c1a37 = 19;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_1d8f7ff87b40f80f":
			{
				level.var_656c1a37 = 20;
				level thread zm_red_challenges::start_challenge();
				break;
			}
			case "hash_2eba8518b711ac1":
			{
				foreach(player in getplayers())
				{
					player function_7c8b5f27();
				}
				break;
			}
			case "hash_73599762d232fa70":
			{
				e_player = getplayers()[0];
				e_player function_7c8b5f27();
				break;
			}
			case "hash_46d64f2b7aa21161":
			{
				a_players = getplayers();
				if(a_players.size >= 2)
				{
					a_players[1] function_7c8b5f27();
				}
				break;
			}
			case "hash_4ae61e7d270a0f16":
			{
				a_players = getplayers();
				if(a_players.size >= 3)
				{
					a_players[2] function_7c8b5f27();
				}
				break;
			}
			case "hash_580b4b8b0d03657f":
			{
				a_players = getplayers();
				if(a_players.size >= 4)
				{
					a_players[3] function_7c8b5f27();
				}
				break;
			}
			case "challenge_phase_1":
			{
				level.var_6e5099bb = 1;
				iprintlnbold("");
				break;
			}
			case "challenge_phase_2":
			{
				level.var_6e5099bb = 2;
				iprintlnbold("");
				break;
			}
			case "challenge_phase_3":
			{
				level.var_6e5099bb = 3;
				iprintlnbold("");
				break;
			}
			case "hash_7a9bab3c50ff294d":
			{
				level flag::set("");
				break;
			}
			case "hash_e3eb39f2ce05aff":
			{
				level thread zm_red_main_quest::function_69e1a1fc();
				break;
			}
			case "hash_6fa14c9cc4ed8317":
			{
				level thread function_bb5a8b5e(0);
				break;
			}
			case "hash_1226dc3756e1cbe4":
			{
				level thread function_bb5a8b5e(1);
				break;
			}
			case "ignite_shield":
			{
				level thread zm_red_main_quest::function_25bb4829(0);
				break;
			}
			case "greek_fire":
			{
				level thread zm_red_main_quest::function_25bb4829(1);
				break;
			}
			case "hash_4e0fd48904ba6582":
			{
				foreach(player in getplayers())
				{
					player.var_6a885e6e = 0;
					player.var_b22aca27[0].b_available = 1;
					player.var_b22aca27[1].b_available = 1;
					player.var_b22aca27[2].b_available = 1;
					player.var_b22aca27[3].b_available = 1;
					player.var_b22aca27[4].b_available = 1;
					player.var_b22aca27[5].b_available = 1;
					player.var_b22aca27[6].b_available = 1;
				}
				break;
			}
			case "hash_7bf7f5b60c83cf1f":
			{
				foreach(player in getplayers())
				{
					player.var_6a885e6e = 0;
					player.var_b22aca27[0].b_available = 1;
				}
				break;
			}
			case "hash_66233ad30c165ffd":
			{
				foreach(player in getplayers())
				{
					player.var_6a885e6e = 0;
					player.var_b22aca27[1].b_available = 1;
				}
				break;
			}
			case "hash_5151955e310b4ba3":
			{
				foreach(player in getplayers())
				{
					player.var_6a885e6e = 0;
					player.var_b22aca27[2].b_available = 1;
				}
				break;
			}
			case "hash_382a97b59a98fb71":
			{
				foreach(player in getplayers())
				{
					player.var_6a885e6e = 0;
					player.var_b22aca27[3].b_available = 1;
				}
				break;
			}
			case "hash_5e97858955d10c64":
			{
				foreach(player in getplayers())
				{
					player.var_6a885e6e = 0;
					player.var_b22aca27[4].b_available = 1;
				}
				break;
			}
			case "hash_5176fcfc9d31845d":
			{
				foreach(player in getplayers())
				{
					player.var_6a885e6e = 0;
					player.var_b22aca27[5].b_available = 1;
				}
				break;
			}
			case "hash_6b98535cc00fb057":
			{
				foreach(player in getplayers())
				{
					player.var_6a885e6e = 0;
					player.var_b22aca27[6].b_available = 1;
				}
				break;
			}
			case "hash_6502e8f99bd18fcd":
			{
				level thread zm_red_util::function_a94baf7b();
				return true;
				break;
			}
		}
	#/
}

/*
	Name: function_7c8b5f27
	Namespace: zm_red
	Checksum: 0x4091E817
	Offset: 0x9478
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_7c8b5f27()
{
	/#
		if(level flag::get(""))
		{
			n_amount = level.var_8b7ab859 / 4;
			self namespace_f8f28e08::function_53a333a8(undefined, n_amount);
		}
	#/
}

/*
	Name: function_71a6c3ea
	Namespace: zm_red
	Checksum: 0x9A209E0D
	Offset: 0x94E0
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_71a6c3ea()
{
	/#
		zm_devgui::zombie_devgui_open_sesame();
		scene::init("");
		level complete_pap();
	#/
}

/*
	Name: function_313ff13
	Namespace: zm_red
	Checksum: 0xBA22A5FD
	Offset: 0x9538
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_313ff13()
{
	/#
		if(isdefined(level.var_c89378af))
		{
			level.var_c89378af hide();
		}
		level flag::set(#"hash_3764b0cb106568ec");
	#/
}

/*
	Name: spawn_pegasus
	Namespace: zm_red
	Checksum: 0xFC5B7A12
	Offset: 0x9598
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function spawn_pegasus()
{
	/#
		level flag::set(#"hash_3dba794053dea40e");
		level flag::set("");
	#/
}

/*
	Name: ride_pegasus
	Namespace: zm_red
	Checksum: 0xC343B71E
	Offset: 0x95F0
	Size: 0x20E
	Parameters: 0
	Flags: None
*/
function ride_pegasus()
{
	/#
		level flag::set(#"hash_3764b0cb106568ec");
		level flag::set(#"hash_3dba794053dea40e");
		level flag::set("");
		level flag::set(#"hash_32ff7a456732ef09");
		level flag::set(#"hash_1b6616e730b1235b");
		level flag::set(#"pegasus_exited");
		level scene::init("");
		zm_devgui::zombie_devgui_open_sesame();
		level zm_utility::function_9ad5aeb1(1);
		s_ride = struct::get("");
		a_players = getplayers();
		foreach(player in a_players)
		{
			player setorigin(s_ride.origin + (randomintrange(-16, 16), randomintrange(-16, 16), 0));
		}
		wait(1);
	#/
}

/*
	Name: free_eagles
	Namespace: zm_red
	Checksum: 0x4A7ACCB6
	Offset: 0x9808
	Size: 0x28C
	Parameters: 0
	Flags: None
*/
function free_eagles()
{
	/#
		level flag::set(#"hash_3764b0cb106568ec");
		level flag::set(#"hash_3dba794053dea40e");
		level flag::set("");
		level flag::set(#"hash_32ff7a456732ef09");
		level flag::set(#"hash_1b6616e730b1235b");
		level scene::init("");
		zm_devgui::zombie_devgui_open_sesame();
		level zm_utility::function_9ad5aeb1(1);
		wait(1);
		level flag::set(#"hash_4083e9da0ba41dec");
		var_ff91be3a = struct::get_array("", "");
		var_a10268d3 = level.players;
		for(i = 0; i < var_a10268d3.size; i++)
		{
			var_a10268d3[i] setorigin(var_ff91be3a[i].origin);
			var_a10268d3[i] setplayerangles(var_ff91be3a[i].angles);
		}
		level thread zm_red_pap_quest::function_a2b76316();
		level thread zm_red_pap_quest::function_5a4d8124();
		level flag::set(#"cage_dropped");
		level flag::set(#"eagle_attack");
		level flag::set(#"hash_67695ee69c57c0b2");
		level flag::set(#"hash_61de3b8fe6f6a35");
	#/
}

/*
	Name: complete_pap
	Namespace: zm_red
	Checksum: 0x351062A0
	Offset: 0x9AA0
	Size: 0x3A4
	Parameters: 0
	Flags: None
*/
function complete_pap()
{
	/#
		level.b_skip = 1;
		if(isdefined(level.var_c89378af))
		{
			level.var_c89378af delete();
		}
		level flag::set(#"hash_3764b0cb106568ec");
		level flag::set(#"hash_3dba794053dea40e");
		level flag::set("");
		level flag::set(#"hash_32ff7a456732ef09");
		level flag::set(#"hash_4083e9da0ba41dec");
		level flag::set(#"pap_quest_completed");
		level flag::set(#"zm_red_fasttravel_open");
		level flag::set(#"cage_dropped");
		level flag::set(#"hash_67695ee69c57c0b2");
		level flag::set(#"hash_61de3b8fe6f6a35");
		level flag::set(#"hash_7943879f3be8ccc6");
		level thread zm_red_power_quest::devgui_complete();
		level thread scene::play(#"hash_6c19cacedbc244f", "");
		level thread scene::play(#"hash_437ea4a503c2e1c7", "");
		level thread scene::play(#"hash_c877e10a252f5a8", "");
		level thread scene::play(#"hash_6c19cacedbc244f", "");
		level thread scene::play(#"hash_437ea4a503c2e1c7", "");
		level thread scene::play(#"hash_c877e10a252f5a8", "");
		level thread scene::play(#"hash_6c19cacedbc244f", "");
		level thread scene::play(#"hash_437ea4a503c2e1c7", "");
		level scene::play(#"hash_c877e10a252f5a8", "");
		var_6800d950 = getent("", "");
		if(isdefined(var_6800d950))
		{
			var_6800d950 delete();
		}
		level flag::set(#"eagle_attack");
		level flag::set(#"egg_free");
	#/
}

/*
	Name: function_f39d0796
	Namespace: zm_red
	Checksum: 0x5F7240EC
	Offset: 0x9E50
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_f39d0796()
{
	/#
		level flag::set(#"hash_4083e9da0ba41dec");
	#/
}

/*
	Name: function_3594d78b
	Namespace: zm_red
	Checksum: 0x1E06D387
	Offset: 0x9E88
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_3594d78b()
{
	/#
		zombie_gegenees_util::spawn_single(1);
	#/
}

/*
	Name: function_590ce3bd
	Namespace: zm_red
	Checksum: 0x34E1BA6B
	Offset: 0x9EB0
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_590ce3bd()
{
	/#
		zombie_skeleton_util::function_1ea880bd(1);
	#/
}

/*
	Name: function_80b73b4
	Namespace: zm_red
	Checksum: 0xFD11D133
	Offset: 0x9ED8
	Size: 0x13E
	Parameters: 0
	Flags: None
*/
function function_80b73b4()
{
	/#
		self notify("");
		self endon("");
		if(getdvarint(#"hash_49d01fe7f6492094", 0) == 0)
		{
			setdvar(#"hash_49d01fe7f6492094", 1);
		}
		else
		{
			setdvar(#"hash_49d01fe7f6492094", 0);
			return;
		}
		while(getdvarint(#"hash_49d01fe7f6492094", 0))
		{
			function_e8760afa(level.zm_loc_types[#"zombie_location"]);
			function_e8760afa(level.zm_loc_types[#"gegenees_location"]);
			function_e8760afa(level.zm_loc_types[#"blight_father_location"]);
			waitframe(1);
		}
	#/
}

/*
	Name: function_e8760afa
	Namespace: zm_red
	Checksum: 0x540D9EF
	Offset: 0xA020
	Size: 0x1A0
	Parameters: 1
	Flags: None
*/
function function_e8760afa(a_s_locs)
{
	/#
		foreach(s_loc in a_s_locs)
		{
			var_91d1913b = distance2d(level.players[0].origin, s_loc.origin);
			n_radius = 0.015 * var_91d1913b;
			if(n_radius > 768)
			{
				n_radius = 768;
			}
			if(var_91d1913b > 64 && var_91d1913b < 2000)
			{
				sphere(s_loc.origin, n_radius, (0, 0, 1), 1, 0, 10, 1);
				print3d(s_loc.origin + (0, 0, 24), s_loc.script_noteworthy, (0, 0, 1), 1, 1, 1);
			}
		}
	#/
}

/*
	Name: function_bb5a8b5e
	Namespace: zm_red
	Checksum: 0x8EC381A9
	Offset: 0xA1C8
	Size: 0x1F8
	Parameters: 1
	Flags: None
*/
function function_bb5a8b5e(b_charged)
{
	/#
		if(b_charged)
		{
			var_d9d642ba = array(level.w_hand_charon, level.w_hand_gaia, level.w_hand_ouranos, level.w_hand_hemera);
		}
		else
		{
			var_d9d642ba = array(level.w_hand_charon_uncharged, level.w_hand_gaia_uncharged, level.w_hand_ouranos_uncharged, level.w_hand_hemera_uncharged);
		}
		var_d9d642ba = array::randomize(var_d9d642ba);
		foreach(i, e_player in getplayers())
		{
			var_3ba4bf7d = e_player getweaponslistprimaries();
			if(var_3ba4bf7d.size > 1)
			{
				w_current = e_player getcurrentweapon();
				if(isdefined(w_current) && isinarray(var_3ba4bf7d, w_current))
				{
					e_player takeweapon(w_current);
				}
				else
				{
					return;
				}
			}
			w_ww = var_d9d642ba[i];
			e_player giveweapon(w_ww);
			e_player switchtoweaponimmediate(w_ww, 1);
		}
	#/
}

