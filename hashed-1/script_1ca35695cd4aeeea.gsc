// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;

#namespace weapons;

/*
	Name: init_shared
	Namespace: weapons
	Checksum: 0xC65C21
	Offset: 0xA8
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level.weaponnone = getweapon(#"none");
	clientfield::register("clientuimodel", "hudItems.pickupHintWeaponIndex", 1, 10, "int", undefined, 0, 0);
}

