// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_mod_staminup;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_staminup
	Checksum: 0xF84F1CC4
	Offset: 0x90
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
	Checksum: 0xBD988DB1
	Offset: 0xD8
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
	Checksum: 0x4F306240
	Offset: 0xF8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function enable_mod_staminup_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_staminup", &registermelee_leader_guntookpain, &function_170260ee);
	zm_perks::register_perk_init_thread(#"specialty_mod_staminup", &function_c24062a0);
}

/*
	Name: function_c24062a0
	Namespace: zm_perk_mod_staminup
	Checksum: 0x80F724D1
	Offset: 0x178
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_c24062a0()
{
}

/*
	Name: registermelee_leader_guntookpain
	Namespace: zm_perk_mod_staminup
	Checksum: 0x80F724D1
	Offset: 0x188
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function registermelee_leader_guntookpain()
{
}

/*
	Name: function_170260ee
	Namespace: zm_perk_mod_staminup
	Checksum: 0x80F724D1
	Offset: 0x198
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_170260ee()
{
}

