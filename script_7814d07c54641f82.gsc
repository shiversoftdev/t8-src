// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cvehicleturretdurability : cluielem
{

	/*
		Name: constructor
		Namespace: cvehicleturretdurability
		Checksum: 0xD52712B4
		Offset: 0x1F8
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
		Checksum: 0x198B01C7
		Offset: 0x368
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
		Checksum: 0x89A2D801
		Offset: 0x330
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_bar_percent(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bar_percent", value);
	}

	/*
		Name: open
		Namespace: cvehicleturretdurability
		Checksum: 0xFD0B67FC
		Offset: 0x2F8
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"vehicleturretdurability");
	}

	/*
		Name: function_fa582112
		Namespace: cvehicleturretdurability
		Checksum: 0x92CBA120
		Offset: 0x2A8
		Size: 0x48
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "bar_percent", 0);
	}

	/*
		Name: register_clientside
		Namespace: cvehicleturretdurability
		Checksum: 0x1F60FFFB
		Offset: 0x278
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cvehicleturretdurability
		Checksum: 0x49840796
		Offset: 0x218
		Size: 0x54
		Parameters: 2
		Flags: Linked
	*/
	function setup_clientfields(uid, var_661989d5)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("bar_percent", 4000, 6, "float", var_661989d5);
	}

}

#namespace vehicleturretdurability;

/*
	Name: register
	Namespace: vehicleturretdurability
	Checksum: 0x4D5C2AF0
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_661989d5)
{
	elem = new cvehicleturretdurability();
	[[ elem ]]->setup_clientfields(uid, var_661989d5);
	return elem;
}

/*
	Name: register_clientside
	Namespace: vehicleturretdurability
	Checksum: 0x2B2DD481
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cvehicleturretdurability();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: vehicleturretdurability
	Checksum: 0x1AD66413
	Offset: 0x150
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: vehicleturretdurability
	Checksum: 0x35AE8566
	Offset: 0x178
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
	Namespace: vehicleturretdurability
	Checksum: 0x19F5442E
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_bar_percent
	Namespace: vehicleturretdurability
	Checksum: 0x9DCB6BC6
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bar_percent(localclientnum, value)
{
	[[ self ]]->set_bar_percent(localclientnum, value);
}

