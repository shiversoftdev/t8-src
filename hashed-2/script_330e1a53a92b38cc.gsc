// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cmp_revive_prompt : cLUIelem
{

	/*
		Name: constructor
		Namespace: cmp_revive_prompt
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
		Namespace: cmp_revive_prompt
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
		Name: set_reviveProgress
		Namespace: cmp_revive_prompt
		Checksum: 0x4B51EA95
		Offset: 0x4E8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_reviveProgress(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "reviveProgress", value);
	}

	/*
		Name: set_health
		Namespace: cmp_revive_prompt
		Checksum: 0x2C7AA12A
		Offset: 0x4B0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_health(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "health", value);
	}

	/*
		Name: set_clientnum
		Namespace: cmp_revive_prompt
		Checksum: 0x85817832
		Offset: 0x478
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_clientnum(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "clientnum", value);
	}

	/*
		Name: open
		Namespace: cmp_revive_prompt
		Checksum: 0x6AD656F0
		Offset: 0x440
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"mp_revive_prompt");
	}

	/*
		Name: function_fa582112
		Namespace: cmp_revive_prompt
		Checksum: 0xF4E05E68
		Offset: 0x3B0
		Size: 0x88
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "clientnum", 0);
		[[ self ]]->set_data(localclientnum, "health", 0);
		[[ self ]]->set_data(localclientnum, "reviveProgress", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cmp_revive_prompt
		Checksum: 0xF1CFF2F5
		Offset: 0x380
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
		Namespace: cmp_revive_prompt
		Checksum: 0x16DAE0E2
		Offset: 0x2B8
		Size: 0xBC
		Parameters: 5
		Flags: None
	*/
	function setup_clientfields(uid, var_c05c67e2, healthcallback, var_d65e5a18, var_f228b5fa)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("clientnum", 1, 7, "int", var_c05c67e2);
		cLUIelem::function_da693cbe("health", 1, 5, "float", healthcallback);
		cLUIelem::function_da693cbe("reviveProgress", 1, 5, "float", var_d65e5a18);
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
function register(uid, var_c05c67e2, healthcallback, var_d65e5a18, var_f228b5fa)
{
	elem = new cmp_revive_prompt();
	[[ elem ]]->setup_clientfields(uid, var_c05c67e2, healthcallback, var_d65e5a18, var_f228b5fa);
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
	elem = new cmp_revive_prompt();
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
	Name: set_clientnum
	Namespace: mp_revive_prompt
	Checksum: 0xEF1717B4
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_clientnum(localclientnum, value)
{
	[[ self ]]->set_clientnum(localclientnum, value);
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
	Name: set_reviveProgress
	Namespace: mp_revive_prompt
	Checksum: 0xE56586B0
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_reviveProgress(localclientnum, value)
{
	[[ self ]]->set_reviveProgress(localclientnum, value);
}

