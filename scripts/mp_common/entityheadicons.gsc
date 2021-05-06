// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\entityheadicons_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace entityheadicons;

/*
	Name: function_89f2df9
	Namespace: entityheadicons
	Checksum: 0x69E76682
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"entityheadicons", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: entityheadicons
	Checksum: 0xAAB32858
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function __init__()
{
	init_shared();
}

