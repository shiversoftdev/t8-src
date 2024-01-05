// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_talisman_perk_start_4;

/*
	Name: __init__system__
	Namespace: zm_talisman_perk_start_4
	Checksum: 0xF0444153
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_talisman_perk_start_4", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_perk_start_4
	Checksum: 0x3C2305D0
	Offset: 0x118
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::register_talisman("talisman_perk_start_4", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_perk_start_4
	Checksum: 0xCD6BF75E
	Offset: 0x150
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	if(isdefined(self.var_c27f1e90) && zm_custom::function_d9f0defb(self.var_c27f1e90[3]))
	{
		self.talisman_perk_start_4 = 1;
	}
}

