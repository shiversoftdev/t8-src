// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_f0228018;

/*
	Name: function_89f2df9
	Namespace: namespace_f0228018
	Checksum: 0xD2F8F29B
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_3ae75105991ff4c1", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_f0228018
	Checksum: 0xCAE09206
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_708b8753a922b9a8", #"hash_75365263415c16f2", #"hash_2bf04f3a8191f11a", &function_d95e620c, #"hash_374df23cda9c79ed");
}

/*
	Name: function_d95e620c
	Namespace: namespace_f0228018
	Checksum: 0x22D6A816
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_fb6c1efd = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_ff653cbb1438270")) ? getgametypesetting(#"hash_ff653cbb1438270") : 0);
	return var_fb6c1efd;
}

