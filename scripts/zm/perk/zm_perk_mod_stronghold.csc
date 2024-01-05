// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_perks.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_perk_mod_stronghold;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_stronghold
	Checksum: 0xF5840C4C
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_stronghold", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_stronghold
	Checksum: 0x71DA80B7
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_8afdc221();
}

/*
	Name: function_8afdc221
	Namespace: zm_perk_mod_stronghold
	Checksum: 0xEB6C82D8
	Offset: 0xE0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_8afdc221()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_camper", &function_46f52747, &function_d2d66071);
	zm_perks::register_perk_init_thread(#"specialty_mod_camper", &function_e630abb2);
}

/*
	Name: function_e630abb2
	Namespace: zm_perk_mod_stronghold
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_e630abb2()
{
}

/*
	Name: function_46f52747
	Namespace: zm_perk_mod_stronghold
	Checksum: 0x80F724D1
	Offset: 0x170
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_46f52747()
{
}

/*
	Name: function_d2d66071
	Namespace: zm_perk_mod_stronghold
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_d2d66071()
{
}

