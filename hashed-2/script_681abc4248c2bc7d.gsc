// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_5563abae : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_5563abae
		Checksum: 0x33995178
		Offset: 0x288
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_5563abae
		Checksum: 0x358C1231
		Offset: 0x518
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_940bbc52
		Namespace: namespace_5563abae
		Checksum: 0xA75EEB4A
		Offset: 0x4D0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_940bbc52(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "decay", value);
	}

	/*
		Name: function_52773fa9
		Namespace: namespace_5563abae
		Checksum: 0xEC16543E
		Offset: 0x488
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_52773fa9(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "purity", value);
	}

	/*
		Name: function_5c237e79
		Namespace: namespace_5563abae
		Checksum: 0x301F9088
		Offset: 0x440
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_5c237e79(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "plasma", value);
	}

	/*
		Name: function_e5c37a19
		Namespace: namespace_5563abae
		Checksum: 0xAC90D776
		Offset: 0x3F8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_e5c37a19(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "radiance", value);
	}

	/*
		Name: close
		Namespace: namespace_5563abae
		Checksum: 0x9DF4BB6B
		Offset: 0x3C8
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
		Namespace: namespace_5563abae
		Checksum: 0x3D78BABF
		Offset: 0x378
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "zm_zod_wonderweapon_quest", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_5563abae
		Checksum: 0xFAB28428
		Offset: 0x2A8
		Size: 0xC4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("radiance", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("plasma", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("purity", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("decay", 1, 1, "int");
	}

}

#namespace zm_zod_wonderweapon_quest;

/*
	Name: register
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xEC263A18
	Offset: 0xF0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_5563abae();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xD87B8AA2
	Offset: 0x138
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
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xB3AD1D5E
	Offset: 0x178
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
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xF3A522B
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_e5c37a19
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x71BD35FE
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_e5c37a19(player, value)
{
	[[ self ]]->function_e5c37a19(player, value);
}

/*
	Name: function_5c237e79
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xFE874A47
	Offset: 0x1F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5c237e79(player, value)
{
	[[ self ]]->function_5c237e79(player, value);
}

/*
	Name: function_52773fa9
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x944268FB
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_52773fa9(player, value)
{
	[[ self ]]->function_52773fa9(player, value);
}

/*
	Name: function_940bbc52
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x6F5DF670
	Offset: 0x258
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_940bbc52(player, value)
{
	[[ self ]]->function_940bbc52(player, value);
}

