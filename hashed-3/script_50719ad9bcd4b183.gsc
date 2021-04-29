// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace full_screen_black;

/*
	Name: register
	Namespace: full_screen_black
	Checksum: 0xF1263C65
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_14224618();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: full_screen_black
	Checksum: 0x9AD0A281
	Offset: 0x158
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
	Namespace: full_screen_black
	Checksum: 0xB1EFB1CE
	Offset: 0x198
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
	Namespace: full_screen_black
	Checksum: 0x6426584C
	Offset: 0x1C0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_eccc151d
	Namespace: full_screen_black
	Checksum: 0xC79397A5
	Offset: 0x1E8
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
	Namespace: full_screen_black
	Checksum: 0x325F92C7
	Offset: 0x218
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
	Namespace: full_screen_black
	Checksum: 0x766C5795
	Offset: 0x248
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7420df0a(player, value)
{
	[[ self ]]->function_7420df0a(player, value);
}

/*
	Name: function_237ff433
	Namespace: full_screen_black
	Checksum: 0xA409C164
	Offset: 0x278
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_237ff433(player, value)
{
	[[ self ]]->function_237ff433(player, value);
}

/*
	Name: function_9cd54463
	Namespace: full_screen_black
	Checksum: 0xBB08F74A
	Offset: 0x2A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_9cd54463(player, value)
{
	[[ self ]]->function_9cd54463(player, value);
}

/*
	Name: function_331f9dd
	Namespace: full_screen_black
	Checksum: 0x9AA7315
	Offset: 0x2D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_331f9dd(player, value)
{
	[[ self ]]->function_331f9dd(player, value);
}

/*
	Name: function_ae1277a0
	Namespace: full_screen_black
	Checksum: 0x99782CD0
	Offset: 0x308
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_ae1277a0(player, value)
{
	[[ self ]]->function_ae1277a0(player, value);
}

#namespace namespace_14224618;

/*
	Name: __constructor
	Namespace: namespace_14224618
	Checksum: 0x54B57BC7
	Offset: 0x338
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
	Namespace: namespace_14224618
	Checksum: 0xB966D78B
	Offset: 0x358
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("red", 1, 3, "float");
	namespace_6aaccc24::function_da693cbe("green", 1, 3, "float");
	namespace_6aaccc24::function_da693cbe("blue", 1, 3, "float");
	namespace_6aaccc24::function_da693cbe("fadeOverTime", 1, 12, "int");
	namespace_6aaccc24::function_da693cbe("startAlpha", 1, 5, "float");
	namespace_6aaccc24::function_da693cbe("endAlpha", 1, 5, "float");
	namespace_6aaccc24::function_da693cbe("drawHUD", 1, 1, "int");
}

/*
	Name: open
	Namespace: namespace_14224618
	Checksum: 0x7430C660
	Offset: 0x4A0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "full_screen_black", persistent);
}

/*
	Name: close
	Namespace: namespace_14224618
	Checksum: 0xE999F1F1
	Offset: 0x4F0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_eccc151d
	Namespace: namespace_14224618
	Checksum: 0xC1C03DA9
	Offset: 0x520
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_eccc151d(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "red", value);
}

/*
	Name: function_2208b8db
	Namespace: namespace_14224618
	Checksum: 0x3EA3E646
	Offset: 0x568
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_2208b8db(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "green", value);
}

/*
	Name: function_7420df0a
	Namespace: namespace_14224618
	Checksum: 0xB645405C
	Offset: 0x5B0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_7420df0a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "blue", value);
}

/*
	Name: function_237ff433
	Namespace: namespace_14224618
	Checksum: 0x48606386
	Offset: 0x5F8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_237ff433(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "fadeOverTime", value);
}

/*
	Name: function_9cd54463
	Namespace: namespace_14224618
	Checksum: 0x9E5EFDDD
	Offset: 0x640
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_9cd54463(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "startAlpha", value);
}

/*
	Name: function_331f9dd
	Namespace: namespace_14224618
	Checksum: 0x811F9F36
	Offset: 0x688
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_331f9dd(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "endAlpha", value);
}

/*
	Name: function_ae1277a0
	Namespace: namespace_14224618
	Checksum: 0x5BA0AB8B
	Offset: 0x6D0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_ae1277a0(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "drawHUD", value);
}

/*
	Name: __destructor
	Namespace: namespace_14224618
	Checksum: 0xD6F5972
	Offset: 0x718
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace full_screen_black;

/*
	Name: function_14224618
	Namespace: full_screen_black
	Checksum: 0xC6D463F5
	Offset: 0x738
	Size: 0x416
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_14224618()
{
	classes.var_14224618[0] = spawnstruct();
	classes.var_14224618[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_14224618[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_14224618[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_14224618[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_14224618[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_14224618[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_14224618[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_14224618[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_14224618[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_14224618[0].__vtable[913321084] = &namespace_14224618::__destructor;
	classes.var_14224618[0].__vtable[1374521440] = &namespace_14224618::function_ae1277a0;
	classes.var_14224618[0].__vtable[53606877] = &namespace_14224618::function_331f9dd;
	classes.var_14224618[0].__vtable[1663744925] = &namespace_14224618::function_9cd54463;
	classes.var_14224618[0].__vtable[595588147] = &namespace_14224618::function_237ff433;
	classes.var_14224618[0].__vtable[1948311306] = &namespace_14224618::function_7420df0a;
	classes.var_14224618[0].__vtable[570996955] = &namespace_14224618::function_2208b8db;
	classes.var_14224618[0].__vtable[322169571] = &namespace_14224618::function_eccc151d;
	classes.var_14224618[0].__vtable[1516492343] = &namespace_14224618::close;
	classes.var_14224618[0].__vtable[250899321] = &namespace_14224618::open;
	classes.var_14224618[0].__vtable[1855416484] = &namespace_14224618::setup_clientfields;
	classes.var_14224618[0].__vtable[674154906] = &namespace_14224618::__constructor;
}

