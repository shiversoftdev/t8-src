// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_perks.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_perk_mod_cooldown;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_cooldown
	Checksum: 0x35974477
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_cooldown", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_cooldown
	Checksum: 0xBE4739E9
	Offset: 0xD8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_7299c39e();
}

/*
	Name: __main__
	Namespace: zm_perk_mod_cooldown
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
	Name: function_7299c39e
	Namespace: zm_perk_mod_cooldown
	Checksum: 0xE37BDD93
	Offset: 0x108
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_7299c39e()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_cooldown", "mod_cooldown", #"perk_cooldown", #"specialty_cooldown", 3500);
	zm_perks::register_perk_threads(#"specialty_mod_cooldown", &function_8d51d9a8, &function_754453a);
}

/*
	Name: function_8d51d9a8
	Namespace: zm_perk_mod_cooldown
	Checksum: 0x80F724D1
	Offset: 0x1A8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_8d51d9a8()
{
}

/*
	Name: function_754453a
	Namespace: zm_perk_mod_cooldown
	Checksum: 0x868DB04E
	Offset: 0x1B8
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_754453a(b_pause, str_perk, str_result, n_slot)
{
}

