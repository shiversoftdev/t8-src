// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\wz_common\wz_common_fixup.csc;

#namespace namespace_d16db92;

/*
	Name: __init__
	Namespace: namespace_d16db92
	Checksum: 0x40B07F51
	Offset: 0x78
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	function_b01adb59();
}

/*
	Name: function_b01adb59
	Namespace: namespace_d16db92
	Checksum: 0xF3D5CFD6
	Offset: 0x98
	Size: 0x634
	Parameters: 0
	Flags: Linked
*/
function function_b01adb59()
{
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
	if(isdefined(getgametypesetting(#"hash_3083d02ea0f5761c")) && getgametypesetting(#"hash_3083d02ea0f5761c"))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_good", #"hash_3a8a0438d42ca57d");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"health_list_good", #"health_list_good_nothing");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"gear_list_good", #"gear_list_good_nothing");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_launchers_dlc1", #"guns_launchers_dlc1_limit_world_high_value");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_zombie", #"equipment_list_zombie_no_acid");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_gold_parent_dlc1", #"guns_gold_parent_dlc1_limit_world_high_value");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"hash_5d3928f724e1cadf", #"ammo_stash_parent_dlc1_limit_world_high_value");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_parent_dlc1", #"supply_stash_parent_dlc1_limit_world_high_value");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot1_dlc1", #"supply_stash_slot1_dlc1_limit_high_world_value");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot2_dlc1", #"supply_stash_slot2_dlc1_limit_world_high_value");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot3_dlc1", #"supply_stash_slot3_dlc1_limit_world_high_value");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot4_dlc1", #"supply_stash_slot4_dlc1_with_conc");
	}
	if(isdefined(getgametypesetting(#"wzenablehotpursuit")) && getgametypesetting(#"wzenablehotpursuit"))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_outlander");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"recon_car_wz_item");
	}
	if(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_police");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_12cd1dd2b05b0b78", #"hash_17040e317630b65b");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_suv_police");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"open_skyscraper_vehicles_heli_police");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_18134e61b5fb4bd0", #"hash_5c41d8b4c675c63");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_77502a4dc5ec85e8", #"hash_409deedc029d1655");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_pbr", #"open_skyscraper_vehicles_pbr_police");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_3b1a45effd27050", #"hash_409deedc029d1655");
	}
}

