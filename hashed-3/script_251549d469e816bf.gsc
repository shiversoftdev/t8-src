// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cluielemimage : cLUIelem
{

	/*
		Name: constructor
		Namespace: cluielemimage
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
		Namespace: cluielemimage
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
		Name: set_material
		Namespace: cluielemimage
		Checksum: 0x566FEE0F
		Offset: 0xA60
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_material(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "material", value);
	}

	/*
		Name: set_blue
		Namespace: cluielemimage
		Checksum: 0x3C229E66
		Offset: 0xA28
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
		Namespace: cluielemimage
		Checksum: 0x8776D27E
		Offset: 0x9F0
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
		Namespace: cluielemimage
		Checksum: 0x73D7CE69
		Offset: 0x9B8
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
		Namespace: cluielemimage
		Checksum: 0x99959D0
		Offset: 0x980
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_alpha(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "alpha", value);
	}

	/*
		Name: set_fadeOverTime
		Namespace: cluielemimage
		Checksum: 0x5574019E
		Offset: 0x948
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_fadeOverTime(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "fadeOverTime", value);
	}

	/*
		Name: set_height
		Namespace: cluielemimage
		Checksum: 0xD484F925
		Offset: 0x910
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_height(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "height", value);
	}

	/*
		Name: set_width
		Namespace: cluielemimage
		Checksum: 0x656FC8C1
		Offset: 0x8D8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_width(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "width", value);
	}

	/*
		Name: set_y
		Namespace: cluielemimage
		Checksum: 0x9211EBC0
		Offset: 0x8A0
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
		Namespace: cluielemimage
		Checksum: 0xFA7DAD40
		Offset: 0x868
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
		Namespace: cluielemimage
		Checksum: 0xB682BD37
		Offset: 0x830
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"luielemimage");
	}

	/*
		Name: function_fa582112
		Namespace: cluielemimage
		Checksum: 0x5E8BD47A
		Offset: 0x6B8
		Size: 0x16C
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "x", 0);
		[[ self ]]->set_data(localclientnum, "y", 0);
		[[ self ]]->set_data(localclientnum, "width", 0);
		[[ self ]]->set_data(localclientnum, "height", 0);
		[[ self ]]->set_data(localclientnum, "fadeOverTime", 0);
		[[ self ]]->set_data(localclientnum, "alpha", 0);
		[[ self ]]->set_data(localclientnum, "red", 0);
		[[ self ]]->set_data(localclientnum, "green", 0);
		[[ self ]]->set_data(localclientnum, "blue", 0);
		[[ self ]]->set_data(localclientnum, "material", #"");
	}

	/*
		Name: function_5c1bb138
		Namespace: cluielemimage
		Checksum: 0x6DAB4032
		Offset: 0x688
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
		Namespace: cluielemimage
		Checksum: 0x8114E94B
		Offset: 0x478
		Size: 0x204
		Parameters: 11
		Flags: None
	*/
	function setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeOverTimecallback, alphacallback, redcallback, greencallback, bluecallback, var_e6b6b84b)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("x", 1, 7, "int", xcallback);
		cLUIelem::function_da693cbe("y", 1, 6, "int", ycallback);
		cLUIelem::function_da693cbe("width", 1, 6, "int", widthcallback);
		cLUIelem::function_da693cbe("height", 1, 6, "int", heightcallback);
		cLUIelem::function_da693cbe("fadeOverTime", 1, 5, "int", fadeOverTimecallback);
		cLUIelem::function_da693cbe("alpha", 1, 4, "float", alphacallback);
		cLUIelem::function_da693cbe("red", 1, 4, "float", redcallback);
		cLUIelem::function_da693cbe("green", 1, 4, "float", greencallback);
		cLUIelem::function_da693cbe("blue", 1, 4, "float", bluecallback);
		cLUIelem::function_dcb34c80("material", "material", 1);
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
function register(uid, xcallback, ycallback, widthcallback, heightcallback, fadeOverTimecallback, alphacallback, redcallback, greencallback, bluecallback, var_e6b6b84b)
{
	elem = new cluielemimage();
	[[ elem ]]->setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeOverTimecallback, alphacallback, redcallback, greencallback, bluecallback, var_e6b6b84b);
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
	elem = new cluielemimage();
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
	Name: set_width
	Namespace: luielemimage
	Checksum: 0x4F464214
	Offset: 0x2D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_width(localclientnum, value)
{
	[[ self ]]->set_width(localclientnum, value);
}

/*
	Name: set_height
	Namespace: luielemimage
	Checksum: 0xE53E6A9A
	Offset: 0x308
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_height(localclientnum, value)
{
	[[ self ]]->set_height(localclientnum, value);
}

/*
	Name: set_fadeOverTime
	Namespace: luielemimage
	Checksum: 0xF4F2C88A
	Offset: 0x338
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_fadeOverTime(localclientnum, value)
{
	[[ self ]]->set_fadeOverTime(localclientnum, value);
}

/*
	Name: set_alpha
	Namespace: luielemimage
	Checksum: 0x568FC7AD
	Offset: 0x368
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
	Namespace: luielemimage
	Checksum: 0x1170A18
	Offset: 0x398
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
	Namespace: luielemimage
	Checksum: 0x267816D2
	Offset: 0x3C8
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
	Namespace: luielemimage
	Checksum: 0xB231D50C
	Offset: 0x3F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_blue(localclientnum, value)
{
	[[ self ]]->set_blue(localclientnum, value);
}

/*
	Name: set_material
	Namespace: luielemimage
	Checksum: 0xBA04CF9D
	Offset: 0x428
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_material(localclientnum, value)
{
	[[ self ]]->set_material(localclientnum, value);
}

