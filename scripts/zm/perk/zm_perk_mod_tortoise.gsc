// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_mod_tortoise;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_tortoise
	Checksum: 0xFB9322E4
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_tortoise", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_tortoise
	Checksum: 0xC8B6D221
	Offset: 0xD8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_dfb8db6a();
}

/*
	Name: __main__
	Namespace: zm_perk_mod_tortoise
	Checksum: 0x80F724D1
	Offset: 0xF8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_dfb8db6a
	Namespace: zm_perk_mod_tortoise
	Checksum: 0xE0601DE2
	Offset: 0x108
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_dfb8db6a()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_shield", "mod_tortoise", #"perk_tortoise", #"specialty_shield", 3500);
	zm_perks::register_perk_threads(#"specialty_mod_shield", &function_f2b55850, &function_844bdb66);
}

/*
	Name: function_f2b55850
	Namespace: zm_perk_mod_tortoise
	Checksum: 0x80F724D1
	Offset: 0x1A8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_f2b55850()
{
}

/*
	Name: function_844bdb66
	Namespace: zm_perk_mod_tortoise
	Checksum: 0x88998A54
	Offset: 0x1B8
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_844bdb66(b_pause, str_perk, str_result, n_slot)
{
}

