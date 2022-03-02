// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_72344d49;

/*
	Name: function_89f2df9
	Namespace: namespace_72344d49
	Checksum: 0x22A5DEA8
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_56d6c8ec5d78c182", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_72344d49
	Checksum: 0xA1C36DF6
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_1b0f5f13a087c3d3", #"hash_23d5f8566508f9f5", #"hash_4da28db320e11353", &function_d95e620c, #"hash_557b228047615fb0");
}

/*
	Name: function_d95e620c
	Namespace: namespace_72344d49
	Checksum: 0xBD02C3C5
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_182a6f93 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_1d4c395693ce04fe")) ? getgametypesetting(#"hash_1d4c395693ce04fe") : 0);
	return var_182a6f93;
}

