// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\wz_common\wz_common_fixup.csc;

#namespace namespace_e375ee62;

/*
	Name: __init__
	Namespace: namespace_e375ee62
	Checksum: 0xDB8ABD8D
	Offset: 0x78
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	function_22c36a1e();
}

/*
	Name: function_22c36a1e
	Namespace: namespace_e375ee62
	Checksum: 0x830E9EEE
	Offset: 0x98
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_22c36a1e()
{
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
}

