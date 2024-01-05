// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_red_challenges_hud : cluielem
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
		Name: set_challengefailing
		Namespace: czm_red_challenges_hud
		Checksum: 0x75587ECA
		Offset: 0xA10
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_challengefailing(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "challengeFailing", value);
	}

	/*
		Name: set_rewardhidden
		Namespace: czm_red_challenges_hud
		Checksum: 0xCB869CF8
		Offset: 0x9D8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_rewardhidden(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "rewardHidden", value);
	}

	/*
		Name: set_tributeavailable
		Namespace: czm_red_challenges_hud
		Checksum: 0x20E0B5B4
		Offset: 0x9A0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_tributeavailable(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "tributeAvailable", value);
	}

	/*
		Name: increment_progress
		Namespace: czm_red_challenges_hud
		Checksum: 0x329E8760
		Offset: 0x928
		Size: 0x6C
		Parameters: 1
		Flags: None
	*/
	function increment_progress(localclientnum)
	{
		current_val = [[ self ]]->get_data(localclientnum, "progress");
		new_val = (current_val + 1) % 2;
		[[ self ]]->set_data(localclientnum, "progress", new_val);
	}

	/*
		Name: set_binlocation
		Namespace: czm_red_challenges_hud
		Checksum: 0xA29D17E0
		Offset: 0x8F0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_binlocation(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bInLocation", value);
	}

	/*
		Name: set_bottomtext
		Namespace: czm_red_challenges_hud
		Checksum: 0xAD417280
		Offset: 0x8B8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_bottomtext(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bottomText", value);
	}

	/*
		Name: set_challengetext
		Namespace: czm_red_challenges_hud
		Checksum: 0x6EC53CAB
		Offset: 0x880
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_challengetext(localclientnum, value)
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
		cluielem::open(localclientnum, #"zm_red_challenges_hud");
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
		cluielem::function_fa582112(localclientnum);
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
		Name: register_clientside
		Namespace: czm_red_challenges_hud
		Checksum: 0xC5962BD7
		Offset: 0x5C8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
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
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("_state", 1, 2, "int");
		cluielem::function_dcb34c80("string", "challengeText", 13000);
		cluielem::function_dcb34c80("string", "bottomText", 13000);
		cluielem::add_clientfield("bInLocation", 13000, 1, "int", var_4866daed);
		cluielem::add_clientfield("progress", 13000, 1, "counter", var_afaddf7a);
		cluielem::add_clientfield("tributeAvailable", 13000, 3, "int", var_5d7491df);
		cluielem::add_clientfield("rewardHidden", 15000, 1, "int", var_26df3d64);
		cluielem::add_clientfield("challengeFailing", 15000, 1, "int", var_90359ec7);
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
	Name: register_clientside
	Namespace: zm_red_challenges_hud
	Checksum: 0xC452CA9A
	Offset: 0x1C8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new czm_red_challenges_hud();
	[[ elem ]]->register_clientside(uid);
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
	Name: set_challengetext
	Namespace: zm_red_challenges_hud
	Checksum: 0xF9AF30D
	Offset: 0x2B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_challengetext(localclientnum, value)
{
	[[ self ]]->set_challengetext(localclientnum, value);
}

/*
	Name: set_bottomtext
	Namespace: zm_red_challenges_hud
	Checksum: 0xE9A30A0B
	Offset: 0x2E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bottomtext(localclientnum, value)
{
	[[ self ]]->set_bottomtext(localclientnum, value);
}

/*
	Name: set_binlocation
	Namespace: zm_red_challenges_hud
	Checksum: 0xEFA07981
	Offset: 0x318
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_binlocation(localclientnum, value)
{
	[[ self ]]->set_binlocation(localclientnum, value);
}

/*
	Name: increment_progress
	Namespace: zm_red_challenges_hud
	Checksum: 0xCFE689A2
	Offset: 0x348
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function increment_progress(localclientnum)
{
	[[ self ]]->increment_progress(localclientnum);
}

/*
	Name: set_tributeavailable
	Namespace: zm_red_challenges_hud
	Checksum: 0xE1B0F16D
	Offset: 0x370
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_tributeavailable(localclientnum, value)
{
	[[ self ]]->set_tributeavailable(localclientnum, value);
}

/*
	Name: set_rewardhidden
	Namespace: zm_red_challenges_hud
	Checksum: 0xA867A16D
	Offset: 0x3A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_rewardhidden(localclientnum, value)
{
	[[ self ]]->set_rewardhidden(localclientnum, value);
}

/*
	Name: set_challengefailing
	Namespace: zm_red_challenges_hud
	Checksum: 0x5CC2FF69
	Offset: 0x3D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_challengefailing(localclientnum, value)
{
	[[ self ]]->set_challengefailing(localclientnum, value);
}

