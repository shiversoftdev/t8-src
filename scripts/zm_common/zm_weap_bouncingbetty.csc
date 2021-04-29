// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_70aa5f5f0b09ad1a;
#using scripts\core_common\system_shared.csc;

#namespace bouncingbetty;

/*
	Name: function_89f2df9
	Namespace: bouncingbetty
	Checksum: 0x3FACD997
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"bouncingbetty", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: bouncingbetty
	Checksum: 0xFDCE78CC
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function __init__()
{
	init_shared();
}

