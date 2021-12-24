// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_red_challenges_hud;

/*
	Name: register
	Namespace: zm_red_challenges_hud
	Checksum: 0x2B9F7578
	Offset: 0x128
	Size: 0x94
	Parameters: 8
	Flags: None
*/
function register(uid, var_be2ad4d, var_a7896263, var_4866daed, var_afaddf7a, var_5d7491df, var_26df3d64, var_90359ec7)
{
	object = new var_ac693954();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_be2ad4d, var_a7896263, var_4866daed, var_afaddf7a, var_5d7491df, var_26df3d64, var_90359ec7);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_red_challenges_hud
	Checksum: 0xC452CA9A
	Offset: 0x1C8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_ac693954();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_red_challenges_hud
	Checksum: 0x6DC7B67D
	Offset: 0x210
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: zm_red_challenges_hud
	Checksum: 0xD984DD5B
	Offset: 0x238
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
	Checksum: 0x22A63D97
	Offset: 0x260
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_state
	Namespace: zm_red_challenges_hud
	Checksum: 0xBDED2524
	Offset: 0x288
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: function_1c836e71
	Namespace: zm_red_challenges_hud
	Checksum: 0xF9AF30D
	Offset: 0x2B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_1c836e71(localclientnum, value)
{
	[[ self ]]->function_1c836e71(localclientnum, value);
}

/*
	Name: function_2dde4d6c
	Namespace: zm_red_challenges_hud
	Checksum: 0xE9A30A0B
	Offset: 0x2E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_2dde4d6c(localclientnum, value)
{
	[[ self ]]->function_2dde4d6c(localclientnum, value);
}

/*
	Name: function_ad9c4f0
	Namespace: zm_red_challenges_hud
	Checksum: 0xEFA07981
	Offset: 0x318
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_ad9c4f0(localclientnum, value)
{
	[[ self ]]->function_ad9c4f0(localclientnum, value);
}

/*
	Name: function_96972b9c
	Namespace: zm_red_challenges_hud
	Checksum: 0xCFE689A2
	Offset: 0x348
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function function_96972b9c(localclientnum)
{
	[[ self ]]->function_96972b9c(localclientnum);
}

/*
	Name: function_ac67ad85
	Namespace: zm_red_challenges_hud
	Checksum: 0xE1B0F16D
	Offset: 0x370
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_ac67ad85(localclientnum, value)
{
	[[ self ]]->function_ac67ad85(localclientnum, value);
}

/*
	Name: function_3fdd9da7
	Namespace: zm_red_challenges_hud
	Checksum: 0xA867A16D
	Offset: 0x3A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3fdd9da7(localclientnum, value)
{
	[[ self ]]->function_3fdd9da7(localclientnum, value);
}

/*
	Name: function_c6703876
	Namespace: zm_red_challenges_hud
	Checksum: 0x5CC2FF69
	Offset: 0x3D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_c6703876(localclientnum, value)
{
	[[ self ]]->function_c6703876(localclientnum, value);
}

#namespace namespace_ac693954;

/*
	Name: __constructor
	Namespace: namespace_ac693954
	Checksum: 0x934443EE
	Offset: 0x400
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
	Checksum: 0x9EFDB812
	Offset: 0x420
	Size: 0x19C
	Parameters: 8
	Flags: None
*/
function setup_clientfields(uid, var_be2ad4d, var_a7896263, var_4866daed, var_afaddf7a, var_5d7491df, var_26df3d64, var_90359ec7)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 2, "int");
	namespace_6aaccc24::function_dcb34c80("string", "challengeText", 13000);
	namespace_6aaccc24::function_dcb34c80("string", "bottomText", 13000);
	namespace_6aaccc24::function_da693cbe("bInLocation", 13000, 1, "int", var_4866daed);
	namespace_6aaccc24::function_da693cbe("progress", 13000, 1, "counter", var_afaddf7a);
	namespace_6aaccc24::function_da693cbe("tributeAvailable", 13000, 3, "int", var_5d7491df);
	namespace_6aaccc24::function_da693cbe("rewardHidden", 15000, 1, "int", var_26df3d64);
	namespace_6aaccc24::function_da693cbe("challengeFailing", 15000, 1, "int", var_90359ec7);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_ac693954
	Checksum: 0xC5962BD7
	Offset: 0x5C8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	namespace_6aaccc24::function_5c1bb138(uid);
}

