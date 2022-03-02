// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_1e9d002b : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_1e9d002b
		Checksum: 0x85501C3
		Offset: 0x190
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_1e9d002b
		Checksum: 0x308CAE5D
		Offset: 0x260
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: close
		Namespace: namespace_1e9d002b
		Checksum: 0xE7E68618
		Offset: 0x230
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
		Namespace: namespace_1e9d002b
		Checksum: 0x94E11145
		Offset: 0x1E0
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "wz_wingsuit_hud", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_1e9d002b
		Checksum: 0xC95FB542
		Offset: 0x1B0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
	}

}

#namespace wz_wingsuit_hud;

/*
	Name: register
	Namespace: wz_wingsuit_hud
	Checksum: 0xA4906DE1
	Offset: 0xB8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new class_1e9d002b();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: wz_wingsuit_hud
	Checksum: 0xBAEEF030
	Offset: 0x100
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
	Namespace: wz_wingsuit_hud
	Checksum: 0x2AB64469
	Offset: 0x140
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
	Namespace: wz_wingsuit_hud
	Checksum: 0x1388EDF
	Offset: 0x168
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

