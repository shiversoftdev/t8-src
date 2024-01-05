// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class cvehicleturretdurability : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cvehicleturretdurability
		Checksum: 0x1DC89457
		Offset: 0x1E0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cvehicleturretdurability
		Checksum: 0x35C105CE
		Offset: 0x320
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_bar_percent
		Namespace: cvehicleturretdurability
		Checksum: 0x18948C15
		Offset: 0x2D8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_bar_percent(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "bar_percent", value);
	}

	/*
		Name: close
		Namespace: cvehicleturretdurability
		Checksum: 0x4C9265F5
		Offset: 0x2A8
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		cluielem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cvehicleturretdurability
		Checksum: 0x6B8B4A3
		Offset: 0x258
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "VehicleTurretDurability", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cvehicleturretdurability
		Checksum: 0xFD55EBD
		Offset: 0x200
		Size: 0x4C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("bar_percent", 4000, 6, "float", 0);
	}

}

#namespace vehicleturretdurability;

/*
	Name: register
	Namespace: vehicleturretdurability
	Checksum: 0x90D76B25
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new cvehicleturretdurability();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: vehicleturretdurability
	Checksum: 0x48A6B65E
	Offset: 0x120
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
	Namespace: vehicleturretdurability
	Checksum: 0xDA9390A3
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
	Namespace: vehicleturretdurability
	Checksum: 0xC64D85EE
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
	Name: set_bar_percent
	Namespace: vehicleturretdurability
	Checksum: 0x42642C55
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bar_percent(player, value)
{
	[[ self ]]->set_bar_percent(player, value);
}

