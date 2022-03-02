// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_server_throttle;

/*
	Name: server_choke_init
	Namespace: zm_server_throttle
	Checksum: 0xED168661
	Offset: 0x78
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function server_choke_init(id, max)
{
	if(!isdefined(level.zombie_server_choke_ids_max))
	{
		level.zombie_server_choke_ids_max = [];
		level.zombie_server_choke_ids_count = [];
	}
	level.zombie_server_choke_ids_max[id] = max;
	level.zombie_server_choke_ids_count[id] = 0;
	level thread server_choke_thread(id);
}

/*
	Name: server_choke_thread
	Namespace: zm_server_throttle
	Checksum: 0xEFE4B8EB
	Offset: 0x108
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function server_choke_thread(id)
{
	while(true)
	{
		waitframe(1);
		level.zombie_server_choke_ids_count[id] = 0;
	}
}

/*
	Name: server_choke_safe
	Namespace: zm_server_throttle
	Checksum: 0x16538C5A
	Offset: 0x148
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function server_choke_safe(id)
{
	return level.zombie_server_choke_ids_count[id] < level.zombie_server_choke_ids_max[id];
}

/*
	Name: server_choke_action
	Namespace: zm_server_throttle
	Checksum: 0xF8511A7
	Offset: 0x180
	Size: 0xF8
	Parameters: 5
	Flags: Linked
*/
function server_choke_action(id, choke_action, arg1, arg2, arg3)
{
	/#
		assert(isdefined(level.zombie_server_choke_ids_max[id]), ("" + id) + "");
	#/
	while(!server_choke_safe(id))
	{
		waitframe(1);
	}
	level.zombie_server_choke_ids_count[id]++;
	if(!isdefined(arg1))
	{
		return [[choke_action]]();
	}
	if(!isdefined(arg2))
	{
		return [[choke_action]](arg1);
	}
	if(!isdefined(arg3))
	{
		return [[choke_action]](arg1, arg2);
	}
	return [[choke_action]](arg1, arg2, arg3);
}

/*
	Name: server_entity_valid
	Namespace: zm_server_throttle
	Checksum: 0xA3C1605B
	Offset: 0x280
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function server_entity_valid(entity)
{
	if(!isdefined(entity))
	{
		return false;
	}
	return true;
}

/*
	Name: server_safe_init
	Namespace: zm_server_throttle
	Checksum: 0xA043AD12
	Offset: 0x2A8
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function server_safe_init(id, max)
{
	if(!isdefined(level.zombie_server_choke_ids_max) || !isdefined(level.zombie_server_choke_ids_max[id]))
	{
		server_choke_init(id, max);
	}
	/#
		assert(max == level.zombie_server_choke_ids_max[id]);
	#/
}

/*
	Name: _server_safe_ground_trace
	Namespace: zm_server_throttle
	Checksum: 0x7353CF1
	Offset: 0x330
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function _server_safe_ground_trace(pos)
{
	return zm_utility::groundpos(pos);
}

/*
	Name: server_safe_ground_trace
	Namespace: zm_server_throttle
	Checksum: 0xC9034F98
	Offset: 0x360
	Size: 0x52
	Parameters: 3
	Flags: Linked
*/
function server_safe_ground_trace(id, max, origin)
{
	server_safe_init(id, max);
	return server_choke_action(id, &_server_safe_ground_trace, origin);
}

/*
	Name: _server_safe_ground_trace_ignore_water
	Namespace: zm_server_throttle
	Checksum: 0x1E98323F
	Offset: 0x3C0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function _server_safe_ground_trace_ignore_water(pos)
{
	return zm_utility::groundpos_ignore_water(pos);
}

/*
	Name: server_safe_ground_trace_ignore_water
	Namespace: zm_server_throttle
	Checksum: 0xBD04E07D
	Offset: 0x3F0
	Size: 0x52
	Parameters: 3
	Flags: None
*/
function server_safe_ground_trace_ignore_water(id, max, origin)
{
	server_safe_init(id, max);
	return server_choke_action(id, &_server_safe_ground_trace_ignore_water, origin);
}

