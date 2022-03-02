// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_danger_closest;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_danger_closest
	Checksum: 0xF5C21C7D
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_bgb_danger_closest", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_danger_closest
	Checksum: 0xDC8896BF
	Offset: 0xD0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_danger_closest", "time", 300, undefined, undefined, undefined);
}

