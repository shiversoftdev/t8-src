// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cself_respawn : cLUIelem
{

	/*
		Name: constructor
		Namespace: cself_respawn
		Checksum: 0xF583C835
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
		Namespace: cself_respawn
		Checksum: 0x1B8A4E44
		Offset: 0x368
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_percent
		Namespace: cself_respawn
		Checksum: 0x4F8D2406
		Offset: 0x330
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_percent(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "percent", value);
	}

	/*
		Name: open
		Namespace: cself_respawn
		Checksum: 0x815A405B
		Offset: 0x2F8
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"self_respawn");
	}

	/*
		Name: function_fa582112
		Namespace: cself_respawn
		Checksum: 0x5B95A9A2
		Offset: 0x2A8
		Size: 0x48
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "percent", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cself_respawn
		Checksum: 0x75C572B1
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
		Namespace: cself_respawn
		Checksum: 0xAC8AC4A8
		Offset: 0x218
		Size: 0x54
		Parameters: 2
		Flags: None
	*/
	function setup_clientfields(uid, var_1089a5f3)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("percent", 4000, 6, "float", var_1089a5f3);
	}

}

#namespace self_respawn;

/*
	Name: register
	Namespace: self_respawn
	Checksum: 0xCC9D396C
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_1089a5f3)
{
	elem = new cself_respawn();
	[[ elem ]]->setup_clientfields(uid, var_1089a5f3);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: self_respawn
	Checksum: 0xC8CBE6B8
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cself_respawn();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_respawn
	Checksum: 0x28F2AB3E
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
	Namespace: self_respawn
	Checksum: 0x603DC5C2
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
	Namespace: self_respawn
	Checksum: 0xC1113908
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
	Name: set_percent
	Namespace: self_respawn
	Checksum: 0x8B484602
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_percent(localclientnum, value)
{
	[[ self ]]->set_percent(localclientnum, value);
}

