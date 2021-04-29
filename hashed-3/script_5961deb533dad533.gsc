// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace luielembar;

/*
	Name: set_color
	Namespace: luielembar
	Checksum: 0xBB552664
	Offset: 0x110
	Size: 0x6C
	Parameters: 4
	Flags: None
*/
function set_color(player, red, green, blue)
{
	self function_eccc151d(player, red);
	self function_2208b8db(player, green);
	self function_7420df0a(player, blue);
}

/*
	Name: fade
	Namespace: luielembar
	Checksum: 0x838FF959
	Offset: 0x188
	Size: 0x7C
	Parameters: 3
	Flags: None
*/
function fade(player, var_1a92607f, duration = 0)
{
	self function_aa5c711d(player, var_1a92607f);
	self function_237ff433(player, int(duration * 10));
}

/*
	Name: show
	Namespace: luielembar
	Checksum: 0xDA5F2429
	Offset: 0x210
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function show(player, duration = 0)
{
	self fade(player, 1, duration);
}

/*
	Name: hide
	Namespace: luielembar
	Checksum: 0xB71A439B
	Offset: 0x260
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function hide(player, duration = 0)
{
	self fade(player, 0, duration);
}

/*
	Name: function_e5898fd7
	Namespace: luielembar
	Checksum: 0xDB2DC95
	Offset: 0x2A8
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function function_e5898fd7(player, var_c6572d9b)
{
	self set_x(player, int(var_c6572d9b / 15));
}

/*
	Name: function_58a135d3
	Namespace: luielembar
	Checksum: 0x345E3AB8
	Offset: 0x300
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function function_58a135d3(player, var_d390c80e)
{
	self set_y(player, int(var_d390c80e / 15));
}

/*
	Name: function_f97e9049
	Namespace: luielembar
	Checksum: 0x12D2ED2F
	Offset: 0x358
	Size: 0x4C
	Parameters: 3
	Flags: None
*/
function function_f97e9049(player, var_c6572d9b, var_d390c80e)
{
	self function_e5898fd7(player, var_c6572d9b);
	self function_58a135d3(player, var_d390c80e);
}

/*
	Name: function_35f52fe9
	Namespace: luielembar
	Checksum: 0xC804FF11
	Offset: 0x3B0
	Size: 0x8C
	Parameters: 3
	Flags: None
*/
function function_35f52fe9(player, width, height)
{
	self function_8b0b5811(player, int(width / 4));
	self function_5dbd7024(player, int(height / 4));
}

