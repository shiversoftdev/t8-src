// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cseeker_mine_prompt : cluielem
{

	/*
		Name: constructor
		Namespace: cseeker_mine_prompt
		Checksum: 0x3D026716
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
		Namespace: cseeker_mine_prompt
		Checksum: 0x3B4F958B
		Offset: 0x440
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_promptstate
		Namespace: cseeker_mine_prompt
		Checksum: 0x71F37FE4
		Offset: 0x408
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_promptstate(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "promptState", value);
	}

	/*
		Name: set_progress
		Namespace: cseeker_mine_prompt
		Checksum: 0x25D3D40
		Offset: 0x3D0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_progress(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "progress", value);
	}

	/*
		Name: open
		Namespace: cseeker_mine_prompt
		Checksum: 0xADC7A8E0
		Offset: 0x398
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"seeker_mine_prompt");
	}

	/*
		Name: function_fa582112
		Namespace: cseeker_mine_prompt
		Checksum: 0x9F597F96
		Offset: 0x328
		Size: 0x64
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "progress", 0);
		[[ self ]]->set_data(localclientnum, "promptState", 0);
	}

	/*
		Name: register_clientside
		Namespace: cseeker_mine_prompt
		Checksum: 0x92C22D06
		Offset: 0x2F8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cseeker_mine_prompt
		Checksum: 0x6363C40F
		Offset: 0x268
		Size: 0x84
		Parameters: 3
		Flags: None
	*/
	function setup_clientfields(uid, var_afaddf7a, var_ca3086f0)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("progress", 1, 5, "float", var_afaddf7a);
		cluielem::add_clientfield("promptState", 1, 2, "int", var_ca3086f0);
	}

}

#namespace seeker_mine_prompt;

/*
	Name: register
	Namespace: seeker_mine_prompt
	Checksum: 0xD0638E0C
	Offset: 0xC8
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function register(uid, var_afaddf7a, var_ca3086f0)
{
	elem = new cseeker_mine_prompt();
	[[ elem ]]->setup_clientfields(uid, var_afaddf7a, var_ca3086f0);
	return elem;
}

/*
	Name: register_clientside
	Namespace: seeker_mine_prompt
	Checksum: 0x845BDBA5
	Offset: 0x128
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cseeker_mine_prompt();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: seeker_mine_prompt
	Checksum: 0xED78596A
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
	Namespace: seeker_mine_prompt
	Checksum: 0x1052FB7F
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
	Namespace: seeker_mine_prompt
	Checksum: 0xF9ED2318
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
	Name: set_progress
	Namespace: seeker_mine_prompt
	Checksum: 0x43A19034
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_progress(localclientnum, value)
{
	[[ self ]]->set_progress(localclientnum, value);
}

/*
	Name: set_promptstate
	Namespace: seeker_mine_prompt
	Checksum: 0x4A520742
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_promptstate(localclientnum, value)
{
	[[ self ]]->set_promptstate(localclientnum, value);
}

