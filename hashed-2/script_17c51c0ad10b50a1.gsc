// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_7052c664;

/*
	Name: function_89f2df9
	Namespace: namespace_7052c664
	Checksum: 0x295E85D9
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_468e2fc3567ab866", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_7052c664
	Checksum: 0x45EBEA44
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_a7cdda99();
}

/*
	Name: function_a7cdda99
	Namespace: namespace_7052c664
	Checksum: 0xE62DEBF6
	Offset: 0x100
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_a7cdda99()
{
	zm_perks::function_7f42e14e(#"hash_7036ce8dafbf1f81", "mod_ethereal_razor", #"hash_42c03eb685b6fe1b", #"hash_6da63d760c1788e2", 5500);
	zm_perks::register_perk_threads(#"hash_7036ce8dafbf1f81", &function_5b26f1e3, &function_98c3f271);
}

/*
	Name: function_5b26f1e3
	Namespace: namespace_7052c664
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_5b26f1e3()
{
}

/*
	Name: function_98c3f271
	Namespace: namespace_7052c664
	Checksum: 0x71902700
	Offset: 0x1B0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_98c3f271(b_pause, str_perk, str_result, var_bcd1c2ff)
{
}

