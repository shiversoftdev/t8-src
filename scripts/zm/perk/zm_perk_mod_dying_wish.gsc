// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_mod_dying_wish;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0xA75B5C5F
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_dying_wish", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0x31905E07
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_7186a3aa();
}

/*
	Name: __main__
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0x80F724D1
	Offset: 0x100
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_7186a3aa
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0x9D0D1C45
	Offset: 0x110
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_7186a3aa()
{
	zm_perks::register_perk_mod_basic_info(#"hash_48255a3b086a9bea", "mod_dying_wish", #"perk_dying_wish", #"specialty_berserker", 5000);
	zm_perks::register_perk_threads(#"hash_48255a3b086a9bea", &function_fb91d1a, &function_63f21c1e);
}

/*
	Name: function_fb91d1a
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0x80F724D1
	Offset: 0x1B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_fb91d1a()
{
}

/*
	Name: function_63f21c1e
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0x7DE5DA40
	Offset: 0x1C0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_63f21c1e(b_pause, str_perk, str_result, n_slot)
{
}

