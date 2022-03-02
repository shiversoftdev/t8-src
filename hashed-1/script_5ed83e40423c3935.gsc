// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_1b0cb7b1 : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_1b0cb7b1
		Checksum: 0x8A489B4A
		Offset: 0x2E8
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
		Checksum: 0xF5CE1E96
		Offset: 0x5F8
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
		Checksum: 0xB7CF891F
		Offset: 0x5C0
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_f52e0186(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "cowardsWay", value);
	}

	/*
		Name: function_4b3fb8b8
		Namespace: namespace_1b0cb7b1
		Checksum: 0xAEE2342
		Offset: 0x588
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_4b3fb8b8(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "reviveProgress", value);
	}

	/*
		Name: set_health
		Namespace: namespace_1b0cb7b1
		Checksum: 0x9481CD05
		Offset: 0x550
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_health(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "health", value);
	}

	/*
		Name: function_3b7b386a
		Namespace: namespace_1b0cb7b1
		Checksum: 0x1F3CA30B
		Offset: 0x518
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_3b7b386a(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "clientnum", value);
	}

	/*
		Name: open
		Namespace: namespace_1b0cb7b1
		Checksum: 0x34C71D1B
		Offset: 0x4E0
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"wz_revive_prompt");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_1b0cb7b1
		Checksum: 0x54E50C91
		Offset: 0x430
		Size: 0xA4
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "clientnum", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "health", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "reviveProgress", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "cowardsWay", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_1b0cb7b1
		Checksum: 0x96DCC47A
		Offset: 0x400
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		namespace_6aaccc24::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_1b0cb7b1
		Checksum: 0x6CAC4AF6
		Offset: 0x308
		Size: 0xEC
		Parameters: 6
		Flags: Linked
	*/
	function setup_clientfields(uid, var_c05c67e2, var_663a86fa, var_d65e5a18, var_f228b5fa, var_7cb8f98a)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("clientnum", 1, 7, "int", var_c05c67e2);
		namespace_6aaccc24::function_da693cbe("health", 1, 5, "float", var_663a86fa);
		namespace_6aaccc24::function_da693cbe("reviveProgress", 1, 5, "float", var_d65e5a18);
		namespace_6aaccc24::function_da693cbe("cowardsWay", 17000, 1, "int", var_7cb8f98a);
	}

}

#namespace wz_revive_prompt;

/*
	Name: register
	Namespace: wz_revive_prompt
	Checksum: 0xB4A67D89
	Offset: 0xE0
	Size: 0x7C
	Parameters: 6
	Flags: Linked
*/
function register(uid, var_c05c67e2, var_663a86fa, var_d65e5a18, var_f228b5fa, var_7cb8f98a)
{
	elem = new class_1b0cb7b1();
	[[ elem ]]->setup_clientfields(uid, var_c05c67e2, var_663a86fa, var_d65e5a18, var_f228b5fa, var_7cb8f98a);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: wz_revive_prompt
	Checksum: 0xFAD9FC1C
	Offset: 0x168
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_1b0cb7b1();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: wz_revive_prompt
	Checksum: 0x44E9A4FE
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
	Namespace: wz_revive_prompt
	Checksum: 0xB00C27CA
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
	Namespace: wz_revive_prompt
	Checksum: 0x1A470293
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
	Name: function_3b7b386a
	Namespace: wz_revive_prompt
	Checksum: 0xCF89D320
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3b7b386a(localclientnum, value)
{
	[[ self ]]->function_3b7b386a(localclientnum, value);
}

/*
	Name: set_health
	Namespace: wz_revive_prompt
	Checksum: 0x65F94891
	Offset: 0x258
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_health(localclientnum, value)
{
	[[ self ]]->set_health(localclientnum, value);
}

/*
	Name: function_4b3fb8b8
	Namespace: wz_revive_prompt
	Checksum: 0xB89F71B7
	Offset: 0x288
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4b3fb8b8(localclientnum, value)
{
	[[ self ]]->function_4b3fb8b8(localclientnum, value);
}

/*
	Name: function_f52e0186
	Namespace: wz_revive_prompt
	Checksum: 0x42056BD3
	Offset: 0x2B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_f52e0186(localclientnum, value)
{
	[[ self ]]->function_f52e0186(localclientnum, value);
}

