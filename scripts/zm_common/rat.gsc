// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\rat_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace rat;

/*
	Name: __init__system__
	Namespace: rat
	Checksum: 0x91FE9A1B
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	/#
		system::register(#"rat", &__init__, undefined, undefined);
	#/
}

/*
	Name: __init__
	Namespace: rat
	Checksum: 0x5D5D97C0
	Offset: 0x108
	Size: 0x51C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	/#
		init();
		level.rat.common.gethostplayer = &util::gethostplayer;
		addratscriptcmd("", &derriesezombiespawnnavmeshtest);
		addratscriptcmd("", &function_b8181e0d);
		addratscriptcmd("", &function_38d6a592);
		addratscriptcmd("", &function_ff8061ca);
		addratscriptcmd("", &function_1428d95e);
		addratscriptcmd("", &function_63a39134);
		addratscriptcmd("", &function_26a15f4d);
		addratscriptcmd("", &function_3d37c034);
		addratscriptcmd("", &function_7a11ca68);
		addratscriptcmd("", &function_782c6850);
		addratscriptcmd("", &function_125e2d8d);
		addratscriptcmd("", &function_e7dffcf9);
		addratscriptcmd("", &function_c3aa7d01);
		addratscriptcmd("", &function_684f2efb);
		addratscriptcmd("", &function_123195b9);
		addratscriptcmd("", &function_c79c0501);
		addratscriptcmd("", &function_3bbff2c5);
		addratscriptcmd("", &function_ea4b3f00);
		addratscriptcmd("", &function_8f340c78);
		addratscriptcmd("", &function_1bd3da0f);
		addratscriptcmd("", &function_6ea9a113);
		addratscriptcmd("", &function_e2143adf);
		addratscriptcmd("", &function_ff8f5737);
		addratscriptcmd("", &function_5b9ddfdb);
		addratscriptcmd("", &function_d49caa1a);
		addratscriptcmd("", &function_d52c7fc3);
		addratscriptcmd("", &function_d87f9fe1);
		addratscriptcmd("", &function_94ac25d9);
		addratscriptcmd("", &function_a6f7ea4a);
		addratscriptcmd("", &function_303319e9);
		addratscriptcmd("", &function_e1bdc812);
	#/
}

/*
	Name: function_e1bdc812
	Namespace: rat
	Checksum: 0x341141DE
	Offset: 0x630
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_e1bdc812(params)
{
	/#
		return zm_trial::function_ba9853db();
	#/
}

/*
	Name: function_303319e9
	Namespace: rat
	Checksum: 0x329DA4B
	Offset: 0x660
	Size: 0x1A8
	Parameters: 1
	Flags: None
*/
function function_303319e9(params)
{
	/#
		zombies = getaiarchetypearray("", level.zombie_team);
		player = getplayer(params);
		forward = anglestoforward(player.angles);
		distance = 25;
		if(isdefined(params.distance))
		{
			distance = float(params.distance);
		}
		spawn = player.origin + (forward * distance);
		foreach(zombie in zombies)
		{
			zombie forceteleport(spawn, player.angles);
			if(isdefined(params.is_dummy) && params.is_dummy == 1)
			{
				zombie pathmode("");
			}
		}
	#/
}

/*
	Name: function_a6f7ea4a
	Namespace: rat
	Checksum: 0x50F23A56
	Offset: 0x810
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_a6f7ea4a(params)
{
	/#
		zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", 2147483647);
	#/
}

/*
	Name: function_94ac25d9
	Namespace: rat
	Checksum: 0x4FBC4639
	Offset: 0x858
	Size: 0xF8
	Parameters: 1
	Flags: None
*/
function function_94ac25d9(params)
{
	/#
		windows = level.exterior_goals;
		if(isdefined(windows))
		{
			foreach(window in windows)
			{
				origin = window.origin;
				function_55e20e75(params._id, origin);
				angles = window.angles;
				function_55e20e75(params._id, angles);
			}
		}
	#/
}

