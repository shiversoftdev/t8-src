// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace namespace_b13f32ef;

/*
	Name: __init__system__
	Namespace: namespace_b13f32ef
	Checksum: 0x58B3EAE8
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_67501a71e89fb822", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b13f32ef
	Checksum: 0x56D9D7BD
	Offset: 0xF8
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_96059a93 = getweapon(#"zhield_zpear_dw");
	level.var_85ed93f4 = getweapon(#"hash_136814846f94f0cd");
	level.var_ce3aa8a8 = getweapon(#"zhield_zpear_turret");
}

/*
	Name: __main__
	Namespace: namespace_b13f32ef
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

