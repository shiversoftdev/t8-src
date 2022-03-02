// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_2051697f : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_2051697f
		Checksum: 0x58440466
		Offset: 0x298
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_2051697f
		Checksum: 0xA7CF1CC
		Offset: 0x528
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_b6ec93fa
		Namespace: namespace_2051697f
		Checksum: 0x48780F9D
		Offset: 0x4E0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_b6ec93fa(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "odin_acquired", value);
	}

	/*
		Name: function_8a094f25
		Namespace: namespace_2051697f
		Checksum: 0xB2E3EEFC
		Offset: 0x498
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_8a094f25(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "zeus_acquired", value);
	}

	/*
		Name: function_bd5da28f
		Namespace: namespace_2051697f
		Checksum: 0x5BEE22C6
		Offset: 0x450
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_bd5da28f(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "ra_acquired", value);
	}

	/*
		Name: function_eda3959a
		Namespace: namespace_2051697f
		Checksum: 0x343E20DE
		Offset: 0x408
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_eda3959a(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "danu_acquired", value);
	}

	/*
		Name: close
		Namespace: namespace_2051697f
		Checksum: 0xFDEFABBE
		Offset: 0x3D8
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
		Namespace: namespace_2051697f
		Checksum: 0x6F3BD843
		Offset: 0x388
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "zm_towers_pap_hud", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_2051697f
		Checksum: 0x8E6378A7
		Offset: 0x2B8
		Size: 0xC4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("danu_acquired", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("ra_acquired", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("zeus_acquired", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("odin_acquired", 1, 1, "int");
	}

}

#namespace zm_towers_pap_hud;

/*
	Name: register
	Namespace: zm_towers_pap_hud
	Checksum: 0x81CC59FD
	Offset: 0x100
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_2051697f();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_pap_hud
	Checksum: 0xFD5D22E8
	Offset: 0x148
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
	Namespace: zm_towers_pap_hud
	Checksum: 0xA6177E61
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
	Namespace: zm_towers_pap_hud
	Checksum: 0x2102F99C
	Offset: 0x1B0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_eda3959a
	Namespace: zm_towers_pap_hud
	Checksum: 0x1DD72F4A
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_eda3959a(player, value)
{
	[[ self ]]->function_eda3959a(player, value);
}

/*
	Name: function_bd5da28f
	Namespace: zm_towers_pap_hud
	Checksum: 0xFA5C49A1
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_bd5da28f(player, value)
{
	[[ self ]]->function_bd5da28f(player, value);
}

/*
	Name: function_8a094f25
	Namespace: zm_towers_pap_hud
	Checksum: 0xFD216808
	Offset: 0x238
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8a094f25(player, value)
{
	[[ self ]]->function_8a094f25(player, value);
}

/*
	Name: function_b6ec93fa
	Namespace: zm_towers_pap_hud
	Checksum: 0xBDA447B7
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_b6ec93fa(player, value)
{
	[[ self ]]->function_b6ec93fa(player, value);
}

