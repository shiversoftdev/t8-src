// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cluielemimage : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cluielemimage
		Checksum: 0x67786668
		Offset: 0x700
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
		Checksum: 0x9AEF8BCB
		Offset: 0xC30
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
		Checksum: 0xA8897088
		Offset: 0xBE8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_material(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "material", value);
	}

	/*
		Name: set_blue
		Namespace: cluielemimage
		Checksum: 0xD723AACA
		Offset: 0xBA0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_blue(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "blue", value);
	}

	/*
		Name: set_green
		Namespace: cluielemimage
		Checksum: 0x8D2C5CA3
		Offset: 0xB58
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_green(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "green", value);
	}

	/*
		Name: set_red
		Namespace: cluielemimage
		Checksum: 0x317080C7
		Offset: 0xB10
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_red(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "red", value);
	}

	/*
		Name: set_alpha
		Namespace: cluielemimage
		Checksum: 0x6C7DB9C6
		Offset: 0xAC8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_alpha(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "alpha", value);
	}

	/*
		Name: set_fadeOverTime
		Namespace: cluielemimage
		Checksum: 0x65CB6F2E
		Offset: 0xA80
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_fadeOverTime(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "fadeOverTime", value);
	}

	/*
		Name: set_height
		Namespace: cluielemimage
		Checksum: 0x58608E2B
		Offset: 0xA38
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_height(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "height", value);
	}

	/*
		Name: set_width
		Namespace: cluielemimage
		Checksum: 0xE03C410C
		Offset: 0x9F0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_width(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "width", value);
	}

	/*
		Name: set_y
		Namespace: cluielemimage
		Checksum: 0xB57A3365
		Offset: 0x9A8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_y(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "y", value);
	}

	/*
		Name: set_x
		Namespace: cluielemimage
		Checksum: 0xD365D0D5
		Offset: 0x960
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_x(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "x", value);
	}

	/*
		Name: close
		Namespace: cluielemimage
		Checksum: 0x5903F461
		Offset: 0x930
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cLUIelem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cluielemimage
		Checksum: 0xB2BAD64D
		Offset: 0x8E0
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "LUIelemImage", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cluielemimage
		Checksum: 0x59FC087F
		Offset: 0x720
		Size: 0x1B4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("x", 1, 7, "int");
		cLUIelem::function_da693cbe("y", 1, 6, "int");
		cLUIelem::function_da693cbe("width", 1, 6, "int");
		cLUIelem::function_da693cbe("height", 1, 6, "int");
		cLUIelem::function_da693cbe("fadeOverTime", 1, 5, "int");
		cLUIelem::function_da693cbe("alpha", 1, 4, "float");
		cLUIelem::function_da693cbe("red", 1, 4, "float");
		cLUIelem::function_da693cbe("green", 1, 4, "float");
		cLUIelem::function_da693cbe("blue", 1, 4, "float");
		cLUIelem::function_dcb34c80("material", "material", 1);
	}

}

#namespace luielemimage;

/*
	Name: set_color
	Namespace: luielemimage
	Checksum: 0x283F55BC
	Offset: 0x110
	Size: 0x6C
	Parameters: 4
	Flags: None
*/
function set_color(player, red, green, blue)
{
	self set_red(player, red);
	self set_green(player, green);
	self set_blue(player, blue);
}

/*
	Name: fade
	Namespace: luielemimage
	Checksum: 0x2D0BAEDD
	Offset: 0x188
	Size: 0x7C
	Parameters: 3
	Flags: None
*/
function fade(player, var_1a92607f, duration = 0)
{
	self set_alpha(player, var_1a92607f);
	self set_fadeOverTime(player, int(duration * 10));
}

