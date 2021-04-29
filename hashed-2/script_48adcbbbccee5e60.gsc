// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace interactive_shot;

/*
	Name: register
	Namespace: interactive_shot
	Checksum: 0x30B9AC25
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_f5852d69)
{
	object = new var_849c5d15();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_f5852d69);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: interactive_shot
	Checksum: 0x6CC23690
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_849c5d15();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: interactive_shot
	Checksum: 0x602C561
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
	Namespace: interactive_shot
	Checksum: 0x1A05F74F
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
	Namespace: interactive_shot
	Checksum: 0x86A869F8
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
	Name: function_d5ea17f0
	Namespace: interactive_shot
	Checksum: 0x2AC5D9C1
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(localclientnum, value)
{
	[[ self ]]->function_d5ea17f0(localclientnum, value);
}

#namespace namespace_849c5d15;

/*
	Name: __constructor
	Namespace: namespace_849c5d15
	Checksum: 0x340CDAD8
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
	Namespace: namespace_849c5d15
	Checksum: 0x50EDB24E
	Offset: 0x218
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function setup_clientfields(uid, var_f5852d69)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_dcb34c80("string", "text", 1);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_849c5d15
	Checksum: 0xF9634FF2
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
	Namespace: namespace_849c5d15
	Checksum: 0x2DD4505B
	Offset: 0x2A8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "text", #"");
}

/*
	Name: open
	Namespace: namespace_849c5d15
	Checksum: 0x7DF4F754
	Offset: 0x300
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"interactive_shot");
}

/*
	Name: function_d5ea17f0
	Namespace: namespace_849c5d15
	Checksum: 0xE9B23DE4
	Offset: 0x338
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "text", value);
}

/*
	Name: __destructor
	Namespace: namespace_849c5d15
	Checksum: 0x863349DE
	Offset: 0x370
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace interactive_shot;

/*
	Name: function_849c5d15
	Namespace: interactive_shot
	Checksum: 0x1124BD84
	Offset: 0x390
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_849c5d15()
{
	classes.var_849c5d15[0] = spawnstruct();
	classes.var_849c5d15[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_849c5d15[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_849c5d15[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_849c5d15[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_849c5d15[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_849c5d15[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_849c5d15[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_849c5d15[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_849c5d15[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_849c5d15[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_849c5d15[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_849c5d15[0].__vtable[913321084] = &namespace_849c5d15::__destructor;
	classes.var_849c5d15[0].__vtable[706078736] = &namespace_849c5d15::function_d5ea17f0;
	classes.var_849c5d15[0].__vtable[250899321] = &namespace_849c5d15::open;
	classes.var_849c5d15[0].__vtable[94887662] = &namespace_849c5d15::function_fa582112;
	classes.var_849c5d15[0].__vtable[1545318712] = &namespace_849c5d15::function_5c1bb138;
	classes.var_849c5d15[0].__vtable[1855416484] = &namespace_849c5d15::setup_clientfields;
	classes.var_849c5d15[0].__vtable[674154906] = &namespace_849c5d15::__constructor;
}

