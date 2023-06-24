// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace debug;

/*
	Name: __init__system__
	Namespace: debug
	Checksum: 0x60A229C1
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	/#
		system::register(#"debug", &__init__, undefined, undefined);
	#/
}

/*
	Name: __init__
	Namespace: debug
	Checksum: 0x15CB2699
	Offset: 0xC8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function __init__()
{
	/#
		level thread debug_draw_tuning_sphere();
		level thread devgui_debug_key_value();
	#/
}

/*
	Name: devgui_debug_key_value
	Namespace: debug
	Checksum: 0xC5F29CB2
	Offset: 0x108
	Size: 0x3D8
	Parameters: 0
	Flags: None
*/
function devgui_debug_key_value()
{
	/#
		a_keys = array("", "", "", "", "", "", "", "", "");
		setdvar(#"debug_key_value", 0);
		setdvar(#"debug_key_value_dist", 2000);
		adddebugcommand("");
		adddebugcommand("");
		foreach(str_key in a_keys)
		{
			adddebugcommand(((("" + str_key) + "") + str_key) + "");
		}
		while(!flag::exists(""))
		{
			util::wait_network_frame();
		}
		level flag::wait_till("");
		while(true)
		{
			debug_key_value = getdvar(#"debug_key_value", 0);
			if(debug_key_value != 0)
			{
				a_ents = getentarray();
				foreach(ent in a_ents)
				{
					n_draw_dist = getdvarint(#"debug_key_value_dist", 0);
					n_draw_dist_sq = n_draw_dist * n_draw_dist;
					n_dist_sq = distancesquared(ent.origin, level.players[0].origin);
					if(n_dist_sq <= n_draw_dist_sq)
					{
						n_scale = mapfloat(0, 6250000, 0.5, 5, n_dist_sq);
						ent thread debug_key_value(string(debug_key_value), undefined, n_scale);
						continue;
					}
					ent notify(#"debug_key_value");
				}
			}
			else
			{
				level notify(#"debug_key_value");
			}
			wait(randomfloatrange(0.1333333, 0.2666667));
		}
	#/
}

/*
	Name: debug_draw_tuning_sphere
	Namespace: debug
	Checksum: 0x5BA307AD
	Offset: 0x4E8
	Size: 0x240
	Parameters: 0
	Flags: None
*/
function debug_draw_tuning_sphere()
{
	/#
		n_sphere_radius = 0;
		v_text_position = (0, 0, 0);
		n_text_scale = 1;
		while(true)
		{
			n_sphere_radius = getdvarfloat(#"debug_measure_sphere_radius", 0);
			while(n_sphere_radius >= 1)
			{
				players = getplayers();
				if(isdefined(players[0]))
				{
					n_sphere_radius = getdvarfloat(#"debug_measure_sphere_radius", 0);
					circle(players[0].origin, n_sphere_radius, (1, 0, 0), 0, 1, 16);
					n_text_scale = (sqrt(n_sphere_radius * 2.5)) / 2;
					vforward = anglestoforward(players[0].angles);
					v_text_position = players[0].origin + (vforward * n_sphere_radius);
					sides = int(10 * (1 + (int(n_text_scale) % 100)));
					sphere(v_text_position, n_text_scale, (1, 0, 0), 1, 1, sides, 16);
					print3d(v_text_position + vectorscale((0, 0, 1), 20), n_sphere_radius, (1, 0, 0), 1, n_text_scale / 14, 16);
				}
				waitframe(1);
			}
			wait(1);
		}
	#/
}

/*
	Name: debug_key_value
	Namespace: debug
	Checksum: 0x6EB09C52
	Offset: 0x730
	Size: 0x156
	Parameters: 3
	Flags: None
*/
function debug_key_value(str_key, n_time, n_scale)
{
	/#
		if(!isdefined(n_scale))
		{
			n_scale = 1;
		}
		level endon(#"debug_key_value");
		self notify(#"debug_key_value");
		self endon(#"debug_key_value", #"death");
		if(isdefined(str_key))
		{
			if(isdefined(n_time))
			{
				__s = spawnstruct();
				__s endon(#"timeout");
				__s util::delay_notify(n_time, "");
			}
			while(true)
			{
				value = self.(str_key);
				if(isdefined(value))
				{
					print3d(self.origin, (isdefined(value) ? "" + value : ""), (0, 0, 1), 1, n_scale, 1);
				}
				waitframe(1);
			}
		}
	#/
}

/*
	Name: drawdebuglineinternal
	Namespace: debug
	Checksum: 0x450483DC
	Offset: 0x890
	Size: 0x6C
	Parameters: 4
	Flags: None
*/
function drawdebuglineinternal(frompoint, topoint, color, durationframes)
{
	/#
		for(i = 0; i < durationframes; i++)
		{
			line(frompoint, topoint, color);
			waitframe(1);
		}
	#/
}

/*
	Name: drawdebugenttoentinternal
	Namespace: debug
	Checksum: 0x8E46C2B0
	Offset: 0x908
	Size: 0x94
	Parameters: 4
	Flags: None
*/
function drawdebugenttoentinternal(ent1, ent2, color, durationframes)
{
	/#
		for(i = 0; i < durationframes; i++)
		{
			if(!isdefined(ent1) || !isdefined(ent2))
			{
				return;
			}
			line(ent1.origin, ent2.origin, color);
			waitframe(1);
		}
	#/
}

/*
	Name: drawdebugline
	Namespace: debug
	Checksum: 0xCAF01B01
	Offset: 0x9A8
	Size: 0x4C
	Parameters: 4
	Flags: None
*/
function drawdebugline(frompoint, topoint, color, durationframes)
{
	/#
		thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
	#/
}

/*
	Name: drawdebuglineenttoent
	Namespace: debug
	Checksum: 0xA987ECBB
	Offset: 0xA00
	Size: 0x4C
	Parameters: 4
	Flags: None
*/
function drawdebuglineenttoent(ent1, ent2, color, durationframes)
{
	/#
		thread drawdebugenttoentinternal(ent1, ent2, color, durationframes);
	#/
}

