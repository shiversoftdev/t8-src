// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cct_progressbar_status : cluielem
{

	/*
		Name: constructor
		Namespace: cct_progressbar_status
		Checksum: 0x1E2FA6C8
		Offset: 0x1E8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cct_progressbar_status
		Checksum: 0xED15F7F8
		Offset: 0x5C8
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_state
		Namespace: cct_progressbar_status
		Checksum: 0x418B5AD4
		Offset: 0x318
		Size: 0x2A4
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
			if(#"download_complete" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"downloading" == state_name)
				{
					[[ self ]]->set_data(localclientnum, "_state", 2);
				}
				else
				{
					if(#"connection_lost" == state_name)
					{
						[[ self ]]->set_data(localclientnum, "_state", 3);
					}
					else
					{
						if(#"downloading1" == state_name)
						{
							[[ self ]]->set_data(localclientnum, "_state", 4);
						}
						else
						{
							if(#"hash_42f8a09c2e0a99e3" == state_name)
							{
								[[ self ]]->set_data(localclientnum, "_state", 5);
							}
							else
							{
								if(#"awaitingconnection" == state_name)
								{
									[[ self ]]->set_data(localclientnum, "_state", 6);
								}
								else
								{
									if(#"hash_7f00f68e42b5b8f6" == state_name)
									{
										[[ self ]]->set_data(localclientnum, "_state", 7);
									}
									else
									{
										if(#"sabotagedata" == state_name)
										{
											[[ self ]]->set_data(localclientnum, "_state", 8);
										}
										else
										{
											if(#"sabotagedata1" == state_name)
											{
												[[ self ]]->set_data(localclientnum, "_state", 9);
											}
											else
											{
												if(#"hash_7185fe2194047325" == state_name)
												{
													[[ self ]]->set_data(localclientnum, "_state", 10);
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

	/*
		Name: open
		Namespace: cct_progressbar_status
		Checksum: 0xC4F2C1E1
		Offset: 0x2E0
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"ct_progressbar_status");
	}

	/*
		Name: function_fa582112
		Namespace: cct_progressbar_status
		Checksum: 0xFC38863A
		Offset: 0x290
		Size: 0x44
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
	}

	/*
		Name: register_clientside
		Namespace: cct_progressbar_status
		Checksum: 0x6A955C2E
		Offset: 0x260
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
		Namespace: cct_progressbar_status
		Checksum: 0xDD12400F
		Offset: 0x208
		Size: 0x4C
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("_state", 1, 4, "int");
	}

}

#namespace ct_progressbar_status;

/*
	Name: register
	Namespace: ct_progressbar_status
	Checksum: 0x1C734833
	Offset: 0xB0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cct_progressbar_status();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: register_clientside
	Namespace: ct_progressbar_status
	Checksum: 0x32E56F9F
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cct_progressbar_status();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_progressbar_status
	Checksum: 0x8DA41DDF
	Offset: 0x140
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
	Namespace: ct_progressbar_status
	Checksum: 0x5613BD9E
	Offset: 0x168
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
	Namespace: ct_progressbar_status
	Checksum: 0x624474F8
	Offset: 0x190
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
	Namespace: ct_progressbar_status
	Checksum: 0xF2E3859
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

