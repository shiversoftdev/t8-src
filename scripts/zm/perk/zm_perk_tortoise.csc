// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_tortoise;

/*
	Name: __init__system__
	Namespace: zm_perk_tortoise
	Checksum: 0x56DE8127
	Offset: 0x170
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_tortoise", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_tortoise
	Checksum: 0xCFAA22F1
	Offset: 0x1B8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_tortoise_perk_for_level();
	level._effect[#"perk_tortoise_explosion"] = "zombie/fx8_perk_vic_tort_exp";
	zm_perks::function_f3c80d73("zombie_perk_bottle_tortoise", "zombie_perk_totem_tortoise");
}

/*
	Name: enable_tortoise_perk_for_level
	Namespace: zm_perk_tortoise
	Checksum: 0x55152949
	Offset: 0x220
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function enable_tortoise_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_shield", &function_6dd9c0ca, &function_cdbbd4f1);
	zm_perks::register_perk_effects(#"specialty_shield", "divetonuke_light");
	zm_perks::register_perk_init_thread(#"specialty_shield", &function_3cc019d7);
	zm_perks::function_b60f4a9f(#"specialty_shield", #"p8_zm_vapor_altar_icon_01_victorioustortoise", "zombie/fx8_perk_altar_symbol_ambient_victorious_tortoise", #"zmperksvictorious");
}

/*
	Name: function_3cc019d7
	Namespace: zm_perk_tortoise
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
	Namespace: zm_perk_tortoise
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
	Namespace: zm_perk_tortoise
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
	Namespace: zm_perk_tortoise
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

