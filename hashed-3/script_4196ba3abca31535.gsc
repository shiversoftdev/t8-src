// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace luielembar_ct;

/*
	Name: register
	Namespace: luielembar_ct
	Checksum: 0xC78FF3E3
	Offset: 0x100
	Size: 0xB8
	Parameters: 11
	Flags: None
*/
function register(uid, var_218de242, var_f6cc2724, var_997793d7, var_fae6c0b5, var_a3e0a6ce, var_af074abc, var_9350f184, var_788c188f, var_3fb95ac9, var_661989d5)
{
	object = new var_5e02ffeb();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_218de242, var_f6cc2724, var_997793d7, var_fae6c0b5, var_a3e0a6ce, var_af074abc, var_9350f184, var_788c188f, var_3fb95ac9, var_661989d5);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: luielembar_ct
	Checksum: 0x8A04876A
	Offset: 0x1C0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_5e02ffeb();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielembar_ct
	Checksum: 0x98C690E6
	Offset: 0x208
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
	Namespace: luielembar_ct
	Checksum: 0x1B4BBCE1
	Offset: 0x230
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
	Namespace: luielembar_ct
	Checksum: 0x9C4CC37E
	Offset: 0x258
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_x
	Namespace: luielembar_ct
	Checksum: 0x9A9D85C8
	Offset: 0x280
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_x(localclientnum, value)
{
	[[ self ]]->set_x(localclientnum, value);
}

/*
	Name: set_y
	Namespace: luielembar_ct
	Checksum: 0x4DD71F72
	Offset: 0x2B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_y(localclientnum, value)
{
	[[ self ]]->set_y(localclientnum, value);
}

/*
	Name: function_8b0b5811
	Namespace: luielembar_ct
	Checksum: 0x7F766C93
	Offset: 0x2E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8b0b5811(localclientnum, value)
{
	[[ self ]]->function_8b0b5811(localclientnum, value);
}

/*
	Name: function_5dbd7024
	Namespace: luielembar_ct
	Checksum: 0x4F79DA60
	Offset: 0x310
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5dbd7024(localclientnum, value)
{
	[[ self ]]->function_5dbd7024(localclientnum, value);
}

/*
	Name: function_237ff433
	Namespace: luielembar_ct
	Checksum: 0xD9625158
	Offset: 0x340
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_237ff433(localclientnum, value)
{
	[[ self ]]->function_237ff433(localclientnum, value);
}

/*
	Name: function_aa5c711d
	Namespace: luielembar_ct
	Checksum: 0x3F6C09F4
	Offset: 0x370
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_aa5c711d(localclientnum, value)
{
	[[ self ]]->function_aa5c711d(localclientnum, value);
}

/*
	Name: function_eccc151d
	Namespace: luielembar_ct
	Checksum: 0x5F2E3CF1
	Offset: 0x3A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_eccc151d(localclientnum, value)
{
	[[ self ]]->function_eccc151d(localclientnum, value);
}

/*
	Name: function_2208b8db
	Namespace: luielembar_ct
	Checksum: 0x4B217B1D
	Offset: 0x3D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_2208b8db(localclientnum, value)
{
	[[ self ]]->function_2208b8db(localclientnum, value);
}

/*
	Name: function_7420df0a
	Namespace: luielembar_ct
	Checksum: 0x13AFF87D
	Offset: 0x400
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7420df0a(localclientnum, value)
{
	[[ self ]]->function_7420df0a(localclientnum, value);
}

/*
	Name: function_fd8c13fb
	Namespace: luielembar_ct
	Checksum: 0xFC0C7953
	Offset: 0x430
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_fd8c13fb(localclientnum, value)
{
	[[ self ]]->function_fd8c13fb(localclientnum, value);
}

#namespace namespace_5e02ffeb;

/*
	Name: __constructor
	Namespace: namespace_5e02ffeb
	Checksum: 0x9552399B
	Offset: 0x460
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
	Namespace: namespace_5e02ffeb
	Checksum: 0x6B11F23
	Offset: 0x480
	Size: 0x204
	Parameters: 11
	Flags: None
*/
function setup_clientfields(uid, var_218de242, var_f6cc2724, var_997793d7, var_fae6c0b5, var_a3e0a6ce, var_af074abc, var_9350f184, var_788c188f, var_3fb95ac9, var_661989d5)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("x", 1, 7, "int", var_218de242);
	namespace_6aaccc24::function_da693cbe("y", 1, 6, "int", var_f6cc2724);
	namespace_6aaccc24::function_da693cbe("width", 1, 6, "int", var_997793d7);
	namespace_6aaccc24::function_da693cbe("height", 1, 6, "int", var_fae6c0b5);
	namespace_6aaccc24::function_da693cbe("fadeOverTime", 1, 5, "int", var_a3e0a6ce);
	namespace_6aaccc24::function_da693cbe("alpha", 1, 4, "float", var_af074abc);
	namespace_6aaccc24::function_da693cbe("red", 1, 4, "float", var_9350f184);
	namespace_6aaccc24::function_da693cbe("green", 1, 4, "float", var_788c188f);
	namespace_6aaccc24::function_da693cbe("blue", 1, 4, "float", var_3fb95ac9);
	namespace_6aaccc24::function_da693cbe("bar_percent", 1, 6, "float", var_661989d5);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_5e02ffeb
	Checksum: 0xF0EBF426
	Offset: 0x690
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
	Namespace: namespace_5e02ffeb
	Checksum: 0xE101569F
	Offset: 0x6C0
	Size: 0x164
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "x", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "y", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "width", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "height", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "fadeOverTime", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "alpha", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "red", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "green", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "blue", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "bar_percent", 0);
}

