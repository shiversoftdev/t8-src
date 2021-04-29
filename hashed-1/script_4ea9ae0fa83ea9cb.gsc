// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_6c7faa2c;

/*
	Name: function_89f2df9
	Namespace: namespace_6c7faa2c
	Checksum: 0xFCF1E8D5
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_213b12187e93b144", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6c7faa2c
	Checksum: 0xA0773B11
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_dfb8db6a();
}

/*
	Name: function_dfb8db6a
	Namespace: namespace_6c7faa2c
	Checksum: 0xDCD94B0D
	Offset: 0xE0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_dfb8db6a()
{
	zm_perks::register_perk_clientfields(#"hash_4262dc5dc4acb784", &function_7e8d1b34, &function_de73ba5c);
	zm_perks::register_perk_init_thread(#"hash_4262dc5dc4acb784", &function_cdedb133);
}

/*
	Name: function_cdedb133
	Namespace: namespace_6c7faa2c
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_cdedb133()
{
}

/*
	Name: function_7e8d1b34
	Namespace: namespace_6c7faa2c
	Checksum: 0x80F724D1
	Offset: 0x170
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_7e8d1b34()
{
}

/*
	Name: function_de73ba5c
	Namespace: namespace_6c7faa2c
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_de73ba5c()
{
}

