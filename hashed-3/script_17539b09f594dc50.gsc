// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace ability_gadgets;

/*
	Name: function_89f2df9
	Namespace: ability_gadgets
	Checksum: 0x1B9B11CC
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"ability_gadgets", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: ability_gadgets
	Checksum: 0xE9B31CE4
	Offset: 0x140
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("clientuimodel", "huditems.abilityHoldToActivate", 1, 2, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "huditems.abilityDelayProgress", 1, 5, "float", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.abilityHintIndex", 1, 3, "int", undefined, 0, 0);
}

