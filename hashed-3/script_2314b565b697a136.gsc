// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_ec67ead4;

/*
	Name: function_89f2df9
	Namespace: namespace_ec67ead4
	Checksum: 0x33213F98
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_3266a9b8fa091d91", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ec67ead4
	Checksum: 0xCD04866A
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_e52f65ea();
}

/*
	Name: function_e52f65ea
	Namespace: namespace_ec67ead4
	Checksum: 0x4EBED977
	Offset: 0x100
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_e52f65ea()
{
	zm_perks::register_perk_clientfields(#"hash_300c4e868f92134b", &function_7252aedc, &function_8357e1f3);
	zm_perks::register_perk_init_thread(#"hash_300c4e868f92134b", &function_85402de1);
}

/*
	Name: function_85402de1
	Namespace: namespace_ec67ead4
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_85402de1()
{
}

/*
	Name: function_7252aedc
	Namespace: namespace_ec67ead4
	Checksum: 0x80F724D1
	Offset: 0x190
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_7252aedc()
{
}

/*
	Name: function_8357e1f3
	Namespace: namespace_ec67ead4
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_8357e1f3()
{
}

