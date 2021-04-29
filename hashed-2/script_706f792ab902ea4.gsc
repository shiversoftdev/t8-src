// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_eb4608d5;

/*
	Name: function_89f2df9
	Namespace: namespace_eb4608d5
	Checksum: 0xA0AD6E9B
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4ae02ae28a48d88b", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_eb4608d5
	Checksum: 0x6C6294F2
	Offset: 0xC0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_perks::register_perk_clientfields(#"hash_4c14ed37c4038671", &function_5eadb2fd, &function_fbae967f);
	zm_perks::register_perk_init_thread(#"hash_4c14ed37c4038671", &function_793d9032);
}

/*
	Name: function_793d9032
	Namespace: namespace_eb4608d5
	Checksum: 0x80F724D1
	Offset: 0x140
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_793d9032()
{
}

/*
	Name: function_5eadb2fd
	Namespace: namespace_eb4608d5
	Checksum: 0x80F724D1
	Offset: 0x150
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_5eadb2fd()
{
}

/*
	Name: function_fbae967f
	Namespace: namespace_eb4608d5
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_fbae967f()
{
}

