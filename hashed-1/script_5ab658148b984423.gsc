// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_build_progress;

/*
	Name: register
	Namespace: zm_build_progress
	Checksum: 0x26DE4028
	Offset: 0xD0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_616a42d0();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_build_progress
	Checksum: 0x41E23B41
	Offset: 0x118
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: zm_build_progress
	Checksum: 0xCEC74DF9
	Offset: 0x158
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: zm_build_progress
	Checksum: 0xA5FB3282
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_affe8f61
	Namespace: zm_build_progress
	Checksum: 0xAFFBC2BA
	Offset: 0x1A8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_affe8f61(player, value)
{
	[[ self ]]->function_affe8f61(player, value);
}

#namespace namespace_616a42d0;

/*
	Name: __constructor
	Namespace: namespace_616a42d0
	Checksum: 0x5AA9760A
	Offset: 0x1D8
	Size: 0x14
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	namespace_6aaccc24::__constructor();
}

/*
	Name: setup_clientfields
	Namespace: namespace_616a42d0
	Checksum: 0x2FD8A6C1
	Offset: 0x1F8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("progress", 1, 6, "float");
}

/*
	Name: open
	Namespace: namespace_616a42d0
	Checksum: 0x53BB0713
	Offset: 0x250
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_build_progress", persistent);
}

/*
	Name: close
	Namespace: namespace_616a42d0
	Checksum: 0xB597955B
	Offset: 0x2A0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_affe8f61
	Namespace: namespace_616a42d0
	Checksum: 0x36F7B894
	Offset: 0x2D0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_affe8f61(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "progress", value);
}

/*
	Name: __destructor
	Namespace: namespace_616a42d0
	Checksum: 0x36376EA9
	Offset: 0x318
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_build_progress;

/*
	Name: function_616a42d0
	Namespace: zm_build_progress
	Checksum: 0x4A88BBF
	Offset: 0x338
	Size: 0x2F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_616a42d0()
{
	classes.var_616a42d0[0] = spawnstruct();
	classes.var_616a42d0[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_616a42d0[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_616a42d0[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_616a42d0[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_616a42d0[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_616a42d0[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_616a42d0[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_616a42d0[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_616a42d0[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_616a42d0[0].__vtable[913321084] = &namespace_616a42d0::__destructor;
	classes.var_616a42d0[0].__vtable[1342271647] = &namespace_616a42d0::function_affe8f61;
	classes.var_616a42d0[0].__vtable[1516492343] = &namespace_616a42d0::close;
	classes.var_616a42d0[0].__vtable[250899321] = &namespace_616a42d0::open;
	classes.var_616a42d0[0].__vtable[1855416484] = &namespace_616a42d0::setup_clientfields;
	classes.var_616a42d0[0].__vtable[674154906] = &namespace_616a42d0::__constructor;
}

