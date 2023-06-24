// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_mod_death_perception;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_death_perception
	Checksum: 0x98ED9E2B
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_death_perception", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_death_perception
	Checksum: 0xD33AA273
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_bc420db4();
}

/*
	Name: __main__
	Namespace: zm_perk_mod_death_perception
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
	Name: function_bc420db4
	Namespace: zm_perk_mod_death_perception
	Checksum: 0x9987A196
	Offset: 0x110
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_bc420db4()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_awareness", "mod_death_perception", #"perk_death_perception", #"specialty_awareness", 3500);
	zm_perks::register_perk_threads(#"specialty_mod_awareness", &function_422ccf78, &function_f8f0703b);
}

/*
	Name: function_422ccf78
	Namespace: zm_perk_mod_death_perception
	Checksum: 0x80F724D1
	Offset: 0x1B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_422ccf78()
{
}

/*
	Name: function_f8f0703b
	Namespace: zm_perk_mod_death_perception
	Checksum: 0x3E7718AD
	Offset: 0x1C0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_f8f0703b(b_pause, str_perk, str_result, n_slot)
{
}

