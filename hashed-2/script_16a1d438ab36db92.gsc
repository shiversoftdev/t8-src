// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\wz_common_fixup.gsc;
#using script_170a9c130859c688;

#namespace namespace_d16db92;

/*
	Name: __init__
	Namespace: namespace_d16db92
	Checksum: 0x40D760E0
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
	Checksum: 0xC9CB7338
	Offset: 0x98
	Size: 0x634
	Parameters: 0
	Flags: Linked
*/
function function_b01adb59()
{
	var_a12b4736 = &namespace_b0722f43::function_96ff7b88;
	var_d2223309 = &namespace_b0722f43::function_261ab7f5;
	var_b5014996 = &namespace_b0722f43::function_19089c75;
	var_87d0eef8 = &namespace_b0722f43::remove_item;
	var_74257310 = &namespace_b0722f43::function_6da5e673;
	var_f8a4c541 = &namespace_b0722f43::function_6991057;
	if(isdefined(getgametypesetting(#"hash_3083d02ea0f5761c")) && getgametypesetting(#"hash_3083d02ea0f5761c"))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"equipment_list_good", #"hash_3a8a0438d42ca57d");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_610716711c6bf258", #"hash_74cdb6ca983d3aca");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_3f8034fc64c31ee1", #"hash_797c130a680817a3");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_60da8dc472901c8d", #"hash_33c658398f3aa905");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"equipment_list_zombie", #"hash_1985194fedbf5145");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_25fc1eba4e8349b", #"hash_3b57a72645fe6d33");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_5d3928f724e1cadf", #"hash_22b2e7dbec67dd6f");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_4bfbb656e63b17ae", #"hash_68edd805f8bad724");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_774a49591e12d6d", #"hash_6843501c099865b");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_53568e2a0a929c12", #"hash_7e5f4822b2b5e4c0");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_4be238cfa4c911b7", #"hash_7854b89f632d51b7");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_58959191442a7ad4", #"hash_46aab46da9f75b03");
	}
	if(isdefined(getgametypesetting(#"wzenablehotpursuit")) && getgametypesetting(#"wzenablehotpursuit"))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1b898a6e72d622d8");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"recon_car_wz_item");
	}
	if(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_36914ef7c27bbd5a");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_12cd1dd2b05b0b78", #"hash_17040e317630b65b");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_139acdd590ca3442", #"hash_696b5472b07bcdf");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6d90d15ce8e75ac2", #"hash_200a2ee47e09256d");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_18134e61b5fb4bd0", #"hash_5c41d8b4c675c63");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_77502a4dc5ec85e8", #"hash_409deedc029d1655");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_1926dc7c3ce2bfb2", #"hash_667491938ccaaf7d");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_3b1a45effd27050", #"hash_409deedc029d1655");
	}
}

