// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_135e8f9a : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_135e8f9a
		Checksum: 0xF160F090
		Offset: 0x288
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_135e8f9a
		Checksum: 0xBC2FE78D
		Offset: 0x508
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_28ebf0f1
		Namespace: namespace_135e8f9a
		Checksum: 0xFFFA0B09
		Offset: 0x4D0
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_28ebf0f1(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "fadeTime", value);
	}

	/*
		Name: function_3b7b386a
		Namespace: namespace_135e8f9a
		Checksum: 0xC098C761
		Offset: 0x498
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_3b7b386a(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "clientNum", value);
	}

	/*
		Name: function_d5ea17f0
		Namespace: namespace_135e8f9a
		Checksum: 0x3D1C9A0E
		Offset: 0x460
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_d5ea17f0(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "text", value);
	}

	/*
		Name: open
		Namespace: namespace_135e8f9a
		Checksum: 0xB859D4C2
		Offset: 0x428
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"revive_hud");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_135e8f9a
		Checksum: 0xE11D356F
		Offset: 0x398
		Size: 0x84
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "text", #"");
		[[ self ]]->function_d7d2fcce(localclientnum, "clientNum", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "fadeTime", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_135e8f9a
		Checksum: 0xBB6BCAE6
		Offset: 0x368
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		namespace_6aaccc24::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_135e8f9a
		Checksum: 0x218C541
		Offset: 0x2A8
		Size: 0xB4
		Parameters: 4
		Flags: Linked
	*/
	function setup_clientfields(uid, var_f5852d69, var_c05c67e2, var_415094af)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_dcb34c80("string", "text", 1);
		namespace_6aaccc24::function_da693cbe("clientNum", 1, 6, "int", var_c05c67e2);
		namespace_6aaccc24::function_da693cbe("fadeTime", 1, 5, "int", var_415094af);
	}

}

#namespace revive_hud;

/*
	Name: register
	Namespace: revive_hud
	Checksum: 0xF79B02DE
	Offset: 0xC8
	Size: 0x64
	Parameters: 4
	Flags: Linked
*/
function register(uid, var_f5852d69, var_c05c67e2, var_415094af)
{
	elem = new class_135e8f9a();
	[[ elem ]]->setup_clientfields(uid, var_f5852d69, var_c05c67e2, var_415094af);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: revive_hud
	Checksum: 0xA79D4F92
	Offset: 0x138
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_135e8f9a();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: revive_hud
	Checksum: 0xF2AFC202
	Offset: 0x180
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
	Namespace: revive_hud
	Checksum: 0xD7B2F8C5
	Offset: 0x1A8
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
	Namespace: revive_hud
	Checksum: 0x894ACD8A
	Offset: 0x1D0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_d5ea17f0
	Namespace: revive_hud
	Checksum: 0x4766F76B
	Offset: 0x1F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(localclientnum, value)
{
	[[ self ]]->function_d5ea17f0(localclientnum, value);
}

/*
	Name: function_3b7b386a
	Namespace: revive_hud
	Checksum: 0x2F71A5F8
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3b7b386a(localclientnum, value)
{
	[[ self ]]->function_3b7b386a(localclientnum, value);
}

/*
	Name: function_28ebf0f1
	Namespace: revive_hud
	Checksum: 0x2127309D
	Offset: 0x258
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_28ebf0f1(localclientnum, value)
{
	[[ self ]]->function_28ebf0f1(localclientnum, value);
}

