// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace namespace_52d1ce59;

/*
	Name: function_89f2df9
	Namespace: namespace_52d1ce59
	Checksum: 0xA9753B38
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_560ca45c0a2daef2", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_52d1ce59
	Checksum: 0x4C1266DE
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
	bgb::register(#"hash_560ca45c0a2daef2", "time");
}

