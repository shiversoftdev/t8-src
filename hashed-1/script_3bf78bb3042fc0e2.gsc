// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace self_respawn;

/*
	Name: register
	Namespace: self_respawn
	Checksum: 0x50E1B8B
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_28a7d65d();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_respawn
	Checksum: 0x4657DD92
	Offset: 0x110
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
	Namespace: self_respawn
	Checksum: 0x7B4B45B9
	Offset: 0x150
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
	Namespace: self_respawn
	Checksum: 0x4EAD0D56
	Offset: 0x178
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_459465a
	Namespace: self_respawn
	Checksum: 0x592A5FBC
	Offset: 0x1A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_459465a(player, value)
{
	[[ self ]]->function_459465a(player, value);
}

#namespace namespace_28a7d65d;

/*
	Name: __constructor
	Namespace: namespace_28a7d65d
	Checksum: 0x4F5C71E1
	Offset: 0x1D0
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
	Namespace: namespace_28a7d65d
	Checksum: 0x144FE2DF
	Offset: 0x1F0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("percent", 4000, 6, "float");
}

/*
	Name: open
	Namespace: namespace_28a7d65d
	Checksum: 0x65556246
	Offset: 0x248
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "self_respawn", persistent);
}

/*
	Name: close
	Namespace: namespace_28a7d65d
	Checksum: 0x53B71BE3
	Offset: 0x298
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_459465a
	Namespace: namespace_28a7d65d
	Checksum: 0xC0D82E
	Offset: 0x2C8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_459465a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "percent", value);
}

/*
	Name: __destructor
	Namespace: namespace_28a7d65d
	Checksum: 0x961D0714
	Offset: 0x310
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace self_respawn;

/*
	Name: function_28a7d65d
	Namespace: self_respawn
	Checksum: 0x8E79BC22
	Offset: 0x330
	Size: 0x2F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_28a7d65d()
{
	classes.var_28a7d65d[0] = spawnstruct();
	classes.var_28a7d65d[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_28a7d65d[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_28a7d65d[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_28a7d65d[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_28a7d65d[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_28a7d65d[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_28a7d65d[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_28a7d65d[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_28a7d65d[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_28a7d65d[0].__vtable[913321084] = &namespace_28a7d65d::__destructor;
	classes.var_28a7d65d[0].__vtable[72959578] = &namespace_28a7d65d::function_459465a;
	classes.var_28a7d65d[0].__vtable[1516492343] = &namespace_28a7d65d::close;
	classes.var_28a7d65d[0].__vtable[250899321] = &namespace_28a7d65d::open;
	classes.var_28a7d65d[0].__vtable[1855416484] = &namespace_28a7d65d::setup_clientfields;
	classes.var_28a7d65d[0].__vtable[674154906] = &namespace_28a7d65d::__constructor;
}

