// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace remote_missile_targets;

/*
	Name: register
	Namespace: remote_missile_targets
	Checksum: 0xCE1CE325
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_5c5263e2();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: remote_missile_targets
	Checksum: 0x82907F9F
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
	Namespace: remote_missile_targets
	Checksum: 0xA7626CCF
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
	Namespace: remote_missile_targets
	Checksum: 0x8E8927FC
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
	Name: function_46609401
	Namespace: remote_missile_targets
	Checksum: 0xC7155B29
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_46609401(player, value)
{
	[[ self ]]->function_46609401(player, value);
}

/*
	Name: function_d798388d
	Namespace: remote_missile_targets
	Checksum: 0xC14752F3
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d798388d(player, value)
{
	[[ self ]]->function_d798388d(player, value);
}

/*
	Name: function_808f0a7c
	Namespace: remote_missile_targets
	Checksum: 0xD1101E04
	Offset: 0x248
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_808f0a7c(player, value)
{
	[[ self ]]->function_808f0a7c(player, value);
}

/*
	Name: function_ec1de198
	Namespace: remote_missile_targets
	Checksum: 0xF84D24EF
	Offset: 0x278
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_ec1de198(player, value)
{
	[[ self ]]->function_ec1de198(player, value);
}

#namespace namespace_5c5263e2;

/*
	Name: __constructor
	Namespace: namespace_5c5263e2
	Checksum: 0x1633B622
	Offset: 0x2A8
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
	Namespace: namespace_5c5263e2
	Checksum: 0xC9E20CEF
	Offset: 0x2C8
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("player_target_active", 1, 16, "int");
	namespace_6aaccc24::function_da693cbe("extra_target_1", 1, 10, "int");
	namespace_6aaccc24::function_da693cbe("extra_target_2", 1, 10, "int");
	namespace_6aaccc24::function_da693cbe("extra_target_3", 1, 10, "int");
}

/*
	Name: open
	Namespace: namespace_5c5263e2
	Checksum: 0x215A9935
	Offset: 0x398
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "remote_missile_targets", persistent);
}

/*
	Name: close
	Namespace: namespace_5c5263e2
	Checksum: 0x23B90DB4
	Offset: 0x3E8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_46609401
	Namespace: namespace_5c5263e2
	Checksum: 0x1D30A022
	Offset: 0x418
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_46609401(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "player_target_active", value);
}

/*
	Name: function_d798388d
	Namespace: namespace_5c5263e2
	Checksum: 0x82AA601F
	Offset: 0x460
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_d798388d(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "extra_target_1", value);
}

/*
	Name: function_808f0a7c
	Namespace: namespace_5c5263e2
	Checksum: 0x7E009F12
	Offset: 0x4A8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_808f0a7c(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "extra_target_2", value);
}

/*
	Name: function_ec1de198
	Namespace: namespace_5c5263e2
	Checksum: 0x52EC8BBE
	Offset: 0x4F0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_ec1de198(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "extra_target_3", value);
}

/*
	Name: __destructor
	Namespace: namespace_5c5263e2
	Checksum: 0x6A266E3B
	Offset: 0x538
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace remote_missile_targets;

/*
	Name: function_5c5263e2
	Namespace: remote_missile_targets
	Checksum: 0xEB54F88E
	Offset: 0x558
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_5c5263e2()
{
	classes.var_5c5263e2[0] = spawnstruct();
	classes.var_5c5263e2[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_5c5263e2[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_5c5263e2[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_5c5263e2[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_5c5263e2[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_5c5263e2[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_5c5263e2[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_5c5263e2[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_5c5263e2[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_5c5263e2[0].__vtable[913321084] = &namespace_5c5263e2::__destructor;
	classes.var_5c5263e2[0].__vtable[333586024] = &namespace_5c5263e2::function_ec1de198;
	classes.var_5c5263e2[0].__vtable[2138109316] = &namespace_5c5263e2::function_808f0a7c;
	classes.var_5c5263e2[0].__vtable[677889907] = &namespace_5c5263e2::function_d798388d;
	classes.var_5c5263e2[0].__vtable[1180734465] = &namespace_5c5263e2::function_46609401;
	classes.var_5c5263e2[0].__vtable[1516492343] = &namespace_5c5263e2::close;
	classes.var_5c5263e2[0].__vtable[250899321] = &namespace_5c5263e2::open;
	classes.var_5c5263e2[0].__vtable[1855416484] = &namespace_5c5263e2::setup_clientfields;
	classes.var_5c5263e2[0].__vtable[674154906] = &namespace_5c5263e2::__constructor;
}

