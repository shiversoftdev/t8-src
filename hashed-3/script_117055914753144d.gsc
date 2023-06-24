// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cct_shared_aar : cLUIelem
{

	/*
		Name: constructor
		Namespace: cct_shared_aar
		Checksum: 0x458129F0
		Offset: 0x330
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cct_shared_aar
		Checksum: 0x86FA6254
		Offset: 0x970
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_medalThresholds
		Namespace: cct_shared_aar
		Checksum: 0xCF225402
		Offset: 0x938
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_medalThresholds(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "medalThresholds", value);
	}

	/*
		Name: set_missionResultMsg
		Namespace: cct_shared_aar
		Checksum: 0x1EA2A59B
		Offset: 0x900
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_missionResultMsg(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "missionResultMsg", value);
	}

	/*
		Name: set_bestTimeMilliseconds
		Namespace: cct_shared_aar
		Checksum: 0x2315508B
		Offset: 0x8C8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_bestTimeMilliseconds(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bestTimeMilliseconds", value);
	}

	/*
		Name: set_timeMilliseconds
		Namespace: cct_shared_aar
		Checksum: 0xD5A20EE6
		Offset: 0x890
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_timeMilliseconds(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "timeMilliseconds", value);
	}

	/*
		Name: set_state
		Namespace: cct_shared_aar
		Checksum: 0x2C98A537
		Offset: 0x5A8
		Size: 0x2DC
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
			if(#"success_fadeout" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"hash_e4c570778eda419" == state_name)
				{
					[[ self ]]->set_data(localclientnum, "_state", 2);
				}
				else
				{
					if(#"fail" == state_name)
					{
						[[ self ]]->set_data(localclientnum, "_state", 3);
					}
					else
					{
						if(#"fail_fadeout" == state_name)
						{
							[[ self ]]->set_data(localclientnum, "_state", 4);
						}
						else
						{
							if(#"win_gold" == state_name)
							{
								[[ self ]]->set_data(localclientnum, "_state", 5);
							}
							else
							{
								if(#"win_silver" == state_name)
								{
									[[ self ]]->set_data(localclientnum, "_state", 6);
								}
								else
								{
									if(#"win_bronze" == state_name)
									{
										[[ self ]]->set_data(localclientnum, "_state", 7);
									}
									else
									{
										if(#"hash_18174a43e0ca3b90" == state_name)
										{
											[[ self ]]->set_data(localclientnum, "_state", 8);
										}
										else
										{
											if(#"hash_3327faf4ae535f2b" == state_name)
											{
												[[ self ]]->set_data(localclientnum, "_state", 9);
											}
											else
											{
												if(#"hash_32ceb5e1ecc00d78" == state_name)
												{
													[[ self ]]->set_data(localclientnum, "_state", 10);
												}
												else
												{
													if(#"hash_71b423d13c228d59" == state_name)
													{
														[[ self ]]->set_data(localclientnum, "_state", 11);
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
					}
				}
			}
		}
	}

	/*
		Name: open
		Namespace: cct_shared_aar
		Checksum: 0x1F7F7E7D
		Offset: 0x570
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"ct_shared_aar");
	}

	/*
		Name: function_fa582112
		Namespace: cct_shared_aar
		Checksum: 0x903C3B6E
		Offset: 0x498
		Size: 0xCC
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "timeMilliseconds", 0);
		[[ self ]]->set_data(localclientnum, "bestTimeMilliseconds", 0);
		[[ self ]]->set_data(localclientnum, "missionResultMsg", #"");
		[[ self ]]->set_data(localclientnum, "medalThresholds", #"");
	}

	/*
		Name: function_5c1bb138
		Namespace: cct_shared_aar
		Checksum: 0xAB58DEE
		Offset: 0x468
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
		Namespace: cct_shared_aar
		Checksum: 0x12FFBB4F
		Offset: 0x350
		Size: 0x10C
		Parameters: 5
		Flags: None
	*/
	function setup_clientfields(uid, var_fa61efce, var_a2ce4dd8, var_28aefa0, var_30cfd9be)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 4, "int");
		cLUIelem::function_da693cbe("timeMilliseconds", 1, 14, "int", var_fa61efce);
		cLUIelem::function_da693cbe("bestTimeMilliseconds", 1, 14, "int", var_a2ce4dd8);
		cLUIelem::function_dcb34c80("string", "missionResultMsg", 1);
		cLUIelem::function_dcb34c80("string", "medalThresholds", 1);
	}

}

#namespace ct_shared_aar;

/*
	Name: register
	Namespace: ct_shared_aar
	Checksum: 0x6BAF0A55
	Offset: 0x108
	Size: 0x70
	Parameters: 5
	Flags: None
*/
function register(uid, var_fa61efce, var_a2ce4dd8, var_28aefa0, var_30cfd9be)
{
	elem = new cct_shared_aar();
	[[ elem ]]->setup_clientfields(uid, var_fa61efce, var_a2ce4dd8, var_28aefa0, var_30cfd9be);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: ct_shared_aar
	Checksum: 0x2039AF39
	Offset: 0x180
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cct_shared_aar();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_aar
	Checksum: 0xAECA93D2
	Offset: 0x1C8
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
	Namespace: ct_shared_aar
	Checksum: 0xBEF23E4
	Offset: 0x1F0
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
	Namespace: ct_shared_aar
	Checksum: 0x8E64B0E8
	Offset: 0x218
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
	Namespace: ct_shared_aar
	Checksum: 0xD6875125
	Offset: 0x240
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: set_timeMilliseconds
	Namespace: ct_shared_aar
	Checksum: 0xF036B1C2
	Offset: 0x270
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_timeMilliseconds(localclientnum, value)
{
	[[ self ]]->set_timeMilliseconds(localclientnum, value);
}

/*
	Name: set_bestTimeMilliseconds
	Namespace: ct_shared_aar
	Checksum: 0x75089D9
	Offset: 0x2A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bestTimeMilliseconds(localclientnum, value)
{
	[[ self ]]->set_bestTimeMilliseconds(localclientnum, value);
}

/*
	Name: set_missionResultMsg
	Namespace: ct_shared_aar
	Checksum: 0x4B732412
	Offset: 0x2D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_missionResultMsg(localclientnum, value)
{
	[[ self ]]->set_missionResultMsg(localclientnum, value);
}

/*
	Name: set_medalThresholds
	Namespace: ct_shared_aar
	Checksum: 0xCBDEC09
	Offset: 0x300
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_medalThresholds(localclientnum, value)
{
	[[ self ]]->set_medalThresholds(localclientnum, value);
}

