// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_9f4bb53a : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_9f4bb53a
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
		Namespace: namespace_9f4bb53a
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
		Name: function_18a028a3
		Namespace: namespace_9f4bb53a
		Checksum: 0xBB90478D
		Offset: 0x580
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_18a028a3(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "countdownTimeSeconds", value);
	}

	/*
		Name: function_cd1b9801
		Namespace: namespace_9f4bb53a
		Checksum: 0xD86F47BE
		Offset: 0x548
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_cd1b9801(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "message", value);
	}

	/*
		Name: set_state
		Namespace: namespace_9f4bb53a
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
			[[ self ]]->function_d7d2fcce(localclientnum, "_state", 0);
		}
		else
		{
			if(#"visible" == state_name)
			{
				[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
			}
			else
			{
				if(#"hash_45bfcb1cd8c9b50a" == state_name)
				{
					[[ self ]]->function_d7d2fcce(localclientnum, "_state", 2);
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
		Namespace: namespace_9f4bb53a
		Checksum: 0x46AF73A2
		Offset: 0x420
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"lower_message");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_9f4bb53a
		Checksum: 0xFCBB23D0
		Offset: 0x390
		Size: 0x88
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->function_d7d2fcce(localclientnum, "message", #"");
		[[ self ]]->function_d7d2fcce(localclientnum, "countdownTimeSeconds", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_9f4bb53a
		Checksum: 0x28C8FC2F
		Offset: 0x360
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
		Namespace: namespace_9f4bb53a
		Checksum: 0x8753D1C6
		Offset: 0x2A8
		Size: 0xAC
		Parameters: 3
		Flags: Linked
	*/
	function setup_clientfields(uid, var_9af44e2b, var_7a5253d3)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("_state", 1, 2, "int");
		namespace_6aaccc24::function_dcb34c80("string", "message", 1);
		namespace_6aaccc24::function_da693cbe("countdownTimeSeconds", 1, 5, "int", var_7a5253d3);
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
	elem = new class_9f4bb53a();
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
	elem = new class_9f4bb53a();
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
	Name: function_cd1b9801
	Namespace: lower_message
	Checksum: 0x315923C0
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_cd1b9801(localclientnum, value)
{
	[[ self ]]->function_cd1b9801(localclientnum, value);
}

/*
	Name: function_18a028a3
	Namespace: lower_message
	Checksum: 0xD36CFBB8
	Offset: 0x258
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_18a028a3(localclientnum, value)
{
	[[ self ]]->function_18a028a3(localclientnum, value);
}

