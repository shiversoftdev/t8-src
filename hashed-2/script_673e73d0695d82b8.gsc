// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cSpectreRisingIndicator : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cSpectreRisingIndicator
		Checksum: 0xF992259F
		Offset: 0x210
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cSpectreRisingIndicator
		Checksum: 0xE9A390EA
		Offset: 0x3C0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_isAlive
		Namespace: cSpectreRisingIndicator
		Checksum: 0x1C0D9C0F
		Offset: 0x378
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_isAlive(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "isAlive", value);
	}

	/*
		Name: set_clientnum
		Namespace: cSpectreRisingIndicator
		Checksum: 0x1DD15873
		Offset: 0x330
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_clientnum(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "clientnum", value);
	}

	/*
		Name: close
		Namespace: cSpectreRisingIndicator
		Checksum: 0x9E112E61
		Offset: 0x300
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
		Namespace: cSpectreRisingIndicator
		Checksum: 0x53F7AD35
		Offset: 0x2B0
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "SpectreRisingIndicator", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cSpectreRisingIndicator
		Checksum: 0x1B16609F
		Offset: 0x230
		Size: 0x74
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("clientnum", 1, 7, "int");
		cLUIelem::function_da693cbe("isAlive", 1, 1, "int");
	}

}

#namespace spectrerisingindicator;

/*
	Name: register
	Namespace: spectrerisingindicator
	Checksum: 0xB86BBF16
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new cSpectreRisingIndicator();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: spectrerisingindicator
	Checksum: 0x4C7439EB
	Offset: 0x120
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
	Namespace: spectrerisingindicator
	Checksum: 0xD19B3746
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
	Namespace: spectrerisingindicator
	Checksum: 0x1A0B48DB
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
	Name: set_clientnum
	Namespace: spectrerisingindicator
	Checksum: 0xF82BBD76
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_clientnum(player, value)
{
	[[ self ]]->set_clientnum(player, value);
}

/*
	Name: set_isAlive
	Namespace: spectrerisingindicator
	Checksum: 0x9A235B41
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_isAlive(player, value)
{
	[[ self ]]->set_isAlive(player, value);
}

