// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\wz_common_fixup.gsc;
#using script_170a9c130859c688;

#namespace namespace_69456f97;

/*
	Name: __init__
	Namespace: namespace_69456f97
	Checksum: 0x92CC2EFE
	Offset: 0x78
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	function_acd44e5f();
}

/*
	Name: function_acd44e5f
	Namespace: namespace_69456f97
	Checksum: 0x51F32C0F
	Offset: 0x98
	Size: 0x2CC
	Parameters: 0
	Flags: Linked
*/
function function_acd44e5f()
{
	var_a12b4736 = &namespace_b0722f43::function_96ff7b88;
	var_d2223309 = &namespace_b0722f43::function_261ab7f5;
	var_b5014996 = &namespace_b0722f43::function_19089c75;
	var_87d0eef8 = &namespace_b0722f43::remove_item;
	var_74257310 = &namespace_b0722f43::function_6da5e673;
	var_f8a4c541 = &namespace_b0722f43::function_6991057;
	if(isdefined(getgametypesetting(#"wzhardcore")) && getgametypesetting(#"wzhardcore"))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6f80136c3b79d9e");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_8578856a247ab60");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_568173e016d45c2a");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"armor_shard_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_80292d121740f6f");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1bb3938ead724a68");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1abfcce0e9955057", #"hash_ff50c93155e445f");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1b975e4c6ae8b190", #"hash_5119794c0791738");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_12ebcb30a76f1ba1", #"hash_38314ba3ce4abdf8");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sensor_dart_wz_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_34fc35458ae105ac");
	}
}

