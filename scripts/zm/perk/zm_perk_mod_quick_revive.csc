// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_mod_quick_revive;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0x9AD5FBAB
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_quick_revive", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0xC930B6EC
	Offset: 0xC8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_quick_revive_perk_for_level();
}

/*
	Name: enable_quick_revive_perk_for_level
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0xD70599E2
	Offset: 0xE8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function enable_quick_revive_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func);
}

/*
	Name: quick_revive_client_field_func
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0x80F724D1
	Offset: 0x138
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function quick_revive_client_field_func()
{
}

/*
	Name: quick_revive_callback_func
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0x80F724D1
	Offset: 0x148
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function quick_revive_callback_func()
{
}

