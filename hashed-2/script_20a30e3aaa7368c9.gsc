// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace luielembar_ct;

/*
	Name: set_color
	Namespace: luielembar_ct
	Checksum: 0x7FE53244
	Offset: 0x118
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
	Namespace: luielembar_ct
	Checksum: 0x7A2ABFF0
	Offset: 0x190
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
	Namespace: luielembar_ct
	Checksum: 0xD5B4E639
	Offset: 0x218
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
	Namespace: luielembar_ct
	Checksum: 0xA36AC881
	Offset: 0x268
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
	Namespace: luielembar_ct
	Checksum: 0x5148E2B7
	Offset: 0x2B0
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
	Namespace: luielembar_ct
	Checksum: 0xE1CEED50
	Offset: 0x308
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
	Namespace: luielembar_ct
	Checksum: 0x5F039D9E
	Offset: 0x360
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
	Namespace: luielembar_ct
	Checksum: 0x4A8C1B8D
	Offset: 0x3B8
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
	Namespace: luielembar_ct
	Checksum: 0x9A8D91F2
	Offset: 0x450
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_5e02ffeb();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielembar_ct
	Checksum: 0x66AE096C
	Offset: 0x498
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
	Namespace: luielembar_ct
	Checksum: 0xD1E25B03
	Offset: 0x4D8
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
	Checksum: 0xADBC8B3C
	Offset: 0x500
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
	Namespace: luielembar_ct
	Checksum: 0x878B3D10
	Offset: 0x528
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
	Namespace: luielembar_ct
	Checksum: 0xFB4B9304
	Offset: 0x558
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
	Namespace: luielembar_ct
	Checksum: 0x93FF9059
	Offset: 0x588
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
	Namespace: luielembar_ct
	Checksum: 0x791F10A3
	Offset: 0x5B8
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
	Namespace: luielembar_ct
	Checksum: 0x4F7FF27D
	Offset: 0x5E8
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
	Namespace: luielembar_ct
	Checksum: 0xB493EE0
	Offset: 0x618
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
	Namespace: luielembar_ct
	Checksum: 0x9DF3BFF2
	Offset: 0x648
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
	Namespace: luielembar_ct
	Checksum: 0x6C07628A
	Offset: 0x678
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
	Namespace: luielembar_ct
	Checksum: 0x72764BFA
	Offset: 0x6A8
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
	Namespace: luielembar_ct
	Checksum: 0x5FD1F414
	Offset: 0x6D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_fd8c13fb(player, value)
{
	[[ self ]]->function_fd8c13fb(player, value);
}

#namespace namespace_5e02ffeb;

/*
	Name: __constructor
	Namespace: namespace_5e02ffeb
	Checksum: 0x9A0989D9
	Offset: 0x708
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
	Checksum: 0x553F19E7
	Offset: 0x728
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
	Namespace: namespace_5e02ffeb
	Checksum: 0x272F7E96
	Offset: 0x8E8
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "LUIelemBar_ct", persistent);
}

/*
	Name: close
	Namespace: namespace_5e02ffeb
	Checksum: 0x7C3A5041
	Offset: 0x938
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
	Namespace: namespace_5e02ffeb
	Checksum: 0x9AE01914
	Offset: 0x968
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
	Namespace: namespace_5e02ffeb
	Checksum: 0xBEA0A124
	Offset: 0x9B0
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
	Namespace: namespace_5e02ffeb
	Checksum: 0x7091CF0B
	Offset: 0x9F8
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
	Namespace: namespace_5e02ffeb
	Checksum: 0x8592683D
	Offset: 0xA40
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
	Namespace: namespace_5e02ffeb
	Checksum: 0xE565C188
	Offset: 0xA88
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
	Namespace: namespace_5e02ffeb
	Checksum: 0xFDFFA5D3
	Offset: 0xAD0
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
	Namespace: namespace_5e02ffeb
	Checksum: 0x88B698E3
	Offset: 0xB18
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
	Namespace: namespace_5e02ffeb
	Checksum: 0x7DE0DD94
	Offset: 0xB60
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
	Namespace: namespace_5e02ffeb
	Checksum: 0xA446DE64
	Offset: 0xBA8
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
	Namespace: namespace_5e02ffeb
	Checksum: 0xEB6F5279
	Offset: 0xBF0
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
	Namespace: namespace_5e02ffeb
	Checksum: 0x7A01DD2A
	Offset: 0xC38
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
	Checksum: 0xCB202B0B
	Offset: 0xC58
	Size: 0x4A6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_5e02ffeb()
{
	classes.var_5e02ffeb[0] = spawnstruct();
	classes.var_5e02ffeb[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_5e02ffeb[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_5e02ffeb[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_5e02ffeb[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_5e02ffeb[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_5e02ffeb[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_5e02ffeb[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_5e02ffeb[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_5e02ffeb[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
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
	classes.var_5e02ffeb[0].__vtable[1516492343] = &namespace_5e02ffeb::close;
	classes.var_5e02ffeb[0].__vtable[250899321] = &namespace_5e02ffeb::open;
	classes.var_5e02ffeb[0].__vtable[1855416484] = &namespace_5e02ffeb::setup_clientfields;
	classes.var_5e02ffeb[0].__vtable[674154906] = &namespace_5e02ffeb::__constructor;
}