/*
	Name: function_8f340c78
	Namespace: rat
	Checksum: 0x221B219B
	Offset: 0x958
	Size: 0x13C
	Parameters: 1
	Flags: None
*/
function function_8f340c78(params)
{
	/#
		chests = level.chests;
		if(isdefined(chests))
		{
			foreach(chest in chests)
			{
				if(chest.hidden == 0)
				{
					origin = chest.origin;
					function_55e20e75(params._id, origin);
					angles = (chest.angles[0], chest.angles[1] - 90, chest.angles[2]);
					function_55e20e75(params._id, angles);
					break;
				}
			}
		}
	#/
}

/*
	Name: function_d52c7fc3
	Namespace: rat
	Checksum: 0x5ED51890
	Offset: 0xAA0
	Size: 0x166
	Parameters: 1
	Flags: None
*/
function function_d52c7fc3(params)
{
	/#
		for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
		{
			triggerstub = level._unitriggers.trigger_stubs[i];
			if(isdefined(triggerstub.script_noteworthy))
			{
				if(triggerstub.script_noteworthy == "" || triggerstub.script_noteworthy == "")
				{
					origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
					function_55e20e75(params._id, origin);
					angles = (triggerstub.angles[0], triggerstub.angles[1], triggerstub.angles[2]);
					function_55e20e75(params._id, angles);
				}
			}
		}
	#/
}

/*
	Name: function_d87f9fe1
	Namespace: rat
	Checksum: 0x152E412D
	Offset: 0xC10
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_d87f9fe1(params)
{
	/#
		host = util::gethostplayer();
		return isdefined(host.var_4e90ce0c);
	#/
}

/*
	Name: function_6ea9a113
	Namespace: rat
	Checksum: 0x90D2D614
	Offset: 0xC58
	Size: 0x1D4
	Parameters: 1
	Flags: None
*/
function function_6ea9a113(params)
{
	/#
		foreach(items in level.item_spawns)
		{
			foreach(item in items)
			{
				if(isdefined(item))
				{
					offset = (item.origin[0], item.origin[1], item.origin[2]);
					function_55e20e75(params._id, offset);
					forward = item.origin - offset;
					angle = vectornormalize(forward);
					angles = (item.angles[0], item.angles[1], item.angles[2]);
					function_55e20e75(params._id, angles);
				}
			}
		}
	#/
}

/*
	Name: function_ff8f5737
	Namespace: rat
	Checksum: 0x6653FAB8
	Offset: 0xE38
	Size: 0x14E
	Parameters: 1
	Flags: None
*/
function function_ff8f5737(params)
{
	/#
		for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
		{
			triggerstub = level._unitriggers.trigger_stubs[i];
			if(isdefined(triggerstub.target))
			{
				if(triggerstub.target == "")
				{
					origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
					function_55e20e75(params._id, origin);
					angles = (triggerstub.angles[0], triggerstub.angles[1] + 180, triggerstub.angles[2]);
					function_55e20e75(params._id, angles);
				}
			}
		}
	#/
}

/*
	Name: function_5b9ddfdb
	Namespace: rat
	Checksum: 0x5D0AB328
	Offset: 0xF90
	Size: 0x14E
	Parameters: 1
	Flags: None
*/
function function_5b9ddfdb(params)
{
	/#
		for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
		{
			triggerstub = level._unitriggers.trigger_stubs[i];
			if(isdefined(triggerstub.target))
			{
				if(triggerstub.target == "")
				{
					origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
					function_55e20e75(params._id, origin);
					angles = (triggerstub.angles[0], triggerstub.angles[1] + 180, triggerstub.angles[2]);
					function_55e20e75(params._id, angles);
				}
			}
		}
	#/
}

