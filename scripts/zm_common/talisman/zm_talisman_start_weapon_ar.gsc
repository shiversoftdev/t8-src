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

#namespace zm_talisman_start_weapon_ar;

/*
	Name: __init__system__
	Namespace: zm_talisman_start_weapon_ar
	Checksum: 0xF1BAB6AB
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_talisman_start_weapon_ar", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_start_weapon_ar
	Checksum: 0xA799D0C2
	Offset: 0x120
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_custom::function_901b751c(#"zmweaponsar") || !zm_custom::function_901b751c(#"zmstartingweaponenabled"))
	{
		return;
	}
	zm_talisman::register_talisman("talisman_start_weapon_ar", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_start_weapon_ar
	Checksum: 0x83B382C2
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	self.var_8313fee5 = #"ar_modular_t8";
}

