// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_bc79c0e8 : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_bc79c0e8
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
		Namespace: namespace_bc79c0e8
		Checksum: 0x339A43AA
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
		Namespace: namespace_bc79c0e8
		Checksum: 0xBE90DCD7
		Offset: 0x258
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"prototype_self_revive");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_bc79c0e8
		Checksum: 0x3F59E0F6
		Offset: 0x228
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_bc79c0e8
		Checksum: 0x845371CF
		Offset: 0x1F8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_5c1bb138(uid)
	{
		namespace_6aaccc24::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_bc79c0e8
		Checksum: 0x464D55A9
		Offset: 0x1C8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
	}

}

#namespace prototype_self_revive;

/*
	Name: register
	Namespace: prototype_self_revive
	Checksum: 0xF274FFBA
	Offset: 0xA0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_bc79c0e8();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: prototype_self_revive
	Checksum: 0xD8D7A5D5
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_bc79c0e8();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: prototype_self_revive
	Checksum: 0xDB1323E5
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
	Namespace: prototype_self_revive
	Checksum: 0xE8EDDA12
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
	Namespace: prototype_self_revive
	Checksum: 0x571DC3FC
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

