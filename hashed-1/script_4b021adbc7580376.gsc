// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b150f8ff0495a20;
#using script_2c2d166441e0da0f;
#using script_4b828d814e8e03a1;
#using script_5209c07c35771d12;
#using script_64ab2b950d85b8ad;
#using script_6aa2128e9d9956a2;
#using script_71e26f08f03b7a7a;
#using script_77ba97b99c9d8532;
#using script_78fb87cbf5b3ed1d;
#using script_8abfb58852911dd;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\compass.gsc;
#using scripts\core_common\death_circle.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\load.gsc;

#namespace namespace_e4918a50;

/*
	Name: main
	Namespace: namespace_e4918a50
	Checksum: 0xE2B3EC21
	Offset: 0x150
	Size: 0x2E4
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	callback::on_spawned(&on_player_spawned);
	callback::add_callback(#"hash_3be1213f454fa90e", &function_78d5fb9b);
	/#
		callback::on_vehicle_spawned(&on_vehicle_spawned);
	#/
	if(!(isdefined(getgametypesetting(#"hash_5b7b817a91ce3534")) && getgametypesetting(#"hash_5b7b817a91ce3534")))
	{
		level.var_30783ca9 = &function_28990311;
	}
	level.mapcenter = (0, 0, 0);
	setmapcenter(level.mapcenter);
	level.var_7fd6bd44 = 3300;
	load::main();
	level.var_405a6738 = 16000;
	level.var_8a390df2 = 16000;
	level death_circle::init();
	if((isdefined(getgametypesetting(#"hash_731aac1992af2669")) ? getgametypesetting(#"hash_731aac1992af2669") : 0))
	{
		level thread function_74ee36be();
	}
	compass::setupminimap("");
	/#
		level thread function_2085db3b();
	#/
	level namespace_51010f55::init();
	level.var_18bf5e98 = &function_d075b84e;
	var_80b6eb8c = (isdefined(level.waverespawndelay) ? level.waverespawndelay : 30);
	if(var_80b6eb8c == 0)
	{
		var_80b6eb8c = 30;
	}
	var_80b6eb8c = int(var_80b6eb8c * 1000);
	item_world::function_cbc32e1b(var_80b6eb8c);
	level thread namespace_3d2704b3::start(3, 15, array(20, 20, 20));
}

/*
	Name: function_d075b84e
	Namespace: namespace_e4918a50
	Checksum: 0xDB42F95E
	Offset: 0x440
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_d075b84e()
{
	itemlist = level.var_9eb9a467;
	if(isdefined(level.var_b4143320) && level.var_b4143320)
	{
		if(isdefined(getgametypesetting(#"hash_26f00de198472b81")) && getgametypesetting(#"hash_26f00de198472b81"))
		{
			itemlist = #"hash_6f837d2828044413";
		}
		else
		{
			itemlist = #"hash_193884f7170a26bb";
		}
		if(randomint(100) <= 2)
		{
			if(!level.var_8a3036cc && isdefined(level.var_db43cbd7))
			{
				itemlist = level.var_db43cbd7;
				level.var_8a3036cc = 1;
			}
		}
	}
	return itemlist;
}

/*
	Name: on_player_spawned
	Namespace: namespace_e4918a50
	Checksum: 0x53A8B19C
	Offset: 0x558
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	/#
		self thread function_e8f0335f();
	#/
}

/*
	Name: function_28990311
	Namespace: namespace_e4918a50
	Checksum: 0xF15322C2
	Offset: 0x580
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_28990311()
{
	n_variant = "0" + randomintrange(1, 2);
	game.musicset = "_zm_" + n_variant;
}

/*
	Name: function_78d5fb9b
	Namespace: namespace_e4918a50
	Checksum: 0x5D6FD8DE
	Offset: 0x5D0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_78d5fb9b()
{
	playsoundatposition(#"hash_5bcfe3a4f3bf67a6", (-1638, -2162, 2673));
}

/*
	Name: function_74ee36be
	Namespace: namespace_e4918a50
	Checksum: 0x349B66A4
	Offset: 0x610
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function function_74ee36be()
{
	location = randomintrange(1, 3);
	switch(location)
	{
		case 1:
		{
			function_69e60a10("ParadeGrounds");
			break;
		}
		case 2:
		{
			function_69e60a10("NewIndustries");
			break;
		}
		case 3:
		{
			function_69e60a10("CellHouse");
			break;
		}
	}
}

/*
	Name: function_69e60a10
	Namespace: namespace_e4918a50
	Checksum: 0x9B37F5A
	Offset: 0x6E8
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_69e60a10(var_e4204b3)
{
	var_8e3c3c5b = level.var_fb91af8[level.var_fb91af8.size - 1];
	hint = struct::get(var_e4204b3);
	var_8e3c3c5b.var_3b9f4abf = hint.origin;
	var_8e3c3c5b.var_66b35636 = 1024;
	var_8e3c3c5b.var_3b4ad673 = 1024;
}

/*
	Name: function_2085db3b
	Namespace: namespace_e4918a50
	Checksum: 0x497143ED
	Offset: 0x780
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function function_2085db3b()
{
	/#
		mapname = util::function_53bbf9d2();
		adddebugcommand("");
		adddebugcommand("" + mapname + "");
		level thread function_9cc59537();
		level thread function_13a77bfa();
		level thread function_10c650e6();
		level thread function_4b227faf();
		level thread devgui_weapon_think();
	#/
}

/*
	Name: on_vehicle_spawned
	Namespace: namespace_e4918a50
	Checksum: 0xBFC18360
	Offset: 0x868
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function on_vehicle_spawned()
{
	/#
		self thread function_f42944c7();
	#/
}

/*
	Name: function_10c650e6
	Namespace: namespace_e4918a50
	Checksum: 0xF6457BC7
	Offset: 0x890
	Size: 0x20A
	Parameters: 0
	Flags: None
*/
function function_10c650e6()
{
	/#
		if(!getdvarint(#"hash_45acaa3a266bbdec", 0))
		{
			return;
		}
		item_world::function_1b11e73c();
		item_world::function_4de3ca98();
		var_6e64f8a3 = function_91b29d2a(#"hash_68307ed314684f1d");
		while(getdvarint(#"hash_45acaa3a266bbdec", 0))
		{
			foreach(point in var_6e64f8a3)
			{
				var_91d1913b = distance2d(level.players[0].origin, point.origin);
				n_radius = 0.015 * var_91d1913b;
				if(n_radius > 768)
				{
					n_radius = 768;
				}
				if(var_91d1913b > 768)
				{
					sphere(point.origin, n_radius, (0, 1, 0));
					if(var_91d1913b < 2048)
					{
						print3d(point.origin + (0, 0, 32), "", (0, 1, 0));
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_9cc59537
	Namespace: namespace_e4918a50
	Checksum: 0x2780C9F6
	Offset: 0xAA8
	Size: 0x149E
	Parameters: 0
	Flags: None
*/
function function_9cc59537()
{
	/#
		if(!getdvarint(#"hash_68dcd0d52e11b957", 0))
		{
			return;
		}
		var_55a05f87 = 0;
		var_cbc7aaf6 = 0;
		var_ebd66b56 = [];
		var_1d9375fc = struct::get_array("", "");
		foreach(group in var_1d9375fc)
		{
			group.var_4a3dcff2 = [];
			var_f0179f4a = getdvarstring(#"hash_230734aeaaf8671", "");
			if(isstring(group.target) && (var_f0179f4a == "" || function_d72aa67e(var_f0179f4a, group.target)))
			{
				group.var_4a3dcff2 = function_91b29d2a(group.target);
			}
		}
		var_7cb887a8 = [];
		level flag::wait_till("");
		level.players[0] endon(#"disconnect");
		adddebugcommand("");
		do
		{
			waitframe(8);
			foreach(group in var_1d9375fc)
			{
				var_b91441dd = getscriptbundle(group.scriptbundlename);
				if(!isdefined(var_b91441dd) || (isdefined(var_b91441dd.var_ca330541) && var_b91441dd.var_ca330541) || group.var_4a3dcff2.size == 0 || var_b91441dd.name === "" || var_b91441dd.name === "" || var_b91441dd.name === "")
				{
					continue;
				}
				else if(var_b91441dd.name === "")
				{
					var_df1e5fef = arraysortclosest(group.var_4a3dcff2, level.players[0].origin, 85, 1, 4000);
					foreach(point in var_df1e5fef)
					{
						sphere(point.origin, 16, (1, 1, 1), 1, 0, 16, 8);
					}
					continue;
				}
				spawn_points = arraysortclosest(group.var_4a3dcff2, level.players[0].origin, 85, 1, 4000);
				foreach(point in spawn_points)
				{
					if(level.players[0] util::is_player_looking_at(point.origin, 0.8, 0))
					{
						b_failed = 0;
						var_47748885 = 28;
						var_c5330f11 = 32;
						v_color = (1, 0, 1);
						if(isdefined(var_b91441dd.itemlist[0]))
						{
							if(var_b91441dd.itemlist[0].var_a6762160 === "" || var_b91441dd.itemlist[0].var_a6762160 === "" || var_b91441dd.itemlist[0].var_a6762160 === "" || var_b91441dd.itemlist[0].var_a6762160 === "" || var_b91441dd.itemlist[0].var_a6762160 === "" || var_b91441dd.itemlist[0].var_a6762160 === "" || var_b91441dd.itemlist[0].var_a6762160 === "")
							{
								v_color = (1, 1, 0);
								var_47748885 = 4;
								var_c5330f11 = 4;
							}
							else if(var_b91441dd.itemlist[0].var_a6762160 === "")
							{
								v_color = (1, 1, 0);
								var_47748885 = 8;
								var_c5330f11 = 8;
							}
						}
						n_radius = 4;
						items = item_world::function_2e3efdda(point.origin, undefined, 1, var_47748885, -1, 1);
						if(items.size > 0)
						{
							v_color = (0, 1, 0);
							foreach(item in items)
							{
								var_c3aa278e = item.var_a6762160.name;
								str_item_name = getdvarstring(#"hash_4d2d3346b87258c6", "");
								if(function_d72aa67e(str_item_name, var_c3aa278e))
								{
									n_radius = 18;
									v_color = (1, 0.5, 0);
									print3d(point.origin + vectorscale((0, 0, 1), 24), var_c3aa278e, v_color, 1, 0.3, 8);
								}
							}
						}
						var_7cb887a8 = [];
						var_3e832e74 = 360 / 8;
						v_angles = point.angles;
						var_c24ea284 = undefined;
						var_4b82457c = distance2d(point.origin, level.players[0].origin);
						var_24b0b1ea = var_b91441dd.var_7fb0967b;
						if(isdefined(var_24b0b1ea))
						{
							if(items.size > 0)
							{
								var_abc7e003 = item_world::function_2e3efdda(point.origin, undefined, 20, var_24b0b1ea, -1, 1);
								var_abc7e003 = arraysortclosest(var_abc7e003, point.origin, 10, var_47748885);
								foreach(item_type in var_b91441dd.itemlist)
								{
									foreach(var_d76a7255 in var_abc7e003)
									{
										if(item_type.var_a6762160 === var_d76a7255.var_a6762160.name && var_d76a7255.var_a6762160.name === items[0].var_a6762160.name)
										{
											print3d(point.origin + vectorscale((0, 0, 1), 18), item_type.var_a6762160 + "" + var_24b0b1ea, (1, 0.5, 0), 1, 0.3, 8);
											line(var_d76a7255.origin, point.origin, (1, 0.5, 0), 1, 0, 8);
										}
									}
								}
							}
						}
						if(isdefined(var_b91441dd.var_f4cdfe08) && var_b91441dd.var_f4cdfe08)
						{
							n_depth = 18;
							n_width = 24;
							if(var_b91441dd.name === "" || var_b91441dd.name === "" || var_b91441dd.name === "")
							{
								n_depth = 12;
								n_width = 48;
							}
							var_7cb887a8[0] = point.origin + (0, 0, 16) + vectorscale(anglestoforward(v_angles), n_depth);
							var_7cb887a8[1] = point.origin + (0, 0, 16) + vectorscale(anglestoforward(v_angles) * -1, n_depth);
							var_7cb887a8[2] = point.origin + (0, 0, 16) + vectorscale(anglestoright(v_angles), n_width);
							var_7cb887a8[3] = point.origin + (0, 0, 16) + vectorscale(anglestoright(v_angles) * -1, n_width);
						}
						else
						{
							for(i = 0; i < 8; i++)
							{
								var_7cb887a8[i] = point.origin + (0, 0, 16) + vectorscale(anglestoforward(v_angles), var_47748885);
								v_angles = v_angles + (0, var_3e832e74, 0);
							}
						}
						var_2e0e7774 = arraysortclosest(spawn_points, point.origin, 20, 1, var_c5330f11);
						foreach(close in var_2e0e7774)
						{
							if(bullettracepassed(point.origin + (0, 0, 16), close.origin, 0, level.players[0]))
							{
								v_color = (0, 0, 1);
								b_failed = 1;
								line(close.origin, point.origin, v_color, 1, 0, 8);
								circle(point.origin, var_c5330f11 / 2, v_color, 0, 1, 8);
								print3d(point.origin + vectorscale((0, 0, 1), 24), sqrt(distancesquared(point.origin, close.origin)), v_color, 1, 0.3, 8);
							}
						}
						if(isdefined(var_b91441dd.var_f4cdfe08) && var_b91441dd.var_f4cdfe08)
						{
							var_47748885 = n_depth;
							foreach(i, v_test in var_7cb887a8)
							{
								if(i > 2)
								{
									var_47748885 = n_width;
								}
								a_trace = bullettrace(point.origin + vectorscale((0, 0, 1), 24), v_test, 0, level.players[0]);
								if(distancesquared(a_trace[#"position"], point.origin + vectorscale((0, 0, 1), 24)) < var_47748885 * var_47748885 - 2 && !isdefined(a_trace[#"dynent"]))
								{
									v_color = (1, 0, 0);
									b_failed = 1;
									if(var_4b82457c < 256)
									{
										debugstar(a_trace[#"position"], 8, v_color);
									}
								}
							}
							var_47748885 = 18;
						}
						else
						{
							foreach(v_test in var_7cb887a8)
							{
								a_trace = bullettrace(point.origin + (0, 0, 16), v_test, 0, level.players[0]);
								if(distancesquared(a_trace[#"position"], point.origin + (0, 0, 16)) < var_47748885 * var_47748885 - 3 && !isdefined(a_trace[#"dynent"]))
								{
									v_color = (1, 0, 0);
									b_failed = 1;
									if(var_4b82457c < 256)
									{
										debugstar(a_trace[#"position"], 8, v_color);
									}
								}
							}
						}
						if(b_failed)
						{
							n_radius = 0.015 * var_4b82457c;
							if(n_radius > 32)
							{
								n_radius = 32;
							}
						}
						if(isdefined(var_b91441dd.var_f4cdfe08) && var_b91441dd.var_f4cdfe08)
						{
							function_47351fa3(point.origin, point.angles, v_color, 8);
						}
						if(var_4b82457c > 212)
						{
							sphere(point.origin, n_radius, v_color, 1, 0, 8, 8);
						}
						if(bullettracepassed(point.origin, level.players[0] geteye(), 0, level.players[0], var_c24ea284))
						{
							circle(point.origin, var_47748885, v_color, 0, 1, 8);
							if(var_4b82457c < 512)
							{
								print3d(point.origin, function_9e72a96(point.targetname), v_color, 1, 0.4, 8);
								if(var_4b82457c < 256 && level.players[0] util::is_player_looking_at(point.origin, 0.87, 0))
								{
									print3d(point.origin + vectorscale((0, 0, 1), 12), point.origin, v_color, 1, 0.3, 8);
								}
							}
						}
					}
				}
			}
		}
		while(getdvarint(#"hash_68dcd0d52e11b957", 0));
	#/
}

/*
	Name: function_d72aa67e
	Namespace: namespace_e4918a50
	Checksum: 0xFCC168C0
	Offset: 0x1F50
	Size: 0xB2
	Parameters: 2
	Flags: None
*/
function function_d72aa67e(str_list, str_name)
{
	/#
		var_be4c7921 = strtok(str_list, "");
		foreach(tok in var_be4c7921)
		{
			if(tok == str_name)
			{
				return 1;
			}
		}
		return 0;
	#/
}

/*
	Name: function_47351fa3
	Namespace: namespace_e4918a50
	Checksum: 0xEC5BDF52
	Offset: 0x2010
	Size: 0x324
	Parameters: 4
	Flags: None
*/
function function_47351fa3(org, ang, opcolor, frames)
{
	/#
		if(!isdefined(frames))
		{
			frames = 1;
		}
		forward = anglestoforward(ang);
		forwardfar = vectorscale(forward, 50);
		forwardclose = vectorscale(forward, 50 * 0.8);
		right = anglestoright(ang);
		left = anglestoright(ang) * -1;
		leftdraw = vectorscale(right, 50 * -0.2);
		rightdraw = vectorscale(right, 50 * 0.2);
		up = anglestoup(ang);
		right = vectorscale(right, 50);
		left = vectorscale(left, 50);
		up = vectorscale(up, 50);
		red = (0.9, 0.2, 0.2);
		green = (0.2, 0.9, 0.2);
		blue = (0.2, 0.2, 0.9);
		if(isdefined(opcolor))
		{
			red = opcolor;
			green = opcolor;
			blue = opcolor;
		}
		line(org, org + forwardfar, red, 0.9, 0, frames);
		line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9, 0, frames);
		line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9, 0, frames);
		line(org, org + right, blue, 0.9, 0, frames);
		line(org, org + left, blue, 0.9, 0, frames);
		line(org, org + up, green, 0.9, 0, frames);
	#/
}

/*
	Name: function_e8f0335f
	Namespace: namespace_e4918a50
	Checksum: 0x4CB2D67D
	Offset: 0x2340
	Size: 0x6C0
	Parameters: 0
	Flags: None
*/
function function_e8f0335f()
{
	/#
		if(!getdvarint(#"hash_15ce8723d2ead5ef", 0))
		{
			return;
		}
		self endon(#"death", #"disconnect");
		var_b3a9e916 = getdvarint(#"hash_796c892495c48172", 1);
		while(getdvarint(#"hash_15ce8723d2ead5ef", 1))
		{
			waitframe(1);
			if(self weaponswitchbuttonpressed())
			{
				var_b3a9e916 = var_b3a9e916 + 1;
				if(var_b3a9e916 > 2)
				{
					var_b3a9e916 = 0;
				}
				setdvar(#"hash_796c892495c48172", var_b3a9e916);
				while(self weaponswitchbuttonpressed())
				{
					waitframe(1);
				}
			}
			if(var_b3a9e916 == 0)
			{
				continue;
			}
			v_eye = self geteye();
			v_end = v_eye + vectorscale(anglestoforward(self getplayerangles()), 1024);
			physicstrace = physicstraceex(v_eye, v_end, vectorscale((-1, -1, -1), 0.5), vectorscale((1, 1, 1), 0.5), self, 32);
			var_11cc451b = bullettrace(v_eye, v_end, 0, self, 0, 0);
			var_708a2754 = physicstrace;
			var_7cb887a8 = [];
			var_3e832e74 = 360 / 8;
			if(var_11cc451b[#"position"][2] > physicstrace[#"position"][2])
			{
				var_708a2754 = var_11cc451b;
			}
			origin = var_708a2754[#"position"];
			if(var_708a2754[#"fraction"] < 1 && vectordot(var_708a2754[#"normal"], (0, 0, 1)) >= 0.707)
			{
				if(var_708a2754[#"position"][2] > -10000)
				{
					origin = var_708a2754[#"position"];
				}
			}
			b_failed = 0;
			v_color = (0, 1, 0);
			v_angles = (0, 0, 0);
			if(var_b3a9e916 != 0)
			{
				for(i = 0; i < 8; i++)
				{
					var_7cb887a8[i] = origin + (0, 0, 12) + vectorscale(anglestoforward(v_angles), 32);
					v_angles = v_angles + (0, var_3e832e74, 0);
				}
				foreach(v_test in var_7cb887a8)
				{
					a_trace = bullettrace(origin + (0, 0, 12), v_test, 0, level.players[0]);
					if(isdefined(a_trace[#"entity"]))
					{
						a_trace = bullettrace(origin + (0, 0, 12), v_test, 0, a_trace[#"entity"]);
					}
					if(distancesquared(a_trace[#"position"], origin + (0, 0, 12)) < 32 * 32 - 2)
					{
						v_color = (1, 0, 0);
						b_failed = 1;
						if(distance2d(origin, level.players[0] getorigin()) < 512)
						{
							debugstar(a_trace[#"position"], 1, v_color);
						}
					}
				}
			}
			sphere(origin, 2, v_color);
			circle(origin, 32, v_color, 0, 1, 1);
			if(var_b3a9e916 == 2)
			{
				print3d(origin + vectorscale((0, 0, 1), 8), "" + origin, v_color, 0.25, 1);
			}
			if(b_failed)
			{
				print3d(origin + vectorscale((0, 0, 1), 8), "", v_color, 0.85, 1);
			}
		}
	#/
}

/*
	Name: function_f9b68fd7
	Namespace: namespace_e4918a50
	Checksum: 0x5D9D86DC
	Offset: 0x2A08
	Size: 0x2B0
	Parameters: 1
	Flags: Private, Event
*/
private event function_f9b68fd7(eventstruct)
{
	/#
		if(!getdvarint(#"hash_69592e1b2d05fb21", 0))
		{
			return;
		}
		dynent = eventstruct.ent;
		dynent notify(#"debug_draw");
		dynent endon(#"debug_draw");
		while(getdvarint(#"hash_69592e1b2d05fb21", 0))
		{
			waitframe(10);
			if(!isdefined(level.players[0]))
			{
				continue;
			}
			var_91d1913b = distance2d(dynent.origin, level.players[0].origin);
			if(level.players[0] util::is_player_looking_at(dynent.origin, 0.8, 0) && var_91d1913b <= 6000)
			{
				if(isdefined(dynent.var_15d44120) && dynent.var_15d44120 !== #"hash_1dcbe8021fb16344")
				{
					function_a476d876(dynent.origin, dynent.angles, (1, 0.5, 0), 10);
					if(var_91d1913b <= 768)
					{
						print3d(dynent.origin + vectorscale((0, 0, 1), 18), function_9e72a96(dynent.var_15d44120), (1, 0.5, 0), 0.9, 0.5, 10);
					}
				}
				if(isdefined(dynent.targetname) && var_91d1913b <= 768)
				{
					print3d(dynent.origin + vectorscale((0, 0, 1), 8), function_9e72a96(dynent.targetname), (1, 0.5, 0), 0.9, 0.5, 10);
				}
			}
		}
	#/
}

/*
	Name: function_a476d876
	Namespace: namespace_e4918a50
	Checksum: 0x57BB5C65
	Offset: 0x2CC0
	Size: 0x22C
	Parameters: 4
	Flags: None
*/
function function_a476d876(org, ang, opcolor, frames)
{
	/#
		if(!isdefined(frames))
		{
			frames = 1;
		}
		right = anglestoright(ang);
		left = anglestoright(ang) * -1;
		forwardfar = vectorscale(left, 52);
		forwardclose = vectorscale(left, 52 * 0.8);
		leftdraw = vectorscale(right, 52 * -0.2);
		rightdraw = vectorscale(right, 52 * 0.2);
		up = anglestoup(ang);
		right = vectorscale(right, 52);
		left = vectorscale(left, 52);
		up = vectorscale(up, 96);
		red = (0.9, 0.2, 0.2);
		green = (0.2, 0.9, 0.2);
		blue = (0.2, 0.2, 0.9);
		if(isdefined(opcolor))
		{
			red = opcolor;
			green = opcolor;
			blue = opcolor;
		}
		line(org, org + left, blue, 0.9, 0, frames);
		line(org, org + up, green, 0.9, 0, frames);
	#/
}

/*
	Name: function_13a77bfa
	Namespace: namespace_e4918a50
	Checksum: 0xEE84078A
	Offset: 0x2EF8
	Size: 0x56E
	Parameters: 0
	Flags: None
*/
function function_13a77bfa()
{
	/#
		if(!getdvarint(#"hash_43f2306cde703585", 0))
		{
			return;
		}
		level flag::wait_till("");
		var_c57af5d9 = level.var_7767cea8;
		do
		{
			waitframe(12);
			total_spawns = 0;
			var_ad802a37 = (120, 480, 0);
			debug2dtext(var_ad802a37, "" + var_c57af5d9.size, (1, 0.7529412, 0.7960784), 1, (0, 0, 0), 0.5, 1.3, 12);
			foreach(influencer in var_c57af5d9)
			{
				spawns = arraysortclosest(influencer.spawns, influencer.origin);
				furthest = spawns[spawns.size - 1];
				radius = distance2d(influencer.origin, furthest.origin);
				circle(influencer.origin, radius, (1, 0.7529412, 0.7960784), 0, 1, 12);
				print3d(influencer.origin + (0, 0, 0), function_9e72a96(influencer.target), (1, 0.7529412, 0.7960784), 0.9, 4, 12);
				print3d(influencer.origin + vectorscale((0, 0, 1), 96), spawns.size, (1, 0.7529412, 0.7960784), 0.9, 4, 12);
				foreach(spawn in spawns)
				{
					line(influencer.origin, spawn.origin, (1, 0.7529412, 0.7960784), 1, 0, 12);
					sphere(spawn.origin, 10, (1, 0.7529412, 0.7960784), 1, 0, 4, 12);
					print3d(spawn.origin + vectorscale((0, 0, 1), 12), function_9e72a96(spawn.targetname), (1, 0.7529412, 0.7960784), 0.9, 0.5, 12);
				}
				total_spawns = total_spawns + spawns.size;
				var_ad802a37 = var_ad802a37 + (0, 28, 0);
				debug2dtext(var_ad802a37, influencer.target + "" + spawns.size, (1, 0.7529412, 0.7960784), 1, (0, 0, 0), 0.5, 1, 12);
			}
			var_ad802a37 = var_ad802a37 + (0, 28, 0);
			debug2dtext(var_ad802a37, "" + total_spawns, (1, 0.7529412, 0.7960784), 1, (0, 0, 0), 0.5, 1.3, 12);
		}
		while(getdvarint(#"hash_43f2306cde703585", 0));
	#/
}

/*
	Name: function_f42944c7
	Namespace: namespace_e4918a50
	Checksum: 0x33BB2E6A
	Offset: 0x3470
	Size: 0x436
	Parameters: 0
	Flags: None
*/
function function_f42944c7()
{
	/#
		if(!getdvarint(#"hash_57a9b32c8a8503f1", 0) || !self function_1221d304())
		{
			return;
		}
		self endon(#"death");
		if(!isdefined(level.var_6eef6733))
		{
			level.var_6eef6733 = [];
		}
		if(!isdefined(level.var_6eef6733[function_9e72a96(self.vehicletype)]))
		{
			level.var_6eef6733[function_9e72a96(self.vehicletype)] = [];
		}
		if(!isdefined(level.var_6eef6733[function_9e72a96(self.vehicletype)]))
		{
			level.var_6eef6733[function_9e72a96(self.vehicletype)] = [];
		}
		else if(!isarray(level.var_6eef6733[function_9e72a96(self.vehicletype)]))
		{
			level.var_6eef6733[function_9e72a96(self.vehicletype)] = array(level.var_6eef6733[function_9e72a96(self.vehicletype)]);
		}
		level.var_6eef6733[function_9e72a96(self.vehicletype)][level.var_6eef6733[function_9e72a96(self.vehicletype)].size] = self;
		v_spawn_pos = self.origin;
		level thread function_f567f0cd();
		level flag::wait_till("");
		str_type = function_9e72a96(self.vehicletype);
		v_color = self function_b2775b52();
		while(getdvarint(#"hash_57a9b32c8a8503f1", 0))
		{
			var_91d1913b = distance2d(level.players[0].origin, self.origin);
			n_radius = 0.015 * var_91d1913b;
			if(n_radius > 768)
			{
				n_radius = 768;
			}
			if(var_91d1913b > 768)
			{
				sphere(self.origin, n_radius, v_color);
				if(var_91d1913b < 2048)
				{
					print3d(self.origin + (0, 0, 32), str_type, v_color);
				}
			}
			if(getdvarint(#"hash_491fd7f96bbc8909", 0) && distance2d(v_spawn_pos, self.origin) > 4)
			{
				line(v_spawn_pos, self.origin, v_color);
				circle(v_spawn_pos, 64, v_color, 0, 1);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_f567f0cd
	Namespace: namespace_e4918a50
	Checksum: 0x9A006651
	Offset: 0x38B0
	Size: 0x25E
	Parameters: 0
	Flags: None
*/
function function_f567f0cd()
{
	/#
		level notify(#"hash_79845fe0e187bb22");
		level endon(#"hash_79845fe0e187bb22");
		while(getdvarint(#"hash_57a9b32c8a8503f1", 0))
		{
			n_total = 0;
			var_bd9acc19 = 176;
			foreach(var_f0ffe8b2 in level.var_6eef6733)
			{
				var_bd9acc19 = var_bd9acc19 + 24;
				n_total = n_total + var_f0ffe8b2.size;
				foreach(var_3ed342fe in var_f0ffe8b2)
				{
					if(isvehicle(var_3ed342fe) && isdefined(var_f0ffe8b2) && isdefined(var_f0ffe8b2[0]) && isdefined(var_f0ffe8b2[0].vehicletype))
					{
						debug2dtext((810, var_bd9acc19, 0), function_9e72a96(var_f0ffe8b2[0].vehicletype) + "" + var_f0ffe8b2.size, var_3ed342fe function_b2775b52());
						break;
					}
				}
			}
			debug2dtext((810, 176, 0), "" + n_total, (1, 1, 1));
			waitframe(1);
		}
	#/
}

/*
	Name: function_1221d304
	Namespace: namespace_e4918a50
	Checksum: 0xED06BABA
	Offset: 0x3B18
	Size: 0x3FC
	Parameters: 0
	Flags: None
*/
function function_1221d304()
{
	/#
		a_str_types = array(#"hash_50df12a3f608295f", #"hash_2321fdb723c1833e", #"hash_1207be62f5586002", #"hash_9c4bbd4ed2ab01a", #"hash_262b20d4fdef3691", #"hash_5e74d2d4d4a1d9dd", #"hash_232aa3a4e81249c6", #"hash_232abda4e81275f4", #"hash_7acdf9a4d20bca08", #"hash_2f8d60a5381870ee", #"hash_1d6e04a52d9a5fe2", #"hash_371dca31a8d2a390", #"hash_1f38eb47b13ae0a2", #"hash_7473bb4a4fe9a17f", #"hash_a32b2557c188dbe", #"hash_32e2d28d167e8e92", #"hash_4c1a688d248f81bc", #"hash_6eba738d801e1796", #"hash_4e73f59c7e21ce5a", #"hash_2f8f4f949bf9ac15", #"hash_15ddcb948d817b45", #"hash_516b7a9466fa5c12", #"hash_769bc3a07e8bc079", #"hash_25efdc944e4cca5b", #"veh_muscle_car_convertible_player_wz_replacer", #"hash_cd755944056a13d", #"hash_56e75c94213b20da", #"hash_2f8f41949bf9944b", #"hash_2da622f0e5b37c60", #"hash_54469210eb79f8fa", #"hash_5a8d85277c6e81cc", #"hash_fd30bfe9c72da01", #"hash_762e82fe8e052b0e", #"hash_6a5a5607b259798f", #"hash_6d35ebfe40e6564f", #"hash_1a7b0eaf3ae726cd", #"hash_2e86e4a61f2237f6", #"hash_2c40642bbbab460d", #"hash_482e864157620248", #"hash_1d37bc413f25898e", #"hash_1d37af413f257377", #"hash_8ea0340ead96490", #"hash_79bf6a7491c80c7", #"hash_32e4c0a7619f03a9", #"hash_22d9b5a7a0d9dd73", #"hash_2466ddfe7224bda1", #"hash_559a470c57ff48f1", #"hash_7c419239b3b272a1", #"hash_750e85ddbd818361", #"hash_6bb2c4db63712ba6", #"hash_2a3f3e38128fc907", #"hash_5aaa847b9e03f876", #"hash_18fa6d20a6e8fa78", #"hash_5b0fb5b643c105fa");
		foreach(str_type in a_str_types)
		{
			if(self.vehicletype == str_type)
			{
				return 1;
			}
		}
		return 0;
	#/
}

/*
	Name: function_b2775b52
	Namespace: namespace_e4918a50
	Checksum: 0x5711E9B1
	Offset: 0x3F20
	Size: 0x3E2
	Parameters: 0
	Flags: None
*/
function function_b2775b52()
{
	/#
		switch(self.vehicletype)
		{
			case "hash_1d6e04a52d9a5fe2":
			case "hash_232aa3a4e81249c6":
			case "hash_232abda4e81275f4":
			case "hash_2f8d60a5381870ee":
			case "hash_7acdf9a4d20bca08":
			{
				return (0, 0, 1);
			}
			case "hash_1207be62f5586002":
			case "hash_2321fdb723c1833e":
			case "hash_50df12a3f608295f":
			{
				return (1, 0, 1);
			}
			case "hash_a32b2557c188dbe":
			case "hash_18fa6d20a6e8fa78":
			case "hash_1d37af413f257377":
			case "hash_1d37bc413f25898e":
			case "hash_1f38eb47b13ae0a2":
			case "hash_2a3f3e38128fc907":
			case "hash_371dca31a8d2a390":
			case "hash_482e864157620248":
			case "hash_5aaa847b9e03f876":
			case "hash_5b0fb5b643c105fa":
			case "hash_6bb2c4db63712ba6":
			case "hash_7473bb4a4fe9a17f":
			{
				return (1, 0, 0);
			}
			case "hash_9c4bbd4ed2ab01a":
			case "hash_262b20d4fdef3691":
			case "hash_5e74d2d4d4a1d9dd":
			{
				return (1, 0.5, 0);
			}
			case "hash_79bf6a7491c80c7":
			case "hash_22d9b5a7a0d9dd73":
			case "hash_32e2d28d167e8e92":
			case "hash_32e4c0a7619f03a9":
			case "hash_4c1a688d248f81bc":
			case "hash_6eba738d801e1796":
			{
				return vectorscale((1, 1, 0), 0.5019608);
			}
			case "hash_2466ddfe7224bda1":
			case "hash_559a470c57ff48f1":
			case "hash_5a8d85277c6e81cc":
			case "hash_750e85ddbd818361":
			case "hash_7c419239b3b272a1":
			{
				return (0, 1, 0);
			}
			case "hash_fd30bfe9c72da01":
			case "hash_2e86e4a61f2237f6":
			case "hash_54469210eb79f8fa":
			case "hash_6a5a5607b259798f":
			case "hash_6d35ebfe40e6564f":
			case "hash_762e82fe8e052b0e":
			{
				return (0, 1, 1);
			}
			case "hash_cd755944056a13d":
			case "veh_muscle_car_convertible_player_wz_replacer":
			case "hash_15ddcb948d817b45":
			case "hash_25efdc944e4cca5b":
			case "hash_2da622f0e5b37c60":
			case "hash_2f8f41949bf9944b":
			case "hash_2f8f4f949bf9ac15":
			case "hash_4e73f59c7e21ce5a":
			case "hash_516b7a9466fa5c12":
			case "hash_56e75c94213b20da":
			case "hash_769bc3a07e8bc079":
			{
				return (0, 1, 1);
			}
			case "hash_2c40642bbbab460d":
			{
				return (0.5450981, 0.2705882, 0.07450981);
			}
			default:
			{
				return (1, 0, 1);
			}
		}
	#/
}

/*
	Name: function_4b227faf
	Namespace: namespace_e4918a50
	Checksum: 0x68F00396
	Offset: 0x4310
	Size: 0x34A
	Parameters: 0
	Flags: None
*/
function function_4b227faf()
{
	/#
		if(!getdvarint(#"hash_59e2d7722e56c1c6", 0))
		{
			return;
		}
		var_1d9375fc = struct::get_array("", "");
		foreach(group in var_1d9375fc)
		{
			switch(group.scriptbundlename)
			{
				case "hash_30e797eb835c5363":
				{
					var_dc1ea650 = group;
					break;
				}
				default:
				{
					break;
				}
			}
		}
		var_4ff6627b = [];
		var_6b5f6eb2 = function_91b29d2a(var_dc1ea650.target);
		var_4ff6627b = arraycombine(var_4ff6627b, var_6b5f6eb2, 0, 0);
		level flag::wait_till("");
		while(getdvarint(#"hash_59e2d7722e56c1c6", 0))
		{
			foreach(point in var_4ff6627b)
			{
				var_91d1913b = distance2d(level.players[0].origin, point.origin);
				n_radius = 0.015 * var_91d1913b;
				if(n_radius > 768)
				{
					n_radius = 768;
				}
				if(var_91d1913b > 768)
				{
					v_color = function_df930125(point.targetname);
					str_type = function_9e72a96(point.targetname);
					sphere(point.origin, n_radius, v_color);
					if(var_91d1913b < 2048)
					{
						print3d(point.origin + (0, 0, 32), str_type, v_color);
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_df930125
	Namespace: namespace_e4918a50
	Checksum: 0xB08C45C8
	Offset: 0x4668
	Size: 0x5A
	Parameters: 1
	Flags: None
*/
function function_df930125(str_type)
{
	/#
		switch(str_type)
		{
			case "hash_9f79ee175f9f015":
			{
				return (1, 0, 0);
			}
			default:
			{
				return (1, 0.5, 0);
			}
		}
	#/
}

/*
	Name: devgui_weapon_think
	Namespace: namespace_e4918a50
	Checksum: 0xB9BFE669
	Offset: 0x46D0
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function devgui_weapon_think()
{
	/#
		for(;;)
		{
			weapon_index = getdvarint(#"hash_56266bf001df762b", 0);
			switch(weapon_index)
			{
				case 1:
				{
					devgui_handle_player_command(&function_1880c93d);
					break;
				}
			}
			setdvar(#"hash_56266bf001df762b", 0);
			wait(0.5);
		}
	#/
}

/*
	Name: devgui_handle_player_command
	Namespace: namespace_e4918a50
	Checksum: 0xE688D262
	Offset: 0x4788
	Size: 0x134
	Parameters: 3
	Flags: None
*/
function devgui_handle_player_command(playercallback, pcb_param_1, pcb_param_2)
{
	/#
		pid = getdvarint(#"hash_56266bf001df762b", 0);
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
		setdvar(#"hash_56266bf001df762b", -1);
	#/
}

/*
	Name: function_1880c93d
	Namespace: namespace_e4918a50
	Checksum: 0x12999F34
	Offset: 0x48C8
	Size: 0xB4
	Parameters: 0
	Flags: Private
*/
private function function_1880c93d()
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		item = namespace_441c2f1c::function_ba18c3e5(#"hash_50b970644e43947b");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(item);
		self item_world::function_de2018e3(item, self, var_fa3df96);
	#/
}

