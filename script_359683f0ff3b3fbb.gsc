// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cprototype_hud : cluielem
{

	/*
		Name: constructor
		Namespace: cprototype_hud
		Checksum: 0x8AD7FA37
		Offset: 0x6F0
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
		Checksum: 0x6BBACB80
		Offset: 0x1050
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
		Checksum: 0x83443C4
		Offset: 0x1018
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_deploy_prompt_visibility(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "deploy_prompt_visibility", value);
	}

	/*
		Name: set_fail_fanfare_visibility
		Namespace: cprototype_hud
		Checksum: 0x35F7FED4
		Offset: 0xFE0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_fail_fanfare_visibility(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "fail_fanfare_visibility", value);
	}

	/*
		Name: set_fanfare_visibility
		Namespace: cprototype_hud
		Checksum: 0x63172253
		Offset: 0xFA8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_fanfare_visibility(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "fanfare_visibility", value);
	}

	/*
		Name: set_objective3_strike
		Namespace: cprototype_hud
		Checksum: 0x2A074ED0
		Offset: 0xF70
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objective3_strike(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objective3_strike", value);
	}

	/*
		Name: set_objective2_strike
		Namespace: cprototype_hud
		Checksum: 0xBCF5371D
		Offset: 0xF38
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objective2_strike(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objective2_strike", value);
	}

	/*
		Name: set_objective1_strike
		Namespace: cprototype_hud
		Checksum: 0xC13D27E2
		Offset: 0xF00
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objective1_strike(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objective1_strike", value);
	}

	/*
		Name: set_objective_prompt_visibility
		Namespace: cprototype_hud
		Checksum: 0xE57D23F1
		Offset: 0xEC8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objective_prompt_visibility(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objective_prompt_visibility", value);
	}

	/*
		Name: set_objective3_string
		Namespace: cprototype_hud
		Checksum: 0xBA28CF0E
		Offset: 0xE90
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objective3_string(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objective3_string", value);
	}

	/*
		Name: set_objective2_string
		Namespace: cprototype_hud
		Checksum: 0x8382105
		Offset: 0xE58
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objective2_string(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objective2_string", value);
	}

	/*
		Name: set_objective1_string
		Namespace: cprototype_hud
		Checksum: 0xCC57AED
		Offset: 0xE20
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objective1_string(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objective1_string", value);
	}

	/*
		Name: set_active_objective_string
		Namespace: cprototype_hud
		Checksum: 0xB0024386
		Offset: 0xDE8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_active_objective_string(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "active_objective_string", value);
	}

	/*
		Name: set_craft_progress
		Namespace: cprototype_hud
		Checksum: 0x575562D
		Offset: 0xDB0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_craft_progress(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "craft_progress", value);
	}

	/*
		Name: set_resource_count_visibility
		Namespace: cprototype_hud
		Checksum: 0x65D5FA3F
		Offset: 0xD78
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_resource_count_visibility(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "resource_count_visibility", value);
	}

	/*
		Name: set_defense_resource_count
		Namespace: cprototype_hud
		Checksum: 0x36368D7F
		Offset: 0xD40
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_defense_resource_count(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "defense_resource_count", value);
	}

	/*
		Name: set_upgrade_resource_count
		Namespace: cprototype_hud
		Checksum: 0xB55B386D
		Offset: 0xD08
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_upgrade_resource_count(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "upgrade_resource_count", value);
	}

	/*
		Name: set_barrier_prompt_visibility
		Namespace: cprototype_hud
		Checksum: 0x345EC1CA
		Offset: 0xCD0
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_barrier_prompt_visibility(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "barrier_prompt_visibility", value);
	}

	/*
		Name: open
		Namespace: cprototype_hud
		Checksum: 0x9ED57063
		Offset: 0xC98
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"prototype_hud");
	}

	/*
		Name: function_fa582112
		Namespace: cprototype_hud
		Checksum: 0xA9E2B35C
		Offset: 0xA70
		Size: 0x220
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "barrier_prompt_visibility", 0);
		[[ self ]]->set_data(localclientnum, "upgrade_resource_count", 0);
		[[ self ]]->set_data(localclientnum, "defense_resource_count", 0);
		[[ self ]]->set_data(localclientnum, "resource_count_visibility", 0);
		[[ self ]]->set_data(localclientnum, "craft_progress", 0);
		[[ self ]]->set_data(localclientnum, "active_objective_string", #"");
		[[ self ]]->set_data(localclientnum, "objective1_string", #"");
		[[ self ]]->set_data(localclientnum, "objective2_string", #"");
		[[ self ]]->set_data(localclientnum, "objective3_string", #"");
		[[ self ]]->set_data(localclientnum, "objective_prompt_visibility", 0);
		[[ self ]]->set_data(localclientnum, "objective1_strike", 0);
		[[ self ]]->set_data(localclientnum, "objective2_strike", 0);
		[[ self ]]->set_data(localclientnum, "objective3_strike", 0);
		[[ self ]]->set_data(localclientnum, "fanfare_visibility", 0);
		[[ self ]]->set_data(localclientnum, "fail_fanfare_visibility", 0);
		[[ self ]]->set_data(localclientnum, "deploy_prompt_visibility", 0);
	}

	/*
		Name: register_clientside
		Namespace: cprototype_hud
		Checksum: 0x9255C0E2
		Offset: 0xA40
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
		Namespace: cprototype_hud
		Checksum: 0x14BE2DB8
		Offset: 0x710
		Size: 0x324
		Parameters: 17
		Flags: None
	*/
	function setup_clientfields(uid, var_fdf544c8, var_33c5c30f, var_96284758, var_bde1ea58, var_9a41cc6b, var_532cdc1a, var_3e5d22, var_61c0f0c1, var_5dd927bd, var_7a99f2e1, var_f3632296, var_d59bef9f, var_be5884c9, var_b5ae72b8, var_2b966169, var_83a9258)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("barrier_prompt_visibility", 4000, 1, "int", var_fdf544c8);
		cluielem::add_clientfield("upgrade_resource_count", 4000, 8, "int", var_33c5c30f);
		cluielem::add_clientfield("defense_resource_count", 4000, 8, "int", var_96284758);
		cluielem::add_clientfield("resource_count_visibility", 4000, 1, "int", var_bde1ea58);
		cluielem::add_clientfield("craft_progress", 4000, 5, "float", var_9a41cc6b);
		cluielem::function_dcb34c80("string", "active_objective_string", 4000);
		cluielem::function_dcb34c80("string", "objective1_string", 4000);
		cluielem::function_dcb34c80("string", "objective2_string", 4000);
		cluielem::function_dcb34c80("string", "objective3_string", 4000);
		cluielem::add_clientfield("objective_prompt_visibility", 4000, 1, "int", var_7a99f2e1);
		cluielem::add_clientfield("objective1_strike", 4000, 1, "int", var_f3632296);
		cluielem::add_clientfield("objective2_strike", 4000, 1, "int", var_d59bef9f);
		cluielem::add_clientfield("objective3_strike", 4000, 1, "int", var_be5884c9);
		cluielem::add_clientfield("fanfare_visibility", 4000, 1, "int", var_b5ae72b8);
		cluielem::add_clientfield("fail_fanfare_visibility", 4000, 1, "int", var_2b966169);
		cluielem::add_clientfield("deploy_prompt_visibility", 4000, 1, "int", var_83a9258);
	}

}

