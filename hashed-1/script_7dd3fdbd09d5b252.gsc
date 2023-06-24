// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cdeath_zone : cLUIelem
{

	/*
		Name: constructor
		Namespace: cdeath_zone
		Checksum: 0x5AA9760A
		Offset: 0x1F8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cdeath_zone
		Checksum: 0xBA546DB2
		Offset: 0x360
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_shutdown_sec
		Namespace: cdeath_zone
		Checksum: 0xC9F3B802
		Offset: 0x328
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_shutdown_sec(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "shutdown_sec", value);
	}

	/*
		Name: open
		Namespace: cdeath_zone
		Checksum: 0xB041637E
		Offset: 0x2F0
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"death_zone");
	}

	/*
		Name: function_fa582112
		Namespace: cdeath_zone
		Checksum: 0xD91EBA63
		Offset: 0x2A8
		Size: 0x40
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "shutdown_sec", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cdeath_zone
		Checksum: 0xAF31A14
		Offset: 0x278
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
		Namespace: cdeath_zone
		Checksum: 0xC30C40A7
		Offset: 0x218
		Size: 0x54
		Parameters: 2
		Flags: None
	*/
	function setup_clientfields(uid, var_fd61f748)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("shutdown_sec", 1, 9, "int", var_fd61f748);
	}

}

#namespace death_zone;

/*
	Name: register
	Namespace: death_zone
	Checksum: 0x11D389ED
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_fd61f748)
{
	elem = new cdeath_zone();
	[[ elem ]]->setup_clientfields(uid, var_fd61f748);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: death_zone
	Checksum: 0x5B41D384
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cdeath_zone();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: death_zone
	Checksum: 0xB41CBCB9
	Offset: 0x150
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
	Namespace: death_zone
	Checksum: 0x6EB1445C
	Offset: 0x178
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
	Namespace: death_zone
	Checksum: 0xCC88AC93
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_shutdown_sec
	Namespace: death_zone
	Checksum: 0x1BA2743
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_shutdown_sec(localclientnum, value)
{
	[[ self ]]->set_shutdown_sec(localclientnum, value);
}

