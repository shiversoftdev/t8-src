// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5745eb63feb5355b;
#using scripts\core_common\system_shared.csc;

#namespace lightninggun;

/*
	Name: function_89f2df9
	Namespace: lightninggun
	Checksum: 0xBC751C4E
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"lightninggun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: lightninggun
	Checksum: 0x395329CA
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

