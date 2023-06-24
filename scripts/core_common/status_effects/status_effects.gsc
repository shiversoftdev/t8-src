// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace status_effect;

/*
	Name: __init__system__
	Namespace: status_effect
	Checksum: 0xC6D6E42A
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"status_effects", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: status_effect
	Checksum: 0xDDB9498C
	Offset: 0xD0
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	callback::on_disconnect(&on_player_disconnect);
	callback::on_end_game(&on_end_game);
	/#
		level thread status_effects_init();
	#/
}

/*
	Name: on_player_connect
	Namespace: status_effect
	Checksum: 0x6F49628F
	Offset: 0x158
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	if(!isdefined(self._gadgets_player))
	{
		self._gadgets_player = [];
	}
	/#
		self thread status_effects_devgui_player_connect();
	#/
}

/*
	Name: on_player_disconnect
	Namespace: status_effect
	Checksum: 0x416C84C8
	Offset: 0x198
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	/#
		self thread status_effects_devgui_player_disconnect();
	#/
}

/*
	Name: on_end_game
	Namespace: status_effect
	Checksum: 0xAF45C0AC
	Offset: 0x1C0
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function on_end_game()
{
	foreach(player in level.players)
	{
		player thread function_6519f95f();
	}
}

/*
	Name: status_effects_init
	Namespace: status_effect
	Checksum: 0xCA7499A4
	Offset: 0x248
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function status_effects_init()
{
	/#
		setdvar(#"scr_status_effects_devgui_cmd", "");
		setdvar(#"scr_status_effects_devgui_arg", 0);
		setdvar(#"scr_status_effects_devgui_player", 0);
		if(isdedicated())
		{
			return;
		}
		level.status_effects_devgui_base = "";
		level.status_effects_devgui_player_connect = &status_effects_devgui_player_connect;
		level.status_effects_devgui_player_disconnect = &status_effects_devgui_player_disconnect;
		level thread status_effects_devgui_think();
	#/
}

/*
	Name: status_effects_devgui_player_disconnect
	Namespace: status_effect
	Checksum: 0x9EDF9D13
	Offset: 0x338
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function status_effects_devgui_player_disconnect()
{
	/#
		if(!isdefined(level.status_effects_devgui_base))
		{
			return;
		}
		remove_cmd_with_root = (("" + level.status_effects_devgui_base) + self.playername) + "";
		util::add_queued_debug_command(remove_cmd_with_root);
	#/
}

/*
	Name: status_effects_devgui_player_connect
	Namespace: status_effect
	Checksum: 0xFE4EC3F8
	Offset: 0x3A0
	Size: 0x108
	Parameters: 0
	Flags: None
*/
function status_effects_devgui_player_connect()
{
	/#
		if(!isdefined(level.status_effects_devgui_base))
		{
			return;
		}
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(players[i] != self)
			{
				continue;
			}
			status_effects_devgui_add_player_status_effects(level.status_effects_devgui_base, players[i].playername, i + 1);
			status_effects_devgui_add_player_grenades(level.status_effects_devgui_base, players[i].playername, i + 1);
			function_2a302935(level.status_effects_devgui_base, players[i].playername, i + 1);
			return;
		}
	#/
}

/*
	Name: function_2a302935
	Namespace: status_effect
	Checksum: 0x6C7C695
	Offset: 0x4B0
	Size: 0x8C
	Parameters: 3
	Flags: None
*/
function function_2a302935(root, pname, index)
{
	/#
		add_cmd_with_root = (("" + root) + pname) + "";
		pid = "" + index;
		status_effects_devgui_add_player_command(add_cmd_with_root, pid, "", "", undefined);
	#/
}

/*
	Name: status_effects_devgui_add_player_status_effects
	Namespace: status_effect
	Checksum: 0xEF073C36
	Offset: 0x548
	Size: 0x11E
	Parameters: 3
	Flags: None
*/
function status_effects_devgui_add_player_status_effects(root, pname, index)
{
	/#
		add_cmd_with_root = (("" + root) + pname) + "";
		pid = "" + index;
		if(isdefined(level.var_233471d2))
		{
			for(i = 0; i < level.var_233471d2.size; i++)
			{
				if(!isdefined(level.var_233471d2[i]))
				{
					println("" + i);
				}
				if(isdefined(level.var_233471d2[i].var_18d16a6b))
				{
					status_effects_devgui_add_player_command(add_cmd_with_root, pid, level.var_233471d2[i].var_18d16a6b, "", i);
				}
			}
		}
	#/
}

