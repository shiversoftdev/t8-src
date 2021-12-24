// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_15c45f6ceed8c664;
#using script_190d6b82bcca0908;
#using script_192830e549417cae;
#using script_1b10fdf0addd52e;
#using script_1baaed37fe4669a4;
#using script_1c51d02b2a870d66;
#using script_20ac552ee498eb9d;
#using script_20f0345a320cc189;
#using script_25ef58a2f6c13bd9;
#using script_261bf0c99a18fc19;
#using script_271b338bc5e801f1;
#using script_27c22e1d8df4d852;
#using script_281eabb4df02b1c;
#using script_299f56e6d0b16416;
#using script_2c5daa95f8fec03c;
#using script_2cb46c63a33c9b9c;
#using script_2e08b271d6ffbf77;
#using script_2e8dd558d392a29f;
#using script_2fd955361c8b5861;
#using script_301f64a4090c381a;
#using script_345bb77d6298356c;
#using script_35598499769dbb3d;
#using script_35b5ff21c2a0960f;
#using script_3688d332e17e9ac1;
#using script_3743c984969444fd;
#using script_37cd05f5ce399867;
#using script_3912c6b178efd520;
#using script_3975dbbf20d501ed;
#using script_3ab029db1d973ccd;
#using script_3b034476f596d018;
#using script_3f9e0dc8454d98e1;
#using script_4194df57536e11ed;
#using script_42499e7667ceb9a8;
#using script_42f2fc7321ce6ef3;
#using script_45a4e17fd13b3121;
#using script_460f2e04fb3cff8a;
#using script_469904a7587a8d6e;
#using script_46b763cb3769d370;
#using script_47fb62300ac0bd60;
#using script_48f7c4ab73137f8;
#using script_4d000493c57bb851;
#using script_53f13b381cd4251d;
#using script_5660bae5b402a1eb;
#using script_59abbd3afb4260b8;
#using script_5b4f7a8178990872;
#using script_5bb072c3abf4652c;
#using script_5ec7afe85b493b9d;
#using script_5f7a85316133915b;
#using script_6021ce59143452c3;
#using script_663c3bd4763135c6;
#using script_68c06910e987dea0;
#using script_68d0af4307c05cca;
#using script_6ce38ab036223e6e;
#using script_6df8c1e16bc0a728;
#using script_6e3c826b1814cab6;
#using script_704280a6086efc24;
#using script_708f86069429bb48;
#using script_71c99f9188d13a15;
#using script_7224d61ed502ea07;
#using script_729483e239af8960;
#using script_741ad7d45afb75ac;
#using script_77ffcd7bdce11b7;
#using script_7daae2066da4b3f7;
#using script_7e1a8b23e43eca16;
#using script_7e59d7bba853fe4b;
#using script_7fb938e966bd5c04;
#using script_9e4105ea1798ccc;
#using script_aed3ce8e2908a0a;
#using script_b52a163973f339f;
#using script_b56031714f70b20;
#using script_c9833a62d6b6bf;
#using script_db06eb511bd9b36;
#using script_f1c34b62cac9967;
#using script_f8bd1830885acc6;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_puppeteer_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\demo_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\rat_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\bb.gsc;
#using scripts\zm_common\gametypes\globallogic.gsc;
#using scripts\zm_common\gametypes\globallogic_player.gsc;
#using scripts\zm_common\gametypes\globallogic_spawn.gsc;
#using scripts\zm_common\gametypes\zm_gametype.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_challenges.gsc;
#using scripts\zm_common\zm_daily_challenges.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_ffotd.gsc;
#using scripts\zm_common\zm_game_module.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_placeable_mine.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm;

