// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_daaf32c2;

/*
	Name: function_89f2df9
	Namespace: namespace_daaf32c2
	Checksum: 0xB3076B51
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_32b19c501f6cd5f9", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_daaf32c2
	Checksum: 0xF6C55278
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_7c61b9fd505b42dc", #"hash_6f105a897d64112", #"hash_6f589f842f2c3d85", &function_d95e620c, #"hash_698918780b4406f1");
}

/*
	Name: function_d95e620c
	Namespace: namespace_daaf32c2
	Checksum: 0xA2B131B9
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_9a07aee8 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_7049c01d7ddf9b35")) ? getgametypesetting(#"hash_7049c01d7ddf9b35") : 0);
	return var_9a07aee8;
}

