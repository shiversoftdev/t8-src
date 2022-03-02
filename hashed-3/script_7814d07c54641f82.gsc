// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_366ba496 : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_366ba496
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
		Namespace: namespace_366ba496
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
		Name: function_fd8c13fb
		Namespace: namespace_366ba496
		Checksum: 0x89A2D801
		Offset: 0x330
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_fd8c13fb(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "bar_percent", value);
	}

	/*
		Name: open
		Namespace: namespace_366ba496
		Checksum: 0xFD0B67FC
		Offset: 0x2F8
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"vehicleturretdurability");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_366ba496
		Checksum: 0x92CBA120
		Offset: 0x2A8
		Size: 0x48
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "bar_percent", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_366ba496
		Checksum: 0x1F60FFFB
		Offset: 0x278
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		namespace_6aaccc24::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_366ba496
		Checksum: 0x49840796
		Offset: 0x218
		Size: 0x54
		Parameters: 2
		Flags: Linked
	*/
	function setup_clientfields(uid, var_661989d5)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("bar_percent", 4000, 6, "float", var_661989d5);
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
	elem = new class_366ba496();
	[[ elem ]]->setup_clientfields(uid, var_661989d5);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: vehicleturretdurability
	Checksum: 0x2B2DD481
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_366ba496();
	[[ elem ]]->function_5c1bb138(uid);
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
	Name: function_fd8c13fb
	Namespace: vehicleturretdurability
	Checksum: 0x9DCB6BC6
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_fd8c13fb(localclientnum, value)
{
	[[ self ]]->function_fd8c13fb(localclientnum, value);
}

