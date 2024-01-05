// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cspectrerisingindicator : cluielem
{

	/*
		Name: constructor
		Namespace: cspectrerisingindicator
		Checksum: 0xDD5339FC
		Offset: 0x238
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cspectrerisingindicator
		Checksum: 0xCE8B3F15
		Offset: 0x428
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_isalive
		Namespace: cspectrerisingindicator
		Checksum: 0x31406B6D
		Offset: 0x3F0
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_isalive(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "isAlive", value);
	}

	/*
		Name: set_clientnum
		Namespace: cspectrerisingindicator
		Checksum: 0x9FBE7107
		Offset: 0x3B8
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_clientnum(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "clientnum", value);
	}

	/*
		Name: open
		Namespace: cspectrerisingindicator
		Checksum: 0x20F9D129
		Offset: 0x380
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"spectrerisingindicator");
	}

	/*
		Name: function_fa582112
		Namespace: cspectrerisingindicator
		Checksum: 0x277EB428
		Offset: 0x318
		Size: 0x5C
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "clientnum", 0);
		[[ self ]]->set_data(localclientnum, "isAlive", 0);
	}

	/*
		Name: register_clientside
		Namespace: cspectrerisingindicator
		Checksum: 0x1AE94536
		Offset: 0x2E8
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cspectrerisingindicator
		Checksum: 0x65364C7B
		Offset: 0x258
		Size: 0x84
		Parameters: 3
		Flags: Linked
	*/
	function setup_clientfields(uid, var_c05c67e2, var_f25b9f45)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("clientnum", 1, 7, "int", var_c05c67e2);
		cluielem::add_clientfield("isAlive", 1, 1, "int", var_f25b9f45);
	}

}

#namespace spectrerisingindicator;

/*
	Name: register
	Namespace: spectrerisingindicator
	Checksum: 0x213F0B2B
	Offset: 0xB8
	Size: 0x58
	Parameters: 3
	Flags: Linked
*/
function register(uid, var_c05c67e2, var_f25b9f45)
{
	elem = new cspectrerisingindicator();
	[[ elem ]]->setup_clientfields(uid, var_c05c67e2, var_f25b9f45);
	return elem;
}

/*
	Name: register_clientside
	Namespace: spectrerisingindicator
	Checksum: 0xD275265A
	Offset: 0x118
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cspectrerisingindicator();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: spectrerisingindicator
	Checksum: 0x8FC4912A
	Offset: 0x160
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
	Namespace: spectrerisingindicator
	Checksum: 0x480B25D4
	Offset: 0x188
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
	Namespace: spectrerisingindicator
	Checksum: 0x188E232B
	Offset: 0x1B0
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
	Namespace: spectrerisingindicator
	Checksum: 0x32292A5E
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_clientnum(localclientnum, value)
{
	[[ self ]]->set_clientnum(localclientnum, value);
}

/*
	Name: set_isalive
	Namespace: spectrerisingindicator
	Checksum: 0xF2C22BE4
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_isalive(localclientnum, value)
{
	[[ self ]]->set_isalive(localclientnum, value);
}

