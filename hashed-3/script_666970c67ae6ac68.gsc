// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace prototype_self_revive;

/*
	Name: register
	Namespace: prototype_self_revive
	Checksum: 0x8CB972FB
	Offset: 0xC0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_bc79c0e8();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: prototype_self_revive
	Checksum: 0x4025E7A2
	Offset: 0x108
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
	Namespace: prototype_self_revive
	Checksum: 0x7B27D931
	Offset: 0x148
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
	Namespace: prototype_self_revive
	Checksum: 0xD98EF968
	Offset: 0x170
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

#namespace namespace_bc79c0e8;

/*
	Name: __constructor
	Namespace: namespace_bc79c0e8
	Checksum: 0xE96D028B
	Offset: 0x198
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
	Namespace: namespace_bc79c0e8
	Checksum: 0xED0678A9
	Offset: 0x1B8
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
	Namespace: namespace_bc79c0e8
	Checksum: 0xEB9E8122
	Offset: 0x1E8
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "prototype_self_revive", persistent);
}

/*
	Name: close
	Namespace: namespace_bc79c0e8
	Checksum: 0x5E7FCAF0
	Offset: 0x238
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
	Namespace: namespace_bc79c0e8
	Checksum: 0x59F33F6C
	Offset: 0x268
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace prototype_self_revive;

/*
	Name: function_bc79c0e8
	Namespace: prototype_self_revive
	Checksum: 0x7F5E70B5
	Offset: 0x288
	Size: 0x2C6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_bc79c0e8()
{
	classes.var_bc79c0e8[0] = spawnstruct();
	classes.var_bc79c0e8[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_bc79c0e8[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_bc79c0e8[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_bc79c0e8[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_bc79c0e8[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_bc79c0e8[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_bc79c0e8[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_bc79c0e8[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_bc79c0e8[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_bc79c0e8[0].__vtable[913321084] = &namespace_bc79c0e8::__destructor;
	classes.var_bc79c0e8[0].__vtable[1516492343] = &namespace_bc79c0e8::close;
	classes.var_bc79c0e8[0].__vtable[250899321] = &namespace_bc79c0e8::open;
	classes.var_bc79c0e8[0].__vtable[1855416484] = &namespace_bc79c0e8::setup_clientfields;
	classes.var_bc79c0e8[0].__vtable[674154906] = &namespace_bc79c0e8::__constructor;
}

