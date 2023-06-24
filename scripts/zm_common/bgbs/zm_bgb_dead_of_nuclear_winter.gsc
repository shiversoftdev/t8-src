// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_dead_of_nuclear_winter;

/*
	Name: __init__system__
	Namespace: zm_bgb_dead_of_nuclear_winter
	Checksum: 0x3717D72C
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_dead_of_nuclear_winter", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_dead_of_nuclear_winter
	Checksum: 0x234E0126
	Offset: 0xE0
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
	bgb::register(#"zm_bgb_dead_of_nuclear_winter", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_dead_of_nuclear_winter
	Checksum: 0xD1B33AFB
	Offset: 0x160
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self thread bgb::function_c6cd71d5("nuke", undefined, 96);
}

/*
	Name: validation
	Namespace: zm_bgb_dead_of_nuclear_winter
	Checksum: 0xB8B055DB
	Offset: 0x190
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	return self bgb::function_9d8118f5();
}

