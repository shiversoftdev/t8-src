// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_towers_pap_hud;

/*
	Name: register
	Namespace: zm_towers_pap_hud
	Checksum: 0x81CC59FD
	Offset: 0x100
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_2051697f();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_pap_hud
	Checksum: 0xFD5D22E8
	Offset: 0x148
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
	Namespace: zm_towers_pap_hud
	Checksum: 0xA6177E61
	Offset: 0x188
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
	Namespace: zm_towers_pap_hud
	Checksum: 0x2102F99C
	Offset: 0x1B0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_eda3959a
	Namespace: zm_towers_pap_hud
	Checksum: 0x1DD72F4A
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_eda3959a(player, value)
{
	[[ self ]]->function_eda3959a(player, value);
}

/*
	Name: function_bd5da28f
	Namespace: zm_towers_pap_hud
	Checksum: 0xFA5C49A1
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_bd5da28f(player, value)
{
	[[ self ]]->function_bd5da28f(player, value);
}

/*
	Name: function_8a094f25
	Namespace: zm_towers_pap_hud
	Checksum: 0xFD216808
	Offset: 0x238
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8a094f25(player, value)
{
	[[ self ]]->function_8a094f25(player, value);
}

/*
	Name: function_b6ec93fa
	Namespace: zm_towers_pap_hud
	Checksum: 0xBDA447B7
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_b6ec93fa(player, value)
{
	[[ self ]]->function_b6ec93fa(player, value);
}

#namespace namespace_2051697f;

/*
	Name: __constructor
	Namespace: namespace_2051697f
	Checksum: 0x58440466
	Offset: 0x298
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
	Namespace: namespace_2051697f
	Checksum: 0x8E6378A7
	Offset: 0x2B8
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("danu_acquired", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("ra_acquired", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("zeus_acquired", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("odin_acquired", 1, 1, "int");
}

/*
	Name: open
	Namespace: namespace_2051697f
	Checksum: 0x6F3BD843
	Offset: 0x388
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_towers_pap_hud", persistent);
}

/*
	Name: close
	Namespace: namespace_2051697f
	Checksum: 0xFDEFABBE
	Offset: 0x3D8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_eda3959a
	Namespace: namespace_2051697f
	Checksum: 0x343E20DE
	Offset: 0x408
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_eda3959a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "danu_acquired", value);
}

/*
	Name: function_bd5da28f
	Namespace: namespace_2051697f
	Checksum: 0x5BEE22C6
	Offset: 0x450
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_bd5da28f(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "ra_acquired", value);
}

/*
	Name: function_8a094f25
	Namespace: namespace_2051697f
	Checksum: 0xB2E3EEFC
	Offset: 0x498
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_8a094f25(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "zeus_acquired", value);
}

/*
	Name: function_b6ec93fa
	Namespace: namespace_2051697f
	Checksum: 0x48780F9D
	Offset: 0x4E0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_b6ec93fa(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "odin_acquired", value);
}

/*
	Name: __destructor
	Namespace: namespace_2051697f
	Checksum: 0xA7CF1CC
	Offset: 0x528
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_towers_pap_hud;

/*
	Name: function_2051697f
	Namespace: zm_towers_pap_hud
	Checksum: 0x19873366
	Offset: 0x548
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_2051697f()
{
	classes.var_2051697f[0] = spawnstruct();
	classes.var_2051697f[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_2051697f[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_2051697f[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_2051697f[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_2051697f[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_2051697f[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_2051697f[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_2051697f[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_2051697f[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_2051697f[0].__vtable[913321084] = &namespace_2051697f::__destructor;
	classes.var_2051697f[0].__vtable[1226009606] = &namespace_2051697f::function_b6ec93fa;
	classes.var_2051697f[0].__vtable[1979101403] = &namespace_2051697f::function_8a094f25;
	classes.var_2051697f[0].__vtable[1117937009] = &namespace_2051697f::function_bd5da28f;
	classes.var_2051697f[0].__vtable[308046438] = &namespace_2051697f::function_eda3959a;
	classes.var_2051697f[0].__vtable[1516492343] = &namespace_2051697f::close;
	classes.var_2051697f[0].__vtable[250899321] = &namespace_2051697f::open;
	classes.var_2051697f[0].__vtable[1855416484] = &namespace_2051697f::setup_clientfields;
	classes.var_2051697f[0].__vtable[674154906] = &namespace_2051697f::__constructor;
}

