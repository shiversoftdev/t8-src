// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class cseeker_mine_prompt : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cseeker_mine_prompt
		Checksum: 0xACB74FC7
		Offset: 0x218
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
		Checksum: 0x746F1B1B
		Offset: 0x3C8
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
		Checksum: 0xB72D4E15
		Offset: 0x380
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_promptstate(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "promptState", value);
	}

	/*
		Name: set_progress
		Namespace: cseeker_mine_prompt
		Checksum: 0x4A765BAE
		Offset: 0x338
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_progress(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "progress", value);
	}

	/*
		Name: close
		Namespace: cseeker_mine_prompt
		Checksum: 0xD31BB692
		Offset: 0x308
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cluielem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cseeker_mine_prompt
		Checksum: 0x8A312C9C
		Offset: 0x2B8
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "seeker_mine_prompt", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cseeker_mine_prompt
		Checksum: 0x7AC5DC51
		Offset: 0x238
		Size: 0x74
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("progress", 1, 5, "float");
		cluielem::add_clientfield("promptState", 1, 2, "int");
	}

}

#namespace seeker_mine_prompt;

/*
	Name: register
	Namespace: seeker_mine_prompt
	Checksum: 0xC7C19110
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cseeker_mine_prompt();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: seeker_mine_prompt
	Checksum: 0xE65CB3FE
	Offset: 0x128
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
	Namespace: seeker_mine_prompt
	Checksum: 0x7879C02B
	Offset: 0x168
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
	Checksum: 0x551F3E7E
	Offset: 0x190
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_progress
	Namespace: seeker_mine_prompt
	Checksum: 0x22FB9802
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_progress(player, value)
{
	[[ self ]]->set_progress(player, value);
}

/*
	Name: set_promptstate
	Namespace: seeker_mine_prompt
	Checksum: 0xC2A9EA5B
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_promptstate(player, value)
{
	[[ self ]]->set_promptstate(player, value);
}

