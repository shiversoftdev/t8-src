// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_db6ea6a6;

/*
	Name: function_89f2df9
	Namespace: namespace_db6ea6a6
	Checksum: 0x71583F65
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4b2c77bb3aca2def", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_db6ea6a6
	Checksum: 0x3560A579
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_2fd1efc569af17b8", #"hash_63c7568898cd4fec", #"hash_279757876549356c", &function_d95e620c, #"hash_74fceff1a255277d");
}

/*
	Name: function_d95e620c
	Namespace: namespace_db6ea6a6
	Checksum: 0x11BE2547
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_d0df1180 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_2b0f9caa00363ee8")) ? getgametypesetting(#"hash_2b0f9caa00363ee8") : 0);
	return var_d0df1180;
}

