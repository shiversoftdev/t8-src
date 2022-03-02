// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1ca35695cd4aeeea;
#using scripts\core_common\system_shared.csc;

#namespace weapons;

/*
	Name: function_89f2df9
	Namespace: weapons
	Checksum: 0x1E138A19
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"weapons", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: weapons
	Checksum: 0x3DC2904E
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

