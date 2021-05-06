// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace vehicleturretoverheat;

/*
	Name: register
	Namespace: vehicleturretoverheat
	Checksum: 0x145D78FB
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_ad2941a0();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: vehicleturretoverheat
	Checksum: 0x4E7DA7A4
	Offset: 0x128
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
	Namespace: vehicleturretoverheat
	Checksum: 0xE9530D87
	Offset: 0x168
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
	Namespace: vehicleturretoverheat
	Checksum: 0x2ED54047
	Offset: 0x190
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_state
	Namespace: vehicleturretoverheat
	Checksum: 0x332F47C8
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_fd8c13fb
	Namespace: vehicleturretoverheat
	Checksum: 0xFABE0E84
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_fd8c13fb(player, value)
{
	[[ self ]]->function_fd8c13fb(player, value);
}

#namespace namespace_ad2941a0;

/*
	Name: __constructor
	Namespace: namespace_ad2941a0
	Checksum: 0xA642CBD5
	Offset: 0x218
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
	Namespace: namespace_ad2941a0
	Checksum: 0xB83BC254
	Offset: 0x238
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("bar_percent", 4000, 6, "float", 0);
}

/*
	Name: open
	Namespace: namespace_ad2941a0
	Checksum: 0x4AA2925F
	Offset: 0x2B8
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "VehicleTurretOverheat", persistent);
}

/*
	Name: close
	Namespace: namespace_ad2941a0
	Checksum: 0xA8204B39
	Offset: 0x308
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: set_state
	Namespace: namespace_ad2941a0
	Checksum: 0x543EC8D6
	Offset: 0x338
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"overheat" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	assertmsg("");
}

/*
	Name: function_fd8c13fb
	Namespace: namespace_ad2941a0
	Checksum: 0x197DB59E
	Offset: 0x400
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
	Namespace: namespace_ad2941a0
	Checksum: 0xDC166380
	Offset: 0x448
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace vehicleturretoverheat;

/*
	Name: function_ad2941a0
	Namespace: vehicleturretoverheat
	Checksum: 0x14CD9B4
	Offset: 0x468
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_ad2941a0()
{
	classes.var_ad2941a0[0] = spawnstruct();
	classes.var_ad2941a0[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_ad2941a0[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_ad2941a0[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_ad2941a0[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_ad2941a0[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_ad2941a0[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_ad2941a0[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_ad2941a0[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_ad2941a0[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_ad2941a0[0].__vtable[913321084] = &namespace_ad2941a0::__destructor;
	classes.var_ad2941a0[0].__vtable[41151493] = &namespace_ad2941a0::function_fd8c13fb;
	classes.var_ad2941a0[0].__vtable[655560998] = &namespace_ad2941a0::set_state;
	classes.var_ad2941a0[0].__vtable[1516492343] = &namespace_ad2941a0::close;
	classes.var_ad2941a0[0].__vtable[250899321] = &namespace_ad2941a0::open;
	classes.var_ad2941a0[0].__vtable[1855416484] = &namespace_ad2941a0::setup_clientfields;
	classes.var_ad2941a0[0].__vtable[674154906] = &namespace_ad2941a0::__constructor;
}

