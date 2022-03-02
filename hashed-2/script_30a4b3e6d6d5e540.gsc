// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_1e6cb1a9 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_1e6cb1a9
		Checksum: 0x1A335DFD
		Offset: 0x230
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_1e6cb1a9
		Checksum: 0x2D057D23
		Offset: 0x3E0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_d50fdde9
		Namespace: namespace_1e6cb1a9
		Checksum: 0x23EB0ACD
		Offset: 0x398
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_d50fdde9(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "revive_progress", value);
	}

	/*
		Name: function_7a5768aa
		Namespace: namespace_1e6cb1a9
		Checksum: 0x33F62F01
		Offset: 0x350
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_7a5768aa(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "self_revive_progress_bar_fill", value);
	}

	/*
		Name: close
		Namespace: namespace_1e6cb1a9
		Checksum: 0xBCF2A8D
		Offset: 0x320
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
		Namespace: namespace_1e6cb1a9
		Checksum: 0x49A803CC
		Offset: 0x2D0
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "self_revive_visuals", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_1e6cb1a9
		Checksum: 0xA6D220AB
		Offset: 0x250
		Size: 0x74
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("self_revive_progress_bar_fill", 1, 5, "float");
		namespace_6aaccc24::function_da693cbe("revive_progress", 1, 5, "float");
	}

}

#namespace self_revive_visuals;

/*
	Name: register
	Namespace: self_revive_visuals
	Checksum: 0xDF881CA3
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new class_1e6cb1a9();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_revive_visuals
	Checksum: 0x4A4E4B04
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
	Namespace: self_revive_visuals
	Checksum: 0x90839ABF
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
	Namespace: self_revive_visuals
	Checksum: 0x941631A6
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_7a5768aa
	Namespace: self_revive_visuals
	Checksum: 0x2E311F5
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7a5768aa(player, value)
{
	[[ self ]]->function_7a5768aa(player, value);
}

/*
	Name: function_d50fdde9
	Namespace: self_revive_visuals
	Checksum: 0xBC271F56
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_d50fdde9(player, value)
{
	[[ self ]]->function_d50fdde9(player, value);
}

