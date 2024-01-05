// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cfull_screen_movie : cluielem
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
		Name: set_moviekey
		Namespace: cfull_screen_movie
		Checksum: 0x99DB496B
		Offset: 0x820
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_moviekey(localclientnum, value)
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
		Name: set_playoutromovie
		Namespace: cfull_screen_movie
		Checksum: 0x570D7D89
		Offset: 0x7B0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_playoutromovie(localclientnum, value)
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
		Name: set_showblackscreen
		Namespace: cfull_screen_movie
		Checksum: 0x4AFB6C5B
		Offset: 0x708
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_showblackscreen(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "showBlackScreen", value);
	}

	/*
		Name: set_moviename
		Namespace: cfull_screen_movie
		Checksum: 0xF88E0BB3
		Offset: 0x6D0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_moviename(localclientnum, value)
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
		cluielem::open(localclientnum, #"full_screen_movie");
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
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "movieName", #"");
		[[ self ]]->set_data(localclientnum, "showBlackScreen", 0);
		[[ self ]]->set_data(localclientnum, "looping", 0);
		[[ self ]]->set_data(localclientnum, "additive", 0);
		[[ self ]]->set_data(localclientnum, "playOutroMovie", 0);
		[[ self ]]->set_data(localclientnum, "skippable", 0);
		[[ self ]]->set_data(localclientnum, "movieKey", #"");
	}

	/*
		Name: register_clientside
		Namespace: cfull_screen_movie
		Checksum: 0xB5DE22C
		Offset: 0x558
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
		Namespace: cfull_screen_movie
		Checksum: 0xE1C5B283
		Offset: 0x3D8
		Size: 0x174
		Parameters: 8
		Flags: None
	*/
	function setup_clientfields(uid, var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, var_ea38d488)
	{
		cluielem::setup_clientfields(uid);
		cluielem::function_dcb34c80("moviefile", "movieName", 1);
		cluielem::add_clientfield("showBlackScreen", 1, 1, "int", var_d5b04ae3);
		cluielem::add_clientfield("looping", 1, 1, "int", var_e4decd0);
		cluielem::add_clientfield("additive", 1, 1, "int", var_e545d4b9);
		cluielem::add_clientfield("playOutroMovie", 1, 1, "int", var_78184b90);
		cluielem::add_clientfield("skippable", 1, 1, "int", var_8ba396cb);
		cluielem::function_dcb34c80("moviefile", "movieKey", 18000);
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
	Name: register_clientside
	Namespace: full_screen_movie
	Checksum: 0x157238F4
	Offset: 0x1A8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cfull_screen_movie();
	[[ elem ]]->register_clientside(uid);
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
	Name: set_moviename
	Namespace: full_screen_movie
	Checksum: 0x6F24A61C
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_moviename(localclientnum, value)
{
	[[ self ]]->set_moviename(localclientnum, value);
}

/*
	Name: set_showblackscreen
	Namespace: full_screen_movie
	Checksum: 0x40DFC805
	Offset: 0x298
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_showblackscreen(localclientnum, value)
{
	[[ self ]]->set_showblackscreen(localclientnum, value);
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
	Name: set_playoutromovie
	Namespace: full_screen_movie
	Checksum: 0xDB2B00FA
	Offset: 0x328
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_playoutromovie(localclientnum, value)
{
	[[ self ]]->set_playoutromovie(localclientnum, value);
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
	Name: set_moviekey
	Namespace: full_screen_movie
	Checksum: 0xE8B8249B
	Offset: 0x388
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_moviekey(localclientnum, value)
{
	[[ self ]]->set_moviekey(localclientnum, value);
}

