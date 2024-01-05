// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\weapons\zm_weap_hand_ouranos.gsc;
#using scripts\zm\weapons\zm_weap_hand_hemera.gsc;
#using scripts\zm\weapons\zm_weap_hand_gaia.gsc;
#using scripts\zm\weapons\zm_weap_hand_charon.gsc;
#using script_14af1fd264ffe8cc;
#using scripts\zm\zm_red_challenges.gsc;
#using scripts\zm\zm_red_fasttravel.gsc;
#using scripts\zm\zm_red.gsc;
#using script_48288470fe0b53d;
#using scripts\zm_common\bgbs\zm_bgb_shields_up.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using script_3aa54d3cb36ea43f;
#using scripts\zm\ai\zm_ai_blight_father.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_transformation.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_round_spawning.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_fasttravel.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_characters.gsc;
#using scripts\zm_common\zm_bgb_pack.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_aoe.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace red_boss_battle;

/*
	Name: init
	Namespace: red_boss_battle
	Checksum: 0xAF3BCD06
	Offset: 0x8A8
	Size: 0xDEC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("missile", "" + #"hash_64910f94ebb8d66a", 16000, 2, "int");
	clientfield::register("scriptmover", "" + #"pegasus_emerge", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"pegasus_storm", 16000, 1, "int");
	clientfield::register("allplayers", "" + #"hash_73e309ffb25bf63d", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_3bb8b5cda11eecc6", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"lightning_impact_fx", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"lightning_arc_fx", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_2bb63677db4333d4", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_2b842a4f17120dfb", 16000, 1, "counter");
	scene::add_scene_func(#"hash_be0d30822a1c21b", &function_e46ef00b, "skip_started");
	level flag::init(#"hash_79d95c7c3d63882d");
	level flag::init(#"hash_315fae99adaebfb4");
	level flag::init(#"hash_7be183aa6a4cbe7");
	level flag::init(#"hash_6dab61ca45a8eaea");
	level flag::init(#"pegasus_attacking");
	level flag::init(#"perseus_attacking");
	level flag::init(#"hash_59553ef93adcfe51");
	level flag::init(#"hash_44d76e9e7b9e0ebd");
	level flag::init(#"hash_15ba89b2357ff618");
	level flag::init(#"hash_75d9474065de2230");
	level flag::init(#"hash_75d94a4065de2749");
	level flag::init(#"hash_3e2ec7f6fb6b50c9");
	level flag::init(#"hash_3e2ec4f6fb6b4bb0");
	level flag::init(#"hash_1c0b421abe38d4e0");
	level flag::init(#"boss_battle_complete");
	zm_sq::register(#"boss_battle", #"stat_tracker", #"stat_tracker", &stat_tracker_setup, &stat_tracker_cleanup, 1);
	zm_sq::start(#"boss_battle");
	level._effect[#"storm_radius"] = #"hash_4dd46a244305d465";
	level._effect[#"annihilator_bolt"] = #"hash_9a8432f2e39c8af";
	level._effect[#"hash_4311fc5f4111c023"] = #"hash_6b0875f1b8c6cf55";
	level._effect[#"hash_4311fd5f4111c1d6"] = #"hash_6b0872f1b8c6ca3c";
	level._effect[#"hash_4311fe5f4111c389"] = #"hash_6b0873f1b8c6cbef";
	level._effect[#"hash_4d8d2bc22add9939"] = #"hash_7a8056b9d995fa0";
	level._effect[#"hash_661c427afb24e5f2"] = #"hash_32b6f16bb5eaa401";
	level._effect[#"hash_65a9f0574c7cd2db"] = #"hash_70f9f9890480fd54";
	level._effect[#"hash_3d64776928022f66"] = #"hash_57449588f6051a0d";
	level._effect[#"perseus_death"] = #"hash_6c3beeb5851adca4";
	level.s_boss_battle = spawnstruct();
	level.s_boss_battle.var_35345d3d = getent("vol_boss_arena_1", "targetname");
	level.s_boss_battle.var_285e59dd = getent("vol_boss_arena_2", "targetname");
	level.s_boss_battle.var_76f4f0e9 = getent("vol_boss_arena_3", "targetname");
	level.s_boss_battle.var_2624492f = [];
	level.s_boss_battle.var_2624492f[2] = "fountain_miniboss_ent";
	level.s_boss_battle.var_2624492f[3] = "column_miniboss_ent";
	level.s_boss_battle.var_2624492f[1] = "park_miniboss_ent";
	level.s_boss_battle.s_pinnacle = struct::get("s_pinnacle_center");
	level.s_boss_battle.var_98ea549b = getent("no_aoe", "targetname");
	level.s_boss_battle.var_5203fa2b = struct::get_array("boss_attack_point");
	level.s_boss_battle.registersarah_defeated_gore_ = struct::get_array("boss_2_player_respawn");
	level.s_boss_battle.var_415fc88 = 33;
	level.s_boss_battle.n_stage = 0;
	level.s_boss_battle.var_dc656db3 = 0;
	level.s_boss_battle.var_3edd432d = getent("chaos_bolt_thrower", "targetname");
	level.s_boss_battle.var_3edd432d hide();
	level.s_boss_battle.var_c67e8352 = getent("chaos_bolt_thrower_shield", "targetname");
	level.s_boss_battle.var_c67e8352 hide();
	level.s_boss_battle.var_5e9e4c15 = getent("chaos_bolt_thrower_sword", "targetname");
	level.s_boss_battle.var_5e9e4c15 hide();
	level.s_boss_battle.var_3edd432d val::set("zm_red_boss_fight", "takedamage", 1);
	level.s_boss_battle.var_3edd432d val::set("zm_red_boss_fight", "allowdeath", 1);
	level.s_boss_battle.var_3edd432d.health = 99999;
	level.s_boss_battle.var_3edd432d.b_override_explosive_damage_cap = 1;
	level.s_boss_battle.var_d82d0e73 = array(level.s_boss_battle.var_3edd432d, level.s_boss_battle.var_c67e8352, level.s_boss_battle.var_5e9e4c15);
	level.s_boss_battle.var_b7fe5d46 = 20000;
	level.s_boss_battle.var_36f0e240 = 0;
	level.s_boss_battle.var_4652a428 = 6;
	level.s_boss_battle.var_ad3f929f = 0;
	level.s_boss_battle.var_1e4f5dab = 15000;
	level.s_boss_battle.var_3edd432d.var_c164e6c7 = 3;
	level.s_boss_battle.var_5dc26e42 = 0;
	level.s_boss_battle.var_7fc7f236 = 15000;
	level.s_boss_battle.var_5db6ed5f = getweapon("perseus_bolt_projectile");
	level.s_boss_battle.var_86d9f46c = getstatuseffect(#"hash_19533caf858a9f3b");
	level.s_boss_battle.var_b42f3b39 = getstatuseffect(#"hash_12a64221f4d27f9b");
	/#
		if(zm_utility::is_ee_enabled())
		{
			setdvar(#"hash_336a4b6a4bdec400", 0);
			setdvar(#"hash_2c5a53140f377a17", 0);
			setdvar(#"hash_16d0c8f49c9e0090", 0);
			setdvar(#"hash_3031043ff4ac0395", 0);
			setdvar(#"hash_68b9a321eca18c32", 0);
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			level.s_boss_battle.var_5de58d03 = 0;
			zm_devgui::add_custom_devgui_callback(&function_27486895);
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			level thread function_d5a70078();
		}
	#/
}

/*
	Name: function_e46ef00b
	Namespace: red_boss_battle
	Checksum: 0x43295C86
	Offset: 0x16A0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_e46ef00b(a_ents)
{
	exploder::stop_exploder("fxexp_boss_intro_sh01");
}

/*
	Name: function_a4bcce4e
	Namespace: red_boss_battle
	Checksum: 0x2D5DADD5
	Offset: 0x16D0
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_a4bcce4e()
{
	for(i = 0; i < 4; i++)
	{
		str_bgb = self.bgb_pack[i];
		if(str_bgb === #"zm_bgb_immolation_liquidation")
		{
			self bgb_pack::function_b2308cd(i, 3);
		}
	}
}

/*
	Name: function_3a2efd4e
	Namespace: red_boss_battle
	Checksum: 0x767E498D
	Offset: 0x1750
	Size: 0x864
	Parameters: 3
	Flags: Linked
*/
function function_3a2efd4e(b_cheated = 0, var_7982b1c8 = 1, var_8ef91a04 = 1)
{
	level endon(#"end_game", #"hash_7646638df88a3656");
	level flag::wait_till("zones_initialized");
	level._zombiemode_check_firesale_loc_valid_func = &return_false;
	array::thread_all(getplayers(), &function_a4bcce4e);
	zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 0);
	level notify(#"fire_sale_off");
	callback::on_spawned(&on_player_spawned);
	callback::on_connect(&on_player_connect);
	if(b_cheated)
	{
		level flag::set("power_on");
		level flag::set(#"pap_quest_completed");
		level flag::set(#"zm_red_fasttravel_open");
		/#
			if(getdvarint(#"hash_36841a9b10fd186d", 0))
			{
				var_7982b1c8 = 0;
			}
			else
			{
				level scene::init_streamer(#"hash_be0d30822a1c21b", #"allies");
			}
		#/
	}
	foreach(chest in level.chests)
	{
		chest zm_magicbox::hide_chest(0);
	}
	foreach(player in getplayers())
	{
		player disableweaponfire();
	}
	level.musicsystemoverride = 1;
	zm_red_challenges::function_304fb042();
	if(var_7982b1c8)
	{
		music::setmusicstate("boss_battle_intro_igc");
		level scene::play(#"hash_be0d30822a1c21b");
	}
	foreach(player in getplayers())
	{
		player enableweaponfire();
	}
	level.s_boss_battle.var_3edd432d show();
	level.s_boss_battle.var_c67e8352 show();
	level.s_boss_battle.var_5e9e4c15 show();
	if(!(isdefined(level.var_27a02034) && level.var_27a02034))
	{
		scene::add_scene_func("aib_vign_cust_zm_red_boss2_intro_exit", &function_21ef9bb7);
	}
	level thread scene::play("boss_intro_exit", "targetname");
	zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 9);
	zm_round_spawning::function_376e51ef(#"skeleton");
	zm_round_spawning::function_376e51ef(#"gegenees");
	level function_3de660a0();
	level clientfield::set("" + #"hash_71f9fcfb2cd84a9c", 1);
	zm_zonemgr::enable_zone("zone_boss_plateau_1");
	zm_zonemgr::enable_zone("zone_boss_plateau_2");
	zm_zonemgr::enable_zone("zone_boss_plateau_3");
	var_9dc587a9 = struct::get_array("s_boss_arena_teleport");
	a_players = getplayers();
	for(i = 0; i < a_players.size; i++)
	{
		if(var_8ef91a04)
		{
			a_players[i] setorigin(var_9dc587a9[i].origin);
			a_players[i] setplayerangles(var_9dc587a9[i].angles);
		}
		a_players[i] thread function_9099e4d8();
		foreach(var_de3a312c in level.var_3958c9ff)
		{
			a_players[i] thread zm_red_fasttravel::function_28deccf1(var_de3a312c, 1);
		}
		a_players[i] thread function_6401a80e();
		a_players[i] thread function_1722dae1();
	}
	level.var_6f6cc58 = &function_123b6625;
	level.var_4e4950d1 = &function_20c2dd32;
	zm_red::function_eeb6a1e7();
	var_7faf3e8b = array::random(util::get_active_players(#"allies"));
	if(isdefined(var_7faf3e8b))
	{
		var_7faf3e8b thread zm_vo::function_a2bd5a0c(#"hash_607c594be89dec0e", 2);
	}
	level thread function_f6306dea();
	music::setmusicstate("boss_battle_stage_1");
	wait(3);
	level thread function_756474bf();
}

/*
	Name: function_dfaf17c8
	Namespace: red_boss_battle
	Checksum: 0xB594BDA0
	Offset: 0x1FC0
	Size: 0x404
	Parameters: 0
	Flags: Linked
*/
function function_dfaf17c8()
{
	level.s_boss_battle.n_stage = 0;
	level.s_boss_battle.var_dc656db3 = 0;
	level.s_boss_battle.var_b7fe5d46 = 20000;
	level.s_boss_battle.var_36f0e240 = 0;
	level.s_boss_battle.var_4652a428 = 6;
	level.s_boss_battle.var_ad3f929f = 0;
	level.s_boss_battle.var_1e4f5dab = 15000;
	level.s_boss_battle.var_3edd432d.var_c164e6c7 = 3;
	level.s_boss_battle.var_5dc26e42 = 0;
	level.s_boss_battle.var_7fc7f236 = 15000;
	level.s_boss_battle.var_3edd432d.origin = level.s_boss_battle.s_pinnacle.origin;
	level.s_boss_battle.var_2624492f = [];
	level.s_boss_battle.var_2624492f[2] = "fountain_miniboss_ent";
	level.s_boss_battle.var_2624492f[3] = "column_miniboss_ent";
	level.s_boss_battle.var_2624492f[1] = "park_miniboss_ent";
	exploder::stop_exploder("fxexp_boss_pers_area_denial_forest");
	exploder::stop_exploder("fxexp_boss_pers_area_denial_fountain");
	exploder::stop_exploder("exp_lgt_boss_isle_1");
	exploder::stop_exploder("exp_lgt_boss_isle_2");
	level flag::clear(#"hash_75d9474065de2230");
	level flag::clear(#"hash_75d94a4065de2749");
	level flag::clear(#"hash_3e2ec7f6fb6b50c9");
	level flag::clear(#"hash_3e2ec4f6fb6b4bb0");
	level flag::clear(#"hash_15ba89b2357ff618");
	foreach(var_de3a312c in level.var_3958c9ff)
	{
		var_de3a312c.var_5a099a2d = undefined;
		var_de3a312c.var_151f9e4b = undefined;
		foreach(player in getplayers())
		{
			player thread zm_red_fasttravel::function_28deccf1(var_de3a312c, 1);
		}
	}
	level flag::clear(#"hash_315fae99adaebfb4");
	level flag::clear(#"perseus_attacking");
	level flag::clear(#"hash_59553ef93adcfe51");
	level flag::clear(#"pegasus_attacking");
	function_e4f860ab();
}

/*
	Name: on_player_spawned
	Namespace: red_boss_battle
	Checksum: 0xE5CBFA61
	Offset: 0x23D0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self function_9099e4d8();
	self thread function_1722dae1();
	self thread function_6401a80e();
}

/*
	Name: function_9099e4d8
	Namespace: red_boss_battle
	Checksum: 0xEC08BD12
	Offset: 0x2428
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_9099e4d8()
{
	if(isdefined(self.var_424c161e) && self.var_424c161e)
	{
		if(isdefined(self.var_cad44cf2))
		{
			self giveweapon(self.var_cad44cf2);
		}
		else
		{
			self takeweapon(level.var_49d60273);
			self.var_424c161e = 0;
		}
	}
}

/*
	Name: function_3de660a0
	Namespace: red_boss_battle
	Checksum: 0x835D6533
	Offset: 0x24A0
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function function_3de660a0()
{
	level.var_b2b15659 = 1;
	level.powerup_vo_available = &return_false;
	level zm_audio::function_6191af93(#"general", #"gib", "", "");
	level zm_audio::function_6191af93(#"elixir", #"drink", "", "");
	level zm_audio::function_6191af93(#"blight_father", #"weak_points", "", "");
	level zm_audio::function_6191af93(#"catalyst_transform", #"react", "", "");
	level zm_audio::function_6191af93(#"catalyst_water", #"react", "", "");
	level zm_audio::function_6191af93(#"catalyst_electric", #"react", "", "");
	level zm_audio::function_6191af93(#"catalyst_plasma", #"react", "", "");
	level zm_audio::function_6191af93(#"catalyst_corrosive", #"react", "", "");
	level zm_audio::function_6191af93(#"catalyst_corrosive", #"react", "", "");
}

/*
	Name: function_756474bf
	Namespace: red_boss_battle
	Checksum: 0x92D0177
	Offset: 0x2718
	Size: 0x8E4
	Parameters: 0
	Flags: Linked
*/
function function_756474bf()
{
	level endon(#"hash_7646638df88a3656");
	level flag::set("pause_round_timeout");
	callback::on_player_damage(&function_4cd6f3d3);
	level.var_e120ae98 = &function_60d4faca;
	level.custom_spawnplayer = &function_9bc4f8cb;
	zm_bgb_anywhere_but_here::function_886fce8f(0);
	level.zombie_round_start_delay = 0;
	level.zombie_powerups[#"fire_sale"].func_should_drop_with_regular_powerups = &return_false;
	level.zombie_powerups[#"bonus_points_team"].func_should_drop_with_regular_powerups = &return_false;
	level.zombie_powerups[#"bonus_points_player"].func_should_drop_with_regular_powerups = &return_false;
	level.zombie_powerups[#"bonus_points_player_shared"].func_should_drop_with_regular_powerups = &return_false;
	if(!isdefined(level.var_d6f059f7))
	{
		level.var_d6f059f7 = max(level.round_number, 25);
	}
	level.var_5d1805c4 = &function_d899c62c;
	switch(level.players.size)
	{
		case 1:
		{
			var_12e5a581 = 7;
			level.s_boss_battle.var_415fc88 = 15;
			level.s_boss_battle.var_2f02900b = 1;
			level.s_boss_battle.var_b7fe5d46 = 9000;
			level.s_boss_battle.var_7fc7f236 = 12000;
			level.s_boss_battle.var_1e4f5dab = 10000;
			level.s_boss_battle.var_407b6d64 = 5000;
			break;
		}
		case 2:
		{
			var_12e5a581 = 10;
			level.s_boss_battle.var_415fc88 = 20;
			level.s_boss_battle.var_2f02900b = 2;
			level.s_boss_battle.var_b7fe5d46 = 12000;
			level.s_boss_battle.var_7fc7f236 = 15000;
			level.s_boss_battle.var_1e4f5dab = 12000;
			level.s_boss_battle.var_407b6d64 = 7000;
			break;
		}
		case 3:
		{
			var_12e5a581 = 12;
			level.s_boss_battle.var_415fc88 = 25;
			level.s_boss_battle.var_2f02900b = 3;
			level.s_boss_battle.var_b7fe5d46 = 15000;
			level.s_boss_battle.var_7fc7f236 = 10000;
			level.s_boss_battle.var_1e4f5dab = 10000;
			level.s_boss_battle.var_407b6d64 = 9000;
			break;
		}
		case 4:
		{
			var_12e5a581 = 15;
			level.s_boss_battle.var_415fc88 = 33;
			level.s_boss_battle.var_2f02900b = 3;
			level.s_boss_battle.var_b7fe5d46 = 18000;
			level.s_boss_battle.var_7fc7f236 = 25000;
			level.s_boss_battle.var_1e4f5dab = 15000;
			level.s_boss_battle.var_407b6d64 = 15000;
			break;
		}
	}
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			level.s_boss_battle.var_b7fe5d46 = 200;
			level.s_boss_battle.var_f4660320 = 2;
			level.s_boss_battle.var_9d0225ce = 50000;
		}
	#/
	level.zombie_ai_limit = level.s_boss_battle.var_2f02900b;
	function_8b1f9518();
	level thread function_517bbfad(level.s_boss_battle.var_2f02900b);
	while(level.s_boss_battle.var_dc656db3 == 0)
	{
		waitframe(1);
	}
	level flag::set(#"hash_79d95c7c3d63882d");
	zm_bgb_anywhere_but_here::function_886fce8f();
	level.zombie_ai_limit = var_12e5a581;
	level flag::wait_till(#"hash_315fae99adaebfb4");
	wait(3);
	level thread function_263a0b8();
	level flag::wait_till_timeout(300, #"hash_15ba89b2357ff618");
	if(flag::get(#"pegasus_attacking"))
	{
		wait(3);
	}
	function_79611ef0(1);
	level flag::wait_till(#"hash_6dab61ca45a8eaea");
	level flag::wait_till_clear(#"pegasus_attacking");
	level flag::clear("spawn_zombies");
	level zm_utility::function_9ad5aeb1(0, 1, 1, 0);
	function_54c795f6();
	level notify(#"boss_stage_1_done");
	level flag::set(#"hash_7be183aa6a4cbe7");
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			iprintlnbold("");
		}
	#/
	level.s_boss_battle.var_3edd432d function_c7a3202c("zone_boss_plateau_2");
	level.s_boss_battle.var_3edd432d scene::play(#"hash_1d24068626b3915e", level.s_boss_battle.var_d82d0e73);
	function_4d844f2();
	level thread function_170c8b16();
	function_79611ef0(2);
	var_7faf3e8b = array::random(util::get_active_players(#"allies"));
	if(isdefined(var_7faf3e8b))
	{
		var_7faf3e8b thread zm_vo::function_a2bd5a0c(#"hash_67e6464e20e49efb", 1);
	}
	function_54c795f6();
	level.s_boss_battle.var_3edd432d function_c7a3202c("zone_boss_plateau_2");
	function_4d844f2();
	level thread function_14833fc2();
	function_e4f860ab();
	level flag::set("spawn_zombies");
	level thread function_290d42b8();
	level flag::wait_till(#"hash_6dab61ca45a8eaea");
}

/*
	Name: function_e4f860ab
	Namespace: red_boss_battle
	Checksum: 0xC2C7021B
	Offset: 0x3008
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_e4f860ab()
{
	level flag::clear(#"hash_6dab61ca45a8eaea");
	level flag::clear(#"hash_7be183aa6a4cbe7");
	level.s_boss_battle.var_5dc26e42 = 0;
	level.s_boss_battle.var_36f0e240 = 0;
}

/*
	Name: function_8b1f9518
	Namespace: red_boss_battle
	Checksum: 0x1FAE4239
	Offset: 0x3080
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_8b1f9518()
{
	if(isdefined(level.s_boss_battle.var_3edd432d))
	{
		level.s_boss_battle.var_3edd432d zm_vo::vo_say(#"hash_177261226759d391", 0, 1, 9999);
	}
}

/*
	Name: function_170c8b16
	Namespace: red_boss_battle
	Checksum: 0xF9C89855
	Offset: 0x30E0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_170c8b16()
{
	level.s_boss_battle.var_3edd432d zm_vo::vo_say(#"hash_43413288a913e03", 0, 1, 9999);
	wait(1);
	var_7faf3e8b = array::random(util::get_active_players(#"allies"));
	if(isdefined(var_7faf3e8b))
	{
		var_7faf3e8b thread zm_vo::function_a2bd5a0c(#"hash_6589e76f2431dda0", 1);
	}
}

/*
	Name: function_b8510127
	Namespace: red_boss_battle
	Checksum: 0xA301C827
	Offset: 0x3198
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_b8510127()
{
	level.s_boss_battle.var_64801233.origin = (self.origin + (anglestoforward(self.angles) * -3900)) + (anglestoright(self.angles) * -130) + (vectorscale((0, 0, -1), 160));
	level.s_boss_battle.var_64801233.angles = (0, randomintrange(0, 360), 0);
	waitframe(1);
	level.s_boss_battle.var_64801233 clientfield::increment("" + #"pegasus_emerge");
}

/*
	Name: function_b3df51ad
	Namespace: red_boss_battle
	Checksum: 0x4FE6C7BC
	Offset: 0x3288
	Size: 0x148
	Parameters: 1
	Flags: Linked
*/
function function_b3df51ad(a_ents)
{
	level endon(#"hash_4be6553c5ac0ec2b", #"hash_7646638df88a3656");
	e_pegasus = self.scene_ents[#"pegasus"];
	e_pegasus.health = 100000;
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			e_pegasus thread function_213d02bd();
		}
	#/
	while(true)
	{
		level waittill(#"bombs_away");
		v_drop_point = e_pegasus zm_utility::groundpos(e_pegasus.origin);
		if(v_drop_point[2] > 600 && !function_85593a2(v_drop_point))
		{
			zm_aoe::function_371b4147(4, #"zm_aoe_strafe_storm", v_drop_point);
		}
	}
}

/*
	Name: chaos_bolt_thrower
	Namespace: red_boss_battle
	Checksum: 0x6CDC6D74
	Offset: 0x33D8
	Size: 0x47A
	Parameters: 1
	Flags: Linked
*/
function chaos_bolt_thrower(e_target)
{
	e_perseus = level.s_boss_battle.var_3edd432d;
	v_target_pos = e_target.origin;
	if(level.s_boss_battle.n_stage != 4)
	{
		level waittill(#"artillery_out");
	}
	var_5f07628 = e_perseus gettagorigin("tag_weapon_right");
	if(isplayer(e_target))
	{
		projectile = magicbullet(level.s_boss_battle.var_5db6ed5f, var_5f07628, v_target_pos, e_perseus);
		if(level.s_boss_battle.n_stage > 1)
		{
			projectile clientfield::set("" + #"hash_64910f94ebb8d66a", 2);
		}
		else
		{
			projectile clientfield::set("" + #"hash_64910f94ebb8d66a", 1);
		}
		b_annihilator = 0;
	}
	else
	{
		projectile = magicbullet(level.s_boss_battle.var_5db6ed5f, var_5f07628, v_target_pos, e_perseus);
		projectile clientfield::set("" + #"hash_64910f94ebb8d66a", 3);
		b_annihilator = 1;
	}
	s_result = undefined;
	s_result = projectile waittilltimeout(7, #"projectile_impact_explode", #"projectile_impact_player", #"projectile_impact");
	if(s_result._notify === #"timeout")
	{
		return;
	}
	if(s_result._notify === #"projectile_impact_player")
	{
		if(isdefined(s_result.player))
		{
			v_pos = getclosestpointonnavmesh(s_result.player.origin, 128, 16);
		}
	}
	else if(s_result._notify === #"projectile_impact_explode" || s_result._notify === #"projectile_impact")
	{
		if(isdefined(s_result.position))
		{
			v_pos = getclosestpointonnavmesh(s_result.position, 128, 16);
		}
	}
	if(isdefined(v_pos))
	{
		playsoundatposition(#"hash_2a8cdf7d7ef28efe", v_pos);
		if(b_annihilator)
		{
			zm_aoe::function_371b4147(7, #"zm_aoe_chaos_bolt_annihilate", v_pos);
		}
		else
		{
			if(function_85593a2(v_pos))
			{
				return false;
			}
			switch(level.s_boss_battle.n_stage)
			{
				case 0:
				case 1:
				{
					zm_aoe::function_371b4147(5, #"zm_aoe_chaos_bolt", v_pos);
					break;
				}
				case 2:
				case 3:
				{
					zm_aoe::function_371b4147(6, #"zm_aoe_chaos_bolt_2", v_pos);
					break;
				}
			}
		}
	}
}

/*
	Name: function_9e8c41f4
	Namespace: red_boss_battle
	Checksum: 0x5A9E1816
	Offset: 0x3860
	Size: 0x202
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e8c41f4(e_target)
{
	level endon(#"perseus_defeated", #"hash_7646638df88a3656");
	e_target endon(#"death");
	var_5f3b05e8 = e_target function_732c74f7(3);
	if(!isdefined(var_5f3b05e8))
	{
		return false;
	}
	b_finished = 0;
	while(!b_finished)
	{
		self function_c7a3202c(var_5f3b05e8);
		/#
			if(getdvarint(#"zm_debug_ee", 0))
			{
				var_701a257e = "";
				switch(var_5f3b05e8)
				{
					case "zone_boss_plateau_1":
					{
						var_701a257e = "";
						break;
					}
					case "zone_boss_plateau_2":
					{
						var_701a257e = "";
						break;
					}
					case "zone_boss_plateau_3":
					{
						var_701a257e = "";
						break;
					}
				}
				iprintlnbold((("" + var_701a257e) + "") + (isdefined(e_target) ? e_target.playernum : ""));
			}
		#/
		var_59d19c72 = e_target function_732c74f7(3);
		if(!isdefined(var_59d19c72))
		{
			return false;
		}
		if(var_59d19c72 == var_5f3b05e8)
		{
			b_finished = 1;
		}
		else
		{
			var_5f3b05e8 = var_59d19c72;
		}
		waitframe(1);
	}
	return true;
}

/*
	Name: function_20bfbc00
	Namespace: red_boss_battle
	Checksum: 0x4407A0FA
	Offset: 0x3A70
	Size: 0x2B4
	Parameters: 1
	Flags: Linked
*/
function function_20bfbc00(a_ents)
{
	level endon(#"hash_4d25b32acbac5117");
	if(isarray(a_ents))
	{
		a_keys = getarraykeys(a_ents);
		if(isinarray(a_keys, #"pegasus"))
		{
			e_boss = self.scene_ents[#"pegasus"];
			self thread function_ca661e4b(1);
		}
		else if(isinarray(a_keys, #"boss_1"))
		{
			e_boss = self.scene_ents[#"boss_1"];
		}
	}
	if(!isdefined(e_boss))
	{
		return;
	}
	e_boss.var_6f84b820 = #"boss";
	e_boss.team = #"axis";
	e_boss clientfield::set("" + #"special_target", 1);
	if(!function_ffa5b184(e_boss))
	{
		e_boss function_2baad8fc();
	}
	if(!isdefined(level.var_2c19331b))
	{
		level.var_2c19331b = [];
	}
	else if(!isarray(level.var_2c19331b))
	{
		level.var_2c19331b = array(level.var_2c19331b);
	}
	if(!isinarray(level.var_2c19331b, e_boss))
	{
		level.var_2c19331b[level.var_2c19331b.size] = e_boss;
	}
	arrayremovevalue(level.var_2c19331b, undefined);
	e_boss thread function_26acf7ee();
	e_boss thread function_2858e671(#"damage");
	level thread function_2858e671(#"hero_weapon_hit", e_boss);
}

/*
	Name: function_aa23278d
	Namespace: red_boss_battle
	Checksum: 0x1B6ABE03
	Offset: 0x3D30
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_aa23278d(a_ents)
{
	e_perseus = self.scene_ents[#"boss_1"];
	if(isdefined(e_perseus.var_e0418003))
	{
		str_fx = #"hash_3a2097ef26fdafe0" + e_perseus.var_e0418003;
		e_perseus fx::play(level._effect[str_fx]);
	}
}

/*
	Name: function_2858e671
	Namespace: red_boss_battle
	Checksum: 0x454429EB
	Offset: 0x3DC8
	Size: 0x300
	Parameters: 2
	Flags: Linked
*/
function function_2858e671(var_c34665fc, e_boss)
{
	level endon(#"hash_4d25b32acbac5117", #"hash_7646638df88a3656");
	self endon(#"death");
	while(true)
	{
		s_waitresult = undefined;
		s_waitresult = self waittill(var_c34665fc);
		self.health = 100000;
		if(var_c34665fc == #"damage")
		{
			e_attacker = s_waitresult.attacker;
			w_weapon = s_waitresult.weapon;
		}
		else if(var_c34665fc == #"hero_weapon_hit")
		{
			e_attacker = s_waitresult.player;
			w_weapon = s_waitresult.var_80e17549;
		}
		if(zm_loadout::is_hero_weapon(w_weapon))
		{
			n_damage = e_attacker function_12f4c281(s_waitresult, w_weapon, e_boss);
		}
		else
		{
			continue;
		}
		if(isdefined(n_damage) && n_damage > 0)
		{
			level.s_boss_battle.var_5dc26e42 = level.s_boss_battle.var_5dc26e42 + n_damage;
			if(level.s_boss_battle.n_stage == 1)
			{
				if(level.s_boss_battle.var_5dc26e42 >= (level.s_boss_battle.var_7fc7f236 / 2))
				{
					level flag::set(#"hash_15ba89b2357ff618");
				}
				var_391b5374 = level.s_boss_battle.var_7fc7f236;
			}
			else if(level.s_boss_battle.n_stage == 3)
			{
				var_391b5374 = level.s_boss_battle.var_407b6d64;
			}
			/#
				iprintlnbold((("" + level.s_boss_battle.var_5dc26e42) + "") + var_391b5374);
			#/
			if(level.s_boss_battle.var_5dc26e42 >= var_391b5374)
			{
				level flag::set(#"hash_6dab61ca45a8eaea");
			}
			if(isdefined(e_attacker) && isplayer(e_attacker))
			{
				self function_4c17036d(e_attacker, 1);
			}
		}
	}
}

/*
	Name: function_12f4c281
	Namespace: red_boss_battle
	Checksum: 0xA0245C05
	Offset: 0x40D0
	Size: 0x820
	Parameters: 3
	Flags: Linked
*/
function function_12f4c281(s_waitresult, w_weapon, e_boss)
{
	str_notify = s_waitresult._notify;
	n_lvl = self.var_72d6f15d;
	str_weapon = self.var_b708af7b;
	var_e635b6cb = 50 * n_lvl;
	if(str_notify === "damage")
	{
		if(isinarray(level.hero_weapon[#"chakram"], w_weapon))
		{
			if(w_weapon === level.hero_weapon[#"chakram"][2] && s_waitresult.mod === "MOD_UNKNOWN")
			{
				var_7bf2d9c0 = 1;
			}
			else if(s_waitresult.mod === "MOD_PROJECTILE")
			{
				var_b162218f = 1;
			}
		}
		if(isinarray(level.hero_weapon[#"scepter"], w_weapon) && s_waitresult.mod === "MOD_BURNED")
		{
			if(isdefined(self.var_d6fe2916) && self.var_d6fe2916)
			{
				var_c408ccc9 = 1;
			}
			else
			{
				return 0;
			}
		}
		if(isinarray(level.hero_weapon[#"hammer"], w_weapon))
		{
			if(isdefined(s_waitresult.mod))
			{
				switch(s_waitresult.mod)
				{
					case "mod_electrocuted":
					{
						var_b7f8cbd8 = 1;
						break;
					}
					case "mod_unknown":
					{
						var_3ae8e8aa = 1;
						break;
					}
				}
			}
		}
		if(isinarray(level.hero_weapon[#"sword_pistol"], w_weapon))
		{
			if(s_waitresult.mod === "MOD_EXPLOSIVE")
			{
				return 0;
			}
			if(w_weapon === level.hero_weapon[#"sword_pistol"][2] && s_waitresult.mod === "MOD_PROJECTILE")
			{
				var_b46b719c = 1;
			}
		}
	}
	else if(str_notify === "hero_weapon_hit" && s_waitresult.e_entity === e_boss)
	{
		if(isinarray(level.hero_weapon[#"scepter"], w_weapon))
		{
			var_5b0fafb = 1;
		}
		if(isinarray(level.hero_weapon[#"sword_pistol"], w_weapon))
		{
			var_99f536ed = 1;
		}
	}
	switch(str_weapon)
	{
		case "chakram":
		{
			if(str_notify === "damage")
			{
				if(isdefined(var_b162218f) && var_b162218f)
				{
					n_base_damage = 100;
					/#
						str_damage_type = "";
					#/
				}
				else
				{
					if(isdefined(var_7bf2d9c0) && var_7bf2d9c0)
					{
						n_base_damage = 25;
						var_e635b6cb = 0;
						/#
							str_damage_type = "";
						#/
					}
					else
					{
						n_base_damage = 50;
						/#
							str_damage_type = "";
						#/
					}
				}
			}
			break;
		}
		case "scepter":
		{
			if(str_notify === "hero_weapon_hit")
			{
				if(isdefined(var_5b0fafb) && var_5b0fafb)
				{
					n_base_damage = 25;
					var_e635b6cb = 0;
					/#
						str_damage_type = "";
					#/
				}
			}
			else if(str_notify === "damage")
			{
				if(isdefined(var_c408ccc9) && var_c408ccc9)
				{
					n_base_damage = 50;
					var_e635b6cb = 0;
					/#
						str_damage_type = "";
					#/
				}
				else
				{
					n_base_damage = 150;
					/#
						str_damage_type = "";
					#/
				}
			}
			break;
		}
		case "hammer":
		{
			if(str_notify === "damage")
			{
				if(isdefined(var_3ae8e8aa) && var_3ae8e8aa)
				{
					n_base_damage = 6;
					var_e635b6cb = 0;
					/#
						str_damage_type = "";
					#/
				}
				else
				{
					if(isdefined(var_b7f8cbd8) && var_b7f8cbd8)
					{
						n_base_damage = 80;
						var_e635b6cb = 0;
						/#
							str_damage_type = "";
						#/
					}
					else
					{
						n_base_damage = 100;
						/#
							str_damage_type = "";
						#/
					}
				}
			}
			break;
		}
		case "sword_pistol":
		{
			if(str_notify === "hero_weapon_hit")
			{
				if(isdefined(var_99f536ed) && var_99f536ed)
				{
					n_base_damage = 100;
					/#
						str_damage_type = "";
					#/
				}
			}
			else if(str_notify === "damage")
			{
				if(isdefined(var_b46b719c) && var_b46b719c)
				{
					n_base_damage = 900;
					/#
						str_damage_type = "";
					#/
				}
				else
				{
					n_base_damage = 100;
					/#
						str_damage_type = "";
					#/
				}
			}
			break;
		}
		default:
		{
			n_base_damage = 100;
			/#
				str_damage_type = "";
			#/
		}
	}
	if(!isdefined(n_base_damage))
	{
		n_base_damage = 0;
		var_e635b6cb = 0;
		/#
		#/
	}
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			if(isdefined(str_damage_type))
			{
				iprintlnbold((str_damage_type + "") + (n_base_damage + var_e635b6cb));
			}
			if(!isdefined(level.s_boss_battle.var_5015427))
			{
				level.s_boss_battle.var_5015427 = [];
			}
			else if(!isarray(level.s_boss_battle.var_5015427))
			{
				level.s_boss_battle.var_5015427 = array(level.s_boss_battle.var_5015427);
			}
			if(!isdefined(level.s_boss_battle.var_5015427[self.playernum]))
			{
				level.s_boss_battle.var_5015427[self.playernum] = 0;
			}
			level.s_boss_battle.var_5015427[self.playernum] = level.s_boss_battle.var_5015427[self.playernum] + (n_base_damage + var_e635b6cb);
		}
	#/
	return n_base_damage + var_e635b6cb;
}

/*
	Name: function_26acf7ee
	Namespace: red_boss_battle
	Checksum: 0xD3F1DA08
	Offset: 0x48F8
	Size: 0x1DA
	Parameters: 0
	Flags: Linked
*/
function function_26acf7ee()
{
	self notify("ff57fe675953cb3");
	self endon("ff57fe675953cb3");
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			level.s_boss_battle.var_5f00964 = level.s_boss_battle.var_5dc26e42;
			level.s_boss_battle.var_5015427 = [];
			if(getdvar(#"hash_68b9a321eca18c32", 0))
			{
				setdvar(#"hash_3031043ff4ac0395", 0);
			}
		}
	#/
	level waittill(#"hash_4d25b32acbac5117", #"perseus_defeated");
	if(isdefined(self))
	{
		self clientfield::set("" + #"special_target", 0);
	}
	level.var_2c19331b = array::exclude(level.var_2c19331b, self);
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			level.s_boss_battle.var_35fffce1 = level.s_boss_battle.var_5dc26e42 - level.s_boss_battle.var_5f00964;
			if(getdvar(#"hash_68b9a321eca18c32", 0))
			{
				level.s_boss_battle.var_5dc26e42 = 0;
			}
		}
	#/
}

/*
	Name: function_4cd6f3d3
	Namespace: red_boss_battle
	Checksum: 0xB68D7A1
	Offset: 0x4AE0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_4cd6f3d3(eventstruct)
{
	if(eventstruct.eattacker === level.s_boss_battle.var_3edd432d)
	{
		zm_hero_weapon::function_3fe4a02e(self, 125);
	}
}

/*
	Name: function_517bbfad
	Namespace: red_boss_battle
	Checksum: 0xA4596C3B
	Offset: 0x4B30
	Size: 0x19C
	Parameters: 1
	Flags: Linked
*/
function function_517bbfad(var_2f02900b)
{
	level endon(#"end_game");
	level flag::clear("spawn_zombies");
	callback::on_ai_killed(&function_a362f6ed);
	callback::on_ai_spawned(&function_5e02e791);
	level scene::play("column_miniboss_ent", "targetname");
	if(var_2f02900b > 1)
	{
		level thread function_9d06f858(#"hash_1bc4862b9138d947");
		level thread function_9d06f858(#"hash_3f87a91683ebe8e3");
	}
	level flag::set("spawn_zombies");
	while(level.s_boss_battle.var_dc656db3 < var_2f02900b)
	{
		waitframe(1);
	}
	callback::remove_on_ai_killed(&function_a362f6ed);
	callback::remove_on_ai_spawned(&function_5e02e791);
	level flag::set(#"hash_315fae99adaebfb4");
}

/*
	Name: function_5e02e791
	Namespace: red_boss_battle
	Checksum: 0xEE04E084
	Offset: 0x4CD8
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function function_5e02e791()
{
	if(self.archetype === #"gegenees")
	{
		self.b_ignore_cleanup = 1;
		self.var_126d7bef = 1;
	}
}

/*
	Name: function_a362f6ed
	Namespace: red_boss_battle
	Checksum: 0x26EC542B
	Offset: 0x4D20
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_a362f6ed(s_params)
{
	if(self.archetype === #"gegenees")
	{
		level.s_boss_battle.var_dc656db3++;
	}
}

/*
	Name: function_9d06f858
	Namespace: red_boss_battle
	Checksum: 0x85F8AA06
	Offset: 0x4D68
	Size: 0xEA
	Parameters: 1
	Flags: Linked
*/
function function_9d06f858(var_fb8c33cc)
{
	level endon(#"game_end");
	level flag::wait_till(var_fb8c33cc);
	if(level.s_boss_battle.var_2f02900b > level.s_boss_battle.var_dc656db3)
	{
		switch(var_fb8c33cc)
		{
			case "hash_1bc4862b9138d947":
			{
				level scene::play("fountain_miniboss_ent", "targetname");
				break;
			}
			case "hash_3f87a91683ebe8e3":
			{
				level scene::play("park_miniboss_ent", "targetname");
				break;
			}
		}
	}
}

/*
	Name: function_263a0b8
	Namespace: red_boss_battle
	Checksum: 0x8E27FEC9
	Offset: 0x4E60
	Size: 0x25C
	Parameters: 0
	Flags: Linked
*/
function function_263a0b8()
{
	level endon(#"hash_7646638df88a3656");
	level flag::clear("spawn_zombies");
	level thread function_14833fc2();
	level flag::set(#"infinite_round_spawning");
	level.s_boss_battle.n_stage = 1;
	level.s_boss_battle.var_5dc26e42 = 0;
	level.s_boss_battle.var_64801233 = util::spawn_model("tag_origin");
	if(!(isdefined(level.var_1a1d3c82) && level.var_1a1d3c82))
	{
		scene::add_scene_func(#"hash_534b26f900cdba5", &function_b3df51ad, "play");
		scene::add_scene_func(#"hash_534b26f900cdba5", &function_21ef9bb7);
		scene::add_scene_func(#"hash_534b26f900cdba5", &function_21ef9bb7, "fail_end");
		scene::add_scene_func(#"hash_534b26f900cdba5", &function_20bfbc00, "fail_start");
		scene::add_scene_func(#"hash_534b26f900cdba5", &function_cb86284d, "fail_end");
		level.var_1a1d3c82 = 1;
	}
	level thread function_7a7b5e79();
	level util::waittill_level_any_timeout(10, level, #"hash_4be6553c5ac0ec2b");
	level flag::set("spawn_zombies");
}

/*
	Name: function_f6306dea
	Namespace: red_boss_battle
	Checksum: 0xD7116E83
	Offset: 0x50C8
	Size: 0x3D0
	Parameters: 0
	Flags: Linked
*/
function function_f6306dea()
{
	level endon(#"perseus_defeated", #"hash_3496e98116b2be19", #"hash_7646638df88a3656");
	e_perseus = level.s_boss_battle.var_3edd432d;
	if(!(isdefined(level.var_42ea19b1) && level.var_42ea19b1))
	{
		scene::add_scene_func(#"hash_50b88b53035d14fb", &function_aa23278d);
		level.var_42ea19b1 = 1;
	}
	while(true)
	{
		while(level flag::get(#"hash_59553ef93adcfe51"))
		{
			level flag::set(#"hash_44d76e9e7b9e0ebd");
			wait(0.2);
		}
		level flag::clear(#"hash_44d76e9e7b9e0ebd");
		if(math::cointoss())
		{
			e_perseus scene::play(#"hash_1642694e5dea61b4", level.s_boss_battle.var_d82d0e73);
		}
		else
		{
			e_perseus scene::play(#"hash_30b5893e00a295d1", level.s_boss_battle.var_d82d0e73);
			if(level.s_boss_battle.n_stage > 0)
			{
				level thread spawn_miniboss();
			}
		}
		if(!level flag::get(#"hash_59553ef93adcfe51"))
		{
			level flag::wait_till_clear(#"perseus_attacking");
			level flag::set(#"perseus_attacking");
			if(level.s_boss_battle.n_stage == 3)
			{
				var_c47b0cbf = 0;
				/#
					if(getdvarint(#"hash_16d0c8f49c9e0090", 0))
					{
						var_c47b0cbf = 1;
					}
				#/
				if(math::cointoss() || var_c47b0cbf)
				{
					level thread function_4a58a0(e_perseus);
					level waittill(#"hash_78452700119fc913");
				}
				else
				{
					level thread function_d9802986();
					level util::waittill_level_any_timeout(13, level, #"hash_47a15209e6e6fc14");
				}
				level thread function_84fac8d5(2, 1);
			}
			else
			{
				e_perseus.var_e0418003 = 2;
				level thread function_d9802986();
				level util::waittill_level_any_timeout(13, level, #"hash_47a15209e6e6fc14");
			}
			e_perseus.var_e0418003 = 1;
			level flag::clear(#"perseus_attacking");
		}
	}
}

/*
	Name: function_7a7b5e79
	Namespace: red_boss_battle
	Checksum: 0xC7849284
	Offset: 0x54A0
	Size: 0x20E
	Parameters: 0
	Flags: Linked
*/
function function_7a7b5e79()
{
	level endon(#"boss_stage_1_done", #"hash_7646638df88a3656");
	_town_pap_quest_complete = 0;
	var_22f02aa3 = struct::get_array("boss_attack_1");
	s_loc = struct::get("first_strike", "script_string");
	while(true)
	{
		while(level flag::get(#"hash_7be183aa6a4cbe7") || level flag::get(#"hash_6dab61ca45a8eaea"))
		{
			wait(1);
		}
		level flag::set(#"pegasus_attacking");
		var_22f02aa3 = array::filter(var_22f02aa3, 0, &function_a695c70b);
		if(!isdefined(s_loc))
		{
			s_loc = array::random(var_22f02aa3);
		}
		if(isdefined(level.s_boss_battle.var_5de58d03) && level.s_boss_battle.var_5de58d03)
		{
			s_loc = var_22f02aa3[0];
		}
		s_loc function_b8510127();
		wait(1.1);
		s_loc thread function_ca661e4b(0, _town_pap_quest_complete);
		s_loc function_1ce83bec();
		level flag::clear(#"pegasus_attacking");
		_town_pap_quest_complete++;
		wait(level.s_boss_battle.var_4652a428);
		s_loc = undefined;
	}
}

/*
	Name: function_1ce83bec
	Namespace: red_boss_battle
	Checksum: 0xF1A8D325
	Offset: 0x56B8
	Size: 0x210
	Parameters: 0
	Flags: Linked
*/
function function_1ce83bec()
{
	level endon(#"hash_7646638df88a3656");
	self scene::play(#"hash_534b26f900cdba5", "start");
	if(level.s_boss_battle.var_36f0e240 >= level.s_boss_battle.var_b7fe5d46)
	{
		level notify(#"boss_stunned");
		level thread function_14833fc2();
		self scene::play(#"hash_534b26f900cdba5", "fail_start");
		self thread scene::play(#"hash_534b26f900cdba5", "fail_loop");
		var_c5374ab4 = 7;
		if(getdvarint(#"zm_debug_ee", 0))
		{
			if(getdvarint(#"hash_3031043ff4ac0395", 0))
			{
				var_c5374ab4 = 60;
			}
		}
		wait(var_c5374ab4);
		level notify(#"hash_4d25b32acbac5117");
		self scene::play(#"hash_534b26f900cdba5", "fail_end");
		level.s_boss_battle.var_36f0e240 = 0;
	}
	else
	{
		/#
			iprintlnbold("" + level.s_boss_battle.var_36f0e240);
		#/
		self scene::play(#"hash_534b26f900cdba5", "atk_end");
	}
	level notify(#"hash_4be6553c5ac0ec2b");
}

/*
	Name: function_8e7ffff8
	Namespace: red_boss_battle
	Checksum: 0x2F8123A4
	Offset: 0x58D0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_8e7ffff8()
{
	self endon(#"death");
	level waittill(#"hash_4be6553c5ac0ec2b", #"hash_7646638df88a3656");
	wait(1);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_84fac8d5
	Namespace: red_boss_battle
	Checksum: 0xB867BDF
	Offset: 0x5938
	Size: 0x462
	Parameters: 3
	Flags: Linked
*/
function function_84fac8d5(var_956f2977, n_delay, v_origin)
{
	if(isdefined(v_origin))
	{
		a_e_players = array::get_all_closest(v_origin, util::get_active_players(#"allies"));
	}
	else
	{
		a_e_players = array::randomize(util::get_active_players(#"allies"));
	}
	switch(var_956f2977)
	{
		case 0:
		{
			var_b628ac68 = #"hash_5d787cea8ef3883a";
			n_cooldown = randomintrange(3, 7);
			if(!isdefined(level.var_cf52cfd3))
			{
				level.var_cf52cfd3 = 0;
			}
			var_10b0c19e = level.var_cf52cfd3 - level.s_boss_battle.var_5dc26e42;
			break;
		}
		case 1:
		{
			var_b628ac68 = #"hash_d41a1c9041dea26";
			n_cooldown = randomintrange(2, 5);
			break;
		}
		case 2:
		{
			var_b628ac68 = #"hash_5dfb705eb4fffef";
			n_cooldown = randomintrange(3, 7);
			if(!isdefined(level.var_d6bf4d87))
			{
				level.var_d6bf4d87 = 0;
			}
			var_10b0c19e = level.var_d6bf4d87 - level.s_boss_battle.var_5dc26e42;
			break;
		}
		case 3:
		{
			var_b628ac68 = #"hash_248248312e0377c1";
			n_cooldown = randomintrange(2, 5);
			break;
		}
	}
	if(!isdefined(var_b628ac68))
	{
		return false;
	}
	if(isdefined(var_10b0c19e) && var_10b0c19e >= 0)
	{
		return false;
	}
	foreach(e_player in a_e_players)
	{
		if(!isdefined(e_player.var_fea99aef))
		{
			e_player.var_fea99aef = [];
		}
		else if(!isarray(e_player.var_fea99aef))
		{
			e_player.var_fea99aef = array(e_player.var_fea99aef);
		}
		if(!isdefined(e_player.var_fea99aef[var_956f2977]) || !e_player.var_fea99aef[var_956f2977])
		{
			if(var_956f2977 == 1 || var_956f2977 == 3)
			{
				if(e_player gadgetpowerget(level.var_a53a05b5) < 100)
				{
					continue;
				}
			}
			e_player thread zm_vo::function_a2bd5a0c(var_b628ac68, n_delay);
			e_player.var_fea99aef[var_956f2977] = n_cooldown;
			if(var_956f2977 == 0)
			{
				level.var_cf52cfd3 = level.s_boss_battle.var_5dc26e42;
			}
			else if(var_956f2977 == 2)
			{
				level.var_d6bf4d87 = level.s_boss_battle.var_5dc26e42;
			}
			return true;
		}
		e_player.var_fea99aef[var_956f2977]--;
	}
}

/*
	Name: function_ca661e4b
	Namespace: red_boss_battle
	Checksum: 0x6C391A10
	Offset: 0x5DA8
	Size: 0x1EA
	Parameters: 2
	Flags: Linked, Private
*/
function private function_ca661e4b(var_956f2977, _town_pap_quest_complete)
{
	switch(var_956f2977)
	{
		case 0:
		{
			if(!_town_pap_quest_complete)
			{
				level.s_boss_battle.var_3edd432d zm_vo::vo_say(#"hash_504e6e3f0da7a9df", 0, 1, 9999);
				a_e_players = array::get_all_closest(self.origin, util::get_active_players(#"allies"));
				foreach(e_player in a_e_players)
				{
					if(zm_utility::is_player_valid(e_player))
					{
						var_7faf3e8b = e_player;
						break;
					}
				}
				if(isdefined(var_7faf3e8b))
				{
					var_7faf3e8b zm_vo::function_a2bd5a0c(#"hash_2c9021dcd1e62316", 1);
				}
			}
			else
			{
				function_84fac8d5(0, 2, self.origin);
			}
			break;
		}
		case 1:
		{
			function_84fac8d5(1, 2, level.s_boss_battle.var_3edd432d.origin);
			break;
		}
	}
}

/*
	Name: function_21ef9bb7
	Namespace: red_boss_battle
	Checksum: 0xED26FC47
	Offset: 0x5FA0
	Size: 0x458
	Parameters: 1
	Flags: Linked
*/
function function_21ef9bb7(a_ents)
{
	level endon(#"hash_4be6553c5ac0ec2b", #"boss_stunned", #"hash_6b4f82e61af7cb08");
	if(isarray(a_ents))
	{
		a_keys = getarraykeys(a_ents);
		if(isinarray(a_keys, #"pegasus"))
		{
			e_boss = self.scene_ents[#"pegasus"];
			var_653b9351 = 1;
			/#
				var_b9c3f277 = "";
			#/
			e_boss thread function_8e7ffff8();
		}
		else if(isinarray(a_keys, #"boss_1"))
		{
			e_boss = self.scene_ents[#"boss_1"];
			var_653b9351 = 0;
			/#
				var_b9c3f277 = "";
			#/
		}
	}
	if(!isdefined(e_boss))
	{
		return;
	}
	e_boss endon(#"death");
	level thread function_5fc81f0a(e_boss);
	e_boss.var_6f84b820 = #"boss";
	e_boss setteam("axis");
	target_set(e_boss);
	if(!function_ffa5b184(e_boss))
	{
		e_boss function_2baad8fc();
	}
	while(true)
	{
		s_waitresult = undefined;
		s_waitresult = e_boss waittill(#"damage", #"death");
		e_boss.health = 100000;
		if(s_waitresult._notify === "death")
		{
			return;
		}
		e_attacker = s_waitresult.attacker;
		if(isdefined(e_attacker) && isplayer(e_attacker))
		{
			e_boss function_4c17036d(e_attacker);
		}
		if(var_653b9351)
		{
			level.s_boss_battle.var_36f0e240 = level.s_boss_battle.var_36f0e240 + s_waitresult.amount;
		}
		else
		{
			if(zm_weapons::function_35746b9c(s_waitresult.weapon))
			{
				level.s_boss_battle.var_ad3f929f = level.s_boss_battle.var_ad3f929f + 50;
				/#
					if(getdvarint(#"zm_debug_ee", 0))
					{
						s_waitresult.amount = 50;
					}
				#/
			}
			else
			{
				level.s_boss_battle.var_ad3f929f = level.s_boss_battle.var_ad3f929f + s_waitresult.amount;
			}
		}
		/#
			if(getdvarint(#"zm_debug_ee", 0))
			{
				if(var_653b9351 || (!var_653b9351 && (!(isdefined(e_boss.var_c3505998) && e_boss.var_c3505998))))
				{
					iprintlnbold(((var_b9c3f277 + "") + s_waitresult.amount) + "");
				}
			}
		#/
	}
}

/*
	Name: function_d9802986
	Namespace: red_boss_battle
	Checksum: 0xC02F6580
	Offset: 0x6400
	Size: 0x3B0
	Parameters: 0
	Flags: Linked
*/
function function_d9802986()
{
	self notify("1e89b8ab1ad1c3c6");
	self endon("1e89b8ab1ad1c3c6");
	level endon(#"perseus_defeated", #"hash_7646638df88a3656");
	s_pinnacle = struct::get("s_pinnacle_center");
	e_perseus = level.s_boss_battle.var_3edd432d;
	b_target_found = 0;
	e_target = undefined;
	while(!b_target_found)
	{
		a_e_active_players = util::get_active_players(#"allies");
		a_e_active_players = array::randomize(a_e_active_players);
		if(a_e_active_players.size > 1)
		{
			foreach(e_active_player in a_e_active_players)
			{
				if(zm_utility::is_player_valid(e_active_player) && (!(isdefined(e_active_player.var_16735873) && e_active_player.var_16735873)) && e_perseus.var_56b1208a !== e_active_player && !e_active_player istouching(level.s_boss_battle.var_98ea549b))
				{
					e_target = e_active_player;
				}
			}
		}
		else
		{
			e_target = a_e_active_players[0];
		}
		if(!isdefined(e_target))
		{
			wait(0.3);
		}
		else
		{
			b_target_found = 1;
		}
	}
	e_perseus.var_56b1208a = e_target;
	b_success = e_perseus function_9e8c41f4(e_target);
	if(isdefined(b_success) && b_success)
	{
		if(!isdefined(e_perseus.var_90e23166))
		{
			e_perseus.var_90e23166 = 5;
		}
		if(!e_perseus.var_90e23166)
		{
			e_perseus thread zm_vo::vo_say(#"hash_7565b085198b71db", 0, 1, 9999);
			e_perseus.var_90e23166 = function_21a3a673(8, 17);
		}
		else
		{
			e_perseus.var_90e23166--;
		}
		level thread chaos_bolt_thrower(e_target);
		e_perseus scene::play(#"hash_50b88b53035d14fb", level.s_boss_battle.var_d82d0e73);
	}
	else
	{
		/#
			iprintlnbold(("" + (isdefined(e_target) ? e_target.playernum : "")) + "");
		#/
		if(getdvarint(#"zm_debug_ee", 0))
		{
		}
	}
	level notify(#"hash_47a15209e6e6fc14");
}

/*
	Name: function_732c74f7
	Namespace: red_boss_battle
	Checksum: 0x99AC7635
	Offset: 0x67B8
	Size: 0xDE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_732c74f7(n_max_time)
{
	var_5f3b05e8 = self zm_zonemgr::get_player_zone();
	n_time = 0;
	while(!isdefined(var_5f3b05e8))
	{
		wait(0.3);
		n_time = n_time + 0.3;
		if(isdefined(n_max_time))
		{
			if(n_time > n_max_time)
			{
				/#
					if(getdvarint(#"zm_debug_ee", 0))
					{
						iprintlnbold("" + n_max_time);
					}
				#/
				return;
			}
		}
		var_5f3b05e8 = self zm_zonemgr::get_player_zone();
	}
	return var_5f3b05e8;
}

/*
	Name: function_3c2238ed
	Namespace: red_boss_battle
	Checksum: 0xD2C89D14
	Offset: 0x68A0
	Size: 0x86
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3c2238ed(str_zone)
{
	n_island = 0;
	switch(str_zone)
	{
		case "zone_boss_plateau_1":
		{
			n_island = 2;
			break;
		}
		case "zone_boss_plateau_2":
		{
			n_island = 3;
			break;
		}
		case "zone_boss_plateau_3":
		{
			n_island = 1;
			break;
		}
	}
	return n_island;
}

/*
	Name: function_cb86284d
	Namespace: red_boss_battle
	Checksum: 0xE7BB4D86
	Offset: 0x6930
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_cb86284d(a_ents)
{
	level endon(#"hash_7646638df88a3656");
	e_pegasus = a_ents[#"pegasus"];
	if(isdefined(e_pegasus))
	{
		level waittill(#"hash_18dd51d5a10476a3");
		var_1d708692 = zm_utility::groundpos(e_pegasus.origin);
		str_zone = zm_zonemgr::get_zone_from_position(var_1d708692);
		if(!isdefined(str_zone))
		{
			return;
		}
		switch(str_zone)
		{
			case "zone_boss_plateau_1":
			{
				n_isle = 2;
				break;
			}
			case "zone_boss_plateau_2":
			{
				n_isle = 3;
				break;
			}
			case "zone_boss_plateau_3":
			{
				n_isle = 1;
				break;
			}
		}
		function_b2420fe0(n_isle);
		level thread function_b4723f8e(var_1d708692, e_pegasus);
	}
}

/*
	Name: function_b4723f8e
	Namespace: red_boss_battle
	Checksum: 0x179934B2
	Offset: 0x6A90
	Size: 0x294
	Parameters: 2
	Flags: Linked, Private
*/
function private function_b4723f8e(v_origin, e_pegasus)
{
	mdl_origin = spawn("script_model", v_origin);
	mdl_origin setmodel("tag_origin");
	mdl_origin clientfield::set("" + #"pegasus_storm", 1);
	n_radius = 256;
	for(n_iterations = int(20); n_iterations > 0; n_iterations--)
	{
		foreach(e_player in getplayers())
		{
			if(!isalive(e_player))
			{
				continue;
			}
			n_radius_squared = n_radius * n_radius;
			if(distancesquared(e_player.origin, v_origin) < n_radius_squared)
			{
				e_player clientfield::set("" + #"hash_73e309ffb25bf63d", 1);
				e_player thread lightning_flash();
				e_player status_effect::status_effect_apply(level.s_boss_battle.var_86d9f46c, undefined, e_pegasus);
				e_player dodamage(10, v_origin);
			}
		}
		wait(0.5);
		if(n_radius < 1000)
		{
			n_radius = math::clamp(n_radius + 50, 256, 1000);
		}
	}
	mdl_origin clientfield::set("" + #"pegasus_storm", 0);
}

/*
	Name: lightning_flash
	Namespace: red_boss_battle
	Checksum: 0xE6E5D2CA
	Offset: 0x6D30
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function lightning_flash()
{
	self clientfield::set_to_player("" + #"pegasus_shellshock", 1);
	self clientfield::increment_to_player("" + #"hash_3bb8b5cda11eecc6");
	wait(0.25);
	self clientfield::set_to_player("" + #"pegasus_shellshock", 0);
}

/*
	Name: function_325b6d95
	Namespace: red_boss_battle
	Checksum: 0x3AF1C904
	Offset: 0x6DC8
	Size: 0x1B2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_325b6d95(v_origin)
{
	level endon(#"hash_7646638df88a3656");
	n_radius = 1000;
	n_iterations = int(20);
	w_fire = getweapon(#"incendiary_fire");
	while(n_iterations > 0)
	{
		foreach(e_player in getplayers())
		{
			if(!isalive(e_player))
			{
				continue;
			}
			n_radius_squared = n_radius * n_radius;
			if(distancesquared(e_player.origin, v_origin) < n_radius_squared)
			{
				e_player status_effect::status_effect_apply(level.s_boss_battle.var_b42f3b39, w_fire, level.s_boss_battle.var_3edd432d, 0);
				e_player dodamage(10, v_origin);
			}
		}
		wait(0.5);
		n_iterations--;
	}
}

/*
	Name: function_290d42b8
	Namespace: red_boss_battle
	Checksum: 0x25F69705
	Offset: 0x6F88
	Size: 0x22A
	Parameters: 1
	Flags: Linked
*/
function function_290d42b8(b_skipped = 0)
{
	level endon(#"hash_7646638df88a3656");
	if(b_skipped)
	{
		level notify(#"boss_stage_1_done");
	}
	level.s_boss_battle.var_3edd432d.var_c164e6c7 = 3;
	level.s_boss_battle.n_stage = 3;
	/#
		iprintlnbold(("" + level.s_boss_battle.n_stage) + "");
	#/
	level thread function_14833fc2();
	if(level.activeplayers.size == 4)
	{
		level.s_boss_battle.var_415fc88 = 50;
	}
	if(!(isdefined(level.var_bd36bb6e) && level.var_bd36bb6e))
	{
		scene::add_scene_func(#"hash_732e3b38ca890511", &function_e069d23c);
		scene::add_scene_func(#"hash_732e3b38ca890511", &function_21ef9bb7);
		scene::add_scene_func(#"hash_732e3b38ca890511", &function_20bfbc00, "fail_start");
		scene::add_scene_func(#"hash_732e3b38ca890511", &function_2a866d1a, "atk_end");
		scene::add_scene_func(#"hash_6fe74ac19c70eaf0", &function_20bfbc00);
		level.var_bd36bb6e = 1;
	}
}

/*
	Name: function_4a58a0
	Namespace: red_boss_battle
	Checksum: 0xA5A90534
	Offset: 0x71C0
	Size: 0x640
	Parameters: 1
	Flags: Linked
*/
function function_4a58a0(e_perseus)
{
	level endon(#"hash_71d7e6a55a1ca9e", #"hash_7646638df88a3656");
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			e_perseus thread function_213d02bd();
		}
	#/
	s_target = array::random(level.s_boss_battle.var_5203fa2b);
	v_destination = s_target.origin;
	if(!isdefined(e_perseus.var_cd1eedcd) || !e_perseus.var_cd1eedcd)
	{
		if(!isdefined(e_perseus.var_8ba6a643))
		{
			e_perseus.var_8ba6a643 = 0;
		}
		var_10b0c19e = e_perseus.var_8ba6a643 - level.s_boss_battle.var_5dc26e42;
		if(var_10b0c19e < 0)
		{
			e_perseus thread zm_vo::vo_say(#"hash_4690d77cb085e0c8", 0, 1, 9999);
			e_perseus.var_cd1eedcd = function_21a3a673(3, 7);
			e_perseus.var_8ba6a643 = level.s_boss_battle.var_5dc26e42;
		}
	}
	else
	{
		e_perseus.var_cd1eedcd--;
	}
	level thread function_bc717eee(v_destination);
	e_perseus scene::play(#"hash_5d8c1562884d9ada", level.s_boss_battle.var_d82d0e73);
	e_perseus.origin = v_destination;
	e_perseus.angles = s_target.angles;
	level thread function_766fb0b1(e_perseus.origin);
	level thread function_bc717eee((20323.7, 21819.1, 1419.25));
	e_perseus scene::play(#"hash_732e3b38ca890511", "start", level.s_boss_battle.var_d82d0e73);
	if(level.s_boss_battle.var_ad3f929f >= level.s_boss_battle.var_1e4f5dab)
	{
		level thread function_14833fc2();
		level notify(#"hash_6b4f82e61af7cb08");
		level thread function_84fac8d5(3, 1);
		e_perseus thread scene::play(#"hash_732e3b38ca890511", "fail_start", level.s_boss_battle.var_d82d0e73);
		/#
			e_perseus.var_c3505998 = 1;
		#/
		var_c5374ab4 = 7;
		if(getdvarint(#"zm_debug_ee", 0))
		{
			if(getdvarint(#"hash_3031043ff4ac0395", 0))
			{
				var_c5374ab4 = 60;
			}
		}
		wait(var_c5374ab4);
		if(level flag::get(#"hash_6dab61ca45a8eaea"))
		{
			level notify(#"perseus_defeated");
			e_perseus thread function_caa7eeb();
			level flag::wait_till(#"hash_1c0b421abe38d4e0");
			foreach(player in getplayers())
			{
				if(isdefined(player) && player clientfield::get_to_player("" + #"hash_403e80cafccc207c"))
				{
					player clientfield::set_to_player("" + #"hash_403e80cafccc207c", 0);
				}
			}
			level thread function_ce82050b();
			level notify(#"hash_71d7e6a55a1ca9e");
		}
		e_perseus scene::play(#"hash_732e3b38ca890511", "fail_end", level.s_boss_battle.var_d82d0e73);
		/#
			e_perseus.var_c3505998 = 0;
		#/
		level notify(#"hash_4d25b32acbac5117");
		level.s_boss_battle.var_ad3f929f = 0;
	}
	else
	{
		e_perseus scene::play(#"hash_732e3b38ca890511", "atk_end", level.s_boss_battle.var_d82d0e73);
	}
	e_perseus.origin = level.s_boss_battle.s_pinnacle.origin;
	e_perseus.angles = vectorscale((0, 1, 0), 90);
	level notify(#"hash_78452700119fc913");
}

/*
	Name: function_2a866d1a
	Namespace: red_boss_battle
	Checksum: 0x880DFD3E
	Offset: 0x7808
	Size: 0x1AE
	Parameters: 1
	Flags: Linked
*/
function function_2a866d1a(a_ents)
{
	level endon(#"end_game");
	e_perseus = level.s_boss_battle.var_3edd432d;
	var_5287d229 = anglestoforward(e_perseus.angles);
	for(i = 0; i <= 10; i++)
	{
		n_yaw = (36 * i) + 22;
		var_bbaa9da2 = var_5287d229 + (0, n_yaw, 0);
		v_direction = anglestoforward(var_bbaa9da2);
		v_target_loc = e_perseus.origin + v_direction;
		launchvelocity = (vectornormalize(v_target_loc - e_perseus.origin)) * 800;
		projectile = e_perseus magicmissile(level.s_boss_battle.var_5db6ed5f, v_target_loc + (16, 0, 54), launchvelocity);
		projectile clientfield::set("" + #"hash_64910f94ebb8d66a", 3);
	}
}

/*
	Name: function_ab699e09
	Namespace: red_boss_battle
	Checksum: 0x3E04CB27
	Offset: 0x79C0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_ab699e09()
{
	self clientfield::set("" + #"special_target", 0);
	exploder::stop_exploder("fxexp_barrier_arena");
	self scene::play(#"hash_6fe74ac19c70eaf0", level.s_boss_battle.var_d82d0e73);
}

/*
	Name: function_caa7eeb
	Namespace: red_boss_battle
	Checksum: 0x53647951
	Offset: 0x7A40
	Size: 0x3DC
	Parameters: 0
	Flags: Linked
*/
function function_caa7eeb()
{
	music::setmusicstate("none");
	level.musicsystemoverride = 0;
	self thread function_ab699e09();
	level flag::clear("spawn_zombies");
	level thread cleanup_final();
	foreach(player in getplayers())
	{
		player val::set("game_over_man", "takedamage", 0);
	}
	if(!zm_utility::is_trials())
	{
		level scene::function_27f5972e(#"hash_649bf4517c6d8d25");
		level scene::init_streamer(#"hash_649bf4517c6d8d25", #"allies", 0, 0);
	}
	self zm_vo::vo_say(#"hash_34171dfc4d06ae4b", 0, 1, 9999);
	level.var_92830991 = util::spawn_model(#"hash_7ad70aa7f6e8c41f", self.origin + vectorscale((0, 0, 1), 48), self.angles);
	level.var_92830991 setscale(4);
	level.var_92830991 thread namespace_f8f28e08::function_51fd2597(0);
	level.var_92830991 thread namespace_f8f28e08::function_f7cdf2f7(2);
	playfx(level._effect[#"perseus_death"], level.var_92830991.origin - vectorscale((0, 0, 1), 16));
	array::run_all(level.s_boss_battle.var_d82d0e73, &ghost);
	array::run_all(level.s_boss_battle.var_d82d0e73, &notsolid);
	var_7faf3e8b = array::random(util::get_active_players(#"allies"));
	if(isdefined(var_7faf3e8b))
	{
		var_7faf3e8b zm_vo::function_a2bd5a0c(#"hash_2b8d0adc9ec3b069");
	}
	var_791705a1 = level.var_92830991 zm_unitrigger::function_fac87205(&function_662093d4, 64);
	level.var_92830991 delete();
	var_791705a1 zm_vo::function_a2bd5a0c(#"hash_213d18d49a47d63b");
	level flag::set(#"hash_1c0b421abe38d4e0");
}

/*
	Name: function_662093d4
	Namespace: red_boss_battle
	Checksum: 0x9F6BF122
	Offset: 0x7E28
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_662093d4(player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_16d3e1ce95636700", #"hash_54d93a685e1f42c");
	self sethintstringforplayer(player, str_prompt);
	return true;
}

/*
	Name: function_e069d23c
	Namespace: red_boss_battle
	Checksum: 0x450A6228
	Offset: 0x7E98
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function function_e069d23c(a_ents)
{
	level endon(#"hash_3032e59c42d961c5", #"hash_6b4f82e61af7cb08", #"hash_7646638df88a3656");
	level waittill(#"hash_511761d3a360abd5");
	e_perseus = level.s_boss_battle.var_3edd432d;
	v_loc = e_perseus gettagorigin("tag_weapon_right");
	var_c23ba302 = spawn("trigger_radius", v_loc, 0, 192, 32);
	foreach(e_player in level.players)
	{
		if(e_player istouching(var_c23ba302))
		{
			e_player dodamage(150, v_loc, e_perseus);
		}
	}
	var_c23ba302 delete();
}

/*
	Name: function_ce82050b
	Namespace: red_boss_battle
	Checksum: 0x75FAB4CE
	Offset: 0x8020
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_ce82050b()
{
	level flag::set(#"boss_battle_complete");
	if(zm_utility::is_trials())
	{
		return;
	}
	level zm_red::play_outro();
	level notify(#"end_game");
}

/*
	Name: function_123b6625
	Namespace: red_boss_battle
	Checksum: 0x293F986F
	Offset: 0x8088
	Size: 0x1DC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_123b6625(e_player)
{
	if(!isdefined(e_player) || !isdefined(self))
	{
		return false;
	}
	var_fe34d2c5 = self istouching(level.s_boss_battle.var_35345d3d);
	var_c58285e2 = e_player istouching(level.s_boss_battle.var_35345d3d);
	var_b517b5b0 = self istouching(level.s_boss_battle.var_285e59dd);
	var_ba5e5578 = e_player istouching(level.s_boss_battle.var_285e59dd);
	var_363b4c7a = self istouching(level.s_boss_battle.var_76f4f0e9);
	var_5692580b = e_player istouching(level.s_boss_battle.var_76f4f0e9);
	if(!var_363b4c7a && !var_b517b5b0 && !var_fe34d2c5)
	{
		return false;
	}
	if(var_fe34d2c5 && var_ba5e5578 || (var_fe34d2c5 && var_5692580b))
	{
		return false;
	}
	if(var_b517b5b0 && var_5692580b || (var_b517b5b0 && var_c58285e2))
	{
		return false;
	}
	if(var_363b4c7a && !var_5692580b)
	{
		return false;
	}
	return true;
}

/*
	Name: function_20c2dd32
	Namespace: red_boss_battle
	Checksum: 0xE9D2A830
	Offset: 0x8270
	Size: 0x3A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_20c2dd32(poi)
{
	reachable = self function_123b6625(poi[1]);
	return reachable;
}

/*
	Name: function_14833fc2
	Namespace: red_boss_battle
	Checksum: 0x16B56B49
	Offset: 0x82B8
	Size: 0x68
	Parameters: 0
	Flags: Linked, Private
*/
function private function_14833fc2()
{
	if(zm_utility::is_trials())
	{
		return;
	}
	target_round = zm_round_logic::get_round_number() + 1;
	zm_round_logic::set_round_number(target_round - 1);
	level notify(#"kill_round_wait");
}

/*
	Name: function_d899c62c
	Namespace: red_boss_battle
	Checksum: 0xDC28AA19
	Offset: 0x8328
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function function_d899c62c(base_health, round_number)
{
	var_d082c739 = base_health;
	round_number = level.var_d6f059f7;
	for(i = 2; i <= round_number; i++)
	{
		if(i >= 10 && (!(isdefined(level.var_50dd0ec5) && level.var_50dd0ec5)))
		{
			old_health = var_d082c739;
			var_d082c739 = var_d082c739 + (int(var_d082c739 * zombie_utility::function_d2dfacfd(#"zombie_health_increase_multiplier")));
			if(var_d082c739 < old_health)
			{
				var_d082c739 = old_health;
				break;
			}
			continue;
		}
		var_d082c739 = int(var_d082c739 + zombie_utility::function_d2dfacfd(#"zombie_health_increase"));
	}
	return var_d082c739;
}

/*
	Name: function_54c795f6
	Namespace: red_boss_battle
	Checksum: 0xD0F7472E
	Offset: 0x8468
	Size: 0xE4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_54c795f6()
{
	level endon(#"hash_7646638df88a3656");
	if(level flag::get(#"hash_59553ef93adcfe51"))
	{
		/#
			if(getdvarint(#"zm_debug_ee", 0))
			{
				iprintlnbold("");
			}
		#/
		level flag::wait_till_clear(#"hash_59553ef93adcfe51");
		wait(0.2);
	}
	level flag::set(#"hash_59553ef93adcfe51");
	level flag::wait_till(#"hash_44d76e9e7b9e0ebd");
}

/*
	Name: function_4d844f2
	Namespace: red_boss_battle
	Checksum: 0xFE85B8FE
	Offset: 0x8558
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
function private function_4d844f2()
{
	level flag::clear(#"hash_59553ef93adcfe51");
}

/*
	Name: function_79611ef0
	Namespace: red_boss_battle
	Checksum: 0x699012B4
	Offset: 0x8588
	Size: 0x408
	Parameters: 1
	Flags: Linked
*/
function function_79611ef0(n_island)
{
	level endon(#"hash_7646638df88a3656");
	e_perseus = level.s_boss_battle.var_3edd432d;
	switch(n_island)
	{
		case 1:
		{
			var_46285 = level.s_boss_battle.var_76f4f0e9;
			var_3c7cb573 = struct::get("isle_1_powerup");
			var_6a56e928 = "zone_boss_plateau_3";
			str_exploder = "fxexp_boss_pers_area_denial_forest";
			break;
		}
		case 2:
		{
			var_46285 = level.s_boss_battle.var_35345d3d;
			var_3c7cb573 = struct::get("isle_2_powerup");
			var_6a56e928 = "zone_boss_plateau_1";
			str_exploder = "fxexp_boss_pers_area_denial_fountain";
			break;
		}
	}
	level.s_boss_battle.var_2624492f[n_island] = undefined;
	function_54c795f6();
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			iprintlnbold(("" + (n_island == 1 ? "" : "")) + "");
		}
	#/
	e_perseus function_c7a3202c(var_6a56e928);
	level flag::set(#"hash_44af125ee5c05d21" + n_island);
	function_2003ebc9(n_island);
	exploder::exploder(str_exploder);
	level thread function_325b6d95(var_3c7cb573.origin);
	if(!(isdefined(level.var_aa83d388) && level.var_aa83d388))
	{
		scene::add_scene_func(#"hash_5b406244b035d85", &function_a3f19534, "play");
		level.var_aa83d388 = 1;
	}
	e_perseus scene::play(#"hash_5b406244b035d85", level.s_boss_battle.var_d82d0e73);
	function_4d844f2();
	level flag::set(#"hash_268e0da84abacda2" + n_island);
	str_exploder = "exp_lgt_boss_isle_" + n_island;
	exploder::exploder(str_exploder);
	function_75f1dc3a(n_island);
	foreach(e_player in util::get_active_players(#"allies"))
	{
		if(e_player istouching(var_46285))
		{
			e_player zm_laststand::instakill_player();
		}
	}
}

/*
	Name: function_a3f19534
	Namespace: red_boss_battle
	Checksum: 0xBD6A4E98
	Offset: 0x8998
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function function_a3f19534(a_ents)
{
	if(isdefined(a_ents[#"boss_1"]))
	{
		a_ents[#"boss_1"] waittill(#"hash_6454c20f6358b7e1");
		foreach(player in getplayers())
		{
			if(isdefined(player))
			{
				player playrumbleonentity("zm_red_step_complete_rumble");
			}
		}
	}
}

/*
	Name: function_2003ebc9
	Namespace: red_boss_battle
	Checksum: 0xECC216C2
	Offset: 0x8A80
	Size: 0x306
	Parameters: 1
	Flags: Linked, Private
*/
function private function_2003ebc9(n_island)
{
	foreach(var_225a75b4 in level.var_4775015b)
	{
		switch(n_island)
		{
			case 1:
			{
				if(var_225a75b4.script_string === "column_to_park" || var_225a75b4.script_string === "fountain_to_park")
				{
					var_225a75b4.var_5a099a2d = 1;
					array::thread_all(util::get_players(#"allies"), &zm_red_fasttravel::function_28deccf1, var_225a75b4, 0);
					var_225a75b4.unitrigger_stub thread util::delay_notify(0.1, "cancel_fasttravel_cooldown");
				}
				if(var_225a75b4.script_string === "park_to_column" || var_225a75b4.script_string === "park_to_fountain")
				{
					var_225a75b4.var_151f9e4b = 1;
					var_225a75b4.unitrigger_stub thread util::delay_notify(0.1, "cancel_fasttravel_cooldown");
				}
				break;
			}
			case 2:
			{
				if(var_225a75b4.script_string === "column_to_fountain" || var_225a75b4.script_string === "park_to_fountain")
				{
					var_225a75b4.var_5a099a2d = 1;
					array::thread_all(util::get_players(#"allies"), &zm_red_fasttravel::function_28deccf1, var_225a75b4, 0);
					var_225a75b4.unitrigger_stub thread util::delay_notify(0.1, "cancel_fasttravel_cooldown");
				}
				if(var_225a75b4.script_string === "fountain_to_column" || var_225a75b4.script_string === "fountain_to_park")
				{
					var_225a75b4.var_151f9e4b = 1;
					var_225a75b4.unitrigger_stub thread util::delay_notify(0.1, "cancel_fasttravel_cooldown");
				}
				break;
			}
		}
	}
}

/*
	Name: function_75f1dc3a
	Namespace: red_boss_battle
	Checksum: 0xD16057AA
	Offset: 0x8D90
	Size: 0x1C6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_75f1dc3a(n_island)
{
	foreach(var_225a75b4 in level.var_4775015b)
	{
		switch(n_island)
		{
			case 1:
			{
				if(var_225a75b4.script_string === "park_to_column" || var_225a75b4.script_string === "park_to_fountain")
				{
					var_225a75b4.var_5a099a2d = 1;
					array::thread_all(util::get_players(#"allies"), &zm_red_fasttravel::function_28deccf1, var_225a75b4, 0);
				}
				break;
			}
			case 2:
			{
				if(var_225a75b4.script_string === "fountain_to_column" || var_225a75b4.script_string === "fountain_to_park")
				{
					var_225a75b4.var_5a099a2d = 1;
					array::thread_all(util::get_players(#"allies"), &zm_red_fasttravel::function_28deccf1, var_225a75b4, 0);
				}
				break;
			}
		}
	}
}

/*
	Name: function_b2420fe0
	Namespace: red_boss_battle
	Checksum: 0x85727AC3
	Offset: 0x8F60
	Size: 0x2CC
	Parameters: 1
	Flags: Linked
*/
function function_b2420fe0(n_island)
{
	switch(n_island)
	{
		case 2:
		{
			if(level flag::get(#"hash_75d9474065de2230"))
			{
				var_888ae42 = struct::get("isle_3_powerup");
			}
			else
			{
				var_78a8b445 = struct::get("isle_3_powerup");
				var_888ae42 = struct::get("isle_1_powerup");
			}
			break;
		}
		case 3:
		{
			if(level flag::get(#"hash_75d9474065de2230") && level flag::get(#"hash_75d94a4065de2749"))
			{
			}
			else
			{
				if(level flag::get(#"hash_75d9474065de2230"))
				{
					var_888ae42 = struct::get("isle_2_powerup");
				}
				else
				{
					if(level flag::get(#"hash_75d94a4065de2749"))
					{
						var_888ae42 = struct::get("isle_1_powerup");
					}
					else
					{
						var_78a8b445 = struct::get("isle_1_powerup");
						var_888ae42 = struct::get("isle_2_powerup");
					}
				}
			}
			break;
		}
		case 1:
		{
			if(level flag::get(#"hash_75d94a4065de2749"))
			{
				var_888ae42 = struct::get("isle_3_powerup");
			}
			else
			{
				var_78a8b445 = struct::get("isle_2_powerup");
				var_888ae42 = struct::get("isle_3_powerup");
			}
		}
	}
	if(isdefined(var_888ae42))
	{
		zm_powerups::specific_powerup_drop("full_ammo", var_888ae42.origin, undefined, undefined, undefined, undefined, 1, undefined, 1);
	}
	if(isdefined(var_78a8b445))
	{
		zm_powerups::specific_powerup_drop("carpenter", var_78a8b445.origin, undefined, undefined, undefined, undefined, 1, undefined, 1);
	}
}

/*
	Name: function_a695c70b
	Namespace: red_boss_battle
	Checksum: 0xEA5D9658
	Offset: 0x9238
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function function_a695c70b(s_loc)
{
	if(s_loc.script_int === 1 && level flag::get(#"hash_75d9474065de2230"))
	{
		return false;
	}
	return true;
}

/*
	Name: function_c7a3202c
	Namespace: red_boss_battle
	Checksum: 0x5DDCD09E
	Offset: 0x9290
	Size: 0x1F6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c7a3202c(var_5f3b05e8)
{
	var_d1ac344a = function_3c2238ed(var_5f3b05e8);
	if(!var_d1ac344a)
	{
		/#
			if(getdvarint(#"zm_debug_ee", 0))
			{
				iprintlnbold("");
			}
		#/
		return false;
	}
	if(var_d1ac344a === self.var_c164e6c7)
	{
		return true;
	}
	switch(self.var_c164e6c7)
	{
		case 2:
		{
			if(var_d1ac344a == 3)
			{
				var_b0e2bf36 = #"hash_70d2133e90b0f3e2";
			}
			else
			{
				var_b0e2bf36 = #"hash_478f474f01271740";
			}
			break;
		}
		case 3:
		{
			if(var_d1ac344a == 1)
			{
				var_b0e2bf36 = #"hash_3f0053e3125f2677";
			}
			else
			{
				var_b0e2bf36 = #"hash_14823bee5bc7ad60";
			}
			break;
		}
		case 1:
		{
			if(var_d1ac344a == 3)
			{
				var_b0e2bf36 = #"hash_3aa6ddfb9edb64cb";
			}
			else
			{
				var_b0e2bf36 = #"hash_f8411f18f7324f6";
			}
			break;
		}
	}
	s_anchor = struct::get("angles_to_" + self.var_c164e6c7);
	s_anchor scene::play(var_b0e2bf36, level.s_boss_battle.var_d82d0e73);
	self.var_c164e6c7 = var_d1ac344a;
	return true;
}

/*
	Name: function_39dc3a09
	Namespace: red_boss_battle
	Checksum: 0xC2418781
	Offset: 0x9490
	Size: 0xBC
	Parameters: 1
	Flags: Private
*/
function private function_39dc3a09(e_target)
{
	v_angles = undefined;
	str_zone = e_target zm_zonemgr::get_player_zone();
	v_angles = 90;
	if(isdefined(str_zone))
	{
		switch(str_zone)
		{
			case "zone_boss_plateau_1":
			{
				v_angles = 200;
				break;
			}
			case "zone_boss_plateau_2":
			{
				v_angles = 90;
				break;
			}
			case "zone_boss_plateau_3":
			{
				v_angles = 309;
				break;
			}
		}
	}
	return (0, v_angles, 0);
}

/*
	Name: function_766fb0b1
	Namespace: red_boss_battle
	Checksum: 0x7ED90142
	Offset: 0x9558
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_766fb0b1(var_fd1c353a)
{
	a_enemies = level.ai[#"axis"];
	if(isdefined(a_enemies) && a_enemies.size)
	{
		a_potential_targets = array::get_all_closest(var_fd1c353a, a_enemies, undefined, undefined, 320);
		if(!isarray(a_potential_targets))
		{
			return;
		}
		var_ecfe5e20 = array::filter(a_potential_targets, 0, &function_6c856fde);
		if(var_ecfe5e20.size > 0)
		{
			foreach(zombie in var_ecfe5e20)
			{
				if(isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area)
				{
					zombie zombie_utility::setup_zombie_knockdown(var_fd1c353a);
				}
			}
		}
	}
}

/*
	Name: return_false
	Namespace: red_boss_battle
	Checksum: 0xC48A0C58
	Offset: 0x96C0
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function return_false()
{
	return false;
}

/*
	Name: function_85593a2
	Namespace: red_boss_battle
	Checksum: 0x2FA48D9
	Offset: 0x96D0
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function function_85593a2(v_point)
{
	b_check = 0;
	var_e25fe3db = spawn("script_origin", v_point);
	if(var_e25fe3db istouching(level.s_boss_battle.var_98ea549b))
	{
		b_check = 1;
	}
	var_e25fe3db delete();
	return b_check;
}

/*
	Name: function_bc717eee
	Namespace: red_boss_battle
	Checksum: 0xC03D947C
	Offset: 0x9760
	Size: 0x224
	Parameters: 1
	Flags: Linked
*/
function function_bc717eee(v_destination)
{
	e_sword = level.s_boss_battle.var_5e9e4c15;
	e_perseus = level.s_boss_battle.var_3edd432d;
	v_forward = anglestoforward(e_perseus.angles);
	level waittill(#"hash_2720cc1fa8b1f8e2");
	var_2ff979fa = spawn("script_model", v_destination);
	var_2ff979fa playsound(#"hash_4cc85ba1ffa59d0b");
	playfxontag(level._effect[#"hash_661c427afb24e5f2"], e_perseus, "tag_weapon_right");
	playfx(level._effect[#"hash_4d8d2bc22add9939"], var_2ff979fa.origin, v_forward, (1, 0, 0));
	level waittill(#"play_teleport_fx");
	playsoundatposition(#"hash_5e07cc4ee28c44e7", e_perseus.origin);
	playfx(level._effect[#"hash_65a9f0574c7cd2db"], var_2ff979fa.origin, v_forward, (1, 0, 0));
	playfx(level._effect[#"hash_3d64776928022f66"], e_perseus gettagorigin("j_spine4"), v_forward, (1, 0, 0));
	wait(2);
	var_2ff979fa delete();
}

/*
	Name: spawn_miniboss
	Namespace: red_boss_battle
	Checksum: 0xBEAFB348
	Offset: 0x9990
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function spawn_miniboss()
{
	if(math::cointoss(level.s_boss_battle.var_415fc88))
	{
		if(math::cointoss(60))
		{
			if(zm_ai_blight_father::function_858c7fa5())
			{
				zm_transform::function_bdd8aba6(#"blight_father");
				s_waitresult = undefined;
				s_waitresult = level waittilltimeout(10, #"transformation_complete");
				if(s_waitresult._notify != "timeout")
				{
					function_8b1f9518();
				}
			}
		}
		else if(zombie_gegenees_util::function_48c60fc2())
		{
			str_scene = array::random(level.s_boss_battle.var_2624492f);
			level scene::play(str_scene, "targetname");
			function_8b1f9518();
		}
	}
}

/*
	Name: function_6c856fde
	Namespace: red_boss_battle
	Checksum: 0xC1A83CEE
	Offset: 0x9AE0
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function function_6c856fde(e_zombie)
{
	if(e_zombie.var_6f84b820 == #"basic")
	{
		return true;
	}
	return false;
}

/*
	Name: on_player_connect
	Namespace: red_boss_battle
	Checksum: 0x634F2A46
	Offset: 0x9B18
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	foreach(var_de3a312c in level.var_3958c9ff)
	{
		self thread zm_red_fasttravel::function_28deccf1(var_de3a312c, 1);
	}
}

/*
	Name: function_6401a80e
	Namespace: red_boss_battle
	Checksum: 0x6C0FAB0D
	Offset: 0x9BA8
	Size: 0x4FE
	Parameters: 0
	Flags: Linked
*/
function function_6401a80e()
{
	self notify("1306ae5632c8627a");
	self endon("1306ae5632c8627a");
	self endon(#"death");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"hash_1c35eb15aa210d6", #"fasttravel_finished", #"hash_178a3d0115bc972e");
		if(!isdefined(s_notify.var_9fa6220c) || !isdefined(s_notify.var_9fa6220c.script_noteworthy) || s_notify.var_9fa6220c.script_noteworthy != "traverse")
		{
			continue;
		}
		var_e1284bee = s_notify.var_9fa6220c.s_loc;
		if(!isdefined(var_e1284bee.var_f0bbde5))
		{
			foreach(s_loc in level.var_4775015b)
			{
				if(s_loc.script_string === var_e1284bee.var_7fe26499)
				{
					var_e1284bee.var_f0bbde5 = s_loc;
					break;
				}
			}
		}
		var_f0bbde5 = var_e1284bee.var_f0bbde5;
		var_2d54d86e = s_notify.var_9fa6220c.var_85e825a7;
		switch(s_notify._notify)
		{
			case "hash_1c35eb15aa210d6":
			{
				if(isdefined(var_2d54d86e))
				{
					level flag::set(var_2d54d86e);
				}
				if(!isdefined(self.var_362f68d6))
				{
					self.var_362f68d6 = randomintrange(0, 4);
				}
				if(!self.var_362f68d6)
				{
					n_char_index = self zm_characters::function_d35e4c92();
					str_vo_alias = "vox_plateau_jump_plr_" + n_char_index;
					a_variants = zm_audio::get_valid_lines(str_vo_alias);
					self.var_2790fd8b thread zm_vo::vo_say(array::random(a_variants), 0, 1, 9999);
					self.var_362f68d6 = function_21a3a673(4, 8);
				}
				else
				{
					self.var_362f68d6--;
				}
				if(!(isdefined(var_e1284bee.var_5a099a2d) && var_e1284bee.var_5a099a2d) && (!(isdefined(var_e1284bee.var_151f9e4b) && var_e1284bee.var_151f9e4b)))
				{
					self zm_red_fasttravel::function_28deccf1(var_e1284bee, 2);
				}
				break;
			}
			case "fasttravel_finished":
			{
				if(isdefined(var_e1284bee.var_151f9e4b) && var_e1284bee.var_151f9e4b || (isdefined(var_f0bbde5.var_151f9e4b) && var_f0bbde5.var_151f9e4b))
				{
					var_e1284bee.unitrigger_stub thread util::delay_notify(0.1, "cancel_fasttravel_cooldown");
					var_f0bbde5.unitrigger_stub thread util::delay_notify(0.1, "cancel_fasttravel_cooldown");
				}
				else if(!(isdefined(var_f0bbde5.var_5a099a2d) && var_f0bbde5.var_5a099a2d))
				{
					self zm_red_fasttravel::function_28deccf1(var_f0bbde5, 2);
				}
				break;
			}
			case "hash_178a3d0115bc972e":
			{
				if(!(isdefined(var_e1284bee.var_5a099a2d) && var_e1284bee.var_5a099a2d))
				{
					self zm_red_fasttravel::function_28deccf1(var_e1284bee, 1);
				}
				if(!(isdefined(var_f0bbde5.var_5a099a2d) && var_f0bbde5.var_5a099a2d))
				{
					self zm_red_fasttravel::function_28deccf1(var_f0bbde5, 1);
				}
				break;
			}
		}
	}
}

/*
	Name: function_5fc81f0a
	Namespace: red_boss_battle
	Checksum: 0xAC4CCECE
	Offset: 0xA0B0
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_5fc81f0a(e_target)
{
	zm_weap_hand_charon::function_5fc81f0a(e_target);
	zm_weap_hand_gaia::function_5fc81f0a(e_target);
	zm_weap_hand_hemera::function_5fc81f0a(e_target);
	zm_weap_hand_ouranos::function_5fc81f0a(e_target);
	s_result = undefined;
	s_result = level waittill(#"hash_4be6553c5ac0ec2b", #"boss_stunned", #"hash_18dd51d5a10476a3", #"hash_78452700119fc913", #"hash_7646638df88a3656");
	zm_weap_hand_charon::function_6d783edd(e_target);
	zm_weap_hand_gaia::function_6d783edd(e_target);
	zm_weap_hand_hemera::function_6d783edd(e_target);
	zm_weap_hand_ouranos::function_6d783edd(e_target);
}

/*
	Name: function_1722dae1
	Namespace: red_boss_battle
	Checksum: 0x1DC147D9
	Offset: 0xA1F0
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function function_1722dae1()
{
	self notify("4fe6867b112381d6");
	self endon("4fe6867b112381d6");
	level endon(#"hash_71d7e6a55a1ca9e");
	self endon(#"death");
	while(true)
	{
		s_waitresult = undefined;
		s_waitresult = self waittill(#"aoe_damage");
		if(s_waitresult.var_159100b7 == "zm_aoe_chaos_bolt" || s_waitresult.var_159100b7 == "zm_aoe_chaos_bolt_2")
		{
			self status_effect::status_effect_apply(level.s_boss_battle.var_b42f3b39, undefined, level.s_boss_battle.var_3edd432d, 0, 3000);
			zm_hero_weapon::function_3fe4a02e(self, 50);
		}
		else if(s_waitresult.var_159100b7 == "zm_aoe_strafe_storm")
		{
			self status_effect::status_effect_apply(level.s_boss_battle.var_86d9f46c);
			self clientfield::increment_to_player("" + #"hash_3bb8b5cda11eecc6");
		}
	}
}

/*
	Name: function_4c17036d
	Namespace: red_boss_battle
	Checksum: 0xCF1A4FE8
	Offset: 0xA360
	Size: 0x74
	Parameters: 2
	Flags: Linked, Private
*/
function private function_4c17036d(e_attacker, b_hero_weapon = 0)
{
	if(!isdefined(self.var_4bb78ac7) || gettime() > self.var_4bb78ac7)
	{
		self.var_4bb78ac7 = gettime() + 100;
		e_attacker util::show_hit_marker(b_hero_weapon);
	}
}

/*
	Name: stat_tracker_setup
	Namespace: red_boss_battle
	Checksum: 0xB3975B7E
	Offset: 0xA3E0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function stat_tracker_setup(b_skipped)
{
	level endon(#"end_game", #"stat_tracker" + "_ended_early");
	while(!level flag::exists(#"hash_5a7f1f9adac6dc8c") || !level flag::exists(#"boss_battle_complete"))
	{
		wait(1);
	}
	level flag::wait_till_all(array(#"hash_5a7f1f9adac6dc8c", #"boss_battle_complete"));
}

/*
	Name: stat_tracker_cleanup
	Namespace: red_boss_battle
	Checksum: 0x3F85189C
	Offset: 0xA4C0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function stat_tracker_cleanup(b_skipped, var_19e802fa)
{
	level flag::set(#"boss_battle_complete");
}

/*
	Name: function_60d4faca
	Namespace: red_boss_battle
	Checksum: 0x437FA88C
	Offset: 0xA500
	Size: 0x218
	Parameters: 1
	Flags: Linked
*/
function function_60d4faca(a_s_valid_respawn_points)
{
	var_e124a4eb = [];
	foreach(s_respawn_point in a_s_valid_respawn_points)
	{
		if(s_respawn_point.script_noteworthy == "zone_boss_plateau_2")
		{
			if(!isdefined(var_e124a4eb))
			{
				var_e124a4eb = [];
			}
			else if(!isarray(var_e124a4eb))
			{
				var_e124a4eb = array(var_e124a4eb);
			}
			var_e124a4eb[var_e124a4eb.size] = s_respawn_point;
		}
		if(s_respawn_point.script_noteworthy == "zone_boss_plateau_3" && !level flag::get(#"hash_3e2ec7f6fb6b50c9"))
		{
			if(!isdefined(var_e124a4eb))
			{
				var_e124a4eb = [];
			}
			else if(!isarray(var_e124a4eb))
			{
				var_e124a4eb = array(var_e124a4eb);
			}
			var_e124a4eb[var_e124a4eb.size] = s_respawn_point;
		}
		if(s_respawn_point.script_noteworthy == "zone_boss_plateau_1" && !level flag::get(#"hash_3e2ec4f6fb6b4bb0"))
		{
			if(!isdefined(var_e124a4eb))
			{
				var_e124a4eb = [];
			}
			else if(!isarray(var_e124a4eb))
			{
				var_e124a4eb = array(var_e124a4eb);
			}
			var_e124a4eb[var_e124a4eb.size] = s_respawn_point;
		}
	}
	return var_e124a4eb;
}

/*
	Name: function_9bc4f8cb
	Namespace: red_boss_battle
	Checksum: 0xF05A0AC
	Offset: 0xA720
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_9bc4f8cb()
{
	self.spectator_respawn = level.s_boss_battle.registersarah_defeated_gore_[self.playernum];
	self zm_player::spectator_respawn();
}

/*
	Name: cleanup_final
	Namespace: red_boss_battle
	Checksum: 0x96F28C7F
	Offset: 0xA768
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function cleanup_final()
{
	wait(1);
	foreach(ai_zombie in getaiteamarray(level.zombie_team))
	{
		if(isdefined(ai_zombie))
		{
			ai_zombie thread cleanup_zombie();
		}
	}
}

/*
	Name: cleanup_zombie
	Namespace: red_boss_battle
	Checksum: 0x7A5F5A69
	Offset: 0xA808
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function cleanup_zombie()
{
	self endon(#"death");
	self clientfield::increment("" + #"zombie_delete");
	self val::set("cleanup_zombie", "ignoreall", 1);
	wait(0.5);
	self delete();
}

/*
	Name: function_27486895
	Namespace: red_boss_battle
	Checksum: 0xDD3C16BE
	Offset: 0xA8A0
	Size: 0x15A
	Parameters: 1
	Flags: None
*/
function function_27486895(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_478165f86a3bc512":
			{
				level thread zm_red::function_71a6c3ea();
				level thread function_3a2efd4e(1);
				break;
			}
			case "hash_a12e7297235e57b":
			{
				level thread function_290d42b8(1);
				break;
			}
			case "hash_7fe81b8551badbeb":
			{
				level.s_boss_battle.var_5de58d03 = 1;
				break;
			}
			case "hash_4effcd324e5f7a28":
			{
				setdvar(#"hash_68b9a321eca18c32", 1);
				level thread function_99f0123d();
				break;
			}
			case "hash_1c090a7b2c262602":
			{
				setdvar(#"hash_68b9a321eca18c32", 0);
				level notify(#"hash_72be9b4e52b943b");
				break;
			}
		}
	#/
}

/*
	Name: function_d5a70078
	Namespace: red_boss_battle
	Checksum: 0x6B819220
	Offset: 0xAA08
	Size: 0xD8
	Parameters: 0
	Flags: None
*/
function function_d5a70078()
{
	/#
		var_cab6e065 = 0;
		var_9df8166f = 0;
		while(true)
		{
			if(!var_cab6e065 && getdvarint(#"hash_336a4b6a4bdec400", 0))
			{
				var_cab6e065 = 1;
				function_2003ebc9(1);
			}
			if(!var_9df8166f && getdvarint(#"hash_2c5a53140f377a17", 0))
			{
				var_9df8166f = 1;
				function_2003ebc9(2);
			}
			wait(0.4);
		}
	#/
}

/*
	Name: function_213d02bd
	Namespace: red_boss_battle
	Checksum: 0x129F9B54
	Offset: 0xAAE8
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function function_213d02bd()
{
	/#
		self notify("");
		self endon("");
		self endon(#"death");
		while(true)
		{
			print3d(self.origin, "" + self.health, (1, 1, 0), 1, 2, 3);
			wait(0.1);
		}
	#/
}

/*
	Name: function_99f0123d
	Namespace: red_boss_battle
	Checksum: 0x644160B6
	Offset: 0xAB78
	Size: 0x28A
	Parameters: 0
	Flags: None
*/
function function_99f0123d()
{
	/#
		self notify("");
		self endon("");
		level endon(#"hash_72be9b4e52b943b");
		while(true)
		{
			foreach(n_index, e_player in util::get_active_players(#"allies"))
			{
				n_y_pos = 480 + (18.7 * n_index);
				var_533a2398 = function_9e72a96(e_player.var_b708af7b);
				if(!isdefined(level.s_boss_battle.var_5015427))
				{
					n_total_damage = 0;
				}
				else
				{
					n_total_damage = level.s_boss_battle.var_5015427[e_player.playernum];
				}
				if(!isdefined(n_total_damage))
				{
					n_total_damage = 0;
				}
				if(!isdefined(var_533a2398))
				{
					var_533a2398 = "";
				}
				debug2dtext((120, n_y_pos, 0), ("" + n_index) + "", (1, 1, 0), 1, (0, 0, 0), 0.4, 1, 2);
				debug2dtext((120 + 100, n_y_pos, 0), var_533a2398, (1, 1, 1), 1, (0, 0, 0), 0.4, 1, 2);
				debug2dtext((120 + 240, n_y_pos, 0), n_total_damage, (1, 0, 0), 1, (0, 0, 0), 0.4, 1, 2);
			}
			waitframe(2);
		}
	#/
}

