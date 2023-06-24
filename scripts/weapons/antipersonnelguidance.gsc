// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace singlelockap_guidance;

/*
	Name: __init__system__
	Namespace: singlelockap_guidance
	Checksum: 0x9B4B4C3A
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"singlelockap_guidance", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: singlelockap_guidance
	Checksum: 0xA72223B1
	Offset: 0xF8
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: singlelockap_guidance
	Checksum: 0x1918B21E
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	self endon(#"disconnect");
	self clearaptarget();
	thread aptoggleloop();
}

/*
	Name: clearaptarget
	Namespace: singlelockap_guidance
	Checksum: 0x1A095955
	Offset: 0x170
	Size: 0x224
	Parameters: 2
	Flags: None
*/
function clearaptarget(weapon, whom)
{
	if(!isdefined(self.multilocklist))
	{
		self.multilocklist = [];
	}
	if(isdefined(whom))
	{
		for(i = 0; i < self.multilocklist.size; i++)
		{
			if(whom.aptarget == self.multilocklist[i].aptarget)
			{
				self.multilocklist[i].aptarget notify(#"missile_unlocked");
				self notify("stop_sound" + whom.apsoundid);
				self weaponlockremoveslot(i);
				arrayremovevalue(self.multilocklist, whom, 0);
				break;
			}
		}
	}
	else
	{
		for(i = 0; i < self.multilocklist.size; i++)
		{
			self.multilocklist[i].aptarget notify(#"missile_unlocked");
			self notify("stop_sound" + self.multilocklist[i].apsoundid);
		}
		self.multilocklist = [];
	}
	if(self.multilocklist.size == 0)
	{
		self stoprumble("stinger_lock_rumble");
		self weaponlockremoveslot(-1);
		if(isdefined(weapon))
		{
			if(isdefined(weapon.lockonseekersearchsound))
			{
				self stoplocalsound(weapon.lockonseekersearchsound);
			}
			if(isdefined(weapon.lockonseekerlockedsound))
			{
				self stoplocalsound(weapon.lockonseekerlockedsound);
			}
		}
	}
}

/*
	Name: function_dc710809
	Namespace: singlelockap_guidance
	Checksum: 0x92BC179E
	Offset: 0x3A0
	Size: 0x144
	Parameters: 1
	Flags: Event
*/
event function_dc710809(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	missile = eventstruct.projectile;
	weapon = eventstruct.weapon;
	if(weapon.lockontype == "AP Single")
	{
		foreach(target in self.multilocklist)
		{
			if(isdefined(target.aptarget) && target.aplockfinalized)
			{
				target.aptarget notify(#"stinger_fired_at_me", {#attacker:self, #weapon:weapon, #projectile:missile});
			}
		}
	}
}

/*
	Name: aptoggleloop
	Namespace: singlelockap_guidance
	Checksum: 0x6BCF4264
	Offset: 0x4F0
	Size: 0x196
	Parameters: 0
	Flags: None
*/
function aptoggleloop()
{
	self endon(#"disconnect", #"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		weapon = waitresult.weapon;
		while(weapon.lockontype == "AP Single")
		{
			abort = 0;
			while(!self playerads() == 1)
			{
				waitframe(1);
				currentweapon = self getcurrentweapon();
				if(currentweapon.lockontype != "AP Single")
				{
					abort = 1;
					break;
				}
			}
			if(abort)
			{
				break;
			}
			self thread aplockloop(weapon);
			while(self playerads() == 1)
			{
				waitframe(1);
			}
			self notify(#"ap_off");
			self clearaptarget(weapon);
			weapon = self getcurrentweapon();
		}
	}
}

/*
	Name: aplockloop
	Namespace: singlelockap_guidance
	Checksum: 0xD51F1F49
	Offset: 0x690
	Size: 0x4EA
	Parameters: 1
	Flags: None
*/
function aplockloop(weapon)
{
	self endon(#"disconnect", #"death", #"ap_off");
	locklength = self getlockonspeed();
	self.multilocklist = [];
	for(;;)
	{
		waitframe(1);
		do
		{
			done = 1;
			foreach(target in self.multilocklist)
			{
				if(target.aplockfinalized)
				{
					if(!isstillvalidtarget(weapon, target.aptarget))
					{
						self clearaptarget(weapon, target);
						done = 0;
						break;
					}
				}
			}
		}
		while(!done);
		inlockingstate = 0;
		do
		{
			done = 1;
			for(i = 0; i < self.multilocklist.size; i++)
			{
				target = self.multilocklist[i];
				if(target.aplocking)
				{
					if(!isstillvalidtarget(weapon, target.aptarget))
					{
						self clearaptarget(weapon, target);
						done = 0;
						break;
					}
					inlockingstate = 1;
					timepassed = gettime() - target.aplockstarttime;
					if(timepassed < locklength)
					{
						continue;
					}
					/#
						assert(isdefined(target.aptarget));
					#/
					target.aplockfinalized = 1;
					target.aplocking = 0;
					target.aplockpending = 0;
					self weaponlockfinalize(target.aptarget, i);
					self thread seekersound(weapon.lockonseekerlockedsound, weapon.lockonseekerlockedsoundloops, target.apsoundid);
					target.aptarget notify(#"missile_lock", {#weapon:weapon, #attacker:self});
				}
			}
		}
		while(!done);
		if(!inlockingstate)
		{
			do
			{
				done = 1;
				for(i = 0; i < self.multilocklist.size; i++)
				{
					target = self.multilocklist[i];
					if(target.aplockpending)
					{
						if(!isstillvalidtarget(weapon, target.aptarget))
						{
							self clearaptarget(weapon, target);
							done = 0;
							break;
						}
						target.aplockstarttime = gettime();
						target.aplockfinalized = 0;
						target.aplockpending = 0;
						target.aplocking = 1;
						self thread seekersound(weapon.lockonseekersearchsound, weapon.lockonseekersearchsoundloops, target.apsoundid);
						done = 1;
						break;
					}
				}
			}
			while(!done);
		}
		if(self.multilocklist.size >= 1)
		{
			continue;
		}
		besttarget = self getbesttarget(weapon);
		if(!isdefined(besttarget) && self.multilocklist.size == 0)
		{
			continue;
		}
		if(isdefined(besttarget) && self.multilocklist.size < 1)
		{
			self weaponlockstart(besttarget.aptarget, self.multilocklist.size);
			self.multilocklist[self.multilocklist.size] = besttarget;
		}
	}
}

/*
	Name: getbesttarget
	Namespace: singlelockap_guidance
	Checksum: 0xAAD8A291
	Offset: 0xB88
	Size: 0x4CA
	Parameters: 1
	Flags: None
*/
function getbesttarget(weapon)
{
	playertargets = getplayers();
	vehicletargets = target_getarray();
	targetsall = getaiteamarray();
	targetsall = arraycombine(targetsall, playertargets, 0, 0);
	targetsall = arraycombine(targetsall, vehicletargets, 0, 0);
	targetsvalid = [];
	for(idx = 0; idx < targetsall.size; idx++)
	{
		if(level.teambased)
		{
			if(isdefined(targetsall[idx].team) && targetsall[idx].team != self.team)
			{
				if(self insideapreticlenolock(targetsall[idx]))
				{
					if(self locksighttest(targetsall[idx]))
					{
						targetsvalid[targetsvalid.size] = targetsall[idx];
					}
				}
			}
			continue;
		}
		if(self insideapreticlenolock(targetsall[idx]))
		{
			if(isdefined(targetsall[idx].owner) && self != targetsall[idx].owner)
			{
				if(self locksighttest(targetsall[idx]))
				{
					targetsvalid[targetsvalid.size] = targetsall[idx];
				}
			}
		}
	}
	if(targetsvalid.size == 0)
	{
		return undefined;
	}
	playerforward = anglestoforward(self getplayerangles());
	dots = [];
	for(i = 0; i < targetsvalid.size; i++)
	{
		newitem = spawnstruct();
		newitem.index = i;
		newitem.dot = vectordot(playerforward, vectornormalize(targetsvalid[i].origin - self.origin));
		array::add_sorted(dots, newitem, 0, &targetinsertionsortcompare);
	}
	index = 0;
	foreach(dot in dots)
	{
		found = 0;
		foreach(lock in self.multilocklist)
		{
			if(lock.aptarget == targetsvalid[dot.index])
			{
				found = 1;
			}
		}
		if(found)
		{
			continue;
		}
		newentry = spawnstruct();
		newentry.aptarget = targetsvalid[dot.index];
		newentry.aplockstarttime = gettime();
		newentry.aplockpending = 1;
		newentry.aplocking = 0;
		newentry.aplockfinalized = 0;
		newentry.aplostsightlinetime = 0;
		newentry.apsoundid = randomint(2147483647);
		return newentry;
	}
	return undefined;
}

/*
	Name: targetinsertionsortcompare
	Namespace: singlelockap_guidance
	Checksum: 0x546658EB
	Offset: 0x1060
	Size: 0x56
	Parameters: 2
	Flags: None
*/
function targetinsertionsortcompare(a, b)
{
	if(a.dot < b.dot)
	{
		return -1;
	}
	if(a.dot > b.dot)
	{
		return 1;
	}
	return 0;
}

/*
	Name: insideapreticlenolock
	Namespace: singlelockap_guidance
	Checksum: 0xE942792C
	Offset: 0x10C0
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function insideapreticlenolock(target)
{
	radius = self getlockonradius();
	return target_isincircle(target, self, 65, radius);
}

/*
	Name: insideapreticlelocked
	Namespace: singlelockap_guidance
	Checksum: 0xE9F36A2A
	Offset: 0x1118
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function insideapreticlelocked(target)
{
	radius = self getlockonlossradius();
	return target_isincircle(target, self, 65, radius);
}

/*
	Name: isstillvalidtarget
	Namespace: singlelockap_guidance
	Checksum: 0x34598E0
	Offset: 0x1170
	Size: 0x6E
	Parameters: 2
	Flags: None
*/
function isstillvalidtarget(weapon, ent)
{
	if(!isdefined(ent))
	{
		return false;
	}
	if(!insideapreticlelocked(ent))
	{
		return false;
	}
	if(!isalive(ent))
	{
		return false;
	}
	if(!locksighttest(ent))
	{
		return false;
	}
	return true;
}

/*
	Name: seekersound
	Namespace: singlelockap_guidance
	Checksum: 0x30D7D78C
	Offset: 0x11E8
	Size: 0xEC
	Parameters: 3
	Flags: None
*/
function seekersound(alias, looping, id)
{
	self notify("stop_sound" + id);
	self endon("stop_sound" + id, #"disconnect", #"death");
	if(isdefined(alias))
	{
		self playrumbleonentity("stinger_lock_rumble");
		time = soundgetplaybacktime(alias) * 0.001;
		do
		{
			self playlocalsound(alias);
			wait(time);
		}
		while(looping);
		self stoprumble("stinger_lock_rumble");
	}
}

/*
	Name: locksighttest
	Namespace: singlelockap_guidance
	Checksum: 0x8DE5D3A7
	Offset: 0x12E0
	Size: 0x18E
	Parameters: 1
	Flags: None
*/
function locksighttest(target)
{
	eyepos = self geteye();
	if(!isdefined(target))
	{
		return false;
	}
	if(!isalive(target))
	{
		return false;
	}
	if(isdefined(target.var_e8ec304d) && target.var_e8ec304d)
	{
		return false;
	}
	pos = target getshootatpos();
	if(isdefined(pos))
	{
		passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
		if(passed)
		{
			return true;
		}
	}
	pos = target getcentroid();
	if(isdefined(pos))
	{
		passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
		if(passed)
		{
			return true;
		}
	}
	pos = target.origin;
	passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
	if(passed)
	{
		return true;
	}
	return false;
}

