// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace microwave_turret;

/*
	Name: init_shared
	Namespace: microwave_turret
	Checksum: 0x4E5E2024
	Offset: 0x218
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	clientfield::register("vehicle", "turret_microwave_open", 1, 1, "int", &microwave_open, 0, 0);
	clientfield::register("scriptmover", "turret_microwave_init", 1, 1, "int", &microwave_init_anim, 0, 0);
	clientfield::register("scriptmover", "turret_microwave_close", 1, 1, "int", &microwave_close_anim, 0, 0);
}

/*
	Name: turret_microwave_sound_start
	Namespace: microwave_turret
	Checksum: 0xB6CFCE86
	Offset: 0x300
	Size: 0x1F4
	Parameters: 1
	Flags: None
*/
function turret_microwave_sound_start(localclientnum)
{
	self endon(#"death");
	self endon(#"sound_stop");
	if(isdefined(self.sound_loop_enabled) && self.sound_loop_enabled)
	{
		return;
	}
	self playsound(0, #"wpn_micro_turret_start");
	wait(0.7);
	origin = self gettagorigin("tag_flash");
	angles = self gettagangles("tag_flash");
	forward = anglestoforward(angles);
	forward = vectorscale(forward, 750);
	trace = bullettrace(origin, origin + forward, 0, self);
	start = origin;
	end = trace[#"position"];
	self.microwave_audio_start = start;
	self.microwave_audio_end = end;
	self thread turret_microwave_sound_updater();
	if(!(isdefined(self.sound_loop_enabled) && self.sound_loop_enabled))
	{
		self.sound_loop_enabled = 1;
		soundlineemitter(#"wpn_micro_turret_loop", self.microwave_audio_start, self.microwave_audio_end);
		self thread turret_microwave_sound_off_waiter(localclientnum);
	}
}

/*
	Name: turret_microwave_sound_off_waiter
	Namespace: microwave_turret
	Checksum: 0xAEC8AB09
	Offset: 0x500
	Size: 0xBE
	Parameters: 1
	Flags: None
*/
function turret_microwave_sound_off_waiter(localclientnum)
{
	msg = undefined;
	msg = self waittill(#"sound_stop", #"death");
	if(msg === "sound_stop")
	{
		playsound(0, #"wpn_micro_turret_stop", self.microwave_audio_start);
	}
	soundstoplineemitter(#"wpn_micro_turret_loop", self.microwave_audio_start, self.microwave_audio_end);
	if(isdefined(self))
	{
		self.sound_loop_enabled = 0;
	}
}

/*
	Name: turret_microwave_sound_updater
	Namespace: microwave_turret
	Checksum: 0xCF311EB1
	Offset: 0x5C8
	Size: 0x1C8
	Parameters: 0
	Flags: None
*/
function turret_microwave_sound_updater()
{
	self endon(#"beam_stop");
	self endon(#"death");
	while(true)
	{
		origin = self gettagorigin("tag_flash");
		if(origin[0] != self.microwave_audio_start[0] || origin[1] != self.microwave_audio_start[1] || origin[2] != self.microwave_audio_start[2])
		{
			previousstart = self.microwave_audio_start;
			previousend = self.microwave_audio_end;
			angles = self gettagangles("tag_flash");
			forward = anglestoforward(angles);
			forward = vectorscale(forward, 750);
			trace = bullettrace(origin, origin + forward, 0, self);
			self.microwave_audio_start = origin;
			self.microwave_audio_end = trace[#"position"];
			soundupdatelineemitter(#"wpn_micro_turret_loop", previousstart, previousend, self.microwave_audio_start, self.microwave_audio_end);
		}
		wait(0.1);
	}
}

/*
	Name: microwave_init_anim
	Namespace: microwave_turret
	Checksum: 0x33B93775
	Offset: 0x798
	Size: 0x46
	Parameters: 7
	Flags: None
*/
function microwave_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!newval)
	{
		return;
	}
}

/*
	Name: microwave_open
	Namespace: microwave_turret
	Checksum: 0xDF369F0F
	Offset: 0x7E8
	Size: 0x7C
	Parameters: 7
	Flags: None
*/
function microwave_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!newval)
	{
		self notify(#"beam_stop");
		self notify(#"sound_stop");
		return;
	}
	self thread startmicrowavefx(localclientnum);
}

/*
	Name: microwave_close_anim
	Namespace: microwave_turret
	Checksum: 0x19EE3D59
	Offset: 0x870
	Size: 0x46
	Parameters: 7
	Flags: None
*/
function microwave_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!newval)
	{
		return;
	}
}

/*
	Name: debug_trace
	Namespace: microwave_turret
	Checksum: 0x355463B0
	Offset: 0x8C0
	Size: 0xEC
	Parameters: 2
	Flags: None
*/
function debug_trace(origin, trace)
{
	/#
		if(trace[#"fraction"] < 1)
		{
			color = (0.95, 0.05, 0.05);
		}
		else
		{
			color = (0.05, 0.95, 0.05);
		}
		sphere(trace[#"position"], 5, color, 0.75, 1, 10, 100);
		util::debug_line(origin, trace[#"position"], color, 100);
	#/
}

/*
	Name: startmicrowavefx
	Namespace: microwave_turret
	Checksum: 0xD5297A7A
	Offset: 0x9B8
	Size: 0x4F8
	Parameters: 1
	Flags: None
*/
function startmicrowavefx(localclientnum)
{
	turret = self;
	turret endon(#"death");
	turret endon(#"beam_stop");
	turret.should_update_fx = 1;
	self thread turret_microwave_sound_start(localclientnum);
	origin = turret gettagorigin("tag_flash");
	angles = turret gettagangles("tag_flash");
	microwavefxent = spawn(localclientnum, origin, "script_model");
	microwavefxent setmodel(#"tag_microwavefx");
	microwavefxent.angles = angles;
	microwavefxent linkto(turret, "tag_flash");
	microwavefxent.fxhandles = [];
	microwavefxent.fxnames = [];
	microwavefxent.fxhashs = [];
	self thread updatemicrowaveaim(microwavefxent);
	self thread cleanupfx(localclientnum, microwavefxent);
	wait(0.3);
	while(true)
	{
		/#
			if(getdvarint(#"scr_microwave_turret_fx_debug", 0))
			{
				turret.should_update_fx = 1;
				microwavefxent.fxhashs[#"center"] = 0;
			}
		#/
		if(turret.should_update_fx == 0)
		{
			wait(1);
			continue;
		}
		if(isdefined(level.last_microwave_turret_fx_trace) && level.last_microwave_turret_fx_trace == gettime())
		{
			waitframe(1);
			continue;
		}
		angles = turret gettagangles("tag_flash");
		origin = turret gettagorigin("tag_flash");
		forward = anglestoforward(angles);
		forward = vectorscale(forward, 750 + 40);
		var_e2e9fefa = anglestoforward(angles + (0, 55 / 3, 0));
		var_e2e9fefa = vectorscale(var_e2e9fefa, 750 + 40);
		trace = bullettrace(origin, origin + forward, 0, turret);
		traceright = bullettrace(origin, origin - var_e2e9fefa, 0, turret);
		traceleft = bullettrace(origin, origin + var_e2e9fefa, 0, turret);
		/#
			if(getdvarint(#"scr_microwave_turret_fx_debug", 0))
			{
				debug_trace(origin, trace);
				debug_trace(origin, traceright);
				debug_trace(origin, traceleft);
			}
		#/
		need_to_rebuild = microwavefxent microwavefxhash(trace, origin, "center");
		need_to_rebuild = need_to_rebuild | microwavefxent microwavefxhash(traceright, origin, "right");
		need_to_rebuild = need_to_rebuild | microwavefxent microwavefxhash(traceleft, origin, "left");
		level.last_microwave_turret_fx_trace = gettime();
		if(!need_to_rebuild)
		{
			wait(1);
			continue;
		}
		wait(0.1);
		microwavefxent playmicrowavefx(localclientnum, trace, traceright, traceleft, origin);
		turret.should_update_fx = 0;
		wait(1);
	}
}

/*
	Name: updatemicrowaveaim
	Namespace: microwave_turret
	Checksum: 0x54EFF9AC
	Offset: 0xEB8
	Size: 0xD0
	Parameters: 1
	Flags: None
*/
function updatemicrowaveaim(microwavefxent)
{
	turret = self;
	turret endon(#"death");
	turret endon(#"beam_stop");
	while(true)
	{
		angles = turret gettagangles("tag_flash");
		if(last_angles != angles)
		{
			turret.should_update_fx = 1;
			last_angles = angles;
		}
		wait(0.1);
	}
}

/*
	Name: microwavefxhash
	Namespace: microwave_turret
	Checksum: 0xC43761AF
	Offset: 0xF90
	Size: 0x1A8
	Parameters: 3
	Flags: None
*/
function microwavefxhash(trace, origin, name)
{
	hash = 0;
	counter = 2;
	for(i = 0; i < 5; i++)
	{
		endofhalffxsq = i * 150 + 125 * i * 150 + 125;
		endoffullfxsq = i * 150 + 200 * i * 150 + 200;
		tracedistsq = distancesquared(origin, trace[#"position"]);
		if(tracedistsq >= endofhalffxsq || i == 0)
		{
			if(tracedistsq < endoffullfxsq)
			{
				hash = hash + 1;
			}
			else
			{
				hash = hash + counter;
			}
		}
		counter = counter * 2;
	}
	if(!isdefined(self.fxhashs[name]))
	{
		self.fxhashs[name] = 0;
	}
	last_hash = self.fxhashs[name];
	self.fxhashs[name] = hash;
	return last_hash != hash;
}

/*
	Name: cleanupfx
	Namespace: microwave_turret
	Checksum: 0x23250BEA
	Offset: 0x1140
	Size: 0xD4
	Parameters: 2
	Flags: None
*/
function cleanupfx(localclientnum, microwavefxent)
{
	self waittill(#"death", #"beam_stop");
	foreach(handle in microwavefxent.fxhandles)
	{
		if(isdefined(handle))
		{
			stopfx(localclientnum, handle);
		}
	}
	microwavefxent delete();
}

/*
	Name: play_fx_on_tag
	Namespace: microwave_turret
	Checksum: 0xE265EA1F
	Offset: 0x1220
	Size: 0xAA
	Parameters: 3
	Flags: None
*/
function play_fx_on_tag(localclientnum, fxname, tag)
{
	if(!isdefined(self.fxhandles[tag]) || fxname != self.fxnames[tag])
	{
		stop_fx_on_tag(localclientnum, fxname, tag);
		self.fxnames[tag] = fxname;
		self.fxhandles[tag] = util::playfxontag(localclientnum, fxname, self, tag);
	}
}

/*
	Name: stop_fx_on_tag
	Namespace: microwave_turret
	Checksum: 0xBCA34E8B
	Offset: 0x12D8
	Size: 0x74
	Parameters: 3
	Flags: None
*/
function stop_fx_on_tag(localclientnum, fxname, tag)
{
	if(isdefined(self.fxhandles[tag]))
	{
		stopfx(localclientnum, self.fxhandles[tag]);
		self.fxhandles[tag] = undefined;
		self.fxnames[tag] = undefined;
	}
}

/*
	Name: render_debug_sphere
	Namespace: microwave_turret
	Checksum: 0xEA415C35
	Offset: 0x1358
	Size: 0x94
	Parameters: 3
	Flags: None
*/
function render_debug_sphere(tag, color, fxname)
{
	/#
		if(getdvarint(#"scr_microwave_turret_fx_debug", 0))
		{
			origin = self gettagorigin(tag);
			sphere(origin, 2, color, 0.75, 1, 10, 100);
		}
	#/
}

/*
	Name: stop_or_start_fx
	Namespace: microwave_turret
	Checksum: 0xBC0D5BB9
	Offset: 0x13F8
	Size: 0xE4
	Parameters: 4
	Flags: None
*/
function stop_or_start_fx(localclientnum, fxname, tag, start)
{
	if(start)
	{
		self play_fx_on_tag(localclientnum, fxname, tag);
		/#
			if(fxname == "")
			{
				render_debug_sphere(tag, vectorscale((1, 1, 0), 0.5), fxname);
			}
			else
			{
				render_debug_sphere(tag, (0, 1, 0), fxname);
			}
		#/
	}
	else
	{
		stop_fx_on_tag(localclientnum, fxname, tag);
		/#
			render_debug_sphere(tag, (1, 0, 0), fxname);
		#/
	}
}

/*
	Name: playmicrowavefx
	Namespace: microwave_turret
	Checksum: 0x4A7D7B74
	Offset: 0x14E8
	Size: 0x58C
	Parameters: 5
	Flags: None
*/
function playmicrowavefx(localclientnum, trace, traceright, traceleft, origin)
{
	for(i = 0; i < 5; i++)
	{
		endofhalffxsq = i * 150 + 125 * i * 150 + 125;
		endoffullfxsq = i * 150 + 200 * i * 150 + 200;
		tracedistsq = distancesquared(origin, trace[#"position"]);
		startfx = tracedistsq >= endofhalffxsq || i == 0;
		fxname = (tracedistsq < endoffullfxsq ? "killstreaks/fx_sg_distortion_cone_ash_sm" : "killstreaks/fx_sg_distortion_cone_ash");
		switch(i)
		{
			case 0:
			{
				self play_fx_on_tag(localclientnum, fxname, "tag_fx11");
				break;
			}
			case 1:
			{
				break;
			}
			case 2:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx32", startfx);
				break;
			}
			case 3:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx42", startfx);
				self stop_or_start_fx(localclientnum, fxname, "tag_fx43", startfx);
				break;
			}
			case 4:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx53", startfx);
				break;
			}
		}
		tracedistsq = distancesquared(origin, traceleft[#"position"]);
		startfx = tracedistsq >= endofhalffxsq;
		fxname = (tracedistsq < endoffullfxsq ? "killstreaks/fx_sg_distortion_cone_ash_sm" : "killstreaks/fx_sg_distortion_cone_ash");
		switch(i)
		{
			case 0:
			{
				break;
			}
			case 1:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx22", startfx);
				break;
			}
			case 2:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx33", startfx);
				break;
			}
			case 3:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx44", startfx);
				break;
			}
			case 4:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx54", startfx);
				self stop_or_start_fx(localclientnum, fxname, "tag_fx55", startfx);
				break;
			}
		}
		tracedistsq = distancesquared(origin, traceright[#"position"]);
		startfx = tracedistsq >= endofhalffxsq;
		fxname = (tracedistsq < endoffullfxsq ? "killstreaks/fx_sg_distortion_cone_ash_sm" : "killstreaks/fx_sg_distortion_cone_ash");
		switch(i)
		{
			case 0:
			{
				break;
			}
			case 1:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx21", startfx);
				break;
			}
			case 2:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx31", startfx);
				break;
			}
			case 3:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx41", startfx);
				break;
			}
			case 4:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx51", startfx);
				self stop_or_start_fx(localclientnum, fxname, "tag_fx52", startfx);
				break;
			}
		}
	}
}

