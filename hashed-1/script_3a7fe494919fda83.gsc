// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_6dfddfeb;

/*
	Name: function_89f2df9
	Namespace: namespace_6dfddfeb
	Checksum: 0x9B9A3B22
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_360b09ee0f5cbefb", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_6dfddfeb
	Checksum: 0xCB4C477C
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_3e631def73c3efa8", #"hash_36157750ed7c6584", #"hash_12d0b662134986e2", &function_d95e620c, #"hash_56b5eb94fb75cbed", #"hash_56b5e894fb75c6d4");
}

/*
	Name: function_d95e620c
	Namespace: namespace_6dfddfeb
	Checksum: 0x2E263523
	Offset: 0x148
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_913db062 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_26186b4e5dc9bb6f")) ? getgametypesetting(#"hash_26186b4e5dc9bb6f") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0);
	return var_913db062;
}

