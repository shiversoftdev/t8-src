// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_39e954a546d3baf;
#using script_3f9e0dc8454d98e1;
#using script_5b4f7a8178990872;
#using script_6a3f43063dfd1bdc;
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_17555f14;

/*
	Name: main
	Namespace: namespace_17555f14
	Checksum: 0x9C65BF93
	Offset: 0x6F8
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function main()
{
	callback::on_spawned(&function_29ec1ad7);
}

/*
	Name: zone_init
	Namespace: namespace_17555f14
	Checksum: 0x77BEF6B
	Offset: 0x728
	Size: 0xE8C
	Parameters: 0
	Flags: None
*/
function zone_init()
{
	level flag::init("always_on");
	level flag::init(#"hash_6f7fd3d4d070db87");
	level flag::init("grotto_tunnel_open");
	level flag::set("always_on");
	level.disable_kill_thread = 1;
	zm_zonemgr::zone_init("ice_grotto");
	zm_zonemgr::enable_zone("ice_grotto");
	zm_zonemgr::zone_init("gehen");
	zm_zonemgr::enable_zone("gehen");
	zm_zonemgr::zone_init("edge");
	zm_zonemgr::enable_zone("edge");
	zm_zonemgr::zone_init("main_entrance");
	zm_zonemgr::zone_init("ice_floe");
	zm_zonemgr::add_adjacent_zone("docks_1", "docks_2", "always_on", 0);
	zm_zonemgr::add_adjacent_zone("docks_2", "boathouse", "docks_to_boathouse", 0);
	zm_zonemgr::add_adjacent_zone("boathouse", "lighthouse_annex", "docks_to_boathouse", 0);
	zm_zonemgr::add_adjacent_zone("boathouse", "lighthouse_annex", "lighthouse_level_1_doors", 0);
	zm_zonemgr::add_adjacent_zone("docks_1", "frozen_crevasse", "frozen_crevasse_open", 0);
	zm_zonemgr::add_adjacent_zone("frozen_crevasse", "lagoon", "frozen_crevasse_open", 0);
	zm_zonemgr::add_adjacent_zone("ice_grotto", "lagoon", "grotto_tunnel_open", 0);
	zm_zonemgr::add_adjacent_zone("ice_grotto", "lagoon", "frozen_crevasse_open", 0);
	zm_zonemgr::add_adjacent_zone("ice_grotto", "lagoon", "docks_to_boathouse", 0);
	zm_zonemgr::add_adjacent_zone("lagoon", "lighthouse_cove", "frozen_crevasse_open", 0);
	zm_zonemgr::add_adjacent_zone("lagoon", "lighthouse_cove", "lighthouse_level_1_doors", 0);
	zm_zonemgr::add_adjacent_zone("lagoon", "lighthouse_cove", "lighthouse_cove_to_lighthouse_station", 0);
	zm_zonemgr::add_adjacent_zone("lagoon", "lighthouse_cove", "grotto_tunnel_open", 0);
	zm_zonemgr::add_adjacent_zone("lagoon", "lighthouse_cove", "docks_to_boathouse", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_annex", "lighthouse_level_1", "lighthouse_level_1_doors", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_cove", "lighthouse_level_1", "lighthouse_level_1_doors", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_cove", "lighthouse_station", "lighthouse_cove_to_lighthouse_station", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_station", "lighthouse_level_2", "lighthouse_station_to_lighthouse_level_2", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_station", "lighthouse_level_3", "lighthouse_station_to_lighthouse_level_3", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_1", "lighthouse_level_2", "lighthouse_level_1_doors", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_1", "lighthouse_level_2", "lighthouse_level_1_doors", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_1", "lighthouse_level_2", "lighthouse_station_to_lighthouse_level_2", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_1", "lighthouse_level_2", "lighthouse_station_to_lighthouse_level_3", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_1", "lighthouse_level_2", "lighthouse_level_3_to_level_4", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_2", "lighthouse_level_3", "lighthouse_level_1_doors", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_2", "lighthouse_level_3", "lighthouse_level_1_doors", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_2", "lighthouse_level_3", "lighthouse_station_to_lighthouse_level_2", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_2", "lighthouse_level_3", "lighthouse_station_to_lighthouse_level_3", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_2", "lighthouse_level_3", "lighthouse_level_3_to_level_4", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_3", "lighthouse_level_4", "lighthouse_level_3_to_level_4", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_level_4", "lighthouse_station", "lighthouse_level_3_to_level_4", 1);
	zm_zonemgr::add_adjacent_zone("lighthouse_station", "lighthouse_approach", "lighthouse_cove_to_lighthouse_station", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_station", "lighthouse_approach", "lighthouse_station_to_lighthouse_level_2", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_station", "lighthouse_approach", "lighthouse_station_to_lighthouse_level_3", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_station", "lighthouse_approach", "beach_to_lighthouse_approach", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_station", "lighthouse_approach", "lighthouse_level_3_to_level_4", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_approach", "beach", "beach_to_lighthouse_approach", 0);
	zm_zonemgr::add_adjacent_zone("lighthouse_cove", "cargo_hold", "lighthouse_cove_to_cargo_hold", 0);
	zm_zonemgr::add_adjacent_zone("beach", "gangway", "beach_to_gangway", 0);
	zm_zonemgr::add_adjacent_zone("gangway", "stern", "gangway_to_stern", 0);
	zm_zonemgr::add_adjacent_zone("gangway", "navigation", "gangway_to_navigation", 0);
	zm_zonemgr::add_adjacent_zone("navigation", "sun_deck", "gangway_to_navigation", 0);
	zm_zonemgr::add_adjacent_zone("sun_deck", "bridge", "sun_deck_to_bridge", 0);
	zm_zonemgr::add_adjacent_zone("gangway", "main_deck", "gangway_to_main_deck", 0);
	zm_zonemgr::add_adjacent_zone("cargo_hold", "main_deck", "lighthouse_cove_to_cargo_hold", 0);
	zm_zonemgr::add_adjacent_zone("cargo_hold", "main_deck", "gangway_to_main_deck", 0);
	zm_zonemgr::add_adjacent_zone("cargo_hold", "main_deck", "hidden_path_open", 0);
	zm_zonemgr::add_adjacent_zone("cargo_hold", "artifact_storage", "cargo_hold_to_artifact_storage", 0);
	zm_zonemgr::add_adjacent_zone("main_deck", "forecastle", "main_deck_to_forecastle", 0);
	zm_zonemgr::add_adjacent_zone("artifact_storage", "forecastle", "artifact_storage_to_forecastle", 0);
	zm_zonemgr::add_adjacent_zone("hidden_path", "cargo_hold", "hidden_path_open", 0);
	zm_zonemgr::add_adjacent_zone("hidden_path", "beach", "hidden_path_open", 1);
	zm_zonemgr::add_adjacent_zone("main_entrance", "security_lobby", #"hash_24952374a6e863b8", 0);
	zm_zonemgr::add_adjacent_zone("security_lobby", "geological_processing", "geological_processing_doors", 0);
	zm_zonemgr::add_adjacent_zone("security_lobby", "decontamination", "decontamination_doors", 0);
	zm_zonemgr::add_adjacent_zone("decontamination", "upper_catwalk", "decontamination_doors", 0);
	zm_zonemgr::add_adjacent_zone("geological_processing", "upper_catwalk", "geological_processing_doors", 0);
	zm_zonemgr::add_adjacent_zone("upper_catwalk", "human_infusion", "upper_catwalk_to_human_infusion", 0);
	zm_zonemgr::add_adjacent_zone("upper_catwalk", "specimen_storage", "specimen_storage_doors", 0);
	zm_zonemgr::add_adjacent_zone("specimen_storage", "loading_platform", #"hash_24952374a6e863b8", 0);
	zm_zonemgr::add_adjacent_zone("sunken_path", "artifact_storage", #"hash_6f7fd3d4d070db87", 0);
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 2)
	{
		zm_zonemgr::add_adjacent_zone("lagoon", "sunken_path", "frozen_crevasse_open", 0);
		zm_zonemgr::add_adjacent_zone("lagoon", "sunken_path", #"hash_6f7fd3d4d070db87", 0);
		zm_zonemgr::add_adjacent_zone("lagoon", "sunken_path", "docks_to_boathouse", 0);
		zm_zonemgr::add_adjacent_zone("main_entrance", "outer_walkway", #"hash_24952374a6e863b8", 0);
		zm_zonemgr::add_adjacent_zone("outer_walkway", "loading_platform", #"hash_24952374a6e863b8", 0);
		zm_zonemgr::add_adjacent_zone("beach", "lighthouse_cove", "frozen_crevasse_open", 0);
		zm_zonemgr::add_adjacent_zone("beach", "lighthouse_cove", "beach_to_lighthouse_approach", 0);
		zm_zonemgr::add_adjacent_zone("beach", "lighthouse_cove", "beach_to_gangway", 0);
		zm_zonemgr::add_adjacent_zone("beach", "lighthouse_cove", "docks_to_boathouse", 0);
	}
	else
	{
		zm_zonemgr::add_adjacent_zone("lagoon", "sunken_path", #"hash_48e7d63b38c5e2da", 0);
		zm_zonemgr::add_adjacent_zone("main_entrance", "outer_walkway", #"hash_52d967f4fc8b12fc", 0);
		zm_zonemgr::add_adjacent_zone("outer_walkway", "loading_platform", #"hash_52d967f4fc8b12fc", 0);
		zm_zonemgr::add_adjacent_zone("beach", "lighthouse_cove", #"hash_38c97197db36afb7", 0);
	}
	level.custom_dog_target_validity_check = &function_502f97fa;
	level thread function_4d5bea6e();
	level thread function_734d8b08();
	level thread function_49054104();
	level thread grotto_tunnel_watcher();
	level thread cargo_hold_to_artifact_storage_watcher();
	level thread sun_deck_to_bridge_watcher();
	level thread main_deck_to_forecastle_watcher();
	if(!zm_utility::is_standard())
	{
		level thread function_9d1d7efd();
		level thread function_58db1b78();
		level thread function_cbb8e588();
	}
}

/*
	Name: main_deck_to_forecastle_watcher
	Namespace: namespace_17555f14
	Checksum: 0x5985136F
	Offset: 0x15C0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function main_deck_to_forecastle_watcher()
{
	level waittill(#"main_deck_to_forecastle");
	var_21a9b20e = array("main_deck_to_forecastle", "main_deck_to_forecastle_blocker");
	level zm_utility::open_door(var_21a9b20e);
}

/*
	Name: function_4d5bea6e
	Namespace: namespace_17555f14
	Checksum: 0x15BB675E
	Offset: 0x1628
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_4d5bea6e()
{
	level flag::init(#"hash_24952374a6e863b8");
	level flag::wait_till(#"hash_24952374a6e863b8");
	zm_zonemgr::enable_zone("main_entrance");
}

/*
	Name: function_734d8b08
	Namespace: namespace_17555f14
	Checksum: 0x3626DEB6
	Offset: 0x1690
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_734d8b08()
{
	level flag::init(#"hash_f14d343f59fc897");
	level flag::wait_till(#"hash_f14d343f59fc897");
	zm_zonemgr::enable_zone("ice_floe");
}

/*
	Name: function_3b77181c
	Namespace: namespace_17555f14
	Checksum: 0x74A672B5
	Offset: 0x16F8
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function function_3b77181c(b_enable = 1)
{
	level.zones[#"ice_floe"].is_enabled = b_enable;
}

/*
	Name: function_49054104
	Namespace: namespace_17555f14
	Checksum: 0x1F6A4984
	Offset: 0x1740
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function function_49054104()
{
	level endon(#"end_game");
	e_blocker = getent("lighthouse_cove_to_lighthouse_level_1_xtra", "targetname");
	level flag::wait_till("lighthouse_level_1_doors");
	e_blocker show();
	e_blocker disconnectpaths();
}

/*
	Name: grotto_tunnel_watcher
	Namespace: namespace_17555f14
	Checksum: 0x1AF6B002
	Offset: 0x17E0
	Size: 0x1EA
	Parameters: 0
	Flags: None
*/
function grotto_tunnel_watcher()
{
	level endon(#"end_game");
	var_752cf781 = getent("grotto_tunnel_big_blocker", "targetname");
	var_752cf781 disconnectpaths();
	a_s_spawn_points = struct::get_array("grotto_tunnel", "psuedo_zone");
	var_ef7245fb = struct::get_array("grotto_tunnel_crawl_spawn", "prefabname");
	a_s_spawn_points = arraycombine(a_s_spawn_points, var_ef7245fb, 0, 0);
	foreach(s_spawn_point in a_s_spawn_points)
	{
		s_spawn_point.is_enabled = 0;
	}
	level flag::wait_till("grotto_tunnel_open");
	var_752cf781 connectpaths();
	var_752cf781 delete();
	foreach(s_spawn_point in a_s_spawn_points)
	{
		s_spawn_point.is_enabled = 1;
	}
}

/*
	Name: cargo_hold_to_artifact_storage_watcher
	Namespace: namespace_17555f14
	Checksum: 0x395082F5
	Offset: 0x19D8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function cargo_hold_to_artifact_storage_watcher()
{
	level endon(#"end_game");
	level flag::wait_till("cargo_hold_to_artifact_storage");
	namespace_3263198e::function_8a7521db("cargo_hold_hatch_door");
}

/*
	Name: sun_deck_to_bridge_watcher
	Namespace: namespace_17555f14
	Checksum: 0xB7A77C9F
	Offset: 0x1A30
	Size: 0xC4
	Parameters: 0
	Flags: None
*/
function sun_deck_to_bridge_watcher()
{
	level endon(#"end_game");
	e_door_clip = getent("sun_deck_to_bridge_clip", "targetname");
	e_door_clip notsolid();
	level flag::wait_till("sun_deck_to_bridge");
	e_door_clip solid();
	e_door_clip disconnectpaths();
	namespace_3263198e::function_8a7521db("bridge_hatch_door");
}

/*
	Name: function_cbaec34a
	Namespace: namespace_17555f14
	Checksum: 0xA7225D83
	Offset: 0x1B00
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_cbaec34a()
{
	result = 0;
	zone_name = self zm_zonemgr::get_player_zone();
	if(isdefined(zone_name) && function_a2888093(zone_name))
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_8355a4a8
	Namespace: namespace_17555f14
	Checksum: 0x82161580
	Offset: 0x1B68
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_8355a4a8()
{
	result = 0;
	zone_name = self zm_utility::get_current_zone();
	if(isdefined(zone_name) && function_a2888093(zone_name))
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_c3bf42e9
	Namespace: namespace_17555f14
	Checksum: 0xF59704BC
	Offset: 0x1BD0
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function function_c3bf42e9()
{
	foreach(e_player in getplayers())
	{
		str_player_zone = e_player zm_zonemgr::get_player_zone();
		if(isdefined(str_player_zone) && function_94b7a4bd(str_player_zone))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_a2888093
	Namespace: namespace_17555f14
	Checksum: 0xA24E70A3
	Offset: 0x1C90
	Size: 0xD6
	Parameters: 1
	Flags: None
*/
function function_a2888093(str_zone)
{
	result = 0;
	if(str_zone == "main_entrance" || str_zone == "security_lobby" || str_zone == "decontamination" || str_zone == "geological_processing" || str_zone == "upper_catwalk" || str_zone == "human_infusion" || str_zone == "specimen_storage" || str_zone == "loading_platform" || str_zone == "outer_walkway")
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_94b7a4bd
	Namespace: namespace_17555f14
	Checksum: 0xB64AA88
	Offset: 0x1D70
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function function_94b7a4bd(str_zone)
{
	if(str_zone == "security_lobby" || str_zone == "decontamination" || str_zone == "geological_processing" || str_zone == "upper_catwalk" || str_zone == "human_infusion" || str_zone == "specimen_storage")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_502f97fa
	Namespace: namespace_17555f14
	Checksum: 0x5496F9B5
	Offset: 0x1E08
	Size: 0x252
	Parameters: 0
	Flags: Private
*/
private function function_502f97fa()
{
	if(!isdefined(self.favoriteenemy) || (isdefined(self.favoriteenemy) && self function_8a80437(self.favoriteenemy) !== 1))
	{
		a_valid_targets = [];
		foreach(player in getplayers())
		{
			if(self function_8a80437(player) == 1)
			{
				if(!isdefined(a_valid_targets))
				{
					a_valid_targets = [];
				}
				else if(!isarray(a_valid_targets))
				{
					a_valid_targets = array(a_valid_targets);
				}
				if(!isinarray(a_valid_targets, player))
				{
					a_valid_targets[a_valid_targets.size] = player;
				}
			}
		}
		if(a_valid_targets.size > 0)
		{
			least_hunted = undefined;
			foreach(player in a_valid_targets)
			{
				if(!isdefined(player))
				{
					continue;
				}
				if(!zm_utility::is_player_valid(player))
				{
					continue;
				}
				if(!isdefined(player.hunted_by))
				{
					player.hunted_by = 0;
				}
				if(!isdefined(least_hunted))
				{
					least_hunted = player;
					continue;
				}
				if(player.hunted_by < least_hunted.hunted_by)
				{
					least_hunted = player;
				}
			}
		}
		if(isdefined(least_hunted))
		{
			self.favoriteenemy = least_hunted;
		}
	}
}

/*
	Name: function_8a80437
	Namespace: namespace_17555f14
	Checksum: 0x65BF990B
	Offset: 0x2068
	Size: 0xAE
	Parameters: 1
	Flags: Private
*/
private function function_8a80437(target)
{
	result = 1;
	if(isdefined(self) && isdefined(target) && isdefined(self.archetype) && self.archetype == #"zombie_dog")
	{
		var_3eb6a47a = target function_cbaec34a();
		var_970d35d = self function_8355a4a8();
		if(var_3eb6a47a != var_970d35d)
		{
			result = 0;
		}
	}
	return result;
}

/*
	Name: function_29ec1ad7
	Namespace: namespace_17555f14
	Checksum: 0xEAFAD9CB
	Offset: 0x2120
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_29ec1ad7()
{
	self thread function_8e0b371();
	if(!zm_utility::is_standard())
	{
		self thread function_17ac86f7();
	}
}

/*
	Name: function_8e0b371
	Namespace: namespace_17555f14
	Checksum: 0xC2611400
	Offset: 0x2170
	Size: 0xB8
	Parameters: 0
	Flags: None
*/
function function_8e0b371()
{
	self endon(#"disconnect");
	while(true)
	{
		if(isalive(self))
		{
			str_location = function_ab7f70b9(self);
			self zm_hud::function_29780fb5((isdefined(str_location) ? str_location : #""));
		}
		else
		{
			self zm_hud::function_29780fb5(#"");
		}
		wait(0.5);
	}
}

/*
	Name: function_ab7f70b9
	Namespace: namespace_17555f14
	Checksum: 0x92EDB4F9
	Offset: 0x2230
	Size: 0x5FE
	Parameters: 2
	Flags: None
*/
function function_ab7f70b9(e_player, str_zone)
{
	if(isdefined(e_player))
	{
		str_zone = e_player zm_zonemgr::get_player_zone();
	}
	if(!isdefined(str_zone))
	{
		return undefined;
	}
	switch(str_zone)
	{
		case "docks_1":
		case "docks_2":
		{
			var_601fee0 = #"hash_99011c41f3d5380";
			break;
		}
		case "boathouse":
		{
			var_601fee0 = #"hash_6b2f9edfc77ea9b2";
			break;
		}
		case "frozen_crevasse":
		{
			var_601fee0 = #"hash_1e6b498a976cdcb5";
			break;
		}
		case "ice_grotto":
		{
			var_601fee0 = #"hash_3461ddd73c20a747";
			break;
		}
		case "lighthouse_annex":
		{
			var_601fee0 = #"hash_43a7944f79cf9bf1";
			break;
		}
		case "lagoon":
		{
			var_601fee0 = #"hash_381e2912fb0376dc";
			break;
		}
		case "lighthouse_cove":
		{
			var_601fee0 = #"hash_2fb0927a65d8a9e";
			break;
		}
		case "lighthouse_station":
		{
			var_601fee0 = #"hash_1424b8bac646249f";
			break;
		}
		case "lighthouse_level_1":
		{
			var_601fee0 = #"hash_7957c402b1b2ef31";
			break;
		}
		case "lighthouse_level_2":
		{
			var_601fee0 = #"hash_7957c102b1b2ea18";
			break;
		}
		case "lighthouse_level_3":
		{
			var_601fee0 = #"hash_7957c202b1b2ebcb";
			break;
		}
		case "lighthouse_level_4":
		{
			var_601fee0 = #"hash_7957c702b1b2f44a";
			break;
		}
		case "lighthouse_approach":
		{
			var_601fee0 = #"hash_39b4e46fd4bebad5";
			break;
		}
		case "beach":
		{
			var_601fee0 = #"hash_75f05448c75c06f";
			break;
		}
		case "hidden_path":
		{
			var_601fee0 = #"hash_3a98581b802c0296";
			break;
		}
		case "gangway":
		{
			var_601fee0 = #"hash_1797071bcd3e6fe6";
			break;
		}
		case "stern":
		{
			var_601fee0 = #"hash_4c328e01a462f48a";
			break;
		}
		case "navigation":
		{
			var_601fee0 = #"hash_3d82a67e307a0426";
			break;
		}
		case "sun_deck":
		{
			var_601fee0 = #"hash_38990c0828e68602";
			break;
		}
		case "bridge":
		{
			var_601fee0 = #"hash_5dbcb178cb1573c1";
			break;
		}
		case "cargo_hold":
		{
			var_601fee0 = #"hash_335d7ee067ac0e68";
			break;
		}
		case "artifact_storage":
		{
			var_601fee0 = #"hash_63f7af429c316620";
			break;
		}
		case "main_deck":
		{
			var_601fee0 = #"hash_75d26f96a738d2a3";
			break;
		}
		case "forecastle":
		{
			var_601fee0 = #"hash_3befc74a37bbeb9e";
			break;
		}
		case "main_entrance":
		{
			var_601fee0 = #"hash_520e403cdf1ae8";
			break;
		}
		case "security_lobby":
		{
			var_601fee0 = #"hash_19a2493217019135";
			break;
		}
		case "geological_processing":
		{
			var_601fee0 = #"hash_21450c4a4a6646d6";
			break;
		}
		case "upper_catwalk":
		{
			var_601fee0 = #"hash_65457ae6fbfe6c32";
			break;
		}
		case "human_infusion":
		{
			var_601fee0 = #"hash_46ef5a594e42c371";
			break;
		}
		case "decontamination":
		{
			var_601fee0 = #"hash_6571eafdcddb13ab";
			break;
		}
		case "specimen_storage":
		{
			var_601fee0 = #"hash_12750e3f1d3659e4";
			break;
		}
		case "loading_platform":
		{
			var_601fee0 = #"hash_4f2b74b3fea599ba";
			break;
		}
		case "outer_walkway":
		{
			var_601fee0 = #"hash_778497a569854310";
			break;
		}
		case "ice_floe":
		{
			var_601fee0 = #"hash_550cd5295ec40e4a";
			break;
		}
		case "sunken_path":
		{
			var_601fee0 = #"hash_18aaabdeba54214a";
			break;
		}
		default:
		{
			var_601fee0 = undefined;
			break;
		}
	}
	return var_601fee0;
}

/*
	Name: function_17ac86f7
	Namespace: namespace_17555f14
	Checksum: 0x9A02E2B2
	Offset: 0x2838
	Size: 0x2DC
	Parameters: 0
	Flags: None
*/
function function_17ac86f7()
{
	self thread zm_audio::function_713192b1(#"hash_6b2f9edfc77ea9b2", #"boathouse");
	self thread zm_audio::function_713192b1(#"hash_2fb0927a65d8a9e", #"lighthouse_cove");
	self thread zm_audio::function_713192b1(#"hash_75f05448c75c06f", #"beach");
	self thread zm_audio::function_713192b1(#"hash_4c328e01a462f48a", #"hash_48aba3bfe56ed7f6");
	self thread zm_audio::function_713192b1(#"hash_5dbcb178cb1573c1", #"hash_1eefffaa31be9005");
	self thread zm_audio::function_713192b1(#"hash_38990c0828e68602", #"hash_1eefffaa31be9005");
	self thread zm_audio::function_713192b1(#"hash_75d26f96a738d2a3", #"hash_534f154b78edc12d");
	self thread zm_audio::function_713192b1(#"hash_335d7ee067ac0e68", #"hash_773a9696fd8ecf0c");
	self thread zm_audio::function_713192b1(#"hash_520e403cdf1ae8", #"hash_d22663e205c54c8");
	self thread zm_audio::function_713192b1(#"hash_12750e3f1d3659e4", #"hash_7dafd21054dda3db");
	self thread zm_audio::function_713192b1(#"hash_6571eafdcddb13ab", #"hash_2781f0de96fa6e4e");
	self thread zm_audio::function_713192b1(#"hash_46ef5a594e42c371", #"hash_4ce194dcbbf4d0aa");
	self thread zm_audio::function_713192b1(#"hash_65457ae6fbfe6c32", #"hash_4ce194dcbbf4d0aa");
	self thread zm_audio::function_713192b1(#"hash_21450c4a4a6646d6", #"hash_6a7fddcbe301f21d");
	self thread function_f7a190a8(undefined, 15, #"hash_99011c41f3d5380", #"docks");
}

/*
	Name: function_f7a190a8
	Namespace: namespace_17555f14
	Checksum: 0x1DA23D9D
	Offset: 0x2B20
	Size: 0x14C
	Parameters: 4
	Flags: None
*/
function function_f7a190a8(str_wait_flag, var_ab660f9a, str_location, var_39acfdda)
{
	level endon(#"end_game");
	self endon(#"death");
	level flag::wait_till("start_zombie_round_logic");
	if(isdefined(str_wait_flag))
	{
		level flag::wait_till(str_wait_flag);
	}
	if(isdefined(var_ab660f9a))
	{
		wait(var_ab660f9a);
	}
	var_33625d75 = function_ab7f70b9(self);
	while(var_33625d75 !== str_location)
	{
		wait(0.5);
		var_33625d75 = function_ab7f70b9(self);
	}
	var_33625d75 = function_ab7f70b9(self);
	while(var_33625d75 === str_location)
	{
		wait(0.5);
		var_33625d75 = function_ab7f70b9(self);
	}
	self thread zm_audio::function_713192b1(str_location, var_39acfdda);
}

/*
	Name: function_9d1d7efd
	Namespace: namespace_17555f14
	Checksum: 0x9CE1E9F
	Offset: 0x2C78
	Size: 0x2A2
	Parameters: 0
	Flags: None
*/
function function_9d1d7efd()
{
	level endon(#"end_game");
	var_de23a374 = array("lighthouse_level_1", "lighthouse_level_2", "lighthouse_level_3");
	level waittill(#"start_zombie_round_logic");
	level flag::wait_till(#"hash_1c52b843cb50942c");
	while(true)
	{
		a_players = [];
		foreach(zone in var_de23a374)
		{
			a_players = arraycombine(a_players, zm_zonemgr::get_players_in_zone(zone, 1), 0, 0);
		}
		if(a_players.size < 1)
		{
			break;
		}
		waitframe(1);
	}
	while(true)
	{
		a_players = [];
		foreach(zone in var_de23a374)
		{
			a_players = arraycombine(a_players, zm_zonemgr::get_players_in_zone(zone, 1), 0, 0);
		}
		if(a_players.size > 0 && level.pablo_npc.var_f75b1f16.size < 1)
		{
			if(a_players[0] zm_audio::function_65e5c19a() && !level flag::get(#"hash_9cfd45106ac760d"))
			{
				player = array::random(a_players);
				player thread namespace_3263198e::function_51b752a9(#"hash_14a884c0dda265b2", -1, 0, 1);
				break;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_58db1b78
	Namespace: namespace_17555f14
	Checksum: 0xF9E9BEEA
	Offset: 0x2F28
	Size: 0x19A
	Parameters: 0
	Flags: None
*/
function function_58db1b78()
{
	level endon(#"end_game");
	level waittill(#"start_zombie_round_logic");
	var_4d44c98e = getentarray("lighthouse_level_4_ext", "targetname");
	while(true)
	{
		foreach(vol_ext in var_4d44c98e)
		{
			foreach(player in getplayers())
			{
				if(player istouching(vol_ext))
				{
					b_played = player zm_audio::create_and_play_dialog(#"hash_20b463357f4ae8f", #"hash_3380edae9bb10779");
					if(b_played)
					{
						return;
					}
				}
			}
			waitframe(1);
		}
	}
}

/*
	Name: function_cbb8e588
	Namespace: namespace_17555f14
	Checksum: 0x8214D1FB
	Offset: 0x30D0
	Size: 0x1AC
	Parameters: 0
	Flags: None
*/
function function_cbb8e588()
{
	level endon(#"end_game");
	level waittill(#"start_zombie_round_logic");
	blood = getent("mq_blood", "targetname");
	while(true)
	{
		foreach(player in getplayers())
		{
			if(player zm_zonemgr::get_player_zone() === "artifact_storage" && player cansee(blood))
			{
				wait(1);
				if(player cansee(blood) && player zm_audio::function_65e5c19a() && !level flag::get(#"hash_9cfd45106ac760d"))
				{
					player namespace_3263198e::function_51b752a9(#"hash_21c0a11438981749");
					return;
				}
			}
		}
		waitframe(1);
	}
}

