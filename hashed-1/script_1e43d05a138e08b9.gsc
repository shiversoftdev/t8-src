// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cwz_wingsuit_hud : cLUIelem
{

	/*
		Name: constructor
		Namespace: cwz_wingsuit_hud
		Checksum: 0x84F7EB9E
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
		Namespace: cwz_wingsuit_hud
		Checksum: 0xE06E5AFE
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
		Namespace: cwz_wingsuit_hud
		Checksum: 0xF45B9762
		Offset: 0x258
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"wz_wingsuit_hud");
	}

	/*
		Name: function_fa582112
		Namespace: cwz_wingsuit_hud
		Checksum: 0xA585160E
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
		Namespace: cwz_wingsuit_hud
		Checksum: 0x1801DF20
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
		Namespace: cwz_wingsuit_hud
		Checksum: 0xA6EF1321
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

#namespace wz_wingsuit_hud;

/*
	Name: register
	Namespace: wz_wingsuit_hud
	Checksum: 0x2A21ABC4
	Offset: 0xA0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new cwz_wingsuit_hud();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: wz_wingsuit_hud
	Checksum: 0xA8F05470
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cwz_wingsuit_hud();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: wz_wingsuit_hud
	Checksum: 0xE03661EF
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
	Namespace: wz_wingsuit_hud
	Checksum: 0x13CA209
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
	Namespace: wz_wingsuit_hud
	Checksum: 0x430F6E1E
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

