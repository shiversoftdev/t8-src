// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cremote_missile_target_lockon : cluielem
{

	/*
		Name: constructor
		Namespace: cremote_missile_target_lockon
		Checksum: 0x5D3F96A7
		Offset: 0x2D0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cremote_missile_target_lockon
		Checksum: 0xCEEBE99D
		Offset: 0x5C8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_killed
		Namespace: cremote_missile_target_lockon
		Checksum: 0x8B048036
		Offset: 0x590
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_killed(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "killed", value);
	}

	/*
		Name: set_ishawktag
		Namespace: cremote_missile_target_lockon
		Checksum: 0x29AF8FF5
		Offset: 0x558
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_ishawktag(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "isHawkTag", value);
	}

	/*
		Name: set_target_locked
		Namespace: cremote_missile_target_lockon
		Checksum: 0x6142C403
		Offset: 0x520
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_target_locked(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "target_locked", value);
	}

	/*
		Name: set_clientnum
		Namespace: cremote_missile_target_lockon
		Checksum: 0xA46A954C
		Offset: 0x4E8
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_clientnum(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "clientnum", value);
	}

	/*
		Name: open
		Namespace: cremote_missile_target_lockon
		Checksum: 0x1197D043
		Offset: 0x4B0
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"remote_missile_target_lockon");
	}

	/*
		Name: function_fa582112
		Namespace: cremote_missile_target_lockon
		Checksum: 0xA45D9768
		Offset: 0x410
		Size: 0x94
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "clientnum", 0);
		[[ self ]]->set_data(localclientnum, "target_locked", 0);
		[[ self ]]->set_data(localclientnum, "isHawkTag", 0);
		[[ self ]]->set_data(localclientnum, "killed", 0);
	}

	/*
		Name: register_clientside
		Namespace: cremote_missile_target_lockon
		Checksum: 0x87355005
		Offset: 0x3E0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cremote_missile_target_lockon
		Checksum: 0x6223C699
		Offset: 0x2F0
		Size: 0xE4
		Parameters: 5
		Flags: Linked
	*/
	function setup_clientfields(uid, var_c05c67e2, var_486334bd, var_683d075d, killedcallback)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("clientnum", 1, 7, "int", var_c05c67e2);
		cluielem::add_clientfield("target_locked", 1, 1, "int", var_486334bd);
		cluielem::add_clientfield("isHawkTag", 13000, 1, "int", var_683d075d);
		cluielem::add_clientfield("killed", 13000, 1, "int", killedcallback);
	}

}

#namespace remote_missile_target_lockon;

/*
	Name: register
	Namespace: remote_missile_target_lockon
	Checksum: 0xEE59B854
	Offset: 0xD8
	Size: 0x70
	Parameters: 5
	Flags: None
*/
function register(uid, var_c05c67e2, var_486334bd, var_683d075d, killedcallback)
{
	elem = new cremote_missile_target_lockon();
	[[ elem ]]->setup_clientfields(uid, var_c05c67e2, var_486334bd, var_683d075d, killedcallback);
	return elem;
}

/*
	Name: register_clientside
	Namespace: remote_missile_target_lockon
	Checksum: 0x19AC3DD9
	Offset: 0x150
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register_clientside(uid)
{
	elem = new cremote_missile_target_lockon();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: remote_missile_target_lockon
	Checksum: 0xFF29ABF1
	Offset: 0x198
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: remote_missile_target_lockon
	Checksum: 0x5C606733
	Offset: 0x1C0
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: remote_missile_target_lockon
	Checksum: 0xB6497E11
	Offset: 0x1E8
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_clientnum
	Namespace: remote_missile_target_lockon
	Checksum: 0xD2DBCBCD
	Offset: 0x210
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_clientnum(localclientnum, value)
{
	[[ self ]]->set_clientnum(localclientnum, value);
}

/*
	Name: set_target_locked
	Namespace: remote_missile_target_lockon
	Checksum: 0x2434D575
	Offset: 0x240
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_target_locked(localclientnum, value)
{
	[[ self ]]->set_target_locked(localclientnum, value);
}

/*
	Name: set_ishawktag
	Namespace: remote_missile_target_lockon
	Checksum: 0x6BBF3FAE
	Offset: 0x270
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_ishawktag(localclientnum, value)
{
	[[ self ]]->set_ishawktag(localclientnum, value);
}

/*
	Name: set_killed
	Namespace: remote_missile_target_lockon
	Checksum: 0x45B5A4E2
	Offset: 0x2A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_killed(localclientnum, value)
{
	[[ self ]]->set_killed(localclientnum, value);
}

