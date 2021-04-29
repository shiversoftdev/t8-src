// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14e569dd391faf67;
#using script_1a0465ccc4a3ef61;
#using script_2595527427ea71eb;
#using script_27c22e1d8df4d852;
#using script_2cd0a997aa904279;
#using script_39e954a546d3baf;
#using script_4bae07eadc57bb51;
#using script_56a07ed451084ca5;
#using script_58c342edd81589fb;
#using script_59a783d756554a80;
#using script_6a3f43063dfd1bdc;
#using script_71b31a94cdaeca53;
#using script_ab862743b3070a;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_5203fdd;

/*
	Name: main
	Namespace: namespace_5203fdd
	Checksum: 0x13EA2B5B
	Offset: 0x690
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
	Namespace: namespace_5203fdd
	Checksum: 0xE01817B8
	Offset: 0x6B0
	Size: 0x27C
	Parameters: 0
	Flags: Linked
*/
function init_level_vars()
{
	function_edd5bb1a();
	function_ac904e5e();
	level.fn_custom_round_ai_spawn = undefined;
	level.var_3f86fd35 = 10;
	level.var_d7853f35 = 20;
	level.var_ecdf38f = 13;
	level.var_55e562f9 = 15;
	level.zombie_hints[#"default_treasure_chest"] = #"hash_57a34375dddce337";
	level thread zm_blockers::function_6f01c3cf("conference1_clocks_tear_in_barricade", "script_string", 0);
	level thread zm_blockers::function_6f01c3cf("conference1_clocks_left_barricade", "script_string", 0);
	level thread zm_blockers::function_6f01c3cf("conference1_clocks_right_barricade", "script_string", 0);
	level thread zm_blockers::function_6f01c3cf("conference1_screens_tear_in_barricade", "script_string", 0);
	level thread zm_blockers::function_6f01c3cf("conference1_screens_left_barricade", "script_string", 0);
	level thread zm_blockers::function_6f01c3cf("conference1_screens_right_barricade", "script_string", 0);
	level thread function_ca35fa36();
	level thread function_9217567c();
	level thread init_traps();
	level thread function_f436d901();
	level thread init_pack_a_punch();
	level thread namespace_6cd64b2b::function_cec9d001();
	namespace_c3287616::function_2876740e(#"zombie_dog", &function_c7e2bbe2);
	namespace_c3287616::function_2876740e(#"nova_crawler", &function_aee9d1fb);
}

/*
	Name: function_c7e2bbe2
	Namespace: namespace_5203fdd
	Checksum: 0x69C9AEBC
	Offset: 0x938
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_c7e2bbe2(n_max)
{
	if(!(isdefined(level.var_4c71614b) && level.var_4c71614b))
	{
		return 0;
	}
	return int(randomfloatrange(0.4, 0.6) * n_max);
}

/*
	Name: function_aee9d1fb
	Namespace: namespace_5203fdd
	Checksum: 0xC48DB678
	Offset: 0x9B0
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function function_aee9d1fb(n_max)
{
	if(!(isdefined(level.var_4c71614b) && level.var_4c71614b))
	{
		return 0;
	}
	return int(0.2 * level.var_38b15968);
}

/*
	Name: function_74872db6
	Namespace: namespace_5203fdd
	Checksum: 0xD8785EDC
	Offset: 0xA10
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
		level.var_ef05cff5 = 62500;
	}
	else
	{
		level.var_2e3a6cbe = undefined;
		level.var_d614a8b4 = undefined;
		level.var_11f7a9af = undefined;
		level.var_18d20774 = undefined;
		level.var_ef05cff5 = undefined;
	}
}

/*
	Name: function_6a9c3eb3
	Namespace: namespace_5203fdd
	Checksum: 0xF4016E22
	Offset: 0xAA0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_6a9c3eb3(n_round_number)
{
	level endon(#"hash_7a04a7fb98fa4e4d");
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
	Namespace: namespace_5203fdd
	Checksum: 0x202999A
	Offset: 0xB48
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
	Name: function_e76696af
	Namespace: namespace_5203fdd
	Checksum: 0x8BE7D9E3
	Offset: 0xBB0
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_e76696af(n_round_number)
{
	level endon(#"hash_7a04a7fb98fa4e4d");
	while(n_spawn_count < 3)
	{
		var_b88c4823 = namespace_c71ecd1b::function_dd836251();
		if(isdefined(var_b88c4823))
		{
			n_spawn_count++;
		}
		waitframe(1);
	}
	level notify(#"hash_49913b68a51bc8f5");
	zm_utility::function_9b7bc715(#"nova_crawler", 1);
}

/*
	Name: function_bee94926
	Namespace: namespace_5203fdd
	Checksum: 0x79FECAF9
	Offset: 0xC60
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_bee94926()
{
	level flag::wait_till("started_defend_area");
	level flag::set(#"hash_2a1fc2e349c48462");
	level util::delay(20, "end_game", &namespace_c3287616::function_376e51ef, #"nova_crawler");
	level waittill(#"hash_49913b68a51bc8f5");
	level flag::clear(#"hash_2a1fc2e349c48462");
}

/*
	Name: function_ca35fa36
	Namespace: namespace_5203fdd
	Checksum: 0xD04AFD60
	Offset: 0xD28
	Size: 0x964
	Parameters: 0
	Flags: Linked
*/
function function_ca35fa36()
{
	level endon(#"end_game");
	function_84139b27();
	level flag::wait_till("start_zombie_round_logic");
	zm_utility::function_cbc75463(0);
	/#
		if(getdvarint(#"hash_b3363e1d25715d7", 0))
		{
			zm_utility::function_cbc75463(1, 1);
			level function_1dcc39ae();
			return;
		}
	#/
	var_f79ff5ec = #"offices";
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	zm_utility::function_fdb0368(3);
	level zm_utility::open_door("conf1_file_door", undefined, undefined, 1);
	zm_utility::function_fdb0368(5);
	var_420e4589 = array("hallway1_office_door", "conf1_hall1", "file_office_blocker");
	level zm_utility::open_door(var_420e4589, undefined, undefined, 1);
	wait(5);
	zm_utility::function_11101458(var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	level waittill(#"end_of_round");
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 20);
	function_35ff3f69();
	zm_utility::function_fef4b36a(var_f79ff5ec);
	var_f79ff5ec = array::random(array(#"server_room", #"war_room_lower"));
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	namespace_c402654::function_aec3446d(0);
	var_3e4bb460 = "elevator2";
	level zm_utility::open_door("elev2_blocker", undefined, undefined, 1);
	function_cc31fe55(var_3e4bb460);
	var_420e4589 = array("war_room_stair", "war_room_east", "war_room_west", "war_room_server_door");
	level zm_utility::open_door(var_420e4589, undefined, undefined, 1);
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	wait(25);
	namespace_c3287616::function_306ce518(#"zombie_dog", &function_6a9c3eb3);
	level thread function_b4cae8b9();
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 45);
	function_35ff3f69();
	zm_utility::function_fef4b36a(var_f79ff5ec);
	var_f79ff5ec = array::random(array(#"lab_halls", #"morgue"));
	var_e95056b1 = var_f79ff5ec;
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	var_3e4bb460 = "elevator1";
	level zm_utility::open_door("elev1_blocker", undefined, undefined, 1);
	function_cc31fe55(var_3e4bb460);
	if(var_f79ff5ec == #"morgue")
	{
		var_420e4589 = array("lab3_level3", "lab1_level3");
	}
	else
	{
		var_420e4589 = array("lab3_level3");
	}
	level zm_utility::open_door(var_420e4589, undefined, 6, 1);
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	wait(25);
	namespace_c3287616::function_306ce518(#"nova_crawler", &function_e76696af);
	level thread function_bee94926();
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	level thread zm_utility::function_cbc75463(1, 1);
	level notify(#"hash_2ec0be5019c6c395");
	level thread namespace_8f53e87b::play_pentagon_announcer_vox(#"hash_7d4064a8d03e0606");
	level.var_4c71614b = 1;
	zm_utility::function_fef4b36a(var_f79ff5ec);
	var_f79ff5ec = #"groom_lake";
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	wait(10);
	function_a95f1203();
	var_37b7b46a = function_ac496011();
	var_7f66a3c0 = zm_utility::function_11101458(var_f79ff5ec);
	objective_setinvisibletoall(var_7f66a3c0);
	foreach(e_player in level.activeplayers)
	{
		e_player thread function_fa0d0109(var_37b7b46a, var_7f66a3c0, var_f79ff5ec);
	}
	wait(25);
	level thread function_c87db3f7(var_f79ff5ec);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	foreach(e_player in getplayers())
	{
		e_player notify(#"hash_4084bd0cc597186f");
		e_player function_b4afc059(var_37b7b46a);
	}
	var_420e4589 = array("lab2_level3");
	if(var_e95056b1 == #"lab_halls")
	{
		var_420e4589 = array("lab2_level3", "lab1_level3");
	}
	level zm_utility::open_door(var_420e4589, undefined, 8, 1);
	level thread function_466fb0ff(var_f79ff5ec);
}

/*
	Name: function_c87db3f7
	Namespace: namespace_5203fdd
	Checksum: 0xC64EE156
	Offset: 0x1698
	Size: 0x2A4
	Parameters: 1
	Flags: Linked
*/
function function_c87db3f7(var_f79ff5ec)
{
	level waittill(#"creating_zone_defend_area");
	if(var_f79ff5ec == #"groom_lake" && isdefined(level.var_35da2d77))
	{
		gameobjects::release_obj_id(level.var_35da2d77);
		level.var_35da2d77 = undefined;
	}
	level flag::wait_till("started_defend_area");
	if(var_f79ff5ec == #"groom_lake")
	{
		if(isdefined(level.var_4d648134.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(level.var_4d648134.s_unitrigger);
		}
		namespace_a701220b::function_60abbae4(0);
	}
	namespace_a701220b::function_a6bb56f6();
	level waittill(#"hash_7a04a7fb98fa4e4d");
	wait(2);
	if(var_f79ff5ec == #"groom_lake")
	{
		level.var_4d648134 zm_unitrigger::create("", 32, &namespace_a701220b::portal_think, 0, 0);
		namespace_a701220b::function_60abbae4(1);
		n_obj_id = gameobjects::get_next_obj_id();
		var_1b808f25 = struct::get("cage_portal");
		objective_add(n_obj_id, "active", var_1b808f25.origin, #"hash_649649ac2d1051cb");
		function_da7940a3(n_obj_id, 1);
		foreach(player in getplayers())
		{
			player thread function_eede094a(n_obj_id);
		}
	}
	namespace_a701220b::function_cc9b97b0();
}

/*
	Name: function_eede094a
	Namespace: namespace_5203fdd
	Checksum: 0x5B8845D2
	Offset: 0x1948
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function function_eede094a(n_obj_id)
{
	level endon(#"end_game");
	self endon(#"disconnect", #"hash_7f92ef3fa3761959");
	while(true)
	{
		if(!namespace_47276bad::function_9dd97963(self))
		{
			objective_setinvisibletoplayer(n_obj_id, self);
			self notify(#"hash_7f92ef3fa3761959");
			break;
		}
		wait(0.1);
	}
}

/*
	Name: function_fa0d0109
	Namespace: namespace_5203fdd
	Checksum: 0x92AB14
	Offset: 0x19F0
	Size: 0x104
	Parameters: 3
	Flags: Linked
*/
function function_fa0d0109(var_37b7b46a, var_7f66a3c0, var_f79ff5ec)
{
	self endon(#"hash_282d6ac23c7b5831", #"disconnect");
	while(!isdefined(str_player_zone) || (str_player_zone != "cage" && str_player_zone != "cage_upper"))
	{
		str_player_zone = self zm_zonemgr::get_player_zone();
		wait(0.1);
	}
	self function_b4afc059(var_37b7b46a);
	if(!level flag::get("started_defend_area"))
	{
		objective_setvisibletoplayer(var_7f66a3c0, self);
	}
}

/*
	Name: function_a95f1203
	Namespace: namespace_5203fdd
	Checksum: 0xBBA41AD5
	Offset: 0x1B00
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_a95f1203()
{
	function_231d0b19();
	level flag::set(#"hash_537cc10c9deca9da");
	level flag::set(#"hash_381e771ed6c80ccb");
	namespace_a701220b::function_bb3f9afd();
	level.var_a23b5c5 movez(150, 1);
}

/*
	Name: function_231d0b19
	Namespace: namespace_5203fdd
	Checksum: 0xCAF550
	Offset: 0x1B98
	Size: 0x338
	Parameters: 0
	Flags: Linked
*/
function function_231d0b19()
{
	level.var_dc235a55 = namespace_509a75d1::function_2719d4c0("cage_debris", "targetname", "script_int");
	foreach(var_f0a1a909 in level.var_dc235a55)
	{
		if(!isdefined(var_f0a1a909.a_e_clip))
		{
			var_f0a1a909.a_e_clip = [];
		}
		else if(!isarray(var_f0a1a909.a_e_clip))
		{
			var_f0a1a909.a_e_clip = array(var_f0a1a909.a_e_clip);
		}
		if(!isdefined(var_f0a1a909.var_ddcda303))
		{
			var_f0a1a909.var_ddcda303 = [];
		}
		else if(!isarray(var_f0a1a909.var_ddcda303))
		{
			var_f0a1a909.var_ddcda303 = array(var_f0a1a909.var_ddcda303);
		}
		var_2b975c1a = getentarray(var_f0a1a909.target, "targetname");
		foreach(var_28dbd41f in var_2b975c1a)
		{
			if(var_28dbd41f iszbarrier())
			{
				if(!isdefined(var_f0a1a909.var_ddcda303))
				{
					var_f0a1a909.var_ddcda303 = [];
				}
				else if(!isarray(var_f0a1a909.var_ddcda303))
				{
					var_f0a1a909.var_ddcda303 = array(var_f0a1a909.var_ddcda303);
				}
				var_f0a1a909.var_ddcda303[var_f0a1a909.var_ddcda303.size] = var_28dbd41f;
				continue;
			}
			if(!isdefined(var_f0a1a909.a_e_clip))
			{
				var_f0a1a909.a_e_clip = [];
			}
			else if(!isarray(var_f0a1a909.a_e_clip))
			{
				var_f0a1a909.a_e_clip = array(var_f0a1a909.a_e_clip);
			}
			var_f0a1a909.a_e_clip[var_f0a1a909.a_e_clip.size] = var_28dbd41f;
		}
		var_f0a1a909 thread namespace_a5657ff1::function_55ca39d8();
	}
}

/*
	Name: function_35ff3f69
	Namespace: namespace_5203fdd
	Checksum: 0x961C2A15
	Offset: 0x1ED8
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_35ff3f69()
{
	switch(level.players.size)
	{
		case 1:
		{
			n_wait_time = 12;
			break;
		}
		case 2:
		{
			n_wait_time = 10;
			break;
		}
		default:
		{
			n_wait_time = 8;
		}
	}
	wait(n_wait_time);
}

/*
	Name: function_cc31fe55
	Namespace: namespace_5203fdd
	Checksum: 0x76E247F1
	Offset: 0x1F60
	Size: 0x434
	Parameters: 1
	Flags: Linked
*/
function function_cc31fe55(var_3e4bb460)
{
	level endon(#"end_game");
	var_52cb42f5 = getent(var_3e4bb460 + "_buy", "script_noteworthy");
	var_2ffe3076 = getent(var_3e4bb460 + "_touch_volume", "targetname");
	e_elevator = getent(var_3e4bb460, "targetname");
	var_1b808f25 = struct::get("s_" + var_3e4bb460);
	n_obj_id = gameobjects::get_next_obj_id();
	level flag::wait_till("elevators_initialized");
	wait(0.1);
	objective_add(n_obj_id, "active", var_1b808f25.origin, #"hash_2b0ffc46eaa608c5");
	function_da7940a3(n_obj_id, 1);
	var_52cb42f5 triggerenable(0);
	foreach(player in level.players)
	{
		player namespace_b22c99a5::stop_timer();
		if(!level.var_f995ece6 zm_trial_timer::is_open(player))
		{
			level.var_f995ece6 zm_trial_timer::open(player);
		}
		level.var_f995ece6 zm_trial_timer::function_8ede8e82(player, #"hash_368c4a7d61a473b0");
		player namespace_b22c99a5::start_timer(30);
	}
	for(n_time = 30; n_time > 0; n_time--)
	{
		wait(1);
		var_a78da539 = 1;
		foreach(player in level.activeplayers)
		{
			if(!player istouching(var_2ffe3076))
			{
				var_a78da539 = 0;
				break;
			}
		}
		if(var_a78da539)
		{
			break;
		}
	}
	foreach(player in level.players)
	{
		if(level.var_f995ece6 zm_trial_timer::is_open(player))
		{
			level.var_f995ece6 zm_trial_timer::close(player);
		}
		player namespace_b22c99a5::stop_timer();
	}
	if(isdefined(n_obj_id))
	{
		gameobjects::release_obj_id(n_obj_id);
	}
	level thread function_2819a255(e_elevator);
}

/*
	Name: function_2819a255
	Namespace: namespace_5203fdd
	Checksum: 0xCB20D638
	Offset: 0x23A0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_2819a255(e_elevator)
{
	while(!namespace_ccdea9b1::is_elevator_clear(e_elevator))
	{
		waitframe(1);
	}
	level thread namespace_ccdea9b1::elevator_move_to(e_elevator);
}

/*
	Name: function_84139b27
	Namespace: namespace_5203fdd
	Checksum: 0xF461660B
	Offset: 0x23F8
	Size: 0x74C
	Parameters: 0
	Flags: Linked
*/
function function_84139b27()
{
	zm_utility::function_c492c4d6("groom_lake", "s_destination_groom_lake", array("cage", "cage_upper"), array(#"pig_lab", #"file_room", #"conference_room", #"lab_halls"), #"hash_699d3db189fbc1d5", #"hash_463d9ce9821d55b");
	zm_utility::function_c492c4d6("file_room", "s_destination_file_room", array("file_room_level1"), array(#"war_room_lower", #"pig_lab", #"server_room", #"lab_halls"), #"hash_ed01e635dadf8cb", #"hash_36d368ed717d20c5");
	zm_utility::function_c492c4d6("war_room_lower", "s_destination_war_room_lower", array("war_room_zone_south", "war_room_zone_north"), array(#"offices", #"conference_room", #"pig_lab", #"morgue"), #"hash_7c1925088ceb0d6f", #"hash_41f0a0badf1ca529");
	zm_utility::function_c492c4d6("morgue", "s_destination_morgue", array("labs_zone1"), array(#"groom_lake", #"offices", #"file_room", #"war_room_lower"), #"hash_7db066010310ac0a", #"hash_77bef9f2fc5c6256");
	zm_utility::function_c492c4d6("offices", "s_destination_offices", array("offices_level1"), array(#"server_room", #"groom_lake", #"pig_lab", #"morgue"), #"hash_2a0d8cb4d439f0f4", #"hash_60286201ddc53a34");
	zm_utility::function_c492c4d6("server_room", "s_destination_server_room", array("war_room_server_room"), array(#"offices", #"conference_room", #"morgue", #"lab_halls"), #"hash_2fa01fcc99fa17e", #"hash_537aff1a771b818a");
	zm_utility::function_c492c4d6("pig_lab", "s_destination_porcine_research_lab", array("labs_zone2"), array(#"server_room", #"conference_room", #"file_room", #"war_room_lower"), #"hash_2907e82c48b5143", #"hash_7b58f28c832606d");
	zm_utility::function_c492c4d6("lab_halls", "s_destination_lab_hallways", array("labs_hallway1", "labs_hallway2"), array(#"server_room", #"offices", #"file_room", #"groom_lake"), #"hash_34055c0d60f4897b", #"hash_6889b45faad48255");
	zm_utility::function_c492c4d6("conference_room", "s_destination_conference_room", array("conference_level1", "hallway_level1"), array(#"war_room_lower", #"lab_halls", #"morgue", #"groom_lake"), #"hash_53862ff7ab29a7fb", #"hash_1803a751f0a9f1d5");
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
	Namespace: namespace_5203fdd
	Checksum: 0x4AD7ACA3
	Offset: 0x2B50
	Size: 0x2BA
	Parameters: 1
	Flags: Linked
*/
function function_466fb0ff(var_3cf55c1)
{
	level endon(#"end_game");
	var_f79ff5ec = zm_utility::function_40ef77ab(var_3cf55c1);
	while(true)
	{
		if(var_f79ff5ec != #"groom_lake")
		{
			util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
		}
		else
		{
			var_37b7b46a = function_ac496011();
			var_7f66a3c0 = zm_utility::function_11101458(var_f79ff5ec);
			objective_setinvisibletoall(var_7f66a3c0);
			foreach(e_player in getplayers())
			{
				e_player thread function_fa0d0109(var_37b7b46a, var_7f66a3c0, var_f79ff5ec);
			}
		}
		wait(25);
		level thread function_c87db3f7(var_f79ff5ec);
		zm_utility::function_33798535(var_679cd7a8.var_39c44288, var_679cd7a8.a_str_zones, var_679cd7a8.var_ed1db1a7);
		if(var_f79ff5ec == #"groom_lake")
		{
			foreach(e_player in getplayers())
			{
				e_player notify(#"hash_4084bd0cc597186f");
				e_player function_b4afc059(var_37b7b46a);
			}
		}
		var_f79ff5ec = zm_utility::function_40ef77ab(var_f79ff5ec);
		var_679cd7a8 = zm_utility::function_a877cd10(var_f79ff5ec);
	}
}

/*
	Name: function_1dcc39ae
	Namespace: namespace_5203fdd
	Checksum: 0x7DE961B
	Offset: 0x2E18
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
		zm_utility::function_cbc75463(1, 1);
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
	Namespace: namespace_5203fdd
	Checksum: 0xA83F7A24
	Offset: 0x2F38
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
	Namespace: namespace_5203fdd
	Checksum: 0xCAD2DEB
	Offset: 0x2FE0
	Size: 0x1A2
	Parameters: 0
	Flags: Linked
*/
function function_9217567c()
{
	level waittill(#"all_players_spawned");
	foreach(var_5f41c401 in level.var_4fe2f84d)
	{
		foreach(var_707469b3 in var_5f41c401)
		{
			if(isarray(var_707469b3.craftfoundry.blueprints))
			{
				foreach(var_6645c992 in var_707469b3.craftfoundry.blueprints)
				{
					if(var_6645c992.name === #"zblueprint_shield_zhield_riot")
					{
						var_707469b3.blueprint = var_6645c992;
					}
				}
			}
		}
	}
}

/*
	Name: init_pack_a_punch
	Namespace: namespace_5203fdd
	Checksum: 0x69A2341D
	Offset: 0x3190
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function init_pack_a_punch()
{
	var_4d8e32c8 = getentarray("zm_pack_a_punch", "targetname");
	foreach(var_5e879929 in var_4d8e32c8)
	{
		var_5e879929 zm_pack_a_punch::function_bb629351(1);
	}
}

/*
	Name: function_edd5bb1a
	Namespace: namespace_5203fdd
	Checksum: 0x632C11D
	Offset: 0x3240
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_edd5bb1a()
{
	if(zm_utility::function_e37823df())
	{
		zm_utility::function_6df718d(#"hash_6db3dde314ca084", 0);
	}
}

/*
	Name: function_ac904e5e
	Namespace: namespace_5203fdd
	Checksum: 0xB2F815DB
	Offset: 0x3288
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
	Namespace: namespace_5203fdd
	Checksum: 0xA81F39DE
	Offset: 0x35C0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_f436d901()
{
	var_5180bf9a = getent("use_elec_switch", "targetname");
	var_5180bf9a hide();
}

/*
	Name: function_ac496011
	Namespace: namespace_5203fdd
	Checksum: 0xB45914C5
	Offset: 0x3610
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_ac496011()
{
	n_obj_id = gameobjects::get_next_obj_id();
	var_1b808f25 = struct::get("s_obj_war_room_map_portal");
	objective_add(n_obj_id, "active", var_1b808f25.origin, #"hash_179c67d4ccb9f19f");
	function_da7940a3(n_obj_id, 1);
	return n_obj_id;
}

/*
	Name: function_b4afc059
	Namespace: namespace_5203fdd
	Checksum: 0xA30500C
	Offset: 0x36A8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_b4afc059(n_obj_id)
{
	if(isdefined(n_obj_id))
	{
		objective_setinvisibletoplayer(n_obj_id, self);
	}
}

