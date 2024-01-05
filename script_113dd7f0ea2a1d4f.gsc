// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class cprototype_hud : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cprototype_hud
		Checksum: 0xD146032D
		Offset: 0x618
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cprototype_hud
		Checksum: 0xFB3A1CC8
		Offset: 0xDE8
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_deploy_prompt_visibility
		Namespace: cprototype_hud
		Checksum: 0x9BD15039
		Offset: 0xDA0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_deploy_prompt_visibility(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "deploy_prompt_visibility", value);
	}

	/*
		Name: set_fail_fanfare_visibility
		Namespace: cprototype_hud
		Checksum: 0xA9BBFFBD
		Offset: 0xD58
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_fail_fanfare_visibility(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "fail_fanfare_visibility", value);
	}

	/*
		Name: set_fanfare_visibility
		Namespace: cprototype_hud
		Checksum: 0xCA916871
		Offset: 0xD10
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_fanfare_visibility(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "fanfare_visibility", value);
	}

	/*
		Name: set_objective3_strike
		Namespace: cprototype_hud
		Checksum: 0xFBD1DE33
		Offset: 0xCC8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objective3_strike(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objective3_strike", value);
	}

	/*
		Name: set_objective2_strike
		Namespace: cprototype_hud
		Checksum: 0xCF9D1BD0
		Offset: 0xC80
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objective2_strike(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objective2_strike", value);
	}

	/*
		Name: set_objective1_strike
		Namespace: cprototype_hud
		Checksum: 0x7B924F7F
		Offset: 0xC38
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objective1_strike(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objective1_strike", value);
	}

	/*
		Name: set_objective_prompt_visibility
		Namespace: cprototype_hud
		Checksum: 0x38273724
		Offset: 0xBF0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objective_prompt_visibility(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objective_prompt_visibility", value);
	}

	/*
		Name: set_objective3_string
		Namespace: cprototype_hud
		Checksum: 0xF6F0374E
		Offset: 0xBA8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objective3_string(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objective3_string", value);
	}

	/*
		Name: set_objective2_string
		Namespace: cprototype_hud
		Checksum: 0xCBDAC031
		Offset: 0xB60
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objective2_string(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objective2_string", value);
	}

	/*
		Name: set_objective1_string
		Namespace: cprototype_hud
		Checksum: 0x2BECF7C4
		Offset: 0xB18
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objective1_string(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objective1_string", value);
	}

	/*
		Name: set_active_objective_string
		Namespace: cprototype_hud
		Checksum: 0xBA7A32EB
		Offset: 0xAD0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_active_objective_string(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "active_objective_string", value);
	}

	/*
		Name: set_craft_progress
		Namespace: cprototype_hud
		Checksum: 0xE2C4BF8
		Offset: 0xA88
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_craft_progress(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "craft_progress", value);
	}

	/*
		Name: set_resource_count_visibility
		Namespace: cprototype_hud
		Checksum: 0x1C66732B
		Offset: 0xA40
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_resource_count_visibility(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "resource_count_visibility", value);
	}

	/*
		Name: set_defense_resource_count
		Namespace: cprototype_hud
		Checksum: 0xA007F782
		Offset: 0x9F8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_defense_resource_count(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "defense_resource_count", value);
	}

	/*
		Name: set_upgrade_resource_count
		Namespace: cprototype_hud
		Checksum: 0xB7AEB639
		Offset: 0x9B0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_upgrade_resource_count(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "upgrade_resource_count", value);
	}

	/*
		Name: set_barrier_prompt_visibility
		Namespace: cprototype_hud
		Checksum: 0x91AD8421
		Offset: 0x968
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_barrier_prompt_visibility(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "barrier_prompt_visibility", value);
	}

	/*
		Name: close
		Namespace: cprototype_hud
		Checksum: 0xD42AEE95
		Offset: 0x938
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
		Namespace: cprototype_hud
		Checksum: 0xB70060FA
		Offset: 0x8E8
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "prototype_hud", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cprototype_hud
		Checksum: 0x900FAA92
		Offset: 0x638
		Size: 0x2A4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("barrier_prompt_visibility", 4000, 1, "int");
		cluielem::add_clientfield("upgrade_resource_count", 4000, 8, "int");
		cluielem::add_clientfield("defense_resource_count", 4000, 8, "int");
		cluielem::add_clientfield("resource_count_visibility", 4000, 1, "int");
		cluielem::add_clientfield("craft_progress", 4000, 5, "float");
		cluielem::function_dcb34c80("string", "active_objective_string", 4000);
		cluielem::function_dcb34c80("string", "objective1_string", 4000);
		cluielem::function_dcb34c80("string", "objective2_string", 4000);
		cluielem::function_dcb34c80("string", "objective3_string", 4000);
		cluielem::add_clientfield("objective_prompt_visibility", 4000, 1, "int");
		cluielem::add_clientfield("objective1_strike", 4000, 1, "int");
		cluielem::add_clientfield("objective2_strike", 4000, 1, "int");
		cluielem::add_clientfield("objective3_strike", 4000, 1, "int");
		cluielem::add_clientfield("fanfare_visibility", 4000, 1, "int");
		cluielem::add_clientfield("fail_fanfare_visibility", 4000, 1, "int");
		cluielem::add_clientfield("deploy_prompt_visibility", 4000, 1, "int");
	}

}

#namespace prototype_hud;

/*
	Name: register
	Namespace: prototype_hud
	Checksum: 0xF9BF629C
	Offset: 0x240
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cprototype_hud();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: prototype_hud
	Checksum: 0x8720B9F4
	Offset: 0x288
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
	Namespace: prototype_hud
	Checksum: 0xA34A2964
	Offset: 0x2C8
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
	Namespace: prototype_hud
	Checksum: 0xC3F00B51
	Offset: 0x2F0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_barrier_prompt_visibility
	Namespace: prototype_hud
	Checksum: 0xF5E16B7B
	Offset: 0x318
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_barrier_prompt_visibility(player, value)
{
	[[ self ]]->set_barrier_prompt_visibility(player, value);
}

/*
	Name: set_upgrade_resource_count
	Namespace: prototype_hud
	Checksum: 0x37EFDFA4
	Offset: 0x348
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_upgrade_resource_count(player, value)
{
	[[ self ]]->set_upgrade_resource_count(player, value);
}

/*
	Name: set_defense_resource_count
	Namespace: prototype_hud
	Checksum: 0x9A52CF9C
	Offset: 0x378
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_defense_resource_count(player, value)
{
	[[ self ]]->set_defense_resource_count(player, value);
}

/*
	Name: set_resource_count_visibility
	Namespace: prototype_hud
	Checksum: 0xCD246604
	Offset: 0x3A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_resource_count_visibility(player, value)
{
	[[ self ]]->set_resource_count_visibility(player, value);
}

/*
	Name: set_craft_progress
	Namespace: prototype_hud
	Checksum: 0x107C6EDF
	Offset: 0x3D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_craft_progress(player, value)
{
	[[ self ]]->set_craft_progress(player, value);
}

/*
	Name: set_active_objective_string
	Namespace: prototype_hud
	Checksum: 0xEC2383FE
	Offset: 0x408
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_active_objective_string(player, value)
{
	[[ self ]]->set_active_objective_string(player, value);
}

/*
	Name: set_objective1_string
	Namespace: prototype_hud
	Checksum: 0xA21D1015
	Offset: 0x438
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective1_string(player, value)
{
	[[ self ]]->set_objective1_string(player, value);
}

/*
	Name: set_objective2_string
	Namespace: prototype_hud
	Checksum: 0xFE8FA60B
	Offset: 0x468
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective2_string(player, value)
{
	[[ self ]]->set_objective2_string(player, value);
}

/*
	Name: set_objective3_string
	Namespace: prototype_hud
	Checksum: 0x30E73DB1
	Offset: 0x498
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective3_string(player, value)
{
	[[ self ]]->set_objective3_string(player, value);
}

/*
	Name: set_objective_prompt_visibility
	Namespace: prototype_hud
	Checksum: 0x90749BB7
	Offset: 0x4C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective_prompt_visibility(player, value)
{
	[[ self ]]->set_objective_prompt_visibility(player, value);
}

/*
	Name: set_objective1_strike
	Namespace: prototype_hud
	Checksum: 0x5195E9EF
	Offset: 0x4F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective1_strike(player, value)
{
	[[ self ]]->set_objective1_strike(player, value);
}

/*
	Name: set_objective2_strike
	Namespace: prototype_hud
	Checksum: 0x9B00B84A
	Offset: 0x528
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective2_strike(player, value)
{
	[[ self ]]->set_objective2_strike(player, value);
}

/*
	Name: set_objective3_strike
	Namespace: prototype_hud
	Checksum: 0xAA6C1924
	Offset: 0x558
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective3_strike(player, value)
{
	[[ self ]]->set_objective3_strike(player, value);
}

/*
	Name: set_fanfare_visibility
	Namespace: prototype_hud
	Checksum: 0xABACBBCA
	Offset: 0x588
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_fanfare_visibility(player, value)
{
	[[ self ]]->set_fanfare_visibility(player, value);
}

/*
	Name: set_fail_fanfare_visibility
	Namespace: prototype_hud
	Checksum: 0x6A6D29B5
	Offset: 0x5B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_fail_fanfare_visibility(player, value)
{
	[[ self ]]->set_fail_fanfare_visibility(player, value);
}

/*
	Name: set_deploy_prompt_visibility
	Namespace: prototype_hud
	Checksum: 0xF608C7AB
	Offset: 0x5E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_deploy_prompt_visibility(player, value)
{
	[[ self ]]->set_deploy_prompt_visibility(player, value);
}

