// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4ca6f7cb266af7fe;
#using scripts\core_common\system_shared.csc;

#namespace hacker_tool;

/*
	Name: function_89f2df9
	Namespace: hacker_tool
	Checksum: 0x30582281
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hacker_tool", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: hacker_tool
	Checksum: 0x249720EA
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