/*
	Name: function_e2143adf
	Namespace: rat
	Checksum: 0xF2304C00
	Offset: 0x10E8
	Size: 0x30
	Parameters: 1
	Flags: None
*/
function function_e2143adf(params)
{
	/#
		if(isdefined(level.item_inventory))
		{
			return level.item_inventory.size;
		}
		return 0;
	#/
}

/*
	Name: function_1bd3da0f
	Namespace: rat
	Checksum: 0xFEBD5AF5
	Offset: 0x1128
	Size: 0x160
	Parameters: 1
	Flags: None
*/
function function_1bd3da0f(params)
{
	/#
		chunks = level.s_pap_quest.a_s_locations;
		if(isdefined(chunks))
		{
			foreach(chunk in chunks)
			{
				origin = (chunk.origin[0], chunk.origin[1] - 40, chunk.origin[2] - 40);
				function_55e20e75(params._id, origin);
				angles = (chunk.angles[0], chunk.angles[1] + 180, chunk.angles[2]);
				function_55e20e75(params._id, angles);
			}
		}
	#/
}

/*
	Name: function_d49caa1a
	Namespace: rat
	Checksum: 0x9E1DB85
	Offset: 0x1290
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_d49caa1a(params)
{
	/#
		return level.s_pap_quest.var_be6e6f65;
	#/
}

/*
	Name: function_ea4b3f00
	Namespace: rat
	Checksum: 0x7BAEF338
	Offset: 0x12C0
	Size: 0x11A
	Parameters: 1
	Flags: None
*/
function function_ea4b3f00(params)
{
	/#
		host = util::gethostplayer();
		skip = 0;
		if(isdefined(params.var_f870f386))
		{
			if(params.var_f870f386 == "")
			{
				skip = 1;
			}
		}
		players = getplayers();
		foreach(player in players)
		{
			if(skip)
			{
				if(player != host)
				{
					player enableinvulnerability();
				}
				continue;
			}
			skip = 0;
		}
	#/
}

/*
	Name: function_c79c0501
	Namespace: rat
	Checksum: 0xBD85421F
	Offset: 0x13E8
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_c79c0501(params)
{
	/#
		if(isdefined(params.round))
		{
			setdvar(#"scr_zombie_round", int(params.round));
			adddebugcommand("");
		}
	#/
}

/*
	Name: function_3bbff2c5
	Namespace: rat
	Checksum: 0xEA457136
	Offset: 0x1468
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_3bbff2c5(params)
{
	/#
		num = 3;
		if(isdefined(params.num))
		{
			num = int(params.num);
		}
		if(num > 0)
		{
			adddebugcommand("" + num);
		}
	#/
}

/*
	Name: function_123195b9
	Namespace: rat
	Checksum: 0x245A3537
	Offset: 0x14F0
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_123195b9(params)
{
	/#
	#/
}

/*
	Name: function_684f2efb
	Namespace: rat
	Checksum: 0x23F8F310
	Offset: 0x1508
	Size: 0x1F0
	Parameters: 1
	Flags: None
*/
function function_684f2efb(params)
{
	/#
		trigs = getentarray("", "");
		foreach(ent in trigs)
		{
			ent_parts = getentarray(ent.target, "");
			foreach(e in ent_parts)
			{
				if(isdefined(e.script_noteworthy) && e.script_noteworthy == "")
				{
					master_switch = e;
					function_55e20e75(params._id, master_switch.origin);
					angles = (master_switch.angles[0], master_switch.angles[1], master_switch.angles[2]);
					function_55e20e75(params._id, angles);
					break;
				}
			}
		}
	#/
}

