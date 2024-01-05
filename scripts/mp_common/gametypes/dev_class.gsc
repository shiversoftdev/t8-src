// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\dev.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace dev_class;

/*
	Name: dev_cac_init
	Namespace: dev_class
	Checksum: 0xCE9F9E88
	Offset: 0x78
	Size: 0x888
	Parameters: 0
	Flags: None
*/
function dev_cac_init()
{
	/#
		dev_cac_overlay = 0;
		dev_cac_camera_on = 0;
		level thread dev_cac_gdt_update_think();
		var_b7b0fdc0 = getdvarint(#"hash_158f81eb73a459bd", 0);
		var_1db243f1 = getdvarint(#"hash_729117f20b736ab4", 0);
		for(;;)
		{
			wait(0.5);
			reset = 1;
			if(getdvarstring(#"scr_disable_cac_2") != "")
			{
				continue;
			}
			host = util::gethostplayer();
			if(!isdefined(level.dev_cac_player))
			{
				level.dev_cac_player = host;
			}
			switch(getdvarstring(#"devgui_dev_cac"))
			{
				case 0:
				{
					reset = 0;
					break;
				}
				case "dpad_body":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_body, "");
					break;
				}
				case "dpad_head":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_head, "");
					break;
				}
				case "dpad_character":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_character, "");
					break;
				}
				case "next_player":
				{
					dev_cac_cycle_player(1);
					break;
				}
				case "prev_player":
				{
					dev_cac_cycle_player(0);
					break;
				}
				case "cac_overlay":
				{
					level notify(#"dev_cac_overlay_think");
					if(!dev_cac_overlay)
					{
						level thread dev_cac_overlay_think();
					}
					dev_cac_overlay = !dev_cac_overlay;
					break;
				}
				case "best_bullet_armor":
				{
					dev_cac_set_model_range(&sort_greatest, "");
					break;
				}
				case "worst_bullet_armor":
				{
					dev_cac_set_model_range(&sort_least, "");
					break;
				}
				case "best_explosive_armor":
				{
					dev_cac_set_model_range(&sort_greatest, "");
					break;
				}
				case "worst_explosive_armor":
				{
					dev_cac_set_model_range(&sort_least, "");
					break;
				}
				case "best_mobility":
				{
					dev_cac_set_model_range(&sort_greatest, "");
					break;
				}
				case "worst_mobility":
				{
					dev_cac_set_model_range(&sort_least, "");
					break;
				}
				case "camera":
				{
					dev_cac_camera_on = !dev_cac_camera_on;
					dev_cac_camera(dev_cac_camera_on);
					break;
				}
				case "dpad_camo":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "dpad_meleecamo":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "dpad_lens":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "dpad_reticle":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "hash_70b765122950a76":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "dpad_reticle_color":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "dpad_emblem":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "dpad_tag":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "dpad_facepaint_pattern":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "dpad_facepaint_color":
				{
					host thread dev_cac_dpad_think("", &dev_cac_cycle_render_options, "");
					break;
				}
				case "dpad_reset":
				{
					host notify(#"dev_cac_dpad_think");
					break;
				}
			}
			if(reset)
			{
				setdvar(#"devgui_dev_cac", "");
			}
			charmindex = getdvarint(#"hash_158f81eb73a459bd", 0);
			if(var_b7b0fdc0 != charmindex)
			{
				host function_3fb8b14(host getcurrentweapon(), charmindex);
			}
			var_b7b0fdc0 = charmindex;
			var_2febbde5 = getdvarint(#"hash_729117f20b736ab4", 0);
			if(var_1db243f1 != var_2febbde5)
			{
				host function_a85d2581(host getcurrentweapon(), var_2febbde5);
			}
			var_1db243f1 = var_2febbde5;
		}
	#/
}

/*
	Name: dev_cac_camera
	Namespace: dev_class
	Checksum: 0xE759AA80
	Offset: 0x908
	Size: 0x104
	Parameters: 1
	Flags: None
*/
function dev_cac_camera(on)
{
	/#
		if(on)
		{
			self setclientthirdperson(1);
			setdvar(#"cg_thirdpersonangle", 185);
			setdvar(#"cg_thirdpersonrange", 138);
			setdvar(#"cg_fov", 20);
		}
		else
		{
			self setclientthirdperson(0);
			setdvar(#"cg_fov", getdvarstring(#"cg_fov_default"));
		}
	#/
}

/*
	Name: dev_cac_dpad_think
	Namespace: dev_class
	Checksum: 0x9CAE58CA
	Offset: 0xA18
	Size: 0x20E
	Parameters: 3
	Flags: None
*/
function dev_cac_dpad_think(part_name, cycle_function, tag)
{
	/#
		self notify(#"dev_cac_dpad_think");
		self endon(#"dev_cac_dpad_think", #"disconnect");
		iprintln(("" + part_name) + "");
		iprintln(("" + part_name) + "");
		dpad_left = 0;
		dpad_right = 0;
		level.dev_cac_player thread highlight_player();
		for(;;)
		{
			self setactionslot(3, "");
			self setactionslot(4, "");
			if(!dpad_left && self buttonpressed(""))
			{
				[[cycle_function]](0, tag);
				dpad_left = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_left = 0;
			}
			if(!dpad_right && self buttonpressed(""))
			{
				[[cycle_function]](1, tag);
				dpad_right = 1;
			}
			else if(!self buttonpressed(""))
			{
				dpad_right = 0;
			}
			waitframe(1);
		}
	#/
}

/*
	Name: next_in_list
	Namespace: dev_class
	Checksum: 0x63CE20F0
	Offset: 0xC30
	Size: 0xA6
	Parameters: 2
	Flags: None
*/
function next_in_list(value, list)
{
	/#
		if(!isdefined(value))
		{
			return list[0];
		}
		for(i = 0; i < list.size; i++)
		{
			if(value == list[i])
			{
				if(isdefined(list[i + 1]))
				{
					value = list[i + 1];
				}
				else
				{
					value = list[0];
				}
				break;
			}
		}
		return value;
	#/
}

/*
	Name: prev_in_list
	Namespace: dev_class
	Checksum: 0x93F8519F
	Offset: 0xCE0
	Size: 0xB0
	Parameters: 2
	Flags: None
*/
function prev_in_list(value, list)
{
	/#
		if(!isdefined(value))
		{
			return list[0];
		}
		for(i = 0; i < list.size; i++)
		{
			if(value == list[i])
			{
				if(isdefined(list[i - 1]))
				{
					value = list[i - 1];
				}
				else
				{
					value = list[list.size - 1];
				}
				break;
			}
		}
		return value;
	#/
}

/*
	Name: dev_cac_set_player_model
	Namespace: dev_class
	Checksum: 0xFFB21ABB
	Offset: 0xDA0
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function dev_cac_set_player_model()
{
	/#
		self.tag_stowed_back = undefined;
		self.tag_stowed_hip = undefined;
	#/
}

/*
	Name: dev_cac_cycle_body
	Namespace: dev_class
	Checksum: 0x96D9E841
	Offset: 0xDC8
	Size: 0xEC
	Parameters: 2
	Flags: None
*/
function dev_cac_cycle_body(forward, tag)
{
	/#
		if(!dev_cac_player_valid())
		{
			return;
		}
		player = level.dev_cac_player;
		keys = getarraykeys(level.cac_functions[#"set_body_model"]);
		if(forward)
		{
			player.cac_body_type = next_in_list(player.cac_body_type, keys);
		}
		else
		{
			player.cac_body_type = prev_in_list(player.cac_body_type, keys);
		}
		player dev_cac_set_player_model();
	#/
}

/*
	Name: dev_cac_cycle_head
	Namespace: dev_class
	Checksum: 0x9592723E
	Offset: 0xEC0
	Size: 0xFC
	Parameters: 2
	Flags: None
*/
function dev_cac_cycle_head(forward, tag)
{
	/#
		if(!dev_cac_player_valid())
		{
			return;
		}
		player = level.dev_cac_player;
		keys = getarraykeys(level.cac_functions[#"set_head_model"]);
		if(forward)
		{
			player.cac_head_type = next_in_list(player.cac_head_type, keys);
		}
		else
		{
			player.cac_head_type = prev_in_list(player.cac_head_type, keys);
		}
		player.cac_hat_type = "";
		player dev_cac_set_player_model();
	#/
}

/*
	Name: dev_cac_cycle_character
	Namespace: dev_class
	Checksum: 0x83DABD82
	Offset: 0xFC8
	Size: 0xFC
	Parameters: 2
	Flags: None
*/
function dev_cac_cycle_character(forward, tag)
{
	/#
		if(!dev_cac_player_valid())
		{
			return;
		}
		player = level.dev_cac_player;
		keys = getarraykeys(level.cac_functions[#"set_body_model"]);
		if(forward)
		{
			player.cac_body_type = next_in_list(player.cac_body_type, keys);
		}
		else
		{
			player.cac_body_type = prev_in_list(player.cac_body_type, keys);
		}
		player.cac_hat_type = "";
		player dev_cac_set_player_model();
	#/
}

/*
	Name: dev_cac_cycle_render_options
	Namespace: dev_class
	Checksum: 0x32DEAEDE
	Offset: 0x10D0
	Size: 0x5C
	Parameters: 3
	Flags: None
*/
function dev_cac_cycle_render_options(forward, tag, count)
{
	/#
		if(!dev_cac_player_valid())
		{
			return;
		}
		level.dev_cac_player nextplayerrenderoption(tag, forward, count);
	#/
}

/*
	Name: dev_cac_player_valid
	Namespace: dev_class
	Checksum: 0xB801A453
	Offset: 0x1138
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function dev_cac_player_valid()
{
	/#
		return isdefined(level.dev_cac_player) && level.dev_cac_player.sessionstate == "";
	#/
}

/*
	Name: dev_cac_cycle_player
	Namespace: dev_class
	Checksum: 0x4476A902
	Offset: 0x1178
	Size: 0xEA
	Parameters: 1
	Flags: None
*/
function dev_cac_cycle_player(forward)
{
	/#
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(forward)
			{
				level.dev_cac_player = next_in_list(level.dev_cac_player, players);
			}
			else
			{
				level.dev_cac_player = prev_in_list(level.dev_cac_player, players);
			}
			if(dev_cac_player_valid())
			{
				level.dev_cac_player thread highlight_player();
				return;
			}
		}
		level.dev_cac_player = undefined;
	#/
}

/*
	Name: highlight_player
	Namespace: dev_class
	Checksum: 0x2758F316
	Offset: 0x1270
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function highlight_player()
{
	/#
		self sethighlighted(1);
		wait(1);
		self sethighlighted(0);
	#/
}

/*
	Name: dev_cac_overlay_think
	Namespace: dev_class
	Checksum: 0xAC6A7728
	Offset: 0x12C0
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function dev_cac_overlay_think()
{
	/#
		hud = dev_cac_overlay_create();
		level thread dev_cac_overlay_update(hud);
		level waittill(#"dev_cac_overlay_think");
		dev_cac_overlay_destroy(hud);
	#/
}

/*
	Name: dev_cac_overlay_update
	Namespace: dev_class
	Checksum: 0x79BA825
	Offset: 0x1338
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function dev_cac_overlay_update(hud)
{
	/#
	#/
}

/*
	Name: dev_cac_overlay_destroy
	Namespace: dev_class
	Checksum: 0x479ECD34
	Offset: 0x1350
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function dev_cac_overlay_destroy(hud)
{
	/#
		for(i = 0; i < hud.menu.size; i++)
		{
			hud.menu[i] destroy();
		}
		hud destroy();
		setdvar(#"player_debugsprint", 0);
	#/
}

/*
	Name: dev_cac_overlay_create
	Namespace: dev_class
	Checksum: 0x2EAE74C9
	Offset: 0x13F0
	Size: 0xD72
	Parameters: 0
	Flags: None
*/
function dev_cac_overlay_create()
{
	/#
		x = -80;
		y = 140;
		menu_name = "";
		hud = dev::new_hud(menu_name, undefined, x, y, 1);
		hud setshader(#"white", 185, 285);
		hud.alignx = "";
		hud.aligny = "";
		hud.sort = 10;
		hud.alpha = 0.6;
		hud.color = vectorscale((0, 0, 1), 0.5);
		x_offset = 100;
		hud.menu[0] = dev::new_hud(menu_name, "", x + 5, y + 10, 1.3);
		hud.menu[1] = dev::new_hud(menu_name, "", x + 5, y + 25, 1);
		hud.menu[2] = dev::new_hud(menu_name, "", x + 5, y + 35, 1);
		hud.menu[3] = dev::new_hud(menu_name, "", x + 5, y + 45, 1);
		hud.menu[4] = dev::new_hud(menu_name, "", x + 5, y + 55, 1);
		hud.menu[5] = dev::new_hud(menu_name, "", x + 5, y + 70, 1);
		hud.menu[6] = dev::new_hud(menu_name, "", x + 5, y + 80, 1);
		hud.menu[7] = dev::new_hud(menu_name, "", x + 5, y + 90, 1);
		hud.menu[8] = dev::new_hud(menu_name, "", x + 5, y + 100, 1);
		hud.menu[9] = dev::new_hud(menu_name, "", x + 5, y + 110, 1);
		hud.menu[10] = dev::new_hud(menu_name, "", x + 5, y + 120, 1);
		hud.menu[11] = dev::new_hud(menu_name, "", x + 5, y + 135, 1);
		hud.menu[12] = dev::new_hud(menu_name, "", x + 5, y + 145, 1);
		hud.menu[13] = dev::new_hud(menu_name, "", x + 5, y + 155, 1);
		hud.menu[14] = dev::new_hud(menu_name, "", x + 5, y + 170, 1);
		hud.menu[15] = dev::new_hud(menu_name, "", x + 5, y + 180, 1);
		hud.menu[16] = dev::new_hud(menu_name, "", x + 5, y + 190, 1);
		hud.menu[17] = dev::new_hud(menu_name, "", x + 5, y + 205, 1);
		hud.menu[18] = dev::new_hud(menu_name, "", x + 5, y + 215, 1);
		hud.menu[19] = dev::new_hud(menu_name, "", x + 5, y + 225, 1);
		hud.menu[20] = dev::new_hud(menu_name, "", x + 5, y + 235, 1);
		hud.menu[21] = dev::new_hud(menu_name, "", x + 5, y + 245, 1);
		hud.menu[22] = dev::new_hud(menu_name, "", x + 5, y + 255, 1);
		hud.menu[23] = dev::new_hud(menu_name, "", x + 5, y + 265, 1);
		hud.menu[24] = dev::new_hud(menu_name, "", x + 5, y + 275, 1);
		x_offset = 65;
		hud.menu[25] = dev::new_hud(menu_name, "", x + x_offset, y + 35, 1);
		hud.menu[26] = dev::new_hud(menu_name, "", x + x_offset, y + 45, 1);
		hud.menu[27] = dev::new_hud(menu_name, "", x + x_offset, y + 55, 1);
		x_offset = 100;
		hud.menu[28] = dev::new_hud(menu_name, "", x + x_offset, y + 80, 1);
		hud.menu[29] = dev::new_hud(menu_name, "", x + x_offset, y + 90, 1);
		hud.menu[30] = dev::new_hud(menu_name, "", x + x_offset, y + 100, 1);
		hud.menu[31] = dev::new_hud(menu_name, "", x + x_offset, y + 110, 1);
		hud.menu[32] = dev::new_hud(menu_name, "", x + x_offset, y + 120, 1);
		hud.menu[33] = dev::new_hud(menu_name, "", x + x_offset, y + 145, 1);
		hud.menu[34] = dev::new_hud(menu_name, "", x + x_offset, y + 155, 1);
		hud.menu[35] = dev::new_hud(menu_name, "", x + x_offset, y + 180, 1);
		hud.menu[36] = dev::new_hud(menu_name, "", x + x_offset, y + 190, 1);
		x_offset = 65;
		hud.menu[37] = dev::new_hud(menu_name, "", x + x_offset, y + 215, 1);
		hud.menu[38] = dev::new_hud(menu_name, "", x + x_offset, y + 225, 1);
		hud.menu[39] = dev::new_hud(menu_name, "", x + x_offset, y + 235, 1);
		hud.menu[40] = dev::new_hud(menu_name, "", x + x_offset, y + 245, 1);
		hud.menu[41] = dev::new_hud(menu_name, "", x + x_offset, y + 255, 1);
		hud.menu[42] = dev::new_hud(menu_name, "", x + x_offset, y + 265, 1);
		hud.menu[43] = dev::new_hud(menu_name, "", x + x_offset, y + 275, 1);
		return hud;
	#/
}

/*
	Name: color
	Namespace: dev_class
	Checksum: 0x6E8BEC05
	Offset: 0x2170
	Size: 0x96
	Parameters: 1
	Flags: None
*/
function color(value)
{
	/#
		r = 1;
		g = 1;
		b = 0;
		color = (0, 0, 0);
		if(value > 0)
		{
			r = r - value;
		}
		else
		{
			g = g + value;
		}
		c = (r, g, b);
		return c;
	#/
}

/*
	Name: dev_cac_gdt_update_think
	Namespace: dev_class
	Checksum: 0xD34A8B87
	Offset: 0x2210
	Size: 0x1F8
	Parameters: 0
	Flags: None
*/
function dev_cac_gdt_update_think()
{
	/#
		for(;;)
		{
			waitresult = undefined;
			waitresult = level waittill(#"gdt_update");
			asset = waitresult.asset;
			keyvalue = waitresult.keyvalue;
			keyvalue = strtok(keyvalue, "");
			key = keyvalue[0];
			switch(key)
			{
				case "armorbullet":
				{
					key = "";
					break;
				}
				case "armorexplosive":
				{
					key = "";
					break;
				}
				case "movespeed":
				{
					key = "";
					break;
				}
				case "sprinttimetotal":
				{
					key = "";
					break;
				}
				case "sprinttimecooldown":
				{
					key = "";
					break;
				}
				default:
				{
					key = undefined;
					break;
				}
			}
			if(!isdefined(key))
			{
				continue;
			}
			value = float(keyvalue[1]);
			level.cac_attributes[key][asset] = value;
			players = getplayers();
			for(i = 0; i < players.size; i++)
			{
			}
		}
	#/
}

/*
	Name: sort_greatest
	Namespace: dev_class
	Checksum: 0x806BCE3
	Offset: 0x2410
	Size: 0xC6
	Parameters: 3
	Flags: None
*/
function sort_greatest(func, attribute, greatest)
{
	/#
		keys = getarraykeys(level.cac_functions[func]);
		greatest = keys[0];
		for(i = 0; i < keys.size; i++)
		{
			if(level.cac_attributes[attribute][keys[i]] > level.cac_attributes[attribute][greatest])
			{
				greatest = keys[i];
			}
		}
		return greatest;
	#/
}

/*
	Name: sort_least
	Namespace: dev_class
	Checksum: 0xDF4ADD37
	Offset: 0x24E0
	Size: 0xC6
	Parameters: 3
	Flags: None
*/
function sort_least(func, attribute, least)
{
	/#
		keys = getarraykeys(level.cac_functions[func]);
		least = keys[0];
		for(i = 0; i < keys.size; i++)
		{
			if(level.cac_attributes[attribute][keys[i]] < level.cac_attributes[attribute][least])
			{
				least = keys[i];
			}
		}
		return least;
	#/
}

/*
	Name: dev_cac_set_model_range
	Namespace: dev_class
	Checksum: 0x5B74BA79
	Offset: 0x25B0
	Size: 0xBC
	Parameters: 2
	Flags: None
*/
function dev_cac_set_model_range(sort_function, attribute)
{
	/#
		if(!dev_cac_player_valid())
		{
			return;
		}
		player = level.dev_cac_player;
		player.cac_body_type = [[sort_function]]("", attribute);
		player.cac_head_type = [[sort_function]]("", attribute);
		player.cac_hat_type = [[sort_function]]("", attribute);
		player dev_cac_set_player_model();
	#/
}

