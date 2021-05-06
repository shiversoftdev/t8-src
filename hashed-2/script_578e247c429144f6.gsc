// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace vehicleturretdurability;

/*
	Name: register
	Namespace: vehicleturretdurability
	Checksum: 0x90D76B25
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_366ba496();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: vehicleturretdurability
	Checksum: 0x48A6B65E
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
	Namespace: vehicleturretdurability
	Checksum: 0xDA9390A3
	Offset: 0x160
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: vehicleturretdurability
	Checksum: 0xC64D85EE
	Offset: 0x188
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_fd8c13fb
	Namespace: vehicleturretdurability
	Checksum: 0x42642C55
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_fd8c13fb(player, value)
{
	[[ self ]]->function_fd8c13fb(player, value);
}

#namespace namespace_366ba496;

/*
	Name: __constructor
	Namespace: namespace_366ba496
	Checksum: 0x1DC89457
	Offset: 0x1E0
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
	Namespace: namespace_366ba496
	Checksum: 0xFD55EBD
	Offset: 0x200
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("bar_percent", 4000, 6, "float", 0);
}

/*
	Name: open
	Namespace: namespace_366ba496
	Checksum: 0x6B8B4A3
	Offset: 0x258
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "VehicleTurretDurability", persistent);
}

/*
	Name: close
	Namespace: namespace_366ba496
	Checksum: 0x4C9265F5
	Offset: 0x2A8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_fd8c13fb
	Namespace: namespace_366ba496
	Checksum: 0x18948C15
	Offset: 0x2D8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_fd8c13fb(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "bar_percent", value);
}

/*
	Name: __destructor
	Namespace: namespace_366ba496
	Checksum: 0x35C105CE
	Offset: 0x320
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace vehicleturretdurability;

/*
	Name: function_366ba496
	Namespace: vehicleturretdurability
	Checksum: 0xABE774C4
	Offset: 0x340
	Size: 0x2F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_366ba496()
{
	classes.var_366ba496[0] = spawnstruct();
	classes.var_366ba496[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_366ba496[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_366ba496[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_366ba496[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_366ba496[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_366ba496[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_366ba496[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_366ba496[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_366ba496[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_366ba496[0].__vtable[913321084] = &namespace_366ba496::__destructor;
	classes.var_366ba496[0].__vtable[41151493] = &namespace_366ba496::function_fd8c13fb;
	classes.var_366ba496[0].__vtable[1516492343] = &namespace_366ba496::close;
	classes.var_366ba496[0].__vtable[250899321] = &namespace_366ba496::open;
	classes.var_366ba496[0].__vtable[1855416484] = &namespace_366ba496::setup_clientfields;
	classes.var_366ba496[0].__vtable[674154906] = &namespace_366ba496::__constructor;
}

