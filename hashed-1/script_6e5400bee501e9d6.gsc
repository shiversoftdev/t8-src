// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_9bf1b425;

/*
	Name: function_89f2df9
	Namespace: namespace_9bf1b425
	Checksum: 0x8966B341
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5eff6da6c51cbff2", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_9bf1b425
	Checksum: 0xE712F420
	Offset: 0xE8
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::add_weapon_type(#"hash_79fccf9f83bf7568", &function_9f6d38cf);
	callback::add_weapon_type(#"hash_38c782e8db011867", &function_9f6d38cf);
}

/*
	Name: function_9f6d38cf
	Namespace: namespace_9bf1b425
	Checksum: 0x1B84F2A0
	Offset: 0x158
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_9f6d38cf(localclientnum)
{
	self thread fx_think(localclientnum);
}

/*
	Name: fx_think
	Namespace: namespace_9bf1b425
	Checksum: 0xF5CC7F15
	Offset: 0x188
	Size: 0xF8
	Parameters: 1
	Flags: None
*/
function fx_think(localclientnum)
{
	self notify(#"light_disable");
	self endon(#"light_disable");
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	for(;;)
	{
		self stop_light_fx(localclientnum);
		localplayer = function_5c10bd79(localclientnum);
		self start_light_fx(localclientnum);
		util::server_wait(localclientnum, 0.3, 0.01, "player_switch");
		self util::waittill_dobj(localclientnum);
	}
}

/*
	Name: start_light_fx
	Namespace: namespace_9bf1b425
	Checksum: 0xF5C615EF
	Offset: 0x288
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function start_light_fx(localclientnum)
{
	self.fx = util::playfxontag(localclientnum, level._effect[#"grenade_light"], self, "tag_fx");
}

/*
	Name: stop_light_fx
	Namespace: namespace_9bf1b425
	Checksum: 0xA515550D
	Offset: 0x2E0
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function stop_light_fx(localclientnum)
{
	if(isdefined(self.fx) && self.fx != 0)
	{
		stopfx(localclientnum, self.fx);
		self.fx = undefined;
	}
}