#namespace prototype_hud;

/*
	Name: register
	Namespace: prototype_hud
	Checksum: 0x15F92CE7
	Offset: 0x228
	Size: 0x100
	Parameters: 17
	Flags: None
*/
function register(uid, var_fdf544c8, var_33c5c30f, var_96284758, var_bde1ea58, var_9a41cc6b, var_532cdc1a, var_3e5d22, var_61c0f0c1, var_5dd927bd, var_7a99f2e1, var_f3632296, var_d59bef9f, var_be5884c9, var_b5ae72b8, var_2b966169, var_83a9258)
{
	elem = new cprototype_hud();
	[[ elem ]]->setup_clientfields(uid, var_fdf544c8, var_33c5c30f, var_96284758, var_bde1ea58, var_9a41cc6b, var_532cdc1a, var_3e5d22, var_61c0f0c1, var_5dd927bd, var_7a99f2e1, var_f3632296, var_d59bef9f, var_be5884c9, var_b5ae72b8, var_2b966169, var_83a9258);
	return elem;
}

/*
	Name: register_clientside
	Namespace: prototype_hud
	Checksum: 0x6ECBA657
	Offset: 0x330
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cprototype_hud();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: prototype_hud
	Checksum: 0xFB258825
	Offset: 0x378
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
	Namespace: prototype_hud
	Checksum: 0xD92C2363
	Offset: 0x3A0
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
	Checksum: 0xEE1D3D72
	Offset: 0x3C8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_barrier_prompt_visibility
	Namespace: prototype_hud
	Checksum: 0xE5752EC5
	Offset: 0x3F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_barrier_prompt_visibility(localclientnum, value)
{
	[[ self ]]->set_barrier_prompt_visibility(localclientnum, value);
}

/*
	Name: set_upgrade_resource_count
	Namespace: prototype_hud
	Checksum: 0xBE7BD400
	Offset: 0x420
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_upgrade_resource_count(localclientnum, value)
{
	[[ self ]]->set_upgrade_resource_count(localclientnum, value);
}

/*
	Name: set_defense_resource_count
	Namespace: prototype_hud
	Checksum: 0xA152AB90
	Offset: 0x450
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_defense_resource_count(localclientnum, value)
{
	[[ self ]]->set_defense_resource_count(localclientnum, value);
}

/*
	Name: set_resource_count_visibility
	Namespace: prototype_hud
	Checksum: 0x8B5C8FA3
	Offset: 0x480
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_resource_count_visibility(localclientnum, value)
{
	[[ self ]]->set_resource_count_visibility(localclientnum, value);
}

/*
	Name: set_craft_progress
	Namespace: prototype_hud
	Checksum: 0xC34A08C2
	Offset: 0x4B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_craft_progress(localclientnum, value)
{
	[[ self ]]->set_craft_progress(localclientnum, value);
}

/*
	Name: set_active_objective_string
	Namespace: prototype_hud
	Checksum: 0x8C5053C2
	Offset: 0x4E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_active_objective_string(localclientnum, value)
{
	[[ self ]]->set_active_objective_string(localclientnum, value);
}

/*
	Name: set_objective1_string
	Namespace: prototype_hud
	Checksum: 0xBED05BD8
	Offset: 0x510
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective1_string(localclientnum, value)
{
	[[ self ]]->set_objective1_string(localclientnum, value);
}

/*
	Name: set_objective2_string
	Namespace: prototype_hud
	Checksum: 0xCED478E0
	Offset: 0x540
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective2_string(localclientnum, value)
{
	[[ self ]]->set_objective2_string(localclientnum, value);
}

/*
	Name: set_objective3_string
	Namespace: prototype_hud
	Checksum: 0x71E995F9
	Offset: 0x570
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective3_string(localclientnum, value)
{
	[[ self ]]->set_objective3_string(localclientnum, value);
}

/*
	Name: set_objective_prompt_visibility
	Namespace: prototype_hud
	Checksum: 0x6C55145
	Offset: 0x5A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective_prompt_visibility(localclientnum, value)
{
	[[ self ]]->set_objective_prompt_visibility(localclientnum, value);
}

/*
	Name: set_objective1_strike
	Namespace: prototype_hud
	Checksum: 0xD0218F88
	Offset: 0x5D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective1_strike(localclientnum, value)
{
	[[ self ]]->set_objective1_strike(localclientnum, value);
}

/*
	Name: set_objective2_strike
	Namespace: prototype_hud
	Checksum: 0x23A72B1C
	Offset: 0x600
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective2_strike(localclientnum, value)
{
	[[ self ]]->set_objective2_strike(localclientnum, value);
}

/*
	Name: set_objective3_strike
	Namespace: prototype_hud
	Checksum: 0x3B052135
	Offset: 0x630
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objective3_strike(localclientnum, value)
{
	[[ self ]]->set_objective3_strike(localclientnum, value);
}

/*
	Name: set_fanfare_visibility
	Namespace: prototype_hud
	Checksum: 0x16C785E
	Offset: 0x660
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_fanfare_visibility(localclientnum, value)
{
	[[ self ]]->set_fanfare_visibility(localclientnum, value);
}

/*
	Name: set_fail_fanfare_visibility
	Namespace: prototype_hud
	Checksum: 0x16FC2E60
	Offset: 0x690
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_fail_fanfare_visibility(localclientnum, value)
{
	[[ self ]]->set_fail_fanfare_visibility(localclientnum, value);
}

/*
	Name: set_deploy_prompt_visibility
	Namespace: prototype_hud
	Checksum: 0x412797DB
	Offset: 0x6C0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_deploy_prompt_visibility(localclientnum, value)
{
	[[ self ]]->set_deploy_prompt_visibility(localclientnum, value);
}

