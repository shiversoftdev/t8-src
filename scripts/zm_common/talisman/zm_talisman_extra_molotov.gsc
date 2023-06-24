// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_talisman_extra_molotov;

/*
	Name: __init__system__
	Namespace: zm_talisman_extra_molotov
	Checksum: 0xC1D6999D
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_talisman_extra_molotov", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_extra_molotov
	Checksum: 0x290DDBBE
	Offset: 0x130
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_extra_molotov", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_extra_molotov
	Checksum: 0x45ECE9C5
	Offset: 0x168
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	callback::on_spawned(&function_94c5165b);
	self.var_ae031eed = 1;
	zm_loadout::register_lethal_grenade_for_level(#"eq_wraith_fire_extra");
}

/*
	Name: function_94c5165b
	Namespace: zm_talisman_extra_molotov
	Checksum: 0xE64F36DF
	Offset: 0x1C8
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_94c5165b()
{
	self endon(#"disconnect");
	if(!(isdefined(self.var_ae031eed) && self.var_ae031eed))
	{
		return;
	}
	level flagsys::wait_till(#"all_players_spawned");
	if(self.slot_weapons[#"lethal_grenade"] === getweapon(#"eq_wraith_fire"))
	{
		self takeweapon(getweapon(#"eq_wraith_fire"));
		self giveweapon(getweapon(#"eq_wraith_fire_extra"));
	}
}

