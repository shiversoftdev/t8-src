// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace namespace_626b0a08;

/*
	Name: function_89f2df9
	Namespace: namespace_626b0a08
	Checksum: 0x840AC8BD
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_177ea318753f5418", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_626b0a08
	Checksum: 0x688EBB6F
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
	bgb::register(#"hash_177ea318753f5418", "activated");
}

