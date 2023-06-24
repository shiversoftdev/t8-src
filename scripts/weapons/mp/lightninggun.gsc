// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\lightninggun.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace lightninggun;

/*
	Name: __init__system__
	Namespace: lightninggun
	Checksum: 0x68E91CB7
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"lightninggun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: lightninggun
	Checksum: 0x3482A284
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

