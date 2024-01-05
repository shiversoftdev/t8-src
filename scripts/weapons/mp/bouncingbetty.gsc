// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\bouncingbetty.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace bouncingbetty;

/*
	Name: __init__system__
	Namespace: bouncingbetty
	Checksum: 0x56AB7BCF
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
	Checksum: 0xA674EE01
	Offset: 0xC0
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	level.trackbouncingbettiesonowner = 1;
}

