// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm\weapons\zm_weap_tomahawk.gsc;
#using script_190d6b82bcca0908;
#using scripts\core_common\bots\bot.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\abilities\ability_player.gsc;
#using scripts\core_common\bots\bot_util.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_bgb_pack.gsc;
#using script_668c4fbb94671fb4;
#using scripts\zm_common\zm_sq.gsc;
#using script_7c62f55ce3a557ff;
#using script_ab862743b3070a;
#using scripts\zm\weapons\zm_weap_spectral_shield.gsc;
#using scripts\zm_common\zm_characters.gsc;
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
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_escape_util.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_challenges.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_69ddf44f;

/*
	Name: init
	Namespace: namespace_69ddf44f
	Checksum: 0xC7502DA9
	Offset: 0x1200
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfield();
	init_flags();
	init_fx();
	function_3335f286();
	scene::add_scene_func(#"p8_fxanim_zm_esc_lab_map_burning_bundle", &function_512a6b36, "init");
	callback::on_connect(&function_4baf619f);
}

/*
	Name: main
	Namespace: namespace_69ddf44f
	Checksum: 0x754902B2
	Offset: 0x12A8
	Size: 0x2CC
	Parameters: 0
	Flags: Linked
*/
function main()
{
	var_96e39e55 = getent("w_h_h_d_clip", "targetname");
	var_96e39e55 disconnectpaths();
	var_669d3a02 = getentarray("mdl_p_s_4_clip", "script_noteworthy");
	foreach(mdl_clip in var_669d3a02)
	{
		mdl_clip notsolid();
	}
	var_571f1eb4 = getent("w_h_f_d", "targetname");
	var_571f1eb4 hide();
	level thread function_a90b7995();
	level flag::wait_till("start_zombie_round_logic");
	exploder::exploder("fxexp_poison_ambient");
	exploder::exploder("fxexp_lighthouse_light");
	var_ebdd41e3 = struct::get("s_p_s1_w_b");
	var_9a23b2c6 = var_ebdd41e3.scene_ents[#"door"];
	if(isdefined(var_9a23b2c6))
	{
		var_9a23b2c6 hidepart("tag_wall_damaged");
		var_9a23b2c6 hidepart("tag_wall_destroyed");
	}
	if(zm_utility::function_e51dc2d8())
	{
		if(!isdefined(level.var_f7febee4))
		{
			level namespace_a9aa9d72::function_18b599e0();
		}
		zm_sq::start(#"hash_62ca600e9c6f07c0");
	}
	hidemiscmodels("mechanical_chair");
	var_b05e79d7 = getent("mechanical_chair", "targetname");
	var_b05e79d7 hide();
}

/*
	Name: init_clientfield
	Namespace: namespace_69ddf44f
	Checksum: 0xEFF45276
	Offset: 0x1580
	Size: 0x6C4
	Parameters: 0
	Flags: Linked
*/
function init_clientfield()
{
	var_440ad52e = getminbitcountfornum(6);
	clientfield::register("scriptmover", "" + #"dm_energy", 1, var_440ad52e, "int");
	clientfield::register("scriptmover", "" + #"hash_1f572bbcdde55d9d", 1, getminbitcountfornum(5), "int");
	clientfield::register("scriptmover", "" + #"hash_4bea78fdf78a2613", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"orb_explosion", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_6e2f9a57d1bc4b6a", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"ritual_gobo", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"seagull_fx", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_7c708a514455bf88", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_592c96b2803d9fd5", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"summoning_key_glow", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_2b6e463a7a482630", 1, 1, "counter");
	clientfield::register("actor", "" + #"hash_29d283d7f747d358", 1, 1, "counter");
	clientfield::register("actor", "" + #"hash_df589cc30f4c7dd", 1, 1, "int");
	clientfield::register("allplayers", "" + #"hash_4f58771e117ee3ee", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_2928b6d60aaacda6", 1, getminbitcountfornum(7), "int");
	clientfield::register("world", "" + #"attic_room", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_670a34b297f8faca", 1, 1, "int");
	clientfield::register("toplayer", "" + #"duffel_prison", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_1ee540924e569350", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_27db1707c088563c", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_376c030aee1d6ccb", 1, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_201ef69f0a0a5dce", 1, 1, "int");
	clientfield::register("allplayers", "" + #"hash_b8601726e1e4a6a", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_624198b41791933f", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_5cab8aa95fc9ea84", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_506164c22c4c7ca8", 1, 1, "counter");
}

/*
	Name: init_flags
	Namespace: namespace_69ddf44f
	Checksum: 0x2A1EE3A1
	Offset: 0x1C50
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_379fc22ed85f0dbc");
	level flag::init(#"hash_68a1656980e771da");
	level flag::init(#"main_quest_completed");
	level flag::init(#"hash_4fac802bd5dcebf4");
	level flag::init(#"hash_40e9ad323fe8402a");
	level flag::init(#"hash_36138b6e1d539829");
	level flag::init(#"hash_6048c3f423fd987");
	level flag::init(#"hash_61bba9aa86f61865");
	level flag::init(#"hash_3cc421108aedf47f");
	level flag::init(#"dm_ready");
	level flag::init(#"hash_1b4b6ce05cb62d56");
	level flag::init(#"hash_3d16465b22e70170");
	level flag::init(#"richtofen_sacrifice");
	level flag::init(#"hash_68923445ebf488f0");
	level flag::init(#"hash_12a631be319641a1");
	level flag::init(#"hash_7680c620ba7315e5");
	level flag::init(#"hash_73b06a8a2c0b0e8d");
	level flag::init(#"hash_8c500dbad4c6edb");
}

/*
	Name: init_fx
	Namespace: namespace_69ddf44f
	Checksum: 0x80F724D1
	Offset: 0x1EA0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
}

/*
	Name: function_3335f286
	Namespace: namespace_69ddf44f
	Checksum: 0xB272C36
	Offset: 0x1EB0
	Size: 0x35C
	Parameters: 0
	Flags: Linked
*/
function function_3335f286()
{
	zm_vo::function_577efa88(5);
	zm_vo::function_577efa88(6);
	zm_vo::function_577efa88(7);
	zm_sq::register(#"hash_62ca600e9c6f07c0", #"1", #"hash_53dd4dd26004594b", &step_1, &step_1_cleanup);
	zm_sq::register(#"hash_62ca600e9c6f07c0", #"2", #"hash_53dd4ed260045afe", &step_2, &step_2_cleanup);
	zm_sq::register(#"hash_62ca600e9c6f07c0", #"3", #"hash_53dd4fd260045cb1", &step_3, &step_3_cleanup);
	zm_sq::register(#"hash_62ca600e9c6f07c0", #"4", #"hash_53dd50d260045e64", &step_4, &step_4_cleanup);
	zm_sq::register(#"hash_62ca600e9c6f07c0", #"5", #"hash_53dd51d260046017", &step_5, &step_5_cleanup);
	zm_sq::register(#"hash_62ca600e9c6f07c0", #"6", #"hash_53dd52d2600461ca", &step_6, &step_6_cleanup);
	zm_sq::register(#"hash_62ca600e9c6f07c0", #"7", #"hash_53dd53d26004637d", &step_7, &step_7_cleanup);
	zm_sq::register(#"hash_62ca600e9c6f07c0", #"outro", #"hash_4b2d3fa2839cfcf8", &outro, &outro_cleanup, 1, &function_f7a9d7c4);
}

/*
	Name: function_4baf619f
	Namespace: namespace_69ddf44f
	Checksum: 0x99AC0DBB
	Offset: 0x2218
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_4baf619f()
{
	level flag::wait_till(#"all_players_spawned");
	if(isdefined(self))
	{
		self thread function_357117bc();
	}
}

/*
	Name: function_357117bc
	Namespace: namespace_69ddf44f
	Checksum: 0xB65A4C74
	Offset: 0x2268
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_357117bc()
{
	self endon(#"disconnect");
	self waittill(#"perk_acquired");
	self.var_6257071f = 1;
}

/*
	Name: step_1
	Namespace: namespace_69ddf44f
	Checksum: 0xE7D80EF5
	Offset: 0x22A8
	Size: 0x6B4
	Parameters: 1
	Flags: Linked
*/
function step_1(var_a276c861)
{
	level flag::wait_till(#"all_players_spawned");
	/#
		level thread function_db632f7();
		level thread function_676ccd91();
		level thread function_e15cfd01();
	#/
	var_96e39e55 = getent("w_h_h_d_clip_m", "targetname");
	var_ebdd41e3 = struct::get("s_p_s1_w_b");
	var_9a23b2c6 = var_ebdd41e3.scene_ents[#"door"];
	var_9a23b2c6 hidepart("tag_wall_damaged");
	var_9a23b2c6 hidepart("tag_wall_destroyed");
	var_96e39e55 setcandamage(1);
	var_96e39e55.health = 100000000;
	var_96e39e55 thread function_c4299d51();
	level waittill(#"hash_4aedd2f50e5e307");
	var_ebdd41e3 scene::play("damaged");
	var_9a23b2c6 playloopsound(#"hash_323e5cd99357925a");
	var_96e39e55 thread function_6578dc64();
	s_result = undefined;
	s_result = level waittill(#"hash_703a48e58dfd43d6");
	if(isdefined(s_result.var_ad2b4afb))
	{
		level.var_dcdad7b1 = s_result.var_ad2b4afb;
	}
	if(isalive(s_result.e_brutus))
	{
		s_result.e_brutus thread function_b4ab4a64();
	}
	var_d388f9de = struct::get(#"hash_1fb558842bdc2690");
	var_db15362c = var_d388f9de.scene_ents[#"prop 1"];
	var_db15362c clientfield::set("" + #"hash_376c030aee1d6ccb", 1);
	level thread function_1f975a04();
	var_38e9df50 = struct::get(#"s_r_w_a_r");
	var_38e9df50 scene::init();
	level clientfield::set("" + #"attic_room", 1);
	if(!isdefined(level.var_dcdad7b1))
	{
		level.var_dcdad7b1 = util::spawn_model("tag_origin", var_96e39e55.origin);
	}
	level.var_dcdad7b1 thread function_bb44b334();
	level.var_dcdad7b1 playsound(#"hash_25a9868631824fea");
	var_9a23b2c6 stoploopsound();
	music::setmusicstate("escape_attic");
	var_ebdd41e3 thread scene::play("destroyed");
	var_15d876af = getent("w_h_h_d_clip", "targetname");
	var_15d876af connectpaths();
	var_15d876af notsolid();
	var_96e39e55 connectpaths();
	var_96e39e55 notsolid();
	zm_zonemgr::enable_zone("zone_warden_home");
	level flag::set("activate_warden_house_2_attic");
	level thread scene::init("s_r_w_a_r");
	level thread scene::init_streamer(#"p8_fxanim_zm_esc_wardensattic_reveal_bundle", #"allies", 0, 0);
	s_orb = struct::get("s_house_orb");
	s_orb.var_b7eee573 = util::spawn_model(#"p8_zm_esc_orb_red_small", s_orb.origin, s_orb.angles);
	s_orb.s_unitrigger_stub = s_orb zm_unitrigger::create("", 48, &function_1af254ac);
	var_f65b874a = struct::get("s_ch_sw");
	var_f65b874a.s_unitrigger_stub = var_f65b874a zm_unitrigger::function_fac87205("", 64);
	level thread function_cf51e21a();
	level flag::wait_till_all(array(#"hash_61bba9aa86f61865", #"hash_379fc22ed85f0dbc"));
	level.var_dcdad7b1 delete();
}

/*
	Name: step_1_cleanup
	Namespace: namespace_69ddf44f
	Checksum: 0x5047BF2F
	Offset: 0x2968
	Size: 0x71E
	Parameters: 2
	Flags: Linked
*/
function step_1_cleanup(var_a276c861, var_19e802fa)
{
	level flag::set(#"hash_40e9ad323fe8402a");
	var_ebdd41e3 = struct::get("s_p_s1_w_b");
	var_9a23b2c6 = var_ebdd41e3.scene_ents[#"door"];
	var_96e39e55 = getent("w_h_h_d_clip", "targetname");
	if(var_a276c861 || var_19e802fa)
	{
		if(!isdefined(level.var_659daf1d))
		{
			level.var_659daf1d = [];
		}
		else if(!isarray(level.var_659daf1d))
		{
			level.var_659daf1d = array(level.var_659daf1d);
		}
		if(!isinarray(level.var_659daf1d, "tag_socket_f"))
		{
			level.var_659daf1d[level.var_659daf1d.size] = "tag_socket_f";
		}
		var_ebdd41e3 scene::play("damaged");
		var_ebdd41e3 scene::play("destroyed");
		if(!zm_zonemgr::zone_is_enabled("zone_warden_home"))
		{
			var_96e39e55 connectpaths();
			zm_zonemgr::enable_zone("zone_warden_home");
			level flag::set("activate_warden_house_2_attic");
		}
		var_d388f9de = struct::get(#"hash_1fb558842bdc2690");
		var_db15362c = var_d388f9de.scene_ents[#"prop 1"];
		var_db15362c clientfield::set("" + #"hash_376c030aee1d6ccb", 2);
		var_d7cbafba = struct::get(#"hash_32ae80e5cfea37c3");
		if(!isdefined(var_d7cbafba.mdl_fx))
		{
			var_d7cbafba.mdl_fx = util::spawn_model(#"tag_origin", var_d7cbafba.origin, var_d7cbafba.angles);
			var_d7cbafba.mdl_fx clientfield::set("" + #"hash_201ef69f0a0a5dce", 1);
		}
	}
	if(var_a276c861 || var_19e802fa)
	{
		exploder::kill_exploder("fxexp_lighthouse_light");
		var_de399497 = struct::get("k_fx_pos");
		var_de399497 thread function_9e723e9();
		level clientfield::set("" + #"attic_room", 1);
		var_d388f9de = struct::get(#"hash_1fb558842bdc2690");
		var_d388f9de thread scene::play();
		level thread scene::skipto_end("s_r_w_a_r", "Main & Idle Loop Out");
	}
	var_7034e8dd = getent("w_h_f", "targetname");
	var_f7afe1a0 = getent("w_h_f_d", "targetname");
	var_f7afe1a0 show();
	if(isdefined(var_7034e8dd))
	{
		var_7034e8dd delete();
	}
	var_96e39e55 delete();
	var_15d876af = getent("w_h_h_d_clip_m", "targetname");
	var_15d876af delete();
	if(isdefined(level.var_dcdad7b1))
	{
		level.var_dcdad7b1 delete();
		level.var_dcdad7b1 = undefined;
	}
	s_orb = struct::get("s_house_orb");
	if(isdefined(s_orb.var_b7eee573))
	{
		s_orb.var_b7eee573 delete();
	}
	if(isdefined(s_orb.s_unitrigger_stub))
	{
		zm_unitrigger::unregister_unitrigger(s_orb.s_unitrigger_stub);
	}
	var_f65b874a = struct::get("s_ch_sw");
	if(isdefined(var_f65b874a.s_unitrigger_stub))
	{
		zm_unitrigger::unregister_unitrigger(var_f65b874a.s_unitrigger_stub);
	}
	if(level flag::exists(#"hash_61bba9aa86f61865"))
	{
		level flag::delete(#"hash_61bba9aa86f61865");
	}
	if(level flag::exists(#"hash_379fc22ed85f0dbc"))
	{
		level flag::delete(#"hash_379fc22ed85f0dbc");
	}
	foreach(e_player in util::get_active_players())
	{
		if(isdefined(e_player.var_b5fbfab4) && e_player.var_b5fbfab4)
		{
			e_player.var_b5fbfab4 = undefined;
		}
	}
}

/*
	Name: function_d66bb9e
	Namespace: namespace_69ddf44f
	Checksum: 0x4D872A79
	Offset: 0x3090
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_d66bb9e()
{
	level endon(#"hash_6da514c90059d5c2");
	wait(16);
	function_314447b(0);
}

/*
	Name: function_c4299d51
	Namespace: namespace_69ddf44f
	Checksum: 0x65803907
	Offset: 0x30D0
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_c4299d51()
{
	level endon(#"hash_53dd4dd26004594b" + "_completed", #"hash_53dd4dd26004594b" + "_skipped_over", #"hash_53dd4dd26004594b" + "_ended_early", #"hash_4aedd2f50e5e307");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"damage");
		if(s_result.weapon == getweapon(#"spoon_alcatraz") || s_result.weapon == getweapon(#"spork_alcatraz") || s_result.weapon == getweapon(#"golden_knife") || s_result.weapon == getweapon(#"spknifeork"))
		{
			self playsound(#"hash_10dad884ca70c23d");
			level notify(#"hash_4aedd2f50e5e307");
		}
	}
}

/*
	Name: function_6578dc64
	Namespace: namespace_69ddf44f
	Checksum: 0x8232F236
	Offset: 0x3268
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function function_6578dc64()
{
	level endon(#"hash_53dd4dd26004594b" + "_completed", #"hash_53dd4dd26004594b" + "_skipped_over", #"hash_53dd4dd26004594b" + "_ended_early", #"hash_703a48e58dfd43d6");
	var_5a5135e6 = struct::get("s_b_d_d_c");
	n_dist_sq_max = var_5a5135e6.radius * var_5a5135e6.radius;
	while(true)
	{
		s_result = undefined;
		s_result = level waittill(#"hash_79c0225ea09cd215", #"hash_7a4ba7676000c3c6");
		e_brutus = s_result.brutus;
		n_dist_sq = distance2dsquared(var_5a5135e6.origin, s_result.brutus.origin);
		if(n_dist_sq < n_dist_sq_max)
		{
			level notify(#"hash_703a48e58dfd43d6", {#hash_de86a1af:e_brutus});
		}
	}
}

/*
	Name: function_b4ab4a64
	Namespace: namespace_69ddf44f
	Checksum: 0xCC37480A
	Offset: 0x33F0
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b4ab4a64()
{
	self endon(#"death");
	self clientfield::set("brutus_spawn_clientfield", 0);
	wait(0.1);
	level thread zm_escape_util::function_37aed203(self, 0);
}

/*
	Name: function_bb44b334
	Namespace: namespace_69ddf44f
	Checksum: 0xE6FF9D2E
	Offset: 0x3450
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_bb44b334()
{
	wait(0.1);
	self ghost();
}

/*
	Name: function_1af254ac
	Namespace: namespace_69ddf44f
	Checksum: 0x2A3F9748
	Offset: 0x3480
	Size: 0x21A
	Parameters: 0
	Flags: Linked
*/
function function_1af254ac()
{
	level endon(#"hash_53dd4dd26004594b" + "_completed", #"hash_53dd4dd26004594b" + "_skipped_over", #"hash_53dd4dd26004594b" + "_ended_early");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		if(isplayer(s_result.activator) && isalive(s_result.activator))
		{
			self.stub.related_parent.var_b7eee573 ghost();
			if(!isdefined(level.var_659daf1d))
			{
				level.var_659daf1d = [];
			}
			else if(!isarray(level.var_659daf1d))
			{
				level.var_659daf1d = array(level.var_659daf1d);
			}
			if(!isinarray(level.var_659daf1d, "tag_socket_f"))
			{
				level.var_659daf1d[level.var_659daf1d.size] = "tag_socket_f";
			}
			level flag::set(#"hash_61bba9aa86f61865");
			playsoundatposition(#"hash_6aa220e65103f345", self.origin);
			s_result.activator thread zm_audio::create_and_play_dialog(#"component_pickup", #"generic");
			return;
		}
	}
}

/*
	Name: function_cf51e21a
	Namespace: namespace_69ddf44f
	Checksum: 0x3E2D7AB6
	Offset: 0x36A8
	Size: 0x2AC
	Parameters: 0
	Flags: Linked
*/
function function_cf51e21a()
{
	var_d388f9de = struct::get(#"hash_1fb558842bdc2690");
	var_d388f9de thread scene::play();
	playsoundatposition(#"hash_4731813c2e1aa578", var_d388f9de.origin);
	wait(0.5);
	var_db15362c = var_d388f9de.scene_ents[#"prop 1"];
	var_db15362c clientfield::set("" + #"hash_376c030aee1d6ccb", 2);
	var_d7cbafba = struct::get(#"hash_32ae80e5cfea37c3");
	var_d7cbafba.mdl_fx = util::spawn_model(#"tag_origin", var_d7cbafba.origin, var_d7cbafba.angles);
	var_d7cbafba.mdl_fx clientfield::set("" + #"hash_201ef69f0a0a5dce", 1);
	function_314447b(1);
	var_f7afe1a0 = getent("w_h_f_d", "targetname");
	var_f7afe1a0 show();
	exploder::kill_exploder("fxexp_lighthouse_light");
	var_de399497 = struct::get("k_fx_pos");
	var_de399497 thread function_9e723e9();
	level thread scene::play("s_r_w_a_r", "Main & Idle Loop Out");
	wait(4.8);
	var_7034e8dd = getent("w_h_f", "targetname");
	var_7034e8dd hide();
	wait(1);
	level thread function_fc4ee98b();
}

/*
	Name: function_1f975a04
	Namespace: namespace_69ddf44f
	Checksum: 0x7F09F161
	Offset: 0x3960
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_1f975a04()
{
	level endon(#"hash_40e9ad323fe8402a");
	e_player = array::random(util::get_active_players());
	str_zone = e_player zm_zonemgr::get_player_zone();
	while(!isalive(e_player) || str_zone !== "zone_warden_home")
	{
		wait(0.1);
		e_player = array::random(util::get_active_players());
		str_zone = e_player zm_zonemgr::get_player_zone();
	}
	zm_vo::function_3c173d37(e_player.origin, 512);
	e_player thread zm_vo::function_a2bd5a0c(#"hash_68b4a0bee89499a7");
}

/*
	Name: function_fc4ee98b
	Namespace: namespace_69ddf44f
	Checksum: 0x1DE15200
	Offset: 0x3A90
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function function_fc4ee98b()
{
	level endon(#"hash_40e9ad323fe8402a");
	e_player = function_b3b2516a();
	zm_vo::function_3c173d37(e_player.origin, 512);
	e_player thread zm_vo::function_a2bd5a0c(#"hash_61bd637d16f1ea90");
	n_length = getanimlength(#"hash_32b13c90c94b5fed") - 6;
	wait(n_length);
	e_player = function_b3b2516a();
	e_richtofen = function_b1203924();
	if(isalive(e_richtofen))
	{
		if(util::get_active_players().size > 1)
		{
			e_player = array::random(util::get_active_players());
			while(e_player == e_richtofen)
			{
				e_player = array::random(util::get_active_players());
				wait(0.1);
			}
			zm_vo::function_3c173d37(e_player.origin, 512);
			e_player zm_vo::function_a2bd5a0c(#"hash_69e992122611c96f", 0, 1, 9999);
		}
		if(isalive(e_richtofen))
		{
			zm_vo::function_3c173d37(e_richtofen.origin, 512);
			e_richtofen zm_vo::function_a2bd5a0c(#"hash_69e992122611c96f", 0, 1, 9999);
		}
	}
	else
	{
		e_player = array::random(util::get_active_players());
		zm_vo::function_3c173d37(e_player.origin, 512);
		e_player zm_vo::function_a2bd5a0c(#"hash_69e992122611c96f");
	}
	level thread function_952c0e76();
	level thread function_d66bb9e();
	level flag::set(#"hash_379fc22ed85f0dbc");
}

/*
	Name: function_952c0e76
	Namespace: namespace_69ddf44f
	Checksum: 0x92D7676E
	Offset: 0x3D88
	Size: 0x3AC
	Parameters: 0
	Flags: Linked
*/
function function_952c0e76()
{
	level endon(#"hash_11fb44a7b531b27d");
	wait(3);
	e_richtofen = function_b1203924();
	if(!isdefined(e_richtofen) || !isalive(e_richtofen) || (!(isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6)))
	{
		return;
	}
	e_richtofen endon(#"disconnect", #"death");
	e_richtofen zm_vo::vo_stop();
	b_play_vo = e_richtofen zm_vo::vo_say(#"hash_5ef24b746faa2e43", 0, 1, 9999, 1, 1, 1);
	if(b_play_vo)
	{
		zm_vo::function_3c173d37(e_richtofen.origin, 512);
		b_play_vo = e_richtofen zm_vo::function_a2bd5a0c(#"hash_31282f9cdf8f5f22", 0, 1, 9999);
	}
	if(b_play_vo)
	{
		e_richtofen zm_vo::vo_stop();
		b_play_vo = e_richtofen zm_vo::vo_say(#"hash_54b5a3377a36a0cd", 0, 1, 9999, 1, 1, 1);
		if(b_play_vo)
		{
			zm_vo::function_3c173d37(e_richtofen.origin, 512);
			b_play_vo = e_richtofen zm_vo::function_a2bd5a0c(#"hash_31282d9cdf8f5bbc", 0, 1, 9999);
		}
		if(b_play_vo)
		{
			e_richtofen zm_vo::vo_stop();
			b_play_vo = e_richtofen zm_vo::vo_say(#"hash_65d3caef1dcbd8af", 0, 1, 9999, 1, 1, 1);
			if(b_play_vo)
			{
				zm_vo::function_3c173d37(e_richtofen.origin, 512);
				b_play_vo = e_richtofen zm_vo::function_a2bd5a0c(#"hash_31282b9cdf8f5856", 0, 1, 9999);
				if(b_play_vo && util::get_active_players().size > 1)
				{
					var_b63113d5 = function_b61881e5(e_richtofen);
					if(isdefined(var_b63113d5) && isalive(var_b63113d5))
					{
						zm_vo::function_3c173d37(var_b63113d5.origin, 512);
						b_play_vo = var_b63113d5 zm_vo::function_a2bd5a0c(#"hash_31282a9cdf8f56a3", 0, 1, 9999);
						if(b_play_vo)
						{
							zm_vo::function_3c173d37(e_richtofen.origin, 512);
							e_richtofen zm_vo::function_a2bd5a0c(#"hash_3128299cdf8f54f0", 0, 1, 9999);
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_b3b2516a
	Namespace: namespace_69ddf44f
	Checksum: 0xF4E5AB37
	Offset: 0x4140
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_b3b2516a()
{
	a_players = array::randomize(util::get_active_players());
	foreach(player in a_players)
	{
		str_zone = player zm_zonemgr::get_player_zone();
		if(isalive(player) && isdefined(str_zone) && str_zone != "zone_warden_home")
		{
			var_4cea0b02 = player;
			break;
		}
	}
	if(!isdefined(var_4cea0b02))
	{
		var_4cea0b02 = util::get_active_players()[0];
	}
	return var_4cea0b02;
}

/*
	Name: function_db632f7
	Namespace: namespace_69ddf44f
	Checksum: 0xC5687387
	Offset: 0x4268
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_db632f7()
{
	/#
		if(!getdvarint(#"zm_debug_ee", 0))
		{
			return;
		}
		zm_devgui::add_custom_devgui_callback(&function_69864bdb);
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_69864bdb
	Namespace: namespace_69ddf44f
	Checksum: 0x174B18A0
	Offset: 0x42F8
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function function_69864bdb(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_17435d3d0cb6939a":
			{
				level notify(#"hash_4aedd2f50e5e307");
				break;
			}
			case "hash_17435c3d0cb691e7":
			{
				level notify(#"hash_703a48e58dfd43d6");
				break;
			}
		}
	#/
}

/*
	Name: step_2
	Namespace: namespace_69ddf44f
	Checksum: 0xA67B6E91
	Offset: 0x4378
	Size: 0x39C
	Parameters: 1
	Flags: Linked
*/
function step_2(var_a276c861)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_7629706a5a9c7bf7", 2);
	if(var_a276c861)
	{
		return;
	}
	if(!isinarray(level.var_dd650b0e, "tag_socket_f"))
	{
		var_c699e2b5 = struct::get("s_p_s2_ins");
		var_c699e2b5.s_unitrigger_stub waittill(#"hash_4c6ab2a4a99f9539");
	}
	var_a5bc0a8b = struct::get("s_p_s2_b");
	var_a5bc0a8b.scene_ents[#"book"] clientfield::set("" + #"hash_6e2f9a57d1bc4b6a", 1);
	var_a5bc0a8b thread scene::play("start");
	var_eec33496 = struct::get("s_p_s2_b_en_po");
	var_64c09f7f = var_eec33496 zm_unitrigger::function_fac87205("", 64);
	if(isplayer(var_64c09f7f))
	{
		var_64c09f7f clientfield::increment_to_player("" + #"hash_5cab8aa95fc9ea84");
	}
	var_a5bc0a8b thread scene::play("IN");
	var_a5bc0a8b.scene_ents[#"book"] playsound(#"hash_4f48c064e6a29d9c");
	level notify(#"hash_6da514c90059d5c2");
	function_314447b(1);
	function_1798f59a(var_64c09f7f);
	function_dc04e77e();
	function_314447b(0);
	function_90d12e87();
	level thread scr_safehouse_testrageservice();
	var_de399497 = struct::get("k_fx_pos");
	var_64c09f7f = var_de399497 zm_unitrigger::function_fac87205("", 64);
	level.var_bbc27d0e = util::spawn_model(#"hash_4c06bc763e373f0f", var_de399497.origin, var_de399497.angles);
	level.var_bbc27d0e playsound(#"hash_5109ee79a5d045f0");
	level thread function_314447b(1);
	function_9465204c(var_64c09f7f);
	level thread function_314447b(0);
}

/*
	Name: step_2_cleanup
	Namespace: namespace_69ddf44f
	Checksum: 0xCBEFF76A
	Offset: 0x4720
	Size: 0x366
	Parameters: 2
	Flags: Linked
*/
function step_2_cleanup(var_a276c861, var_19e802fa)
{
	level flag::set(#"hash_36138b6e1d539829");
	level thread function_314447b(0);
	level.var_487c1bca = undefined;
	callback::remove_on_connect(&function_a039c992);
	callback::remove_on_connect(&function_441abdeb);
	callback::remove_on_connect(&function_1875f44f);
	arrayremovevalue(level.a_tomahawk_pickup_funcs, &function_66677663);
	if(var_a276c861)
	{
		level thread function_e998f810("tag_socket_f");
	}
	var_2f3fca78 = struct::get("s_p_s2_gul");
	if(isdefined(var_2f3fca78.var_4527036f))
	{
		if(isdefined(var_2f3fca78.var_4527036f.var_99424b88))
		{
			var_2f3fca78.var_4527036f.var_99424b88 delete();
		}
		var_2f3fca78.var_4527036f delete();
	}
	if(isdefined(level.var_dcc985c4))
	{
		if(isdefined(level.var_dcc985c4.mdl_prop))
		{
			level.var_dcc985c4.mdl_prop delete();
		}
		if(isdefined(level.var_dcc985c4.var_e5c7e01a))
		{
			level.var_dcc985c4.var_e5c7e01a delete();
		}
		level.var_dcc985c4 = undefined;
	}
	foreach(e_player in util::get_active_players())
	{
		if(isdefined(e_player.var_39de0c9f) && e_player.var_39de0c9f)
		{
			e_player.var_39de0c9f = undefined;
		}
	}
	var_de399497 = struct::get("k_fx_pos");
	if(isdefined(var_de399497.var_21841d64))
	{
		var_de399497.var_21841d64 delete();
	}
	if(!isdefined(level.var_bbc27d0e))
	{
		var_de399497 = struct::get("k_fx_pos");
		level.var_bbc27d0e = util::spawn_model(#"hash_4c06bc763e373f0f", var_de399497.origin, var_de399497.angles);
	}
}

/*
	Name: function_dc04e77e
	Namespace: namespace_69ddf44f
	Checksum: 0xDEE2EA6D
	Offset: 0x4A90
	Size: 0x56C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_dc04e77e()
{
	level endon(#"hash_36138b6e1d539829");
	var_2f3fca78 = struct::get("s_p_s2_gul");
	var_2f3fca78.mdl_origin = util::spawn_model("tag_origin", var_2f3fca78.origin, var_2f3fca78.angles);
	var_2f3fca78.var_4527036f = util::spawn_model(#"hash_91c31763b1101e6", var_2f3fca78.origin, var_2f3fca78.angles);
	var_2f3fca78.var_4527036f clientfield::set("" + #"hash_504d26c38b96651c", 1);
	var_2f3fca78.var_4527036f linkto(var_2f3fca78.mdl_origin);
	var_2f3fca78.var_4527036f playsound(#"hash_7839d08fa3b89f16");
	var_2f3fca78.mdl_origin scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "materialize", var_2f3fca78.var_4527036f);
	var_2f3fca78.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "attack", var_2f3fca78.var_4527036f);
	var_2f3fca78.var_4527036f waittill(#"att_fx");
	var_2f3fca78.var_4527036f clientfield::set("" + #"seagull_fx", 1);
	v_position = function_9cc082d2(var_2f3fca78.var_4527036f.origin, 512);
	if(isdefined(v_position))
	{
		var_2f3fca78.mdl_origin.var_99424b88 = util::spawn_model("tag_origin", v_position[#"point"], var_2f3fca78.var_4527036f.angles);
		var_2f3fca78.mdl_origin.var_99424b88 clientfield::set("" + #"hash_7c708a514455bf88", 1);
	}
	var_a5bc0a8b = struct::get("s_p_s2_b");
	var_a5bc0a8b thread scene::play("OUT");
	level thread function_779a8baa();
	var_2f3fca78.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "loop_anim", var_2f3fca78.var_4527036f);
	wait(1.5);
	var_21fedc12 = struct::get("s_p_s2_gul_esc");
	while(isdefined(var_21fedc12))
	{
		n_time = distance(var_2f3fca78.mdl_origin.origin, var_21fedc12.origin) / 150;
		var_2f3fca78.mdl_origin moveto(var_21fedc12.origin, n_time);
		var_2f3fca78.mdl_origin rotateto(var_21fedc12.angles, n_time);
		var_2f3fca78.mdl_origin waittill(#"movedone");
		if(isdefined(var_21fedc12.var_fe5ac7c0) && var_21fedc12.var_fe5ac7c0)
		{
			var_2f3fca78.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "dissolve", var_2f3fca78.var_4527036f);
		}
		var_21fedc12 = struct::get(var_21fedc12.target);
	}
	level thread function_1bf68b9d(var_2f3fca78.var_4527036f.origin, var_2f3fca78.var_4527036f.angles);
	var_2f3fca78.var_4527036f notify(#"delete_seagull");
	var_2f3fca78.mdl_origin.var_99424b88 delete();
	var_2f3fca78.var_4527036f delete();
	var_2f3fca78.mdl_origin delete();
}

/*
	Name: function_90d12e87
	Namespace: namespace_69ddf44f
	Checksum: 0x6553E777
	Offset: 0x5008
	Size: 0x17E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_90d12e87()
{
	level endon(#"hash_36138b6e1d539829", #"hash_11ed3188b9f33eab");
	level.var_487c1bca = 0;
	if(!(isdefined(level.var_cbf67424) && level.var_cbf67424))
	{
		while(level.var_487c1bca < 3)
		{
			function_d8d3d62();
		}
	}
	level notify(#"hash_3872b8f91be564bc");
	callback::remove_on_connect(&function_441abdeb);
	function_26e380c2();
	if(!isdefined(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = [];
	}
	else if(!isarray(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
	}
	level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_66677663;
	level waittill(#"hash_1b94645b5f964ebe");
	level.var_9f3a06d1 = undefined;
}

/*
	Name: function_d8d3d62
	Namespace: namespace_69ddf44f
	Checksum: 0x91D2B270
	Offset: 0x5190
	Size: 0x494
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d8d3d62()
{
	level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe");
	var_3d950183 = struct::get_array("s_p_s2_b_loc");
	var_dcc985c4 = array::random(var_3d950183);
	if(level.var_487c1bca == 0)
	{
		str_location = var_dcc985c4.script_string;
		var_787855a9 = array("zone_cellblock_east", "zone_cellblock_west_gondola", "zone_library");
		while(!isinarray(var_787855a9, str_location))
		{
			var_dcc985c4 = array::random(var_3d950183);
			str_location = var_dcc985c4.script_string;
		}
	}
	else
	{
		var_7e4a1da8 = 0;
		while(!var_7e4a1da8)
		{
			var_7e4a1da8 = 1;
			var_dcc985c4 = array::random(var_3d950183);
			while(var_dcc985c4.script_string == level.var_dcc985c4.script_string)
			{
				var_dcc985c4 = array::random(var_3d950183);
			}
			mdl_origin = util::spawn_model("tag_origin", var_dcc985c4.origin);
			foreach(e_player in util::get_active_players())
			{
				s_cost = zm_zonemgr::function_54fc7938(e_player, mdl_origin);
				if(isdefined(s_cost) && s_cost.cost < 3)
				{
					var_7e4a1da8 = 0;
				}
			}
			mdl_origin delete();
		}
	}
	level.var_dcc985c4 = var_dcc985c4;
	function_5d904e7d(var_dcc985c4);
	var_dcc985c4.var_e5c7e01a thread function_9ac90ec7();
	foreach(e_player in util::get_players())
	{
		e_player thread function_a039c992();
		e_player thread function_441abdeb();
	}
	callback::on_connect(&function_a039c992);
	callback::on_connect(&function_441abdeb);
	/#
		iprintln("" + var_dcc985c4.script_string);
	#/
	level waittill(#"seagull_blasted");
	level.var_487c1bca++;
	function_94cbd473();
	foreach(e_player in util::get_active_players())
	{
		if(isdefined(e_player.var_32a62723) && e_player.var_32a62723)
		{
			e_player.var_32a62723 = undefined;
		}
	}
	level waittill(#"between_round_over");
}

/*
	Name: function_26e380c2
	Namespace: namespace_69ddf44f
	Checksum: 0x33513E6
	Offset: 0x5630
	Size: 0x2E4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_26e380c2()
{
	level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe");
	var_3d950183 = struct::get_array("s_p_s2_b_loc");
	var_dcc985c4 = array::random(var_3d950183);
	str_location = var_dcc985c4.script_string;
	var_e6a8ec03 = array("zone_citadel_basement", "zone_citadel_basement_building", "zone_studio", "zone_dock_gondola", "zone_dock", "zone_citadel_shower", "zone_citadel_warden", "cellblock_shower", "zone_cellblock_west_warden", "zone_sally_port");
	if(!isdefined(level.var_dcc985c4))
	{
		level.var_dcc985c4 = array::random(var_3d950183);
	}
	while(!isinarray(var_e6a8ec03, str_location) || str_location == level.var_dcc985c4.script_string)
	{
		var_dcc985c4 = array::random(var_3d950183);
		str_location = var_dcc985c4.script_string;
	}
	level.var_dcc985c4 = var_dcc985c4;
	function_5d904e7d(var_dcc985c4, 0, 1);
	var_dcc985c4.var_e5c7e01a setinvisibletoall();
	var_dcc985c4.var_617131bd setinvisibletoall();
	foreach(e_player in util::get_active_players())
	{
		e_player thread function_a039c992();
		e_player thread function_1875f44f();
	}
	callback::on_connect(&function_a039c992);
	callback::on_connect(&function_1875f44f);
	/#
		iprintln("" + var_dcc985c4.script_string);
	#/
}

/*
	Name: function_5d904e7d
	Namespace: namespace_69ddf44f
	Checksum: 0xC032584C
	Offset: 0x5920
	Size: 0x48E
	Parameters: 3
	Flags: Linked
*/
function function_5d904e7d(var_dcc985c4, var_a6c68ee8 = 1, var_cc91eb05 = 0)
{
	n_item = randomint(3);
	level.var_dcc985c4 = var_dcc985c4;
	switch(n_item)
	{
		case 0:
		{
			var_dcc985c4.mdl_prop = util::spawn_model(#"p8_zm_esc_weasel_hat", var_dcc985c4.origin, var_dcc985c4.angles);
			break;
		}
		case 1:
		{
			var_dcc985c4.mdl_prop = util::spawn_model(#"p8_zm_esc_comicbook_drawing", var_dcc985c4.origin + (0, 0, 1), var_dcc985c4.angles);
			break;
		}
		case 2:
		{
			var_dcc985c4.mdl_prop = util::spawn_model(#"hash_153ac5fda9f2b0c9", var_dcc985c4.origin, var_dcc985c4.angles);
			break;
		}
	}
	var_2c82917f = struct::get_array(var_dcc985c4.target);
	s_bird = array::random(var_2c82917f);
	var_dcc985c4.var_e5c7e01a = util::spawn_model(#"hash_91c31763b1101e6", s_bird.origin, s_bird.angles);
	if(var_a6c68ee8)
	{
		var_dcc985c4.var_e5c7e01a clientfield::set("" + #"hash_7327d0447d656234", 1);
	}
	var_dcc985c4.var_e5c7e01a clientfield::set("" + #"seagull_fx", 1);
	var_dcc985c4.var_e5c7e01a clientfield::set("" + #"hash_504d26c38b96651c", 1);
	var_dcc985c4.mdl_origin = util::spawn_model("tag_origin", s_bird.origin, s_bird.angles);
	var_dcc985c4.var_e5c7e01a linkto(var_dcc985c4.mdl_origin);
	var_dcc985c4.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "idle_grounded_loop", var_dcc985c4.var_e5c7e01a);
	var_dcc985c4.var_e5c7e01a.script_noteworthy = "blast_attack_interactables";
	s_book = struct::get(s_bird.target);
	if(var_cc91eb05 && isdefined(s_book))
	{
		var_dcc985c4.var_617131bd = util::spawn_model(#"p7_zm_ctl_book_zombie", s_book.origin, s_book.angles);
		var_dcc985c4.var_617131bd clientfield::set("" + #"hash_6e2f9a57d1bc4b6a", 1);
	}
	if(isdefined(s_book) && !var_cc91eb05)
	{
		var_dcc985c4.mdl_origin.origin = var_dcc985c4.mdl_origin.origin - vectorscale((0, 0, 1), 5);
	}
}

/*
	Name: function_9ac90ec7
	Namespace: namespace_69ddf44f
	Checksum: 0xAEFB10C
	Offset: 0x5DB8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_9ac90ec7()
{
	level endon(#"seagull_blasted", #"hash_36138b6e1d539829");
	self setcandamage(1);
	self.health = 100000000;
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"blast_attack");
		level notify(#"seagull_blasted");
	}
}

/*
	Name: function_a039c992
	Namespace: namespace_69ddf44f
	Checksum: 0x1752DE4C
	Offset: 0x5E58
	Size: 0x240
	Parameters: 0
	Flags: Linked
*/
function function_a039c992()
{
	self notify(#"hash_7472292fa861b6ed");
	self endon(#"death", #"disconnect", #"hash_7472292fa861b6ed");
	level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe");
	while(true)
	{
		if(self.currentweapon == level.var_4e845c84 || self.currentweapon == level.var_58e17ce3)
		{
			var_bdf9e3c2 = self zm_zonemgr::get_player_zone();
			a_str_active_zones = zm_cleanup::get_adjacencies_to_zone(level.var_dcc985c4.script_string);
			if(isdefined(var_bdf9e3c2) && isdefined(a_str_active_zones))
			{
				var_455e0e0 = 0;
				foreach(str_zone in a_str_active_zones)
				{
					if(var_bdf9e3c2 == str_zone)
					{
						var_455e0e0 = 1;
						break;
					}
				}
				if(var_455e0e0 && isdefined(level.var_dcc985c4.var_e5c7e01a) && (!(isdefined(level.var_dcc985c4.var_e5c7e01a.var_4d89e47e) && level.var_dcc985c4.var_e5c7e01a.var_4d89e47e)))
				{
					level.var_dcc985c4.var_e5c7e01a playsoundtoplayer(#"hash_6cd665a68de4367e", self);
					wait(5);
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_1875f44f
	Namespace: namespace_69ddf44f
	Checksum: 0x868E1829
	Offset: 0x60A0
	Size: 0x2F4
	Parameters: 0
	Flags: Linked
*/
function function_1875f44f()
{
	self endon(#"death", #"disconnect");
	level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe");
	while(true)
	{
		if(isdefined(level.var_dcc985c4.var_e5c7e01a))
		{
			if(self.currentweapon == level.var_4e845c84 || self.currentweapon == level.var_58e17ce3)
			{
				var_bdf9e3c2 = zm_zonemgr::get_player_zone();
				if(isdefined(var_bdf9e3c2) && var_bdf9e3c2 == level.var_dcc985c4.script_string && isdefined(level.var_dcc985c4.var_e5c7e01a))
				{
					var_dc40fc85 = level.var_dcc985c4.var_e5c7e01a sightconetrace(self getweaponmuzzlepoint(), self, self getweaponforwarddir(), 10);
					if(isdefined(var_dc40fc85) && var_dc40fc85)
					{
						level.var_dcc985c4.var_e5c7e01a.var_4d89e47e = 1;
						level.var_dcc985c4.var_e5c7e01a playsoundtoplayer(#"hash_46a6d025135db080", self);
						if(!(isdefined(level.var_9f3a06d1) && level.var_9f3a06d1))
						{
							level.var_9f3a06d1 = 1;
							self thread function_e4a9da98();
						}
						if(!(isdefined(level.var_dcc985c4.var_e5c7e01a.var_51bb3559) && level.var_dcc985c4.var_e5c7e01a.var_51bb3559))
						{
							/#
								iprintln("");
							#/
							level.var_dcc985c4.var_e5c7e01a.var_51bb3559 = 1;
							level thread function_b6abb124();
						}
						wait(soundgetplaybacktime(#"hash_46a6d025135db080") * 0.001);
						if(isdefined(level.var_dcc985c4.var_e5c7e01a))
						{
							level.var_dcc985c4.var_e5c7e01a.var_4d89e47e = undefined;
						}
					}
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_e4a9da98
	Namespace: namespace_69ddf44f
	Checksum: 0x11D4439C
	Offset: 0x63A0
	Size: 0x1B6
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e4a9da98()
{
	level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe", #"hash_38f418ba1b5571a2");
	level.var_dcc985c4.mdl_origin endon(#"death");
	level.var_dcc985c4.mdl_origin clientfield::set("" + #"hash_670a34b297f8faca", 1);
	while(isdefined(self) && (isdefined(level.var_dcc985c4.var_e5c7e01a sightconetrace(self getweaponmuzzlepoint(), self, self getweaponforwarddir(), 10)) && level.var_dcc985c4.var_e5c7e01a sightconetrace(self getweaponmuzzlepoint(), self, self getweaponforwarddir(), 10)) && self adsbuttonpressed())
	{
		waitframe(1);
	}
	level.var_dcc985c4.mdl_origin clientfield::set("" + #"hash_670a34b297f8faca", 0);
	level.var_9f3a06d1 = undefined;
}

/*
	Name: function_b6abb124
	Namespace: namespace_69ddf44f
	Checksum: 0x9E269E88
	Offset: 0x6560
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_b6abb124()
{
	level endon(#"hash_36138b6e1d539829", #"hash_38f418ba1b5571a2");
	while(zm_zonemgr::any_player_in_zone(level.var_dcc985c4.script_string))
	{
		wait(1);
	}
	level thread function_f1d0739();
	/#
		iprintln("");
	#/
}

/*
	Name: function_f1d0739
	Namespace: namespace_69ddf44f
	Checksum: 0x3E7B6C8B
	Offset: 0x6600
	Size: 0x3CC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f1d0739()
{
	level endon(#"hash_36138b6e1d539829", #"hash_38f418ba1b5571a2", #"hash_1b94645b5f964ebe");
	while(true)
	{
		a_e_players = zm_zonemgr::get_players_in_zone(level.var_dcc985c4.script_string, 1);
		for(i = 0; i < a_e_players.size; i++)
		{
			if(!(isdefined(a_e_players[i].bgb_in_plain_sight_active) && a_e_players[i].bgb_in_plain_sight_active) && (!(isdefined(a_e_players[i].var_4e6b62c3) && a_e_players[i].var_4e6b62c3)) && !a_e_players[i].zombie_vars[#"zombie_powerup_zombie_blood_on"])
			{
				if(isdefined(a_e_players[i].var_39de0c9f) && a_e_players[i].var_39de0c9f)
				{
					a_e_players[i].var_39de0c9f = undefined;
					a_e_players[i] notify(#"hash_1380399cfb2fecab");
				}
				if(isdefined(level.var_bc03159c) && level.var_bc03159c && (!(isdefined(level.var_5a23951d) && level.var_5a23951d)) && !level flag::get(#"hash_8c500dbad4c6edb"))
				{
					level.var_5a23951d = 1;
					level thread function_c4a07f79();
				}
				continue;
			}
			if(isdefined(level.var_dcc985c4.var_e5c7e01a))
			{
				level.var_dcc985c4.var_e5c7e01a setvisibletoall();
				level.var_dcc985c4.var_e5c7e01a clientfield::set("" + #"hash_7327d0447d656234", 1);
			}
			if(isdefined(level.var_dcc985c4.var_617131bd))
			{
				level.var_dcc985c4.var_617131bd setvisibletoall();
				level.var_dcc985c4.var_617131bd clientfield::set("" + #"hash_7327d0447d656234", 1);
			}
			if(!(isdefined(a_e_players[i].var_39de0c9f) && a_e_players[i].var_39de0c9f))
			{
				a_e_players[i].var_39de0c9f = 1;
				a_e_players[i] thread function_b797cdc0();
				a_e_players[i] thread function_baf69ec9();
				level thread function_787bed75();
				/#
					iprintln("");
				#/
			}
		}
		wait(0.5);
	}
}

/*
	Name: function_c4a07f79
	Namespace: namespace_69ddf44f
	Checksum: 0xED94D33F
	Offset: 0x69D8
	Size: 0x12A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c4a07f79()
{
	function_94cbd473();
	/#
		iprintln("");
	#/
	level thread function_4efc779e();
	foreach(e_player in util::get_active_players())
	{
		if(isdefined(e_player.var_39de0c9f) && e_player.var_39de0c9f)
		{
			e_player.var_39de0c9f = undefined;
			e_player notify(#"hash_1380399cfb2fecab");
		}
	}
	level notify(#"hash_38f418ba1b5571a2");
	level.var_9f3a06d1 = undefined;
	level.var_bc03159c = undefined;
	level.var_5a23951d = undefined;
}

/*
	Name: function_787bed75
	Namespace: namespace_69ddf44f
	Checksum: 0x8F09C12
	Offset: 0x6B10
	Size: 0xEA
	Parameters: 0
	Flags: Linked, Private
*/
function private function_787bed75()
{
	self notify("209e19ef3b5719aa" + #"hash_503880ae5cc41ea8");
	self endon("209e19ef3b5719aa" + #"hash_503880ae5cc41ea8");
	if(!isdefined(level.var_dcc985c4.var_e5c7e01a))
	{
		return;
	}
	level.var_dcc985c4.var_e5c7e01a endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = level.var_dcc985c4.var_e5c7e01a waittill(#"blast_attack");
		if(isdefined(level.var_bc03159c) && level.var_bc03159c)
		{
			level thread function_c4a07f79();
			return;
		}
	}
}

/*
	Name: function_4efc779e
	Namespace: namespace_69ddf44f
	Checksum: 0xFA21C556
	Offset: 0x6C08
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_4efc779e()
{
	level endon(#"hash_36138b6e1d539829");
	level waittill(#"between_round_over");
	function_26e380c2();
}

/*
	Name: function_baf69ec9
	Namespace: namespace_69ddf44f
	Checksum: 0xCDBCE97
	Offset: 0x6C58
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function function_baf69ec9()
{
	self notify("3b07ae06f69b61d8" + #"hash_44480146d21af13c");
	self endon("3b07ae06f69b61d8" + #"hash_44480146d21af13c");
	self endon(#"death", #"disconnect");
	level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe", #"hash_38f418ba1b5571a2");
	while(true)
	{
		if(isdefined(level.var_dcc985c4.var_e5c7e01a))
		{
			if(self.currentweapon == level.var_4e845c84 || self.currentweapon == level.var_58e17ce3)
			{
				var_bdf9e3c2 = zm_zonemgr::get_player_zone();
				if(isdefined(var_bdf9e3c2) && var_bdf9e3c2 == level.var_dcc985c4.script_string && isdefined(level.var_dcc985c4.var_e5c7e01a))
				{
					var_dc40fc85 = level.var_dcc985c4.var_e5c7e01a sightconetrace(self getweaponmuzzlepoint(), self, self getweaponforwarddir(), 50);
					if(isdefined(var_dc40fc85) && var_dc40fc85)
					{
						level.var_bc03159c = 1;
					}
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_b797cdc0
	Namespace: namespace_69ddf44f
	Checksum: 0x720F0837
	Offset: 0x6E28
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_b797cdc0()
{
	if(!isdefined(level.var_dcc985c4.var_e5c7e01a))
	{
		return;
	}
	self notify("54cbefeb162dce8f" + #"hash_56213bab41e78b0b");
	self endon("54cbefeb162dce8f" + #"hash_56213bab41e78b0b");
	self endon(#"death", #"disconnect", #"hash_1380399cfb2fecab");
	level endon(#"hash_36138b6e1d539829", #"hash_1b94645b5f964ebe", #"hash_38f418ba1b5571a2");
	level.var_dcc985c4.var_e5c7e01a endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"throwing_tomahawk");
		var_288eb627 = s_result.e_grenade;
		while(isdefined(var_288eb627))
		{
			if(distancesquared(var_288eb627.origin, level.var_dcc985c4.var_e5c7e01a gettagorigin("j_jaw")) < 40000 && (isdefined(level.var_bc03159c) && level.var_bc03159c))
			{
				level.var_dcc985c4.var_e5c7e01a.var_98ceb3be = 1;
				break;
			}
			wait(0.1);
		}
	}
}

/*
	Name: function_66677663
	Namespace: namespace_69ddf44f
	Checksum: 0x5B75DDDD
	Offset: 0x7000
	Size: 0x1C4
	Parameters: 2
	Flags: Linked
*/
function function_66677663(e_grenade, n_grenade_charge_power)
{
	self endon(#"disconnect");
	if(!isdefined(level.var_dcc985c4.var_e5c7e01a) || (!(isdefined(self.var_39de0c9f) && self.var_39de0c9f)))
	{
		return false;
	}
	if(isdefined(level.var_dcc985c4.var_e5c7e01a.var_98ceb3be) && level.var_dcc985c4.var_e5c7e01a.var_98ceb3be)
	{
		if(isdefined(level.var_dcc985c4.var_617131bd))
		{
			var_6e6ec518 = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
			var_6e6ec518.n_grenade_charge_power = n_grenade_charge_power;
			var_21841d64 = util::spawn_model(level.var_dcc985c4.var_617131bd.model, e_grenade.origin);
			var_21841d64 linkto(var_6e6ec518);
			self thread zm_weap_tomahawk::tomahawk_return_player(var_6e6ec518, undefined, 800);
			self thread function_d8c3721f(var_6e6ec518, var_21841d64);
			level thread function_94cbd473();
			level flag::set(#"hash_8c500dbad4c6edb");
			return true;
		}
		return false;
	}
	return false;
}

/*
	Name: function_d8c3721f
	Namespace: namespace_69ddf44f
	Checksum: 0x48151EB3
	Offset: 0x71D0
	Size: 0xE0
	Parameters: 2
	Flags: Linked
*/
function function_d8c3721f(var_6e6ec518, var_21841d64)
{
	self endoncallback(&function_4dd32050, #"disconnect");
	while(isdefined(var_6e6ec518))
	{
		waitframe(1);
	}
	var_21841d64 delete();
	self thread function_750df71a();
	s_result = undefined;
	s_result = level waittill(#"hash_2a774132e6f379ae");
	if(isdefined(s_result.e_player))
	{
		s_result.e_player function_a3eca01d();
	}
	level notify(#"hash_1b94645b5f964ebe");
}

/*
	Name: function_750df71a
	Namespace: namespace_69ddf44f
	Checksum: 0x13D4AD7D
	Offset: 0x72B8
	Size: 0x314
	Parameters: 0
	Flags: Linked, Private
*/
function private function_750df71a()
{
	var_a812a69b = self.origin + (anglestoforward(self getplayerangles()) * 16);
	v_pos = getclosestpointonnavmesh(var_a812a69b, 128, 16);
	/#
		assert(isdefined(v_pos), "" + var_a812a69b);
	#/
	var_21841d64 = util::spawn_model(#"p7_zm_ctl_book_zombie", v_pos + vectorscale((0, 0, 1), 24));
	var_21841d64 clientfield::set("" + #"hash_6e2f9a57d1bc4b6a", 1);
	var_21841d64 thread function_e645ca47();
	t_interact = spawn("trigger_radius_use", var_21841d64.origin, 0, 64, 64);
	t_interact sethintstring(#"");
	t_interact setcursorhint("HINT_NOICON");
	t_interact triggerignoreteam();
	t_interact setvisibletoall();
	t_interact endon(#"death");
	while(isdefined(var_21841d64))
	{
		s_result = undefined;
		s_result = t_interact waittill(#"trigger");
		if(isplayer(s_result.activator))
		{
			level notify(#"hash_2a774132e6f379ae", {#e_player:s_result.activator});
			s_result.activator clientfield::increment_to_player("" + #"hash_5cab8aa95fc9ea84");
			s_result.activator playsound(#"hash_b4cadde3a57e29");
			var_21841d64 clientfield::set("" + #"hash_6e2f9a57d1bc4b6a", 0);
			var_21841d64 delete();
		}
	}
	t_interact delete();
}

/*
	Name: function_e645ca47
	Namespace: namespace_69ddf44f
	Checksum: 0xE5D87756
	Offset: 0x75D8
	Size: 0x138
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e645ca47()
{
	self endon(#"death");
	while(isdefined(self))
	{
		waittime = randomfloatrange(2.5, 5);
		yaw = math::clamp(randomint(45), 0, 45);
		yaw = self.angles[1] + yaw;
		new_angles = (-45 + randomint(45), yaw, -45 + randomint(45));
		self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
		wait(randomfloat(waittime - 0.1));
	}
}

/*
	Name: function_4dd32050
	Namespace: namespace_69ddf44f
	Checksum: 0x6B758AB3
	Offset: 0x7718
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function function_4dd32050(str_notify)
{
	if(isdefined(level.var_dcc985c4.var_e5c7e01a) && (isdefined(level.var_dcc985c4.var_e5c7e01a.var_98ceb3be) && level.var_dcc985c4.var_e5c7e01a.var_98ceb3be))
	{
		level.var_dcc985c4.var_e5c7e01a.var_98ceb3be = undefined;
	}
}

/*
	Name: function_94cbd473
	Namespace: namespace_69ddf44f
	Checksum: 0xA0AA7A72
	Offset: 0x77A0
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function function_94cbd473()
{
	if(isdefined(level.var_dcc985c4.var_e5c7e01a))
	{
		level.var_dcc985c4.var_e5c7e01a setvisibletoall();
	}
	if(isdefined(level.var_dcc985c4.mdl_prop))
	{
		level.var_dcc985c4.mdl_prop delete();
	}
	if(isdefined(level.var_dcc985c4.var_617131bd))
	{
		level.var_dcc985c4.var_617131bd delete();
	}
	if(isdefined(level.var_dcc985c4) && isdefined(level.var_dcc985c4.var_e5c7e01a))
	{
		level.var_dcc985c4.var_e5c7e01a clientfield::set("" + #"hash_7327d0447d656234", 0);
		waitframe(1);
	}
	if(isdefined(level.var_dcc985c4) && isdefined(level.var_dcc985c4.var_e5c7e01a) && isdefined(level.var_dcc985c4.mdl_origin))
	{
		level.var_dcc985c4.mdl_origin scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "fly_off", level.var_dcc985c4.var_e5c7e01a);
		level thread function_1bf68b9d(level.var_dcc985c4.mdl_origin.origin, level.var_dcc985c4.mdl_origin.angles);
		waitframe(1);
	}
	if(isdefined(level.var_dcc985c4))
	{
		if(isdefined(level.var_dcc985c4.var_e5c7e01a))
		{
			level.var_dcc985c4.var_e5c7e01a delete();
		}
		if(isdefined(level.var_dcc985c4.mdl_origin))
		{
			level.var_dcc985c4.mdl_origin delete();
		}
	}
}

/*
	Name: function_1bf68b9d
	Namespace: namespace_69ddf44f
	Checksum: 0x6B7738CE
	Offset: 0x7A20
	Size: 0xEC
	Parameters: 2
	Flags: Linked, Private
*/
function private function_1bf68b9d(v_position, v_angles)
{
	if(!isdefined(v_position))
	{
		return;
	}
	if(!isdefined(v_angles))
	{
		return;
	}
	var_785626e7 = (v_position + (anglestoforward(v_angles) * 48)) + vectorscale((0, 0, 1), 8);
	mdl_fx = util::spawn_model("tag_origin", var_785626e7, v_angles);
	if(isdefined(mdl_fx))
	{
		mdl_fx clientfield::set("" + #"hash_592c96b2803d9fd5", 1);
		wait(2);
		mdl_fx delete();
	}
}

/*
	Name: function_1798f59a
	Namespace: namespace_69ddf44f
	Checksum: 0x98655944
	Offset: 0x7B18
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_1798f59a(e_player)
{
	level notify(#"hash_11fb44a7b531b27d");
	level endon(#"hash_11fb44a7b531b27d", #"hash_36138b6e1d539829");
	if(isalive(e_player))
	{
		zm_vo::function_3c173d37(e_player.origin, 512);
		e_player zm_vo::function_a2bd5a0c(#"hash_61ec04cf6e717320");
	}
}

/*
	Name: function_779a8baa
	Namespace: namespace_69ddf44f
	Checksum: 0x8221F72D
	Offset: 0x7BB8
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_779a8baa()
{
	level notify(#"hash_11fb44a7b531b27d");
	level endon(#"hash_11fb44a7b531b27d", #"hash_36138b6e1d539829");
	e_player = array::random(util::get_active_players());
	while(!isalive(e_player) || e_player zm_zonemgr::get_player_zone() !== "zone_model_industries")
	{
		wait(0.1);
		e_player = array::random(util::get_active_players());
	}
	zm_vo::function_3c173d37(e_player.origin, 512);
	b_played_line = e_player zm_vo::function_a2bd5a0c(#"hash_7ece3932c57d8fad", 0, 1);
	level thread function_c362eae3();
}

/*
	Name: function_c362eae3
	Namespace: namespace_69ddf44f
	Checksum: 0xC1F14A53
	Offset: 0x7D08
	Size: 0x3D6
	Parameters: 0
	Flags: Linked
*/
function function_c362eae3()
{
	level notify(#"hash_11fb44a7b531b27d");
	level endon(#"hash_11fb44a7b531b27d", #"hash_36138b6e1d539829");
	wait(3);
	e_richtofen = function_b1203924();
	if(!isdefined(e_richtofen) || !isalive(e_richtofen) || (!(isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6)))
	{
		return;
	}
	e_richtofen endon(#"death", #"disconnect");
	e_richtofen zm_vo::vo_stop();
	b_say = e_richtofen zm_vo::vo_say(#"hash_3017e53254e0b2b0", 0, 1, 9999, 1, 1, 1);
	if(b_say)
	{
		zm_vo::function_3c173d37(e_richtofen.origin, 512);
		b_say = e_richtofen zm_vo::function_a2bd5a0c(#"hash_26737a9cd8eaf393", 0, 1, 9999);
		if(b_say)
		{
			e_richtofen zm_vo::vo_stop();
			b_say = e_richtofen zm_vo::vo_say(#"hash_680ce96c277ba84e", 0, 1, 9999, 1, 1, 1);
			if(b_say)
			{
				zm_vo::function_3c173d37(e_richtofen.origin, 512);
				b_say = e_richtofen zm_vo::function_a2bd5a0c(#"hash_26737c9cd8eaf6f9", 0, 1, 9999);
				if(b_say && util::get_active_players().size > 1)
				{
					var_95b25b2e = function_b61881e5(e_richtofen);
					if(isdefined(var_95b25b2e) && isalive(var_95b25b2e))
					{
						zm_vo::function_3c173d37(var_95b25b2e.origin, 512);
						b_say = var_95b25b2e zm_vo::function_a2bd5a0c(#"hash_26737d9cd8eaf8ac", 0, 1, 9999);
						if(b_say)
						{
							e_richtofen zm_vo::vo_stop();
							b_say = e_richtofen zm_vo::vo_say(#"hash_400c40774d03001d", 0, 1, 9999, 1, 1, 1);
							if(b_say)
							{
								zm_vo::function_3c173d37(e_richtofen.origin, 512);
								b_say = e_richtofen zm_vo::function_a2bd5a0c(#"hash_26737f9cd8eafc12", 0, 1, 9999);
								if(b_say)
								{
									e_richtofen zm_vo::vo_stop();
									b_say = e_richtofen zm_vo::vo_say(#"hash_1aa5f5d5b29633d3", 0, 1, 9999, 1, 1, 1);
								}
							}
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_b1203924
	Namespace: namespace_69ddf44f
	Checksum: 0xEFA7180C
	Offset: 0x80E8
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_b1203924(var_4527b4bf = 0)
{
	e_richtofen = undefined;
	a_players = util::get_active_players();
	if(var_4527b4bf)
	{
		a_players = util::get_players();
	}
	foreach(e_player in a_players)
	{
		if(e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
		{
			if(isalive(e_player) || var_4527b4bf)
			{
				e_richtofen = e_player;
				break;
			}
		}
	}
	return e_richtofen;
}

/*
	Name: function_b61881e5
	Namespace: namespace_69ddf44f
	Checksum: 0x619E922B
	Offset: 0x8240
	Size: 0x176
	Parameters: 1
	Flags: Linked
*/
function function_b61881e5(e_richtofen)
{
	a_e_players = array::randomize(util::get_active_players());
	var_b63113d5 = undefined;
	foreach(e_player in a_e_players)
	{
		if(!e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")) && isalive(e_player) && isalive(e_richtofen) && distancesquared(e_player.origin, e_richtofen.origin) < 589824)
		{
			var_b63113d5 = e_player;
			break;
		}
	}
	return var_b63113d5;
}

/*
	Name: function_441abdeb
	Namespace: namespace_69ddf44f
	Checksum: 0xE5EECBAB
	Offset: 0x83C0
	Size: 0x1D8
	Parameters: 0
	Flags: Linked
*/
function function_441abdeb()
{
	self notify(#"hash_dbc4bce5474323a");
	self endon(#"death", #"disconnect", #"hash_dbc4bce5474323a");
	level endon(#"hash_36138b6e1d539829", #"hash_3872b8f91be564bc");
	while(true)
	{
		if(self.currentweapon == level.var_4e845c84 || self.currentweapon == level.var_58e17ce3 && (!(isdefined(self.var_32a62723) && self.var_32a62723)))
		{
			if(isdefined(level.var_dcc985c4.var_e5c7e01a) && distancesquared(level.var_dcc985c4.var_e5c7e01a.origin, self.origin) < 262144)
			{
				n_trace = level.var_dcc985c4.var_e5c7e01a sightconetrace(self getweaponmuzzlepoint(), self, self getweaponforwarddir());
				if(n_trace > 0.65)
				{
					zm_vo::function_3c173d37(self.origin, 512);
					self.var_32a62723 = self zm_vo::function_a2bd5a0c(#"hash_13cd65f9025f98b", 0, 1, 9999);
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_a3eca01d
	Namespace: namespace_69ddf44f
	Checksum: 0x9895D7AC
	Offset: 0x85A0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_a3eca01d()
{
	self zm_vo::function_3c173d37(self.origin, 512);
	self zm_vo::function_a2bd5a0c(#"hash_51734ccae106d149", 0, 1, 9999);
}

/*
	Name: scr_safehouse_testrageservice
	Namespace: namespace_69ddf44f
	Checksum: 0xE306F316
	Offset: 0x85F8
	Size: 0x396
	Parameters: 0
	Flags: Linked
*/
function scr_safehouse_testrageservice()
{
	level notify(#"hash_11fb44a7b531b27d");
	level endon(#"hash_11fb44a7b531b27d", #"hash_36138b6e1d539829");
	wait(3);
	e_richtofen = function_b1203924();
	if(!isdefined(e_richtofen) || !isalive(e_richtofen) || (!(isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6)))
	{
		return;
	}
	e_richtofen endon(#"death", #"disconnect");
	e_richtofen zm_vo::vo_stop();
	b_say = e_richtofen zm_vo::vo_say(#"hash_7fdd1ff9ab5956e1", 0, 1, 9999, 1, 1, 1);
	if(b_say)
	{
		zm_vo::function_3c173d37(e_richtofen.origin, 512);
		b_say = e_richtofen zm_vo::function_a2bd5a0c(#"hash_1f24619cd5290718", 0, 1, 9999);
		if(b_say)
		{
			e_richtofen zm_vo::vo_stop();
			b_say = e_richtofen zm_vo::vo_say(#"hash_42cfc3e346da1d7", 0, 1, 9999, 1, 1, 1);
			if(b_say)
			{
				zm_vo::function_3c173d37(e_richtofen.origin, 512);
				b_say = e_richtofen zm_vo::function_a2bd5a0c(#"hash_1f24639cd5290a7e", 0, 1, 999);
				if(b_say)
				{
					var_95b25b2e = function_b61881e5(e_richtofen);
					if(isdefined(var_95b25b2e))
					{
						zm_vo::function_3c173d37(var_95b25b2e.origin, 512);
						b_say = var_95b25b2e zm_vo::function_a2bd5a0c(#"hash_1f24669cd5290f97", 0, 1, 9999);
						if(b_say)
						{
							e_richtofen zm_vo::vo_stop();
							b_say = e_richtofen zm_vo::vo_say(#"hash_69c55b111354ddfc", 0, 1, 9999, 1, 1, 1);
							if(b_say)
							{
								zm_vo::function_3c173d37(e_richtofen.origin, 512);
								b_say = e_richtofen zm_vo::function_a2bd5a0c(#"hash_1f24689cd52912fd", 0, 1, 9999);
								if(b_say)
								{
									e_richtofen zm_vo::vo_stop();
									b_say = e_richtofen zm_vo::vo_say(#"hash_7168ed7a57c9729a", 0, 1, 9999, 1, 1, 1);
								}
							}
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_9465204c
	Namespace: namespace_69ddf44f
	Checksum: 0x6C26F127
	Offset: 0x8998
	Size: 0x21C
	Parameters: 1
	Flags: Linked
*/
function function_9465204c(var_64c09f7f)
{
	level notify(#"hash_11fb44a7b531b27d");
	if(!isalive(var_64c09f7f))
	{
		return;
	}
	zm_vo::function_3c173d37(var_64c09f7f.origin, 512);
	b_say = var_64c09f7f zm_vo::function_a2bd5a0c(#"hash_53ef8e09c9b4d690", 0, 1, 9999);
	if(b_say && isalive(var_64c09f7f) && !var_64c09f7f zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
	{
		e_richtofen = function_b1203924();
		if(isalive(e_richtofen) && distancesquared(e_richtofen.origin, var_64c09f7f.origin) < 589824)
		{
			zm_vo::function_3c173d37(e_richtofen.origin, 768);
			var_f5f9c084 = zm_characters::function_9004475c(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae"));
			e_richtofen zm_vo::function_a2bd5a0c(#"hash_53ef8e09c9b4d690", 0, 1, 9999);
		}
	}
}

/*
	Name: function_676ccd91
	Namespace: namespace_69ddf44f
	Checksum: 0x6B96CF8E
	Offset: 0x8BC0
	Size: 0x174
	Parameters: 0
	Flags: None
*/
function function_676ccd91()
{
	/#
		if(!getdvarint(#"zm_debug_ee", 0))
		{
			return;
		}
		zm_devgui::add_custom_devgui_callback(&function_52e31e1a);
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
	Name: function_52e31e1a
	Namespace: namespace_69ddf44f
	Checksum: 0xC1634F74
	Offset: 0x8D40
	Size: 0x66A
	Parameters: 1
	Flags: None
*/
function function_52e31e1a(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_c8e283d06114e8b":
			{
				var_c699e2b5 = struct::get("");
				var_c699e2b5.s_unitrigger_stub notify(#"hash_4c6ab2a4a99f9539");
				level thread function_e998f810("");
				break;
			}
			case "hash_c8e293d0611503e":
			{
				var_a5bc0a8b = struct::get("");
				var_a5bc0a8b notify(#"trigger_activated");
				break;
			}
			case "hash_c8e2a3d061151f1":
			{
				level notify(#"seagull_blasted");
				zm_devgui::zombie_devgui_goto_round(level.round_number + 1);
				break;
			}
			case "hash_c8e2b3d061153a4":
			{
				level notify(#"seagull_blasted");
				zm_devgui::zombie_devgui_goto_round(level.round_number + 1);
				break;
			}
			case "hash_c8e2c3d06115557":
			{
				level notify(#"seagull_blasted");
				zm_devgui::zombie_devgui_goto_round(level.round_number + 1);
				break;
			}
			case "hash_c8e2d3d0611570a":
			{
				level notify(#"hash_1b94645b5f964ebe");
				break;
			}
			case "hash_c8e2e3d061158bd":
			{
				var_a5bc0a8b = struct::get("");
				var_a5bc0a8b notify(#"trigger_activated");
				break;
			}
			case "hash_7f65be6afe5b6656":
			{
				level notify(#"hash_11ed3188b9f33eab");
				break;
			}
			case "hash_6f00d561fc15269a":
			{
				level.var_cbf67424 = 1;
				break;
			}
			case "hash_39361a1fa06167ab":
			{
				var_20279738 = struct::get_array("");
				level.var_2c82917f = [];
				foreach(s_loc in var_20279738)
				{
					var_2c82917f = struct::get_array(s_loc.target);
					s_loc.var_231e3f97 = util::spawn_model(#"hash_91c31763b1101e6", var_2c82917f[0].origin, var_2c82917f[0].angles);
					s_loc.var_231e3f97 clientfield::set("" + #"hash_504d26c38b96651c", 1);
					s_loc.var_231e3f97.script_noteworthy = "";
					s_loc.var_231e3f97 thread function_6af89001();
					s_loc.var_231e3f97 clientfield::set("" + #"hash_670a34b297f8faca", 1);
					var_2c82917f[0] thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "", s_loc.var_231e3f97);
					s_book = struct::get(var_2c82917f[0].target);
					if(isdefined(s_book))
					{
						s_loc.var_39fa0e01 = util::spawn_model(#"p7_zm_ctl_book_zombie", s_book.origin, s_book.angles);
						s_loc.var_39fa0e01 clientfield::set("" + #"hash_6e2f9a57d1bc4b6a", 1);
					}
					if(!isdefined(level.var_2c82917f))
					{
						level.var_2c82917f = [];
					}
					else if(!isarray(level.var_2c82917f))
					{
						level.var_2c82917f = array(level.var_2c82917f);
					}
					level.var_2c82917f[level.var_2c82917f.size] = s_loc;
				}
				foreach(e_player in util::get_active_players())
				{
					e_player thread function_d053b82c();
				}
				break;
			}
			case "hash_62edc78ae04218b":
			{
				level thread function_1802df85();
				break;
			}
			case "hash_1f91117ebc8b22a3":
			{
				level thread function_249c62e7();
				break;
			}
		}
	#/
}

/*
	Name: function_d053b82c
	Namespace: namespace_69ddf44f
	Checksum: 0x43B08C03
	Offset: 0x93B8
	Size: 0x1D8
	Parameters: 0
	Flags: None
*/
function function_d053b82c()
{
	/#
		self endon(#"death", #"disconnect");
		while(true)
		{
			s_result = undefined;
			s_result = self waittill(#"throwing_tomahawk");
			var_288eb627 = s_result.e_grenade;
			str_zone = self zm_zonemgr::get_player_zone();
			while(isdefined(var_288eb627))
			{
				foreach(var_2f3fca78 in level.var_2c82917f)
				{
					if(isdefined(str_zone) && str_zone == var_2f3fca78.script_string)
					{
						iprintln("" + distance(var_288eb627.origin, var_2f3fca78.var_231e3f97 gettagorigin("")));
						if(distancesquared(var_288eb627.origin, var_2f3fca78.var_231e3f97 gettagorigin("")) < 40000)
						{
							iprintln("");
						}
					}
				}
				wait(0.1);
			}
		}
	#/
}

/*
	Name: function_1802df85
	Namespace: namespace_69ddf44f
	Checksum: 0x17966B4D
	Offset: 0x9598
	Size: 0x72
	Parameters: 0
	Flags: None
*/
function function_1802df85()
{
	/#
		level notify(#"hash_600fbb2538368696");
		level endon(#"hash_600fbb2538368696");
		if(isdefined(level.var_bc410725) && level.var_bc410725)
		{
			level.var_bc410725 = 0;
		}
		else
		{
			level.var_bc410725 = 1;
		}
	#/
}

/*
	Name: function_249c62e7
	Namespace: namespace_69ddf44f
	Checksum: 0x6E6675D
	Offset: 0x9618
	Size: 0xF0
	Parameters: 0
	Flags: None
*/
function function_249c62e7()
{
	/#
		level notify(#"hash_1971ee3d4c0a3ede");
		level endon(#"hash_1971ee3d4c0a3ede");
		if(isdefined(level.var_af7ee21c) && level.var_af7ee21c)
		{
			level.var_af7ee21c = 0;
		}
		else
		{
			level.var_af7ee21c = 1;
		}
		while(level.var_af7ee21c)
		{
			if(isdefined(level.var_dcc985c4) && isdefined(level.var_dcc985c4.var_e5c7e01a))
			{
				debugstar(level.var_dcc985c4.var_e5c7e01a.origin, 10, (0, 1, 0));
				waitframe(10);
			}
			else
			{
				wait(1);
			}
		}
	#/
}

/*
	Name: function_6af89001
	Namespace: namespace_69ddf44f
	Checksum: 0x2DEFF4D8
	Offset: 0x9710
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_6af89001()
{
	/#
		self setcandamage(1);
		self.health = 100000000;
		while(true)
		{
			s_result = undefined;
			s_result = self waittill(#"blast_attack");
			iprintln("");
		}
	#/
}

/*
	Name: step_3
	Namespace: namespace_69ddf44f
	Checksum: 0x1CC088B
	Offset: 0x9790
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function step_3(var_a276c861)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_7629706a5a9c7bf7", 3);
	level thread namespace_a9aa9d72::function_307fdd13(var_a276c861);
	if(!var_a276c861)
	{
		level waittill(#"hash_29b90ce9aa921f78");
	}
}

/*
	Name: step_3_cleanup
	Namespace: namespace_69ddf44f
	Checksum: 0xB5AA1F
	Offset: 0x9808
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function step_3_cleanup(var_a276c861, var_19e802fa)
{
	level notify(#"hash_54eae43edf7f08cd");
}

/*
	Name: step_4
	Namespace: namespace_69ddf44f
	Checksum: 0x7A5E8672
	Offset: 0x9838
	Size: 0x384
	Parameters: 1
	Flags: Linked
*/
function step_4(var_a276c861)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_7629706a5a9c7bf7", 4);
	level flag::init(#"hash_67f8280f4ac19125");
	level flag::init(#"hash_2ae01ca8561c1819");
	level flag::init(#"hash_66efd29e4fb12cb5");
	level flag::init(#"hash_46e13471f21f98d0");
	level flag::init(#"hash_6bacf600a3126b18");
	level.var_d668eae7[0] spawner::add_spawn_function(&function_90ce7724);
	if(var_a276c861)
	{
		level.lighting_state = 2;
		self util::set_lighting_state(level.lighting_state);
		level thread function_f52bbbb5();
		return;
	}
	if(!(isdefined(level.var_3e89bfdf) && level.var_3e89bfdf))
	{
		function_2aee0563();
		function_adb645f2();
	}
	level.var_f88b13d6 = level.brutus_max_count;
	level.brutus_max_count = 4;
	level.check_for_valid_spawn_near_team_callback = &function_5bcc5537;
	function_9e1e3766();
	if(!(isdefined(level.var_3e89bfdf) && level.var_3e89bfdf))
	{
		function_6bf2e4d();
		function_27097e44();
	}
	level.lighting_state = 2;
	self util::set_lighting_state(level.lighting_state);
	if(!(isdefined(level.var_3e89bfdf) && level.var_3e89bfdf))
	{
		wait(29);
	}
	else
	{
		/#
			function_314447b(1, 0);
			wait(16);
		#/
	}
	level.var_d804e8a9 = undefined;
	function_ddc5b4e9();
	level thread function_1c978623();
	level flag::set(#"hash_2ae01ca8561c1819");
	level thread function_474ba3b0();
	level thread function_2e3734e2();
	level waittill(#"hash_66efd29e4fb12cb5");
	level thread function_ddf8f11();
	function_8e52cae7();
	function_8562a40f();
}

/*
	Name: step_4_cleanup
	Namespace: namespace_69ddf44f
	Checksum: 0xCFFC9DAD
	Offset: 0x9BC8
	Size: 0x4B4
	Parameters: 2
	Flags: Linked
*/
function step_4_cleanup(var_a276c861, var_19e802fa)
{
	level flag::set(#"hash_6048c3f423fd987");
	level flag::clear("pause_round_timeout");
	callback::remove_on_spawned(&function_1c2b53df);
	exploder::stop_exploder("fxexp_flame_wall_door_glow_recreation_yard");
	exploder::stop_exploder("fxexp_flame_wall_door_glow_shower");
	exploder::stop_exploder("fxexp_flame_wall_door_glow_all");
	zm_bgb_anywhere_but_here::function_886fce8f(1);
	level.check_for_valid_spawn_near_team_callback = undefined;
	level.var_779eb5f5 = undefined;
	level zm_escape_util::function_67710e66(1);
	foreach(e_player in util::get_players())
	{
		if(isdefined(e_player.s_loadout))
		{
			e_player zm_weapons::player_give_loadout(e_player.s_loadout);
			e_player.s_loadout = undefined;
			e_player thread function_30bab0b0(0);
		}
		if(isdefined(e_player.var_1b7ab815))
		{
			e_player zm_trial_util::function_d37a769(e_player.var_1b7ab815);
			e_player.var_1b7ab815 = undefined;
		}
		e_player bgb_pack::function_ac9cb612(0);
	}
	level.var_d668eae7[0] spawner::remove_spawn_function(&function_90ce7724);
	if(isdefined(level.var_dc4013b0))
	{
		zm_escape_util::function_37aed203(level.var_dc4013b0);
		level.var_dc4013b0 = undefined;
	}
	if(!level flag::get(#"hash_2ae01ca8561c1819"))
	{
		function_c2746c7c();
	}
	level flag::delete(#"hash_2ae01ca8561c1819");
	var_669d3a02 = getentarray("mdl_p_s_4_clip", "script_noteworthy");
	array::run_all(var_669d3a02, &delete);
	s_orb = struct::get("s_p_s_4_b_g_p_orb");
	if(isdefined(s_orb.var_b7eee573))
	{
		s_orb.var_b7eee573 delete();
	}
	if(isdefined(level.var_f88b13d6))
	{
		level.brutus_max_count = level.var_f88b13d6;
		level.var_f88b13d6 = undefined;
	}
	if(isdefined(level.var_7a548c75))
	{
		if(isdefined(level.var_7a548c75.mdl_origin))
		{
			level.var_7a548c75.mdl_origin delete();
		}
		level.var_7a548c75 notify(#"delete_seagull");
		level.var_7a548c75 delete();
		level.var_7a548c75 = undefined;
	}
	var_e0630bbb = struct::get("p_s_4_bag");
	if(isdefined(var_e0630bbb.var_36db29e9))
	{
		var_e0630bbb.var_36db29e9 delete();
		var_e0630bbb.var_36db29e9 = undefined;
	}
	s_beam = struct::get("s_p_s1_lh_r_light");
	if(isdefined(s_beam.var_8999a4bf))
	{
		s_beam.var_8999a4bf delete();
	}
}

/*
	Name: function_5bcc5537
	Namespace: namespace_69ddf44f
	Checksum: 0x7D64FCA5
	Offset: 0xA088
	Size: 0x18C
	Parameters: 2
	Flags: Linked
*/
function function_5bcc5537(e_revivee, s_return)
{
	if(!level flag::get(#"hash_46e13471f21f98d0"))
	{
		var_19c35ca = struct::get_array("p_s_4_spawn_start");
	}
	else
	{
		if(level flag::get(#"hash_46e13471f21f98d0") && !level flag::get(#"hash_6bacf600a3126b18"))
		{
			var_19c35ca = struct::get_array("catwalk_04_respawn_points");
		}
		else
		{
			var_19c35ca = struct::get_array("west_side_exterior_upper_02_respawn_points");
		}
	}
	n_player = e_revivee getentitynumber() + 1;
	foreach(s_spawn in var_19c35ca)
	{
		if(s_spawn.script_int == n_player)
		{
			var_660ba218 = s_spawn;
		}
	}
	return var_660ba218;
}

/*
	Name: function_2aee0563
	Namespace: namespace_69ddf44f
	Checksum: 0x24C2ED63
	Offset: 0xA220
	Size: 0x264
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2aee0563()
{
	level endon(#"hash_2f347ddff9fdaeb9", #"hash_4ff99434ccb06268");
	level thread scene::init_streamer(#"hash_722c4512700977d4", #"allies", 0, 0);
	var_704f12cc = struct::get("s_p_s4_s_k_ins");
	var_704f12cc.var_64c09f7f = var_704f12cc zm_unitrigger::function_fac87205("", 64);
	var_704f12cc.mdl_key = util::spawn_model(var_704f12cc.model, var_704f12cc.origin, var_704f12cc.angles);
	var_704f12cc.mdl_key clientfield::set("" + #"summoning_key_glow", 1);
	var_704f12cc.mdl_key playsound(#"hash_421f50c0f5cd0b92");
	function_314447b(1);
	level thread function_a98a79b(var_704f12cc.var_64c09f7f);
	wait(2.9);
	foreach(player in util::get_active_players())
	{
		player thread function_ed3077c1();
	}
	level thread function_72d2079e();
	level flag::wait_till(#"hash_73b06a8a2c0b0e8d");
	var_704f12cc thread function_d82c14e8();
	level waittill(#"hash_2f347ddff9fdaeb9");
}

/*
	Name: function_72d2079e
	Namespace: namespace_69ddf44f
	Checksum: 0xE25D2FCA
	Offset: 0xA490
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_72d2079e()
{
	level endon(#"hash_2f347ddff9fdaeb9");
	wait(16);
	function_314447b(0);
}

/*
	Name: function_ed3077c1
	Namespace: namespace_69ddf44f
	Checksum: 0x3B5E44D7
	Offset: 0xA4D0
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_ed3077c1()
{
	self endon(#"death");
	level endon(#"hash_2f347ddff9fdaeb9");
	s_summoning_key = struct::get(#"s_p_s4_s_k_ins");
	var_3d569543 = 0;
	while(true)
	{
		n_dist_2d_sq = distance2dsquared(s_summoning_key.origin, self.origin);
		if(!var_3d569543 && self zm_zonemgr::is_player_in_zone("zone_warden_home") && n_dist_2d_sq <= 13456)
		{
			self clientfield::set_to_player("rumble_spinning_trap", 1);
			self clientfield::set("" + #"hash_4f58771e117ee3ee", 1);
			var_3d569543 = 1;
		}
		else if(var_3d569543 && (!self zm_zonemgr::is_player_in_zone("zone_warden_home") || n_dist_2d_sq > 13456))
		{
			self clientfield::set_to_player("rumble_spinning_trap", 0);
			self clientfield::set("" + #"hash_4f58771e117ee3ee", 0);
			var_3d569543 = 0;
		}
		waitframe(1);
	}
}

/*
	Name: function_d82c14e8
	Namespace: namespace_69ddf44f
	Checksum: 0x2311D592
	Offset: 0xA6A8
	Size: 0x174
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d82c14e8()
{
	level endon(#"hash_2f347ddff9fdaeb9");
	s_summoning_key = struct::get(#"s_p_s4_s_k_ins");
	while(true)
	{
		var_ff05a672 = zm_zonemgr::get_players_in_zone("zone_warden_home");
		if(var_ff05a672 >= util::get_active_players().size)
		{
			var_a55559f3 = 0;
			foreach(player in util::get_active_players())
			{
				if(distance2dsquared(s_summoning_key.origin, player.origin) <= 13456)
				{
					var_a55559f3++;
				}
			}
			if(var_a55559f3 >= util::get_active_players().size)
			{
				level notify(#"hash_2f347ddff9fdaeb9");
			}
		}
		wait(0.2);
	}
}

/*
	Name: function_adb645f2
	Namespace: namespace_69ddf44f
	Checksum: 0x853A911A
	Offset: 0xA828
	Size: 0x2BC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_adb645f2()
{
	level endon(#"hash_4ff99434ccb06268");
	level flag::set("pause_round_timeout");
	level zm_audio::function_6191af93(#"brutus", #"react", "", "");
	if(isdefined(level.var_3e89bfdf) && level.var_3e89bfdf)
	{
		return;
	}
	level flag::set(#"hash_67f8280f4ac19125");
	scene::add_scene_func(#"hash_722c4512700977d4", &function_bdaf22e8, "Shot 1");
	foreach(e_player in util::get_players())
	{
		if(e_player clientfield::get("" + #"hash_4f58771e117ee3ee"))
		{
			e_player clientfield::set("" + #"hash_4f58771e117ee3ee", 0);
		}
		if(e_player clientfield::get_to_player("rumble_spinning_trap"))
		{
			e_player clientfield::set_to_player("rumble_spinning_trap", 0);
		}
	}
	waitframe(1);
	function_314447b(1, 0);
	level.musicsystemoverride = 1;
	music::setmusicstate("escape_lockup");
	level thread util::delay(5.5, undefined, &function_f8ec40fe);
	level thread util::delay(2, undefined, &function_f52bbbb5);
	level scene::play(#"hash_722c4512700977d4", "Shot 1");
}

/*
	Name: function_f8ec40fe
	Namespace: namespace_69ddf44f
	Checksum: 0x5F1788C2
	Offset: 0xAAF0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_f8ec40fe()
{
	level util::clientnotify("sndlhouse");
}

/*
	Name: function_f52bbbb5
	Namespace: namespace_69ddf44f
	Checksum: 0xDDA331C2
	Offset: 0xAB20
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_f52bbbb5()
{
	s_beam = struct::get(#"s_p_s1_lh_r_light");
	s_beam.var_8999a4bf clientfield::set("" + #"hash_1f572bbcdde55d9d", 0);
	waitframe(1);
	if(isdefined(s_beam.var_8999a4bf))
	{
		s_beam.var_8999a4bf delete();
	}
	waitframe(1);
	exploder::stop_exploder("fxexp_script_l_d");
	exploder::stop_exploder("fxexp_script_l_c");
	exploder::stop_exploder("fxexp_script_l_n_i");
	exploder::stop_exploder("fxexp_script_l_s");
	exploder::stop_exploder("fxexp_script_l_p_p");
}

/*
	Name: function_9e1e3766
	Namespace: namespace_69ddf44f
	Checksum: 0xC1DF0C7
	Offset: 0xAC40
	Size: 0x444
	Parameters: 0
	Flags: Linked, Private
*/
function private function_9e1e3766()
{
	level flag::set(#"activate_cellblock_jail");
	if(!level flag::get(#"hash_67f8280f4ac19125"))
	{
		level flag::set(#"hash_67f8280f4ac19125");
	}
	wait(0.1);
	var_3270baa7 = getentarray("activate_cellblock_ca", "script_flag");
	if(isdefined(var_3270baa7[0]))
	{
		a_e_players = getplayers();
		a_e_players[0] zm_score::add_to_player_score(var_3270baa7[0].zombie_cost);
		var_3270baa7[0] notify(#"trigger", {#is_forced:1, #activator:a_e_players[0]});
	}
	zm_escape_util::function_2f9d355c();
	foreach(e_player in util::get_players())
	{
		e_player thread function_1c2b53df();
	}
	callback::on_spawned(&function_1c2b53df);
	var_e0630bbb = struct::get("p_s_4_bag");
	function_6932a6d4("" + #"duffel_prison");
	var_e0630bbb.s_unitrigger_stub = var_e0630bbb zm_unitrigger::create(&function_7daf4480, 64, &function_3035b012);
	zm_unitrigger::unitrigger_force_per_player_triggers(var_e0630bbb.s_unitrigger_stub, 1);
	scene::add_scene_func("aib_vign_zm_mob_brutus_monologue", &registers_helm_of_the_king_support, "play");
	var_669d3a02 = getentarray("mdl_p_s_4_clip", "script_noteworthy");
	array::run_all(var_669d3a02, &solid);
	wait(0.45);
	foreach(player in util::get_players())
	{
		player setclientuivisibilityflag("hud_visible", 0);
	}
	wait(2.9);
	foreach(e_player in util::get_players())
	{
		e_player thread function_5526beaa();
	}
	lui::screen_fade_in(2);
	if(!(isdefined(level.var_3e89bfdf) && level.var_3e89bfdf))
	{
		function_ac2fa9a4();
	}
}

/*
	Name: function_6932a6d4
	Namespace: namespace_69ddf44f
	Checksum: 0xB6C2D30E
	Offset: 0xB090
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_6932a6d4(var_9076afaf)
{
	foreach(player in util::get_active_players())
	{
		player clientfield::set_to_player(var_9076afaf, 1);
	}
}

/*
	Name: function_5526beaa
	Namespace: namespace_69ddf44f
	Checksum: 0x2A6EE4A4
	Offset: 0xB128
	Size: 0x20C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_5526beaa()
{
	self endon(#"death");
	n_start_time = gettime();
	n_total_time = 0;
	n_time_increment = 1.6;
	n_move_speed = 0;
	if(!self clientfield::get_to_player("" + #"hash_1ee540924e569350"))
	{
		self clientfield::set_to_player("" + #"hash_1ee540924e569350", 1);
	}
	self setmovespeedscale(n_move_speed);
	while(n_total_time < 12)
	{
		self playrumbleonentity("damage_light");
		if(n_total_time >= (12 * 0.61))
		{
			n_time_increment = n_time_increment + 0.5;
		}
		if(n_total_time >= 6 && self clientfield::get_to_player("" + #"hash_1ee540924e569350"))
		{
			self clientfield::set_to_player("" + #"hash_1ee540924e569350", 0);
		}
		n_move_speed = n_move_speed + 0.1;
		if(n_move_speed > 1)
		{
			n_move_speed = 1;
		}
		self setmovespeedscale(n_move_speed);
		wait(n_time_increment);
		n_current_time = gettime();
		n_total_time = (n_current_time - n_start_time) / 1000;
	}
	self setmovespeedscale(1);
}

/*
	Name: function_6bf2e4d
	Namespace: namespace_69ddf44f
	Checksum: 0x82A9CE28
	Offset: 0xB340
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_6bf2e4d()
{
	level endon(#"hash_4ff99434ccb06268");
	if(isdefined(level.var_3e89bfdf) && level.var_3e89bfdf)
	{
		return;
	}
	level scene::play(#"aib_vign_zm_mob_brutus_monologue", "play");
	level.var_779eb5f5 = undefined;
	level.musicsystemoverride = 0;
	music::setmusicstate("none");
}

/*
	Name: function_1c2b53df
	Namespace: namespace_69ddf44f
	Checksum: 0x1C1CE2F4
	Offset: 0xB3E0
	Size: 0x134
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1c2b53df()
{
	self endon(#"disconnect");
	a_s_start_points = struct::get_array("p_s_4_spawn_start");
	n_script_int = self getentitynumber() + 1;
	foreach(s_point in a_s_start_points)
	{
		if(s_point.script_int == n_script_int)
		{
			self setorigin(s_point.origin);
			self setplayerangles(s_point.angles);
			break;
		}
	}
	self thread function_b1130e05();
}

/*
	Name: function_b1130e05
	Namespace: namespace_69ddf44f
	Checksum: 0x59B248E5
	Offset: 0xB520
	Size: 0x28C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b1130e05()
{
	self endon(#"disconnect");
	var_24cc214c = array(getweapon(#"tomahawk_t8"), getweapon(#"tomahawk_t8_upgraded"), getweapon(#"spoon_alcatraz"), getweapon(#"spork_alcatraz"), getweapon(#"spknifeork"), getweapon(#"knife"));
	var_5c9fee42 = [];
	a_w_player_weapons = self getweaponslist();
	foreach(w_player_weapon in a_w_player_weapons)
	{
		if(isinarray(var_24cc214c, w_player_weapon))
		{
			if(!isdefined(var_5c9fee42))
			{
				var_5c9fee42 = [];
			}
			else if(!isarray(var_5c9fee42))
			{
				var_5c9fee42 = array(var_5c9fee42);
			}
			if(!isinarray(var_5c9fee42, w_player_weapon))
			{
				var_5c9fee42[var_5c9fee42.size] = w_player_weapon;
			}
		}
	}
	self function_30bab0b0();
	self.s_loadout = self zm_weapons::player_get_loadout();
	self zm_weapons::player_take_loadout(self.s_loadout);
	self bgb_pack::function_ac9cb612(1);
	self disableweapons();
}

/*
	Name: function_3035b012
	Namespace: namespace_69ddf44f
	Checksum: 0x8DF7CA1D
	Offset: 0xB7B8
	Size: 0x270
	Parameters: 0
	Flags: Linked
*/
function function_3035b012()
{
	self endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		if(isplayer(s_result.activator) && isalive(s_result.activator))
		{
			e_player = s_result.activator;
			e_player enableweapons();
			e_player playsound(#"hash_503df109f2de7783");
			if(isdefined(e_player.s_loadout))
			{
				if(e_player.s_loadout.current == getweapon(#"zhield_spectral_dw") || e_player.s_loadout.current == getweapon(#"zhield_spectral_dw_upgraded"))
				{
					e_player.var_3b5e1037 = 1;
				}
				e_player zm_weapons::player_give_loadout(e_player.s_loadout);
				e_player.s_loadout = undefined;
			}
			e_player thread function_30bab0b0(0);
			if(isdefined(e_player.var_1b7ab815))
			{
				e_player zm_trial_util::function_d37a769(e_player.var_1b7ab815);
				e_player.var_1b7ab815 = undefined;
			}
			e_player bgb_pack::function_ac9cb612(0);
			level notify(#"hash_71944131dc1aa5f0");
			e_player clientfield::set_to_player("" + #"duffel_prison", 0);
			if(!level flag::get(#"hash_6048c3f423fd987"))
			{
				zm_bgb_anywhere_but_here::function_886fce8f(0);
			}
		}
	}
}

/*
	Name: function_7daf4480
	Namespace: namespace_69ddf44f
	Checksum: 0x129D45ED
	Offset: 0xBA30
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function function_7daf4480(player)
{
	if(isdefined(player.s_loadout))
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_645683920df08a26");
		}
		else
		{
			self sethintstring(#"hash_d1d8e2ab13aec92");
		}
		return true;
	}
	return false;
}

/*
	Name: function_90ce7724
	Namespace: namespace_69ddf44f
	Checksum: 0xF63BEFB2
	Offset: 0xBAC0
	Size: 0x11C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_90ce7724()
{
	if(level flag::get(#"hash_66efd29e4fb12cb5") || !level flag::get(#"hash_67f8280f4ac19125"))
	{
		return;
	}
	self.ignore_enemy_count = 1;
	self.b_ignore_cleanup = 1;
	self.ignore_find_flesh = 1;
	self ai::set_behavior_attribute("scripted_mode", 1);
	self thread zombie_utility::delayed_zombie_eye_glow();
	self clientfield::set("brutus_spawn_clientfield", 1);
	self val::set(#"hash_1742bf14f2dc303f", "ignoreall", 1);
	self zombie_utility::set_zombie_run_cycle("walk");
}

/*
	Name: function_f01e5d6d
	Namespace: namespace_69ddf44f
	Checksum: 0xA70EB0B3
	Offset: 0xBBE8
	Size: 0x8C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f01e5d6d()
{
	self endon(#"death");
	self.ignore_find_flesh = 0;
	self ai::set_behavior_attribute("scripted_mode", 0);
	self val::set(#"hash_1742bf14f2dc303f", "ignoreall", 0);
	self zombie_utility::set_zombie_run_cycle("run");
}

/*
	Name: function_ddc5b4e9
	Namespace: namespace_69ddf44f
	Checksum: 0xC0029D9
	Offset: 0xBC80
	Size: 0x458
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ddc5b4e9()
{
	level zm_escape_util::function_67710e66(0);
	level function_ff0c4916();
	var_2f3fca78 = struct::get("s_p_s4_gul");
	level.var_7a548c75 = util::spawn_model(#"hash_91c31763b1101e6", var_2f3fca78.origin, var_2f3fca78.angles);
	level.var_7a548c75 clientfield::set("" + #"seagull_fx", 1);
	level.var_7a548c75 clientfield::set("" + #"hash_504d26c38b96651c", 1);
	level.var_7a548c75.mdl_origin = util::spawn_model("tag_origin", level.var_7a548c75.origin, level.var_7a548c75.angles);
	level.var_7a548c75 linkto(level.var_7a548c75.mdl_origin);
	level.var_7a548c75 playloopsound(#"hash_1f562ccd8b4e7e3b");
	level.var_7a548c75 move_seagull(var_2f3fca78.target);
	level.var_7a548c75.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "attack", level.var_7a548c75);
	level.var_7a548c75 waittill(#"att_fx");
	v_position = function_9cc082d2(level.var_7a548c75.origin, 512);
	if(isdefined(v_position))
	{
		level.var_7a548c75.var_99424b88 = util::spawn_model("tag_origin", v_position[#"point"], level.var_7a548c75.angles);
		level.var_7a548c75.var_99424b88 clientfield::set("" + #"hash_7c708a514455bf88", 1);
	}
	var_a8d69fbd = getent("p_s_4_box", "script_string");
	var_a8d69fbd notify(#"blast_attack");
	exploder::stop_exploder("bx_cellblock_off");
	var_a8d69fbd playsound(#"hash_7d2fc6bbbfda2b1e");
	exploder::exploder("fxexp_flame_wall_door_glow_shower");
	exploder::exploder("fxexp_flame_wall_door_glow_all");
	exploder::exploder("fxexp_flame_wall_door_glow_recreation_yard");
	function_c2746c7c();
	level.var_7a548c75 thread move_seagull("s_p4_gull_wait_0", undefined, 500);
	foreach(e_player in getplayers())
	{
		e_player setclientuivisibilityflag("hud_visible", 1);
	}
}

/*
	Name: function_c2746c7c
	Namespace: namespace_69ddf44f
	Checksum: 0x8E3672BD
	Offset: 0xC0E0
	Size: 0x258
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c2746c7c()
{
	var_39a60b6e = getent("lockup_door_1", "targetname");
	var_4c373090 = getent("lockup_door_2", "targetname");
	var_95124245 = getent("lockup_door_3", "targetname");
	var_a7dbe7d8 = getent("lockup_door_4", "targetname");
	var_39a60b6e movex(39 * -1, 1);
	var_4c373090 movex(39 * -1, 1);
	var_95124245 movex(39, 1);
	var_a7dbe7d8 movex(39, 1);
	playsoundatposition(#"hash_2903807228236fbc", var_39a60b6e.origin);
	playsoundatposition(#"hash_2903807228236fbc", var_4c373090.origin);
	playsoundatposition(#"hash_2903807228236fbc", var_95124245.origin);
	playsoundatposition(#"hash_2903807228236fbc", var_a7dbe7d8.origin);
	foreach(e_player in util::get_active_players())
	{
		e_player enableweapons();
	}
}

/*
	Name: function_2e3734e2
	Namespace: namespace_69ddf44f
	Checksum: 0xB975FF96
	Offset: 0xC340
	Size: 0x2C4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2e3734e2()
{
	level endon(#"hash_6048c3f423fd987");
	level.var_7a548c75 thread function_5b7ba6e0();
	level.s_brutus_spawn = struct::get("p_s_4_br_patrol_spawn");
	if(!isdefined(level.var_dc4013b0))
	{
		level.var_dc4013b0 = zombie_utility::spawn_zombie(level.var_d668eae7[0], undefined, level.s_brutus_spawn);
	}
	level.var_dc4013b0.b_alerted = 0;
	level.var_dc4013b0 thread function_5bc6515c(level.s_brutus_spawn);
	level.var_dc4013b0 thread function_a7c869fb(5);
	level.var_dc4013b0 thread function_1d0df68c("zone_start");
	level thread function_9b417108("s_player_in_library_t", "p_s_4_br_patrol_teleport", 1);
	level thread function_68a43add("zone_cellblock_west", #"hash_3fbae87a461a2833");
	level thread function_20b09fc1();
	level waittill(#"hash_3fbae87a461a2833");
	level thread function_16253726("s_player_in_cd_street_t", #"hash_27676df2bce09242");
	level waittill(#"hash_27676df2bce09242");
	level thread function_68a43add("zone_library", #"hash_3ae7273b29d5ffee");
	level waittill(#"hash_3ae7273b29d5ffee");
	if(isalive(level.var_dc4013b0))
	{
		level thread function_16253726("s_player_in_d_block_t", #"hash_1eb5db47aabd9f93");
		level waittill(#"hash_1eb5db47aabd9f93");
	}
	else
	{
		level notify(#"hash_6d7abf957b99ef6");
	}
	level thread function_68a43add("zone_cellblock_entrance", #"hash_74f17d1c19851203");
	level waittill(#"hash_74f17d1c19851203");
}

/*
	Name: function_7cc834b1
	Namespace: namespace_69ddf44f
	Checksum: 0xC4E056DF
	Offset: 0xC610
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_7cc834b1()
{
	if(isdefined(level.var_dc4013b0))
	{
		while(isdefined(level.var_dc4013b0) && level.var_dc4013b0.origin[0] < 861)
		{
			wait(1.6);
		}
		level notify(#"hash_6d7abf957b99ef6");
	}
}

/*
	Name: function_5b7ba6e0
	Namespace: namespace_69ddf44f
	Checksum: 0x3F42F019
	Offset: 0xC688
	Size: 0x27C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_5b7ba6e0()
{
	self endon(#"death");
	s_result = undefined;
	s_result = level waittill(#"hash_71944131dc1aa5f0", #"hash_3fbae87a461a2833");
	self thread move_seagull("s_p4_gull_wait_1", #"hash_3ae7273b29d5ffee", 500);
	level waittill(#"hash_27676df2bce09242");
	self thread move_seagull("s_p4_gull_wait_3", #"hash_1eb5db47aabd9f93", 500);
	level thread function_7cc834b1();
	if(isalive(level.var_dc4013b0))
	{
		level.var_dc4013b0 thread function_f361a74e();
	}
	level waittill(#"hash_6d7abf957b99ef6", #"hash_61d9bcdf0dc6a4cc", #"hash_671f280acd6d81fc");
	if(isalive(level.var_dc4013b0))
	{
		self thread move_seagull("s_p4_gull_wait_4", #"spawn_dog_patrol", 500, 1);
		level waittill(#"spawn_dog_patrol", #"hash_61d9bcdf0dc6a4cc", #"hash_671f280acd6d81fc");
		wait(2.9);
	}
	if(isalive(level.var_dc4013b0) && level.var_dc4013b0 ai::get_behavior_attribute("scripted_mode"))
	{
		level notify(#"hash_5694107be23fa3c2");
		level thread zm_escape_util::function_37aed203(level.var_dc4013b0);
		wait(1);
	}
	self thread move_seagull(#"hash_20824ff037f0ef57", #"hash_573bca7543322902", 500);
}

/*
	Name: function_f361a74e
	Namespace: namespace_69ddf44f
	Checksum: 0x895854C7
	Offset: 0xC910
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function function_f361a74e()
{
	self waittill(#"death");
	level notify(#"hash_671f280acd6d81fc");
}

/*
	Name: function_9e1370d4
	Namespace: namespace_69ddf44f
	Checksum: 0x249B9A34
	Offset: 0xC948
	Size: 0x100
	Parameters: 0
	Flags: Private
*/
function private function_9e1370d4()
{
	level endon(#"hash_6048c3f423fd987");
	self endon(#"hash_3ae5db037968d6de");
	while(true)
	{
		foreach(e_player in util::get_active_players())
		{
			if(distance2dsquared(self.origin, e_player.origin) < 128 * 128)
			{
				self notify(#"player_close");
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_5bc6515c
	Namespace: namespace_69ddf44f
	Checksum: 0xBD34CD86
	Offset: 0xCA50
	Size: 0x1BC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5bc6515c(s_brutus_spawn)
{
	self endon(#"death", #"damage", #"brutus_attack_players", #"teleport_brutus");
	level endon(#"hash_6048c3f423fd987");
	if(s_brutus_spawn.targetname === "p_s_4_br_patrol_spawn")
	{
		self thread function_9a832000();
		level waittill(#"hash_3fbae87a461a2833");
		wait(0.1);
	}
	s_next = struct::get(s_brutus_spawn.target);
	while(isdefined(s_next))
	{
		self setgoal(s_next.origin, 1);
		self waittill(#"goal");
		level.s_brutus_spawn = s_next;
		s_next = struct::get(s_next.target);
	}
	if(isalive(level.var_dc4013b0) && level.var_dc4013b0 ai::get_behavior_attribute("scripted_mode"))
	{
		level notify(#"hash_5694107be23fa3c2");
		level thread zm_escape_util::function_37aed203(level.var_dc4013b0);
	}
}

/*
	Name: function_9a832000
	Namespace: namespace_69ddf44f
	Checksum: 0x9ABE5B9B
	Offset: 0xCC18
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_9a832000()
{
	self endon(#"death", #"damage", #"brutus_attack_players", #"teleport_brutus");
	level endon(#"hash_6048c3f423fd987", #"hash_3fbae87a461a2833");
	while(true)
	{
		self setgoal(self.origin, 1);
		waitframe(1);
	}
}

/*
	Name: function_1d0df68c
	Namespace: namespace_69ddf44f
	Checksum: 0xB311927F
	Offset: 0xCCC0
	Size: 0x98
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1d0df68c(var_b631c17a)
{
	self endon(#"death", #"brutus_attack_players");
	while(true)
	{
		str_zone = zm_zonemgr::get_zone_from_position(self.origin);
		if(isdefined(str_zone) && str_zone == var_b631c17a)
		{
			level notify(#"hash_585f05da94c76f1c");
			break;
		}
		wait(1);
	}
}

/*
	Name: function_a7c869fb
	Namespace: namespace_69ddf44f
	Checksum: 0xB7D02F60
	Offset: 0xCD60
	Size: 0x22E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a7c869fb(n_wait)
{
	self endon(#"death");
	self endoncallback(&function_75b71c1f, #"damage", #"brutus_attack_players");
	level endon(#"hash_6048c3f423fd987");
	if(isdefined(n_wait) && isfloat(n_wait))
	{
		wait(n_wait);
	}
	var_9ecee84e = 0;
	while(true)
	{
		var_252b80e8 = 0;
		foreach(e_player in util::get_active_players())
		{
			if(distance2dsquared(e_player.origin, self.origin) < 116 * 116)
			{
				var_252b80e8 = 1;
				if(distance2dsquared(e_player.origin, self.origin) < 64 * 64)
				{
					self notify(#"brutus_attack_players");
				}
			}
		}
		if(var_252b80e8)
		{
			var_9ecee84e++;
		}
		else
		{
			var_9ecee84e--;
			if(var_9ecee84e < 0)
			{
				var_9ecee84e = 0;
			}
		}
		if(var_9ecee84e >= 16)
		{
			self notify(#"brutus_attack_players");
		}
		/#
			circle(self.origin, 116, (1, 0, 0), 0, 1);
		#/
		waitframe(1);
	}
}

/*
	Name: function_75b71c1f
	Namespace: namespace_69ddf44f
	Checksum: 0x64CDD440
	Offset: 0xCF98
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_75b71c1f(str_notify)
{
	self endon(#"death");
	self.b_alerted = 1;
	level notify(#"hash_61d9bcdf0dc6a4cc");
	self thread function_f01e5d6d();
	n_line = randomint(5);
	self playsound(#"hash_562d11f32f1fc4f3" + n_line);
}

/*
	Name: function_9b417108
	Namespace: namespace_69ddf44f
	Checksum: 0xB9664B5F
	Offset: 0xD040
	Size: 0x3A4
	Parameters: 3
	Flags: Linked
*/
function function_9b417108(str_target, str_teleport_name, var_39e3a318 = 0)
{
	level.var_dc4013b0 endon(#"brutus_attack_players", #"death");
	s_check = struct::get(str_target);
	var_25c3b71c = spawn("trigger_radius", s_check.origin, 0, s_check.radius, 100);
	var_25c3b71c setteamfortrigger(#"allies");
	s_result = undefined;
	s_result = var_25c3b71c waittill(#"trigger");
	var_25c3b71c delete();
	level notify(#"hash_6d7abf957b99ef6");
	b_continue = 1;
	while(b_continue)
	{
		e_player_closest = util::get_active_players()[0];
		if(util::get_active_players().size > 1)
		{
			n_dist_sq_closest = distance2dsquared(e_player_closest.origin, level.var_dc4013b0.origin);
			for(i = 1; i < util::get_active_players().size; i++)
			{
				n_dist_sq = distance2dsquared(util::get_active_players()[i].origin, level.var_dc4013b0.origin);
				if(n_dist_sq < n_dist_sq_closest)
				{
					e_player_closest = util::get_active_players()[i];
					n_dist_sq_closest = n_dist_sq;
				}
			}
		}
		if(!e_player_closest util::is_looking_at(level.var_dc4013b0))
		{
			b_continue = 0;
			break;
		}
		waitframe(1);
	}
	if(level.var_dc4013b0 ai::get_behavior_attribute("scripted_mode"))
	{
		level.var_dc4013b0 notify(#"teleport_brutus");
		level.var_dc4013b0 clientfield::set("brutus_spawn_clientfield", 0);
		level.s_brutus_spawn = struct::get(str_teleport_name);
		level.var_dc4013b0 forceteleport(level.s_brutus_spawn.origin, level.s_brutus_spawn.angles);
		waitframe(1);
		level.var_dc4013b0 clientfield::set("brutus_spawn_clientfield", 1);
		level.var_dc4013b0 function_5bc6515c(level.s_brutus_spawn);
	}
}

/*
	Name: function_68a43add
	Namespace: namespace_69ddf44f
	Checksum: 0x3AA939FB
	Offset: 0xD3F0
	Size: 0x68
	Parameters: 2
	Flags: Linked, Private
*/
function private function_68a43add(str_zone, var_c34665fc)
{
	level endon(var_c34665fc);
	while(true)
	{
		n_players = zm_zonemgr::get_players_in_zone(str_zone);
		if(n_players > 0)
		{
			level notify(var_c34665fc);
		}
		wait(0.1);
	}
}

/*
	Name: function_16253726
	Namespace: namespace_69ddf44f
	Checksum: 0xD53EA6F5
	Offset: 0xD460
	Size: 0xE6
	Parameters: 2
	Flags: Linked
*/
function function_16253726(str_name, var_c34665fc)
{
	level endon(var_c34665fc);
	var_14127942 = struct::get(str_name);
	var_25c3b71c = spawn("trigger_radius", var_14127942.origin, 0, var_14127942.radius, 100);
	var_25c3b71c setteamfortrigger(#"allies");
	s_result = undefined;
	s_result = var_25c3b71c waittill(#"trigger");
	var_25c3b71c delete();
	level notify(var_c34665fc);
}

/*
	Name: function_20b09fc1
	Namespace: namespace_69ddf44f
	Checksum: 0x8E937791
	Offset: 0xD550
	Size: 0x25C
	Parameters: 0
	Flags: Linked
*/
function function_20b09fc1()
{
	function_16253726(#"hash_71c45db075d0f127", #"spawn_dog_patrol");
	s_spawn = struct::get(#"hash_d808e38f50220cb");
	level.var_c28f6f4b = zombie_utility::spawn_zombie(level.dog_spawners[0], s_spawn.origin);
	level.var_c28f6f4b endon(#"death");
	level.var_c28f6f4b.b_alerted = 0;
	waitframe(1);
	level.var_c28f6f4b zm_escape_util::function_7273c33d(s_spawn);
	level.var_c28f6f4b val::set(#"dog_patrol", "ignoreall", 1);
	while(!level.var_c28f6f4b.b_alerted && isdefined(level.var_dc4013b0) && !level.var_dc4013b0.b_alerted)
	{
		foreach(player in util::get_active_players())
		{
			if(distance2dsquared(player.origin, level.var_c28f6f4b.origin) < 16384)
			{
				level.var_c28f6f4b.b_alerted = 1;
				break;
			}
		}
		waitframe(1);
	}
	level.var_c28f6f4b val::set(#"dog_patrol", "ignoreall", 0);
}

/*
	Name: function_26609819
	Namespace: namespace_69ddf44f
	Checksum: 0x86CBD40
	Offset: 0xD7B8
	Size: 0x190
	Parameters: 0
	Flags: Private
*/
function private function_26609819()
{
	level endon(#"hash_46e13471f21f98d0");
	var_e93479e2 = [];
	level waittill(#"hash_27676df2bce09242");
	while(true)
	{
		while(var_e93479e2.size >= 3)
		{
			function_1eaaceab(var_e93479e2);
			waitframe(1);
		}
		if(zombie_utility::get_current_zombie_count() < zombie_utility::function_d2dfacfd(#"zombie_max_ai"))
		{
			ai_dog = zombie_dog_util::function_62db7b1c(1, undefined);
			waitframe(1);
		}
		if(isdefined(ai_dog))
		{
			if(!isdefined(var_e93479e2))
			{
				var_e93479e2 = [];
			}
			else if(!isarray(var_e93479e2))
			{
				var_e93479e2 = array(var_e93479e2);
			}
			if(!isinarray(var_e93479e2, ai_dog))
			{
				var_e93479e2[var_e93479e2.size] = ai_dog;
			}
		}
		wait(randomfloatrange(10, 30));
		function_1eaaceab(var_e93479e2);
	}
}

/*
	Name: function_474ba3b0
	Namespace: namespace_69ddf44f
	Checksum: 0xB85839F0
	Offset: 0xD950
	Size: 0xF4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_474ba3b0()
{
	level endon(#"hash_6048c3f423fd987");
	level waittill(#"spawn_dog_patrol");
	s_brutus_spawn = struct::get("p_s_4_br_stun_spawn");
	var_996029a9 = zombie_utility::spawn_zombie(level.var_d668eae7[0]);
	waitframe(1);
	var_996029a9 forceteleport(s_brutus_spawn.origin, s_brutus_spawn.angles);
	var_996029a9 val::set(#"hash_1742bf14f2dc303f", "ignoreall", 1);
	var_996029a9 thread function_6758392d();
}

/*
	Name: function_6758392d
	Namespace: namespace_69ddf44f
	Checksum: 0x3710CD77
	Offset: 0xDA50
	Size: 0x1DE
	Parameters: 0
	Flags: Linked, Private
*/
function private function_6758392d()
{
	self endoncallback(&function_ac2a83ab, #"damage", #"detected_players");
	self endon(#"death");
	b_continue = 1;
	s_detect = struct::get("s_br_detect");
	while(b_continue)
	{
		foreach(e_player in util::get_players())
		{
			if(distance2dsquared(e_player.origin, s_detect.origin) < s_detect.radius * s_detect.radius)
			{
				str_zone = e_player zm_zonemgr::get_player_zone();
				if(self sightconetrace(e_player getweaponmuzzlepoint(), e_player, e_player getweaponforwarddir(), 65) || (isdefined(str_zone) && str_zone == "zone_cellblock_entrance"))
				{
					b_continue = 0;
					break;
				}
			}
		}
		waitframe(1);
	}
	self notify(#"detected_players");
}

/*
	Name: function_ac2a83ab
	Namespace: namespace_69ddf44f
	Checksum: 0x9FC1B101
	Offset: 0xDC38
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_ac2a83ab(str_notify)
{
	self function_f01e5d6d();
	level thread function_65c7c787(self);
}

/*
	Name: function_65c7c787
	Namespace: namespace_69ddf44f
	Checksum: 0x88BBFC7A
	Offset: 0xDC80
	Size: 0x294
	Parameters: 1
	Flags: Linked, Private
*/
function private function_65c7c787(e_brutus)
{
	level notify(#"hash_573bca7543322902");
	e_brutus val::set(#"hash_54a371c662e546eb", "allowdeath", 0);
	while(isalive(e_brutus) && distance2dsquared(e_brutus.origin, level.var_7a548c75.mdl_origin.origin) > 147456)
	{
		waitframe(1);
	}
	level notify(#"hash_573bca7543322902");
	level.var_7a548c75 stopanimscripted();
	level.var_7a548c75.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "attack", level.var_7a548c75);
	level.var_7a548c75 waittill(#"att_fx");
	v_position = function_9cc082d2(level.var_7a548c75.origin, 512);
	if(isdefined(v_position))
	{
		if(isdefined(level.var_7a548c75.var_99424b88))
		{
			level.var_7a548c75.var_99424b88 delete();
			waitframe(1);
		}
		level.var_7a548c75.var_99424b88 = util::spawn_model("tag_origin", v_position[#"point"], level.var_7a548c75.angles);
		level.var_7a548c75.var_99424b88 clientfield::set("" + #"hash_7c708a514455bf88", 1);
	}
	if(isalive(e_brutus))
	{
		e_brutus thread function_dbe333cb(2.9);
	}
	else
	{
		level flag::set(#"hash_66efd29e4fb12cb5");
	}
}

/*
	Name: function_dbe333cb
	Namespace: namespace_69ddf44f
	Checksum: 0x66CF7F28
	Offset: 0xDF20
	Size: 0xDC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_dbe333cb(n_time)
{
	self endon(#"death");
	self clientfield::set("" + #"hash_27db1707c088563c", 1);
	self ai::stun(n_time);
	level flag::set(#"hash_66efd29e4fb12cb5");
	wait(n_time);
	self clientfield::set("" + #"hash_27db1707c088563c", 0);
	self val::reset(#"hash_54a371c662e546eb", "allowdeath");
}

/*
	Name: function_8e52cae7
	Namespace: namespace_69ddf44f
	Checksum: 0xACACEEE
	Offset: 0xE008
	Size: 0x2AC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8e52cae7()
{
	level endon(#"hash_6048c3f423fd987");
	callback::remove_on_spawned(&function_1c2b53df);
	level.var_7a548c75 thread function_c7e7b5c7();
	level thread function_1e1e575e();
	level thread function_3ec723c4();
	level thread function_5deecaa4();
	level thread function_83467abf();
	level thread function_67646b91();
	level thread function_16253726("s_player_w_g_1", #"s_player_w_g_1");
	level thread function_16253726("s_player_w_g_2", #"s_player_w_g_2");
	level thread function_16253726("s_player_w_g_3", #"s_player_w_g_3");
	level thread function_16253726("s_player_w_g_4", #"s_player_w_g_4");
	level thread function_16253726("s_player_w_g_5", #"s_player_w_g_5");
	level thread function_16253726("s_player_w_g_6", #"s_player_w_g_6");
	level thread function_16253726("s_player_w_g_7", #"s_player_w_g_7");
	a_s_dog_spawn = struct::get_array("s_p_s_4_c_d_s");
	foreach(s_spawn in a_s_dog_spawn)
	{
		s_spawn thread function_d8e03d9e();
	}
	level flag::wait_till(#"hash_6bacf600a3126b18");
	function_c53dbd56();
}

/*
	Name: function_c7e7b5c7
	Namespace: namespace_69ddf44f
	Checksum: 0x4FD4F35A
	Offset: 0xE2C0
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function function_c7e7b5c7()
{
	level endon(#"hash_6048c3f423fd987");
	self thread move_seagull("s_p4_gull_wait_6", #"s_player_w_g_1", 500);
	level waittill(#"s_player_w_g_1");
	self thread move_seagull("s_p4_gull_wait_7", #"s_player_w_g_2", 500);
	level waittill(#"s_player_w_g_2");
	self thread move_seagull("s_p4_gull_wait_8", #"s_player_w_g_3", 500);
	level waittill(#"s_player_w_g_3");
	self thread move_seagull("s_p4_gull_wait_9", #"s_player_w_g_4", 500);
	level waittill(#"s_player_w_g_4");
	self thread move_seagull("s_p4_gull_wait_10", #"s_player_w_g_5", 500);
	level waittill(#"s_player_w_g_5");
	self thread move_seagull("s_p4_gull_wait_11", #"s_player_w_g_6", 500);
	level waittill(#"s_player_w_g_6");
	self thread move_seagull("s_p4_gull_wait_12", #"s_player_w_g_7", 500);
	level waittill(#"s_player_w_g_7");
	self thread move_seagull("s_p4_gull_wait_13", undefined, 500);
}

/*
	Name: function_1e1e575e
	Namespace: namespace_69ddf44f
	Checksum: 0x980EBD33
	Offset: 0xE4F8
	Size: 0xF4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1e1e575e()
{
	level endon(#"hash_6048c3f423fd987");
	var_8ec71cec = getent("mdl_p_s_4_clip_entrance", "targetname");
	var_8ec71cec notsolid();
	var_8ec71cec hide();
	exploder::stop_exploder("fxexp_flame_wall_door_glow_recreation_yard");
	level flag::wait_till(#"hash_46e13471f21f98d0");
	var_8ec71cec show();
	var_8ec71cec solid();
	exploder::exploder("fxexp_flame_wall_door_glow_recreation_yard");
}

/*
	Name: function_3ec723c4
	Namespace: namespace_69ddf44f
	Checksum: 0x78CF2B36
	Offset: 0xE5F8
	Size: 0xAE
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3ec723c4()
{
	level endon(#"hash_6048c3f423fd987", #"hash_46e13471f21f98d0", #"hash_5a3a303c081e246e");
	while(true)
	{
		var_34f95e28 = function_c482e40a();
		if(var_34f95e28 == 0)
		{
			level thread function_868655b9();
			level flag::set(#"hash_46e13471f21f98d0");
		}
		waitframe(1);
	}
}

/*
	Name: function_8a1ab660
	Namespace: namespace_69ddf44f
	Checksum: 0xB48187D6
	Offset: 0xE6B0
	Size: 0x15C
	Parameters: 0
	Flags: Private
*/
function private function_8a1ab660()
{
	level endon(#"hash_6048c3f423fd987");
	level.var_dc4013b0 endon(#"death", #"brutus_attack_players");
	if(!isdefined(level.var_dc4013b0))
	{
		return;
	}
	s_kill = struct::get("s_br_kill");
	b_continue = 1;
	while(b_continue)
	{
		if(distance2dsquared(level.var_dc4013b0.origin, s_kill.origin) < s_kill.radius * s_kill.radius)
		{
			b_continue = 0;
		}
		waitframe(1);
	}
	if(isalive(level.var_dc4013b0) && level.var_dc4013b0 ai::get_behavior_attribute("scripted_mode"))
	{
		level notify(#"hash_5694107be23fa3c2");
		zm_escape_util::function_37aed203(level.var_dc4013b0);
	}
}

/*
	Name: function_c482e40a
	Namespace: namespace_69ddf44f
	Checksum: 0x1C51E9CB
	Offset: 0xE818
	Size: 0xE0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c482e40a()
{
	a_str_zones = array("zone_cellblock_entrance", "zone_cellblock_east", "zone_start", "zone_library", "zone_cellblock_west", "zone_broadway_floor_2", "zone_cellblock_west_gondola");
	var_34f95e28 = 0;
	foreach(str_zone in a_str_zones)
	{
		var_34f95e28 = var_34f95e28 + zm_zonemgr::get_players_in_zone(str_zone);
	}
	return var_34f95e28;
}

/*
	Name: function_5deecaa4
	Namespace: namespace_69ddf44f
	Checksum: 0x434236E4
	Offset: 0xE900
	Size: 0xD8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_5deecaa4()
{
	level endon(#"hash_6048c3f423fd987", #"hash_46e13471f21f98d0");
	while(true)
	{
		wait(6.1);
		foreach(e_player in util::get_active_players())
		{
			if(level.brutus_count < level.brutus_max_count)
			{
				zombie_brutus_util::attempt_brutus_spawn(1);
				break;
			}
		}
	}
}

/*
	Name: function_868655b9
	Namespace: namespace_69ddf44f
	Checksum: 0x3ACCD64F
	Offset: 0xE9E0
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function function_868655b9(str_notify)
{
	a_e_brutus = getaiarchetypearray(#"brutus");
	if(a_e_brutus.size > 1)
	{
		for(i = 0; i < a_e_brutus.size - 1; i++)
		{
			e_brutus = a_e_brutus[i];
			zm_escape_util::function_37aed203(e_brutus);
		}
	}
}

/*
	Name: function_f28c854b
	Namespace: namespace_69ddf44f
	Checksum: 0xE40D7D7F
	Offset: 0xEA88
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
function private function_f28c854b()
{
	level endon(#"hash_6048c3f423fd987", #"hash_6bacf600a3126b18");
	while(true)
	{
		a_e_brutus = getaiarchetypearray(#"brutus");
		if(a_e_brutus.size == 0)
		{
			zombie_brutus_util::attempt_brutus_spawn(1);
		}
		wait(2);
	}
}

/*
	Name: function_d8e03d9e
	Namespace: namespace_69ddf44f
	Checksum: 0x71E6DCE8
	Offset: 0xEB20
	Size: 0x218
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d8e03d9e()
{
	level endon(#"hash_6048c3f423fd987", #"hash_6bacf600a3126b18");
	self.var_25c3b71c = spawn("trigger_radius", self.origin, 0, self.radius, 200);
	self.var_25c3b71c setteamfortrigger(#"allies");
	self.var_25c3b71c waittill(#"trigger");
	self.var_25c3b71c delete();
	level notify(self.targetname);
	a_s_dog_spawns = struct::get_array(self.target);
	foreach(s_dog_spawn in a_s_dog_spawns)
	{
		if(!isdefined(s_dog_spawn.script_int) || (isdefined(s_dog_spawn.script_int) && s_dog_spawn.script_int <= util::get_active_players().size))
		{
			e_dog = zombie_utility::spawn_zombie(level.dog_spawners[0]);
			waitframe(1);
			if(isalive(e_dog))
			{
				e_dog thread zm_escape_util::function_7273c33d(s_dog_spawn);
				e_dog ai::set_behavior_attribute("sprint", 1);
			}
		}
	}
}

/*
	Name: function_67646b91
	Namespace: namespace_69ddf44f
	Checksum: 0x1DE84EC8
	Offset: 0xED40
	Size: 0xA20
	Parameters: 0
	Flags: Linked, Private
*/
function private function_67646b91()
{
	level endon(#"hash_6048c3f423fd987", #"hash_6bacf600a3126b18");
	var_bc24de55 = [];
	var_ca5e7ac8 = [];
	var_ef103e8 = [];
	var_3c4a5e9a = [];
	var_cbf12efc = [];
	var_213bd990 = [];
	var_eaad775 = struct::get_array("dog_location", "script_noteworthy");
	foreach(s_loc in var_eaad775)
	{
		switch(s_loc.targetname)
		{
			case "hash_2fabd8fdb4f5a1a3":
			{
				if(!isdefined(var_3c4a5e9a))
				{
					var_3c4a5e9a = [];
				}
				else if(!isarray(var_3c4a5e9a))
				{
					var_3c4a5e9a = array(var_3c4a5e9a);
				}
				if(!isinarray(var_3c4a5e9a, s_loc))
				{
					var_3c4a5e9a[var_3c4a5e9a.size] = s_loc;
				}
				break;
			}
			case "hash_12643042b422bb7c":
			{
				if(!isdefined(var_ef103e8))
				{
					var_ef103e8 = [];
				}
				else if(!isarray(var_ef103e8))
				{
					var_ef103e8 = array(var_ef103e8);
				}
				if(!isinarray(var_ef103e8, s_loc))
				{
					var_ef103e8[var_ef103e8.size] = s_loc;
				}
				break;
			}
			case "hash_16a7184ca95fade1":
			{
				if(!isdefined(var_ca5e7ac8))
				{
					var_ca5e7ac8 = [];
				}
				else if(!isarray(var_ca5e7ac8))
				{
					var_ca5e7ac8 = array(var_ca5e7ac8);
				}
				if(!isinarray(var_ca5e7ac8, s_loc))
				{
					var_ca5e7ac8[var_ca5e7ac8.size] = s_loc;
				}
				break;
			}
			case "hash_116cd8a82caef692":
			{
				if(!isdefined(var_bc24de55))
				{
					var_bc24de55 = [];
				}
				else if(!isarray(var_bc24de55))
				{
					var_bc24de55 = array(var_bc24de55);
				}
				if(!isinarray(var_bc24de55, s_loc))
				{
					var_bc24de55[var_bc24de55.size] = s_loc;
				}
				break;
			}
			case "hash_766712dab6b3164c":
			{
				if(!isdefined(var_cbf12efc))
				{
					var_cbf12efc = [];
				}
				else if(!isarray(var_cbf12efc))
				{
					var_cbf12efc = array(var_cbf12efc);
				}
				if(!isinarray(var_cbf12efc, s_loc))
				{
					var_cbf12efc[var_cbf12efc.size] = s_loc;
				}
			}
			case "hash_237e2248f9ded6e2":
			{
				if(!isdefined(var_213bd990))
				{
					var_213bd990 = [];
				}
				else if(!isarray(var_213bd990))
				{
					var_213bd990 = array(var_213bd990);
				}
				if(!isinarray(var_213bd990, s_loc))
				{
					var_213bd990[var_213bd990.size] = s_loc;
				}
				break;
			}
		}
	}
	var_176b3d5e = 3;
	if(util::get_active_players().size > 1)
	{
		var_176b3d5e = (3 + util::get_active_players().size) - 1;
	}
	level waittill(#"s_p_s_4_c_d_s");
	while(true)
	{
		a_ai = getaiteamarray(level.zombie_team);
		if(a_ai.size > var_176b3d5e)
		{
			wait(randomfloatrange(1.6, 2.9));
			continue;
		}
		var_3c4a5e9a = array::randomize(var_3c4a5e9a);
		var_ef103e8 = array::randomize(var_ef103e8);
		var_ca5e7ac8 = array::randomize(var_ca5e7ac8);
		var_bc24de55 = array::randomize(var_bc24de55);
		var_cbf12efc = array::randomize(var_cbf12efc);
		var_213bd990 = array::randomize(var_213bd990);
		var_93403046 = zm_zonemgr::get_players_in_zone("zone_catwalk_01", 1);
		var_a0fd4bc0 = zm_zonemgr::get_players_in_zone("zone_catwalk_02", 1);
		var_ae7c66be = zm_zonemgr::get_players_in_zone("zone_catwalk_03", 1);
		var_3c44024b = zm_zonemgr::get_players_in_zone("zone_catwalk_04", 1);
		var_8e73a2b5 = zm_zonemgr::get_players_in_zone("zone_cellblock_entrance", 1);
		if(var_93403046.size > 0)
		{
			s_loc = arraygetfarthest(var_93403046[0].origin, var_cbf12efc);
			n_dist_sq = distance2dsquared(var_93403046[0].origin, s_loc.origin);
			if(!isdefined(s_loc) || n_dist_sq < 1245456)
			{
				s_loc = arraygetfarthest(var_93403046[0].origin, var_213bd990);
			}
		}
		else
		{
			if(var_a0fd4bc0.size > 0)
			{
				s_loc = arraygetfarthest(var_a0fd4bc0[0].origin, var_3c4a5e9a);
				n_dist_sq = distance2dsquared(var_a0fd4bc0[0].origin, s_loc.origin);
				if(!isdefined(s_loc) || n_dist_sq < 1245456)
				{
					s_loc = arraygetfarthest(var_a0fd4bc0[0].origin, var_cbf12efc);
				}
			}
			else
			{
				if(var_ae7c66be.size > 0)
				{
					s_loc = arraygetfarthest(var_ae7c66be[0].origin, var_ef103e8);
					n_dist_sq = distance2dsquared(var_ae7c66be[0].origin, s_loc.origin);
					if(!isdefined(s_loc) || n_dist_sq < 1245456)
					{
						s_loc = arraygetfarthest(var_ae7c66be[0].origin, var_3c4a5e9a);
					}
				}
				else
				{
					if(var_3c44024b.size > 0)
					{
						s_loc = arraygetfarthest(var_3c44024b[0].origin, var_ca5e7ac8);
						n_dist_sq = distance2dsquared(var_3c44024b[0].origin, s_loc.origin);
						if(!isdefined(s_loc) || n_dist_sq < 1245456)
						{
							s_loc = arraygetfarthest(var_3c44024b[0].origin, var_ef103e8);
						}
					}
					else if(var_8e73a2b5.size > 0)
					{
						s_loc = arraygetfarthest(var_8e73a2b5[0].origin, var_bc24de55);
						n_dist_sq = distance2dsquared(var_8e73a2b5[0].origin, s_loc.origin);
						if(!isdefined(s_loc) || n_dist_sq < 1245456)
						{
							s_loc = arraygetfarthest(var_8e73a2b5[0].origin, var_ca5e7ac8);
						}
					}
				}
			}
		}
		if(isdefined(s_loc))
		{
			e_dog = zombie_utility::spawn_zombie(level.dog_spawners[0]);
			if(isdefined(e_dog))
			{
				waitframe(1);
				e_dog thread zm_escape_util::function_7273c33d(s_loc);
				e_dog ai::set_behavior_attribute("sprint", 1);
			}
		}
		wait(randomfloatrange(1.6, 2.9));
	}
}

/*
	Name: function_83467abf
	Namespace: namespace_69ddf44f
	Checksum: 0x70511D03
	Offset: 0xF768
	Size: 0x90
	Parameters: 0
	Flags: Linked, Private
*/
function private function_83467abf()
{
	level endon(#"hash_6048c3f423fd987", #"hash_6bacf600a3126b18");
	while(true)
	{
		n_players = zm_zonemgr::get_players_in_zone("zone_west_side_exterior_upper_02");
		if(n_players > 0)
		{
			level flag::set(#"hash_6bacf600a3126b18");
		}
		wait(1.6);
	}
}

/*
	Name: function_c53dbd56
	Namespace: namespace_69ddf44f
	Checksum: 0x1B2BC5CC
	Offset: 0xF800
	Size: 0xA8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c53dbd56()
{
	a_e_brutus = getaiarchetypearray(#"brutus");
	foreach(e_brutus in a_e_brutus)
	{
		level thread zm_escape_util::function_37aed203(e_brutus);
	}
}

/*
	Name: function_8562a40f
	Namespace: namespace_69ddf44f
	Checksum: 0x4DB8E570
	Offset: 0xF8B0
	Size: 0x6EC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8562a40f()
{
	level endon(#"hash_6048c3f423fd987");
	scene::add_scene_func(#"hash_314849ff967504f5", &function_b2c57ad7, "play");
	s_orb = struct::get("s_p_s_4_b_g_p_orb");
	s_orb.var_b7eee573 = util::spawn_model(s_orb.model, s_orb.origin, s_orb.angles);
	s_orb.var_b7eee573 setscale(3);
	s_orb.var_b7eee573 ghost();
	var_17188289 = struct::get("s_p_s_4_b_g_p");
	var_b21b4155 = 0;
	while(!var_b21b4155)
	{
		foreach(e_player in util::get_players())
		{
			if(distance2dsquared(e_player.origin, var_17188289.origin) <= (var_17188289.radius * var_17188289.radius))
			{
				var_b21b4155 = 1;
				break;
			}
		}
		if(!var_b21b4155)
		{
			wait(0.1);
		}
	}
	level zm_utility::function_9ad5aeb1(0, 1, 0, 0);
	function_868655b9();
	level notify(#"hash_5a3a303c081e246e");
	var_a4257067 = struct::get("s_p_s_4_b_r_s");
	var_a4257067 thread scene::play(var_a4257067.scriptbundlename, "Shot 1");
	var_a4257067.scene_ents[#"brutus"] waittill(#"play_fx");
	var_a4257067.scene_ents[#"brutus"] clientfield::increment("" + #"hash_2b6e463a7a482630");
	var_a4257067.scene_ents[#"brutus"] waittill(#"teleport");
	var_a4257067.scene_ents[#"brutus"] ghost();
	foreach(e_player in util::get_active_players())
	{
		e_player playrumbleonentity("damage_heavy");
	}
	level thread scene::play("s_p_s_4_b_g_p_s", "play");
	level waittill(#"drop_o");
	level.var_7a548c75 playsound(#"hash_6cd665a68de4367e");
	level.var_7a548c75.mdl_origin moveto(level.var_7a548c75.mdl_origin.origin + (vectornormalize(anglestoforward(level.var_7a548c75.mdl_origin.angles)) * 48), 1);
	level.var_7a548c75.mdl_origin scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "dissolve", level.var_7a548c75);
	level.var_7a548c75.mdl_origin clientfield::set("" + #"hash_592c96b2803d9fd5", 1);
	level.var_7a548c75 ghost();
	level.var_7a548c75 stoploopsound();
	s_orb.var_b7eee573 show();
	var_97bc4cb3 = struct::get(s_orb.target);
	s_orb.var_b7eee573 moveto(var_97bc4cb3.origin, 0.5);
	s_orb.var_b7eee573 waittill(#"movedone");
	s_orb.var_b7eee573 playsound(#"hash_748c338212771d3");
	function_314447b(0);
	level thread function_914f17b9();
	var_97bc4cb3 = struct::get(var_97bc4cb3.target);
	var_64c09f7f = var_97bc4cb3 zm_unitrigger::function_fac87205("", 64);
	if(isplayer(var_64c09f7f) && isalive(var_64c09f7f))
	{
		var_64c09f7f playsound(#"hash_6aa220e65103f345");
	}
}

/*
	Name: function_b2c57ad7
	Namespace: namespace_69ddf44f
	Checksum: 0x3EB85C53
	Offset: 0xFFA8
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_b2c57ad7(a_ents)
{
	e_brutus = a_ents[#"brutus"];
	e_brutus thread zombie_utility::delayed_zombie_eye_glow();
	e_brutus clientfield::set("" + #"hash_df589cc30f4c7dd", 1);
	var_75b1acf = a_ents[#"ghost_1"];
	var_352a766d = a_ents[#"ghost_2"];
	var_237bd310 = a_ents[#"ghost_3"];
}

/*
	Name: function_a98a79b
	Namespace: namespace_69ddf44f
	Checksum: 0x29827B4B
	Offset: 0x10090
	Size: 0x2F4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a98a79b(var_64c09f7f)
{
	level endon(#"end_game", #"hash_2f347ddff9fdaeb9");
	zm_vo::function_3c173d37(var_64c09f7f.origin, 512);
	b_say = var_64c09f7f zm_vo::function_a2bd5a0c(#"hash_2efc94b2753043b4", 0, 1, 9999);
	if(b_say)
	{
		if(var_64c09f7f zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
		{
			e_richtofen = var_64c09f7f;
		}
		if(util::get_players().size > 1 && !var_64c09f7f zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
		{
			e_richtofen = function_b1203924();
			if(isalive(e_richtofen))
			{
				b_say = e_richtofen zm_vo::function_a2bd5a0c(#"hash_2efc94b2753043b4", 0, 1, 9999);
			}
		}
		if(b_say && isdefined(e_richtofen) && isalive(e_richtofen) && (isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6))
		{
			e_richtofen zm_vo::vo_stop();
			b_say = e_richtofen zm_vo::vo_say(#"hash_157c5eae4ea7f8a5", 0, 1, 9999, 1, 1, 1);
			if(b_say && isalive(e_richtofen))
			{
				zm_vo::function_3c173d37(e_richtofen.origin, 512);
				e_richtofen zm_vo::function_a2bd5a0c(#"hash_2efc96b27530471a", 0, 1, 9999);
			}
		}
	}
	level flag::set(#"hash_73b06a8a2c0b0e8d");
}

/*
	Name: function_bdaf22e8
	Namespace: namespace_69ddf44f
	Checksum: 0x3E3ADD80
	Offset: 0x10390
	Size: 0x43C
	Parameters: 1
	Flags: Linked
*/
function function_bdaf22e8(a_ents)
{
	level endon(#"hash_4ff99434ccb06268");
	if(isdefined(level.var_3e89bfdf) && level.var_3e89bfdf)
	{
		return;
	}
	level thread scene::play(#"p8_fxanim_zm_esc_lighthouse_explosion_bundle", "Main & Idle Loop Out");
	zm_vo::function_3c173d37(a_ents[#"brutus"].origin, 1024);
	foreach(e_player in util::get_players())
	{
		e_player zm_vo::function_3c173d37(e_player.origin, 512);
	}
	a_ents[#"brutus"] waittill(#"b_at_l");
	wait(soundgetplaybacktime(#"hash_243ad34fa49f53fd") * 0.001);
	e_player = array::random(util::get_players());
	if(e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")) && (isdefined(e_player.var_59dde2f6) && e_player.var_59dde2f6))
	{
		var_b710dc9e = randomint(2);
		if(var_b710dc9e == 0)
		{
			e_player zm_vo::vo_say(#"hash_b95a5dba1c61ea3", 0, 1, 9999, 1, 1, 1);
		}
		else
		{
			e_player zm_vo::function_3c173d37(e_player.origin, 512);
			e_player zm_vo::function_a2bd5a0c(#"hash_7dbb3706a13991c");
		}
	}
	else
	{
		e_player zm_vo::function_3c173d37(e_player.origin, 512);
		e_player zm_vo::function_a2bd5a0c(#"hash_7dbb3706a13991c");
	}
	if(isdefined(a_ents[#"brutus"]))
	{
		a_ents[#"brutus"] waittill(#"b_fade", #"death");
	}
	foreach(e_player in util::get_players())
	{
		e_player playrumbleonentity("damage_heavy");
		e_player clientfield::set_to_player("" + #"hash_1ee540924e569350", 1);
	}
	level lui::screen_fade_out(0);
}

/*
	Name: function_ac2fa9a4
	Namespace: namespace_69ddf44f
	Checksum: 0x1CC66E58
	Offset: 0x107D8
	Size: 0x32C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ac2fa9a4()
{
	level endon(#"hash_4ff99434ccb06268");
	if(isdefined(level.var_3e89bfdf) && level.var_3e89bfdf)
	{
		return;
	}
	var_d3456dff = 0;
	e_richtofen = function_b1203924(1);
	if(isalive(e_richtofen) && (isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6))
	{
		var_d3456dff = 1;
	}
	if(var_d3456dff)
	{
		if(util::get_players().size > 1)
		{
			var_ee033f8 = array::random(util::get_players());
			while(var_ee033f8 == e_richtofen)
			{
				var_ee033f8 = array::random(util::get_players());
			}
			var_ee033f8 thread zm_vo::function_a2bd5a0c(#"hash_26999951d3a44c87", 0, 1, 9999);
		}
		e_richtofen zm_vo::vo_stop();
		b_say = e_richtofen zm_vo::vo_say(#"hash_7a09fcd3369d5af", 0, 1, 9999, 1, 1, 1);
		if(isalive(e_richtofen))
		{
			b_say = e_richtofen zm_vo::function_a2bd5a0c(#"hash_1544b0fcee3d5f56", 0, 1, 9999);
			if(b_say && isalive(e_richtofen))
			{
				e_richtofen zm_vo::vo_stop();
				b_say = e_richtofen zm_vo::vo_say(#"hash_560988b67c3da339", 0, 1, 9999, 1, 1, 1);
				if(isalive(e_richtofen))
				{
					b_say = e_richtofen zm_vo::function_a2bd5a0c(#"hash_1544aefcee3d5bf0", 0, 1, 9999);
				}
			}
		}
	}
	else
	{
		var_ee033f8 = array::random(util::get_active_players());
		var_ee033f8 zm_vo::function_a2bd5a0c(#"hash_26999951d3a44c87", 0, 1, 9999);
		zm_vo::function_7922807c(5);
	}
}

/*
	Name: registers_helm_of_the_king_support
	Namespace: namespace_69ddf44f
	Checksum: 0x85E70C5D
	Offset: 0x10B10
	Size: 0xDC
	Parameters: 1
	Flags: Linked, Private
*/
function private registers_helm_of_the_king_support(a_ents)
{
	e_brutus = a_ents[#"brutus"];
	e_brutus.var_e8920729 = 1;
	e_brutus waittill(#"hash_369ca9a71e9123ab");
	wait(soundgetplaybacktime(#"hash_2e270a777e3c775") * 0.001);
	var_ee033f8 = array::random(util::get_active_players());
	var_ee033f8 zm_vo::function_a2bd5a0c(#"hash_46c5bad902f6e46a", 0, 1, 9999);
}

/*
	Name: function_27097e44
	Namespace: namespace_69ddf44f
	Checksum: 0x78EEA3D7
	Offset: 0x10BF8
	Size: 0x20C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_27097e44()
{
	if(util::get_active_players().size == 1)
	{
		if(util::get_active_players()[0] zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
		{
			wait(5);
		}
		else
		{
			zm_vo::function_3c173d37(util::get_active_players()[0].origin, 512);
			util::get_active_players()[0] zm_vo::function_a2bd5a0c(#"hash_46c5b5d902f6dbeb", 3, 1, 9999);
		}
	}
	else
	{
		var_ee033f8 = array::random(util::get_active_players());
		while(var_ee033f8 zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
		{
			var_ee033f8 = array::random(util::get_active_players());
		}
		zm_vo::function_3c173d37(var_ee033f8.origin, 512);
		var_ee033f8 zm_vo::function_a2bd5a0c(#"hash_46c5b5d902f6dbeb", 3, 1, 9999);
	}
}

/*
	Name: function_ff0c4916
	Namespace: namespace_69ddf44f
	Checksum: 0x4D99AFE2
	Offset: 0x10E10
	Size: 0xAE
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ff0c4916()
{
	e_richtofen = function_b1203924();
	if(isalive(e_richtofen) && (isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6))
	{
		e_richtofen zm_vo::vo_stop();
		b_say = e_richtofen zm_vo::vo_say(#"hash_1e34b3a0b6f70e26", 0, 1, 9999, 1, 1, 1);
	}
}

/*
	Name: function_1c978623
	Namespace: namespace_69ddf44f
	Checksum: 0x2189147E
	Offset: 0x10EC8
	Size: 0x284
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1c978623()
{
	level endon(#"hash_6048c3f423fd987");
	e_richtofen = function_b1203924();
	if(isalive(e_richtofen))
	{
		if(util::get_players().size > 1)
		{
			var_ee033f8 = array::random(util::get_players());
			while(var_ee033f8 == e_richtofen)
			{
				var_ee033f8 = array::random(util::get_players());
			}
			zm_vo::function_3c173d37(var_ee033f8.origin, 512);
			var_ee033f8 zm_vo::function_a2bd5a0c(#"hash_46c5b7d902f6df51", 0, 1, 999);
		}
		if(isalive(e_richtofen))
		{
			zm_vo::function_3c173d37(e_richtofen.origin, 512);
			e_richtofen zm_vo::function_a2bd5a0c(#"hash_46c5b0d902f6d36c", 0, 1, 999);
			if(isalive(e_richtofen) && (isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6))
			{
				e_richtofen zm_vo::vo_stop();
				b_say = e_richtofen zm_vo::vo_say(#"hash_4f8bc80733e3575d", 0, 1, 9999, 1, 1, 1);
			}
		}
	}
	else
	{
		var_ee033f8 = array::random(util::get_active_players());
		zm_vo::function_3c173d37(var_ee033f8.origin, 512);
		var_ee033f8 zm_vo::function_a2bd5a0c(#"hash_46c5b7d902f6df51", 0, 1, 999);
	}
}

/*
	Name: function_ddf8f11
	Namespace: namespace_69ddf44f
	Checksum: 0x3BA8A38F
	Offset: 0x11158
	Size: 0x8C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ddf8f11()
{
	level endon(#"hash_6048c3f423fd987");
	var_ee033f8 = array::random(util::get_active_players());
	zm_vo::function_3c173d37(var_ee033f8.origin, 512);
	var_ee033f8 zm_vo::function_a2bd5a0c(#"hash_5931ce3f54ff9613", 0, 1, 999);
}

/*
	Name: function_914f17b9
	Namespace: namespace_69ddf44f
	Checksum: 0xE5FA0CDF
	Offset: 0x111F0
	Size: 0xC4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_914f17b9()
{
	e_richtofen = function_b1203924();
	if(isalive(e_richtofen))
	{
		e_richtofen zm_vo::function_a2bd5a0c(#"hash_2853b0b1b9bd2301", 0, 1, 9999);
	}
	else
	{
		e_player = array::random(util::get_active_players());
		e_player zm_vo::function_a2bd5a0c(#"hash_2853b0b1b9bd2301", 0, 1, 9999);
	}
}

/*
	Name: function_e15cfd01
	Namespace: namespace_69ddf44f
	Checksum: 0x20A56B24
	Offset: 0x112C0
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_e15cfd01()
{
	/#
		if(!getdvarint(#"zm_debug_ee", 0))
		{
			return;
		}
		zm_devgui::add_custom_devgui_callback(&function_1b504133);
		adddebugcommand("");
	#/
}

/*
	Name: function_1b504133
	Namespace: namespace_69ddf44f
	Checksum: 0x831ABADB
	Offset: 0x11338
	Size: 0x5A
	Parameters: 1
	Flags: None
*/
function function_1b504133(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_7d175a3cfdd62ec1":
			{
				level notify(#"hash_4ff99434ccb06268");
				level.var_3e89bfdf = 1;
				break;
			}
		}
	#/
}

/*
	Name: step_5
	Namespace: namespace_69ddf44f
	Checksum: 0x90D6031B
	Offset: 0x113A0
	Size: 0x3D4
	Parameters: 1
	Flags: Linked
*/
function step_5(var_a276c861)
{
	zm_vo::function_2fd1af0(6);
	level zm_ui_inventory::function_7df6bb60(#"hash_7629706a5a9c7bf7", 5);
	mdl_door = getent("jar_1", "targetname");
	if(!var_a276c861)
	{
		s_interact = spawnstruct();
		s_interact.origin = mdl_door gettagorigin("tag_socket_b");
		mdl_door.s_interact = s_interact;
		e_who = s_interact zm_unitrigger::function_fac87205(undefined, 39);
		function_314447b(1);
	}
	level thread function_e998f810("tag_socket_b");
	exploder::exploder("lgtexp_richtofenspod_on");
	level scene::function_27f5972e(#"hash_70ea46435e8fd4ed");
	wait(1.6);
	scene::add_scene_func(#"hash_70ea46435e8fd4ed", &function_8ffd93bf);
	level thread scene::play(#"hash_70ea46435e8fd4ed");
	s_map = struct::get(#"hash_137eedd5080e585d");
	s_map scene::play("Shot 2");
	mdl_door scene::play(#"p8_fxanim_zm_esc_lab_door_map_bundle", mdl_door);
	if(!var_a276c861)
	{
		level thread function_4ff97a71(e_who);
	}
	var_6fb54924 = getent("jar_2", "targetname");
	var_82a6de88 = getent("jar_2_fxanim", "targetname");
	var_82a6de88 thread scene::play(#"p8_fxanim_zm_esc_door_lab_double_bundle", "OPENED", var_82a6de88);
	wait(1.6);
	var_6fb54924 delete();
	if(!var_a276c861)
	{
		function_314447b(0);
		level flag::set(#"activate_west_side_exterior_stairs");
		function_f1659bd5(util::get_active_players().size);
		level.var_d9b730f3 = 1;
		mdl_door = getent("c29_door", "targetname");
		playsoundatposition("zmb_c29_door_open", mdl_door.origin);
		mdl_door movez(96, 1.6);
	}
}

/*
	Name: function_8ffd93bf
	Namespace: namespace_69ddf44f
	Checksum: 0x53F4FDB5
	Offset: 0x11780
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_8ffd93bf(a_ents)
{
	level.var_7e34e7db = a_ents[#"cryo_pod"];
}

/*
	Name: function_512a6b36
	Namespace: namespace_69ddf44f
	Checksum: 0xFBBDAFBF
	Offset: 0x117B8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_512a6b36(a_ents)
{
	mdl_door = getent("jar_1", "targetname");
	a_ents[#"prop 1"] linkto(mdl_door, "tag_door_anim", (0, 0, 0));
}

/*
	Name: function_f1659bd5
	Namespace: namespace_69ddf44f
	Checksum: 0xBC82E6AC
	Offset: 0x11830
	Size: 0x164
	Parameters: 2
	Flags: Linked
*/
function function_f1659bd5(var_141689f1, var_a9d2fdec)
{
	level flag::clear(#"hash_4fac802bd5dcebf4");
	level.var_b519da5d = [];
	level.var_be5976c4 = 0;
	for(i = 1; i <= 4; i++)
	{
		var_c9b94f85 = getent("c29_plate_" + i, "targetname");
		var_c9b94f85 setmodel(#"p7_light_round_spot_flat_off");
		if(i > var_141689f1)
		{
			var_c9b94f85 setmodel(#"p7_light_round_spot_flat_on_warm");
			exploder::exploder("lgt_exp_boss_rollup_" + i);
			continue;
		}
		level thread function_5efab4f9(i, var_a9d2fdec);
		level.var_be5976c4++;
	}
	level flag::wait_till(#"hash_4fac802bd5dcebf4");
}

/*
	Name: function_37838b09
	Namespace: namespace_69ddf44f
	Checksum: 0x2C2BF9C3
	Offset: 0x119A0
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_37838b09()
{
	for(i = 1; i <= 4; i++)
	{
		var_c9b94f85 = getent("c29_plate_" + i, "targetname");
		if(isdefined(var_c9b94f85.var_89bffd7b))
		{
			var_c9b94f85.var_89bffd7b delete();
		}
		exploder::stop_exploder("lgt_exp_boss_rollup_" + i);
	}
	foreach(player in util::get_active_players())
	{
		if(isdefined(player.m_pap_force_stream))
		{
			player.m_pap_force_stream delete();
		}
	}
}

/*
	Name: function_5efab4f9
	Namespace: namespace_69ddf44f
	Checksum: 0xBF18D5CA
	Offset: 0x11AF0
	Size: 0x588
	Parameters: 2
	Flags: Linked
*/
function function_5efab4f9(var_27d47c17, var_a9d2fdec = 0)
{
	level endon(#"hash_4fac802bd5dcebf4");
	var_c9b94f85 = getent("c29_plate_" + var_27d47c17, "targetname");
	var_c9b94f85.var_89bffd7b = spawn("trigger_box", var_c9b94f85.origin, 0, 16, 16, 64);
	var_c9b94f85.var_89bffd7b.b_locked = 0;
	var_c9b94f85.var_27d47c17 = var_27d47c17;
	if(var_a9d2fdec)
	{
		var_c9b94f85.var_89bffd7b waittill(#"trigger");
		level flag::set(#"hash_4fac802bd5dcebf4");
	}
	else
	{
		while(true)
		{
			s_info = undefined;
			s_info = var_c9b94f85.var_89bffd7b waittill(#"trigger");
			if(!array::contains(level.var_b519da5d, s_info.activator) || level.var_be5976c4 > util::get_active_players().size && !var_c9b94f85.var_89bffd7b.b_locked)
			{
				var_c9b94f85.var_89bffd7b.b_locked = 1;
				var_c9b94f85 setmodel(#"p7_light_round_spot_flat_on_warm");
				exploder::exploder("lgt_exp_boss_rollup_" + var_27d47c17);
				s_info.activator.var_5dfdbf1 = var_27d47c17;
				if(!isdefined(level.var_b519da5d))
				{
					level.var_b519da5d = [];
				}
				else if(!isarray(level.var_b519da5d))
				{
					level.var_b519da5d = array(level.var_b519da5d);
				}
				level.var_b519da5d[level.var_b519da5d.size] = s_info.activator;
				s_info.activator.var_c9b94f85 = var_c9b94f85;
				s_info.activator thread function_5524bec2(var_c9b94f85);
				if(level.var_b519da5d.size == level.var_be5976c4)
				{
					level.var_845ca238 = [];
					foreach(player in util::get_active_players())
					{
						if(isdefined(player.var_c9b94f85))
						{
							player thread function_256e70d7(player.var_c9b94f85.origin);
						}
					}
					a_str_flags = array(#"hash_12a631be319641a1", #"hash_7680c620ba7315e5");
					var_a4937b41 = level flag::wait_till_any(a_str_flags);
					foreach(player in util::get_active_players())
					{
						if(isdefined(player.m_pap_force_stream))
						{
							player.m_pap_force_stream delete();
						}
					}
					if(var_a4937b41._notify == #"hash_12a631be319641a1")
					{
						level flag::set(#"hash_4fac802bd5dcebf4");
					}
				}
				else
				{
					a_str_flags = array(#"hash_12a631be319641a1", #"hash_7680c620ba7315e5");
					level flag::wait_till_any(a_str_flags);
				}
				level flag::clear(#"hash_12a631be319641a1");
				level flag::clear(#"hash_7680c620ba7315e5");
			}
			wait(0.15);
		}
	}
}

/*
	Name: function_5524bec2
	Namespace: namespace_69ddf44f
	Checksum: 0xBD5D5C29
	Offset: 0x12080
	Size: 0x1A6
	Parameters: 1
	Flags: Linked
*/
function function_5524bec2(var_c9b94f85)
{
	self endon(#"death", #"hash_7680c620ba7315e5");
	var_c9b94f85.var_89bffd7b endon(#"death");
	if(!self flag::exists(#"hash_7680c620ba7315e5"))
	{
		self flag::init(#"hash_7680c620ba7315e5");
	}
	while(true)
	{
		if(!self istouching(var_c9b94f85.var_89bffd7b))
		{
			arrayremovevalue(level.var_b519da5d, self);
			var_c9b94f85.var_89bffd7b.b_locked = 0;
			var_c9b94f85 setmodel(#"p7_light_round_spot_flat_off");
			exploder::stop_exploder("lgt_exp_boss_rollup_" + var_c9b94f85.var_27d47c17);
			level flag::set(#"hash_7680c620ba7315e5");
			self flag::set(#"hash_7680c620ba7315e5");
			self.var_c9b94f85 = undefined;
		}
		else
		{
			self playrumbleonentity("damage_light");
		}
		waitframe(1);
	}
}

/*
	Name: function_256e70d7
	Namespace: namespace_69ddf44f
	Checksum: 0x825537D6
	Offset: 0x12230
	Size: 0x224
	Parameters: 1
	Flags: Linked
*/
function function_256e70d7(var_3104b082)
{
	self endon(#"death");
	level endon(#"hash_12a631be319641a1", #"hash_7680c620ba7315e5");
	self.m_pap_force_stream = spawn("trigger_box_use", var_3104b082 + (0, 12, 61), 0, 16, 16, 61);
	self.m_pap_force_stream sethintstring(#"hash_6d663dca450595ef");
	self.m_pap_force_stream setcursorhint("HINT_NOICON");
	self.m_pap_force_stream triggerignoreteam();
	self.m_pap_force_stream setvisibletoplayer(self);
	while(true)
	{
		s_info = undefined;
		s_info = self.m_pap_force_stream waittill(#"trigger");
		if(!array::contains(level.var_845ca238, s_info.activator))
		{
			if(!isdefined(level.var_845ca238))
			{
				level.var_845ca238 = [];
			}
			else if(!isarray(level.var_845ca238))
			{
				level.var_845ca238 = array(level.var_845ca238);
			}
			level.var_845ca238[level.var_845ca238.size] = s_info.activator;
			if(level.var_845ca238.size == util::get_active_players().size)
			{
				level notify(#"hash_12a631be319641a1");
			}
		}
		wait(0.15);
	}
}

/*
	Name: function_4ff97a71
	Namespace: namespace_69ddf44f
	Checksum: 0x165E37F
	Offset: 0x12460
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function function_4ff97a71(var_386f3ef3)
{
	level notify(#"hash_12e07fb1fcd93e06");
	if(!isdefined(var_386f3ef3))
	{
		var_386f3ef3 = util::get_players()[0];
	}
	zm_vo::function_3c173d37(var_386f3ef3.origin, 512);
	var_386f3ef3 zm_vo::function_a2bd5a0c(#"hash_49dd995af5e92761", 0, 1, 9999);
	e_richtofen = function_b1203924();
	if(isdefined(e_richtofen))
	{
		zm_vo::function_3c173d37(e_richtofen.origin, 512);
		e_richtofen zm_vo::function_a2bd5a0c(#"hash_49dd985af5e925ae", 0, 1, 9999);
	}
	if(isdefined(e_richtofen) && (isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6))
	{
		e_richtofen zm_vo::vo_stop();
		b_say = e_richtofen zm_vo::vo_say(#"hash_996507b15245f1", 0, 1, 9999, 1, 1, 1);
		if(b_say && isalive(e_richtofen))
		{
			e_richtofen zm_vo::function_a2bd5a0c(#"hash_49dd965af5e92248", 0, 1, 9999);
		}
	}
}

/*
	Name: step_5_cleanup
	Namespace: namespace_69ddf44f
	Checksum: 0x25C288C7
	Offset: 0x12630
	Size: 0x1CC
	Parameters: 2
	Flags: Linked
*/
function step_5_cleanup(var_a276c861, var_19e802fa)
{
	level flag::set(#"activate_west_side_exterior_stairs");
	level flag::set(#"hash_4fac802bd5dcebf4");
	level flag::clear("zombie_drop_powerups");
	zm_zonemgr::enable_zone("zone_west_side_exterior_upper_03");
	level thread function_314447b(1);
	mdl_door = getent("jar_1", "targetname");
	if(isdefined(mdl_door.s_interact))
	{
		zm_unitrigger::unregister_unitrigger(mdl_door.s_interact.s_unitrigger);
	}
	function_37838b09();
	exploder::stop_exploder("lgtexp_richtofenspod_on");
	level scene::stop(#"hash_70ea46435e8fd4ed");
	level scene::function_f81475ae(#"hash_70ea46435e8fd4ed");
	function_f2f59362();
	arrayremoveindex(level.sndplayervox, "elixir", 1);
	arrayremoveindex(level.sndplayervox, "powerup", 1);
}

/*
	Name: function_f2f59362
	Namespace: namespace_69ddf44f
	Checksum: 0xB750780F
	Offset: 0x12808
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_f2f59362()
{
	s_wall = struct::get(#"hash_56b9f12181d4b3d0");
	mdl_clip = util::spawn_model("collision_player_wall_128x128x10", s_wall.origin, s_wall.angles);
	mdl_clip ghost();
	exploder::exploder("fxexp_flame_wall_door_glow_lab");
}

/*
	Name: step_6
	Namespace: namespace_69ddf44f
	Checksum: 0x9FCEBB91
	Offset: 0x128A8
	Size: 0x2D0
	Parameters: 1
	Flags: Linked
*/
function step_6(var_a276c861)
{
	showmiscmodels("mechanical_chair");
	var_b05e79d7 = getent("mechanical_chair", "targetname");
	var_b05e79d7 show();
	level thread scene::play(#"p8_zm_esc_dark_machine_bundle", "IDLE");
	exploder::kill_exploder("fxexp_poison_ambient");
	exploder::exploder("lgtexp_bossArena_on");
	zm_bgb_anywhere_but_here::function_886fce8f(0);
	function_6b40f92e();
	level zm_ui_inventory::function_7df6bb60(#"hash_7629706a5a9c7bf7", 6);
	level thread function_fd915ab5();
	level.var_8b4ac110 = 256;
	if(!var_a276c861)
	{
		var_3ded86ce = function_708bfb60();
		scene::add_scene_func(#"hash_6c8ed7f336f9ee3c", &boss_intro, "play");
		scene::add_scene_func(#"hash_6c8ed7f336f9ee3c", &_cover_challenge_reward_timeout, "done");
		level scene::play(#"hash_6c8ed7f336f9ee3c", var_3ded86ce);
	}
	level.musicsystemoverride = 1;
	music::setmusicstate("boss");
	level.check_valid_spawn_override = &function_ea25ff10;
	changeadvertisedstatus(0);
	function_5022ff9d();
	if(!var_a276c861)
	{
		function_37d4f9(2, 4);
		while(!isdefined(level.var_b1312d49))
		{
			wait(1.6);
			function_30febada();
			if(!isdefined(level.var_b1312d49))
			{
				wait(6.1);
				function_37d4f9(2, 8, 3);
			}
		}
	}
}

/*
	Name: function_ea25ff10
	Namespace: namespace_69ddf44f
	Checksum: 0xF00369CC
	Offset: 0x12B80
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function function_ea25ff10(player)
{
	var_19c35ca = struct::get_array(#"hash_26ba975865fbda23");
	var_61c941e8 = array::random(var_19c35ca);
	return var_61c941e8;
}

/*
	Name: boss_intro
	Namespace: namespace_69ddf44f
	Checksum: 0x35C44381
	Offset: 0x12BE8
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function boss_intro(a_ents)
{
	wait(2.1);
	a_ents[#"hash_5e9ded7036d6311f"] hide();
	wait(4.95);
	a_ents[#"hash_5e9dec7036d62f6c"] hide();
	wait(1.6);
	a_ents[#"hash_5e9dee7036d632d2"] hide();
	wait(1.6);
	a_ents[#"boss"] clientfield::increment("" + #"hash_29d283d7f747d358");
	wait(0.3);
	a_ents[#"boss"] hide();
	a_ents[#"prop 1"] hide();
}

/*
	Name: _cover_challenge_reward_timeout
	Namespace: namespace_69ddf44f
	Checksum: 0xA25E4736
	Offset: 0x12D30
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function _cover_challenge_reward_timeout(a_ents)
{
	playsoundatposition(#"hash_8a68e0d5ec39687", (9860, 10237, 617));
	wait(soundgetplaybacktime(#"hash_8a68e0d5ec39687") * 0.001);
	e_player = array::random(util::get_active_players());
	e_player zm_vo::function_a2bd5a0c(#"hash_16dd5249cdc08382", 0, 1, 9999);
}

/*
	Name: function_fd915ab5
	Namespace: namespace_69ddf44f
	Checksum: 0xA7F6BB8F
	Offset: 0x12E00
	Size: 0x27E
	Parameters: 0
	Flags: Linked
*/
function function_fd915ab5()
{
	if(isdefined(level.var_d9b730f3) && level.var_d9b730f3)
	{
		foreach(player in util::get_active_players())
		{
			player thread function_e9910473();
		}
		level waittill(#"hash_3bb155b55ea4338a");
		mdl_door = getent("c29_door", "targetname");
		playsoundatposition("zmb_c29_door_close", mdl_door.origin);
		mdl_door movez(-96, 1.6);
	}
	else
	{
		s_portal = struct::get(#"hash_4f3ae1de39c4b3e3");
		for(i = 1; i <= util::get_active_players().size; i++)
		{
			v_facing = s_portal.origin - (util::get_active_players()[i - 1].origin);
			v_angle = vectortoangles(v_facing);
			s_teleport = struct::get(#"c29_teleport_" + i);
			util::get_active_players()[i - 1] setorigin(s_teleport.origin);
			util::get_active_players()[i - 1] setplayerangles(v_angle);
		}
	}
}

/*
	Name: function_e9910473
	Namespace: namespace_69ddf44f
	Checksum: 0xC0F69581
	Offset: 0x13088
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function function_e9910473()
{
	self endon(#"death");
	s_portal = struct::get(#"hash_4f3ae1de39c4b3e3");
	v_facing = vectornormalize((s_portal.origin[0], s_portal.origin[1], self.origin[2]) - self.origin);
	v_angle = vectortoangles(v_facing);
	mdl_origin = util::spawn_model("tag_origin", self.origin, v_angle);
	self linkto(mdl_origin);
	wait(0.9);
	var_b681bc7d = getstatuseffect(#"hash_19533caf858a9f3b");
	self status_effect::status_effect_apply(var_b681bc7d, undefined, self, 0);
	if(isdefined(self.var_5dfdbf1))
	{
		s_goto = struct::get(#"c29_teleport_" + self.var_5dfdbf1);
		mdl_origin moveto(s_goto.origin, 1.6, 0.2, 0.9);
	}
	wait(1.6);
	level notify(#"hash_3bb155b55ea4338a");
	self unlink();
}

/*
	Name: function_6b40f92e
	Namespace: namespace_69ddf44f
	Checksum: 0x6606190D
	Offset: 0x13298
	Size: 0x2BE
	Parameters: 0
	Flags: Linked
*/
function function_6b40f92e()
{
	level zm_escape_util::function_67710e66(0);
	level.var_b491030 = 0;
	if(level.round_number < 26)
	{
		level.var_69ff31e1 = level.zombie_vars[#"zombie_health_start"];
		for(i = 2; i <= 26; i++)
		{
			if(i >= 10)
			{
				n_old_health = level.var_69ff31e1;
				level.var_69ff31e1 = level.var_69ff31e1 + (int(level.var_69ff31e1 * level.zombie_vars[#"zombie_health_increase_multiplier"]));
				if(level.var_69ff31e1 < n_old_health)
				{
					level.var_69ff31e1 = n_old_health;
					break;
				}
				continue;
			}
			level.var_69ff31e1 = int(level.var_69ff31e1 + level.zombie_vars[#"zombie_health_increase"]);
		}
	}
	else
	{
		level.var_69ff31e1 = level.zombie_health;
	}
	if(level.brutus_round_count < 7)
	{
		level.brutus_round_count = 7;
	}
	zm::register_actor_damage_callback(&function_f90d2c81, 1);
	level.var_a36cbfaf = 0;
	s_portal = struct::get(#"hash_4f3ae1de39c4b3e3");
	mdl_portal = util::spawn_model("tag_origin", s_portal.origin, s_portal.angles);
	mdl_portal.targetname = "c29_energy";
	mdl_portal clientfield::set("" + #"dm_energy", 3);
	mdl_portal.script_noteworthy = "blast_attack_interactables";
	mdl_portal thread function_2f4c3a4e();
	level._powerup_timeout_custom_time = &function_f8173af0;
}

/*
	Name: function_f90d2c81
	Namespace: namespace_69ddf44f
	Checksum: 0xEF63C532
	Offset: 0x13560
	Size: 0x12C
	Parameters: 12
	Flags: Linked
*/
function function_f90d2c81(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	n_damage = -1;
	if(isdefined(attacker) && !isplayer(attacker))
	{
		var_607b7fd9 = getweapon(#"hash_494f5501b3f8e1e9");
		if(isdefined(weapon) && weapon == var_607b7fd9)
		{
			n_damage = 0;
		}
	}
	else if(isdefined(self.var_9fde8624) && self.var_9fde8624 == #"brutus_special" && !level.var_b491030)
	{
		n_damage = 0;
	}
	return n_damage;
}

/*
	Name: function_2f4c3a4e
	Namespace: namespace_69ddf44f
	Checksum: 0x994CE2B9
	Offset: 0x13698
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_2f4c3a4e()
{
	self endon(#"death");
	while(true)
	{
		s_info = undefined;
		s_info = self waittill(#"blast_attack");
		if(isdefined(level.var_7fe331bf) && level.var_7fe331bf)
		{
			if(isdefined(s_info.e_player))
			{
				level.var_4f538b17 = s_info.e_player;
			}
			level.var_e22ef7ff = 1;
			level notify(#"hash_6721db7073dcfe48");
		}
	}
}

/*
	Name: function_f8173af0
	Namespace: namespace_69ddf44f
	Checksum: 0xE46789B6
	Offset: 0x13758
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function function_f8173af0(var_7d81025)
{
	return 29;
}

/*
	Name: function_37d4f9
	Namespace: namespace_69ddf44f
	Checksum: 0x60BC537E
	Offset: 0x13778
	Size: 0x6E6
	Parameters: 5
	Flags: Linked
*/
function function_37d4f9(var_f6d24584, n_brutus = 0, var_b8fc6ea2 = 0, var_49770f00 = 0, n_zombies_max)
{
	switch(util::get_active_players().size)
	{
		case 1:
		{
			var_abab4bf6 = 36;
			break;
		}
		case 2:
		{
			var_abab4bf6 = 37;
			break;
		}
		case 3:
		{
			var_abab4bf6 = 38;
			break;
		}
		default:
		{
			var_abab4bf6 = 39;
			break;
		}
	}
	level.var_dcff743c = 1;
	level.n_brutus_spawned = 0;
	if(var_b8fc6ea2 > 0)
	{
		level thread function_65cd27ea(var_b8fc6ea2);
	}
	if(var_49770f00)
	{
		level thread function_f1eda79e();
	}
	if(n_brutus != 0)
	{
		level thread function_a4e995fb(n_brutus, var_49770f00);
	}
	var_45e9dd93 = function_9a1e357b(var_f6d24584);
	var_96c30422 = 0;
	var_3ba04663 = 0;
	var_ea4b199f = struct::get_array(#"hash_12b8ce4101a20d47");
	var_ea4b199f = array::randomize(var_ea4b199f);
	if(isdefined(n_zombies_max))
	{
		for(i = 0; i < var_ea4b199f.size; i++)
		{
			if(var_ea4b199f[i].script_noteworthy == "riser_location")
			{
				var_ea4b199f[i] = undefined;
			}
		}
		var_ea4b199f = array::remove_undefined(var_ea4b199f);
		wait(1.6);
	}
	while(level.var_dcff743c)
	{
		var_d8036031 = getaiteamarray(level.zombie_team).size;
		if(util::get_active_players().size == 1 && level flag::get(#"richtofen_sacrifice") && !level flag::get(#"hash_68a1656980e771da"))
		{
			if(var_d8036031 >= 23)
			{
				wait(var_45e9dd93);
				continue;
			}
		}
		if(isdefined(n_zombies_max) && var_d8036031 >= n_zombies_max)
		{
			wait(var_45e9dd93);
			continue;
		}
		if(var_3ba04663 == var_ea4b199f.size)
		{
			var_3ba04663 = 0;
			var_ea4b199f = array::randomize(var_ea4b199f);
		}
		s_spawn_loc = var_ea4b199f[var_3ba04663];
		if(isdefined(s_spawn_loc) && isdefined(s_spawn_loc.script_noteworthy))
		{
			if(s_spawn_loc.script_noteworthy == "riser_location")
			{
				ai_zombie = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined, s_spawn_loc);
				ai_zombie thread function_8d744628();
			}
			else if(s_spawn_loc.script_noteworthy == "dog_location" && !isdefined(level.var_e3522ee))
			{
				ai_zombie = zombie_utility::spawn_zombie(level.dog_spawners[0]);
				ai_zombie thread function_23bd9529(s_spawn_loc);
			}
		}
		if(isdefined(ai_zombie))
		{
			var_96c30422++;
		}
		var_3ba04663++;
		if(n_brutus == 0)
		{
			if(var_96c30422 > var_abab4bf6)
			{
				level.var_dcff743c = 0;
			}
		}
		wait(var_45e9dd93);
	}
	if(!isdefined(n_zombies_max))
	{
		var_d8036031 = getaiteamarray(level.zombie_team).size;
		while(var_d8036031 > 0)
		{
			wait(1.6);
			var_d8036031 = getaiteamarray(level.zombie_team).size;
		}
		var_f12715f5 = struct::get_array(#"hash_3ea8e97c5c09e1a5", "variantname");
		s_location = array::random(var_f12715f5);
		level.var_ebd424be = s_location.script_int;
		if(!var_49770f00)
		{
			if(function_efbccd91())
			{
				var_7d81025 = zm_powerups::specific_powerup_drop("carpenter", s_location.origin + vectorscale((1, 0, 0), 31));
			}
			else
			{
				var_e9e88745 = util::spawn_model(#"hash_5892f7f4c9a9720e", s_location.origin + (31, 0, 61));
				var_e9e88745 notsolid();
				t_shield = spawn("trigger_radius_new", s_location.origin + (31, 0, 61), 0, 16);
				t_shield thread give_player_shield(var_e9e88745);
			}
			var_7d81025 = zm_powerups::specific_powerup_drop("full_ammo", s_location.origin + (vectorscale((-1, 0, 0), 31)));
		}
	}
}

/*
	Name: function_efbccd91
	Namespace: namespace_69ddf44f
	Checksum: 0x1B403934
	Offset: 0x13E68
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_efbccd91()
{
	var_c22bb85c = 0;
	foreach(player in util::get_active_players())
	{
		if(player hasweapon(getweapon(#"zhield_spectral_dw")) || player hasweapon(getweapon(#"zhield_spectral_dw_upgraded")))
		{
			var_c22bb85c = 1;
			break;
		}
	}
	return var_c22bb85c;
}

/*
	Name: give_player_shield
	Namespace: namespace_69ddf44f
	Checksum: 0xAABDF27B
	Offset: 0x13F70
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function give_player_shield(var_e9e88745)
{
	s_info = undefined;
	s_info = self waittill(#"trigger");
	s_info.activator giveweapon(getweapon(#"zhield_spectral_dw"));
	var_e9e88745 delete();
	self delete();
}

/*
	Name: function_108ff870
	Namespace: namespace_69ddf44f
	Checksum: 0xDC2766A1
	Offset: 0x14018
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_108ff870()
{
	level.var_e3522ee = 1;
	level flag::wait_till_timeout(29, #"hash_3d16465b22e70170");
	level.var_e3522ee = undefined;
}

/*
	Name: function_8d744628
	Namespace: namespace_69ddf44f
	Checksum: 0xEF784B0C
	Offset: 0x14068
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_8d744628()
{
	self endon(#"death");
	waitframe(1);
	self thread zm_escape_util::function_24d3ec02();
	self.maxhealth = int(level.var_69ff31e1);
	self.health = self.maxhealth;
	n_roll = randomint(10);
	if(n_roll <= 6)
	{
		self zombie_utility::set_zombie_run_cycle("sprint");
	}
	else
	{
		self zombie_utility::set_zombie_run_cycle("run");
	}
}

/*
	Name: function_23bd9529
	Namespace: namespace_69ddf44f
	Checksum: 0x21074762
	Offset: 0x14148
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_23bd9529(s_spawn_loc)
{
	self endon(#"death");
	waitframe(1);
	self thread zm_escape_util::function_7273c33d(s_spawn_loc);
	self ai::set_behavior_attribute("sprint", 1);
}

/*
	Name: function_a4e995fb
	Namespace: namespace_69ddf44f
	Checksum: 0x24F73599
	Offset: 0x141B0
	Size: 0x1B0
	Parameters: 2
	Flags: Linked
*/
function function_a4e995fb(n_brutus, var_49770f00 = 0)
{
	if(var_49770f00)
	{
		level flag::wait_till_timeout(61, #"hash_68a1656980e771da");
	}
	wait(1.6);
	var_9bc12626 = array("brutus_spawned", "brutus_spawn_failed");
	while(level.var_dcff743c)
	{
		zombie_brutus_util::attempt_brutus_spawn(1, "zone_west_side_exterior_upper_03", 1);
		s_waittill = undefined;
		s_waittill = level waittill(var_9bc12626);
		if(isdefined(s_waittill.ai_brutus))
		{
			level.n_brutus_spawned++;
			s_waittill.ai_brutus.var_ece4a895 = &function_bba62242;
			s_waittill.ai_brutus ai::set_behavior_attribute("can_ground_slam", 1);
			s_waittill.ai_brutus.var_db8b3627 = 1;
			s_waittill.ai_brutus waittilltimeout(12.6, #"death");
			if(n_brutus != -1 && level.n_brutus_spawned >= n_brutus)
			{
				level.var_dcff743c = 0;
			}
		}
		else
		{
			wait(16);
		}
	}
}

/*
	Name: function_5022ff9d
	Namespace: namespace_69ddf44f
	Checksum: 0x87DC22B6
	Offset: 0x14368
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_5022ff9d()
{
	level.var_84e3557e = [];
	structs = struct::get_array("zone_west_side_exterior_upper_03_spawners");
	foreach(struct in structs)
	{
		if(struct.script_noteworthy === "brutus_location")
		{
			array::add(level.var_84e3557e, struct);
		}
	}
}

/*
	Name: function_bba62242
	Namespace: namespace_69ddf44f
	Checksum: 0xC83C9F8A
	Offset: 0x14438
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_bba62242()
{
	/#
		assert(isdefined(level.var_84e3557e));
	#/
	structs = [];
	foreach(struct in level.var_84e3557e)
	{
		if(!util::within_fov(self.origin, self.angles, struct.origin, cos(90)))
		{
			array::add(structs, struct);
		}
	}
	if(structs.size)
	{
		return array::random(structs).origin;
	}
}

/*
	Name: function_65cd27ea
	Namespace: namespace_69ddf44f
	Checksum: 0x41E9875
	Offset: 0x14558
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_65cd27ea(var_b8fc6ea2)
{
	wait(2.6);
	while(level.var_dcff743c)
	{
		var_cc30b3b9 = struct::get_array(#"hash_238da2de7cf910d9", "variantname");
		var_cc30b3b9 = array::randomize(var_cc30b3b9);
		for(i = 0; i < var_b8fc6ea2; i++)
		{
			s_cloud = var_cc30b3b9[i];
			function_645562a2(s_cloud);
			wait(randomfloatrange(1.6, 6.1));
		}
		wait(16);
	}
}

/*
	Name: function_645562a2
	Namespace: namespace_69ddf44f
	Checksum: 0x526DB0CB
	Offset: 0x14648
	Size: 0x180
	Parameters: 1
	Flags: Linked
*/
function function_645562a2(s_cloud)
{
	var_81f76694 = util::spawn_model("tag_origin", s_cloud.origin, s_cloud.angles + vectorscale((1, 0, 0), 270));
	var_81f76694 clientfield::set("" + #"ritual_gobo", 1);
	var_81f76694 thread function_a67f95bd();
	wait(7.6);
	foreach(player in util::get_active_players())
	{
		if(distance2dsquared(var_81f76694.origin, player.origin) < 5041)
		{
			player dodamage(player.health + 16, player.origin);
		}
	}
}

/*
	Name: function_a67f95bd
	Namespace: namespace_69ddf44f
	Checksum: 0xB06392D0
	Offset: 0x147D0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_a67f95bd()
{
	wait(6.1);
	self clientfield::set("" + #"ritual_gobo", 0);
}

/*
	Name: function_708bfb60
	Namespace: namespace_69ddf44f
	Checksum: 0x955D0B85
	Offset: 0x14810
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function function_708bfb60()
{
	var_b932e751 = getent("spawner_zm_brutus_special", "targetname");
	var_3ded86ce = zombie_utility::spawn_zombie(var_b932e751);
	var_3ded86ce clientfield::set("brutus_spawn_clientfield", 1);
	var_3ded86ce disableaimassist();
	var_3ded86ce clientfield::set("" + #"hash_df589cc30f4c7dd", 1);
	return var_3ded86ce;
}

/*
	Name: function_f1eda79e
	Namespace: namespace_69ddf44f
	Checksum: 0xC915D83D
	Offset: 0x148D8
	Size: 0x3B4
	Parameters: 0
	Flags: Linked
*/
function function_f1eda79e()
{
	if(util::get_active_players().size == 1 && util::get_active_players()[0] zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
	{
		level flag::wait_till(#"hash_3d16465b22e70170");
		wait(2.3);
	}
	else
	{
		level flag::wait_till_timeout(16, #"richtofen_sacrifice");
	}
	var_b932e751 = getent("spawner_zm_brutus_special", "targetname");
	var_3ded86ce = zombie_utility::spawn_zombie(var_b932e751);
	while(!isdefined(var_3ded86ce))
	{
		var_3ded86ce = zombie_utility::spawn_zombie(var_b932e751);
		waitframe(1);
	}
	var_3ded86ce.health = int(ceil(2961 / (4 - (util::get_active_players().size - 1))));
	var_3ded86ce.b_ignore_cleanup = 1;
	var_3ded86ce thread zombie_brutus_util::brutus_spawn(undefined, undefined, undefined, undefined, "zone_west_side_exterior_upper_03");
	var_3ded86ce.var_ece4a895 = &function_bba62242;
	var_3ded86ce ai::set_behavior_attribute("can_ground_slam", 1);
	var_3ded86ce.var_db8b3627 = 1;
	var_3ded86ce.script_noteworthy = "spawner_zm_brutus_special_ai";
	var_3ded86ce clientfield::set("" + #"hash_df589cc30f4c7dd", 1);
	var_3ded86ce val::set(#"boss_special", "takedamage", 0);
	level notify(#"hash_7fbbfdf42f9d741");
	var_3ded86ce thread function_81771803();
	level waittill(#"raise_fire");
	var_3ded86ce clientfield::set("" + #"hash_df589cc30f4c7dd", 0);
	var_3ded86ce ai::stun(2.9);
	level.var_b491030 = 1;
	var_3ded86ce val::reset(#"boss_special", "takedamage");
	var_3ded86ce waittill(#"death");
	level.var_dcff743c = 0;
	level flag::set(#"main_quest_completed");
}

/*
	Name: function_81771803
	Namespace: namespace_69ddf44f
	Checksum: 0xD313A668
	Offset: 0x14C98
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function function_81771803()
{
	self endon(#"death");
	level endon(#"hash_68a1656980e771da");
	while(true)
	{
		wait(16);
		if(!zm_vo::function_45e29f06())
		{
			var_c3ba3c34 = randomint(10);
			self playsoundtoteam(#"hash_3e6efe7a558dc61d" + var_c3ba3c34, util::get_active_players()[0].team);
			wait((soundgetplaybacktime(#"hash_3e6efe7a558dc61d" + var_c3ba3c34)) * 0.001);
		}
	}
}

/*
	Name: function_77cf4d4a
	Namespace: namespace_69ddf44f
	Checksum: 0x85FB0989
	Offset: 0x14D90
	Size: 0xADC
	Parameters: 0
	Flags: Linked
*/
function function_77cf4d4a()
{
	e_richtofen = function_b1203924(1);
	if(!isdefined(e_richtofen))
	{
		e_richtofen = bot::add_bot(util::get_active_players()[0].team);
		e_richtofen zm_characters::set_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae"));
		e_richtofen endon(#"disconnect");
		e_richtofen val::set(#"boss_bot", "takedamage", 0);
		e_richtofen val::set(#"boss_bot", "ignoreme", 1);
		while(e_richtofen.sessionstate !== "playing")
		{
			waitframe(1);
		}
		while(e_richtofen.sessionstate !== "spectator")
		{
			waitframe(1);
		}
	}
	if(e_richtofen util::is_spectating())
	{
		e_richtofen zm_player::spectator_respawn_player();
	}
	e_richtofen endon(#"death");
	while(e_richtofen.sessionstate !== "playing")
	{
		waitframe(1);
	}
	level thread function_81eedba4(e_richtofen);
	var_b05e79d7 = getent("mechanical_chair", "targetname");
	for(i = 1; i <= 3; i++)
	{
		var_b05e79d7 setmodel(#"hash_4fb2e1f3ca435307" + i);
		var_b05e79d7 playsound(#"hash_556656930bf32b28");
		if(i != 3)
		{
			wait(3.9);
		}
	}
	level flag::set(#"dm_ready");
	if(!isbot(e_richtofen))
	{
		s_interact = struct::get(#"dm_activate");
		s_interact zm_unitrigger::create(&function_6234ba97, undefined, &function_42f33811);
		s_interact waittill(#"trigger_activated");
		zm_unitrigger::unregister_unitrigger(s_interact.s_unitrigger);
		s_interact.s_unitrigger = undefined;
		e_richtofen val::set(#"boss_bot", "takedamage", 0);
		e_richtofen val::set(#"boss_bot", "ignoreme", 1);
	}
	else
	{
		s_location = struct::get(#"dm_location");
		e_richtofen bot_util::function_23cbc6c1(s_location.origin, 1, 16);
		e_richtofen waittilltimeout(60, #"goal");
	}
	level flag::set(#"hash_1b4b6ce05cb62d56");
	if(util::get_active_players().size == 1)
	{
		level.zone_occupied_func = &function_5622ed7e;
	}
	e_richtofen.var_f22c83f5 = 1;
	e_richtofen function_30bab0b0();
	foreach(player in getplayers())
	{
		if(player !== e_richtofen)
		{
			player scene::function_8b06792(array(#"hash_38654bcdffc6d5ed", #"hash_15674d3b96867b43", #"hash_55cf700c69e28ede"));
		}
	}
	scene::add_scene_func(#"hash_25e7b4fd0113745e", &function_dc59c134, "play");
	level thread scene::play(#"hash_25e7b4fd0113745e");
	level thread scene::play(#"p8_zm_esc_dark_machine_bundle", "RICH_IN");
	level scene::play(#"hash_15674d3b96867b43", e_richtofen);
	e_richtofen thread lui::screen_flash(0.1, 1, 0.6, 1, "white");
	level flag::set(#"richtofen_sacrifice");
	e_richtofen setcharacteroutfit(2);
	waitframe(1);
	if(!isdefined(level.var_7e34e7db))
	{
		level.var_7e34e7db = util::spawn_model(#"hash_58eb21ddb61deff4");
	}
	level.var_7e34e7db.script_animname = "cryo_pod";
	a_scene_ents = array(e_richtofen, level.var_7e34e7db);
	level scene::init(#"hash_38654bcdffc6d5ed", a_scene_ents);
	wait(1.2);
	scene::add_scene_func(#"hash_38654bcdffc6d5ed", &function_6225044e, "Shot 3");
	level scene::play(#"hash_38654bcdffc6d5ed", a_scene_ents);
	e_richtofen.var_f22c83f5 = 0;
	level flag::wait_till(#"hash_3d16465b22e70170");
	e_richtofen thread function_30bab0b0(0);
	scene::add_scene_func(#"hash_55cf700c69e28ede", &function_162e2d88, "play");
	scene::add_scene_func(#"hash_55cf700c69e28ede", &raise_fire, "play");
	function_f4b4e39f(1);
	if(isbot(e_richtofen))
	{
		s_door = struct::get(#"hash_5835bfd32af5f016");
		e_richtofen bot_util::function_23cbc6c1(s_door.origin, 1, 16);
		e_richtofen waittilltimeout(20, #"goal");
		level scene::play(#"hash_55cf700c69e28ede", e_richtofen);
	}
	else
	{
		function_f1659bd5(1, 1);
		w_current = e_richtofen getcurrentweapon();
		if(zm_loadout::is_hero_weapon(w_current))
		{
			n_slot = e_richtofen gadgetgetslot(w_current);
			e_richtofen ability_player::turn_gadget_off(n_slot, w_current);
			e_richtofen waittilltimeout(4, #"weapon_change_complete");
		}
		level scene::play(#"hash_55cf700c69e28ede", e_richtofen);
		function_37838b09();
	}
	level flag::set(#"hash_68a1656980e771da");
	callback::on_spawned(&function_c195b1fc);
	if(isbot(e_richtofen))
	{
		level waittill(#"hash_13084094b40f3c48");
		bot::remove_bot(e_richtofen);
	}
	else
	{
		e_richtofen val::reset(#"boss_bot", "takedamage");
		e_richtofen val::reset(#"boss_bot", "ignoreme");
	}
}

/*
	Name: function_c195b1fc
	Namespace: namespace_69ddf44f
	Checksum: 0x89BF9B66
	Offset: 0x15878
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_c195b1fc()
{
	e_richtofen = function_b1203924(1);
	if(self == e_richtofen)
	{
		self setcharacteroutfit(2);
	}
}

/*
	Name: function_6225044e
	Namespace: namespace_69ddf44f
	Checksum: 0xC48D194C
	Offset: 0x158D0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_6225044e(a_ents)
{
	level flag::set(#"hash_68923445ebf488f0");
}

/*
	Name: function_162e2d88
	Namespace: namespace_69ddf44f
	Checksum: 0x9AABE2F5
	Offset: 0x15908
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_162e2d88(a_ents)
{
	wait(1.2);
	mdl_door = getent("c29_door", "targetname");
	mdl_door playsound("zmb_igc_richto_crystal_door");
	mdl_door movez(96, 0.9);
	wait(0.9);
	mdl_door movez(-96, 0.8);
}

/*
	Name: raise_fire
	Namespace: namespace_69ddf44f
	Checksum: 0xB20DB0F3
	Offset: 0x159C0
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function raise_fire(a_ents)
{
	level waittill(#"raise_fire");
	level lui::screen_flash(0.2, 0.5, 1, 0.16, "white");
}

/*
	Name: function_6234ba97
	Namespace: namespace_69ddf44f
	Checksum: 0x74CC164D
	Offset: 0x15A30
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_6234ba97(e_player)
{
	if(e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_4c75fc5691b181cc");
		}
		else
		{
			self sethintstring(#"hash_676b19ae139cb760");
		}
		return true;
	}
	return false;
}

/*
	Name: function_42f33811
	Namespace: namespace_69ddf44f
	Checksum: 0xE3561D37
	Offset: 0x15B00
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_42f33811()
{
	self endon(#"death");
	e_richtofen = function_b1203924();
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!zm_utility::can_use(e_player) || e_player != e_richtofen)
		{
			continue;
		}
		self.stub.related_parent notify(#"trigger_activated", {#e_who:e_player});
	}
}

/*
	Name: function_dc59c134
	Namespace: namespace_69ddf44f
	Checksum: 0x57951C55
	Offset: 0x15BE8
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_dc59c134(a_ents)
{
	a_ents[#"fake_richtofen"] ghost();
	level flag::wait_till(#"richtofen_sacrifice");
	a_ents[#"fake_richtofen"] show();
	level flag::wait_till(#"main_quest_completed");
	level scene::stop(#"hash_25e7b4fd0113745e", 1);
}

/*
	Name: function_5622ed7e
	Namespace: namespace_69ddf44f
	Checksum: 0x614AEA9
	Offset: 0x15CB8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_5622ed7e(str_zone_name)
{
	if(str_zone_name == "zone_west_side_exterior_upper_03")
	{
		return true;
	}
	return false;
}

/*
	Name: function_81eedba4
	Namespace: namespace_69ddf44f
	Checksum: 0xF3E0F249
	Offset: 0x15CE8
	Size: 0x3A8
	Parameters: 1
	Flags: Linked
*/
function function_81eedba4(e_richtofen)
{
	level endon(#"hash_7ceb7f13f6277a7e");
	level flag::wait_till(#"hash_3cc421108aedf47f");
	level zm_audio::sndvoxoverride(1);
	var_45adf42 = function_f2c42deb();
	if(isdefined(var_45adf42))
	{
		var_45adf42 zm_vo::function_a2bd5a0c(#"hash_1afa41c004f5c759", 0, 1, 9999);
	}
	if(isdefined(e_richtofen))
	{
		e_richtofen zm_vo::function_a2bd5a0c(#"hash_1afa40c004f5c5a6", 0, 1, 9999);
	}
	if(isdefined(e_richtofen) && (isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6))
	{
		b_say = e_richtofen zm_vo::vo_say(#"hash_67275e4d65416fa9", 0, 1, 9999, 1, 1, 1);
		if(b_say && isalive(e_richtofen))
		{
			e_richtofen zm_vo::function_a2bd5a0c(#"hash_1afa3ec004f5c240", 0, 1, 9999);
		}
	}
	level flag::wait_till(#"hash_1b4b6ce05cb62d56");
	level waittilltimeout(7, #"hash_3f8d7d050298fd50");
	var_45adf42 = function_f2c42deb();
	if(isdefined(var_45adf42))
	{
		var_45adf42 zm_vo::function_a2bd5a0c(#"hash_68855270c2084c93", 0, 1, 9999);
	}
	level flag::wait_till(#"hash_68923445ebf488f0");
	if(isdefined(e_richtofen))
	{
		e_richtofen zm_vo::function_a2bd5a0c(#"hash_30d26ca75e303a02", 0, 1, 9999, 1, 1);
	}
	if(isdefined(e_richtofen))
	{
		e_richtofen zm_vo::function_a2bd5a0c(#"hash_30d26da75e303bb5", 0, 1, 9999, 1, 1);
	}
	level flag::set(#"hash_3d16465b22e70170");
	level flag::wait_till(#"hash_68a1656980e771da");
	ai_boss = getent("spawner_zm_brutus_special_ai", "script_noteworthy");
	ai_boss zm_vo::vo_say(#"hash_7d4215782b23c898");
	if(isdefined(e_richtofen))
	{
		e_richtofen zm_vo::function_a2bd5a0c(#"hash_581bb829fc9a0c1f", 0, 1, 9999);
	}
	level zm_audio::sndvoxoverride(0);
	zm_vo::function_7922807c(7);
	level notify(#"hash_13084094b40f3c48");
}

/*
	Name: function_f2c42deb
	Namespace: namespace_69ddf44f
	Checksum: 0xBF63E3A4
	Offset: 0x16098
	Size: 0xF0
	Parameters: 0
	Flags: Linked
*/
function function_f2c42deb()
{
	var_a3031870 = array::randomize(util::get_active_players());
	foreach(e_player in var_a3031870)
	{
		if(!e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
		{
			return e_player;
		}
	}
}

/*
	Name: function_9a1e357b
	Namespace: namespace_69ddf44f
	Checksum: 0x1D726205
	Offset: 0x16190
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function function_9a1e357b(n_multiplier = 1)
{
	n_wait = 0.9;
	n_wait = n_wait * n_multiplier;
	n_wait = n_wait - ((util::get_active_players().size - 1) * 0.2);
	if(n_wait < 0.2)
	{
		n_wait = 0.2;
	}
	return n_wait;
}

/*
	Name: function_30febada
	Namespace: namespace_69ddf44f
	Checksum: 0xA0A54C0F
	Offset: 0x16240
	Size: 0x55C
	Parameters: 0
	Flags: Linked
*/
function function_30febada()
{
	var_b962ee19 = array("energy_location_up", "energy_location_right", "energy_location_left", "energy_location_bottom");
	if(!isdefined(level.var_ebd424be))
	{
		level.var_ebd424be = randomintrange(1, 5);
	}
	var_18f25434 = randomintrange(1, 5);
	while(var_18f25434 == level.var_ebd424be)
	{
		waitframe(1);
		var_18f25434 = randomintrange(1, 5);
	}
	var_31ad8eb4 = struct::get("sbrutus_attack_" + var_18f25434);
	var_14ed46ec = util::spawn_model(#"p8_fxp_cylinder_shield", var_31ad8eb4.origin + (vectorscale((0, 0, -1), 61)), var_31ad8eb4.angles);
	level.var_7fe331bf = 0;
	level.var_f493ed9d = 0;
	level.var_e22ef7ff = 0;
	level.var_e7184999 = 0;
	var_3ded86ce = function_708bfb60();
	scene::add_scene_func(#"hash_5d4bfbee934372eb", &function_6546242b, "init");
	var_31ad8eb4 thread scene::play(var_3ded86ce);
	var_3ded86ce thread function_2aa1c625(var_b962ee19[var_18f25434 - 1], var_31ad8eb4.origin);
	wait(1.6);
	exploder::exploder("fxexp_poison_0" + var_18f25434);
	foreach(e_player in util::get_players())
	{
		e_player thread function_4e2f5d87(var_31ad8eb4.origin);
	}
	level thread function_37d4f9(3, 0, 0, 0, util::get_active_players().size);
	level waittilltimeout(11.6, #"boss_loses");
	level.var_dcff743c = 0;
	level.var_e7184999 = 1;
	var_14ed46ec delete();
	if(level.var_7fe331bf)
	{
		scene::add_scene_func(#"hash_2f6dc47d93e018d0", &function_9c59bce1, "play");
		var_3ded86ce scene::play(#"hash_2f6dc47d93e018d0", var_3ded86ce);
		level thread function_17b00ca4(1);
		level waittilltimeout(6.1, #"hash_6721db7073dcfe48");
		level notify(#"hash_77922c6d618e505a");
		if(level.var_e22ef7ff)
		{
			playsoundatposition(#"hash_b04b76e47de1e9d", (9915, 10161, 617));
			level.var_a36cbfaf++;
			level thread function_7cfcac59();
		}
		level thread function_17b00ca4(0);
	}
	else
	{
		level.var_a36cbfaf--;
		level thread function_6f05bd7c();
		scene::add_scene_func(#"hash_dc3b3b48b040137", &function_9c59bce1, "play");
		level notify(#"hash_430c557748eea7b8");
		var_3ded86ce thread scene::play(#"hash_dc3b3b48b040137", var_3ded86ce);
		wait(1);
		level notify(#"hash_7dc902a6d75721a1");
	}
	exploder::kill_exploder("fxexp_poison_0" + var_18f25434);
	function_360daff1();
}

/*
	Name: function_17b00ca4
	Namespace: namespace_69ddf44f
	Checksum: 0x117035E3
	Offset: 0x167A8
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_17b00ca4(var_466b0d0c)
{
	mdl_portal = getent("c29_energy", "targetname");
	if(var_466b0d0c)
	{
		mdl_portal playsound(#"hash_3ea52c9c66d5dc24");
		mdl_portal playloopsound(#"hash_4d39ae8a8d729ec4");
	}
	else
	{
		mdl_portal playsound(#"hash_414b783a085076e0");
		wait(0.5);
		mdl_portal stoploopsound();
	}
}

/*
	Name: function_9c59bce1
	Namespace: namespace_69ddf44f
	Checksum: 0x9070BBC7
	Offset: 0x16878
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_9c59bce1(a_ents)
{
	level waittill(#"boss_despawn");
	if(isdefined(a_ents[#"boss"]))
	{
		a_ents[#"boss"] clientfield::increment("" + #"hash_29d283d7f747d358");
		a_ents[#"boss"] playsound(#"hash_6fd86d58e7f64963");
	}
}

/*
	Name: function_6546242b
	Namespace: namespace_69ddf44f
	Checksum: 0x1B633444
	Offset: 0x16938
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_6546242b(a_ents)
{
	var_17099f35 = [];
	var_17099f35[-1] = #"hash_46e0921e3e770840";
	var_17099f35[0] = #"hash_46e0981e3e771272";
	var_17099f35[1] = #"hash_46e0961e3e770f0c";
	a_ents[#"boss"] playsoundtoteam(var_17099f35[level.var_a36cbfaf], util::get_active_players()[0].team);
}

/*
	Name: function_7cfcac59
	Namespace: namespace_69ddf44f
	Checksum: 0xA4970B7C
	Offset: 0x169F8
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_7cfcac59()
{
	if(level.var_a36cbfaf == 0)
	{
		var_e083ecbd = randomintrange(0, 3);
	}
	else if(level.var_a36cbfaf == 1)
	{
		var_e083ecbd = randomintrange(3, 5);
	}
	if(isdefined(var_e083ecbd))
	{
		str_vo_line = function_7aa8f66f(var_e083ecbd);
		b_said = undefined;
		while(!(isdefined(b_said) && b_said))
		{
			zm_vo::function_3c173d37(level.var_4f538b17.origin, 512);
			b_said = level.var_4f538b17 zm_vo::function_a2bd5a0c(str_vo_line, 0, 1, 9999);
		}
	}
	if(level.var_a36cbfaf == 2)
	{
		level flag::set(#"hash_3cc421108aedf47f");
	}
}

/*
	Name: function_7aa8f66f
	Namespace: namespace_69ddf44f
	Checksum: 0x34037461
	Offset: 0x16B38
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function function_7aa8f66f(var_e083ecbd)
{
	switch(var_e083ecbd)
	{
		case 0:
		case 1:
		case 2:
		{
			str_vo_line = #"hash_453eca2863f832b1";
			break;
		}
		case 3:
		case 4:
		{
			str_vo_line = #"hash_453ec72863f82d98";
			break;
		}
		default:
		{
			break;
		}
	}
	return str_vo_line;
}

/*
	Name: function_6f05bd7c
	Namespace: namespace_69ddf44f
	Checksum: 0x1ED13372
	Offset: 0x16C00
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_6f05bd7c()
{
	if(level.var_a36cbfaf == 0)
	{
		var_e083ecbd = randomintrange(0, 3);
	}
	else if(level.var_a36cbfaf == -1)
	{
		var_e083ecbd = randomintrange(3, 5);
	}
	if(isdefined(var_e083ecbd))
	{
		mdl_portal = getent("c29_energy", "targetname");
		mdl_portal playsoundtoteam(#"hash_5ec49e32f2e3d497" + var_e083ecbd, util::get_active_players()[0].team);
	}
}

/*
	Name: function_4e2f5d87
	Namespace: namespace_69ddf44f
	Checksum: 0x20A62A46
	Offset: 0x16CE8
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function function_4e2f5d87(var_1f61bd3e)
{
	self endon(#"death");
	level endon(#"hash_77922c6d618e505a", #"hash_7dc902a6d75721a1");
	while(true)
	{
		wait(1.6);
		n_dist_2d_sq = distance2dsquared(var_1f61bd3e, self.origin);
		var_533bc5e8 = 65536;
		if(n_dist_2d_sq > var_533bc5e8)
		{
			self dodamage(50, self.origin);
		}
	}
}

/*
	Name: function_2aa1c625
	Namespace: namespace_69ddf44f
	Checksum: 0xCFAE354A
	Offset: 0x16DB0
	Size: 0x206
	Parameters: 2
	Flags: Linked
*/
function function_2aa1c625(var_896fa160, var_1f61bd3e)
{
	level endon(#"hash_77922c6d618e505a");
	level.var_ed0d6c7d = 0;
	var_3758c43e = [];
	for(i = 1; i <= 3; i++)
	{
		s_orb = struct::get((var_896fa160 + "_") + i);
		var_b7eee573 = util::spawn_model(#"hash_6d68fe0dc773635f", s_orb.origin, s_orb.angles);
		var_b7eee573 setcandamage(1);
		var_b7eee573.health = 1116 * util::get_active_players().size;
		var_b7eee573.var_1f61bd3e = var_1f61bd3e;
		var_b7eee573 thread function_bceb2f4c();
		callback::function_9d78f548(&function_2ffe7896, var_b7eee573);
		self thread scene::play(#"hash_4b825982d02adb40" + i, "Shot 1", var_b7eee573);
		if(!isdefined(var_3758c43e))
		{
			var_3758c43e = [];
		}
		else if(!isarray(var_3758c43e))
		{
			var_3758c43e = array(var_3758c43e);
		}
		var_3758c43e[var_3758c43e.size] = var_b7eee573;
		var_b7eee573 thread function_5d55d8d0(self, i);
	}
}

/*
	Name: function_5d55d8d0
	Namespace: namespace_69ddf44f
	Checksum: 0x1194704C
	Offset: 0x16FC0
	Size: 0xD6
	Parameters: 2
	Flags: Linked
*/
function function_5d55d8d0(var_3ded86ce, var_1b7a4481)
{
	self endon(#"death");
	self thread function_9f489c6e();
	level waittill(#"hash_430c557748eea7b8");
	self clientfield::set("" + #"hash_4bea78fdf78a2613", 1);
	var_3ded86ce scene::play(#"hash_4b825982d02adb40" + var_1b7a4481, "Shot 2", self);
	self notify(#"delete_me");
	level.var_f493ed9d = 1;
}

/*
	Name: function_9f489c6e
	Namespace: namespace_69ddf44f
	Checksum: 0x596A75A
	Offset: 0x170A0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_9f489c6e()
{
	self endon(#"death");
	self hide();
	wait(1.6);
	self show();
}

/*
	Name: function_2ffe7896
	Namespace: namespace_69ddf44f
	Checksum: 0x657CE6D8
	Offset: 0x170F8
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function function_2ffe7896(var_386e5658, s_info)
{
	if(!isdefined(s_info) || self != var_386e5658)
	{
		n_damage = 0;
	}
	else
	{
		n_damage = s_info.idamage;
		if(!level.var_e7184999)
		{
			n_dist_2d_sq = distance2dsquared(self.var_1f61bd3e, s_info.eattacker.origin);
			var_533bc5e8 = 65536;
			if(n_dist_2d_sq > var_533bc5e8)
			{
				n_damage = 0;
			}
			n_health_after_damage = self.health - (n_damage * 2);
			if(n_health_after_damage <= 0)
			{
				self notify(#"delete_me");
				n_damage = 0;
			}
		}
		if(n_damage > 0)
		{
			s_info.eattacker util::show_hit_marker();
		}
	}
	return n_damage;
}

/*
	Name: function_bceb2f4c
	Namespace: namespace_69ddf44f
	Checksum: 0xDA5B066B
	Offset: 0x17220
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_bceb2f4c()
{
	self waittill(#"delete_me");
	self clientfield::set("" + #"orb_explosion", 1);
	self ghost();
	level.var_ed0d6c7d++;
	if(level.var_ed0d6c7d == 3)
	{
		level notify(#"boss_loses");
		if(!level.var_f493ed9d)
		{
			level.var_7fe331bf = 1;
		}
	}
	playsoundatposition(#"hash_14e38e92efca6db0", self.origin);
	wait(1.6);
	self delete();
}

/*
	Name: function_360daff1
	Namespace: namespace_69ddf44f
	Checksum: 0x7AAF00DC
	Offset: 0x17320
	Size: 0x30C
	Parameters: 0
	Flags: Linked
*/
function function_360daff1()
{
	mdl_portal = getent("c29_energy", "targetname");
	waitframe(1);
	if(level.var_a36cbfaf == 2)
	{
		level.var_b1312d49 = "players_won";
		mdl_portal clientfield::set("" + #"dm_energy", 1);
	}
	else
	{
		if(level.var_a36cbfaf == -2)
		{
			mdl_portal clientfield::set("" + #"dm_energy", 5);
			wait(1.6);
			level thread lui::screen_flash(0.2, 1, 0.6, 0.9, (1, 0, 0));
			level.var_b1312d49 = "players_lose";
			foreach(e_player in util::get_players())
			{
				e_player thread function_75a41e37();
			}
			mdl_portal playsoundtoteam(#"hash_7ae2ffc3070edcfc", util::get_active_players()[0].team);
			wait(soundgetplaybacktime(#"hash_7ae2ffc3070edcfc") * 0.001);
			level notify(#"end_game");
		}
		else
		{
			if(level.var_a36cbfaf == 1)
			{
				mdl_portal clientfield::set("" + #"dm_energy", 2);
			}
			else
			{
				if(level.var_a36cbfaf == 0)
				{
					mdl_portal clientfield::set("" + #"dm_energy", 3);
				}
				else if(level.var_a36cbfaf == -1)
				{
					mdl_portal clientfield::set("" + #"dm_energy", 4);
				}
			}
		}
	}
}

/*
	Name: function_75a41e37
	Namespace: namespace_69ddf44f
	Checksum: 0x798CDDF9
	Offset: 0x17638
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_75a41e37()
{
	self endon(#"death");
	while(true)
	{
		if(isalive(self))
		{
			self dodamage(self.health + 1, self.origin);
		}
		waitframe(1);
	}
}

/*
	Name: step_6_cleanup
	Namespace: namespace_69ddf44f
	Checksum: 0x5D6327E5
	Offset: 0x176A8
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function step_6_cleanup(var_a276c861, var_19e802fa)
{
	if(var_a276c861 || var_19e802fa)
	{
		level flag::set(#"hash_3cc421108aedf47f");
		level.var_b1312d49 = "players_won";
	}
}

/*
	Name: step_7
	Namespace: namespace_69ddf44f
	Checksum: 0xF8956717
	Offset: 0x17708
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function step_7(var_a276c861)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_7629706a5a9c7bf7", 7);
	level thread scene::init_streamer(#"hash_641ed02ad1d85897", #"allies", 0, 0);
	music::setmusicstate("none");
	level.musicsystemoverride = 0;
	if(!var_a276c861)
	{
		level thread function_77cf4d4a();
		level flag::wait_till(#"dm_ready");
		level waittilltimeout(6.1, #"hash_1b4b6ce05cb62d56");
		level.musicsystemoverride = 1;
		music::setmusicstate("boss");
		level thread function_108ff870();
		level thread function_37d4f9(2, -1, 3, 1);
		level flag::wait_till(#"main_quest_completed");
	}
}

/*
	Name: step_7_cleanup
	Namespace: namespace_69ddf44f
	Checksum: 0x33348708
	Offset: 0x17890
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function step_7_cleanup(var_a276c861, var_19e802fa)
{
	a_ai_brutus = getaiarchetypearray(#"brutus");
	foreach(ai_brutus in a_ai_brutus)
	{
		ai_brutus dodamage(ai_brutus.health + 666, ai_brutus.origin);
	}
	level zm_utility::function_9ad5aeb1(1, 1, 0, 0, 0);
}

/*
	Name: outro
	Namespace: namespace_69ddf44f
	Checksum: 0x7A1021A3
	Offset: 0x17990
	Size: 0x54C
	Parameters: 1
	Flags: Linked
*/
function outro(var_a276c861)
{
	foreach(e_player in util::get_players())
	{
		e_player clientfield::set("" + #"hash_b8601726e1e4a6a", 1);
	}
	scene::add_scene_func(#"hash_641ed02ad1d85897", &function_44267df1, "init");
	scene::add_scene_func(#"hash_641ed02ad1d85897", &function_ed66b9f7, "play");
	level thread scene::init(#"hash_641ed02ad1d85897");
	foreach(e_player in util::get_active_players())
	{
		e_player freezecontrols(1);
		e_player.var_16735873 = 1;
	}
	level lui::screen_fade_out(1.6, "white");
	level.lighting_state = 0;
	self util::set_lighting_state(level.lighting_state);
	music::setmusicstate("none");
	level.musicsystemoverride = 0;
	hidemiscmodels("mechanical_chair");
	var_b05e79d7 = getent("mechanical_chair", "targetname");
	level thread scene::stop(#"p8_zm_esc_dark_machine_bundle");
	var_b05e79d7 hide();
	mdl_portal = getent("c29_energy", "targetname");
	mdl_portal clientfield::set("" + #"dm_energy", 0);
	exploder::stop_exploder("fxexp_script_l_d");
	exploder::stop_exploder("fxexp_script_l_c");
	exploder::stop_exploder("fxexp_script_l_n_i");
	exploder::stop_exploder("fxexp_script_l_s");
	exploder::stop_exploder("fxexp_script_l_p_p");
	exploder::stop_exploder("fxexp_lighthouse_dest");
	level clientfield::set("dog_round_fog_bank", 0);
	foreach(chest in level.chests)
	{
		if(isdefined(chest) && isdefined(chest.pandora_light))
		{
			chest.pandora_light delete();
		}
	}
	callback::remove_on_connect(&zm_escape_util::function_6a1500f1);
	level notify(#"hash_40cd2e6f2c496d75");
	foreach(e_player in util::get_players())
	{
		self util::set_lighting_state(level.lighting_state);
	}
	zombie_utility::clear_all_corpses();
	level thread play_outro();
}

/*
	Name: outro_cleanup
	Namespace: namespace_69ddf44f
	Checksum: 0x9AC0C06C
	Offset: 0x17EE8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function outro_cleanup(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_44267df1
	Namespace: namespace_69ddf44f
	Checksum: 0xCA752901
	Offset: 0x17F08
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_44267df1(a_ents)
{
	foreach(e_prop in a_ents)
	{
		if(isdefined(e_prop.model) && (e_prop.model == #"c_t8_zmb_mob_ghoul_body2_rob" || e_prop.model == #"c_t8_zmb_mob_ghoul_body1_rob" || e_prop.model == #"c_t8_zmb_mob_ghoul_body3_rob"))
		{
			e_prop clientfield::set("" + #"hash_624198b41791933f", 1);
			e_prop ghost();
		}
	}
	var_e5c7e01a = a_ents[#"bird"];
	var_e5c7e01a ghost();
}

/*
	Name: function_ed66b9f7
	Namespace: namespace_69ddf44f
	Checksum: 0x47F7A18F
	Offset: 0x18078
	Size: 0x274
	Parameters: 1
	Flags: Linked
*/
function function_ed66b9f7(a_ents)
{
	level lui::screen_fade_in(0.15, "white");
	foreach(e_player in util::get_active_players())
	{
		e_player freezecontrols(0);
	}
	wait(5);
	foreach(e_prop in a_ents)
	{
		if(isdefined(e_prop.model) && (e_prop.model == #"c_t8_zmb_mob_ghoul_body2_rob" || e_prop.model == #"c_t8_zmb_mob_ghoul_body1_rob" || e_prop.model == #"c_t8_zmb_mob_ghoul_body3_rob"))
		{
			e_prop clientfield::set("" + #"hash_624198b41791933f", 0);
			e_prop show();
		}
	}
	var_e5c7e01a = a_ents[#"bird"];
	var_e5c7e01a show();
	var_e5c7e01a clientfield::set("" + #"hash_504d26c38b96651c", 1);
	var_e5c7e01a waittill(#"b_gh");
	var_e5c7e01a hide();
}

/*
	Name: play_outro
	Namespace: namespace_69ddf44f
	Checksum: 0xAD622BD1
	Offset: 0x182F8
	Size: 0x138
	Parameters: 0
	Flags: Linked
*/
function play_outro()
{
	level zm_vo::function_3c173d37((0, 0, 0), 2147483647);
	level zm_audio::sndvoxoverride(1);
	level scene::play(#"hash_641ed02ad1d85897");
	foreach(e_player in util::get_players())
	{
		e_player clientfield::set("" + #"hash_b8601726e1e4a6a", 0);
		level.var_7c7c6c35 zm_game_over::set_state(e_player, #"gatewayopened");
	}
	level notify(#"end_game");
}

/*
	Name: function_f7a9d7c4
	Namespace: namespace_69ddf44f
	Checksum: 0xA7058F59
	Offset: 0x18438
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_f7a9d7c4()
{
	self notify(#"hash_108cb6aa18caf726");
	self zm_challenges::function_9a9ab6f6(#"hash_ad3a508a80a0e6e");
	if(!isdefined(self.var_6257071f))
	{
		self zm_challenges::function_979f4cc0(#"hash_6d551a71b5461906");
	}
}

/*
	Name: function_314447b
	Namespace: namespace_69ddf44f
	Checksum: 0x8A935A01
	Offset: 0x184A8
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_314447b(b_pause = 0, var_53458a86 = 1)
{
	if(b_pause)
	{
		level.disable_nuke_delay_spawning = 1;
		level flag::clear("spawn_zombies");
		level zm_utility::function_9ad5aeb1(1, 1, 0, var_53458a86, 0);
	}
	else
	{
		level.disable_nuke_delay_spawning = 0;
		level flag::set("spawn_zombies");
	}
}

/*
	Name: move_seagull
	Namespace: namespace_69ddf44f
	Checksum: 0x81D94C03
	Offset: 0x18570
	Size: 0x23E
	Parameters: 4
	Flags: Linked
*/
function move_seagull(var_813c2299, str_endon_notify, n_speed = 300, b_skippable = 0)
{
	level notify(#"move_seagull");
	level endon(#"move_seagull");
	if(isdefined(str_endon_notify) && (isstring(str_endon_notify) || ishash(str_endon_notify)))
	{
		self endon(str_endon_notify);
		level endon(str_endon_notify);
	}
	self.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "loop_anim", self);
	var_21fedc12 = struct::get(var_813c2299);
	while(isdefined(var_21fedc12))
	{
		n_time = distance(self.origin, var_21fedc12.origin) / n_speed;
		if(n_time < 0.8)
		{
			n_time = 0.8;
		}
		self.mdl_origin moveto(var_21fedc12.origin, n_time);
		self.mdl_origin rotateto(var_21fedc12.angles, n_time);
		self.mdl_origin waittill(#"movedone");
		var_21fedc12 = self function_72f1cfd1(var_21fedc12, b_skippable);
	}
	self.mdl_origin thread scene::play(#"p8_fxanim_aml_seagull_body1_ghost_bundle", "idle_flying_loop", self);
	self notify(#"hash_10107d27cb385d36");
}

/*
	Name: function_72f1cfd1
	Namespace: namespace_69ddf44f
	Checksum: 0xCC467DDB
	Offset: 0x187B8
	Size: 0x16E
	Parameters: 2
	Flags: Linked
*/
function function_72f1cfd1(s_current, b_skippable)
{
	s_target = struct::get(s_current.target);
	if(b_skippable && isdefined(s_target) && isdefined(level.var_dc4013b0))
	{
		while(isdefined(level.var_dc4013b0) && s_target.origin[0] > level.var_dc4013b0.origin[0])
		{
			wait(1.6);
		}
		if(isdefined(level.var_dc4013b0))
		{
			var_b5470e0d = level.var_dc4013b0.origin[0] - s_target.origin[0];
		}
		while(isdefined(level.var_dc4013b0) && var_b5470e0d > 128)
		{
			s_next = s_target;
			s_target = struct::get(s_next.target);
			var_b5470e0d = level.var_dc4013b0.origin[0] - s_target.origin[0];
		}
	}
	self.s_target = s_target;
	return s_target;
}

/*
	Name: function_30bab0b0
	Namespace: namespace_69ddf44f
	Checksum: 0xF7E44B13
	Offset: 0x18930
	Size: 0x2EC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_30bab0b0(b_taken = 1)
{
	if(!isdefined(self) || !isentity(self))
	{
		return;
	}
	self endon(#"death", #"disconnect");
	if(b_taken)
	{
		if(self hasweapon(getweapon(#"zhield_spectral_dw_upgraded")))
		{
			self.var_a4d61ba4 = 1;
			weapon = getweapon(#"zhield_spectral_dw_upgraded");
		}
		else
		{
			if(self hasweapon(getweapon(#"zhield_spectral_dw")))
			{
				self.var_719ddec1 = 1;
				weapon = getweapon(#"zhield_spectral_dw");
			}
			else
			{
				return;
			}
		}
		if(isdefined(self.var_9fd623ed) && self.var_9fd623ed > 0)
		{
			self.var_b3032361 = self.var_9fd623ed;
		}
		self takeweapon(weapon);
		self notify(#"destroy_riotshield");
		self.hasriotshield = 0;
		self.hasriotshieldequipped = 0;
		self.var_d3345483 = undefined;
		self zm_weapons::clear_stowed_weapon();
	}
	else
	{
		if(isdefined(self.var_a4d61ba4) && self.var_a4d61ba4)
		{
			self.var_a4d61ba4 = undefined;
			self giveweapon(getweapon(#"zhield_spectral_dw_upgraded"));
		}
		else
		{
			if(isdefined(self.var_719ddec1) && self.var_719ddec1)
			{
				self.var_719ddec1 = undefined;
				self giveweapon(getweapon(#"zhield_spectral_dw"));
			}
			else
			{
				return;
			}
		}
		wait(0.5);
		if(isdefined(self.var_b3032361))
		{
			self.var_9fd623ed = self.var_b3032361;
			self.var_b3032361 = undefined;
			self thread zm_weap_spectral_shield::function_804309c();
			self zm_weapons::set_stowed_weapon(self.weaponriotshield);
		}
	}
}

/*
	Name: function_9e723e9
	Namespace: namespace_69ddf44f
	Checksum: 0xC34CCBE0
	Offset: 0x18C28
	Size: 0x3AC
	Parameters: 2
	Flags: Linked
*/
function function_9e723e9(n_time = 3, var_57feea38 = 0)
{
	s_beam = struct::get("s_p_s1_lh_r_light");
	if(!isdefined(s_beam.var_8999a4bf))
	{
		s_beam.var_8999a4bf = util::spawn_model("tag_origin", s_beam.origin);
		s_beam.var_8999a4bf clientfield::set("" + #"hash_1f572bbcdde55d9d", 1);
		level.var_3d98e258 = 1;
	}
	s_beam.var_8999a4bf endon(#"death");
	if(var_57feea38)
	{
		s_beam.var_8999a4bf clientfield::set("" + #"hash_1f572bbcdde55d9d", level.var_3d98e258);
		wait(n_time);
	}
	if(!isdefined(self.script_string))
	{
		n_clientfield = 1;
		var_52036da7 = 1;
		level.var_3d98e258 = 1;
	}
	else
	{
		switch(self.script_string)
		{
			case "cellblock":
			{
				n_clientfield = 2;
				level.var_3d98e258 = 2;
				break;
			}
			case "showers":
			case "docks":
			{
				n_clientfield = 3;
				level.var_3d98e258 = 3;
				break;
			}
			case "new_industries":
			case "power_plant":
			{
				n_clientfield = 4;
				level.var_3d98e258 = 4;
				break;
			}
		}
	}
	if(!var_57feea38)
	{
		s_beam.var_8999a4bf clientfield::set("" + #"hash_1f572bbcdde55d9d", n_clientfield);
		wait(0.1);
	}
	v_dir = vectornormalize(self.origin - s_beam.var_8999a4bf.origin);
	v_angles = vectortoangles(v_dir);
	s_beam.var_8999a4bf rotateto(v_angles, n_time);
	if(var_57feea38)
	{
		wait(0.5);
		s_beam.var_8999a4bf clientfield::set("" + #"hash_1f572bbcdde55d9d", n_clientfield);
	}
	if(isdefined(var_52036da7) && var_52036da7)
	{
		s_beam.var_8999a4bf waittill(#"rotatedone");
		s_beam.var_8999a4bf clientfield::set("" + #"hash_1f572bbcdde55d9d", 5);
	}
}

/*
	Name: function_a90b7995
	Namespace: namespace_69ddf44f
	Checksum: 0xCC0AFBF3
	Offset: 0x18FE0
	Size: 0x1DC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a90b7995()
{
	level.var_659daf1d = [];
	level.var_dd650b0e = [];
	level thread function_5341907e();
	var_f8c33269 = getent("jar_1", "targetname");
	var_f8c33269 hidepart("tag_socket_a");
	var_f8c33269 hidepart("tag_socket_b");
	var_f8c33269 hidepart("tag_socket_c");
	var_f8c33269 hidepart("tag_socket_d");
	var_f8c33269 hidepart("tag_socket_e");
	var_f8c33269 hidepart("tag_socket_f");
	var_f8c33269 hidepart("tag_socket_g");
	var_f8c33269 hidepart("tag_glow_a");
	var_f8c33269 hidepart("tag_glow_c");
	var_f8c33269 hidepart("tag_glow_d");
	var_f8c33269 hidepart("tag_glow_e");
	var_f8c33269 hidepart("tag_glow_g");
}

/*
	Name: function_5341907e
	Namespace: namespace_69ddf44f
	Checksum: 0x97D66F47
	Offset: 0x191C8
	Size: 0x5E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_5341907e()
{
	var_c699e2b5 = struct::get("s_p_s2_ins");
	var_c699e2b5.s_unitrigger_stub = var_c699e2b5 zm_unitrigger::create(&function_5f4260cf, 40, &function_276db81);
}

/*
	Name: function_276db81
	Namespace: namespace_69ddf44f
	Checksum: 0xD83F6232
	Offset: 0x19230
	Size: 0x188
	Parameters: 0
	Flags: Linked
*/
function function_276db81()
{
	level flag::wait_till(#"hash_40e9ad323fe8402a");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		if(isplayer(s_result.activator) && level.var_659daf1d.size)
		{
			s_result.activator clientfield::increment_to_player("" + #"hash_506164c22c4c7ca8");
			a_str_tags = arraycopy(level.var_659daf1d);
			foreach(str_tag in a_str_tags)
			{
				level thread function_e998f810(str_tag);
				arrayremovevalue(level.var_659daf1d, str_tag);
			}
			self.stub notify(#"hash_4c6ab2a4a99f9539");
		}
	}
}

/*
	Name: function_5f4260cf
	Namespace: namespace_69ddf44f
	Checksum: 0x6AE32139
	Offset: 0x193C0
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function function_5f4260cf(e_player)
{
	if(level.var_659daf1d.size)
	{
		return true;
	}
	return false;
}

/*
	Name: function_e998f810
	Namespace: namespace_69ddf44f
	Checksum: 0x7CA6E459
	Offset: 0x193F8
	Size: 0x54A
	Parameters: 1
	Flags: Linked
*/
function function_e998f810(str_tag)
{
	var_f8c33269 = getent("jar_1", "targetname");
	if(!isdefined(level.var_dd650b0e))
	{
		level.var_dd650b0e = [];
	}
	else if(!isarray(level.var_dd650b0e))
	{
		level.var_dd650b0e = array(level.var_dd650b0e);
	}
	if(!isinarray(level.var_dd650b0e, str_tag))
	{
		level.var_dd650b0e[level.var_dd650b0e.size] = str_tag;
	}
	switch(str_tag)
	{
		case "tag_socket_a":
		{
			var_f8c33269 hidepart("tag_map_part_a");
			var_f8c33269 showpart("tag_socket_a");
			var_f8c33269 clientfield::set("" + #"hash_2928b6d60aaacda6", 1);
			var_f8c33269 showpart("tag_glow_a");
			break;
		}
		case "tag_socket_b":
		{
			var_f8c33269 hidepart("tag_map_part_b");
			var_f8c33269 showpart("tag_socket_b");
			var_f8c33269 clientfield::set("" + #"hash_2928b6d60aaacda6", 2);
			break;
		}
		case "tag_socket_c":
		{
			var_f8c33269 hidepart("tag_map_part_c");
			var_f8c33269 showpart("tag_socket_c");
			var_f8c33269 clientfield::set("" + #"hash_2928b6d60aaacda6", 3);
			var_f8c33269 showpart("tag_glow_c");
			break;
		}
		case "tag_socket_d":
		{
			var_f8c33269 hidepart("tag_map_part_d");
			var_f8c33269 showpart("tag_socket_d");
			var_f8c33269 clientfield::set("" + #"hash_2928b6d60aaacda6", 4);
			var_f8c33269 showpart("tag_glow_d");
			break;
		}
		case "tag_socket_e":
		{
			var_f8c33269 hidepart("tag_map_part_e");
			var_f8c33269 showpart("tag_socket_e");
			var_f8c33269 clientfield::set("" + #"hash_2928b6d60aaacda6", 5);
			var_f8c33269 showpart("tag_glow_e");
			break;
		}
		case "tag_socket_f":
		{
			var_f8c33269 hidepart("tag_map_part_f");
			var_f8c33269 showpart("tag_socket_f");
			var_f8c33269 clientfield::set("" + #"hash_2928b6d60aaacda6", 6);
			break;
		}
		case "tag_socket_g":
		{
			var_f8c33269 hidepart("tag_map_part_g");
			var_f8c33269 showpart("tag_socket_g");
			var_f8c33269 clientfield::set("" + #"hash_2928b6d60aaacda6", 7);
			var_f8c33269 showpart("tag_glow_g");
			break;
		}
	}
}

