// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cct_firebreak_multi_kill : cluielem
{

	/*
		Name: constructor
		Namespace: cct_firebreak_multi_kill
		Checksum: 0xCDD8BF00
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
		Namespace: cct_firebreak_multi_kill
		Checksum: 0xA0040272
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
		Namespace: cct_firebreak_multi_kill
		Checksum: 0xF0A6C6C4
		Offset: 0x258
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"ct_firebreak_multi_kill");
	}

	/*
		Name: function_fa582112
		Namespace: cct_firebreak_multi_kill
		Checksum: 0x4CB89252
		Offset: 0x228
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
	}

	/*
		Name: register_clientside
		Namespace: cct_firebreak_multi_kill
		Checksum: 0xBB3E3E47
		Offset: 0x1F8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cct_firebreak_multi_kill
		Checksum: 0xAADCE22D
		Offset: 0x1C8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
	}

}

#namespace ct_firebreak_multi_kill;

/*
	Name: register
	Namespace: ct_firebreak_multi_kill
	Checksum: 0x5BF02508
	Offset: 0xA0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cct_firebreak_multi_kill();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: register_clientside
	Namespace: ct_firebreak_multi_kill
	Checksum: 0xCD6EBB5D
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cct_firebreak_multi_kill();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_firebreak_multi_kill
	Checksum: 0xE739FAC
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
	Namespace: ct_firebreak_multi_kill
	Checksum: 0x3BF24D65
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
	Namespace: ct_firebreak_multi_kill
	Checksum: 0x2245903B
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

