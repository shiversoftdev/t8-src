// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_b1cc4bcc;

/*
	Name: function_89f2df9
	Namespace: namespace_b1cc4bcc
	Checksum: 0x6DF82521
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_487298a0fc9d4e82", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b1cc4bcc
	Checksum: 0x3C1936DC
	Offset: 0xC8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_7299c39e();
}

/*
	Name: function_7299c39e
	Namespace: namespace_b1cc4bcc
	Checksum: 0x709FE9A3
	Offset: 0xE8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_7299c39e()
{
	zm_perks::register_perk_clientfields(#"hash_301aaa36fae44a5c", &function_2e843bb7, &function_dbcec7de);
	zm_perks::register_perk_init_thread(#"hash_301aaa36fae44a5c", &function_d5042d74);
}

/*
	Name: function_d5042d74
	Namespace: namespace_b1cc4bcc
	Checksum: 0x80F724D1
	Offset: 0x168
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_d5042d74()
{
}

/*
	Name: function_2e843bb7
	Namespace: namespace_b1cc4bcc
	Checksum: 0x80F724D1
	Offset: 0x178
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_2e843bb7()
{
}

/*
	Name: function_dbcec7de
	Namespace: namespace_b1cc4bcc
	Checksum: 0x80F724D1
	Offset: 0x188
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_dbcec7de()
{
}

