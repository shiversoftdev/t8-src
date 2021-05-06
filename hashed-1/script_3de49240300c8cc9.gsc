// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace wz_revive_prompt;

/*
	Name: register
	Namespace: wz_revive_prompt
	Checksum: 0xC2C72F5F
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_1b0cb7b1();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: wz_revive_prompt
	Checksum: 0x3C528D6F
	Offset: 0x140
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
	Namespace: wz_revive_prompt
	Checksum: 0x85BBACF6
	Offset: 0x180
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
	Checksum: 0xAF235EE0
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_3b7b386a
	Namespace: wz_revive_prompt
	Checksum: 0x24199459
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3b7b386a(player, value)
{
	[[ self ]]->function_3b7b386a(player, value);
}

/*
	Name: set_health
	Namespace: wz_revive_prompt
	Checksum: 0x545C2C21
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_health(player, value)
{
	[[ self ]]->set_health(player, value);
}

/*
	Name: function_4b3fb8b8
	Namespace: wz_revive_prompt
	Checksum: 0x4F8599FE
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4b3fb8b8(player, value)
{
	[[ self ]]->function_4b3fb8b8(player, value);
}

/*
	Name: function_f52e0186
	Namespace: wz_revive_prompt
	Checksum: 0x202A5ECE
	Offset: 0x260
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_f52e0186(player, value)
{
	[[ self ]]->function_f52e0186(player, value);
}

#namespace namespace_1b0cb7b1;

/*
	Name: __constructor
	Namespace: namespace_1b0cb7b1
	Checksum: 0xDA39AC7E
	Offset: 0x290
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
	Checksum: 0xE01E272
	Offset: 0x2B0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("clientnum", 1, 7, "int");
	namespace_6aaccc24::function_da693cbe("health", 1, 5, "float");
	namespace_6aaccc24::function_da693cbe("reviveProgress", 1, 5, "float");
	namespace_6aaccc24::function_da693cbe("cowardsWay", 17000, 1, "int");
}

/*
	Name: open
	Namespace: namespace_1b0cb7b1
	Checksum: 0xA46F2A8
	Offset: 0x380
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "wz_revive_prompt", persistent);
}

/*
	Name: close
	Namespace: namespace_1b0cb7b1
	Checksum: 0x3AB05EA6
	Offset: 0x3D0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_3b7b386a
	Namespace: namespace_1b0cb7b1
	Checksum: 0xBCA400CC
	Offset: 0x400
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_3b7b386a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "clientnum", value);
}

/*
	Name: set_health
	Namespace: namespace_1b0cb7b1
	Checksum: 0xBFC54322
	Offset: 0x448
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function set_health(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "health", value);
}

/*
	Name: function_4b3fb8b8
	Namespace: namespace_1b0cb7b1
	Checksum: 0x2CF071A9
	Offset: 0x490
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_4b3fb8b8(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "reviveProgress", value);
}

/*
	Name: function_f52e0186
	Namespace: namespace_1b0cb7b1
	Checksum: 0x4E3F5DD1
	Offset: 0x4D8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_f52e0186(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "cowardsWay", value);
}

/*
	Name: __destructor
	Namespace: namespace_1b0cb7b1
	Checksum: 0xC4091EA4
	Offset: 0x520
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
	Checksum: 0x1DFDBF29
	Offset: 0x540
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_1b0cb7b1()
{
	classes.var_1b0cb7b1[0] = spawnstruct();
	classes.var_1b0cb7b1[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_1b0cb7b1[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_1b0cb7b1[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_1b0cb7b1[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_1b0cb7b1[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_1b0cb7b1[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_1b0cb7b1[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_1b0cb7b1[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_1b0cb7b1[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_1b0cb7b1[0].__vtable[913321084] = &namespace_1b0cb7b1::__destructor;
	classes.var_1b0cb7b1[0].__vtable[181534330] = &namespace_1b0cb7b1::function_f52e0186;
	classes.var_1b0cb7b1[0].__vtable[1262467256] = &namespace_1b0cb7b1::function_4b3fb8b8;
	classes.var_1b0cb7b1[0].__vtable[181372725] = &namespace_1b0cb7b1::set_health;
	classes.var_1b0cb7b1[0].__vtable[997931114] = &namespace_1b0cb7b1::function_3b7b386a;
	classes.var_1b0cb7b1[0].__vtable[1516492343] = &namespace_1b0cb7b1::close;
	classes.var_1b0cb7b1[0].__vtable[250899321] = &namespace_1b0cb7b1::open;
	classes.var_1b0cb7b1[0].__vtable[1855416484] = &namespace_1b0cb7b1::setup_clientfields;
	classes.var_1b0cb7b1[0].__vtable[674154906] = &namespace_1b0cb7b1::__constructor;
}

