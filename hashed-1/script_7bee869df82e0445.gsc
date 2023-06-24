// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cremote_missile_targets : cLUIelem
{

	/*
		Name: constructor
		Namespace: cremote_missile_targets
		Checksum: 0xBDEC227E
		Offset: 0x2E8
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
		Checksum: 0x416E4E0A
		Offset: 0x5E0
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
		Checksum: 0xF8C5D6A3
		Offset: 0x5A8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_extra_target_3(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "extra_target_3", value);
	}

	/*
		Name: set_extra_target_2
		Namespace: cremote_missile_targets
		Checksum: 0xE7F7CA2A
		Offset: 0x570
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_extra_target_2(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "extra_target_2", value);
	}

	/*
		Name: set_extra_target_1
		Namespace: cremote_missile_targets
		Checksum: 0xBCC14938
		Offset: 0x538
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_extra_target_1(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "extra_target_1", value);
	}

	/*
		Name: set_player_target_active
		Namespace: cremote_missile_targets
		Checksum: 0x5A20BAEB
		Offset: 0x500
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_player_target_active(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "player_target_active", value);
	}

	/*
		Name: open
		Namespace: cremote_missile_targets
		Checksum: 0x9D5EA133
		Offset: 0x4C8
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"remote_missile_targets");
	}

	/*
		Name: function_fa582112
		Namespace: cremote_missile_targets
		Checksum: 0x74753BD5
		Offset: 0x428
		Size: 0x94
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "player_target_active", 0);
		[[ self ]]->set_data(localclientnum, "extra_target_1", 0);
		[[ self ]]->set_data(localclientnum, "extra_target_2", 0);
		[[ self ]]->set_data(localclientnum, "extra_target_3", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cremote_missile_targets
		Checksum: 0xE351C9BA
		Offset: 0x3F8
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
		Namespace: cremote_missile_targets
		Checksum: 0x9720BBED
		Offset: 0x308
		Size: 0xE4
		Parameters: 5
		Flags: None
	*/
	function setup_clientfields(uid, var_9318c80d, var_82a5247c, var_afbc846a, var_4c87c083)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("player_target_active", 1, 16, "int", var_9318c80d);
		cLUIelem::function_da693cbe("extra_target_1", 1, 10, "int", var_82a5247c);
		cLUIelem::function_da693cbe("extra_target_2", 1, 10, "int", var_afbc846a);
		cLUIelem::function_da693cbe("extra_target_3", 1, 10, "int", var_4c87c083);
	}

}

#namespace remote_missile_targets;

/*
	Name: register
	Namespace: remote_missile_targets
	Checksum: 0xEC624A7A
	Offset: 0xF0
	Size: 0x70
	Parameters: 5
	Flags: None
*/
function register(uid, var_9318c80d, var_82a5247c, var_afbc846a, var_4c87c083)
{
	elem = new cremote_missile_targets();
	[[ elem ]]->setup_clientfields(uid, var_9318c80d, var_82a5247c, var_afbc846a, var_4c87c083);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: remote_missile_targets
	Checksum: 0x89A3BB40
	Offset: 0x168
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cremote_missile_targets();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: remote_missile_targets
	Checksum: 0x30FA92B3
	Offset: 0x1B0
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
	Namespace: remote_missile_targets
	Checksum: 0x37E46CF2
	Offset: 0x1D8
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
	Checksum: 0x43F2B421
	Offset: 0x200
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_player_target_active
	Namespace: remote_missile_targets
	Checksum: 0x1BC72B8C
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_player_target_active(localclientnum, value)
{
	[[ self ]]->set_player_target_active(localclientnum, value);
}

/*
	Name: set_extra_target_1
	Namespace: remote_missile_targets
	Checksum: 0xD916598F
	Offset: 0x258
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_extra_target_1(localclientnum, value)
{
	[[ self ]]->set_extra_target_1(localclientnum, value);
}

/*
	Name: set_extra_target_2
	Namespace: remote_missile_targets
	Checksum: 0x72D1C294
	Offset: 0x288
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_extra_target_2(localclientnum, value)
{
	[[ self ]]->set_extra_target_2(localclientnum, value);
}

/*
	Name: set_extra_target_3
	Namespace: remote_missile_targets
	Checksum: 0x2FE86834
	Offset: 0x2B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_extra_target_3(localclientnum, value)
{
	[[ self ]]->set_extra_target_3(localclientnum, value);
}

