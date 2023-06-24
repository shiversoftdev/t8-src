// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\trophy_system.csc;
#using scripts\core_common\system_shared.csc;

#namespace trophy_system;

/*
	Name: __init__system__
	Namespace: trophy_system
	Checksum: 0xAD028AE
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"trophy_system", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: trophy_system
	Checksum: 0x972A731D
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

