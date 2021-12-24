// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace art;

/*
	Name: function_89f2df9
	Namespace: art
	Checksum: 0xBE5163E2
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"art", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: art
	Checksum: 0xACAEA37
	Offset: 0xD0
	Size: 0x156
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.dofdefault))
	{
		level.dofdefault[#"nearstart"] = 0;
		level.dofdefault[#"nearend"] = 1;
		level.dofdefault[#"farstart"] = 8000;
		level.dofdefault[#"farend"] = 10000;
		level.dofdefault[#"nearblur"] = 6;
		level.dofdefault[#"farblur"] = 0;
	}
	level.curdof = (level.dofdefault[#"farstart"] - level.dofdefault[#"nearend"]) / 2;
	/#
		thread tweakart();
	#/
	if(!isdefined(level.script))
	{
		level.script = util::function_53bbf9d2();
	}
}

/*
	Name: artfxprintln
	Namespace: art
	Checksum: 0xBE4B04DB
	Offset: 0x230
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function artfxprintln(file, string)
{
	/#
		if(file == -1)
		{
			return;
		}
		fprintln(file, string);
	#/
}

/*
	Name: strtok_loc
	Namespace: art
	Checksum: 0xBBB012FA
	Offset: 0x280
	Size: 0xC8
	Parameters: 2
	Flags: Linked
*/
function strtok_loc(string, par1)
{
	stringlist = [];
	indexstring = "";
	for(i = 0; i < string.size; i++)
	{
		if(string[i] == " ")
		{
			stringlist[stringlist.size] = indexstring;
			indexstring = "";
			continue;
		}
		indexstring = indexstring + string[i];
	}
	if(indexstring.size)
	{
		stringlist[stringlist.size] = indexstring;
	}
	return stringlist;
}

