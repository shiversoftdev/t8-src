// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_39bd5b6b799b1c9c;
#using script_8abfb58852911dd;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_b56b91cb;

/*
	Name: function_89f2df9
	Namespace: namespace_b56b91cb
	Checksum: 0xDD14695D
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_637836cd1d98abbd", &__init__, undefined, #"item_world");
}

/*
	Name: __init__
	Namespace: namespace_b56b91cb
	Checksum: 0xA157F489
	Offset: 0xF8
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	if(!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	/#
		level thread function_44b9dd1d();
	#/
	/#
		level thread function_cdd9b388();
	#/
	/#
		level thread function_91ef342();
	#/
}

/*
	Name: function_13d7bba
	Namespace: namespace_b56b91cb
	Checksum: 0xF882CAA3
	Offset: 0x1A8
	Size: 0xBE
	Parameters: 2
	Flags: Private
*/
function private function_13d7bba(xoffset, yoffset)
{
	/#
		elem = newdebughudelem();
		elem.alignx = "";
		elem.horzalign = "";
		elem.x = xoffset + 0;
		elem.y = yoffset;
		elem.fontscale = 1;
		elem.color = (1, 1, 1);
		elem.fontstyle3d = "";
		return elem;
	#/
}

/*
	Name: function_11421106
	Namespace: namespace_b56b91cb
	Checksum: 0xAE9AC26B
	Offset: 0x270
	Size: 0x324
	Parameters: 2
	Flags: Private
*/
function private function_11421106(typestring, type)
{
	/#
		tab = "";
		loc_000002D0:
		loc_00000304:
		loc_0000038C:
		loc_000003C0:
		loc_0000044C:
		loc_00000480:
		loc_0000050C:
		return ((((((((((((((typestring + "") + (isdefined(level.var_efeab371[type]) ? level.var_efeab371[type] : 0) + "") + (int((isdefined(level.var_efeab371[type]) ? level.var_efeab371[type] : 0) / int(max(level.var_66e56764, 1)) * 100)) + "") + tab) + "") + (isdefined(level.var_d80c35aa[type]) ? level.var_d80c35aa[type] : 0) + "") + (int((isdefined(level.var_d80c35aa[type]) ? level.var_d80c35aa[type] : 0) / int(max(level.var_136445c0, 1)) * 100)) + "") + tab) + "") + (isdefined(level.var_8d9ad8e8[type]) ? level.var_8d9ad8e8[type] : 0) + "") + (int((isdefined(level.var_8d9ad8e8[type]) ? level.var_8d9ad8e8[type] : 0) / int(max(level.var_5720c09a, 1)) * 100)) + "") + tab) + "") + (isdefined(level.var_ecf16fd3[type]) ? level.var_ecf16fd3[type] : 0) + "") + (int((isdefined(level.var_ecf16fd3[type]) ? level.var_ecf16fd3[type] : 0) / int(max(level.var_2850ef5, 1)) * 100)) + "";
	#/
}

