// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cfull_screen_black : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cfull_screen_black
		Checksum: 0x54B57BC7
		Offset: 0x338
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cfull_screen_black
		Checksum: 0xD6F5972
		Offset: 0x718
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_drawHUD
		Namespace: cfull_screen_black
		Checksum: 0x5BA0AB8B
		Offset: 0x6D0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_drawHUD(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "drawHUD", value);
	}

	/*
		Name: set_endAlpha
		Namespace: cfull_screen_black
		Checksum: 0x811F9F36
		Offset: 0x688
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_endAlpha(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "endAlpha", value);
	}

	/*
		Name: set_startAlpha
		Namespace: cfull_screen_black
		Checksum: 0x9E5EFDDD
		Offset: 0x640
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_startAlpha(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "startAlpha", value);
	}

	/*
		Name: set_fadeOverTime
		Namespace: cfull_screen_black
		Checksum: 0x48606386
		Offset: 0x5F8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_fadeOverTime(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "fadeOverTime", value);
	}

	/*
		Name: set_blue
		Namespace: cfull_screen_black
		Checksum: 0xB645405C
		Offset: 0x5B0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_blue(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "blue", value);
	}

	/*
		Name: set_green
		Namespace: cfull_screen_black
		Checksum: 0x3EA3E646
		Offset: 0x568
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_green(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "green", value);
	}

	/*
		Name: set_red
		Namespace: cfull_screen_black
		Checksum: 0xC1C03DA9
		Offset: 0x520
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_red(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "red", value);
	}

	/*
		Name: close
		Namespace: cfull_screen_black
		Checksum: 0xE999F1F1
		Offset: 0x4F0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		cLUIelem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cfull_screen_black
		Checksum: 0x7430C660
		Offset: 0x4A0
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "full_screen_black", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cfull_screen_black
		Checksum: 0xB966D78B
		Offset: 0x358
		Size: 0x13C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("red", 1, 3, "float");
		cLUIelem::function_da693cbe("green", 1, 3, "float");
		cLUIelem::function_da693cbe("blue", 1, 3, "float");
		cLUIelem::function_da693cbe("fadeOverTime", 1, 12, "int");
		cLUIelem::function_da693cbe("startAlpha", 1, 5, "float");
		cLUIelem::function_da693cbe("endAlpha", 1, 5, "float");
		cLUIelem::function_da693cbe("drawHUD", 1, 1, "int");
	}

}

#namespace full_screen_black;

/*
	Name: register
	Namespace: full_screen_black
	Checksum: 0xF1263C65
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new cfull_screen_black();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: full_screen_black
	Checksum: 0x9AD0A281
	Offset: 0x158
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
	Namespace: full_screen_black
	Checksum: 0xB1EFB1CE
	Offset: 0x198
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
	Namespace: full_screen_black
	Checksum: 0x6426584C
	Offset: 0x1C0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_red
	Namespace: full_screen_black
	Checksum: 0xC79397A5
	Offset: 0x1E8
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
	Namespace: full_screen_black
	Checksum: 0x325F92C7
	Offset: 0x218
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
	Namespace: full_screen_black
	Checksum: 0x766C5795
	Offset: 0x248
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_blue(player, value)
{
	[[ self ]]->set_blue(player, value);
}

/*
	Name: set_fadeOverTime
	Namespace: full_screen_black
	Checksum: 0xA409C164
	Offset: 0x278
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_fadeOverTime(player, value)
{
	[[ self ]]->set_fadeOverTime(player, value);
}

/*
	Name: set_startAlpha
	Namespace: full_screen_black
	Checksum: 0xBB08F74A
	Offset: 0x2A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_startAlpha(player, value)
{
	[[ self ]]->set_startAlpha(player, value);
}

/*
	Name: set_endAlpha
	Namespace: full_screen_black
	Checksum: 0x9AA7315
	Offset: 0x2D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_endAlpha(player, value)
{
	[[ self ]]->set_endAlpha(player, value);
}

/*
	Name: set_drawHUD
	Namespace: full_screen_black
	Checksum: 0x99782CD0
	Offset: 0x308
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_drawHUD(player, value)
{
	[[ self ]]->set_drawHUD(player, value);
}