/*
	Name: function_c3aa7d01
	Namespace: rat
	Checksum: 0x478EE154
	Offset: 0x1700
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_c3aa7d01(params)
{
	/#
		player = util::gethostplayer();
		if(isdefined(player))
		{
			if(isdefined(player.perk_purchased))
			{
				return player.perk_purchased;
			}
		}
	#/
}

/*
	Name: function_125e2d8d
	Namespace: rat
	Checksum: 0xAF52306C
	Offset: 0x1760
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_125e2d8d(params)
{
	/#
		zombie_doors = getentarray("", "");
		count = 0;
		if(isdefined(zombie_doors))
		{
			for(i = 0; i < zombie_doors.size; i++)
			{
				if(isdefined(zombie_doors[i].purchaser))
				{
					count++;
				}
			}
		}
		return count;
	#/
}

/*
	Name: function_e7dffcf9
	Namespace: rat
	Checksum: 0x2580FF09
	Offset: 0x1808
	Size: 0x146
	Parameters: 1
	Flags: None
*/
function function_e7dffcf9(params)
{
	/#
		zombie_doors = getentarray("", "");
		if(isdefined(zombie_doors))
		{
			for(i = 0; i < zombie_doors.size; i++)
			{
				door = zombie_doors[i];
				if(isdefined(door.script_noteworthy))
				{
					if(door.script_noteworthy == "" && door._door_open == 0)
					{
						function_55e20e75(params._id, door.origin);
						angles = (door.angles[0], door.angles[1] + 90, door.angles[2]);
						function_55e20e75(params._id, angles);
					}
				}
			}
		}
	#/
}

/*
	Name: function_7a11ca68
	Namespace: rat
	Checksum: 0xB836A67
	Offset: 0x1958
	Size: 0x146
	Parameters: 1
	Flags: None
*/
function function_7a11ca68(params)
{
	/#
		for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
		{
			triggerstub = level._unitriggers.trigger_stubs[i];
			if(triggerstub.cursor_hint == "")
			{
				origin = triggerstub zm_unitrigger::unitrigger_origin();
				origin = (origin[0], origin[1], origin[2] - 40);
				function_55e20e75(params._id, origin);
				angles = triggerstub.angles;
				angles = (angles[0], angles[1] - 90, angles[2]);
				function_55e20e75(params._id, angles);
			}
		}
	#/
}

/*
	Name: function_782c6850
	Namespace: rat
	Checksum: 0x82F9D470
	Offset: 0x1AA8
	Size: 0x12E
	Parameters: 1
	Flags: None
*/
function function_782c6850(params)
{
	/#
		for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
		{
			triggerstub = level._unitriggers.trigger_stubs[i];
			if(isdefined(triggerstub.hint_string) && triggerstub.hint_string == "")
			{
				origin = triggerstub zm_unitrigger::unitrigger_origin();
				function_55e20e75(params._id, origin);
				angles = triggerstub.angles;
				angles = (angles[0], angles[1] + 180, angles[2]);
				function_55e20e75(params._id, angles);
			}
		}
	#/
}

/*
	Name: function_3d37c034
	Namespace: rat
	Checksum: 0xA5951D66
	Offset: 0x1BE0
	Size: 0xDE
	Parameters: 1
	Flags: None
*/
function function_3d37c034(params)
{
	/#
		a_e_players = getplayers();
		foreach(e_player in a_e_players)
		{
			if(isdefined(e_player.intermission) || e_player.sessionstate == "" || e_player.sessionstate == "")
			{
				continue;
			}
			return true;
		}
		return false;
	#/
}

