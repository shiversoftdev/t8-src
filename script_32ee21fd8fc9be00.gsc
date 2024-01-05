// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cct_shared_desc : cluielem
{

	/*
		Name: constructor
		Namespace: cct_shared_desc
		Checksum: 0x5677727
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
		Namespace: cct_shared_desc
		Checksum: 0xF6DB3857
		Offset: 0x408
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_state
		Namespace: cct_shared_desc
		Checksum: 0xC39709D1
		Offset: 0x318
		Size: 0xE4
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
			if(#"hash_3319eaa2c590a2ac" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"hash_2ac3b79c708dcfd5" == state_name)
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
		Namespace: cct_shared_desc
		Checksum: 0x74D23105
		Offset: 0x2E0
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"ct_shared_desc");
	}

	/*
		Name: function_fa582112
		Namespace: cct_shared_desc
		Checksum: 0x8C07D54F
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
		Namespace: cct_shared_desc
		Checksum: 0x8F17F6E6
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
		Namespace: cct_shared_desc
		Checksum: 0x24C04009
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

#namespace ct_shared_desc;

/*
	Name: register
	Namespace: ct_shared_desc
	Checksum: 0xBB4E31E5
	Offset: 0xB0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cct_shared_desc();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: register_clientside
	Namespace: ct_shared_desc
	Checksum: 0x3CC1832E
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cct_shared_desc();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_desc
	Checksum: 0x69678B99
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
	Namespace: ct_shared_desc
	Checksum: 0x2FF7B883
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
	Namespace: ct_shared_desc
	Checksum: 0xDF764D0A
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
	Namespace: ct_shared_desc
	Checksum: 0xE3AC16B
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

