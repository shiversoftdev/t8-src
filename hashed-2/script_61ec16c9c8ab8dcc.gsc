// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class clower_message : cLUIelem
{

	/*
		Name: constructor
		Namespace: clower_message
		Checksum: 0xCC7571C3
		Offset: 0x288
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: clower_message
		Checksum: 0x878B6A4D
		Offset: 0x5B8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_countdownTimeSeconds
		Namespace: clower_message
		Checksum: 0xBB90478D
		Offset: 0x580
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_countdownTimeSeconds(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "countdownTimeSeconds", value);
	}

	/*
		Name: set_message
		Namespace: clower_message
		Checksum: 0xD86F47BE
		Offset: 0x548
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_message(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "message", value);
	}

	/*
		Name: set_state
		Namespace: clower_message
		Checksum: 0xD573B218
		Offset: 0x458
		Size: 0xE4
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
			if(#"visible" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"hash_45bfcb1cd8c9b50a" == state_name)
				{
					[[ self ]]->set_data(localclientnum, "_state", 2);
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

	/*
		Name: open
		Namespace: clower_message
		Checksum: 0x46AF73A2
		Offset: 0x420
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"lower_message");
	}

	/*
		Name: function_fa582112
		Namespace: clower_message
		Checksum: 0xFCBB23D0
		Offset: 0x390
		Size: 0x88
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "message", #"");
		[[ self ]]->set_data(localclientnum, "countdownTimeSeconds", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: clower_message
		Checksum: 0x28C8FC2F
		Offset: 0x360
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
		Namespace: clower_message
		Checksum: 0x8753D1C6
		Offset: 0x2A8
		Size: 0xAC
		Parameters: 3
		Flags: Linked
	*/
	function setup_clientfields(uid, var_9af44e2b, var_7a5253d3)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 2, "int");
		cLUIelem::function_dcb34c80("string", "message", 1);
		cLUIelem::function_da693cbe("countdownTimeSeconds", 1, 5, "int", var_7a5253d3);
	}

}

#namespace lower_message;

/*
	Name: register
	Namespace: lower_message
	Checksum: 0x2FB6D8F
	Offset: 0xD8
	Size: 0x58
	Parameters: 3
	Flags: Linked
*/
function register(uid, var_9af44e2b, var_7a5253d3)
{
	elem = new clower_message();
	[[ elem ]]->setup_clientfields(uid, var_9af44e2b, var_7a5253d3);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: lower_message
	Checksum: 0x407355B7
	Offset: 0x138
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new clower_message();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: lower_message
	Checksum: 0x45D35D8E
	Offset: 0x180
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
	Namespace: lower_message
	Checksum: 0x1CC53293
	Offset: 0x1A8
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
	Namespace: lower_message
	Checksum: 0xCE69B8E2
	Offset: 0x1D0
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
	Namespace: lower_message
	Checksum: 0x6E001BF4
	Offset: 0x1F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: set_message
	Namespace: lower_message
	Checksum: 0x315923C0
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_message(localclientnum, value)
{
	[[ self ]]->set_message(localclientnum, value);
}

/*
	Name: set_countdownTimeSeconds
	Namespace: lower_message
	Checksum: 0xD36CFBB8
	Offset: 0x258
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_countdownTimeSeconds(localclientnum, value)
{
	[[ self ]]->set_countdownTimeSeconds(localclientnum, value);
}