/*
	Name: function_bebe535
	Namespace: namespace_b56b91cb
	Checksum: 0xF0AB61C3
	Offset: 0x5A0
	Size: 0x214
	Parameters: 0
	Flags: Private
*/
function private function_bebe535()
{
	/#
		n_total = 0;
		var_9243cc66 = 0;
		foreach(i, list in level.var_2e96a450)
		{
			var_98ed4e60 = function_9e72a96(i);
			println((var_98ed4e60 + "") + list);
			n_total = n_total + list;
			a_tokens = strtok(var_98ed4e60, "");
			foreach(token in a_tokens)
			{
				if(token === "" || token === "")
				{
					var_9243cc66 = var_9243cc66 + list;
					break;
				}
			}
		}
		if(isdefined(level.var_2e96a450[#"hash_4d4893453c660a3d"]))
		{
			var_9243cc66 = var_9243cc66 - level.var_2e96a450[#"hash_4d4893453c660a3d"];
		}
		println("" + n_total);
		println("" + var_9243cc66);
	#/
}

/*
	Name: function_2248268e
	Namespace: namespace_b56b91cb
	Checksum: 0x8AD82149
	Offset: 0x7C0
	Size: 0xB0
	Parameters: 0
	Flags: Private
*/
function private function_2248268e()
{
	/#
		vehicles = getvehiclearray();
		foreach(vehicle in vehicles)
		{
			if(isdefined(vehicle.scriptvehicletype))
			{
				println(vehicle.scriptvehicletype);
			}
		}
	#/
}

/*
	Name: function_b6ea080
	Namespace: namespace_b56b91cb
	Checksum: 0xB018B76E
	Offset: 0x878
	Size: 0x724
	Parameters: 0
	Flags: Private
*/
function private function_b6ea080()
{
	/#
		self notify("");
		self endon("");
		file = openfile("", "");
		if(file == -1)
		{
			iprintlnbold("");
			return;
		}
		println("");
		mapname = util::function_53bbf9d2();
		if(mapname === "" || mapname == "")
		{
			world_items = [8:"", 7:"", 6:"", 5:"", 4:"", 3:"", 2:"", 1:"", 0:""];
		}
		else
		{
			world_items = [40:"", 39:"", 38:"", 37:"", 36:"", 35:"", 34:"", 33:"", 32:"", 31:"", 30:"", 29:"", 28:"", 27:"", 26:"", 25:"", 24:"", 23:"", 22:"", 21:"", 20:"", 19:"", 18:"", 17:"", 16:"", 15:"", 14:"", 13:"", 12:"", 11:"", 10:"", 9:"", 8:"", 7:"", 6:"", 5:"", 4:"", 3:"", 2:"", 1:"", 0:""];
		}
		count = 0;
		item_count = 0;
		while(count < world_items.size)
		{
			itemlist = function_91b29d2a(world_items[count]);
			foreach(item in itemlist)
			{
				var_5819b8d4 = item_world::function_2e3efdda(item.origin, undefined, 1, 1, -1, 1);
				if(var_5819b8d4.size > 0)
				{
					type = "";
					if(isdefined(var_5819b8d4[0].var_a6762160) && isdefined(var_5819b8d4[0].var_a6762160.itemtype))
					{
						switch(var_5819b8d4[0].var_a6762160.itemtype)
						{
							case "ammo":
							{
								type = "";
								break;
							}
							case "weapon":
							{
								type = "";
								break;
							}
							case "health":
							{
								type = "";
								break;
							}
							case "armor":
							{
								type = "";
								break;
							}
							case "equipment":
							{
								type = "";
								break;
							}
							case "backpack":
							{
								type = "";
								break;
							}
							case "generic":
							{
								type = "";
								break;
							}
							case "cash":
							{
								type = "";
								break;
							}
							case "killstreak":
							{
								type = "";
								break;
							}
							case "attachment":
							{
								type = "";
								break;
							}
							case "resource":
							{
								type = "";
								break;
							}
							default:
							{
								type = "";
								break;
							}
						}
					}
					if(isdefined(var_5819b8d4[0].var_a6762160))
					{
						debug_string = ((((var_5819b8d4[0].var_a6762160.name + "") + function_9e72a96(var_5819b8d4[0].targetname) + "") + var_5819b8d4[0].origin) + "") + type;
						fprintln(file, debug_string);
						item_count++;
					}
				}
			}
			count++;
		}
		println(("" + item_count) + "");
		println("");
		closefile(file);
	#/
}

/*
	Name: function_938d798a
	Namespace: namespace_b56b91cb
	Checksum: 0x62366DCE
	Offset: 0xFA8
	Size: 0x754
	Parameters: 0
	Flags: Private
*/
function private function_938d798a()
{
	/#
		str_filename = util::function_53bbf9d2() + "";
		file = openfile(str_filename, "");
		if(file == -1)
		{
			iprintlnbold("" + str_filename);
			return;
		}
		freadln(file);
		freadln(file);
		freadln(file);
		freadln(file);
		var_7099d03 = [];
		while(freadln(file) > 0)
		{
			var_a9682cef = [];
			var_aae1fec0 = fgetarg(file, 0);
			a_str_keys = strtok2(var_aae1fec0, "");
			var_a9682cef[0] = float(a_str_keys[5]);
			var_aae1fec0 = fgetarg(file, 1);
			var_a9682cef[1] = float(var_aae1fec0);
			var_aae1fec0 = fgetarg(file, 2);
			var_a9682cef[2] = float(var_aae1fec0);
			var_4e94b449 = strtok2(var_aae1fec0, "");
			v_origin = (var_a9682cef[0], var_a9682cef[1], var_a9682cef[2]);
			v_stand = getclosestpointonnavmesh(v_origin, 192);
			switch(var_4e94b449[2])
			{
				case "overlaps":
				{
					var_e45e8f33 = (0, 0, 1);
					var_6f08946b = fgetarg(file, 3);
					var_dd52f0fe = fgetarg(file, 4);
					var_d8aec942 = (float(var_4e94b449[6]), float(var_6f08946b), float(var_dd52f0fe));
					break;
				}
				case "is":
				{
					var_e45e8f33 = (1, 0, 0);
					var_d8aec942 = undefined;
					break;
				}
			}
			var_7099d03[var_7099d03.size] = {#hash_d8aec942:var_d8aec942, #hash_e45e8f33:var_e45e8f33, #stand:v_stand, #origin:v_origin};
		}
		closefile(file);
		wait(0.5);
		iprintlnbold("");
		adddebugcommand("");
		player = util::gethostplayer();
		if(!isdefined(level.var_eedfa327))
		{
			level.var_eedfa327 = 0;
		}
		n_index = 0;
		var_d4714efb = 0;
		while(level.var_938d798a)
		{
			if(player jumpbuttonpressed() && player function_78931318(""))
			{
				if(level.var_eedfa327 < var_7099d03.size - 1)
				{
					level.var_eedfa327++;
				}
				else
				{
					level.var_eedfa327 = 0;
				}
			}
			else if(player jumpbuttonpressed() && player function_78931318(""))
			{
				if(level.var_eedfa327 <= 0)
				{
					level.var_eedfa327 = var_7099d03.size - 1;
				}
				else
				{
					level.var_eedfa327--;
				}
			}
			if(level.var_eedfa327 != var_d4714efb)
			{
				sphere(var_7099d03[level.var_eedfa327].origin, 8, var_7099d03[level.var_eedfa327].var_e45e8f33, 0.5, 0, 16, 300);
				if(isdefined(var_7099d03[level.var_eedfa327].var_d8aec942))
				{
					sphere(var_7099d03[level.var_eedfa327].var_d8aec942, 8, var_7099d03[level.var_eedfa327].var_e45e8f33, 0.5, 0, 16, 300);
				}
				if(isdefined(var_7099d03[level.var_eedfa327].stand))
				{
					v_player_pos = var_7099d03[level.var_eedfa327].stand;
				}
				else
				{
					v_player_pos = var_7099d03[level.var_eedfa327].origin;
				}
				var_543a44a5 = vectortoangles(var_7099d03[level.var_eedfa327].origin - (v_player_pos + vectorscale((0, 0, 1), 36)));
				player setorigin(v_player_pos);
				player setplayerangles(var_543a44a5);
				var_d4714efb = level.var_eedfa327;
				iprintlnbold("" + level.var_eedfa327);
				wait(0.1);
			}
			waitframe(1);
		}
		iprintlnbold("");
	#/
}

/*
	Name: function_f9efe895
	Namespace: namespace_b56b91cb
	Checksum: 0xEC58082D
	Offset: 0x1708
	Size: 0x2B4
	Parameters: 0
	Flags: Private
*/
function private function_f9efe895()
{
	/#
		var_7f0b4b6b = [];
		buoy_stash = [];
		var_7f0b4b6b = function_91b29d2a("");
		buoy_stash = function_91b29d2a("");
		var_7f0b4b6b = arraycombine(var_7f0b4b6b, buoy_stash, 1, 0);
		player = util::gethostplayer();
		n_index = 0;
		var_d4714efb = 0;
		wait(1);
		iprintlnbold("");
		while(level.var_f9efe895)
		{
			if(player adsbuttonpressed() && player function_78931318(""))
			{
				if(n_index < var_7f0b4b6b.size - 1)
				{
					n_index++;
				}
				else
				{
					n_index = 0;
				}
			}
			else if(player adsbuttonpressed() && player function_78931318(""))
			{
				if(n_index == 0)
				{
					n_index = var_7f0b4b6b.size - 1;
				}
				else
				{
					n_index--;
				}
			}
			if(n_index != var_d4714efb)
			{
				v_player_pos = var_7f0b4b6b[n_index].origin + (anglestoforward(var_7f0b4b6b[n_index].angles) * 96);
				var_543a44a5 = vectortoangles(var_7f0b4b6b[n_index].origin - (v_player_pos + vectorscale((0, 0, 1), 36)));
				player setorigin(v_player_pos);
				player setplayerangles(var_543a44a5);
				var_d4714efb = n_index;
				iprintlnbold("" + n_index);
				wait(0.1);
			}
			waitframe(1);
		}
		iprintlnbold("");
	#/
}

/*
	Name: function_f0d72128
	Namespace: namespace_b56b91cb
	Checksum: 0xD8773E30
	Offset: 0x19C8
	Size: 0x32C
	Parameters: 0
	Flags: Private
*/
function private function_f0d72128()
{
	/#
		var_df1e5fef = [];
		var_df1e5fef = function_91b29d2a("");
		player = util::gethostplayer();
		if(!isdefined(level.var_99026891))
		{
			level.var_99026891 = var_df1e5fef.size - 1;
		}
		var_d4714efb = 0;
		v_offset = vectorscale((0, 0, 1), 50);
		wait(1);
		iprintlnbold("");
		adddebugcommand("");
		while(level.var_f0d72128)
		{
			if(player jumpbuttonpressed() && player function_78931318(""))
			{
				if(level.var_99026891 < var_df1e5fef.size - 1)
				{
					level.var_99026891++;
				}
				else
				{
					level.var_99026891 = 0;
				}
			}
			else if(player jumpbuttonpressed() && player function_78931318(""))
			{
				if(level.var_99026891 == 0)
				{
					level.var_99026891 = var_df1e5fef.size - 1;
				}
				else
				{
					level.var_99026891--;
				}
			}
			if(level.var_99026891 != var_d4714efb)
			{
				debugstar(var_df1e5fef[level.var_99026891].origin, 190, (1, 1, 1));
				v_player_pos = var_df1e5fef[level.var_99026891].origin - (anglestoright(var_df1e5fef[level.var_99026891].angles) * 128);
				var_543a44a5 = vectortoangles(var_df1e5fef[level.var_99026891].origin - v_player_pos);
				v_player_pos = v_player_pos - v_offset;
				player setorigin(v_player_pos);
				player setplayerangles(var_543a44a5);
				var_d4714efb = level.var_99026891;
				iprintlnbold("" + level.var_99026891);
				wait(0.1);
			}
			waitframe(1);
		}
		iprintlnbold("");
	#/
}

/*
	Name: function_78931318
	Namespace: namespace_b56b91cb
	Checksum: 0xA3EB1C0A
	Offset: 0x1D00
	Size: 0x162
	Parameters: 1
	Flags: None
*/
function function_78931318(str_button)
{
	/#
		switch(str_button)
		{
			case "down":
			{
				var_a1798265 = "";
				var_7a00db94 = "";
				break;
			}
			case "left":
			{
				var_a1798265 = "";
				var_7a00db94 = "";
				break;
			}
			case "right":
			{
				var_a1798265 = "";
				var_7a00db94 = "";
				break;
			}
			case "up":
			{
				var_a1798265 = "";
				var_7a00db94 = "";
				break;
			}
		}
		if(isdefined(var_a1798265))
		{
			if(self buttonpressed(var_a1798265) || self buttonpressed(var_7a00db94))
			{
				while(self buttonpressed(var_a1798265) || self buttonpressed(var_7a00db94))
				{
					waitframe(1);
				}
				return true;
			}
		}
		return false;
	#/
}

/*
	Name: function_cdd9b388
	Namespace: namespace_b56b91cb
	Checksum: 0x5F7575A9
	Offset: 0x1E70
	Size: 0x34A4
	Parameters: 0
	Flags: Private
*/
function private function_cdd9b388()
{
	/#
		while(true)
		{
			if(getdvarint(#"hash_326974dd9b8c3414", 0))
			{
				wait(1);
			}
			else
			{
				waitframe(1);
			}
			if(!isdefined(level flagsys::get(#"hash_51daecff754729dc")))
			{
				continue;
			}
			if(getdvarint(#"hash_4341150bd02e99a1", 0) > 0)
			{
				xoffset = 20;
				yoffset = 160;
				var_27afd540 = 15;
				var_9e681fbf = 10;
				if(!isdefined(level.var_f0d0335b))
				{
					level.var_f0d0335b = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + (var_27afd540 + var_9e681fbf);
				}
				if(!isdefined(level.var_7f7d26cc))
				{
					level.var_7f7d26cc = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + var_27afd540;
				}
				if(!isdefined(level.var_6deb23ed))
				{
					level.var_6deb23ed = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + (var_27afd540 + var_9e681fbf);
				}
				if(!isdefined(level.var_5c6c77b3))
				{
					level.var_5c6c77b3 = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + var_27afd540;
				}
				if(!isdefined(level.var_5471e557))
				{
					level.var_5471e557 = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + var_27afd540;
				}
				if(!isdefined(level.var_544a823a))
				{
					level.var_544a823a = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + var_27afd540;
				}
				if(!isdefined(level.var_eaa15f28))
				{
					level.var_eaa15f28 = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + var_27afd540;
				}
				if(!isdefined(level.var_6fc93583))
				{
					level.var_6fc93583 = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + var_27afd540;
				}
				if(!isdefined(level.var_f2a04fda))
				{
					level.var_f2a04fda = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + var_27afd540;
				}
				if(!isdefined(level.var_721a3621))
				{
					level.var_721a3621 = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + var_27afd540;
				}
				if(!isdefined(level.var_67220c03))
				{
					level.var_67220c03 = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + (var_27afd540 + var_9e681fbf);
				}
				if(!isdefined(level.var_58faba13))
				{
					level.var_58faba13 = function_13d7bba(xoffset, yoffset);
					yoffset = yoffset + var_27afd540;
				}
				tab = "";
				loc_000025B8:
				loc_00002600:
				level.var_f0d0335b settext((("" + (isdefined(level.var_d80c35aa[#"blank"]) ? level.var_d80c35aa[#"blank"] : 0)) + "") + (int((isdefined(level.var_d80c35aa[#"blank"]) ? level.var_d80c35aa[#"blank"] : 0) / (int(max(level.var_136445c0, 1) + (isdefined(level.var_d80c35aa[#"blank"]) ? level.var_d80c35aa[#"blank"] : 0))) * 100)) + "");
				level.var_7f7d26cc settext("" + (level.var_136445c0 + (isdefined(level.var_d80c35aa[#"blank"]) ? level.var_d80c35aa[#"blank"] : 0)));
				level.var_6deb23ed settext((((((((((((("" + level.var_66e56764) + tab) + tab) + "") + level.var_136445c0) + tab) + tab) + "") + level.var_5720c09a) + tab) + tab) + "") + level.var_2850ef5);
				level.var_5c6c77b3 settext(function_11421106("", ""));
				level.var_5471e557 settext(function_11421106("", ""));
				level.var_544a823a settext(function_11421106("", ""));
				level.var_eaa15f28 settext(function_11421106("", ""));
				level.var_6fc93583 settext(function_11421106("", ""));
				level.var_f2a04fda settext(function_11421106("", ""));
				level.var_721a3621 settext(function_11421106("", ""));
				level.var_67220c03 settext(function_11421106("", ""));
				level.var_58faba13 settext("" + (isdefined(level.var_f2db6a7f) ? level.var_f2db6a7f : 0));
			}
			else
			{
				if(isdefined(level.var_f0d0335b))
				{
					level.var_f0d0335b destroy();
				}
				if(isdefined(level.var_7f7d26cc))
				{
					level.var_7f7d26cc destroy();
				}
				if(isdefined(level.var_6deb23ed))
				{
					level.var_6deb23ed destroy();
				}
				if(isdefined(level.var_5c6c77b3))
				{
					level.var_5c6c77b3 destroy();
				}
				if(isdefined(level.var_5471e557))
				{
					level.var_5471e557 destroy();
				}
				if(isdefined(level.var_544a823a))
				{
					level.var_544a823a destroy();
				}
				if(isdefined(level.var_eaa15f28))
				{
					level.var_eaa15f28 destroy();
				}
				if(isdefined(level.var_6fc93583))
				{
					level.var_6fc93583 destroy();
				}
				if(isdefined(level.var_f2a04fda))
				{
					level.var_f2a04fda destroy();
				}
				if(isdefined(level.var_721a3621))
				{
					level.var_721a3621 destroy();
				}
				if(isdefined(level.var_67220c03))
				{
					level.var_67220c03 destroy();
				}
				if(isdefined(level.var_58faba13))
				{
					level.var_58faba13 destroy();
				}
			}
			if(getdvarint(#"hash_66ec171c69a26bfe", 0) > 0)
			{
				level clientfield::set("", 0);
			}
			if(getdvarint(#"hash_cc335a24301e7a1", 0) > 0)
			{
				if(!level.var_1d8e6dd8)
				{
					level.var_1d8e6dd8 = 1;
					level thread function_b6ea080();
				}
			}
			if(getdvarint(#"hash_7701b1eb7e173692", 0))
			{
				if(!level.var_938d798a)
				{
					wait(0.5);
					level.var_938d798a = 1;
					level thread function_938d798a();
				}
			}
			if(getdvarint(#"hash_7701b1eb7e173692", 0) == 0)
			{
				level.var_938d798a = 0;
			}
			if(getdvarint(#"hash_cb3296a761d4f6c", 0))
			{
				if(!level.var_f9efe895)
				{
					wait(0.5);
					level.var_f9efe895 = 1;
					level thread function_f9efe895();
				}
			}
			if(getdvarint(#"hash_cb3296a761d4f6c", 0) == 0)
			{
				level.var_f9efe895 = 0;
			}
			if(getdvarint(#"hash_4f4c47d52d6ad262", 0))
			{
				if(!level.var_f0d72128)
				{
					wait(0.5);
					level.var_f0d72128 = 1;
					level thread function_f0d72128();
				}
			}
			if(getdvarint(#"hash_4f4c47d52d6ad262", 0) == 0)
			{
				level.var_f0d72128 = 0;
			}
			if(getdvarint(#"hash_170b29b9b506feed", 0))
			{
				setdvar(#"hash_170b29b9b506feed", 0);
				level thread function_bebe535();
			}
			if(getdvarint(#"hash_38ea7228f76d733f", 0))
			{
				setdvar(#"hash_38ea7228f76d733f", 0);
				level thread function_2248268e();
			}
			if(getdvarint(#"hash_cc335a24301e7a1", 0) == 0)
			{
				level.var_1d8e6dd8 = 0;
			}
			if(getdvarint(#"hash_3fdd3b60f349d462", 0) > 0)
			{
				players = getplayers();
				if(players.size <= 0)
				{
					continue;
				}
				origin = players[0].origin;
				var_f4b807cb = item_world::function_2e3efdda(origin, undefined, 128, 2000);
				foreach(item in var_f4b807cb)
				{
					print3d(item.origin + vectorscale((0, 0, 1), 10), (("" + item.var_bd027dd9) + "") + item.var_a6762160.name, (1, 0.5, 0), 1, 0.4);
				}
			}
			if(getdvarint(#"hash_326974dd9b8c3414", 0))
			{
				itemtype = getdvarint(#"hash_326974dd9b8c3414", 1);
				players = getplayers();
				if(players.size <= 0)
				{
					continue;
				}
				origin = players[0].origin;
				if(itemtype == 13)
				{
					var_cc58c092 = function_91b29d2a(#"hash_776cf27e25f57c7a");
					var_f5196a40 = function_91b29d2a(#"hash_44623cfed77fbb23");
					var_dfebf4da = function_91b29d2a(#"hash_7e0f31597a8a30af");
					heli_spawn = function_91b29d2a(#"heli_spawn");
					var_56c17d74 = function_91b29d2a(#"hash_7f58537ca200b519");
					var_77bdab14 = function_91b29d2a(#"hash_3392a8a72acc91d");
					var_e8750c36 = function_91b29d2a(#"hash_187ecf3003e27fce");
					var_1901b1fa = function_91b29d2a(#"hash_2d6fce71eb390d50");
					var_453c640c = function_91b29d2a(#"hash_781a27d230f31faf");
					var_b351e4a0 = function_91b29d2a(#"hash_19db6f9cacbc79c3");
					var_e4dc1e88 = function_91b29d2a(#"hash_60758a532bcf65bf");
					var_b3103dc6 = function_91b29d2a(#"hash_48a5672439afc27f");
					var_5cf9a6ca = function_91b29d2a(#"hash_5efb8d41fc3faa1d");
					var_60f65e2 = function_91b29d2a(#"hash_1b0d6e065e6eb939");
					var_ad7c20c4 = function_91b29d2a(#"hash_21fc3a6dd0e569af");
					foreach(vehicle in var_cc58c092)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 0, 0), 1, 0, 10, 20);
					}
					foreach(vehicle in var_f5196a40)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 1, 0), 1, 0, 10, 20);
					}
					foreach(vehicle in var_dfebf4da)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 1, 0), 1, 0, 10, 20);
					}
					foreach(vehicle in heli_spawn)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 0, 1), 1, 0, 10, 20);
					}
					foreach(vehicle in var_56c17d74)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 0, 1), 1, 0, 10, 20);
					}
					foreach(vehicle in var_77bdab14)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
					}
					foreach(vehicle in var_e8750c36)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
					}
					foreach(vehicle in var_1901b1fa)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
					}
					foreach(vehicle in var_453c640c)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
					}
					foreach(vehicle in var_b351e4a0)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
					}
					foreach(vehicle in var_e4dc1e88)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
					}
					foreach(vehicle in var_b3103dc6)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (0, 1, 1), 1, 0, 10, 20);
					}
					foreach(vehicle in var_60f65e2)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (0, 1, 1), 1, 0, 10, 20);
					}
					foreach(vehicle in var_5cf9a6ca)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, vectorscale((1, 1, 0), 0.5019608), 1, 0, 10, 20);
					}
					foreach(vehicle in var_ad7c20c4)
					{
						radius = 128;
						var_84dd2a8b = 4096;
						if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
						{
							radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
						}
						sphere(vehicle.origin, radius, (0, 1, 0), 1, 0, 10, 20);
					}
				}
				else
				{
					if(itemtype == 14)
					{
						vehicles = getvehiclearray();
						foreach(vehicle in vehicles)
						{
							color = vectorscale((1, 1, 1), 0.75);
							radius = 128;
							var_84dd2a8b = 4096;
							if(distancesquared(origin, vehicle.origin) < var_84dd2a8b * var_84dd2a8b)
							{
								radius = max((distance(origin, vehicle.origin) / var_84dd2a8b) * radius, 1);
							}
							if(isdefined(vehicle.scriptvehicletype))
							{
								color = (1, 1, 1);
								switch(vehicle.scriptvehicletype)
								{
									case "player_atv":
									{
										color = (0, 1, 1);
										break;
									}
									case "cargo_truck_wz":
									{
										color = (1, 1, 0);
										break;
									}
									case "tactical_raft_wz":
									{
										color = (1, 0.5, 0);
										break;
									}
									case "helicopter_light":
									{
										color = (1, 0, 1);
										break;
									}
								}
								sphere(vehicle.origin, radius, color, 1, 0, 10, 20);
							}
						}
					}
					else
					{
						if(itemtype == 12)
						{
							var_83f919af = function_91b29d2a(#"hash_77c7d3dc43202775");
							foreach(point in var_83f919af)
							{
								player = level.players[0];
								if(vectordot(player.origin, point.origin) > 0)
								{
									color = (0, 0, 1);
									radius = 128;
									var_84dd2a8b = 4096;
									if(distancesquared(origin, point.origin) < var_84dd2a8b * var_84dd2a8b)
									{
										radius = max((distance(origin, point.origin) / var_84dd2a8b) * radius, 1);
									}
									var_58e1eac5 = item_world::function_2e3efdda(point.origin, undefined, 100, 1);
									if(var_58e1eac5.size > 0)
									{
										switch(var_58e1eac5[0].targetname)
										{
											case "world_dynent_stash_health":
											{
												color = (1, 0, 0);
												break;
											}
											case "world_dynent_stash_supply":
											{
												color = (0, 1, 0);
												break;
											}
											case "hash_ea6664e89a0bff6":
											{
												color = vectorscale((1, 1, 0), 0.5019608);
												break;
											}
										}
										sphere(point.origin, radius, color, 1, 0, 10, 20);
										continue;
									}
									color = vectorscale((1, 1, 1), 0.75);
									sphere(point.origin, radius, color, 1, 0, 10, 20);
								}
							}
						}
						else
						{
							if(itemtype == 18)
							{
								var_c3ff57f0 = getdynentarray("");
								zombie_apoc_homunculus = getdynent("");
								if(isdefined(zombie_apoc_homunculus))
								{
									if(!isdefined(var_c3ff57f0))
									{
										var_c3ff57f0 = [];
									}
									else if(!isarray(var_c3ff57f0))
									{
										var_c3ff57f0 = array(var_c3ff57f0);
									}
									var_c3ff57f0[var_c3ff57f0.size] = zombie_apoc_homunculus;
								}
								foreach(var_1176d784 in var_c3ff57f0)
								{
									if(function_8a8a409b(var_1176d784))
									{
										sphere(var_1176d784.origin, 256, (0, 1, 0), 1, 0, 10, 20);
									}
								}
							}
							else
							{
								var_f4b807cb = item_world::function_2e3efdda(origin, undefined, 4000, 30000, -1, 0);
								foreach(item in var_f4b807cb)
								{
									if(isdefined(item.var_a6762160) && isdefined(item.var_a6762160.rarity))
									{
										switch(item.var_a6762160.rarity)
										{
											case "common":
											{
												color = (0, 1, 0);
												break;
											}
											case "rare":
											{
												color = (0, 0, 1);
												break;
											}
											case "legendary":
											{
												color = (1, 0, 1);
												break;
											}
											case "epic":
											{
												color = (1, 0.5, 0);
												break;
											}
											default:
											{
												color = (1, 0, 0);
												break;
											}
										}
									}
									else
									{
										color = (1, 0, 0);
									}
									radius = 64;
									var_84dd2a8b = 2048;
									if(distancesquared(origin, item.origin) < var_84dd2a8b * var_84dd2a8b)
									{
										radius = max((distance(origin, item.origin) / var_84dd2a8b) * radius, 1);
									}
									switch(itemtype)
									{
										case 1:
										{
											color = (1, 0, 1);
											sphere(item.origin, radius, color, 1, 0, 10, 20);
											if(isdefined(item.targetname))
											{
												print3d(item.origin + vectorscale((0, 0, 1), 32), function_9e72a96(item.targetname), color, 1, 0.3, 20);
											}
											break;
										}
										case 2:
										{
											if(isdefined(item.var_a6762160))
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
										}
										case 3:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"ammo")
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
											break;
										}
										case 4:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"weapon")
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
											break;
										}
										case 5:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"health")
											{
												if(item.var_a6762160.name == "")
												{
													sphere(item.origin, radius, (0, 1, 0), 1, 0, 10, 20);
												}
												else
												{
													if(item.var_a6762160.name == "")
													{
														sphere(item.origin, radius, (0, 0, 1), 1, 0, 10, 20);
													}
													else
													{
														if(item.var_a6762160.name == "")
														{
															sphere(item.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
														}
														else
														{
															sphere(item.origin, radius, color, 1, 0, 10, 20);
														}
													}
												}
											}
											break;
										}
										case 6:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"armor")
											{
												if(item.var_a6762160.name == "")
												{
													sphere(item.origin, radius, (0, 1, 0), 1, 0, 10, 20);
												}
												else
												{
													if(item.var_a6762160.name == "")
													{
														sphere(item.origin, radius, (0, 0, 1), 1, 0, 10, 20);
													}
													else
													{
														if(item.var_a6762160.name == "")
														{
															sphere(item.origin, radius, (1, 1, 0), 1, 0, 10, 20);
														}
														else
														{
															sphere(item.origin, radius, color, 1, 0, 10, 20);
														}
													}
												}
											}
											break;
										}
										case 7:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"equipment")
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
											break;
										}
										case 8:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"backpack")
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
											break;
										}
										case 9:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"attachment")
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
											break;
										}
										case 10:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"generic")
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
											break;
										}
										case 11:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"killstreak")
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
											break;
										}
										case 15:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"quest")
											{
												sphere(item.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
											}
											break;
										}
										case 16:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"cash")
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
											break;
										}
										case 17:
										{
											if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"resource")
											{
												sphere(item.origin, radius, color, 1, 0, 10, 20);
											}
											break;
										}
									}
								}
							}
						}
					}
				}
			}
			if(getdvarint(#"hash_5d7b010a8d4f8666", 0))
			{
				if(isdefined(level.var_8819644a))
				{
					foreach(info in level.var_8819644a)
					{
						vehicle = info.vehicle;
						spawnpoint = info.origin;
						players = getplayers();
						if(players.size <= 0)
						{
							continue;
						}
						origin = players[0].origin;
						if(isdefined(vehicle))
						{
							radius = 64;
							var_84dd2a8b = 2048;
							if(distancesquared(origin, spawnpoint) < var_84dd2a8b * var_84dd2a8b)
							{
								radius = max((distance(origin, spawnpoint) / var_84dd2a8b) * radius, 10);
							}
							sphere(spawnpoint, radius, (1, 1, 0), 1, 0, 10, 20);
							line(spawnpoint, vehicle.origin, (0, 1, 0));
							sphere(vehicle.origin, radius, (1, 0, 0), 1, 0, 10, 20);
						}
					}
				}
			}
		}
	#/
}

/*
	Name: function_44b9dd1d
	Namespace: namespace_b56b91cb
	Checksum: 0xE576C1D
	Offset: 0x5320
	Size: 0x254
	Parameters: 0
	Flags: Private
*/
function private function_44b9dd1d()
{
	/#
		while(!canadddebugcommand())
		{
			waitframe(1);
		}
		mapname = util::function_53bbf9d2();
		adddebugcommand("");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand("");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
	#/
}

/*
	Name: function_91ef342
	Namespace: namespace_b56b91cb
	Checksum: 0x39CC041C
	Offset: 0x5580
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function function_91ef342()
{
	/#
		level endon(#"game_ended");
		while(true)
		{
			r = undefined;
			r = level waittill(#"devgui_bot");
			switch(r.args[0])
			{
				case "hash_29f59f6b62fdbf94":
				{
					function_c07eae4e();
					break;
				}
			}
		}
	#/
}

/*
	Name: function_c07eae4e
	Namespace: namespace_b56b91cb
	Checksum: 0xF86CFCAA
	Offset: 0x5618
	Size: 0x244
	Parameters: 0
	Flags: None
*/
function function_c07eae4e()
{
	/#
		var_6e5bbee1 = [];
		itemcount = function_8322cf16();
		for(i = 0; i < itemcount; i++)
		{
			item = function_b1702735(i);
			if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype == "" && item.var_a6762160.weapon.isprimary)
			{
				array::add(var_6e5bbee1, namespace_ad5a0cd6::function_35e06774(item.var_a6762160), 0);
			}
		}
		var_6e5bbee1 = array::randomize(var_6e5bbee1);
		if(var_6e5bbee1.size == 0)
		{
			return;
		}
		players = getplayers();
		var_9db8ea1b = 0;
		foreach(player in players)
		{
			if(isbot(player))
			{
				weapon = var_6e5bbee1[var_9db8ea1b];
				player giveweapon(weapon);
				player givemaxammo(weapon);
				player switchtoweaponimmediate(weapon);
				var_9db8ea1b++;
				if(var_9db8ea1b >= var_6e5bbee1.size)
				{
					var_9db8ea1b = 0;
				}
			}
		}
	#/
}

