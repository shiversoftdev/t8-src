// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_12bf89f7 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_12bf89f7
		Checksum: 0xE092AC28
		Offset: 0x1D8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_12bf89f7
		Checksum: 0xAE2606F5
		Offset: 0x310
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_1e74977
		Namespace: namespace_12bf89f7
		Checksum: 0xDF200818
		Offset: 0x2D0
		Size: 0x34
		Parameters: 1
		Flags: None
	*/
	function function_1e74977(player)
	{
		player clientfield::function_bb878fc3(var_47e79fc, "show_icon");
	}

	/*
		Name: close
		Namespace: namespace_12bf89f7
		Checksum: 0x8159D702
		Offset: 0x2A0
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
		Namespace: namespace_12bf89f7
		Checksum: 0x7A109E1B
		Offset: 0x250
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "zm_trial_weapon_locked", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_12bf89f7
		Checksum: 0xD5AC8B98
		Offset: 0x1F8
		Size: 0x4C
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("show_icon", 1, 1, "counter");
	}

}

#namespace zm_trial_weapon_locked;

/*
	Name: register
	Namespace: zm_trial_weapon_locked
	Checksum: 0x6B18BA85
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_12bf89f7();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_trial_weapon_locked
	Checksum: 0x5A389AF7
	Offset: 0x120
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
	Namespace: zm_trial_weapon_locked
	Checksum: 0xC559A93E
	Offset: 0x160
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
	Namespace: zm_trial_weapon_locked
	Checksum: 0x7F3A5514
	Offset: 0x188
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_1e74977
	Namespace: zm_trial_weapon_locked
	Checksum: 0x242FB16C
	Offset: 0x1B0
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function function_1e74977(player)
{
	[[ self ]]->function_1e74977(player);
}

