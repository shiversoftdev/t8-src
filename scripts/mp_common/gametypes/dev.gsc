// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_269e356734524812;
#using script_383a3b1bb18ba876;
#using script_3fda550bc6e1089a;
#using script_68d2ee1489345a1d;
#using script_6b93dd1f0ad89d91;
#using script_6c8abe14025b47c4;
#using script_788472602edbe3b9;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\dev_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\perks.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\sound_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\devgui.gsc;
#using scripts\mp_common\gametypes\dev_class.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\util.gsc;

#namespace dev;

/*
	Name: function_89f2df9
	Namespace: dev
	Checksum: 0xFC91A826
	Offset: 0x130
	Size: 0x4C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	/#
		system::register(#"dev", &__init__, undefined, #"spawning_shared");
	#/
}

/*
	Name: __init__
	Namespace: dev
	Checksum: 0x1FC3F2AE
	Offset: 0x188
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::on_start_gametype(&init);
	callback::on_connect(&on_player_connected);
	/#
		level.devongetormakebot = &getormakebot;
	#/
}

/*
	Name: init
	Namespace: dev
	Checksum: 0x2712DA1E
	Offset: 0x1F0
	Size: 0x3C0
	Parameters: 0
	Flags: Linked
*/
function init()
{
	/#
		if(getdvarstring(#"scr_show_hq_spawns") == "")
		{
			setdvar(#"scr_show_hq_spawns", "");
		}
		if(!isdefined(getdvar(#"scr_testscriptruntimeerror")))
		{
			setdvar(#"scr_testscriptruntimeerror", "");
		}
		if(getdvarstring(#"hash_42bc2c660a3d2ecd") == "")
		{
			setdvar(#"hash_42bc2c660a3d2ecd", "");
		}
		thread testscriptruntimeerror();
		thread testdvars();
		thread addenemyheli();
		thread addtestcarepackage();
		thread devhelipathdebugdraw();
		thread devstraferunpathdebugdraw();
		thread dev_class::dev_cac_init();
		thread namespace_af53555a::function_d8049496();
		thread globallogic_score::setplayermomentumdebug();
		setdvar(#"scr_giveperk", "");
		setdvar(#"scr_forceevent", "");
		setdvar(#"scr_draw_triggers", 0);
		setdvar(#"hash_69042953f03fb8a4", "");
		thread engagement_distance_debug_toggle();
		thread equipment_dev_gui();
		thread grenade_dev_gui();
		setdvar(#"debug_dynamic_ai_spawning", 0);
		level.dem_spawns = [];
		if(level.gametype == "")
		{
			extra_spawns = [];
			extra_spawns[0] = "";
			extra_spawns[1] = "";
			extra_spawns[2] = "";
			extra_spawns[3] = "";
			for(i = 0; i < extra_spawns.size; i++)
			{
				points = getentarray(extra_spawns[i], "");
				if(isdefined(points) && points.size > 0)
				{
					level.dem_spawns = arraycombine(level.dem_spawns, points, 1, 0);
				}
			}
		}
		for(;;)
		{
			updatedevsettings();
			wait(0.5);
		}
	#/
}

/*
	Name: on_player_connected
	Namespace: dev
	Checksum: 0x86AF49B6
	Offset: 0x5B8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function on_player_connected()
{
	/#
		if(isdefined(level.devgui_unlimited_ammo) && level.devgui_unlimited_ammo)
		{
			wait(1);
			self thread devgui_unlimited_ammo();
		}
	#/
}

/*
	Name: updatehardpoints
	Namespace: dev
	Checksum: 0xB47B5E1E
	Offset: 0x608
	Size: 0x3E6
	Parameters: 0
	Flags: None
*/
function updatehardpoints()
{
	/#
		keys = getarraykeys(level.killstreaks);
		for(i = 0; i < keys.size; i++)
		{
			dvar = level.killstreaks[keys[i]].devdvar;
			enemydvar = level.killstreaks[keys[i]].devenemydvar;
			host = util::gethostplayer();
			if(isdefined(dvar) && getdvarint(dvar, 0) == 1)
			{
				foreach(player in level.players)
				{
					if(isdefined(level.usingmomentum) && level.usingmomentum && (isdefined(level.usingscorestreaks) && level.usingscorestreaks))
					{
						player killstreaks::give(keys[i]);
						continue;
					}
					if(isbot(player))
					{
						player.bot[#"killstreaks"] = [];
						player.bot[#"killstreaks"][0] = killstreaks::get_menu_name(keys[i]);
						killstreakweapon = killstreaks::get_killstreak_weapon(keys[i]);
						player killstreaks::give_weapon(killstreakweapon, 1);
						globallogic_score::_setplayermomentum(player, 2000);
						continue;
					}
					player killstreaks::give(keys[i]);
				}
				setdvar(dvar, 0);
			}
			if(isdefined(enemydvar) && getdvarint(enemydvar, 0) == 1)
			{
				team = "";
				player = util::gethostplayer();
				if(isdefined(player.team))
				{
					team = util::getotherteam(player.team);
				}
				ent = getormakebot(team);
				if(!isdefined(ent))
				{
					println("");
					continue;
				}
				wait(1);
				if(isbot(ent))
				{
					ent killstreaks::give(keys[i]);
				}
				else
				{
					ent killstreaks::give(keys[i]);
				}
				setdvar(enemydvar, 0);
			}
		}
	#/
}

/*
	Name: warpalltohost
	Namespace: dev
	Checksum: 0xEB186FCF
	Offset: 0x9F8
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function warpalltohost(team)
{
	/#
		host = util::gethostplayer();
		players = getplayers();
		function_30d59c86(team, host, players);
	#/
}

/*
	Name: warpalltoplayer
	Namespace: dev
	Checksum: 0x351897D5
	Offset: 0xA70
	Size: 0xB4
	Parameters: 2
	Flags: None
*/
function warpalltoplayer(team, player)
{
	/#
		players = getplayers();
		target = undefined;
		for(i = 0; i < players.size; i++)
		{
			if(players[i].name == player)
			{
				target = players[i];
				break;
			}
		}
		function_30d59c86(team, player, players);
	#/
}

/*
	Name: function_9758857b
	Namespace: dev
	Checksum: 0xDB1372BC
	Offset: 0xB30
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_9758857b()
{
	/#
		host = util::gethostplayer();
		function_e8b29265(host);
	#/
}

/*
	Name: function_e8b29265
	Namespace: dev
	Checksum: 0x4E89ACD1
	Offset: 0xB78
	Size: 0x144
	Parameters: 1
	Flags: None
*/
function function_e8b29265(player)
{
	/#
		players = [];
		foreach(team in level.teams)
		{
			players_on_team = getplayers(team);
			foreach(person in players_on_team)
			{
				if(isalive(person))
				{
					players[players.size] = person;
					break;
				}
			}
		}
		function_30d59c86(undefined, player, players);
	#/
}

/*
	Name: function_30d59c86
	Namespace: dev
	Checksum: 0x6CAED7B4
	Offset: 0xCC8
	Size: 0x34C
	Parameters: 3
	Flags: None
*/
function function_30d59c86(team, target, players)
{
	/#
		if(isdefined(target))
		{
			origin = target.origin;
			nodes = getnodesinradius(origin, 128, 32, 128, #"path");
			angles = target getplayerangles();
			yaw = (0, angles[1], 0);
			forward = anglestoforward(yaw);
			spawn_origin = (origin + (forward * 128)) + vectorscale((0, 0, 1), 16);
			if(!bullettracepassed(target geteye(), spawn_origin, 0, target))
			{
				spawn_origin = undefined;
			}
			for(i = 0; i < players.size; i++)
			{
				if(players[i] == target)
				{
					continue;
				}
				if(isdefined(team))
				{
					if(strstartswith(team, "") && target.team == players[i].team)
					{
						continue;
					}
					if(strstartswith(team, "") && target.team != players[i].team)
					{
						continue;
					}
				}
				goal = undefined;
				if(isdefined(spawn_origin))
				{
					players[i] setorigin(spawn_origin);
					goal = spawn_origin;
				}
				else if(nodes.size > 0)
				{
					node = array::random(nodes);
					players[i] setorigin(node.origin);
					goal = node;
				}
				else
				{
					players[i] setorigin(origin);
					goal = origin;
				}
				if(isdefined(goal) && isbot(players[i]))
				{
					players[i] setgoal(goal, 1);
				}
			}
		}
		setdvar(#"scr_playerwarp", "");
	#/
}

/*
	Name: updatedevsettingszm
	Namespace: dev
	Checksum: 0xE9371C9B
	Offset: 0x1020
	Size: 0x41C
	Parameters: 0
	Flags: None
*/
function updatedevsettingszm()
{
	/#
		if(level.players.size > 0)
		{
			if(getdvarint(#"r_streamdumpdistance", 0) == 3)
			{
				if(!isdefined(level.streamdumpteamindex))
				{
					level.streamdumpteamindex = 0;
				}
				else
				{
					level.streamdumpteamindex++;
				}
				numpoints = 0;
				spawnpoints = [];
				location = level.scr_zm_map_start_location;
				if(location == "" || location == "" && isdefined(level.default_start_location))
				{
					location = level.default_start_location;
				}
				match_string = (level.scr_zm_ui_gametype + "") + location;
				if(level.streamdumpteamindex < level.teams.size)
				{
					structs = struct::get_array("", "");
					if(isdefined(structs))
					{
						foreach(struct in structs)
						{
							if(isdefined(struct.script_string))
							{
								tokens = strtok(struct.script_string, "");
								foreach(token in tokens)
								{
									if(token == match_string)
									{
										spawnpoints[spawnpoints.size] = struct;
									}
								}
							}
						}
					}
					if(!isdefined(spawnpoints) || spawnpoints.size == 0)
					{
						spawnpoints = struct::get_array("", "");
					}
					if(isdefined(spawnpoints))
					{
						numpoints = spawnpoints.size;
					}
				}
				if(numpoints == 0)
				{
					setdvar(#"r_streamdumpdistance", 0);
					level.streamdumpteamindex = -1;
				}
				else
				{
					averageorigin = (0, 0, 0);
					averageangles = (0, 0, 0);
					foreach(spawnpoint in spawnpoints)
					{
						averageorigin = averageorigin + (spawnpoint.origin / numpoints);
						averageangles = averageangles + (spawnpoint.angles / numpoints);
					}
					level.players[0] setplayerangles(averageangles);
					level.players[0] setorigin(averageorigin);
					wait(5);
					setdvar(#"r_streamdumpdistance", 2);
				}
			}
		}
	#/
}

/*
	Name: updatedevsettings
	Namespace: dev
	Checksum: 0x59F25F8A
	Offset: 0x1448
	Size: 0x2684
	Parameters: 0
	Flags: None
*/
function updatedevsettings()
{
	/#
		player = util::gethostplayer();
		namespace_af53555a::function_c28b3d26();
		updateminimapsetting();
		if(level.players.size > 0)
		{
			updatehardpoints();
			playerwarp_string = getdvarstring(#"scr_playerwarp");
			if(playerwarp_string == "")
			{
				warpalltohost();
			}
			else if(playerwarp_string == "")
			{
				warpalltohost(playerwarp_string);
			}
			else if(playerwarp_string == "")
			{
				warpalltohost(playerwarp_string);
			}
			else if(playerwarp_string == "")
			{
				function_9758857b();
			}
			else if(strstartswith(playerwarp_string, ""))
			{
				name = getsubstr(playerwarp_string, 8);
				warpalltoplayer(playerwarp_string, name);
			}
			else if(strstartswith(playerwarp_string, ""))
			{
				name = getsubstr(playerwarp_string, 11);
				warpalltoplayer(playerwarp_string, name);
			}
			else if(strstartswith(playerwarp_string, ""))
			{
				name = getsubstr(playerwarp_string, 4);
				warpalltoplayer(undefined, name);
			}
			else if(playerwarp_string == "")
			{
				players = getplayers();
				setdvar(#"scr_playerwarp", "");
				if(!isdefined(level.devgui_start_spawn_index))
				{
					level.devgui_start_spawn_index = 0;
				}
				player = util::gethostplayer();
				spawns = level.spawn_start[player.pers[#"team"]];
				if(!isdefined(spawns) || spawns.size <= 0)
				{
					return;
				}
				for(i = 0; i < players.size; i++)
				{
					players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
					players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
				}
				level.devgui_start_spawn_index++;
				if(level.devgui_start_spawn_index >= spawns.size)
				{
					level.devgui_start_spawn_index = 0;
				}
			}
			else if(playerwarp_string == "")
			{
				players = getplayers();
				setdvar(#"scr_playerwarp", "");
				if(!isdefined(level.devgui_start_spawn_index))
				{
					level.devgui_start_spawn_index = 0;
				}
				player = util::gethostplayer();
				spawns = level.spawn_start[player.pers[#"team"]];
				if(!isdefined(spawns) || spawns.size <= 0)
				{
					return;
				}
				for(i = 0; i < players.size; i++)
				{
					players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
					players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
				}
				level.devgui_start_spawn_index--;
				if(level.devgui_start_spawn_index < 0)
				{
					level.devgui_start_spawn_index = spawns.size - 1;
				}
			}
			else if(playerwarp_string == "")
			{
				players = getplayers();
				setdvar(#"scr_playerwarp", "");
				if(!isdefined(level.devgui_spawn_index))
				{
					level.devgui_spawn_index = 0;
				}
				spawns = (isdefined(level.var_3da2623a) ? level.var_3da2623a : level.spawnpoints);
				spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
				if(!isdefined(spawns) || spawns.size <= 0)
				{
					return;
				}
				for(i = 0; i < players.size; i++)
				{
					players[i] setorigin(spawns[level.devgui_spawn_index].origin);
					players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
				}
				level.devgui_spawn_index++;
				if(level.devgui_spawn_index >= spawns.size)
				{
					level.devgui_spawn_index = 0;
				}
			}
			else if(playerwarp_string == "")
			{
				players = getplayers();
				setdvar(#"scr_playerwarp", "");
				if(!isdefined(level.devgui_spawn_index))
				{
					level.devgui_spawn_index = 0;
				}
				spawns = (isdefined(level.var_3da2623a) ? level.var_3da2623a : level.spawnpoints);
				spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
				if(!isdefined(spawns) || spawns.size <= 0)
				{
					return;
				}
				for(i = 0; i < players.size; i++)
				{
					players[i] setorigin(spawns[level.devgui_spawn_index].origin);
					players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
				}
				level.devgui_spawn_index--;
				if(level.devgui_spawn_index < 0)
				{
					level.devgui_spawn_index = spawns.size - 1;
				}
			}
			else if(getdvarstring(#"scr_devgui_spawn") != "")
			{
				player = util::gethostplayer();
				if(!isdefined(player.devgui_spawn_active))
				{
					player.devgui_spawn_active = 0;
				}
				if(!player.devgui_spawn_active)
				{
					iprintln("");
					iprintln("");
					player.devgui_spawn_active = 1;
					player thread devgui_spawn_think();
				}
				else
				{
					player notify(#"devgui_spawn_think");
					player.devgui_spawn_active = 0;
					player setactionslot(3, "");
				}
				setdvar(#"scr_devgui_spawn", "");
			}
			else if(getdvarstring(#"hash_c9f8ff06a656024") != "")
			{
				player = util::gethostplayer();
				if(!isdefined(player.var_31922da4))
				{
					player.var_31922da4 = 0;
				}
				if(!player.var_31922da4)
				{
					iprintln("");
					iprintln("");
					player.var_31922da4 = 1;
					player thread function_48a6b85();
				}
				else
				{
					player notify(#"hash_47f3d9a9e91670d1");
					player.var_31922da4 = 0;
					player setactionslot(3, "");
				}
				setdvar(#"hash_c9f8ff06a656024", "");
			}
			else if(getdvarstring(#"scr_player_ammo") != "")
			{
				players = getplayers();
				if(!isdefined(level.devgui_unlimited_ammo))
				{
					level.devgui_unlimited_ammo = 1;
				}
				else
				{
					level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
				}
				if(level.devgui_unlimited_ammo)
				{
					iprintln("");
				}
				else
				{
					iprintln("");
				}
				for(i = 0; i < players.size; i++)
				{
					if(level.devgui_unlimited_ammo)
					{
						players[i] thread devgui_unlimited_ammo();
						continue;
					}
					players[i] notify(#"devgui_unlimited_ammo");
				}
				setdvar(#"scr_player_ammo", "");
			}
			else if(getdvarstring(#"scr_player_momentum") != "")
			{
				if(!isdefined(level.devgui_unlimited_momentum))
				{
					level.devgui_unlimited_momentum = 1;
				}
				else
				{
					level.devgui_unlimited_momentum = !level.devgui_unlimited_momentum;
				}
				if(level.devgui_unlimited_momentum)
				{
					iprintln("");
					level thread devgui_unlimited_momentum();
				}
				else
				{
					iprintln("");
					level notify(#"devgui_unlimited_momentum");
				}
				setdvar(#"scr_player_momentum", "");
			}
			else if(getdvarstring(#"scr_give_player_score") != "")
			{
				level thread devgui_increase_momentum(getdvarint(#"scr_give_player_score", 0));
				setdvar(#"scr_give_player_score", "");
			}
			else if(getdvarstring(#"hash_7d7add0fb8d419c8") != "")
			{
				level thread function_e88bdbcf();
				setdvar(#"hash_7d7add0fb8d419c8", "");
			}
			else if(getdvarstring(#"scr_player_zero_ammo") != "")
			{
				players = getplayers();
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					weapons = player getweaponslist();
					arrayremovevalue(weapons, level.weaponbasemelee);
					for(j = 0; j < weapons.size; j++)
					{
						if(weapons[j] == level.weaponnone)
						{
							continue;
						}
						player setweaponammostock(weapons[j], 0);
						player setweaponammoclip(weapons[j], 0);
					}
				}
				setdvar(#"scr_player_zero_ammo", "");
			}
			else if(getdvarstring(#"scr_emp_jammed") != "")
			{
				players = getplayers();
				for(i = 0; i < players.size; i++)
				{
					player = players[i];
					player setempjammed(getdvarint(#"scr_emp_jammed", 0));
				}
				setdvar(#"scr_emp_jammed", "");
			}
			else if(getdvarstring(#"scr_round_pause") != "")
			{
				if(!level.timerstopped)
				{
					iprintln("");
					globallogic_utils::pausetimer();
				}
				else
				{
					iprintln("");
					globallogic_utils::resumetimer();
				}
				setdvar(#"scr_round_pause", "");
			}
			else if(getdvarstring(#"scr_round_end") != "")
			{
				level globallogic::forceend();
				setdvar(#"scr_round_end", "");
			}
			else if(getdvarint(#"scr_health_debug", 0))
			{
				players = getplayers();
				host = util::gethostplayer();
				if(!isdefined(host.devgui_health_debug))
				{
					host.devgui_health_debug = 0;
				}
				if(host.devgui_health_debug)
				{
					host.devgui_health_debug = 0;
					for(i = 0; i < players.size; i++)
					{
						players[i] notify(#"devgui_health_debug");
						if(isdefined(players[i].debug_health_bar))
						{
							players[i].debug_health_bar destroy();
							players[i].debug_health_text destroy();
							players[i].debug_health_bar = undefined;
							players[i].debug_health_text = undefined;
						}
					}
				}
				else
				{
					host.devgui_health_debug = 1;
					for(i = 0; i < players.size; i++)
					{
						players[i] thread devgui_health_debug();
					}
				}
				setdvar(#"scr_health_debug", 0);
			}
			else if(getdvarstring(#"scr_show_hq_spawns") != "")
			{
				if(!isdefined(level.devgui_show_hq))
				{
					level.devgui_show_hq = 0;
				}
				if(level.gametype == "" && isdefined(level.radios))
				{
					if(!level.devgui_show_hq)
					{
						for(i = 0; i < level.radios.size; i++)
						{
							color = (1, 0, 0);
							level namespace_af53555a::showonespawnpoint(level.radios[i], color, "", 32, "");
						}
					}
					else
					{
						level notify(#"hide_hq_points");
					}
					level.devgui_show_hq = !level.devgui_show_hq;
				}
				setdvar(#"scr_show_hq_spawns", "");
			}
			if(getdvarint(#"r_streamdumpdistance", 0) == 3)
			{
				if(!isdefined(level.streamdumpteamindex))
				{
					level.streamdumpteamindex = 0;
				}
				else
				{
					level.streamdumpteamindex++;
				}
				numpoints = 0;
				if(level.streamdumpteamindex < level.teams.size)
				{
					teamname = getarraykeys(level.teams)[level.streamdumpteamindex];
					if(isdefined(level.spawn_start[teamname]))
					{
						numpoints = level.spawn_start[teamname].size;
					}
				}
				if(numpoints == 0)
				{
					setdvar(#"r_streamdumpdistance", 0);
					level.streamdumpteamindex = -1;
				}
				else
				{
					averageorigin = (0, 0, 0);
					averageangles = (0, 0, 0);
					foreach(spawnpoint in level.spawn_start[teamname])
					{
						averageorigin = averageorigin + (spawnpoint.origin / numpoints);
						averageangles = averageangles + (spawnpoint.angles / numpoints);
					}
					level.players[0] setplayerangles(averageangles);
					level.players[0] setorigin(averageorigin);
					wait(5);
					setdvar(#"r_streamdumpdistance", 2);
				}
			}
		}
		if(getdvarstring(#"scr_giveperk") == "")
		{
			players = getplayers();
			iprintln("");
			for(i = 0; i < players.size; i++)
			{
				players[i] clearperks();
				players[i].extraperks = undefined;
			}
			setdvar(#"scr_giveperk", "");
		}
		if(getdvarstring(#"scr_giveperk") != "")
		{
			perk = getdvarstring(#"scr_giveperk");
			specialties = strtok(perk, "");
			players = getplayers();
			iprintln(("" + perk) + "");
			for(i = 0; i < players.size; i++)
			{
				for(j = 0; j < specialties.size; j++)
				{
					players[i] perks::function_7637bafa(specialties[j]);
					players[i].extraperks[specialties[j]] = 1;
				}
			}
			setdvar(#"scr_giveperk", "");
		}
		if(getdvarstring(#"hash_2d9131ec76baa766") == "")
		{
			players = getplayers();
			iprintln("");
			foreach(player in players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				player function_e6f9e3cd();
				player loadout::function_3d16577a(player.team, player.curclass);
			}
			setdvar(#"hash_2d9131ec76baa766", "");
		}
		if(getdvarstring(#"hash_2d9131ec76baa766") != "")
		{
			talentname = getdvarstring(#"hash_2d9131ec76baa766");
			var_2fe3f7e3 = hash(talentname);
			players = getplayers();
			iprintln(("" + talentname) + "");
			foreach(player in players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				player function_b5feff95(var_2fe3f7e3);
				player loadout::function_3d16577a(player.team, player.curclass);
			}
			setdvar(#"hash_2d9131ec76baa766", "");
		}
		if(getdvarstring(#"hash_5b311cf6da67afb") == "")
		{
			players = getplayers();
			iprintln("");
			foreach(player in players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				player function_e6f9e3cd();
				player loadout::function_3d16577a(player.team, player.curclass);
			}
			setdvar(#"hash_5b311cf6da67afb", "");
		}
		if(getdvarstring(#"hash_5b311cf6da67afb") != "")
		{
			talentname = getdvarstring(#"hash_5b311cf6da67afb");
			var_2fe3f7e3 = hash(talentname);
			players = getplayers();
			iprintln(("" + talentname) + "");
			foreach(player in players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				player function_b5feff95(var_2fe3f7e3);
				player loadout::function_3d16577a(player.team, player.curclass);
			}
			setdvar(#"hash_5b311cf6da67afb", "");
		}
		if(getdvarstring(#"scr_forcegrenade") != "")
		{
			force_grenade_throw(getweapon(getdvarstring(#"scr_forcegrenade")));
			setdvar(#"scr_forcegrenade", "");
		}
		if(getdvarstring(#"scr_forceevent") != "")
		{
			event = getdvarstring(#"scr_forceevent");
			player = util::gethostplayer();
			forward = anglestoforward(player.angles);
			right = anglestoright(player.angles);
			if(event == "")
			{
				player dodamage(1, player.origin + forward);
			}
			else if(event == "")
			{
				player dodamage(1, player.origin - forward);
			}
			else if(event == "")
			{
				player dodamage(1, player.origin - right);
			}
			else if(event == "")
			{
				player dodamage(1, player.origin + right);
			}
			setdvar(#"scr_forceevent", "");
		}
		if(getdvarstring(#"scr_takeperk") != "")
		{
			perk = getdvarstring(#"scr_takeperk");
			for(i = 0; i < level.players.size; i++)
			{
				level.players[i] perks::function_45d12554(perk);
				level.players[i].extraperks[perk] = undefined;
			}
			setdvar(#"scr_takeperk", "");
		}
		if(getdvarstring(#"scr_x_kills_y") != "")
		{
			nametokens = strtok(getdvarstring(#"scr_x_kills_y"), "");
			if(nametokens.size > 1)
			{
				thread xkillsy(nametokens[0], nametokens[1]);
			}
			setdvar(#"scr_x_kills_y", "");
		}
		if(getdvarstring(#"scr_usedogs") != "")
		{
			ownername = getdvarstring(#"scr_usedogs");
			setdvar(#"scr_usedogs", "");
			owner = undefined;
			for(index = 0; index < level.players.size; index++)
			{
				if(level.players[index].name == ownername)
				{
					owner = level.players[index];
				}
			}
			if(isdefined(owner))
			{
				owner killstreaks::trigger_killstreak("");
			}
		}
		if(getdvarstring(#"scr_entdebug") != "")
		{
			ents = getentarray();
			level.entarray = [];
			level.entcounts = [];
			level.entgroups = [];
			for(index = 0; index < ents.size; index++)
			{
				classname = ents[index].classname;
				if(!issubstr(classname, ""))
				{
					curent = ents[index];
					level.entarray[level.entarray.size] = curent;
					if(!isdefined(level.entcounts[classname]))
					{
						level.entcounts[classname] = 0;
					}
					level.entcounts[classname]++;
					if(!isdefined(level.entgroups[classname]))
					{
						level.entgroups[classname] = [];
					}
					level.entgroups[classname][level.entgroups[classname].size] = curent;
				}
			}
		}
		if(getdvarint(#"debug_dynamic_ai_spawning", 0) && !isdefined(level.larry))
		{
			thread larry_thread();
		}
		else if(!getdvarint(#"debug_dynamic_ai_spawning", 0))
		{
			level notify(#"kill_larry");
		}
		if(getdvarint(#"scr_force_finalkillcam", 0) == 1)
		{
			level thread killcam::do_final_killcam();
			level thread waitthennotifyfinalkillcam();
		}
		if(getdvarint(#"scr_force_roundkillcam", 0) == 1)
		{
			level thread killcam::do_final_killcam();
			level thread waitthennotifyroundkillcam();
		}
		potm::debugupdate();
	#/
}

/*
	Name: waitthennotifyroundkillcam
	Namespace: dev
	Checksum: 0xD8E8E590
	Offset: 0x3AD8
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function waitthennotifyroundkillcam()
{
	/#
		waitframe(1);
		level notify(#"play_final_killcam");
		setdvar(#"scr_force_roundkillcam", 0);
	#/
}

/*
	Name: waitthennotifyfinalkillcam
	Namespace: dev
	Checksum: 0xDE174349
	Offset: 0x3B28
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function waitthennotifyfinalkillcam()
{
	/#
		waitframe(1);
		level notify(#"play_final_killcam");
		waitframe(1);
		setdvar(#"scr_force_finalkillcam", 0);
	#/
}

/*
	Name: function_48a6b85
	Namespace: dev
	Checksum: 0x7C5100A1
	Offset: 0x3B80
	Size: 0x976
	Parameters: 0
	Flags: None
*/
function function_48a6b85()
{
	/#
		self notify("");
		self endon("");
		self endon(#"disconnect");
		dpad_left = 0;
		dpad_right = 0;
		dpad_up = 0;
		dpad_down = 0;
		if(!isdefined(level.var_94f4ca81))
		{
			level.var_94f4ca81 = spawnstruct();
			level.var_94f4ca81.var_e3c223f5 = [];
			var_2e980658 = spawnstruct();
			var_2e980658.name = "";
			var_2e980658.spawns = level.spawnpoints;
			level.var_94f4ca81.var_e3c223f5[0] = var_2e980658;
			var_bc7d1357 = spawnstruct();
			var_bc7d1357.name = "";
			var_bc7d1357.spawns = level.spawn_start[#"allies"];
			level.var_94f4ca81.var_e3c223f5[1] = var_bc7d1357;
			var_2a1cb802 = spawnstruct();
			var_2a1cb802.name = "";
			var_2a1cb802.spawns = level.spawn_start[#"axis"];
			level.var_94f4ca81.var_e3c223f5[2] = var_2a1cb802;
			var_c95c8eff = spawnstruct();
			var_c95c8eff.name = "";
			var_c95c8eff.spawns = level.allspawnpoints;
			level.var_94f4ca81.var_e3c223f5[3] = var_c95c8eff;
		}
		level.var_94f4ca81.var_89266507 = "";
		level.var_94f4ca81.var_1fde6598 = 0;
		level.var_94f4ca81.var_64799f7 = 0;
		var_f94a23 = 0;
		while(true)
		{
			self setactionslot(3, "");
			self setactionslot(4, "");
			if(!dpad_up && self buttonpressed(""))
			{
				level.var_94f4ca81.var_1fde6598++;
				if(level.var_94f4ca81.var_1fde6598 >= level.var_94f4ca81.var_e3c223f5.size)
				{
					level.var_94f4ca81.var_1fde6598 = 0;
				}
				level.var_94f4ca81.var_64799f7 = 0;
				dpad_up = 1;
				var_f94a23 = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_up = 0;
			}
			if(!dpad_down && self buttonpressed(""))
			{
				level.var_94f4ca81.var_1fde6598--;
				if(level.var_94f4ca81.var_1fde6598 < 0)
				{
					level.var_94f4ca81.var_1fde6598 = level.var_94f4ca81.var_e3c223f5.size - 1;
				}
				level.var_94f4ca81.var_64799f7 = 0;
				var_f94a23 = 1;
				dpad_down = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_down = 0;
			}
			if(!dpad_left && self buttonpressed(""))
			{
				while(true)
				{
					level.var_94f4ca81.var_64799f7--;
					if(level.var_94f4ca81.var_64799f7 < 0)
					{
						level.var_94f4ca81.var_64799f7 = level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].spawns.size - 1;
					}
					if(!(isdefined(level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].ct) && level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].ct))
					{
						break;
					}
				}
				var_f94a23 = 1;
				dpad_left = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_left = 0;
			}
			if(!dpad_right && self buttonpressed(""))
			{
				while(true)
				{
					level.var_94f4ca81.var_64799f7++;
					if(level.var_94f4ca81.var_64799f7 >= level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].spawns.size)
					{
						level.var_94f4ca81.var_64799f7 = 0;
					}
					if(!(isdefined(level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].ct) && level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].ct))
					{
						break;
					}
				}
				var_f94a23 = 1;
				dpad_right = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_right = 0;
			}
			if(var_f94a23)
			{
				origin = level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].origin;
				angles = level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].spawns[level.var_94f4ca81.var_64799f7].angles;
				println("" + level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].name);
				self setorigin(origin);
				self setplayerangles(angles);
				var_f94a23 = 0;
			}
			debug2dtext((100, 750, 0), "" + level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].name, (1, 0, 0));
			debug2dtext((100, 800, 0), (("" + string(level.var_94f4ca81.var_64799f7)) + "") + string(level.var_94f4ca81.var_e3c223f5[level.var_94f4ca81.var_1fde6598].spawns.size), (1, 0, 0));
			waitframe(1);
		}
	#/
}

/*
	Name: devgui_spawn_think
	Namespace: dev
	Checksum: 0xA0B29BC9
	Offset: 0x4500
	Size: 0x2E6
	Parameters: 0
	Flags: None
*/
function devgui_spawn_think()
{
	/#
		self notify(#"devgui_spawn_think");
		self endon(#"devgui_spawn_think");
		self endon(#"disconnect");
		dpad_left = 0;
		dpad_right = 0;
		dpad_up = 0;
		dpad_down = 0;
		for(;;)
		{
			self setactionslot(3, "");
			self setactionslot(4, "");
			if(!dpad_left && self buttonpressed(""))
			{
				setdvar(#"scr_playerwarp", "");
				dpad_left = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_left = 0;
			}
			if(!dpad_right && self buttonpressed(""))
			{
				setdvar(#"scr_playerwarp", "");
				dpad_right = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_right = 0;
			}
			if(!dpad_up && self buttonpressed(""))
			{
				setdvar(#"scr_playerwarp", "");
				dpad_up = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_up = 0;
			}
			if(!dpad_down && self buttonpressed(""))
			{
				setdvar(#"scr_playerwarp", "");
				dpad_down = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_down = 0;
			}
			waitframe(1);
		}
	#/
}

/*
	Name: devgui_unlimited_ammo
	Namespace: dev
	Checksum: 0x58712DBA
	Offset: 0x47F0
	Size: 0x1AA
	Parameters: 0
	Flags: None
*/
function devgui_unlimited_ammo()
{
	/#
		self notify(#"devgui_unlimited_ammo");
		self endon(#"devgui_unlimited_ammo");
		self endon(#"disconnect");
		for(;;)
		{
			wait(1);
			primary_weapons = self getweaponslistprimaries();
			offhand_weapons_and_alts = array::exclude(self getweaponslist(1), primary_weapons);
			weapons = arraycombine(primary_weapons, offhand_weapons_and_alts, 0, 0);
			arrayremovevalue(weapons, level.weaponbasemelee);
			for(i = 0; i < weapons.size; i++)
			{
				weapon = weapons[i];
				if(weapon == level.weaponnone)
				{
					continue;
				}
				if(killstreaks::is_killstreak_weapon(weapon))
				{
					continue;
				}
				if(weapon.iscliponly)
				{
					continue;
				}
				if(self getfractionmaxammo(weapon) == 1)
				{
					continue;
				}
				self givemaxammo(weapon);
			}
		}
	#/
}

/*
	Name: devgui_unlimited_momentum
	Namespace: dev
	Checksum: 0xC5228D04
	Offset: 0x49A8
	Size: 0x11C
	Parameters: 0
	Flags: None
*/
function devgui_unlimited_momentum()
{
	/#
		level notify(#"devgui_unlimited_momentum");
		level endon(#"devgui_unlimited_momentum");
		for(;;)
		{
			wait(1);
			players = getplayers();
			foreach(player in players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				if(!isalive(player))
				{
					continue;
				}
				if(player.sessionstate != "")
				{
					continue;
				}
				globallogic_score::_setplayermomentum(player, 5000);
			}
		}
	#/
}

/*
	Name: devgui_increase_momentum
	Namespace: dev
	Checksum: 0xCCC4E4D0
	Offset: 0x4AD0
	Size: 0x108
	Parameters: 1
	Flags: None
*/
function devgui_increase_momentum(score)
{
	/#
		players = getplayers();
		foreach(player in players)
		{
			if(!isdefined(player))
			{
				continue;
			}
			if(!isalive(player))
			{
				continue;
			}
			if(player.sessionstate != "")
			{
				continue;
			}
			player globallogic_score::giveplayermomentumnotification(score, #"kill", "");
		}
	#/
}

/*
	Name: function_e88bdbcf
	Namespace: dev
	Checksum: 0x22CDFE0C
	Offset: 0x4BE0
	Size: 0xD8
	Parameters: 1
	Flags: None
*/
function function_e88bdbcf(score)
{
	/#
		players = getplayers();
		foreach(player in players)
		{
			if(isdefined(player) && isalive(player) && player.sessionstate == "")
			{
				player globallogic_score::function_49c10afe();
			}
		}
	#/
}

/*
	Name: devgui_health_debug
	Namespace: dev
	Checksum: 0x165D25B2
	Offset: 0x4CC0
	Size: 0x320
	Parameters: 0
	Flags: None
*/
function devgui_health_debug()
{
	/#
		self notify(#"devgui_health_debug");
		self endon(#"devgui_health_debug");
		self endon(#"disconnect");
		x = 80;
		y = 40;
		self.debug_health_bar = newdebughudelem(self);
		self.debug_health_bar.x = x + 80;
		self.debug_health_bar.y = y + 2;
		self.debug_health_bar.alignx = "";
		self.debug_health_bar.aligny = "";
		self.debug_health_bar.horzalign = "";
		self.debug_health_bar.vertalign = "";
		self.debug_health_bar.alpha = 1;
		self.debug_health_bar.foreground = 1;
		self.debug_health_bar setshader(#"black", 1, 8);
		self.debug_health_text = newdebughudelem(self);
		self.debug_health_text.x = x + 80;
		self.debug_health_text.y = y;
		self.debug_health_text.alignx = "";
		self.debug_health_text.aligny = "";
		self.debug_health_text.horzalign = "";
		self.debug_health_text.vertalign = "";
		self.debug_health_text.alpha = 1;
		self.debug_health_text.fontscale = 1;
		self.debug_health_text.foreground = 1;
		if(!isdefined(self.maxhealth) || self.maxhealth <= 0)
		{
			self.maxhealth = 100;
		}
		for(;;)
		{
			waitframe(1);
			width = (self.health / self.maxhealth) * 300;
			width = int(max(width, 1));
			self.debug_health_bar setshader(#"black", width, 8);
			self.debug_health_text setvalue(self.health);
		}
	#/
}

/*
	Name: giveextraperks
	Namespace: dev
	Checksum: 0x71BC8E79
	Offset: 0x4FE8
	Size: 0xBE
	Parameters: 0
	Flags: None
*/
function giveextraperks()
{
	/#
		if(!isdefined(self.extraperks))
		{
			return;
		}
		perks = getarraykeys(self.extraperks);
		for(i = 0; i < perks.size; i++)
		{
			/#
				println(((("" + self.name) + "") + perks[i]) + "");
			#/
			self perks::function_7637bafa(perks[i]);
		}
	#/
}

/*
	Name: xkillsy
	Namespace: dev
	Checksum: 0xBE4A02D0
	Offset: 0x50B0
	Size: 0x14C
	Parameters: 2
	Flags: None
*/
function xkillsy(attackername, victimname)
{
	/#
		attacker = undefined;
		victim = undefined;
		for(index = 0; index < level.players.size; index++)
		{
			if(level.players[index].name == attackername)
			{
				attacker = level.players[index];
				continue;
			}
			if(level.players[index].name == victimname)
			{
				victim = level.players[index];
			}
		}
		if(!isalive(attacker) || !isalive(victim))
		{
			return;
		}
		victim thread [[level.callbackplayerdamage]](attacker, attacker, 1000, 0, "", level.weaponnone, (0, 0, 0), (0, 0, 0), "", (0, 0, 0), 0, 0, (1, 0, 0));
	#/
}

/*
	Name: testscriptruntimeerrorassert
	Namespace: dev
	Checksum: 0xAC8BFB5
	Offset: 0x5208
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
	Name: testscriptruntimeassertmsgassert
	Namespace: dev
	Checksum: 0xFFC9024F
	Offset: 0x5238
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function testscriptruntimeassertmsgassert()
{
	/#
		wait(1);
		/#
			assertmsg("");
		#/
	#/
}

/*
	Name: testscriptruntimeerrormsgassert
	Namespace: dev
	Checksum: 0x6727EF9
	Offset: 0x5270
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function testscriptruntimeerrormsgassert()
{
	/#
		wait(1);
		/#
			errormsg("");
		#/
	#/
}

/*
	Name: testscriptruntimeerror2
	Namespace: dev
	Checksum: 0x719190C6
	Offset: 0x52A8
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
	Namespace: dev
	Checksum: 0xD5B8B887
	Offset: 0x52F8
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
	Namespace: dev
	Checksum: 0x4F5BD2D9
	Offset: 0x5320
	Size: 0x12C
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
		else if(myerror == "")
		{
			testscriptruntimeassertmsgassert();
		}
		else if(myerror == "")
		{
			testscriptruntimeerrormsgassert();
		}
		else
		{
			testscriptruntimeerror1();
		}
		thread testscriptruntimeerror();
	#/
}

/*
	Name: testdvars
	Namespace: dev
	Checksum: 0x8C34D7C7
	Offset: 0x5458
	Size: 0x104
	Parameters: 0
	Flags: None
*/
function testdvars()
{
	/#
		wait(5);
		for(;;)
		{
			if(getdvarstring(#"scr_testdvar") != "")
			{
				break;
			}
			wait(1);
		}
		tokens = strtok(getdvarstring(#"scr_testdvar"), "");
		dvarname = tokens[0];
		dvarvalue = tokens[1];
		setdvar(dvarname, dvarvalue);
		setdvar(#"scr_testdvar", "");
		thread testdvars();
	#/
}

/*
	Name: addenemyheli
	Namespace: dev
	Checksum: 0x2F864775
	Offset: 0x5568
	Size: 0x234
	Parameters: 0
	Flags: None
*/
function addenemyheli()
{
	/#
		wait(5);
		for(;;)
		{
			if(getdvarint(#"scr_spawnenemyheli", 0) > 0)
			{
				break;
			}
			wait(1);
		}
		enemyheli = getdvarint(#"scr_spawnenemyheli", 0);
		setdvar(#"scr_spawnenemyheli", 0);
		team = "";
		player = util::gethostplayer();
		if(isdefined(player.pers[#"team"]))
		{
			team = util::getotherteam(player.pers[#"team"]);
		}
		ent = getormakebot(team);
		if(!isdefined(ent))
		{
			println("");
			wait(1);
			thread addenemyheli();
			return;
		}
		switch(enemyheli)
		{
			case 1:
			{
				level.helilocation = ent.origin;
				ent thread helicopter::usekillstreakhelicopter("");
				wait(0.5);
				ent notify(#"confirm_location", {#position:level.helilocation});
				break;
			}
			case 2:
			{
				break;
			}
		}
		thread addenemyheli();
	#/
}

/*
	Name: getormakebot
	Namespace: dev
	Checksum: 0xBDDEF818
	Offset: 0x57A8
	Size: 0xD6
	Parameters: 1
	Flags: None
*/
function getormakebot(team)
{
	/#
		for(i = 0; i < level.players.size; i++)
		{
			if(level.players[i].team == team)
			{
				if(isbot(level.players[i]))
				{
					return level.players[i];
				}
			}
		}
		ent = bot::add_bot(team);
		if(isdefined(ent))
		{
			sound::play_on_players("");
			wait(1);
		}
		return ent;
	#/
}

/*
	Name: addtestcarepackage
	Namespace: dev
	Checksum: 0x60E92E2B
	Offset: 0x5888
	Size: 0x25C
	Parameters: 0
	Flags: None
*/
function addtestcarepackage()
{
	/#
		wait(5);
		for(;;)
		{
			if(getdvarint(#"scr_givetestsupplydrop", 0) > 0)
			{
				break;
			}
			wait(1);
		}
		supplydrop = getdvarint(#"scr_givetestsupplydrop", 0);
		team = "";
		player = util::gethostplayer();
		if(isdefined(player.pers[#"team"]))
		{
			switch(supplydrop)
			{
				case 2:
				{
					team = util::getotherteam(player.pers[#"team"]);
					break;
				}
				case 1:
				default:
				{
					team = player.pers[#"team"];
					break;
				}
			}
		}
		setdvar(#"scr_givetestsupplydrop", 0);
		ent = getormakebot(team);
		if(!isdefined(ent))
		{
			println("");
			wait(1);
			thread addtestcarepackage();
			return;
		}
		ent killstreakrules::killstreakstart("", team);
		ent thread supplydrop::helidelivercrate(ent.origin, getweapon(#"supplydrop"), ent, team);
		thread addtestcarepackage();
	#/
}

/*
	Name: print3duntilnotified
	Namespace: dev
	Checksum: 0xFBF71A55
	Offset: 0x5AF0
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
	Namespace: dev
	Checksum: 0xAF544DF6
	Offset: 0x5B70
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
	Name: engagement_distance_debug_toggle
	Namespace: dev
	Checksum: 0xA57BD457
	Offset: 0x5BE0
	Size: 0x184
	Parameters: 0
	Flags: None
*/
function engagement_distance_debug_toggle()
{
	/#
		level endon(#"kill_engage_dist_debug_toggle_watcher");
		if(!isdefined(getdvarint(#"debug_engage_dists", 0)))
		{
			setdvar(#"debug_engage_dists", 0);
		}
		laststate = getdvarint(#"debug_engage_dists", 0);
		while(true)
		{
			currentstate = getdvarint(#"debug_engage_dists", 0);
			if(dvar_turned_on(currentstate) && !dvar_turned_on(laststate))
			{
				weapon_engage_dists_init();
				thread debug_realtime_engage_dist();
				laststate = currentstate;
			}
			else if(!dvar_turned_on(currentstate) && dvar_turned_on(laststate))
			{
				level notify(#"kill_all_engage_dist_debug");
				laststate = currentstate;
			}
			wait(0.3);
		}
	#/
}

/*
	Name: dvar_turned_on
	Namespace: dev
	Checksum: 0x12AE898C
	Offset: 0x5D70
	Size: 0x28
	Parameters: 1
	Flags: None
*/
function dvar_turned_on(val)
{
	/#
		if(val <= 0)
		{
			return 0;
		}
		return 1;
	#/
}

/*
	Name: engagement_distance_debug_init
	Namespace: dev
	Checksum: 0x174FCFB4
	Offset: 0x5DA8
	Size: 0x3DE
	Parameters: 0
	Flags: None
*/
function engagement_distance_debug_init()
{
	/#
		level.debug_xpos = -50;
		level.debug_ypos = 250;
		level.debug_yinc = 18;
		level.debug_fontscale = 1.5;
		level.white = (1, 1, 1);
		level.green = (0, 1, 0);
		level.yellow = (1, 1, 0);
		level.red = (1, 0, 0);
		level.realtimeengagedist = newdebughudelem();
		level.realtimeengagedist.alignx = "";
		level.realtimeengagedist.fontscale = level.debug_fontscale;
		level.realtimeengagedist.x = level.debug_xpos;
		level.realtimeengagedist.y = level.debug_ypos;
		level.realtimeengagedist.color = level.white;
		level.realtimeengagedist settext("");
		xpos = level.debug_xpos + 207;
		level.realtimeengagedist_value = newdebughudelem();
		level.realtimeengagedist_value.alignx = "";
		level.realtimeengagedist_value.fontscale = level.debug_fontscale;
		level.realtimeengagedist_value.x = xpos;
		level.realtimeengagedist_value.y = level.debug_ypos;
		level.realtimeengagedist_value.color = level.white;
		level.realtimeengagedist_value setvalue(0);
		xpos = xpos + 37;
		level.realtimeengagedist_middle = newdebughudelem();
		level.realtimeengagedist_middle.alignx = "";
		level.realtimeengagedist_middle.fontscale = level.debug_fontscale;
		level.realtimeengagedist_middle.x = xpos;
		level.realtimeengagedist_middle.y = level.debug_ypos;
		level.realtimeengagedist_middle.color = level.white;
		level.realtimeengagedist_middle settext("");
		xpos = xpos + 105;
		level.realtimeengagedist_offvalue = newdebughudelem();
		level.realtimeengagedist_offvalue.alignx = "";
		level.realtimeengagedist_offvalue.fontscale = level.debug_fontscale;
		level.realtimeengagedist_offvalue.x = xpos;
		level.realtimeengagedist_offvalue.y = level.debug_ypos;
		level.realtimeengagedist_offvalue.color = level.white;
		level.realtimeengagedist_offvalue setvalue(0);
		hudobjarray = [];
		hudobjarray[0] = level.realtimeengagedist;
		hudobjarray[1] = level.realtimeengagedist_value;
		hudobjarray[2] = level.realtimeengagedist_middle;
		hudobjarray[3] = level.realtimeengagedist_offvalue;
		return hudobjarray;
	#/
}

/*
	Name: engage_dist_debug_hud_destroy
	Namespace: dev
	Checksum: 0xD4B850CC
	Offset: 0x6190
	Size: 0x66
	Parameters: 2
	Flags: None
*/
function engage_dist_debug_hud_destroy(hudarray, killnotify)
{
	/#
		level waittill(killnotify);
		for(i = 0; i < hudarray.size; i++)
		{
			hudarray[i] destroy();
		}
	#/
}

/*
	Name: weapon_engage_dists_init
	Namespace: dev
	Checksum: 0x1DCBC2E5
	Offset: 0x6200
	Size: 0x70C
	Parameters: 0
	Flags: None
*/
function weapon_engage_dists_init()
{
	/#
		level.engagedists = [];
		genericpistol = spawnstruct();
		genericpistol.engagedistmin = 125;
		genericpistol.engagedistoptimal = 225;
		genericpistol.engagedistmulligan = 50;
		genericpistol.engagedistmax = 400;
		shotty = spawnstruct();
		shotty.engagedistmin = 50;
		shotty.engagedistoptimal = 200;
		shotty.engagedistmulligan = 75;
		shotty.engagedistmax = 350;
		genericsmg = spawnstruct();
		genericsmg.engagedistmin = 100;
		genericsmg.engagedistoptimal = 275;
		genericsmg.engagedistmulligan = 100;
		genericsmg.engagedistmax = 500;
		genericlmg = spawnstruct();
		genericlmg.engagedistmin = 325;
		genericlmg.engagedistoptimal = 550;
		genericlmg.engagedistmulligan = 150;
		genericlmg.engagedistmax = 850;
		genericriflesa = spawnstruct();
		genericriflesa.engagedistmin = 325;
		genericriflesa.engagedistoptimal = 550;
		genericriflesa.engagedistmulligan = 150;
		genericriflesa.engagedistmax = 850;
		genericriflebolt = spawnstruct();
		genericriflebolt.engagedistmin = 350;
		genericriflebolt.engagedistoptimal = 600;
		genericriflebolt.engagedistmulligan = 150;
		genericriflebolt.engagedistmax = 900;
		generichmg = spawnstruct();
		generichmg.engagedistmin = 390;
		generichmg.engagedistoptimal = 600;
		generichmg.engagedistmulligan = 100;
		generichmg.engagedistmax = 900;
		genericsniper = spawnstruct();
		genericsniper.engagedistmin = 950;
		genericsniper.engagedistoptimal = 1700;
		genericsniper.engagedistmulligan = 300;
		genericsniper.engagedistmax = 3000;
		engage_dists_add("", genericpistol);
		engage_dists_add("", genericpistol);
		engage_dists_add("", genericpistol);
		engage_dists_add("", genericpistol);
		engage_dists_add("", genericsmg);
		engage_dists_add("", genericsmg);
		engage_dists_add("", genericsmg);
		engage_dists_add("", genericsmg);
		engage_dists_add("", genericsmg);
		engage_dists_add("", genericsmg);
		engage_dists_add("", genericsmg);
		engage_dists_add("", shotty);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericlmg);
		engage_dists_add("", genericriflesa);
		engage_dists_add("", genericriflesa);
		engage_dists_add("", genericriflesa);
		engage_dists_add("", genericriflesa);
		engage_dists_add("", genericriflebolt);
		engage_dists_add("", genericriflebolt);
		engage_dists_add("", genericriflebolt);
		engage_dists_add("", genericriflebolt);
		engage_dists_add("", genericriflebolt);
		engage_dists_add("", generichmg);
		engage_dists_add("", generichmg);
		engage_dists_add("", generichmg);
		engage_dists_add("", generichmg);
		engage_dists_add("", genericsniper);
		engage_dists_add("", genericsniper);
		engage_dists_add("", genericsniper);
		engage_dists_add("", genericsniper);
		engage_dists_add("", genericsniper);
		engage_dists_add("", genericsniper);
		level thread engage_dists_watcher();
	#/
}

/*
	Name: engage_dists_add
	Namespace: dev
	Checksum: 0x175747D0
	Offset: 0x6918
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function engage_dists_add(weaponname, values)
{
	/#
		level.engagedists[getweapon(weaponname)] = values;
	#/
}

/*
	Name: get_engage_dists
	Namespace: dev
	Checksum: 0xE4466DB2
	Offset: 0x6968
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function get_engage_dists(weapon)
{
	/#
		if(isdefined(level.engagedists[weapon]))
		{
			return level.engagedists[weapon];
		}
		return undefined;
	#/
}

/*
	Name: engage_dists_watcher
	Namespace: dev
	Checksum: 0xDED37649
	Offset: 0x69B0
	Size: 0x118
	Parameters: 0
	Flags: None
*/
function engage_dists_watcher()
{
	/#
		level endon(#"kill_all_engage_dist_debug");
		level endon(#"kill_engage_dists_watcher");
		while(true)
		{
			player = util::gethostplayer();
			playerweapon = player getcurrentweapon();
			if(!isdefined(player.lastweapon))
			{
				player.lastweapon = playerweapon;
			}
			else if(player.lastweapon == playerweapon)
			{
				waitframe(1);
				continue;
			}
			values = get_engage_dists(playerweapon);
			if(isdefined(values))
			{
				level.weaponengagedistvalues = values;
			}
			else
			{
				level.weaponengagedistvalues = undefined;
			}
			player.lastweapon = playerweapon;
			waitframe(1);
		}
	#/
}

/*
	Name: debug_realtime_engage_dist
	Namespace: dev
	Checksum: 0xE0D76E4C
	Offset: 0x6AD0
	Size: 0x496
	Parameters: 0
	Flags: None
*/
function debug_realtime_engage_dist()
{
	/#
		level endon(#"kill_all_engage_dist_debug");
		level endon(#"kill_realtime_engagement_distance_debug");
		hudobjarray = engagement_distance_debug_init();
		level thread engage_dist_debug_hud_destroy(hudobjarray, "");
		level.debugrtengagedistcolor = level.green;
		player = util::gethostplayer();
		while(true)
		{
			lasttracepos = (0, 0, 0);
			direction = player getplayerangles();
			direction_vec = anglestoforward(direction);
			eye = player geteye();
			eye = (eye[0], eye[1], eye[2] + 20);
			trace = bullettrace(eye, eye + vectorscale(direction_vec, 100000), 1, player);
			tracepoint = trace[#"position"];
			tracenormal = trace[#"normal"];
			tracedist = int(distance(eye, tracepoint));
			if(tracepoint != lasttracepos)
			{
				lasttracepos = tracepoint;
				if(!isdefined(level.weaponengagedistvalues))
				{
					hudobj_changecolor(hudobjarray, level.white);
					hudobjarray engagedist_hud_changetext("", tracedist);
				}
				else
				{
					engagedistmin = level.weaponengagedistvalues.engagedistmin;
					engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
					engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
					engagedistmax = level.weaponengagedistvalues.engagedistmax;
					if(tracedist >= engagedistmin && tracedist <= engagedistmax)
					{
						if(tracedist >= (engagedistoptimal - engagedistmulligan) && tracedist <= (engagedistoptimal + engagedistmulligan))
						{
							hudobjarray engagedist_hud_changetext("", tracedist);
							hudobj_changecolor(hudobjarray, level.green);
						}
						else
						{
							hudobjarray engagedist_hud_changetext("", tracedist);
							hudobj_changecolor(hudobjarray, level.yellow);
						}
					}
					else if(tracedist < engagedistmin)
					{
						hudobj_changecolor(hudobjarray, level.red);
						hudobjarray engagedist_hud_changetext("", tracedist);
					}
					else if(tracedist > engagedistmax)
					{
						hudobj_changecolor(hudobjarray, level.red);
						hudobjarray engagedist_hud_changetext("", tracedist);
					}
				}
			}
			thread util::function_6844bea4(1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
			thread util::function_6844bea4(1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
			waitframe(1);
		}
	#/
}

/*
	Name: hudobj_changecolor
	Namespace: dev
	Checksum: 0xE498FC66
	Offset: 0x6F70
	Size: 0x88
	Parameters: 2
	Flags: None
*/
function hudobj_changecolor(hudobjarray, newcolor)
{
	/#
		for(i = 0; i < hudobjarray.size; i++)
		{
			hudobj = hudobjarray[i];
			if(hudobj.color != newcolor)
			{
				hudobj.color = newcolor;
				level.debugrtengagedistcolor = newcolor;
			}
		}
	#/
}

/*
	Name: engagedist_hud_changetext
	Namespace: dev
	Checksum: 0xBC0431C0
	Offset: 0x7000
	Size: 0x2F6
	Parameters: 2
	Flags: None
*/
function engagedist_hud_changetext(engagedisttype, units)
{
	/#
		if(!isdefined(level.lastdisttype))
		{
			level.lastdisttype = "";
		}
		if(engagedisttype == "")
		{
			self[1] setvalue(units);
			self[2] settext("");
			self[3].alpha = 0;
		}
		else if(engagedisttype == "")
		{
			self[1] setvalue(units);
			self[2] settext("");
			self[3].alpha = 0;
		}
		else if(engagedisttype == "")
		{
			amountunder = level.weaponengagedistvalues.engagedistmin - units;
			self[1] setvalue(units);
			self[3] setvalue(amountunder);
			self[3].alpha = 1;
			if(level.lastdisttype != engagedisttype)
			{
				self[2] settext("");
			}
		}
		else if(engagedisttype == "")
		{
			amountover = units - level.weaponengagedistvalues.engagedistmax;
			self[1] setvalue(units);
			self[3] setvalue(amountover);
			self[3].alpha = 1;
			if(level.lastdisttype != engagedisttype)
			{
				self[2] settext("");
			}
		}
		else if(engagedisttype == "")
		{
			self[1] setvalue(units);
			self[2] settext("");
			self[3].alpha = 0;
		}
		level.lastdisttype = engagedisttype;
	#/
}

/*
	Name: larry_thread
	Namespace: dev
	Checksum: 0xA18EA870
	Offset: 0x7300
	Size: 0x1DA
	Parameters: 0
	Flags: None
*/
function larry_thread()
{
	/#
		setdvar(#"bot_allowmovement", 0);
		setdvar(#"bot_allowaiming", 0);
		setdvar(#"bot_pressattackbtn", 0);
		setdvar(#"bot_pressmeleebtn", 0);
		level.larry = spawnstruct();
		player = util::gethostplayer();
		player thread larry_init(level.larry);
		level waittill(#"kill_larry");
		larry_hud_destroy(level.larry);
		if(isdefined(level.larry.model))
		{
			level.larry.model delete();
		}
		if(isdefined(level.larry.ai))
		{
			for(i = 0; i < level.larry.ai.size; i++)
			{
				kick(level.larry.ai[i] getentitynumber());
			}
		}
		level.larry = undefined;
	#/
}

/*
	Name: larry_init
	Namespace: dev
	Checksum: 0xC70B1F2F
	Offset: 0x74E8
	Size: 0x254
	Parameters: 1
	Flags: None
*/
function larry_init(larry)
{
	/#
		level endon(#"kill_larry");
		larry_hud_init(larry);
		larry.model = spawn("", (0, 0, 0));
		larry.model setmodel(#"defaultactor");
		larry.ai = [];
		wait(0.1);
		for(;;)
		{
			waitframe(1);
			if(larry.ai.size > 0)
			{
				larry.model hide();
				continue;
			}
			direction = self getplayerangles();
			direction_vec = anglestoforward(direction);
			eye = self geteye();
			trace = bullettrace(eye, eye + vectorscale(direction_vec, 8000), 0, undefined);
			dist = distance(eye, trace[#"position"]);
			position = eye + (vectorscale(direction_vec, dist - 64));
			larry.model.origin = position;
			larry.model.angles = self.angles + vectorscale((0, 1, 0), 180);
			if(self usebuttonpressed())
			{
				self larry_ai(larry);
				while(self usebuttonpressed())
				{
					waitframe(1);
				}
			}
		}
	#/
}

/*
	Name: larry_ai
	Namespace: dev
	Checksum: 0x85DFC81A
	Offset: 0x7748
	Size: 0x224
	Parameters: 1
	Flags: None
*/
function larry_ai(larry)
{
	/#
		var_572bc68e = "";
		if(level.teambased)
		{
			foreach(team in level.teams)
			{
				if(team != self.team)
				{
					var_572bc68e = team;
					break;
				}
			}
		}
		else
		{
			foreach(team in level.teams)
			{
				if(getplayers(team).size == 0)
				{
					var_572bc68e = team;
					break;
				}
			}
		}
		larry.ai[larry.ai.size] = bot::add_bot(var_572bc68e);
		i = larry.ai.size - 1;
		larry.ai[i] thread larry_ai_thread(larry, larry.model.origin, larry.model.angles);
		larry.ai[i] thread larry_ai_damage(larry);
		larry.ai[i] thread larry_ai_health(larry);
	#/
}

/*
	Name: larry_ai_thread
	Namespace: dev
	Checksum: 0x567F1AFA
	Offset: 0x7978
	Size: 0x1E0
	Parameters: 3
	Flags: None
*/
function larry_ai_thread(larry, origin, angles)
{
	/#
		level endon(#"kill_larry");
		for(;;)
		{
			self waittill(#"spawned_player");
			larry.menu[larry.menu_health] setvalue(self.health);
			larry.menu[larry.menu_damage] settext("");
			larry.menu[larry.menu_range] settext("");
			larry.menu[larry.menu_hitloc] settext("");
			larry.menu[larry.menu_weapon] settext("");
			larry.menu[larry.menu_perks] settext("");
			self setorigin(origin);
			self setplayerangles(angles);
			self clearperks();
		}
	#/
}

/*
	Name: larry_ai_damage
	Namespace: dev
	Checksum: 0x62345DE1
	Offset: 0x7B60
	Size: 0x2B8
	Parameters: 1
	Flags: None
*/
function larry_ai_damage(larry)
{
	/#
		level endon(#"kill_larry");
		for(;;)
		{
			waitresult = undefined;
			waitresult = self waittill(#"damage");
			attacker = waitresult.attacker;
			damage = waitresult.amount;
			point = waitresult.position;
			if(!isdefined(attacker))
			{
				continue;
			}
			player = util::gethostplayer();
			if(!isdefined(player))
			{
				continue;
			}
			if(attacker != player)
			{
				continue;
			}
			eye = player geteye();
			range = int(distance(eye, point));
			larry.menu[larry.menu_health] setvalue(self.health);
			larry.menu[larry.menu_damage] setvalue(damage);
			larry.menu[larry.menu_range] setvalue(range);
			if(isdefined(self.cac_debug_location))
			{
				larry.menu[larry.menu_hitloc] settext(self.cac_debug_location);
			}
			else
			{
				larry.menu[larry.menu_hitloc] settext("");
			}
			if(isdefined(self.cac_debug_weapon))
			{
				larry.menu[larry.menu_weapon] settext(self.cac_debug_weapon);
				continue;
			}
			larry.menu[larry.menu_weapon] settext("");
		}
	#/
}

/*
	Name: larry_ai_health
	Namespace: dev
	Checksum: 0x43798FE0
	Offset: 0x7E20
	Size: 0x60
	Parameters: 1
	Flags: None
*/
function larry_ai_health(larry)
{
	/#
		level endon(#"kill_larry");
		for(;;)
		{
			waitframe(1);
			larry.menu[larry.menu_health] setvalue(self.health);
		}
	#/
}

/*
	Name: larry_hud_init
	Namespace: dev
	Checksum: 0x8619FBC0
	Offset: 0x7E88
	Size: 0x586
	Parameters: 1
	Flags: None
*/
function larry_hud_init(larry)
{
	/#
		/#
			x = -45;
			y = 275;
			menu_name = "";
			larry.hud = new_hud(menu_name, undefined, x, y, 1);
			larry.hud setshader(#"white", 135, 65);
			larry.hud.alignx = "";
			larry.hud.aligny = "";
			larry.hud.sort = 10;
			larry.hud.alpha = 0.6;
			larry.hud.color = vectorscale((0, 0, 1), 0.5);
			larry.menu[0] = new_hud(menu_name, "", x + 5, y + 10, 1);
			larry.menu[1] = new_hud(menu_name, "", x + 5, y + 20, 1);
			larry.menu[2] = new_hud(menu_name, "", x + 5, y + 30, 1);
			larry.menu[3] = new_hud(menu_name, "", x + 5, y + 40, 1);
			larry.menu[4] = new_hud(menu_name, "", x + 5, y + 50, 1);
			larry.cleartextmarker = newdebughudelem();
			larry.cleartextmarker.alpha = 0;
			larry.cleartextmarker settext("");
			larry.menu_health = larry.menu.size;
			larry.menu_damage = larry.menu.size + 1;
			larry.menu_range = larry.menu.size + 2;
			larry.menu_hitloc = larry.menu.size + 3;
			larry.menu_weapon = larry.menu.size + 4;
			larry.menu_perks = larry.menu.size + 5;
			x_offset = 70;
			larry.menu[larry.menu_health] = new_hud(menu_name, "", x + x_offset, y + 10, 1);
			larry.menu[larry.menu_damage] = new_hud(menu_name, "", x + x_offset, y + 20, 1);
			larry.menu[larry.menu_range] = new_hud(menu_name, "", x + x_offset, y + 30, 1);
			larry.menu[larry.menu_hitloc] = new_hud(menu_name, "", x + x_offset, y + 40, 1);
			larry.menu[larry.menu_weapon] = new_hud(menu_name, "", x + x_offset, y + 50, 1);
			larry.menu[larry.menu_perks] = new_hud(menu_name, "", x + x_offset, y + 60, 1);
		#/
	#/
}

/*
	Name: larry_hud_destroy
	Namespace: dev
	Checksum: 0xF94392B7
	Offset: 0x8418
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function larry_hud_destroy(larry)
{
	/#
		if(isdefined(larry.hud))
		{
			larry.hud destroy();
			for(i = 0; i < larry.menu.size; i++)
			{
				larry.menu[i] destroy();
			}
			larry.cleartextmarker destroy();
		}
	#/
}

/*
	Name: new_hud
	Namespace: dev
	Checksum: 0x66E9120D
	Offset: 0x84D0
	Size: 0xCC
	Parameters: 5
	Flags: None
*/
function new_hud(hud_name, msg, x, y, scale)
{
	/#
		if(!isdefined(level.hud_array))
		{
			level.hud_array = [];
		}
		if(!isdefined(level.hud_array[hud_name]))
		{
			level.hud_array[hud_name] = [];
		}
		hud = set_hudelem(msg, x, y, scale);
		level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
		return hud;
	#/
}

/*
	Name: set_hudelem
	Namespace: dev
	Checksum: 0xBB9A5CBE
	Offset: 0x85A8
	Size: 0x168
	Parameters: 7
	Flags: None
*/
function set_hudelem(text, x, y, scale, alpha, sort, debug_hudelem)
{
	/#
		/#
			if(!isdefined(alpha))
			{
				alpha = 1;
			}
			if(!isdefined(scale))
			{
				scale = 1;
			}
			if(!isdefined(sort))
			{
				sort = 20;
			}
			hud = newdebughudelem();
			hud.debug_hudelem = 1;
			hud.location = 0;
			hud.alignx = "";
			hud.aligny = "";
			hud.foreground = 1;
			hud.fontscale = scale;
			hud.sort = sort;
			hud.alpha = alpha;
			hud.x = x;
			hud.y = y;
			hud.og_scale = scale;
			if(isdefined(text))
			{
				hud settext(text);
			}
			return hud;
		#/
	#/
}

/*
	Name: print_weapon_name
	Namespace: dev
	Checksum: 0x230C0234
	Offset: 0x8720
	Size: 0x15C
	Parameters: 0
	Flags: None
*/
function print_weapon_name()
{
	/#
		/#
			self notify(#"print_weapon_name");
			self endon(#"print_weapon_name");
			wait(0.2);
			if(self isswitchingweapons())
			{
				waitresult = undefined;
				waitresult = self waittill(#"weapon_change_complete");
				fail_safe = 0;
				while(waitresult.weapon == level.weaponnone)
				{
					waitresult = undefined;
					waitresult = self waittill(#"weapon_change_complete");
					waitframe(1);
					fail_safe++;
					if(fail_safe > 120)
					{
						break;
					}
				}
			}
			else
			{
				weapon = self getcurrentweapon();
			}
			printweaponname = getdvarint(#"scr_print_weapon_name", 1);
			if(printweaponname)
			{
				iprintlnbold(function_a16a090d(weapon));
			}
		#/
	#/
}

/*
	Name: set_equipment_list
	Namespace: dev
	Checksum: 0xFC01D5A6
	Offset: 0x8888
	Size: 0x236
	Parameters: 0
	Flags: None
*/
function set_equipment_list()
{
	/#
		if(isdefined(level.dev_equipment))
		{
			return;
		}
		level.dev_equipment = [];
		level.dev_equipment[1] = getweapon(#"acoustic_sensor");
		level.dev_equipment[2] = getweapon(#"camera_spike");
		level.dev_equipment[3] = getweapon(#"claymore");
		level.dev_equipment[4] = getweapon(#"satchel_charge");
		level.dev_equipment[5] = getweapon(#"scrambler");
		level.dev_equipment[6] = getweapon(#"tactical_insertion");
		level.dev_equipment[7] = getweapon(#"bouncingbetty");
		level.dev_equipment[8] = getweapon(#"trophy_system");
		level.dev_equipment[9] = getweapon(#"pda_hack");
		level.dev_equipment[10] = getweapon(#"threat_detector");
		level.dev_equipment[11] = getweapon(#"armor_station");
	#/
}

/*
	Name: set_grenade_list
	Namespace: dev
	Checksum: 0xD5E73943
	Offset: 0x8AC8
	Size: 0x266
	Parameters: 0
	Flags: None
*/
function set_grenade_list()
{
	/#
		if(isdefined(level.dev_grenade))
		{
			return;
		}
		level.dev_grenade = [];
		level.dev_grenade[1] = getweapon(#"frag_grenade");
		level.dev_grenade[2] = getweapon(#"sticky_grenade");
		level.dev_grenade[3] = getweapon(#"hatchet");
		level.dev_grenade[4] = getweapon(#"willy_pete");
		level.dev_grenade[5] = getweapon(#"proximity_grenade");
		level.dev_grenade[6] = getweapon(#"flash_grenade");
		level.dev_grenade[7] = getweapon(#"concussion_grenade");
		level.dev_grenade[8] = getweapon(#"nightingale");
		level.dev_grenade[9] = getweapon(#"emp_grenade");
		level.dev_grenade[10] = getweapon(#"sensor_grenade");
		level.dev_grenade[11] = getweapon(#"incendiary_grenade");
		level.dev_grenade[12] = getweapon(#"sprint_boost_grenade");
	#/
}

/*
	Name: take_all_grenades_and_equipment
	Namespace: dev
	Checksum: 0xD6D71639
	Offset: 0x8D38
	Size: 0xB6
	Parameters: 1
	Flags: None
*/
function take_all_grenades_and_equipment(player)
{
	/#
		for(i = 0; i < level.dev_equipment.size; i++)
		{
			player takeweapon(level.dev_equipment[i + 1]);
		}
		for(i = 0; i < level.dev_grenade.size; i++)
		{
			player takeweapon(level.dev_grenade[i + 1]);
		}
	#/
}

/*
	Name: equipment_dev_gui
	Namespace: dev
	Checksum: 0x51B27C61
	Offset: 0x8DF8
	Size: 0x150
	Parameters: 0
	Flags: None
*/
function equipment_dev_gui()
{
	/#
		set_equipment_list();
		set_grenade_list();
		setdvar(#"scr_give_equipment", "");
		while(true)
		{
			wait(0.5);
			devgui_int = getdvarint(#"scr_give_equipment", 0);
			if(devgui_int != 0)
			{
				for(i = 0; i < level.players.size; i++)
				{
					take_all_grenades_and_equipment(level.players[i]);
					level.players[i] devgui::devgui_give_weapon(function_a16a090d(level.dev_equipment[devgui_int]));
				}
				setdvar(#"scr_give_equipment", 0);
			}
		}
	#/
}

/*
	Name: grenade_dev_gui
	Namespace: dev
	Checksum: 0x3914A135
	Offset: 0x8F50
	Size: 0x150
	Parameters: 0
	Flags: None
*/
function grenade_dev_gui()
{
	/#
		set_equipment_list();
		set_grenade_list();
		setdvar(#"scr_give_grenade", "");
		while(true)
		{
			wait(0.5);
			devgui_int = getdvarint(#"scr_give_grenade", 0);
			if(devgui_int != 0)
			{
				for(i = 0; i < level.players.size; i++)
				{
					take_all_grenades_and_equipment(level.players[i]);
					level.players[i] devgui::devgui_give_weapon(function_a16a090d(level.dev_grenade[devgui_int]));
				}
				setdvar(#"scr_give_grenade", 0);
			}
		}
	#/
}

/*
	Name: force_grenade_throw
	Namespace: dev
	Checksum: 0x99D5B842
	Offset: 0x90A8
	Size: 0x27C
	Parameters: 1
	Flags: None
*/
function force_grenade_throw(weapon)
{
	/#
		if(weapon == level.weaponnone)
		{
			return;
		}
		setdvar(#"bot_allowmovement", 0);
		setdvar(#"bot_allowaiming", 0);
		setdvar(#"bot_pressattackbtn", 0);
		setdvar(#"bot_pressmeleebtn", 0);
		setdvar(#"scr_botsallowkillstreaks", 0);
		host = util::gethostplayer();
		if(!isdefined(host.team))
		{
			iprintln("");
			return;
		}
		bot = getormakebot(util::getotherteam(host.team));
		if(!isdefined(bot))
		{
			iprintln("");
			return;
		}
		angles = host getplayerangles();
		angles = (0, angles[1], 0);
		dir = anglestoforward(angles);
		dir = vectornormalize(dir);
		origin = host geteye() + vectorscale(dir, 256);
		velocity = vectorscale(dir, -1024);
		grenade = bot magicgrenadeplayer(weapon, origin, velocity);
		grenade setteam(bot.team);
		grenade setowner(bot);
	#/
}

/*
	Name: devstraferunpathdebugdraw
	Namespace: dev
	Checksum: 0xC034646B
	Offset: 0x9330
	Size: 0x472
	Parameters: 0
	Flags: None
*/
function devstraferunpathdebugdraw()
{
	/#
		white = (1, 1, 1);
		red = (1, 0, 0);
		green = (0, 1, 0);
		blue = (0, 0, 1);
		violet = (0.4, 0, 0.6);
		maxdrawtime = 10;
		drawtime = maxdrawtime;
		origintextoffset = vectorscale((0, 0, -1), 50);
		endonmsg = "";
		while(true)
		{
			if(killstreaks::should_draw_debug("") > 0)
			{
				nodes = [];
				end = 0;
				node = getvehiclenode("", "");
				if(!isdefined(node))
				{
					println("");
					setdvar(#"scr_devstraferunpathdebugdraw", 0);
					continue;
				}
				while(isdefined(node.target))
				{
					new_node = getvehiclenode(node.target, "");
					foreach(n in nodes)
					{
						if(n == new_node)
						{
							end = 1;
						}
					}
					textscale = 30;
					if(drawtime == maxdrawtime)
					{
						node thread drawpathsegment(new_node, violet, violet, 1, textscale, origintextoffset, drawtime, endonmsg);
					}
					if(isdefined(node.script_noteworthy))
					{
						textscale = 10;
						switch(node.script_noteworthy)
						{
							case "strafe_start":
							{
								textcolor = green;
								textalpha = 1;
								break;
							}
							case "strafe_stop":
							{
								textcolor = red;
								textalpha = 1;
								break;
							}
							case "strafe_leave":
							{
								textcolor = white;
								textalpha = 1;
								break;
							}
						}
						switch(node.script_noteworthy)
						{
							case "strafe_stop":
							case "strafe_leave":
							case "strafe_start":
							{
								sides = 10;
								radius = 100;
								if(drawtime == maxdrawtime)
								{
									sphere(node.origin, radius, textcolor, textalpha, 1, sides, int(drawtime * 1000));
								}
								node draworiginlines();
								node drawnoteworthytext(textcolor, textalpha, textscale);
								break;
							}
						}
					}
					if(end)
					{
						break;
					}
					nodes[nodes.size] = new_node;
					node = new_node;
				}
				drawtime = drawtime - 0.05;
				if(drawtime < 0)
				{
					drawtime = maxdrawtime;
				}
				waitframe(1);
			}
			else
			{
				wait(1);
			}
		}
	#/
}

/*
	Name: devhelipathdebugdraw
	Namespace: dev
	Checksum: 0xB46301A2
	Offset: 0x97B0
	Size: 0x3C4
	Parameters: 0
	Flags: None
*/
function devhelipathdebugdraw()
{
	/#
		white = (1, 1, 1);
		red = (1, 0, 0);
		green = (0, 1, 0);
		blue = (0, 0, 1);
		textcolor = white;
		textalpha = 1;
		textscale = 1;
		maxdrawtime = 10;
		drawtime = maxdrawtime;
		origintextoffset = vectorscale((0, 0, -1), 50);
		endonmsg = "";
		while(true)
		{
			if(getdvarint(#"scr_devhelipathsdebugdraw", 0) > 0)
			{
				script_origins = getentarray("", "");
				foreach(ent in script_origins)
				{
					if(isdefined(ent.targetname))
					{
						switch(ent.targetname)
						{
							case "heli_start":
							{
								textcolor = blue;
								textalpha = 1;
								textscale = 3;
								break;
							}
							case "heli_loop_start":
							{
								textcolor = green;
								textalpha = 1;
								textscale = 3;
								break;
							}
							case "heli_attack_area":
							{
								textcolor = red;
								textalpha = 1;
								textscale = 3;
								break;
							}
							case "heli_leave":
							{
								textcolor = white;
								textalpha = 1;
								textscale = 3;
								break;
							}
						}
						switch(ent.targetname)
						{
							case "heli_leave":
							case "heli_attack_area":
							case "heli_start":
							case "heli_loop_start":
							{
								if(drawtime == maxdrawtime)
								{
									ent thread drawpath(textcolor, white, textalpha, textscale, origintextoffset, drawtime, endonmsg);
								}
								ent draworiginlines();
								ent drawtargetnametext(textcolor, textalpha, textscale);
								ent draworigintext(textcolor, textalpha, textscale, origintextoffset);
								break;
							}
						}
					}
				}
				drawtime = drawtime - 0.05;
				if(drawtime < 0)
				{
					drawtime = maxdrawtime;
				}
			}
			if(getdvarint(#"scr_devhelipathsdebugdraw", 0) == 0)
			{
				level notify(endonmsg);
				drawtime = maxdrawtime;
				wait(1);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: draworiginlines
	Namespace: dev
	Checksum: 0x59E9627F
	Offset: 0x9B80
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function draworiginlines()
{
	/#
		red = (1, 0, 0);
		green = (0, 1, 0);
		blue = (0, 0, 1);
		line(self.origin, self.origin + (anglestoforward(self.angles) * 10), red);
		line(self.origin, self.origin + (anglestoright(self.angles) * 10), green);
		line(self.origin, self.origin + (anglestoup(self.angles) * 10), blue);
	#/
}

/*
	Name: drawtargetnametext
	Namespace: dev
	Checksum: 0x763C3E5
	Offset: 0x9C88
	Size: 0x6C
	Parameters: 4
	Flags: None
*/
function drawtargetnametext(textcolor, textalpha, textscale, textoffset)
{
	/#
		if(!isdefined(textoffset))
		{
			textoffset = (0, 0, 0);
		}
		print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
	#/
}

/*
	Name: drawnoteworthytext
	Namespace: dev
	Checksum: 0xF9DC4B4
	Offset: 0x9D00
	Size: 0x6C
	Parameters: 4
	Flags: None
*/
function drawnoteworthytext(textcolor, textalpha, textscale, textoffset)
{
	/#
		if(!isdefined(textoffset))
		{
			textoffset = (0, 0, 0);
		}
		print3d(self.origin + textoffset, self.script_noteworthy, textcolor, textalpha, textscale);
	#/
}

/*
	Name: draworigintext
	Namespace: dev
	Checksum: 0xE76A92AB
	Offset: 0x9D78
	Size: 0xBC
	Parameters: 4
	Flags: None
*/
function draworigintext(textcolor, textalpha, textscale, textoffset)
{
	/#
		if(!isdefined(textoffset))
		{
			textoffset = (0, 0, 0);
		}
		originstring = ((((("" + self.origin[0]) + "") + self.origin[1]) + "") + self.origin[2]) + "";
		print3d(self.origin + textoffset, originstring, textcolor, textalpha, textscale);
	#/
}

/*
	Name: drawspeedacceltext
	Namespace: dev
	Checksum: 0xCEDDA150
	Offset: 0x9E40
	Size: 0xD4
	Parameters: 4
	Flags: None
*/
function drawspeedacceltext(textcolor, textalpha, textscale, textoffset)
{
	/#
		if(isdefined(self.script_airspeed))
		{
			print3d(self.origin + (0, 0, textoffset[2] * 2), "" + self.script_airspeed, textcolor, textalpha, textscale);
		}
		if(isdefined(self.script_accel))
		{
			print3d(self.origin + (0, 0, textoffset[2] * 3), "" + self.script_accel, textcolor, textalpha, textscale);
		}
	#/
}

/*
	Name: drawpath
	Namespace: dev
	Checksum: 0xF7870D44
	Offset: 0x9F20
	Size: 0x142
	Parameters: 7
	Flags: None
*/
function drawpath(linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg)
{
	/#
		level endon(endonmsg);
		ent = self;
		entfirsttarget = ent.targetname;
		while(isdefined(ent.target))
		{
			enttarget = getent(ent.target, "");
			ent thread drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg);
			if(ent.targetname == "")
			{
				entfirsttarget = ent.target;
			}
			else if(ent.target == entfirsttarget)
			{
				break;
			}
			ent = enttarget;
			waitframe(1);
		}
	#/
}

/*
	Name: drawpathsegment
	Namespace: dev
	Checksum: 0xF8BFFE7F
	Offset: 0xA070
	Size: 0x116
	Parameters: 8
	Flags: None
*/
function drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg)
{
	/#
		level endon(endonmsg);
		while(drawtime > 0)
		{
			if(isdefined(self.targetname) && self.targetname == "")
			{
				print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
			}
			line(self.origin, enttarget.origin, linecolor);
			self drawspeedacceltext(textcolor, textalpha, textscale, textoffset);
			drawtime = drawtime - 0.05;
			waitframe(1);
		}
	#/
}

