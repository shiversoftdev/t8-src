// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace success_screen;

/*
	Name: register
	Namespace: success_screen
	Checksum: 0x9CB45A09
	Offset: 0xA0
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
	Name: function_5c1bb138
	Namespace: success_screen
	Checksum: 0x7A5202CF
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_6dd74b12();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: success_screen
	Checksum: 0xE2A4807E
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
	Namespace: success_screen
	Checksum: 0x212E3DAC
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
	Namespace: success_screen
	Checksum: 0x9402D1AA
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

#namespace namespace_6dd74b12;

/*
	Name: __constructor
	Namespace: namespace_6dd74b12
	Checksum: 0xCC7571C3
	Offset: 0x1A8
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
	Checksum: 0x65DFAE15
	Offset: 0x1C8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_6dd74b12
	Checksum: 0x504C9D50
	Offset: 0x1F8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	namespace_6aaccc24::function_5c1bb138(uid);
}

/*
	Name: function_fa582112
	Namespace: namespace_6dd74b12
	Checksum: 0x4A9C8559
	Offset: 0x228
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
}

/*
	Name: open
	Namespace: namespace_6dd74b12
	Checksum: 0x9B73C672
	Offset: 0x258
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"success_screen");
}

/*
	Name: __destructor
	Namespace: namespace_6dd74b12
	Checksum: 0x46EA9978
	Offset: 0x290
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
	Checksum: 0x8C01BE3C
	Offset: 0x2B0
	Size: 0x356
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_6dd74b12()
{
	classes.var_6dd74b12[0] = spawnstruct();
	classes.var_6dd74b12[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_6dd74b12[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_6dd74b12[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_6dd74b12[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_6dd74b12[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_6dd74b12[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_6dd74b12[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_6dd74b12[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_6dd74b12[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_6dd74b12[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_6dd74b12[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_6dd74b12[0].__vtable[913321084] = &namespace_6dd74b12::__destructor;
	classes.var_6dd74b12[0].__vtable[250899321] = &namespace_6dd74b12::open;
	classes.var_6dd74b12[0].__vtable[94887662] = &namespace_6dd74b12::function_fa582112;
	classes.var_6dd74b12[0].__vtable[1545318712] = &namespace_6dd74b12::function_5c1bb138;
	classes.var_6dd74b12[0].__vtable[1855416484] = &namespace_6dd74b12::setup_clientfields;
	classes.var_6dd74b12[0].__vtable[674154906] = &namespace_6dd74b12::__constructor;
}

