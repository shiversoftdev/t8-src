// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_transformation.gsc;
#using scripts\zm\zm_zodt8_eye.gsc;
#using scripts\zm_common\zm_fasttravel.gsc;
#using script_3e5ec44cfab7a201;
#using scripts\zm\ai\zm_ai_stoker.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_round_spawning.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using scripts\zm_common\zm_characters.gsc;
#using script_db06eb511bd9b36;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_zodt8.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_challenges.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_74905749;

/*
	Name: init
	Namespace: namespace_74905749
	Checksum: 0xDE6BA4C3
	Offset: 0xCC8
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_fx();
	init_clientfields();
	init_flags();
	function_3335f286();
	function_91be5845();
	function_4e7d0566();
	function_5659cbef();
	function_c1a4b575();
	level thread function_b2901ae4();
	if(zm_utility::function_e51dc2d8())
	{
		zm_sq::start(#"main_quest");
	}
}

/*
	Name: init_fx
	Namespace: namespace_74905749
	Checksum: 0xB7FE0485
	Offset: 0xDA0
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_41a5c5168ffb2a97"] = #"hash_7b0d80c48289dd0b";
	level._effect[#"hash_400a481490a4e390"] = #"hash_29138c752c86a486";
	level._effect[#"hash_5562e324d230f057"] = #"hash_495fc19edc59bb4e";
	level._effect[#"hash_41fae186552f1259"] = #"hash_22decafaaa11e437";
	level._effect[#"freezing_mist"] = #"hash_7379a044e62d65f";
}

/*
	Name: init_clientfields
	Namespace: namespace_74905749
	Checksum: 0xBBC53462
	Offset: 0xEA0
	Size: 0x674
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "" + #"hash_3c58464f16d8a1be", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"essence_fx", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"land_fx", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"planet_light", 1, getminbitcountfornum(9), "int");
	clientfield::register("scriptmover", "" + #"planet_fx", 1, getminbitcountfornum(9), "int");
	clientfield::register("scriptmover", "" + #"pulse_shader", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"sentinel_shader", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_3400ccffbd3d73b3", 1, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_15b23de7589e61a", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"blocker_fx", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_68e2384b254175da", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"pipe_fx", 1, 2, "int");
	clientfield::register("scriptmover", "" + #"teleport_sigil", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_46e2ed49fb0f55c6", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"water_props", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_6e41de51a0092771", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_53c7d27cc9130e8f", 1, getminbitcountfornum(4), "int");
	clientfield::register("toplayer", "" + #"boiler_fx", 1, 1, "int");
	clientfield::register("toplayer", "" + #"main_flash", 1, 1, "int");
	clientfield::register("toplayer", "" + #"iceberg_rumbles", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_7a927551ca199a1c", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"icy_bubbles", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_58b44c320123e829", 1, 1, "int");
	clientfield::register("toplayer", "" + #"camera_snow", 1, 1, "int");
	clientfield::register("vehicle", "" + #"orb_fx", 1, 1, "int");
}

/*
	Name: init_flags
	Namespace: namespace_74905749
	Checksum: 0xD0538E22
	Offset: 0x1520
	Size: 0x2E4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_2d1cd18f39ac5fa7");
	level flag::init(#"hash_515a88d1cbabc18e");
	level flag::init(#"hash_1322dd3a3d7411a5");
	level flag::init(#"hash_2f5be8d749b4e88e");
	level flag::init(#"hash_33a5d8dd1204080e");
	level flag::init(#"hash_652ae68711aa37c1");
	level flag::init(#"hash_63ebf7fc2afa76ea");
	level flag::init(#"hash_70eb07a177cf8881");
	level flag::init(#"hash_65e37079e0d22d47");
	level flag::init(#"hash_2d91883efdb2893f");
	level flag::init(#"hash_7a31252c7c941976");
	level flag::init(#"hash_27a2746eb30e61c");
	level flag::init(#"hash_3e80d503318a5674");
	level flag::init(#"hash_452df3df817c57f9");
	level flag::init(#"hash_63a102a7ae564e99");
	level flag::init(#"hash_220b149fa209b3e8");
	level flag::init(#"hash_76dd603f61fa542d");
	level flag::init(#"hash_77f76266b597a1f7");
	level flag::init(#"hash_7494610e7bd95c34");
	level flag::init(#"hash_1a742576c41a0ab9");
	level flag::init(#"hash_767ce45fce848b88");
	level flag::init(#"hash_349bc60cedc7491e");
	level flag::init(#"hash_280d10a2ac060edb");
}

/*
	Name: function_3335f286
	Namespace: namespace_74905749
	Checksum: 0x2BE94F13
	Offset: 0x1810
	Size: 0x3D4
	Parameters: 0
	Flags: Linked
*/
function function_3335f286()
{
	zm_sq::register(#"main_quest", #"step_1", #"main_quest_step_1", &function_e3163424, &function_c4bd3743);
	zm_sq::register(#"main_quest", #"step_2", #"main_quest_step_2", &function_fbba6b79, &function_eb027eca);
	zm_sq::register(#"main_quest", #"step_3", #"main_quest_step_3", &function_558b4527, &function_34f97128);
	zm_sq::register(#"main_quest", #"step_4", #"main_quest_step_4", &function_73a32bb4, &function_ba182aaa);
	zm_sq::register(#"main_quest", #"step_5", #"main_quest_step_5", &function_1b44fb7f, &function_92cd9426);
	zm_sq::register(#"main_quest", #"step_6", #"main_quest_step_6", &function_443b1ad2, &function_542127b2);
	zm_sq::register(#"main_quest", #"step_7", #"main_quest_step_7", &function_8ec70b18, &function_71a8bce1);
	zm_sq::register(#"main_quest", #"step_8", #"main_quest_step_8", &function_5b7a1511, &function_98cdd988);
	zm_sq::register(#"main_quest", #"step_9", #"main_quest_step_9", &function_f4b715c1, &function_b4d0381e);
	zm_sq::register(#"main_quest", #"outro_igc", #"main_quest_step_10", &function_594ebc75, &function_60d50c62, 1, &function_48837477);
}

/*
	Name: function_91be5845
	Namespace: namespace_74905749
	Checksum: 0x32AEAFFE
	Offset: 0x1BF0
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function function_91be5845()
{
	level.a_s_sparks = array::randomize(struct::get_array(#"hash_b29f24eab97a1d"));
	var_ffba1428 = array(#"hash_41a5c5168ffb2a97", #"hash_400a481490a4e390", #"hash_5562e324d230f057", #"hash_41fae186552f1259");
	while(level.a_s_sparks.size > var_ffba1428.size)
	{
		arrayremoveindex(level.a_s_sparks, 0, 0);
	}
	foreach(s_spark in level.a_s_sparks)
	{
		s_spark.script_noteworthy = var_ffba1428[0];
		arrayremovevalue(var_ffba1428, var_ffba1428[0], 0);
		namespace_617a54f4::function_d8383812(s_spark.script_noteworthy, 1, s_spark, &function_b6db8da0, &function_6ae57d29);
	}
	namespace_617a54f4::function_d8383812(#"hash_7182a46bb3cdf577", 1, #"hash_7182a46bb3cdf577", &function_36df874b, &function_800855df);
	namespace_617a54f4::function_d8383812(#"hash_466c2764cc790370", 1, #"hash_466c2764cc790370", &function_36df874b, &function_800855df);
	namespace_617a54f4::function_d8383812(#"hash_34f2b4c4f7d74137", 1, #"hash_34f2b4c4f7d74137", &function_36df874b, &function_800855df);
	namespace_617a54f4::function_d8383812(#"hash_49ad34a64ecaebb9", 1, #"hash_49ad34a64ecaebb9", &function_36df874b, &function_800855df);
}

/*
	Name: function_4e7d0566
	Namespace: namespace_74905749
	Checksum: 0xB104490B
	Offset: 0x1EE8
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_4e7d0566()
{
	a_blockers = getentarray("cat_script_blocker", "targetname");
	foreach(e_blocker in a_blockers)
	{
		e_blocker hide();
		e_blocker notsolid();
	}
}

/*
	Name: function_5659cbef
	Namespace: namespace_74905749
	Checksum: 0x67F827A6
	Offset: 0x1FA8
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_5659cbef()
{
	a_iceberg = getentarray("forget_what_you_know", "targetname");
	foreach(mdl in a_iceberg)
	{
		mdl hide();
	}
}

/*
	Name: function_b2901ae4
	Namespace: namespace_74905749
	Checksum: 0xA694DE3E
	Offset: 0x2050
	Size: 0x2CC
	Parameters: 0
	Flags: Linked
*/
function function_b2901ae4()
{
	var_7fcc8d39 = struct::get_array(#"s_telegraph");
	foreach(s_telegraph in var_7fcc8d39)
	{
		s_telegraph flag::init(s_telegraph.script_flag);
		s_telegraph zm_unitrigger::create(undefined, (64, 64, 72), &function_a025a65e, 1);
		zm_unitrigger::function_89380dda(s_telegraph.s_unitrigger, 1);
		s_telegraph thread function_c76f5e7f();
	}
	var_a1a864c9 = getentarray("mdl_short", "targetname");
	var_b64616b0 = getentarray("mdl_long", "targetname");
	foreach(var_e54375bf in var_a1a864c9)
	{
		var_e54375bf.original_angles = var_e54375bf.angles;
		var_e54375bf rotateroll(-350, 0.1);
	}
	foreach(var_52330a61 in var_b64616b0)
	{
		var_52330a61.original_angles = var_52330a61.angles;
		var_52330a61 rotateroll(-240, 0.1);
	}
	level waittill(#"start_zombie_round_logic");
	hidemiscmodels("bridge_controls");
}

/*
	Name: function_c1a4b575
	Namespace: namespace_74905749
	Checksum: 0x20F6779
	Offset: 0x2328
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_c1a4b575()
{
	var_5aa39ae9 = struct::get_array(#"planet_glyph", "script_noteworthy");
	foreach(s_loc in var_5aa39ae9)
	{
		s_loc.var_6eb21a54 = util::spawn_model(s_loc.model, s_loc.origin, s_loc.angles);
		s_loc.var_6eb21a54 setscale(0.666);
	}
}

/*
	Name: function_e3163424
	Namespace: namespace_74905749
	Checksum: 0x4EF09037
	Offset: 0x2428
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_e3163424(var_5ea5c94d)
{
	level flag::wait_till("all_players_spawned");
	foreach(player in util::get_players())
	{
		player thread function_e695466b();
	}
	level zm_ui_inventory::function_7df6bb60(#"hash_5d7e4ccce97334e0", 1);
	if(!var_5ea5c94d)
	{
		level flag::wait_till("power_on");
	}
}

/*
	Name: function_c4bd3743
	Namespace: namespace_74905749
	Checksum: 0x8DCAEA76
	Offset: 0x2528
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_c4bd3743(var_5ea5c94d, ended_early)
{
	level flag::set("power_on");
	level flag::set(#"hash_3e80d503318a5674");
	zm_utility::giveachievement_wrapper("ZM_ZODT8_TRIAL_STEP_1", 1);
}

/*
	Name: function_e695466b
	Namespace: namespace_74905749
	Checksum: 0x69BE59DF
	Offset: 0x25A8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_e695466b()
{
	self endon(#"entering_last_stand", #"death");
	self waittill(#"hash_3716659f7fa370ee");
	self zm_challenges::function_979f4cc0(#"hash_16aa183f2c51f999");
}

/*
	Name: function_48837477
	Namespace: namespace_74905749
	Checksum: 0x4164EE09
	Offset: 0x2610
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_48837477()
{
	self notify(#"hash_3716659f7fa370ee");
	self zm_challenges::function_9a9ab6f6(#"darkops_zod_ee");
}

/*
	Name: function_fbba6b79
	Namespace: namespace_74905749
	Checksum: 0x509D5E4
	Offset: 0x2650
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_fbba6b79(var_5ea5c94d)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_5d7e4ccce97334e0", 2);
	if(!var_5ea5c94d)
	{
		level flag::wait_till("pap_quest_complete");
	}
}

/*
	Name: function_eb027eca
	Namespace: namespace_74905749
	Checksum: 0xE6115524
	Offset: 0x26B8
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_eb027eca(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		if(isdefined(level.s_pap_quest))
		{
			level.s_pap_quest.var_4ee2e2ab = 0;
		}
	}
	if(!var_5ea5c94d)
	{
		playsoundatposition(#"hash_e0f3a75083de89a", (0, 0, 0));
	}
	level flag::set("pap_quest_complete");
}

/*
	Name: function_558b4527
	Namespace: namespace_74905749
	Checksum: 0x93F5E0
	Offset: 0x2758
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_558b4527(var_5ea5c94d)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_5d7e4ccce97334e0", 3);
	if(!var_5ea5c94d)
	{
		level.a_str_zones = array(#"bridge", #"grand_staircase", #"mail_rooms", #"hash_f434aec906b7c76", #"hash_5236cc7d71cc92b3", #"galley");
		/#
		#/
		function_bdf27083(#"hash_122c834b72722973");
		function_bdf27083(#"hash_1cd2e394d963233b");
		function_bdf27083(#"hash_2697e0e48c225c27");
		function_bdf27083(#"hash_154f3a12365359d");
		level flag::wait_till(#"hash_2d1cd18f39ac5fa7");
	}
}

/*
	Name: function_34f97128
	Namespace: namespace_74905749
	Checksum: 0xF17BBB1
	Offset: 0x28C0
	Size: 0x1AC
	Parameters: 2
	Flags: Linked
*/
function function_34f97128(var_5ea5c94d, ended_early)
{
	if(!var_5ea5c94d)
	{
		hidemiscmodels("bridge_controls");
		foreach(var_a18f792 in level.var_c08c55b8)
		{
			var_a18f792 delete();
		}
		level.var_c08c55b8 = undefined;
		playsoundatposition(#"hash_e0f3b75083dea4d", (0, 0, 0));
	}
	var_7fcc8d39 = struct::get_array(#"s_telegraph");
	foreach(s_telegraph in var_7fcc8d39)
	{
		zm_unitrigger::unregister_unitrigger(s_telegraph.s_unitrigger);
	}
	level.a_str_zones = undefined;
	level flag::set(#"hash_2d1cd18f39ac5fa7");
}

/*
	Name: function_bdf27083
	Namespace: namespace_74905749
	Checksum: 0xE8FCC617
	Offset: 0x2A78
	Size: 0x554
	Parameters: 1
	Flags: Linked
*/
function function_bdf27083(str_script_noteworthy)
{
	n_index = randomint(level.a_str_zones.size);
	str_zone = level.a_str_zones[n_index];
	arrayremoveindex(level.a_str_zones, n_index);
	var_c0028c4a = struct::get(str_script_noteworthy, "script_noteworthy");
	var_52c5bb4 = struct::get(var_c0028c4a.var_46f0b81a, "script_noteworthy");
	var_c0028c4a.var_d0b3106f = function_23153807(var_c0028c4a);
	var_52c5bb4.var_d0b3106f = function_23153807(var_52c5bb4);
	while(var_52c5bb4.var_d0b3106f == 11 && var_c0028c4a.var_d0b3106f == 8)
	{
		var_52c5bb4.var_d0b3106f = 8;
		var_c0028c4a.var_d0b3106f = 11;
	}
	var_a1a864c9 = getentarray("mdl_short", "targetname");
	var_b64616b0 = getentarray("mdl_long", "targetname");
	foreach(var_e54375bf in var_a1a864c9)
	{
		if(isdefined(var_e54375bf.script_zone))
		{
			if(var_e54375bf.script_zone == str_zone)
			{
				var_e54375bf thread function_f4e792d3(var_52c5bb4.var_d0b3106f, -12, 0.166667);
			}
			continue;
		}
		/#
			assertmsg("");
		#/
	}
	foreach(var_52330a61 in var_b64616b0)
	{
		if(isdefined(var_52330a61.script_zone))
		{
			if(var_52330a61.script_zone == str_zone)
			{
				var_52330a61 thread function_f4e792d3(var_c0028c4a.var_d0b3106f, -120, 2);
			}
			continue;
		}
		/#
			assertmsg("");
		#/
	}
	var_c9a92ed0 = struct::get_array(var_c0028c4a.var_f8c16831, "script_noteworthy");
	foreach(var_e575d09e in var_c9a92ed0)
	{
		if(!isdefined(var_e575d09e.script_zone) || var_e575d09e.script_zone == str_zone)
		{
			var_a18f792 = util::spawn_model(var_e575d09e.model, var_e575d09e.origin, var_e575d09e.angles);
			if(!isdefined(level.var_c08c55b8))
			{
				level.var_c08c55b8 = [];
			}
			else if(!isarray(level.var_c08c55b8))
			{
				level.var_c08c55b8 = array(level.var_c08c55b8);
			}
			if(!isinarray(level.var_c08c55b8, var_a18f792))
			{
				level.var_c08c55b8[level.var_c08c55b8.size] = var_a18f792;
			}
			if(isdefined(var_e575d09e.scale))
			{
				var_a18f792 setscale(var_e575d09e.scale);
			}
		}
	}
	showmiscmodels("bridge_controls");
}

/*
	Name: function_f4e792d3
	Namespace: namespace_74905749
	Checksum: 0x1B71B132
	Offset: 0x2FD8
	Size: 0x314
	Parameters: 3
	Flags: Linked
*/
function function_f4e792d3(var_d0b3106f, var_b267963b, var_a761a549)
{
	n_angle = -30 * var_d0b3106f;
	self rotateroll(n_angle + var_b267963b, (0.5 * var_d0b3106f) + var_a761a549);
	self waittill(#"rotatedone");
	var_e23f4bd9 = combineangles(-1 * self.original_angles, self.angles);
	var_a3ea9bcc = var_e23f4bd9[2];
	while(var_a3ea9bcc >= 0)
	{
		var_a3ea9bcc = var_a3ea9bcc - 360;
	}
	while(var_a3ea9bcc < -360)
	{
		var_a3ea9bcc = var_a3ea9bcc + 360;
	}
	if(var_a3ea9bcc > (n_angle + 10) || var_a3ea9bcc < (n_angle - 10))
	{
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold((("" + self.script_zone) + "") + self.targetname);
				println((("" + self.script_zone) + "") + self.targetname);
			}
		#/
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold(("" + var_d0b3106f) + "");
				println(("" + var_d0b3106f) + "");
			}
		#/
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold(("" + (var_a3ea9bcc / -30)) + "");
				println(("" + (var_a3ea9bcc / -30)) + "");
			}
		#/
		self.angles = self.original_angles;
		self rotateroll(n_angle, 0.1);
	}
}

/*
	Name: function_23153807
	Namespace: namespace_74905749
	Checksum: 0x198797DE
	Offset: 0x32F8
	Size: 0x26E
	Parameters: 3
	Flags: Linked
*/
function function_23153807(s_telegraph, var_3d89d732 = s_telegraph.var_3d89d732, var_d0b3106f = undefined)
{
	if(s_telegraph.var_e9af6526 == 11)
	{
		if(!isdefined(var_d0b3106f))
		{
			var_d0b3106f = function_21a3a673(1, 10);
		}
		if(var_d0b3106f >= min(var_3d89d732, 6))
		{
			var_d0b3106f = var_d0b3106f + 1;
		}
		if(var_d0b3106f >= max(var_3d89d732, 6))
		{
			var_d0b3106f = var_d0b3106f + 1;
		}
	}
	else
	{
		if(s_telegraph.var_e9af6526 == 7)
		{
			if(!isdefined(var_d0b3106f))
			{
				var_d0b3106f = function_21a3a673(1, 6);
			}
			if(var_d0b3106f >= 4 || var_d0b3106f >= var_3d89d732)
			{
				if(var_3d89d732 <= 4)
				{
					var_d0b3106f = var_d0b3106f + 1;
					if(var_d0b3106f >= 4)
					{
						var_d0b3106f = var_d0b3106f + 5;
					}
				}
				else
				{
					var_d0b3106f = var_d0b3106f + 5;
					if(var_d0b3106f >= var_3d89d732)
					{
						var_d0b3106f = var_d0b3106f + 1;
					}
				}
			}
		}
		else if(s_telegraph.var_e9af6526 == 5)
		{
			if(!isdefined(var_d0b3106f))
			{
				var_d0b3106f = function_21a3a673(1, 4);
			}
			if(var_d0b3106f >= 3 || var_d0b3106f >= var_3d89d732)
			{
				if(var_3d89d732 <= 3)
				{
					var_d0b3106f = var_d0b3106f + 1;
					if(var_d0b3106f >= 3)
					{
						var_d0b3106f = var_d0b3106f + 7;
					}
				}
				else
				{
					var_d0b3106f = var_d0b3106f + 7;
					if(var_d0b3106f >= var_3d89d732)
					{
						var_d0b3106f = var_d0b3106f + 1;
					}
				}
			}
		}
	}
	return var_d0b3106f;
}

/*
	Name: function_6361c85
	Namespace: namespace_74905749
	Checksum: 0x93F19605
	Offset: 0x3570
	Size: 0x2D4
	Parameters: 1
	Flags: Private
*/
function private function_6361c85(str_script_noteworthy)
{
	/#
		s_telegraph = struct::get(str_script_noteworthy, "");
		println("");
		println(s_telegraph.script_noteworthy);
		for(i = 1; i <= 12; i++)
		{
			if(s_telegraph.var_e9af6526 == 11 && (i < 6 || i > 6))
			{
				for(j = 1; j <= 10; j++)
				{
					s_telegraph.var_d0b3106f = function_23153807(s_telegraph, i, j);
					print(s_telegraph.var_d0b3106f + "");
				}
				println("");
				continue;
			}
			if(s_telegraph.var_e9af6526 == 7 && (i < 4 || i > 8))
			{
				for(j = 1; j <= 6; j++)
				{
					s_telegraph.var_d0b3106f = function_23153807(s_telegraph, i, j);
					print(s_telegraph.var_d0b3106f + "");
				}
				println("");
				continue;
			}
			if(s_telegraph.var_e9af6526 == 5 && (i < 3 || i > 9))
			{
				for(j = 1; j <= 4; j++)
				{
					s_telegraph.var_d0b3106f = function_23153807(s_telegraph, i, j);
					print(s_telegraph.var_d0b3106f + "");
				}
				println("");
			}
		}
		println("");
	#/
}

/*
	Name: function_a025a65e
	Namespace: namespace_74905749
	Checksum: 0xF4152F3A
	Offset: 0x3850
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_a025a65e()
{
	level endon(#"hash_2d1cd18f39ac5fa7", #"end_game");
	self endon(#"death");
	function_dae4ab9b(self, self.stub.related_parent.usetime);
	self zm_unitrigger::function_69168e61();
}

/*
	Name: function_c76f5e7f
	Namespace: namespace_74905749
	Checksum: 0x7CE421B4
	Offset: 0x38E0
	Size: 0x83C
	Parameters: 0
	Flags: Linked
*/
function function_c76f5e7f()
{
	level endon(#"hash_2d1cd18f39ac5fa7", #"end_game");
	self.var_3d89d732 = 12;
	if(isdefined(self.var_603d2311))
	{
		self.var_397be8a2 = getent(self.var_603d2311, "script_noteworthy");
	}
	else
	{
		/#
			assertmsg("" + self.script_noteworthy);
		#/
	}
	if(isdefined(self.var_319221a5))
	{
		self.var_b43ef4f9 = getent(self.var_319221a5, "script_noteworthy");
	}
	if(isdefined(self.var_f92ad94a))
	{
		self.var_3501cf51 = getent(self.var_f92ad94a, "script_noteworthy");
	}
	else
	{
		/#
			assertmsg("" + self.script_noteworthy);
		#/
	}
	if(isdefined(self.var_9913bb72))
	{
		self.var_9fb69ce = getent(self.var_9913bb72, "script_noteworthy");
	}
	var_52c5bb4 = struct::get(self.var_46f0b81a, "script_noteworthy");
	var_7fcc8d39 = struct::get_array(#"s_telegraph");
	var_14d5aa56 = getentarray(self.var_f8c16831, "script_noteworthy");
	if(self.script_noteworthy === #"hash_5db5a7e2cb1cab66" || self.script_noteworthy === #"hash_3f671b17f96b861a")
	{
		self thread function_bc253abc();
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger_activated");
		if(waitresult.e_who function_4a2a1b87(self))
		{
			var_54e61ab7 = 1;
			var_307456c0 = waitresult.e_who function_39b9ecb(self, self.var_397be8a2);
		}
		else
		{
			var_54e61ab7 = 0;
			var_307456c0 = waitresult.e_who function_39b9ecb(self, self.var_b43ef4f9);
		}
		if(var_54e61ab7 && var_307456c0 || (!var_54e61ab7 && !var_307456c0))
		{
			var_f583afd3 = self function_3b0b73d9(1);
		}
		else
		{
			var_f583afd3 = self function_3b0b73d9(0);
		}
		if(var_f583afd3 != 0)
		{
			var_52c5bb4.var_3501cf51 rotatepitch(var_f583afd3, 0.1);
			var_52c5bb4.var_3501cf51 playsound(#"hash_27a4629b68e4d58f");
			if(isdefined(var_52c5bb4.var_9fb69ce))
			{
				var_52c5bb4.var_9fb69ce rotatepitch(-1 * var_f583afd3, 0.1);
			}
			self.var_397be8a2 rotatepitch(var_f583afd3, 0.1);
			self.var_397be8a2 playsound(#"hash_7bc6c78f3cf8d7da");
			if(isdefined(self.var_b43ef4f9))
			{
				self.var_b43ef4f9 rotatepitch(-1 * var_f583afd3, 0.1);
			}
			self.var_397be8a2 waittill(#"rotatedone");
			/#
				if(getdvarint(#"zm_debug_ee", 0))
				{
					if(isdefined(self.var_d0b3106f))
					{
						print3d(self.origin + (anglestoright(self.angles) * 24), "" + self.var_d0b3106f, (1, 1, 0), 1, 0.25, 100);
					}
				}
			#/
			if(isdefined(self.var_d0b3106f))
			{
				if(self.var_3d89d732 == self.var_d0b3106f)
				{
					self flag::set_val(self.script_flag, 1);
					if(var_52c5bb4 flag::get(var_52c5bb4.script_flag))
					{
						foreach(var_9e7c3935 in var_14d5aa56)
						{
							var_9e7c3935 flag::set_val(var_9e7c3935.script_flag, 1);
						}
					}
					var_be77f82e = 1;
					foreach(s_telegraph in var_7fcc8d39)
					{
						if(s_telegraph flag::get(s_telegraph.script_flag) == 0)
						{
							var_be77f82e = 0;
							break;
						}
					}
					if(var_be77f82e)
					{
						level flag::set(#"hash_2d1cd18f39ac5fa7");
					}
					else
					{
						/#
							iprintlnbold("" + self.script_noteworthy);
							println("" + self.script_noteworthy);
						#/
						if(getdvarint(#"hash_7919e37cd5d57659", 0))
						{
						}
					}
				}
				else if(self flag::get(self.script_flag))
				{
					self flag::set_val(self.script_flag, 0);
					if(var_52c5bb4 flag::get(var_52c5bb4.script_flag))
					{
						foreach(var_9e7c3935 in var_14d5aa56)
						{
							var_9e7c3935 flag::set_val(var_9e7c3935.script_flag, 0);
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_bc253abc
	Namespace: namespace_74905749
	Checksum: 0xDC8A5BE2
	Offset: 0x4128
	Size: 0x31A
	Parameters: 0
	Flags: Linked
*/
function function_bc253abc()
{
	level flagsys::wait_till(#"power_on");
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	var_ec2a4d18 = scene::get_active_scenes(#"p8_fxanim_zm_zod_sentinel_chaos_bundle");
	var_e0c609e3 = var_ec2a4d18[0];
	var_b62e2cca = var_e0c609e3.scene_ents[#"prop 3"];
	var_7349be2e = (self.script_noteworthy === #"hash_5db5a7e2cb1cab66" ? "chaos_tops_left_jnt" : "chaos_tops_right_jnt");
	self.var_3501cf51.var_9090fb06 = self.var_3501cf51.angles;
	self.var_9fb69ce.var_9090fb06 = self.var_9fb69ce.angles;
	self.var_397be8a2.var_9090fb06 = self.var_397be8a2.angles;
	self.var_b43ef4f9.var_9090fb06 = self.var_b43ef4f9.angles;
	self.var_3501cf51 linkto(var_b62e2cca, var_7349be2e);
	self.var_9fb69ce linkto(var_b62e2cca, var_7349be2e);
	self.var_397be8a2 linkto(var_b62e2cca, var_7349be2e);
	self.var_b43ef4f9 linkto(var_b62e2cca, var_7349be2e);
	level waittill(#"hash_332f0f61c1829f65");
	zm_unitrigger::register_static_unitrigger(self.s_unitrigger, &function_a025a65e);
	zm_unitrigger::function_89380dda(self.s_unitrigger, 1);
	self.var_3501cf51 unlink();
	self.var_9fb69ce unlink();
	self.var_397be8a2 unlink();
	self.var_b43ef4f9 unlink();
	self.var_3501cf51.angles = self.var_3501cf51.var_9090fb06;
	self.var_9fb69ce.angles = self.var_9fb69ce.var_9090fb06;
	self.var_397be8a2.angles = self.var_397be8a2.var_9090fb06;
	self.var_b43ef4f9.angles = self.var_b43ef4f9.var_9090fb06;
}

/*
	Name: function_4a2a1b87
	Namespace: namespace_74905749
	Checksum: 0xA4A085B3
	Offset: 0x4450
	Size: 0xA6
	Parameters: 1
	Flags: Linked
*/
function function_4a2a1b87(s_telegraph)
{
	if(!isdefined(s_telegraph.var_b43ef4f9))
	{
		return true;
	}
	v_delta = vectornormalize(self.origin - s_telegraph.origin);
	v_facing = anglestoforward(s_telegraph.angles);
	if(vectordot(v_delta, v_facing) >= 0)
	{
		return true;
	}
	return false;
}

/*
	Name: function_39b9ecb
	Namespace: namespace_74905749
	Checksum: 0x1EBFCACE
	Offset: 0x4500
	Size: 0x1C4
	Parameters: 2
	Flags: Linked
*/
function function_39b9ecb(s_telegraph, var_397be8a2)
{
	v_delta = vectornormalize(var_397be8a2.origin - self geteye());
	v_view = anglestoforward(self getplayerangles());
	v_cross = vectorcross(v_view, v_delta);
	var_35b81369 = vectordot(v_cross, anglestoup(var_397be8a2.angles));
	var_7c6b02a8 = vectordot(v_cross, (0, 0, 1));
	if(s_telegraph.var_3d89d732 < 6)
	{
		if(var_35b81369 >= 0 && var_7c6b02a8 >= 0)
		{
			return true;
		}
		return false;
	}
	if(s_telegraph.var_3d89d732 > 6 && s_telegraph.var_3d89d732 < 12)
	{
		if(var_35b81369 <= 0 && var_7c6b02a8 <= 0)
		{
			return false;
		}
		return true;
	}
	if(var_35b81369 >= 0)
	{
		return true;
	}
	return false;
}

/*
	Name: function_3b0b73d9
	Namespace: namespace_74905749
	Checksum: 0x43FCAB3F
	Offset: 0x46D0
	Size: 0x796
	Parameters: 1
	Flags: Linked
*/
function function_3b0b73d9(b_clockwise)
{
	if(b_clockwise)
	{
		if(self.var_e9af6526 == 11)
		{
			switch(self.var_3d89d732)
			{
				case 12:
				{
					var_f583afd3 = 23.75;
					self.var_3d89d732 = 1;
					break;
				}
				case 1:
				case 2:
				case 3:
				case 4:
				case 7:
				case 8:
				case 9:
				case 10:
				case 11:
				{
					var_f583afd3 = 23.75;
					self.var_3d89d732 = self.var_3d89d732 + 1;
					break;
				}
				case 5:
				{
					var_f583afd3 = 0;
					break;
				}
				default:
				{
					/#
						assertmsg("" + self.var_3d89d732);
					#/
					break;
				}
			}
		}
		else
		{
			if(self.var_e9af6526 == 7)
			{
				switch(self.var_3d89d732)
				{
					case 12:
					{
						var_f583afd3 = 34.25;
						self.var_3d89d732 = 1;
						break;
					}
					case 1:
					case 2:
					case 9:
					case 10:
					case 11:
					{
						var_f583afd3 = 34.25;
						self.var_3d89d732 = self.var_3d89d732 + 1;
						break;
					}
					case 3:
					{
						var_f583afd3 = 0;
						break;
					}
					default:
					{
						/#
							assertmsg("" + self.var_3d89d732);
						#/
						break;
					}
				}
			}
			else if(self.var_e9af6526 == 5)
			{
				switch(self.var_3d89d732)
				{
					case 12:
					{
						var_f583afd3 = 33.5;
						self.var_3d89d732 = 1;
						break;
					}
					case 1:
					case 10:
					case 11:
					{
						var_f583afd3 = 33.5;
						self.var_3d89d732 = self.var_3d89d732 + 1;
						break;
					}
					case 2:
					{
						var_f583afd3 = 0;
						break;
					}
					default:
					{
						/#
							assertmsg("" + self.var_3d89d732);
						#/
						break;
					}
				}
			}
		}
	}
	else
	{
		if(self.var_e9af6526 == 11)
		{
			switch(self.var_3d89d732)
			{
				case 1:
				{
					var_f583afd3 = 23.75 * -1;
					self.var_3d89d732 = 12;
					break;
				}
				case 2:
				case 3:
				case 4:
				case 5:
				case 8:
				case 9:
				case 10:
				case 11:
				case 12:
				{
					var_f583afd3 = 23.75 * -1;
					self.var_3d89d732 = self.var_3d89d732 - 1;
					break;
				}
				case 7:
				{
					var_f583afd3 = 0;
					break;
				}
				default:
				{
					/#
						assertmsg("" + self.var_3d89d732);
					#/
					break;
				}
			}
		}
		else
		{
			if(self.var_e9af6526 == 7)
			{
				switch(self.var_3d89d732)
				{
					case 1:
					{
						var_f583afd3 = 34.25 * -1;
						self.var_3d89d732 = 12;
						break;
					}
					case 2:
					case 3:
					case 10:
					case 11:
					case 12:
					{
						var_f583afd3 = 34.25 * -1;
						self.var_3d89d732 = self.var_3d89d732 - 1;
						break;
					}
					case 9:
					{
						var_f583afd3 = 0;
						break;
					}
					default:
					{
						/#
							assertmsg("" + self.var_3d89d732);
						#/
						break;
					}
				}
			}
			else if(self.var_e9af6526 == 5)
			{
				switch(self.var_3d89d732)
				{
					case 1:
					{
						var_f583afd3 = 33.5 * -1;
						self.var_3d89d732 = 12;
						break;
					}
					case 2:
					case 11:
					case 12:
					{
						var_f583afd3 = 33.5 * -1;
						self.var_3d89d732 = self.var_3d89d732 - 1;
						break;
					}
					case 10:
					{
						var_f583afd3 = 0;
						break;
					}
					default:
					{
						/#
							assertmsg("" + self.var_3d89d732);
						#/
						break;
					}
				}
			}
		}
	}
	return var_f583afd3;
}

/*
	Name: function_73a32bb4
	Namespace: namespace_74905749
	Checksum: 0xFE544110
	Offset: 0x4E70
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_73a32bb4(var_5ea5c94d)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_5d7e4ccce97334e0", 4);
	function_ce111e55();
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			gear_up(1, 0);
		}
	#/
	if(!var_5ea5c94d)
	{
		level thread function_40744a4();
		function_1c841015();
	}
}

/*
	Name: function_ba182aaa
	Namespace: namespace_74905749
	Checksum: 0xE8478485
	Offset: 0x4F30
	Size: 0x24C
	Parameters: 2
	Flags: Linked
*/
function function_ba182aaa(var_5ea5c94d, ended_early)
{
	level flag::set(#"hash_2d91883efdb2893f");
	level flag::set(#"hash_65e37079e0d22d47");
	level.var_8a64ef3a = undefined;
	level.var_c8de91e3 = undefined;
	if(!var_5ea5c94d)
	{
		playsoundatposition(#"hash_e0f3475083dde68", (0, 0, 0));
	}
	/#
		if(var_5ea5c94d || ended_early)
		{
			foreach(player in util::get_players())
			{
				player thread function_8b8eabba();
			}
			callback::on_spawned(&function_8b8eabba);
			hidemiscmodels("");
			showmiscmodels("");
		}
		if(ended_early)
		{
			namespace_617a54f4::function_2a94055d(#"hash_41a5c5168ffb2a97");
			namespace_617a54f4::function_2a94055d(#"hash_400a481490a4e390");
			namespace_617a54f4::function_2a94055d(#"hash_5562e324d230f057");
			namespace_617a54f4::function_2a94055d(#"hash_41fae186552f1259");
			level notify(#"hash_7b7d380d73a2ba58");
		}
	#/
	exploder::exploder("exp_lgt_boiler_overheat");
	exploder::exploder("exp_boiler_overheat");
}

/*
	Name: function_ce111e55
	Namespace: namespace_74905749
	Checksum: 0xBF6EEF65
	Offset: 0x5188
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_ce111e55()
{
	var_c1da220b = getent("zombie_spawn_1", "script_string");
	zm_transform::function_cfca77a7(var_c1da220b, #"transform1", &zm_ai_utility::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_corrosive_spawn_pre_split", "aib_vign_zm_zod_catalyst_corrosive_spawn_post_split");
	var_c1da220b = getent("zombie_spawn_2", "script_string");
	zm_transform::function_cfca77a7(var_c1da220b, #"transform2", &zm_ai_utility::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_water_spawn_pre_split", "aib_vign_zm_zod_catalyst_water_spawn_post_split");
	var_c1da220b = getent("zombie_spawn_3", "script_string");
	zm_transform::function_cfca77a7(var_c1da220b, #"transform3", &zm_ai_utility::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_electric_spawn_pre_split", "aib_vign_zm_zod_catalyst_electric_spawn_post_split");
	var_c1da220b = getent("zombie_spawn_4", "script_string");
	zm_transform::function_cfca77a7(var_c1da220b, #"transform4", &zm_ai_utility::function_db610082, 0, undefined, &function_724b3e30, "aib_vign_zm_zod_catalyst_plasma_spawn_pre_split", "aib_vign_zm_zod_catalyst_plasma_spawn_post_split");
}

/*
	Name: function_40744a4
	Namespace: namespace_74905749
	Checksum: 0xE88759CB
	Offset: 0x5360
	Size: 0x2D0
	Parameters: 0
	Flags: Linked
*/
function function_40744a4()
{
	while(zm_round_logic::get_round_number() < 9)
	{
		level waittill(#"start_of_round");
	}
	a_str_ids = array(#"transform1", #"transform2", #"transform3", #"transform4", #"transform1", #"transform2", #"transform3", #"transform4");
	while(!level flag::get(#"hash_2d91883efdb2893f"))
	{
		if(!zm_round_spawning::function_d0db51fc(#"stoker") && isdefined(level.var_1643d0d) && level.var_1643d0d.size == 1)
		{
			level waittill(#"hash_5d3012139f083ccb");
			waitframe(1);
			continue;
		}
		n_round = zm_round_logic::get_round_number();
		var_741bc064 = array::randomize(a_str_ids);
		for(i = 0; i < 3; i++)
		{
			arrayremoveindex(var_741bc064, 0, 0);
		}
		foreach(str_id in var_741bc064)
		{
			wait(randomintrange(11, 22));
			if(level flag::get(#"hash_7a31252c7c941976"))
			{
				break;
			}
			zm_transform::function_bdd8aba6(str_id);
		}
		if(n_round == zm_round_logic::get_round_number())
		{
			level waittill(#"start_of_round");
		}
	}
}

/*
	Name: function_1c841015
	Namespace: namespace_74905749
	Checksum: 0xFDCE1014
	Offset: 0x5638
	Size: 0x5FC
	Parameters: 0
	Flags: Linked
*/
function function_1c841015()
{
	/#
		level endon(#"hash_7b7d380d73a2ba58");
	#/
	a_flags = array(#"hash_515a88d1cbabc18e", #"hash_1322dd3a3d7411a5", #"hash_2f5be8d749b4e88e", #"hash_33a5d8dd1204080e");
	while(true)
	{
		foreach(s_spark in level.a_s_sparks)
		{
			level thread function_bcdb8fc4(s_spark);
			namespace_617a54f4::function_3f808d3d(s_spark.script_noteworthy);
		}
		foreach(str_flag in a_flags)
		{
			level flag::clear(str_flag);
		}
		s_result = level flag::wait_till_any(a_flags);
		if(isdefined(s_result) && s_result._notify !== #"hash_515a88d1cbabc18e")
		{
			function_3a730415(0);
			continue;
		}
		level flag::set(#"hash_652ae68711aa37c1");
		level flag::clear(#"hash_515a88d1cbabc18e");
		function_3a730415();
		s_result = level flag::wait_till_any(a_flags);
		if(isdefined(s_result) && s_result._notify !== #"hash_1322dd3a3d7411a5")
		{
			function_3a730415(0);
			continue;
		}
		level flag::set(#"hash_63ebf7fc2afa76ea");
		level flag::clear(#"hash_1322dd3a3d7411a5");
		function_3a730415();
		s_result = level flag::wait_till_any(a_flags);
		if(isdefined(s_result) && s_result._notify !== #"hash_2f5be8d749b4e88e")
		{
			function_3a730415(0);
			continue;
		}
		level flag::set(#"hash_70eb07a177cf8881");
		level flag::clear(#"hash_2f5be8d749b4e88e");
		function_3a730415();
		if(!level flag::get(#"water_drained_aft"))
		{
			level thread zm_zodt8::change_water_height_aft(1);
			level notify(#"hash_47d532bd5a3fa1f5");
		}
		s_result = level flag::wait_till_any(a_flags);
		if(isdefined(s_result) && s_result._notify !== #"hash_33a5d8dd1204080e")
		{
			function_3a730415(0);
			continue;
		}
		level flag::set(#"hash_65e37079e0d22d47");
		level flag::clear(#"hash_33a5d8dd1204080e");
		hidemiscmodels("coal_cold");
		hidemiscmodels("coal_warm");
		showmiscmodels("coal_hot");
		foreach(player in util::get_players())
		{
			player util::delay(3.5, "death", &function_8b8eabba);
		}
		callback::on_spawned(&function_8b8eabba);
		function_3a730415();
		level flag::wait_till(#"hash_3e80d503318a5674");
		level flag::set(#"hash_2d91883efdb2893f");
		break;
	}
}

/*
	Name: function_3a730415
	Namespace: namespace_74905749
	Checksum: 0x80201DAC
	Offset: 0x5C40
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_3a730415(b_success = 1)
{
	wait(3);
	music::setmusicstate("none");
	level.musicsystemoverride = 0;
	function_63a0f09e(b_success);
	wait(5);
	if(b_success)
	{
		wait(5);
	}
	zhide_heart();
}

/*
	Name: function_bcdb8fc4
	Namespace: namespace_74905749
	Checksum: 0x1A570287
	Offset: 0x5CD0
	Size: 0x1EE
	Parameters: 1
	Flags: Linked
*/
function function_bcdb8fc4(s_spark)
{
	s_spark notify(#"hash_20b1bfb7761ba3a2");
	s_spark endon(#"hash_20b1bfb7761ba3a2");
	level endon(s_spark.script_noteworthy + "_completed");
	str_alias = #"hash_73169d47085b2d";
	switch(s_spark.script_noteworthy)
	{
		case "hash_41a5c5168ffb2a97":
		{
			str_alias = #"hash_73169d47085b2d";
			break;
		}
		case "hash_400a481490a4e390":
		{
			str_alias = #"hash_3b2c49194741ffda";
			break;
		}
		case "hash_5562e324d230f057":
		{
			str_alias = #"hash_3e9d8c755fa909a5";
			break;
		}
		case "hash_41fae186552f1259":
		{
			str_alias = #"hash_3d879b8999812127";
			break;
		}
	}
	while(!level flag::get(#"hash_2d91883efdb2893f"))
	{
		if(!level flag::get(#"hash_27a2746eb30e61c") && s_spark.var_b7273b77 !== 1)
		{
			fx::play(s_spark.script_noteworthy, s_spark.origin, s_spark.angles, 1.5);
			playsoundatposition(str_alias, s_spark.origin);
		}
		wait(4);
	}
}

/*
	Name: function_b6db8da0
	Namespace: namespace_74905749
	Checksum: 0x75206761
	Offset: 0x5EC8
	Size: 0x156
	Parameters: 2
	Flags: Linked
*/
function function_b6db8da0(s_struct, ai_killed)
{
	if(level flag::get(#"hash_27a2746eb30e61c"))
	{
		return false;
	}
	switch(s_struct.script_noteworthy)
	{
		case "hash_41a5c5168ffb2a97":
		{
			if(ai_killed.catalyst_type === 1)
			{
				break;
			}
			return false;
		}
		case "hash_400a481490a4e390":
		{
			if(ai_killed.catalyst_type === 4)
			{
				break;
			}
			return false;
		}
		case "hash_5562e324d230f057":
		{
			if(ai_killed.catalyst_type === 3)
			{
				break;
			}
			return false;
		}
		case "hash_41fae186552f1259":
		{
			if(ai_killed.catalyst_type === 2)
			{
				break;
			}
			return false;
		}
	}
	e_volume = getent(s_struct.target, "targetname");
	if(ai_killed istouching(e_volume))
	{
		return true;
	}
	return false;
}

/*
	Name: function_6ae57d29
	Namespace: namespace_74905749
	Checksum: 0x3C8BE720
	Offset: 0x6028
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function function_6ae57d29(s_struct, ai_killed)
{
	level thread function_3965c201(s_struct);
}

/*
	Name: function_3965c201
	Namespace: namespace_74905749
	Checksum: 0x91F074E1
	Offset: 0x6060
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_3965c201(s_struct)
{
	namespace_617a54f4::function_2a94055d(s_struct.script_noteworthy);
	level flag::set(#"hash_27a2746eb30e61c");
	util::delay("end_of_round", undefined, &flag::clear, #"hash_27a2746eb30e61c");
	s_portal = struct::get(s_struct.target);
	streamermodelhint(#"p8_zm_zod_teleport_symbol", 10);
	streamermodelhint(#"hash_15e8ba772c745d63", 10);
	wait(3);
	level thread function_4d356dc0(s_struct, s_portal);
	level thread function_8a0679e4(s_struct, s_portal);
}

/*
	Name: function_4d356dc0
	Namespace: namespace_74905749
	Checksum: 0xCA27636F
	Offset: 0x6198
	Size: 0x21C
	Parameters: 2
	Flags: Linked
*/
function function_4d356dc0(s_struct, s_portal)
{
	s_struct.var_b7273b77 = 1;
	v_offset = vectorscale((0, 0, 1), 2);
	n_scale = 0.1;
	mdl_portal = util::spawn_model(#"hash_15e8ba772c745d63", s_portal.origin + v_offset, s_portal.angles);
	s_portal.mdl_portal = mdl_portal;
	mdl_portal playsound(#"hash_2333d58ae8bcec49");
	mdl_portal playloopsound(#"hash_7519aa807bfee90f");
	while(n_scale < 1)
	{
		mdl_portal setscale(n_scale);
		wait(0.1);
		n_scale = n_scale + 0.05;
	}
	mdl_portal bobbing((0, 0, 1), 0.5, 5);
	mdl_portal.var_22763205 = 1;
	level thread function_d4b31d36(s_portal.origin, #"hash_19fca744d8d369fa");
	while(s_struct.var_b7273b77 == 1)
	{
		wait(2);
	}
	if(isdefined(mdl_portal))
	{
		mdl_portal stoploopsound();
		mdl_portal playsound(#"hash_10ab4113bd828143");
		mdl_portal ghost();
		wait(3);
		if(isdefined(mdl_portal))
		{
			mdl_portal delete();
		}
	}
}

/*
	Name: function_65880cbe
	Namespace: namespace_74905749
	Checksum: 0xAFDFBB20
	Offset: 0x63C0
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function function_65880cbe(a_s_valid_respawn_points)
{
	return level.var_bbef5923;
}

/*
	Name: function_8a0679e4
	Namespace: namespace_74905749
	Checksum: 0xA0CEF642
	Offset: 0x63E0
	Size: 0x4CC
	Parameters: 2
	Flags: Linked
*/
function function_8a0679e4(s_struct, s_portal)
{
	s_portal function_6099877a(64);
	if(!level flag::get(#"hash_3e80d503318a5674"))
	{
		level thread function_8a0679e4(s_struct, s_portal);
		return;
	}
	s_struct.var_b7273b77 = 0;
	level.disable_nuke_delay_spawning = 1;
	level notify(#"disable_nuke_delay_spawning");
	level flag::clear("spawn_zombies");
	level flag::clear("zombie_drop_powerups");
	level flag::set(#"hash_7a31252c7c941976");
	level flag::set(#"hash_1b9ecc7979b0fcfb");
	level flag::set(#"pause_round_timeout");
	zm_transform::function_e95ec8df();
	level.var_8a64ef3a = 0;
	level.zm_bgb_anywhere_but_here_validation_override = &return_false;
	level.var_bbef5923 = struct::get_array(s_struct.script_noteworthy, "script_teleport");
	level.var_eeb98313 = &function_65880cbe;
	level clientfield::set("fasttravel_exploder", 0);
	level thread function_43a16eb7(s_struct.script_noteworthy, s_portal);
	level waittill(#"hash_332a98e65f5dce4");
	function_999a6c5(s_struct.script_noteworthy, 1);
	s_powerup = struct::get(s_struct.script_noteworthy, "script_powerup");
	if(level.var_c8de91e3 !== 1)
	{
		if(isdefined(s_powerup))
		{
			powerup = zm_powerups::specific_powerup_drop("full_ammo", s_powerup.origin, undefined, undefined, undefined, 1);
			level.var_c8de91e3 = 1;
		}
	}
	else
	{
		level.var_c8de91e3 = 0;
	}
	function_77a859a8();
	level.musicsystemoverride = 1;
	music::setmusicstate("quest_catalyst_portals");
	level.var_88de5053 = 3;
	switch(s_struct.script_noteworthy)
	{
		case "hash_41a5c5168ffb2a97":
		{
			level thread function_ad0eee44("earth");
			function_e7615c8c();
			break;
		}
		case "hash_400a481490a4e390":
		{
			level thread function_ad0eee44("water");
			function_ab15557a();
			break;
		}
		case "hash_5562e324d230f057":
		{
			level thread function_ad0eee44("air");
			function_cacf191b();
			break;
		}
		case "hash_41fae186552f1259":
		{
			level thread function_ad0eee44("fire");
			function_818b63da();
			break;
		}
	}
	if(isdefined(powerup))
	{
		powerup thread zm_powerups::powerup_timeout();
	}
	wait(2.5);
	level.var_88de5053 = undefined;
	level.disable_nuke_delay_spawning = undefined;
	level.zm_bgb_anywhere_but_here_validation_override = &zm_zodt8::function_3910bef9;
	level.var_eeb98313 = undefined;
	level.var_bbef5923 = undefined;
	function_999a6c5(s_struct.script_noteworthy, 0);
}

/*
	Name: return_false
	Namespace: namespace_74905749
	Checksum: 0x9EBC34DD
	Offset: 0x68B8
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function return_false(player)
{
	return false;
}

/*
	Name: zhide_heart
	Namespace: namespace_74905749
	Checksum: 0xABC0AE59
	Offset: 0x68D0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function zhide_heart()
{
	level flag::set("spawn_zombies");
	level flag::set("zombie_drop_powerups");
	level flag::clear(#"hash_7a31252c7c941976");
	level flag::clear(#"hash_1b9ecc7979b0fcfb");
	level flag::clear(#"pause_round_timeout");
	level clientfield::set("fasttravel_exploder", 1);
}

/*
	Name: function_999a6c5
	Namespace: namespace_74905749
	Checksum: 0xFB84D397
	Offset: 0x69A0
	Size: 0x44E
	Parameters: 2
	Flags: Linked
*/
function function_999a6c5(var_e02e0cce, b_solid)
{
	switch(var_e02e0cce)
	{
		case "hash_41a5c5168ffb2a97":
		{
			var_da816ebe = "loc1";
			break;
		}
		case "hash_400a481490a4e390":
		{
			var_da816ebe = "loc2";
			break;
		}
		case "hash_5562e324d230f057":
		{
			var_da816ebe = "loc3";
			break;
		}
		case "hash_41fae186552f1259":
		{
			var_da816ebe = "loc4";
			break;
		}
	}
	a_blockers = getentarray(var_da816ebe, "script_blocker");
	if(b_solid)
	{
		foreach(e_blocker in a_blockers)
		{
			e_blocker solid();
			e_blocker show();
		}
		e_blocker.var_c2a873f6 = [];
		a_s_fx = struct::get_array(var_da816ebe, "script_blocker_fx");
		foreach(s_fx in a_s_fx)
		{
			mdl_fx = util::spawn_model(#"p8_zm_power_door_symbol_01", s_fx.origin, s_fx.angles);
			mdl_fx.objectid = "symbol_front_power";
			mdl_fx clientfield::set("" + #"blocker_fx", 1);
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
					mdl_fx thread function_73145dbe();
					mdl_fx clientfield::set("" + #"blocker_fx", 0);
				}
				e_blocker.var_c2a873f6 = undefined;
			}
		}
	}
}

/*
	Name: function_73145dbe
	Namespace: namespace_74905749
	Checksum: 0x7A2ED7C3
	Offset: 0x6DF8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_73145dbe()
{
	self clientfield::set("doorbuy_bought_fx", 1);
	util::wait_network_frame();
	self clientfield::set("doorbuy_ambient_fx", 0);
	util::wait_network_frame();
	self delete();
}

/*
	Name: function_e7615c8c
	Namespace: namespace_74905749
	Checksum: 0x989CC5C5
	Offset: 0x6E80
	Size: 0x2C4
	Parameters: 0
	Flags: Linked
*/
function function_e7615c8c()
{
	wait(2.5);
	n_players = util::get_active_players().size;
	var_6bf3abcf = (26 + (n_players * 12)) / 3;
	n_spawn_delay = 1.25 / n_players;
	n_max_zombies = 12 + (n_players * 3);
	a_spawnpoints = struct::get_array(#"hash_62b6792c95a50741");
	function_a5946754(a_spawnpoints, var_6bf3abcf, undefined, 20, #"transform1", n_spawn_delay);
	level thread spawn_blightfather();
	function_a5946754(a_spawnpoints, var_6bf3abcf, undefined, 20 + 5, #"transform1", n_spawn_delay / 2);
	wait(8 / n_players);
	spawner = array::random(level.zombie_spawners);
	n_players = util::get_active_players().size;
	var_475e440c = 12 / n_players;
	var_8e350fd9 = 0;
	var_70a7fbc3 = 0;
	for(i = 0; i < n_players; i++)
	{
		ai_blightfather = spawn_blightfather();
		if(isdefined(ai_blightfather))
		{
			if(!var_70a7fbc3)
			{
				var_70a7fbc3 = 1;
				level thread function_a5946754(a_spawnpoints, var_6bf3abcf, undefined, 20, #"transform1", n_spawn_delay);
			}
			var_8e350fd9++;
			ai_blightfather waittilltimeout(var_475e440c * var_8e350fd9, #"death");
		}
	}
	level notify(#"hash_215a84542b11208c");
	function_b9af308b();
	level flag::set(#"hash_515a88d1cbabc18e");
}

/*
	Name: function_ab15557a
	Namespace: namespace_74905749
	Checksum: 0x1DF3D413
	Offset: 0x7150
	Size: 0x27C
	Parameters: 0
	Flags: Linked
*/
function function_ab15557a()
{
	wait(5);
	if(level flag::get("water_drained_fore"))
	{
		var_86cf0c94 = 1;
		util::delay(10, undefined, &zm_zodt8::change_water_height_fore, 0);
	}
	a_spawnpoints = arraycombine(struct::get_array("zone_cargo_spawns"), struct::get_array(#"hash_17233d37983e8ef3"), 0, 0);
	a_spawnpoints = function_8046369(a_spawnpoints);
	n_players = util::get_active_players().size;
	n_spawns = 28 + (n_players * 16);
	n_max_active = 14 + (n_players * 2.5);
	n_spawn_delay = 1 / n_players;
	function_a5946754(a_spawnpoints, n_spawns * 0.6, n_max_active, 15, #"transform2", n_spawn_delay);
	wait(4);
	level thread spawn_blightfather();
	function_a5946754(a_spawnpoints, n_spawns * 0.4, n_max_active, 15, #"transform2", n_spawn_delay * 0.6);
	level notify(#"hash_215a84542b11208c");
	if(n_players > 2)
	{
		level thread spawn_blightfather();
	}
	function_b9af308b();
	if(var_86cf0c94 === 1)
	{
		level thread zm_zodt8::change_water_height_fore(1);
	}
	level flag::set(#"hash_1322dd3a3d7411a5");
}

/*
	Name: function_cacf191b
	Namespace: namespace_74905749
	Checksum: 0x7AEBF139
	Offset: 0x73D8
	Size: 0x2F4
	Parameters: 0
	Flags: Linked
*/
function function_cacf191b()
{
	wait(1);
	n_players = util::get_active_players().size;
	var_d8036031 = 36 + (n_players * 12);
	var_e8711f44 = 16 + (n_players * 2);
	n_spawn_delay = 0.75 / n_players;
	a_spawnpoints = arraycombine(struct::get_array(#"hash_2ddf7f822f34714f"), struct::get_array(#"hash_1e415296e149d2fb"), 0, 0);
	a_spawnpoints = arraycombine(a_spawnpoints, struct::get_array(#"hash_64e18832c1d29752"), 0, 0);
	a_spawnpoints = function_8046369(a_spawnpoints);
	util::delay(5, #"hash_2f5be8d749b4e88e", &spawn_blightfather);
	if(n_players > 2)
	{
		util::delay(10, #"hash_2f5be8d749b4e88e", &spawn_blightfather);
	}
	function_a5946754(a_spawnpoints, var_d8036031 / 2, var_e8711f44, 40, #"transform3", n_spawn_delay, array(10, 15));
	wait(8 / n_players);
	if(n_players > 3)
	{
		level thread spawn_blightfather();
	}
	function_a5946754(a_spawnpoints, var_d8036031 / 2, var_e8711f44, 40, #"transform3", n_spawn_delay / 2, array(5, 10));
	level thread spawn_blightfather();
	level notify(#"hash_215a84542b11208c");
	function_b9af308b();
	level flag::set(#"hash_2f5be8d749b4e88e");
}

/*
	Name: function_818b63da
	Namespace: namespace_74905749
	Checksum: 0x97608FC
	Offset: 0x76D8
	Size: 0x39C
	Parameters: 0
	Flags: Linked
*/
function function_818b63da()
{
	wait(3);
	var_bb492495 = struct::get_array(#"stoker_spawn");
	a_spawnpoints = struct::get_array(#"hash_1ee3c805146f5ec4", "script_encounter");
	var_feee5228 = 0;
	n_players = util::get_active_players().size;
	n_stokers = max(4, n_players * 2.5);
	var_36f58c64 = n_players + (n_players / 2);
	n_delay = 25;
	var_585c95aa = (n_players + 1) * 6;
	var_70050170 = 1 / n_players;
	ai_stoker = undefined;
	n_round = max(level.round_number, 15);
	while(var_feee5228 < n_stokers)
	{
		a_stokers = [];
		foreach(s_spawnpoint in var_bb492495)
		{
			while(!isdefined(ai_stoker))
			{
				ai_stoker = zm_ai_stoker::spawn_single(1, s_spawnpoint, n_round);
				waitframe(1);
			}
			if(!isdefined(a_stokers))
			{
				a_stokers = [];
			}
			else if(!isarray(a_stokers))
			{
				a_stokers = array(a_stokers);
			}
			a_stokers[a_stokers.size] = ai_stoker;
			ai_stoker.var_12745932 = 1;
			var_feee5228++;
			ai_stoker = undefined;
			if(a_stokers.size >= var_36f58c64)
			{
				break;
			}
			wait(randomfloat(1));
		}
		if(var_feee5228 >= (n_stokers / 2))
		{
			function_a5946754(a_spawnpoints, var_585c95aa, undefined, 25, #"transform4", var_70050170, array(5, 10));
		}
		function_1eaaceab(a_stokers, 0);
		if(a_stokers.size)
		{
			array::wait_till(a_stokers, "death", n_delay);
		}
		n_delay = n_delay - 5;
	}
	level notify(#"hash_215a84542b11208c");
	function_b9af308b();
	level flag::set(#"hash_33a5d8dd1204080e");
}

/*
	Name: function_ad0eee44
	Namespace: namespace_74905749
	Checksum: 0xC4C52B0
	Offset: 0x7A80
	Size: 0x5F4
	Parameters: 1
	Flags: Linked
*/
function function_ad0eee44(var_ac81ee88)
{
	namespace_617a54f4::function_3f808d3d(#"hash_34f827c2750a5a25" + var_ac81ee88);
	s_artifact = struct::get(#"hash_34f827c2750a5a25" + var_ac81ee88);
	s_moveto = struct::get(s_artifact.target);
	level flag::clear(#"hash_3e80d503318a5674");
	mdl_artifact = util::spawn_model(#"hash_12eedcc89df28c41", s_artifact.origin, s_artifact.angles);
	mdl_artifact notsolid();
	mdl_artifact setscale(1.25);
	mdl_artifact playloopsound(#"hash_5c7e9911ac98f633");
	if(isdefined(s_moveto))
	{
		wait(4);
		v_offset = vectorscale((0, 0, -1), 16);
		mdl_artifact moveto(s_moveto.origin + v_offset, 6, 1, 1);
		mdl_artifact waittill(#"movedone");
		if(s_artifact.angles != s_moveto.angles)
		{
			mdl_artifact rotateto(s_moveto.angles, 1);
			mdl_artifact waittill(#"rotatedone");
		}
		waitframe(1);
	}
	mdl_artifact bobbing((0, 0, 1), 2, 3);
	level flag::wait_till(#"hash_317170e3689d18aa" + var_ac81ee88);
	namespace_617a54f4::function_2a94055d(#"hash_34f827c2750a5a25" + var_ac81ee88);
	waitframe(1);
	if(level flag::get((#"hash_511653209a0c8cc5" + var_ac81ee88) + "_completed"))
	{
		switch(var_ac81ee88)
		{
			case "earth":
			{
				mdl_artifact clientfield::set("" + #"hash_53c7d27cc9130e8f", 1);
				break;
			}
			case "water":
			{
				mdl_artifact clientfield::set("" + #"hash_53c7d27cc9130e8f", 2);
				break;
			}
			case "air":
			{
				mdl_artifact clientfield::set("" + #"hash_53c7d27cc9130e8f", 3);
				break;
			}
			case "fire":
			{
				mdl_artifact clientfield::set("" + #"hash_53c7d27cc9130e8f", 4);
				break;
			}
		}
		wait(4);
		if(var_ac81ee88 == #"fire")
		{
			mdl_artifact setmodel(#"hash_2b14d34cb1bc161a");
			mdl_artifact playloopsound(#"hash_66df9cab2c64f968");
		}
		wait(2.5);
		mdl_artifact moveto(s_artifact.origin, 2.5, 1, 1);
		mdl_artifact waittill(#"movedone");
		mdl_artifact bobbing((0, 0, 1), 0.5, 5);
		player = s_artifact zm_unitrigger::function_fac87205(#"hash_14754dac7b0290c6");
		if(var_ac81ee88 == #"fire")
		{
			mdl_artifact playsound(#"hash_58d1c989a1ea4137");
			level thread function_53802e89(#"hash_74cb038c7565ddc9", mdl_artifact.origin, array(1, 3, 2, 4));
		}
		else
		{
			mdl_artifact playsound(#"hash_5de064f33e9e49b8");
		}
	}
	level flag::set(#"hash_3e80d503318a5674");
	mdl_artifact delete();
}

/*
	Name: function_36df874b
	Namespace: namespace_74905749
	Checksum: 0xEF037D57
	Offset: 0x8080
	Size: 0x7A
	Parameters: 2
	Flags: Linked
*/
function function_36df874b(s_struct, ai_killed)
{
	if(ai_killed.archetype === #"stoker" || ai_killed.archetype === #"blight_father" || ai_killed.archetype === #"catalyst")
	{
		return true;
	}
	return false;
}

/*
	Name: function_800855df
	Namespace: namespace_74905749
	Checksum: 0xB6367103
	Offset: 0x8108
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_800855df(s_struct, ai_killed)
{
}

/*
	Name: function_a5946754
	Namespace: namespace_74905749
	Checksum: 0x8A41A3C4
	Offset: 0x8128
	Size: 0x254
	Parameters: 7
	Flags: Linked
*/
function function_a5946754(a_spawnpoints, n_spawns, n_max_active = 24, var_4309d73b, var_e7c7eaab, n_spawn_delay = 0.1, var_70f72ba4 = 0.1)
{
	var_cbdd8fe5 = 0;
	var_7c332548 = arraycopy(a_spawnpoints);
	n_round_number = max(level.round_number, 15);
	while(var_cbdd8fe5 < n_spawns)
	{
		function_9c6147b1(n_max_active);
		spawner = array::random(level.zombie_spawners);
		s_spawnpoint = array::random(var_7c332548);
		ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, s_spawnpoint, n_round_number);
		if(isdefined(ai))
		{
			ai.b_ignore_cleanup = 1;
			ai.var_12745932 = 1;
			if(isarray(var_70f72ba4))
			{
				var_70f72ba4 = randomintrange(var_70f72ba4[0], var_70f72ba4[1]);
			}
			if(isdefined(var_e7c7eaab))
			{
				ai util::delay(var_70f72ba4, "death", &function_71d1696b, var_4309d73b, var_e7c7eaab);
			}
			var_cbdd8fe5++;
			arrayremovevalue(var_7c332548, s_spawnpoint, 0);
			wait(n_spawn_delay);
			if(!var_7c332548.size)
			{
				var_7c332548 = arraycopy(a_spawnpoints);
			}
		}
		else
		{
			waitframe(1);
		}
	}
}

/*
	Name: function_71d1696b
	Namespace: namespace_74905749
	Checksum: 0x27F3A02
	Offset: 0x8388
	Size: 0x128
	Parameters: 2
	Flags: Linked
*/
function function_71d1696b(var_6d630352, var_c0958d26)
{
	level endon(#"hash_215a84542b11208c", #"hash_349bc60cedc7491e");
	while(isalive(self) && isdefined(level.var_8a64ef3a))
	{
		n_enemies = getaiteamarray(level.zombie_team).size;
		if(n_enemies && ((level.var_8a64ef3a / n_enemies) * 100) < var_6d630352)
		{
			var_6c463143 = 1;
		}
		else
		{
			var_6c463143 = 0;
		}
		if(var_6c463143 && !zm_transform::function_abf1dcb4(var_c0958d26) && zm_ai_utility::function_db610082())
		{
			zm_transform::function_9acf76e6(self, var_c0958d26);
			return;
		}
		wait(3);
	}
}

/*
	Name: function_724b3e30
	Namespace: namespace_74905749
	Checksum: 0x34FC3D82
	Offset: 0x84B8
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_724b3e30(n_health)
{
	if(level flag::get(#"hash_7a31252c7c941976") || level flag::get(#"hash_767ce45fce848b88"))
	{
		self.b_ignore_cleanup = 1;
		self.var_12745932 = 1;
		level.var_8a64ef3a++;
		level thread function_83ad8f65(self);
		self thread function_fae5779();
	}
}

/*
	Name: function_fae5779
	Namespace: namespace_74905749
	Checksum: 0xD05D3E3
	Offset: 0x8570
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_fae5779()
{
	self endon(#"death");
	waitframe(1);
	if(self.catalyst_type == 1)
	{
		self zombie_utility::set_zombie_run_cycle("sprint");
	}
	else
	{
		self zombie_utility::set_zombie_run_cycle("run");
	}
}

/*
	Name: function_83ad8f65
	Namespace: namespace_74905749
	Checksum: 0xFB044193
	Offset: 0x85E8
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function function_83ad8f65(ai)
{
	ai waittill(#"death");
	if(isdefined(level.var_8a64ef3a))
	{
		level.var_8a64ef3a--;
	}
}

/*
	Name: spawn_blightfather
	Namespace: namespace_74905749
	Checksum: 0xC8D0BB7B
	Offset: 0x8638
	Size: 0x23E
	Parameters: 0
	Flags: Linked
*/
function spawn_blightfather()
{
	for(i = 0; i < 10; i++)
	{
		var_75c89236 = 0;
		var_3d5dc4ac = undefined;
		while(!isdefined(var_3d5dc4ac) && var_75c89236 < 10)
		{
			var_75c89236++;
			foreach(ai in getaiteamarray(level.zombie_team))
			{
				waitframe(1);
				if(ai zm_ai_utility::function_db610082())
				{
					var_3d5dc4ac = ai;
					break;
				}
			}
		}
		if(isalive(var_3d5dc4ac))
		{
			level.var_88de5053 = undefined;
			zm_transform::function_9acf76e6(var_3d5dc4ac, #"blight_father");
			level.var_88de5053 = 3;
			s_notify = function_660987e();
			if(isdefined(s_notify) && s_notify._notify === "transformation_complete" && isdefined(s_notify.var_944250d2[0]))
			{
				var_d10aa73b = s_notify.var_944250d2[0];
				var_d10aa73b.var_12745932 = 1;
				var_d10aa73b.b_ignore_cleanup = 1;
				var_d10aa73b ai::set_behavior_attribute("lockdown_enabled", 0);
				return s_notify.var_944250d2[0];
			}
			wait(1);
			continue;
		}
		wait(1);
	}
	return undefined;
}

/*
	Name: function_660987e
	Namespace: namespace_74905749
	Checksum: 0xCC05A96B
	Offset: 0x8880
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_660987e()
{
	if(isdefined(15))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(15, "timeout");
	}
	do
	{
		s_notify = undefined;
		s_notify = level waittill(#"transformation_complete", #"transformation_interrupted");
	}
	while(s_notify.id !== #"blight_father");
	return s_notify;
}

/*
	Name: function_8046369
	Namespace: namespace_74905749
	Checksum: 0x281E377A
	Offset: 0x8950
	Size: 0x132
	Parameters: 1
	Flags: Linked
*/
function function_8046369(a_spawnpoints)
{
	foreach(s_spawnpoint in a_spawnpoints)
	{
		if(s_spawnpoint.script_noteworthy === #"stoker_location" || s_spawnpoint.script_noteworthy === #"blight_father_location" || s_spawnpoint.script_noteworthy === #"wait_location" || s_spawnpoint.script_noteworthy === #"catalyst_location")
		{
			arrayremovevalue(a_spawnpoints, s_spawnpoint, 1);
		}
	}
	a_spawnpoints = array::remove_undefined(a_spawnpoints, 0);
	return a_spawnpoints;
}

/*
	Name: function_b9af308b
	Namespace: namespace_74905749
	Checksum: 0x497142E0
	Offset: 0x8A90
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_b9af308b()
{
	level notify(#"hash_4b6c2e61ca9a9e94");
	level endon(#"hash_20ba9a0874996fda", #"hash_4b6c2e61ca9a9e94");
	util::delay_notify(240, #"hash_20ba9a0874996fda", #"hash_4b6c2e61ca9a9e94");
	while(true)
	{
		wait(1);
		b_wait = 0;
		a_ai = getaiteamarray(level.zombie_team);
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
			return;
		}
	}
}

/*
	Name: function_9c6147b1
	Namespace: namespace_74905749
	Checksum: 0xFA7C054E
	Offset: 0x8BD8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_9c6147b1(n_max)
{
	while(getaiteamarray(level.zombie_team).size > int(n_max))
	{
		wait(0.1);
	}
}

/*
	Name: function_1b44fb7f
	Namespace: namespace_74905749
	Checksum: 0xE3AF0119
	Offset: 0x8C30
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_1b44fb7f(var_5ea5c94d)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_5d7e4ccce97334e0", 5);
	if(!var_5ea5c94d)
	{
		/#
			if(getdvarint(#"zm_debug_ee", 0) && !level flag::get(#"water_drained_aft"))
			{
				level thread zm_zodt8::change_water_height_aft(1);
			}
		#/
		function_e81d23de();
		function_22651585();
	}
}

/*
	Name: function_92cd9426
	Namespace: namespace_74905749
	Checksum: 0x463947E9
	Offset: 0x8D00
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_92cd9426(var_5ea5c94d, ended_early)
{
	if(!var_5ea5c94d)
	{
		level thread function_f8ec2dc1();
		playsoundatposition(#"hash_e0f3575083de01b", (0, 0, 0));
		if(ended_early)
		{
			level thread function_1f9c58bd();
		}
	}
	else
	{
		if(level flag::get(#"water_drained_fore"))
		{
			level flag::set(#"hash_76dd603f61fa542d");
		}
		else
		{
			level thread function_1f9c58bd();
		}
	}
}

/*
	Name: function_8b8eabba
	Namespace: namespace_74905749
	Checksum: 0x7C9D728E
	Offset: 0x8DE8
	Size: 0x1BC
	Parameters: 0
	Flags: Linked
*/
function function_8b8eabba()
{
	a_zones = array("zone_engine", "zone_boiler_room", "zone_turbine_room", "zone_upper_engine_room");
	self callback::on_death(&function_c6f820b8);
	while(isalive(self) && !level flag::get(#"hash_7494610e7bd95c34"))
	{
		if(!(isdefined(self.var_16735873) && self.var_16735873) && self.origin[2] < 500 && zm_zonemgr::is_player_in_zone(a_zones))
		{
			self clientfield::set_to_player("" + #"boiler_fx", 1);
		}
		else if(self clientfield::get_to_player("" + #"boiler_fx"))
		{
			self clientfield::set_to_player("" + #"boiler_fx", 0);
		}
		wait(0.5);
	}
	if(isdefined(self))
	{
		self clientfield::set_to_player("" + #"boiler_fx", 0);
	}
}

/*
	Name: function_c6f820b8
	Namespace: namespace_74905749
	Checksum: 0x7091F35E
	Offset: 0x8FB0
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_c6f820b8(params)
{
	if(isdefined(self))
	{
		self clientfield::set_to_player("" + #"boiler_fx", 0);
		self callback::remove_on_death(&function_c6f820b8);
	}
}

/*
	Name: function_e81d23de
	Namespace: namespace_74905749
	Checksum: 0xECD3B911
	Offset: 0x9018
	Size: 0x2DA
	Parameters: 0
	Flags: Linked
*/
function function_e81d23de()
{
	a_s_pipes = struct::get_array(#"hash_bf15c9f5060cda0");
	var_250390bc = [];
	foreach(s_pipe in a_s_pipes)
	{
		mdl_pipe = util::spawn_model("tag_origin", s_pipe.origin, s_pipe.angles);
		mdl_pipe clientfield::set("" + #"pipe_fx", 1);
		mdl_pipe thread function_9b60ef24();
		var_250390bc[var_250390bc.size] = mdl_pipe;
		waitframe(1);
	}
	array::wait_till(var_250390bc, #"hash_6ad372c0b5c6245a");
	level thread scene::stop("p8_fxanim_zm_zod_skybox_bundle");
	level thread scene::play("p8_fxanim_zm_zod_skybox_bundle", "event_impact");
	array::thread_all(var_250390bc, &function_e52c365d);
	array::thread_all(util::get_active_players(), &function_43602a86);
	level thread zm_zodt8::change_water_height_aft(0);
	level thread zm_zodt8::change_water_height_fore(0);
	level thread function_1f9c58bd();
	wait(5);
	if(isdefined(level.var_b67e1da6))
	{
		v_origin = level.var_b67e1da6.origin;
		level.var_b67e1da6 = undefined;
	}
	else
	{
		v_origin = s_pipe.origin;
	}
	level thread function_53802e89(#"hash_6a413b4d74b92971", v_origin, array(3, 4, 1, 2));
	wait(10);
}

/*
	Name: function_43602a86
	Namespace: namespace_74905749
	Checksum: 0x1071928B
	Offset: 0x9300
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_43602a86()
{
	self endon(#"death");
	__timeout__ = 10;
	var_a51f2d59 = gettime();
	do
	{
		if(!self isplayerunderwater() && self zm_zonemgr::is_player_in_zone("zone_turbine_room"))
		{
			self clientfield::set_to_player("water_drippies", 1);
		}
		else
		{
			self clientfield::set_to_player("water_drippies", 0);
		}
		wait(0.5);
	}
	while(!(__timeout__ >= 0 && (__timeout__ - ((float(gettime() - var_a51f2d59)) / 1000)) <= 0));
	self clientfield::set_to_player("water_drippies", 0);
}

/*
	Name: function_1f9c58bd
	Namespace: namespace_74905749
	Checksum: 0x2CB8ACA3
	Offset: 0x9428
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_1f9c58bd()
{
	level flag::wait_till_clear(#"water_drained_fore");
	zm_zodt8::function_ea9f953(1, 0);
	while(level.e_clip_water_fore.origin[2] > 580)
	{
		wait(0.2);
	}
	level flag::set(#"hash_76dd603f61fa542d");
}

/*
	Name: function_9b60ef24
	Namespace: namespace_74905749
	Checksum: 0x382E3045
	Offset: 0x94C0
	Size: 0x1D8
	Parameters: 0
	Flags: Linked
*/
function function_9b60ef24()
{
	wait(1);
	trigger = spawn("trigger_damage", self.origin, 0, 12, 24);
	var_542eec4d = getweapon(#"ww_tricannon_earth_t8");
	var_15b49ebc = getweapon(#"ww_tricannon_earth_t8_upgraded");
	while(true)
	{
		s_result = undefined;
		s_result = trigger waittill(#"trigger");
		if(isdefined(s_result.activator) && isplayer(s_result.activator))
		{
			w_weapon = s_result.activator getcurrentweapon();
			if(w_weapon == var_542eec4d || w_weapon == var_15b49ebc)
			{
				self notify(#"hash_6ad372c0b5c6245a");
				self clientfield::set("" + #"pipe_fx", 2);
				s_result.activator util::show_hit_marker(1);
				trigger delete();
				level.var_b67e1da6 = s_result.activator;
				return;
			}
		}
	}
}

/*
	Name: function_e52c365d
	Namespace: namespace_74905749
	Checksum: 0xBB02BE80
	Offset: 0x96A0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_e52c365d()
{
	self clientfield::set("" + #"pipe_fx", 0);
	wait(30);
	self delete();
}

/*
	Name: function_22651585
	Namespace: namespace_74905749
	Checksum: 0x5E8039CB
	Offset: 0x96F0
	Size: 0x48A
	Parameters: 0
	Flags: Linked
*/
function function_22651585()
{
	if(level.s_pap_quest.var_4ee2e2ab === 2 || level flag::get(#"hash_598d4e6af1cf4c39"))
	{
		level.var_25e38adf++;
	}
	else
	{
		level.s_pap_quest.var_e9b06709 = 2;
		level flag::set(#"hash_452df3df817c57f9");
		level.var_25e38adf = level.round_number + 1;
		level waittill(#"pap_moved");
		waitframe(1);
		level flag::clear(#"hash_452df3df817c57f9");
		level.s_pap_quest.var_e9b06709 = undefined;
	}
	var_bfa067ca = 0;
	while(var_bfa067ca !== 1)
	{
		var_bfa067ca = function_bdddfbe6();
	}
	v_spawn = level.pap_machine.origin + (0, -32, 40);
	mdl_artifact = util::spawn_model(#"hash_2b14d34cb1bc161a", v_spawn, vectorscale((0, -1, 0), 90));
	mdl_artifact notsolid();
	mdl_artifact playsound(#"hash_2d125a0883ae10c4");
	mdl_artifact playloopsound(#"hash_66df9cab2c64f968");
	mdl_artifact thread function_8d4d655d();
	mdl_artifact moveto(level.pap_machine.origin + (0, 2, 48), 3);
	mdl_artifact waittill(#"movedone");
	mdl_artifact setmodel(#"hash_3cdbd25e43a09930");
	wait(2.5);
	mdl_artifact playloopsound(#"hash_e2c71c7dece38ee");
	mdl_artifact clientfield::set("" + #"sentinel_shader", 1);
	mdl_artifact moveto(v_spawn, 3);
	mdl_artifact playsound(#"zmb_perks_packa_ready");
	wait(1.5);
	mdl_artifact playsound(#"hash_6bae336584399f4d");
	s_pickup = spawnstruct();
	s_pickup.origin = v_spawn;
	e_player = s_pickup zm_unitrigger::function_fac87205(#"hash_14754dac7b0290c6");
	level thread function_53802e89(#"hash_2e8d8d922535b1db", mdl_artifact.origin, array(3, 4, 1, 2));
	mdl_artifact playsound(#"hash_58d1c989a1ea4137");
	s_pickup struct::delete();
	mdl_artifact clientfield::set("" + #"sentinel_shader", 0);
	mdl_artifact delete();
	wait(2);
	level.pap_machine.unitrigger_stub.prompt_and_visibility_func = &zm_pap_util::update_hint_string;
}

/*
	Name: function_8d4d655d
	Namespace: namespace_74905749
	Checksum: 0x733356B2
	Offset: 0x9B88
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_8d4d655d()
{
	wait(2);
	self playsound(#"zmb_perks_packa_upgrade");
}

/*
	Name: function_bdddfbe6
	Namespace: namespace_74905749
	Checksum: 0x5447284
	Offset: 0x9BC0
	Size: 0x156
	Parameters: 0
	Flags: Linked
*/
function function_bdddfbe6()
{
	if(level.s_pap_quest.var_4ee2e2ab === 2)
	{
		level endon(#"pap_moved");
		level.pap_machine.unitrigger_stub.prompt_and_visibility_func = &return_false;
		s_stub = spawnstruct();
		s_stub.origin = level.pap_machine.origin;
		s_stub zm_unitrigger::create(#"hash_6b86bf43a35e502b", 96, &function_fb91462e);
		s_stub waittill(#"trigger_activated");
		zm_unitrigger::unregister_unitrigger(s_stub.s_unitrigger);
		s_stub struct::delete();
		return true;
	}
	level.pap_machine.unitrigger_stub.prompt_and_visibility_func = &zm_pap_util::update_hint_string;
	level waittill(#"pap_moved");
	return false;
}

/*
	Name: function_fb91462e
	Namespace: namespace_74905749
	Checksum: 0x1121D3CE
	Offset: 0x9D20
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_fb91462e()
{
	self endon(#"death", #"kill_trigger");
	self thread zm_unitrigger::function_69168e61();
	while(true)
	{
		level waittill(#"hash_14c80c5abb28b07b");
		if(!level flag::get(#"hash_598d4e6af1cf4c39"))
		{
			break;
		}
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self delete();
}

/*
	Name: function_f8ec2dc1
	Namespace: namespace_74905749
	Checksum: 0xB202C2DD
	Offset: 0x9DE0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_f8ec2dc1()
{
	level flag::wait_till_clear(#"water_drained_aft");
	zm_zodt8::function_ea9f953(0, 1);
}

/*
	Name: function_443b1ad2
	Namespace: namespace_74905749
	Checksum: 0x63E17F6
	Offset: 0x9E28
	Size: 0x2B4
	Parameters: 1
	Flags: Linked
*/
function function_443b1ad2(var_5ea5c94d)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_588e00046665bac6", 1);
	level zm_ui_inventory::function_7df6bb60(#"hash_5d7e4ccce97334e0", 6);
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			level flag::set(#"hash_76dd603f61fa542d");
		}
	#/
	if(!var_5ea5c94d)
	{
		foreach(player in util::get_active_players())
		{
			player thread function_53a78cbd();
		}
		callback::on_spawned(&function_53a78cbd);
		level.a_planets = [];
		level thread function_51054f59();
		function_9d73036a();
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				a_glyphs = struct::get_array(#"planet_glyph", "");
				foreach(s_glyph in a_glyphs)
				{
					waitframe(1);
					if(isdefined(s_glyph.s_unitrigger.trigger))
					{
						s_glyph.s_unitrigger.trigger notify(#"trigger");
					}
				}
			}
		#/
		level flag::wait_till(#"hash_63a102a7ae564e99");
		function_63ce4441();
	}
}

/*
	Name: function_542127b2
	Namespace: namespace_74905749
	Checksum: 0x1C4531A6
	Offset: 0xA0E8
	Size: 0x22C
	Parameters: 2
	Flags: Linked
*/
function function_542127b2(var_5ea5c94d, ended_early)
{
	if(!var_5ea5c94d)
	{
		callback::remove_on_spawned(&function_53a78cbd);
		playsoundatposition(#"hash_e0f3675083de1ce", (0, 0, 0));
	}
	callback::remove_on_spawned(&function_8b8eabba);
	hidemiscmodels("coal_hot");
	if(level flag::get("water_drained_aft"))
	{
		showmiscmodels("coal_warm");
		hidemiscmodels("coal_cold");
	}
	else
	{
		hidemiscmodels("coal_warm");
		showmiscmodels("coal_cold");
	}
	if(isdefined(level.var_21807a83) && isarray(level.var_21807a83))
	{
		foreach(planet in level.var_21807a83)
		{
			planet delete();
		}
		level.var_21807a83 = undefined;
	}
	level.a_planets = undefined;
	level flag::clear(#"infinite_round_spawning");
	exploder::exploder_stop("exp_lgt_boiler_overheat");
	exploder::exploder_stop("exp_boiler_overheat");
}

/*
	Name: function_9d73036a
	Namespace: namespace_74905749
	Checksum: 0xFB04789F
	Offset: 0xA320
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function function_9d73036a()
{
	a_glyphs = struct::get_array(#"planet_glyph", "script_noteworthy");
	foreach(s_glyph in a_glyphs)
	{
		s_glyph zm_unitrigger::create(undefined, undefined, &function_4f658ef7);
	}
}

/*
	Name: function_4f658ef7
	Namespace: namespace_74905749
	Checksum: 0xCF0105D6
	Offset: 0xA3E8
	Size: 0x3FC
	Parameters: 0
	Flags: Linked
*/
function function_4f658ef7()
{
	self endon(#"death");
	s_glyph = self.stub.related_parent;
	while(!level flag::get(#"hash_63a102a7ae564e99"))
	{
		s_glyph.var_6eb21a54 show();
		self waittill(#"trigger");
		s_glyph.var_6eb21a54 clientfield::increment("" + #"hash_68e2384b254175da", 1);
		s_glyph.var_6eb21a54 util::delay(0.5, #"hash_158580acc65694d5", &function_cbad2cfb);
		var_7ec8be9 = getent(s_glyph.targetname, "str_object_name");
		if(!isdefined(var_7ec8be9))
		{
			var_7ec8be9 = util::spawn_model("tag_origin");
		}
		var_7ec8be9.str_object_name = s_glyph.targetname;
		playsoundatposition((#"hash_73b0c0f78e9868c6" + s_glyph.targetname) + "_cele_0", s_glyph.origin);
		if(!isdefined(level.var_21807a83))
		{
			level.var_21807a83 = [];
		}
		else if(!isarray(level.var_21807a83))
		{
			level.var_21807a83 = array(level.var_21807a83);
		}
		if(!isinarray(level.var_21807a83, var_7ec8be9))
		{
			level.var_21807a83[level.var_21807a83.size] = var_7ec8be9;
		}
		if(!isdefined(level.a_planets))
		{
			level.a_planets = [];
		}
		else if(!isarray(level.a_planets))
		{
			level.a_planets = array(level.a_planets);
		}
		if(!isinarray(level.a_planets, var_7ec8be9))
		{
			level.a_planets[level.a_planets.size] = var_7ec8be9;
		}
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold(s_glyph.targetname + "");
				println(s_glyph.targetname + "");
			}
		#/
		level thread function_adb2b2a3(var_7ec8be9);
		level waittill(#"hash_158580acc65694d5", #"hash_63a102a7ae564e99");
	}
	if(isdefined(s_glyph) && isdefined(s_glyph.var_6eb21a54))
	{
		s_glyph.var_6eb21a54 delete();
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: function_cbad2cfb
	Namespace: namespace_74905749
	Checksum: 0xFCB511EF
	Offset: 0xA7F0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_cbad2cfb()
{
	self hide();
}

/*
	Name: function_8b9aec1a
	Namespace: namespace_74905749
	Checksum: 0xEB8AF6FE
	Offset: 0xA818
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_8b9aec1a()
{
	if(level.a_planets.size < 9)
	{
		return;
	}
	foreach(var_7ec8be9 in level.a_planets)
	{
		if(var_7ec8be9.var_ddb0a5b4 !== 1)
		{
			return;
		}
	}
	waitframe(1);
	level flag::set(#"hash_63a102a7ae564e99");
}

/*
	Name: function_63ce4441
	Namespace: namespace_74905749
	Checksum: 0x4B73922E
	Offset: 0xA8E0
	Size: 0x4F8
	Parameters: 0
	Flags: Linked
*/
function function_63ce4441()
{
	a_glyphs = struct::get_array(#"planet_glyph", "script_noteworthy");
	do
	{
		a_glyphs = array::randomize(a_glyphs);
	}
	while(a_glyphs[0].targetname == #"moon");
	foreach(s_glyph in a_glyphs)
	{
		if(s_glyph.targetname == #"sun")
		{
			var_7f1b5e98 = s_glyph;
			break;
		}
	}
	arrayremovevalue(a_glyphs, var_7f1b5e98, 0);
	a_glyphs[a_glyphs.size] = var_7f1b5e98;
	a_str_flags = [];
	foreach(s_glyph in a_glyphs)
	{
		if(!isdefined(a_str_flags))
		{
			a_str_flags = [];
		}
		else if(!isarray(a_str_flags))
		{
			a_str_flags = array(a_str_flags);
		}
		a_str_flags[a_str_flags.size] = s_glyph.targetname;
	}
	var_364a23fa = getent("secret_device", "targetname");
	level thread function_996d1a4c(a_glyphs, var_364a23fa);
	while(true)
	{
		level flag::wait_till(#"hash_220b149fa209b3e8");
		level notify(#"hash_e9d5238dbce48ca");
		level thread function_f016aaf8(a_glyphs, var_364a23fa);
		function_7711ae4b(a_glyphs, var_364a23fa);
		if(level flag::get(#"hash_1a742576c41a0ab9"))
		{
			level flag::wait_till_any(array(#"hash_7494610e7bd95c34", #"hash_77f76266b597a1f7"));
			if(level flag::get(#"hash_7494610e7bd95c34"))
			{
				break;
			}
		}
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold("");
				println("");
			}
		#/
		foreach(str_flag in a_str_flags)
		{
			if(level flag::exists(str_flag + "_done"))
			{
				level flag::delete(str_flag + "_done");
			}
			if(level flag::exists(str_flag + "_pickup"))
			{
				level flag::delete(str_flag + "_pickup");
			}
		}
		level flag::clear(#"hash_1a742576c41a0ab9");
		level flag::clear(#"hash_220b149fa209b3e8");
		var_364a23fa clientfield::set("" + #"planet_light", 0);
	}
}

/*
	Name: function_7711ae4b
	Namespace: namespace_74905749
	Checksum: 0x8F21DDBF
	Offset: 0xADE0
	Size: 0x148
	Parameters: 2
	Flags: Linked
*/
function function_7711ae4b(a_glyphs, var_307df34b)
{
	level endon(#"hash_77f76266b597a1f7");
	for(i = 0; i < a_glyphs.size; i++)
	{
		str_planet_name = a_glyphs[i].targetname;
		level flag::init(str_planet_name + "_done");
		level flag::wait_till(str_planet_name + "_done");
		level thread function_50b3a576(str_planet_name, i + 1);
		level flag::delete(str_planet_name + "_done");
	}
	level flag::set(#"hash_1a742576c41a0ab9");
	level thread function_996d1a4c(a_glyphs, var_307df34b);
	waitframe(1);
	level notify(#"hash_e9d5238dbce48ca");
}

/*
	Name: function_f016aaf8
	Namespace: namespace_74905749
	Checksum: 0xCE39DE40
	Offset: 0xAF30
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function function_f016aaf8(a_glyphs, var_307df34b)
{
	level endon(#"hash_77f76266b597a1f7");
	for(i = 0; i < a_glyphs.size; i++)
	{
		str_planet_name = a_glyphs[i].targetname;
		level flag::init(str_planet_name + "_pickup");
		level flag::wait_till(str_planet_name + "_pickup");
		level flag::delete(str_planet_name + "_pickup");
	}
	level flag::set(#"hash_7494610e7bd95c34");
	level flag::set(#"hash_1b9ecc7979b0fcfb");
}

/*
	Name: function_50b3a576
	Namespace: namespace_74905749
	Checksum: 0xA8015319
	Offset: 0xB048
	Size: 0x45C
	Parameters: 2
	Flags: Linked
*/
function function_50b3a576(str_planet_name, n_number)
{
	level endoncallback(&function_699ac1b, str_planet_name + "_pickup", #"hash_7494610e7bd95c34", #"hash_77f76266b597a1f7");
	while(!level flag::exists(str_planet_name + "_pickup"))
	{
		waitframe(1);
	}
	level.disable_nuke_delay_spawning = 1;
	level notify(#"disable_nuke_delay_spawning");
	level flag::clear("spawn_zombies");
	level.str_planet_name = str_planet_name;
	level.no_target_override = &function_325ea497;
	a_zones = function_c3e929e8(str_planet_name);
	if(!isdefined(a_zones))
	{
		a_zones = [];
	}
	else if(!isarray(a_zones))
	{
		a_zones = array(a_zones);
	}
	level thread function_11df7365(a_zones);
	level thread function_89b95aa1(a_zones, str_planet_name);
	a_s_spawnpoints = [];
	foreach(str_zone in a_zones)
	{
		var_fc5b2270 = getnodearray(str_zone, "targetname");
		var_277fe5f1 = struct::get_array(var_fc5b2270[0].target);
		a_s_spawnpoints = arraycombine(a_s_spawnpoints, var_277fe5f1, 0, 0);
	}
	var_1b30f365 = function_ce045bbf(a_s_spawnpoints, #"stoker_location");
	a_s_spawnpoints = function_8046369(a_s_spawnpoints);
	n_max_zombies = 16 + (util::get_active_players().size * 2);
	if(n_number == 2 || n_number == 8)
	{
		if(var_1b30f365.size)
		{
			s_stoker_spawn = array::random(var_1b30f365);
		}
		ai = zm_ai_stoker::spawn_single(1, s_stoker_spawn);
		if(isdefined(ai))
		{
			ai.b_ignore_cleanup = 1;
		}
		if(util::get_active_players().size > 2)
		{
			level thread function_13fa48c4(s_stoker_spawn, 5);
		}
	}
	if(n_number == 5 || n_number == 8)
	{
		util::delay(10, undefined, &spawn_blightfather);
	}
	while(true)
	{
		function_a5946754(a_s_spawnpoints, 99, n_max_zombies);
	}
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold("" + str_zone);
			println("" + str_zone);
		}
	#/
}

/*
	Name: function_699ac1b
	Namespace: namespace_74905749
	Checksum: 0x82A26861
	Offset: 0xB4B0
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function function_699ac1b(s_result)
{
	level flag::set("spawn_zombies");
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
	level.no_target_override = undefined;
	level.disable_nuke_delay_spawning = undefined;
}

/*
	Name: function_13fa48c4
	Namespace: namespace_74905749
	Checksum: 0x59EAB693
	Offset: 0xB540
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function function_13fa48c4(s_stoker_spawn, n_delay)
{
	wait(n_delay);
	ai = zm_ai_stoker::spawn_single(1, s_stoker_spawn);
	if(isdefined(ai))
	{
		ai.b_ignore_cleanup = 1;
	}
}

/*
	Name: function_ce045bbf
	Namespace: namespace_74905749
	Checksum: 0xBCF96C
	Offset: 0xB5A0
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function function_ce045bbf(a_spawnpoints, str_type)
{
	var_fded0f90 = [];
	foreach(s_spawnpoint in a_spawnpoints)
	{
		if(s_spawnpoint.script_noteworthy === str_type)
		{
			if(!isdefined(var_fded0f90))
			{
				var_fded0f90 = [];
			}
			else if(!isarray(var_fded0f90))
			{
				var_fded0f90 = array(var_fded0f90);
			}
			var_fded0f90[var_fded0f90.size] = s_spawnpoint;
		}
	}
	return var_fded0f90;
}

/*
	Name: function_325ea497
	Namespace: namespace_74905749
	Checksum: 0xF643CFC9
	Offset: 0xB690
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_325ea497(ai)
{
	v_goal = struct::get(level.str_planet_name + "_turtle").origin;
	if(isdefined(v_goal))
	{
		self setgoal(v_goal, 0, 0, 256);
	}
}

/*
	Name: function_89b95aa1
	Namespace: namespace_74905749
	Checksum: 0x1C5C6491
	Offset: 0xB708
	Size: 0x330
	Parameters: 2
	Flags: Linked
*/
function function_89b95aa1(a_zones, str_planet_name)
{
	wait(10);
	while(level flag::exists(str_planet_name + "_pickup") && !level flag::get(str_planet_name + "_pickup"))
	{
		if(zm_zonemgr::any_player_in_zone(a_zones[0]))
		{
			foreach(player in util::get_active_players())
			{
				player val::reset(#"planet_ignore", "ignoreme");
			}
		}
		else
		{
			foreach(player in util::get_active_players())
			{
				player val::set(#"planet_ignore", "ignoreme", 1);
			}
		}
		wait(1);
		if(randomint(100) >= 66)
		{
			ai = array::random(getaiarchetypearray(#"zombie", level.zombie_team));
			if(zm_utility::is_magic_bullet_shield_enabled(ai))
			{
				ai util::stop_magic_bullet_shield();
			}
			if(isalive(ai) && (isdefined(ai.allowdeath) && ai.allowdeath))
			{
				ai kill();
			}
		}
	}
	foreach(player in util::get_active_players())
	{
		player val::reset(#"planet_ignore", "ignoreme");
	}
}

/*
	Name: function_11df7365
	Namespace: namespace_74905749
	Checksum: 0xEFBC9F9E
	Offset: 0xBA40
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function function_11df7365(a_zones)
{
	wait(10);
	foreach(ai in getaiarchetypearray(#"zombie", level.zombie_team))
	{
		foreach(str_zone in a_zones)
		{
			if(isalive(ai) && ai.zone_name !== str_zone)
			{
				if(zm_utility::is_magic_bullet_shield_enabled(ai))
				{
					ai util::stop_magic_bullet_shield();
				}
				ai dodamage(ai.health + 999, ai.origin);
				waitframe(randomint(15));
			}
		}
	}
}

/*
	Name: function_c3e929e8
	Namespace: namespace_74905749
	Checksum: 0xF43B42E8
	Offset: 0xBBE0
	Size: 0x13A
	Parameters: 1
	Flags: Linked
*/
function function_c3e929e8(str_planet_name)
{
	switch(str_planet_name)
	{
		case "sun":
		{
			return array("zone_forecastle_upper", "zone_forecastle_lower");
		}
		case "saturn":
		{
			return "zone_bridge";
		}
		case "neptune":
		{
			return "zone_aft_deck";
		}
		case "jupiter":
		{
			return array("zone_engine", "zone_upper_engine_room");
		}
		case "moon":
		{
			return "zone_grand_stairs_c_deck";
		}
		case "uranus":
		{
			return array("zone_state_rooms_rear", "zone_state_rooms_front");
		}
		case "mercury":
		{
			return "zone_mail_room";
		}
		case "mars":
		{
			return "zone_boiler_room";
		}
		case "venus":
		{
			return "millionaire_suite_zone";
		}
	}
}

/*
	Name: function_996d1a4c
	Namespace: namespace_74905749
	Checksum: 0xF4E00F34
	Offset: 0xBD28
	Size: 0x28C
	Parameters: 2
	Flags: Linked
*/
function function_996d1a4c(a_glyphs, var_307df34b)
{
	var_307df34b endon(#"death");
	while(!level flag::get(#"hash_7494610e7bd95c34"))
	{
		level waittill(#"hash_e9d5238dbce48ca");
		if(var_307df34b.var_98591484 === 1)
		{
			return;
		}
		var_307df34b.var_98591484 = 1;
		var_307df34b notify(#"stop_blinking");
		waitframe(1);
		var_307df34b clientfield::set("" + #"planet_light", 0);
		wait(0.5);
		for(i = 0; i < a_glyphs.size; i++)
		{
			var_307df34b function_f84f44e5(a_glyphs[i].targetname);
			wait(1.25);
		}
		var_307df34b clientfield::set("" + #"planet_light", 0);
		wait(1.25);
		str_current = undefined;
		for(i = 0; i < a_glyphs.size; i++)
		{
			if(level flag::exists(a_glyphs[i].targetname + "_done"))
			{
				str_current = a_glyphs[i].targetname;
			}
		}
		if(!isdefined(str_current))
		{
			for(i = 0; i < a_glyphs.size; i++)
			{
				if(level flag::exists(a_glyphs[i].targetname + "_pickup"))
				{
					str_current = a_glyphs[i].targetname;
				}
			}
		}
		var_307df34b.var_98591484 = 0;
		level notify(#"hash_2b98a5e784a514cf", isdefined(str_current));
	}
}

/*
	Name: function_f84f44e5
	Namespace: namespace_74905749
	Checksum: 0x820D57B2
	Offset: 0xBFC0
	Size: 0x262
	Parameters: 1
	Flags: Linked
*/
function function_f84f44e5(str_planet_name)
{
	switch(str_planet_name)
	{
		case "sun":
		{
			self clientfield::set("" + #"planet_light", 1);
			break;
		}
		case "mercury":
		{
			self clientfield::set("" + #"planet_light", 2);
			break;
		}
		case "venus":
		{
			self clientfield::set("" + #"planet_light", 3);
			break;
		}
		case "moon":
		{
			self clientfield::set("" + #"planet_light", 4);
			break;
		}
		case "mars":
		{
			self clientfield::set("" + #"planet_light", 5);
			break;
		}
		case "jupiter":
		{
			self clientfield::set("" + #"planet_light", 6);
			break;
		}
		case "saturn":
		{
			self clientfield::set("" + #"planet_light", 7);
			break;
		}
		case "uranus":
		{
			self clientfield::set("" + #"planet_light", 8);
			break;
		}
		case "neptune":
		{
			self clientfield::set("" + #"planet_light", 9);
			break;
		}
	}
}

/*
	Name: function_51054f59
	Namespace: namespace_74905749
	Checksum: 0x843B35BD
	Offset: 0xC230
	Size: 0x64C
	Parameters: 0
	Flags: Linked
*/
function function_51054f59()
{
	level flag::wait_till(#"hash_76dd603f61fa542d");
	var_43b4f0a = struct::get(#"loc_sun");
	playsoundatposition(#"hash_792f64fc5493af58", var_43b4f0a.origin);
	exploder::exploder("exp_crate_blast");
	wait(0.2);
	a_crate = getentarray("generic_crate_sides", "targetname");
	foreach(e_crate in a_crate)
	{
		e_crate delete();
	}
	level flag::wait_till(#"hash_63a102a7ae564e99");
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold("");
			println("");
		}
	#/
	a_glyphs = struct::get_array(#"planet_glyph", "script_noteworthy");
	var_27805204 = struct::get(#"loc_sun");
	var_27805204 zm_unitrigger::create();
	while(!level flag::get(#"hash_7494610e7bd95c34"))
	{
		s_result = undefined;
		s_result = var_27805204 waittill(#"trigger_activated");
		if(isdefined(s_result.e_who))
		{
			s_result.e_who zm_audio::create_and_play_dialog(#"m_quest", #"hash_7ccac254437d97c2");
		}
		playsoundatposition(#"hash_1321699865d55fc2", var_27805204.origin);
		foreach(player in util::get_active_players())
		{
			player playrumbleonentity("zm_power_on_rumble");
		}
		level scene::stop("p8_fxanim_zm_zod_skybox_bundle");
		level thread scene::play("p8_fxanim_zm_zod_skybox_bundle", "event_impact");
		level flag::set(#"hash_220b149fa209b3e8");
		level flag::set(#"pause_round_timeout");
		level flag::set(#"infinite_round_spawning");
		level.a_planets = arraycopy(level.var_21807a83);
		if(level flag::get(#"hash_77f76266b597a1f7"))
		{
			level flag::clear(#"hash_77f76266b597a1f7");
		}
		waitframe(1);
		foreach(player in util::get_active_players())
		{
			player thread function_53a78cbd();
		}
		foreach(var_7ec8be9 in level.a_planets)
		{
			level thread function_adb2b2a3(var_7ec8be9);
		}
		var_27805204 thread function_384c480f();
		level flag::wait_till_clear(#"hash_220b149fa209b3e8");
		level flag::clear(#"infinite_round_spawning");
		level flag::clear(#"pause_round_timeout");
		level waittill(#"end_of_round", #"start_of_round");
		var_27805204 notify(#"hash_3ff9c95fe61d398c");
	}
	zm_unitrigger::unregister_unitrigger(var_27805204.s_unitrigger);
	var_27805204 struct::delete();
}

/*
	Name: function_384c480f
	Namespace: namespace_74905749
	Checksum: 0xB7970DF4
	Offset: 0xC888
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function function_384c480f()
{
	while(!level flag::get(#"hash_7494610e7bd95c34"))
	{
		s_result = undefined;
		s_result = self waittill(#"trigger_activated", #"hash_3ff9c95fe61d398c");
		if(s_result._notify === "trigger_activated")
		{
			waitframe(1);
			if(level flag::get(#"hash_220b149fa209b3e8"))
			{
				level notify(#"hash_e9d5238dbce48ca");
			}
		}
		else
		{
			return;
		}
	}
}

/*
	Name: function_adb2b2a3
	Namespace: namespace_74905749
	Checksum: 0xA8E34F02
	Offset: 0xC950
	Size: 0x556
	Parameters: 1
	Flags: Linked
*/
function function_adb2b2a3(var_7ec8be9)
{
	if(var_7ec8be9.var_ddb0a5b4 === 1)
	{
		return;
	}
	str_planet_name = var_7ec8be9.str_object_name;
	if(str_planet_name !== #"moon")
	{
		var_7ec8be9 setmodel((#"p8_zm_zod_planets_" + str_planet_name) + "_large");
		var_7ec8be9 setscale(1.25);
		switch(str_planet_name)
		{
			case "uranus":
			{
				var_7ec8be9 setscale(2);
				var_7ec8be9 clientfield::set("" + #"planet_fx", 8);
				break;
			}
			case "saturn":
			{
				var_7ec8be9 setscale(3);
				var_7ec8be9 clientfield::set("" + #"planet_fx", 7);
				break;
			}
			case "jupiter":
			{
				var_7ec8be9 setscale(2.5);
				var_7ec8be9 clientfield::set("" + #"planet_fx", 6);
				break;
			}
			case "sun":
			{
				var_7ec8be9 clientfield::set("" + #"planet_fx", 1);
				break;
			}
			case "mars":
			{
				var_7ec8be9 clientfield::set("" + #"planet_fx", 5);
				break;
			}
			case "mercury":
			{
				var_7ec8be9 clientfield::set("" + #"planet_fx", 2);
				break;
			}
			case "venus":
			{
				var_7ec8be9 clientfield::set("" + #"planet_fx", 3);
				break;
			}
			case "neptune":
			{
				var_7ec8be9 clientfield::set("" + #"planet_fx", 9);
				break;
			}
		}
	}
	var_7ec8be9 notsolid();
	var_7ec8be9 hide();
	var_7ec8be9.var_ddb0a5b4 = 1;
	function_8b9aec1a();
	level thread function_5d34f85b(var_7ec8be9);
	level thread function_45878df1(var_7ec8be9);
	if(str_planet_name !== #"moon")
	{
		var_5314bd63 = getent("veh_fasttravel_cam", "targetname");
		nd_path = array::random(getvehiclenodearray(str_planet_name + "_turkey", "targetname"));
		var_44c99f3b = spawner::simple_spawn_single(var_5314bd63);
		var_7ec8be9.var_44c99f3b = var_44c99f3b;
		var_7ec8be9.origin = var_44c99f3b.origin;
		var_7ec8be9 linkto(var_44c99f3b);
		while(!level flag::get(#"hash_77f76266b597a1f7"))
		{
			if(isdefined(var_44c99f3b))
			{
				var_44c99f3b vehicle::get_on_and_go_path(nd_path);
				if(isdefined(var_44c99f3b) && (str_planet_name === #"uranus" || str_planet_name === #"saturn"))
				{
					wait(randomintrange(10, 20));
				}
			}
			else
			{
				return;
			}
		}
	}
}

/*
	Name: function_45878df1
	Namespace: namespace_74905749
	Checksum: 0x2E37F2B4
	Offset: 0xCEB0
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_45878df1(var_7ec8be9)
{
	level waittill(#"hash_77f76266b597a1f7", var_7ec8be9.str_object_name + "_pickup");
	if(isdefined(var_7ec8be9))
	{
		var_7ec8be9.var_ddb0a5b4 = 0;
		var_7ec8be9 clientfield::set("" + #"essence_fx", 0);
		var_7ec8be9 setmodel("tag_origin");
		if(isdefined(var_7ec8be9.var_44c99f3b))
		{
			var_7ec8be9 unlink();
			var_7ec8be9.var_44c99f3b notify(#"stop path");
			var_7ec8be9.var_44c99f3b delete();
		}
	}
}

/*
	Name: function_5d34f85b
	Namespace: namespace_74905749
	Checksum: 0x88F31D8A
	Offset: 0xCFB8
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_5d34f85b(var_7ec8be9)
{
	var_7ec8be9 clientfield::set("" + #"land_fx", 0);
	var_7ec8be9 hide();
	wait(0.5);
	var_7ec8be9 show();
}

/*
	Name: function_53a78cbd
	Namespace: namespace_74905749
	Checksum: 0xB9D7B79E
	Offset: 0xD038
	Size: 0x4A6
	Parameters: 0
	Flags: Linked
*/
function function_53a78cbd()
{
	self notify("27434ec2d49bebb3");
	self endon("27434ec2d49bebb3");
	self endon(#"death");
	var_d9ebae63 = gettime();
	var_82f4c12b = level.hero_weapon[#"chakram"];
	while(!level flag::get(#"hash_1a742576c41a0ab9"))
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_fired");
		if(!isdefined(level.a_planets) || level.a_planets.size == 0)
		{
			continue;
		}
		if(gettime() - var_d9ebae63 < 100)
		{
			continue;
		}
		var_6203d9be = 0;
		foreach(weapon in var_82f4c12b)
		{
			if(weapon.dualwieldweapon == s_result.weapon || weapon == s_result.weapon)
			{
				var_6203d9be = 1;
				break;
			}
		}
		if(var_6203d9be)
		{
			continue;
		}
		v_forward = self getweaponforwarddir();
		v_start = self getweaponmuzzlepoint();
		foreach(var_7ec8be9 in level.a_planets)
		{
			if(!isdefined(var_7ec8be9.str_object_name) || (v_forward[2] < 0.3 && var_7ec8be9.str_object_name != #"neptune") || (v_forward[2] > 0.1 && var_7ec8be9.str_object_name == #"neptune"))
			{
				continue;
			}
			if(var_7ec8be9.var_ddb0a5b4 !== 1)
			{
				continue;
			}
			v_end = v_start + (v_forward * 200000);
			b_hit = self function_370a9e5(var_7ec8be9, v_start, v_end, v_forward);
			if(b_hit)
			{
				v_trace_end = v_start + (v_forward * 10000);
				a_trace = bullettrace(v_start, v_trace_end, 1, self);
				if(isdefined(a_trace[#"entity"]) || (a_trace[#"surfacetype"] !== "default" && a_trace[#"surfacetype"] !== "none"))
				{
					break;
				}
				self util::show_hit_marker(1);
				self thread zm_audio::create_and_play_dialog(#"m_quest", #"hash_45e36c01ad8ad25c", 0, 1);
				if(isdefined(var_7ec8be9.var_44c99f3b))
				{
					var_7ec8be9 unlink();
					var_7ec8be9.var_44c99f3b delete();
				}
				level thread function_acc65da4(var_7ec8be9);
				break;
			}
		}
		var_d9ebae63 = gettime();
	}
}

/*
	Name: function_370a9e5
	Namespace: namespace_74905749
	Checksum: 0xBEE968C4
	Offset: 0xD4E8
	Size: 0x252
	Parameters: 4
	Flags: Linked
*/
function function_370a9e5(var_7ec8be9, v_start, v_end, v_forward)
{
	if(var_7ec8be9.str_object_name === #"moon")
	{
		v_angles = self getplayerangles();
		if((abs(abs(v_angles[0]) - (abs(-26.6)))) + (abs(abs(v_angles[1]) - (abs(-29.35)))) <= 2.2 && (abs(abs(v_angles[2]) - abs(0))) <= 1)
		{
			var_7ec8be9.origin = v_start + (v_forward * 100000);
			return true;
		}
		return false;
	}
	v_target = var_7ec8be9.origin;
	if(var_7ec8be9.str_object_name === #"neptune")
	{
		n_min_dist = 10000;
	}
	else
	{
		n_min_dist = 1048576;
	}
	v_shot = pointonsegmentnearesttopoint(v_start, v_end, v_target);
	n_dist_squared = distancesquared(v_shot, v_target);
	if(n_dist_squared < n_min_dist)
	{
		return true;
	}
	return false;
}

/*
	Name: function_acc65da4
	Namespace: namespace_74905749
	Checksum: 0xE8A0918B
	Offset: 0xD748
	Size: 0x640
	Parameters: 1
	Flags: Linked
*/
function function_acc65da4(var_7ec8be9)
{
	n_move_time = 9;
	n_accel = 5;
	str_planet_name = var_7ec8be9.str_object_name;
	arrayremovevalue(level.a_planets, var_7ec8be9, 0);
	var_7ec8be9 setmodel(#"tag_origin");
	if(str_planet_name != #"neptune")
	{
		if(str_planet_name == #"moon")
		{
			util::wait_network_frame();
		}
		var_7ec8be9 clientfield::set("" + #"essence_fx", 1);
	}
	var_7ec8be9 playsound(#"hash_2380c4a79ebb093c");
	var_7ec8be9 playloopsound(#"hash_5a4997dc84f6d680");
	if(level flag::exists(str_planet_name + "_done"))
	{
		level flag::set(str_planet_name + "_done");
		if(str_planet_name == #"neptune")
		{
			var_7ec8be9 clientfield::set("" + #"essence_fx", 1);
			function_fd93c584(var_7ec8be9);
			n_move_time = 3;
			n_accel = 1;
		}
		s_landing = struct::get(str_planet_name + "_coyote");
		var_7ec8be9 moveto(s_landing.origin + vectorscale((0, 0, 1), 20), n_move_time, n_accel, 0.5);
		var_7ec8be9 waittill(#"movedone");
		var_7ec8be9 clientfield::set("" + #"land_fx", 1);
		var_7ec8be9 rotate((15, 50, 0));
		var_7ec8be9 playsound(#"hash_6e67e59759b21e8e");
		if(!level flag::get(#"hash_77f76266b597a1f7"))
		{
			var_7ec8be9 playloopsound(#"hash_733ab9b8fda8f02b");
			level thread function_647da52c(str_planet_name);
			if(str_planet_name == #"sun")
			{
				s_landing function_6099877a(undefined, #"hash_77f76266b597a1f7");
			}
			else
			{
				s_landing zm_unitrigger::create();
				s_landing function_1f6c1c1f();
			}
			level.var_e830f656 = undefined;
			if(level flag::exists(str_planet_name + "_pickup"))
			{
				level flag::set(str_planet_name + "_pickup");
				var_7ec8be9 stoploopsound();
				var_7ec8be9 playsound(#"hash_134115584a37eb8a");
			}
			else
			{
				level flag::set(#"hash_77f76266b597a1f7");
				zm_unitrigger::unregister_unitrigger(s_landing.s_unitrigger);
			}
		}
	}
	else
	{
		var_7ec8be9 clientfield::set("" + #"land_fx", 1);
		s_landing = array::get_all_closest(var_7ec8be9.origin, struct::get_array(#"hash_599cbbc041a9734e"), undefined, 1)[0];
		var_7ec8be9 moveto(s_landing.origin, n_move_time);
		var_7ec8be9 waittill(#"movedone");
		var_7ec8be9 stoploopsound();
		var_7ec8be9 playsound(#"hash_7007602a9c1e2b84");
		var_7ec8be9 clientfield::set("" + #"land_fx", 0);
		level flag::set(#"hash_77f76266b597a1f7");
		/#
			iprintlnbold("");
		#/
	}
	if(!level flag::get(#"hash_63a102a7ae564e99"))
	{
		waitframe(1);
		level flag::clear(#"hash_77f76266b597a1f7");
		level notify(#"hash_158580acc65694d5");
	}
}

/*
	Name: function_1f6c1c1f
	Namespace: namespace_74905749
	Checksum: 0x30762F0C
	Offset: 0xDD90
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_1f6c1c1f()
{
	level endon(#"hash_77f76266b597a1f7");
	s_result = undefined;
	s_result = self waittill(#"trigger_activated");
	if(isdefined(s_result.e_who))
	{
		s_result.e_who thread zm_audio::create_and_play_dialog(#"m_quest", #"hash_75e9e3640a38273", 0, 1);
	}
}

/*
	Name: function_647da52c
	Namespace: namespace_74905749
	Checksum: 0x31406B42
	Offset: 0xDE28
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_647da52c(str_planet_name)
{
	level endon(#"hash_77f76266b597a1f7", str_planet_name + "_pickup");
	n_interval = 10;
	n_current_time = 0;
	if(getplayers().size > 1)
	{
		n_time = 30;
	}
	else
	{
		n_time = 45;
	}
	while(n_current_time < n_time)
	{
		if(!isdefined(level.var_e830f656))
		{
			level.var_e830f656 = str_planet_name;
		}
		wait(n_interval);
		n_current_time = n_current_time + n_interval;
		n_interval = max(1, n_interval * 0.666);
		if(level.var_e830f656 === str_planet_name)
		{
			playsoundatposition(#"hash_1e42da88156af69f", (0, 0, 0));
			/#
				if(getdvarint(#"hash_7919e37cd5d57659", 0))
				{
					iprintlnbold("");
					println("");
				}
			#/
		}
	}
	level flag::set(#"hash_77f76266b597a1f7");
}

/*
	Name: function_fd93c584
	Namespace: namespace_74905749
	Checksum: 0xB70B9E42
	Offset: 0xDFD8
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_fd93c584(var_7ec8be9)
{
	s_rising = struct::get(#"hash_38c9156b019d766b");
	var_7ec8be9 moveto(s_rising.origin, 5, 1, 3);
	var_7ec8be9 waittill(#"movedone");
	wait(0.15);
}

/*
	Name: function_8ec70b18
	Namespace: namespace_74905749
	Checksum: 0xA57B2685
	Offset: 0xE070
	Size: 0x40E
	Parameters: 1
	Flags: Linked
*/
function function_8ec70b18(var_5ea5c94d)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_5d7e4ccce97334e0", 7);
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			gear_up();
		}
	#/
	if(!var_5ea5c94d)
	{
		level.zm_bgb_anywhere_but_here_validation_override = &return_false;
		level.var_88de5053 = 3;
		level flag::set(#"hash_767ce45fce848b88");
		foreach(player in util::get_players())
		{
			if(player util::is_spectating())
			{
				player thread zm_player::spectator_respawn_player();
			}
			player clientfield::set_to_player("" + #"camera_snow", 1);
		}
		level.musicsystemoverride = 1;
		music::setmusicstate("frozen");
		function_1cfbff5e();
		level thread function_365aa198();
		level thread function_cfd304b3();
		util::delay(3.5, undefined, &function_53802e89, #"hash_4ba720f616544675", struct::get(#"sun_coyote").origin, array(4, 3, 2, 1));
		level flag::wait_till(#"hash_349bc60cedc7491e");
		streamermodelhint(#"p8_zm_zod_teleport_symbol", 10);
		streamermodelhint(#"hash_15e8ba772c745d63", 10);
		level thread function_63a0f09e();
		music::setmusicstate("none");
		level.musicsystemoverride = 0;
		wait(1);
		foreach(player in util::get_active_players())
		{
			player clientfield::set("bs_player_ice_br_cf", 0);
			player clientfield::set_to_player("" + #"camera_snow", 0);
		}
		function_77a859a8(0, 0);
		level.zm_bgb_anywhere_but_here_validation_override = &zm_zodt8::function_3910bef9;
	}
}

/*
	Name: function_71a8bce1
	Namespace: namespace_74905749
	Checksum: 0xCB6C7A2B
	Offset: 0xE488
	Size: 0x228
	Parameters: 2
	Flags: Linked
*/
function function_71a8bce1(var_5ea5c94d, ended_early)
{
	if(ended_early)
	{
		level flag::set(#"hash_349bc60cedc7491e");
	}
	if(!var_5ea5c94d)
	{
		playsoundatposition(#"hash_e0f3775083de381", (0, 0, 0));
		function_964dd361();
	}
	level.a_mdl_blockers = undefined;
	level.var_1012c716 = undefined;
	level.var_8a64ef3a = undefined;
	level.var_11f7a9af = undefined;
	level.var_88de5053 = undefined;
	level flag::set("spawn_zombies");
	level flag::set("zombie_drop_powerups");
	level flag::clear(#"hash_767ce45fce848b88");
	level flag::clear(#"hash_1b9ecc7979b0fcfb");
	level flag::clear(#"pause_round_timeout");
	level clientfield::set("fasttravel_exploder", 1);
	foreach(player in util::get_active_players())
	{
		player clientfield::set("bs_player_ice_br_cf", 0);
		player clientfield::set_to_player("" + #"camera_snow", 0);
	}
}

/*
	Name: function_cfd304b3
	Namespace: namespace_74905749
	Checksum: 0x4DF8DB7
	Offset: 0xE6B8
	Size: 0x4E4
	Parameters: 0
	Flags: Linked
*/
function function_cfd304b3()
{
	level endon(#"hash_349bc60cedc7491e");
	n_round = zm_round_logic::get_round_number();
	a_players = util::get_active_players();
	n_players = a_players.size;
	foreach(player in a_players)
	{
		player clientfield::set("bs_player_ice_br_cf", 1);
	}
	switch(n_players)
	{
		case 1:
		{
			n_time = 180;
			break;
		}
		case 2:
		{
			n_time = 160;
			break;
		}
		case 3:
		{
			n_time = 135;
			break;
		}
		case 4:
		{
			n_time = 120;
			break;
		}
	}
	n_increment = n_time / 9;
	var_398f5909 = n_time;
	while(var_398f5909 > 0)
	{
		streamermodelhint(#"hash_55657a69ddb2f287" + "dmg_01", n_increment);
		streamermodelhint(#"hash_55657a69ddb2f287" + "dmg_02", n_increment);
		streamermodelhint(#"hash_55657a69ddb2f287" + "dmg_03", n_increment);
		if(var_398f5909 < n_increment)
		{
			wait(var_398f5909);
		}
		else
		{
			wait(n_increment);
		}
		foreach(player in a_players)
		{
			if(isdefined(player))
			{
				player clientfield::increment_to_player("" + #"hash_7a927551ca199a1c", 1);
			}
		}
		var_398f5909 = var_398f5909 - n_increment;
		/#
			if(var_398f5909 > 0)
			{
				iprintlnbold(int(var_398f5909) + "");
			}
		#/
	}
	level notify(#"frozen_timeout");
	foreach(player in a_players)
	{
		if(isdefined(player))
		{
			player clientfield::increment_to_player("" + #"hash_7a927551ca199a1c", 1);
			player clientfield::set_to_player("" + #"camera_snow", 0);
			player clientfield::set("bs_player_ice_br_cf", 0);
		}
	}
	level thread function_5473a2b3(n_round);
	function_964dd361();
	level flag::set("spawn_zombies");
	level flag::set("zombie_drop_powerups");
	level flag::clear(#"hash_1b9ecc7979b0fcfb");
	level flag::clear(#"pause_round_timeout");
	level.var_11f7a9af = undefined;
	level clientfield::set("fasttravel_exploder", 1);
}

/*
	Name: function_5473a2b3
	Namespace: namespace_74905749
	Checksum: 0xCB0C5B8D
	Offset: 0xEBA8
	Size: 0x3AC
	Parameters: 1
	Flags: Linked
*/
function function_5473a2b3(n_round)
{
	level thread function_63a0f09e(0);
	music::setmusicstate("none");
	level.musicsystemoverride = 0;
	wait(0.5);
	function_77a859a8(0, 0);
	if(n_round == zm_round_logic::get_round_number())
	{
		level waittill(#"end_of_round");
	}
	s_reset = struct::get(#"sun_coyote");
	var_223239fc = util::spawn_model("tag_origin", s_reset.origin + vectorscale((0, 0, 1), 90000));
	var_223239fc moveto(s_reset.origin + vectorscale((0, 0, 1), 20), 9, 5, 0.5);
	var_223239fc clientfield::set("" + #"essence_fx", 1);
	var_223239fc playloopsound(#"hash_5a4997dc84f6d680");
	var_223239fc waittill(#"movedone");
	var_223239fc clientfield::set("" + #"land_fx", 1);
	var_223239fc rotate((15, 50, 0));
	var_223239fc playsound(#"hash_6e67e59759b21e8e");
	var_223239fc playloopsound(#"hash_733ab9b8fda8f02b");
	s_reset function_6099877a();
	var_223239fc clientfield::set("" + #"essence_fx", 0);
	var_223239fc delete();
	s_blockers = struct::get_array(#"mq_block", "script_noteworthy");
	foreach(s_blocker in s_blockers)
	{
		s_blocker.b_spawned = undefined;
	}
	level.musicsystemoverride = 1;
	music::setmusicstate("frozen");
	function_1cfbff5e();
	level thread function_365aa198();
	function_cfd304b3();
}

/*
	Name: function_1cfbff5e
	Namespace: namespace_74905749
	Checksum: 0xC3A5B462
	Offset: 0xEF60
	Size: 0x19E
	Parameters: 0
	Flags: Linked
*/
function function_1cfbff5e()
{
	level flag::set(#"hash_1b9ecc7979b0fcfb");
	level clientfield::set("fasttravel_exploder", 0);
	level thread function_63a0f09e();
	wait(0.5);
	function_77a859a8();
	s_blockers = struct::get_array(#"hash_653ae82f1c11d82c");
	level.a_mdl_blockers = [];
	level.var_1012c716 = 0;
	n_players = util::get_active_players().size;
	n_health = int((20000 * 0.2) + ((20000 * 0.8) * n_players));
	foreach(s_blocker in s_blockers)
	{
		function_4fc9e782(s_blocker, n_health);
		waitframe(1);
	}
}

/*
	Name: function_4fc9e782
	Namespace: namespace_74905749
	Checksum: 0xF5FBB089
	Offset: 0xF108
	Size: 0x182
	Parameters: 2
	Flags: Linked
*/
function function_4fc9e782(s_blocker, n_health)
{
	mdl_blocker = util::spawn_model(#"hash_55657a69ddb2f287" + "full", s_blocker.origin, s_blocker.angles);
	mdl_blocker function_2baad8fc();
	mdl_blocker disconnectpaths();
	mdl_blocker.health = n_health;
	mdl_blocker.maxhealth = n_health;
	mdl_blocker.var_6f84b820 = #"inanimate";
	mdl_blocker thread function_a68ae7b5(s_blocker, n_health);
	s_blocker thread function_353e1c69(mdl_blocker);
	if(!isdefined(level.a_mdl_blockers))
	{
		level.a_mdl_blockers = [];
	}
	else if(!isarray(level.a_mdl_blockers))
	{
		level.a_mdl_blockers = array(level.a_mdl_blockers);
	}
	level.a_mdl_blockers[level.a_mdl_blockers.size] = mdl_blocker;
}

/*
	Name: function_a68ae7b5
	Namespace: namespace_74905749
	Checksum: 0x5AB25216
	Offset: 0xF298
	Size: 0x61C
	Parameters: 2
	Flags: Linked
*/
function function_a68ae7b5(s_blocker, n_health)
{
	level endon(#"frozen_timeout", #"hash_349bc60cedc7491e");
	self val::set(#"mq_block", "takedamage", 1);
	self clientfield::set("" + #"hash_3400ccffbd3d73b3", 1);
	b_shrunk = 0;
	var_e4eccdc0 = 0;
	var_cf6ec580 = n_health * 0.666;
	var_3f5e36d1 = n_health * 0.333;
	var_22733eff = int(n_health / (8 + (util::get_active_players().size * 2)));
	while(self.health > 0)
	{
		var_67ed7be7 = self.health;
		s_result = undefined;
		s_result = self waittill(#"damage");
		if(s_result.amount >= var_22733eff)
		{
			self.health = self.health + (s_result.amount - var_22733eff);
			var_b9ade2a0 = var_67ed7be7 - var_22733eff;
			if(self.health != var_b9ade2a0)
			{
				self.health = var_b9ade2a0;
			}
			s_result.amount = var_22733eff;
		}
		else
		{
			if(self.health > 0 && util::getweaponclass(s_result.weapon) === #"weapon_cqb" && s_result.weapon !== getweapon(#"shotgun_trenchgun_t8_upgraded"))
			{
				self.health = self.health + (s_result.amount * 2);
			}
			else if(self.health > 0 && s_result.attacker.var_fd05e363 === s_result.weapon && s_result.attacker.var_b708af7b === #"scepter")
			{
				self.health = self.health + (int(s_result.amount * 0.666));
			}
		}
		var_ef90775c = self.health < 1;
		s_result.attacker util::show_hit_marker(var_ef90775c);
		if(!var_e4eccdc0 && self.health < var_cf6ec580)
		{
			if(self.health < var_3f5e36d1)
			{
				var_e4eccdc0 = 1;
				self setmodel(#"hash_55657a69ddb2f287" + "dmg_02");
				self clientfield::set("" + #"hash_3400ccffbd3d73b3", 3);
			}
			else if(!b_shrunk)
			{
				b_shrunk = 1;
				self setmodel(#"hash_55657a69ddb2f287" + "dmg_01");
				self clientfield::set("" + #"hash_3400ccffbd3d73b3", 2);
			}
		}
	}
	level.var_1012c716++;
	self connectpaths();
	self setmodel(#"hash_55657a69ddb2f287" + "dmg_03");
	self clientfield::set("" + #"hash_3400ccffbd3d73b3", 0);
	self notsolid();
	foreach(var_d8d42129 in struct::get_array(s_blocker.target))
	{
		if(var_d8d42129.b_spawned !== 1)
		{
			var_d8d42129.b_spawned = 1;
			function_4fc9e782(var_d8d42129, n_health);
			waitframe(1);
		}
	}
	if(s_blocker.script_string === #"hash_3f00f45f819284ba")
	{
		level flag::set(#"hash_349bc60cedc7491e");
	}
	else if(level.var_1012c716 == 5)
	{
		zm_powerups::specific_powerup_drop("full_ammo", s_blocker.origin);
	}
}

/*
	Name: function_964dd361
	Namespace: namespace_74905749
	Checksum: 0xFFC7835F
	Offset: 0xF8C0
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function function_964dd361()
{
	wait(1);
	if(isdefined(level.a_mdl_blockers))
	{
		array::remove_undefined(level.a_mdl_blockers);
		foreach(mdl_blocker in level.a_mdl_blockers)
		{
			mdl_blocker connectpaths();
			mdl_blocker delete();
			waitframe(1);
		}
	}
}

/*
	Name: function_365aa198
	Namespace: namespace_74905749
	Checksum: 0x28527241
	Offset: 0xF998
	Size: 0x4A2
	Parameters: 0
	Flags: Linked
*/
function function_365aa198()
{
	level flag::clear("spawn_zombies");
	level flag::clear("zombie_drop_powerups");
	level flag::set(#"pause_round_timeout");
	level.var_11f7a9af = 1;
	level thread function_7c85a743();
	level endon(#"spawn_zombies", #"hash_349bc60cedc7491e");
	n_round_number = max(level.round_number, 20);
	n_max = zombie_utility::function_d2dfacfd(#"zombie_max_ai");
	var_e8ebec1d = array(#"transform1", #"transform2", #"transform3", #"transform4");
	level.var_8a64ef3a = 0;
	while(true)
	{
		a_s_spawnpoints = get_spawnpoints(1, 4);
		if(!a_s_spawnpoints.size)
		{
			wait(0.1);
			continue;
		}
		foreach(s_spawnpoint in a_s_spawnpoints)
		{
			spawner = array::random(level.zombie_spawners);
			ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, s_spawnpoint, n_round_number);
			if(isdefined(ai))
			{
				ai.var_12745932 = 1;
				ai.exclude_cleanup_adding_to_total = 1;
				ai util::delay(15, "death", &function_71d1696b, 9, array::random(var_e8ebec1d));
				s_spawnpoint.var_96a8b34a = 1;
				s_spawnpoint util::delay(1, undefined, &clear_spawnpoint);
				waitframe(randomintrange(10, 15));
			}
			else
			{
				waitframe(1);
			}
			a_ai_enemies = getaiteamarray(level.zombie_team);
			while(getaiteamarray(level.zombie_team).size >= n_max)
			{
				var_9dfc9362 = 0;
				foreach(ai_enemy in a_ai_enemies)
				{
					ai_enemy zm_cleanup::do_cleanup_check(1048576);
					util::wait_network_frame();
					var_7e4af4d9 = getaiteamarray(level.zombie_team);
					if(var_7e4af4d9.size < n_max - 4)
					{
						var_9dfc9362 = 1;
						break;
					}
				}
				if(var_9dfc9362)
				{
					break;
				}
				a_ai_enemies = getaiteamarray(level.zombie_team);
			}
		}
	}
}

/*
	Name: clear_spawnpoint
	Namespace: namespace_74905749
	Checksum: 0xCED79A5
	Offset: 0xFE48
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function clear_spawnpoint()
{
	self.var_96a8b34a = undefined;
}

/*
	Name: get_spawnpoints
	Namespace: namespace_74905749
	Checksum: 0x1C4846DC
	Offset: 0xFE60
	Size: 0x32A
	Parameters: 2
	Flags: Linked
*/
function get_spawnpoints(var_78837396 = 1, var_7d9a5da1)
{
	a_s_spawnpoints = [];
	foreach(player in util::get_active_players())
	{
		if(!isalive(player))
		{
			continue;
		}
		s_zone = undefined;
		if(isdefined(player.zone_name))
		{
			s_zone = level.zones[player.zone_name];
		}
		if(!isdefined(s_zone))
		{
			continue;
		}
		a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(s_zone.name + "_spawns"), 0, 0);
		if(var_78837396)
		{
			var_9b69c01b = getarraykeys(s_zone.adjacent_zones);
			foreach(str_zone in var_9b69c01b)
			{
				if(s_zone.adjacent_zones[str_zone].is_connected)
				{
					a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawns"), 0, 0);
				}
			}
		}
	}
	a_s_spawnpoints = function_8046369(a_s_spawnpoints);
	foreach(s_spawn in a_s_spawnpoints)
	{
		if(s_spawn.var_96a8b34a === 1)
		{
			arrayremovevalue(a_s_spawnpoints, s_spawn, 1);
		}
	}
	if(a_s_spawnpoints.size)
	{
		s_final = struct::get(#"hash_3f00f45f819284ba", "script_string");
		a_s_spawnpoints = arraysortclosest(a_s_spawnpoints, s_final.origin, var_7d9a5da1);
	}
	return a_s_spawnpoints;
}

/*
	Name: function_353e1c69
	Namespace: namespace_74905749
	Checksum: 0x9401A5D
	Offset: 0x10198
	Size: 0x3DE
	Parameters: 1
	Flags: Linked
*/
function function_353e1c69(mdl_blocker)
{
	level endon(#"frozen_timeout", #"hash_349bc60cedc7491e", #"spawn_zombies");
	mdl_blocker waittill(#"death");
	waitframe(randomint(5));
	a_players = util::get_active_players();
	a_spawn_structs = struct::get_array(self.script_spawn, "script_spawn");
	var_af1d9eb1 = arraycopy(a_spawn_structs);
	foreach(s_spawn in a_spawn_structs)
	{
		if(s_spawn.targetname !== #"step7_stoker" && s_spawn.targetname !== #"hash_21b17b50ba89b6ae" || (isdefined(s_spawn.script_int) && s_spawn.script_int > a_players.size))
		{
			arrayremovevalue(var_af1d9eb1, s_spawn, 1);
			continue;
		}
		foreach(player in a_players)
		{
			if(isdefined(player) && player util::is_looking_at(s_spawn.origin, undefined, 1, vectorscale((0, 0, 1), 32)))
			{
				arrayremovevalue(var_af1d9eb1, s_spawn, 1);
				continue;
			}
			waitframe(1);
		}
	}
	n_round_number = max(level.round_number, 20);
	var_af1d9eb1 = array::remove_undefined(var_af1d9eb1);
	var_af1d9eb1 = arraysortclosest(var_af1d9eb1, self.origin, a_players.size);
	foreach(s_spawn in var_af1d9eb1)
	{
		if(s_spawn.targetname == #"step7_stoker")
		{
			ai_stoker = zm_ai_stoker::spawn_single(1, s_spawn, n_round_number);
			if(isdefined(ai_stoker))
			{
				ai_stoker.var_12745932 = 1;
			}
		}
		else if(s_spawn.targetname == #"hash_21b17b50ba89b6ae")
		{
			function_204d58b0(s_spawn, n_round_number);
		}
		waitframe(1);
	}
}

/*
	Name: function_204d58b0
	Namespace: namespace_74905749
	Checksum: 0x3F121401
	Offset: 0x10580
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_204d58b0(s_spawn_point, n_round_number)
{
	var_c08116d5 = getspawnerarray("zombie_blight_father_spawner", "script_noteworthy");
	var_c08116d5[0].script_forcespawn = 1;
	ai_blight_father = zombie_utility::spawn_zombie(var_c08116d5[0], undefined, s_spawn_point, n_round_number);
	if(!isdefined(ai_blight_father))
	{
		return;
	}
	ai_blight_father.var_12745932 = 1;
	ai_blight_father zm_transform::function_bbaec2fd();
	ai_blight_father forceteleport(s_spawn_point.origin, s_spawn_point.angles);
}

/*
	Name: function_7c85a743
	Namespace: namespace_74905749
	Checksum: 0x5AF57C81
	Offset: 0x10660
	Size: 0x2B6
	Parameters: 0
	Flags: Linked
*/
function function_7c85a743()
{
	n_max_dist = 2500;
	while(!level flag::get("spawn_zombies") && !level flag::get(#"hash_349bc60cedc7491e"))
	{
		var_2b267dc2 = undefined;
		a_stokers = getaiarchetypearray(#"stoker");
		if(a_stokers.size > 5)
		{
			foreach(stoker in a_stokers)
			{
				foreach(player in util::get_active_players())
				{
					if(!isalive(stoker) || stoker cansee(player))
					{
						break;
					}
					n_dist = distancesquared(player.origin, stoker.origin);
					if(n_dist > n_max_dist)
					{
						n_max_dist = n_dist;
						var_2b267dc2 = stoker;
					}
					waitframe(1);
				}
			}
			if(isalive(var_2b267dc2))
			{
				if(zm_utility::is_magic_bullet_shield_enabled(var_2b267dc2))
				{
					var_2b267dc2 util::stop_magic_bullet_shield();
				}
				/#
					/#
						assert(var_2b267dc2.allowdeath);
					#/
				#/
				if(isdefined(var_2b267dc2.allowdeath) && var_2b267dc2.allowdeath)
				{
					var_2b267dc2 kill();
				}
			}
		}
		wait(3);
	}
}

/*
	Name: function_5b7a1511
	Namespace: namespace_74905749
	Checksum: 0xED76BEE8
	Offset: 0x10920
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_5b7a1511(var_5ea5c94d)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_5d7e4ccce97334e0", 8);
	if(!var_5ea5c94d)
	{
		function_9003b2d4();
		function_7b4cd474();
	}
}

/*
	Name: function_98cdd988
	Namespace: namespace_74905749
	Checksum: 0x6DDD31D5
	Offset: 0x10988
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_98cdd988(var_5ea5c94d, ended_early)
{
	level flag::clear(#"hash_280d10a2ac060edb");
	if(!var_5ea5c94d)
	{
		playsoundatposition(#"hash_e0f3075083dd79c", (0, 0, 0));
	}
}

/*
	Name: function_9003b2d4
	Namespace: namespace_74905749
	Checksum: 0x8F3691E
	Offset: 0x109F8
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function function_9003b2d4()
{
	s_struct = struct::get(#"final_portal");
	s_struct.var_f50e3c9d = 1;
	level thread function_4d356dc0(s_struct, s_struct);
	util::delay(5, undefined, &function_d4b31d36, s_struct.origin, #"circle_appears");
	s_struct function_6099877a();
	s_struct.var_b7273b77 = 0;
	function_d3786e2e(getent("iceberg_water", "targetname") getentitynumber());
	level clientfield::set("" + #"hash_3c58464f16d8a1be", 1);
	level.disable_nuke_delay_spawning = 1;
	level notify(#"disable_nuke_delay_spawning");
	level flag::set(#"hash_280d10a2ac060edb");
	level flag::clear("spawn_zombies");
	level flag::set(#"pause_round_timeout");
	level flag::set(#"hash_1b9ecc7979b0fcfb");
	level clientfield::set("fasttravel_exploder", 0);
}

/*
	Name: function_c8c01471
	Namespace: namespace_74905749
	Checksum: 0xFA63AD98
	Offset: 0x10C08
	Size: 0x3D8
	Parameters: 0
	Flags: Linked
*/
function function_c8c01471()
{
	a_spawns = struct::get_array(#"water_corpse");
	var_260d8941 = getspawnerarray("spawner_zombie_water", "targetname")[0];
	a_corpses = [];
	var_f6b33772 = 0;
	level thread function_897177b9();
	foreach(spawn in a_spawns)
	{
		ai_corpse = var_260d8941 spawnfromspawner(0, 1, 1, 1);
		if(!isdefined(ai_corpse))
		{
			var_f6b33772++;
			if(var_f6b33772 < 20)
			{
				if(!isdefined(a_spawns))
				{
					a_spawns = [];
				}
				else if(!isarray(a_spawns))
				{
					a_spawns = array(a_spawns);
				}
				a_spawns[a_spawns.size] = spawn;
			}
			waitframe(1);
			continue;
		}
		if(!isdefined(a_corpses))
		{
			a_corpses = [];
		}
		else if(!isarray(a_corpses))
		{
			a_corpses = array(a_corpses);
		}
		a_corpses[a_corpses.size] = ai_corpse;
		ai_corpse.var_c8de8fdc = 1;
		ai_corpse.b_ignore_cleanup = 1;
		ai_corpse.dont_throw_gib = 1;
		ai_corpse forceteleport(spawn.origin, spawn.angles);
		util::wait_network_frame();
		ai_corpse kill();
		ai_corpse startragdoll(1);
		waitframe(1);
	}
	foreach(player in util::get_active_players())
	{
		player clientfield::set_to_player("" + #"hash_58b44c320123e829", 1);
	}
	level flag::wait_till_clear(#"hash_280d10a2ac060edb");
	foreach(ai in a_corpses)
	{
		if(isdefined(ai))
		{
			ai delete();
		}
	}
}

/*
	Name: function_897177b9
	Namespace: namespace_74905749
	Checksum: 0xDB2B1334
	Offset: 0x10FE8
	Size: 0x3B8
	Parameters: 0
	Flags: Linked
*/
function function_897177b9()
{
	a_props = [];
	a_str_models = array("p7_shr_weapon_axe_03", "p7_shr_weapon_axe_04", "p7_shr_weapon_spear_med", "p7_shr_weapon_spear_sml", "p7_shr_weapon_bow_02", "p7_shr_suit_armor_helmet_03", "p7_shr_weapon_axe_03", "p7_shr_weapon_spear_med", "p7_shr_weapon_bow_02", "p7_shr_suit_armor_helmet_03");
	a_str_models = array::randomize(a_str_models);
	a_spots = array::randomize(struct::get_array(#"water_prop", "script_noteworthy"));
	foreach(spot in a_spots)
	{
		n_x_offset = randomintrange(-128, 128);
		n_y_offset = randomintrange(-128, 128);
		n_z_offset = randomintrange(-64, 64);
		str_model = array::pop_front(a_str_models);
		mdl_prop = util::spawn_model(str_model, spot.origin + (n_x_offset, n_y_offset, n_z_offset), spot.angles + (n_x_offset, n_y_offset, n_z_offset));
		if(!isdefined(a_props))
		{
			a_props = [];
		}
		else if(!isarray(a_props))
		{
			a_props = array(a_props);
		}
		a_props[a_props.size] = mdl_prop;
		mdl_prop rotate((randomint(10), randomint(10), randomint(10)));
		mdl_prop clientfield::set("" + #"water_props", 1);
		if(!a_str_models.size)
		{
			return;
		}
		waitframe(1);
	}
	level waittill(#"hash_78e23a0f092a6560");
	foreach(mdl_prop in a_props)
	{
		if(isdefined(mdl_prop))
		{
			mdl_prop delete();
		}
	}
}

/*
	Name: function_7b4cd474
	Namespace: namespace_74905749
	Checksum: 0xB8E4D766
	Offset: 0x113A8
	Size: 0xB44
	Parameters: 0
	Flags: Linked
*/
function function_7b4cd474()
{
	var_a93e2138 = getent("forget_what_you_know", "targetname");
	a_scenes = scene::get_active_scenes("p8_fxanim_zm_zod_skybox_bundle");
	if(!isdefined(a_scenes))
	{
		a_scenes = scene::get_inactive_scenes("p8_fxanim_zm_zod_skybox_bundle");
	}
	if(!a_scenes.size)
	{
		var_f7d93bcb = array();
	}
	else
	{
		var_f7d93bcb = a_scenes[0].scene_ents;
	}
	a_names = getarraykeys(var_f7d93bcb);
	level scene::stop("p8_fxanim_zm_zod_skybox_bundle");
	for(i = 0; i < var_f7d93bcb.size; i++)
	{
		if(!isdefined(a_names[i]) || !isdefined(var_f7d93bcb[a_names[i]]) || !ishash(a_names[i]) || a_names[i] === #"skybox_water")
		{
			arrayremovevalue(var_f7d93bcb, var_f7d93bcb[a_names[i]], 0);
		}
	}
	if(!isdefined(var_f7d93bcb))
	{
		var_f7d93bcb = [];
	}
	else if(!isarray(var_f7d93bcb))
	{
		var_f7d93bcb = array(var_f7d93bcb);
	}
	var_f7d93bcb[var_f7d93bcb.size] = var_a93e2138;
	s_tree = struct::get(#"hash_1022226235c54b6");
	if(!getdvarint(#"hash_7919e37cd5d57659", 0))
	{
		level.zm_bgb_anywhere_but_here_validation_override = &return_false;
		s_loc = struct::get(#"hash_3f00f45f819284ba", "script_string");
		level thread function_43a16eb7(#"interior_interact", s_loc);
		foreach(player in util::get_active_players())
		{
			player clientfield::set_to_player("" + #"icy_bubbles", 1);
		}
		level thread function_c8c01471();
		level waittill(#"hash_332a98e65f5dce4");
		level.musicsystemoverride = 1;
		music::setmusicstate("location_tree");
		a_players = util::get_active_players();
		foreach(player in a_players)
		{
			player.var_f07d3654 = 1;
			player val::set(#"iceberg_event", "takedamage", 0);
			player val::set(#"iceberg_event", "ignoreme", 1);
		}
		var_f5cdb102 = getent("special_entity", "targetname");
		if(isdefined(var_f5cdb102))
		{
			var_f5cdb102 clientfield::set("" + #"pulse_shader", 1);
		}
		level thread function_77a859a8();
		var_18090dd1 = spawn("script_origin", s_tree.origin);
		var_18090dd1 playloopsound(#"hash_73e107b21dfb7f37");
		s_tree function_6099877a(128);
		var_18090dd1 delete();
		function_28228fa2(s_tree);
	}
	foreach(player in util::get_active_players())
	{
		player clientfield::set_to_player("" + #"icy_bubbles", 0);
	}
	var_a93e2138 show();
	level thread function_43a16eb7(#"iceberg_viewing", s_tree);
	level waittill(#"hash_332a98e65f5dce4");
	level clientfield::set("" + #"hash_3c58464f16d8a1be", 0);
	music::setmusicstate("none");
	level.musicsystemoverride = 0;
	zm_audio::sndvoxoverride(1);
	waitframe(1);
	util::delay(3.5, undefined, &function_53802e89, #"hash_3d70e83c6d1a839d", undefined, array(4, 3, 1, 2), 2);
	a_players = util::get_active_players();
	foreach(player in a_players)
	{
		player.var_f07d3654 = 0;
		player val::reset(#"iceberg_event", "freezecontrols_allowlook");
		player val::set(#"iceberg_event", "freezecontrols", 1);
		player playrumbleonentity(#"hash_676e72d4bae843ff");
	}
	exploder::exploder("exp_lgt_ice_rise");
	var_a93e2138.origin = var_a93e2138.origin - (0, 0, 14400);
	var_a93e2138 playloopsound(#"hash_56a05b30f7dab873");
	var_a93e2138 util::delay(33, "end_game", &function_1cf31801);
	foreach(ent in var_f7d93bcb)
	{
		ent moveto(ent.origin + (0, 0, 14400), 45, 10, 10);
	}
	var_a93e2138 clientfield::set("" + #"hash_15b23de7589e61a", 1);
	exploder::exploder("exp_iceberg_splashes");
	wait(7.5);
	level flag::clear(#"hash_280d10a2ac060edb");
	level thread zodt8_eye::function_c8f90603("bs_blkr_stg_pd", 1);
	foreach(player in a_players)
	{
		if(isdefined(player))
		{
			player val::reset(#"iceberg_event", "freezecontrols");
			player val::reset(#"iceberg_event", "disable_weapons");
			player val::reset(#"iceberg_event", "takedamage");
			player val::reset(#"iceberg_event", "ignoreme");
		}
	}
	var_a93e2138 waittill(#"movedone");
	var_a93e2138 stoploopsound();
	level thread function_50128c10(var_a93e2138, var_f7d93bcb, 14400);
}

/*
	Name: function_1cf31801
	Namespace: namespace_74905749
	Checksum: 0x45695614
	Offset: 0x11EF8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_1cf31801()
{
	self playsound(#"hash_6a836a005e00b6d3");
}

/*
	Name: function_50128c10
	Namespace: namespace_74905749
	Checksum: 0x27AC6EAA
	Offset: 0x11F28
	Size: 0x134
	Parameters: 3
	Flags: Linked
*/
function function_50128c10(var_79727c11, var_f7d93bcb, var_c53a4cdc)
{
	wait(5);
	var_79727c11 playsound(#"hash_474e149664b1d903");
	foreach(mdl in var_f7d93bcb)
	{
		mdl moveto(mdl.origin - (0, 0, var_c53a4cdc), 15, 13, 2);
	}
	mdl waittill(#"movedone");
	var_79727c11 clientfield::set("" + #"hash_15b23de7589e61a", 0);
}

/*
	Name: function_28228fa2
	Namespace: namespace_74905749
	Checksum: 0xA776B41
	Offset: 0x12068
	Size: 0x6B0
	Parameters: 1
	Flags: Linked
*/
function function_28228fa2(s_tree)
{
	mdl_artifact = util::spawn_model(#"hash_3cdbd25e43a09930", s_tree.origin + (vectorscale((-1, 0, 0), 48)), s_tree.angles + vectorscale((0, 1, 0), 180));
	mdl_artifact notsolid();
	mdl_artifact playloopsound(#"hash_e2c71c7dece38ee");
	mdl_artifact playsound(#"hash_7e9d06805545fcfe");
	v_offset = (-4, 0, 16);
	mdl_artifact moveto(s_tree.origin + v_offset, 4);
	var_da9e0035 = struct::get_array(#"hash_78dd4413a014e785");
	a_players = util::get_active_players();
	a_players = arraysort(a_players, s_tree.origin, 0);
	foreach(player in a_players)
	{
		player playersetgroundreferenceent(undefined);
		player clientfield::set_to_player("" + #"iceberg_rumbles", 1);
		var_da9e0035 = arraysortclosest(var_da9e0035, player.origin);
		var_bd99878e = struct::get(var_da9e0035[0].target);
		var_55e11aa9 = util::spawn_model("tag_origin", player.origin, player.angles);
		player playerlinktodelta(var_55e11aa9, "tag_origin", 1, 30, 30, 30, 30, 1, 1);
		player ghost();
		player val::set(#"iceberg_event", "freezecontrols", 1);
		player val::set(#"iceberg_event", "disable_weapons", 1);
		var_55e11aa9 thread function_2f2651ce(var_da9e0035[0], var_bd99878e, player);
		arrayremoveindex(var_da9e0035, 0);
		waitframe(1);
	}
	level waittill(#"hash_78e23a0f092a6560");
	mdl_artifact clientfield::set("" + #"hash_46e2ed49fb0f55c6", 1);
	var_5314bd63 = getent("veh_fasttravel_cam", "targetname");
	n_wait = 5;
	for(i = 0; i < 9; i++)
	{
		nd_path = getvehiclenode("orb_path_" + i, "targetname");
		if(isdefined(nd_path))
		{
			veh_orb = spawner::simple_spawn_single(var_5314bd63);
			veh_orb clientfield::set("" + #"orb_fx", 1);
			veh_orb thread function_6fef3bc3(nd_path);
		}
		if(i == 8)
		{
			veh_orb playrumbleonentity(#"hash_107ea3f0e402de58");
			veh_orb playsound(#"hash_36c85a4ee28dd7a");
		}
		wait(n_wait);
		n_wait = n_wait * 0.6;
		if(i == 2 || i == 4)
		{
			n_wait = n_wait + 1;
		}
	}
	mdl_artifact clientfield::set("" + #"hash_46e2ed49fb0f55c6", 0);
	veh_orb waittilltimeout(10, #"reached_end_node");
	playsoundatposition(#"hash_1a6436fc53efe56f", (0, 0, 0));
	level thread function_63a0f09e(1);
	wait(1);
	foreach(player in a_players)
	{
		if(isdefined(player))
		{
			player playersetgroundreferenceent(level.var_56665536);
		}
	}
}

/*
	Name: function_6fef3bc3
	Namespace: namespace_74905749
	Checksum: 0xEEA01A00
	Offset: 0x12720
	Size: 0x264
	Parameters: 1
	Flags: Linked
*/
function function_6fef3bc3(nd_path)
{
	self vehicle::get_on_and_go_path(nd_path);
	self clientfield::set("" + #"orb_fx", 0);
	if(isdefined(nd_path.targetname))
	{
		switch(nd_path.targetname)
		{
			case "hash_7762924fc6051394":
			{
				str_model = #"p8_zm_zod_planets_mercury_large";
				break;
			}
			case "hash_7762954fc60518ad":
			{
				str_model = #"p8_zm_zod_planets_venus_large";
				break;
			}
			case "hash_7762944fc60516fa":
			{
				str_model = #"p8_zm_zod_planets_mars_large";
				break;
			}
			case "hash_77628f4fc6050e7b":
			{
				str_model = #"p8_zm_zod_planets_jupiter_large";
				break;
			}
			case "hash_77628e4fc6050cc8":
			{
				str_model = #"p8_zm_zod_planets_saturn_large";
				break;
			}
			case "hash_7762914fc60511e1":
			{
				str_model = #"p8_zm_zod_planets_uranus_large";
				break;
			}
			case "hash_7762904fc605102e":
			{
				str_model = #"p8_zm_zod_planets_neptune_large";
				break;
			}
			case "hash_7762934fc6051547":
			{
				str_model = #"p8_zm_zod_planets_sun_large";
				break;
			}
		}
		if(isdefined(str_model))
		{
			var_7ec8be9 = util::spawn_model(str_model, self.origin, nd_path.angles);
			var_7ec8be9 setscale(nd_path.n_scale);
		}
	}
	level waittill(#"hash_332a98e65f5dce4");
	if(isdefined(var_7ec8be9))
	{
		var_7ec8be9 delete();
	}
	self delete();
}

/*
	Name: function_2f2651ce
	Namespace: namespace_74905749
	Checksum: 0x49FC0126
	Offset: 0x12990
	Size: 0x224
	Parameters: 3
	Flags: Linked
*/
function function_2f2651ce(s_setup, s_pushback, player)
{
	self moveto(s_setup.origin, 2);
	wait(0.5);
	self rotateto(s_setup.angles, 1.5);
	player playerlinktoblend(self, "tag_origin");
	wait(3.5);
	level notify(#"hash_78e23a0f092a6560");
	wait(0.1);
	player clientfield::set_to_player("" + #"iceberg_rumbles", 0);
	player val::reset(#"iceberg_event", "freezecontrols");
	player val::set(#"iceberg_event", "freezecontrols_allowlook", 1);
	self moveto(s_pushback.origin, 8, 0.1, 6);
	self rotateto(s_pushback.angles, 8);
	player playerlinktoblend(self, "tag_origin");
	self waittill(#"movedone");
	s_setup struct::delete();
	s_pushback struct::delete();
	self delete();
}

/*
	Name: function_f4b715c1
	Namespace: namespace_74905749
	Checksum: 0x8CE0FA1B
	Offset: 0x12BC0
	Size: 0x264
	Parameters: 1
	Flags: Linked
*/
function function_f4b715c1(var_5ea5c94d)
{
	level zm_ui_inventory::function_7df6bb60(#"hash_5d7e4ccce97334e0", 9);
	foreach(s_magic_box in level.chests)
	{
		if(isdefined(s_magic_box.pandora_light))
		{
			s_magic_box.pandora_light delete();
		}
		for(i = 0; i < s_magic_box.zbarrier getnumzbarrierpieces(); i++)
		{
			s_magic_box.zbarrier hidezbarrierpiece(i);
		}
		if(isdefined(s_magic_box.zbarrier.var_8cab0622))
		{
			s_magic_box.zbarrier.var_8cab0622 thread scene::stop(1);
		}
	}
	if(!var_5ea5c94d)
	{
		foreach(player in util::get_players())
		{
			if(player util::is_spectating())
			{
				player thread zm_player::spectator_respawn_player();
			}
		}
		level.zm_bgb_anywhere_but_here_validation_override = &return_false;
		level.var_88de5053 = 3;
		zm_sq::start(#"boss_fight");
		level flag::wait_till(#"hash_25d8c88ff3f91ee5");
	}
}

/*
	Name: function_b4d0381e
	Namespace: namespace_74905749
	Checksum: 0xE7AE4CF
	Offset: 0x12E30
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function function_b4d0381e(var_5ea5c94d, ended_early)
{
	level flag::set(#"hash_25d8c88ff3f91ee5");
	foreach(player in util::get_active_players())
	{
		player clientfield::set_to_player("water_drippies", 0);
		player val::set(#"outro_igc", "freezecontrols", 1);
	}
}

/*
	Name: function_594ebc75
	Namespace: namespace_74905749
	Checksum: 0xBD080651
	Offset: 0x12F20
	Size: 0x47C
	Parameters: 1
	Flags: Linked
*/
function function_594ebc75(var_5ea5c94d)
{
	level flag::clear("spawn_zombies");
	level flag::set(#"pause_round_timeout");
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			level clientfield::set("" + #"hash_7f2f74f05d1f1b75", 3);
			zm_devgui::zombie_devgui_open_sesame();
			wait(10);
		}
	#/
	level thread function_77a859a8(0, 0);
	level thread function_8c49c8b();
	if(!level flag::get("water_drained_fore"))
	{
		level notify(#"hash_5625f76c55116195");
		level.e_clip_water_fore.origin = (level.e_clip_water_fore.origin[0], level.e_clip_water_fore.origin[1], level.var_1b85943e);
		level.e_clip_water_fore rotateroll(-1.5, 0.1);
		level.e_clip_water_fore waittill(#"rotatedone");
		util::wait_network_frame();
		level.e_clip_water_fore clientfield::increment("update_wave_water_height", 1);
	}
	level.var_56665536 clientfield::set("tilt", 0);
	level scene::stop("p8_fxanim_zm_zod_skybox_bundle");
	getent("ocean_water_hidden", "script_noteworthy") hide();
	hidemiscmodels("mdl_magic_box_base");
	hidemiscmodels("pancakerabbit");
	foreach(ent in getentarray("pancakerabbit", "targetname"))
	{
		ent delete();
	}
	level clientfield::set("" + #"hash_7f2f74f05d1f1b75", 0);
	level clientfield::set("fasttravel_exploder", 0);
	scene::function_d8a83a50("cin_zm_zod_outro", &function_5dc629ad, "play");
	scene::function_d8a83a50("cin_zm_zod_outro", &function_c41154ec, "Shot090");
	scene::function_d8a83a50("cin_zm_zod_outro", &function_44a2fe02, "Shot110");
	scene::function_d8a83a50("cin_zm_zod_outro", &function_d87932b5, "Shot120");
	scene::function_d8a83a50("cin_zm_zod_outro", &end_game, "done");
	level thread scene::play("cin_zm_zod_outro");
}

/*
	Name: function_5dc629ad
	Namespace: namespace_74905749
	Checksum: 0x7D7FD2AE
	Offset: 0x133A8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_5dc629ad()
{
	level thread lui::screen_fade_in(0.25, "white");
}

/*
	Name: function_d87932b5
	Namespace: namespace_74905749
	Checksum: 0x62AFF6E2
	Offset: 0x133E0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_d87932b5()
{
	level waittill(#"hash_431057fdc56bc595");
	level lui::screen_fade_out(2, "white");
}

/*
	Name: function_44a2fe02
	Namespace: namespace_74905749
	Checksum: 0x638005EB
	Offset: 0x13428
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_44a2fe02()
{
	level clientfield::set("" + #"hash_3c58464f16d8a1be", 1);
	getent("mov_ship_rob", "targetname") clientfield::set("" + #"hash_6e41de51a0092771", 0);
}

/*
	Name: end_game
	Namespace: namespace_74905749
	Checksum: 0x7AD4AA76
	Offset: 0x134B8
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function end_game()
{
	level notify(#"end_game");
}

/*
	Name: function_60d50c62
	Namespace: namespace_74905749
	Checksum: 0x5AD924A1
	Offset: 0x134D8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_60d50c62(var_5ea5c94d, ended_early)
{
}

/*
	Name: function_c41154ec
	Namespace: namespace_74905749
	Checksum: 0x135E67D2
	Offset: 0x134F8
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function function_c41154ec()
{
	getent("mov_ship_rob", "targetname") clientfield::set("" + #"hash_6e41de51a0092771", 1);
	a_scenes = scene::get_active_scenes("p8_fxanim_zm_zod_smokestack_01_bundle");
	if(!a_scenes.size)
	{
		a_scenes = scene::get_inactive_scenes("p8_fxanim_zm_zod_smokestack_01_bundle");
	}
	if(a_scenes.size)
	{
		a_ents = a_scenes[0].scene_ents;
		if(isdefined(a_ents))
		{
			foreach(ent in a_ents)
			{
				ent hide();
			}
		}
	}
}

/*
	Name: function_8c49c8b
	Namespace: namespace_74905749
	Checksum: 0x3273BB54
	Offset: 0x13640
	Size: 0x1D6
	Parameters: 0
	Flags: Linked
*/
function function_8c49c8b()
{
	setdvar(#"zombie_unlock_all", 1);
	players = getplayers();
	zombie_doors = getentarray("zombie_door", "targetname");
	for(i = 0; i < zombie_doors.size; i++)
	{
		if(!(isdefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened))
		{
			zombie_doors[i] notify(#"trigger", {#activator:players[0]});
		}
		if(isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait)
		{
			zombie_doors[i] notify(#"power_on");
		}
		waitframe(1);
	}
	zombie_debris = getentarray("zombie_debris", "targetname");
	for(i = 0; i < zombie_debris.size; i++)
	{
		if(isdefined(zombie_debris[i]))
		{
			zombie_debris[i] notify(#"trigger", {#activator:players[0]});
		}
		waitframe(1);
	}
}

/*
	Name: function_6099877a
	Namespace: namespace_74905749
	Checksum: 0xF75FDBEC
	Offset: 0x13820
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_6099877a(n_radius = 96, str_endon)
{
	s_unitrigger = self zm_unitrigger::function_a7620bfb(n_radius, 0);
	s_unitrigger.related_parent = self;
	zm_unitrigger::register_static_unitrigger(s_unitrigger, &function_715588b3);
	if(isdefined(str_endon))
	{
		level endon(str_endon);
		level thread function_f4482deb(s_unitrigger, str_endon);
	}
	s_unitrigger waittill(#"hash_4993ab35c53e0b5c");
}

/*
	Name: function_715588b3
	Namespace: namespace_74905749
	Checksum: 0xAD0E6D2
	Offset: 0x138E8
	Size: 0x24C
	Parameters: 0
	Flags: Linked
*/
function function_715588b3()
{
	self endon(#"death");
	s_unitrigger = self.stub;
	self thread function_45c58b56(self.stub.related_parent);
	while(true)
	{
		self waittill(#"trigger");
		b_using = 1;
		n_time = 0;
		while(n_time < 0.5)
		{
			foreach(player in util::get_active_players())
			{
				if(player util::is_spectating())
				{
					continue;
				}
				if(!player usebuttonpressed() || !zm_utility::can_use(player) || player isinmovemode("ufo", "noclip") || !player istouching(self))
				{
					b_using = 0;
					n_time = 0;
					break;
				}
			}
			if(b_using == 0 || util::get_active_players().size == 0)
			{
				break;
			}
			wait(0.1);
			n_time = n_time + 0.1;
		}
		if(b_using == 1)
		{
			break;
		}
		wait(0.1);
	}
	s_unitrigger notify(#"hash_4993ab35c53e0b5c");
	zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: function_45c58b56
	Namespace: namespace_74905749
	Checksum: 0xCBE1EA01
	Offset: 0x13B40
	Size: 0x3D0
	Parameters: 1
	Flags: Linked
*/
function function_45c58b56(s_portal)
{
	if(isdefined(s_portal.mdl_portal))
	{
		self endon(#"death");
		s_portal.mdl_portal clientfield::set("" + #"teleport_sigil", 1);
		waitframe(1);
		while(1 && isdefined(s_portal.mdl_portal))
		{
			streamermodelhint(#"p8_zm_zod_teleport_symbol", 0.5);
			streamermodelhint(#"hash_15e8ba772c745d63", 0.5);
			if(s_portal.mdl_portal.var_22763205 === 1)
			{
				b_activate = 1;
				foreach(player in util::get_active_players())
				{
					if(!zm_utility::can_use(player) || !player istouching(self))
					{
						b_activate = 0;
						break;
					}
				}
				if(b_activate == 1 && util::get_active_players().size > 0)
				{
					if(s_portal.mdl_portal.model !== #"p8_zm_zod_teleport_symbol")
					{
						s_portal.mdl_portal setmodel(#"p8_zm_zod_teleport_symbol");
						s_portal.mdl_portal playsound(#"hash_1644d20be9e19c9f");
						s_portal.mdl_portal clientfield::set("" + #"teleport_sigil", 0);
						if(isdefined(self.stub.related_parent.var_f50e3c9d) && self.stub.related_parent.var_f50e3c9d)
						{
							self sethintstring(#"hash_6d663dca450595ef");
						}
					}
				}
				else if(s_portal.mdl_portal.model !== #"hash_15e8ba772c745d63")
				{
					s_portal.mdl_portal setmodel(#"hash_15e8ba772c745d63");
					s_portal.mdl_portal playsound(#"hash_68f60cc0248fcc9b");
					s_portal.mdl_portal clientfield::set("" + #"teleport_sigil", 1);
					self sethintstring("");
				}
			}
			wait(0.5);
		}
	}
}

/*
	Name: function_f4482deb
	Namespace: namespace_74905749
	Checksum: 0x220A75F5
	Offset: 0x13F18
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function function_f4482deb(s_unitrigger, str_endon)
{
	s_unitrigger endon(#"hash_4993ab35c53e0b5c");
	level waittill(str_endon);
	zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: function_43a16eb7
	Namespace: namespace_74905749
	Checksum: 0xC9DADEA8
	Offset: 0x13F70
	Size: 0x15C
	Parameters: 2
	Flags: Linked
*/
function function_43a16eb7(var_e6d63e1c, s_loc)
{
	zm_audio::sndvoxoverride(1);
	a_s_locs = struct::get_array(var_e6d63e1c, "script_teleport");
	a_players = util::get_active_players();
	level thread function_26284c6a(a_players);
	foreach(player in a_players)
	{
		player thread zm_fasttravel::function_66d020b0(undefined, undefined, undefined, #"hash_1d62cb1087778988", a_s_locs, s_loc, undefined, 1);
	}
	level waittill(#"hash_1d62cb1087778988");
	level util::delay(1, undefined, &zm_audio::sndvoxoverride, 0);
}

/*
	Name: function_26284c6a
	Namespace: namespace_74905749
	Checksum: 0xC246666E
	Offset: 0x140D8
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function function_26284c6a(a_players)
{
	array::wait_till(a_players, #"hash_1c35eb15aa210d6", 1);
	level notify(#"hash_332a98e65f5dce4");
}

/*
	Name: function_77a859a8
	Namespace: namespace_74905749
	Checksum: 0x429A088
	Offset: 0x14128
	Size: 0x1DE
	Parameters: 3
	Flags: Linked
*/
function function_77a859a8(var_82ea43f2 = 0, var_a8d0b313 = 1, b_hide_body = 1)
{
	foreach(ai in getaiteamarray(level.zombie_team))
	{
		if(isalive(ai) && (!(isdefined(ai.var_c8de8fdc) && ai.var_c8de8fdc)))
		{
			if(var_a8d0b313)
			{
				level.zombie_total++;
				level.zombie_respawns++;
			}
			if(var_82ea43f2 || ai.archetype === #"blight_father")
			{
				if(zm_utility::is_magic_bullet_shield_enabled(ai))
				{
					ai util::stop_magic_bullet_shield();
				}
				ai.allowdeath = 1;
				ai kill();
				if(b_hide_body)
				{
					ai hide();
					ai notsolid();
				}
			}
			else
			{
				ai delete();
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_63a0f09e
	Namespace: namespace_74905749
	Checksum: 0x4B77E413
	Offset: 0x14310
	Size: 0x288
	Parameters: 2
	Flags: Linked
*/
function function_63a0f09e(b_success = 1, var_d1a2823e = 1)
{
	a_players = util::get_active_players();
	foreach(player in a_players)
	{
		player val::set(#"hash_519b32068605d08f", "takedamage", 0);
		if(var_d1a2823e)
		{
			player val::set(#"hash_519b32068605d08f", "freezecontrols", 1);
		}
		player clientfield::set_to_player("" + #"main_flash", b_success);
	}
	if(!b_success)
	{
		lui::screen_flash(0.5, 2, 0.5, 1, "black");
	}
	wait(0.5 + 2);
	foreach(player in a_players)
	{
		if(isdefined(player))
		{
			player val::reset(#"hash_519b32068605d08f", "takedamage");
			if(var_d1a2823e)
			{
				player val::reset(#"hash_519b32068605d08f", "freezecontrols");
			}
			player clientfield::set_to_player("" + #"main_flash", 0);
		}
	}
}

/*
	Name: function_d4b31d36
	Namespace: namespace_74905749
	Checksum: 0x90D0E58A
	Offset: 0x145A0
	Size: 0xF2
	Parameters: 3
	Flags: Linked
*/
function function_d4b31d36(v_origin, var_39acfdda, str_category = #"m_quest")
{
	level endon(var_39acfdda + "vo_end");
	level util::delay_notify(10, var_39acfdda + "vo_end", var_39acfdda + "vo_played");
	do
	{
		var_27b13fab = zm_utility::get_closest_player(v_origin);
		b_played = var_27b13fab zm_audio::create_and_play_dialog(str_category, var_39acfdda);
		waitframe(1);
	}
	while(b_played !== 1);
	level notify(var_39acfdda + "vo_played");
	return true;
}

/*
	Name: function_53802e89
	Namespace: namespace_74905749
	Checksum: 0xB086A3A8
	Offset: 0x146A0
	Size: 0x1C0
	Parameters: 4
	Flags: Linked
*/
function function_53802e89(str_vox, v_loc, var_c30ae85a, var_3d981e0b)
{
	for(i = 0; i < var_c30ae85a.size; i++)
	{
		a_players = util::get_active_players();
		if(isdefined(v_loc))
		{
			a_players = arraysortclosest(a_players, v_loc, undefined, undefined, 512);
		}
		foreach(player in a_players)
		{
			if(player zm_characters::function_d35e4c92() == var_c30ae85a[i])
			{
				while(isalive(player) && player isplayerunderwater())
				{
					waitframe(1);
				}
				if(isalive(player))
				{
					if(isdefined(v_loc))
					{
						v_loc = player.origin;
					}
					player zm_vo::function_a2bd5a0c(str_vox);
					if(isdefined(var_3d981e0b))
					{
						wait(var_3d981e0b);
					}
				}
				break;
			}
		}
		waitframe(1);
	}
	level notify(#"hash_5286b6160d468570");
}

/*
	Name: gear_up
	Namespace: namespace_74905749
	Checksum: 0x8E0EB4B0
	Offset: 0x14868
	Size: 0x5AC
	Parameters: 2
	Flags: None
*/
function gear_up(b_packed, var_5b901c1)
{
	/#
		if(!isdefined(b_packed))
		{
			b_packed = 1;
		}
		if(!isdefined(var_5b901c1))
		{
			var_5b901c1 = 1;
		}
		players = getplayers();
		var_c9612d27 = array(#"ww_tricannon_water_t8", #"ww_tricannon_air_t8", #"ww_tricannon_fire_t8");
		var_2ebde1ac = array::randomize(array(#"shotgun_semiauto_t8", #"ww_tricannon_earth_t8", array::random(var_c9612d27), array::random(var_c9612d27)));
		var_dd063e3e = array::randomize(array(#"lmg_spray_t8", #"ar_mg1909_t8", #"lmg_heavy_t8", #"lmg_double_t8"));
		foreach(player in players)
		{
			if(!player laststand::player_is_in_laststand())
			{
				player giveweapon(getweapon(#"zhield_dw"));
				player zm_perks::function_869a50c0(4);
				if(!var_dd063e3e.size || !var_2ebde1ac.size)
				{
					break;
				}
				foreach(w_primary in player getweaponslistprimaries())
				{
					player takeweapon(w_primary);
				}
				weapon1 = getweapon(var_dd063e3e[0]);
				weapon2 = getweapon(var_2ebde1ac[0]);
				arrayremovevalue(var_dd063e3e, var_dd063e3e[0], 0);
				arrayremovevalue(var_2ebde1ac, var_2ebde1ac[0], 0);
				if(b_packed)
				{
					weapon1 = zm_devgui::get_upgrade(weapon1.rootweapon);
					weapon2 = zm_devgui::get_upgrade(weapon2.rootweapon);
				}
				weapon1 = player zm_weapons::give_build_kit_weapon(weapon1);
				weapon2 = player zm_weapons::give_build_kit_weapon(weapon2);
				if(isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon1))
				{
					player thread aat::acquire(weapon1);
					player zm_pap_util::repack_weapon(weapon1, 4);
				}
				if(isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon2))
				{
					player thread aat::acquire(weapon2);
					player zm_pap_util::repack_weapon(weapon2, 4);
				}
				player zm_hero_weapon::function_1bb7f7b1(3);
			}
		}
		array::pop(players, randomint(players.size), 0) giveweapon(getweapon(#"homunculus"));
		if(players.size)
		{
			array::pop(players, randomint(players.size)) giveweapon(getweapon(#"homunculus"));
		}
	#/
}

/*
	Name: function_1734a3af
	Namespace: namespace_74905749
	Checksum: 0x473871B9
	Offset: 0x14E20
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_1734a3af(s_spark)
{
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			level waittill(#"all_players_spawned");
			level thread function_bcdb8fc4(s_spark);
			function_3965c201(s_spark);
		}
	#/
}

