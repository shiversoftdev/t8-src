// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_c4d4ae55;

/*
	Name: function_89f2df9
	Namespace: namespace_c4d4ae55
	Checksum: 0xA42B04D1
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5313bfeaba8f80ee", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_c4d4ae55
	Checksum: 0xC279D859
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_798e4261c9a11b0b", #"hash_7f410b145dce17bd", #"hash_3063198fc139e3b0", &function_d95e620c, #"hash_c5713430b8fb888");
}

/*
	Name: function_d95e620c
	Namespace: namespace_c4d4ae55
	Checksum: 0xC7A79B56
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_7801126f = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_2cd26947d8f311fa")) ? getgametypesetting(#"hash_2cd26947d8f311fa") : 0);
	return var_7801126f;
}

