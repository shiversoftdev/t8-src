// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\wz_common\wz_common_fixup.csc;

#namespace namespace_ec834edc;

/*
	Name: __init__
	Namespace: namespace_ec834edc
	Checksum: 0x598918EF
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	function_62cd02cc();
}

/*
	Name: function_62cd02cc
	Namespace: namespace_ec834edc
	Checksum: 0x5ECDB861
	Offset: 0xE0
	Size: 0x10AC
	Parameters: 0
	Flags: Linked
*/
function function_62cd02cc()
{
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
	var_edfbccd0 = &item_world_fixup::function_e70fa91c;
	var_e92b5b25 = getgametypesetting(#"wzambush");
	if(isdefined(var_e92b5b25) && var_e92b5b25)
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_45_item", #"ammo_type_50cal_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_556_item", #"ammo_type_338_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_762_item", #"ammo_type_338_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_9mm_item", #"ammo_type_338_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_12ga_item", #"ammo_type_50cal_item");
		if(var_e92b5b25 == 1)
		{
			str_list = #"ambush";
		}
		else
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_good", #"equipment_list_good_ambush_v2");
			wz_common_fixup::item_replacer(var_edfbccd0, undefined, #"supply_stash_parent", #"ambush_v2_supply_stash_parent");
			wz_common_fixup::item_replacer(var_edfbccd0, undefined, #"supply_stash_parent_dlc1", #"ambush_v2_supply_stash_parent");
			wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"hash_30dcaca16025cb02", #"ambush_v2_supply_stash_weapons");
			str_list = #"ambush_v2";
		}
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_arav", #"open_skyscraper_vehicles_cargo_truck_small");
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
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot3_dlc1", #"ambush_supply_stash_slot3");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot4_dlc1", #"ambush_supply_stash_slot4");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot5_dlc1", #"ambush_supply_stash_slot5");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot1", str_list + "_supply_stash_slot1");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot2", str_list + "_supply_stash_slot2");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot3", #"ambush_supply_stash_slot3");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot4", #"ambush_supply_stash_slot4");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_slot5", #"ambush_supply_stash_slot5");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_operator_mod_weapons", #"supply_stash_operator_mod_weapons_ambush");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"supply_stash_gold_guns", str_list + "_guns_gold");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"blackjack_ammo_stash_guns", #"ambush_v2_blackjack_ammo_stash_guns");
		wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"loot_locker_parent", #"hash_5f368fdfb643d45e");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"attachment_list_good", #"hash_14c8f136272c2cc0");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"attachment_list_med", #"hash_629cbe2478d19625");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"attachment_list_low", #"attachment_list_low_ambush");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_low", #"hash_1d4ea58da145f816");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_zombie", #"equipment_list_zombie_ambush");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"gear_list_good", #"gear_list_good_ambush");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"consumable_list_low", #"hash_576fbac492e4d1cb");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"consumable_list_med", #"consumable_list_med_ambush");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"consumable_list_good", #"consumable_list_good_ambush");
		if(isdefined(getgametypesetting(#"wzenablewallbuyasylum")) && getgametypesetting(#"wzenablewallbuyasylum") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_asylum", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuydiner")) && getgametypesetting(#"wzenablewallbuydiner") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_diner", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuycemetary")) && getgametypesetting(#"wzenablewallbuycemetary") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_cemetary", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuyfarm")) && getgametypesetting(#"wzenablewallbuyfarm") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_farm", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuynuketown")) && getgametypesetting(#"wzenablewallbuynuketown") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_nuketown", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuyboxinggym")) && getgametypesetting(#"wzenablewallbuyboxinggym") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_boxing_gym", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuyghosttown")) && getgametypesetting(#"wzenablewallbuyghosttown") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_ghosttown", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
		}
		if(isdefined(getgametypesetting(#"wzenablewallbuylighthouse")) && getgametypesetting(#"wzenablewallbuylighthouse") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_lighthouse", #"wz_open_skyscrapers_wallbuy_guns_list_ambush");
		}
	}
}

