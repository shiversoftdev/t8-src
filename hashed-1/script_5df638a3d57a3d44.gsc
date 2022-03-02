// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_talisman_extra_self_revive;

/*
	Name: function_89f2df9
	Namespace: zm_talisman_extra_self_revive
	Checksum: 0x423DBC12
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_talisman_extra_self_revive", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_extra_self_revive
	Checksum: 0xB039978C
	Offset: 0x120
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_extra_self_revive", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_extra_self_revive
	Checksum: 0xA4A6CFD
	Offset: 0x158
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	self zm_laststand::function_3a00302e(1);
}