/*
	Name: register
	Namespace: luielembar
	Checksum: 0x3D8405A8
	Offset: 0x448
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_3c805d30();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielembar
	Checksum: 0x5D7E346E
	Offset: 0x490
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: luielembar
	Checksum: 0x77D29E05
	Offset: 0x4D0
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
	Namespace: luielembar
	Checksum: 0x8008BD42
	Offset: 0x4F8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_x
	Namespace: luielembar
	Checksum: 0xADC9FF71
	Offset: 0x520
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_x(player, value)
{
	[[ self ]]->set_x(player, value);
}

/*
	Name: set_y
	Namespace: luielembar
	Checksum: 0x266C89A
	Offset: 0x550
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_y(player, value)
{
	[[ self ]]->set_y(player, value);
}

/*
	Name: function_8b0b5811
	Namespace: luielembar
	Checksum: 0x5C1AC7EB
	Offset: 0x580
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8b0b5811(player, value)
{
	[[ self ]]->function_8b0b5811(player, value);
}

/*
	Name: function_5dbd7024
	Namespace: luielembar
	Checksum: 0xD2638470
	Offset: 0x5B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5dbd7024(player, value)
{
	[[ self ]]->function_5dbd7024(player, value);
}

/*
	Name: function_237ff433
	Namespace: luielembar
	Checksum: 0x3057448B
	Offset: 0x5E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_237ff433(player, value)
{
	[[ self ]]->function_237ff433(player, value);
}

/*
	Name: function_aa5c711d
	Namespace: luielembar
	Checksum: 0x52C7AFF8
	Offset: 0x610
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_aa5c711d(player, value)
{
	[[ self ]]->function_aa5c711d(player, value);
}

/*
	Name: function_eccc151d
	Namespace: luielembar
	Checksum: 0x4A25CB24
	Offset: 0x640
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_eccc151d(player, value)
{
	[[ self ]]->function_eccc151d(player, value);
}

/*
	Name: function_2208b8db
	Namespace: luielembar
	Checksum: 0x1E46B737
	Offset: 0x670
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_2208b8db(player, value)
{
	[[ self ]]->function_2208b8db(player, value);
}

/*
	Name: function_7420df0a
	Namespace: luielembar
	Checksum: 0x765C5729
	Offset: 0x6A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7420df0a(player, value)
{
	[[ self ]]->function_7420df0a(player, value);
}

/*
	Name: function_fd8c13fb
	Namespace: luielembar
	Checksum: 0xB4F3976
	Offset: 0x6D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_fd8c13fb(player, value)
{
	[[ self ]]->function_fd8c13fb(player, value);
}

#namespace namespace_3c805d30;

/*
	Name: __constructor
	Namespace: namespace_3c805d30
	Checksum: 0x513C597F
	Offset: 0x700
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
	Namespace: namespace_3c805d30
	Checksum: 0xF04C8EF
	Offset: 0x720
	Size: 0x1B4
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("x", 1, 7, "int");
	namespace_6aaccc24::function_da693cbe("y", 1, 6, "int");
	namespace_6aaccc24::function_da693cbe("width", 1, 6, "int");
	namespace_6aaccc24::function_da693cbe("height", 1, 6, "int");
	namespace_6aaccc24::function_da693cbe("fadeOverTime", 1, 5, "int");
	namespace_6aaccc24::function_da693cbe("alpha", 1, 4, "float");
	namespace_6aaccc24::function_da693cbe("red", 1, 4, "float");
	namespace_6aaccc24::function_da693cbe("green", 1, 4, "float");
	namespace_6aaccc24::function_da693cbe("blue", 1, 4, "float");
	namespace_6aaccc24::function_da693cbe("bar_percent", 1, 6, "float");
}

/*
	Name: open
	Namespace: namespace_3c805d30
	Checksum: 0x86E81213
	Offset: 0x8E0
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "LUIelemBar", persistent);
}

/*
	Name: close
	Namespace: namespace_3c805d30
	Checksum: 0xDE576393
	Offset: 0x930
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: set_x
	Namespace: namespace_3c805d30
	Checksum: 0xE91B164C
	Offset: 0x960
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function set_x(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "x", value);
}

/*
	Name: set_y
	Namespace: namespace_3c805d30
	Checksum: 0xBFC92ECC
	Offset: 0x9A8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function set_y(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "y", value);
}

/*
	Name: function_8b0b5811
	Namespace: namespace_3c805d30
	Checksum: 0xED9FFF82
	Offset: 0x9F0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_8b0b5811(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "width", value);
}

/*
	Name: function_5dbd7024
	Namespace: namespace_3c805d30
	Checksum: 0xB89270D4
	Offset: 0xA38
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_5dbd7024(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "height", value);
}

/*
	Name: function_237ff433
	Namespace: namespace_3c805d30
	Checksum: 0x2B63A693
	Offset: 0xA80
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_237ff433(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "fadeOverTime", value);
}

/*
	Name: function_aa5c711d
	Namespace: namespace_3c805d30
	Checksum: 0x37F9990F
	Offset: 0xAC8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_aa5c711d(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "alpha", value);
}

/*
	Name: function_eccc151d
	Namespace: namespace_3c805d30
	Checksum: 0x1C2A8
	Offset: 0xB10
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_eccc151d(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "red", value);
}

/*
	Name: function_2208b8db
	Namespace: namespace_3c805d30
	Checksum: 0xB30BAD0C
	Offset: 0xB58
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_2208b8db(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "green", value);
}

/*
	Name: function_7420df0a
	Namespace: namespace_3c805d30
	Checksum: 0x12ADC59C
	Offset: 0xBA0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_7420df0a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "blue", value);
}

/*
	Name: function_fd8c13fb
	Namespace: namespace_3c805d30
	Checksum: 0x3023F565
	Offset: 0xBE8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_fd8c13fb(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "bar_percent", value);
}

/*
	Name: __destructor
	Namespace: namespace_3c805d30
	Checksum: 0x7042ED4A
	Offset: 0xC30
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace luielembar;

/*
	Name: function_3c805d30
	Namespace: luielembar
	Checksum: 0x499642F2
	Offset: 0xC50
	Size: 0x4D6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_3c805d30()
{
	classes.var_3c805d30[0] = spawnstruct();
	classes.var_3c805d30[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_3c805d30[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_3c805d30[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_3c805d30[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_3c805d30[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_3c805d30[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_3c805d30[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_3c805d30[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_3c805d30[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_3c805d30[0].__vtable[913321084] = &namespace_6aaccc24::__destructor;
	classes.var_3c805d30[0].__vtable[913321084] = &namespace_3c805d30::__destructor;
	classes.var_3c805d30[0].__vtable[41151493] = &namespace_3c805d30::function_fd8c13fb;
	classes.var_3c805d30[0].__vtable[1948311306] = &namespace_3c805d30::function_7420df0a;
	classes.var_3c805d30[0].__vtable[570996955] = &namespace_3c805d30::function_2208b8db;
	classes.var_3c805d30[0].__vtable[322169571] = &namespace_3c805d30::function_eccc151d;
	classes.var_3c805d30[0].__vtable[1436782307] = &namespace_3c805d30::function_aa5c711d;
	classes.var_3c805d30[0].__vtable[595588147] = &namespace_3c805d30::function_237ff433;
	classes.var_3c805d30[0].__vtable[1572696100] = &namespace_3c805d30::function_5dbd7024;
	classes.var_3c805d30[0].__vtable[1962190831] = &namespace_3c805d30::function_8b0b5811;
	classes.var_3c805d30[0].__vtable[1687309110] = &namespace_3c805d30::set_y;
	classes.var_3c805d30[0].__vtable[765680993] = &namespace_3c805d30::set_x;
	classes.var_3c805d30[0].__vtable[1516492343] = &namespace_3c805d30::close;
	classes.var_3c805d30[0].__vtable[250899321] = &namespace_3c805d30::open;
	classes.var_3c805d30[0].__vtable[1855416484] = &namespace_3c805d30::setup_clientfields;
	classes.var_3c805d30[0].__vtable[674154906] = &namespace_3c805d30::__constructor;
}

