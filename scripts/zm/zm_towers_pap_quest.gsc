// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2affe92664ace48d;
#using script_3f9e0dc8454d98e1;
#using script_52c6c2d1a2ef1b46;
#using script_684097158a90b5c3;
#using script_6e3c826b1814cab6;
#using script_d8b1f4ee30e5fc5;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_towers_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_2ea65b04;

/*
	Name: init
	Namespace: namespace_2ea65b04
	Checksum: 0x966FDBE
	Offset: 0xA48
	Size: 0x32C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"fx_challenge_head_blood_burst"] = "maps/zm_towers/fx8_challenge_head_blood_burst";
	level._effect[#"fx_challenge_head_blood_drips"] = "maps/zm_towers/fx8_challenge_head_blood_drips";
	function_90a833e2();
	level thread function_5ad3e281();
	scene::add_scene_func("p8_fxanim_zm_towers_pap_sarcophagus_spikes_bundle", &function_64f2d6de, "init");
	level thread scene::init("p8_fxanim_zm_towers_pap_door_blue_bundle");
	level thread scene::init("p8_fxanim_zm_towers_pap_door_red_bundle");
	level thread scene::init("p8_fxanim_zm_towers_pap_sarcophagus_bundle");
	n_pap_enabled = namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2");
	if(n_pap_enabled == 2 || (isdefined(level.var_fe2bb2ac) && level.var_fe2bb2ac) || (isdefined(level.var_15747fb1) && level.var_15747fb1))
	{
		level thread function_a7faeaaf();
	}
	else if(n_pap_enabled == 0)
	{
		level flag::set(#"hash_2802a934b7e37913");
		mdl_sentinel_artifact = getent("mdl_pap_quest_sentinel_artifact", "targetname");
		mdl_sentinel_artifact hide();
		mdl_sentinel_artifact notsolid();
		function_a73ff9f2();
	}
	level thread function_ce84849b();
	a_mdl_pap_room_debris_clip = getentarray("mdl_pap_room_debris_clip", "targetname");
	foreach(mdl_pap_room_debris_clip in a_mdl_pap_room_debris_clip)
	{
		mdl_pap_room_debris_clip disconnectpaths();
	}
	var_f7afe1a0 = getent("sarcophagus_destroyed", "targetname");
	var_f7afe1a0 hide();
}

/*
	Name: function_5ad3e281
	Namespace: namespace_2ea65b04
	Checksum: 0x5FA8D57F
	Offset: 0xD80
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_5ad3e281()
{
	level flag::wait_till(#"hash_2a7d461c7eff8179");
	changeadvertisedstatus(0);
}

/*
	Name: function_a7faeaaf
	Namespace: namespace_2ea65b04
	Checksum: 0x95B334BD
	Offset: 0xDC8
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_a7faeaaf()
{
	level flag::wait_till("all_players_spawned");
	level flag::set(#"hash_3d833ecc64915d8d");
	level flag::set(#"hash_d38ff215be3a4fc");
	level flag::set(#"hash_4142472dec557d03");
	level flag::set(#"hash_45b6b1ee5d5038b4");
	level flag::set(#"hash_1eda3c39867cbe53");
	level flag::set(#"hash_1b7828aafd3f83f4");
	level flag::set(#"hash_15b79db61753c205");
	level flag::set(#"hash_34c1fdccaa5279bc");
	flag::wait_till_any(array("connect_ra_tunnel_to_body_pit", "connect_zeus_tunnel_to_flooded_crypt"));
	level flag::set(#"hash_2cf71ce4a3d1c081");
}

/*
	Name: function_90a833e2
	Namespace: namespace_2ea65b04
	Checksum: 0x6DDD4C6B
	Offset: 0xF48
	Size: 0x2E4
	Parameters: 0
	Flags: Linked
*/
function function_90a833e2()
{
	level flag::init(#"hash_2802a934b7e37913");
	level flag::init(#"hash_2a7d461c7eff8179");
	level flag::init(#"hash_798d51388d6e10f4");
	level flag::init(#"hash_18134dc5b9b39a96");
	level flag::init(#"hash_582eea77824b014d");
	level flag::init(#"hash_5cc500f9282cd290");
	level flag::init(#"hash_20c64c155f7a0065");
	level flag::init(#"hash_589679a12150767a");
	level flag::init(#"hash_4abb12b14a38d2e9");
	level flag::init(#"hash_15f5946d4968f144");
	level flag::init(#"hash_355567a6fa6d44d1");
	level flag::init(#"hash_76692d6669cb0500");
	level flag::init(#"hash_3d833ecc64915d8d");
	level flag::init(#"hash_d38ff215be3a4fc");
	level flag::init(#"hash_4142472dec557d03");
	level flag::init(#"hash_45b6b1ee5d5038b4");
	level flag::init(#"hash_1eda3c39867cbe53");
	level flag::init(#"hash_1b7828aafd3f83f4");
	level flag::init(#"hash_15b79db61753c205");
	level flag::init(#"hash_34c1fdccaa5279bc");
	level flag::init(#"hash_2cf71ce4a3d1c081");
	level flag::init("zm_towers_pap_quest_sentinel_artifact_exploded");
	level flag::init("zm_towers_pap_quest_completed");
}

/*
	Name: function_ce84849b
	Namespace: namespace_2ea65b04
	Checksum: 0x449A4469
	Offset: 0x1238
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_ce84849b()
{
	level endon(#"end_game");
	pap_quest_init(0);
	function_52411f5e(0);
}

/*
	Name: function_9b917fd5
	Namespace: namespace_2ea65b04
	Checksum: 0xE42A753C
	Offset: 0x1288
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_9b917fd5(is_powered)
{
	level flag::wait_till("all_players_spawned");
	self zm_pack_a_punch::set_state_hidden();
	if(zm_utility::is_standard())
	{
		level waittill(#"hash_7ca261f468171655");
	}
	level flag::wait_till("zm_towers_pap_quest_completed");
	if(!level flag::get(#"hash_2802a934b7e37913"))
	{
		self zm_pack_a_punch::function_bb629351(1, "arriving", "arrive_anim_done");
	}
}

/*
	Name: pap_quest_init
	Namespace: namespace_2ea65b04
	Checksum: 0x2D08525
	Offset: 0x1368
	Size: 0x45C
	Parameters: 1
	Flags: Linked
*/
function pap_quest_init(var_5ea5c94d)
{
	var_9840ab47 = getentarray("pap_quest_encounter_triggers", "script_noteworthy");
	if(function_8b1a219a())
	{
		array::run_all(var_9840ab47, &sethintstring, #"hash_7c465ea7da6991fb");
	}
	else
	{
		array::run_all(var_9840ab47, &sethintstring, #"hash_2a4860e40142bac5");
	}
	var_16561d51 = array(#"marauder", #"destroyer", #"both", #"tigers");
	var_5cf420b9 = array(#"danu", #"ra", #"odin", #"zeus");
	var_16561d51 = array::randomize(var_16561d51);
	level.var_4118581a = 0;
	foreach(i, var_5542e979 in var_5cf420b9)
	{
		level thread function_199b1814(var_5542e979, var_16561d51[i]);
	}
	level.var_c22016cf = 0;
	level.var_7695ff59 = 0;
	level.var_9847c460 = 0;
	level thread function_a2f4eb85();
	var_307566 = getentarray("mdl_pap_quest_head", "targetname");
	foreach(mdl_head in var_307566)
	{
		mdl_head flag::init(#"hash_26125a3306681e2");
		mdl_head hide();
	}
	level thread function_d7c092b9();
	level namespace_6747c550::function_7df6bb60(#"hash_4fce42c559430ff9", 1);
	level namespace_6747c550::function_7df6bb60(#"hash_6257a73f22800e57", 1);
	level namespace_6747c550::function_7df6bb60(#"hash_61f69ed4cbd8f2f5", 1);
	level namespace_6747c550::function_7df6bb60(#"hash_5114ed99a6bad03b", 1);
	if(!var_5ea5c94d)
	{
		level flag::wait_till_all(array(#"hash_3d833ecc64915d8d", #"hash_d38ff215be3a4fc", #"hash_4142472dec557d03", #"hash_45b6b1ee5d5038b4"));
	}
	level flag::set(#"hash_76692d6669cb0500");
	function_97e78811(0, 0);
}

/*
	Name: function_18b39e14
	Namespace: namespace_2ea65b04
	Checksum: 0x5B08DF2F
	Offset: 0x17D0
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_18b39e14()
{
	if(level flag::get(#"hash_18134dc5b9b39a96") && !level flag::get(#"hash_589679a12150767a"))
	{
		function_3effad88(#"danu");
	}
	if(level flag::get(#"hash_582eea77824b014d") && !level flag::get(#"hash_4abb12b14a38d2e9"))
	{
		function_3effad88(#"ra");
	}
	if(level flag::get(#"hash_5cc500f9282cd290") && !level flag::get(#"hash_15f5946d4968f144"))
	{
		function_3effad88(#"odin");
	}
	if(level flag::get(#"hash_20c64c155f7a0065") && !level flag::get(#"hash_355567a6fa6d44d1"))
	{
		function_3effad88(#"zeus");
	}
}

/*
	Name: function_3effad88
	Namespace: namespace_2ea65b04
	Checksum: 0xC6CFDCC2
	Offset: 0x1980
	Size: 0x244
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3effad88(var_5542e979)
{
	str_prompt = zm_utility::function_d6046228(#"hash_2a4860e40142bac5", #"hash_7c465ea7da6991fb");
	switch(var_5542e979)
	{
		case "danu":
		{
			var_e362d075 = getent("t_pap_quest_danu_encounter", "targetname");
			level flag::clear(#"hash_18134dc5b9b39a96");
			break;
		}
		case "ra":
		{
			var_e362d075 = getent("t_pap_quest_ra_encounter", "targetname");
			level flag::clear(#"hash_582eea77824b014d");
			break;
		}
		case "odin":
		{
			var_e362d075 = getent("t_pap_quest_odin_encounter", "targetname");
			level flag::clear(#"hash_5cc500f9282cd290");
			break;
		}
		case "zeus":
		{
			var_e362d075 = getent("t_pap_quest_zeus_encounter", "targetname");
			level flag::clear(#"hash_20c64c155f7a0065");
			break;
		}
	}
	var_e362d075 triggerenable(1);
	var_e362d075 sethintstring(str_prompt);
	level flag::clear(#"hash_798d51388d6e10f4");
	level thread function_199b1814(var_5542e979, function_67fffa0(var_5542e979));
}

/*
	Name: function_57d79cac
	Namespace: namespace_2ea65b04
	Checksum: 0x932077D0
	Offset: 0x1BD0
	Size: 0x57C
	Parameters: 0
	Flags: Linked
*/
function function_57d79cac()
{
	level notify(#"hash_47472704726954cf");
	level flag::clear(#"hash_18134dc5b9b39a96");
	level flag::clear(#"hash_582eea77824b014d");
	level flag::clear(#"hash_5cc500f9282cd290");
	level flag::clear(#"hash_20c64c155f7a0065");
	level flag::clear(#"hash_589679a12150767a");
	level flag::clear(#"hash_4abb12b14a38d2e9");
	level flag::clear(#"hash_15f5946d4968f144");
	level flag::clear(#"hash_355567a6fa6d44d1");
	level flag::clear(#"hash_3d833ecc64915d8d");
	level flag::clear(#"hash_d38ff215be3a4fc");
	level flag::clear(#"hash_4142472dec557d03");
	level flag::clear(#"hash_45b6b1ee5d5038b4");
	var_9840ab47 = getentarray("pap_quest_encounter_triggers", "script_noteworthy");
	if(function_8b1a219a())
	{
		array::run_all(var_9840ab47, &sethintstring, #"hash_7c465ea7da6991fb");
	}
	else
	{
		array::run_all(var_9840ab47, &sethintstring, #"hash_2a4860e40142bac5");
	}
	var_16561d51 = array(#"marauder", #"destroyer", #"both", #"tigers");
	var_5cf420b9 = array(#"danu", #"ra", #"odin", #"zeus");
	var_16561d51 = array::randomize(var_16561d51);
	level.var_4118581a = 0;
	foreach(i, var_5542e979 in var_5cf420b9)
	{
		level thread function_199b1814(var_5542e979, var_16561d51[i]);
	}
	level.var_c22016cf = 0;
	level.var_7695ff59 = 0;
	level.var_9847c460 = 0;
	level thread function_a2f4eb85();
	var_307566 = getentarray("mdl_pap_quest_head", "targetname");
	foreach(mdl_head in var_307566)
	{
		mdl_head flag::clear(#"hash_26125a3306681e2");
		mdl_head hide();
	}
	level namespace_6747c550::function_7df6bb60(#"hash_4fce42c559430ff9", 1);
	level namespace_6747c550::function_7df6bb60(#"hash_6257a73f22800e57", 1);
	level namespace_6747c550::function_7df6bb60(#"hash_61f69ed4cbd8f2f5", 1);
	level namespace_6747c550::function_7df6bb60(#"hash_5114ed99a6bad03b", 1);
	if(isdefined(level.var_9ca6160c))
	{
		array::delete_all(level.var_9ca6160c);
		level.var_9ca6160c = undefined;
	}
	function_f18e2775();
}

/*
	Name: function_64f2d6de
	Namespace: namespace_2ea65b04
	Checksum: 0x3E415DF3
	Offset: 0x2158
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function function_64f2d6de(a_ents)
{
	var_f99f1421 = a_ents[#"hash_7aff0ee60ddd937b"];
	var_307566 = getentarray("mdl_pap_quest_head", "targetname");
	foreach(mdl_head in var_307566)
	{
		mdl_head linkto(var_f99f1421, mdl_head.var_d06913fa);
	}
}

/*
	Name: function_97e78811
	Namespace: namespace_2ea65b04
	Checksum: 0x4C6ECBAB
	Offset: 0x2238
	Size: 0x1D0
	Parameters: 2
	Flags: Linked
*/
function function_97e78811(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_18134dc5b9b39a96");
		level flag::set(#"hash_582eea77824b014d");
		level flag::set(#"hash_5cc500f9282cd290");
		level flag::set(#"hash_20c64c155f7a0065");
		level flag::set(#"hash_589679a12150767a");
		level flag::set(#"hash_4abb12b14a38d2e9");
		level flag::set(#"hash_15f5946d4968f144");
		level flag::set(#"hash_355567a6fa6d44d1");
		level flag::set(#"hash_3d833ecc64915d8d");
		level flag::set(#"hash_d38ff215be3a4fc");
		level flag::set(#"hash_4142472dec557d03");
		level flag::set(#"hash_45b6b1ee5d5038b4");
	}
	else
	{
		level thread function_a73ff9f2();
		level notify(#"hash_9ffcf4efbfb9b65");
	}
}

/*
	Name: function_199b1814
	Namespace: namespace_2ea65b04
	Checksum: 0xA2D1B0B7
	Offset: 0x2410
	Size: 0x1004
	Parameters: 2
	Flags: Linked
*/
function function_199b1814(var_5542e979, var_32af2882)
{
	level notify(var_5542e979 + "_pap_quest_restart");
	level endon(#"pap_quest_completed", #"hash_47472704726954cf", var_5542e979 + "_pap_quest_restart");
	switch(var_5542e979)
	{
		case "danu":
		{
			str_trigger = "t_pap_quest_danu_encounter";
			var_31e5b512 = #"hash_18134dc5b9b39a96";
			var_def2a519 = #"hash_589679a12150767a";
			level.var_58e06b5b = var_32af2882;
			var_33a5ad52 = struct::get_array("s_pap_encounter_scenes_danu_destroyer");
			var_b994877d = struct::get_array("s_pap_encounter_scenes_danu_marauder");
			var_a0529e1b = struct::get_array("s_pap_encounter_scenes_danu_tiger");
			s_spawn = struct::get("s_pap_encounter_spawn_danu");
			break;
		}
		case "ra":
		{
			str_trigger = "t_pap_quest_ra_encounter";
			var_31e5b512 = #"hash_582eea77824b014d";
			var_def2a519 = #"hash_4abb12b14a38d2e9";
			level.var_b941799e = var_32af2882;
			var_33a5ad52 = struct::get_array("s_pap_encounter_scenes_ra_destroyer");
			var_b994877d = struct::get_array("s_pap_encounter_scenes_ra_marauder");
			var_a0529e1b = struct::get_array("s_pap_encounter_scenes_ra_tiger");
			s_spawn = struct::get("s_pap_encounter_spawn_ra");
			break;
		}
		case "odin":
		{
			str_trigger = "t_pap_quest_odin_encounter";
			var_31e5b512 = #"hash_5cc500f9282cd290";
			var_def2a519 = #"hash_15f5946d4968f144";
			level.var_34bb868f = var_32af2882;
			var_33a5ad52 = struct::get_array("s_pap_encounter_scenes_odin_destroyer");
			var_b994877d = struct::get_array("s_pap_encounter_scenes_odin_marauder");
			var_a0529e1b = struct::get_array("s_pap_encounter_scenes_odin_tiger");
			s_spawn = struct::get("s_pap_encounter_spawn_odin");
			break;
		}
		case "zeus":
		{
			str_trigger = "t_pap_quest_zeus_encounter";
			var_31e5b512 = #"hash_20c64c155f7a0065";
			var_def2a519 = #"hash_355567a6fa6d44d1";
			level.var_c90f6df9 = var_32af2882;
			var_33a5ad52 = struct::get_array("s_pap_encounter_scenes_zeus_destroyer");
			var_b994877d = struct::get_array("s_pap_encounter_scenes_zeus_marauder");
			var_a0529e1b = struct::get_array("s_pap_encounter_scenes_zeus_tiger");
			s_spawn = struct::get("s_pap_encounter_spawn_zeus");
			break;
		}
	}
	var_33a5ad52 = array::randomize(var_33a5ad52);
	var_b994877d = array::randomize(var_b994877d);
	var_a0529e1b = array::randomize(var_a0529e1b);
	t_trigger = getent(str_trigger, "targetname");
	var_190d5d80 = getent(t_trigger.target, "targetname");
	var_190d5d80 thread scene::init("p8_fxanim_zm_towers_challenge_gong_bundle", var_190d5d80);
	b_triggered = 0;
	while(!b_triggered)
	{
		waitresult = undefined;
		waitresult = t_trigger waittill(#"trigger");
		if(!level flag::get(#"hash_798d51388d6e10f4"))
		{
			b_triggered = 1;
			break;
		}
	}
	level flag::set(#"hash_2a7d461c7eff8179");
	level flag::set(var_31e5b512);
	level flag::set(#"hash_798d51388d6e10f4");
	switch(var_5542e979)
	{
		case "danu":
		{
			var_32af2882 = level.var_58e06b5b;
			str_exploder = "fxexp_gong_danu";
			var_38e7a8be = #"hash_18134dc5b9b39a96";
			break;
		}
		case "ra":
		{
			var_32af2882 = level.var_b941799e;
			str_exploder = "fxexp_gong_ra";
			var_38e7a8be = #"hash_582eea77824b014d";
			break;
		}
		case "odin":
		{
			var_32af2882 = level.var_34bb868f;
			str_exploder = "fxexp_gong_odin";
			var_38e7a8be = #"hash_5cc500f9282cd290";
			break;
		}
		case "zeus":
		{
			var_32af2882 = level.var_c90f6df9;
			str_exploder = "fxexp_gong_zeus";
			var_38e7a8be = #"hash_20c64c155f7a0065";
			break;
		}
	}
	exploder::exploder(str_exploder);
	namespace_11c28b18::function_afd37143(var_38e7a8be);
	switch(var_32af2882)
	{
		case "marauder":
		{
			if(!level.var_4118581a)
			{
				var_e482422a = array(#"marauder");
			}
			else
			{
				var_e482422a = [];
				for(i = 0; i < var_b994877d.size; i++)
				{
					if(!isdefined(var_e482422a))
					{
						var_e482422a = [];
					}
					else if(!isarray(var_e482422a))
					{
						var_e482422a = array(var_e482422a);
					}
					var_e482422a[var_e482422a.size] = #"marauder";
				}
			}
			break;
		}
		case "destroyer":
		{
			if(!level.var_4118581a)
			{
				var_e482422a = array(#"destroyer");
			}
			else
			{
				var_e482422a = [];
				for(i = 0; i < var_33a5ad52.size; i++)
				{
					if(!isdefined(var_e482422a))
					{
						var_e482422a = [];
					}
					else if(!isarray(var_e482422a))
					{
						var_e482422a = array(var_e482422a);
					}
					var_e482422a[var_e482422a.size] = #"destroyer";
				}
			}
			break;
		}
		case "both":
		{
			var_e482422a = array(#"marauder", #"destroyer");
			break;
		}
		case "tigers":
		{
			if(!level.var_4118581a)
			{
				var_e482422a = array(#"tiger", #"tiger", #"tiger", #"tiger");
			}
			else
			{
				var_e482422a = [];
				for(i = 0; i < var_a0529e1b.size; i++)
				{
					if(!isdefined(var_e482422a))
					{
						var_e482422a = [];
					}
					else if(!isarray(var_e482422a))
					{
						var_e482422a = array(var_e482422a);
					}
					var_e482422a[var_e482422a.size] = #"tiger";
				}
			}
			break;
		}
	}
	var_190d5d80 thread scene::play("p8_fxanim_zm_towers_challenge_gong_bundle", var_190d5d80);
	level.var_b2b15659 = 1;
	function_a73ff9f2();
	level.var_5c51cf1a = var_e482422a.size;
	level.var_4629a597 = 0;
	var_1f8676e3 = arraycopy(var_33a5ad52);
	var_1b55c253 = arraycopy(var_b994877d);
	var_6e280451 = arraycopy(var_a0529e1b);
	foreach(i, str_enemy in var_e482422a)
	{
		switch(str_enemy)
		{
			case "destroyer":
			{
				if(var_32af2882 != #"both")
				{
					if(var_1f8676e3.size == 0)
					{
						var_1f8676e3 = array::randomize(var_33a5ad52);
					}
					s_scene = var_1f8676e3[0];
					arrayremoveindex(var_1f8676e3, 0);
				}
				else
				{
					switch(var_5542e979)
					{
						case "danu":
						{
							s_scene = struct::get("danu_destroyer", "script_pap_encounter_scene_both");
							break;
						}
						case "ra":
						{
							s_scene = struct::get("ra_destroyer", "script_pap_encounter_scene_both");
							break;
						}
						case "odin":
						{
							s_scene = struct::get("odin_destroyer", "script_pap_encounter_scene_both");
							break;
						}
						case "zeus":
						{
							s_scene = struct::get("zeus_destroyer", "script_pap_encounter_scene_both");
							break;
						}
					}
				}
				break;
			}
			case "marauder":
			{
				if(var_32af2882 != #"both")
				{
					if(var_1b55c253.size == 0)
					{
						var_1b55c253 = array::randomize(var_b994877d);
					}
					s_scene = var_1b55c253[0];
					arrayremoveindex(var_1b55c253, 0);
				}
				else
				{
					switch(var_5542e979)
					{
						case "danu":
						{
							s_scene = struct::get("danu_marauder", "script_pap_encounter_scene_both");
							break;
						}
						case "ra":
						{
							s_scene = struct::get("ra_marauder", "script_pap_encounter_scene_both");
							break;
						}
						case "odin":
						{
							s_scene = struct::get("odin_marauder", "script_pap_encounter_scene_both");
							break;
						}
						case "zeus":
						{
							s_scene = struct::get("zeus_marauder", "script_pap_encounter_scene_both");
							break;
						}
					}
				}
				break;
			}
			case "tiger":
			{
				if(var_6e280451.size == 0)
				{
					var_6e280451 = array::randomize(var_a0529e1b);
				}
				s_scene = var_6e280451[0];
				arrayremoveindex(var_6e280451, 0);
				break;
			}
		}
		function_79071b9a(str_enemy, s_spawn, s_scene);
		if(level.var_4118581a || (var_32af2882 == #"tigers" && i < var_e482422a.size))
		{
			wait(1);
		}
	}
	var_be17187b = undefined;
	var_be17187b = level waittill(#"hash_2ea1048758a3ff14");
	v_origin = var_be17187b.v_origin;
	var_7246d429 = var_be17187b.var_7246d429;
	str_archetype = var_be17187b.str_archetype;
	var_1e137cec = var_be17187b.var_1e137cec;
	if(var_32af2882 == #"both")
	{
		if(var_1e137cec == #"gladiator_destroyer")
		{
			level.var_9bd700c9 = #"destroyer";
		}
		else
		{
			level.var_9bd700c9 = #"marauder";
		}
	}
	level thread drop_head(v_origin, var_5542e979, var_7246d429);
	level flag::set(var_def2a519);
	level flag::clear(#"hash_798d51388d6e10f4");
	level.var_b2b15659 = 0;
	function_f18e2775();
	switch(var_5542e979)
	{
		case "danu":
		{
			var_38e7a8be = #"hash_589679a12150767a";
			break;
		}
		case "ra":
		{
			var_38e7a8be = #"hash_4abb12b14a38d2e9";
			break;
		}
		case "odin":
		{
			var_38e7a8be = #"hash_15f5946d4968f144";
			break;
		}
		case "zeus":
		{
			var_38e7a8be = #"hash_355567a6fa6d44d1";
			break;
		}
	}
	namespace_11c28b18::function_afd37143(var_38e7a8be);
}

/*
	Name: function_79071b9a
	Namespace: namespace_2ea65b04
	Checksum: 0x3D02A42F
	Offset: 0x3420
	Size: 0x172
	Parameters: 3
	Flags: Linked
*/
function function_79071b9a(str_enemy, s_spawn, s_scene)
{
	ai_enemy = undefined;
	while(!isdefined(ai_enemy))
	{
		switch(str_enemy)
		{
			case "marauder":
			{
				ai_enemy = namespace_acd9c698::function_c9cd31(1, s_spawn);
				break;
			}
			case "destroyer":
			{
				ai_enemy = namespace_acd9c698::function_2efc00db(1, s_spawn);
				break;
			}
			case "tiger":
			{
				ai_enemy = namespace_3fe4d0d7::spawn_single(1, s_spawn);
				break;
			}
		}
		if(isdefined(ai_enemy))
		{
			ai_enemy flag::init(#"hash_368f8dee8aca386c");
			ai_enemy thread function_9ec8ec89();
			ai_enemy thread function_4b702fd5(s_scene);
			if(ai_enemy.archetype == #"tiger")
			{
				ai_enemy ai::set_behavior_attribute("sprint", 1);
			}
			return;
		}
	}
}

/*
	Name: function_4b702fd5
	Namespace: namespace_2ea65b04
	Checksum: 0x527D1F5E
	Offset: 0x35A0
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_4b702fd5(s_scene)
{
	self endon(#"death");
	self.var_126d7bef = 1;
	self.no_powerups = 1;
	self.ignore_round_spawn_failsafe = 1;
	self.b_ignore_cleanup = 1;
	self.ignore_enemy_count = 1;
	self.ignore_nuke = 1;
	self.var_1df64653 = 1;
	s_scene scene::play(self);
	self.var_1df64653 = undefined;
	if(self.archetype == #"gladiator")
	{
		self.completed_emerging_into_playable_area = 1;
		self notify(#"completed_emerging_into_playable_area");
	}
	else if(self.archetype == #"tiger")
	{
		self namespace_dea34b6a::function_8747b993();
	}
	self flag::set(#"hash_368f8dee8aca386c");
}

/*
	Name: function_9ec8ec89
	Namespace: namespace_2ea65b04
	Checksum: 0x6248E94C
	Offset: 0x36D0
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function function_9ec8ec89()
{
	level endon(#"round_reset");
	str_archetype = self.archetype;
	var_1e137cec = self.var_9fde8624;
	self waittill(#"death");
	v_origin = self.origin;
	var_7246d429 = self flag::get(#"hash_368f8dee8aca386c");
	if(var_7246d429)
	{
		var_7246d429 = zm_utility::check_point_in_playable_area(v_origin);
	}
	level.var_4629a597++;
	if(level.var_4629a597 >= level.var_5c51cf1a)
	{
		self thread namespace_11c28b18::function_ae1b4f5b(100, 75, 75);
		level notify(#"hash_2ea1048758a3ff14", {#hash_1e137cec:var_1e137cec, #str_archetype:str_archetype, #hash_7246d429:var_7246d429, #v_origin:v_origin});
	}
}

/*
	Name: function_a73ff9f2
	Namespace: namespace_2ea65b04
	Checksum: 0x2E769859
	Offset: 0x3830
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_a73ff9f2()
{
	var_9840ab47 = getentarray("pap_quest_encounter_triggers", "script_noteworthy");
	foreach(var_324ea742 in var_9840ab47)
	{
		var_324ea742 triggerenable(0);
	}
}

/*
	Name: function_f18e2775
	Namespace: namespace_2ea65b04
	Checksum: 0x463A42D3
	Offset: 0x38E0
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_f18e2775()
{
	var_9840ab47 = getentarray("pap_quest_encounter_triggers", "script_noteworthy");
	foreach(var_324ea742 in var_9840ab47)
	{
		if(!level flag::get(hash(var_324ea742.var_bc2bade2)))
		{
			var_324ea742 triggerenable(1);
		}
	}
}

/*
	Name: drop_head
	Namespace: namespace_2ea65b04
	Checksum: 0xA613B9AD
	Offset: 0x39C0
	Size: 0x3D2
	Parameters: 3
	Flags: Linked
*/
function drop_head(v_origin, var_5542e979, var_5570d8de)
{
	v_position = v_origin + vectorscale((0, 0, 1), 40);
	str_head = #"c_t8_zmb_dlc0_zombie_corpse_head_2";
	var_32af2882 = function_67fffa0(var_5542e979);
	b_both = 0;
	if(var_32af2882 == #"both")
	{
		b_both = 1;
		if(!isdefined(level.var_9bd700c9))
		{
			level.var_9bd700c9 = #"destroyer";
		}
		var_32af2882 = level.var_9bd700c9;
	}
	switch(var_32af2882)
	{
		case "destroyer":
		{
			str_head = #"hash_7c166ef26a8ce946";
			break;
		}
		case "marauder":
		{
			str_head = #"c_t8_zmb_dlc0_zombie_marauder_decapitated_head1";
			break;
		}
		case "tigers":
		{
			str_head = #"hash_7046550bbfeaf740";
			break;
		}
	}
	var_483b8a0 = util::spawn_model(str_head, v_position, vectorscale((1, 0, 0), 270));
	var_483b8a0 clientfield::set("zombie_head_pickup_glow", 1);
	if(!var_5570d8de)
	{
		switch(var_5542e979)
		{
			case "danu":
			{
				str_backup = "s_danu_encounter_back_up_head_spawn";
				break;
			}
			case "ra":
			{
				str_backup = "s_ra_encounter_back_up_head_spawn";
				break;
			}
			case "odin":
			{
				str_backup = "s_odin_encounter_back_up_head_spawn";
				break;
			}
			case "zeus":
			{
				str_backup = "s_zeus_encounter_back_up_head_spawn";
				break;
			}
		}
		s_point = struct::get(str_backup);
		var_a0fca4e1 = s_point.origin + vectorscale((0, 0, 1), 40);
		var_483b8a0 moveto(var_a0fca4e1, 2);
	}
	var_483b8a0 thread namespace_11c28b18::function_48f49769();
	if(b_both)
	{
		var_32af2882 = #"both";
	}
	var_483b8a0 thread function_499b080d(var_5542e979, var_32af2882);
	if(!isdefined(level.var_9ca6160c))
	{
		level.var_9ca6160c = array();
	}
	if(!isdefined(level.var_9ca6160c))
	{
		level.var_9ca6160c = [];
	}
	else if(!isarray(level.var_9ca6160c))
	{
		level.var_9ca6160c = array(level.var_9ca6160c);
	}
	if(!isinarray(level.var_9ca6160c, var_483b8a0))
	{
		level.var_9ca6160c[level.var_9ca6160c.size] = var_483b8a0;
	}
}

/*
	Name: function_499b080d
	Namespace: namespace_2ea65b04
	Checksum: 0x9CDA6D31
	Offset: 0x3DA0
	Size: 0x4A0
	Parameters: 2
	Flags: Linked
*/
function function_499b080d(var_5542e979, var_32af2882)
{
	level endon(#"hash_47472704726954cf");
	var_903152eb = 0;
	while(!var_903152eb)
	{
		a_e_players = level.players;
		foreach(e_player in a_e_players)
		{
			if(distancesquared(e_player.origin, self.origin) < 4096)
			{
				var_903152eb = 1;
				break;
			}
		}
		wait(0.1);
	}
	switch(var_5542e979)
	{
		case "danu":
		{
			str_flag = #"hash_3d833ecc64915d8d";
			break;
		}
		case "ra":
		{
			str_flag = #"hash_d38ff215be3a4fc";
			break;
		}
		case "odin":
		{
			str_flag = #"hash_4142472dec557d03";
			break;
		}
		case "zeus":
		{
			str_flag = #"hash_45b6b1ee5d5038b4";
			break;
		}
	}
	level flag::set(str_flag);
	str_clientfield = function_1191a919(var_32af2882);
	level namespace_6747c550::function_7df6bb60(str_clientfield, 2);
	level.var_c22016cf++;
	level thread function_7590a833();
	n_scalar = zombie_utility::function_6403cf83(#"zombie_point_scalar", #"allies");
	foreach(e_player in level.players)
	{
		e_player zm_score::add_to_player_score(500 * n_scalar);
	}
	playsoundatposition(#"hash_f35db774de79d2", self.origin);
	if(isdefined(level.var_9ca6160c) && isinarray(level.var_9ca6160c, self))
	{
		arrayremovevalue(level.var_9ca6160c, self);
		if(!level.var_9ca6160c.size)
		{
			level.var_9ca6160c = undefined;
		}
	}
	self clientfield::set("zombie_head_pickup_glow", 0);
	self delete();
	/#
		var_cd6e44b6 = 0;
		if(level flag::get(#"hash_3d833ecc64915d8d"))
		{
			var_cd6e44b6++;
		}
		if(level flag::get(#"hash_d38ff215be3a4fc"))
		{
			var_cd6e44b6++;
		}
		if(level flag::get(#"hash_4142472dec557d03"))
		{
			var_cd6e44b6++;
		}
		if(level flag::get(#"hash_45b6b1ee5d5038b4"))
		{
			var_cd6e44b6++;
		}
		str_message = var_cd6e44b6 + "";
		iprintlnbold(str_message);
	#/
	level notify(#"collected_head");
}

/*
	Name: function_52411f5e
	Namespace: namespace_2ea65b04
	Checksum: 0x8E1330E7
	Offset: 0x4248
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_52411f5e(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"hash_2cf71ce4a3d1c081");
		level flag::wait_till("zm_towers_pap_quest_sentinel_artifact_exploded");
	}
	level flag::set("zm_towers_pap_quest_completed");
	function_156669dd(0, 0);
}

/*
	Name: function_156669dd
	Namespace: namespace_2ea65b04
	Checksum: 0xE3231097
	Offset: 0x42E0
	Size: 0x500
	Parameters: 2
	Flags: Linked
*/
function function_156669dd(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_2cf71ce4a3d1c081");
		level flag::set("zm_towers_pap_quest_sentinel_artifact_exploded");
		level flag::set("zm_towers_pap_quest_completed");
		var_307566 = getentarray("mdl_pap_quest_head", "targetname");
		foreach(mdl_head in var_307566)
		{
			mdl_head show();
		}
		mdl_sentinel_artifact = getent("mdl_pap_quest_sentinel_artifact", "targetname");
		mdl_sentinel_artifact hide();
		mdl_sentinel_artifact notsolid();
	}
	else
	{
		/#
			iprintlnbold("");
		#/
		if(zm_utility::is_standard())
		{
			level waittill(#"hash_7ca261f468171655");
		}
		else
		{
			level flag::set("power_on");
		}
		namespace_11c28b18::function_afd37143(#"pap_quest_completed");
		var_307566 = getentarray("mdl_pap_quest_head", "targetname");
		array::thread_all(var_307566, &function_9b320791);
		level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_spikes_bundle");
		level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_blood_01_bundle", "Shot 2");
		level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_blood_02_bundle", "Shot 2");
		level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_blood_03_bundle", "Shot 2");
		level scene::play("p8_fxanim_zm_towers_pap_sarcophagus_blood_04_bundle", "Shot 2");
		level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_bundle");
		level thread scene::play("p8_fxanim_zm_towers_pap_door_blue_bundle");
		level thread scene::play("p8_fxanim_zm_towers_pap_door_red_bundle");
		exploder::exploder("fx8_exp_pap_slam_smk");
		var_f7afe1a0 = getent("sarcophagus_destroyed", "targetname");
		var_f7afe1a0 show();
		var_e7ab66ef = getent("sarcophagus_solid", "targetname");
		var_e7ab66ef delete();
		a_mdl_pap_room_debris_clip = getentarray("mdl_pap_room_debris_clip", "targetname");
		foreach(mdl_pap_room_debris_clip in a_mdl_pap_room_debris_clip)
		{
			mdl_pap_room_debris_clip connectpaths();
			mdl_pap_room_debris_clip delete();
		}
		level flag::set("connect_pap_room_to_danu_ra_tunnel");
		level flag::set("connect_pap_room_to_odin_zeus_tunnel");
		level notify(#"pap_quest_completed");
	}
}

/*
	Name: function_9b320791
	Namespace: namespace_2ea65b04
	Checksum: 0xB25C9A66
	Offset: 0x47E8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_9b320791()
{
	level endon(#"end_game");
	str_notify = self.var_427eb1ae;
	level waittill(str_notify);
	self thread fx::play("fx_challenge_head_blood_burst", self getcentroid(), undefined, undefined, 1, undefined, 1, 0);
	self notify(#"hash_691806c47ba12fac");
	self hide();
}

/*
	Name: function_a2f4eb85
	Namespace: namespace_2ea65b04
	Checksum: 0xE7E907F8
	Offset: 0x4898
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_a2f4eb85()
{
	t_trigger = getent("t_pap_quest_place_head", "targetname");
	t_trigger sethintstring(#"hash_6b4f36812ac1e729");
}

/*
	Name: function_7590a833
	Namespace: namespace_2ea65b04
	Checksum: 0x99F18B84
	Offset: 0x48F0
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_7590a833()
{
	self notify("5e1fb7fbace74e0b");
	self endon("5e1fb7fbace74e0b");
	level endon(#"pap_quest_completed");
	t_trigger = getent("t_pap_quest_place_head", "targetname");
	foreach(e_player in level.players)
	{
		e_player clientfield::set("force_pap_models", 1);
	}
	if(function_8b1a219a())
	{
		t_trigger sethintstring(#"hash_785577888de11add");
	}
	else
	{
		t_trigger sethintstring(#"hash_50fc385a94b3d3f");
	}
	while(true)
	{
		s_notify = undefined;
		s_notify = t_trigger waittill(#"trigger");
		e_player = s_notify.activator;
		if(isplayer(e_player))
		{
			v_origin = e_player.origin;
			break;
		}
	}
	level thread function_5ed0d968(v_origin);
}

/*
	Name: function_5ed0d968
	Namespace: namespace_2ea65b04
	Checksum: 0x4573C5E8
	Offset: 0x4AC8
	Size: 0x254
	Parameters: 1
	Flags: Linked
*/
function function_5ed0d968(v_player_origin)
{
	var_307566 = getentarray("mdl_pap_quest_head", "targetname");
	var_307566 = util::get_array_of_closest(v_player_origin, var_307566);
	n_heads = level.var_c22016cf;
	level.var_c22016cf = 0;
	foreach(mdl_head in var_307566)
	{
		if(mdl_head flag::get(#"hash_26125a3306681e2"))
		{
			continue;
		}
		mdl_head flag::set(#"hash_26125a3306681e2");
		mdl_head function_f3c4aeac();
		mdl_head thread function_61cf4d04();
		level.var_7695ff59++;
		n_heads--;
		if(n_heads <= 0)
		{
			break;
		}
	}
	if(level.var_7695ff59 >= 4)
	{
		var_10761775 = getent("t_pap_quest_place_head", "targetname");
		var_10761775 triggerenable(0);
		foreach(e_player in level.players)
		{
			e_player clientfield::set("force_pap_models", 0);
		}
	}
	else
	{
		function_a2f4eb85();
	}
}

/*
	Name: function_f3c4aeac
	Namespace: namespace_2ea65b04
	Checksum: 0x52DCAB01
	Offset: 0x4D28
	Size: 0x424
	Parameters: 0
	Flags: Linked
*/
function function_f3c4aeac()
{
	if(level flag::get(#"hash_3d833ecc64915d8d") && !level flag::get(#"hash_1eda3c39867cbe53"))
	{
		str_flag = #"hash_1eda3c39867cbe53";
		var_5542e979 = #"danu";
	}
	else
	{
		if(level flag::get(#"hash_d38ff215be3a4fc") && !level flag::get(#"hash_1b7828aafd3f83f4"))
		{
			str_flag = #"hash_1b7828aafd3f83f4";
			var_5542e979 = #"ra";
		}
		else
		{
			if(level flag::get(#"hash_4142472dec557d03") && !level flag::get(#"hash_15b79db61753c205"))
			{
				str_flag = #"hash_15b79db61753c205";
				var_5542e979 = #"odin";
			}
			else if(level flag::get(#"hash_45b6b1ee5d5038b4") && !level flag::get(#"hash_34c1fdccaa5279bc"))
			{
				str_flag = #"hash_34c1fdccaa5279bc";
				var_5542e979 = #"zeus";
			}
		}
	}
	str_clientfield = function_1191a919(var_5542e979);
	level namespace_6747c550::function_7df6bb60(str_clientfield, 3);
	level flag::set(str_flag);
	str_fx_tag = "j_neck";
	var_32af2882 = function_67fffa0(var_5542e979);
	if(var_32af2882 == #"both")
	{
		if(!isdefined(level.var_9bd700c9))
		{
			level.var_9bd700c9 = #"destroyer";
		}
		var_32af2882 = level.var_9bd700c9;
	}
	switch(var_32af2882)
	{
		case "destroyer":
		{
			str_fx_tag = undefined;
			self setmodel(#"hash_7c166ef26a8ce946");
			break;
		}
		case "marauder":
		{
			str_fx_tag = undefined;
			self setmodel(#"c_t8_zmb_dlc0_zombie_marauder_decapitated_head1");
			break;
		}
		case "tigers":
		{
			str_fx_tag = undefined;
			self setmodel(#"hash_7046550bbfeaf740");
			break;
		}
	}
	self show();
	self playsound(#"hash_3d7066af9c9bf849");
	self thread fx::play("fx_challenge_head_blood_burst", self getcentroid(), undefined, undefined, 1, undefined, 1, 0);
	self thread fx::play("fx_challenge_head_blood_drips", self getcentroid(), undefined, #"hash_691806c47ba12fac", 1, str_fx_tag, 1, 0);
}

/*
	Name: function_67fffa0
	Namespace: namespace_2ea65b04
	Checksum: 0x772A1FA8
	Offset: 0x5158
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_67fffa0(var_5542e979)
{
	switch(var_5542e979)
	{
		case "danu":
		{
			var_32af2882 = level.var_58e06b5b;
			break;
		}
		case "ra":
		{
			var_32af2882 = level.var_b941799e;
			break;
		}
		case "odin":
		{
			var_32af2882 = level.var_34bb868f;
			break;
		}
		case "zeus":
		{
			var_32af2882 = level.var_c90f6df9;
			break;
		}
	}
	return var_32af2882;
}

/*
	Name: function_1191a919
	Namespace: namespace_2ea65b04
	Checksum: 0x49867B7B
	Offset: 0x5210
	Size: 0x106
	Parameters: 1
	Flags: Linked
*/
function function_1191a919(var_32af2882)
{
	switch(var_32af2882)
	{
		case "destroyer":
		{
			str_clientfield = #"hash_4fce42c559430ff9";
			break;
		}
		case "marauder":
		{
			str_clientfield = #"hash_6257a73f22800e57";
			break;
		}
		case "both":
		{
			str_clientfield = #"hash_61f69ed4cbd8f2f5";
			break;
		}
		case "tigers":
		{
			str_clientfield = #"hash_5114ed99a6bad03b";
			break;
		}
		default:
		{
			var_32af2882 = function_67fffa0(var_32af2882);
			str_clientfield = function_1191a919(var_32af2882);
			break;
		}
	}
	return str_clientfield;
}

/*
	Name: function_61cf4d04
	Namespace: namespace_2ea65b04
	Checksum: 0x59CB2A3
	Offset: 0x5320
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_61cf4d04()
{
	level scene::play(self.var_28f6edb7, "Shot 1");
	level.var_9847c460++;
	if(level.var_9847c460 >= 4)
	{
		level flag::set(#"hash_2cf71ce4a3d1c081");
	}
}

/*
	Name: function_d7c092b9
	Namespace: namespace_2ea65b04
	Checksum: 0xAD26FF85
	Offset: 0x5398
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_d7c092b9()
{
	level flag::wait_till(#"hash_2cf71ce4a3d1c081");
	var_10761775 = getent("t_pap_quest_place_head", "targetname");
	if(isdefined(var_10761775) && (!(zm_utility::is_trials() && level.round_number <= 8)))
	{
		var_10761775 delete();
	}
	var_8a3d82fc = getentarray("script_brush_lgt_pap_door", "targetname");
	foreach(a_clip in var_8a3d82fc)
	{
		a_clip delete();
	}
	exploder::exploder("exp_lgt_pap");
	level flag::set("zm_towers_pap_quest_sentinel_artifact_exploded");
}

/*
	Name: function_438a415
	Namespace: namespace_2ea65b04
	Checksum: 0xF99D81DF
	Offset: 0x5518
	Size: 0x31C
	Parameters: 1
	Flags: None
*/
function function_438a415(str_head)
{
	/#
		switch(str_head)
		{
			case "danu":
			{
				var_31e5b512 = #"hash_18134dc5b9b39a96";
				var_def2a519 = #"hash_589679a12150767a";
				var_ce6f7a4c = #"hash_3d833ecc64915d8d";
				break;
			}
			case "ra":
			{
				var_31e5b512 = #"hash_582eea77824b014d";
				var_def2a519 = #"hash_4abb12b14a38d2e9";
				var_ce6f7a4c = #"hash_d38ff215be3a4fc";
				break;
			}
			case "odin":
			{
				var_31e5b512 = #"hash_5cc500f9282cd290";
				var_def2a519 = #"hash_15f5946d4968f144";
				var_ce6f7a4c = #"hash_4142472dec557d03";
				break;
			}
			case "zeus":
			{
				var_31e5b512 = #"hash_20c64c155f7a0065";
				var_def2a519 = #"hash_355567a6fa6d44d1";
				var_ce6f7a4c = #"hash_45b6b1ee5d5038b4";
				break;
			}
			case "all":
			{
				function_438a415(#"danu");
				function_438a415(#"ra");
				function_438a415(#"odin");
				function_438a415(#"zeus");
				return;
			}
		}
		level flag::set(#"hash_2a7d461c7eff8179");
		if(level flag::get(#"hash_2cf71ce4a3d1c081") || level flag::get(var_31e5b512))
		{
			return;
		}
		function_a73ff9f2();
		str_clientfield = function_1191a919(str_head);
		level namespace_6747c550::function_7df6bb60(str_clientfield, 2);
		level flag::set(var_31e5b512);
		level flag::set(var_def2a519);
		level flag::set(var_ce6f7a4c);
		function_f18e2775();
		level.var_c22016cf++;
		level thread function_7590a833();
	#/
}

/*
	Name: function_883e88be
	Namespace: namespace_2ea65b04
	Checksum: 0xDDC3FBDF
	Offset: 0x5840
	Size: 0x1D2
	Parameters: 1
	Flags: None
*/
function function_883e88be(str_enemy)
{
	/#
		level.var_4118581a = 1;
		switch(str_enemy)
		{
			case "destroyers":
			{
				level.var_58e06b5b = #"destroyer";
				level.var_b941799e = #"destroyer";
				level.var_34bb868f = #"destroyer";
				level.var_c90f6df9 = #"destroyer";
				iprintlnbold("");
				break;
			}
			case "marauders":
			{
				level.var_58e06b5b = #"marauder";
				level.var_b941799e = #"marauder";
				level.var_34bb868f = #"marauder";
				level.var_c90f6df9 = #"marauder";
				iprintlnbold("");
				break;
			}
			case "tigers":
			{
				level.var_58e06b5b = #"tigers";
				level.var_b941799e = #"tigers";
				level.var_34bb868f = #"tigers";
				level.var_c90f6df9 = #"tigers";
				iprintlnbold("");
				break;
			}
		}
	#/
}

