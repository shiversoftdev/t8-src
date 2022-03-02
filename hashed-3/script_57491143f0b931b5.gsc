// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_8c34ca59 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_8c34ca59
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
		Namespace: namespace_8c34ca59
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
		Name: function_c719cfea
		Namespace: namespace_8c34ca59
		Checksum: 0xB72D4E15
		Offset: 0x380
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_c719cfea(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "promptState", value);
	}

	/*
		Name: function_affe8f61
		Namespace: namespace_8c34ca59
		Checksum: 0x4A765BAE
		Offset: 0x338
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_affe8f61(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "progress", value);
	}

	/*
		Name: close
		Namespace: namespace_8c34ca59
		Checksum: 0xD31BB692
		Offset: 0x308
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_8c34ca59
		Checksum: 0x8A312C9C
		Offset: 0x2B8
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "seeker_mine_prompt", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_8c34ca59
		Checksum: 0x7AC5DC51
		Offset: 0x238
		Size: 0x74
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("progress", 1, 5, "float");
		namespace_6aaccc24::function_da693cbe("promptState", 1, 2, "int");
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
	elem = new class_8c34ca59();
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
	Name: function_affe8f61
	Namespace: seeker_mine_prompt
	Checksum: 0x22FB9802
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_affe8f61(player, value)
{
	[[ self ]]->function_affe8f61(player, value);
}

/*
	Name: function_c719cfea
	Namespace: seeker_mine_prompt
	Checksum: 0xC2A9EA5B
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_c719cfea(player, value)
{
	[[ self ]]->function_c719cfea(player, value);
}

