// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace ct_shared_objcounter;

/*
	Name: register
	Namespace: ct_shared_objcounter
	Checksum: 0x1AC64B9F
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_f6104ad5();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_objcounter
	Checksum: 0x4EFA6376
	Offset: 0x150
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
	Namespace: ct_shared_objcounter
	Checksum: 0xC5D0FD9E
	Offset: 0x190
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
	Namespace: ct_shared_objcounter
	Checksum: 0x7083BC09
	Offset: 0x1B8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_state
	Namespace: ct_shared_objcounter
	Checksum: 0x8DB3B6E6
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_e23dcbb4
	Namespace: ct_shared_objcounter
	Checksum: 0xD36D4652
	Offset: 0x210
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_e23dcbb4(player, value)
{
	[[ self ]]->function_e23dcbb4(player, value);
}

/*
	Name: function_d9fa867a
	Namespace: ct_shared_objcounter
	Checksum: 0x3A83F056
	Offset: 0x240
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d9fa867a(player, value)
{
	[[ self ]]->function_d9fa867a(player, value);
}

/*
	Name: function_871cdcb3
	Namespace: ct_shared_objcounter
	Checksum: 0x6F552D5C
	Offset: 0x270
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_871cdcb3(player, value)
{
	[[ self ]]->function_871cdcb3(player, value);
}

#namespace namespace_f6104ad5;

/*
	Name: __constructor
	Namespace: namespace_f6104ad5
	Checksum: 0xA11B57CF
	Offset: 0x2A0
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
	Namespace: namespace_f6104ad5
	Checksum: 0x5CFF223D
	Offset: 0x2C0
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 3, "int");
	namespace_6aaccc24::function_da693cbe("objectiveCount", 1, 5, "int");
	namespace_6aaccc24::function_dcb34c80("string", "objectiveLabel", 1);
	namespace_6aaccc24::function_da693cbe("objectiveTotal", 1, 5, "int");
}

/*
	Name: open
	Namespace: namespace_f6104ad5
	Checksum: 0xF84F6916
	Offset: 0x390
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "ct_shared_objcounter", persistent);
}

/*
	Name: close
	Namespace: namespace_f6104ad5
	Checksum: 0x369BA90F
	Offset: 0x3E0
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: set_state
	Namespace: namespace_f6104ad5
	Checksum: 0x3931B69E
	Offset: 0x410
	Size: 0x1FC
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"hash_2da0af76542bf74" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	else if(#"hash_1895dd9cec027130" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 2);
	}
	else if(#"total" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 3);
	}
	else if(#"hash_3a90323ee061faef" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 4);
	}
	else if(#"hash_5edcadf19882d66f" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 5);
	}
	else if(#"hash_2d31980bd7e27adc" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 6);
	}
	assertmsg("");
}

/*
	Name: function_e23dcbb4
	Namespace: namespace_f6104ad5
	Checksum: 0x7B7A794C
	Offset: 0x618
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_e23dcbb4(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objectiveCount", value);
}

/*
	Name: function_d9fa867a
	Namespace: namespace_f6104ad5
	Checksum: 0xC46DCDF1
	Offset: 0x660
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_d9fa867a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objectiveLabel", value);
}

/*
	Name: function_871cdcb3
	Namespace: namespace_f6104ad5
	Checksum: 0xD858D50B
	Offset: 0x6A8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_871cdcb3(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objectiveTotal", value);
}

/*
	Name: __destructor
	Namespace: namespace_f6104ad5
	Checksum: 0x32C0D918
	Offset: 0x6F0
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace ct_shared_objcounter;

/*
	Name: function_f6104ad5
	Namespace: ct_shared_objcounter
	Checksum: 0x95D1756
	Offset: 0x710
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_f6104ad5()
{
	classes.var_f6104ad5[0] = spawnstruct();
	classes.var_f6104ad5[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_f6104ad5[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_f6104ad5[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_f6104ad5[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_f6104ad5[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_f6104ad5[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_f6104ad5[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_f6104ad5[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_f6104ad5[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_f6104ad5[0].__vtable[913321084] = &namespace_f6104ad5::__destructor;
	classes.var_f6104ad5[0].__vtable[2028151629] = &namespace_f6104ad5::function_871cdcb3;
	classes.var_f6104ad5[0].__vtable[637892998] = &namespace_f6104ad5::function_d9fa867a;
	classes.var_f6104ad5[0].__vtable[499266636] = &namespace_f6104ad5::function_e23dcbb4;
	classes.var_f6104ad5[0].__vtable[655560998] = &namespace_f6104ad5::set_state;
	classes.var_f6104ad5[0].__vtable[1516492343] = &namespace_f6104ad5::close;
	classes.var_f6104ad5[0].__vtable[250899321] = &namespace_f6104ad5::open;
	classes.var_f6104ad5[0].__vtable[1855416484] = &namespace_f6104ad5::setup_clientfields;
	classes.var_f6104ad5[0].__vtable[674154906] = &namespace_f6104ad5::__constructor;
}

