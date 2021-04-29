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

#namespace namespace_a1429964;

/*
	Name: function_89f2df9
	Namespace: namespace_a1429964
	Checksum: 0x147E9258
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_43a940623c30cb8", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a1429964
	Checksum: 0x8E67164F
	Offset: 0x128
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_extra_semtex", &function_fd7e329b);
}

/*
	Name: function_fd7e329b
	Namespace: namespace_a1429964
	Checksum: 0x824682FF
	Offset: 0x160
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_fd7e329b()
{
	callback::on_spawned(&function_4d97e9ce);
	self.var_95097a63 = 1;
	namespace_2ba51478::register_lethal_grenade_for_level(#"hash_246c869c9de45f07");
}

/*
	Name: function_4d97e9ce
	Namespace: namespace_a1429964
	Checksum: 0xB659DEFC
	Offset: 0x1C0
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_4d97e9ce()
{
	self endon(#"disconnect");
	if(!(isdefined(self.var_95097a63) && self.var_95097a63))
	{
		return;
	}
	level flagsys::wait_till(#"all_players_spawned");
	if(self.var_49377865[#"lethal_grenade"] === getweapon(#"eq_acid_bomb"))
	{
		self takeweapon(getweapon(#"eq_acid_bomb"));
		self giveweapon(getweapon(#"hash_246c869c9de45f07"));
	}
}

