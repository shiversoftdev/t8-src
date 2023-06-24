// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_51e19a6cd0b4d30f;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace util;

/*
	Name: __init__system__
	Namespace: util
	Checksum: 0xB5685B56
	Offset: 0x388
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"util_shared", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: util
	Checksum: 0x10E87E90
	Offset: 0x3D8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_9fee970c = function_60d95f53();
	function_73fab74d();
	function_f9ce1d49();
	register_clientfields();
	namespace_1e38a8f6::init();
}

/*
	Name: __main__
	Namespace: util
	Checksum: 0x89E66F76
	Offset: 0x448
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	system::wait_till("all");
	function_3cb7a62d();
}

/*
	Name: register_clientfields
	Namespace: util
	Checksum: 0xFA57294B
	Offset: 0x480
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("world", "cf_team_mapping", 1, 1, "int");
	clientfield::register("world", "preload_frontend", 1, 1, "int");
	clientfield::register("allplayers", "ClearStreamerLoadingHints", 1, 1, "int");
	clientfield::register("allplayers", "StreamerSetSpawnHintIndex", 1, 4, "int");
}

/*
	Name: error
	Namespace: util
	Checksum: 0x36D3BF10
	Offset: 0x550
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function error(msg)
{
	/#
		println("", msg);
		if(!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame())
		{
			waitframe(1);
		}
		if(getdvar(#"debug", 0))
		{
			/#
				assertmsg("");
			#/
		}
	#/
}

/*
	Name: warning
	Namespace: util
	Checksum: 0xE52B1D96
	Offset: 0x600
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function warning(msg)
{
	/#
		println("" + msg);
	#/
}

/*
	Name: empty
	Namespace: util
	Checksum: 0xDCB06E22
	Offset: 0x640
	Size: 0x2C
	Parameters: 5
	Flags: Linked
*/
function empty(a, b, c, d, e)
{
}

/*
	Name: wait_network_frame
	Namespace: util
	Checksum: 0xDD67FE99
	Offset: 0x678
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function wait_network_frame(n_count = 1)
{
	if(numremoteclients())
	{
		for(i = 0; i < n_count; i++)
		{
			snapshot_ids = getsnapshotindexarray();
			acked = undefined;
			for(n_tries = 0; !isdefined(acked) && n_tries < 5; n_tries++)
			{
				level waittill(#"snapacknowledged");
				acked = snapshotacknowledged(snapshot_ids);
			}
		}
	}
	else
	{
		wait(0.1 * n_count);
	}
}

/*
	Name: preload_frontend
	Namespace: util
	Checksum: 0xE48FAA31
	Offset: 0x778
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function preload_frontend()
{
	level clientfield::set("preload_frontend", 1);
	wait_network_frame();
	level clientfield::set("preload_frontend", 0);
}

/*
	Name: clear_streamer_hint
	Namespace: util
	Checksum: 0x89EC692D
	Offset: 0x7D8
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function clear_streamer_hint()
{
	if(isdefined(self.streamer_hint))
	{
		self.streamer_hint delete();
		self.streamer_hint = undefined;
	}
	self notify(#"wait_clear_streamer_hint");
}

/*
	Name: wait_clear_streamer_hint
	Namespace: util
	Checksum: 0xC21B581B
	Offset: 0x828
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function wait_clear_streamer_hint(lifetime)
{
	self endon(#"wait_clear_streamer_hint");
	wait(lifetime);
	if(isdefined(self))
	{
		self clear_streamer_hint();
	}
}

/*
	Name: create_streamer_hint
	Namespace: util
	Checksum: 0xD3576CD
	Offset: 0x878
	Size: 0x19C
	Parameters: 4
	Flags: Linked
*/
function create_streamer_hint(origin, angles, value, lifetime)
{
	if(self == level)
	{
		foreach(player in getplayers())
		{
			player clear_streamer_hint();
		}
	}
	self clear_streamer_hint();
	self.streamer_hint = createstreamerhint(origin, value);
	if(isdefined(angles))
	{
		self.streamer_hint.angles = angles;
	}
	if(self != level)
	{
		self.streamer_hint setinvisibletoall();
		self.streamer_hint setvisibletoplayer(self);
	}
	self.streamer_hint setincludemeshes(1);
	self notify(#"wait_clear_streamer_hint");
	if(isdefined(lifetime) && lifetime > 0)
	{
		self thread wait_clear_streamer_hint(lifetime);
	}
}

/*
	Name: streamer_wait
	Namespace: util
	Checksum: 0x59FC3FDB
	Offset: 0xA20
	Size: 0x3A0
	Parameters: 5
	Flags: Linked
*/
function streamer_wait(n_stream_request_id, n_wait_frames = 0, n_timeout = 15, str_team, str_scenedef)
{
	/#
		if(getdvarint(#"cg_drawfps", 1) != 0)
		{
			n_timeout = 1;
		}
	#/
	if(n_wait_frames > 0)
	{
		wait_network_frame(n_wait_frames);
	}
	timeout = gettime() + (int(n_timeout * 1000));
	if(self == level)
	{
		n_num_streamers_ready = 0;
		do
		{
			wait_network_frame();
			n_num_streamers_ready = 0;
			if(isdefined(str_team))
			{
				a_players = get_players(str_team);
			}
			else
			{
				a_players = getplayers();
			}
			foreach(player in a_players)
			{
				if(isdefined(str_scenedef) && isarray(player.var_16672042) && isdefined(player.var_16672042[str_scenedef]))
				{
					var_5a2f2554 = player.var_16672042[str_scenedef];
				}
				else
				{
					var_5a2f2554 = (isdefined(n_stream_request_id) ? n_stream_request_id : player.var_ecd30af1);
				}
				if((isdefined(var_5a2f2554) ? player isstreamerready(var_5a2f2554) : player isstreamerready()))
				{
					n_num_streamers_ready++;
				}
			}
			if(n_timeout > 0 && gettime() > timeout)
			{
				/#
					if(n_timeout > 5)
					{
						iprintln("");
						debug2dtext(vectorscale((1, 1, 0), 50), "", (1, 0, 0), 1, (0, 0, 0), 0, 2, 40);
					}
				#/
				break;
			}
		}
		while(n_num_streamers_ready < max(1, a_players.size));
	}
	else
	{
		self endon(#"disconnect");
		var_5a2f2554 = (isdefined(n_stream_request_id) ? n_stream_request_id : self.var_ecd30af1);
		do
		{
			wait_network_frame();
			if(n_timeout > 0 && gettime() > timeout)
			{
				break;
			}
		}
		while(!(isdefined(var_5a2f2554) ? self isstreamerready(var_5a2f2554) : self isstreamerready()));
	}
}

/*
	Name: draw_debug_line
	Namespace: util
	Checksum: 0xA5B2541A
	Offset: 0xDC8
	Size: 0x7C
	Parameters: 3
	Flags: None
*/
function draw_debug_line(start, end, timer)
{
	/#
		for(i = 0; i < timer * 20; i++)
		{
			line(start, end, (1, 1, 0.5));
			waitframe(1);
		}
	#/
}

/*
	Name: debug_line
	Namespace: util
	Checksum: 0xC317C8F5
	Offset: 0xE50
	Size: 0x9C
	Parameters: 6
	Flags: None
*/
function debug_line(start, end, color, alpha, depthtest, duration)
{
	/#
		if(!isdefined(color))
		{
			color = (1, 1, 1);
		}
		if(!isdefined(alpha))
		{
			alpha = 1;
		}
		if(!isdefined(depthtest))
		{
			depthtest = 0;
		}
		if(!isdefined(duration))
		{
			duration = 100;
		}
		line(start, end, color, alpha, depthtest, duration);
	#/
}

/*
	Name: debug_spherical_cone
	Namespace: util
	Checksum: 0x5F676FB9
	Offset: 0xEF8
	Size: 0xC4
	Parameters: 8
	Flags: None
*/
function debug_spherical_cone(origin, domeapex, angle, slices, color, alpha, depthtest, duration)
{
	/#
		if(!isdefined(slices))
		{
			slices = 10;
		}
		if(!isdefined(color))
		{
			color = (1, 1, 1);
		}
		if(!isdefined(alpha))
		{
			alpha = 1;
		}
		if(!isdefined(depthtest))
		{
			depthtest = 0;
		}
		if(!isdefined(duration))
		{
			duration = 100;
		}
		sphericalcone(origin, domeapex, angle, slices, color, alpha, depthtest, duration);
	#/
}

/*
	Name: debug_sphere
	Namespace: util
	Checksum: 0x845C1DB6
	Offset: 0xFC8
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
	Name: plot_points
	Namespace: util
	Checksum: 0x6E817F1B
	Offset: 0x1090
	Size: 0xEC
	Parameters: 5
	Flags: None
*/
function plot_points(plotpoints, r, g, b, timer)
{
	/#
		lastpoint = plotpoints[0];
		if(!isdefined(r))
		{
			r = 1;
		}
		if(!isdefined(g))
		{
			g = 1;
		}
		if(!isdefined(b))
		{
			b = 1;
		}
		if(!isdefined(timer))
		{
			timer = 0.05;
		}
		for(i = 1; i < plotpoints.size; i++)
		{
			thread draw_line_for_time(lastpoint, plotpoints[i], r, g, b, timer);
			lastpoint = plotpoints[i];
		}
	#/
}

/*
	Name: draw_arrow_time
	Namespace: util
	Checksum: 0xF331A43F
	Offset: 0x1188
	Size: 0x2AC
	Parameters: 4
	Flags: None
*/
function draw_arrow_time(start, end, color, timer)
{
	/#
		level endon(#"newpath");
		pts = [];
		angles = vectortoangles(start - end);
		right = anglestoright(angles);
		forward = anglestoforward(angles);
		up = anglestoup(angles);
		dist = distance(start, end);
		arrow = [];
		arrow[0] = start;
		arrow[1] = (start + (vectorscale(right, dist * 0.1))) + (vectorscale(forward, dist * -0.1));
		arrow[2] = end;
		arrow[3] = (start + (vectorscale(right, dist * -1 * 0.1))) + (vectorscale(forward, dist * -0.1));
		arrow[4] = start;
		arrow[5] = (start + (vectorscale(up, dist * 0.1))) + (vectorscale(forward, dist * -0.1));
		arrow[6] = end;
		arrow[7] = (start + (vectorscale(up, dist * -1 * 0.1))) + (vectorscale(forward, dist * -0.1));
		arrow[8] = start;
		r = color[0];
		g = color[1];
		b = color[2];
		plot_points(arrow, r, g, b, timer);
	#/
}

/*
	Name: draw_arrow
	Namespace: util
	Checksum: 0xF13EC0E1
	Offset: 0x1440
	Size: 0x1F6
	Parameters: 3
	Flags: None
*/
function draw_arrow(start, end, color)
{
	/#
		level endon(#"newpath");
		pts = [];
		angles = vectortoangles(start - end);
		right = anglestoright(angles);
		forward = anglestoforward(angles);
		dist = distance(start, end);
		arrow = [];
		arrow[0] = start;
		arrow[1] = (start + (vectorscale(right, dist * 0.05))) + (vectorscale(forward, dist * -0.2));
		arrow[2] = end;
		arrow[3] = (start + (vectorscale(right, dist * -1 * 0.05))) + (vectorscale(forward, dist * -0.2));
		for(p = 0; p < 4; p++)
		{
			nextpoint = p + 1;
			if(nextpoint >= 4)
			{
				nextpoint = 0;
			}
			line(arrow[p], arrow[nextpoint], color, 1);
		}
	#/
}

/*
	Name: debugorigin
	Namespace: util
	Checksum: 0xAAAE4242
	Offset: 0x1640
	Size: 0x1D6
	Parameters: 0
	Flags: None
*/
function debugorigin()
{
	/#
		self notify(#"debug origin");
		self endon(#"debug origin", #"death");
		for(;;)
		{
			forward = anglestoforward(self.angles);
			forwardfar = vectorscale(forward, 30);
			forwardclose = vectorscale(forward, 20);
			right = anglestoright(self.angles);
			left = vectorscale(right, -10);
			right = vectorscale(right, 10);
			line(self.origin, self.origin + forwardfar, (0.9, 0.7, 0.6), 0.9);
			line(self.origin + forwardfar, (self.origin + forwardclose) + right, (0.9, 0.7, 0.6), 0.9);
			line(self.origin + forwardfar, (self.origin + forwardclose) + left, (0.9, 0.7, 0.6), 0.9);
			waitframe(1);
		}
	#/
}

/*
	Name: draw_line_for_time
	Namespace: util
	Checksum: 0x9DF32EC
	Offset: 0x1820
	Size: 0xB6
	Parameters: 6
	Flags: None
*/
function draw_line_for_time(org1, org2, r, g, b, timer)
{
	/#
		timer = gettime() + (timer * 1000);
		while(gettime() < timer)
		{
			line(org1, org2, (r, g, b), 1);
			recordline(org1, org2, (1, 1, 1), "");
			waitframe(1);
		}
	#/
}

/*
	Name: function_6844bea4
	Namespace: util
	Checksum: 0xD8F32E0E
	Offset: 0x18E0
	Size: 0x16C
	Parameters: 6
	Flags: None
*/
function function_6844bea4(radius1, radius2, time, color, origin, normal)
{
	/#
		if(!isdefined(color))
		{
			color = (0, 1, 0);
		}
		circleres = 6;
		circleinc = 360 / circleres;
		circleres++;
		plotpoints = [];
		rad = 0;
		radius = radius2;
		angletoplayer = vectortoangles(normal);
		for(i = 0; i < circleres; i++)
		{
			plotpoints[plotpoints.size] = origin + (vectorscale(anglestoforward(angletoplayer + (rad, 90, 0)), radius));
			rad = rad + circleinc;
		}
		plot_points(plotpoints, color[0], color[1], color[2], time);
	#/
}

/*
	Name: track
	Namespace: util
	Checksum: 0xCA70F14F
	Offset: 0x1A58
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function track(spot_to_track)
{
	if(isdefined(self.current_target))
	{
		if(spot_to_track == self.current_target)
		{
			return;
		}
	}
	self.current_target = spot_to_track;
}

/*
	Name: waittill_string
	Namespace: util
	Checksum: 0x4EBE8E7A
	Offset: 0x1A98
	Size: 0x80
	Parameters: 2
	Flags: Linked
*/
function waittill_string(msg, ent)
{
	if(msg != "death")
	{
		self endon(#"death");
	}
	ent endon(#"die");
	self waittill(msg);
	ent notify(#"returned", {#msg:msg});
}

/*
	Name: waittill_level_string
	Namespace: util
	Checksum: 0x2DCD7395
	Offset: 0x1B20
	Size: 0x80
	Parameters: 3
	Flags: Linked
*/
function waittill_level_string(msg, ent, otherent)
{
	otherent endon(#"death");
	ent endon(#"die");
	level waittill(msg);
	ent notify(#"returned", {#msg:msg});
}

/*
	Name: waittill_multiple
	Namespace: util
	Checksum: 0x55AADB9B
	Offset: 0x1BA8
	Size: 0x9C
	Parameters: 1
	Flags: Variadic
*/
function waittill_multiple(vararg)
{
	s_tracker = spawnstruct();
	s_tracker._wait_count = 0;
	for(i = 0; i < vararg.size; i++)
	{
		self thread _waitlogic(s_tracker, vararg[i]);
	}
	if(s_tracker._wait_count > 0)
	{
		s_tracker waittill(#"waitlogic_finished");
	}
}

/*
	Name: waittill_either
	Namespace: util
	Checksum: 0x5AA31E5B
	Offset: 0x1C50
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function waittill_either(msg1, msg2)
{
	self endon(msg1);
	self waittill(msg2);
}

/*
	Name: break_glass
	Namespace: util
	Checksum: 0x718EDF26
	Offset: 0x1C88
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function break_glass(n_radius = 50)
{
	n_radius = float(n_radius);
	if(n_radius == -1)
	{
		v_origin_offset = (0, 0, 0);
		n_radius = 100;
	}
	else
	{
		v_origin_offset = vectorscale((0, 0, 1), 40);
	}
	glassradiusdamage(self.origin + v_origin_offset, n_radius, 500, 500);
}

/*
	Name: waittill_multiple_ents
	Namespace: util
	Checksum: 0x36F0C65A
	Offset: 0x1D40
	Size: 0x1C4
	Parameters: 1
	Flags: Variadic
*/
function waittill_multiple_ents(vararg)
{
	a_ents = [];
	a_notifies = [];
	for(i = 0; i < vararg.size; i++)
	{
		if(i % 2)
		{
			if(!isdefined(a_notifies))
			{
				a_notifies = [];
			}
			else if(!isarray(a_notifies))
			{
				a_notifies = array(a_notifies);
			}
			a_notifies[a_notifies.size] = vararg[i];
			continue;
		}
		if(!isdefined(a_ents))
		{
			a_ents = [];
		}
		else if(!isarray(a_ents))
		{
			a_ents = array(a_ents);
		}
		a_ents[a_ents.size] = vararg[i];
	}
	s_tracker = spawnstruct();
	s_tracker._wait_count = 0;
	for(i = 0; i < a_ents.size; i++)
	{
		ent = a_ents[i];
		if(isdefined(ent))
		{
			ent thread _waitlogic(s_tracker, a_notifies[i]);
		}
	}
	if(s_tracker._wait_count > 0)
	{
		s_tracker waittill(#"waitlogic_finished");
	}
}

/*
	Name: _waitlogic
	Namespace: util
	Checksum: 0xD1E299EA
	Offset: 0x1F10
	Size: 0xB0
	Parameters: 2
	Flags: Linked
*/
function _waitlogic(s_tracker, notifies)
{
	s_tracker._wait_count++;
	if(!isdefined(notifies))
	{
		notifies = [];
	}
	else if(!isarray(notifies))
	{
		notifies = array(notifies);
	}
	notifies[notifies.size] = "death";
	self waittill(notifies);
	s_tracker._wait_count--;
	if(s_tracker._wait_count == 0)
	{
		s_tracker notify(#"waitlogic_finished");
	}
}

/*
	Name: waittill_level_any_timeout
	Namespace: util
	Checksum: 0xA4092A3A
	Offset: 0x1FC8
	Size: 0x1BA
	Parameters: 7
	Flags: Linked
*/
function waittill_level_any_timeout(n_timeout, otherent, string1, string2, string3, string4, string5)
{
	otherent endon(#"death");
	ent = spawnstruct();
	if(isdefined(string1))
	{
		level thread waittill_level_string(string1, ent, otherent);
	}
	if(isdefined(string2))
	{
		level thread waittill_level_string(string2, ent, otherent);
	}
	if(isdefined(string3))
	{
		level thread waittill_level_string(string3, ent, otherent);
	}
	if(isdefined(string4))
	{
		level thread waittill_level_string(string4, ent, otherent);
	}
	if(isdefined(string5))
	{
		level thread waittill_level_string(string5, ent, otherent);
	}
	if(isdefined(otherent))
	{
		otherent thread waittill_string("death", ent);
	}
	ent thread _timeout(n_timeout);
	waitresult = undefined;
	waitresult = ent waittill(#"returned");
	ent notify(#"die");
	return waitresult.msg;
}

/*
	Name: _timeout
	Namespace: util
	Checksum: 0x52DA7F7B
	Offset: 0x2190
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function _timeout(delay)
{
	self endon(#"die");
	wait(delay);
	self notify(#"returned", {#msg:"timeout"});
}

/*
	Name: waittill_any_ents
	Namespace: util
	Checksum: 0xE30D0275
	Offset: 0x21F0
	Size: 0x166
	Parameters: 14
	Flags: Linked
*/
function waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7)
{
	/#
		assert(isdefined(ent1));
	#/
	/#
		assert(isdefined(string1));
	#/
	if(isdefined(ent2) && isdefined(string2))
	{
		ent2 endon(string2);
	}
	if(isdefined(ent3) && isdefined(string3))
	{
		ent3 endon(string3);
	}
	if(isdefined(ent4) && isdefined(string4))
	{
		ent4 endon(string4);
	}
	if(isdefined(ent5) && isdefined(string5))
	{
		ent5 endon(string5);
	}
	if(isdefined(ent6) && isdefined(string6))
	{
		ent6 endon(string6);
	}
	if(isdefined(ent7) && isdefined(string7))
	{
		ent7 endon(string7);
	}
	ent1 waittill(string1);
}

/*
	Name: waittill_any_ents_two
	Namespace: util
	Checksum: 0x76BC9FC2
	Offset: 0x2360
	Size: 0x80
	Parameters: 4
	Flags: Linked
*/
function waittill_any_ents_two(ent1, string1, ent2, string2)
{
	/#
		assert(isdefined(ent1));
	#/
	/#
		assert(isdefined(string1));
	#/
	if(isdefined(ent2) && isdefined(string2))
	{
		ent2 endon(string2);
	}
	ent1 waittill(string1);
}

/*
	Name: isflashed
	Namespace: util
	Checksum: 0xC477395E
	Offset: 0x23E8
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function isflashed()
{
	if(!isdefined(self.flashendtime))
	{
		return 0;
	}
	return gettime() < self.flashendtime;
}

/*
	Name: isstunned
	Namespace: util
	Checksum: 0x70CB79C9
	Offset: 0x2410
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function isstunned()
{
	if(!isdefined(self.flashendtime))
	{
		return 0;
	}
	return gettime() < self.flashendtime;
}

/*
	Name: single_func
	Namespace: util
	Checksum: 0x8837140
	Offset: 0x2438
	Size: 0x3A
	Parameters: 3
	Flags: Linked, Variadic
*/
function single_func(entity, func, vararg)
{
	return _single_func(entity, func, vararg);
}

/*
	Name: single_func_argarray
	Namespace: util
	Checksum: 0x2AE185EF
	Offset: 0x2480
	Size: 0x3A
	Parameters: 3
	Flags: Linked
*/
function single_func_argarray(entity, func, a_vars)
{
	return _single_func(entity, func, a_vars);
}

/*
	Name: _single_func
	Namespace: util
	Checksum: 0x40C0BDAB
	Offset: 0x24C8
	Size: 0x53A
	Parameters: 3
	Flags: Linked
*/
function _single_func(entity, func, a_vars)
{
	_clean_up_arg_array(a_vars);
	switch(a_vars.size)
	{
		case 8:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
			}
			break;
		}
		case 7:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
			}
			break;
		}
		case 6:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
			}
			break;
		}
		case 5:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
			}
			break;
		}
		case 4:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
			}
			break;
		}
		case 3:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2]);
			}
			break;
		}
		case 2:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1]);
			}
			break;
		}
		case 1:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0]);
			}
			else
			{
				return [[func]](a_vars[0]);
			}
			break;
		}
		case 0:
		{
			if(isdefined(entity))
			{
				return entity [[func]]();
			}
			else
			{
				return [[func]]();
			}
			break;
		}
		default:
		{
			/#
				assertmsg("");
			#/
		}
	}
}

