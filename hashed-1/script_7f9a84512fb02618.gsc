// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace namespace_6cc2ce5b;

/*
	Name: function_89f2df9
	Namespace: namespace_6cc2ce5b
	Checksum: 0x7ACA2DCF
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4a6b297c85fafec1", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_6cc2ce5b
	Checksum: 0x8AD24E46
	Offset: 0xD0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_4a6b297c85fafec1", "time");
}

