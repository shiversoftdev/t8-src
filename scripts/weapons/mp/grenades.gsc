// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\grenades.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace grenades;

/*
	Name: __init__system__
	Namespace: grenades
	Checksum: 0x505E9914
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"grenades", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: grenades
	Checksum: 0x9037DB12
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function __init__()
{
	init_shared();
}

