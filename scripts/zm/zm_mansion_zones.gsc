// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5b4f7a8178990872;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_8b84598b;

/*
	Name: init
	Namespace: namespace_8b84598b
	Checksum: 0x51EB35AD
	Offset: 0x790
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_spawned(&function_29ec1ad7);
}

/*
	Name: zone_init
	Namespace: namespace_8b84598b
	Checksum: 0x354E6ADA
	Offset: 0x7C0
	Size: 0x8A4
	Parameters: 0
	Flags: Linked
*/
function zone_init()
{
	level flag::init("always_on");
	level flag::set("always_on");
	zm_zonemgr::zone_init("zone_start_west");
	zm_zonemgr::zone_init("zone_start_east");
	zm_zonemgr::zone_init("zone_underground");
	zm_zonemgr::zone_init("zone_arena");
	level.disable_kill_thread = 1;
	zm_zonemgr::add_adjacent_zone("zone_main_hall", "zone_cellar", "connect_ground_floor_to_cellar", 0);
	zm_zonemgr::add_adjacent_zone("zone_cemetery_entrance", "zone_cemetery_path_left", "connect_cemetery_entrance_to_cemetery_graveyard", 0);
	zm_zonemgr::add_adjacent_zone("zone_cemetery_entrance", "zone_cemetery_path_right", "connect_cemetery_entrance_to_cemetery_graveyard", 0);
	zm_zonemgr::add_adjacent_zone("zone_cemetery_path_left", "zone_cemetery_graveyard", "connect_cemetery_entrance_to_cemetery_graveyard", 0);
	zm_zonemgr::add_adjacent_zone("zone_cemetery_path_right", "zone_cemetery_graveyard", "connect_cemetery_entrance_to_cemetery_graveyard", 0);
	zm_zonemgr::add_adjacent_zone("zone_cemetery_graveyard", "zone_cemetery_mausoleum", "connect_cemetery_entrance_to_cemetery_graveyard", 0);
	zm_zonemgr::add_adjacent_zone("zone_dining_hallway", "zone_dining_room", "connect_main_hall_to_dining_room", 0);
	zm_zonemgr::add_adjacent_zone("zone_dining_room", "zone_greenhouse_entrance", "connect_dining_room_to_greenhouse_entrance", 0);
	zm_zonemgr::add_adjacent_zone("zone_start_corner_east", "zone_hallway_to_bedroom", "connect_starteast_to_hall_to_bedroom", 0);
	zm_zonemgr::add_adjacent_zone("zone_hallway_to_bedroom", "zone_floor2_bedroom", "connect_starteast_to_hall_to_bedroom", 0);
	zm_zonemgr::add_adjacent_zone("zone_floor2_bedroom", "zone_floor2_trophy_room", "connect_starteast_to_hall_to_bedroom", 0);
	zm_zonemgr::add_adjacent_zone("zone_floor2_trophy_room", "zone_hallway_to_bedroom", "connect_starteast_to_hall_to_bedroom", 0);
	zm_zonemgr::add_adjacent_zone("zone_hallway_to_bedroom", "zone_trophy_to_dining_stairs", "connect_bedroom_to_dining_room", 0);
	zm_zonemgr::add_adjacent_zone("zone_trophy_to_dining_stairs", "zone_dining_room", "connect_bedroom_to_dining_room", 0);
	zm_zonemgr::add_adjacent_zone("zone_foyer_east", "zone_foyer_eastend", "connect_start_east_to_foyer_floor2_east", 0);
	zm_zonemgr::add_adjacent_zone("zone_foyer_eastend", "zone_grand_staircase", "connect_foyer_end_to_grand_staircase", 0);
	zm_zonemgr::add_adjacent_zone("zone_foyer_west", "zone_foyer_westend", "connect_start_west_to_foyer_floor2_west", 0);
	zm_zonemgr::add_adjacent_zone("zone_foyer_westend", "zone_grand_staircase", "connect_foyer_end_to_grand_staircase", 0);
	zm_zonemgr::add_adjacent_zone("zone_foyer_westend", "zone_library_hallway_upper", "connect_main_hall_to_upper_hallway_to_library", 0);
	zm_zonemgr::add_adjacent_zone("zone_foyer_west", "zone_foyer_westend", "connect_main_hall_to_upper_hallway_to_library", 0);
	zm_zonemgr::add_adjacent_zone("zone_forest_entrance", "zone_forest_s", "connect_forest_entrance_to_forest", 0);
	zm_zonemgr::add_adjacent_zone("zone_forest_s", "zone_forest_center", "connect_forest_entrance_to_forest", 0);
	zm_zonemgr::add_adjacent_zone("zone_forest_center", "zone_forest_n", "connect_forest_entrance_to_forest", 0);
	zm_zonemgr::add_adjacent_zone("zone_greenhouse_entrance", "zone_greenhouse_lab", "connect_greenhouse_entrance_to_greenhouse_lab", 0);
	zm_zonemgr::add_adjacent_zone("zone_greenhouse_entrance", "zone_sidegarden_right", "connect_greenhouse_entrance_to_greenhouse_lab", 0);
	zm_zonemgr::add_adjacent_zone("zone_greenhouse_lab", "zone_sidegarden_right", "connect_greenhouse_entrance_to_greenhouse_lab", 0);
	zm_zonemgr::add_adjacent_zone("zone_library_hallway_upper", "zone_library_upper", "connect_upper_hall_to_library", 0);
	zm_zonemgr::add_adjacent_zone("zone_library_upper", "zone_library", "connect_upper_hall_to_library", 0);
	zm_zonemgr::add_adjacent_zone("zone_library_hallway_lower", "zone_library", "connect_main_hall_to_library", 0);
	zm_zonemgr::add_adjacent_zone("zone_library", "zone_library_upper", "connect_main_hall_to_library", 0);
	zm_zonemgr::add_adjacent_zone("zone_library_upper", "zone_cemetery_entrance", "connect_library_to_cemetery_entrance", 0);
	zm_zonemgr::add_adjacent_zone("zone_grand_staircase", "zone_entrance_hall", "connect_grand_staircase_to_entrance_hall", 0);
	zm_zonemgr::add_adjacent_zone("zone_main_hall", "zone_grand_staircase", "connect_grand_staircase_to_main_hall", 0);
	zm_zonemgr::add_adjacent_zone("zone_main_hall", "zone_main_hall_north", "connect_grand_staircase_to_main_hall", 0);
	zm_zonemgr::add_adjacent_zone("zone_main_hall", "zone_dining_hallway", "connect_main_hall_to_dining_room", 0);
	zm_zonemgr::add_adjacent_zone("zone_main_hall", "zone_library_hallway_lower", "connect_main_hall_to_library", 0);
	zm_zonemgr::add_adjacent_zone("zone_main_hall_north", "zone_forest_entrance", "connect_main_hall_to_forest_entrance", 0);
	zm_zonemgr::add_adjacent_zone("zone_start_east", "zone_start_corner_east", "always_on", 0);
	zm_zonemgr::add_adjacent_zone("zone_start_east", "zone_main_hall_north", "connect_grand_staircase_to_main_hall", 1);
	zm_zonemgr::add_adjacent_zone("zone_start_corner_east", "zone_foyer_east", "connect_start_east_to_foyer_floor2_east", 0);
	zm_zonemgr::add_adjacent_zone("zone_start_corner_east", "zone_main_hall", "connect_start_east_to_main_hall", 0);
	zm_zonemgr::add_adjacent_zone("zone_start_west", "zone_start_corner_west", "always_on", 0);
	zm_zonemgr::add_adjacent_zone("zone_start_corner_west", "zone_start_room_west", "always_on", 0);
	zm_zonemgr::add_adjacent_zone("zone_start_west", "zone_main_hall_north", "connect_grand_staircase_to_main_hall", 1);
	zm_zonemgr::add_adjacent_zone("zone_start_room_west", "zone_foyer_west", "connect_start_west_to_foyer_floor2_west", 0);
	zm_zonemgr::add_adjacent_zone("zone_start_corner_west", "zone_main_hall", "connect_start_west_to_main_hall", 0);
	zm_zonemgr::add_adjacent_zone("zone_start_west", "zone_start_east", "connect_start_west_to_start_east", 0);
	zm_zonemgr::add_adjacent_zone("zone_underground", "zone_cemetery_graveyard", "connect_cemetery_graveyard_to_underground", 1);
	level thread function_18b016d2();
	zm_zonemgr::function_e5eceb89(#"zone_library_upper");
	zm_zonemgr::function_e5eceb89(#"zone_cemetery_graveyard");
}

/*
	Name: function_18b016d2
	Namespace: namespace_8b84598b
	Checksum: 0xE6CD0B56
	Offset: 0x1070
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_18b016d2()
{
	level endon(#"end_game");
	level flag::wait_till("start_zombie_round_logic");
	a_players = getplayers();
	if(a_players.size <= 2)
	{
		if(randomint(100) > 50)
		{
			a_players[0] function_d274c574();
		}
		if(a_players.size == 2)
		{
			var_b0cb473d = a_players[0] zm_zonemgr::get_player_zone();
			var_9b031bad = a_players[1] zm_zonemgr::get_player_zone();
			if(var_b0cb473d == var_9b031bad)
			{
				a_players[1] function_d274c574();
			}
		}
	}
}

/*
	Name: function_d274c574
	Namespace: namespace_8b84598b
	Checksum: 0x2B6FE108
	Offset: 0x1198
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_d274c574()
{
	str_zone = self zm_zonemgr::get_player_zone();
	a_s_spawn_points = struct::get_array("initial_spawn_points");
	foreach(s_spawn_point in a_s_spawn_points)
	{
		if(s_spawn_point.script_noteworthy != str_zone)
		{
			s_start = s_spawn_point;
			break;
		}
	}
	self setorigin(s_start.origin);
	self setplayerangles(s_start.angles);
}

/*
	Name: function_29ec1ad7
	Namespace: namespace_8b84598b
	Checksum: 0x5A7A681C
	Offset: 0x12B0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_29ec1ad7()
{
	self thread function_8e0b371();
	self thread function_17ac86f7();
}

/*
	Name: function_8e0b371
	Namespace: namespace_8b84598b
	Checksum: 0x3E980C24
	Offset: 0x12F0
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_8e0b371()
{
	self endon(#"disconnect");
	while(true)
	{
		if(isalive(self))
		{
			str_location = function_ab7f70b9(self);
			self namespace_2c9e6caa::function_29780fb5((isdefined(str_location) ? str_location : #""));
		}
		else
		{
			self namespace_2c9e6caa::function_29780fb5(#"");
		}
		wait(0.5);
	}
}

/*
	Name: function_ab7f70b9
	Namespace: namespace_8b84598b
	Checksum: 0xC8C24C7
	Offset: 0x13B0
	Size: 0x5F6
	Parameters: 1
	Flags: Linked
*/
function function_ab7f70b9(e_player)
{
	str_zone = e_player zm_zonemgr::get_player_zone();
	if(!isdefined(str_zone))
	{
		return undefined;
	}
	switch(str_zone)
	{
		case "zone_floor2_bedroom":
		{
			var_601fee0 = #"hash_5b174f0e82a56362";
			break;
		}
		case "zone_floor2_trophy_room":
		{
			var_601fee0 = #"hash_799f29c8059bb492";
			break;
		}
		case "zone_hallway_to_bedroom":
		{
			var_601fee0 = #"hash_39314f35659fff4b";
			break;
		}
		case "zone_cellar":
		{
			var_601fee0 = #"hash_5d4530599612a24a";
			break;
		}
		case "zone_cemetery_entrance":
		case "zone_cemetery_path_left":
		case "zone_cemetery_path_right":
		{
			var_601fee0 = #"hash_5141bcb2e5b72c28";
			break;
		}
		case "zone_cemetery_graveyard":
		{
			var_601fee0 = #"hash_b91dba12f5681cb";
			break;
		}
		case "zone_cemetery_mausoleum":
		{
			var_601fee0 = #"hash_336573cc6209fb70";
			break;
		}
		case "zone_entrance_hall":
		{
			var_601fee0 = #"hash_294db47b299baf9f";
			break;
		}
		case "zone_dining_hallway":
		{
			var_601fee0 = #"hash_cc69f561c03e329";
			break;
		}
		case "zone_trophy_to_dining_stairs":
		{
			var_601fee0 = #"hash_7085496da10debc3";
			break;
		}
		case "zone_dining_room":
		{
			var_601fee0 = #"hash_4cfb09573e278f6a";
			break;
		}
		case "zone_foyer_east":
		{
			var_601fee0 = #"hash_2d30bd945675677f";
			break;
		}
		case "zone_foyer_eastend":
		{
			var_601fee0 = #"hash_2b19c9a3e37c977c";
			break;
		}
		case "zone_foyer_west":
		{
			var_601fee0 = #"hash_fc698faab2e9a15";
			break;
		}
		case "zone_foyer_westend":
		{
			var_601fee0 = #"hash_47b54639df53d26e";
			break;
		}
		case "zone_forest_entrance":
		{
			var_601fee0 = #"hash_4d0468edce809e3b";
			break;
		}
		case "zone_forest_center":
		case "zone_forest_n":
		case "zone_forest_s":
		{
			var_601fee0 = #"hash_1b96528add0fc9c0";
			break;
		}
		case "zone_greenhouse_entrance":
		{
			var_601fee0 = #"hash_3ea748d6a647de7b";
			break;
		}
		case "zone_greenhouse_lab":
		{
			var_601fee0 = #"hash_4fa0217a1bf4ccdc";
			break;
		}
		case "zone_sidegarden_right":
		{
			var_601fee0 = #"hash_14a22fcc9cae07e";
			break;
		}
		case "zone_library":
		{
			var_601fee0 = #"hash_430969697efda742";
			break;
		}
		case "zone_library_upper":
		{
			var_601fee0 = #"hash_75a8495d302e976f";
			break;
		}
		case "zone_library_hallway_lower":
		{
			var_601fee0 = #"hash_4c90c8d92a3dcb37";
			break;
		}
		case "zone_library_hallway_upper":
		{
			var_601fee0 = #"hash_4e4c72cec577f4b6";
			break;
		}
		case "zone_main_hall":
		{
			var_601fee0 = #"hash_41d4a90493982b62";
			break;
		}
		case "zone_main_hall_north":
		{
			var_601fee0 = #"hash_2bad94e7d912ccc6";
			break;
		}
		case "zone_grand_staircase":
		{
			var_601fee0 = #"hash_7a3ea6bcf44cfc17";
			break;
		}
		case "zone_start_east":
		case "zone_start_west":
		{
			var_601fee0 = #"hash_1ac770988eda8b85";
			break;
		}
		case "zone_start_corner_east":
		{
			var_601fee0 = #"hash_2dbd7524c1dc4b3f";
			break;
		}
		case "zone_start_corner_west":
		{
			var_601fee0 = #"hash_3d345090017751d5";
			break;
		}
		case "zone_start_room_west":
		{
			var_601fee0 = #"hash_1da61d307197c763";
			break;
		}
		case "zone_arena":
		{
			var_601fee0 = #"hash_517224645b7ac008";
			break;
		}
		case "zone_underground":
		{
			var_601fee0 = #"hash_ce97d364ff4b9c6";
			break;
		}
		default:
		{
			var_601fee0 = #"hash_33c27ddc507381e3";
			break;
		}
	}
	return var_601fee0;
}

/*
	Name: function_17ac86f7
	Namespace: namespace_8b84598b
	Checksum: 0x81074820
	Offset: 0x19B0
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function function_17ac86f7()
{
	self thread zm_audio::function_713192b1(#"hash_4cfb09573e278f6a", #"dining_room");
	self thread zm_audio::function_713192b1(#"hash_14a22fcc9cae07e", #"garden");
	self thread zm_audio::function_713192b1(#"hash_4e4c72cec577f4b6", #"hash_413cdf3a155d7eb5");
	self thread zm_audio::function_713192b1(#"hash_1b96528add0fc9c0", #"forest");
	self thread zm_audio::function_713192b1(#"hash_b91dba12f5681cb", #"hash_5b3c024325407df5");
	self thread zm_audio::function_713192b1(#"hash_517224645b7ac008", #"druid_arena");
	self thread zm_audio::function_713192b1(#"hash_ce97d364ff4b9c6", #"hash_ed7379fe26527ab");
	self thread zm_audio::function_713192b1(#"hash_4fa0217a1bf4ccdc", #"greenhouse");
	self thread zm_audio::function_713192b1(#"hash_430969697efda742", #"library");
	self thread zm_audio::function_713192b1(#"hash_41d4a90493982b62", #"main_hall");
	self thread zm_audio::function_713192b1(#"hash_5b174f0e82a56362", #"hash_621561abe03ee23");
}

