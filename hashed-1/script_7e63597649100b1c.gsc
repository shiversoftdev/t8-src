// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\sound_shared.gsc;

#namespace zombie_shared;

/*
	Name: deleteatlimit
	Namespace: zombie_shared
	Checksum: 0xE2F940EE
	Offset: 0x210
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function deleteatlimit()
{
	wait(30);
	self delete();
}

/*
	Name: lookatposition
	Namespace: zombie_shared
	Checksum: 0xD7E94A10
	Offset: 0x240
	Size: 0x1BE
	Parameters: 5
	Flags: None
*/
function lookatposition(looktargetpos, lookduration, lookspeed, eyesonly, interruptothers)
{
	/#
		assert(isai(self), "");
	#/
	/#
		assert(self.a.targetlookinitilized == 1, "");
	#/
	/#
		assert(lookspeed == "" || lookspeed == "", "");
	#/
	if(!isdefined(interruptothers) || interruptothers == "interrupt others" || gettime() > self.a.lookendtime)
	{
		self.a.looktargetpos = looktargetpos;
		self.a.lookendtime = gettime() + (lookduration * 1000);
		if(lookspeed == "casual")
		{
			self.a.looktargetspeed = 800;
		}
		else
		{
			self.a.looktargetspeed = 1600;
		}
		if(isdefined(eyesonly) && eyesonly == "eyes only")
		{
			self notify(#"hash_65f45f02d394bffe");
		}
		else
		{
			self notify(#"hash_23639563af2eae72");
		}
	}
}

/*
	Name: lookatanimations
	Namespace: zombie_shared
	Checksum: 0x6ABAE22C
	Offset: 0x408
	Size: 0x3A
	Parameters: 2
	Flags: None
*/
function lookatanimations(leftanim, rightanim)
{
	self.a.lookanimationleft = leftanim;
	self.a.lookanimationright = rightanim;
}

/*
	Name: handledogsoundnotetracks
	Namespace: zombie_shared
	Checksum: 0x5DF444A
	Offset: 0x450
	Size: 0x140
	Parameters: 1
	Flags: None
*/
function handledogsoundnotetracks(note)
{
	if(note == "sound_dogstep_run_default" || note == "dogstep_rf" || note == "dogstep_lf")
	{
		self playsound(#"fly_dog_step_run_default");
		return 1;
	}
	prefix = getsubstr(note, 0, 5);
	if(prefix != "sound")
	{
		return 0;
	}
	alias = "aml" + getsubstr(note, 5);
	if(isalive(self))
	{
		self thread sound::play_on_tag(alias, "tag_eye");
	}
	else
	{
		self thread sound::play_in_space(alias, self gettagorigin("tag_eye"));
	}
	return 1;
}

/*
	Name: growling
	Namespace: zombie_shared
	Checksum: 0x37FAE42B
	Offset: 0x598
	Size: 0xC
	Parameters: 0
	Flags: None
*/
function growling()
{
	return isdefined(self.script_growl);
}

/*
	Name: registernotetracks
	Namespace: zombie_shared
	Checksum: 0xC47B623A
	Offset: 0x5B0
	Size: 0x3F2
	Parameters: 0
	Flags: None
*/
function registernotetracks()
{
	anim.notetracks[#"hash_4c309a126c1a44ff"] = &notetrackposestand;
	anim.notetracks[#"hash_eafc4a7d7b6a027"] = &notetrackposecrouch;
	anim.notetracks[#"hash_ec5e7d2072ae0d5"] = &notetrackmovementstop;
	anim.notetracks[#"hash_4170f46935239626"] = &notetrackmovementwalk;
	anim.notetracks[#"hash_2c94246462ac6748"] = &notetrackmovementrun;
	anim.notetracks[#"hash_40fdc55d0cf02732"] = &notetrackalertnesscasual;
	anim.notetracks[#"hash_404f1950633f51b"] = &notetrackalertnessalert;
	anim.notetracks[#"gravity on"] = &notetrackgravity;
	anim.notetracks[#"gravity off"] = &notetrackgravity;
	anim.notetracks[#"hash_3a65333187809d2e"] = &notetrackgravity;
	anim.notetracks[#"bodyfall large"] = &notetrackbodyfall;
	anim.notetracks[#"bodyfall small"] = &notetrackbodyfall;
	anim.notetracks[#"footstep"] = &notetrackfootstep;
	anim.notetracks[#"step"] = &notetrackfootstep;
	anim.notetracks[#"footstep_right_large"] = &notetrackfootstep;
	anim.notetracks[#"footstep_right_small"] = &notetrackfootstep;
	anim.notetracks[#"footstep_left_large"] = &notetrackfootstep;
	anim.notetracks[#"footstep_left_small"] = &notetrackfootstep;
	anim.notetracks[#"footscrape"] = &notetrackfootscrape;
	anim.notetracks[#"land"] = &notetrackland;
	anim.notetracks[#"start_ragdoll"] = &notetrackstartragdoll;
}

/*
	Name: notetrackstopanim
	Namespace: zombie_shared
	Checksum: 0x13ABAE54
	Offset: 0x9B0
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function notetrackstopanim(note, flagname)
{
}

/*
	Name: notetrackstartragdoll
	Namespace: zombie_shared
	Checksum: 0x80E18200
	Offset: 0x9D0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function notetrackstartragdoll(note, flagname)
{
	if(isdefined(self.noragdoll))
	{
		return;
	}
	self unlink();
	self startragdoll();
}

/*
	Name: notetrackmovementstop
	Namespace: zombie_shared
	Checksum: 0x21BC5B83
	Offset: 0xA28
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function notetrackmovementstop(note, flagname)
{
	if(issentient(self))
	{
		self.a.movement = "stop";
	}
}

/*
	Name: notetrackmovementwalk
	Namespace: zombie_shared
	Checksum: 0xFAD5F8C2
	Offset: 0xA78
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function notetrackmovementwalk(note, flagname)
{
	if(issentient(self))
	{
		self.a.movement = "walk";
	}
}

/*
	Name: notetrackmovementrun
	Namespace: zombie_shared
	Checksum: 0x4FAA2DD3
	Offset: 0xAC8
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function notetrackmovementrun(note, flagname)
{
	if(issentient(self))
	{
		self.a.movement = "run";
	}
}

/*
	Name: notetrackalertnesscasual
	Namespace: zombie_shared
	Checksum: 0xE4A2823F
	Offset: 0xB18
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function notetrackalertnesscasual(note, flagname)
{
	if(issentient(self))
	{
		self.a.alertness = "casual";
	}
}

/*
	Name: notetrackalertnessalert
	Namespace: zombie_shared
	Checksum: 0x176C18CC
	Offset: 0xB68
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function notetrackalertnessalert(note, flagname)
{
	if(issentient(self))
	{
		self.a.alertness = "alert";
	}
}

/*
	Name: notetrackposestand
	Namespace: zombie_shared
	Checksum: 0x9CC53EE3
	Offset: 0xBB8
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function notetrackposestand(note, flagname)
{
	self.a.pose = "stand";
	self notify("entered_pose" + "stand");
}

/*
	Name: notetrackposecrouch
	Namespace: zombie_shared
	Checksum: 0x8D6C52E1
	Offset: 0xC00
	Size: 0x6E
	Parameters: 2
	Flags: Linked
*/
function notetrackposecrouch(note, flagname)
{
	self.a.pose = "crouch";
	self notify("entered_pose" + "crouch");
	if(self.a.crouchpain)
	{
		self.a.crouchpain = 0;
		self.health = 150;
	}
}

/*
	Name: notetrackgravity
	Namespace: zombie_shared
	Checksum: 0x466FE198
	Offset: 0xC78
	Size: 0xEE
	Parameters: 2
	Flags: Linked
*/
function notetrackgravity(note, flagname)
{
	if(issubstr(note, "on"))
	{
		self animmode("gravity");
	}
	else if(issubstr(note, "off"))
	{
		self animmode("nogravity");
		self.nogravity = 1;
	}
	else if(issubstr(note, "code"))
	{
		self animmode("none");
		self.nogravity = undefined;
	}
}

/*
	Name: notetrackbodyfall
	Namespace: zombie_shared
	Checksum: 0xBFF31E14
	Offset: 0xD70
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function notetrackbodyfall(note, flagname)
{
	if(isdefined(self.groundtype))
	{
		groundtype = self.groundtype;
	}
	else
	{
		groundtype = "dirt";
	}
	if(issubstr(note, "large"))
	{
		self playsound(#"fly_bodyfall_large_" + groundtype);
	}
	else if(issubstr(note, "small"))
	{
		self playsound(#"fly_bodyfall_small_" + groundtype);
	}
}

/*
	Name: notetrackfootstep
	Namespace: zombie_shared
	Checksum: 0x47C8720F
	Offset: 0xE48
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function notetrackfootstep(note, flagname)
{
	if(issubstr(note, "left"))
	{
		playfootstep("J_Ball_LE");
	}
	else
	{
		playfootstep("J_BALL_RI");
	}
	if(!level.clientscripts)
	{
		self playsound(#"fly_gear_run");
	}
}

/*
	Name: notetrackfootscrape
	Namespace: zombie_shared
	Checksum: 0xA652AEA5
	Offset: 0xEF0
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function notetrackfootscrape(note, flagname)
{
	if(isdefined(self.groundtype))
	{
		groundtype = self.groundtype;
	}
	else
	{
		groundtype = "dirt";
	}
	self playsound(#"fly_step_scrape_" + groundtype);
}

/*
	Name: notetrackland
	Namespace: zombie_shared
	Checksum: 0xB54A9FBC
	Offset: 0xF68
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function notetrackland(note, flagname)
{
	if(isdefined(self.groundtype))
	{
		groundtype = self.groundtype;
	}
	else
	{
		groundtype = "dirt";
	}
	self playsound(#"fly_land_npc_" + groundtype);
}

/*
	Name: handlenotetrack
	Namespace: zombie_shared
	Checksum: 0xF1BFB67D
	Offset: 0xFE0
	Size: 0x33A
	Parameters: 4
	Flags: Linked
*/
function handlenotetrack(note, flagname, customfunction, var1)
{
	if(isai(self) && isdefined(anim.notetracks))
	{
		notetrackfunc = anim.notetracks[note];
		if(isdefined(notetrackfunc))
		{
			return [[notetrackfunc]](note, flagname);
		}
	}
	switch(note)
	{
		case "undefined":
		case "end":
		case "finish":
		{
			return note;
		}
		case "hash_701bc5c059dfaa52":
		{
			self thread sound::play_in_space("fly_gear_enemy", self gettagorigin("TAG_WEAPON_RIGHT"));
			break;
		}
		case "hash_5f5e275b9f3b93ee":
		{
			self thread sound::play_in_space("fly_gear_enemy_large", self gettagorigin("TAG_WEAPON_RIGHT"));
			break;
		}
		case "hash_1c88a07f5d53a11c":
		{
			self.a.nodeath = 1;
			break;
		}
		case "hash_70c20f2d48c55e02":
		{
			self.allowpain = 0;
			break;
		}
		case "hash_50c6c08f5de3ec2a":
		{
			self.allowpain = 1;
			break;
		}
		case "hash_d734c21f2e3b83e":
		case "hash_39ec7b0969bab796":
		{
			self.a.meleestate = "right";
			break;
		}
		case "hash_1791db148d16d825":
		case "hash_6b554a9080ec8b07":
		{
			self.a.meleestate = "left";
			break;
		}
		case "swap taghelmet to tagleft":
		{
			if(isdefined(self.hatmodel))
			{
				if(isdefined(self.helmetsidemodel))
				{
					self detach(self.helmetsidemodel, "TAG_HELMETSIDE");
					self.helmetsidemodel = undefined;
				}
				self detach(self.hatmodel, "");
				self attach(self.hatmodel, "TAG_WEAPON_LEFT");
				self.hatmodel = undefined;
			}
			break;
		}
		default:
		{
			if(isdefined(customfunction))
			{
				if(!isdefined(var1))
				{
					return [[customfunction]](note);
				}
				else
				{
					return [[customfunction]](note, var1);
				}
			}
			break;
		}
	}
}

/*
	Name: donotetracks
	Namespace: zombie_shared
	Checksum: 0x554C59DC
	Offset: 0x1328
	Size: 0xA0
	Parameters: 3
	Flags: Linked
*/
function donotetracks(flagname, customfunction, var1)
{
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(flagname);
		note = waitresult.notetrack;
		if(!isdefined(note))
		{
			note = "undefined";
		}
		val = self handlenotetrack(note, flagname, customfunction, var1);
		if(isdefined(val))
		{
			return val;
		}
	}
}

/*
	Name: donotetracksforeverproc
	Namespace: zombie_shared
	Checksum: 0x632ECAE0
	Offset: 0x13D0
	Size: 0x12E
	Parameters: 5
	Flags: Linked
*/
function donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, var1)
{
	if(isdefined(killstring))
	{
		self endon(killstring, #"killanimscript");
	}
	for(;;)
	{
		time = gettime();
		returnednote = [[notetracksfunc]](flagname, customfunction, var1);
		timetaken = gettime() - time;
		if(timetaken < 0.05)
		{
			time = gettime();
			returnednote = [[notetracksfunc]](flagname, customfunction, var1);
			timetaken = gettime() - time;
			if(timetaken < 0.05)
			{
				/#
					println(((((gettime() + "") + flagname) + "") + returnednote) + "");
				#/
				wait(0.05 - timetaken);
			}
		}
	}
}

/*
	Name: donotetracksforever
	Namespace: zombie_shared
	Checksum: 0x9A6666CB
	Offset: 0x1508
	Size: 0x54
	Parameters: 4
	Flags: Linked
*/
function donotetracksforever(flagname, killstring, customfunction, var1)
{
	donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, var1);
}

/*
	Name: donotetracksfortimeproc
	Namespace: zombie_shared
	Checksum: 0x36D42B5
	Offset: 0x1568
	Size: 0x62
	Parameters: 6
	Flags: Linked
*/
function donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, ent, var1)
{
	ent endon(#"stop_notetracks");
	[[donotetracksforeverfunc]](flagname, undefined, customfunction, var1);
}

/*
	Name: donotetracksfortime
	Namespace: zombie_shared
	Checksum: 0xD7783E69
	Offset: 0x15D8
	Size: 0x84
	Parameters: 4
	Flags: None
*/
function donotetracksfortime(time, flagname, customfunction, var1)
{
	ent = spawnstruct();
	ent thread donotetracksfortimeendnotify(time);
	donotetracksfortimeproc(&donotetracksforever, time, flagname, customfunction, ent, var1);
}

/*
	Name: donotetracksfortimeendnotify
	Namespace: zombie_shared
	Checksum: 0x8CA9221D
	Offset: 0x1668
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function donotetracksfortimeendnotify(time)
{
	wait(time);
	self notify(#"stop_notetracks");
}

/*
	Name: playfootstep
	Namespace: zombie_shared
	Checksum: 0xAF46EC61
	Offset: 0x1698
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function playfootstep(foot)
{
	if(!level.clientscripts)
	{
		if(!isai(self))
		{
			self playsound(#"fly_step_run_dirt");
			return;
		}
	}
	groundtype = undefined;
	if(!isdefined(self.groundtype))
	{
		if(!isdefined(self.lastgroundtype))
		{
			if(!level.clientscripts)
			{
				self playsound(#"fly_step_run_dirt");
			}
			return;
		}
		groundtype = self.lastgroundtype;
	}
	else
	{
		groundtype = self.groundtype;
		self.lastgroundtype = self.groundtype;
	}
	if(!level.clientscripts)
	{
		self playsound(#"fly_step_run_" + groundtype);
	}
	[[anim.optionalstepeffectfunction]](foot, groundtype);
}

/*
	Name: playfootstepeffect
	Namespace: zombie_shared
	Checksum: 0xB7A6ED4D
	Offset: 0x17C0
	Size: 0x100
	Parameters: 2
	Flags: Linked
*/
function playfootstepeffect(foot, groundtype)
{
	if(level.clientscripts)
	{
		return;
	}
	for(i = 0; i < anim.optionalstepeffects.size; i++)
	{
		if(isdefined(self.fire_footsteps) && self.fire_footsteps)
		{
			groundtype = "fire";
		}
		if(groundtype != anim.optionalstepeffects[i])
		{
			continue;
		}
		org = self gettagorigin(foot);
		playfx(level._effect["step_" + anim.optionalstepeffects[i]], org, org + vectorscale((0, 0, 1), 100));
		return;
	}
}

/*
	Name: movetooriginovertime
	Namespace: zombie_shared
	Checksum: 0xE1387C8D
	Offset: 0x18C8
	Size: 0x15E
	Parameters: 2
	Flags: None
*/
function movetooriginovertime(origin, time)
{
	self endon(#"killanimscript");
	if(distancesquared(self.origin, origin) > 256 && !self maymovetopoint(origin))
	{
		/#
			println(("" + origin) + "");
		#/
		return;
	}
	self.keepclaimednodeingoal = 1;
	offset = self.origin - origin;
	frames = int(time * 20);
	offsetreduction = vectorscale(offset, 1 / frames);
	for(i = 0; i < frames; i++)
	{
		offset = offset - offsetreduction;
		self teleport(origin + offset);
		waitframe(1);
	}
	self.keepclaimednodeingoal = 0;
}

/*
	Name: returntrue
	Namespace: zombie_shared
	Checksum: 0x85020D4F
	Offset: 0x1A30
	Size: 0x8
	Parameters: 0
	Flags: None
*/
function returntrue()
{
	return 1;
}

/*
	Name: setanimaimweight
	Namespace: zombie_shared
	Checksum: 0xE8170652
	Offset: 0x1A40
	Size: 0xFA
	Parameters: 2
	Flags: None
*/
function setanimaimweight(goalweight, goaltime)
{
	if(!isdefined(goaltime) || goaltime <= 0)
	{
		self.a.aimweight = goalweight;
		self.a.aimweight_start = goalweight;
		self.a.aimweight_end = goalweight;
		self.a.aimweight_transframes = 0;
	}
	else
	{
		self.a.aimweight = goalweight;
		self.a.aimweight_start = self.a.aimweight;
		self.a.aimweight_end = goalweight;
		self.a.aimweight_transframes = int(goaltime * 20);
	}
	self.a.aimweight_t = 0;
}

/*
	Name: incranimaimweight
	Namespace: zombie_shared
	Checksum: 0x9064E153
	Offset: 0x1B48
	Size: 0xAE
	Parameters: 0
	Flags: None
*/
function incranimaimweight()
{
	if(self.a.aimweight_t < self.a.aimweight_transframes)
	{
		self.a.aimweight_t++;
		t = (1 * self.a.aimweight_t) / self.a.aimweight_transframes;
		self.a.aimweight = (self.a.aimweight_start * (1 - t)) + (self.a.aimweight_end * t);
	}
}

