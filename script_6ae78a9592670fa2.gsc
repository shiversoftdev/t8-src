// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cmulti_stage_target_lockon : cluielem
{

	/*
		Name: constructor
		Namespace: cmulti_stage_target_lockon
		Checksum: 0x5568C6BD
		Offset: 0x238
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cmulti_stage_target_lockon
		Checksum: 0x968B1252
		Offset: 0x428
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_targetstate
		Namespace: cmulti_stage_target_lockon
		Checksum: 0x5F71E01D
		Offset: 0x3F0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_targetstate(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "targetState", value);
	}

	/*
		Name: set_entnum
		Namespace: cmulti_stage_target_lockon
		Checksum: 0x685D4A5E
		Offset: 0x3B8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_entnum(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "entNum", value);
	}

	/*
		Name: open
		Namespace: cmulti_stage_target_lockon
		Checksum: 0xC565287E
		Offset: 0x380
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"multi_stage_target_lockon");
	}

	/*
		Name: function_fa582112
		Namespace: cmulti_stage_target_lockon
		Checksum: 0x1EF80C26
		Offset: 0x318
		Size: 0x5C
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "entNum", 0);
		[[ self ]]->set_data(localclientnum, "targetState", 0);
	}

	/*
		Name: register_clientside
		Namespace: cmulti_stage_target_lockon
		Checksum: 0x38C59015
		Offset: 0x2E8
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
		Namespace: cmulti_stage_target_lockon
		Checksum: 0xFC42BA4
		Offset: 0x258
		Size: 0x84
		Parameters: 3
		Flags: None
	*/
	function setup_clientfields(uid, var_5a7b4b38, var_29786c92)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("entNum", 1, 6, "int", var_5a7b4b38);
		cluielem::add_clientfield("targetState", 1, 3, "int", var_29786c92);
	}

}

#namespace multi_stage_target_lockon;

/*
	Name: register
	Namespace: multi_stage_target_lockon
	Checksum: 0xC1CD047
	Offset: 0xB8
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function register(uid, var_5a7b4b38, var_29786c92)
{
	elem = new cmulti_stage_target_lockon();
	[[ elem ]]->setup_clientfields(uid, var_5a7b4b38, var_29786c92);
	return elem;
}

/*
	Name: register_clientside
	Namespace: multi_stage_target_lockon
	Checksum: 0x3BC24DE7
	Offset: 0x118
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cmulti_stage_target_lockon();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: multi_stage_target_lockon
	Checksum: 0x805FD78F
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
	Namespace: multi_stage_target_lockon
	Checksum: 0xDF513089
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
	Namespace: multi_stage_target_lockon
	Checksum: 0x357536BC
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
	Name: set_entnum
	Namespace: multi_stage_target_lockon
	Checksum: 0x625B55E
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_entnum(localclientnum, value)
{
	[[ self ]]->set_entnum(localclientnum, value);
}

/*
	Name: set_targetstate
	Namespace: multi_stage_target_lockon
	Checksum: 0x5CBB75D1
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_targetstate(localclientnum, value)
{
	[[ self ]]->set_targetstate(localclientnum, value);
}

