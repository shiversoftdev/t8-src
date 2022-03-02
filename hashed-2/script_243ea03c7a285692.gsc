// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_135e8f9a : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_135e8f9a
		Checksum: 0x5094C0B9
		Offset: 0x248
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_135e8f9a
		Checksum: 0x6A4B80D2
		Offset: 0x468
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_28ebf0f1
		Namespace: namespace_135e8f9a
		Checksum: 0xEF18594C
		Offset: 0x420
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_28ebf0f1(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "fadeTime", value);
	}

	/*
		Name: function_3b7b386a
		Namespace: namespace_135e8f9a
		Checksum: 0x4EEF2D1
		Offset: 0x3D8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_3b7b386a(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "clientNum", value);
	}

	/*
		Name: function_d5ea17f0
		Namespace: namespace_135e8f9a
		Checksum: 0xE48CC578
		Offset: 0x390
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_d5ea17f0(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "text", value);
	}

	/*
		Name: close
		Namespace: namespace_135e8f9a
		Checksum: 0xA06177E0
		Offset: 0x360
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
		Namespace: namespace_135e8f9a
		Checksum: 0xCA70395A
		Offset: 0x310
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "revive_hud", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_135e8f9a
		Checksum: 0xC7F4ECA2
		Offset: 0x268
		Size: 0x9C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_dcb34c80("string", "text", 1);
		namespace_6aaccc24::function_da693cbe("clientNum", 1, 6, "int");
		namespace_6aaccc24::function_da693cbe("fadeTime", 1, 5, "int");
	}

}

#namespace revive_hud;

/*
	Name: register
	Namespace: revive_hud
	Checksum: 0xC88C96A8
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new class_135e8f9a();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: revive_hud
	Checksum: 0x7FBCBDAC
	Offset: 0x128
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
	Namespace: revive_hud
	Checksum: 0xF65DD395
	Offset: 0x168
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
	Namespace: revive_hud
	Checksum: 0x42C392A4
	Offset: 0x190
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_d5ea17f0
	Namespace: revive_hud
	Checksum: 0xA25A0F67
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_d5ea17f0(player, value)
{
	[[ self ]]->function_d5ea17f0(player, value);
}

/*
	Name: function_3b7b386a
	Namespace: revive_hud
	Checksum: 0x12EBF496
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_3b7b386a(player, value)
{
	[[ self ]]->function_3b7b386a(player, value);
}

/*
	Name: function_28ebf0f1
	Namespace: revive_hud
	Checksum: 0x9930F51F
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_28ebf0f1(player, value)
{
	[[ self ]]->function_28ebf0f1(player, value);
}

