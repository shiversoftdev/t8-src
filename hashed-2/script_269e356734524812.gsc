// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\dev.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\util.gsc;

#namespace namespace_af53555a;

/*
	Name: function_d8049496
	Namespace: namespace_af53555a
	Checksum: 0x330AE9F4
	Offset: 0x98
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_d8049496()
{
	/#
		callback::on_start_gametype(&on_start_gametype);
		setdvar(#"hash_4c1fd51cfe763a2", "");
		setdvar(#"hash_6d53bd520b4f7853", "");
	#/
}

/*
	Name: on_start_gametype
	Namespace: namespace_af53555a
	Checksum: 0xF0A84542
	Offset: 0x120
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function on_start_gametype()
{
	/#
		thread function_3326cf8d();
	#/
}

/*
	Name: function_c28b3d26
	Namespace: namespace_af53555a
	Checksum: 0x1793E890
	Offset: 0x148
	Size: 0x224
	Parameters: 0
	Flags: None
*/
function function_c28b3d26()
{
	/#
		show_spawns = getdvarint(#"scr_showspawns", 0);
		show_start_spawns = getdvarint(#"scr_showstartspawns", 0);
		var_8f7b54b5 = getdvarint(#"hash_42bc2c660a3d2ecd", 0);
		if(show_spawns >= 1)
		{
			show_spawns = 1;
		}
		else
		{
			show_spawns = 0;
		}
		if(show_start_spawns >= 1)
		{
			show_start_spawns = 1;
		}
		else
		{
			show_start_spawns = 0;
		}
		if(var_8f7b54b5 >= 1)
		{
			var_8f7b54b5 = 1;
		}
		else
		{
			var_8f7b54b5 = 0;
		}
		if(!isdefined(level.show_spawns) || level.show_spawns != show_spawns)
		{
			level.show_spawns = show_spawns;
			setdvar(#"scr_showspawns", level.show_spawns);
			if(level.show_spawns)
			{
				showspawnpoints();
			}
			else
			{
				hidespawnpoints();
			}
		}
		if(!isdefined(level.var_8f7b54b5) || level.var_8f7b54b5 != var_8f7b54b5)
		{
			level.var_8f7b54b5 = var_8f7b54b5;
			setdvar(#"hash_42bc2c660a3d2ecd", level.var_8f7b54b5);
			if(level.var_8f7b54b5)
			{
				function_1b0780eb();
			}
			else
			{
				function_107f44c0();
			}
		}
	#/
}

/*
	Name: function_f084faed
	Namespace: namespace_af53555a
	Checksum: 0xFEED8E7F
	Offset: 0x378
	Size: 0x4D2
	Parameters: 0
	Flags: None
*/
function function_f084faed()
{
	/#
		if(!isdefined(level.var_2f11d3e5))
		{
			level.var_2f11d3e5 = [];
			level.var_2f11d3e5[#"dm"] = "";
			level.var_2f11d3e5[#"ffa"] = "";
			level.var_2f11d3e5[#"dem"] = "";
			level.var_2f11d3e5[#"demolition"] = "";
			level.var_2f11d3e5[#"dom"] = "";
			level.var_2f11d3e5[#"domination"] = "";
			level.var_2f11d3e5[#"hash_200088ed1400621f"] = "";
			level.var_2f11d3e5[#"hash_200089ed140063d2"] = "";
			level.var_2f11d3e5[#"hash_754a59ee5b52f897"] = "";
			level.var_2f11d3e5[#"hash_754a5aee5b52fa4a"] = "";
			level.var_2f11d3e5[#"hash_7faa5a704de97213"] = "";
			level.var_2f11d3e5[#"hash_69438a51aacbf824"] = "";
			level.var_2f11d3e5[#"hash_69438d51aacbfd3d"] = "";
			level.var_2f11d3e5[#"hash_16ca7b5aee87513c"] = "";
			level.var_2f11d3e5[#"hash_4bcbc46ff5f13ed4"] = "";
			level.var_2f11d3e5[#"hash_4bcbc76ff5f143ed"] = "";
			level.var_2f11d3e5[#"hash_4bcbc66ff5f1423a"] = "";
			level.var_2f11d3e5[#"ctf"] = "";
			level.var_2f11d3e5[#"frontline"] = "";
			level.var_2f11d3e5[#"gun"] = "";
			level.var_2f11d3e5[#"koth"] = "";
			level.var_2f11d3e5[#"infil"] = "";
			level.var_2f11d3e5[#"kc"] = "";
			level.var_2f11d3e5[#"sd"] = "";
			level.var_2f11d3e5[#"control"] = "";
			level.var_2f11d3e5[#"tdm"] = "";
			level.var_2f11d3e5[#"clean"] = "";
			level.var_2f11d3e5[#"ct"] = "";
			level.var_2f11d3e5[#"escort"] = "";
			level.var_2f11d3e5[#"bounty"] = "";
		}
	#/
}

/*
	Name: function_3326cf8d
	Namespace: namespace_af53555a
	Checksum: 0x9830140A
	Offset: 0x858
	Size: 0xCE
	Parameters: 0
	Flags: None
*/
function function_3326cf8d()
{
	/#
		while(true)
		{
			var_14d21c2b = getdvarstring(#"hash_35e516df462215b5");
			if(var_14d21c2b != "")
			{
				function_f084faed();
				var_9e1b22d = function_f0b81b80(var_14d21c2b);
				function_bf14041f(var_9e1b22d);
				setdvar(#"hash_35e516df462215b5", "");
			}
			wait(1);
		}
	#/
}

/*
	Name: function_bf14041f
	Namespace: namespace_af53555a
	Checksum: 0xD0B9D636
	Offset: 0x930
	Size: 0xEC
	Parameters: 1
	Flags: None
*/
function function_bf14041f(var_9e1b22d)
{
	/#
		hidespawnpoints();
		spawning::clear_spawn_points();
		globallogic_spawn::function_c40af6fa();
		foreach(spawnflag in var_9e1b22d)
		{
			globallogic_spawn::addsupportedspawnpointtype(spawnflag);
		}
		spawning::updateallspawnpoints();
		globallogic_spawn::addspawns();
		showspawnpoints();
	#/
}

/*
	Name: function_f0b81b80
	Namespace: namespace_af53555a
	Checksum: 0xAE56C6DB
	Offset: 0xA28
	Size: 0x1B8
	Parameters: 1
	Flags: None
*/
function function_f0b81b80(var_14d21c2b)
{
	/#
		flagset = [];
		tokens = strtok(tolower(var_14d21c2b), "");
		foreach(token in tokens)
		{
			spawnflag = function_423a05a4(token);
			if(isdefined(spawnflag))
			{
				flagset[spawnflag] = 1;
			}
		}
		flags = [];
		foreach(flag, var_f90db79c in flagset)
		{
			if(var_f90db79c)
			{
				if(!isdefined(flags))
				{
					flags = [];
				}
				else if(!isarray(flags))
				{
					flags = array(flags);
				}
				flags[flags.size] = flag;
			}
		}
		return flags;
	#/
}

/*
	Name: function_423a05a4
	Namespace: namespace_af53555a
	Checksum: 0x8BA2AAA9
	Offset: 0xBF0
	Size: 0x20
	Parameters: 1
	Flags: None
*/
function function_423a05a4(var_a7fb3ec0)
{
	/#
		return level.var_2f11d3e5[var_a7fb3ec0];
	#/
}

/*
	Name: function_5650f4ee
	Namespace: namespace_af53555a
	Checksum: 0x326104E7
	Offset: 0xC20
	Size: 0xF6
	Parameters: 4
	Flags: None
*/
function function_5650f4ee(var_7a594c78, var_55a94d2c, var_9fd9c93b, var_b8543545)
{
	/#
		if(var_55a94d2c == "")
		{
			return 1;
		}
		if(var_55a94d2c == "" && !var_b8543545)
		{
			return 0;
		}
		if(var_b8543545 && var_55a94d2c != "")
		{
			return 0;
		}
		if(var_55a94d2c == "" && var_7a594c78 != #"any")
		{
			if(var_7a594c78 == #"neutral" && isdefined(var_9fd9c93b))
			{
				return 0;
			}
			if(!(isdefined(var_9fd9c93b) && var_9fd9c93b == var_7a594c78))
			{
				return 0;
			}
		}
		return 1;
	#/
}

/*
	Name: function_88770699
	Namespace: namespace_af53555a
	Checksum: 0xCE14350B
	Offset: 0xD20
	Size: 0x258
	Parameters: 1
	Flags: None
*/
function function_88770699(spawnlist)
{
	/#
		level endon(#"hide_spawnpoints", #"hash_12bbc39c8f50f769");
		maxdistancesq = 1000000;
		hostplayer = util::gethostplayer();
		if(!isdefined(hostplayer))
		{
			return;
		}
		while(true)
		{
			color = (1, 1, 1);
			var_7a594c78 = getdvarstring(#"hash_4c1fd51cfe763a2");
			var_55a94d2c = getdvarstring(#"hash_6d53bd520b4f7853");
			level.var_3da2623a = [];
			for(spawn_point_index = 0; spawn_point_index < spawnlist.size; spawn_point_index++)
			{
				if(!function_5650f4ee(var_7a594c78, var_55a94d2c, spawnlist[spawn_point_index].team, (isdefined(spawnlist[spawn_point_index]._human_were) ? spawnlist[spawn_point_index]._human_were : 0)))
				{
					continue;
				}
				if(distancesquared(hostplayer.origin, spawnlist[spawn_point_index].origin) > maxdistancesq)
				{
					continue;
				}
				if(!isdefined(level.var_3da2623a))
				{
					level.var_3da2623a = [];
				}
				else if(!isarray(level.var_3da2623a))
				{
					level.var_3da2623a = array(level.var_3da2623a);
				}
				level.var_3da2623a[level.var_3da2623a.size] = spawnlist[spawn_point_index];
				function_8beb6f7d(spawnlist[spawn_point_index], color);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: showspawnpoints
	Namespace: namespace_af53555a
	Checksum: 0x304D6CD0
	Offset: 0xF80
	Size: 0xEC
	Parameters: 0
	Flags: None
*/
function showspawnpoints()
{
	/#
		spawns = [];
		spawnpoints = arraycombine(level.spawnpoints, spawns, 0, 0);
		if(isdefined(level.spawn_start))
		{
			foreach(startspawns in level.spawn_start)
			{
				spawnpoints = arraycombine(startspawns, spawnpoints, 0, 0);
			}
		}
		thread function_88770699(spawnpoints);
	#/
}

/*
	Name: function_1b0780eb
	Namespace: namespace_af53555a
	Checksum: 0xB0E5F92D
	Offset: 0x1078
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function function_1b0780eb()
{
	/#
		if(!isdefined(level.spawnpoints))
		{
			return;
		}
		color = (1, 1, 1);
		spawns = [];
		spawnpoints = arraycombine(level.allspawnpoints, spawns, 0, 0);
		if(isdefined(level.spawn_start))
		{
			foreach(startspawns in level.spawn_start)
			{
				spawnpoints = arraycombine(startspawns, spawnpoints, 0, 0);
			}
		}
		thread function_88770699(spawnpoints);
	#/
}

/*
	Name: function_107f44c0
	Namespace: namespace_af53555a
	Checksum: 0x5510E93B
	Offset: 0x1190
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function function_107f44c0()
{
	/#
		level notify(#"hash_12bbc39c8f50f769");
	#/
}

/*
	Name: hidespawnpoints
	Namespace: namespace_af53555a
	Checksum: 0x4A2263B0
	Offset: 0x11B8
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function hidespawnpoints()
{
	/#
		level notify(#"hide_spawnpoints");
	#/
}

/*
	Name: showstartspawnpoints
	Namespace: namespace_af53555a
	Checksum: 0x1C31DEF4
	Offset: 0x11E8
	Size: 0x2C0
	Parameters: 0
	Flags: None
*/
function showstartspawnpoints()
{
	/#
		if(!isdefined(level.spawn_start))
		{
			return;
		}
		if(level.teambased)
		{
			team_colors = [];
			team_colors[#"axis"] = (1, 0, 1);
			team_colors[#"allies"] = (0, 1, 1);
			team_colors[#"team3"] = (1, 1, 0);
			team_colors[#"team4"] = (0, 1, 0);
			team_colors[#"team5"] = (0, 0, 1);
			team_colors[#"team6"] = (1, 0.5, 0);
			team_colors[#"team7"] = (1, 0.7529412, 0.7960784);
			team_colors[#"team8"] = (0.5450981, 0.2705882, 0.07450981);
			foreach(key, color in team_colors)
			{
				if(!isdefined(level.spawn_start[key]))
				{
					continue;
				}
				foreach(spawnpoint in level.spawn_start[key])
				{
					showonespawnpoint(spawnpoint, color, "");
				}
			}
		}
		else
		{
			color = (1, 0, 1);
			foreach(spawnpoint in level.spawn_start)
			{
				showonespawnpoint(spawnpoint, color, "");
			}
		}
	#/
}

/*
	Name: hidestartspawnpoints
	Namespace: namespace_af53555a
	Checksum: 0x6B33DB41
	Offset: 0x14B8
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function hidestartspawnpoints()
{
	/#
		level notify(#"hide_startspawnpoints");
	#/
}

/*
	Name: function_8beb6f7d
	Namespace: namespace_af53555a
	Checksum: 0x65759567
	Offset: 0x14E8
	Size: 0x544
	Parameters: 4
	Flags: None
*/
function function_8beb6f7d(spawn_point, color, height, var_379ac7cc)
{
	/#
		if(!isdefined(height) || height <= 0)
		{
			height = util::get_player_height();
		}
		if(!isdefined(var_379ac7cc))
		{
			if(level.convert_spawns_to_structs)
			{
				var_379ac7cc = spawn_point.targetname;
			}
			else
			{
				var_379ac7cc = spawn_point.classname;
			}
		}
		depthtest = 0;
		center = spawn_point.origin;
		forward = anglestoforward(spawn_point.angles);
		right = anglestoright(spawn_point.angles);
		forward = vectorscale(forward, 16);
		right = vectorscale(right, 16);
		a = center + forward - right;
		b = center + forward + right;
		c = center - forward + right;
		d = center - forward - right;
		line(a, b, color, 0, depthtest);
		line(b, c, color, 0, depthtest);
		line(c, d, color, 0, depthtest);
		line(d, a, color, 0, depthtest);
		line(a, a + (0, 0, height), color, 0, depthtest);
		line(b, b + (0, 0, height), color, 0, depthtest);
		line(c, c + (0, 0, height), color, 0, depthtest);
		line(d, d + (0, 0, height), color, 0, depthtest);
		a = a + (0, 0, height);
		b = b + (0, 0, height);
		c = c + (0, 0, height);
		d = d + (0, 0, height);
		line(a, b, color, 0, depthtest);
		line(b, c, color, 0, depthtest);
		line(c, d, color, 0, depthtest);
		line(d, a, color, 0, depthtest);
		center = center + (0, 0, height / 2);
		arrow_forward = anglestoforward(spawn_point.angles);
		arrowhead_forward = anglestoforward(spawn_point.angles);
		arrowhead_right = anglestoright(spawn_point.angles);
		arrow_forward = vectorscale(arrow_forward, 32);
		arrowhead_forward = vectorscale(arrowhead_forward, 24);
		arrowhead_right = vectorscale(arrowhead_right, 8);
		a = center + arrow_forward;
		b = center + arrowhead_forward - arrowhead_right;
		c = center + arrowhead_forward + arrowhead_right;
		line(center, a, color, 0, depthtest);
		line(a, b, color, 0, depthtest);
		line(a, c, color, 0, depthtest);
		if(isdefined(var_379ac7cc) && var_379ac7cc != "")
		{
			print3d(spawn_point.origin + (0, 0, height), var_379ac7cc, color, 1, 1);
		}
	#/
}

/*
	Name: showonespawnpoint
	Namespace: namespace_af53555a
	Checksum: 0xAC253BD1
	Offset: 0x1A38
	Size: 0x54C
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
			if(level.convert_spawns_to_structs)
			{
				print = spawn_point.targetname;
			}
			else
			{
				print = spawn_point.classname;
			}
		}
		center = spawn_point.origin;
		forward = anglestoforward(spawn_point.angles);
		right = anglestoright(spawn_point.angles);
		forward = vectorscale(forward, 16);
		right = vectorscale(right, 16);
		a = center + forward - right;
		b = center + forward + right;
		c = center - forward + right;
		d = center - forward - right;
		thread dev::lineuntilnotified(a, b, color, 0, notification);
		thread dev::lineuntilnotified(b, c, color, 0, notification);
		thread dev::lineuntilnotified(c, d, color, 0, notification);
		thread dev::lineuntilnotified(d, a, color, 0, notification);
		thread dev::lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
		thread dev::lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
		thread dev::lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
		thread dev::lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
		a = a + (0, 0, height);
		b = b + (0, 0, height);
		c = c + (0, 0, height);
		d = d + (0, 0, height);
		thread dev::lineuntilnotified(a, b, color, 0, notification);
		thread dev::lineuntilnotified(b, c, color, 0, notification);
		thread dev::lineuntilnotified(c, d, color, 0, notification);
		thread dev::lineuntilnotified(d, a, color, 0, notification);
		center = center + (0, 0, height / 2);
		arrow_forward = anglestoforward(spawn_point.angles);
		arrowhead_forward = anglestoforward(spawn_point.angles);
		arrowhead_right = anglestoright(spawn_point.angles);
		arrow_forward = vectorscale(arrow_forward, 32);
		arrowhead_forward = vectorscale(arrowhead_forward, 24);
		arrowhead_right = vectorscale(arrowhead_right, 8);
		a = center + arrow_forward;
		b = center + arrowhead_forward - arrowhead_right;
		c = center + arrowhead_forward + arrowhead_right;
		thread dev::lineuntilnotified(center, a, color, 0, notification);
		thread dev::lineuntilnotified(a, b, color, 0, notification);
		thread dev::lineuntilnotified(a, c, color, 0, notification);
		if(isdefined(print) && print != "")
		{
			thread dev::print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
		}
	#/
}

