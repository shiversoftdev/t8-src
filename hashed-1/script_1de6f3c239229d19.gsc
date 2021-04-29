// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_game_timer;

/*
	Name: register
	Namespace: zm_game_timer
	Checksum: 0xC1AE6460
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_140ed462();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_game_timer
	Checksum: 0x1D9C3837
	Offset: 0x120
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
	Namespace: zm_game_timer
	Checksum: 0x4DF7D4EA
	Offset: 0x160
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
	Namespace: zm_game_timer
	Checksum: 0xFFA7BCDB
	Offset: 0x188
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_c48569e7
	Namespace: zm_game_timer
	Checksum: 0x680352E8
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_c48569e7(player, value)
{
	[[ self ]]->function_c48569e7(player, value);
}

/*
	Name: function_21eb67aa
	Namespace: zm_game_timer
	Checksum: 0x56D6FB4A
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_21eb67aa(player, value)
{
	[[ self ]]->function_21eb67aa(player, value);
}

/*
	Name: function_7954feaf
	Namespace: zm_game_timer
	Checksum: 0x3835487B
	Offset: 0x210
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7954feaf(player, value)
{
	[[ self ]]->function_7954feaf(player, value);
}

#namespace namespace_140ed462;

/*
	Name: __constructor
	Namespace: namespace_140ed462
	Checksum: 0x60B2E0D4
	Offset: 0x240
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
	Namespace: namespace_140ed462
	Checksum: 0x9A2525F1
	Offset: 0x260
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("seconds", 1, 6, "int");
	namespace_6aaccc24::function_da693cbe("minutes", 1, 9, "int");
	namespace_6aaccc24::function_da693cbe("showzero", 1, 1, "int");
}

/*
	Name: open
	Namespace: namespace_140ed462
	Checksum: 0xA0872563
	Offset: 0x308
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_game_timer", persistent);
}

/*
	Name: close
	Namespace: namespace_140ed462
	Checksum: 0xA0F6997F
	Offset: 0x358
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_c48569e7
	Namespace: namespace_140ed462
	Checksum: 0xDD0CC3A0
	Offset: 0x388
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_c48569e7(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "seconds", value);
}

/*
	Name: function_21eb67aa
	Namespace: namespace_140ed462
	Checksum: 0xF7CE0420
	Offset: 0x3D0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_21eb67aa(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "minutes", value);
}

/*
	Name: function_7954feaf
	Namespace: namespace_140ed462
	Checksum: 0xE0068F7C
	Offset: 0x418
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_7954feaf(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "showzero", value);
}

/*
	Name: __destructor
	Namespace: namespace_140ed462
	Checksum: 0x27A8A3E0
	Offset: 0x460
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_game_timer;

/*
	Name: function_140ed462
	Namespace: zm_game_timer
	Checksum: 0x8A383443
	Offset: 0x480
	Size: 0x356
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_140ed462()
{
	classes.var_140ed462[0] = spawnstruct();
	classes.var_140ed462[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_140ed462[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_140ed462[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_140ed462[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_140ed462[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_140ed462[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_140ed462[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_140ed462[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_140ed462[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_140ed462[0].__vtable[913321084] = &namespace_140ed462::__destructor;
	classes.var_140ed462[0].__vtable[2035613359] = &namespace_140ed462::function_7954feaf;
	classes.var_140ed462[0].__vtable[569075626] = &namespace_140ed462::function_21eb67aa;
	classes.var_140ed462[0].__vtable[997889561] = &namespace_140ed462::function_c48569e7;
	classes.var_140ed462[0].__vtable[1516492343] = &namespace_140ed462::close;
	classes.var_140ed462[0].__vtable[250899321] = &namespace_140ed462::open;
	classes.var_140ed462[0].__vtable[1855416484] = &namespace_140ed462::setup_clientfields;
	classes.var_140ed462[0].__vtable[674154906] = &namespace_140ed462::__constructor;
}

