// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_mod_widows_wine;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_widows_wine
	Checksum: 0x10084B51
	Offset: 0x90
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
	Checksum: 0x671E82DF
	Offset: 0xD8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_widows_wine_perk_for_level();
}

/*
	Name: enable_widows_wine_perk_for_level
	Namespace: zm_perk_mod_widows_wine
	Checksum: 0x10305236
	Offset: 0xF8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function enable_widows_wine_perk_for_level()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_widowswine", "mod_widows_wine", #"perk_widows_wine", #"specialty_widowswine", 4500);
	zm_perks::register_perk_threads(#"specialty_mod_widowswine", &widows_wine_perk_activate, &widows_wine_perk_lost);
}

/*
	Name: widows_wine_perk_activate
	Namespace: zm_perk_mod_widows_wine
	Checksum: 0x37650E36
	Offset: 0x198
	Size: 0x10
	Parameters: 0
	Flags: Linked
*/
function widows_wine_perk_activate()
{
	self.var_a33a5a37++;
}

/*
	Name: widows_wine_perk_lost
	Namespace: zm_perk_mod_widows_wine
	Checksum: 0x439B4043
	Offset: 0x1B0
	Size: 0x36
	Parameters: 4
	Flags: Linked
*/
function widows_wine_perk_lost(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_4fa1f45a60444ddc");
}

