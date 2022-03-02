// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\vehicle_shared.csc;

#namespace wing_drone;

/*
	Name: function_89f2df9
	Namespace: wing_drone
	Checksum: 0x4C82AFD9
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"wing_drone", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wing_drone
	Checksum: 0x2B7C457F
	Offset: 0x118
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!isdefined(level.var_c23a525e))
	{
		level.var_c23a525e = {};
		clientfield::register("vehicle", "wing_drone_reload", 1, 1, "int", &reload, 0, 0);
	}
}

/*
	Name: reload
	Namespace: wing_drone
	Checksum: 0x4386B093
	Offset: 0x188
	Size: 0x8C
	Parameters: 7
	Flags: None
*/
function reload(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_d309e55a("tag_turret_control_animate", 0);
	}
	else
	{
		self function_d309e55a("tag_turret_control_animate", 1);
	}
}

