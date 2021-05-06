// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_b0eb7648;

/*
	Name: function_89f2df9
	Namespace: namespace_b0eb7648
	Checksum: 0xCF102294
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_660d9e9af9d2e4b9", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_b0eb7648
	Checksum: 0xBECF2F89
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_cd592349eeb8a06", #"hash_3f01badbd66b2962", #"hash_2b5695464a83f96d", &function_d95e620c, #"hash_17a4baf5ec553be7", #"hash_17a4bbf5ec553d9a");
}

/*
	Name: function_d95e620c
	Namespace: namespace_b0eb7648
	Checksum: 0xE18164AA
	Offset: 0x148
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_fca3d7af = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_265bdda9362c5a35")) ? getgametypesetting(#"hash_265bdda9362c5a35") : 0);
	return var_fca3d7af;
}

