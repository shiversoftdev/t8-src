// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_eb4608d5;

/*
	Name: function_89f2df9
	Namespace: namespace_eb4608d5
	Checksum: 0x38C6D459
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4ae02ae28a48d88b", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_eb4608d5
	Checksum: 0x420143C
	Offset: 0xD0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_37c0d395();
}

/*
	Name: function_37c0d395
	Namespace: namespace_eb4608d5
	Checksum: 0x688C855B
	Offset: 0xF0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_37c0d395()
{
	zm_perks::function_7f42e14e(#"hash_4c14ed37c4038671", "mod_zombshell", #"hash_6fac30b31b5bec64", #"hash_36b9957a693185ea", 5500);
	zm_perks::register_perk_threads(#"hash_4c14ed37c4038671", &function_58d94d9, &function_bf7ca4a7);
}

/*
	Name: function_58d94d9
	Namespace: namespace_eb4608d5
	Checksum: 0x80F724D1
	Offset: 0x190
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_58d94d9()
{
}

/*
	Name: function_bf7ca4a7
	Namespace: namespace_eb4608d5
	Checksum: 0x7E32B6BE
	Offset: 0x1A0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_bf7ca4a7(b_pause, str_perk, str_result, var_bcd1c2ff)
{
}

