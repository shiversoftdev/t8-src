// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cfail_screen : cLUIelem
{

	/*
		Name: constructor
		Namespace: cfail_screen
		Checksum: 0xE6F48613
		Offset: 0x1A8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cfail_screen
		Checksum: 0x329DD6FB
		Offset: 0x290
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: open
		Namespace: cfail_screen
		Checksum: 0xA67AB13F
		Offset: 0x258
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"fail_screen");
	}

	/*
		Name: function_fa582112
		Namespace: cfail_screen
		Checksum: 0x5A947C4C
		Offset: 0x228
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
	}

	/*
		Name: function_5c1bb138
		Namespace: cfail_screen
		Checksum: 0x1CFA0079
		Offset: 0x1F8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_5c1bb138(uid)
	{
		cLUIelem::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cfail_screen
		Checksum: 0x91696877
		Offset: 0x1C8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
	}

}

#namespace fail_screen;

/*
	Name: register
	Namespace: fail_screen
	Checksum: 0xB81E280E
	Offset: 0xA0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cfail_screen();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: fail_screen
	Checksum: 0x69FA015F
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cfail_screen();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: fail_screen
	Checksum: 0x86C7333D
	Offset: 0x130
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
	Namespace: fail_screen
	Checksum: 0xBEBCDC39
	Offset: 0x158
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
	Namespace: fail_screen
	Checksum: 0xDFDE5556
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

