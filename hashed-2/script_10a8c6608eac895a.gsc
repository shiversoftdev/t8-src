// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_3da77d43;

/*
	Name: function_89f2df9
	Namespace: namespace_3da77d43
	Checksum: 0x56DE8127
	Offset: 0x170
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_52dccf7e9237dda5", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3da77d43
	Checksum: 0xCFAA22F1
	Offset: 0x1B8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_9c732a0a();
	level._effect[#"perk_tortoise_explosion"] = "zombie/fx8_perk_vic_tort_exp";
	zm_perks::function_f3c80d73("zombie_perk_bottle_tortoise", "zombie_perk_totem_tortoise");
}

/*
	Name: function_9c732a0a
	Namespace: namespace_3da77d43
	Checksum: 0x55152949
	Offset: 0x220
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_9c732a0a()
{
	zm_perks::register_perk_clientfields(#"specialty_shield", &function_6dd9c0ca, &function_cdbbd4f1);
	zm_perks::register_perk_effects(#"specialty_shield", "divetonuke_light");
	zm_perks::register_perk_init_thread(#"specialty_shield", &function_3cc019d7);
	zm_perks::function_b60f4a9f(#"specialty_shield", #"hash_b018dfba8eb5020", "zombie/fx8_perk_altar_symbol_ambient_victorious_tortoise", #"hash_2dd9d538ca5bc2d6");
}

/*
	Name: function_3cc019d7
	Namespace: namespace_3da77d43
	Checksum: 0x80F724D1
	Offset: 0x310
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_3cc019d7()
{
}

/*
	Name: function_6dd9c0ca
	Namespace: namespace_3da77d43
	Checksum: 0x26F6AE42
	Offset: 0x320
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_6dd9c0ca()
{
	clientfield::register("allplayers", "perk_tortoise_explosion", 1, 1, "counter", &function_f92dce50, 0, 0);
}

/*
	Name: function_cdbbd4f1
	Namespace: namespace_3da77d43
	Checksum: 0x80F724D1
	Offset: 0x378
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_cdbbd4f1()
{
}

/*
	Name: function_f92dce50
	Namespace: namespace_3da77d43
	Checksum: 0xAB3D3794
	Offset: 0x388
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_f92dce50(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"perk_tortoise_explosion"], self, " j_spine");
	}
}

