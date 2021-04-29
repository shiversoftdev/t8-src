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

#namespace namespace_5de42f12;

/*
	Name: function_89f2df9
	Namespace: namespace_5de42f12
	Checksum: 0xC1D6999D
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_16d714f38d660912", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5de42f12
	Checksum: 0x290DDBBE
	Offset: 0x130
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_extra_molotov", &function_fd7e329b);
}

/*
	Name: function_fd7e329b
	Namespace: namespace_5de42f12
	Checksum: 0x45ECE9C5
	Offset: 0x168
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_fd7e329b()
{
	callback::on_spawned(&function_94c5165b);
	self.var_ae031eed = 1;
	namespace_2ba51478::register_lethal_grenade_for_level(#"hash_6cb687e3f8c569fd");
}

/*
	Name: function_94c5165b
	Namespace: namespace_5de42f12
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
	if(self.var_49377865[#"lethal_grenade"] === getweapon(#"hash_c78156ba6aeda14"))
	{
		self takeweapon(getweapon(#"hash_c78156ba6aeda14"));
		self giveweapon(getweapon(#"hash_6cb687e3f8c569fd"));
	}
}

