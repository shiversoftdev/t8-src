// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_5f8400fc;

/*
	Name: function_89f2df9
	Namespace: namespace_5f8400fc
	Checksum: 0x69514CBA
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_5d85cd0cfa653f3b", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_5f8400fc
	Checksum: 0xDF61FBC4
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_4c8083bdba5bbd92", #"hash_1dc888eecacf65d4", #"hash_447ad6b75cf77f8b", &function_d95e620c, #"hash_28966e441535b733");
}

/*
	Name: function_d95e620c
	Namespace: namespace_5f8400fc
	Checksum: 0x58EC00E3
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_f8bc8610 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_52d705a46da9e55f")) ? getgametypesetting(#"hash_52d705a46da9e55f") : 0);
	return var_f8bc8610;
}

