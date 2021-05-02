// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\bb.gsc;
#using scripts\zm_common\gametypes\zm_gametype.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_zonemgr;

/*
	Name: function_89f2df9
	Namespace: zm_zonemgr
	Checksum: 0xDEB6E01D
	Offset: 0x2D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_zonemgr", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_zonemgr
	Checksum: 0xB90DB1FA
	Offset: 0x318
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	/#
		println("");
	#/
	level flag::init("zones_initialized");
	level.zones = [];
	level.zone_flags = [];
	level.var_5ef1a72c = [];
	level.var_e046d333 = [];
	level.var_5f6d543e = [];
	level.zone_scanning_active = 0;
	level.str_zone_mgr_mode = "occupied_and_adjacent";
	level.create_spawner_list_func = &create_spawner_list;
	level thread function_228ae7e();
	/#
		level thread function_74a20786();
	#/
}

/*
	Name: zone_is_enabled
	Namespace: zm_zonemgr
	Checksum: 0x37390734
	Offset: 0x410
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function zone_is_enabled(zone_name)
{
	if(!isdefined(level.zones) || !isdefined(level.zones[zone_name]) || !level.zones[zone_name].is_enabled)
	{
		return 0;
	}
	return 1;
}

/*
	Name: zone_wait_till_enabled
	Namespace: zm_zonemgr
	Checksum: 0x59FCDB9A
	Offset: 0x478
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function zone_wait_till_enabled(zone_name)
{
	if(!zone_is_enabled(zone_name))
	{
		level waittill(zone_name);
	}
}

/*
	Name: function_8caa21df
	Namespace: zm_zonemgr
	Checksum: 0xC8DF66C6
	Offset: 0x4B8
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_8caa21df(var_5ef6045b)
{
	if(!isdefined(var_5ef6045b))
	{
		var_5ef6045b = [];
	}
	else if(!isarray(var_5ef6045b))
	{
		var_5ef6045b = array(var_5ef6045b);
	}
	foreach(str_zone_name in var_5ef6045b)
	{
		if(zone_is_enabled(str_zone_name))
		{
			return str_zone_name;
		}
	}
	return level waittill(var_5ef6045b);
}

/*
	Name: function_28cabfbf
	Namespace: zm_zonemgr
	Checksum: 0xB6426772
	Offset: 0x598
	Size: 0xB6
	Parameters: 1
	Flags: None
*/
function function_28cabfbf(var_5ef6045b)
{
	if(!isdefined(var_5ef6045b))
	{
		var_5ef6045b = [];
	}
	else if(!isarray(var_5ef6045b))
	{
		var_5ef6045b = array(var_5ef6045b);
	}
	for(i = 0; i < var_5ef6045b.size; i++)
	{
		str_zone_name = var_5ef6045b[i];
		if(!zone_is_enabled(str_zone_name))
		{
			level waittill(str_zone_name);
			i = -1;
		}
	}
}

/*
	Name: get_player_zone
	Namespace: zm_zonemgr
	Checksum: 0x3DA38B17
	Offset: 0x658
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function get_player_zone()
{
	return zm_utility::get_current_zone();
}

/*
	Name: get_zone_from_position
	Namespace: zm_zonemgr
	Checksum: 0xAB54F2FF
	Offset: 0x678
	Size: 0xE6
	Parameters: 3
	Flags: Linked
*/
function get_zone_from_position(v_pos, ignore_enabled_check = 0, var_1ea110b6 = 0)
{
	if(zm_utility::function_21f4ac36())
	{
		node = function_52c1730(v_pos, level.var_5f6d543e, 500);
		if(isdefined(node))
		{
			if(var_1ea110b6 && !isdefined(getnoderegion(node)))
			{
				return undefined;
			}
			if(ignore_enabled_check || zone_is_enabled(node.targetname))
			{
				return node.targetname;
			}
		}
	}
	return undefined;
}

/*
	Name: function_49d8d29f
	Namespace: zm_zonemgr
	Checksum: 0xB039FE8D
	Offset: 0x768
	Size: 0xA6
	Parameters: 2
	Flags: None
*/
function function_49d8d29f(v_pos, ignore_enabled_check)
{
	zone = undefined;
	keys = getarraykeys(level.zones);
	for(i = 0; i < keys.size; i++)
	{
		if(function_adc70eee(v_pos, keys[i], ignore_enabled_check))
		{
			zone = keys[i];
			break;
		}
	}
	return zone;
}

