// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_net;

/*
	Name: network_choke_init
	Namespace: zm_net
	Checksum: 0xAC1E40A0
	Offset: 0x78
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function network_choke_init(id, max)
{
	if(!isdefined(level.zombie_network_choke_ids_max))
	{
		level.zombie_network_choke_ids_max = [];
		level.zombie_network_choke_ids_count = [];
	}
	level.zombie_network_choke_ids_max[id] = max;
	level.zombie_network_choke_ids_count[id] = 0;
	level thread network_choke_thread(id);
}

/*
	Name: network_choke_thread
	Namespace: zm_net
	Checksum: 0xA7C6D8D6
	Offset: 0x108
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function network_choke_thread(id)
{
	while(true)
	{
		util::wait_network_frame();
		util::wait_network_frame();
		level.zombie_network_choke_ids_count[id] = 0;
	}
}

/*
	Name: network_choke_safe
	Namespace: zm_net
	Checksum: 0x376A3780
	Offset: 0x160
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function network_choke_safe(id)
{
	return level.zombie_network_choke_ids_count[id] < level.zombie_network_choke_ids_max[id];
}

/*
	Name: network_choke_action
	Namespace: zm_net
	Checksum: 0xB02A7436
	Offset: 0x198
	Size: 0xF8
	Parameters: 5
	Flags: Linked
*/
function network_choke_action(id, choke_action, arg1, arg2, arg3)
{
	/#
		assert(isdefined(level.zombie_network_choke_ids_max[id]), ("" + id) + "");
	#/
	while(!network_choke_safe(id))
	{
		waitframe(1);
	}
	level.zombie_network_choke_ids_count[id]++;
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
	Name: network_entity_valid
	Namespace: zm_net
	Checksum: 0xFAD6D142
	Offset: 0x298
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function network_entity_valid(entity)
{
	if(!isdefined(entity))
	{
		return false;
	}
	return true;
}

/*
	Name: network_safe_init
	Namespace: zm_net
	Checksum: 0x320C97A
	Offset: 0x2C0
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function network_safe_init(id, max)
{
	if(!isdefined(level.zombie_network_choke_ids_max) || !isdefined(level.zombie_network_choke_ids_max[id]))
	{
		network_choke_init(id, max);
	}
	/#
		assert(max == level.zombie_network_choke_ids_max[id]);
	#/
}

/*
	Name: _network_safe_spawn
	Namespace: zm_net
	Checksum: 0xB2D57FB4
	Offset: 0x348
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function _network_safe_spawn(classname, origin)
{
	return spawn(classname, origin);
}

/*
	Name: network_safe_spawn
	Namespace: zm_net
	Checksum: 0x25396B4D
	Offset: 0x380
	Size: 0x62
	Parameters: 4
	Flags: Linked
*/
function network_safe_spawn(id, max, classname, origin)
{
	network_safe_init(id, max);
	return network_choke_action(id, &_network_safe_spawn, classname, origin);
}

/*
	Name: _network_safe_play_fx_on_tag
	Namespace: zm_net
	Checksum: 0xA45B85D3
	Offset: 0x3F0
	Size: 0x54
	Parameters: 3
	Flags: Linked
*/
function _network_safe_play_fx_on_tag(fx, entity, tag)
{
	if(network_entity_valid(entity))
	{
		playfxontag(fx, entity, tag);
	}
}

/*
	Name: network_safe_play_fx_on_tag
	Namespace: zm_net
	Checksum: 0xA3C1F66B
	Offset: 0x450
	Size: 0x6C
	Parameters: 5
	Flags: Linked
*/
function network_safe_play_fx_on_tag(id, max, fx, entity, tag)
{
	network_safe_init(id, max);
	network_choke_action(id, &_network_safe_play_fx_on_tag, fx, entity, tag);
}

