// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace death_zone;

/*
	Name: register
	Namespace: death_zone
	Checksum: 0x67B340D0
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_e6fa6527();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: death_zone
	Checksum: 0x2CF90DDF
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
	Namespace: death_zone
	Checksum: 0xBFC9ADF
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
	Namespace: death_zone
	Checksum: 0x7A899DBF
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
	Name: function_3820c524
	Namespace: death_zone
	Checksum: 0x96214F6A
	Offset: 0x1A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3820c524(player, value)
{
	[[ self ]]->function_3820c524(player, value);
}

#namespace namespace_e6fa6527;

/*
	Name: __constructor
	Namespace: namespace_e6fa6527
	Checksum: 0xF7D72CB5
	Offset: 0x1D0
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
	Namespace: namespace_e6fa6527
	Checksum: 0x9B8B17F5
	Offset: 0x1F0
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("shutdown_sec", 1, 9, "int");
}

/*
	Name: open
	Namespace: namespace_e6fa6527
	Checksum: 0x37E43E6A
	Offset: 0x248
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "death_zone", persistent);
}

/*
	Name: close
	Namespace: namespace_e6fa6527
	Checksum: 0xDD1B2821
	Offset: 0x298
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_3820c524
	Namespace: namespace_e6fa6527
	Checksum: 0xED54BADF
	Offset: 0x2C8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_3820c524(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "shutdown_sec", value);
}

/*
	Name: __destructor
	Namespace: namespace_e6fa6527
	Checksum: 0xC79BFFDF
	Offset: 0x310
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace death_zone;

/*
	Name: function_e6fa6527
	Namespace: death_zone
	Checksum: 0x70A3314D
	Offset: 0x330
	Size: 0x2F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_e6fa6527()
{
	classes.var_e6fa6527[0] = spawnstruct();
	classes.var_e6fa6527[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_e6fa6527[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_e6fa6527[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_e6fa6527[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_e6fa6527[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_e6fa6527[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_e6fa6527[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_e6fa6527[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_e6fa6527[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_e6fa6527[0].__vtable[913321084] = &namespace_e6fa6527::__destructor;
	classes.var_e6fa6527[0].__vtable[941671716] = &namespace_e6fa6527::function_3820c524;
	classes.var_e6fa6527[0].__vtable[1516492343] = &namespace_e6fa6527::close;
	classes.var_e6fa6527[0].__vtable[250899321] = &namespace_e6fa6527::open;
	classes.var_e6fa6527[0].__vtable[1855416484] = &namespace_e6fa6527::setup_clientfields;
	classes.var_e6fa6527[0].__vtable[674154906] = &namespace_e6fa6527::__constructor;
}

