// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace hackable;

/*
	Name: __init__system__
	Namespace: hackable
	Checksum: 0x89B9C3F
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hackable", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: hackable
	Checksum: 0x1FEB37F6
	Offset: 0xC0
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function init()
{
	if(!isdefined(level.hackable_items))
	{
		level.hackable_items = [];
	}
}

/*
	Name: add_hackable_object
	Namespace: hackable
	Checksum: 0x563C2D57
	Offset: 0xF0
	Size: 0x266
	Parameters: 5
	Flags: None
*/
function add_hackable_object(obj, test_callback, start_callback, fail_callback, complete_callback)
{
	cleanup_hackable_objects();
	if(!isdefined(level.hackable_items))
	{
		level.hackable_items = [];
	}
	else if(!isarray(level.hackable_items))
	{
		level.hackable_items = array(level.hackable_items);
	}
	level.hackable_items[level.hackable_items.size] = obj;
	if(!isdefined(obj.hackable_distance_sq))
	{
		obj.hackable_distance_sq = getdvarfloat(#"scr_hacker_default_distance", 0) * getdvarfloat(#"scr_hacker_default_distance", 0);
	}
	if(!isdefined(obj.hackable_angledot))
	{
		obj.hackable_angledot = getdvarfloat(#"scr_hacker_default_angledot", 0);
	}
	if(!isdefined(obj.hackable_timeout))
	{
		obj.hackable_timeout = getdvarfloat(#"scr_hacker_default_timeout", 0);
	}
	if(!isdefined(obj.hackable_progress_prompt))
	{
		obj.hackable_progress_prompt = #"hash_7080e1304a0ce47d";
	}
	if(!isdefined(obj.hackable_cost_mult))
	{
		obj.hackable_cost_mult = 1;
	}
	if(!isdefined(obj.hackable_hack_time))
	{
		obj.hackable_hack_time = getdvarfloat(#"scr_hacker_default_hack_time", 0);
	}
	obj.hackable_test_callback = test_callback;
	obj.hackable_start_callback = start_callback;
	obj.hackable_fail_callback = fail_callback;
	obj.hackable_hacked_callback = complete_callback;
}

/*
	Name: remove_hackable_object
	Namespace: hackable
	Checksum: 0xB5C4A028
	Offset: 0x360
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function remove_hackable_object(obj)
{
	arrayremovevalue(level.hackable_items, obj);
	cleanup_hackable_objects();
}

/*
	Name: cleanup_hackable_objects
	Namespace: hackable
	Checksum: 0xC19BD9A2
	Offset: 0x3A8
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function cleanup_hackable_objects()
{
	level.hackable_items = array::filter(level.hackable_items, 0, &filter_deleted);
}

/*
	Name: filter_deleted
	Namespace: hackable
	Checksum: 0xDD62ADCE
	Offset: 0x3E8
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function filter_deleted(val)
{
	return isdefined(val);
}

/*
	Name: find_hackable_object
	Namespace: hackable
	Checksum: 0xAF6E0D00
	Offset: 0x400
	Size: 0x156
	Parameters: 0
	Flags: None
*/
function find_hackable_object()
{
	cleanup_hackable_objects();
	candidates = [];
	origin = self.origin;
	forward = anglestoforward(self.angles);
	foreach(obj in level.hackable_items)
	{
		if(self is_object_hackable(obj, origin, forward))
		{
			if(!isdefined(candidates))
			{
				candidates = [];
			}
			else if(!isarray(candidates))
			{
				candidates = array(candidates);
			}
			candidates[candidates.size] = obj;
		}
	}
	if(candidates.size > 0)
	{
		return arraygetclosest(self.origin, candidates);
	}
	return undefined;
}

/*
	Name: is_object_hackable
	Namespace: hackable
	Checksum: 0x97F77D6
	Offset: 0x560
	Size: 0x104
	Parameters: 3
	Flags: None
*/
function is_object_hackable(obj, origin, forward)
{
	if(distancesquared(origin, obj.origin) < obj.hackable_distance_sq)
	{
		to_obj = obj.origin - origin;
		to_obj = (to_obj[0], to_obj[1], 0);
		to_obj = vectornormalize(to_obj);
		dot = vectordot(to_obj, forward);
		if(dot >= obj.hackable_angledot)
		{
			if(isdefined(obj.hackable_test_callback))
			{
				return obj [[obj.hackable_test_callback]](self);
			}
			return 1;
		}
		/#
		#/
	}
	return 0;
}

/*
	Name: start_hacking_object
	Namespace: hackable
	Checksum: 0xFB124D6D
	Offset: 0x670
	Size: 0x58
	Parameters: 1
	Flags: None
*/
function start_hacking_object(obj)
{
	obj.hackable_being_hacked = 1;
	obj.hackable_hacked_amount = 0;
	if(isdefined(obj.hackable_start_callback))
	{
		obj thread [[obj.hackable_start_callback]](self);
	}
}

/*
	Name: fail_hacking_object
	Namespace: hackable
	Checksum: 0xE1ED4706
	Offset: 0x6D0
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function fail_hacking_object(obj)
{
	if(isdefined(obj.hackable_fail_callback))
	{
		obj thread [[obj.hackable_fail_callback]](self);
	}
	obj.hackable_hacked_amount = 0;
	obj.hackable_being_hacked = 0;
	obj notify(#"hackable_watch_timeout");
}

/*
	Name: complete_hacking_object
	Namespace: hackable
	Checksum: 0xB8136B28
	Offset: 0x740
	Size: 0x66
	Parameters: 1
	Flags: None
*/
function complete_hacking_object(obj)
{
	obj notify(#"hackable_watch_timeout");
	if(isdefined(obj.hackable_hacked_callback))
	{
		obj thread [[obj.hackable_hacked_callback]](self);
	}
	obj.hackable_hacked_amount = 0;
	obj.hackable_being_hacked = 0;
}

/*
	Name: watch_timeout
	Namespace: hackable
	Checksum: 0xD1A4188A
	Offset: 0x7B0
	Size: 0x5C
	Parameters: 2
	Flags: None
*/
function watch_timeout(obj, time)
{
	obj notify(#"hackable_watch_timeout");
	obj endon(#"hackable_watch_timeout");
	wait(time);
	if(isdefined(obj))
	{
		fail_hacking_object(obj);
	}
}

/*
	Name: continue_hacking_object
	Namespace: hackable
	Checksum: 0x7C29B860
	Offset: 0x818
	Size: 0x19C
	Parameters: 1
	Flags: None
*/
function continue_hacking_object(obj)
{
	origin = self.origin;
	forward = anglestoforward(self.angles);
	if(self is_object_hackable(obj, origin, forward))
	{
		if(!(isdefined(obj.hackable_being_hacked) && obj.hackable_being_hacked))
		{
			self start_hacking_object(obj);
		}
		if(isdefined(obj.hackable_timeout) && obj.hackable_timeout > 0)
		{
			self thread watch_timeout(obj, obj.hackable_timeout);
		}
		amt = 1 / (20 * obj.hackable_hack_time);
		obj.hackable_hacked_amount = obj.hackable_hacked_amount + amt;
		if(obj.hackable_hacked_amount > 1)
		{
			self complete_hacking_object(obj);
		}
		if(isdefined(obj.hackable_being_hacked) && obj.hackable_being_hacked)
		{
			return obj.hackable_hacked_amount;
		}
	}
	return -1;
}

