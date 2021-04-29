// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace ct_shared_ingame_hint;

/*
	Name: register
	Namespace: ct_shared_ingame_hint
	Checksum: 0xDF62E3A4
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_f85aae7f();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_ingame_hint
	Checksum: 0x1AA1D2C7
	Offset: 0x128
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
	Namespace: ct_shared_ingame_hint
	Checksum: 0x37B76330
	Offset: 0x168
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
	Namespace: ct_shared_ingame_hint
	Checksum: 0x2F90F3A3
	Offset: 0x190
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
	Namespace: ct_shared_ingame_hint
	Checksum: 0x81BB4FCA
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_f9868b51
	Namespace: ct_shared_ingame_hint
	Checksum: 0x4ADA5926
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_f9868b51(player, value)
{
	[[ self ]]->function_f9868b51(player, value);
}

#namespace namespace_f85aae7f;

/*
	Name: __constructor
	Namespace: namespace_f85aae7f
	Checksum: 0x2B69BB80
	Offset: 0x218
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
	Namespace: namespace_f85aae7f
	Checksum: 0x35D44EE
	Offset: 0x238
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 4, "int");
	namespace_6aaccc24::function_dcb34c80("string", "inGameHint", 1);
}

/*
	Name: open
	Namespace: namespace_f85aae7f
	Checksum: 0x89DA9830
	Offset: 0x2B8
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "ct_shared_ingame_hint", persistent);
}

/*
	Name: close
	Namespace: namespace_f85aae7f
	Checksum: 0xE1D24083
	Offset: 0x308
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
	Namespace: namespace_f85aae7f
	Checksum: 0x7AAC8CD4
	Offset: 0x338
	Size: 0x2BC
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"fadeout" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	else if(#"green" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 2);
	}
	else if(#"grey" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 3);
	}
	else if(#"red" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 4);
	}
	else if(#"hash_d88afb16dd24291" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 5);
	}
	else if(#"hash_595d7b53cd00c77f" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 6);
	}
	else if(#"hash_1bf30d1307f73c31" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 7);
	}
	else if(#"red_paused" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 8);
	}
	else if(#"hash_3d131b584420ca82" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 9);
	}
	assertmsg("");
}

/*
	Name: function_f9868b51
	Namespace: namespace_f85aae7f
	Checksum: 0x311F4293
	Offset: 0x600
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_f9868b51(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "inGameHint", value);
}

/*
	Name: __destructor
	Namespace: namespace_f85aae7f
	Checksum: 0x589E8CC1
	Offset: 0x648
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace ct_shared_ingame_hint;

/*
	Name: function_f85aae7f
	Namespace: ct_shared_ingame_hint
	Checksum: 0x4B2D3FD7
	Offset: 0x668
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_f85aae7f()
{
	classes.var_f85aae7f[0] = spawnstruct();
	classes.var_f85aae7f[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_f85aae7f[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_f85aae7f[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_f85aae7f[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_f85aae7f[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_f85aae7f[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_f85aae7f[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_f85aae7f[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_f85aae7f[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_f85aae7f[0].__vtable[913321084] = &namespace_f85aae7f::__destructor;
	classes.var_f85aae7f[0].__vtable[108623023] = &namespace_f85aae7f::function_f9868b51;
	classes.var_f85aae7f[0].__vtable[655560998] = &namespace_f85aae7f::set_state;
	classes.var_f85aae7f[0].__vtable[1516492343] = &namespace_f85aae7f::close;
	classes.var_f85aae7f[0].__vtable[250899321] = &namespace_f85aae7f::open;
	classes.var_f85aae7f[0].__vtable[1855416484] = &namespace_f85aae7f::setup_clientfields;
	classes.var_f85aae7f[0].__vtable[674154906] = &namespace_f85aae7f::__constructor;
}