/*
	Name: _clean_up_arg_array
	Namespace: util
	Checksum: 0xAA0D02BD
	Offset: 0x2A10
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function _clean_up_arg_array(a_vars)
{
	for(i = a_vars.size - 1; i >= 0; i--)
	{
		if(a_vars[i] === undefined)
		{
			arrayremoveindex(a_vars, i, 0);
			continue;
		}
		break;
	}
}

/*
	Name: new_func
	Namespace: util
	Checksum: 0xEB1FBB0D
	Offset: 0x2A88
	Size: 0xCA
	Parameters: 7
	Flags: None
*/
function new_func(func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	s_func = spawnstruct();
	s_func.func = func;
	s_func.arg1 = arg1;
	s_func.arg2 = arg2;
	s_func.arg3 = arg3;
	s_func.arg4 = arg4;
	s_func.arg5 = arg5;
	s_func.arg6 = arg6;
	return s_func;
}

/*
	Name: call_func
	Namespace: util
	Checksum: 0xE0EFE409
	Offset: 0x2B60
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function call_func(s_func)
{
	return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

/*
	Name: single_thread
	Namespace: util
	Checksum: 0xBEAB1519
	Offset: 0x2BE0
	Size: 0x3C
	Parameters: 3
	Flags: Linked, Variadic
*/
function single_thread(entity, func, vararg)
{
	_single_thread(entity, func, undefined, undefined, vararg);
}

/*
	Name: single_thread_argarray
	Namespace: util
	Checksum: 0x12B5AD14
	Offset: 0x2C28
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function single_thread_argarray(entity, func, a_vars)
{
	_single_thread(entity, func, undefined, undefined, a_vars);
}

/*
	Name: function_50f54b6f
	Namespace: util
	Checksum: 0x87D7A87C
	Offset: 0x2C70
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function function_50f54b6f(entity, func, arg1, a_vars)
{
	_single_thread(entity, func, arg1, undefined, a_vars);
}

/*
	Name: function_cf55c866
	Namespace: util
	Checksum: 0x5ADACCC9
	Offset: 0x2CC0
	Size: 0x54
	Parameters: 5
	Flags: Linked
*/
function function_cf55c866(entity, func, arg1, arg2, a_vars)
{
	_single_thread(entity, func, arg1, arg2, a_vars);
}

