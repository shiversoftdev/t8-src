// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_baca3c7c;

/*
	Name: function_89f2df9
	Namespace: namespace_baca3c7c
	Checksum: 0xFCF3DE23
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1a1f89094851296e", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_baca3c7c
	Checksum: 0xD222562A
	Offset: 0x148
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_27473e44();
	zm_perks::function_f3c80d73("zombie_perk_bottle_bandolier", "zombie_perk_totem_bandolier");
}

/*
	Name: function_27473e44
	Namespace: namespace_baca3c7c
	Checksum: 0x638EB393
	Offset: 0x188
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_clientfields(#"specialty_extraammo", &function_12161a30, &function_b10a7225);
	zm_perks::register_perk_effects(#"specialty_extraammo", "sleight_light");
	zm_perks::register_perk_init_thread(#"specialty_extraammo", &init_perk);
	zm_perks::function_b60f4a9f(#"specialty_extraammo", #"hash_f19d451775e86", "zombie/fx8_perk_altar_symbol_ambient_bandolier", #"hash_1bdfb5736ad174a3");
}

/*
	Name: init_perk
	Namespace: namespace_baca3c7c
	Checksum: 0xBADB5247
	Offset: 0x278
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init_perk()
{
}

/*
	Name: function_12161a30
	Namespace: namespace_baca3c7c
	Checksum: 0x80F724D1
	Offset: 0x2A8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_12161a30()
{
}

/*
	Name: function_b10a7225
	Namespace: namespace_baca3c7c
	Checksum: 0x80F724D1
	Offset: 0x2B8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_b10a7225()
{
}

