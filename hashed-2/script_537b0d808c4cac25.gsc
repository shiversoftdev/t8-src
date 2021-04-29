// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace self_revive_visuals_rush;

/*
	Name: register
	Namespace: self_revive_visuals_rush
	Checksum: 0x2A5EED24
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_600b033d();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_revive_visuals_rush
	Checksum: 0xE930F7D7
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
	Namespace: self_revive_visuals_rush
	Checksum: 0xADEDFF66
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
	Namespace: self_revive_visuals_rush
	Checksum: 0x549CFF49
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
	Name: set_revive_time
	Namespace: self_revive_visuals_rush
	Checksum: 0xDFB17AF3
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_revive_time(player, value)
{
	[[ self ]]->set_revive_time(player, value);
}

#namespace namespace_600b033d;

/*
	Name: __constructor
	Namespace: namespace_600b033d
	Checksum: 0x86EC5C37
	Offset: 0x1E0
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
	Namespace: namespace_600b033d
	Checksum: 0x85661467
	Offset: 0x200
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("revive_time", 1, 4, "int");
}

/*
	Name: open
	Namespace: namespace_600b033d
	Checksum: 0x3E68A457
	Offset: 0x258
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "self_revive_visuals_rush", persistent);
}

/*
	Name: close
	Namespace: namespace_600b033d
	Checksum: 0xAC716876
	Offset: 0x2A8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: set_revive_time
	Namespace: namespace_600b033d
	Checksum: 0x21211EA8
	Offset: 0x2D8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function set_revive_time(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "revive_time", value);
}

/*
	Name: __destructor
	Namespace: namespace_600b033d
	Checksum: 0xC1B63A66
	Offset: 0x320
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace self_revive_visuals_rush;

/*
	Name: function_600b033d
	Namespace: self_revive_visuals_rush
	Checksum: 0x1A72373C
	Offset: 0x340
	Size: 0x2F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_600b033d()
{
	classes.var_600b033d[0] = spawnstruct();
	classes.var_600b033d[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_600b033d[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_600b033d[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_600b033d[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_600b033d[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_600b033d[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_600b033d[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_600b033d[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_600b033d[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_600b033d[0].__vtable[913321084] = &namespace_600b033d::__destructor;
	classes.var_600b033d[0].__vtable[160856599] = &namespace_600b033d::set_revive_time;
	classes.var_600b033d[0].__vtable[1516492343] = &namespace_600b033d::close;
	classes.var_600b033d[0].__vtable[250899321] = &namespace_600b033d::open;
	classes.var_600b033d[0].__vtable[1855416484] = &namespace_600b033d::setup_clientfields;
	classes.var_600b033d[0].__vtable[674154906] = &namespace_600b033d::__constructor;
}

