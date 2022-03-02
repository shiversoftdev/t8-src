// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_1b0cb7b1 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_1b0cb7b1
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
		Namespace: namespace_1b0cb7b1
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
		Name: function_f52e0186
		Namespace: namespace_1b0cb7b1
		Checksum: 0x4E3F5DD1
		Offset: 0x4D8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_f52e0186(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "cowardsWay", value);
	}

	/*
		Name: function_4b3fb8b8
		Namespace: namespace_1b0cb7b1
		Checksum: 0x2CF071A9
		Offset: 0x490
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_4b3fb8b8(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "reviveProgress", value);
	}

	/*
		Name: set_health
		Namespace: namespace_1b0cb7b1
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
		Name: function_3b7b386a
		Namespace: namespace_1b0cb7b1
		Checksum: 0xBCA400CC
		Offset: 0x400
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_3b7b386a(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "clientnum", value);
	}

	/*
		Name: close
		Namespace: namespace_1b0cb7b1
		Checksum: 0x3AB05EA6
		Offset: 0x3D0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_1b0cb7b1
		Checksum: 0xA46F2A8
		Offset: 0x380
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "wz_revive_prompt", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_1b0cb7b1
		Checksum: 0xE01E272
		Offset: 0x2B0
		Size: 0xC4
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("clientnum", 1, 7, "int");
		namespace_6aaccc24::function_da693cbe("health", 1, 5, "float");
		namespace_6aaccc24::function_da693cbe("reviveProgress", 1, 5, "float");
		namespace_6aaccc24::function_da693cbe("cowardsWay", 17000, 1, "int");
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
	elem = new class_1b0cb7b1();
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
	Name: function_3b7b386a
	Namespace: wz_revive_prompt
	Checksum: 0x24199459
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3b7b386a(player, value)
{
	[[ self ]]->function_3b7b386a(player, value);
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
	Name: function_4b3fb8b8
	Namespace: wz_revive_prompt
	Checksum: 0x4F8599FE
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4b3fb8b8(player, value)
{
	[[ self ]]->function_4b3fb8b8(player, value);
}

/*
	Name: function_f52e0186
	Namespace: wz_revive_prompt
	Checksum: 0x202A5ECE
	Offset: 0x260
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_f52e0186(player, value)
{
	[[ self ]]->function_f52e0186(player, value);
}

