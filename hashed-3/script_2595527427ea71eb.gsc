// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_3df1eeda : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_3df1eeda
		Checksum: 0x3F78A266
		Offset: 0x220
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_3df1eeda
		Checksum: 0xCE7AB3BE
		Offset: 0x3D0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_6ad54036
		Namespace: namespace_3df1eeda
		Checksum: 0xB293F207
		Offset: 0x388
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_6ad54036(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "under_round_rules", value);
	}

	/*
		Name: function_8ede8e82
		Namespace: namespace_3df1eeda
		Checksum: 0xE2B92088
		Offset: 0x340
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_8ede8e82(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "timer_text", value);
	}

	/*
		Name: close
		Namespace: namespace_3df1eeda
		Checksum: 0x58B8363D
		Offset: 0x310
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_3df1eeda
		Checksum: 0x879C2E53
		Offset: 0x2C0
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "zm_trial_timer", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_3df1eeda
		Checksum: 0x1405EF7
		Offset: 0x240
		Size: 0x74
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_dcb34c80("string", "timer_text", 1);
		namespace_6aaccc24::function_da693cbe("under_round_rules", 5000, 1, "int");
	}

}

#namespace zm_trial_timer;

/*
	Name: register
	Namespace: zm_trial_timer
	Checksum: 0x1B5E4684
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new class_3df1eeda();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_trial_timer
	Checksum: 0x313ECA49
	Offset: 0x130
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: zm_trial_timer
	Checksum: 0xF9250091
	Offset: 0x170
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: zm_trial_timer
	Checksum: 0xC5809CA1
	Offset: 0x198
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_8ede8e82
	Namespace: zm_trial_timer
	Checksum: 0xD4255224
	Offset: 0x1C0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_8ede8e82(player, value)
{
	[[ self ]]->function_8ede8e82(player, value);
}

/*
	Name: function_6ad54036
	Namespace: zm_trial_timer
	Checksum: 0x8CF695
	Offset: 0x1F0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_6ad54036(player, value)
{
	[[ self ]]->function_6ad54036(player, value);
}

