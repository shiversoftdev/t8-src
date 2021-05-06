// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_909c5b5b;

/*
	Name: function_89f2df9
	Namespace: namespace_909c5b5b
	Checksum: 0x6570F9FE
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2b729a318b495ddc", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_909c5b5b
	Checksum: 0xBE4BB9B8
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_14743213b896d2e5", #"hash_4b77f84c47802222", #"hash_2c46bb9444d71ab6", &function_d95e620c, #"hash_7eb32c4c67ae13fe");
}

/*
	Name: function_d95e620c
	Namespace: namespace_909c5b5b
	Checksum: 0x9E258DD0
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_1ff787de = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_26843909f5fdef20")) ? getgametypesetting(#"hash_26843909f5fdef20") : 0);
	return var_1ff787de;
}

