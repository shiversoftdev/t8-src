// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_d8dd0d46;

/*
	Name: function_89f2df9
	Namespace: namespace_d8dd0d46
	Checksum: 0x4C38790B
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"spork", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d8dd0d46
	Checksum: 0xE567473F
	Offset: 0xD8
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	zm_melee_weapon::init(#"hash_32a584f5a65c70d1", #"hash_7ad424f2b3d0ebb6", 1000, "spork", undefined, "spork", undefined);
}

/*
	Name: __main__
	Namespace: namespace_d8dd0d46
	Checksum: 0x80F724D1
	Offset: 0x130
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
}

