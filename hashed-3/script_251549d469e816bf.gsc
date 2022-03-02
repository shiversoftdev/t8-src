// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_b58d10b2 : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_b58d10b2
		Checksum: 0x2A0D4E23
		Offset: 0x458
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_b58d10b2
		Checksum: 0x3A51D09B
		Offset: 0xA98
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_6416c30d
		Namespace: namespace_b58d10b2
		Checksum: 0x566FEE0F
		Offset: 0xA60
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_6416c30d(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "material", value);
	}

	/*
		Name: function_7420df0a
		Namespace: namespace_b58d10b2
		Checksum: 0x3C229E66
		Offset: 0xA28
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_7420df0a(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "blue", value);
	}

	/*
		Name: function_2208b8db
		Namespace: namespace_b58d10b2
		Checksum: 0x8776D27E
		Offset: 0x9F0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_2208b8db(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "green", value);
	}

	/*
		Name: function_eccc151d
		Namespace: namespace_b58d10b2
		Checksum: 0x73D7CE69
		Offset: 0x9B8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_eccc151d(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "red", value);
	}

	/*
		Name: function_aa5c711d
		Namespace: namespace_b58d10b2
		Checksum: 0x99959D0
		Offset: 0x980
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_aa5c711d(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "alpha", value);
	}

	/*
		Name: function_237ff433
		Namespace: namespace_b58d10b2
		Checksum: 0x5574019E
		Offset: 0x948
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_237ff433(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "fadeOverTime", value);
	}

	/*
		Name: function_5dbd7024
		Namespace: namespace_b58d10b2
		Checksum: 0xD484F925
		Offset: 0x910
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_5dbd7024(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "height", value);
	}

	/*
		Name: function_8b0b5811
		Namespace: namespace_b58d10b2
		Checksum: 0x656FC8C1
		Offset: 0x8D8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_8b0b5811(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "width", value);
	}

	/*
		Name: set_y
		Namespace: namespace_b58d10b2
		Checksum: 0x9211EBC0
		Offset: 0x8A0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_y(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "y", value);
	}

	/*
		Name: set_x
		Namespace: namespace_b58d10b2
		Checksum: 0xFA7DAD40
		Offset: 0x868
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_x(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "x", value);
	}

	/*
		Name: open
		Namespace: namespace_b58d10b2
		Checksum: 0xB682BD37
		Offset: 0x830
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"luielemimage");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_b58d10b2
		Checksum: 0x5E8BD47A
		Offset: 0x6B8
		Size: 0x16C
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "x", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "y", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "width", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "height", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "fadeOverTime", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "alpha", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "red", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "green", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "blue", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "material", #"");
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_b58d10b2
		Checksum: 0x6DAB4032
		Offset: 0x688
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
		Namespace: namespace_b58d10b2
		Checksum: 0x8114E94B
		Offset: 0x478
		Size: 0x204
		Parameters: 11
		Flags: None
	*/
	function setup_clientfields(uid, var_218de242, var_f6cc2724, var_997793d7, var_fae6c0b5, var_a3e0a6ce, var_af074abc, var_9350f184, var_788c188f, var_3fb95ac9, var_e6b6b84b)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("x", 1, 7, "int", var_218de242);
		namespace_6aaccc24::function_da693cbe("y", 1, 6, "int", var_f6cc2724);
		namespace_6aaccc24::function_da693cbe("width", 1, 6, "int", var_997793d7);
		namespace_6aaccc24::function_da693cbe("height", 1, 6, "int", var_fae6c0b5);
		namespace_6aaccc24::function_da693cbe("fadeOverTime", 1, 5, "int", var_a3e0a6ce);
		namespace_6aaccc24::function_da693cbe("alpha", 1, 4, "float", var_af074abc);
		namespace_6aaccc24::function_da693cbe("red", 1, 4, "float", var_9350f184);
		namespace_6aaccc24::function_da693cbe("green", 1, 4, "float", var_788c188f);
		namespace_6aaccc24::function_da693cbe("blue", 1, 4, "float", var_3fb95ac9);
		namespace_6aaccc24::function_dcb34c80("material", "material", 1);
	}

}

#namespace luielemimage;

/*
	Name: register
	Namespace: luielemimage
	Checksum: 0xC7386B61
	Offset: 0xF8
	Size: 0xB8
	Parameters: 11
	Flags: None
*/
function register(uid, var_218de242, var_f6cc2724, var_997793d7, var_fae6c0b5, var_a3e0a6ce, var_af074abc, var_9350f184, var_788c188f, var_3fb95ac9, var_e6b6b84b)
{
	elem = new class_b58d10b2();
	[[ elem ]]->setup_clientfields(uid, var_218de242, var_f6cc2724, var_997793d7, var_fae6c0b5, var_a3e0a6ce, var_af074abc, var_9350f184, var_788c188f, var_3fb95ac9, var_e6b6b84b);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: luielemimage
	Checksum: 0xE3055534
	Offset: 0x1B8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_b58d10b2();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielemimage
	Checksum: 0x391D8046
	Offset: 0x200
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
	Namespace: luielemimage
	Checksum: 0x8E182657
	Offset: 0x228
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
	Namespace: luielemimage
	Checksum: 0x93A1617
	Offset: 0x250
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_x
	Namespace: luielemimage
	Checksum: 0x1ABDF039
	Offset: 0x278
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_x(localclientnum, value)
{
	[[ self ]]->set_x(localclientnum, value);
}

/*
	Name: set_y
	Namespace: luielemimage
	Checksum: 0x392C04F9
	Offset: 0x2A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_y(localclientnum, value)
{
	[[ self ]]->set_y(localclientnum, value);
}

/*
	Name: function_8b0b5811
	Namespace: luielemimage
	Checksum: 0x4F464214
	Offset: 0x2D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8b0b5811(localclientnum, value)
{
	[[ self ]]->function_8b0b5811(localclientnum, value);
}

/*
	Name: function_5dbd7024
	Namespace: luielemimage
	Checksum: 0xE53E6A9A
	Offset: 0x308
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5dbd7024(localclientnum, value)
{
	[[ self ]]->function_5dbd7024(localclientnum, value);
}

/*
	Name: function_237ff433
	Namespace: luielemimage
	Checksum: 0xF4F2C88A
	Offset: 0x338
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_237ff433(localclientnum, value)
{
	[[ self ]]->function_237ff433(localclientnum, value);
}

/*
	Name: function_aa5c711d
	Namespace: luielemimage
	Checksum: 0x568FC7AD
	Offset: 0x368
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_aa5c711d(localclientnum, value)
{
	[[ self ]]->function_aa5c711d(localclientnum, value);
}

/*
	Name: function_eccc151d
	Namespace: luielemimage
	Checksum: 0x1170A18
	Offset: 0x398
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_eccc151d(localclientnum, value)
{
	[[ self ]]->function_eccc151d(localclientnum, value);
}

/*
	Name: function_2208b8db
	Namespace: luielemimage
	Checksum: 0x267816D2
	Offset: 0x3C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_2208b8db(localclientnum, value)
{
	[[ self ]]->function_2208b8db(localclientnum, value);
}

/*
	Name: function_7420df0a
	Namespace: luielemimage
	Checksum: 0xB231D50C
	Offset: 0x3F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7420df0a(localclientnum, value)
{
	[[ self ]]->function_7420df0a(localclientnum, value);
}

/*
	Name: function_6416c30d
	Namespace: luielemimage
	Checksum: 0xBA04CF9D
	Offset: 0x428
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_6416c30d(localclientnum, value)
{
	[[ self ]]->function_6416c30d(localclientnum, value);
}

