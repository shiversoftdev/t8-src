// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_mod_dying_wish;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0xB7692BC2
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_dying_wish", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0xD228E987
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_7186a3aa();
}

/*
	Name: function_7186a3aa
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0x17119C81
	Offset: 0xE0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_7186a3aa()
{
	zm_perks::register_perk_clientfields(#"hash_48255a3b086a9bea", &function_974d4ee2, &function_992358e3);
	zm_perks::register_perk_init_thread(#"hash_48255a3b086a9bea", &function_4e184775);
}

/*
	Name: function_4e184775
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_4e184775()
{
}

/*
	Name: function_974d4ee2
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0x80F724D1
	Offset: 0x170
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_974d4ee2()
{
}

/*
	Name: function_992358e3
	Namespace: zm_perk_mod_dying_wish
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_992358e3()
{
}

