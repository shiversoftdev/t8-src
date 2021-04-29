// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3496aeeccaa9d66a;
#using script_387eab232fe22983;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using script_ab862743b3070a;
#using script_b52a163973f339f;
#using script_b761c44ab2e5b46;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_mansion_pap_quest.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_a8113e97;

/*
	Name: init
	Namespace: namespace_a8113e97
	Checksum: 0x2837A2C1
	Offset: 0xA30
	Size: 0x804
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("allplayers", "" + #"hash_5370f4bc9fc25d13", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_42b6c982eeb59c79", 8000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_15af8e35c0c1f344", 8000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_663a4a99828c832b", 8000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_709c03abf1a2e08b", 8000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_61d9ba9310d827ea", 8000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_5eff598dc267e32a", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_4f11537440270a3", 8000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_141bb928b3d09e20", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_34c5ab29531f15f0", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_546e7612359187c3", 8000, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_73a4abf07bc65bc3", 8000, 1, "counter");
	clientfield::register("world", "" + #"hash_557a1703971f074c", 8000, 1, "int");
	function_c739f755();
	init_flags();
	scene::add_scene_func(#"hash_68332e1f4a178f99", &function_ea49787e, "init");
	scene::add_scene_func(#"hash_66b780d6495a613c", &function_604f9d73, "init");
	level thread scene::init(#"hash_66b780d6495a613c");
	level thread scene::init(#"hash_76720505cdbd413f");
	level.var_1613cea0 = 0;
	level.var_dd0ec1fe = getent("ring_outer", "targetname");
	level.var_7ff4f03a = getent("ring_middle", "targetname");
	level.var_6ce9da5c = getent("ring_inner", "targetname");
	level.var_dd0ec1fe.e_linkto = getent("ring_outer_linkto", "targetname");
	level.var_dd0ec1fe linkto(level.var_dd0ec1fe.e_linkto);
	level.var_7ff4f03a.e_linkto = getent("ring_middle_linkto", "targetname");
	level.var_7ff4f03a linkto(level.var_7ff4f03a.e_linkto);
	level.var_6ce9da5c.e_linkto = getent("ring_inner_linkto", "targetname");
	level.var_6ce9da5c linkto(level.var_6ce9da5c.e_linkto);
	level.var_dd0ec1fe.e_pos = getent(level.var_dd0ec1fe.target, "targetname");
	level.var_7ff4f03a.e_pos = getent(level.var_7ff4f03a.target, "targetname");
	level.var_6ce9da5c.e_pos = getent(level.var_6ce9da5c.target, "targetname");
	level.var_dd0ec1fe.e_pos linkto(level.var_dd0ec1fe);
	level.var_7ff4f03a.e_pos linkto(level.var_7ff4f03a);
	level.var_6ce9da5c.e_pos linkto(level.var_6ce9da5c);
	level.var_dd0ec1fe.v_start = level.var_dd0ec1fe.e_pos.origin;
	level.var_7ff4f03a.v_start = level.var_7ff4f03a.e_pos.origin;
	level.var_6ce9da5c.v_start = level.var_6ce9da5c.e_pos.origin;
	var_65c9997c = getent("stone_obs", "targetname");
	var_65c9997c ghost();
	level thread function_5f259315();
	level thread function_30fcf7ae();
	if(zm_utility::function_e51dc2d8())
	{
		level thread function_9513d3a6();
		level thread function_3f64b455();
		level thread function_b87ae607();
	}
}

/*
	Name: function_30fcf7ae
	Namespace: namespace_a8113e97
	Checksum: 0x3C411FBF
	Offset: 0x1240
	Size: 0x3A4
	Parameters: 0
	Flags: Linked
*/
function function_30fcf7ae()
{
	level.var_ddfdc3b6 = getent("crystal_outer", "targetname");
	level.var_ddfdc3b6 linkto(level.var_dd0ec1fe);
	level.var_ddfdc3b6.v_start = level.var_ddfdc3b6.origin;
	level.var_6a6d4760 = getent("crystal_middle", "targetname");
	level.var_6a6d4760 linkto(level.var_7ff4f03a);
	level.var_6a6d4760.v_start = level.var_6a6d4760.origin;
	level.var_bfd6fc7e = getent("crystal_inner", "targetname");
	level.var_bfd6fc7e linkto(level.var_6ce9da5c);
	level.var_bfd6fc7e.v_start = level.var_bfd6fc7e.origin;
	level.var_a5e8b59c = getent("blue_light", "targetname");
	level.var_ca5d3cc2 = getent("green_light", "targetname");
	level.var_92ee6d8f = getent("red_light", "targetname");
	array::run_all(getentarray("r_con", "script_noteworthy"), &hide);
	level thread function_2038666b();
	level flag::wait_till("ley_start");
	array::run_all(getentarray("r_con", "script_noteworthy"), &show);
	a_players = util::get_active_players();
	var_6f9fc893 = array::random(a_players);
	if(isalive(var_6f9fc893))
	{
		var_6f9fc893 thread namespace_891c9bac::function_a2bd5a0c(#"hash_22f0e4f17e4e1994", 0, 1);
	}
	level.var_a5e8b59c clientfield::set("" + #"hash_61d9ba9310d827ea", 1);
	level.var_ca5d3cc2 clientfield::set("" + #"hash_709c03abf1a2e08b", 1);
	level.var_92ee6d8f clientfield::set("" + #"hash_663a4a99828c832b", 1);
}

/*
	Name: function_5f259315
	Namespace: namespace_a8113e97
	Checksum: 0x5A13781
	Offset: 0x15F0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_5f259315()
{
	level flag::wait_till(#"open_pap");
	if(zm_utility::function_e51dc2d8())
	{
		if(namespace_59ff1d6c::function_901b751c(#"hash_3c5363541b97ca3e") && namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") != 2)
		{
			namespace_ee206246::start(#"hash_559b7237b8acece2");
		}
	}
}

/*
	Name: function_c739f755
	Namespace: namespace_a8113e97
	Checksum: 0x354AEF79
	Offset: 0x1698
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_c739f755()
{
	namespace_ee206246::register(#"hash_559b7237b8acece2", #"step_1", #"hash_2388f47d8d90bdfb", &function_cdfe68a2, &function_c5868f47);
	namespace_ee206246::register(#"hash_559b7237b8acece2", #"step_2", #"hash_2388f57d8d90bfae", &function_a03f8d25, &function_f05be4f1);
	namespace_ee206246::register(#"hash_559b7237b8acece2", #"step_3", #"hash_2388f67d8d90c161", &function_aa79a199, &function_bafa7a2b);
	namespace_ee206246::register(#"hash_559b7237b8acece2", #"step_4", #"hash_2388f77d8d90c314", &function_86e35a69, &function_a93d56b1);
}

/*
	Name: init_flags
	Namespace: namespace_a8113e97
	Checksum: 0xEE9A857E
	Offset: 0x1828
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_546b8f78e6510d81");
	level flag::init(#"hash_546b8c78e6510868");
	level flag::init(#"hash_546b8d78e6510a1b");
	level flag::init(#"hash_546b9278e651129a");
	level flag::init(#"ley_start");
	level flag::init(#"hash_4e13220b07971761");
	level flag::init(#"hash_9e03a22668d24b");
	level flag::init(#"hash_76ea4b1b1c7ac757");
	level flag::init(#"hash_3e3ae137d6c07f8d");
	level flag::init(#"hash_426c0f5a9e34edc2");
	level flag::init(#"hash_583d263e32521ee0");
	level flag::init(#"hash_b240a9137ecc6f9");
	level flag::init(#"hash_10693cfc20e83df1");
	level flag::init(#"hash_702dbaf6695a5607");
}

/*
	Name: function_cdfe68a2
	Namespace: namespace_a8113e97
	Checksum: 0x1D13099E
	Offset: 0x19F8
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_cdfe68a2(var_a276c861)
{
	var_65c9997c = getent("gazing_stone_library", "targetname");
	var_47323b73 = var_65c9997c zm_unitrigger::create(undefined, 64, &function_55b79f54);
	var_47323b73.str_loc = "library";
	var_47323b73.var_f0e6c7a2 = var_65c9997c;
	if(!var_47323b73.var_f0e6c7a2 flag::exists(#"flag_gazing_stone_in_use"))
	{
		var_47323b73.var_f0e6c7a2 flag::init(#"flag_gazing_stone_in_use");
	}
	level thread function_6e89c193();
	level thread function_d3128b5f();
	if(!var_a276c861)
	{
		level flag::wait_till(#"ley_start");
	}
}

/*
	Name: function_c5868f47
	Namespace: namespace_a8113e97
	Checksum: 0x3FBD42A5
	Offset: 0x1B38
	Size: 0x17C
	Parameters: 2
	Flags: Linked
*/
function function_c5868f47(var_5ea5c94d, ended_early)
{
	level flag::set(#"gazed_library");
	level flag::set(#"ley_start");
	foreach(str_flag in array(#"hash_546b8f78e6510d81", #"hash_546b8c78e6510868", #"hash_546b8d78e6510a1b", #"hash_546b9278e651129a"))
	{
		level flag::set(str_flag);
	}
	var_2782a2fe = getent("beam_man", "targetname");
	var_2782a2fe clientfield::set("" + #"hash_42b6c982eeb59c79", 1);
}

/*
	Name: function_a03f8d25
	Namespace: namespace_a8113e97
	Checksum: 0x508108C2
	Offset: 0x1CC0
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_a03f8d25(var_a276c861)
{
	level namespace_6747c550::function_7df6bb60(#"hash_7b006e4a8b2139a2", 1);
	if(!var_a276c861)
	{
		level flag::wait_till(#"hash_4e13220b07971761");
	}
}

/*
	Name: function_f05be4f1
	Namespace: namespace_a8113e97
	Checksum: 0xD49A21B1
	Offset: 0x1D28
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_f05be4f1(var_5ea5c94d, ended_early)
{
	level flag::set(#"hash_4e13220b07971761");
}

/*
	Name: function_aa79a199
	Namespace: namespace_a8113e97
	Checksum: 0x5880635C
	Offset: 0x1D68
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_aa79a199(var_a276c861)
{
	level namespace_6747c550::function_7df6bb60(#"hash_7b006f4a8b213b55", 1);
	exploder::exploder("fxexp_telescope_charge");
	playsoundatposition(#"hash_75404411ef08e098", (4029, -146, -138));
	level thread function_d3f6a790();
	level thread function_5164d716();
	level thread function_1c760913();
	level thread function_d8162064();
	if(!var_a276c861)
	{
		getent("trigger_combo_button", "targetname") thread function_bfefc7aa();
		level flag::wait_till(#"hash_76ea4b1b1c7ac757");
		function_986307c4();
	}
	level thread function_fda40d17();
}

/*
	Name: function_bafa7a2b
	Namespace: namespace_a8113e97
	Checksum: 0x1A1F04CD
	Offset: 0x1ED0
	Size: 0x2BC
	Parameters: 2
	Flags: Linked
*/
function function_bafa7a2b(var_5ea5c94d, ended_early)
{
	level notify(#"hash_11429494f29d116d");
	level flag::set(#"ley_start");
	level flag::set(#"hash_4e13220b07971761");
	/#
		if(!level flag::get(#"hash_76ea4b1b1c7ac757"))
		{
			var_da3daf09 = function_b1b02a54();
			var_da3daf09 thread scene::play(#"hash_3225470f7ea39ab3", var_da3daf09);
			mdl_door_right = getent("", "");
			mdl_door_left = getent("", "");
			var_5a2e8e4f = anglestoright(mdl_door_right.angles);
			var_58aebac7 = anglestoright(mdl_door_left.angles);
			var_a40d6e4f = mdl_door_right.origin + var_5a2e8e4f * 64;
			var_5f19fbd3 = mdl_door_left.origin - var_58aebac7 * 64;
			mdl_door_right moveto(var_a40d6e4f, 0.1);
			mdl_door_left moveto(var_5f19fbd3, 0.1);
			mdl_door_left waittill(#"movedone");
		}
	#/
	level flag::set(#"hash_76ea4b1b1c7ac757");
	level flag::set(#"hash_3e3ae137d6c07f8d");
	level flag::set(#"hash_426c0f5a9e34edc2");
	var_7f147f52 = getent("t_eshield_check", "targetname");
	var_7f147f52 delete();
}

/*
	Name: function_86e35a69
	Namespace: namespace_a8113e97
	Checksum: 0x91C1F17C
	Offset: 0x2198
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function function_86e35a69(var_a276c861)
{
	level namespace_6747c550::function_7df6bb60(#"hash_7b00684a8b212f70", 1);
	level thread function_c888f1f4();
	level thread function_1be5e603();
	if(!var_a276c861)
	{
		level flag::wait_till(#"hash_583d263e32521ee0");
		level flag::clear(#"spawn_zombies");
		level flag::clear(#"zombie_drop_powerups");
		namespace_c05f06c7::function_45ac4bb8();
		level thread function_f3668a9();
		level thread namespace_c05f06c7::function_bb613572(function_a7bed514(), #"hash_b240a9137ecc6f9");
		wave_1();
		wave_3();
		a_players = util::get_active_players();
		var_6f9fc893 = array::random(a_players);
		if(isalive(var_6f9fc893))
		{
			var_6f9fc893 thread namespace_891c9bac::function_a2bd5a0c(#"hash_5927981205a122fc", 0, 1);
		}
		level flag::wait_till(#"hash_10693cfc20e83df1");
	}
}

/*
	Name: function_a93d56b1
	Namespace: namespace_a8113e97
	Checksum: 0x599E23E1
	Offset: 0x2380
	Size: 0x174
	Parameters: 2
	Flags: Linked
*/
function function_a93d56b1(var_5ea5c94d, ended_early)
{
	level flag::set(#"hash_10693cfc20e83df1");
	level flag::set(#"hash_b240a9137ecc6f9");
	level notify(#"hash_3c7945247db32d89");
	var_65c9997c = getent("stone_obs", "targetname");
	if(isdefined(var_65c9997c))
	{
		var_65c9997c delete();
	}
	var_6372f21f = struct::get("relic_greenhouse");
	mdl_relic = util::spawn_model(#"hash_2282e81c2ba17337", var_6372f21f.origin, var_6372f21f.angles);
	util::wait_network_frame();
	mdl_relic.targetname = var_6372f21f.targetname;
	mdl_relic clientfield::set("" + #"hash_5eff598dc267e32a", 1);
}

/*
	Name: function_55b79f54
	Namespace: namespace_a8113e97
	Checksum: 0x83B4D470
	Offset: 0x2500
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function function_55b79f54()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::can_use(player) || (isdefined(player.var_e60ec8e9) && player.var_e60ec8e9) || (isdefined(player.var_d049df11) && player.var_d049df11) || distancesquared(groundtrace(player.origin, player.origin + vectorscale((0, 0, -1), 128), 0, player)[#"position"], player.origin) > 16)
		{
			continue;
		}
		level thread namespace_b8f22955::function_9e7129d2(player, self.stub.var_f0e6c7a2, 16, "ley");
		player thread namespace_c05f06c7::function_58dfa337(15);
		player thread namespace_c05f06c7::function_a113df82(18);
		level flag::set(#"gazed_library");
	}
}

/*
	Name: function_a8de7aeb
	Namespace: namespace_a8113e97
	Checksum: 0x90E49969
	Offset: 0x26A8
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_a8de7aeb(player)
{
}

/*
	Name: function_6e89c193
	Namespace: namespace_a8113e97
	Checksum: 0x9010B346
	Offset: 0x26C0
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_6e89c193()
{
	level flag::wait_till(#"gazed_library");
	level namespace_6747c550::function_7df6bb60(#"hash_7b006d4a8b2137ef", 1);
	scene::add_scene_func(#"hash_317afc9eb6bd2436", &function_d961aafc, "shot 1");
	level scene::play(#"hash_317afc9eb6bd2436", "shot 1");
	scene::remove_scene_func(#"hash_317afc9eb6bd2436", &function_d961aafc, "shot 1");
}

/*
	Name: function_d961aafc
	Namespace: namespace_a8113e97
	Checksum: 0xFA8A6909
	Offset: 0x27B0
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_d961aafc(a_ents)
{
	var_579805b6 = a_ents[getfirstarraykey(a_ents)];
	var_579805b6 thread function_70d8a7cb();
	level thread function_71d1b235();
	level thread function_fde77b55();
}

/*
	Name: function_70d8a7cb
	Namespace: namespace_a8113e97
	Checksum: 0x581E97BF
	Offset: 0x2838
	Size: 0x1BA
	Parameters: 0
	Flags: Linked
*/
function function_70d8a7cb()
{
	level endon(#"ley_start");
	self val::set("ley_source", "takedamage", 1);
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"damage");
		a_players = util::get_active_players();
		if(isdefined(var_88706ea7.attacker) && isplayer(var_88706ea7.attacker) && var_88706ea7.attacker zm_utility::function_aa45670f(var_88706ea7.weapon, 0))
		{
			for(i = 0; i < a_players.size; i++)
			{
				if(a_players[i] === var_88706ea7.attacker)
				{
					self playsound(#"hash_7651f08f562fc850");
					self clientfield::increment("" + #"hash_546e7612359187c3", 1);
					level flag::set("symbol_hit_player_" + i + 1);
				}
			}
		}
	}
}

/*
	Name: function_fde77b55
	Namespace: namespace_a8113e97
	Checksum: 0xE4BA85E
	Offset: 0x2A00
	Size: 0x26A
	Parameters: 1
	Flags: Linked
*/
function function_fde77b55(var_579805b6)
{
	level notify(#"hash_5c754451cae73035");
	level endon(#"ley_start", #"hash_5c754451cae73035");
	while(true)
	{
		level flag::wait_till_any(array(#"hash_546b8f78e6510d81", #"hash_546b8c78e6510868", #"hash_546b8d78e6510a1b", #"hash_546b9278e651129a"));
		var_af1bea51 = [];
		for(i = 1; i < getplayers().size + 1; i++)
		{
			var_af1bea51[var_af1bea51.size] = "symbol_hit_player_" + i;
		}
		wait(getplayers().size * 0.35);
		if(level flag::get_all(var_af1bea51))
		{
			level scene::play(#"hash_317afc9eb6bd2436", "shot 2");
			var_2782a2fe = getent("beam_man", "targetname");
			var_2782a2fe playsound(#"hash_4a842fe16ea6db6a");
			var_2782a2fe clientfield::set("" + #"hash_42b6c982eeb59c79", 1);
			level flag::set(#"ley_start");
		}
		else
		{
			for(i = 1; i < getplayers().size + 1; i++)
			{
				level flag::clear("symbol_hit_player_" + i);
			}
		}
	}
}

/*
	Name: function_d3128b5f
	Namespace: namespace_a8113e97
	Checksum: 0x4C60F120
	Offset: 0x2C78
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function function_d3128b5f()
{
	level flag::wait_till(#"ley_start");
	level.var_3128fb28 clientfield::set("" + #"hash_34c5ab29531f15f0", 0);
	var_95807f2d = [];
	var_72243c52 = struct::get_array(#"hash_fd673acb65a1865", "script_string");
	foreach(var_a352f5ee in var_72243c52)
	{
		trigger = spawn("trigger_box_use", var_a352f5ee.origin, 0, 64, 64, 64);
		trigger setcursorhint("HINT_NOICON");
		trigger triggerignoreteam();
		function_dae4ab9b(trigger, 0.1);
		trigger.str_pos = var_a352f5ee.script_noteworthy;
		trigger thread function_57692917(var_a352f5ee);
		if(!isdefined(var_95807f2d))
		{
			var_95807f2d = [];
		}
		else if(!isarray(var_95807f2d))
		{
			var_95807f2d = array(var_95807f2d);
		}
		var_95807f2d[var_95807f2d.size] = trigger;
	}
	/#
		var_310c1492 = struct::get("");
		var_556dff4b = spawn("", var_310c1492.origin, 0, 64, 128);
		var_556dff4b setcursorhint("");
		var_556dff4b triggerignoreteam();
		var_556dff4b.str_pos = var_310c1492.script_noteworthy;
		var_556dff4b thread function_57692917();
	#/
	level waittill(#"hash_4e13220b07971761");
	array::run_all(var_95807f2d, &delete);
	/#
		var_556dff4b delete();
	#/
}

/*
	Name: function_2038666b
	Namespace: namespace_a8113e97
	Checksum: 0xEEDE6759
	Offset: 0x2FA0
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function function_2038666b()
{
	if(!zm_utility::function_e51dc2d8())
	{
		return;
	}
	var_7e35b184 = array(5, 6, 7);
	var_77f6daf9 = array::random(var_7e35b184);
	arrayremovevalue(var_7e35b184, var_77f6daf9);
	for(i = 0; i < var_77f6daf9; i++)
	{
		function_c430a297("inner");
		waitframe(1);
	}
	var_3ce098fa = array::random(var_7e35b184);
	arrayremovevalue(var_7e35b184, var_3ce098fa);
	for(i = 0; i < var_3ce098fa; i++)
	{
		function_c430a297("middle");
		waitframe(1);
	}
	var_871b88b7 = array::random(var_7e35b184);
	arrayremovevalue(var_7e35b184, var_871b88b7);
	for(i = 0; i < var_871b88b7; i++)
	{
		function_c430a297("outer");
		waitframe(1);
	}
}

/*
	Name: function_57692917
	Namespace: namespace_a8113e97
	Checksum: 0x930AEAA6
	Offset: 0x3140
	Size: 0x206
	Parameters: 1
	Flags: Linked
*/
function function_57692917(var_a352f5ee)
{
	level endon(#"hash_4e13220b07971761");
	if(isdefined(var_a352f5ee))
	{
		trigger = trigger::wait_till(var_a352f5ee.target, "targetname", undefined, 0);
		if(isdefined(trigger))
		{
			trigger delete();
		}
		level scene::play(var_a352f5ee.script_noteworthy + "_control", "open");
	}
	waitresult = undefined;
	player = undefined;
	while(true)
	{
		if(!isdefined(waitresult) || (isalive(player) && (!player usebuttonpressed() || !player istouching(self))))
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger");
			player = waitresult.activator;
		}
		if(level.var_1613cea0 || !zm_utility::can_use(player))
		{
			waitframe(1);
			continue;
		}
		level.var_1613cea0 = 1;
		if(self.str_pos === "reset")
		{
			function_eeb45780();
		}
		else
		{
			player function_c430a297(self.str_pos, var_a352f5ee, 0);
		}
		level.var_1613cea0 = 0;
	}
}

/*
	Name: function_eeb45780
	Namespace: namespace_a8113e97
	Checksum: 0xF027C70A
	Offset: 0x3350
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function function_eeb45780()
{
	level.var_6ce9da5c.e_linkto rotateto(level.var_6ce9da5c.e_linkto.var_5287d229, 2);
	level.var_7ff4f03a.e_linkto rotateto(level.var_7ff4f03a.e_linkto.var_5287d229, 2);
	level.var_dd0ec1fe.e_linkto rotateto(level.var_dd0ec1fe.e_linkto.var_5287d229, 2);
	level.var_6ce9da5c playsound(#"hash_13acff42f13d9448");
	level.var_7ff4f03a playsound(#"hash_7813e29d18ad3dcf");
	level.var_dd0ec1fe playsound(#"hash_3b464e57c6aa7e35");
	level.var_dd0ec1fe.e_linkto waittill_timeout(2, #"rotatedone");
}

/*
	Name: function_c430a297
	Namespace: namespace_a8113e97
	Checksum: 0xBE66FDEF
	Offset: 0x34C8
	Size: 0x4B4
	Parameters: 3
	Flags: Linked
*/
function function_c430a297(str_pos, var_a352f5ee, b_starting = 1)
{
	if(b_starting)
	{
		n_move_time = 0.1;
	}
	else
	{
		n_move_time = 2;
		level scene::stop(var_a352f5ee.script_noteworthy + "_control", "targetname");
	}
	if(!isdefined(var_a352f5ee) || self function_39b9ecb(var_a352f5ee))
	{
		var_47d19ee = 30;
		var_6c4c2561 = -30;
		if(!b_starting)
		{
			level thread scene::play(var_a352f5ee.script_noteworthy + "_control", "wheel_right");
		}
	}
	else
	{
		var_47d19ee = -30;
		var_6c4c2561 = 30;
		if(!b_starting)
		{
			level thread scene::play(var_a352f5ee.script_noteworthy + "_control", "wheel_left");
		}
	}
	switch(str_pos)
	{
		case "outer":
		{
			level.var_6ce9da5c.e_linkto rotatepitch(var_6c4c2561, n_move_time);
			level.var_7ff4f03a.e_linkto rotateroll(var_47d19ee, n_move_time);
			level.var_dd0ec1fe.e_linkto rotatepitch(var_47d19ee, n_move_time);
			level.var_6ce9da5c playsound(#"hash_1928aff0a0342673");
			level.var_dd0ec1fe.e_linkto waittill_timeout(n_move_time, #"rotatedone");
			break;
		}
		case "middle":
		{
			level.var_dd0ec1fe.e_linkto rotatepitch(var_6c4c2561, n_move_time);
			level.var_7ff4f03a.e_linkto rotateroll(var_47d19ee, n_move_time);
			level.var_6ce9da5c playsound(#"hash_1928aef0a03424c0");
			level.var_7ff4f03a.e_linkto waittill_timeout(n_move_time, #"rotatedone");
			break;
		}
		case "inner":
		{
			level.var_7ff4f03a.e_linkto rotateroll(var_6c4c2561, n_move_time);
			level.var_6ce9da5c.e_linkto rotatepitch(var_47d19ee, n_move_time);
			level.var_6ce9da5c playsound(#"hash_1928aef0a03424c0");
			level.var_6ce9da5c.e_linkto waittill_timeout(n_move_time, #"rotatedone");
			break;
		}
	}
	if(b_starting)
	{
		level.var_6ce9da5c.e_linkto.var_5287d229 = level.var_6ce9da5c.e_linkto.angles;
		level.var_7ff4f03a.e_linkto.var_5287d229 = level.var_7ff4f03a.e_linkto.angles;
		level.var_dd0ec1fe.e_linkto.var_5287d229 = level.var_dd0ec1fe.e_linkto.angles;
	}
	waitframe(1);
	if(level flag::get(#"power_on1") || level flag::get(#"hash_2daf5bdda85cc660"))
	{
		level thread function_29c221f6(self);
	}
}

/*
	Name: function_29c221f6
	Namespace: namespace_a8113e97
	Checksum: 0x1849B927
	Offset: 0x3988
	Size: 0x324
	Parameters: 1
	Flags: Linked
*/
function function_29c221f6(player)
{
	var_4a92152c = distancesquared(level.var_ddfdc3b6.v_start, level.var_ddfdc3b6.origin);
	var_b2a31570 = distancesquared(level.var_6a6d4760.v_start, level.var_6a6d4760.origin);
	var_a0357e49 = distancesquared(level.var_bfd6fc7e.v_start, level.var_bfd6fc7e.origin);
	if(var_4a92152c <= 5 * 5)
	{
		level.var_92ee6d8f clientfield::set("" + #"hash_663a4a99828c832b", 2);
	}
	else
	{
		level.var_92ee6d8f clientfield::set("" + #"hash_663a4a99828c832b", 1);
	}
	if(var_b2a31570 <= 5 * 5)
	{
		level.var_ca5d3cc2 clientfield::set("" + #"hash_709c03abf1a2e08b", 2);
	}
	else
	{
		level.var_ca5d3cc2 clientfield::set("" + #"hash_709c03abf1a2e08b", 1);
	}
	if(var_a0357e49 <= 5 * 5)
	{
		level.var_a5e8b59c clientfield::set("" + #"hash_61d9ba9310d827ea", 2);
	}
	else
	{
		level.var_a5e8b59c clientfield::set("" + #"hash_61d9ba9310d827ea", 1);
	}
	if(var_4a92152c <= 5 * 5 && var_b2a31570 <= 5 * 5 && var_a0357e49 <= 5 * 5)
	{
		level flag::set(#"hash_4e13220b07971761");
		wait(0.5);
		if(isalive(player))
		{
			player zm_audio::create_and_play_dialog(#"hash_453010b01962824f", #"aligned");
		}
	}
}

/*
	Name: function_71d1b235
	Namespace: namespace_a8113e97
	Checksum: 0x5F34E52D
	Offset: 0x3CB8
	Size: 0x42C
	Parameters: 0
	Flags: Linked
*/
function function_71d1b235()
{
	level flag::wait_till(#"hash_4e13220b07971761");
	playrumbleonposition("zm_mansion_atlas_globe_set_rumble", level.var_dd0ec1fe.origin);
	level.var_bfd6fc7e playsound(#"hash_2647ce5bb2e14502");
	wait(2);
	var_2754aada = struct::get("s_atl");
	var_2754aada thread scene::play("melt");
	var_85effabc = getent("head_collision", "targetname");
	var_85effabc movey(32, 3);
	level.var_3128fb28 clientfield::set("" + #"hash_34c5ab29531f15f0", 1);
	level waittill(#"hash_3fd22d0e2a401a7a");
	level.var_f67d1d7e showpart("link_ring1_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
	level.var_f67d1d7e showpart("link_ring2_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
	level.var_f67d1d7e showpart("link_ring3_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
	function_f856cc2();
	var_1ed057a1 = getent("beam_obs", "targetname");
	var_1ed057a1 clientfield::set("" + #"hash_42b6c982eeb59c79", 2);
	wait(4);
	var_85effabc disconnectpaths();
	var_9283def2 = array("zone_main_hall", "zone_main_hall_north", "zone_start_east", "zone_start_west", "zone_grand_staircase");
	a_players = [];
	foreach(player in util::get_active_players())
	{
		if(player zm_zonemgr::is_player_in_zone(var_9283def2))
		{
			if(!isdefined(a_players))
			{
				a_players = [];
			}
			else if(!isarray(a_players))
			{
				a_players = array(a_players);
			}
			a_players[a_players.size] = player;
		}
	}
	if(a_players.size)
	{
		array::random(a_players) zm_audio::create_and_play_dialog(#"hash_74a1ff99c50036ab", #"collapse");
	}
	wait(2);
	level scene::stop(#"hash_59292dcf3b5d3850");
	level scene::play(#"hash_59292dcf3b5d3850", "close");
}

/*
	Name: function_ea49787e
	Namespace: namespace_a8113e97
	Checksum: 0x9E5467AE
	Offset: 0x40F0
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_ea49787e(a_ents)
{
	level.var_3128fb28 = a_ents[#"crystal"];
	level.var_4b916bb9 = a_ents[#"hash_90c8c80c57b984c"];
	level.var_f67d1d7e = a_ents[#"hash_5a08861e29928be4"];
	util::wait_network_frame(5);
	level.var_3128fb28 clientfield::set("" + #"hash_34c5ab29531f15f0", 1);
	level.var_f67d1d7e hidepart("link_ring1_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
	level.var_f67d1d7e hidepart("link_ring2_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
	level.var_f67d1d7e hidepart("link_ring3_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
}

/*
	Name: function_f856cc2
	Namespace: namespace_a8113e97
	Checksum: 0xB0AF5FAA
	Offset: 0x4248
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_f856cc2()
{
	level.var_dd0ec1fe.e_linkto delete();
	level.var_dd0ec1fe.e_pos delete();
	level.var_dd0ec1fe delete();
	level.var_7ff4f03a.e_linkto delete();
	level.var_7ff4f03a.e_pos delete();
	level.var_7ff4f03a delete();
	level.var_6ce9da5c.e_linkto delete();
	level.var_6ce9da5c.e_pos delete();
	level.var_6ce9da5c delete();
	level.var_a5e8b59c delete();
	level.var_92ee6d8f delete();
	level.var_ca5d3cc2 delete();
}

/*
	Name: function_604f9d73
	Namespace: namespace_a8113e97
	Checksum: 0x260D649A
	Offset: 0x43A8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_604f9d73(a_ents)
{
	level.var_fbeb7c7f = a_ents[getfirstarraykey(a_ents)];
	scene::remove_scene_func(#"hash_66b780d6495a613c", &function_604f9d73, "init");
}

/*
	Name: function_b1b02a54
	Namespace: namespace_a8113e97
	Checksum: 0xF68BDDCE
	Offset: 0x4420
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_b1b02a54()
{
	var_83e2b81d = struct::get_script_bundle_instances("scene", #"hash_3225470f7ea39ab3");
	a_scene_ents = var_83e2b81d[getfirstarraykey(var_83e2b81d)].scene_ents;
	var_da3daf09 = a_scene_ents[getfirstarraykey(a_scene_ents)];
	var_da3daf09 stopanimscripted();
	var_da3daf09 moveto(var_da3daf09.origin, 0.1);
	return var_da3daf09;
}

/*
	Name: function_d3f6a790
	Namespace: namespace_a8113e97
	Checksum: 0x898BC4AA
	Offset: 0x44F0
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_d3f6a790()
{
	var_da3daf09 = function_b1b02a54();
	var_47323b73 = var_da3daf09 zm_unitrigger::create();
	var_47323b73.var_da3daf09 = var_da3daf09;
	var_47323b73.mdl_door_right = getent("mdl_telescope_observatory_door_right", "targetname");
	var_47323b73.mdl_door_left = getent("mdl_telescope_observatory_door_left", "targetname");
	var_47323b73 thread function_250cf19b();
	level flag::wait_till(#"hash_76ea4b1b1c7ac757");
	zm_unitrigger::unregister_unitrigger(var_47323b73);
}

/*
	Name: function_250cf19b
	Namespace: namespace_a8113e97
	Checksum: 0x85E9E966
	Offset: 0x45E8
	Size: 0x788
	Parameters: 0
	Flags: Linked
*/
function function_250cf19b()
{
	level endon(#"hash_10693cfc20e83df1", #"hash_76ea4b1b1c7ac757");
	level scene::stop(#"hash_76720505cdbd413f");
	level thread scene::play(#"hash_76720505cdbd413f", "reset");
	level flag::wait_till(#"hash_702dbaf6695a5607");
	waitframe(1);
	level scene::stop(#"hash_76720505cdbd413f");
	level thread scene::play(#"hash_76720505cdbd413f", "part_open");
	self.mdl_door_right unlink();
	self.mdl_door_left unlink();
	if(!isdefined(level.var_96362a1a))
	{
		level.var_96362a1a = 0;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self.var_da3daf09 waittill(#"trigger_activated");
		player = waitresult.e_who;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		while(isalive(player) && player usebuttonpressed() && isdefined(self.trigger) && player istouching(self.trigger))
		{
			if(level.var_96362a1a < 16)
			{
				self.var_da3daf09 rotateroll(-90, 0.25);
				self.var_da3daf09 playloopsound(#"hash_70057df239d8bb23");
				var_5a2e8e4f = anglestoright(self.mdl_door_right.angles);
				var_58aebac7 = anglestoright(self.mdl_door_left.angles);
				var_a40d6e4f = self.mdl_door_right.origin + var_5a2e8e4f * 4;
				var_5f19fbd3 = self.mdl_door_left.origin - var_58aebac7 * 4;
				self.mdl_door_right moveto(var_a40d6e4f, 0.25);
				self.mdl_door_left moveto(var_5f19fbd3, 0.25);
				self.mdl_door_right playloopsound(#"hash_1734ee34b49eddb4");
				level.var_96362a1a++;
				if(level.var_96362a1a >= 16)
				{
					self.mdl_door_right playsound(#"hash_7134188ed9012ffe");
					self.mdl_door_right stoploopsound();
					self.var_da3daf09 stoploopsound();
				}
				array::wait_till(array(self.mdl_door_right, self.mdl_door_left), "movedone");
			}
			else
			{
				wait(0.25);
			}
		}
		self.mdl_door_right stoploopsound();
		self.var_da3daf09 stoploopsound();
		if(getplayers().size == 1)
		{
			wait(1);
		}
		if(!level flag::get(#"hash_76ea4b1b1c7ac757"))
		{
			level scene::stop(#"hash_76720505cdbd413f");
			level thread scene::play(#"hash_76720505cdbd413f", "reset");
			if(level.var_96362a1a < 5)
			{
				var_c5af0345 = 5 - level.var_96362a1a;
			}
			while(level.var_96362a1a)
			{
				self.var_da3daf09 rotateroll(90, 0.25);
				self.var_da3daf09 playloopsound(#"hash_70057df239d8bb23");
				var_5a2e8e4f = anglestoright(self.mdl_door_right.angles);
				var_58aebac7 = anglestoright(self.mdl_door_left.angles);
				var_a40d6e4f = self.mdl_door_right.origin - var_5a2e8e4f * 4;
				var_5f19fbd3 = self.mdl_door_left.origin + var_58aebac7 * 4;
				self.mdl_door_right moveto(var_a40d6e4f, 0.25);
				self.mdl_door_left moveto(var_5f19fbd3, 0.25);
				self.mdl_door_right playloopsound(#"hash_644ccbe0bd198b6");
				level.var_96362a1a--;
				array::wait_till(array(self.mdl_door_right, self.mdl_door_left), "movedone");
			}
			if(isdefined(var_c5af0345))
			{
				wait(0.25 * var_c5af0345);
				var_c5af0345 = undefined;
			}
			level scene::stop(#"hash_76720505cdbd413f");
			level thread scene::play(#"hash_76720505cdbd413f", "part_open");
			self.mdl_door_right stoploopsound();
			self.var_da3daf09 stoploopsound();
			self.mdl_door_right playsound(#"hash_5bb03dee040764f4");
		}
	}
}

/*
	Name: function_5164d716
	Namespace: namespace_a8113e97
	Checksum: 0x2B32EB
	Offset: 0x4D78
	Size: 0x288
	Parameters: 0
	Flags: Linked
*/
function function_5164d716()
{
	level endon(#"hash_76ea4b1b1c7ac757", #"hash_10693cfc20e83df1");
	level flag::wait_till(#"hash_702dbaf6695a5607");
	var_e0cc1e20 = getent("trigger_obs_wheel_lock", "targetname");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = var_e0cc1e20 waittill(#"damage");
		var_e0cc1e20.health = var_e0cc1e20.health + var_385703b7.amount;
		if(isdefined(var_385703b7.attacker) && isplayer(var_385703b7.attacker) && namespace_c05f06c7::function_9b4de361(var_385703b7.weapon) && var_385703b7.mod === "MOD_MELEE" && isdefined(level.var_96362a1a) && level.var_96362a1a > 15)
		{
			var_da3daf09 = function_b1b02a54();
			var_da3daf09 scene::play(#"hash_3225470f7ea39ab3", var_da3daf09);
			mdl_door_right = getent("mdl_telescope_observatory_door_right", "targetname");
			var_da3daf09 stoploopsound();
			mdl_door_right stoploopsound();
			var_e0cc1e20 delete();
			level scene::stop(#"hash_76720505cdbd413f");
			level thread scene::play(#"hash_76720505cdbd413f", "open");
			level flag::set(#"hash_76ea4b1b1c7ac757");
		}
	}
}

/*
	Name: function_e188ae5d
	Namespace: namespace_a8113e97
	Checksum: 0x23ACB2FE
	Offset: 0x5008
	Size: 0x248
	Parameters: 0
	Flags: Linked
*/
function function_e188ae5d()
{
	mdl_base = getent("mdl_tel_base", "targetname");
	var_da3daf09 = getent("mdl_tel_wheel", "targetname");
	foreach(var_6142bc53 in level.var_21d0f5ee)
	{
		var_da3daf09 hidepart("tag_wheel_" + var_6142bc53);
		mdl_base hidepart(var_6142bc53 + "_01");
		mdl_base hidepart(var_6142bc53 + "_02");
		mdl_base hidepart(var_6142bc53 + "_03");
	}
	level flag::wait_till(#"hash_4e13220b07971761");
	foreach(var_6142bc53 in level.var_21d0f5ee)
	{
		var_da3daf09 showpart("tag_wheel_" + var_6142bc53);
		mdl_base hidepart(var_6142bc53 + "_01");
		mdl_base hidepart(var_6142bc53 + "_02");
		mdl_base hidepart(var_6142bc53 + "_03");
	}
}

/*
	Name: function_3f64b455
	Namespace: namespace_a8113e97
	Checksum: 0x5B7E8C9F
	Offset: 0x5258
	Size: 0x388
	Parameters: 0
	Flags: Linked
*/
function function_3f64b455()
{
	level endon(#"hash_426c0f5a9e34edc2");
	var_da3daf09 = getent("mdl_tel_wheel", "targetname");
	n_shot = 0;
	level.var_21d0f5ee = array("aquarius", "pisces", "aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn");
	level thread function_e188ae5d();
	var_da3daf09.s_unitrigger = var_da3daf09 zm_unitrigger::create(undefined, 48, &function_5e54642e);
	zm_unitrigger::function_89380dda(var_da3daf09.s_unitrigger);
	level.var_779d8f63 = 1;
	while(true)
	{
		if(!isdefined(var_88706ea7) || (isalive(var_88706ea7.e_who) && (!var_88706ea7.e_who usebuttonpressed() || (isdefined(var_da3daf09.s_unitrigger.trigger) && !var_88706ea7.e_who istouching(var_da3daf09.s_unitrigger.trigger)))))
		{
			var_88706ea7 = undefined;
			var_88706ea7 = var_da3daf09 waittill(#"trigger_activated");
		}
		if(isplayer(var_88706ea7.e_who))
		{
			if(var_88706ea7.e_who function_39b9ecb(var_da3daf09.s_unitrigger))
			{
				level.var_779d8f63--;
				if(level.var_779d8f63 < 1)
				{
					level.var_779d8f63 = 12;
				}
			}
			else
			{
				level.var_779d8f63++;
				if(level.var_779d8f63 > 12)
				{
					level.var_779d8f63 = 1;
				}
			}
			s_rotate = struct::get(level.var_21d0f5ee[level.var_779d8f63 - 1]);
			var_da3daf09 rotateto(s_rotate.angles, 0.35);
			var_da3daf09 playsound(#"hash_bbeb6a0420a769e");
			if(n_shot < 9)
			{
				n_shot++;
			}
			else
			{
				n_shot = 1;
			}
			scene::play(#"hash_46daceec4c4a102f", "shot " + n_shot);
		}
	}
}

/*
	Name: function_39b9ecb
	Namespace: namespace_a8113e97
	Checksum: 0x9C7836EF
	Offset: 0x55E8
	Size: 0x126
	Parameters: 1
	Flags: Linked
*/
function function_39b9ecb(s_unitrigger)
{
	v_delta = vectornormalize(s_unitrigger.origin - self geteye());
	v_view = anglestoforward(self getplayerangles());
	v_cross = vectorcross(v_view, v_delta);
	var_35b81369 = vectordot(v_cross, anglestoup(s_unitrigger.angles));
	var_7c6b02a8 = vectordot(v_cross, (0, 0, 1));
	if(var_35b81369 >= 0 && var_7c6b02a8 >= 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_5e54642e
	Namespace: namespace_a8113e97
	Checksum: 0xB389514
	Offset: 0x5718
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_5e54642e()
{
	self endon(#"death");
	function_dae4ab9b(self, 0.1);
	self zm_unitrigger::function_69168e61();
}

/*
	Name: function_9513d3a6
	Namespace: namespace_a8113e97
	Checksum: 0x86999A2E
	Offset: 0x5770
	Size: 0x45C
	Parameters: 0
	Flags: Linked
*/
function function_9513d3a6()
{
	level flag::wait_till(#"hash_4e13220b07971761");
	a_s_locs = struct::get_array("symbol_combo_loc");
	struct::get("s_zodiac_symbol_spawn");
	var_3ab52107 = [];
	for(i = 1; i <= 12; i++)
	{
		if(!isdefined(var_3ab52107))
		{
			var_3ab52107 = [];
		}
		else if(!isarray(var_3ab52107))
		{
			var_3ab52107 = array(var_3ab52107);
		}
		var_3ab52107[var_3ab52107.size] = i;
	}
	if(isdefined(level.var_d181080c))
	{
		foreach(var_9e7c3935 in level.var_d181080c)
		{
			if(isdefined(var_9e7c3935.var_c6f538f0))
			{
				array::run_all(var_9e7c3935.var_c6f538f0, &delete);
			}
			var_9e7c3935 delete();
		}
	}
	level.var_d181080c = [];
	level.var_5c086e54 = [];
	for(i = 0; i < 3; i++)
	{
		var_fb1b957b = array::random(var_3ab52107);
		arrayremovevalue(var_3ab52107, var_fb1b957b);
		switch(var_fb1b957b)
		{
			case 1:
			{
				str_model = "p8_zm_man_zodiac_sign_aquarius";
				break;
			}
			case 2:
			{
				str_model = "p8_zm_man_zodiac_sign_pisces";
				break;
			}
			case 3:
			{
				str_model = "p8_zm_man_zodiac_sign_aries";
				break;
			}
			case 4:
			{
				str_model = "p8_zm_man_zodiac_sign_taurus";
				break;
			}
			case 5:
			{
				str_model = "p8_zm_man_zodiac_sign_gemini";
				break;
			}
			case 6:
			{
				str_model = "p8_zm_man_zodiac_sign_cancer";
				break;
			}
			case 7:
			{
				str_model = "p8_zm_man_zodiac_sign_leo";
				break;
			}
			case 8:
			{
				str_model = "p8_zm_man_zodiac_sign_virgo";
				break;
			}
			case 9:
			{
				str_model = "p8_zm_man_zodiac_sign_libra";
				break;
			}
			case 10:
			{
				str_model = "p8_zm_man_zodiac_sign_scorpio";
				break;
			}
			case 11:
			{
				str_model = "p8_zm_man_zodiac_sign_sagittarius";
				break;
			}
			case 12:
			{
				str_model = "p8_zm_man_zodiac_sign_capricorn";
				break;
			}
		}
		var_9e7c3935 = util::spawn_model(str_model, vectorscale((0, 0, -1), 400));
		var_9e7c3935.script_int = var_fb1b957b;
		var_9e7c3935.s_loc = array::random(a_s_locs);
		arrayremovevalue(a_s_locs, var_9e7c3935.s_loc);
		level.var_d181080c[level.var_d181080c.size] = var_9e7c3935;
	}
	level thread function_8ced5d5b();
}

/*
	Name: function_8ced5d5b
	Namespace: namespace_a8113e97
	Checksum: 0xAB4BEF59
	Offset: 0x5BD8
	Size: 0x1A6
	Parameters: 0
	Flags: Linked
*/
function function_8ced5d5b()
{
	a_n_numbers = array(7, 9, 11, 13, 15);
	var_679750f5 = [];
	for(i = 0; i < 3; i++)
	{
		n_num = array::random(a_n_numbers);
		var_679750f5[var_679750f5.size] = n_num;
		arrayremovevalue(a_n_numbers, n_num);
	}
	var_db303d4f = array::sort_by_value(var_679750f5, 1);
	for(i = 0; i < 3; i++)
	{
		level.var_d181080c[i].origin = level.var_d181080c[i].s_loc.origin;
		level.var_d181080c[i].angles = level.var_d181080c[i].s_loc.angles;
		level.var_d181080c[i].n_hints = var_db303d4f[i];
		level.var_d181080c[i] thread function_7cc34fef();
	}
}

/*
	Name: function_7cc34fef
	Namespace: namespace_a8113e97
	Checksum: 0x9B4193D
	Offset: 0x5D88
	Size: 0x5D2
	Parameters: 0
	Flags: Linked
*/
function function_7cc34fef()
{
	self.var_c6f538f0 = [];
	self.a_s_locs = struct::get_array(self.s_loc.script_noteworthy);
	self.a_s_locs = array::randomize(self.a_s_locs);
	switch(self.n_hints)
	{
		case 7:
		{
			self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
			self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_04_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
			break;
		}
		case 9:
		{
			if(math::cointoss())
			{
				self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_04_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
				self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
			}
			else
			{
				self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
				self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
				self.var_c6f538f0[2] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[2].origin, self.a_s_locs[2].angles);
			}
			break;
		}
		case 11:
		{
			self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
			self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
			self.var_c6f538f0[2] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[2].origin, self.a_s_locs[2].angles);
			break;
		}
		case 13:
		{
			self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
			self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
			self.var_c6f538f0[2] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[2].origin, self.a_s_locs[2].angles);
			break;
		}
		case 15:
		{
			self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
			self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
			self.var_c6f538f0[2] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[2].origin, self.a_s_locs[2].angles);
			break;
		}
	}
}

/*
	Name: function_bfefc7aa
	Namespace: namespace_a8113e97
	Checksum: 0x299610A2
	Offset: 0x6368
	Size: 0x310
	Parameters: 0
	Flags: Linked
*/
function function_bfefc7aa()
{
	level endon(#"hash_426c0f5a9e34edc2");
	self notify(#"combo_reset");
	self endon(#"combo_reset");
	var_da3daf09 = getent("mdl_tel_wheel", "targetname");
	mdl_base = getent("mdl_tel_base", "targetname");
	self.health = 99999;
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"damage");
		self.health = self.health + var_385703b7.amount;
		if(level flag::get(#"hash_3e3ae137d6c07f8d") || !isdefined(level.var_779d8f63) || !isdefined(level.var_21d0f5ee) || isinarray(level.var_5c086e54, level.var_779d8f63))
		{
			continue;
		}
		if(var_385703b7.mod !== #"mod_melee")
		{
			continue;
		}
		if(isplayer(var_385703b7.attacker))
		{
			level.var_5c086e54[level.var_5c086e54.size] = level.var_779d8f63;
			mdl_base showpart(level.var_21d0f5ee[level.var_779d8f63 - 1] + "_0" + level.var_5c086e54.size);
			var_da3daf09 hidepart("tag_wheel_" + level.var_21d0f5ee[level.var_779d8f63 - 1]);
			playsoundatposition(#"hash_7391894450e708c9", mdl_base gettagorigin(level.var_21d0f5ee[level.var_779d8f63 - 1] + "_0" + level.var_5c086e54.size));
			var_da3daf09 playsound(#"hash_8ea83abca0ca591");
			if(level.var_5c086e54.size > 2)
			{
				level.var_ee0a344c = var_385703b7.attacker;
				level flag::set(#"hash_3e3ae137d6c07f8d");
			}
		}
	}
}

/*
	Name: function_1c760913
	Namespace: namespace_a8113e97
	Checksum: 0x286F7F7E
	Offset: 0x6680
	Size: 0x628
	Parameters: 0
	Flags: Linked
*/
function function_1c760913()
{
	level endon(#"hash_426c0f5a9e34edc2");
	var_da3daf09 = getent("mdl_tel_wheel", "targetname");
	while(true)
	{
		level flag::wait_till(#"hash_3e3ae137d6c07f8d");
		for(i = 0; i < 3; i++)
		{
			wait(0.75);
			mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[0] - 1] + "_01");
			mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[1] - 1] + "_02");
			mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[2] - 1] + "_03");
			wait(0.5);
			playsoundatposition(#"hash_7391894450e708c9", mdl_base gettagorigin(level.var_21d0f5ee[level.var_5c086e54[1] - 1] + "_02"));
			mdl_base showpart(level.var_21d0f5ee[level.var_5c086e54[0] - 1] + "_01");
			mdl_base showpart(level.var_21d0f5ee[level.var_5c086e54[1] - 1] + "_02");
			mdl_base showpart(level.var_21d0f5ee[level.var_5c086e54[2] - 1] + "_03");
		}
		if(level.var_5c086e54[0] === level.var_d181080c[0].script_int && level.var_5c086e54[1] === level.var_d181080c[1].script_int && level.var_5c086e54[2] === level.var_d181080c[2].script_int)
		{
			if(isalive(level.var_ee0a344c))
			{
				level.var_ee0a344c zm_audio::create_and_play_dialog(#"hash_75a60d33a7026673", #"hash_7a3eeda80ea92423");
				level.var_ee0a344c = undefined;
			}
			var_da3daf09 playsound(#"hash_68988cab9fa84ad5");
			zm_unitrigger::unregister_unitrigger(var_da3daf09.s_unitrigger);
			level flag::set(#"hash_426c0f5a9e34edc2");
		}
		else
		{
			mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[0] - 1] + "_01");
			mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[1] - 1] + "_02");
			mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[2] - 1] + "_03");
			foreach(var_6142bc53 in level.var_21d0f5ee)
			{
				var_da3daf09 hidepart("tag_wheel_" + var_6142bc53);
			}
			var_da3daf09 playsound(#"hash_12c1d713dd5a5d68");
			level.var_ee0a344c = undefined;
			level.var_5c086e54 = undefined;
			wait(5);
			function_9513d3a6();
			foreach(var_6142bc53 in level.var_21d0f5ee)
			{
				var_da3daf09 showpart("tag_wheel_" + var_6142bc53);
			}
			level flag::clear(#"hash_3e3ae137d6c07f8d");
		}
	}
}

/*
	Name: function_d8162064
	Namespace: namespace_a8113e97
	Checksum: 0x3BEDF87
	Offset: 0x6CB0
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function function_d8162064()
{
	level endon(#"hash_10693cfc20e83df1");
	level flag::wait_till(#"hash_426c0f5a9e34edc2");
	mdl_door_right = getent("mdl_telescope_observatory_door_right", "targetname");
	mdl_door_left = getent("mdl_telescope_observatory_door_left", "targetname");
	mdl_door_right linkto(level.var_fbeb7c7f, "p8_zm_man_greenhouse_ext_dome_01_link_jnt");
	mdl_door_left linkto(level.var_fbeb7c7f, "p8_zm_man_greenhouse_ext_dome_01_link_jnt");
	array::run_all(util::get_active_players(), &clientfield::increment_to_player, "" + #"hash_73a4abf07bc65bc3", 1);
	level scene::play(#"hash_66b780d6495a613c");
	level flag::set(#"hash_702dbaf6695a5607");
}

/*
	Name: function_a99a5c4e
	Namespace: namespace_a8113e97
	Checksum: 0x2F955FBF
	Offset: 0x6E28
	Size: 0xE8
	Parameters: 1
	Flags: None
*/
function function_a99a5c4e(var_65500f70)
{
	var_e9b059c7 = [];
	foreach(var_70e1deb9 in var_65500f70)
	{
		if(var_70e1deb9.script_noteworthy == "zone_greenhouse_lab")
		{
			if(!isdefined(var_e9b059c7))
			{
				var_e9b059c7 = [];
			}
			else if(!isarray(var_e9b059c7))
			{
				var_e9b059c7 = array(var_e9b059c7);
			}
			var_e9b059c7[var_e9b059c7.size] = var_70e1deb9;
		}
	}
	return var_e9b059c7;
}

/*
	Name: function_986307c4
	Namespace: namespace_a8113e97
	Checksum: 0x219E5AE1
	Offset: 0x6F18
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_986307c4()
{
	level endon(#"hash_11429494f29d116d");
	level flag::wait_till(#"hash_426c0f5a9e34edc2");
	level clientfield::set("" + #"hash_557a1703971f074c", 1);
	var_7f147f52 = getent("t_eshield_check", "targetname");
	var_7f147f52.health = 999999;
	var_7f147f52 function_d5bfc8e8();
	level thread zm_utility::function_9ad5aeb1(1, 1, 0, 1, 0);
}

/*
	Name: function_d5bfc8e8
	Namespace: namespace_a8113e97
	Checksum: 0xA8C2C9A3
	Offset: 0x7010
	Size: 0x292
	Parameters: 0
	Flags: Linked
*/
function function_d5bfc8e8()
{
	level endon(#"hash_11429494f29d116d");
	self endon(#"death");
	self.var_ee6ce319 = [];
	var_1a50a8c5 = undefined;
	do
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"damage");
		self.health = self.health + var_88706ea7.amount;
		e_player = var_88706ea7.inflictor;
		var_989dd232 = 0;
		if(isplayer(e_player))
		{
			var_989dd232 = isdefined(e_player.var_4ceff143) && e_player.var_4ceff143 && var_88706ea7.mod === "MOD_MELEE" && namespace_c05f06c7::function_9b4de361(var_88706ea7.weapon);
		}
		if(var_989dd232)
		{
			e_player thread function_3d93d103();
			if(!isdefined(self.var_ee6ce319))
			{
				self.var_ee6ce319 = [];
			}
			else if(!isarray(self.var_ee6ce319))
			{
				self.var_ee6ce319 = array(self.var_ee6ce319);
			}
			if(!isinarray(self.var_ee6ce319, e_player))
			{
				self.var_ee6ce319[self.var_ee6ce319.size] = e_player;
			}
		}
		var_1a50a8c5 = 0;
		self.var_ee6ce319 = array::remove_undefined(self.var_ee6ce319);
		foreach(var_ef904cac in self.var_ee6ce319)
		{
			if(isdefined(var_ef904cac.var_12c0dec1) && var_ef904cac.var_12c0dec1)
			{
				var_1a50a8c5++;
			}
		}
	}
	while(var_1a50a8c5 < getplayers().size);
}

/*
	Name: function_3d93d103
	Namespace: namespace_a8113e97
	Checksum: 0xC08FC02A
	Offset: 0x72B0
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function function_3d93d103()
{
	self notify("2e914afcb974e9ec");
	self endon("2e914afcb974e9ec");
	self endon(#"disconnect");
	self.var_12c0dec1 = 1;
	self playsound(#"hash_613cef4818d77aca");
	wait(1.6);
	if(isplayer(self))
	{
		self.var_12c0dec1 = undefined;
	}
}

/*
	Name: function_b87ae607
	Namespace: namespace_a8113e97
	Checksum: 0x2DFDAF17
	Offset: 0x7348
	Size: 0x1CE
	Parameters: 1
	Flags: Linked
*/
function function_b87ae607(var_5839811b)
{
	while(true)
	{
		level flag::wait_till(#"hash_6f483dda6f8ab19d");
		while(level flag::get(#"hash_6f483dda6f8ab19d"))
		{
			foreach(player in util::get_active_players())
			{
				if(isdefined(player.var_c09a076a) && player.var_c09a076a && player istouching(e_trap) && (!(isdefined(player.var_c79d709f) && player.var_c79d709f)) && (!(isdefined(player.var_4ceff143) && player.var_4ceff143)))
				{
					player.var_4ceff143 = 1;
					player.var_c79d709f = 1;
					player notify(#"hash_4916b386e0478580");
					player thread function_371e56be(e_trap);
				}
			}
			waitframe(1);
		}
	}
}

/*
	Name: function_371e56be
	Namespace: namespace_a8113e97
	Checksum: 0x1BB0BF3D
	Offset: 0x7520
	Size: 0x1EA
	Parameters: 1
	Flags: Linked
*/
function function_371e56be(e_trap)
{
	self notify(#"hash_1e76041e9fa5f479");
	self endon(#"disconnect", #"hash_1e76041e9fa5f479", #"death");
	self clientfield::set("" + #"hash_5370f4bc9fc25d13", 1);
	while(level flag::get(#"hash_6f483dda6f8ab19d") && self istouching(e_trap) && namespace_c05f06c7::function_9b4de361(self getcurrentweapon()))
	{
		waitframe(1);
	}
	self.var_c79d709f = undefined;
	self thread function_53577dc7();
	if(!namespace_c05f06c7::function_9b4de361(self getcurrentweapon()))
	{
		self notify(#"hash_459246e5bfcc3713");
		self notify(#"hash_1e76041e9fa5f479");
	}
	while(isdefined(self.var_4ceff143) && self.var_4ceff143)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_4916b386e0478580", #"weapon_change");
		if(var_88706ea7._notify !== "weapon_change" || !namespace_c05f06c7::function_9b4de361(var_88706ea7.weapon))
		{
			self notify(#"hash_459246e5bfcc3713");
		}
	}
}

/*
	Name: function_53577dc7
	Namespace: namespace_a8113e97
	Checksum: 0x5360EDFD
	Offset: 0x7718
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_53577dc7()
{
	self endon(#"disconnect");
	self waittill_timeout(9.2, #"hash_4916b386e0478580", #"hash_459246e5bfcc3713", #"destroy_riotshield");
	self.var_4ceff143 = 0;
	self clientfield::set("" + #"hash_5370f4bc9fc25d13", 0);
	self notify(#"hash_4916b386e0478580");
}

/*
	Name: function_fda40d17
	Namespace: namespace_a8113e97
	Checksum: 0xD1982AF5
	Offset: 0x77C0
	Size: 0x306
	Parameters: 0
	Flags: Linked
*/
function function_fda40d17()
{
	level flag::wait_till(#"hash_702dbaf6695a5607");
	level.var_fbeb7c7f clientfield::set("" + #"hash_15af8e35c0c1f344", 2);
	level.var_fbeb7c7f playsound(#"hash_7602966ff564e065");
	level.var_fbeb7c7f playloopsound(#"hash_69b6d00136d35f2b");
	wait(5.3);
	level thread zm_utility::function_9ad5aeb1(0, 1, 0, 1, 0);
	foreach(player in getplayers())
	{
		player setlightingstate(1);
	}
	level util::delay(5, undefined, &clientfield::set, "" + #"hash_557a1703971f074c", 0);
	player = level.var_fbeb7c7f namespace_c05f06c7::get_closest_valid_player();
	if(isdefined(player))
	{
		player zm_audio::create_and_play_dialog(#"hash_65f40b8325b149b4", #"react_first");
	}
	getent("beam_man", "targetname") clientfield::set("" + #"hash_42b6c982eeb59c79", 0);
	getent("beam_obs", "targetname") clientfield::set("" + #"hash_42b6c982eeb59c79", 3);
	level.var_fbeb7c7f clientfield::set("" + #"hash_15af8e35c0c1f344", 0);
	level.var_fbeb7c7f stoploopsound();
	level.var_fbeb7c7f playsound(#"hash_79e81e464a483017");
	level.var_fbeb7c7f = undefined;
}

/*
	Name: function_f3668a9
	Namespace: namespace_a8113e97
	Checksum: 0xFE4586E9
	Offset: 0x7AD0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_f3668a9()
{
	level flag::wait_till(#"hash_b240a9137ecc6f9");
	wait(15);
	level flag::set(#"spawn_zombies");
	level flag::set(#"zombie_drop_powerups");
}

/*
	Name: function_c888f1f4
	Namespace: namespace_a8113e97
	Checksum: 0xAC2F0DD3
	Offset: 0x7B48
	Size: 0x2DC
	Parameters: 0
	Flags: Linked
*/
function function_c888f1f4()
{
	level endon(#"hash_10693cfc20e83df1");
	wait(8);
	exploder::exploder("exp_lgt_telescope_base_door");
	trigger = trigger::wait_till("scope_door_open", "targetname", undefined, 0);
	var_65c9997c = getent("stone_obs", "targetname");
	var_65c9997c show();
	var_65c9997c clientfield::set("" + #"hash_17b6a8253206a3cf", 1);
	if(isdefined(trigger))
	{
		trigger delete();
	}
	mdl_door = getent("mdl_telescope_base_door", "targetname");
	var_93048467 = struct::get(mdl_door.target);
	array::run_all(util::get_active_players(), &clientfield::increment_to_player, "" + #"hash_73a4abf07bc65bc3", 1);
	mdl_door moveto(var_93048467.origin, 3, 0.1, 1.5);
	mdl_door playsound(#"hash_34b16f03c4ce4b97");
	mdl_door waittill(#"movedone");
	mdl_door moveto(var_93048467.origin - vectorscale((0, 0, 1), 64), 3);
	mdl_door playsound(#"hash_34b17003c4ce4d4a");
	mdl_door waittill(#"movedone");
	var_47323b73 = var_65c9997c zm_unitrigger::create(undefined, 128);
	var_47323b73.v_start = var_65c9997c.angles;
	var_65c9997c thread function_31e641f5();
}

/*
	Name: function_31e641f5
	Namespace: namespace_a8113e97
	Checksum: 0x2A37BCF3
	Offset: 0x7E30
	Size: 0x4CC
	Parameters: 0
	Flags: Linked
*/
function function_31e641f5()
{
	level endon(#"hash_10693cfc20e83df1");
	while(true)
	{
		self waittill(#"trigger_activated");
		var_3ba1f680 = 1;
		n_time = 0;
		self thread namespace_c05f06c7::function_6a523c8c((1, 0, 0));
		self playsound(#"hash_54ef1510e22e8574");
		while(n_time < 3)
		{
			foreach(player in getplayers())
			{
				if(!player usebuttonpressed() || !zm_utility::can_use(player) || !isdefined(self.s_unitrigger) || !isdefined(self.s_unitrigger.trigger) || !player istouching(self.s_unitrigger.trigger))
				{
					var_3ba1f680 = 0;
					n_time = 0;
					break;
				}
			}
			if(var_3ba1f680 == 0)
			{
				self notify(#"stop_wobble");
				self.angles = self.s_unitrigger.v_start;
				self clientfield::set("" + #"hash_5eff598dc267e32a", 0);
				self playsound(#"hash_3640a466781bf551");
				break;
			}
			self clientfield::set("" + #"hash_5eff598dc267e32a", 1);
			wait(0.1);
			n_time = n_time + 0.1;
		}
		if(var_3ba1f680 == 1)
		{
			self playsound(#"hash_e1ac3a86a1144fc");
			break;
		}
		wait(0.1);
	}
	array::run_all(util::get_active_players(), &clientfield::increment_to_player, "" + #"hash_73a4abf07bc65bc3", 1);
	level flag::set(#"hash_1b9ecc7979b0fcfb");
	level clientfield::set("fasttravel_exploder", 0);
	exploder::exploder("fxexp_barrier_gameplay_observatory");
	level thread namespace_c05f06c7::function_f1c106b("loc4", 1);
	self clientfield::set("" + #"hash_141bb928b3d09e20", 1);
	self playloopsound(#"hash_5eb57257201f9043");
	self moveto(struct::get(self.target).origin, 1);
	self waittill(#"movedone");
	self clientfield::set("" + #"hash_60051e21f8eb4af", 1);
	self thread function_a8ddd91f();
	wait(1);
	self.var_4c4f2b6 = self.angles;
	self thread namespace_c05f06c7::function_da5cd631();
	level flag::set(#"hash_583d263e32521ee0");
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: function_a8ddd91f
	Namespace: namespace_a8113e97
	Checksum: 0xCCE27DEE
	Offset: 0x8308
	Size: 0x1AE
	Parameters: 0
	Flags: Linked
*/
function function_a8ddd91f()
{
	level endon(#"hash_10693cfc20e83df1");
	level flag::wait_till(#"hash_b240a9137ecc6f9");
	level thread zm_utility::function_9ad5aeb1(0, 1, 0, 1, 0);
	level.var_84b2907f = undefined;
	wait(2);
	var_65c9997c = getent("stone_obs", "targetname");
	var_65c9997c notify(#"hash_3946eb0fdd8a2c0e");
	var_65c9997c stoploopsound();
	var_65c9997c playsound(#"hash_3019afe90c2eb3aa");
	wait(0.5);
	var_65c9997c rotateto(var_65c9997c.var_4c4f2b6, 1);
	var_65c9997c waittill(#"rotatedone");
	var_65c9997c clientfield::set("" + #"hash_141bb928b3d09e20", 0);
	var_65c9997c bobbing((0, 1, 0), 1, 5);
	var_47323b73 = var_65c9997c zm_unitrigger::create(undefined, 96, &function_c9ebaa3);
}

/*
	Name: function_c9ebaa3
	Namespace: namespace_a8113e97
	Checksum: 0x5DBC8773
	Offset: 0x84C0
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function function_c9ebaa3()
{
	while(!level flag::get(#"hash_10693cfc20e83df1"))
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		player thread namespace_c05f06c7::function_f15c4657();
		level thread function_78a99a79();
		zm_unitrigger::unregister_unitrigger(self.stub);
	}
}

/*
	Name: function_78a99a79
	Namespace: namespace_a8113e97
	Checksum: 0x742DEBE0
	Offset: 0x8588
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_78a99a79()
{
	var_65c9997c = getent("stone_obs", "targetname");
	if(isdefined(var_65c9997c))
	{
		v_loc = var_65c9997c.origin + (15, 0, -40);
		var_65c9997c clientfield::increment("" + #"hash_4f11537440270a3", 1);
		var_65c9997c playsound(#"hash_397fa4e3bc7de2fb");
		var_65c9997c thread util::delayed_delete(1);
		zm_powerups::specific_powerup_drop(#"full_ammo", v_loc);
	}
	level flag::set(#"hash_10693cfc20e83df1");
}

/*
	Name: wave_1
	Namespace: namespace_a8113e97
	Checksum: 0x212E23ED
	Offset: 0x86A0
	Size: 0x36C
	Parameters: 0
	Flags: Linked
*/
function wave_1()
{
	level endon(#"hash_b240a9137ecc6f9");
	level flag::wait_till(#"hash_583d263e32521ee0");
	wait(2);
	n_players = getplayers().size;
	switch(n_players)
	{
		case 1:
		{
			n_num = 16;
			n_current = 9;
			break;
		}
		case 2:
		{
			n_num = 22;
			n_current = 13;
			break;
		}
		case 3:
		{
			n_num = 27;
			n_current = 17;
			break;
		}
		case 4:
		{
			n_num = 32;
			n_current = 20;
			break;
		}
	}
	level.var_e12e0420 = 0;
	level.var_84b2907f = &function_a9b81878;
	a_s_locs = array::randomize(struct::get_array("greenhouse_bat"));
	x = 0;
	level flag::set(#"hash_29b12646045186fa");
	for(i = 0; i < n_num; i++)
	{
		if(getaiteamarray(level.zombie_team).size >= 24)
		{
			level flag::set(#"hash_29b12646045186fa");
		}
		var_51fe0ded = bat::function_2e37549f(1, a_s_locs[x], 20);
		if(isdefined(var_51fe0ded))
		{
			level.var_e12e0420++;
			x++;
			var_51fe0ded.no_powerups = 1;
			var_51fe0ded zm_score::function_acaab828();
			var_51fe0ded callback::function_d8abfc3d(#"on_ai_killed", &function_3da8da85);
			if(x == a_s_locs.size)
			{
				x = 0;
			}
			while(level.var_e12e0420 >= n_current || getaiteamarray(level.zombie_team).size >= 24)
			{
				waitframe(1);
			}
		}
		level flag::clear(#"hash_29b12646045186fa");
		wait(randomfloatrange(0.2, 0.5));
	}
	level flag::clear(#"hash_29b12646045186fa");
	function_aa1d0bc6();
}

/*
	Name: function_a9b81878
	Namespace: namespace_a8113e97
	Checksum: 0x8F142617
	Offset: 0x8A18
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function function_a9b81878(ai)
{
	if(isalive(ai))
	{
		ai.no_powerups = 1;
		ai zm_score::function_acaab828();
		ai waittill(#"death");
		if(isdefined(level.var_e12e0420))
		{
			level.var_e12e0420--;
		}
	}
}

/*
	Name: function_3da8da85
	Namespace: namespace_a8113e97
	Checksum: 0x7F78431F
	Offset: 0x8AA0
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function function_3da8da85(params)
{
	level.var_e12e0420--;
}

/*
	Name: function_aa1d0bc6
	Namespace: namespace_a8113e97
	Checksum: 0xD5E33DD8
	Offset: 0x8AC0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_aa1d0bc6()
{
	if(isdefined(20 - getplayers().size))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(20 - getplayers().size, "timeout");
	}
	function_655a2fcc();
}

/*
	Name: function_655a2fcc
	Namespace: namespace_a8113e97
	Checksum: 0xC8811425
	Offset: 0x8B68
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_655a2fcc()
{
	while(true)
	{
		if(level.var_e12e0420 < 5)
		{
			return;
		}
		wait(0.25);
	}
}

/*
	Name: wave_2
	Namespace: namespace_a8113e97
	Checksum: 0x7EA4CCA5
	Offset: 0x8BA0
	Size: 0x2C4
	Parameters: 0
	Flags: None
*/
function wave_2()
{
	level endon(#"hash_b240a9137ecc6f9");
	wait(2);
	switch(getplayers().size)
	{
		case 1:
		{
			var_54e56d76 = 20;
			break;
		}
		case 2:
		{
			var_54e56d76 = 26;
			break;
		}
		case 3:
		{
			var_54e56d76 = 32;
			break;
		}
		case 4:
		{
			var_54e56d76 = 40;
			break;
		}
	}
	level.var_20f423f6 = 0;
	for(i = 0; i < var_54e56d76; i++)
	{
		var_69024a6a = namespace_9d27962b::function_988438a7(level.dog_spawners[0], undefined, 20);
		if(isdefined(var_69024a6a))
		{
			level.var_20f423f6++;
			var_69024a6a namespace_c402654::dog_init();
			var_69024a6a.var_126d7bef = 1;
			var_69024a6a.ignore_round_spawn_failsafe = 1;
			var_69024a6a.ignore_enemy_count = 1;
			var_69024a6a.b_ignore_cleanup = 1;
			var_69024a6a.no_powerups = 1;
			var_69024a6a.favoriteenemy = array::random(getplayers());
			s_spawn_loc = namespace_9d27962b::function_e1c262fb(var_69024a6a);
			var_69024a6a forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
			var_69024a6a thread namespace_9d27962b::function_c79d744e(s_spawn_loc);
			var_69024a6a callback::function_d8abfc3d(#"on_ai_killed", &function_831a12ae);
		}
		wait(0.25);
		while(level.var_20f423f6 > getplayers().size * 4)
		{
			wait(0.25);
		}
	}
	level flag::clear(#"hash_29b12646045186fa");
	function_cd9e9ab1();
}

/*
	Name: function_831a12ae
	Namespace: namespace_a8113e97
	Checksum: 0x9C31BF1
	Offset: 0x8E70
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function function_831a12ae(params)
{
	level.var_20f423f6--;
}

/*
	Name: function_cd9e9ab1
	Namespace: namespace_a8113e97
	Checksum: 0x44D455CD
	Offset: 0x8E90
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_cd9e9ab1()
{
	if(isdefined(30 - getplayers().size * 2))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(30 - getplayers().size * 2, "timeout");
	}
	function_a918c691();
}

/*
	Name: function_a918c691
	Namespace: namespace_a8113e97
	Checksum: 0xCD08F22E
	Offset: 0x8F48
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_a918c691()
{
	while(true)
	{
		if(level.var_20f423f6 < 3)
		{
			return;
		}
		wait(0.25);
	}
}

/*
	Name: wave_3
	Namespace: namespace_a8113e97
	Checksum: 0x9D8706B8
	Offset: 0x8F80
	Size: 0x3FC
	Parameters: 0
	Flags: Linked
*/
function wave_3()
{
	level endon(#"hash_b240a9137ecc6f9");
	wait(3.5);
	n_players = getplayers().size;
	switch(n_players)
	{
		case 1:
		{
			var_8a9f2734 = 4;
			var_61584de3 = 2;
			break;
		}
		case 2:
		{
			var_8a9f2734 = 7;
			var_61584de3 = 2;
			break;
		}
		case 3:
		{
			var_8a9f2734 = 9;
			var_61584de3 = 3;
			break;
		}
		case 4:
		{
			var_8a9f2734 = 10;
			var_61584de3 = 4;
			break;
		}
	}
	var_602ff9e4 = struct::get_array("greenhouse_lab_spawns");
	a_s_locs = [];
	foreach(var_843446c5 in var_602ff9e4)
	{
		if(var_843446c5.script_noteworthy === "werewolf_location")
		{
			a_s_locs[a_s_locs.size] = var_843446c5;
		}
	}
	level flag::set(#"hash_29b12646045186fa");
	level.var_4b9e58af = 0;
	for(i = 0; i < var_8a9f2734; i++)
	{
		while(level.var_4b9e58af >= var_61584de3)
		{
			waitframe(1);
		}
		if(getaiteamarray(level.zombie_team).size >= 20)
		{
			level flag::set(#"hash_29b12646045186fa");
		}
		s_loc = array::random(a_s_locs);
		var_69024a6a = namespace_977da60::function_47a88a0c(1, undefined, 1, s_loc, 20);
		if(isalive(var_69024a6a))
		{
			level.var_4b9e58af++;
			var_69024a6a.no_powerups = 1;
			var_69024a6a zm_score::function_acaab828();
			var_69024a6a.script_noteworthy = "angry_werewolf";
			var_69024a6a.var_126d7bef = 1;
			var_69024a6a.ignore_round_spawn_failsafe = 1;
			var_69024a6a.ignore_enemy_count = 1;
			var_69024a6a.b_ignore_cleanup = 1;
			var_69024a6a callback::function_d8abfc3d(#"on_ai_killed", &function_70e83f44);
			if(!(isdefined(level.var_456ece3d) && level.var_456ece3d))
			{
				level.var_456ece3d = 1;
				var_69024a6a thread function_d89f5961();
			}
			level flag::clear(#"hash_29b12646045186fa");
		}
		wait(6 - n_players / 2);
	}
	function_acf54a6a();
}

/*
	Name: function_d89f5961
	Namespace: namespace_a8113e97
	Checksum: 0x322456DF
	Offset: 0x9388
	Size: 0x304
	Parameters: 0
	Flags: Linked
*/
function function_d89f5961()
{
	level endon(#"end_game", #"intermission", #"hash_3bc655798befa0c6");
	self endon(#"death");
	a_e_players = util::get_active_players();
	a_e_players = array::randomize(a_e_players);
	foreach(e_player in a_e_players)
	{
		if(isalive(e_player))
		{
			e_player namespace_891c9bac::function_a2bd5a0c(#"hash_5da859125becfdfa", 0, 1);
			break;
		}
	}
	n_range_sq = 360000;
	var_51dd97e5 = undefined;
	do
	{
		a_e_players = util::get_active_players();
		foreach(e_player in a_e_players)
		{
			if(namespace_891c9bac::is_player_valid(e_player))
			{
				n_dist_sq = distancesquared(e_player.origin, self.origin);
				if(n_dist_sq <= n_range_sq && e_player zm_utility::is_facing(self, 0.75, 1))
				{
					var_51dd97e5 = e_player;
					break;
				}
			}
		}
		waitframe(1);
	}
	while(!namespace_891c9bac::is_player_valid(var_51dd97e5));
	var_3608d414 = [];
	var_3608d414[10] = "vox_werewolf_react_plr_10_0";
	var_3608d414[12] = "vox_werewolf_react_plr_12_4";
	var_3608d414[11] = "vox_werewolf_react_plr_11_2";
	var_3608d414[9] = "vox_werewolf_react_plr_9_0";
	var_e04d003f = var_51dd97e5 namespace_48f3568::function_d35e4c92();
	var_51dd97e5 namespace_891c9bac::function_8e0f4696(var_3608d414[var_e04d003f], 0, 1, 9999);
}

/*
	Name: function_70e83f44
	Namespace: namespace_a8113e97
	Checksum: 0xF519BA7C
	Offset: 0x9698
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function function_70e83f44(params)
{
	level.var_4b9e58af--;
}

/*
	Name: function_acf54a6a
	Namespace: namespace_a8113e97
	Checksum: 0x9E6C172C
	Offset: 0x96B8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_acf54a6a()
{
	while(true)
	{
		if(level.var_4b9e58af < 1)
		{
			level flag::set(#"hash_b240a9137ecc6f9");
			return;
		}
		wait(1);
	}
}

/*
	Name: function_1be5e603
	Namespace: namespace_a8113e97
	Checksum: 0x5B7DD93A
	Offset: 0x9710
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_1be5e603()
{
	level flag::wait_till(#"hash_10693cfc20e83df1");
	level flag::clear(#"hash_1b9ecc7979b0fcfb");
	level clientfield::set("fasttravel_exploder", 1);
	exploder::stop_exploder("fxexp_barrier_gameplay_observatory");
	level thread namespace_c05f06c7::function_f1c106b("loc4", 0);
	namespace_c05f06c7::function_5904a8e1();
}

/*
	Name: function_a7bed514
	Namespace: namespace_a8113e97
	Checksum: 0xD2E84CD6
	Offset: 0x97C8
	Size: 0xEA
	Parameters: 1
	Flags: Linked
*/
function function_a7bed514(str_script_noteworthy = "spawn_location")
{
	a_spawns = struct::get_array(str_script_noteworthy, "script_noteworthy");
	foreach(s_loc in a_spawns)
	{
		if(s_loc.targetname !== "greenhouse_lab_spawns")
		{
			arrayremovevalue(a_spawns, s_loc, 1);
		}
	}
	return array::remove_undefined(a_spawns);
}

