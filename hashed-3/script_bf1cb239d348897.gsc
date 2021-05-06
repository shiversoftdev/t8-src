// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_10e9968112011b37;
#using script_170a9c130859c688;

#namespace namespace_46ccc531;

/*
	Name: __init__
	Namespace: namespace_46ccc531
	Checksum: 0x5484187F
	Offset: 0x98
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
autoexec function __init__()
{
	function_63ad593a();
}

/*
	Name: main
	Namespace: namespace_46ccc531
	Checksum: 0x831CE56D
	Offset: 0xB8
	Size: 0x24
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	level thread function_b9962a73();
}

/*
	Name: function_b9962a73
	Namespace: namespace_46ccc531
	Checksum: 0x3506393D
	Offset: 0xE8
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_b9962a73()
{
	if(isdefined(getgametypesetting(#"hash_2992e3d39d55b312")) && getgametypesetting(#"hash_2992e3d39d55b312"))
	{
		chests = getdynentarray("world_ammo_stash_blackjack");
		foreach(dynent in chests)
		{
			function_b562a1b4(dynent, #"hash_6a582b37e8f152b4");
		}
	}
}

/*
	Name: function_63ad593a
	Namespace: namespace_46ccc531
	Checksum: 0x4A634615
	Offset: 0x1E8
	Size: 0x1BC
	Parameters: 0
	Flags: Linked
*/
function function_63ad593a()
{
	var_a12b4736 = &namespace_b0722f43::function_96ff7b88;
	var_d2223309 = &namespace_b0722f43::function_261ab7f5;
	var_b5014996 = &namespace_b0722f43::function_19089c75;
	var_87d0eef8 = &namespace_b0722f43::function_63bfe27;
	var_74257310 = &namespace_b0722f43::function_6da5e673;
	var_f8a4c541 = &namespace_b0722f43::function_6991057;
	var_edfbccd0 = &namespace_b0722f43::function_e70fa91c;
	if(isdefined(getgametypesetting(#"hash_2992e3d39d55b312")) && getgametypesetting(#"hash_2992e3d39d55b312"))
	{
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_13ba73311ab5250f", #"hash_58c8b457cdf56278");
		if(isdefined(getgametypesetting(#"hash_2fa72a7ec2d86741")) && getgametypesetting(#"hash_2fa72a7ec2d86741"))
		{
			namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_745d80b3e4f28da1", #"hash_7e8c84081fafaea4");
		}
	}
}

