// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_bgb.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_c9fc4f3f;

/*
	Name: function_89f2df9
	Namespace: namespace_c9fc4f3f
	Checksum: 0xDFD3900D
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_1455490b99d4cbbb", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_c9fc4f3f
	Checksum: 0x2CB98A72
	Offset: 0xF0
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
	bgb::register(#"hash_1455490b99d4cbbb", "time");
}

