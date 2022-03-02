// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_d596aaaa : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_d596aaaa
		Checksum: 0x290E66B0
		Offset: 0x1D0
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_d596aaaa
		Checksum: 0x75D4ADFA
		Offset: 0x310
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_3684f146
		Namespace: namespace_d596aaaa
		Checksum: 0x5C61B4
		Offset: 0x2C8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_3684f146(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "key_count", value);
	}

	/*
		Name: close
		Namespace: namespace_d596aaaa
		Checksum: 0x1541A95E
		Offset: 0x298
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_d596aaaa
		Checksum: 0x8B56151E
		Offset: 0x248
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "zm_arcade_keys", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_d596aaaa
		Checksum: 0x8FC351E0
		Offset: 0x1F0
		Size: 0x4C
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("key_count", 1, 4, "int");
	}

}

#namespace zm_arcade_keys;

/*
	Name: register
	Namespace: zm_arcade_keys
	Checksum: 0x278C3F92
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_d596aaaa();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_arcade_keys
	Checksum: 0x88C54E08
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
	Namespace: zm_arcade_keys
	Checksum: 0xCE00D88C
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
	Namespace: zm_arcade_keys
	Checksum: 0xDD731BF1
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
	Name: function_3684f146
	Namespace: zm_arcade_keys
	Checksum: 0xA212BB4E
	Offset: 0x1A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3684f146(player, value)
{
	[[ self ]]->function_3684f146(player, value);
}

