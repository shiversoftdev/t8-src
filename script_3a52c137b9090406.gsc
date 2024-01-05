// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\wz_common\wz_common_fixup.csc;

#namespace namespace_8149bbf5;

/*
	Name: function_45a212c0
	Namespace: namespace_8149bbf5
	Checksum: 0x4B28B1A1
	Offset: 0x78
	Size: 0xBD4
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_45a212c0()
{
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
	if(isdefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle"))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_12ga_item", #"ammo_type_12ga_double_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_338_item", #"ammo_type_338_double_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_45_item", #"ammo_type_45_double_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"hash_49fecbcd6cbd1ed9", #"ammo_type_50cal_double_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_556_item", #"ammo_type_556_double_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_762_item", #"ammo_type_762_double_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_9mm_item", #"ammo_type_9mm_double_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_rocket_item", #"ammo_type_rocket_double_item");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"array_list_item_default_dlc1", #"array_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"asylum_list_item_default_dlc1", #"asylum_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"boxing_gym_list_item_default_dlc1", #"boxing_gym_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"clearing_list_item_default_dlc1", #"clearing_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"construction_list_item_default_dlc1", #"construction_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"diner_list_item_default_dlc1", #"diner_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"dockyard_list_item_default_dlc1", #"dockyard_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"estate_list_item_default_dlc1", #"estate_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"factory_list_item_default_dlc1", #"factory_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"farm_list_item_default_dlc1", #"farm_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"farmtown_list_item_default_dlc1", #"farmtown_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"firing_range_list_item_default_dlc1", #"firing_range_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"fracking_list_item_default_dlc1", #"fracking_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"graveyard_list_item_default_dlc1", #"graveyard_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hijacked_list_item_default_dlc1", #"hijacked_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hydro_list_item_default_dlc1", #"hydro_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"lighthouse_list_item_default_dlc1", #"lighthouse_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"nuketown_list_item_default_dlc1", #"nuketown_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"rivertown_list_item_default_dlc1", #"rivertown_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"support_structure_list_item_default_dlc1", #"support_structure_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"train_station_list_item_default_dlc1", #"train_station_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wind_turbine_list_item_default_dlc1", #"wind_turbine_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"ghosttown_list_item_default_dlc1", #"ghosttown_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"array_list_item_default_small_dlc1", #"array_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"asylum_list_item_default_small_dlc1", #"asylum_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"construction_list_item_default_small_dlc1", #"construction_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"dockyard_list_item_default_small_dlc1", #"dockyard_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"estate_list_item_default_small_dlc1", #"estate_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"factory_list_item_default_small_dlc1", #"factory_list_items_small");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"farm_list_item_default_small_dlc1", #"farm_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"farmtown_list_item_default_small_dlc1", #"farmtown_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"firing_range_list_item_default_small_dlc1", #"firing_range_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"fracking_list_item_default_small_dlc1", #"fracking_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hydro_list_item_default_small_dlc1", #"hydro_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"nuketown_list_item_default_small_dlc1", #"nuketown_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"rivertown_list_item_default_small_dlc1", #"rivertown_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"support_structure_list_item_default_small_dlc1", #"support_structure_list_items_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"train_station_list_item_default_small_dlc1", #"train_station_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wind_turbine_list_item_default_small_dlc1", #"wind_turbine_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"ghosttown_list_item_default_small_dlc1", #"ghosttown_list_items_small_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"world_base_event_parent", #"firing_range_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"supply_stash_parent_dlc1", #"supply_stash_parent_big_team_battle");
	}
}

