// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_909c5b5b;

/*
	Name: function_89f2df9
	Namespace: namespace_909c5b5b
	Checksum: 0x1CDA3C4
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_2b729a318b495ddc", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_909c5b5b
	Checksum: 0x2E4E9DD2
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
	Checksum: 0xF8DDC001
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

