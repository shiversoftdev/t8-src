// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace scavenger_icon;

/*
	Name: register
	Namespace: scavenger_icon
	Checksum: 0x4C9B8AB9
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_e5d48e46();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: scavenger_icon
	Checksum: 0x92CD2583
	Offset: 0x110
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: scavenger_icon
	Checksum: 0xC5B8B9E0
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
	Namespace: scavenger_icon
	Checksum: 0x687FD122
	Offset: 0x178
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_693a2be8
	Namespace: scavenger_icon
	Checksum: 0x4173E362
	Offset: 0x1A0
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_693a2be8(player)
{
	[[ self ]]->function_693a2be8(player);
}

#namespace namespace_e5d48e46;

/*
	Name: __constructor
	Namespace: namespace_e5d48e46
	Checksum: 0x17567AB1
	Offset: 0x1C8
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
	Namespace: namespace_e5d48e46
	Checksum: 0x1839F8E1
	Offset: 0x1E8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("pulse", 1, 1, "counter");
}

/*
	Name: open
	Namespace: namespace_e5d48e46
	Checksum: 0x46D70449
	Offset: 0x240
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "scavenger_icon", persistent);
}

/*
	Name: close
	Namespace: namespace_e5d48e46
	Checksum: 0x4E07157C
	Offset: 0x290
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_693a2be8
	Namespace: namespace_e5d48e46
	Checksum: 0x86C117DA
	Offset: 0x2C0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_693a2be8(player)
{
	player clientfield::function_bb878fc3(self.var_47e79fc, "pulse");
}

/*
	Name: __destructor
	Namespace: namespace_e5d48e46
	Checksum: 0x6F82F3C6
	Offset: 0x300
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace scavenger_icon;

/*
	Name: function_e5d48e46
	Namespace: scavenger_icon
	Checksum: 0x1A2DFD22
	Offset: 0x320
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_e5d48e46()
{
	classes.var_e5d48e46[0] = spawnstruct();
	classes.var_e5d48e46[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_e5d48e46[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_e5d48e46[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_e5d48e46[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_e5d48e46[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_e5d48e46[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_e5d48e46[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_e5d48e46[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_e5d48e46[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_e5d48e46[0].__vtable[913321084] = &namespace_6aaccc24::__destructor;
	classes.var_e5d48e46[0].__vtable[913321084] = &namespace_e5d48e46::__destructor;
	classes.var_e5d48e46[0].__vtable[1765420008] = &namespace_e5d48e46::function_693a2be8;
	classes.var_e5d48e46[0].__vtable[1516492343] = &namespace_e5d48e46::close;
	classes.var_e5d48e46[0].__vtable[250899321] = &namespace_e5d48e46::open;
	classes.var_e5d48e46[0].__vtable[1855416484] = &namespace_e5d48e46::setup_clientfields;
	classes.var_e5d48e46[0].__vtable[674154906] = &namespace_e5d48e46::__constructor;
}

