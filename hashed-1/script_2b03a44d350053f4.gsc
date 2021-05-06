// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_13c073f7;

/*
	Name: function_89f2df9
	Namespace: namespace_13c073f7
	Checksum: 0x86921238
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_e08ecdac50a87f4", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_13c073f7
	Checksum: 0x8769B6F7
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_4bb047708704a065", #"hash_1d718be46a94371f", #"hash_5a5f9a4b9aede3f4", &function_d95e620c, #"hash_6a5c9e02cc60e87e");
}

/*
	Name: function_d95e620c
	Namespace: namespace_13c073f7
	Checksum: 0xB732F2DB
	Offset: 0x138
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_bca69f36 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_2574d482086ec9d8")) ? getgametypesetting(#"hash_2574d482086ec9d8") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0);
	return var_bca69f36;
}

