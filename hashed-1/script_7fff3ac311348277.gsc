// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_equipment.gsc;

#namespace sticky_grenade;

/*
	Name: function_89f2df9
	Namespace: sticky_grenade
	Checksum: 0x467AE17F
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"sticky_grenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: sticky_grenade
	Checksum: 0x9BE6F731
	Offset: 0xE0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm::function_84d343d(#"eq_acid_bomb", &function_140f2522);
	zm::function_84d343d(#"hash_246c869c9de45f07", &function_140f2522);
}

/*
	Name: function_140f2522
	Namespace: sticky_grenade
	Checksum: 0xA3C0004B
	Offset: 0x150
	Size: 0xEA
	Parameters: 12
	Flags: Linked
*/
function function_140f2522(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(meansofdeath === "MOD_IMPACT")
	{
		return 0;
	}
	var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 1, 1);
	var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 40);
	return var_5d7b4163;
}

