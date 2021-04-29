// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace colors;

/*
	Name: function_89f2df9
	Namespace: colors
	Checksum: 0x781D9A18
	Offset: 0x170
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"colors", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: colors
	Checksum: 0x8EF4ED01
	Offset: 0x1C0
	Size: 0xC24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	nodes = getallnodes();
	level flag::init("player_looks_away_from_spawner");
	level flag::init("friendly_spawner_locked");
	level flag::init("respawn_friendlies");
	level.arrays_of_colorcoded_nodes = [];
	level.arrays_of_colorcoded_nodes[#"axis"] = [];
	level.arrays_of_colorcoded_nodes[#"allies"] = [];
	level.arrays_of_colorcoded_nodes[#"team3"] = [];
	level.colorcoded_volumes = [];
	level.colorcoded_volumes[#"axis"] = [];
	level.colorcoded_volumes[#"allies"] = [];
	level.colorcoded_volumes[#"team3"] = [];
	volumes = getentarray("info_volume", "classname");
	for(i = 0; i < nodes.size; i++)
	{
		if(isdefined(nodes[i].script_color_allies))
		{
			nodes[i] add_node_to_global_arrays(nodes[i].script_color_allies, #"allies");
		}
		if(isdefined(nodes[i].script_color_axis))
		{
			nodes[i] add_node_to_global_arrays(nodes[i].script_color_axis, #"axis");
		}
		if(isdefined(nodes[i].var_15eb6ad5))
		{
			nodes[i] add_node_to_global_arrays(nodes[i].var_15eb6ad5, #"team3");
		}
	}
	for(i = 0; i < volumes.size; i++)
	{
		if(isdefined(volumes[i].script_color_allies))
		{
			volumes[i] add_volume_to_global_arrays(volumes[i].script_color_allies, #"allies");
		}
		if(isdefined(volumes[i].script_color_axis))
		{
			volumes[i] add_volume_to_global_arrays(volumes[i].script_color_axis, #"axis");
		}
		if(isdefined(volumes[i].var_15eb6ad5))
		{
			volumes[i] add_volume_to_global_arrays(volumes[i].var_15eb6ad5, #"team3");
		}
	}
	/#
		level.colornodes_debug_array = [];
		level.colornodes_debug_array[#"allies"] = [];
		level.colornodes_debug_array[#"axis"] = [];
		level.colornodes_debug_array[#"team3"] = [];
	#/
	level.color_node_type_function = [];
	add_cover_node(#"hash_397b1509f632dd34");
	add_cover_node(#"hash_581529fff05853f0");
	add_cover_node(#"hash_6d8019ab9d39bf96");
	add_cover_node(#"hash_12feb47aa56f29ee");
	add_cover_node(#"hash_280d1247a6abdbae");
	add_cover_node(#"hash_2a7b1ca393696762");
	add_cover_node(#"hash_63cbb4767da2a801");
	add_cover_node(#"hash_22a0cbc4c551a678");
	add_cover_node(#"hash_4c95cba4aba377ad");
	add_cover_node(#"hash_7a0e62fbbe3989d4");
	add_cover_node(#"hash_1bb444d857814e92");
	add_cover_node(#"hash_171465527444ed14");
	add_cover_node(#"hash_15ababf467e5750c");
	add_cover_node(#"reacquire");
	add_cover_node(#"balcony");
	add_cover_node(#"scripted");
	add_cover_node(#"begin");
	add_cover_node(#"end");
	add_cover_node(#"turret");
	add_path_node(#"guard");
	add_path_node(#"exposed");
	add_path_node(#"path");
	level.colorlist = [];
	level.colorlist[level.colorlist.size] = "r";
	level.colorlist[level.colorlist.size] = "b";
	level.colorlist[level.colorlist.size] = "y";
	level.colorlist[level.colorlist.size] = "c";
	level.colorlist[level.colorlist.size] = "g";
	level.colorlist[level.colorlist.size] = "p";
	level.colorlist[level.colorlist.size] = "o";
	level.colorchecklist[#"red"] = "r";
	level.colorchecklist[#"r"] = "r";
	level.colorchecklist[#"blue"] = "b";
	level.colorchecklist[#"b"] = "b";
	level.colorchecklist[#"yellow"] = "y";
	level.colorchecklist[#"y"] = "y";
	level.colorchecklist[#"cyan"] = "c";
	level.colorchecklist[#"c"] = "c";
	level.colorchecklist[#"green"] = "g";
	level.colorchecklist[#"g"] = "g";
	level.colorchecklist[#"purple"] = "p";
	level.colorchecklist[#"p"] = "p";
	level.colorchecklist[#"orange"] = "o";
	level.colorchecklist[#"o"] = "o";
	level.currentcolorforced = [];
	level.currentcolorforced[#"allies"] = [];
	level.currentcolorforced[#"axis"] = [];
	level.currentcolorforced[#"team3"] = [];
	level.lastcolorforced = [];
	level.lastcolorforced[#"allies"] = [];
	level.lastcolorforced[#"axis"] = [];
	level.lastcolorforced[#"team3"] = [];
	for(i = 0; i < level.colorlist.size; i++)
	{
		level.arrays_of_colorforced_ai[#"allies"][level.colorlist[i]] = [];
		level.arrays_of_colorforced_ai[#"axis"][level.colorlist[i]] = [];
		level.arrays_of_colorforced_ai[#"team3"][level.colorlist[i]] = [];
		level.currentcolorforced[#"allies"][level.colorlist[i]] = undefined;
		level.currentcolorforced[#"axis"][level.colorlist[i]] = undefined;
		level.currentcolorforced[#"team3"][level.colorlist[i]] = undefined;
	}
	/#
		thread debugdvars();
		thread debugcolorfriendlies();
	#/
}

/*
	Name: __main__
	Namespace: colors
	Checksum: 0x1817C932
	Offset: 0xDF0
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	foreach(trig in trigger::get_all())
	{
		if(isdefined(trig.script_color_allies))
		{
			trig thread trigger_issues_orders(trig.script_color_allies, #"allies");
		}
		if(isdefined(trig.script_color_axis))
		{
			trig thread trigger_issues_orders(trig.script_color_axis, #"axis");
		}
		if(isdefined(trig.var_15eb6ad5))
		{
			trig thread trigger_issues_orders(trig.var_15eb6ad5, #"team3");
		}
	}
}

/*
	Name: debugdvars
	Namespace: colors
	Checksum: 0x481E0A19
	Offset: 0xF28
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function debugdvars()
{
	/#
		while(true)
		{
			if(getdvar(#"debug_colornodes", 0) > 0)
			{
				thread debug_colornodes();
			}
			waitframe(1);
		}
	#/
}

/*
	Name: get_team_substr
	Namespace: colors
	Checksum: 0x321B1083
	Offset: 0xF88
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function get_team_substr()
{
	/#
		if(self.team == #"allies")
		{
			if(!isdefined(self.node.script_color_allies_old))
			{
				return;
			}
			return self.node.script_color_allies_old;
		}
		if(self.team == #"axis")
		{
			if(!isdefined(self.node.script_color_axis_old))
			{
				return;
			}
			return self.node.script_color_axis_old;
		}
	#/
}

/*
	Name: try_to_draw_line_to_node
	Namespace: colors
	Checksum: 0xA1F8F9D6
	Offset: 0x1018
	Size: 0x11C
	Parameters: 0
	Flags: None
*/
function try_to_draw_line_to_node()
{
	/#
		if(!isdefined(self.node))
		{
			return;
		}
		if(!isdefined(self.script_forcecolor))
		{
			return;
		}
		substr = get_team_substr();
		if(!isdefined(substr))
		{
			return;
		}
		if(!issubstr(substr, self.script_forcecolor))
		{
			return;
		}
		recordline(self.origin + vectorscale((0, 0, 1), 25), self.node.origin, _get_debug_color(self.script_forcecolor), "", self);
		line(self.origin + vectorscale((0, 0, 1), 25), self.node.origin, _get_debug_color(self.script_forcecolor));
	#/
}

