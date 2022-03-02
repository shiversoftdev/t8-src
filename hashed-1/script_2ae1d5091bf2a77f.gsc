// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_d25f3c2a;

/*
	Name: function_89f2df9
	Namespace: namespace_d25f3c2a
	Checksum: 0x10084B51
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_7bb29f081ab9b5cc", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d25f3c2a
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
	Namespace: namespace_d25f3c2a
	Checksum: 0x10305236
	Offset: 0xF8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function enable_widows_wine_perk_for_level()
{
	zm_perks::function_7f42e14e(#"hash_14e2498426fadea3", "mod_widows_wine", #"perk_widows_wine", #"specialty_widowswine", 4500);
	zm_perks::register_perk_threads(#"hash_14e2498426fadea3", &widows_wine_perk_activate, &widows_wine_perk_lost);
}

/*
	Name: widows_wine_perk_activate
	Namespace: namespace_d25f3c2a
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
	Namespace: namespace_d25f3c2a
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

