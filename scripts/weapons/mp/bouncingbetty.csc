// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\bouncingbetty.csc;
#using scripts\core_common\system_shared.csc;

#namespace bouncingbetty;

/*
	Name: __init__system__
	Namespace: bouncingbetty
	Checksum: 0x282CE923
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"bouncingbetty", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: bouncingbetty
	Checksum: 0xB065D309
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

