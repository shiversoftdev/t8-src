// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace wz_revive_prompt;

/*
	Name: register
	Namespace: wz_revive_prompt
	Checksum: 0xB4A67D89
	Offset: 0xE0
	Size: 0x7C
	Parameters: 6
	Flags: Linked
*/
function register(uid, var_c05c67e2, var_663a86fa, var_d65e5a18, var_f228b5fa, var_7cb8f98a)
{
	object = new var_1b0cb7b1();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_c05c67e2, var_663a86fa, var_d65e5a18, var_f228b5fa, var_7cb8f98a);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: wz_revive_prompt
	Checksum: 0xFAD9FC1C
	Offset: 0x168
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_1b0cb7b1();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: wz_revive_prompt
	Checksum: 0x44E9A4FE
	Offset: 0x1B0
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
	Namespace: wz_revive_prompt
	Checksum: 0xB00C27CA
	Offset: 0x1D8
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
	Namespace: wz_revive_prompt
	Checksum: 0x1A470293
	Offset: 0x200
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_3b7b386a
	Namespace: wz_revive_prompt
	Checksum: 0xCF89D320
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3b7b386a(localclientnum, value)
{
	[[ self ]]->function_3b7b386a(localclientnum, value);
}

/*
	Name: set_health
	Namespace: wz_revive_prompt
	Checksum: 0x65F94891
	Offset: 0x258
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_health(localclientnum, value)
{
	[[ self ]]->set_health(localclientnum, value);
}

/*
	Name: function_4b3fb8b8
	Namespace: wz_revive_prompt
	Checksum: 0xB89F71B7
	Offset: 0x288
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4b3fb8b8(localclientnum, value)
{
	[[ self ]]->function_4b3fb8b8(localclientnum, value);
}

/*
	Name: function_f52e0186
	Namespace: wz_revive_prompt
	Checksum: 0x42056BD3
	Offset: 0x2B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_f52e0186(localclientnum, value)
{
	[[ self ]]->function_f52e0186(localclientnum, value);
}

#namespace namespace_1b0cb7b1;

/*
	Name: __constructor
	Namespace: namespace_1b0cb7b1
	Checksum: 0x8A489B4A
	Offset: 0x2E8
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
	Namespace: namespace_1b0cb7b1
	Checksum: 0x6CAC4AF6
	Offset: 0x308
	Size: 0xEC
	Parameters: 6
	Flags: Linked
*/
function setup_clientfields(uid, var_c05c67e2, var_663a86fa, var_d65e5a18, var_f228b5fa, var_7cb8f98a)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("clientnum", 1, 7, "int", var_c05c67e2);
	namespace_6aaccc24::function_da693cbe("health", 1, 5, "float", var_663a86fa);
	namespace_6aaccc24::function_da693cbe("reviveProgress", 1, 5, "float", var_d65e5a18);
	namespace_6aaccc24::function_da693cbe("cowardsWay", 17000, 1, "int", var_7cb8f98a);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_1b0cb7b1
	Checksum: 0x96DCC47A
	Offset: 0x400
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
	Namespace: namespace_1b0cb7b1
	Checksum: 0x54E50C91
	Offset: 0x430
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "clientnum", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "health", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "reviveProgress", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "cowardsWay", 0);
}

/*
	Name: open
	Namespace: namespace_1b0cb7b1
	Checksum: 0x34C71D1B
	Offset: 0x4E0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"wz_revive_prompt");
}

/*
	Name: function_3b7b386a
	Namespace: namespace_1b0cb7b1
	Checksum: 0x1F3CA30B
	Offset: 0x518
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_3b7b386a(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "clientnum", value);
}

/*
	Name: set_health
	Namespace: namespace_1b0cb7b1
	Checksum: 0x9481CD05
	Offset: 0x550
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function set_health(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "health", value);
}

/*
	Name: function_4b3fb8b8
	Namespace: namespace_1b0cb7b1
	Checksum: 0xAEE2342
	Offset: 0x588
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_4b3fb8b8(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "reviveProgress", value);
}

/*
	Name: function_f52e0186
	Namespace: namespace_1b0cb7b1
	Checksum: 0xB7CF891F
	Offset: 0x5C0
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_f52e0186(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "cowardsWay", value);
}

/*
	Name: __destructor
	Namespace: namespace_1b0cb7b1
	Checksum: 0xF5CE1E96
	Offset: 0x5F8
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace wz_revive_prompt;

/*
	Name: function_1b0cb7b1
	Namespace: wz_revive_prompt
	Checksum: 0xC520691A
	Offset: 0x618
	Size: 0x416
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_1b0cb7b1()
{
	classes.var_1b0cb7b1[0] = spawnstruct();
	classes.var_1b0cb7b1[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_1b0cb7b1[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_1b0cb7b1[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_1b0cb7b1[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_1b0cb7b1[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_1b0cb7b1[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_1b0cb7b1[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_1b0cb7b1[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_1b0cb7b1[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_1b0cb7b1[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_1b0cb7b1[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_1b0cb7b1[0].__vtable[913321084] = &namespace_1b0cb7b1::__destructor;
	classes.var_1b0cb7b1[0].__vtable[181534330] = &namespace_1b0cb7b1::function_f52e0186;
	classes.var_1b0cb7b1[0].__vtable[1262467256] = &namespace_1b0cb7b1::function_4b3fb8b8;
	classes.var_1b0cb7b1[0].__vtable[181372725] = &namespace_1b0cb7b1::set_health;
	classes.var_1b0cb7b1[0].__vtable[997931114] = &namespace_1b0cb7b1::function_3b7b386a;
	classes.var_1b0cb7b1[0].__vtable[250899321] = &namespace_1b0cb7b1::open;
	classes.var_1b0cb7b1[0].__vtable[94887662] = &namespace_1b0cb7b1::function_fa582112;
	classes.var_1b0cb7b1[0].__vtable[1545318712] = &namespace_1b0cb7b1::function_5c1bb138;
	classes.var_1b0cb7b1[0].__vtable[1855416484] = &namespace_1b0cb7b1::setup_clientfields;
	classes.var_1b0cb7b1[0].__vtable[674154906] = &namespace_1b0cb7b1::__constructor;
}

