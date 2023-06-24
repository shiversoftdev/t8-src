// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_red_challenges_hud : cLUIelem
{

	/*
		Name: constructor
		Namespace: czm_red_challenges_hud
		Checksum: 0x934443EE
		Offset: 0x400
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_red_challenges_hud
		Checksum: 0x59784CCA
		Offset: 0xA48
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_challengeFailing
		Namespace: czm_red_challenges_hud
		Checksum: 0x75587ECA
		Offset: 0xA10
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_challengeFailing(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "challengeFailing", value);
	}

	/*
		Name: set_rewardHidden
		Namespace: czm_red_challenges_hud
		Checksum: 0xCB869CF8
		Offset: 0x9D8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_rewardHidden(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "rewardHidden", value);
	}

	/*
		Name: set_tributeAvailable
		Namespace: czm_red_challenges_hud
		Checksum: 0x20E0B5B4
		Offset: 0x9A0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_tributeAvailable(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "tributeAvailable", value);
	}

	/*
		Name: function_96972b9c
		Namespace: czm_red_challenges_hud
		Checksum: 0x329E8760
		Offset: 0x928
		Size: 0x6C
		Parameters: 1
		Flags: None
	*/
	function function_96972b9c(localclientnum)
	{
		current_val = [[ self ]]->get_data(localclientnum, "progress");
		new_val = (current_val + 1) % 2;
		[[ self ]]->set_data(localclientnum, "progress", new_val);
	}

	/*
		Name: set_bInLocation
		Namespace: czm_red_challenges_hud
		Checksum: 0xA29D17E0
		Offset: 0x8F0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_bInLocation(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bInLocation", value);
	}

	/*
		Name: set_bottomText
		Namespace: czm_red_challenges_hud
		Checksum: 0xAD417280
		Offset: 0x8B8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_bottomText(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bottomText", value);
	}

	/*
		Name: set_challengeText
		Namespace: czm_red_challenges_hud
		Checksum: 0x6EC53CAB
		Offset: 0x880
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_challengeText(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "challengeText", value);
	}

	/*
		Name: set_state
		Namespace: czm_red_challenges_hud
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
			[[ self ]]->set_data(localclientnum, "_state", 0);
		}
		else
		{
			if(#"visible" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"visiblepc" == state_name)
				{
					[[ self ]]->set_data(localclientnum, "_state", 2);
				}
				else
				{
					if(#"trials" == state_name)
					{
						[[ self ]]->set_data(localclientnum, "_state", 3);
					}
					else
					{
						/#
							assertmsg("");
						#/
						/#
						#/
					}
				}
			}
		}
	}

	/*
		Name: open
		Namespace: czm_red_challenges_hud
		Checksum: 0x4D3404E4
		Offset: 0x720
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"zm_red_challenges_hud");
	}

	/*
		Name: function_fa582112
		Namespace: czm_red_challenges_hud
		Checksum: 0x94FD5F54
		Offset: 0x5F8
		Size: 0x120
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "challengeText", #"");
		[[ self ]]->set_data(localclientnum, "bottomText", #"");
		[[ self ]]->set_data(localclientnum, "bInLocation", 0);
		[[ self ]]->set_data(localclientnum, "progress", 0);
		[[ self ]]->set_data(localclientnum, "tributeAvailable", 0);
		[[ self ]]->set_data(localclientnum, "rewardHidden", 0);
		[[ self ]]->set_data(localclientnum, "challengeFailing", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: czm_red_challenges_hud
		Checksum: 0xC5962BD7
		Offset: 0x5C8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_5c1bb138(uid)
	{
		cLUIelem::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_red_challenges_hud
		Checksum: 0x9EFDB812
		Offset: 0x420
		Size: 0x19C
		Parameters: 8
		Flags: None
	*/
	function setup_clientfields(uid, var_be2ad4d, var_a7896263, var_4866daed, var_afaddf7a, var_5d7491df, var_26df3d64, var_90359ec7)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 2, "int");
		cLUIelem::function_dcb34c80("string", "challengeText", 13000);
		cLUIelem::function_dcb34c80("string", "bottomText", 13000);
		cLUIelem::function_da693cbe("bInLocation", 13000, 1, "int", var_4866daed);
		cLUIelem::function_da693cbe("progress", 13000, 1, "counter", var_afaddf7a);
		cLUIelem::function_da693cbe("tributeAvailable", 13000, 3, "int", var_5d7491df);
		cLUIelem::function_da693cbe("rewardHidden", 15000, 1, "int", var_26df3d64);
		cLUIelem::function_da693cbe("challengeFailing", 15000, 1, "int", var_90359ec7);
	}

}

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
	elem = new czm_red_challenges_hud();
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
	elem = new czm_red_challenges_hud();
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
	Name: set_challengeText
	Namespace: zm_red_challenges_hud
	Checksum: 0xF9AF30D
	Offset: 0x2B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_challengeText(localclientnum, value)
{
	[[ self ]]->set_challengeText(localclientnum, value);
}

/*
	Name: set_bottomText
	Namespace: zm_red_challenges_hud
	Checksum: 0xE9A30A0B
	Offset: 0x2E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bottomText(localclientnum, value)
{
	[[ self ]]->set_bottomText(localclientnum, value);
}

/*
	Name: set_bInLocation
	Namespace: zm_red_challenges_hud
	Checksum: 0xEFA07981
	Offset: 0x318
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bInLocation(localclientnum, value)
{
	[[ self ]]->set_bInLocation(localclientnum, value);
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
	Name: set_tributeAvailable
	Namespace: zm_red_challenges_hud
	Checksum: 0xE1B0F16D
	Offset: 0x370
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_tributeAvailable(localclientnum, value)
{
	[[ self ]]->set_tributeAvailable(localclientnum, value);
}

/*
	Name: set_rewardHidden
	Namespace: zm_red_challenges_hud
	Checksum: 0xA867A16D
	Offset: 0x3A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_rewardHidden(localclientnum, value)
{
	[[ self ]]->set_rewardHidden(localclientnum, value);
}

/*
	Name: set_challengeFailing
	Namespace: zm_red_challenges_hud
	Checksum: 0x5CC2FF69
	Offset: 0x3D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_challengeFailing(localclientnum, value)
{
	[[ self ]]->set_challengeFailing(localclientnum, value);
}

