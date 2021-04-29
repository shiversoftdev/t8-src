// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace initial_black;

/*
	Name: register
	Namespace: initial_black
	Checksum: 0xAAC22DC0
	Offset: 0xB8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_f4d68515();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: initial_black
	Checksum: 0xDC183C4B
	Offset: 0x100
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
	Namespace: initial_black
	Checksum: 0xCF13DAC7
	Offset: 0x140
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
	Namespace: initial_black
	Checksum: 0x8ACF073B
	Offset: 0x168
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

#namespace namespace_f4d68515;

/*
	Name: __constructor
	Namespace: namespace_f4d68515
	Checksum: 0xDCCB29A0
	Offset: 0x190
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
	Namespace: namespace_f4d68515
	Checksum: 0xF81FE114
	Offset: 0x1B0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
}

/*
	Name: open
	Namespace: namespace_f4d68515
	Checksum: 0xCEBA4374
	Offset: 0x1E0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "initial_black", persistent);
}

/*
	Name: close
	Namespace: namespace_f4d68515
	Checksum: 0x8859BA13
	Offset: 0x230
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: __destructor
	Namespace: namespace_f4d68515
	Checksum: 0x168D3D20
	Offset: 0x260
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace initial_black;

/*
	Name: function_f4d68515
	Namespace: initial_black
	Checksum: 0xAB98AC7
	Offset: 0x280
	Size: 0x2C6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_f4d68515()
{
	classes.var_f4d68515[0] = spawnstruct();
	classes.var_f4d68515[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_f4d68515[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_f4d68515[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_f4d68515[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_f4d68515[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_f4d68515[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_f4d68515[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_f4d68515[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_f4d68515[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_f4d68515[0].__vtable[913321084] = &namespace_f4d68515::__destructor;
	classes.var_f4d68515[0].__vtable[1516492343] = &namespace_f4d68515::close;
	classes.var_f4d68515[0].__vtable[250899321] = &namespace_f4d68515::open;
	classes.var_f4d68515[0].__vtable[1855416484] = &namespace_f4d68515::setup_clientfields;
	classes.var_f4d68515[0].__vtable[674154906] = &namespace_f4d68515::__constructor;
}

