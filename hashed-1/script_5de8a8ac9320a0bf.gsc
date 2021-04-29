// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace debug_center_screen;

/*
	Name: register
	Namespace: debug_center_screen
	Checksum: 0xEB27F52C
	Offset: 0xA0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_e9d01e1c();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: debug_center_screen
	Checksum: 0x4A9FF3C9
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_e9d01e1c();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: debug_center_screen
	Checksum: 0x2C9AA8B
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
	Namespace: debug_center_screen
	Checksum: 0xAC727145
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
	Namespace: debug_center_screen
	Checksum: 0x50039CAE
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

#namespace namespace_e9d01e1c;

/*
	Name: __constructor
	Namespace: namespace_e9d01e1c
	Checksum: 0xC86E7622
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
	Namespace: namespace_e9d01e1c
	Checksum: 0x83F875FE
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
	Namespace: namespace_e9d01e1c
	Checksum: 0xB49B3905
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
	Namespace: namespace_e9d01e1c
	Checksum: 0x9616BDB7
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
	Namespace: namespace_e9d01e1c
	Checksum: 0x8610FEF8
	Offset: 0x258
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"debug_center_screen");
}

/*
	Name: __destructor
	Namespace: namespace_e9d01e1c
	Checksum: 0xC1AB16F3
	Offset: 0x290
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace debug_center_screen;

/*
	Name: function_e9d01e1c
	Namespace: debug_center_screen
	Checksum: 0x6CF090B
	Offset: 0x2B0
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_e9d01e1c()
{
	classes.var_e9d01e1c[0] = spawnstruct();
	classes.var_e9d01e1c[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_e9d01e1c[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_e9d01e1c[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_e9d01e1c[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_e9d01e1c[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_e9d01e1c[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_e9d01e1c[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_e9d01e1c[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_e9d01e1c[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_e9d01e1c[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_e9d01e1c[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_e9d01e1c[0].__vtable[913321084] = &namespace_6aaccc24::__destructor;
	classes.var_e9d01e1c[0].__vtable[913321084] = &namespace_e9d01e1c::__destructor;
	classes.var_e9d01e1c[0].__vtable[250899321] = &namespace_e9d01e1c::open;
	classes.var_e9d01e1c[0].__vtable[94887662] = &namespace_e9d01e1c::function_fa582112;
	classes.var_e9d01e1c[0].__vtable[1545318712] = &namespace_e9d01e1c::function_5c1bb138;
	classes.var_e9d01e1c[0].__vtable[1855416484] = &namespace_e9d01e1c::setup_clientfields;
	classes.var_e9d01e1c[0].__vtable[674154906] = &namespace_e9d01e1c::__constructor;
}

