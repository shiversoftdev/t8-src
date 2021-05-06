// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace fail_screen;

/*
	Name: register
	Namespace: fail_screen
	Checksum: 0x18AF3E38
	Offset: 0xB0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_f2a6c231();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: fail_screen
	Checksum: 0x72E7BD7E
	Offset: 0xF8
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
	Namespace: fail_screen
	Checksum: 0x5802C75F
	Offset: 0x138
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
	Namespace: fail_screen
	Checksum: 0xEDF23AB5
	Offset: 0x160
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

#namespace namespace_f2a6c231;

/*
	Name: __constructor
	Namespace: namespace_f2a6c231
	Checksum: 0x3D4388C8
	Offset: 0x188
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
	Namespace: namespace_f2a6c231
	Checksum: 0xAB2BA741
	Offset: 0x1A8
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
	Namespace: namespace_f2a6c231
	Checksum: 0xACC65BF7
	Offset: 0x1D8
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "fail_screen", persistent);
}

/*
	Name: close
	Namespace: namespace_f2a6c231
	Checksum: 0x6A16FBDD
	Offset: 0x228
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
	Namespace: namespace_f2a6c231
	Checksum: 0x3FA51520
	Offset: 0x258
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace fail_screen;

/*
	Name: function_f2a6c231
	Namespace: fail_screen
	Checksum: 0x18B5616E
	Offset: 0x278
	Size: 0x2C6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_f2a6c231()
{
	classes.var_f2a6c231[0] = spawnstruct();
	classes.var_f2a6c231[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_f2a6c231[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_f2a6c231[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_f2a6c231[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_f2a6c231[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_f2a6c231[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_f2a6c231[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_f2a6c231[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_f2a6c231[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_f2a6c231[0].__vtable[913321084] = &namespace_f2a6c231::__destructor;
	classes.var_f2a6c231[0].__vtable[1516492343] = &namespace_f2a6c231::close;
	classes.var_f2a6c231[0].__vtable[250899321] = &namespace_f2a6c231::open;
	classes.var_f2a6c231[0].__vtable[1855416484] = &namespace_f2a6c231::setup_clientfields;
	classes.var_f2a6c231[0].__vtable[674154906] = &namespace_f2a6c231::__constructor;
}

