// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_towers_crowd_meter : cLUIelem
{

	/*
		Name: constructor
		Namespace: czm_towers_crowd_meter
		Checksum: 0x8664627D
		Offset: 0x230
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_towers_crowd_meter
		Checksum: 0x4CE8482B
		Offset: 0x6C8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_visible
		Namespace: czm_towers_crowd_meter
		Checksum: 0xD6858549
		Offset: 0x690
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_visible(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "visible", value);
	}

	/*
		Name: set_state
		Namespace: czm_towers_crowd_meter
		Checksum: 0xE7951BD4
		Offset: 0x3A8
		Size: 0x2DC
		Parameters: 2
		Flags: Linked
	*/
	function set_state(localclientnum, state_name)
	{
		if(#"defaultstate" == state_name)
		{
			[[ self ]]->set_data(localclientnum, "_state", 0);
		}
		else
		{
			if(#"hash_2b0516887b8c733" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"crowd_loathes" == state_name)
				{
					[[ self ]]->set_data(localclientnum, "_state", 2);
				}
				else
				{
					if(#"crowd_hates" == state_name)
					{
						[[ self ]]->set_data(localclientnum, "_state", 3);
					}
					else
					{
						if(#"crowd_no_love" == state_name)
						{
							[[ self ]]->set_data(localclientnum, "_state", 4);
						}
						else
						{
							if(#"crowd_warm_up" == state_name)
							{
								[[ self ]]->set_data(localclientnum, "_state", 5);
							}
							else
							{
								if(#"crowd_likes" == state_name)
								{
									[[ self ]]->set_data(localclientnum, "_state", 6);
								}
								else
								{
									if(#"crowd_loves" == state_name)
									{
										[[ self ]]->set_data(localclientnum, "_state", 7);
									}
									else
									{
										if(#"crowd_power_up_available_good" == state_name)
										{
											[[ self ]]->set_data(localclientnum, "_state", 8);
										}
										else
										{
											if(#"crowd_power_up_available_bad" == state_name)
											{
												[[ self ]]->set_data(localclientnum, "_state", 9);
											}
											else
											{
												if(#"crowd_power_up_available_good_partial" == state_name)
												{
													[[ self ]]->set_data(localclientnum, "_state", 10);
												}
												else
												{
													if(#"crowd_power_up_available_bad_partial" == state_name)
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
		Namespace: czm_towers_crowd_meter
		Checksum: 0x1CC81DB2
		Offset: 0x370
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"zm_towers_crowd_meter");
	}

	/*
		Name: function_fa582112
		Namespace: czm_towers_crowd_meter
		Checksum: 0x2A4CBC0B
		Offset: 0x308
		Size: 0x60
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "visible", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: czm_towers_crowd_meter
		Checksum: 0xCD390F97
		Offset: 0x2D8
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		cLUIelem::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_towers_crowd_meter
		Checksum: 0xCE367597
		Offset: 0x250
		Size: 0x7C
		Parameters: 2
		Flags: Linked
	*/
	function setup_clientfields(uid, var_6ad1a3bb)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 4, "int");
		cLUIelem::function_da693cbe("visible", 1, 1, "int", var_6ad1a3bb);
	}

}

#namespace zm_towers_crowd_meter;

/*
	Name: register
	Namespace: zm_towers_crowd_meter
	Checksum: 0xF81AB299
	Offset: 0xB8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_6ad1a3bb)
{
	elem = new czm_towers_crowd_meter();
	[[ elem ]]->setup_clientfields(uid, var_6ad1a3bb);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_towers_crowd_meter
	Checksum: 0xECDAC24
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new czm_towers_crowd_meter();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_crowd_meter
	Checksum: 0xFD22EAE5
	Offset: 0x158
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
	Namespace: zm_towers_crowd_meter
	Checksum: 0x57F33C7F
	Offset: 0x180
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
	Namespace: zm_towers_crowd_meter
	Checksum: 0x403FE8A
	Offset: 0x1A8
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
	Namespace: zm_towers_crowd_meter
	Checksum: 0x5D4D4467
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: set_visible
	Namespace: zm_towers_crowd_meter
	Checksum: 0xEF530CC4
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_visible(localclientnum, value)
{
	[[ self ]]->set_visible(localclientnum, value);
}

