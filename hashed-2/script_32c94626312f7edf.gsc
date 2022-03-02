// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_301c52c;

/*
	Name: function_89f2df9
	Namespace: namespace_301c52c
	Checksum: 0x9E36D276
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_1906a0df69010a5", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_301c52c
	Checksum: 0xE61A76F8
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_36698e3567c4b204", #"hash_77118b5dbb73e0b6", #"hash_76e7c2dc8672414f", &function_d95e620c, #"hash_4bc3134998048aa7");
}

/*
	Name: function_d95e620c
	Namespace: namespace_301c52c
	Checksum: 0xB40D7B53
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_e9462a7e = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_1d50c09e8021ab1")) ? getgametypesetting(#"hash_1d50c09e8021ab1") : 0);
	return var_e9462a7e;
}

