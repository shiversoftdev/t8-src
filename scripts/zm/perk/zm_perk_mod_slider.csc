// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_perks.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_perk_mod_slider;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_slider
	Checksum: 0xA5B41A2B
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_slider", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_slider
	Checksum: 0x1A06840F
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_bf3cfde4();
}

/*
	Name: function_bf3cfde4
	Namespace: zm_perk_mod_slider
	Checksum: 0x8DBA9A8E
	Offset: 0xE0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_bf3cfde4()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_phdflopper", &function_59383c4e, &function_613ff0da);
	zm_perks::register_perk_init_thread(#"specialty_mod_phdflopper", &function_58cb6bff);
}

/*
	Name: function_58cb6bff
	Namespace: zm_perk_mod_slider
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_58cb6bff()
{
}

/*
	Name: function_59383c4e
	Namespace: zm_perk_mod_slider
	Checksum: 0x80F724D1
	Offset: 0x170
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_59383c4e()
{
}

/*
	Name: function_613ff0da
	Namespace: zm_perk_mod_slider
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_613ff0da()
{
}

