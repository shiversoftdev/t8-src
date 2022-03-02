// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_b7f44132 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_b7f44132
		Checksum: 0xF992259F
		Offset: 0x210
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_b7f44132
		Checksum: 0xE9A390EA
		Offset: 0x3C0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_7f5a9fed
		Namespace: namespace_b7f44132
		Checksum: 0x1C0D9C0F
		Offset: 0x378
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_7f5a9fed(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "isAlive", value);
	}

	/*
		Name: function_3b7b386a
		Namespace: namespace_b7f44132
		Checksum: 0x1DD15873
		Offset: 0x330
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_3b7b386a(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "clientnum", value);
	}

	/*
		Name: close
		Namespace: namespace_b7f44132
		Checksum: 0x9E112E61
		Offset: 0x300
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
		Namespace: namespace_b7f44132
		Checksum: 0x53F7AD35
		Offset: 0x2B0
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "SpectreRisingIndicator", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_b7f44132
		Checksum: 0x1B16609F
		Offset: 0x230
		Size: 0x74
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("clientnum", 1, 7, "int");
		namespace_6aaccc24::function_da693cbe("isAlive", 1, 1, "int");
	}

}

#namespace spectrerisingindicator;

/*
	Name: register
	Namespace: spectrerisingindicator
	Checksum: 0xB86BBF16
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new class_b7f44132();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: spectrerisingindicator
	Checksum: 0x4C7439EB
	Offset: 0x120
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
	Namespace: spectrerisingindicator
	Checksum: 0xD19B3746
	Offset: 0x160
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
	Namespace: spectrerisingindicator
	Checksum: 0x1A0B48DB
	Offset: 0x188
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_3b7b386a
	Namespace: spectrerisingindicator
	Checksum: 0xF82BBD76
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_3b7b386a(player, value)
{
	[[ self ]]->function_3b7b386a(player, value);
}

/*
	Name: function_7f5a9fed
	Namespace: spectrerisingindicator
	Checksum: 0x9A235B41
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_7f5a9fed(player, value)
{
	[[ self ]]->function_7f5a9fed(player, value);
}

