// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace success_screen;

/*
	Name: register
	Namespace: success_screen
	Checksum: 0xFD107BDA
	Offset: 0xB8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_6dd74b12();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: success_screen
	Checksum: 0xBA30F2F1
	Offset: 0x100
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
	Namespace: success_screen
	Checksum: 0x39C122F5
	Offset: 0x140
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
	Namespace: success_screen
	Checksum: 0xFA1C3BB7
	Offset: 0x168
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

#namespace namespace_6dd74b12;

/*
	Name: __constructor
	Namespace: namespace_6dd74b12
	Checksum: 0xB78D7789
	Offset: 0x190
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
	Namespace: namespace_6dd74b12
	Checksum: 0xE1D3DFF0
	Offset: 0x1B0
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
}

/*
	Name: open
	Namespace: namespace_6dd74b12
	Checksum: 0x8B9D6DF1
	Offset: 0x1E0
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "success_screen", persistent);
}

/*
	Name: close
	Namespace: namespace_6dd74b12
	Checksum: 0x5858E354
	Offset: 0x230
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: __destructor
	Namespace: namespace_6dd74b12
	Checksum: 0x7BF540F9
	Offset: 0x260
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace success_screen;

/*
	Name: function_6dd74b12
	Namespace: success_screen
	Checksum: 0x5B55675A
	Offset: 0x280
	Size: 0x2C6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_6dd74b12()
{
	classes.var_6dd74b12[0] = spawnstruct();
	classes.var_6dd74b12[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_6dd74b12[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_6dd74b12[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_6dd74b12[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_6dd74b12[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_6dd74b12[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_6dd74b12[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_6dd74b12[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_6dd74b12[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_6dd74b12[0].__vtable[913321084] = &namespace_6dd74b12::__destructor;
	classes.var_6dd74b12[0].__vtable[1516492343] = &namespace_6dd74b12::close;
	classes.var_6dd74b12[0].__vtable[250899321] = &namespace_6dd74b12::open;
	classes.var_6dd74b12[0].__vtable[1855416484] = &namespace_6dd74b12::setup_clientfields;
	classes.var_6dd74b12[0].__vtable[674154906] = &namespace_6dd74b12::__constructor;
}

