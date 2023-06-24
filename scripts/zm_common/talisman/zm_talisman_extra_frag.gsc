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

#namespace zm_talisman_extra_frag;

/*
	Name: __init__system__
	Namespace: zm_talisman_extra_frag
	Checksum: 0x6C019F92
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_talisman_extra_frag", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_extra_frag
	Checksum: 0x10D63840
	Offset: 0x128
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_extra_frag", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_extra_frag
	Checksum: 0x6C375951
	Offset: 0x160
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	callback::on_spawned(&function_fbcc1e50);
	self.b_talisman_extra_frag = 1;
	zm_loadout::register_lethal_grenade_for_level(#"eq_frag_grenade_extra");
}

/*
	Name: function_fbcc1e50
	Namespace: zm_talisman_extra_frag
	Checksum: 0x37FAF9AE
	Offset: 0x1C0
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_fbcc1e50()
{
	self endon(#"disconnect");
	if(!(isdefined(self.b_talisman_extra_frag) && self.b_talisman_extra_frag))
	{
		return;
	}
	level flagsys::wait_till(#"all_players_spawned");
	if(self.slot_weapons[#"lethal_grenade"] === getweapon(#"eq_frag_grenade"))
	{
		self takeweapon(getweapon(#"eq_frag_grenade"));
		self giveweapon(getweapon(#"eq_frag_grenade_extra"));
		self zm_loadout::set_player_lethal_grenade(getweapon(#"eq_frag_grenade_extra"));
	}
}

