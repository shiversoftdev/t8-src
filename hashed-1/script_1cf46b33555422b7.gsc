// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace luielemtext;

/*
	Name: set_color
	Namespace: luielemtext
	Checksum: 0xEDAC895
	Offset: 0x128
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
	Namespace: luielemtext
	Checksum: 0x96C0E923
	Offset: 0x1A0
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
	Namespace: luielemtext
	Checksum: 0x46633C7B
	Offset: 0x228
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
	Namespace: luielemtext
	Checksum: 0x86D6E7C
	Offset: 0x278
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
	Namespace: luielemtext
	Checksum: 0x3E49ABE2
	Offset: 0x2C0
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
	Namespace: luielemtext
	Checksum: 0x23F2A554
	Offset: 0x318
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
	Namespace: luielemtext
	Checksum: 0xC7766D26
	Offset: 0x370
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
	Name: register
	Namespace: luielemtext
	Checksum: 0x6A06ACB2
	Offset: 0x3C8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_e6e7895b();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielemtext
	Checksum: 0xC0F66C4A
	Offset: 0x410
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
	Namespace: luielemtext
	Checksum: 0x32CCE914
	Offset: 0x450
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
	Namespace: luielemtext
	Checksum: 0xF6874ACB
	Offset: 0x478
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
	Namespace: luielemtext
	Checksum: 0x2DC1344F
	Offset: 0x4A0
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
	Namespace: luielemtext
	Checksum: 0x58E62611
	Offset: 0x4D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_y(player, value)
{
	[[ self ]]->set_y(player, value);
}

/*
	Name: function_5dbd7024
	Namespace: luielemtext
	Checksum: 0x83DE11DE
	Offset: 0x500
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
	Namespace: luielemtext
	Checksum: 0x4F302CBD
	Offset: 0x530
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
	Namespace: luielemtext
	Checksum: 0x37EA2FA8
	Offset: 0x560
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
	Namespace: luielemtext
	Checksum: 0x68F834FB
	Offset: 0x590
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
	Namespace: luielemtext
	Checksum: 0x6C9486A5
	Offset: 0x5C0
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
	Namespace: luielemtext
	Checksum: 0x36E08A6D
	Offset: 0x5F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7420df0a(player, value)
{
	[[ self ]]->function_7420df0a(player, value);
}

/*
	Name: function_d5ea17f0
	Namespace: luielemtext
	Checksum: 0x63BD16F8
	Offset: 0x620
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(player, value)
{
	[[ self ]]->function_d5ea17f0(player, value);
}

/*
	Name: function_1bd2bb26
	Namespace: luielemtext
	Checksum: 0xA898BDB4
	Offset: 0x650
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_1bd2bb26(player, value)
{
	[[ self ]]->function_1bd2bb26(player, value);
}

#namespace namespace_e6e7895b;

/*
	Name: __constructor
	Namespace: namespace_e6e7895b
	Checksum: 0xA4348636
	Offset: 0x680
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
	Namespace: namespace_e6e7895b
	Checksum: 0xF758A3A7
	Offset: 0x6A0
	Size: 0x1B4
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("x", 1, 7, "int");
	namespace_6aaccc24::function_da693cbe("y", 1, 6, "int");
	namespace_6aaccc24::function_da693cbe("height", 1, 2, "int");
	namespace_6aaccc24::function_da693cbe("fadeOverTime", 1, 5, "int");
	namespace_6aaccc24::function_da693cbe("alpha", 1, 4, "float");
	namespace_6aaccc24::function_da693cbe("red", 1, 4, "float");
	namespace_6aaccc24::function_da693cbe("green", 1, 4, "float");
	namespace_6aaccc24::function_da693cbe("blue", 1, 4, "float");
	namespace_6aaccc24::function_dcb34c80("string", "text", 1);
	namespace_6aaccc24::function_da693cbe("horizontal_alignment", 1, 2, "int");
}

/*
	Name: open
	Namespace: namespace_e6e7895b
	Checksum: 0x4754AAD2
	Offset: 0x860
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "LUIelemText", persistent);
}

/*
	Name: close
	Namespace: namespace_e6e7895b
	Checksum: 0x8CFD21CC
	Offset: 0x8B0
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
	Namespace: namespace_e6e7895b
	Checksum: 0xADB407BC
	Offset: 0x8E0
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
	Namespace: namespace_e6e7895b
	Checksum: 0x1A55E49E
	Offset: 0x928
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function set_y(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "y", value);
}

/*
	Name: function_5dbd7024
	Namespace: namespace_e6e7895b
	Checksum: 0x88D3B37A
	Offset: 0x970
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
	Namespace: namespace_e6e7895b
	Checksum: 0x306B53CC
	Offset: 0x9B8
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
	Namespace: namespace_e6e7895b
	Checksum: 0xA694FD16
	Offset: 0xA00
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
	Namespace: namespace_e6e7895b
	Checksum: 0xC851CA97
	Offset: 0xA48
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
	Namespace: namespace_e6e7895b
	Checksum: 0xB2EC60A3
	Offset: 0xA90
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
	Namespace: namespace_e6e7895b
	Checksum: 0x1F70E891
	Offset: 0xAD8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_7420df0a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "blue", value);
}

/*
	Name: function_d5ea17f0
	Namespace: namespace_e6e7895b
	Checksum: 0xF3351EC2
	Offset: 0xB20
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "text", value);
}

/*
	Name: function_1bd2bb26
	Namespace: namespace_e6e7895b
	Checksum: 0x86AD5162
	Offset: 0xB68
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_1bd2bb26(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "horizontal_alignment", value);
}

/*
	Name: __destructor
	Namespace: namespace_e6e7895b
	Checksum: 0x85FB5DC6
	Offset: 0xBB0
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace luielemtext;

/*
	Name: function_e6e7895b
	Namespace: luielemtext
	Checksum: 0xD429E1CA
	Offset: 0xBD0
	Size: 0x4D6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_e6e7895b()
{
	classes.var_e6e7895b[0] = spawnstruct();
	classes.var_e6e7895b[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_e6e7895b[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_e6e7895b[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_e6e7895b[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_e6e7895b[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_e6e7895b[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_e6e7895b[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_e6e7895b[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_e6e7895b[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_e6e7895b[0].__vtable[913321084] = &namespace_6aaccc24::__destructor;
	classes.var_e6e7895b[0].__vtable[913321084] = &namespace_e6e7895b::__destructor;
	classes.var_e6e7895b[0].__vtable[466795302] = &namespace_e6e7895b::function_1bd2bb26;
	classes.var_e6e7895b[0].__vtable[706078736] = &namespace_e6e7895b::function_d5ea17f0;
	classes.var_e6e7895b[0].__vtable[1948311306] = &namespace_e6e7895b::function_7420df0a;
	classes.var_e6e7895b[0].__vtable[570996955] = &namespace_e6e7895b::function_2208b8db;
	classes.var_e6e7895b[0].__vtable[322169571] = &namespace_e6e7895b::function_eccc151d;
	classes.var_e6e7895b[0].__vtable[1436782307] = &namespace_e6e7895b::function_aa5c711d;
	classes.var_e6e7895b[0].__vtable[595588147] = &namespace_e6e7895b::function_237ff433;
	classes.var_e6e7895b[0].__vtable[1572696100] = &namespace_e6e7895b::function_5dbd7024;
	classes.var_e6e7895b[0].__vtable[1687309110] = &namespace_e6e7895b::set_y;
	classes.var_e6e7895b[0].__vtable[765680993] = &namespace_e6e7895b::set_x;
	classes.var_e6e7895b[0].__vtable[1516492343] = &namespace_e6e7895b::close;
	classes.var_e6e7895b[0].__vtable[250899321] = &namespace_e6e7895b::open;
	classes.var_e6e7895b[0].__vtable[1855416484] = &namespace_e6e7895b::setup_clientfields;
	classes.var_e6e7895b[0].__vtable[674154906] = &namespace_e6e7895b::__constructor;
}

