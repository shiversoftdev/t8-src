// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_ec0fbe79 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_ec0fbe79
		Checksum: 0xD449F9F4
		Offset: 0x1D8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_ec0fbe79
		Checksum: 0x1E5FCA3E
		Offset: 0x318
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_e967988b
		Namespace: namespace_ec0fbe79
		Checksum: 0x2828A4D
		Offset: 0x2D0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_e967988b(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "location_name", value);
	}

	/*
		Name: close
		Namespace: namespace_ec0fbe79
		Checksum: 0xB9850192
		Offset: 0x2A0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_ec0fbe79
		Checksum: 0xCB8DE962
		Offset: 0x250
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "zm_location", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_ec0fbe79
		Checksum: 0x8DC2E22C
		Offset: 0x1F8
		Size: 0x4C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_dcb34c80("string", "location_name", 1);
	}

}

#namespace zm_location;

/*
	Name: register
	Namespace: zm_location
	Checksum: 0x7C862202
	Offset: 0xD0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new class_ec0fbe79();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_location
	Checksum: 0x5BE47CEA
	Offset: 0x118
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: zm_location
	Checksum: 0x671B2C7C
	Offset: 0x158
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: zm_location
	Checksum: 0xCF1407A2
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_e967988b
	Namespace: zm_location
	Checksum: 0x8C44B296
	Offset: 0x1A8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_e967988b(player, value)
{
	[[ self ]]->function_e967988b(player, value);
}

