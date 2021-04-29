// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_480b4ef11b7c73ec;
#using scripts\core_common\system_shared.csc;

#namespace namespace_81cf3c7f;

/*
	Name: function_89f2df9
	Namespace: namespace_81cf3c7f
	Checksum: 0xFFD81B72
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2ce2e438ecd6b2d2", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_81cf3c7f
	Checksum: 0xE53EE743
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

