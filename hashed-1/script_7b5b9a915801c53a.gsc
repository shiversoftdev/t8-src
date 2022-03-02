// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_a932c764;

/*
	Name: function_89f2df9
	Namespace: namespace_a932c764
	Checksum: 0x322F13D6
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"golden_knife", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a932c764
	Checksum: 0x3D8A8586
	Offset: 0xE0
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	zm_melee_weapon::init(#"golden_knife", #"hash_723c17d990ece50f", 1000, "golden_knife", undefined, undefined, undefined);
}

/*
	Name: __main__
	Namespace: namespace_a932c764
	Checksum: 0x80F724D1
	Offset: 0x130
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
}

