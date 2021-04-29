// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_red_challenges_hud;

/*
	Name: register
	Namespace: zm_red_challenges_hud
	Checksum: 0x26119C0
	Offset: 0x148
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_ac693954();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_red_challenges_hud
	Checksum: 0x6BF68E62
	Offset: 0x190
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
	Namespace: zm_red_challenges_hud
	Checksum: 0x20B05506
	Offset: 0x1D0
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
	Namespace: zm_red_challenges_hud
	Checksum: 0x12DEBB97
	Offset: 0x1F8
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
	Namespace: zm_red_challenges_hud
	Checksum: 0xA0929FD0
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_1c836e71
	Namespace: zm_red_challenges_hud
	Checksum: 0xC6F3F65E
	Offset: 0x250
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_1c836e71(player, value)
{
	[[ self ]]->function_1c836e71(player, value);
}

/*
	Name: function_2dde4d6c
	Namespace: zm_red_challenges_hud
	Checksum: 0x22E08F7C
	Offset: 0x280
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_2dde4d6c(player, value)
{
	[[ self ]]->function_2dde4d6c(player, value);
}

/*
	Name: function_ad9c4f0
	Namespace: zm_red_challenges_hud
	Checksum: 0x25504718
	Offset: 0x2B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_ad9c4f0(player, value)
{
	[[ self ]]->function_ad9c4f0(player, value);
}

/*
	Name: function_96972b9c
	Namespace: zm_red_challenges_hud
	Checksum: 0x641D0716
	Offset: 0x2E0
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function function_96972b9c(player)
{
	[[ self ]]->function_96972b9c(player);
}

/*
	Name: function_ac67ad85
	Namespace: zm_red_challenges_hud
	Checksum: 0xCE045DE2
	Offset: 0x308
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_ac67ad85(player, value)
{
	[[ self ]]->function_ac67ad85(player, value);
}

/*
	Name: function_3fdd9da7
	Namespace: zm_red_challenges_hud
	Checksum: 0xAFA89D48
	Offset: 0x338
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3fdd9da7(player, value)
{
	[[ self ]]->function_3fdd9da7(player, value);
}

/*
	Name: function_c6703876
	Namespace: zm_red_challenges_hud
	Checksum: 0xFB8BFC8B
	Offset: 0x368
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_c6703876(player, value)
{
	[[ self ]]->function_c6703876(player, value);
}

#namespace namespace_ac693954;

/*
	Name: __constructor
	Namespace: namespace_ac693954
	Checksum: 0x924A4A5F
	Offset: 0x398
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
	Namespace: namespace_ac693954
	Checksum: 0x150703C5
	Offset: 0x3B8
	Size: 0x164
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 2, "int");
	namespace_6aaccc24::function_dcb34c80("string", "challengeText", 13000);
	namespace_6aaccc24::function_dcb34c80("string", "bottomText", 13000);
	namespace_6aaccc24::function_da693cbe("bInLocation", 13000, 1, "int");
	namespace_6aaccc24::function_da693cbe("progress", 13000, 1, "counter");
	namespace_6aaccc24::function_da693cbe("tributeAvailable", 13000, 3, "int");
	namespace_6aaccc24::function_da693cbe("rewardHidden", 15000, 1, "int");
	namespace_6aaccc24::function_da693cbe("challengeFailing", 15000, 1, "int");
}

/*
	Name: open
	Namespace: namespace_ac693954
	Checksum: 0x4F9A2773
	Offset: 0x528
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_red_challenges_hud", persistent);
}

/*
	Name: close
	Namespace: namespace_ac693954
	Checksum: 0xF5F8599F
	Offset: 0x578
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
	Namespace: namespace_ac693954
	Checksum: 0x2FCB7E1F
	Offset: 0x5A8
	Size: 0x13C
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"visible" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	else if(#"hash_5b34afcc0d053940" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 2);
	}
	else if(#"trials" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 3);
	}
	assertmsg("");
}

/*
	Name: function_1c836e71
	Namespace: namespace_ac693954
	Checksum: 0xA114966D
	Offset: 0x6F0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_1c836e71(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "challengeText", value);
}

/*
	Name: function_2dde4d6c
	Namespace: namespace_ac693954
	Checksum: 0xA4E318FC
	Offset: 0x738
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_2dde4d6c(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "bottomText", value);
}

/*
	Name: function_ad9c4f0
	Namespace: namespace_ac693954
	Checksum: 0xAA45B088
	Offset: 0x780
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_ad9c4f0(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "bInLocation", value);
}

/*
	Name: function_96972b9c
	Namespace: namespace_ac693954
	Checksum: 0x4BA442A0
	Offset: 0x7C8
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_96972b9c(player)
{
	player clientfield::function_bb878fc3(self.var_47e79fc, "progress");
}

/*
	Name: function_ac67ad85
	Namespace: namespace_ac693954
	Checksum: 0x88B7C0A8
	Offset: 0x808
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_ac67ad85(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "tributeAvailable", value);
}

/*
	Name: function_3fdd9da7
	Namespace: namespace_ac693954
	Checksum: 0xBC9CE00
	Offset: 0x850
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_3fdd9da7(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "rewardHidden", value);
}

/*
	Name: function_c6703876
	Namespace: namespace_ac693954
	Checksum: 0x868E354E
	Offset: 0x898
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_c6703876(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "challengeFailing", value);
}

/*
	Name: __destructor
	Namespace: namespace_ac693954
	Checksum: 0x91B99D56
	Offset: 0x8E0
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_red_challenges_hud;

/*
	Name: function_ac693954
	Namespace: zm_red_challenges_hud
	Checksum: 0xCE5523F4
	Offset: 0x900
	Size: 0x446
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_ac693954()
{
	classes.var_ac693954[0] = spawnstruct();
	classes.var_ac693954[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_ac693954[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_ac693954[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_ac693954[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_ac693954[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_ac693954[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_ac693954[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_ac693954[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_ac693954[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_ac693954[0].__vtable[913321084] = &namespace_ac693954::__destructor;
	classes.var_ac693954[0].__vtable[965724042] = &namespace_ac693954::function_c6703876;
	classes.var_ac693954[0].__vtable[1071488423] = &namespace_ac693954::function_3fdd9da7;
	classes.var_ac693954[0].__vtable[1402491515] = &namespace_ac693954::function_ac67ad85;
	classes.var_ac693954[0].__vtable[1768477796] = &namespace_ac693954::function_96972b9c;
	classes.var_ac693954[0].__vtable[182043888] = &namespace_ac693954::function_ad9c4f0;
	classes.var_ac693954[0].__vtable[769543532] = &namespace_ac693954::function_2dde4d6c;
	classes.var_ac693954[0].__vtable[478375537] = &namespace_ac693954::function_1c836e71;
	classes.var_ac693954[0].__vtable[655560998] = &namespace_ac693954::set_state;
	classes.var_ac693954[0].__vtable[1516492343] = &namespace_ac693954::close;
	classes.var_ac693954[0].__vtable[250899321] = &namespace_ac693954::open;
	classes.var_ac693954[0].__vtable[1855416484] = &namespace_ac693954::setup_clientfields;
	classes.var_ac693954[0].__vtable[674154906] = &namespace_ac693954::__constructor;
}

