// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_9d6b1bc5;

/*
	Name: function_89f2df9
	Namespace: namespace_9d6b1bc5
	Checksum: 0x39C20512
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_d23efe71e585b90", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_9d6b1bc5
	Checksum: 0xB375A363
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_518e05d31b55dfe7", #"hash_8bb7d93747987a1", #"hash_3fd471201d49cc19", &function_d95e620c, #"hash_9eef158b72b6ff4", #"hash_9eef458b72b750d");
}

/*
	Name: function_d95e620c
	Namespace: namespace_9d6b1bc5
	Checksum: 0x3B4394C0
	Offset: 0x148
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_a6df6d8d = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_1ec2d38a40e97c55")) ? getgametypesetting(#"hash_1ec2d38a40e97c55") : 0);
	return var_a6df6d8d;
}

