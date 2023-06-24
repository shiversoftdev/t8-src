// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class czm_zod_wonderweapon_quest : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: czm_zod_wonderweapon_quest
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
		Namespace: czm_zod_wonderweapon_quest
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
		Name: set_decay
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0xA75EEB4A
		Offset: 0x4D0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_decay(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "decay", value);
	}

	/*
		Name: set_purity
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0xEC16543E
		Offset: 0x488
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_purity(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "purity", value);
	}

	/*
		Name: set_plasma
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x301F9088
		Offset: 0x440
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_plasma(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "plasma", value);
	}

	/*
		Name: set_radiance
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0xAC90D776
		Offset: 0x3F8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_radiance(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "radiance", value);
	}

	/*
		Name: close
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x9DF4BB6B
		Offset: 0x3C8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cLUIelem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x3D78BABF
		Offset: 0x378
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "zm_zod_wonderweapon_quest", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0xFAB28428
		Offset: 0x2A8
		Size: 0xC4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("radiance", 1, 1, "int");
		cLUIelem::function_da693cbe("plasma", 1, 1, "int");
		cLUIelem::function_da693cbe("purity", 1, 1, "int");
		cLUIelem::function_da693cbe("decay", 1, 1, "int");
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
	elem = new czm_zod_wonderweapon_quest();
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
	Name: set_radiance
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x71BD35FE
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_radiance(player, value)
{
	[[ self ]]->set_radiance(player, value);
}

/*
	Name: set_plasma
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xFE874A47
	Offset: 0x1F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_plasma(player, value)
{
	[[ self ]]->set_plasma(player, value);
}

/*
	Name: set_purity
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x944268FB
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_purity(player, value)
{
	[[ self ]]->set_purity(player, value);
}

/*
	Name: set_decay
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x6F5DF670
	Offset: 0x258
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_decay(player, value)
{
	[[ self ]]->set_decay(player, value);
}

