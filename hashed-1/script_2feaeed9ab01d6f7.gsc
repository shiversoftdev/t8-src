// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cfull_screen_black : cLUIelem
{

	/*
		Name: constructor
		Namespace: cfull_screen_black
		Checksum: 0xE8886016
		Offset: 0x3A0
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
		Checksum: 0x643ED5B6
		Offset: 0x848
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
		Checksum: 0xA96A7069
		Offset: 0x810
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_drawHUD(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "drawHUD", value);
	}

	/*
		Name: set_endAlpha
		Namespace: cfull_screen_black
		Checksum: 0x762135CA
		Offset: 0x7D8
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_endAlpha(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "endAlpha", value);
	}

	/*
		Name: set_startAlpha
		Namespace: cfull_screen_black
		Checksum: 0x2F79870B
		Offset: 0x7A0
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_startAlpha(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "startAlpha", value);
	}

	/*
		Name: set_fadeOverTime
		Namespace: cfull_screen_black
		Checksum: 0x780C8161
		Offset: 0x768
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_fadeOverTime(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "fadeOverTime", value);
	}

	/*
		Name: set_blue
		Namespace: cfull_screen_black
		Checksum: 0x51E86F79
		Offset: 0x730
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_blue(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "blue", value);
	}

	/*
		Name: set_green
		Namespace: cfull_screen_black
		Checksum: 0x87EFAB85
		Offset: 0x6F8
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_green(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "green", value);
	}

	/*
		Name: set_red
		Namespace: cfull_screen_black
		Checksum: 0x59BF51D1
		Offset: 0x6C0
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_red(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "red", value);
	}

	/*
		Name: open
		Namespace: cfull_screen_black
		Checksum: 0x1F1F9B49
		Offset: 0x688
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"full_screen_black");
	}

	/*
		Name: function_fa582112
		Namespace: cfull_screen_black
		Checksum: 0xD53FCE31
		Offset: 0x570
		Size: 0x110
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "red", 0);
		[[ self ]]->set_data(localclientnum, "green", 0);
		[[ self ]]->set_data(localclientnum, "blue", 0);
		[[ self ]]->set_data(localclientnum, "fadeOverTime", 0);
		[[ self ]]->set_data(localclientnum, "startAlpha", 0);
		[[ self ]]->set_data(localclientnum, "endAlpha", 0);
		[[ self ]]->set_data(localclientnum, "drawHUD", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cfull_screen_black
		Checksum: 0x805BB644
		Offset: 0x540
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		cLUIelem::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cfull_screen_black
		Checksum: 0xB7350A45
		Offset: 0x3C0
		Size: 0x174
		Parameters: 8
		Flags: Linked
	*/
	function setup_clientfields(uid, redcallback, greencallback, bluecallback, fadeOverTimecallback, var_b046940, var_34291db, var_32445b2)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("red", 1, 3, "float", redcallback);
		cLUIelem::function_da693cbe("green", 1, 3, "float", greencallback);
		cLUIelem::function_da693cbe("blue", 1, 3, "float", bluecallback);
		cLUIelem::function_da693cbe("fadeOverTime", 1, 12, "int", fadeOverTimecallback);
		cLUIelem::function_da693cbe("startAlpha", 1, 5, "float", var_b046940);
		cLUIelem::function_da693cbe("endAlpha", 1, 5, "float", var_34291db);
		cLUIelem::function_da693cbe("drawHUD", 1, 1, "int", var_32445b2);
	}

}

#namespace full_screen_black;

/*
	Name: register
	Namespace: full_screen_black
	Checksum: 0x320D2459
	Offset: 0xF0
	Size: 0x94
	Parameters: 8
	Flags: Linked
*/
function register(uid, redcallback, greencallback, bluecallback, fadeOverTimecallback, var_b046940, var_34291db, var_32445b2)
{
	elem = new cfull_screen_black();
	[[ elem ]]->setup_clientfields(uid, redcallback, greencallback, bluecallback, fadeOverTimecallback, var_b046940, var_34291db, var_32445b2);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: full_screen_black
	Checksum: 0x9EC43F2D
	Offset: 0x190
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cfull_screen_black();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: full_screen_black
	Checksum: 0xB631F30B
	Offset: 0x1D8
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
	Namespace: full_screen_black
	Checksum: 0x131FB4BD
	Offset: 0x200
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
	Checksum: 0xE1A3A1E5
	Offset: 0x228
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_red
	Namespace: full_screen_black
	Checksum: 0x7056E8B8
	Offset: 0x250
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
	Namespace: full_screen_black
	Checksum: 0x9C50F715
	Offset: 0x280
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
	Namespace: full_screen_black
	Checksum: 0xD20AB2CD
	Offset: 0x2B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_blue(localclientnum, value)
{
	[[ self ]]->set_blue(localclientnum, value);
}

/*
	Name: set_fadeOverTime
	Namespace: full_screen_black
	Checksum: 0x4371CE57
	Offset: 0x2E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_fadeOverTime(localclientnum, value)
{
	[[ self ]]->set_fadeOverTime(localclientnum, value);
}

/*
	Name: set_startAlpha
	Namespace: full_screen_black
	Checksum: 0x558D1C5A
	Offset: 0x310
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_startAlpha(localclientnum, value)
{
	[[ self ]]->set_startAlpha(localclientnum, value);
}

/*
	Name: set_endAlpha
	Namespace: full_screen_black
	Checksum: 0x9254A5B7
	Offset: 0x340
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_endAlpha(localclientnum, value)
{
	[[ self ]]->set_endAlpha(localclientnum, value);
}

/*
	Name: set_drawHUD
	Namespace: full_screen_black
	Checksum: 0xBBD2D0CF
	Offset: 0x370
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_drawHUD(localclientnum, value)
{
	[[ self ]]->set_drawHUD(localclientnum, value);
}

