// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cdeath_zone : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cdeath_zone
		Checksum: 0xF7D72CB5
		Offset: 0x1D0
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cdeath_zone
		Checksum: 0xC79BFFDF
		Offset: 0x310
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_shutdown_sec
		Namespace: cdeath_zone
		Checksum: 0xED54BADF
		Offset: 0x2C8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_shutdown_sec(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "shutdown_sec", value);
	}

	/*
		Name: close
		Namespace: cdeath_zone
		Checksum: 0xDD1B2821
		Offset: 0x298
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cLUIelem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cdeath_zone
		Checksum: 0x37E43E6A
		Offset: 0x248
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "death_zone", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cdeath_zone
		Checksum: 0x9B8B17F5
		Offset: 0x1F0
		Size: 0x4C
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("shutdown_sec", 1, 9, "int");
	}

}

#namespace death_zone;

/*
	Name: register
	Namespace: death_zone
	Checksum: 0x67B340D0
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cdeath_zone();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: death_zone
	Checksum: 0x2CF90DDF
	Offset: 0x110
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
	Namespace: death_zone
	Checksum: 0xBFC9ADF
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
	Namespace: death_zone
	Checksum: 0x7A899DBF
	Offset: 0x178
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_shutdown_sec
	Namespace: death_zone
	Checksum: 0x96214F6A
	Offset: 0x1A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_shutdown_sec(player, value)
{
	[[ self ]]->set_shutdown_sec(player, value);
}

