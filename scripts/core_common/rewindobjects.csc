// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;

#namespace rewindobjects;

/*
	Name: __init__system__
	Namespace: rewindobjects
	Checksum: 0x2FE70A32
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"rewindobjects", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: rewindobjects
	Checksum: 0x8A2D07F
	Offset: 0xE0
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level.rewindwatcherarray = [];
}

/*
	Name: initrewindobjectwatchers
	Namespace: rewindobjects
	Checksum: 0xED857EFC
	Offset: 0x100
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function initrewindobjectwatchers(localclientnum)
{
	level.rewindwatcherarray[localclientnum] = [];
	createnapalmrewindwatcher(localclientnum);
	createairstrikerewindwatcher(localclientnum);
	level thread watchrewindableevents(localclientnum);
}

/*
	Name: watchrewindableevents
	Namespace: rewindobjects
	Checksum: 0xB25EE99
	Offset: 0x170
	Size: 0x18C
	Parameters: 1
	Flags: None
*/
function watchrewindableevents(localclientnum)
{
	for(;;)
	{
		if(isdefined(level.rewindwatcherarray[localclientnum]))
		{
			rewindwatcherkeys = getarraykeys(level.rewindwatcherarray[localclientnum]);
			for(i = 0; i < rewindwatcherkeys.size; i++)
			{
				rewindwatcher = level.rewindwatcherarray[localclientnum][rewindwatcherkeys[i]];
				if(!isdefined(rewindwatcher))
				{
					continue;
				}
				if(!isdefined(rewindwatcher.event))
				{
					continue;
				}
				timekeys = getarraykeys(rewindwatcher.event);
				for(j = 0; j < timekeys.size; j++)
				{
					timekey = timekeys[j];
					if(rewindwatcher.event[timekey].inprogress == 1)
					{
						continue;
					}
					if(getservertime(0) >= timekey)
					{
						rewindwatcher thread startrewindableevent(localclientnum, timekey);
					}
				}
			}
		}
		wait(0.1);
	}
}

/*
	Name: startrewindableevent
	Namespace: rewindobjects
	Checksum: 0x936E1491
	Offset: 0x308
	Size: 0x220
	Parameters: 2
	Flags: None
*/
function startrewindableevent(localclientnum, timekey)
{
	player = function_5c10bd79(localclientnum);
	level endon("demo_jump" + localclientnum);
	self.event[timekey].inprogress = 1;
	allfunctionsstarted = 0;
	while(allfunctionsstarted == 0)
	{
		allfunctionsstarted = 1;
		/#
			assert(isdefined(self.timedfunctions));
		#/
		timedfunctionkeys = getarraykeys(self.timedfunctions);
		for(i = 0; i < timedfunctionkeys.size; i++)
		{
			timedfunction = self.timedfunctions[timedfunctionkeys[i]];
			timedfunctionkey = timedfunctionkeys[i];
			if(self.event[timekey].timedfunction[timedfunctionkey] == 1)
			{
				continue;
			}
			starttime = timekey + (int(timedfunction.starttimesec * 1000));
			if(starttime > getservertime(0))
			{
				allfunctionsstarted = 0;
				continue;
			}
			self.event[timekey].timedfunction[timedfunctionkey] = 1;
			level thread [[timedfunction.func]](localclientnum, starttime, timedfunction.starttimesec, self.event[timekey].data);
		}
		wait(0.1);
	}
}

/*
	Name: createnapalmrewindwatcher
	Namespace: rewindobjects
	Checksum: 0xD1E74C52
	Offset: 0x530
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function createnapalmrewindwatcher(localclientnum)
{
	napalmrewindwatcher = createrewindwatcher(localclientnum, "napalm");
	timeincreasebetweenplanes = 0;
}

/*
	Name: createairstrikerewindwatcher
	Namespace: rewindobjects
	Checksum: 0x13C1E5F
	Offset: 0x580
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function createairstrikerewindwatcher(localclientnum)
{
	airstrikerewindwatcher = createrewindwatcher(localclientnum, "airstrike");
}

/*
	Name: createrewindwatcher
	Namespace: rewindobjects
	Checksum: 0xB489D281
	Offset: 0x5C0
	Size: 0x100
	Parameters: 2
	Flags: None
*/
function createrewindwatcher(localclientnum, name)
{
	player = function_5c10bd79(localclientnum);
	if(!isdefined(level.rewindwatcherarray[localclientnum]))
	{
		level.rewindwatcherarray[localclientnum] = [];
	}
	rewindwatcher = getrewindwatcher(localclientnum, name);
	if(!isdefined(rewindwatcher))
	{
		rewindwatcher = spawnstruct();
		level.rewindwatcherarray[localclientnum][level.rewindwatcherarray[localclientnum].size] = rewindwatcher;
	}
	rewindwatcher.name = name;
	rewindwatcher.event = [];
	rewindwatcher thread resetondemojump(localclientnum);
	return rewindwatcher;
}

/*
	Name: resetondemojump
	Namespace: rewindobjects
	Checksum: 0x41036766
	Offset: 0x6C8
	Size: 0x176
	Parameters: 1
	Flags: None
*/
function resetondemojump(localclientnum)
{
	for(;;)
	{
		level waittill("demo_jump" + localclientnum);
		self.inprogress = 0;
		timedfunctionkeys = getarraykeys(self.timedfunctions);
		for(i = 0; i < timedfunctionkeys.size; i++)
		{
			self.timedfunctions[timedfunctionkeys[i]].inprogress = 0;
		}
		eventkeys = getarraykeys(self.event);
		for(i = 0; i < eventkeys.size; i++)
		{
			self.event[eventkeys[i]].inprogress = 0;
			timedfunctionkeys = getarraykeys(self.event[eventkeys[i]].timedfunction);
			for(index = 0; index < timedfunctionkeys.size; index++)
			{
				self.event[eventkeys[i]].timedfunction[timedfunctionkeys[index]] = 0;
			}
		}
	}
}

