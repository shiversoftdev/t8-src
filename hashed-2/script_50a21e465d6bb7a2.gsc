// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_24c32478acf44108;
#using script_28b18e98462a3c7c;
#using script_3510d12b63a575c3;
#using script_3cebb48c37fc271;
#using script_3f9e0dc8454d98e1;
#using script_48dd035d23bf8844;
#using script_6c5b51f98cd04fa3;
#using script_6ce38ab036223e6e;
#using script_78e9e286015f2ec;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_29f39efb;

/*
	Name: function_89f2df9
	Namespace: namespace_29f39efb
	Checksum: 0x8A802AD
	Offset: 0x330
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_a3c193a2e252a90", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_29f39efb
	Checksum: 0xBC6572DA
	Offset: 0x380
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
}

/*
	Name: __main__
	Namespace: namespace_29f39efb
	Checksum: 0xD6F27554
	Offset: 0x3A0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	init_flags();
	function_88d1bd71();
}

/*
	Name: init_clientfields
	Namespace: namespace_29f39efb
	Checksum: 0xADE10985
	Offset: 0x3D0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("vehicle", "fx8_insanity_wisp", 18000, 1, "int");
}

/*
	Name: init_flags
	Namespace: namespace_29f39efb
	Checksum: 0xD05DA958
	Offset: 0x410
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	if(zm_utility::function_e51dc2d8())
	{
		level flag::init(#"hash_684fc43e0573043f");
		level flag::init(#"hash_a54ffd2751ba9de");
		level flag::init(#"hash_13cf89176254a394");
		level flag::init(#"hash_136314b16639d725");
		level flag::init(#"hash_eb582974245f076");
		level flag::init(#"hash_12b747be855cc622");
		level flag::init(#"hash_7cd09ec15b9808a9");
		level flag::init(#"insanity_mode_triggered");
	}
}

/*
	Name: function_88d1bd71
	Namespace: namespace_29f39efb
	Checksum: 0x7C7AA29
	Offset: 0x530
	Size: 0x3B4
	Parameters: 0
	Flags: Linked
*/
function function_88d1bd71()
{
	if(zm_utility::function_e51dc2d8())
	{
		level.var_d416f0ff = spawnstruct();
		nd_start = getvehiclenode("insanity_mode_wisp_path_start", "targetname");
		var_ef55363f = getent("insanity_mode_wisp_info_volume", "targetname");
		if(isdefined(nd_start) && isdefined(var_ef55363f))
		{
			do
			{
				vh_wisp = spawner::simple_spawn_single(getent("veh_insanity_mode_wisp", "targetname"));
				waitframe(1);
			}
			while(!isdefined(vh_wisp));
			vh_wisp.origin = nd_start.origin;
			vh_wisp.angles = nd_start.angles;
			arrayremovevalue(level.ai[#"axis"], vh_wisp);
			var_ef55363f.origin = nd_start.origin;
			var_ef55363f.angles = nd_start.angles;
			var_ef55363f enablelinkto();
			var_ef55363f linkto(vh_wisp);
			vh_wisp.var_ef55363f = var_ef55363f;
			vh_wisp val::set(#"hash_159845592f9ea040", "takedamage", 0);
			level.var_d416f0ff.vh_wisp = vh_wisp;
		}
		function_69a6d31a(0);
		namespace_ee206246::register(#"hash_27806d08798eb77a", #"step_1", #"hash_1ac340ed59970ef4", &function_e62b987d, &function_899db485);
		namespace_ee206246::register(#"hash_27806d08798eb77a", #"step_2", #"hash_1ac343ed5997140d", &function_77a0aab6, &function_e78c6006);
		namespace_ee206246::register(#"hash_27806d08798eb77a", #"step_3", #"hash_1ac342ed5997125a", &function_6699867f, &function_a885d87a);
		namespace_ee206246::register(#"hash_27806d08798eb77a", #"step_4", #"hash_1ac33ded599709db", &function_21b9d36d, &function_6932bc46);
		namespace_ee206246::start(#"hash_27806d08798eb77a");
	}
	else
	{
		function_52a6a332();
	}
}

/*
	Name: function_52a6a332
	Namespace: namespace_29f39efb
	Checksum: 0xDB97CA91
	Offset: 0x8F0
	Size: 0x228
	Parameters: 1
	Flags: Linked
*/
function function_52a6a332(var_1e3deed9 = 1)
{
	var_9d62fe6f = getent("insanity_mode_wisp_start_trigger", "targetname");
	var_ef55363f = getent("insanity_mode_wisp_info_volume", "targetname");
	var_7a5bbd26 = getent("insanity_mode_damage_trigger", "targetname");
	var_d190efa8 = struct::get_array("insanity_mode_zone_containment_model");
	var_bdd13992 = getentarray("insanity_mode_zone_containment_clip", "targetname");
	var_9d62fe6f delete();
	var_ef55363f delete();
	var_7a5bbd26 delete();
	if(var_1e3deed9)
	{
		foreach(var_917ecbff in var_d190efa8)
		{
			if(isdefined(var_917ecbff.e_model))
			{
				var_917ecbff.e_model delete();
			}
		}
		foreach(e_clip in var_bdd13992)
		{
			e_clip delete();
		}
	}
}

/*
	Name: function_e62b987d
	Namespace: namespace_29f39efb
	Checksum: 0x3D89F3FD
	Offset: 0xB20
	Size: 0x2D0
	Parameters: 1
	Flags: Linked
*/
function function_e62b987d(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level waittill(#"update_doomsday_clock");
		var_9d62fe6f = getent("insanity_mode_wisp_start_trigger", "targetname");
		level thread function_4bcfb4d9();
		while(!level flag::get(#"hash_a54ffd2751ba9de"))
		{
			level flag::wait_till(#"hash_35762ecd1ee8f3c1");
			function_d8c5450b();
			level thread function_d7fe6be2();
			a_flags = array(#"hash_35762ecd1ee8f3c1", #"hash_684fc43e0573043f");
			level flag::wait_till_clear_any(a_flags);
			if(!level flag::get(#"hash_35762ecd1ee8f3c1"))
			{
				level notify(#"hash_227a6fc118040203");
				level.var_d416f0ff.vh_wisp clientfield::set("fx8_insanity_wisp", 0);
				continue;
			}
			function_461006d1();
			level flag::set(#"infinite_round_spawning");
			var_f8b0325d = array(#"hash_a54ffd2751ba9de", #"hash_13cf89176254a394");
			level flag::wait_till_any(var_f8b0325d);
			level flag::clear(#"infinite_round_spawning");
			level.var_d416f0ff.vh_wisp clientfield::set("fx8_insanity_wisp", 0);
			if(!level flag::get(#"hash_a54ffd2751ba9de"))
			{
				level waittill(#"start_of_round");
				level flag::clear(#"hash_13cf89176254a394");
				/#
					iprintlnbold("");
				#/
			}
		}
	}
}

/*
	Name: function_899db485
	Namespace: namespace_29f39efb
	Checksum: 0x50BA504D
	Offset: 0xDF8
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_899db485(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_a54ffd2751ba9de");
	}
}

/*
	Name: function_d7fe6be2
	Namespace: namespace_29f39efb
	Checksum: 0xC7892AF8
	Offset: 0xE48
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function function_d7fe6be2()
{
	self endon(#"end_game", #"hash_227a6fc118040203");
	var_9d62fe6f = getent("insanity_mode_wisp_start_trigger", "targetname");
	level flag::set(#"hash_684fc43e0573043f");
	while(level flag::get(#"hash_684fc43e0573043f"))
	{
		a_e_players = getplayers();
		foreach(e_player in a_e_players)
		{
			if(e_player istouching(var_9d62fe6f))
			{
				/#
					iprintlnbold("");
				#/
				level flag::clear(#"hash_684fc43e0573043f");
			}
		}
		wait(0.25);
	}
}

/*
	Name: function_d8c5450b
	Namespace: namespace_29f39efb
	Checksum: 0x24C1AA1D
	Offset: 0xFD0
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_d8c5450b()
{
	nd_start = getvehiclenode("insanity_mode_wisp_path_start", "targetname");
	level.var_d416f0ff.vh_wisp.origin = nd_start.origin;
	level.var_d416f0ff.vh_wisp.angles = nd_start.angles;
	level.var_d416f0ff.vh_wisp vehicle::get_on_path(nd_start);
	wait(0.5);
	level.var_d416f0ff.vh_wisp clientfield::set("fx8_insanity_wisp", 1);
}

/*
	Name: function_461006d1
	Namespace: namespace_29f39efb
	Checksum: 0xEBAB9911
	Offset: 0x10B0
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_461006d1()
{
	nd_start = getvehiclenode("insanity_mode_wisp_path_start", "targetname");
	vh_wisp = level.var_d416f0ff.vh_wisp;
	vh_wisp thread function_7cfef7a8();
	vh_wisp playsound(#"hash_591341e81a7abb0");
	vh_wisp vehicle::get_on_path(nd_start);
	vh_wisp vehicle::resume_path();
	vh_wisp thread vehicle::get_on_and_go_path(nd_start);
	vh_wisp thread function_dba32984();
	vh_wisp setspeed(6);
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_dba32984
	Namespace: namespace_29f39efb
	Checksum: 0x6667CC7C
	Offset: 0x11D8
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function function_dba32984()
{
	level endon(#"hash_a54ffd2751ba9de", #"hash_13cf89176254a394");
	if(isdefined(self.var_ef55363f))
	{
		var_c299518b = 1;
		a_e_players = getplayers();
		while(var_c299518b)
		{
			wait(0.25);
			foreach(e_player in a_e_players)
			{
				var_c299518b = 0;
				if(e_player istouching(self.var_ef55363f))
				{
					var_c299518b = 1;
				}
			}
		}
		self playsound(#"hash_4f86aa0523c734ed");
		/#
			iprintlnbold("");
		#/
		self vehicle::pause_path();
		level flag::set(#"hash_13cf89176254a394");
	}
}

/*
	Name: function_7cfef7a8
	Namespace: namespace_29f39efb
	Checksum: 0xADCCB09
	Offset: 0x1360
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_7cfef7a8()
{
	self waittill(#"hash_28a9083d4bf6e717");
	level flag::set(#"hash_a54ffd2751ba9de");
}

/*
	Name: function_4bcfb4d9
	Namespace: namespace_29f39efb
	Checksum: 0x378ED6EA
	Offset: 0x13A8
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function function_4bcfb4d9()
{
	self endon(#"hash_a54ffd2751ba9de", #"magic_door_power_up_grabbed");
	while(true)
	{
		level flag::wait_till(#"hash_35762ecd1ee8f3c1");
		if(!level flag::get(#"hash_13cf89176254a394"))
		{
			level.door_powerup zm_powerups::powerup_delete();
			level flag::wait_till_clear(#"hash_35762ecd1ee8f3c1");
			namespace_456de992::door_powerup_drop(level.perk_type, level.ammodrop.origin);
		}
		wait(0.5);
	}
}

/*
	Name: function_77a0aab6
	Namespace: namespace_29f39efb
	Checksum: 0x9BBD846
	Offset: 0x1498
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_77a0aab6(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		pixbeginevent(#"hash_7e38a18c8bc5484c");
		level thread namespace_7d8e6ec3::function_5fbede7a();
		var_7a5bbd26 = getent("insanity_mode_damage_trigger", "targetname");
		while(true)
		{
			waitresult = undefined;
			waitresult = var_7a5bbd26 waittill(#"damage");
			if(waitresult.weapon == getweapon(#"bowie_knife_story_1"))
			{
				level thread namespace_7d8e6ec3::function_60f15ca8();
				level flag::set(#"hash_136314b16639d725");
				break;
			}
		}
		pixendevent();
	}
}

/*
	Name: function_e78c6006
	Namespace: namespace_29f39efb
	Checksum: 0x7922517D
	Offset: 0x15C8
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_e78c6006(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_136314b16639d725");
	}
}

/*
	Name: function_6699867f
	Namespace: namespace_29f39efb
	Checksum: 0x648E4D2B
	Offset: 0x1618
	Size: 0x2D8
	Parameters: 1
	Flags: Linked
*/
function function_6699867f(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		var_9152e2cb = struct::get("insanity_mode_confirmation");
		str_hint = zm_utility::function_d6046228(#"hash_209b7a0a83ce0276", #"hash_683c616025752252");
		while(!flag::get(#"hash_7cd09ec15b9808a9"))
		{
			/#
				iprintlnbold("" + level.var_f13364b4.var_3c358113);
			#/
			level flag::clear(#"hash_eb582974245f076");
			level.var_f13364b4.var_132bd718[level.var_f13364b4.var_3c358113].var_544c05c6 = 1;
			level flag::wait_till(#"hash_eb582974245f076");
			/#
				iprintlnbold("");
			#/
			wait(0.5);
			level.var_c2511d7b = getplayers();
			var_9152e2cb zm_unitrigger::create(str_hint, 96);
			zm_unitrigger::function_89380dda(var_9152e2cb.s_unitrigger, 1);
			var_9152e2cb thread function_3d4b148b();
			level thread function_2ef7822a();
			namespace_3e3742fd::function_63e4838b(1);
			a_flags = array(#"hash_7cd09ec15b9808a9", #"hash_12b747be855cc622");
			level flag::wait_till_any(a_flags);
			if(level flag::get(#"hash_12b747be855cc622") && !level flag::get(#"hash_7cd09ec15b9808a9"))
			{
				zm_unitrigger::unregister_unitrigger(var_9152e2cb.s_unitrigger);
				namespace_3e3742fd::function_63e4838b(0);
				level.countdown_clock namespace_7d8e6ec3::function_9b1511fa();
			}
		}
	}
}

/*
	Name: function_a885d87a
	Namespace: namespace_29f39efb
	Checksum: 0x3CC4C7CD
	Offset: 0x18F8
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_a885d87a(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_eb582974245f076");
		level flag::set(#"hash_7cd09ec15b9808a9");
	}
}

/*
	Name: function_2ef7822a
	Namespace: namespace_29f39efb
	Checksum: 0xF2AE3C7C
	Offset: 0x1968
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_2ef7822a()
{
	level flag::clear(#"hash_12b747be855cc622");
	level endon(#"hash_12b747be855cc622");
	level.countdown_clock namespace_7d8e6ec3::function_4955480();
	level flag::set(#"hash_12b747be855cc622");
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_3d4b148b
	Namespace: namespace_29f39efb
	Checksum: 0xB3ED7A35
	Offset: 0x1A08
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_3d4b148b()
{
	while(level.var_c2511d7b.size > 0)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		arrayremovevalue(level.var_c2511d7b, var_be17187b.e_who);
		/#
			iprintlnbold("" + level.var_c2511d7b.size);
		#/
	}
	level flag::set(#"hash_7cd09ec15b9808a9");
	level flag::set(#"hash_12b747be855cc622");
}

/*
	Name: function_21b9d36d
	Namespace: namespace_29f39efb
	Checksum: 0x692CA68C
	Offset: 0x1AE0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_21b9d36d(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		function_1541f1c9();
	}
}

/*
	Name: function_6932bc46
	Namespace: namespace_29f39efb
	Checksum: 0x841B1867
	Offset: 0x1B10
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_6932bc46(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"insanity_mode_triggered");
	}
}

/*
	Name: function_1541f1c9
	Namespace: namespace_29f39efb
	Checksum: 0x454F8C4
	Offset: 0x1B60
	Size: 0x2A4
	Parameters: 0
	Flags: Linked
*/
function function_1541f1c9()
{
	level.var_73d1e054 = 1;
	level flag::set(#"insanity_mode_triggered");
	level.musicsystemoverride = 1;
	level.var_3c9cfd6f = 1;
	level.var_d555ff19 = 1;
	function_52a6a332(0);
	playsoundatposition(#"hash_83b85ca3e963765", (0, 0, 0));
	level thread lui::screen_flash(1, 2, 1, 1, "white");
	array::run_all(getaiarray(), &namespace_9ff9f642::freeze);
	wait(1);
	namespace_3e3742fd::function_32c317fb();
	namespace_1846c963::function_5c2807fc();
	function_69a6d31a(1);
	function_83c13f8e();
	function_5ac5f2aa();
	function_4f84973a();
	function_ff416940();
	function_7cb78bcd();
	a_e_players = getplayers();
	var_a0b0c8c4 = struct::get_array("insanity_mode_teleport_location", "targetname");
	for(i = 0; i < a_e_players.size; i++)
	{
		a_e_players[i] namespace_eaaeba61::function_2aed1d83(var_a0b0c8c4[i], 1);
	}
	wait(2 + 1);
	function_411302d7();
	level thread zm_audio::sndannouncerplayvox(undefined, undefined, "vox_event_insanitystart_avoa_0");
	level thread function_b693a570();
}

/*
	Name: function_b693a570
	Namespace: namespace_29f39efb
	Checksum: 0x91FB2B5F
	Offset: 0x1E10
	Size: 0x150
	Parameters: 0
	Flags: Linked
*/
function function_b693a570()
{
	level endon(#"game_over");
	var_8f5b3e75 = 2;
	var_69503500 = 12;
	var_5f530783 = [];
	for(i = 0; i <= var_69503500 - var_8f5b3e75; i++)
	{
		var_5f530783[i] = "im_" + var_8f5b3e75 + i;
	}
	zm_audio::playstate("im_1");
	var_432c4ea2 = array::randomize(var_5f530783);
	array::add(var_5f530783, "im_1");
	while(true)
	{
		zm_audio::playstate(var_432c4ea2[0]);
		arrayremoveindex(var_432c4ea2, 0);
		if(var_432c4ea2.size <= 0)
		{
			var_432c4ea2 = array::randomize(var_5f530783);
		}
		wait(1);
	}
}

/*
	Name: function_411302d7
	Namespace: namespace_29f39efb
	Checksum: 0x7BCB085E
	Offset: 0x1F68
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function function_411302d7()
{
	if(level.round_number != 200)
	{
		level flag::wait_till("round_active");
		namespace_a28acff3::set_round_number(200 - 1);
	}
	level notify(#"kill_round");
	zombies = getaiteamarray(level.zombie_team);
	if(isdefined(zombies))
	{
		for(i = 0; i < zombies.size; i++)
		{
			zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
		}
	}
}

/*
	Name: function_69a6d31a
	Namespace: namespace_29f39efb
	Checksum: 0xBA459C09
	Offset: 0x2078
	Size: 0x358
	Parameters: 1
	Flags: Linked
*/
function function_69a6d31a(b_show)
{
	var_d190efa8 = struct::get_array("insanity_mode_zone_containment_model");
	foreach(var_917ecbff in var_d190efa8)
	{
		if(b_show)
		{
			var_917ecbff.e_model = util::spawn_model(var_917ecbff.model, var_917ecbff.origin, var_917ecbff.angles);
			continue;
		}
		if(isdefined(var_917ecbff.e_model))
		{
			var_917ecbff.e_model delete();
		}
	}
	var_bdd13992 = getentarray("insanity_mode_zone_containment_clip", "targetname");
	foreach(e_clip in var_bdd13992)
	{
		if(b_show)
		{
			e_clip solid();
			continue;
		}
		e_clip notsolid();
	}
	var_76a02192 = getentarray("insanity_mode_no_starting_powerups", "targetname");
	if(isdefined(level.var_5fa2f970))
	{
		foreach(var_6e56eb16 in var_76a02192)
		{
			if(b_show)
			{
				var_6e56eb16 show();
				if(!isdefined(level.var_5fa2f970))
				{
					level.var_5fa2f970 = [];
				}
				else if(!isarray(level.var_5fa2f970))
				{
					level.var_5fa2f970 = array(level.var_5fa2f970);
				}
				if(!isinarray(level.var_5fa2f970, var_6e56eb16))
				{
					level.var_5fa2f970[level.var_5fa2f970.size] = var_6e56eb16;
				}
				continue;
			}
			var_6e56eb16 hide();
			arrayremovevalue(level.var_5fa2f970, var_6e56eb16);
		}
	}
}

/*
	Name: function_83c13f8e
	Namespace: namespace_29f39efb
	Checksum: 0x45D91D2D
	Offset: 0x23D8
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_83c13f8e()
{
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		e_player zm_perks::function_cc24f525();
	}
}

/*
	Name: function_5ac5f2aa
	Namespace: namespace_29f39efb
	Checksum: 0xC7076EF4
	Offset: 0x2470
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_5ac5f2aa()
{
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		e_player.var_c09adff0 = 1;
		e_player.var_e77eadb7 = 1;
		e_player zm_hero_weapon::function_45b7d6c1(2);
		e_player zm_hero_weapon::function_1164ba7b(1);
		e_player zm_hero_weapon::function_2264d131(level.hero_weapon[e_player.var_b708af7b][2], 1);
	}
}

/*
	Name: function_4f84973a
	Namespace: namespace_29f39efb
	Checksum: 0x7CD0569E
	Offset: 0x2588
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_4f84973a()
{
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		var_2d579541 = e_player getweaponslistprimaries();
		foreach(var_7dc1fc2 in var_2d579541)
		{
			if(zm_pap_util::function_7352d8cc(var_7dc1fc2))
			{
				continue;
			}
			e_player function_e16c950d(var_7dc1fc2);
		}
	}
}

/*
	Name: get_upgrade
	Namespace: namespace_29f39efb
	Checksum: 0xF990498E
	Offset: 0x26C0
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function get_upgrade(weapon)
{
	if(isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade_name))
	{
		return zm_weapons::get_upgrade_weapon(weapon, 0);
	}
	return zm_weapons::get_upgrade_weapon(weapon, 1);
}

/*
	Name: function_e16c950d
	Namespace: namespace_29f39efb
	Checksum: 0xB4DA9BE0
	Offset: 0x2740
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_e16c950d(weapon)
{
	weapon_upgrade = self get_upgrade(weapon);
	if(isdefined(weapon_upgrade))
	{
		self takeweapon(weapon);
		weapon_upgrade = self zm_weapons::give_build_kit_weapon(weapon_upgrade);
		self thread aat::remove(weapon_upgrade);
		self zm_weapons::function_7c5dd4bd(weapon_upgrade);
		if(isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon_upgrade))
		{
			self thread aat::acquire(weapon_upgrade);
			self zm_pap_util::function_18994aca(weapon_upgrade, 4);
		}
	}
}

/*
	Name: function_7cb78bcd
	Namespace: namespace_29f39efb
	Checksum: 0xD5A12105
	Offset: 0x2850
	Size: 0x36C
	Parameters: 0
	Flags: Linked
*/
function function_7cb78bcd()
{
	foreach(zone in level.zones)
	{
		enable_zone(zone, 0);
	}
	var_df1533c0 = getentarray("zombie_door", "targetname");
	if(isdefined(var_df1533c0))
	{
		foreach(var_6620353d in var_df1533c0)
		{
			switch(var_6620353d.script_flag)
			{
				case "green_backyard_to_green_house":
				case "culdesac_to_yellow_house_f1":
				case "culdesac_to_green_house":
				case "yellow_backyard_to_yellow_house":
				{
					if(!(isdefined(var_6620353d.has_been_opened) && var_6620353d.has_been_opened))
					{
						a_e_players = getplayers();
						var_6620353d notify(#"trigger", {#hash_3fc8547c:1, #activator:a_e_players[0]});
					}
					break;
				}
			}
		}
	}
	enable_zone(level.zones[#"zone_culdesac_green"], 1);
	enable_zone(level.zones[#"zone_green_house_f1"], 1);
	enable_zone(level.zones[#"zone_green_house_f2"], 1);
	enable_zone(level.zones[#"zone_green_backyard"], 1);
	enable_zone(level.zones[#"zone_culdesac_yellow"], 1);
	enable_zone(level.zones[#"zone_yellow_house_f1"], 1);
	enable_zone(level.zones[#"zone_yellow_house_f2"], 1);
	enable_zone(level.zones[#"zone_yellow_backyard"], 1);
}

/*
	Name: enable_zone
	Namespace: namespace_29f39efb
	Checksum: 0x6849FBC7
	Offset: 0x2BC8
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function enable_zone(zone, is_enabled = 1)
{
	zone.is_enabled = is_enabled;
	zone.is_spawning_allowed = is_enabled;
	var_42da954d = getarraykeys(zone.adjacent_zones);
	for(i = 0; i < zone.adjacent_zones.size; i++)
	{
		zone.adjacent_zones[var_42da954d[i]].is_connected = level.zones[var_42da954d[i]].is_enabled;
		if(isdefined(level.zones[var_42da954d[i]].adjacent_zones[zone.name]))
		{
			level.zones[var_42da954d[i]].adjacent_zones[zone.name].is_connected = is_enabled;
		}
	}
}

/*
	Name: function_ff416940
	Namespace: namespace_29f39efb
	Checksum: 0xEA81A04F
	Offset: 0x2D08
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function function_ff416940()
{
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		var_ac6ee9a0 = e_player namespace_2ba51478::get_player_lethal_grenade();
		if(var_ac6ee9a0.isgadget)
		{
			var_bcd1c2ff = e_player gadgetgetslot(var_ac6ee9a0);
			e_player gadgetpowerreset(var_bcd1c2ff, 0);
		}
	}
}

