// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cvehicleturretoverheat : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cvehicleturretoverheat
		Checksum: 0xA642CBD5
		Offset: 0x218
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cvehicleturretoverheat
		Checksum: 0xDC166380
		Offset: 0x448
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_bar_percent
		Namespace: cvehicleturretoverheat
		Checksum: 0x197DB59E
		Offset: 0x400
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_bar_percent(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "bar_percent", value);
	}

	/*
		Name: set_state
		Namespace: cvehicleturretoverheat
		Checksum: 0x543EC8D6
		Offset: 0x338
		Size: 0xBC
		Parameters: 2
		Flags: Linked
	*/
	function set_state(player, state_name)
	{
		if(#"defaultstate" == state_name)
		{
			player clientfield::function_9bf78ef8(var_47e79fc, "_state", 0);
		}
		else
		{
			if(#"overheat" == state_name)
			{
				player clientfield::function_9bf78ef8(var_47e79fc, "_state", 1);
			}
			else
			{
				/#
					assertmsg("");
				#/
				/#
				#/
			}
		}
	}

	/*
		Name: close
		Namespace: cvehicleturretoverheat
		Checksum: 0xA8204B39
		Offset: 0x308
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		cLUIelem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cvehicleturretoverheat
		Checksum: 0x4AA2925F
		Offset: 0x2B8
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "VehicleTurretOverheat", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cvehicleturretoverheat
		Checksum: 0xB83BC254
		Offset: 0x238
		Size: 0x74
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 1, "int");
		cLUIelem::function_da693cbe("bar_percent", 4000, 6, "float", 0);
	}

}

#namespace vehicleturretoverheat;

/*
	Name: register
	Namespace: vehicleturretoverheat
	Checksum: 0x145D78FB
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new cvehicleturretoverheat();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: vehicleturretoverheat
	Checksum: 0x4E7DA7A4
	Offset: 0x128
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
	Namespace: vehicleturretoverheat
	Checksum: 0xE9530D87
	Offset: 0x168
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
	Namespace: vehicleturretoverheat
	Checksum: 0x2ED54047
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
	Name: set_state
	Namespace: vehicleturretoverheat
	Checksum: 0x332F47C8
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_bar_percent
	Namespace: vehicleturretoverheat
	Checksum: 0xFABE0E84
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bar_percent(player, value)
{
	[[ self ]]->set_bar_percent(player, value);
}

