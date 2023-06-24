// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class czm_game_timer : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: czm_game_timer
		Checksum: 0x60B2E0D4
		Offset: 0x240
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_game_timer
		Checksum: 0x27A8A3E0
		Offset: 0x460
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_showzero
		Namespace: czm_game_timer
		Checksum: 0xE0068F7C
		Offset: 0x418
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_showzero(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "showzero", value);
	}

	/*
		Name: set_minutes
		Namespace: czm_game_timer
		Checksum: 0xF7CE0420
		Offset: 0x3D0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_minutes(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "minutes", value);
	}

	/*
		Name: set_seconds
		Namespace: czm_game_timer
		Checksum: 0xDD0CC3A0
		Offset: 0x388
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_seconds(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "seconds", value);
	}

	/*
		Name: close
		Namespace: czm_game_timer
		Checksum: 0xA0F6997F
		Offset: 0x358
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
		Namespace: czm_game_timer
		Checksum: 0xA0872563
		Offset: 0x308
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "zm_game_timer", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_game_timer
		Checksum: 0x9A2525F1
		Offset: 0x260
		Size: 0x9C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("seconds", 1, 6, "int");
		cLUIelem::function_da693cbe("minutes", 1, 9, "int");
		cLUIelem::function_da693cbe("showzero", 1, 1, "int");
	}

}

#namespace zm_game_timer;

/*
	Name: register
	Namespace: zm_game_timer
	Checksum: 0xC1AE6460
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new czm_game_timer();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_game_timer
	Checksum: 0x1D9C3837
	Offset: 0x120
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
	Namespace: zm_game_timer
	Checksum: 0x4DF7D4EA
	Offset: 0x160
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
	Checksum: 0xFFA7BCDB
	Offset: 0x188
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_seconds
	Namespace: zm_game_timer
	Checksum: 0x680352E8
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_seconds(player, value)
{
	[[ self ]]->set_seconds(player, value);
}

/*
	Name: set_minutes
	Namespace: zm_game_timer
	Checksum: 0x56D6FB4A
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_minutes(player, value)
{
	[[ self ]]->set_minutes(player, value);
}

/*
	Name: set_showzero
	Namespace: zm_game_timer
	Checksum: 0x3835487B
	Offset: 0x210
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_showzero(player, value)
{
	[[ self ]]->set_showzero(player, value);
}

