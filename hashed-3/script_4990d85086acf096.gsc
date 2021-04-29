// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_location;

/*
	Name: register
	Namespace: zm_location
	Checksum: 0xE89A82EA
	Offset: 0xB8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_5c0f4d11)
{
	object = new var_ec0fbe79();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_5c0f4d11);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_location
	Checksum: 0x61FDE613
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_ec0fbe79();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_location
	Checksum: 0x938DD70F
	Offset: 0x158
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
	Namespace: zm_location
	Checksum: 0x520174B5
	Offset: 0x180
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
	Namespace: zm_location
	Checksum: 0x8063A3D6
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_e967988b
	Namespace: zm_location
	Checksum: 0x8D484312
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_e967988b(localclientnum, value)
{
	[[ self ]]->function_e967988b(localclientnum, value);
}

#namespace namespace_ec0fbe79;

/*
	Name: __constructor
	Namespace: namespace_ec0fbe79
	Checksum: 0x144846DD
	Offset: 0x200
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
	Namespace: namespace_ec0fbe79
	Checksum: 0x27606F78
	Offset: 0x220
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function setup_clientfields(uid, var_5c0f4d11)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_dcb34c80("string", "location_name", 1);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_ec0fbe79
	Checksum: 0xD11D3009
	Offset: 0x280
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
	Namespace: namespace_ec0fbe79
	Checksum: 0xBDB01B95
	Offset: 0x2B0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "location_name", #"");
}

/*
	Name: open
	Namespace: namespace_ec0fbe79
	Checksum: 0x7F36AFBE
	Offset: 0x308
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_location");
}

/*
	Name: function_e967988b
	Namespace: namespace_ec0fbe79
	Checksum: 0xC2786A25
	Offset: 0x340
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_e967988b(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "location_name", value);
}

/*
	Name: __destructor
	Namespace: namespace_ec0fbe79
	Checksum: 0xA5AF63B2
	Offset: 0x378
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_location;

/*
	Name: function_ec0fbe79
	Namespace: zm_location
	Checksum: 0xF1162FAE
	Offset: 0x398
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_ec0fbe79()
{
	classes.var_ec0fbe79[0] = spawnstruct();
	classes.var_ec0fbe79[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_ec0fbe79[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_ec0fbe79[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_ec0fbe79[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_ec0fbe79[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_ec0fbe79[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_ec0fbe79[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_ec0fbe79[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_ec0fbe79[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_ec0fbe79[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_ec0fbe79[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_ec0fbe79[0].__vtable[913321084] = &namespace_ec0fbe79::__destructor;
	classes.var_ec0fbe79[0].__vtable[379086709] = &namespace_ec0fbe79::function_e967988b;
	classes.var_ec0fbe79[0].__vtable[250899321] = &namespace_ec0fbe79::open;
	classes.var_ec0fbe79[0].__vtable[94887662] = &namespace_ec0fbe79::function_fa582112;
	classes.var_ec0fbe79[0].__vtable[1545318712] = &namespace_ec0fbe79::function_5c1bb138;
	classes.var_ec0fbe79[0].__vtable[1855416484] = &namespace_ec0fbe79::setup_clientfields;
	classes.var_ec0fbe79[0].__vtable[674154906] = &namespace_ec0fbe79::__constructor;
}

