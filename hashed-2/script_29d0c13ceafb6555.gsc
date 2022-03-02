// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_b7d493c4;

/*
	Name: function_89f2df9
	Namespace: namespace_b7d493c4
	Checksum: 0xA5B41A2B
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_62d99633cc457fde", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b7d493c4
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
	Namespace: namespace_b7d493c4
	Checksum: 0x8DBA9A8E
	Offset: 0xE0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_bf3cfde4()
{
	zm_perks::register_perk_clientfields(#"hash_6ca140703a87cd09", &function_59383c4e, &function_613ff0da);
	zm_perks::register_perk_init_thread(#"hash_6ca140703a87cd09", &function_58cb6bff);
}

/*
	Name: function_58cb6bff
	Namespace: namespace_b7d493c4
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
	Namespace: namespace_b7d493c4
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
	Namespace: namespace_b7d493c4
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_613ff0da()
{
}

