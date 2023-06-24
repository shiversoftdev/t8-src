// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_game_over : cLUIelem
{

	/*
		Name: constructor
		Namespace: czm_game_over
		Checksum: 0x3D67B3F7
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
		Namespace: czm_game_over
		Checksum: 0x39E2C2B0
		Offset: 0x498
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_rounds
		Namespace: czm_game_over
		Checksum: 0x6C3857F
		Offset: 0x460
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_rounds(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "rounds", value);
	}

	/*
		Name: set_state
		Namespace: czm_game_over
		Checksum: 0x5D583DA3
		Offset: 0x3A8
		Size: 0xAC
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
			if(#"gatewayopened" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
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
		Namespace: czm_game_over
		Checksum: 0x71B81B92
		Offset: 0x370
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"zm_game_over");
	}

	/*
		Name: function_fa582112
		Namespace: czm_game_over
		Checksum: 0x22E8D048
		Offset: 0x308
		Size: 0x60
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "rounds", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: czm_game_over
		Checksum: 0x26D0C695
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
		Namespace: czm_game_over
		Checksum: 0x36A6D6B2
		Offset: 0x250
		Size: 0x7C
		Parameters: 2
		Flags: Linked
	*/
	function setup_clientfields(uid, var_ddbc37b7)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 1, "int");
		cLUIelem::function_da693cbe("rounds", 1, 8, "int", var_ddbc37b7);
	}

}

#namespace zm_game_over;

/*
	Name: register
	Namespace: zm_game_over
	Checksum: 0x434D8DF
	Offset: 0xB8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_ddbc37b7)
{
	elem = new czm_game_over();
	[[ elem ]]->setup_clientfields(uid, var_ddbc37b7);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_game_over
	Checksum: 0x3A0E1A2C
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new czm_game_over();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_game_over
	Checksum: 0x31A5580F
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
	Namespace: zm_game_over
	Checksum: 0x69393CFE
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
	Namespace: zm_game_over
	Checksum: 0x99111D29
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
	Namespace: zm_game_over
	Checksum: 0x475AA62
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
	Name: set_rounds
	Namespace: zm_game_over
	Checksum: 0x43F67659
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_rounds(localclientnum, value)
{
	[[ self ]]->set_rounds(localclientnum, value);
}

