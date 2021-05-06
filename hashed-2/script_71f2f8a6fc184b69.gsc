// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace insertion_passenger_count;

/*
	Name: register
	Namespace: insertion_passenger_count
	Checksum: 0x17DB45A3
	Offset: 0xA8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_fbcc4763)
{
	object = new var_b6e5ba9d();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_fbcc4763);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: insertion_passenger_count
	Checksum: 0x7F774449
	Offset: 0x100
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_b6e5ba9d();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: insertion_passenger_count
	Checksum: 0xB2C98BB5
	Offset: 0x148
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
	Namespace: insertion_passenger_count
	Checksum: 0xAD6ABCF6
	Offset: 0x170
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
	Namespace: insertion_passenger_count
	Checksum: 0xA9D3CCED
	Offset: 0x198
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_count
	Namespace: insertion_passenger_count
	Checksum: 0x99E6EAC4
	Offset: 0x1C0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_count(localclientnum, value)
{
	[[ self ]]->set_count(localclientnum, value);
}

#namespace namespace_b6e5ba9d;

/*
	Name: __constructor
	Namespace: namespace_b6e5ba9d
	Checksum: 0x4F07467
	Offset: 0x1F0
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
	Namespace: namespace_b6e5ba9d
	Checksum: 0x75B74D01
	Offset: 0x210
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function setup_clientfields(uid, var_fbcc4763)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("count", 1, 7, "int", var_fbcc4763);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_b6e5ba9d
	Checksum: 0x2A2CFAAF
	Offset: 0x270
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
	Namespace: namespace_b6e5ba9d
	Checksum: 0xFFE3B3DB
	Offset: 0x2A0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "count", 0);
}

/*
	Name: open
	Namespace: namespace_b6e5ba9d
	Checksum: 0x515377C3
	Offset: 0x2E8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"insertion_passenger_count");
}

/*
	Name: set_count
	Namespace: namespace_b6e5ba9d
	Checksum: 0x2966892C
	Offset: 0x320
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function set_count(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "count", value);
}

/*
	Name: __destructor
	Namespace: namespace_b6e5ba9d
	Checksum: 0xBE7D7DAA
	Offset: 0x358
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace insertion_passenger_count;

/*
	Name: function_b6e5ba9d
	Namespace: insertion_passenger_count
	Checksum: 0xE87B5D00
	Offset: 0x378
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_b6e5ba9d()
{
	classes.var_b6e5ba9d[0] = spawnstruct();
	classes.var_b6e5ba9d[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_b6e5ba9d[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_b6e5ba9d[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_b6e5ba9d[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_b6e5ba9d[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_b6e5ba9d[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_b6e5ba9d[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_b6e5ba9d[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_b6e5ba9d[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_b6e5ba9d[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_b6e5ba9d[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_b6e5ba9d[0].__vtable[913321084] = &namespace_b6e5ba9d::__destructor;
	classes.var_b6e5ba9d[0].__vtable[1689304324] = &namespace_b6e5ba9d::set_count;
	classes.var_b6e5ba9d[0].__vtable[250899321] = &namespace_b6e5ba9d::open;
	classes.var_b6e5ba9d[0].__vtable[94887662] = &namespace_b6e5ba9d::function_fa582112;
	classes.var_b6e5ba9d[0].__vtable[1545318712] = &namespace_b6e5ba9d::function_5c1bb138;
	classes.var_b6e5ba9d[0].__vtable[1855416484] = &namespace_b6e5ba9d::setup_clientfields;
	classes.var_b6e5ba9d[0].__vtable[674154906] = &namespace_b6e5ba9d::__constructor;
}

