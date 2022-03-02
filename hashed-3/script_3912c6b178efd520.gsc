// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
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
	Name: function_89f2df9
	Namespace: zm_talisman_extra_frag
	Checksum: 0x6C019F92
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
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
	zm_loadout::register_lethal_grenade_for_level(#"hash_244eb1a096b12734");
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
	if(self.var_49377865[#"lethal_grenade"] === getweapon(#"hash_34b7eb9fde56bd35"))
	{
		self takeweapon(getweapon(#"hash_34b7eb9fde56bd35"));
		self giveweapon(getweapon(#"hash_244eb1a096b12734"));
		self zm_loadout::set_player_lethal_grenade(getweapon(#"hash_244eb1a096b12734"));
	}
}

