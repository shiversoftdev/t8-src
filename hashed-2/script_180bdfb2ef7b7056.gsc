// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace self_respawn;

/*
	Name: register
	Namespace: self_respawn
	Checksum: 0xCC9D396C
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_1089a5f3)
{
	object = new var_28a7d65d();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_1089a5f3);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: self_respawn
	Checksum: 0xC8CBE6B8
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_28a7d65d();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_respawn
	Checksum: 0x28F2AB3E
	Offset: 0x150
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
	Namespace: self_respawn
	Checksum: 0x603DC5C2
	Offset: 0x178
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
	Namespace: self_respawn
	Checksum: 0xC1113908
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_459465a
	Namespace: self_respawn
	Checksum: 0x8B484602
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_459465a(localclientnum, value)
{
	[[ self ]]->function_459465a(localclientnum, value);
}

#namespace namespace_28a7d65d;

/*
	Name: __constructor
	Namespace: namespace_28a7d65d
	Checksum: 0xF583C835
	Offset: 0x1F8
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
	Namespace: namespace_28a7d65d
	Checksum: 0xAC8AC4A8
	Offset: 0x218
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function setup_clientfields(uid, var_1089a5f3)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("percent", 4000, 6, "float", var_1089a5f3);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_28a7d65d
	Checksum: 0x75C572B1
	Offset: 0x278
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
	Namespace: namespace_28a7d65d
	Checksum: 0x5B95A9A2
	Offset: 0x2A8
	Size: 0x48
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "percent", 0);
}

/*
	Name: open
	Namespace: namespace_28a7d65d
	Checksum: 0x815A405B
	Offset: 0x2F8
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"self_respawn");
}

/*
	Name: function_459465a
	Namespace: namespace_28a7d65d
	Checksum: 0x4F8D2406
	Offset: 0x330
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_459465a(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "percent", value);
}

/*
	Name: __destructor
	Namespace: namespace_28a7d65d
	Checksum: 0x1B8A4E44
	Offset: 0x368
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace self_respawn;

/*
	Name: function_28a7d65d
	Namespace: self_respawn
	Checksum: 0xC7443DDE
	Offset: 0x388
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_28a7d65d()
{
	classes.var_28a7d65d[0] = spawnstruct();
	classes.var_28a7d65d[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_28a7d65d[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_28a7d65d[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_28a7d65d[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_28a7d65d[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_28a7d65d[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_28a7d65d[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_28a7d65d[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_28a7d65d[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_28a7d65d[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_28a7d65d[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_28a7d65d[0].__vtable[913321084] = &namespace_28a7d65d::__destructor;
	classes.var_28a7d65d[0].__vtable[72959578] = &namespace_28a7d65d::function_459465a;
	classes.var_28a7d65d[0].__vtable[250899321] = &namespace_28a7d65d::open;
	classes.var_28a7d65d[0].__vtable[94887662] = &namespace_28a7d65d::function_fa582112;
	classes.var_28a7d65d[0].__vtable[1545318712] = &namespace_28a7d65d::function_5c1bb138;
	classes.var_28a7d65d[0].__vtable[1855416484] = &namespace_28a7d65d::setup_clientfields;
	classes.var_28a7d65d[0].__vtable[674154906] = &namespace_28a7d65d::__constructor;
}

