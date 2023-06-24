// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\perks.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_always_done_swiftly;

/*
	Name: __init__system__
	Namespace: zm_bgb_always_done_swiftly
	Checksum: 0x73F498B2
	Offset: 0xB0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_always_done_swiftly", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_always_done_swiftly
	Checksum: 0xC9B150D3
	Offset: 0x100
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_always_done_swiftly", "time", 300, &enable, &disable, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_always_done_swiftly
	Checksum: 0xC48DEECC
	Offset: 0x180
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self perks::perk_setperk("specialty_fastads");
	self perks::perk_setperk("specialty_stalker");
}

/*
	Name: disable
	Namespace: zm_bgb_always_done_swiftly
	Checksum: 0xF7C5BB70
	Offset: 0x1D0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	self perks::perk_unsetperk("specialty_fastads");
	self perks::perk_unsetperk("specialty_stalker");
}