/*
	Name: _single_thread
	Namespace: util
	Checksum: 0x723955AF
	Offset: 0x2D20
	Size: 0x9B2
	Parameters: 5
	Flags: Linked
*/
function _single_thread(entity, func, arg1, arg2, a_vars)
{
	_clean_up_arg_array(a_vars);
	/#
		/#
			assert(isfunctionptr(func), "" + "");
		#/
	#/
	if(!isfunctionptr(func))
	{
		return;
	}
	if(isdefined(arg2))
	{
		switch(a_vars.size)
		{
			case 8:
			{
				entity thread [[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
				break;
			}
			case 7:
			{
				entity thread [[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
				break;
			}
			case 6:
			{
				entity thread [[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
				break;
			}
			case 5:
			{
				entity thread [[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
				break;
			}
			case 4:
			{
				entity thread [[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
				break;
			}
			case 3:
			{
				entity thread [[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2]);
				break;
			}
			case 2:
			{
				entity thread [[func]](arg1, arg2, a_vars[0], a_vars[1]);
				break;
			}
			case 1:
			{
				entity thread [[func]](arg1, arg2, a_vars[0]);
				break;
			}
			case 0:
			{
				entity thread [[func]](arg1, arg2);
				break;
			}
			default:
			{
				/#
					assertmsg("");
				#/
			}
		}
	}
	else
	{
		if(isdefined(arg1))
		{
			switch(a_vars.size)
			{
				case 8:
				{
					entity thread [[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
					break;
				}
				case 7:
				{
					entity thread [[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
					break;
				}
				case 6:
				{
					entity thread [[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
					break;
				}
				case 5:
				{
					entity thread [[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
					break;
				}
				case 4:
				{
					entity thread [[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
					break;
				}
				case 3:
				{
					entity thread [[func]](arg1, a_vars[0], a_vars[1], a_vars[2]);
					break;
				}
				case 2:
				{
					entity thread [[func]](arg1, a_vars[0], a_vars[1]);
					break;
				}
				case 1:
				{
					entity thread [[func]](arg1, a_vars[0]);
					break;
				}
				case 0:
				{
					entity thread [[func]](arg1);
					break;
				}
				default:
				{
					/#
						assertmsg("");
					#/
				}
			}
		}
		else
		{
			switch(a_vars.size)
			{
				case 8:
				{
					entity thread [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
					break;
				}
				case 7:
				{
					entity thread [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
					break;
				}
				case 6:
				{
					entity thread [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
					break;
				}
				case 5:
				{
					entity thread [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
					break;
				}
				case 4:
				{
					entity thread [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
					break;
				}
				case 3:
				{
					entity thread [[func]](a_vars[0], a_vars[1], a_vars[2]);
					break;
				}
				case 2:
				{
					entity thread [[func]](a_vars[0], a_vars[1]);
					break;
				}
				case 1:
				{
					entity thread [[func]](a_vars[0]);
					break;
				}
				case 0:
				{
					entity thread [[func]]();
					break;
				}
				default:
				{
					/#
						assertmsg("");
					#/
				}
			}
		}
	}
}

/*
	Name: script_delay
	Namespace: util
	Checksum: 0xA6018118
	Offset: 0x36E0
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function script_delay()
{
	n_time = gettime();
	self.var_653e059d = 1;
	if(isdefined(self.script_delay))
	{
		wait(self.script_delay);
	}
	n_min_delay = (isdefined(self.script_delay_min) ? self.script_delay_min : 0);
	n_max_delay = (isdefined(self.script_delay_max) ? self.script_delay_max : 0);
	if(n_max_delay > n_min_delay)
	{
		wait(randomfloatrange(n_min_delay, n_max_delay));
	}
	else if(n_min_delay > 0)
	{
		wait(n_min_delay);
	}
	self.var_653e059d = undefined;
	return gettime() - n_time;
}

/*
	Name: timeout
	Namespace: util
	Checksum: 0xF8C7931
	Offset: 0x37B8
	Size: 0xCC
	Parameters: 8
	Flags: Linked
*/
function timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	if(isdefined(n_time))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s delay_notify(n_time, "timeout");
	}
	single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

/*
	Name: create_flags_and_return_tokens
	Namespace: util
	Checksum: 0xB20CA97F
	Offset: 0x3890
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function create_flags_and_return_tokens(flags)
{
	tokens = strtok(flags, " ");
	for(i = 0; i < tokens.size; i++)
	{
		level trigger::function_ac2f203a(tokens[i]);
	}
	return tokens;
}

/*
	Name: function_aebdb74f
	Namespace: util
	Checksum: 0xE7331FA2
	Offset: 0x3920
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function function_aebdb74f(str_flags)
{
	a_str_flags = strtok(str_flags, " ");
	foreach(str_flag in a_str_flags)
	{
		level flag::set(str_flag);
	}
}

/*
	Name: fileprint_start
	Namespace: util
	Checksum: 0x543D85CE
	Offset: 0x39D8
	Size: 0x6A
	Parameters: 1
	Flags: None
*/
function fileprint_start(file)
{
	/#
		filename = file;
		file = openfile(filename, "");
		level.fileprint = file;
		level.fileprintlinecount = 0;
		level.fileprint_filename = filename;
	#/
}

/*
	Name: fileprint_map_start
	Namespace: util
	Checksum: 0xBC7E917D
	Offset: 0x3A50
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function fileprint_map_start(file)
{
	/#
		file = ("" + file) + "";
		fileprint_start(file);
		level.fileprint_mapentcount = 0;
		fileprint_map_header(1);
	#/
}

/*
	Name: fileprint_chk
	Namespace: util
	Checksum: 0x61438D4D
	Offset: 0x3AC0
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function fileprint_chk(file, str)
{
	/#
		level.fileprintlinecount++;
		if(level.fileprintlinecount > 400)
		{
			waitframe(1);
			level.fileprintlinecount++;
			level.fileprintlinecount = 0;
		}
		fprintln(file, str);
	#/
}

/*
	Name: fileprint_map_header
	Namespace: util
	Checksum: 0x1372DA2B
	Offset: 0x3B38
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function fileprint_map_header(binclude_blank_worldspawn = 0)
{
	/#
		assert(isdefined(level.fileprint));
	#/
	/#
		fileprint_chk(level.fileprint, "");
		fileprint_chk(level.fileprint, "");
		fileprint_chk(level.fileprint, "");
		if(!binclude_blank_worldspawn)
		{
			return;
		}
		fileprint_map_entity_start();
		fileprint_map_keypairprint("", "");
		fileprint_map_entity_end();
	#/
}

/*
	Name: fileprint_map_keypairprint
	Namespace: util
	Checksum: 0xCCE64BC0
	Offset: 0x3C38
	Size: 0x7C
	Parameters: 2
	Flags: None
*/
function fileprint_map_keypairprint(key1, key2)
{
	/#
		/#
			assert(isdefined(level.fileprint));
		#/
		fileprint_chk(level.fileprint, ((("" + key1) + "") + key2) + "");
	#/
}

/*
	Name: fileprint_map_entity_start
	Namespace: util
	Checksum: 0xC9FD7DB8
	Offset: 0x3CC0
	Size: 0xB8
	Parameters: 0
	Flags: None
*/
function fileprint_map_entity_start()
{
	/#
		/#
			assert(!isdefined(level.fileprint_entitystart));
		#/
		level.fileprint_entitystart = 1;
		/#
			assert(isdefined(level.fileprint));
		#/
		fileprint_chk(level.fileprint, "" + level.fileprint_mapentcount);
		fileprint_chk(level.fileprint, "");
		level.fileprint_mapentcount++;
	#/
}

/*
	Name: fileprint_map_entity_end
	Namespace: util
	Checksum: 0x966EA15F
	Offset: 0x3D80
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function fileprint_map_entity_end()
{
	/#
		/#
			assert(isdefined(level.fileprint_entitystart));
		#/
		/#
			assert(isdefined(level.fileprint));
		#/
		level.fileprint_entitystart = undefined;
		fileprint_chk(level.fileprint, "");
	#/
}

/*
	Name: fileprint_end
	Namespace: util
	Checksum: 0xEA3FE3ED
	Offset: 0x3E00
	Size: 0x262
	Parameters: 0
	Flags: None
*/
function fileprint_end()
{
	/#
		/#
			assert(!isdefined(level.fileprint_entitystart));
		#/
		saved = closefile(level.fileprint);
		if(saved != 1)
		{
			println("");
			println("");
			println("");
			println("" + level.fileprint_filename);
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
			println("");
		}
		level.fileprint = undefined;
		level.fileprint_filename = undefined;
	#/
}

/*
	Name: fileprint_radiant_vec
	Namespace: util
	Checksum: 0xD93E79E0
	Offset: 0x4070
	Size: 0x60
	Parameters: 1
	Flags: None
*/
function fileprint_radiant_vec(vector)
{
	/#
		string = ((((("" + vector[0]) + "") + vector[1]) + "") + vector[2]) + "";
		return string;
	#/
}

/*
	Name: death_notify_wrapper
	Namespace: util
	Checksum: 0x1465048B
	Offset: 0x40E0
	Size: 0x8E
	Parameters: 2
	Flags: None
*/
function death_notify_wrapper(attacker, damagetype)
{
	level notify(#"face", {#entity:self, #face_notify:"death"});
	self notify(#"death", {#mod:damagetype, #attacker:attacker});
}

/*
	Name: damage_notify_wrapper
	Namespace: util
	Checksum: 0xF38F6F89
	Offset: 0x4178
	Size: 0x136
	Parameters: 9
	Flags: Linked
*/
function damage_notify_wrapper(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags)
{
	level notify(#"face", {#entity:self, #face_notify:"damage"});
	self notify(#"damage", {#flags:idflags, #part_name:partname, #tag_name:tagname, #model_name:modelname, #mod:type, #position:point, #direction:direction_vec, #attacker:attacker, #amount:damage});
}

/*
	Name: explode_notify_wrapper
	Namespace: util
	Checksum: 0xA8042E8B
	Offset: 0x42B8
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function explode_notify_wrapper()
{
	level notify(#"face", {#entity:self, #face_notify:"explode"});
	self notify(#"explode");
}

/*
	Name: alert_notify_wrapper
	Namespace: util
	Checksum: 0x2BA8EE71
	Offset: 0x4320
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function alert_notify_wrapper()
{
	level notify(#"face", {#entity:self, #face_notify:"alert"});
	self notify(#"alert");
}

/*
	Name: shoot_notify_wrapper
	Namespace: util
	Checksum: 0xB2D14886
	Offset: 0x4388
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function shoot_notify_wrapper()
{
	level notify(#"face", {#entity:self, #face_notify:"shoot"});
	self notify(#"shoot");
}

/*
	Name: melee_notify_wrapper
	Namespace: util
	Checksum: 0xB876721F
	Offset: 0x43F0
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function melee_notify_wrapper()
{
	level notify(#"face", {#entity:self, #face_notify:"melee"});
	self notify(#"melee");
}

/*
	Name: isusabilityenabled
	Namespace: util
	Checksum: 0xD6C35662
	Offset: 0x4458
	Size: 0xC
	Parameters: 0
	Flags: None
*/
function isusabilityenabled()
{
	return !self.disabledusability;
}

/*
	Name: _disableusability
	Namespace: util
	Checksum: 0xF4BC5262
	Offset: 0x4470
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function _disableusability()
{
	self.disabledusability++;
	self disableusability();
}

/*
	Name: _enableusability
	Namespace: util
	Checksum: 0x397E01F4
	Offset: 0x44A0
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function _enableusability()
{
	self.disabledusability--;
	/#
		assert(self.disabledusability >= 0);
	#/
	if(!self.disabledusability)
	{
		self enableusability();
	}
}

/*
	Name: resetusability
	Namespace: util
	Checksum: 0x3FDD20D5
	Offset: 0x4500
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function resetusability()
{
	self.disabledusability = 0;
	self enableusability();
}

/*
	Name: orient_to_normal
	Namespace: util
	Checksum: 0xA0FD9AC7
	Offset: 0x4530
	Size: 0xEA
	Parameters: 1
	Flags: None
*/
function orient_to_normal(normal)
{
	hor_normal = (normal[0], normal[1], 0);
	hor_length = length(hor_normal);
	if(!hor_length)
	{
		return (0, 0, 0);
	}
	hor_dir = vectornormalize(hor_normal);
	neg_height = normal[2] * -1;
	tangent = (hor_dir[0] * neg_height, hor_dir[1] * neg_height, hor_length);
	plant_angle = vectortoangles(tangent);
	return plant_angle;
}

/*
	Name: delay
	Namespace: util
	Checksum: 0x63EDAEFE
	Offset: 0x4628
	Size: 0x84
	Parameters: 9
	Flags: Linked
*/
function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

/*
	Name: _delay
	Namespace: util
	Checksum: 0xFCC7CD76
	Offset: 0x46B8
	Size: 0xE4
	Parameters: 9
	Flags: Linked
*/
function _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	self endon(#"death");
	if(isdefined(str_endon))
	{
		self endon(str_endon);
	}
	if(ishash(time_or_notify) || isstring(time_or_notify))
	{
		self waittill(time_or_notify);
	}
	else
	{
		wait(time_or_notify);
	}
	single_thread(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

/*
	Name: delay_network_frames
	Namespace: util
	Checksum: 0x5E0805B
	Offset: 0x47A8
	Size: 0x84
	Parameters: 9
	Flags: Linked
*/
function delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	self thread _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

/*
	Name: _delay_network_frames
	Namespace: util
	Checksum: 0xE26E5DD4
	Offset: 0x4838
	Size: 0xB4
	Parameters: 9
	Flags: Linked
*/
function _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	self endon(#"death");
	if(isdefined(str_endon))
	{
		self endon(str_endon);
	}
	wait_network_frame(n_frames);
	single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

/*
	Name: delay_notify
	Namespace: util
	Checksum: 0xF5180D3D
	Offset: 0x48F8
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function delay_notify(time_or_notify, str_notify, str_endon, arg1)
{
	self thread _delay_notify(time_or_notify, str_notify, str_endon, arg1);
}

/*
	Name: _delay_notify
	Namespace: util
	Checksum: 0xBEA35957
	Offset: 0x4948
	Size: 0x9A
	Parameters: 4
	Flags: Linked
*/
function _delay_notify(time_or_notify, str_notify, str_endon, arg1)
{
	self endon(#"death");
	if(isdefined(str_endon))
	{
		self endon(str_endon);
	}
	if(ishash(time_or_notify) || isstring(time_or_notify))
	{
		self waittill(time_or_notify);
	}
	else
	{
		wait(time_or_notify);
	}
	self notify(str_notify, arg1);
}

/*
	Name: get_closest_player
	Namespace: util
	Checksum: 0x5DCAD765
	Offset: 0x49F0
	Size: 0x74
	Parameters: 2
	Flags: None
*/
function get_closest_player(org, team)
{
	team = get_team_mapping(team);
	players = getplayers(team);
	return arraysort(players, org, 1, 1)[0];
}

/*
	Name: registerclientsys
	Namespace: util
	Checksum: 0x1F1864E1
	Offset: 0x4A70
	Size: 0xF2
	Parameters: 1
	Flags: Linked
*/
function registerclientsys(ssysname)
{
	if(!isdefined(level._clientsys))
	{
		level._clientsys = [];
	}
	if(level._clientsys.size >= 32)
	{
		/#
			/#
				assertmsg("");
			#/
		#/
		return;
	}
	if(isdefined(level._clientsys[ssysname]))
	{
		/#
			/#
				assertmsg("" + ssysname);
			#/
		#/
		return;
	}
	level._clientsys[ssysname] = spawnstruct();
	level._clientsys[ssysname].sysid = clientsysregister(ssysname);
}

/*
	Name: setclientsysstate
	Namespace: util
	Checksum: 0xD1790927
	Offset: 0x4B70
	Size: 0x112
	Parameters: 3
	Flags: Linked
*/
function setclientsysstate(ssysname, ssysstate, player)
{
	if(!isdefined(level._clientsys))
	{
		/#
			/#
				assertmsg("");
			#/
		#/
		return;
	}
	if(!isdefined(level._clientsys[ssysname]))
	{
		/#
			/#
				assertmsg("" + ssysname);
			#/
		#/
		return;
	}
	if(isdefined(player))
	{
		player clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
	}
	else
	{
		clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
		level._clientsys[ssysname].sysstate = ssysstate;
	}
}

/*
	Name: getclientsysstate
	Namespace: util
	Checksum: 0x302C4AE4
	Offset: 0x4C90
	Size: 0xCE
	Parameters: 1
	Flags: None
*/
function getclientsysstate(ssysname)
{
	if(!isdefined(level._clientsys))
	{
		/#
			/#
				assertmsg("");
			#/
		#/
		return "";
	}
	if(!isdefined(level._clientsys[ssysname]))
	{
		/#
			/#
				assertmsg(("" + ssysname) + "");
			#/
		#/
		return "";
	}
	if(isdefined(level._clientsys[ssysname].sysstate))
	{
		return level._clientsys[ssysname].sysstate;
	}
	return "";
}

/*
	Name: clientnotify
	Namespace: util
	Checksum: 0x19F2D543
	Offset: 0x4D68
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function clientnotify(event)
{
	if(level.clientscripts)
	{
		if(isplayer(self))
		{
			setclientsysstate("levelNotify", event, self);
		}
		else
		{
			setclientsysstate("levelNotify", event);
		}
	}
}

/*
	Name: coopgame
	Namespace: util
	Checksum: 0x733DA9CF
	Offset: 0x4DE0
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function coopgame()
{
	return sessionmodeissystemlink() || (sessionmodeisonlinegame() || issplitscreen());
}

/*
	Name: is_looking_at
	Namespace: util
	Checksum: 0xD8E8350A
	Offset: 0x4E30
	Size: 0x1A6
	Parameters: 4
	Flags: Linked
*/
function is_looking_at(ent_or_org, n_dot_range = 0.9, do_trace = 0, v_offset)
{
	/#
		assert(isdefined(ent_or_org), "");
	#/
	v_point = (isvec(ent_or_org) ? ent_or_org : ent_or_org.origin);
	if(isvec(v_offset))
	{
		v_point = v_point + v_offset;
	}
	b_can_see = 0;
	b_use_tag_eye = 0;
	if(isplayer(self) || isai(self))
	{
		b_use_tag_eye = 1;
	}
	n_dot = self math::get_dot_direction(v_point, 0, 1, "forward", b_use_tag_eye);
	if(n_dot > n_dot_range)
	{
		if(do_trace)
		{
			v_eye = self get_eye();
			b_can_see = sighttracepassed(v_eye, v_point, 0, ent_or_org);
		}
		else
		{
			b_can_see = 1;
		}
	}
	return b_can_see;
}

/*
	Name: get_eye
	Namespace: util
	Checksum: 0x32AA74A8
	Offset: 0x4FE0
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function get_eye()
{
	if(isplayer(self))
	{
		return self getplayercamerapos();
	}
	return self geteye();
}

/*
	Name: is_ads
	Namespace: util
	Checksum: 0xC8894ABD
	Offset: 0x5038
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function is_ads()
{
	return self playerads() > 0.5;
}

/*
	Name: spawn_model
	Namespace: util
	Checksum: 0xB4DC3176
	Offset: 0x5068
	Size: 0x146
	Parameters: 5
	Flags: Linked
*/
function spawn_model(model_name, origin = (0, 0, 0), angles = (0, 0, 0), n_spawnflags = 0, b_throttle = 0)
{
	while(true)
	{
		if(b_throttle)
		{
			spawner::global_spawn_throttle(4);
		}
		model = spawn("script_model", origin, n_spawnflags);
		if(isdefined(model))
		{
			break;
		}
		else
		{
			/#
				println(((((("" + "") + model_name) + "") + origin) + "") + angles);
			#/
		}
		waitframe(1);
	}
	model setmodel(model_name);
	model.angles = angles;
	return model;
}

/*
	Name: spawn_anim_model
	Namespace: util
	Checksum: 0x2C9E71A9
	Offset: 0x51B8
	Size: 0x9A
	Parameters: 5
	Flags: Linked
*/
function spawn_anim_model(model_name, origin, angles, n_spawnflags = 0, b_throttle)
{
	model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
	model useanimtree("generic");
	model.animtree = "generic";
	return model;
}

/*
	Name: spawn_anim_player_model
	Namespace: util
	Checksum: 0x326C59C6
	Offset: 0x5260
	Size: 0x9A
	Parameters: 5
	Flags: Linked
*/
function spawn_anim_player_model(model_name, origin, angles, n_spawnflags = 0, b_throttle)
{
	model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
	model useanimtree("all_player");
	model.animtree = "all_player";
	return model;
}

/*
	Name: waittill_player_looking_at
	Namespace: util
	Checksum: 0xDCAA352
	Offset: 0x5308
	Size: 0xB0
	Parameters: 4
	Flags: Linked
*/
function waittill_player_looking_at(origin, arc_angle_degrees = 90, do_trace, e_ignore)
{
	self endon(#"death");
	arc_angle_degrees = absangleclamp360(arc_angle_degrees);
	dot = cos(arc_angle_degrees * 0.5);
	while(!is_player_looking_at(origin, dot, do_trace, e_ignore))
	{
		waitframe(1);
	}
}

/*
	Name: waittill_player_not_looking_at
	Namespace: util
	Checksum: 0xB9067342
	Offset: 0x53C0
	Size: 0x58
	Parameters: 3
	Flags: Linked
*/
function waittill_player_not_looking_at(origin, dot, do_trace)
{
	self endon(#"death");
	while(is_player_looking_at(origin, dot, do_trace))
	{
		waitframe(1);
	}
}

/*
	Name: is_player_looking_at
	Namespace: util
	Checksum: 0x34365B1F
	Offset: 0x5420
	Size: 0x1B8
	Parameters: 4
	Flags: Linked
*/
function is_player_looking_at(v_origin, n_dot = 0.7, b_do_trace = 1, e_ignore)
{
	/#
		assert(isplayer(self), "");
	#/
	if(isdefined(self.hijacked_vehicle_entity))
	{
		v_eye = self.hijacked_vehicle_entity gettagorigin("tag_driver");
		v_view = anglestoforward(self.hijacked_vehicle_entity gettagangles("tag_driver"));
	}
	else
	{
		v_eye = self get_eye();
		v_view = anglestoforward(self getplayerangles());
	}
	v_delta = vectornormalize(v_origin - v_eye);
	n_new_dot = vectordot(v_delta, v_view);
	if(n_new_dot >= n_dot)
	{
		if(b_do_trace)
		{
			return bullettracepassed(v_origin, v_eye, 0, e_ignore);
		}
		return 1;
	}
	return 0;
}

/*
	Name: wait_endon
	Namespace: util
	Checksum: 0x747EFD76
	Offset: 0x55E0
	Size: 0x76
	Parameters: 5
	Flags: Linked
*/
function wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4)
{
	self endon(endonstring);
	if(isdefined(endonstring2))
	{
		self endon(endonstring2);
	}
	if(isdefined(endonstring3))
	{
		self endon(endonstring3);
	}
	if(isdefined(endonstring4))
	{
		self endon(endonstring4);
	}
	wait(waittime);
	return true;
}

/*
	Name: waittillendonthreaded
	Namespace: util
	Checksum: 0x3669590A
	Offset: 0x5660
	Size: 0x84
	Parameters: 5
	Flags: None
*/
function waittillendonthreaded(waitcondition, callback, endcondition1, endcondition2, endcondition3)
{
	if(isdefined(endcondition1))
	{
		self endon(endcondition1);
	}
	if(isdefined(endcondition2))
	{
		self endon(endcondition2);
	}
	if(isdefined(endcondition3))
	{
		self endon(endcondition3);
	}
	self waittill(waitcondition);
	if(isdefined(callback))
	{
		[[callback]](waitcondition);
	}
}

/*
	Name: new_timer
	Namespace: util
	Checksum: 0x1F3296BA
	Offset: 0x56F0
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function new_timer(n_timer_length)
{
	s_timer = spawnstruct();
	s_timer.n_time_created = gettime();
	s_timer.n_length = n_timer_length;
	return s_timer;
}

/*
	Name: get_time
	Namespace: util
	Checksum: 0xCC40363F
	Offset: 0x5740
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function get_time()
{
	t_now = gettime();
	return t_now - self.n_time_created;
}

/*
	Name: get_time_in_seconds
	Namespace: util
	Checksum: 0x2EE85389
	Offset: 0x5768
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function get_time_in_seconds()
{
	return float(get_time()) / 1000;
}

/*
	Name: get_time_frac
	Namespace: util
	Checksum: 0xB521935F
	Offset: 0x57A8
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function get_time_frac(n_end_time = self.n_length)
{
	return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

/*
	Name: get_time_left
	Namespace: util
	Checksum: 0x404D6128
	Offset: 0x5800
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function get_time_left()
{
	if(isdefined(self.n_length))
	{
		n_current_time = get_time_in_seconds();
		return max(self.n_length - n_current_time, 0);
	}
	return -1;
}

/*
	Name: is_time_left
	Namespace: util
	Checksum: 0x58F052F1
	Offset: 0x5860
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function is_time_left()
{
	return get_time_left() != 0;
}

/*
	Name: timer_wait
	Namespace: util
	Checksum: 0x715E567E
	Offset: 0x5880
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function timer_wait(n_wait)
{
	if(isdefined(self.n_length))
	{
		n_wait = min(n_wait, get_time_left());
	}
	wait(n_wait);
	n_current_time = get_time_in_seconds();
	return n_current_time;
}

/*
	Name: is_primary_damage
	Namespace: util
	Checksum: 0xFFDCCFB6
	Offset: 0x58F0
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function is_primary_damage(meansofdeath)
{
	if(meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET")
	{
		return true;
	}
	return false;
}

/*
	Name: delete_on_death
	Namespace: util
	Checksum: 0x48D9BF8D
	Offset: 0x5930
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function delete_on_death(ent)
{
	ent endon(#"death");
	self waittill(#"death");
	if(isdefined(ent))
	{
		ent delete();
	}
}

/*
	Name: delete_on_death_or_notify
	Namespace: util
	Checksum: 0xF59A97A8
	Offset: 0x5990
	Size: 0xB4
	Parameters: 3
	Flags: None
*/
function delete_on_death_or_notify(e_to_delete, str_notify, str_clientfield = undefined)
{
	e_to_delete endon(#"death");
	self waittill_either("death", str_notify);
	if(isdefined(e_to_delete))
	{
		if(isdefined(str_clientfield))
		{
			e_to_delete clientfield::set(str_clientfield, 0);
			wait(0.1);
		}
		e_to_delete delete();
	}
}

/*
	Name: wait_till_not_touching
	Namespace: util
	Checksum: 0x783CB389
	Offset: 0x5A50
	Size: 0xA8
	Parameters: 2
	Flags: None
*/
function wait_till_not_touching(e_to_check, e_to_touch)
{
	/#
		assert(isdefined(e_to_check), "");
	#/
	/#
		assert(isdefined(e_to_touch), "");
	#/
	e_to_check endon(#"death");
	e_to_touch endon(#"death");
	while(e_to_check istouching(e_to_touch))
	{
		waitframe(1);
	}
}

/*
	Name: any_player_is_touching
	Namespace: util
	Checksum: 0x3E25D602
	Offset: 0x5B00
	Size: 0xD4
	Parameters: 2
	Flags: None
*/
function any_player_is_touching(ent, team)
{
	team = get_team_mapping(team);
	foreach(player in getplayers(team))
	{
		if(isalive(player) && player istouching(ent))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: set_console_status
	Namespace: util
	Checksum: 0xB3659573
	Offset: 0x5BE0
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function set_console_status()
{
	if(!isdefined(level.console))
	{
		level.console = getdvarstring(#"consolegame") == "true";
	}
	else
	{
		/#
			assert(level.console == getdvarstring(#"consolegame") == "", "");
		#/
	}
	if(!isdefined(level.consolexenon))
	{
		level.xenon = getdvarstring(#"xenongame") == "true";
	}
	else
	{
		/#
			assert(level.xenon == getdvarstring(#"xenongame") == "", "");
		#/
	}
}

/*
	Name: waittill_asset_loaded
	Namespace: util
	Checksum: 0x66FEC324
	Offset: 0x5D10
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function waittill_asset_loaded(str_type, str_name)
{
}

/*
	Name: script_wait
	Namespace: util
	Checksum: 0x77B0AB0B
	Offset: 0x5D30
	Size: 0x15A
	Parameters: 0
	Flags: Linked
*/
function script_wait()
{
	n_time = gettime();
	if(isdefined(self.script_wait))
	{
		wait(self.script_wait);
		if(isdefined(self.script_wait_add))
		{
			self.script_wait = self.script_wait + self.script_wait_add;
		}
	}
	n_min = (isdefined(self.script_wait_min) ? self.script_wait_min : 0);
	n_max = (isdefined(self.script_wait_max) ? self.script_wait_max : 0);
	if(n_max > n_min)
	{
		wait(randomfloatrange(n_min, n_max));
		self.script_wait_min = self.script_wait_min + (isdefined(self.script_wait_add) ? self.script_wait_add : 0);
		self.script_wait_max = self.script_wait_max + (isdefined(self.script_wait_add) ? self.script_wait_add : 0);
	}
	else if(n_min > 0)
	{
		wait(n_min);
		self.script_wait_min = self.script_wait_min + (isdefined(self.script_wait_add) ? self.script_wait_add : 0);
	}
	return gettime() - n_time;
}

/*
	Name: is_killstreaks_enabled
	Namespace: util
	Checksum: 0x5F5878CD
	Offset: 0x5E98
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function is_killstreaks_enabled()
{
	return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

/*
	Name: is_flashbanged
	Namespace: util
	Checksum: 0xC78BE403
	Offset: 0x5EC0
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function is_flashbanged()
{
	return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

/*
	Name: magic_bullet_shield
	Namespace: util
	Checksum: 0xBF29A377
	Offset: 0x5EE8
	Size: 0x116
	Parameters: 1
	Flags: Linked
*/
function magic_bullet_shield(ent = self)
{
	ent val::set(#"magic_bullet_shield", "allowdeath", 0);
	ent.magic_bullet_shield = 1;
	/#
		ent notify(#"_stop_magic_bullet_shield_debug");
		level thread debug_magic_bullet_shield_death(ent);
	#/
	/#
		assert(isalive(ent), "");
	#/
	if(isai(ent))
	{
		if(isactor(ent))
		{
			ent bloodimpact("hero");
		}
		ent.attackeraccuracy = 0.1;
	}
}

/*
	Name: debug_magic_bullet_shield_death
	Namespace: util
	Checksum: 0x432F9394
	Offset: 0x6008
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function debug_magic_bullet_shield_death(guy)
{
	targetname = "none";
	if(isdefined(guy.targetname))
	{
		targetname = guy.targetname;
	}
	guy endon(#"stop_magic_bullet_shield", #"_stop_magic_bullet_shield_debug");
	guy waittill(#"death");
	/#
		assert(!isdefined(guy), "" + targetname);
	#/
}

/*
	Name: spawn_player_clone
	Namespace: util
	Checksum: 0xA95C8DD2
	Offset: 0x60B8
	Size: 0x328
	Parameters: 4
	Flags: Linked
*/
function spawn_player_clone(player, animname, s_align, var_df23b31f = 0)
{
	playerclone = spawn("script_model", player.origin);
	playerclone.angles = player.angles;
	if(player function_390cb543())
	{
		var_1749f1e8 = player function_92ea4100();
		if(isdefined(var_1749f1e8))
		{
			playerclone setmodel(var_1749f1e8);
		}
		headmodel = player function_44a7328f();
		if(isdefined(headmodel))
		{
			playerclone attach(headmodel);
		}
	}
	else
	{
		var_41206ae3 = player function_5d23af5b();
		if(isdefined(var_41206ae3))
		{
			playerclone setmodel(var_41206ae3);
		}
		headmodel = player function_44a7328f();
		if(isdefined(headmodel))
		{
			playerclone attach(headmodel);
		}
		var_b4d88433 = player function_cde23658();
		if(isdefined(var_b4d88433))
		{
			playerclone attach(var_b4d88433);
		}
		var_1749f1e8 = player function_92ea4100();
		if(isdefined(var_1749f1e8))
		{
			playerclone attach(var_1749f1e8);
		}
	}
	playerclone setbodyrenderoptionspacked(player getcharacterbodyrenderoptions());
	if(var_df23b31f)
	{
		playerclone animation::attach_weapon(player getcurrentweapon());
	}
	playerclone useanimtree("all_player");
	if(isdefined(animname))
	{
		if(isdefined(s_align))
		{
			playerclone thread animation::play(animname, s_align);
		}
		else
		{
			playerclone thread animation::play(animname, playerclone.origin, playerclone.angles);
		}
	}
	playerclone.health = 100;
	playerclone setowner(player);
	playerclone.team = player.team;
	playerclone solid();
	return playerclone;
}

/*
	Name: stop_magic_bullet_shield
	Namespace: util
	Checksum: 0xAFA619DB
	Offset: 0x63E8
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function stop_magic_bullet_shield(ent = self)
{
	ent val::reset(#"magic_bullet_shield", "allowdeath");
	ent.magic_bullet_shield = undefined;
	if(isai(ent))
	{
		if(isactor(ent))
		{
			ent bloodimpact("normal");
		}
		ent.attackeraccuracy = 1;
	}
	ent notify(#"stop_magic_bullet_shield");
}

/*
	Name: get_rounds_won
	Namespace: util
	Checksum: 0xF92F10B9
	Offset: 0x64B0
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function get_rounds_won(team)
{
	team = get_team_mapping(team);
	return game.stat[#"roundswon"][team];
}

/*
	Name: within_fov
	Namespace: util
	Checksum: 0x8D0ADC34
	Offset: 0x6500
	Size: 0x90
	Parameters: 4
	Flags: Linked
*/
function within_fov(start_origin, start_angles, end_origin, fov)
{
	normal = vectornormalize(end_origin - start_origin);
	forward = anglestoforward(start_angles);
	dot = vectordot(forward, normal);
	return dot >= fov;
}

/*
	Name: button_held_think
	Namespace: util
	Checksum: 0x1D759826
	Offset: 0x6598
	Size: 0x16A
	Parameters: 1
	Flags: Linked
*/
function button_held_think(which_button)
{
	self endon(#"disconnect");
	if(!isdefined(self._holding_button))
	{
		self._holding_button = [];
	}
	self._holding_button[which_button] = 0;
	time_started = 0;
	while(true)
	{
		usinggamepad = self gamepadusedlast();
		use_time = (!usinggamepad ? 0 : 250);
		if(self._holding_button[which_button])
		{
			if(!self [[level._button_funcs[which_button]]]())
			{
				self._holding_button[which_button] = 0;
			}
		}
		else
		{
			if(self [[level._button_funcs[which_button]]]())
			{
				if(time_started == 0)
				{
					time_started = gettime();
				}
				if(gettime() - time_started > use_time)
				{
					self._holding_button[which_button] = 1;
				}
			}
			else if(time_started != 0)
			{
				time_started = 0;
			}
		}
		waitframe(1);
	}
}

/*
	Name: use_button_held
	Namespace: util
	Checksum: 0xDAAB5F8D
	Offset: 0x6710
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function use_button_held()
{
	init_button_wrappers();
	if(!isdefined(self._use_button_think_threaded))
	{
		self thread button_held_think(0);
		self._use_button_think_threaded = 1;
	}
	return self._holding_button[0];
}

/*
	Name: stance_button_held
	Namespace: util
	Checksum: 0x80A27A11
	Offset: 0x6768
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function stance_button_held()
{
	init_button_wrappers();
	if(!isdefined(self._stance_button_think_threaded))
	{
		self thread button_held_think(1);
		self._stance_button_think_threaded = 1;
	}
	return self._holding_button[1];
}

/*
	Name: ads_button_held
	Namespace: util
	Checksum: 0xBA46AAAC
	Offset: 0x67C8
	Size: 0x58
	Parameters: 0
	Flags: None
*/
function ads_button_held()
{
	init_button_wrappers();
	if(!isdefined(self._ads_button_think_threaded))
	{
		self thread button_held_think(2);
		self._ads_button_think_threaded = 1;
	}
	return self._holding_button[2];
}

/*
	Name: attack_button_held
	Namespace: util
	Checksum: 0xA019F0FA
	Offset: 0x6828
	Size: 0x58
	Parameters: 0
	Flags: None
*/
function attack_button_held()
{
	init_button_wrappers();
	if(!isdefined(self._attack_button_think_threaded))
	{
		self thread button_held_think(3);
		self._attack_button_think_threaded = 1;
	}
	return self._holding_button[3];
}

/*
	Name: button_right_held
	Namespace: util
	Checksum: 0xF69D1998
	Offset: 0x6888
	Size: 0x58
	Parameters: 0
	Flags: None
*/
function button_right_held()
{
	init_button_wrappers();
	if(!isdefined(self._dpad_right_button_think_threaded))
	{
		self thread button_held_think(6);
		self._dpad_right_button_think_threaded = 1;
	}
	return self._holding_button[6];
}

/*
	Name: waittill_use_button_pressed
	Namespace: util
	Checksum: 0x23A80C1
	Offset: 0x68E8
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_use_button_pressed()
{
	while(!self usebuttonpressed())
	{
		waitframe(1);
	}
}

/*
	Name: waittill_use_button_held
	Namespace: util
	Checksum: 0xC3E52C97
	Offset: 0x6918
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_use_button_held()
{
	while(!self use_button_held())
	{
		waitframe(1);
	}
}

/*
	Name: waittill_stance_button_pressed
	Namespace: util
	Checksum: 0xBEAA68D9
	Offset: 0x6948
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_stance_button_pressed()
{
	while(!self stancebuttonpressed())
	{
		waitframe(1);
	}
}

/*
	Name: waittill_stance_button_held
	Namespace: util
	Checksum: 0x5B352957
	Offset: 0x6978
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_stance_button_held()
{
	while(!self stance_button_held())
	{
		waitframe(1);
	}
}

/*
	Name: waittill_attack_button_pressed
	Namespace: util
	Checksum: 0xB436BD44
	Offset: 0x69A8
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_attack_button_pressed()
{
	while(!self attackbuttonpressed())
	{
		waitframe(1);
	}
}

/*
	Name: waittill_ads_button_pressed
	Namespace: util
	Checksum: 0xDD0A70AF
	Offset: 0x69D8
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_ads_button_pressed()
{
	while(!self adsbuttonpressed())
	{
		waitframe(1);
	}
}

/*
	Name: waittill_vehicle_move_up_button_pressed
	Namespace: util
	Checksum: 0x81662E75
	Offset: 0x6A08
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_vehicle_move_up_button_pressed()
{
	while(!self vehiclemoveupbuttonpressed())
	{
		waitframe(1);
	}
}

/*
	Name: init_button_wrappers
	Namespace: util
	Checksum: 0x9D0F27AA
	Offset: 0x6A38
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function init_button_wrappers()
{
	if(!isdefined(level._button_funcs))
	{
		level._button_funcs[0] = &usebuttonpressed;
		level._button_funcs[2] = &adsbuttonpressed;
		level._button_funcs[3] = &attackbuttonpressed;
		level._button_funcs[1] = &stancebuttonpressed;
		level._button_funcs[6] = &actionslotfourbuttonpressed;
		/#
			level._button_funcs[4] = &up_button_pressed;
			level._button_funcs[5] = &down_button_pressed;
		#/
	}
}

/*
	Name: up_button_held
	Namespace: util
	Checksum: 0x4302BD4D
	Offset: 0x6B40
	Size: 0x60
	Parameters: 0
	Flags: None
*/
function up_button_held()
{
	/#
		init_button_wrappers();
		if(!isdefined(self._up_button_think_threaded))
		{
			self thread button_held_think(4);
			self._up_button_think_threaded = 1;
		}
		return self._holding_button[4];
	#/
}

/*
	Name: down_button_held
	Namespace: util
	Checksum: 0x4BECA614
	Offset: 0x6BB0
	Size: 0x60
	Parameters: 0
	Flags: None
*/
function down_button_held()
{
	/#
		init_button_wrappers();
		if(!isdefined(self._down_button_think_threaded))
		{
			self thread button_held_think(5);
			self._down_button_think_threaded = 1;
		}
		return self._holding_button[5];
	#/
}

/*
	Name: up_button_pressed
	Namespace: util
	Checksum: 0x324BF539
	Offset: 0x6C20
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function up_button_pressed()
{
	/#
		return self buttonpressed("") || self buttonpressed("");
	#/
}

/*
	Name: waittill_up_button_pressed
	Namespace: util
	Checksum: 0xBB89CFD2
	Offset: 0x6C70
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_up_button_pressed()
{
	/#
		while(!self up_button_pressed())
		{
			waitframe(1);
		}
	#/
}

/*
	Name: down_button_pressed
	Namespace: util
	Checksum: 0x876A4B32
	Offset: 0x6CA0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function down_button_pressed()
{
	/#
		return self buttonpressed("") || self buttonpressed("");
	#/
}

/*
	Name: waittill_down_button_pressed
	Namespace: util
	Checksum: 0x54296540
	Offset: 0x6CF0
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_down_button_pressed()
{
	/#
		while(!self down_button_pressed())
		{
			waitframe(1);
		}
	#/
}

/*
	Name: ishacked
	Namespace: util
	Checksum: 0x7E5A6D
	Offset: 0x6D20
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function ishacked()
{
	return isdefined(self.hacked) && self.hacked || (isdefined(self.ishacked) && self.ishacked);
}

/*
	Name: function_fbce7263
	Namespace: util
	Checksum: 0x25A8F070
	Offset: 0x6D60
	Size: 0x86
	Parameters: 2
	Flags: Linked
*/
function function_fbce7263(team_a, team_b)
{
	if(team_a === team_b || function_9b7092ef(team_a, team_b))
	{
		return false;
	}
	if(!isdefined(team_a) || !isdefined(team_b))
	{
		return true;
	}
	if(function_b37afded(team_a, team_b))
	{
		return false;
	}
	return true;
}

/*
	Name: isenemyteam
	Namespace: util
	Checksum: 0x52BF3698
	Offset: 0x6DF0
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function isenemyteam(team)
{
	/#
		assert(isdefined(team));
	#/
	if(!isdefined(self))
	{
		return 0;
	}
	return function_fbce7263(team, self.team);
}

/*
	Name: function_4ded36e3
	Namespace: util
	Checksum: 0x96B06490
	Offset: 0x6E48
	Size: 0x80
	Parameters: 1
	Flags: None
*/
function function_4ded36e3(player)
{
	if(!isplayer(player) || !isdefined(self))
	{
		return 0;
	}
	if(level.teambased)
	{
		return !isenemyteam(player.team);
	}
	if(player == self)
	{
		return 1;
	}
	return 1;
}

/*
	Name: isenemyplayer
	Namespace: util
	Checksum: 0xB97107A8
	Offset: 0x6ED0
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function isenemyplayer(player)
{
	if(!isplayer(player) || !isdefined(self))
	{
		return 0;
	}
	if(level.teambased)
	{
		return isenemyteam(player.team);
	}
	if(player == self)
	{
		return 0;
	}
	return 1;
}

/*
	Name: waittillslowprocessallowed
	Namespace: util
	Checksum: 0xE67C5223
	Offset: 0x6F58
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function waittillslowprocessallowed()
{
	while(level.lastslowprocessframe == gettime())
	{
		waitframe(1);
	}
	level.lastslowprocessframe = gettime();
}

/*
	Name: function_1ea0b2ce
	Namespace: util
	Checksum: 0xB17824E9
	Offset: 0x6F90
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function function_1ea0b2ce()
{
	level.lastslowprocessframe = gettime();
}

/*
	Name: get_start_time
	Namespace: util
	Checksum: 0x52922ED5
	Offset: 0x6FB0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function get_start_time()
{
	return getmicrosecondsraw();
}

/*
	Name: note_elapsed_time
	Namespace: util
	Checksum: 0x558E6465
	Offset: 0x6FD0
	Size: 0xEC
	Parameters: 2
	Flags: None
*/
function note_elapsed_time(start_time, label = "unspecified")
{
	/#
		elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
		if(!isdefined(start_time))
		{
			return;
		}
		elapsed_time = elapsed_time * 0.001;
		if(!level.orbis)
		{
			elapsed_time = int(elapsed_time);
		}
		msg = ((label + "") + elapsed_time) + "";
		profileprintln(msg);
		iprintln(msg);
	#/
}

/*
	Name: record_elapsed_time
	Namespace: util
	Checksum: 0x77D0181F
	Offset: 0x70C8
	Size: 0x98
	Parameters: 2
	Flags: Linked
*/
function record_elapsed_time(start_time, elapsed_time_array)
{
	elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
	if(!isdefined(elapsed_time_array))
	{
		elapsed_time_array = [];
	}
	else if(!isarray(elapsed_time_array))
	{
		elapsed_time_array = array(elapsed_time_array);
	}
	elapsed_time_array[elapsed_time_array.size] = elapsed_time;
}

/*
	Name: note_elapsed_times
	Namespace: util
	Checksum: 0x1AFA6021
	Offset: 0x7168
	Size: 0x284
	Parameters: 2
	Flags: Linked
*/
function note_elapsed_times(elapsed_time_array, label = "unspecified")
{
	/#
		if(!isarray(elapsed_time_array))
		{
			return;
		}
		msg = (label + "") + elapsed_time_array.size;
		profileprintln(msg);
		if(elapsed_time_array.size == 0)
		{
			return;
		}
		total_elapsed_time = 0;
		smallest_elapsed_time = 2147483647;
		largest_elapsed_time = 0;
		foreach(elapsed_time in elapsed_time_array)
		{
			elapsed_time = elapsed_time * 0.001;
			total_elapsed_time = total_elapsed_time + elapsed_time;
			if(elapsed_time < smallest_elapsed_time)
			{
				smallest_elapsed_time = elapsed_time;
			}
			if(elapsed_time > largest_elapsed_time)
			{
				largest_elapsed_time = elapsed_time;
			}
			if(!level.orbis)
			{
				elapsed_time = int(elapsed_time);
			}
			msg = ((label + "") + elapsed_time) + "";
			profileprintln(msg);
		}
		average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
		msg = ((label + "") + average_elapsed_time) + "";
		profileprintln(msg);
		iprintln(msg);
		msg = ((label + "") + largest_elapsed_time) + "";
		profileprintln(msg);
		msg = ((label + "") + smallest_elapsed_time) + "";
		profileprintln(msg);
	#/
}

/*
	Name: get_elapsed_time
	Namespace: util
	Checksum: 0xE1B1E4F6
	Offset: 0x73F8
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function get_elapsed_time(start_time, end_time = getmicrosecondsraw())
{
	if(!isdefined(start_time))
	{
		return undefined;
	}
	elapsed_time = end_time - start_time;
	if(elapsed_time < 0)
	{
		elapsed_time = elapsed_time + -2147483648;
	}
	return elapsed_time;
}

/*
	Name: note_raw_time
	Namespace: util
	Checksum: 0xFACD12E2
	Offset: 0x7470
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function note_raw_time(label = "unspecified")
{
	now = getmicrosecondsraw();
	msg = ("us = " + now) + (" -- ") + label;
	profileprintln(msg);
}

/*
	Name: mayapplyscreeneffect
	Namespace: util
	Checksum: 0x41CC99ED
	Offset: 0x74F8
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function mayapplyscreeneffect()
{
	/#
		assert(isdefined(self));
	#/
	/#
		assert(isplayer(self));
	#/
	return !isdefined(self.viewlockedentity);
}

/*
	Name: waittillnotmoving
	Namespace: util
	Checksum: 0x6640DED3
	Offset: 0x7550
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function waittillnotmoving()
{
	if(self ishacked())
	{
		waitframe(1);
		return;
	}
	if(self.classname == "grenade")
	{
		self waittill(#"stationary");
	}
	else
	{
		prevorigin = self.origin;
		while(true)
		{
			wait(0.15);
			if(self.origin == prevorigin)
			{
				break;
			}
			prevorigin = self.origin;
		}
	}
}

/*
	Name: waittillrollingornotmoving
	Namespace: util
	Checksum: 0x75A31A7E
	Offset: 0x75F8
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function waittillrollingornotmoving()
{
	if(self ishacked())
	{
		waitframe(1);
		return "stationary";
	}
	movestate = undefined;
	movestate = self waittill(#"stationary", #"rolling");
	return movestate._notify;
}

/*
	Name: getweaponclass
	Namespace: util
	Checksum: 0x240B1C74
	Offset: 0x7670
	Size: 0x142
	Parameters: 1
	Flags: Linked
*/
function getweaponclass(weapon)
{
	if(weapon == level.weaponnone)
	{
		return undefined;
	}
	if(!weapon.isvalid)
	{
		return undefined;
	}
	if(!isdefined(level.weaponclassarray))
	{
		level.weaponclassarray = [];
	}
	if(isdefined(level.weaponclassarray[weapon.name]))
	{
		return level.weaponclassarray[weapon.name];
	}
	baseweaponparam = weapons::getbaseweapon(weapon);
	baseweaponindex = getbaseweaponitemindex(baseweaponparam);
	weaponclass = #"";
	weaponinfo = getunlockableiteminfofromindex(baseweaponindex, 1);
	if(isdefined(weaponinfo))
	{
		weaponclass = weaponinfo.itemgroupname;
	}
	level.weaponclassarray[weapon.name] = weaponclass;
	return weaponclass;
}

/*
	Name: function_56353fe9
	Namespace: util
	Checksum: 0x810B89EC
	Offset: 0x77C0
	Size: 0x56
	Parameters: 1
	Flags: None
*/
function function_56353fe9(weaponname)
{
	weapon = getweapon(weaponname);
	if(!isdefined(weapon) || weapon == level.weaponnone)
	{
		return undefined;
	}
	return weapon;
}

/*
	Name: isusingremote
	Namespace: util
	Checksum: 0x1F603C12
	Offset: 0x7820
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function isusingremote()
{
	return isdefined(self.usingremote);
}

/*
	Name: function_63d27d4e
	Namespace: util
	Checksum: 0x9060EC7D
	Offset: 0x7838
	Size: 0x18
	Parameters: 1
	Flags: None
*/
function function_63d27d4e(remotename)
{
	return self.usingremote === remotename;
}

/*
	Name: setusingremote
	Namespace: util
	Checksum: 0x22BD76D8
	Offset: 0x7858
	Size: 0xC6
	Parameters: 2
	Flags: None
*/
function setusingremote(remotename, set_killstreak_delay_killcam = !sessionmodeiszombiesgame())
{
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 0;
	}
	/#
		assert(!self isusingremote());
	#/
	self.usingremote = remotename;
	if(set_killstreak_delay_killcam)
	{
		self.killstreak_delay_killcam = remotename;
	}
	self disableoffhandweapons();
	self notify(#"using_remote");
}

/*
	Name: function_9a39538a
	Namespace: util
	Checksum: 0x84D579C3
	Offset: 0x7928
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function function_9a39538a()
{
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 1;
	}
	self.usingremote = undefined;
	self enableoffhandweapons();
	self.killstreak_delay_killcam = undefined;
	self notify(#"stopped_using_remote");
}

/*
	Name: deleteaftertime
	Namespace: util
	Checksum: 0x7282D442
	Offset: 0x7988
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function deleteaftertime(time)
{
	/#
		assert(isdefined(self));
	#/
	/#
		assert(isdefined(time));
	#/
	/#
		assert(time >= 0.05);
	#/
	self thread deleteaftertimethread(time);
}

/*
	Name: deleteaftertimethread
	Namespace: util
	Checksum: 0xA1232A4D
	Offset: 0x7A08
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function deleteaftertimethread(time)
{
	self endon(#"death");
	wait(time);
	self delete();
}

/*
	Name: waitfortime
	Namespace: util
	Checksum: 0x63A81D70
	Offset: 0x7A50
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function waitfortime(time = 0)
{
	if(time > 0)
	{
		wait(time);
	}
}

/*
	Name: waitfortimeandnetworkframe
	Namespace: util
	Checksum: 0x9223B43F
	Offset: 0x7A90
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function waitfortimeandnetworkframe(time = 0)
{
	start_time_ms = gettime();
	wait_network_frame();
	elapsed_time = (gettime() - start_time_ms) * 0.001;
	remaining_time = time - elapsed_time;
	if(remaining_time > 0)
	{
		wait(remaining_time);
	}
}

/*
	Name: deleteaftertimeandnetworkframe
	Namespace: util
	Checksum: 0xE309EF26
	Offset: 0x7B18
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function deleteaftertimeandnetworkframe(time)
{
	/#
		assert(isdefined(self));
	#/
	waitfortimeandnetworkframe(time);
	self delete();
}

/*
	Name: drawcylinder
	Namespace: util
	Checksum: 0x2FFD2F4E
	Offset: 0x7B78
	Size: 0x7C
	Parameters: 7
	Flags: None
*/
function drawcylinder(pos, rad, height, duration, stop_notify, color, alpha)
{
	/#
		if(!isdefined(duration))
		{
			duration = 0;
		}
		level thread drawcylinder_think(pos, rad, height, duration, stop_notify, color, alpha);
	#/
}

/*
	Name: drawcylinder_think
	Namespace: util
	Checksum: 0xBF72D5B8
	Offset: 0x7C00
	Size: 0x2F8
	Parameters: 7
	Flags: None
*/
function drawcylinder_think(pos, rad, height, seconds, stop_notify, color, alpha)
{
	/#
		if(isdefined(stop_notify))
		{
			level endon(stop_notify);
		}
		stop_time = gettime() + (int(seconds * 1000));
		currad = rad;
		curheight = height;
		if(!isdefined(color))
		{
			color = (1, 1, 1);
		}
		if(!isdefined(alpha))
		{
			alpha = 1;
		}
		for(;;)
		{
			if(seconds > 0 && stop_time <= gettime())
			{
				return;
			}
			for(r = 0; r < 20; r++)
			{
				theta = (r / 20) * 360;
				theta2 = ((r + 1) / 20) * 360;
				line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, alpha);
				line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, alpha);
				line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, alpha);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: spawn_array_struct
	Namespace: util
	Checksum: 0xB56A42D1
	Offset: 0x7F00
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function spawn_array_struct()
{
	s = spawnstruct();
	s.a = [];
	return s;
}

/*
	Name: gethostplayer
	Namespace: util
	Checksum: 0xF768BFB4
	Offset: 0x7F38
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function gethostplayer()
{
	players = getplayers();
	foreach(player in players)
	{
		if(player ishost())
		{
			return player;
		}
	}
}

/*
	Name: gethostplayerforbots
	Namespace: util
	Checksum: 0x52754EDC
	Offset: 0x7FD8
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function gethostplayerforbots()
{
	players = getplayers();
	for(index = 0; index < players.size; index++)
	{
		if(players[index] ishostforbots())
		{
			return players[index];
		}
	}
}

/*
	Name: get_array_of_closest
	Namespace: util
	Checksum: 0x139F8E62
	Offset: 0x8050
	Size: 0x2F0
	Parameters: 5
	Flags: Linked
*/
function get_array_of_closest(org, array, excluders = [], max = array.size, maxdist)
{
	maxdists2rd = undefined;
	if(isdefined(maxdist))
	{
		maxdists2rd = maxdist * maxdist;
	}
	dist = [];
	index = [];
	for(i = 0; i < array.size; i++)
	{
		if(!isdefined(array[i]))
		{
			continue;
		}
		if(isinarray(excluders, array[i]))
		{
			continue;
		}
		if(isvec(array[i]))
		{
			length = distancesquared(org, array[i]);
		}
		else
		{
			length = distancesquared(org, array[i].origin);
		}
		if(isdefined(maxdists2rd) && maxdists2rd < length)
		{
			continue;
		}
		dist[dist.size] = length;
		index[index.size] = i;
	}
	for(;;)
	{
		change = 0;
		for(i = 0; i < dist.size - 1; i++)
		{
			if(dist[i] <= (dist[i + 1]))
			{
				continue;
			}
			change = 1;
			temp = dist[i];
			dist[i] = dist[i + 1];
			dist[i + 1] = temp;
			temp = index[i];
			index[i] = index[i + 1];
			index[i + 1] = temp;
		}
		if(!change)
		{
			break;
		}
	}
	newarray = [];
	if(max > dist.size)
	{
		max = dist.size;
	}
	for(i = 0; i < max; i++)
	{
		newarray[i] = array[index[i]];
	}
	return newarray;
}

/*
	Name: set_lighting_state
	Namespace: util
	Checksum: 0x6CDAED58
	Offset: 0x8348
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function set_lighting_state(n_state)
{
	if(isdefined(n_state))
	{
		self.lighting_state = n_state;
	}
	else
	{
		self.lighting_state = level.lighting_state;
	}
	if(isdefined(self.lighting_state))
	{
		if(self == level)
		{
			if(isdefined(level.activeplayers))
			{
				foreach(player in level.activeplayers)
				{
					player set_lighting_state(level.lighting_state);
				}
			}
		}
		else
		{
			if(isplayer(self))
			{
				self setlightingstate(self.lighting_state);
			}
			else
			{
				/#
					assertmsg("");
				#/
			}
		}
	}
}

/*
	Name: set_sun_shadow_split_distance
	Namespace: util
	Checksum: 0xB14A3819
	Offset: 0x8490
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function set_sun_shadow_split_distance(f_distance)
{
	if(isdefined(f_distance))
	{
		self.sun_shadow_split_distance = f_distance;
	}
	else
	{
		self.sun_shadow_split_distance = level.sun_shadow_split_distance;
	}
	if(isdefined(self.sun_shadow_split_distance))
	{
		if(self == level)
		{
			if(isdefined(level.activeplayers))
			{
				foreach(player in level.activeplayers)
				{
					player set_sun_shadow_split_distance(level.sun_shadow_split_distance);
				}
			}
		}
		else
		{
			if(isplayer(self))
			{
				self setsunshadowsplitdistance(self.sun_shadow_split_distance);
			}
			else
			{
				/#
					assertmsg("");
				#/
			}
		}
	}
}

/*
	Name: function_7f49ffb7
	Namespace: util
	Checksum: 0x4D1D4FB4
	Offset: 0x85D8
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_7f49ffb7(var_bf01552a)
{
	if(!isdefined(level.var_bf01552a))
	{
		level.var_bf01552a = -1;
	}
	if(isdefined(var_bf01552a))
	{
		self.var_bf01552a = var_bf01552a;
	}
	else
	{
		self.var_bf01552a = level.var_bf01552a;
	}
	if(isdefined(self.var_bf01552a))
	{
		if(self == level)
		{
			if(isdefined(level.activeplayers))
			{
				foreach(player in level.activeplayers)
				{
					player function_7f49ffb7(level.var_bf01552a);
				}
			}
		}
		else
		{
			if(isplayer(self))
			{
				self function_61471b4a(self.var_bf01552a);
			}
			else
			{
				/#
					assertmsg("");
				#/
			}
		}
	}
}

/*
	Name: auto_delete
	Namespace: util
	Checksum: 0x4335C58E
	Offset: 0x8740
	Size: 0x52A
	Parameters: 4
	Flags: Linked
*/
function auto_delete(n_mode = 1, n_min_time_alive = 0, n_dist_horizontal = 0, n_dist_vertical = 0)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death", #"hash_375a9d48dd6a9427");
	self notify(#"__auto_delete__");
	self endon(#"__auto_delete__");
	level flag::wait_till("all_players_spawned");
	if(isdefined(level.heroes) && isinarray(level.heroes, self))
	{
		return;
	}
	if(isplayer(self))
	{
		return;
	}
	if(n_mode & 16 || n_mode == 1 || n_mode == 8)
	{
		n_mode = n_mode | 2;
		n_mode = n_mode | 4;
	}
	n_think_time = 1;
	n_tests_to_do = 2;
	n_dot_check = 0;
	if(n_mode & 16)
	{
		n_think_time = 0.2;
		n_tests_to_do = 1;
		n_dot_check = 0.4;
	}
	n_test_count = 0;
	n_dist_horizontal_sq = n_dist_horizontal * n_dist_horizontal;
	while(true)
	{
		do
		{
			wait(randomfloatrange(n_think_time - (n_think_time / 3), n_think_time + (n_think_time / 3)));
		}
		while(isdefined(self.birthtime) && ((float(gettime() - self.birthtime)) / 1000) < n_min_time_alive);
		n_tests_passed = 0;
		foreach(player in level.players)
		{
			if(isbot(player))
			{
				n_tests_passed++;
				continue;
			}
			if(n_dist_horizontal && distance2dsquared(self.origin, player.origin) < n_dist_horizontal_sq)
			{
				continue;
			}
			if(n_dist_vertical && (abs(self.origin[2] - player.origin[2])) < n_dist_vertical)
			{
				continue;
			}
			v_eye = player getplayercamerapos();
			b_behind = 0;
			if(n_mode & 2)
			{
				v_facing = anglestoforward(player getplayerangles());
				v_to_ent = vectornormalize(self.origin - v_eye);
				n_dot = vectordot(v_facing, v_to_ent);
				if(n_dot < n_dot_check)
				{
					b_behind = 1;
					if(!n_mode & 1)
					{
						n_tests_passed++;
						continue;
					}
				}
			}
			if(n_mode & 4)
			{
				if(!self sightconetrace(v_eye, (isdefined(player getvehicleoccupied()) ? player getvehicleoccupied() : player)))
				{
					if(b_behind || !n_mode & 1)
					{
						n_tests_passed++;
					}
				}
			}
		}
		if(n_tests_passed == level.players.size)
		{
			n_test_count++;
			if(n_test_count < n_tests_to_do)
			{
				continue;
			}
			self notify(#"_disable_reinforcement");
			self delete();
		}
		else
		{
			n_test_count = 0;
		}
	}
}

/*
	Name: query_ents
	Namespace: util
	Checksum: 0xCB1C1338
	Offset: 0x8C78
	Size: 0x436
	Parameters: 5
	Flags: None
*/
function query_ents(a_kvps_match, b_match_all = 1, a_kvps_ingnore, b_ignore_spawners = 0, b_match_substrings = 0)
{
	a_ret = [];
	if(b_match_substrings)
	{
		a_all_ents = arraycombine(getentarray(), level.struct, 0, 0);
		b_first = 1;
		foreach(v in a_kvps_match)
		{
			a_ents = _query_ents_by_substring_helper(a_all_ents, v.value, v.key, b_ignore_spawners);
			if(b_first)
			{
				a_ret = a_ents;
				b_first = 0;
				continue;
			}
			if(b_match_all)
			{
				a_ret = arrayintersect(a_ret, a_ents);
				continue;
			}
			a_ret = arraycombine(a_ret, a_ents, 0, 0);
		}
		if(isdefined(a_kvps_ingnore))
		{
			foreach(k, v in a_kvps_ingnore)
			{
				a_ents = _query_ents_by_substring_helper(a_all_ents, v, k, b_ignore_spawners);
				a_ret = array::exclude(a_ret, a_ents);
			}
		}
	}
	else
	{
		b_first = 1;
		foreach(v in a_kvps_match)
		{
			a_ents = arraycombine(getentarray(v.value, v.key, b_ignore_spawners), struct::get_array(v.value, v.key), 0, 0);
			if(b_first)
			{
				a_ret = a_ents;
				b_first = 0;
				continue;
			}
			if(b_match_all)
			{
				a_ret = arrayintersect(a_ret, a_ents);
				continue;
			}
			a_ret = arraycombine(a_ret, a_ents, 0, 0);
		}
		if(isdefined(a_kvps_ingnore))
		{
			foreach(k, v in a_kvps_ingnore)
			{
				a_ents = arraycombine(getentarray(v, k, b_ignore_spawners), struct::get_array(v, k), 0, 0);
				a_ret = array::exclude(a_ret, a_ents);
			}
		}
	}
	return a_ret;
}

/*
	Name: _query_ents_by_substring_helper
	Namespace: util
	Checksum: 0xCD1467E0
	Offset: 0x90B8
	Size: 0x170
	Parameters: 4
	Flags: Linked
*/
function _query_ents_by_substring_helper(a_ents, str_value, str_key = "targetname", b_ignore_spawners = 0)
{
	a_ret = [];
	foreach(ent in a_ents)
	{
		if(b_ignore_spawners && isspawner(ent))
		{
			continue;
		}
		if(isstring(ent.(str_key)) && issubstr(ent.(str_key), str_value))
		{
			if(!isdefined(a_ret))
			{
				a_ret = [];
			}
			else if(!isarray(a_ret))
			{
				a_ret = array(a_ret);
			}
			a_ret[a_ret.size] = ent;
		}
	}
	return a_ret;
}

/*
	Name: get_weapon_by_name
	Namespace: util
	Checksum: 0xAE7C1EF9
	Offset: 0x9230
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function get_weapon_by_name(weapon_name, var_2f3a032e)
{
	split = [];
	if("" != var_2f3a032e)
	{
		split = strtok(var_2f3a032e, "+");
	}
	if(split.size)
	{
		weapon = getweapon(weapon_name, split);
	}
	else
	{
		weapon = getweapon(weapon_name);
	}
	return weapon;
}

/*
	Name: function_2146bd83
	Namespace: util
	Checksum: 0x44ED928
	Offset: 0x92E0
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function function_2146bd83(weapon)
{
	var_2f3a032e = "";
	for(i = 0; i < weapon.attachments.size; i++)
	{
		if(!i)
		{
			var_2f3a032e = var_2f3a032e + ("+");
		}
		var_2f3a032e = var_2f3a032e + weapon.attachments[i];
	}
	return var_2f3a032e;
}

/*
	Name: function_4c1656d5
	Namespace: util
	Checksum: 0x9191D7A9
	Offset: 0x9368
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_4c1656d5()
{
	if(sessionmodeiswarzonegame())
	{
		return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
	}
	return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

/*
	Name: function_16fb0a3b
	Namespace: util
	Checksum: 0x1CC41B54
	Offset: 0x93E0
	Size: 0x122
	Parameters: 0
	Flags: Linked
*/
function function_16fb0a3b()
{
	if(sessionmodeiswarzonegame())
	{
		if(getdvarint(#"hash_23a1d3a9139af42b", 0) > 0)
		{
			return getdvarfloat(#"hash_608e7bb0e9517884", 250);
		}
		return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
	}
	if(getdvarint(#"hash_23fac9a913e70c03", 0) > 0)
	{
		return getdvarfloat(#"hash_606c79b0e9348eb8", 250);
	}
	return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

/*
	Name: is_female
	Namespace: util
	Checksum: 0x1AF84D4E
	Offset: 0x9510
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function is_female()
{
	gender = self getplayergendertype(currentsessionmode());
	b_female = 0;
	if(isdefined(gender) && gender == "female")
	{
		b_female = 1;
	}
	return b_female;
}

/*
	Name: positionquery_pointarray
	Namespace: util
	Checksum: 0x4C15EE15
	Offset: 0x9588
	Size: 0x168
	Parameters: 6
	Flags: None
*/
function positionquery_pointarray(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent)
{
	if(isdefined(reachableby_ent))
	{
		queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent);
	}
	else
	{
		queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing);
	}
	pointarray = [];
	foreach(pointstruct in queryresult.data)
	{
		if(!isdefined(pointarray))
		{
			pointarray = [];
		}
		else if(!isarray(pointarray))
		{
			pointarray = array(pointarray);
		}
		pointarray[pointarray.size] = pointstruct.origin;
	}
	return pointarray;
}

/*
	Name: totalplayercount
	Namespace: util
	Checksum: 0xE6D59C51
	Offset: 0x96F8
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function totalplayercount()
{
	count = 0;
	foreach(team, _ in level.teams)
	{
		count = count + level.playercount[team];
	}
	return count;
}

/*
	Name: isrankenabled
	Namespace: util
	Checksum: 0x1C3014D1
	Offset: 0x9798
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function isrankenabled()
{
	return isdefined(level.rankenabled) && level.rankenabled;
}

/*
	Name: isoneround
	Namespace: util
	Checksum: 0xE1D9D4A2
	Offset: 0x97C0
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function isoneround()
{
	if(level.roundlimit == 1)
	{
		return true;
	}
	return false;
}

/*
	Name: isfirstround
	Namespace: util
	Checksum: 0x47C1916C
	Offset: 0x97E8
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function isfirstround()
{
	if(game.roundsplayed == 0)
	{
		return true;
	}
	return false;
}

/*
	Name: islastround
	Namespace: util
	Checksum: 0xAE4A5D5D
	Offset: 0x9810
	Size: 0x40
	Parameters: 0
	Flags: None
*/
function islastround()
{
	if(level.roundlimit > 1 && game.roundsplayed >= (level.roundlimit - 1))
	{
		return true;
	}
	return false;
}

/*
	Name: waslastround
	Namespace: util
	Checksum: 0x3CFAC104
	Offset: 0x9858
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function waslastround()
{
	if(level.forcedend)
	{
		return true;
	}
	if(isdefined(level.nextroundisovertime))
	{
		if(level.nextroundisovertime)
		{
			level.nextroundisovertime = 1;
			return false;
		}
		if(isdefined(game.overtime_round) && game.overtime_round > 0)
		{
			return true;
		}
	}
	if(hitroundlimit() || hitscorelimit() || hitroundwinlimit())
	{
		return true;
	}
	return false;
}

/*
	Name: hitroundlimit
	Namespace: util
	Checksum: 0x4D3E5C6C
	Offset: 0x9928
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function hitroundlimit()
{
	if(level.roundlimit <= 0)
	{
		return 0;
	}
	return getroundsplayed() >= level.roundlimit;
}

/*
	Name: anyteamhitroundwinlimit
	Namespace: util
	Checksum: 0xA89BDF4
	Offset: 0x9968
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function anyteamhitroundwinlimit()
{
	foreach(team, _ in level.teams)
	{
		if(getroundswon(team) >= level.roundwinlimit)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: anyteamhitroundlimitwithdraws
	Namespace: util
	Checksum: 0xC8443772
	Offset: 0x9A08
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function anyteamhitroundlimitwithdraws()
{
	tie_wins = game.stat[#"roundswon"][#"tie"];
	foreach(team, _ in level.teams)
	{
		if((getroundswon(team) + tie_wins) >= level.roundwinlimit)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_385658da
	Namespace: util
	Checksum: 0xF8A8A217
	Offset: 0x9AE0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_385658da()
{
	count = 0;
	foreach(team, _ in level.teams)
	{
		wins = getroundswon(team);
		if(!isdefined(count))
		{
			count = wins;
			continue;
		}
		if(wins != count)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: hitroundwinlimit
	Namespace: util
	Checksum: 0x318680C4
	Offset: 0x9BA8
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function hitroundwinlimit()
{
	if(!isdefined(level.roundwinlimit) || level.roundwinlimit <= 0)
	{
		return false;
	}
	if(anyteamhitroundwinlimit())
	{
		return true;
	}
	if(anyteamhitroundlimitwithdraws())
	{
		if(!function_385658da())
		{
			return true;
		}
	}
	return false;
}

/*
	Name: any_team_hit_score_limit
	Namespace: util
	Checksum: 0xB8EFB131
	Offset: 0x9C28
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function any_team_hit_score_limit()
{
	foreach(team, _ in level.teams)
	{
		if(game.stat[#"teamscores"][team] >= level.scorelimit)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: hitscorelimit
	Namespace: util
	Checksum: 0xEF52D445
	Offset: 0x9CC8
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function hitscorelimit()
{
	if(level.scoreroundwinbased)
	{
		return false;
	}
	if(level.scorelimit <= 0)
	{
		return false;
	}
	if(level.teambased)
	{
		if(any_team_hit_score_limit())
		{
			return true;
		}
	}
	else
	{
		for(i = 0; i < level.players.size; i++)
		{
			player = level.players[i];
			if(isdefined(player.pointstowin) && player.pointstowin >= level.scorelimit)
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: get_current_round_score_limit
	Namespace: util
	Checksum: 0xB7A18709
	Offset: 0x9DA0
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function get_current_round_score_limit()
{
	return level.roundscorelimit * (game.roundsplayed + 1);
}

/*
	Name: any_team_hit_round_score_limit
	Namespace: util
	Checksum: 0x12AA06C7
	Offset: 0x9DC8
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function any_team_hit_round_score_limit()
{
	round_score_limit = get_current_round_score_limit();
	foreach(team, _ in level.teams)
	{
		if(game.stat[#"teamscores"][team] >= round_score_limit)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: hitroundscorelimit
	Namespace: util
	Checksum: 0x76EF19B1
	Offset: 0x9E80
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function hitroundscorelimit()
{
	if(level.roundscorelimit <= 0)
	{
		return false;
	}
	if(level.teambased)
	{
		if(any_team_hit_round_score_limit())
		{
			return true;
		}
	}
	else
	{
		roundscorelimit = get_current_round_score_limit();
		for(i = 0; i < level.players.size; i++)
		{
			player = level.players[i];
			if(isdefined(player.pointstowin) && player.pointstowin >= roundscorelimit)
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: getroundswon
	Namespace: util
	Checksum: 0x5F55D3FF
	Offset: 0x9F68
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function getroundswon(team)
{
	team = get_team_mapping(team);
	return game.stat[#"roundswon"][team];
}

/*
	Name: getotherteamsroundswon
	Namespace: util
	Checksum: 0xC38BBE93
	Offset: 0x9FB8
	Size: 0xE4
	Parameters: 1
	Flags: None
*/
function getotherteamsroundswon(str_skip_team)
{
	str_skip_team = get_team_mapping(str_skip_team);
	roundswon = 0;
	if(!isdefined(str_skip_team))
	{
		return roundswon;
	}
	foreach(team, _ in level.teams)
	{
		if(team === str_skip_team)
		{
			continue;
		}
		roundswon = roundswon + game.stat[#"roundswon"][team];
	}
	return roundswon;
}

/*
	Name: getroundsplayed
	Namespace: util
	Checksum: 0x8B24CB58
	Offset: 0xA0A8
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function getroundsplayed()
{
	return game.roundsplayed;
}

/*
	Name: isroundbased
	Namespace: util
	Checksum: 0x8454631
	Offset: 0xA0C0
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function isroundbased()
{
	if(level.roundlimit != 1 && level.roundwinlimit != 1)
	{
		return true;
	}
	return false;
}

/*
	Name: getcurrentgamemode
	Namespace: util
	Checksum: 0xE1817448
	Offset: 0xA100
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function getcurrentgamemode()
{
	if(gamemodeismode(6))
	{
		return "leaguematch";
	}
	return "publicmatch";
}

/*
	Name: function_97cf7eb0
	Namespace: util
	Checksum: 0x38AB7CA0
	Offset: 0xA138
	Size: 0x194
	Parameters: 6
	Flags: Linked
*/
function function_97cf7eb0(v_start, n_max_dist = 5000, n_ground_offset = 0, e_ignore, b_ignore_water = 0, b_ignore_glass = 0)
{
	v_trace_start = v_start + (0, 0, 5);
	v_trace_end = v_trace_start + (0, 0, (n_max_dist + 5) * -1);
	a_trace = groundtrace(v_trace_start, v_trace_end, 0, e_ignore, b_ignore_water, b_ignore_glass);
	if(a_trace[#"surfacetype"] != "none")
	{
		return {#entity:a_trace[#"entity"], #position:a_trace[#"position"] + (0, 0, n_ground_offset)};
	}
	return {#entity:a_trace[#"entity"], #position:v_start};
}

/*
	Name: ground_position
	Namespace: util
	Checksum: 0x222A5A8D
	Offset: 0xA2D8
	Size: 0x9A
	Parameters: 6
	Flags: Linked
*/
function ground_position(v_start, n_max_dist = 5000, n_ground_offset = 0, e_ignore, b_ignore_water = 0, b_ignore_glass = 0)
{
	return function_97cf7eb0(v_start, n_max_dist, n_ground_offset, e_ignore, b_ignore_water, b_ignore_glass).position;
}

/*
	Name: delayed_notify
	Namespace: util
	Checksum: 0xD2C7EA75
	Offset: 0xA380
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function delayed_notify(str_notify, f_delay_seconds)
{
	wait(f_delay_seconds);
	if(isdefined(self))
	{
		self notify(str_notify);
	}
}

/*
	Name: delayed_delete
	Namespace: util
	Checksum: 0xCA5C24DC
	Offset: 0xA3B8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function delayed_delete(f_delay_seconds)
{
	/#
		assert(isentity(self));
	#/
	wait(f_delay_seconds);
	if(isdefined(self) && isentity(self))
	{
		self delete();
	}
}

/*
	Name: is_safehouse
	Namespace: util
	Checksum: 0x8EAA75DF
	Offset: 0xA430
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function is_safehouse()
{
	mapname = get_map_name();
	return false;
}

/*
	Name: is_new_cp_map
	Namespace: util
	Checksum: 0x4E0AADE
	Offset: 0xA458
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function is_new_cp_map()
{
	mapname = get_map_name();
	switch(mapname)
	{
		default:
		{
			return false;
		}
	}
}

/*
	Name: add_queued_debug_command
	Namespace: util
	Checksum: 0xED1BB8A2
	Offset: 0xA4B0
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function add_queued_debug_command(cmd)
{
	/#
		if(!isdefined(level.dbg_cmd_queue))
		{
			level thread queued_debug_commands();
		}
		if(isdefined(level.dbg_cmd_queue))
		{
			array::push(level.dbg_cmd_queue, cmd);
		}
	#/
}

/*
	Name: queued_debug_commands
	Namespace: util
	Checksum: 0x55430C35
	Offset: 0xA520
	Size: 0x17A
	Parameters: 0
	Flags: None
*/
function queued_debug_commands()
{
	/#
		self notify(#"queued_debug_commands");
		self endon(#"queued_debug_commands");
		if(!isdefined(level.dbg_cmd_queue))
		{
			level.dbg_cmd_queue = [];
		}
		while(true)
		{
			waitframe(1);
			if(!isdefined(game.state))
			{
				continue;
			}
			if(game.state == "")
			{
				continue;
			}
			if(level.dbg_cmd_queue.size == 0)
			{
				level.dbg_cmd_queue = undefined;
				return;
			}
			trickle = 0;
			if(level.players.size > 1)
			{
				trickle = 1;
				var_1085858 = 12;
			}
			while(!trickle || var_1085858 > 0 && canadddebugcommand() && level.dbg_cmd_queue.size > 0)
			{
				cmd = array::pop_front(level.dbg_cmd_queue, 0);
				adddebugcommand(cmd);
				if(trickle)
				{
					var_1085858--;
				}
			}
		}
	#/
}

/*
	Name: array_copy_if_array
	Namespace: util
	Checksum: 0x5A23BFC6
	Offset: 0xA6A8
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function array_copy_if_array(any_var)
{
	return (isarray(any_var) ? arraycopy(any_var) : any_var);
}

/*
	Name: is_item_purchased
	Namespace: util
	Checksum: 0xF46BE649
	Offset: 0xA6F8
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function is_item_purchased(ref)
{
	itemindex = getitemindexfromref(ref);
	return (itemindex >= 256 ? 0 : self isitempurchased(itemindex));
}

/*
	Name: has_purchased_perk_equipped
	Namespace: util
	Checksum: 0x3C5EDA80
	Offset: 0xA768
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function has_purchased_perk_equipped(ref)
{
	return self hasperk(ref) && self is_item_purchased(ref);
}

/*
	Name: has_purchased_perk_equipped_with_specific_stat
	Namespace: util
	Checksum: 0xB47B25B9
	Offset: 0xA7B0
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function has_purchased_perk_equipped_with_specific_stat(single_perk_ref, stats_table_ref)
{
	if(isplayer(self))
	{
		return self hasperk(single_perk_ref) && self is_item_purchased(stats_table_ref);
	}
	return 0;
}

/*
	Name: has_flak_jacket_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0xD8750ED
	Offset: 0xA820
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function has_flak_jacket_perk_purchased_and_equipped()
{
	return has_purchased_perk_equipped(#"specialty_flakjacket");
}

/*
	Name: has_blind_eye_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0x804998CB
	Offset: 0xA850
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function has_blind_eye_perk_purchased_and_equipped()
{
	return self has_purchased_perk_equipped_with_specific_stat(#"specialty_nottargetedbyairsupport", #"hash_1989bed2fa3c7b67");
}

/*
	Name: has_ghost_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0xC56F893A
	Offset: 0xA890
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function has_ghost_perk_purchased_and_equipped()
{
	return has_purchased_perk_equipped(#"specialty_gpsjammer");
}

/*
	Name: has_tactical_mask_purchased_and_equipped
	Namespace: util
	Checksum: 0x5F9006
	Offset: 0xA8C0
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function has_tactical_mask_purchased_and_equipped()
{
	return self has_purchased_perk_equipped_with_specific_stat(#"specialty_stunprotection", #"hash_18d73d37c73a8114");
}

/*
	Name: has_hacker_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0x68F03ED9
	Offset: 0xA900
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function has_hacker_perk_purchased_and_equipped()
{
	return self has_purchased_perk_equipped_with_specific_stat(#"specialty_showenemyequipment", #"hash_1897ec9fa8c5c1c");
}

/*
	Name: has_cold_blooded_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0xC92F8E5B
	Offset: 0xA940
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function has_cold_blooded_perk_purchased_and_equipped()
{
	return self has_purchased_perk_equipped_with_specific_stat(#"specialty_nottargetedbyaitank", #"hash_b28558f13693bd9");
}

/*
	Name: has_hard_wired_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0x97725A72
	Offset: 0xA980
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function has_hard_wired_perk_purchased_and_equipped()
{
	return self has_purchased_perk_equipped_with_specific_stat(#"specialty_immunecounteruav", #"hash_6537e48a9b3f0527");
}

/*
	Name: has_gung_ho_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0x89A832F5
	Offset: 0xA9C0
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function has_gung_ho_perk_purchased_and_equipped()
{
	return self has_purchased_perk_equipped_with_specific_stat(#"specialty_sprintfire", #"hash_1fee6b565ce51b8");
}

/*
	Name: has_fast_hands_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0x492640E5
	Offset: 0xAA00
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function has_fast_hands_perk_purchased_and_equipped()
{
	return self has_purchased_perk_equipped_with_specific_stat(#"specialty_fastweaponswitch", #"hash_7fc4f09d0daa7cc6");
}

/*
	Name: has_scavenger_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0x5A4BA19E
	Offset: 0xAA40
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function has_scavenger_perk_purchased_and_equipped()
{
	return has_purchased_perk_equipped(#"specialty_scavenger");
}

/*
	Name: has_jetquiet_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0x19BC9C60
	Offset: 0xAA70
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function has_jetquiet_perk_purchased_and_equipped()
{
	return self has_purchased_perk_equipped_with_specific_stat(#"specialty_jetquiet", #"hash_37417e9ac4c35344");
}

/*
	Name: has_awareness_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0xDCE34BE5
	Offset: 0xAAB0
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function has_awareness_perk_purchased_and_equipped()
{
	return has_purchased_perk_equipped(#"specialty_loudenemies");
}

/*
	Name: has_ninja_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0x584F2CCB
	Offset: 0xAAE0
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function has_ninja_perk_purchased_and_equipped()
{
	return has_purchased_perk_equipped(#"specialty_quieter");
}

/*
	Name: has_toughness_perk_purchased_and_equipped
	Namespace: util
	Checksum: 0x991E30A
	Offset: 0xAB10
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function has_toughness_perk_purchased_and_equipped()
{
	return has_purchased_perk_equipped(#"specialty_bulletflinch");
}

/*
	Name: str_strip_lh
	Namespace: util
	Checksum: 0x7085AC4B
	Offset: 0xAB40
	Size: 0x58
	Parameters: 1
	Flags: None
*/
function str_strip_lh(str)
{
	if(strendswith(str, "_lh"))
	{
		return getsubstr(str, 0, str.size - 3);
	}
	return str;
}

/*
	Name: trackwallrunningdistance
	Namespace: util
	Checksum: 0x86F0054A
	Offset: 0xABA0
	Size: 0x176
	Parameters: 0
	Flags: None
*/
function trackwallrunningdistance()
{
	self endon(#"disconnect");
	self.movementtracking.wallrunning = spawnstruct();
	self.movementtracking.wallrunning.distance = 0;
	self.movementtracking.wallrunning.count = 0;
	self.movementtracking.wallrunning.time = 0;
	while(true)
	{
		self waittill(#"wallrun_begin");
		startpos = self.origin;
		starttime = gettime();
		self.movementtracking.wallrunning.count++;
		self waittill(#"wallrun_end");
		self.movementtracking.wallrunning.distance = self.movementtracking.wallrunning.distance + distance(startpos, self.origin);
		self.movementtracking.wallrunning.time = self.movementtracking.wallrunning.time + (gettime() - starttime);
	}
}

/*
	Name: tracksprintdistance
	Namespace: util
	Checksum: 0x1C23F2B8
	Offset: 0xAD20
	Size: 0x176
	Parameters: 0
	Flags: None
*/
function tracksprintdistance()
{
	self endon(#"disconnect");
	self.movementtracking.sprinting = spawnstruct();
	self.movementtracking.sprinting.distance = 0;
	self.movementtracking.sprinting.count = 0;
	self.movementtracking.sprinting.time = 0;
	while(true)
	{
		self waittill(#"sprint_begin");
		startpos = self.origin;
		starttime = gettime();
		self.movementtracking.sprinting.count++;
		self waittill(#"sprint_end");
		self.movementtracking.sprinting.distance = self.movementtracking.sprinting.distance + distance(startpos, self.origin);
		self.movementtracking.sprinting.time = self.movementtracking.sprinting.time + (gettime() - starttime);
	}
}

/*
	Name: trackdoublejumpdistance
	Namespace: util
	Checksum: 0xB822E56C
	Offset: 0xAEA0
	Size: 0x176
	Parameters: 0
	Flags: None
*/
function trackdoublejumpdistance()
{
	self endon(#"disconnect");
	self.movementtracking.doublejump = spawnstruct();
	self.movementtracking.doublejump.distance = 0;
	self.movementtracking.doublejump.count = 0;
	self.movementtracking.doublejump.time = 0;
	while(true)
	{
		self waittill(#"doublejump_begin");
		startpos = self.origin;
		starttime = gettime();
		self.movementtracking.doublejump.count++;
		self waittill(#"doublejump_end");
		self.movementtracking.doublejump.distance = self.movementtracking.doublejump.distance + distance(startpos, self.origin);
		self.movementtracking.doublejump.time = self.movementtracking.doublejump.time + (gettime() - starttime);
	}
}

/*
	Name: getplayspacecenter
	Namespace: util
	Checksum: 0xF55C0C98
	Offset: 0xB020
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function getplayspacecenter()
{
	minimaporigins = getentarray("minimap_corner", "targetname");
	if(minimaporigins.size)
	{
		return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
	}
	return (0, 0, 0);
}

/*
	Name: getplayspacemaxwidth
	Namespace: util
	Checksum: 0xF800FFED
	Offset: 0xB098
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function getplayspacemaxwidth()
{
	minimaporigins = getentarray("minimap_corner", "targetname");
	if(minimaporigins.size)
	{
		x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
		y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
		return max(x, y);
	}
	return 0;
}

/*
	Name: getteammask
	Namespace: util
	Checksum: 0xE0B0C314
	Offset: 0xB180
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function getteammask(team)
{
	team = get_team_mapping(team);
	if(!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team]))
	{
		return level.spawnsystem.ispawn_teammask_free;
	}
	return level.spawnsystem.ispawn_teammask[team];
}

/*
	Name: getotherteam
	Namespace: util
	Checksum: 0xF2D564DC
	Offset: 0xB218
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function getotherteam(team)
{
	team = get_team_mapping(team);
	if(team == #"allies")
	{
		return #"axis";
	}
	if(team == #"axis")
	{
		return #"allies";
	}
	return #"allies";
}

/*
	Name: getotherteamsmask
	Namespace: util
	Checksum: 0x5426E16E
	Offset: 0xB2D0
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function getotherteamsmask(str_skip_team)
{
	str_skip_team = get_team_mapping(str_skip_team);
	mask = 0;
	if(!isdefined(str_skip_team))
	{
		return mask;
	}
	foreach(team, _ in level.teams)
	{
		if(team === str_skip_team)
		{
			continue;
		}
		mask = mask | getteammask(team);
	}
	return mask;
}

/*
	Name: waittill_can_add_debug_command
	Namespace: util
	Checksum: 0x82B29C1D
	Offset: 0xB3B0
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function waittill_can_add_debug_command()
{
	while(!canadddebugcommand())
	{
		waitframe(1);
	}
}

/*
	Name: add_debug_command
	Namespace: util
	Checksum: 0x67794AA5
	Offset: 0xB3D8
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function add_debug_command(cmd)
{
	/#
		waittill_can_add_debug_command();
		adddebugcommand(cmd);
	#/
}

/*
	Name: get_players
	Namespace: util
	Checksum: 0x55487DA5
	Offset: 0xB420
	Size: 0x162
	Parameters: 1
	Flags: Linked
*/
function get_players(team = #"any")
{
	arrayremovevalue(level.players, undefined, 0);
	if(team == #"any")
	{
		return arraycopy(level.players);
	}
	/#
		assert(isdefined(level.teams[team]), ("" + function_9e72a96(team)) + "");
	#/
	players = [];
	foreach(player in level.players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		if(player.team === team)
		{
			players[players.size] = player;
		}
	}
	return players;
}

/*
	Name: get_active_players
	Namespace: util
	Checksum: 0x126E3DFB
	Offset: 0xB590
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function get_active_players(team = #"any")
{
	/#
		if(team != #"any")
		{
			/#
				assert(isdefined(level.teams[team]), ("" + function_9e72a96(team)) + "");
			#/
		}
	#/
	arrayremovevalue(level.activeplayers, undefined, 0);
	players = [];
	foreach(player in level.activeplayers)
	{
		if(!isdefined(player))
		{
			continue;
		}
		if(!isdefined(team) || team == #"any" || player.team === team)
		{
			players[players.size] = player;
		}
	}
	return players;
}

/*
	Name: function_81ccf6d3
	Namespace: util
	Checksum: 0x7DB6923C
	Offset: 0xB718
	Size: 0x16A
	Parameters: 1
	Flags: Linked
*/
function function_81ccf6d3(team = #"any")
{
	players = get_active_players();
	if(team == #"any")
	{
		return players;
	}
	/#
		assert(isdefined(level.teams[team]), ("" + function_9e72a96(team)) + "");
	#/
	enemies = [];
	foreach(player in players)
	{
		if(isdefined(player) && isdefined(player.team) && function_fbce7263(player.team, team))
		{
			enemies[enemies.size] = player;
		}
	}
	return enemies;
}

/*
	Name: get_human_players
	Namespace: util
	Checksum: 0x26F6DA1
	Offset: 0xB890
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function get_human_players(team = #"any")
{
	players = getplayers(team);
	humanplayers = [];
	foreach(player in players)
	{
		if(!isbot(player))
		{
			humanplayers[humanplayers.size] = player;
		}
	}
	return humanplayers;
}

/*
	Name: function_8e89351
	Namespace: util
	Checksum: 0xA17ABD63
	Offset: 0xB978
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_8e89351(player)
{
	return isdefined(player) && !isbot(player) && isinarray(level.players, player);
}

/*
	Name: function_517954bb
	Namespace: util
	Checksum: 0xB26A013E
	Offset: 0xB9D0
	Size: 0xE0
	Parameters: 1
	Flags: None
*/
function function_517954bb(team = #"any")
{
	players = get_players(team);
	var_d913e002 = [];
	foreach(player in players)
	{
		if(isbot(player))
		{
			var_d913e002[var_d913e002.size] = player;
		}
	}
	return var_d913e002;
}

/*
	Name: is_game_solo
	Namespace: util
	Checksum: 0x699CD60
	Offset: 0xBAB8
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function is_game_solo(team = #"any")
{
	humanplayers = get_human_players(team);
	return humanplayers.size == 1;
}

/*
	Name: is_game_coop
	Namespace: util
	Checksum: 0xA7E55E21
	Offset: 0xBB18
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function is_game_coop(team = #"any")
{
	humanplayers = get_human_players(team);
	return humanplayers.size > 1;
}

/*
	Name: function_cfa8b8df
	Namespace: util
	Checksum: 0x473C7614
	Offset: 0xBB78
	Size: 0x38
	Parameters: 1
	Flags: None
*/
function function_cfa8b8df(team)
{
	players = get_players(team);
	return players.size > 0;
}

/*
	Name: function_cda17472
	Namespace: util
	Checksum: 0x25024F7F
	Offset: 0xBBB8
	Size: 0x38
	Parameters: 1
	Flags: None
*/
function function_cda17472(team)
{
	players = get_human_players(team);
	return players.size > 0;
}

/*
	Name: timesince
	Namespace: util
	Checksum: 0x417FD4AA
	Offset: 0xBBF8
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function timesince(starttimeinmilliseconds)
{
	return (gettime() - starttimeinmilliseconds) * 0.001;
}

/*
	Name: cooldowninit
	Namespace: util
	Checksum: 0x53D62FBD
	Offset: 0xBC20
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function cooldowninit()
{
	if(!isdefined(self._cooldown))
	{
		self._cooldown = [];
	}
}

/*
	Name: cooldown
	Namespace: util
	Checksum: 0x29225004
	Offset: 0xBC48
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function cooldown(name, time_seconds)
{
	cooldowninit();
	self._cooldown[name] = gettime() + (int(time_seconds * 1000));
}

/*
	Name: getcooldowntimeraw
	Namespace: util
	Checksum: 0x69692D6
	Offset: 0xBCA8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function getcooldowntimeraw(name)
{
	cooldowninit();
	if(!isdefined(self._cooldown[name]))
	{
		self._cooldown[name] = gettime() - 1;
	}
	return self._cooldown[name];
}

/*
	Name: getcooldownleft
	Namespace: util
	Checksum: 0x6C0EE957
	Offset: 0xBD08
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function getcooldownleft(name)
{
	cooldowninit();
	return (getcooldowntimeraw(name) - gettime()) * 0.001;
}

/*
	Name: iscooldownready
	Namespace: util
	Checksum: 0x2C480C49
	Offset: 0xBD50
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function iscooldownready(name, timeforward_seconds)
{
	cooldowninit();
	if(!isdefined(timeforward_seconds))
	{
		timeforward_seconds = 0;
	}
	cooldownreadytime = self._cooldown[name];
	return !isdefined(cooldownreadytime) || (gettime() + (int(timeforward_seconds * 1000))) > cooldownreadytime;
}

/*
	Name: clearcooldown
	Namespace: util
	Checksum: 0x8EE1AE32
	Offset: 0xBDD8
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function clearcooldown(name)
{
	cooldowninit();
	self._cooldown[name] = gettime() - 1;
}

/*
	Name: addcooldowntime
	Namespace: util
	Checksum: 0xA092A62B
	Offset: 0xBE18
	Size: 0x6E
	Parameters: 2
	Flags: Linked
*/
function addcooldowntime(name, time_seconds)
{
	cooldowninit();
	self._cooldown[name] = getcooldowntimeraw(name) + (int(time_seconds * 1000));
}

/*
	Name: clearallcooldowns
	Namespace: util
	Checksum: 0x28CAD00A
	Offset: 0xBE90
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function clearallcooldowns()
{
	if(isdefined(self._cooldown))
	{
		foreach(str_name, cooldown in self._cooldown)
		{
			self._cooldown[str_name] = gettime() - 1;
		}
	}
}

/*
	Name: function_4627b63d
	Namespace: util
	Checksum: 0xDF498B69
	Offset: 0xBF28
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4627b63d(alias)
{
	/#
		assert(isdefined(level.team_mapping_alias));
	#/
	/#
		assert(isdefined(level.team_mapping_alias[alias]));
	#/
	return level.team_mapping_alias[alias];
}

/*
	Name: function_3cb7a62d
	Namespace: util
	Checksum: 0xC948931D
	Offset: 0xBF98
	Size: 0xC4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3cb7a62d()
{
	/#
		assert(isdefined(level.team_mapping));
	#/
	if(get_team_mapping("sidea") == #"allies" && get_team_mapping("sideb") == #"axis")
	{
		level clientfield::set("cf_team_mapping", 1);
	}
	else
	{
		level clientfield::set("cf_team_mapping", 0);
	}
}

/*
	Name: function_73fab74d
	Namespace: util
	Checksum: 0x1EF68A5A
	Offset: 0xC068
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function function_73fab74d()
{
	if(isdefined(level.var_1bbf77be))
	{
		return;
	}
	level.var_1bbf77be = 1;
	function_9db3109f(#"allies", #"allies");
	function_9db3109f(#"axis", #"axis");
	function_9db3109f(#"allies", "wun");
	function_9db3109f(#"axis", "fpa");
	function_9db3109f(#"team3", "side3");
	function_d3e0802c("sidea", "sideb");
	function_d3e0802c("teama", "teamb");
	function_d3e0802c("attacker", "defender");
	function_d3e0802c("attackers", "defenders");
	function_d3e0802c("wun", "fpa");
	function_c16f65a3(#"allies", #"axis");
	function_c16f65a3(#"team3", #"any");
	set_team_mapping(#"allies", #"axis");
}

/*
	Name: function_f9ce1d49
	Namespace: util
	Checksum: 0xC434EC16
	Offset: 0xC2A0
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_f9ce1d49()
{
	if(isdefined(level.var_fdf974de))
	{
		return;
	}
	level.var_fdf974de = array();
}

/*
	Name: function_d7e70327
	Namespace: util
	Checksum: 0x8D538B6D
	Offset: 0xC2E0
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_d7e70327(var_23866d2)
{
	array::add(level.var_fdf974de, var_23866d2);
}

/*
	Name: function_3d66774c
	Namespace: util
	Checksum: 0x247DA173
	Offset: 0xC318
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function function_3d66774c(var_23866d2)
{
	foreach(i, v in level.var_fdf974de)
	{
		if(array::function_460f3c24(v, var_23866d2))
		{
			array::remove_index(i);
		}
	}
}

/*
	Name: function_9b7092ef
	Namespace: util
	Checksum: 0x5B9AD59F
	Offset: 0xC3C0
	Size: 0x12C
	Parameters: 4
	Flags: Linked
*/
function function_9b7092ef(team1, team2, team3, team4)
{
	if(!isdefined(team1) || !isdefined(team2))
	{
		return false;
	}
	foreach(var_ef54b214 in level.var_fdf974de)
	{
		if(array::contains(var_ef54b214, team1))
		{
			if(array::contains(var_ef54b214, team2))
			{
				if(!isdefined(team3) || array::contains(var_ef54b214, team3))
				{
					if(!isdefined(team4) || array::contains(var_ef54b214, team4))
					{
						return true;
					}
				}
			}
		}
	}
	return false;
}

/*
	Name: set_team_mapping
	Namespace: util
	Checksum: 0xB12F6105
	Offset: 0xC4F8
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function set_team_mapping(var_b0dd114d, var_54495823)
{
	var_b0dd114d = function_4627b63d(var_b0dd114d);
	var_54495823 = function_4627b63d(var_54495823);
	/#
		assert(var_b0dd114d != var_54495823, "");
	#/
	level.team_mapping[0] = var_b0dd114d;
	level.team_mapping[1] = var_54495823;
	flagsys::set(#"team_mapping_set");
	game.attackers = var_b0dd114d;
	game.defenders = var_54495823;
	if(clientfield::can_set())
	{
		function_3cb7a62d();
	}
}

/*
	Name: function_d3e0802c
	Namespace: util
	Checksum: 0xCA4F0FC8
	Offset: 0xC608
	Size: 0x6A
	Parameters: 2
	Flags: Linked
*/
function function_d3e0802c(var_1dc5879e, var_128bf12b)
{
	/#
		assert(var_1dc5879e != var_128bf12b, "");
	#/
	level.var_af68e94e[var_1dc5879e] = 0;
	level.var_af68e94e[var_128bf12b] = 1;
}

/*
	Name: function_c16f65a3
	Namespace: util
	Checksum: 0x48595D94
	Offset: 0xC680
	Size: 0x6A
	Parameters: 2
	Flags: Linked
*/
function function_c16f65a3(enemy_a, enemy_b)
{
	/#
		assert(enemy_a != enemy_b, "");
	#/
	level.team_enemy_mapping[enemy_a] = enemy_b;
	level.team_enemy_mapping[enemy_b] = enemy_a;
}

/*
	Name: function_9db3109f
	Namespace: util
	Checksum: 0x3F9904C2
	Offset: 0xC6F8
	Size: 0x82
	Parameters: 2
	Flags: Linked
*/
function function_9db3109f(team, alias)
{
	/#
		assert(team == #"allies" || team == #"axis" || team == #"team3");
	#/
	level.team_mapping_alias[alias] = team;
}

/*
	Name: get_team_mapping
	Namespace: util
	Checksum: 0xA0E696D6
	Offset: 0xC788
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function get_team_mapping(team)
{
	/#
		assert(isdefined(level.team_mapping));
	#/
	/#
		assert(isdefined(level.var_af68e94e));
	#/
	if(isdefined(team))
	{
		if(isdefined(level.var_af68e94e[team]))
		{
			return level.team_mapping[level.var_af68e94e[team]];
		}
		if(isdefined(level.team_mapping_alias[team]))
		{
			return level.team_mapping_alias[team];
		}
	}
	return team;
}

/*
	Name: function_310d70e2
	Namespace: util
	Checksum: 0xA810279F
	Offset: 0xC848
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_310d70e2(team)
{
	/#
		assert(isdefined(level.team_mapping));
	#/
	/#
		assert(isdefined(level.var_af68e94e));
	#/
	if(isdefined(team))
	{
		if(team === level.team_mapping[level.var_af68e94e[#"sidea"]])
		{
			return "sidea";
		}
		if(team === level.team_mapping[level.var_af68e94e[#"sideb"]])
		{
			return "sideb";
		}
	}
	return team;
}

/*
	Name: is_on_side
	Namespace: util
	Checksum: 0xB70C9684
	Offset: 0xC918
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function is_on_side(team)
{
	return self getteam() === get_team_mapping(team);
}

/*
	Name: get_enemy_team
	Namespace: util
	Checksum: 0x5FE6B512
	Offset: 0xC958
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function get_enemy_team(team)
{
	team = get_team_mapping(team);
	if(!isdefined(team))
	{
		return undefined;
	}
	if(isdefined(level.team_enemy_mapping[team]))
	{
		return level.team_enemy_mapping[team];
	}
	return #"none";
}

/*
	Name: get_game_type
	Namespace: util
	Checksum: 0x2747DF82
	Offset: 0xC9C8
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function get_game_type()
{
	return tolower(getdvarstring(#"g_gametype"));
}

/*
	Name: get_map_name
	Namespace: util
	Checksum: 0x24AA524
	Offset: 0xCA08
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function get_map_name()
{
	return tolower(getdvarstring(#"sv_mapname"));
}

/*
	Name: is_frontend_map
	Namespace: util
	Checksum: 0xC8A51926
	Offset: 0xCA48
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function is_frontend_map()
{
	return get_map_name() === "core_frontend";
}

/*
	Name: add_devgui
	Namespace: util
	Checksum: 0xBF4797FD
	Offset: 0xCA70
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function add_devgui(menu_path, commands)
{
	/#
		add_queued_debug_command(((("" + menu_path) + "") + commands) + "");
	#/
}

/*
	Name: remove_devgui
	Namespace: util
	Checksum: 0x5050044E
	Offset: 0xCAD0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function remove_devgui(menu_path)
{
	/#
		add_queued_debug_command(("" + menu_path) + "");
	#/
}

/*
	Name: function_3f749abc
	Namespace: util
	Checksum: 0x797BEDF4
	Offset: 0xCB18
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function function_3f749abc(menu_path, commands)
{
	/#
		add_debug_command(((("" + menu_path) + "") + commands) + "");
	#/
}

/*
	Name: function_85c62761
	Namespace: util
	Checksum: 0xC8E07183
	Offset: 0xCB78
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_85c62761(menu_path)
{
	/#
		add_debug_command(("" + menu_path) + "");
	#/
}

/*
	Name: gadget_is_in_use
	Namespace: util
	Checksum: 0xD4096D09
	Offset: 0xCBC0
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function gadget_is_in_use(slot)
{
	if(isdefined(self._gadgets_player) && isdefined(self._gadgets_player[slot]))
	{
		if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type]))
		{
			if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse))
			{
				return self [[level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse]](slot);
			}
		}
	}
	return self gadgetisactive(slot);
}

/*
	Name: function_72cbea07
	Namespace: util
	Checksum: 0xD580BB3C
	Offset: 0xCC88
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function function_72cbea07(player, weapon)
{
	if(!isdefined(player.var_9c4683a0))
	{
		return false;
	}
	foreach(var_e64f4a4a in player.var_9c4683a0)
	{
		if(var_e64f4a4a == weapon)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: ghost_wait_show
	Namespace: util
	Checksum: 0xB377F93F
	Offset: 0xCD38
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function ghost_wait_show(wait_time = 0.1)
{
	self endon(#"death");
	self ghost();
	wait(wait_time);
	self show();
}

/*
	Name: ghost_wait_show_to_player
	Namespace: util
	Checksum: 0x6D21F529
	Offset: 0xCDA0
	Size: 0x124
	Parameters: 3
	Flags: Linked
*/
function ghost_wait_show_to_player(player, wait_time = 0.1, self_endon_string1)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self.abort_ghost_wait_show_to_player = undefined;
	if(isdefined(player))
	{
		player endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
	}
	if(isdefined(self_endon_string1))
	{
		self endon(self_endon_string1);
	}
	self ghost();
	self setinvisibletoall();
	self setvisibletoplayer(player);
	wait(wait_time);
	if(!isdefined(self.abort_ghost_wait_show_to_player))
	{
		self showtoplayer(player);
	}
}

/*
	Name: ghost_wait_show_to_others
	Namespace: util
	Checksum: 0x57D71788
	Offset: 0xCED0
	Size: 0x124
	Parameters: 3
	Flags: Linked
*/
function ghost_wait_show_to_others(player, wait_time = 0.1, self_endon_string1)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self.abort_ghost_wait_show_to_others = undefined;
	if(isdefined(player))
	{
		player endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
	}
	if(isdefined(self_endon_string1))
	{
		self endon(self_endon_string1);
	}
	self ghost();
	self setinvisibletoplayer(player);
	wait(wait_time);
	if(!isdefined(self.abort_ghost_wait_show_to_others))
	{
		self show();
		self setinvisibletoplayer(player);
	}
}

/*
	Name: show_hit_marker
	Namespace: util
	Checksum: 0x5310ED87
	Offset: 0xD000
	Size: 0x1F4
	Parameters: 2
	Flags: Linked
*/
function show_hit_marker(var_554cb812 = 0, var_1ed250ec = 0)
{
	if(isplayer(self))
	{
		if(isdefined(self) && isdefined(self.hud_damagefeedback))
		{
			/#
				currenttime = gettime();
				if((isdefined(self.hud_damagefeedback.time) ? self.hud_damagefeedback.time : 0) != currenttime || (!(isdefined(self.hud_damagefeedback.feedback_dead) && self.hud_damagefeedback.feedback_dead)))
				{
					if(var_554cb812)
					{
						self.hud_damagefeedback setshader(#"damage_feedback_glow_orange", 24, 48);
						self.hud_damagefeedback.feedback_dead = 1;
					}
					else
					{
						self.hud_damagefeedback setshader(#"damage_feedback", 24, 48);
						self.hud_damagefeedback.feedback_dead = 0;
					}
					self.hud_damagefeedback.alpha = 1;
					self.hud_damagefeedback fadeovertime(1);
					self.hud_damagefeedback.alpha = 0;
					self.hud_damagefeedback.time = currenttime;
				}
			#/
		}
		else if(isdefined(self) && !isdefined(self.hud_damagefeedback))
		{
			self thread _show_hit_marker(var_554cb812, var_1ed250ec);
		}
	}
}

/*
	Name: _show_hit_marker
	Namespace: util
	Checksum: 0xE0355944
	Offset: 0xD200
	Size: 0xA0
	Parameters: 2
	Flags: Linked, Private
*/
function private _show_hit_marker(var_554cb812, var_1ed250ec)
{
	self endon(#"death");
	if(!isdefined(self.var_9a94bf1))
	{
		self.var_9a94bf1 = 0;
	}
	if(self.var_9a94bf1 < 5)
	{
		self.var_9a94bf1++;
		self playhitmarker(undefined, 5, undefined, var_554cb812, var_1ed250ec);
		wait_network_frame();
		self.var_9a94bf1--;
	}
}

/*
	Name: function_5d36c37a
	Namespace: util
	Checksum: 0xFED4EF57
	Offset: 0xD2A8
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_5d36c37a(str_tag = "tag_aim_target")
{
	if(!issentient(self) && !function_ffa5b184(self))
	{
		if(isdefined(self gettagorigin(str_tag)))
		{
			self function_2baad8fc(str_tag);
		}
		else
		{
			self function_2baad8fc();
		}
	}
}

/*
	Name: function_c596f193
	Namespace: util
	Checksum: 0x41BA823E
	Offset: 0xD350
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_c596f193()
{
	if(!issentient(self))
	{
		self makesentient();
	}
}

/*
	Name: function_f9af3d43
	Namespace: util
	Checksum: 0xDAF00CAC
	Offset: 0xD390
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_f9af3d43(time)
{
	self endon(#"death");
	wait(time);
	self delete();
}

/*
	Name: is_party_gamemode
	Namespace: util
	Checksum: 0x96257A3A
	Offset: 0xD3D8
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function is_party_gamemode()
{
	switch(level.gametype)
	{
		case "sas":
		case "oic":
		case "shrp":
		case "gun":
		{
			return true;
			break;
		}
	}
	return false;
}

/*
	Name: get_gametype_name
	Namespace: util
	Checksum: 0x8EE82209
	Offset: 0xD450
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function get_gametype_name()
{
	return level.gametype;
}

/*
	Name: function_419f0c21
	Namespace: util
	Checksum: 0xDC4A8B6
	Offset: 0xD468
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_419f0c21()
{
	self endon(#"disconnect");
	if(isplayer(self) && !isbot(self))
	{
		wait_network_frame();
		self function_eb0dd56(0);
		wait_network_frame();
		self function_eb0dd56(0);
	}
}

/*
	Name: set_dvar_if_unset
	Namespace: util
	Checksum: 0x5FF26E46
	Offset: 0xD510
	Size: 0x82
	Parameters: 3
	Flags: Linked
*/
function set_dvar_if_unset(dvar, value, reset = 0)
{
	if(reset || getdvarstring(dvar) == "")
	{
		setdvar(dvar, value);
		return value;
	}
	return getdvarstring(dvar);
}

/*
	Name: set_dvar_float_if_unset
	Namespace: util
	Checksum: 0xB462E86
	Offset: 0xD5A0
	Size: 0x82
	Parameters: 3
	Flags: None
*/
function set_dvar_float_if_unset(dvar, value, reset = 0)
{
	if(reset || getdvarstring(dvar) == "")
	{
		setdvar(dvar, value);
	}
	return getdvarfloat(dvar, 0);
}

/*
	Name: set_dvar_int_if_unset
	Namespace: util
	Checksum: 0x1EF4DD7A
	Offset: 0xD630
	Size: 0x9A
	Parameters: 3
	Flags: None
*/
function set_dvar_int_if_unset(dvar, value, reset = 0)
{
	if(reset || getdvarstring(dvar) == "")
	{
		setdvar(dvar, value);
		return int(value);
	}
	return getdvarint(dvar, 0);
}

/*
	Name: debug_slow_heli_speed
	Namespace: util
	Checksum: 0xF049F02
	Offset: 0xD6D8
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function debug_slow_heli_speed()
{
	/#
		if(getdvarint(#"scr_slow_heli", 0) > 0)
		{
			self setspeed(getdvarint(#"scr_slow_heli", 0));
		}
	#/
}

/*
	Name: function_fb80e9ca
	Namespace: util
	Checksum: 0x7929DAFD
	Offset: 0xD748
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_fb80e9ca()
{
	n_timeout = 0;
	self flagsys::set(#"hash_157310a25dd4e508");
	if(isdefined(self.var_68d6a816))
	{
		n_timeout = self.var_68d6a816;
	}
	flag::function_5f02becb(n_timeout);
	self script_delay();
	self flagsys::clear(#"hash_157310a25dd4e508");
}

/*
	Name: function_74f2b2e9
	Namespace: util
	Checksum: 0x94B17095
	Offset: 0xD7E8
	Size: 0x7A
	Parameters: 0
	Flags: None
*/
function function_74f2b2e9()
{
	return isdefined(self.script_flag_true) || isdefined(self.script_flag_false) || (isdefined(self.script_delay) && self.script_delay > 0) || (isdefined(self.script_delay_min) && self.script_delay_min > 0) || (isdefined(self.script_delay_max) && self.script_delay_max > 0);
}

/*
	Name: function_d2dd4134
	Namespace: util
	Checksum: 0x1AA35C9B
	Offset: 0xD870
	Size: 0x126
	Parameters: 2
	Flags: Linked
*/
function function_d2dd4134(str_value, str_key)
{
	a_targets = [];
	if(!isdefined(str_key))
	{
		str_key = "targetname";
	}
	if(isdefined(str_value))
	{
		var_c747e345 = strtok(str_value, " ");
		foreach(var_2fd77a2f in var_c747e345)
		{
			a_targets = arraycombine(a_targets, getentarray(var_2fd77a2f, str_key), 0, 0);
			a_targets = arraycombine(a_targets, struct::get_array(var_2fd77a2f, str_key), 0, 0);
		}
	}
	return a_targets;
}

/*
	Name: get_array
	Namespace: util
	Checksum: 0xF57932A
	Offset: 0xD9A0
	Size: 0x136
	Parameters: 2
	Flags: Linked
*/
function get_array(str_value, str_key = "targetname")
{
	a_targets = function_d2dd4134(str_value, str_key);
	if(isdefined(str_value))
	{
		var_c747e345 = strtok(str_value, " ");
		foreach(var_2fd77a2f in var_c747e345)
		{
			a_targets = arraycombine(a_targets, getvehiclenodearray(var_2fd77a2f, str_key), 0, 0);
			a_targets = arraycombine(a_targets, getnodearray(var_2fd77a2f, str_key), 0, 0);
		}
	}
	return a_targets;
}

/*
	Name: function_a1281365
	Namespace: util
	Checksum: 0x990A4183
	Offset: 0xDAE0
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function function_a1281365(radius)
{
	if(!isdefined(radius) || radius <= 0)
	{
		return 0;
	}
	return randomfloatrange(radius * -1, radius);
}

/*
	Name: function_8eb53136
	Namespace: util
	Checksum: 0xAE5D6042
	Offset: 0xDB40
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_8eb53136(radius)
{
	if(!isdefined(radius) || radius <= 0)
	{
		return 0;
	}
	return function_21a3a673(radius * -1, radius);
}

/*
	Name: is_spectating
	Namespace: util
	Checksum: 0x43A25827
	Offset: 0xDB90
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function is_spectating()
{
	if(self.sessionstate == #"spectator")
	{
		return true;
	}
	return false;
}

/*
	Name: function_8570168d
	Namespace: util
	Checksum: 0x8A8DE992
	Offset: 0xDBC0
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_8570168d()
{
	/#
		if(getdvar(#"hash_49e94b7aefac4f49", 0))
		{
			return true;
		}
	#/
	if(sessionmodeismultiplayergame())
	{
		mode = function_bea73b01();
		if(mode == 4)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_88c74107
	Namespace: util
	Checksum: 0xD6D48C0C
	Offset: 0xDC48
	Size: 0x13A
	Parameters: 2
	Flags: Linked
*/
function function_88c74107(var_2cd16289 = "ufo", var_e7245730 = "noclip")
{
	var_bf8813f9 = 0;
	if(self == level)
	{
		a_players = getplayers();
		var_bf8813f9 = 0;
		foreach(player in a_players)
		{
			if(player isinmovemode("ufo", "noclip"))
			{
				var_bf8813f9 = 1;
				break;
			}
		}
	}
	else if(self isinmovemode("ufo", "noclip"))
	{
		var_bf8813f9 = 1;
	}
	return var_bf8813f9;
}

/*
	Name: function_22bf0a4a
	Namespace: util
	Checksum: 0xC5399F8B
	Offset: 0xDD90
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_22bf0a4a()
{
	player = self;
	if(level.var_e6f2a0c9 === 1)
	{
		return;
	}
	if(getdvarstring(#"hash_60bd94571c7f1e3b", "") != "community_galil_achievement")
	{
		return;
	}
	if(!gamemodeismode(0) && !gamemodeismode(6))
	{
		return;
	}
	if(level.var_903e2252 === 1)
	{
		return;
	}
	if(!isdefined(player))
	{
		return;
	}
	if(!isplayer(player))
	{
		return;
	}
	player function_cce105c8(#"hash_243e425916855df3", 1, getdvarint(#"hash_4f52cc2f30dbbb9", 1));
	level.var_e6f2a0c9 = 1;
}

#namespace namespace_2e6206f9;

/*
	Name: register_callback
	Namespace: namespace_2e6206f9
	Checksum: 0x5D00A5E6
	Offset: 0xDED0
	Size: 0x2DC
	Parameters: 3
	Flags: Linked, Variadic
*/
function register_callback(str_kvp, func, vararg)
{
	var_a12e87bd = hash(str_kvp);
	var_bcb861f = self.(str_kvp + "_target");
	if(isdefined(var_bcb861f))
	{
		if(!isdefined(mission.var_232d57d8))
		{
			mission.var_232d57d8 = [];
		}
		if(!isdefined(mission.var_232d57d8[var_a12e87bd]))
		{
			mission.var_232d57d8[var_a12e87bd] = [];
		}
		if(!isdefined(self.var_c18fbf49))
		{
			self.var_c18fbf49 = [];
		}
		s_callback = {#params:vararg, #func:func};
		self.var_c18fbf49[var_a12e87bd] = s_callback;
		var_c747e345 = strtok(var_bcb861f, " ");
		foreach(var_5afcf8a3 in var_c747e345)
		{
			if(!isdefined(mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)]))
			{
				mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)] = [];
			}
			else if(!isarray(mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)]))
			{
				mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)] = array(mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)]);
			}
			mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)][mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)].size] = self;
		}
		self thread function_d608a743();
	}
}

/*
	Name: function_c6dbc898
	Namespace: namespace_2e6206f9
	Checksum: 0xDC25DBD2
	Offset: 0xE1B8
	Size: 0x2CC
	Parameters: 3
	Flags: Linked
*/
function function_c6dbc898(str_name, str_kvp, func)
{
	var_ce100229 = hash(str_name);
	var_bcb861f = self.(str_kvp + "_target");
	if(isdefined(var_bcb861f))
	{
		if(!isdefined(mission.var_232d57d8))
		{
			mission.var_232d57d8 = [];
		}
		if(!isdefined(mission.var_232d57d8[var_ce100229]))
		{
			mission.var_232d57d8[var_ce100229] = [];
		}
		if(!isdefined(self.var_c18fbf49))
		{
			self.var_c18fbf49 = [];
		}
		s_callback = {#func:func};
		self.var_c18fbf49[var_ce100229] = s_callback;
		var_c747e345 = strtok(var_bcb861f, " ");
		foreach(var_5afcf8a3 in var_c747e345)
		{
			if(!isdefined(mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)]))
			{
				mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)] = [];
			}
			else if(!isarray(mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)]))
			{
				mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)] = array(mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)]);
			}
			mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)][mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)].size] = self;
		}
		self thread function_d608a743();
	}
}

/*
	Name: function_d608a743
	Namespace: namespace_2e6206f9
	Checksum: 0xD643DA5A
	Offset: 0xE490
	Size: 0x150
	Parameters: 0
	Flags: Linked
*/
function function_d608a743()
{
	self notify(#"hash_29bf696e43d4a08b");
	self endon(#"hash_29bf696e43d4a08b", #"death");
	var_9bc12626 = getarraykeys(self.var_c18fbf49);
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(var_9bc12626);
		s_callback = self.var_c18fbf49[hash(s_result._notify)];
		if(isdefined(s_callback.params))
		{
			util::single_thread_argarray(self, s_callback.func, s_callback.params);
		}
		else
		{
			if(isdefined(s_result.params))
			{
				util::single_thread_argarray(self, s_callback.func, s_result.params);
			}
			else
			{
				util::single_thread_argarray(self, s_callback.func);
			}
		}
	}
}

/*
	Name: function_7ed1d198
	Namespace: namespace_2e6206f9
	Checksum: 0xBBD1002
	Offset: 0xE5E8
	Size: 0x20C
	Parameters: 2
	Flags: Linked
*/
function function_7ed1d198(str_kvp, str_name)
{
	var_eef18fbd = [];
	if(isdefined(mission.var_232d57d8))
	{
		var_ce100229 = hash((isdefined(str_name) ? str_name : str_kvp));
		var_7ac3e82f = mission.var_232d57d8[var_ce100229];
		if(isdefined(var_7ac3e82f))
		{
			var_bcb861f = self.(str_kvp + "_src");
			if(isdefined(var_bcb861f))
			{
				var_c747e345 = strtok(var_bcb861f, " ");
				foreach(var_5afcf8a3 in var_c747e345)
				{
					var_85c1bb33 = var_7ac3e82f[hash(var_5afcf8a3)];
					if(isdefined(var_85c1bb33))
					{
						foreach(var_8507e893 in var_85c1bb33)
						{
							if(!isdefined(var_eef18fbd))
							{
								var_eef18fbd = [];
							}
							else if(!isarray(var_eef18fbd))
							{
								var_eef18fbd = array(var_eef18fbd);
							}
							var_eef18fbd[var_eef18fbd.size] = var_8507e893;
						}
					}
				}
			}
		}
	}
	return var_eef18fbd;
}

/*
	Name: callback
	Namespace: namespace_2e6206f9
	Checksum: 0x52954944
	Offset: 0xE800
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function callback(str_kvp)
{
	var_e028d750 = function_7ed1d198(str_kvp);
	if(var_e028d750.size)
	{
		foreach(var_8507e893 in var_e028d750)
		{
			var_8507e893 notify(str_kvp);
		}
	}
}

/*
	Name: custom_callback
	Namespace: namespace_2e6206f9
	Checksum: 0xE9A80F99
	Offset: 0xE8A8
	Size: 0xCA
	Parameters: 3
	Flags: Variadic
*/
function custom_callback(str_name, str_kvp, vararg)
{
	var_e028d750 = function_7ed1d198(str_kvp, str_name);
	if(var_e028d750.size)
	{
		foreach(var_8507e893 in var_e028d750)
		{
			var_8507e893 notify(str_name, {#params:vararg});
		}
	}
}

/*
	Name: function_4da758bf
	Namespace: namespace_2e6206f9
	Checksum: 0x99A32D78
	Offset: 0xE980
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function function_4da758bf()
{
	self.var_c18fbf49 = undefined;
	self notify(#"hash_29bf696e43d4a08b");
}

/*
	Name: function_61e8e3c8
	Namespace: namespace_2e6206f9
	Checksum: 0x639998F2
	Offset: 0xE9A8
	Size: 0x3A
	Parameters: 1
	Flags: None
*/
function function_61e8e3c8(str_kvp)
{
	return util::get_array(self.(str_kvp + "_target"), str_kvp + "_src");
}

/*
	Name: get_target_structs
	Namespace: namespace_2e6206f9
	Checksum: 0x8B6D639A
	Offset: 0xE9F0
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function get_target_structs(str_kvp)
{
	return util::get_array(self.(str_kvp + "_src"), str_kvp + "_target");
}

