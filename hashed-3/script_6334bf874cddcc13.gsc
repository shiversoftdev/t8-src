// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_towers_crowd_meter;

/*
	Name: register
	Namespace: zm_towers_crowd_meter
	Checksum: 0x65CAA948
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_44e9a2c5();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_crowd_meter
	Checksum: 0x5A237A88
	Offset: 0x120
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
	Namespace: zm_towers_crowd_meter
	Checksum: 0xDBC21D
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
	Namespace: zm_towers_crowd_meter
	Checksum: 0x1D0B5B0F
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
	Name: set_state
	Namespace: zm_towers_crowd_meter
	Checksum: 0xF232AB06
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_visible
	Namespace: zm_towers_crowd_meter
	Checksum: 0x2E2D0612
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_visible(player, value)
{
	[[ self ]]->set_visible(player, value);
}

#namespace namespace_44e9a2c5;

/*
	Name: __constructor
	Namespace: namespace_44e9a2c5
	Checksum: 0x285461F9
	Offset: 0x210
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
	Namespace: namespace_44e9a2c5
	Checksum: 0x3687A054
	Offset: 0x230
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 4, "int");
	namespace_6aaccc24::function_da693cbe("visible", 1, 1, "int");
}

/*
	Name: open
	Namespace: namespace_44e9a2c5
	Checksum: 0xBBF27285
	Offset: 0x2B0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_towers_crowd_meter", persistent);
}

/*
	Name: close
	Namespace: namespace_44e9a2c5
	Checksum: 0x698353A9
	Offset: 0x300
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
	Namespace: namespace_44e9a2c5
	Checksum: 0x66E966A6
	Offset: 0x330
	Size: 0x33C
	Parameters: 2
	Flags: Linked
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"hash_2b0516887b8c733" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	else if(#"crowd_loathes" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 2);
	}
	else if(#"crowd_hates" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 3);
	}
	else if(#"crowd_no_love" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 4);
	}
	else if(#"crowd_warm_up" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 5);
	}
	else if(#"crowd_likes" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 6);
	}
	else if(#"crowd_loves" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 7);
	}
	else if(#"crowd_power_up_available_good" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 8);
	}
	else if(#"crowd_power_up_available_bad" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 9);
	}
	else if(#"crowd_power_up_available_good_partial" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 10);
	}
	else if(#"crowd_power_up_available_bad_partial" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 11);
	}
	assertmsg("");
}

/*
	Name: set_visible
	Namespace: namespace_44e9a2c5
	Checksum: 0x1D96674C
	Offset: 0x678
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function set_visible(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "visible", value);
}

/*
	Name: __destructor
	Namespace: namespace_44e9a2c5
	Checksum: 0x48AE58D6
	Offset: 0x6C0
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_towers_crowd_meter;

/*
	Name: function_44e9a2c5
	Namespace: zm_towers_crowd_meter
	Checksum: 0x92FA59C6
	Offset: 0x6E0
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_44e9a2c5()
{
	classes.var_44e9a2c5[0] = spawnstruct();
	classes.var_44e9a2c5[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_44e9a2c5[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_44e9a2c5[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_44e9a2c5[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_44e9a2c5[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_44e9a2c5[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_44e9a2c5[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_44e9a2c5[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_44e9a2c5[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_44e9a2c5[0].__vtable[913321084] = &namespace_44e9a2c5::__destructor;
	classes.var_44e9a2c5[0].__vtable[658471132] = &namespace_44e9a2c5::set_visible;
	classes.var_44e9a2c5[0].__vtable[655560998] = &namespace_44e9a2c5::set_state;
	classes.var_44e9a2c5[0].__vtable[1516492343] = &namespace_44e9a2c5::close;
	classes.var_44e9a2c5[0].__vtable[250899321] = &namespace_44e9a2c5::open;
	classes.var_44e9a2c5[0].__vtable[1855416484] = &namespace_44e9a2c5::setup_clientfields;
	classes.var_44e9a2c5[0].__vtable[674154906] = &namespace_44e9a2c5::__constructor;
}

