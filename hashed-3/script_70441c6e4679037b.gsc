// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_7458ae6d;

/*
	Name: function_89f2df9
	Namespace: namespace_7458ae6d
	Checksum: 0x39D5DA05
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_1222ebda4b02b01b", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_7458ae6d
	Checksum: 0xD27F5395
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_4e05591e7665f140", #"hash_1ee2659e8dff07d8", #"hash_512902807bf52e0", &function_d95e620c, #"hash_27023afb3f91aba5");
}

/*
	Name: function_d95e620c
	Namespace: namespace_7458ae6d
	Checksum: 0xA18A57F0
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_4c72e3da = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_6fe34e77ba14d86f")) ? getgametypesetting(#"hash_6fe34e77ba14d86f") : 0);
	return var_4c72e3da;
}

