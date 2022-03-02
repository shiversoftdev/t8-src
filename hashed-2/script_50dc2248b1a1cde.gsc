// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_bff7216d : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_bff7216d
		Checksum: 0x18C8275A
		Offset: 0x2D0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_bff7216d
		Checksum: 0x559E512A
		Offset: 0x650
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_f718efbf
		Namespace: namespace_bff7216d
		Checksum: 0xC8477C11
		Offset: 0x618
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_f718efbf(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "required_goal", value);
	}

	/*
		Name: function_7a344bdf
		Namespace: namespace_bff7216d
		Checksum: 0x4D4750BB
		Offset: 0x5E0
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_7a344bdf(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "challenge_text", value);
	}

	/*
		Name: function_affe8f61
		Namespace: namespace_bff7216d
		Checksum: 0x4408084F
		Offset: 0x5A8
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_affe8f61(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "progress", value);
	}

	/*
		Name: set_state
		Namespace: namespace_bff7216d
		Checksum: 0xFE25F32
		Offset: 0x4F0
		Size: 0xAC
		Parameters: 2
		Flags: Linked
	*/
	function set_state(localclientnum, state_name)
	{
		if(#"defaultstate" == state_name)
		{
			[[ self ]]->function_d7d2fcce(localclientnum, "_state", 0);
		}
		else
		{
			if(#"hidden" == state_name)
			{
				[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
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

	/*
		Name: open
		Namespace: namespace_bff7216d
		Checksum: 0x4DEB17C3
		Offset: 0x4B8
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"zm_towers_challenges_hud");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_bff7216d
		Checksum: 0x33F484DC
		Offset: 0x408
		Size: 0xA8
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->function_d7d2fcce(localclientnum, "progress", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "challenge_text", #"");
		[[ self ]]->function_d7d2fcce(localclientnum, "required_goal", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_bff7216d
		Checksum: 0xF1B271E3
		Offset: 0x3D8
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		namespace_6aaccc24::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_bff7216d
		Checksum: 0x23E26286
		Offset: 0x2F0
		Size: 0xDC
		Parameters: 4
		Flags: Linked
	*/
	function setup_clientfields(uid, var_afaddf7a, var_c00108aa, var_db844c2)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("_state", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("progress", 1, 7, "int", var_afaddf7a);
		namespace_6aaccc24::function_dcb34c80("string", "challenge_text", 1);
		namespace_6aaccc24::function_da693cbe("required_goal", 1, 7, "int", var_db844c2);
	}

}

#namespace zm_towers_challenges_hud;

/*
	Name: register
	Namespace: zm_towers_challenges_hud
	Checksum: 0xF934108C
	Offset: 0xE0
	Size: 0x64
	Parameters: 4
	Flags: None
*/
function register(uid, var_afaddf7a, var_c00108aa, var_db844c2)
{
	elem = new class_bff7216d();
	[[ elem ]]->setup_clientfields(uid, var_afaddf7a, var_c00108aa, var_db844c2);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_towers_challenges_hud
	Checksum: 0xE9829B6B
	Offset: 0x150
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_bff7216d();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_challenges_hud
	Checksum: 0xDA63FCB5
	Offset: 0x198
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
	Namespace: zm_towers_challenges_hud
	Checksum: 0x56FC7192
	Offset: 0x1C0
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
	Namespace: zm_towers_challenges_hud
	Checksum: 0x81C4F12F
	Offset: 0x1E8
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
	Namespace: zm_towers_challenges_hud
	Checksum: 0x1B16E4DE
	Offset: 0x210
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: function_affe8f61
	Namespace: zm_towers_challenges_hud
	Checksum: 0x4DC977CB
	Offset: 0x240
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_affe8f61(localclientnum, value)
{
	[[ self ]]->function_affe8f61(localclientnum, value);
}

/*
	Name: function_7a344bdf
	Namespace: zm_towers_challenges_hud
	Checksum: 0x5B4C1701
	Offset: 0x270
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7a344bdf(localclientnum, value)
{
	[[ self ]]->function_7a344bdf(localclientnum, value);
}

/*
	Name: function_f718efbf
	Namespace: zm_towers_challenges_hud
	Checksum: 0xCA367F0E
	Offset: 0x2A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_f718efbf(localclientnum, value)
{
	[[ self ]]->function_f718efbf(localclientnum, value);
}

