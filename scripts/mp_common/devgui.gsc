// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_68d2ee1489345a1d;
#using script_7edb54aca54e9a2b;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\dev_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;

#namespace devgui;

/*
	Name: function_89f2df9
	Namespace: devgui
	Checksum: 0xAA84CEC
	Offset: 0xD0
	Size: 0x4C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	/#
		system::register(#"devgui", &__init__, undefined, #"load");
	#/
}

/*
	Name: __init__
	Namespace: devgui
	Checksum: 0xEB8B6F6B
	Offset: 0x128
	Size: 0x36C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	/#
		level.var_f9f04b00 = debug_center_screen::register("");
		util::set_dvar_if_unset("", "");
		util::set_dvar_if_unset("", 0);
		util::set_dvar_if_unset("", "");
		util::set_dvar_if_unset("", 0);
		util::set_dvar_if_unset("", 0);
		util::set_dvar_if_unset("", "");
		level.attachment_cycling_dvars = [];
		level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "";
		level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "";
		level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "";
		level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "";
		level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "";
		level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "";
		level thread devgui_weapon_think();
		level thread devgui_weapon_asset_name_display_think();
		level thread devgui_player_weapons();
		level thread function_cb7cee87();
		level thread dev::devgui_test_chart_think();
		level thread devgui_player_spawn_think();
		level thread devgui_vehicle_spawn_think();
		level thread function_7bef8d25();
		level thread function_be0f9897();
		level thread dev::function_487bf571();
		level thread function_46b22d99();
		level thread function_773432e2();
		level thread function_6a24e58f();
		level thread function_57edec18();
		thread init_debug_center_screen();
		level thread dev::body_customization_devgui(currentsessionmode());
		callback::on_connect(&hero_art_on_player_connect);
		callback::on_connect(&on_player_connect);
	#/
}

/*
	Name: on_player_connect
	Namespace: devgui
	Checksum: 0x53CD3AB4
	Offset: 0x4A0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function on_player_connect()
{
	/#
		self.devguilockspawn = 0;
		self thread devgui_player_spawn();
	#/
}

/*
	Name: devgui_player_spawn
	Namespace: devgui
	Checksum: 0xDF54D33A
	Offset: 0x4D0
	Size: 0x148
	Parameters: 0
	Flags: None
*/
function devgui_player_spawn()
{
	/#
		wait(1);
		player_devgui_base_mp = "";
		waitframe(1);
		players = getplayers();
		foreach(player in players)
		{
			if(player != self)
			{
				continue;
			}
			temp = player_devgui_base_mp + player.playername + "" + "" + "" + player.playername + "";
			adddebugcommand(player_devgui_base_mp + player.playername + "" + "" + "" + player.playername + "");
		}
	#/
}

