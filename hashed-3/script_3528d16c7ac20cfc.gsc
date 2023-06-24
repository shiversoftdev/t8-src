// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cmp_laststand_client : cLUIelem
{

	/*
		Name: constructor
		Namespace: cmp_laststand_client
		Checksum: 0x8B6825F
		Offset: 0x248
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cmp_laststand_client
		Checksum: 0x5051D24E
		Offset: 0x448
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_revive_progress
		Namespace: cmp_laststand_client
		Checksum: 0xE6FEDAA0
		Offset: 0x410
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_revive_progress(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "revive_progress", value);
	}

	/*
		Name: set_bleedout_progress
		Namespace: cmp_laststand_client
		Checksum: 0x35E3EC9F
		Offset: 0x3D8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_bleedout_progress(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "bleedout_progress", value);
	}

	/*
		Name: open
		Namespace: cmp_laststand_client
		Checksum: 0x636FD351
		Offset: 0x3A0
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"mp_laststand_client");
	}

	/*
		Name: function_fa582112
		Namespace: cmp_laststand_client
		Checksum: 0x4FC04249
		Offset: 0x328
		Size: 0x6C
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "bleedout_progress", 0);
		[[ self ]]->set_data(localclientnum, "revive_progress", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cmp_laststand_client
		Checksum: 0xDD39439F
		Offset: 0x2F8
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
		Namespace: cmp_laststand_client
		Checksum: 0xE327593B
		Offset: 0x268
		Size: 0x84
		Parameters: 3
		Flags: None
	*/
	function setup_clientfields(uid, var_a9a4e140, var_e97e7153)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("bleedout_progress", 1, 6, "float", var_a9a4e140);
		cLUIelem::function_da693cbe("revive_progress", 1, 5, "float", var_e97e7153);
	}

}

#namespace mp_laststand_client;

/*
	Name: register
	Namespace: mp_laststand_client
	Checksum: 0xE6EA2A41
	Offset: 0xC8
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function register(uid, var_a9a4e140, var_e97e7153)
{
	elem = new cmp_laststand_client();
	[[ elem ]]->setup_clientfields(uid, var_a9a4e140, var_e97e7153);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: mp_laststand_client
	Checksum: 0x48F092A6
	Offset: 0x128
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cmp_laststand_client();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: mp_laststand_client
	Checksum: 0x973E3469
	Offset: 0x170
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
	Namespace: mp_laststand_client
	Checksum: 0x7E940818
	Offset: 0x198
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
	Namespace: mp_laststand_client
	Checksum: 0xB8CA79FB
	Offset: 0x1C0
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
	Namespace: mp_laststand_client
	Checksum: 0x4DB93DBB
	Offset: 0x1E8
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
	Namespace: mp_laststand_client
	Checksum: 0x502F9501
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_revive_progress(localclientnum, value)
{
	[[ self ]]->set_revive_progress(localclientnum, value);
}

