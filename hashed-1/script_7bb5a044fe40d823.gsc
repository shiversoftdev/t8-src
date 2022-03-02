// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_86484e1;

/*
	Name: function_89f2df9
	Namespace: namespace_86484e1
	Checksum: 0x9924A8D7
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_1c2ed3083ed241b5", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_86484e1
	Checksum: 0x955F63B
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_58ba46469707a85c", #"hash_63b894fa4d634238", #"hash_6d7d534b5d46d8dd", &function_d95e620c, #"hash_4e9ba934add76371");
}

/*
	Name: function_d95e620c
	Namespace: namespace_86484e1
	Checksum: 0xEE032B33
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_e2bea9cf = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_4f0a6d1e98cdbf81")) ? getgametypesetting(#"hash_4f0a6d1e98cdbf81") : 0);
	return var_e2bea9cf;
}

