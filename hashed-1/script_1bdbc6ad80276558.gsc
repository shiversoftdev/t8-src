// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_d7d5935b;

/*
	Name: function_89f2df9
	Namespace: namespace_d7d5935b
	Checksum: 0x3A648F5
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"spoon", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d7d5935b
	Checksum: 0xE31D18F9
	Offset: 0xD8
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	zm_melee_weapon::init(#"hash_52b03a79f854eed3", #"hash_62fb373e0f485710", 1000, "spoon", undefined, "spoon", undefined);
}

/*
	Name: __main__
	Namespace: namespace_d7d5935b
	Checksum: 0x80F724D1
	Offset: 0x130
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
}

