// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cLUIelemBar : cLUIelem
{

	/*
		Name: constructor
		Namespace: cLUIelemBar
		Checksum: 0x64657531
		Offset: 0x460
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cLUIelemBar
		Checksum: 0x3159A9FE
		Offset: 0xA98
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_bar_percent
		Namespace: cLUIelemBar
		Checksum: 0x8347C90D
		Offset: 0xA60
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_bar_percent(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bar_percent", value);
	}

	/*
		Name: set_blue
		Namespace: cLUIelemBar
		Checksum: 0x257ED69E
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
		Namespace: cLUIelemBar
		Checksum: 0x289A8F28
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
		Namespace: cLUIelemBar
		Checksum: 0x20C35710
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
		Namespace: cLUIelemBar
		Checksum: 0xDBE54FE1
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
		Namespace: cLUIelemBar
		Checksum: 0x469078A5
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
		Namespace: cLUIelemBar
		Checksum: 0x47084C23
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
		Namespace: cLUIelemBar
		Checksum: 0x95FA2214
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
		Namespace: cLUIelemBar
		Checksum: 0x9639EAA3
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
		Namespace: cLUIelemBar
		Checksum: 0x8DA49E60
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
		Namespace: cLUIelemBar
		Checksum: 0x9A6252F5
		Offset: 0x830
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"luielembar");
	}

	/*
		Name: function_fa582112
		Namespace: cLUIelemBar
		Checksum: 0x42078469
		Offset: 0x6C0
		Size: 0x164
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
		[[ self ]]->set_data(localclientnum, "bar_percent", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cLUIelemBar
		Checksum: 0xB6712A86
		Offset: 0x690
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
		Namespace: cLUIelemBar
		Checksum: 0xFA112CF3
		Offset: 0x480
		Size: 0x204
		Parameters: 11
		Flags: None
	*/
	function setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeOverTimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5)
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
		cLUIelem::function_da693cbe("bar_percent", 1, 6, "float", var_661989d5);
	}

}

#namespace luielembar;

/*
	Name: register
	Namespace: luielembar
	Checksum: 0xD181DE7C
	Offset: 0x100
	Size: 0xB8
	Parameters: 11
	Flags: None
*/
function register(uid, xcallback, ycallback, widthcallback, heightcallback, fadeOverTimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5)
{
	elem = new cLUIelemBar();
	[[ elem ]]->setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeOverTimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: luielembar
	Checksum: 0x7BCB3DF
	Offset: 0x1C0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cLUIelemBar();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielembar
	Checksum: 0x4DD9A799
	Offset: 0x208
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
	Namespace: luielembar
	Checksum: 0x9D5F684
	Offset: 0x230
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
	Namespace: luielembar
	Checksum: 0xFD4C96C6
	Offset: 0x258
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
	Namespace: luielembar
	Checksum: 0x60E14AB7
	Offset: 0x280
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
	Namespace: luielembar
	Checksum: 0x86B41C20
	Offset: 0x2B0
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
	Namespace: luielembar
	Checksum: 0x334CEEE8
	Offset: 0x2E0
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
	Namespace: luielembar
	Checksum: 0x6D19A727
	Offset: 0x310
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
	Namespace: luielembar
	Checksum: 0x66B1979C
	Offset: 0x340
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
	Namespace: luielembar
	Checksum: 0x37EDD464
	Offset: 0x370
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
	Namespace: luielembar
	Checksum: 0x4F5E219
	Offset: 0x3A0
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
	Namespace: luielembar
	Checksum: 0x864E9F3
	Offset: 0x3D0
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
	Namespace: luielembar
	Checksum: 0x29228CF7
	Offset: 0x400
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_blue(localclientnum, value)
{
	[[ self ]]->set_blue(localclientnum, value);
}

/*
	Name: set_bar_percent
	Namespace: luielembar
	Checksum: 0x8BBE23C1
	Offset: 0x430
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bar_percent(localclientnum, value)
{
	[[ self ]]->set_bar_percent(localclientnum, value);
}

