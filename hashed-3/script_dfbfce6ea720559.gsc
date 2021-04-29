// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace lead_drone;

/*
	Name: function_89f2df9
	Namespace: lead_drone
	Checksum: 0xD56918C0
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"lead_drone", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: lead_drone
	Checksum: 0xA3814471
	Offset: 0x108
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("vehicle", "lead_drone_reload", 1, 1, "int", &reload, 0, 0);
}

/*
	Name: reload
	Namespace: lead_drone
	Checksum: 0xBE08BC0D
	Offset: 0x160
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function reload(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_d309e55a("tag_gun_deploy_control_animate", 0);
	}
	else
	{
		self function_d309e55a("tag_gun_deploy_control_animate", 1);
	}
}

