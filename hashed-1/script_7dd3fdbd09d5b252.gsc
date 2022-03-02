// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_e6fa6527 : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_e6fa6527
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
		Namespace: namespace_e6fa6527
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
		Name: function_3820c524
		Namespace: namespace_e6fa6527
		Checksum: 0xC9F3B802
		Offset: 0x328
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_3820c524(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "shutdown_sec", value);
	}

	/*
		Name: open
		Namespace: namespace_e6fa6527
		Checksum: 0xB041637E
		Offset: 0x2F0
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"death_zone");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_e6fa6527
		Checksum: 0xD91EBA63
		Offset: 0x2A8
		Size: 0x40
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "shutdown_sec", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_e6fa6527
		Checksum: 0xAF31A14
		Offset: 0x278
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_5c1bb138(uid)
	{
		namespace_6aaccc24::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_e6fa6527
		Checksum: 0xC30C40A7
		Offset: 0x218
		Size: 0x54
		Parameters: 2
		Flags: None
	*/
	function setup_clientfields(uid, var_fd61f748)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("shutdown_sec", 1, 9, "int", var_fd61f748);
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
	elem = new class_e6fa6527();
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
	elem = new class_e6fa6527();
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
	Name: function_3820c524
	Namespace: death_zone
	Checksum: 0x1BA2743
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3820c524(localclientnum, value)
{
	[[ self ]]->function_3820c524(localclientnum, value);
}

