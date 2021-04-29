// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace as_debug;

/*
	Name: function_89f2df9
	Namespace: as_debug
	Checksum: 0x29041158
	Offset: 0x70
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	/#
		system::register(#"as_debug", &__init__, undefined, undefined);
	#/
}

/*
	Name: __init__
	Namespace: as_debug
	Checksum: 0xE2EF0D5B
	Offset: 0xB8
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	/#
		level thread debugdvars();
	#/
}

/*
	Name: debugdvars
	Namespace: as_debug
	Checksum: 0x6B20EA56
	Offset: 0xE0
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function debugdvars()
{
	/#
		while(true)
		{
			if(getdvarint(#"debug_ai_clear_corpses", 0))
			{
				delete_all_ai_corpses();
			}
			waitframe(1);
		}
	#/
}

/*
	Name: isdebugon
	Namespace: as_debug
	Checksum: 0x5CBE5F58
	Offset: 0x140
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function isdebugon()
{
	/#
		return getdvarint(#"animdebug", 0) == 1 || (isdefined(anim.debugent) && anim.debugent == self);
	#/
}

/*
	Name: drawdebuglineinternal
	Namespace: as_debug
	Checksum: 0x8CCAADF8
	Offset: 0x1A0
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
	Name: drawdebugline
	Namespace: as_debug
	Checksum: 0x2F985C75
	Offset: 0x218
	Size: 0x5C
	Parameters: 4
	Flags: None
*/
function drawdebugline(frompoint, topoint, color, durationframes)
{
	/#
		if(isdebugon())
		{
			thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
		}
	#/
}

/*
	Name: debugline
	Namespace: as_debug
	Checksum: 0xCBCD2414
	Offset: 0x280
	Size: 0x74
	Parameters: 4
	Flags: None
*/
function debugline(frompoint, topoint, color, durationframes)
{
	/#
		for(i = 0; i < durationframes * 20; i++)
		{
			line(frompoint, topoint, color);
			waitframe(1);
		}
	#/
}

/*
	Name: drawdebugcross
	Namespace: as_debug
	Checksum: 0x6CFC9010
	Offset: 0x300
	Size: 0x144
	Parameters: 4
	Flags: None
*/
function drawdebugcross(atpoint, radius, color, durationframes)
{
	/#
		atpoint_high = atpoint + (0, 0, radius);
		atpoint_low = atpoint + (0, 0, -1 * radius);
		atpoint_left = atpoint + (0, radius, 0);
		atpoint_right = atpoint + (0, -1 * radius, 0);
		atpoint_forward = atpoint + (radius, 0, 0);
		atpoint_back = atpoint + (-1 * radius, 0, 0);
		thread debugline(atpoint_high, atpoint_low, color, durationframes);
		thread debugline(atpoint_left, atpoint_right, color, durationframes);
		thread debugline(atpoint_forward, atpoint_back, color, durationframes);
	#/
}

