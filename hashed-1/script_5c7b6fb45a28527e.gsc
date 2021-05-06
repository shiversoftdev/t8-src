// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_73e11da2;

/*
	Name: function_89f2df9
	Namespace: namespace_73e11da2
	Checksum: 0x7F84C6F1
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_bff403c2cb59a3a", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_73e11da2
	Checksum: 0xE06F66F8
	Offset: 0xD0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_de683235345aa4b", #"hash_4f0c567012b33fd9", #"hash_3a19a30df0f60aa6", &function_d95e620c, #"hash_5495584ec5e9f348");
}

/*
	Name: function_d95e620c
	Namespace: namespace_73e11da2
	Checksum: 0xCAB99194
	Offset: 0x140
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_8d597b54 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_5ea56d63c68b4396")) ? getgametypesetting(#"hash_5ea56d63c68b4396") : 0);
	return var_8d597b54;
}

