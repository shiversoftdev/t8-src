// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace namespace_86e99a0d;

/*
	Name: function_89f2df9
	Namespace: namespace_86e99a0d
	Checksum: 0x2FC23092
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_56d3df5058c56523", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_86e99a0d
	Checksum: 0x6536C801
	Offset: 0xD8
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
	bgb::register(#"hash_56d3df5058c56523", "activated");
}

