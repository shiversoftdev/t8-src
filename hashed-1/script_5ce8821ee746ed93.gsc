// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class csuccess_screen : cLUIelem
{

	/*
		Name: constructor
		Namespace: csuccess_screen
		Checksum: 0xB78D7789
		Offset: 0x190
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: csuccess_screen
		Checksum: 0x7BF540F9
		Offset: 0x260
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: close
		Namespace: csuccess_screen
		Checksum: 0x5858E354
		Offset: 0x230
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
		Namespace: csuccess_screen
		Checksum: 0x8B9D6DF1
		Offset: 0x1E0
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "success_screen", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: csuccess_screen
		Checksum: 0xE1D3DFF0
		Offset: 0x1B0
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
	}

}

#namespace success_screen;

/*
	Name: register
	Namespace: success_screen
	Checksum: 0xFD107BDA
	Offset: 0xB8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new csuccess_screen();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: success_screen
	Checksum: 0xBA30F2F1
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
	Namespace: success_screen
	Checksum: 0x39C122F5
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
	Namespace: success_screen
	Checksum: 0xFA1C3BB7
	Offset: 0x168
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

