// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_e044deca;

/*
	Name: function_89f2df9
	Namespace: namespace_e044deca
	Checksum: 0xF5840C4C
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_5c6b0ba6c540d07d", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e044deca
	Checksum: 0x71DA80B7
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_8afdc221();
}

/*
	Name: function_8afdc221
	Namespace: namespace_e044deca
	Checksum: 0xEB6C82D8
	Offset: 0xE0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_8afdc221()
{
	zm_perks::register_perk_clientfields(#"hash_cd6e82bd4ce7abf", &function_46f52747, &function_d2d66071);
	zm_perks::register_perk_init_thread(#"hash_cd6e82bd4ce7abf", &function_e630abb2);
}

/*
	Name: function_e630abb2
	Namespace: namespace_e044deca
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_e630abb2()
{
}

/*
	Name: function_46f52747
	Namespace: namespace_e044deca
	Checksum: 0x80F724D1
	Offset: 0x170
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_46f52747()
{
}

/*
	Name: function_d2d66071
	Namespace: namespace_e044deca
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_d2d66071()
{
}

