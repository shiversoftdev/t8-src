// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_522aeb6ae906391e;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\ai\zombie_shared.gsc;
#using scripts\core_common\ai\zombie_death.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\rat.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_turned.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_placeable_mine.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_characters.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\popups_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\dev_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\bots\bot.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_devgui;

/*
	Name: __init__system__
	Namespace: zm_devgui
	Checksum: 0x3F475459
	Offset: 0x1C0
	Size: 0x4C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	/#
		system::register(#"zm_devqui", &__init__, &__main__, undefined);
	#/
}

/*
	Name: __init__
	Namespace: zm_devgui
	Checksum: 0x2D484B07
	Offset: 0x218
	Size: 0x25C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	/#
		setdvar(#"zombie_devgui", "");
		setdvar(#"scr_force_weapon", "");
		setdvar(#"scr_zombie_round", 1);
		setdvar(#"scr_zombie_dogs", 1);
		setdvar(#"scr_spawn_tesla", "");
		setdvar(#"scr_zombie_variant_type", -1);
		level.devgui_add_weapon = &devgui_add_weapon;
		level.devgui_add_ability = &devgui_add_ability;
		level thread zombie_devgui_think();
		thread zombie_weapon_devgui_think();
		thread function_3b534f9c();
		thread function_1e285ac2();
		thread devgui_zombie_healthbar();
		thread dev::devgui_test_chart_think();
		if(!isdefined(getdvar(#"scr_testscriptruntimeerror")))
		{
			setdvar(#"scr_testscriptruntimeerror", "");
		}
		level thread dev::body_customization_devgui(0);
		thread testscriptruntimeerror();
		callback::on_connect(&player_on_connect);
		add_custom_devgui_callback(&function_2f5772bf);
		thread init_debug_center_screen();
	#/
}

/*
	Name: __main__
	Namespace: zm_devgui
	Checksum: 0x86A657BD
	Offset: 0x480
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function __main__()
{
	/#
		level thread zombie_devgui_player_commands();
		level thread zombie_devgui_validation_commands();
		level thread function_358c899d();
		level thread function_5ac8947e();
		level thread zombie_draw_traversals();
		level thread function_8817dd98();
		level thread function_e9b89aac();
		level thread function_38184bf8();
		level thread function_b5d522f8();
	#/
}

/*
	Name: zombie_devgui_player_commands
	Namespace: zm_devgui
	Checksum: 0xFB13E6C1
	Offset: 0x568
	Size: 0x8
	Parameters: 0
	Flags: None
*/
function zombie_devgui_player_commands()
{
	/#
	#/
}

/*
	Name: function_358c899d
	Namespace: zm_devgui
	Checksum: 0x85A15C50
	Offset: 0x578
	Size: 0xF6
	Parameters: 0
	Flags: None
*/
function function_358c899d()
{
	/#
		test_scores = array(1, 10, 50, 100, 3500, 9999);
		i = 0;
		foreach(score in test_scores)
		{
			adddebugcommand(((((("" + score) + "") + i) + "") + score) + "");
			i++;
		}
	#/
}

