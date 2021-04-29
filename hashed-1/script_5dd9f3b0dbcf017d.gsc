// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_trial_weapon_locked;

/*
	Name: register
	Namespace: zm_trial_weapon_locked
	Checksum: 0x6B18BA85
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_12bf89f7();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_trial_weapon_locked
	Checksum: 0x5A389AF7
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
	Namespace: zm_trial_weapon_locked
	Checksum: 0xC559A93E
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
	Namespace: zm_trial_weapon_locked
	Checksum: 0x7F3A5514
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
	Name: function_1e74977
	Namespace: zm_trial_weapon_locked
	Checksum: 0x242FB16C
	Offset: 0x1B0
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function function_1e74977(player)
{
	[[ self ]]->function_1e74977(player);
}

#namespace namespace_12bf89f7;

/*
	Name: __constructor
	Namespace: namespace_12bf89f7
	Checksum: 0xE092AC28
	Offset: 0x1D8
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
	Namespace: namespace_12bf89f7
	Checksum: 0xD5AC8B98
	Offset: 0x1F8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("show_icon", 1, 1, "counter");
}

/*
	Name: open
	Namespace: namespace_12bf89f7
	Checksum: 0x7A109E1B
	Offset: 0x250
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_trial_weapon_locked", persistent);
}

/*
	Name: close
	Namespace: namespace_12bf89f7
	Checksum: 0x8159D702
	Offset: 0x2A0
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_1e74977
	Namespace: namespace_12bf89f7
	Checksum: 0xDF200818
	Offset: 0x2D0
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_1e74977(player)
{
	player clientfield::function_bb878fc3(self.var_47e79fc, "show_icon");
}

/*
	Name: __destructor
	Namespace: namespace_12bf89f7
	Checksum: 0xAE2606F5
	Offset: 0x310
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_trial_weapon_locked;

/*
	Name: function_12bf89f7
	Namespace: zm_trial_weapon_locked
	Checksum: 0x5BC75D22
	Offset: 0x330
	Size: 0x2F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_12bf89f7()
{
	classes.var_12bf89f7[0] = spawnstruct();
	classes.var_12bf89f7[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_12bf89f7[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_12bf89f7[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_12bf89f7[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_12bf89f7[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_12bf89f7[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_12bf89f7[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_12bf89f7[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_12bf89f7[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_12bf89f7[0].__vtable[913321084] = &namespace_12bf89f7::__destructor;
	classes.var_12bf89f7[0].__vtable[31934839] = &namespace_12bf89f7::function_1e74977;
	classes.var_12bf89f7[0].__vtable[1516492343] = &namespace_12bf89f7::close;
	classes.var_12bf89f7[0].__vtable[250899321] = &namespace_12bf89f7::open;
	classes.var_12bf89f7[0].__vtable[1855416484] = &namespace_12bf89f7::setup_clientfields;
	classes.var_12bf89f7[0].__vtable[674154906] = &namespace_12bf89f7::__constructor;
}