/*
	Name: function_66bf6a43
	Namespace: zm_zonemgr
	Checksum: 0xC37AC71A
	Offset: 0x818
	Size: 0x88
	Parameters: 2
	Flags: None
*/
function function_66bf6a43(v_pos, ignore_enabled_check)
{
	keys = getarraykeys(level.zones);
	for(i = 0; i < keys.size; i++)
	{
		if(function_adc70eee(v_pos, keys[i], ignore_enabled_check))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: get_zone_magic_boxes
	Namespace: zm_zonemgr
	Checksum: 0x48278B6
	Offset: 0x8A8
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function get_zone_magic_boxes(zone_name)
{
	if(isdefined(zone_name) && !zone_is_enabled(zone_name))
	{
		return undefined;
	}
	zone = level.zones[zone_name];
	/#
		assert(isdefined(zone_name));
	#/
	return zone.magic_boxes;
}

/*
	Name: get_zone_zbarriers
	Namespace: zm_zonemgr
	Checksum: 0x3B0D833B
	Offset: 0x928
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function get_zone_zbarriers(zone_name)
{
	if(isdefined(zone_name) && !zone_is_enabled(zone_name))
	{
		return undefined;
	}
	zone = level.zones[zone_name];
	/#
		assert(isdefined(zone_name));
	#/
	return zone.zbarriers;
}

/*
	Name: get_players_in_zone
	Namespace: zm_zonemgr
	Checksum: 0x1182BFC3
	Offset: 0x9A8
	Size: 0x2D6
	Parameters: 2
	Flags: Linked
*/
function get_players_in_zone(zone_name, return_players)
{
	wait_zone_flags_updating();
	if(!zone_is_enabled(zone_name))
	{
		if(isdefined(return_players) && return_players)
		{
			return [];
		}
		return 0;
	}
	zone = level.zones[zone_name];
	players_in_zone = [];
	players = getplayers();
	if(zm_utility::function_21f4ac36())
	{
		foreach(player in players)
		{
			node = function_52c1730(player.origin, zone.nodes, 500);
			if(isdefined(node))
			{
				if(!isdefined(players_in_zone))
				{
					players_in_zone = [];
				}
				else if(!isarray(players_in_zone))
				{
					players_in_zone = array(players_in_zone);
				}
				if(!isinarray(players_in_zone, player))
				{
					players_in_zone[players_in_zone.size] = player;
				}
			}
		}
	}
	if(zm_utility::function_c85ebbbc())
	{
		for(j = 0; j < players.size; j++)
		{
			for(i = 0; i < zone.volumes.size; i++)
			{
				if(players[j] istouching(zone.volumes[i]))
				{
					if(!isdefined(players_in_zone))
					{
						players_in_zone = [];
					}
					else if(!isarray(players_in_zone))
					{
						players_in_zone = array(players_in_zone);
					}
					if(!isinarray(players_in_zone, player))
					{
						players_in_zone[players_in_zone.size] = player;
					}
					break;
				}
			}
		}
	}
	if(isdefined(return_players) && return_players)
	{
		return players_in_zone;
	}
	return players_in_zone.size;
}

/*
	Name: any_player_in_zone
	Namespace: zm_zonemgr
	Checksum: 0xBC5BAC42
	Offset: 0xC88
	Size: 0x29E
	Parameters: 1
	Flags: Linked
*/
function any_player_in_zone(zone_name)
{
	pixbeginevent("any_player_in_zone");
	if(!zone_is_enabled(zone_name))
	{
		pixendevent();
		return 0;
	}
	zone = level.zones[zone_name];
	if(zm_utility::function_21f4ac36())
	{
		foreach(player in getplayers())
		{
			if(isdefined(level.var_e5a996e8))
			{
				node = [[level.var_e5a996e8]](player, zone);
			}
			else
			{
				node = function_52c1730(player.origin, zone.nodes, 500);
			}
			if(isdefined(node) && player.sessionstate != "spectator")
			{
				pixendevent();
				return 1;
			}
		}
	}
	if(zm_utility::function_c85ebbbc())
	{
		for(i = 0; i < zone.volumes.size; i++)
		{
			players = getplayers();
			for(j = 0; j < players.size; j++)
			{
				if(players[j] istouching(zone.volumes[i]) && !players[j].sessionstate == "spectator")
				{
					pixendevent();
					return 1;
				}
			}
		}
	}
	pixendevent();
	return 0;
}

/*
	Name: function_74a82172
	Namespace: zm_zonemgr
	Checksum: 0x5D01BCC9
	Offset: 0xF30
	Size: 0x15A
	Parameters: 3
	Flags: None
*/
function function_74a82172(location, zone_name, ignore_enabled_check = 0)
{
	if(!zone_is_enabled(zone_name) && !ignore_enabled_check)
	{
		return 0;
	}
	zone = level.zones[zone_name];
	if(zm_utility::function_21f4ac36())
	{
		node = function_52c1730(location, zone.nodes, 500);
		if(isdefined(node))
		{
			return 1;
		}
	}
	if(zm_utility::function_c85ebbbc())
	{
		foreach(e_volume in zone.volumes)
		{
			if(istouching(location, e_volume))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_adc70eee
	Namespace: zm_zonemgr
	Checksum: 0xAF051900
	Offset: 0x1098
	Size: 0xBE
	Parameters: 3
	Flags: Linked
*/
function function_adc70eee(location, zone_name, ignore_enabled_check = 0)
{
	if(!zone_is_enabled(zone_name) && !ignore_enabled_check)
	{
		return 0;
	}
	zone = level.zones[zone_name];
	if(zm_utility::function_21f4ac36())
	{
		node = function_52c1730(location, zone.nodes, 500);
		if(isdefined(node))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: entity_in_zone
	Namespace: zm_zonemgr
	Checksum: 0x7680CA11
	Offset: 0x1160
	Size: 0x17A
	Parameters: 2
	Flags: Linked
*/
function entity_in_zone(zone_name, ignore_enabled_check = 0)
{
	if(isplayer(self) && self.sessionstate == "spectator")
	{
		return 0;
	}
	if(!zone_is_enabled(zone_name) && !ignore_enabled_check)
	{
		return 0;
	}
	zone = level.zones[zone_name];
	if(zm_utility::function_21f4ac36())
	{
		node = function_52c1730(self.origin, zone.nodes, 500);
		if(isdefined(node))
		{
			return 1;
		}
	}
	if(zm_utility::function_c85ebbbc())
	{
		foreach(e_volume in zone.volumes)
		{
			if(self istouching(e_volume))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: entity_in_active_zone
	Namespace: zm_zonemgr
	Checksum: 0xC70A8F6E
	Offset: 0x12E8
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function entity_in_active_zone(ignore_enabled_check = 0)
{
	if(isplayer(self) && self.sessionstate == "spectator")
	{
		return 0;
	}
	foreach(str_adj_zone in level.active_zone_names)
	{
		b_in_zone = entity_in_zone(str_adj_zone, ignore_enabled_check);
		if(b_in_zone)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: deactivate_initial_barrier_goals
	Namespace: zm_zonemgr
	Checksum: 0x997A1C00
	Offset: 0x13D8
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function deactivate_initial_barrier_goals()
{
	special_goals = struct::get_array("exterior_goal", "targetname");
	for(i = 0; i < special_goals.size; i++)
	{
		if(isdefined(special_goals[i].script_noteworthy))
		{
			special_goals[i].is_active = 0;
			special_goals[i] triggerenable(0);
		}
	}
}

/*
	Name: zone_init
	Namespace: zm_zonemgr
	Checksum: 0x91DFFCC9
	Offset: 0x1480
	Size: 0xE0C
	Parameters: 2
	Flags: Linked
*/
function zone_init(zone_name, zone_tag)
{
	if(isdefined(level.zones[zone_name]))
	{
		return;
	}
	/#
		println("" + zone_name);
	#/
	level.zones[zone_name] = spawnstruct();
	zone = level.zones[zone_name];
	zone.name = zone_name;
	zone.is_enabled = 0;
	zone.is_occupied = 0;
	zone.is_active = 0;
	zone.adjacent_zones = [];
	zone.is_spawning_allowed = 0;
	if(isdefined(zone_tag))
	{
		zone_name_tokens = strtok(zone_name, "_");
		zone.district = zone_name_tokens[1];
		zone.area = zone_tag;
	}
	zone.nodes = getnodearray(zone_name, "targetname");
	/#
		var_a44786e4 = 0;
		foreach(node in zone.nodes)
		{
			if(node.type == "" || !isdefined(getnoderegion(node)))
			{
				if(!var_a44786e4)
				{
					println("");
				}
				var_a44786e4 = 1;
				println("" + zone_name + "" + node.origin[0] + "" + node.origin[1] + "" + node.origin[2] + "");
			}
		}
		/#
			assert(!var_a44786e4);
		#/
	#/
	level.var_5f6d543e = arraycombine(level.var_5f6d543e, zone.nodes, 0, 0);
	var_34065104 = array("inner_zigzag_radius", "outer_zigzag_radius", "zigzag_distance_min", "zigzag_distance_max", "zigzag_activation_distance", "zigzag_enabled");
	foreach(node in zone.nodes)
	{
		foreach(var_72fd8204 in var_34065104)
		{
			if(isdefined(node.(var_72fd8204)))
			{
				/#
					assert(!isdefined(zone.(var_72fd8204)), "" + var_72fd8204 + "" + zone_name);
				#/
				zone.(var_72fd8204) = node.(var_72fd8204);
			}
		}
	}
	zone.volumes = [];
	volumes = getentarray(zone_name, "targetname");
	/#
		println("" + volumes.size + "" + zone.nodes.size);
	#/
	for(i = 0; i < volumes.size; i++)
	{
		if(volumes[i].classname == "info_volume")
		{
			zone.volumes[zone.volumes.size] = volumes[i];
		}
	}
	/#
		assert(isdefined(zone.volumes[0]) || isdefined(zone.nodes[0]), "" + zone_name);
	#/
	/#
		zone.total_spawn_count = 0;
		zone.round_spawn_count = 0;
	#/
	zone.a_loc_types = [];
	zone.a_loc_types[#"zombie_location"] = [];
	zone.zbarriers = [];
	zone.magic_boxes = [];
	if(zm_utility::function_21f4ac36() && zone.nodes.size > 0)
	{
		var_38079066 = zone.nodes[0].target;
	}
	else if(zm_utility::function_c85ebbbc() && zone.volumes[0].size > 0)
	{
		var_38079066 = zone.volumes[0].target;
	}
	if(isdefined(var_38079066))
	{
		spots = struct::get_array(var_38079066, "targetname");
		barricades = struct::get_array("exterior_goal", "targetname");
		box_locs = struct::get_array("treasure_chest_use", "targetname");
		foreach(spot in spots)
		{
			spot.zone_name = zone_name;
			if(!(isdefined(spot.is_blocked) && spot.is_blocked))
			{
				spot.is_enabled = 1;
			}
			else
			{
				spot.is_enabled = 0;
			}
			tokens = strtok(spot.script_noteworthy, " ");
			foreach(token in tokens)
			{
				switch(token)
				{
					case "custom_spawner_entry":
					case "spawn_location":
					case "riser_location":
					case "faller_location":
					{
						spot.var_d51f4e2d = gettime();
						if(!isdefined(zone.a_loc_types[#"zombie_location"]))
						{
							zone.a_loc_types[#"zombie_location"] = [];
						}
						else if(!isarray(zone.a_loc_types[#"zombie_location"]))
						{
							zone.a_loc_types[#"zombie_location"] = array(zone.a_loc_types[#"zombie_location"]);
						}
						zone.a_loc_types[#"zombie_location"][zone.a_loc_types[#"zombie_location"].size] = spot;
						break;
					}
					default:
					{
						if(!isdefined(zone.a_loc_types[token]))
						{
							zone.a_loc_types[token] = [];
						}
						if(!isdefined(zone.a_loc_types[token]))
						{
							zone.a_loc_types[token] = [];
						}
						else if(!isarray(zone.a_loc_types[token]))
						{
							zone.a_loc_types[token] = array(zone.a_loc_types[token]);
						}
						zone.a_loc_types[token][zone.a_loc_types[token].size] = spot;
					}
				}
			}
			if(isdefined(spot.script_string))
			{
				barricade_id = spot.script_string;
				for(k = 0; k < barricades.size; k++)
				{
					if(isdefined(barricades[k].script_string) && barricades[k].script_string == barricade_id)
					{
						nodes = getnodearray(barricades[k].target, "targetname");
						for(j = 0; j < nodes.size; j++)
						{
							if(isdefined(nodes[j].type) && nodes[j].type == #"begin")
							{
								spot.target = nodes[j].targetname;
							}
						}
					}
				}
			}
		}
		for(i = 0; i < barricades.size; i++)
		{
			targets = getentarray(barricades[i].target, "targetname");
			for(j = 0; j < targets.size; j++)
			{
				if(targets[j] iszbarrier() && isdefined(targets[j].script_string) && targets[j].script_string == zone_name)
				{
					if(!isdefined(zone.zbarriers))
					{
						zone.zbarriers = [];
					}
					else if(!isarray(zone.zbarriers))
					{
						zone.zbarriers = array(zone.zbarriers);
					}
					zone.zbarriers[zone.zbarriers.size] = targets[j];
				}
			}
		}
		for(i = 0; i < box_locs.size; i++)
		{
			chest_ent = getent(box_locs[i].script_noteworthy + "_zbarrier", "script_noteworthy");
			if(chest_ent entity_in_zone(zone_name, 1))
			{
				if(!isdefined(zone.magic_boxes))
				{
					zone.magic_boxes = [];
				}
				else if(!isarray(zone.magic_boxes))
				{
					zone.magic_boxes = array(zone.magic_boxes);
				}
				zone.magic_boxes[zone.magic_boxes.size] = box_locs[i];
			}
		}
	}
}

/*
	Name: reinit_zone_spawners
	Namespace: zm_zonemgr
	Checksum: 0xB408345B
	Offset: 0x2298
	Size: 0x564
	Parameters: 0
	Flags: None
*/
function reinit_zone_spawners()
{
	zkeys = getarraykeys(level.zones);
	for(i = 0; i < level.zones.size; i++)
	{
		zone = level.zones[zkeys[i]];
		zone.a_loc_types = [];
		zone.a_loc_types[#"zombie_location"] = [];
		if(zm_utility::function_21f4ac36() && zone.nodes.size > 0)
		{
			var_38079066 = zone.nodes[0].target;
		}
		else if(zm_utility::function_c85ebbbc() && zone.volumes[0].size > 0)
		{
			var_38079066 = zone.volumes[0].target;
		}
		if(isdefined(var_38079066))
		{
			spots = struct::get_array(var_38079066, "targetname");
			foreach(n_index, spot in spots)
			{
				spot.zone_name = zkeys[n_index];
				if(!(isdefined(spot.is_blocked) && spot.is_blocked))
				{
					spot.is_enabled = 1;
				}
				else
				{
					spot.is_enabled = 0;
				}
				tokens = strtok(spot.script_noteworthy, " ");
				foreach(token in tokens)
				{
					switch(token)
					{
						case "custom_spawner_entry":
						case "spawn_location":
						case "riser_location":
						case "spawner_location":
						case "faller_location":
						{
							if(!isdefined(zone.a_loc_types[#"zombie_location"]))
							{
								zone.a_loc_types[#"zombie_location"] = [];
							}
							else if(!isarray(zone.a_loc_types[#"zombie_location"]))
							{
								zone.a_loc_types[#"zombie_location"] = array(zone.a_loc_types[#"zombie_location"]);
							}
							zone.a_loc_types[#"zombie_location"][zone.a_loc_types[#"zombie_location"].size] = spot;
							break;
						}
						default:
						{
							if(!isdefined(zone.a_loc_types[token]))
							{
								zone.a_loc_types[token] = [];
							}
							else if(!isarray(zone.a_loc_types[token]))
							{
								zone.a_loc_types[token] = array(zone.a_loc_types[token]);
							}
							if(!isdefined(zone.a_loc_types[token]))
							{
								zone.a_loc_types[token] = [];
							}
							else if(!isarray(zone.a_loc_types[token]))
							{
								zone.a_loc_types[token] = array(zone.a_loc_types[token]);
							}
							zone.a_loc_types[token][zone.a_loc_types[token].size] = spot;
						}
					}
				}
			}
		}
	}
}

/*
	Name: enable_zone
	Namespace: zm_zonemgr
	Checksum: 0xB47743D
	Offset: 0x2808
	Size: 0x324
	Parameters: 1
	Flags: Linked
*/
function enable_zone(zone_name)
{
	/#
		assert(isdefined(level.zones) && isdefined(level.zones[zone_name]), "");
	#/
	if(level.zones[zone_name].is_enabled)
	{
		return;
	}
	level.zones[zone_name].is_enabled = 1;
	level.zones[zone_name].is_spawning_allowed = 1;
	level notify(zone_name);
	level notify(#"hash_7f3e3ea9f03a4f3a", {#str_zone_name:zone_name});
	spawn_points = zm_gametype::get_player_spawns_for_gametype();
	for(i = 0; i < spawn_points.size; i++)
	{
		if(spawn_points[i].script_noteworthy == zone_name)
		{
			spawn_points[i].locked = 0;
		}
	}
	entry_points = struct::get_array(zone_name + "_barriers", "script_noteworthy");
	for(i = 0; i < entry_points.size; i++)
	{
		entry_points[i].is_active = 1;
		entry_points[i] triggerenable(1);
	}
	foreach(node in level.zones[zone_name].nodes)
	{
		if(!isdefined(level.var_e046d333))
		{
			level.var_e046d333 = [];
		}
		else if(!isarray(level.var_e046d333))
		{
			level.var_e046d333 = array(level.var_e046d333);
		}
		if(!isinarray(level.var_e046d333, getnoderegion(node)))
		{
			level.var_e046d333[level.var_e046d333.size] = getnoderegion(node);
		}
	}
	bb::function_22b9bc7("zone_enable_" + zone_name);
}

/*
	Name: make_zone_adjacent
	Namespace: zm_zonemgr
	Checksum: 0xBE31A397
	Offset: 0x2B38
	Size: 0x176
	Parameters: 3
	Flags: Linked
*/
function make_zone_adjacent(main_zone_name, adj_zone_name, flag_name)
{
	main_zone = level.zones[main_zone_name];
	if(!isdefined(main_zone.adjacent_zones[adj_zone_name]))
	{
		main_zone.adjacent_zones[adj_zone_name] = spawnstruct();
		adj_zone = main_zone.adjacent_zones[adj_zone_name];
		adj_zone.is_connected = 0;
		adj_zone.flags_do_or_check = 0;
		if(isarray(flag_name))
		{
			adj_zone.flags = flag_name;
		}
		else
		{
			adj_zone.flags[0] = flag_name;
		}
	}
	else
	{
		/#
			assert(!isarray(flag_name), "");
		#/
		adj_zone = main_zone.adjacent_zones[adj_zone_name];
		size = adj_zone.flags.size;
		adj_zone.flags_do_or_check = 1;
		adj_zone.flags[size] = flag_name;
	}
}

/*
	Name: add_zone_flags
	Namespace: zm_zonemgr
	Checksum: 0x7A71CA8B
	Offset: 0x2CB8
	Size: 0x11E
	Parameters: 2
	Flags: None
*/
function add_zone_flags(wait_flag, add_flags)
{
	if(!isdefined(add_flags))
	{
		add_flags = [];
	}
	else if(!isarray(add_flags))
	{
		add_flags = array(add_flags);
	}
	keys = getarraykeys(level.zone_flags);
	for(i = 0; i < keys.size; i++)
	{
		if(keys[i] == wait_flag)
		{
			level.zone_flags[keys[i]] = arraycombine(level.zone_flags[keys[i]], add_flags, 1, 0);
			return;
		}
	}
	level.zone_flags[wait_flag] = add_flags;
}

/*
	Name: add_adjacent_zone
	Namespace: zm_zonemgr
	Checksum: 0xBF6ABECE
	Offset: 0x2DE0
	Size: 0xEC
	Parameters: 6
	Flags: Linked
*/
function add_adjacent_zone(zone_name_a, zone_name_b, flag_name, one_way = 1, zone_tag_a, zone_tag_b)
{
	if(!isdefined(level.flag[flag_name]))
	{
		level flag::init(flag_name);
	}
	zone_init(zone_name_a, zone_tag_a);
	zone_init(zone_name_b, zone_tag_b);
	make_zone_adjacent(zone_name_a, zone_name_b, flag_name);
	if(!one_way)
	{
		make_zone_adjacent(zone_name_b, zone_name_a, flag_name);
	}
}

/*
	Name: setup_zone_flag_waits
	Namespace: zm_zonemgr
	Checksum: 0xEFD765E3
	Offset: 0x2ED8
	Size: 0x1EE
	Parameters: 0
	Flags: Linked
*/
function setup_zone_flag_waits()
{
	flags = [];
	zkeys = getarraykeys(level.zones);
	for(z = 0; z < level.zones.size; z++)
	{
		zone = level.zones[zkeys[z]];
		azkeys = getarraykeys(zone.adjacent_zones);
		for(az = 0; az < zone.adjacent_zones.size; az++)
		{
			azone = zone.adjacent_zones[azkeys[az]];
			for(f = 0; f < azone.flags.size; f++)
			{
				if(!isdefined(flags))
				{
					flags = [];
				}
				else if(!isarray(flags))
				{
					flags = array(flags);
				}
				if(!isinarray(flags, azone.flags[f]))
				{
					flags[flags.size] = azone.flags[f];
				}
			}
		}
	}
	for(i = 0; i < flags.size; i++)
	{
		level thread zone_flag_wait(flags[i]);
	}
}

/*
	Name: wait_zone_flags_updating
	Namespace: zm_zonemgr
	Checksum: 0xA5373487
	Offset: 0x30D0
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function wait_zone_flags_updating()
{
	if(!isdefined(level.zone_flags_updating))
	{
		level.zone_flags_updating = 0;
	}
	while(level.zone_flags_updating > 0)
	{
		waitframe(1);
	}
}

/*
	Name: zone_flag_wait_throttle
	Namespace: zm_zonemgr
	Checksum: 0xF2F074EE
	Offset: 0x3118
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function zone_flag_wait_throttle()
{
	if(!isdefined(level.zone_flag_wait_throttle))
	{
		level.zone_flag_wait_throttle = 0;
	}
	level.zone_flag_wait_throttle++;
	if(level.zone_flag_wait_throttle > 3)
	{
		level.zone_flag_wait_throttle = 0;
		waitframe(1);
	}
}

/*
	Name: zone_flag_wait
	Namespace: zm_zonemgr
	Checksum: 0xFFB05403
	Offset: 0x3178
	Size: 0x584
	Parameters: 1
	Flags: Linked
*/
function zone_flag_wait(flag_name)
{
	if(!isdefined(level.flag[flag_name]))
	{
		level flag::init(flag_name);
	}
	if(flag_name == "power_on" && namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 2)
	{
		waitframe(1);
	}
	level flag::wait_till(flag_name);
	if(!isdefined(level.zone_flags_updating))
	{
		level.zone_flags_updating = 0;
	}
	level.zone_flags_updating++;
	flags_set = 0;
	for(z = 0; z < level.zones.size; z++)
	{
		zkeys = getarraykeys(level.zones);
		zone = level.zones[zkeys[z]];
		for(az = 0; az < zone.adjacent_zones.size; az++)
		{
			azkeys = getarraykeys(zone.adjacent_zones);
			azone = zone.adjacent_zones[azkeys[az]];
			if(!azone.is_connected)
			{
				if(azone.flags_do_or_check)
				{
					flags_set = 0;
					if(azone.flags.size == 1 && azone.flags[0] == "power_on" && namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 2)
					{
						flags_set = 1;
					}
					else
					{
						for(f = 0; f < azone.flags.size; f++)
						{
							if(level flag::get(azone.flags[f]))
							{
								flags_set = 1;
								break;
							}
						}
					}
				}
				else
				{
					flags_set = 1;
					if(azone.flags.size == 1 && azone.flags[0] == "power_on" && namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 2)
					{
						flags_set = 1;
					}
					else
					{
						for(f = 0; f < azone.flags.size; f++)
						{
							if(!level flag::get(azone.flags[f]))
							{
								flags_set = 0;
							}
						}
					}
				}
				if(flags_set)
				{
					enable_zone(level.zones[zkeys[z]].name);
					azone.is_connected = 1;
					if(!level.zones[azkeys[az]].is_enabled)
					{
						enable_zone(level.zones[azkeys[az]].name);
						zone_flag_wait_throttle();
					}
					if(level flag::get("door_can_close"))
					{
						azone thread door_close_disconnect(flag_name);
					}
				}
			}
		}
	}
	keys = getarraykeys(level.zone_flags);
	for(i = 0; i < keys.size; i++)
	{
		if(keys[i] == flag_name)
		{
			check_flag = level.zone_flags[keys[i]];
			for(k = 0; k < check_flag.size; k++)
			{
				if(check_flag[k] != #"power_on")
				{
					if(!level flag::get(check_flag[k]))
					{
						level flag::set(check_flag[k]);
						zone_flag_wait_throttle();
					}
				}
			}
			break;
		}
	}
	level.zone_flag_wait_throttle = 0;
	level.zone_flags_updating--;
	function_d4cf2b9b(1);
}

/*
	Name: door_close_disconnect
	Namespace: zm_zonemgr
	Checksum: 0xAB1B9039
	Offset: 0x3708
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function door_close_disconnect(flag_name)
{
	while(level flag::get(flag_name))
	{
		wait(1);
	}
	self.is_connected = 0;
	level thread zone_flag_wait(flag_name);
}

/*
	Name: manage_zones
	Namespace: zm_zonemgr
	Checksum: 0x7308F1DE
	Offset: 0x3768
	Size: 0xA58
	Parameters: 1
	Flags: Linked
*/
function manage_zones(initial_zone)
{
	/#
		assert(isdefined(initial_zone), "");
	#/
	deactivate_initial_barrier_goals();
	level.player_zone_found = 1;
	zone_choke = 0;
	spawn_points = zm_gametype::get_player_spawns_for_gametype();
	for(i = 0; i < spawn_points.size; i++)
	{
		/#
			assert(isdefined(spawn_points[i].script_noteworthy), "");
		#/
		spawn_points[i].locked = 1;
	}
	if(isdefined(level.zone_manager_init_func))
	{
		[[level.zone_manager_init_func]]();
	}
	/#
		println("" + initial_zone.size);
	#/
	if(isarray(initial_zone))
	{
		/#
			println("" + initial_zone[0]);
		#/
		for(i = 0; i < initial_zone.size; i++)
		{
			zone_init(initial_zone[i]);
			enable_zone(initial_zone[i]);
		}
	}
	else
	{
		/#
			println("" + initial_zone);
		#/
		zone_init(initial_zone);
		enable_zone(initial_zone);
	}
	setup_zone_flag_waits();
	zkeys = getarraykeys(level.zones);
	level.zone_keys = zkeys;
	level.newzones = [];
	for(z = 0; z < zkeys.size; z++)
	{
		level.newzones[zkeys[z]] = spawnstruct();
	}
	oldzone = undefined;
	level flag::set("zones_initialized");
	level flag::wait_till("begin_spawning");
	/#
		level thread _debug_zones();
	#/
	/#
		level thread function_8a9003ae();
	#/
	while(getdvarint(#"noclip", 0) == 0 || getdvarint(#"notarget", 0) != 0)
	{
		wait_zone_flags_updating();
		for(z = 0; z < zkeys.size; z++)
		{
			level.newzones[zkeys[z]].is_active = 0;
			level.newzones[zkeys[z]].is_occupied = 0;
		}
		a_zone_is_active = 0;
		a_zone_is_spawning_allowed = 0;
		level.zone_scanning_active = 1;
		for(z = 0; z < zkeys.size; z++)
		{
			zone = level.zones[zkeys[z]];
			newzone = level.newzones[zkeys[z]];
			if(!zone.is_enabled)
			{
				continue;
			}
			if(isdefined(level.zone_occupied_func))
			{
				newzone.is_occupied = [[level.zone_occupied_func]](zkeys[z]);
			}
			else
			{
				newzone.is_occupied = any_player_in_zone(zkeys[z]);
			}
			if(newzone.is_occupied)
			{
				newzone.is_active = 1;
				a_zone_is_active = 1;
				if(zone.is_spawning_allowed)
				{
					a_zone_is_spawning_allowed = 1;
				}
				if(!isdefined(oldzone) || oldzone != newzone)
				{
					level notify(#"newzoneactive", {#zone:zkeys[z]});
					oldzone = newzone;
				}
				azkeys = getarraykeys(zone.adjacent_zones);
				for(az = 0; az < zone.adjacent_zones.size; az++)
				{
					if(zone.adjacent_zones[azkeys[az]].is_connected && level.zones[azkeys[az]].is_enabled)
					{
						level.newzones[azkeys[az]].is_active = 1;
						if(level.zones[azkeys[az]].is_spawning_allowed)
						{
							a_zone_is_spawning_allowed = 1;
						}
					}
				}
			}
			zone_choke++;
			if(zone_choke >= 2)
			{
				zone_choke = 0;
				waitframe(1);
				wait_zone_flags_updating();
			}
		}
		level.zone_scanning_active = 0;
		for(z = 0; z < zkeys.size; z++)
		{
			level.zones[zkeys[z]].is_active = level.newzones[zkeys[z]].is_active;
			level.zones[zkeys[z]].is_occupied = level.newzones[zkeys[z]].is_occupied;
		}
		if(!a_zone_is_active || !a_zone_is_spawning_allowed)
		{
			var_8cd03217 = 0;
			foreach(e_player in level.players)
			{
				if(e_player.sessionstate != "spectator")
				{
					var_bdf9e3c2 = e_player zm_utility::get_current_zone();
					if(!isdefined(var_bdf9e3c2))
					{
						continue;
					}
					s_zone = level.zones[var_bdf9e3c2];
					s_zone.is_active = 1;
					s_zone.is_occupied = 1;
					s_zone.is_spawning_allowed = 1;
					foreach(str_zone_name, var_c714ccfe in s_zone.adjacent_zones)
					{
						if(var_c714ccfe.is_connected && level.zones[str_zone_name].is_enabled)
						{
							level.zones[str_zone_name].is_active = 1;
							level.zones[str_zone_name].is_spawning_allowed = 1;
						}
					}
					var_8cd03217 = 1;
					break;
				}
			}
			if(!var_8cd03217)
			{
				if(isarray(initial_zone))
				{
					level.zones[initial_zone[0]].is_active = 1;
					level.zones[initial_zone[0]].is_occupied = 1;
					level.zones[initial_zone[0]].is_spawning_allowed = 1;
				}
				else
				{
					level.zones[initial_zone].is_active = 1;
					level.zones[initial_zone].is_occupied = 1;
					level.zones[initial_zone].is_spawning_allowed = 1;
				}
			}
			level.player_zone_found = 0;
		}
		else
		{
			level.player_zone_found = 1;
		}
		waitframe(1);
		[[level.create_spawner_list_func]](zkeys);
		/#
			debug_show_spawn_locations();
		#/
		level.active_zone_names = get_active_zone_names();
		wait(1);
	}
}

/*
	Name: debug_show_spawn_locations
	Namespace: zm_zonemgr
	Checksum: 0x65129962
	Offset: 0x41C8
	Size: 0x178
	Parameters: 0
	Flags: None
*/
function debug_show_spawn_locations()
{
	/#
		if(isdefined(level.toggle_show_spawn_locations) && level.toggle_show_spawn_locations)
		{
			host_player = util::gethostplayer();
			foreach(location in level.zm_loc_types[#"zombie_location"])
			{
				distance = distance(location.origin, host_player.origin);
				color = (0, 1, 1);
				if(distance > getdvarint(#"scr_spawner_location_distance", 0) * 12)
				{
					color = (1, 0, 0);
				}
				debugstar(location.origin, getdvarint(#"scr_spawner_location_time", 0), color);
			}
		}
	#/
}

/*
	Name: create_spawner_list
	Namespace: zm_zonemgr
	Checksum: 0x165D1764
	Offset: 0x4348
	Size: 0x500
	Parameters: 1
	Flags: Linked
*/
function create_spawner_list(zkeys)
{
	foreach(str_index, a_locs in level.zm_loc_types)
	{
		level.zm_loc_types[str_index] = [];
	}
	for(z = 0; z < zkeys.size; z++)
	{
		zone = level.zones[zkeys[z]];
		if(zone.is_enabled && zone.is_active && zone.is_spawning_allowed)
		{
			foreach(a_locs in zone.a_loc_types)
			{
				foreach(loc in a_locs)
				{
					if(isdefined(loc.is_enabled) && loc.is_enabled == 0)
					{
						continue;
					}
					if(!isdefined(loc.tokens))
					{
						loc.tokens = strtok(loc.script_noteworthy, " ");
					}
					foreach(token in loc.tokens)
					{
						switch(token)
						{
							case "custom_spawner_entry":
							case "spawn_location":
							case "riser_location":
							case "faller_location":
							{
								if(!isdefined(level.zm_loc_types[#"zombie_location"]))
								{
									level.zm_loc_types[#"zombie_location"] = [];
								}
								else if(!isarray(level.zm_loc_types[#"zombie_location"]))
								{
									level.zm_loc_types[#"zombie_location"] = array(level.zm_loc_types[#"zombie_location"]);
								}
								if(!isinarray(level.zm_loc_types[#"zombie_location"], loc))
								{
									level.zm_loc_types[#"zombie_location"][level.zm_loc_types[#"zombie_location"].size] = loc;
								}
								break;
							}
							default:
							{
								if(!isdefined(level.zm_loc_types[token]))
								{
									level.zm_loc_types[token] = [];
								}
								if(!isdefined(level.zm_loc_types[token]))
								{
									level.zm_loc_types[token] = [];
								}
								else if(!isarray(level.zm_loc_types[token]))
								{
									level.zm_loc_types[token] = array(level.zm_loc_types[token]);
								}
								if(!isinarray(level.zm_loc_types[token], loc))
								{
									level.zm_loc_types[token][level.zm_loc_types[token].size] = loc;
								}
							}
						}
					}
				}
			}
		}
	}
}

/*
	Name: get_active_zone_names
	Namespace: zm_zonemgr
	Checksum: 0x8B7140A3
	Offset: 0x4850
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function get_active_zone_names()
{
	ret_list = [];
	if(!isdefined(level.zone_keys))
	{
		return ret_list;
	}
	while(level.zone_scanning_active)
	{
		waitframe(1);
	}
	for(i = 0; i < level.zone_keys.size; i++)
	{
		if(level.zones[level.zone_keys[i]].is_active)
		{
			ret_list[ret_list.size] = level.zone_keys[i];
		}
	}
	return ret_list;
}

/*
	Name: get_active_zones_entities
	Namespace: zm_zonemgr
	Checksum: 0x26287AD7
	Offset: 0x4908
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function get_active_zones_entities()
{
	a_player_zones = getentarray("player_volume", "script_noteworthy");
	a_active_zones = [];
	for(i = 0; i < a_player_zones.size; i++)
	{
		e_zone = a_player_zones[i];
		zone = level.zones[e_zone.targetname];
		if(isdefined(zone) && (isdefined(zone.is_enabled) && zone.is_enabled))
		{
			a_active_zones[a_active_zones.size] = e_zone;
		}
	}
	return a_active_zones;
}

/*
	Name: _debug_show_zone
	Namespace: zm_zonemgr
	Checksum: 0x6CD19676
	Offset: 0x49F0
	Size: 0x110
	Parameters: 3
	Flags: None
*/
function _debug_show_zone(zone, color, alpha)
{
	if(isdefined(zone))
	{
		foreach(volume in zone.volumes)
		{
			if(!isdefined(color) || !isdefined(alpha))
			{
				showinfovolume(volume getentitynumber(), (0.2, 0.5, 0), 0.05);
				continue;
			}
			showinfovolume(volume getentitynumber(), color, alpha);
		}
	}
}

/*
	Name: _debug_zones
	Namespace: zm_zonemgr
	Checksum: 0x171AFFCB
	Offset: 0x4B08
	Size: 0x38C
	Parameters: 0
	Flags: None
*/
function _debug_zones()
{
	enabled = 0;
	while(true)
	{
		wasenabled = enabled;
		enabled = getdvarint(#"zombiemode_debug_zones", 0);
		occupied_zone = undefined;
		var_a1da7b93 = 0;
		foreach(zone in level.zones)
		{
			if(zone.name.size > var_a1da7b93)
			{
				var_a1da7b93 = zone.name.size;
			}
		}
		if(enabled)
		{
			n = 0;
			foreach(zone in level.zones)
			{
				var_28686bb1 = "";
				var_871522b2 = "";
				for(i = 0; i < var_a1da7b93 - zone.name.size; i++)
				{
					var_871522b2 = var_871522b2 + " ";
				}
				var_28686bb1 = var_28686bb1 + zone.name + var_871522b2 + " | ";
				if(zone.is_enabled)
				{
					var_28686bb1 = var_28686bb1 + "Enabled | ";
				}
				else
				{
					var_28686bb1 = var_28686bb1 + "        | ";
				}
				if(zone.is_active)
				{
					var_28686bb1 = var_28686bb1 + "Active | ";
				}
				else
				{
					var_28686bb1 = var_28686bb1 + "       | ";
				}
				if(zone.is_occupied)
				{
					var_28686bb1 = var_28686bb1 + "Occupied | ";
					occupied_zone = zone;
				}
				else
				{
					var_28686bb1 = var_28686bb1 + "         | ";
				}
				if(zone.is_spawning_allowed)
				{
					var_28686bb1 = var_28686bb1 + "SpawnOK | ";
				}
				else
				{
					var_28686bb1 = var_28686bb1 + "        | ";
				}
				/#
					var_28686bb1 = var_28686bb1 + zone.a_loc_types[#"zombie_location"].size + "" + zone.total_spawn_count + "" + zone.round_spawn_count;
					v_pos = 100 + 18 * n;
					debug2dtext((400, v_pos, 0), var_28686bb1, (1, 1, 0), undefined, (0, 0, 0), 0.75, 0.85, 2);
				#/
				n++;
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_74a20786
	Namespace: zm_zonemgr
	Checksum: 0x4006D53F
	Offset: 0x4EA0
	Size: 0x9C
	Parameters: 0
	Flags: Private
*/
private function function_74a20786()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_8a9003ae
	Namespace: zm_zonemgr
	Checksum: 0x46A1FFD6
	Offset: 0x4F48
	Size: 0x556
	Parameters: 0
	Flags: Private
*/
private function function_8a9003ae()
{
	while(true)
	{
		waitframe(1);
		enabled = getdvarint(#"hash_4d21e2fbe27b37e6", 0);
		if(!enabled || !isdefined(level.zones))
		{
			continue;
		}
		players = getplayers();
		if(!isdefined(players) || players.size == 0)
		{
			continue;
		}
		player = players[0];
		if(!isdefined(player.zone_name) || !isdefined(level.zones[player.zone_name]) || !isdefined(level.zones[player.zone_name].a_loc_types))
		{
			continue;
		}
		var_5380428d = getarraykeys(level.zones[player.zone_name].a_loc_types);
		var_d580b0ec = getdvarint(#"hash_4f0caa9b1c47489c", 0);
		var_2451ad27 = math::clamp(getdvarint(#"hash_4f0caa9b1c47489c", 0), 0, var_5380428d.size - 1);
		/#
			var_4b0b7fff = function_9e72a96(var_5380428d[var_2451ad27]);
		#/
		foreach(zone in level.zones)
		{
			if(!isdefined(zone.a_loc_types) || !isdefined(zone.a_loc_types[var_4b0b7fff]) || zone.a_loc_types[var_4b0b7fff].size == 0)
			{
				continue;
			}
			var_89bea209 = getdvarint(#"hash_5731d10a0ca1d5c", 0);
			if(!var_89bea209 && !zone.is_active)
			{
				continue;
			}
			var_8a28016b = (1, 0, 0);
			line_color = (1, 0, 0);
			var_82ceb4ef = zone.name + "\n" + var_4b0b7fff;
			if(isdefined(player.zone_name))
			{
				var_a4808c85 = getarraykeys(zone.adjacent_zones);
				if(player.zone_name == zone.name)
				{
					var_8a28016b = (0, 1, 0);
					line_color = (1, 1, 1);
				}
				else if(isinarray(var_a4808c85, hash(player.zone_name)))
				{
					var_8a28016b = (1, 1, 0);
					line_color = (1, 1, 1);
				}
			}
			if(zone.is_enabled)
			{
				var_db6c400c = (0, 0, 0);
				for(index = 0; index < zone.a_loc_types[var_4b0b7fff].size; index++)
				{
					var_db6c400c = var_db6c400c + zone.a_loc_types[var_4b0b7fff][index].origin;
				}
				var_db6c400c = var_db6c400c / zone.a_loc_types[var_4b0b7fff].size;
				/#
					print3d(var_db6c400c, var_82ceb4ef, (1, 1, 1), 1, 1);
				#/
				for(index = 0; index < zone.a_loc_types[var_4b0b7fff].size; index++)
				{
					node = zone.a_loc_types[var_4b0b7fff][index];
					var_560220f0 = node.origin;
					/#
						line(var_db6c400c, var_560220f0, line_color, 1, 0, 1);
						sphere(var_560220f0, 6, var_8a28016b, 1, 0, 10, 1);
					#/
				}
			}
		}
	}
}

/*
	Name: function_54fc7938
	Namespace: zm_zonemgr
	Checksum: 0x56B59371
	Offset: 0x54A8
	Size: 0x19C
	Parameters: 2
	Flags: Linked
*/
function function_54fc7938(player_ent, var_5d02daa5)
{
	/#
		assert(isplayer(player_ent));
	#/
	/#
		assert(isentity(var_5d02daa5) || function_7a600918(var_5d02daa5) || isstring(var_5d02daa5));
	#/
	if(isplayer(player_ent))
	{
		ent_number = player_ent getentitynumber();
		if(isentity(var_5d02daa5))
		{
			zone_name = var_5d02daa5 zm_utility::get_current_zone();
		}
		else if(function_7a600918(var_5d02daa5) || isstring(var_5d02daa5))
		{
			zone_name = var_5d02daa5;
		}
		else
		{
			return undefined;
		}
		if(isdefined(zone_name) && isdefined(level.var_5ef1a72c[ent_number]) && isdefined(level.var_5ef1a72c[ent_number][zone_name]))
		{
			return level.var_5ef1a72c[ent_number][zone_name];
		}
	}
}

/*
	Name: function_228ae7e
	Namespace: zm_zonemgr
	Checksum: 0x99139E66
	Offset: 0x5650
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function function_228ae7e()
{
	level endon(#"game_ended");
	while(true)
	{
		function_d4cf2b9b();
		wait(randomfloatrange(0.5, 1));
	}
}

/*
	Name: function_d4cf2b9b
	Namespace: zm_zonemgr
	Checksum: 0x494319C1
	Offset: 0x56B0
	Size: 0x4D4
	Parameters: 1
	Flags: Linked
*/
function function_d4cf2b9b(force_update = 0)
{
	pixbeginevent(#"hash_62bff2437ffcdbcd");
	if(getdvarint(#"hash_576f5cfc006ef831", 1))
	{
		if(force_update)
		{
			level.var_5ef1a72c = [];
		}
		players = getplayers();
		var_4550a175 = [];
		var_5ef1a72c = [];
		foreach(player in getplayers())
		{
			if(player.sessionstate !== "spectator")
			{
				var_4550a175[var_4550a175.size] = player;
			}
		}
		foreach(player in var_4550a175)
		{
			var_c6bd50df = player get_player_zone();
			if(!isdefined(var_c6bd50df))
			{
				continue;
			}
			ent_number = player getentitynumber();
			if(isdefined(level.var_5ef1a72c[ent_number]) && isdefined(level.var_5ef1a72c[ent_number][var_c6bd50df]))
			{
				if(level.var_5ef1a72c[ent_number][var_c6bd50df].cost == 0)
				{
					var_5ef1a72c[ent_number] = level.var_5ef1a72c[ent_number];
					continue;
				}
			}
			zone = level.zones[var_c6bd50df];
			var_23ca4e6e = [];
			var_1d26c41e = spawnstruct();
			var_1d26c41e.cost = 0;
			var_23ca4e6e[zone.name] = var_1d26c41e;
			var_51c813e9 = 0;
			var_14a2a339 = [];
			var_14a2a339[var_14a2a339.size] = zone.name;
			while(var_14a2a339.size > var_51c813e9)
			{
				zone = level.zones[var_14a2a339[var_51c813e9]];
				if(isdefined(zone.var_d68ef0f9) && zone.var_d68ef0f9)
				{
					var_51c813e9++;
					continue;
				}
				var_1d26c41e = var_23ca4e6e[zone.name];
				foreach(var_4a52ff35, adjacent_zone in zone.adjacent_zones)
				{
					if(isdefined(var_23ca4e6e[var_4a52ff35]) || (isdefined(level.zones[var_4a52ff35].var_d68ef0f9) && level.zones[var_4a52ff35].var_d68ef0f9))
					{
						continue;
					}
					if(adjacent_zone.is_connected)
					{
						var_658cf985 = spawnstruct();
						var_658cf985.var_ab176ce9 = zone.name;
						var_658cf985.cost = var_1d26c41e.cost + 1;
						var_23ca4e6e[var_4a52ff35] = var_658cf985;
						var_14a2a339[var_14a2a339.size] = var_4a52ff35;
					}
				}
				var_51c813e9++;
			}
			var_5ef1a72c[ent_number] = var_23ca4e6e;
		}
		level.var_5ef1a72c = var_5ef1a72c;
	}
	pixendevent();
}

/*
	Name: function_d68ef0f9
	Namespace: zm_zonemgr
	Checksum: 0xDB00EE0
	Offset: 0x5B90
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_d68ef0f9(zone_name)
{
	if(isdefined(level.zones) && isdefined(level.zones[zone_name]) && (!(isdefined(level.zones[zone_name].var_d68ef0f9) && level.zones[zone_name].var_d68ef0f9)))
	{
		level.zones[zone_name].var_d68ef0f9 = 1;
		function_d4cf2b9b(1);
	}
}

/*
	Name: function_5f39d727
	Namespace: zm_zonemgr
	Checksum: 0xDBE5CD61
	Offset: 0x5C40
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_5f39d727(zone_name)
{
	if(isdefined(level.zones) && isdefined(level.zones[zone_name]) && (isdefined(level.zones[zone_name].var_d68ef0f9) && level.zones[zone_name].var_d68ef0f9))
	{
		level.zones[zone_name].var_d68ef0f9 = undefined;
		function_d4cf2b9b(1);
	}
}

/*
	Name: function_d874116e
	Namespace: zm_zonemgr
	Checksum: 0x3433923C
	Offset: 0x5CE8
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function function_d874116e(zone_name)
{
	if(isdefined(level.zones) && isdefined(level.zones[zone_name]))
	{
		level.zones[zone_name].var_458fe8a = undefined;
	}
}

/*
	Name: function_e5eceb89
	Namespace: zm_zonemgr
	Checksum: 0xC3BF46A9
	Offset: 0x5D40
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function function_e5eceb89(zone_name)
{
	if(isdefined(level.zones) && isdefined(level.zones[zone_name]))
	{
		level.zones[zone_name].var_458fe8a = 1;
	}
}

/*
	Name: is_player_in_zone
	Namespace: zm_zonemgr
	Checksum: 0xE67A698D
	Offset: 0x5DA0
	Size: 0x122
	Parameters: 2
	Flags: Linked
*/
function is_player_in_zone(a_str_zones, var_d309b38f = 1)
{
	if(!isdefined(a_str_zones))
	{
		a_str_zones = [];
	}
	else if(!isarray(a_str_zones))
	{
		a_str_zones = array(a_str_zones);
	}
	if(var_d309b38f && (isdefined(self.var_16735873) && self.var_16735873))
	{
		return 0;
	}
	str_player_zone = self get_player_zone();
	foreach(str_zone in a_str_zones)
	{
		if(str_player_zone === str_zone)
		{
			return 1;
		}
	}
	return 0;
}

