// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_b1cc4bcc;

/*
	Name: function_89f2df9
	Namespace: namespace_b1cc4bcc
	Checksum: 0x35974477
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_487298a0fc9d4e82", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b1cc4bcc
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
	Namespace: namespace_b1cc4bcc
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
	Namespace: namespace_b1cc4bcc
	Checksum: 0xE37BDD93
	Offset: 0x108
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_7299c39e()
{
	zm_perks::function_7f42e14e(#"hash_301aaa36fae44a5c", "mod_cooldown", #"hash_69fcf7d746edeeaf", #"hash_37aa3a5919757781", 3500);
	zm_perks::register_perk_threads(#"hash_301aaa36fae44a5c", &function_8d51d9a8, &function_754453a);
}

/*
	Name: function_8d51d9a8
	Namespace: namespace_b1cc4bcc
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
	Namespace: namespace_b1cc4bcc
	Checksum: 0x868DB04E
	Offset: 0x1B8
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_754453a(b_pause, str_perk, str_result, n_slot)
{
}

