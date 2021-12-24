// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace dev;

/*
	Name: debug_sphere
	Namespace: dev
	Checksum: 0xCCBB20E9
	Offset: 0x78
	Size: 0xBC
	Parameters: 5
	Flags: None
*/
function debug_sphere(origin, radius, color, alpha, time)
{
	/#
		if(!isdefined(time))
		{
			time = 1000;
		}
		if(!isdefined(color))
		{
			color = (1, 1, 1);
		}
		sides = int(10 * (1 + (int(radius) % 100)));
		sphere(origin, radius, color, alpha, 1, sides, time);
	#/
}

/*
	Name: devgui_test_chart_think
	Namespace: dev
	Checksum: 0xA1F88F5B
	Offset: 0x140
	Size: 0x3E6
	Parameters: 0
	Flags: None
*/
function devgui_test_chart_think()
{
	/#
		waitframe(1);
		old_val = getdvarint(#"scr_debug_test_chart", 0);
		scale = 120;
		for(;;)
		{
			val = getdvarint(#"scr_debug_test_chart", 0);
			if(old_val != val)
			{
				if(isdefined(level.test_chart_model))
				{
					level.test_chart_model delete();
					level.test_chart_model = undefined;
				}
				if(val)
				{
					player = getplayers()[0];
					direction = player getplayerangles();
					direction_vec = anglestoforward((0, direction[1], 0));
					direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
					level.test_chart_model = spawn("", player geteye() + direction_vec);
					level.test_chart_model setmodel(#"test_chart_model");
					level.test_chart_model.angles = (0, direction[1], 0) + vectorscale((0, 1, 0), 90);
				}
			}
			if(val)
			{
				player = getplayers()[0];
				if(val == 1)
				{
					level.test_chart_model setmodel(#"test_chart_model");
				}
				else if(val == 2)
				{
					level.test_chart_model setmodel(#"hash_70a102226734fb49");
				}
				else if(val == 3)
				{
					level.test_chart_model setmodel(#"hash_70a101226734f996");
				}
				direction = player getplayerangles();
				direction_vec = anglestoforward((0, direction[1], 0));
				direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
				level.test_chart_model.angles = (0, direction[1], 0) + vectorscale((0, 1, 0), 90);
				level.test_chart_model.origin = player geteye() + direction_vec;
				if(player meleebuttonpressed())
				{
					scale = scale + 10;
				}
				if(player sprintbuttonpressed())
				{
					scale = scale - 10;
				}
			}
			old_val = val;
			waitframe(1);
		}
	#/
}

/*
	Name: updateminimapsetting
	Namespace: dev
	Checksum: 0xE8EFBEB2
	Offset: 0x530
	Size: 0xAD4
	Parameters: 0
	Flags: None
*/
function updateminimapsetting()
{
	/#
		requiredmapaspectratio = getdvarfloat(#"scr_requiredmapaspectratio", 0);
		if(!isdefined(level.minimapheight))
		{
			setdvar(#"scr_minimap_height", 0);
			level.minimapheight = 0;
		}
		minimapheight = getdvarfloat(#"scr_minimap_height", 0);
		if(minimapheight != level.minimapheight)
		{
			if(minimapheight <= 0)
			{
				util::gethostplayer() cameraactivate(0);
				level.minimapheight = minimapheight;
				level notify(#"end_draw_map_bounds");
			}
			if(minimapheight > 0)
			{
				level.minimapheight = minimapheight;
				players = getplayers();
				if(players.size > 0)
				{
					player = util::gethostplayer();
					corners = getentarray("", "");
					if(corners.size == 2)
					{
						viewpos = corners[0].origin + corners[1].origin;
						viewpos = (viewpos[0] * 0.5, viewpos[1] * 0.5, viewpos[2] * 0.5);
						level thread minimapwarn(corners);
						maxcorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
						mincorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
						if(corners[1].origin[0] > corners[0].origin[0])
						{
							maxcorner = (corners[1].origin[0], maxcorner[1], maxcorner[2]);
						}
						else
						{
							mincorner = (corners[1].origin[0], mincorner[1], mincorner[2]);
						}
						if(corners[1].origin[1] > corners[0].origin[1])
						{
							maxcorner = (maxcorner[0], corners[1].origin[1], maxcorner[2]);
						}
						else
						{
							mincorner = (mincorner[0], corners[1].origin[1], mincorner[2]);
						}
						viewpostocorner = maxcorner - viewpos;
						viewpos = (viewpos[0], viewpos[1], viewpos[2] + minimapheight);
						northvector = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
						eastvector = (northvector[1], 0 - northvector[0], 0);
						disttotop = vectordot(northvector, viewpostocorner);
						if(disttotop < 0)
						{
							disttotop = 0 - disttotop;
						}
						disttoside = vectordot(eastvector, viewpostocorner);
						if(disttoside < 0)
						{
							disttoside = 0 - disttoside;
						}
						if(requiredmapaspectratio > 0)
						{
							mapaspectratio = disttoside / disttotop;
							if(mapaspectratio < requiredmapaspectratio)
							{
								incr = requiredmapaspectratio / mapaspectratio;
								disttoside = disttoside * incr;
								addvec = vecscale(eastvector, (vectordot(eastvector, maxcorner - viewpos)) * (incr - 1));
								mincorner = mincorner - addvec;
								maxcorner = maxcorner + addvec;
							}
							else
							{
								incr = mapaspectratio / requiredmapaspectratio;
								disttotop = disttotop * incr;
								addvec = vecscale(northvector, (vectordot(northvector, maxcorner - viewpos)) * (incr - 1));
								mincorner = mincorner - addvec;
								maxcorner = maxcorner + addvec;
							}
						}
						if(level.console)
						{
							aspectratioguess = 1.777778;
							angleside = 2 * (atan((disttoside * 0.8) / minimapheight));
							angletop = 2 * (atan(((disttotop * aspectratioguess) * 0.8) / minimapheight));
						}
						else
						{
							aspectratioguess = 1.333333;
							angleside = 2 * (atan(disttoside / minimapheight));
							angletop = 2 * (atan((disttotop * aspectratioguess) / minimapheight));
						}
						if(angleside > angletop)
						{
							angle = angleside;
						}
						else
						{
							angle = angletop;
						}
						znear = minimapheight - 1000;
						if(znear < 16)
						{
							znear = 16;
						}
						if(znear > 10000)
						{
							znear = 10000;
						}
						player camerasetposition(viewpos, (90, getnorthyaw(), 0));
						player cameraactivate(1);
						player takeallweapons();
						setdvar(#"cg_drawgun", 0);
						setdvar(#"cg_draw2d", 0);
						setdvar(#"cg_drawfps", 0);
						setdvar(#"fx_enable", 0);
						setdvar(#"r_fog", 0);
						setdvar(#"r_highloddist", 0);
						setdvar(#"r_znear", znear);
						setdvar(#"r_lodscalerigid", 0.1);
						setdvar(#"cg_drawversion", 0);
						setdvar(#"sm_enable", 1);
						setdvar(#"player_view_pitch_down", 90);
						setdvar(#"player_view_pitch_up", 0);
						setdvar(#"cg_fov", angle);
						setdvar(#"cg_drawminimap", 1);
						setdvar(#"r_umbranumthreads", 1);
						setdvar(#"r_umbradistancescale", 0.1);
						setdvar(#"r_uselensfov", 0);
						setdvar(#"hash_5ee9a4ac16993e50", 1);
						setdvar(#"debug_show_viewpos", 0);
						thread drawminimapbounds(viewpos, mincorner, maxcorner);
					}
					else
					{
						println("");
					}
				}
				else
				{
					setdvar(#"scr_minimap_height", 0);
				}
			}
		}
	#/
}

/*
	Name: vecscale
	Namespace: dev
	Checksum: 0x270FADC7
	Offset: 0x1010
	Size: 0x48
	Parameters: 2
	Flags: None
*/
function vecscale(vec, scalar)
{
	/#
		return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
	#/
}

/*
	Name: drawminimapbounds
	Namespace: dev
	Checksum: 0x8CBC3E27
	Offset: 0x1068
	Size: 0x396
	Parameters: 3
	Flags: None
*/
function drawminimapbounds(viewpos, mincorner, maxcorner)
{
	/#
		level notify(#"end_draw_map_bounds");
		level endon(#"end_draw_map_bounds");
		viewheight = viewpos[2] - maxcorner[2];
		north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
		diaglen = length(mincorner - maxcorner);
		mincorneroffset = mincorner - viewpos;
		mincorneroffset = vectornormalize((mincorneroffset[0], mincorneroffset[1], 0));
		mincorner = mincorner + (vecscale(mincorneroffset, (diaglen * 1) / 800));
		maxcorneroffset = maxcorner - viewpos;
		maxcorneroffset = vectornormalize((maxcorneroffset[0], maxcorneroffset[1], 0));
		maxcorner = maxcorner + (vecscale(maxcorneroffset, (diaglen * 1) / 800));
		diagonal = maxcorner - mincorner;
		side = vecscale(north, vectordot(diagonal, north));
		sidenorth = vecscale(north, abs(vectordot(diagonal, north)));
		corner0 = mincorner;
		corner1 = mincorner + side;
		corner2 = maxcorner;
		corner3 = maxcorner - side;
		toppos = (vecscale(mincorner + maxcorner, 0.5)) + vecscale(sidenorth, 0.51);
		textscale = diaglen * 0.003;
		while(true)
		{
			line(corner0, corner1);
			line(corner1, corner2);
			line(corner2, corner3);
			line(corner3, corner0);
			print3d(toppos, "", (1, 1, 1), 1, textscale);
			waitframe(1);
		}
	#/
}

/*
	Name: minimapwarn
	Namespace: dev
	Checksum: 0xB0FF35B0
	Offset: 0x1408
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function minimapwarn(corners)
{
	/#
	#/
}

/*
	Name: function_e5746ec1
	Namespace: dev
	Checksum: 0xDAE5961E
	Offset: 0x1420
	Size: 0x11C
	Parameters: 0
	Flags: None
*/
function function_e5746ec1()
{
	/#
		host = util::gethostplayer();
		all_players = getplayers();
		var_1645eaac = host getstance() == "";
		if(!isdefined(host) || var_1645eaac)
		{
			return all_players;
		}
		all_players = arraysort(all_players, host.origin);
		players = [];
		if(all_players.size == 1 || host getstance() == "")
		{
			players[0] = host;
		}
		else
		{
			players[0] = all_players[1];
		}
		return players;
	#/
}

/*
	Name: function_5639909a
	Namespace: dev
	Checksum: 0xF7482FB4
	Offset: 0x1548
	Size: 0xC8
	Parameters: 2
	Flags: None
*/
function function_5639909a(bodytype, outfitindex)
{
	/#
		players = function_e5746ec1();
		foreach(player in players)
		{
			player setcharacterbodytype(bodytype);
			player function_8fd843dd(outfitindex);
		}
	#/
}

/*
	Name: function_f413b4d5
	Namespace: dev
	Checksum: 0x7356CD84
	Offset: 0x1618
	Size: 0x178
	Parameters: 4
	Flags: None
*/
function function_f413b4d5(bodytype, outfitindex, var_c1154821, index)
{
	/#
		players = function_e5746ec1();
		if(var_c1154821 == "")
		{
			foreach(player in players)
			{
				player function_fbc5a093(index);
			}
		}
		else
		{
			foreach(player in players)
			{
				if(var_c1154821 == "")
				{
					player function_9b48a8e5(outfitindex);
				}
				player function_ab96a9b5(var_c1154821, index);
			}
		}
	#/
}

/*
	Name: body_customization_process_command
	Namespace: dev
	Checksum: 0x1B63A7B2
	Offset: 0x1798
	Size: 0x3CA
	Parameters: 1
	Flags: None
*/
function body_customization_process_command(character_index)
{
	/#
		/#
			println(("" + character_index) + "");
		#/
		split = strtok(character_index, "");
		switch(split.size)
		{
			case 1:
			{
				command0 = strtok(split[0], "");
				bodytype = int(command0[1]);
				/#
					println(("" + bodytype) + "");
				#/
				function_5639909a(bodytype, 0);
				break;
			}
			case 2:
			{
				command0 = strtok(split[0], "");
				bodytype = int(command0[1]);
				command1 = strtok(split[1], "");
				outfitindex = int(command1[1]);
				/#
					println(((("" + bodytype) + "") + outfitindex) + "");
				#/
				function_5639909a(bodytype, outfitindex);
				break;
			}
			case 3:
			{
				command0 = strtok(split[0], "");
				bodytype = int(command0[1]);
				command1 = strtok(split[1], "");
				outfitindex = int(command1[1]);
				var_e7f74d2b = strtok(split[2], "");
				var_c1154821 = var_e7f74d2b[0];
				index = int(var_e7f74d2b[1]);
				/#
					println(((((((("" + bodytype) + "") + outfitindex) + "") + var_c1154821) + "") + index) + "");
				#/
				function_f413b4d5(bodytype, outfitindex, var_c1154821, index);
				break;
			}
			default:
			{
				break;
			}
		}
	#/
}

/*
	Name: function_3cec5609
	Namespace: dev
	Checksum: 0x5A43AEFC
	Offset: 0x1B70
	Size: 0x120
	Parameters: 5
	Flags: None
*/
function function_3cec5609(arr, var_7956c7ac, bodytype, outfitindex, optiontype)
{
	/#
		foreach(index, option in arr)
		{
			if(option.isvalid)
			{
				util::function_345e5b9a((((((((((((((var_7956c7ac + index) + "") + "") + "") + "") + bodytype) + "") + "") + outfitindex) + "") + optiontype) + "") + index) + "");
			}
		}
	#/
}

/*
	Name: function_2c6232e5
	Namespace: dev
	Checksum: 0x59966E49
	Offset: 0x1C98
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_2c6232e5(var_4148b6dc)
{
	/#
		var_8d9c8a5d = function_ea13f55(var_4148b6dc, "", "");
		return var_8d9c8a5d;
	#/
}

/*
	Name: function_970d4891
	Namespace: dev
	Checksum: 0x5B6530E7
	Offset: 0x1CE8
	Size: 0x150
	Parameters: 1
	Flags: None
*/
function function_970d4891(mode)
{
	/#
		bodies = getallcharacterbodies(mode);
		foreach(playerbodytype in bodies)
		{
			body_name = (function_2c6232e5(makelocalizedstring(getcharacterdisplayname(playerbodytype, mode))) + "") + function_9e72a96(getcharacterassetname(playerbodytype, mode));
			util::function_e2e9d901(("" + body_name) + "", (("" + "") + "") + body_name);
		}
	#/
}

/*
	Name: body_customization_populate
	Namespace: dev
	Checksum: 0xDD3C4ED4
	Offset: 0x1E40
	Size: 0x7FA
	Parameters: 2
	Flags: None
*/
function body_customization_populate(mode, var_ef4940a5)
{
	/#
		bodies = getallcharacterbodies(mode);
		body_customization_devgui_base = "" + "";
		foreach(playerbodytype in bodies)
		{
			body_name = (function_2c6232e5(makelocalizedstring(getcharacterdisplayname(playerbodytype, mode))) + "") + function_9e72a96(getcharacterassetname(playerbodytype, mode));
			if(isdefined(var_ef4940a5) && var_ef4940a5 != body_name)
			{
				continue;
			}
			util::function_345e5b9a((((((((body_customization_devgui_base + body_name) + "") + "") + "") + "") + "") + playerbodytype) + "");
			var_13240050 = function_d299ef16(playerbodytype, mode);
			for(outfitindex = 0; outfitindex < var_13240050; outfitindex++)
			{
				var_9cf37283 = function_d7c3cf6c(playerbodytype, outfitindex, mode);
				if(var_9cf37283.valid)
				{
					var_346660ac = function_2c6232e5(makelocalizedstring(function_9e72a96(var_9cf37283.var_74996050)));
					var_1bf829f2 = ((((outfitindex + "") + var_346660ac) + "") + function_9e72a96(var_9cf37283.var_3cf2d21) + "") + outfitindex;
					var_a818c4e = ((body_customization_devgui_base + body_name) + "") + var_1bf829f2;
					util::function_345e5b9a((((((((((var_a818c4e + "") + "") + "") + "") + "") + playerbodytype) + "") + "") + outfitindex) + "");
					types = [7:{#field:"", #path:""}, 6:{#field:"", #path:""}, 5:{#field:"", #path:""}, 4:{#field:"", #path:""}, 3:{#field:"", #path:""}, 2:{#field:"", #path:""}, 1:{#field:"", #path:""}, 0:{#field:"", #path:""}];
					foreach(type, data in types)
					{
						foreach(index, option in var_9cf37283.options[type])
						{
							if(option.isvalid)
							{
								util::waittill_can_add_debug_command();
								util::function_345e5b9a(((((((((((((((((((var_a818c4e + "") + data.path) + "") + index) + "") + index) + "") + "") + "") + "") + playerbodytype) + "") + "") + outfitindex) + "") + data.field) + "") + index) + "");
							}
						}
					}
					for(var_56fe70a0 = 0; var_56fe70a0 < var_9cf37283.presets.size; var_56fe70a0++)
					{
						preset = var_9cf37283.presets[var_56fe70a0];
						if(!preset.isvalid)
						{
							continue;
						}
						util::waittill_can_add_debug_command();
						util::function_345e5b9a((((((((((((((((((var_a818c4e + "") + "") + var_56fe70a0) + "") + var_56fe70a0) + "") + "") + "") + "") + playerbodytype) + "") + "") + outfitindex) + "") + "") + "") + var_56fe70a0) + "");
					}
				}
				if(isdefined(var_ef4940a5))
				{
					util::function_d84da933(("" + body_name) + "");
				}
			}
		}
	#/
}

/*
	Name: body_customization_devgui
	Namespace: dev
	Checksum: 0xBDDD4895
	Offset: 0x2648
	Size: 0x138
	Parameters: 1
	Flags: None
*/
function body_customization_devgui(mode)
{
	/#
		function_970d4891(mode);
		for(;;)
		{
			var_f12e4923 = getdvarstring(#"hash_2195b248bfe1371e", "");
			if(var_f12e4923 != "")
			{
				level thread body_customization_populate(mode, var_f12e4923);
				setdvar(#"hash_2195b248bfe1371e", "");
			}
			character_index = getdvarstring(#"char_devgui", "");
			if(character_index != "")
			{
				body_customization_process_command(character_index);
				setdvar(#"char_devgui", "");
			}
			wait(0.5);
		}
	#/
}

/*
	Name: add_perk_devgui
	Namespace: dev
	Checksum: 0x6E9695A3
	Offset: 0x2788
	Size: 0xBC
	Parameters: 2
	Flags: None
*/
function add_perk_devgui(name, specialties)
{
	/#
		perk_devgui_base = "";
		perk_name = name;
		test = (((((perk_devgui_base + perk_name) + "") + "") + "") + specialties) + "";
		util::function_345e5b9a((((((perk_devgui_base + perk_name) + "") + "") + "") + specialties) + "");
	#/
}

/*
	Name: function_373068ca
	Namespace: dev
	Checksum: 0xA0B65A95
	Offset: 0x2850
	Size: 0xCC
	Parameters: 2
	Flags: None
*/
function function_373068ca(name, postfix)
{
	/#
		if(!isdefined(postfix))
		{
			postfix = "";
		}
		if(!isdefined(name))
		{
			return;
		}
		if(name == "")
		{
			return;
		}
		util::waittill_can_add_debug_command();
		talentname = ("" + name) + postfix;
		cmd = (("" + "") + "") + talentname;
		util::function_e2e9d901("" + talentname, cmd);
	#/
}

/*
	Name: function_8263c0d5
	Namespace: dev
	Checksum: 0x4248FC2B
	Offset: 0x2928
	Size: 0xDC
	Parameters: 2
	Flags: None
*/
function function_8263c0d5(name, postfix)
{
	/#
		if(!isdefined(postfix))
		{
			postfix = "";
		}
		if(!isdefined(name))
		{
			return;
		}
		if(name == "")
		{
			return;
		}
		util::waittill_can_add_debug_command();
		talentname = ("" + getsubstr(name, 7)) + postfix;
		cmd = (("" + "") + "") + talentname;
		util::function_e2e9d901("" + talentname, cmd);
	#/
}

/*
	Name: function_a432e633
	Namespace: dev
	Checksum: 0xC35E7327
	Offset: 0x2A10
	Size: 0x17C
	Parameters: 0
	Flags: None
*/
function function_a432e633()
{
	/#
		gesture = getdvarstring(#"hash_69042953f03fb8a4");
		if(isdefined(gesture) && gesture != "")
		{
			foreach(player in level.players)
			{
				if(isbot(player))
				{
					continue;
				}
				player gestures::function_ae63f496();
				player.loadoutgesture = getweapon(gesture);
				if(isdefined(player.loadoutgesture) && player.loadoutgesture != level.weaponnone)
				{
					player gestures::function_f8ae6f87(player.loadoutgesture);
				}
			}
		}
		setdvar(#"hash_69042953f03fb8a4", "");
	#/
}

/*
	Name: function_487bf571
	Namespace: dev
	Checksum: 0xA5C6773
	Offset: 0x2B98
	Size: 0x90
	Parameters: 0
	Flags: None
*/
function function_487bf571()
{
	/#
		for(;;)
		{
			gesture = getdvarstring(#"hash_69042953f03fb8a4");
			if(gesture != "")
			{
				function_a432e633();
			}
			setdvar(#"hash_69042953f03fb8a4", "");
			wait(0.5);
		}
	#/
}

/*
	Name: get_lookat_origin
	Namespace: dev
	Checksum: 0x18D0AC7A
	Offset: 0x2C30
	Size: 0xC8
	Parameters: 1
	Flags: None
*/
function get_lookat_origin(player)
{
	/#
		angles = player getplayerangles();
		forward = anglestoforward(angles);
		dir = vectorscale(forward, 8000);
		eye = player geteye();
		trace = bullettrace(eye, eye + dir, 0, undefined);
		return trace[#"position"];
	#/
}

/*
	Name: draw_pathnode
	Namespace: dev
	Checksum: 0x80ADB512
	Offset: 0x2D08
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function draw_pathnode(node, color)
{
	/#
		if(!isdefined(color))
		{
			color = (1, 0, 1);
		}
		box(node.origin, vectorscale((-1, -1, 0), 16), vectorscale((1, 1, 1), 16), 0, color, 1, 0, 1);
	#/
}

/*
	Name: draw_pathnode_think
	Namespace: dev
	Checksum: 0x41B1948B
	Offset: 0x2D80
	Size: 0x4E
	Parameters: 2
	Flags: None
*/
function draw_pathnode_think(node, color)
{
	/#
		level endon(#"draw_pathnode_stop");
		for(;;)
		{
			draw_pathnode(node, color);
			waitframe(1);
		}
	#/
}

/*
	Name: draw_pathnodes_stop
	Namespace: dev
	Checksum: 0xD865E538
	Offset: 0x2DD8
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function draw_pathnodes_stop()
{
	/#
		wait(5);
		level notify(#"draw_pathnode_stop");
	#/
}

/*
	Name: node_get
	Namespace: dev
	Checksum: 0xCA466BCD
	Offset: 0x2E00
	Size: 0x120
	Parameters: 1
	Flags: None
*/
function node_get(player)
{
	/#
		for(;;)
		{
			waitframe(1);
			origin = get_lookat_origin(player);
			node = getnearestnode(origin);
			if(!isdefined(node))
			{
				continue;
			}
			if(player buttonpressed(""))
			{
				return node;
			}
			if(player buttonpressed(""))
			{
				return undefined;
			}
			if(node.type == #"path")
			{
				draw_pathnode(node, (1, 0, 1));
				continue;
			}
			draw_pathnode(node, (0.85, 0.85, 0.1));
		}
	#/
}

/*
	Name: dev_get_node_pair
	Namespace: dev
	Checksum: 0x736182BF
	Offset: 0x2F28
	Size: 0x1A4
	Parameters: 0
	Flags: None
*/
function dev_get_node_pair()
{
	/#
		player = util::gethostplayer();
		start = undefined;
		while(!isdefined(start))
		{
			start = node_get(player);
			if(player buttonpressed(""))
			{
				level notify(#"draw_pathnode_stop");
				return undefined;
			}
		}
		level thread draw_pathnode_think(start, (0, 1, 0));
		while(player buttonpressed(""))
		{
			waitframe(1);
		}
		end = undefined;
		while(!isdefined(end))
		{
			end = node_get(player);
			if(player buttonpressed(""))
			{
				level notify(#"draw_pathnode_stop");
				return undefined;
			}
		}
		level thread draw_pathnode_think(end, (0, 1, 0));
		level thread draw_pathnodes_stop();
		array = [];
		array[0] = start;
		array[1] = end;
		return array;
	#/
}

/*
	Name: draw_point
	Namespace: dev
	Checksum: 0xDFD4B232
	Offset: 0x30D8
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function draw_point(origin, color)
{
	/#
		if(!isdefined(color))
		{
			color = (1, 0, 1);
		}
		sphere(origin, 16, color, 0.25, 0, 16, 1);
	#/
}

/*
	Name: point_get
	Namespace: dev
	Checksum: 0x97ABD4A0
	Offset: 0x3138
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function point_get(player)
{
	/#
		for(;;)
		{
			waitframe(1);
			origin = get_lookat_origin(player);
			if(player buttonpressed(""))
			{
				return origin;
			}
			if(player buttonpressed(""))
			{
				return undefined;
			}
			draw_point(origin, (1, 0, 1));
		}
	#/
}

/*
	Name: dev_get_point_pair
	Namespace: dev
	Checksum: 0x782A7195
	Offset: 0x31E0
	Size: 0xFA
	Parameters: 0
	Flags: None
*/
function dev_get_point_pair()
{
	/#
		player = util::gethostplayer();
		start = undefined;
		points = [];
		while(!isdefined(start))
		{
			start = point_get(player);
			if(!isdefined(start))
			{
				return points;
			}
		}
		while(player buttonpressed(""))
		{
			waitframe(1);
		}
		end = undefined;
		while(!isdefined(end))
		{
			end = point_get(player);
			if(!isdefined(end))
			{
				return points;
			}
		}
		points[0] = start;
		points[1] = end;
		return points;
	#/
}