/*
	Name: open
	Namespace: namespace_5e02ffeb
	Checksum: 0x9E700B97
	Offset: 0x830
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"luielembar_ct");
}

/*
	Name: set_x
	Namespace: namespace_5e02ffeb
	Checksum: 0x7AF11FC3
	Offset: 0x868
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function set_x(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "x", value);
}

/*
	Name: set_y
	Namespace: namespace_5e02ffeb
	Checksum: 0x32CD2CF9
	Offset: 0x8A0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function set_y(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "y", value);
}

/*
	Name: function_8b0b5811
	Namespace: namespace_5e02ffeb
	Checksum: 0x1EB39F13
	Offset: 0x8D8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_8b0b5811(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "width", value);
}

/*
	Name: function_5dbd7024
	Namespace: namespace_5e02ffeb
	Checksum: 0xF690483E
	Offset: 0x910
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_5dbd7024(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "height", value);
}

/*
	Name: function_237ff433
	Namespace: namespace_5e02ffeb
	Checksum: 0x45E20C67
	Offset: 0x948
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_237ff433(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "fadeOverTime", value);
}

/*
	Name: function_aa5c711d
	Namespace: namespace_5e02ffeb
	Checksum: 0xE180EDA0
	Offset: 0x980
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_aa5c711d(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "alpha", value);
}

/*
	Name: function_eccc151d
	Namespace: namespace_5e02ffeb
	Checksum: 0xD56186FF
	Offset: 0x9B8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_eccc151d(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "red", value);
}

/*
	Name: function_2208b8db
	Namespace: namespace_5e02ffeb
	Checksum: 0xD281BE9A
	Offset: 0x9F0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_2208b8db(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "green", value);
}

/*
	Name: function_7420df0a
	Namespace: namespace_5e02ffeb
	Checksum: 0xEE88222A
	Offset: 0xA28
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_7420df0a(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "blue", value);
}

/*
	Name: function_fd8c13fb
	Namespace: namespace_5e02ffeb
	Checksum: 0xE80895C1
	Offset: 0xA60
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_fd8c13fb(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "bar_percent", value);
}

/*
	Name: __destructor
	Namespace: namespace_5e02ffeb
	Checksum: 0x3176BE4B
	Offset: 0xA98
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace luielembar_ct;

/*
	Name: function_5e02ffeb
	Namespace: luielembar_ct
	Checksum: 0x849DF9D8
	Offset: 0xAB8
	Size: 0x566
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_5e02ffeb()
{
	classes.var_5e02ffeb[0] = spawnstruct();
	classes.var_5e02ffeb[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_5e02ffeb[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_5e02ffeb[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_5e02ffeb[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_5e02ffeb[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_5e02ffeb[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_5e02ffeb[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_5e02ffeb[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_5e02ffeb[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_5e02ffeb[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_5e02ffeb[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_5e02ffeb[0].__vtable[913321084] = &namespace_6aaccc24::__destructor;
	classes.var_5e02ffeb[0].__vtable[913321084] = &namespace_5e02ffeb::__destructor;
	classes.var_5e02ffeb[0].__vtable[41151493] = &namespace_5e02ffeb::function_fd8c13fb;
	classes.var_5e02ffeb[0].__vtable[1948311306] = &namespace_5e02ffeb::function_7420df0a;
	classes.var_5e02ffeb[0].__vtable[570996955] = &namespace_5e02ffeb::function_2208b8db;
	classes.var_5e02ffeb[0].__vtable[322169571] = &namespace_5e02ffeb::function_eccc151d;
	classes.var_5e02ffeb[0].__vtable[1436782307] = &namespace_5e02ffeb::function_aa5c711d;
	classes.var_5e02ffeb[0].__vtable[595588147] = &namespace_5e02ffeb::function_237ff433;
	classes.var_5e02ffeb[0].__vtable[1572696100] = &namespace_5e02ffeb::function_5dbd7024;
	classes.var_5e02ffeb[0].__vtable[1962190831] = &namespace_5e02ffeb::function_8b0b5811;
	classes.var_5e02ffeb[0].__vtable[1687309110] = &namespace_5e02ffeb::set_y;
	classes.var_5e02ffeb[0].__vtable[765680993] = &namespace_5e02ffeb::set_x;
	classes.var_5e02ffeb[0].__vtable[250899321] = &namespace_5e02ffeb::open;
	classes.var_5e02ffeb[0].__vtable[94887662] = &namespace_5e02ffeb::function_fa582112;
	classes.var_5e02ffeb[0].__vtable[1545318712] = &namespace_5e02ffeb::function_5c1bb138;
	classes.var_5e02ffeb[0].__vtable[1855416484] = &namespace_5e02ffeb::setup_clientfields;
	classes.var_5e02ffeb[0].__vtable[674154906] = &namespace_5e02ffeb::__constructor;
}

