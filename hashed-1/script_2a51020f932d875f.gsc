// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_6c7faa2c;

/*
	Name: function_89f2df9
	Namespace: namespace_6c7faa2c
	Checksum: 0xFB9322E4
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_213b12187e93b144", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6c7faa2c
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
	Namespace: namespace_6c7faa2c
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
	Namespace: namespace_6c7faa2c
	Checksum: 0xE0601DE2
	Offset: 0x108
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_dfb8db6a()
{
	zm_perks::function_7f42e14e(#"hash_4262dc5dc4acb784", "mod_tortoise", #"hash_2d1dfb82ebcbdb7d", #"specialty_shield", 3500);
	zm_perks::register_perk_threads(#"hash_4262dc5dc4acb784", &function_f2b55850, &function_844bdb66);
}

/*
	Name: function_f2b55850
	Namespace: namespace_6c7faa2c
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
	Namespace: namespace_6c7faa2c
	Checksum: 0x88998A54
	Offset: 0x1B8
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_844bdb66(b_pause, str_perk, str_result, var_bcd1c2ff)
{
}

