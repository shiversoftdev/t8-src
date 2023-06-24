// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_powerups.gsc;

#namespace frag_grenade;

/*
	Name: __init__system__
	Namespace: frag_grenade
	Checksum: 0xE4AB97A5
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"frag_grenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: frag_grenade
	Checksum: 0xC8C5DFDA
	Offset: 0xF8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm::function_84d343d(#"eq_frag_grenade", &function_719b774a);
	zm::function_84d343d(#"eq_frag_grenade_extra", &function_719b774a);
}

/*
	Name: function_719b774a
	Namespace: frag_grenade
	Checksum: 0xFC89659C
	Offset: 0x168
	Size: 0xEA
	Parameters: 12
	Flags: Linked
*/
function function_719b774a(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(meansofdeath === "MOD_IMPACT")
	{
		return 0;
	}
	var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 1, 1);
	var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 40);
	return var_5d7b4163;
}

