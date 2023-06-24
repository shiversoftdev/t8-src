// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_mod_tortoise;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_tortoise
	Checksum: 0xFCF1E8D5
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_tortoise", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_tortoise
	Checksum: 0xA0773B11
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_dfb8db6a();
}

/*
	Name: function_dfb8db6a
	Namespace: zm_perk_mod_tortoise
	Checksum: 0xDCD94B0D
	Offset: 0xE0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_dfb8db6a()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_shield", &function_7e8d1b34, &function_de73ba5c);
	zm_perks::register_perk_init_thread(#"specialty_mod_shield", &function_cdedb133);
}

/*
	Name: function_cdedb133
	Namespace: zm_perk_mod_tortoise
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_cdedb133()
{
}

/*
	Name: function_7e8d1b34
	Namespace: zm_perk_mod_tortoise
	Checksum: 0x80F724D1
	Offset: 0x170
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_7e8d1b34()
{
}

/*
	Name: function_de73ba5c
	Namespace: zm_perk_mod_tortoise
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_de73ba5c()
{
}

