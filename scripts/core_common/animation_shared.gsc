// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14feb11d757fd194;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_debug_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\string_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace animation;

/*
	Name: function_89f2df9
	Namespace: animation
	Checksum: 0x68B48246
	Offset: 0x330
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"animation", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: animation
	Checksum: 0xBDFF7AF0
	Offset: 0x378
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarstring(#"debug_anim_shared", "") == "")
	{
		setdvar(#"debug_anim_shared", "");
	}
	setup_notetracks();
	callback::on_laststand(&reset_player);
	callback::on_bleedout(&reset_player);
	callback::on_player_killed(&reset_player);
	callback::on_spawned(&reset_player);
}

/*
	Name: reset_player
	Namespace: animation
	Checksum: 0xE40DC791
	Offset: 0x478
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function reset_player()
{
	flagsys::clear(#"firstframe");
	flagsys::clear(#"scripted_anim_this_frame");
	flagsys::clear(#"scriptedanim");
}

/*
	Name: first_frame
	Namespace: animation
	Checksum: 0x576F6FB5
	Offset: 0x4E8
	Size: 0x3C
	Parameters: 3
	Flags: None
*/
function first_frame(animation, v_origin_or_ent, v_angles_or_tag)
{
	self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

/*
	Name: last_frame
	Namespace: animation
	Checksum: 0xE21DB83D
	Offset: 0x530
	Size: 0x4C
	Parameters: 3
	Flags: None
*/
function last_frame(animation, v_origin_or_ent, v_angles_or_tag)
{
	self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0, 0, 0, 0, 1);
}

