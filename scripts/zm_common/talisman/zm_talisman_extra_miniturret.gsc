// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_talisman_extra_miniturret;

/*
	Name: __init__system__
	Namespace: zm_talisman_extra_miniturret
	Checksum: 0x426260BB
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_talisman_extra_miniturret", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_extra_miniturret
	Checksum: 0x6BA77BE2
	Offset: 0x128
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::register_talisman("talisman_extra_miniturret", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_extra_miniturret
	Checksum: 0xAB73ABA4
	Offset: 0x160
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	self.b_talisman_extra_miniturret = 1;
}

