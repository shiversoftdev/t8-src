// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_talisman_extra_semtex;

/*
	Name: __init__system__
	Namespace: zm_talisman_extra_semtex
	Checksum: 0x147E9258
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_talisman_extra_semtex", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_extra_semtex
	Checksum: 0x8E67164F
	Offset: 0x128
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::register_talisman("talisman_extra_semtex", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_extra_semtex
	Checksum: 0x824682FF
	Offset: 0x160
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	callback::on_spawned(&function_4d97e9ce);
	self.b_talisman_extra_semtex = 1;
	zm_loadout::register_lethal_grenade_for_level(#"eq_acid_bomb_extra");
}

/*
	Name: function_4d97e9ce
	Namespace: zm_talisman_extra_semtex
	Checksum: 0xB659DEFC
	Offset: 0x1C0
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_4d97e9ce()
{
	self endon(#"disconnect");
	if(!(isdefined(self.b_talisman_extra_semtex) && self.b_talisman_extra_semtex))
	{
		return;
	}
	level flagsys::wait_till(#"all_players_spawned");
	if(self.slot_weapons[#"lethal_grenade"] === getweapon(#"eq_acid_bomb"))
	{
		self takeweapon(getweapon(#"eq_acid_bomb"));
		self giveweapon(getweapon(#"eq_acid_bomb_extra"));
	}
}

