// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_bgb_licensed_contractor;

/*
	Name: __init__system__
	Namespace: zm_bgb_licensed_contractor
	Checksum: 0x90C12C2C
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_licensed_contractor", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_licensed_contractor
	Checksum: 0xA5ED927E
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
	bgb::register(#"zm_bgb_licensed_contractor", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_licensed_contractor
	Checksum: 0x6AB0CCFD
	Offset: 0x160
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self thread bgb::function_c6cd71d5("carpenter", undefined, 96);
}

/*
	Name: validation
	Namespace: zm_bgb_licensed_contractor
	Checksum: 0x4DC1D2C5
	Offset: 0x190
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	return self bgb::function_9d8118f5();
}

