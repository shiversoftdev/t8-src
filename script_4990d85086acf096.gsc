// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_location : cluielem
{

	/*
		Name: constructor
		Namespace: czm_location
		Checksum: 0x144846DD
		Offset: 0x200
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_location
		Checksum: 0xA5AF63B2
		Offset: 0x378
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_location_name
		Namespace: czm_location
		Checksum: 0xC2786A25
		Offset: 0x340
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_location_name(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "location_name", value);
	}

	/*
		Name: open
		Namespace: czm_location
		Checksum: 0x7F36AFBE
		Offset: 0x308
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"zm_location");
	}

	/*
		Name: function_fa582112
		Namespace: czm_location
		Checksum: 0xBDB01B95
		Offset: 0x2B0
		Size: 0x4C
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "location_name", #"");
	}

	/*
		Name: register_clientside
		Namespace: czm_location
		Checksum: 0xD11D3009
		Offset: 0x280
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_location
		Checksum: 0x27606F78
		Offset: 0x220
		Size: 0x54
		Parameters: 2
		Flags: Linked
	*/
	function setup_clientfields(uid, var_5c0f4d11)
	{
		cluielem::setup_clientfields(uid);
		cluielem::function_dcb34c80("string", "location_name", 1);
	}

}

#namespace zm_location;

/*
	Name: register
	Namespace: zm_location
	Checksum: 0xE89A82EA
	Offset: 0xB8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_5c0f4d11)
{
	elem = new czm_location();
	[[ elem ]]->setup_clientfields(uid, var_5c0f4d11);
	return elem;
}

/*
	Name: register_clientside
	Namespace: zm_location
	Checksum: 0x61FDE613
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new czm_location();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_location
	Checksum: 0x938DD70F
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
	Namespace: zm_location
	Checksum: 0x520174B5
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
	Namespace: zm_location
	Checksum: 0x8063A3D6
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
	Name: set_location_name
	Namespace: zm_location
	Checksum: 0x8D484312
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_location_name(localclientnum, value)
{
	[[ self ]]->set_location_name(localclientnum, value);
}

