// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_laststand_client : cLUIelem
{

	/*
		Name: constructor
		Namespace: czm_laststand_client
		Checksum: 0xCA14C5DD
		Offset: 0x2A0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_laststand_client
		Checksum: 0xB0EA0257
		Offset: 0x520
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_num_downs
		Namespace: czm_laststand_client
		Checksum: 0xB979D720
		Offset: 0x4E8
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_num_downs(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "num_downs", value);
	}

	/*
		Name: set_revive_progress
		Namespace: czm_laststand_client
		Checksum: 0x96D0312C
		Offset: 0x4B0
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_revive_progress(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "revive_progress", value);
	}

	/*
		Name: set_bleedout_progress
		Namespace: czm_laststand_client
		Checksum: 0xC5742D28
		Offset: 0x478
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_bleedout_progress(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bleedout_progress", value);
	}

	/*
		Name: open
		Namespace: czm_laststand_client
		Checksum: 0xBA92EEB0
		Offset: 0x440
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"zm_laststand_client");
	}

	/*
		Name: function_fa582112
		Namespace: czm_laststand_client
		Checksum: 0x2A3A5C11
		Offset: 0x3B0
		Size: 0x88
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "bleedout_progress", 0);
		[[ self ]]->set_data(localclientnum, "revive_progress", 0);
		[[ self ]]->set_data(localclientnum, "num_downs", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: czm_laststand_client
		Checksum: 0x3463E936
		Offset: 0x380
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		cLUIelem::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_laststand_client
		Checksum: 0x8315B949
		Offset: 0x2C0
		Size: 0xB4
		Parameters: 4
		Flags: Linked
	*/
	function setup_clientfields(uid, var_a9a4e140, var_e97e7153, var_5db69c99)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("bleedout_progress", 1, 6, "float", var_a9a4e140);
		cLUIelem::function_da693cbe("revive_progress", 1, 5, "float", var_e97e7153);
		cLUIelem::function_da693cbe("num_downs", 1, 8, "int", var_5db69c99);
	}

}

#namespace zm_laststand_client;

/*
	Name: register
	Namespace: zm_laststand_client
	Checksum: 0x953EE0C1
	Offset: 0xE0
	Size: 0x64
	Parameters: 4
	Flags: Linked
*/
function register(uid, var_a9a4e140, var_e97e7153, var_5db69c99)
{
	elem = new czm_laststand_client();
	[[ elem ]]->setup_clientfields(uid, var_a9a4e140, var_e97e7153, var_5db69c99);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_laststand_client
	Checksum: 0x8673CD5E
	Offset: 0x150
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new czm_laststand_client();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_laststand_client
	Checksum: 0x6C42E100
	Offset: 0x198
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
	Namespace: zm_laststand_client
	Checksum: 0x3E991D85
	Offset: 0x1C0
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
	Namespace: zm_laststand_client
	Checksum: 0xA1BF77C6
	Offset: 0x1E8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_bleedout_progress
	Namespace: zm_laststand_client
	Checksum: 0xE6DDC324
	Offset: 0x210
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bleedout_progress(localclientnum, value)
{
	[[ self ]]->set_bleedout_progress(localclientnum, value);
}

/*
	Name: set_revive_progress
	Namespace: zm_laststand_client
	Checksum: 0xEDA1E986
	Offset: 0x240
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_revive_progress(localclientnum, value)
{
	[[ self ]]->set_revive_progress(localclientnum, value);
}

/*
	Name: set_num_downs
	Namespace: zm_laststand_client
	Checksum: 0x4B9C228C
	Offset: 0x270
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_num_downs(localclientnum, value)
{
	[[ self ]]->set_num_downs(localclientnum, value);
}

