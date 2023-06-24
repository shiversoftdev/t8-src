// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\smokegrenade.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace smokegrenade;

/*
	Name: __init__system__
	Namespace: smokegrenade
	Checksum: 0x7441476
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"smokegrenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: smokegrenade
	Checksum: 0xE0B3FF8A
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

