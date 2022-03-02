// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using script_27c22e1d8df4d852;
#using script_2fcb47e3735a6edd;
#using script_39e954a546d3baf;
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_5b2f999b8dbf5f77;
#using script_6a3f43063dfd1bdc;
#using script_72eca4c9e2aea110;
#using script_ab862743b3070a;
#using script_d19b1fbf1d7cdd6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_cde8b7d2;

/*
	Name: main
	Namespace: namespace_cde8b7d2
	Checksum: 0x981372A4
	Offset: 0x940
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function main()
{
	init_level_vars();
}

/*
	Name: init_level_vars
	Namespace: namespace_cde8b7d2
	Checksum: 0x4BBADC43
	Offset: 0x960
	Size: 0x36C
	Parameters: 0
	Flags: Linked
*/
function init_level_vars()
{
	function_ac904e5e();
	function_7f933d39();
	level.fn_custom_round_ai_spawn = &function_a39e7a56;
	level flag::init("crevasse_points");
	level flag::init("boathouse_points");
	level flag::init("lighthouse_points");
	level flag::init("station_points");
	level flag::init("cargo_points");
	level flag::init("beach_points");
	level flag::init("forecastle_points");
	level flag::init("stern_points");
	level flag::init("artifact_points");
	level flag::init("gangway_points");
	level flag::init("facility_points");
	level flag::init(#"hash_50990d5b9376f50d");
	level flag::init(#"hash_13bc135937af9be2");
	level.var_3f86fd35 = 9;
	level.var_d7853f35 = 18;
	level.var_ecdf38f = 12;
	level.var_55e562f9 = 18;
	level.zombie_hints[#"default_treasure_chest"] = #"hash_57a34375dddce337";
	level thread function_ca35fa36();
	level thread function_9217567c();
	level thread init_traps();
	level thread function_f436d901();
	namespace_c3287616::function_2876740e(#"zombie_dog", &function_c7e2bbe2);
	namespace_c3287616::function_2876740e(#"zombie_electric", &function_ae7c2601);
	zm_utility::function_2959a3cb(#"zombie_dog", &function_126999be);
	zm_utility::function_2959a3cb(#"zombie_electric", &function_7b3abf7b);
}

/*
	Name: function_ca35fa36
	Namespace: namespace_cde8b7d2
	Checksum: 0xF2106481
	Offset: 0xCD8
	Size: 0xD8C
	Parameters: 0
	Flags: Linked
*/
function function_ca35fa36()
{
	level endon(#"end_game");
	function_84139b27();
	level.var_d6538eef = 0;
	level flag::wait_till("start_zombie_round_logic");
	level thread function_80a9077f();
	zm_utility::enable_power_switch(0);
	/#
		if(getdvarint(#"hash_b3363e1d25715d7", 0))
		{
			zm_utility::enable_power_switch(1, 1);
			level function_1dcc39ae();
			return;
		}
	#/
	level flag::set("power_on1");
	var_f79ff5ec = #"lighthouse";
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	var_420e4589 = [];
	var_49f2dcca = [];
	var_dca419c2 = [];
	zm_utility::function_fdb0368(3);
	if(math::cointoss())
	{
		var_420e4589 = array("frozen_crevasse_blockers");
		var_49f2dcca = array("docks_to_boathouse");
		level flag::set("crevasse_points");
	}
	else
	{
		var_420e4589 = array("docks_to_boathouse");
		var_49f2dcca = array("frozen_crevasse_blockers");
		level flag::set("boathouse_points");
	}
	level zm_utility::open_door(var_420e4589, undefined, undefined, 1);
	zm_utility::function_fdb0368(4);
	var_420e4589 = array("lighthouse_level_1_doors");
	level zm_utility::open_door(var_420e4589, undefined, undefined, 1);
	level flag::set("lighthouse_points");
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	wait(25);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 45);
	zm_utility::function_fef4b36a(var_f79ff5ec);
	if(math::cointoss())
	{
		var_420e4589 = array("lighthouse_cove_to_lighthouse_station", "lighthouse_station_to_lighthouse_level_2", "lighthouse_station_to_lighthouse_level_3", "beach_to_lighthouse_approach");
		var_49f2dcca = arraycombine(var_49f2dcca, array("lighthouse_cove_to_cargo_hold", "main_deck_to_forecastle", "main_deck_to_forecastle_blocker"), 0, 0);
		level flag::set("station_points");
		level flag::set("beach_points");
		var_f79ff5ec = #"beach";
	}
	else
	{
		var_420e4589 = array("lighthouse_cove_to_cargo_hold", "main_deck_to_forecastle", "main_deck_to_forecastle_blocker");
		var_49f2dcca = arraycombine(var_49f2dcca, array("lighthouse_cove_to_lighthouse_station", "lighthouse_station_to_lighthouse_level_2", "lighthouse_station_to_lighthouse_level_3", "beach_to_lighthouse_approach"), 0, 0);
		level flag::set("cargo_points");
		level flag::set("forecastle_points");
		var_f79ff5ec = #"forecastle";
	}
	level zm_utility::open_door(var_420e4589, undefined, undefined, 1);
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	namespace_c3287616::function_306ce518(#"zombie_dog", &intro_zombie_dog);
	level thread function_b4cae8b9();
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	wait(25);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 45);
	level flag::set(#"hash_50990d5b9376f50d");
	zm_utility::function_fef4b36a(var_f79ff5ec);
	var_f79ff5ec = #"sundeck";
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	level.var_a385f14 notify(#"hash_77af4c847e66b4ca");
	namespace_d09ff23c::function_602d605();
	level flag::set(#"hash_5a3d0402a5557739");
	foreach(var_a84febff in level.var_4d8e32c8)
	{
		if(!var_a84febff.script_noteworthy === "pap_island")
		{
			var_a84febff thread namespace_44916ada::function_e3921120(1);
		}
	}
	level thread registerlast_truck_headshot_();
	wait(5);
	if(level flag::get("beach_points"))
	{
		var_420e4589 = array("beach_to_gangway", "gangway_to_stern");
		var_49f2dcca = arraycombine(var_49f2dcca, array("cargo_hold_to_artifact_storage", "artifact_storage_to_forecastle"), 0, 0);
		level flag::set("stern_points");
	}
	else
	{
		var_420e4589 = array("cargo_hold_to_artifact_storage", "artifact_storage_to_forecastle");
		var_49f2dcca = arraycombine(var_49f2dcca, array("beach_to_gangway", "gangway_to_stern"), 0, 0);
		level flag::set("cargo_hold_to_artifact_storage");
		level flag::set("artifact_points");
	}
	var_420e4589 = arraycombine(var_420e4589, array("gangway_to_main_deck", "gangway_to_navigation", "sun_deck_to_bridge"), 0, 0);
	level zm_utility::open_door(var_420e4589, undefined, undefined, 1);
	level flag::set("sun_deck_to_bridge");
	level flag::set("gangway_points");
	namespace_c3287616::function_306ce518(#"zombie_electric", &intro_electric_zombie);
	level thread function_6091b49b();
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	wait(25);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 45);
	level flag::set(#"hash_13bc135937af9be2");
	level flag::set("power_on2");
	level flag::set(#"hash_7d9f8ec3cb9af87e");
	level flag::clear("fasttravel_disabled");
	level flag::set("ship_flinger_fixed");
	level flag::set(#"hash_24952374a6e863b8");
	level flag::set("facility_points");
	zm_utility::function_fef4b36a(var_f79ff5ec);
	if(math::cointoss())
	{
		var_f79ff5ec = #"decon";
	}
	else
	{
		var_f79ff5ec = #"geo";
	}
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	var_420e4589 = array("hidden_path_blocker", "lighthouse_level_3_to_level_4", "decontamination_doors", "geological_processing_doors", "specimen_storage_doors", "upper_catwalk_to_human_infusion_blocker", "grotto_tunnel_blockers");
	var_420e4589 = arraycombine(var_420e4589, var_49f2dcca, 0, 0);
	level zm_utility::open_door(var_420e4589, undefined, undefined, 1);
	level flag::set("cargo_hold_to_artifact_storage");
	level thread function_c87db3f7();
	wait(10);
	function_4fe4866f();
	wait(10);
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	wait(45);
	level thread function_c87db3f7();
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 45);
	level flag::set("power_on3");
	level flag::set("facility_flinger_fixed");
	zm_utility::function_fef4b36a(var_f79ff5ec);
	level function_a97f7327();
	for(i = 0; i < 3; i++)
	{
		namespace_be178848::function_61511fcf(i);
	}
	level thread function_466fb0ff(var_f79ff5ec);
}

/*
	Name: function_7f933d39
	Namespace: namespace_cde8b7d2
	Checksum: 0x2CE599F3
	Offset: 0x1A70
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_7f933d39()
{
	level flag::set("fasttravel_disabled");
}

/*
	Name: function_c87db3f7
	Namespace: namespace_cde8b7d2
	Checksum: 0xE55AAD17
	Offset: 0x1AA0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_c87db3f7(var_f79ff5ec)
{
	level waittill(#"creating_zone_defend_area");
	level flag::wait_till("started_defend_area");
	level flag::set("fasttravel_disabled");
	level waittill(#"hash_7a04a7fb98fa4e4d");
	wait(2);
	level flag::clear("fasttravel_disabled");
}

/*
	Name: function_c7e2bbe2
	Namespace: namespace_cde8b7d2
	Checksum: 0x65B2E1BC
	Offset: 0x1B48
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_c7e2bbe2(n_max)
{
	return getplayers().size;
}

/*
	Name: function_ae7c2601
	Namespace: namespace_cde8b7d2
	Checksum: 0xC6B41360
	Offset: 0x1B70
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_ae7c2601(n_max)
{
	return getplayers().size;
}

/*
	Name: function_74872db6
	Namespace: namespace_cde8b7d2
	Checksum: 0x4E43AC1E
	Offset: 0x1B98
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function function_74872db6()
{
	if(level.round_number <= 7)
	{
		level.var_11f7a9af = 1;
		level.var_18d20774 = 62500;
		level.registertheater_fxanim_kill_trigger_centerterminatetraverse = 62500;
	}
	else
	{
		level.var_2e3a6cbe = undefined;
		level.var_d614a8b4 = undefined;
		level.var_11f7a9af = undefined;
		level.var_18d20774 = undefined;
		level.registertheater_fxanim_kill_trigger_centerterminatetraverse = undefined;
	}
}

/*
	Name: function_126999be
	Namespace: namespace_cde8b7d2
	Checksum: 0x2BA1404E
	Offset: 0x1C28
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_126999be()
{
	level zm_utility::function_e64ac3b6(7, #"hash_75a75e4d68452af4");
	level thread zm_audio::sndannouncerplayvox(#"hellhound", undefined, undefined, undefined, 1);
}

/*
	Name: function_7b3abf7b
	Namespace: namespace_cde8b7d2
	Checksum: 0xCF181D
	Offset: 0x1C88
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_7b3abf7b()
{
	level zm_utility::function_e64ac3b6(17, #"hash_2ab45b2d46ada063");
	level thread zm_audio::sndannouncerplayvox(#"electric_zombie", undefined, undefined, 3, 1);
}

/*
	Name: intro_zombie_dog
	Namespace: namespace_cde8b7d2
	Checksum: 0x9DA482EF
	Offset: 0x1CF0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function intro_zombie_dog(n_round_number)
{
	level endon(#"hash_7a04a7fb98fa4e4d");
	n_spawn_count = 0;
	while(n_spawn_count < 3)
	{
		var_b88c4823 = namespace_c402654::function_62db7b1c(1, undefined);
		if(isdefined(var_b88c4823))
		{
			n_spawn_count++;
		}
		waitframe(1);
	}
	zm_utility::function_9b7bc715(#"zombie_dog", 1);
}

/*
	Name: function_b4cae8b9
	Namespace: namespace_cde8b7d2
	Checksum: 0x67127B77
	Offset: 0x1D98
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_b4cae8b9()
{
	level flag::wait_till("started_defend_area");
	util::delay(15, "end_game", &namespace_c3287616::function_376e51ef, #"zombie_dog");
}

/*
	Name: intro_electric_zombie
	Namespace: namespace_cde8b7d2
	Checksum: 0x869FDAB9
	Offset: 0x1E00
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function intro_electric_zombie(n_round_number)
{
	level endon(#"hash_7a04a7fb98fa4e4d");
	n_spawn_count = 0;
	while(n_spawn_count < 3)
	{
		var_2b12a83f = namespace_16c9989b::function_27695a82();
		if(isdefined(var_2b12a83f))
		{
			n_spawn_count++;
		}
		waitframe(1);
	}
	zm_utility::function_9b7bc715(#"zombie_electric", 1);
}

/*
	Name: function_6091b49b
	Namespace: namespace_cde8b7d2
	Checksum: 0xEA1F2F73
	Offset: 0x1EA0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_6091b49b()
{
	level flag::wait_till("started_defend_area");
	util::delay(15, "end_game", &namespace_c3287616::function_376e51ef, #"zombie_electric");
}

/*
	Name: function_a39e7a56
	Namespace: namespace_cde8b7d2
	Checksum: 0xE6784216
	Offset: 0x1F08
	Size: 0x1DA
	Parameters: 0
	Flags: Linked
*/
function function_a39e7a56()
{
	if(level flag::get(#"infinite_round_spawning"))
	{
		if(level.var_d6538eef > 8)
		{
			level.var_d6538eef = 0;
			if(level flag::get(#"hash_50990d5b9376f50d"))
			{
				ai = namespace_c402654::function_62db7b1c(0);
			}
		}
		else
		{
			if(level.var_d6538eef == 4)
			{
				if(level flag::get(#"hash_13bc135937af9be2"))
				{
					ai = namespace_16c9989b::function_27695a82();
				}
			}
			else
			{
				s_spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
				ai = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0], undefined, s_spawn_point);
			}
		}
		if(isdefined(ai))
		{
			n_delay = (isdefined(zombie_utility::function_d2dfacfd(#"zombie_spawn_delay")) ? zombie_utility::function_d2dfacfd(#"zombie_spawn_delay") : zombie_utility::function_d2dfacfd(#"hash_7d5a25e2463f7fc5"));
			level.var_d6538eef++;
			wait(n_delay);
			return true;
		}
	}
	return false;
}

/*
	Name: function_84139b27
	Namespace: namespace_cde8b7d2
	Checksum: 0x91072F1E
	Offset: 0x20F0
	Size: 0x94C
	Parameters: 0
	Flags: Linked
*/
function function_84139b27()
{
	zm_utility::function_c492c4d6("docks", "s_destination_docks", array("docks_2"), array(#"sunken", #"lighthouse", #"decon", #"station"), #"hash_40f8b1314b80b85d", #"hash_6771074908d56993");
	zm_utility::function_c492c4d6("lighthouse", "s_destination_lighthouse", array("lighthouse_level_1", "lighthouse_level_2"), array(#"beach", #"docks", #"forecastle", #"sunken"), #"hash_39a57c12eb43e417", #"hash_2cf824933e1a8ac1");
	zm_utility::function_c492c4d6("station", "s_destination_station", array("lighthouse_station"), array(#"beach", #"sundeck", #"geo", #"infusion"), #"hash_473af639aa6a1dc5", #"hash_1b75a3705bfd446b");
	zm_utility::function_c492c4d6("beach", "s_destination_beach", array("beach"), array(#"decon", #"geo", #"station", #"sundeck"), #"hash_1c2b8784bb8aa590", #"hash_9162184ef7f0220");
	zm_utility::function_c492c4d6("sundeck", "s_destination_sundeck", array("sun_deck", "bridge", "navigation"), array(#"forecastle", #"station", #"geo", #"storage"), #"hash_471148d113f50e0c", #"hash_34e048217bee05fc");
	zm_utility::function_c492c4d6("forecastle", "s_destination_forecastle", array("forecastle"), array(#"sunken", #"sundeck", #"lighthouse", #"crevasse"), #"hash_6b39e945c6763df5", #"hash_1dd68872a158d43b");
	zm_utility::function_c492c4d6("sunken", "s_destination_sunken", array("sunken_path"), array(#"forecastle", #"crevasse", #"lighthouse", #"docks"), #"hash_5a8610793f761a8b", #"hash_117ffcace4813a85");
	zm_utility::function_c492c4d6("crevasse", "s_destination_crevasse", array("frozen_crevasse"), array(#"forecastle", #"lighthouse", #"station", #"sunken"), #"hash_44fd8f5db56ca8cd", #"hash_6a7f34c402b66923");
	zm_utility::function_c492c4d6("decon", "s_destination_decon", array("decontamination", "security_lobby"), array(#"infusion", #"storage", #"docks", #"sundeck"), #"hash_7e711c2bf9dc32ea", #"hash_2e2da9c51dd43f6");
	zm_utility::function_c492c4d6("geo", "s_destination_geo", array("geological_processing", "security_lobby"), array(#"infusion", #"storage", #"crevasse", #"docks"), #"hash_42e3987404caee2e", #"hash_7714e6727380675a");
	zm_utility::function_c492c4d6("infusion", "s_destination_infusion", array("human_infusion"), array(#"decon", #"beach", #"infusion", #"crevasse"), #"hash_eb74e8efde96bb6", #"hash_39c6252f8f92d0f2");
	zm_utility::function_c492c4d6("storage", "s_destination_storage", array("specimen_storage"), array(#"decon", #"beach", #"infusion", #"crevasse"), #"hash_5571176820f1f5c2", #"hash_28ea515ade07dde");
	a_str_keys = getarraykeys(level.var_f05f7e16);
	foreach(s_defend_area in level.var_f05f7e16)
	{
		foreach(str_index in s_defend_area.var_cc0c35ca)
		{
			str_index = hash(str_index);
			/#
				assert(isinarray(a_str_keys, str_index), str_index + "");
			#/
		}
	}
}

/*
	Name: function_466fb0ff
	Namespace: namespace_cde8b7d2
	Checksum: 0x6B6B3E6E
	Offset: 0x2A48
	Size: 0x11A
	Parameters: 1
	Flags: Linked
*/
function function_466fb0ff(var_3cf55c1)
{
	level endon(#"end_game");
	var_f79ff5ec = zm_utility::function_40ef77ab(var_3cf55c1);
	var_679cd7a8 = zm_utility::function_a877cd10(var_f79ff5ec);
	while(true)
	{
		util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
		wait(25);
		level thread function_c87db3f7();
		zm_utility::function_33798535(var_679cd7a8.var_39c44288, var_679cd7a8.a_str_zones, var_679cd7a8.var_ed1db1a7);
		var_f79ff5ec = zm_utility::function_40ef77ab(var_f79ff5ec);
		var_679cd7a8 = zm_utility::function_a877cd10(var_f79ff5ec);
	}
}

/*
	Name: function_1dcc39ae
	Namespace: namespace_cde8b7d2
	Checksum: 0x82AA32BE
	Offset: 0x2B70
	Size: 0x112
	Parameters: 0
	Flags: None
*/
function function_1dcc39ae()
{
	/#
		wait(5);
		var_f79ff5ec = zm_utility::function_40ef77ab("");
		var_679cd7a8 = zm_utility::function_a877cd10(var_f79ff5ec);
		zm_utility::enable_power_switch(1, 1);
		while(true)
		{
			zm_utility::function_11101458(var_f79ff5ec);
			wait(5);
			zm_utility::function_33798535(var_679cd7a8.var_39c44288, var_679cd7a8.a_str_zones, var_679cd7a8.var_ed1db1a7, undefined, undefined, 3);
			var_a6238ac3 = var_f79ff5ec;
			var_f79ff5ec = zm_utility::function_40ef77ab(var_f79ff5ec);
			var_679cd7a8 = zm_utility::function_a877cd10(var_f79ff5ec);
		}
	#/
}

/*
	Name: init_traps
	Namespace: namespace_cde8b7d2
	Checksum: 0xAD9DE3A0
	Offset: 0x2C90
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function init_traps()
{
	var_2b4789ce = getentarray("zombie_trap", "targetname");
	foreach(e_trap in var_2b4789ce)
	{
		e_trap.script_string = "disable_wait_for_power";
	}
}

/*
	Name: function_9217567c
	Namespace: namespace_cde8b7d2
	Checksum: 0x8B18524D
	Offset: 0x2D38
	Size: 0x19A
	Parameters: 0
	Flags: Linked
*/
function function_9217567c()
{
	level waittill(#"all_players_spawned");
	foreach(var_5f41c401 in level.var_4fe2f84d)
	{
		foreach(s_crafting in var_5f41c401)
		{
			if(isarray(s_crafting.craftfoundry.blueprints))
			{
				foreach(var_6645c992 in s_crafting.craftfoundry.blueprints)
				{
					if(var_6645c992.name === "zblueprint_shield_zhield_riot")
					{
						s_crafting.blueprint = var_6645c992;
					}
				}
			}
		}
	}
}

/*
	Name: function_ac904e5e
	Namespace: namespace_cde8b7d2
	Checksum: 0x5E0160E1
	Offset: 0x2EE0
	Size: 0x330
	Parameters: 0
	Flags: Linked
*/
function function_ac904e5e()
{
	zm_utility::function_742f2c18(1, #"zombie", 8, 6);
	zm_utility::function_742f2c18(2, #"zombie", 10, 6);
	zm_utility::function_742f2c18(3, #"zombie", 10, 6);
	zm_utility::function_742f2c18(4, #"zombie", 10, 6);
	zm_utility::function_742f2c18(5, #"zombie", 12, 6);
	zm_utility::function_742f2c18(6, #"zombie", 12, 6);
	zm_utility::function_742f2c18(7, #"zombie", 12, 8);
	zm_utility::function_742f2c18(8, #"zombie", 14, 8);
	zm_utility::function_742f2c18(9, #"zombie", 14, 8);
	zm_utility::function_742f2c18(10, #"zombie", 14, 10);
	zm_utility::function_742f2c18(11, #"zombie", 16, 10);
	zm_utility::function_742f2c18(12, #"zombie", 16, 10);
	zm_utility::function_742f2c18(13, #"zombie", 16, 12);
	zm_utility::function_742f2c18(14, #"zombie", 16, 12);
	zm_utility::function_742f2c18(15, #"zombie", 16, 14);
	zm_utility::function_742f2c18(16, #"zombie", 20, 14);
	zm_utility::function_742f2c18(17, #"zombie", 24, 14);
	var_a535d72c = 16;
	for(n_round = 18; n_round < 255; n_round++)
	{
		zm_utility::function_742f2c18(n_round, #"zombie", undefined, var_a535d72c);
		var_a535d72c++;
		var_a535d72c = math::clamp(var_a535d72c, 16, 24);
	}
}

/*
	Name: function_f436d901
	Namespace: namespace_cde8b7d2
	Checksum: 0x330432CC
	Offset: 0x3218
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_f436d901()
{
	var_83a5fb84 = getentarray("use_elec_switch", "targetname");
	foreach(var_9a560db0 in var_83a5fb84)
	{
		var_9a560db0 hide();
	}
}

/*
	Name: registerlast_truck_headshot_
	Namespace: namespace_cde8b7d2
	Checksum: 0x620D4B69
	Offset: 0x32C0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function registerlast_truck_headshot_()
{
	level zm_utility::function_7a35b1d7(#"hash_56917185158b9df4");
	level thread zm_audio::sndannouncerplayvox(#"hash_435dce8984528996", undefined, undefined, undefined, 1);
}

/*
	Name: function_a97f7327
	Namespace: namespace_cde8b7d2
	Checksum: 0x7368C94B
	Offset: 0x3318
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_a97f7327()
{
	level zm_utility::function_7a35b1d7(#"hash_299d0a3534135476");
	level thread zm_audio::sndannouncerplayvox(#"hash_3acd6d72567def3a", undefined, undefined, undefined, 1);
}

/*
	Name: function_80a9077f
	Namespace: namespace_cde8b7d2
	Checksum: 0xA4DAD201
	Offset: 0x3370
	Size: 0x234
	Parameters: 0
	Flags: Linked
*/
function function_80a9077f()
{
	foreach(s_zipline_crank in level.var_67730c8d)
	{
		if(!(isdefined(s_zipline_crank.var_2e77da49) && s_zipline_crank.var_2e77da49))
		{
			s_zipline_crank.var_41580343 show();
			s_zipline_crank.var_2e77da49 = 1;
			s_zipline_crank notify(#"hash_762e0e4561d25aeb");
			s_zipline_crank zm_unitrigger::unregister_unitrigger(s_zipline_crank.s_unitrigger);
		}
		if(!(isdefined(s_zipline_crank.var_68a09be4) && s_zipline_crank.var_68a09be4))
		{
			if(s_zipline_crank.str_location === "aft_to_beach")
			{
				level flag::set(#"hash_7def3e555eba842c");
			}
			else
			{
				level flag::set(#"hash_e29d662bb90e4bc");
			}
			if(s_zipline_crank.var_68ae361b == "s_zipline_use_aft_to_beach")
			{
				s_zipline_crank.var_3bc09679 = struct::get("scene_zipline_aft", "targetname");
			}
			else if(s_zipline_crank.var_68ae361b == "s_zipline_use_lighthouse_to_fore")
			{
				s_zipline_crank.var_3bc09679 = struct::get("scene_zipline_fore", "targetname");
			}
			s_zipline_crank.var_3bc09679 thread scene::play("move_down_9");
			s_zipline_crank.var_68a09be4 = 1;
			s_zipline_crank notify(#"hash_6c3e5c135959d4ec");
		}
	}
}

/*
	Name: function_4fe4866f
	Namespace: namespace_cde8b7d2
	Checksum: 0xF1A97131
	Offset: 0x35B0
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function function_4fe4866f()
{
	level endon(#"end_game");
	var_2876a1a4 = getvehiclenode("vnd_zipline_lighthouse_to_facility_0", "targetname");
	n_obj_id = gameobjects::get_next_obj_id();
	objective_add(n_obj_id, "active", var_2876a1a4.origin, #"hash_5cfdced70a5a5948");
	function_da7940a3(n_obj_id, 1);
	foreach(player in level.players)
	{
		player thread function_f8dc2ddb(n_obj_id);
	}
}

/*
	Name: function_f8dc2ddb
	Namespace: namespace_cde8b7d2
	Checksum: 0xE1EC2B4D
	Offset: 0x36E8
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function function_f8dc2ddb(n_obj_id)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	while(true)
	{
		var_adea2587 = undefined;
		var_adea2587 = self waittill(#"hash_702a9c7f10066b19", #"death");
		if(var_adea2587.str_location === "lighthouse_to_facility" || var_adea2587._notify === "death")
		{
			objective_setinvisibletoplayer(n_obj_id, self);
			return;
		}
	}
}

