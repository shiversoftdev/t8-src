// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace blackboard;

/*
	Name: main
	Namespace: blackboard
	Checksum: 0x3EEDBE29
	Offset: 0x68
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
autoexec function main()
{
	_initializeblackboard();
}

/*
	Name: _initializeblackboard
	Namespace: blackboard
	Checksum: 0x2A488699
	Offset: 0x88
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
private function _initializeblackboard()
{
	level.__ai_blackboard = [];
	level thread _updateevents();
}

/*
	Name: _updateevents
	Namespace: blackboard
	Checksum: 0x21557449
	Offset: 0xC0
	Size: 0x1A4
	Parameters: 0
	Flags: Linked, Private
*/
private function _updateevents()
{
	waittime = 1 * float(function_60d95f53()) / 1000;
	updatemillis = int(waittime * 1000);
	while(true)
	{
		foreach(eventname, events in level.__ai_blackboard)
		{
			liveevents = [];
			foreach(event in events)
			{
				event.ttl = event.ttl - updatemillis;
				if(event.ttl > 0)
				{
					liveevents[liveevents.size] = event;
				}
			}
			level.__ai_blackboard[eventname] = liveevents;
		}
		wait(waittime);
	}
}

/*
	Name: addblackboardevent
	Namespace: blackboard
	Checksum: 0x7457276F
	Offset: 0x270
	Size: 0x1B8
	Parameters: 3
	Flags: Linked
*/
function addblackboardevent(eventname, data, timetoliveinmillis)
{
	/#
		/#
			assert(isstring(eventname) || function_7a600918(eventname), "");
		#/
		/#
			assert(isdefined(data), "");
		#/
		/#
			assert(isint(timetoliveinmillis) && timetoliveinmillis > 0, "");
		#/
	#/
	event = spawnstruct();
	event.data = data;
	event.timestamp = gettime();
	event.ttl = timetoliveinmillis;
	if(!isdefined(level.__ai_blackboard[eventname]))
	{
		level.__ai_blackboard[eventname] = [];
	}
	else if(!isarray(level.__ai_blackboard[eventname]))
	{
		level.__ai_blackboard[eventname] = array(level.__ai_blackboard[eventname]);
	}
	level.__ai_blackboard[eventname][level.__ai_blackboard[eventname].size] = event;
}

/*
	Name: getblackboardevents
	Namespace: blackboard
	Checksum: 0xADBADB7E
	Offset: 0x430
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function getblackboardevents(eventname)
{
	if(isdefined(level.__ai_blackboard[eventname]))
	{
		return level.__ai_blackboard[eventname];
	}
	return [];
}

/*
	Name: removeblackboardevents
	Namespace: blackboard
	Checksum: 0x1D87200A
	Offset: 0x470
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function removeblackboardevents(eventname)
{
	if(isdefined(level.__ai_blackboard[eventname]))
	{
		level.__ai_blackboard[eventname] = undefined;
	}
}

