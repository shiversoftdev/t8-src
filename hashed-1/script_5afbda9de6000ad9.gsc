// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cremote_missile_targets : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cremote_missile_targets
		Checksum: 0x1633B622
		Offset: 0x2A8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cremote_missile_targets
		Checksum: 0x6A266E3B
		Offset: 0x538
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_extra_target_3
		Namespace: cremote_missile_targets
		Checksum: 0x52EC8BBE
		Offset: 0x4F0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_extra_target_3(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "extra_target_3", value);
	}

	/*
		Name: set_extra_target_2
		Namespace: cremote_missile_targets
		Checksum: 0x7E009F12
		Offset: 0x4A8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_extra_target_2(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "extra_target_2", value);
	}

	/*
		Name: set_extra_target_1
		Namespace: cremote_missile_targets
		Checksum: 0x82AA601F
		Offset: 0x460
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_extra_target_1(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "extra_target_1", value);
	}

	/*
		Name: set_player_target_active
		Namespace: cremote_missile_targets
		Checksum: 0x1D30A022
		Offset: 0x418
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_player_target_active(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "player_target_active", value);
	}

	/*
		Name: close
		Namespace: cremote_missile_targets
		Checksum: 0x23B90DB4
		Offset: 0x3E8
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
		Namespace: cremote_missile_targets
		Checksum: 0x215A9935
		Offset: 0x398
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "remote_missile_targets", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cremote_missile_targets
		Checksum: 0xC9E20CEF
		Offset: 0x2C8
		Size: 0xC4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("player_target_active", 1, 16, "int");
		cLUIelem::function_da693cbe("extra_target_1", 1, 10, "int");
		cLUIelem::function_da693cbe("extra_target_2", 1, 10, "int");
		cLUIelem::function_da693cbe("extra_target_3", 1, 10, "int");
	}

}

#namespace remote_missile_targets;

/*
	Name: register
	Namespace: remote_missile_targets
	Checksum: 0xCE1CE325
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cremote_missile_targets();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: remote_missile_targets
	Checksum: 0x82907F9F
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
	Namespace: remote_missile_targets
	Checksum: 0xA7626CCF
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
	Namespace: remote_missile_targets
	Checksum: 0x8E8927FC
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
	Name: set_player_target_active
	Namespace: remote_missile_targets
	Checksum: 0xC7155B29
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_player_target_active(player, value)
{
	[[ self ]]->set_player_target_active(player, value);
}

/*
	Name: set_extra_target_1
	Namespace: remote_missile_targets
	Checksum: 0xC14752F3
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_extra_target_1(player, value)
{
	[[ self ]]->set_extra_target_1(player, value);
}

/*
	Name: set_extra_target_2
	Namespace: remote_missile_targets
	Checksum: 0xD1101E04
	Offset: 0x248
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_extra_target_2(player, value)
{
	[[ self ]]->set_extra_target_2(player, value);
}

/*
	Name: set_extra_target_3
	Namespace: remote_missile_targets
	Checksum: 0xF84D24EF
	Offset: 0x278
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_extra_target_3(player, value)
{
	[[ self ]]->set_extra_target_3(player, value);
}

