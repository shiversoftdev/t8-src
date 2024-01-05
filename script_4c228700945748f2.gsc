// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\wz_common\wz_common_fixup.csc;

#namespace namespace_69456f97;

/*
	Name: __init__
	Namespace: namespace_69456f97
	Checksum: 0x31FDB813
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
	Checksum: 0x8B58816D
	Offset: 0x98
	Size: 0x2CC
	Parameters: 0
	Flags: Linked
*/
function function_acd44e5f()
{
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
	if(isdefined(getgametypesetting(#"wzhardcore")) && getgametypesetting(#"wzhardcore"))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_small");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_medium");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_large");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"armor_shard_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"health_item_large");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1bb3938ead724a68");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"health_item_small", #"health_item_medium");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"hash_1b975e4c6ae8b190", #"hash_5119794c0791738");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"health_list_low", #"health_list_low_hardcore");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sensor_dart_wz_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_34fc35458ae105ac");
	}
}