/*
	Name: ignore_systems
	Namespace: zm
	Checksum: 0x77273750
	Offset: 0x13D0
	Size: 0x2A4
	Parameters: 0
	Flags: AutoExec
*/
autoexec function ignore_systems()
{
	system::ignore(#"gadget_clone");
	system::ignore(#"gadget_armor");
	system::ignore(#"gadget_cleanse");
	system::ignore(#"hash_52aca7c35be649b8");
	system::ignore(#"gadget_heat_wave");
	system::ignore(#"gadget_resurrect");
	system::ignore(#"gadget_shock_field");
	system::ignore(#"gadget_overdrive");
	system::ignore(#"gadget_security_breach");
	system::ignore(#"gadget_combat_efficiency");
	system::ignore(#"gadget_other");
	system::ignore(#"gadget_camo");
	system::ignore(#"gadget_vision_pulse");
	system::ignore(#"gadget_speed_burst");
	system::ignore(#"gadget_sprint_boost");
	system::ignore(#"spike_charge_siegebot");
	system::ignore(#"siegebot");
	system::ignore(#"amws");
	system::ignore(#"gadget_health_regen");
	system::ignore(#"influencers_shared");
	system::ignore(#"hash_2ce2e438ecd6b2d2");
}

/*
	Name: function_89f2df9
	Namespace: zm
	Checksum: 0x9DE745FF
	Offset: 0x1680
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm
	Checksum: 0xABE50514
	Offset: 0x16C8
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.zombie_vars))
	{
		level.zombie_vars = [];
	}
	level.scr_zm_ui_gametype = util::function_5df4294();
	level.scr_zm_ui_gametype_group = "";
	level.scr_zm_map_start_location = "";
	level.var_aaf21bbb = 0;
	level.var_5caadd40 = 0;
	level.var_b68902c4 = 1;
}

/*
	Name: init
	Namespace: zm
	Checksum: 0x1E9E3033
	Offset: 0x1760
	Size: 0x934
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(isdefined(level.aat_in_use) && level.aat_in_use)
	{
		register_vehicle_damage_callback(&aat::aat_vehicle_damage_monitor);
		register_zombie_damage_override_callback(&aat::aat_response);
	}
	setdvar(#"doublejump_enabled", 0);
	setdvar(#"wallrun_enabled", 0);
	setdvar(#"sprintleap_enabled", 0);
	setdvar(#"traverse_mode", 2);
	setdvar(#"weaponrest_enabled", 0);
	setdvar(#"ui_allowdisplaycontinue", 1);
	if(!isdefined(level.killstreakweapons))
	{
		level.killstreakweapons = [];
	}
	level.weaponnone = getweapon(#"none");
	level.weaponnull = getweapon(#"weapon_null");
	level.weaponbasemelee = getweapon(#"knife");
	level.weaponbasemeleeheld = getweapon(#"knife_held");
	if(!isdefined(level.weaponriotshield))
	{
		level.weaponriotshield = getweapon(#"riotshield");
	}
	level.weaponrevivetool = getweapon(#"syrette");
	level.weaponzmdeaththroe = getweapon(#"death_throe");
	level.weaponzmfists = getweapon(#"zombie_fists");
	if(!isdefined(level.givecustomloadout))
	{
		level.givecustomloadout = &zm_weapons::give_start_weapons;
	}
	level.projectiles_should_ignore_world_pause = 1;
	level.player_out_of_playable_area_monitor = 1;
	level.player_too_many_players_check = 1;
	level.player_too_many_players_check_func = &player_too_many_players_check;
	level._use_choke_weapon_hints = 1;
	level._use_choke_blockers = 1;
	level.speed_change_round = 15;
	if(!isdefined(level.custom_ai_type))
	{
		level.custom_ai_type = [];
	}
	level.custom_ai_spawn_check_funcs = [];
	level thread zm_ffotd::main_start();
	level.zombiemode = 1;
	level.revivefeature = 0;
	level.swimmingfeature = 0;
	level.calc_closest_player_using_paths = 0;
	level.zombie_melee_in_water = 1;
	level.put_timed_out_zombies_back_in_queue = 1;
	level.use_alternate_poi_positioning = 1;
	level.zmb_laugh_alias = "zmb_player_outofbounds";
	level.sndannouncerisrich = 1;
	level.curr_gametype_affects_rank = 0;
	gametype = util::function_5df4294();
	if("zclassic" == gametype || "zstandard" == gametype)
	{
		level.curr_gametype_affects_rank = 1;
	}
	level.grenade_multiattack_bookmark_count = 1;
	demo::initactorbookmarkparams(3, 6000, 6000);
	if(!isdefined(level._zombies_round_spawn_failsafe))
	{
		level._zombies_round_spawn_failsafe = &zombie_utility::round_spawn_failsafe;
	}
	level.func_get_zombie_spawn_delay = &namespace_a28acff3::get_zombie_spawn_delay;
	level.func_get_delay_between_rounds = &namespace_a28acff3::get_delay_between_rounds;
	level.var_3426461d = &function_a2b54d42;
	level.no_target_override = &zm_cleanup::no_target_override;
	level.var_d22435d9 = &zm_cleanup::function_d22435d9;
	level.zombie_visionset = "zombie_neutral";
	level.wait_and_revive = 0;
	if(getdvarint(#"anim_intro", 0) == 1)
	{
		level.zombie_anim_intro = 1;
	}
	else
	{
		level.zombie_anim_intro = 0;
	}
	zm_player::precache_models();
	precache_zombie_leaderboards();
	level._zombie_gib_piece_index_all = 0;
	level._zombie_gib_piece_index_right_arm = 1;
	level._zombie_gib_piece_index_left_arm = 2;
	level._zombie_gib_piece_index_right_leg = 3;
	level._zombie_gib_piece_index_left_leg = 4;
	level._zombie_gib_piece_index_head = 5;
	level._zombie_gib_piece_index_guts = 6;
	level._zombie_gib_piece_index_hat = 7;
	if(!isdefined(level.zombie_ai_limit))
	{
		level.zombie_ai_limit = 24;
	}
	if(!isdefined(level.zombie_actor_limit))
	{
		level.zombie_actor_limit = 31;
	}
	level.var_7c7c6c35 = zm_game_over::register("game_over");
	init_flags();
	init_dvars();
	init_strings();
	init_levelvars();
	init_sounds();
	init_shellshocks();
	init_client_field_callback_funcs();
	zm_loadout::register_offhand_weapons_for_level_defaults();
	zm_perks::init();
	zm_talisman::init();
	zm_powerups::init();
	zm_spawner::init();
	level.zombie_poi_array = getentarray("zombie_poi", "script_noteworthy");
	init_function_overrides();
	level thread zm_laststand::function_5ff83684();
	level thread post_all_players_connected();
	zm_utility::init_utility();
	initializestattracking();
	callback::on_connect(&zm_player::zm_on_player_connect);
	zm_utility::set_demo_intermission_point();
	level thread zm_ffotd::main_end();
	level thread zm_utility::track_players_intersection_tracker();
	level thread zm_utility::function_55295a16();
	level thread onallplayersready();
	level thread namespace_a28acff3::function_d20309f1();
	callback::on_spawned(&zm_player::zm_on_player_spawned);
	callback::on_disconnect(&on_player_disconnect);
	callback::on_deleted(&on_entity_deleted);
	level thread zm_utility::function_a3648315();
	/#
		printhashids();
	#/
}

/*
	Name: on_player_disconnect
	Namespace: zm
	Checksum: 0xA1E5033B
	Offset: 0x20A0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	zm_stats::function_ea5b4947(0);
}

/*
	Name: on_entity_deleted
	Namespace: zm
	Checksum: 0xAD234F84
	Offset: 0x20C8
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function on_entity_deleted()
{
	self notify(#"deleted");
}

/*
	Name: post_main
	Namespace: zm
	Checksum: 0x3AFB982C
	Offset: 0x20E8
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function post_main()
{
	level thread init_custom_ai_type();
}

/*
	Name: cheat_enabled
	Namespace: zm
	Checksum: 0xA4E694B7
	Offset: 0x2110
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function cheat_enabled(val)
{
	if(getdvarint(#"zombie_cheat", 0) >= val)
	{
		/#
			return 1;
		#/
	}
	return 0;
}

/*
	Name: fade_out_intro_screen_zm
	Namespace: zm
	Checksum: 0x8CAB7AB7
	Offset: 0x2178
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function fade_out_intro_screen_zm(hold_black_time = 0.2)
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] clientfield::set("ClearStreamerLoadingHints", 1);
	}
	if(isdefined(level.var_fdba6f4b))
	{
		[[level.var_fdba6f4b]]();
	}
	else
	{
		wait(hold_black_time);
	}
	level flag::set("initial_blackscreen_passed");
	level clientfield::set("sndZMBFadeIn", 1);
	wait(level.var_ab367500);
	if(isdefined(level.var_3a382f82))
	{
		wait(level.var_3a382f82);
	}
	else
	{
		wait(1.6);
	}
	level flag::set("gameplay_started");
	level clientfield::set("gameplay_started", 1);
	setmatchflag("disableIngameMenu", 0);
}

/*
	Name: onallplayersready
	Namespace: zm
	Checksum: 0x8074CF99
	Offset: 0x2300
	Size: 0x42C
	Parameters: 0
	Flags: Linked
*/
function onallplayersready()
{
	level endon(#"game_ended");
	changeadvertisedstatus(0);
	while(isloadingcinematicplaying())
	{
		waitframe(1);
	}
	if("zclassic" == util::function_5df4294())
	{
		changeadvertisedstatus(1);
	}
	while(!getnumexpectedplayers(1))
	{
		waitframe(1);
	}
	/#
		println("" + getnumexpectedplayers(1));
	#/
	player_count_actual = 0;
	while(player_count_actual < getnumexpectedplayers(1))
	{
		players = getplayers();
		player_count_actual = 0;
		for(i = 0; i < players.size; i++)
		{
			if(players[i].sessionstate == "playing" && !isbot(players[i]))
			{
				player_count_actual++;
			}
		}
		/#
			println((("" + getnumconnectedplayers()) + "") + getnumexpectedplayers(1));
		#/
		waitframe(1);
	}
	setinitialplayersconnected();
	/#
		println("");
	#/
	a_e_players = getplayers();
	if(a_e_players.size == 1)
	{
		level flag::set("solo_game");
		level.solo_lives_given = 0;
	}
	level flag::set("all_players_connected");
	function_9a8ab40f();
	while(!aretexturesloaded())
	{
		waitframe(1);
	}
	level util::streamer_wait(undefined, 2, 15);
	wait(5);
	function_5fad41b5();
	n_start_delay = 3;
	level thread util::delay(n_start_delay, "game_ended", &flag::set, "start_zombie_round_logic");
	level thread function_d797f41f(n_start_delay - 0.1);
	set_intermission_point();
	n_black_screen = n_start_delay + 2;
	level thread fade_out_intro_screen_zm(n_black_screen);
	wait(n_black_screen);
	level.n_gameplay_start_time = gettime();
	clientfield::set("game_start_time", level.n_gameplay_start_time);
	level notify(#"initial_fade_in_complete");
	/#
		rat::function_7d22c1c9();
	#/
	wait(n_start_delay);
	luinotifyevent(#"hash_3aef0da8363893b6");
}

/*
	Name: function_9a8ab40f
	Namespace: zm
	Checksum: 0x5B69305B
	Offset: 0x2738
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function function_9a8ab40f()
{
	do
	{
		waitframe(1);
		var_183929a8 = 0;
		a_players = getplayers();
		foreach(player in a_players)
		{
			if(!player isloadingcinematicplaying())
			{
				var_183929a8++;
			}
		}
	}
	while(a_players.size > var_183929a8);
}

/*
	Name: function_d797f41f
	Namespace: zm
	Checksum: 0x827F3B50
	Offset: 0x2800
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_d797f41f(n_waittime = 1)
{
	wait(n_waittime);
	if(!zm_utility::is_tutorial())
	{
		music::setmusicstate("none");
	}
}

/*
	Name: _outro_slow
	Namespace: zm
	Checksum: 0xE21BE333
	Offset: 0x2858
	Size: 0xA8
	Parameters: 1
	Flags: None
*/
function _outro_slow(func)
{
	level endon(#"all_players_connected", #"game_ended");
	array::thread_all(getplayers(), func);
	while(true)
	{
		result = undefined;
		result = level waittill(#"connected");
		result.player thread [[func]]();
	}
}

/*
	Name: initialblack
	Namespace: zm
	Checksum: 0x990D5AED
	Offset: 0x2908
	Size: 0x38C
	Parameters: 0
	Flags: Linked
*/
function initialblack()
{
	self endon(#"disconnect");
	initial_black = lui::function_e810a527("InitialBlack");
	initial_black initial_black::close(self);
	initial_black initial_black::open(self, 1);
	if(level flag::get("start_zombie_round_logic"))
	{
		return;
	}
	if(!(isdefined(self.hasspawned) && self.hasspawned))
	{
		self waittill(#"spawned");
	}
	do
	{
		waitframe(1);
	}
	while(!self isclientuivisibilityflagset("hud_visible"));
	val::set(#"initial_black", "hide");
	val::set(#"initial_black", "takedamage", 0);
	val::set(#"initial_black", "ignoreme");
	val::set(#"initial_black", "freezecontrols");
	val::set(#"initial_black", "disablegadgets");
	val::set(#"initial_black", "show_hud", 0);
	level flag::wait_till("initial_blackscreen_passed");
	lui::screen_fade_out(0);
	util::wait_network_frame(2);
	self thread function_9c2111a0(initial_black);
	val::reset(#"initial_black", "hide");
	val::reset(#"initial_black", "takedamage");
	util::wait_network_frame(2);
	val::reset(#"initial_black", "freezecontrols");
	self thread lui::screen_fade_in(level.var_ab367500);
	level flag::wait_till("gameplay_started");
	val::reset(#"initial_black", "ignoreme");
	val::reset(#"initial_black", "disablegadgets");
	val::reset(#"initial_black", "show_hud");
}

/*
	Name: function_9c2111a0
	Namespace: zm
	Checksum: 0x8F29EBB8
	Offset: 0x2CA0
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function function_9c2111a0(initial_black)
{
	self endon(#"disconnect");
	for(i = 0; i < 5; i++)
	{
		initial_black initial_black::close(self);
		util::wait_network_frame(2);
	}
}

/*
	Name: delete_in_createfx
	Namespace: zm
	Checksum: 0x38EEE648
	Offset: 0x2D20
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function delete_in_createfx()
{
	exterior_goals = struct::get_array("exterior_goal", "targetname");
	for(i = 0; i < exterior_goals.size; i++)
	{
		if(!isdefined(exterior_goals[i].target))
		{
			continue;
		}
		targets = getentarray(exterior_goals[i].target, "targetname");
		for(j = 0; j < targets.size; j++)
		{
			targets[j] zm_utility::self_delete();
		}
	}
	if(isdefined(level.level_createfx_callback_thread))
	{
		level thread [[level.level_createfx_callback_thread]]();
	}
}

/*
	Name: post_all_players_connected
	Namespace: zm
	Checksum: 0xAEC9C938
	Offset: 0x2E30
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function post_all_players_connected()
{
	level thread end_game();
	level flag::wait_till("start_zombie_round_logic");
	level.var_aaf21bbb = level.players.size;
	level.var_5caadd40 = util::get_human_players(#"allies").size;
	/#
		println("", level.script, "", getplayers().size);
	#/
	level thread round_end_monitor();
	if(!level.zombie_anim_intro)
	{
		if(isdefined(level._round_start_func))
		{
			level thread [[level._round_start_func]]();
		}
	}
	level thread players_playing();
	level.startinvulnerabletime = getdvarint(#"player_deathinvulnerabletime", 0);
	level thread zm_stats::function_b14863c1();
}

/*
	Name: start_zm_dash_counter_watchers
	Namespace: zm
	Checksum: 0x3289FD5C
	Offset: 0x2F98
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function start_zm_dash_counter_watchers()
{
	level thread first_consumables_used_watcher();
}

/*
	Name: first_consumables_used_watcher
	Namespace: zm
	Checksum: 0x823B912B
	Offset: 0x2FC0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function first_consumables_used_watcher()
{
	level flag::init("first_consumables_used");
}

/*
	Name: init_custom_ai_type
	Namespace: zm
	Checksum: 0xE07750BC
	Offset: 0x2FF0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function init_custom_ai_type()
{
	if(isdefined(level.custom_ai_type))
	{
		for(i = 0; i < level.custom_ai_type.size; i++)
		{
			[[level.custom_ai_type[i]]]();
		}
	}
}

/*
	Name: zombiemode_melee_miss
	Namespace: zm
	Checksum: 0xE673CB0F
	Offset: 0x3050
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function zombiemode_melee_miss()
{
	if(isdefined(self.enemy.curr_pay_turret))
	{
		self.enemy dodamage(getdvarint(#"ai_meleedamage", 0), self.origin, self, self, "none", "melee");
	}
}

/*
	Name: init_shellshocks
	Namespace: zm
	Checksum: 0x305E590F
	Offset: 0x30D0
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function init_shellshocks()
{
	level.player_killed_shellshock = "zombie_death";
}

/*
	Name: init_strings
	Namespace: zm
	Checksum: 0x22BD6F80
	Offset: 0x30F0
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function init_strings()
{
	zm_utility::add_zombie_hint("undefined", #"hash_12e8fa7cbcc02ee4");
	if(function_8b1a219a())
	{
		zm_utility::add_zombie_hint("default_treasure_chest", #"hash_52426a433be4aa00");
	}
	else
	{
		zm_utility::add_zombie_hint("default_treasure_chest", #"hash_40a3bd4c33eac8cc");
	}
	if(function_8b1a219a())
	{
		zm_utility::add_zombie_hint("default_buy_barrier_piece_10", #"hash_3dd048373e06ad1f");
		zm_utility::add_zombie_hint("default_buy_barrier_piece_20", #"hash_47ff6a92609a306e");
		zm_utility::add_zombie_hint("default_buy_barrier_piece_50", #"hash_693bb70d9737a5b");
		zm_utility::add_zombie_hint("default_buy_barrier_piece_100", #"hash_42e37d69c3691009");
	}
	else
	{
		zm_utility::add_zombie_hint("default_buy_barrier_piece_10", #"hash_1c189b8ad7ec73a1");
		zm_utility::add_zombie_hint("default_buy_barrier_piece_20", #"hash_1c1c218ad7ef8d2a");
		zm_utility::add_zombie_hint("default_buy_barrier_piece_50", #"hash_1c26138ad7f7c9e5");
		zm_utility::add_zombie_hint("default_buy_barrier_piece_100", #"hash_2a43ddece6c85f63");
	}
	zm_utility::add_zombie_hint("default_reward_barrier_piece", #"hash_6a8e67597b680da2");
	zm_utility::add_zombie_hint("default_buy_area", #"hash_cc45440fbd070dc");
}

/*
	Name: init_sounds
	Namespace: zm
	Checksum: 0xF79138B9
	Offset: 0x3338
	Size: 0x3E4
	Parameters: 0
	Flags: Linked
*/
function init_sounds()
{
	zm_utility::add_sound("end_of_round", "mus_zmb_round_over");
	zm_utility::add_sound("end_of_game", "mus_zmb_game_over");
	zm_utility::add_sound("chalk_one_up", "mus_zmb_chalk");
	zm_utility::add_sound("purchase", "zmb_cha_ching");
	zm_utility::add_sound("no_purchase", "zmb_no_cha_ching");
	zm_utility::add_sound("playerzombie_usebutton_sound", "zmb_zombie_vocals_attack");
	zm_utility::add_sound("playerzombie_attackbutton_sound", "zmb_zombie_vocals_attack");
	zm_utility::add_sound("playerzombie_adsbutton_sound", "zmb_zombie_vocals_attack");
	zm_utility::add_sound("zombie_head_gib", "zmb_zombie_head_gib");
	zm_utility::add_sound("rebuild_barrier_piece", "zmb_repair_boards");
	zm_utility::add_sound("rebuild_barrier_metal_piece", "zmb_metal_repair");
	zm_utility::add_sound("rebuild_barrier_hover", "zmb_boards_float");
	zm_utility::add_sound("debris_hover_loop", "zmb_couch_loop");
	zm_utility::add_sound("break_barrier_piece", "zmb_break_boards");
	zm_utility::add_sound("grab_metal_bar", "zmb_bar_pull");
	zm_utility::add_sound("break_metal_bar", "zmb_bar_break");
	zm_utility::add_sound("drop_metal_bar", "zmb_bar_drop");
	zm_utility::add_sound("blocker_end_move", "zmb_board_slam");
	zm_utility::add_sound("barrier_rebuild_slam", "zmb_board_slam");
	zm_utility::add_sound("bar_rebuild_slam", "zmb_bar_repair");
	zm_utility::add_sound("zmb_rock_fix", "zmb_break_rock_barrier_fix");
	zm_utility::add_sound("zmb_vent_fix", "evt_vent_slat_repair");
	zm_utility::add_sound("zmb_barrier_debris_move", "zmb_barrier_debris_move");
	zm_utility::add_sound("door_slide_open", "zmb_door_slide_open");
	zm_utility::add_sound("door_rotate_open", "zmb_door_slide_open");
	zm_utility::add_sound("debris_move", "zmb_weap_wall");
	zm_utility::add_sound("open_chest", "zmb_lid_open");
	zm_utility::add_sound("music_chest", "zmb_music_box");
	zm_utility::add_sound("close_chest", "zmb_lid_close");
	zm_utility::add_sound("weapon_show", "zmb_weap_wall");
	zm_utility::add_sound("break_stone", "evt_break_stone");
}

/*
	Name: init_levelvars
	Namespace: zm
	Checksum: 0x40B59612
	Offset: 0x3728
	Size: 0x924
	Parameters: 0
	Flags: Linked
*/
function init_levelvars()
{
	level.is_zombie_level = 1;
	level.default_laststandpistol = getweapon(#"pistol_topbreak_t8");
	level.default_solo_laststandpistol = getweapon(#"hash_6a0c4101e88a4707");
	level.super_ee_weapon = getweapon(#"pistol_burst");
	level.laststandpistol = level.default_laststandpistol;
	level.start_weapon = level.default_laststandpistol;
	level.first_round = 1;
	level.start_round = getgametypesetting(#"startround");
	level.round_number = level.start_round;
	level.enable_magic = getgametypesetting(#"magic");
	level.headshots_only = getgametypesetting(#"hash_4cb15aed177a8ef5");
	level.player_starting_points = function_b10f6843();
	level.round_start_time = 0;
	level.pro_tips_start_time = 0;
	level.intermission = 0;
	level.dog_intermission = 0;
	level.zombie_total = 0;
	level.zombie_respawns = 0;
	level.var_9427911d = 0;
	level.total_zombies_killed = 0;
	level.zm_loc_types = [];
	level.zm_loc_types[#"zombie_location"] = [];
	level.var_9b91564e = 8;
	level.zm_variant_type_max = [];
	level.zm_variant_type_max[#"walk"] = [];
	level.zm_variant_type_max[#"run"] = [];
	level.zm_variant_type_max[#"sprint"] = [];
	level.zm_variant_type_max[#"super_sprint"] = [];
	level.zm_variant_type_max[#"walk"][#"down"] = 14;
	level.zm_variant_type_max[#"walk"][#"up"] = 16;
	level.zm_variant_type_max[#"run"][#"down"] = 13;
	level.zm_variant_type_max[#"run"][#"up"] = 12;
	level.zm_variant_type_max[#"sprint"][#"down"] = 9;
	level.zm_variant_type_max[#"sprint"][#"up"] = 8;
	level.zm_variant_type_max[#"super_sprint"][#"down"] = 1;
	level.zm_variant_type_max[#"super_sprint"][#"up"] = 1;
	level.zm_variant_type_max[#"burned"][#"down"] = 1;
	level.zm_variant_type_max[#"burned"][#"up"] = 1;
	level.zm_variant_type_max[#"jump_pad_super_sprint"][#"down"] = 1;
	level.zm_variant_type_max[#"jump_pad_super_sprint"][#"up"] = 1;
	level.var_d9ffddf4 = [];
	level.var_d9ffddf4[#"walk"] = 4;
	level.var_d9ffddf4[#"run"] = 4;
	level.var_d9ffddf4[#"sprint"] = 4;
	level.var_d9ffddf4[#"super_sprint"] = 4;
	level.var_d9ffddf4[#"crawl"] = 3;
	level.current_zombie_array = [];
	level.current_zombie_count = 0;
	level.zombie_total_subtract = 0;
	level.destructible_callbacks = [];
	foreach(team, _ in level.teams)
	{
		if(!isdefined(level.zombie_vars[team]))
		{
			level.zombie_vars[team] = [];
		}
	}
	if(!isdefined(level.var_aed5d327))
	{
		level.var_aed5d327 = [];
	}
	level.gamedifficulty = getgametypesetting(#"zmdifficulty");
	level.var_ab367500 = 1.5;
	zombie_utility::set_zombie_var(#"below_world_check", -1000);
	zombie_utility::set_zombie_var(#"spectators_respawn", 1);
	zombie_utility::set_zombie_var(#"zombie_use_failsafe", 1);
	zombie_utility::set_zombie_var(#"zombie_between_round_time", 15);
	zombie_utility::set_zombie_var(#"zombie_intermission_time", 15);
	zombie_utility::set_zombie_var(#"hash_6bae95928bbe8f1", 10);
	zombie_utility::set_zombie_var(#"hash_6f24d1fbe8a09727", 90);
	zombie_utility::set_zombie_var(#"zombie_score_bonus_melee", 60);
	zombie_utility::set_zombie_var(#"zombie_score_bonus_head", 30);
	zombie_utility::set_zombie_var(#"hash_68aa9b4c8de33261", 50);
	zombie_utility::set_zombie_var(#"zombify_player", 0);
	if(issplitscreen())
	{
		zombie_utility::set_zombie_var(#"zombie_timer_offset", 280);
	}
	function_1442d44f();
	level thread init_player_levelvars();
	level.speed_change_max = 0;
	level.speed_change_num = 0;
	namespace_a28acff3::set_round_number(level.round_number);
	zm_score::function_e5d6e6dd(#"zombie", zombie_utility::function_d2dfacfd(#"hash_6f24d1fbe8a09727"));
}

/*
	Name: function_b10f6843
	Namespace: zm
	Checksum: 0x4798E69
	Offset: 0x4058
	Size: 0x66
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b10f6843()
{
	n_starting = ((level.round_number - namespace_59ff1d6c::function_901b751c(#"startround")) + 1) * 500;
	return (isdefined(level.player_starting_points) ? level.player_starting_points : n_starting);
}

/*
	Name: function_1442d44f
	Namespace: zm
	Checksum: 0xBCBB099D
	Offset: 0x40C8
	Size: 0x664
	Parameters: 0
	Flags: Linked
*/
function function_1442d44f()
{
	var_c6ceb446 = function_268ef952();
	zombie_utility::set_zombie_var(#"zombie_health_increase", var_c6ceb446[#"zomhealthincrease"], 0);
	zombie_utility::set_zombie_var(#"zombie_health_increase_multiplier", var_c6ceb446[#"zomhealthincreasemult"], 1);
	zombie_utility::set_zombie_var(#"zombie_health_start", var_c6ceb446[#"zombasehealth"], 0);
	zombie_utility::set_zombie_var(#"hash_7d5a25e2463f7fc5", var_c6ceb446[#"zomspawndelay"], 0);
	zombie_utility::set_zombie_var(#"zombie_new_runner_interval", var_c6ceb446[#"zomnewrunnerint"], 0);
	zombie_utility::set_zombie_var(#"zombie_max_ai", var_c6ceb446[#"zommaxcount"], 0);
	zombie_utility::set_zombie_var(#"zombie_ai_per_player", var_c6ceb446[#"zommaxcountperplayer"], 0);
	zombie_utility::set_zombie_var(#"zombie_move_speed_multiplier", var_c6ceb446[#"zommovespeedmult"], 0);
	zombie_utility::set_zombie_var(#"hash_607bc50072c2a386", var_c6ceb446[#"zomcountscalar"], 1);
	zombie_utility::set_zombie_var(#"hash_67b3cbf79292e047", var_c6ceb446[#"zomcountsolomult"], 1);
	zombie_utility::set_zombie_var(#"player_base_health", var_c6ceb446[#"plybasehealth"], 0);
	zombie_utility::set_zombie_var(#"player_health_regen_rate", var_c6ceb446[#"plyhealthregenrate"], 0);
	zombie_utility::set_zombie_var(#"player_health_regen_delay", var_c6ceb446[#"plyhealthregendelay"], 0);
	zombie_utility::set_zombie_var(#"penalty_no_revive", var_c6ceb446[#"plypenaltynorevive"], 1);
	zombie_utility::set_zombie_var(#"penalty_died", var_c6ceb446[#"plypenaltydeath"], 1);
	zombie_utility::set_zombie_var(#"penalty_downed", var_c6ceb446[#"plypenaltydowned"], 1);
	zombie_utility::set_zombie_var(#"hash_3037a1f286b662e6", var_c6ceb446[#"plypenaltydownedpointstep"], 1);
	zombie_utility::set_zombie_var(#"hash_3098c53bba6402d3", var_c6ceb446[#"plyselfrevivecountcoop"], 0);
	zombie_utility::set_zombie_var(#"hash_67ae1b8cbb7c985", var_c6ceb446[#"plyselfrevivecountsolo"], 0);
	zombie_utility::set_zombie_var(#"hash_cc85b961f25c2ff", var_c6ceb446[#"plyshielddamagemult"], 1);
	zombie_utility::set_zombie_var(#"retain_weapons", var_c6ceb446[#"plyretainweapons"], 0);
	zombie_utility::set_zombie_var(#"perks_decay", var_c6ceb446[#"plyperksdecay"], 0);
	zombie_utility::set_zombie_var(#"hash_1ab42b4d7db4cb3c", var_c6ceb446[#"plyxpmodfier"], 1);
	zombie_utility::set_zombie_var(#"hash_44737d225ec3b9d7", var_c6ceb446[#"plyhighlightcraftables"], 0);
	zombie_utility::set_zombie_var(#"zombie_point_scalar", var_c6ceb446[#"zompointscalar"], undefined, undefined, 1);
	zombie_utility::set_zombie_var(#"hash_3a4a041c1d674898", var_c6ceb446[#"zommixedstart"], 0);
	zombie_utility::set_zombie_var(#"hash_762b7db4166c70aa", var_c6ceb446[#"zommixedstartsolo"], 0);
	zombie_utility::set_zombie_var(#"hash_6eb9b2d60babd5aa", var_c6ceb446[#"zomcatalyststart"], 0);
	zombie_utility::set_zombie_var(#"hash_376905ad360fc2e8", var_c6ceb446[#"zomcatalyststartsolo"], 0);
	zombie_utility::set_zombie_var(#"hash_3b4ad7449c039d1b", var_c6ceb446[#"zomstokerstart"], 0);
	zombie_utility::set_zombie_var(#"hash_2374f3ef775ac2c3", var_c6ceb446[#"zomstokerstartsolo"], 0);
	level flagsys::set(#"hash_55d385069aec3065");
}

/*
	Name: function_268ef952
	Namespace: zm
	Checksum: 0xAEDBE9B9
	Offset: 0x4738
	Size: 0x2CC
	Parameters: 0
	Flags: Linked
*/
function function_268ef952()
{
	if(isdefined(level.var_cd45ee9f))
	{
		var_ca9c0ca2 = getscriptbundle(level.var_cd45ee9f);
	}
	else
	{
		var_ca9c0ca2 = getscriptbundle("zm_base_difficulty");
	}
	var_c6ceb446 = [];
	switch(level.gamedifficulty)
	{
		case 0:
		{
			str_suffix = "_E";
			break;
		}
		case 1:
		default:
		{
			str_suffix = "_N";
			break;
		}
		case 2:
		{
			str_suffix = "_H";
			break;
		}
		case 3:
		{
			str_suffix = "_I";
			break;
		}
	}
	foreach(var_c9db62d5 in array("zomMoveSpeedMult", "zomBaseHealth", "zomHealthIncrease", "zomHealthIncreaseMult", "zomSpawnDelay", "zomNewRunnerInt", "zomMaxCount", "zomMaxCountPerPlayer", "zomCountScalar", "zomCountSoloMult", "zomPointScalar", "plyBaseHealth", "plyPenaltyNoRevive", "plyPenaltyDeath", "plyPenaltyDowned", "plyPenaltyDownedPointStep", "plySelfReviveCountCoop", "plySelfReviveCountSolo", "zomMixedStart", "zomMixedStartSolo", "zomCatalystStart", "zomCatalystStartSolo", "zomStokerStart", "zomStokerStartSolo", "plyShieldDamageMult", "plyRetainWeapons", "plyPerksDecay", "plyHealthRegenRate", "plyHealthRegenDelay", "plyXPModfier", "plyHighlightCraftables"))
	{
		if(!isdefined(var_ca9c0ca2.(var_c9db62d5 + str_suffix)))
		{
			var_ca9c0ca2.(var_c9db62d5 + str_suffix) = 0;
		}
		var_c6ceb446[var_c9db62d5] = var_ca9c0ca2.(var_c9db62d5 + str_suffix);
	}
	return var_c6ceb446;
}

/*
	Name: init_player_levelvars
	Namespace: zm
	Checksum: 0x395E9716
	Offset: 0x4A10
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function init_player_levelvars()
{
	level flag::wait_till("start_zombie_round_logic");
	difficulty = 1;
	column = int(difficulty) + 1;
	for(i = 0; i < 8; i++)
	{
		points = 500;
		if(i > 3)
		{
			points = 3000;
		}
		points = zombie_utility::set_zombie_var(("zombie_score_start_" + (i + 1)) + "p", points, 0, column);
	}
}

/*
	Name: init_dvars
	Namespace: zm
	Checksum: 0x81A742CF
	Offset: 0x4AF8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function init_dvars()
{
	setdvar(#"magic_chest_movable", 1);
	setdvar(#"revive_trigger_radius", 75);
	setdvar(#"scr_deleteexplosivesonspawn", 0);
	setdvar(#"hash_442d42efc73d739a", 50);
}

/*
	Name: init_function_overrides
	Namespace: zm
	Checksum: 0x4E0DC2E9
	Offset: 0x4BA0
	Size: 0x186
	Parameters: 0
	Flags: Linked
*/
function init_function_overrides()
{
	level.callbackplayerdamage = &zm_player::callback_playerdamage;
	level.overrideplayerdamage = &zm_player::player_damage_override;
	level.callbackplayerkilled = &zm_player::player_killed_override;
	level.callbackplayerlaststand = &zm_player::callback_playerlaststand;
	level.prevent_player_damage = &zm_player::player_prevent_damage;
	level.callbackactorkilled = &actor_killed_override;
	level.callbackactordamage = &actor_damage_override_wrapper;
	level.var_6788bf11 = &namespace_e42b3e24::function_8c7ec52f;
	level.callbackvehicledamage = &vehicle_damage_override;
	level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
	level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
	level.custom_introscreen = &zombie_intro_screen;
	level.custom_intermission = &zm_player::player_intermission;
	level.reset_clientdvars = &zm_player::onplayerconnect_clientdvars;
	level.player_becomes_zombie = &namespace_cc96b007::zombify_player;
	level.validate_enemy_path_length = &zm_utility::default_validate_enemy_path_length;
}

/*
	Name: init_flags
	Namespace: zm
	Checksum: 0xFBE37E66
	Offset: 0x4D30
	Size: 0x2C8
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init("solo_game");
	level flag::init("start_zombie_round_logic");
	level flag::init("start_encounters_match_logic");
	level flag::init("spawn_point_override");
	level flag::init("crawler_round");
	level flag::init("spawn_zombies", 1);
	level flag::init("special_round");
	level flag::init("dog_round");
	level flag::init("raps_round");
	level flag::init("begin_spawning");
	level flag::init("end_round_wait");
	level flag::init("wait_and_revive");
	level flag::init("initial_blackscreen_passed");
	level flag::init("gameplay_started");
	setmatchflag("disableIngameMenu", 1);
	level flag::init("power_on");
	power_trigs = getentarray("use_elec_switch", "targetname");
	foreach(trig in power_trigs)
	{
		if(isdefined(trig.script_int))
		{
			level flag::init("power_on" + trig.script_int);
		}
	}
}

/*
	Name: init_client_field_callback_funcs
	Namespace: zm
	Checksum: 0xF6EBEA96
	Offset: 0x5000
	Size: 0x3F4
	Parameters: 0
	Flags: Linked
*/
function init_client_field_callback_funcs()
{
	clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
	if(isdefined(level.use_water_risers) && level.use_water_risers)
	{
		clientfield::register("actor", "zombie_riser_fx_water", 1, 1, "int");
	}
	if(isdefined(level.use_foliage_risers) && level.use_foliage_risers)
	{
		clientfield::register("actor", "zombie_riser_fx_foliage", 1, 1, "int");
	}
	if(isdefined(level.use_low_gravity_risers) && level.use_low_gravity_risers)
	{
		clientfield::register("actor", "zombie_riser_fx_lowg", 1, 1, "int");
	}
	clientfield::register("actor", "zombie_ragdoll_explode", 1, 1, "int");
	clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int");
	clientfield::register("actor", "zombie_keyline_render", 1, 1, "int");
	bits = 4;
	trigs = getentarray("use_elec_switch", "targetname");
	if(isdefined(trigs))
	{
		bits = getminbitcountfornum(trigs.size + 1);
	}
	clientfield::register("world", "zombie_power_on", 1, bits, "int");
	clientfield::register("world", "zombie_power_off", 1, bits, "int");
	clientfield::register("world", "zesn", 1, 1, "int");
	clientfield::register("world", "round_complete_time", 1, 20, "int");
	clientfield::register("world", "round_complete_num", 1, 8, "int");
	clientfield::register("world", "game_end_time", 1, 20, "int");
	clientfield::register("world", "quest_complete_time", 1, 20, "int");
	clientfield::register("world", "game_start_time", 1, 20, "int");
	clientfield::register("scriptmover", "rob_zm_prop_fade", 1, 1, "int");
	clientfield::register("clientuimodel", "ZMInvTalisman.show", 1, 1, "int");
}

/*
	Name: init_fx
	Namespace: zm
	Checksum: 0x8A350FDC
	Offset: 0x5400
	Size: 0x58A
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level.createfx_callback_thread = &delete_in_createfx;
	level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
	level._effect[#"switch_sparks"] = #"hash_26f37488feec03c3";
	level._effect[#"hash_4159f23a18f644a7"] = #"hash_71ed4f412b17e19e";
	level._effect[#"fx_zombie_bar_break"] = #"hash_718a24841c1e00c9";
	level._effect[#"fx_zombie_bar_break_lite"] = #"hash_35ee6425adf16fb6";
	if(!(isdefined(level.fx_exclude_edge_fog) && level.fx_exclude_edge_fog))
	{
		level._effect[#"edge_fog"] = #"_t6/maps/zombie/fx_fog_zombie_amb";
	}
	level._effect[#"chest_light"] = #"zombie/fx_weapon_box_open_glow_zmb";
	level._effect[#"chest_light_closed"] = #"zombie/fx_weapon_box_closed_glow_zmb";
	level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
	if(!(isdefined(level.fx_exclude_tesla_head_light) && level.fx_exclude_tesla_head_light))
	{
		level._effect[#"tesla_head_light"] = #"hash_757d002378ec934c";
	}
	level._effect[#"zombie_guts_explosion"] = #"zombie/fx_blood_torso_explo_lg_zmb";
	level._effect[#"rise_burst_water"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
	level._effect[#"rise_billow_water"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
	level._effect[#"rise_dust_water"] = #"zombie/fx_spawn_dirt_body_dustfalling_zmb";
	level._effect[#"rise_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
	level._effect[#"rise_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
	level._effect[#"rise_dust"] = #"zombie/fx_spawn_dirt_body_dustfalling_zmb";
	level._effect[#"fall_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
	level._effect[#"fall_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
	level._effect[#"fall_dust"] = #"zombie/fx_spawn_dirt_body_dustfalling_zmb";
	level._effect[#"character_fire_death_sm"] = #"hash_c9cf0acc938a7f6";
	level._effect[#"character_fire_death_torso"] = #"hash_5686def5b4c85661";
	if(!(isdefined(level.fx_exclude_default_explosion) && level.fx_exclude_default_explosion))
	{
		level._effect[#"def_explosion"] = #"_t6/explosions/fx_default_explosion";
	}
	if(!(isdefined(level.disable_fx_upgrade_aquired) && level.disable_fx_upgrade_aquired))
	{
		level._effect[#"upgrade_aquired"] = #"hash_359f0993cf4ebe66";
	}
}

/*
	Name: zombie_intro_screen
	Namespace: zm
	Checksum: 0x868A13C7
	Offset: 0x5998
	Size: 0x4C
	Parameters: 5
	Flags: Linked
*/
function zombie_intro_screen(string1, string2, string3, string4, string5)
{
	level flag::wait_till("start_zombie_round_logic");
}

/*
	Name: players_playing
	Namespace: zm
	Checksum: 0x6E5784FD
	Offset: 0x59F0
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function players_playing()
{
	players = getplayers();
	level.players_playing = players.size;
	wait(20);
	players = getplayers();
	level.players_playing = players.size;
}

/*
	Name: set_intermission_point
	Namespace: zm
	Checksum: 0x7B03DF5E
	Offset: 0x5A50
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function set_intermission_point()
{
	points = struct::get_array("intermission", "targetname");
	if(points.size < 1)
	{
		return;
	}
	points = array::randomize(points);
	point = points[0];
	setdemointermissionpoint(point.origin, point.angles);
}

/*
	Name: register_vehicle_damage_callback
	Namespace: zm
	Checksum: 0x8DC93694
	Offset: 0x5AF0
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function register_vehicle_damage_callback(func)
{
	if(!isdefined(level.vehicle_damage_callbacks))
	{
		level.vehicle_damage_callbacks = [];
	}
	level.vehicle_damage_callbacks[level.vehicle_damage_callbacks.size] = func;
}

/*
	Name: vehicle_damage_override
	Namespace: zm
	Checksum: 0x55CBF8E
	Offset: 0x5B40
	Size: 0x214
	Parameters: 15
	Flags: Linked
*/
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(isdefined(level.vehicle_damage_callbacks))
	{
		for(i = 0; i < level.vehicle_damage_callbacks.size; i++)
		{
			idamage = self [[level.vehicle_damage_callbacks[i]]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
		}
	}
	if(isdefined(self.var_1e7e5205) && self.var_1e7e5205)
	{
		idamage = idamage * 2;
	}
	self thread zm_score::function_89db94b3(eattacker, idamage);
	self globallogic_vehicle::callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
	if(isdefined(eattacker) && idamage > 0 && (!(isdefined(self.var_265cb589) && self.var_265cb589)) && (!(isdefined(level.var_dc60105c) && level.var_dc60105c)))
	{
		eattacker util::show_hit_marker(self.health <= 0);
	}
}

/*
	Name: function_7bdb1f9f
	Namespace: zm
	Checksum: 0xFF9F22FC
	Offset: 0x5D60
	Size: 0x16E
	Parameters: 5
	Flags: Linked, Private
*/
private function function_7bdb1f9f(attacker, damage, meansofdeath, weapon, shitloc)
{
	if(isdefined(level.headshots_only) && level.headshots_only || namespace_25f0796c::is_active() && isplayer(attacker))
	{
		if(meansofdeath == "MOD_MELEE" && (shitloc == "head" || shitloc == "helmet"))
		{
			return int(damage);
		}
		if(zm_utility::is_explosive_damage(meansofdeath))
		{
			return int(damage);
		}
		if(weapon.isheroweapon)
		{
			return int(damage);
		}
		if(isdefined(self.var_7105092c) && self.var_7105092c)
		{
			return int(damage);
		}
		if(!self zm_utility::is_headshot(weapon, shitloc, meansofdeath))
		{
			return 0;
		}
	}
	return damage;
}

/*
	Name: actor_damage_override
	Namespace: zm
	Checksum: 0xD618ECC5
	Offset: 0x5ED8
	Size: 0xBA2
	Parameters: 12
	Flags: Linked
*/
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!isdefined(self) || !isdefined(attacker))
	{
		return damage;
	}
	if(isai(attacker))
	{
		if(self.team == attacker.team && meansofdeath == "MOD_MELEE")
		{
			return 0;
		}
	}
	if(meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH")
	{
		self.var_e6675d2d = vpoint;
	}
	else
	{
		self.var_e6675d2d = undefined;
	}
	damage = self zm_pap_util::function_873e8824(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
	if(isdefined(level.bgb_in_use) && level.bgb_in_use)
	{
		damage = bgb::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
	}
	if(isdefined(weapon) && isdefined(weapon.name) && isdefined(level.var_aed5d327[weapon.name]))
	{
		damage = self [[level.var_aed5d327[weapon.name]]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
	}
	damage = zm_attachments::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
	damage = zm_perks::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
	damage = namespace_e38c57c1::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
	damage = self check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
	self.knuckles_extinguish_flames = weapon.name == #"tazer_knuckles";
	attacker thread zm_audio::sndplayerhitalert(self, meansofdeath, inflictor, weapon, shitloc, damage);
	if(!isplayer(attacker) && isdefined(self.non_attacker_func))
	{
		if(isdefined(self.non_attack_func_takes_attacker) && self.non_attack_func_takes_attacker)
		{
			return self [[self.non_attacker_func]](damage, weapon, attacker);
		}
		return self [[self.non_attacker_func]](damage, weapon);
	}
	if(!isbot(attacker))
	{
		level notify(#"hash_3fdaafe712252cf5");
	}
	if(isdefined(self.var_1e7e5205) && self.var_1e7e5205)
	{
		damage = damage * 2;
	}
	if(isdefined(level.var_4804edae) && level.var_4804edae && isbot(attacker))
	{
		damage = int(damage * zm_bot::function_e16b5033(self));
	}
	if(!isdefined(damage) || !isdefined(meansofdeath))
	{
		return damage;
	}
	if(meansofdeath == "")
	{
		return damage;
	}
	self.var_2e581a5 = undefined;
	if(self.var_6f84b820 === #"heavy" || self.var_6f84b820 === #"miniboss")
	{
		var_84ed9a13 = self namespace_e0710ee6::function_de3dda83(boneindex, shitloc, vpoint);
		if(isdefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1 && var_84ed9a13.type !== #"armor")
		{
			self.var_2e581a5 = 1;
		}
	}
	if(isdefined(self.aioverridedamage))
	{
		for(index = 0; index < self.aioverridedamage.size; index++)
		{
			damagecallback = self.aioverridedamage[index];
			damage = self [[damagecallback]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, undefined);
		}
		if(damage < 1)
		{
			return 0;
		}
		damage = int(damage + 0.5);
	}
	old_damage = damage;
	final_damage = damage;
	if(isdefined(self.actor_damage_func))
	{
		final_damage = [[self.actor_damage_func]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
	}
	/#
		if(getdvarint(#"scr_perkdebug", 0))
		{
			println((((("" + (final_damage / old_damage)) + "") + old_damage) + "") + final_damage);
		}
	#/
	if(isdefined(self.in_water) && self.in_water)
	{
		if(int(final_damage) >= self.health)
		{
			self.water_damage = 1;
		}
	}
	if(isdefined(inflictor) && isdefined(inflictor.archetype) && inflictor.archetype == #"glaive")
	{
		if(meansofdeath == "MOD_CRUSH")
		{
			if(isdefined(inflictor.enemy) && inflictor.enemy != self || (isdefined(inflictor._glaive_must_return_to_owner) && inflictor._glaive_must_return_to_owner))
			{
				if(isdefined(self.archetype) && self.archetype != #"margwa")
				{
					final_damage = final_damage + self.health;
					if(isactor(self))
					{
						self zombie_utility::gib_random_parts();
					}
				}
			}
			else
			{
				return 0;
			}
		}
	}
	if(isdefined(inflictor) && isplayer(attacker) && attacker == inflictor)
	{
		if(meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET")
		{
			if(!isdefined(attacker.hits))
			{
				attacker.hits = 0;
			}
			attacker.hits++;
		}
	}
	if(isplayer(attacker))
	{
		if(isalive(attacker) && (meansofdeath === "MOD_GRENADE" || meansofdeath === "MOD_GRENADE_SPLASH"))
		{
			attacker.grenade_multiattack_count++;
			attacker.grenade_multiattack_ent = self;
		}
		final_damage = self zm_powerups::function_fe6d6eac(attacker, meansofdeath, shitloc, weapon, final_damage);
		self.has_been_damaged_by_player = 1;
	}
	final_damage = self function_7bdb1f9f(attacker, final_damage, meansofdeath, weapon, shitloc);
	if(isdefined(attacker) && final_damage > 0 && (!(isdefined(self.var_265cb589) && self.var_265cb589)) && (!(isdefined(level.var_dc60105c) && level.var_dc60105c)))
	{
		var_6b5f7089 = 0;
		if(weapon.name === #"hash_6aadfdc58af04635" || weapon.name === #"hash_55330e258be3e3cc" && meansofdeath == "MOD_PROJECTILE_SPLASH")
		{
			var_6b5f7089 = 1;
		}
		if(isplayer(attacker) && attacker issplitscreen())
		{
			players = getplayers();
			if(players.size == 4)
			{
				var_6b5f7089 = 1;
			}
		}
		if(!var_6b5f7089)
		{
			attacker util::show_hit_marker(final_damage >= self.health);
		}
	}
	return int(final_damage);
}

/*
	Name: check_actor_damage_callbacks
	Namespace: zm
	Checksum: 0x6EF2BDAD
	Offset: 0x6A88
	Size: 0x10E
	Parameters: 12
	Flags: Linked
*/
function check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!isdefined(level.actor_damage_callbacks))
	{
		return damage;
	}
	for(i = 0; i < level.actor_damage_callbacks.size; i++)
	{
		newdamage = self [[level.actor_damage_callbacks[i]]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
		if(-1 !== newdamage)
		{
			return newdamage;
		}
	}
	return damage;
}

/*
	Name: function_84d343d
	Namespace: zm
	Checksum: 0xE712D38F
	Offset: 0x6BA0
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function function_84d343d(str_weapon, func)
{
	if(!isdefined(level.var_aed5d327))
	{
		level.var_aed5d327 = [];
	}
	level.var_aed5d327[str_weapon] = func;
}

/*
	Name: register_actor_damage_callback
	Namespace: zm
	Checksum: 0xB6899423
	Offset: 0x6BF8
	Size: 0x86
	Parameters: 2
	Flags: Linked
*/
function register_actor_damage_callback(func, var_61bac8c = 0)
{
	if(!isdefined(level.actor_damage_callbacks))
	{
		level.actor_damage_callbacks = [];
	}
	if(var_61bac8c)
	{
		array::push_front(level.actor_damage_callbacks, func);
	}
	else
	{
		level.actor_damage_callbacks[level.actor_damage_callbacks.size] = func;
	}
}

/*
	Name: function_79a42ab9
	Namespace: zm
	Checksum: 0x9A7D204
	Offset: 0x6C88
	Size: 0xAA
	Parameters: 0
	Flags: None
*/
function function_79a42ab9()
{
	if(!isdefined(level.var_d0851e53))
	{
		level.var_d0851e53 = 0;
	}
	if(!isdefined(level.var_7c1032cf))
	{
		level.var_7c1032cf = 0;
	}
	while(isdefined(self))
	{
		if(level.var_d0851e53 == gettime())
		{
			level.var_7c1032cf++;
			if(level.var_7c1032cf < 4)
			{
				return;
			}
		}
		else
		{
			level.var_d0851e53 = gettime();
			level.var_7c1032cf = 0;
			return;
		}
		waitframe(1);
	}
}

/*
	Name: actor_damage_override_wrapper
	Namespace: zm
	Checksum: 0x3E02AF1D
	Offset: 0x6D40
	Size: 0x4AC
	Parameters: 15
	Flags: Linked
*/
function actor_damage_override_wrapper(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal)
{
	if(!isdefined(self))
	{
		return damage;
	}
	if(level.var_9427911d <= 0 && level flag::get(#"infinite_round_spawning") && (!(isdefined(level.var_382a24b0) && level.var_382a24b0)))
	{
		self.var_12745932 = 1;
	}
	if(isdefined(attacker) && attacker zm_utility::function_45492cc4())
	{
		attacker = attacker.owner;
	}
	if(isdefined(self.var_ccefa6dd) && isdefined(attacker) && attacker.team === self.team)
	{
		return 0;
	}
	damage_override = self actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
	willbekilled = (self.health - damage_override) <= 0;
	if(isdefined(level.zombie_damage_override_callbacks))
	{
		foreach(func_override in level.zombie_damage_override_callbacks)
		{
			self thread [[func_override]](willbekilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
		}
	}
	bb::function_95e18a48(attacker, self, weapon, damage_override, meansofdeath, shitloc, willbekilled, willbekilled);
	if(!willbekilled || (!(isdefined(self.dont_die_on_me) && self.dont_die_on_me)))
	{
		self thread zm_score::function_89db94b3(attacker, damage_override, inflictor);
		params = spawnstruct();
		params.einflictor = inflictor;
		params.eattacker = attacker;
		params.idamage = damage_override;
		params.idflags = flags;
		params.smeansofdeath = meansofdeath;
		params.weapon = weapon;
		params.vpoint = vpoint;
		params.vdir = vdir;
		params.shitloc = shitloc;
		params.vdamageorigin = vdamageorigin;
		params.psoffsettime = psoffsettime;
		params.boneindex = boneindex;
		params.modelindex = modelindex;
		params.surfacetype = surfacetype;
		params.vsurfacenormal = vsurfacenormal;
		if(params.idamage > 0 || namespace_ae2d0839::is_active())
		{
			self callback::callback(#"on_ai_damage", params);
			self callback::callback(#"on_actor_damage", params);
		}
		self finishactordamage(inflictor, attacker, damage_override, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
	}
}

/*
	Name: register_zombie_damage_override_callback
	Namespace: zm
	Checksum: 0x12D5A244
	Offset: 0x71F8
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function register_zombie_damage_override_callback(func)
{
	if(!isdefined(level.zombie_damage_override_callbacks))
	{
		level.zombie_damage_override_callbacks = [];
	}
	if(!isdefined(level.zombie_damage_override_callbacks))
	{
		level.zombie_damage_override_callbacks = [];
	}
	else if(!isarray(level.zombie_damage_override_callbacks))
	{
		level.zombie_damage_override_callbacks = array(level.zombie_damage_override_callbacks);
	}
	level.zombie_damage_override_callbacks[level.zombie_damage_override_callbacks.size] = func;
}

/*
	Name: actor_killed_override
	Namespace: zm
	Checksum: 0x5E6B6412
	Offset: 0x72B0
	Size: 0x764
	Parameters: 8
	Flags: Linked
*/
function actor_killed_override(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	if(game.state == "postgame")
	{
		return;
	}
	if(self.var_c39323b5 !== 1)
	{
		level.var_9427911d--;
		if(level.var_9427911d <= 0 && level flag::get(#"infinite_round_spawning") && (!(isdefined(level.var_382a24b0) && level.var_382a24b0)))
		{
			self.var_12745932 = 1;
		}
	}
	player = undefined;
	eattacker = attacker;
	if(!isdefined(level.n_total_kills))
	{
		level.n_total_kills = 0;
	}
	if(isdefined(eattacker))
	{
		if(isplayer(eattacker))
		{
			player = eattacker;
		}
		else if(isdefined(eattacker.owner) && isplayer(eattacker) && eattacker.classname == "script_vehicle")
		{
			player = eattacker.owner;
		}
	}
	if(isdefined(player) && isplayer(player))
	{
		killcam_entity_info = killcam::get_killcam_entity_info(player, einflictor, weapon);
		deathtime = gettime();
		deathtimeoffset = 0;
		perks = [];
		killstreaks = [];
		rounds = level.round_number;
		var_65e76577 = #"";
		if(isdefined(self.archetype) && (self.archetype == #"tiger" || self.archetype == #"brutus" || self.archetype == #"zombie_dog" || self.archetype == #"catalyst" || self.archetype == #"stoker" || self.archetype == #"blight_father"))
		{
			var_65e76577 = #"hash_1553fcea4f6a00e";
		}
		else
		{
			var_65e76577 = #"hash_37300d83d8e6f1fc";
		}
		if(var_65e76577 == #"hash_1553fcea4f6a00e")
		{
			demo::bookmark(var_65e76577, gettime(), player);
		}
		potm::bookmark(var_65e76577, gettime(), player);
		level thread potm::function_5523a49a(var_65e76577, player getentitynumber(), player getxuid(), self, killcam_entity_info, weapon, smeansofdeath, deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, player);
	}
	if(isai(attacker) && isdefined(attacker.script_owner))
	{
		if(attacker.script_owner.team != self.team)
		{
			attacker = attacker.script_owner;
		}
	}
	if(isdefined(attacker) && attacker zm_utility::function_45492cc4(0))
	{
		attacker = attacker.owner;
	}
	if(isdefined(attacker) && isplayer(attacker))
	{
		level.n_total_kills++;
		type = undefined;
		if(isdefined(self.animname))
		{
			switch(self.animname)
			{
				case "quad_zombie":
				{
					type = "quadkill";
					break;
				}
				case "ape_zombie":
				{
					type = "apekill";
					break;
				}
				case "zombie":
				{
					type = "zombiekill";
					break;
				}
				case "zombie_dog":
				{
					type = "dogkill";
					break;
				}
			}
		}
	}
	if(isdefined(self.is_ziplining) && self.is_ziplining)
	{
		self.deathanim = undefined;
	}
	params = spawnstruct();
	params.einflictor = einflictor;
	params.eattacker = attacker;
	params.idamage = idamage;
	params.smeansofdeath = smeansofdeath;
	params.weapon = weapon;
	params.vdir = vdir;
	params.shitloc = shitloc;
	params.psoffsettime = psoffsettime;
	self callback::callback(#"on_ai_killed", params);
	self callback::callback(#"on_actor_killed", params);
	self zm_stats::handle_death(einflictor, attacker, weapon, smeansofdeath);
	if(isdefined(self.actor_killed_override))
	{
		self [[self.actor_killed_override]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
	}
	if(isdefined(self.deathfunction))
	{
		self [[self.deathfunction]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
	}
	var_82700ea5 = namespace_59ff1d6c::function_901b751c(#"zmkillcap");
	if(var_82700ea5 > 0 && level.n_total_kills >= var_82700ea5)
	{
		namespace_59ff1d6c::function_9be9c072("zmKillCap");
	}
}

/*
	Name: round_end_monitor
	Namespace: zm
	Checksum: 0x5BAC952F
	Offset: 0x7A20
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function round_end_monitor()
{
	while(true)
	{
		level waittill(#"end_of_round");
		demo::bookmark(#"zm_round_end", gettime(), undefined, undefined, 1);
		bbpostdemostreamstatsforround(level.round_number);
		waitframe(1);
	}
}

/*
	Name: function_51133aa1
	Namespace: zm
	Checksum: 0x7E021BDF
	Offset: 0x7A98
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_51133aa1()
{
	level endon(#"resume_end_game");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"menuresponse");
		response = waitresult.response;
		if(response == "restart_level_zm")
		{
			level thread zm_gametype::function_22d79e6e();
			wait(666);
		}
		else if(response == "resume_end_game")
		{
			level notify(#"resume_end_game");
		}
	}
}

/*
	Name: function_d723e40
	Namespace: zm
	Checksum: 0x3271630F
	Offset: 0x7B60
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function function_d723e40()
{
	level endon(#"resume_end_game");
	wait(1);
	luinotifyevent(#"hash_1fc4832b89307895", 0);
	wait(zombie_utility::function_d2dfacfd(#"hash_6bae95928bbe8f1"));
	level notify(#"resume_end_game");
}

/*
	Name: function_758406d8
	Namespace: zm
	Checksum: 0x89B5EEE
	Offset: 0x7BE0
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_758406d8()
{
	players = getplayers();
	foreach(player in players)
	{
		player thread function_51133aa1();
	}
	level thread function_d723e40();
	level waittill(#"resume_end_game");
	luinotifyevent(#"hash_3aa743d9ad6c8e19", 0);
}

/*
	Name: function_70171add
	Namespace: zm
	Checksum: 0x87BCE6B5
	Offset: 0x7CC8
	Size: 0x7E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_70171add()
{
	if(randomfloat(1) <= getdvarfloat(#"survey_chance", 0))
	{
		return randomintrange(1, getdvarint(#"survey_count", 0) + 1);
	}
	return 0;
}

/*
	Name: function_6c369691
	Namespace: zm
	Checksum: 0xA7E9BD83
	Offset: 0x7D50
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_6c369691()
{
	a_ai = getaiteamarray("axis");
	foreach(n_index, ai in a_ai)
	{
		if(isalive(ai))
		{
			ai val::set(#"end_game", "ignoreall", 1);
			ai thread zm_cleanup::no_target_override(ai);
			if(n_index % 2)
			{
				wait(0.05);
			}
		}
	}
}

/*
	Name: end_game
	Namespace: zm
	Checksum: 0xC148BF5B
	Offset: 0x7E50
	Size: 0xF92
	Parameters: 0
	Flags: Linked
*/
function end_game()
{
	level waittill(#"end_game");
	changeadvertisedstatus(0);
	check_end_game_intermission_delay();
	/#
		println("");
	#/
	setmatchflag("game_ended", 1);
	game.state = "postgame";
	if(!isdefined(level.var_21e22beb))
	{
		level.var_21e22beb = gettime();
	}
	var_7da9f0c = (isdefined(level.var_bccd8271) ? level.var_bccd8271 : gettime() - level.var_21e22beb);
	if(!isdefined(level.n_gameplay_start_time))
	{
		level.n_gameplay_start_time = gettime();
	}
	level clientfield::set("gameplay_started", 0);
	level clientfield::set("game_end_time", int(((gettime() - level.n_gameplay_start_time) + 500) / 1000));
	level clientfield::set("zesn", 1);
	if(isdefined(level.var_ea32773))
	{
		level [[level.var_ea32773]]();
	}
	if(zm_utility::is_tutorial())
	{
		music::setmusicstate("zodt8_death");
	}
	else
	{
		level thread zm_audio::sndmusicsystem_playstate("game_over");
	}
	players = getplayers();
	foreach(player in players)
	{
		player val::set(#"end_game", "ignoreme", 1);
		player enableinvulnerability();
		if(!isdefined(player.score_total))
		{
			player.score_total = 0;
		}
		player.score = player.score_total;
		player notify(#"stop_ammo_tracking");
		player clientfield::set("zmbLastStand", 0);
	}
	level thread function_6c369691();
	surveyid = function_70171add();
	for(i = 0; i < players.size; i++)
	{
		if(sessionmodeisonlinegame())
		{
			players[i] stats::function_7a850245(#"demofileid", getdemofileid());
			players[i] stats::function_7a850245(#"matchid", function_c7c50474());
			if(level.rankedmatch)
			{
				players[i] stats::function_7a850245(#"surveyid", surveyid);
			}
		}
		if(players[i] laststand::player_is_in_laststand())
		{
			players[i] recordplayerdeathzombies();
			players[i] zm_stats::increment_player_stat("deaths");
			players[i] zm_stats::increment_client_stat("deaths");
			players[i] zm_stats::function_8f10788e("boas_deaths");
		}
	}
	stopallrumbles();
	level.intermission = 1;
	zombie_utility::set_zombie_var(#"zombie_powerup_insta_kill_time", 0);
	zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", 0);
	zombie_utility::set_zombie_var(#"zombie_powerup_double_points_time", 0);
	wait(0.1);
	game_over = [];
	survived = [];
	players = getplayers();
	setmatchflag("disableIngameMenu", 1);
	foreach(player in players)
	{
		player closeingamemenu();
		player closemenu("StartMenu_Main");
	}
	foreach(player in players)
	{
		player zm_stats::function_9daadcaa(#"lobbypopup", #"summary");
		player zm_stats::function_9daadcaa(#"difficulty", level.gamedifficulty);
		if(level.var_ff482f76 zm_laststand_client::is_open(player))
		{
			level.var_ff482f76 zm_laststand_client::close(player);
		}
	}
	if(!isdefined(level._supress_survived_screen))
	{
		var_5c965b78 = 0;
		if(isdefined(level.var_458eec65) && level.var_458eec65)
		{
			var_5c965b78 = 1;
		}
		for(i = 0; i < players.size; i++)
		{
			level.var_7c7c6c35 zm_game_over::open(players[i]);
			level.var_7c7c6c35 zm_game_over::set_rounds(players[i], (level.round_number - namespace_59ff1d6c::function_901b751c(#"startround")) + var_5c965b78);
		}
	}
	else if("ztrials" == util::function_5df4294())
	{
		namespace_b22c99a5::function_2ee2d021();
	}
	util::preload_frontend();
	players = getplayers();
	if(isdefined(level.custom_end_screen))
	{
		level [[level.custom_end_screen]]();
	}
	for(i = 0; i < players.size; i++)
	{
		players[i] setclientuivisibilityflag("weapon_hud_visible", 0);
		players[i] setclientminiscoreboardhide(1);
		players[i] notify(#"report_bgb_consumption");
	}
	zm_stats::update_players_stats_at_match_end(players);
	zm_stats::update_global_counters_on_match_end();
	zm_stats::function_42677837("gameLength", var_7da9f0c);
	foreach(player in getplayers())
	{
		player zm_stats::function_9daadcaa("gameLength", var_7da9f0c);
		player zm_stats::function_ae547e45("boas_gameLength", var_7da9f0c);
		player zm_stats::function_ae547e45("boas_numZombieRounds", level.round_number);
		player zm_stats::function_ae547e45("boas_score", player.score);
		if(isdefined(level.var_211e3a53))
		{
			player zm_stats::function_ae547e45("boas_gameType", level.var_211e3a53);
			continue;
		}
		player zm_stats::function_ae547e45("boas_gameType", util::function_5df4294());
	}
	zm_stats::function_ea5b4947(1);
	bb::function_22b9bc7("end_game");
	upload_leaderboards();
	recordgameresult(#"draw");
	globallogic::function_6c8d7c31(#"draw");
	globallogic_player::recordactiveplayersendgamematchrecordstats();
	recordnumzombierounds(level.round_number);
	finalizematchrecord();
	players = getplayers();
	foreach(player in players)
	{
		if(isdefined(player.sessionstate) && player.sessionstate == "spectator")
		{
			player thread end_game_player_was_spectator();
		}
	}
	waitframe(1);
	/#
		if(!(isdefined(level.host_ended_game) && level.host_ended_game) && getdvarint(#"hash_2a088de8afba1c99", 0) > 1)
		{
			luinotifyevent(#"force_scoreboard", 0);
			map_restart(1);
			wait(666);
		}
	#/
	luinotifyevent(#"force_scoreboard", 1, 1);
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] val::set(#"end_of_game", "freezecontrols");
	}
	intermission();
	if(getdvar(#"hash_4413f876155a89bd", 0))
	{
		function_758406d8();
	}
	if(zm_trial::function_b47f6aba())
	{
		level thread namespace_b22c99a5::function_f79b96ac();
	}
	if(potm::function_afe21831() == 0)
	{
		wait(zombie_utility::function_d2dfacfd(#"zombie_intermission_time"));
	}
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(level.var_7c7c6c35 zm_game_over::is_open(players[i]))
		{
			level.var_7c7c6c35 zm_game_over::close(players[i]);
		}
	}
	level notify(#"stop_intermission");
	array::thread_all(getplayers(), &zm_player::player_exit_level);
	wait(1.5);
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] cameraactivate(0);
	}
	/#
		if(!(isdefined(level.host_ended_game) && level.host_ended_game) && getdvarint(#"hash_2a088de8afba1c99", 0))
		{
			luinotifyevent(#"force_scoreboard", 1, 0);
			map_restart(1);
			wait(666);
		}
	#/
	exitlevel(0);
	wait(666);
}

/*
	Name: end_game_player_was_spectator
	Namespace: zm
	Checksum: 0x1861D98C
	Offset: 0x8DF0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function end_game_player_was_spectator()
{
	waitframe(1);
	self ghost();
	self val::set(#"end_game_player_was_spectator", "freezecontrols", 1);
}

/*
	Name: disable_end_game_intermission
	Namespace: zm
	Checksum: 0xEF467D40
	Offset: 0x8E48
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function disable_end_game_intermission(delay)
{
	level.disable_intermission = 1;
	wait(delay);
	level.disable_intermission = undefined;
}

/*
	Name: check_end_game_intermission_delay
	Namespace: zm
	Checksum: 0xB0FF2631
	Offset: 0x8E80
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function check_end_game_intermission_delay()
{
	if(isdefined(level.disable_intermission))
	{
		while(true)
		{
			if(!isdefined(level.disable_intermission))
			{
				break;
			}
			wait(0.01);
		}
	}
}

/*
	Name: upload_leaderboards
	Namespace: zm
	Checksum: 0x36E9AFA5
	Offset: 0x8EC8
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function upload_leaderboards()
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] uploadleaderboards();
	}
}

/*
	Name: initializestattracking
	Namespace: zm
	Checksum: 0xB0F8F2CA
	Offset: 0x8F30
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function initializestattracking()
{
	level.global_zombies_killed = 0;
	level.zombies_timeout_spawn = 0;
	level.zombies_timeout_playspace = 0;
	level.zombies_timeout_undamaged = 0;
	level.zombie_player_killed_count = 0;
	level.zombie_trap_killed_count = 0;
	level.zombie_pathing_failed = 0;
	level.zombie_breadcrumb_failed = 0;
}

/*
	Name: to_mins
	Namespace: zm
	Checksum: 0xA1876151
	Offset: 0x8FA0
	Size: 0x18E
	Parameters: 1
	Flags: None
*/
function to_mins(seconds)
{
	hours = 0;
	minutes = 0;
	if(seconds > 59)
	{
		minutes = int(seconds / 60);
		seconds = (int(seconds * 1000)) % 60000;
		seconds = seconds * 0.001;
		if(minutes > 59)
		{
			hours = int(minutes / 60);
			minutes = (int(minutes * 1000)) % 60000;
			minutes = minutes * 0.001;
		}
	}
	if(hours < 10)
	{
		hours = "0" + hours;
	}
	if(minutes < 10)
	{
		minutes = "0" + minutes;
	}
	seconds = int(seconds);
	if(seconds < 10)
	{
		seconds = "0" + seconds;
	}
	combined = (((("" + hours) + ":") + minutes) + ":") + seconds;
	return combined;
}

/*
	Name: function_dccccaf2
	Namespace: zm
	Checksum: 0xF76907AF
	Offset: 0x9138
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_dccccaf2()
{
	self closeingamemenu();
	self closemenu("StartMenu_Main");
	self notify(#"player_intermission");
	self endon(#"player_intermission");
	level endon(#"stop_intermission");
	self endon(#"disconnect", #"death");
	self notify(#"_zombie_game_over");
	self.score = self.score_total;
	wait(0.51);
	self lui::screen_fade_out(1);
	level waittill(#"play_potm");
	self lui::screen_fade_in(0.1);
	level waittill(#"potm_finished");
	self lui::screen_fade_out(2);
}

/*
	Name: intermission
	Namespace: zm
	Checksum: 0x642A4C9C
	Offset: 0x9290
	Size: 0x234
	Parameters: 0
	Flags: Linked
*/
function intermission()
{
	potm_enabled = 0;
	if(potm::function_afe21831() > 0)
	{
		potm_enabled = 1;
	}
	level.intermission = 1;
	level notify(#"intermission");
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] setclientthirdperson(0);
		players[i] resetfov();
		players[i].health = players[i].maxhealth;
		if(potm_enabled)
		{
			players[i] thread function_dccccaf2();
		}
		else
		{
			players[i] thread [[level.custom_intermission]]();
		}
		players[i] stopsounds();
	}
	if(potm_enabled)
	{
		wait(5);
		level thread potm::play_potm(2);
		waitframe(1);
		level notify(#"play_potm");
		level waittill(#"potm_finished");
		wait(2.25);
	}
	else
	{
		wait(5.25);
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			players[i] clientfield::set("zmbLastStand", 0);
		}
		level thread zombie_game_over_death();
	}
}

/*
	Name: zombie_game_over_death
	Namespace: zm
	Checksum: 0xAAFF8BDB
	Offset: 0x94D0
	Size: 0x1C6
	Parameters: 0
	Flags: Linked
*/
function zombie_game_over_death()
{
	zombies = getaiteamarray(level.zombie_team);
	for(i = 0; i < zombies.size; i++)
	{
		if(!isalive(zombies[i]))
		{
			continue;
		}
		zombies[i] setgoal(zombies[i].origin);
	}
	for(i = 0; i < zombies.size; i++)
	{
		if(!isalive(zombies[i]))
		{
			continue;
		}
		if(isdefined(zombies[i].ignore_game_over_death) && zombies[i].ignore_game_over_death)
		{
			continue;
		}
		wait(0.5 + randomfloat(2));
		if(isdefined(zombies[i]))
		{
			if(!isvehicle(zombies[i]))
			{
				zombies[i] zombie_utility::zombie_head_gib();
			}
			zombies[i].allowdeath = 1;
			zombies[i] kill(zombies[i].origin, undefined, undefined, undefined, 0, 1);
		}
	}
}

/*
	Name: fade_up_over_time
	Namespace: zm
	Checksum: 0x7147F6CB
	Offset: 0x96A0
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function fade_up_over_time(t)
{
	/#
		self fadeovertime(t);
		self.alpha = 1;
	#/
}

/*
	Name: default_exit_level
	Namespace: zm
	Checksum: 0x90C1B81
	Offset: 0x96E0
	Size: 0x10E
	Parameters: 0
	Flags: None
*/
function default_exit_level()
{
	zombies = getaiteamarray(level.zombie_team);
	for(i = 0; i < zombies.size; i++)
	{
		if(isdefined(zombies[i].ignore_solo_last_stand) && zombies[i].ignore_solo_last_stand)
		{
			continue;
		}
		if(isdefined(zombies[i].find_exit_point))
		{
			zombies[i] thread [[zombies[i].find_exit_point]]();
			continue;
		}
		if(zombies[i].ignoreme)
		{
			zombies[i] thread default_delayed_exit();
			continue;
		}
		zombies[i] thread default_find_exit_point();
	}
}

/*
	Name: default_delayed_exit
	Namespace: zm
	Checksum: 0x4CDC387B
	Offset: 0x97F8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function default_delayed_exit()
{
	self endon(#"death");
	while(true)
	{
		if(!level flag::get("wait_and_revive"))
		{
			return;
		}
		if(!self.ignoreme)
		{
			break;
		}
		wait(0.1);
	}
	self thread default_find_exit_point();
}

/*
	Name: default_find_exit_point
	Namespace: zm
	Checksum: 0x3F6FAF91
	Offset: 0x9878
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function default_find_exit_point()
{
	self endon(#"death");
	player = util::gethostplayer();
	if(!isdefined(player))
	{
		return;
	}
	dist_zombie = 0;
	dist_player = 0;
	dest = 0;
	away = vectornormalize(self.origin - player.origin);
	endpos = self.origin + vectorscale(away, 600);
	locs = [];
	if(isdefined(level.zm_loc_types[#"wait_location"]) && level.zm_loc_types[#"wait_location"].size > 0)
	{
		locs = array::randomize(level.zm_loc_types[#"wait_location"]);
	}
	for(i = 0; i < locs.size; i++)
	{
		dist_zombie = distancesquared(locs[i].origin, endpos);
		dist_player = distancesquared(locs[i].origin, player.origin);
		if(dist_zombie < dist_player)
		{
			dest = i;
			break;
		}
	}
	self notify(#"stop_find_flesh");
	self notify(#"zombie_acquire_enemy");
	if(isdefined(locs[dest]))
	{
		self setgoal(locs[dest].origin);
	}
}

/*
	Name: register_sidequest
	Namespace: zm
	Checksum: 0x105A1C27
	Offset: 0x9AB0
	Size: 0x142
	Parameters: 2
	Flags: None
*/
function register_sidequest(id, sidequest_stat)
{
	if(!isdefined(level.zombie_sidequest_stat))
	{
		level.zombie_sidequest_previously_completed = [];
		level.zombie_sidequest_stat = [];
	}
	level.zombie_sidequest_stat[id] = sidequest_stat;
	level flag::wait_till("start_zombie_round_logic");
	level.zombie_sidequest_previously_completed[id] = 0;
	if(!level.onlinegame)
	{
		return;
	}
	if(isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats)
	{
		return;
	}
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(players[i] zm_stats::get_global_stat(level.zombie_sidequest_stat[id]))
		{
			level.zombie_sidequest_previously_completed[id] = 1;
			return;
		}
	}
}

/*
	Name: is_sidequest_previously_completed
	Namespace: zm
	Checksum: 0x88A50B20
	Offset: 0x9C00
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function is_sidequest_previously_completed(id)
{
	return isdefined(level.zombie_sidequest_previously_completed[id]) && level.zombie_sidequest_previously_completed[id];
}

/*
	Name: set_sidequest_completed
	Namespace: zm
	Checksum: 0x24F66BD3
	Offset: 0x9C40
	Size: 0xEE
	Parameters: 1
	Flags: None
*/
function set_sidequest_completed(id)
{
	level notify(#"zombie_sidequest_completed", id);
	level.zombie_sidequest_previously_completed[id] = 1;
	if(!level.onlinegame)
	{
		return;
	}
	if(isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats)
	{
		return;
	}
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(level.zombie_sidequest_stat[id]))
		{
			players[i] zm_stats::add_global_stat(level.zombie_sidequest_stat[id], 1);
		}
	}
}

/*
	Name: precache_zombie_leaderboards
	Namespace: zm
	Checksum: 0xB13AA673
	Offset: 0x9D38
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function precache_zombie_leaderboards()
{
	if(sessionmodeissystemlink())
	{
		return;
	}
	globalleaderboards = "LB_ZM_GB_BULLETS_FIRED_AT ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_BULLETS_HIT_AT ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_DISTANCE_TRAVELED_AT ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_DOORS_PURCHASED_AT ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_GRENADE_KILLS_AT ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_HEADSHOTS_AT ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_KILLS_AT ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_PERKS_DRANK_AT ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_REVIVES_AT ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_KILLSTATS_MR ";
	globalleaderboards = globalleaderboards + "LB_ZM_GB_GAMESTATS_MR ";
	if(!level.rankedmatch && getdvarint(#"zm_private_rankedmatch", 0) == 0)
	{
		precacheleaderboards(globalleaderboards);
		return;
	}
	mapname = util::function_53bbf9d2();
	expectedplayernum = getnumexpectedplayers();
	mapleaderboard = ((("LB_ZM_MAP_" + getsubstr(mapname, 3, mapname.size)) + "_") + expectedplayernum) + "PLAYER";
	precacheleaderboards(globalleaderboards + mapleaderboard);
}

/*
	Name: increment_dog_round_stat
	Namespace: zm
	Checksum: 0x4ED6190B
	Offset: 0x9F08
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function increment_dog_round_stat(stat)
{
	players = getplayers();
	foreach(player in players)
	{
		player zm_stats::increment_client_stat("zdog_rounds_" + stat);
	}
}

/*
	Name: player_too_many_players_check
	Namespace: zm
	Checksum: 0x35B4786E
	Offset: 0x9FB8
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function player_too_many_players_check()
{
	max_players = 4;
	if(level.scr_zm_ui_gametype == "zgrief" || level.scr_zm_ui_gametype == "zmeat")
	{
		max_players = 8;
	}
	if(getplayers().size > max_players)
	{
		foreach(player in getplayers())
		{
			player val::set(#"hash_1a88595aedca8cc4", "freezecontrols");
		}
		level notify(#"end_game");
	}
}

/*
	Name: is_idgun_damage
	Namespace: zm
	Checksum: 0xF00C93BD
	Offset: 0xA0D8
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function is_idgun_damage(weapon)
{
	if(isdefined(level.idgun_weapons))
	{
		if(isinarray(level.idgun_weapons, weapon))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_a2b54d42
	Namespace: zm
	Checksum: 0x4715E2EC
	Offset: 0xA128
	Size: 0x1A6
	Parameters: 0
	Flags: Linked
*/
function function_a2b54d42()
{
	n_multiplier = zombie_utility::function_d2dfacfd(#"hash_1ab42b4d7db4cb3c");
	if(zm_utility::is_standard())
	{
		switch(level.players.size)
		{
			case 1:
			{
				n_multiplier = n_multiplier * 0.55;
				break;
			}
			case 2:
			{
				n_multiplier = n_multiplier * 0.75;
				break;
			}
			case 3:
			{
				n_multiplier = n_multiplier * 0.9;
				break;
			}
			case 4:
			{
				n_multiplier = n_multiplier * 1.1;
				break;
			}
		}
	}
	else
	{
		switch(level.players.size)
		{
			case 1:
			{
				n_multiplier = n_multiplier * 0.63;
				break;
			}
			case 2:
			{
				n_multiplier = n_multiplier * 0.75;
				break;
			}
			case 3:
			{
				n_multiplier = n_multiplier * 0.8;
				break;
			}
			case 4:
			{
				n_multiplier = n_multiplier * 0.95;
				break;
			}
		}
	}
	return n_multiplier;
}

/*
	Name: printhashids
	Namespace: zm
	Checksum: 0x6EC0BAC5
	Offset: 0xA2D8
	Size: 0x2CC
	Parameters: 0
	Flags: None
*/
function printhashids()
{
	/#
		outputstring = "";
		outputstring = outputstring + "";
		foreach(powerup in level.zombie_powerups)
		{
			outputstring = outputstring + (((powerup.powerup_name + "") + powerup.var_33c87f51) + "");
		}
		outputstring = outputstring + "";
		if(isdefined(level.aat_in_use) && level.aat_in_use)
		{
			foreach(aat in level.aat)
			{
				if(!isdefined(aat) || !isdefined(aat.name) || aat.name == "")
				{
					continue;
				}
				outputstring = outputstring + (((aat.name + "") + aat.var_33c87f51) + "");
			}
		}
		outputstring = outputstring + "";
		foreach(perk in level._custom_perks)
		{
			if(!isdefined(perk) || !isdefined(perk.alias))
			{
				continue;
			}
			outputstring = outputstring + (((function_9e72a96(perk.alias) + "") + perk.alias) + "");
		}
		outputstring = outputstring + "";
		println(outputstring);
	#/
}

