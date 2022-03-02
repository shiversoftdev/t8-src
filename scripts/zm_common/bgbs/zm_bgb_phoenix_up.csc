// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_bgb.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_bgb_phoenix_up;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_phoenix_up
	Checksum: 0x54F4D990
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_bgb_phoenix_up", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_phoenix_up
	Checksum: 0x7D5D6D0C
	Offset: 0xF8
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
	bgb::register(#"zm_bgb_phoenix_up", "activated");
}

