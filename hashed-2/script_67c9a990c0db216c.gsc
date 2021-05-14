// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace full_screen_movie;

/*
	Name: register
	Namespace: full_screen_movie
	Checksum: 0xF79C536E
	Offset: 0x128
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_7ca06143();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: full_screen_movie
	Checksum: 0xF6470B0
	Offset: 0x170
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
	Namespace: full_screen_movie
	Checksum: 0xCC4A7A58
	Offset: 0x1B0
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
	Namespace: full_screen_movie
	Checksum: 0xF82433D4
	Offset: 0x1D8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_87bb24
	Namespace: full_screen_movie
	Checksum: 0x774E6E2F
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_87bb24(player, value)
{
	[[ self ]]->function_87bb24(player, value);
}

/*
	Name: function_8f7a8b9c
	Namespace: full_screen_movie
	Checksum: 0xE85542FE
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8f7a8b9c(player, value)
{
	[[ self ]]->function_8f7a8b9c(player, value);
}

/*
	Name: function_5caa21cb
	Namespace: full_screen_movie
	Checksum: 0x1316043C
	Offset: 0x260
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5caa21cb(player, value)
{
	[[ self ]]->function_5caa21cb(player, value);
}

/*
	Name: function_493305af
	Namespace: full_screen_movie
	Checksum: 0xC7C6ED35
	Offset: 0x290
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_493305af(player, value)
{
	[[ self ]]->function_493305af(player, value);
}

/*
	Name: function_3a81612d
	Namespace: full_screen_movie
	Checksum: 0x81478F11
	Offset: 0x2C0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3a81612d(player, value)
{
	[[ self ]]->function_3a81612d(player, value);
}

/*
	Name: registerplayer_callout_traversal
	Namespace: full_screen_movie
	Checksum: 0x635BAFCA
	Offset: 0x2F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function registerplayer_callout_traversal(player, value)
{
	[[ self ]]->registerplayer_callout_traversal(player, value);
}

/*
	Name: function_251fc818
	Namespace: full_screen_movie
	Checksum: 0x54C0C316
	Offset: 0x320
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_251fc818(player, value)
{
	[[ self ]]->function_251fc818(player, value);
}

#namespace namespace_7ca06143;

/*
	Name: __constructor
	Namespace: namespace_7ca06143
	Checksum: 0x73D15B1D
	Offset: 0x350
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
	Namespace: namespace_7ca06143
	Checksum: 0x5553D56B
	Offset: 0x370
	Size: 0x13C
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_dcb34c80("moviefile", "movieName", 1);
	namespace_6aaccc24::function_da693cbe("showBlackScreen", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("looping", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("additive", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("playOutroMovie", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("skippable", 1, 1, "int");
	namespace_6aaccc24::function_dcb34c80("moviefile", "movieKey", 18000);
}

/*
	Name: open
	Namespace: namespace_7ca06143
	Checksum: 0x704C253B
	Offset: 0x4B8
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "full_screen_movie", persistent);
}

/*
	Name: close
	Namespace: namespace_7ca06143
	Checksum: 0x394FFD5
	Offset: 0x508
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_87bb24
	Namespace: namespace_7ca06143
	Checksum: 0x4ECED0FB
	Offset: 0x538
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_87bb24(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "movieName", value);
}

/*
	Name: function_8f7a8b9c
	Namespace: namespace_7ca06143
	Checksum: 0x3FE28C1B
	Offset: 0x580
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_8f7a8b9c(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "showBlackScreen", value);
}

/*
	Name: function_5caa21cb
	Namespace: namespace_7ca06143
	Checksum: 0xADA264E
	Offset: 0x5C8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_5caa21cb(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "looping", value);
}

/*
	Name: function_493305af
	Namespace: namespace_7ca06143
	Checksum: 0x94BDF6E6
	Offset: 0x610
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_493305af(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "additive", value);
}

/*
	Name: function_3a81612d
	Namespace: namespace_7ca06143
	Checksum: 0x8F3613A0
	Offset: 0x658
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_3a81612d(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "playOutroMovie", value);
}

/*
	Name: registerplayer_callout_traversal
	Namespace: namespace_7ca06143
	Checksum: 0x4988A482
	Offset: 0x6A0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function registerplayer_callout_traversal(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "skippable", value);
}

/*
	Name: function_251fc818
	Namespace: namespace_7ca06143
	Checksum: 0xDC36EB36
	Offset: 0x6E8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_251fc818(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "movieKey", value);
}

/*
	Name: __destructor
	Namespace: namespace_7ca06143
	Checksum: 0xAF8CBDE3
	Offset: 0x730
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace full_screen_movie;

/*
	Name: function_7ca06143
	Namespace: full_screen_movie
	Checksum: 0x7405498D
	Offset: 0x750
	Size: 0x446
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_7ca06143()
{
	classes.var_7ca06143[0] = spawnstruct();
	classes.var_7ca06143[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_7ca06143[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_7ca06143[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_7ca06143[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_7ca06143[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_7ca06143[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_7ca06143[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_7ca06143[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_7ca06143[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_7ca06143[0].__vtable[913321084] = &namespace_6aaccc24::__destructor;
	classes.var_7ca06143[0].__vtable[913321084] = &namespace_7ca06143::__destructor;
	classes.var_7ca06143[0].__vtable[622839832] = &namespace_7ca06143::function_251fc818;
	classes.var_7ca06143[0].__vtable[1579346390] = &namespace_7ca06143::registerplayer_callout_traversal;
	classes.var_7ca06143[0].__vtable[981557549] = &namespace_7ca06143::function_3a81612d;
	classes.var_7ca06143[0].__vtable[1228080559] = &namespace_7ca06143::function_493305af;
	classes.var_7ca06143[0].__vtable[1554653643] = &namespace_7ca06143::function_5caa21cb;
	classes.var_7ca06143[0].__vtable[1887794276] = &namespace_7ca06143::function_8f7a8b9c;
	classes.var_7ca06143[0].__vtable[8895268] = &namespace_7ca06143::function_87bb24;
	classes.var_7ca06143[0].__vtable[1516492343] = &namespace_7ca06143::close;
	classes.var_7ca06143[0].__vtable[250899321] = &namespace_7ca06143::open;
	classes.var_7ca06143[0].__vtable[1855416484] = &namespace_7ca06143::setup_clientfields;
	classes.var_7ca06143[0].__vtable[674154906] = &namespace_7ca06143::__constructor;
}

