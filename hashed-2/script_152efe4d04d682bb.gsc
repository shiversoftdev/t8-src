// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_4cd9c601;

/*
	Name: function_89f2df9
	Namespace: namespace_4cd9c601
	Checksum: 0xDA496598
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_567cc170fccd467c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_4cd9c601
	Checksum: 0x9C8B0D0C
	Offset: 0xD8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_c0deb38d();
}

/*
	Name: function_c0deb38d
	Namespace: namespace_4cd9c601
	Checksum: 0xAE4FA091
	Offset: 0xF8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_c0deb38d()
{
	zm_perks::register_perk_clientfields(#"hash_5266c7139f9acf56", &function_40cb6d31, &function_90e7d3be);
	zm_perks::register_perk_init_thread(#"hash_5266c7139f9acf56", &function_a850540);
}

/*
	Name: function_a850540
	Namespace: namespace_4cd9c601
	Checksum: 0x80F724D1
	Offset: 0x178
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_a850540()
{
}

/*
	Name: function_40cb6d31
	Namespace: namespace_4cd9c601
	Checksum: 0x80F724D1
	Offset: 0x188
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_40cb6d31()
{
}

/*
	Name: function_90e7d3be
	Namespace: namespace_4cd9c601
	Checksum: 0x80F724D1
	Offset: 0x198
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_90e7d3be()
{
}

