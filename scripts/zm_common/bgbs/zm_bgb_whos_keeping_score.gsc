// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_bgb_whos_keeping_score;

/*
	Name: __init__system__
	Namespace: zm_bgb_whos_keeping_score
	Checksum: 0xF6C9B66
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_whos_keeping_score", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_whos_keeping_score
	Checksum: 0x5AE20387
	Offset: 0xE8
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
	bgb::register(#"zm_bgb_whos_keeping_score", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_whos_keeping_score
	Checksum: 0x4A1B88E5
	Offset: 0x168
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self thread bgb::function_c6cd71d5("double_points", undefined, 96);
}

/*
	Name: validation
	Namespace: zm_bgb_whos_keeping_score
	Checksum: 0x5C0DAA89
	Offset: 0x198
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	return self bgb::function_9d8118f5();
}

