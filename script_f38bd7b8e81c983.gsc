// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\deployable.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\struct.csc;

#namespace ultimate_turret;

/*
	Name: __init__system__
	Namespace: ultimate_turret
	Checksum: 0xD2B57A0E
	Offset: 0xA8
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register("ultimate_turret_wz", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: ultimate_turret
	Checksum: 0x6129786A
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	deployable::register_deployable(getweapon("ultimate_turret"), 1);
}