/*
	Name: _get_debug_color
	Namespace: colors
	Checksum: 0x8D8C889
	Offset: 0x1140
	Size: 0x1A2
	Parameters: 1
	Flags: None
*/
function _get_debug_color(str_color)
{
	/#
		switch(str_color)
		{
			case "red":
			case "r":
			{
				return (1, 0, 0);
				break;
			}
			case "green":
			case "g":
			{
				return (0, 1, 0);
				break;
			}
			case "b":
			case "blue":
			{
				return (0, 0, 1);
				break;
			}
			case "yellow":
			case "y":
			{
				return (1, 1, 0);
				break;
			}
			case "orange":
			case "o":
			{
				return (1, 0.5, 0);
				break;
			}
			case "c":
			case "cyan":
			{
				return (0, 1, 1);
				break;
			}
			case "purple":
			case "p":
			{
				return (1, 0, 1);
				break;
			}
			default:
			{
				println("" + str_color + "");
				return (0, 0, 0);
				break;
			}
		}
	#/
}

/*
	Name: debug_colornodes
	Namespace: colors
	Checksum: 0x32D32850
	Offset: 0x12F0
	Size: 0x2B4
	Parameters: 0
	Flags: None
*/
function debug_colornodes()
{
	/#
		array = [];
		array[#"axis"] = [];
		array[#"allies"] = [];
		array[#"team3"] = [];
		aiarray = arraycombine(getplayers(), getaiarray(), 0, 0);
		foreach(ai in aiarray)
		{
			if(!isdefined(ai.currentcolorcode) || (!isai(ai) && !isbot(ai)) || !isdefined(array[ai.team]))
			{
				continue;
			}
			array[ai.team][ai.currentcolorcode] = 1;
			color = (1, 1, 1);
			if(isdefined(ai.script_forcecolor))
			{
				color = _get_debug_color(ai.script_forcecolor);
			}
			recordenttext(ai.currentcolorcode, ai, color, "");
			print3d(ai.origin + vectorscale((0, 0, 1), 25), ai.currentcolorcode, color, 1, 0.7);
			ai try_to_draw_line_to_node();
		}
		draw_colornodes(array, #"allies");
		draw_colornodes(array, #"axis");
		draw_colornodes(array, #"team3");
	#/
}

/*
	Name: draw_colornodes
	Namespace: colors
	Checksum: 0xDCDD1917
	Offset: 0x15B0
	Size: 0x2EA
	Parameters: 2
	Flags: None
*/
function draw_colornodes(array, team)
{
	/#
		foreach(k, v in array[team])
		{
			color = _get_debug_color(function_9e72a96(k)[0]);
			if(isdefined(level.colornodes_debug_array[team][k]))
			{
				a_team_nodes = level.colornodes_debug_array[team][k];
				for(p = 0; p < a_team_nodes.size; p++)
				{
					print3d(a_team_nodes[p].origin, "" + function_9e72a96(k), color, 1, 0.7);
					if(getdvar(#"debug_colornodes", 0) == 2 && isdefined(a_team_nodes[p].script_color_allies_old))
					{
						if(isdefined(a_team_nodes[p].color_user) && isalive(a_team_nodes[p].color_user) && isdefined(a_team_nodes[p].color_user.script_forcecolor))
						{
							print3d(a_team_nodes[p].origin + vectorscale((0, 0, -1), 5), "" + a_team_nodes[p].script_color_allies_old, _get_debug_color(a_team_nodes[p].color_user.script_forcecolor), 0.5, 0.4);
							continue;
						}
						print3d(a_team_nodes[p].origin + vectorscale((0, 0, -1), 5), "" + a_team_nodes[p].script_color_allies_old, color, 0.5, 0.4);
					}
				}
			}
		}
	#/
}

/*
	Name: debugcolorfriendlies
	Namespace: colors
	Checksum: 0x1416E6D9
	Offset: 0x18A8
	Size: 0x68
	Parameters: 0
	Flags: None
*/
function debugcolorfriendlies()
{
	/#
		level.debug_color_friendlies = [];
		level.debug_color_huds = [];
		level thread debugcolorfriendliestogglewatch();
		for(;;)
		{
			level waittill(#"updated_color_friendlies");
			draw_color_friendlies();
		}
	#/
}

/*
	Name: debugcolorfriendliestogglewatch
	Namespace: colors
	Checksum: 0x9A40F4CA
	Offset: 0x1918
	Size: 0xE8
	Parameters: 0
	Flags: None
*/
function debugcolorfriendliestogglewatch()
{
	/#
		just_turned_on = 0;
		while(true)
		{
			if(getdvar(#"debug_colornodes", 0) == 1 && !just_turned_on)
			{
				just_turned_on = 1;
				just_turned_off = 0;
				draw_color_friendlies();
			}
			if(getdvar(#"debug_colornodes", 0) != 1 && !just_turned_off)
			{
				just_turned_off = 1;
				just_turned_on = 0;
				draw_color_friendlies();
			}
			wait(0.25);
		}
	#/
}

/*
	Name: get_script_palette
	Namespace: colors
	Checksum: 0x2D3C4447
	Offset: 0x1A08
	Size: 0xD6
	Parameters: 0
	Flags: None
*/
function get_script_palette()
{
	/#
		rgb = [];
		rgb[#"r"] = (1, 0, 0);
		rgb[#"o"] = (1, 0.5, 0);
		rgb[#"y"] = (1, 1, 0);
		rgb[#"g"] = (0, 1, 0);
		rgb[#"c"] = (0, 1, 1);
		rgb[#"b"] = (0, 0, 1);
		rgb[#"p"] = (1, 0, 1);
		return rgb;
	#/
}

/*
	Name: draw_color_friendlies
	Namespace: colors
	Checksum: 0x9EC756DE
	Offset: 0x1AE8
	Size: 0x37C
	Parameters: 0
	Flags: None
*/
function draw_color_friendlies()
{
	/#
		level endon(#"updated_color_friendlies");
		colored_friendlies = [];
		colors = [];
		colors[colors.size] = "";
		colors[colors.size] = "";
		colors[colors.size] = "";
		colors[colors.size] = "";
		colors[colors.size] = "";
		colors[colors.size] = "";
		colors[colors.size] = "";
		rgb = get_script_palette();
		for(i = 0; i < colors.size; i++)
		{
			colored_friendlies[colors[i]] = 0;
		}
		foreach(color in level.debug_color_friendlies)
		{
			colored_friendlies[color]++;
		}
		for(i = 0; i < level.debug_color_huds.size; i++)
		{
			level.debug_color_huds[i] destroy();
		}
		level.debug_color_huds = [];
		if(getdvar(#"debug_colornodes", 0) != 1)
		{
			return;
		}
		y = 365;
		for(i = 0; i < colors.size; i++)
		{
			if(colored_friendlies[colors[i]] <= 0)
			{
				continue;
			}
			for(p = 0; p < colored_friendlies[colors[i]]; p++)
			{
				overlay = newdebughudelem();
				overlay.x = 15 + 25 * p;
				overlay.y = y;
				overlay setshader(#"white", 16, 16);
				overlay.alignx = "";
				overlay.aligny = "";
				overlay.alpha = 1;
				overlay.color = rgb[colors[i]];
				level.debug_color_huds[level.debug_color_huds.size] = overlay;
			}
			y = y + 25;
		}
	#/
}

/*
	Name: player_init_color_grouping
	Namespace: colors
	Checksum: 0x26741885
	Offset: 0x1E70
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function player_init_color_grouping()
{
	thread player_color_node();
}

/*
	Name: convert_color_to_short_string
	Namespace: colors
	Checksum: 0x620C581E
	Offset: 0x1E90
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function convert_color_to_short_string()
{
	self.script_forcecolor = level.colorchecklist[self.script_forcecolor];
}

/*
	Name: goto_current_colorindex
	Namespace: colors
	Checksum: 0xD29C6C97
	Offset: 0x1EB8
	Size: 0x21C
	Parameters: 0
	Flags: Linked
*/
function goto_current_colorindex()
{
	if(!isdefined(self.currentcolorcode))
	{
		return;
	}
	nodes = level.arrays_of_colorcoded_nodes[self.team][self.currentcolorcode];
	if(!isdefined(nodes))
	{
		nodes = [];
	}
	else if(!isarray(nodes))
	{
		nodes = array(nodes);
	}
	nodes[nodes.size] = level.colorcoded_volumes[self.team][self.currentcolorcode];
	self left_color_node();
	if(!isalive(self))
	{
		return;
	}
	if(!has_color())
	{
		return;
	}
	for(i = 0; i < nodes.size; i++)
	{
		node = nodes[i];
		if(isalive(node.color_user) && !isplayer(node.color_user))
		{
			continue;
		}
		self thread ai_sets_goal_with_delay(node);
		thread decrementcolorusers(node);
		return;
	}
	/#
		if(isbot(self))
		{
			println("" + self.name + "");
		}
		else
		{
			println("" + self.export + "");
		}
	#/
}

/*
	Name: get_color_list
	Namespace: colors
	Checksum: 0x84C16676
	Offset: 0x20E0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function get_color_list()
{
	colorlist = [];
	colorlist[colorlist.size] = "r";
	colorlist[colorlist.size] = "b";
	colorlist[colorlist.size] = "y";
	colorlist[colorlist.size] = "c";
	colorlist[colorlist.size] = "g";
	colorlist[colorlist.size] = "p";
	colorlist[colorlist.size] = "o";
	return colorlist;
}

/*
	Name: get_colorcodes_from_trigger
	Namespace: colors
	Checksum: 0xF5A63FF7
	Offset: 0x2190
	Size: 0x256
	Parameters: 2
	Flags: Linked
*/
function get_colorcodes_from_trigger(color_team, team)
{
	colorcodes = strtok(color_team, " ");
	colors = [];
	colorcodesbycolorindex = [];
	usable_colorcodes = [];
	colorlist = get_color_list();
	for(i = 0; i < colorcodes.size; i++)
	{
		color = undefined;
		for(p = 0; p < colorlist.size; p++)
		{
			if(issubstr(colorcodes[i], colorlist[p]))
			{
				color = colorlist[p];
				break;
			}
		}
		if(!isdefined(level.arrays_of_colorcoded_nodes[team][colorcodes[i]]) && !isdefined(level.colorcoded_volumes[team][colorcodes[i]]))
		{
			continue;
		}
		/#
			assert(isdefined(color), "" + self getorigin() + "" + colorcodes[i]);
		#/
		colorcodesbycolorindex[color] = colorcodes[i];
		colors[colors.size] = color;
		usable_colorcodes[usable_colorcodes.size] = colorcodes[i];
	}
	colorcodes = usable_colorcodes;
	array = [];
	array[#"colorcodes"] = colorcodes;
	array[#"colorcodesbycolorindex"] = colorcodesbycolorindex;
	array[#"colors"] = colors;
	return array;
}

/*
	Name: trigger_issues_orders
	Namespace: colors
	Checksum: 0x254A20DB
	Offset: 0x23F0
	Size: 0x140
	Parameters: 2
	Flags: Linked
*/
function trigger_issues_orders(color_team, team)
{
	self endon(#"death");
	array = get_colorcodes_from_trigger(color_team, team);
	colorcodes = array[#"colorcodes"];
	colorcodesbycolorindex = array[#"colorcodesbycolorindex"];
	colors = array[#"colors"];
	for(;;)
	{
		self waittill(#"trigger");
		if(isdefined(self.activated_color_trigger))
		{
			self.activated_color_trigger = undefined;
			continue;
		}
		if(!isdefined(self.color_enabled) || (isdefined(self.color_enabled) && self.color_enabled))
		{
			activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);
		}
		trigger_auto_disable();
	}
}

/*
	Name: trigger_auto_disable
	Namespace: colors
	Checksum: 0xDC5C0A9D
	Offset: 0x2538
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function trigger_auto_disable()
{
	if(!isdefined(self.script_color_stay_on))
	{
		self.script_color_stay_on = 0;
	}
	if(!isdefined(self.color_enabled))
	{
		if(isdefined(self.script_color_stay_on) && self.script_color_stay_on)
		{
			self.color_enabled = 1;
		}
		else
		{
			self.color_enabled = 0;
		}
	}
}

/*
	Name: %ai_crouch_exposed_turn_135l
	Namespace: colors
	Checksum: 0x5BF8D9AD
	Offset: 0x25A0
	Size: 0xB4
	Parameters: 1
	Flags: None
*/
function %ai_crouch_exposed_turn_135l(var_cc966c56)
{
	switch(var_cc966c56)
	{
		case "allies":
		{
			str_color = self.script_color_allies;
			break;
		}
		case "axis":
		{
			str_color = self.script_color_axis;
			break;
		}
		case "team3":
		{
			str_color = self.var_15eb6ad5;
			break;
		}
		default:
		{
			return;
		}
	}
	self thread get_colorcodes_and_activate_trigger(str_color, var_cc966c56);
}

/*
	Name: get_colorcodes_and_activate_trigger
	Namespace: colors
	Checksum: 0x8D4A6089
	Offset: 0x2660
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function get_colorcodes_and_activate_trigger(color_team, team)
{
	array = get_colorcodes_from_trigger(color_team, team);
	colorcodes = array[#"colorcodes"];
	colorcodesbycolorindex = array[#"colorcodesbycolorindex"];
	colors = array[#"colors"];
	activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);
}

/*
	Name: activate_color_trigger_internal
	Namespace: colors
	Checksum: 0xE3C74D17
	Offset: 0x2720
	Size: 0x3E6
	Parameters: 4
	Flags: Linked
*/
function activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex)
{
	for(i = 0; i < colorcodes.size; i++)
	{
		if(!isdefined(level.arrays_of_colorcoded_spawners[team][colorcodes[i]]))
		{
			continue;
		}
		arrayremovevalue(level.arrays_of_colorcoded_spawners[team][colorcodes[i]], undefined);
		for(p = 0; p < level.arrays_of_colorcoded_spawners[team][colorcodes[i]].size; p++)
		{
			level.arrays_of_colorcoded_spawners[team][colorcodes[i]][p].currentcolorcode = colorcodes[i];
		}
	}
	for(i = 0; i < colors.size; i++)
	{
		level.arrays_of_colorforced_ai[team][colors[i]] = array::remove_dead(level.arrays_of_colorforced_ai[team][colors[i]]);
		level.lastcolorforced[team][colors[i]] = level.currentcolorforced[team][colors[i]];
		level.currentcolorforced[team][colors[i]] = colorcodesbycolorindex[colors[i]];
		/#
			/#
				assert(isdefined(level.arrays_of_colorcoded_nodes[team][level.currentcolorforced[team][colors[i]]]) || isdefined(level.colorcoded_volumes[team][level.currentcolorforced[team][colors[i]]]), "" + colors[i] + "" + team + "");
			#/
		#/
	}
	ai_array = [];
	for(i = 0; i < colorcodes.size; i++)
	{
		if(same_color_code_as_last_time(team, colors[i]))
		{
			continue;
		}
		colorcode = colorcodes[i];
		if(!isdefined(level.arrays_of_colorcoded_ai[team][colorcode]))
		{
			continue;
		}
		ai_array[colorcode] = issue_leave_node_order_to_ai_and_get_ai(colorcode, colors[i], team);
	}
	for(i = 0; i < colorcodes.size; i++)
	{
		colorcode = colorcodes[i];
		if(!isdefined(ai_array[colorcode]))
		{
			continue;
		}
		if(same_color_code_as_last_time(team, colors[i]))
		{
			continue;
		}
		if(!isdefined(level.arrays_of_colorcoded_ai[team][colorcode]))
		{
			continue;
		}
		issue_color_order_to_ai(colorcode, colors[i], team, ai_array[colorcode]);
	}
}

/*
	Name: same_color_code_as_last_time
	Namespace: colors
	Checksum: 0x7190E438
	Offset: 0x2B10
	Size: 0x60
	Parameters: 2
	Flags: Linked
*/
function same_color_code_as_last_time(team, color)
{
	if(!isdefined(level.lastcolorforced[team][color]))
	{
		return 0;
	}
	return level.lastcolorforced[team][color] == level.currentcolorforced[team][color];
}

/*
	Name: function_f06ea88
	Namespace: colors
	Checksum: 0xB0BCA9
	Offset: 0x2B78
	Size: 0x10A
	Parameters: 3
	Flags: Linked
*/
function function_f06ea88(node, var_f9350db6, var_cc966c56)
{
	switch(var_cc966c56)
	{
		case "allies":
		{
			str_color = node.script_color_allies;
			break;
		}
		case "axis":
		{
			str_color = node.script_color_axis;
			break;
		}
		case "team3":
		{
			str_color = node.var_15eb6ad5;
			break;
		}
		default:
		{
			return;
		}
	}
	if(issubstr(str_color, var_f9350db6))
	{
		self.cover_nodes_last[self.cover_nodes_last.size] = node;
	}
	else
	{
		self.cover_nodes_first[self.cover_nodes_first.size] = node;
	}
}

/*
	Name: process_cover_node
	Namespace: colors
	Checksum: 0x1E0DC34B
	Offset: 0x2C90
	Size: 0x36
	Parameters: 3
	Flags: Linked
*/
function process_cover_node(node, var_f9350db6, var_cc966c56)
{
	self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

/*
	Name: process_path_node
	Namespace: colors
	Checksum: 0xFE203184
	Offset: 0x2CD0
	Size: 0x36
	Parameters: 3
	Flags: Linked
*/
function process_path_node(node, var_f9350db6, var_cc966c56)
{
	self.path_nodes[self.path_nodes.size] = node;
}

/*
	Name: prioritize_colorcoded_nodes
	Namespace: colors
	Checksum: 0xC280F72F
	Offset: 0x2D10
	Size: 0x1F8
	Parameters: 3
	Flags: Linked
*/
function prioritize_colorcoded_nodes(team, colorcode, color)
{
	nodes = level.arrays_of_colorcoded_nodes[team][colorcode];
	ent = spawnstruct();
	ent.path_nodes = [];
	ent.cover_nodes_first = [];
	ent.cover_nodes_last = [];
	lastcolorforced_exists = isdefined(level.lastcolorforced[team][color]);
	for(i = 0; i < nodes.size; i++)
	{
		node = nodes[i];
		ent [[level.color_node_type_function[node.type][lastcolorforced_exists]]](node, level.lastcolorforced[team][color], team);
	}
	ent.cover_nodes_first = array::randomize(ent.cover_nodes_first);
	nodes = ent.cover_nodes_first;
	for(i = 0; i < ent.cover_nodes_last.size; i++)
	{
		nodes[nodes.size] = ent.cover_nodes_last[i];
	}
	for(i = 0; i < ent.path_nodes.size; i++)
	{
		nodes[nodes.size] = ent.path_nodes[i];
	}
	level.arrays_of_colorcoded_nodes[team][colorcode] = nodes;
}

/*
	Name: get_prioritized_colorcoded_nodes
	Namespace: colors
	Checksum: 0x48BF7597
	Offset: 0x2F10
	Size: 0x84
	Parameters: 3
	Flags: Linked
*/
function get_prioritized_colorcoded_nodes(team, colorcode, color)
{
	if(isdefined(level.arrays_of_colorcoded_nodes[team][colorcode]))
	{
		return level.arrays_of_colorcoded_nodes[team][colorcode];
	}
	if(isdefined(level.colorcoded_volumes[team][colorcode]))
	{
		return level.colorcoded_volumes[team][colorcode];
	}
}

/*
	Name: issue_leave_node_order_to_ai_and_get_ai
	Namespace: colors
	Checksum: 0x73CA4194
	Offset: 0x2FA0
	Size: 0x182
	Parameters: 3
	Flags: Linked
*/
function issue_leave_node_order_to_ai_and_get_ai(colorcode, color, team)
{
	level.arrays_of_colorcoded_ai[team][colorcode] = array::remove_dead(level.arrays_of_colorcoded_ai[team][colorcode]);
	ai = level.arrays_of_colorcoded_ai[team][colorcode];
	ai = arraycombine(ai, level.arrays_of_colorforced_ai[team][color], 1, 0);
	newarray = [];
	for(i = 0; i < ai.size; i++)
	{
		if(isdefined(ai[i].currentcolorcode) && ai[i].currentcolorcode == colorcode)
		{
			continue;
		}
		newarray[newarray.size] = ai[i];
	}
	ai = newarray;
	if(!ai.size)
	{
		return;
	}
	for(i = 0; i < ai.size; i++)
	{
		ai[i] left_color_node();
	}
	return ai;
}

/*
	Name: issue_color_order_to_ai
	Namespace: colors
	Checksum: 0xFAF8EF76
	Offset: 0x3130
	Size: 0x218
	Parameters: 4
	Flags: Linked
*/
function issue_color_order_to_ai(colorcode, color, team, ai)
{
	original_ai_array = ai;
	prioritize_colorcoded_nodes(team, colorcode, color);
	nodes = get_prioritized_colorcoded_nodes(team, colorcode, color);
	/#
		level.colornodes_debug_array[team][colorcode] = nodes;
		if(nodes.size < ai.size)
		{
			println("" + ai.size + "" + nodes.size + "");
		}
	#/
	counter = 0;
	ai_count = ai.size;
	for(i = 0; i < nodes.size; i++)
	{
		node = nodes[i];
		if(isalive(node.color_user))
		{
			continue;
		}
		closestai = arraysort(ai, node.origin, 1, 1)[0];
		/#
			assert(isalive(closestai));
		#/
		arrayremovevalue(ai, closestai);
		closestai take_color_node(node, colorcode, self, counter);
		counter++;
		if(!ai.size)
		{
			return;
		}
	}
}

/*
	Name: take_color_node
	Namespace: colors
	Checksum: 0x6687B6B5
	Offset: 0x3350
	Size: 0x64
	Parameters: 4
	Flags: Linked
*/
function take_color_node(node, colorcode, trigger, counter)
{
	self notify(#"stop_color_move");
	self.currentcolorcode = colorcode;
	self thread process_color_order_to_ai(node, trigger, counter);
}

/*
	Name: player_color_node
	Namespace: colors
	Checksum: 0xE07EC379
	Offset: 0x33C0
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function player_color_node()
{
	for(;;)
	{
		playernode = undefined;
		if(!isdefined(self.node))
		{
			waitframe(1);
			continue;
		}
		olduser = self.node.color_user;
		playernode = self.node;
		playernode.color_user = self;
		for(;;)
		{
			if(!isdefined(self.node))
			{
				break;
			}
			if(self.node != playernode)
			{
				break;
			}
			waitframe(1);
		}
		playernode.color_user = undefined;
		playernode color_node_finds_a_user();
	}
}

/*
	Name: color_node_finds_a_user
	Namespace: colors
	Checksum: 0xF35AAB0B
	Offset: 0x3478
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function color_node_finds_a_user()
{
	if(isdefined(self.script_color_allies))
	{
		color_node_finds_user_from_colorcodes(self.script_color_allies, #"allies");
	}
	if(isdefined(self.script_color_axis))
	{
		color_node_finds_user_from_colorcodes(self.script_color_axis, #"axis");
	}
	if(isdefined(self.var_15eb6ad5))
	{
		color_node_finds_user_from_colorcodes(self.var_15eb6ad5, #"team3");
	}
}

/*
	Name: color_node_finds_user_from_colorcodes
	Namespace: colors
	Checksum: 0xE94FE993
	Offset: 0x3530
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function color_node_finds_user_from_colorcodes(colorcodestring, team)
{
	if(isdefined(self.color_user))
	{
		return;
	}
	colorcodes = strtok(colorcodestring, " ");
	array::thread_all_ents(colorcodes, &color_node_finds_user_for_colorcode, team);
}

/*
	Name: color_node_finds_user_for_colorcode
	Namespace: colors
	Checksum: 0x8098ABC4
	Offset: 0x35A8
	Size: 0x150
	Parameters: 2
	Flags: Linked
*/
function color_node_finds_user_for_colorcode(colorcode, team)
{
	color = colorcode[0];
	/#
		assert(colorislegit(color), "" + color + "");
	#/
	if(!isdefined(level.currentcolorforced[team][color]))
	{
		return;
	}
	if(level.currentcolorforced[team][color] != colorcode)
	{
		return;
	}
	ai = get_force_color_guys(team, color);
	if(!ai.size)
	{
		return;
	}
	for(i = 0; i < ai.size; i++)
	{
		guy = ai[i];
		if(guy occupies_colorcode(colorcode))
		{
			continue;
		}
		guy take_color_node(self, colorcode);
		return;
	}
}

/*
	Name: occupies_colorcode
	Namespace: colors
	Checksum: 0x80EF4A9F
	Offset: 0x3700
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function occupies_colorcode(colorcode)
{
	if(!isdefined(self.currentcolorcode))
	{
		return 0;
	}
	return self.currentcolorcode == colorcode;
}

/*
	Name: ai_sets_goal_with_delay
	Namespace: colors
	Checksum: 0xFEC3E2D5
	Offset: 0x3730
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function ai_sets_goal_with_delay(node)
{
	self endon(#"death");
	delay = my_current_node_delays();
	if(delay)
	{
		wait(delay);
	}
	ai_sets_goal(node);
}

/*
	Name: ai_sets_goal
	Namespace: colors
	Checksum: 0x3B4F6BEE
	Offset: 0x37A0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function ai_sets_goal(node)
{
	self notify(#"stop_going_to_node");
	set_goal_and_volume(node);
}

/*
	Name: set_goal_and_volume
	Namespace: colors
	Checksum: 0x49191E01
	Offset: 0x37E0
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function set_goal_and_volume(node)
{
	if(isdefined(self._colors_go_line))
	{
		self notify(#"colors_go_line_done");
		self._colors_go_line = undefined;
	}
	if(isdefined(node.radius) && node.radius)
	{
		self.goalradius = node.radius;
	}
	if(isdefined(node.script_forcegoal) && node.script_forcegoal)
	{
		self thread color_force_goal(node);
	}
	else
	{
		self setgoal(node);
	}
	volume = level.colorcoded_volumes[self.team][self.currentcolorcode];
	if(isdefined(volume))
	{
		self setgoal(volume);
	}
}

/*
	Name: color_force_goal
	Namespace: colors
	Checksum: 0xA3D3FEC4
	Offset: 0x38F0
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function color_force_goal(node)
{
	self endon(#"death");
	self thread ai::force_goal(node, 1, "stop_color_forcegoal", 1);
	self waittill(#"goal", #"stop_color_move");
	self notify(#"stop_color_forcegoal");
}

/*
	Name: my_current_node_delays
	Namespace: colors
	Checksum: 0xB5EFEB34
	Offset: 0x3980
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function my_current_node_delays()
{
	if(!isdefined(self.node))
	{
		return 0;
	}
	return self.node util::script_delay();
}

/*
	Name: process_color_order_to_ai
	Namespace: colors
	Checksum: 0x5E066BF9
	Offset: 0x39B8
	Size: 0x218
	Parameters: 3
	Flags: Linked
*/
function process_color_order_to_ai(node, trigger, counter)
{
	thread decrementcolorusers(node);
	self endon(#"stop_color_move", #"death");
	if(isdefined(trigger))
	{
		trigger util::script_delay();
	}
	if(isdefined(trigger))
	{
		if(isdefined(trigger.script_flag_wait))
		{
			level flag::wait_till(trigger.script_flag_wait);
		}
	}
	if(!my_current_node_delays())
	{
		if(isdefined(counter))
		{
			wait(counter * randomfloatrange(0.2, 0.35));
		}
	}
	self ai_sets_goal(node);
	self.color_ordered_node_assignment = node;
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"node_taken");
		if(waitresult.taker == self)
		{
			waitframe(1);
		}
		node = get_best_available_new_colored_node();
		if(isdefined(node))
		{
			/#
				assert(!isalive(node.color_user), "");
			#/
			if(isalive(self.color_node.color_user) && self.color_node.color_user == self)
			{
				self.color_node.color_user = undefined;
			}
			self.color_node = node;
			node.color_user = self;
			self ai_sets_goal(node);
		}
	}
}

/*
	Name: get_best_available_colored_node
	Namespace: colors
	Checksum: 0x2279DCDC
	Offset: 0x3BD8
	Size: 0x15C
	Parameters: 0
	Flags: None
*/
function get_best_available_colored_node()
{
	/#
		assert(self.team != #"neutral");
	#/
	/#
		assert(isdefined(self.script_forcecolor), "" + self.export + "");
	#/
	colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
	nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
	/#
		assert(nodes.size > 0, "" + self.export + "" + self.script_forcecolor + "");
	#/
	for(i = 0; i < nodes.size; i++)
	{
		if(!isalive(nodes[i].color_user))
		{
			return nodes[i];
		}
	}
}

/*
	Name: get_best_available_new_colored_node
	Namespace: colors
	Checksum: 0xD87E02D2
	Offset: 0x3D40
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function get_best_available_new_colored_node()
{
	/#
		assert(self.team != #"neutral");
	#/
	/#
		assert(isdefined(self.script_forcecolor), "" + self.export + "");
	#/
	colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
	nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
	/#
		assert(nodes.size > 0, "" + self.export + "" + self.script_forcecolor + "");
	#/
	nodes = arraysort(nodes, self.origin);
	for(i = 0; i < nodes.size; i++)
	{
		if(!isalive(nodes[i].color_user))
		{
			return nodes[i];
		}
	}
}

/*
	Name: process_stop_short_of_node
	Namespace: colors
	Checksum: 0x18AA53F9
	Offset: 0x3EC8
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function process_stop_short_of_node(node)
{
	self endon(#"stopscript", #"death");
	if(isdefined(self.node))
	{
		return;
	}
	if(distancesquared(node.origin, self.origin) < 1024)
	{
		reached_node_but_could_not_claim_it(node);
		return;
	}
	currenttime = gettime();
	wait_for_killanimscript_or_time(1);
	newtime = gettime();
	if(newtime - currenttime >= 1000)
	{
		reached_node_but_could_not_claim_it(node);
	}
}

/*
	Name: wait_for_killanimscript_or_time
	Namespace: colors
	Checksum: 0x5D750AAC
	Offset: 0x3FB0
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function wait_for_killanimscript_or_time(timer)
{
	self endon(#"killanimscript");
	wait(timer);
}

/*
	Name: reached_node_but_could_not_claim_it
	Namespace: colors
	Checksum: 0x5F6CD66A
	Offset: 0x3FE0
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function reached_node_but_could_not_claim_it(node)
{
	ai = getaiarray();
	for(i = 0; i < ai.size; i++)
	{
		if(!isdefined(ai[i].node))
		{
			continue;
		}
		if(ai[i].node != node)
		{
			continue;
		}
		ai[i] notify(#"eject_from_my_node");
		wait(1);
		self notify(#"eject_from_my_node");
		return 1;
	}
	return 0;
}

/*
	Name: decrementcolorusers
	Namespace: colors
	Checksum: 0xA19E9E2E
	Offset: 0x40A8
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function decrementcolorusers(node)
{
	node.color_user = self;
	self.color_node = node;
	/#
		self.color_node_debug_val = 1;
	#/
	self endon(#"stop_color_move");
	self waittill(#"death");
	self.color_node.color_user = undefined;
}

/*
	Name: colorislegit
	Namespace: colors
	Checksum: 0xA0A43AFF
	Offset: 0x4120
	Size: 0x58
	Parameters: 1
	Flags: None
*/
function colorislegit(color)
{
	for(i = 0; i < level.colorlist.size; i++)
	{
		if(color == level.colorlist[i])
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: add_volume_to_global_arrays
	Namespace: colors
	Checksum: 0xD6F8F095
	Offset: 0x4180
	Size: 0xCE
	Parameters: 2
	Flags: Linked
*/
function add_volume_to_global_arrays(colorcode, team)
{
	colors = strtok(colorcode, " ");
	for(p = 0; p < colors.size; p++)
	{
		/#
			assert(!isdefined(level.colorcoded_volumes[team][colors[p]]), "" + colors[p]);
		#/
		level.colorcoded_volumes[team][colors[p]] = self;
	}
}

/*
	Name: add_node_to_global_arrays
	Namespace: colors
	Checksum: 0x64BFC7A9
	Offset: 0x4258
	Size: 0x20E
	Parameters: 2
	Flags: Linked
*/
function add_node_to_global_arrays(colorcode, team)
{
	self.color_user = undefined;
	colors = strtok(colorcode, " ");
	for(p = 0; p < colors.size; p++)
	{
		if(isdefined(level.arrays_of_colorcoded_nodes[team]) && isdefined(level.arrays_of_colorcoded_nodes[team][colors[p]]))
		{
			if(!isdefined(level.arrays_of_colorcoded_nodes[team][colors[p]]))
			{
				level.arrays_of_colorcoded_nodes[team][colors[p]] = [];
			}
			else if(!isarray(level.arrays_of_colorcoded_nodes[team][colors[p]]))
			{
				level.arrays_of_colorcoded_nodes[team][colors[p]] = array(level.arrays_of_colorcoded_nodes[team][colors[p]]);
			}
			level.arrays_of_colorcoded_nodes[team][colors[p]][level.arrays_of_colorcoded_nodes[team][colors[p]].size] = self;
			continue;
		}
		level.arrays_of_colorcoded_nodes[team][colors[p]][0] = self;
		level.arrays_of_colorcoded_ai[team][colors[p]] = [];
		level.arrays_of_colorcoded_spawners[team][colors[p]] = [];
	}
}

/*
	Name: left_color_node
	Namespace: colors
	Checksum: 0x1014D6B4
	Offset: 0x4470
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function left_color_node()
{
	/#
		self.color_node_debug_val = undefined;
	#/
	if(!isdefined(self.color_node))
	{
		return;
	}
	if(isdefined(self.color_node.color_user) && self.color_node.color_user == self)
	{
		self.color_node.color_user = undefined;
	}
	self.color_node = undefined;
	self notify(#"stop_color_move");
}

/*
	Name: removespawnerfromcolornumberarray
	Namespace: colors
	Checksum: 0xE8845574
	Offset: 0x44F0
	Size: 0x11E
	Parameters: 0
	Flags: None
*/
function removespawnerfromcolornumberarray()
{
	switch(self.team)
	{
		case "allies":
		{
			str_color = self.script_color_allies;
			break;
		}
		case "axis":
		{
			str_color = self.script_color_axis;
			break;
		}
		case "team3":
		{
			str_color = self.var_15eb6ad5;
			break;
		}
		default:
		{
			return;
		}
	}
	if(!isdefined(str_color))
	{
		return;
	}
	var_9986d9d6 = strtok(str_color, " ");
	for(i = 0; i < var_9986d9d6.size; i++)
	{
		arrayremovevalue(level.arrays_of_colorcoded_spawners[self.team][var_9986d9d6[i]], self);
	}
}

/*
	Name: add_cover_node
	Namespace: colors
	Checksum: 0xB96B7221
	Offset: 0x4618
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function add_cover_node(type)
{
	level.color_node_type_function[type][1] = &function_f06ea88;
	level.color_node_type_function[type][0] = &process_cover_node;
}

/*
	Name: add_path_node
	Namespace: colors
	Checksum: 0xBCA0BF8B
	Offset: 0x4678
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function add_path_node(type)
{
	level.color_node_type_function[type][1] = &process_path_node;
	level.color_node_type_function[type][0] = &process_path_node;
}

/*
	Name: colornode_spawn_reinforcement
	Namespace: colors
	Checksum: 0x8098BEA5
	Offset: 0x46D8
	Size: 0x318
	Parameters: 2
	Flags: Linked
*/
function colornode_spawn_reinforcement(classname, fromcolor)
{
	level endon(#"kill_color_replacements");
	while(level.friendly_spawners_types[friendly_spawners_type] > 0)
	{
		spawn = undefined;
		for(;;)
		{
			if(!level flag::get("respawn_friendlies"))
			{
				if(!isdefined(level.friendly_respawn_vision_checker_thread))
				{
					thread friendly_spawner_vision_checker();
				}
				for(;;)
				{
					level flag::wait_till_any(array("player_looks_away_from_spawner", "respawn_friendlies"));
					level flag::wait_till_clear("friendly_spawner_locked");
					if(level flag::get("player_looks_away_from_spawner") || level flag::get("respawn_friendlies"))
					{
						break;
					}
				}
				level flag::set("friendly_spawner_locked");
			}
			spawner = get_color_spawner(classname, fromcolor);
			spawner.count = 1;
			level.friendly_spawners_types[friendly_spawners_type] = level.friendly_spawners_types[friendly_spawners_type] - 1;
			spawner util::script_wait();
			spawn = spawner spawner::spawn();
			if(spawner::spawn_failed(spawn))
			{
				thread lock_spawner_for_awhile();
				wait(1);
				continue;
			}
			level notify(#"reinforcement_spawned", {#entity:spawn});
			break;
		}
		for(;;)
		{
			if(!isdefined(fromcolor))
			{
				break;
			}
			if(get_color_from_order(fromcolor, level.current_color_order) == "none")
			{
				break;
			}
			fromcolor = level.current_color_order[fromcolor];
		}
		if(isdefined(fromcolor))
		{
			spawn set_force_color(fromcolor);
		}
		thread lock_spawner_for_awhile();
		if(isdefined(level.friendly_startup_thread))
		{
			spawn thread [[level.friendly_startup_thread]]();
		}
		spawn thread colornode_replace_on_death();
	}
}

/*
	Name: colornode_replace_on_death
	Namespace: colors
	Checksum: 0xDA39A34E
	Offset: 0x49F8
	Size: 0x3F6
	Parameters: 0
	Flags: Linked
*/
function colornode_replace_on_death()
{
	level endon(#"kill_color_replacements");
	/#
		assert(isalive(self), "");
	#/
	self endon(#"_disable_reinforcement");
	if(self.team == #"axis")
	{
		return;
	}
	if(isdefined(self.replace_on_death))
	{
		return;
	}
	self.replace_on_death = 1;
	/#
		assert(!isdefined(self.respawn_on_death), "" + self.export + "");
	#/
	classname = self.classname;
	color = self.script_forcecolor;
	waittillframeend();
	if(isalive(self))
	{
		self waittill(#"death");
	}
	color_order = level.current_color_order;
	if(!isdefined(self.script_forcecolor))
	{
		return;
	}
	friendly_spawners_type = getclasscolorhash(classname, self.script_forcecolor);
	if(!isdefined(level.friendly_spawners_types) || !isdefined(level.friendly_spawners_types[friendly_spawners_type]) || level.friendly_spawners_types[friendly_spawners_type] <= 0)
	{
		level.friendly_spawners_types[friendly_spawners_type] = 1;
		thread colornode_spawn_reinforcement(classname, self.script_forcecolor);
	}
	else
	{
		level.friendly_spawners_types[friendly_spawners_type] = level.friendly_spawners_types[friendly_spawners_type] + 1;
	}
	if(isdefined(self) && isdefined(self.script_forcecolor))
	{
		color = self.script_forcecolor;
	}
	if(isdefined(self) && isdefined(self.origin))
	{
		origin = self.origin;
	}
	for(;;)
	{
		if(get_color_from_order(color, color_order) == "none")
		{
			return;
		}
		correct_colored_friendlies = get_force_color_guys(#"allies", color_order[color]);
		correct_colored_friendlies = array::filter_classname(correct_colored_friendlies, 1, classname);
		if(!correct_colored_friendlies.size)
		{
			wait(2);
			continue;
		}
		players = getplayers();
		correct_colored_guy = arraysort(correct_colored_friendlies, players[0].origin, 1)[0];
		/#
			assert(correct_colored_guy.script_forcecolor != color, "" + color + "");
		#/
		waittillframeend();
		if(!isalive(correct_colored_guy))
		{
			continue;
		}
		correct_colored_guy set_force_color(color);
		if(isdefined(level.friendly_promotion_thread))
		{
			correct_colored_guy [[level.friendly_promotion_thread]](color);
		}
		color = color_order[color];
	}
}

/*
	Name: get_color_from_order
	Namespace: colors
	Checksum: 0x8DDF2DCC
	Offset: 0x4DF8
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function get_color_from_order(color, color_order)
{
	if(!isdefined(color))
	{
		return "none";
	}
	if(!isdefined(color_order))
	{
		return "none";
	}
	if(!isdefined(color_order[color]))
	{
		return "none";
	}
	return color_order[color];
}

/*
	Name: friendly_spawner_vision_checker
	Namespace: colors
	Checksum: 0x8724A94
	Offset: 0x4E58
	Size: 0x220
	Parameters: 0
	Flags: Linked
*/
function friendly_spawner_vision_checker()
{
	level.friendly_respawn_vision_checker_thread = 1;
	successes = 0;
	for(;;)
	{
		level flag::wait_till_clear("respawn_friendlies");
		wait(1);
		if(!isdefined(level.respawn_spawner))
		{
			continue;
		}
		spawner = level.respawn_spawner;
		players = getplayers();
		player_sees_spawner = 0;
		for(q = 0; q < players.size; q++)
		{
			difference_vec = players[q].origin - spawner.origin;
			if(length(difference_vec) < 200)
			{
				player_sees_spawner();
				player_sees_spawner = 1;
				break;
			}
			forward = anglestoforward((0, players[q] getplayerangles()[1], 0));
			difference = vectornormalize(difference_vec);
			dot = vectordot(forward, difference);
			if(dot < 0.2)
			{
				player_sees_spawner();
				player_sees_spawner = 1;
				break;
			}
			successes++;
			if(successes < 3)
			{
				continue;
			}
		}
		if(player_sees_spawner)
		{
			continue;
		}
		level flag::set("player_looks_away_from_spawner");
	}
}

/*
	Name: get_color_spawner
	Namespace: colors
	Checksum: 0xC7B15F0B
	Offset: 0x5080
	Size: 0x26A
	Parameters: 2
	Flags: Linked
*/
function get_color_spawner(classname, fromcolor)
{
	specificfromcolor = 0;
	if(isdefined(level.respawn_spawners_specific) && isdefined(level.respawn_spawners_specific[fromcolor]))
	{
		specificfromcolor = 1;
	}
	if(!isdefined(level.respawn_spawner))
	{
		if(!isdefined(fromcolor) || !specificfromcolor)
		{
			/#
				assertmsg("");
			#/
		}
	}
	if(!isdefined(classname))
	{
		if(isdefined(fromcolor) && specificfromcolor)
		{
			return level.respawn_spawners_specific[fromcolor];
		}
		return level.respawn_spawner;
	}
	spawners = getentarray("color_spawner", "targetname");
	class_spawners = [];
	for(i = 0; i < spawners.size; i++)
	{
		class_spawners[spawners[i].classname] = spawners[i];
	}
	spawner = undefined;
	keys = getarraykeys(class_spawners);
	for(i = 0; i < keys.size; i++)
	{
		if(!issubstr(class_spawners[keys[i]].classname, classname))
		{
			continue;
		}
		spawner = class_spawners[keys[i]];
		break;
	}
	if(!isdefined(spawner))
	{
		if(isdefined(fromcolor) && specificfromcolor)
		{
			return level.respawn_spawners_specific[fromcolor];
		}
		return level.respawn_spawner;
	}
	if(isdefined(fromcolor) && specificfromcolor)
	{
		spawner.origin = level.respawn_spawners_specific[fromcolor].origin;
	}
	else
	{
		spawner.origin = level.respawn_spawner.origin;
	}
	return spawner;
}

/*
	Name: getclasscolorhash
	Namespace: colors
	Checksum: 0xC41496C9
	Offset: 0x52F8
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function getclasscolorhash(classname, fromcolor)
{
	classcolorhash = classname;
	if(isdefined(fromcolor))
	{
		classcolorhash = classcolorhash + "##" + fromcolor;
	}
	return classcolorhash;
}

/*
	Name: lock_spawner_for_awhile
	Namespace: colors
	Checksum: 0x31C4FB3A
	Offset: 0x5348
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function lock_spawner_for_awhile()
{
	level flag::set("friendly_spawner_locked");
	wait(2);
	level flag::clear("friendly_spawner_locked");
}

/*
	Name: player_sees_spawner
	Namespace: colors
	Checksum: 0x6C1E6F7E
	Offset: 0x5398
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function player_sees_spawner()
{
	level flag::clear("player_looks_away_from_spawner");
}

/*
	Name: kill_color_replacements
	Namespace: colors
	Checksum: 0x4B5F3095
	Offset: 0x53C8
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function kill_color_replacements()
{
	level flag::clear("friendly_spawner_locked");
	level notify(#"kill_color_replacements");
	level.friendly_spawners_types = undefined;
	ai = getaiarray();
	array::thread_all(ai, &remove_replace_on_death);
}

/*
	Name: remove_replace_on_death
	Namespace: colors
	Checksum: 0x8D159FAE
	Offset: 0x5450
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function remove_replace_on_death()
{
	self.replace_on_death = undefined;
}

/*
	Name: set_force_color
	Namespace: colors
	Checksum: 0x356B4DCE
	Offset: 0x5468
	Size: 0x27C
	Parameters: 1
	Flags: Linked
*/
function set_force_color(_color)
{
	color = shortencolor(_color);
	/#
		assert(colorislegit(color), "" + color);
	#/
	if(!isactor(self) && !isbot(self))
	{
		set_force_color_spawner(color);
		return;
	}
	/#
		assert(isalive(self), "");
	#/
	self.script_color_axis = undefined;
	self.script_color_allies = undefined;
	self.old_forcecolor = undefined;
	if(isdefined(self.script_forcecolor))
	{
		arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
	}
	self.script_forcecolor = color;
	if(!isdefined(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor]))
	{
		level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = [];
	}
	else if(!isarray(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor]))
	{
		level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = array(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor]);
	}
	level.arrays_of_colorforced_ai[self.team][self.script_forcecolor][level.arrays_of_colorforced_ai[self.team][self.script_forcecolor].size] = self;
	level thread remove_colorforced_ai_when_dead(self);
	self thread new_color_being_set(color);
}

/*
	Name: remove_colorforced_ai_when_dead
	Namespace: colors
	Checksum: 0x3D75EDB5
	Offset: 0x56F0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function remove_colorforced_ai_when_dead(ai)
{
	script_forcecolor = ai.script_forcecolor;
	team = ai.team;
	ai waittill(#"death");
	level.arrays_of_colorforced_ai[team][script_forcecolor] = array::remove_undefined(level.arrays_of_colorforced_ai[team][script_forcecolor]);
}

/*
	Name: shortencolor
	Namespace: colors
	Checksum: 0xEB849BC6
	Offset: 0x5790
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function shortencolor(color)
{
	/#
		assert(isdefined(level.colorchecklist[tolower(color)]), "" + color);
	#/
	return level.colorchecklist[tolower(color)];
}

/*
	Name: set_force_color_spawner
	Namespace: colors
	Checksum: 0x698031CE
	Offset: 0x5808
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function set_force_color_spawner(color)
{
	self.script_forcecolor = color;
	self.old_forcecolor = undefined;
}

/*
	Name: new_color_being_set
	Namespace: colors
	Checksum: 0xECE9A0E1
	Offset: 0x5838
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function new_color_being_set(color)
{
	self notify(#"new_color_being_set");
	self.new_force_color_being_set = 1;
	left_color_node();
	self endon(#"new_color_being_set", #"death");
	waittillframeend();
	waittillframeend();
	if(isdefined(self.script_forcecolor))
	{
		self.currentcolorcode = level.currentcolorforced[self.team][self.script_forcecolor];
		self thread goto_current_colorindex();
	}
	self.new_force_color_being_set = undefined;
	self notify(#"done_setting_new_color");
	/#
		update_debug_friendlycolor();
	#/
}

/*
	Name: update_debug_friendlycolor_on_death
	Namespace: colors
	Checksum: 0x5CA0A2D3
	Offset: 0x5918
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function update_debug_friendlycolor_on_death()
{
	self notify(#"debug_color_update");
	self endon(#"debug_color_update");
	self waittill(#"death");
	/#
		foreach(n_key, v in level.debug_color_friendlies)
		{
			ai = getentbynum(n_key);
			if(!isalive(ai))
			{
				arrayremoveindex(level.debug_color_friendlies, n_key, 1);
			}
		}
	#/
	level notify(#"updated_color_friendlies");
}

/*
	Name: update_debug_friendlycolor
	Namespace: colors
	Checksum: 0x3CE05984
	Offset: 0x5A38
	Size: 0x90
	Parameters: 0
	Flags: None
*/
function update_debug_friendlycolor()
{
	self thread update_debug_friendlycolor_on_death();
	if(isdefined(self.script_forcecolor))
	{
		level.debug_color_friendlies[self getentitynumber()] = self.script_forcecolor;
	}
	else
	{
		level.debug_color_friendlies[self getentitynumber()] = undefined;
	}
	level notify(#"updated_color_friendlies");
}

/*
	Name: has_color
	Namespace: colors
	Checksum: 0xC248F6E2
	Offset: 0x5AD0
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function has_color()
{
	if(self.team == #"allies")
	{
		return isdefined(self.script_color_allies) || isdefined(self.script_forcecolor);
	}
	if(self.team == #"axis")
	{
		return isdefined(self.script_color_axis) || isdefined(self.script_forcecolor);
	}
	if(self.team == #"team3")
	{
		return isdefined(self.var_15eb6ad5) || isdefined(self.script_forcecolor);
	}
	return 0;
}

/*
	Name: get_force_color
	Namespace: colors
	Checksum: 0xCE786317
	Offset: 0x5B88
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function get_force_color()
{
	color = self.script_forcecolor;
	return color;
}

/*
	Name: get_force_color_guys
	Namespace: colors
	Checksum: 0x2144C46
	Offset: 0x5BB0
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function get_force_color_guys(team, color)
{
	ai = getaiteamarray(team);
	guys = [];
	for(i = 0; i < ai.size; i++)
	{
		guy = ai[i];
		if(!isdefined(guy.script_forcecolor))
		{
			continue;
		}
		if(guy.script_forcecolor != color)
		{
			continue;
		}
		guys[guys.size] = guy;
	}
	return guys;
}

/*
	Name: get_all_force_color_friendlies
	Namespace: colors
	Checksum: 0x5E9BF0CD
	Offset: 0x5C80
	Size: 0xA4
	Parameters: 0
	Flags: None
*/
function get_all_force_color_friendlies()
{
	ai = getaiteamarray(#"allies");
	guys = [];
	for(i = 0; i < ai.size; i++)
	{
		guy = ai[i];
		if(!isdefined(guy.script_forcecolor))
		{
			continue;
		}
		guys[guys.size] = guy;
	}
	return guys;
}

/*
	Name: disable
	Namespace: colors
	Checksum: 0x94187BE0
	Offset: 0x5D30
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	if(isdefined(self.new_force_color_being_set))
	{
		self endon(#"death");
		self waittill(#"done_setting_new_color");
	}
	if(!isdefined(self.script_forcecolor))
	{
		return;
	}
	/#
		assert(!isdefined(self.old_forcecolor), "");
	#/
	self.old_forcecolor = self.script_forcecolor;
	arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
	left_color_node();
	self.script_forcecolor = undefined;
	self.currentcolorcode = undefined;
	/#
		update_debug_friendlycolor();
	#/
}

/*
	Name: enable
	Namespace: colors
	Checksum: 0x4344A5F5
	Offset: 0x5E20
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	if(isdefined(self.script_forcecolor))
	{
		return;
	}
	if(!isdefined(self.old_forcecolor))
	{
		return;
	}
	set_force_color(self.old_forcecolor);
	self.old_forcecolor = undefined;
}

/*
	Name: is_color_ai
	Namespace: colors
	Checksum: 0x8764E944
	Offset: 0x5E70
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function is_color_ai()
{
	return isdefined(self.script_forcecolor) || isdefined(self.old_forcecolor);
}

/*
	Name: insure_player_does_not_set_forcecolor_twice_in_one_frame
	Namespace: colors
	Checksum: 0x97D8D3ED
	Offset: 0x5E98
	Size: 0x6A
	Parameters: 0
	Flags: None
*/
function insure_player_does_not_set_forcecolor_twice_in_one_frame()
{
	/#
		/#
			assert(!isdefined(self.setforcecolor), "");
		#/
		self.setforcecolor = 1;
		waittillframeend();
		if(!isalive(self))
		{
			return;
		}
		self.setforcecolor = undefined;
	#/
}