/*
	Name: updatedebuginfo
	Namespace: as_debug
	Checksum: 0x59308914
	Offset: 0x450
	Size: 0xA6
	Parameters: 0
	Flags: None
*/
function updatedebuginfo()
{
	/#
		self endon(#"death");
		self.debuginfo = spawnstruct();
		self.debuginfo.enabled = getdvarint(#"ai_debuganimscript", 0) > 0;
		debugclearstate();
		while(true)
		{
			waitframe(1);
			updatedebuginfointernal();
			waitframe(1);
		}
	#/
}

/*
	Name: updatedebuginfointernal
	Namespace: as_debug
	Checksum: 0xEC3E3E1F
	Offset: 0x500
	Size: 0x116
	Parameters: 0
	Flags: None
*/
function updatedebuginfointernal()
{
	/#
		if(isdefined(anim.debugent) && anim.debugent == self)
		{
			doinfo = 1;
		}
		else
		{
			doinfo = getdvarint(#"ai_debuganimscript", 0) > 0;
			if(doinfo)
			{
				ai_entnum = getdvarint(#"ai_debugentindex", 0);
				if(ai_entnum > -1 && ai_entnum != self getentitynumber())
				{
					doinfo = 0;
				}
			}
			if(!self.debuginfo.enabled && doinfo)
			{
				self.debuginfo.shouldclearonanimscriptchange = 1;
			}
			self.debuginfo.enabled = doinfo;
		}
	#/
}

/*
	Name: drawdebugenttext
	Namespace: as_debug
	Checksum: 0x13BB9FE2
	Offset: 0x620
	Size: 0x134
	Parameters: 4
	Flags: None
*/
function drawdebugenttext(text, ent, color, channel)
{
	/#
		/#
			assert(isdefined(ent));
		#/
		if(!getdvarint(#"recorder_enablerec", 0))
		{
			if(!isdefined(ent.debuganimscripttime) || gettime() > ent.debuganimscripttime)
			{
				ent.debuganimscriptlevel = 0;
				ent.debuganimscripttime = gettime();
			}
			indentlevel = vectorscale(vectorscale((0, 0, -1), 10), ent.debuganimscriptlevel);
			print3d(self.origin + vectorscale((0, 0, 1), 70) + indentlevel, text, color);
			ent.debuganimscriptlevel++;
		}
		else
		{
			recordenttext(text, ent, color, channel);
		}
	#/
}

/*
	Name: debugpushstate
	Namespace: as_debug
	Checksum: 0xEC141201
	Offset: 0x760
	Size: 0x196
	Parameters: 2
	Flags: None
*/
function debugpushstate(statename, extrainfo)
{
	/#
		if(!getdvarint(#"ai_debuganimscript", 0))
		{
			return;
		}
		ai_entnum = getdvarint(#"ai_debugentindex", 0);
		if(ai_entnum > -1 && ai_entnum != self getentitynumber())
		{
			return;
		}
		/#
			assert(isdefined(self.debuginfo.states));
		#/
		/#
			assert(isdefined(statename));
		#/
		state = spawnstruct();
		state.statename = statename;
		state.statelevel = self.debuginfo.statelevel;
		state.statetime = gettime();
		state.statevalid = 1;
		self.debuginfo.statelevel++;
		if(isdefined(extrainfo))
		{
			state.extrainfo = extrainfo + "";
		}
		self.debuginfo.states[self.debuginfo.states.size] = state;
	#/
}

/*
	Name: debugaddstateinfo
	Namespace: as_debug
	Checksum: 0xE46A451D
	Offset: 0x900
	Size: 0x2E6
	Parameters: 2
	Flags: None
*/
function debugaddstateinfo(statename, extrainfo)
{
	/#
		if(!getdvarint(#"ai_debuganimscript", 0))
		{
			return;
		}
		ai_entnum = getdvarint(#"ai_debugentindex", 0);
		if(ai_entnum > -1 && ai_entnum != self getentitynumber())
		{
			return;
		}
		/#
			assert(isdefined(self.debuginfo.states));
		#/
		if(isdefined(statename))
		{
			for(i = self.debuginfo.states.size - 1; i >= 0; i--)
			{
				/#
					assert(isdefined(self.debuginfo.states[i]));
				#/
				if(self.debuginfo.states[i].statename == statename)
				{
					if(!isdefined(self.debuginfo.states[i].extrainfo))
					{
						self.debuginfo.states[i].extrainfo = "";
					}
					self.debuginfo.states[i].extrainfo = self.debuginfo.states[i].extrainfo + extrainfo + "";
					break;
				}
			}
		}
		else if(self.debuginfo.states.size > 0)
		{
			lastindex = self.debuginfo.states.size - 1;
			/#
				assert(isdefined(self.debuginfo.states[lastindex]));
			#/
			if(!isdefined(self.debuginfo.states[lastindex].extrainfo))
			{
				self.debuginfo.states[lastindex].extrainfo = "";
			}
			self.debuginfo.states[lastindex].extrainfo = self.debuginfo.states[lastindex].extrainfo + extrainfo + "";
		}
	#/
}

/*
	Name: debugpopstate
	Namespace: as_debug
	Checksum: 0x242B9DAB
	Offset: 0xBF0
	Size: 0x342
	Parameters: 2
	Flags: None
*/
function debugpopstate(statename, exitreason)
{
	/#
		if(!getdvarint(#"ai_debuganimscript", 0) || self.debuginfo.states.size <= 0)
		{
			return;
		}
		ai_entnum = getdvarint(#"ai_debugentindex", 0);
		if(!isdefined(self) || !isalive(self))
		{
			return;
		}
		if(ai_entnum > -1 && ai_entnum != self getentitynumber())
		{
			return;
		}
		/#
			assert(isdefined(self.debuginfo.states));
		#/
		if(isdefined(statename))
		{
			for(i = 0; i < self.debuginfo.states.size; i++)
			{
				if(self.debuginfo.states[i].statename == statename && self.debuginfo.states[i].statevalid)
				{
					self.debuginfo.states[i].statevalid = 0;
					self.debuginfo.states[i].exitreason = exitreason;
					self.debuginfo.statelevel = self.debuginfo.states[i].statelevel;
					for(j = i + 1; j < self.debuginfo.states.size && self.debuginfo.states[j].statelevel > self.debuginfo.states[i].statelevel; j++)
					{
						self.debuginfo.states[j].statevalid = 0;
					}
					break;
				}
			}
		}
		else
		{
			for(i = self.debuginfo.states.size - 1; i >= 0; i--)
			{
				if(self.debuginfo.states[i].statevalid)
				{
					self.debuginfo.states[i].statevalid = 0;
					self.debuginfo.states[i].exitreason = exitreason;
					self.debuginfo.statelevel--;
					break;
				}
			}
		}
	#/
}

/*
	Name: debugclearstate
	Namespace: as_debug
	Checksum: 0x3D5017C7
	Offset: 0xF40
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function debugclearstate()
{
	/#
		self.debuginfo.states = [];
		self.debuginfo.statelevel = 0;
		self.debuginfo.shouldclearonanimscriptchange = 0;
	#/
}

/*
	Name: debugshouldclearstate
	Namespace: as_debug
	Checksum: 0xDA0FBE1D
	Offset: 0xF88
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function debugshouldclearstate()
{
	/#
		if(isdefined(self.debuginfo) && isdefined(self.debuginfo.shouldclearonanimscriptchange) && self.debuginfo.shouldclearonanimscriptchange)
		{
			return 1;
		}
		return 0;
	#/
}

/*
	Name: debugcleanstatestack
	Namespace: as_debug
	Checksum: 0xE25257CF
	Offset: 0xFE0
	Size: 0x9A
	Parameters: 0
	Flags: None
*/
function debugcleanstatestack()
{
	/#
		newarray = [];
		for(i = 0; i < self.debuginfo.states.size; i++)
		{
			if(self.debuginfo.states[i].statevalid)
			{
				newarray[newarray.size] = self.debuginfo.states[i];
			}
		}
		self.debuginfo.states = newarray;
	#/
}

/*
	Name: indent
	Namespace: as_debug
	Checksum: 0x14A25A30
	Offset: 0x1088
	Size: 0x5A
	Parameters: 1
	Flags: None
*/
function indent(depth)
{
	/#
		indent = "";
		for(i = 0; i < depth; i++)
		{
			indent = indent + "";
		}
		return indent;
	#/
}

/*
	Name: debugdrawweightedpoints
	Namespace: as_debug
	Checksum: 0xCC9E8ECF
	Offset: 0x10F0
	Size: 0xEE
	Parameters: 3
	Flags: None
*/
function debugdrawweightedpoints(entity, points, weights)
{
	/#
		lowestvalue = 0;
		highestvalue = 0;
		for(index = 0; index < points.size; index++)
		{
			if(weights[index] < lowestvalue)
			{
				lowestvalue = weights[index];
			}
			if(weights[index] > highestvalue)
			{
				highestvalue = weights[index];
			}
		}
		for(index = 0; index < points.size; index++)
		{
			debugdrawweightedpoint(entity, points[index], weights[index], lowestvalue, highestvalue);
		}
	#/
}

/*
	Name: debugdrawweightedpoint
	Namespace: as_debug
	Checksum: 0x4010FE2C
	Offset: 0x11E8
	Size: 0x15C
	Parameters: 5
	Flags: None
*/
function debugdrawweightedpoint(entity, point, weight, lowestvalue, highestvalue)
{
	/#
		deltavalue = highestvalue - lowestvalue;
		halfdeltavalue = deltavalue / 2;
		midvalue = lowestvalue + deltavalue / 2;
		if(halfdeltavalue == 0)
		{
			halfdeltavalue = 1;
		}
		if(weight <= midvalue)
		{
			redcolor = 1 - abs(weight - lowestvalue / halfdeltavalue);
			recordcircle(point, 2, (redcolor, 0, 0), "", entity);
		}
		else
		{
			greencolor = 1 - abs(highestvalue - weight / halfdeltavalue);
			recordcircle(point, 2, (0, greencolor, 0), "", entity);
		}
	#/
}

/*
	Name: delete_all_ai_corpses
	Namespace: as_debug
	Checksum: 0xD9DAD718
	Offset: 0x1350
	Size: 0xD0
	Parameters: 0
	Flags: None
*/
function delete_all_ai_corpses()
{
	/#
		setdvar(#"debug_ai_clear_corpses", 0);
		corpses = getcorpsearray();
		foreach(corpse in corpses)
		{
			if(isactorcorpse(corpse))
			{
				corpse delete();
			}
		}
	#/
}