/*
	Name: function_5ac8947e
	Namespace: zm_devgui
	Checksum: 0xC6876DBF
	Offset: 0x678
	Size: 0x1F8
	Parameters: 0
	Flags: None
*/
function function_5ac8947e()
{
	/#
		setdvar(#"zombie_devgui_hud", "");
		while(true)
		{
			cmd = getdvar(#"zombie_devgui_hud", "");
			if(cmd == "")
			{
				wait(0.1);
				continue;
			}
			if(strstartswith(cmd, ""))
			{
				str = strreplace(cmd, "", "");
				score = int(str);
				players = getplayers();
				foreach(player in players)
				{
					if(isplayer(player))
					{
						player luinotifyevent(#"score_event", 2, #"hash_60899927812586a1", score);
						break;
					}
				}
			}
			setdvar(#"zombie_devgui_hud", "");
		}
	#/
}

/*
	Name: player_on_connect
	Namespace: zm_devgui
	Checksum: 0x65EDAA59
	Offset: 0x878
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function player_on_connect()
{
	/#
		level flag::wait_till("");
		wait(1);
		if(isdefined(self))
		{
			zombie_devgui_player_menu(self);
		}
	#/
}

/*
	Name: zombie_devgui_player_menu_clear
	Namespace: zm_devgui
	Checksum: 0x718AD292
	Offset: 0x8C8
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function zombie_devgui_player_menu_clear(playername)
{
	/#
		rootclear = ("" + playername) + "";
		adddebugcommand(rootclear);
	#/
}

/*
	Name: function_c7dd7a17
	Namespace: zm_devgui
	Checksum: 0xEB90334B
	Offset: 0x918
	Size: 0xB4
	Parameters: 2
	Flags: None
*/
function function_c7dd7a17(archetype, var_9fde8624)
{
	/#
		if(!isdefined(var_9fde8624))
		{
			var_9fde8624 = "";
		}
		displayname = archetype;
		if(isdefined(var_9fde8624) && var_9fde8624 != "")
		{
			displayname = (displayname + "") + var_9fde8624;
		}
		adddebugcommand(((((("" + displayname) + "") + archetype) + "") + var_9fde8624) + "");
	#/
}

/*
	Name: function_2f5772bf
	Namespace: zm_devgui
	Checksum: 0x6AAB7568
	Offset: 0x9D8
	Size: 0x3DC
	Parameters: 1
	Flags: Private
*/
function private function_2f5772bf(cmd)
{
	/#
		if(strstartswith(cmd, ""))
		{
			player = level.players[0];
			direction = player getplayerangles();
			direction_vec = anglestoforward(direction);
			eye = player geteye();
			direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
			trace = bullettrace(eye, eye + direction_vec, 0, undefined);
			ai = undefined;
			ai_info = strreplace(cmd, "", "");
			ai_info = strtok(ai_info, "");
			aitype = ai_info[0];
			if(ai_info.size > 1)
			{
				var_9fde8624 = ai_info[1];
			}
			spawners = getspawnerarray();
			foreach(spawner in spawners)
			{
				if(isdefined(spawner.archetype) && spawner.archetype == aitype && (!isdefined(var_9fde8624) || (isdefined(spawner.var_9fde8624) && spawner.var_9fde8624 == var_9fde8624)))
				{
					ai_spawner = spawner;
					break;
				}
			}
			if(!isdefined(ai_spawner))
			{
				iprintln("" + aitype);
				return;
			}
			ai_spawner.script_forcespawn = 1;
			ai = zombie_utility::spawn_zombie(ai_spawner, undefined, ai_spawner);
			if(isdefined(ai))
			{
				if(ai.team != ai_spawner.team)
				{
					ai.team = ai_spawner.team;
				}
				wait(0.5);
				if(isvehicle(ai))
				{
					ai.origin = trace[#"position"];
					ai function_a57c34b7(trace[#"position"]);
				}
				else
				{
					ai forceteleport(trace[#"position"], player.angles + vectorscale((0, 1, 0), 180));
				}
			}
		}
	#/
}

/*
	Name: zombie_devgui_player_menu
	Namespace: zm_devgui
	Checksum: 0x57098601
	Offset: 0xDC0
	Size: 0x65C
	Parameters: 1
	Flags: None
*/
function zombie_devgui_player_menu(player)
{
	/#
		zombie_devgui_player_menu_clear(player.name);
		ip1 = player getentitynumber() + 1;
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
		if(isdefined(level.validcharacters))
		{
			for(i = 0; i < level.validcharacters.size; i++)
			{
				ci = level.validcharacters[i];
				var_b82273f = getcharacterfields(ci, currentsessionmode());
				adddebugcommand((((((((((((("" + player.name) + "") + ip1) + "") + ci) + "") + var_b82273f.chrname) + "") + (ci + 1) + "") + ip1) + "") + ci) + "");
			}
		}
		if(isdefined(level.var_e2c54606))
		{
			level thread [[level.var_e2c54606]](player, ip1);
		}
		self thread zombie_devgui_player_menu_clear_on_disconnect(player);
	#/
}

/*
	Name: zombie_devgui_player_menu_clear_on_disconnect
	Namespace: zm_devgui
	Checksum: 0xA9844E93
	Offset: 0x1428
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function zombie_devgui_player_menu_clear_on_disconnect(player)
{
	/#
		playername = player.name;
		player waittill(#"disconnect");
		zombie_devgui_player_menu_clear(playername);
	#/
}

/*
	Name: function_38184bf8
	Namespace: zm_devgui
	Checksum: 0x6B92D174
	Offset: 0x1488
	Size: 0x442
	Parameters: 0
	Flags: None
*/
function function_38184bf8()
{
	/#
		while(true)
		{
			var_c635168c = getdvarint(#"hash_67d19b13a4ab8b94", 0);
			if(var_c635168c >= 0 && isdefined(level.zone_paths[var_c635168c]))
			{
				zone_paths = level.zone_paths[var_c635168c];
				foreach(var_375627f0, zone_path in zone_paths)
				{
					zone = level.zones[var_375627f0];
					print_origin = undefined;
					if(isdefined(zone.nodes[0]))
					{
						print_origin = zone.nodes[0].origin;
					}
					if(!isdefined(print_origin))
					{
						print_origin = zone.volumes[0].origin;
					}
					color = (1, 0, 0);
					if(zone_path.cost < 4)
					{
						color = (0, 1, 0);
					}
					else if(zone_path.cost < 8)
					{
						color = (1, 0.5, 0);
					}
					circle(print_origin, 30, color);
					print3d(print_origin, function_9e72a96(var_375627f0), color, 1, 0.5);
					print3d(print_origin + (vectorscale((0, 0, -1), 10)), "" + zone_path.cost, color, 1, 0.5);
					if(isdefined(zone_path.to_zone))
					{
						to_zone = level.zones[zone_path.to_zone];
						if(isdefined(to_zone.nodes[0]))
						{
							var_fbe06d06 = to_zone.nodes[0].origin;
						}
						if(!isdefined(var_fbe06d06))
						{
							var_fbe06d06 = to_zone.volumes[0].origin;
						}
						line(print_origin, var_fbe06d06, color, 0, 0);
					}
				}
				foreach(zone_name, zone in level.zones)
				{
					if(!isdefined(zone_paths[zone_name]))
					{
						print_origin = undefined;
						if(isdefined(zone.nodes[0]))
						{
							print_origin = zone.nodes[0].origin;
						}
						if(!isdefined(print_origin))
						{
							print_origin = zone.volumes[0].origin;
						}
						print3d(print_origin, function_9e72a96(zone_name), (1, 0, 0), 1, 0.5);
						circle(print_origin, 30, (1, 0, 0));
						circle(print_origin, 35, (1, 0, 0));
						circle(print_origin, 40, (1, 0, 0));
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: zombie_devgui_validation_commands
	Namespace: zm_devgui
	Checksum: 0x5BE74D84
	Offset: 0x18D8
	Size: 0x220
	Parameters: 0
	Flags: None
*/
function zombie_devgui_validation_commands()
{
	/#
		setdvar(#"validation_devgui_command", "");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			cmd = getdvarstring(#"validation_devgui_command");
			if(cmd != "")
			{
				switch(cmd)
				{
					case "structs":
					{
						thread bunker_entrance_zoned();
						break;
					}
					case "spawner":
					{
						zombie_spawner_validation();
						break;
					}
					case "zone_adj":
					{
						if(!isdefined(level.toggle_zone_adjacencies_validation))
						{
							level.toggle_zone_adjacencies_validation = 1;
						}
						else
						{
							level.toggle_zone_adjacencies_validation = !level.toggle_zone_adjacencies_validation;
						}
						thread zone_adjacencies_validation();
						break;
					}
					case "zone_paths":
					{
						break;
					}
					case "pathing":
					{
						thread zombie_pathing_validation();
					}
					default:
					{
						break;
					}
				}
				setdvar(#"validation_devgui_command", "");
			}
			util::wait_network_frame();
		}
	#/
}

/*
	Name: function_edce7be0
	Namespace: zm_devgui
	Checksum: 0xA241276D
	Offset: 0x1B00
	Size: 0x1A0
	Parameters: 0
	Flags: None
*/
function function_edce7be0()
{
	/#
		spawners = getspawnerarray();
		var_26193d02 = [];
		foreach(spawner in spawners)
		{
			have_spawner = 0;
			foreach(unique_spawner in var_26193d02)
			{
				if(spawner.classname === unique_spawner.classname)
				{
					have_spawner = 1;
					break;
				}
			}
			if(have_spawner)
			{
				continue;
			}
			if(!isdefined(var_26193d02))
			{
				var_26193d02 = [];
			}
			else if(!isarray(var_26193d02))
			{
				var_26193d02 = array(var_26193d02);
			}
			if(!isinarray(var_26193d02, spawner))
			{
				var_26193d02[var_26193d02.size] = spawner;
			}
		}
		return var_26193d02;
	#/
}

/*
	Name: function_6758ede4
	Namespace: zm_devgui
	Checksum: 0xE79417EC
	Offset: 0x1CB0
	Size: 0xD0
	Parameters: 1
	Flags: None
*/
function function_6758ede4(zone)
{
	/#
		if(isdefined(zone.nodes))
		{
			foreach(node in zone.nodes)
			{
				node_region = getnoderegion(node);
				if(!isdefined(node_region))
				{
					thread drawvalidation(node.origin, undefined, undefined, undefined, node);
				}
			}
		}
	#/
}

/*
	Name: function_995340b7
	Namespace: zm_devgui
	Checksum: 0xECBEF189
	Offset: 0x1D88
	Size: 0x164
	Parameters: 2
	Flags: None
*/
function function_995340b7(zone, var_87f65b00)
{
	/#
		if(!isdefined(zone.a_loc_types[#"wait_location"]) || zone.a_loc_types[#"wait_location"].size <= 0)
		{
			if(isdefined(var_87f65b00) && var_87f65b00)
			{
				level.validation_errors_count++;
				if(isdefined(zone.nodes) && zone.nodes.size > 0)
				{
					origin = zone.nodes[0].origin + vectorscale((0, 0, 1), 32);
				}
				else
				{
					origin = zone.volumes[0].origin;
				}
				thread drawvalidation(origin, zone.name);
				println("" + zone.name);
				iprintlnbold("" + zone.name);
			}
			return false;
		}
		return true;
	#/
}

/*
	Name: function_1f0bc660
	Namespace: zm_devgui
	Checksum: 0xFBD98AA1
	Offset: 0x1EF8
	Size: 0x2EE
	Parameters: 4
	Flags: None
*/
function function_1f0bc660(zone, enemy, spawner, spawn_location)
{
	/#
		if(!isdefined(zone.a_loc_types[spawn_location]))
		{
			return enemy;
		}
		foreach(spawn_point in zone.a_loc_types[spawn_location])
		{
			if(!isdefined(enemy))
			{
				enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
			}
			spawn_point_origin = spawn_point.origin;
			if(isdefined(spawn_point.script_string) && spawn_point.script_string != "")
			{
				spawn_point_origin = enemy validate_to_board(spawn_point, spawn_point_origin);
			}
			if(!ispointonnavmesh(spawn_point_origin, enemy getpathfindingradius() + 1))
			{
				new_spawn_point_origin = getclosestpointonnavmesh(spawn_point_origin, 64, enemy getpathfindingradius() + 1);
			}
			else
			{
				new_spawn_point_origin = spawn_point_origin;
			}
			var_d37fcf94 = isdefined(spawn_point.script_noteworthy) && !issubstr(spawn_point.script_noteworthy, "");
			if(isdefined(var_d37fcf94) && var_d37fcf94 && !isdefined(new_spawn_point_origin) && (!(isdefined(spawn_point.var_f0596bbb) && spawn_point.var_f0596bbb)))
			{
				level.validation_errors_count++;
				thread drawvalidation(spawn_point_origin);
				println("" + spawn_point_origin);
				iprintlnbold("" + spawn_point_origin);
				spawn_point.var_f0596bbb = 1;
			}
			if(!isdefined(new_spawn_point_origin))
			{
				continue;
			}
			ispath = enemy validate_to_wait_point(zone, new_spawn_point_origin, spawn_point);
		}
		return enemy;
	#/
}

/*
	Name: zombie_spawner_validation
	Namespace: zm_devgui
	Checksum: 0xB327592D
	Offset: 0x21F0
	Size: 0x38E
	Parameters: 0
	Flags: None
*/
function zombie_spawner_validation()
{
	/#
		level.validation_errors_count = 0;
		if(!isdefined(level.toggle_spawner_validation))
		{
			level.toggle_spawner_validation = 1;
			zombie_devgui_open_sesame();
			spawners = function_edce7be0();
			foreach(zone in level.zones)
			{
				function_6758ede4(zone);
				function_995340b7(zone, 1);
			}
			foreach(spawner in spawners)
			{
				if(!isdefined(spawner.aitype))
				{
					continue;
				}
				archetype = getarchetypefromclassname(spawner.aitype);
				if(!isdefined(archetype))
				{
					continue;
				}
				var_f41ab3f2 = spawner ai::function_9139c839().spawnlocations;
				if(!isdefined(var_f41ab3f2))
				{
					continue;
				}
				var_4d7c27e3 = 0;
				enemy = undefined;
				foreach(zone in level.zones)
				{
					if(!function_995340b7(zone))
					{
						continue;
					}
					foreach(var_37121713 in var_f41ab3f2)
					{
						enemy = function_1f0bc660(zone, enemy, spawner, var_37121713.spawnlocation);
						if(isdefined(enemy))
						{
							var_4d7c27e3 = 1;
						}
					}
				}
				if(!var_4d7c27e3)
				{
					iprintlnbold("" + spawner.aitype);
				}
			}
			println("" + level.validation_errors_count);
			iprintlnbold("" + level.validation_errors_count);
			level.validation_errors_count = undefined;
		}
		else
		{
			level.toggle_spawner_validation = !level.toggle_spawner_validation;
		}
	#/
}

/*
	Name: validate_to_board
	Namespace: zm_devgui
	Checksum: 0xF014A65D
	Offset: 0x2588
	Size: 0x2C4
	Parameters: 2
	Flags: None
*/
function validate_to_board(spawn_point, spawn_point_origin_backup)
{
	/#
		for(j = 0; j < level.exterior_goals.size; j++)
		{
			if(isdefined(level.exterior_goals[j].script_string) && level.exterior_goals[j].script_string == spawn_point.script_string)
			{
				node = level.exterior_goals[j];
				break;
			}
		}
		if(isdefined(node))
		{
			ispath = self canpath(spawn_point.origin, node.origin);
			if(!ispath)
			{
				level.validation_errors_count++;
				thread drawvalidation(spawn_point_origin_backup, undefined, undefined, node.origin, undefined, self.archetype);
				if(isdefined(self.archetype))
				{
					println((((("" + function_9e72a96(self.archetype)) + "") + spawn_point_origin_backup) + "") + spawn_point.targetname);
					iprintlnbold((((("" + function_9e72a96(self.archetype)) + "") + spawn_point_origin_backup) + "") + spawn_point.targetname);
				}
				else
				{
					println((("" + spawn_point_origin_backup) + "") + spawn_point.targetname);
					iprintlnbold((("" + spawn_point_origin_backup) + "") + spawn_point.targetname);
				}
			}
			nodeforward = anglestoforward(node.angles);
			nodeforward = vectornormalize(nodeforward);
			spawn_point_origin = node.origin + (nodeforward * 100);
			return spawn_point_origin;
		}
		return spawn_point_origin_backup;
	#/
}

/*
	Name: validate_to_wait_point
	Namespace: zm_devgui
	Checksum: 0x29670C9F
	Offset: 0x2858
	Size: 0x2A6
	Parameters: 3
	Flags: None
*/
function validate_to_wait_point(zone, new_spawn_point_origin, spawn_point)
{
	/#
		foreach(loc in zone.a_loc_types[#"wait_location"])
		{
			if(isdefined(loc))
			{
				wait_point = loc.origin;
				if(isdefined(wait_point))
				{
					new_wait_point = getclosestpointonnavmesh(wait_point, self getpathfindingradius(), 30);
					if(isdefined(new_spawn_point_origin) && isdefined(new_wait_point))
					{
						ispath = self findpath(new_spawn_point_origin, new_wait_point);
						if(ispath)
						{
							return true;
						}
						level.validation_errors_count++;
						thread drawvalidation(new_spawn_point_origin, undefined, new_wait_point, undefined, undefined, self.archetype);
						if(isdefined(self.archetype))
						{
							println((((("" + function_9e72a96(self.archetype)) + "") + new_spawn_point_origin) + "") + spawn_point.targetname);
							iprintlnbold((((("" + function_9e72a96(self.archetype)) + "") + new_spawn_point_origin) + "") + spawn_point.targetname);
						}
						else
						{
							println((("" + new_spawn_point_origin) + "") + spawn_point.targetname);
							iprintlnbold((("" + new_spawn_point_origin) + "") + spawn_point.targetname);
						}
						return false;
					}
				}
			}
		}
		return false;
	#/
}

/*
	Name: drawvalidation
	Namespace: zm_devgui
	Checksum: 0xC5CB946E
	Offset: 0x2B08
	Size: 0x456
	Parameters: 6
	Flags: None
*/
function drawvalidation(origin, zone_name, nav_mesh_wait_point, boards_point, zone_node, archetype)
{
	/#
		if(!isdefined(zone_name))
		{
			zone_name = undefined;
		}
		if(!isdefined(nav_mesh_wait_point))
		{
			nav_mesh_wait_point = undefined;
		}
		if(!isdefined(boards_point))
		{
			boards_point = undefined;
		}
		if(!isdefined(zone_node))
		{
			zone_node = undefined;
		}
		if(!isdefined(archetype))
		{
			archetype = undefined;
		}
		if(isdefined(archetype))
		{
			archetype = function_9e72a96(archetype);
		}
		while(true)
		{
			if(isdefined(level.toggle_spawner_validation) && level.toggle_spawner_validation)
			{
				if(!isdefined(origin))
				{
					break;
				}
				if(isdefined(zone_name))
				{
					circle(origin, 32, (1, 0, 0));
					print3d(origin, "" + zone_name, (1, 1, 1), 1, 0.5);
				}
				else
				{
					if(isdefined(nav_mesh_wait_point))
					{
						circle(origin, 32, (0, 0, 1));
						if(isdefined(archetype))
						{
							print3d(origin, (archetype + "") + origin, (1, 1, 1), 1, 0.5);
						}
						else
						{
							print3d(origin, "" + origin, (1, 1, 1), 1, 0.5);
						}
						line(origin, nav_mesh_wait_point, (1, 0, 0));
						circle(nav_mesh_wait_point, 32, (1, 0, 0));
						print3d(nav_mesh_wait_point, "" + nav_mesh_wait_point, (1, 1, 1), 1, 0.5);
					}
					else
					{
						if(isdefined(boards_point))
						{
							circle(origin, 32, (0, 0, 1));
							if(isdefined(archetype))
							{
								print3d(origin, (archetype + "") + origin, (1, 1, 1), 1, 0.5);
							}
							else
							{
								print3d(origin, "" + origin, (1, 1, 1), 1, 0.5);
							}
							line(origin, boards_point, (1, 0, 0));
							circle(boards_point, 32, (1, 0, 0));
							print3d(boards_point, "" + boards_point, (1, 1, 1), 1, 0.5);
						}
						else
						{
							if(isdefined(zone_node))
							{
								circle(origin, 32, (1, 0, 0));
								print3d(origin, ((("" + (isdefined(zone_node.targetname) ? zone_node.targetname : "")) + "") + origin) + "", (1, 1, 1), 1, 0.5);
							}
							else
							{
								circle(origin, 32, (0, 0, 1));
								print3d(origin, "" + origin, (1, 1, 1), 1, 0.5);
							}
						}
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: zone_adjacencies_validation
	Namespace: zm_devgui
	Checksum: 0xA8708549
	Offset: 0x2F68
	Size: 0x2D2
	Parameters: 0
	Flags: None
*/
function zone_adjacencies_validation()
{
	/#
		zombie_devgui_open_sesame();
		while(true)
		{
			if(isdefined(level.toggle_zone_adjacencies_validation) && level.toggle_zone_adjacencies_validation)
			{
				if(!isdefined(getplayers()[0].zone_name))
				{
					waitframe(1);
					continue;
				}
				str_zone = getplayers()[0].zone_name;
				keys = getarraykeys(level.zones);
				offset = 0;
				foreach(key in keys)
				{
					if(key === str_zone)
					{
						draw_zone_adjacencies_validation(level.zones[key], 2, key);
						continue;
					}
					if(isdefined(level.zones[str_zone].adjacent_zones[key]))
					{
						if(level.zones[str_zone].adjacent_zones[key].is_connected)
						{
							offset = offset + 10;
							draw_zone_adjacencies_validation(level.zones[key], 1, key, level.zones[str_zone], offset);
						}
						else
						{
							draw_zone_adjacencies_validation(level.zones[key], 0, key);
						}
						continue;
					}
					draw_zone_adjacencies_validation(level.zones[key], 0, key);
				}
				foreach(zone in level.zones)
				{
					function_f4669d7b(level.zones, zone);
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: draw_zone_adjacencies_validation
	Namespace: zm_devgui
	Checksum: 0xD0444B7D
	Offset: 0x3248
	Size: 0x294
	Parameters: 5
	Flags: None
*/
function draw_zone_adjacencies_validation(zone, status, name, current_zone, offset)
{
	/#
		if(!isdefined(current_zone))
		{
			current_zone = undefined;
		}
		if(!isdefined(offset))
		{
			offset = 0;
		}
		if(!isdefined(zone.volumes[0]) && !isdefined(zone.nodes[0]))
		{
			return;
		}
		if(isdefined(zone.nodes[0]))
		{
			print_origin = zone.nodes[0].origin;
		}
		if(!isdefined(print_origin))
		{
			print_origin = zone.volumes[0].origin;
		}
		if(status == 2)
		{
			circle(print_origin, 30, (0, 1, 0));
			print3d(print_origin, function_9e72a96(name), (0, 1, 0), 1, 0.5);
		}
		else
		{
			if(status == 1)
			{
				circle(print_origin, 30, (0, 0, 1));
				print3d(print_origin, function_9e72a96(name), (0, 0, 1), 1, 0.5);
				if(isdefined(current_zone.nodes[0]))
				{
					print_origin = current_zone.nodes[0].origin;
				}
				if(!isdefined(print_origin))
				{
					print_origin = current_zone.volumes[0].origin;
				}
				print3d(print_origin + (0, 20, offset * -1), function_9e72a96(name), (0, 0, 1), 1, 0.5);
			}
			else
			{
				circle(print_origin, 30, (1, 0, 0));
				print3d(print_origin, function_9e72a96(name), (1, 0, 0), 1, 0.5);
			}
		}
	#/
}

/*
	Name: function_f4669d7b
	Namespace: zm_devgui
	Checksum: 0x89DA69EA
	Offset: 0x34E8
	Size: 0x1E8
	Parameters: 2
	Flags: None
*/
function function_f4669d7b(zones, zone)
{
	/#
		if(!isdefined(zone.volumes[0]) && !isdefined(zone.nodes[0]))
		{
			return;
		}
		if(isdefined(zone.nodes[0]))
		{
			origin = zone.nodes[0].origin;
		}
		if(!isdefined(origin))
		{
			origin = zone.volumes[0].origin;
		}
		foreach(var_4c973d00, adjacent in zone.adjacent_zones)
		{
			adjacent_zone = zones[var_4c973d00];
			if(adjacent_zone.nodes.size && isdefined(adjacent_zone.nodes[0].origin))
			{
				var_16c82636 = adjacent_zone.nodes[0].origin;
			}
			if(!isdefined(var_16c82636))
			{
				var_16c82636 = adjacent_zone.volumes[0].origin;
			}
			if(adjacent.is_connected)
			{
				line(origin, var_16c82636, (0, 1, 0), 0, 0);
				continue;
			}
			line(origin, var_16c82636, (1, 0, 0), 0, 0);
		}
	#/
}

/*
	Name: zombie_pathing_validation
	Namespace: zm_devgui
	Checksum: 0x48C306CF
	Offset: 0x36D8
	Size: 0x142
	Parameters: 0
	Flags: None
*/
function zombie_pathing_validation()
{
	/#
		if(!isdefined(level.zombie_spawners[0]))
		{
			return;
		}
		if(!isdefined(level.zombie_pathing_validation))
		{
			level.zombie_pathing_validation = 1;
		}
		zombie_devgui_open_sesame();
		setdvar(#"zombie_default_max", 0);
		zombie_devgui_goto_round(20);
		wait(2);
		spawner = level.zombie_spawners[0];
		slums_station = (808, -1856, 544);
		enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname);
		wait(1);
		while(isdefined(enemy) && enemy.completed_emerging_into_playable_area !== 1)
		{
			waitframe(1);
		}
		if(isdefined(enemy))
		{
			enemy forceteleport(slums_station);
			enemy.b_ignore_cleanup = 1;
		}
	#/
}

/*
	Name: function_bcc8843e
	Namespace: zm_devgui
	Checksum: 0xBF932F6A
	Offset: 0x3828
	Size: 0xF4
	Parameters: 3
	Flags: None
*/
function function_bcc8843e(weapon_name, up, root)
{
	/#
		util::waittill_can_add_debug_command();
		rootslash = "";
		if(isdefined(root) && root.size)
		{
			rootslash = root + "";
		}
		uppath = "" + up;
		if(up.size < 1)
		{
			uppath = "";
		}
		cmd = ((((("" + rootslash) + weapon_name) + uppath) + "") + weapon_name) + "";
		adddebugcommand(cmd);
	#/
}

/*
	Name: devgui_add_weapon_entry
	Namespace: zm_devgui
	Checksum: 0xEA51778D
	Offset: 0x3928
	Size: 0x264
	Parameters: 3
	Flags: None
*/
function devgui_add_weapon_entry(weapon, root, n_order)
{
	/#
		weapon_name = function_a16a090d(weapon);
		if(isdefined(root) && root.size)
		{
			adddebugcommand(((((((("" + root) + "") + n_order) + "") + weapon_name) + "") + weapon_name) + "");
		}
		else
		{
			if(getdvarint(#"zm_debug_attachments", 0))
			{
				var_876795bf = weapon.supportedattachments;
				weapon_root = ("" + weapon_name) + "";
				adddebugcommand((((weapon_root + weapon_name) + "") + weapon_name) + "");
				foreach(var_96bc131f in var_876795bf)
				{
					if(var_96bc131f != "" && var_96bc131f != "")
					{
						util::waittill_can_add_debug_command();
						var_29c3a74d = (weapon_name + "") + var_96bc131f;
						adddebugcommand((((weapon_root + var_29c3a74d) + "") + var_29c3a74d) + "");
					}
				}
			}
			else
			{
				adddebugcommand(((("" + weapon_name) + "") + weapon_name) + "");
			}
		}
	#/
}

/*
	Name: devgui_add_weapon
	Namespace: zm_devgui
	Checksum: 0x598D8395
	Offset: 0x3B98
	Size: 0x17C
	Parameters: 7
	Flags: None
*/
function devgui_add_weapon(weapon, upgrade, in_box, cost, weaponvo, weaponvoresp, ammo_cost)
{
	/#
		level endon(#"game_ended");
		if(in_box)
		{
			level thread function_bcc8843e(function_a16a090d(weapon), "", "");
		}
		util::waittill_can_add_debug_command();
		if(zm_loadout::is_offhand_weapon(weapon) && !zm_loadout::is_melee_weapon(weapon))
		{
			devgui_add_weapon_entry(weapon, "", 2);
		}
		else
		{
			if(zm_loadout::is_melee_weapon(weapon))
			{
				devgui_add_weapon_entry(weapon, "", 3);
			}
			else
			{
				if(zm_weapons::is_wonder_weapon(weapon))
				{
					devgui_add_weapon_entry(weapon, "", 5);
				}
				else
				{
					devgui_add_weapon_entry(weapon);
				}
			}
		}
	#/
}

/*
	Name: function_3b534f9c
	Namespace: zm_devgui
	Checksum: 0x32247B74
	Offset: 0x3D20
	Size: 0x370
	Parameters: 0
	Flags: None
*/
function function_3b534f9c()
{
	/#
		level.zombie_devgui_gun = getdvarstring(#"hash_1c9225f4f6e82068");
		for(;;)
		{
			wait(0.1);
			cmd = getdvarstring(#"hash_1c9225f4f6e82068");
			if(isdefined(cmd) && cmd.size > 0)
			{
				level.zombie_devgui_gun = cmd;
				players = getplayers();
				if(players.size >= 1)
				{
					players[0] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
				}
				setdvar(#"hash_1c9225f4f6e82068", "");
			}
			wait(0.1);
			cmd = getdvarstring(#"hash_1c9228f4f6e82581");
			if(isdefined(cmd) && cmd.size > 0)
			{
				level.zombie_devgui_gun = cmd;
				players = getplayers();
				if(players.size >= 2)
				{
					players[1] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
				}
				setdvar(#"hash_1c9228f4f6e82581", "");
			}
			wait(0.1);
			cmd = getdvarstring(#"hash_1c9227f4f6e823ce");
			if(isdefined(cmd) && cmd.size > 0)
			{
				level.zombie_devgui_gun = cmd;
				players = getplayers();
				if(players.size >= 3)
				{
					players[2] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
				}
				setdvar(#"hash_1c9227f4f6e823ce", "");
			}
			wait(0.1);
			cmd = getdvarstring(#"hash_1c922af4f6e828e7");
			if(isdefined(cmd) && cmd.size > 0)
			{
				level.zombie_devgui_gun = cmd;
				players = getplayers();
				if(players.size >= 4)
				{
					players[3] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
				}
				setdvar(#"hash_1c922af4f6e828e7", "");
			}
		}
	#/
}

/*
	Name: zombie_weapon_devgui_think
	Namespace: zm_devgui
	Checksum: 0x98C2F4AD
	Offset: 0x4098
	Size: 0x100
	Parameters: 0
	Flags: None
*/
function zombie_weapon_devgui_think()
{
	/#
		level.zombie_devgui_gun = getdvarstring(#"zombie_devgui_gun");
		for(;;)
		{
			wait(0.25);
			cmd = getdvarstring(#"zombie_devgui_gun");
			if(isdefined(cmd) && cmd.size > 0)
			{
				level.zombie_devgui_gun = cmd;
				array::thread_all(getplayers(), &zombie_devgui_weapon_give, level.zombie_devgui_gun);
				setdvar(#"zombie_devgui_gun", "");
			}
		}
	#/
}

/*
	Name: zombie_devgui_weapon_give
	Namespace: zm_devgui
	Checksum: 0x4EF46C56
	Offset: 0x41A0
	Size: 0x22C
	Parameters: 1
	Flags: None
*/
function zombie_devgui_weapon_give(weapon_name)
{
	/#
		split = strtok(function_9e72a96(weapon_name), "");
		switch(split.size)
		{
			case 1:
			default:
			{
				weapon = getweapon(split[0]);
				break;
			}
			case 2:
			{
				weapon = getweapon(split[0], split[1]);
				break;
			}
			case 3:
			{
				weapon = getweapon(split[0], split[1], split[2]);
				break;
			}
			case 4:
			{
				weapon = getweapon(split[0], split[1], split[2], split[3]);
				break;
			}
			case 5:
			{
				weapon = getweapon(split[0], split[1], split[2], split[3], split[4]);
				break;
			}
		}
		if(zm_loadout::is_melee_weapon(weapon) && isdefined(zm_melee_weapon::find_melee_weapon(weapon)))
		{
			self zm_melee_weapon::award_melee_weapon(weapon_name);
		}
		else
		{
			self function_2d4d7fd9(weapon);
		}
	#/
}

/*
	Name: function_2d4d7fd9
	Namespace: zm_devgui
	Checksum: 0xFBBE4370
	Offset: 0x43D8
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_2d4d7fd9(weapon)
{
	/#
		if(self hasweapon(weapon, 1))
		{
			self takeweapon(weapon, 1);
		}
		self thread function_bb54e671(weapon);
		self zm_weapons::weapon_give(weapon);
	#/
}

/*
	Name: function_bb54e671
	Namespace: zm_devgui
	Checksum: 0x4ACF7498
	Offset: 0x4460
	Size: 0x174
	Parameters: 1
	Flags: None
*/
function function_bb54e671(weapon)
{
	/#
		self notify(#"hash_7c6363440c125d8b");
		self endon(#"disconnect", #"hash_7c6363440c125d8b");
		if(!isdefined(self.var_8d5839f4))
		{
			self.var_8d5839f4 = [];
		}
		else if(!isarray(self.var_8d5839f4))
		{
			self.var_8d5839f4 = array(self.var_8d5839f4);
		}
		self.var_8d5839f4[self.var_8d5839f4.size] = weapon;
		while(true)
		{
			self waittill(#"weapon_change_complete");
			foreach(weapon in arraycopy(self.var_8d5839f4))
			{
				if(!self hasweapon(weapon))
				{
					arrayremovevalue(self.var_8d5839f4, weapon);
				}
			}
		}
	#/
}

/*
	Name: devgui_add_ability
	Namespace: zm_devgui
	Checksum: 0xEE4B3732
	Offset: 0x45E0
	Size: 0x164
	Parameters: 5
	Flags: None
*/
function devgui_add_ability(name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved)
{
	/#
		online_game = sessionmodeisonlinegame();
		if(!online_game)
		{
			return;
		}
		if(!(isdefined(level.devgui_watch_abilities) && level.devgui_watch_abilities))
		{
			cmd = "";
			adddebugcommand(cmd);
			cmd = "";
			adddebugcommand(cmd);
			level thread zombie_ability_devgui_think();
			level.devgui_watch_abilities = 1;
		}
		cmd = ((("" + name) + "") + name) + "";
		adddebugcommand(cmd);
		cmd = ((("" + name) + "") + name) + "";
		adddebugcommand(cmd);
	#/
}

/*
	Name: zombie_devgui_ability_give
	Namespace: zm_devgui
	Checksum: 0xFDA336DC
	Offset: 0x4750
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function zombie_devgui_ability_give(name)
{
	/#
	#/
}

/*
	Name: zombie_devgui_ability_take
	Namespace: zm_devgui
	Checksum: 0xC4E84079
	Offset: 0x4768
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function zombie_devgui_ability_take(name)
{
	/#
	#/
}

/*
	Name: zombie_ability_devgui_think
	Namespace: zm_devgui
	Checksum: 0x608BEB64
	Offset: 0x4780
	Size: 0x208
	Parameters: 0
	Flags: None
*/
function zombie_ability_devgui_think()
{
	/#
		level.zombie_devgui_give_ability = getdvarstring(#"zombie_devgui_give_ability");
		level.zombie_devgui_take_ability = getdvarstring(#"zombie_devgui_take_ability");
		for(;;)
		{
			wait(0.25);
			cmd = getdvarstring(#"zombie_devgui_give_ability");
			if(!isdefined(level.zombie_devgui_give_ability) || level.zombie_devgui_give_ability != cmd)
			{
				if(cmd == "")
				{
					level flag::set("");
				}
				else
				{
					if(cmd == "")
					{
						level flag::clear("");
					}
					else
					{
						level.zombie_devgui_give_ability = cmd;
						array::thread_all(getplayers(), &zombie_devgui_ability_give, level.zombie_devgui_give_ability);
					}
				}
			}
			wait(0.25);
			cmd = getdvarstring(#"zombie_devgui_take_ability");
			if(!isdefined(level.zombie_devgui_take_ability) || level.zombie_devgui_take_ability != cmd)
			{
				level.zombie_devgui_take_ability = cmd;
				array::thread_all(getplayers(), &zombie_devgui_ability_take, level.zombie_devgui_take_ability);
			}
		}
	#/
}

/*
	Name: zombie_healthbar
	Namespace: zm_devgui
	Checksum: 0x28AEBE3A
	Offset: 0x4990
	Size: 0xF4
	Parameters: 2
	Flags: None
*/
function zombie_healthbar(pos, dsquared)
{
	/#
		if(distancesquared(pos, self.origin) > dsquared)
		{
			return;
		}
		rate = 1;
		if(isdefined(self.maxhealth))
		{
			rate = self.health / self.maxhealth;
		}
		color = (1 - rate, rate, 0);
		text = "" + int(self.health);
		print3d(self.origin + (0, 0, 0), text, color, 1, 0.5, 1);
	#/
}

/*
	Name: devgui_zombie_healthbar
	Namespace: zm_devgui
	Checksum: 0xC1213246
	Offset: 0x4A90
	Size: 0x132
	Parameters: 0
	Flags: None
*/
function devgui_zombie_healthbar()
{
	/#
		while(true)
		{
			if(getdvarint(#"scr_zombie_healthbars", 0) == 1)
			{
				e_player = getplayers()[0];
				if(isalive(e_player))
				{
					a_ai_zombies = getaispeciesarray("", "");
					foreach(ai_zombie in a_ai_zombies)
					{
						ai_zombie zombie_healthbar(e_player.origin, 360000);
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: zombie_devgui_watch_input
	Namespace: zm_devgui
	Checksum: 0xCA5F9B83
	Offset: 0x4BD0
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function zombie_devgui_watch_input()
{
	/#
		level flag::wait_till("");
		wait(1);
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			players[i] thread watch_debug_input();
		}
	#/
}

/*
	Name: damage_player
	Namespace: zm_devgui
	Checksum: 0x8AFE681C
	Offset: 0x4C60
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function damage_player()
{
	/#
		self val::set(#"damage_player", "", 1);
		self dodamage(self.health / 2, self.origin);
	#/
}

/*
	Name: kill_player
	Namespace: zm_devgui
	Checksum: 0xDC1D6321
	Offset: 0x4CC8
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function kill_player()
{
	/#
		self val::set(#"kill_player", "", 1);
		death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
		self dodamage(self.health + 666, self.origin + death_from);
	#/
}

/*
	Name: force_drink
	Namespace: zm_devgui
	Checksum: 0x4B430987
	Offset: 0x4D88
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function force_drink()
{
	/#
		wait(0.01);
		build_weapon = getweapon(#"zombie_builder");
		self thread gestures::function_f3e2696f(self, build_weapon, undefined, 2.5, undefined, undefined, undefined);
	#/
}

/*
	Name: zombie_devgui_dpad_none
	Namespace: zm_devgui
	Checksum: 0x17E467C2
	Offset: 0x4E00
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function zombie_devgui_dpad_none()
{
	/#
		self thread watch_debug_input();
	#/
}

/*
	Name: zombie_devgui_dpad_death
	Namespace: zm_devgui
	Checksum: 0x3672DD81
	Offset: 0x4E28
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function zombie_devgui_dpad_death()
{
	/#
		self thread watch_debug_input(&kill_player);
	#/
}

/*
	Name: zombie_devgui_dpad_damage
	Namespace: zm_devgui
	Checksum: 0x4D5B8C8B
	Offset: 0x4E60
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function zombie_devgui_dpad_damage()
{
	/#
		self thread watch_debug_input(&damage_player);
	#/
}

/*
	Name: zombie_devgui_dpad_changeweapon
	Namespace: zm_devgui
	Checksum: 0x53718CC9
	Offset: 0x4E98
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function zombie_devgui_dpad_changeweapon()
{
	/#
		self thread watch_debug_input(&force_drink);
	#/
}

/*
	Name: watch_debug_input
	Namespace: zm_devgui
	Checksum: 0x614D3496
	Offset: 0x4ED0
	Size: 0xC2
	Parameters: 1
	Flags: None
*/
function watch_debug_input(callback)
{
	/#
		self endon(#"disconnect");
		self notify(#"watch_debug_input");
		self endon(#"watch_debug_input");
		level.devgui_dpad_watch = 0;
		if(isdefined(callback))
		{
			level.devgui_dpad_watch = 1;
			for(;;)
			{
				if(self actionslottwobuttonpressed())
				{
					self thread [[callback]]();
					while(self actionslottwobuttonpressed())
					{
						waitframe(1);
					}
				}
				waitframe(1);
			}
		}
	#/
}

/*
	Name: zombie_devgui_think
	Namespace: zm_devgui
	Checksum: 0x62987C7E
	Offset: 0x4FA0
	Size: 0x2CA8
	Parameters: 0
	Flags: None
*/
function zombie_devgui_think()
{
	/#
		level notify(#"zombie_devgui_think");
		level endon(#"zombie_devgui_think");
		for(;;)
		{
			cmd = getdvarstring(#"zombie_devgui");
			switch(cmd)
			{
				case "money":
				{
					players = getplayers();
					array::thread_all(players, &zombie_devgui_give_money);
					break;
				}
				case "player1_money":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zombie_devgui_give_money();
					}
					break;
				}
				case "player2_money":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zombie_devgui_give_money();
					}
					break;
				}
				case "player3_money":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zombie_devgui_give_money();
					}
					break;
				}
				case "player4_money":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zombie_devgui_give_money();
					}
					break;
				}
				case "moneydown":
				{
					players = getplayers();
					array::thread_all(players, &zombie_devgui_take_money);
					break;
				}
				case "player1_moneydown":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zombie_devgui_take_money();
					}
					break;
				}
				case "player2_moneydown":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zombie_devgui_take_money();
					}
					break;
				}
				case "player3_moneydown":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zombie_devgui_take_money();
					}
					break;
				}
				case "player4_moneydown":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zombie_devgui_take_money();
					}
					break;
				}
				case "ammodown":
				{
					players = getplayers();
					array::thread_all(players, &function_dc7312be);
					break;
				}
				case "hash_428dbd0a89fc5d32":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread function_dc7312be();
					}
					break;
				}
				case "hash_119220b211e16ba9":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread function_dc7312be();
					}
					break;
				}
				case "hash_6cdf097974c7bcd0":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread function_dc7312be();
					}
					break;
				}
				case "hash_5e281497ef267e37":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread function_dc7312be();
					}
					break;
				}
				case "hash_59a96f9816430398":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zombie_devgui_give_xp(1000);
					}
					break;
				}
				case "hash_423b4f1fbe6391dd":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zombie_devgui_give_xp(1000);
					}
					break;
				}
				case "hash_50580bf75ed9e65e":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zombie_devgui_give_xp(1000);
					}
					break;
				}
				case "hash_4e18caaf131ec443":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zombie_devgui_give_xp(1000);
					}
					break;
				}
				case "hash_1dec476dd3df3678":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zombie_devgui_give_xp(10000);
					}
					break;
				}
				case "hash_6e595ff08330f5b7":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zombie_devgui_give_xp(10000);
					}
					break;
				}
				case "hash_5f82c3562c428cea":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zombie_devgui_give_xp(10000);
					}
					break;
				}
				case "hash_52e4da7d7d47cf69":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zombie_devgui_give_xp(10000);
					}
					break;
				}
				case "health":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_health);
					break;
				}
				case "player1_health":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zombie_devgui_give_health();
					}
					break;
				}
				case "player2_health":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zombie_devgui_give_health();
					}
					break;
				}
				case "player3_health":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zombie_devgui_give_health();
					}
					break;
				}
				case "player4_health":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zombie_devgui_give_health();
					}
					break;
				}
				case "minhealth":
				{
					array::thread_all(getplayers(), &zombie_devgui_low_health);
					break;
				}
				case "player1_minhealth":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zombie_devgui_low_health();
					}
					break;
				}
				case "player2_minhealth":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zombie_devgui_low_health();
					}
					break;
				}
				case "player3_minhealth":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zombie_devgui_low_health();
					}
					break;
				}
				case "player4_minhealth":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zombie_devgui_low_health();
					}
					break;
				}
				case "ammo":
				{
					array::thread_all(getplayers(), &zombie_devgui_toggle_ammo);
					break;
				}
				case "ignore":
				{
					array::thread_all(getplayers(), &zombie_devgui_toggle_ignore);
					break;
				}
				case "player1_ignore":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zombie_devgui_toggle_ignore();
					}
					break;
				}
				case "player2_ignore":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zombie_devgui_toggle_ignore();
					}
					break;
				}
				case "player3_ignore":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zombie_devgui_toggle_ignore();
					}
					break;
				}
				case "player4_ignore":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zombie_devgui_toggle_ignore();
					}
					break;
				}
				case "invul_on":
				{
					zombie_devgui_invulnerable(undefined, 1);
					break;
				}
				case "invul_off":
				{
					zombie_devgui_invulnerable(undefined, 0);
					break;
				}
				case "player1_invul_on":
				{
					zombie_devgui_invulnerable(0, 1);
					break;
				}
				case "player1_invul_off":
				{
					zombie_devgui_invulnerable(0, 0);
					break;
				}
				case "player2_invul_on":
				{
					zombie_devgui_invulnerable(1, 1);
					break;
				}
				case "player2_invul_off":
				{
					zombie_devgui_invulnerable(1, 0);
					break;
				}
				case "player3_invul_on":
				{
					zombie_devgui_invulnerable(2, 1);
					break;
				}
				case "player3_invul_off":
				{
					zombie_devgui_invulnerable(2, 0);
					break;
				}
				case "player4_invul_on":
				{
					zombie_devgui_invulnerable(3, 1);
					break;
				}
				case "player4_invul_off":
				{
					zombie_devgui_invulnerable(3, 0);
					break;
				}
				case "revive_all":
				{
					array::thread_all(getplayers(), &zombie_devgui_revive);
					break;
				}
				case "player1_revive":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zombie_devgui_revive();
					}
					break;
				}
				case "player2_revive":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zombie_devgui_revive();
					}
					break;
				}
				case "player3_revive":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zombie_devgui_revive();
					}
					break;
				}
				case "player4_revive":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zombie_devgui_revive();
					}
					break;
				}
				case "player1_kill":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zombie_devgui_kill();
					}
					break;
				}
				case "player2_kill":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zombie_devgui_kill();
					}
					break;
				}
				case "player3_kill":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zombie_devgui_kill();
					}
					break;
				}
				case "player4_kill":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zombie_devgui_kill();
					}
					break;
				}
				case "hash_7f4d70c7ded8e94a":
				{
					if(zm_utility::get_story() === 2)
					{
						array::random(getplayers()) giveweapon(getweapon(#"homunculus"));
					}
					array::thread_all(getplayers(), &function_8d799ebd);
					break;
				}
				case "hash_505efa1825e2cb99":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread function_8d799ebd();
					}
					break;
				}
				case "hash_15233852e3dc3500":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread function_8d799ebd();
					}
					break;
				}
				case "hash_5cb5edc4858d92f7":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread function_8d799ebd();
					}
					break;
				}
				case "hash_6d57ff86c541a5fe":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread function_8d799ebd();
					}
					break;
				}
				case "hash_2c320318aed843b2":
				{
					array::thread_all(getplayers(), &zm_laststand::function_3d685b5f, 100);
					break;
				}
				case "hash_72783b08840a3ab7":
				{
					players = getplayers();
					if(players.size >= 1)
					{
						players[0] thread zm_laststand::function_3d685b5f(100);
					}
					break;
				}
				case "hash_447712ef48d6ea0":
				{
					players = getplayers();
					if(players.size >= 2)
					{
						players[1] thread zm_laststand::function_3d685b5f(100);
					}
					break;
				}
				case "hash_2a15f60adbba0cf5":
				{
					players = getplayers();
					if(players.size >= 3)
					{
						players[2] thread zm_laststand::function_3d685b5f(100);
					}
					break;
				}
				case "hash_430eb4715f49a5fe":
				{
					players = getplayers();
					if(players.size >= 4)
					{
						players[3] thread zm_laststand::function_3d685b5f(100);
					}
					break;
				}
				case "specialty_quickrevive":
				{
					level.solo_lives_given = 0;
				}
				case "specialty_deadshot":
				case "specialty_additionalprimaryweapon":
				case "specialty_vultureaid":
				case "specialty_showonradar":
				case "specialty_doubletap2":
				case "specialty_electriccherry":
				case "specialty_phdflopper":
				case "specialty_staminup":
				case "specialty_fastmeleerecovery":
				case "specialty_widowswine":
				{
					zombie_devgui_give_perk(cmd);
					break;
				}
				case "remove_perks":
				{
					zombie_devgui_take_perks(cmd);
					break;
				}
				case "lose_points_team":
				case "hero_weapon_power":
				case "carpenter":
				case "free_perk":
				case "extra_lives":
				case "tesla":
				case "pack_a_punch":
				case "bonus_points_player":
				case "lose_perk":
				case "meat_stink":
				case "full_ammo":
				case "empty_clip":
				case "bonus_points_team":
				case "random_weapon":
				case "nuke":
				case "fire_sale":
				case "insta_kill":
				case "double_points":
				case "minigun":
				case "zmarcade_key":
				case "bonfire_sale":
				{
					zombie_devgui_give_powerup(cmd, 1);
					break;
				}
				case "next_extra_lives":
				case "next_bonus_points_player":
				case "next_insta_kill":
				case "next_lose_perk":
				case "next_lose_points_team":
				case "next_nuke":
				case "next_bonfire_sale":
				case "next_pack_a_punch":
				case "next_meat_stink":
				case "next_bonus_points_team":
				case "next_free_perk":
				case "next_minigun":
				case "next_double_points":
				case "next_empty_clip":
				case "next_tesla":
				case "next_full_ammo":
				case "next_fire_sale":
				case "next_carpenter":
				case "next_zmarcade_key":
				case "next_random_weapon":
				case "next_hero_weapon_power":
				{
					zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
					break;
				}
				case "round":
				{
					zombie_devgui_goto_round(getdvarint(#"scr_zombie_round", 0));
					break;
				}
				case "round_next":
				{
					zombie_devgui_goto_round(level.round_number + 1);
					break;
				}
				case "round_prev":
				{
					zombie_devgui_goto_round(level.round_number - 1);
					break;
				}
				case "chest_warp":
				{
					array::thread_all(getplayers(), &function_4bb7eb36);
					break;
				}
				case "pap_warp":
				{
					array::thread_all(getplayers(), &function_84f0a909);
					break;
				}
				case "chest_move":
				{
					if(isdefined(level.chest_accessed))
					{
						level notify(#"devgui_chest_end_monitor");
						level.var_401aaa92 = 1;
					}
					break;
				}
				case "chest_never_move":
				{
					if(isdefined(level.chest_accessed))
					{
						level.var_401aaa92 = 0;
						level thread zombie_devgui_chest_never_move();
					}
					break;
				}
				case "chest":
				{
					break;
				}
				case "give_claymores":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(#"claymore"));
					break;
				}
				case "give_bouncingbetties":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(#"bouncingbetty"));
					break;
				}
				case "give_frags":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_frags);
					break;
				}
				case "give_sticky":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_sticky);
					break;
				}
				case "give_monkey":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_monkey);
					break;
				}
				case "give_bhb":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_bhb);
					break;
				}
				case "give_quantum":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_qed);
					break;
				}
				case "give_dolls":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_dolls);
					break;
				}
				case "give_emp_bomb":
				{
					array::thread_all(getplayers(), &zombie_devgui_give_emp_bomb);
					break;
				}
				case "dog_round":
				{
					zombie_devgui_dog_round(getdvarint(#"scr_zombie_dogs", 0));
					break;
				}
				case "dog_round_skip":
				{
					zombie_devgui_dog_round_skip();
					break;
				}
				case "print_variables":
				{
					zombie_devgui_dump_zombie_vars();
					break;
				}
				case "pack_current_weapon":
				{
					zombie_devgui_pack_current_weapon();
					break;
				}
				case "hash_f9c9f7dd75a4047":
				{
					function_8c9f2dea();
					break;
				}
				case "hash_5605531ad17b5408":
				{
					function_b7ef4b8();
					break;
				}
				case "hash_2dde14d5c2960aea":
				{
					function_9b4d61fa();
					break;
				}
				case "hash_465e01a5b9f4f28e":
				{
					function_cdc3d061();
					break;
				}
				case "hash_26abd478093a24d0":
				{
					zombie_devgui_repack_current_weapon();
					break;
				}
				case "unpack_current_weapon":
				{
					zombie_devgui_unpack_current_weapon();
					break;
				}
				case "hash_3c2b067b1510118c":
				{
					function_c8949116();
					break;
				}
				case "hash_769c6d03952dd107":
				{
					function_9d21f44b();
					break;
				}
				case "hash_68e9afed4aa9c0dd":
				{
					function_e2a97bab();
					break;
				}
				case "hash_3f4888627ed06269":
				{
					function_1a560cfc();
					break;
				}
				case "hash_73ecd8731ecdf6b0":
				{
					function_c8ee84ba();
					break;
				}
				case "hash_49563ad3930e97e4":
				{
					function_c83c6fa();
					break;
				}
				case "reopt_current_weapon":
				{
					zombie_devgui_reopt_current_weapon();
					break;
				}
				case "weapon_take_all_fallback":
				{
					zombie_devgui_take_weapons(1);
					break;
				}
				case "weapon_take_all":
				{
					zombie_devgui_take_weapons(0);
					break;
				}
				case "weapon_take_current":
				{
					zombie_devgui_take_weapon();
					break;
				}
				case "power_on":
				{
					level flag::set("");
					level clientfield::set("", 1);
					power_trigs = getentarray("", "");
					foreach(trig in power_trigs)
					{
						if(isdefined(trig.script_int))
						{
							level flag::set("" + trig.script_int);
							level clientfield::set("", trig.script_int + 1);
						}
					}
					break;
				}
				case "power_off":
				{
					level flag::clear("");
					level clientfield::set("", 0);
					power_trigs = getentarray("", "");
					foreach(trig in power_trigs)
					{
						if(isdefined(trig.script_int))
						{
							level flag::clear("" + trig.script_int);
							level clientfield::set("", trig.script_int);
						}
					}
					break;
				}
				case "zombie_dpad_none":
				{
					array::thread_all(getplayers(), &zombie_devgui_dpad_none);
					break;
				}
				case "zombie_dpad_damage":
				{
					array::thread_all(getplayers(), &zombie_devgui_dpad_damage);
					break;
				}
				case "zombie_dpad_kill":
				{
					array::thread_all(getplayers(), &zombie_devgui_dpad_death);
					break;
				}
				case "zombie_dpad_drink":
				{
					array::thread_all(getplayers(), &zombie_devgui_dpad_changeweapon);
					break;
				}
				case "director_easy":
				{
					zombie_devgui_director_easy();
					break;
				}
				case "open_sesame":
				{
					zombie_devgui_open_sesame();
					break;
				}
				case "allow_fog":
				{
					zombie_devgui_allow_fog();
					break;
				}
				case "disable_kill_thread_toggle":
				{
					zombie_devgui_disable_kill_thread_toggle();
					break;
				}
				case "check_kill_thread_every_frame_toggle":
				{
					zombie_devgui_check_kill_thread_every_frame_toggle();
					break;
				}
				case "kill_thread_test_mode_toggle":
				{
					zombie_devgui_kill_thread_test_mode_toggle();
					break;
				}
				case "zombie_failsafe_debug_flush":
				{
					level notify(#"zombie_failsafe_debug_flush", isdefined(level.zombie_weapons[getweapon(getdvarstring(#"scr_force_weapon"))]));
					break;
				}
				case "rat_navmesh":
				{
					level thread rat::derriesezombiespawnnavmeshtest(0, 0);
					break;
				}
				case "spawn":
				{
					devgui_zombie_spawn();
					break;
				}
				case "spawn_dummy":
				{
					function_6f066ef();
					break;
				}
				case "spawn_near":
				{
					function_7c17d00f();
					break;
				}
				case "spawn_all":
				{
					devgui_all_spawn();
					break;
				}
				case "crawler":
				{
					devgui_make_crawler();
					break;
				}
				case "toggle_show_spawn_locations":
				{
					devgui_toggle_show_spawn_locations();
					break;
				}
				case "toggle_show_exterior_goals":
				{
					devgui_toggle_show_exterior_goals();
					break;
				}
				case "draw_traversals":
				{
					zombie_devgui_draw_traversals();
					break;
				}
				case "dump_traversals":
				{
					function_bbeaa2da();
					break;
				}
				case "debug_hud":
				{
					array::thread_all(getplayers(), &devgui_debug_hud);
					break;
				}
				case "reverse_carpenter":
				{
					function_f12b8a34();
					break;
				}
				case "keyline_always":
				{
					zombie_devgui_keyline_always();
					break;
				}
				case "hash_1e51dfcdbebdf936":
				{
					robotsupportsovercover_manager_();
					break;
				}
				case "debug_counts":
				{
					function_92523b12();
					break;
				}
				case "hash_604a84ea1690f781":
				{
					thread function_3a5618f8();
					break;
				}
				case "hash_72a10718318ec7ff":
				{
					function_21f1fbf1();
					break;
				}
				case "debug_navmesh_zone":
				{
					function_e395a714();
					break;
				}
				case "hash_7fafc507d5398c0b":
				{
					function_567ee21f();
					break;
				}
				case "hash_3ede275f03a4aa2b":
				{
					function_1762ff96();
					break;
				}
				case "hash_74f6277a8a40911e":
				{
					function_e5713258();
					break;
				}
				case "hash_3d647b897ae5dca6":
				{
					function_f298dd5c();
					break;
				}
				case "hash_3f826ccc785705ba":
				{
					function_26417ea7();
					break;
				}
				case "hash_683b625d2ace3726":
				{
					function_fb88b423();
					break;
				}
				case "hash_3f9e70ff9f34194a":
				{
					function_1b531660();
					break;
				}
				case "hash_4369eeba583c6d2d":
				{
					function_61a7bb28();
					break;
				}
				case "hash_757311298fe0366e":
				{
					function_184b9c6a();
					break;
				}
				case "hash_27a8af524430a8e1":
				{
					function_986a2585();
					break;
				}
				case "hash_5995af694f312813":
				{
					function_faf7abce();
					break;
				}
				case 0:
				{
					break;
				}
				default:
				{
					if(isdefined(level.custom_devgui))
					{
						if(isarray(level.custom_devgui))
						{
							foreach(devgui in level.custom_devgui)
							{
								b_result = [[devgui]](cmd);
								if(isdefined(b_result) && b_result)
								{
									break;
								}
							}
						}
						else
						{
							[[level.custom_devgui]](cmd);
						}
					}
					break;
				}
			}
			setdvar(#"zombie_devgui", "");
			wait(0.5);
		}
	#/
}

/*
	Name: add_custom_devgui_callback
	Namespace: zm_devgui
	Checksum: 0xDF6E2DF5
	Offset: 0x7C50
	Size: 0x172
	Parameters: 1
	Flags: None
*/
function add_custom_devgui_callback(callback)
{
	/#
		if(isdefined(level.custom_devgui))
		{
			if(!isarray(level.custom_devgui))
			{
				cdgui = level.custom_devgui;
				level.custom_devgui = [];
				if(!isdefined(level.custom_devgui))
				{
					level.custom_devgui = [];
				}
				else if(!isarray(level.custom_devgui))
				{
					level.custom_devgui = array(level.custom_devgui);
				}
				level.custom_devgui[level.custom_devgui.size] = cdgui;
			}
		}
		else
		{
			level.custom_devgui = [];
		}
		if(!isdefined(level.custom_devgui))
		{
			level.custom_devgui = [];
		}
		else if(!isarray(level.custom_devgui))
		{
			level.custom_devgui = array(level.custom_devgui);
		}
		level.custom_devgui[level.custom_devgui.size] = callback;
	#/
}

/*
	Name: devgui_all_spawn
	Namespace: zm_devgui
	Checksum: 0x80EC21BB
	Offset: 0x7DD0
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function devgui_all_spawn()
{
	/#
		player = util::gethostplayer();
		bot::add_bots(3, player.team);
		wait(0.1);
		zombie_devgui_goto_round(8);
	#/
}

/*
	Name: devgui_toggle_show_spawn_locations
	Namespace: zm_devgui
	Checksum: 0x4D11FEFA
	Offset: 0x7E40
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function devgui_toggle_show_spawn_locations()
{
	/#
		if(!isdefined(level.toggle_show_spawn_locations))
		{
			level.toggle_show_spawn_locations = 1;
		}
		else
		{
			level.toggle_show_spawn_locations = !level.toggle_show_spawn_locations;
		}
	#/
}

/*
	Name: devgui_toggle_show_exterior_goals
	Namespace: zm_devgui
	Checksum: 0x16017F04
	Offset: 0x7E88
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function devgui_toggle_show_exterior_goals()
{
	/#
		if(!isdefined(level.toggle_show_exterior_goals))
		{
			level.toggle_show_exterior_goals = 1;
		}
		else
		{
			level.toggle_show_exterior_goals = !level.toggle_show_exterior_goals;
		}
	#/
}

/*
	Name: function_567ee21f
	Namespace: zm_devgui
	Checksum: 0x784768F3
	Offset: 0x7ED0
	Size: 0x258
	Parameters: 0
	Flags: None
*/
function function_567ee21f()
{
	/#
		level.var_377c39e4 = !(isdefined(level.var_377c39e4) && level.var_377c39e4);
		if(level.var_377c39e4)
		{
			foreach(player in level.players)
			{
				player setclientplayerpushamount(1);
			}
			foreach(ai in getaiteamarray(#"axis"))
			{
				ai pushplayer(1);
			}
		}
		else
		{
			foreach(player in level.players)
			{
				player setclientplayerpushamount(0);
			}
			foreach(ai in getaiteamarray(#"axis"))
			{
				ai pushplayer(0);
			}
		}
	#/
}

/*
	Name: devgui_zombie_spawn
	Namespace: zm_devgui
	Checksum: 0x89FB6019
	Offset: 0x8130
	Size: 0x1E8
	Parameters: 0
	Flags: None
*/
function devgui_zombie_spawn()
{
	/#
		player = getplayers()[0];
		spawnername = undefined;
		spawnername = "";
		direction = player getplayerangles();
		direction_vec = anglestoforward(direction);
		eye = player geteye();
		scale = 8000;
		direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
		trace = bullettrace(eye, eye + direction_vec, 0, undefined);
		guy = undefined;
		spawners = getentarray(spawnername, "");
		spawner = array::random(spawners);
		guy = zombie_utility::spawn_zombie(spawner);
		if(isdefined(guy))
		{
			guy.script_string = "";
			wait(0.5);
			guy forceteleport(trace[#"position"], player.angles + vectorscale((0, 1, 0), 180));
		}
		return guy;
	#/
}

/*
	Name: function_6f066ef
	Namespace: zm_devgui
	Checksum: 0xEF4F4C73
	Offset: 0x8328
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function function_6f066ef()
{
	/#
		player = getplayers()[0];
		forward = anglestoforward(player.angles);
		spawn = player.origin + (forward * 25);
		guy = devgui_zombie_spawn();
		if(isdefined(guy))
		{
			guy pathmode("");
			guy forceteleport(spawn, player.angles);
		}
	#/
}

/*
	Name: function_7c17d00f
	Namespace: zm_devgui
	Checksum: 0x9F850BA9
	Offset: 0x8410
	Size: 0xD4
	Parameters: 0
	Flags: None
*/
function function_7c17d00f()
{
	/#
		player = getplayers()[0];
		forward = anglestoforward(player.angles);
		spawn = player.origin + (forward * 100);
		guy = devgui_zombie_spawn();
		if(isdefined(guy))
		{
			guy forceteleport(spawn, player.angles + vectorscale((0, 1, 0), 180));
		}
	#/
}

/*
	Name: devgui_make_crawler
	Namespace: zm_devgui
	Checksum: 0xB511DF2E
	Offset: 0x84F0
	Size: 0x1D0
	Parameters: 0
	Flags: None
*/
function devgui_make_crawler()
{
	/#
		zombies = zombie_utility::get_round_enemy_array();
		foreach(zombie in zombies)
		{
			gib_style = [];
			gib_style[gib_style.size] = "";
			gib_style[gib_style.size] = "";
			gib_style[gib_style.size] = "";
			gib_style = zombie_death::randomize_array(gib_style);
			zombie.a.gib_ref = gib_style[0];
			zombie zombie_utility::function_df5afb5e(1);
			zombie allowedstances("");
			zombie setphysparams(15, 0, 24);
			zombie allowpitchangle(1);
			zombie setpitchorient();
			health = zombie.health;
			health = health * 0.1;
			zombie thread zombie_death::do_gib();
		}
	#/
}

/*
	Name: zombie_devgui_open_sesame
	Namespace: zm_devgui
	Checksum: 0x3CF4B58B
	Offset: 0x86C8
	Size: 0x3E4
	Parameters: 0
	Flags: None
*/
function zombie_devgui_open_sesame()
{
	/#
		setdvar(#"zombie_unlock_all", 1);
		level flag::set("");
		level clientfield::set("", 1);
		power_trigs = getentarray("", "");
		foreach(trig in power_trigs)
		{
			if(isdefined(trig.script_int))
			{
				level flag::set("" + trig.script_int);
				level clientfield::set("", trig.script_int + 1);
			}
		}
		players = getplayers();
		array::thread_all(players, &zombie_devgui_give_money);
		zombie_doors = getentarray("", "");
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
		zombie_airlock_doors = getentarray("", "");
		for(i = 0; i < zombie_airlock_doors.size; i++)
		{
			zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
			waitframe(1);
		}
		zombie_debris = getentarray("", "");
		for(i = 0; i < zombie_debris.size; i++)
		{
			if(isdefined(zombie_debris[i]))
			{
				zombie_debris[i] notify(#"trigger", {#activator:players[0]});
			}
			waitframe(1);
		}
		level notify(#"open_sesame");
		wait(1);
		setdvar(#"zombie_unlock_all", 0);
	#/
}

/*
	Name: any_player_in_noclip
	Namespace: zm_devgui
	Checksum: 0xD2EB060B
	Offset: 0x8AB8
	Size: 0xA2
	Parameters: 0
	Flags: None
*/
function any_player_in_noclip()
{
	/#
		foreach(player in getplayers())
		{
			if(player isinmovemode("", ""))
			{
				return true;
			}
		}
		return false;
	#/
}

/*
	Name: diable_fog_in_noclip
	Namespace: zm_devgui
	Checksum: 0x14B6D01F
	Offset: 0x8B68
	Size: 0x168
	Parameters: 0
	Flags: None
*/
function diable_fog_in_noclip()
{
	/#
		level.fog_disabled_in_noclip = 1;
		level endon(#"allowfoginnoclip");
		level flag::wait_till("");
		while(true)
		{
			while(!any_player_in_noclip())
			{
				wait(1);
			}
			setdvar(#"scr_fog_disable", 1);
			setdvar(#"r_fog_disable", 1);
			if(isdefined(level.culldist))
			{
				setculldist(0);
			}
			while(any_player_in_noclip())
			{
				wait(1);
			}
			setdvar(#"scr_fog_disable", 0);
			setdvar(#"r_fog_disable", 0);
			if(isdefined(level.culldist))
			{
				setculldist(level.culldist);
			}
		}
	#/
}

/*
	Name: zombie_devgui_allow_fog
	Namespace: zm_devgui
	Checksum: 0x6FEF1827
	Offset: 0x8CD8
	Size: 0xAC
	Parameters: 0
	Flags: None
*/
function zombie_devgui_allow_fog()
{
	/#
		if(isdefined(level.fog_disabled_in_noclip) && level.fog_disabled_in_noclip)
		{
			level notify(#"allowfoginnoclip");
			level.fog_disabled_in_noclip = 0;
			setdvar(#"scr_fog_disable", 0);
			setdvar(#"r_fog_disable", 0);
		}
		else
		{
			thread diable_fog_in_noclip();
		}
	#/
}

/*
	Name: zombie_devgui_give_money
	Namespace: zm_devgui
	Checksum: 0x8DCE3184
	Offset: 0x8D90
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_money()
{
	/#
		level.devcheater = 1;
		self zm_score::add_to_player_score(100000);
	#/
}

/*
	Name: zombie_devgui_take_money
	Namespace: zm_devgui
	Checksum: 0x41FB37A5
	Offset: 0x8DD0
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function zombie_devgui_take_money()
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		if(self.score > 100)
		{
			self zm_score::player_reduce_points("");
		}
		else
		{
			self zm_score::player_reduce_points("");
		}
	#/
}

/*
	Name: function_dc7312be
	Namespace: zm_devgui
	Checksum: 0x143802E7
	Offset: 0x8E98
	Size: 0x1AC
	Parameters: 0
	Flags: None
*/
function function_dc7312be()
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		if(!self zm_utility::is_drinking())
		{
			weapon = self getcurrentweapon();
			if(weapon != level.weaponnone && weapon != level.weaponzmfists && (!(isdefined(weapon.isflourishweapon) && weapon.isflourishweapon)))
			{
				ammo = self getweaponammostock(weapon);
				max = weapon.maxammo;
				if(isdefined(max) && isdefined(ammo))
				{
					if(ammo > max / 10)
					{
						self setweaponammostock(weapon, int(ammo / 2));
					}
					else
					{
						self setweaponammostock(weapon, 0);
					}
				}
			}
		}
	#/
}

/*
	Name: zombie_devgui_give_xp
	Namespace: zm_devgui
	Checksum: 0x91852DE6
	Offset: 0x9050
	Size: 0xB4
	Parameters: 1
	Flags: None
*/
function zombie_devgui_give_xp(amount)
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		self addrankxp("", self.currentweapon, undefined, undefined, 1, amount / 50);
	#/
}

/*
	Name: zombie_devgui_turn_player
	Namespace: zm_devgui
	Checksum: 0xBF3C3664
	Offset: 0x9110
	Size: 0x174
	Parameters: 1
	Flags: None
*/
function zombie_devgui_turn_player(index)
{
	/#
		players = getplayers();
		if(!isdefined(index) || index >= players.size)
		{
			player = players[0];
		}
		else
		{
			player = players[index];
		}
		/#
			assert(isdefined(player));
		#/
		/#
			assert(isplayer(player));
		#/
		/#
			assert(isalive(player));
		#/
		level.devcheater = 1;
		if(player hasperk(#"specialty_playeriszombie"))
		{
			println("");
			player zm_turned::turn_to_human();
		}
		else
		{
			println("");
			player zm_turned::turn_to_zombie();
		}
	#/
}

/*
	Name: function_4bb7eb36
	Namespace: zm_devgui
	Checksum: 0xF0749D8D
	Offset: 0x9290
	Size: 0x1E4
	Parameters: 0
	Flags: None
*/
function function_4bb7eb36()
{
	/#
		entnum = self getentitynumber();
		chest = level.chests[level.chest_index];
		origin = chest.zbarrier.origin;
		forward = anglestoforward(chest.zbarrier.angles);
		right = anglestoright(chest.zbarrier.angles);
		var_21f5823e = vectortoangles(right);
		var_916d3dfe = origin - (48 * right);
		switch(entnum)
		{
			case 0:
			{
				var_916d3dfe = var_916d3dfe + (16 * right);
				break;
			}
			case 1:
			{
				var_916d3dfe = var_916d3dfe + (16 * forward);
				break;
			}
			case 2:
			{
				var_916d3dfe = var_916d3dfe - (16 * right);
				break;
			}
			case 3:
			{
				var_916d3dfe = var_916d3dfe - (16 * forward);
				break;
			}
		}
		self setorigin(var_916d3dfe);
		self setplayerangles(var_21f5823e);
	#/
}

/*
	Name: function_84f0a909
	Namespace: zm_devgui
	Checksum: 0x2F128AE2
	Offset: 0x9480
	Size: 0x1FC
	Parameters: 0
	Flags: None
*/
function function_84f0a909()
{
	/#
		entnum = self getentitynumber();
		paps = getentarray("", "");
		pap = paps[0];
		if(!isdefined(pap))
		{
			return;
		}
		origin = pap.origin;
		forward = anglestoforward(pap.angles);
		right = anglestoright(pap.angles);
		var_21f5823e = vectortoangles(right * -1);
		var_916d3dfe = origin + (72 * right);
		switch(entnum)
		{
			case 0:
			{
				var_916d3dfe = var_916d3dfe - (16 * right);
				break;
			}
			case 1:
			{
				var_916d3dfe = var_916d3dfe + (16 * forward);
				break;
			}
			case 2:
			{
				var_916d3dfe = var_916d3dfe + (16 * right);
				break;
			}
			case 3:
			{
				var_916d3dfe = var_916d3dfe - (16 * forward);
				break;
			}
		}
		self setorigin(var_916d3dfe);
		self setplayerangles(var_21f5823e);
	#/
}

/*
	Name: zombie_devgui_cool_jetgun
	Namespace: zm_devgui
	Checksum: 0xCDEBDEE7
	Offset: 0x9688
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function zombie_devgui_cool_jetgun()
{
	/#
		if(isdefined(level.zm_devgui_jetgun_never_overheat))
		{
			self thread [[level.zm_devgui_jetgun_never_overheat]]();
		}
	#/
}

/*
	Name: zombie_devgui_preserve_turbines
	Namespace: zm_devgui
	Checksum: 0x238AF8D4
	Offset: 0x96C0
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function zombie_devgui_preserve_turbines()
{
	/#
		self endon(#"disconnect");
		self notify(#"preserve_turbines");
		self endon(#"preserve_turbines");
		if(!(isdefined(self.preserving_turbines) && self.preserving_turbines))
		{
			self.preserving_turbines = 1;
			while(true)
			{
				self.turbine_health = 1200;
				wait(1);
			}
		}
		self.preserving_turbines = 0;
	#/
}

/*
	Name: zombie_devgui_equipment_stays_healthy
	Namespace: zm_devgui
	Checksum: 0xE4C051E2
	Offset: 0x9758
	Size: 0x156
	Parameters: 0
	Flags: None
*/
function zombie_devgui_equipment_stays_healthy()
{
	/#
		self endon(#"disconnect");
		self notify(#"preserve_equipment");
		self endon(#"preserve_equipment");
		if(!(isdefined(self.preserving_equipment) && self.preserving_equipment))
		{
			self.preserving_equipment = 1;
			while(true)
			{
				self.equipment_damage = [];
				self.shielddamagetaken = 0;
				if(isdefined(level.destructible_equipment))
				{
					foreach(equip in level.destructible_equipment)
					{
						if(isdefined(equip))
						{
							equip.shielddamagetaken = 0;
							equip.damage = 0;
							equip.headchopper_kills = 0;
							equip.springpad_kills = 0;
							equip.subwoofer_kills = 0;
						}
					}
				}
				wait(0.1);
			}
		}
		self.preserving_equipment = 0;
	#/
}

/*
	Name: zombie_devgui_disown_equipment
	Namespace: zm_devgui
	Checksum: 0x12FF7F51
	Offset: 0x98B8
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function zombie_devgui_disown_equipment()
{
	/#
		self.deployed_equipment = [];
	#/
}

/*
	Name: zombie_devgui_equipment_give
	Namespace: zm_devgui
	Checksum: 0x67082C7A
	Offset: 0x98D8
	Size: 0xB4
	Parameters: 1
	Flags: None
*/
function zombie_devgui_equipment_give(equipment)
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		level.devcheater = 1;
		if(zm_equipment::is_included(equipment))
		{
			self zm_equipment::buy(equipment);
		}
	#/
}

/*
	Name: zombie_devgui_give_placeable_mine
	Namespace: zm_devgui
	Checksum: 0xCFE7C6C5
	Offset: 0x9998
	Size: 0x156
	Parameters: 1
	Flags: None
*/
function zombie_devgui_give_placeable_mine(weapon)
{
	/#
		self endon(#"disconnect");
		self notify(#"give_planted_grenade_thread");
		self endon(#"give_planted_grenade_thread");
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		level.devcheater = 1;
		if(!zm_loadout::is_placeable_mine(weapon))
		{
			return;
		}
		if(isdefined(self zm_loadout::get_player_placeable_mine()))
		{
			self takeweapon(self zm_loadout::get_player_placeable_mine());
		}
		self thread zm_placeable_mine::setup_for_player(weapon);
		while(true)
		{
			self givemaxammo(weapon);
			wait(1);
		}
	#/
}

/*
	Name: zombie_devgui_give_claymores
	Namespace: zm_devgui
	Checksum: 0xCDFE86AA
	Offset: 0x9AF8
	Size: 0x15E
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_claymores()
{
	/#
		self endon(#"disconnect");
		self notify(#"give_planted_grenade_thread");
		self endon(#"give_planted_grenade_thread");
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		level.devcheater = 1;
		if(isdefined(self zm_loadout::get_player_placeable_mine()))
		{
			self takeweapon(self zm_loadout::get_player_placeable_mine());
		}
		wpn_type = zm_placeable_mine::get_first_available();
		if(wpn_type != level.weaponnone)
		{
			self thread zm_placeable_mine::setup_for_player(wpn_type);
		}
		while(true)
		{
			self givemaxammo(wpn_type);
			wait(1);
		}
	#/
}

/*
	Name: zombie_devgui_give_lethal
	Namespace: zm_devgui
	Checksum: 0xF4284224
	Offset: 0x9C60
	Size: 0x156
	Parameters: 1
	Flags: None
*/
function zombie_devgui_give_lethal(weapon)
{
	/#
		self endon(#"disconnect");
		self notify(#"give_lethal_grenade_thread");
		self endon(#"give_lethal_grenade_thread");
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		level.devcheater = 1;
		if(isdefined(self zm_loadout::get_player_lethal_grenade()))
		{
			self takeweapon(self zm_loadout::get_player_lethal_grenade());
		}
		self giveweapon(weapon);
		self zm_loadout::set_player_lethal_grenade(weapon);
		while(true)
		{
			self givemaxammo(weapon);
			wait(1);
		}
	#/
}

/*
	Name: zombie_devgui_give_frags
	Namespace: zm_devgui
	Checksum: 0xEC9CE825
	Offset: 0x9DC0
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_frags()
{
	/#
		zombie_devgui_give_lethal(getweapon(#"eq_frag_grenade"));
	#/
}

/*
	Name: zombie_devgui_give_sticky
	Namespace: zm_devgui
	Checksum: 0x73DE0669
	Offset: 0x9E08
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_sticky()
{
	/#
		zombie_devgui_give_lethal(getweapon(#"sticky_grenade"));
	#/
}

/*
	Name: zombie_devgui_give_monkey
	Namespace: zm_devgui
	Checksum: 0xD719D26A
	Offset: 0x9E50
	Size: 0x15E
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_monkey()
{
	/#
		self endon(#"disconnect");
		self notify(#"give_tactical_grenade_thread");
		self endon(#"give_tactical_grenade_thread");
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		level.devcheater = 1;
		if(isdefined(self zm_loadout::get_player_tactical_grenade()))
		{
			self takeweapon(self zm_loadout::get_player_tactical_grenade());
		}
		if(isdefined(level.zombiemode_devgui_cymbal_monkey_give))
		{
			self [[level.zombiemode_devgui_cymbal_monkey_give]]();
			while(true)
			{
				self givemaxammo(getweapon(#"cymbal_monkey"));
				wait(1);
			}
		}
	#/
}

/*
	Name: zombie_devgui_give_bhb
	Namespace: zm_devgui
	Checksum: 0x8BCB07A2
	Offset: 0x9FB8
	Size: 0x146
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_bhb()
{
	/#
		self endon(#"disconnect");
		self notify(#"give_tactical_grenade_thread");
		self endon(#"give_tactical_grenade_thread");
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		level.devcheater = 1;
		if(isdefined(self zm_loadout::get_player_tactical_grenade()))
		{
			self takeweapon(self zm_loadout::get_player_tactical_grenade());
		}
		if(isdefined(level.zombiemode_devgui_black_hole_bomb_give))
		{
			self [[level.zombiemode_devgui_black_hole_bomb_give]]();
			while(true)
			{
				self givemaxammo(level.w_black_hole_bomb);
				wait(1);
			}
		}
	#/
}

/*
	Name: zombie_devgui_give_qed
	Namespace: zm_devgui
	Checksum: 0x99992061
	Offset: 0xA108
	Size: 0x146
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_qed()
{
	/#
		self endon(#"disconnect");
		self notify(#"give_tactical_grenade_thread");
		self endon(#"give_tactical_grenade_thread");
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		level.devcheater = 1;
		if(isdefined(self zm_loadout::get_player_tactical_grenade()))
		{
			self takeweapon(self zm_loadout::get_player_tactical_grenade());
		}
		if(isdefined(level.zombiemode_devgui_quantum_bomb_give))
		{
			self [[level.zombiemode_devgui_quantum_bomb_give]]();
			while(true)
			{
				self givemaxammo(level.w_quantum_bomb);
				wait(1);
			}
		}
	#/
}

/*
	Name: zombie_devgui_give_dolls
	Namespace: zm_devgui
	Checksum: 0x140EF41C
	Offset: 0xA258
	Size: 0x146
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_dolls()
{
	/#
		self endon(#"disconnect");
		self notify(#"give_tactical_grenade_thread");
		self endon(#"give_tactical_grenade_thread");
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		level.devcheater = 1;
		if(isdefined(self zm_loadout::get_player_tactical_grenade()))
		{
			self takeweapon(self zm_loadout::get_player_tactical_grenade());
		}
		if(isdefined(level.zombiemode_devgui_nesting_dolls_give))
		{
			self [[level.zombiemode_devgui_nesting_dolls_give]]();
			while(true)
			{
				self givemaxammo(level.w_nesting_dolls);
				wait(1);
			}
		}
	#/
}

/*
	Name: zombie_devgui_give_emp_bomb
	Namespace: zm_devgui
	Checksum: 0xDE309A5C
	Offset: 0xA3A8
	Size: 0x15E
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_emp_bomb()
{
	/#
		self endon(#"disconnect");
		self notify(#"give_tactical_grenade_thread");
		self endon(#"give_tactical_grenade_thread");
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		level.devcheater = 1;
		if(isdefined(self zm_loadout::get_player_tactical_grenade()))
		{
			self takeweapon(self zm_loadout::get_player_tactical_grenade());
		}
		if(isdefined(level.zombiemode_devgui_emp_bomb_give))
		{
			self [[level.zombiemode_devgui_emp_bomb_give]]();
			while(true)
			{
				self givemaxammo(getweapon(#"emp_grenade"));
				wait(1);
			}
		}
	#/
}

/*
	Name: zombie_devgui_invulnerable
	Namespace: zm_devgui
	Checksum: 0x40BD1121
	Offset: 0xA510
	Size: 0x104
	Parameters: 2
	Flags: None
*/
function zombie_devgui_invulnerable(playerindex, onoff)
{
	/#
		players = getplayers();
		if(!isdefined(playerindex))
		{
			for(i = 0; i < players.size; i++)
			{
				zombie_devgui_invulnerable(i, onoff);
			}
		}
		else if(players.size > playerindex)
		{
			if(onoff)
			{
				players[playerindex] val::set(#"zombie_devgui", "", 0);
			}
			else
			{
				players[playerindex] val::reset(#"zombie_devgui", "");
			}
		}
	#/
}

/*
	Name: zombie_devgui_kill
	Namespace: zm_devgui
	Checksum: 0x66DEC21A
	Offset: 0xA620
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function zombie_devgui_kill()
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		self val::set(#"devgui_kill", "", 1);
		death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
		self dodamage(self.health + 666, self.origin + death_from);
	#/
}

/*
	Name: zombie_devgui_toggle_ammo
	Namespace: zm_devgui
	Checksum: 0x55C9B9B
	Offset: 0xA750
	Size: 0x2E8
	Parameters: 0
	Flags: None
*/
function zombie_devgui_toggle_ammo()
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		self notify(#"devgui_toggle_ammo");
		self endon(#"devgui_toggle_ammo");
		self.ammo4evah = !(isdefined(self.ammo4evah) && self.ammo4evah);
		while(isdefined(self) && self.ammo4evah)
		{
			if(!self zm_utility::is_drinking())
			{
				weapon = self getcurrentweapon();
				if(weapon != level.weaponnone && weapon != level.weaponzmfists && (!(isdefined(weapon.isflourishweapon) && weapon.isflourishweapon)))
				{
					self setweaponoverheating(0, 0);
					max = weapon.maxammo;
					if(isdefined(max))
					{
						self setweaponammostock(weapon, max);
					}
					if(isdefined(self zm_loadout::get_player_tactical_grenade()))
					{
						self givemaxammo(self zm_loadout::get_player_tactical_grenade());
					}
					if(isdefined(self zm_loadout::get_player_lethal_grenade()))
					{
						self givemaxammo(self zm_loadout::get_player_lethal_grenade());
					}
				}
				for(i = 0; i < 3; i++)
				{
					if(isdefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i]))
					{
						if(!self util::gadget_is_in_use(i) && self gadgetcharging(i))
						{
							self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
						}
					}
				}
			}
			wait(1);
		}
	#/
}

/*
	Name: zombie_devgui_toggle_ignore
	Namespace: zm_devgui
	Checksum: 0x3BF28487
	Offset: 0xAA40
	Size: 0x134
	Parameters: 0
	Flags: None
*/
function zombie_devgui_toggle_ignore()
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		if(!isdefined(self.devgui_ignoreme))
		{
			self.devgui_ignoreme = 0;
		}
		self.devgui_ignoreme = !self.devgui_ignoreme;
		if(self.devgui_ignoreme)
		{
			self val::set(#"devgui", "");
		}
		else
		{
			self val::reset(#"devgui", "");
		}
		if(self.ignoreme)
		{
			setdvar(#"ai_showfailedpaths", 0);
		}
	#/
}

/*
	Name: zombie_devgui_revive
	Namespace: zm_devgui
	Checksum: 0x115D2E97
	Offset: 0xAB80
	Size: 0x6E
	Parameters: 0
	Flags: None
*/
function zombie_devgui_revive()
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		if(laststand::player_is_in_laststand())
		{
			self notify(#"auto_revive");
		}
	#/
}

/*
	Name: zombie_devgui_give_health
	Namespace: zm_devgui
	Checksum: 0x86C0E906
	Offset: 0xABF8
	Size: 0x12C
	Parameters: 0
	Flags: None
*/
function zombie_devgui_give_health()
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		self notify(#"devgui_health");
		self endon(#"devgui_health", #"disconnect", #"death");
		level.devcheater = 1;
		while(true)
		{
			self.maxhealth = 100000;
			self.health = 100000;
			self waittill(#"player_revived", #"perk_used", #"spawned_player");
			wait(2);
		}
	#/
}

/*
	Name: zombie_devgui_low_health
	Namespace: zm_devgui
	Checksum: 0x5DE2700B
	Offset: 0xAD30
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function zombie_devgui_low_health()
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		self notify(#"devgui_health");
		self endon(#"devgui_health", #"disconnect", #"death");
		level.devcheater = 1;
		while(true)
		{
			self.maxhealth = 10;
			self.health = 10;
			self waittill(#"player_revived", #"perk_used", #"spawned_player");
			wait(2);
		}
	#/
}

/*
	Name: zombie_devgui_give_perk
	Namespace: zm_devgui
	Checksum: 0x3E245252
	Offset: 0xAE60
	Size: 0x136
	Parameters: 1
	Flags: None
*/
function zombie_devgui_give_perk(perk)
{
	/#
		vending_machines = zm_perks::get_perk_machines();
		level.devcheater = 1;
		if(vending_machines.size < 1)
		{
			return;
		}
		foreach(player in getplayers())
		{
			for(i = 0; i < vending_machines.size; i++)
			{
				if(vending_machines[i].script_noteworthy == perk)
				{
					vending_machines[i] notify(#"trigger", {#activator:player});
					break;
				}
			}
			wait(1);
		}
	#/
}

/*
	Name: zombie_devgui_take_perks
	Namespace: zm_devgui
	Checksum: 0x51E2D2B1
	Offset: 0xAFA0
	Size: 0x19E
	Parameters: 1
	Flags: None
*/
function zombie_devgui_take_perks(cmd)
{
	/#
		vending_machines = zm_perks::get_perk_machines();
		perks = [];
		for(i = 0; i < vending_machines.size; i++)
		{
			perk = vending_machines[i].script_noteworthy;
			if(isdefined(self.perk_purchased) && self.perk_purchased == perk)
			{
				continue;
			}
			perks[perks.size] = perk;
		}
		foreach(player in getplayers())
		{
			foreach(perk in perks)
			{
				perk_str = perk + "";
				player notify(perk_str);
			}
		}
	#/
}

/*
	Name: function_fd6c1b3c
	Namespace: zm_devgui
	Checksum: 0xB15DF5FA
	Offset: 0xB148
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_fd6c1b3c(cmd)
{
	/#
		if(isdefined(level.perk_random_devgui_callback))
		{
			self [[level.perk_random_devgui_callback]](cmd);
		}
	#/
}

/*
	Name: function_82f7d6a1
	Namespace: zm_devgui
	Checksum: 0xB2E372DA
	Offset: 0xB188
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_82f7d6a1(cmd)
{
	/#
		if(isdefined(level.perk_random_devgui_callback))
		{
			self [[level.perk_random_devgui_callback]](cmd);
		}
	#/
}

/*
	Name: function_68bd1e17
	Namespace: zm_devgui
	Checksum: 0xD21BBA1E
	Offset: 0xB1C8
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_68bd1e17(cmd)
{
	/#
		if(isdefined(level.perk_random_devgui_callback))
		{
			self [[level.perk_random_devgui_callback]](cmd);
		}
	#/
}

/*
	Name: function_7565dd74
	Namespace: zm_devgui
	Checksum: 0x28B85622
	Offset: 0xB208
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_7565dd74(cmd)
{
	/#
		if(isdefined(level.perk_random_devgui_callback))
		{
			self [[level.perk_random_devgui_callback]](cmd);
		}
	#/
}

/*
	Name: function_87979c2c
	Namespace: zm_devgui
	Checksum: 0x63A71863
	Offset: 0xB248
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_87979c2c(cmd)
{
	/#
		if(isdefined(level.perk_random_devgui_callback))
		{
			self [[level.perk_random_devgui_callback]](cmd);
		}
	#/
}

/*
	Name: function_2cbcab61
	Namespace: zm_devgui
	Checksum: 0x57B09077
	Offset: 0xB288
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_2cbcab61(cmd)
{
	/#
		if(isdefined(level.perk_random_devgui_callback))
		{
			self [[level.perk_random_devgui_callback]](cmd);
		}
	#/
}

/*
	Name: function_18fc6a29
	Namespace: zm_devgui
	Checksum: 0x8B47F4F1
	Offset: 0xB2C8
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_18fc6a29(cmd)
{
	/#
		if(isdefined(level.perk_random_devgui_callback))
		{
			self [[level.perk_random_devgui_callback]](cmd);
		}
	#/
}

/*
	Name: zombie_devgui_give_powerup
	Namespace: zm_devgui
	Checksum: 0xB5643B5A
	Offset: 0xB308
	Size: 0x2A4
	Parameters: 3
	Flags: None
*/
function zombie_devgui_give_powerup(powerup_name, now, origin)
{
	/#
		player = getplayers()[0];
		found = 0;
		level.devcheater = 1;
		if(isdefined(now) && !now)
		{
			for(i = 0; i < level.zombie_powerup_array.size; i++)
			{
				if(level.zombie_powerup_array[i] == powerup_name)
				{
					level.zombie_powerup_index = i;
					found = 1;
					break;
				}
			}
			if(!found)
			{
				return;
			}
			level.zombie_devgui_power = 1;
			zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
			level.powerup_drop_count = 0;
			return;
		}
		direction = player getplayerangles();
		direction_vec = anglestoforward(direction);
		eye = player geteye();
		scale = 8000;
		direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
		trace = bullettrace(eye, eye + direction_vec, 0, undefined);
		if(!isdefined(level.zombie_powerups) || !isdefined(level.zombie_powerups[powerup_name]))
		{
			return;
		}
		if(isdefined(origin))
		{
			level thread zm_powerups::specific_powerup_drop(powerup_name, origin, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
		}
		else
		{
			level thread zm_powerups::specific_powerup_drop(powerup_name, trace[#"position"], undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
		}
	#/
}

/*
	Name: zombie_devgui_give_powerup_player
	Namespace: zm_devgui
	Checksum: 0xC7AFD5B9
	Offset: 0xB5B8
	Size: 0x20C
	Parameters: 2
	Flags: None
*/
function zombie_devgui_give_powerup_player(powerup_name, now)
{
	/#
		player = self;
		found = 0;
		level.devcheater = 1;
		if(isdefined(now) && !now)
		{
			for(i = 0; i < level.zombie_powerup_array.size; i++)
			{
				if(level.zombie_powerup_array[i] == powerup_name)
				{
					level.zombie_powerup_index = i;
					found = 1;
					break;
				}
			}
			if(!found)
			{
				return;
			}
			level.zombie_devgui_power = 1;
			zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
			level.powerup_drop_count = 0;
			return;
		}
		direction = player getplayerangles();
		direction_vec = anglestoforward(direction);
		eye = player geteye();
		scale = 8000;
		direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
		trace = bullettrace(eye, eye + direction_vec, 0, undefined);
		level thread zm_powerups::specific_powerup_drop(powerup_name, trace[#"position"], undefined, undefined, player);
	#/
}

/*
	Name: zombie_devgui_goto_round
	Namespace: zm_devgui
	Checksum: 0x78434C5E
	Offset: 0xB7D0
	Size: 0x19E
	Parameters: 1
	Flags: None
*/
function zombie_devgui_goto_round(target_round)
{
	/#
		player = getplayers()[0];
		if(target_round < 1)
		{
			target_round = 1;
		}
		level.devcheater = 1;
		level.zombie_total = 0;
		level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::function_d2dfacfd(#"zombie_health_start"), target_round);
		zm_round_logic::set_round_number(target_round - 1);
		level notify(#"kill_round");
		wait(1);
		zombies = getaiteamarray(level.zombie_team);
		if(isdefined(zombies))
		{
			for(i = 0; i < zombies.size; i++)
			{
				if(isdefined(zombies[i].ignore_devgui_death) && zombies[i].ignore_devgui_death)
				{
					continue;
				}
				zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
			}
		}
	#/
}

/*
	Name: zombie_devgui_monkey_round
	Namespace: zm_devgui
	Checksum: 0xFE9F142A
	Offset: 0xB978
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function zombie_devgui_monkey_round()
{
	/#
		if(isdefined(level.next_monkey_round))
		{
			zombie_devgui_goto_round(level.next_monkey_round);
		}
	#/
}

/*
	Name: zombie_devgui_thief_round
	Namespace: zm_devgui
	Checksum: 0x2C61F62F
	Offset: 0xB9B8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function zombie_devgui_thief_round()
{
	/#
		if(isdefined(level.next_thief_round))
		{
			zombie_devgui_goto_round(level.next_thief_round);
		}
	#/
}

/*
	Name: zombie_devgui_dog_round
	Namespace: zm_devgui
	Checksum: 0x7104DCA3
	Offset: 0xB9F8
	Size: 0xEC
	Parameters: 1
	Flags: None
*/
function zombie_devgui_dog_round(num_dogs)
{
	/#
		if(!isdefined(level.dogs_enabled) || !level.dogs_enabled)
		{
			return;
		}
		if(!isdefined(level.dog_rounds_enabled) || !level.dog_rounds_enabled)
		{
			return;
		}
		if(!isdefined(level.enemy_dog_spawns) || level.enemy_dog_spawns.size < 1)
		{
			return;
		}
		if(!level flag::get(""))
		{
			setdvar(#"force_dogs", num_dogs);
		}
		zombie_devgui_goto_round(level.round_number + 1);
	#/
}

/*
	Name: zombie_devgui_dog_round_skip
	Namespace: zm_devgui
	Checksum: 0x1DB515EA
	Offset: 0xBAF0
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function zombie_devgui_dog_round_skip()
{
	/#
		if(isdefined(level.next_dog_round))
		{
			zombie_devgui_goto_round(level.next_dog_round);
		}
	#/
}

/*
	Name: zombie_devgui_dump_zombie_vars
	Namespace: zm_devgui
	Checksum: 0xF26B683B
	Offset: 0xBB30
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function zombie_devgui_dump_zombie_vars()
{
	/#
		if(!isdefined(level.zombie_vars))
		{
			return;
		}
		if(level.zombie_vars.size > 0)
		{
			println("");
		}
		else
		{
			return;
		}
		var_392d3ebe = getarraykeys(level.zombie_vars);
		for(i = 0; i < level.zombie_vars.size; i++)
		{
			key = var_392d3ebe[i];
			println((key + "") + zombie_utility::function_d2dfacfd(key));
		}
		println("");
	#/
}

/*
	Name: zombie_devgui_pack_current_weapon
	Namespace: zm_devgui
	Checksum: 0xB23469F5
	Offset: 0xBC38
	Size: 0x1A6
	Parameters: 0
	Flags: None
*/
function zombie_devgui_pack_current_weapon()
{
	/#
		players = getplayers();
		reviver = players[0];
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			if(!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "")
			{
				weap = players[i] getcurrentweapon();
				weapon = players[i] get_upgrade(weap);
				if(isdefined(weapon))
				{
					players[i] takeweapon(weap);
					weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
					players[i] thread aat::remove(weapon);
					players[i] zm_weapons::function_7c5dd4bd(weapon);
					players[i] switchtoweapon(weapon);
				}
			}
		}
	#/
}

/*
	Name: zombie_devgui_repack_current_weapon
	Namespace: zm_devgui
	Checksum: 0xD8B81B1
	Offset: 0xBDE8
	Size: 0x156
	Parameters: 0
	Flags: None
*/
function zombie_devgui_repack_current_weapon()
{
	/#
		players = getplayers();
		reviver = players[0];
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			if(!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "")
			{
				weap = players[i] getcurrentweapon();
				if(isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weap))
				{
					players[i] thread aat::acquire(weap);
					players[i] zm_pap_util::repack_weapon(weap, 4);
				}
			}
		}
	#/
}

/*
	Name: zombie_devgui_unpack_current_weapon
	Namespace: zm_devgui
	Checksum: 0xB11381C1
	Offset: 0xBF48
	Size: 0x176
	Parameters: 0
	Flags: None
*/
function zombie_devgui_unpack_current_weapon()
{
	/#
		players = getplayers();
		reviver = players[0];
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			if(!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "")
			{
				weap = players[i] getcurrentweapon();
				weapon = zm_weapons::get_base_weapon(weap);
				players[i] takeweapon(weap);
				weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
				players[i] zm_weapons::function_7c5dd4bd(weapon);
				players[i] switchtoweapon(weapon);
			}
		}
	#/
}

/*
	Name: function_55c6dedd
	Namespace: zm_devgui
	Checksum: 0xCBCAAF2
	Offset: 0xC0C8
	Size: 0x74
	Parameters: 2
	Flags: None
*/
function function_55c6dedd(str_weapon, xp)
{
	/#
		if(!isdefined(str_weapon) || !level.onlinegame)
		{
			return;
		}
		if(0 > xp)
		{
			xp = 0;
		}
		self stats::set_stat(#"hash_60e21f66eb3a1f18", str_weapon, #"xp", xp);
	#/
}

/*
	Name: function_335cdac
	Namespace: zm_devgui
	Checksum: 0x8673B935
	Offset: 0xC148
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function function_335cdac(weapon)
{
	/#
		gunlevels = [];
		table = popups::devgui_notif_getgunleveltablename();
		weapon_name = weapon.rootweapon.name;
		for(i = 0; i < 15; i++)
		{
			var_4a3def14 = tablelookup(table, 2, weapon_name, 0, i, 1);
			if("" == var_4a3def14)
			{
				break;
			}
			gunlevels[i] = int(var_4a3def14);
		}
		return gunlevels;
	#/
}

/*
	Name: registerhendricks_under_silo_third_jump_fight_
	Namespace: zm_devgui
	Checksum: 0x12633B62
	Offset: 0xC248
	Size: 0x86
	Parameters: 2
	Flags: None
*/
function registerhendricks_under_silo_third_jump_fight_(weapon, var_56c1b8d)
{
	/#
		xp = 0;
		gunlevels = function_335cdac(weapon);
		if(gunlevels.size)
		{
			xp = gunlevels[gunlevels.size - 1];
			if(var_56c1b8d < gunlevels.size)
			{
				xp = gunlevels[var_56c1b8d];
			}
		}
		return xp;
	#/
}

/*
	Name: function_af7d932
	Namespace: zm_devgui
	Checksum: 0x43AEF60E
	Offset: 0xC2D8
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_af7d932(weapon)
{
	/#
		xp = 0;
		gunlevels = function_335cdac(weapon);
		if(gunlevels.size)
		{
			xp = gunlevels[gunlevels.size - 1];
		}
		return xp;
	#/
}

/*
	Name: function_c8949116
	Namespace: zm_devgui
	Checksum: 0xA54B50BD
	Offset: 0xC348
	Size: 0x12E
	Parameters: 0
	Flags: None
*/
function function_c8949116()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player laststand::player_is_in_laststand())
			{
				weapon = player getcurrentweapon();
				itemindex = getbaseweaponitemindex(weapon);
				var_56c1b8d = player getcurrentgunrank(itemindex);
				xp = registerhendricks_under_silo_third_jump_fight_(weapon, var_56c1b8d);
				player function_55c6dedd(weapon.name, xp);
			}
		}
	#/
}

/*
	Name: function_9d21f44b
	Namespace: zm_devgui
	Checksum: 0x41D52991
	Offset: 0xC480
	Size: 0x12E
	Parameters: 0
	Flags: None
*/
function function_9d21f44b()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player laststand::player_is_in_laststand())
			{
				weapon = player getcurrentweapon();
				itemindex = getbaseweaponitemindex(weapon);
				var_56c1b8d = player getcurrentgunrank(itemindex);
				xp = registerhendricks_under_silo_third_jump_fight_(weapon, var_56c1b8d);
				player function_55c6dedd(weapon.name, xp - 50);
			}
		}
	#/
}

/*
	Name: function_e2a97bab
	Namespace: zm_devgui
	Checksum: 0x62E369C5
	Offset: 0xC5B8
	Size: 0x10E
	Parameters: 0
	Flags: None
*/
function function_e2a97bab()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player laststand::player_is_in_laststand())
			{
				weapon = player getcurrentweapon();
				itemindex = getbaseweaponitemindex(weapon);
				xp = function_af7d932(weapon);
				player function_55c6dedd(weapon.name, xp);
			}
		}
	#/
}

/*
	Name: function_1a560cfc
	Namespace: zm_devgui
	Checksum: 0x9947FA85
	Offset: 0xC6D0
	Size: 0xEE
	Parameters: 0
	Flags: None
*/
function function_1a560cfc()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player laststand::player_is_in_laststand())
			{
				weapon = player getcurrentweapon();
				itemindex = getbaseweaponitemindex(weapon);
				player function_55c6dedd(weapon.name, 0);
			}
		}
	#/
}

/*
	Name: function_c8ee84ba
	Namespace: zm_devgui
	Checksum: 0xC2291B56
	Offset: 0xC7C8
	Size: 0x150
	Parameters: 0
	Flags: None
*/
function function_c8ee84ba()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		a_weapons = enumerateweapons("");
		for(weapon_index = 0; weapon_index < a_weapons.size; weapon_index++)
		{
			weapon = a_weapons[weapon_index];
			itemindex = getbaseweaponitemindex(weapon);
			if(!itemindex)
			{
				continue;
			}
			xp = function_af7d932(weapon);
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
				if(!player laststand::player_is_in_laststand())
				{
					player function_55c6dedd(weapon.name, xp);
				}
			}
		}
	#/
}

/*
	Name: function_c83c6fa
	Namespace: zm_devgui
	Checksum: 0x49B128D3
	Offset: 0xC920
	Size: 0x138
	Parameters: 0
	Flags: None
*/
function function_c83c6fa()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		a_weapons = enumerateweapons("");
		for(weapon_index = 0; weapon_index < a_weapons.size; weapon_index++)
		{
			weapon = a_weapons[weapon_index];
			itemindex = getbaseweaponitemindex(weapon);
			if(!itemindex)
			{
				continue;
			}
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
				if(!player laststand::player_is_in_laststand())
				{
					player function_55c6dedd(weapon.name, 0);
				}
			}
		}
	#/
}

/*
	Name: function_cbdab30d
	Namespace: zm_devgui
	Checksum: 0x98A66A81
	Offset: 0xCA60
	Size: 0x124
	Parameters: 1
	Flags: None
*/
function function_cbdab30d(xp)
{
	/#
		if(self.pers[#"rankxp"] > xp)
		{
			self.pers[#"rank"] = 0;
			self setrank(0);
			self stats::set_stat(#"playerstatslist", #"rank", #"statvalue", 0);
		}
		self.pers[#"rankxp"] = xp;
		self rank::updaterank();
		self stats::set_stat(#"playerstatslist", #"rank", #"statvalue", self.pers[#"rank"]);
	#/
}

/*
	Name: function_5c26ad27
	Namespace: zm_devgui
	Checksum: 0xCD2B130D
	Offset: 0xCB90
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function function_5c26ad27(var_56c1b8d)
{
	/#
		return int(rank::getrankinfominxp(var_56c1b8d));
	#/
}

/*
	Name: function_5da832fa
	Namespace: zm_devgui
	Checksum: 0x33682366
	Offset: 0xCBD0
	Size: 0x42
	Parameters: 0
	Flags: None
*/
function function_5da832fa()
{
	/#
		xp = 0;
		xp = function_5c26ad27(level.ranktable.size - 1);
		return xp;
	#/
}

/*
	Name: function_8c9f2dea
	Namespace: zm_devgui
	Checksum: 0xF0ED7A7A
	Offset: 0xCC20
	Size: 0xDE
	Parameters: 0
	Flags: None
*/
function function_8c9f2dea()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player laststand::player_is_in_laststand())
			{
				var_56c1b8d = player rank::getrank();
				xp = function_5c26ad27(var_56c1b8d);
				player function_cbdab30d(xp);
			}
		}
	#/
}

/*
	Name: function_b7ef4b8
	Namespace: zm_devgui
	Checksum: 0x1F7B688C
	Offset: 0xCD08
	Size: 0xE6
	Parameters: 0
	Flags: None
*/
function function_b7ef4b8()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player laststand::player_is_in_laststand())
			{
				var_56c1b8d = player rank::getrank();
				xp = function_5c26ad27(var_56c1b8d);
				player function_cbdab30d(xp - 50);
			}
		}
	#/
}

/*
	Name: function_9b4d61fa
	Namespace: zm_devgui
	Checksum: 0x7185F53A
	Offset: 0xCDF8
	Size: 0xBE
	Parameters: 0
	Flags: None
*/
function function_9b4d61fa()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player laststand::player_is_in_laststand())
			{
				xp = function_5da832fa();
				player function_cbdab30d(xp);
			}
		}
	#/
}

/*
	Name: function_cdc3d061
	Namespace: zm_devgui
	Checksum: 0x657CD36D
	Offset: 0xCEC0
	Size: 0x9E
	Parameters: 0
	Flags: None
*/
function function_cdc3d061()
{
	/#
		players = getplayers();
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!player laststand::player_is_in_laststand())
			{
				player function_cbdab30d(0);
			}
		}
	#/
}

/*
	Name: zombie_devgui_reopt_current_weapon
	Namespace: zm_devgui
	Checksum: 0x6E03058D
	Offset: 0xCF68
	Size: 0x166
	Parameters: 0
	Flags: None
*/
function zombie_devgui_reopt_current_weapon()
{
	/#
		players = getplayers();
		reviver = players[0];
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			if(!players[i] laststand::player_is_in_laststand())
			{
				weapon = players[i] getcurrentweapon();
				if(isdefined(players[i].pack_a_punch_weapon_options))
				{
					players[i].pack_a_punch_weapon_options[weapon] = undefined;
				}
				players[i] takeweapon(weapon);
				weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
				players[i] zm_weapons::function_7c5dd4bd(weapon);
				players[i] switchtoweapon(weapon);
			}
		}
	#/
}

/*
	Name: zombie_devgui_take_weapon
	Namespace: zm_devgui
	Checksum: 0x1F1A0E6C
	Offset: 0xD0D8
	Size: 0xE6
	Parameters: 0
	Flags: None
*/
function zombie_devgui_take_weapon()
{
	/#
		players = getplayers();
		reviver = players[0];
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			if(!players[i] laststand::player_is_in_laststand())
			{
				players[i] takeweapon(players[i] getcurrentweapon());
				players[i] zm_weapons::switch_back_primary_weapon(undefined);
			}
		}
	#/
}

/*
	Name: zombie_devgui_take_weapons
	Namespace: zm_devgui
	Checksum: 0xDA252A1B
	Offset: 0xD1C8
	Size: 0xD6
	Parameters: 1
	Flags: None
*/
function zombie_devgui_take_weapons(give_fallback)
{
	/#
		players = getplayers();
		reviver = players[0];
		level.devcheater = 1;
		for(i = 0; i < players.size; i++)
		{
			if(!players[i] laststand::player_is_in_laststand())
			{
				players[i] takeallweapons();
				if(give_fallback)
				{
					players[i] zm_weapons::give_fallback_weapon();
				}
			}
		}
	#/
}

/*
	Name: get_upgrade
	Namespace: zm_devgui
	Checksum: 0xA78180A8
	Offset: 0xD2A8
	Size: 0x7A
	Parameters: 1
	Flags: None
*/
function get_upgrade(weapon)
{
	/#
		if(isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade_name))
		{
			return zm_weapons::get_upgrade_weapon(weapon, 0);
		}
		return zm_weapons::get_upgrade_weapon(weapon, 1);
	#/
}

/*
	Name: zombie_devgui_director_easy
	Namespace: zm_devgui
	Checksum: 0x365CF321
	Offset: 0xD330
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function zombie_devgui_director_easy()
{
	/#
		if(isdefined(level.director_devgui_health))
		{
			[[level.director_devgui_health]]();
		}
	#/
}

/*
	Name: zombie_devgui_chest_never_move
	Namespace: zm_devgui
	Checksum: 0xD01F6A5A
	Offset: 0xD360
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function zombie_devgui_chest_never_move()
{
	/#
		level notify(#"devgui_chest_end_monitor");
		level endon(#"devgui_chest_end_monitor");
		for(;;)
		{
			level.chest_accessed = 0;
			wait(5);
		}
	#/
}

/*
	Name: zombie_devgui_disable_kill_thread_toggle
	Namespace: zm_devgui
	Checksum: 0xE138997D
	Offset: 0xD3B0
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function zombie_devgui_disable_kill_thread_toggle()
{
	/#
		if(!(isdefined(level.disable_kill_thread) && level.disable_kill_thread))
		{
			level.disable_kill_thread = 1;
		}
		else
		{
			level.disable_kill_thread = 0;
		}
	#/
}

/*
	Name: zombie_devgui_check_kill_thread_every_frame_toggle
	Namespace: zm_devgui
	Checksum: 0x6F8305A2
	Offset: 0xD400
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function zombie_devgui_check_kill_thread_every_frame_toggle()
{
	/#
		if(!(isdefined(level.check_kill_thread_every_frame) && level.check_kill_thread_every_frame))
		{
			level.check_kill_thread_every_frame = 1;
		}
		else
		{
			level.check_kill_thread_every_frame = 0;
		}
	#/
}

/*
	Name: zombie_devgui_kill_thread_test_mode_toggle
	Namespace: zm_devgui
	Checksum: 0xFD49E5EB
	Offset: 0xD450
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function zombie_devgui_kill_thread_test_mode_toggle()
{
	/#
		if(!(isdefined(level.kill_thread_test_mode) && level.kill_thread_test_mode))
		{
			level.kill_thread_test_mode = 1;
		}
		else
		{
			level.kill_thread_test_mode = 0;
		}
	#/
}

/*
	Name: showonespawnpoint
	Namespace: zm_devgui
	Checksum: 0x1332BB02
	Offset: 0xD4A0
	Size: 0x50C
	Parameters: 5
	Flags: None
*/
function showonespawnpoint(spawn_point, color, notification, height, print)
{
	/#
		if(!isdefined(height) || height <= 0)
		{
			height = util::get_player_height();
		}
		if(!isdefined(print))
		{
			print = spawn_point.classname;
		}
		center = spawn_point.origin;
		forward = anglestoforward(spawn_point.angles);
		right = anglestoright(spawn_point.angles);
		forward = vectorscale(forward, 16);
		right = vectorscale(right, 16);
		a = (center + forward) - right;
		b = (center + forward) + right;
		c = (center - forward) + right;
		d = (center - forward) - right;
		thread lineuntilnotified(a, b, color, 0, notification);
		thread lineuntilnotified(b, c, color, 0, notification);
		thread lineuntilnotified(c, d, color, 0, notification);
		thread lineuntilnotified(d, a, color, 0, notification);
		thread lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
		thread lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
		thread lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
		thread lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
		a = a + (0, 0, height);
		b = b + (0, 0, height);
		c = c + (0, 0, height);
		d = d + (0, 0, height);
		thread lineuntilnotified(a, b, color, 0, notification);
		thread lineuntilnotified(b, c, color, 0, notification);
		thread lineuntilnotified(c, d, color, 0, notification);
		thread lineuntilnotified(d, a, color, 0, notification);
		center = center + (0, 0, height / 2);
		arrow_forward = anglestoforward(spawn_point.angles);
		arrowhead_forward = anglestoforward(spawn_point.angles);
		arrowhead_right = anglestoright(spawn_point.angles);
		arrow_forward = vectorscale(arrow_forward, 32);
		arrowhead_forward = vectorscale(arrowhead_forward, 24);
		arrowhead_right = vectorscale(arrowhead_right, 8);
		a = center + arrow_forward;
		b = (center + arrowhead_forward) - arrowhead_right;
		c = (center + arrowhead_forward) + arrowhead_right;
		thread lineuntilnotified(center, a, color, 0, notification);
		thread lineuntilnotified(a, b, color, 0, notification);
		thread lineuntilnotified(a, c, color, 0, notification);
		thread print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
	#/
}

/*
	Name: print3duntilnotified
	Namespace: zm_devgui
	Checksum: 0xBC1C6F84
	Offset: 0xD9B8
	Size: 0x76
	Parameters: 6
	Flags: None
*/
function print3duntilnotified(origin, text, color, alpha, scale, notification)
{
	/#
		level endon(notification);
		for(;;)
		{
			print3d(origin, text, color, alpha, scale);
			waitframe(1);
		}
	#/
}

/*
	Name: lineuntilnotified
	Namespace: zm_devgui
	Checksum: 0xFB53D4BC
	Offset: 0xDA38
	Size: 0x66
	Parameters: 5
	Flags: None
*/
function lineuntilnotified(start, end, color, depthtest, notification)
{
	/#
		level endon(notification);
		for(;;)
		{
			line(start, end, color, depthtest);
			waitframe(1);
		}
	#/
}

/*
	Name: devgui_debug_hud
	Namespace: zm_devgui
	Checksum: 0x9D89AA85
	Offset: 0xDAA8
	Size: 0x2EC
	Parameters: 0
	Flags: None
*/
function devgui_debug_hud()
{
	/#
		if(isdefined(self zm_loadout::get_player_lethal_grenade()))
		{
			self givemaxammo(self zm_loadout::get_player_lethal_grenade());
		}
		wpn_type = zm_placeable_mine::get_first_available();
		if(wpn_type != level.weaponnone)
		{
			self thread zm_placeable_mine::setup_for_player(wpn_type);
		}
		if(isdefined(level.zombiemode_devgui_cymbal_monkey_give))
		{
			if(isdefined(self zm_loadout::get_player_tactical_grenade()))
			{
				self takeweapon(self zm_loadout::get_player_tactical_grenade());
			}
			self [[level.zombiemode_devgui_cymbal_monkey_give]]();
		}
		else if(isdefined(self zm_loadout::get_player_tactical_grenade()))
		{
			self givemaxammo(self zm_loadout::get_player_tactical_grenade());
		}
		if(isdefined(level.zombie_include_equipment) && !isdefined(self zm_equipment::get_player_equipment()))
		{
			equipment = getarraykeys(level.zombie_include_equipment);
			if(isdefined(equipment[0]))
			{
				self zombie_devgui_equipment_give(equipment[0]);
			}
		}
		for(i = 0; i < 10; i++)
		{
			zombie_devgui_give_powerup("", 1, self.origin);
			wait(0.25);
		}
		zombie_devgui_give_powerup("", 1, self.origin);
		wait(0.25);
		zombie_devgui_give_powerup("", 1, self.origin);
		wait(0.25);
		zombie_devgui_give_powerup("", 1, self.origin);
		wait(0.25);
		zombie_devgui_give_powerup("", 1, self.origin);
		wait(0.25);
		zombie_devgui_give_powerup("", 1, self.origin);
		wait(0.25);
	#/
}

/*
	Name: zombie_devgui_draw_traversals
	Namespace: zm_devgui
	Checksum: 0x9C1F3C05
	Offset: 0xDDA0
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function zombie_devgui_draw_traversals()
{
	/#
		if(!isdefined(level.toggle_draw_traversals))
		{
			level.toggle_draw_traversals = 1;
		}
		else
		{
			level.toggle_draw_traversals = !level.toggle_draw_traversals;
		}
	#/
}

/*
	Name: zombie_devgui_keyline_always
	Namespace: zm_devgui
	Checksum: 0xC5EFDF86
	Offset: 0xDDE8
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function zombie_devgui_keyline_always()
{
	/#
		if(!isdefined(level.toggle_keyline_always))
		{
			level.toggle_keyline_always = 1;
		}
		else
		{
			level.toggle_keyline_always = !level.toggle_keyline_always;
		}
	#/
}

/*
	Name: robotsupportsovercover_manager_
	Namespace: zm_devgui
	Checksum: 0xA8DD2E12
	Offset: 0xDE30
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function robotsupportsovercover_manager_()
{
	/#
		if(level flag::get(""))
		{
			level flag::clear("");
			iprintln("");
		}
		else
		{
			level flag::set("");
			iprintln("");
		}
	#/
}

/*
	Name: function_92523b12
	Namespace: zm_devgui
	Checksum: 0xC5EFC42E
	Offset: 0xDED0
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function function_92523b12()
{
	/#
		if(!isdefined(level.var_5171ee4a))
		{
			level.var_5171ee4a = 1;
		}
		else
		{
			level.var_5171ee4a = !level.var_5171ee4a;
		}
	#/
}

/*
	Name: wait_for_zombie
	Namespace: zm_devgui
	Checksum: 0xC4D92ED
	Offset: 0xDF18
	Size: 0x290
	Parameters: 1
	Flags: None
*/
function wait_for_zombie(crawler)
{
	/#
		nodes = getallnodes();
		while(true)
		{
			ai = getactorarray();
			zombie = ai[0];
			if(isdefined(zombie))
			{
				foreach(node in nodes)
				{
					if(node.type == #"begin" || node.type == #"end" || node.type == #"bad node")
					{
						if(isdefined(node.animscript))
						{
							zombie setblackboardattribute("", "");
							zombie setblackboardattribute("", node.animscript);
							table = "";
							if(isdefined(crawler) && crawler)
							{
								table = "";
							}
							if(isdefined(zombie.debug_traversal_ast))
							{
								table = zombie.debug_traversal_ast;
							}
							anim_results = zombie astsearch(table);
							if(!isdefined(anim_results[#"animation"]))
							{
								if(isdefined(crawler) && crawler)
								{
									node.bad_crawler_traverse = 1;
								}
								else
								{
									node.bad_traverse = 1;
								}
								continue;
							}
							if(anim_results[#"animation"] == "")
							{
								teleport = 1;
							}
						}
					}
				}
				break;
			}
			wait(0.25);
		}
	#/
}

/*
	Name: zombie_draw_traversals
	Namespace: zm_devgui
	Checksum: 0xE1A5396C
	Offset: 0xE1B0
	Size: 0x212
	Parameters: 0
	Flags: None
*/
function zombie_draw_traversals()
{
	/#
		level thread wait_for_zombie();
		level thread wait_for_zombie(1);
		nodes = getallnodes();
		while(true)
		{
			if(isdefined(level.toggle_draw_traversals) && level.toggle_draw_traversals)
			{
				foreach(node in nodes)
				{
					if(isdefined(node.animscript))
					{
						txt_color = (0, 0.8, 0.6);
						circle_color = (1, 1, 1);
						if(isdefined(node.bad_traverse) && node.bad_traverse)
						{
							txt_color = (1, 0, 0);
							circle_color = (1, 0, 0);
						}
						circle(node.origin, 16, circle_color);
						print3d(node.origin, node.animscript, txt_color, 1, 0.5);
						if(isdefined(node.bad_crawler_traverse) && node.bad_crawler_traverse)
						{
							print3d(node.origin + (vectorscale((0, 0, -1), 12)), "", (1, 0, 0), 1, 0.5);
						}
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_bbeaa2da
	Namespace: zm_devgui
	Checksum: 0xB1A6A467
	Offset: 0xE3D0
	Size: 0x1CC
	Parameters: 0
	Flags: None
*/
function function_bbeaa2da()
{
	/#
		nodes = getallnodes();
		var_43e9aabd = [];
		foreach(node in nodes)
		{
			if(isdefined(node.animscript) && node.animscript != "")
			{
				var_43e9aabd[node.animscript] = 1;
			}
		}
		var_cb16f0db = getarraykeys(var_43e9aabd);
		sortednames = array::sort_by_value(var_cb16f0db, 1);
		println("");
		foreach(name in sortednames)
		{
			println("" + name);
		}
		println("");
	#/
}

/*
	Name: function_e9b89aac
	Namespace: zm_devgui
	Checksum: 0xC9D2516F
	Offset: 0xE5A8
	Size: 0x1DE
	Parameters: 0
	Flags: None
*/
function function_e9b89aac()
{
	/#
		while(true)
		{
			if(isdefined(level.zones) && (getdvarint(#"zombiemode_debug_zones", 0) || getdvarint(#"hash_756b3f2accaa1678", 0)))
			{
				foreach(zone in level.zones)
				{
					foreach(node in zone.nodes)
					{
						node_region = getnoderegion(node);
						var_747013f8 = node.targetname;
						if(isdefined(node_region))
						{
							var_747013f8 = (node_region + "") + node.targetname;
						}
						print3d(node.origin + vectorscale((0, 0, 1), 12), var_747013f8, (0, 1, 0), 1, 1);
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_e395a714
	Namespace: zm_devgui
	Checksum: 0xD70D59FC
	Offset: 0xE790
	Size: 0xDE
	Parameters: 0
	Flags: None
*/
function function_e395a714()
{
	/#
		if(!isdefined(level.var_9a11ee76))
		{
			level.var_9a11ee76 = 0;
		}
		foreach(player in level.players)
		{
			if(level.var_9a11ee76)
			{
				player notify(#"hash_d592b5d81b7b3a7");
				continue;
			}
			player thread function_fb482cad();
		}
		level.var_9a11ee76 = !level.var_9a11ee76;
	#/
}

/*
	Name: function_2fcf8a4a
	Namespace: zm_devgui
	Checksum: 0xF02FE7E4
	Offset: 0xE878
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function function_2fcf8a4a(notifyhash)
{
	/#
		if(isdefined(self.var_d35d1d3d))
		{
			self.var_d35d1d3d destroy();
			self.var_d35d1d3d = undefined;
		}
	#/
}

/*
	Name: function_fb482cad
	Namespace: zm_devgui
	Checksum: 0xBE11D569
	Offset: 0xE8C0
	Size: 0x186
	Parameters: 0
	Flags: None
*/
function function_fb482cad()
{
	/#
		self notify(#"hash_d592b5d81b7b3a7");
		self endoncallback(&function_2fcf8a4a, #"hash_d592b5d81b7b3a7", #"disconnect");
		while(true)
		{
			if(!isdefined(self.var_d35d1d3d))
			{
				self.var_d35d1d3d = newdebughudelem(self);
				self.var_d35d1d3d.alignx = "";
				self.var_d35d1d3d.horzalign = "";
				self.var_d35d1d3d.aligny = "";
				self.var_d35d1d3d.vertalign = "";
				self.var_d35d1d3d.color = (1, 1, 1);
				self.var_d35d1d3d.alpha = 1;
			}
			debug_text = "";
			if(isdefined(self.cached_zone_volume))
			{
				debug_text = "";
			}
			else if(isdefined(self.var_3b65cdd7))
			{
				debug_text = "";
			}
			self.var_d35d1d3d settext(debug_text);
			self waittill(#"zone_change");
		}
	#/
}

/*
	Name: function_8817dd98
	Namespace: zm_devgui
	Checksum: 0xDAD07844
	Offset: 0xEA50
	Size: 0x21E
	Parameters: 0
	Flags: None
*/
function function_8817dd98()
{
	/#
		while(true)
		{
			if(isdefined(level.var_5171ee4a) && level.var_5171ee4a)
			{
				if(!isdefined(level.var_fcfab54a))
				{
					level.var_fcfab54a = newdebughudelem();
					level.var_fcfab54a.alignx = "";
					level.var_fcfab54a.x = 2;
					level.var_fcfab54a.y = 160;
					level.var_fcfab54a.fontscale = 1.5;
					level.var_fcfab54a.color = (1, 1, 1);
				}
				zombie_count = zombie_utility::get_current_zombie_count();
				zombie_left = level.zombie_total;
				zombie_runners = 0;
				var_536fd32b = zombie_utility::get_zombie_array();
				foreach(ai_zombie in var_536fd32b)
				{
					if(ai_zombie.zombie_move_speed == "")
					{
						zombie_runners++;
					}
				}
				level.var_fcfab54a settext((((("" + zombie_count) + "") + zombie_left) + "") + zombie_runners);
			}
			else if(isdefined(level.var_fcfab54a))
			{
				level.var_fcfab54a destroy();
			}
			waitframe(1);
		}
	#/
}

/*
	Name: testscriptruntimeerrorassert
	Namespace: zm_devgui
	Checksum: 0x344B39F2
	Offset: 0xEC78
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function testscriptruntimeerrorassert()
{
	/#
		wait(1);
		/#
			assert(0);
		#/
	#/
}

/*
	Name: testscriptruntimeerror2
	Namespace: zm_devgui
	Checksum: 0xF08ECF0E
	Offset: 0xECA8
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function testscriptruntimeerror2()
{
	/#
		myundefined = "";
		if(myundefined == 1)
		{
			println("");
		}
	#/
}

/*
	Name: testscriptruntimeerror1
	Namespace: zm_devgui
	Checksum: 0x210183EA
	Offset: 0xECF8
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function testscriptruntimeerror1()
{
	/#
		testscriptruntimeerror2();
	#/
}

/*
	Name: testscriptruntimeerror
	Namespace: zm_devgui
	Checksum: 0xE86E26AF
	Offset: 0xED20
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function testscriptruntimeerror()
{
	/#
		wait(5);
		for(;;)
		{
			if(getdvarstring(#"scr_testscriptruntimeerror") != "")
			{
				break;
			}
			wait(1);
		}
		myerror = getdvarstring(#"scr_testscriptruntimeerror");
		setdvar(#"scr_testscriptruntimeerror", "");
		if(myerror == "")
		{
			testscriptruntimeerrorassert();
		}
		else
		{
			testscriptruntimeerror1();
		}
		thread testscriptruntimeerror();
	#/
}

/*
	Name: function_f12b8a34
	Namespace: zm_devgui
	Checksum: 0x9E7FF92C
	Offset: 0xEE08
	Size: 0x27E
	Parameters: 0
	Flags: None
*/
function function_f12b8a34()
{
	/#
		barriers = struct::get_array("", "");
		if(isdefined(level._additional_carpenter_nodes))
		{
			barriers = arraycombine(barriers, level._additional_carpenter_nodes, 0, 0);
		}
		foreach(barrier in barriers)
		{
			if(isdefined(barrier.zbarrier))
			{
				a_pieces = barrier.zbarrier getzbarrierpieceindicesinstate("");
				if(isdefined(a_pieces))
				{
					for(xx = 0; xx < a_pieces.size; xx++)
					{
						chunk = a_pieces[xx];
						barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
						barrier.zbarrier.chunk_health[chunk] = 0;
					}
				}
				for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++)
				{
					barrier.zbarrier setzbarrierpiecestate(x, "");
					barrier.zbarrier showzbarrierpiece(x);
				}
			}
			if(isdefined(barrier.clip))
			{
				barrier.clip triggerenable(1);
				barrier.clip disconnectpaths();
			}
			else
			{
				zm_blockers::blocker_connect_paths(barrier.neg_start, barrier.neg_end);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_29dcbd58
	Namespace: zm_devgui
	Checksum: 0x1DDF0500
	Offset: 0xF090
	Size: 0x8A
	Parameters: 0
	Flags: None
*/
function function_29dcbd58()
{
	/#
		var_a6f3b62c = getdvarint(#"hash_1e8ebf0a767981dd", 0);
		return array(array(var_a6f3b62c / 2, 30), array(var_a6f3b62c - 1, 20));
	#/
}

/*
	Name: function_3a5618f8
	Namespace: zm_devgui
	Checksum: 0xA94A69B
	Offset: 0xF128
	Size: 0x264
	Parameters: 0
	Flags: None
*/
function function_3a5618f8()
{
	/#
		self endon(#"hash_63ae1cb168b8e0d7");
		setdvar(#"cg_drawscriptusage", 1);
		var_a6f3b62c = getdvarint(#"hash_1e8ebf0a767981dd", 0);
		timescale = getdvarint(#"hash_7438b7c847f3c0", 0);
		var_59ed21fc = function_29dcbd58();
		setdvar(#"runtime_time_scale", timescale);
		while(level.round_number < var_a6f3b62c)
		{
			foreach(round_info in var_59ed21fc)
			{
				if(level.round_number < round_info[0])
				{
					wait(round_info[1]);
					break;
				}
			}
			ai_enemies = getaiteamarray(#"axis");
			foreach(ai in ai_enemies)
			{
				ai kill();
			}
			adddebugcommand("");
			wait(0.2);
		}
		setdvar(#"runtime_time_scale", 1);
	#/
}

/*
	Name: function_21f1fbf1
	Namespace: zm_devgui
	Checksum: 0xE3922A74
	Offset: 0xF398
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_21f1fbf1()
{
	/#
		self notify(#"hash_63ae1cb168b8e0d7");
		setdvar(#"runtime_time_scale", 1);
	#/
}

/*
	Name: function_1762ff96
	Namespace: zm_devgui
	Checksum: 0x41277B29
	Offset: 0xF3E8
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_1762ff96()
{
	/#
		level.var_afb69372 = !(isdefined(self.var_afb69372) && self.var_afb69372);
		if(isdefined(level.var_afb69372) && level.var_afb69372)
		{
			level thread function_b7e34647();
		}
		else
		{
			level notify(#"hash_2876f101dd7375df");
		}
	#/
}

/*
	Name: function_b7e34647
	Namespace: zm_devgui
	Checksum: 0x90D8A883
	Offset: 0xF468
	Size: 0x232
	Parameters: 0
	Flags: None
*/
function function_b7e34647()
{
	/#
		level endon(#"hash_2876f101dd7375df");
		while(true)
		{
			zombies = [];
			foreach(archetype in level.var_58903b1f)
			{
				ai = getaiarchetypearray(archetype, level.zombie_team);
				if(ai.size)
				{
					zombies = arraycombine(zombies, ai, 0, 0);
				}
			}
			foreach(zombie in zombies)
			{
				if(isdefined(zombie.need_closest_player) && zombie.need_closest_player)
				{
					record3dtext("", zombie.origin + vectorscale((0, 0, 1), 72), (1, 0, 0));
					continue;
				}
				record3dtext("", zombie.origin + vectorscale((0, 0, 1), 72), (0, 1, 0));
				if(isdefined(zombie.var_26f25576))
				{
					record3dtext(gettime() - zombie.var_26f25576, zombie.origin + vectorscale((0, 0, 1), 54), (1, 1, 1));
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_1e285ac2
	Namespace: zm_devgui
	Checksum: 0x49E3507B
	Offset: 0xF6A8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_1e285ac2()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		level thread function_c774d870();
	#/
}

/*
	Name: function_c774d870
	Namespace: zm_devgui
	Checksum: 0xE41C0031
	Offset: 0xF738
	Size: 0x298
	Parameters: 0
	Flags: None
*/
function function_c774d870()
{
	/#
		for(;;)
		{
			wait(0.25);
			cmd = getdvarint(#"hash_5b8785c3d6383b3a", 0);
			if(isdefined(cmd) && cmd == 1)
			{
				iprintlnbold("");
				zm::function_1442d44f();
				setdvar(#"hash_5b8785c3d6383b3a", 0);
			}
			cmd = getdvarstring(#"hash_2d9d21912cbffb75");
			if(isdefined(cmd) && cmd == 1)
			{
				iprintlnbold("");
				level.gamedifficulty = 0;
				setdvar(#"hash_2d9d21912cbffb75", 0);
				setdvar(#"hash_5b8785c3d6383b3a", 1);
			}
			cmd = getdvarstring(#"hash_2b205a3ab882058c");
			if(isdefined(cmd) && cmd == 1)
			{
				iprintlnbold("");
				level.gamedifficulty = 1;
				setdvar(#"hash_2b205a3ab882058c", 0);
				setdvar(#"hash_5b8785c3d6383b3a", 1);
			}
			cmd = getdvarstring(#"hash_393960bacf784966");
			if(isdefined(cmd) && cmd == 1)
			{
				iprintlnbold("");
				level.gamedifficulty = 2;
				setdvar(#"hash_393960bacf784966", 0);
				setdvar(#"hash_5b8785c3d6383b3a", 1);
			}
		}
	#/
}

/*
	Name: function_255c7194
	Namespace: zm_devgui
	Checksum: 0xCA9F8245
	Offset: 0xF9D8
	Size: 0xAC
	Parameters: 0
	Flags: Private
*/
function private function_255c7194()
{
	/#
		player = getplayers()[0];
		queryresult = positionquery_source_navigation(player.origin, 256, 512, 128, 20);
		if(isdefined(queryresult) && queryresult.data.size > 0)
		{
			return queryresult.data[0];
		}
		return {#origin:player.origin};
	#/
}

/*
	Name: function_b4dcb9ce
	Namespace: zm_devgui
	Checksum: 0xDE17C415
	Offset: 0xFA90
	Size: 0x114
	Parameters: 0
	Flags: Private
*/
function private function_b4dcb9ce()
{
	/#
		player = getplayers()[0];
		direction = player getplayerangles();
		direction_vec = anglestoforward(direction);
		eye = player geteye();
		scale = 8000;
		direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
		trace = bullettrace(eye, eye + direction_vec, 0, player);
		return {#origin:trace[#"position"]};
	#/
}

/*
	Name: spawn_archetype
	Namespace: zm_devgui
	Checksum: 0xF74F75F0
	Offset: 0xFBB0
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function spawn_archetype(spawner_name)
{
	/#
		spawners = getspawnerarray(spawner_name, "");
		spawn_point = function_b4dcb9ce();
		if(spawners.size == 0)
		{
			iprintln(("" + spawner_name) + "");
			return;
		}
		entity = spawners[0] spawnfromspawner(0, 1);
		if(isdefined(entity))
		{
			entity forceteleport(spawn_point.origin);
		}
	#/
}

/*
	Name: kill_archetype
	Namespace: zm_devgui
	Checksum: 0xACBAE6AD
	Offset: 0xFC98
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function kill_archetype(archetype)
{
	/#
		enemies = getaiarchetypearray(archetype);
		foreach(enemy in enemies)
		{
			if(isalive(enemy))
			{
				enemy kill();
			}
		}
	#/
}

/*
	Name: function_8d799ebd
	Namespace: zm_devgui
	Checksum: 0xD6F61FD7
	Offset: 0xFD58
	Size: 0x27C
	Parameters: 0
	Flags: None
*/
function function_8d799ebd()
{
	/#
		level.devcheater = 1;
		if(!self laststand::player_is_in_laststand())
		{
			self zm_hero_weapon::function_1bb7f7b1(3);
			self zm_perks::function_869a50c0(4);
			var_5d62d3c8 = array::randomize(array(#"ar_accurate_t8", #"ar_fastfire_t8", #"ar_stealth_t8", #"ar_modular_t8", #"smg_capacity_t8", #"tr_powersemi_t8"));
			foreach(w_primary in self getweaponslistprimaries())
			{
				self takeweapon(w_primary);
			}
			for(i = 0; i < zm_utility::get_player_weapon_limit(self); i++)
			{
				weapon = getweapon(var_5d62d3c8[i]);
				weapon = get_upgrade(weapon.rootweapon);
				weapon = self zm_weapons::give_build_kit_weapon(weapon);
				if(isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon))
				{
					self thread aat::acquire(weapon);
					self zm_pap_util::repack_weapon(weapon, 4);
				}
			}
			self switchtoweapon(weapon);
		}
	#/
}

/*
	Name: function_f298dd5c
	Namespace: zm_devgui
	Checksum: 0x87B56543
	Offset: 0xFFE0
	Size: 0x5A
	Parameters: 0
	Flags: None
*/
function function_f298dd5c()
{
	/#
		/#
			if(!isdefined(level.var_9db63456))
			{
				level.var_9db63456 = 0;
			}
		#/
		if(!isdefined(level.var_9db63456))
		{
			level.var_9db63456 = 1;
		}
		level.var_9db63456 = !level.var_9db63456;
	#/
}

/*
	Name: function_e5713258
	Namespace: zm_devgui
	Checksum: 0x6D611FD3
	Offset: 0x10048
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function function_e5713258()
{
	/#
		if(isdefined(level.var_33571ef1) && level.var_33571ef1)
		{
			level notify(#"hash_147174071dbfe31e");
		}
		else
		{
			level thread function_15ee6847();
		}
		level.var_33571ef1 = !(isdefined(level.var_33571ef1) && level.var_33571ef1);
	#/
}

/*
	Name: function_15ee6847
	Namespace: zm_devgui
	Checksum: 0xFE71B5E6
	Offset: 0x100D8
	Size: 0x27E
	Parameters: 0
	Flags: None
*/
function function_15ee6847()
{
	/#
		self notify("");
		self endon("");
		level endon(#"hash_147174071dbfe31e");
		while(true)
		{
			teststring = "";
			foreach(player in level.players)
			{
				teststring = teststring + (("" + player getentitynumber()) + "");
				if(player.sessionstate == "")
				{
					teststring = teststring + "";
					continue;
				}
				if(isdefined(self.hostmigrationcontrolsfrozen) && self.hostmigrationcontrolsfrozen)
				{
					teststring = teststring + "";
					continue;
				}
				if(player zm_player::in_life_brush())
				{
					teststring = teststring + "";
					continue;
				}
				if(player zm_player::in_kill_brush())
				{
					teststring = teststring + "";
					continue;
				}
				if(!player zm_player::in_enabled_playable_area())
				{
					teststring = teststring + "";
					continue;
				}
				if(isdefined(level.player_out_of_playable_area_override) && (!(isdefined(player [[level.player_out_of_playable_area_override]]()) && player [[level.player_out_of_playable_area_override]]())))
				{
					teststring = teststring + "";
					continue;
				}
				teststring = teststring + "";
			}
			debug2dtext((400, 100, 0), teststring, (1, 1, 0), undefined, (0, 0, 0), 0.75, 1, 1);
			waitframe(1);
		}
	#/
}

/*
	Name: function_26417ea7
	Namespace: zm_devgui
	Checksum: 0x3B629030
	Offset: 0x10360
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function function_26417ea7()
{
	/#
		level.var_565d6ce0 = !(isdefined(level.var_565d6ce0) && level.var_565d6ce0);
	#/
}

/*
	Name: function_fb88b423
	Namespace: zm_devgui
	Checksum: 0x3054D939
	Offset: 0x103A0
	Size: 0xA8
	Parameters: 0
	Flags: None
*/
function function_fb88b423()
{
	/#
		zombies = getaiarray();
		foreach(zombie in zombies)
		{
			zombie zombie_utility::setup_zombie_knockdown(level.players[0]);
		}
	#/
}

/*
	Name: init_debug_center_screen
	Namespace: zm_devgui
	Checksum: 0xACF6C406
	Offset: 0x10450
	Size: 0x1B8
	Parameters: 0
	Flags: None
*/
function init_debug_center_screen()
{
	/#
		waitframe(1);
		setdvar(#"debug_center_screen", 0);
		level flag::wait_till("");
		zero_idle_movement = 0;
		devgui_base = "";
		adddebugcommand(((devgui_base + "") + "") + "");
		for(;;)
		{
			if(getdvarint(#"debug_center_screen", 0))
			{
				if(!isdefined(level.center_screen_debug_hudelem_active) || level.center_screen_debug_hudelem_active == 0)
				{
					thread debug_center_screen();
					zero_idle_movement = getdvarint(#"zero_idle_movement", 0);
					if(zero_idle_movement == 0)
					{
						setdvar(#"zero_idle_movement", 1);
						zero_idle_movement = 1;
					}
				}
			}
			else
			{
				level notify(#"stop center screen debug");
				if(zero_idle_movement == 1)
				{
					setdvar(#"zero_idle_movement", 0);
					zero_idle_movement = 0;
				}
			}
			wait(0.5);
		}
	#/
}

/*
	Name: debug_center_screen
	Namespace: zm_devgui
	Checksum: 0xE2CA90C8
	Offset: 0x10610
	Size: 0x24A
	Parameters: 0
	Flags: None
*/
function debug_center_screen()
{
	/#
		level.center_screen_debug_hudelem_active = 1;
		wait(0.1);
		level.center_screen_debug_hudelem1 = newdebughudelem(level.players[0]);
		level.center_screen_debug_hudelem1.alignx = "";
		level.center_screen_debug_hudelem1.aligny = "";
		level.center_screen_debug_hudelem1.fontscale = 1;
		level.center_screen_debug_hudelem1.alpha = 0.5;
		level.center_screen_debug_hudelem1.x = 320 - 1;
		level.center_screen_debug_hudelem1.y = 240;
		level.center_screen_debug_hudelem1 setshader("", 1000, 1);
		level.center_screen_debug_hudelem2 = newdebughudelem(level.players[0]);
		level.center_screen_debug_hudelem2.alignx = "";
		level.center_screen_debug_hudelem2.aligny = "";
		level.center_screen_debug_hudelem2.fontscale = 1;
		level.center_screen_debug_hudelem2.alpha = 0.5;
		level.center_screen_debug_hudelem2.x = 320 - 1;
		level.center_screen_debug_hudelem2.y = 240;
		level.center_screen_debug_hudelem2 setshader("", 1, 480);
		level waittill(#"stop center screen debug");
		level.center_screen_debug_hudelem1 destroy();
		level.center_screen_debug_hudelem2 destroy();
		level.center_screen_debug_hudelem_active = 0;
	#/
}

/*
	Name: function_b5d522f8
	Namespace: zm_devgui
	Checksum: 0x7C9404A9
	Offset: 0x10868
	Size: 0x270
	Parameters: 0
	Flags: None
*/
function function_b5d522f8()
{
	/#
		self notify("");
		self endon("");
		function_7c9dd642();
		setdvar(#"hash_46eec505e691414c", "");
		setdvar(#"hash_74f1952a0f93d08e", -1);
		while(true)
		{
			wait(0.1);
			var_9261da43 = getdvar(#"hash_46eec505e691414c", "");
			var_10acd4fa = getdvar(#"hash_74f1952a0f93d08e", -1);
			if(var_9261da43 == "" && var_10acd4fa == -1)
			{
				continue;
			}
			player = level.players[0];
			if(isplayer(player))
			{
				if(var_9261da43 != "")
				{
					args = strtok(var_9261da43, "");
					level zm_ui_inventory::function_7df6bb60(args[0], int(args[1]), player);
				}
				if(var_10acd4fa != -1)
				{
					if(var_10acd4fa > 0)
					{
						player zm_ui_inventory::function_d8f1d200(#"hash_336cbe1bb6ff213");
					}
					else
					{
						player zm_ui_inventory::function_d8f1d200(#"");
					}
				}
			}
			setdvar(#"hash_46eec505e691414c", "");
			setdvar(#"hash_74f1952a0f93d08e", -1);
		}
	#/
}

/*
	Name: function_7c9dd642
	Namespace: zm_devgui
	Checksum: 0xDC9B60FE
	Offset: 0x10AE0
	Size: 0x21C
	Parameters: 0
	Flags: None
*/
function function_7c9dd642()
{
	/#
		while(!isdefined(level.var_a16c38d9))
		{
			wait(0.1);
		}
		path = "";
		cmd = "";
		keys = getarraykeys(level.var_a16c38d9);
		foreach(key in keys)
		{
			mapping = level.var_a16c38d9[key];
			num = pow(2, mapping.numbits);
			for(i = 0; i < num; i++)
			{
				cmdarg = (function_9e72a96(key) + "") + i;
				util::add_devgui(((path + function_9e72a96(key)) + "") + i, cmd + cmdarg);
			}
		}
		var_30a96cf9 = "";
		cmd = "";
		util::add_devgui(var_30a96cf9 + "", cmd + 1);
		util::add_devgui(var_30a96cf9 + "", cmd + 0);
	#/
}

/*
	Name: bunker_entrance_zoned
	Namespace: zm_devgui
	Checksum: 0x417EC1E8
	Offset: 0x10D08
	Size: 0x3D2
	Parameters: 0
	Flags: None
*/
function bunker_entrance_zoned()
{
	/#
		self notify("");
		self endon("");
		if(getdvarint(#"hash_4cebb1d3b0ee545a", 0) == 0)
		{
			setdvar(#"hash_4cebb1d3b0ee545a", 1);
		}
		else
		{
			setdvar(#"hash_4cebb1d3b0ee545a", 0);
			return;
		}
		a_s_key = struct::get_array(1, "");
		a_e_all = getentitiesinradius((0, 0, 0), 640000);
		a_e_key = [];
		foreach(ent in a_e_all)
		{
			if(isdefined(ent.var_61330f48) && ent.var_61330f48)
			{
				array::add(a_e_key, ent);
			}
		}
		a_key = arraycombine(a_s_key, a_e_key, 0, 0);
		while(getdvarint(#"hash_4cebb1d3b0ee545a", 0))
		{
			foreach(key in a_key)
			{
				var_91d1913b = distance2d(level.players[0].origin, key.origin);
				n_radius = 0.015 * var_91d1913b;
				if(n_radius > 768)
				{
					n_radius = 768;
				}
				if(var_91d1913b > 64 && var_91d1913b < 2000)
				{
					v_color = (0, 0, 1);
					if(isdefined(key.targetname))
					{
						str_type = function_9e72a96(key.targetname);
					}
					else
					{
						if(isdefined(key.model))
						{
							str_type = function_9e72a96(key.model);
						}
						else
						{
							str_type = key.origin;
						}
					}
					sphere(key.origin, n_radius, v_color);
					print3d(key.origin + (0, 0, 24), str_type, v_color);
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_1b531660
	Namespace: zm_devgui
	Checksum: 0xB861E774
	Offset: 0x110E8
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function function_1b531660()
{
	/#
		if(!isdefined(level.var_77e1430c))
		{
			level.var_77e1430c = 0;
		}
		level.var_77e1430c = !level.var_77e1430c;
		if(level.var_77e1430c)
		{
			callback::on_ai_damage(&function_e7321799);
		}
		else
		{
			callback::remove_on_ai_damage(&function_e7321799);
		}
	#/
}

/*
	Name: function_e7321799
	Namespace: zm_devgui
	Checksum: 0x35A0423A
	Offset: 0x11180
	Size: 0x10C
	Parameters: 1
	Flags: None
*/
function function_e7321799(params)
{
	/#
		damage = params.idamage;
		location = params.vpoint;
		target = self;
		smeansofdeath = params.smeansofdeath;
		if(smeansofdeath == "" || smeansofdeath == "")
		{
			location = self.origin + vectorscale((0, 0, 1), 60);
		}
		if(damage)
		{
			thread function_2cde0af9("" + damage, (1, 1, 1), location, (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 2), 30);
		}
	#/
}

/*
	Name: function_2cde0af9
	Namespace: zm_devgui
	Checksum: 0x4FF3775A
	Offset: 0x11298
	Size: 0xCC
	Parameters: 5
	Flags: None
*/
function function_2cde0af9(text, color, start, velocity, frames)
{
	/#
		location = start;
		alpha = 1;
		for(i = 0; i < frames; i++)
		{
			print3d(location, text, color, alpha, 0.6, 1);
			location = location + velocity;
			alpha = alpha - (1 / (frames * 2));
			waitframe(1);
		}
	#/
}

/*
	Name: function_61a7bb28
	Namespace: zm_devgui
	Checksum: 0xB781CEAB
	Offset: 0x11370
	Size: 0x168
	Parameters: 0
	Flags: None
*/
function function_61a7bb28()
{
	/#
		foreach(e_player in getplayers())
		{
			if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate !== "")
			{
				weapon = e_player getcurrentweapon();
				if(weaponhasattachment(weapon, ""))
				{
					continue;
				}
				weapon = getweapon(weapon.name, arraycombine(weapon.attachments, array(""), 0, 0));
				e_player function_2d4d7fd9(weapon);
				e_player function_f45a88df(weapon);
			}
		}
	#/
}

/*
	Name: function_986a2585
	Namespace: zm_devgui
	Checksum: 0x5B5AD82F
	Offset: 0x114E0
	Size: 0x108
	Parameters: 0
	Flags: None
*/
function function_986a2585()
{
	/#
		foreach(e_player in getplayers())
		{
			if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate !== "")
			{
				weapon = e_player getcurrentweapon();
				if(!weaponhasattachment(weapon, ""))
				{
					continue;
				}
				e_player function_3fb8b14(weapon, 1);
			}
		}
	#/
}

/*
	Name: function_184b9c6a
	Namespace: zm_devgui
	Checksum: 0xDDCC8491
	Offset: 0x115F0
	Size: 0x100
	Parameters: 0
	Flags: None
*/
function function_184b9c6a()
{
	/#
		foreach(e_player in getplayers())
		{
			if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate !== "")
			{
				weapon = e_player getcurrentweapon();
				if(!weaponhasattachment(weapon, ""))
				{
					continue;
				}
				e_player function_f45a88df(weapon);
			}
		}
	#/
}

/*
	Name: function_f45a88df
	Namespace: zm_devgui
	Checksum: 0x3A7E65EC
	Offset: 0x116F8
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_f45a88df(weapon)
{
	/#
		var_fd8cbdfd = self function_ddd45573(weapon);
		if(!isdefined(var_fd8cbdfd) || var_fd8cbdfd == 0)
		{
			var_fd8cbdfd = 1;
		}
		else
		{
			var_fd8cbdfd++;
		}
		self function_3fb8b14(weapon, var_fd8cbdfd);
	#/
}

/*
	Name: function_faf7abce
	Namespace: zm_devgui
	Checksum: 0x569401E
	Offset: 0x11778
	Size: 0x128
	Parameters: 0
	Flags: None
*/
function function_faf7abce()
{
	/#
		foreach(e_player in getplayers())
		{
			if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate !== "")
			{
				weapon = e_player getcurrentweapon();
				var_1c3b8b11 = e_player function_b1298bfb(weapon);
				if(!isdefined(var_1c3b8b11) || var_1c3b8b11 == 0)
				{
					var_1c3b8b11 = 1;
				}
				else
				{
					var_1c3b8b11++;
				}
				e_player function_a85d2581(weapon, var_1c3b8b11);
			}
		}
	#/
}

