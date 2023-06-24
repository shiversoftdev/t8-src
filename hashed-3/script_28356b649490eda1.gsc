// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cvehicleturretoverheat : cLUIelem
{

	/*
		Name: constructor
		Namespace: cvehicleturretoverheat
		Checksum: 0xB0D92252
		Offset: 0x238
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cvehicleturretoverheat
		Checksum: 0x5A7082D3
		Offset: 0x4A8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_bar_percent
		Namespace: cvehicleturretoverheat
		Checksum: 0x38F34591
		Offset: 0x470
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_bar_percent(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bar_percent", value);
	}

	/*
		Name: set_state
		Namespace: cvehicleturretoverheat
		Checksum: 0xB0B459A4
		Offset: 0x3B8
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
			if(#"overheat" == state_name)
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
		Namespace: cvehicleturretoverheat
		Checksum: 0xAB228B31
		Offset: 0x380
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"vehicleturretoverheat");
	}

	/*
		Name: function_fa582112
		Namespace: cvehicleturretoverheat
		Checksum: 0x21811193
		Offset: 0x310
		Size: 0x68
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "bar_percent", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cvehicleturretoverheat
		Checksum: 0xA474A7F8
		Offset: 0x2E0
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
		Namespace: cvehicleturretoverheat
		Checksum: 0xCDCD568A
		Offset: 0x258
		Size: 0x7C
		Parameters: 2
		Flags: Linked
	*/
	function setup_clientfields(uid, var_661989d5)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 1, "int");
		cLUIelem::function_da693cbe("bar_percent", 4000, 6, "float", var_661989d5);
	}

}

#namespace vehicleturretoverheat;

/*
	Name: register
	Namespace: vehicleturretoverheat
	Checksum: 0x262673DA
	Offset: 0xC0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_661989d5)
{
	elem = new cvehicleturretoverheat();
	[[ elem ]]->setup_clientfields(uid, var_661989d5);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: vehicleturretoverheat
	Checksum: 0x3A57C5B5
	Offset: 0x118
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cvehicleturretoverheat();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: vehicleturretoverheat
	Checksum: 0xDB3BDBDD
	Offset: 0x160
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
	Namespace: vehicleturretoverheat
	Checksum: 0xEBCEA365
	Offset: 0x188
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
	Namespace: vehicleturretoverheat
	Checksum: 0xB3EEBC47
	Offset: 0x1B0
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
	Namespace: vehicleturretoverheat
	Checksum: 0x6CC4F1FB
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: set_bar_percent
	Namespace: vehicleturretoverheat
	Checksum: 0x6B997AD2
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bar_percent(localclientnum, value)
{
	[[ self ]]->set_bar_percent(localclientnum, value);
}