/*
	Name: status_effects_devgui_add_player_grenades
	Namespace: status_effect
	Checksum: 0xE255FB99
	Offset: 0x670
	Size: 0x136
	Parameters: 3
	Flags: None
*/
function status_effects_devgui_add_player_grenades(root, pname, index)
{
	/#
		add_cmd_with_root = (("" + root) + pname) + "";
		pid = "" + index;
		if(isdefined(level.var_233471d2))
		{
			for(i = 0; i < level.var_233471d2.size; i++)
			{
				if(!isdefined(level.var_233471d2[i]))
				{
					println("" + i);
				}
				if(isdefined(level.var_233471d2[i].var_18d16a6b))
				{
					grenade = "" + level.var_233471d2[i].var_18d16a6b;
					status_effects_devgui_add_player_command(add_cmd_with_root, pid, grenade, "", grenade);
				}
			}
		}
	#/
}

/*
	Name: status_effects_devgui_add_player_command
	Namespace: status_effect
	Checksum: 0xA064652D
	Offset: 0x7B0
	Size: 0xC4
	Parameters: 5
	Flags: None
*/
function status_effects_devgui_add_player_command(root, pid, cmdname, cmddvar, argdvar)
{
	/#
		if(!isdefined(argdvar))
		{
			argdvar = "";
		}
		adddebugcommand((((((((((((((root + cmdname) + "") + "") + "") + pid) + "") + "") + "") + cmddvar) + "") + "") + "") + argdvar) + "");
	#/
}

/*
	Name: status_effects_devgui_think
	Namespace: status_effect
	Checksum: 0x4B1C36DB
	Offset: 0x880
	Size: 0x178
	Parameters: 0
	Flags: None
*/
function status_effects_devgui_think()
{
	/#
		for(;;)
		{
			cmd = getdvarstring(#"scr_status_effects_devgui_cmd");
			if(cmd == "")
			{
				waitframe(1);
				continue;
			}
			pid = getdvarint(#"scr_status_effects_devgui_player", 0);
			switch(cmd)
			{
				case "set_active":
				{
					status_effects_set_active_effect(pid);
					break;
				}
				case "give_grenade":
				{
					status_effects_give_grenade(pid);
					break;
				}
				case "clear_all":
				{
					function_64ba1c7e(pid);
				}
				default:
				{
					break;
				}
			}
			setdvar(#"scr_status_effects_devgui_cmd", "");
			setdvar(#"scr_status_effects_devgui_arg", "");
			wait(0.5);
		}
	#/
}

/*
	Name: function_64ba1c7e
	Namespace: status_effect
	Checksum: 0x1C14DD52
	Offset: 0xA00
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_64ba1c7e(pid)
{
	/#
		player = getplayers()[pid - 1];
		if(isdefined(player))
		{
			player function_6519f95f();
		}
	#/
}

/*
	Name: status_effects_set_active_effect
	Namespace: status_effect
	Checksum: 0x27C011E4
	Offset: 0xA60
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function status_effects_set_active_effect(pid)
{
	/#
		arg = getdvarint(#"scr_status_effects_devgui_arg", 0);
		player = getplayers()[pid - 1];
		if(isdefined(player))
		{
			player function_e2bff3ce(arg, undefined, player);
		}
	#/
}

/*
	Name: status_effects_give_grenade
	Namespace: status_effect
	Checksum: 0x5B1B38F4
	Offset: 0xAF8
	Size: 0x20C
	Parameters: 1
	Flags: None
*/
function status_effects_give_grenade(pid)
{
	/#
		arg = getdvarstring(#"scr_status_effects_devgui_arg");
		player = getplayers()[pid - 1];
		if(isdefined(player))
		{
			weapon = getweapon(arg);
			grenades = 0;
			pweapons = player getweaponslist();
			foreach(pweapon in pweapons)
			{
				if(pweapon != weapon && pweapon.isgrenadeweapon)
				{
					grenades++;
				}
			}
			if(grenades > 1)
			{
				foreach(pweapon in pweapons)
				{
					if(pweapon != weapon && pweapon.isgrenadeweapon)
					{
						grenades--;
						player takeweapon(pweapon);
						if(grenades < 2)
						{
							break;
						}
					}
				}
			}
			player giveweapon(weapon);
		}
	#/
}

