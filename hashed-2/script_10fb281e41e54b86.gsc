// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cprototype_defend_timer : cLUIelem
{

	/*
		Name: constructor
		Namespace: cprototype_defend_timer
		Checksum: 0xED05DE0A
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
		Namespace: cprototype_defend_timer
		Checksum: 0x6578CFA4
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
		Namespace: cprototype_defend_timer
		Checksum: 0x5F7EBDDF
		Offset: 0x258
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"prototype_defend_timer");
	}

	/*
		Name: function_fa582112
		Namespace: cprototype_defend_timer
		Checksum: 0x8CAEDA1
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
		Namespace: cprototype_defend_timer
		Checksum: 0xC7ED1123
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
		Namespace: cprototype_defend_timer
		Checksum: 0x48F17400
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

#namespace prototype_defend_timer;

/*
	Name: register
	Namespace: prototype_defend_timer
	Checksum: 0x6D91BCF2
	Offset: 0xA0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cprototype_defend_timer();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: prototype_defend_timer
	Checksum: 0x8B975E97
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cprototype_defend_timer();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: prototype_defend_timer
	Checksum: 0x7FC91C37
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
	Namespace: prototype_defend_timer
	Checksum: 0x8F3CFC34
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
	Namespace: prototype_defend_timer
	Checksum: 0x9A666015
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

