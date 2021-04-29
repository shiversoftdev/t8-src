// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_towers_pap_hud;

/*
	Name: register
	Namespace: zm_towers_pap_hud
	Checksum: 0x583C44BC
	Offset: 0xE0
	Size: 0x70
	Parameters: 5
	Flags: None
*/
function register(uid, var_54a6819c, var_6d3f4678, var_fad0d5ca, var_84879db6)
{
	object = new var_2051697f();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_54a6819c, var_6d3f4678, var_fad0d5ca, var_84879db6);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_towers_pap_hud
	Checksum: 0x4409F7AC
	Offset: 0x158
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_2051697f();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_pap_hud
	Checksum: 0x640B7803
	Offset: 0x1A0
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
	Namespace: zm_towers_pap_hud
	Checksum: 0x19150BDD
	Offset: 0x1C8
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
	Namespace: zm_towers_pap_hud
	Checksum: 0xFB1CEAE
	Offset: 0x1F0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_eda3959a
	Namespace: zm_towers_pap_hud
	Checksum: 0xE90B348B
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_eda3959a(localclientnum, value)
{
	[[ self ]]->function_eda3959a(localclientnum, value);
}

/*
	Name: function_bd5da28f
	Namespace: zm_towers_pap_hud
	Checksum: 0x21D519CA
	Offset: 0x248
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_bd5da28f(localclientnum, value)
{
	[[ self ]]->function_bd5da28f(localclientnum, value);
}

/*
	Name: function_8a094f25
	Namespace: zm_towers_pap_hud
	Checksum: 0x6403B8BA
	Offset: 0x278
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8a094f25(localclientnum, value)
{
	[[ self ]]->function_8a094f25(localclientnum, value);
}

/*
	Name: function_b6ec93fa
	Namespace: zm_towers_pap_hud
	Checksum: 0x87809A0E
	Offset: 0x2A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_b6ec93fa(localclientnum, value)
{
	[[ self ]]->function_b6ec93fa(localclientnum, value);
}

#namespace namespace_2051697f;

/*
	Name: __constructor
	Namespace: namespace_2051697f
	Checksum: 0x3722FD30
	Offset: 0x2D8
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
	Namespace: namespace_2051697f
	Checksum: 0x6901522B
	Offset: 0x2F8
	Size: 0xE4
	Parameters: 5
	Flags: None
*/
function setup_clientfields(uid, var_54a6819c, var_6d3f4678, var_fad0d5ca, var_84879db6)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("danu_acquired", 1, 1, "int", var_54a6819c);
	namespace_6aaccc24::function_da693cbe("ra_acquired", 1, 1, "int", var_6d3f4678);
	namespace_6aaccc24::function_da693cbe("zeus_acquired", 1, 1, "int", var_fad0d5ca);
	namespace_6aaccc24::function_da693cbe("odin_acquired", 1, 1, "int", var_84879db6);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_2051697f
	Checksum: 0x99D99EEF
	Offset: 0x3E8
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
	Namespace: namespace_2051697f
	Checksum: 0xE9E939FB
	Offset: 0x418
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "danu_acquired", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "ra_acquired", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "zeus_acquired", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "odin_acquired", 0);
}

/*
	Name: open
	Namespace: namespace_2051697f
	Checksum: 0x49E889F8
	Offset: 0x4B8
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_towers_pap_hud");
}

/*
	Name: function_eda3959a
	Namespace: namespace_2051697f
	Checksum: 0xBBCEC54C
	Offset: 0x4F0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_eda3959a(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "danu_acquired", value);
}

/*
	Name: function_bd5da28f
	Namespace: namespace_2051697f
	Checksum: 0xC2E0B81A
	Offset: 0x528
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_bd5da28f(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "ra_acquired", value);
}

/*
	Name: function_8a094f25
	Namespace: namespace_2051697f
	Checksum: 0x530A0E0E
	Offset: 0x560
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_8a094f25(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "zeus_acquired", value);
}

/*
	Name: function_b6ec93fa
	Namespace: namespace_2051697f
	Checksum: 0x81955F91
	Offset: 0x598
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_b6ec93fa(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "odin_acquired", value);
}

/*
	Name: __destructor
	Namespace: namespace_2051697f
	Checksum: 0x352C067D
	Offset: 0x5D0
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_towers_pap_hud;

/*
	Name: function_2051697f
	Namespace: zm_towers_pap_hud
	Checksum: 0x8E1866BA
	Offset: 0x5F0
	Size: 0x416
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_2051697f()
{
	classes.var_2051697f[0] = spawnstruct();
	classes.var_2051697f[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_2051697f[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_2051697f[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_2051697f[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_2051697f[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_2051697f[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_2051697f[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_2051697f[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_2051697f[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_2051697f[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_2051697f[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_2051697f[0].__vtable[913321084] = &namespace_2051697f::__destructor;
	classes.var_2051697f[0].__vtable[1226009606] = &namespace_2051697f::function_b6ec93fa;
	classes.var_2051697f[0].__vtable[1979101403] = &namespace_2051697f::function_8a094f25;
	classes.var_2051697f[0].__vtable[1117937009] = &namespace_2051697f::function_bd5da28f;
	classes.var_2051697f[0].__vtable[308046438] = &namespace_2051697f::function_eda3959a;
	classes.var_2051697f[0].__vtable[250899321] = &namespace_2051697f::open;
	classes.var_2051697f[0].__vtable[94887662] = &namespace_2051697f::function_fa582112;
	classes.var_2051697f[0].__vtable[1545318712] = &namespace_2051697f::function_5c1bb138;
	classes.var_2051697f[0].__vtable[1855416484] = &namespace_2051697f::setup_clientfields;
	classes.var_2051697f[0].__vtable[674154906] = &namespace_2051697f::__constructor;
}