/*
	Name: play_siege
	Namespace: animation
	Checksum: 0xC4F90006
	Offset: 0x588
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function play_siege(str_anim, n_rate = 1)
{
	self notify(#"hash_10506de382288d3");
	self endon(#"death", #"scene_stop", #"hash_10506de382288d3");
	b_loop = function_35c3fa74(str_anim);
	self function_cf6be307(str_anim, "default", n_rate, b_loop);
	if(b_loop)
	{
		self waittill(#"hash_10506de382288d3");
	}
	else
	{
		n_length = function_658484f7(str_anim);
		wait(n_length);
	}
}

/*
	Name: play
	Namespace: animation
	Checksum: 0xDEA617B7
	Offset: 0x688
	Size: 0x172
	Parameters: 12
	Flags: Linked
*/
function play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp = 0, n_start_time = 0, b_show_player_firstperson_weapon = 0, b_unlink_after_completed = 1, var_f4b34dc1, paused)
{
	if(self isragdoll())
	{
		return;
	}
	self endon(#"death", #"entering_last_stand");
	self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed, var_f4b34dc1, paused);
	if(n_rate > 0)
	{
		self waittill(#"scriptedanim");
	}
}

/*
	Name: stop
	Namespace: animation
	Checksum: 0xA324F881
	Offset: 0x808
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function stop(n_blend = 0.2)
{
	flagsys::clear(#"scriptedanim");
	if(isdefined(self))
	{
		self stopanimscripted(n_blend);
	}
}

/*
	Name: debug_print
	Namespace: animation
	Checksum: 0x5CC2B19E
	Offset: 0x870
	Size: 0x204
	Parameters: 2
	Flags: None
*/
function debug_print(str_animation, str_msg)
{
	/#
		str_dvar = getdvarstring(#"debug_anim_shared", "");
		if(str_dvar != "")
		{
			if(!isstring(str_animation))
			{
				str_animation = (isdefined(function_9e72a96(str_animation)) ? "" + function_9e72a96(str_animation) : "");
			}
			b_print = 0;
			if(strisnumber(str_dvar))
			{
				if(int(str_dvar) > 0)
				{
					b_print = 1;
				}
			}
			else if(issubstr(str_animation, str_dvar) || (isdefined(self.animname) && issubstr(self.animname, str_dvar)))
			{
				b_print = 1;
			}
			if(b_print)
			{
				printtoprightln((((str_animation + "") + string::rjust(str_msg, 10) + "") + (string::rjust("" + self getentitynumber(), 4)) + "") + (string::rjust("" + gettime(), 6)) + "", (1, 1, 0), -1);
			}
		}
	#/
}

/*
	Name: _play
	Namespace: animation
	Checksum: 0x5D8A8CDB
	Offset: 0xA80
	Size: 0x7E4
	Parameters: 12
	Flags: Linked
*/
function _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed, var_f4b34dc1, paused)
{
	self notify(#"new_scripted_anim");
	self endon_callback(&function_2adc2518, #"death", #"entering_last_stand", #"new_scripted_anim");
	/#
		debug_print(animation, "");
	#/
	flagsys::set_val("firstframe", n_rate == 0 && (!(isdefined(paused) && paused)));
	flagsys::set(#"scripted_anim_this_frame");
	flagsys::set(#"scriptedanim");
	if(!isdefined(v_origin_or_ent))
	{
		v_origin_or_ent = self;
	}
	if(isvec(v_origin_or_ent))
	{
		v_origin = v_origin_or_ent;
	}
	else
	{
		v_origin = (isdefined(v_origin_or_ent.origin) ? v_origin_or_ent.origin : (0, 0, 0));
	}
	if(isvec(v_angles_or_tag))
	{
		v_angles = v_angles_or_tag;
	}
	else if(isstring(v_angles_or_tag))
	{
		str_tag = v_angles_or_tag;
		v_origin = v_origin_or_ent gettagorigin(str_tag);
		v_angles = v_origin_or_ent gettagangles(str_tag);
		/#
			/#
				assert(isdefined(v_origin) && isdefined(v_angles), (((("" + function_9e72a96(animation)) + "") + v_origin_or_ent getentitynumber() + "") + v_angles_or_tag) + "");
			#/
		#/
	}
	else
	{
		v_angles = (isdefined(v_origin_or_ent.angles) ? v_origin_or_ent.angles : (0, 0, 0));
	}
	self.str_current_anim = animation;
	b_link = isentity(v_origin_or_ent);
	if(isdefined(self.n_script_anim_rate))
	{
		n_rate = self.n_script_anim_rate;
	}
	if(n_lerp > 0)
	{
		prevorigin = self.origin;
		prevangles = self.angles;
	}
	if(b_link)
	{
		if(isactor(self))
		{
			self forceteleport(v_origin, v_angles);
		}
		else if(isplayer(self))
		{
			self setorigin(v_origin);
			self setplayerangles(v_angles);
		}
		else
		{
			self.origin = v_origin;
			self.angles = v_angles;
		}
		if(v_origin_or_ent != self)
		{
			if(isstring(str_tag))
			{
				self linkto(v_origin_or_ent, str_tag, (0, 0, 0), (0, 0, 0));
			}
			else
			{
				self linkto(v_origin_or_ent);
			}
		}
		if(n_lerp > 0)
		{
			if(isactor(self))
			{
				self forceteleport(prevorigin, prevangles);
			}
			else if(isplayer(self))
			{
				self setorigin(prevorigin);
				self setplayerangles(prevangles);
			}
			else
			{
				self.origin = prevorigin;
				self.angles = prevangles;
			}
		}
	}
	self animscripted(animation, v_origin, v_angles, animation, "normal", undefined, n_rate, n_blend_in, n_lerp, n_start_time, 1, b_show_player_firstperson_weapon, var_f4b34dc1, paused);
	if(isplayer(self))
	{
		set_player_clamps();
	}
	/#
		self.var_80c69db6 = "";
		self.var_6c4bb19 = {#hash_f4b34dc1:var_f4b34dc1, #v_angles_or_tag:v_angles_or_tag, #v_origin_or_ent:v_origin_or_ent, #animation:animation};
		level flagsys::clear("");
	#/
	if(!isanimlooping(animation) && n_blend_out > 0 && n_rate > 0 && n_start_time < 1)
	{
		if(!animhasnotetrack(animation, "start_ragdoll"))
		{
			self thread _blend_out(animation, n_blend_out, n_rate, n_start_time);
		}
	}
	if(!flagsys::get(#"firstframe"))
	{
		self thread handle_notetracks(animation);
		if(getanimframecount(animation) > 1 || isanimlooping(animation))
		{
			self waittill_match({#notetrack:"end"}, animation);
		}
		else
		{
			waitframe(1);
		}
		if(b_link && (isdefined(b_unlink_after_completed) && b_unlink_after_completed))
		{
			self unlink();
		}
		self.str_current_anim = undefined;
		self.var_80c69db6 = undefined;
		self.var_6c4bb19 = undefined;
		flagsys::clear(#"scriptedanim");
		flagsys::clear(#"firstframe");
		/#
			debug_print(animation, "");
		#/
		waittillframeend();
		flagsys::clear(#"scripted_anim_this_frame");
	}
}

/*
	Name: function_2adc2518
	Namespace: animation
	Checksum: 0x5AA39617
	Offset: 0x1270
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_2adc2518(str_notify)
{
	if(isdefined(self) && str_notify == "entering_last_stand")
	{
		self.var_80c69db6 = undefined;
		self.str_current_anim = undefined;
		self.var_6c4bb19 = undefined;
	}
}

/*
	Name: _blend_out
	Namespace: animation
	Checksum: 0xFD988471
	Offset: 0x12B8
	Size: 0x162
	Parameters: 4
	Flags: Linked
*/
function _blend_out(animation, n_blend, n_rate, n_start_time)
{
	self endon(#"death", #"end", #"scriptedanim", #"new_scripted_anim");
	n_server_length = (floor(getanimlength(animation) / (float(function_60d95f53()) / 1000))) * (float(function_60d95f53()) / 1000);
	while(true)
	{
		n_current_time = self getanimtime(animation) * n_server_length;
		n_time_left = n_server_length - n_current_time;
		if(n_time_left <= n_blend)
		{
			self stopanimscripted(n_blend);
			break;
		}
		waitframe(1);
	}
}

/*
	Name: _get_align_ent
	Namespace: animation
	Checksum: 0x3C02EBE2
	Offset: 0x1428
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function _get_align_ent(e_align)
{
	e = self;
	if(isdefined(e_align))
	{
		e = e_align;
	}
	if(!isdefined(e.angles))
	{
		e.angles = (0, 0, 0);
	}
	return e;
}

/*
	Name: _get_align_pos
	Namespace: animation
	Checksum: 0xC8DF083D
	Offset: 0x1480
	Size: 0x1A6
	Parameters: 2
	Flags: Linked
*/
function _get_align_pos(v_origin_or_ent = self.origin, v_angles_or_tag = (isdefined(self.angles) ? self.angles : (0, 0, 0)))
{
	s = spawnstruct();
	if(isvec(v_origin_or_ent))
	{
		/#
			assert(isvec(v_angles_or_tag), "");
		#/
		s.origin = v_origin_or_ent;
		s.angles = v_angles_or_tag;
	}
	else
	{
		e_align = _get_align_ent(v_origin_or_ent);
		if(isstring(v_angles_or_tag))
		{
			s.origin = e_align gettagorigin(v_angles_or_tag);
			s.angles = e_align gettagangles(v_angles_or_tag);
		}
		else
		{
			s.origin = e_align.origin;
			s.angles = e_align.angles;
		}
	}
	if(!isdefined(s.angles))
	{
		s.angles = (0, 0, 0);
	}
	return s;
}

/*
	Name: teleport
	Namespace: animation
	Checksum: 0xC778619
	Offset: 0x1630
	Size: 0x162
	Parameters: 4
	Flags: None
*/
function teleport(animation, v_origin_or_ent, v_angles_or_tag, time = 0)
{
	s = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
	v_pos = getstartorigin(s.origin, s.angles, animation, time);
	v_ang = getstartangles(s.origin, s.angles, animation, time);
	if(isactor(self))
	{
		self forceteleport(v_pos, v_ang);
	}
	else if(isplayer(self))
	{
		self setorigin(v_pos);
		self setplayerangles(v_ang);
	}
	else
	{
		self.origin = v_pos;
		self.angles = v_ang;
	}
}

/*
	Name: reach
	Namespace: animation
	Checksum: 0xF2D2980F
	Offset: 0x17A0
	Size: 0xA4
	Parameters: 4
	Flags: Linked
*/
function reach(animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals = 0)
{
	self endon(#"death");
	s_tracker = spawnstruct();
	self thread _reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals);
	s_tracker waittill(#"done");
}

/*
	Name: _reach
	Namespace: animation
	Checksum: 0x6BD20DF7
	Offset: 0x1850
	Size: 0x3C6
	Parameters: 5
	Flags: Linked
*/
function _reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals = 0)
{
	self endon(#"death");
	self notify(#"stop_going_to_node");
	self notify(#"new_anim_reach");
	flagsys::wait_till_clear("anim_reach");
	flagsys::set(#"anim_reach");
	s = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
	goal = getstartorigin(s.origin, s.angles, animation);
	n_delta = distancesquared(goal, self.origin);
	if(n_delta > 16)
	{
		self stopanimscripted(0.2);
		if(b_disable_arrivals)
		{
			if(ai::has_behavior_attribute("disablearrivals"))
			{
				ai::set_behavior_attribute("disablearrivals", 1);
			}
			self.stopanimdistsq = 0.0001;
		}
		if(isdefined(self.archetype) && self.archetype == #"robot")
		{
			ai::set_behavior_attribute("rogue_control_force_goal", goal);
		}
		else if(ai::has_behavior_attribute("vignette_mode") && (!(isdefined(self.ignorevignettemodeforanimreach) && self.ignorevignettemodeforanimreach)))
		{
			ai::set_behavior_attribute("vignette_mode", "fast");
		}
		self thread ai::force_goal(goal, 1, undefined, 0, 1);
		/#
			self thread debug_anim_reach();
		#/
		self waittill(#"goal", #"new_anim_reach", #"new_scripted_anim", #"stop_scripted_anim");
		if(ai::has_behavior_attribute("disablearrivals"))
		{
			ai::set_behavior_attribute("disablearrivals", 0);
			self.stopanimdistsq = 0;
		}
	}
	else
	{
		waittillframeend();
	}
	if(!(isdefined(self.archetype) && self.archetype == #"robot") && ai::has_behavior_attribute("vignette_mode"))
	{
		ai::set_behavior_attribute("vignette_mode", "off");
	}
	flagsys::clear(#"anim_reach");
	s_tracker notify(#"done");
	self notify(#"reach_done");
}

/*
	Name: debug_anim_reach
	Namespace: animation
	Checksum: 0xE2280CF2
	Offset: 0x1C20
	Size: 0xB6
	Parameters: 0
	Flags: None
*/
function debug_anim_reach()
{
	/#
		self endon(#"death", #"goal", #"new_anim_reach", #"new_scripted_anim", #"stop_scripted_anim");
		while(true)
		{
			level flagsys::wait_till("");
			print3d(self.origin, "", (1, 0, 0), 1, 1, 1);
			waitframe(1);
		}
	#/
}

/*
	Name: set_death_anim
	Namespace: animation
	Checksum: 0x7819536C
	Offset: 0x1CE0
	Size: 0xA2
	Parameters: 7
	Flags: Linked
*/
function set_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp)
{
	self notify(#"new_death_anim");
	if(isdefined(animation))
	{
		self.skipdeath = 1;
		self thread _do_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
	}
	else
	{
		self.skipdeath = 0;
	}
}

/*
	Name: _do_death_anim
	Namespace: animation
	Checksum: 0x5113C9B7
	Offset: 0x1D90
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function _do_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp)
{
	self endon(#"new_death_anim");
	self waittill(#"death");
	if(isdefined(self) && !self isragdoll())
	{
		self play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
	}
}

/*
	Name: set_player_clamps
	Namespace: animation
	Checksum: 0x466918A4
	Offset: 0x1E50
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function set_player_clamps()
{
	if(isdefined(self.player_anim_look_enabled) && self.player_anim_look_enabled)
	{
		self setviewclamp(self.player_anim_clamp_right, self.player_anim_clamp_left, self.player_anim_clamp_top, self.player_anim_clamp_bottom);
	}
}

/*
	Name: add_notetrack_func
	Namespace: animation
	Checksum: 0x5CA64E17
	Offset: 0x1EB0
	Size: 0x7A
	Parameters: 2
	Flags: Linked
*/
function add_notetrack_func(funcname, func)
{
	if(!isdefined(level._animnotifyfuncs))
	{
		level._animnotifyfuncs = [];
	}
	/#
		assert(!isdefined(level._animnotifyfuncs[funcname]), "");
	#/
	level._animnotifyfuncs[funcname] = func;
}

/*
	Name: add_global_notetrack_handler
	Namespace: animation
	Checksum: 0x2E251BD5
	Offset: 0x1F38
	Size: 0x128
	Parameters: 4
	Flags: Linked, Variadic
*/
function add_global_notetrack_handler(str_note, func, pass_notify_params, vararg)
{
	if(!isdefined(level._animnotetrackhandlers))
	{
		level._animnotetrackhandlers = [];
	}
	if(!isdefined(level._animnotetrackhandlers[str_note]))
	{
		level._animnotetrackhandlers[str_note] = [];
	}
	if(!isdefined(level._animnotetrackhandlers[str_note]))
	{
		level._animnotetrackhandlers[str_note] = [];
	}
	else if(!isarray(level._animnotetrackhandlers[str_note]))
	{
		level._animnotetrackhandlers[str_note] = array(level._animnotetrackhandlers[str_note]);
	}
	level._animnotetrackhandlers[str_note][level._animnotetrackhandlers[str_note].size] = array(func, pass_notify_params, vararg);
}

/*
	Name: call_notetrack_handler
	Namespace: animation
	Checksum: 0xF1E24EE8
	Offset: 0x2068
	Size: 0x118
	Parameters: 3
	Flags: Linked
*/
function call_notetrack_handler(str_note, param1, param2)
{
	if(isdefined(level._animnotetrackhandlers[str_note]))
	{
		foreach(handler in level._animnotetrackhandlers[str_note])
		{
			func = handler[0];
			passnotifyparams = handler[1];
			args = handler[2];
			if(passnotifyparams)
			{
				self [[func]](param1, param2);
				continue;
			}
			util::single_func_argarray(self, func, args);
		}
	}
}

/*
	Name: setup_notetracks
	Namespace: animation
	Checksum: 0x27D18359
	Offset: 0x2188
	Size: 0x3EC
	Parameters: 0
	Flags: Linked
*/
function setup_notetracks()
{
	add_notetrack_func("flag::set", &flagsys::set);
	add_notetrack_func("flag::clear", &flagsys::clear);
	add_notetrack_func("util::break_glass", &util::break_glass);
	add_notetrack_func("PhysicsLaunch", &function_eb0aa7cf);
	clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int");
	clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int");
	add_global_notetrack_handler("red_cracks_on", &cracks_on, 0, "red");
	add_global_notetrack_handler("green_cracks_on", &cracks_on, 0, "green");
	add_global_notetrack_handler("blue_cracks_on", &cracks_on, 0, "blue");
	add_global_notetrack_handler("all_cracks_on", &cracks_on, 0, "all");
	add_global_notetrack_handler("red_cracks_off", &cracks_off, 0, "red");
	add_global_notetrack_handler("green_cracks_off", &cracks_off, 0, "green");
	add_global_notetrack_handler("blue_cracks_off", &cracks_off, 0, "blue");
	add_global_notetrack_handler("all_cracks_off", &cracks_off, 0, "all");
	add_global_notetrack_handler("headlook_on", &enable_headlook, 0, 1);
	add_global_notetrack_handler("headlook_off", &enable_headlook, 0, 0);
	add_global_notetrack_handler("headlook_notorso_on", &enable_headlook_notorso, 0, 1);
	add_global_notetrack_handler("headlook_notorso_off", &enable_headlook_notorso, 0, 0);
	add_global_notetrack_handler("attach weapon", &attach_weapon, 1);
	add_global_notetrack_handler("detach weapon", &detach_weapon, 1);
	add_global_notetrack_handler("fire", &fire_weapon, 0);
}

/*
	Name: handle_notetracks
	Namespace: animation
	Checksum: 0xFEA4D261
	Offset: 0x2580
	Size: 0xCE
	Parameters: 1
	Flags: Linked
*/
function handle_notetracks(animation)
{
	self endon(#"death", #"new_scripted_anim");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(animation);
		str_note = waitresult.notetrack;
		if(isdefined(str_note))
		{
			if(str_note != "end" && str_note != "loop_end")
			{
				self thread call_notetrack_handler(str_note, waitresult.param1, waitresult.param2);
			}
			else
			{
				return;
			}
		}
	}
}

/*
	Name: cracks_on
	Namespace: animation
	Checksum: 0x7871723A
	Offset: 0x2658
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function cracks_on(str_type)
{
	switch(str_type)
	{
		case "red":
		{
			clientfield::set("cracks_on", 1);
			break;
		}
		case "green":
		{
			clientfield::set("cracks_on", 3);
			break;
		}
		case "blue":
		{
			clientfield::set("cracks_on", 2);
			break;
		}
		case "all":
		{
			clientfield::set("cracks_on", 4);
			break;
		}
	}
}

/*
	Name: cracks_off
	Namespace: animation
	Checksum: 0x7210DC84
	Offset: 0x2748
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function cracks_off(str_type)
{
	switch(str_type)
	{
		case "red":
		{
			clientfield::set("cracks_off", 1);
			break;
		}
		case "green":
		{
			clientfield::set("cracks_off", 3);
			break;
		}
		case "blue":
		{
			clientfield::set("cracks_off", 2);
			break;
		}
		case "all":
		{
			clientfield::set("cracks_off", 4);
			break;
		}
	}
}

/*
	Name: enable_headlook
	Namespace: animation
	Checksum: 0x6CD093FB
	Offset: 0x2838
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function enable_headlook(b_on = 1)
{
	if(isactor(self))
	{
		if(b_on)
		{
			self lookatentity(level.players[0]);
		}
		else
		{
			self lookatentity();
		}
	}
}

/*
	Name: enable_headlook_notorso
	Namespace: animation
	Checksum: 0xDE646D56
	Offset: 0x28B8
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function enable_headlook_notorso(b_on = 1)
{
	if(isactor(self))
	{
		if(b_on)
		{
			self lookatentity(level.players[0], 1);
		}
		else
		{
			self lookatentity();
		}
	}
}

/*
	Name: is_valid_weapon
	Namespace: animation
	Checksum: 0x3B42315
	Offset: 0x2940
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function is_valid_weapon(weaponobject)
{
	return isdefined(weaponobject) && weaponobject != level.weaponnone;
}

/*
	Name: attach_weapon
	Namespace: animation
	Checksum: 0xB7B6458E
	Offset: 0x2970
	Size: 0x162
	Parameters: 2
	Flags: Linked
*/
function attach_weapon(weaponobject, tag = "tag_weapon_right")
{
	if(isactor(self))
	{
		if(is_valid_weapon(weaponobject))
		{
			ai::gun_switchto(weaponobject.name, "right");
		}
		else
		{
			ai::gun_recall();
		}
	}
	else if(!is_valid_weapon(weaponobject))
	{
		weaponobject = self.last_item;
	}
	if(is_valid_weapon(weaponobject))
	{
		if(self.item != level.weaponnone)
		{
			detach_weapon();
		}
		/#
			assert(isdefined(weaponobject.worldmodel));
		#/
		self attach(weaponobject.worldmodel, tag);
		self setentityweapon(weaponobject);
		self.gun_removed = undefined;
		self.last_item = weaponobject;
	}
}

/*
	Name: detach_weapon
	Namespace: animation
	Checksum: 0xF170E8AF
	Offset: 0x2AE0
	Size: 0xE2
	Parameters: 2
	Flags: Linked
*/
function detach_weapon(weaponobject, tag = "tag_weapon_right")
{
	if(isactor(self))
	{
		ai::gun_remove();
	}
	else if(!is_valid_weapon(weaponobject))
	{
		weaponobject = self.item;
	}
	if(is_valid_weapon(weaponobject))
	{
		self detach(weaponobject.worldmodel, tag);
		self setentityweapon(level.weaponnone);
	}
	self.gun_removed = 1;
}

/*
	Name: fire_weapon
	Namespace: animation
	Checksum: 0x9472576B
	Offset: 0x2BD0
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function fire_weapon()
{
	if(!isai(self))
	{
		if(self.item != level.weaponnone)
		{
			v_start_pos = (isdefined(self gettagorigin("tag_flash")) ? self gettagorigin("tag_flash") : self gettagorigin("tag_aim"));
			v_start_ang = (isdefined(self gettagangles("tag_flash")) ? self gettagangles("tag_flash") : self gettagangles("tag_aim"));
			v_end_pos = v_start_pos + vectorscale(anglestoforward(v_start_ang), 100);
			magicbullet(self.item, v_start_pos, v_end_pos, self);
		}
	}
}

/*
	Name: function_eb0aa7cf
	Namespace: animation
	Checksum: 0x6C0A644A
	Offset: 0x2D30
	Size: 0x26C
	Parameters: 2
	Flags: Linked
*/
function function_eb0aa7cf(n_pulse = 100, bone)
{
	/#
		assert(!issentient(self), "");
	#/
	if(!isdefined(bone))
	{
		bone = "tag_physics_pulse";
	}
	var_8ef160cb = (isdefined(self gettagorigin(bone)) ? self gettagorigin(bone) : self getcentroid());
	n_pulse = float(n_pulse);
	if(n_pulse == 0)
	{
		self physicslaunch(var_8ef160cb);
	}
	else
	{
		var_cc487a10 = self gettagangles(bone);
		var_236556ec = vectorscale((0, 0, 1), 100);
		color = (1, 0, 0);
		if(isdefined(var_cc487a10))
		{
			var_236556ec = vectorscale(anglestoforward(var_cc487a10), n_pulse);
			color = (0, 1, 0);
		}
		else
		{
			var_57a69262 = (math::cointoss() ? 1 : -1);
			var_2059cf18 = (math::cointoss() ? 1 : -1);
			var_f98659c0 = (math::cointoss() ? 1 : -1);
			var_236556ec = vectorscale((var_57a69262, var_2059cf18, var_f98659c0), n_pulse);
			color = (1, 1, 0);
		}
		self physicslaunch(var_8ef160cb, var_236556ec);
		/#
			util::draw_arrow_time(var_8ef160cb, var_8ef160cb + var_236556ec, color, 2);
		#/
	}
}

