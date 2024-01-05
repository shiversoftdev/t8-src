// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_perks.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace zm_perk_mod_ethereal_razor;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_ethereal_razor
	Checksum: 0x295E85D9
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_ethereal_razor", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_ethereal_razor
	Checksum: 0x45EBEA44
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_ethereal_razor_perk_for_level();
}

/*
	Name: enable_ethereal_razor_perk_for_level
	Namespace: zm_perk_mod_ethereal_razor
	Checksum: 0xE62DEBF6
	Offset: 0x100
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function enable_ethereal_razor_perk_for_level()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_etherealrazor", "mod_ethereal_razor", #"perk_ethereal_razor", #"specialty_etherealrazor", 5500);
	zm_perks::register_perk_threads(#"specialty_mod_etherealrazor", &function_5b26f1e3, &function_98c3f271);
}

/*
	Name: function_5b26f1e3
	Namespace: zm_perk_mod_ethereal_razor
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_5b26f1e3()
{
}

/*
	Name: function_98c3f271
	Namespace: zm_perk_mod_ethereal_razor
	Checksum: 0x71902700
	Offset: 0x1B0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_98c3f271(b_pause, str_perk, str_result, n_slot)
{
}

