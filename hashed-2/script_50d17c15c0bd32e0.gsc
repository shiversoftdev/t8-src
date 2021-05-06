// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace player_insertion_choice;

/*
	Name: register
	Namespace: player_insertion_choice
	Checksum: 0x289CFCA3
	Offset: 0xD0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_9e6034d2();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: player_insertion_choice
	Checksum: 0x58E7239D
	Offset: 0x118
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
	Namespace: player_insertion_choice
	Checksum: 0x88B3A92
	Offset: 0x158
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
	Namespace: player_insertion_choice
	Checksum: 0xB1260AA3
	Offset: 0x180
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
	Namespace: player_insertion_choice
	Checksum: 0xD6608380
	Offset: 0x1A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

#namespace namespace_9e6034d2;

/*
	Name: __constructor
	Namespace: namespace_9e6034d2
	Checksum: 0x416897F9
	Offset: 0x1D8
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
	Namespace: namespace_9e6034d2
	Checksum: 0xFF882A3C
	Offset: 0x1F8
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
	Namespace: namespace_9e6034d2
	Checksum: 0xEC0BE477
	Offset: 0x250
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "player_insertion_choice", persistent);
}

/*
	Name: close
	Namespace: namespace_9e6034d2
	Checksum: 0x33E0F342
	Offset: 0x2A0
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
	Namespace: namespace_9e6034d2
	Checksum: 0xC60874C
	Offset: 0x2D0
	Size: 0x13C
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"hash_bcb68d30ea251e2" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	else if(#"hash_a9365fdb97f532b" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 2);
	}
	else if(#"heli" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 3);
	}
	assertmsg("");
}

/*
	Name: __destructor
	Namespace: namespace_9e6034d2
	Checksum: 0x37B3756
	Offset: 0x418
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace player_insertion_choice;

/*
	Name: function_9e6034d2
	Namespace: player_insertion_choice
	Checksum: 0x6ED7527E
	Offset: 0x438
	Size: 0x2F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_9e6034d2()
{
	classes.var_9e6034d2[0] = spawnstruct();
	classes.var_9e6034d2[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_9e6034d2[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_9e6034d2[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_9e6034d2[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_9e6034d2[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_9e6034d2[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_9e6034d2[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_9e6034d2[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_9e6034d2[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_9e6034d2[0].__vtable[913321084] = &namespace_9e6034d2::__destructor;
	classes.var_9e6034d2[0].__vtable[655560998] = &namespace_9e6034d2::set_state;
	classes.var_9e6034d2[0].__vtable[1516492343] = &namespace_9e6034d2::close;
	classes.var_9e6034d2[0].__vtable[250899321] = &namespace_9e6034d2::open;
	classes.var_9e6034d2[0].__vtable[1855416484] = &namespace_9e6034d2::setup_clientfields;
	classes.var_9e6034d2[0].__vtable[674154906] = &namespace_9e6034d2::__constructor;
}

