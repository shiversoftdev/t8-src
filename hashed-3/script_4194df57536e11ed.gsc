// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cinitial_black : cLUIelem
{

	/*
		Name: constructor
		Namespace: cinitial_black
		Checksum: 0xDCCB29A0
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
		Namespace: cinitial_black
		Checksum: 0x168D3D20
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
		Namespace: cinitial_black
		Checksum: 0x8859BA13
		Offset: 0x230
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
		Namespace: cinitial_black
		Checksum: 0xCEBA4374
		Offset: 0x1E0
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "initial_black", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cinitial_black
		Checksum: 0xF81FE114
		Offset: 0x1B0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
	}

}

#namespace initial_black;

/*
	Name: register
	Namespace: initial_black
	Checksum: 0xAAC22DC0
	Offset: 0xB8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new cinitial_black();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: initial_black
	Checksum: 0xDC183C4B
	Offset: 0x100
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
	Namespace: initial_black
	Checksum: 0xCF13DAC7
	Offset: 0x140
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
	Namespace: initial_black
	Checksum: 0x8ACF073B
	Offset: 0x168
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