/*
	Name: show
	Namespace: luielemimage
	Checksum: 0xF9B4AB03
	Offset: 0x210
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function show(player, duration = 0)
{
	self fade(player, 1, duration);
}

/*
	Name: hide
	Namespace: luielemimage
	Checksum: 0xBC7D411
	Offset: 0x260
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function hide(player, duration = 0)
{
	self fade(player, 0, duration);
}

/*
	Name: function_e5898fd7
	Namespace: luielemimage
	Checksum: 0x67FF5A6B
	Offset: 0x2A8
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function function_e5898fd7(player, var_c6572d9b)
{
	self set_x(player, int(var_c6572d9b / 15));
}

/*
	Name: function_58a135d3
	Namespace: luielemimage
	Checksum: 0xDD3921AF
	Offset: 0x300
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function function_58a135d3(player, var_d390c80e)
{
	self set_y(player, int(var_d390c80e / 15));
}

/*
	Name: function_f97e9049
	Namespace: luielemimage
	Checksum: 0x99DF5738
	Offset: 0x358
	Size: 0x4C
	Parameters: 3
	Flags: None
*/
function function_f97e9049(player, var_c6572d9b, var_d390c80e)
{
	self function_e5898fd7(player, var_c6572d9b);
	self function_58a135d3(player, var_d390c80e);
}

/*
	Name: function_35f52fe9
	Namespace: luielemimage
	Checksum: 0x54C8E8E0
	Offset: 0x3B0
	Size: 0x8C
	Parameters: 3
	Flags: None
*/
function function_35f52fe9(player, width, height)
{
	self set_width(player, int(width / 4));
	self set_height(player, int(height / 4));
}

/*
	Name: register
	Namespace: luielemimage
	Checksum: 0xE65702F9
	Offset: 0x448
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cluielemimage();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielemimage
	Checksum: 0xFE8AB30E
	Offset: 0x490
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: luielemimage
	Checksum: 0x51C8B020
	Offset: 0x4D0
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
	Checksum: 0xB1478AC1
	Offset: 0x4F8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_x
	Namespace: luielemimage
	Checksum: 0x8E06CD3E
	Offset: 0x520
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_x(player, value)
{
	[[ self ]]->set_x(player, value);
}

/*
	Name: set_y
	Namespace: luielemimage
	Checksum: 0xD1032C02
	Offset: 0x550
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_y(player, value)
{
	[[ self ]]->set_y(player, value);
}

/*
	Name: set_width
	Namespace: luielemimage
	Checksum: 0x75C49F24
	Offset: 0x580
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_width(player, value)
{
	[[ self ]]->set_width(player, value);
}

/*
	Name: set_height
	Namespace: luielemimage
	Checksum: 0x81EF7A8E
	Offset: 0x5B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_height(player, value)
{
	[[ self ]]->set_height(player, value);
}

/*
	Name: set_fadeOverTime
	Namespace: luielemimage
	Checksum: 0x610AF99F
	Offset: 0x5E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_fadeOverTime(player, value)
{
	[[ self ]]->set_fadeOverTime(player, value);
}

/*
	Name: set_alpha
	Namespace: luielemimage
	Checksum: 0x75BA2E4
	Offset: 0x610
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_alpha(player, value)
{
	[[ self ]]->set_alpha(player, value);
}

/*
	Name: set_red
	Namespace: luielemimage
	Checksum: 0x72B74568
	Offset: 0x640
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_red(player, value)
{
	[[ self ]]->set_red(player, value);
}

/*
	Name: set_green
	Namespace: luielemimage
	Checksum: 0x453C0A98
	Offset: 0x670
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_green(player, value)
{
	[[ self ]]->set_green(player, value);
}

/*
	Name: set_blue
	Namespace: luielemimage
	Checksum: 0xE3EC3EB
	Offset: 0x6A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_blue(player, value)
{
	[[ self ]]->set_blue(player, value);
}

/*
	Name: set_material
	Namespace: luielemimage
	Checksum: 0x1FC4B2B6
	Offset: 0x6D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_material(player, value)
{
	[[ self ]]->set_material(player, value);
}

