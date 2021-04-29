// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\animation_debug_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\shaderanim_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace animation;

/*
	Name: function_89f2df9
	Namespace: animation
	Checksum: 0xC664B82F
	Offset: 0x2A0
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
	Checksum: 0x8B029361
	Offset: 0x2E8
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int", &cf_cracks_on, 0, 0);
	clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int", &cf_cracks_off, 0, 0);
	setup_notetracks();
}

/*
	Name: first_frame
	Namespace: animation
	Checksum: 0x9F171162
	Offset: 0x3B8
	Size: 0x3C
	Parameters: 3
	Flags: None
*/
function first_frame(animation, v_origin_or_ent, v_angles_or_tag)
{
	self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

/*
	Name: play
	Namespace: animation
	Checksum: 0x647A1693
	Offset: 0x400
	Size: 0xFA
	Parameters: 9
	Flags: Linked
*/
function play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp, b_link = 0, n_start_time = 0)
{
	self endon(#"death");
	self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link, n_start_time);
	self waittill(#"scriptedanim");
}

/*
	Name: _play
	Namespace: animation
	Checksum: 0x9D25C773
	Offset: 0x508
	Size: 0x52C
	Parameters: 9
	Flags: Linked
*/
function _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp, b_link = 0, n_start_time)
{
	if(!isdefined(self))
	{
		return;
	}
	self notify(#"new_scripted_anim");
	self endon(#"new_scripted_anim", #"death");
	if(!isdefined(self.model) || self.model == #"")
	{
		/#
			/#
				assertmsg("" + self.origin);
			#/
		#/
		return;
	}
	flagsys::set_val("firstframe", n_rate == 0);
	flagsys::set(#"scripted_anim_this_frame");
	flagsys::set(#"scriptedanim");
	if(!isdefined(v_origin_or_ent))
	{
		v_origin_or_ent = self;
	}
	n_start_time = math::clamp(n_start_time, 0, 1);
	if(isvec(v_origin_or_ent) && isvec(v_angles_or_tag))
	{
		self animscripted("_anim_notify_", v_origin_or_ent, v_angles_or_tag, animation, n_blend_in, n_rate, n_start_time);
	}
	else if(isstring(v_angles_or_tag))
	{
		/#
			assert(isdefined(v_origin_or_ent.model), "" + animation + "" + v_angles_or_tag + "");
		#/
		v_pos = v_origin_or_ent gettagorigin(v_angles_or_tag);
		v_ang = v_origin_or_ent gettagangles(v_angles_or_tag);
		self.origin = v_pos;
		self.angles = v_ang;
		b_link = 1;
		self animscripted("_anim_notify_", self.origin, self.angles, animation, n_blend_in, n_rate, n_start_time);
	}
	else
	{
		v_angles = (isdefined(v_origin_or_ent.angles) ? v_origin_or_ent.angles : (0, 0, 0));
		v_origin = (isdefined(v_origin_or_ent.origin) ? v_origin_or_ent.origin : (0, 0, 0));
		self animscripted("_anim_notify_", v_origin, v_angles, animation, n_blend_in, n_rate, n_start_time);
	}
	if(n_start_time > 0)
	{
		self setanimtimebyname(animation, n_start_time, 1);
	}
	if(!b_link)
	{
		self unlink();
	}
	/#
		self.var_80c69db6 = "";
		self.var_6c4bb19 = {#v_angles_or_tag:v_angles_or_tag, #v_origin_or_ent:v_origin_or_ent, #animation:animation};
		level flagsys::clear("");
	#/
	self thread handle_notetracks();
	self waittill_end();
	if(b_link)
	{
		self unlink();
	}
	flagsys::clear(#"scriptedanim");
	flagsys::clear(#"firstframe");
	self.var_80c69db6 = undefined;
	self.var_6c4bb19 = undefined;
	waittillframeend();
	flagsys::clear(#"scripted_anim_this_frame");
}

/*
	Name: waittill_end
	Namespace: animation
	Checksum: 0x23974B15
	Offset: 0xA40
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
private function waittill_end()
{
	level endon(#"demo_jump");
	self waittill_match({#notetrack:"end"}, #"_anim_notify_");
}

/*
	Name: _get_align_ent
	Namespace: animation
	Checksum: 0x8B9C1436
	Offset: 0xA98
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
	Checksum: 0xE22003A9
	Offset: 0xAF0
	Size: 0x1A6
	Parameters: 2
	Flags: None
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
	Name: play_siege
	Namespace: animation
	Checksum: 0xAA186434
	Offset: 0xCA0
	Size: 0x16A
	Parameters: 4
	Flags: Linked
*/
function play_siege(str_anim, str_shot = "default", n_rate = 1, b_loop = 0)
{
	self notify(#"end");
	level endon(#"demo_jump");
	self endon(#"death");
	if(n_rate == 0)
	{
		self siegecmd("set_anim", str_anim, "set_shot", str_shot, "pause", "goto_start");
	}
	else
	{
		self siegecmd("set_anim", str_anim, "set_shot", str_shot, "unpause", "set_playback_speed", n_rate, "send_end_events", 1, (b_loop ? "loop" : "unloop"));
	}
	self waittill(#"end");
}

/*
	Name: add_notetrack_func
	Namespace: animation
	Checksum: 0x43AC02AC
	Offset: 0xE18
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
	Checksum: 0xD5ED63F2
	Offset: 0xEA0
	Size: 0x118
	Parameters: 3
	Flags: Linked, Variadic
*/
function add_global_notetrack_handler(str_note, func, vararg)
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
	level._animnotetrackhandlers[str_note][level._animnotetrackhandlers[str_note].size] = array(func, vararg);
}

/*
	Name: call_notetrack_handler
	Namespace: animation
	Checksum: 0xBBB8432C
	Offset: 0xFC0
	Size: 0x2BE
	Parameters: 1
	Flags: Linked
*/
function call_notetrack_handler(str_note)
{
	if(isdefined(level._animnotetrackhandlers) && isdefined(level._animnotetrackhandlers[str_note]))
	{
		foreach(handler in level._animnotetrackhandlers[str_note])
		{
			func = handler[0];
			args = handler[1];
			switch(args.size)
			{
				case 6:
				{
					self [[func]](args[0], args[1], args[2], args[3], args[4], args[5]);
					break;
				}
				case 5:
				{
					self [[func]](args[0], args[1], args[2], args[3], args[4]);
					break;
				}
				case 4:
				{
					self [[func]](args[0], args[1], args[2], args[3]);
					break;
				}
				case 3:
				{
					self [[func]](args[0], args[1], args[2]);
					break;
				}
				case 2:
				{
					self [[func]](args[0], args[1]);
					break;
				}
				case 1:
				{
					self [[func]](args[0]);
					break;
				}
				case 0:
				{
					self [[func]]();
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
	Name: setup_notetracks
	Namespace: animation
	Checksum: 0x29D62FAA
	Offset: 0x1288
	Size: 0x224
	Parameters: 0
	Flags: Linked
*/
function setup_notetracks()
{
	add_notetrack_func("flag::set", &flag::set);
	add_notetrack_func("flag::clear", &flag::clear);
	add_notetrack_func("postfx::PlayPostFxBundle", &postfx::playpostfxbundle);
	add_notetrack_func("postfx::StopPostFxBundle", &postfx::stoppostfxbundle);
	add_global_notetrack_handler("red_cracks_on", &cracks_on, "red");
	add_global_notetrack_handler("green_cracks_on", &cracks_on, "green");
	add_global_notetrack_handler("blue_cracks_on", &cracks_on, "blue");
	add_global_notetrack_handler("all_cracks_on", &cracks_on, "all");
	add_global_notetrack_handler("red_cracks_off", &cracks_off, "red");
	add_global_notetrack_handler("green_cracks_off", &cracks_off, "green");
	add_global_notetrack_handler("blue_cracks_off", &cracks_off, "blue");
	add_global_notetrack_handler("all_cracks_off", &cracks_off, "all");
}

/*
	Name: handle_notetracks
	Namespace: animation
	Checksum: 0xEDC9D1D0
	Offset: 0x14B8
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function handle_notetracks()
{
	self notify(#"handle_notetracks");
	level endon(#"demo_jump");
	self endon(#"handle_notetracks", #"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"_anim_notify_");
		str_note = waitresult.notetrack;
		if(str_note != "end" && str_note != "loop_end")
		{
			self thread call_notetrack_handler(str_note);
		}
		else
		{
			return;
		}
	}
}

/*
	Name: cracks_on
	Namespace: animation
	Checksum: 0x48D325AE
	Offset: 0x1598
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
			cf_cracks_on(self.localclientnum, 0, 1);
			break;
		}
		case "green":
		{
			cf_cracks_on(self.localclientnum, 0, 3);
			break;
		}
		case "blue":
		{
			cf_cracks_on(self.localclientnum, 0, 2);
			break;
		}
		case "all":
		{
			cf_cracks_on(self.localclientnum, 0, 4);
			break;
		}
	}
}

/*
	Name: cracks_off
	Namespace: animation
	Checksum: 0x57546519
	Offset: 0x1688
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
			cf_cracks_off(self.localclientnum, 0, 1);
			break;
		}
		case "green":
		{
			cf_cracks_off(self.localclientnum, 0, 3);
			break;
		}
		case "blue":
		{
			cf_cracks_off(self.localclientnum, 0, 2);
			break;
		}
		case "all":
		{
			cf_cracks_off(self.localclientnum, 0, 4);
			break;
		}
	}
}

/*
	Name: cf_cracks_on
	Namespace: animation
	Checksum: 0x5A0BD674
	Offset: 0x1778
	Size: 0x1B2
	Parameters: 7
	Flags: Linked
*/
function cf_cracks_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 3, 0, 1);
			break;
		}
		case 3:
		{
			shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 3, 0, 1);
			break;
		}
		case 2:
		{
			shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 3, 0, 1);
			break;
		}
		case 4:
		{
			shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 3, 0, 1);
			shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 3, 0, 1);
			shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 3, 0, 1);
		}
	}
}

/*
	Name: cf_cracks_off
	Namespace: animation
	Checksum: 0xF3C373E7
	Offset: 0x1938
	Size: 0x19A
	Parameters: 7
	Flags: Linked
*/
function cf_cracks_off(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 0, 1, 0);
			break;
		}
		case 3:
		{
			shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 0, 1, 0);
			break;
		}
		case 2:
		{
			shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 0, 1, 0);
			break;
		}
		case 4:
		{
			shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 0, 1, 0);
			shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 0, 1, 0);
			shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 0, 1, 0);
		}
	}
}

