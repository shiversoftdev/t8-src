// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_mod_staminup;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_staminup
	Checksum: 0xDE7128AB
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_staminup", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_staminup
	Checksum: 0x75B64FF3
	Offset: 0xD0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_mod_staminup_perk_for_level();
}

/*
	Name: enable_mod_staminup_perk_for_level
	Namespace: zm_perk_mod_staminup
	Checksum: 0x77B03C2F
	Offset: 0xF0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function enable_mod_staminup_perk_for_level()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_staminup", "mod_marathon", #"perk_staminup", #"specialty_staminup", 2500);
	zm_perks::function_2ae97a14(#"specialty_mod_staminup", array(#"specialty_unlimitedsprint", #"specialty_sprintfire"));
}

