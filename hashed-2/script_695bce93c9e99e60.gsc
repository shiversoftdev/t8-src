// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_7db26be178c873e2;
#using scripts\core_common\system_shared.csc;

#namespace smokegrenade;

/*
	Name: function_89f2df9
	Namespace: smokegrenade
	Checksum: 0x30719B64
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"smokegrenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: smokegrenade
	Checksum: 0x3FE4F5EF
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

