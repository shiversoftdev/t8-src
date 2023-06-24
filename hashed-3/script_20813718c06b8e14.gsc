// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cct_timer_mod_ticks : cLUIelem
{

	/*
		Name: constructor
		Namespace: cct_timer_mod_ticks
		Checksum: 0x4FFBA72A
		Offset: 0x230
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cct_timer_mod_ticks
		Checksum: 0x4A621EB6
		Offset: 0x5B0
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_timeMod
		Namespace: cct_timer_mod_ticks
		Checksum: 0xF44FD624
		Offset: 0x578
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_timeMod(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "timeMod", value);
	}

	/*
		Name: set_state
		Namespace: cct_timer_mod_ticks
		Checksum: 0x593A9C9E
		Offset: 0x3A8
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
			if(#"plus" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"minus" == state_name)
				{
					[[ self ]]->set_data(localclientnum, "_state", 2);
				}
				else
				{
					if(#"plus_destroyedobj" == state_name)
					{
						[[ self ]]->set_data(localclientnum, "_state", 3);
					}
					else
					{
						if(#"plus_dogkill" == state_name)
						{
							[[ self ]]->set_data(localclientnum, "_state", 4);
						}
						else
						{
							if(#"hash_654551b30d95836c" == state_name)
							{
								[[ self ]]->set_data(localclientnum, "_state", 5);
							}
							else
							{
								if(#"plus_multikill" == state_name)
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
		Namespace: cct_timer_mod_ticks
		Checksum: 0x3856A1CD
		Offset: 0x370
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"ct_timer_mod_ticks");
	}

	/*
		Name: function_fa582112
		Namespace: cct_timer_mod_ticks
		Checksum: 0xE97E35B5
		Offset: 0x308
		Size: 0x60
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "timeMod", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cct_timer_mod_ticks
		Checksum: 0x23DA378C
		Offset: 0x2D8
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
		Namespace: cct_timer_mod_ticks
		Checksum: 0x24B36FF5
		Offset: 0x250
		Size: 0x7C
		Parameters: 2
		Flags: None
	*/
	function setup_clientfields(uid, var_2b2f0c89)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 3, "int");
		cLUIelem::function_da693cbe("timeMod", 1, 6, "int", var_2b2f0c89);
	}

}

#namespace ct_timer_mod_ticks;

/*
	Name: register
	Namespace: ct_timer_mod_ticks
	Checksum: 0x7D853C59
	Offset: 0xB8
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_2b2f0c89)
{
	elem = new cct_timer_mod_ticks();
	[[ elem ]]->setup_clientfields(uid, var_2b2f0c89);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: ct_timer_mod_ticks
	Checksum: 0xDB8F4D7F
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cct_timer_mod_ticks();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_timer_mod_ticks
	Checksum: 0xF00DE01B
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
	Namespace: ct_timer_mod_ticks
	Checksum: 0x82E5F13C
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
	Namespace: ct_timer_mod_ticks
	Checksum: 0x615C3B8D
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
	Namespace: ct_timer_mod_ticks
	Checksum: 0xAFA1A19
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
	Name: set_timeMod
	Namespace: ct_timer_mod_ticks
	Checksum: 0x79C8F290
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_timeMod(localclientnum, value)
{
	[[ self ]]->set_timeMod(localclientnum, value);
}

