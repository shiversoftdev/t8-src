// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class cwz_revive_prompt : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cwz_revive_prompt
		Checksum: 0xDA39AC7E
		Offset: 0x290
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cwz_revive_prompt
		Checksum: 0xC4091EA4
		Offset: 0x520
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_cowardsway
		Namespace: cwz_revive_prompt
		Checksum: 0x4E3F5DD1
		Offset: 0x4D8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_cowardsway(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "cowardsWay", value);
	}

	/*
		Name: set_reviveprogress
		Namespace: cwz_revive_prompt
		Checksum: 0x2CF071A9
		Offset: 0x490
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_reviveprogress(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "reviveProgress", value);
	}

	/*
		Name: set_health
		Namespace: cwz_revive_prompt
		Checksum: 0xBFC54322
		Offset: 0x448
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_health(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "health", value);
	}

	/*
		Name: set_clientnum
		Namespace: cwz_revive_prompt
		Checksum: 0xBCA400CC
		Offset: 0x400
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_clientnum(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "clientnum", value);
	}

	/*
		Name: close
		Namespace: cwz_revive_prompt
		Checksum: 0x3AB05EA6
		Offset: 0x3D0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		cluielem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cwz_revive_prompt
		Checksum: 0xA46F2A8
		Offset: 0x380
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "wz_revive_prompt", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cwz_revive_prompt
		Checksum: 0xE01E272
		Offset: 0x2B0
		Size: 0xC4
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("clientnum", 1, 7, "int");
		cluielem::add_clientfield("health", 1, 5, "float");
		cluielem::add_clientfield("reviveProgress", 1, 5, "float");
		cluielem::add_clientfield("cowardsWay", 17000, 1, "int");
	}

}

#namespace wz_revive_prompt;

/*
	Name: register
	Namespace: wz_revive_prompt
	Checksum: 0xC2C72F5F
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new cwz_revive_prompt();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: wz_revive_prompt
	Checksum: 0x3C528D6F
	Offset: 0x140
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
	Namespace: wz_revive_prompt
	Checksum: 0x85BBACF6
	Offset: 0x180
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
	Namespace: wz_revive_prompt
	Checksum: 0xAF235EE0
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_clientnum
	Namespace: wz_revive_prompt
	Checksum: 0x24199459
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_clientnum(player, value)
{
	[[ self ]]->set_clientnum(player, value);
}

/*
	Name: set_health
	Namespace: wz_revive_prompt
	Checksum: 0x545C2C21
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_health(player, value)
{
	[[ self ]]->set_health(player, value);
}

/*
	Name: set_reviveprogress
	Namespace: wz_revive_prompt
	Checksum: 0x4F8599FE
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_reviveprogress(player, value)
{
	[[ self ]]->set_reviveprogress(player, value);
}

/*
	Name: set_cowardsway
	Namespace: wz_revive_prompt
	Checksum: 0x202A5ECE
	Offset: 0x260
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_cowardsway(player, value)
{
	[[ self ]]->set_cowardsway(player, value);
}

