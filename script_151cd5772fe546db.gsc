// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_arcade_timer : cluielem
{

	/*
		Name: constructor
		Namespace: czm_arcade_timer
		Checksum: 0x31D99A06
		Offset: 0x2C8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_arcade_timer
		Checksum: 0x14004975
		Offset: 0x5D0
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_title
		Namespace: czm_arcade_timer
		Checksum: 0xA6E6A9E0
		Offset: 0x598
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_title(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "title", value);
	}

	/*
		Name: set_minutes
		Namespace: czm_arcade_timer
		Checksum: 0x8EE5E467
		Offset: 0x560
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
		Namespace: czm_arcade_timer
		Checksum: 0x5AC68377
		Offset: 0x528
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_seconds(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "seconds", value);
	}

	/*
		Name: set_showzero
		Namespace: czm_arcade_timer
		Checksum: 0x2D8946B8
		Offset: 0x4F0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_showzero(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "showzero", value);
	}

	/*
		Name: open
		Namespace: czm_arcade_timer
		Checksum: 0x42D913AD
		Offset: 0x4B8
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"zm_arcade_timer");
	}

	/*
		Name: function_fa582112
		Namespace: czm_arcade_timer
		Checksum: 0x6AB17A46
		Offset: 0x408
		Size: 0xA4
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "showzero", 0);
		[[ self ]]->set_data(localclientnum, "seconds", 0);
		[[ self ]]->set_data(localclientnum, "minutes", 0);
		[[ self ]]->set_data(localclientnum, "title", #"");
	}

	/*
		Name: register_clientside
		Namespace: czm_arcade_timer
		Checksum: 0x27725EB9
		Offset: 0x3D8
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
		Namespace: czm_arcade_timer
		Checksum: 0x5FB7986
		Offset: 0x2E8
		Size: 0xE4
		Parameters: 5
		Flags: None
	*/
	function setup_clientfields(uid, var_8fd8bfaa, var_b1de907e, var_359a4d9a, var_395b3059)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("showzero", 1, 1, "int", var_8fd8bfaa);
		cluielem::add_clientfield("seconds", 1, 6, "int", var_b1de907e);
		cluielem::add_clientfield("minutes", 1, 4, "int", var_359a4d9a);
		cluielem::function_dcb34c80("string", "title", 1);
	}

}

#namespace zm_arcade_timer;

/*
	Name: register
	Namespace: zm_arcade_timer
	Checksum: 0x2A58250A
	Offset: 0xD0
	Size: 0x70
	Parameters: 5
	Flags: None
*/
function register(uid, var_8fd8bfaa, var_b1de907e, var_359a4d9a, var_395b3059)
{
	elem = new czm_arcade_timer();
	[[ elem ]]->setup_clientfields(uid, var_8fd8bfaa, var_b1de907e, var_359a4d9a, var_395b3059);
	return elem;
}

/*
	Name: register_clientside
	Namespace: zm_arcade_timer
	Checksum: 0xA759B441
	Offset: 0x148
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new czm_arcade_timer();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_arcade_timer
	Checksum: 0x6247FFF2
	Offset: 0x190
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
	Namespace: zm_arcade_timer
	Checksum: 0xC41C8C3F
	Offset: 0x1B8
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
	Namespace: zm_arcade_timer
	Checksum: 0xEDFB820
	Offset: 0x1E0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_showzero
	Namespace: zm_arcade_timer
	Checksum: 0x40403259
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_showzero(localclientnum, value)
{
	[[ self ]]->set_showzero(localclientnum, value);
}

/*
	Name: set_seconds
	Namespace: zm_arcade_timer
	Checksum: 0xC416F0F4
	Offset: 0x238
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
	Namespace: zm_arcade_timer
	Checksum: 0xFD822439
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_minutes(localclientnum, value)
{
	[[ self ]]->set_minutes(localclientnum, value);
}

/*
	Name: set_title
	Namespace: zm_arcade_timer
	Checksum: 0xD3600D3C
	Offset: 0x298
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_title(localclientnum, value)
{
	[[ self ]]->set_title(localclientnum, value);
}

