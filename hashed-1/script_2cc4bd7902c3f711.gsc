// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace ct_shared_warning;

/*
	Name: register
	Namespace: ct_shared_warning
	Checksum: 0x286440CE
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_ce8c28b9();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_warning
	Checksum: 0xD80B734E
	Offset: 0x120
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
	Namespace: ct_shared_warning
	Checksum: 0xFC080168
	Offset: 0x160
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
	Namespace: ct_shared_warning
	Checksum: 0x8BD26E7F
	Offset: 0x188
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
	Namespace: ct_shared_warning
	Checksum: 0x3B095EBB
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_54166b84
	Namespace: ct_shared_warning
	Checksum: 0x9892ACD0
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_54166b84(player, value)
{
	[[ self ]]->function_54166b84(player, value);
}

#namespace namespace_ce8c28b9;

/*
	Name: __constructor
	Namespace: namespace_ce8c28b9
	Checksum: 0x1E73E7AE
	Offset: 0x210
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
	Namespace: namespace_ce8c28b9
	Checksum: 0xD81D1597
	Offset: 0x230
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 4, "int");
	namespace_6aaccc24::function_da693cbe("objpoints", 1, 11, "int");
}

/*
	Name: open
	Namespace: namespace_ce8c28b9
	Checksum: 0x1F41C5D5
	Offset: 0x2B0
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "ct_shared_warning", persistent);
}

/*
	Name: close
	Namespace: namespace_ce8c28b9
	Checksum: 0xE1166FEF
	Offset: 0x300
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
	Namespace: namespace_ce8c28b9
	Checksum: 0x3D7C9C39
	Offset: 0x330
	Size: 0x27C
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"hash_80e92cf4cdaae12" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	else if(#"hash_5e59fb81ffd2fd6b" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 2);
	}
	else if(#"hash_4d78e6d4caf789ce" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 3);
	}
	else if(#"warnheal" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 4);
	}
	else if(#"hash_626c7058df1977f5" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 5);
	}
	else if(#"hash_626c6d58df1972dc" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 6);
	}
	else if(#"hash_5ae2f5a909a5efa9" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 7);
	}
	else if(#"hash_5ae2f2a909a5ea90" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 8);
	}
	assertmsg("");
}

/*
	Name: function_54166b84
	Namespace: namespace_ce8c28b9
	Checksum: 0x1B30B476
	Offset: 0x5B8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_54166b84(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objpoints", value);
}

/*
	Name: __destructor
	Namespace: namespace_ce8c28b9
	Checksum: 0x795C67D6
	Offset: 0x600
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace ct_shared_warning;

/*
	Name: function_ce8c28b9
	Namespace: ct_shared_warning
	Checksum: 0x58300C01
	Offset: 0x620
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_ce8c28b9()
{
	classes.var_ce8c28b9[0] = spawnstruct();
	classes.var_ce8c28b9[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_ce8c28b9[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_ce8c28b9[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_ce8c28b9[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_ce8c28b9[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_ce8c28b9[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_ce8c28b9[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_ce8c28b9[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_ce8c28b9[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_ce8c28b9[0].__vtable[913321084] = &namespace_ce8c28b9::__destructor;
	classes.var_ce8c28b9[0].__vtable[1410755460] = &namespace_ce8c28b9::function_54166b84;
	classes.var_ce8c28b9[0].__vtable[655560998] = &namespace_ce8c28b9::set_state;
	classes.var_ce8c28b9[0].__vtable[1516492343] = &namespace_ce8c28b9::close;
	classes.var_ce8c28b9[0].__vtable[250899321] = &namespace_ce8c28b9::open;
	classes.var_ce8c28b9[0].__vtable[1855416484] = &namespace_ce8c28b9::setup_clientfields;
	classes.var_ce8c28b9[0].__vtable[674154906] = &namespace_ce8c28b9::__constructor;
}

