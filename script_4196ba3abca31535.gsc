// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cluielembar_ct : cluielem
{

	/*
		Name: constructor
		Namespace: cluielembar_ct
		Checksum: 0x9552399B
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
		Namespace: cluielembar_ct
		Checksum: 0x3176BE4B
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
		Namespace: cluielembar_ct
		Checksum: 0xE80895C1
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
		Namespace: cluielembar_ct
		Checksum: 0xEE88222A
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
		Namespace: cluielembar_ct
		Checksum: 0xD281BE9A
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
		Namespace: cluielembar_ct
		Checksum: 0xD56186FF
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
		Namespace: cluielembar_ct
		Checksum: 0xE180EDA0
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
		Name: set_fadeovertime
		Namespace: cluielembar_ct
		Checksum: 0x45E20C67
		Offset: 0x948
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
		Namespace: cluielembar_ct
		Checksum: 0xF690483E
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
		Namespace: cluielembar_ct
		Checksum: 0x1EB39F13
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
		Namespace: cluielembar_ct
		Checksum: 0x32CD2CF9
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
		Namespace: cluielembar_ct
		Checksum: 0x7AF11FC3
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
		Namespace: cluielembar_ct
		Checksum: 0x9E700B97
		Offset: 0x830
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"luielembar_ct");
	}

	/*
		Name: function_fa582112
		Namespace: cluielembar_ct
		Checksum: 0xE101569F
		Offset: 0x6C0
		Size: 0x164
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
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
		Name: register_clientside
		Namespace: cluielembar_ct
		Checksum: 0xF0EBF426
		Offset: 0x690
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
		Namespace: cluielembar_ct
		Checksum: 0x6B11F23
		Offset: 0x480
		Size: 0x204
		Parameters: 11
		Flags: None
	*/
	function setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("x", 1, 7, "int", xcallback);
		cluielem::add_clientfield("y", 1, 6, "int", ycallback);
		cluielem::add_clientfield("width", 1, 6, "int", widthcallback);
		cluielem::add_clientfield("height", 1, 6, "int", heightcallback);
		cluielem::add_clientfield("fadeOverTime", 1, 5, "int", fadeovertimecallback);
		cluielem::add_clientfield("alpha", 1, 4, "float", alphacallback);
		cluielem::add_clientfield("red", 1, 4, "float", redcallback);
		cluielem::add_clientfield("green", 1, 4, "float", greencallback);
		cluielem::add_clientfield("blue", 1, 4, "float", bluecallback);
		cluielem::add_clientfield("bar_percent", 1, 6, "float", var_661989d5);
	}

}

#namespace luielembar_ct;

/*
	Name: register
	Namespace: luielembar_ct
	Checksum: 0xC78FF3E3
	Offset: 0x100
	Size: 0xB8
	Parameters: 11
	Flags: None
*/
function register(uid, xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5)
{
	elem = new cluielembar_ct();
	[[ elem ]]->setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5);
	return elem;
}

/*
	Name: register_clientside
	Namespace: luielembar_ct
	Checksum: 0x8A04876A
	Offset: 0x1C0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cluielembar_ct();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielembar_ct
	Checksum: 0x98C690E6
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
	Namespace: luielembar_ct
	Checksum: 0x1B4BBCE1
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
	Namespace: luielembar_ct
	Checksum: 0x9C4CC37E
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
	Namespace: luielembar_ct
	Checksum: 0x9A9D85C8
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
	Namespace: luielembar_ct
	Checksum: 0x4DD71F72
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
	Namespace: luielembar_ct
	Checksum: 0x7F766C93
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
	Namespace: luielembar_ct
	Checksum: 0x4F79DA60
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
	Name: set_fadeovertime
	Namespace: luielembar_ct
	Checksum: 0xD9625158
	Offset: 0x340
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
	Namespace: luielembar_ct
	Checksum: 0x3F6C09F4
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
	Namespace: luielembar_ct
	Checksum: 0x5F2E3CF1
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
	Namespace: luielembar_ct
	Checksum: 0x4B217B1D
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
	Namespace: luielembar_ct
	Checksum: 0x13AFF87D
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
	Namespace: luielembar_ct
	Checksum: 0xFC0C7953
	Offset: 0x430
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bar_percent(localclientnum, value)
{
	[[ self ]]->set_bar_percent(localclientnum, value);
}

