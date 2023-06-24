// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cfull_screen_movie : cLUIelem
{

	/*
		Name: constructor
		Namespace: cfull_screen_movie
		Checksum: 0x8A3213F
		Offset: 0x3B8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cfull_screen_movie
		Checksum: 0xB1E92033
		Offset: 0x858
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_movieKey
		Namespace: cfull_screen_movie
		Checksum: 0x99DB496B
		Offset: 0x820
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_movieKey(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "movieKey", value);
	}

	/*
		Name: registerplayer_callout_traversal
		Namespace: cfull_screen_movie
		Checksum: 0xE353861D
		Offset: 0x7E8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function registerplayer_callout_traversal(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "skippable", value);
	}

	/*
		Name: set_playOutroMovie
		Namespace: cfull_screen_movie
		Checksum: 0x570D7D89
		Offset: 0x7B0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_playOutroMovie(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "playOutroMovie", value);
	}

	/*
		Name: set_additive
		Namespace: cfull_screen_movie
		Checksum: 0xB255D71A
		Offset: 0x778
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_additive(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "additive", value);
	}

	/*
		Name: set_looping
		Namespace: cfull_screen_movie
		Checksum: 0xE7B811CB
		Offset: 0x740
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_looping(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "looping", value);
	}

	/*
		Name: set_showBlackScreen
		Namespace: cfull_screen_movie
		Checksum: 0x4AFB6C5B
		Offset: 0x708
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_showBlackScreen(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "showBlackScreen", value);
	}

	/*
		Name: set_movieName
		Namespace: cfull_screen_movie
		Checksum: 0xF88E0BB3
		Offset: 0x6D0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_movieName(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "movieName", value);
	}

	/*
		Name: open
		Namespace: cfull_screen_movie
		Checksum: 0x884FFAAE
		Offset: 0x698
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"full_screen_movie");
	}

	/*
		Name: function_fa582112
		Namespace: cfull_screen_movie
		Checksum: 0xAD0B02B2
		Offset: 0x588
		Size: 0x104
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "movieName", #"");
		[[ self ]]->set_data(localclientnum, "showBlackScreen", 0);
		[[ self ]]->set_data(localclientnum, "looping", 0);
		[[ self ]]->set_data(localclientnum, "additive", 0);
		[[ self ]]->set_data(localclientnum, "playOutroMovie", 0);
		[[ self ]]->set_data(localclientnum, "skippable", 0);
		[[ self ]]->set_data(localclientnum, "movieKey", #"");
	}

	/*
		Name: function_5c1bb138
		Namespace: cfull_screen_movie
		Checksum: 0xB5DE22C
		Offset: 0x558
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
		Namespace: cfull_screen_movie
		Checksum: 0xE1C5B283
		Offset: 0x3D8
		Size: 0x174
		Parameters: 8
		Flags: None
	*/
	function setup_clientfields(uid, var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, var_ea38d488)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_dcb34c80("moviefile", "movieName", 1);
		cLUIelem::function_da693cbe("showBlackScreen", 1, 1, "int", var_d5b04ae3);
		cLUIelem::function_da693cbe("looping", 1, 1, "int", var_e4decd0);
		cLUIelem::function_da693cbe("additive", 1, 1, "int", var_e545d4b9);
		cLUIelem::function_da693cbe("playOutroMovie", 1, 1, "int", var_78184b90);
		cLUIelem::function_da693cbe("skippable", 1, 1, "int", var_8ba396cb);
		cLUIelem::function_dcb34c80("moviefile", "movieKey", 18000);
	}

}

#namespace full_screen_movie;

/*
	Name: register
	Namespace: full_screen_movie
	Checksum: 0xAADD2040
	Offset: 0x108
	Size: 0x94
	Parameters: 8
	Flags: None
*/
function register(uid, var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, var_ea38d488)
{
	elem = new cfull_screen_movie();
	[[ elem ]]->setup_clientfields(uid, var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, var_ea38d488);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: full_screen_movie
	Checksum: 0x157238F4
	Offset: 0x1A8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cfull_screen_movie();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: full_screen_movie
	Checksum: 0xD07721E2
	Offset: 0x1F0
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
	Namespace: full_screen_movie
	Checksum: 0xF10130FA
	Offset: 0x218
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
	Checksum: 0xD83C94E4
	Offset: 0x240
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_movieName
	Namespace: full_screen_movie
	Checksum: 0x6F24A61C
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_movieName(localclientnum, value)
{
	[[ self ]]->set_movieName(localclientnum, value);
}

/*
	Name: set_showBlackScreen
	Namespace: full_screen_movie
	Checksum: 0x40DFC805
	Offset: 0x298
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_showBlackScreen(localclientnum, value)
{
	[[ self ]]->set_showBlackScreen(localclientnum, value);
}

/*
	Name: set_looping
	Namespace: full_screen_movie
	Checksum: 0x9E169BF8
	Offset: 0x2C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_looping(localclientnum, value)
{
	[[ self ]]->set_looping(localclientnum, value);
}

/*
	Name: set_additive
	Namespace: full_screen_movie
	Checksum: 0x4EB25CAA
	Offset: 0x2F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_additive(localclientnum, value)
{
	[[ self ]]->set_additive(localclientnum, value);
}

/*
	Name: set_playOutroMovie
	Namespace: full_screen_movie
	Checksum: 0xDB2B00FA
	Offset: 0x328
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_playOutroMovie(localclientnum, value)
{
	[[ self ]]->set_playOutroMovie(localclientnum, value);
}

/*
	Name: registerplayer_callout_traversal
	Namespace: full_screen_movie
	Checksum: 0x65D7B289
	Offset: 0x358
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function registerplayer_callout_traversal(localclientnum, value)
{
	[[ self ]]->registerplayer_callout_traversal(localclientnum, value);
}

/*
	Name: set_movieKey
	Namespace: full_screen_movie
	Checksum: 0xE8B8249B
	Offset: 0x388
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_movieKey(localclientnum, value)
{
	[[ self ]]->set_movieKey(localclientnum, value);
}

