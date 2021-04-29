// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace full_screen_movie;

/*
	Name: register
	Namespace: full_screen_movie
	Checksum: 0xAADD2040
	Offset: 0x108
	Size: 0x94
	Parameters: 8
	Flags: None
*/
function register(uid, var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, var_ea38d488)
{
	object = new var_7ca06143();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, var_ea38d488);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: full_screen_movie
	Checksum: 0x157238F4
	Offset: 0x1A8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_7ca06143();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: full_screen_movie
	Checksum: 0xD07721E2
	Offset: 0x1F0
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
	Namespace: full_screen_movie
	Checksum: 0xF10130FA
	Offset: 0x218
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
	Checksum: 0xD83C94E4
	Offset: 0x240
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_87bb24
	Namespace: full_screen_movie
	Checksum: 0x6F24A61C
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_87bb24(localclientnum, value)
{
	[[ self ]]->function_87bb24(localclientnum, value);
}

/*
	Name: function_8f7a8b9c
	Namespace: full_screen_movie
	Checksum: 0x40DFC805
	Offset: 0x298
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8f7a8b9c(localclientnum, value)
{
	[[ self ]]->function_8f7a8b9c(localclientnum, value);
}

/*
	Name: function_5caa21cb
	Namespace: full_screen_movie
	Checksum: 0x9E169BF8
	Offset: 0x2C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5caa21cb(localclientnum, value)
{
	[[ self ]]->function_5caa21cb(localclientnum, value);
}

/*
	Name: function_493305af
	Namespace: full_screen_movie
	Checksum: 0x4EB25CAA
	Offset: 0x2F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_493305af(localclientnum, value)
{
	[[ self ]]->function_493305af(localclientnum, value);
}

/*
	Name: function_3a81612d
	Namespace: full_screen_movie
	Checksum: 0xDB2B00FA
	Offset: 0x328
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3a81612d(localclientnum, value)
{
	[[ self ]]->function_3a81612d(localclientnum, value);
}

/*
	Name: function_5e22e9d6
	Namespace: full_screen_movie
	Checksum: 0x65D7B289
	Offset: 0x358
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5e22e9d6(localclientnum, value)
{
	[[ self ]]->function_5e22e9d6(localclientnum, value);
}

/*
	Name: function_251fc818
	Namespace: full_screen_movie
	Checksum: 0xE8B8249B
	Offset: 0x388
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_251fc818(localclientnum, value)
{
	[[ self ]]->function_251fc818(localclientnum, value);
}

#namespace namespace_7ca06143;

/*
	Name: __constructor
	Namespace: namespace_7ca06143
	Checksum: 0x8A3213F
	Offset: 0x3B8
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
	Checksum: 0xE1C5B283
	Offset: 0x3D8
	Size: 0x174
	Parameters: 8
	Flags: None
*/
function setup_clientfields(uid, var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, var_ea38d488)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_dcb34c80("moviefile", "movieName", 1);
	namespace_6aaccc24::function_da693cbe("showBlackScreen", 1, 1, "int", var_d5b04ae3);
	namespace_6aaccc24::function_da693cbe("looping", 1, 1, "int", var_e4decd0);
	namespace_6aaccc24::function_da693cbe("additive", 1, 1, "int", var_e545d4b9);
	namespace_6aaccc24::function_da693cbe("playOutroMovie", 1, 1, "int", var_78184b90);
	namespace_6aaccc24::function_da693cbe("skippable", 1, 1, "int", var_8ba396cb);
	namespace_6aaccc24::function_dcb34c80("moviefile", "movieKey", 18000);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_7ca06143
	Checksum: 0xB5DE22C
	Offset: 0x558
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
	Namespace: namespace_7ca06143
	Checksum: 0xAD0B02B2
	Offset: 0x588
	Size: 0x104
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "movieName", #"");
	[[ self ]]->function_d7d2fcce(localclientnum, "showBlackScreen", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "looping", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "additive", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "playOutroMovie", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "skippable", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "movieKey", #"");
}

/*
	Name: open
	Namespace: namespace_7ca06143
	Checksum: 0x884FFAAE
	Offset: 0x698
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"full_screen_movie");
}

/*
	Name: function_87bb24
	Namespace: namespace_7ca06143
	Checksum: 0xF88E0BB3
	Offset: 0x6D0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_87bb24(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "movieName", value);
}

/*
	Name: function_8f7a8b9c
	Namespace: namespace_7ca06143
	Checksum: 0x4AFB6C5B
	Offset: 0x708
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_8f7a8b9c(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "showBlackScreen", value);
}

/*
	Name: function_5caa21cb
	Namespace: namespace_7ca06143
	Checksum: 0xE7B811CB
	Offset: 0x740
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_5caa21cb(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "looping", value);
}

/*
	Name: function_493305af
	Namespace: namespace_7ca06143
	Checksum: 0xB255D71A
	Offset: 0x778
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_493305af(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "additive", value);
}

/*
	Name: function_3a81612d
	Namespace: namespace_7ca06143
	Checksum: 0x570D7D89
	Offset: 0x7B0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_3a81612d(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "playOutroMovie", value);
}

/*
	Name: function_5e22e9d6
	Namespace: namespace_7ca06143
	Checksum: 0xE353861D
	Offset: 0x7E8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_5e22e9d6(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "skippable", value);
}

/*
	Name: function_251fc818
	Namespace: namespace_7ca06143
	Checksum: 0x99DB496B
	Offset: 0x820
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_251fc818(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "movieKey", value);
}

/*
	Name: __destructor
	Namespace: namespace_7ca06143
	Checksum: 0xB1E92033
	Offset: 0x858
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
	Checksum: 0x24D6E12
	Offset: 0x878
	Size: 0x4D6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_7ca06143()
{
	classes.var_7ca06143[0] = spawnstruct();
	classes.var_7ca06143[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_7ca06143[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_7ca06143[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_7ca06143[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_7ca06143[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_7ca06143[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_7ca06143[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_7ca06143[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_7ca06143[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_7ca06143[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_7ca06143[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_7ca06143[0].__vtable[913321084] = &namespace_6aaccc24::__destructor;
	classes.var_7ca06143[0].__vtable[913321084] = &namespace_7ca06143::__destructor;
	classes.var_7ca06143[0].__vtable[622839832] = &namespace_7ca06143::function_251fc818;
	classes.var_7ca06143[0].__vtable[1579346390] = &namespace_7ca06143::function_5e22e9d6;
	classes.var_7ca06143[0].__vtable[981557549] = &namespace_7ca06143::function_3a81612d;
	classes.var_7ca06143[0].__vtable[1228080559] = &namespace_7ca06143::function_493305af;
	classes.var_7ca06143[0].__vtable[1554653643] = &namespace_7ca06143::function_5caa21cb;
	classes.var_7ca06143[0].__vtable[1887794276] = &namespace_7ca06143::function_8f7a8b9c;
	classes.var_7ca06143[0].__vtable[8895268] = &namespace_7ca06143::function_87bb24;
	classes.var_7ca06143[0].__vtable[250899321] = &namespace_7ca06143::open;
	classes.var_7ca06143[0].__vtable[94887662] = &namespace_7ca06143::function_fa582112;
	classes.var_7ca06143[0].__vtable[1545318712] = &namespace_7ca06143::function_5c1bb138;
	classes.var_7ca06143[0].__vtable[1855416484] = &namespace_7ca06143::setup_clientfields;
	classes.var_7ca06143[0].__vtable[674154906] = &namespace_7ca06143::__constructor;
}

