// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\util.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_zdraw;

/*
	Name: __init__system__
	Namespace: zm_zdraw
	Checksum: 0xB4884C3D
	Offset: 0xB8
	Size: 0x4C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	/#
		system::register(#"zdraw", &__init__, &__main__, undefined);
	#/
}

/*
	Name: __init__
	Namespace: zm_zdraw
	Checksum: 0x8010F6F8
	Offset: 0x110
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	/#
		setdvar(#"zdraw", "");
		level.zdraw = spawnstruct();
		function_c9f70832();
		function_99bd35ec();
		function_b36498d3();
		level thread function_c78d9e67();
	#/
}

/*
	Name: __main__
	Namespace: zm_zdraw
	Checksum: 0x62D83DA0
	Offset: 0x1B8
	Size: 0x8
	Parameters: 0
	Flags: None
*/
function __main__()
{
	/#
	#/
}

/*
	Name: function_c9f70832
	Namespace: zm_zdraw
	Checksum: 0x8E6F4794
	Offset: 0x1C8
	Size: 0x46E
	Parameters: 0
	Flags: None
*/
function function_c9f70832()
{
	/#
		level.zdraw.colors = [];
		level.zdraw.colors[#"red"] = (1, 0, 0);
		level.zdraw.colors[#"green"] = (0, 1, 0);
		level.zdraw.colors[#"blue"] = (0, 0, 1);
		level.zdraw.colors[#"yellow"] = (1, 1, 0);
		level.zdraw.colors[#"orange"] = (1, 0.5, 0);
		level.zdraw.colors[#"cyan"] = (0, 1, 1);
		level.zdraw.colors[#"purple"] = (1, 0, 1);
		level.zdraw.colors[#"black"] = (0, 0, 0);
		level.zdraw.colors[#"white"] = (1, 1, 1);
		level.zdraw.colors[#"grey"] = vectorscale((1, 1, 1), 0.75);
		level.zdraw.colors[#"gray1"] = vectorscale((1, 1, 1), 0.1);
		level.zdraw.colors[#"gray2"] = vectorscale((1, 1, 1), 0.2);
		level.zdraw.colors[#"gray3"] = vectorscale((1, 1, 1), 0.3);
		level.zdraw.colors[#"gray4"] = vectorscale((1, 1, 1), 0.4);
		level.zdraw.colors[#"gray5"] = vectorscale((1, 1, 1), 0.5);
		level.zdraw.colors[#"gray6"] = vectorscale((1, 1, 1), 0.6);
		level.zdraw.colors[#"gray7"] = vectorscale((1, 1, 1), 0.7);
		level.zdraw.colors[#"gray8"] = vectorscale((1, 1, 1), 0.8);
		level.zdraw.colors[#"gray9"] = vectorscale((1, 1, 1), 0.9);
		level.zdraw.colors[#"slate"] = (0.4392157, 0.5019608, 0.5647059);
		level.zdraw.colors[#"pink"] = (1, 0.7529412, 0.7960784);
		level.zdraw.colors[#"olive"] = vectorscale((1, 1, 0), 0.5019608);
		level.zdraw.colors[#"brown"] = (0.5450981, 0.2705882, 0.07450981);
		level.zdraw.colors[#"default"] = (1, 1, 1);
	#/
}

/*
	Name: function_99bd35ec
	Namespace: zm_zdraw
	Checksum: 0xDE040BAF
	Offset: 0x640
	Size: 0x22E
	Parameters: 0
	Flags: None
*/
function function_99bd35ec()
{
	/#
		level.zdraw.commands = [];
		level.zdraw.commands[#"color"] = &function_54389019;
		level.zdraw.commands[#"alpha"] = &function_82f2d020;
		level.zdraw.commands[#"duration"] = &function_cb18c560;
		level.zdraw.commands[#"seconds"] = &function_82201799;
		level.zdraw.commands[#"scale"] = &function_f7176625;
		level.zdraw.commands[#"radius"] = &function_a026f442;
		level.zdraw.commands[#"sides"] = &function_912c8db9;
		level.zdraw.commands[#"text"] = &function_b5cdeec6;
		level.zdraw.commands[#"star"] = &function_da7503f4;
		level.zdraw.commands[#"sphere"] = &function_3a2c5c6b;
		level.zdraw.commands[#"line"] = &function_25fd7d2a;
	#/
}

/*
	Name: function_b36498d3
	Namespace: zm_zdraw
	Checksum: 0xB84FE35E
	Offset: 0x878
	Size: 0xF2
	Parameters: 0
	Flags: None
*/
function function_b36498d3()
{
	/#
		level.zdraw.color = level.zdraw.colors[#"default"];
		level.zdraw.alpha = 1;
		level.zdraw.scale = 1;
		level.zdraw.duration = int(1 * 62.5);
		level.zdraw.radius = 8;
		level.zdraw.sides = 10;
		level.zdraw.var_eeef5e89 = (0, 0, 0);
		level.zdraw.var_f78505a1 = 0;
		level.zdraw.var_d15c03f8 = "";
	#/
}

/*
	Name: function_c78d9e67
	Namespace: zm_zdraw
	Checksum: 0x997A3FAB
	Offset: 0x978
	Size: 0xF8
	Parameters: 0
	Flags: None
*/
function function_c78d9e67()
{
	/#
		level notify(#"hash_79dc2eb04ee1da22");
		level endon(#"hash_79dc2eb04ee1da22");
		for(;;)
		{
			cmd = getdvarstring(#"zdraw");
			if(cmd.size)
			{
				function_b36498d3();
				params = strtok(cmd, "");
				function_cd7ed6c5(params, 0, 1);
				setdvar(#"zdraw", "");
			}
			wait(0.5);
		}
	#/
}

/*
	Name: function_cd7ed6c5
	Namespace: zm_zdraw
	Checksum: 0x1F0DB96A
	Offset: 0xA78
	Size: 0xDA
	Parameters: 3
	Flags: None
*/
function function_cd7ed6c5(var_a99ac828, startat, var_7d04e9ec)
{
	/#
		if(!isdefined(var_7d04e9ec))
		{
			var_7d04e9ec = 0;
		}
		while(isdefined(var_a99ac828[startat]))
		{
			if(isdefined(level.zdraw.commands[var_a99ac828[startat]]))
			{
				startat = [[level.zdraw.commands[var_a99ac828[startat]]]](var_a99ac828, startat + 1);
			}
			else
			{
				if(isdefined(var_7d04e9ec) && var_7d04e9ec)
				{
					function_96c207f("" + var_a99ac828[startat]);
				}
				return startat;
			}
		}
		return startat;
	#/
}

/*
	Name: function_3a2c5c6b
	Namespace: zm_zdraw
	Checksum: 0x9652CC8A
	Offset: 0xB60
	Size: 0x15C
	Parameters: 2
	Flags: None
*/
function function_3a2c5c6b(var_a99ac828, startat)
{
	/#
		while(isdefined(var_a99ac828[startat]))
		{
			if(function_b0f457f2(var_a99ac828[startat]))
			{
				var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
				if(var_769ff4d7 > startat)
				{
					startat = var_769ff4d7;
					center = level.zdraw.var_eeef5e89;
					sphere(center, level.zdraw.radius, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.sides, level.zdraw.duration);
					level.zdraw.var_eeef5e89 = (0, 0, 0);
				}
			}
			else
			{
				var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);
				if(var_769ff4d7 > startat)
				{
					startat = var_769ff4d7;
				}
				else
				{
					return startat;
				}
			}
		}
		return startat;
	#/
}

/*
	Name: function_da7503f4
	Namespace: zm_zdraw
	Checksum: 0xB6A0ACA1
	Offset: 0xCC8
	Size: 0x124
	Parameters: 2
	Flags: None
*/
function function_da7503f4(var_a99ac828, startat)
{
	/#
		while(isdefined(var_a99ac828[startat]))
		{
			if(function_b0f457f2(var_a99ac828[startat]))
			{
				var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
				if(var_769ff4d7 > startat)
				{
					startat = var_769ff4d7;
					center = level.zdraw.var_eeef5e89;
					debugstar(center, level.zdraw.duration, level.zdraw.color);
					level.zdraw.var_eeef5e89 = (0, 0, 0);
				}
			}
			else
			{
				var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);
				if(var_769ff4d7 > startat)
				{
					startat = var_769ff4d7;
				}
				else
				{
					return startat;
				}
			}
		}
		return startat;
	#/
}

/*
	Name: function_25fd7d2a
	Namespace: zm_zdraw
	Checksum: 0xC0DDD9FB
	Offset: 0xDF8
	Size: 0x184
	Parameters: 2
	Flags: None
*/
function function_25fd7d2a(var_a99ac828, startat)
{
	/#
		level.zdraw.linestart = undefined;
		while(isdefined(var_a99ac828[startat]))
		{
			if(function_b0f457f2(var_a99ac828[startat]))
			{
				var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
				if(var_769ff4d7 > startat)
				{
					startat = var_769ff4d7;
					lineend = level.zdraw.var_eeef5e89;
					if(isdefined(level.zdraw.linestart))
					{
						line(level.zdraw.linestart, lineend, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.duration);
					}
					level.zdraw.linestart = lineend;
					level.zdraw.var_eeef5e89 = (0, 0, 0);
				}
			}
			else
			{
				var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);
				if(var_769ff4d7 > startat)
				{
					startat = var_769ff4d7;
				}
				else
				{
					return startat;
				}
			}
		}
		return startat;
	#/
}

/*
	Name: function_b5cdeec6
	Namespace: zm_zdraw
	Checksum: 0x52B1DA06
	Offset: 0xF88
	Size: 0x1DC
	Parameters: 2
	Flags: None
*/
function function_b5cdeec6(var_a99ac828, startat)
{
	/#
		level.zdraw.text = "";
		if(isdefined(var_a99ac828[startat]))
		{
			var_769ff4d7 = function_7bf700e4(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.text = level.zdraw.var_d15c03f8;
				level.zdraw.var_d15c03f8 = "";
			}
		}
		while(isdefined(var_a99ac828[startat]))
		{
			if(function_b0f457f2(var_a99ac828[startat]))
			{
				var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
				if(var_769ff4d7 > startat)
				{
					startat = var_769ff4d7;
					center = level.zdraw.var_eeef5e89;
					print3d(center, level.zdraw.text, level.zdraw.color, level.zdraw.alpha, level.zdraw.scale, level.zdraw.duration);
					level.zdraw.var_eeef5e89 = (0, 0, 0);
				}
			}
			else
			{
				var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);
				if(var_769ff4d7 > startat)
				{
					startat = var_769ff4d7;
				}
				else
				{
					return startat;
				}
			}
		}
		return startat;
	#/
}

/*
	Name: function_54389019
	Namespace: zm_zdraw
	Checksum: 0x196CF798
	Offset: 0x1170
	Size: 0x16E
	Parameters: 2
	Flags: None
*/
function function_54389019(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			if(function_b0f457f2(var_a99ac828[startat]))
			{
				var_769ff4d7 = function_b59acc83(var_a99ac828, startat);
				if(var_769ff4d7 > startat)
				{
					startat = var_769ff4d7;
					level.zdraw.color = level.zdraw.var_eeef5e89;
					level.zdraw.var_eeef5e89 = (0, 0, 0);
				}
				else
				{
					level.zdraw.color = (1, 1, 1);
				}
			}
			else
			{
				if(isdefined(level.zdraw.colors[var_a99ac828[startat]]))
				{
					level.zdraw.color = level.zdraw.colors[var_a99ac828[startat]];
				}
				else
				{
					level.zdraw.color = (1, 1, 1);
					function_96c207f("" + var_a99ac828[startat]);
				}
				startat = startat + 1;
			}
		}
		return startat;
	#/
}

/*
	Name: function_82f2d020
	Namespace: zm_zdraw
	Checksum: 0xE7C01B8B
	Offset: 0x12E8
	Size: 0xB2
	Parameters: 2
	Flags: None
*/
function function_82f2d020(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			var_769ff4d7 = function_6291f508(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.alpha = level.zdraw.var_f78505a1;
				level.zdraw.var_f78505a1 = 0;
			}
			else
			{
				level.zdraw.alpha = 1;
			}
		}
		return startat;
	#/
}

/*
	Name: function_f7176625
	Namespace: zm_zdraw
	Checksum: 0xE28EA788
	Offset: 0x13A8
	Size: 0xB2
	Parameters: 2
	Flags: None
*/
function function_f7176625(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			var_769ff4d7 = function_6291f508(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.scale = level.zdraw.var_f78505a1;
				level.zdraw.var_f78505a1 = 0;
			}
			else
			{
				level.zdraw.scale = 1;
			}
		}
		return startat;
	#/
}

/*
	Name: function_cb18c560
	Namespace: zm_zdraw
	Checksum: 0x737C9516
	Offset: 0x1468
	Size: 0xDE
	Parameters: 2
	Flags: None
*/
function function_cb18c560(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			var_769ff4d7 = function_6291f508(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.duration = int(level.zdraw.var_f78505a1);
				level.zdraw.var_f78505a1 = 0;
			}
			else
			{
				level.zdraw.duration = int(1 * 62.5);
			}
		}
		return startat;
	#/
}

/*
	Name: function_82201799
	Namespace: zm_zdraw
	Checksum: 0x67BD00F
	Offset: 0x1550
	Size: 0xE6
	Parameters: 2
	Flags: None
*/
function function_82201799(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			var_769ff4d7 = function_6291f508(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.duration = int(62.5 * level.zdraw.var_f78505a1);
				level.zdraw.var_f78505a1 = 0;
			}
			else
			{
				level.zdraw.duration = int(1 * 62.5);
			}
		}
		return startat;
	#/
}

/*
	Name: function_a026f442
	Namespace: zm_zdraw
	Checksum: 0x4D851C0
	Offset: 0x1640
	Size: 0xB2
	Parameters: 2
	Flags: None
*/
function function_a026f442(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			var_769ff4d7 = function_6291f508(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.radius = level.zdraw.var_f78505a1;
				level.zdraw.var_f78505a1 = 0;
			}
			else
			{
				level.zdraw.radius = 8;
			}
		}
		return startat;
	#/
}

/*
	Name: function_912c8db9
	Namespace: zm_zdraw
	Checksum: 0xFE548077
	Offset: 0x1700
	Size: 0xC2
	Parameters: 2
	Flags: None
*/
function function_912c8db9(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			var_769ff4d7 = function_6291f508(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.sides = int(level.zdraw.var_f78505a1);
				level.zdraw.var_f78505a1 = 0;
			}
			else
			{
				level.zdraw.sides = 10;
			}
		}
		return startat;
	#/
}

/*
	Name: function_b0f457f2
	Namespace: zm_zdraw
	Checksum: 0x77AA84ED
	Offset: 0x17D0
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_b0f457f2(param)
{
	/#
		if(isdefined(param) && (isint(param) || isfloat(param) || (isstring(param) && strisnumber(param))))
		{
			return true;
		}
		return false;
	#/
}

/*
	Name: function_b59acc83
	Namespace: zm_zdraw
	Checksum: 0x7796C86
	Offset: 0x1860
	Size: 0x256
	Parameters: 2
	Flags: None
*/
function function_b59acc83(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			var_769ff4d7 = function_6291f508(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.var_eeef5e89 = (level.zdraw.var_f78505a1, level.zdraw.var_eeef5e89[1], level.zdraw.var_eeef5e89[2]);
				level.zdraw.var_f78505a1 = 0;
			}
			else
			{
				function_96c207f("");
				return startat;
			}
			var_769ff4d7 = function_6291f508(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.var_eeef5e89 = (level.zdraw.var_eeef5e89[0], level.zdraw.var_f78505a1, level.zdraw.var_eeef5e89[2]);
				level.zdraw.var_f78505a1 = 0;
			}
			else
			{
				function_96c207f("");
				return startat;
			}
			var_769ff4d7 = function_6291f508(var_a99ac828, startat);
			if(var_769ff4d7 > startat)
			{
				startat = var_769ff4d7;
				level.zdraw.var_eeef5e89 = (level.zdraw.var_eeef5e89[0], level.zdraw.var_eeef5e89[1], level.zdraw.var_f78505a1);
				level.zdraw.var_f78505a1 = 0;
			}
			else
			{
				function_96c207f("");
				return startat;
			}
		}
		return startat;
	#/
}

/*
	Name: function_6291f508
	Namespace: zm_zdraw
	Checksum: 0xA04EEE9B
	Offset: 0x1AC0
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function function_6291f508(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			if(function_b0f457f2(var_a99ac828[startat]))
			{
				level.zdraw.var_f78505a1 = float(var_a99ac828[startat]);
				startat = startat + 1;
			}
		}
		return startat;
	#/
}

/*
	Name: function_7bf700e4
	Namespace: zm_zdraw
	Checksum: 0x399780A6
	Offset: 0x1B50
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function function_7bf700e4(var_a99ac828, startat)
{
	/#
		if(isdefined(var_a99ac828[startat]))
		{
			level.zdraw.var_d15c03f8 = var_a99ac828[startat];
			startat = startat + 1;
		}
		return startat;
	#/
}

/*
	Name: function_96c207f
	Namespace: zm_zdraw
	Checksum: 0x19F93C1
	Offset: 0x1BB0
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_96c207f(msg)
{
	/#
		println("" + msg);
	#/
}

