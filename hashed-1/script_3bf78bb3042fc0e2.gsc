// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_28a7d65d : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_28a7d65d
		Checksum: 0x4F5C71E1
		Offset: 0x1D0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_28a7d65d
		Checksum: 0x961D0714
		Offset: 0x310
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_459465a
		Namespace: namespace_28a7d65d
		Checksum: 0xC0D82E
		Offset: 0x2C8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_459465a(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "percent", value);
	}

	/*
		Name: close
		Namespace: namespace_28a7d65d
		Checksum: 0x53B71BE3
		Offset: 0x298
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
		Namespace: namespace_28a7d65d
		Checksum: 0x65556246
		Offset: 0x248
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "self_respawn", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_28a7d65d
		Checksum: 0x144FE2DF
		Offset: 0x1F0
		Size: 0x4C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("percent", 4000, 6, "float");
	}

}

#namespace self_respawn;

/*
	Name: register
	Namespace: self_respawn
	Checksum: 0x50E1B8B
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_28a7d65d();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_respawn
	Checksum: 0x4657DD92
	Offset: 0x110
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
	Namespace: self_respawn
	Checksum: 0x7B4B45B9
	Offset: 0x150
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
	Namespace: self_respawn
	Checksum: 0x4EAD0D56
	Offset: 0x178
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_459465a
	Namespace: self_respawn
	Checksum: 0x592A5FBC
	Offset: 0x1A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_459465a(player, value)
{
	[[ self ]]->function_459465a(player, value);
}

