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

#namespace zm_talisman_extra_claymore;

/*
	Name: function_89f2df9
	Namespace: zm_talisman_extra_claymore
	Checksum: 0x96A5728
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_talisman_extra_claymore", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_extra_claymore
	Checksum: 0xD0D2937B
	Offset: 0x130
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_extra_claymore", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_extra_claymore
	Checksum: 0x85E00E8A
	Offset: 0x168
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	callback::on_spawned(&function_4a46cf14);
	self.b_talisman_extra_claymore = 1;
	zm_loadout::register_lethal_grenade_for_level(#"hash_4a5efaceb780ecb0");
}

/*
	Name: function_4a46cf14
	Namespace: zm_talisman_extra_claymore
	Checksum: 0x692598E1
	Offset: 0x1C8
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_4a46cf14()
{
	self endon(#"disconnect");
	if(!(isdefined(self.b_talisman_extra_claymore) && self.b_talisman_extra_claymore))
	{
		return;
	}
	level flagsys::wait_till(#"all_players_spawned");
	if(self.var_49377865[#"lethal_grenade"] === getweapon(#"claymore"))
	{
		self takeweapon(getweapon(#"claymore"));
		self giveweapon(getweapon(#"hash_4a5efaceb780ecb0"));
	}
}

