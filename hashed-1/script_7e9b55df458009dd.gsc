// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_4fc83677;

/*
	Name: function_89f2df9
	Namespace: namespace_4fc83677
	Checksum: 0xA75B5C5F
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_16f1bc78a3808406", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_4fc83677
	Checksum: 0x31905E07
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_7186a3aa();
}

/*
	Name: __main__
	Namespace: namespace_4fc83677
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
	Name: function_7186a3aa
	Namespace: namespace_4fc83677
	Checksum: 0x9D0D1C45
	Offset: 0x110
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_7186a3aa()
{
	zm_perks::function_7f42e14e(#"hash_48255a3b086a9bea", "mod_dying_wish", #"hash_e58ff2df5bfd9b3", #"hash_5b141f82a55645a9", 5000);
	zm_perks::register_perk_threads(#"hash_48255a3b086a9bea", &function_fb91d1a, &function_63f21c1e);
}

/*
	Name: function_fb91d1a
	Namespace: namespace_4fc83677
	Checksum: 0x80F724D1
	Offset: 0x1B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_fb91d1a()
{
}

/*
	Name: function_63f21c1e
	Namespace: namespace_4fc83677
	Checksum: 0x7DE5DA40
	Offset: 0x1C0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_63f21c1e(b_pause, str_perk, str_result, var_bcd1c2ff)
{
}