/*
	Name: function_38d6a592
	Namespace: rat
	Checksum: 0xF1152A0B
	Offset: 0x1CC8
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_38d6a592(params)
{
	/#
		setdvar(#"zombie_cheat", 2);
	#/
}

/*
	Name: function_26a15f4d
	Namespace: rat
	Checksum: 0xD54C5D9D
	Offset: 0x1D08
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_26a15f4d(params)
{
	/#
		setdvar(#"zombie_cheat", 0);
	#/
}

/*
	Name: function_1428d95e
	Namespace: rat
	Checksum: 0xA29B836A
	Offset: 0x1D48
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function function_1428d95e(params)
{
	/#
		player = util::gethostplayer();
		forward = anglestoforward(player.angles);
		spawn = player.origin + (forward * 10);
		zombie = zm_devgui::devgui_zombie_spawn();
		if(isdefined(zombie))
		{
			zombie forceteleport(spawn, player.angles + vectorscale((0, 1, 0), 180));
			zombie pathmode("");
		}
	#/
}

/*
	Name: function_63a39134
	Namespace: rat
	Checksum: 0xE86CA00A
	Offset: 0x1E50
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_63a39134(params)
{
	/#
		return zombie_utility::get_current_zombie_count();
	#/
}

/*
	Name: function_b8181e0d
	Namespace: rat
	Checksum: 0xE3AB0D7D
	Offset: 0x1E80
	Size: 0x3A
	Parameters: 1
	Flags: None
*/
function function_b8181e0d(params)
{
	/#
		player = util::gethostplayer();
		return player.score;
	#/
}

/*
	Name: function_ff8061ca
	Namespace: rat
	Checksum: 0xF82B7EBF
	Offset: 0x1EC8
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_ff8061ca(params)
{
	/#
		if(isdefined(level.power_local_doors_globally))
		{
			return true;
		}
		return false;
	#/
}

/*
	Name: derriesezombiespawnnavmeshtest
	Namespace: rat
	Checksum: 0x1CCC8328
	Offset: 0x1F00
	Size: 0x4BC
	Parameters: 2
	Flags: None
*/
function derriesezombiespawnnavmeshtest(params, inrat)
{
	/#
		if(!isdefined(inrat))
		{
			inrat = 1;
		}
		if(inrat)
		{
			wait(10);
		}
		enemy = zm_devgui::devgui_zombie_spawn();
		enemy.is_rat_test = 1;
		failed_spawn_origin = [];
		failed_node_origin = [];
		failed_attack_spot_spawn_origin = [];
		failed_attack_spot = [];
		size = 0;
		failed_attack_spot_size = 0;
		wait(0.2);
		foreach(zone in level.zones)
		{
			foreach(loc in zone.a_loc_types[#"zombie_location"])
			{
				angles = (0, 0, 0);
				enemy forceteleport(loc.origin, angles);
				wait(0.2);
				node = undefined;
				for(j = 0; j < level.exterior_goals.size; j++)
				{
					if(isdefined(level.exterior_goals[j].script_string) && level.exterior_goals[j].script_string == loc.script_string)
					{
						node = level.exterior_goals[j];
					}
				}
				if(isdefined(node))
				{
					ispath = enemy setgoal(node.origin);
					if(!ispath)
					{
						failed_spawn_origin[size] = loc.origin;
						failed_node_origin[size] = node.origin;
						size++;
					}
					wait(0.2);
					for(j = 0; j < node.attack_spots.size; j++)
					{
						isattackpath = enemy setgoal(node.attack_spots[j]);
						if(!isattackpath)
						{
							failed_attack_spot_spawn_origin[failed_attack_spot_size] = loc.origin;
							failed_attack_spot[failed_attack_spot_size] = node.attack_spots[j];
							failed_attack_spot_size++;
						}
						wait(0.2);
					}
				}
			}
		}
		if(inrat)
		{
			errmsg = "";
			for(i = 0; i < size; i++)
			{
				errmsg = errmsg + (((("" + failed_spawn_origin[i]) + "") + failed_node_origin[i]) + "");
			}
			for(i = 0; i < failed_attack_spot_size; i++)
			{
				errmsg = errmsg + (((("" + failed_attack_spot_spawn_origin[i]) + "") + failed_attack_spot[i]) + "");
			}
			if(size > 0 || failed_attack_spot_size > 0)
			{
				ratreportcommandresult(params._id, 0, errmsg);
			}
			else
			{
				ratreportcommandresult(params._id, 1);
			}
		}
	#/
}

