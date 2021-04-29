// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_game_timer;

/*
	Name: register
	Namespace: zm_game_timer
	Checksum: 0x770EF87A
	Offset: 0xC0
	Size: 0x64
	Parameters: 4
	Flags: None
*/
function register(uid, var_b1de907e, var_359a4d9a, var_8fd8bfaa)
{
	object = new var_140ed462();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_b1de907e, var_359a4d9a, var_8fd8bfaa);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_game_timer
	Checksum: 0x1AA696BE
	Offset: 0x130
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_140ed462();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_game_timer
	Checksum: 0xCB4327C5
	Offset: 0x178
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
	Namespace: zm_game_timer
	Checksum: 0x30C88B9B
	Offset: 0x1A0
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
	Namespace: zm_game_timer
	Checksum: 0xDCA510B8
	Offset: 0x1C8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_c48569e7
	Namespace: zm_game_timer
	Checksum: 0x73B55EBE
	Offset: 0x1F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_c48569e7(localclientnum, value)
{
	[[ self ]]->function_c48569e7(localclientnum, value);
}

/*
	Name: function_21eb67aa
	Namespace: zm_game_timer
	Checksum: 0xFDA88E29
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_21eb67aa(localclientnum, value)
{
	[[ self ]]->function_21eb67aa(localclientnum, value);
}

/*
	Name: function_7954feaf
	Namespace: zm_game_timer
	Checksum: 0xB436270D
	Offset: 0x250
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7954feaf(localclientnum, value)
{
	[[ self ]]->function_7954feaf(localclientnum, value);
}

#namespace namespace_140ed462;

/*
	Name: __constructor
	Namespace: namespace_140ed462
	Checksum: 0xBAFC6C13
	Offset: 0x280
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
	Namespace: namespace_140ed462
	Checksum: 0xFB9F5F43
	Offset: 0x2A0
	Size: 0xB4
	Parameters: 4
	Flags: None
*/
function setup_clientfields(uid, var_b1de907e, var_359a4d9a, var_8fd8bfaa)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("seconds", 1, 6, "int", var_b1de907e);
	namespace_6aaccc24::function_da693cbe("minutes", 1, 9, "int", var_359a4d9a);
	namespace_6aaccc24::function_da693cbe("showzero", 1, 1, "int", var_8fd8bfaa);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_140ed462
	Checksum: 0xDEFB438D
	Offset: 0x360
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
	Namespace: namespace_140ed462
	Checksum: 0xE2A72655
	Offset: 0x390
	Size: 0x78
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "seconds", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "minutes", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "showzero", 0);
}

/*
	Name: open
	Namespace: namespace_140ed462
	Checksum: 0x91F1521
	Offset: 0x410
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_game_timer");
}

/*
	Name: function_c48569e7
	Namespace: namespace_140ed462
	Checksum: 0x44EB424D
	Offset: 0x448
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_c48569e7(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "seconds", value);
}

/*
	Name: function_21eb67aa
	Namespace: namespace_140ed462
	Checksum: 0x474EEA73
	Offset: 0x480
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_21eb67aa(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "minutes", value);
}

/*
	Name: function_7954feaf
	Namespace: namespace_140ed462
	Checksum: 0x244B186E
	Offset: 0x4B8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_7954feaf(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "showzero", value);
}

/*
	Name: __destructor
	Namespace: namespace_140ed462
	Checksum: 0x201650C4
	Offset: 0x4F0
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_game_timer;

/*
	Name: function_140ed462
	Namespace: zm_game_timer
	Checksum: 0x1570D1CF
	Offset: 0x510
	Size: 0x3E6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_140ed462()
{
	classes.var_140ed462[0] = spawnstruct();
	classes.var_140ed462[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_140ed462[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_140ed462[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_140ed462[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_140ed462[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_140ed462[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_140ed462[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_140ed462[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_140ed462[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_140ed462[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_140ed462[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_140ed462[0].__vtable[913321084] = &namespace_140ed462::__destructor;
	classes.var_140ed462[0].__vtable[2035613359] = &namespace_140ed462::function_7954feaf;
	classes.var_140ed462[0].__vtable[569075626] = &namespace_140ed462::function_21eb67aa;
	classes.var_140ed462[0].__vtable[997889561] = &namespace_140ed462::function_c48569e7;
	classes.var_140ed462[0].__vtable[250899321] = &namespace_140ed462::open;
	classes.var_140ed462[0].__vtable[94887662] = &namespace_140ed462::function_fa582112;
	classes.var_140ed462[0].__vtable[1545318712] = &namespace_140ed462::function_5c1bb138;
	classes.var_140ed462[0].__vtable[1855416484] = &namespace_140ed462::setup_clientfields;
	classes.var_140ed462[0].__vtable[674154906] = &namespace_140ed462::__constructor;
}

