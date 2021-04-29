// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace ct_shared_desc;

/*
	Name: register
	Namespace: ct_shared_desc
	Checksum: 0x3476698F
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_a7489323();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_desc
	Checksum: 0xFDD383E0
	Offset: 0x110
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: ct_shared_desc
	Checksum: 0xDD868F6F
	Offset: 0x150
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: ct_shared_desc
	Checksum: 0xCBBA9445
	Offset: 0x178
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_state
	Namespace: ct_shared_desc
	Checksum: 0x422F37B7
	Offset: 0x1A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

#namespace namespace_a7489323;

/*
	Name: __constructor
	Namespace: namespace_a7489323
	Checksum: 0xC9806DC5
	Offset: 0x1D0
	Size: 0x14
	Parameters: 0
	Flags: 8
*/
function __constructor()
{
	namespace_6aaccc24::__constructor();
}

/*
	Name: setup_clientfields
	Namespace: namespace_a7489323
	Checksum: 0x1BE91FEB
	Offset: 0x1F0
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 2, "int");
}

/*
	Name: open
	Namespace: namespace_a7489323
	Checksum: 0x515EF379
	Offset: 0x248
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "ct_shared_desc", persistent);
}

/*
	Name: close
	Namespace: namespace_a7489323
	Checksum: 0x21B1789B
	Offset: 0x298
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: set_state
	Namespace: namespace_a7489323
	Checksum: 0x9BB75EE3
	Offset: 0x2C8
	Size: 0xFC
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"hash_3319eaa2c590a2ac" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	else if(#"hash_2ac3b79c708dcfd5" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 2);
	}
	assertmsg("");
}

/*
	Name: __destructor
	Namespace: namespace_a7489323
	Checksum: 0x5F157A65
	Offset: 0x3D0
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace ct_shared_desc;

/*
	Name: function_a7489323
	Namespace: ct_shared_desc
	Checksum: 0x593AF3F1
	Offset: 0x3F0
	Size: 0x2F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_a7489323()
{
	classes.var_a7489323[0] = spawnstruct();
	classes.var_a7489323[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_a7489323[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_a7489323[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_a7489323[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_a7489323[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_a7489323[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_a7489323[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_a7489323[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_a7489323[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_a7489323[0].__vtable[913321084] = &namespace_a7489323::__destructor;
	classes.var_a7489323[0].__vtable[655560998] = &namespace_a7489323::set_state;
	classes.var_a7489323[0].__vtable[1516492343] = &namespace_a7489323::close;
	classes.var_a7489323[0].__vtable[250899321] = &namespace_a7489323::open;
	classes.var_a7489323[0].__vtable[1855416484] = &namespace_a7489323::setup_clientfields;
	classes.var_a7489323[0].__vtable[674154906] = &namespace_a7489323::__constructor;
}

