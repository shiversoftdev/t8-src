// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;

#namespace zm_weap_spork;

/*
	Name: __init__system__
	Namespace: zm_weap_spork
	Checksum: 0x4C38790B
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"spork", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_spork
	Checksum: 0xE567473F
	Offset: 0xD8
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	zm_melee_weapon::init(#"spork_alcatraz", #"spork_alcatraz_flourish", 1000, "spork", undefined, "spork", undefined);
}

/*
	Name: __main__
	Namespace: zm_weap_spork
	Checksum: 0x80F724D1
	Offset: 0x130
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
}

