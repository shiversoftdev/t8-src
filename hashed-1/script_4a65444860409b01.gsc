// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_57f7003580bb15e0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_dafacbee;

/*
	Name: function_89f2df9
	Namespace: namespace_dafacbee
	Checksum: 0xB0B7759C
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_221a828ea2610a47", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_dafacbee
	Checksum: 0xF241D5D2
	Offset: 0xD0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	status_effect::function_6f4eaf88(function_4d1e7b48("movement"));
	status_effect::function_5bae5120(8, &function_f7e9c0bb);
}

/*
	Name: function_f7e9c0bb
	Namespace: namespace_dafacbee
	Checksum: 0x80F724D1
	Offset: 0x128
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_f7e9c0bb()
{
}

