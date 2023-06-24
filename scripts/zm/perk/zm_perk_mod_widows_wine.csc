// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_mod_widows_wine;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_widows_wine
	Checksum: 0x8164EC46
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_widows_wine", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_widows_wine
	Checksum: 0x20EF3EC7
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_widowswine", &function_905840b3, &function_a3102f04);
	zm_perks::register_perk_init_thread(#"specialty_mod_widowswine", &function_eb36b57e);
}

/*
	Name: function_eb36b57e
	Namespace: zm_perk_mod_widows_wine
	Checksum: 0x80F724D1
	Offset: 0x148
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_eb36b57e()
{
}

/*
	Name: function_905840b3
	Namespace: zm_perk_mod_widows_wine
	Checksum: 0x80F724D1
	Offset: 0x158
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_905840b3()
{
}

/*
	Name: function_a3102f04
	Namespace: zm_perk_mod_widows_wine
	Checksum: 0x80F724D1
	Offset: 0x168
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_a3102f04()
{
}

