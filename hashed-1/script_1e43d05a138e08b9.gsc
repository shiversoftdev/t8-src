// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace wz_wingsuit_hud;

/*
	Name: register
	Namespace: wz_wingsuit_hud
	Checksum: 0x2A21ABC4
	Offset: 0xA0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_1e9d002b();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: wz_wingsuit_hud
	Checksum: 0xA8F05470
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_1e9d002b();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: wz_wingsuit_hud
	Checksum: 0xE03661EF
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
	Namespace: wz_wingsuit_hud
	Checksum: 0x13CA209
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
	Namespace: wz_wingsuit_hud
	Checksum: 0x430F6E1E
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

#namespace namespace_1e9d002b;

/*
	Name: __constructor
	Namespace: namespace_1e9d002b
	Checksum: 0x84F7EB9E
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
	Namespace: namespace_1e9d002b
	Checksum: 0xA6EF1321
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
	Namespace: namespace_1e9d002b
	Checksum: 0x1801DF20
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
	Namespace: namespace_1e9d002b
	Checksum: 0xA585160E
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
	Namespace: namespace_1e9d002b
	Checksum: 0xF45B9762
	Offset: 0x258
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"wz_wingsuit_hud");
}

/*
	Name: __destructor
	Namespace: namespace_1e9d002b
	Checksum: 0xE06E5AFE
	Offset: 0x290
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace wz_wingsuit_hud;

/*
	Name: function_1e9d002b
	Namespace: wz_wingsuit_hud
	Checksum: 0x7B3EC2B0
	Offset: 0x2B0
	Size: 0x356
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_1e9d002b()
{
	classes.var_1e9d002b[0] = spawnstruct();
	classes.var_1e9d002b[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_1e9d002b[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_1e9d002b[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_1e9d002b[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_1e9d002b[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_1e9d002b[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_1e9d002b[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_1e9d002b[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_1e9d002b[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_1e9d002b[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_1e9d002b[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_1e9d002b[0].__vtable[913321084] = &namespace_1e9d002b::__destructor;
	classes.var_1e9d002b[0].__vtable[250899321] = &namespace_1e9d002b::open;
	classes.var_1e9d002b[0].__vtable[94887662] = &namespace_1e9d002b::function_fa582112;
	classes.var_1e9d002b[0].__vtable[1545318712] = &namespace_1e9d002b::function_5c1bb138;
	classes.var_1e9d002b[0].__vtable[1855416484] = &namespace_1e9d002b::setup_clientfields;
	classes.var_1e9d002b[0].__vtable[674154906] = &namespace_1e9d002b::__constructor;
}
