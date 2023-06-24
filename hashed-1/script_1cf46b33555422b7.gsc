// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cLUIelemText : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cLUIelemText
		Checksum: 0xA4348636
		Offset: 0x680
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cLUIelemText
		Checksum: 0x85FB5DC6
		Offset: 0xBB0
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_horizontal_alignment
		Namespace: cLUIelemText
		Checksum: 0x86AD5162
		Offset: 0xB68
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_horizontal_alignment(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "horizontal_alignment", value);
	}

	/*
		Name: set_text
		Namespace: cLUIelemText
		Checksum: 0xF3351EC2
		Offset: 0xB20
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_text(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "text", value);
	}

	/*
		Name: set_blue
		Namespace: cLUIelemText
		Checksum: 0x1F70E891
		Offset: 0xAD8
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
		Namespace: cLUIelemText
		Checksum: 0xB2EC60A3
		Offset: 0xA90
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
		Namespace: cLUIelemText
		Checksum: 0xC851CA97
		Offset: 0xA48
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
		Namespace: cLUIelemText
		Checksum: 0xA694FD16
		Offset: 0xA00
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
		Namespace: cLUIelemText
		Checksum: 0x306B53CC
		Offset: 0x9B8
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
		Namespace: cLUIelemText
		Checksum: 0x88D3B37A
		Offset: 0x970
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_height(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "height", value);
	}

	/*
		Name: set_y
		Namespace: cLUIelemText
		Checksum: 0x1A55E49E
		Offset: 0x928
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
		Namespace: cLUIelemText
		Checksum: 0xADB407BC
		Offset: 0x8E0
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
		Namespace: cLUIelemText
		Checksum: 0x8CFD21CC
		Offset: 0x8B0
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
		Namespace: cLUIelemText
		Checksum: 0x4754AAD2
		Offset: 0x860
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "LUIelemText", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cLUIelemText
		Checksum: 0xF758A3A7
		Offset: 0x6A0
		Size: 0x1B4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("x", 1, 7, "int");
		cLUIelem::function_da693cbe("y", 1, 6, "int");
		cLUIelem::function_da693cbe("height", 1, 2, "int");
		cLUIelem::function_da693cbe("fadeOverTime", 1, 5, "int");
		cLUIelem::function_da693cbe("alpha", 1, 4, "float");
		cLUIelem::function_da693cbe("red", 1, 4, "float");
		cLUIelem::function_da693cbe("green", 1, 4, "float");
		cLUIelem::function_da693cbe("blue", 1, 4, "float");
		cLUIelem::function_dcb34c80("string", "text", 1);
		cLUIelem::function_da693cbe("horizontal_alignment", 1, 2, "int");
	}

}

#namespace luielemtext;

/*
	Name: set_color
	Namespace: luielemtext
	Checksum: 0xEDAC895
	Offset: 0x128
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
	Namespace: luielemtext
	Checksum: 0x96C0E923
	Offset: 0x1A0
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
	Namespace: luielemtext
	Checksum: 0x46633C7B
	Offset: 0x228
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
	Namespace: luielemtext
	Checksum: 0x86D6E7C
	Offset: 0x278
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
	Namespace: luielemtext
	Checksum: 0x3E49ABE2
	Offset: 0x2C0
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
	Namespace: luielemtext
	Checksum: 0x23F2A554
	Offset: 0x318
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
	Namespace: luielemtext
	Checksum: 0xC7766D26
	Offset: 0x370
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
	Name: register
	Namespace: luielemtext
	Checksum: 0x6A06ACB2
	Offset: 0x3C8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cLUIelemText();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: luielemtext
	Checksum: 0xC0F66C4A
	Offset: 0x410
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
	Namespace: luielemtext
	Checksum: 0x32CCE914
	Offset: 0x450
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
	Checksum: 0xF6874ACB
	Offset: 0x478
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
	Namespace: luielemtext
	Checksum: 0x2DC1344F
	Offset: 0x4A0
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
	Namespace: luielemtext
	Checksum: 0x58E62611
	Offset: 0x4D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_y(player, value)
{
	[[ self ]]->set_y(player, value);
}

/*
	Name: set_height
	Namespace: luielemtext
	Checksum: 0x83DE11DE
	Offset: 0x500
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
	Namespace: luielemtext
	Checksum: 0x4F302CBD
	Offset: 0x530
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
	Namespace: luielemtext
	Checksum: 0x37EA2FA8
	Offset: 0x560
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
	Namespace: luielemtext
	Checksum: 0x68F834FB
	Offset: 0x590
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
	Namespace: luielemtext
	Checksum: 0x6C9486A5
	Offset: 0x5C0
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
	Namespace: luielemtext
	Checksum: 0x36E08A6D
	Offset: 0x5F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_blue(player, value)
{
	[[ self ]]->set_blue(player, value);
}

/*
	Name: set_text
	Namespace: luielemtext
	Checksum: 0x63BD16F8
	Offset: 0x620
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_text(player, value)
{
	[[ self ]]->set_text(player, value);
}

/*
	Name: set_horizontal_alignment
	Namespace: luielemtext
	Checksum: 0xA898BDB4
	Offset: 0x650
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_horizontal_alignment(player, value)
{
	[[ self ]]->set_horizontal_alignment(player, value);
}

