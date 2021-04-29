// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace interactive_shot;

/*
	Name: register
	Namespace: interactive_shot
	Checksum: 0xEDE8CAB7
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_849c5d15();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: interactive_shot
	Checksum: 0xFE6E779E
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
	Namespace: interactive_shot
	Checksum: 0x8C391D05
	Offset: 0x150
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
	Namespace: interactive_shot
	Checksum: 0x773F2A0B
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
	Name: function_d5ea17f0
	Namespace: interactive_shot
	Checksum: 0xB5A857D5
	Offset: 0x1A0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_d5ea17f0(player, value)
{
	[[ self ]]->function_d5ea17f0(player, value);
}

#namespace namespace_849c5d15;

/*
	Name: __constructor
	Namespace: namespace_849c5d15
	Checksum: 0xFD2D7C02
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
	Namespace: namespace_849c5d15
	Checksum: 0x68C01EC9
	Offset: 0x1F0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_dcb34c80("string", "text", 1);
}

/*
	Name: open
	Namespace: namespace_849c5d15
	Checksum: 0xD2FCFFD1
	Offset: 0x248
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "interactive_shot", persistent);
}

/*
	Name: close
	Namespace: namespace_849c5d15
	Checksum: 0xDA8C2BDB
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
	Name: function_d5ea17f0
	Namespace: namespace_849c5d15
	Checksum: 0x74C2BD8
	Offset: 0x2C8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_d5ea17f0(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "text", value);
}

/*
	Name: __destructor
	Namespace: namespace_849c5d15
	Checksum: 0x910380B
	Offset: 0x310
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace interactive_shot;

/*
	Name: function_849c5d15
	Namespace: interactive_shot
	Checksum: 0x29C9FC6B
	Offset: 0x330
	Size: 0x2F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_849c5d15()
{
	classes.var_849c5d15[0] = spawnstruct();
	classes.var_849c5d15[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_849c5d15[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_849c5d15[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_849c5d15[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_849c5d15[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_849c5d15[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_849c5d15[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_849c5d15[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_849c5d15[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_849c5d15[0].__vtable[913321084] = &namespace_849c5d15::__destructor;
	classes.var_849c5d15[0].__vtable[706078736] = &namespace_849c5d15::function_d5ea17f0;
	classes.var_849c5d15[0].__vtable[1516492343] = &namespace_849c5d15::close;
	classes.var_849c5d15[0].__vtable[250899321] = &namespace_849c5d15::open;
	classes.var_849c5d15[0].__vtable[1855416484] = &namespace_849c5d15::setup_clientfields;
	classes.var_849c5d15[0].__vtable[674154906] = &namespace_849c5d15::__constructor;
}

