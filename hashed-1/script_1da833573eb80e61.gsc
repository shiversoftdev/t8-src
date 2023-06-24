// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cinitial_black : cLUIelem
{

	/*
		Name: constructor
		Namespace: cinitial_black
		Checksum: 0xEB056E42
		Offset: 0x1A8
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
		Checksum: 0x62C6C2F
		Offset: 0x290
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: open
		Namespace: cinitial_black
		Checksum: 0x5367638
		Offset: 0x258
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"initial_black");
	}

	/*
		Name: function_fa582112
		Namespace: cinitial_black
		Checksum: 0x28A47FC7
		Offset: 0x228
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
	}

	/*
		Name: function_5c1bb138
		Namespace: cinitial_black
		Checksum: 0x6E533EE2
		Offset: 0x1F8
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		cLUIelem::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cinitial_black
		Checksum: 0xD89208D9
		Offset: 0x1C8
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
	Checksum: 0x3295262C
	Offset: 0xA0
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
	Name: function_5c1bb138
	Namespace: initial_black
	Checksum: 0x6E7E5033
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cinitial_black();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: initial_black
	Checksum: 0xC6EC12E2
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
	Namespace: initial_black
	Checksum: 0xA0E7B69
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
	Namespace: initial_black
	Checksum: 0x64B28E02
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

