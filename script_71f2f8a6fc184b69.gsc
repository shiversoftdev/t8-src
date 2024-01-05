// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cinsertion_passenger_count : cluielem
{

	/*
		Name: constructor
		Namespace: cinsertion_passenger_count
		Checksum: 0x4F07467
		Offset: 0x1F0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cinsertion_passenger_count
		Checksum: 0xBE7D7DAA
		Offset: 0x358
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_count
		Namespace: cinsertion_passenger_count
		Checksum: 0x2966892C
		Offset: 0x320
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_count(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "count", value);
	}

	/*
		Name: open
		Namespace: cinsertion_passenger_count
		Checksum: 0x515377C3
		Offset: 0x2E8
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"insertion_passenger_count");
	}

	/*
		Name: function_fa582112
		Namespace: cinsertion_passenger_count
		Checksum: 0xFFE3B3DB
		Offset: 0x2A0
		Size: 0x40
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "count", 0);
	}

	/*
		Name: register_clientside
		Namespace: cinsertion_passenger_count
		Checksum: 0x2A2CFAAF
		Offset: 0x270
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
		Namespace: cinsertion_passenger_count
		Checksum: 0x75B74D01
		Offset: 0x210
		Size: 0x54
		Parameters: 2
		Flags: Linked
	*/
	function setup_clientfields(uid, var_fbcc4763)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("count", 1, 7, "int", var_fbcc4763);
	}

}

#namespace insertion_passenger_count;

/*
	Name: register
	Namespace: insertion_passenger_count
	Checksum: 0x17DB45A3
	Offset: 0xA8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_fbcc4763)
{
	elem = new cinsertion_passenger_count();
	[[ elem ]]->setup_clientfields(uid, var_fbcc4763);
	return elem;
}

/*
	Name: register_clientside
	Namespace: insertion_passenger_count
	Checksum: 0x7F774449
	Offset: 0x100
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cinsertion_passenger_count();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: insertion_passenger_count
	Checksum: 0xB2C98BB5
	Offset: 0x148
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
	Namespace: insertion_passenger_count
	Checksum: 0xAD6ABCF6
	Offset: 0x170
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
	Namespace: insertion_passenger_count
	Checksum: 0xA9D3CCED
	Offset: 0x198
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_count
	Namespace: insertion_passenger_count
	Checksum: 0x99E6EAC4
	Offset: 0x1C0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_count(localclientnum, value)
{
	[[ self ]]->set_count(localclientnum, value);
}

