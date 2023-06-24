// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_weap_golden_knife;

/*
	Name: __init__system__
	Namespace: zm_weap_golden_knife
	Checksum: 0x322F13D6
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"golden_knife", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_golden_knife
	Checksum: 0x3D8A8586
	Offset: 0xE0
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	zm_melee_weapon::init(#"golden_knife", #"golden_knife_flourish", 1000, "golden_knife", undefined, undefined, undefined);
}

/*
	Name: __main__
	Namespace: zm_weap_golden_knife
	Checksum: 0x80F724D1
	Offset: 0x130
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
}

