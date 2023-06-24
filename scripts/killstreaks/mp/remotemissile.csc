// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\remotemissile_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace remotemissile;

/*
	Name: __init__system__
	Namespace: remotemissile
	Checksum: 0xFA23F5C8
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"remotemissile", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: remotemissile
	Checksum: 0x656B5EB6
	Offset: 0xC8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

