// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_af345a5f : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_af345a5f
		Checksum: 0xB4E2EFD1
		Offset: 0x260
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_af345a5f
		Checksum: 0xA77E0280
		Offset: 0x480
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_65194707
		Namespace: namespace_af345a5f
		Checksum: 0x2AA94CE6
		Offset: 0x438
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_65194707(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "num_downs", value);
	}

	/*
		Name: function_d50fdde9
		Namespace: namespace_af345a5f
		Checksum: 0x31EB79AB
		Offset: 0x3F0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_d50fdde9(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "revive_progress", value);
	}

	/*
		Name: function_67bdfe40
		Namespace: namespace_af345a5f
		Checksum: 0x7F8BCE4F
		Offset: 0x3A8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_67bdfe40(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "bleedout_progress", value);
	}

	/*
		Name: close
		Namespace: namespace_af345a5f
		Checksum: 0x9CD1480D
		Offset: 0x378
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
		Namespace: namespace_af345a5f
		Checksum: 0x722B5FF3
		Offset: 0x328
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "zm_laststand_client", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_af345a5f
		Checksum: 0x23772C
		Offset: 0x280
		Size: 0x9C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("bleedout_progress", 1, 6, "float");
		namespace_6aaccc24::function_da693cbe("revive_progress", 1, 5, "float");
		namespace_6aaccc24::function_da693cbe("num_downs", 1, 8, "int");
	}

}

#namespace zm_laststand_client;

/*
	Name: register
	Namespace: zm_laststand_client
	Checksum: 0x1C64CAF
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new class_af345a5f();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_laststand_client
	Checksum: 0xD41F7363
	Offset: 0x140
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
	Namespace: zm_laststand_client
	Checksum: 0xE30331E
	Offset: 0x180
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
	Namespace: zm_laststand_client
	Checksum: 0xF9FF5B8A
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_67bdfe40
	Namespace: zm_laststand_client
	Checksum: 0xA6CE9A48
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_67bdfe40(player, value)
{
	[[ self ]]->function_67bdfe40(player, value);
}

/*
	Name: function_d50fdde9
	Namespace: zm_laststand_client
	Checksum: 0x2C1A498A
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_d50fdde9(player, value)
{
	[[ self ]]->function_d50fdde9(player, value);
}

/*
	Name: function_65194707
	Namespace: zm_laststand_client
	Checksum: 0x66B06DC2
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_65194707(player, value)
{
	[[ self ]]->function_65194707(player, value);
}

