// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cct_shared_objcounter : cLUIelem
{

	/*
		Name: constructor
		Namespace: cct_shared_objcounter
		Checksum: 0x97A213AB
		Offset: 0x2D8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cct_shared_objcounter
		Checksum: 0x2D509ACC
		Offset: 0x770
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_objectiveTotal
		Namespace: cct_shared_objcounter
		Checksum: 0x8F4A52
		Offset: 0x738
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objectiveTotal(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objectiveTotal", value);
	}

	/*
		Name: set_objectiveLabel
		Namespace: cct_shared_objcounter
		Checksum: 0xDEE6DF9C
		Offset: 0x700
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objectiveLabel(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objectiveLabel", value);
	}

	/*
		Name: set_objectiveCount
		Namespace: cct_shared_objcounter
		Checksum: 0x23C50273
		Offset: 0x6C8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objectiveCount(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objectiveCount", value);
	}

	/*
		Name: set_state
		Namespace: cct_shared_objcounter
		Checksum: 0x54946D0
		Offset: 0x4F8
		Size: 0x1C4
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
			if(#"nototal" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"hash_1895dd9cec027130" == state_name)
				{
					[[ self ]]->set_data(localclientnum, "_state", 2);
				}
				else
				{
					if(#"total" == state_name)
					{
						[[ self ]]->set_data(localclientnum, "_state", 3);
					}
					else
					{
						if(#"total_update" == state_name)
						{
							[[ self ]]->set_data(localclientnum, "_state", 4);
						}
						else
						{
							if(#"hash_5edcadf19882d66f" == state_name)
							{
								[[ self ]]->set_data(localclientnum, "_state", 5);
							}
							else
							{
								if(#"total_init" == state_name)
								{
									[[ self ]]->set_data(localclientnum, "_state", 6);
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
			}
		}
	}

	/*
		Name: open
		Namespace: cct_shared_objcounter
		Checksum: 0x384860D
		Offset: 0x4C0
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"ct_shared_objcounter");
	}

	/*
		Name: function_fa582112
		Namespace: cct_shared_objcounter
		Checksum: 0x27E48F04
		Offset: 0x410
		Size: 0xA8
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "objectiveCount", 0);
		[[ self ]]->set_data(localclientnum, "objectiveLabel", #"");
		[[ self ]]->set_data(localclientnum, "objectiveTotal", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cct_shared_objcounter
		Checksum: 0xBDD02BC9
		Offset: 0x3E0
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
		Namespace: cct_shared_objcounter
		Checksum: 0xC3A0D53B
		Offset: 0x2F8
		Size: 0xDC
		Parameters: 4
		Flags: None
	*/
	function setup_clientfields(uid, var_c2f4c01a, var_d45d2560, var_cee9c803)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 3, "int");
		cLUIelem::function_da693cbe("objectiveCount", 1, 5, "int", var_c2f4c01a);
		cLUIelem::function_dcb34c80("string", "objectiveLabel", 1);
		cLUIelem::function_da693cbe("objectiveTotal", 1, 5, "int", var_cee9c803);
	}

}

#namespace ct_shared_objcounter;

/*
	Name: register
	Namespace: ct_shared_objcounter
	Checksum: 0x657BC818
	Offset: 0xE8
	Size: 0x64
	Parameters: 4
	Flags: None
*/
function register(uid, var_c2f4c01a, var_d45d2560, var_cee9c803)
{
	elem = new cct_shared_objcounter();
	[[ elem ]]->setup_clientfields(uid, var_c2f4c01a, var_d45d2560, var_cee9c803);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: ct_shared_objcounter
	Checksum: 0x55A3A721
	Offset: 0x158
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cct_shared_objcounter();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_objcounter
	Checksum: 0x3B465B4D
	Offset: 0x1A0
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
	Namespace: ct_shared_objcounter
	Checksum: 0x2CD5D2E9
	Offset: 0x1C8
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
	Checksum: 0xB16FCC3C
	Offset: 0x1F0
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
	Namespace: ct_shared_objcounter
	Checksum: 0xF4C403A
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: set_objectiveCount
	Namespace: ct_shared_objcounter
	Checksum: 0x4FDE408D
	Offset: 0x248
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objectiveCount(localclientnum, value)
{
	[[ self ]]->set_objectiveCount(localclientnum, value);
}

/*
	Name: set_objectiveLabel
	Namespace: ct_shared_objcounter
	Checksum: 0x65261ED9
	Offset: 0x278
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objectiveLabel(localclientnum, value)
{
	[[ self ]]->set_objectiveLabel(localclientnum, value);
}

/*
	Name: set_objectiveTotal
	Namespace: ct_shared_objcounter
	Checksum: 0xAABCD3E3
	Offset: 0x2A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objectiveTotal(localclientnum, value)
{
	[[ self ]]->set_objectiveTotal(localclientnum, value);
}