/*
	Name: addtimedfunction
	Namespace: rewindobjects
	Checksum: 0xC48645DC
	Offset: 0x848
	Size: 0xCA
	Parameters: 3
	Flags: None
*/
function addtimedfunction(name, func, relativestarttimeinsecs)
{
	if(!isdefined(self.timedfunctions))
	{
		self.timedfunctions = [];
	}
	/#
		assert(!isdefined(self.timedfunctions[name]));
	#/
	self.timedfunctions[name] = spawnstruct();
	self.timedfunctions[name].inprogress = 0;
	self.timedfunctions[name].func = func;
	self.timedfunctions[name].starttimesec = relativestarttimeinsecs;
}

/*
	Name: getrewindwatcher
	Namespace: rewindobjects
	Checksum: 0x39EB7FE5
	Offset: 0x920
	Size: 0xA0
	Parameters: 2
	Flags: None
*/
function getrewindwatcher(localclientnum, name)
{
	if(!isdefined(level.rewindwatcherarray[localclientnum]))
	{
		return undefined;
	}
	for(watcher = 0; watcher < level.rewindwatcherarray[localclientnum].size; watcher++)
	{
		if(level.rewindwatcherarray[localclientnum][watcher].name == name)
		{
			return level.rewindwatcherarray[localclientnum][watcher];
		}
	}
	return undefined;
}

/*
	Name: addrewindableeventtowatcher
	Namespace: rewindobjects
	Checksum: 0xD5595D88
	Offset: 0x9C8
	Size: 0x124
	Parameters: 2
	Flags: None
*/
function addrewindableeventtowatcher(starttime, data)
{
	if(isdefined(self.event[starttime]))
	{
		return;
	}
	self.event[starttime] = spawnstruct();
	self.event[starttime].data = data;
	self.event[starttime].inprogress = 0;
	if(isdefined(self.timedfunctions))
	{
		timedfunctionkeys = getarraykeys(self.timedfunctions);
		self.event[starttime].timedfunction = [];
		for(i = 0; i < timedfunctionkeys.size; i++)
		{
			timedfunctionkey = timedfunctionkeys[i];
			self.event[starttime].timedfunction[timedfunctionkey] = 0;
		}
	}
}

/*
	Name: servertimedmoveto
	Namespace: rewindobjects
	Checksum: 0x9E58FBF6
	Offset: 0xAF8
	Size: 0x14C
	Parameters: 5
	Flags: None
*/
function servertimedmoveto(localclientnum, startpoint, endpoint, starttime, duration)
{
	level endon("demo_jump" + localclientnum);
	timeelapsed = (getservertime(0) - starttime) * 0.001;
	/#
		assert(duration > 0);
	#/
	dojump = 1;
	if(timeelapsed < 0.02)
	{
		dojump = 0;
	}
	if(timeelapsed < duration)
	{
		movetime = duration - timeelapsed;
		if(dojump)
		{
			jumppoint = getpointonline(startpoint, endpoint, timeelapsed / duration);
			self.origin = jumppoint;
		}
		self moveto(endpoint, movetime, 0, 0);
		return true;
	}
	self.origin = endpoint;
	return false;
}

/*
	Name: servertimedrotateto
	Namespace: rewindobjects
	Checksum: 0x317489C
	Offset: 0xC50
	Size: 0x10C
	Parameters: 6
	Flags: None
*/
function servertimedrotateto(localclientnum, angles, starttime, duration, timein, timeout)
{
	level endon("demo_jump" + localclientnum);
	timeelapsed = (getservertime(0) - starttime) * 0.001;
	if(!isdefined(timein))
	{
		timein = 0;
	}
	if(!isdefined(timeout))
	{
		timeout = 0;
	}
	/#
		assert(duration > 0);
	#/
	if(timeelapsed < duration)
	{
		rotatetime = duration - timeelapsed;
		self rotateto(angles, rotatetime, timein, timeout);
		return true;
	}
	self.angles = angles;
	return false;
}

/*
	Name: waitforservertime
	Namespace: rewindobjects
	Checksum: 0x81DDCDEF
	Offset: 0xD68
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function waitforservertime(localclientnum, timefromstart)
{
	while(timefromstart > getservertime(0))
	{
		waitframe(1);
	}
}

/*
	Name: removecliententonjump
	Namespace: rewindobjects
	Checksum: 0x37921B70
	Offset: 0xDA8
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function removecliententonjump(clientent, localclientnum)
{
	clientent endon(#"complete");
	player = function_5c10bd79(localclientnum);
	level waittill("demo_jump" + localclientnum);
	clientent notify(#"delete");
	clientent forcedelete();
}

/*
	Name: getpointonline
	Namespace: rewindobjects
	Checksum: 0x9F5F57A9
	Offset: 0xE38
	Size: 0xA0
	Parameters: 3
	Flags: None
*/
function getpointonline(startpoint, endpoint, ratio)
{
	nextpoint = (startpoint[0] + ((endpoint[0] - startpoint[0]) * ratio), startpoint[1] + ((endpoint[1] - startpoint[1]) * ratio), startpoint[2] + ((endpoint[2] - startpoint[2]) * ratio));
	return nextpoint;
}

