// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_3cdd43e2 : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_3cdd43e2
		Checksum: 0xC428F878
		Offset: 0x298
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_3cdd43e2
		Checksum: 0xDE4B867E
		Offset: 0x520
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_4b3fb8b8
		Namespace: namespace_3cdd43e2
		Checksum: 0x4B51EA95
		Offset: 0x4E8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_4b3fb8b8(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "reviveProgress", value);
	}

	/*
		Name: set_health
		Namespace: namespace_3cdd43e2
		Checksum: 0x2C7AA12A
		Offset: 0x4B0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_health(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "health", value);
	}

	/*
		Name: function_3b7b386a
		Namespace: namespace_3cdd43e2
		Checksum: 0x85817832
		Offset: 0x478
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_3b7b386a(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "clientnum", value);
	}

	/*
		Name: open
		Namespace: namespace_3cdd43e2
		Checksum: 0x6AD656F0
		Offset: 0x440
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"mp_revive_prompt");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_3cdd43e2
		Checksum: 0xF4E05E68
		Offset: 0x3B0
		Size: 0x88
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "clientnum", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "health", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "reviveProgress", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_3cdd43e2
		Checksum: 0xF1CFF2F5
		Offset: 0x380
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
		Namespace: namespace_3cdd43e2
		Checksum: 0x16DAE0E2
		Offset: 0x2B8
		Size: 0xBC
		Parameters: 5
		Flags: None
	*/
	function setup_clientfields(uid, var_c05c67e2, var_663a86fa, var_d65e5a18, var_f228b5fa)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("clientnum", 1, 7, "int", var_c05c67e2);
		namespace_6aaccc24::function_da693cbe("health", 1, 5, "float", var_663a86fa);
		namespace_6aaccc24::function_da693cbe("reviveProgress", 1, 5, "float", var_d65e5a18);
	}

}

#namespace mp_revive_prompt;

/*
	Name: register
	Namespace: mp_revive_prompt
	Checksum: 0x520B2514
	Offset: 0xD0
	Size: 0x70
	Parameters: 5
	Flags: None
*/
function register(uid, var_c05c67e2, var_663a86fa, var_d65e5a18, var_f228b5fa)
{
	elem = new class_3cdd43e2();
	[[ elem ]]->setup_clientfields(uid, var_c05c67e2, var_663a86fa, var_d65e5a18, var_f228b5fa);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: mp_revive_prompt
	Checksum: 0x7B55C31A
	Offset: 0x148
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_3cdd43e2();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: mp_revive_prompt
	Checksum: 0xD9BBD290
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
	Namespace: mp_revive_prompt
	Checksum: 0x3F4B3C4D
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
	Namespace: mp_revive_prompt
	Checksum: 0x22318157
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
	Name: function_3b7b386a
	Namespace: mp_revive_prompt
	Checksum: 0xEF1717B4
	Offset: 0x208
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
	Namespace: mp_revive_prompt
	Checksum: 0xB067438C
	Offset: 0x238
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
	Namespace: mp_revive_prompt
	Checksum: 0xE56586B0
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4b3fb8b8(localclientnum, value)
{
	[[ self ]]->function_4b3fb8b8(localclientnum, value);
}

