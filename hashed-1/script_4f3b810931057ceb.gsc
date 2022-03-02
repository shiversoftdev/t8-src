// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_d25f3c2a;

/*
	Name: function_89f2df9
	Namespace: namespace_d25f3c2a
	Checksum: 0x8164EC46
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_7bb29f081ab9b5cc", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d25f3c2a
	Checksum: 0x20EF3EC7
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_perks::register_perk_clientfields(#"hash_14e2498426fadea3", &function_905840b3, &function_a3102f04);
	zm_perks::register_perk_init_thread(#"hash_14e2498426fadea3", &function_eb36b57e);
}

/*
	Name: function_eb36b57e
	Namespace: namespace_d25f3c2a
	Checksum: 0x80F724D1
	Offset: 0x148
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_eb36b57e()
{
}

/*
	Name: function_905840b3
	Namespace: namespace_d25f3c2a
	Checksum: 0x80F724D1
	Offset: 0x158
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_905840b3()
{
}

/*
	Name: function_a3102f04
	Namespace: namespace_d25f3c2a
	Checksum: 0x80F724D1
	Offset: 0x168
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_a3102f04()
{
}

