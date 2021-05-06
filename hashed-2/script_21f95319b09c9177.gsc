// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_1b9f4b0d;

/*
	Name: function_89f2df9
	Namespace: namespace_1b9f4b0d
	Checksum: 0x5A1D3250
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5ff3d0a390e9775f", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_1b9f4b0d
	Checksum: 0xB3929743
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_77a2176db1d8a05c", #"hash_4815f130a1c1d840", #"hash_7ed229d63a11e187", &function_d95e620c, #"hash_21c5510d64c20b71");
}

/*
	Name: function_d95e620c
	Namespace: namespace_1b9f4b0d
	Checksum: 0x2D2F9BCB
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_808a2a47 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_2dfb36064be05f03")) ? getgametypesetting(#"hash_2dfb36064be05f03") : 0);
	return var_808a2a47;
}

