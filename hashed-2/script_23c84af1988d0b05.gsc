// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_717dae5fdb2f4ef;
#using scripts\core_common\system_shared.csc;

#namespace shockrifle;

/*
	Name: function_89f2df9
	Namespace: shockrifle
	Checksum: 0x5188B1AB
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"shockrifle", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: shockrifle
	Checksum: 0x7BEF3C44
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

