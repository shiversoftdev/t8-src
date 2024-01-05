// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\wz_common\wz_common_fixup.csc;

#namespace namespace_794c7965;

/*
	Name: __init__
	Namespace: namespace_794c7965
	Checksum: 0x4DE8E91B
	Offset: 0x140
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	function_e420bad2();
}

/*
	Name: function_e420bad2
	Namespace: namespace_794c7965
	Checksum: 0xBAC78210
	Offset: 0x160
	Size: 0x6C4
	Parameters: 0
	Flags: Linked
*/
function function_e420bad2()
{
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
	var_edfbccd0 = &item_world_fixup::function_e70fa91c;
	if(isdefined(getgametypesetting(#"wzweaponstest")) && getgametypesetting(#"wzweaponstest"))
	{
		str_list = #"weapons_test";
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"world_base_event_parent", str_list + "_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_low", str_list + "_equipment_list_good");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_med", str_list + "_equipment_list_good");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_good", str_list + "_equipment_list_good");
		wz_common_fixup::item_replacer(var_edfbccd0, undefined, #"supply_stash_parent", str_list + "_supply_stash_parent");
		wz_common_fixup::item_replacer(var_edfbccd0, undefined, #"supply_stash_parent_dlc1", str_list + "_supply_stash_parent");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"hash_30dcaca16025cb02", str_list + "_guns_gold");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"health_item_medium", #"health_item_squad");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"health_item_large", #"health_item_squad");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_zombie_dlc1", str_list + "_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_pistols_dlc1", str_list + "_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_shotguns_dlc1", str_list + "_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_smgs_dlc1", str_list + "_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_ars_dlc1", str_list + "_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_trs_dlc1", str_list + "_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_lmgs_dlc1", str_list + "_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_gold_parent", str_list + "_guns_gold");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_gold_parent_dlc1", str_list + "_guns_gold");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot1_dlc1", str_list + "_supply_stash_slot1");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot2_dlc1", str_list + "_supply_stash_slot2");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot3_dlc1", str_list + "_supply_stash_slot3");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot4_dlc1", str_list + "_supply_stash_slot4");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot5_dlc1", str_list + "_supply_stash_slot5");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot1", str_list + "_supply_stash_slot1");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot2", str_list + "_supply_stash_slot2");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot3", str_list + "_supply_stash_slot3");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot4", str_list + "_supply_stash_slot4");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot5", str_list + "_supply_stash_slot5");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_operator_mod_weapons", str_list + "_guns_operator");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_gold_guns", str_list + "_guns_gold");
	}
}

