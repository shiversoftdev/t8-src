// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_game_timer : cLUIelem
{

	/*
		Name: constructor
		Namespace: czm_game_timer
		Checksum: 0xBAFC6C13
		Offset: 0x280
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_game_timer
		Checksum: 0x201650C4
		Offset: 0x4F0
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_showzero
		Namespace: czm_game_timer
		Checksum: 0x244B186E
		Offset: 0x4B8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_showzero(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "showzero", value);
	}

	/*
		Name: set_minutes
		Namespace: czm_game_timer
		Checksum: 0x474EEA73
		Offset: 0x480
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_minutes(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "minutes", value);
	}

	/*
		Name: set_seconds
		Namespace: czm_game_timer
		Checksum: 0x44EB424D
		Offset: 0x448
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_seconds(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "seconds", value);
	}

	/*
		Name: open
		Namespace: czm_game_timer
		Checksum: 0x91F1521
		Offset: 0x410
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"zm_game_timer");
	}

	/*
		Name: function_fa582112
		Namespace: czm_game_timer
		Checksum: 0xE2A72655
		Offset: 0x390
		Size: 0x78
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "seconds", 0);
		[[ self ]]->set_data(localclientnum, "minutes", 0);
		[[ self ]]->set_data(localclientnum, "showzero", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: czm_game_timer
		Checksum: 0xDEFB438D
		Offset: 0x360
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
		Namespace: czm_game_timer
		Checksum: 0xFB9F5F43
		Offset: 0x2A0
		Size: 0xB4
		Parameters: 4
		Flags: None
	*/
	function setup_clientfields(uid, var_b1de907e, var_359a4d9a, var_8fd8bfaa)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("seconds", 1, 6, "int", var_b1de907e);
		cLUIelem::function_da693cbe("minutes", 1, 9, "int", var_359a4d9a);
		cLUIelem::function_da693cbe("showzero", 1, 1, "int", var_8fd8bfaa);
	}

}

#namespace zm_game_timer;

/*
	Name: register
	Namespace: zm_game_timer
	Checksum: 0x770EF87A
	Offset: 0xC0
	Size: 0x64
	Parameters: 4
	Flags: None
*/
function register(uid, var_b1de907e, var_359a4d9a, var_8fd8bfaa)
{
	elem = new czm_game_timer();
	[[ elem ]]->setup_clientfields(uid, var_b1de907e, var_359a4d9a, var_8fd8bfaa);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_game_timer
	Checksum: 0x1AA696BE
	Offset: 0x130
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new czm_game_timer();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_game_timer
	Checksum: 0xCB4327C5
	Offset: 0x178
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
	Namespace: zm_game_timer
	Checksum: 0x30C88B9B
	Offset: 0x1A0
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
	Namespace: zm_game_timer
	Checksum: 0xDCA510B8
	Offset: 0x1C8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_seconds
	Namespace: zm_game_timer
	Checksum: 0x73B55EBE
	Offset: 0x1F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_seconds(localclientnum, value)
{
	[[ self ]]->set_seconds(localclientnum, value);
}

/*
	Name: set_minutes
	Namespace: zm_game_timer
	Checksum: 0xFDA88E29
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_minutes(localclientnum, value)
{
	[[ self ]]->set_minutes(localclientnum, value);
}

/*
	Name: set_showzero
	Namespace: zm_game_timer
	Checksum: 0xB436270D
	Offset: 0x250
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_showzero(localclientnum, value)
{
	[[ self ]]->set_showzero(localclientnum, value);
}

