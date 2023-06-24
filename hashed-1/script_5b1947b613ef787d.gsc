// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\wz_common_fixup.gsc;
#using script_170a9c130859c688;

#namespace namespace_794c7965;

/*
	Name: __init__
	Namespace: namespace_794c7965
	Checksum: 0x76E16419
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
	Checksum: 0xF66456D
	Offset: 0x160
	Size: 0x6C4
	Parameters: 0
	Flags: Linked
*/
function function_e420bad2()
{
	var_a12b4736 = &namespace_b0722f43::function_96ff7b88;
	var_d2223309 = &namespace_b0722f43::function_261ab7f5;
	var_b5014996 = &namespace_b0722f43::function_19089c75;
	var_87d0eef8 = &namespace_b0722f43::remove_item;
	var_74257310 = &namespace_b0722f43::function_6da5e673;
	var_f8a4c541 = &namespace_b0722f43::function_6991057;
	var_edfbccd0 = &namespace_b0722f43::function_e70fa91c;
	if(isdefined(getgametypesetting(#"wzweaponstest")) && getgametypesetting(#"wzweaponstest"))
	{
		str_list = #"weapons_test";
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_56933bc0ebda6f33", str_list + "_guns");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_230efa8b15f70979", str_list + "_equipment_list_good");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_1b31f48b11bd3801", str_list + "_equipment_list_good");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"equipment_list_good", str_list + "_equipment_list_good");
		wz_common_fixup::function_149cbc84(var_edfbccd0, undefined, #"supply_stash_parent", str_list + "_supply_stash_parent");
		wz_common_fixup::function_149cbc84(var_edfbccd0, undefined, #"hash_4bfbb656e63b17ae", str_list + "_supply_stash_parent");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_30dcaca16025cb02", str_list + "_guns_gold");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_ff50c93155e445f", #"hash_45ced3880667df22");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_80292d121740f6f", #"hash_45ced3880667df22");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_670d02ab3b4128b2", str_list + "_guns");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_46f73ca5ddb4e276", str_list + "_guns");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_73b67150c513b4f9", str_list + "_guns");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_4a637cd4a03131b2", str_list + "_guns");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_27e22f275feb07fe", str_list + "_guns");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_5169964579e807e3", str_list + "_guns");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_3c8a483e6ebb08cb", str_list + "_guns");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_288777455d94303e", str_list + "_guns_gold");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_25fc1eba4e8349b", str_list + "_guns_gold");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_774a49591e12d6d", str_list + "_supply_stash_slot1");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_53568e2a0a929c12", str_list + "_supply_stash_slot2");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_4be238cfa4c911b7", str_list + "_supply_stash_slot3");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_58959191442a7ad4", str_list + "_supply_stash_slot4");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_3ea2902b7908e871", str_list + "_supply_stash_slot5");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"supply_stash_slot1", str_list + "_supply_stash_slot1");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"supply_stash_slot2", str_list + "_supply_stash_slot2");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"supply_stash_slot3", str_list + "_supply_stash_slot3");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"supply_stash_slot4", str_list + "_supply_stash_slot4");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"supply_stash_slot5", str_list + "_supply_stash_slot5");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_166d47d063a39440", str_list + "_guns_operator");
		wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_7f70b6e5eca04933", str_list + "_guns_gold");
	}
}

