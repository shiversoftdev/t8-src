// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cself_respawn : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cself_respawn
		Checksum: 0x4F5C71E1
		Offset: 0x1D0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cself_respawn
		Checksum: 0x961D0714
		Offset: 0x310
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_percent
		Namespace: cself_respawn
		Checksum: 0xC0D82E
		Offset: 0x2C8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_percent(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "percent", value);
	}

	/*
		Name: close
		Namespace: cself_respawn
		Checksum: 0x53B71BE3
		Offset: 0x298
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
		Namespace: cself_respawn
		Checksum: 0x65556246
		Offset: 0x248
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "self_respawn", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cself_respawn
		Checksum: 0x144FE2DF
		Offset: 0x1F0
		Size: 0x4C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("percent", 4000, 6, "float");
	}

}

#namespace self_respawn;

/*
	Name: register
	Namespace: self_respawn
	Checksum: 0x50E1B8B
	Offset: 0xC8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cself_respawn();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_respawn
	Checksum: 0x4657DD92
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
	Namespace: self_respawn
	Checksum: 0x7B4B45B9
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
	Namespace: self_respawn
	Checksum: 0x4EAD0D56
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
	Name: set_percent
	Namespace: self_respawn
	Checksum: 0x592A5FBC
	Offset: 0x1A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_percent(player, value)
{
	[[ self ]]->set_percent(player, value);
}

