// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\wz_common\wz_common_fixup.csc;

#namespace namespace_8adbca95;

/*
	Name: __init__
	Namespace: namespace_8adbca95
	Checksum: 0x9DA5EB78
	Offset: 0x78
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	function_c77b33db();
}

/*
	Name: function_c77b33db
	Namespace: namespace_8adbca95
	Checksum: 0xF0D92A5C
	Offset: 0x98
	Size: 0xCAC
	Parameters: 0
	Flags: Linked
*/
function function_c77b33db()
{
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
	if(isdefined(getgametypesetting(#"hash_3109a8794543000f")) && getgametypesetting(#"hash_3109a8794543000f"))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_338_item", #"ammo_type_9mm_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_762_item", #"ammo_type_12ga_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_50cal_item", #"ammo_type_9mm_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_556_item", #"ammo_type_45_item");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_ars_dlc1", #"closequarters_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_trs_dlc1", #"closequarters_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_lmgs_dlc1", #"closequarters_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_snipers_dlc1", #"closequarters_guns");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"guns_gold_parent_dlc1", #"closequarters_guns_gold");
		wz_common_fixup::item_replacer(var_74257310, undefined, #"warmachine_wz_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_74257310, undefined, #"flamethrower_wz_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot1_dlc1", #"supply_stash_slot1_closequarters");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot2_dlc1", #"supply_stash_slot2_closequarters");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot3_dlc1", #"supply_stash_slot3_closequarters");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot4_dlc1", #"supply_stash_slot4_closequarters");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot5_dlc1", #"supply_stash_slot5_closequarters");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_operator_mod_weapons", #"supply_stash_operator_mod_weapons_closequarters");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_gold_guns", #"closequarters_guns_gold");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"loot_locker_parent", #"loot_locker_parent_ccf");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"attachment_list_good", #"attachment_list_good_closequarters");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"attachment_list_med", #"attachment_list_med_closequarters");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"consumable_list_low", #"consumable_list_low_closequarters");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_11f313217dbe7186", #"wz_escape_wallbuy_guns_list_closequarters");
		if(isdefined(getgametypesetting(#"wzenablewallbuyasylum")) && getgametypesetting(#"wzenablewallbuyasylum") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_asylum", #"wz_open_skyscrapers_wallbuy_guns_list_closequarters");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuydiner")) && getgametypesetting(#"wzenablewallbuydiner") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_diner", #"wz_open_skyscrapers_wallbuy_guns_list_closequarters");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuycemetary")) && getgametypesetting(#"wzenablewallbuycemetary") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_cemetary", #"wz_open_skyscrapers_wallbuy_guns_list_closequarters");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuyfarm")) && getgametypesetting(#"wzenablewallbuyfarm") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_farm", #"wz_open_skyscrapers_wallbuy_guns_list_closequarters");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuynuketown")) && getgametypesetting(#"wzenablewallbuynuketown") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_nuketown", #"wz_open_skyscrapers_wallbuy_guns_list_closequarters");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuyboxinggym")) && getgametypesetting(#"wzenablewallbuyboxinggym") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_boxing_gym", #"wz_open_skyscrapers_wallbuy_guns_list_closequarters");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuyghosttown")) && getgametypesetting(#"wzenablewallbuyghosttown") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_ghosttown", #"wz_open_skyscrapers_wallbuy_guns_list_closequarters");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuylighthouse")) && getgametypesetting(#"wzenablewallbuylighthouse") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_lighthouse", #"wz_open_skyscrapers_wallbuy_guns_list_closequarters");
		}
	}
}

