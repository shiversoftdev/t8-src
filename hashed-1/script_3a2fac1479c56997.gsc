// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_build_progress;

/*
	Name: register
	Namespace: zm_build_progress
	Checksum: 0x590CB2C7
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_afaddf7a)
{
	object = new var_616a42d0();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_afaddf7a);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_build_progress
	Checksum: 0x5F5D7922
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_616a42d0();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_build_progress
	Checksum: 0x36187FA
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
	Namespace: zm_build_progress
	Checksum: 0x17E11995
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
	Namespace: zm_build_progress
	Checksum: 0x2BD8FCC4
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
	Name: function_affe8f61
	Namespace: zm_build_progress
	Checksum: 0xE4EC5688
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_affe8f61(localclientnum, value)
{
	[[ self ]]->function_affe8f61(localclientnum, value);
}

#namespace namespace_616a42d0;

/*
	Name: __constructor
	Namespace: namespace_616a42d0
	Checksum: 0x552D683C
	Offset: 0x1F8
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
	Namespace: namespace_616a42d0
	Checksum: 0x915AF0A2
	Offset: 0x218
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function setup_clientfields(uid, var_afaddf7a)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("progress", 1, 6, "float", var_afaddf7a);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_616a42d0
	Checksum: 0xA0F86E98
	Offset: 0x278
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
	Namespace: namespace_616a42d0
	Checksum: 0xDFDA8CA4
	Offset: 0x2A8
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "progress", 0);
}

/*
	Name: open
	Namespace: namespace_616a42d0
	Checksum: 0x4B95EE6B
	Offset: 0x2F8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_build_progress");
}

/*
	Name: function_affe8f61
	Namespace: namespace_616a42d0
	Checksum: 0x1A68DFC5
	Offset: 0x330
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_affe8f61(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "progress", value);
}

/*
	Name: __destructor
	Namespace: namespace_616a42d0
	Checksum: 0xE101194C
	Offset: 0x368
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_build_progress;

/*
	Name: function_616a42d0
	Namespace: zm_build_progress
	Checksum: 0x3F9AB983
	Offset: 0x388
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_616a42d0()
{
	classes.var_616a42d0[0] = spawnstruct();
	classes.var_616a42d0[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_616a42d0[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_616a42d0[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_616a42d0[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_616a42d0[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_616a42d0[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_616a42d0[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_616a42d0[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_616a42d0[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_616a42d0[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_616a42d0[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_616a42d0[0].__vtable[913321084] = &namespace_616a42d0::__destructor;
	classes.var_616a42d0[0].__vtable[1342271647] = &namespace_616a42d0::function_affe8f61;
	classes.var_616a42d0[0].__vtable[250899321] = &namespace_616a42d0::open;
	classes.var_616a42d0[0].__vtable[94887662] = &namespace_616a42d0::function_fa582112;
	classes.var_616a42d0[0].__vtable[1545318712] = &namespace_616a42d0::function_5c1bb138;
	classes.var_616a42d0[0].__vtable[1855416484] = &namespace_616a42d0::setup_clientfields;
	classes.var_616a42d0[0].__vtable[674154906] = &namespace_616a42d0::__constructor;
}

