// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_talisman_shield_durability_rare;

/*
	Name: __init__system__
	Namespace: zm_talisman_shield_durability_rare
	Checksum: 0x46BE2D37
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_talisman_shield_durability_rare", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_shield_durability_rare
	Checksum: 0x89FDDEA4
	Offset: 0x120
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::register_talisman("talisman_shield_durability_rare", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_shield_durability_rare
	Checksum: 0xACDE260B
	Offset: 0x158
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	self.var_9c2026aa = 0.2;
}

