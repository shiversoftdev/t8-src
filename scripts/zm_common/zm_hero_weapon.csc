// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_hero_weapon;

/*
	Name: function_89f2df9
	Namespace: zm_hero_weapon
	Checksum: 0x77B3C25D
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_hero_weapons", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_hero_weapon
	Checksum: 0x4CCB3E15
	Offset: 0x170
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("clientuimodel", "zmhud.weaponLevel", 1, 2, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "zmhud.weaponProgression", 1, 5, "float", undefined, 0, 0);
	clientfield::register("clientuimodel", "zmhud.swordEnergy", 1, 7, "float", undefined, 0, 0);
	clientfield::register("clientuimodel", "zmhud.swordState", 1, 4, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "zmhud.swordChargeUpdate", 1, 1, "counter", undefined, 0, 0);
}

