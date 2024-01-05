// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cluielemtext : cluielem
{

	/*
		Name: constructor
		Namespace: cluielemtext
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
		Namespace: cluielemtext
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
		Name: set_horizontal_alignment
		Namespace: cluielemtext
		Checksum: 0x570AF1FC
		Offset: 0xA70
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_horizontal_alignment(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "horizontal_alignment", value);
	}

	/*
		Name: set_text
		Namespace: cluielemtext
		Checksum: 0xEB88DC49
		Offset: 0xA38
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_text(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "text", value);
	}

	/*
		Name: set_blue
		Namespace: cluielemtext
		Checksum: 0x106334A7
		Offset: 0xA00
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_blue(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "blue", value);
	}

	/*
		Name: set_green
		Namespace: cluielemtext
		Checksum: 0x3B29E600
		Offset: 0x9C8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_green(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "green", value);
	}

	/*
		Name: set_red
		Namespace: cluielemtext
		Checksum: 0x45747ADA
		Offset: 0x990
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_red(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "red", value);
	}

	/*
		Name: set_alpha
		Namespace: cluielemtext
		Checksum: 0x8CE82786
		Offset: 0x958
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_alpha(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "alpha", value);
	}

	/*
		Name: set_fadeovertime
		Namespace: cluielemtext
		Checksum: 0xCAA8B5E2
		Offset: 0x920
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_fadeovertime(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "fadeOverTime", value);
	}

	/*
		Name: set_height
		Namespace: cluielemtext
		Checksum: 0x71987773
		Offset: 0x8E8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_height(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "height", value);
	}

	/*
		Name: set_y
		Namespace: cluielemtext
		Checksum: 0xB8DE9E74
		Offset: 0x8B0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_y(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "y", value);
	}

	/*
		Name: set_x
		Namespace: cluielemtext
		Checksum: 0x202AC311
		Offset: 0x878
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_x(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "x", value);
	}

	/*
		Name: open
		Namespace: cluielemtext
		Checksum: 0xC0CF9F7F
		Offset: 0x840
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"luielemtext");
	}

	/*
		Name: function_fa582112
		Namespace: cluielemtext
		Checksum: 0xCE3A691A
		Offset: 0x6D0
		Size: 0x168
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "x", 0);
		[[ self ]]->set_data(localclientnum, "y", 0);
		[[ self ]]->set_data(localclientnum, "height", 0);
		[[ self ]]->set_data(localclientnum, "fadeOverTime", 0);
		[[ self ]]->set_data(localclientnum, "alpha", 0);
		[[ self ]]->set_data(localclientnum, "red", 0);
		[[ self ]]->set_data(localclientnum, "green", 0);
		[[ self ]]->set_data(localclientnum, "blue", 0);
		[[ self ]]->set_data(localclientnum, "text", #"");
		[[ self ]]->set_data(localclientnum, "horizontal_alignment", 0);
	}

	/*
		Name: register_clientside
		Namespace: cluielemtext
		Checksum: 0xC7AFAA4C
		Offset: 0x6A0
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
		Namespace: cluielemtext
		Checksum: 0x9B9CD1E0
		Offset: 0x490
		Size: 0x204
		Parameters: 11
		Flags: None
	*/
	function setup_clientfields(uid, xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_f5852d69, horizontal_alignmentcallback)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("x", 1, 7, "int", xcallback);
		cluielem::add_clientfield("y", 1, 6, "int", ycallback);
		cluielem::add_clientfield("height", 1, 2, "int", heightcallback);
		cluielem::add_clientfield("fadeOverTime", 1, 5, "int", fadeovertimecallback);
		cluielem::add_clientfield("alpha", 1, 4, "float", alphacallback);
		cluielem::add_clientfield("red", 1, 4, "float", redcallback);
		cluielem::add_clientfield("green", 1, 4, "float", greencallback);
		cluielem::add_clientfield("blue", 1, 4, "float", bluecallback);
		cluielem::function_dcb34c80("string", "text", 1);
		cluielem::add_clientfield("horizontal_alignment", 1, 2, "int", horizontal_alignmentcallback);
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
function register(uid, xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_f5852d69, horizontal_alignmentcallback)
{
	elem = new cluielemtext();
	[[ elem ]]->setup_clientfields(uid, xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_f5852d69, horizontal_alignmentcallback);
	return elem;
}

/*
	Name: register_clientside
	Namespace: luielemtext
	Checksum: 0x73DA1F93
	Offset: 0x1D0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cluielemtext();
	[[ elem ]]->register_clientside(uid);
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
	Name: set_height
	Namespace: luielemtext
	Checksum: 0xC4C1B80
	Offset: 0x2F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_height(localclientnum, value)
{
	[[ self ]]->set_height(localclientnum, value);
}

/*
	Name: set_fadeovertime
	Namespace: luielemtext
	Checksum: 0xD59A67C6
	Offset: 0x320
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_fadeovertime(localclientnum, value)
{
	[[ self ]]->set_fadeovertime(localclientnum, value);
}

/*
	Name: set_alpha
	Namespace: luielemtext
	Checksum: 0xE436257E
	Offset: 0x350
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_alpha(localclientnum, value)
{
	[[ self ]]->set_alpha(localclientnum, value);
}

/*
	Name: set_red
	Namespace: luielemtext
	Checksum: 0x11F87B37
	Offset: 0x380
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_red(localclientnum, value)
{
	[[ self ]]->set_red(localclientnum, value);
}

/*
	Name: set_green
	Namespace: luielemtext
	Checksum: 0x997375A8
	Offset: 0x3B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_green(localclientnum, value)
{
	[[ self ]]->set_green(localclientnum, value);
}

/*
	Name: set_blue
	Namespace: luielemtext
	Checksum: 0x1DD09B2A
	Offset: 0x3E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_blue(localclientnum, value)
{
	[[ self ]]->set_blue(localclientnum, value);
}

/*
	Name: set_text
	Namespace: luielemtext
	Checksum: 0x41E47EC7
	Offset: 0x410
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_text(localclientnum, value)
{
	[[ self ]]->set_text(localclientnum, value);
}

/*
	Name: set_horizontal_alignment
	Namespace: luielemtext
	Checksum: 0x7CCF3952
	Offset: 0x440
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_horizontal_alignment(localclientnum, value)
{
	[[ self ]]->set_horizontal_alignment(localclientnum, value);
}

