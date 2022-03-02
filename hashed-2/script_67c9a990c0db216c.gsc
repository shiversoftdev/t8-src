// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_7ca06143 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_7ca06143
		Checksum: 0x73D15B1D
		Offset: 0x350
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_7ca06143
		Checksum: 0xAF8CBDE3
		Offset: 0x730
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_251fc818
		Namespace: namespace_7ca06143
		Checksum: 0xDC36EB36
		Offset: 0x6E8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_251fc818(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "movieKey", value);
	}

	/*
		Name: registerplayer_callout_traversal
		Namespace: namespace_7ca06143
		Checksum: 0x4988A482
		Offset: 0x6A0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function registerplayer_callout_traversal(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "skippable", value);
	}

	/*
		Name: function_3a81612d
		Namespace: namespace_7ca06143
		Checksum: 0x8F3613A0
		Offset: 0x658
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_3a81612d(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "playOutroMovie", value);
	}

	/*
		Name: function_493305af
		Namespace: namespace_7ca06143
		Checksum: 0x94BDF6E6
		Offset: 0x610
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_493305af(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "additive", value);
	}

	/*
		Name: function_5caa21cb
		Namespace: namespace_7ca06143
		Checksum: 0xADA264E
		Offset: 0x5C8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_5caa21cb(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "looping", value);
	}

	/*
		Name: function_8f7a8b9c
		Namespace: namespace_7ca06143
		Checksum: 0x3FE28C1B
		Offset: 0x580
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_8f7a8b9c(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "showBlackScreen", value);
	}

	/*
		Name: function_87bb24
		Namespace: namespace_7ca06143
		Checksum: 0x4ECED0FB
		Offset: 0x538
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_87bb24(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "movieName", value);
	}

	/*
		Name: close
		Namespace: namespace_7ca06143
		Checksum: 0x394FFD5
		Offset: 0x508
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_7ca06143
		Checksum: 0x704C253B
		Offset: 0x4B8
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "full_screen_movie", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_7ca06143
		Checksum: 0x5553D56B
		Offset: 0x370
		Size: 0x13C
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_dcb34c80("moviefile", "movieName", 1);
		namespace_6aaccc24::function_da693cbe("showBlackScreen", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("looping", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("additive", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("playOutroMovie", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("skippable", 1, 1, "int");
		namespace_6aaccc24::function_dcb34c80("moviefile", "movieKey", 18000);
	}

}

#namespace full_screen_movie;

/*
	Name: register
	Namespace: full_screen_movie
	Checksum: 0xF79C536E
	Offset: 0x128
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_7ca06143();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: full_screen_movie
	Checksum: 0xF6470B0
	Offset: 0x170
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
	Namespace: full_screen_movie
	Checksum: 0xCC4A7A58
	Offset: 0x1B0
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
	Namespace: full_screen_movie
	Checksum: 0xF82433D4
	Offset: 0x1D8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_87bb24
	Namespace: full_screen_movie
	Checksum: 0x774E6E2F
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_87bb24(player, value)
{
	[[ self ]]->function_87bb24(player, value);
}

/*
	Name: function_8f7a8b9c
	Namespace: full_screen_movie
	Checksum: 0xE85542FE
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8f7a8b9c(player, value)
{
	[[ self ]]->function_8f7a8b9c(player, value);
}

/*
	Name: function_5caa21cb
	Namespace: full_screen_movie
	Checksum: 0x1316043C
	Offset: 0x260
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5caa21cb(player, value)
{
	[[ self ]]->function_5caa21cb(player, value);
}

/*
	Name: function_493305af
	Namespace: full_screen_movie
	Checksum: 0xC7C6ED35
	Offset: 0x290
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_493305af(player, value)
{
	[[ self ]]->function_493305af(player, value);
}

/*
	Name: function_3a81612d
	Namespace: full_screen_movie
	Checksum: 0x81478F11
	Offset: 0x2C0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3a81612d(player, value)
{
	[[ self ]]->function_3a81612d(player, value);
}

/*
	Name: registerplayer_callout_traversal
	Namespace: full_screen_movie
	Checksum: 0x635BAFCA
	Offset: 0x2F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function registerplayer_callout_traversal(player, value)
{
	[[ self ]]->registerplayer_callout_traversal(player, value);
}

/*
	Name: function_251fc818
	Namespace: full_screen_movie
	Checksum: 0x54C0C316
	Offset: 0x320
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_251fc818(player, value)
{
	[[ self ]]->function_251fc818(player, value);
}

