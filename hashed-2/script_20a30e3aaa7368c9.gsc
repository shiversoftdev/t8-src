// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cLUIelemBar_ct : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cLUIelemBar_ct
		Checksum: 0x9A0989D9
		Offset: 0x708
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cLUIelemBar_ct
		Checksum: 0x7A01DD2A
		Offset: 0xC38
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_bar_percent
		Namespace: cLUIelemBar_ct
		Checksum: 0xEB6F5279
		Offset: 0xBF0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_bar_percent(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "bar_percent", value);
	}

	/*
		Name: set_blue
		Namespace: cLUIelemBar_ct
		Checksum: 0xA446DE64
		Offset: 0xBA8
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
		Namespace: cLUIelemBar_ct
		Checksum: 0x7DE0DD94
		Offset: 0xB60
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
		Namespace: cLUIelemBar_ct
		Checksum: 0x88B698E3
		Offset: 0xB18
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
		Namespace: cLUIelemBar_ct
		Checksum: 0xFDFFA5D3
		Offset: 0xAD0
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
		Namespace: cLUIelemBar_ct
		Checksum: 0xE565C188
		Offset: 0xA88
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
		Namespace: cLUIelemBar_ct
		Checksum: 0x8592683D
		Offset: 0xA40
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
		Namespace: cLUIelemBar_ct
		Checksum: 0x7091CF0B
		Offset: 0x9F8
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
		Namespace: cLUIelemBar_ct
		Checksum: 0xBEA0A124
		Offset: 0x9B0
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
		Namespace: cLUIelemBar_ct
		Checksum: 0x9AE01914
		Offset: 0x968
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
		Namespace: cLUIelemBar_ct
		Checksum: 0x7C3A5041
		Offset: 0x938
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
		Namespace: cLUIelemBar_ct
		Checksum: 0x272F7E96
		Offset: 0x8E8
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "LUIelemBar_ct", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cLUIelemBar_ct
		Checksum: 0x553F19E7
		Offset: 0x728
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
		cLUIelem::function_da693cbe("bar_percent", 1, 6, "float");
	}

}

#namespace luielembar_ct;

/*
	Name: set_color
	Namespace: luielembar_ct
	Checksum: 0x7FE53244
	Offset: 0x118
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
	Namespace: luielembar_ct
	Checksum: 0x7A2ABFF0
	Offset: 0x190
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
	Namespace: luielembar_ct
	Checksum: 0xD5B4E639
	Offset: 0x218
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
	Namespace: luielembar_ct
	Checksum: 0xA36AC881
	Offset: 0x268
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
	Namespace: luielembar_ct
	Checksum: 0x5148E2B7
	Offset: 0x2B0
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
	Namespace: luielembar_ct
	Checksum: 0xE1CEED50
	Offset: 0x308
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
	Namespace: luielembar_ct
	Checksum: 0x5F039D9E
	Offset: 0x360
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
	Namespace: luielembar_ct
	Checksum: 0x4A8C1B8D
	Offset: 0x3B8
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
	Namespace: luielembar_ct
	Checksum: 0x9A8D91F2
	Offset: 0x450
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cLUIelemBar_ct();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielembar_ct
	Checksum: 0x66AE096C
	Offset: 0x498
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
	Namespace: luielembar_ct
	Checksum: 0xD1E25B03
	Offset: 0x4D8
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
	Checksum: 0xADBC8B3C
	Offset: 0x500
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
	Namespace: luielembar_ct
	Checksum: 0x878B3D10
	Offset: 0x528
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
	Namespace: luielembar_ct
	Checksum: 0xFB4B9304
	Offset: 0x558
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
	Namespace: luielembar_ct
	Checksum: 0x93FF9059
	Offset: 0x588
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
	Namespace: luielembar_ct
	Checksum: 0x791F10A3
	Offset: 0x5B8
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
	Namespace: luielembar_ct
	Checksum: 0x4F7FF27D
	Offset: 0x5E8
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
	Namespace: luielembar_ct
	Checksum: 0xB493EE0
	Offset: 0x618
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
	Namespace: luielembar_ct
	Checksum: 0x9DF3BFF2
	Offset: 0x648
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
	Namespace: luielembar_ct
	Checksum: 0x6C07628A
	Offset: 0x678
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
	Namespace: luielembar_ct
	Checksum: 0x72764BFA
	Offset: 0x6A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_blue(player, value)
{
	[[ self ]]->set_blue(player, value);
}

/*
	Name: set_bar_percent
	Namespace: luielembar_ct
	Checksum: 0x5FD1F414
	Offset: 0x6D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bar_percent(player, value)
{
	[[ self ]]->set_bar_percent(player, value);
}

