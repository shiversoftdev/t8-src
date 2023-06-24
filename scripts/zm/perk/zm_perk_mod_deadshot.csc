// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_mod_deadshot;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x33213F98
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_deadshot", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_deadshot
	Checksum: 0xCD04866A
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_mod_deadshot_perk_for_level();
}

/*
	Name: enable_mod_deadshot_perk_for_level
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x4EBED977
	Offset: 0x100
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function enable_mod_deadshot_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_deadshot", &function_7252aedc, &function_8357e1f3);
	zm_perks::register_perk_init_thread(#"specialty_mod_deadshot", &function_85402de1);
}

/*
	Name: function_85402de1
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_85402de1()
{
}

/*
	Name: function_7252aedc
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x80F724D1
	Offset: 0x190
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_7252aedc()
{
}

/*
	Name: function_8357e1f3
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_8357e1f3()
{
}

