// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_talisman_perk_permanent_2;

/*
	Name: __init__system__
	Namespace: zm_talisman_perk_permanent_2
	Checksum: 0xB8371BE
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_talisman_perk_permanent_2", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_perk_permanent_2
	Checksum: 0xDA7CD0AA
	Offset: 0x118
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_perk_permanent_2", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_perk_permanent_2
	Checksum: 0xBADA2D35
	Offset: 0x150
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	self.talisman_perk_permanent = 2;
}

