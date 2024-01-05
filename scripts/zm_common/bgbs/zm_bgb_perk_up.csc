// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_bgb.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_bgb_perk_up;

/*
	Name: __init__system__
	Namespace: zm_bgb_perk_up
	Checksum: 0xB7B9D606
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_perk_up", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_perk_up
	Checksum: 0x3E2FCB29
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
	bgb::register(#"zm_bgb_perk_up", "activated");
}

