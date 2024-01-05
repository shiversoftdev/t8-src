// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class cinsertion_passenger_count : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cinsertion_passenger_count
		Checksum: 0x1B896CD7
		Offset: 0x1D8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cinsertion_passenger_count
		Checksum: 0x80C99C31
		Offset: 0x318
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_count
		Namespace: cinsertion_passenger_count
		Checksum: 0xACA037B0
		Offset: 0x2D0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_count(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "count", value);
	}

	/*
		Name: close
		Namespace: cinsertion_passenger_count
		Checksum: 0x659F47EB
		Offset: 0x2A0
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cluielem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cinsertion_passenger_count
		Checksum: 0xECB542A8
		Offset: 0x250
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "insertion_passenger_count", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cinsertion_passenger_count
		Checksum: 0x8D63D486
		Offset: 0x1F8
		Size: 0x4C
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("count", 1, 7, "int");
	}

}

#namespace insertion_passenger_count;

/*
	Name: register
	Namespace: insertion_passenger_count
	Checksum: 0x30FA9321
	Offset: 0xD0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cinsertion_passenger_count();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: insertion_passenger_count
	Checksum: 0x3632857B
	Offset: 0x118
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: insertion_passenger_count
	Checksum: 0xF4EEFAEE
	Offset: 0x158
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
	Checksum: 0xF01F1BB0
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_count
	Namespace: insertion_passenger_count
	Checksum: 0xBD9D5281
	Offset: 0x1A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_count(player, value)
{
	[[ self ]]->set_count(player, value);
}

