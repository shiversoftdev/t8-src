// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace initial_black;

/*
	Name: register
	Namespace: initial_black
	Checksum: 0x3295262C
	Offset: 0xA0
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
	Name: function_5c1bb138
	Namespace: initial_black
	Checksum: 0x6E7E5033
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_f4d68515();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: initial_black
	Checksum: 0xC6EC12E2
	Offset: 0x130
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: initial_black
	Checksum: 0xA0E7B69
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
	Namespace: initial_black
	Checksum: 0x64B28E02
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

#namespace namespace_f4d68515;

/*
	Name: __constructor
	Namespace: namespace_f4d68515
	Checksum: 0xEB056E42
	Offset: 0x1A8
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
	Checksum: 0xD89208D9
	Offset: 0x1C8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_f4d68515
	Checksum: 0x6E533EE2
	Offset: 0x1F8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_5c1bb138(uid)
{
	namespace_6aaccc24::function_5c1bb138(uid);
}

/*
	Name: function_fa582112
	Namespace: namespace_f4d68515
	Checksum: 0x28A47FC7
	Offset: 0x228
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
}

/*
	Name: open
	Namespace: namespace_f4d68515
	Checksum: 0x5367638
	Offset: 0x258
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"initial_black");
}

/*
	Name: __destructor
	Namespace: namespace_f4d68515
	Checksum: 0x62C6C2F
	Offset: 0x290
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
	Checksum: 0x1C77CD96
	Offset: 0x2B0
	Size: 0x356
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_f4d68515()
{
	classes.var_f4d68515[0] = spawnstruct();
	classes.var_f4d68515[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_f4d68515[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_f4d68515[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_f4d68515[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_f4d68515[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_f4d68515[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_f4d68515[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_f4d68515[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_f4d68515[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_f4d68515[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_f4d68515[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_f4d68515[0].__vtable[913321084] = &namespace_f4d68515::__destructor;
	classes.var_f4d68515[0].__vtable[250899321] = &namespace_f4d68515::open;
	classes.var_f4d68515[0].__vtable[94887662] = &namespace_f4d68515::function_fa582112;
	classes.var_f4d68515[0].__vtable[1545318712] = &namespace_f4d68515::function_5c1bb138;
	classes.var_f4d68515[0].__vtable[1855416484] = &namespace_f4d68515::setup_clientfields;
	classes.var_f4d68515[0].__vtable[674154906] = &namespace_f4d68515::__constructor;
}

