// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b10fdf0addd52e;
#using script_2affe92664ace48d;
#using script_31a8049bdbd4af27;
#using script_39e954a546d3baf;
#using script_3a3c430eb58ed475;
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_684097158a90b5c3;
#using script_6ce38ab036223e6e;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_towers_pap_quest.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_65cff301;

/*
	Name: main
	Namespace: namespace_65cff301
	Checksum: 0x9928CC65
	Offset: 0x398
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
	Namespace: namespace_65cff301
	Checksum: 0xBB4F9B72
	Offset: 0x3B8
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function init_level_vars()
{
	function_edd5bb1a();
	function_ac904e5e();
	level.var_d5bd7049 = #"hash_17758d1de3b1fe6a";
	level.var_b0ebbc69 = "zblueprint_shield_zhield_zword";
	level.var_3f86fd35 = 15;
	level.var_d7853f35 = 25;
	level.var_ecdf38f = 20;
	level.var_55e562f9 = 20;
	level.zombie_hints[#"default_treasure_chest"] = #"hash_57a34375dddce337";
	callback::function_74872db6(&function_74872db6);
	level thread function_ca35fa36();
}

/*
	Name: function_74872db6
	Namespace: namespace_65cff301
	Checksum: 0xD36C873B
	Offset: 0x4C0
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
	Name: function_931e4ab1
	Namespace: namespace_65cff301
	Checksum: 0xB6190624
	Offset: 0x508
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function function_931e4ab1()
{
	/#
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
		zm_zonemgr::enable_zone("");
	#/
}

/*
	Name: function_84139b27
	Namespace: namespace_65cff301
	Checksum: 0x230CE2B7
	Offset: 0x658
	Size: 0x674
	Parameters: 0
	Flags: Linked
*/
function function_84139b27()
{
	zm_utility::function_c492c4d6(#"danu", #"hash_692e7036aa28a86e", array(#"zone_danu_top_floor", #"zone_danu_ground_floor"), array(#"temple", #"arena", #"hash_564e150d01ecfb65", #"pit"), #"hash_39a5e0978d0efd73", #"hash_78b1d1196746763d");
	zm_utility::function_c492c4d6(#"ra", #"hash_15c014d044ca67c1", array(#"zone_ra_top_floor", #"zone_ra_ground_floor"), array(#"arena", #"temple", #"hash_564e150d01ecfb65", #"pit"), #"hash_7d572184f439180a", #"hash_298247685ea80656");
	zm_utility::function_c492c4d6(#"odin", #"hash_644b220d0ab22c0c", array(#"zone_odin_top_floor", #"zone_odin_ground_floor"), array(#"temple", #"hash_564e150d01ecfb65", #"pit", #"arena"), #"hash_ed407098b77bc91", #"hash_5e203d11381c57c7");
	zm_utility::function_c492c4d6(#"zeus", #"hash_76fbf2acafa2c1b9", array(#"zone_zeus_ground_floor", #"zone_zeus_top_floor"), array(#"arena", #"hash_564e150d01ecfb65", #"pit", #"temple"), #"hash_417a5feff0cb56ea", #"hash_74941e980968cff6");
	zm_utility::function_c492c4d6(#"temple", #"hash_8117ce3b24d5287", array(#"zone_pap_room", #"zone_pap_room_balcony_flooded_crypt"), array(#"ra", #"danu", #"odin", #"zeus"), #"hash_75add73ac9df6bbc", #"hash_468014d28365550c");
	zm_utility::function_c492c4d6(#"arena", #"hash_67ff9fcb1f12e52d", array(#"zone_starting_area_center"), array(#"ra", #"danu", #"odin", #"zeus"), #"hash_4d59f666d8b7f20c", #"hash_c641ebe32c2d1fc");
	zm_utility::function_c492c4d6(#"pit", #"hash_2db9c4e4d97c7ca9", array(#"zone_body_pit", #"zone_fallen_hero"), array(#"ra", #"danu", #"odin", #"zeus"), #"hash_6880f6ff86cde47e", #"hash_30733dec2e9e228a");
	zm_utility::function_c492c4d6(#"hash_564e150d01ecfb65", #"hash_68baa2a5397d37da", array(#"zone_flooded_crypt", #"zone_cursed_room"), array(#"ra", #"danu", #"odin", #"zeus"), #"hash_107cd70abcec1413", #"hash_3235c0f8ff21201d");
}

/*
	Name: function_69d1ce85
	Namespace: namespace_65cff301
	Checksum: 0x6D938F1B
	Offset: 0xCD8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_69d1ce85(n_round_number)
{
	namespace_acd9c698::function_c9cd31(1);
}

/*
	Name: function_af36af51
	Namespace: namespace_65cff301
	Checksum: 0xAEB7B4E1
	Offset: 0xD08
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_af36af51(n_round_number)
{
	namespace_acd9c698::function_2efc00db(1);
}

/*
	Name: intro_blight_father
	Namespace: namespace_65cff301
	Checksum: 0x3B8AA0BF
	Offset: 0xD38
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function intro_blight_father(n_round_number)
{
	zm_transform::function_bdd8aba6(#"blight_father");
}

/*
	Name: function_b03369f
	Namespace: namespace_65cff301
	Checksum: 0xB7C62606
	Offset: 0xD70
	Size: 0x41C
	Parameters: 0
	Flags: Linked
*/
function function_b03369f()
{
	var_d5d4e4c5 = struct::get(#"p8_fxanim_zm_towers_pap_door_red_bundle", "scriptbundlename");
	var_ef946c5f = struct::get(#"p8_fxanim_zm_towers_pap_door_blue_bundle", "scriptbundlename");
	while(true)
	{
		var_e43d143e = 0;
		foreach(player in level.players)
		{
			if(player zm_zonemgr::is_player_in_zone(array(#"zone_danu_ra_tunnel", #"zone_pap_room", #"zone_pap_room_balcony_flooded_crypt")) && player util::is_player_looking_at(var_d5d4e4c5.origin, 0.9, 0) || (player zm_zonemgr::is_player_in_zone(array(#"zone_odin_zeus_tunnel", #"zone_pap_room", #"zone_pap_room_balcony_flooded_crypt")) && player util::is_player_looking_at(var_ef946c5f.origin, 0.9, 0)))
			{
				var_e43d143e = 1;
				break;
			}
		}
		if(var_e43d143e)
		{
			break;
		}
		waitframe(1);
	}
	level thread scene::play(#"p8_fxanim_zm_towers_pap_door_blue_bundle");
	level thread scene::play(#"p8_fxanim_zm_towers_pap_door_red_bundle");
	a_mdl_pap_room_debris_clip = getentarray("mdl_pap_room_debris_clip", "targetname");
	foreach(mdl_pap_room_debris_clip in a_mdl_pap_room_debris_clip)
	{
		mdl_pap_room_debris_clip connectpaths();
		mdl_pap_room_debris_clip delete();
	}
	level flag::set(#"connect_pap_room_to_danu_ra_tunnel");
	level flag::set(#"connect_pap_room_to_odin_zeus_tunnel");
	zm_zonemgr::enable_zone(#"zone_flooded_crypt");
	zm_zonemgr::enable_zone(#"zone_pap_room_balcony_flooded_crypt");
	zm_zonemgr::enable_zone(#"zone_body_pit");
	zm_zonemgr::enable_zone(#"zone_odin_tunnel");
	zm_zonemgr::enable_zone(#"zone_zeus_tunnel");
	zm_zonemgr::enable_zone(#"zone_cursed_room");
	function_bbbc20bf();
}

/*
	Name: function_bbbc20bf
	Namespace: namespace_65cff301
	Checksum: 0x7E009B38
	Offset: 0x1198
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_bbbc20bf(var_a7bc1cee = 0)
{
	var_307566 = getentarray("mdl_pap_quest_head", "targetname");
	foreach(mdl_head in var_307566)
	{
		mdl_head show();
		if(var_a7bc1cee)
		{
			mdl_head playsound(#"hash_3d7066af9c9bf849");
			mdl_head thread namespace_2ea65b04::function_61cf4d04();
		}
	}
	if(var_a7bc1cee)
	{
		n_time = scene::function_8582657c(#"p8_fxanim_zm_towers_pap_sarcophagus_blood_01_bundle", "Shot 1");
		wait(n_time);
	}
}

/*
	Name: function_b9cacd48
	Namespace: namespace_65cff301
	Checksum: 0x9C1E924A
	Offset: 0x12E0
	Size: 0xEA
	Parameters: 0
	Flags: None
*/
function function_b9cacd48()
{
	/#
		while(true)
		{
			foreach(str_index, s_defend_area in level.var_f05f7e16)
			{
				s_defend_area = zm_utility::function_a877cd10(str_index);
				zm_utility::function_11101458(str_index);
				wait(10);
				zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 5);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: activate_pap_altar
	Namespace: namespace_65cff301
	Checksum: 0x74860176
	Offset: 0x13D8
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function activate_pap_altar()
{
	level thread function_bbbc20bf();
	level clientfield::set("pap_force_stream", 1);
	var_35103e6d = struct::get(#"p8_fxanim_zm_towers_pap_sarcophagus_bundle", "scriptbundlename");
	while(true)
	{
		var_52eeb37 = 0;
		foreach(player in level.players)
		{
			if(player zm_zonemgr::is_player_in_zone(array(#"zone_pap_room", #"zone_pap_room_balcony_flooded_crypt")) && player util::is_player_looking_at(var_35103e6d.origin, 0.9, 0))
			{
				var_52eeb37 = 1;
				break;
			}
		}
		if(var_52eeb37)
		{
			break;
		}
		waitframe(1);
	}
	level notify(#"hash_7ca261f468171655");
	level clientfield::set("pap_force_stream", 0);
	level zm_utility::function_7a35b1d7(#"hash_3083207742f405f6");
}

/*
	Name: function_ca35fa36
	Namespace: namespace_65cff301
	Checksum: 0xB3865742
	Offset: 0x15B0
	Size: 0xF6E
	Parameters: 0
	Flags: Linked
*/
function function_ca35fa36()
{
	level endon(#"end_game");
	function_84139b27();
	level flag::wait_till("start_zombie_round_logic");
	level thread function_5dff542c();
	/#
		if(getdvarint(#"hash_b3363e1d25715d7", 0))
		{
			level thread function_b03369f();
			level thread activate_pap_altar();
			level notify(#"hash_2ff6268271a25ffa");
			level thread function_b9cacd48();
			return;
		}
	#/
	level.var_77f262b9 = 1;
	zm_utility::function_fdb0368(4);
	var_f79ff5ec = array::random(array(#"danu", #"ra"));
	var_b4476de3 = var_f79ff5ec;
	if(var_f79ff5ec == #"danu")
	{
		level zm_utility::open_door("door_starting_area_to_danu_hallway", undefined, undefined, 1);
	}
	else
	{
		level zm_utility::open_door("door_starting_area_to_ra_hallway", undefined, undefined, 1);
	}
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	wait(25);
	zm_zonemgr::function_8caa21df(array(#"zone_danu_ground_floor", #"zone_ra_ground_floor"));
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 20);
	var_69e6a669 = var_f79ff5ec;
	var_f79ff5ec = array::random(array(#"pit", #"hash_564e150d01ecfb65"));
	var_381c9eeb = var_f79ff5ec;
	var_420e4589 = [];
	if(var_69e6a669 == #"danu")
	{
		if(var_f79ff5ec == #"pit")
		{
			var_420e4589 = array("door_danu_basement_to_danu_ra_tunnel", "door_ra_tunnel_to_body_pit");
		}
		else
		{
			var_420e4589 = array("door_danu_basement_to_danu_ra_tunnel", "door_zeus_tunnel_to_flooded_crypt");
		}
	}
	else if(var_f79ff5ec == #"pit")
	{
		var_420e4589 = array("door_ra_basement_to_danu_ra_tunnel", "door_ra_tunnel_to_body_pit");
	}
	else
	{
		var_420e4589 = array("door_ra_basement_to_danu_ra_tunnel", "door_zeus_tunnel_to_flooded_crypt");
	}
	level zm_utility::open_door(var_420e4589, undefined, 8, 1);
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	wait(45);
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	s_defend_area zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7, undefined, undefined, 45);
	level thread function_b03369f();
	zm_utility::function_11101458(#"temple");
	level thread activate_pap_altar();
	wait(45);
	zm_zonemgr::zone_wait_till_enabled(#"zone_pap_room");
	namespace_c3287616::function_306ce518(#"gladiator_marauder", &function_69d1ce85);
	s_defend_area = zm_utility::function_a877cd10(#"temple");
	level thread zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	level flag::wait_till("started_defend_area");
	level util::delay(5, "end_game", &namespace_c3287616::function_376e51ef, #"gladiator_marauder");
	level waittill(#"hash_7a04a7fb98fa4e4d");
	zm_utility::function_fef4b36a(#"temple");
	level util::delay(5, "end_game", &namespace_c3287616::function_376e51ef, #"tiger");
	level notify(#"hash_2ff6268271a25ffa");
	var_f79ff5ec = array::random(array(#"odin", #"zeus"));
	var_2803cfda = var_f79ff5ec;
	if(var_f79ff5ec == #"odin")
	{
		var_420e4589 = array("door_starting_area_to_odin_hallway", "door_odin_basement_to_odin_zeus_tunnel");
	}
	else
	{
		var_420e4589 = array("door_starting_area_to_zeus_hallway", "door_zeus_basement_to_odin_zeus_tunnel");
	}
	level zm_utility::open_door(var_420e4589, undefined, 8, 1);
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	wait(45);
	level notify(#"hash_6a0d2b5af489c227");
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	namespace_c3287616::function_306ce518(#"gladiator_destroyer", &function_af36af51);
	level util::delay("started_defend_area", "end_game", &namespace_c3287616::function_376e51ef, #"gladiator_destroyer");
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	zm_utility::function_fef4b36a(var_f79ff5ec);
	var_f79ff5ec = #"arena";
	zm_utility::function_11101458(#"arena");
	wait(45);
	s_defend_area = zm_utility::function_a877cd10(#"arena");
	level thread zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	level flag::wait_till("started_defend_area");
	level thread namespace_700b02ad::function_93eab559();
	level waittill(#"hash_7a04a7fb98fa4e4d");
	level thread namespace_700b02ad::function_417990b9();
	zm_utility::function_fef4b36a(#"arena");
	if(var_b4476de3 == #"danu")
	{
		var_f79ff5ec = #"ra";
		var_420e4589 = array("door_starting_area_to_ra_hallway", "door_danu_ra_bridge", "door_ra_basement_to_danu_ra_tunnel");
	}
	else
	{
		var_f79ff5ec = #"danu";
		var_420e4589 = array("door_starting_area_to_danu_hallway", "door_danu_ra_bridge", "door_danu_basement_to_danu_ra_tunnel");
	}
	level zm_utility::open_door(var_420e4589, undefined, 8, 1);
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	wait(45);
	namespace_c3287616::function_306ce518(#"blight_father", &intro_blight_father);
	level util::delay("started_defend_area", "end_game", &namespace_c3287616::function_376e51ef, #"blight_father");
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	if(var_381c9eeb == #"pit")
	{
		var_f79ff5ec = #"hash_564e150d01ecfb65";
		var_420e4589 = array("door_zeus_tunnel_to_flooded_crypt");
	}
	else
	{
		var_f79ff5ec = #"pit";
		var_420e4589 = array("door_ra_tunnel_to_body_pit");
	}
	level zm_utility::open_door(var_420e4589, undefined, 8, 1);
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	wait(45);
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	if(var_2803cfda == #"odin")
	{
		var_f79ff5ec = #"zeus";
		var_420e4589 = array("door_starting_area_to_zeus_hallway", "door_zeus_basement_to_odin_zeus_tunnel", "door_odin_zeus_bridge");
	}
	else
	{
		var_f79ff5ec = #"odin";
		var_420e4589 = array("door_starting_area_to_odin_hallway", "door_odin_basement_to_odin_zeus_tunnel", "door_odin_zeus_bridge");
	}
	level zm_utility::open_door(var_420e4589, undefined, 8, 1);
	util::delay(4, undefined, &zm_utility::function_11101458, var_f79ff5ec);
	wait(45);
	s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
	zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
	zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
	var_f79ff5ec = zm_utility::function_40ef77ab(var_f79ff5ec);
	n_wait_time = 45;
	var_837cd1b4 = 0;
	while(true)
	{
		zm_utility::function_11101458(var_f79ff5ec);
		wait(n_wait_time);
		s_defend_area = zm_utility::function_a877cd10(var_f79ff5ec);
		zm_zonemgr::function_8caa21df(s_defend_area.a_str_zones);
		if(var_837cd1b4 == 3 || var_f79ff5ec == #"arena")
		{
			level thread namespace_700b02ad::function_93eab559();
		}
		zm_utility::function_33798535(s_defend_area.var_39c44288, s_defend_area.a_str_zones, s_defend_area.var_ed1db1a7);
		if(var_837cd1b4 == 3 || var_f79ff5ec == #"arena")
		{
			level thread namespace_700b02ad::function_417990b9();
			var_837cd1b4 = 0;
		}
		var_f79ff5ec = zm_utility::function_40ef77ab(var_f79ff5ec);
		n_wait_time = n_wait_time - 2.5;
		if(n_wait_time < 30)
		{
			n_wait_time = 30;
		}
		var_837cd1b4++;
	}
}

/*
	Name: function_5dff542c
	Namespace: namespace_65cff301
	Checksum: 0x4A79668C
	Offset: 0x2528
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_5dff542c()
{
	level endon(#"end_game");
	while(true)
	{
		level waittill(#"hash_7a04a7fb98fa4e4d");
		foreach(player in level.players)
		{
			if(isalive(player))
			{
				player namespace_ebd828b::function_b8dfa139(#"hash_5986c925a370e137");
			}
		}
	}
}

/*
	Name: function_edd5bb1a
	Namespace: namespace_65cff301
	Checksum: 0x77C9A273
	Offset: 0x2610
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
	Namespace: namespace_65cff301
	Checksum: 0x9D4DBBFA
	Offset: 0x2658
	Size: 0x3BC
	Parameters: 0
	Flags: Linked
*/
function function_ac904e5e()
{
	zm_utility::function_742f2c18(1, #"zombie", 6, 6);
	zm_utility::function_742f2c18(2, #"zombie", 6, 8);
	zm_utility::function_742f2c18(3, #"zombie", 6, 8);
	zm_utility::function_742f2c18(4, #"zombie", 6, 8);
	zm_utility::function_742f2c18(5, #"zombie", 6, 8);
	zm_utility::function_742f2c18(6, #"zombie", 10, 8);
	zm_utility::function_742f2c18(7, #"zombie", 10, 8);
	zm_utility::function_742f2c18(8, #"zombie", 10, 8);
	zm_utility::function_742f2c18(9, #"zombie", 10, 8);
	zm_utility::function_742f2c18(10, #"zombie", 12, 12);
	zm_utility::function_742f2c18(11, #"zombie", 14, 12);
	zm_utility::function_742f2c18(12, #"zombie", 14, 14);
	zm_utility::function_742f2c18(13, #"zombie", 16, 14);
	zm_utility::function_742f2c18(14, #"zombie", 20, 16);
	var_a535d72c = 16;
	for(n_round = 15; n_round < 255; n_round++)
	{
		zm_utility::function_742f2c18(n_round, #"zombie", undefined, var_a535d72c);
		var_a535d72c++;
		var_a535d72c = math::clamp(var_a535d72c, 16, 24);
	}
	namespace_c3287616::function_306ce518(#"gladiator_destroyer", &function_e073793e);
	namespace_c3287616::function_306ce518(#"gladiator_marauder", &function_20d7ebbb);
	namespace_c3287616::function_306ce518(#"catalyst", &function_40dfd00b);
	namespace_c3287616::function_306ce518(#"blight_father", &function_dcf7377c);
	namespace_c3287616::function_cc103b38(#"catalyst", 6);
	level thread function_11962516();
}

/*
	Name: function_11962516
	Namespace: namespace_65cff301
	Checksum: 0x3917C6FD
	Offset: 0x2A20
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_11962516()
{
	level endon(#"end_game");
	level waittill(#"hash_6a0d2b5af489c227");
	var_1a397ef = level.round_number + 1;
	if(var_1a397ef == 3 || var_1a397ef == 6)
	{
		var_1a397ef++;
	}
	namespace_c3287616::function_b4a8f95a(#"tiger", var_1a397ef, &namespace_700b02ad::function_f63225b8, &namespace_700b02ad::function_9a74f284, &namespace_700b02ad::function_a5dc8595, &namespace_3fe4d0d7::function_ffa01525);
	zm_utility::function_fdb0368(var_1a397ef);
	wait(2);
	zm_utility::function_9b7bc715(#"tiger", 1);
}

/*
	Name: function_e073793e
	Namespace: namespace_65cff301
	Checksum: 0x515AC334
	Offset: 0x2B40
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_e073793e(n_round_number)
{
	zm_utility::function_9b7bc715(#"gladiator_destroyer", 1);
}

/*
	Name: function_20d7ebbb
	Namespace: namespace_65cff301
	Checksum: 0x5832D7BF
	Offset: 0x2B80
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_20d7ebbb(n_round_number)
{
	zm_utility::function_9b7bc715(#"gladiator_marauder", 1);
}

/*
	Name: function_40dfd00b
	Namespace: namespace_65cff301
	Checksum: 0x769D9277
	Offset: 0x2BC0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_40dfd00b(n_round_number)
{
	zm_utility::function_9b7bc715(#"catalyst", 1);
}

/*
	Name: function_dcf7377c
	Namespace: namespace_65cff301
	Checksum: 0xEAA12560
	Offset: 0x2C00
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_dcf7377c(n_round_number)
{
	zm_utility::function_9b7bc715(#"blight_father", 1);
}

/*
	Name: function_3747b95
	Namespace: namespace_65cff301
	Checksum: 0xA3417A1A
	Offset: 0x2C40
	Size: 0x2F8
	Parameters: 0
	Flags: None
*/
function function_3747b95()
{
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(#"hash_4ffec9c5f552e6fc");
		if(isdefined(var_be17187b.e_door) && isdefined(var_be17187b.e_door.script_flag))
		{
			switch(var_be17187b.e_door.script_flag)
			{
				case "connect_starting_area_to_danu_hallway":
				{
					var_ff20f7d3 = #"hash_756891f8e9b19c50";
					break;
				}
				case "connect_starting_area_to_ra_hallway":
				{
					var_ff20f7d3 = #"hash_2bf18201f54178a3";
					break;
				}
				case "connect_starting_area_to_odin_hallway":
				{
					var_ff20f7d3 = #"hash_51ae58346462e5ea";
					break;
				}
				case "connect_starting_area_to_zeus_hallway":
				{
					var_ff20f7d3 = #"hash_2a82088dd0b6b42f";
					break;
				}
				case "connect_danu_ra_bridge":
				{
					var_ff20f7d3 = #"hash_25d85717f971c376";
					break;
				}
				case "connect_odin_zeus_bridge":
				{
					var_ff20f7d3 = #"hash_634e7ac7c0316c00";
					break;
				}
				case "connect_danu_basement_to_danu_ra_tunnel":
				{
					var_ff20f7d3 = #"hash_77bd07afdb58abd9";
					break;
				}
				case "connect_ra_basement_to_danu_ra_tunnel":
				{
					var_ff20f7d3 = #"hash_45d7dc4e4f0b00f4";
					break;
				}
				case "connect_odin_basement_to_odin_zeus_tunnel":
				{
					var_ff20f7d3 = #"hash_2e9e5b687ffd2e47";
					break;
				}
				case "connect_zeus_basement_to_odin_zeus_tunnel":
				{
					var_ff20f7d3 = #"hash_1354af92e864254c";
					break;
				}
				case "connect_zeus_tunnel_to_flooded_crypt":
				{
					var_ff20f7d3 = #"hash_1a0bc9a2403dc1ee";
					break;
				}
				case "connect_ra_tunnel_to_body_pit":
				{
					var_ff20f7d3 = #"hash_35fd31a4342c9786";
					break;
				}
				default:
				{
					if(var_be17187b.e_door.targetname === "zombie_debris")
					{
						var_ff20f7d3 = #"hash_782714d88bdaa1b6";
					}
					else
					{
						var_ff20f7d3 = #"hash_7203281c0385cddd";
					}
				}
			}
			level zm_utility::function_7a35b1d7(var_ff20f7d3);
		}
	}
}

