// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.gsc;
#using scripts\wz_common\wz_common_fixup.gsc;

#namespace namespace_731699f2;

/*
	Name: __init__
	Namespace: namespace_731699f2
	Checksum: 0xA8F62C4A
	Offset: 0x78
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	function_b35b2850();
}

/*
	Name: function_b35b2850
	Namespace: namespace_731699f2
	Checksum: 0x257C1AF6
	Offset: 0x98
	Size: 0x6CC
	Parameters: 0
	Flags: Linked
*/
function function_b35b2850()
{
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
	if(isdefined(getgametypesetting(#"wzheavymetalheroes")) && getgametypesetting(#"wzheavymetalheroes"))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"array_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"asylum_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"boxing_gym_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"clearing_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"construction_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"diner_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"dockyard_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"estate_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"factory_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"farm_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"farmtown_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"firing_range_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"fracking_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"ghosttown_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"graveyard_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hijacked_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hydro_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"lighthouse_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"nuketown_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"rivertown_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_5295664b3252e2a7", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"support_structure_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"train_station_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wind_turbine_list_guns_dlc1", #"heavy_metal_heroes_list_guns_dlc1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"world_base_event_parent", #"guns_launchers_dlc1");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_rocket_item", #"ammo_type_rocket_double_item");
		item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"supply_stash_parent_heavy_metal_heroes", 20);
	}
}

