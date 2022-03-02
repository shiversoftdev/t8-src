// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_1b10fdf0addd52e;
#using script_387eab232fe22983;
#using script_39e954a546d3baf;
#using script_3cebb48c37fc271;
#using script_3f9e0dc8454d98e1;
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_52a84b3d20788c6;
#using script_58c342edd81589fb;
#using script_6ce38ab036223e6e;
#using script_79c9122f9058e8ba;
#using script_b52a163973f339f;
#using script_b761c44ab2e5b46;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_mansion.gsc;
#using scripts\zm\zm_mansion_pap_quest.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_6569a107;

/*
	Name: function_84139b27
	Namespace: namespace_6569a107
	Checksum: 0x28977481
	Offset: 0x5C0
	Size: 0x5FC
	Parameters: 0
	Flags: Linked
*/
function function_84139b27()
{
	zm_utility::function_c492c4d6(#"cellar", #"hash_1b5f923615231b33", array(#"zone_cellar"), array(#"hash_413cdf3a155d7eb5", #"library", #"greenhouse", #"cemetery"), #"hash_d991d688c218647", #"hash_2b2357a02d83b291");
	zm_utility::function_c492c4d6(#"main_hall", #"hash_7a9b6ecf9efe213d", array(#"zone_main_hall"), array(#"library", #"dining_room", #"hash_242faf74ae7224d7"), #"hash_23e3f0727cf654e1", #"hash_56ee5965eeb986f7");
	zm_utility::function_c492c4d6(#"hash_242faf74ae7224d7", #"hash_385f3c24f5a215a0", array(#"zone_grand_staircase", #"zone_entrance_hall"), array(#"hash_413cdf3a155d7eb5", #"greenhouse", #"dining_room", #"library"), #"hash_17eb32ca84395d46", #"hash_63182288b2fa8fe2");
	zm_utility::function_c492c4d6(#"library", #"hash_1ed56b51775c6337", array(#"zone_library"), array(#"hash_242faf74ae7224d7", #"main_hall", #"cemetery"), #"hash_18ccedb519d08fdb", #"hash_3d3024b021773e75");
	zm_utility::function_c492c4d6(#"greenhouse", #"hash_6ca6299c59dc3611", array(#"zone_greenhouse_lab"), array(#"main_hall", #"cellar", #"hash_242faf74ae7224d7", #"dining_room"), #"hash_1eab9450a8098785", #"hash_11659cb4f681fe2b");
	zm_utility::function_c492c4d6(#"dining_room", #"hash_630110b8f5ec36d9", array(#"zone_dining_room"), array(#"greenhouse", #"cellar", #"cemetery"), #"hash_59f4621f89897419", #"hash_9374fbb3272c53f");
	zm_utility::function_c492c4d6(#"hash_413cdf3a155d7eb5", #"hash_1d07f6440958f050", array(#"zone_library_hallway_upper", #"zone_foyer_westend"), array(#"cemetery", #"hash_242faf74ae7224d7", #"greenhouse"), #"hash_3d69c72a393f3836", #"hash_3d83f27f0bfd3a72");
	zm_utility::function_c492c4d6(#"cemetery", #"hash_551b339e17319aa0", array(#"zone_cemetery_mausoleum"), array(#"library", #"hash_413cdf3a155d7eb5", #"main_hall", #"cellar"), #"hash_2b4478e34d38202", #"hash_a3797801599641e");
	/#
		zm_utility::function_1e856719();
	#/
}

/*
	Name: main
	Namespace: namespace_6569a107
	Checksum: 0x803A6988
	Offset: 0xBC8
	Size: 0x38C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level thread function_fe69176c();
	function_edd5bb1a();
	function_ac904e5e();
	callback::function_74872db6(&function_74872db6);
	level.fn_custom_round_ai_spawn = undefined;
	level.var_3f86fd35 = 8;
	level.var_d7853f35 = 14;
	level.var_ecdf38f = 13;
	level.var_55e562f9 = 16;
	namespace_c3287616::function_306ce518(#"catalyst", &function_40dfd00b);
	namespace_c3287616::function_306ce518(#"nosferatu", &function_2ce29db3);
	namespace_c3287616::function_306ce518(#"werewolf", &function_124d3657);
	zm_utility::function_2959a3cb(#"nosferatu", &function_c22d1f6a);
	zm_utility::function_2959a3cb(#"werewolf", &function_9ab66ae8);
	level.zombie_hints[#"default_treasure_chest"] = #"hash_57a34375dddce337";
	level thread function_ca35fa36();
	var_4ce6fa3d = getent("connect_forest_entrance_to_forest", "script_flag");
	var_4ce6fa3d.script_noteworthy = "";
	var_822110ba = getent("ooze_gate_col", "targetname");
	var_822110ba delete();
	level thread function_5f03f689();
	level thread zm_blockers::function_6f01c3cf("barricade_start_west_1", "script_string");
	level thread zm_blockers::function_6f01c3cf("barricade_start_west_2", "script_string");
	level thread zm_blockers::function_6f01c3cf("barricade_start_east_1", "script_string");
	level thread zm_blockers::function_6f01c3cf("barricade_start_east_2", "script_string");
	level thread zm_blockers::function_6f01c3cf("barricade_hall_west_end_1", "script_string");
	level thread zm_blockers::function_6f01c3cf("barricade_hall_east_end_1", "script_string");
	zm_power::turn_power_on_and_open_doors(1);
	namespace_b8f22955::function_cdb8fe80();
}

/*
	Name: function_5f03f689
	Namespace: namespace_6569a107
	Checksum: 0xBFDE677
	Offset: 0xF60
	Size: 0xFA
	Parameters: 0
	Flags: Linked
*/
function function_5f03f689()
{
	level endon(#"end_game");
	level flag::wait_till("start_zombie_round_logic");
	var_50b78e87 = struct::get_array("fasttravel_trigger");
	foreach(s_fasttravel in var_50b78e87)
	{
		if(s_fasttravel.script_string === "entrance_hall")
		{
			s_fasttravel.var_a4134e51 = "connect_forest_entrance_to_forest";
			s_fasttravel.unitrigger_stub.var_a4134e51 = "connect_forest_entrance_to_forest";
		}
	}
}

/*
	Name: function_74872db6
	Namespace: namespace_6569a107
	Checksum: 0xB860CB9B
	Offset: 0x1068
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_74872db6()
{
	level.var_2e3a6cbe = undefined;
	level.var_d614a8b4 = undefined;
	level.var_11f7a9af = undefined;
	level.var_18d20774 = undefined;
	level.registertheater_fxanim_kill_trigger_centerterminatetraverse = undefined;
}

/*
	Name: function_c22d1f6a
	Namespace: namespace_6569a107
	Checksum: 0x351FBEA6
	Offset: 0x10B0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_c22d1f6a()
{
	level zm_utility::function_e64ac3b6(11, #"hash_7f4287cceb84c614");
	level thread zm_audio::sndannouncerplayvox(#"nosferatu", undefined, undefined, undefined, 1);
}

/*
	Name: function_9ab66ae8
	Namespace: namespace_6569a107
	Checksum: 0xDFFC1174
	Offset: 0x1110
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_9ab66ae8()
{
	level zm_utility::function_e64ac3b6(10, #"hash_44ee4f30644e71ec");
	level thread zm_audio::sndannouncerplayvox(#"werewolf", undefined, undefined, undefined, 1);
}

/*
	Name: registerlast_truck_headshot_
	Namespace: namespace_6569a107
	Checksum: 0x1323DBAF
	Offset: 0x1170
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function registerlast_truck_headshot_()
{
	level zm_utility::function_7a35b1d7(#"hash_4ebcbd3655fdceb0");
	level thread zm_audio::sndannouncerplayvox(#"hash_435dce8984528996", undefined, undefined, undefined, 1);
}

/*
	Name: function_a97f7327
	Namespace: namespace_6569a107
	Checksum: 0x442D95B7
	Offset: 0x11C8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_a97f7327()
{
	level zm_utility::function_7a35b1d7(#"hash_60f7952659026bea");
	level thread zm_audio::sndannouncerplayvox(#"hash_3acd6d72567def3a", undefined, undefined, undefined, 1);
}

/*
	Name: function_40dfd00b
	Namespace: namespace_6569a107
	Checksum: 0xB50DCFB7
	Offset: 0x1220
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_40dfd00b(n_round_number)
{
	var_c66743a5 = array::random(array(#"hash_78ca8e8e6bdbc8ab", #"hash_266b62e342076a90", #"hash_5cfa99582cc66c59", #"hash_5d6b55906fc82ff2"));
	zm_utility::function_9b7bc715(#"catalyst", 1);
	zm_transform::function_bdd8aba6(var_c66743a5);
}

/*
	Name: function_2ce29db3
	Namespace: namespace_6569a107
	Checksum: 0x61B6C11D
	Offset: 0x12E0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_2ce29db3(n_round)
{
	zm_utility::function_9b7bc715(#"nosferatu", 1);
	namespace_2fa8319f::function_74f25f8a(1);
}

/*
	Name: function_124d3657
	Namespace: namespace_6569a107
	Checksum: 0x5E1E27EE
	Offset: 0x1338
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_124d3657(n_round)
{
	zm_utility::function_9b7bc715(#"werewolf", 1);
	namespace_977da60::function_47a88a0c(1, undefined, 1);
}

/*
	Name: function_edd5bb1a
	Namespace: namespace_6569a107
	Checksum: 0x99DF7521
	Offset: 0x1398
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_edd5bb1a()
{
	if(zm_utility::function_e37823df())
	{
		zm_utility::function_6df718d(#"tag_origin");
	}
}

/*
	Name: function_ca35fa36
	Namespace: namespace_6569a107
	Checksum: 0x21479BC7
	Offset: 0x13D8
	Size: 0x9FC
	Parameters: 0
	Flags: Linked
*/
function function_ca35fa36()
{
	level endon(#"end_game");
	function_84139b27();
	level thread zm_mansion::function_e764a14b();
	level flag::wait_till("start_zombie_round_logic");
	level util::delay(4, undefined, &zm_utility::open_door, array("debris_startwest_to_starteast", "debris_starteast_to_startwest"));
	/#
		if(getdvarint(#"hash_b3363e1d25715d7", 0))
		{
			namespace_c05f06c7::function_57423f(1);
			return;
		}
	#/
	zm_utility::function_fdb0368(2);
	level zm_utility::open_door(array("door_start_to_hall", "debris_start_east_to_bedhall"), undefined, undefined, 1);
	zm_utility::function_fdb0368(4);
	zm_utility::open_door(array("door_hallend_to_grand_staircase", "door_to_entrance_hall"), undefined, undefined, 1);
	level thread scene::play("entrance_hall_exploding_door", "targetname");
	var_f79ff5ec = #"hash_242faf74ae7224d7";
	wait(5);
	zm_utility::function_11101458(var_f79ff5ec);
	wait(10);
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 35);
	zm_utility::function_fef4b36a(var_f79ff5ec);
	var_6152b664 = getent("use_elec_switch", "targetname");
	var_6152b664 triggerenable(1);
	trigger::use("use_elec_switch");
	wait(10);
	var_33efe293 = array::random(array(#"cellar", #"library", #"dining_room"));
	if(var_33efe293 == #"cellar")
	{
		level thread zm_utility::open_door(array("door_to_cellar"));
	}
	else
	{
		if(var_33efe293 == #"library")
		{
			level thread zm_utility::open_door(array("door_to_library_floor", "door_to_library"));
		}
		else
		{
			level thread zm_utility::open_door(array("door_to_dining_room_lower", "debris_to_dining_room_upper"));
		}
	}
	wait(5);
	zm_utility::function_11101458(var_33efe293);
	s_defend_area = zm_utility::function_a877cd10(var_33efe293);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 45);
	zm_utility::function_fef4b36a(var_33efe293);
	level zm_utility::open_door(array("debris_startwest_to_mainhall", "debris_starteast_to_mainhall"), undefined, undefined, 1);
	wait(5);
	var_f79ff5ec = #"main_hall";
	zm_utility::function_11101458(var_f79ff5ec);
	registertrench_dogs_coop_round();
	wait(15);
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	level thread zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	level flag::wait_till("started_defend_area");
	level util::delay(5, undefined, &namespace_c3287616::function_376e51ef, #"werewolf");
	level waittill(#"hash_7a04a7fb98fa4e4d");
	zm_utility::function_fef4b36a(var_f79ff5ec);
	var_c545d0a8 = getzbarrierarray();
	foreach(zbarrier in var_c545d0a8)
	{
		if(zbarrier.classname === "zbarrier_zm_packapunch_stationary")
		{
			collision = spawn("script_model", zbarrier.origin, 1);
			collision.angles = zbarrier.angles;
			collision setmodel(#"zm_collision_perks1");
			collision.script_noteworthy = "clip";
			collision disconnectpaths();
		}
	}
	level flag::set("open_pap");
	level thread zm_utility::open_door(array("door_main_hall_to_forest_entrance"));
	wait(5);
	level thread registerlast_truck_headshot_();
	wait(30);
	if(var_33efe293 == #"library")
	{
		var_f79ff5ec = #"cemetery";
		level thread zm_utility::open_door(array("debris_cemetery_entrance", "debris_cemetery", "door_to_library", "door_to_library_floor"));
	}
	else
	{
		var_f79ff5ec = #"greenhouse";
		level thread zm_utility::open_door(array("gate_greenhouse", "door_dining_room_to_greenhouse_entrance", "door_to_dining_room_lower", "debris_to_dining_room_upper"));
	}
	zm_utility::function_11101458(var_f79ff5ec);
	wait(15);
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	zm_utility::function_fef4b36a(var_f79ff5ec);
	namespace_c3287616::function_376e51ef(#"bat");
	namespace_c3287616::function_376e51ef(#"nosferatu");
	level thread namespace_c3287616::function_376e51ef(#"crimson_nosferatu", level.round_number + 6);
	level thread util::delay(120, "end_game", &function_cf680b18);
	/#
		iprintlnbold("");
	#/
	wait(7);
	level thread zm_utility::open_door(array("door_to_cellar", "door_to_dining_room_lower", "debris_to_dining_room_upper", "door_dining_room_to_greenhouse_entrance", "gate_greenhouse", "door_to_library_floor", "door_to_library", "debris_cemetery_entrance", "debris_cemetery"), undefined, undefined, 0);
	level thread function_a97f7327();
	function_39364bed();
}

/*
	Name: registertrench_dogs_coop_round
	Namespace: namespace_6569a107
	Checksum: 0xD830525F
	Offset: 0x1DE0
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function registertrench_dogs_coop_round()
{
	/#
		iprintlnbold("");
	#/
	switch(level.players.size)
	{
		case 1:
		default:
		{
			level.var_9a7491e = 1.5;
			break;
		}
		case 2:
		case 3:
		{
			level.var_9a7491e = 2;
			break;
		}
		case 4:
		{
			level.var_9a7491e = 2.5;
			break;
		}
	}
}

/*
	Name: function_cf680b18
	Namespace: namespace_6569a107
	Checksum: 0x3620296
	Offset: 0x1EC0
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function function_cf680b18()
{
	/#
		iprintlnbold("");
	#/
	switch(level.players.size)
	{
		case 1:
		default:
		{
			level.var_cd345b49 = 1.5;
			break;
		}
		case 2:
		case 3:
		{
			level.var_cd345b49 = 2;
			break;
		}
		case 4:
		{
			level.var_cd345b49 = 3;
			break;
		}
	}
}

/*
	Name: function_39364bed
	Namespace: namespace_6569a107
	Checksum: 0x7C169870
	Offset: 0x1FA0
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_39364bed()
{
	var_f79ff5ec = array::random(array(#"hash_413cdf3a155d7eb5", #"cellar", #"library"));
	while(true)
	{
		zm_utility::function_11101458(var_f79ff5ec);
		wait(45);
		s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
		zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
		zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
		var_f79ff5ec = zm_utility::function_40ef77ab(var_f79ff5ec);
		waitframe(1);
	}
}

/*
	Name: function_ac904e5e
	Namespace: namespace_6569a107
	Checksum: 0xD03BCB6B
	Offset: 0x20B8
	Size: 0x2F0
	Parameters: 0
	Flags: Linked
*/
function function_ac904e5e()
{
	zm_utility::function_742f2c18(1, #"zombie", 8, 4);
	zm_utility::function_742f2c18(2, #"zombie", 8, 4);
	zm_utility::function_742f2c18(3, #"zombie", 8, 6);
	zm_utility::function_742f2c18(4, #"zombie", 10, 6);
	zm_utility::function_742f2c18(5, #"zombie", 10, 8);
	zm_utility::function_742f2c18(6, #"zombie", 10, 8);
	zm_utility::function_742f2c18(7, #"zombie", 12, 8);
	zm_utility::function_742f2c18(8, #"zombie", 12, 8);
	zm_utility::function_742f2c18(9, #"zombie", 12, 8);
	zm_utility::function_742f2c18(10, #"zombie", 14, 10);
	zm_utility::function_742f2c18(11, #"zombie", 14, 10);
	zm_utility::function_742f2c18(12, #"zombie", 14, 10);
	zm_utility::function_742f2c18(13, #"zombie", 16, 12);
	zm_utility::function_742f2c18(14, #"zombie", 20, 12);
	zm_utility::function_742f2c18(15, #"zombie", 30, 12);
	var_a535d72c = 12;
	for(n_round = 10; n_round < 255; n_round++)
	{
		zm_utility::function_742f2c18(n_round, #"zombie", undefined, var_a535d72c);
		if(math::cointoss())
		{
			var_a535d72c++;
		}
		var_a535d72c = math::clamp(var_a535d72c, 8, 24);
	}
}

/*
	Name: function_f3859095
	Namespace: namespace_6569a107
	Checksum: 0x6D16147
	Offset: 0x23B0
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function function_f3859095()
{
	var_82c8a927 = getent("pap_lock_main_hall", "targetname");
	var_a82b1de9 = getent("pap_lock_library", "targetname");
	var_34cbce37 = getent("pap_lock_greenhouse", "targetname");
	if(isdefined(var_82c8a927))
	{
		var_82c8a927 delete();
	}
	if(isdefined(var_a82b1de9))
	{
		var_a82b1de9 delete();
	}
	if(isdefined(var_34cbce37))
	{
		var_34cbce37 delete();
	}
}

/*
	Name: function_fe69176c
	Namespace: namespace_6569a107
	Checksum: 0x46A02FCE
	Offset: 0x2498
	Size: 0x2AE
	Parameters: 0
	Flags: Linked
*/
function function_fe69176c()
{
	var_18c56c6b = array();
	var_18c56c6b[0] = zm_crafting::function_4c2f8683(#"hash_1d492d987b5f57ed");
	var_18c56c6b[1] = zm_crafting::function_4c2f8683(#"hash_1d492a987b5f52d4");
	var_18c56c6b[2] = zm_crafting::function_4c2f8683(#"hash_1d492b987b5f5487");
	var_18c56c6b[3] = zm_crafting::function_4c2f8683(#"hash_11ae647a1f0d9704");
	var_18c56c6b[4] = zm_crafting::function_4c2f8683(#"hash_11ae677a1f0d9c1d");
	var_18c56c6b[5] = zm_crafting::function_4c2f8683(#"hash_11ae667a1f0d9a6a");
	var_58d9e0d3 = getitemarray();
	foreach(var_2e1f34dd in var_58d9e0d3)
	{
		if(isinarray(var_18c56c6b, var_2e1f34dd.item))
		{
			var_2e1f34dd delete();
		}
	}
	hidemiscmodels("ww_lvl3_quest_piece_on_table");
	var_7f952cba = getentarray("ww_lvl3_quest_piece_on_table", "targetname");
	array::delete_all(var_7f952cba);
	zm_crafting::function_ca244624(#"zblueprint_mansion_silver_bullet");
	zm_crafting::function_ca244624(#"zblueprint_mansion_silver_molten");
	level.var_4fe2f84d[#"zblueprint_mansion_silver_molten"][0].var_95f72816 = 1;
	level.var_4fe2f84d[#"zblueprint_mansion_silver_bullet"][0].var_95f72816 = 1;
}

