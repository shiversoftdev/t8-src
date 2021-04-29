// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace namespace_522dc10;

/*
	Name: function_89f2df9
	Namespace: namespace_522dc10
	Checksum: 0xD7EF686C
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_40ff20dc353ceb63", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_522dc10
	Checksum: 0xD7B84AFA
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
	bgb::register(#"hash_40ff20dc353ceb63", "time");
}

