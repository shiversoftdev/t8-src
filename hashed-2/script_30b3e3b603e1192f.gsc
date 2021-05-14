// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_a061685d;

/*
	Name: function_89f2df9
	Namespace: namespace_a061685d
	Checksum: 0xF84F1CC4
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_79ec124ce8380088", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a061685d
	Checksum: 0xBD988DB1
	Offset: 0xD8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_ce65aae8();
}

/*
	Name: function_ce65aae8
	Namespace: namespace_a061685d
	Checksum: 0x4F306240
	Offset: 0xF8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_ce65aae8()
{
	zm_perks::register_perk_clientfields(#"hash_3e2f955cd85b5532", &registermelee_leader_guntookpain, &function_170260ee);
	zm_perks::register_perk_init_thread(#"hash_3e2f955cd85b5532", &function_c24062a0);
}

/*
	Name: function_c24062a0
	Namespace: namespace_a061685d
	Checksum: 0x80F724D1
	Offset: 0x178
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_c24062a0()
{
}

/*
	Name: registermelee_leader_guntookpain
	Namespace: namespace_a061685d
	Checksum: 0x80F724D1
	Offset: 0x188
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function registermelee_leader_guntookpain()
{
}

/*
	Name: function_170260ee
	Namespace: namespace_a061685d
	Checksum: 0x80F724D1
	Offset: 0x198
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_170260ee()
{
}