/*
	Name: function_fa582112
	Namespace: namespace_ac693954
	Checksum: 0x94FD5F54
	Offset: 0x5F8
	Size: 0x120
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->set_state(localclientnum, #"defaultstate");
	[[ self ]]->function_d7d2fcce(localclientnum, "challengeText", #"");
	[[ self ]]->function_d7d2fcce(localclientnum, "bottomText", #"");
	[[ self ]]->function_d7d2fcce(localclientnum, "bInLocation", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "progress", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "tributeAvailable", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "rewardHidden", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "challengeFailing", 0);
}

/*
	Name: open
	Namespace: namespace_ac693954
	Checksum: 0x4D3404E4
	Offset: 0x720
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_red_challenges_hud");
}

/*
	Name: set_state
	Namespace: namespace_ac693954
	Checksum: 0xA6DFE837
	Offset: 0x758
	Size: 0x11C
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	if(#"defaultstate" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 0);
	}
	else if(#"visible" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
	}
	else if(#"hash_5b34afcc0d053940" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 2);
	}
	else if(#"trials" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 3);
	}
	assertmsg("");
}

/*
	Name: function_1c836e71
	Namespace: namespace_ac693954
	Checksum: 0x6EC53CAB
	Offset: 0x880
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_1c836e71(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "challengeText", value);
}

/*
	Name: function_2dde4d6c
	Namespace: namespace_ac693954
	Checksum: 0xAD417280
	Offset: 0x8B8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_2dde4d6c(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "bottomText", value);
}

/*
	Name: function_ad9c4f0
	Namespace: namespace_ac693954
	Checksum: 0xA29D17E0
	Offset: 0x8F0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_ad9c4f0(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "bInLocation", value);
}

/*
	Name: function_96972b9c
	Namespace: namespace_ac693954
	Checksum: 0x329E8760
	Offset: 0x928
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_96972b9c(localclientnum)
{
	current_val = [[ self ]]->function_92ba69fa(localclientnum, "progress");
	new_val = (current_val + 1) % 2;
	[[ self ]]->function_d7d2fcce(localclientnum, "progress", new_val);
}

/*
	Name: function_ac67ad85
	Namespace: namespace_ac693954
	Checksum: 0x20E0B5B4
	Offset: 0x9A0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_ac67ad85(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "tributeAvailable", value);
}

/*
	Name: function_3fdd9da7
	Namespace: namespace_ac693954
	Checksum: 0xCB869CF8
	Offset: 0x9D8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_3fdd9da7(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "rewardHidden", value);
}

/*
	Name: function_c6703876
	Namespace: namespace_ac693954
	Checksum: 0x75587ECA
	Offset: 0xA10
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_c6703876(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "challengeFailing", value);
}

/*
	Name: __destructor
	Namespace: namespace_ac693954
	Checksum: 0x59784CCA
	Offset: 0xA48
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
	Checksum: 0x8C86F15
	Offset: 0xA68
	Size: 0x4D6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_ac693954()
{
	classes.var_ac693954[0] = spawnstruct();
	classes.var_ac693954[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_ac693954[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_ac693954[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_ac693954[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_ac693954[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_ac693954[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_ac693954[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
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
	classes.var_ac693954[0].__vtable[250899321] = &namespace_ac693954::open;
	classes.var_ac693954[0].__vtable[94887662] = &namespace_ac693954::function_fa582112;
	classes.var_ac693954[0].__vtable[1545318712] = &namespace_ac693954::function_5c1bb138;
	classes.var_ac693954[0].__vtable[1855416484] = &namespace_ac693954::setup_clientfields;
	classes.var_ac693954[0].__vtable[674154906] = &namespace_ac693954::__constructor;
}

