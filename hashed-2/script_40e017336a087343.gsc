// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_e6e7895b : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_e6e7895b
		Checksum: 0x5322EE49
		Offset: 0x470
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_e6e7895b
		Checksum: 0xB5A12F58
		Offset: 0xAA8
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_1bd2bb26
		Namespace: namespace_e6e7895b
		Checksum: 0x570AF1FC
		Offset: 0xA70
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_1bd2bb26(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "horizontal_alignment", value);
	}

	/*
		Name: function_d5ea17f0
		Namespace: namespace_e6e7895b
		Checksum: 0xEB88DC49
		Offset: 0xA38
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_d5ea17f0(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "text", value);
	}

	/*
		Name: function_7420df0a
		Namespace: namespace_e6e7895b
		Checksum: 0x106334A7
		Offset: 0xA00
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
		Namespace: namespace_e6e7895b
		Checksum: 0x3B29E600
		Offset: 0x9C8
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
		Namespace: namespace_e6e7895b
		Checksum: 0x45747ADA
		Offset: 0x990
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
		Namespace: namespace_e6e7895b
		Checksum: 0x8CE82786
		Offset: 0x958
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
		Namespace: namespace_e6e7895b
		Checksum: 0xCAA8B5E2
		Offset: 0x920
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
		Namespace: namespace_e6e7895b
		Checksum: 0x71987773
		Offset: 0x8E8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_5dbd7024(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "height", value);
	}

	/*
		Name: set_y
		Namespace: namespace_e6e7895b
		Checksum: 0xB8DE9E74
		Offset: 0x8B0
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
		Namespace: namespace_e6e7895b
		Checksum: 0x202AC311
		Offset: 0x878
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
		Namespace: namespace_e6e7895b
		Checksum: 0xC0CF9F7F
		Offset: 0x840
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"luielemtext");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_e6e7895b
		Checksum: 0xCE3A691A
		Offset: 0x6D0
		Size: 0x168
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "x", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "y", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "height", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "fadeOverTime", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "alpha", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "red", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "green", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "blue", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "text", #"");
		[[ self ]]->function_d7d2fcce(localclientnum, "horizontal_alignment", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_e6e7895b
		Checksum: 0xC7AFAA4C
		Offset: 0x6A0
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
		Namespace: namespace_e6e7895b
		Checksum: 0x9B9CD1E0
		Offset: 0x490
		Size: 0x204
		Parameters: 11
		Flags: None
	*/
	function setup_clientfields(uid, var_218de242, var_f6cc2724, var_fae6c0b5, var_a3e0a6ce, var_af074abc, var_9350f184, var_788c188f, var_3fb95ac9, var_f5852d69, var_cfabd75c)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("x", 1, 7, "int", var_218de242);
		namespace_6aaccc24::function_da693cbe("y", 1, 6, "int", var_f6cc2724);
		namespace_6aaccc24::function_da693cbe("height", 1, 2, "int", var_fae6c0b5);
		namespace_6aaccc24::function_da693cbe("fadeOverTime", 1, 5, "int", var_a3e0a6ce);
		namespace_6aaccc24::function_da693cbe("alpha", 1, 4, "float", var_af074abc);
		namespace_6aaccc24::function_da693cbe("red", 1, 4, "float", var_9350f184);
		namespace_6aaccc24::function_da693cbe("green", 1, 4, "float", var_788c188f);
		namespace_6aaccc24::function_da693cbe("blue", 1, 4, "float", var_3fb95ac9);
		namespace_6aaccc24::function_dcb34c80("string", "text", 1);
		namespace_6aaccc24::function_da693cbe("horizontal_alignment", 1, 2, "int", var_cfabd75c);
	}

}

#namespace luielemtext;

/*
	Name: register
	Namespace: luielemtext
	Checksum: 0x294DD550
	Offset: 0x110
	Size: 0xB8
	Parameters: 11
	Flags: None
*/
function register(uid, var_218de242, var_f6cc2724, var_fae6c0b5, var_a3e0a6ce, var_af074abc, var_9350f184, var_788c188f, var_3fb95ac9, var_f5852d69, var_cfabd75c)
{
	elem = new class_e6e7895b();
	[[ elem ]]->setup_clientfields(uid, var_218de242, var_f6cc2724, var_fae6c0b5, var_a3e0a6ce, var_af074abc, var_9350f184, var_788c188f, var_3fb95ac9, var_f5852d69, var_cfabd75c);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: luielemtext
	Checksum: 0x73DA1F93
	Offset: 0x1D0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_e6e7895b();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielemtext
	Checksum: 0x6A4407A1
	Offset: 0x218
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
	Namespace: luielemtext
	Checksum: 0xA83DA7D4
	Offset: 0x240
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
	Namespace: luielemtext
	Checksum: 0x1648C9AA
	Offset: 0x268
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
	Namespace: luielemtext
	Checksum: 0xDBA61060
	Offset: 0x290
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
	Namespace: luielemtext
	Checksum: 0xD620528
	Offset: 0x2C0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_y(localclientnum, value)
{
	[[ self ]]->set_y(localclientnum, value);
}

/*
	Name: function_5dbd7024
	Namespace: luielemtext
	Checksum: 0xC4C1B80
	Offset: 0x2F0
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
	Namespace: luielemtext
	Checksum: 0xD59A67C6
	Offset: 0x320
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
	Namespace: luielemtext
	Checksum: 0xE436257E
	Offset: 0x350
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
	Namespace: luielemtext
	Checksum: 0x11F87B37
	Offset: 0x380
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
	Namespace: luielemtext
	Checksum: 0x997375A8
	Offset: 0x3B0
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
	Namespace: luielemtext
	Checksum: 0x1DD09B2A
	Offset: 0x3E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7420df0a(localclientnum, value)
{
	[[ self ]]->function_7420df0a(localclientnum, value);
}

/*
	Name: function_d5ea17f0
	Namespace: luielemtext
	Checksum: 0x41E47EC7
	Offset: 0x410
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(localclientnum, value)
{
	[[ self ]]->function_d5ea17f0(localclientnum, value);
}

/*
	Name: function_1bd2bb26
	Namespace: luielemtext
	Checksum: 0x7CCF3952
	Offset: 0x440
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_1bd2bb26(localclientnum, value)
{
	[[ self ]]->function_1bd2bb26(localclientnum, value);
}

