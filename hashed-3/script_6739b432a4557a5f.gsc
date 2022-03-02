// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_50ee4366;

/*
	Name: function_89f2df9
	Namespace: namespace_50ee4366
	Checksum: 0xDA4790F4
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_39ff5cb883fb68c9", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_50ee4366
	Checksum: 0x2A6960D6
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_4cfd2023adf3da70", #"hash_303d7717027a0f92", #"hash_71890d1ecc35f71e", &function_d95e620c, #"hash_178b421c5b67b4d5");
}

/*
	Name: function_d95e620c
	Namespace: namespace_50ee4366
	Checksum: 0x9DB4B94A
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_a703ffba = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_19c58d35b2ea8d15")) ? getgametypesetting(#"hash_19c58d35b2ea8d15") : 0);
	return var_a703ffba;
}

