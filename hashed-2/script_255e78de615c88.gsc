// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_a2503d0f;

/*
	Name: function_89f2df9
	Namespace: namespace_a2503d0f
	Checksum: 0xD49C31B6
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_2bd6bd7ba1f2b5d8", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_a2503d0f
	Checksum: 0x82779E21
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_3a3698e1b47c7a79", #"hash_8596bc069593313", #"hash_67a672ee53e0a823", &function_d95e620c, #"hash_48b3b84fe88578f2");
}

/*
	Name: function_d95e620c
	Namespace: namespace_a2503d0f
	Checksum: 0xD2D3506B
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_711ddc0f = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_75370c9c920502fc")) ? getgametypesetting(#"hash_75370c9c920502fc") : 0);
	return var_711ddc0f;
}