/*
	Name: devgui_player_spawn_think
	Namespace: devgui
	Checksum: 0x1E6B110
	Offset: 0x620
	Size: 0x170
	Parameters: 0
	Flags: None
*/
function devgui_player_spawn_think()
{
	/#
		for(;;)
		{
			playername = getdvarstring(#"mp_lockspawn_command_devgui");
			if(playername == "")
			{
				waitframe(1);
				continue;
			}
			players = getplayers();
			foreach(player in players)
			{
				if(player.playername != playername)
				{
					continue;
				}
				player.devguilockspawn = !player.devguilockspawn;
				if(player.devguilockspawn)
				{
					player.resurrect_origin = player.origin;
					player.resurrect_angles = player.angles;
				}
			}
			setdvar(#"mp_lockspawn_command_devgui", "");
			wait(0.5);
		}
	#/
}

/*
	Name: devgui_vehicle_spawn_think
	Namespace: devgui
	Checksum: 0xE3721393
	Offset: 0x798
	Size: 0xEE
	Parameters: 0
	Flags: None
*/
function devgui_vehicle_spawn_think()
{
	/#
		waitframe(1);
		for(;;)
		{
			val = getdvarint(#"scr_spawnvehicle", 0);
			if(val != 0)
			{
				if(val == 1)
				{
					add_vehicle_at_eye_trace("");
				}
				else if(val == 2)
				{
					add_vehicle_at_eye_trace("");
				}
				else if(val == 3)
				{
					add_vehicle_at_eye_trace("");
				}
				setdvar(#"scr_spawnvehicle", 0);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_cb7cee87
	Namespace: devgui
	Checksum: 0x62ECF555
	Offset: 0x890
	Size: 0x2E4
	Parameters: 0
	Flags: None
*/
function function_cb7cee87()
{
	/#
		if(isdefined(game.var_461b2589) && game.var_461b2589)
		{
			return;
		}
		self notify("");
		self endon("");
		level endon(#"game_ended");
		player_devgui_base = "";
		setdvar(#"hash_2abeb78ad3292aa1", "");
		util::function_e2e9d901(player_devgui_base + "", "" + "" + "");
		while(getdvarstring(#"hash_2abeb78ad3292aa1", "") == "")
		{
			wait(1);
		}
		game.var_461b2589 = 1;
		setdvar(#"hash_2abeb78ad3292aa1", "");
		var_fca60300 = function_5e2d2d9b();
		foreach(var_1a983da1, var_31863ee4 in var_fca60300)
		{
			var_64345a05 = player_devgui_base + function_9e72a96(var_1a983da1) + "";
			foreach(boast in var_31863ee4)
			{
				util::function_e2e9d901(var_64345a05 + function_9e72a96(boast), "" + "" + "" + function_9e72a96(boast));
			}
			waitframe(1);
		}
		util::function_d84da933(player_devgui_base + "");
		level thread function_42644f29();
	#/
}

/*
	Name: function_42644f29
	Namespace: devgui
	Checksum: 0x88815E7E
	Offset: 0xB80
	Size: 0x156
	Parameters: 0
	Flags: None
*/
function function_42644f29()
{
	/#
		while(true)
		{
			level.var_cfbfb6de = getdvarint(#"hash_6046bac574d1e237", 0);
			gesture = getdvarstring(#"hash_2abeb78ad3292aa1");
			if(gesture != "")
			{
				setdvar(#"hash_6028c4687677bbc9", 1);
				players = getplayers();
				if(isdefined(level.var_cfbfb6de) && isdefined(players[level.var_cfbfb6de]))
				{
					players[level.var_cfbfb6de] function_c6775cf9(gesture);
				}
				else
				{
					players[0] function_c6775cf9(gesture);
				}
				setdvar(#"hash_2abeb78ad3292aa1", "");
			}
			waitframe(1);
		}
	#/
}

/*
	Name: devgui_player_weapons
	Namespace: devgui
	Checksum: 0xDEE78245
	Offset: 0xCE0
	Size: 0x60C
	Parameters: 0
	Flags: None
*/
function devgui_player_weapons()
{
	/#
		level endon(#"game_ended");
		if(isdefined(game.devgui_weapons_added) && game.devgui_weapons_added)
		{
			return;
		}
		level flag::wait_till("");
		a_weapons = enumerateweapons("");
		a_weapons_mp = [];
		a_grenades_mp = [];
		a_misc_mp = [];
		var_ef946ce8 = [];
		for(i = 0; i < a_weapons.size; i++)
		{
			if(strstartswith(function_a16a090d(a_weapons[i]), ""))
			{
				arrayinsert(var_ef946ce8, a_weapons[i], 0);
				continue;
			}
			if(weapons::is_primary_weapon(a_weapons[i]) || weapons::is_side_arm(a_weapons[i]) && !killstreaks::is_killstreak_weapon(a_weapons[i]))
			{
				arrayinsert(a_weapons_mp, a_weapons[i], 0);
				continue;
			}
			if(weapons::is_grenade(a_weapons[i]))
			{
				arrayinsert(a_grenades_mp, a_weapons[i], 0);
				continue;
			}
			arrayinsert(a_misc_mp, a_weapons[i], 0);
		}
		player_devgui_base_mp = "";
		menu_index = 1;
		level thread devgui_add_player_weapons(player_devgui_base_mp, "", 0, a_weapons_mp, "", menu_index);
		menu_index++;
		level thread devgui_add_player_weapons(player_devgui_base_mp, "", 0, a_grenades_mp, "", menu_index);
		menu_index++;
		level thread devgui_add_player_weapons(player_devgui_base_mp, "", 0, a_misc_mp, "", menu_index);
		menu_index++;
		level thread devgui_add_player_weapons(player_devgui_base_mp, "", 0, var_ef946ce8, "", menu_index);
		menu_index++;
		game.devgui_weapons_added = 1;
		waitframe(1);
		adddebugcommand(player_devgui_base_mp + "" + "" + "" + "");
		menu_index++;
		adddebugcommand(player_devgui_base_mp + "" + "" + "" + "");
		menu_index++;
		adddebugcommand(player_devgui_base_mp + "" + "" + "" + "");
		menu_index++;
		waitframe(1);
		attachment_cycling_devgui_base_mp = player_devgui_base_mp + "" + "";
		adddebugcommand(attachment_cycling_devgui_base_mp + "" + "" + "");
		adddebugcommand(attachment_cycling_devgui_base_mp + "" + "" + "");
		attachmentnames = getattachmentnames();
		for(i = 0; i < 6; i++)
		{
			attachment_cycling_sub_menu_index = 1;
			adddebugcommand(attachment_cycling_devgui_base_mp + "" + i + 1 + "" + "" + "" + i + "");
			for(attachmentname = 0; attachmentname < attachmentnames.size; attachmentname++)
			{
				util::waittill_can_add_debug_command();
				adddebugcommand(attachment_cycling_devgui_base_mp + "" + i + 1 + "" + attachmentnames[attachmentname] + "" + "" + "" + level.attachment_cycling_dvars[i] + "" + attachmentnames[attachmentname] + "");
				attachment_cycling_sub_menu_index++;
			}
			if(i % 4)
			{
				waitframe(1);
			}
		}
		level thread devgui_attachment_cycling_think();
	#/
}

/*
	Name: devgui_add_player_weapons
	Namespace: devgui
	Checksum: 0x620BC48A
	Offset: 0x12F8
	Size: 0x20E
	Parameters: 6
	Flags: None
*/
function devgui_add_player_weapons(root, pname, index, a_weapons, weapon_type, mindex)
{
	/#
		level endon(#"game_ended");
		if(isdedicated())
		{
			return;
		}
		devgui_root = root + weapon_type + "";
		if(isdefined(a_weapons))
		{
			for(i = 0; i < a_weapons.size; i++)
			{
				attachments = a_weapons[i].supportedattachments;
				name = function_a16a090d(a_weapons[i]);
				if(attachments.size)
				{
					devgui_add_player_weap_command(devgui_root + name + "", index, name, i + 1);
					foreach(att in attachments)
					{
						if(att != "")
						{
							devgui_add_player_weap_command(devgui_root + name + "", index, name + "" + att, i + 1);
						}
					}
					continue;
				}
				devgui_add_player_weap_command(devgui_root, index, name, i + 1);
			}
		}
	#/
}

/*
	Name: devgui_add_player_weap_command
	Namespace: devgui
	Checksum: 0xAAA6B14A
	Offset: 0x1510
	Size: 0x84
	Parameters: 4
	Flags: None
*/
function devgui_add_player_weap_command(root, pid, weap_name, cmdindex)
{
	/#
		util::waittill_can_add_debug_command();
		adddebugcommand(root + weap_name + "" + "" + "" + weap_name + "");
	#/
}

/*
	Name: devgui_weapon_think
	Namespace: devgui
	Checksum: 0x17F5F220
	Offset: 0x15A0
	Size: 0xA0
	Parameters: 0
	Flags: None
*/
function devgui_weapon_think()
{
	/#
		for(;;)
		{
			weapon_name = getdvarstring(#"mp_weap_devgui");
			if(weapon_name != "")
			{
				devgui_handle_player_command(&devgui_give_weapon, weapon_name);
			}
			setdvar(#"mp_weap_devgui", "");
			wait(0.5);
		}
	#/
}

/*
	Name: hero_art_on_player_connect
	Namespace: devgui
	Checksum: 0x84431A11
	Offset: 0x1648
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function hero_art_on_player_connect()
{
	/#
		self._debugheromodels = spawnstruct();
	#/
}

/*
	Name: devgui_weapon_asset_name_display_think
	Namespace: devgui
	Checksum: 0x8F431C8F
	Offset: 0x1678
	Size: 0x42E
	Parameters: 0
	Flags: None
*/
function devgui_weapon_asset_name_display_think()
{
	/#
		update_time = 1;
		print_duration = int(update_time / float(function_60d95f53()) / 1000);
		printlnbold_update = int(1 / update_time);
		printlnbold_counter = 0;
		colors = [];
		colors[colors.size] = (1, 1, 1);
		colors[colors.size] = (1, 0, 0);
		colors[colors.size] = (0, 1, 0);
		colors[colors.size] = (1, 1, 0);
		colors[colors.size] = (1, 0, 1);
		colors[colors.size] = (0, 1, 1);
		for(;;)
		{
			wait(update_time);
			display = getdvarint(#"mp_weap_asset_name_display_devgui", 0);
			if(!display)
			{
				continue;
			}
			if(!printlnbold_counter)
			{
				iprintlnbold(function_a16a090d(level.players[0] getcurrentweapon()));
			}
			printlnbold_counter++;
			if(printlnbold_counter >= printlnbold_update)
			{
				printlnbold_counter = 0;
			}
			color_index = 0;
			for(i = 1; i < level.players.size; i++)
			{
				player = level.players[i];
				weapon = player getcurrentweapon();
				if(!isdefined(weapon) || level.weaponnone == weapon)
				{
					continue;
				}
				var_9643e38d = player gettagorigin("");
				if(!isdefined(var_9643e38d))
				{
					continue;
				}
				print3d(var_9643e38d, function_a16a090d(weapon), colors[color_index], 1, 0.15, print_duration);
				color_index++;
				if(color_index >= colors.size)
				{
					color_index = 0;
				}
			}
			color_index = 0;
			ai_list = getaiarray();
			for(i = 0; i < ai_list.size; i++)
			{
				ai = ai_list[i];
				if(isvehicle(ai))
				{
					weapon = ai.turretweapon;
				}
				else
				{
					weapon = ai.weapon;
				}
				if(!isdefined(weapon) || level.weaponnone == weapon)
				{
					continue;
				}
				var_9643e38d = ai gettagorigin("");
				if(!isdefined(var_9643e38d))
				{
					continue;
				}
				print3d(var_9643e38d, function_a16a090d(weapon), colors[color_index], 1, 0.15, print_duration);
				color_index++;
				if(color_index >= colors.size)
				{
					color_index = 0;
				}
			}
		}
	#/
}

/*
	Name: devgui_attachment_cycling_clear
	Namespace: devgui
	Checksum: 0x35FAE323
	Offset: 0x1AB0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function devgui_attachment_cycling_clear(index)
{
	/#
		setdvar(level.attachment_cycling_dvars[index], "");
	#/
}

/*
	Name: devgui_attachment_cycling_update
	Namespace: devgui
	Checksum: 0xBC92C754
	Offset: 0x1AF8
	Size: 0x3A4
	Parameters: 0
	Flags: None
*/
function devgui_attachment_cycling_update()
{
	/#
		currentweapon = self getcurrentweapon();
		rootweapon = currentweapon.rootweapon;
		supportedattachments = currentweapon.supportedattachments;
		textcolors = [];
		attachments = [];
		originalattachments = [];
		for(i = 0; i < 6; i++)
		{
			originalattachments[i] = getdvarstring(level.attachment_cycling_dvars[i]);
			textcolor[i] = "";
			attachments[i] = "";
			name = originalattachments[i];
			if("" == name)
			{
				continue;
			}
			textcolor[i] = "";
			for(supportedindex = 0; supportedindex < supportedattachments.size; supportedindex++)
			{
				if(name == supportedattachments[supportedindex])
				{
					textcolor[i] = "";
					attachments[i] = name;
					break;
				}
			}
		}
		for(i = 0; i < 6; i++)
		{
			if("" == originalattachments[i])
			{
				continue;
			}
			for(j = i + 1; j < 6; j++)
			{
				if(originalattachments[i] == originalattachments[j])
				{
					textcolor[j] = "";
					attachments[j] = "";
				}
			}
		}
		msg = "";
		for(i = 0; i < 6; i++)
		{
			if("" == originalattachments[i])
			{
				continue;
			}
			msg = msg + textcolor[i];
			msg = msg + i;
			msg = msg + "";
			msg = msg + originalattachments[i];
			msg = msg + "";
		}
		iprintlnbold(msg);
		self takeweapon(currentweapon);
		currentweapon = getweapon(rootweapon.name, attachments[0], attachments[1], attachments[2], attachments[3], attachments[4], attachments[5]);
		wait(0.25);
		self giveweapon(currentweapon, undefined);
		self switchtoweapon(currentweapon);
	#/
}

/*
	Name: devgui_attachment_cycling_think
	Namespace: devgui
	Checksum: 0x869B7077
	Offset: 0x1EA8
	Size: 0x178
	Parameters: 0
	Flags: None
*/
function devgui_attachment_cycling_think()
{
	/#
		for(;;)
		{
			state = getdvarstring(#"mp_attachment_cycling_state_devgui");
			setdvar(#"mp_attachment_cycling_state_devgui", "");
			if(issubstr(state, ""))
			{
				if("" == state)
				{
					for(i = 0; i < 6; i++)
					{
						devgui_attachment_cycling_clear(i);
					}
				}
				else
				{
					index = int(getsubstr(state, 6, 7));
					devgui_attachment_cycling_clear(index);
				}
				state = "";
			}
			if("" == state)
			{
				array::thread_all(getplayers(), &devgui_attachment_cycling_update);
			}
			wait(0.5);
		}
	#/
}

/*
	Name: devgui_give_weapon
	Namespace: devgui
	Checksum: 0x4715A566
	Offset: 0x2028
	Size: 0x84C
	Parameters: 1
	Flags: None
*/
function devgui_give_weapon(weapon_name)
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		self notify(#"devgui_give_ammo");
		self endon(#"devgui_give_ammo");
		endtime = gettime() + 10000;
		while(!isalive(self) && gettime() < endtime)
		{
			wait(0.25);
		}
		if(!isalive(self))
		{
			util::warning("" + weapon_name + "" + self.name + "" + self.name + "");
			return;
		}
		takeweapon = undefined;
		currentweapon = self getcurrentweapon();
		if(strstartswith(weapon_name, ""))
		{
			split = strtok(weapon_name, "");
			if(isdefined(split[2]))
			{
				if(split[2] == "")
				{
					var_18a8ed6e = 1;
				}
				else if(split[2] == "")
				{
					var_18a8ed6e = -1;
				}
				currentweaponname = currentweapon.name;
				currentattachment = "";
				if(isdefined(currentweapon.attachments) && isdefined(currentweapon.attachments[0]) && currentweapon.attachments[0] != "")
				{
					currentattachment = currentweapon.attachments[0];
				}
				supportedattachments = currentweapon.supportedattachments;
				var_a67ed7c5 = -1;
				if(supportedattachments.size)
				{
					var_a67ed7c5 = supportedattachments.size;
					for(i = 0; i < supportedattachments.size; i++)
					{
						if(supportedattachments[i] == currentattachment)
						{
							var_a67ed7c5 = i;
							break;
						}
					}
				}
				weapon = currentweapon;
				nextindex = -1;
				if(var_a67ed7c5 == supportedattachments.size)
				{
					if(var_18a8ed6e > 0)
					{
						nextindex = 0;
					}
					else
					{
						nextindex = supportedattachments.size - 1;
					}
				}
				else if(var_a67ed7c5 >= 0)
				{
					nextindex = supportedattachments.size + var_a67ed7c5 + var_18a8ed6e % supportedattachments.size;
				}
				if(nextindex >= 0 && nextindex < supportedattachments.size)
				{
					if(isdefined(supportedattachments[nextindex]))
					{
						attachment = supportedattachments[nextindex];
						takeweapon = currentweapon;
						weapon = getweapon(currentweaponname, attachment);
					}
				}
			}
		}
		else
		{
			split = strtok(weapon_name, "");
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
		}
		if(currentweapon != weapon)
		{
			if(weapon.isgrenadeweapon && !getdvarint(#"hash_1fce8e806b5356fc", 0))
			{
				grenades = 0;
				pweapons = self getweaponslist();
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
							self takeweapon(pweapon);
							if(grenades < 2)
							{
								break;
							}
						}
					}
				}
			}
			if(isdefined(takeweapon))
			{
				self takeweapon(takeweapon);
			}
			if(getdvarint(#"mp_weap_use_give_console_command_devgui", 0))
			{
				adddebugcommand("" + weapon_name);
				waitframe(1);
			}
			else
			{
				self giveweapon(weapon);
				if(!weapon.isgrenadeweapon)
				{
					self switchtoweapon(weapon);
				}
			}
			max = weapon.maxammo;
			if(max)
			{
				self setweaponammostock(weapon, max);
			}
			else
			{
				clipammo = self getweaponammoclip(weapon);
				if(clipammo == 0)
				{
					self setweaponammoclip(weapon, 1);
				}
			}
		}
	#/
}

/*
	Name: devgui_handle_player_command
	Namespace: devgui
	Checksum: 0xB55AAEFF
	Offset: 0x2880
	Size: 0x134
	Parameters: 3
	Flags: None
*/
function devgui_handle_player_command(playercallback, pcb_param_1, pcb_param_2)
{
	/#
		pid = getdvarint(#"mp_weap_devgui", 0);
		if(pid > 0)
		{
			player = getplayers()[pid - 1];
			if(isdefined(player))
			{
				if(isdefined(pcb_param_2))
				{
					player thread [[playercallback]](pcb_param_1, pcb_param_2);
				}
				else if(isdefined(pcb_param_1))
				{
					player thread [[playercallback]](pcb_param_1);
				}
				else
				{
					player thread [[playercallback]]();
				}
			}
		}
		else
		{
			array::thread_all(getplayers(), playercallback, pcb_param_1, pcb_param_2);
		}
		setdvar(#"mp_weap_devgui", "");
	#/
}

/*
	Name: init_debug_center_screen
	Namespace: devgui
	Checksum: 0x9E4A07EA
	Offset: 0x29C0
	Size: 0x12C
	Parameters: 0
	Flags: None
*/
function init_debug_center_screen()
{
	/#
		zero_idle_movement = 0;
		for(;;)
		{
			if(getdvarint(#"debug_center_screen", 0))
			{
				if(!isdefined(level.var_7929a046) || level.var_7929a046 == 0)
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
				level notify(#"hash_63054d2b7dcb7739");
				if(zero_idle_movement == 1)
				{
					setdvar(#"zero_idle_movement", 0);
					zero_idle_movement = 0;
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: debug_center_screen
	Namespace: devgui
	Checksum: 0x8A2325B2
	Offset: 0x2AF8
	Size: 0x9A
	Parameters: 0
	Flags: None
*/
function debug_center_screen()
{
	/#
		level.var_7929a046 = 1;
		wait(0.1);
		level.var_f9f04b00 debug_center_screen::open(level.players[0], 1);
		level waittill(#"hash_63054d2b7dcb7739");
		level.var_f9f04b00 debug_center_screen::close(level.players[0]);
		level.var_7929a046 = 0;
	#/
}

/*
	Name: add_vehicle_at_eye_trace
	Namespace: devgui
	Checksum: 0x73E1087F
	Offset: 0x2BA0
	Size: 0x128
	Parameters: 1
	Flags: None
*/
function add_vehicle_at_eye_trace(vehiclename)
{
	/#
		host = util::gethostplayer();
		trace = host bot::eye_trace();
		veh_spawner = getent(vehiclename + "", "");
		vehicle = veh_spawner spawnfromspawner(vehiclename, 1, 1, 1);
		vehicle asmrequestsubstate(#"locomotion@movement");
		waitframe(1);
		vehicle makevehicleusable();
		vehicle.origin = trace[#"position"];
		vehicle.nojumping = 1;
		vehicle thread watch_player_death();
		return vehicle;
	#/
}

/*
	Name: watch_player_death
	Namespace: devgui
	Checksum: 0xF940376
	Offset: 0x2CD8
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function watch_player_death()
{
	/#
		self endon(#"death");
		vehicle = self;
		while(true)
		{
			driver = self getseatoccupant(0);
			if(isdefined(driver) && !isalive(driver))
			{
				driver unlink();
			}
			waitframe(1);
		}
	#/
}

/*
	Name: devgui_add_ve_map_switches
	Namespace: devgui
	Checksum: 0x420464E6
	Offset: 0x2D70
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function devgui_add_ve_map_switches()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_6a24e58f
	Namespace: devgui
	Checksum: 0x64DC6FEB
	Offset: 0x2DD0
	Size: 0x65E
	Parameters: 0
	Flags: None
*/
function function_6a24e58f()
{
	/#
		level notify(#"hash_254f5df0e8f1d66");
		level endon(#"hash_254f5df0e8f1d66");
		setdvar(#"hash_3a3f995b08f2b9b8", -1);
		setdvar(#"hash_2aab28ebf600b8c7", -1);
		setdvar(#"hash_4874e2dd28221d6c", -1);
		wait(0.5);
		path = "";
		cmd = "";
		util::function_e2e9d901(path + "", cmd + "");
		for(minutes = 0; minutes < 10; minutes++)
		{
			seconds = 0;
			while(seconds < 60)
			{
				var_99cfbb07 = "" + seconds;
				totalseconds = minutes * 60 + seconds;
				if(seconds == 0)
				{
					if(minutes == 0)
					{
						totalseconds = 1;
						var_99cfbb07 = "";
					}
					else
					{
						var_99cfbb07 = "";
					}
				}
				util::function_e2e9d901(path + minutes + "" + var_99cfbb07, cmd + totalseconds);
				seconds = seconds + 15;
			}
			waitframe(1);
		}
		var_a11730e4 = "";
		var_eb72e2d3 = "";
		var_3b0a5dad = "";
		var_5f2cb965 = "";
		if(util::isroundbased())
		{
			var_ca373442 = level.roundlimit * level.roundscorelimit;
		}
		else
		{
			var_ca373442 = level.scorelimit;
		}
		var_ca373442 = math::clamp(var_ca373442, 0, 300);
		wait(0.5);
		for(score = 0; score <= var_ca373442; score++)
		{
			var_8acb4d22 = int(score / 10) * 10;
			var_daf8d664 = int(score / 10) * 10 + 10;
			util::function_e2e9d901(var_a11730e4 + var_8acb4d22 + "" + var_daf8d664 + "" + var_8acb4d22 + "" + score, var_eb72e2d3 + score);
			util::function_e2e9d901(var_3b0a5dad + var_8acb4d22 + "" + var_daf8d664 + "" + var_8acb4d22 + "" + score, var_5f2cb965 + score);
			if(score == var_daf8d664)
			{
				waitframe(1);
			}
		}
		while(true)
		{
			if(getdvarint(#"hash_3a3f995b08f2b9b8", -1) != -1)
			{
				var_6d2040ea = getdvarint(#"hash_3a3f995b08f2b9b8", -1);
				var_14f1a63 = int(var_6d2040ea * 1000) + globallogic_utils::gettimepassed() / int(60 * 1000);
				if(var_6d2040ea == 0)
				{
					var_14f1a63 = 0;
				}
				setdvar(#"hash_5424bc2a81bcb188", var_14f1a63);
				setdvar(#"hash_3a3f995b08f2b9b8", -1);
			}
			if(getdvarint(#"hash_2aab28ebf600b8c7", -1) != -1)
			{
				var_168b7d5 = getdvarint(#"hash_2aab28ebf600b8c7", -1);
				[[level._setteamscore]](#"allies", var_168b7d5);
				setdvar(#"hash_2aab28ebf600b8c7", -1);
			}
			if(getdvarint(#"hash_4874e2dd28221d6c", -1) != -1)
			{
				var_46c53e6e = getdvarint(#"hash_4874e2dd28221d6c", -1);
				[[level._setteamscore]](#"axis", var_46c53e6e);
				setdvar(#"hash_4874e2dd28221d6c", -1);
			}
			wait(1);
		}
	#/
}

/*
	Name: function_7bef8d25
	Namespace: devgui
	Checksum: 0xB5557B13
	Offset: 0x3438
	Size: 0x1A0
	Parameters: 0
	Flags: None
*/
function function_7bef8d25()
{
	/#
		level notify(#"hash_6a8b1c9e1485919d");
		level endon(#"hash_6a8b1c9e1485919d");
		wait(5);
		function_e4b86469();
		wait(1);
		while(true)
		{
			wait(0.25);
			remaining_health = getdvarint(#"hash_28af507d964c5802", 0);
			if(remaining_health <= 0)
			{
				continue;
			}
			player = level.players[0];
			if(isplayer(player))
			{
				remaining_health = math::clamp(remaining_health, 0, (isdefined(player.maxhealth) ? player.maxhealth : 100));
				damage = player.health - remaining_health;
				if(damage <= 0)
				{
					player.health = remaining_health;
				}
				else
				{
					player dodamage(damage, player.origin + vectorscale((1, 0, 0), 100));
				}
			}
			setdvar(#"hash_28af507d964c5802", 0);
		}
	#/
}

/*
	Name: function_46b22d99
	Namespace: devgui
	Checksum: 0x817CE5EA
	Offset: 0x35E0
	Size: 0x1B8
	Parameters: 0
	Flags: None
*/
function function_46b22d99()
{
	/#
		level notify(#"hash_4c09c9d01060d7ad");
		level endon(#"hash_4c09c9d01060d7ad");
		wait(2);
		function_9fb69cba();
		wait(0.5);
		while(true)
		{
			wait(0.5);
			if(level.gameended)
			{
				continue;
			}
			var_7442b0e6 = getdvarint(#"hash_410a22566f5a0b32", 0);
			if(var_7442b0e6 == 0)
			{
				continue;
			}
			setdvar(#"hash_410a22566f5a0b32", 0);
			var_53b4c3ae = getgametypesetting(#"timelimit");
			var_c585681e = 0.25;
			setgametypesetting("", var_c585681e);
			aborted = 0;
			while(!level.gameended && !aborted)
			{
				wait(0.5);
				aborted = getgametypesetting(#"timelimit") != var_c585681e;
			}
			if(!aborted)
			{
				setgametypesetting("", var_53b4c3ae);
			}
		}
	#/
}

/*
	Name: function_be0f9897
	Namespace: devgui
	Checksum: 0x961260C6
	Offset: 0x37A0
	Size: 0x1D8
	Parameters: 0
	Flags: None
*/
function function_be0f9897()
{
	/#
		level notify(#"hash_7528b3262d076f59");
		level endon(#"hash_7528b3262d076f59");
		wait(5.5);
		function_51cc2292();
		wait(1);
		while(true)
		{
			wait(0.25);
			damage = getdvarint(#"hash_3ea62f6d7351287c", 0);
			if(damage == 0)
			{
				continue;
			}
			player = level.players[0];
			if(isplayer(player))
			{
				if(damage <= 0)
				{
					heal = damage * -1;
					var_66cb03ad = (player.var_66cb03ad > 0 ? player.var_66cb03ad : player.maxhealth);
					if(!isdefined(var_66cb03ad))
					{
						var_66cb03ad = 100;
					}
					if(player.health + heal > var_66cb03ad)
					{
						player.health = var_66cb03ad;
					}
					else
					{
						player.health = player.health + heal;
					}
				}
				else
				{
					player dodamage(damage, player.origin + vectorscale((1, 0, 0), 100));
				}
			}
			setdvar(#"hash_3ea62f6d7351287c", 0);
		}
	#/
}

/*
	Name: function_773432e2
	Namespace: devgui
	Checksum: 0xC2C84576
	Offset: 0x3980
	Size: 0x250
	Parameters: 0
	Flags: None
*/
function function_773432e2()
{
	/#
		level notify(#"hash_6534754fb1d75ea7");
		level endon(#"hash_6534754fb1d75ea7");
		while(!isdefined(level.scoreinfo))
		{
			wait(1);
		}
		function_354e12a4();
		while(true)
		{
			wait(0.1);
			var_aa8173e0 = getdvarint(#"hash_649ea18bd5e55893", -1);
			var_97c83f66 = getdvarint(#"hash_6ad3f58a8e0a1e59", -1);
			var_9721ecc = getdvarint(#"hash_4c63911d0d26443c", -1);
			if(var_aa8173e0 == -1 && var_97c83f66 == -1 && var_9721ecc == -1)
			{
				continue;
			}
			player = level.players[0];
			if(isplayer(player))
			{
				if(var_aa8173e0 != -1)
				{
					player luinotifyevent(#"hash_468a2878939e8c64", 1, var_aa8173e0);
				}
				if(var_97c83f66 != -1)
				{
					player luinotifyevent(#"hash_2ba26a631965ab0b", 1, var_97c83f66);
				}
				if(var_9721ecc != -1)
				{
					player clientfield::set_player_uimodel("", var_9721ecc);
				}
			}
			setdvar(#"hash_649ea18bd5e55893", -1);
			setdvar(#"hash_6ad3f58a8e0a1e59", -1);
		}
	#/
}

/*
	Name: function_e4b86469
	Namespace: devgui
	Checksum: 0x79C9E1FF
	Offset: 0x3BD8
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function function_e4b86469()
{
	/#
		path = "";
		cmd = "";
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
	#/
}

/*
	Name: function_51cc2292
	Namespace: devgui
	Checksum: 0x8F3C157F
	Offset: 0x3D08
	Size: 0x174
	Parameters: 0
	Flags: None
*/
function function_51cc2292()
{
	/#
		path = "";
		cmd = "";
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
		util::function_e2e9d901(path + "", cmd + "");
	#/
}

/*
	Name: function_9fb69cba
	Namespace: devgui
	Checksum: 0x8933067F
	Offset: 0x3E88
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_9fb69cba()
{
	/#
		util::function_e2e9d901("", "");
	#/
}

/*
	Name: function_354e12a4
	Namespace: devgui
	Checksum: 0xDBF706A0
	Offset: 0x3EC0
	Size: 0x2CC
	Parameters: 0
	Flags: None
*/
function function_354e12a4()
{
	/#
		path = "";
		cmd = "";
		var_ab79c6df = "";
		var_b917e8e0 = getarraykeys(level.scoreinfo);
		for(i = 0; i < var_b917e8e0.size; i++)
		{
			key = var_b917e8e0[i];
			action = level.scoreinfo[key];
			if(isdefined(action) && isdefined(action[#"row"]))
			{
				if(isdefined(action[#"hash_7fe1763a3ac14691"]))
				{
					keystring = function_9e72a96(key);
					util::function_e2e9d901(path + "" + keystring[0] + "" + keystring, cmd + action[#"row"]);
					if(isdefined(action[#"hash_401b1493e5188252"]) && action[#"hash_401b1493e5188252"] == #"ender")
					{
						util::function_e2e9d901(path + "" + keystring[0] + "" + keystring, var_ab79c6df + action[#"row"]);
					}
				}
			}
		}
		var_e625686f = path + "";
		var_f99507b8 = "";
		util::function_e2e9d901(var_e625686f + "", var_f99507b8 + "");
		util::function_e2e9d901(var_e625686f + "", var_f99507b8 + "");
		util::function_e2e9d901(var_e625686f + "", var_f99507b8 + "");
		util::function_e2e9d901(var_e625686f + "", var_f99507b8 + "");
	#/
}

/*
	Name: function_57edec18
	Namespace: devgui
	Checksum: 0x8D8AF454
	Offset: 0x4198
	Size: 0x1DE
	Parameters: 0
	Flags: Private
*/
private function function_57edec18()
{
	/#
		util::function_e2e9d901("", "");
		util::function_e2e9d901("", "");
		while(true)
		{
			if(getdvarint(#"hash_428eca4823d65134", 0))
			{
				if(isdefined(level.var_6460e605))
				{
					waitframe(1);
					continue;
				}
				player = getplayers()[0];
				if(!isdefined(player))
				{
					waitframe(1);
					continue;
				}
				var_6460e605 = spawnvehicle("", player.origin + vectorscale((0, 0, 1), 150), player.angles, "");
				var_6460e605.ignoreme = 1;
				var_6460e605 usevehicle(player, 0);
				level.var_6460e605 = var_6460e605;
			}
			else if(isdefined(level.var_6460e605))
			{
				driver = level.var_6460e605 getseatoccupant(0);
				if(isdefined(driver))
				{
					driver unlink();
				}
				level.var_6460e605 delete();
			}
			waitframe(1);
		}
	#/
}