/*
	Name: setfogsliders
	Namespace: art
	Checksum: 0x7ABA28C5
	Offset: 0x350
	Size: 0x1B4
	Parameters: 0
	Flags: None
*/
function setfogsliders()
{
	fogall = strtok_loc(getdvarstring(#"g_fogcolorreadonly"), " ");
	red = fogall[0];
	green = fogall[1];
	blue = fogall[2];
	halfplane = getdvarstring(#"g_foghalfdistreadonly");
	nearplane = getdvarstring(#"g_fogstartdistreadonly");
	if(!isdefined(red) || !isdefined(green) || !isdefined(blue) || !isdefined(halfplane))
	{
		red = 1;
		green = 1;
		blue = 1;
		halfplane = 10000001;
		nearplane = 10000000;
	}
	setdvar(#"scr_fog_exp_halfplane", halfplane);
	setdvar(#"scr_fog_nearplane", nearplane);
	setdvar(#"scr_fog_color", (((red + " ") + green) + " ") + blue);
}

/*
	Name: tweakart
	Namespace: art
	Checksum: 0x86BD2281
	Offset: 0x510
	Size: 0xB00
	Parameters: 0
	Flags: None
*/
function tweakart()
{
	/#
		if(!isdefined(level.tweakfile))
		{
			level.tweakfile = 0;
		}
		if(getdvarstring(#"scr_fog_baseheight") == "")
		{
			setdvar(#"scr_fog_exp_halfplane", 500);
			setdvar(#"scr_fog_exp_halfheight", 500);
			setdvar(#"scr_fog_nearplane", 0);
			setdvar(#"scr_fog_baseheight", 0);
		}
		setdvar(#"scr_fog_fraction", 1);
		setdvar(#"scr_art_dump", 0);
		setdvar(#"scr_art_sun_fog_dir_set", 0);
		setdvar(#"scr_dof_nearstart", level.dofdefault[#"nearstart"]);
		setdvar(#"scr_dof_nearend", level.dofdefault[#"nearend"]);
		setdvar(#"scr_dof_farstart", level.dofdefault[#"farstart"]);
		setdvar(#"scr_dof_farend", level.dofdefault[#"farend"]);
		setdvar(#"scr_dof_nearblur", level.dofdefault[#"nearblur"]);
		setdvar(#"scr_dof_farblur", level.dofdefault[#"farblur"]);
		file = undefined;
		filename = undefined;
		tweak_toggle = 1;
		for(;;)
		{
			while(getdvarint(#"scr_art_tweak", 0) == 0)
			{
				tweak_toggle = 1;
				waitframe(1);
			}
			if(tweak_toggle)
			{
				tweak_toggle = 0;
				fogsettings = getfogsettings();
				setdvar(#"scr_fog_nearplane", fogsettings[0]);
				setdvar(#"scr_fog_exp_halfplane", fogsettings[1]);
				setdvar(#"scr_fog_exp_halfheight", fogsettings[3]);
				setdvar(#"scr_fog_baseheight", fogsettings[2]);
				setdvar(#"scr_fog_color", (((fogsettings[4] + "") + fogsettings[5]) + "") + fogsettings[6]);
				setdvar(#"scr_fog_color_scale", fogsettings[7]);
				setdvar(#"scr_sun_fog_color", (((fogsettings[8] + "") + fogsettings[9]) + "") + fogsettings[10]);
				level.fogsundir = [];
				level.fogsundir[0] = fogsettings[11];
				level.fogsundir[1] = fogsettings[12];
				level.fogsundir[2] = fogsettings[13];
				setdvar(#"scr_sun_fog_start_angle", fogsettings[14]);
				setdvar(#"scr_sun_fog_end_angle", fogsettings[15]);
				setdvar(#"scr_fog_max_opacity", fogsettings[16]);
			}
			level.fogexphalfplane = getdvarfloat(#"scr_fog_exp_halfplane", 0);
			level.fogexphalfheight = getdvarfloat(#"scr_fog_exp_halfheight", 0);
			level.fognearplane = getdvarfloat(#"scr_fog_nearplane", 0);
			level.fogbaseheight = getdvarfloat(#"scr_fog_baseheight", 0);
			colors = strtok(getdvarstring(#"scr_fog_color"), "");
			level.fogcolorred = int(colors[0]);
			level.fogcolorgreen = int(colors[1]);
			level.fogcolorblue = int(colors[2]);
			level.fogcolorscale = getdvarfloat(#"scr_fog_color_scale", 0);
			colors = strtok(getdvarstring(#"scr_sun_fog_color"), "");
			level.sunfogcolorred = int(colors[0]);
			level.sunfogcolorgreen = int(colors[1]);
			level.sunfogcolorblue = int(colors[2]);
			level.sunstartangle = getdvarfloat(#"scr_sun_fog_start_angle", 0);
			level.sunendangle = getdvarfloat(#"scr_sun_fog_end_angle", 0);
			level.fogmaxopacity = getdvarfloat(#"scr_fog_max_opacity", 0);
			if(getdvarint(#"scr_art_sun_fog_dir_set", 0))
			{
				setdvar(#"scr_art_sun_fog_dir_set", 0);
				println("");
				players = getplayers();
				dir = vectornormalize(anglestoforward(players[0] getplayerangles()));
				level.fogsundir = [];
				level.fogsundir[0] = dir[0];
				level.fogsundir[1] = dir[1];
				level.fogsundir[2] = dir[2];
			}
			fovslidercheck();
			dumpsettings();
			if(!getdvarint(#"scr_fog_disable", 0))
			{
				if(!isdefined(level.fogsundir))
				{
					level.fogsundir = [];
					level.fogsundir[0] = 1;
					level.fogsundir[1] = 0;
					level.fogsundir[2] = 0;
				}
				setvolfog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogcolorred, level.fogcolorgreen, level.fogcolorblue, level.fogcolorscale, level.sunfogcolorred, level.sunfogcolorgreen, level.sunfogcolorblue, level.fogsundir[0], level.fogsundir[1], level.fogsundir[2], level.sunstartangle, level.sunendangle, 0, level.fogmaxopacity);
			}
			else
			{
				setexpfog(100000000, 100000001, 0, 0, 0, 0);
			}
			wait(0.1);
		}
	#/
}

/*
	Name: fovslidercheck
	Namespace: art
	Checksum: 0x426435FB
	Offset: 0x1018
	Size: 0x424
	Parameters: 0
	Flags: None
*/
function fovslidercheck()
{
	if(level.dofdefault[#"nearstart"] >= level.dofdefault[#"nearend"])
	{
		level.dofdefault[#"nearstart"] = level.dofdefault[#"nearend"] - 1;
		setdvar(#"scr_dof_nearstart", level.dofdefault[#"nearstart"]);
	}
	if(level.dofdefault[#"nearend"] <= level.dofdefault[#"nearstart"])
	{
		level.dofdefault[#"nearend"] = level.dofdefault[#"nearstart"] + 1;
		setdvar(#"scr_dof_nearend", level.dofdefault[#"nearend"]);
	}
	if(level.dofdefault[#"farstart"] >= level.dofdefault[#"farend"])
	{
		level.dofdefault[#"farstart"] = level.dofdefault[#"farend"] - 1;
		setdvar(#"scr_dof_farstart", level.dofdefault[#"farstart"]);
	}
	if(level.dofdefault[#"farend"] <= level.dofdefault[#"farstart"])
	{
		level.dofdefault[#"farend"] = level.dofdefault[#"farstart"] + 1;
		setdvar(#"scr_dof_farend", level.dofdefault[#"farend"]);
	}
	if(level.dofdefault[#"farblur"] >= level.dofdefault[#"nearblur"])
	{
		level.dofdefault[#"farblur"] = level.dofdefault[#"nearblur"] - 0.1;
		setdvar(#"scr_dof_farblur", level.dofdefault[#"farblur"]);
	}
	if(level.dofdefault[#"farstart"] <= level.dofdefault[#"nearend"])
	{
		level.dofdefault[#"farstart"] = level.dofdefault[#"nearend"] + 1;
		setdvar(#"scr_dof_farstart", level.dofdefault[#"farstart"]);
	}
}

/*
	Name: dumpsettings
	Namespace: art
	Checksum: 0x4FD116E5
	Offset: 0x1448
	Size: 0x40C
	Parameters: 0
	Flags: None
*/
function dumpsettings()
{
	/#
		if(getdvar(#"scr_art_dump", 0))
		{
			println(("" + level.fognearplane) + "");
			println(("" + level.fogexphalfplane) + "");
			println(("" + level.fogexphalfheight) + "");
			println(("" + level.fogbaseheight) + "");
			println(("" + level.fogcolorred) + "");
			println(("" + level.fogcolorgreen) + "");
			println(("" + level.fogcolorblue) + "");
			println(("" + level.fogcolorscale) + "");
			println(("" + level.sunfogcolorred) + "");
			println(("" + level.sunfogcolorgreen) + "");
			println(("" + level.sunfogcolorblue) + "");
			println(("" + level.fogsundir[0]) + "");
			println(("" + level.fogsundir[1]) + "");
			println(("" + level.fogsundir[2]) + "");
			println(("" + level.sunstartangle) + "");
			println(("" + level.sunendangle) + "");
			println("");
			println(("" + level.fogmaxopacity) + "");
			println("");
			println("");
			println("");
			println("");
			setdvar(#"scr_art_dump", 0);
		}
	#/
}

