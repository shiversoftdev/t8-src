// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_laststand_client;

/*
	Name: register
	Namespace: zm_laststand_client
	Checksum: 0x953EE0C1
	Offset: 0xE0
	Size: 0x64
	Parameters: 4
	Flags: Linked
*/
function register(uid, var_a9a4e140, var_e97e7153, var_5db69c99)
{
	object = new var_af345a5f();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_a9a4e140, var_e97e7153, var_5db69c99);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_laststand_client
	Checksum: 0x8673CD5E
	Offset: 0x150
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_af345a5f();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_laststand_client
	Checksum: 0x6C42E100
	Offset: 0x198
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
	Namespace: zm_laststand_client
	Checksum: 0x3E991D85
	Offset: 0x1C0
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
	Namespace: zm_laststand_client
	Checksum: 0xA1BF77C6
	Offset: 0x1E8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_67bdfe40
	Namespace: zm_laststand_client
	Checksum: 0xE6DDC324
	Offset: 0x210
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_67bdfe40(localclientnum, value)
{
	[[ self ]]->function_67bdfe40(localclientnum, value);
}

/*
	Name: function_d50fdde9
	Namespace: zm_laststand_client
	Checksum: 0xEDA1E986
	Offset: 0x240
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d50fdde9(localclientnum, value)
{
	[[ self ]]->function_d50fdde9(localclientnum, value);
}

/*
	Name: function_65194707
	Namespace: zm_laststand_client
	Checksum: 0x4B9C228C
	Offset: 0x270
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_65194707(localclientnum, value)
{
	[[ self ]]->function_65194707(localclientnum, value);
}

#namespace namespace_af345a5f;

/*
	Name: __constructor
	Namespace: namespace_af345a5f
	Checksum: 0xCA14C5DD
	Offset: 0x2A0
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
	Namespace: namespace_af345a5f
	Checksum: 0x8315B949
	Offset: 0x2C0
	Size: 0xB4
	Parameters: 4
	Flags: Linked
*/
function setup_clientfields(uid, var_a9a4e140, var_e97e7153, var_5db69c99)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("bleedout_progress", 1, 6, "float", var_a9a4e140);
	namespace_6aaccc24::function_da693cbe("revive_progress", 1, 5, "float", var_e97e7153);
	namespace_6aaccc24::function_da693cbe("num_downs", 1, 8, "int", var_5db69c99);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_af345a5f
	Checksum: 0x3463E936
	Offset: 0x380
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
	Namespace: namespace_af345a5f
	Checksum: 0x2A3A5C11
	Offset: 0x3B0
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "bleedout_progress", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "revive_progress", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "num_downs", 0);
}

/*
	Name: open
	Namespace: namespace_af345a5f
	Checksum: 0xBA92EEB0
	Offset: 0x440
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_laststand_client");
}

/*
	Name: function_67bdfe40
	Namespace: namespace_af345a5f
	Checksum: 0xC5742D28
	Offset: 0x478
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_67bdfe40(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "bleedout_progress", value);
}

/*
	Name: function_d50fdde9
	Namespace: namespace_af345a5f
	Checksum: 0x96D0312C
	Offset: 0x4B0
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_d50fdde9(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "revive_progress", value);
}

/*
	Name: function_65194707
	Namespace: namespace_af345a5f
	Checksum: 0xB979D720
	Offset: 0x4E8
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_65194707(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "num_downs", value);
}

/*
	Name: __destructor
	Namespace: namespace_af345a5f
	Checksum: 0xB0EA0257
	Offset: 0x520
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_laststand_client;

/*
	Name: function_af345a5f
	Namespace: zm_laststand_client
	Checksum: 0xCC5FBF37
	Offset: 0x540
	Size: 0x3E6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_af345a5f()
{
	classes.var_af345a5f[0] = spawnstruct();
	classes.var_af345a5f[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_af345a5f[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_af345a5f[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_af345a5f[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_af345a5f[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_af345a5f[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_af345a5f[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_af345a5f[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_af345a5f[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_af345a5f[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_af345a5f[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_af345a5f[0].__vtable[913321084] = &namespace_af345a5f::__destructor;
	classes.var_af345a5f[0].__vtable[1696155399] = &namespace_af345a5f::function_65194707;
	classes.var_af345a5f[0].__vtable[720380439] = &namespace_af345a5f::function_d50fdde9;
	classes.var_af345a5f[0].__vtable[1740504640] = &namespace_af345a5f::function_67bdfe40;
	classes.var_af345a5f[0].__vtable[250899321] = &namespace_af345a5f::open;
	classes.var_af345a5f[0].__vtable[94887662] = &namespace_af345a5f::function_fa582112;
	classes.var_af345a5f[0].__vtable[1545318712] = &namespace_af345a5f::function_5c1bb138;
	classes.var_af345a5f[0].__vtable[1855416484] = &namespace_af345a5f::setup_clientfields;
	classes.var_af345a5f[0].__vtable[674154906] = &namespace_af345a5f::__constructor;
}

