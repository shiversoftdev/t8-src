// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_talisman_start_weapon_lmg;

/*
	Name: function_89f2df9
	Namespace: zm_talisman_start_weapon_lmg
	Checksum: 0x1268DF58
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_talisman_start_weapon_lmg", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_talisman_start_weapon_lmg
	Checksum: 0xEC76A5D3
	Offset: 0x120
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!namespace_59ff1d6c::function_901b751c(#"hash_2f6740b518dbeb8f") || !namespace_59ff1d6c::function_901b751c(#"hash_7bc64c0823c87e41"))
	{
		return;
	}
	zm_talisman::function_88a60d36("talisman_start_weapon_lmg", &activate_talisman);
}

/*
	Name: activate_talisman
	Namespace: zm_talisman_start_weapon_lmg
	Checksum: 0x44F59A42
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function activate_talisman()
{
	self.var_8313fee5 = #"lmg_standard_t8";
}

