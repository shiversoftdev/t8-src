// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\serverfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_2cce9002;

/*
	Name: function_89f2df9
	Namespace: namespace_2cce9002
	Checksum: 0x4CFFC69F
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_53e2d15cdf3290ad", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2cce9002
	Checksum: 0x34AAAC84
	Offset: 0xE8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	serverfield::register("status_effect_suppress_field", 1, 5, "int");
}

