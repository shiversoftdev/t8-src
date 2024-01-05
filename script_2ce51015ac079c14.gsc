// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cplayer_insertion_choice : cluielem
{

	/*
		Name: constructor
		Namespace: cplayer_insertion_choice
		Checksum: 0x693B4085
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
		Namespace: cplayer_insertion_choice
		Checksum: 0x1A8F02DF
		Offset: 0x440
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_state
		Namespace: cplayer_insertion_choice
		Checksum: 0x5AA0A3AD
		Offset: 0x318
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
			if(#"groundvehicle" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"halojump" == state_name)
				{
					[[ self ]]->set_data(localclientnum, "_state", 2);
				}
				else
				{
					if(#"heli" == state_name)
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
		Namespace: cplayer_insertion_choice
		Checksum: 0xA447DE09
		Offset: 0x2E0
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"player_insertion_choice");
	}

	/*
		Name: function_fa582112
		Namespace: cplayer_insertion_choice
		Checksum: 0xF5C7A3B6
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
		Namespace: cplayer_insertion_choice
		Checksum: 0x3EDCE539
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
		Namespace: cplayer_insertion_choice
		Checksum: 0xCDD77E2B
		Offset: 0x208
		Size: 0x4C
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("_state", 1, 2, "int");
	}

}

#namespace player_insertion_choice;

/*
	Name: register
	Namespace: player_insertion_choice
	Checksum: 0x25C4ABF7
	Offset: 0xB0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cplayer_insertion_choice();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: register_clientside
	Namespace: player_insertion_choice
	Checksum: 0xD29C4C4
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cplayer_insertion_choice();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: player_insertion_choice
	Checksum: 0x9C60B9EE
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
	Namespace: player_insertion_choice
	Checksum: 0xD97CEFA7
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
	Namespace: player_insertion_choice
	Checksum: 0xCA8D7C01
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
	Namespace: player_insertion_choice
	Checksum: 0xFD3836D5
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

