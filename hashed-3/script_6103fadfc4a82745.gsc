// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_e5d48e46 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_e5d48e46
		Checksum: 0x17567AB1
		Offset: 0x1C8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_e5d48e46
		Checksum: 0x6F82F3C6
		Offset: 0x300
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_693a2be8
		Namespace: namespace_e5d48e46
		Checksum: 0x86C117DA
		Offset: 0x2C0
		Size: 0x34
		Parameters: 1
		Flags: Linked
	*/
	function function_693a2be8(player)
	{
		player clientfield::function_bb878fc3(var_47e79fc, "pulse");
	}

	/*
		Name: close
		Namespace: namespace_e5d48e46
		Checksum: 0x4E07157C
		Offset: 0x290
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
		Namespace: namespace_e5d48e46
		Checksum: 0x46D70449
		Offset: 0x240
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "scavenger_icon", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_e5d48e46
		Checksum: 0x1839F8E1
		Offset: 0x1E8
		Size: 0x4C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("pulse", 1, 1, "counter");
	}

}

#namespace scavenger_icon;

/*
	Name: register
	Namespace: scavenger_icon
	Checksum: 0x4C9B8AB9
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new class_e5d48e46();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: scavenger_icon
	Checksum: 0x92CD2583
	Offset: 0x110
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
	Namespace: scavenger_icon
	Checksum: 0xC5B8B9E0
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
	Namespace: scavenger_icon
	Checksum: 0x687FD122
	Offset: 0x178
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_693a2be8
	Namespace: scavenger_icon
	Checksum: 0x4173E362
	Offset: 0x1A0
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_693a2be8(player)
{
	[[ self ]]->function_693a2be8(player);
}

